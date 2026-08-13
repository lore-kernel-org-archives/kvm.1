Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27D43E9F4
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608653; cv=none; b=ezcjalhykcRGr4XWtdJlcF2QHBpEec7r8dklWcsi8REIwr00m6gwTis4zCQi29JTaNoFcLPf0fIvME+SaGNIYfWv2fc4PuXzHV6xXvLLu8gSLHLdSaBf6YU0ZTqi0RiOPHT9wN5pCHKQ0VNNtX9tzdqhxvLJxODUYGAihSGvyEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608653; c=relaxed/simple;
	bh=2vW8nPjiF+fKmhpleG4r/1VZ5Ror7CluAB366amg3HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1Lf7oViyD6sjOBUuN+twa4O3AiYrusNd6WOjjAN5pgVDBa+qaF1jQ3iErQnlleqhM9K7/A/qcKl1myMRz6CWm/PcQYtf/ozbvxp/ICScbuzEgabvh50sTeBTb8bUHnsE9+8Icq08Ugv/1YuLm2Ezgnjo9pH+Df/JG8XodgqG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJjgaQBj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJjgaQBj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786608646; x=1818144646;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2vW8nPjiF+fKmhpleG4r/1VZ5Ror7CluAB366amg3HI=;
  b=GJjgaQBjguHe0LTjyu76wMWupr6MCbRMzZZ+7k7D0Mitpy0xBFWGJjvp
   9pGZRi3oUGF9MG/k0zTFdK9cZyTQZdQ3OQWG+eRBOexJ0ll6sAu5j4i81
   VMwMR/rCNBWRwlZRjDH6sOoaoDJ6e2VE/lJK5ClxbW9SZ4vdG5k6YzvMg
   HLLHuzznDRNOIDNqKgIXO1WU1PvRRzYuplyMIx1Wl5bQkddNBUhfbdHVV
   HoMVctAgM0q+QiN3xGlYuow//ztfu+yb67qE5yI7lfBxTqM3IBEw1mkFH
   DIt0FBzRKt7/+lJ7qmZpbNm0Eu6Q4YMZ4+odO+Fr80vuwtqX9PIeArqMh
   Q==;
X-CSE-ConnectionGUID: iGQG3g5xT/OfgdX4u88m1w==
X-CSE-MsgGUID: B+LTsJxgSAS44cJ0W9QKag==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97524269"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="97524269"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:10:44 -0700
X-CSE-ConnectionGUID: 5a7DsNlZS/iliGzvmg7gbQ==
X-CSE-MsgGUID: MluFwrrzRKi96aEWKhcA9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="262559933"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:10:42 -0700
Message-ID: <e749e9bc-5bdf-4e43-87cf-32b0a58981ea@intel.com>
Date: Thu, 13 Aug 2026 16:10:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-3-xiaoyao.li@intel.com>
 <20260810113924.4ACBE1F000E9@smtp.kernel.org>
 <13ea6279-a342-493b-a0f8-15ac5b4c59ad@intel.com>
 <anplcWfYReCMeu1A@google.com>
 <07df932f-ca83-463d-b830-aa10a8fa11f2@intel.com>
 <an0N0vHwsYEqjpRe@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <an0N0vHwsYEqjpRe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/2026 8:20 AM, Sean Christopherson wrote:
