
// Переменные для сохранения и восстановления состояния дерева.
&НаКлиенте
Перем МассивРазвернутыхЭлементов, ТекущийДокумент, ИдентификаторТекущего;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Документ") Тогда
		Документ = Параметры.Документ;
		ЗаполнитьСписокРемонтовПоДокументу();
	КонецЕсли;
	
	ПостроитьДеревоДокументов();
	УстановитьУсловноеОформление();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписокДокументов

&НаКлиенте
Процедура СписокДокументовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекДанные = Элементы.СписокДокументов.ТекущиеДанные;
	
	Если ТекДанные <> Неопределено Тогда
		ПоказатьЗначение(Неопределено, ТекДанные.Документ);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокДокументовПриАктивизацииСтроки(Элемент)
	
	ТекДанные = Элементы.СписокДокументов.ТекущиеДанные;
	
	Если ТекДанные <> Неопределено И ТекДанные.ЯвляетсяДокументом Тогда
		Элементы.ФормаПометитьНаУдаление.Доступность = Истина;
		
		Если ТекДанные.Проведен Тогда
			Элементы.ФормаПровести.Доступность = Ложь;
			Элементы.ФормаОтменаПроведения.Доступность = Истина;
			Элементы.СписокДокументовКонтекстноеМенюПровести.Доступность = Ложь;
			Элементы.СписокДокументовКонтекстноеМенюОтменаПроведения.Доступность = Истина;
			Элементы.СписокДокументовКонтекстноеМенюПометитьНаУдаление.Доступность = Истина;
		Иначе
			Элементы.ФормаПровести.Доступность = Истина;
			Элементы.ФормаОтменаПроведения.Доступность = Ложь;
			Элементы.СписокДокументовКонтекстноеМенюПровести.Доступность = Истина;
			Элементы.СписокДокументовКонтекстноеМенюОтменаПроведения.Доступность = Ложь;
			Элементы.СписокДокументовКонтекстноеМенюПометитьНаУдаление.Доступность = Истина;
		КонецЕсли;
	Иначе
		Элементы.ФормаПровести.Доступность = Ложь;
		Элементы.ФормаОтменаПроведения.Доступность = Ложь;
		Элементы.ФормаПометитьНаУдаление.Доступность = Ложь;
		Элементы.СписокДокументовКонтекстноеМенюПровести.Доступность = Ложь;
		Элементы.СписокДокументовКонтекстноеМенюОтменаПроведения.Доступность = Ложь;
		Элементы.СписокДокументовКонтекстноеМенюПометитьНаУдаление.Доступность = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Провести(Команда)
	
	ТекДанные = Элементы.СписокДокументов.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если ТекДанные.ПометкаУдаления Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru = 'Помеченный на удаление документ не может быть проведен!'"));
		Возврат;
	КонецЕсли;
	
	Если ЗаписатьВыбранныйДокумент(РежимЗаписиДокумента.Проведение, ТекДанные.Документ, ТекДанные.ПолучитьИдентификатор()) Тогда
		ТекДанные.Картинка = ПолучитьИндексКартинкиВКоллекции(ТекДанные);
		СписокДокументовПриАктивизацииСтроки(Элементы.СписокДокументов);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтменаПроведения(Команда)
	
	ТекДанные = Элементы.СписокДокументов.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если НЕ ТекДанные.Проведен Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru = 'Документ не проведен.'"));
		Возврат;
	КонецЕсли;
	
	Если ЗаписатьВыбранныйДокумент(РежимЗаписиДокумента.ОтменаПроведения, ТекДанные.Документ, ТекДанные.ПолучитьИдентификатор()) Тогда
		ТекДанные.Картинка = ПолучитьИндексКартинкиВКоллекции(ТекДанные);
		СписокДокументовПриАктивизацииСтроки(Элементы.СписокДокументов);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПометитьНаУдаление(Команда)
	ТекущиеДанные = Элементы.СписокДокументов.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если ЗаписатьВыбранныйДокумент(РежимЗаписиДокумента.Запись, ТекущиеДанные.Документ, ТекущиеДанные.ПолучитьИдентификатор(), Не ТекущиеДанные.ПометкаУдаления) Тогда
		ТекущиеДанные.Картинка = ПолучитьИндексКартинкиВКоллекции(ТекущиеДанные);
		СписокДокументовПриАктивизацииСтроки(Элементы.СписокДокументов);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Обновить(Команда)
	
	ЗаписатьСостояниеДерева();
	СписокДокументовДерево.ПолучитьЭлементы().Очистить();
	ПостроитьДеревоДокументов();
	ВосстановитьСостояниеДерева();
	
