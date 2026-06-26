Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5313A3ED
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782517146; cv=none; b=KtfJS8yYPEJI9+90CHXvTOKMystcqYMtCtejmXveYN2Iu//S89kXwfqhCWOu3gZeo9u5BbiCGgCrjZ0bM3bL2g7gDIqYY/QGGs0oR99+L12txU59kS/U7WQhecfRqW1tpYJX6EBby9xXMKcOGITjByDe356WqjQ/tJDyyB2cLEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782517146; c=relaxed/simple;
	bh=z3Xcx0QmRmTw4jg+IihNbxvc96SWe7OPemnt4ErPRRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eUJU1Tyw+0vEnC7MXpzE5LSesqNxgfp94xTtXSrHyvaQgdu6LLPf70Bg+Tiy0TUhuocNCTWEt4aRm4B7tHvuMA2baYK/VEq3t6hnASrk10TFOQd0Wau4Ldz1zNv7vi5oHw1thoqfzu14KbDK8fxAKuyaqzI4hseTfFPwTyZ75Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh2WhCrc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh2WhCrc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDE11F000E9;
	Fri, 26 Jun 2026 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782517144;
	bh=0+ds92NFQkJskzegRvoqPELtIU0TfKrWl4tNEskM97Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dh2WhCrcDOjAdwqXnLDCqtQe70bgm2q2y1vkRrLDZ13c44G1bt5Zp8El42UXVpQmL
	 X6xMzRU5Mfy1+cWzyqHjP2yy/HCi0b+5w7kjAM4QZD5UFrUNt3jePN8z9VMpJogVVi
	 Bwyy4I3q19sQUMcC+5vW1s1oXpj1UO4VAiMWFjvT5eeDl0edtezPjyUGCl1at8ZnEO
	 ukyFyzAoLDFccOLAp5xWX9CEGrTB5WBZULYighk8aFP4fSiXSGzlLpyzlJRgclxeUe
	 XM0q4c6XPqxTDd0qSEOPHaMEKjKMTN3JgUVTOxm5NbQ1Pd+P5sOYiC3zpsFCi65t0n
	 mAvwtUUKsexNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626231416.3943216-8-seanjc@google.com>
References: <20260626231416.3943216-1-seanjc@google.com>
 <20260626231416.3943216-8-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 23:39:04 +0000
Message-Id: <20260626233904.ABDE11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Data Race on lockless access to `snp_guest_vmsa_gpa` without READ_O=
NCE/WRITE_ONCE.
--

commit 0384ec40691742221905a1f869e903471b8acac7
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped

This commit wires up a gmem_invalid_range() call for SNP VMs. It forces
vCPUs to reload or recheck their guest-provided VMSA if the backing
guest_memfd page is being invalidated.

Link: https://lore.kernel.org/all/aimMWzAf5b3luM0b@v4bel

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 3d90aa723dc25..04be49b1af57d 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c

[ ... ]

> @@ -5135,6 +5154,31 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pf=
n, gfn_t gfn, int max_order)
> =20
>  	return 0;
>  }
> +void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *ra=
nge)
> +{
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
> +	lockdep_assert_held_write(&kvm->mmu_lock);
> +
> +	/*
> +	 * An unstable result for "is SNP" is a-ok here, thanks to mmu_lock.
> +	 * The vCPU's VMSA GPA is invalidated before the vCPU is made visible
> +	 * to other tasks, and can only become valid while holding mmu_lock,
> +	 * after the VM is fully committed to being an SNP VM.
> +	 */
> +	if (!____sev_snp_guest(kvm))
> +		return;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		gpa_t gpa =3D to_svm(vcpu)->sev_es.snp_guest_vmsa_gpa;
> +
> +		if (VALID_PAGE(gpa) &&

[Severity: Low]
Can this lead to a data race or KCSAN splat?

Here snp_guest_vmsa_gpa is read locklessly relative to snp_vmsa_mutex. It is
read under mmu_lock, but in __sev_snp_reload_vmsa(), snp_guest_vmsa_gpa is
cleared (set to INVALID_PAGE) while holding snp_vmsa_mutex without mmu_lock.

Since they don't share a common lock for this variable's lifecycle, should
this read and the corresponding write in __sev_snp_reload_vmsa() use
READ_ONCE() and WRITE_ONCE() to prevent compiler refetching or optimization
artifacts?

> +		    gpa_to_gfn(gpa) >=3D range->start &&
> +		    gpa_to_gfn(gpa) < range->end)
> +			kvm_make_request_and_kick(KVM_REQ_VMSA_PAGE_RELOAD, vcpu);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626231416.3943=
216-1-seanjc@google.com?part=3D7
