Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1B405877
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500636; cv=none; b=qfOdVf0EQNnj9RXK9T3w5agXtoG9pQuMr61CnfRIhDVYObc8FrRj2mZeVlfI9c7h4GS406h/0TDS/fLwjLdB3jssVAyorffxPbbif9NUntBx1L9QMnyRMuuT1wXuE1IL4b7NXme1MHyGvEBb/6s3gYXWMi8f0Z7Qcwakm5R4Apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500636; c=relaxed/simple;
	bh=lvibewXknrwbofLgN64HOnOOXNNE/eLEoLegDWzMRzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNdbDjXFBfnuRPnovd8Tr7kN3U1EwA7wlrzjd6Rh9UZSrmtU22MsvCdR4bNdvvZuXf/hpSc5CnakOcLaPCPnENF11qmS/rREKdzh2W7fvyygGoKaOh07O9YYzpdQeCPwqg/zzzJEPBk5nkFPWxmtsPxJ90FUp0d12qc6fjmL0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JffFOzJQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JffFOzJQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783500634; x=1815036634;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lvibewXknrwbofLgN64HOnOOXNNE/eLEoLegDWzMRzQ=;
  b=JffFOzJQeJdF+yCj1sCB9lNfT0EMGXHYNd3kj6V8gnKMdk0q3znNNwDl
   DFIgnHW3QOB6GyyW5hVb9xwOdUzMlbyg4+UFhbqVcOX4Dnh/QHq+qRih+
   KVjL4KjcwDjRlPQ7EUgr7gS3hXOV9VLZuAlD+Lg9XWLmR8U6nGfaea/LS
   XiNmun0hNGzMMXL62Bsb3WgHAq4w5XsLY5bTyJq1hguqveW2ZM2A64JeP
   uogzu+2ZNdVhpgWDEzBIjO3FAX7IA3X+2xKqC2sMRicXWeNCDAWrQYZJc
   dzhIk7INChv/OfP7I11qmowCV/s8I1d/X5gb+URdHMj+4Sv7ZXaqH89NJ
   A==;
X-CSE-ConnectionGUID: afzQGqqYSdCSj2WMVYPz8g==
X-CSE-MsgGUID: Y31UuOnnQDiSuEles8PO5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94801873"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94801873"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 01:50:33 -0700
X-CSE-ConnectionGUID: pERsrTM7T1mEB1yHAx/0Lg==
X-CSE-MsgGUID: BJVNEQM+S+eY7ZmwnC3Jpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="292418821"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 01:50:32 -0700
Message-ID: <a018bb95-cda5-4431-9bed-e60223087d97@linux.intel.com>
Date: Wed, 8 Jul 2026 16:50:29 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD
 init
To: sashiko-reviews@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
References: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
 <20260708023531.825361F000E9@smtp.kernel.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260708023531.825361F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/8/2026 10:35 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Lock inversion and deadlock risk: `cpus_read_lock()` is acquired while holding `kvm->lock`, `vcpu->mutex`, and `kvm->slots_lock`, violating the KVM lock ordering hierarchy.
