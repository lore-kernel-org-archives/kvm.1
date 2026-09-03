Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BF332E121
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401647; cv=none; b=BABUy4J3ZaZi5Z0g1iBOUj2LNjpZC3gwsUPAUUaqbbUmLwEijnhSvZ4Lrp+2CsQflwtEXt5gwh7iySk04LhNvm/ttvBy0yIxZulkts1wsU+W+jeoaWNCA0FtLhKAb8AaHFwZHxHGWXNc6hkxTKceKCnVrrhUgFnygzYShpPblVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401647; c=relaxed/simple;
	bh=GMLWIZkvKnQ1G1pOW9zgJrxmc3MBmfj2ahvb88DEHVo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t81d9pWlOgrSdVYW9KXDfSBq7uWD9Cs1SDHr/qczwKUAof1WCFcJj1Kzq48KRORwgsCNtDUSqaTOUcvv6rSlzBkKdDfeG9RPtuKqRdycCm3wF2jtTiC1qufCULxy2zuN98FgkEyEaIg6QsLfiA1/uRMeEjCV4hqjRxUTwnQ0QSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhzjCt//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhzjCt//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA101F000E9;
	Thu,  3 Sep 2026 02:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788401645;
	bh=1bLTHgFTpdnphPhOp7+SmuPQfVBszSk0YtQIlKXJzYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LhzjCt//NtG+KCZE6764/7Kt1S0SMZVc/ZGjkYKyJkjx9wFmRNN6ji59NQbqlSOnK
	 TJ8B42hpqwAtQ3EGPsE4Q2E+Ld3VIaca2imECcKgs1v6ILl+I2+v9AI2IcA7v0+Gc3
	 iu5ODyZCzArGi0GCTrAAXUInKlAGwAkFyvbeTXMkR/35hXshzXFIGAgjse7vbDG19M
	 IlYAsG1PpuQE3mJTMusVzOabTGv7gvKTvqUwTNABs/BdPm5KzD8lawht9tsyvZv/Ms
	 qGZiRaQEWNhJOKAb2S7C1ho3Us1YlA6WOR04/gRs8FGfvb0bNltYqQgUC3urxZEH6U
	 lpuMQIOmSVmiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260903015113.93343-9-rick.p.edgecombe@intel.com>
References: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
 <20260903015113.93343-9-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 02:14:04 +0000
Message-Id: <20260903021405.0DA101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The retry loop in kvm_tdp_mmu_map_private_pfn() fails to top up me=
mory caches, causing PAMT cache exhaustion and a fatal KVM_BUG_ON when S-EP=
T mapping encounters contention.

Pre-existing issues:
- [High] cpus_read_lock() is acquired while kvm->lock is already held durin=
g KVM_TDX_INIT_VM initialization and teardown, violating lock hierarchy.
--

commit bab02cc7c6ddf1559b28e6bffce54a70e3531bc9
Author: Kiryl Shutsemau <kas@kernel.org>

KVM: TDX: Get/put PAMT pages when (un)mapping private memory
   =20
