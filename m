Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6C379C53
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503647; cv=none; b=ENE57tqknSdAz4Dx544dUYQd0KInAULWG1pWEGeq6vcq3NUzk7D8EQq/yMFZR18Zr7GL0V4DhTyuAbMhCTbH1QMI1EnY77Hp/zaCd67sMqGhaBTendsdf/yB8dAS21liO+hU5aqxKp0gB0sbZQjXDW7Mxv097Rk2KGhbKDOicTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503647; c=relaxed/simple;
	bh=iv6TnW0oboqQhwxqBsHu9WrQx9HKHErRvTnVDvAL/qE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cVcNxkuu1lt7LmVY4gUjseKW5O9GfjlInWScj4bzMVwL9xEtBu7jS2M3cPmkK2F+Xsk5gA3AbEAjFfV4SzMTr+Zsi8BEm/q6OdCn+9WprMft+CoPAN5Anxr8s4LhzFjMx2TwiOF3iRJWCQd7Y3AqJ7VMsXQBxYelJB1N840SxQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5RfuNkw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5RfuNkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D851F000E9;
	Wed,  8 Jul 2026 09:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783503646;
	bh=K1fbee/fdWtB/pqQh/quyoI5Tu+2RkAbKmWhWPaVkLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c5RfuNkwMjiOWL4AQz83E3OqQxK/Uv/fGDXR9HLIPXl6K+BNppUE9h16iUSzCK10N
	 M26vPq7GeyuUHWuX9vbQtVcf1j6GX2cMTh14jSCnpZPlzPyLOkTX29jmREBOp3YSaV
	 /nhpqV4o9MH/Rh19OxytAVdxRneNDmXc6Uj1RnIJnbSyg6/JNAdOMgyUX47+0yKmSv
	 lqXGLWRhfl5S+jm07QHjS0kZevg7lfjnhNWuf0GpadgibbuqXupUDtPqWvdZNO9Der
	 qtZhb4RLnI2BzGiuC+2GdGV325D8sSLoL9eqrVs/D/1cpfIQsQVAj+laNFycmQyo7C
	 xQ9udhT+7g+nw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 5/5] iommu/amd: Provide kernel command line
 option to enable GAPPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260708091408.12106-6-sarunkod@amd.com>
References: <20260708091408.12106-1-sarunkod@amd.com>
 <20260708091408.12106-6-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:40:45 +0000
Message-Id: <20260708094045.E1D851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Global state `amd_iommu_gappi` remains incorrectly `true` when VAP=
IC is unsupported or disabled by SNP, causing KVM state corruption.

Pre-existing issues:
- [High] Memory leak and sleeping in atomic context during system resume on=
 the GALog fallback path.
- [High] Resource leak and inconsistent VAPIC state if GALog initialization=
 fails on a secondary IOMMU.
--

--- Patch [5]: [RFC PATCH v2 5/5] iommu/amd: Provide kernel command line op=
tion to enable GAPPI ---
commit eb6466c0ce487095bfa19ee53f280dedc6c60d0f
Author: Sairaj Kodilkar <sarunkod@amd.com>

iommu/amd: Provide kernel command line option to enable GAPPI

This commit adds a new kernel command line parameter amd_iommu=3Dgappi. It
allows enabling the GAPPI feature if the corresponding extended feature bit
is set in the hardware. It modifies the IOMMU initialization sequence to
configure GAPPI when enabled.

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index e2da6d5a63c78..a1dd2e8840d6c 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c

[ ... ]

> @@ -3016,10 +3025,19 @@ static void enable_iommus_vapic(void)
>  		return;
>  	}
> =20
> +	if (amd_iommu_gappi &&
> +	    !(check_feature(FEATURE_GAPPI) &&
> +	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
> +		pr_warn("GAPPI is not supported.\n");
> +		amd_iommu_gappi =3D false;
> +	}

[Severity: High]
Does this leave amd_iommu_gappi erroneously set to true if an early return
is taken?

If the kernel is booted with amd_iommu=3Dgappi, the variable is initially
true. In enable_iommus_vapic(), if an early return is taken before reaching
this validation check (for instance, when check_feature(FEATURE_GAM_VAPIC)
returns false, or if forced to disable due to SNP), the function exits
without resetting amd_iommu_gappi to false.

Because the variable remains true, exported subsystems like KVM AVIC might
incorrectly assume hardware GAPPI is active and attempt to use it, which
could lead to state corruption or missed interrupts.

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

[Severity: High]
This is a pre-existing issue, but does this early return leave the VAPIC
configuration in an inconsistent state if it fails on a secondary IOMMU?

In enable_iommus_vapic(), if iommu_init_ga_log() or iommu_ga_log_enable()
fails for any IOMMU after the first one, the function returns immediately.
This leaves the global kernel state assuming VAPIC is active, but some
IOMMUs are left unconfigured. It also skips reverting amd_iommu_guest_ir
or cleaning up resources for the previously configured IOMMUs.

[Severity: High]
This isn't a bug introduced by this patch, but can calling
iommu_init_ga_log() here cause a memory leak and a sleeping in atomic
context issue during system resume?

During system resume, syscore_ops.resume runs with local interrupts
disabled. amd_iommu_resume() calls amd_iommu_enable_interrupts(), which
invokes enable_iommus_vapic().

On the GALog fallback path, it unconditionally calls iommu_init_ga_log().
This function then allocates memory using GFP_KERNEL:

drivers/iommu/amd/init.c:iommu_init_ga_log() {
    ...
    iommu->ga_log =3D iommu_alloc_pages_node_sz(nid, GFP_KERNEL, GA_LOG_SIZ=
E);
    ...
}

Using GFP_KERNEL in atomic context triggers a sleeping in atomic context
bug. In addition, the existing ga_log pointers are overwritten without
being freed, which leaks the previous allocations on every resume cycle.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708091408.1210=
6-1-sarunkod@amd.com?part=3D5
