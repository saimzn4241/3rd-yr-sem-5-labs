#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <time.h>


int main(){
  int i,j,k,l,m,n,c,welcomeSocket, newSocket;
  
  char  key[100]={'l','d','a','o','k','b','c','e','p','g','h','f','m','n','i','j','t','u','q','r','s','x','y','z','v','w'};
  char table[30][30];
  char buffer[1024];
  struct sockaddr_in serverAddr;
  struct sockaddr_storage serverStorage;
  
 clock_t t;
    t = clock();
  socklen_t addr_size;


  /*---- Create the socket. The three arguments are: ----*/
  /* 1) Internet domain 2) Stream socket 3) Default protocol (TCP in this case) */
  welcomeSocket = socket(PF_INET, SOCK_STREAM, 0);
  
  /*---- Configure settings of the server address struct ----*/
  /* Address family = Internet */
  serverAddr.sin_family = AF_INET;
  /* Set port number, using htons function to use proper byte order */
  serverAddr.sin_port = htons(7891);
  /* Set IP address to localhost */
  serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
  /* Set all bits of the padding field to 0 */
  memset(serverAddr.sin_zero, '\0', sizeof serverAddr.sin_zero);  

  /*---- Bind the address struct to the socket ----*/
  bind(welcomeSocket, (struct sockaddr *) &serverAddr, sizeof(serverAddr));

  /*---- Listen on the socket, with 5 max connection requests queued ----*/
  if(listen(welcomeSocket,5)==0)
    printf("Listening\n");
  else
    printf("Error\n");

  /*---- Accept call creates a new socket for the incoming connection ----*/
  addr_size = sizeof serverStorage;
  newSocket = accept(welcomeSocket, (struct sockaddr *) &serverStorage, &addr_size);

  /*---- Send message to the socket of the incoming connection ----*/
  strcpy(buffer,"Hello World ");
  for ( i = 0; i < 26; ++i)
  {
    c=i;
    for (j = 0; j < 26; ++j)
    {
      table[i][j]=c+'a';
      c++;
      c=c%26;
    }
  }
  for ( i = 0; i < strlen(buffer); ++i)
  {
    if(buffer[i]==' ')
      continue;
    
    if(buffer[i]>='A' && buffer[i]<='Z')
    buffer[i]=(buffer[i]-'A'+'a');  
    
    buffer[i]=table[key[i%26]-'a'][buffer[i]-'a'];
    printf("%c\n",buffer[i] );
  
  }
   t = clock() - t;
    double time_taken = ((double)t)/CLOCKS_PER_SEC; // in seconds
 
    printf("encription took %f seconds to execute \n", time_taken);
  send(newSocket,buffer,13,0);

  return 0;
}