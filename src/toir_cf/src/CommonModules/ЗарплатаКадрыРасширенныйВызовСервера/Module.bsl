
#Область СлужебныйПрограммныйИнтерфейс

Функция ФизическоеЛицоСотрудника(Сотрудник) Экспорт
	
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Сотрудник, "ФизическоеЛицо");
	
КонецФункции

Функция СтруктураПоМетаданным(ПолноеИмяОбъектаМетаданных) Экспорт
	
	МетаданныеОбъекта = Метаданные.НайтиПоПолномуИмени(ПолноеИмяОбъектаМетаданных);
	СтруктураОписания = Новый Структура;
	
	Для каждого Реквизит Из МетаданныеОбъекта.Реквизиты Цикл
		СтруктураОписания.Вставить(Реквизит.Имя);
	КонецЦикла;
	
	ТабличныеЧастиОбъекта = Новый Структура;
	ОписаниеТабличныхЧастей = Новый Структура;
	Для каждого ТабличнаяЧасть Из МетаданныеОбъекта.ТабличныеЧасти Цикл
		
		Если ТабличнаяЧасть.Имя = "ДополнительныеРеквизиты" Тогда
			Продолжить;
		КонецЕсли;
		
		ИменаРеквизитов = "";
		ДобавитьЗапятую = Ложь;
		Для каждого Реквизит Из ТабличнаяЧасть.Реквизиты Цикл
			
			Если Не ДобавитьЗапятую Тогда
				ДобавитьЗапятую = Истина;
			Иначе
				ИменаРеквизитов = ИменаРеквизитов + ",";
			КонецЕсли; 
			ИменаРеквизитов = ИменаРеквизитов + Реквизит.Имя;
			
		КонецЦикла;
		
		ОписаниеТабличныхЧастей.Вставить(ТабличнаяЧасть.Имя, ИменаРеквизитов);
		ТабличныеЧастиОбъекта.Вставить(ТабличнаяЧасть.Имя, Новый Массив);
		
	КонецЦикла;
	
	ТабличныеЧастиОбъекта.Вставить("ОписаниеТабличныхЧастей", ОписаниеТабличныхЧастей);
	
	СтруктураОписания.Вставить("ТабличныеЧасти", ТабличныеЧастиОбъекта);
	
	Возврат СтруктураОписания;
	
КонецФункции

#КонецОбласти
