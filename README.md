# Overview

This is a simple python script that automates grading questions on gradescope.

You will need to provide the following inputs, specified in `main.py`:
- The question number
- The correct answer
- A link to a submission on Gradescope

A Chrome browser will open up and automatically go through each question and grade them, _marking only correct answers and leaving potentially incorrect ones for human review._

# Usage

1. Run `python login.py` and sign in to gradescope
2. Update variables in `main.py`
3. Run `python main.py`

