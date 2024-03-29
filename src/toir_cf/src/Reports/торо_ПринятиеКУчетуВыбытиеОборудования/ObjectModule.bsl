#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	ТекИерархия = торо_ОтчетыСервер.ПолучитьЗначениеСтруктурыИерархии(КомпоновщикНастроек);
	
	торо_ОтчетыСервер.УстановитьЗапросыНаборовДанныхИерархииОР(СхемаКомпоновкиДанных, ТекИерархия, "ДатаОкончания");
	
	Если ТекИерархия.СтроитсяАвтоматически Тогда
				
		СхемаКомпоновкиДанных.НаборыДанных.Объекты.Запрос =
		ПолучитьСодержательнуюЧастьЗапроса()+
		"ВЫБРАТЬ
		|	ВТ_Данные.ОбъектРемонта КАК ОбъектРемонта,
		|	ВТ_Данные.ДатаПринятия КАК ДатаПринятия,
		|	ВТ_Данные.ДокументПринятия КАК ДокументПринятия,
		|	ВТ_Данные.ДатаСнятияСУчета КАК ДатаСнятияСУчета,
		|	ВТ_Данные.ДокументСнятияСУчета КАК ДокументСнятияСУчета,
		|	ВТ_Данные.ОбъектРемонта." + ТекИерархия.РеквизитОР + " КАК ОбъектИерархии
		|ИЗ
		|	ВТ_Данные КАК ВТ_Данные";
		
		торо_ОтчетыКлиентСервер.УстановитьТипИерархическойГруппировкиВНастройках(КомпоновщикНастроек, "ОбъектИерархии", ТипГруппировкиКомпоновкиДанных.Иерархия);
		
	Иначе

		торо_ОтчетыКлиентСервер.УстановитьТипИерархическойГруппировкиВНастройках(КомпоновщикНастроек, "ОбъектИерархии", ТипГруппировкиКомпоновкиДанных.ТолькоИерархия);

		СхемаКомпоновкиДанных.НаборыДанных.Объекты.Запрос = 
		ПолучитьСодержательнуюЧастьЗапроса()+
		"ВЫБРАТЬ
		|	ВТ_Данные.ОбъектРемонта КАК ОбъектРемонта,
		|	ВТ_Данные.ДатаПринятия КАК ДатаПринятия,
		|	ВТ_Данные.ДокументПринятия КАК ДокументПринятия,
		|	ВТ_Данные.ДатаСнятияСУчета КАК ДатаСнятияСУчета,
		|	ВТ_Данные.ДокументСнятияСУчета КАК ДокументСнятияСУчета,
		|	ВТ_Данные.ОбъектРемонта КАК ОбъектИерархии
		|ИЗ
		|	ВТ_Данные КАК ВТ_Данные";
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	
	Настройки.ЗагрузитьНастройкиПриИзмененииПараметров = ЗагрузитьНастройкиПриИзмененииПараметров();

КонецПроцедуры

Функция ЗагрузитьНастройкиПриИзмененииПараметров()  
	
	Параметры = Новый Массив;
	Параметры.Добавить(Новый ПараметрКомпоновкиДанных("ИерархияТип"));	
	Возврат Параметры;
	
КонецФункции

