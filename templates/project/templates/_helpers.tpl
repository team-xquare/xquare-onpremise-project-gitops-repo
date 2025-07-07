{{/*
Project namespace pattern
*/}}
{{- define "project.namespace" -}}
{{ .Values.project }}-dsm-project
{{- end }}

{{/*
Common labels
*/}}
{{- define "project.labels" -}}
app.kubernetes.io/name: {{ .Values.project }}
app.kubernetes.io/instance: {{ .Values.project }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .Chart.AppVersion | default .Chart.Version }}
app.kubernetes.io/component: project
helm.sh/chart: {{ printf "%s-%s" .Chart.Name (.Chart.Version | replace "+" "_") }}
{{- end }}

{{/*
Harbor registry URL
*/}}
{{- define "project.harborRegistry" -}}
harbor-xquare-infra.dsmhs.kr
{{- end }}

{{/*
Vault service account name
*/}}
{{- define "project.vaultServiceAccount" -}}
{{ .Values.project }}-dsm-project-vault-service-account
{{- end }}

{{/*
Vault auth name
*/}}
{{- define "project.vaultAuth" -}}
{{ .Values.project }}-dsm-project-vault-auth
{{- end }}

{{/*
Application-specific helpers
*/}}
{{- define "app.serviceName" -}}
{{ .name }}
{{- end }}

{{- define "app.labels" -}}
app.kubernetes.io/name: {{ .name }}
app.kubernetes.io/instance: {{ .name }}
app.kubernetes.io/managed-by: {{ $.Release.Service }}
app.kubernetes.io/version: {{ $.Chart.AppVersion | default $.Chart.Version }}
helm.sh/chart: {{ printf "%s-%s" $.Chart.Name ($.Chart.Version | replace "+" "_") }}
{{- end }}

{{- define "app.selectorLabels" -}}
app.kubernetes.io/name: {{ .name }}
app.kubernetes.io/instance: {{ .name }}
{{- end }}

{{- define "app.image" -}}
{{ include "project.harborRegistry" $ }}/xquare/{{ include "project.namespace" $ }}-{{ .name }}:{{ .imageTag | default "latest" }}
{{- end }}

{{- define "app.vaultSecretName" -}}
{{ $.Values.project }}-{{ .name }}
{{- end }}

{{- define "app.vaultAuthRef" -}}
{{ include "project.namespace" $ }}/{{ include "project.vaultAuth" $ }}
{{- end }}

{{/*
CI-specific helpers
*/}}
{{- define "ci.githubAppID" -}}
1172114
{{- end }}

{{- define "ci.webhookHost" -}}
argo-events-xquare-infra.dsmhs.kr
{{- end }}

{{- define "ci.gitopsRepo" -}}
team-xquare/xquare-onpremise-project-gitops-repo
{{- end }}

{{- define "ci.webhookPort" -}}
12000
{{- end }}

{{- define "ci.eventSourceServiceName" -}}
{{ .name }}-github-webhook-eventsource-svc
{{- end }}

{{- define "ci.githubFullname" -}}
{{- .name | replace "-" "_" | lower }}
{{- end }}