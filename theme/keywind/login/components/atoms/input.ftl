<#import "/assets/icons/icon-user.ftl" as iconUser>
<#import "/assets/icons/icon-password.ftl" as iconPassword>
<#import "/assets/icons/icon-eye.ftl" as iconEye>
<#import "/assets/icons/icon-eye-close.ftl" as iconEyeClose>
<#macro
  kw
  autofocus=false
  disabled=false
  invalid=false
  label=""
  message=""
  name=""
  icon=""
  required=true
  rest...
>
  <div class="relative form-group <#if icon?has_content> with-icon</#if>">
    <#if icon?has_content>
      <span class="form-group-icon">
        <#if icon == "user">
          <@iconUser.kw />
        <#elseif icon == "password">
          <@iconPassword.kw />
        </#if>
      </span>
    </#if>
    <#list rest as attrName, attrValue>
      <#if attrValue == "password">
        <span class="password-toggle" onclick="togglePasswordVisibility('${name}')">
          <@iconEye.kw />
          <@iconEyeClose.kw />
        </span>
      </#if>
    </#list>
      <#--  <#if required>required</#if>  -->
    <input
      <#if autofocus>autofocus</#if>
      <#if disabled>disabled</#if>

      aria-invalid="${invalid?c}"
      class="form-input block placeholder-shown:border-secondary-200 border-black  mt-1 px-4 rounded-xxl w-full autofill:shadow-none autofill:bg-white autofill:border-black focus-within:border-black focus:ring-0 focus:outline-none text-xs/[1.375rem]
      <#if invalid>border-red-600 focus-within:border-red-600 placeholder-shown:!border-red-600</#if>"
      id="${name}"
      name="${name}"
      placeholder="&nbsp;"
 
      <#list rest as attrName, attrValue>
        ${attrName}="${attrValue}"
      </#list>
    >
    
    <label class="floating-label" for="${name}">
      ${label}
    </label>
    <#if invalid?? && message??>
      <div class="mt-2 text-red-600 text-[0.625rem] ps-10">
        ${message?no_esc}
      </div>
    </#if>
  </div>

  
    
  <script>
  // JavaScript function to toggle password visibility
  function togglePasswordVisibility(inputName) {
    var passwordInput = document.getElementById(inputName);
    var eyeIcon = document.getElementById('eyeIcon');
    var eyeCloseIcon = document.getElementById('eyeCloseIcon');

    if (passwordInput.type === 'password') {
      // Password is currently hidden, make eyeIcon visible and eyeCloseIcon hidden
      eyeIcon.style.display = 'none';
      eyeCloseIcon.style.display = 'block';
    } else {
      // Password is currently visible, make eyeIcon hidden and eyeCloseIcon visible
      eyeIcon.style.display = 'block';
      eyeCloseIcon.style.display = 'none';
    }

    // Toggle the password input type
    passwordInput.type = (passwordInput.type === 'password') ? 'text' : 'password';
  }
</script>
</#macro>
