import os
import sys
import chardet
import xml.etree.cElementTree as ET

def xmlparserObjects(n):
    tree = ET.ElementTree(file='C:/objects.xml')
    root = tree.getroot()

    for child in root:
        if child.attrib['ID'] == n:
            for s in child.iterfind('.//'):
                if s.attrib['name'] == "Name":
                    return(s.text)

def xmlparserAbonents(n):
    tree = ET.ElementTree(file='C:/abonents.xml')
    root = tree.getroot()

    for child in root:
        if child.attrib['ID'] == n:
            for s in child.iterfind('.//'):
                if s.attrib['name'] == "Name":
                    return(s.text)

f = open('C:/output.txt', 'w')
f.write('Дата; Время; Объект; Абонент; Сообщение \n')

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

        if xmlparserAbonents(t_Abonent) != None:
            t_Abonent = xmlparserAbonents(t_Abonent)

        print(t_Date[0]+';'+t_Date[1]+';'+t_Object+';'+t_Abonent+';'+s[2])
        f.write(t_Date[0]+';'+t_Date[1]+';'+t_Object+';'+t_Abonent+';'+s[2]+';\n')
f.close()
