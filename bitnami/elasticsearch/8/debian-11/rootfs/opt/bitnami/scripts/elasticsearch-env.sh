#!/bin/bash
# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0
#
# Environment configuration for elasticsearch

# The values for all environment variables will be set in the below order of precedence
# 1. Custom environment variables defined below after Bitnami defaults
# 2. Constants defined in this file (environment variables with no default), i.e. BITNAMI_ROOT_DIR
# 3. Environment variables overridden via external files using *_FILE variables (see below)
# 4. Environment variables set externally (i.e. current Bash context/Dockerfile/userdata)

# Load logging library
# shellcheck disable=SC1090,SC1091
. /opt/bitnami/scripts/liblog.sh

export BITNAMI_ROOT_DIR="/opt/bitnami"
export BITNAMI_VOLUME_DIR="/bitnami"

# Logging configuration
export MODULE="${MODULE:-elasticsearch}"
export BITNAMI_DEBUG="${BITNAMI_DEBUG:-false}"

# By setting an environment variable matching *_FILE to a file path, the prefixed environment
# variable will be overridden with the value specified in that file
elasticsearch_env_vars=(
    ELASTICSEARCH_CERTS_DIR
    ELASTICSEARCH_DATA_DIR_LIST
    ELASTICSEARCH_BIND_ADDRESS
    ELASTICSEARCH_ADVERTISED_HOSTNAME
    ELASTICSEARCH_CLUSTER_HOSTS
    ELASTICSEARCH_CLUSTER_MASTER_HOSTS
    ELASTICSEARCH_CLUSTER_NAME
    ELASTICSEARCH_HEAP_SIZE
    ELASTICSEARCH_MAX_ALLOWED_MEMORY_PERCENTAGE
    ELASTICSEARCH_MAX_ALLOWED_MEMORY
    ELASTICSEARCH_MAX_TIMEOUT
    ELASTICSEARCH_LOCK_ALL_MEMORY
    ELASTICSEARCH_DISABLE_JVM_HEAP_DUMP
    ELASTICSEARCH_DISABLE_GC_LOGS
    ELASTICSEARCH_IS_DEDICATED_NODE
    ELASTICSEARCH_MINIMUM_MASTER_NODES
    ELASTICSEARCH_NODE_NAME
    ELASTICSEARCH_FS_SNAPSHOT_REPO_PATH
    ELASTICSEARCH_NODE_ROLES
    ELASTICSEARCH_PLUGINS
    ELASTICSEARCH_TRANSPORT_PORT_NUMBER
    ELASTICSEARCH_HTTP_PORT_NUMBER
    ELASTICSEARCH_ENABLE_SECURITY
    ELASTICSEARCH_PASSWORD
    ELASTICSEARCH_TLS_VERIFICATION_MODE
    ELASTICSEARCH_TLS_USE_PEM
    ELASTICSEARCH_KEYSTORE_PASSWORD
    ELASTICSEARCH_TRUSTSTORE_PASSWORD
    ELASTICSEARCH_KEY_PASSWORD
    ELASTICSEARCH_KEYSTORE_LOCATION
    ELASTICSEARCH_TRUSTSTORE_LOCATION
    ELASTICSEARCH_NODE_CERT_LOCATION
    ELASTICSEARCH_NODE_KEY_LOCATION
    ELASTICSEARCH_CA_CERT_LOCATION
    ELASTICSEARCH_SKIP_TRANSPORT_TLS
    ELASTICSEARCH_TRANSPORT_TLS_USE_PEM
    ELASTICSEARCH_TRANSPORT_TLS_KEYSTORE_PASSWORD
    ELASTICSEARCH_TRANSPORT_TLS_TRUSTSTORE_PASSWORD
    ELASTICSEARCH_TRANSPORT_TLS_KEY_PASSWORD
    ELASTICSEARCH_TRANSPORT_TLS_KEYSTORE_LOCATION
    ELASTICSEARCH_TRANSPORT_TLS_TRUSTSTORE_LOCATION
    ELASTICSEARCH_TRANSPORT_TLS_NODE_CERT_LOCATION
    ELASTICSEARCH_TRANSPORT_TLS_NODE_KEY_LOCATION
    ELASTICSEARCH_TRANSPORT_TLS_CA_CERT_LOCATION
    ELASTICSEARCH_ENABLE_REST_TLS
    ELASTICSEARCH_HTTP_TLS_USE_PEM
    ELASTICSEARCH_HTTP_TLS_KEYSTORE_PASSWORD
    ELASTICSEARCH_HTTP_TLS_TRUSTSTORE_PASSWORD
    ELASTICSEARCH_HTTP_TLS_KEY_PASSWORD
    ELASTICSEARCH_HTTP_TLS_KEYSTORE_LOCATION
    ELASTICSEARCH_HTTP_TLS_TRUSTSTORE_LOCATION
    ELASTICSEARCH_HTTP_TLS_NODE_CERT_LOCATION
    ELASTICSEARCH_HTTP_TLS_NODE_KEY_LOCATION
    ELASTICSEARCH_HTTP_TLS_CA_CERT_LOCATION
    ELASTICSEARCH_ENABLE_FIPS_MODE
    ELASTICSEARCH_KEYS
    ELASTICSEARCH_ACTION_DESTRUCTIVE_REQUIRES_NAME
    DB_MINIMUM_MANAGER_NODES
)
for env_var in "${elasticsearch_env_vars[@]}"; do
    file_env_var="${env_var}_FILE"
    if [[ -n "${!file_env_var:-}" ]]; then
        if [[ -r "${!file_env_var:-}" ]]; then
            export "${env_var}=$(< "${!file_env_var}")"
            unset "${file_env_var}"
        else
            warn "Skipping export of '${env_var}'. '${!file_env_var:-}' is not readable."
        fi
    fi
