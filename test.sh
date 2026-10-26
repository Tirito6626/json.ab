#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: nightly-65-g7090046

if [ -n "$ZSH_VERSION" ]; then
    __exec_shell_version="$ZSH_VERSION"
    IFS='.' read -r __exec_v1 __exec_v2 __exec_v3 <<< "${__exec_shell_version}"
    set -A EXEC_SHELL_VERSION -- "${__exec_v1:-0}" "${__exec_v2:-0}" "${__exec_v3:-0}"
elif [ -n "$KSH_VERSION" ]; then
    __exec_shell_version="${KSH_VERSION#Version }"
    __exec_shell_version="${__exec_shell_version#* }"
    __exec_shell_version="${__exec_shell_version%% *}"
    __exec_v1="${__exec_shell_version%%[!0-9]*}"
    __exec_v2=0
    __exec_v3=0
    set -A EXEC_SHELL_VERSION -- "${__exec_v1:-0}" "${__exec_v2:-0}" "${__exec_v3:-0}"
else
    EXEC_SHELL_VERSION=("${BASH_VERSINFO[0]}" "${BASH_VERSINFO[1]}" "${BASH_VERSINFO[2]}")
fi
# replace(source: Text, search: Text, replace: Text)
replace__0_v0() {
    local source_162="${1}"
    : "${source_162}"
    local search_163="${2}"
    : "${search_163}"
    local replace_164="${3}"
    : "${replace_164}"
    # Here we use a command to avoid #646
    local result_165=""
    left_comp=("${EXEC_SHELL_VERSION[@]}")
    right_comp=(4 3)
    local comp
    comp="$(
        # Compare if left array >= right array
        len_comp="$( (( "${#left_comp[@]}" < "${#right_comp[@]}" )) && echo "${#left_comp[@]}"|| echo "${#right_comp[@]}")"
        for (( i=0; i<len_comp; i++ )); do
            left="${left_comp[i]?"Index out of bounds (at unknown)"}"
            right="${right_comp[i]?"Index out of bounds (at unknown)"}"
            if (( left > right )); then
                echo 1
                exit
            elif (( left < right )); then
                echo 0
                exit
            fi
        done
        (( "${#left_comp[@]}" == "${#right_comp[@]}" || "${#left_comp[@]}" > "${#right_comp[@]}" )) && echo 1 || echo 0
)"
    if { false || { true && [[ "${comp}" != 0 ]]; }; }; then
        result_165="${source_162//"${search_163}"/"${replace_164}"}" && __status=0 || __status=$?
    else
        result_165="${source_162//"${search_163}"/${replace_164}}" && __status=0 || __status=$?
    fi
    ret_replace0_v0="${result_165}"
    return 0
}

# replace_one(source: Text, search: Text, replace: Text)
replace_one__1_v0() {
    local source_170="${1}"
    : "${source_170}"
    local search_171="${2}"
    : "${search_171}"
    local replace_172="${3}"
    : "${replace_172}"
    # Here we use a command to avoid #646
    local result_173=""
    left_comp=("${EXEC_SHELL_VERSION[@]}")
    right_comp=(4 3)
    local comp
    comp="$(
        # Compare if left array >= right array
        len_comp="$( (( "${#left_comp[@]}" < "${#right_comp[@]}" )) && echo "${#left_comp[@]}"|| echo "${#right_comp[@]}")"
        for (( i=0; i<len_comp; i++ )); do
            left="${left_comp[i]?"Index out of bounds (at unknown)"}"
            right="${right_comp[i]?"Index out of bounds (at unknown)"}"
            if (( left > right )); then
                echo 1
                exit
            elif (( left < right )); then
                echo 0
                exit
            fi
        done
        (( "${#left_comp[@]}" == "${#right_comp[@]}" || "${#left_comp[@]}" > "${#right_comp[@]}" )) && echo 1 || echo 0
)"
    if { false || { true && [[ "${comp}" != 0 ]]; }; }; then
        result_173="${source_170/"${search_171}"/"${replace_172}"}" && __status=0 || __status=$?
    else
        result_173="${source_170/"${search_171}"/${replace_172}}" && __status=0 || __status=$?
    fi
    ret_replace_one1_v0="${result_173}"
    return 0
}

