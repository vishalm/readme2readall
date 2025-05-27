@echo off
echo 🚀 Setting up README to Word Converter...

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python is not installed. Please install Python 3.8 or higher.
    pause
    exit /b 1
)

echo ✅ Python found
python --version

REM Check if pip is installed
pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ pip is not installed. Please install pip.
    pause
    exit /b 1
)

echo ✅ pip found

REM Create virtual environment
echo 📦 Creating virtual environment...
python -m venv venv

REM Activate virtual environment
echo ✅ Activating virtual environment...
call venv\Scripts\activate.bat

REM Install dependencies
echo 📥 Installing dependencies...
pip install -r requirements.txt

if %errorlevel% neq 0 (
    echo ❌ Failed to install dependencies. Please check the error messages above.
    pause
    exit /b 1
)

echo ✅ Dependencies installed successfully!

REM Create output directory
if not exist "output" mkdir output
if not exist "output\images" mkdir output\images
echo 📁 Created output directories

REM Display success message
echo.
echo 🎉 Setup completed successfully!
echo.
echo To run the application:
echo 1. Activate the virtual environment:
echo    venv\Scripts\activate.bat
echo 2. Start the application:
echo    streamlit run app.py
echo.
echo 3. Open your browser to http://localhost:8501
echo.
echo Happy converting! 📄➡️📋
echo.
pause