done
unset elasticsearch_env_vars
export DB_FLAVOR="elasticsearch"

# Paths
export ELASTICSEARCH_VOLUME_DIR="/bitnami/elasticsearch"
export DB_VOLUME_DIR="$ELASTICSEARCH_VOLUME_DIR"
export ELASTICSEARCH_BASE_DIR="/opt/bitnami/elasticsearch"
export DB_BASE_DIR="$ELASTICSEARCH_BASE_DIR"
export ELASTICSEARCH_CONF_DIR="${DB_BASE_DIR}/config"
export DB_CONF_DIR="$ELASTICSEARCH_CONF_DIR"
export ELASTICSEARCH_CERTS_DIR="${ELASTICSEARCH_CERTS_DIR:-${DB_CONF_DIR}/certs}"
export DB_CERTS_DIR="$ELASTICSEARCH_CERTS_DIR"
export ELASTICSEARCH_LOGS_DIR="${DB_BASE_DIR}/logs"
export DB_LOGS_DIR="$ELASTICSEARCH_LOGS_DIR"
export ELASTICSEARCH_PLUGINS_DIR="${DB_BASE_DIR}/plugins"
export DB_PLUGINS_DIR="$ELASTICSEARCH_PLUGINS_DIR"
export ELASTICSEARCH_DEFAULT_PLUGINS_DIR="${DB_BASE_DIR}/plugins.default"
export DB_DEFAULT_PLUGINS_DIR="$ELASTICSEARCH_DEFAULT_PLUGINS_DIR"
export ELASTICSEARCH_DATA_DIR="${DB_VOLUME_DIR}/data"
export DB_DATA_DIR="$ELASTICSEARCH_DATA_DIR"
export ELASTICSEARCH_DATA_DIR_LIST="${ELASTICSEARCH_DATA_DIR_LIST:-}"
export DB_DATA_DIR_LIST="$ELASTICSEARCH_DATA_DIR_LIST"
export ELASTICSEARCH_TMP_DIR="${DB_BASE_DIR}/tmp"
export DB_TMP_DIR="$ELASTICSEARCH_TMP_DIR"
export ELASTICSEARCH_BIN_DIR="${DB_BASE_DIR}/bin"
export DB_BIN_DIR="$ELASTICSEARCH_BIN_DIR"
export ELASTICSEARCH_MOUNTED_PLUGINS_DIR="${DB_VOLUME_DIR}/plugins"
export DB_MOUNTED_PLUGINS_DIR="$ELASTICSEARCH_MOUNTED_PLUGINS_DIR"
export ELASTICSEARCH_CONF_FILE="${DB_CONF_DIR}/elasticsearch.yml"
export DB_CONF_FILE="$ELASTICSEARCH_CONF_FILE"
export ELASTICSEARCH_LOG_FILE="${DB_LOGS_DIR}/elasticsearch.log"
export DB_LOG_FILE="$ELASTICSEARCH_LOG_FILE"
export ELASTICSEARCH_PID_FILE="${DB_TMP_DIR}/elasticsearch.pid"
export DB_PID_FILE="$ELASTICSEARCH_PID_FILE"
export ELASTICSEARCH_INITSCRIPTS_DIR="/docker-entrypoint-initdb.d"
export DB_INITSCRIPTS_DIR="$ELASTICSEARCH_INITSCRIPTS_DIR"
export PATH="${DB_BIN_DIR}:${BITNAMI_ROOT_DIR}/common/bin:$PATH"