КонецПроцедуры

&НаКлиенте
Процедура РазвернутьВсеСтроки(Команда)	
	
	Для Каждого ТекСтрока Из СписокДокументовДерево.ПолучитьЭлементы() Цикл
		Элементы.СписокДокументов.Развернуть(ТекСтрока.ПолучитьИдентификатор(), Истина);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СвернутьВсеСтроки(Команда)
	
	Для каждого Стр Из СписокДокументовДерево.ПолучитьЭлементы() Цикл
		СвернутьПодчиненные(Стр);
		Элементы.СписокДокументов.Свернуть(Стр.ПолучитьИдентификатор());
	КонецЦикла; 
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьСписокРемонтовПоДокументу()
	
	ИмяТЧРемонтов = торо_Ремонты.ПолучитьИмяТЧРемонтов(Документ);
	ИменаКолонок = ПолучитьСоответствиеИменКолонокДляЗаполнения(Документ);
	
	ВидРемонтаДляВД = Константы.торо_ВидРемонтаПриВводеНаОснованииВыявленныхДефектов.Получить();
	ВидРемонтаДляВО = Константы.торо_ВидРемонтаПриВводеНаОснованииВнешнихОснований.Получить();
	
	Для каждого СтрокаДокумента Из Документ[ИмяТЧРемонтов] Цикл
		НоваяСтрока = СписокID.Добавить();
		НоваяСтрока.ОбъектРемонта = СтрокаДокумента[ИменаКолонок.ОР];
		НоваяСтрока.ID = СтрокаДокумента.ID;
		Если ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ВыявленныеДефекты") Тогда 
			НоваяСтрока.ВидРемонта = ВидРемонтаДляВД;
		ИначеЕсли ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ВнешнееОснованиеДляРабот") Тогда 
			НоваяСтрока.ВидРемонта = ВидРемонтаДляВО;
		Иначе
			НоваяСтрока.ВидРемонта = СтрокаДокумента[ИменаКолонок.ВР];
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ИменаКолонок.ДатаНачала) Тогда
			НоваяСтрока.ДатаНачала = СтрокаДокумента[ИменаКолонок.ДатаНачала];
		КонецЕсли;
	КонецЦикла;
	
	Если ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ОстановочныеРемонты") Тогда
		НоваяСтрока = СписокID.Добавить();
		НоваяСтрока.ОбъектРемонта = Документ.ОбъектРемонта;
		НоваяСтрока.ВидРемонта = Документ.ВидРемонта;
		НоваяСтрока.ID = Документ.IDОсновногоРемонта;
		НоваяСтрока.ДатаНачала = Документ.ДатаНачалаРемонта;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьСоответствиеИменКолонокДляЗаполнения(Документ)

	ИменаКолонок = Новый Структура("ОР, ВР, ДатаНачала");	
	
	Если ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ВнешнееОснованиеДляРабот") 
		ИЛИ ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ВыявленныеДефекты") Тогда
		
		ИменаКолонок.Вставить("ОР", "ОбъектРемонта");
		
	ИначеЕсли ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ПланГрафикРемонта") Тогда
		
		ИменаКолонок.Вставить("ОР", "ОбъектРемонтныхРабот");
		ИменаКолонок.Вставить("ВР", "ВидРемонтныхРабот");
		ИменаКолонок.Вставить("ДатаНачала", "ДатаНач");
		
	ИначеЕсли ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ГрафикРегламентныхМероприятийТОиР") Тогда
		
		ИменаКолонок.Вставить("ОР", "СписокОбъектовРемонта");
		ИменаКолонок.Вставить("ВР", "ВидРемонтныхРабот");
		ИменаКолонок.Вставить("ДатаНачала", "ДатаНач");
	
	ИначеЕсли ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ЗаявкаНаРемонт")
		ИЛИ ТипЗнч(Документ) = Тип("ДокументСсылка.торо_НарядНаВыполнениеРемонтныхРабот")
		ИЛИ ТипЗнч(Документ) = Тип("ДокументСсылка.торо_НарядНаРегламентноеМероприятие")
		ИЛИ ТипЗнч(Документ) = Тип("ДокументСсылка.торо_АктОВыполненииЭтапаРабот")
		ИЛИ ТипЗнч(Документ) = Тип("ДокументСсылка.торо_АктОВыполненииРегламентногоМероприятия") 
		ИЛИ ТипЗнч(Документ) = Тип("ДокументСсылка.торо_АктПриемкиОборудования") Тогда
		
		ИменаКолонок.Вставить("ОР", "ОбъектРемонта");
		ИменаКолонок.Вставить("ВР", "ВидРемонтныхРабот");
		ИменаКолонок.Вставить("ДатаНачала", "ДатаНачала");
		
	ИначеЕсли ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ОстановочныеРемонты") Тогда
		
		ИменаКолонок.Вставить("ОР", "ОбъектРемонта");
		ИменаКолонок.Вставить("ВР", "ВидРемонта");
		ИменаКолонок.Вставить("ДатаНачала", "ДатаНачалаРемонта");
		
	ИначеЕсли ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ПланРаботПодразделения") Тогда
		
		ИменаКолонок.Вставить("ОР", "ОбъектРемонта");
		ИменаКолонок.Вставить("ВР", "ВидРемонта");
		ИменаКолонок.Вставить("ДатаНачала", "ДатаНачала");
		
	КонецЕсли;
	
	Возврат ИменаКолонок;
	
