#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// Сформировать печатные формы объектов.
//
// ВХОДЯЩИЕ:
//   МассивОбъектов  - Массив    - Массив ссылок на объекты которые нужно распечатать.
//
// ИСХОДЯЩИЕ:
//   КоллекцияПечатныхФорм - Таблица значений - Сформированные табличные документы.
//   ОшибкиПечати          - Список значений  - Ошибки печати  (значение - ссылка на объект, представление - текст
//                           ошибки).
//   ОбъектыПечати         - Список значений  - Объекты печати (значение - ссылка на объект, представление - имя
//                           области в которой был выведен объект).
//   ПараметрыВывода       - Структура        - Параметры сформированных табличных документов.
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	ПараметрыВывода.ДоступнаПечатьПоКомплектно = Истина;
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПФ_MXL_Т1") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
						КоллекцияПечатныхФорм,
						"ПФ_MXL_Т1", НСтр("ru='Приказ о приеме'"),
						ПолучитьТабличныйДокументПриказаТ1(УправлениеПечатью.МакетПечатнойФормы("Обработка.торо_ПечатьКадровыхПриказов.ПФ_MXL_Т1"), МассивОбъектов, ОбъектыПечати), ,
						"Обработка.торо_ПечатьКадровыхПриказов.ПФ_MXL_Т1");
	КонецЕсли;
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПФ_MXL_Т1а") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
						КоллекцияПечатныхФорм,
						"ПФ_MXL_Т1а", НСтр("ru='Приказ о приеме (Т-1а)'"),
						ПолучитьТабличныйДокументПриказаТ1а(УправлениеПечатью.МакетПечатнойФормы("Обработка.торо_ПечатьКадровыхПриказов.ПФ_MXL_Т1а"), МассивОбъектов, ОбъектыПечати), ,
						"Обработка.торо_ПечатьКадровыхПриказов.ПФ_MXL_Т1а");
	КонецЕсли;
					
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПФ_MXL_Т8") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
						КоллекцияПечатныхФорм,
						"ПФ_MXL_Т8", НСтр("ru='Приказ об увольнении'"),
						ПолучитьТабличныйДокументПриказаТ8(УправлениеПечатью.МакетПечатнойФормы("Обработка.торо_ПечатьКадровыхПриказов.ПФ_MXL_Т8"), МассивОбъектов, ОбъектыПечати), ,
						"Обработка.торо_ПечатьКадровыхПриказов.ПФ_MXL_Т8");
	КонецЕсли;	
					
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПФ_MXL_Т8а") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
						КоллекцияПечатныхФорм,
						"ПФ_MXL_Т8а", НСтр("ru='Приказ об увольнении (Т-8а)'"),
						ПолучитьТабличныйДокументПриказаТ8а(УправлениеПечатью.МакетПечатнойФормы("Обработка.торо_ПечатьКадровыхПриказов.ПФ_MXL_Т8а"), МассивОбъектов, ОбъектыПечати), ,
						"Обработка.торо_ПечатьКадровыхПриказов.ПФ_MXL_Т8а");
	КонецЕсли;	
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПФ_MXL_Т5") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
						КоллекцияПечатныхФорм,
						"ПФ_MXL_Т5", НСтр("ru='Приказ о переводе'"),
						ПолучитьТабличныйДокументПриказаТ5(УправлениеПечатью.МакетПечатнойФормы("Обработка.торо_ПечатьКадровыхПриказов.ПФ_MXL_Т5"), МассивОбъектов, ОбъектыПечати), ,
						"Обработка.торо_ПечатьКадровыхПриказов.ПФ_MXL_Т5");
	КонецЕсли;	
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПФ_MXL_Т5а") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
						КоллекцияПечатныхФорм,
						"ПФ_MXL_Т5а", НСтр("ru='Приказ о переводе (Т-5а)'"),
						ПолучитьТабличныйДокументПриказаТ5а(УправлениеПечатью.МакетПечатнойФормы("Обработка.торо_ПечатьКадровыхПриказов.ПФ_MXL_Т5а"), МассивОбъектов, ОбъектыПечати), ,
						"Обработка.торо_ПечатьКадровыхПриказов.ПФ_MXL_Т5а");
	КонецЕсли;	
	
КонецПроцедуры								

#Область ПроцедурыФункцииПечатиКадровыхДанных

// Процедура печати документа.
// Возвращает табличный документ - сформированную печатную форму приказа о приеме или увольнении.
//
// Параметры:
//	МассивОбъектов - массив сотрудников.
//  ОбъектыПечати  - Список значений  - Объекты печати (значение - ссылка на объект, представление - имя области в
//                   которой был выведен объект).
//	ВидПриказа     - "ПриказОПриеме" или "ПриказОбУвольнении".
//
// Возвращаемое значение:
//	Табличный документ
//
Функция ПолучитьТабличныйДокументПриказаТ1(Макет, МассивОбъектов, ОбъектыПечати)
	
	ДокументРезультат = Новый ТабличныйДокумент;
		
	ДокументРезультат.КлючПараметровПечати = "ПараметрыПечати_ПриказОПриеме";
	МассивДанныхЗаполнения = ПолучитьДанныеДляПечатиКадровогоПриказаТ1(МассивОбъектов);	
	
	ВывестиДанныеКадровогоПриказаВТабличныйДокумент(Макет, ДокументРезультат, МассивДанныхЗаполнения, ОбъектыПечати);
	
	ДокументРезультат.ТолькоПросмотр = Истина;
	Возврат ДокументРезультат;
КонецФункции 

// Процедура печати документа.
// Возвращает табличный документ - сформированную печатную форму приказа о приеме или увольнении.
//
// Параметры:
//	МассивОбъектов - массив сотрудников.
//  ОбъектыПечати  - Список значений  - Объекты печати (значение - ссылка на объект, представление - имя области в
//                   которой был выведен объект).
//	ВидПриказа     - "ПриказОПриеме" или "ПриказОбУвольнении".
//
// Возвращаемое значение:
//	Табличный документ
//
Функция ПолучитьТабличныйДокументПриказаТ1а(Макет, МассивОбъектов, ОбъектыПечати)
	
	ДокументРезультат = Новый ТабличныйДокумент;
		
	ДокументРезультат.КлючПараметровПечати = "ПараметрыПечати_ПриказОПриеме";
	МассивДанныхЗаполнения = ПолучитьДанныеДляПечатиКадровогоПриказаТ1а(МассивОбъектов);	
	
	ВывестиДанныеКадровогоПриказаСпискомВТабличныйДокумент(Макет, ДокументРезультат, МассивДанныхЗаполнения, ОбъектыПечати);
	
	ДокументРезультат.ТолькоПросмотр = Истина;
	Возврат ДокументРезультат;