> --
> 
> --- Patch [1]: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD init ---
> commit 60173e3dd2d8767ff9b1708338f63d8f3d6d8481
> Author: Binbin Wu <binbin.wu@linux.intel.com>
> 
> KVM: x86: TDX: Use validated CPUID entry count for TD init
> 
> This commit ensures KVM_TDX_INIT_VM uses the validated CPUID entry count 
> when parsing CPUID data. This prevents issues if userspace modifies the 
> input count concurrently during setup.
> 
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index ffe9d0db58c59..b658b03e77508 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -2802,6 +2802,12 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>>  	if (IS_ERR(init_vm))
>>  		return PTR_ERR(init_vm);
>>  
>> +	/*
>> +	 * Use the validated entry count, as user_data->cpuid.nent may have
>> +	 * changed.
>> +	 */
>> +	init_vm->cpuid.nent = nr_user_entries;
>> +
>>  	if (memchr_inv(init_vm->reserved, 0, sizeof(init_vm->reserved))) {
>>  		ret = -EINVAL;
>>  		goto out;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the KVM_TDX_INIT_VM
> initialization path have a lock inversion?
> 
> Looking at the call chain triggered by the KVM_TDX_INIT_VM ioctl, 
> tdx_vm_ioctl() first acquires the inner KVM locks via 
> tdx_acquire_vm_state_locks():
> 
> arch/x86/kvm/vmx/tdx.c:tdx_vm_ioctl() {
>     ...
>     CLASS(tdx_vm_state_guard, guard)(kvm);
>     ...
>     r = tdx_td_init(kvm, &tdx_cmd);
>     ...
> }
> 
> The tdx_vm_state_guard acquires kvm->lock, all vcpu->mutex locks, and 
> kvm->slots_lock. 
> 
> Then tdx_td_init() continues and calls __tdx_td_init(), where 
> cpus_read_lock() is acquired directly:
> 
> arch/x86/kvm/vmx/tdx.c:__tdx_td_init() {
>     ...
>     cpus_read_lock();
>     ...
> }
> 
> Since KVM locking rules require cpus_read_lock() to be the outermost lock,
> does acquiring it while holding kvm->lock and the other inner locks create
> a deadlock risk against CPU hotplug or other paths that acquire these locks
> in the correct order?
> 

The virt/kvm/locking.rst doesn't explicitly say cpus_read_lock() needs to be the
outermost lock, but
documentation:        cpus_read_lock() is taken outside kvm_lock
                      kvm->lock is taken outside kvm->slots_lock
​set_nx_huge_pages():  takes kvm_lock outside of kvm->slots_lock

So it's transitive that cpus_read_lock() should be taken outside of
kvm->slots_lock while KVM_TDX_INIT_VM takes cpus_read_lock() inside
kvm->slots_lock.

So there could be a deadlock case:
tdx_td_init()               set_nx_huge_pages()        __kvmclock_cpufreq_notifier
  lock(&kvm->slots_lock)                             
                              lock(kvm_lock)
                                                         lock(cpu_hotplug_lock)
                              lock(&kvm->slots_lock)
                                                         lock(kvm_lock)
  lock(cpu_hotplug_lock)

There was a discussion that is related to this issue:
https://lore.kernel.org/kvm/20250124191109.205955-2-pbonzini@redhat.com/
It seems the discussion is still open?

Back to this issue, does it make sense to take cpus_read_lock() before 
kvm->lock during KVM_TDX_INIT_VM as following:

---
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b658b03e7750..90fe7beadc06 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -484,7 +484,7 @@ static void smp_func_do_phymem_cache_wb(void *unused)
 	TDX_BUG_ON(err, TDH_PHYMEM_CACHE_WB, NULL);
 }
 
-void tdx_mmu_release_hkid(struct kvm *kvm)
+static void __tdx_mmu_release_hkid(struct kvm *kvm)
 {
 	bool packages_allocated, targets_allocated;
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
@@ -494,12 +494,13 @@ void tdx_mmu_release_hkid(struct kvm *kvm)
 	int i;
 	u64 err;
 
+	lockdep_assert_cpus_held();
+
 	if (!is_hkid_assigned(kvm_tdx))
 		return;
 
 	packages_allocated = zalloc_cpumask_var(&packages, GFP_KERNEL);
 	targets_allocated = zalloc_cpumask_var(&targets, GFP_KERNEL);
-	cpus_read_lock();
 
 	kvm_for_each_vcpu(j, vcpu, kvm)
 		tdx_flush_vp_on_cpu(vcpu);
@@ -552,11 +553,16 @@ void tdx_mmu_release_hkid(struct kvm *kvm)
 
 out:
 	mutex_unlock(&tdx_lock);
-	cpus_read_unlock();
 	free_cpumask_var(targets);
 	free_cpumask_var(packages);
 }
 
+void tdx_mmu_release_hkid(struct kvm *kvm)
+{
+	guard(cpus_read_lock)();
+	__tdx_mmu_release_hkid(kvm);
+}
+
 static void tdx_reclaim_td_control_pages(struct kvm *kvm)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
@@ -2490,7 +2496,7 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 	if (!zalloc_cpumask_var(&packages, GFP_KERNEL))
 		goto free_tdcs;
 
