{{/*
Addon helpers
*/}}

{{/*
Generate addon name
*/}}
{{- define "addon.name" -}}
{{- .name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Generate addon labels
*/}}
{{- define "addon.labels" -}}
addon.xquare.io/name: {{ include "addon.name" . | quote }}
addon.xquare.io/type: {{ .type | quote }}
addon.xquare.io/tier: {{ .tier | quote }}
{{- end }}

{{/*
Generate addon selector labels  
*/}}
{{- define "addon.selectorLabels" -}}
addon.xquare.io/name: {{ include "addon.name" . | quote }}
addon.xquare.io/type: {{ .type | quote }}
{{- end }}

{{/*
Generate addon service name
*/}}
{{- define "addon.serviceName" -}}
{{ include "addon.name" . }}
{{- end }}

{{/*
Generate addon database name (same as addon name)
*/}}
{{- define "addon.databaseName" -}}
{{ include "addon.name" . | replace "-" "_" }}
{{- end }}

{{/*
Generate addon password (same as addon name)
*/}}
{{- define "addon.password" -}}
{{ include "addon.name" . }}
{{- end }}