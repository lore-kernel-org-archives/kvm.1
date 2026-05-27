Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE23806D6
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852594; cv=none; b=DkZnWnpkyiuoG952+7YDts1bPz6LwSPR9btHAiLiLiS99ACVJVc5c9WlQ2tdSsYO/NuBuWbHFqwkMaecCEDcfkhThqzGiqWjikPa73M2gK9NQDZ+bP/aWxz/xlMsZAbpswehwlvFhRL9JvhCmdMANtmmhcek5VKN3ZNf/+yrWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852594; c=relaxed/simple;
	bh=Tt9FVmg//7mK1+dC5sxTJMqU8ZQpf1QOgnhYX/ptzj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SzqPcxlKtqYuEg+NEXs5UvRf6z4dt/+y9jzH32oKQpZQ5ghW0tfE8a6jqOTlzg/LLjim9fl4kBz3TyDlN5zSc6YyKBeBx1aBWJ+z+c9QpCH3cmIPqoBMdLeBswFLe6jRJD0W97twXNrBIzJjyLEMLZoYVcdUqRLw6AfLddLr4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6/p87hE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6/p87hE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB30A1F00A3D;
	Wed, 27 May 2026 03:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779852593;
	bh=V28ioQXFdf5gTV6d1QcGHOYfgP6PyYYIJ6KhFhOwRv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E6/p87hE2ODh5PH9R4bqr15mw1R3r4CAnO0HSz+ywaCgA/r1YFXQCtIgRdKyZ56iV
	 UR4KmUdRjXZDC6M6dSFR83LR2zt9idzg880Ca6PLPAhMwmj6eIudNTjpfmgpTCJ1qV
	 fHV6PnpC37PnqwLvUfsckUYSQPFEKJ7kTt+wLgu2WH3whUO7XBOh6Z1RZcIntS895O
	 GEqzvZYotL18HvNf1zJIczOMZNG7CSufMxdvdxe8Z0QgoByxj7/sHkLinypvc0p8jV
	 vdggKTt+NQozYCSiPMFqTLLVeJxNTg+mo7egXoU28B+jkCjrqaK85zm3qNBV/SQlG1
	 XY4uM1rmJS3pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/43] KVM: x86/mmu: Bug the VM if gmem attributes
 are queried to determine max mapping level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260507-gmem-inplace-conversion-v6-6-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-6-91ab5a8b19a4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 03:29:52 +0000
Message-Id: <20260527032952.DB30A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The newly added KVM_BUG_ON check in kvm_mmu_max_mapping_level eval=
uates global state and unconditionally crashes standard, non-confidential V=
Ms whenever user-space disables dirty logging.
- [Low] The patch unconditionally references conditionally compiled symbols=
 (`__kvm_get_memory_attributes` and `kvm_gmem_get_memory_attributes`), resu=
lting in build and link failures on standard configurations.
--

commit ffa430675edb844f07837310c0934745f310bf26
Author: Ackerley Tng <ackerleytng@google.com>

KVM: x86/mmu: Bug the VM if gmem attributes are queried to determine max ma=
pping level

This commit introduces a KVM_BUG_ON check in kvm_mmu_max_mapping_level()
to prevent querying guest_memfd memory attributes while holding the MMU
lock.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a80a876ab4ad6..153bcc5369985 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> @@ -3357,6 +3357,15 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm, str=
uct kvm_page_fault *fault,
>  		max_level =3D fault->max_level;
>  		is_private =3D fault->is_private;
>  	} else {
> +		/*
> +		 * Memory attributes cannot be obtained from guest_memfd while
> +		 * the MMU lock is held.
> +		 */
> +		if (KVM_BUG_ON(static_call_query(__kvm_get_memory_attributes) =3D=3D
> +			       kvm_gmem_get_memory_attributes, kvm)) {

[Severity: Low]
Does this code cause build and link failures on standard configurations?

When CONFIG_KVM_MEMORY_ATTRIBUTES is disabled (e.g. standard x86 builds
without confidential VM features), __kvm_get_memory_attributes is not
declared.

Additionally, on 32-bit builds where CONFIG_KVM_GUEST_MEMFD is disabled,
kvm_gmem_get_memory_attributes is undefined. Unconditionally referencing
these symbols here breaks the build on those setups.

[Severity: High]
Does this check evaluate global state instead of checking if the specific
memslot uses guest_memfd, potentially crashing standard VMs?

On standard x86_64 configurations, KVM initialization can set this global
static call to kvm_gmem_get_memory_attributes for all VMs. If userspace
(like QEMU) disables dirty logging on any memslot, KVM triggers huge page
recovery:

kvm_tdp_mmu_recover_huge_pages()
    kvm_mmu_max_mapping_level(..., fault =3D NULL, ...)

Since fault is NULL, this executes the KVM_BUG_ON() check. Because the
global static call matches, the condition evaluates to true and immediately
kills the innocent VM via kvm_vm_bugged().

Could an unprivileged userspace VMM trigger a local denial of service
simply by toggling dirty logging on standard non-confidential VMs?

> +			return 0;
> +		}
> +
>  		max_level =3D PG_LEVEL_NUM;
>  		is_private =3D kvm_mem_is_private(kvm, gfn);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-gmem-inpla=
ce-conversion-v6-0-91ab5a8b19a4@google.com?part=3D6
