///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Не ИнтеграцияСКоннект.ДоступнаИнтеграцияСКоннект() Тогда
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаОшибка;
		Элементы.Сохранить.Видимость = Ложь;
	Иначе
		ЗаполнитьЗначенияСвойств(
			ЭтотОбъект,
			ИнтеграцияСКоннект.НастройкиИнтеграции(),
			"РасположениеФайла, ОтображатьКнопкуЗапуска");
		УстановитьВидимостьДоступность(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОтображатьКнопкуЗапускаПриИзменении(Элемент)
	
	УстановитьВидимостьДоступность(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура РасположениеФайлаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Каталог = ОбщегоНазначенияКлиентСервер.РазложитьПолноеИмяФайла(РасположениеФайла);
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Заголовок          = НСтр("ru = 'Выберите исполняемый файл приложения'");
	Диалог.ПолноеИмяФайла     = РасположениеФайла;
	Диалог.Каталог            = Каталог.Путь;
	Фильтр                    = НСтр("ru = 'Файл приложения (*.exe)|*.exe'");
	Диалог.Фильтр             = Фильтр;
	Диалог.МножественныйВыбор = Ложь;
	
	Оповещение = Новый ОписаниеОповещения(
		"РасположениеФайлаНачалоВыбораЗавершение",
		ЭтотОбъект);
	
	ФайловаяСистемаКлиент.ПоказатьДиалогВыбора(
		Оповещение,
		Диалог);
	
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияЗаголовокНастройкиОбработкаНавигационнойСсылки(
		Элемент,
		НавигационнаяСсылкаФорматированнойСтроки,
		СтандартнаяОбработка)
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "action:serviceDescription" Тогда
		ИнтернетПоддержкаПользователейКлиент.ОткрытьВебСтраницу(
			"https://portal.1c.ru/applications/12");
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Сохранить(Команда)
	
	СохранитьНаСервере(РасположениеФайла, ОтображатьКнопкуЗапуска);
	Оповестить(ИнтеграцияСКоннектКлиент.ИмяСобытияОбновленияНастроек());
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура НетЛогина(Команда)
	
	ФайловаяСистемаКлиент.ОткрытьНавигационнуюСсылку("http://buhphone.com/clients/be-client/");
	
КонецПроцедуры

&НаКлиенте
Процедура НетПриложения(Команда)
	
	ФайловаяСистемаКлиент.ОткрытьНавигационнуюСсылку("https://1c-connect.com/download-desktop/");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьДоступность(Форма)
	
	Форма.Элементы.ГруппаПараметрыЗапуска.Доступность = Форма.ОтображатьКнопкуЗапуска;
	
КонецПроцедуры

&НаКлиенте
Процедура РасположениеФайлаНачалоВыбораЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы <> Неопределено
		И ВыбранныеФайлы <> ""
		И ВыбранныеФайлы.Количество() > 0 Тогда
		РасположениеФайла = ВыбранныеФайлы[0];
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура СохранитьНаСервере(
		РасположениеФайла,
		ОтображатьКнопкуЗапуска)
	
	ИнтеграцияСКоннект.СохранитьНастройкиИнтеграции(
		РасположениеФайла,
		ОтображатьКнопкуЗапуска);
	
КонецПроцедуры 

#КонецОбласти