{{/*
athena.helper.name
Will generate a meaningful name
*/}}
{{- define "helper.name" }}
{{- if .context.Values.nameSuffix -}}
{{- printf "%s-%s" .name .context.Values.nameSuffix }}
{{- else -}}
{{- printf "%s" .name }}
{{- end -}}
{{- end -}}
