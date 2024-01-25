
#Область ОбработчикиСобытий
	
&После("ОбработкаПроведения")
Процедура проф_ОбработкаПроведения(Отказ, РежимПроведения)
	
	//++ Проф-ИТ, #27, Соловьев А.А., 25.08.2023
	Если Отказ Тогда 
		Возврат;
	КонецЕсли;	
	
	ФОИспользоватьСерии = Константы.ИспользоватьСерииНоменклатуры.Получить();
	ФОИспользоватьХарактеристики = Константы.торо_ИспользоватьХарактеристикиНоменклатуры.Получить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	торо_ВозвратТоваровНаСклад.Дата КАК Период,
	|	торо_ВозвратТоваровНаСклад.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) КАК ВидДвижения,
	|	ТабличнаяЧасть.Номенклатура КАК Номенклатура,
	|	ВЫБОР
	|		КОГДА &ФОИспользоватьХарактеристики
	|			ТОГДА ТабличнаяЧасть.Характеристика 
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.ХарактеристикиНоменклатуры.ПустаяСсылка)
	|	КОНЕЦ КАК Характеристика,
	|	ВЫБОР
	|		КОГДА &ФОИспользоватьСерии
	|			ТОГДА ТабличнаяЧасть.Серия
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка)
	|	КОНЕЦ КАК Серия,
	|	ТабличнаяЧасть.Склад КАК Склад,
	|	ТабличнаяЧасть.проф_Назначение КАК Назначение,
	|	СУММА(ТабличнаяЧасть.Количество) КАК Количество
	|ИЗ 
	|	Документ.торо_ВозвратТоваровНаСклад КАК торо_ВозвратТоваровНаСклад
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_ВозвратТоваровНаСклад.Товары КАК ТабличнаяЧасть 
	|		ПО торо_ВозвратТоваровНаСклад.Ссылка = ТабличнаяЧасть.Ссылка
	|ГДЕ
	|	торо_ВозвратТоваровНаСклад.Ссылка = &Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	торо_ВозвратТоваровНаСклад.Дата,
	|	торо_ВозвратТоваровНаСклад.ЗаказНаВнутреннееПотребление,
	|	ТабличнаяЧасть.Номенклатура,
	|	ТабличнаяЧасть.Характеристика,
	|	ТабличнаяЧасть.Серия,
	|	ТабличнаяЧасть.Склад,
	|	ТабличнаяЧасть.проф_Назначение";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("ФОИспользоватьХарактеристики", ФОИспользоватьХарактеристики);
	Запрос.УстановитьПараметр("ФОИспользоватьСерии", ФОИспользоватьСерии);
	Запрос.УстановитьПараметр("Дата", ТекущаяДатаСеанса());
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда 
		Возврат;
	КонецЕсли;	

	Движения.проф_ТоварыНаСкладах.Записывать = Истина;
	
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		Движение = Движения.проф_ТоварыНаСкладах.Добавить();
		ЗаполнитьЗначенияСвойств(Движение, Выборка);
	КонецЦикла;
	//-- Проф-ИТ, #27, Соловьев А.А., 25.08.2023
	
КонецПроцедуры

#КонецОбласти