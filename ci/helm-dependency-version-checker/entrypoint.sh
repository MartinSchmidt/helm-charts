#!/bin/bash -l

 updateDependencyVersion() {
    NAME=$1
    OLDVERSION=$2
    NEWVERSION=$3

    # Get everything in the Chart.yaml up until and including the dependency name
    UPTODEPENDENCYNAME=$(sed "/- name: $NAME/q" Chart.yaml)
    # Get the repository and version lines
    REPOANDVERSION=$(grep "\- name: $NAME" Chart.yaml -A 2 | tail -n +2)
    # Get the remaning part of the Chart.yaml file
    REMAINING=$(grep "\- name: $NAME" Chart.yaml -A 100 | tail -n +4)
    # Replace the old version with the new one in $REPOANDVERSION
    NEWVERSIONWITHREPO="${REPOANDVERSION//"$OLDVERSION"/"$NEWVERSION"}"
    # Put together the 3 pieces of Chart.yaml again
    NEWCHARTYAML="${UPTODEPENDENCYNAME}"$'\n'"${NEWVERSIONWITHREPO}"$'\n'"${REMAINING}"
    echo "$NEWCHARTYAML" > Chart.yaml
}

updateChartVersion() {
    # Get the current version from the chart
    VERSION=$(yq e '.version' Chart.yaml)
    # Get the minor version from the version
    MINORVERSION=$(grep -m 1 -Eo '[v]?[0-9]+\.[0-9]+\.[0-9]+' Chart.yaml | grep -Eo '[0-9]+$')
    # Increment minorversion
    NEWMINORVERSION=$((MINORVERSION+1))
    # Cut the version so the minor version is removed
    CUTVERSION=${VERSION%[0-9]*}
    # Put together the cut version and the new minor version
    NEWVERSION="${CUTVERSION}${NEWMINORVERSION}"
    # Replace the old version with the new one in Chart.yaml
    newversion=$NEWVERSION yq e -i '.version = env(newversion)' Chart.yaml
}


# Find the dependencies of the Helm chart
DEPENDENCIES=$(helm dependency list .)
CHARTVERSIONCHANGED=false
DEPENDENCIESCHANGED=0

echo "$DEPENDENCIES" | while IFS= read -r line ; do 

    STRING=$line
    echo "$STRING" > string.txt
    TOPLINE=$(grep "STATUS" string.txt)

    if [ -z "$TOPLINE" ] && [ "$STRING" != "WARNING: no dependencies at charts" ]
    then
        # Get the name, version and URL for the current dependency
        NAME="$(awk '{print $1}' <<< "$STRING")"
        echo "::set-output name=name::$NAME"
        VERSION="$(awk '{print $2}' <<< "$STRING")"
        echo "::set-output name=version::$VERSION"
        URL="$(awk '{print $3}' <<< "$STRING")"

        # Append index.yaml depending if there is a trailing slash or not
        TRAILINGSLASH=$(echo "$URL" | grep -m 1 -Eo '[/]$')
        if [ -z "$TRAILINGSLASH" ] 
        then
            INDEXURL="$URL/index.yaml"
        else
            INDEXURL="${URL}index.yaml"
        fi
        echo "Dependency name is:               ${NAME}"
        echo "Current dependency version is:    ${VERSION}"
        
        # Get the index.yaml file and store it
        curl -s "$INDEXURL" > index.yaml
        
        # Get the highest version and source from the index.yaml file
        VERSIONSTRING=".entries.${NAME}[0].version"
        HIGHESTVERSION=$(yq e "$VERSIONSTRING" index.yaml)
        SOURCESTRING=".entries.${NAME}[0].sources"
        SOURCE=$(yq e "$SOURCESTRING" index.yaml)
        SOURCE=${SOURCE#[- ]}
        echo "::set-output name=url::$SOURCE"
        echo "::set-output name=highestversion::$HIGHESTVERSION"
        echo "Deleting temporary files..."
        
        # Remove old files
        rm index.yaml string.txt
        echo "Highest found version is: "
        echo "$HIGHESTVERSION"

        # If the highest version is different to the one in the dependency
        if [ "$VERSION" != "$HIGHESTVERSION" ] && [ "$HIGHESTVERSION" != "" ]; then
            DEPENDENCIESCHANGED=$((DEPENDENCIESCHANGED+1))
            echo "A new version was found, creating pull request..."
            updateDependencyVersion "$NAME" "$VERSION" "$HIGHESTVERSION"
            if [ $CHARTVERSIONCHANGED = false ] ; then
                updateChartVersion
                CHARTVERSIONCHANGED=true
            fi
        else
            echo "No new version found"
        fi
        printf "\n"
    fi
    echo "::set-output name=dependencies-changed::$DEPENDENCIESCHANGED"
done
