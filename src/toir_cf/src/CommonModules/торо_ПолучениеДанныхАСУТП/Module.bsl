
#Область ПрограммныйИнтерфейс

// Процедура инициирует получение данных из АСУ ТП.
//
// Параметры:
//  Подключение - СправочникСсылка.торо_ПодключенияКБазеДанных - подключение к БД.
//
Процедура ПолучитьДанные(Подключение = Неопределено) Экспорт
	
	Если Константы.торо_ОтладкаАСУТП_ЗагрузкаДанныхИзМакета.Получить() Тогда
		ПолучитьДанныеОтладка();
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	торо_ПодключенияКБазеДанных.Сервер КАК Адрес,
	               |	торо_ПодключенияКБазеДанных.БазаДанных КАК ИмяБД,
	               |	торо_ПодключенияКБазеДанных.Логин КАК Логин,
	               |	торо_ПодключенияКБазеДанных.Пароль КАК Пароль,
	               |	торо_ПодключенияКБазеДанных.Ссылка КАК Ссылка,
	               |	торо_ПодключенияКБазеДанных.ПериодПолученияДанных КАК ПериодПолученияДанных,
	               |	торо_ПодключенияКБазеДанных.ТекстЗапросаЧтения КАК ТекстЗапросаЧтения,
	               |	торо_ПодключенияКБазеДанных.ТекстЗапросаПометкиОбрабатываемых КАК ТекстЗапросаПометки,
	               |	торо_ПодключенияКБазеДанных.ТекстЗапросаУдаленияОбработанных КАК ТекстЗапросаУдаления,
	               |	торо_ПодключенияКБазеДанных.ИспользоватьПометкуДанных КАК ИспользоватьПометкуДанных,
	               |	торо_ПодключенияКБазеДанных.ИспользоватьУдалениеДанных КАК ИспользоватьУдалениеДанных,
	               |	торо_ПодключенияКБазеДанных.ИспользованиеРазбиениеДанныхНаПорции КАК ИспользованиеРазбиениеДанныхНаПорции,
	               |	торо_ПодключенияКБазеДанных.РазмерПорции КАК РазмерПорции,
	               |	торо_ПодключенияКБазеДанных.ИспользоватьПроизвольнуюСтрокуПодключения КАК ИспользоватьПроизвольнуюСтрокуПодключения,
	               |	торо_ПодключенияКБазеДанных.ПроизвольнаяСтрокаПодключения КАК ПроизвольнаяСтрокаПодключения
	               |ПОМЕСТИТЬ Источники
	               |ИЗ
	               |	Справочник.торо_ПодключенияКБазеДанных КАК торо_ПодключенияКБазеДанных
	               |ГДЕ
	               |	торо_ПодключенияКБазеДанных.ПометкаУдаления = ЛОЖЬ
	               |	И торо_ПодключенияКБазеДанных.Отключен = ЛОЖЬ
	               |	И (торо_ПодключенияКБазеДанных.Ссылка = &Подключение
	               |			ИЛИ &Подключение = НЕОПРЕДЕЛЕНО)
	               |
	               |ИНДЕКСИРОВАТЬ ПО
	               |	Ссылка
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	торо_СеансыОбменаСрезПоследних.Период КАК Период,
	               |	торо_СеансыОбменаСрезПоследних.Подключение КАК Подключение
	               |ПОМЕСТИТЬ Сеансы
	               |ИЗ
	               |	РегистрСведений.торо_СеансыОбменаСАСУТП.СрезПоследних КАК торо_СеансыОбменаСрезПоследних
	               |
	               |ИНДЕКСИРОВАТЬ ПО
	               |	Подключение
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	Источники.Адрес КАК Адрес,
	               |	Источники.ИмяБД КАК ИмяБД,
	               |	Источники.Логин КАК Логин,
	               |	Источники.Пароль КАК Пароль,
	               |	Источники.Ссылка КАК Подключение,
	               |	Источники.Ссылка.Наименование КАК НаименованиеПодключения,
	               |	Источники.ТекстЗапросаЧтения КАК ТекстЗапросаЧтения,
	               |	Источники.ТекстЗапросаПометки КАК ТекстЗапросаПометки,
	               |	Источники.ТекстЗапросаУдаления КАК ТекстЗапросаУдаления,
	               |	Источники.ИспользоватьПометкуДанных КАК ИспользоватьПометкуДанных,
	               |	Источники.ИспользоватьУдалениеДанных КАК ИспользоватьУдалениеДанных,
	               |	ЕСТЬNULL(Сеансы.Период, ДАТАВРЕМЯ(1980, 1, 1, 0, 0, 0)) КАК ДатаПрошлогоСеанса,
	               |	Источники.ИспользованиеРазбиениеДанныхНаПорции КАК ИспользованиеРазбиениеДанныхНаПорции,
	               |	Источники.РазмерПорции КАК РазмерПорции,
	               |	Источники.ИспользоватьПроизвольнуюСтрокуПодключения КАК ИспользоватьПроизвольнуюСтрокуПодключения,
	               |	Источники.ПроизвольнаяСтрокаПодключения КАК ПроизвольнаяСтрокаПодключения
	               |ИЗ
	               |	Источники КАК Источники
	               |		ЛЕВОЕ СОЕДИНЕНИЕ Сеансы КАК Сеансы
	               |		ПО Источники.Ссылка = Сеансы.Подключение
	               |ГДЕ
	               |	ДОБАВИТЬКДАТЕ(ЕСТЬNULL(Сеансы.Период, ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)), СЕКУНДА, Источники.ПериодПолученияДанных) < &ТекДата";
	
	Запрос.УстановитьПараметр("ТекДата", ТекущаяДата());
	Запрос.УстановитьПараметр("Подключение", Подключение);
	резЗапроса = Запрос.Выполнить();
	
	Если резЗапроса.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	ИсточникиДанных = резЗапроса.Выбрать();
	
	Ошибка = Ложь;
	Пока ИсточникиДанных.Следующий() Цикл
		ПодключитьсяИВыполнитьЗапрос(ИсточникиДанных, Ошибка);
	КонецЦикла;
	
