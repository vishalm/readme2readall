#!/usr/bin/env python3
"""
Web Interface for README to Word Converter

This module provides a Streamlit-based web interface for the converter.
"""

import sys
import os
from pathlib import Path

def main():
    """Launch the Streamlit web interface."""
    try:
        import streamlit.web.cli as stcli
        
        # Get the path to the app.py file
        app_path = Path(__file__).parent.parent / "app.py"
        
        if not app_path.exists():
            # Try to find app.py in the current directory
            app_path = Path("app.py")
            if not app_path.exists():
                print("❌ Error: app.py not found.", file=sys.stderr)
                print("💡 Make sure you're running from the project directory.", file=sys.stderr)
                sys.exit(1)
        
        # Set up Streamlit arguments
        sys.argv = [
            "streamlit",
            "run",
            str(app_path),
            "--server.headless=true",
            "--browser.gatherUsageStats=false",
            "--server.port=8501"
        ]
        
        # Launch Streamlit
        stcli.main()
        
    except ImportError:
        print("❌ Streamlit not installed.", file=sys.stderr)
        print("💡 Install with: pip install streamlit", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"❌ Error launching web interface: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main() 