> On Tue, Aug 11, 2026, Xiaoyao Li wrote:
>> On 8/11/2026 7:57 AM, Sean Christopherson wrote:
>>> On Mon, Aug 10, 2026, Xiaoyao Li wrote:
>>>> On 8/10/2026 7:39 PM, sashiko-bot@kernel.org wrote:
>>>>>> @@ -2147,7 +2156,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
>>>>>>     	struct vcpu_tdx *tdx = to_tdx(vcpu);
>>>>>>     	*reason = tdx->vt.exit_reason.full;
>>>>>> -	if (*reason != -1u) {
>>>>>> +	if (tdx->vt.exit_reason.basic != -1) {
>>>>> [Severity: Medium]
>>>>> Will this check always evaluate to true due to C integer promotion rules?
>>>>>
>>>>> The basic field in union vmx_exit_reason is a 16-bit unsigned bitfield. When
>>>>> comparing it to -1, the unsigned 16-bit value is promoted to a signed 32-bit
>>>>> integer. If the value was set to -1 (65535), the comparison evaluates as
>>>>> 65535 != -1, which is always true.
>>>>>
>>>>
>>>> Well, how about something below on top of this patch?
>>>
>>> No, we need to not rely on magic exit_reason.basic values.  Can't this be?
>>>
>>> 	if ((tdx->vp_enter_ret & TDX_SW_ERROR) != TDX_SW_ERROR) {
>>
>> I think the reason of checking if (*reason != -1u) in the original commit
>> 095b71a03f49 ("KVM: TDX: Add a place holder to handle TDX VM exit") was
>> that, -1u means there is no valid Exit Reason in the lower 32 bits in
>> vp_enter_ret.
>>
>> Change it to check TDX_SW_ERROR, doesn't look correct to me. Set the
>> EPT_MISCONFIG magic handling aside, TDX_SW_ERROR only means the SEAMCALL
>> instruction faults, e.g., hitting #UD, #GP, or VMFAILINVALID. Just a small
>> subset of the cases where there is no valid Exit Reason.
> 
> Surely we can enumerate those cases?  I.e. why can't that be something like:
> 
> 	if (tdx_is_exit_reason_valid(vcpu))
> 
> where tdx_is_exit_reason_valid() decodes vp_enter_ret.  Clobbering the entire
> exit reason and then _relying_ on that clobbered state is gross and brittle.

This a good suggestion. I implemented it as:

Author: Xiaoyao Li <xiaoyao.li@intel.com>
Date:   Thu Aug 13 09:42:15 2026 +0800

     KVM: TDX: Check if there is valid exit info based on vp_enter_ret

     Check if there is valid exit info based on vp_enter_ret instead of 
relying
     on the clobbered Exit Reason, in tdx_get_exit_info().

     Current KVM uses "Exit Reason is not equal to the synthesized invalid
     Exit Reason, -1u," as the condition to identify there is a real TD Exit
     and valid exit infos.  However, there is one issue with this approach:
     KVM updates the Exit Reason to the synthesized invalid Exit Reason for
     real EPT MISCONFIG as well.  This is a false positive that real EPT
     MISCONFIG has valid exit infos.

     Though the issue can be addressed by changing the handling for real EPT
     MISCONFIG to not update the Exit Reason to the synthesized one, relying
     on the clobbered Exit Reason itself is brittle.  Instead, check
     vp_enter_ret directly to identify if it is a valid Exit Reason.

     Fixes: da407fe45908 ("KVM: TDX: Handle EPT violation/misconfig exit")
     Cc: stable@vger.kernel.org
     Suggested-by: Sean Christopherson <seanjc@google.com>
     Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 7338ac0af693..f9036c0a8f9c 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -921,21 +921,27 @@ static __always_inline u32 
tdcall_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
         return EXIT_REASON_TDCALL;
  }

-static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
+static __always_inline bool tdx_is_exit_reason_valid(u64 vp_enter_ret)
  {
-       struct vcpu_tdx *tdx = to_tdx(vcpu);
-       u32 exit_reason;
-
-       switch (tdx->vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) {
+       switch (vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) {
         case TDX_SUCCESS:
         case TDX_NON_RECOVERABLE_VCPU:
         case TDX_NON_RECOVERABLE_TD:
         case TDX_NON_RECOVERABLE_TD_NON_ACCESSIBLE:
         case TDX_NON_RECOVERABLE_TD_WRONG_APIC_MODE:
-               break;
+               return true;
         default:
-               return -1u;
+               return false;
         }
+}
+
+static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
+{
+       struct vcpu_tdx *tdx = to_tdx(vcpu);
+       u32 exit_reason;
+
+       if (!tdx_is_exit_reason_valid(tdx->vp_enter_ret))
+               return -1u;

         exit_reason = tdx->vp_enter_ret;

@@ -2144,7 +2150,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 
*reason,
         struct vcpu_tdx *tdx = to_tdx(vcpu);

         *reason = tdx->vt.exit_reason.full;
-       if (*reason != -1u) {
+       if (tdx_is_exit_reason_valid(tdx->vp_enter_ret)) {
                 *info1 = vmx_get_exit_qual(vcpu);
                 *info2 = tdx->ext_exit_qualification;
                 *intr_info = vmx_get_intr_info(vcpu);
