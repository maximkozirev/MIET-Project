//Данный модуль моделирует работу SPI-подобного интерфейса
//Авторы: Владимиров Н., Козырев М.
module SPI (
			input DataRead, //Индикатор готовности к приему (1-готов, 0-не готов)
			output DataReady, //Индикатор готовности к отпраке из платы на внешнее устройство
			input [4:0] DataSlave, //Шина приема данных
			input clk, //Ежу понятно, что это тактовый импульс
			input reset, //Обнуляет внутренние регистры и счетчик
			);
			
			reg [4:0] RegSlave; //Регистр роли Slave
			reg [3:0] Counter=0; //Задаем 4-битный счетчик
			assign DataSlave=RegSlave; //Передача данны из шины
			reg [4:0] RegMaster; //Регистр роли Master
			
			always @(posedge clk)
				begin
					if (DataRead == 1) //Если DataRead равен единице, 
					//то считываем данные с внешнего устройства
						begin
							if(reset) //Если Reset равен единице,
							//то обнуляем счетчик
								counter <=4'h0
							else
								if (counter=4'h8)
									counter <= 4'h0;
									DataReady <=1;
								else
									counter++;
									RegMaster[3]<=RegSlave[0];
									assign RegSlave = RegSlave >> 1;
									assign RegMaster = RegMaster >> 1;
						end
				end
endmodule;
						