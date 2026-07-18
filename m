Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F53DC4AF
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784389771; cv=none; b=WSqBQnwrTdAMa0OxUnuKuJf6Mggk6a9w5xxg/pH4FIQX0HDWMtwm9cVFxmXC81Az8ExvxZ06YpeAYkZwiEvklAvxR7moHECn+JFDodjMs0A5zGmeJrUIB261PhI9rdU6li3cI7szDb+2+Hrog++FnwpbUE6sGBHKzTB92jNVEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784389771; c=relaxed/simple;
	bh=AgXQk3SEm2KH8Z9qYeyUx5D+piG7gfBN5Zrjn5ZHED8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B8EhY1qGF9APla/QllK+Ih4ncziqSxX8iUQON1FCGgxYqxThJFeaa+xUa6WrMlG+Tnj5jKZUenrJD4gSwR11rubE91Our5HR75OcPU4hpCJb+PdlmynSXNMIPA/BxGnRaUw4rTGV9bK3XeQMlZauw7tk2cqfuwnxTTt3QZUf9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxOoF3R1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxOoF3R1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891C81F000E9;
	Sat, 18 Jul 2026 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784389754;
	bh=fYirwCa7qSdaFZxW1t3kUPBsmP7k95Nlyo6NEcBwZf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GxOoF3R1deUf2UkpT0qXJWpHElhQTQS2yZEGhcVAw77za1A979Mm6D8JuIsmVnItR
	 jPztrLNBUgpwKRsM9w9d7XE8cRsBrE8hCUu97F7kso/aKK+Fu8R7QEOaYud7jnABMc
	 If/XUzxVvb7CMGjpCIL2STo+EJEfcOqFfJ+7f7Qj8hPvyS9HHNXFAMEm7YyGBqi7sV
	 KGJSB0/nCnDH5C/ovc4XGoZQL52hgDR6oppIYVjq1t7JFHQTEwDE+VC8eqeRyJ/59W
	 ve9SjmsLEJzs0MXhNsfg0J4nDe7OKnCYs3ZsHMz1LTm+TXJwshW1tj0zg1cEMsszyK
	 GSLle+hTKy5NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Fix PMU event info array size overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guidong Han" <2045gemini@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260718153620.829378-1-2045gemini@gmail.com>
References: <20260718153620.829378-1-2045gemini@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 15:49:14 +0000
Message-Id: <20260718154914.891C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest-controlled large allocation lacks __GFP_NOWARN and __GFP_ACC=
OUNT, allowing host log spam and memcg limit bypass.
--

--- Patch [1]: [PATCH] RISC-V: KVM: Fix PMU event info array size overflow =
---
commit f0a5b0643b60a1981804276ca1f91780cd681469
Author: Guidong Han <2045gemini@gmail.com>

RISC-V: KVM: Fix PMU event info array size overflow

The patch prevents an integer overflow when calculating shmem_size from
guest-controlled num_events in the SBI PMU EVENT_GET_INFO handler. It
introduces check_mul_overflow and rejects sizes beyond KMALLOC_MAX_SIZE.

> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index bb46dcbfb24da..8b489fc3051f4 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c

[ ... ]

> @@ -479,16 +481,21 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *=
vcpu, unsigned long saddr_low
>  				  unsigned long flags, struct kvm_vcpu_sbi_return *retdata)
>  {
>  	struct riscv_pmu_event_info *einfo =3D NULL;
> -	int shmem_size =3D num_events * sizeof(*einfo);
> +	size_t shmem_size;
>  	gpa_t shmem;
>  	u32 eidx, etype;
>  	u64 econfig;
>  	int ret;
> =20
> -	if (flags !=3D 0 || (saddr_low & (SZ_16 - 1) || num_events =3D=3D 0)) {
> +	if (flags !=3D 0 || (saddr_low & (SZ_16 - 1)) || num_events =3D=3D 0 ||
> +	    check_mul_overflow(num_events, sizeof(*einfo), &shmem_size)) {
>  		ret =3D SBI_ERR_INVALID_PARAM;
>  		goto out;
>  	}
> +	if (shmem_size > KMALLOC_MAX_SIZE) {
> +		ret =3D SBI_ERR_FAILURE;
> +		goto out;
> +	}

[Severity: High]
This is a pre-existing issue, but is it safe to allow a guest-controlled
allocation up to KMALLOC_MAX_SIZE using kzalloc() without __GFP_ACCOUNT
and __GFP_NOWARN?

Later in kvm_riscv_vcpu_pmu_event_info(), the code does:

	einfo =3D kzalloc(shmem_size, GFP_KERNEL);

Since the allocation uses GFP_KERNEL without __GFP_ACCOUNT, this memory is
not charged to the guest's memory cgroup. Could an untrusted guest coordina=
te
concurrent SBI_EXT_PMU_EVENT_GET_INFO hypercalls across multiple vCPUs to
temporarily hoard host memory, potentially causing a host OOM?

Additionally, without __GFP_NOWARN, won't allocation failures for these
high-order pages on a fragmented system generate rate-limited page
allocation failure stack traces, causing host log spam?

Since these allocations can be large and are guest-driven, would it be bett=
er
to use kvcalloc() with GFP_KERNEL_ACCOUNT | __GFP_NOWARN so it falls back to
vmalloc() if physical memory is fragmented?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718153620.8293=
78-1-2045gemini@gmail.com?part=3D1
