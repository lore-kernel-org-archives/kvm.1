Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99520322B6D
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453696; cv=none; b=YvIzBZoqHJuXDcEHIrB0hHP+iRtN24lI4nl9FL+DI9dYDKnq5VuyoVoWrnUwI2duwGpS3oYP9vtZngQ3+8s5RHD2xhyF6ML4QXpUWT+XIgUs0Da3SsW+772GFgU2leOj0Ey0sg7zIlrlfcK30Vf+sME8fxIJ70/LwaksE73APZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453696; c=relaxed/simple;
	bh=jKH9HLE/pmOMbul3+uuRtysEiT1nguALp4gpKu58NuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sKAgl5I71JwQ9sbBqR84nxlE4cgx9dqyVIHIOKHvumVwFW+WF4S63LBLRhdg61LdUh6QX5naxZn0GpSuw6daEDchN7FVPzVOpw4eNmTAn+sK8sp1JwQMlFuVW5toGFTwMNczQ/p0RUDAUWvakvX++SJGPwwU/uMZH1XDV67T1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1s3Ydbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1s3Ydbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E6B1F000E9;
	Tue,  7 Jul 2026 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783453695;
	bh=v211NiT1FlpTjNjsZ0eG74iVxbktloWhOlUNRWCrxpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1s3YdbxG0CpHmHNV6IFP7VV2+DITbM3UlwRA7sdKpuvfcPDaspXM50EO1vFtjy0S
	 DzNY17RKUHUv9ZnZ53duqsz/lJEM6gyLunGldBmxyROYBO//qKmMgANet+jXnaqCPO
	 6m7auEFabmxOhpkAZVelx0rDZ27KB6L+ynhKcA8BA004o1/BR0Syci3cjIF2F3AmgS
	 I8swEMwTYruG4OwqpMuY9i5c/VH4M+tfqeF+io1q6R8fnFmrgdjSFReuVdLM6vKpqN
	 uFBnig/VgdWXYn1E5tmRb0a7aPsBZQtxCK8m2iYiG9k0xvwt6ZYZL5MQ5DGpgPtG+X
	 FC4pKshwq0flA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Fix heap overflow in SBI PMU event info
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naveed Khan" <naveed@digiscrypt.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <178345245327.72065.13249716450708539854@digiscrypt.com>
References: <178345245327.72065.13249716450708539854@digiscrypt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 19:48:14 +0000
Message-Id: <20260707194814.D0E6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An unbounded, guest-controlled `num_events` parameter translates i=
nto a large memory allocation, triggering a `WARN_ON_ONCE` in the host's pa=
ge allocator.
--

--- Patch [1]: [PATCH] RISC-V: KVM: Fix heap overflow in SBI PMU event info=
 handler ---
commit 59f34c484dfc616073369a4a2f4ea4eb32bc7ab5
Author: Naveed Khan <naveed@digiscrypt.com>

RISC-V: KVM: Fix heap overflow in SBI PMU event info handler

This commit fixes a heap out-of-bounds read and write by using size_mul()
to calculate the shared memory size, saturating to SIZE_MAX on overflow
so the allocation fails safely.

> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index bb46dcbfb24da..ff940fa74b55d 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c

[ ... ]

> @@ -479,7 +480,7 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vc=
pu, unsigned long saddr_low
>  				  unsigned long flags, struct kvm_vcpu_sbi_return *retdata)
>  {
>  	struct riscv_pmu_event_info *einfo =3D NULL;
> -	int shmem_size =3D num_events * sizeof(*einfo);
> +	size_t shmem_size =3D size_mul(num_events, sizeof(*einfo));

[Severity: High]
This is a pre-existing issue, but does this allocation still allow a guest
to trigger a host warning?

Because num_events comes directly from the guest without an upper bound, a
malicious guest can provide an extremely large value. While size_mul() now
safely saturates to SIZE_MAX and prevents the loop mismatch, this massive
size is subsequently passed to kzalloc():

arch/riscv/kvm/vcpu_pmu.c:kvm_riscv_vcpu_pmu_event_info() {
    ...
    einfo =3D kzalloc(shmem_size, GFP_KERNEL);
    ...
}

Since GFP_KERNEL lacks the __GFP_NOWARN flag, passing a size that evaluates
to an order larger than MAX_PAGE_ORDER will trigger a WARN_ON_ONCE in the
host's page allocator.

If panic_on_warn is enabled on the host, this results in a guest-triggerable
host denial of service. Should this allocation include __GFP_NOWARN, or
should num_events be explicitly bounded before the allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178345245327.72065.=
13249716450708539854@digiscrypt.com?part=3D1
