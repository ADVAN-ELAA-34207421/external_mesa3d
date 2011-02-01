// all allocations need to use hieralloc
typedef unsigned int size_t;

#include "prog_parameter.h"

#include "src/glsl/ir.h"

extern GLint _mesa_add_parameter(struct gl_program_parameter_list * paramList,
                                    const char * name)
{
   paramList->NumParameters++;
   if (paramList->NumParameters > paramList->Size) {
      paramList->Size = paramList->NumParameters + 4;
      paramList->Parameters = hieralloc_realloc(paramList, paramList->Parameters,
                              gl_program_parameter, paramList->Size);
   }

   gl_program_parameter * param = paramList->Parameters + paramList->NumParameters - 1;
   memset(param, 0, sizeof(*param));
   param->Name = hieralloc_strdup(paramList, name);
   param->BindLocation = -1;
   param->Location = -1;

   return paramList->NumParameters - 1;
}

extern GLint _mesa_get_parameter(const struct gl_program_parameter_list * paramList,
                                    const char * name)
{
   for (unsigned i = 0; i < paramList->NumParameters; i++)
      if (!strcmp(name, paramList->Parameters[i].Name))
         return i;
   return -1;
}
