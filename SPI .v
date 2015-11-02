//������ ������ ���������� ������ SPI-��������� ����������
//������: ���������� �., ������� �.
module SPI (
			input DataRead, //��������� ���������� � ������ (1-�����, 0-�� �����)
			output DataReady, //��������� ���������� � ������� �� ����� �� ������� ����������
			input [4:0] DataSlave, //���� ������ ������
			input clk, //��� �������, ��� ��� �������� �������
			input reset, //�������� ���������� �������� � �������
			);
			
			reg [4:0] RegSlave; //������� ���� Slave
			reg [3:0] Counter=0; //������ 4-������ �������
			assign DataSlave=RegSlave; //�������� ����� �� ����
			reg [4:0] RegMaster; //������� ���� Master
			
			always @(posedge clk)
				begin
					if (DataRead == 1) //���� DataRead ����� �������, 
					//�� ��������� ������ � �������� ����������
						begin
							if(reset) //���� Reset ����� �������,
							//�� �������� �������
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
						