КонецФункции 
	
// Процедура печати документа.
// Возвращает табличный документ - сформированную печатную форму приказа о приеме или увольнении.
//
// Параметры:
//	МассивОбъектов - массив сотрудников.
//  ОбъектыПечати  - Список значений  - Объекты печати (значение - ссылка на объект, представление - имя области в
//                   которой был выведен объект).
//	ВидПриказа     - "ПриказОПриеме" или "ПриказОбУвольнении".
//
// Возвращаемое значение:
//	Табличный документ
//
Функция ПолучитьТабличныйДокументПриказаТ5(Макет, МассивОбъектов, ОбъектыПечати)
	
	ДокументРезультат = Новый ТабличныйДокумент;
	
	ДокументРезультат.КлючПараметровПечати = "ПараметрыПечати_ПриказОПереводе";
	МассивДанныхЗаполнения = ПолучитьДанныеДляПечатиКадровогоПриказаТ5(МассивОбъектов);	
	
	ВывестиДанныеКадровогоПриказаВТабличныйДокумент(Макет, ДокументРезультат, МассивДанныхЗаполнения, ОбъектыПечати);
	
	ДокументРезультат.ТолькоПросмотр = Истина;
	Возврат ДокументРезультат;
КонецФункции 
	
// Процедура печати документа.
// Возвращает табличный документ - сформированную печатную форму приказа о приеме или увольнении.
//
// Параметры:
//	МассивОбъектов - массив сотрудников.
//  ОбъектыПечати  - Список значений  - Объекты печати (значение - ссылка на объект, представление - имя области в
//                   которой был выведен объект).
//	ВидПриказа     - "ПриказОПриеме" или "ПриказОбУвольнении".
//
// Возвращаемое значение:
//	Табличный документ
//
Функция ПолучитьТабличныйДокументПриказаТ5а(Макет, МассивОбъектов, ОбъектыПечати)
	
	ДокументРезультат = Новый ТабличныйДокумент;
	
	ДокументРезультат.КлючПараметровПечати = "ПараметрыПечати_ПриказОПереводе";
	МассивДанныхЗаполнения = ПолучитьДанныеДляПечатиКадровогоПриказаТ5а(МассивОбъектов);	
	
	ВывестиДанныеКадровогоПриказаСпискомВТабличныйДокумент(Макет, ДокументРезультат, МассивДанныхЗаполнения, ОбъектыПечати);
	
	ДокументРезультат.ТолькоПросмотр = Истина;
	Возврат ДокументРезультат;
КонецФункции 
	
// Процедура печати документа.
// Возвращает табличный документ - сформированную печатную форму приказа о приеме или увольнении.
//
// Параметры:
//	МассивОбъектов - массив сотрудников.
//  ОбъектыПечати  - Список значений  - Объекты печати (значение - ссылка на объект, представление - имя области в
//                   которой был выведен объект).
//	ВидПриказа     - "ПриказОПриеме" или "ПриказОбУвольнении".
//
// Возвращаемое значение:
//	Табличный документ
//
Функция ПолучитьТабличныйДокументПриказаТ8(Макет, МассивОбъектов, ОбъектыПечати)
	
	ДокументРезультат = Новый ТабличныйДокумент;

	ДокументРезультат.КлючПараметровПечати = "ПараметрыПечати_ПриказОбУвольнении";
	МассивДанныхЗаполнения = ПолучитьДанныеДляПечатиКадровогоПриказаТ8(МассивОбъектов);
	
	ВывестиДанныеКадровогоПриказаВТабличныйДокумент(Макет, ДокументРезультат, МассивДанныхЗаполнения, ОбъектыПечати);
	
	ДокументРезультат.ТолькоПросмотр = Истина;
	Возврат ДокументРезультат;
КонецФункции 
	
// Процедура печати документа.
// Возвращает табличный документ - сформированную печатную форму приказа о приеме или увольнении.
//
// Параметры:
//	МассивОбъектов - массив сотрудников.
//  ОбъектыПечати  - Список значений  - Объекты печати (значение - ссылка на объект, представление - имя области в
//                   которой был выведен объект).
//	ВидПриказа     - "ПриказОПриеме" или "ПриказОбУвольнении".
//
// Возвращаемое значение:
//	Табличный документ
//
Функция ПолучитьТабличныйДокументПриказаТ8а(Макет, МассивОбъектов, ОбъектыПечати)
	
	ДокументРезультат = Новый ТабличныйДокумент;

	ДокументРезультат.КлючПараметровПечати = "ПараметрыПечати_ПриказОбУвольнении";
	МассивДанныхЗаполнения = ПолучитьДанныеДляПечатиКадровогоПриказаТ8а(МассивОбъектов);
	
	ВывестиДанныеКадровогоПриказаСпискомВТабличныйДокумент(Макет, ДокументРезультат, МассивДанныхЗаполнения, ОбъектыПечати);
	
	ДокументРезультат.ТолькоПросмотр = Истина;
	Возврат ДокументРезультат;
КонецФункции 

Функция ПолучитьДанныеДляПечатиКадровогоПриказаТ1(МассивОбъектов)
	
	Выборка = СформироватьЗапросДляТ1(МассивОбъектов).Выбрать();
	
	МассивПараметров = Новый Массив;
	
	Пока Выборка.Следующий() Цикл
		
		Параметры = ПолучитьСтруктуруПараметровПриказаТ1();
		
		ЗаполнитьЗначенияСвойств(Параметры, Выборка);
		
		ЦелаяЧасть = Цел(Выборка.Оклад);
		Параметры.ОкладТарифнаяСтавкаЦелаяЧасть = ЦелаяЧасть;
		ДробнаяЧасть = Выборка.Оклад - ЦелаяЧасть;
		Параметры.ОкладТарифнаяСтавкаДробнаяЧасть = ?(ДробнаяЧасть = 0, "00", ДробнаяЧасть*100);
		
		МассивПараметров.Добавить(Параметры);
		
	КонецЦикла;
	
	Возврат МассивПараметров;

