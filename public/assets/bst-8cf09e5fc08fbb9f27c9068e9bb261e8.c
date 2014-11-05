#include "stdio.h"
#include "stdlib.h"

struct bst
{
	int datal
	struct bst *l_child;
	struct bst *r_child;
}*root = NULL;



void inorder(node *temp) {
   if (temp != NULL) {
      inorder(temp->l_child);
      printf("%d", temp->data);
      inorder(temp->r_child);
   }
}


int main()
{
	int data, run =0;
	node = (struct bst *) malloc(sizeof(struct bst));

	printf("enter data\n");
	scanf(" %d", &data);

    node->data = data;
    node->l_child = NULL;
    node-> r_child = NULL;
    root = node;

    while(run != 5)
    {
         printf("1. insert\n2.itr search\n3.rec search\n4.show\n5. exit");
         scanf(" %d", &run);

         switch(run)
         {
              case 1:
              //insert
              struct bst *node, *temp_check, *temp_parent;
              node = (struct bst *) malloc(sizeof(struct bst));
              printf("enter data\n");
              scanf(" %d", &data);

              node->data = data;
              node->l_child = NULL;
              node->r_child= NULL;

              temp_check = root;
              temp_parent = root;

              while(temp_check != NULL)
              {
                   if(data >temp_check->data)
                   {
                   	temp_parent = temp_check;
                   	temp_check = temp_check->r_child;
                   }
                   else if(data < temp_check->data)
                   {
                   	temp_parent = temp_check;
                   	temp_check = temp_check->l_child;
                   }
              }//end of while temp_check

              if(data > temp_parent->data)	temp_parent->r_child = node;
              else if(data < temp_parent->data) temp_parent->l_child = node;
              break;
         
            case 4:
            //show in order
             if (root == NULL)
	            printf("Tree Is Not Created");
	         else 
	         {
	            printf("\nThe Inorder display : ");
	            inorder(root);
	         }
	         break;


         }//end of swtich
    }//end of while run
}