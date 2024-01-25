
&ИзменениеИКонтроль("РасчетППР")
Функция проф_РасчетППР(Ссылка, РассчитыватьСтоимости, ФоновыйРасчет, СтруктураДанныхДляРасчетаВизуализации, ТаблицаОРДляВыборочногоРасчета)

	ЭтоГрафикРегламентныхМероприятий = (ТипЗнч(Ссылка) = Тип("ДокументСсылка.торо_ГрафикРегламентныхМероприятийТОиР"));
	ЭтоРасчетВизуализации = (Ссылка = Неопределено);

	Если НЕ ЭтоРасчетВизуализации Тогда

		ВидОперации = Ссылка.ВидОперации;
		ПланРемонтов = Ссылка.ПланРемонтов.Выгрузить();
		ПланРемонтовID = Ссылка.ПланРемонтов.Выгрузить(, "ID");

		Если Не ЭтоГрафикРегламентныхМероприятий Тогда
			МассивДоступныхДляКорректировкиСтрок = Документы.торо_ПланГрафикРемонта.ОбновитьДоступностьДляРедактирования(Ссылка, ВидОперации, ПланРемонтовID);
		Иначе 
			МассивДоступныхДляКорректировкиСтрок = Документы.торо_ГрафикРегламентныхМероприятийТОиР.ОбновитьДоступностьДляРедактирования(Ссылка, ВидОперации, ПланРемонтовID);
		КонецЕсли;

		Если РассчитыватьСтоимости = Неопределено Тогда
			Если ВидОперации <> Перечисления.торо_ВидыОперацийПланаГрафикаППР.Корректировка Тогда
				РассчитыватьСтоимости = Истина;
			Иначе
				РассчитыватьСтоимости = Ложь;
			КонецЕсли;
		КонецЕсли;

		ТаблицаОбъектыРемонта = Новый ТаблицаЗначений;

		Если ЭтоГрафикРегламентныхМероприятий Тогда
			ТаблицаОбъектыРемонта.Колонки.Добавить("ОбъектРемонтныхРабот", Новый ОписаниеТипов("СправочникСсылка.торо_СписокОбъектовРегламентногоМероприятия"));
		Иначе
			ТаблицаОбъектыРемонта.Колонки.Добавить("ОбъектРемонтныхРабот", Новый ОписаниеТипов("СправочникСсылка.торо_ОбъектыРемонта"));
		КонецЕсли;

		ТаблицаОбъектыРемонта.Колонки.Добавить("ВидРемонтныхРабот",    Новый ОписаниеТипов("СправочникСсылка.торо_ВидыРемонтов"));

		ТаблицаЦепочки = Новый ТаблицаЗначений;
		ТаблицаЦепочки.Колонки.Добавить("ОбъектРемонтныхРабот", Новый ОписаниеТипов("СправочникСсылка.торо_ОбъектыРемонта"));
		ТаблицаЦепочки.Колонки.Добавить("Цепочка",              Новый ОписаниеТипов("СправочникСсылка.торо_ЦепочкиРемонта"));

		ОбъектыРемонтаИзППР = ПолучитьТаблицуОбъектовИзДокумента(Ссылка, ТаблицаОРДляВыборочногоРасчета);

		Для Каждого ОР Из ОбъектыРемонтаИзППР Цикл
			Если ТипЗнч(ОР.ВидРемонтныхРабот) = Тип("СправочникСсылка.торо_ЦепочкиРемонта") Тогда
				НС = ТаблицаЦепочки.Добавить();
				ЗаполнитьЗначенияСвойств(НС,ОР);
				НС.Цепочка = ОР.ВидРемонтныхРабот;
			ИначеЕсли ТипЗнч(ОР.ВидРемонтныхРабот) = Тип("СправочникСсылка.торо_ВидыРемонтов") Тогда
				Если НЕ ЭтоГрафикРегламентныхМероприятий И ОР.ОбъектРемонтныхРабот.НеУчаствуетВПланировании Тогда 
					Продолжить; 
				КонецЕсли;

				ЗаполнитьЗначенияСвойств(ТаблицаОбъектыРемонта.Добавить(),ОР);
			КонецЕсли;
		КонецЦикла;

		СтруктураДанных = Новый Структура;

		Если Не ЭтоГрафикРегламентныхМероприятий Тогда
			СтруктураДанных.Вставить("ТаблицаПланРемонтов", ?(ВидОперации = Перечисления.торо_ВидыОперацийПланаГрафикаППР.Корректировка, Документы.торо_ПланГрафикРемонта.ЗаполнитьДоступностьДляРедактированияПолная(ПланРемонтов, МассивДоступныхДляКорректировкиСтрок), ПланРемонтов));
		Иначе
			СтруктураДанных.Вставить("ТаблицаПланРемонтов", ?(ВидОперации = Перечисления.торо_ВидыОперацийПланаГрафикаППР.Корректировка, Документы.торо_ГрафикРегламентныхМероприятийТОиР.ЗаполнитьДоступностьДляРедактированияПолная(ПланРемонтов, МассивДоступныхДляКорректировкиСтрок), ПланРемонтов));
		КонецЕсли;

		СтруктураДанных.Вставить("ТаблицаОбъектыРемонта",    ТаблицаОбъектыРемонта);
		СтруктураДанных.Вставить("ТаблицаЦепочки",           ТаблицаЦепочки);
		СтруктураДанных.Вставить("ДатаПланирования",         Ссылка.ДатаПланирования);
		СтруктураДанных.Вставить("ПериодичностьДетализации", Ссылка.ПериодичностьДетализации);
		СтруктураДанных.Вставить("КоличествоПериодов",       Ссылка.КоличествоПериодов);

	Иначе
		СтруктураДанных = СтруктураДанныхДляРасчетаВизуализации;	
	КонецЕсли;

	#Вставка
	//++ Проф-ИТ, #150, Соловьев А.А., 18.08.2023
	НачатьТранзакцию();
	
	Попытка
		СтратегическийРасчет = Ложь;
		Если Не ЭтоРасчетВизуализации Тогда 		
			РеквизитыППР = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, "КоличествоПериодов, ПериодичностьДетализации");
			СтратегическийРасчет = (РеквизитыППР.КоличествоПериодов >= 1
				И РеквизитыППР.ПериодичностьДетализации = Перечисления.Периодичность.Год);
			Если СтратегическийРасчет Тогда 
				проф_РасчетППР.СоздатьЗаписиПараметрыНаработкиОбъектовРемонта(СтруктураДанных);
			КонецЕсли;	
		//-- Проф-ИТ, #150, Соловьев А.А., 18.08.2023
		КонецЕсли;
	#КонецВставки
	ИмяОбработки = "торо_ЗащитаУправлениеРемонтами83";		
	ТаблицаРемонтов = торо_СЛКСервер.ЗаполнитьПланГрафикППР_Session(ИмяОбработки, СтруктураДанных,, Ссылка);
	
	#Вставка
	//++ Проф-ИТ, #150, Соловьев А.А., 18.08.2023
		Если СтратегическийРасчет И Не ЭтоРасчетВизуализации Тогда 
			проф_РасчетППР.ОчиститьКэшПараметрыНаработкиОбъектовРемонта(СтруктураДанных);
		КонецЕсли;
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ТекстСообщения = СтрШаблон(НСтр("ru = 'Не удалось рассчитать наработку по причине: %1'"), ОписаниеОшибки());
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		ТаблицаРемонтов = Неопределено;
	КонецПопытки;	
	//-- Проф-ИТ, #150, Соловьев А.А., 18.08.2023
	#КонецВставки
	Если ТаблицаРемонтов = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли; 

	Если НЕ ЭтоРасчетВизуализации Тогда
		Если Не ВидОперации = Перечисления.торо_ВидыОперацийПланаГрафикаППР.Корректировка Тогда

			Если РассчитыватьСтоимости Тогда
				МассивСтрокДляРедактирования = ТаблицаРемонтов.Скопировать(, "ID");
				МассивСтрокДляРедактирования.Колонки.Добавить("ДоступенДляРедактирования", Новый ОписаниеТипов("Булево"));
				МассивСтрокДляРедактирования.ЗаполнитьЗначения(Истина, "ДоступенДляРедактирования");
				Если ЭтоГрафикРегламентныхМероприятий Тогда
					ПланРемонтов = Документы.торо_ГрафикРегламентныхМероприятийТОиР.РассчитатьСтоимостиРемонтов(ТаблицаРемонтов, Ссылка, МассивСтрокДляРедактирования);
				Иначе
					ПланРемонтов = Документы.торо_ПланГрафикРемонта.РассчитатьСтоимостиРемонтов(ТаблицаРемонтов, Ссылка, МассивСтрокДляРедактирования);
				КонецЕсли;
			Иначе
				ПланРемонтов = ТаблицаРемонтов.Скопировать();
			КонецЕсли;

		Иначе

			МассивПрошлых = Новый Массив;
			Для Каждого СтрокаПланРемонтов Из ПланРемонтов Цикл
				Если ЗначениеЗаполнено(СтрокаПланРемонтов.ДатаНачСт) И ЗначениеЗаполнено(СтрокаПланРемонтов.ДатаКонСт) Тогда
					СтрокаПланРемонтов.ДатаНач = Дата(1,1,1,0,0,0);
					СтрокаПланРемонтов.ДатаКон = Дата(1,1,1,0,0,0);
				Иначе
					МассивПрошлых.Добавить(СтрокаПланРемонтов);
				КонецЕсли;
			КонецЦикла;

			Для Каждого СтрокаРемонта Из ТаблицаРемонтов Цикл

				КорректируемаяСтрока = ПланРемонтов.Найти(СтрокаРемонта.ID,"ID");
				Если КорректируемаяСтрока = Неопределено Тогда
					НоваяСтрокаПлана = ПланРемонтов.Добавить();
					ЗаполнитьЗначенияСвойств(НоваяСтрокаПлана,СтрокаРемонта);

					НоваяСтрокаДляКорректировки = МассивДоступныхДляКорректировкиСтрок.Добавить();
					НоваяСтрокаДляКорректировки.ID = СтрокаРемонта.ID;
					НоваяСтрокаДляКорректировки.ДоступенДляРедактирования = Истина;
				Иначе
					ЗаполнитьЗначенияСвойств(КорректируемаяСтрока,СтрокаРемонта);
				КонецЕсли;
			КонецЦикла;

			МассивКУдалению = Новый Массив;

			Для Каждого СтрокаПланаРемонтов Из ПланРемонтов Цикл

				Если (МассивДоступныхДляКорректировкиСтрок.Найти(СтрокаПланаРемонтов.ID) = Неопределено ИЛИ МассивДоступныхДляКорректировкиСтрок.Найти(СтрокаПланаРемонтов.ID).ДоступенДляРедактирования) Тогда
					Если Не ЗначениеЗаполнено(СтрокаПланаРемонтов.ДатаНач) И Не ЗначениеЗаполнено(СтрокаПланаРемонтов.ДатаКон) Тогда
						СтрокаПланаРемонтов.Отменен = Истина;
						СтрокаПланаРемонтов.ДатаНач = СтрокаПланаРемонтов.ДатаНачСт;
						СтрокаПланаРемонтов.ДатаКон = СтрокаПланаРемонтов.ДатаКонСт;
					Иначе  						
						СтрПрошлыйРасчет = МассивПрошлых.Найти(СтрокаПланаРемонтов);
						Если СтрПрошлыйРасчет <> Неопределено И ТаблицаРемонтов.Найти(СтрокаПланаРемонтов.ID,"ID") = Неопределено Тогда
							МассивКУдалению.Добавить(СтрокаПланаРемонтов);
						КонецЕсли;
					КонецЕсли;
				Иначе
					СтрокаПланаРемонтов.ДатаНач = СтрокаПланаРемонтов.ДатаНачСт;
					СтрокаПланаРемонтов.ДатаКон = СтрокаПланаРемонтов.ДатаКонСт;
				КонецЕсли;

				Если Не ЭтоГрафикРегламентныхМероприятий Тогда
					Если ЗначениеЗаполнено(СтрокаПланаРемонтов.Отменен) И СтрокаПланаРемонтов.Отменен Тогда
						СтрокаПланаРемонтов.ПричинаЗакрытия = Справочники.торо_ПричиныЗакрытияРемонтов.КорректировкаППРАвтоматически;
					КонецЕсли;
				КонецЕсли;

			КонецЦикла;	

			Для Каждого Стр из МассивКУдалению ЦИкл
				ПланРемонтов.Удалить(Стр);
			КонецЦикла;

			Если РассчитыватьСтоимости Тогда
				Если ЭтоГрафикРегламентныхМероприятий Тогда
					ПланРемонтов = Документы.торо_ГрафикРегламентныхМероприятийТОиР.РассчитатьСтоимостиРемонтов(ПланРемонтов, Ссылка, МассивДоступныхДляКорректировкиСтрок);
				Иначе
					ПланРемонтов = Документы.торо_ПланГрафикРемонта.РассчитатьСтоимостиРемонтов(ПланРемонтов, Ссылка, МассивДоступныхДляКорректировкиСтрок);
				КонецЕсли;
			КонецЕсли;

		КонецЕсли;

	КонецЕсли;

	Если ФоновыйРасчет Тогда
		ДокументППР = Ссылка.ПолучитьОбъект();

		Если ТипЗнч(ТаблицаОРДляВыборочногоРасчета) <> Тип("ТаблицаЗначений") Тогда 
			ДокументППР.ПланРемонтов.Загрузить(ПланРемонтов);
		Иначе

			СтруктураПоиска = Новый Структура("ОбъектРемонтныхРабот, ВидРемонтныхРабот");
			Для каждого СтрокаОР из ТаблицаОРДляВыборочногоРасчета Цикл
				Если СтрокаОР.ЭтоЦепочка Тогда
					Для каждого ВидРемонтаИзЦепочки из СтрокаОР.ВидРемонтныхРабот.ПоследовательностьРемонтов Цикл
						ЗаполнитьЗначенияСвойств(СтруктураПоиска, СтрокаОР);
						СтруктураПоиска.ВидРемонтныхРабот = ВидРемонтаИзЦепочки.ВидРемонта;
						ЗаменитьСтрокиПланаРемонтовПоСтруктуреПоиска(ДокументППР, ПланРемонтов, СтруктураПоиска, СтрокаОР.ВидРемонтныхРабот);
					КонецЦикла;
				Иначе
					ЗаполнитьЗначенияСвойств(СтруктураПоиска, СтрокаОР);
					Если ЭтоГрафикРегламентныхМероприятий Тогда
						ЗаменитьСтрокиГрафикаРМПоСтруктуреПоиска(ДокументППР, ПланРемонтов, СтруктураПоиска);
					Иначе
						ЗаменитьСтрокиПланаРемонтовПоСтруктуреПоиска(ДокументППР, ПланРемонтов, СтруктураПоиска);
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;

		КонецЕсли;

		РежимЗаписи = ?(ДокументППР.Проведен, РежимЗаписиДокумента.Проведение, РежимЗаписиДокумента.Запись);
		ДокументППР.РассчитаноНаВерсииППР = торо_СЛКСервер.Версия_Session(ИмяОбработки);
		ДокументППР.Записать(РежимЗаписи);

		Возврат Истина;
	ИначеЕсли ЭтоРасчетВизуализации Тогда
		Возврат ТаблицаРемонтов;
	Иначе
		Возврат ПланРемонтов;
	КонецЕсли;

КонецФункции
