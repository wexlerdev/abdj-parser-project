# Python-Like Parser

## 📜 Project Description

This project involves the implementation of a **parser** for a specified subset of the Python 3.x language. The core objective is to define a grammar using a tool like ANTLR, YACC, Lex, or Bison, and use it to successfully parse Python-like code snippets featuring key structural and operational elements.

The parser is built using **Context-Free Grammar (CFG)** or **Backus-Naur Form (BNF)** principles. The final output of the parser must be a **parse tree**.

***Note:*** Python is an **indentation-sensitive** language. The grammar and parser must correctly handle indentation to define block structures (like `if`, `else`, `while`, and `for`).

## 👨‍💻 Team Members

* Alex Wexler
* Dominic Rios
* Patrick "Jaxon" Rogan
* Brody Nelson

## ⚙️ Setup and Requirements

This project uses a bash script (`run-tree.sh`) to automate the dependency download and execution process, simplifying setup significantly.

### 1. Required Tools

* **Java Development Kit (JDK):** Required to run the ANTLR tool and compile the generated Java files.
* **`curl`:** Required by the script to download the ANTLR JAR file.
* **Bash/Shell Environment:** The `run-tree.sh` script requires a standard Unix-like environment (Linux, macOS, or WSL on Windows).

### 2. Repository Structure

Your repository must contain the following files:

* `parsah.g4`: The ANTLR grammar file.
* `run-tree.sh`: The execution script that handles ANTLR setup and parsing.
* `testfile.py`: The input Python code file to be parsed.
* `README.md`: This documentation file.

## ▶️ How to Use/Run the Parser

The provided `run-tree.sh` script automates the entire process: downloading the ANTLR JAR, generating the parser, compiling the Java classes, and finally running the TestRig to display the parse tree.

### Step 1: Make the Script Executable

First, grant execution permission to the script:

```bash
chmod +x run-tree.sh
```
### Step 2: Prepare the Input File

Ensure the file named in the script's configuration (`TEST_FILE="testfile.py"`) contains the Python code you wish to parse. You can modify the content of `testfile.py` before running the script.

### Step 3: Run the Parser

Execute the script from your terminal:

```bash
./run-tree.sh
```

**Execution Flow (Automated by the script):**
1. Downloads `antlr-4.13.1-complete.jar`.
2. Generates the parser and lexer files from `parsah.g4`.
3. Compiles the generated Java files.
4. Executes the ANTLR TestRig on `testfile.py` using the entry rule defined as `program`.

**Expected Output:** After the script runs successfully, a separate window will open, displaying the full parse tree for the content of `testfile.py` using the ANTLR Java Tree Viewer. 

### Demo Video
* **Link:** https://youtu.be/QhRQfQQRGQc
