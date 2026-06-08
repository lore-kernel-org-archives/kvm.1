Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C72E5B2D
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907164; cv=none; b=o1t3vzCcQBs6yczhCEL9DTefEPbGZQAv1xTVyBkakwa7bk9Szn/2Ys1sAcoqf/o8HzChx8AFakT92kJW3Tj+CdCShIUTu7Y74d5AzTyR46jf0nT9vz1ii8mKcVt1mzKOj2iBZYokF6kc26B9H8GcUKUk1kDMgmMFc7V3dO62nSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907164; c=relaxed/simple;
	bh=Fmu1u7XTtwMb7E/AiX7sSoPILcSDF51ahRkCu8GHLck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hNFj+nh+mHCk+FYpuFLdDpwx0JG5F0p8iTHpeFSNbPLq9M4qzc1ErRN02O2doU+/452RdvGFy/hIYWbnrupbXSx9FVqq3ff9aF2iD735DWSLikKpqHJ042NXVIaB5I1Lj0iLErN8CptnJDbAu7S8JGEMMKyJ2ase1I5ljA7nHTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFO7KzQo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFO7KzQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AEC1F00893;
	Mon,  8 Jun 2026 08:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907163;
	bh=2rAyEjstaTr75K0Ach0duVMqLGBkaxSLvTNigTlHVcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KFO7KzQov5+nwi6Qz1t4v0BJqUlXEU13bwouOw5TzMPCVYf4GulEepmvJuwx6pPTu
	 y8lxZgbRSCBbKceBWxG2lQ8Aaa7M/CHJpJBAa7zz/Cmeem6k6hKEmLhLdgnp3ersqc
	 pOKtX0H6oixkaNQqTbN9z3bItBG64PkbwcHZTseqkdEwHxWjTpIm11/a0RZUbwxoNI
	 RAl/DLT4wvvke/rRXGeBhCnYXRTvUmMzp5p+h1X7N0SF+TI1a1HN2IM7TNVs1p66fv
	 QODk+rGamzRky8whq5vx2jvVk7JMgAiLCx/M7PBS22FgAnMGC1OIBb1reJMDOxQmtK
	 Dba3EOkTT83cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: arm64: Hold kvm->mmu_lock while initialising
 vcpu->arch.vncr_tlb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Zyngier" <maz@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608081108.2244133-1-maz@kernel.org>
References: <20260608081108.2244133-1-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:26:02 +0000
Message-Id: <20260608082603.16AEC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing NULL check for `vcpu->arch.vncr_tlb` in `invalidate_vn=
cr_va()` causes a host kernel panic when iterating over uninitialized vCPUs.
- [High] The lazily allocated `vncr_tlb` structure leaves the `cpu` field z=
ero-initialized, causing it to inadvertently unmap CPU 0's VNCR fixmap on t=
he first fault.
- [High] Resource leak of `struct page` references on error paths in `kvm_t=
ranslate_vncr()`.
--

commit cf6d236759b9eb5ba69620ec32a536af7c15a9a2
Author: Marc Zyngier <maz@kernel.org>

KVM: arm64: Hold kvm->mmu_lock while initialising vcpu->arch.vncr_tlb

This commit fixes a race condition and memory leak in the initialization
of vncr_tlb by taking the mmu_lock during assignment and verifying it is
NULL beforehand.

Link: https://lore.kernel.org/r/20260607180815.85FBC1F00893@smtp.kernel.org

> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index 883b6c1008fbb..21c9d1f07d7a8 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -1248,8 +1248,14 @@ int kvm_vcpu_allocate_vncr_tlb(struct kvm_vcpu *vc=
pu)
>  	if (!kvm_has_feat(vcpu->kvm, ID_AA64MMFR4_EL1, NV_frac, NV2_ONLY))
>  		return 0;
> =20
> -	vcpu->arch.vncr_tlb =3D kzalloc_obj(*vcpu->arch.vncr_tlb,
> -					  GFP_KERNEL_ACCOUNT);
> +	if (!vcpu->arch.vncr_tlb) {
> +		struct vncr_tlb *vt =3D kzalloc_obj(*vcpu->arch.vncr_tlb,
> +						  GFP_KERNEL_ACCOUNT);

[Severity: High]
This is a pre-existing issue, but since we are allocating the vncr_tlb here
using kzalloc_obj(), vt->cpu will be zero-initialized.

Looking at invalidate_vncr(), if a vCPU encounters its first VNCR fault,
kvm_translate_vncr() calls invalidate_vncr(vt). Because vt->cpu is 0
instead of -1, the following check passes:

arch/arm64/kvm/nested.c:invalidate_vncr() {
        ...
        if (vt->cpu !=3D -1)
                clear_fixmap(vncr_fixmap(vt->cpu));
        ...
}

Does this inadvertently unmap CPU 0's fixmap, potentially corrupting the
translation state if another vCPU is actively mapped on CPU 0? Could we
initialize vt->cpu to -1 right after this allocation?

> +
> +		scoped_guard(write_lock, &vcpu->kvm->mmu_lock)
> +			vcpu->arch.vncr_tlb =3D vt;
> +	}
> +
>  	if (!vcpu->arch.vncr_tlb)
>  		return -ENOMEM;

[Severity: Critical]
This isn't a bug introduced by this patch, but while reviewing the vncr_tlb
lifecycle, I noticed a potential issue in invalidate_vncr_va() when
iterating over uninitialized vCPUs.

If an online vCPU triggers an EL2 TLBI instruction before another vCPU in
the same VM has run, could this lead to a NULL pointer dereference?

arch/arm64/kvm/nested.c:invalidate_vncr_va() {
        ...
        kvm_for_each_vcpu(i, vcpu, kvm) {
                struct vncr_tlb *vt =3D vcpu->arch.vncr_tlb;

                if (!vt->valid)
                        continue;
        ...
}

Since vncr_tlb is allocated lazily on the first run, vt could be NULL here.
Does this path need a NULL check before accessing vt->valid?

[Severity: High]
This is also a pre-existing issue, but I noticed a potential page reference
leak in kvm_translate_vncr() on the error paths.

When __kvm_faultin_pfn() successfully pins a page, the early return for a
write fault without a writable page bypasses kvm_release_faultin_page():

arch/arm64/kvm/nested.c:kvm_translate_vncr() {
        ...
        if (is_error_noslot_pfn(pfn) || (write_fault && !writable))
                return -EFAULT;
        ...
}

Similarly, the MMU retry check also returns directly:

arch/arm64/kvm/nested.c:kvm_translate_vncr() {
        ...
        if (mmu_invalidate_retry(vcpu->kvm, mmu_seq))
                return -EAGAIN;
        ...
}

Do these error paths leave the page pinned and permanently leak the struct
page reference count?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608081108.2244=
133-1-maz@kernel.org?part=3D1
