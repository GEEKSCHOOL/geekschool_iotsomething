#include <wiringPi.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

#define MAX_TIME 85
#define DHT11PIN 7

int dht11_val[5]={0,0,0,0,0};
int res;

int dht11_read_val() {
    uint8_t lststate = HIGH;
    uint8_t counter=0;
    uint8_t j=0,i;
    float farenheit;

    for(i=0;i<5;i++) {
        dht11_val[i] = 0;
    }

    pinMode(DHT11PIN,OUTPUT);
    digitalWrite(DHT11PIN,LOW);
    delay(18);
    digitalWrite(DHT11PIN,HIGH);
    delayMicroseconds(40);
    pinMode(DHT11PIN,INPUT);

    for(i = 0 ; i < MAX_TIME ; i++ ) {
        counter = 0;
        while(digitalRead(DHT11PIN) == lststate) {
            counter++;
            delayMicroseconds(1);
            if(counter == 255) {
                break;
            }
        }
        lststate = digitalRead(DHT11PIN);
        if(counter == 255) {
            break;
        }
        // top 3 transistions are ignored
        if((i >= 4) && (i % 2 == 0)) {
            dht11_val[j/8] <<= 1;
            if(counter > 16) {
                dht11_val[j/8] |= 1;
            }
            j++;
        }
    }

    // verify cheksum and print the verified data
    if((j >= 40) && (dht11_val[4] == ((dht11_val[0] + dht11_val[1] + dht11_val[2] + dht11_val[3]) & 0xFF))) {
        time_t timer;
        struct tm *date;
        char str[256];
        timer = time(NULL);
        date = localtime(&timer);
        strftime(str, 255, "%Y%m%d%H%M%S", date);
//        strftime(str, 255, "%Y/%m/%d %H:%M:%S", date);
//        printf("%s ,", str);
//        printf("Humidity = %d.%d %% Temperature = %d.%d *C\n", dht11_val[0], dht11_val[1], dht11_val[2], dht11_val[3]);

        fprintf(stdout, "{\"date\":\"%s\",\"humidity\":\"%d.%d\",\"temperature\":\"%d.%d\"}", str, dht11_val[0], dht11_val[1], dht11_val[2], dht11_val[3]);

        return 2;
    }
}

int main(void) {
    if(wiringPiSetup() == -1) {
        exit(1);
    }

    while(1) {
        res = 1;
        res = dht11_read_val();
        if(res == 2) {
            return 0;
        }
        delay(3000);
    }

    return 1;
}

// gcc -o temperature -lwiringPi temperature.c