# System users (when running with a privileged user)
export ELASTICSEARCH_DAEMON_USER="elasticsearch"
export DB_DAEMON_USER="$ELASTICSEARCH_DAEMON_USER"
export ELASTICSEARCH_DAEMON_GROUP="elasticsearch"
export DB_DAEMON_GROUP="$ELASTICSEARCH_DAEMON_GROUP"

# Elasticsearch configuration
export ELASTICSEARCH_BIND_ADDRESS="${ELASTICSEARCH_BIND_ADDRESS:-}"
export DB_BIND_ADDRESS="$ELASTICSEARCH_BIND_ADDRESS"
export ELASTICSEARCH_ADVERTISED_HOSTNAME="${ELASTICSEARCH_ADVERTISED_HOSTNAME:-}"
export DB_ADVERTISED_HOSTNAME="$ELASTICSEARCH_ADVERTISED_HOSTNAME"
export ELASTICSEARCH_CLUSTER_HOSTS="${ELASTICSEARCH_CLUSTER_HOSTS:-}"
export DB_CLUSTER_HOSTS="$ELASTICSEARCH_CLUSTER_HOSTS"
export ELASTICSEARCH_CLUSTER_MASTER_HOSTS="${ELASTICSEARCH_CLUSTER_MASTER_HOSTS:-}"
export DB_CLUSTER_MASTER_HOSTS="$ELASTICSEARCH_CLUSTER_MASTER_HOSTS"
export ELASTICSEARCH_CLUSTER_NAME="${ELASTICSEARCH_CLUSTER_NAME:-}"
export DB_CLUSTER_NAME="$ELASTICSEARCH_CLUSTER_NAME"
export ELASTICSEARCH_HEAP_SIZE="${ELASTICSEARCH_HEAP_SIZE:-1024m}"
export DB_HEAP_SIZE="$ELASTICSEARCH_HEAP_SIZE"
export ELASTICSEARCH_MAX_ALLOWED_MEMORY_PERCENTAGE="${ELASTICSEARCH_MAX_ALLOWED_MEMORY_PERCENTAGE:-100}"
export DB_MAX_ALLOWED_MEMORY_PERCENTAGE="$ELASTICSEARCH_MAX_ALLOWED_MEMORY_PERCENTAGE"
export ELASTICSEARCH_MAX_ALLOWED_MEMORY="${ELASTICSEARCH_MAX_ALLOWED_MEMORY:-}"
export DB_MAX_ALLOWED_MEMORY="$ELASTICSEARCH_MAX_ALLOWED_MEMORY"
export ELASTICSEARCH_MAX_TIMEOUT="${ELASTICSEARCH_MAX_TIMEOUT:-60}"
export DB_MAX_TIMEOUT="$ELASTICSEARCH_MAX_TIMEOUT"
export ELASTICSEARCH_LOCK_ALL_MEMORY="${ELASTICSEARCH_LOCK_ALL_MEMORY:-no}"
export DB_LOCK_ALL_MEMORY="$ELASTICSEARCH_LOCK_ALL_MEMORY"
export ELASTICSEARCH_DISABLE_JVM_HEAP_DUMP="${ELASTICSEARCH_DISABLE_JVM_HEAP_DUMP:-no}"
export DB_DISABLE_JVM_HEAP_DUMP="$ELASTICSEARCH_DISABLE_JVM_HEAP_DUMP"
export ELASTICSEARCH_DISABLE_GC_LOGS="${ELASTICSEARCH_DISABLE_GC_LOGS:-no}"
export DB_DISABLE_GC_LOGS="$ELASTICSEARCH_DISABLE_GC_LOGS"
export ELASTICSEARCH_IS_DEDICATED_NODE="${ELASTICSEARCH_IS_DEDICATED_NODE:-no}"
export DB_IS_DEDICATED_NODE="$ELASTICSEARCH_IS_DEDICATED_NODE"
ELASTICSEARCH_MINIMUM_MASTER_NODES="${ELASTICSEARCH_MINIMUM_MASTER_NODES:-"${DB_MINIMUM_MANAGER_NODES:-}"}"
export ELASTICSEARCH_MINIMUM_MASTER_NODES="${ELASTICSEARCH_MINIMUM_MASTER_NODES:-}"
export DB_MINIMUM_MASTER_NODES="$ELASTICSEARCH_MINIMUM_MASTER_NODES"
export ELASTICSEARCH_NODE_NAME="${ELASTICSEARCH_NODE_NAME:-}"
export DB_NODE_NAME="$ELASTICSEARCH_NODE_NAME"
export ELASTICSEARCH_FS_SNAPSHOT_REPO_PATH="${ELASTICSEARCH_FS_SNAPSHOT_REPO_PATH:-}"
export DB_FS_SNAPSHOT_REPO_PATH="$ELASTICSEARCH_FS_SNAPSHOT_REPO_PATH"
export ELASTICSEARCH_NODE_ROLES="${ELASTICSEARCH_NODE_ROLES:-}"
export DB_NODE_ROLES="$ELASTICSEARCH_NODE_ROLES"
export ELASTICSEARCH_PLUGINS="${ELASTICSEARCH_PLUGINS:-}"
export DB_PLUGINS="$ELASTICSEARCH_PLUGINS"
export ELASTICSEARCH_TRANSPORT_PORT_NUMBER="${ELASTICSEARCH_TRANSPORT_PORT_NUMBER:-9300}"
export DB_TRANSPORT_PORT_NUMBER="$ELASTICSEARCH_TRANSPORT_PORT_NUMBER"
export ELASTICSEARCH_HTTP_PORT_NUMBER="${ELASTICSEARCH_HTTP_PORT_NUMBER:-9200}"
export DB_HTTP_PORT_NUMBER="$ELASTICSEARCH_HTTP_PORT_NUMBER"

