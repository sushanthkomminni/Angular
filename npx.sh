#!/bin/sh
(set -o igncr) 2>/dev/null && set -o igncr; # cygwin encoding fix

basedir=`dirname "$0"`

case `uname` in
    *CYGWIN*) basedir=`cygpath -w "$basedir"`;;
esac

NODE_EXE="$basedir/node.exe"
if ! [ -x "$NODE_EXE" ]; then
  NODE_EXE=node
fi

NPM_CLI_JS="$basedir/node_modules/npm/bin/npm-cli.js"
NPX_CLI_JS="$basedir/node_modules/npm/bin/npx-cli.js"

case `uname` in
  *MINGW*)
    NPM_PREFIX=`"$NODE_EXE" "$NPM_CLI_JS" prefix -g`
    NPM_PREFIX_NPX_CLI_JS="$NPM_PREFIX/node_modules/npm/bin/npx-cli.js"
    if [ -f "$NPM_PREFIX_NPX_CLI_JS" ]; then
      NPX_CLI_JS="$NPM_PREFIX_NPX_CLI_JS"
    fi
    ;;
  *CYGWIN*)
    NPM_PREFIX=`"$NODE_EXE" "$NPM_CLI_JS" prefix -g`
    NPM_PREFIX_NPX_CLI_JS="$NPM_PREFIX/node_modules/npm/bin/npx-cli.js"
    if [ -f "$NPM_PREFIX_NPX_CLI_JS" ]; then
      NPX_CLI_JS="$NPM_PREFIX_NPX_CLI_JS"
    fi
    ;;
esac

"$NODE_EXE" "$NPX_CLI_JS" "$@"
