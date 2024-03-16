<#import "document.ftl" as document>
<#import "components/atoms/background.ftl" as background>
<#import "components/atoms/card.ftl" as card>
<#import "components/atoms/container.ftl" as container>
<#import "components/atoms/footer.ftl" as footer>
<#import "components/atoms/header.ftl" as header>
<#import "components/atoms/main.ftl" as main>

<#macro emailLayout>
<!DOCTYPE html>
<html lang="ar">
    <@document.kw script=script />
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
  <body style="background-color: #EFEFEF; text-align: right; direction: rtl;">
    <@background.kw />
    <@container.kw>
      <@card.kw>
        <@header.kw />
        <@main.kw>
          <#nested>
        </@main.kw>
      </@card.kw>
      <@footer.kw />
    </@container.kw>
  </body>
</html>
</#macro>
