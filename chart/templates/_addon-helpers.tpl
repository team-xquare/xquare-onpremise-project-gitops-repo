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
Generate addon resources based on tier
*/}}
{{- define "addon.resources" -}}
{{- $tier := .tier | default "x3.micro" }}
{{- if eq $tier "x3.micro" }}
requests:
  cpu: 100m
  memory: 512Mi
limits:  
  cpu: 500m
  memory: 1Gi
{{- else if eq $tier "x3.small" }}
requests:
  cpu: 500m
  memory: 1Gi  
limits:
  cpu: 1000m
  memory: 2Gi
{{- else if eq $tier "x3.medium" }}
requests:
  cpu: 1000m
  memory: 2Gi
limits:
  cpu: 2000m  
  memory: 4Gi
{{- else if eq $tier "x3.large" }}
requests:
  cpu: 2000m
  memory: 4Gi
limits:
  cpu: 4000m
  memory: 8Gi
{{- end }}
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