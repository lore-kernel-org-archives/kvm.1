Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2E3290C9
	for <kvm@vger.kernel.org>; Sun, 13 Sep 2026 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789318290; cv=none; b=oNZ5vdqkYKQpK1/uxAbKWemAd8E8YtK6hJ7fVStyI8orUxdWupI0FqcpUclstBCkEJYVmHEtaZ+noW7I/2xaZhunMoUBaaSLoeNWDTbiokTW+QbwmuxVRLUnbWqGz/PMcnFOZh4bfnt4uDg85iuvv9o3XY2ybFwzttEiLPcXA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789318290; c=relaxed/simple;
	bh=6qxJIjt5mhO1QhtG96ed1CuXfbczJHDTj2wshb0Pc/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=azYSoMBeZ6Y6x3Kysosxaa9OCbhGwXs1IEf6pcrp3n/13IqvXrMhIqI4/V1aJEyrN9ww0+1o4QD6KMN7OmJqYos0SN0BHR47p4eCVtv2NfrV5m/+tFBUkv5Mvqo7egctkLLxUQVjSMvUYmqbrSWB6isBpXW8G9brUFMVKMKQKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBlaK8a8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBlaK8a8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077151F000FF;
	Sun, 13 Sep 2026 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789318289;
	bh=nlAqW8CfpGUTNXKYDYABmbTZf1Fn9omyIE3OVsGSb0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DBlaK8a8i172wmmLvuQGc9KjYgf1aiG4mvAMEVIsDVqF/4+umnapkEOCknjXexbSE
	 PYF0XE8fqaDTiONLvjFQ2hnEx/LPQrVFyMAx4wqy/irhDTzqzrY0jQ82wfsKMf05GR
	 ZApN1JW4OWwl0aYOUNHXfaNrDxymWTWlN99jNoyMdz8xbza6WNNgoLzituA4HVadp0
	 8giwg3Uf15NuhqMIAuKwjpoCAKZFQ4zdsmR1aDVkkyR6q0tHuuM++R0vRKVaraOVje
	 4g/RLKuv22wJjoLAuNRaJ8pOeapF32S7f6Cxsnymj5sdrn6zN0ehziGwe1Yx2PMCb3
	 uMELCX3kkCcTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y v3 5/7] KVM: x86/mmu: pull call to
 drop_large_spte() into __link_shadow_page()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kenta Akagi" <k@mgml.me>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260913155523.7423-6-k@mgml.me>
References: <20260913155523.7423-1-k@mgml.me>
 <20260913155523.7423-6-k@mgml.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 16:51:28 +0000
Message-Id: <20260913165129.077151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added __link_shadow_page() function takes a `cache` param=
eter that is never used.
--

commit 2b06effbc767b0ad5b93300d41735b1910c14908
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()

This commit refactors the KVM MMU code by moving the call to drop_large_spt=
e()
into __link_shadow_page(). This avoids having the callers check whether the
parent points to a huge page before installing the child shadow page. It al=
so
modifies kvm_mmu_get_child_sp() to return an error instead of NULL to ensure
idempotency.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b7801690ea175..78c7e77bfdd0d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c

[ ... ]

> @@ -2269,13 +2262,21 @@ static void shadow_walk_next(struct kvm_shadow_wa=
lk_iterator *iterator)
>  	__shadow_walk_next(iterator, *iterator->sptep);
>  }
> =20
> -static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
> -			     struct kvm_mmu_page *sp)
> +static void __link_shadow_page(struct kvm_vcpu *vcpu,
> +			       struct kvm_mmu_memory_cache *cache, u64 *sptep,
> +			       struct kvm_mmu_page *sp)

[Severity: Low]
Is this parameter necessary? It seems the newly introduced cache parameter =
is
never actually used anywhere in the body of __link_shadow_page().

>  {
>  	u64 spte;
> =20
>  	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK !=3D PT_WRITABLE_MASK);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913155523.7423=
-1-k@mgml.me?part=3D5
