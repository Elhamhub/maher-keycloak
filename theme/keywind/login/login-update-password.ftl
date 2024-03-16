<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/checkbox.ftl" as checkbox>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>

<@layout.registrationLayout
  displayMessage=!messagesPerField.existsError("password", "password-confirm")
  ;
  section
>

<style>
.password-conditions__item {
  position: relative;
  padding-inline-start: 24px;
}

.text-green-600.password-conditions__item::before,
.all-checked .password-conditions__item::after {
  background-color:rgb(22 163 74);
}

.password-conditions__item::before {
    content: "";
    width: 8px;
    height: 8px;
    background-color:rgb(37 99 235);
    display: inline-block;
    border-radius: 100%;
    position: absolute;
    top: 4px;
    inset-inline-start: 4px;
}

.password-conditions__item::after {
    content: "";
    position: absolute;
    height: 16px;
    width: 2px;
    top: 16px;
    inset-inline-start: 7px;
    display: inline-block;
    background-color: rgb(37 99 235);
}

#password-case-message::after {
  display: none;
}

</style>
  <#if section="header">
    ${msg("updatePasswordTitle")}
  <#elseif section="form">
    <@form.kw action=url.loginAction method="post">
      <input
        autocomplete="username"
        name="username"
        type="hidden"
        value="${username}"
      >
      <input autocomplete="current-password" name="password" type="hidden">
      <@input.kw
        autocomplete="new-password"
        autofocus=true
        invalid=messagesPerField.existsError("password", "password-confirm")
        label=msg("passwordNew")
        name="password-new"
        type="password"
        onkeyup="checkPasswordStrength(this.value)"
      />
      <@input.kw
        autocomplete="new-password"
        invalid=messagesPerField.existsError("password-confirm")
        label=msg("passwordConfirm")
        message=kcSanitize(messagesPerField.get("password-confirm"))
        name="password-confirm"
        type="password"
      />

      <!-- Progress bar -->
      <div class="w-full bg-gray-100 rounded-full h-2.5 overflow-hidden">
        <div id="password-strength-bar" class="bg-blue-600 h-2.5 rounded-full transition-all ease-in-out duration-500" style="width: 0%"></div>
      </div>
      <!-- END || Progress bar -->

      <!-- Validation password text -->
      <div class="password-conditions space-y-4">
        <div id="password-length-message" class="password-conditions__item text-xs">
          More than 6 characters.
        </div>
        <div id="password-strength-message" class="password-conditions__item text-xs">
          Combination of numbers and letters.
        </div>
        <div id="password-case-message" class="password-conditions__item text-xs">
          Lower-Case and Upper-Case letters.
        </div>
      </div>
      <!-- END || Validation password text -->

      <#if isAppInitiatedAction??>
        <@checkbox.kw
          checked=true
          label=msg("logoutOtherSessions")
          name="logout-sessions"
          value="on"
        />
      </#if>

      <@buttonGroup.kw>
        <#if isAppInitiatedAction??>
          <@button.kw color="primary" type="submit">
            ${msg("doSubmit")}
          </@button.kw>
          <@button.kw color="secondary" name="cancel-aia" type="submit" value="true">
            ${msg("doCancel")}
          </@button.kw>
        <#else>
          <@button.kw color="primary" type="submit">
            ${msg("doSubmit")}
          </@button.kw>
        </#if>
      </@buttonGroup.kw>
    </@form.kw>

    <script>
      function checkPasswordStrength(password) {
        let strengthMessageElement = document.querySelector('#password-strength-message');
        let lengthMessageElement = document.querySelector('#password-length-message');
        let caseMessageElement = document.querySelector('#password-case-message');
        let progressBar = document.querySelector('#password-strength-bar');
        let allConditions = document.querySelector('.password-conditions');

        // Check if the password contains a combination of numbers and letters
        let containsCombination = /^(?=.*[a-zA-Z])(?=.*\d).+$/.test(password);

        // Check if the password is more than 6 characters
        let isMoreThanSixCharacters = password.length > 6;

        // Check if the password has both lowercase and uppercase letters
        let hasLowerAndUpperCase = /^(?=.*[a-z])(?=.*[A-Z]).+$/.test(password);

        // Check if all conditions are true
        let allConditionsTrue = containsCombination && isMoreThanSixCharacters && hasLowerAndUpperCase;

        // Calculate the width for each segment (1/3 of the total width)
        let segmentWidth = 100 / 3;

        // Update progress bar width based on conditions
        let width = 0;
        width += containsCombination ? segmentWidth : 0;
        width += isMoreThanSixCharacters ? segmentWidth : 0;
        width += hasLowerAndUpperCase ? segmentWidth : 0;

        // Set the progress bar width
        progressBar.style.width = width + '%';

        // Display messages by default and add the "text-green-600" class only when the condition is true
        strengthMessageElement.classList.toggle('text-green-600', containsCombination);
        lengthMessageElement.classList.toggle('text-green-600', isMoreThanSixCharacters);
        caseMessageElement.classList.toggle('text-green-600', hasLowerAndUpperCase);

        // Add a success background when all conditions are true
        progressBar.classList.toggle('bg-green-600', allConditionsTrue);

        // Add a class to the parent element to change the color of the bullet and the line
        allConditions.classList.toggle('all-checked', allConditionsTrue);

      }
    </script>


  </#if>
</@layout.registrationLayout>