КонецФункции

&НаСервере
Процедура ПостроитьДеревоДокументов()
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ВЫБОР
	|		КОГДА торо_ПланГрафикРемонта.ДокументОснование = ЗНАЧЕНИЕ(Документ.торо_ПланГрафикРемонта.ПустаяСсылка)
	|			ТОГДА НЕОПРЕДЕЛЕНО
	|		КОГДА торо_АктуальныеПлановыеДатыРемонтов.ДокументНачалаЦепочки ЕСТЬ NULL
	|			ТОГДА НЕОПРЕДЕЛЕНО
	|		КОГДА торо_ПланГрафикРемонта.Ссылка = торо_АктуальныеПлановыеДатыРемонтов.ДокументНачалаЦепочки
	|			ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ торо_ПланГрафикРемонта.ДокументОснование
	|	КОНЕЦ КАК ДокументИсточник,
	|	торо_ПланГрафикРемонта.Ссылка КАК Ссылка,
	|	торо_ПланГрафикРемонтаПланРемонтов.ДатаНач КАК Дата,
	|	торо_ПланГрафикРемонта.Проведен КАК Проведен,
	|	торо_ПланГрафикРемонта.ПометкаУдаления КАК ПометкаУдаления
	|ИЗ
	|	Документ.торо_ПланГрафикРемонта.ПланРемонтов КАК торо_ПланГрафикРемонтаПланРемонтов
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_ПланГрафикРемонта КАК торо_ПланГрафикРемонта
	|		ПО торо_ПланГрафикРемонтаПланРемонтов.Ссылка = торо_ПланГрафикРемонта.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_АктуальныеПлановыеДатыРемонтов КАК торо_АктуальныеПлановыеДатыРемонтов
	|		ПО торо_ПланГрафикРемонтаПланРемонтов.ID = торо_АктуальныеПлановыеДатыРемонтов.IDРемонта
	|ГДЕ
	|	торо_ПланГрафикРемонтаПланРемонтов.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВЫБОР
	|		КОГДА торо_ПланГрафикРемонта.ДокументОснование = ЗНАЧЕНИЕ(Документ.торо_ГрафикРегламентныхМероприятийТОиР.ПустаяСсылка)
	|			ТОГДА НЕОПРЕДЕЛЕНО
	|		КОГДА торо_АктуальныеПлановыеДатыРемонтов.ДокументНачалаЦепочки ЕСТЬ NULL
	|			ТОГДА НЕОПРЕДЕЛЕНО
	|		КОГДА торо_ПланГрафикРемонта.Ссылка = торо_АктуальныеПлановыеДатыРемонтов.ДокументНачалаЦепочки
	|			ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ торо_ПланГрафикРемонта.ДокументОснование
	|	КОНЕЦ,
	|	торо_ПланГрафикРемонта.Ссылка,
	|	торо_ПланГрафикРемонтаПланРемонтов.ДатаНач,
	|	торо_ПланГрафикРемонта.Проведен,
	|	торо_ПланГрафикРемонта.ПометкаУдаления
	|ИЗ
	|	Документ.торо_ГрафикРегламентныхМероприятийТОиР.ПланРемонтов КАК торо_ПланГрафикРемонтаПланРемонтов
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_ГрафикРегламентныхМероприятийТОиР КАК торо_ПланГрафикРемонта
	|		ПО торо_ПланГрафикРемонтаПланРемонтов.Ссылка = торо_ПланГрафикРемонта.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_АктуальныеПлановыеДатыРемонтов КАК торо_АктуальныеПлановыеДатыРемонтов
	|		ПО торо_ПланГрафикРемонтаПланРемонтов.ID = торо_АктуальныеПлановыеДатыРемонтов.IDРемонта
	|ГДЕ
	|	торо_ПланГрафикРемонтаПланРемонтов.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВЫБОР
	|		КОГДА торо_ВыявленныеДефектыСписокДефектов.ЗакрываетПредписание
	|			ТОГДА торо_ВыявленныеДефектыСписокДефектов.ДокументИсточник
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО
	|	КОНЕЦ,
	|	торо_ВыявленныеДефекты.Ссылка,
	|	торо_ВыявленныеДефекты.ДатаОбнаружения,
	|	торо_ВыявленныеДефекты.Проведен,
	|	торо_ВыявленныеДефекты.ПометкаУдаления
	|ИЗ
	|	Документ.торо_ВыявленныеДефекты.СписокДефектов КАК торо_ВыявленныеДефектыСписокДефектов
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_ВыявленныеДефекты КАК торо_ВыявленныеДефекты
	|		ПО торо_ВыявленныеДефектыСписокДефектов.Ссылка = торо_ВыявленныеДефекты.Ссылка
	|ГДЕ
	|	торо_ВыявленныеДефектыСписокДефектов.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	НЕОПРЕДЕЛЕНО,
	|	торо_Предписание.Ссылка,
	|	торо_ПредписанияОбследованноеОборудование.ПлановаяДатаРемонта,
	|	торо_Предписание.Проведен,
	|	торо_Предписание.ПометкаУдаления
	|ИЗ
	|	Документ.торо_ВнешнееОснованиеДляРабот.ОбследованноеОборудование КАК торо_ПредписанияОбследованноеОборудование
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_ВнешнееОснованиеДляРабот КАК торо_Предписание
	|		ПО торо_ПредписанияОбследованноеОборудование.Ссылка = торо_Предписание.Ссылка
	|ГДЕ
	|	торо_ПредписанияОбследованноеОборудование.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_ЗаявкаНаРемонтРемонтыОборудования.ДокументИсточник,
	|	торо_ЗаявкаНаРемонт.Ссылка,
	|	ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0),
	|	торо_ЗаявкаНаРемонт.Проведен,
	|	торо_ЗаявкаНаРемонт.ПометкаУдаления
	|ИЗ
	|	Документ.торо_ЗаявкаНаРемонт.РемонтыОборудования КАК торо_ЗаявкаНаРемонтРемонтыОборудования
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_ЗаявкаНаРемонт КАК торо_ЗаявкаНаРемонт
	|		ПО торо_ЗаявкаНаРемонтРемонтыОборудования.Ссылка = торо_ЗаявкаНаРемонт.Ссылка
	|ГДЕ
	|	торо_ЗаявкаНаРемонтРемонтыОборудования.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования.ДокументИсточник,
	|	торо_НарядНаВыполнениеРемонтныхРабот.Ссылка,
	|	ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0),
	|	торо_НарядНаВыполнениеРемонтныхРабот.Проведен,
	|	торо_НарядНаВыполнениеРемонтныхРабот.ПометкаУдаления
	|ИЗ
	|	Документ.торо_НарядНаВыполнениеРемонтныхРабот.РемонтыОборудования КАК торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_НарядНаВыполнениеРемонтныхРабот КАК торо_НарядНаВыполнениеРемонтныхРабот
	|		ПО торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования.Ссылка = торо_НарядНаВыполнениеРемонтныхРабот.Ссылка
	|ГДЕ
	|	торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования.ДокументИсточник,
	|	торо_НарядНаВыполнениеРемонтныхРабот.Ссылка,
	|	ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0),
	|	торо_НарядНаВыполнениеРемонтныхРабот.Проведен,
	|	торо_НарядНаВыполнениеРемонтныхРабот.ПометкаУдаления
	|ИЗ
	|	Документ.торо_НарядНаРегламентноеМероприятие.РегламентныеМероприятия КАК торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_НарядНаРегламентноеМероприятие КАК торо_НарядНаВыполнениеРемонтныхРабот
	|		ПО торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования.Ссылка = торо_НарядНаВыполнениеРемонтныхРабот.Ссылка
	|ГДЕ
	|	торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ДокументИсточник,
	|	торо_АктОВыполненииЭтапаРабот.Ссылка,
	|	ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0),
	|	торо_АктОВыполненииЭтапаРабот.Проведен,
	|	торо_АктОВыполненииЭтапаРабот.ПометкаУдаления
	|ИЗ
	|	Документ.торо_АктОВыполненииЭтапаРабот.РемонтыОборудования КАК торо_АктОВыполненииЭтапаРаботРемонтыОборудования
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииЭтапаРабот КАК торо_АктОВыполненииЭтапаРабот
	|		ПО торо_АктОВыполненииЭтапаРаботРемонтыОборудования.Ссылка = торо_АктОВыполненииЭтапаРабот.Ссылка
	|ГДЕ
	|	торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ДокументИсточник,
	|	торо_АктОВыполненииЭтапаРабот.Ссылка,
	|	ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0),
	|	торо_АктОВыполненииЭтапаРабот.Проведен,
	|	торо_АктОВыполненииЭтапаРабот.ПометкаУдаления
	|ИЗ
	|	Документ.торо_АктОВыполненииРегламентногоМероприятия.Мероприятия КАК торо_АктОВыполненииЭтапаРаботРемонтыОборудования
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииРегламентногоМероприятия КАК торо_АктОВыполненииЭтапаРабот
	|		ПО торо_АктОВыполненииЭтапаРаботРемонтыОборудования.Ссылка = торо_АктОВыполненииЭтапаРабот.Ссылка
	|ГДЕ
	|	торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_АктПриемкиОборудованияРемонтыОборудования.ДокументИсточник,
	|	торо_АктПриемкиОборудования.Ссылка,
	|	ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0),
	|	торо_АктПриемкиОборудования.Проведен,
	|	торо_АктПриемкиОборудования.ПометкаУдаления
	|ИЗ
	|	Документ.торо_АктПриемкиОборудования.РемонтыОборудования КАК торо_АктПриемкиОборудованияРемонтыОборудования
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_АктПриемкиОборудования КАК торо_АктПриемкиОборудования
	|		ПО торо_АктПриемкиОборудованияРемонтыОборудования.Ссылка = торо_АктПриемкиОборудования.Ссылка
	|ГДЕ
	|	торо_АктПриемкиОборудованияРемонтыОборудования.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВЫБОР
	|		КОГДА торо_ОстановочныеРемонты.КорректируемыйДокумент = ЗНАЧЕНИЕ(Документ.торо_ОстановочныеРемонты.ПустаяСсылка)
	|			ТОГДА торо_ОстановочныеРемонты.ДокументОснование
	|		ИНАЧЕ торо_ОстановочныеРемонты.КорректируемыйДокумент
	|	КОНЕЦ,
	|	торо_ОстановочныеРемонты.Ссылка,
	|	торо_ОстановочныеРемонты.ДатаНачалаРемонта,
	|	торо_ОстановочныеРемонты.Проведен,
	|	торо_ОстановочныеРемонты.ПометкаУдаления
	|ИЗ
	|	Документ.торо_ОстановочныеРемонты КАК торо_ОстановочныеРемонты
	|ГДЕ
	|	торо_ОстановочныеРемонты.IDОсновногоРемонта = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_ОстановочныеРемонтыСвязанныеРемонты.ДокументИсточник,
	|	торо_ОстановочныеРемонтыСвязанныеРемонты.Ссылка,
	|	торо_ОстановочныеРемонтыСвязанныеРемонты.ДатаНачалаРемонта,
	|	торо_ОстановочныеРемонты.Проведен,
	|	торо_ОстановочныеРемонты.ПометкаУдаления
	|ИЗ
	|	Документ.торо_ОстановочныеРемонты.СвязанныеРемонты КАК торо_ОстановочныеРемонтыСвязанныеРемонты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_ОстановочныеРемонты КАК торо_ОстановочныеРемонты
	|		ПО торо_ОстановочныеРемонтыСвязанныеРемонты.Ссылка = торо_ОстановочныеРемонты.Ссылка
	|ГДЕ
	|	торо_ОстановочныеРемонтыСвязанныеРемонты.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЕСТЬNULL(торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеЗаявки.Заявка, НЕОПРЕДЕЛЕНО),
	|	торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеРемонты.Ссылка,
	|	ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0),
	|	торо_ЗакрытиеЗаявокИРемонтов.Проведен,
	|	торо_ЗакрытиеЗаявокИРемонтов.ПометкаУдаления
	|ИЗ
	|	Документ.торо_ЗакрытиеЗаявокИРемонтов.ЗакрываемыеРемонты КАК торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеРемонты
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ЗакрытиеЗаявокИРемонтов КАК торо_ЗакрытиеЗаявокИРемонтов
	|		ПО торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеРемонты.Ссылка = торо_ЗакрытиеЗаявокИРемонтов.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ЗакрытиеЗаявокИРемонтов.ЗакрываемыеЗаявки КАК торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеЗаявки
	|		ПО торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеРемонты.Ссылка = торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеЗаявки.Ссылка
	|ГДЕ
	|	торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеРемонты.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_ПланРаботПодразделенияСписокРемонтовПлана.ДокументОснование,
	|	торо_ПланРаботПодразделенияСписокРемонтовПлана.Ссылка,
	|	торо_ПланРаботПодразделенияСписокРемонтовПлана.ДатаНачала,
	|	торо_ПланРаботПодразделенияСписокРемонтовПлана.Ссылка.Проведен,
	|	торо_ПланРаботПодразделенияСписокРемонтовПлана.Ссылка.ПометкаУдаления
	|ИЗ
	|	Документ.торо_ПланРаботПодразделения.СписокРемонтовПлана КАК торо_ПланРаботПодразделенияСписокРемонтовПлана
	|ГДЕ
	|	торо_ПланРаботПодразделенияСписокРемонтовПлана.ID = &ID
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_ПроектныеЗатратыНаРемонты.ДокументИсточник,
	|	торо_ПроектныеЗатратыНаРемонты.Ссылка,
	|	ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0),
	|	торо_ПроектныеЗатратыНаРемонты.Проведен,
	|	торо_ПроектныеЗатратыНаРемонты.ПометкаУдаления
	|ИЗ
	|	Документ.торо_ПроектныеЗатратыНаРемонты КАК торо_ПроектныеЗатратыНаРемонты
	|ГДЕ
	|	торо_ПроектныеЗатратыНаРемонты.IDРемонта = &ID
	|
	|УПОРЯДОЧИТЬ ПО
	|	ДокументИсточник,
	|	Дата УБЫВ";
	
	МассивID = ОбщегоНазначения.ВыгрузитьКолонку(СписокID, "ID");
	ТаблицаПлановыхДат = торо_ПланированиеРемонтов.ПолучитьАктуальныеДатыРемонтов(МассивID);
	
	ТаблицаОбъектов = СписокID.Выгрузить(, "ОбъектРемонта");
	ТаблицаОбъектов.Свернуть("ОбъектРемонта");
	
	ШаблонСтрокиРемонта = "%1: %2 (%3)";
	ШаблонСтрокиРемонтаБезДаты = "%1: %2";
	
	Для Каждого СтрокаС_ID Из ТаблицаОбъектов Цикл
		ДобавляемаяСтрокаОбъект = СписокДокументовДерево.ПолучитьЭлементы().Добавить();
		ДобавляемаяСтрокаОбъект.Документ = СтрокаС_ID.ОбъектРемонта;
		ДобавляемаяСтрокаОбъект.Картинка = 6;
		ДобавляемаяСтрокаОбъект.ДокументТекст = ДобавляемаяСтрокаОбъект.Документ;
		ТаблицаРемонтов = СписокID.НайтиСтроки(Новый Структура("ОбъектРемонта", СтрокаС_ID.ОбъектРемонта));
		Для Каждого СтрокаСРемонтом Из ТаблицаРемонтов Цикл
			ДобавляемаяСтрокаРемонт = ДобавляемаяСтрокаОбъект.ПолучитьЭлементы().Добавить();
			ДобавляемаяСтрокаРемонт.Документ = СтрокаСРемонтом.ВидРемонта;
			ДобавляемаяСтрокаРемонт.Картинка = 7;
			ДобавляемаяСтрокаРемонт.ДатаПоДокументу = СтрокаСРемонтом.ДатаНачала;
			
			НайденнаяСтрокаДаты = ТаблицаПлановыхДат.Найти(СтрокаСРемонтом.ID, "IDРемонта");
			Если НайденнаяСтрокаДаты <> Неопределено Тогда
				ДобавляемаяСтрокаРемонт.ДатаТОиР = НайденнаяСтрокаДаты.ДатаНачала;
			КонецЕсли;
			
			Если ЗначениеЗаполнено(ДобавляемаяСтрокаРемонт.ДатаПоДокументу) Тогда
				ДобавляемаяСтрокаРемонт.ДокументТекст = СтрШаблон(ШаблонСтрокиРемонта, ДобавляемаяСтрокаРемонт.Документ, 
																				Формат(ДобавляемаяСтрокаРемонт.ДатаТОиР,"ДФ=dd.MM.yyyy"), 
																				Формат(ДобавляемаяСтрокаРемонт.ДатаПоДокументу,"ДФ=dd.MM.yyyy"));
			Иначе
				ДобавляемаяСтрокаРемонт.ДокументТекст = СтрШаблон(ШаблонСтрокиРемонтаБезДаты, ДобавляемаяСтрокаРемонт.Документ, 
																				Формат(ДобавляемаяСтрокаРемонт.ДатаТОиР,"ДФ=dd.MM.yyyy"));			
			КонецЕсли;
			
			Запрос.УстановитьПараметр("ID",СтрокаСРемонтом.ID);   
			ТаблицаДокументов = Запрос.Выполнить().Выгрузить();
			ТаблицаДокументов.Индексы.Добавить("ДокументИсточник");
			
			ПостроитьВетвьДереваПодчиненныхДокументов(ТаблицаДокументов, ДобавляемаяСтрокаРемонт, Неопределено);

			Если ID_Ремонта = СтрокаСРемонтом.ID Тогда
				ИдентификаторСтроки = ДобавляемаяСтрокаРемонт.ПолучитьИдентификатор();
				Элементы.СписокДокументов.Развернуть(ИдентификаторСтроки, Истина);
				Элементы.СписокДокументов.ТекущаяСтрока = ИдентификаторСтроки;
			КонецЕсли;
			
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ПостроитьВетвьДереваПодчиненныхДокументов(ТаблицаДокументов, КореньПоддерева, ЗначениеОтбора)
	
	МассивДляДобавления = ТаблицаДокументов.НайтиСтроки(Новый Структура("ДокументИсточник", ЗначениеОтбора));
	
	Для Каждого СтрокаДляДобавления Из МассивДляДобавления Цикл
		ДобавляемаяСтрокаДерева = КореньПоддерева.ПолучитьЭлементы().Добавить();
		
		ДобавляемаяСтрокаДерева.Документ 		= СтрокаДляДобавления.Ссылка;
		ДобавляемаяСтрокаДерева.Проведен 		= СтрокаДляДобавления.Проведен;
		ДобавляемаяСтрокаДерева.ПометкаУдаления = СтрокаДляДобавления.ПометкаУдаления;
		ДобавляемаяСтрокаДерева.ЯвляетсяДокументом = Истина;
		ДобавляемаяСтрокаДерева.Картинка = ПолучитьИндексКартинкиВКоллекции(ДобавляемаяСтрокаДерева);
		ДобавляемаяСтрокаДерева.ДокументТекст = ДобавляемаяСтрокаДерева.Документ;
		
		ПостроитьВетвьДереваПодчиненныхДокументов(ТаблицаДокументов, ДобавляемаяСтрокаДерева, СтрокаДляДобавления.Ссылка);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьИндексКартинкиВКоллекции(ДокументСтрока)
	
	Если ДокументСтрока.Проведен Тогда
		Возврат 1;
	ИначеЕсли ДокументСтрока.ПометкаУдаления Тогда
		Возврат 2;
	Иначе
		Возврат 0;
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	ЭлемУслОформ = УсловноеОформление.Элементы.Добавить();
	ЭлемУслОформ.Использование = Истина;
	
	ОтборУслОформления = ЭлемУслОформ.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборУслОформления.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборУслОформления.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("СписокДокументовДерево.Документ");
	ОтборУслОформления.ПравоеЗначение = Документ;
	ОтборУслОформления.Использование = Истина;
	
	ОформлениеУслОформления = ЭлемУслОформ.Оформление.Элементы[5];
	ОформлениеУслОформления.Использование = Истина;
	ОформлениеУслОформления.Значение = Новый Шрифт(,,Истина);
	
	ПолеУслОформления = ЭлемУслОформ.Поля.Элементы.Добавить();
	ПолеУслОформления.Использование = Истина;
	ПолеУслОформления.Поле = Новый ПолеКомпоновкиДанных("СписокДокументовДокументТекст");

