Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4352853FD
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404165; cv=none; b=WwCR4+sFY88wlJh0rdgNfvLZTA2nYoKHXocNjg5wqe49Ujn1HHDgA1POTvWsubeZqIaCNPUdn824KVII/vvSP8a8BIy/TySWZbrKlCuu8Ajfr08C8eGuxqT1cUI/gpH9CLJaPN7HSkSXzD05Bd4eqj5tspSjQtbCr9WtCdHeY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404165; c=relaxed/simple;
	bh=xLncj5/sqc9EFr9VR6uomCcPAl2akTMYp9MnWRwr6sw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cmxspN/vL3g+oxDqqzfZk2o0jBa/aHjo1X3Svo/Ebhmi4ca9B8pGwLLTXdNG3zCA72kPYQXdUoqei0/vmjLRor2MVldRKSu5r13eg1aKvZUAQyvCDKlC1fiBes26TvHTVrf3ylLSzkx4BbP/PWGV3xFLIzch19+ebOh2yJyWkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egya6Bf3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egya6Bf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4631F000E9;
	Thu, 30 Jul 2026 09:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785404164;
	bh=u4iPJkQeX4iyLkzhO3FJrwMCj/0c0X6xAcIWGua2BjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=egya6Bf38DJ7zpu4vgx6M46dz4lPzHzYGfwzKQq5OF4UHHw1JzCnzRmPwWzunwu3g
	 WnloVXkCmWuz2pN1PVEsPeU/pz0a2XREWhU6yt5EU0YydODqV98yWxJUYKpnXnz3WJ
	 xr6cMRrVP3MO7qintsrk5dPxnzwe+o91BApvMtb7a+3wwFIQVQuW06XAmTAiDH+kL2
	 VhVdz8QJlB5zhmyfTMtZ6lgosGvLLLW5Qu9lgswNIakvoilokaS5VBJl5NPw2jcuu2
	 QPDut4YsKUuNtv5MiOr9e1HNxeUiPdVZX7RZHSAsFoqQPP37yyxa6N49Yo7j8deYcE
	 +AyZ3FVeONejQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] RISC-V: KVM: Fix PMU event info array size overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guidong Han" <2045gemini@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260730091710.1366757-1-2045gemini@gmail.com>
References: <20260718153620.829378-1-2045gemini@gmail.com>
 <20260730091710.1366757-1-2045gemini@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 09:36:02 +0000
Message-Id: <20260730093603.BD4631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unbounded guest-controlled `num_events` allows arbitrarily large m=
emory allocations via `kvcalloc` and host soft lockups.
--

--- Patch [1]: [PATCH v2] RISC-V: KVM: Fix PMU event info array size overfl=
ow ---
commit 500aa03e09c05223e23f66e67acfa12d3e264362
Author: Guidong Han <2045gemini@gmail.com>

RISC-V: KVM: Fix PMU event info array size overflow

This commit fixes a slab out-of-bounds issue by storing the shared memory
size in a size_t and checking for multiplication overflow. It also switches
the allocation to use kvcalloc() with GFP_KERNEL_ACCOUNT and __GFP_NOWARN
to support large guest requests safely.

Link: https://lore.kernel.org/kvm/178345245327.72065.13249716450708539854@d=
igiscrypt.com/
Link: https://lore.kernel.org/kvm/20260718153620.829378-1-2045gemini@gmail.=
com/

> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 2025b664961c8..a7f948410d531 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
[ ... ]
> @@ -479,13 +481,14 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *=
vcpu, unsigned long saddr_low
>  				  unsigned long flags, struct kvm_vcpu_sbi_return *retdata)
>  {
>  	struct riscv_pmu_event_info *einfo =3D NULL;
> -	int shmem_size =3D num_events * sizeof(*einfo);
> +	size_t shmem_size;
>  	gpa_t shmem;
[ ... ]
> -	if (flags !=3D 0 || (saddr_low & (SZ_16 - 1) || num_events =3D=3D 0)) {
> +	if (flags !=3D 0 || (saddr_low & (SZ_16 - 1)) || num_events =3D=3D 0 ||
> +	    check_mul_overflow(num_events, sizeof(*einfo), &shmem_size)) {

[Severity: High]
Is there a missing upper bound check for num_events here?

While check_mul_overflow() prevents integer wrap-around, it still allows a
guest to pass extremely large values for num_events (e.g., hundreds of
millions) since size_t is 64-bit on RV64.

>  		ret =3D SBI_ERR_INVALID_PARAM;
>  		goto out;
>  	}
[ ... ]
> -	einfo =3D kzalloc(shmem_size, GFP_KERNEL);
> +	einfo =3D kvcalloc(num_events, sizeof(*einfo),
> +			 GFP_KERNEL_ACCOUNT | __GFP_NOWARN);

[Severity: High]
Can this unbounded allocation lead to host memory exhaustion?

Because the patch replaces kzalloc() with kvcalloc() without adding a
functional upper limit on num_events, an untrusted guest could force the
host to allocate and zero gigabytes of vmalloc memory. Even with
GFP_KERNEL_ACCOUNT, this could cause severe memory pressure or memcg OOMs.

>  	if (!einfo) {
>  		ret =3D SBI_ERR_FAILURE;
>  		goto out;
>  	}
[ ... ]
> -	for (int i =3D 0; i < num_events; i++) {
> +	for (unsigned long i =3D 0; i < num_events; i++) {
>  		eidx =3D einfo[i].event_idx;
>  		etype =3D kvm_pmu_get_perf_event_type(eidx);

[Severity: High]
If the guest backs the request with valid memory, could this loop cause a
host soft lockup?

This block iterates num_events times synchronously. For very large inputs,
this could execute millions of times without cond_resched(), monopolizing
the host CPU and causing RCU stalls. Should num_events be bounded to a sane
architectural maximum?

>  		econfig =3D kvm_pmu_get_perf_event_config(eidx, einfo[i].event_data);
>  		ret =3D riscv_pmu_get_event_info(etype, econfig, NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730091710.1366=
757-1-2045gemini@gmail.com?part=3D1
