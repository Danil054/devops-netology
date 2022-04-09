1.  

Найдите, где перечислены все доступные resource и data_source:  

(https://github.com/hashicorp/terraform-provider-aws/blob/55e9157c3ba093b834b30400e4dd045d8b26d518/internal/provider/provider.go#L412)  

сперва DataSource идут, потом resource  



Для создания очереди сообщений SQS используется ресурс aws_sqs_queue у которого есть параметр name.  
С каким другим параметром конфликтует name? Приложите строчку кода, в которой это указано.  

Конфликтует с параметром "name_prefix":  
(https://github.com/hashicorp/terraform-provider-aws/blob/55e9157c3ba093b834b30400e4dd045d8b26d518/internal/service/sqs/queue.go#L82)  
```
                "name": {
                        Type:          schema.TypeString,
                        Optional:      true,
                        Computed:      true,
                        ForceNew:      true,
                        ConflictsWith: []string{"name_prefix"},
                },
                "name_prefix": {
                        Type:          schema.TypeString,
                        Optional:      true,
                        Computed:      true,
                        ForceNew:      true,
                        ConflictsWith: []string{"name"},
```

Какая максимальная длина имени?  
Судя по коду ниже, максимальная длина 80 символов:  
```
func resourceQueueCustomizeDiff(_ context.Context, diff *schema.ResourceDiff, meta interface{}) error {
        fifoQueue := diff.Get("fifo_queue").(bool)
        contentBasedDeduplication := diff.Get("content_based_deduplication").(bool)

        if diff.Id() == "" {
                // Create.

                var name string

                if fifoQueue {
                        name = create.NameWithSuffix(diff.Get("name").(string), diff.Get("name_prefix").(string), FIFOQueueNameSuffix)
                } else {
                        name = create.Name(diff.Get("name").(string), diff.Get("name_prefix").(string))
                }

                var re *regexp.Regexp

                if fifoQueue {
                        re = regexp.MustCompile(`^[a-zA-Z0-9_-]{1,75}\.fifo$`)
                } else {
                        re = regexp.MustCompile(`^[a-zA-Z0-9_-]{1,80}$`)
                }

                if !re.MatchString(name) {
                        return fmt.Errorf("invalid queue name: %s", name)
                }
        }

        if !fifoQueue && contentBasedDeduplication {
                return fmt.Errorf("content-based deduplication can only be set for FIFO queue")
        }
```

Какому регулярному выражению должно подчиняться имя?  
см. код выше:  
```
if fifoQueue {
                        re = regexp.MustCompile(`^[a-zA-Z0-9_-]{1,75}\.fifo$`)
                } else {
                        re = regexp.MustCompile(`^[a-zA-Z0-9_-]{1,80}$`)
```