Функция ПолучитьСодержательнуюЧастьЗапроса() 
	
	ЗапросТекст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
	              |	торо_СтатусыВыбытиеВУчете.Период КАК Период,
	              |	торо_СтатусыВыбытиеВУчете.Регистратор КАК Регистратор,
	              |	торо_СтатусыВыбытиеВУчете.ОбъектРемонта КАК ОбъектРемонта,
	              |	торо_СтатусыВыбытиеВУчете.СтатусОР КАК СтатусОР
	              |ПОМЕСТИТЬ ТаблицаСоответствующаяПараметрам
	              |ИЗ
	              |	РегистрСведений.торо_СтатусыОбъектовРемонтаВУчете КАК торо_СтатусыВыбытиеВУчете
	              |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_ВыбытиеОбъектаРемонта КАК торо_ВыбытиеОбъектаРемонта
	              |		ПО торо_СтатусыВыбытиеВУчете.Регистратор = торо_ВыбытиеОбъектаРемонта.Ссылка
	              |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.торо_ОбъектыРемонта КАК торо_ОбъектыРемонта
	              |		ПО торо_СтатусыВыбытиеВУчете.ОбъектРемонта = торо_ОбъектыРемонта.Ссылка
	              |ГДЕ
	              |	торо_СтатусыВыбытиеВУчете.СтатусОР В(&СтатусыКВыводу)
	              |{ГДЕ
	              |	(торо_СтатусыВыбытиеВУчете.Период >= &ДатаНачала),
	              |	(торо_СтатусыВыбытиеВУчете.Период <= &ДатаОкончания)}
	              |
	              |ОБЪЕДИНИТЬ
	              |
	              |ВЫБРАТЬ
	              |	торо_СтатусыПринятияВУчете.Период,
	              |	торо_СтатусыПринятияВУчете.Регистратор,
	              |	торо_СтатусыПринятияВУчете.ОбъектРемонта,
	              |	торо_СтатусыПринятияВУчете.СтатусОР
	              |ИЗ
	              |	РегистрСведений.торо_СтатусыОбъектовРемонтаВУчете КАК торо_СтатусыПринятияВУчете
	              |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_ПринятиеОРКУчету КАК торо_ПринятиеОРКУчету
	              |		ПО торо_СтатусыПринятияВУчете.Регистратор = торо_ПринятиеОРКУчету.Ссылка
	              |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.торо_ОбъектыРемонта КАК торо_ОбъектыРемонта
	              |		ПО торо_СтатусыПринятияВУчете.ОбъектРемонта = торо_ОбъектыРемонта.Ссылка
	              |ГДЕ
	              |	торо_СтатусыПринятияВУчете.СтатусОР В(&СтатусыКВыводу)
	              |{ГДЕ
	              |	(торо_СтатусыПринятияВУчете.Период >= &ДатаНачала),
	              |	(торо_СтатусыПринятияВУчете.Период <= &ДатаОкончания)}
	              |;
	              |
	              |////////////////////////////////////////////////////////////////////////////////
	              |ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	              |	ТаблицаСоответствующаяПараметрам.ОбъектРемонта КАК ОбъектРемонта,
	              |	ВЫБОР
	              |		КОГДА ТаблицаСоответствующаяПараметрам.СтатусОР = ЗНАЧЕНИЕ(Перечисление.торо_СтатусыОРВУчете.ПринятоКУчету)
	              |			ТОГДА ТаблицаСоответствующаяПараметрам.Период
	              |		ИНАЧЕ торо_СтатусыОбъектовРемонтаВУчете.Период
	              |	КОНЕЦ КАК ДатаПринятия,
	              |	ВЫБОР
	              |		КОГДА ТаблицаСоответствующаяПараметрам.СтатусОР = ЗНАЧЕНИЕ(Перечисление.торо_СтатусыОРВУчете.ПринятоКУчету)
	              |			ТОГДА ТаблицаСоответствующаяПараметрам.Регистратор
	              |		ИНАЧЕ торо_СтатусыОбъектовРемонтаВУчете.Регистратор
	              |	КОНЕЦ КАК ДокументПринятия,
	              |	ВЫБОР
	              |		КОГДА ТаблицаСоответствующаяПараметрам.СтатусОР = ЗНАЧЕНИЕ(Перечисление.торо_СтатусыОРВУчете.СнятоСУчета)
	              |			ТОГДА ТаблицаСоответствующаяПараметрам.Период
	              |		ИНАЧЕ торо_СтатусыОбъектовРемонтаВУчете.Период
	              |	КОНЕЦ КАК ДатаСнятияСУчета,
	              |	ВЫБОР
	              |		КОГДА ТаблицаСоответствующаяПараметрам.СтатусОР = ЗНАЧЕНИЕ(Перечисление.торо_СтатусыОРВУчете.СнятоСУчета)
	              |			ТОГДА ТаблицаСоответствующаяПараметрам.Регистратор
	              |		ИНАЧЕ торо_СтатусыОбъектовРемонтаВУчете.Регистратор
	              |	КОНЕЦ КАК ДокументСнятияСУчета
	              |ПОМЕСТИТЬ ТаблицаСовокупная
	              |ИЗ
	              |	ТаблицаСоответствующаяПараметрам КАК ТаблицаСоответствующаяПараметрам
	              |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_СтатусыОбъектовРемонтаВУчете КАК торо_СтатусыОбъектовРемонтаВУчете
	              |		ПО (торо_СтатусыОбъектовРемонтаВУчете.ОбъектРемонта = ТаблицаСоответствующаяПараметрам.ОбъектРемонта)
	              |			И (торо_СтатусыОбъектовРемонтаВУчете.СтатусОР <> ТаблицаСоответствующаяПараметрам.СтатусОР)
	              |			И (торо_СтатусыОбъектовРемонтаВУчете.СтатусОР В (ЗНАЧЕНИЕ(Перечисление.торо_СтатусыОРВУчете.ПринятоКУчету), ЗНАЧЕНИЕ(Перечисление.торо_СтатусыОРВУчете.СнятоСУчета)))
	              |;
	              |
	              |////////////////////////////////////////////////////////////////////////////////
	              |ВЫБРАТЬ
	              |	ТаблицаСовокупная.ОбъектРемонта КАК ОбъектРемонта,
	              |	МИНИМУМ(ТаблицаСовокупная.ДатаПринятия) КАК ДатаПринятия,
	              |	МАКСИМУМ(ТаблицаСовокупная.ДатаСнятияСУчета) КАК ДатаСнятияСУчета
	              |ПОМЕСТИТЬ ТаблицаМинИМакс
	              |ИЗ
	              |	ТаблицаСовокупная КАК ТаблицаСовокупная
	              |
	              |СГРУППИРОВАТЬ ПО
	              |	ТаблицаСовокупная.ОбъектРемонта
	              |;
	              |
	              |////////////////////////////////////////////////////////////////////////////////
	              |ВЫБРАТЬ
	              |	ТаблицаМинИМакс.ОбъектРемонта КАК ОбъектРемонта,
	              |	ТаблицаСовокупнаяДляПринятых.ДатаПринятия КАК ДатаПринятия,
	              |	ТаблицаСовокупнаяДляПринятых.ДокументПринятия КАК ДокументПринятия,
	              |	ТаблицаСовокупнаяДляСнятых.ДатаСнятияСУчета КАК ДатаСнятияСУчета,
	              |	ТаблицаСовокупнаяДляСнятых.ДокументСнятияСУчета КАК ДокументСнятияСУчета
	              |ПОМЕСТИТЬ ВТ_Данные
	              |ИЗ
	              |	ТаблицаМинИМакс КАК ТаблицаМинИМакс
	              |		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаСовокупная КАК ТаблицаСовокупнаяДляПринятых
	              |		ПО ТаблицаМинИМакс.ОбъектРемонта = ТаблицаСовокупнаяДляПринятых.ОбъектРемонта
	              |			И ТаблицаМинИМакс.ДатаПринятия = ТаблицаСовокупнаяДляПринятых.ДатаПринятия
	              |		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаСовокупная КАК ТаблицаСовокупнаяДляСнятых
	              |		ПО ТаблицаМинИМакс.ОбъектРемонта = ТаблицаСовокупнаяДляСнятых.ОбъектРемонта
	              |			И ТаблицаМинИМакс.ДатаСнятияСУчета = ТаблицаСовокупнаяДляСнятых.ДатаСнятияСУчета"  
				  + "
				  |; 
				  |
				  |//////////////////////////////////////////////////////////////////////////////// 
				  |";
	
	Возврат ЗапросТекст;
	
КонецФункции

#КонецОбласти

#КонецЕсли