КонецПроцедуры

// Обработчик регламентного задания торо_ИнтеграцияСАСУТП.
//
Процедура торо_ИнтеграцияСАСУТП() Экспорт
	
	ИспользоватьИнтеграциюСАСУТП = Константы.торо_ПоказыватьПодсистемуИнтеграцияАСУТП.Получить();
	Если ИспользоватьИнтеграциюСАСУТП = Ложь Тогда
		Возврат;
	КонецЕсли;
	
	ПолучитьДанные();
	торо_ОбработкаДанныхАСУТП.ОбработатьДанные();
	
КонецПроцедуры

// Обработчик регламентного задания торо_УдалениеОбработанныхДанныхАСУТП.
//
Процедура торо_УдалениеОбработанныхДанныхАСУТП() Экспорт
	
	ИспользоватьИнтеграциюСАСУТП = Константы.торо_ПоказыватьПодсистемуИнтеграцияАСУТП.Получить();
	Если ИспользоватьИнтеграциюСАСУТП = Ложь Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
	               |	торо_ДанныеАСУТП.ИДСеанса КАК ИДСеанса
	               |ИЗ
	               |	РегистрСведений.торо_ДанныеАСУТП КАК торо_ДанныеАСУТП
	               |ГДЕ
	               |	торо_ДанныеАСУТП.МеткаВремени < &ТекДата
	               |	И торо_ДанныеАСУТП.Обработан = ИСТИНА
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	торо_СеансыОбменаСАСУТП.Период КАК Период,
	               |	торо_СеансыОбменаСАСУТП.Подключение КАК Подключение,
	               |	торо_СеансыОбменаСАСУТП.КоличествоЗагруженныхЗаписей КАК КоличествоЗагруженныхЗаписей
	               |ИЗ
	               |	РегистрСведений.торо_СеансыОбменаСАСУТП КАК торо_СеансыОбменаСАСУТП
	               |ГДЕ
	               |	торо_СеансыОбменаСАСУТП.Период >= &ТекДата";
	
	Запрос.УстановитьПараметр("ТекДата", ДобавитьМесяц(ТекущаяДата(), -1));
	резЗапроса = Запрос.ВыполнитьПакет();
	ДанныеАСУТПКУдалению = резЗапроса[0];
	СеансыКУдалению = резЗапроса[1];
	
	Если Не ДанныеАСУТПКУдалению.Пустой() Тогда
		Выборка = ДанныеАСУТПКУдалению.Выбрать();
		Пока Выборка.Следующий() Цикл
			нз = РегистрыСведений.торо_ДанныеАСУТП.СоздатьНаборЗаписей();
			нз.Отбор.ИДСеанса.Установить(Выборка.ИДСеанса);
			нз.Записать();
		КонецЦикла;
	КонецЕсли;
	
	Если не СеансыКУдалению.Пустой() Тогда
		тзСеансов = СеансыКУдалению.выгрузить();
		нз = РегистрыСведений.торо_СеансыОбменаСАСУТП.СоздатьНаборЗаписей();
		нз.Загрузить(тзСеансов);
		нз.записать();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Генерирует тестовые записи в базе данных для отладки интеграции с АСУ ТП.
