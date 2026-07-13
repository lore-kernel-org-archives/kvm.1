Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D422621FF2A
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783908971; cv=none; b=e/O8u7HbAURKkJQk07aXNqq2AfvkcjsEyQltdSvSrP6m5AkMcpVKtSIO98CqYEy8qb3Mik/X5dZorBJGwnZPw7nnricLyemlIre+M0DMDTpuJSh8yj0QLDjYSIRFktu2NNV2U9QOv9XMDRNtjjGfN+F3ClYeFeIzg4soHU01JNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783908971; c=relaxed/simple;
	bh=MP2DwSscQNp+EjMOUBeD++W0kL9VU2yb8oot+GZQwCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pz53yaFnkRV18DeiZKh3R7B8bEL3ugV5lardhGUxeWO75zoKXAPl6PQP3qeXPwoMfJOLRmje1SB2QUO4BcXx6lDb4WRETIrvd4e8v4mZ7q/UtNPlewvMme2qHiU82U3hpPrPuIK3LUWdEUg1mqSnL78LgnI8zf2P7DPX/caqr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kkyn0j2S; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kkyn0j2S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783908969; x=1815444969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MP2DwSscQNp+EjMOUBeD++W0kL9VU2yb8oot+GZQwCU=;
  b=Kkyn0j2S7usp9te1TfuXAgEvhmEx1y+8NYCh1A/EZMu5wYt1qosv7/fm
   JmjhvKsMbRsF2PCG91gGGZMjwMNcPYUMNpQZFFtydNypNXFYWvqoCTG1q
   uMWUAQ8uDS+GnG22pUac/DR54W91qmz640ZD4EaJjIFGomoJkkDvqiv2n
   2EuKsqcsP7EWmNqVEF8rW2Rs5cRaJ5p1F9a+94JN5wiaLAUkwUmC/JBI4
   vcwRWdvJq4eEw3vmUDP/3eHwMm81E/AWGqhro0QlphS1zTjZLcnJRgQKf
   YQTpc/JLJRFEGfmJtaIjLIaYMN5HDLzNSsaMakwzIA549L+Y2VehOX/5u
   Q==;
X-CSE-ConnectionGUID: Vo8133sLQdeGvAcxMTqt/Q==
X-CSE-MsgGUID: PaoLYrnkQ0uBkDZS2cUmYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84707702"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84707702"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 19:16:09 -0700
X-CSE-ConnectionGUID: 4lmS4Xl8ToqhCf/9OIf+Vw==
X-CSE-MsgGUID: LPY0J7d4S+W+ivZMm8/8sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="279831043"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 19:16:08 -0700
Message-ID: <12c6add9-14c4-4fad-a6b7-7ef91730cb36@linux.intel.com>
Date: Mon, 13 Jul 2026 10:16:06 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: TDX: Reject concurrent change to CPUID entry
 count
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
References: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
 <20260710040153.D8EA71F000E9@smtp.kernel.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260710040153.D8EA71F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/2026 12:01 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Acquiring `cpus_read_lock()` while holding `kvm->lock` and `kvm->slots_lock` violates the KVM lock ordering hierarchy and creates an AB-BA deadlock risk with CPU hotplug.
