%{
#include <stdio.h>
void yyerror (const char *s) /* Called by yyparse on error */
{
    return;
}
%}
%token tMAIL tENDMAIL tSCHEDULE tENDSCH tSEND tSET tTO tFROM tAT tCOMMA tCOLON tLPR tRPR tLBR tRBR tIDENT tSTRING tADDRESS tDATE tTIME
%start program
%%
program: 
     | program mailblock
     | program setstmt
;
mailblock: tMAIL tFROM tADDRESS tCOLON stmt_list tENDMAIL
         | tMAIL tFROM tADDRESS tCOLON tENDMAIL
;
stmt_list: stmt
         | stmt_list stmt
;
stmt: setstmt
    | sendstmt
    | schedulestmt
;
setstmt: tSET tIDENT tLPR tSTRING tRPR
;
schedulestmt: tSCHEDULE tAT tLBR tDATE tCOMMA tTIME tRBR tCOLON sendstmt_r tENDSCH
;
sendstmt_r: sendstmt
          | sendstmt_r sendstmt
;
sendstmt: tSEND tLBR tIDENT tRBR tTO recipient_list
        | tSEND tLBR tSTRING tRBR tTO recipient_list
;
recipient_list: tLBR recipient_r tRBR
;
recipient_r: recipient
           | recipient_r tCOMMA recipient 
;
recipient: tLPR tADDRESS tRPR
         | tLPR tIDENT tCOMMA tADDRESS tRPR
         | tLPR tSTRING tCOMMA tADDRESS tRPR
;
%%
int main ()
{
if (yyparse()) {
    printf("ERROR\n");
    return 1;
    }
else {
    printf("OK\n");
    return 0;
    }
}