# Elasticsearch Security configuration
export ELASTICSEARCH_ENABLE_SECURITY="${ELASTICSEARCH_ENABLE_SECURITY:-false}"
export DB_ENABLE_SECURITY="$ELASTICSEARCH_ENABLE_SECURITY"
export ELASTICSEARCH_PASSWORD="${ELASTICSEARCH_PASSWORD:-bitnami}"
export DB_PASSWORD="$ELASTICSEARCH_PASSWORD"
export ELASTICSEARCH_USERNAME="elastic"
export DB_USERNAME="$ELASTICSEARCH_USERNAME"
export ELASTICSEARCH_TLS_VERIFICATION_MODE="${ELASTICSEARCH_TLS_VERIFICATION_MODE:-full}"
export DB_TLS_VERIFICATION_MODE="$ELASTICSEARCH_TLS_VERIFICATION_MODE"
export ELASTICSEARCH_TLS_USE_PEM="${ELASTICSEARCH_TLS_USE_PEM:-false}"
export DB_TLS_USE_PEM="$ELASTICSEARCH_TLS_USE_PEM"
export ELASTICSEARCH_KEYSTORE_PASSWORD="${ELASTICSEARCH_KEYSTORE_PASSWORD:-}"
export DB_KEYSTORE_PASSWORD="$ELASTICSEARCH_KEYSTORE_PASSWORD"
export ELASTICSEARCH_TRUSTSTORE_PASSWORD="${ELASTICSEARCH_TRUSTSTORE_PASSWORD:-}"
export DB_TRUSTSTORE_PASSWORD="$ELASTICSEARCH_TRUSTSTORE_PASSWORD"
export ELASTICSEARCH_KEY_PASSWORD="${ELASTICSEARCH_KEY_PASSWORD:-}"
export DB_KEY_PASSWORD="$ELASTICSEARCH_KEY_PASSWORD"
export ELASTICSEARCH_KEYSTORE_LOCATION="${ELASTICSEARCH_KEYSTORE_LOCATION:-${DB_CERTS_DIR}/elasticsearch.keystore.jks}"
export DB_KEYSTORE_LOCATION="$ELASTICSEARCH_KEYSTORE_LOCATION"
export ELASTICSEARCH_TRUSTSTORE_LOCATION="${ELASTICSEARCH_TRUSTSTORE_LOCATION:-${DB_CERTS_DIR}/elasticsearch.truststore.jks}"
export DB_TRUSTSTORE_LOCATION="$ELASTICSEARCH_TRUSTSTORE_LOCATION"
export ELASTICSEARCH_NODE_CERT_LOCATION="${ELASTICSEARCH_NODE_CERT_LOCATION:-${DB_CERTS_DIR}/tls.crt}"
export DB_NODE_CERT_LOCATION="$ELASTICSEARCH_NODE_CERT_LOCATION"
export ELASTICSEARCH_NODE_KEY_LOCATION="${ELASTICSEARCH_NODE_KEY_LOCATION:-${DB_CERTS_DIR}/tls.key}"
export DB_NODE_KEY_LOCATION="$ELASTICSEARCH_NODE_KEY_LOCATION"
export ELASTICSEARCH_CA_CERT_LOCATION="${ELASTICSEARCH_CA_CERT_LOCATION:-${DB_CERTS_DIR}/ca.crt}"
export DB_CA_CERT_LOCATION="$ELASTICSEARCH_CA_CERT_LOCATION"
export ELASTICSEARCH_SKIP_TRANSPORT_TLS="${ELASTICSEARCH_SKIP_TRANSPORT_TLS:-false}"
export DB_SKIP_TRANSPORT_TLS="$ELASTICSEARCH_SKIP_TRANSPORT_TLS"
export ELASTICSEARCH_TRANSPORT_TLS_USE_PEM="${ELASTICSEARCH_TRANSPORT_TLS_USE_PEM:-$DB_TLS_USE_PEM}"
export DB_TRANSPORT_TLS_USE_PEM="$ELASTICSEARCH_TRANSPORT_TLS_USE_PEM"
export ELASTICSEARCH_TRANSPORT_TLS_KEYSTORE_PASSWORD="${ELASTICSEARCH_TRANSPORT_TLS_KEYSTORE_PASSWORD:-$DB_KEYSTORE_PASSWORD}"
export DB_TRANSPORT_TLS_KEYSTORE_PASSWORD="$ELASTICSEARCH_TRANSPORT_TLS_KEYSTORE_PASSWORD"
export ELASTICSEARCH_TRANSPORT_TLS_TRUSTSTORE_PASSWORD="${ELASTICSEARCH_TRANSPORT_TLS_TRUSTSTORE_PASSWORD:-$DB_TRUSTSTORE_PASSWORD}"
export DB_TRANSPORT_TLS_TRUSTSTORE_PASSWORD="$ELASTICSEARCH_TRANSPORT_TLS_TRUSTSTORE_PASSWORD"
export ELASTICSEARCH_TRANSPORT_TLS_KEY_PASSWORD="${ELASTICSEARCH_TRANSPORT_TLS_KEY_PASSWORD:-$DB_KEY_PASSWORD}"
export DB_TRANSPORT_TLS_KEY_PASSWORD="$ELASTICSEARCH_TRANSPORT_TLS_KEY_PASSWORD"
export ELASTICSEARCH_TRANSPORT_TLS_KEYSTORE_LOCATION="${ELASTICSEARCH_TRANSPORT_TLS_KEYSTORE_LOCATION:-$DB_KEYSTORE_LOCATION}"
export DB_TRANSPORT_TLS_KEYSTORE_LOCATION="$ELASTICSEARCH_TRANSPORT_TLS_KEYSTORE_LOCATION"
export ELASTICSEARCH_TRANSPORT_TLS_TRUSTSTORE_LOCATION="${ELASTICSEARCH_TRANSPORT_TLS_TRUSTSTORE_LOCATION:-$DB_TRUSTSTORE_LOCATION}"
export DB_TRANSPORT_TLS_TRUSTSTORE_LOCATION="$ELASTICSEARCH_TRANSPORT_TLS_TRUSTSTORE_LOCATION"
export ELASTICSEARCH_TRANSPORT_TLS_NODE_CERT_LOCATION="${ELASTICSEARCH_TRANSPORT_TLS_NODE_CERT_LOCATION:-$DB_NODE_CERT_LOCATION}"
export DB_TRANSPORT_TLS_NODE_CERT_LOCATION="$ELASTICSEARCH_TRANSPORT_TLS_NODE_CERT_LOCATION"
export ELASTICSEARCH_TRANSPORT_TLS_NODE_KEY_LOCATION="${ELASTICSEARCH_TRANSPORT_TLS_NODE_KEY_LOCATION:-$DB_NODE_KEY_LOCATION}"
export DB_TRANSPORT_TLS_NODE_KEY_LOCATION="$ELASTICSEARCH_TRANSPORT_TLS_NODE_KEY_LOCATION"
export ELASTICSEARCH_TRANSPORT_TLS_CA_CERT_LOCATION="${ELASTICSEARCH_TRANSPORT_TLS_CA_CERT_LOCATION:-$DB_CA_CERT_LOCATION}"
export DB_TRANSPORT_TLS_CA_CERT_LOCATION="$ELASTICSEARCH_TRANSPORT_TLS_CA_CERT_LOCATION"
export ELASTICSEARCH_ENABLE_REST_TLS="${ELASTICSEARCH_ENABLE_REST_TLS:-true}"
export DB_ENABLE_REST_TLS="$ELASTICSEARCH_ENABLE_REST_TLS"
export ELASTICSEARCH_HTTP_TLS_USE_PEM="${ELASTICSEARCH_HTTP_TLS_USE_PEM:-$DB_TLS_USE_PEM}"
export DB_HTTP_TLS_USE_PEM="$ELASTICSEARCH_HTTP_TLS_USE_PEM"
export ELASTICSEARCH_HTTP_TLS_KEYSTORE_PASSWORD="${ELASTICSEARCH_HTTP_TLS_KEYSTORE_PASSWORD:-$DB_KEYSTORE_PASSWORD}"
export DB_HTTP_TLS_KEYSTORE_PASSWORD="$ELASTICSEARCH_HTTP_TLS_KEYSTORE_PASSWORD"
export ELASTICSEARCH_HTTP_TLS_TRUSTSTORE_PASSWORD="${ELASTICSEARCH_HTTP_TLS_TRUSTSTORE_PASSWORD:-$DB_TRUSTSTORE_PASSWORD}"
export DB_HTTP_TLS_TRUSTSTORE_PASSWORD="$ELASTICSEARCH_HTTP_TLS_TRUSTSTORE_PASSWORD"
export ELASTICSEARCH_HTTP_TLS_KEY_PASSWORD="${ELASTICSEARCH_HTTP_TLS_KEY_PASSWORD:-$DB_KEY_PASSWORD}"
export DB_HTTP_TLS_KEY_PASSWORD="$ELASTICSEARCH_HTTP_TLS_KEY_PASSWORD"
export ELASTICSEARCH_HTTP_TLS_KEYSTORE_LOCATION="${ELASTICSEARCH_HTTP_TLS_KEYSTORE_LOCATION:-$DB_KEYSTORE_LOCATION}"
export DB_HTTP_TLS_KEYSTORE_LOCATION="$ELASTICSEARCH_HTTP_TLS_KEYSTORE_LOCATION"
export ELASTICSEARCH_HTTP_TLS_TRUSTSTORE_LOCATION="${ELASTICSEARCH_HTTP_TLS_TRUSTSTORE_LOCATION:-$DB_TRUSTSTORE_LOCATION}"
export DB_HTTP_TLS_TRUSTSTORE_LOCATION="$ELASTICSEARCH_HTTP_TLS_TRUSTSTORE_LOCATION"
export ELASTICSEARCH_HTTP_TLS_NODE_CERT_LOCATION="${ELASTICSEARCH_HTTP_TLS_NODE_CERT_LOCATION:-$DB_NODE_CERT_LOCATION}"
export DB_HTTP_TLS_NODE_CERT_LOCATION="$ELASTICSEARCH_HTTP_TLS_NODE_CERT_LOCATION"
export ELASTICSEARCH_HTTP_TLS_NODE_KEY_LOCATION="${ELASTICSEARCH_HTTP_TLS_NODE_KEY_LOCATION:-$DB_NODE_KEY_LOCATION}"
export DB_HTTP_TLS_NODE_KEY_LOCATION="$ELASTICSEARCH_HTTP_TLS_NODE_KEY_LOCATION"
export ELASTICSEARCH_HTTP_TLS_CA_CERT_LOCATION="${ELASTICSEARCH_HTTP_TLS_CA_CERT_LOCATION:-$DB_CA_CERT_LOCATION}"
export DB_HTTP_TLS_CA_CERT_LOCATION="$ELASTICSEARCH_HTTP_TLS_CA_CERT_LOCATION"
export ELASTICSEARCH_ENABLE_FIPS_MODE="${ELASTICSEARCH_ENABLE_FIPS_MODE:-false}"
export ELASTICSEARCH_KEYS="${ELASTICSEARCH_KEYS:-}"
export ELASTICSEARCH_ACTION_DESTRUCTIVE_REQUIRES_NAME="${ELASTICSEARCH_ACTION_DESTRUCTIVE_REQUIRES_NAME:-}"
export DB_ACTION_DESTRUCTIVE_REQUIRES_NAME="$ELASTICSEARCH_ACTION_DESTRUCTIVE_REQUIRES_NAME"

# Custom environment variables may be defined below
