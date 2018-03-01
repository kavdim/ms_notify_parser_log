import os
import sys

import xml.etree.cElementTree as ET

def xmlparserObjects(n):
    tree = ET.ElementTree(file='C:/objects.xml')# Путь до файла с объектами
    root = tree.getroot()

    for child in root:
        if child.attrib['ID'] == n:
            for s in child.iterfind('.//'):
                if s.attrib['name'] == "Name":
                    return(s.text)

def xmlparserAbonents(n):
    tree = ET.ElementTree(file='C:/abonents.xml')# Путь до файла с абонентами
    root = tree.getroot()

    for child in root:
        if child.attrib['ID'] == n:
            for s in child.iterfind('.//'):
                if s.attrib['name'] == "Name":
                    return(s.text)

def xmlparserPhoneAbonents(n):
    tree = ET.ElementTree(file='C:/abonents.xml')# Путь до файла с абонентами
    root = tree.getroot()

    for child in root:
        if child.attrib['ID'] == n:
            for s in child.iterfind('.//'):
                if s.attrib['name'] == "Address":
                    return(s.text)

f = open('C:/output.txt', 'w')
f.write('Дата; Время; Объект; Абонент; Сообщение \n')

fReport = open('C:/report.txt','w')

phoneCount = {}

for line in (open('C:/1.log', 'r')):
    if ('02/18' in line) and ('- OK[' in line):
        s = line.replace('[', '')
        s = s.replace(']', '')
        s = s.replace('I', '')
        s = s.replace('Application', '')
        s = s.replace('  Отправка сообщения, элемент 0 - OK',';')
        s = s.replace('  Отправка сообщения, элемент 1 - OK',';')
        s = s.replace(', Сообщение:',';')
        s = s.replace('\n','')
        s = s.split(';')

        t_Date = s[0].split(' ')
        t = s[1].split(',')
        t_Object = t[0].replace('Объект:','')

        if xmlparserObjects(t_Object) != None:
            t_Object = xmlparserObjects(t_Object)

        t_Abonent = t[1].replace('Абонент:','')
        t_Abonent = t_Abonent.replace(' ','')

        t_phoneAbonent = t_Abonent

        if xmlparserAbonents(t_Abonent) != None:
            t_Abonent = xmlparserAbonents(t_Abonent)

        #print(t_Date[0]+';'+t_Date[1]+';'+t_Object+';'+t_Abonent+';'+s[2])
        #f.write(t_Date[0]+';'+t_Date[1]+';'+t_Object+';'+t_Abonent+';'+s[2]+'\n')

        if xmlparserPhoneAbonents(t_phoneAbonent) in phoneCount:
            phoneCount[xmlparserPhoneAbonents(t_phoneAbonent)] = phoneCount[xmlparserPhoneAbonents(t_phoneAbonent)] + 1
        else:
            phoneCount[str(xmlparserPhoneAbonents(t_phoneAbonent))] = 1

    for strPhone in phoneCount:
        print(str(strPhone)+' ; '+ str(phoneCount[strPhone]))

f.close()
