Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782441BF33
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783656115; cv=none; b=CJMN57xStvjt4v0VAEMK4jCeRvQqigY6dTXrY6lhem35GoDEkAFG9ZMcCrRZ/QhzgYvaYd26Ye7nBu3TG+Hkp0syn6eh2FNxaDiGs3+LDWsPdWRwQCf+Wo25CScl3sCr243HpG0iwB53EiQyfTpi+18lzUNwoy2ScoSPrDhTuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783656115; c=relaxed/simple;
	bh=3FOjQeNird3Eb90K2HWDR3t62AGWcBqsIx1NrLr5e1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jVWy9Q7hIZFzRm3cDjEOc55QQixOlP0Jj8npzZkQ6IY4IUwbKaDm+9bFXeL5vhVy5cIm8pEB/oaTkn/0eJQz0Ju4dKrvX+oQne/8tK5l8N/2qJIvNdtNPRjnXmlImODczLCRYIXc9AENyKqzZ3Qzx3EURAzRiPdB2zTmreDT/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKgcjQaS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKgcjQaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EA71F000E9;
	Fri, 10 Jul 2026 04:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783656114;
	bh=xQ2yGBzDMJ+NjoDvKIQ4gl96AIXZJpJC/Id67eNbuto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PKgcjQaSgPfyZRs6mDs+wJohwiyJUYsIfA65jzTGyV54KGgzG87JONzFJg+2tL+55
	 fSrzcUnGkI57A8fdQjCQ7UAm/uqSCtXxTTAW9DZ+La/OKWgqJ7jyqrVPYm0Beh3jT3
	 cpzY44lVmdKHzZaNZJPi274qQz4hPkdhAbcUrZTiD1U8V0mh9Vqa/KMWFivspuUKP2
	 3Alse28vgPLkFPx0JCNsKxTlSg/WS6VHupMZ4fKhnueeVO4YgPO1SyXKrD0oKkZqvh
	 zoDPaggLXYKRf/bOXLeVCYq8bPmyYl8ABHrsfU+BE2V9W5Okgis5iA4hJZIMhhAzc6
	 dIHLtsAe24uzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: TDX: Reject concurrent change to CPUID entry
 count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Wu" <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
References: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 04:01:53 +0000
Message-Id: <20260710040153.D8EA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Acquiring `cpus_read_lock()` while holding `kvm->lock` and `kvm->s=
lots_lock` violates the KVM lock ordering hierarchy and creates an AB-BA de=
adlock risk with CPU hotplug.
- [High] Failing to charge the `misc_cg` in `__tdx_td_init()` jumps to a cl=
eanup label that incorrectly uncharges and decrements a global counter.
- [High] Kernel heap buffer overflow when setting up TD params if the TDX m=
odule reports a large number of CPUID configurations.
--

--- Patch [1]: [PATCH v2] KVM: TDX: Reject concurrent change to CPUID entry=
 count ---
commit 43b81457d393443ba395e2515a2d545aac295cf0
Author: Binbin Wu <binbin.wu@linux.intel.com>

KVM: TDX: Reject concurrent change to CPUID entry count

Reject KVM_TDX_INIT_VM if userspace changes cpuid.nent between the
initial read and the subsequent copy of the initialization data.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 2d7a4d52ccfb4..c2349c54d45b5 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2738,7 +2738,11 @@ static int tdx_td_init(struct kvm *kvm, struct kvm=
_tdx_cmd *cmd)
>  		goto out;
>  	}
> =20
> -	if (init_vm->cpuid.padding) {
> +	/*
> +	 * Reject the request if userspace changes cpuid.nent between the
> +	 * initial read and the subsequent copy.
> +	 */
> +	if (init_vm->cpuid.padding || init_vm->cpuid.nent !=3D nr_user_entries)=
 {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}

[Severity: High]
This is a pre-existing issue, but I noticed a potential lock ordering probl=
em
in the initialization path called shortly after this check.

In __tdx_td_init(), the code acquires the cpu read lock:

arch/x86/kvm/vmx/tdx.c:__tdx_td_init() {
    ...
    cpus_read_lock();
    ...
}

However, tdx_td_init() is called while the vm state locks are already held
higher in the stack:

arch/x86/kvm/vmx/tdx.c:tdx_acquire_vm_state_locks() {
    ...
    mutex_lock(&kvm->lock);
    ...
}

Taking cpus_read_lock() while holding kvm->lock creates a deadlock risk
against other subsystems, like cpu hotplug, that hold cpu_hotplug_lock
via cpus_write_lock() and subsequently attempt to acquire kvm->lock.

Can this lead to a system-wide deadlock during cpu hotplug operations?

[Severity: High]
This is another pre-existing issue in the same __tdx_td_init() path.

If misc_cg_try_charge() fails, it jumps to the free_hkid label:

arch/x86/kvm/vmx/tdx.c:__tdx_td_init() {
    ...
    ret =3D misc_cg_try_charge(MISC_CG_RES_TDX, kvm_tdx->misc_cg, 1);
    if (ret)
        goto free_hkid;
    ...
}

The free_hkid cleanup path executes tdx_hkid_free(), which unconditionally
decrements the configured hkid counter and uncharges the cgroup:

arch/x86/kvm/vmx/tdx.c:tdx_hkid_free() {
    ...
    atomic_dec(&nr_configured_hkid);
    misc_cg_uncharge(MISC_CG_RES_TDX, kvm_tdx->misc_cg, 1);
    ...
}

Since the initial charge failed and the code jumped past the atomic_inc()
for nr_configured_hkid, does this error path underflow the global atomic
counter and corrupt the cgroup accounting?

[Severity: High]
This isn't a bug introduced by this patch, but there is a potential out of
bounds write later in this function when setting up the td params.

In setup_tdparams_cpuids(), the loop is bounded by num_cpuid_config:

arch/x86/kvm/vmx/tdx.c:setup_tdparams_cpuids() {
    ...
    for (i =3D 0; i < td_conf->num_cpuid_config; i++) {
        ...
        value =3D &td_params->cpuid_values[i];
        value->eax =3D entry->eax;
        ...
    }
}

The td_params structure is strictly sized to 1024 bytes, which only leaves
room for 48 elements in the cpuid_values array.

Since tdx_global_metadata.c permits td_conf->num_cpuid_config to be up to 1=
28,
will this loop write past the end of the td_params kernel heap allocation i=
f=20
the module reports a large number of cpuid configurations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710035324.3170=
534-1-binbin.wu@linux.intel.com?part=3D1
