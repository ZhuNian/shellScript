#!/bin/bash
echo `date` >> /Users/nianzhu/Documents/learn/shellScript/testResult
nohup open 'http://www.baidu.com' >> testResult
echo `date` >> testResult