This patch adds Dynamic PAMT support to KVM's S-EPT MMU by allocating PAMT
pages on demand when adding guest memory and balancing releases via
tdx_pamt_put() when removing it or on error paths.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 957078e8656ef..09573112540e9 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> @@ -1679,16 +1694,28 @@ static struct page *tdx_spte_to_sept_pt(struct kv=
m *kvm, gfn_t gfn,
>  static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gfn,
>  				     enum pg_level level, u64 new_spte)
>  {
> +	struct kvm_vcpu *vcpu =3D kvm_get_running_vcpu();
>  	gpa_t gpa =3D gfn_to_gpa(gfn);
>  	u64 err, entry, level_state;
>  	struct page *sept_pt;
> +	int ret;
> +
> +	if (KVM_BUG_ON(!vcpu, kvm))
> +		return -EIO;
> =20
>  	sept_pt =3D tdx_spte_to_sept_pt(kvm, gfn, new_spte, level);
>  	if (!sept_pt)
>  		return -EIO;
> =20
> +	ret =3D tdx_pamt_get(page_to_pfn(sept_pt), &to_tdx(vcpu)->pamt_cache);
> +	if (KVM_BUG_ON(ret, kvm))
> +		return ret;

[Severity: High]
Does this error path lead to PAMT cache exhaustion and a fatal VM BUG if
mapping encounters contention?

When tdh_mem_sept_add() below encounters lock contention, which can occur
during parallel setups, it returns TDX_OPERAND_BUSY (-EBUSY/RET_PF_RETRY).

The error path calls tdx_pamt_put(), which drops the refcount and calls
free_pamt_array(). Crucially, free_pamt_array() returns the memory to the
kernel buddy allocator instead of returning it to the vCPU cache:

arch/x86/virt/vmx/tdx/tdx.c:tdx_pamt_put() {
	...
	atomic_set(dpamt_refcount, 0);
	spin_unlock(&dpamt_lock);
	free_pamt_array(pamt_pages);
}

The failure propagates as RET_PF_RETRY, and the page fault loop in
kvm_tdp_mmu_map_private_pfn() retries without calling
mmu_topup_memory_caches():

arch/x86/kvm/mmu/mmu.c:kvm_tdp_mmu_map_private_pfn() {
	...
		r =3D kvm_tdp_mmu_map(vcpu, &fault);
	} while (r =3D=3D RET_PF_RETRY);
}

This causes a net loss of cache entries. When the unreplenished cache runs
out of memory, tdx_pamt_get() returns -ENOMEM, causing KVM to BUG the VM
here. Could tdx_pamt_put() restore pages to the cache, or could the
retry loop be updated to replenish caches?

> +
>  	err =3D tdh_mem_sept_add(&to_kvm_tdx(kvm)->td, gpa, level, sept_pt,
>  			       &entry, &level_state);
> +	if (err)
> +		tdx_pamt_put(page_to_pfn(sept_pt));
> +
>  	if (unlikely(tdx_operand_busy(err)))
>  		return -EBUSY;
[ ... ]

[Severity: High]
This is a pre-existing issue, but does acquiring cpus_read_lock() while
kvm->lock is already held violate the KVM lock hierarchy?

During KVM_TDX_INIT_VM initialization, kvm->lock is acquired via the state
guard before handling the init ioctl:

arch/x86/kvm/vmx/tdx.c:tdx_vm_ioctl() {
	CLASS(tdx_vm_state_guard, guard)(kvm);
	if (IS_ERR(guard))
		return PTR_ERR(guard);

	switch (tdx_cmd.id) {
	case KVM_TDX_INIT_VM:
		r =3D tdx_td_init(kvm, &tdx_cmd);
	...
}

Then cpus_read_lock() is acquired inside __tdx_td_init() while kvm->lock
is held:

arch/x86/kvm/vmx/tdx.c:__tdx_td_init() {
	...
	if (!zalloc_cpumask_var(&packages, GFP_KERNEL))
		goto free_tdcs;

	cpus_read_lock();
	...
}

Similarly, it is acquired on the teardown path in tdx_mmu_release_hkid()
while kvm->lock is held:

arch/x86/kvm/vmx/tdx.c:tdx_mmu_release_hkid() {
	packages_allocated =3D zalloc_cpumask_var(&packages, GFP_KERNEL);
	targets_allocated =3D zalloc_cpumask_var(&targets, GFP_KERNEL);
	cpus_read_lock();
	...
}

The KVM guidelines explicitly state that cpus_read_lock() must be the
outermost lock. Could this cause an ABBA deadlock against other paths that
acquire cpus_read_lock() before taking kvm->lock, resulting in system hangs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903015113.9334=
3-1-rick.p.edgecombe@intel.com?part=3D8
