import { Component, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { TranslateService } from '@ngx-translate/core';

@Component({
  selector: 'public-${variables.etoName?lower_case}-dialog',
  templateUrl: './${variables.etoName?lower_case}-dialog.component.html',
})
export class ${variables.etoName?cap_first}DialogComponent {

  title: string;
  items: any = {
  <#list pojo.fields as field>
    ${field.name?lower_case}: '',
  </#list>
  };

  constructor(
    private translate: TranslateService,
    public dialogRef: MatDialogRef<${variables.etoName?cap_first}DialogComponent>,
    @Inject(MAT_DIALOG_DATA) dialogData: any,
  ) {
    if (!dialogData) {
      this.title = this.getTranslation('${variables.component}.addTitle');
    } else {
      this.title = this.getTranslation('${variables.component}.editTitle');
      <#list pojo.fields as field>
        this.items.${field.name?lower_case}: dialogData.${field.name?lower_case};
      </#list>
      this.items.id = dialogData.id;
      this.items.modificationCounter = dialogData.modificationCounter;
    }
  }

  getTranslation(text: string): string {
    let value: string;
    this.translate.get(text).subscribe((res: any) => {
      value = res;
    });
    return value;
  }
}
