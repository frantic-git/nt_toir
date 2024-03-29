
#Область ПрограммныйИнтерфейс

// Возвращает структуру параметров с нужными полями для передачи 
// в функцию ПолучитьИндексКартинкиДереваНеавтоматическойИерархии.
//
// Возвращаемое значение:
//		Структура - незаполненная структура с необходимым набором полей.
//
Функция СтруктураПараметровДляОпределенияИндексаКартинки() Экспорт
	
	Возврат Новый Структура("ПометкаУдаления, ЭтоГруппа, ЭтоСоставной, ТипОбъекта");
	
КонецФункции

// Возвращает индекс картикни из коллекции торо_КоллекцияВидыОбъектов по параметрам.
//
// Параметры:
//		СтруктураПараметров - Структура - состав полей определяется 
// 		в функции СтруктураПараметровДляОпределенияИндексаКартинки.
//
// Возвращаемое значение:
//		Число - индекс картинки в коллеции.
//
Функция ПолучитьИндексКартинкиДереваНеавтоматическойИерархии(СтруктураПараметров) Экспорт
	
	ИндексКартинки = 0;
	
	Если СтруктураПараметров.ЭтоГруппа = Истина Тогда
		ИндексКартинки = 5;
	ИначеЕсли СтруктураПараметров.ТипОбъекта = ПредопределенноеЗначение("Перечисление.торо_ТипыОбъектовRCM.ФункциональноеМесто") Тогда	
		Если СтруктураПараметров.ЭтоСоставной = Истина Тогда
			ИндексКартинки = 13;
		Иначе
			ИндексКартинки = 11;
		КонецЕсли;
	ИначеЕсли СтруктураПараметров.ЭтоСоставной = Истина Тогда
		ИндексКартинки = 2;
	Иначе
		ИндексКартинки = 0;
	КонецЕсли;
	
	Если СтруктураПараметров.ПометкаУдаления = Истина Тогда
		ИндексКартинки = ИндексКартинки + 1;
	КонецЕсли;
	
	Возврат ИндексКартинки;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область РаботаСДеревомИерархии

// Заполняет два верхних уровня иерархии в дереве
Процедура НачатьЗаполнениеДереваИерархии(Дерево, СтруктураПараметровИерархии, ПустойРодитель, ПолучатьСтатусыВУчете = Ложь, ОтборСтатусыВУчете = Неопределено, ОтборОбъектРемонта = Неопределено, ДополнительныеОтборы = Неопределено) Экспорт
	
	Дерево.ПолучитьЭлементы().Очистить();
	
	СтрокаСтруктурыИерархии = Дерево.ПолучитьЭлементы().Добавить();
	СтрокаСтруктурыИерархии.Ссылка = СтруктураПараметровИерархии.ТекСтруктураИерархии;
	СтрокаСтруктурыИерархии.Наименование = СтруктураПараметровИерархии.ТекСтруктураИерархии;
	СтрокаСтруктурыИерархии.Картинка = 4;
	СтрокаСтруктурыИерархии.КартинкаОтображаемая = 4;
	СтрокаСтруктурыИерархии.СвязиОбновлялись = Истина;
	
	Если ЗначениеЗаполнено(ОтборОбъектРемонта) Тогда
		ДанныеСтроки = торо_РаботаСИерархией20.ПолучитьСтруктуруДанныхСтрокиДляДереваОР(СтруктураПараметровИерархии, ОтборОбъектРемонта, СтруктураПараметровИерархии.КонечныеЭлементыВДереве);
		Если ДанныеСтроки <> Неопределено Тогда
			КореньОтбора = ДобавитьСтрокуВДеревоИерархии(СтрокаСтруктурыИерархии, ДанныеСтроки);
			МассивСтрок = торо_РаботаСИерархией20.ПолучитьМассивСтрокОдногоУровняИерархии(СтруктураПараметровИерархии, ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ОтборОбъектРемонта),,,СтруктураПараметровИерархии.КонечныеЭлементыВДереве);
			Для каждого ПодчиненныйЭлемент из МассивСтрок Цикл
				торо_РаботаСИерархией20КлиентСервер.ДобавитьСтрокуВДеревоИерархии(КореньОтбора, ПодчиненныйЭлемент);
			КонецЦикла;
		КонецЕсли;
	Иначе
		МассивСтрок = торо_РаботаСИерархией20.ПолучитьМассивСтрокВерхнегоУровняИерархии(СтруктураПараметровИерархии, ПустойРодитель, ПолучатьСтатусыВУчете, ОтборСтатусыВУчете, СтруктураПараметровИерархии.КонечныеЭлементыВДереве, ДополнительныеОтборы);
		ДобавитьСтрокиВДеревоСФиктивнымиПодчиненнымиЭлементами(МассивСтрок, СтрокаСтруктурыИерархии);
	КонецЕсли;
	