-	cpus_read_lock();
+	lockdep_assert_cpus_held();
 
 	/*
 	 * Need at least one CPU of the package to be online in order to
@@ -2552,7 +2558,6 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 		if (ret)
 			break;
 	}
-	cpus_read_unlock();
 	free_cpumask_var(packages);
 	if (ret) {
 		i = 0;
@@ -2608,13 +2613,12 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 	if (!kvm_tdx->td.tdcs_pages)
 		kfree(tdcs_pages);
 
-	tdx_mmu_release_hkid(kvm);
+	__tdx_mmu_release_hkid(kvm);
 	tdx_reclaim_td_control_pages(kvm);
 
 	return ret;
 
 free_packages:
-	cpus_read_unlock();
 	free_cpumask_var(packages);
 
 free_tdcs:
@@ -2733,12 +2737,24 @@ static int tdx_read_cpuid(struct kvm_vcpu *vcpu, u32 leaf, u32 sub_leaf,
 	return -EIO;
 }
 
-typedef void *tdx_vm_state_guard_t;
+struct tdx_vm_state_guard {
+	struct kvm *kvm;
+	bool acquire_cpus_read_lock;
+};
 
-static tdx_vm_state_guard_t tdx_acquire_vm_state_locks(struct kvm *kvm)
+static struct tdx_vm_state_guard tdx_acquire_vm_state_locks(struct kvm *kvm,
+							    bool acquire_cpus_read_lock)
 {
+	struct tdx_vm_state_guard g = { .acquire_cpus_read_lock = acquire_cpus_read_lock };
 	int r;
 
+	/*
+	 * When needed, take cpu_hotplug_lock as the outermost lock, to avoid
+	 * lock inversion against the CPU hotplug path.
+	 */
+	if (acquire_cpus_read_lock)
+		cpus_read_lock();
+
 	mutex_lock(&kvm->lock);
 
 	if (kvm->created_vcpus != atomic_read(&kvm->online_vcpus)) {
@@ -2755,23 +2771,33 @@ static tdx_vm_state_guard_t tdx_acquire_vm_state_locks(struct kvm *kvm)
 	 * kvm->slots_lock!
 	 */
 	mutex_lock(&kvm->slots_lock);
-	return kvm;
+	g.kvm = kvm;
+	return g;
 
 out_err:
 	mutex_unlock(&kvm->lock);
-	return ERR_PTR(r);
+	if (acquire_cpus_read_lock)
+		cpus_read_unlock();
+	g.kvm = ERR_PTR(r);
+	return g;
 }
 
-static void tdx_release_vm_state_locks(struct kvm *kvm)
+static void tdx_release_vm_state_locks(struct tdx_vm_state_guard g)
 {
-	mutex_unlock(&kvm->slots_lock);
-	kvm_unlock_all_vcpus(kvm);
-	mutex_unlock(&kvm->lock);
+	if (IS_ERR(g.kvm))
+		return;
+
+	mutex_unlock(&g.kvm->slots_lock);
+	kvm_unlock_all_vcpus(g.kvm);
+	mutex_unlock(&g.kvm->lock);
+	if (g.acquire_cpus_read_lock)
+		cpus_read_unlock();
 }
 
-DEFINE_CLASS(tdx_vm_state_guard, tdx_vm_state_guard_t,
-	     if (!IS_ERR(_T)) tdx_release_vm_state_locks(_T),
-	     tdx_acquire_vm_state_locks(kvm), struct kvm *kvm);
+DEFINE_CLASS(tdx_vm_state_guard, struct tdx_vm_state_guard,
+	     tdx_release_vm_state_locks(_T),
+	     tdx_acquire_vm_state_locks(kvm, acquire_cpus_read_lock),
+	     struct kvm *kvm, bool acquire_cpus_read_lock);
 
 static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
 {
@@ -2933,9 +2959,13 @@ int tdx_vm_ioctl(struct kvm *kvm, void __user *argp)
 	if (tdx_cmd.id == KVM_TDX_CAPABILITIES)
 		return tdx_get_capabilities(&tdx_cmd);
 
-	CLASS(tdx_vm_state_guard, guard)(kvm);
-	if (IS_ERR(guard))
-		return PTR_ERR(guard);
+	/*
+	 * KVM_TDX_INIT_VM programs the per-package encryption keys, which must
+	 * be done under cpus_read_lock().
+	 */
+	CLASS(tdx_vm_state_guard, guard)(kvm, tdx_cmd.id == KVM_TDX_INIT_VM);
+	if (IS_ERR(guard.kvm))
+		return PTR_ERR(guard.kvm);
 
 	switch (tdx_cmd.id) {
 	case KVM_TDX_INIT_VM:
@@ -3307,9 +3337,9 @@ int tdx_vcpu_unlocked_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
 	if (r)
 		return r;
 
-	CLASS(tdx_vm_state_guard, guard)(kvm);
-	if (IS_ERR(guard))
-		return PTR_ERR(guard);
+	CLASS(tdx_vm_state_guard, guard)(kvm, false);
+	if (IS_ERR(guard.kvm))
+		return PTR_ERR(guard.kvm);
 
 	if (!is_hkid_assigned(kvm_tdx) || kvm_tdx->state == TD_STATE_RUNNABLE)
 		return -EINVAL;

