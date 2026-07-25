Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D7C4908D7
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784940419; cv=none; b=LfbByfAbLjQ/LkHvLid6FEtdK0qeuNIVFvgdo8fjsIuHjL5dcK+wnUqcdVWDt0k2X6lAEqA7Y8urcuYgN5uss+KTjdE6sfNja4z6GdNVKCiHR1Kn4A7gBeAhxm4c2DhrCdLshDkrvKi+q6xA0XsozUihKaH78djCN7QLMyk0bXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784940419; c=relaxed/simple;
	bh=/hwOqvOEYjW1t69W+PayLgS9rM0JMjPjdnBrJEbSvQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=upQ6dkTMa+bhLqfMH/PP02/YUyfj8JGOgRHHiQNiDbK/+Ed4IH8NCZO7Qc2H4RwMakjLWIsjUp7alxXt/lpm3VwxebWmri8mkHhp+FD4uyk8GnIbawXECfrQIJ0mAoKtonHP45erW396y1DEaB5TXHzTlBNhIkLe2kqVdvSR5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtNVbJRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtNVbJRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3154F1F000E9;
	Sat, 25 Jul 2026 00:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784940418;
	bh=wJj8P25tGCTIQftNCj/jsrylyL+ZuoJc6sGmT0PkvTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GtNVbJRwQOhoJ3gSKLz90p3GAR2WrvQIDq+hANMCjREKeA2g/Kr698mNzuKy5TH0P
	 EhGxkXdYVt97qtUUW9oeqiJ8I/44sYv/WPFHlENp9anwdFdpx7qzwcgvTCiUVJwgeI
	 llHg2DkjHPa2Tb/sdVqw15Q0JXt3cvB1aucb6D+IY1ALNscbsUudSfJEQD5KQxURPz
	 rxqyaHR/umllarO7yzXgu7pb9l/Iu6DakKH9PM4s9z640Bczc6+yHdT4TsB/U4Hl6f
	 KHu0rfVHBQzyJpt7eXnXK+hh1e7NEP6AsNvqzgv4bcWBrLUhEnb9X16d9lS8uZ3Pzj
	 tKZ8DxLgafChQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260725002302.3337017-9-rick.p.edgecombe@intel.com>
References: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
 <20260725002302.3337017-9-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 00:46:57 +0000
Message-Id: <20260725004658.3154F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PAMT and KVM MMU memory caches are depleted during transient hardw=
are contention in KVM_TDX_INIT_MEM_REGION, leading to a fatal VM crash.
--

--- Patch [8]: [PATCH v8 08/11] KVM: TDX: Get/put PAMT pages when (un)mappi=
ng private memory ---
commit 204266ade892e48bf35565ec0b69b39fdcfacf67
Author: Kiryl Shutsemau <kas@kernel.org>

KVM: TDX: Get/put PAMT pages when (un)mapping private memory

This commit adds Dynamic PAMT support to KVM's S-EPT MMU. It allocates PAMT
pages on demand when adding guest memory and releases them when removing
memory. It also introduces per-vCPU PAMT caches which are topped up and used
during page faults.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 528ebb3cb0389..b3a8af8cd4335 100644
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
> +
>  	err =3D tdh_mem_sept_add(&to_kvm_tdx(kvm)->td, gpa, level, sept_pt,
>  			       &entry, &level_state);
> +	if (err)
> +		tdx_pamt_put(page_to_pfn(sept_pt));
> +
>  	if (unlikely(tdx_operand_busy(err)))
>  		return -EBUSY;

[Severity: High]
Can transient hardware contention crash the VM here by exhausting the
pamt_cache?

If tdh_mem_sept_add() fails with TDX_OPERAND_BUSY, this function returns -E=
BUSY
and the fault is retried. However, tdx_pamt_put() frees the PAMT page to the
system allocator instead of returning it to the per-vCPU pamt_cache.

Because the page fault retry loops do not call mmu_topup_memory_caches()
on every iteration, retrying a few times will drain the pamt_cache:

	do {
		...
		r =3D kvm_tdp_mmu_map(vcpu, &fault);
	} while (r =3D=3D RET_PF_RETRY);

Once the cache is empty, the next tdx_pamt_get() will return -ENOMEM, causi=
ng
the KVM_BUG_ON() to evaluate to true and fatally crash the VM.

Should the cache be replenished during these retry loops, or should the put
operation return the page back to the cache to avoid depletion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725002302.3337=
017-1-rick.p.edgecombe@intel.com?part=3D8