КонецПроцедуры

// Заполняет на форме полное дерево с конечными элементами.
Процедура ПостроитьДеревоСКонечнымиЭлементами(Дерево, СтруктураПараметровИерархии, РодительИерархии, ПолучатьСтатусыВУчете = Ложь, ОтборСтатусыВУчете = Неопределено, ДополнительныеОтборы = Неопределено) Экспорт
	
	Дерево.ПолучитьЭлементы().Очистить();
	
	СтрокаСтруктурыИерархии = Дерево.ПолучитьЭлементы().Добавить();
	СтрокаСтруктурыИерархии.Ссылка = СтруктураПараметровИерархии.ТекСтруктураИерархии;
	СтрокаСтруктурыИерархии.Наименование = СтруктураПараметровИерархии.ТекСтруктураИерархии;
	СтрокаСтруктурыИерархии.Картинка = 4;
	
	ДанныеСтроки = торо_РаботаСИерархией20.ПолучитьСтруктуруДанныхСтрокиДляДереваОР(СтруктураПараметровИерархии, РодительИерархии, Истина);
	Если ДанныеСтроки <> Неопределено Тогда
		КореньОтбора = ДобавитьСтрокуВДеревоИерархии(СтрокаСтруктурыИерархии, ДанныеСтроки);
		РекурсивноДобавитьСтрокиВДеревоСКонечнымиЭлементами(КореньОтбора, СтруктураПараметровИерархии, ПолучатьСтатусыВУчете, ОтборСтатусыВУчете, ДополнительныеОтборы);
	КонецЕсли;
	
КонецПроцедуры

Процедура РекурсивноДобавитьСтрокиВДеревоСКонечнымиЭлементами(СтрокаРодителя, СтруктураПараметровИерархии, ПолучатьСтатусыВУчете = Ложь, ОтборСтатусыВУчете = Неопределено, ДополнительныеОтборы = Неопределено)
	
	Если НЕ ЭтоКонечныйЭлементПоКартинке(СтрокаРодителя.Картинка) Тогда
		МассивСтрок = торо_РаботаСИерархией20.ПолучитьМассивСтрокОдногоУровняИерархииСКоличествомПодчиненных(СтруктураПараметровИерархии, ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(СтрокаРодителя.Ссылка), ПолучатьСтатусыВУчете, ОтборСтатусыВУчете, Истина, ДополнительныеОтборы);
		Для каждого ПодчиненныйЭлемент из МассивСтрок Цикл
			НоваяСтрока = торо_РаботаСИерархией20КлиентСервер.ДобавитьСтрокуВДеревоИерархии(СтрокаРодителя, ПодчиненныйЭлемент);
			РекурсивноДобавитьСтрокиВДеревоСКонечнымиЭлементами(НоваяСтрока, СтруктураПараметровИерархии, ПолучатьСтатусыВУчете, ОтборСтатусыВУчете);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

