#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

// См. ЗапретРедактированияРеквизитовОбъектовПереопределяемый.ПриОпределенииОбъектовСЗаблокированнымиРеквизитами.
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт
	Результат = Новый Массив;
	Результат.Добавить("Коэффициент");
	Результат.Добавить("ЕдиницаИзмерения");
	Результат.Добавить("Родитель");
	Результат.Добавить("КоличествоУпаковок");
	Результат.Добавить("СостоитИзДругихУпаковок");
	Возврат Результат;
КонецФункции

// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

// Заполняет список выбора упаковок по параметрам выбора, предварительно список очищается.
// Пример вызова из обработчиков форм:
//	Справочники.УпаковкиНоменклатуры.ЗаполнитьСписокВыбора(Элементы.Упаковка.СписокВыбора,
//		Новый Структура("Номенклатура, ДобавлятьПустуюУпаковку", Объект.Номенклатура, Истина));
//
// Параметры:
//	 СписокВыбора - СписокЗначений - список значений выбора.
//	 ПараметрыВыбора - Структура - структура параметров.
//
Процедура ЗаполнитьСписокВыбора(СписокВыбора, ПараметрыВыбора) Экспорт
	СписокВыбора.Очистить();
	Для Каждого ЭлементВыбора Из Справочники.УпаковкиНоменклатуры.ПолучитьДанныеВыбора(ПараметрыВыбора) Цикл
		СписокВыбора.Добавить(ЭлементВыбора.Значение, ЭлементВыбора.Представление, ЭлементВыбора.Пометка, ЭлементВыбора.Картинка);
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий
Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ДанныеВыбора = Новый СписокЗначений;
	
	Если Параметры.Свойство("ВыборРодителя") Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст =
		"ВЫБРАТЬ
		|	УпаковкиНоменклатуры.Ссылка КАК Упаковка,
		|	ПРЕДСТАВЛЕНИЕ(УпаковкиНоменклатуры.Ссылка) КАК УпаковкаПредставление
		|ИЗ
		|	Справочник.УпаковкиНоменклатуры КАК УпаковкиНоменклатуры
		|ГДЕ
		|	УпаковкиНоменклатуры.Ссылка <> &Ссылка
		|	И УпаковкиНоменклатуры.Владелец = &Владелец
		|
		|УПОРЯДОЧИТЬ ПО
		|	Наименование";
		
		Запрос.УстановитьПараметр("Владелец", Параметры.Владелец);
		Запрос.УстановитьПараметр("Ссылка", Параметры.Ссылка);
		
		Выборка = Запрос.Выполнить().Выбрать();
		
		Пока Выборка.Следующий() Цикл
			ДанныеВыбора.Добавить(Выборка.Упаковка, Выборка.УпаковкаПредставление);
		КонецЦикла;
		
	Иначе
		
		Номенклатура = Неопределено;
		
		Если Не Параметры.Свойство("Номенклатура", Номенклатура) Тогда
			Возврат;
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Номенклатура) Тогда
			Возврат;
		КонецЕсли;
		
		Если Параметры.Свойство("ДобавлятьПустуюУпаковку") Тогда
			ДобавлятьПустуюУпаковку = Параметры.ДобавлятьПустуюУпаковку;	
		Иначе
			ДобавлятьПустуюУпаковку = Истина;
		КонецЕсли;
		
		ПолучитьСписокДляВыбораУпаковок(Номенклатура, ДанныеВыбора, Параметры.СтрокаПоиска, ДобавлятьПустуюУпаковку);
		
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
Функция СформироватьНаименование(ЕдиницаИзмерения, Коэффициент, ЕдиницаИзмеренияВладельца) Экспорт
	Возврат СокрЛП(СокрЛП(ЕдиницаИзмерения) + " (" + Формат(Коэффициент,"ЧРД=.") + " " + СокрЛП(ЕдиницаИзмеренияВладельца) + ")");
КонецФункции

Процедура ПолучитьСписокДляВыбораУпаковок(Номенклатура, ДанныеВыбора, СтрокаПоиска, Знач ДобавлятьПустуюУпаковку)

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	СпрНоменклатура.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	ПРЕДСТАВЛЕНИЕ(СпрНоменклатура.ЕдиницаИзмерения) КАК ЕдиницаИзмеренияПредставление,
	|	ЕСТЬNULL(СпрУпаковки.Ссылка, НЕОПРЕДЕЛЕНО) КАК Упаковка,
	|	ПРЕДСТАВЛЕНИЕ(СпрУпаковки.Ссылка) КАК УпаковкаПредставление,
	|	ЕСТЬNULL(СпрУпаковки.ЕдиницаИзмерения, НЕОПРЕДЕЛЕНО) КАК ЕдиницаИзмеренияУпаковки,
	|	ЕСТЬNULL(СпрУпаковки.ЕдиницаИзмерения.Представление,"""") КАК ЕдиницаИзмеренияУпаковкиПредставление,
	|	ЕСТЬNULL(СпрУпаковки.Коэффициент,0) КАК Коэффициент
	|ИЗ
	|	Справочник.Номенклатура КАК СпрНоменклатура
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.УпаковкиНоменклатуры КАК СпрУпаковки
	|		ПО СпрУпаковки.Владелец = СпрНоменклатура.Ссылка
	|			" + ?(СтрокаПоиска = Неопределено, "", "И СпрУпаковки.Наименование ПОДОБНО &СтрокаПоиска") + "
	|   		И НЕ СпрУпаковки.ПометкаУдаления
	|
	|ГДЕ
	|	СпрНоменклатура.Ссылка = &Номенклатура
	|
	|УПОРЯДОЧИТЬ ПО
	|	Коэффициент,
	|	ЕдиницаИзмеренияУпаковкиПредставление";

	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);

	Если СтрокаПоиска <> Неопределено Тогда
		Запрос.УстановитьПараметр("СтрокаПоиска", СтрокаПоиска + "%");
	КонецЕсли;
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	ЕдиницаХраненияПредставление = "";
	ЕстьЕдиничнаяУпаковка = Ложь;
	
	Пока Выборка.Следующий() Цикл
		
		ЕдиницаХраненияПредставление = Выборка.ЕдиницаИзмеренияПредставление; 
		
		Если Выборка.Упаковка <> Неопределено Тогда
			Если Выборка.Коэффициент = 1
				И Выборка.ЕдиницаИзмеренияУпаковки = Выборка.ЕдиницаИзмерения Тогда
				ДанныеВыбора.Добавить(Выборка.Упаковка, Выборка.УпаковкаПредставление, Истина);
				ЕстьЕдиничнаяУпаковка = Истина;
			Иначе
				ДанныеВыбора.Добавить(Выборка.Упаковка, Выборка.УпаковкаПредставление, Ложь);
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;

	Если ДобавлятьПустуюУпаковку
		И Не ЕстьЕдиничнаяУпаковка Тогда
		ДанныеВыбора.Вставить(0,Справочники.УпаковкиНоменклатуры.ПустаяСсылка(), ЕдиницаХраненияПредставление)
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли