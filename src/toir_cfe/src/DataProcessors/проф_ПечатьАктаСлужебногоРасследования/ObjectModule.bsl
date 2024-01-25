
//++ Проф-ИТ, #133, Башинская А., 13.10.2023

#Область ПрограммныйИнтерфейс

Функция ПечатьАктаСлужебногоРасследования(МассивОбъектов, ПараметрыПечати) Экспорт
	
	ТабДок = Новый ТабличныйДокумент;
	
	Макет = ПолучитьМакет("проф_ПФ_MXL_АктСлужебногоРасследованияПоФактуАварийногоОтказаАТиДСТ");		
	
	ЗаголовокАкта              = Макет.ПолучитьОбласть("ШапкаДокумента");
	ДатаАкта                   = Макет.ПолучитьОбласть("ДатаДокумента");
	КомиссияШапка              = Макет.ПолучитьОбласть("КомиссияШапка"); 
	КомиссияПредседатель       = Макет.ПолучитьОбласть("КомиссияПредседатель"); 
	КомиссияЧлен               = Макет.ПолучитьОбласть("КомиссияЧлен");
	КомиссияПустаяСтрока       = Макет.ПолучитьОбласть("КомиссияПустаяСтрока"); 
	ОсновнаяЧасть              = Макет.ПолучитьОбласть("ДокументОсновнаяЧасть");
	ШапкаПодписиКомиссии       = Макет.ПолучитьОбласть("ШапкаПодписиКомиссии");
	СтрокаПодписи              = Макет.ПолучитьОбласть("СтрокаПодписи");
	СтрокаПодписиССотрудником  = Макет.ПолучитьОбласть("СтрокаПодписиССотрудником");
	ШапкаПодписиПрисутствующих = Макет.ПолучитьОбласть("ШапкаПодписиПрисутствующих");
	
	ПерваяСтраница = Истина;
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапросаАктаСлужебногоРасследования();		
	Запрос.УстановитьПараметр("МассивСсылок", МассивОбъектов);
		
	РезультатЗапроса = Запрос.ВыполнитьПакет();		
	
	ВыборкаАкт = РезультатЗапроса[1].Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам, "Документ");	
	
	Пока ВыборкаАкт.Следующий() Цикл 
		
		Если НЕ ПерваяСтраница Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		Иначе
			ПерваяСтраница = Ложь;
		КонецЕсли;
		
		ВывестиДанныеВУтверждаю(ВыборкаАкт.Документ, РезультатЗапроса[0], ЗаголовокАкта, ТабДок);				
		
		МесяцПрописью = Формат(ВыборкаАкт.Дата, "ДФ=ММММ");
		МесяцПрописью = ПолучитьСклоненияСтроки(МесяцПрописью, "ПЛ=Мужской", "ПД=Родительный");
		ДатаГод       = Строка(Год(ВыборкаАкт.Дата));
		ДатаГод       = СтрЗаменить(ДатаГод, Символы.НПП, "");
		ДатаГод       = СтрЗаменить(ДатаГод, " ", "");
		СтрокаДаты    = Строка(МесяцПрописью[0] + " " + ДатаГод + " г."); 
		
		ДатаАкта.Параметры.ДокументДата = СтрокаДаты; 
		ДатаАкта.Параметры.День         = День(ВыборкаАкт.Дата);
		
		ТабДок.Вывести(ДатаАкта);
		
		ТабДок.Вывести(КомиссияШапка);
		
		ВыборкаКомиссия = ВыборкаАкт.Выбрать();
		ВывестиКомиссию(ВыборкаКомиссия, КомиссияЧлен, КомиссияПустаяСтрока, ТабДок);
		
		ТабДок.Вывести(ОсновнаяЧасть);
		ТабДок.Вывести(ШапкаПодписиКомиссии);
		
		ВывестиПодписи(ВыборкаАкт, СтрокаПодписи, СтрокаПодписиССотрудником, Истина, 3, ТабДок);
		
		ТабДок.Вывести(ШапкаПодписиПрисутствующих);
		
		ВывестиПодписи(ВыборкаАкт, СтрокаПодписи, СтрокаПодписиССотрудником, Ложь, 2, ТабДок);
		
	КонецЦикла;
	
	Возврат ТабДок;	
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ВывестиКомиссию(ВыборкаКомиссия, СтрокаКомиссия, ПустаяСтрока, ТабДок)

	Если ВыборкаКомиссия.Количество() = 1 Тогда		
		ВывестиЕдинственногоЧленаКомиссии(ВыборкаКомиссия, СтрокаКомиссия, ТабДок, ПустаяСтрока);		
	Иначе
		ВывестиВыборкуКомиссии(ВыборкаКомиссия, СтрокаКомиссия, ТабДок);	
	КонецЕсли;
	
КонецПроцедуры

