#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	МультиязычностьКлиентСервер.ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка);
КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	МультиязычностьКлиентСервер.ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка);
КонецПроцедуры

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	МультиязычностьСервер.ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка, Метаданные.Справочники.торо_КатегорииРиска);
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ЗаполнитьСправочникНачальнымиДанными() Экспорт
	
	Запрос = Новый Запрос;
	# Область ТекстЗапроса
	Запрос.Текст = "ВЫБРАТЬ
	               |	торо_КатегорииВероятности.Ссылка КАК Ссылка,
	               |	торо_КатегорииВероятности.Наименование КАК Наименование
	               |ПОМЕСТИТЬ втКатегорииВероятности
	               |ИЗ
	               |	Справочник.торо_КатегорииВероятности КАК торо_КатегорииВероятности
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	торо_КатегорииТяжестиПоследствий.Ссылка КАК Ссылка,
	               |	торо_КатегорииТяжестиПоследствий.Наименование КАК Наименование
	               |ПОМЕСТИТЬ втКатегорииТяжестиПоследствий
	               |ИЗ
	               |	Справочник.торо_КатегорииТяжестиПоследствий КАК торо_КатегорииТяжестиПоследствий
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	втКатегорииВероятности.Ссылка КАК КатегорияВероятности,
	               |	втКатегорииТяжестиПоследствий.Ссылка КАК КатегорияТяжестиПоследствий,
	               |	втКатегорииВероятности.Наименование КАК КатегорияВероятностиНаименование,
	               |	втКатегорииТяжестиПоследствий.Наименование КАК КатегорияТяжестиПоследствийНаименование
	               |ПОМЕСТИТЬ ИтоговаяДляСоздания
	               |ИЗ
	               |	втКатегорииВероятности КАК втКатегорииВероятности,
	               |	втКатегорииТяжестиПоследствий КАК втКатегорииТяжестиПоследствий
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ИтоговаяДляСоздания.КатегорияВероятности КАК КатегорияВероятностиСсылка,
	               |	ИтоговаяДляСоздания.КатегорияТяжестиПоследствий КАК КатегорияТяжестиПоследствийСсылка,
	               |	ИтоговаяДляСоздания.КатегорияВероятностиНаименование КАК КатегорияВероятности,
	               |	ИтоговаяДляСоздания.КатегорияТяжестиПоследствийНаименование КАК КатегорияТяжестиПоследствий,
	               |	торо_КатегорииРиска.Ссылка КАК Ссылка
	               |ИЗ
	               |	ИтоговаяДляСоздания КАК ИтоговаяДляСоздания
	               |		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.торо_КатегорииРиска КАК торо_КатегорииРиска
	               |		ПО ИтоговаяДляСоздания.КатегорияВероятности = торо_КатегорииРиска.КатегорияВероятности
	               |			И ИтоговаяДляСоздания.КатегорияТяжестиПоследствий = торо_КатегорииРиска.КатегорияТяжестиПоследствий";
	# КонецОбласти
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат;
	КонецЕсли;
		
	ТаблицаСПарамиТяжестиПоследствийВеротяности = РезультатЗапроса.Выгрузить();
	ТаблицаСПарамиТяжестиПоследствийВеротяности.Индексы.Добавить("КатегорияВероятности, КатегорияТяжестиПоследствий");
	
	Макет = Справочники.торо_КатегорииРиска.ПолучитьМакет("НачальноеЗаполнение");
	
	ОбластьРеквизиты = Макет.ПолучитьОбласть("ЗаполняемыеРеквизиты");
	ОбластьДанные    = Макет.ПолучитьОбласть("ДанныеДляЗаполнения");
	
	Если ОбластьДанные.ВысотаТаблицы = 0 Тогда
		Возврат;
	КонецЕсли; 
	
	НомерКолонки = 1;
	
	МассивРеквизитов = Новый Массив;
	
	Пока Истина Цикл
		
		ЗначениеВЯчейке = ОбластьРеквизиты.Область(0, НомерКолонки, 0, НомерКолонки).Текст;
		
		Если Не ЗначениеЗаполнено(ЗначениеВЯчейке) Тогда
			Прервать;
		КонецЕсли; 	
		
		НомерКолонки = НомерКолонки + 1;
		
		МассивРеквизитов.Добавить(СокрЛП(ЗначениеВЯчейке));
		
	КонецЦикла;  	
	
	ЗначенияПеречисления = Метаданные.Перечисления.Периодичность.ЗначенияПеречисления;
	
	Для СтрокаНомер = 1 По ОбластьДанные.ВысотаТаблицы Цикл
		
		СтруктураЗначенийРеквизитов = Новый Структура(СтрСоединить(МассивРеквизитов, ","));
		
		Сч = 1;
		
		Для каждого КлючИЗНачение Из СтруктураЗначенийРеквизитов Цикл
			ЗначениеВЯчейке = ОбластьДанные.Область(СтрокаНомер,Сч,СтрокаНомер,Сч).Текст;
			СтруктураЗначенийРеквизитов[КлючИЗНачение.Ключ] = СокрЛП(ЗначениеВЯчейке);
			Сч = Сч + 1;
		КонецЦикла; 
		
		ЦветЯчейки = ОбластьДанные.Область(СтрокаНомер,1,СтрокаНомер,1).ЦветФона;
		
		СтруктураПоиска = Новый Структура("КатегорияВероятности, КатегорияТяжестиПоследствий");
		ЗаполнитьЗначенияСвойств(СтруктураПоиска, СтруктураЗначенийРеквизитов);			
		
		НайденнаяПараВероятностьТяжесть = ТаблицаСПарамиТяжестиПоследствийВеротяности.НайтиСтроки(СтруктураПоиска);
		
		Если НайденнаяПараВероятностьТяжесть.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		СоздатьИЗаполнитьОбъект(НайденнаяПараВероятностьТяжесть, СтруктураЗначенийРеквизитов, ЗначенияПеречисления, ЦветЯчейки);
		
	КонецЦикла; 
	
