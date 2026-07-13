Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDD35A387
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941087; cv=none; b=Xi+fKmi2MUMs49m+7p4jtklqvOTQO0SjoOHnW5o1oQQI7rHftaMYxcKh29in5LyvoNmIEMU0QCVAgzhjflSLYUzwEl65MVCpmakjs1P9IWsErTQQiGXVK5frCGknzG2VezAWRf+0uAAO4goEvajZUlEoXQilFDBa37EUOLtwR80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941087; c=relaxed/simple;
	bh=AAAq49daWj5vylRq2cH57u/q0vI6DUl2FwL4XOqf2aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kcn6caEbUMTsW89ZDKn9hOI5mH7vS4wsNBXoZ0uTumPWAycKPg/qWLR3T4UQ1V8VRWw8L/g9BLmfLFUUnFCu9PGqmEAx27DnzbdZE0LnLhm8Gxaq2HeCAdridwACkS8u8jtu4o8l63t6DtfOLYNzjMdThU5MwHDvoYMXoEUurUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5RU/MyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5RU/MyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC2F1F000E9;
	Mon, 13 Jul 2026 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783941085;
	bh=eC8FYZ9lBrqwbNVLOE6u8Ur6t3oevgrvUcRut7dNPxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5RU/MyY3tfI9L1doL1QLpkBjVgyZp4uRIFcWGJ7v6EgljFLX2lIbxAc/fBMkFpZo
	 +aHWeZKa2GiS73Y0sTaLrE30Uyg8aa4sbWwx9Pq9Vd8zpSW5oCDdCsFFMvKKvLCBNV
	 08izRzuU3aOq5VedULbG4OXu+2gMsyZzDIgf29SuLfinfXikReOP+JS5m2Ooqo0yyR
	 YmP4khowIVZiv9qPOWmM+Zajw9aI/Duva6MKqPUy/LtWk9tHzH4b4I29ADk/L8XGNZ
	 rKqXK3w+6zYt4HS2eyRjsxa9LUKVWlYVJ64JxpXII22C+t7LCpaT30WWlH+Nj2HNqu
	 TTVcHle3lMT9g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 6/6] iommu/amd: Provide kernel command line
 option to enable GAPPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713105033.15405-7-sarunkod@amd.com>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <20260713105033.15405-7-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 11:11:25 +0000
Message-Id: <20260713111125.9DC2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Unconditional enablement of GA log on overflow in kexec/kdump =
environments with GAPPI leads to critical DMA memory corruption.

Pre-existing issues:
- [High] Lockless read-modify-write of the IOMMU MMIO control register caus=
es a race condition that can permanently disable IOMMU interrupts or GAPPI.
--

--- Patch [6]: [RFC PATCH v3 6/6] iommu/amd: Provide kernel command line op=
tion to enable GAPPI ---
commit 38ebc4ddc54202efd2ae74234b7ee4169af3e39a
Author: Sairaj Kodilkar <sarunkod@amd.com>

iommu/amd: Provide kernel command line option to enable GAPPI

This commit adds a kernel parameter to enable GAPPI for AMD IOMMUs when
the GAPPISup extended feature bit is set. It also modifies initialization
code to handle GAPPI alongside the existing GALOG feature.

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 2e1889f8a9e42..7d2b1c24f6ecc 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c

[ ... ]

> @@ -2999,6 +3002,13 @@ static void enable_iommus_vapic(void)
>  	struct amd_iommu *iommu;
> =20
>  	for_each_iommu(iommu) {
> +		/*
> +		 * Disable GAPPI, do not check amd_iommu_gappi as it may be
> +		 * false in new kexec kernel even though previous kernel has
> +		 * enabled it.
> +		 */
> +		iommu_feature_disable(iommu, CONTROL_GAPPI_EN);

[Severity: High]
This is a pre-existing issue, but does this unlocked modification of the
IOMMU MMIO control register cause a race condition that could disable
interrupts or other features?

The iommu_feature_disable() function performs a read-modify-write without
holding iommu->lock:

drivers/iommu/amd/init.c:iommu_feature_set() {
    ctrl =3D readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
    ctrl &=3D ~((u64)mask << shift);
    ctrl |=3D ((u64)val << shift) & ((u64)mask << shift);
    writeq(ctrl, iommu->mmio_base +  MMIO_CONTROL_OFFSET);
}

During initialization, the IRQ thread could be running concurrently. If a l=
og
overflow occurs, the IRQ thread calls amd_iommu_restart_log() which also
invokes iommu_feature_disable().

Since this read-modify-write isn't synchronized, could concurrent
modifications silently overwrite each other?

> +
>  		/*
>  		 * Disable GALog if already running. It could have been enabled

[ ... ]

> @@ -3038,10 +3048,19 @@ static void enable_iommus_vapic(void)
>  		return;
>  	}
> =20
> +	if (amd_iommu_gappi &&
> +	    !(check_feature(FEATURE_GAPPI) &&
> +	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
> +		pr_warn("GAPPI is not supported.\n");
> +		amd_iommu_gappi =3D false;
> +	}
> +
>  	/* Enabling GAM and SNPAVIC support */
>  	for_each_iommu(iommu) {
> -		if (iommu_init_ga_log(iommu) ||
> -		    iommu_ga_log_enable(iommu))
> +		if (amd_iommu_gappi)
> +			iommu_feature_enable(iommu, CONTROL_GAPPI_EN);
> +		else if (iommu_init_ga_log(iommu) ||
> +			 iommu_ga_log_enable(iommu))
>  			return;
> =20

[Severity: Critical]
If the system is booted into a kdump kernel with GAPPI enabled, could this
lead to the IOMMU writing to stale physical memory from the previous kernel?

When GAPPI is used, iommu_init_ga_log() is skipped, meaning the ga_log buff=
er
is not allocated. However, if the previous kernel crashed with a pending GA
log overflow, the hardware's overflow status bit remains set.

Once shared IOMMU interrupts are enabled, the pending overflow status trigg=
ers
the interrupt thread:

drivers/iommu/amd/iommu.c:amd_iommu_int_thread_galog() {
    amd_iommu_handle_irq(data, "GA", MMIO_STATUS_GALOG_INT_MASK,
                         MMIO_STATUS_GALOG_OVERFLOW_MASK,
                         iommu_poll_ga_log, amd_iommu_restart_ga_log);
}

This calls amd_iommu_restart_ga_log() which unconditionally enables
CONTROL_GALOG_EN:

drivers/iommu/amd/init.c:amd_iommu_restart_ga_log() {
    amd_iommu_restart_log(iommu, "GA", CONTROL_GAINT_EN,
                          CONTROL_GALOG_EN, MMIO_STATUS_GALOG_RUN_MASK,
                          MMIO_STATUS_GALOG_OVERFLOW_MASK);
}

Since CONTROL_GALOG_EN is re-enabled without checking if GAPPI is active or
if the log memory was allocated, will the IOMMU resume writing GA log
entries to the uninitialized physical address left by the crashed kernel?

>  		iommu_feature_enable(iommu, CONTROL_GAM_EN);
>  		if (amd_iommu_snp_en)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713105033.1540=
5-1-sarunkod@amd.com?part=3D6