Процедура ВывестиЕдинственногоЧленаКомиссии(ВыборкаКомиссия, СтрокаКомиссия, ТабДок, ПустаяСтрока)

	Если ВыборкаКомиссия.Следующий() Тогда 
		Если ВыборкаКомиссия.Сотрудник = "" Тогда
			ВывестиПустыеСтрокиИлиСтрокиПодписи(3, ПустаяСтрока, ТабДок); 
		Иначе				
			Если ВыборкаКомиссия.Роль <> ПредопределенноеЗначение("Перечисление.проф_РолиПодписантов.Утверждаю") Тогда				
				СтрокаКомиссия.Параметры.РольПодписанта = ВыборкаКомиссия.Роль;
				СтрокаКомиссия.Параметры.ЧленКомиссии   = ВыборкаКомиссия.Сотрудник;
				СтрокаКомиссия.Параметры.Должность      = ВыборкаКомиссия.Должность;
				ТабДок.Вывести(СтрокаКомиссия);				
				ВывестиПустыеСтрокиИлиСтрокиПодписи(2, ПустаяСтрока, ТабДок); 
			Иначе
				ВывестиПустыеСтрокиИлиСтрокиПодписи(3, ПустаяСтрока, ТабДок);
			КонецЕсли;		
		КонецЕсли;
	КонецЕсли;	
	
КонецПроцедуры	

Процедура ВывестиВыборкуКомиссии(ВыборкаКомиссия, СтрокаКомиссия, ТабДок)
	
	Пока ВыборкаКомиссия.Следующий() Цикл			
		Если ВыборкаКомиссия.Роль <> ПредопределенноеЗначение("Перечисление.проф_РолиПодписантов.Утверждаю") Тогда 			
			СтрокаКомиссия.Параметры.РольПодписанта = ВыборкаКомиссия.Роль;
			СтрокаКомиссия.Параметры.ЧленКомиссии   = ВыборкаКомиссия.Сотрудник;
			СтрокаКомиссия.Параметры.Должность      = ВыборкаКомиссия.Должность;
			ТабДок.Вывести(СтрокаКомиссия); 			
		КонецЕсли;			
	КонецЦикла;	
	
КонецПроцедуры	

Процедура ВывестиДанныеВУтверждаю(ТекущийДокумент, РезультатЗапроса, ЗаголовокАкта, ТабДок);
	
	ЗаголовокВыведен = Ложь;
	ВыборкаСотрудникРольУтверждаю = РезультатЗапроса.Выбрать();
	Если ВыборкаСотрудникРольУтверждаю.Количество() > 0 Тогда
		Пока ВыборкаСотрудникРольУтверждаю.Следующий() Цикл
			Если ВыборкаСотрудникРольУтверждаю.Документ = ТекущийДокумент Тогда
				ЗаголовокАкта.Параметры.РольПодписанта = ВыборкаСотрудникРольУтверждаю.Должность;
				ФамилияИнициалыСотрудника = ФизическиеЛицаКлиентСервер.ФамилияИнициалы(ВыборкаСотрудникРольУтверждаю.Сотрудник);
				ЗаголовокАкта.Параметры.Сотрудник = ФамилияИнициалыСотрудника;				
				ТабДок.Вывести(ЗаголовокАкта);
				ЗаголовокВыведен = Истина;
			КонецЕсли;
		КонецЦикла;
		Если НЕ ЗаголовокВыведен Тогда
			ЗаголовокАкта.Параметры.РольПодписанта = "";
			ЗаголовокАкта.Параметры.Сотрудник      = "";
			ТабДок.Вывести(ЗаголовокАкта);
		КонецЕсли;
	Иначе
		ЗаголовокАкта.Параметры.РольПодписанта = "";
		ЗаголовокАкта.Параметры.Сотрудник      = "";
		ТабДок.Вывести(ЗаголовокАкта);
	КонецЕсли;
КонецПроцедуры