КонецФункции	

Функция ПолучитьДанныеДляПечатиКадровогоПриказаТ1а(МассивОбъектов)
	
	Выборка = СформироватьЗапросДляТ1а(МассивОбъектов).Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	МассивПараметров = Новый Массив;
	
	Пока Выборка.Следующий() Цикл
		
		ПараметрыДокумента = Новый Структура("ПараметрыДокумента, ПараметрыТЧ");
		ПараметрыДокумента.ПараметрыДокумента = ПолучитьСтруктуруПараметровПриказаТ1а();
		ЗаполнитьЗначенияСвойств(ПараметрыДокумента.ПараметрыДокумента, Выборка);
		
		МассивПараметровТЧ = Новый Массив();
		
		ВыборкаДокумента = Выборка.Выбрать();
		
		Пока ВыборкаДокумента.Следующий() Цикл
			
			Параметры = ПолучитьСтруктуруПараметровПриказаТ1а();
			
			ЗаполнитьЗначенияСвойств(Параметры, ВыборкаДокумента);
			
			ЦелаяЧасть = Цел(ВыборкаДокумента.Оклад);
			Параметры.ОкладТарифнаяСтавкаЦелаяЧасть = ЦелаяЧасть;
			ДробнаяЧасть = ВыборкаДокумента.Оклад - ЦелаяЧасть;
			Параметры.ОкладТарифнаяСтавкаДробнаяЧасть = ?(ДробнаяЧасть = 0, "00", ДробнаяЧасть*100);
			
			МассивПараметровТЧ.Добавить(Параметры);
			
		КонецЦикла;
		
		ПараметрыДокумента.ПараметрыТЧ = МассивПараметровТЧ;
		
		МассивПараметров.Добавить(ПараметрыДокумента);
		
	КонецЦикла;
	
	Возврат МассивПараметров;

КонецФункции	

Функция ПолучитьДанныеДляПечатиКадровогоПриказаТ5(МассивОбъектов)
	
	Выборка = СформироватьЗапросДляТ5(МассивОбъектов).Выбрать();
	
	МассивПараметров = Новый Массив;
	
	Пока Выборка.Следующий() Цикл
		
		Параметры = ПолучитьСтруктуруПараметровПриказаТ5();		
		
		ЗаполнитьЗначенияСвойств(Параметры, Выборка);
		
		ЦелаяЧасть = Цел(Выборка.Оклад);
		Параметры.ОкладТарифнаяСтавкаЦелаяЧасть = ЦелаяЧасть;
		ДробнаяЧасть = Выборка.Оклад - ЦелаяЧасть;
		Параметры.ОкладТарифнаяСтавкаДробнаяЧасть = ?(ДробнаяЧасть = 0, "00", ДробнаяЧасть*100);
		
		Если ЗначениеЗаполнено(Параметры.ДатаОкончания) Тогда
			Параметры.ВидПеревода = "Временно";
		Иначе
			Параметры.ВидПеревода = "Постоянно";
		КонецЕсли;
		
		МассивПараметров.Добавить(Параметры);
		
	КонецЦикла;
	
	Возврат МассивПараметров;

КонецФункции	

Функция ПолучитьДанныеДляПечатиКадровогоПриказаТ5а(МассивОбъектов)
	
	Выборка = СформироватьЗапросДляТ5а(МассивОбъектов).Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	МассивПараметров = Новый Массив;
	
	Пока Выборка.Следующий() Цикл
		
		ПараметрыДокумента = Новый Структура("ПараметрыДокумента, ПараметрыТЧ");
		ПараметрыДокумента.ПараметрыДокумента = ПолучитьСтруктуруПараметровПриказаТ5а();
		ЗаполнитьЗначенияСвойств(ПараметрыДокумента.ПараметрыДокумента, Выборка);
		
		МассивПараметровТЧ = Новый Массив();
		
		ВыборкаДокумента = Выборка.Выбрать();
		
		Пока ВыборкаДокумента.Следующий() Цикл
			
			Параметры = ПолучитьСтруктуруПараметровПриказаТ5а();
			
			ЗаполнитьЗначенияСвойств(Параметры, ВыборкаДокумента);
			
			ЦелаяЧасть = Цел(ВыборкаДокумента.Оклад);
			Параметры.ОкладТарифнаяСтавкаЦелаяЧасть = ЦелаяЧасть;
			ДробнаяЧасть = ВыборкаДокумента.Оклад - ЦелаяЧасть;
			Параметры.ОкладТарифнаяСтавкаДробнаяЧасть = ?(ДробнаяЧасть = 0, "00", ДробнаяЧасть*100);
			
			МассивПараметровТЧ.Добавить(Параметры);
			
		КонецЦикла;
		
		ПараметрыДокумента.ПараметрыТЧ = МассивПараметровТЧ;
		
		МассивПараметров.Добавить(ПараметрыДокумента);
		
	КонецЦикла;
	
	Возврат МассивПараметров;

КонецФункции	

Функция ПолучитьДанныеДляПечатиКадровогоПриказаТ8(МассивОбъектов)
	
	Выборка = СформироватьЗапросДляТ8(МассивОбъектов).Выбрать();
	
	МассивПараметров = Новый Массив;
	
	Пока Выборка.Следующий() Цикл
		
		Параметры = ПолучитьСтруктуруПараметровПриказаТ8();		
		
		ЗаполнитьЗначенияСвойств(Параметры, Выборка);

		ПредставлениеДатыУвольнения  = Формат(Выборка.ДатаУвольнения, "ДЛФ=DD");
		
		Параметры.ДатаУвольненияЧисло = ?(ЗначениеЗаполнено(Выборка.ДатаУвольнения),
			СокрЛП(Лев(ПредставлениеДатыУвольнения,2)),
			"      ");
		Параметры.ДатаУвольненияМесяцГод = ?(ЗначениеЗаполнено(Выборка.ДатаУвольнения),
			СокрЛП(Прав(ПредставлениеДатыУвольнения, СтрДлина(ПредставлениеДатыУвольнения)-2)),
			"                     г.");
		
		МассивПараметров.Добавить(Параметры);
		
	КонецЦикла;
	
	Возврат МассивПараметров;

КонецФункции	

