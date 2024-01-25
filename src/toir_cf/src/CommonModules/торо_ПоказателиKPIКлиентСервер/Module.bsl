#Область ПрограммныйИнтерфейс

// Возвращает массив символов, запрещенных к использованию в формулах показателей KPI.
// Возвращаемое значение:
//		Массив - массив запрещенных символов.
Функция ПолучитьЗапрещенныеСимволыДляФормул() Экспорт
	
	ЗапрещенныеСимволы = Новый Массив;
	ЗапрещенныеСимволы.Добавить(" ");
	ЗапрещенныеСимволы.Добавить(".");
	ЗапрещенныеСимволы.Добавить(",");
	ЗапрещенныеСимволы.Добавить(";");
	ЗапрещенныеСимволы.Добавить(":");
	ЗапрещенныеСимволы.Добавить("/");
	ЗапрещенныеСимволы.Добавить("*");
	ЗапрещенныеСимволы.Добавить("+");
	ЗапрещенныеСимволы.Добавить("-");
	ЗапрещенныеСимволы.Добавить("=");
	ЗапрещенныеСимволы.Добавить("?");
	ЗапрещенныеСимволы.Добавить("!");
	ЗапрещенныеСимволы.Добавить("(");
	ЗапрещенныеСимволы.Добавить(")");
	ЗапрещенныеСимволы.Добавить("[");
	ЗапрещенныеСимволы.Добавить("]");
	ЗапрещенныеСимволы.Добавить("{");
	ЗапрещенныеСимволы.Добавить("}");
	ЗапрещенныеСимволы.Добавить("<");
	ЗапрещенныеСимволы.Добавить(">");
	ЗапрещенныеСимволы.Добавить("|");
	ЗапрещенныеСимволы.Добавить("\");
	ЗапрещенныеСимволы.Добавить("`");
	ЗапрещенныеСимволы.Добавить("~");
	ЗапрещенныеСимволы.Добавить("@");
	ЗапрещенныеСимволы.Добавить("$");
	ЗапрещенныеСимволы.Добавить("%");
	ЗапрещенныеСимволы.Добавить("^");
	ЗапрещенныеСимволы.Добавить("&");
	ЗапрещенныеСимволы.Добавить("#");
	ЗапрещенныеСимволы.Добавить("""");
	ЗапрещенныеСимволы.Добавить("'");
	ЗапрещенныеСимволы.Добавить(Символы.ПС);
	ЗапрещенныеСимволы.Добавить(Символы.Таб);
	ЗапрещенныеСимволы.Добавить(Символы.НПП);
	ЗапрещенныеСимволы.Добавить(Символы.ВК);
	ЗапрещенныеСимволы.Добавить(Символы.ВТаб);
	ЗапрещенныеСимволы.Добавить(Символы.ПФ);

	Возврат ЗапрещенныеСимволы;
	
КонецФункции

// Заполняет структуру параметров для открытия формы расшифровки.
// Параметры:
//		ФормаМонитора - ФормаКлиентскогоПриложения - форма отчета "Монитор KPI".
//		ПараметрыФормы - Структура - Структура параметров, которую необходимо дозаполнить.
//		ВариантАнализа - СправочникСсылка.торо_ВариантыАнализаПоказателейKPI - ссылка на вариант анализа.
//		Показатель - СправочникСсылка.торо_ПоказателиKPI - ссылка на показатель.
//		Разделитель - ЛюбаяСсылка, Булево, Строка, Дата, Число - значение разделителя.
//
Процедура ПодготовитьСтруктуруПараметровДляОтчетаРасшифровкиПоказателя(ФормаМонитора, ПараметрыФормы, ВариантАнализа, Показатель, Разделитель) Экспорт
	
	ПараметрыФормы.Вставить("ВариантАнализа", ВариантАнализа);
	ПараметрыФормы.Вставить("Разделитель", Разделитель);
	ПараметрыФормы.Вставить("ПредставлениеПараметров", торо_ПоказателиKPIКлиентСервер.СфомироватьСтрокуПараметров(ФормаМонитора));
	
	ТипАнализа = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(ВариантАнализа, "ТипАнализа");
	
	СтрокаПоказателя = ФормаМонитора.ДанныеПоказателей.НайтиСтроки(Новый Структура("Показатель, Разделитель", Показатель, Разделитель));
	Если СтрокаПоказателя.Количество() > 0 Тогда
		СтрокаПоказателя = СтрокаПоказателя[0];
		
		Если ТипАнализа = ПредопределенноеЗначение("Перечисление.торо_ТипыАнализа.ДинамикаИзменения") Тогда
			ПараметрыФормы.Вставить("АдресТаблицыДанных", СтрокаПоказателя.АдресХранилищаДанныхСПериодами);
			
		ИначеЕсли ТипАнализа = ПредопределенноеЗначение("Перечисление.торо_ТипыАнализа.ИзмерениеТекущегоСостояния") Тогда
			ПараметрыФормы.Вставить("АдресТаблицыДанных", СтрокаПоказателя.АдресХранилищаДанных);
			
		ИначеЕсли ТипАнализа = ПредопределенноеЗначение("Перечисление.торо_ТипыАнализа.ПокомпонентноеСравнениеДинамика") Тогда
			ПараметрыФормы.Вставить("АдресТаблицыДанных", СтрокаПоказателя.АдресХранилищаДанныхСПериодами);
			
		ИначеЕсли ТипАнализа = ПредопределенноеЗначение("Перечисление.торо_ТипыАнализа.ПокомпонентноеСравнениеСтруктура") Тогда
			ПараметрыФормы.Вставить("АдресТаблицыДанных", СтрокаПоказателя.АдресХранилищаДанных);
			
		ИначеЕсли ТипАнализа = ПредопределенноеЗначение("Перечисление.торо_ТипыАнализа.СравнениеСПрошлымПериодом") Тогда
			ПараметрыФормы.Вставить("АдресТаблицыДанных", СтрокаПоказателя.АдресХранилищаДанных);
			
			СтрокаПоказателяПрошлогоПериода = ФормаМонитора.ДанныеПоказателейЗаПрошлыйПериод.НайтиСтроки(Новый Структура("Показатель, Разделитель", Показатель, Разделитель));
			Если СтрокаПоказателяПрошлогоПериода.Количество() > 0 Тогда
				СтрокаПоказателяПрошлогоПериода = СтрокаПоказателяПрошлогоПериода[0];
				ПараметрыФормы.Вставить("АдресТаблицыДанныхПрошлогоПериода", СтрокаПоказателяПрошлогоПериода.АдресХранилищаДанных);
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СфомироватьСтрокуПараметров(ФормаМонитора) Экспорт
	
	ШаблонСтрокиПараметров = НСтр("ru='Период: %1
												|Период сравнения: %2'");
	
	СтрокаЗначениеПараметров = СтрШаблон(ШаблонСтрокиПараметров, 
		ПредставлениеПериода(ФормаМонитора.ОтборПоПериоду.ДатаНачала, ФормаМонитора.ОтборПоПериоду.ДатаОкончания),
		ПредставлениеПериода(ФормаМонитора.ОтборПоПериодуСравнения.ДатаНачала, ФормаМонитора.ОтборПоПериодуСравнения.ДатаОкончания));
	
	Возврат СтрокаЗначениеПараметров;	
		
КонецФункции

Функция ОкруглитьВверх(Число) Экспорт
	
	Возврат Цел(Число) + ?(Цел(Число) = Число, 0, 1);
	
КонецФункции

Функция ПолучитьТипДиаграммыПоЗначениюПеречисления(ТипДиаграммыПеречисление) Экспорт
	
	Если ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.Гистограмма") Тогда
		Возврат ТипДиаграммы.Гистограмма;
		
	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГистограммаГоризонтальная") Тогда
		Возврат ТипДиаграммы.ГистограммаГоризонтальная;
		
	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГистограммаГоризонтальнаяОбъемная") Тогда
		Возврат ТипДиаграммы.ГистограммаГоризонтальнаяОбъемная;
		
	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГистограммаНормированная") Тогда
		Возврат ТипДиаграммы.ГистограммаНормированная;
	
	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГистограммаНормированнаяГоризонтальная") Тогда
		Возврат ТипДиаграммы.ГистограммаНормированнаяГоризонтальная;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГистограммаНормированнаяГоризонтальнаяОбъемная") Тогда
		Возврат ТипДиаграммы.ГистограммаНормированнаяГоризонтальнаяОбъемная;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГистограммаНормированнаяОбъемная") Тогда
		Возврат ТипДиаграммы.ГистограммаНормированнаяОбъемная;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГистограммаОбъемная") Тогда
		Возврат ТипДиаграммы.ГистограммаОбъемная;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГистограммаСНакоплением") Тогда
		Возврат ТипДиаграммы.ГистограммаСНакоплением;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГистограммаСНакоплениемГоризонтальная") Тогда
		Возврат ТипДиаграммы.ГистограммаСНакоплениемГоризонтальная;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГистограммаСНакоплениемГоризонтальнаяОбъемная") Тогда
		Возврат ТипДиаграммы.ГистограммаСНакоплениемГоризонтальнаяОбъемная;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГистограммаСНакоплениемОбъемная") Тогда
		Возврат ТипДиаграммы.ГистограммаСНакоплениемОбъемная;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.График") Тогда
		Возврат ТипДиаграммы.График;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГрафикПоШагам") Тогда
		Возврат ТипДиаграммы.ГрафикПоШагам;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГрафикСНакоплением") Тогда
		Возврат ТипДиаграммы.ГрафикСНакоплением;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГрафикСОбластями") Тогда
		Возврат ТипДиаграммы.ГрафикСОбластями;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГрафикСОбластямиИНакоплением") Тогда
		Возврат ТипДиаграммы.ГрафикСОбластямиИНакоплением;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.ГрафикСОбластямиНормированный") Тогда
		Возврат ТипДиаграммы.ГрафикСОбластямиНормированный;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.Измерительная") Тогда
		Возврат ТипДиаграммы.Измерительная;

	ИначеЕсли ТипДиаграммыПеречисление = ПредопределенноеЗначение("Перечисление.торо_ТипыДиаграммПоказателей.Круговая") Тогда
		Возврат ТипДиаграммы.Круговая;

	Иначе
		Возврат ТипДиаграммы.График;
	КонецЕсли;
	
КонецФункции

Функция ПолучитьФорматнуюСтрокуДляДаты(Форма) Экспорт
	
	ИспользоватьДетализациюПоПериоду = Форма.ИспользоватьДетализациюПоПериоду;
	ДетализацияПоПериоду = Форма.ДетализацияПоПериоду;
	
	СтрокаФормата = "ДФ=dd.MM.yyyy";
	
	Если ИспользоватьДетализациюПоПериоду И ЗначениеЗаполнено(ДетализацияПоПериоду) Тогда
		Если ДетализацияПоПериоду = ПредопределенноеЗначение("Перечисление.Периодичность.Год") Тогда
			СтрокаФормата = "ДФ=yyyy";
		ИначеЕсли ДетализацияПоПериоду = ПредопределенноеЗначение("Перечисление.Периодичность.Полугодие") Тогда
			СтрокаФормата = "ДФ=MM.yyyy";
		ИначеЕсли ДетализацияПоПериоду = ПредопределенноеЗначение("Перечисление.Периодичность.Квартал") Тогда
			СтрокаФормата = "ДФ=MM.yyyy";
		ИначеЕсли ДетализацияПоПериоду = ПредопределенноеЗначение("Перечисление.Периодичность.Месяц") Тогда
			СтрокаФормата = "ДФ='MMMM yyyy'";
		ИначеЕсли ДетализацияПоПериоду = ПредопределенноеЗначение("Перечисление.Периодичность.Неделя") Тогда
			СтрокаФормата = "ДФ=dd.MM.yyyy";
		ИначеЕсли ДетализацияПоПериоду = ПредопределенноеЗначение("Перечисление.Периодичность.Декада") Тогда
			СтрокаФормата = "ДФ=dd.MM.yyyy";
		ИначеЕсли ДетализацияПоПериоду = ПредопределенноеЗначение("Перечисление.Периодичность.День") Тогда
			СтрокаФормата = "ДФ=dd.MM.yyyy";
		КонецЕсли;
	КонецЕсли;
	
	Возврат СтрокаФормата;
	
КонецФункции

#КонецОбласти