//
// Параметры:
//  ПодключениеКБД - СправочникСсылка.торо_ПодключенияКБазеДанных - элемент справочника с параметрами подключения.
//  КоличествоЗаписей - Число - количество добавляемых записей.
//  МенятьДату			 - Булево - Если Истина, то дата будет выбрана случайным образом, но не раньше даты, 
//											заданной в параметре НачДата. Иначе - будет использована текущая дата.
//  НачДата				 - Дата - Нижняя граница периода для генерации записей.
//  СмещениеДаты		 - Число - Количество секунд смещения, в пределах которого формируется случайная дата, 
//											если параметр МенятьДату равен Истина.
//
Процедура ГенераторЗаписей(ПодключениеКБД, КоличествоЗаписей, МенятьДату = Ложь, НачДата = Неопределено, СмещениеДаты = 300) Экспорт
	
	Если КоличествоЗаписей = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Подключение = Новый COMОбъект("ADODB.Connection");
	Подключение.ConnectionTimeOut = 30;
	Подключение.connectionString = "SERVER="+СокрЛП(ПодключениеКБД.Сервер)+
		"; Database = "+СокрЛП(ПодключениеКБД.БазаДанных)+
		"; DRIVER=SQL Server; UID="+СокрЛП(ПодключениеКБД.Логин)+
		"; PWD="+СокрЛП(ПодключениеКБД.Пароль)+";";
	Подключение.Open();
	
	Command = Новый COMОбъект("ADODB.Command");
	Command.ActiveConnection = Подключение;
	Command.CommandTimeOut = 30;
	Command.CommandType = 1;
	
	Макет = ПолучитьОбщийМакет("торо_ОтладочныеДанныеАСУТП");
	ПостроительЗапроса = новый ПостроительЗапроса;
	ПостроительЗапроса.ИсточникДанных = Новый ОписаниеИсточникаДанных(Макет.Область("КорректДанные"));
	ПостроительЗапроса.Выполнить();
	тзМакета = ПостроительЗапроса.Результат.Выгрузить();
	
	ГСЧ = Новый ГенераторСлучайныхЧисел(Год(ТекущаяДата()) + Месяц(текущаяДата()) + День(текущаяДата()) + Час(текущаяДата()) + Минута(текущаяДата()) + Секунда(текущаяДата()));
	Для номерПП = 0 по КоличествоЗаписей-1 Цикл
		ТекстЗапроса = "INSERT INTO [ASU_test].[dbo]._Таблица
		       |([ORName]
			   |,[Tag]
		       |,[Date]
		       |,[Value])
		 |VALUES
		       |('_ОР' 
			   |,'_Тег'
		       |,'_Дата'
		       |,'_Значение')";
		
		нсс = ГСЧ.СлучайноеЧисло(0, тзМакета.Количество()-1);
		
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "_Таблица", тзМакета[нсс].Подключение);
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "_ОР", тзМакета[нсс].ORName);
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "_Тег", тзМакета[нсс].Tag);
		
		Если МенятьДату Тогда 
			Если Не ЗначениеЗаполнено(НачДата) Тогда
				НачДата = ТекущаяДата() - 60*60*24;
			КонецЕсли;
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "_Дата", Формат(НачДата,"ДФ='ггггММдд ЧЧ:мм:сс'"));
			
			случЧислоСекунд = ГСЧ.СлучайноеЧисло(10, ?(СмещениеДаты < 10, 10, СмещениеДаты));
			НачДата = НачДата+ случЧислоСекунд;
		Иначе 
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "_Дата", Формат(ТекущаяДата(), "ДФ='ггггММдд ЧЧ:мм:сс'"));
		КонецЕсли;
		
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "_Значение", ГСЧ.СлучайноеЧисло(0, 20));
		
		Command.CommandText = ТекстЗапроса;
		Выборка = Command.Execute();
		
	КонецЦикла;
	
	Подключение.Close();	
	
