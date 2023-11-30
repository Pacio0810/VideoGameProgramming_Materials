#include <stddef.h>
#include<stdio.h>

struct  aiv_list_item
{
    struct aiv_list_item* next;
    unsigned int count;
};

struct  aiv_int_item
{
    struct aiv_list_item list_item;
    int value;
};

struct aiv_list_item * aiv_list_get_tail(struct aiv_list_item* head)
{
    if (!head)
    {
        return NULL;
    }

    struct aiv_list_item* current_item = head;
    struct aiv_list_item* last_item = head;

    while (current_item)
    {
        last_item = current_item;
        current_item = current_item->next;
    }

    return last_item;
}

struct aiv_list_item * aiv_list_append(struct aiv_list_item** head, struct aiv_list_item* item)
{
    struct aiv_list_item* tail = aiv_list_get_tail(*head);
    
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

struct aiv_list_item* aiv_list_pop(struct aiv_list_item** head)
{
    if(!*head)
    {
        return NULL;
    }

    struct aiv_list_item* current_head = *head;
    const unsigned int current_count = current_head->count;
    *head = (*head)->next;
    if(*head)
    {
        (*head)->count = current_count - 1;
    }

    current_head->next = NULL;
    return current_head;
};

struct aiv_list_item* aiv_list_get_item(struct aiv_list_item** head, unsigned int index)
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
    
    
    struct aiv_list_item* current_item = *head;
    struct aiv_list_item* parent_of_wanted_item = *head;
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

unsigned int aiv_list_lenght(struct aiv_list_item* head)
{
    return head->count;
};

int main()
{
    struct aiv_list_item * head = NULL;

    struct aiv_int_item int_item;
    int_item.value = 100;
    aiv_list_append(&head, (struct aiv_list_item*)&int_item);

    struct aiv_int_item int_item2;
    int_item2.value = 101;
    aiv_list_append(&head, (struct aiv_list_item*)&int_item2);

    struct aiv_int_item int_item3;
    int_item3.value = 102;
    aiv_list_append(&head, (struct aiv_list_item*)&int_item3);

    unsigned int index = 1;
    struct aiv_int_item* returned_item = (struct aiv_int_item*)aiv_list_get_item(&head, index);

    printf("Il valore dell'elemento all' indice %d e' %u\n", index, returned_item->value);

    struct aiv_int_item* returned_item2 = (struct aiv_int_item*)aiv_list_get_item(&head, index);

    printf("Il valore dell'elemento all' indice %d e' %u\n", index, returned_item2->value);
    printf("count: %u", aiv_list_lenght(head));

    return 0;
}