#include <stddef.h>
#include<stdio.h>

#define AIV_INT_ITEM(x) &(x.list_item)

typedef struct aiv_list_item Aiv_list_item;
typedef struct aiv_int_item Aiv_int_item;

struct  aiv_list_item
{
    Aiv_list_item* next;
    unsigned int count;
};

struct  aiv_int_item
{
    Aiv_list_item list_item;
    int value;
};

Aiv_list_item* aiv_list_get_tail(Aiv_list_item* head)
{
    if (!head)
    {
        return NULL;
    }

    Aiv_list_item* current_item = head;
    Aiv_list_item* last_item = head;

    while (current_item)
    {
        last_item = current_item;
        current_item = current_item->next;
    }

    return last_item;
}

Aiv_list_item* aiv_list_append(Aiv_list_item** head, Aiv_list_item* item)
{
    Aiv_list_item* tail = aiv_list_get_tail(*head);
    
    if (!tail)
    {
        *head = item;
        (*head)->count = 1;

    }
    else
    {
        tail->next = item;
        (*head)->count++;
    }

    item->next = NULL;
    return item;
}

Aiv_list_item* aiv_list_pop(Aiv_list_item** head)
{
    if(!*head)
    {
        return NULL;
    }

    Aiv_list_item* current_head = *head;
    const unsigned int current_count = current_head->count;
    *head = (*head)->next;
    if(*head)
    {
        (*head)->count = current_count - 1;
    }

    current_head->next = NULL;
    return current_head;
};

Aiv_list_item* aiv_list_get_item(Aiv_list_item** head, unsigned int index)
{
    if (!*head || index >= (*head)->count)
    {
        printf("Indice non valido\n");
        return NULL;
    }
    if (index == 0)
    {
        return aiv_list_pop(head);
    }
    
    
    Aiv_list_item* current_item = *head;
    Aiv_list_item* parent_of_wanted_item = *head;
    int i = 0;

    while(current_item != NULL && i < index)
    {
        current_item = current_item->next;
        i++;
        if (i == index - 1)
        {
            parent_of_wanted_item = current_item;
        }
    }
    
    parent_of_wanted_item->next = current_item->next;
    current_item->next = NULL;
    (*head)->count--;

    return current_item;
    
}

unsigned int aiv_list_lenght(Aiv_list_item* head)
{
    return head->count;
};

int main()
{
    Aiv_list_item* head = NULL;

    Aiv_int_item int_item;
    int_item.value = 100;
    aiv_list_append(&head, AIV_INT_ITEM(int_item));

    Aiv_int_item int_item2;
    int_item2.value = 101;
    aiv_list_append(&head, AIV_INT_ITEM(int_item2));

    Aiv_int_item int_item3;
    int_item3.value = 102;
    aiv_list_append(&head, AIV_INT_ITEM(int_item3));

    unsigned int index = 1;
    Aiv_int_item* returned_item = (Aiv_int_item*)aiv_list_get_item(&head, index);

    printf("Il valore dell'elemento all' indice %d e' %u\n", index, returned_item->value);

    Aiv_int_item* returned_item2 = (Aiv_int_item*)aiv_list_get_item(&head, index);

    printf("Il valore dell'elemento all' indice %d e' %u\n", index, returned_item2->value);
    printf("count: %u", aiv_list_lenght(head));

    return 0;
}