Функция ПолучитьДанныеДляПечатиКадровогоПриказаТ8а(МассивОбъектов)
	
	Выборка = СформироватьЗапросДляТ8а(МассивОбъектов).Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	МассивПараметров = Новый Массив;
	
	Пока Выборка.Следующий() Цикл
		
		ПараметрыДокумента = Новый Структура("ПараметрыДокумента, ПараметрыТЧ");
		ПараметрыДокумента.ПараметрыДокумента = ПолучитьСтруктуруПараметровПриказаТ8а();
		ЗаполнитьЗначенияСвойств(ПараметрыДокумента.ПараметрыДокумента, Выборка);
		
		МассивПараметровТЧ = Новый Массив();
		
		ВыборкаДокумента = Выборка.Выбрать();
		
		Пока ВыборкаДокумента.Следующий() Цикл
			
			Параметры = ПолучитьСтруктуруПараметровПриказаТ8а();		
		
			ЗаполнитьЗначенияСвойств(Параметры, ВыборкаДокумента);

			ПредставлениеДатыУвольнения  = Формат(ВыборкаДокумента.ДатаУвольнения, "ДЛФ=DD");
			
			Параметры.ДатаУвольненияЧисло = ?(ЗначениеЗаполнено(ВыборкаДокумента.ДатаУвольнения),
				СокрЛП(Лев(ПредставлениеДатыУвольнения,2)),
				"      ");
			Параметры.ДатаУвольненияМесяцГод = ?(ЗначениеЗаполнено(ВыборкаДокумента.ДатаУвольнения),
				СокрЛП(Прав(ПредставлениеДатыУвольнения, СтрДлина(ПредставлениеДатыУвольнения)-2)),
				"                     г.");
			
			МассивПараметровТЧ.Добавить(Параметры);
			
		КонецЦикла;
		
		ПараметрыДокумента.ПараметрыТЧ = МассивПараметровТЧ;
		
		МассивПараметров.Добавить(ПараметрыДокумента);
		
	КонецЦикла;
	
	Возврат МассивПараметров;

КонецФункции	

Процедура ВывестиДанныеКадровогоПриказаВТабличныйДокумент(Макет, ТабличныйДокумент, МассивДанныхЗаполнения, ОбъектыПечати)
	
	Если Макет <> Неопределено Тогда
		
		ПервыйПриказ = Истина;
		Для каждого ПараметрыМакета Из МассивДанныхЗаполнения Цикл
			Если Не ПервыйПриказ Тогда
				ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
			Иначе
				ПервыйПриказ = Ложь;
			КонецЕсли;
			
			НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы + 1;
			
			Макет.Параметры.Заполнить(ПараметрыМакета);
			ТабличныйДокумент.Вывести(Макет);
			
			УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабличныйДокумент, НомерСтрокиНачало, ОбъектыПечати, ПараметрыМакета.Ссылка);	
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ВывестиДанныеКадровогоПриказаСпискомВТабличныйДокумент(Макет, ТабличныйДокумент, МассивДанныхЗаполнения, ОбъектыПечати)
	
	Если Макет = Неопределено Тогда
		
		Возврат;
		
	КонецЕсли;
	
	ПервыйПриказ = Истина;
	Для каждого ПараметрыДокумента Из МассивДанныхЗаполнения Цикл
		Если Не ПервыйПриказ Тогда
			ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
		Иначе
			ПервыйПриказ = Ложь;
		КонецЕсли;
		
		НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы + 1;
		
		Область = Макет.ПолучитьОбласть("Шапка");
		Область.Параметры.Заполнить(ПараметрыДокумента.ПараметрыДокумента);
		ТабличныйДокумент.Вывести(Область);
		
		Область = Макет.ПолучитьОбласть("ШапкаТаблицы");
		ТабличныйДокумент.Вывести(Область);
		
		Для каждого ПараметрыМакета Из ПараметрыДокумента.ПараметрыТЧ Цикл
		    Область = Макет.ПолучитьОбласть("Строка");
			Область.Параметры.Заполнить(ПараметрыМакета);
			ТабличныйДокумент.Вывести(Область);
		КонецЦикла;
		
		Область = Макет.ПолучитьОбласть("Подвал");
		Область.Параметры.Заполнить(ПараметрыДокумента.ПараметрыДокумента);
		ТабличныйДокумент.Вывести(Область);
		
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабличныйДокумент, НомерСтрокиНачало, ОбъектыПечати, ПараметрыДокумента.ПараметрыДокумента.Ссылка);	
		
	КонецЦикла;
	
КонецПроцедуры

Функция ПолучитьСтруктуруПараметровПриказаТ1()
	
	Параметры = ПолучитьСтруктуруПараметровКадровогоПриказа();
	
	Параметры.Вставить("ДатаПриема");
	Параметры.Вставить("ДатаЗавершенияТрудовогоДоговора");
	Параметры.Вставить("ОкладТарифнаяСтавкаЦелаяЧасть");
	Параметры.Вставить("ОкладТарифнаяСтавкаДробнаяЧасть");
	Параметры.Вставить("ВалютаТарифнойСтавки", "руб.");
	Параметры.Вставить("КопейкиТарифнойСтавки", "коп.");
	Параметры.Вставить("Надбавка", 0);
	Параметры.Вставить("ДлительностьИспытательногоСрока", "");

	Возврат Параметры;
	
КонецФункции	

Функция ПолучитьСтруктуруПараметровПриказаТ1а()
	
	Параметры = ПолучитьСтруктуруПараметровКадровогоПриказа();
	
	Параметры.Вставить("ДатаПриема");
	Параметры.Вставить("ДатаЗавершенияТрудовогоДоговора");
	Параметры.Вставить("ОкладТарифнаяСтавкаЦелаяЧасть");
	Параметры.Вставить("ОкладТарифнаяСтавкаДробнаяЧасть");
	Параметры.Вставить("ВалютаТарифнойСтавки", "руб.");
	Параметры.Вставить("КопейкиТарифнойСтавки", "коп.");
	Параметры.Вставить("Надбавка", 0);
	Параметры.Вставить("ДлительностьИспытательногоСрока", "");

	Возврат Параметры;
	
КонецФункции	

