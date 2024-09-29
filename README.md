# Overview

_For educational purposes only. Obviously I would never use this, obviously.

This is a simple python script that automates grading questions on gradescope.

You will need to provide the following inputs, specified in `main.py`:
- The question number
- The correct answer
- A link to a submission on Gradescope

A Chrome browser will open up and automatically go through each question and grade them, _marking only correct answers and leaving potentially incorrect ones for human review._

Note: the code uses [Baml](https://docs.boundaryml.com/docs/snippets/clients/overview), refer to their documentation if you need to edit the `baml_src/` files.

# Usage

1. Run `python login.py` and sign in to gradescope
2. Update variables in `main.py`
3. Run `python main.py`

