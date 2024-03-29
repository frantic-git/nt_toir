#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)

	Если ОбменДанными.Загрузка Или Не ПроведениеСервер.РассчитыватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;

	СтруктураВременныеТаблицы = ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы;
	БлокироватьДляИзменения = Истина;

	// Текущее состояние набора помещается во временную таблицу,
	// чтобы при записи получить изменение нового набора относительно текущего.

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ЭтоНовый",    ДополнительныеСвойства.ЭтоНовый);
	Запрос.МенеджерВременныхТаблиц = СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Таблица.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
	|	Таблица.Номенклатура                 КАК Номенклатура,
	|	Таблица.Характеристика               КАК Характеристика,
	|	Таблица.КодСтроки                    КАК КодСтроки,
	|	Таблица.Склад                        КАК Склад,
	|	ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|			Таблица.КОформлению
	|		ИНАЧЕ
	|			-Таблица.КОформлению
	|	КОНЕЦ                                КАК КОформлениюПередЗаписью
	|ПОМЕСТИТЬ ДвиженияЗаказыНаВнутреннееПотреблениеПередЗаписью
	|ИЗ
	|	РегистрНакопления.ЗаказыНаВнутреннееПотребление КАК Таблица
	|ГДЕ
	|	Таблица.Регистратор = &Регистратор
	|	И НЕ &ЭтоНовый
	|";
	Запрос.Выполнить();

КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)

	Если ОбменДанными.Загрузка Или Не ПроведениеСервер.РассчитыватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;

	СтруктураВременныеТаблицы = ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы;
	// Рассчитывается изменение нового набора относительно текущего с учетом накопленных изменений
	// и помещается во временную таблицу.
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.МенеджерВременныхТаблиц = СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаИзменений.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
	|	ТаблицаИзменений.Номенклатура                КАК Номенклатура,
	|	ТаблицаИзменений.Характеристика              КАК Характеристика,
	|	ТаблицаИзменений.КодСтроки                   КАК КодСтроки,
	|	ТаблицаИзменений.Склад                       КАК Склад,
	|	СУММА(ТаблицаИзменений.КОформлениюИзменение) КАК КОформлениюИзменение
	|ПОМЕСТИТЬ ДвиженияЗаказыНаВнутреннееПотреблениеИзменение
	|ИЗ
	|	(ВЫБРАТЬ
	|		Таблица.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
	|		Таблица.Номенклатура                 КАК Номенклатура,
	|		Таблица.Характеристика               КАК Характеристика,
	|		Таблица.КодСтроки                    КАК КодСтроки,
	|		Таблица.Склад                        КАК Склад,
	|		Таблица.КОформлениюПередЗаписью      КАК КОформлениюИзменение
	|	ИЗ
	|		ДвиженияЗаказыНаВнутреннееПотреблениеПередЗаписью КАК Таблица
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		Таблица.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
	|		Таблица.Номенклатура                 КАК Номенклатура,
	|		Таблица.Характеристика               КАК Характеристика,
	|		Таблица.КодСтроки                    КАК КодСтроки,
	|		Таблица.Склад                        КАК Склад,
	|		ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|				-Таблица.КОформлению
	|			ИНАЧЕ
	|				Таблица.КОформлению
	|		КОНЕЦ                                КАК КОформлениюИзменение
	|	ИЗ
	|		РегистрНакопления.ЗаказыНаВнутреннееПотребление КАК Таблица
	|	ГДЕ
	|		Таблица.Регистратор = &Регистратор) КАК ТаблицаИзменений
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаИзменений.ЗаказНаВнутреннееПотребление,
	|	ТаблицаИзменений.Номенклатура,
	|	ТаблицаИзменений.Характеристика,
	|	ТаблицаИзменений.КодСтроки,
	|	ТаблицаИзменений.Склад
	|
	|ИМЕЮЩИЕ
	|	СУММА(ТаблицаИзменений.КОформлениюИзменение) > 0
	|;
	|УНИЧТОЖИТЬ ДвиженияЗаказыНаВнутреннееПотреблениеПередЗаписью
	|";
	Выборка = Запрос.ВыполнитьПакет()[0].Выбрать();
	Выборка.Следующий();
	
	// Новые изменения были помещены во временную таблицу.
	// Добавляется информация о ее существовании и наличии в ней записей об изменении.
	СтруктураВременныеТаблицы.Вставить("ДвиженияЗаказыНаВнутреннееПотреблениеИзменение", Выборка.Количество > 0);

КонецПроцедуры

#КонецОбласти

#КонецЕсли