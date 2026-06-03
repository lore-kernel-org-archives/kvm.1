Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED034A797
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486443; cv=none; b=OnBYA3ZC94CRYrDExGg+PFt+SgIQ2f+jynLcS7gmhCj+BsfAOs7Wm70Oj112vr9+3WD8R4neMYeFwYV0g/Hdq04yb55pxMAc8/+OT2ECg7Zmnn8W2YZUb6cfY5Bv3ejtd3RKjGhOo4L/C/47w8SIPf2yIFp8Fx0wbJX78P5RF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486443; c=relaxed/simple;
	bh=tiSXmmeFgzgvpMZkpG1bANWkvJm7Cv0gQMfSDOUGBC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZTiaWQPmjnPCOh7AgBPLZdE8VxsibDtE/2CJ8yO4EV857BgjZi8/c/nCzapDNnnlktklJ/Xk5/BVKO2RYvO2ptL2Xxok7bcndmvQXMY6uhwutd2LzfQwT06ZtjytveGCVdRHWV4f0S7ruhf9McUxYvlG9UPKHdLBm3i9MJhBlog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I90qP9IO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I90qP9IO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF071F00893;
	Wed,  3 Jun 2026 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486442;
	bh=k5aTS1YG2O72fH2wmeWhveDdvw/hFwcvr5q1hjOF4tk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I90qP9IOQc6bjqzdOXMfAwyIeMy9ys9jkXHH+gj13iBj4kX23UKAaupL5zZeErEXj
	 rnI3fziAc1xqmyIUsBql8VOWTYy8QEN+CC2wpUM8gc0/Mq+4M7sgnw/ZGVP7zOWjEv
	 DEUnq9mM8MEc+GEgtIpIp1XQt++RD/RVaWIXCHlnhS6coyEVoKqvymg7V9mAI4/jlY
	 3iMgrc84nXiueASUw3YM1xj9BfEkEBGJTdtNltWh+SUnWctlT2bSZhsATVXDcQ6ZJH
	 ihcBv0T6B1C/d6TniOlKtKZa19YhHUeXwV3/wV1gKl/IN5OKQP66rwlWFDS+gkz9Ef
	 o2iZBOSw0j4xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/24] KVM: x86/mmu: use kvm_page_format to test SPTEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603105814.10236-25-pbonzini@redhat.com>
References: <20260603105814.10236-25-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:34:01 +0000
Message-Id: <20260603113402.5DF071F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The `spte_permission_fault()` function indexes the statically-=
sized 16-element `mmu->fmt.permissions` array using the raw hardware page f=
ault error code (`fault->error_code`), leading to an out-of-bounds kernel m=
emory read and host kernel panic when higher-order error code bits are set =
by hardware (e.g., AMD RMP faults).
--

commit 18ca0883f7313fb2ea6fc90d61d35c33ed81ed22
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Jun 3 10:58:14 2026 +0000

    KVM: x86/mmu: use kvm_page_format to test SPTEs
   =20
This commit replaces the custom is_access_allowed() implementation with=20
spte_permission_fault(). The new version leverages kvm_page_format to check
SPTEs against permissions, adding support for SMEP and paving the way for
TDP entries with differing XS and XU bits.

> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index 918533e61b983..9bddfa0e02b97 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h

[ ... ]

> @@ -496,20 +485,35 @@ static inline bool is_mmu_writable_spte(u64 spte)
>  }
> =20
>  /*
> - * Returns true if the access indicated by @fault is allowed by the exis=
ting
> - * SPTE protections.  Note, the caller is responsible for checking that =
the
> - * SPTE is a shadow-present, leaf SPTE (either before or after).
> + * Returns true if the access indicated by @fault is forbidden by the ex=
isting
> + * SPTE protections.
>   */
> -static inline bool is_access_allowed(struct kvm_page_fault *fault, u64 s=
pte)
> -{
> -	if (fault->exec)
> -		return is_executable_pte(spte);
> -
> -	if (fault->write)
> -		return is_writable_pte(spte);
> -
> -	/* Fault was on Read access */
> -	return spte & PT_PRESENT_MASK;
> +static inline bool spte_permission_fault(struct kvm_mmu *mmu, u64 spte,
> +					 struct kvm_page_fault *fault)
> +{
> +	unsigned int pfec =3D fault->error_code;
> +	int index =3D pfec >> 1;
> +	int pte_access;
> +
> +	if (!is_shadow_present_pte(spte))
> +		return true;
> +
> +	BUILD_BUG_ON(PT_PRESENT_MASK !=3D ACC_READ_MASK);
> +	BUILD_BUG_ON(PT_WRITABLE_MASK !=3D ACC_WRITE_MASK);
> +	BUILD_BUG_ON(VMX_EPT_READABLE_MASK !=3D ACC_READ_MASK);
> +	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK !=3D ACC_WRITE_MASK);
> +
> +	/* strip nested paging fault error codes */
> +	pte_access =3D spte & (PT_PRESENT_MASK | PT_WRITABLE_MASK);
> +	if (shadow_nx_mask) {
> +		pte_access |=3D spte & shadow_user_mask ? ACC_USER_MASK : 0;
> +		pte_access |=3D spte & shadow_nx_mask ? 0 : ACC_EXEC_MASK;
> +	} else {
> +		pte_access |=3D spte & shadow_xs_mask ? ACC_EXEC_MASK : 0;
> +		pte_access |=3D spte & shadow_xu_mask ? ACC_USER_EXEC_MASK : 0;
> +	}
> +
> +	return (mmu->fmt.permissions[index] >> pte_access) & 1;

[Severity: Critical]
Could this lead to an out-of-bounds read if the hardware page fault error
code contains higher-order bits?

Looking at spte_permission_fault(), the raw fault->error_code is shifted
and used directly as an index into the mmu->fmt.permissions array. Since
this array only has 16 elements, an unmasked error code with higher bits
set could easily exceed the array bounds.

For example, if an AMD RMP fault sets bit 31 (PFERR_GUEST_RMP_MASK), the
index would be 1073741824, potentially causing a host kernel panic when
accessing mmu->fmt.permissions[index]. Even without SEV-SNP, a PKRU fault
(bit 5) under shadow paging results in an index of 16, which is also out
of bounds.

Should fault->error_code be masked before computing the index?

>  }
> =20
>  /*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603105814.1023=
6-1-pbonzini@redhat.com?part=3D24