КонецПроцедуры

&НаСервере
Функция ЗаписатьВыбранныйДокумент(РежимЗаписи, ДокументСсылка, ИдентификаторСтроки, ПометитьНаУдаление = Ложь)
	
	Если ДокументСсылка = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Попытка
		ДокОбъект = ДокументСсылка.ПолучитьОбъект();
		
		Если ПометитьНаУдаление Тогда
			ДокОбъект.УстановитьПометкуУдаления(Истина);
		Иначе
			Если ДокОбъект.ПометкаУдаления Тогда
			    ДокОбъект.УстановитьПометкуУдаления(Ложь);
			КонецЕсли;
			
			ДокОбъект.Записать(РежимЗаписи);
		КонецЕсли;
		
		СтрокаДерева = СписокДокументовДерево.НайтиПоИдентификатору(ИдентификаторСтроки);
		СтрокаДерева.Проведен = ДокОбъект.Проведен;
		СтрокаДерева.ПометкаУдаления = ДокОбъект.ПометкаУдаления;
	Исключение
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
	
КонецФункции

&НаКлиенте
Процедура СвернутьПодчиненные(Строка)
	
	Для каждого Стр Из Строка.ПолучитьЭлементы() Цикл
		СвернутьПодчиненные(Стр);
		Элементы.СписокДокументов.Свернуть(Стр.ПолучитьИдентификатор());
	КонецЦикла; 	
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьСостояниеДерева()
	
	Если Элементы.СписокДокументов.ТекущиеДанные <> Неопределено Тогда
		ТекущийДокумент = Элементы.СписокДокументов.ТекущиеДанные.ДокументТекст;
	КонецЕсли;

	Для Каждого СтрокаДерева Из СписокДокументовДерево.ПолучитьЭлементы() Цикл
		ПолучитьМассивРазвернутыхЭлементов(МассивРазвернутыхЭлементов,СтрокаДерева);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьМассивРазвернутыхЭлементов(МассивРазвернутыхЭлементов,Строка)
	     
	Если Элементы.СписокДокументов.Развернут(Строка.ПолучитьИдентификатор()) Тогда
		МассивРазвернутыхЭлементов.Добавить(Строка.Документ);
		Для Каждого СтрокаПодчиненная Из Строка.ПолучитьЭлементы() Цикл
			ПолучитьМассивРазвернутыхЭлементов(МассивРазвернутыхЭлементов,СтрокаПодчиненная);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВосстановитьСостояниеДерева()
	
	Для Каждого Строка Из СписокДокументовДерево.ПолучитьЭлементы() Цикл
		
		РазвернутьВетвиДерева(МассивРазвернутыхЭлементов,Строка);
				
	КонецЦикла;
	Элементы.СписокДокументов.ТекущаяСтрока = ИдентификаторТекущего;
	МассивРазвернутыхЭлементов.Очистить();
	
КонецПроцедуры

&НаКлиенте
Процедура РазвернутьВетвиДерева(МассивРазвернутыхЭлементов,СтрокаДерева)
	
	Если МассивРазвернутыхЭлементов.Найти(СтрокаДерева.Документ) <> Неопределено Тогда
		
		Элементы.СписокДокументов.Развернуть(СтрокаДерева.ПолучитьИдентификатор());
		Для Каждого СтрокаДереваПодчиненная Из СтрокаДерева.ПолучитьЭлементы() Цикл
		
			РазвернутьВетвиДерева(МассивРазвернутыхЭлементов,СтрокаДереваПодчиненная);
		
		КонецЦикла;
	КонецЕсли;
	
	Если СтрокаДерева.ДокументТекст = ТекущийДокумент Тогда
		ИдентификаторТекущего = СтрокаДерева.ПолучитьИдентификатор();
	КонецЕсли;
		
	
	
КонецПроцедуры

МассивРазвернутыхЭлементов = Новый Массив;

#КонецОбласти

