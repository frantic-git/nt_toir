#Область ПрограммныйИнтерфейс

// Заполняет на форме элементы, связанные с отображением структуры ремонтного цикла.
//
// Параметры:
//		Форма - ФормаКлиентскогоПриложения - форма, на которой выполняется расчет структуры РЦ.
//
Процедура НарисоватьМнемосхему(Форма) Экспорт
	
	торо_РаботаСМнемосхемами.мнс_СоздатьЧистуюКарту(Форма.ПолеМнемосхемы);
	Форма.Элементы.ПолеМнемосхемы.ТекущийЭлемент = Неопределено;
	Форма.КолСтрокСхемы = 0;
	
	Если Форма.Элементы.ПолеТД.Ширина < 20 Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Размер окна слишком мал. Невозможно вывести таблицу!'"));
		Возврат;
	КонецЕсли;
	
	ЗаполнитьНадписьИтоги(Форма);
	
	ДополнительныеПараметры = Новый Структура("Форма", Форма);
	
	Если Форма.ТаблицаРемонтовВизуализация.Количество() > 100 Тогда
		ТекстВопроса = НСтр("ru = 'Вывод схемы ремонтного цикла может занять продолжительное время. Вывести схему?'");
		ОписаниеОповещения = Новый ОписаниеОповещения("НарисоватьМнемосхемуЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		Возврат;
	КонецЕсли;
	
	НарисоватьМнемосхемуЗавершение(Неопределено, ДополнительныеПараметры);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура НарисоватьМнемосхемуЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Форма = ДополнительныеПараметры.Форма;
	
	#Если Не МобильныйКлиент Тогда

		МассивЭлементовДляВывода = Новый Массив;
				
		ПолеМнемосхемыЭлемент = Форма.Элементы.ПолеМнемосхемы;
		ПолеТД = Форма.ПолеТД;
		ПолеТДЭлемент = Форма.Элементы.ПолеТД;
		ТаблицаРемонтовВизуализация = Форма.ТаблицаРемонтовВизуализация;
		КолонкиНаработки = Форма.КолонкиНаработки;
		ЗначенияНаработки = Форма.ЗначенияНаработки;
		Нормировать = Форма.Нормировать;
		СоответствиеЦветов = Форма.СоответствиеЦветов;
		СоответствиеИндексаИНомераКолонки = Форма.СоответствиеИндексаИНомераКолонки;
	
		НаправлениеЭлемента     = "Вправо";
		ШиринаОдногоЭлемента		= 60;
		ОтступОтКрая 				= 10; 
		ШиринаПоля              = ПолеМнемосхемыЭлемент.Ширина * 10 - 150;
		ШиринаПоляТД            = ПолеТДЭлемент.Ширина * 15 - 150;
		КоличествоКолонокПоляТД = Цел((ШиринаПоляТД - 50) / 50) - 1;
		ИндексСтроки            = 8 + КолонкиНаработки.Количество() + 1;
		МаксЭлементовДляВебКлиента = 10;
		
		ОбщаяПродолжительность = РассчитатьОбщуюПродолжительностьРемонтногоЦикла(ТаблицаРемонтовВизуализация);
		МинШаг = РассчитатьМинимальныйШагСтруктуры(ТаблицаРемонтовВизуализация, ОбщаяПродолжительность);
		
		торо_РасчетСтруктурыРемонтногоЦиклаКлиентСервер.ВывестиКолонкуЗаголовковТаблицыРасшифровки(ПолеТД, 0, КоличествоКолонокПоляТД, ТаблицаРемонтовВизуализация.Количество(), ИндексСтроки, КолонкиНаработки);
		
		СдвигСтрокПоляТД = 0;
		НомерРемонта = 1;
		Счетчик = 1;
		Форма.КолСтрокСхемы = 1;
		КоличествоЭлементовВСтроке = 0;
		НакопленнаяДлинаСтроки = ОтступОтКрая;
		
		Для Каждого СтрокаРемонта Из ТаблицаРемонтовВизуализация Цикл
			Если Не ЗначениеЗаполнено(СтрокаРемонта.ВидРемонтныхРабот) Тогда
				Продолжить;
			КонецЕсли;
			
			Если РезультатВопроса = КодВозвратаДиалога.Да ИЛИ РезультатВопроса = Неопределено Тогда
				
				Если Нормировать Тогда
					Шаг = Окр((СтрокаРемонта.ДатаНач - СтрокаРемонта.ДатаПредшествующего) / ОбщаяПродолжительность * 40 / МинШаг);
					Если Шаг = 0 Тогда
						Шаг = 1;
					КонецЕсли;
				Иначе
					Шаг = 40;
				КонецЕсли;
				
				#Если ВебКлиент Тогда
					ДошлиДоКраяЭкрана = (КоличествоЭлементовВСтроке = МаксЭлементовДляВебКлиента + ?(СдвигСтрокПоляТД>0, 0, 1));
				#Иначе
				   ДошлиДоКраяЭкрана = (НакопленнаяДлинаСтроки + Шаг > ШиринаПоля);
				#КонецЕсли
				
				Если ДошлиДоКраяЭкрана Тогда
					НаправлениеЭлемента = "Вниз";
					Шаг = 40;
					КоличествоЭлементовВСтроке = 0;
					НакопленнаяДлинаСтроки = ОтступОтКрая;
				КонецЕсли;
				
				НайденныеСтроки = СоответствиеЦветов.НайтиСтроки(Новый Структура("ВидРемонтныхРабот", СтрокаРемонта.ВидРемонтныхРабот));
				Если НайденныеСтроки.Количество() > 0 Тогда
					СтрокаВидРемонта =  НайденныеСтроки[0];
					ЦветВР     = СтрокаВидРемонта.Цвет;
					ЦветТекста = СтрокаВидРемонта.ЦветТекста;
					Шрифт      = СтрокаВидРемонта.Шрифт; 
				Иначе
					ЦветВР     = Новый Цвет(255,255,255);
					ЦветТекста = Новый Цвет(0,0,0);
					Шрифт      = Новый Шрифт(); 
				КонецЕсли; 
				
				ИмяЭлемента = "Блок"+Формат(Счетчик, "ЧН=0; ЧГ=0");
				
				СтруктураДопСвойств = Новый Структура("Наименование, Фигура, ЦветВР, ЦветТекста, Шрифт, Подсказка, 
																	|Шаг, Направление, Имя, Картинка, Ширина");
				СтруктураДопСвойств.Наименование = торо_ЗаполнениеДокументов.ПолучитьПредоставленияВРДляПечати(СтрокаРемонта.ВидРемонтныхРабот, Истина);
				СтруктураДопСвойств.Фигура = ФигурыГрафическойСхемы.Блок;
				СтруктураДопСвойств.ЦветВР = ЦветВР;
				СтруктураДопСвойств.ЦветТекста = ЦветТекста;
				СтруктураДопСвойств.Шрифт = Шрифт;
				СтруктураДопСвойств.Подсказка =  НСтр("ru='Дата начала: '") + Строка(СтрокаРемонта.ДатаНач);
				СтруктураДопСвойств.Шаг = Шаг;
				СтруктураДопСвойств.Направление = НаправлениеЭлемента;
				СтруктураДопСвойств.Имя = ИмяЭлемента;
				СтруктураДопСвойств.Картинка = Новый Картинка;
				СтруктураДопСвойств.Ширина = ШиринаОдногоЭлемента;
				
				МассивЭлементовДляВывода.Добавить(СтруктураДопСвойств);
				
				КоличествоЭлементовВСтроке = КоличествоЭлементовВСтроке + 1;
				НакопленнаяДлинаСтроки = НакопленнаяДлинаСтроки + ШиринаОдногоЭлемента;
				Если НаправлениеЭлемента = "Вправо" И Счетчик > 1 Тогда
					НакопленнаяДлинаСтроки = НакопленнаяДлинаСтроки + Шаг;
				КонецЕсли;
				
				Если НаправлениеЭлемента = "Вниз" Тогда 
					Форма.КолСтрокСхемы = Форма.КолСтрокСхемы + 1;
					НаправлениеЭлемента = "Вправо";
				КонецЕсли;
				
				НС = СоответствиеИндексаИНомераКолонки.Добавить();
				НС.ТекЭлементИмя = ИмяЭлемента;
				НС.НомерКолонки = НомерРемонта + 2;
				НС.СдвигСтрок = СдвигСтрокПоляТД;

			КонецЕсли;
			
			торо_РасчетСтруктурыРемонтногоЦиклаКлиентСервер.ВывестиКолонкуДанныхТаблицыРасшифровки(ПолеТД, СдвигСтрокПоляТД, ИндексСтроки, НомерРемонта, СтрокаРемонта, КолонкиНаработки, ЗначенияНаработки);
			
			НомерРемонта = НомерРемонта + 1;
			Счетчик = Счетчик + 1;
			
			Если Не (ПолеТДЭлемент.ТекущаяОбласть = Неопределено) И (НомерРемонта + 3)*50 > ШиринаПоляТД Тогда 
				СдвигСтрокПоляТД = СдвигСтрокПоляТД + ИндексСтроки - 1;
				НомерРемонта = 1;
			КонецЕсли;
			
		КонецЦикла;
		
		СоответствиеИменЭлементов = Новый Соответствие;
		торо_РаботаСМнемосхемами.ВывестиЭлементыСоединенныеЛинией(Форма.ПолеМнемосхемы, МассивЭлементовДляВывода, 1, СоответствиеИменЭлементов);

		Для каждого КлючИЗначение из СоответствиеИменЭлементов Цикл
			СоответствиеИндексаИНомераКолонки[КлючИЗначение.Значение].ТекЭлементИмя = КлючИЗначение.Ключ;
		КонецЦикла;
		
		Форма.МожноПечататьВизуализацию = Истина;
	#КонецЕсли
	
КонецПроцедуры

Функция РассчитатьОбщуюПродолжительностьРемонтногоЦикла(ТаблицаРемонтов)
	
	ОбщаяПродолжительность = 0;
	
	Если ТаблицаРемонтов.Количество() > 0 Тогда
		ПоследнийРемонт = ТаблицаРемонтов[ТаблицаРемонтов.Количество() - 1];
		ДатаПоследнего = ТаблицаРемонтов[0].ДатаНач;
		ОбщаяПродолжительность = ПоследнийРемонт.ДатаНач - ДатаПоследнего;
	КонецЕсли;
	
	Если ОбщаяПродолжительность = 0 Тогда
		ОбщаяПродолжительность = 1;
	КонецЕсли;

	Возврат ОбщаяПродолжительность;
		
КонецФункции

Функция РассчитатьМинимальныйШагСтруктуры(ТаблицаРемонтов, ОбщаяПродолжительность)
	
	МинШаг = 1;
	
	СписокШагов = Новый СписокЗначений;
	
	Для Каждого СтрокаРемонта Из ТаблицаРемонтов Цикл
		Шаг = (СтрокаРемонта.ДатаНач - СтрокаРемонта.ДатаПредшествующего) / ОбщаяПродолжительность;
		Если Шаг > 0 Тогда
			СписокШагов.Добавить(Шаг);
		КонецЕсли;
	КонецЦикла;
	
	СписокШагов.СортироватьПоЗначению();
		
	Если СписокШагов.Количество() > 0 Тогда
		МинШаг = СписокШагов[0].Значение;
	КонецЕсли;

	Возврат МинШаг;
	
КонецФункции

Процедура ЗаполнитьНадписьИтоги(Форма)
	
	ТаблицаРемонтовВизуализация = Форма.ТаблицаРемонтовВизуализация;
	КолонкиНаработки = Форма.КолонкиНаработки;
	ЗначенияНаработки = Форма.ЗначенияНаработки;
	
	Если ТаблицаРемонтовВизуализация.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
		
	КоличествоРемонтовСоответствие = Новый Соответствие;
	
	Для каждого Стр Из ТаблицаРемонтовВизуализация Цикл
		ЗначениеКлюча = КоличествоРемонтовСоответствие.Получить(Стр.ВидРемонтныхРабот);
		Если ЗначениеКлюча = Неопределено Тогда
			КоличествоРемонтовСоответствие.Вставить(Стр.ВидРемонтныхРабот, 1);
		Иначе
			КоличествоРемонтовСоответствие.Вставить(Стр.ВидРемонтныхРабот, ЗначениеКлюча + 1);
		КонецЕсли;
	КонецЦикла; 
	
	ПоследняяСтрокаРемонта = ТаблицаРемонтовВизуализация[ТаблицаРемонтовВизуализация.Количество() - 1];
	РазностьДат = (ПоследняяСтрокаРемонта.ДатаНач - ПоследняяСтрокаРемонта.ДатаПредшествующегоТогожеВида) / 86400;
	
	ШаблонИтоговойНадписи = НСтр("ru='Всего:
								|%1
								|Календарных дней: %2
								|Рабочих дней: %3
								|%4'");
	
	ШаблонСтрокиКоличестваРемонтов = НСтр("ru='%1: %2 шт.'");
	ШаблонСтрокиНаработки = НСтр("ru='%1: %2'");
	
	МассивСтрокКоличествоРемонтов = Новый Массив;
	МассивСтрокНаработки = Новый Массив;
	
	Для каждого Стр Из КоличествоРемонтовСоответствие Цикл
		МассивСтрокКоличествоРемонтов.Добавить(СтрШаблон(ШаблонСтрокиКоличестваРемонтов, Стр.Ключ, Стр.Значение));
	КонецЦикла;
	
	МассивКолонокНаработки = КолонкиНаработки.НайтиСтроки(Новый Структура("ПредшествующийТогоЖеВида", Истина));
		
	Для Каждого КолонкаНаработки из МассивКолонокНаработки Цикл
		СтрокиНаработки = ЗначенияНаработки.НайтиСтроки(Новый Структура("ID, ВидРемонтныхРабот, Показатель", ПоследняяСтрокаРемонта.ID, ПоследняяСтрокаРемонта.ВидРемонтныхРабот, КолонкаНаработки.ИмяКолонки));
		Если СтрокиНаработки.Количество() > 0 Тогда
			ЗначениеНаработки = СтрокиНаработки[0].Значение;
			МассивСтрокНаработки.Добавить(СтрШаблон(ШаблонСтрокиНаработки, КолонкаНаработки.Показатель, ЗначениеНаработки));
		КонецЕсли;
	КонецЦикла;
		
	СтрокаКоличествоРемонтов = СтрСоединить(МассивСтрокКоличествоРемонтов, Символы.ПС);
	СтрокаНаработка = СтрСоединить(МассивСтрокНаработки, Символы.ПС);
	ЧислоКалендарныхДней = ?(РазностьДат > 0,РазностьДат - 1, 0);
	ЧислоРабочихДней = ПоследняяСтрокаРемонта.ДниОтПредшествующего;
		
	Форма.НадписьКоличествоРемонтовСтруктураРЦ = СтрШаблон(ШаблонИтоговойНадписи, СтрокаКоличествоРемонтов, ЧислоКалендарныхДней, ЧислоРабочихДней, СтрокаНаработка);;
	
КонецПроцедуры

#КонецОбласти
