Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AB3E47B
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181490; cv=none; b=Kytw/G1D00yjaNOpYQxflU7z3WkG8Mlk3UpaQguisMZFtt4G4/N3QsCQnFTMuIOOKLmuHNKRatX7yYrjZ8r5NaDVhEe0klNsjZnvN7+6BvBqhpYxBKZxAf1jYBYsUssCG69Zpy+P6YKxJGnlDVeRvS6lBuTUd2r+dCw2zR+Ei6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181490; c=relaxed/simple;
	bh=8tuWdlgD9JBnZbZSvj6smXZJcnlcT/0EpO0rcEFWtuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A469VcnmGVquuBF0IupHicjXDkO8dMhBCLKfsFnxgW3zcO7BXhdVCjBgIS2yuaSmVztOUaqJsN9qt1nNIaHqlotNgz2FYRRfDg0SnYKglOp0hBD6HDAw87J5AtOLMNK7t2fOTFKKa/XqHAS1x+rADPs403X7/UmVQpfQjrxQqMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBADRJS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBADRJS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD47F1F000E9;
	Mon, 27 Jul 2026 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181489;
	bh=rcYZ00p05TfB+TkU7sS5Ey6xKJiNffxMrSR8Q7YwcKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IBADRJS5UdcCfvSMC3h/RJo8hUF+KJ0HmbgZEFGnoIUSz11jWY8T1VW+3mHw71fv2
	 HesQNAO1wN5yVrqw9y/5RnkEXF56Mdt+Jt9Jj46NG78BtjWMT0luHYR2dzgXkH4b7h
	 /YUTKqQxw3oDgjGqMfXRhpf7qx9ZM77pSDu1ln2hVZs/Er+x+ugxLbQpUk0zyEx1ZM
	 ZcqELKRwhCa8Yee8UmKutDrRaHTD5sa4fVrUy+4XTfQXe3garwcbOkyw/MjxqgAAtd
	 yyCpXIWVnyMytwESt/s0Hvwpo6Dq3vTgtrp0AIaU/ycJE5OBWTomDBzOcTbzkODHk3
	 TNNL3bA/K4Luw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/9] KVM: x86/pmu: Snapshot host
 IA32_PERF_CAPABILITIES in kvm_host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727192131.582105-5-zide.chen@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-5-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:44:48 +0000
Message-Id: <20260727194448.CD47F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete replacement of raw MSR_IA32_PERF_CAPABILITIES read leav=
es KVM vulnerable to kernel panics during module initialization.
--

--- Patch [4]: [PATCH v7 4/9] KVM: x86/pmu: Snapshot host IA32_PERF_CAPABIL=
ITIES in kvm_host ---
commit 6a6d946c1225761f83ef8a8498aa4ccab5425b72
Author: Mingwei Zhang <mizhang@google.com>

KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES in kvm_host
   =20
Cache the unadulterated snapshot of perf_capabilities so that KVM can
compare guest vPMU capabilities against raw hardware capabilities.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0626e835e9eb7..e0114f248a9ef 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -7033,6 +7033,10 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *o=
ps)
>  	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
>  		rdmsrq(MSR_IA32_ARCH_CAPABILITIES, kvm_host.arch_capabilities);
> =20
> +	if (boot_cpu_has(X86_FEATURE_PDCM))
> +		rdmsrq_safe(MSR_IA32_PERF_CAPABILITIES,
> +			    &kvm_host.perf_capabilities);
> +

[Severity: High]
This isn't a bug introduced by this patch, but there is an incomplete
replacement of a raw MSR_IA32_PERF_CAPABILITIES read elsewhere that leaves
KVM vulnerable to kernel panics during module initialization.

If a nested hypervisor exposes CPUID.PDCM but faults on the MSR access, the
raw rdmsrq() in intel_pmu_is_mediated_pmu_supported() can trigger a #GP and
panic the kernel:

arch/x86/kvm/vmx/pmu_intel.c:intel_pmu_is_mediated_pmu_supported() {
    ...
    rdmsrq(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
    ...
}

While this patch safely caches the MSR using rdmsrq_safe() here in
kvm_x86_vendor_init(), this snapshot is populated after
kvm_init_pmu_capability() has already run.

Because of this ordering, intel_pmu_is_mediated_pmu_supported() cannot
currently use this safely cached value, as it would incorrectly read 0.

Would it make sense to reorder the initialization so the snapshot is
populated before kvm_init_pmu_capability() runs, and then update
intel_pmu_is_mediated_pmu_supported() to use kvm_host.perf_capabilities
to avoid the #GP risk?

>  	WARN_ON_ONCE(kvm_nr_uret_msrs);
> =20
>  	r =3D ops->hardware_setup();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192131.5821=
05-1-zide.chen@intel.com?part=3D4
