#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>
#include <unistd.h>
#include <sys/ioctl.h>

#include <libbase58.h>

size_t binsz, b58sz;
void *data, *b58;

int main(int argc, char **argv) {
  /* get how many input bytes there are and read them */
  ioctl(STDIN_FILENO, FIONREAD, &binsz);
  data = malloc(binsz);
  read(STDIN_FILENO, data, binsz);

  /* pass them to the library function */
  b58sz = (size_t)((double)binsz * 1.5);
  b58 = malloc(b58sz);
  b58enc(b58, &b58sz, data, binsz);

  /* cleanup */
  free(b58);
  free(data);
  return 0;
}

