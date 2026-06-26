Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954219D07A
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482513; cv=none; b=EjTFsgiDlK03Mk8zLLUnJWFmdquajOx+u7mkC2jFsxyC/4Coi2ThjDbvspTEmSfQh6ddq57rCNbUiFxBhXFcFLBjtIuqWRD5aB1P/Xfmti5A0LbwA2ztn5brYGpnpswPdVmyRvZ+lR97VBB+PoU0JFKvleXzWYhG1E6iKnNnTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482513; c=relaxed/simple;
	bh=8QwqAX+DDv2FAXdhmNA8D6WkL/h8ogU9eC9uUJ4kWcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l2KXq5/XQLfFdFTuLVZ9Qx9aejPQ0Dl/uYoAm2MZ3jCbkRu+vJrnuNd8DV7b3kHqhMKo5CdPn4jtpF7prmjEkQOKRbXEfofMRozM67yFa/7sZJ4+yIG49XNT3cBmNK3pG37uDLwbN6uUQ7dndfZIIHFOYzcxaQBZD65kOIX9Sz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geXSsRaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geXSsRaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75F91F000E9;
	Fri, 26 Jun 2026 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782482512;
	bh=2UjCv1H2gQlx+0MhBLX0Re35KcHfescQ8JNG6hpxe0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=geXSsRaG5/+8fRWFx4q3z+pJSe18ZDFYtg27xraZidGdzEPjc8zvwlL4581qbpcOu
	 XCbP+POOyDl3zqVakRx/CyWnmhNoxBoY9Lw1hmmZ/c74cgC4+n/NvkSKRcrcbIHXoq
	 YrlWWeai5TPpE58HEKnQ223Hgn4sduFBJocmgGGgr9uEFdgU5QyWwDNnmC6j0a819x
	 w4ZdpfmS8Up/+zAgmVHdkb/PM7AoL+E9DY4LTcpc3LUpUX/0zwE1UlNQy6SzQ2WMRm
	 vtRHi71Oq/JXanfVGXIRHY996ETfOJZmA82Z8DZcpiUljJui3iQpttfRnp8R9CfXnF
	 WG3FGyygIWTCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10.y 13/17] KVM: x86/mmu: pull call to
 drop_large_spte() into __link_shadow_page()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626112634.1778506-14-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
 <20260626112634.1778506-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:01:51 +0000
Message-Id: <20260626140151.E75F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added `cache` parameter in `__link_shadow_page()` is neve=
r used.
--

commit 58832cb7365080324e7906cc11df0e03073304a5
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()

This commit moves the dropping of large SPTEs from the callers into
__link_shadow_page() to happen just before the shadow page is installed.
It also modifies kvm_mmu_get_child_sp() to return an error pointer if the
shadow page already exists, preventing duplicate links.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 5df1cd5bff1b9..47c5c3613b682 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c

[ ... ]

> @@ -2208,13 +2201,21 @@ static void shadow_walk_next(struct kvm_shadow_wa=
lk_iterator *iterator)
>  	__shadow_walk_next(iterator, *iterator->sptep);
>  }
> =20
> -static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
> -			     struct kvm_mmu_page *sp)
> +static void __link_shadow_page(struct kvm_vcpu *vcpu,
> +			       struct kvm_mmu_memory_cache *cache, u64 *sptep,

[Severity: Low]
This isn't a bug, but is the new cache parameter intended to be used?

Looking at the rest of this function, the cache argument is never reference=
d.
Instead, nested operations like mmu_page_add_parent_pte() continue to
implicitly use vcpu->arch.mmu_pte_list_desc_cache from the vcpu struct.

> +			       struct kvm_mmu_page *sp)
>  {
>  	u64 spte;
> =20
>  	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK !=3D PT_WRITABLE_MASK);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626112634.1778=
506-1-pbonzini@redhat.com?part=3D13
