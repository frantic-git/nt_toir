#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("ДатаНачалаПланирования") Тогда
	    ДатаНачалаПланирования = Параметры.ДатаНачалаПланирования;
	Иначе
		Возврат;
	КонецЕсли;
	
	Если Параметры.Свойство("ПериодичностьДетализации") Тогда
	    ПериодичностьДетализации = Параметры.ПериодичностьДетализации;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	РассчитатьКоличествоПериодов();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПеренестиВДокумент(Команда)
	Если Не ПроверитьВозможностьПереносаДанныхВДокумент() Тогда
	    Возврат;
	КонецЕсли;
	
	СтруктураВозврата = Новый Структура("КоличествоПериодов, ПериодичностьДетализации", КоличествоПериодов, ПериодичностьДетализации);
	ОповеститьОВыборе(СтруктураВозврата);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВидДатыОкончанияПриИзменении(Элемент)
	РассчитатьДатуОкончания();
	РассчитатьКоличествоПериодов();
КонецПроцедуры

&НаКлиенте
Процедура ПериодичностьДетализацииПриИзменении(Элемент)
	РассчитатьКоличествоПериодов();
КонецПроцедуры

&НаКлиенте
Процедура ДатаОкончанияПланированияПриИзменении(Элемент)
	ДатаОкончанияПланирования = КонецДня(ДатаОкончанияПланирования);
	РассчитатьКоличествоПериодов();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция ПроверитьВозможностьПереносаДанныхВДокумент()
	Если Не РасчетВыполнен Тогда
		ТекстСообщения = НСтр("ru = 'Количество периодов не было рассчитано!'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат Ложь;
	ИначеЕсли Не ДатаОкончанияПланирования = ДатаОкончанияПланированияПослеРасчета Тогда
		ТекстСообщения = НСтр("ru = 'Рассчитанная и указанная даты окончания планирования не совпадают!'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
КонецФункции

&НаКлиенте
Функция ПроверитьВозможностьРасчетаКоличестваПериодов()
	Если ЗначениеЗаполнено(ПериодичностьДетализации) И ЗначениеЗаполнено(ВидДатыОкончания)
		И ЗначениеЗаполнено(ДатаОкончанияПланирования) Тогда
	    Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
КонецФункции

&НаКлиенте
Функция ОбязательныеПроверкиПередРасчетомКоличестваПериодов()
	Если Не ПроверитьВозможностьРасчетаКоличестваПериодов() Тогда
		УстановитьОформлениеФормы(Ложь, Ложь);
		Возврат Ложь;
	ИначеЕсли ДатаНачалаПланирования > ДатаОкончанияПланирования Тогда
		ТекстСообщения = НСтр("ru = 'Дата начала планирования больше даты окончания! Расчет количества периодов не может быть выполнен.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		УстановитьОформлениеФормы(Ложь, Ложь);
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
КонецФункции

&НаКлиенте
Процедура РассчитатьДатуОкончания()
	Если Не ЗначениеЗаполнено(ВидДатыОкончания) Или Не ВидДатыОкончания = "Произвольная дата" Тогда
	    Элементы.ДатаОкончанияПланирования.ТолькоПросмотр = Истина;
		ШаблонФормулыРассчетаДатыОкончания = "%1(ДатаНачалаПланирования)";
		ФормулаРассчетаДатыОкончания = СтрШаблон(ШаблонФормулыРассчетаДатыОкончания, СтрЗаменить(ВидДатыОкончания, " ", ""));
		ДатаОкончанияПланирования = Вычислить(ФормулаРассчетаДатыОкончания);
	Иначе
		Элементы.ДатаОкончанияПланирования.ТолькоПросмотр = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьКоличествоПериодов()
	РасчетВыполнен = Ложь;
	КоличествоПериодов = 0;
	Если Не ОбязательныеПроверкиПередРасчетомКоличестваПериодов() Тогда
		Возврат;
	КонецЕсли;
	
	ОдинДень = 60 * 60 * 24;
	Если ПериодичностьДетализации = ПредопределенноеЗначение("Перечисление.Периодичность.День") Тогда
		КоличествоПериодов = (ДатаОкончанияПланирования - ДатаНачалаПланирования) / ОдинДень;
		ДатаОкончанияПланированияПослеРасчета = ДатаОкончанияПланирования;
	ИначеЕсли ПериодичностьДетализации = ПредопределенноеЗначение("Перечисление.Периодичность.Неделя") Тогда
		КоличествоПериодов = 1;
		ДатаОкончанияПланированияПослеРасчета = ДатаНачалаПланирования + 7 * ОдинДень;
		Пока ДатаОкончанияПланированияПослеРасчета <= ДатаОкончанияПланирования Цикл
			КоличествоПериодов = КоличествоПериодов + 1;
			ДатаОкончанияПланированияПослеРасчета = ДатаОкончанияПланированияПослеРасчета + 7 * ОдинДень;
		КонецЦикла;
	ИначеЕсли ПериодичностьДетализации = ПредопределенноеЗначение("Перечисление.Периодичность.Декада") Тогда
		// Дата начала декады даты начала планирования
		ДеньМесяцаДатыПланирования = День(ДатаНачалаПланирования);
		Если ДеньМесяцаДатыПланирования <= 10 Тогда
			НомерДекадыДатыНачала = 1;
		ИначеЕсли ДеньМесяцаДатыПланирования <= 20 Тогда
			НомерДекадыДатыНачала = 2;
		Иначе
			НомерДекадыДатыНачала = 3;
		КонецЕсли;
		
		// Декады считаются от начала месяца как при расчете даты окончания планирования при расчете ППР.
		НачалоДекадыДатыНачала = НачалоМесяца(ДатаНачалаПланирования) + (НомерДекадыДатыНачала - 1) * 10 * ОдинДень;
		
		// Дата окончания декады даты окончания планирования
		ДеньМесяцаДатыОкончания = День(ДатаОкончанияПланирования);
		Если ДеньМесяцаДатыОкончания <= 10 Тогда
			НомерДекадыДатыОкончания = 1;
		ИначеЕсли ДеньМесяцаДатыОкончания <= 20 Тогда
			НомерДекадыДатыОкончания = 2;
		Иначе
			НомерДекадыДатыОкончания = 3;
		КонецЕсли;
		
		// Если декада третья, то ее дата окончания - конец месяца (т.к. в разных месяцах она может быть
		// от 28 до 31, необходимо отдельно вычислить), для 1-й и 2-й декад - 10 и 20 числа соответственно.
		Если НомерДекадыДатыОкончания = 1 Или НомерДекадыДатыОкончания = 2 Тогда
		    КонецДекадыДатыОкончания = НачалоМесяца(ДатаОкончанияПланирования) + НомерДекадыДатыОкончания * 10 * ОдинДень - ОдинДень;
		Иначе
			КонецДекадыДатыОкончания = КонецМесяца(ДатаОкончанияПланирования);
		КонецЕсли;
		
		//
		ДатаОкончанияПланированияПослеРасчета = КонецДня(КонецДекадыДатыОкончания);
		
		// Сначала рассчитываем количество целых месяцев между датами, а потом добавляем нужное
		// количество декад из месяцев дат начала и окончания. Для этого в качестве месяца даты начала
		// берем следующий после месяца даты начала (если дата окончания находится в следующем за
		// датой начала месяце, то разность как раз будет равна 0). При определении года даты начала
		// аналогично добавляется месяц для случая, когда месяц декабрь (чтобы получить следующий год,
		// т.к. в качестве месяца даты начала уже взяли январь).
		МесяцДатыНачала = Месяц(ДобавитьМесяц(ДатаНачалаПланирования, 1));
		МесяцДатыОкончания = Месяц(ДатаОкончанияПланированияПослеРасчета);
		ЛетМеждуДатами = Год(ДатаОкончанияПланированияПослеРасчета) - Год(ДобавитьМесяц(ДатаНачалаПланирования, 1));
		РезультатВМесяцах = ЛетМеждуДатами * 12 - МесяцДатыНачала + МесяцДатыОкончания;
		
		КоличествоПериодов = РезультатВМесяцах * 3 + НомерДекадыДатыОкончания + (4 - НомерДекадыДатыНачала);
	Иначе
		Если ПериодичностьДетализации = ПредопределенноеЗначение("Перечисление.Периодичность.Месяц") Тогда
		    ЧислоМесяцев = 1;
		ИначеЕсли ПериодичностьДетализации = ПредопределенноеЗначение("Перечисление.Периодичность.Квартал") Тогда
		    ЧислоМесяцев = 3;
		ИначеЕсли ПериодичностьДетализации = ПредопределенноеЗначение("Перечисление.Периодичность.Полугодие") Тогда
		    ЧислоМесяцев = 6;
		ИначеЕсли ПериодичностьДетализации = ПредопределенноеЗначение("Перечисление.Периодичность.Год") Тогда
		    ЧислоМесяцев = 12;
		КонецЕсли;
		
		КоличествоПериодов = 1;
		ДатаОкончанияПланированияПослеРасчета = ДобавитьМесяц(ДатаНачалаПланирования, ЧислоМесяцев);
		Пока ДатаОкончанияПланированияПослеРасчета <= ДатаОкончанияПланирования Цикл
			КоличествоПериодов = КоличествоПериодов + 1;
			ДатаОкончанияПланированияПослеРасчета = ДобавитьМесяц(ДатаОкончанияПланированияПослеРасчета, ЧислоМесяцев);
		КонецЦикла;
	КонецЕсли;
	
	// Под датой окончания подразумеваем конец дня. Поэтому в качестве рассчитанной даты окончания берем
	// конец предыдущего дня (т.к. после расчета она будет равна дате начала следующего периода), кроме случаев
	// детализации День и Декада. Для них дата не рассчитывается, а берется конкретное число (для дня это 
	// ДатаОкончанияПланирования, для декады - конец дня 10-го, 20-го чисел или конец месяца, соответствующие
	// декаде даты окончания планирования).
	Если Не ПериодичностьДетализации = ПредопределенноеЗначение("Перечисление.Периодичность.День")
		И Не ПериодичностьДетализации = ПредопределенноеЗначение("Перечисление.Периодичность.Декада") Тогда
	    ДатаОкончанияПланированияПослеРасчета = КонецДня(ДатаОкончанияПланированияПослеРасчета - ОдинДень);
	КонецЕсли;
	
	РасчетВыполнен = Истина;
	
	Если Не ДатаОкончанияПланированияПослеРасчета = ДатаОкончанияПланирования Тогда
	    УстановитьОформлениеФормы(Истина, Ложь);
	Иначе
		УстановитьОформлениеФормы();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОформлениеФормы(РезультатРасчитан = Истина, Успешно = Истина)
	Если Не РезультатРасчитан Тогда
	    Элементы.КоличествоПериодов.Видимость = Ложь;
		Элементы.ДекорацияОписаниеРезультатаУспешно.Видимость = Ложь;
		Элементы.ДекорацияОписаниеРезультатаОшибка.Видимость = Ложь;
		Элементы.ДекорацияЗаголовок.ЦветТекста = Новый Цвет(51, 51, 51);
		Возврат;
	КонецЕсли;
	
	Элементы.КоличествоПериодов.Видимость = Истина;
	Если Успешно Тогда
	    Элементы.ДекорацияОписаниеРезультатаУспешно.Видимость = Истина;
		Элементы.ДекорацияОписаниеРезультатаОшибка.Видимость = Ложь;
		Элементы.КоличествоПериодов.ЦветТекста = Новый Цвет(0, 150, 70);
		Элементы.ДекорацияЗаголовок.ЦветТекста = Новый Цвет(0, 150, 70);
	Иначе
		Элементы.ДекорацияОписаниеРезультатаУспешно.Видимость = Ложь;
		Элементы.ДекорацияОписаниеРезультатаОшибка.Видимость = Истина;
		Элементы.КоличествоПериодов.ЦветТекста = Новый Цвет(250, 0, 0);
		Элементы.ДекорацияЗаголовок.ЦветТекста = Новый Цвет(250, 0, 0);
		
		ШаблонОписанияРезультата = НСтр("ru = 'Рассчитанная дата окончания планирования (%1) не совпадает с заданной. Попробуйте изменить периодичность детализации'");
		ТекстОписанияРезультата = СтрШаблон(ШаблонОписанияРезультата, ДатаОкончанияПланированияПослеРасчета);
		Элементы.ДекорацияОписаниеРезультатаОшибка.Заголовок = ТекстОписанияРезультата;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти