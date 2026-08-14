Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552D61D514E;
	Fri, 14 Aug 2026 00:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786668564; cv=none; b=jDNmxMfUG2Zhy/lDLN7cY7kGrfVp5aGJWQHvvqZYg6Tc05q13r7RNMjLCvk7at2fQsfj/h9JWskceFrJ0PwqnS1EDoALbG1a5Ubu2H3BQGX75SLQ272EiB2vkKTuJzqaO1T42Ys/fJaKE+fkd6SQNuT2iKQRODus7ykpQpWYqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786668564; c=relaxed/simple;
	bh=iU7B1C0qhT0pl84AXU9ksMyZOJS7RR592NJKp28t61Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhnsnMAfLouHqWCyFNBMewDiJGlGcIkZ4F7I5dWGeUmLj2cziJeeW5BMQgPkrIPfyztbi1r+kXMY8Pj6BSw0oi9DHLhKp8YwYsIzw4uWAFkl21/l+vIN0cLCj5cDtsEUCqf5TowgaFa4mBVVofBQKei6Q5zACQ6z8YXZrcg8p/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WINjfgVl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WINjfgVl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786668563; x=1818204563;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iU7B1C0qhT0pl84AXU9ksMyZOJS7RR592NJKp28t61Q=;
  b=WINjfgVlA/vWbP6GbLalK7Cra8JXs0l28UsHHMQgLFWLGk2PLbFjDepc
   OK0UbM+I9ROjjxorvURFGXKHJKyLveKDpXu+unGCBR2eFCCFVWu09gEil
   PtymLULS8iaamUBiPpTJ4Pldsgi0d3tR6BCMHaqNufdrE3vHqb5D538XK
   LgDN0XB/yDZL8c0t2iDGSfZU9Mgefs9M/eDyo+fupUu+6B4AoSYV8mxrN
   2Jz1o6+frVjYBEZmzDu178qNAc6m5/4wSYtt2XG8SBYdTmIJopo+1NGTn
   q4XplcagLggn4fdbbqZuPNAJ2NZkLBL1rh5TZuw2xpwF6+OoNERLtKfdO
   A==;
X-CSE-ConnectionGUID: 3xURMBtTSdKHI68e1+D8Sw==
X-CSE-MsgGUID: +vNtC0jlTx2NSlSKPCQO8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="98406736"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="98406736"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 17:49:22 -0700
X-CSE-ConnectionGUID: 2uGPsbFfSKWHhCJ1jC95Zw==
X-CSE-MsgGUID: 0mtixsmvQUOmNNAZeE7DeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="267949116"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 17:49:20 -0700
Message-ID: <77567574-d26c-4d2c-b5ce-5da28a7178d6@intel.com>
Date: Fri, 14 Aug 2026 08:49:17 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kas@kernel.org" <kas@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-5-xiaoyao.li@intel.com>
 <868c0d3c792d789347c767031612977c31cc227f.camel@intel.com>
 <1cf47118-2a19-44d5-ab74-b4c7ffa8890c@intel.com>
 <an3YFiDbjRs3PUwn@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <an3YFiDbjRs3PUwn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/2026 10:43 PM, Sean Christopherson wrote:
> On Thu, Aug 13, 2026, Xiaoyao Li wrote:
>> On 8/13/2026 6:58 AM, Edgecombe, Rick P wrote:
>>> On Wed, 2026-08-12 at 16:02 +0800, Xiaoyao Li wrote:
>>>> -	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap)))
>>>> +	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap))) {
>>>> +		vt->exit_reason.bus_lock_detected = 0;
>>>>    		return EXIT_FASTPATH_EXIT_HANDLED;
>>>> +	}
>>>
>>> This still feels hacky to me. It at least deserves a comment I think. If you
>>> spin another version.
>>
>> I spent more time on this today and I find there is an existing issue. When
>> the previous Exit Reason is EXIT_REASON_EXTERNAL_INTERRUPT, the early return
>> here can go to the path due to the stale exit_reason.
>>
>> kvm_x86_call(handle_exit_irqoff)(vcpu)
>>    vmx_handle_exit_irqoff()
>>      handle_external_interrupt_irqoff()
>>
>> This makes the host process the external interrupt twice, and maybe more
>> times if the wait_for_sept_zap remains longer.
>>
>> I think we need an separate fix to set
>>
>> 	vt->exit_reasons.full = TDX_INVALID_EXIT_REASON;
>>
>> so that if some patch is going to consume the stale Exit Reason, it can be
>> caught by TDX_INVALID_EXIT_REASON.
> 
> The more I look at this, the more I'm against shoving garbage into vt->exit_reasons.
> With tdx_is_exit_reason_valid(), this is trivially easy to handle, *and* explicitly
> captures the logic instead of subtly rerouting KVM away from meaningful handling.

tdx_is_exit_reason_valid() doesn't work unless we update the 
vp_enter_ret to one that isn't one of the status code with valid Exit 
Reason. See below.

About the idea, isn't the purpose of setting the Exit Reason to a 
synthesized one is to avoid the undefined Exit Reason causing 
false-positives when it happens to match one of the existing ones? If we 
are going to use tdx_is_exit_reason_valid(), does it mean we can drop 
the synthesized Exit Reason entirely and check 
tdx_is_exit_reason_valid() everywhere when KVM is going to consume Exit 
Reason?  e.g., for this initial bus_lock_detected bit handling here. we 
can avoid it by below. (Which makes it different for VMX, and somehow 
prevents consolidating the code between VMX and TDX around the exit 
handlers that we plan to do after series)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b6c30c4c6b84..52360313dd82 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2169,7 +2169,8 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, 
fastpath_t fastpath)
         int ret = __tdx_handle_exit(vcpu, fastpath);

         /* Exit to user space when bus lock was detected */
-       if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
+       if (tdx_is_exit_reason_valid(vcpu) &&
+           vmx_get_exit_reason(vcpu).bus_lock_detected) {
                 if (ret > 0) {
                         vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
                         ret = 0;

> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index 95d89d809c19..a1f5b5dc1fa3 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -157,6 +157,14 @@ static fastpath_t vt_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
>          return vmx_vcpu_run(vcpu, run_flags);
>   }
>   
> +static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
> +{
> +       if (is_td_vcpu(vcpu) && !tdx_is_exit_reason_valid(vcpu))

No, this doesn't work.

The previous vp_enter_ret was TDX_SUCCESS with 
EXIT_REASON_EXTERNAL_INTERRUPT. KVM handled it and is going to re-enter 
the TD. But wait_for_sept_zap is set by other vCPU thread, KVM decides 
to return directly but the vp_entere_ret isn't updated.

> +               return;
> +
> +       vmx_handle_exit_irqoff();
> +}
> +
>   static int vt_handle_exit(struct kvm_vcpu *vcpu,
>                            enum exit_fastpath_completion fastpath)
>   {
> @@ -1071,7 +1079,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
>          .load_mmu_pgd = vt_op(load_mmu_pgd),
>   
>          .check_intercept = vmx_check_intercept,
> -       .handle_exit_irqoff = vmx_handle_exit_irqoff,
> +       .handle_exit_irqoff = vt_op(handle_exit_irqoff),
>   
>          .update_cpu_dirty_logging = vt_op(update_cpu_dirty_logging),

