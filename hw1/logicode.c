#include <stdio.h>

int x(float A, float B){
    float value = 0;
    value = (((int)A + 4) % 2) + ((B + 1) / 2) - (A / 2) * ((int)B % 2);
    if(1 < value && value < 2.5)
        return 1;
    else
        return 0;
}

int y(float A, float B){
    if(((A + 5)/(B + 3) * ((int)B << 5)) > ((A + 3) / (B + 3) * ((int)A << 5)))
        return 1;
    return 0;
}

int z(float A, float B){
    if((A - B != 0) && ((A + B) / (A - B) > -2))
        return 1;
    return 0;
}

int q(int A, int B){
    if(A - B > -1)
        return 1;
    else
        return 0;
}

int main(){
    int A0, A1, B0, B1;

    for(A0 = 0; A0 < 2; A0++){
        for(A1 = 0; A1 < 2; A1++){
            for(B0 = 0; B0 < 2; B0++){
                for(B1 = 0; B1 < 2; B1++){
                    printf("A0: %d, A1: %d, B0: %d, B1: %d\n", A0, A1, B0, B1);
                }
            }
             
        }
    }

    return 0;
}