Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E123F7AA8
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405196; cv=none; b=cs+OddpZySIy0qKjD8wamOKKKN6XzulHxVb2KqszOnwqvF1GKJH7SQgip1CsURmqq9lpq48otxGOG05ABFZVH073aUlOliR3QZhgd0JOo4HPd3+L1LS8iM5wgNO60hGqXehiSAQWLMeCp7qb8N86gCQRn8hfNaCwHJ8BsckhNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405196; c=relaxed/simple;
	bh=9KFNaA3MC8RpzJsGw1RJn9Gk0VY+315+GdfY+qT3lsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bYVmNU2vbnUi8tg9O4o6sfc7d7QxB8PpKJZHkPvWvHMOfPURIps8WMNqKTTUEBVorLJbc2NFPrWcxgYIwFQXbnCEeexzj0SGXXkFZwHsLFPsdCYv6H/vvbPcquBaoIEFsJRAhl2N9eo2JH/NTbVREz+trjbuMi6dZ4dHYB2uKO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaupYgbJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaupYgbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417241F000E9;
	Thu, 30 Jul 2026 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785405194;
	bh=h8HtxsdgCVKVNnpT6iFlBDd0Jpzr/LNLLDWIsiuIopk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eaupYgbJQEY3lKqo+6BcUAv9fMjIyyGR2IMrVUk32srBpZtjCgY2mFOHkdZCM4IQa
	 COcFepjDZbUm2wf5wC35wsuTSDqZFAuy6Uc+RwAg+xdZ30j/97hkfED/ybLxc3YQ62
	 SVmQ5prVG0RT0pmk+FbQYwLazFtV5xYW8zEoV4M11fpusP3GT0gLzZ+2Wb9BRv/qXr
	 llgT90aqgDDE279Z2FRDn+Ff9HbdgNEUXcqKK0hG1HJfcdWSFrURbY679u5TL1Civs
	 JeOxKgpeefC7QUzUiGk5OhsZ+AOAqPb7Wp4Y8ZnmZ3E0Dd0nnz0mKAfLYwsCeW7ZNw
	 8XUObQVxZzTPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 RESEND] RISC-V: KVM: Fix PMU event info array size
 overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guidong Han" <2045gemini@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260730092533.1369531-1-2045gemini@gmail.com>
References: <20260730092533.1369531-1-2045gemini@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 09:53:13 +0000
Message-Id: <20260730095314.417241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unbounded memory allocation and long execution loop due to unvalid=
ated guest-controlled `num_events`.
--

--- Patch [1]: [PATCH v2 RESEND] RISC-V: KVM: Fix PMU event info array size=
 overflow ---
commit bdf470babff9670998ba5d0cae1674a0cc0b80b2
Author: Guidong Han <2045gemini@gmail.com>

RISC-V: KVM: Fix PMU event info array size overflow

This commit addresses an integer overflow in the SBI PMU event info array
allocation. It switches the allocation to kvcalloc with GFP_KERNEL_ACCOUNT
and uses size_t and unsigned long variables to match the guest-provided
size without truncation.

Closes: https://lore.kernel.org/kvm/178345245327.72065.13249716450708539854=
@digiscrypt.com/

> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 2025b664961c8..a7f948410d531 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -479,13 +481,14 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *=
vcpu, unsigned long saddr_low
[ ... ]
> -	if (flags !=3D 0 || (saddr_low & (SZ_16 - 1) || num_events =3D=3D 0)) {
> +	if (flags !=3D 0 || (saddr_low & (SZ_16 - 1)) || num_events =3D=3D 0 ||
> +	    check_mul_overflow(num_events, sizeof(*einfo), &shmem_size)) {
>  		ret =3D SBI_ERR_INVALID_PARAM;
>  		goto out;
>  	}
[ ... ]
> -	einfo =3D kzalloc(shmem_size, GFP_KERNEL);
> +	einfo =3D kvcalloc(num_events, sizeof(*einfo),
> +			 GFP_KERNEL_ACCOUNT | __GFP_NOWARN);

[Severity: High]
Can this introduce an unbounded memory allocation regression based on a
guest-controlled num_events?

While check_mul_overflow() prevents integer overflow during the calculation,
there doesn't appear to be a check capping num_events to a reasonable
architectural maximum. A guest passing an extremely large value could cause
kvcalloc() to attempt an allocation approaching the host's total RAM, which
could lead to severe host memory thrashing or direct reclaim.

[ ... ]
> -	for (int i =3D 0; i < num_events; i++) {
> +	for (unsigned long i =3D 0; i < num_events; i++) {
>  		eidx =3D einfo[i].event_idx;
>  		etype =3D kvm_pmu_get_perf_event_type(eidx);

[Severity: High]
Could this loop iteration trigger a regression resulting in host soft
lockups or RCU stalls?

If a massive allocation from the earlier kvcalloc() succeeds, this loop
will iterate num_events times synchronously without yielding. This could
allow an untrusted guest to monopolize the host CPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730092533.1369=
531-1-2045gemini@gmail.com?part=3D1
