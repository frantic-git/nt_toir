#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	МультиязычностьСервер.ПриСозданииНаСервере(ЭтотОбъект);
	
	Если ЗначениеЗаполнено(Параметры.ДатаОтбора) Тогда 
		ДатаОтбора = Параметры.ДатаОтбора;
		Список.ТекстЗапроса = "ВЫБРАТЬ
		                       |	торо_ВерсииТехКартСрезПоследних.ИдентификаторТехКарты КАК ИдентификаторТехКарты,
		                       |	торо_ВерсииТехКартСрезПоследних.ТехКарта КАК ТехКарта
		                       |ПОМЕСТИТЬ ВерсииНаДату
		                       |ИЗ
		                       |	РегистрСведений.торо_ВерсииТехКарт.СрезПоследних(&ДатаОтбора, ) КАК торо_ВерсииТехКартСрезПоследних
		                       |;
		                       |
		                       |////////////////////////////////////////////////////////////////////////////////
		                       |ВЫБРАТЬ
		                       |	ВерсииНаДату.ИдентификаторТехКарты КАК ИдентификаторТехКарты,
		                       |	ВерсииНаДату.ТехКарта КАК ТехКарта
		                       |ПОМЕСТИТЬ АктуальныеТКНаДату
		                       |ИЗ
		                       |	ВерсииНаДату КАК ВерсииНаДату
		                       |
		                       |ОБЪЕДИНИТЬ ВСЕ
		                       |
		                       |ВЫБРАТЬ
		                       |	ВерсииСтаршеДатыОтбора.ИдентификаторТехКарты,
		                       |	ВерсииСтаршеДатыОтбора.ТехКарта
		                       |ИЗ
		                       |	РегистрСведений.торо_ВерсииТехКарт.СрезПервых(
		                       |			&ДатаОтбора,
		                       |			НЕ ИдентификаторТехКарты В
		                       |					(ВЫБРАТЬ
		                       |						ВерсииНаДату.ИдентификаторТехКарты
		                       |					ИЗ
		                       |						ВерсииНаДату)) КАК ВерсииСтаршеДатыОтбора
		                       |;
		                       |
		                       |////////////////////////////////////////////////////////////////////////////////
		                       |ВЫБРАТЬ
		                       |	Справочникторо_ИдентификаторыТехКарт.Ссылка КАК Ссылка,
		                       |	Справочникторо_ИдентификаторыТехКарт.ПометкаУдаления КАК ПометкаУдаления,
		                       |	Справочникторо_ИдентификаторыТехКарт.Родитель КАК Родитель,
		                       |	Справочникторо_ИдентификаторыТехКарт.ЭтоГруппа КАК ЭтоГруппа,
		                       |	Справочникторо_ИдентификаторыТехКарт.Код КАК Код,
		                       |	Справочникторо_ИдентификаторыТехКарт.Наименование КАК Наименование,
		                       |	Справочникторо_ИдентификаторыТехКарт.Предопределенный КАК Предопределенный,
		                       |	Справочникторо_ИдентификаторыТехКарт.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных,
		                       |	Справочникторо_ИдентификаторыТехКарт.Статус КАК Статус,
		                       |	ЕСТЬNULL(АктуальныеТК.ТехКарта, ЗНАЧЕНИЕ(Справочник.торо_ТехКарты.ПустаяСсылка)) КАК ТехКарта,
		                       |	ЕСТЬNULL(АктуальныеТК.ТехКарта.СодержитОпасныеОперации, ЛОЖЬ) КАК СодержитОпасныеОперации,
		                       |	ЕСТЬNULL(АктуальныеТК.ТехКарта.СодержитРаботыПовышеннойОпасности, ЛОЖЬ) КАК СодержитРаботыПовышеннойОпасности,
		                       |	ЕСТЬNULL(АктуальныеТК.ТехКарта.НормаВремениТекст, """") КАК НормаВремени,
		                       |	ЕСТЬNULL(АктуальныеТК.ТехКарта.Комментарий, """") КАК Комментарий,
		                       |	ЕСТЬNULL(АктуальныеТК.ТехКарта.ДатаПринятия, ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)) КАК ДатаПринятия,
		                       |	ЕСТЬNULL(АктуальныеТК.ТехКарта.ВыполнениеРемонтаТребуетОстановаОборудования, ЛОЖЬ) КАК ВыполнениеРемонтаТребуетОстановаОборудования,
		                       |	ЕСТЬNULL(АктуальныеТК.ТехКарта.ВремяПростояТекст, """") КАК ВремяПростоя,
		                       |	ЕСТЬNULL(АктуальныеТК.ТехКарта.ВидПростоя, ЗНАЧЕНИЕ(Справочник.торо_ВидыЭксплуатации.ПустаяСсылка)) КАК ВидПростоя
		                       |ИЗ
		                       |	Справочник.торо_ИдентификаторыТехКарт КАК Справочникторо_ИдентификаторыТехКарт
		                       |		ЛЕВОЕ СОЕДИНЕНИЕ АктуальныеТКНаДату КАК АктуальныеТК
		                       |		ПО (АктуальныеТК.ИдентификаторТехКарты = Справочникторо_ИдентификаторыТехКарт.Ссылка)";
		Список.Параметры.УстановитьЗначениеПараметра("ДатаОтбора", ДатаОтбора);	
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура СоздатьТехКарту(Команда)
	
	ТекущиеДанные =  Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		ОткрытьФорму("Справочник.торо_ИдентификаторыТехКарт.Форма.ФормаГруппы", Новый Структура("Родитель", ПредопределенноеЗначение("Справочник.торо_ИдентификаторыТехКарт.ПустаяСсылка")), ЭтаФорма);
		Возврат;
	КонецЕсли;
	
	Родитель = ?(ТекущиеДанные.ЭтоГруппа, ТекущиеДанные.Ссылка, ТекущиеДанные.Родитель);
	
	Форма = ОткрытьФорму("Справочник.торо_ИдентификаторыТехКарт.Форма.ФормаЭлемента", Новый Структура("Родитель", Родитель), ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьГруппу(Команда)

	ТекущиеДанные =  Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		ОткрытьФорму("Справочник.торо_ИдентификаторыТехКарт.Форма.ФормаГруппы", Новый Структура("ЭтоГруппа, Родитель", Истина, ПредопределенноеЗначение("Справочник.торо_ИдентификаторыТехКарт.ПустаяСсылка")), ЭтаФорма);
		Возврат;
	КонецЕсли;
	
	Родитель = ?(ТекущиеДанные.ЭтоГруппа, ТекущиеДанные.Ссылка, ТекущиеДанные.Родитель);
	
	Форма = ОткрытьФорму("Справочник.торо_ИдентификаторыТехКарт.Форма.ФормаГруппы", Новый Структура("ЭтоГруппа, Родитель", Истина, Родитель), ЭтаФорма);		
	
КонецПроцедуры

&НаКлиенте
Процедура Изменить(Команда)
	
	ТекДанные = Элементы.Список.ТекущиеДанные;	
	Если НЕ ТекДанные = Неопределено Тогда
		Если ТекДанные.ЭтоГруппа Тогда
			ПоказатьЗначение(Неопределено,ТекДанные.Ссылка);
		Иначе
			ПоказатьЗначение(Неопределено,ТекДанные.Ссылка);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	Если ЗначениеЗаполнено(ДатаОтбора) Тогда 
		Если ТипЗнч(Значение) = Тип("Массив") И Значение.Количество() > 1 Тогда 
			ПроверитьДатуНаСервере(Значение, СтандартнаяОбработка);
		ИначеЕсли Элемент.ТекущиеДанные.ДатаПринятия > ДатаОтбора Тогда
			ОбщегоНазначенияКлиент.СообщитьПользователю(СтрШаблон(НСтр("ru = 'Дата принятия карты «%1» %2 больше %3'"), 
				Элемент.ТекущиеДанные.Наименование, Формат(Элемент.ТекущиеДанные.ДатаПринятия, "ДФ=dd.MM.yyyy"), Формат(ДатаОтбора, "ДФ=dd.MM.yyyy"))); 
			СтандартнаяОбработка = Ложь;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПроверитьДатуНаСервере(ВыбранныеСтроки, СтандартнаяОбработка)
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	торо_ВерсииТехКартСрезПоследних.ИдентификаторТехКарты КАК ИдентификаторТехКарты,
	               |	торо_ВерсииТехКартСрезПоследних.Период КАК Период
	               |ПОМЕСТИТЬ ВерсииТКНаДату
	               |ИЗ
	               |	РегистрСведений.торо_ВерсииТехКарт.СрезПоследних(&ДатаДокумента, ИдентификаторТехКарты В (&СписокИД)) КАК торо_ВерсииТехКартСрезПоследних
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	торо_ВерсииТехКартСрезПервых.ИдентификаторТехКарты КАК ИдентификаторТехКарты,
	               |	торо_ВерсииТехКартСрезПервых.Период КАК Период
	               |ИЗ
	               |	РегистрСведений.торо_ВерсииТехКарт.СрезПервых(
	               |			&ДатаДокумента,
	               |			ИдентификаторТехКарты В (&СписокИД)
	               |				И НЕ ИдентификаторТехКарты В
	               |						(ВЫБРАТЬ
	               |							ВерсииТКНаДату.ИдентификаторТехКарты
	               |						ИЗ
	               |							ВерсииТКНаДату)) КАК торо_ВерсииТехКартСрезПервых
	               |ГДЕ
	               |	торо_ВерсииТехКартСрезПервых.Период > &ДатаДокумента
	               |
	               |ОБЪЕДИНИТЬ ВСЕ
	               |
	               |ВЫБРАТЬ
	               |	ВерсииТКНаДату.ИдентификаторТехКарты,
	               |	ВерсииТКНаДату.Период
	               |ИЗ
	               |	ВерсииТКНаДату КАК ВерсииТКНаДату
	               |ГДЕ
	               |	ВерсииТКНаДату.Период > &ДатаДокумента";
	Запрос.УстановитьПараметр("ДатаДокумента", ДатаОтбора);
	Запрос.УстановитьПараметр("СписокИД", ВыбранныеСтроки);
	РезЗапроса = Запрос.Выполнить();
	Если НЕ РезЗапроса.Пустой() Тогда
		Выборка = РезЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл 
			ОбщегоНазначения.СообщитьПользователю(СтрШаблон(НСтр("ru = 'Дата принятия карты «%1» %2 больше %3'"), 
				Выборка.ИдентификаторТехКарты, Формат(Выборка.Период, "ДФ=dd.MM.yyyy"), Формат(ДатаОтбора, "ДФ=dd.MM.yyyy")));
			СтандартнаяОбработка = Ложь;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти
