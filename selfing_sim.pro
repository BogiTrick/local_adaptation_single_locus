QT += core
QT -= gui

TARGET = selfing_sim
CONFIG += console
CONFIG -= app_bundle
CONFIG += -static

INCLUDEPATH += /home/bogi/gsl/include/
LIBS += -L/usr/local/lib -L/home/bogi/gsl/lib/ -lgsl -lgslcblas -lm

TEMPLATE = app

SOURCES += main.cpp