Функция ПолучитьСтруктуруПараметровПриказаТ5()
	
	Параметры = ПолучитьСтруктуруПараметровКадровогоПриказа();
	
	Параметры.Вставить("ДатаНачала");
	Параметры.Вставить("ДатаОкончания");
	Параметры.Вставить("ВидПеревода");
	Параметры.Вставить("Подразделение");
	Параметры.Вставить("Должность");
	Параметры.Вставить("НовоеПодразделение");
	Параметры.Вставить("НоваяДолжность");
	Параметры.Вставить("ОкладТарифнаяСтавкаЦелаяЧасть");
	Параметры.Вставить("ОкладТарифнаяСтавкаДробнаяЧасть");
	Параметры.Вставить("ВалютаТарифнойСтавки", "руб.");
	Параметры.Вставить("КопейкиТарифнойСтавки", "коп.");
	Параметры.Вставить("Надбавка", 0);
	Параметры.Вставить("ОснованиеПеревода");
	Параметры.Вставить("ПричинаПеревода");

	Возврат Параметры;
	
КонецФункции

Функция ПолучитьСтруктуруПараметровПриказаТ5а()
	
	Параметры = ПолучитьСтруктуруПараметровКадровогоПриказа();
	
	Параметры.Вставить("ДатаНачала");
	Параметры.Вставить("ДатаОкончания");
	Параметры.Вставить("ВидПеревода");
	Параметры.Вставить("Подразделение");
	Параметры.Вставить("Должность");
	Параметры.Вставить("НовоеПодразделение");
	Параметры.Вставить("НоваяДолжность");
	Параметры.Вставить("ОкладТарифнаяСтавкаЦелаяЧасть");
	Параметры.Вставить("ОкладТарифнаяСтавкаДробнаяЧасть");
	Параметры.Вставить("ВалютаТарифнойСтавки", "руб.");
	Параметры.Вставить("КопейкиТарифнойСтавки", "коп.");
	Параметры.Вставить("Надбавка", 0);
	Параметры.Вставить("ОснованиеПеревода");
	Параметры.Вставить("ПричинаПеревода");

	Возврат Параметры;
	
КонецФункции

Функция ПолучитьСтруктуруПараметровПриказаТ8()
	
	Параметры = ПолучитьСтруктуруПараметровКадровогоПриказа();
	
	Параметры.Вставить("ДатаУвольненияЧисло");
	Параметры.Вставить("ДатаУвольненияМесяцГод");
	Параметры.Вставить("ОснованиеУвольнения", "");
	
	Возврат Параметры;
	
КонецФункции

Функция ПолучитьСтруктуруПараметровПриказаТ8а()
	
	Параметры = ПолучитьСтруктуруПараметровКадровогоПриказа();
	
	Параметры.Вставить("ДатаУвольнения");
	Параметры.Вставить("ДатаУвольненияЧисло");
	Параметры.Вставить("ДатаУвольненияМесяцГод");
	Параметры.Вставить("ОснованиеУвольнения", "");
	
	Возврат Параметры;
	
КонецФункции

