#!/bin/bash

# --- Configuration ---
ANTLR_VERSION="4.13.1"
ANTLR_JAR="antlr-${ANTLR_VERSION}-complete.jar"
GRAMMAR_FILE="parsah.g4"
TEST_RULE="program"
TEST_FILE="testfile.py"

# --- 1. Download the ANTLR JAR file ---
echo "1. Downloading ANTLR JAR file..."
curl -O "https://www.antlr.org/download/${ANTLR_JAR}"

# Check if download was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to download ${ANTLR_JAR}. Aborting."
    exit 1
fi

# --- 2. Generate the Parser and Lexer source code ---
echo "2. Generating parser and lexer source code from ${GRAMMAR_FILE}..."
java -jar "${ANTLR_JAR}" "${GRAMMAR_FILE}"

# Check if generation was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to generate source code. Check your grammar file (${GRAMMAR_FILE}). Aborting."
    exit 1
fi

# --- 3. Compile the generated Java source files ---
# Compiles the generated files (*.java) and the supporting main program (if any)
echo "3. Compiling all Java files..."
javac -cp "${ANTLR_JAR}:." *.java

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to compile Java files. Aborting."
    exit 1
fi

# --- 4. Run the TestRig to parse the test file ---
# Note: The separator for the classpath (cp) is usually ':' on Linux/macOS and ';' on Windows.
echo "4. Running ANTLR TestRig with GUI for ${TEST_FILE}..."
java -cp ".:${ANTLR_JAR}" org.antlr.v4.gui.TestRig parsah "${TEST_RULE}" -gui "${TEST_FILE}"

echo "Script complete."