__SED_VERSION_UNKNOWN_0=0
__SED_VERSION_GNU_1=1
__SED_VERSION_BUSYBOX_2=2
# sed_version()
sed_version__2_v0() {
    # We can't match against a word "GNU" because
    # alpine's busybox sed returns "This is not GNU sed version"
    re='Copyright.+Free Software Foundation'; [[ $(command sed --version 2>/dev/null) =~ $re ]] && __status=0 || __status=$?
    if (( __status == 0 )); then
        ret_sed_version2_v0="${__SED_VERSION_GNU_1}"
        return 0
    fi
    # On BSD single `sed` waits for stdin. We must use `sed --help` to avoid this.
    re='BusyBox'; [[ $(command sed --help 2>&1) =~ $re ]] && __status=0 || __status=$?
    if (( __status == 0 )); then
        ret_sed_version2_v0="${__SED_VERSION_BUSYBOX_2}"
        return 0
    fi
    ret_sed_version2_v0="${__SED_VERSION_UNKNOWN_0}"
    return 0
}

# split(text: Text, delimiter: Text)
split__4_v0() {
    local text_175="${1}"
    : "${text_175}"
    local delimiter_176="${2}"
    local result_177=()
    # zsh uses -A for array, bash uses -a, ksh is VERY bad at splitting anything
        IFS="${delimiter_176}" read -rd '' -a result_177 < <(printf %s "$text_175") && __status=0 || __status=$?
    ret_split4_v0=("${result_177[@]}")
    return 0
}

# split_lines(text: Text)
split_lines__5_v0() {
    local text_174="${1}"
    split__4_v0 "${text_174}" "
"
    ret_split_lines5_v0=("${ret_split4_v0[@]}")
    return 0
}

# join(list: [Text], delimiter: Text)
join__7_v0() {
    local list_213=("${!1}")
    : "${list_213[@]}"
    local delimiter_214="${2}"
    local command_3
    command_3="$(IFS="${delimiter_214}" ; printf "%s
" "${list_213[*]}")"
    __status=$?
    ret_join7_v0="${command_3}"
    return 0
}

# parse_int(text: Text)
parse_int__13_v0() {
    local text_179="${1}"
    [ -n "${text_179}" ] && [ "${text_179}" -eq "${text_179}" ] 2>/dev/null && __status=0 || __status=$?
    if [ "${__status}" != 0 ]; then
        ret_parse_int13_v0=''
        return "${__status}"
    fi
    ret_parse_int13_v0="${text_179}"
    return 0
}

# match_regex(source: Text, search: Text, extended: Bool)
match_regex__19_v0() {
    local source_158="${1}"
    local search_159="${2}"
    local extended_160="${3}"
    sed_version__2_v0 
    local sed_version_161="${ret_sed_version2_v0}"
    replace__0_v0 "${search_159}" "/" "\\/"
    search_159="${ret_replace0_v0}"
    local output_166=""
    if { (( sed_version_161 == __SED_VERSION_GNU_1 )) || (( sed_version_161 == __SED_VERSION_BUSYBOX_2 )); }; then
        # '\b' is supported but not in POSIX standards. Disable it
        replace__0_v0 "${search_159}" "\\b" "\\\\b"
        search_159="${ret_replace0_v0}"
    fi
    if [[ ${extended_160} != 0 ]]; then
        # GNU sed versions 4.0 through 4.2 support extended regex syntax,
        # but only via the "-r" option
        if (( sed_version_161 == __SED_VERSION_GNU_1 )); then
            # '\b' is not in POSIX standards. Disable it
            replace__0_v0 "${search_159}" "\\b" "\\b"
            search_159="${ret_replace0_v0}"
            local command_4
            command_4="$(command sed -r -ne "/${search_159}/p" <<<"${source_158}")"
            __status=$?
            output_166="${command_4}"
        else
            local command_5
            command_5="$(command sed -E -ne "/${search_159}/p" <<<"${source_158}")"
            __status=$?
            output_166="${command_5}"
        fi
    else
        if { (( sed_version_161 == __SED_VERSION_GNU_1 )) || (( sed_version_161 == __SED_VERSION_BUSYBOX_2 )); }; then
            # GNU Sed BRE handle \| as a metacharacter, but it is not POSIX standands. Disable it
            replace__0_v0 "${search_159}" "\\|" "|"
            search_159="${ret_replace0_v0}"
        fi
        local command_6
        command_6="$(command sed -ne "/${search_159}/p" <<<"${source_158}")"
        __status=$?
        output_166="${command_6}"
    fi
    if [[ "${output_166}" != "" ]]; then
        ret_match_regex19_v0=1
        return 0
    fi
    ret_match_regex19_v0=0
    return 0
}

