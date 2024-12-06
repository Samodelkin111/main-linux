# Стенд Vagrant ZFS
## Описание домашнего задания 
1. Определить алгоритм с наилучшим сжатием:
- Определить какие алгоритмы сжатия поддерживает zfs (gzip, zle, lzjb, lz4);
- создать 4 файловых системы на каждой применить свой алгоритм сжатия;
- для сжатия использовать либо текстовый файл, либо группу файлов.
2. Определить настройки пула.
- С помощью команды zfs import собрать pool ZFS.
- Командами zfs определить настройки:
  размер хранилища;
  тип pool;
  значение recordsize;
  какое сжатие используется;
  какая контрольная сумма используется.
3 . Работа со снапшотами:
- скопировать файл из удаленной директории;
- восстановить файл локально. zfs receive;
- найти зашифрованное сообщение в файле secret_message.
## Общие сведения:
- сеть по умолчанию
- всё помечено как тестовые машины, все тестовые файлы из методички.
- имя хоста test-zfs
- имена пулов test1-test4
- подготовка пулов и скачивание файлов пропущены в отчёте
- настройка хоста с помощью автоматически запускаемого скриптов 
### Основная часть: 
Использованное ПО: vagrant 2.4.1, Virtualbox 7.0.20, локальный бокс Ubuntu 2204.
Проблемы: не проходила команда  ```zpool import -d zpoolexport/ otus newotus``` с ошибкой pool not found, в скрипт это не попало чтобы потом не разбираться с именем пула.
Пропустил команду ```zfs get all``` - очень много вывода.
#### Определение наилучшего алгоритма сжатия.
 ```
 vagrant@test-zfs:~$ zfs get all | grep compressratio | grep -v ref;
test1  compressratio         1.81x                  -
test2  compressratio         2.23x                  -
test3  compressratio         3.65x                  -
test4  compressratio         1.00x                  -
vagrant@test-zfs:~$ zfs get all | grep compression;
test1  compression           lzjb                   local
test2  compression           lz4                    local
test3  compression           gzip-9                 local
test4  compression           zle                    local
```
Получается пул test3 и gzip-9 с коэффициентом сжатия 3,65.
#### Определение настроек пула
```
vagrant@test-zfs:~$ zfs get available otus;
e otus;
NAME  PROPERTY   VALUE  SOURCE
otus  available  347M   -
vagrant@test-zfs:~$ zfs get readonly otus;
NAME  PROPERTY  VALUE   SOURCE
otus  readonly  off     default
vagrant@test-zfs:~$ zfs get recordsize otus;
NAME  PROPERTY    VALUE    SOURCE
otus  recordsize  128K     local
vagrant@test-zfs:~$ zfs get compression otus;
NAME  PROPERTY     VALUE           SOURCE
otus  compression  zle             local
vagrant@test-zfs:~$ zfs get checksum otus;
NAME  PROPERTY  VALUE      SOURCE
otus  checksum  sha256     local
```
   ### Файлы: