#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
 
#include <driver/adc.h>
#include <esp_adc_cal.h>
#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <esp_err.h>
#include <esp_log.h>

#define SCREEN_WIDTH 128                                                          // OLED display width, in pixels
#define SCREEN_HEIGHT 32                                                          // OLED display height, in pixels
#define TIMG0_T0LOADLO_REG 0x3FF5F018
#define TIMG0_T0ALARMLO_REG 0x3FF5F010
#define TIMG0_T0CONFIG_REG 0x3FF5F000

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);                 // Cria um objeto display
char Txt[10];                                                                     // Vai salvar temperatura em string
int gpio_botao = 4;

//Termistor
int ThermistorPin = 34;
double adcMax = 4095;
double Vs = 3.3;

double R1 = 10000.0;   // voltage divider resistor value
double Beta = 3380.0;  // Beta value
double To = 298.15;    // Temperature in Kelvin for 25 degree Celsius
double Ro = 10000.0;   // Resistance of Thermistor at 25 degree Celsius
int read_and_display = 0;

esp_adc_cal_characteristics_t adc_cal;

void IRAM_ATTR botao(){
    read_and_display = 1;
    
  
}

void setup() 
{
    //config display
    Serial.begin(9600);                                                           // Inicia comunicação serial em 9600 bps
    if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C))                                // Address 0x3C for 128x32
    { 
        Serial.println(F("SSD1306 allocation failed"));
        for(;;);                                                                  // Don't proceed, loop forever
    }
    display.clearDisplay();
    Oled_WriteStr("Starting", 1, 0, 0); // Limpa o display
    delay(1000);
    clear_all();

    
    //configuracao do adc
    adc1_config_width(ADC_WIDTH_BIT_12);
    adc1_config_channel_atten(ADC1_CHANNEL_6, ADC_ATTEN_DB_0); //pin 34 esp32 devkit v1
    esp_adc_cal_value_t adc_type = esp_adc_cal_characterize(ADC_UNIT_1, ADC_ATTEN_DB_0, ADC_WIDTH_BIT_12, 1100, &adc_cal); //Inicializa a estrutura de calibracao
    
    //interrupcao
    pinMode(gpio_botao, INPUT);
    attachInterrupt(gpio_botao, botao, FALLING);
}

void loop() 
{
 

  
  
 
  
  if(read_and_display){
    double adc = read_adc(ThermistorPin);
    print_temp(adc);
    read_and_display = 0;
    timing(5000);
    clear_all();
  }

}

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------

void Oled_WriteStr(char *pStr, byte Size, byte x, byte y)
{
    display.setTextSize(Size);                                                    // The size of the text
    display.setTextColor(SSD1306_WHITE);                                          // Draw white text
    display.setCursor(x,y);                                                       // Start at top-left corner
    display.println(pStr);                                                        // Write a string in 0,0 location
    display.display();                                                            // Write the buffer contents into the display
}

void write_message(char *message_top, char *message_bottom){
    display.clearDisplay();
    Oled_WriteStr(message_top, 1, 0, 0); // Limpa o display
    Oled_WriteStr(message_bottom, 2, 50, 16);    
}

void clear_all(){
  display.clearDisplay();
  Oled_WriteStr("", 2, 50, 16);
}

double read_adc(int ThermistorPin){
  double adc = 0;
  for(int i = 0; i < 10; i++){
    adc += analogRead(ThermistorPin);
    timing(10);
  }
  adc /=10;
  return adc;
}

void print_temp(double adc){

  double Vs = 3.3;
  double R1 = 10000.0;   // voltage divider resistor value
  double Beta = 3380.0;  // Beta value
  double To = 298.15;    // Temperature in Kelvin for 25 degree Celsius
  double Ro = 10000.0;   // Resistance of Thermistor at 25 degree Celsius


  double Vout, Rt = 0;
  double T, Tc, Tf = 0;
  
  Vout = adc * Vs / adcMax;
  Rt = R1 * Vout / (Vs - Vout);
 
  T = 1 / (1 / To + log(Rt / Ro) / Beta); //  Kelvin
  Tc = T - 273.15;                   // Celsius

  //Cria a string com a temperatura
  sprintf(Txt, "%f", Tc);

  write_message("Temperatura:", Txt);

  
}

//-----------------------------------------------------
int timing(int miliSec){//Conta até 4.294.967.29 millisegundos
  if(miliSec > 429496729)
    return -1;
  REG_WRITE(TIMG0_T0LOADLO_REG, 0); // Defini recomeço
  REG_WRITE(TIMG0_T0ALARMLO_REG, 10*miliSec); // Defini alarme
  REG_WRITE(TIMG0_T0CONFIG_REG, 0xE3E80400); // Habilita timer, contagem crescente, reload automático e alarme
  
  while(REG_GET_BIT(TIMG0_T0CONFIG_REG, BIT10) == BIT10); // Monitora alarme em espera ocupada
 
  REG_WRITE(TIMG0_T0CONFIG_REG, 0x43E80000); // Desliga timer
  return 1;
}