// Выстраивает дерево из массива структур данных строк.
Процедура ПостроитьДеревоПоМассивуСтрок(МассивСтруктурОР, Дерево, РодительИерархии) Экспорт
	
	СоответствиеРодителей = ПолучитьСоответствиеПоМассивуСтрок(МассивСтруктурОР);
	
	МассивКорневыхЭлементов = СоответствиеРодителей[РодительИерархии];
	Если МассивКорневыхЭлементов <> Неопределено Тогда
		Для каждого КорневойЭлемент из МассивКорневыхЭлементов Цикл
			НСКорневая = Дерево.ПолучитьЭлементы().Добавить();
			ЗаполнитьЗначенияСвойств(НСКорневая,КорневойЭлемент);
			НСКорневая.Ссылка = КорневойЭлемент.ОбъектИерархии;
			НСКорневая.Картинка = КорневойЭлемент.ИндексКартинки;
			
			МассивПодчиненныхЭлементов = СоответствиеРодителей[КорневойЭлемент.ОбъектИерархии];
			Если МассивПодчиненныхЭлементов = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			
			Для каждого ПодчиненныйЭлемент из МассивПодчиненныхЭлементов Цикл
				НСПодчиненная = НСКорневая.ПолучитьЭлементы().Добавить();
				ЗаполнитьЗначенияСвойств(НСПодчиненная,ПодчиненныйЭлемент);
				НСПодчиненная.Ссылка = ПодчиненныйЭлемент.ОбъектИерархии;
				НСПодчиненная.Картинка = ПодчиненныйЭлемент.ИндексКартинки;
			КонецЦикла;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

// Выстраивает дерево из массива структур данных строк.
Процедура ДобавитьСтрокиВДеревоСФиктивнымиПодчиненнымиЭлементами(МассивСтруктурОР, Дерево) Экспорт
	
	Для каждого СтруктураСтроки из МассивСтруктурОР Цикл
		НСКорневая = Дерево.ПолучитьЭлементы().Добавить();
		ЗаполнитьЗначенияСвойств(НСКорневая,СтруктураСтроки);
		НСКорневая.Ссылка = СтруктураСтроки.ОбъектИерархии;
		НСКорневая.Картинка = СтруктураСтроки.ИндексКартинки;
		
		Если СтруктураСтроки.ЕстьПодчиненные Тогда
			НСКорневая.ПолучитьЭлементы().Добавить();
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Из массива строк подготавливает соответствие Родитель - Подчиненные строки.
Функция ПолучитьСоответствиеПоМассивуСтрок(МассивСтрок, ИмяРеквизитаКлюча = "РодительИерархии") Экспорт
	
	СоответствиеРодителей = Новый Соответствие;
	Для каждого Элемент из МассивСтрок Цикл
		Ключ = Элемент[ИмяРеквизитаКлюча];
		ЭлемСоответсвия = СоответствиеРодителей[Ключ];
		Если ЭлемСоответсвия = Неопределено Тогда
			ЭлемСоответсвия = Новый Массив;
		КонецЕсли;
		ЭлемСоответсвия.Добавить(Элемент);
		СоответствиеРодителей.Вставить(Ключ, ЭлемСоответсвия);
	КонецЦикла;
	
	Возврат СоответствиеРодителей;
	
КонецФункции

// Выполняет поиск строки с ссылкой в дереве по уже построенным ветвям.
Функция НайтиСсылкуВДеревеБезДостраивания(СтрокиДерева, Знач ИскомаяСсылка, СтруктураПараметровИерархии, ПустойРодитель) Экспорт
	
	Если НЕ СтруктураПараметровИерархии.СтроитсяАвтоматически И ИскомаяСсылка = ПустойРодитель Тогда
		ИскомаяСсылка = СтруктураПараметровИерархии.ТекСтруктураИерархии;
	КонецЕсли;
	
	Возврат НайтиСсылкуВДеревеБезДостраиванияРекурсивно(СтрокиДерева, ИскомаяСсылка);
	
КонецФункции

Функция НайтиСсылкуВДеревеБезДостраиванияРекурсивно(СтрокиДерева, ИскомаяСсылка)
	
	Для каждого Строка из СтрокиДерева Цикл
		Если Строка.Ссылка = ИскомаяСсылка Тогда
			Возврат Строка;
		КонецЕсли;
		НайденнаяСсылка = НайтиСсылкуВДеревеБезДостраиванияРекурсивно(Строка.ПолучитьЭлементы(), ИскомаяСсылка);
		Если НайденнаяСсылка <> Неопределено Тогда
			Возврат НайденнаяСсылка;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