Функция СформироватьЗапросДляТ1(МассивОбъектов)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПриемНаРаботу.Ссылка,
		|	ПриемНаРаботу.Номер КАК НомерДок,
		|	ПриемНаРаботу.Дата КАК ДатаДок,
		|	ПриемНаРаботу.Организация КАК НазваниеОрганизации,
		|	ПриемНаРаботу.Подразделение,
		|	ПриемНаРаботу.Сотрудник КАК Работник,
		|	ПриемНаРаботу.Должность,
		|	ПриемНаРаботу.ДолжностьРуководителя,
		|	ПриемНаРаботу.Руководитель КАК РуководительРасшифровкаПодписи,
		|	ПриемНаРаботу.ДатаПриема,
		|	ПриемНаРаботу.ДатаЗавершенияТрудовогоДоговора,
		|	ПриемНаРаботу.ДлительностьИспытательногоСрока,
		|	ЕСТЬNULL(Сотрудники.Код, """") КАК ТабельныйНомер,
		|	ЕСТЬNULL(торо_ТекущиеТарифныеСтавкиСотрудников.Оклад, 0) КАК Оклад
		|ИЗ
		|	Документ.ПриемНаРаботу КАК ПриемНаРаботу
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК Сотрудники
		|		ПО ПриемНаРаботу.Сотрудник = Сотрудники.Ссылка
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ТекущиеТарифныеСтавкиСотрудников КАК торо_ТекущиеТарифныеСтавкиСотрудников
		|		ПО ПриемНаРаботу.Сотрудник = торо_ТекущиеТарифныеСтавкиСотрудников.Сотрудник
		|			И ПриемНаРаботу.Организация = торо_ТекущиеТарифныеСтавкиСотрудников.Организация
		|ГДЕ
		|	ПриемНаРаботу.Ссылка В(&МассивОбъектов)";
	
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса;
	
КонецФункции

Функция СформироватьЗапросДляТ1а(МассивОбъектов)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ПриемНаРаботуСписком.Ссылка КАК Ссылка,
		|	ПриемНаРаботуСписком.Номер КАК НомерДок,
		|	ПриемНаРаботуСписком.Дата КАК ДатаДок,
		|	ПриемНаРаботуСписком.Организация КАК НазваниеОрганизации,
		|	ПриемНаРаботуСписком.Организация.КодПоОКПО КАК ОрганизацияКодПоОКПО,
		|	ПриемНаРаботуСпискомСотрудники.Подразделение КАК Подразделение,
		|	ПриемНаРаботуСпискомСотрудники.Сотрудник КАК Работник,
		|	ПриемНаРаботуСпискомСотрудники.Должность КАК Должность,
		|	ПриемНаРаботуСписком.ДолжностьРуководителя КАК ДолжностьРуководителя,
		|	ПриемНаРаботуСписком.Руководитель КАК РуководительРасшифровкаПодписи,
		|	ПриемНаРаботуСпискомСотрудники.ДатаПриема КАК ДатаПриема,
		|	ПриемНаРаботуСпискомСотрудники.ДатаЗавершенияТрудовогоДоговора КАК ДатаЗавершенияТрудовогоДоговора,
		|	ПриемНаРаботуСпискомСотрудники.ДлительностьИспытательногоСрока КАК ДлительностьИспытательногоСрока,
		|	ЕСТЬNULL(СписокСотрудники.Код, """") КАК ТабельныйНомер,
		|	ЕСТЬNULL(торо_ТекущиеТарифныеСтавкиСотрудников.Оклад, 0) КАК Оклад
		|ИЗ
		|	Документ.ПриемНаРаботуСписком КАК ПриемНаРаботуСписком
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПриемНаРаботуСписком.Сотрудники КАК ПриемНаРаботуСпискомСотрудники
		|		ПО ПриемНаРаботуСписком.Ссылка = ПриемНаРаботуСпискомСотрудники.Ссылка
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК СписокСотрудники
		|		ПО (ПриемНаРаботуСпискомСотрудники.Сотрудник = СписокСотрудники.Ссылка)
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ТекущиеТарифныеСтавкиСотрудников КАК торо_ТекущиеТарифныеСтавкиСотрудников
		|		ПО (ПриемНаРаботуСпискомСотрудники.Сотрудник = торо_ТекущиеТарифныеСтавкиСотрудников.Сотрудник)
		|			И ПриемНаРаботуСписком.Организация = торо_ТекущиеТарифныеСтавкиСотрудников.Организация
		|ГДЕ
		|	ПриемНаРаботуСпискомСотрудники.Ссылка В(&МассивОбъектов)
		|ИТОГИ
		|	НомерДок КАК НомерДок,
		|	ДатаДок КАК ДатаДок,
		|	НазваниеОрганизации,
		|	ОрганизацияКодПоОКПО,
		|	ДолжностьРуководителя,
		|	РуководительРасшифровкаПодписи
		|ПО
		|	Ссылка";
	
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса;
	
КонецФункции

Функция СформироватьЗапросДляТ5(МассивОбъектов)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	КадровыйПеревод.Ссылка КАК Ссылка,
		|	КадровыйПеревод.Сотрудник КАК Сотрудник,
		|	КадровыйПеревод.Организация КАК Организация,
		|	МАКСИМУМ(КадроваяИсторияСотрудников.Период) КАК ДатаПредыдущейДолжности
		|ПОМЕСТИТЬ ВТ_ТекущиеКадровыеДанныеПериод
		|ИЗ
		|	Документ.КадровыйПеревод КАК КадровыйПеревод
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КадроваяИсторияСотрудников КАК КадроваяИсторияСотрудников
		|		ПО (КадроваяИсторияСотрудников.Сотрудник = КадровыйПеревод.Сотрудник)
		|			И (КадроваяИсторияСотрудников.Организация = КадровыйПеревод.Организация)
		|			И (КадроваяИсторияСотрудников.Регистратор <> КадровыйПеревод.Ссылка)
		|			И (КадроваяИсторияСотрудников.Период < КадровыйПеревод.Дата)
		|ГДЕ
		|	КадровыйПеревод.Ссылка В(&МассивОбъектов)
		|
		|СГРУППИРОВАТЬ ПО
		|	КадровыйПеревод.Ссылка,
		|	КадровыйПеревод.Организация,
		|	КадровыйПеревод.Сотрудник
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Ссылка,
		|	Сотрудник,
		|	Организация
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ТекущиеКадровыеДанныеПериод.Ссылка КАК Ссылка,
		|	ВТ_ТекущиеКадровыеДанныеПериод.Сотрудник КАК Сотрудник,
		|	ВТ_ТекущиеКадровыеДанныеПериод.Организация КАК Организация,
		|	КадроваяИсторияСотрудников.Подразделение,
		|	КадроваяИсторияСотрудников.Должность
		|ПОМЕСТИТЬ ВТ_ТекущиеКадровыеДанные
		|ИЗ
		|	ВТ_ТекущиеКадровыеДанныеПериод КАК ВТ_ТекущиеКадровыеДанныеПериод
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КадроваяИсторияСотрудников КАК КадроваяИсторияСотрудников
		|		ПО ВТ_ТекущиеКадровыеДанныеПериод.Сотрудник = КадроваяИсторияСотрудников.Сотрудник
		|			И ВТ_ТекущиеКадровыеДанныеПериод.Организация = КадроваяИсторияСотрудников.Организация
		|			И ВТ_ТекущиеКадровыеДанныеПериод.ДатаПредыдущейДолжности = КадроваяИсторияСотрудников.Период
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Ссылка,
		|	Сотрудник,
		|	Организация
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	КадровыйПеревод.Ссылка,
		|	КадровыйПеревод.Номер КАК НомерДок,
		|	КадровыйПеревод.Дата КАК ДатаДок,
		|	КадровыйПеревод.Организация КАК НазваниеОрганизации,
		|	КадровыйПеревод.Подразделение КАК НовоеПодразделение,
		|	КадровыйПеревод.Сотрудник КАК Работник,
		|	КадровыйПеревод.Должность КАК НоваяДолжность,
		|	КадровыйПеревод.ДолжностьРуководителя,
		|	КадровыйПеревод.Руководитель КАК РуководительРасшифровкаПодписи,
		|	ЕСТЬNULL(Сотрудники.Код, """") КАК ТабельныйНомер,
		|	ЕСТЬNULL(торо_ТекущиеТарифныеСтавкиСотрудников.Оклад, 0) КАК Оклад,
		|	КадровыйПеревод.ДатаНачала,
		|	КадровыйПеревод.ДатаОкончания,
		|	КадровыйПеревод.ПричинаПеревода,
		|	КадровыйПеревод.ОснованиеПеревода,
		|	ЕСТЬNULL(ВТ_ТекущиеКадровыеДанные.Подразделение, ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка)) КАК Подразделение,
		|	ЕСТЬNULL(ВТ_ТекущиеКадровыеДанные.Должность, ЗНАЧЕНИЕ(Справочник.Должности.ПустаяСсылка)) КАК Должность
		|ИЗ
		|	Документ.КадровыйПеревод КАК КадровыйПеревод
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК Сотрудники
		|		ПО КадровыйПеревод.Сотрудник = Сотрудники.Ссылка
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ТекущиеТарифныеСтавкиСотрудников КАК торо_ТекущиеТарифныеСтавкиСотрудников
		|		ПО КадровыйПеревод.Сотрудник = торо_ТекущиеТарифныеСтавкиСотрудников.Сотрудник
		|			И КадровыйПеревод.Организация = торо_ТекущиеТарифныеСтавкиСотрудников.Организация
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ТекущиеКадровыеДанные КАК ВТ_ТекущиеКадровыеДанные
		|		ПО КадровыйПеревод.Ссылка = ВТ_ТекущиеКадровыеДанные.Ссылка
		|			И КадровыйПеревод.Сотрудник = ВТ_ТекущиеКадровыеДанные.Сотрудник
		|			И КадровыйПеревод.Организация = ВТ_ТекущиеКадровыеДанные.Организация
		|ГДЕ
		|	КадровыйПеревод.Ссылка В(&МассивОбъектов)";
	
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса;
	
КонецФункции

Функция СформироватьЗапросДляТ5а(МассивОбъектов)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	КадровыйПереводСписком.Ссылка КАК Ссылка,
		|	КадровыйПереводСпискомСотрудники.Сотрудник КАК Сотрудник,
		|	КадровыйПереводСписком.Организация КАК Организация,
		|	МАКСИМУМ(КадроваяИсторияСотрудников.Период) КАК ДатаПредыдущейДолжности
		|ПОМЕСТИТЬ ВТ_ТекущиеКадровыеДанныеПериод
		|ИЗ
		|	Документ.КадровыйПереводСписком КАК КадровыйПереводСписком
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.КадровыйПереводСписком.Сотрудники КАК КадровыйПереводСпискомСотрудники
		|		ПО КадровыйПереводСписком.Ссылка = КадровыйПереводСпискомСотрудники.Ссылка
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КадроваяИсторияСотрудников КАК КадроваяИсторияСотрудников
		|		ПО (КадроваяИсторияСотрудников.Сотрудник = КадровыйПереводСпискомСотрудники.Сотрудник)
		|			И (КадроваяИсторияСотрудников.Организация = КадровыйПереводСписком.Организация)
		|			И (КадроваяИсторияСотрудников.Регистратор <> КадровыйПереводСписком.Ссылка)
		|			И (КадроваяИсторияСотрудников.Период < КадровыйПереводСписком.Дата)
		|ГДЕ
		|	КадровыйПереводСписком.Ссылка В(&МассивОбъектов)
		|
		|СГРУППИРОВАТЬ ПО
		|	КадровыйПереводСписком.Ссылка,
		|	КадровыйПереводСписком.Организация,
		|	КадровыйПереводСпискомСотрудники.Сотрудник
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Ссылка,
		|	Сотрудник,
		|	Организация
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ТекущиеКадровыеДанныеПериод.Ссылка КАК Ссылка,
		|	ВТ_ТекущиеКадровыеДанныеПериод.Сотрудник КАК Сотрудник,
		|	ВТ_ТекущиеКадровыеДанныеПериод.Организация КАК Организация,
		|	КадроваяИсторияСотрудников.Подразделение КАК Подразделение,
		|	КадроваяИсторияСотрудников.Должность КАК Должность
		|ПОМЕСТИТЬ ВТ_ТекущиеКадровыеДанные
		|ИЗ
		|	ВТ_ТекущиеКадровыеДанныеПериод КАК ВТ_ТекущиеКадровыеДанныеПериод
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КадроваяИсторияСотрудников КАК КадроваяИсторияСотрудников
		|		ПО ВТ_ТекущиеКадровыеДанныеПериод.Сотрудник = КадроваяИсторияСотрудников.Сотрудник
		|			И ВТ_ТекущиеКадровыеДанныеПериод.Организация = КадроваяИсторияСотрудников.Организация
		|			И ВТ_ТекущиеКадровыеДанныеПериод.ДатаПредыдущейДолжности = КадроваяИсторияСотрудников.Период
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Ссылка,
		|	Сотрудник,
		|	Организация
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	КадровыйПереводСписком.Ссылка КАК Ссылка,
		|	КадровыйПереводСписком.Номер КАК НомерДок,
		|	КадровыйПереводСписком.Дата КАК ДатаДок,
		|	КадровыйПереводСписком.Организация.Наименование КАК НазваниеОрганизации,
		|	КадровыйПереводСписком.Организация.КодПоОКПО КАК ОрганизацияКодПоОКПО,
		|	КадровыйПереводСпискомСотрудники.Подразделение КАК НовоеПодразделение,
		|	КадровыйПереводСпискомСотрудники.Сотрудник КАК Работник,
		|	КадровыйПереводСпискомСотрудники.Должность КАК НоваяДолжность,
		|	КадровыйПереводСписком.ДолжностьРуководителя.Наименование КАК ДолжностьРуководителя,
		|	КадровыйПереводСписком.Руководитель КАК РуководительРасшифровкаПодписи,
		|	ЕСТЬNULL(СписокСотрудники.Код, """") КАК ТабельныйНомер,
		|	ЕСТЬNULL(торо_ТекущиеТарифныеСтавкиСотрудников.Оклад, 0) КАК Оклад,
		|	КадровыйПереводСпискомСотрудники.ДатаНачала КАК ДатаНачала,
		|	КадровыйПереводСпискомСотрудники.ДатаОкончания КАК ДатаОкончания,
		|	КадровыйПереводСпискомСотрудники.ПричинаПеревода КАК ПричинаПеревода,
		|	КадровыйПереводСпискомСотрудники.ОснованиеПеревода КАК ОснованиеПеревода,
		|	ЕСТЬNULL(ВТ_ТекущиеКадровыеДанные.Подразделение, ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка)) КАК Подразделение,
		|	ЕСТЬNULL(ВТ_ТекущиеКадровыеДанные.Должность, ЗНАЧЕНИЕ(Справочник.Должности.ПустаяСсылка)) КАК Должность
		|ИЗ
		|	Документ.КадровыйПереводСписком КАК КадровыйПереводСписком
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.КадровыйПереводСписком.Сотрудники КАК КадровыйПереводСпискомСотрудники
		|		ПО КадровыйПереводСписком.Ссылка = КадровыйПереводСпискомСотрудники.Ссылка
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК СписокСотрудники
		|		ПО (КадровыйПереводСпискомСотрудники.Сотрудник = СписокСотрудники.Ссылка)
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ТекущиеТарифныеСтавкиСотрудников КАК торо_ТекущиеТарифныеСтавкиСотрудников
		|		ПО (КадровыйПереводСпискомСотрудники.Сотрудник = торо_ТекущиеТарифныеСтавкиСотрудников.Сотрудник)
		|			И КадровыйПереводСписком.Организация = торо_ТекущиеТарифныеСтавкиСотрудников.Организация
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ТекущиеКадровыеДанные КАК ВТ_ТекущиеКадровыеДанные
		|		ПО КадровыйПереводСписком.Ссылка = ВТ_ТекущиеКадровыеДанные.Ссылка
		|			И (КадровыйПереводСпискомСотрудники.Сотрудник = ВТ_ТекущиеКадровыеДанные.Сотрудник)
		|			И КадровыйПереводСписком.Организация = ВТ_ТекущиеКадровыеДанные.Организация
		|ГДЕ
		|	КадровыйПереводСписком.Ссылка В(&МассивОбъектов)
		|ИТОГИ
		|	НомерДок КАК НомерДок,
		|	ДатаДок КАК ДатаДок,
		|	НазваниеОрганизации,
		|	ОрганизацияКодПоОКПО,
		|	ДолжностьРуководителя,
		|	РуководительРасшифровкаПодписи
		|ПО
		|	Ссылка";
	
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса;
	
КонецФункции

Функция СформироватьЗапросДляТ8(МассивОбъектов)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Увольнение.Ссылка,
		|	Увольнение.Номер КАК НомерДок,
		|	Увольнение.Дата КАК ДатаДок,
		|	Увольнение.Организация КАК НазваниеОрганизации,
		|	Увольнение.Подразделение,
		|	Увольнение.Сотрудник КАК Работник,
		|	Увольнение.ДолжностьРуководителя,
		|	Увольнение.Руководитель КАК РуководительРасшифровкаПодписи,
		|	ЕСТЬNULL(Сотрудники.Код, """") КАК ТабельныйНомер,
		|	ЕСТЬNULL(ТекущиеКадровыеДанныеСотрудников.ТекущаяДолжность, ЗНАЧЕНИЕ(Справочник.Должности.ПустаяСсылка)) КАК Должность,
		|	Увольнение.ДатаУвольнения,
		|	Увольнение.ОснованиеУвольнения
		|ИЗ
		|	Документ.Увольнение КАК Увольнение
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК Сотрудники
		|		ПО Увольнение.Сотрудник = Сотрудники.Ссылка
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ТекущиеКадровыеДанныеСотрудников КАК ТекущиеКадровыеДанныеСотрудников
		|		ПО Увольнение.Сотрудник = ТекущиеКадровыеДанныеСотрудников.Сотрудник
		|			И Увольнение.Организация = ТекущиеКадровыеДанныеСотрудников.ТекущаяОрганизация
		|ГДЕ
		|	Увольнение.Ссылка В(&МассивОбъектов)";
	
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса;
	
КонецФункции

Функция СформироватьЗапросДляТ8а(МассивОбъектов)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	УвольнениеСписком.Ссылка КАК Ссылка,
		|	УвольнениеСписком.Номер КАК НомерДок,
		|	УвольнениеСписком.Дата КАК ДатаДок,
		|	УвольнениеСписком.Организация КАК НазваниеОрганизации,
		|	УвольнениеСписком.Организация.КодПоОКПО КАК ОрганизацияКодПоОКПО,
		|	УвольнениеСпискомСотрудники.Сотрудник КАК Работник,
		|	УвольнениеСписком.ДолжностьРуководителя КАК ДолжностьРуководителя,
		|	УвольнениеСписком.Руководитель КАК РуководительРасшифровкаПодписи,
		|	ЕСТЬNULL(СпписокСотрудники.Код, """") КАК ТабельныйНомер,
		|	ЕСТЬNULL(ТекущиеКадровыеДанныеСотрудников.ТекущаяДолжность, ЗНАЧЕНИЕ(Справочник.Должности.ПустаяСсылка)) КАК Должность,
		|	УвольнениеСпискомСотрудники.ДатаУвольнения КАК ДатаУвольнения,
		|	УвольнениеСпискомСотрудники.ОснованиеУвольнения КАК ОснованиеУвольнения
		|ИЗ
		|	Документ.УвольнениеСписком КАК УвольнениеСписком
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.УвольнениеСписком.Сотрудники КАК УвольнениеСпискомСотрудники
		|		ПО УвольнениеСписком.Ссылка = УвольнениеСпискомСотрудники.Ссылка
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК СпписокСотрудники
		|		ПО (УвольнениеСпискомСотрудники.Сотрудник = СпписокСотрудники.Ссылка)
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ТекущиеКадровыеДанныеСотрудников КАК ТекущиеКадровыеДанныеСотрудников
		|		ПО (УвольнениеСпискомСотрудники.Сотрудник = ТекущиеКадровыеДанныеСотрудников.Сотрудник)
		|			И УвольнениеСписком.Организация = ТекущиеКадровыеДанныеСотрудников.ТекущаяОрганизация
		|ГДЕ
		|	УвольнениеСписком.Ссылка В(&МассивОбъектов)
		|ИТОГИ
		|	НомерДок КАК НомерДок,
		|	ДатаДок КАК ДатаДок,
		|	НазваниеОрганизации КАК НазваниеОрганизации,
		|	ОрганизацияКодПоОКПО КАК ОрганизацияКодПоОКПО,
		|	УвольнениеСписком.ДолжностьРуководителя КАК ДолжностьРуководителя,
		|	РуководительРасшифровкаПодписи КАК РуководительРасшифровкаПодписи
		|ПО
		|	Ссылка";
	
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса;
	
КонецФункции

Функция ПолучитьСтруктуруПараметровКадровогоПриказа() Экспорт
	
	СтруктураПараметровКадровогоПриказа = Новый Структура;
	
	СтруктураПараметровКадровогоПриказа.Вставить("Ссылка");
	СтруктураПараметровКадровогоПриказа.Вставить("НазваниеОрганизации", "");
	СтруктураПараметровКадровогоПриказа.Вставить("ОрганизацияКодПоОКПО", "");
	СтруктураПараметровКадровогоПриказа.Вставить("НомерДок", "");
	СтруктураПараметровКадровогоПриказа.Вставить("ДатаДок", '00010101');
	СтруктураПараметровКадровогоПриказа.Вставить("Работник", "");
	СтруктураПараметровКадровогоПриказа.Вставить("ТабельныйНомер", "");
	СтруктураПараметровКадровогоПриказа.Вставить("Подразделение");
	СтруктураПараметровКадровогоПриказа.Вставить("Должность");
	СтруктураПараметровКадровогоПриказа.Вставить("ДолжностьРуководителя", "");
	СтруктураПараметровКадровогоПриказа.Вставить("РуководительРасшифровкаПодписи", "");
	
	Возврат СтруктураПараметровКадровогоПриказа;
		
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли