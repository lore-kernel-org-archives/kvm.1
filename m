Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A62BDC05
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864019; cv=none; b=qaqi5lq5MfX7bruyiz1WF/QUrjk+4iodQXnUJ17m6x2LsKRr61y0TZYWhvwx32jH9tRg87339pEJNVEppgNgsQPAllvvYBPzak4G7C+YJp5D/xLkbJecxz3oxKAV4KepbfO7VhuW0KdSBpELWPbiJ5MN4EPH36o29oM5hKXDL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864019; c=relaxed/simple;
	bh=iD78M1ckzupZQifTHiFUVcHVWZ64IXLGKFgBXL3zZH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dupFdmnz0cMoyXU82QONv81WpxfnSIh3hzRobVk1EFrJ5RfpIQ1jSQZAoWShK01XUpv1vw1vqqJyzBcsqK597ZdUMBpNGmShP5Vbrf2i9YYsZuK32xzEH3GzOAy3ZEq1GnYrVPvK6ltvapKvnhsjuZL9VDm7oojVtD5sDwzRvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS+qCige; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS+qCige"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C891F00A3A;
	Wed,  1 Jul 2026 00:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782864018;
	bh=cgXBHBGQShF/LUIqeaj4MCqpQg480kQPrEFUojOkhLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nS+qCigeqH9XjMeCqyv4AA512bHrfRkx55L72WGG6pYPXPVZfvVTeklBCr3GA9U96
	 pCUQ0eqyCJsfsmdLG7/3YULW74SsoZIypuhpEvunjH7sTFkCnTutLv7dIiaKNhg1e4
	 8LQEVospSWI1rXQMgAdFLuS1J57Yuv6BgijbFhQcIeRW+XPK8cG7AARCfHhYsPtlcd
	 7tsDF73ohb5mQRmPLU1M5GMmJ99z8iCQVjaLzMe6hG1uZHxeGlkFTSERkTzApGJEGW
	 PHZnmHMfEThGWHIGZCUmO24H5pUfW/sfrdt8kApQk/fsmrXGSdg+j/rRmtLE0Jv4xo
	 FEGY+AAYOao1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] KVM: x86: Move supported EFER bits to kvm_caps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260630234716.3039031-7-yosry@kernel.org>
References: <20260630234716.3039031-1-yosry@kernel.org>
 <20260630234716.3039031-7-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 00:00:17 +0000
Message-Id: <20260701000018.00C891F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect bitwise logic in EFER validation rejects valid EFER=3D0 =
and allows setting reserved EFER bits.
--

commit 2ebe510bc1d7884420361ec9d7613318508f1d94
Author: Yosry Ahmed <yosry@kernel.org>

KVM: x86: Move supported EFER bits to kvm_caps

This commit moves efer_supported_bits into kvm_caps as supported_efer_bits
for consistency, allowing it to be recomputed during vendor initialization.
It removes helper functions for enabling or disabling specific bits, choosi=
ng
to open-code updates directly to the new bitmask.

> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -606,7 +603,7 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u=
64 efer)
>  }
>  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
>  {
> -	if (!(efer & efer_supported_bits))
> +	if (!(efer & kvm_caps.supported_efer_bits))

[Severity: High]
Does this bitwise logic incorrectly reject an efer value of 0?

If userspace or a guest completely clears efer (e.g., setting it to 0 when
returning to real mode), efer & kvm_caps.supported_efer_bits evaluates to 0,
making the ! condition true. This would reject the valid state.

Additionally, does this allow writing unsupported reserved bits? If a guest
sets a supported bit alongside arbitrary reserved bits (e.g.,
EFER_SCE | BIT_ULL(63)), the bitwise AND yields a non-zero value, meaning
this check passes.

Since __kvm_valid_efer() only validates specific feature bits and ignores
unknown bits, could these reserved bits be written directly to vCPU hardware
state?

>  		return false;
> =20
>  	return __kvm_valid_efer(vcpu, efer);
> @@ -619,7 +616,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr=
_data *msr_info)
>  	u64 efer =3D msr_info->data;
>  	int r;
> =20
> -	if (!(efer & efer_supported_bits))
> +	if (!(efer & kvm_caps.supported_efer_bits))

[Severity: High]
Does this identically flawed check also block the guest from clearing its e=
fer
via wrmsr, and allow writing reserved bits directly to hardware?

Should this check be if (efer & ~kvm_caps.supported_efer_bits) instead to
correctly verify that no unsupported bits are set?

>  		return 1;
> =20
>  	if (!msr_info->host_initiated) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630234716.3039=
031-1-yosry@kernel.org?part=3D6
