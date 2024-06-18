#!/usr/bin/env bash
curl -L https://raw.githubusercontent.com/NickLediet/lil-dotties/main/install.sh | bash

curl -s https://raw.githubusercontent.com/pgrange/bash_unit/master/install.sh | bash
./bash_unit ~/.lil-src/tests/*