> - [High] Failing to charge the `misc_cg` in `__tdx_td_init()` jumps to a cleanup label that incorrectly uncharges and decrements a global counter.
> - [High] Kernel heap buffer overflow when setting up TD params if the TDX module reports a large number of CPUID configurations.
> --
> 
> --- Patch [1]: [PATCH v2] KVM: TDX: Reject concurrent change to CPUID entry count ---
> commit 43b81457d393443ba395e2515a2d545aac295cf0
> Author: Binbin Wu <binbin.wu@linux.intel.com>
> 
> KVM: TDX: Reject concurrent change to CPUID entry count
> 
> Reject KVM_TDX_INIT_VM if userspace changes cpuid.nent between the
> initial read and the subsequent copy of the initialization data.
> 
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index 2d7a4d52ccfb4..c2349c54d45b5 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -2738,7 +2738,11 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>>  		goto out;
>>  	}
>>  
>> -	if (init_vm->cpuid.padding) {
>> +	/*
>> +	 * Reject the request if userspace changes cpuid.nent between the
>> +	 * initial read and the subsequent copy.
>> +	 */
>> +	if (init_vm->cpuid.padding || init_vm->cpuid.nent != nr_user_entries) {
>>  		ret = -EINVAL;
>>  		goto out;
>>  	}
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential lock ordering problem
> in the initialization path called shortly after this check.
> 
> In __tdx_td_init(), the code acquires the cpu read lock:
> 
> arch/x86/kvm/vmx/tdx.c:__tdx_td_init() {
>     ...
>     cpus_read_lock();
>     ...
> }
> 
> However, tdx_td_init() is called while the vm state locks are already held
> higher in the stack:
> 
> arch/x86/kvm/vmx/tdx.c:tdx_acquire_vm_state_locks() {
>     ...
>     mutex_lock(&kvm->lock);
>     ...
> }
> 
> Taking cpus_read_lock() while holding kvm->lock creates a deadlock risk
> against other subsystems, like cpu hotplug, that hold cpu_hotplug_lock
> via cpus_write_lock() and subsequently attempt to acquire kvm->lock.
> 
> Can this lead to a system-wide deadlock during cpu hotplug operations?

This is considered as a set_nx_huge_pages() problem, not a TDX
problem per the discussion.
https://lore.kernel.org/kvm/ak5L2csITyi1tGp0@google.com/

> 
> [Severity: High]
> This is another pre-existing issue in the same __tdx_td_init() path.
> 
> If misc_cg_try_charge() fails, it jumps to the free_hkid label:
> 
> arch/x86/kvm/vmx/tdx.c:__tdx_td_init() {
>     ...
>     ret = misc_cg_try_charge(MISC_CG_RES_TDX, kvm_tdx->misc_cg, 1);
>     if (ret)
>         goto free_hkid;
>     ...
> }
> 
> The free_hkid cleanup path executes tdx_hkid_free(), which unconditionally
> decrements the configured hkid counter and uncharges the cgroup:
> 
> arch/x86/kvm/vmx/tdx.c:tdx_hkid_free() {
>     ...
>     atomic_dec(&nr_configured_hkid);
>     misc_cg_uncharge(MISC_CG_RES_TDX, kvm_tdx->misc_cg, 1);
>     ...
> }
> 
> Since the initial charge failed and the code jumped past the atomic_inc()
> for nr_configured_hkid, does this error path underflow the global atomic
> counter and corrupt the cgroup accounting?

nr_configured_hkid has been removed on kvm-x86's next branch by Sean's patches
https://lore.kernel.org/all/20260214012702.2368778-14-seanjc@google.com/
https://lore.kernel.org/all/20260214012702.2368778-15-seanjc@google.com/

But the issue raised for cgroup accounting is valid.
Will cook a patch to fix it.

> 
> [Severity: High]
> This isn't a bug introduced by this patch, but there is a potential out of
> bounds write later in this function when setting up the td params.
> 
> In setup_tdparams_cpuids(), the loop is bounded by num_cpuid_config:
> 
> arch/x86/kvm/vmx/tdx.c:setup_tdparams_cpuids() {
>     ...
>     for (i = 0; i < td_conf->num_cpuid_config; i++) {
>         ...
>         value = &td_params->cpuid_values[i];
>         value->eax = entry->eax;
>         ...
>     }
> }
> 
> The td_params structure is strictly sized to 1024 bytes, which only leaves
> room for 48 elements in the cpuid_values array.
> 
> Since tdx_global_metadata.c permits td_conf->num_cpuid_config to be up to 128,
> will this loop write past the end of the td_params kernel heap allocation if 
> the module reports a large number of cpuid configurations?
> 
The td_params structure is fixed to 1024byte, which is defined by the TDX spec
and the value of  td_conf->num_cpuid_config is read from the TDX module.

So, this should not happen unless there is a bug in the TDX module.
Not sure if KVM should do a preventive check.

