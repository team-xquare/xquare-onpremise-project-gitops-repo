{{/*
Project namespace pattern
*/}}
{{- define "project.namespace" -}}
{{ .Values.project | default "xquare" }}-dsm-project
{{- end }}

{{/*
Common labels
*/}}
{{- define "project.labels" -}}
app.kubernetes.io/name: {{ .Values.project | default "xquare" | quote }}
app.kubernetes.io/instance: {{ .Values.project | default "xquare" | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .Chart.AppVersion | default .Chart.Version | quote }}
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
{{ .Values.project | default "xquare" }}-dsm-project-vault-service-account
{{- end }}

{{/*
Vault auth name
*/}}
{{- define "project.vaultAuth" -}}
{{ .Values.project | default "xquare" }}-dsm-project-vault-auth
{{- end }}

{{/*
Application-specific helpers
*/}}
{{- define "app.serviceName" -}}
{{ .name }}
{{- end }}

{{- define "app.labels" -}}
app.kubernetes.io/name: {{ .name | quote }}
app.kubernetes.io/instance: {{ .name | quote }}
app.kubernetes.io/managed-by: Helm
app.kubernetes.io/version: "1.0.0"
helm.sh/chart: project-1.0.0
{{- end }}

{{- define "app.selectorLabels" -}}
app.kubernetes.io/name: {{ .name | quote }}
app.kubernetes.io/instance: {{ .name | quote }}
{{- end }}

{{- define "app.image" -}}
{{ .harborRegistry }}/xquare/{{ .projectNamespace }}-{{ .name }}:{{ .imageTag | default "latest" }}
{{- end }}

{{- define "app.vaultSecretName" -}}
{{ .project }}-{{ .name }}
{{- end }}

{{- define "app.vaultAuthRef" -}}
{{ .projectNamespace }}/{{ .vaultAuth }}
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

{{- define "ci.githubInstallationID" -}}
{{- .githubInstallationID | int }}
{{- end }}