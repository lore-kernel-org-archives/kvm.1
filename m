Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498D3382DC
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227325; cv=none; b=uA/ZHYZ5ho1VCwzpFW46CSu+GI93MoBn/uU6bY6o9K2Vok7fmg7lCnbcY/Zk0aG8GygoWJv5WQ4VB98DZ3v+7H0rFL0qceypnUty+r/LNsOm9LRJwxbdd/S+HM0GUKo9HZDAW/FRz1vQmm5GX6S93vHimc8yRrhKnIckRoiApC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227325; c=relaxed/simple;
	bh=awLHZzaezstA9RH8IhjiWzcsJEOu9E+3op0C3Kjv+Dk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aRjpXSatJ+fGCCUzrvFe/lOfZS9KUr9CtioCqKNBLVe4CIk5KbMXMkf4xwIXLyQLOBUecf7fVzrnlIo6O/W4nddpsr0b9dULMsc7aY4qCv/lA9R7oZmFPCBEJZVr2A/J9QyyCa7TldzNN9EL6PyGLLPJEdd/kUV8xgpnotftYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFOCvXB6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFOCvXB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DC51F000E9;
	Thu, 16 Jul 2026 18:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227324;
	bh=CyLwxuOa1i9bWpGxthEm6A1iNUaLdTx8FMU/0oz1Tck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MFOCvXB6eeRJERTWPZ2skCp00iy9BAaKTeL/OYQwnMnyL65Q1NbyjxuKehSPLyci3
	 ZRjC2MlAyQ2NNBvvhjUT2VhUPfhZnZ36YnVPDH0TCAqOpTeN96mmnKOAgHInrKhir8
	 CeoVo9ntcInIb+Xqm0ddxoUQ9wDocaTSYe8k90ncCspLjkF4ntSbidJequCJPI/BmK
	 x4LOaKsL8IwE5XfU2PsZXaPtMEO38QiFbqr5IMc1YOg2rWZCbBkmLq3gtNKO7XV3aa
	 uR+T3b7knLgWu7hJySsrSRe2sqHzaR/Rv5KqgBdUM6RO8+L7yfQnYVPjq0P9RcQSUI
	 VyESvgShW3QGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/24] KVM: x86: Avoid warning when installing
 non-private memory attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-7-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:42:03 +0000
Message-Id: <20260716184204.07DC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The defensive sanitization of memory attributes is ineffective, =
containing a dead store and failing to prevent inconsistent xarray state.
--

--- Patch [6]: [PATCH 06/24] KVM: x86: Avoid warning when installing non-pr=
ivate memory attributes ---
commit 08f754e61d84422c72539df0f4a05fb7d05a02f5
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: x86: Avoid warning when installing non-private memory attributes

This commit adds a check to warn and clear KVM_MEMORY_ATTRIBUTE_PRIVATE in
both kvm_arch_pre_set_memory_attributes() and
kvm_arch_post_set_memory_attributes() when private memory is not supported.
It replaces the unconditional WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm))
checks that were previously throwing warnings.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 424f4e1136822..055e0b45a8ee9 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -8078,9 +8078,15 @@ static void hugepage_set_mixed(struct kvm_memory_s=
lot *slot, gfn_t gfn,
>  bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>  					struct kvm_gfn_range *range)
>  {
> +	unsigned long attrs =3D range->arg.attributes;
>  	struct kvm_memory_slot *slot =3D range->slot;
>  	int level;
> =20
> +	if (!kvm_arch_has_private_mem(kvm)) {
> +		WARN_ON(attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +		attrs &=3D ~KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +	}
> +

[Severity: Medium]
Is this attrs update effective, or does it result in a dead store?

Looking further down in kvm_arch_pre_set_memory_attributes(), the unmap
filter logic evaluates the unmodified range->arg.attributes instead of using
this newly sanitized attrs variable:

	/* Unmap the old attribute page. */
	if (range->arg.attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)
		range->attr_filter =3D KVM_FILTER_SHARED;
	else
		range->attr_filter =3D KVM_FILTER_PRIVATE;

Does this mean the invalid attributes are still processed if they manage to
reach this path?

[ ... ]

> @@ -8165,16 +8168,17 @@ bool kvm_arch_post_set_memory_attributes(struct k=
vm *kvm,
>  	lockdep_assert_held_write(&kvm->mmu_lock);
>  	lockdep_assert_held(&kvm->slots_lock);
> =20
> +	if (!kvm_arch_has_private_mem(kvm)) {
> +		WARN_ON(attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +		attrs &=3D ~KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +	}
> +

[Severity: Medium]
Could sanitizing attrs locally here lead to inconsistent state evaluations
later on?

In virt/kvm/kvm_main.c:kvm_vm_set_mem_attributes(), the unmodified attribut=
es
argument is unconditionally stored into the global xarray before the
arch-specific callbacks run:

	r =3D xa_err(xa_store(&kvm->mem_attr_array, i, entry,
			    GFP_KERNEL_ACCOUNT));

If kvm_arch_post_set_memory_attributes() passes this locally sanitized attrs
variable into hugepage_has_attrs(), will it erroneously compare the sanitiz=
ed
value against the unsanitized values stored in the xarray?

>  	/*
>  	 * Calculate which ranges can be mapped with hugepages even if the slot
>  	 * can't map memory PRIVATE.  KVM mustn't create a SHARED hugepage over
>  	 * a range that has PRIVATE GFNs, and conversely converting a range to
>  	 * SHARED may now allow hugepages.
> -	 */
> -	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
> -		return false;
> -
> -	/*
>  	 * The sequence matters here: upper levels consume the result of lower
>  	 * level's scanning.
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D6
