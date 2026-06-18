Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E3330D3B
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773392; cv=none; b=uzAR0ff52h1CKqHxLC1ur3d/5VQcRGdWf6JLSEdFL1i2DitW2/DCrfprtk0UbpjuLsRuVeReOc8cePKFaBtC1HcDJIcDv6OFYqefTi/pK3pwfIQ6yFVcL2s/n3SOxNFkjhhRwEr2m7Eqi9r6F+t5Uk4G70MRliNLZcytSQCh+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773392; c=relaxed/simple;
	bh=sLNs9XeuShk4QNWVe7mEqJOaUGTr1oOsgtHdaEHSe8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AI2WFD/5ZKMD4iBOwpNzQL+jW6g2+GywALsM48qDsjSsuGSTix6W81Xe6cuy1hOYu+IO1zfoxLu7rspU+E8tfuhqJixkvJns2qZ2uvemXfSTv58ms1R6j/UKT9oXJxgpzRbYMi7syVLAWt6aFBkKxfxeIJ6Mfx2SsYcoZ9HZHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZjEU9rH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZjEU9rH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E9B1F000E9;
	Thu, 18 Jun 2026 09:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781773390;
	bh=kjR6qt6DjOBCS100w//aIRqZs7A2shazwstL05K3IdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZjEU9rH5f2rpwRQAbpm0znT+2xt7Ipnp5KUMe1MT5W3LCDGuNAwKCIPCqxVOqUw7
	 vmQgrHhydu3DTcjgnmTmm5xbW5uC4XHl7qsouK85s3Z2wiKFCbRYpgTHlTmmc28LUi
	 dK6SrmNSV4LD1035bmlIIS216Km2rXI2lzL4ji+waqfGXzI8Au22RhSTyQ/RNLiGrE
	 iBSd6BCJfotOoVAU4ZA1d3GSBEU6UzgRtziN7W47BFonoaB7elSM1hiQvtPU9X1dAN
	 a63+vDvqlUp4BDOMTcvCbVf7RTrTAvcDMvgXCXs+wKvKnGVFWSr/0eaPMCsoGWTrbA
	 U4vhd32LznV7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yilun" <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618081355.3253581-17-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-17-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 09:03:09 +0000
Message-Id: <20260618090310.43E9B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM incorrectly returns a hypercall error (TDVMCALL_STATUS_INVALID=
_OPERAND) when in-kernel quote generation gracefully fails.
- [High] KVM fails to write the required buffer size back to the guest when=
 the provided GetQuote buffer is too small.
--

commit 482cde6e1c4a3f88b17ca20d55ddbc439d933981
Author: Peter Fang <peter.fang@intel.com>

KVM: TDX: Add in-kernel Quote generation

Provide an in-kernel path for Quote generation when handling
TDG.VP.VMCALL<GetQuote>, without requiring an exit to userspace.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 9f7c39e0d4b59..20558b0185b63 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c

[ ... ]

> +static u64 get_quote_kernel(struct kvm_vcpu *vcpu, struct tdx_quote_req =
*req,
> +			    gpa_t req_gpa, size_t total_len)
> +{

[ ... ]

> +	/* Caller owns the requested quote */
> +	void *quote_data __free(kvfree) =3D
> +		tdx_quote_generate(td, req->data, req->in_len, &req->out_len);
> +
> +	if (!quote_data)
> +		return TDX_QUOTE_STATUS_UNAVAILABLE;
> +
> +	if ((size_t)req->out_len + TDX_QUOTE_REQ_HDR_SIZE > total_len)
> +		return TDX_QUOTE_STATUS_ERROR;

[Severity: High]
If the guest-provided buffer is too small, does this early return skip
writing the required size back to the guest?

When tdx_quote_generate() fails due to an insufficient buffer, it populates
req->out_len with the required size. By returning TDX_QUOTE_STATUS_ERROR
immediately here, it seems we bypass the logic that writes req->out_len back
to the guest.

Will this break a guest's ability to dynamically probe the required quote s=
ize
and retry if its initial allocation is too small?

> +
> +	if (!write_quote_to_guest(vcpu, quote_data, req->out_len, req_gpa))
> +		return TDX_QUOTE_STATUS_ERROR;
> +
> +	return TDX_QUOTE_STATUS_SUCCESS;
> +}

[ ... ]

> +static int tdx_get_quote_kernel(struct kvm_vcpu *vcpu, u64 gpa, u64 size)
> +{
> +	void *first_page =3D NULL;
> +	u64 err, qerr;
> +
> +	err =3D tdx_get_quote_check_args(vcpu, gpa, size);
> +	if (err !=3D TDVMCALL_STATUS_SUCCESS)
> +		goto out;
> +
> +	err =3D TDVMCALL_STATUS_INVALID_OPERAND;

[ ... ]

> +	qerr =3D get_quote_kernel(vcpu, first_page, (gpa_t)gpa, size);
> +
> +	if (write_quote_status_to_guest(vcpu, qerr, (gpa_t)gpa) &&
> +	    qerr =3D=3D TDX_QUOTE_STATUS_SUCCESS)
> +		err =3D TDVMCALL_STATUS_SUCCESS;

[Severity: High]
Should the hypercall return SUCCESS even if the quote generation itself
failed gracefully?

If get_quote_kernel() encounters a quote service error (like
TDX_QUOTE_STATUS_UNAVAILABLE), this condition prevents err from being updat=
ed
to TDVMCALL_STATUS_SUCCESS. As a result, the hypercall returns the
initialized value TDVMCALL_STATUS_INVALID_OPERAND in R10.

Since the hypercall arguments were structurally valid and we successfully
wrote the error status into the shared memory buffer, shouldn't the hyperca=
ll
return SUCCESS to let the guest parse the actual quote status?

> +
> +out:
> +	kfree(first_page);
> +	tdvmcall_set_return_code(vcpu, err);
> +
> +	return 1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618081355.3253=
581-1-yilun.xu@linux.intel.com?part=3D16
