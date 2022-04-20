class CateGoryItem 
{
    int id;
    String name1;
    String name2;
    int categoryLevel;
    int parentCategoryId;
    String parentCategoryName1;
    String parentCategoryName2;
    bool isActive;
    int createdByUserId;
    DateTime createdDate;
    int updatedByUserId;
    DateTime updatedDate;

    CateGoryItem({
        this.id,
        this.name1,
        this.name2,
        this.categoryLevel,
        this.parentCategoryId,
        this.parentCategoryName1,
        this.parentCategoryName2,
        this.isActive,
        this.createdByUserId,
        this.createdDate,
        this.updatedByUserId,
        this.updatedDate,
    });



}