# is_command(command: Text)
is_command__128_v0() {
    local command_149="${1}"
    [ -x "$(command -v "${command_149}")" ] && __status=0 || __status=$?
    if [ "${__status}" != 0 ]; then
        ret_is_command128_v0=0
        return 0
    fi
    ret_is_command128_v0=1
    return 0
}

# printf(format: Text, args: [Text])
printf__134_v0() {
    local format_19="${1}"
    local args_20=("${!2}")
    : "${args_20[@]}"
    args_20=("${format_19}" "${args_20[@]}") && __status=0 || __status=$?
    command printf "${args_20[@]}" && __status=0 || __status=$?
}

# echo_error(message: Text, exit_code: Int)
echo_error__144_v0() {
    local message_17="${1}"
    local exit_code_18="${2}"
    local array_9=("${message_17}")
    : "${array_9[@]}"
    printf__134_v0 "\\x1b[1;3;97;41m%s\\x1b[0m
" "array_9"[@]
    if (( exit_code_18 > 0 )); then
        exit "${exit_code_18}"
    fi
}

# load_shelljq(path: Text)
load_shelljq__165_v0() {
    local path_16="${1}"
    source "${path_16}" && __status=0 || __status=$?
    if [ "${__status}" != 0 ]; then
        echo_error__144_v0 "Failed to load shelljq (${path_16})" 1
        return 1
    fi
}