КонецПроцедуры

Процедура ЗарегистрироватьОшибкуИнтеграции(ТекИсточник, Этап, ОписаниеОшибки, ИДСеанса) Экспорт
	
	ТекстОшибки = "";
	Если Этап = Перечисления.торо_ОшибкиАСУТП.Подключение Тогда
		мз = РегистрыСведений.торо_СобытияИнтеграцииСАСУТП.СоздатьМенеджерЗаписи();
		мз.Подключение = ТекИсточник.Подключение;
		мз.Дата = ТекущаяДата();
		мз.ИДСеанса = ИДСеанса;
		мз.ТипОшибки = Этап;
		мз.ТипСобытия = Перечисления.торо_СобытияИнтеграции.Ошибка;
		ТекстОшибки = "Подключение: " + ТекИсточник.НаименованиеПодключения + Символы.ПС
			+ "Сервер: " + ТекИсточник.Адрес + Символы.ПС
			+ "БазаДанных: " + ТекИсточник.ИмяБД + Символы.ПС
			+ "Логин:" + ТекИсточник.Логин + Символы.ПС
			+ "Пароль: " + ТекИсточник.Пароль + Символы.ПС
			+ "ОписаниеОшибки: " + ОписаниеОшибки;
		мз.Ошибка = ТекстОшибки;
		мз.Записать();
	ИначеЕсли Этап = Перечисления.торо_ОшибкиАСУТП.ЧтениеДанных Тогда
		мз = РегистрыСведений.торо_СобытияИнтеграцииСАСУТП.СоздатьМенеджерЗаписи();
		мз.Подключение = ТекИсточник.Подключение;
		мз.Дата = ТекущаяДата();
		мз.ИДСеанса = ИДСеанса;
		мз.ТипОшибки = Этап;
		мз.ТипСобытия = Перечисления.торо_СобытияИнтеграции.Ошибка;
		ТекстОшибки = "Подключение: " + ТекИсточник.НаименованиеПодключения + Символы.ПС
			+ "Сервер: " + ТекИсточник.Адрес + Символы.ПС
			+ "БазаДанных: " + ТекИсточник.ИмяБД + Символы.ПС
			+ "Логин:" + ТекИсточник.Логин + Символы.ПС
			+ "Пароль: " + ТекИсточник.Пароль + Символы.ПС
			+ "ТекстЗапросаЧтения: " + ТекИсточник.ТекстЗапросаЧтения + Символы.ПС
			+ "ТекстЗапросаПометкиОбрабатываемых: " + ?(ТекИсточник.ИспользоватьПометкуДанных, ТекИсточник.ТекстЗапросаПометки, "не используется") + Символы.ПС
			+ "ТекстЗапросаУдаленияОбработанных: " + ?(ТекИсточник.ИспользоватьУдалениеДанных, ТекИсточник.ТекстЗапросаУдаления, "не используется") + Символы.ПС
			+ "ОписаниеОшибки: " + ОписаниеОшибки;
		мз.Ошибка = ТекстОшибки;
		мз.Записать();
	ИначеЕсли Этап = Перечисления.торо_ОшибкиАСУТП.ЧтениеДанныхИзМакета Тогда
		мз = РегистрыСведений.торо_СобытияИнтеграцииСАСУТП.СоздатьМенеджерЗаписи();
		мз.Подключение = ТекИсточник.Подключение;
		мз.Дата = ТекущаяДата();
		мз.ИДСеанса = ИДСеанса;
		мз.ТипОшибки = Этап;		
		мз.ТипСобытия = Перечисления.торо_СобытияИнтеграции.Ошибка;
		ТекстОшибки = "Подключение: " + ТекИсточник.Подключение + Символы.ПС
			+ "ОписаниеОшибки: " + ОписаниеОшибки;
		мз.Ошибка = ТекстОшибки;
		мз.Записать();		
	Иначе
		мз = РегистрыСведений.торо_СобытияИнтеграцииСАСУТП.СоздатьМенеджерЗаписи();
		мз.Подключение = ТекИсточник.Подключение;
		мз.Дата = ТекущаяДата();
		мз.ИДСеанса = ИДСеанса;
		мз.ТипОшибки = Этап;
		мз.ТипСобытия = Перечисления.торо_СобытияИнтеграции.Ошибка;
		ТекстОшибки = "Неопознанный этап интеграции: " + Этап;
		мз.Ошибка = ТекстОшибки;
		мз.Записать();
	КонецЕсли;
	
	торо_ОбработкаДанныхАСУТП.СформироватьПочтовыеУведомление(ИДСеанса);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПолучитьДанныеОтладка()
	
	Макет = ПолучитьОбщийМакет("торо_ОтладочныеДанныеАСУТП");
	ПостроительЗапроса = новый ПостроительЗапроса;
	ПостроительЗапроса.ИсточникДанных = Новый ОписаниеИсточникаДанных(Макет.Область("Данные"));
	ПостроительЗапроса.Выполнить();
	тзМакета = ПостроительЗапроса.Результат.Выгрузить();

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	Таб.Подключение КАК Подключение,
	               |	Таб.ORName КАК наименованиеОР,
	               |	Таб.Tag КАК Тег,
	               |	Таб.Date КАК Дата,
	               |	Таб.Value КАК Значение
	               |ПОМЕСТИТЬ ДанныеИзМакета
	               |ИЗ
	               |	&Таб КАК Таб
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ДанныеИхМакета.наименованиеОР КАК наименованиеОР,
	               |	ДанныеИхМакета.Тег КАК Тег,
	               |	ДанныеИхМакета.Дата КАК Дата,
	               |	ДанныеИхМакета.Значение КАК Значение,
	               |	ДанныеИхМакета.Подключение КАК ПодключениеНаименованиеИзМакета,
	               |	торо_ПодключенияКБазеДанных.Ссылка КАК Подключение,
	               |	торо_ПодключенияКБазеДанных.Наименование КАК Наименование
	               |ПОМЕСТИТЬ Данные
	               |ИЗ
	               |	ДанныеИзМакета КАК ДанныеИхМакета
	               |		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.торо_ПодключенияКБазеДанных КАК торо_ПодключенияКБазеДанных
	               |		ПО ДанныеИхМакета.Подключение = торо_ПодключенияКБазеДанных.Наименование
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	Данные.наименованиеОР КАК наименованиеОР,
	               |	Данные.Тег КАК Тег,
	               |	Данные.Дата КАК Дата,
	               |	Данные.Значение КАК Значение,
	               |	Данные.ПодключениеНаименованиеИзМакета КАК ПодключениеНаименованиеИзМакета,
	               |	Данные.Подключение КАК Подключение,
	               |	Данные.Наименование КАК Наименование,
	               |	ВЫБОР
	               |		КОГДА Данные.Подключение ЕСТЬ NULL
	               |			ТОГДА ЛОЖЬ
	               |		ИНАЧЕ ИСТИНА
	               |	КОНЕЦ КАК ПодключениеРаспознано
	               |ИЗ
	               |	Данные КАК Данные
	               |ИТОГИ
	               |	МАКСИМУМ(ПодключениеРаспознано)
	               |ПО
	               |	Подключение";
	
	Запрос.УстановитьПараметр("Таб", тзМакета);
	
	резЗапроса = Запрос.Выполнить();
	
	Если НЕ резЗапроса.Пустой() Тогда
		Выборка = резЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		струкДанных = Новый Структура("Подключение");
		Попытка
			МеткаВремени = Дата(Год(ТекущаяДата()), Месяц(ТекущаяДата()), День(ТекущаяДата()), Час(ТекущаяДата()),0,0);
			Пока Выборка.Следующий() Цикл
				ИДСеанса = Новый УникальныйИдентификатор;
				КоличествоЗагруженныхЗаписей = 0;
				струкДанных.Подключение = Выборка.ПодключениеНаименованиеИзМакета;
				
				Если Выборка.ПодключениеРаспознано Тогда 
					текСтрока = Выборка.Выбрать();
					нз = РегистрыСведений.торо_ДанныеАСУТП.СоздатьНаборЗаписей();
					нз.Отбор.ИДСеанса.Установить(ИДСеанса);
					
					НомерПП = 1;
					Пока текСтрока.Следующий() цикл
						нс = нз.Добавить();
						ЗаполнитьЗначенияСвойств(нс, текСтрока);
						нс.ИДСеанса = ИДСеанса;
						нс.ИДЗаписи = НомерПП;
						НомерПП = НомерПП + 1;
						нс.Ошибка = Ложь;
						нс.МеткаВремени = МеткаВремени;
						нс.Дата = Дата(текСтрока.дата);
						нс.Обработан = Ложь;
					КонецЦикла;
					
					КоличествоЗагруженныхЗаписей = нз.Количество();
					нз.Записать(Истина);
				Иначе 
					ВызватьИсключение "Подключение из макета не опознано.";
				КонецЕсли;
				
				СделатьЗаписьВРегистрСеансов(Выборка, КоличествоЗагруженныхЗаписей, ТекущаяДата());
			КонецЦикла;
		Исключение
			ОписаниеОшибки = ОписаниеОшибки();
			ЗаписьЖурналаРегистрации(НСтр("ru = 'Исключение'"), УровеньЖурналаРегистрации.Предупреждение,,,ОписаниеОшибки);
			ЗарегистрироватьОшибкуИнтеграции(струкДанных, Перечисления.торо_ОшибкиАСУТП.ЧтениеДанныхИзМакета, ОписаниеОшибки, ИДСеанса);
			СделатьЗаписьВРегистрСеансов(струкДанных, КоличествоЗагруженныхЗаписей, ТекущаяДата());
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПодключитьсяИВыполнитьЗапрос(текИсточник, Ошибка)
	
	Этап = Перечисления.торо_ОшибкиАСУТП.Подключение;
	КоличествоЗагруженныхЗаписей = 0;
	ТекДата = ТекущаяДата();
	ОтступатьС = Константы.торо_ОтступВСекундахАСУТП.Получить();
	
	Порция = текИсточник.РазмерПорции;
	Если текИсточник.ИспользованиеРазбиениеДанныхНаПорции = истина Тогда
		ГраницаПолученияДанныхНачало = ТекИсточник.ДатаПрошлогоСеанса;
		ГраницаПолученияДанныхКонец = ГраницаПолученияДанныхНачало + Порция;
	КонецЕсли;
	
	Попытка
		ИДСеанса = Новый УникальныйИдентификатор;
		
		Подключение = Новый COMОбъект("ADODB.Connection");
		Подключение.ConnectionTimeOut = 30;
		
		Если текИсточник.ИспользоватьПроизвольнуюСтрокуПодключения Тогда
			СтрокаПодключения = СокрЛП(текИсточник.ПроизвольнаяСтрокаПодключения);
			СтрокаПодключения = СтрЗаменить(СтрокаПодключения, "%Логин%", СокрЛП(текИсточник.Логин));
			СтрокаПодключения = СтрЗаменить(СтрокаПодключения, "%Пароль%", СокрЛП(текИсточник.Пароль));
			Подключение.connectionString = СтрокаПодключения;
		Иначе
			Подключение.connectionString = "SERVER="+СокрЛП(текИсточник.Адрес)+
				"; Database = "+СокрЛП(текИсточник.ИмяБД)+
				"; DRIVER=SQL Server; UID="+СокрЛП(текИсточник.Логин)+
				"; PWD="+СокрЛП(текИсточник.Пароль)+";";
		КонецЕсли;
		
		Подключение.Open();
		
		Command = Новый COMОбъект("ADODB.Command");
		Command.ActiveConnection = Подключение;
		Command.CommandTimeOut = 30;
		Command.CommandType = 1;
		
		Если текИсточник.ИспользованиеРазбиениеДанныхНаПорции = Истина Тогда
			p1 = Command.CreateParameter("@P1",200,1,255,Формат(ГраницаПолученияДанныхНачало,"ДФ='ггггММдд ЧЧ:мм:сс'"));
			Command.Parameters.Append(p1);
			p2 = Command.CreateParameter("@P2",200,1,255,Формат(ГраницаПолученияДанныхКонец,"ДФ='ггггММдд ЧЧ:мм:сс'"));
			Command.Parameters.Append(p2);
		Иначе
			p1 = Command.CreateParameter("@P1",200,1,255,Формат(ТекДата-ОтступатьС,"ДФ='ггггММдд ЧЧ:мм:сс'"));
			Command.Parameters.Append(p1);
		КонецЕсли;
		Command.Parameters.Refresh();
		
		тз = Новый ТаблицаЗначений;
		тз.Колонки.Добавить("НаименованиеОР", Новый ОписаниеТипов("Строка",,,, Новый КвалификаторыСтроки(100)));
		тз.Колонки.Добавить("Тег", Новый ОписаниеТипов("Строка",,,, Новый КвалификаторыСтроки(100)));
		тз.Колонки.Добавить("Подключение", новый ОписаниеТипов("СправочникСсылка.торо_ПодключенияКБазеДанных"));
		тз.Колонки.Добавить("Дата", Новый ОписаниеТипов("Дата",,,,, Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)));
		тз.Колонки.Добавить("МеткаВремени", Новый ОписаниеТипов("Дата",,,,, Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)));
		тз.Колонки.Добавить("Значение", Новый ОписаниеТипов("Число",,, Новый КвалификаторыЧисла(15,3)));
		тз.Колонки.Добавить("Ошибка", Новый ОписаниеТипов("Булево"));
		тз.Колонки.Добавить("Обработан", Новый ОписаниеТипов("Булево"));
		
		КоличествоЗагруженныхЗаписей = 0;
		Закончить = Ложь;
		
		Пока Истина Цикл
			
			Если Закончить = Истина Тогда
				Прервать;
			КонецЕсли;
			
			Если текИсточник.ИспользованиеРазбиениеДанныхНаПорции = Истина Тогда
				ГраницаПолученияДанныхКонец = ГраницаПолученияДанныхНачало + Порция;
				Если ГраницаПолученияДанныхКонец >= (ТекДата - ОтступатьС) Тогда 
					Закончить = Истина;
				КонецЕсли;
				
				ГраницаПолученияДанныхКонец = Мин(ГраницаПолученияДанныхКонец, (ТекДата - ОтступатьС));
			
				p1 = Command.Parameters.Item(0);
				p1.value = Формат(ГраницаПолученияДанныхНачало,"ДФ='ггггММдд ЧЧ:мм:сс'");
				p2 = Command.Parameters.Item(1);
				p2.value = Формат(ГраницаПолученияДанныхКонец,"ДФ='ггггММдд ЧЧ:мм:сс'");
			Иначе
				Закончить = Истина;
			КонецЕсли;
			
			Если текИсточник.ИспользоватьПометкуДанных Тогда
				Command.CommandText = текИсточник.ТекстЗапросаПометки;
				Выборка = Command.Execute();
			КонецЕсли;
			
			Command.CommandText = текИсточник.ТекстЗапросаЧтения;
			
			Выборка = Command.Execute();
			
			ИДСеанса = Новый УникальныйИдентификатор;
			Этап = Перечисления.торо_ОшибкиАСУТП.ЧтениеДанных;
			тз.Очистить();
			
			Записывать = Ложь;
			Если Выборка.BOF = Ложь и Выборка.EOF = Ложь Тогда 
				масSafeArray = Выборка.GetRows();
				масПростоМассив = масSafeArray.Выгрузить();
				Для каждого текСтрока из масПростоМассив Цикл
					нс = тз.Добавить();
					нс.НаименованиеОР = текСтрока[0];
					нс.Тег = текСтрока[1];
					нс.Дата = текСтрока[2];
					нс.Значение = текСтрока[3];
					нс.Подключение = текИсточник.Подключение;
					Записывать = Истина;
				КонецЦикла;
			КонецЕсли;
			Выборка.Close();
			
			Если Записывать = Истина Тогда
				нз = РегистрыСведений.торо_ДанныеАСУТП.СоздатьНаборЗаписей();
				нз.Отбор.ИДСеанса.Установить(ИДСеанса);
				тз.ЗаполнитьЗначения(Ложь, "Ошибка");
				тз.ЗаполнитьЗначения(Ложь, "Обработан");
				тз.ЗаполнитьЗначения(Дата(Год(ТекущаяДата()), Месяц(ТекущаяДата()), День(ТекущаяДата()), Час(ТекущаяДата()),0,0), "МеткаВремени");
				
				НомерПП = 1;
				Для каждого текСтрока из тз Цикл
					нс = нз.Добавить();
					нс.ИДСеанса = ИДСеанса;
					нс.ИДЗаписи = НомерПП;
					НомерПП = НомерПП + 1;
					ЗаполнитьЗначенияСвойств(нс, текСтрока);
				КонецЦикла;
				
				КоличествоЗагруженныхЗаписей = КоличествоЗагруженныхЗаписей + нз.Количество();
				нз.Записать(Истина);
			КонецЕсли;
		
			Если текИсточник.ИспользоватьУдалениеДанных Тогда
				Command.CommandText = текИсточник.ТекстЗапросаУдаления;
				Выборка = Command.Execute();
			КонецЕсли;
			
			ГраницаПолученияДанныхНачало = ГраницаПолученияДанныхКонец;
			
		КонецЦикла;
		
	Исключение
		Ошибка = Истина;
		КоличествоЗагруженныхЗаписей = 0;
		ОписаниеОшибки = ОписаниеОшибки();
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Исключение'"), УровеньЖурналаРегистрации.Предупреждение,,,ОписаниеОшибки);
		ЗарегистрироватьОшибкуИнтеграции(текИсточник, Этап, ОписаниеОшибки, ИДСеанса);
	КонецПопытки;
	
	Попытка
		Подключение.Close();
	Исключение
		ТекстСообщения = НСтр("ru = 'Ошибка при закрытии подключения.'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
	КонецПопытки;
	
	СделатьЗаписьВРегистрСеансов(текИсточник, КоличествоЗагруженныхЗаписей, ТекДата);

КонецПроцедуры

Процедура СделатьЗаписьВРегистрСеансов(текИсточник, КоличествоЗагруженныхЗаписей, ДатаНачалаСеанса)
	мз = РегистрыСведений.торо_СеансыОбменаСАСУТП.СоздатьМенеджерЗаписи();
	мз.Подключение = текИсточник.Подключение;
	мз.Период = ДатаНачалаСеанса;
	мз.КоличествоЗагруженныхЗаписей = КоличествоЗагруженныхЗаписей;
	мз.Записать(Истина);
КонецПроцедуры

#КонецОбласти



