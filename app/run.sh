#!/bin/sh

cd /home/app;

#python3 /home/app/main.py
uvicorn main:app --reload --host 0.0.0.0  --loop uvloop --workers 10
