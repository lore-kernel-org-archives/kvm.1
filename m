Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41C1E8342
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772582; cv=none; b=DLP1uUT5qXpngC13gPcLCCRxdOEuIVBmr+x1gspYIa2/9Retc8V6AM65NsAuVTQo0ZnMQpskMnOrg92VLVRUwzr6Ndotxpz6D21IgC378H6ndsJNZ9qMytn7WTLfq4/YzIDa1ogAr/5tlD9oDm5qnpMGrMQ4mTAvAEyQidly/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772582; c=relaxed/simple;
	bh=VQG/MqIVYAsj6qJ2i0mJabklkyu7PoYfHaZyqtx83ls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XKdrNh+rbiEImH53GKffqAeLp8TlTGcerq271VdHjB7VWE+LdkyHBarubF8ISqmbbBR0W4XsYCNSnFPiSpoN/D/KtT9TrfMtAWkaRFfWK8dI+kKEsDrWfOmuOIsPH4XHv/1G2bgA5WszgtmzTdpukwi6xf5nnd7BCM6LV0oyO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZT/4Oeu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZT/4Oeu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48821F000E9;
	Thu, 18 Jun 2026 08:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781772580;
	bh=NNPnEreAdCopFKIraOSnf41rCM9VI2OKm6ROlSjgh/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZT/4Oeuxg9J7FqtbjH0mQXQVN+5tNxN2IvrljOsS2v8/vk9Y5XFsyjTLVk1F8Gje
	 JZYjiA3rIBCpY/2CIdTD1g1otDg5UyocCw+pl81R5tTyun0hwdohMqPtvtm0Zeo0/D
	 xumMRIXQA/r7FYhrxxd0AuZeEw1ST1R/z6bcxRTv6BWXwFnoKBLIABOQIdMDmD2r2O
	 /MPMdyu60gfgUGCy6wTfSg0HV+Cr2g+oajM2Z5ZYi6D3R/zmRabf5M8oiy7yeeooRu
	 67A8gd0xpfFfJWa2l35GJHNm/CdudNHkh5Qry1+UWVDaURtazf+jrdOrEME/5mLwh4
	 HZQHL4dUBDjXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/17] x86/virt/tdx: Add interface to generate a
 Quote
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yilun" <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618081355.3253581-12-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-12-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:49:40 +0000
Message-Id: <20260618084940.C48821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tdx_quote_generate() uses an uninterruptible mutex lock for a gues=
t-triggered hardware operation, creating a potential host-level denial of s=
ervice.
--

commit 3bb73b03a2480c47534841c05b531b06bda047a9
Author: Peter Fang <peter.fang@intel.com>

x86/virt/tdx: Add interface to generate a Quote

This commit provides an interface to generate a Quote via the TDH.QUOTE.GET
Extension-SEAMCALL. It introduces a global mutex to serialize access to a
shared quote buffer.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c

[ ... ]

> +void *tdx_quote_generate(struct tdx_td *td, void *in_data, u32 in_data_l=
en,
> +			 u32 *quote_len)
> +{
> +	struct tdx_quote_data *qdata =3D &tdx_quote;
> +	void *quote_dup =3D NULL;
> +	u64 r, out_len;
> +
> +	if (!tdx_quote_enabled())
> +		return NULL;
> +
> +	mutex_lock(&tdx_quote_lock);

[Severity: High]
Since this path can be triggered by a guest, could using an uninterruptible
mutex_lock() here lead to a host-level denial of service?

If a guest rapidly requests quotes from multiple vCPUs, it could monopolize
the global tdx_quote_lock. Other vCPU threads waiting for the lock would
block in an uninterruptible sleep (D state). If an administrator attempts
to kill the waiting VMs, the threads will not respond to fatal signals until
they acquire the lock.

Would it be safer to use mutex_lock_killable() here to allow fatal signals
to interrupt the wait and permit VM teardown?

> +
> +	/*
> +	 * Use the first page of the quote buffer for input data. The buffer
> +	 * must be at least one page in size. @in_data may not be page-aligned,
> +	 * but TDH.QUOTE.GET expects page-aligned addresses.
> +	 */
> +	memcpy(qdata->buf, in_data, in_data_len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618081355.3253=
581-1-yilun.xu@linux.intel.com?part=3D11