КонецПроцедуры

Процедура СоздатьИЗаполнитьОбъект(НайденнаяПараВероятностьТяжесть, СтруктураЗначенийРеквизитов, ЗначенияПеречисления, ЦветЯчейки)
	
	Если ЗначениеЗаполнено(НайденнаяПараВероятностьТяжесть[0].Ссылка) Тогда
		СоздаваемыйОбъект = НайденнаяПараВероятностьТяжесть[0].Ссылка.ПолучитьОбъект();
	Иначе
		СоздаваемыйОбъект = Справочники.торо_КатегорииРиска.СоздатьЭлемент();			
	КонецЕсли; 
	
	СоздаваемыйОбъект.Наименование = НайденнаяПараВероятностьТяжесть[0].КатегорияВероятности 
	+ НайденнаяПараВероятностьТяжесть[0].КатегорияТяжестиПоследствий;
	
	СоздаваемыйОбъект.КатегорияВероятности = НайденнаяПараВероятностьТяжесть[0].КатегорияВероятностиСсылка;
	СоздаваемыйОбъект.КатегорияТяжестиПоследствий = НайденнаяПараВероятностьТяжесть[0].КатегорияТяжестиПоследствийСсылка;
	СоздаваемыйОбъект.КритичностьДефекта = Справочники.торо_КритичностьДефекта.НайтиПоНаименованию(СтруктураЗначенийРеквизитов.КритичностьДефекта);
	
	СтруктураПарЗаполняемыхЗначений = Новый Структура;
	СтруктураПарЗаполняемыхЗначений.Вставить("ДатаНачала_КоличествоПериодов", "ДатаНачала_Период");
	СтруктураПарЗаполняемыхЗначений.Вставить("ДатаОкончания_КоличествоПериодов", "ДатаОкончания_Период");
	СтруктураПарЗаполняемыхЗначений.Вставить("ДатаПлановаяКрайняя_КоличествоПериодов", "ДатаПлановаяКрайняя_Период");
	
	Для каждого Структура Из СтруктураПарЗаполняемыхЗначений Цикл
		
		Периодичность = ЗначенияПеречисления.Найти(СтруктураЗначенийРеквизитов[Структура.Значение]);
		
		Если ЗначениеЗаполнено(СтруктураЗначенийРеквизитов[Структура.Значение]) 
			И Не Периодичность = Неопределено Тогда
			
			СоздаваемыйОбъект[Структура.Ключ]     = СтруктураЗначенийРеквизитов[Структура.Ключ];
			СоздаваемыйОбъект[Структура.Значение] = Перечисления.Периодичность[СтруктураЗначенийРеквизитов[Структура.Значение]];
		Иначе
			СоздаваемыйОбъект[Структура.Ключ]     = 0;
			СоздаваемыйОбъект[Структура.Значение] = Перечисления.Периодичность.ПустаяСсылка();
		КонецЕсли; 
		
	КонецЦикла; 
	
	Попытка
		Цвет = Вычислить("WebЦвета." + СтруктураЗначенийРеквизитов.Цвет);
	Исключение
		Цвет = ЦветЯчейки;
	КонецПопытки; 
	
	СоздаваемыйОбъект.Цвет = Новый ХранилищеЗначения(Цвет);
	
	Попытка
		СоздаваемыйОбъект.Записать();
	Исключение
		ШаблонСообщения = НСтр("ru = 'Не удалось заполнить справочник поставляемыми значениями. Причина ошибки: %1'"); 
		ТекстСообщения = СтрШаблон(ШаблонСообщения, ОписаниеОшибки());
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
	КонецПопытки; 

КонецПроцедуры

#КонецОбласти

#КонецЕсли


 

 