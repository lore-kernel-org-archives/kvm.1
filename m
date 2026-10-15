Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5482EEE66
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027718; cv=none; b=ILikN1HR4LP5cMCZLmGBibru3cPVdLEFofDB07ZYCUN8Oyqel+tsSkjN694el6rFjhXmPMvOFn2QaL4zPjk8o9vIcaCDfSPaTuBDtFXYbFIcyXdR2jCPPqIvsy7/VduWCr/Y4ECIdoiB/AmdkM9TpbtM3bR2rgkq/0Lccjr9yXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027718; c=relaxed/simple;
	bh=stlb4D+El4INLKUZWC7mXSw1FnhmJMZpuMrbBjk6p0c=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=jUIZLgqbbJGMg/AUhwCNjrP6xW+R1uP04vtIhrBc1toZSFi8NjISS9oP0Kfqfa5KdlvWV/WneXtXZsLjZS8RzoEbD9MQHZXMK8FIrYlxfRI76/1FB5eAHCLwns519q92vovcB81+uwsgUmBhF8s8pSbp9p1avFkmKieQlzpEGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3pT3nwp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3pT3nwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9A31F000C4;
	Thu, 15 Oct 2026 01:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792027716;
	bh=zFmkTi1YxdLhydC/wLEEKQ2vETrYhkGWr07eS8TH57Y=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=N3pT3nwppud2xgUDLQ1JgHAWqnztOeQkrPaRkbMdSxFWVL4O8WS5V0vIDPjSrMJ5S
	 uY1pHBIop8os9nCVfJkVLLtKf2xhqn6fjyVd2u6oIznEFEw0OGrzJEq0dRw+wJRLVI
	 m//U+FxUNWYUXTXMkyJeIooYjsb5kLPEBg5gxGgRf5IlnZzrdD2loctRWjsIF6z84W
	 zT5f62fsbNvIVLw07y5klW2zyXbPCjXGrkKrOMFVuyIEK+2ALz7NhcQFcjOSvO3GTP
	 mbybjM+Hp62ypt39WQQ44t9Wcd97K8NlyDAXKkzhppoiNVM0Njf+nPNNthwtF7s4Fr
	 yIvzbSFwbLIEw==
Message-ID: <sashiko-outbox-172091@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lu Baolu" <baolu.lu@linux.intel.com>, kvm@vger.kernel.org
In-Reply-To: <20261015010705.1973284-2-baolu.lu@linux.intel.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 01:28:35 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/virt/tdx: missing clflush on IOMMU parameter pages
--

commit ea38aa1a74969b72895a018349277b8a5b88cfb3
Author: Lu Baolu <baolu.lu@linux.intel.com>

x86/virt/tdx: Add SEAMCALL wrappers for IOMMU setup/clear

This commit adds SEAMCALL wrappers for TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR.
These functions transition an IOMMU into and out of Secure TDX Mode to
provide the trusted foundation required before enabling TEE-IO security
protocols.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 1b9ff749dd8e0..5d31c1b0890ae 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c

[ ... ]

> @@ -2034,3 +2034,59 @@ void tdx_sys_disable(void)
>  	if (ret && (ret & TDX_SW_ERROR) !=3D TDX_SW_ERROR)
>  		pr_err("TDH.SYS.DISABLE failed: 0x%016llx\n", ret);
>  }
> +
> +/*
> + * Wrapper for TDH.IOMMU.SETUP leaf, which transitions the IOMMU and rel=
ated
> + * I/O stack into Secure TDX Mode.
> + *
> + * The @root page format is defined by the TDX Connect ABI spec (Table 3=
.35,
> + * Structure of IOMMU_MT Parameter): the first two entries describe the =
size
> + * and HPA (Host Physical Address) of the two contiguous buffers for the
> + * invalidation queue; the remaining entries provide HPAs of
> + * IOMMU_MT_PAGES_COUNT metadata pages. IOMMU_MT_PAGES_COUNT is obtained=
 from
> + * trusted IOMMU global metadata.
> + */
> +u64 tdh_iommu_setup(u64 reg_base, void *root, u64 *tdx_iommu_id)
> +{
> +	struct tdx_module_args args =3D {
> +		.rcx =3D reg_base,
> +		.rdx =3D __pa(root),
> +	};

[Severity: High]
Does the root page need to be flushed from the CPU cache before being passed
to the TDX module?

The TDX module accesses memory using physical addresses. If CPU-cached,
unflushed memory pages are passed to the module during trusted DMA
initialization, it can lead to cache paradoxes and machine checks,
potentially causing host kernel panics.

Other TDX page-adding wrappers typically ensure pages are flushed. While the
caller is responsible for populating the parameter page, the caller introdu=
ced
in the follow-up patch (tdx_iommu_setup in iommu.c) allocates and populates
the metadata pages but does not appear to perform a cache flush either.

Should tdh_iommu_setup() perform the flush, or does the caller need to be
updated to handle it?

> +	u64 ret;
> +
> +	/*
> +	 * Don't loop forever:
> +	 *
> +	 *  - TDX_INTERRUPTED_RESUMABLE guarantees forward progress between
> +	 *    calls.
> +	 *  - On TDX_INTERRUPTED_RESUMABLE, all registers except RAX remain
> +	 *    unchanged.
> +	 */

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015010705.1973=
284-1-baolu.lu@linux.intel.com?part=3D1
