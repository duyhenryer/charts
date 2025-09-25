{{/*
Expand the name of the chart.
*/}}
{{- define "karpenter-nodepool.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "karpenter-nodepool.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "karpenter-nodepool.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels for EC2NodeClass (still uses standard Helm labels)
*/}}
{{- define "karpenter-nodepool.labels" -}}
helm.sh/chart: {{ include "karpenter-nodepool.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Safe labels for NodePool resource metadata (v1.5.x compatible)
These labels go on NodePool metadata.labels and also cannot use restricted domains in v1.5.x
*/}}
{{- define "nodepool.labels" -}}
helm.sh/chart: {{ include "karpenter-nodepool.chart" . }}
{{- if .Values.globalLabels }}
{{- range $key, $value := .Values.globalLabels }}
{{- if not (or (hasPrefix "kubernetes.io/" $key) (hasPrefix "karpenter.sh/" $key) (hasPrefix "karpenter.k8s.aws/" $key) (hasPrefix "app.kubernetes.io/" $key)) }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Safe labels for NodePool node template (excludes ALL restricted domains)
These labels go on spec.template.metadata.labels and CANNOT use:
- kubernetes.io (reserved by Kubernetes) 
- karpenter.sh (reserved by Karpenter)  
- karpenter.k8s.aws (reserved by Karpenter AWS provider)
- app.kubernetes.io (Kubernetes app labels)
Note: Only custom domain labels are allowed here
*/}}
{{- define "nodepool.nodeLabels" -}}
{{- if .Values.globalLabels }}
{{- range $key, $value := .Values.globalLabels }}
{{- if not (or (hasPrefix "kubernetes.io/" $key) (hasPrefix "karpenter.sh/" $key) (hasPrefix "karpenter.k8s.aws/" $key) (hasPrefix "app.kubernetes.io/" $key)) }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels for EC2NodeClass resources
*/}}
{{- define "labels" -}}
{{- include "karpenter-nodepool.labels" . }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "annotations" -}}
{{- if .Values.globalAnnotations }}
{{- toYaml .Values.globalAnnotations }}
{{- end }}
{{- end }}

{{/*
Common selector terms for EC2NodeClass resources
*/}}
{{- define "ec2NodeClass.commonSelectorTerms" -}}
{{- if kindIs "slice" . }}
{{- toYaml . | nindent 4 }}
{{- else }}
{{- toYaml (list .) | nindent 4 }}
{{- end }}
{{- end }}
