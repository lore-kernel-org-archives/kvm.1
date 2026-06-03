Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE88F35DA5D
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504371; cv=none; b=tbDAq4N1/eBL9zjOSimjzzlppDDuyR2N43rqois89Y2+kVwEW+3zDoekbhhPJBRyi2cIFFLeoegLzOyyQGfm4ZfkoI1Y4NK1z/G5/r3ijlGuY93nQnUQEd2oHpfEo2wjulcMYLKWHyozX0pR/0f/CfwCXjD3qbBuFLLx6bWte+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504371; c=relaxed/simple;
	bh=f9nKkS4BLQkxr7pM86UjiUScruhOghvv0SIkJ2GuIJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZWx6hiPCfXLA3DdT7v6zEIIHoFoAuWO4BytCdc25mmZk1FoN2/Wq99WgcsfIsX+6iIg7Ao7J9GgVaXUs2o44N0q6xtQYgAxDmMZUjOBW6xO7leGJkSTuMz1h2TKf/RNOX4SveVMFGcOTl8Dho7j24/sBtiz3e625e637ImQP/fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzexMSaT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzexMSaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744341F00893;
	Wed,  3 Jun 2026 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780504369;
	bh=ENPWNrwIfUzSApQaRRH02eHrg+sQXf7DNoBxsOvmCCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QzexMSaT52ABcr570CDR8X7s9XtuET1NOWJid0eyXQQQyWC3s+6n3yTS+lo0Cwx1K
	 dPMeud8EHmLnPf5vocODGmWUVQT9+cNKBfVGpANjZ09qqFqrn400ZnKMCVFMiL6n37
	 DyHGXDfjSpmLQOCy/emt/SU8opZ506XTwf5fghmYzu0HptDRWACB8sISD3Gxqx8t4G
	 j3ibI2hLfSc4APiVfDMQaJGg7tY9fgOYW73UP8pbwLwvvvyVq1pZQGQtUGAOS1gOK7
	 nokE8TAsvStjkuem3nPBgM2H17BkwhUn8fRlMISSDvk/eaniROblqZP4rf+0lhHtou
	 v0eE6NQ0P1uKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] KVM: s390: Allow for 2G hugepages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603154758.234768-4-imbrenda@linux.ibm.com>
References: <20260603154758.234768-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:32:48 +0000
Message-Id: <20260603163249.744341F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Enabling 2G hugepages exposes a hardcoded `_SEGMENT_MASK` in `=
_crste_fc1`, injecting invalid entries into hardware page tables.

Pre-existing issues:
- [High] Concurrent page faults can insert 1M or 2G huge pages into a PV gu=
est gmap while `KVM_PV_ENABLE` runs, because `gmap_split_huge_pages` and `g=
map_link` both acquire `mmu_lock` in read mode without sufficient serializa=
tion.
--

commit 8d8980fda5d60990dd59ce7e857350fb4c8cedbd
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Allow for 2G hugepages

Change gmap_2g_allowed() to perform the necessary checks to allow for
2G hugepages to be used, instead of unconditionally returning false. The
GMAP_FLAG_ALLOW_HPAGE_2G flag is now taken into account when evaluating
whether a 2G hugepage can back the faulting address.

> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index c9e348149ba12..c5a8132eaa22b 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c

[ ... ]

> @@ -635,10 +635,27 @@ int gmap_try_fixup_minor(struct gmap *gmap, struct =
guest_fault *fault)
>  	return rc;
>  }
> =20
> +/**
> + * gmap_2g_allowed() - Check whether a 2G hugepage is allowed.
> + * @gmap: The gmap of the guest.
> + * @f: Describes the fault that is being resolved.
> + * @slot: The memslot the faulting address belongs to.
> + *
> + * The function checks whether the GMAP_FLAG_ALLOW_HPAGE_2G flag is set =
for
> + * @gmap, whether the offset of the address in the 2G virtual frame is t=
he
> + * same as the offset in the physical 2G frame, and finally whether the =
whole
> + * 2G page would fit in the given memslot.
> + *
> + * Return: true if a 2G hugepage is allowed to back the faulting address=
, false
> + *         otherwise.
> + */
>  static inline bool gmap_2g_allowed(struct gmap *gmap, struct guest_fault=
 *f,
>  				   struct kvm_memory_slot *slot)
>  {
> -	return false;
> +	return test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &gmap->flags) &&

[Severity: Critical]
Enabling 2G hugepages here exposes a hardcoded _SEGMENT_MASK in _crste_fc1(=
).
When 2G hugepages proceed to _gmap_link(), it calls _crste_fc1() with an
unaligned f->pfn and a Region-3 table type.

arch/s390/kvm/dat.h:_crste_fc1() {
    union crste res =3D { .val =3D PFN_PHYS(pfn) & _SEGMENT_MASK };
    ...
}

The constructor hardcodes _SEGMENT_MASK, which fails to zero out bits 20-30
for Region-3 hugepages. For a Region-3 large page entry, the hardware requi=
res
these bits to be strictly zero. Writing the unaligned 2MB-to-2GB offset into
these reserved bits causes the hardware MMU to trigger a Translation
Specification Exception when it walks the page table.

Should _crste_fc1() be updated to use _REGION3_MASK for Region-3 entries to
prevent guest crashes?

[Severity: High]
This isn't a bug introduced by this patch, but adding 2G hugepages to this
path exacerbates a preexisting race with PV initialization.

Concurrent page faults can insert huge pages into a PV guest gmap while
kvm_s390_pv_init_vm() runs. The initialization code clears the flags and ca=
lls
gmap_split_huge_pages():

arch/s390/kvm/pv.c:kvm_s390_pv_init_vm() {
    ...
    clear_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &kvm->arch.gmap->flags);
    clear_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &kvm->arch.gmap->flags);
    gmap_split_huge_pages(kvm->arch.gmap);
    ...
}

However, gmap_split_huge_pages() only takes a read lock on kvm->mmu_lock.
If a vCPU thread evaluates test_bit() in gmap_2g_allowed() to true before
the flag is cleared, and is then preempted, the splitting function can
walk past the faulting GFN.

When the vCPU thread resumes, it can atomically insert the 2G huge page
into the gmap via _gmap_link(), as that also only holds mmu_lock in read
mode.

Does this race allow a PV guest to map a hugepage and break memory
isolation invariants?

> +	       !((f->gfn ^ f->pfn) & ~_REGION3_FR_MASK) &&
> +	       slot->base_gfn <=3D ALIGN_DOWN(f->gfn, _PAGES_PER_REGION3) &&
> +	       slot->base_gfn + slot->npages >=3D ALIGN(f->gfn + 1, _PAGES_PER_=
REGION3);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603154758.2347=
68-1-imbrenda@linux.ibm.com?part=3D3