# json_trim(input: Text, validate: Bool)
json_trim__166_v0() {
    local input_196="${1}"
    local validate_197="${2}"
    local result_198=""
    local __length_10="${input_196}"
    if (( ${#__length_10} == 0 )); then
        echo_error__144_v0 "No input provided" 1
    fi
    json_trim "${input_196}" "${validate_197}" true && __status=0 || __status=$?
    if [ "${__status}" != 0 ]; then
        echo "json_trim exited with error: $_shjq_error" && __status=0 || __status=$?
        ret_json_trim166_v0=''
        return 1
    fi
    result_198="$json_trim_output" && __status=0 || __status=$?
    ret_json_trim166_v0="${result_198}"
    return 0
}

# json_parser(input: Text, raw: Bool)
json_parser__167_v0() {
    local input_194="${1}"
    local raw_195="${2}"
    local __length_11="${input_194}"
    if (( ${#__length_11} == 0 )); then
        echo_error__144_v0 "No input provided" 1
    fi
    json_trim__166_v0 "${input_194}" 1
    __status=$?
    if [ "${__status}" != 0 ]; then
        return "${__status}"
    fi
    input_194="${ret_json_trim166_v0}"
    json_to_arr "${input_194}" "" "${raw_195}" && __status=0 || __status=$?
    if [ "${__status}" != 0 ]; then
        echo "json_to_arr exited with error: $_shjq_error" && __status=0 || __status=$?
        return 1
    fi
}

# json_multiquery(query: [Text], raw: Bool)
json_multiquery__169_v0() {
    local query_210=("${!1}")
    local raw_211="${2}"
    local result_212=()
    local __length_13=("${query_210[@]}")
    if (( ${#__length_13[@]} == 0 )); then
        echo_error__144_v0 "No query provided" 1
    fi
    join__7_v0 "query_210"[@] " "
    local ret_join7_v0__55_20="${ret_join7_v0}"
    json_query "${ret_join7_v0__55_20}" "${raw_211}" 1 && __status=0 || __status=$?
    if [ "${__status}" != 0 ]; then
        echo "json_query exited with error: $_shjq_error" && __status=0 || __status=$?
        ret_json_multiquery169_v0=()
        return 1
    fi
    result_212=("${json_query_output[@]}") && __status=0 || __status=$?
    ret_json_multiquery169_v0=("${result_212[@]}")
    return 0
}

# key_to_arr(key: Text, raw: Bool)
key_to_arr__170_v0() {
    local key_201="${1}"
    local raw_202="${2}"
    local __length_14="${key_201}"
    if (( ${#__length_14} == 0 )); then
        echo_error__144_v0 "No key provided" 1
    fi
    key_to_arr "${key_201}" "" "${raw_202}" && __status=0 || __status=$?
    if [ "${__status}" != 0 ]; then
        echo "key_to_arr exited with error: $_shjq_error" && __status=0 || __status=$?
        return 1
    fi
}

# fetch(url: Text, method: Text, data: Text, headers: [Text])
fetch__254_v0() {
    local url_145="${1}"
    local method_146="${2}"
    local data_147="${3}"
    local headers_148=("${!4}")
    is_command__128_v0 "curl"
    local ret_is_command128_v0__45_9="${ret_is_command128_v0}"
    is_command__128_v0 "wget"
    local ret_is_command128_v0__65_9="${ret_is_command128_v0}"
    if [[ ${ret_is_command128_v0__45_9} != 0 ]]; then
        local header_args_150=()
        local post_data_151=()
        local __length_17="${data_147}"
        if (( ${#__length_17} > 0 )); then
            post_data_151+=("-d" "${data_147}")
        fi
        for header_152 in "${headers_148[@]}"; do
            local __length_21="${header_152}"
            if (( ${#__length_21} > 0 )); then
                header_args_150+=("-H" "${header_152}")
            fi
        done
        local command_23
        command_23="$(curl -L "${url_145}" --silent -S -X "${method_146}" "${header_args_150[@]}" "${post_data_151[@]}" 2>&1)"
        __status=$?
        local output_153="${command_23}"
        local curl_status_154="${__status}"
        if (( curl_status_154 > 0 )); then
            local array_24=("curl request failed with error: ${output_153}")
            : "${array_24[@]}"
            printf__134_v0 "\\x1b[1;3;97;41m%s\\x1b[0m
" "array_24"[@]
            exit "${curl_status_154}"
        fi
        ret_fetch254_v0="${output_153}"
        return 0
    elif [[ ${ret_is_command128_v0__65_9} != 0 ]]; then
        local header_args_155=()
        local post_data_156=()
        local __length_27="${data_147}"
        if (( ${#__length_27} > 0 )); then
            post_data_156+=("--body-data" "${data_147}")
        fi
        for header_157 in "${headers_148[@]}"; do
            local __length_31="${header_157}"
            if (( ${#__length_31} > 0 )); then
                header_args_155+=("--header" "${header_157}")
            fi
        done
        local command_34
        command_34="$(wget "${url_145}" -qO- --method="${method_146}" "${header_args_155[@]}" "${post_data_156[@]}")"
        __status=$?
        if [ "${__status}" != 0 ]; then
            local array_33=("wget request failed with exit code ${__status}")
            : "${array_33[@]}"
            printf__134_v0 "\\x1b[1;3;97;41m%s\\x1b[0m
" "array_33"[@]
            exit "${__status}"
        fi
        ret_fetch254_v0="${command_34}"
        return 0
    else
        match_regex__19_v0 "${url_145}" "http://" 0
        local ret_match_regex19_v0__80_42="${ret_match_regex19_v0}"
        if { true && [[ "${ret_match_regex19_v0__80_42}" != 0 ]]; }; then
            local full_headers_167=""
            local port_168=80
            local path_169=""
            replace__0_v0 "${url_145}" "http://" ""
            url_145="${ret_replace0_v0}"
            replace_one__1_v0 "${url_145}" "/" "
"
            local ret_replace_one1_v0__85_41="${ret_replace_one1_v0}"
            split_lines__5_v0 "${ret_replace_one1_v0__85_41}"
            local parts_178=("${ret_split_lines5_v0[@]}")
            # split host and path
            url_145="${parts_178[0]?"Index out of bounds (at std/http:86:29)"}"
            match_regex__19_v0 "${url_145}" ":([0-9][0-9]+)" 1
            local ret_match_regex19_v0__88_20="${ret_match_regex19_v0}"
            if [[ ${ret_match_regex19_v0__88_20} != 0 ]]; then
                # https://github.com/amber-lang/amber/pull/906#discussion_r2616210649
                path_169="${parts_178[1]?"Index out of bounds (at std/http:89:34)"}"
                replace_one__1_v0 "${url_145}" ":" "
"
                local ret_replace_one1_v0__90_41="${ret_replace_one1_v0}"
                split_lines__5_v0 "${ret_replace_one1_v0__90_41}"
                parts_178=("${ret_split_lines5_v0[@]}")
                # split IP/domain and port
                url_145="${parts_178[0]?"Index out of bounds (at std/http:91:33)"}"
                parse_int__13_v0 "${parts_178[1]?"Index out of bounds (at std/http:92:44)"}"
                __status=$?
                if [ "${__status}" != 0 ]; then
                    ret_fetch254_v0=''
                    return "${__status}"
                fi
                port_168="${ret_parse_int13_v0}"
            else
                local __length_35="${parts_178[1]?"Index out of bounds (at std/http:94:38)"}"
                path_169="$(if (( ${#__length_35} > 0 )); then printf '%s
' "${parts_178[1]?"Index out of bounds (at std/http:94:57)"}"; else printf '%s
' ""; fi)"
            fi
            local has_headers_180=0
            for header_181 in "${headers_148[@]}"; do
                local __length_38="${header_181}"
                if (( ${#__length_38} > 1 )); then
                    full_headers_167+="${header_181}
"
                    has_headers_180=1
                fi
            done
            local __length_39="${data_147}"
            if (( ${#__length_39} > 0 )); then
                local __length_40="${data_147}"
                full_headers_167+="content-length: ${#__length_40}
"
                if (( ! has_headers_180 )); then
                    full_headers_167+="content-type: application/x-www-form-urlencoded
"
                fi
                full_headers_167+="
${data_147}
"
            fi
            exec 3<>/dev/tcp/"${url_145}"/"${port_168}" && __status=0 || __status=$?
            if [ "${__status}" = 0 ]; then
                local http_code_182=0
                url_145="$(if (( port_168 != 80 )); then printf '%s
' "${url_145}:${port_168}"; else printf '%s
' "${url_145}"; fi)"
                local vers_183=("${EXEC_SHELL_VERSION[@]}")
                printf "%s
" "${method_146} /${path_169} HTTP/1.1
host: ${url_145}
connection: close
user-agent: Amber/bash-${vers_183[0]?"Index out of bounds (at std/http:115:136)"}.${vers_183[1]?"Index out of bounds (at std/http:115:146)"}.${vers_183[2]?"Index out of bounds (at std/http:115:156)"}
accept: */*
${full_headers_167}" >&3 && __status=0 || __status=$?
                read -r _ http_code_182 _ <&3
                  while IFS= read -r line; do 
                    [[ "$line" == $'' || -z "$line" ]] && break 
                  done <&3 && __status=0 || __status=$?
                if (( http_code_182 > 226 )); then
                    # all official HTTP 2** codes go up to 226
                    ret_fetch254_v0="${http_code_182}"
                    return 0
                else
                    local command_41
                    command_41="$(cat <&3 && exec 3>&-)"
                    __status=$?
                    ret_fetch254_v0="${command_41}"
                    return 0
                fi
            fi
            local socket_status_184="${__status}"
            local array_42=("Request failed with exit code ${socket_status_184}")
            : "${array_42[@]}"
            printf__134_v0 "\\x1b[1;3;97;41m%s\\x1b[0m
" "array_42"[@]
            exit "${socket_status_184}"
        else
            local array_43=("No connection method is available, aborting")
            : "${array_43[@]}"
            printf__134_v0 "\\x1b[1;3;97;41m%s\\x1b[0m
" "array_43"[@]
            exit 1
        fi
    fi
}

load_shelljq__165_v0 "shelljq/shjq"
__status=$?
if [ "${__status}" != 0 ]; then
    exit "${__status}"
fi
array_45=("")
: "${array_45[@]}"
fetch__254_v0 "https://wttr.is/Berlin?format=j2" "GET" "" "array_45"[@]
__status=$?
json_185="${ret_fetch254_v0}"
json_parser__167_v0 "${json_185}" 1
__status=$?
if [ "${__status}" != 0 ]; then
    exit "${__status}"
fi
printf '%s\n' "${json_185}"
declare -p json_to_arr_array && __status=0 || __status=$?
key_to_arr__170_v0 "current_condition[0]" 0
__status=$?
if [ "${__status}" != 0 ]; then
    exit "${__status}"
fi
# trust $ set -x $
array_46=("Temp_C" "Humidity" "Pressure")
: "${array_46[@]}"
json_multiquery__169_v0 "array_46"[@] 0
__status=$?
ret_json_multiquery169_v0__13_46=("${ret_json_multiquery169_v0[@]}")
array_destruct_47=("${ret_json_multiquery169_v0__13_46[@]}")
temp_215="${array_destruct_47[0]?"Index out of bounds (at test.ab:13:12)"}"
humidity_216="${array_destruct_47[1]?"Index out of bounds (at test.ab:13:18)"}"
pressure_217="${array_destruct_47[2]?"Index out of bounds (at test.ab:13:28)"}"
set +x && __status=0 || __status=$?
echo "Weather in Berlin:"
echo "Temperature: ${temp_215}"
echo "Humidity: ${humidity_216}"
echo "Pressure: ${pressure_217}"
