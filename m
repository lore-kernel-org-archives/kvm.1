Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698284FD281
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743474; cv=none; b=YCAUXw8bSVjkSWzgprDOQgvGM762NY5kfs7luGVf5fe/m0wopUJ9//34HUsM1ADiObu2dyOouo8kIJIRh6Bt6dLhcbdjmG3+k1ImZXwpcojX6AQkFKLOspSenrT/1pEAclRptzuK9Dm+8o+nI6+Nf6e7qEw0XfoAP6rsIFCafDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743474; c=relaxed/simple;
	bh=G/gFmpu1Tcg4GG6o8z225VtNQxYHavwTvEVRSsulBHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KZjVxQYzMhzsREE2fIo3Uc+cayPv2RGXsWGXL1xv2zlN9V8U+gVWQvNXY15wXUq2hkPL5qswbtYRmsnO2rZMhXK46VJSWtEpPYIpkRY63yoeqsfZH5V71NzAwMMm+lf5Iew8QNm6MvnHOkn8BRDlgu/8nvgGJgbh9fKcyPglsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZbom7oC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZbom7oC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E551F000FF;
	Fri, 18 Sep 2026 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743473;
	bh=KdaEzLzGhI8x8/EiW6Jiujlj2ehC49VW5TO6zViUGlk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZbom7oCNGq/6rPpIJdoB/Z+a7hCHnejZtes5HVy+13dD4hE9tXGr237IwsaTQa3V
	 Rm1RWTfaWhmqkLzucWa8z0RwrgEcE6aRjmAp2OIe3x9wOM4bnEb+ZZ8q6LfcvllvcG
	 /5/crya9+otvBL1j3FQGe2+IYwKfI+yeygc5JShVWaJjVWfmEDpRr1w3Vom5KlXjv9
	 3FPqcLS2M2Val6k//g5gQxdgIzoj8aEzu0qkzVdE6KAykk/hI9gLUUUjuTCesXe9DO
	 pNJYaNBi2wnrWeALRmCAyZWR8vqj0R0p4NVH29KkD4PEo85FtIsNoEHbbmc0kNeq6E
	 4JPi4y5ncOX3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 28/31] KVM: x86/mmu: Obsolete all roots if memattr
 contains gPTEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918135030.171564-29-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
 <20260918135030.171564-29-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:57:52 +0000
Message-Id: <20260918145753.30E551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: soft lockup in KVM_SET_MEMORY_ATTRIBUTES due to unyielding lo=
op
--

commit c7a249c1f674a4bf236247e82b5eb5accc8a2958
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: Obsolete all roots if memattr contains gPTEs

This commit introduces a separate architecture callback for the back half of
kvm_mmu_zap_all_fast() so that obsolete roots can be zapped after the mmu_l=
ock
is dropped. It applies this by checking for guest PTEs when setting memory
attributes and triggering a front-half fast zap if found.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6bbecbae2f8c4..242cbe65859df 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> @@ -8326,9 +8327,38 @@ bool kvm_arch_post_set_memory_attributes(struct kv=
m *kvm,
[ ... ]
> +	/*
> +	 * There are special considerations when applying an memory protection
> +	 * attibute against a page containing guest PTEs, because virtual
> +	 * addresses that requires traversing that page need to fault.
> +	 *
> +	 * When using shadow paging, the PTEs that the CPU actually walks
> +	 * do not have any information about attributes (unlike TDP where
> +	 * the attributes become part of the TDP permission bits).  Since
> +	 * this should be a rare occasion, just invalidate all the mmu roots
> +	 * if shadow paging is in use and attributes do cover a guest PTE.
> +	 */
> +	for (gfn_t gfn =3D range->start; gfn < range->end; gfn++) {
> +		for_each_gfn_valid_sp_with_gptes(kvm, sp, gfn) {
> +			__kvm_mmu_zap_all_fast_front_half(kvm);
> +			return false;
> +		}
> +	}
>  	return false;
>  }

[Severity: High]
Does this loop present a denial of service vector?  If userspace calls the
KVM_SET_MEMORY_ATTRIBUTES ioctl with a very large memory range (for example,
1TB), this loop will execute hundreds of millions of iterations doing hash
table lookups.

Because kvm_arch_post_set_memory_attributes() is called with the global
kvm->mmu_lock held for write, and the loop scales linearly with the size of
the update without yielding, can an unprivileged userspace process stall
the host CPU indefinitely, causing RCU stalls and soft lockups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918135030.1715=
64-2-pbonzini@redhat.com?part=3D28
