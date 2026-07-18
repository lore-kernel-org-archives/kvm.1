Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8867A1B86C7
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784355052; cv=none; b=iv4ieJUazGB6j/KO6rLhWBuW2FLya24Z+GZ33t5dB6oge4JJeTsaMcJYcOdFlr5+x0tTVKj9aKjVrFrhXvRQXg4orXfwtHxcJFGbSSn3gHi06RicUDHiCtl/W+5ff7i55HrXF56b2dG4Fm8JZFldXCOInjKPgEWMa2gjXC4uASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784355052; c=relaxed/simple;
	bh=6Tp/rkrFRRREFMszZsq00R83mbtIGwGyOPth3d56PUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HiMBtViNKhqYo4+OkGlg0c5x5fMLkNAqAQAgz+615ajtdOULkbCtrq85dIOAgH1/7HafwxqvZqUN5dVwYEPbRUZKABRYwheAudCj/S38shRFSYikvFCtqWxRj+V9eAMAfCLvM5j2z3WXcZgy4qr2xC1aSADsGeVcOakBJeZHWRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej7bfyQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej7bfyQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17B01F000E9;
	Sat, 18 Jul 2026 06:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784355051;
	bh=oaLugtF12mxw8+D45f0hX+P5OhKvHuoYQAexLUIHg10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ej7bfyQTUK+de5EgZ1REE34L8gDiYgqssJqEB+tiEB0OqcafCra1d+VBrZm+IaHzq
	 dnTxNu5L08zK8nt2zNSB2ZG/fMh/fj/HuFnLgIpN1tPUWnoB8lnwZH//NcssDW0S4+
	 4Fj0UpHWMpVfvU9qWO5yT77bw4WteS1cY4tDItOgCvrkNsg4C/o5xMIKjbs5IP/vZT
	 Rjfag2ayBT8OuIuRXu/VvgDk8DK4q3gp7TASuFASBZCG2J6oAFHOORTfyND4uXS+3x
	 hZDboIpTtwVIXqdJ14KdR7gJyS06ECm/mNHQ3UYbJDe1+QSvGKUOUlE2c5Z96EkPwk
	 gxNozjEKzB6/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 06:10:50 +0000
Message-Id: <20260718061050.E17B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Infinite kernel loop in `kvm_tdp_mmu_map_private_pfn` due to perma=
nent PAMT cache depletion on transient TDX module contention.
--

--- Patch [8]: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mappi=
ng private memory ---
commit 3474807f1c1bc4dedc75e2a756b65254c986a41d
Author: Kiryl Shutsemau <kas@kernel.org>

KVM: TDX: Get/put PAMT pages when (un)mapping private memory
   =20
Add Dynamic PAMT support to KVM's S-EPT MMU by "getting" a PAMT page when
adding guest memory (PAGE.ADD or PAGE.AUG), and "putting" the page when
removing guest memory (PAGE.REMOVE).

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 528ebb3cb0389..049da8559882b 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1679,16 +1693,28 @@ static struct page *tdx_spte_to_sept_pt(struct kv=
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
> +	if (ret)
> +		return ret;
> +
>  	err =3D tdh_mem_sept_add(&to_kvm_tdx(kvm)->td, gpa, level, sept_pt,
>  			       &entry, &level_state);
> +	if (err)
> +		tdx_pamt_put(page_to_pfn(sept_pt));
> +
>  	if (unlikely(tdx_operand_busy(err)))
>  		return -EBUSY;

[Severity: High]
Does this error path risk causing an infinite loop if the TDX module
contention leads to TDX_OPERAND_BUSY?

When tdh_mem_sept_add() returns TDX_OPERAND_BUSY, tdx_pamt_put() frees the
PAMT pages directly back to the buddy allocator, not back into the vCPU's
PAMT cache.

If this happens during VM initialization in a retry loop like
kvm_tdp_mmu_map_private_pfn(), the vCPU memory caches are topped up outside
of the loop:

    r =3D mmu_topup_memory_caches(vcpu, false);
    if (r)
        return r;

    do {
        ...
        r =3D kvm_tdp_mmu_map(vcpu, &fault);
    } while (r =3D=3D RET_PF_RETRY);

Since the PAMT pages are discarded rather than returned to the cache, a few
busy retries will completely empty the vCPU's PAMT cache.

On the next retry, tdx_pamt_get() will return -ENOMEM because the cache is
empty and it does not fall back to alloc_page() when a cache is provided.

The TDP MMU handles -ENOMEM by returning RET_PF_RETRY, but because the cache
is never replenished inside the loop, the loop will infinitely fail and ret=
ry.

Could the PAMT pages be returned to the vCPU cache instead of the buddy
allocator during transient failures, or should the cache top-up be moved
inside the retry loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718014500.2231=
262-1-rick.p.edgecombe@intel.com?part=3D8
