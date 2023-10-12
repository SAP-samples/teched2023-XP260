using ProcessorService as service from '../../srv/processor-service';
using from '../../db/schema';

annotate service.Incidents with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>Title}',
        },
        {
            $Type : 'UI.DataField',
            Value : customer.name,
            Label : '{i18n>Customer}',
        },
        {
            $Type : 'UI.DataField',
            Value : status.descr,
            Label : '{i18n>Urgency}',
        },
        {
            $Type : 'UI.DataField',
            Value : urgency.descr,
            Label : '{i18n>Status}',
            Criticality : status.criticality,
        },
    ]
);
annotate service.Incidents with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID : 'Overview',
            Facets : [
                {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Details}',
                    ID : 'Details',
                    Target : '@UI.FieldGroup#Details',
                },],
        },
        {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Conversations}',
                    ID : 'i18nConversations',
                    Target : 'conversations/@UI.LineItem#i18nConversations',
                },
    ]
);
annotate service.Incidents with @(
    UI.SelectionFields : [
        status_code,
        urgency_code,
    ]
);
annotate service.Incidents with {
    status @Common.Label : 'Status'
};
annotate service.Incidents with {
    urgency @Common.Label : '{i18n>Urgency}'
};
annotate service.Status with {
    code @Common.Text : descr
};
annotate service.Urgency with {
    code @Common.Text : descr
};
annotate service.Incidents with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : customer.name,
        },
        TypeImageUrl : 'sap-icon://alert',
    }
);
annotate service.Incidents with @(
    UI.FieldGroup #Details : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : customer_ID,
                Label : '{i18n>Customer}',
            },
            {
                $Type : 'UI.DataField',
                Value : status_code,
                Label : '{i18n>Status}',
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
                Label : 'Urgency',
            }],
    }
);

annotate service.Incidents with {
    customer @Common.Text : {
            $value : customer.name,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.Incidents with {
    customer @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'email',
                },
            ],
        },
        Common.ValueListWithFixedValues : false
)};
annotate service.Customers with {
    ID @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextOnly,
    }
};
annotate service.Conversations with @(
    UI.LineItem #i18nConversations : [
        {
            $Type : 'UI.DataField',
            Value : author,
            Label : 'author',
        },
        {
            $Type : 'UI.DataField',
            Value : timestamp,
            Label : '{i18n>ConversationDate}',
        },{
            $Type : 'UI.DataField',
            Value : message,
            Label : 'message',
        },]
);
annotate service.Status with {
    descr @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Status',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : descr,
                    ValueListProperty : 'name',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.Incidents with {
    urgency @Common.Text : urgency.descr
};
annotate service.Incidents with {
    urgency @Common.ValueListWithFixedValues : true
};
annotate service.Incidents with {
    status @Common.Text : status.descr
};
annotate service.Incidents with {
    status @Common.ValueListWithFixedValues : true
};