Функция ЭтоКонечныйЭлементПоКартинке(ИндексКартинки) Экспорт
	
	Возврат ИндексКартинки = 0 ИЛИ  ИндексКартинки = 1;
	
КонецФункции

Функция ЭтоОбычнаяГруппаПоКартинке(ИндексКартинки) Экспорт
	
	Возврат ИндексКартинки = 5 ИЛИ  ИндексКартинки = 6;

КонецФункции

Функция ЭтоОРГруппаПоКартинке(ИндексКартинки) Экспорт
	
	Возврат ИндексКартинки = 2 ИЛИ  ИндексКартинки = 3
				ИЛИ ИндексКартинки = 13 ИЛИ  ИндексКартинки = 14;
		
КонецФункции

Функция ЭтоОбъектСПодчиненнымиПоКартинке(ИндексКартинки) Экспорт
	
	Возврат ЭтоОбычнаяГруппаПоКартинке(ИндексКартинки)
				ИЛИ ЭтоОРГруппаПоКартинке(ИндексКартинки);
	
КонецФункции

Функция ЭтоКореньИерархииПоКартинке(ИндексКартинки) Экспорт
	
	Возврат ИндексКартинки = 4;
	
КонецФункции

Функция ЭтоФункциональноеМестоПоКартинке(ИндексКартинки) Экспорт
	
	Возврат ИндексКартинки >= 11 И  ИндексКартинки <= 14;

КонецФункции

Функция ЭтоНеОбъектРемонтаПоКартинке(ИндексКартинки) Экспорт
	
	Возврат ИндексКартинки > 6 И  ИндексКартинки < 11;

КонецФункции

Процедура УстановитьСостояниеИерархическогоПросмотра(Форма, Включен) Экспорт
	
	Форма.ВключенИерархическийПросмотр = Включен;
	Если Форма.Элементы.Найти("ФормаИерархическийПросмотр") <> Неопределено Тогда
		Форма.Элементы.ФормаИерархическийПросмотр.Пометка = Включен;
	КонецЕсли;
		
КонецПроцедуры

Функция ДобавитьСтрокуВДеревоИерархии(КорневаяСтрока, ДанныеДляДобавления) Экспорт
	
	НоваяСтрока = КорневаяСтрока.ПолучитьЭлементы().Добавить();
	ЗаполнитьЗначенияСвойств(НоваяСтрока,ДанныеДляДобавления);
	НоваяСтрока.Ссылка = ДанныеДляДобавления.ОбъектИерархии;
	НоваяСтрока.Картинка = ДанныеДляДобавления.ИндексКартинки;
	
	Возврат НоваяСтрока;
	
КонецФункции

#КонецОбласти

#Область РаботаСДинамическимСпискомОбъектовРемонта

// Изменяет отбор в динамическом списке.
Процедура УстановитьОтборСпискаПоРодителю(Список, Родитель, Использование = Истина) Экспорт
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Родитель", Родитель,,,Использование,РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	
КонецПроцедуры

#КонецОбласти

// Возвращает описание типов, которое состоит либо только из справочника ОбъектыРемонта,
// либо из справочника ОбъектыРемонта и типа справочника родителя для автоматической иерархии.
Функция ПолучитьОписаниеТиповЭлементовВИерархии(СтруктураИерархии) Экспорт
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("СправочникСсылка.торо_ОбъектыРемонта"));
	
	Если ЗначениеЗаполнено(СтруктураИерархии) Тогда
		РеквизитыИерархии = торо_ОбщегоНазначенияВызовСервера.ЗначенияРеквизитовОбъекта(СтруктураИерархии, "СтроитсяАвтоматически, ТипРеквизитаОР");
		Если РеквизитыИерархии.СтроитсяАвтоматически = Истина И ЗначениеЗаполнено(РеквизитыИерархии.ТипРеквизитаОР) Тогда
			МассивТипов.Добавить(Тип("СправочникСсылка."+РеквизитыИерархии.ТипРеквизитаОР));
		КонецЕсли;
	КонецЕсли;
	
	Возврат Новый ОписаниеТипов(МассивТипов);
	
КонецФункции

#КонецОбласти
