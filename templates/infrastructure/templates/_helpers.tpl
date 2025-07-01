{{- define "infrastructure.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "infrastructure.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" .Values.project $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "infrastructure.namespace" -}}
{{- .Values.project }}
{{- end }}

{{- define "infrastructure.namespaces" -}}
{{- $namespaces := list }}
{{- if .Values.environments.stag }}
{{- $namespaces = append $namespaces (printf "%s-stag" .Values.project) }}
{{- end }}
{{- if .Values.environments.prod }}
{{- $namespaces = append $namespaces (printf "%s-prod" .Values.project) }}
{{- end }}
{{- join "," $namespaces }}
{{- end }}