Функция ТекстЗапросаАктаСлужебногоРасследования()

	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	торо_ВыявленныеДефектыпроф_Подписанты.Роль КАК Роль,	
	|	ЕСТЬNULL(Сотрудники.Наименование, """") КАК Сотрудник, 	
	|	торо_ВыявленныеДефектыпроф_Подписанты.Должность КАК Должность,
	|	торо_ВыявленныеДефекты.Ссылка КАК Документ
	|ИЗ
	|	Документ.торо_ВыявленныеДефекты КАК торо_ВыявленныеДефекты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_ВыявленныеДефекты.проф_Подписанты КАК торо_ВыявленныеДефектыпроф_Подписанты 	
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК Сотрудники
	|		ПО торо_ВыявленныеДефектыпроф_Подписанты.Сотрудник = Сотрудники.Ссылка	
	|		ПО (торо_ВыявленныеДефектыпроф_Подписанты.Ссылка = торо_ВыявленныеДефекты.Ссылка)
	|ГДЕ
	|	торо_ВыявленныеДефекты.Ссылка В(&МассивСсылок)
	|	И торо_ВыявленныеДефектыпроф_Подписанты.Роль = ЗНАЧЕНИЕ(Перечисление.проф_РолиПодписантов.Утверждаю)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	торо_ВыявленныеДефекты.Ссылка КАК Документ,
	|	торо_ВыявленныеДефекты.Дата КАК Дата,
	|	ЕСТЬNULL(торо_ВыявленныеДефектыпроф_Подписанты.Роль, """") КАК Роль,	
	|	ЕСТЬNULL(Сотрудники.Наименование, """") КАК Сотрудник, 
	|	ЕСТЬNULL(торо_ВыявленныеДефектыпроф_Подписанты.Должность, ЗНАЧЕНИЕ(Справочник.Должности.ПустаяСсылка)) КАК Должность
	|ИЗ
	|	Документ.торо_ВыявленныеДефекты КАК торо_ВыявленныеДефекты
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ВыявленныеДефекты.проф_Подписанты КАК торо_ВыявленныеДефектыпроф_Подписанты 
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК Сотрудники
	|		ПО торо_ВыявленныеДефектыпроф_Подписанты.Сотрудник = Сотрудники.Ссылка
	|		ПО (торо_ВыявленныеДефектыпроф_Подписанты.Ссылка = торо_ВыявленныеДефекты.Ссылка)
	|ГДЕ
	|	торо_ВыявленныеДефекты.Ссылка В(&МассивСсылок)
	|ИТОГИ
	|	МАКСИМУМ(Дата)
	|ПО
	|	Документ";

	Возврат ТекстЗапроса;
	
КонецФункции	

Процедура ВывестиПодписи(ВыборкаАкт, СтрокаПодписи, СтрокаПодписиССотрудником, ЭтоКомиссия, КоличествоСтрок, ТабДок)
	
	Если НЕ ЭтоКомиссия Тогда
		ВывестиПустыеСтрокиИлиСтрокиПодписи(КоличествоСтрок, СтрокаПодписи, ТабДок); 
		Возврат;
	КонецЕсли;	
			
	ВыборкаКомиссия = ВыборкаАкт.Выбрать();
	Если ВыборкаКомиссия.Количество() = 1 Тогда
    	ВывестиПодписьЕдинственногоЧленаКомиссии(ВыборкаКомиссия, СтрокаПодписиССотрудником,
													СтрокаПодписи, КоличествоСтрок, ТабДок);
	Иначе
    	ВывестиПодписиКомиссии(ВыборкаКомиссия, СтрокаПодписиССотрудником, ТабДок);
	КонецЕсли;
		
КонецПроцедуры

Процедура ВывестиПодписьЕдинственногоЧленаКомиссии(ВыборкаКомиссия,
												   СтрокаПодписиССотрудником,
												   СтрокаПодписи,
												   КоличествоСтрок,
												   ТабДок)
	
	Если ВыборкаКомиссия.Следующий() Тогда	
		Если ВыборкаКомиссия.Сотрудник = ""
		Или ВыборкаКомиссия.Роль = ПредопределенноеЗначение("Перечисление.проф_РолиПодписантов.Утверждаю") Тогда  
			ВывестиПустыеСтрокиИлиСтрокиПодписи(КоличествоСтрок, СтрокаПодписи, ТабДок); 	
		КонецЕсли;		
		Если ВыборкаКомиссия.Роль <> ПредопределенноеЗначение("Перечисление.проф_РолиПодписантов.Утверждаю") Тогда 		
			СтрокаПодписиССотрудником.Параметры.ЧленКомиссии = ВыборкаКомиссия.Сотрудник;
			ТабДок.Вывести(СтрокаПодписиССотрудником);
			ВывестиПустыеСтрокиИлиСтрокиПодписи(КоличествоСтрок - 1, СтрокаПодписи, ТабДок); 
		КонецЕсли;
	КонецЕсли;	
	
КонецПроцедуры	

Процедура ВывестиПодписиКомиссии(ВыборкаКомиссия, СтрокаПодписиССотрудником, ТабДок)
	
	Пока ВыборкаКомиссия.Следующий() Цикл 		
		Если ВыборкаКомиссия.Роль <> ПредопределенноеЗначение("Перечисление.проф_РолиПодписантов.Утверждаю") Тогда
			СтрокаПодписиССотрудником.Параметры.ЧленКомиссии = ВыборкаКомиссия.Сотрудник;
			ТабДок.Вывести(СтрокаПодписиССотрудником);		
		КонецЕсли;		
	КонецЦикла;	
	
КонецПроцедуры

Процедура ВывестиПустыеСтрокиИлиСтрокиПодписи(Количество, Строка, ТабДок)
	
	Для Счетчик = 1 По Количество Цикл
		ТабДок.Вывести(Строка);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

//-- Проф-ИТ, #133, Башинская А., 13.10.2023