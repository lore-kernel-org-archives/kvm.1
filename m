Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0132C1A6814
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863530; cv=none; b=qIbOFA5yZwV80FkzF4r1DjoB68jo5dXKhzXL23rhQB0INljmCDMAFIcj3YkyX72LMWkOFZzKYXS2HwqxaaCweBhWb6ll6dkcqkHwlhbPaYipI2FLO/qZz7dxIM1symydlXxRmiUh74U/fBEQvbtYQIs/gSDbnsHp7F4NYdowwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863530; c=relaxed/simple;
	bh=ymmcoLErqdhW6aGxtJG+Gdrb8wDmErN9VUsy1J3XDRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jmL8hXPj5x3TgMCX7467bANEGH+ZnTJBPTiXn+s8aib3Gp2SxkLxLh+fz9grasKGmRTfMAQvni/uEfk7b89lT5AtbG48jB++R7H/F14SJWclUkqxmm3Yth7oEbKalL91/wmm8EARspM1hmtD59aBwsA2EHYnDY4lb9aOpXXiuW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2V7adGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2V7adGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEBD1F000E9;
	Tue, 30 Jun 2026 23:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863528;
	bh=Oz/IELJTuzHAkCqAoKnZwgxhlCANKOUJuH/XYtZzOSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y2V7adGBn1FIgCRJ5VA1TrZhT8jA0Wgg9YC6vM9xiz9DikjOsDEWHssr07cBRNmrn
	 j6Ax9H2dEIs+RCrN4w/6S+/xOvbRuUPlrmvVmHMdkcEZM9icqvflHSBp//lDMjIDWq
	 xMKfNEFp0BgenE0WYUgOf6C+bllHRWCaKxf7XIfX/1T0B/jDlDUd1g7y5lWwno4wrp
	 pL1ptLJ5/2ZSj3qxC5KzOqXHYxlbGa1FSQEeVSNDIWy6E7Zv98IsLLpHW3UwCJyKRS
	 va0Bigl1vYrxMQ903jR9KBD+N6QMtwkyVyXFgUB5J26cxpr8ZFqPzAWkhShBWqIdRA
	 kjO92R+LTIbGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] KVM: x86: Reverse the polarity of
 efer_reserved_bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260630234716.3039031-6-yosry@kernel.org>
References: <20260630234716.3039031-1-yosry@kernel.org>
 <20260630234716.3039031-6-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 23:52:07 +0000
Message-Id: <20260630235208.0FEBD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect bitwise logic in EFER validation rejects valid zero valu=
es (breaking guest boot) and allows guests to set reserved bits (triggering=
 VMENTRY failures).
--

commit 4bd740e43933efd5aaca18b2bd83e1696dbbd7dd
Author: Yosry Ahmed <yosry@kernel.org>

KVM: x86: Reverse the polarity of efer_reserved_bits

This commit reverses the polarity of the EFER validation variable, renaming
efer_reserved_bits to efer_supported_bits to align with other fields in
kvm_caps. The stated intent is that no functional change is introduced.

> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index 17d4c813a9e8a..b9a16a27f6c23 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c

[ ... ]

> @@ -606,7 +606,7 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u=
64 efer)
>  }
>  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
>  {
> -	if (efer & efer_reserved_bits)
> +	if (!(efer & efer_supported_bits))

[Severity: High]
Does this bitwise logic inadvertently reject valid zero values and allow
guests to set reserved bits?

If a guest writes 0 to the EFER MSR, (efer & efer_supported_bits) evaluates
to 0, and the negation makes this condition true, improperly rejecting it.

Additionally, if a guest writes an EFER value containing both a supported
bit and a reserved bit, the condition evaluates to false, allowing the
reserved bit to be set.=20

Should this check instead be (efer & ~efer_supported_bits)?

>  		return false;
> =20
>  	return __kvm_valid_efer(vcpu, efer);
> @@ -619,7 +619,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr=
_data *msr_info)
>  	u64 efer =3D msr_info->data;
>  	int r;
> =20
> -	if (efer & efer_reserved_bits)
> +	if (!(efer & efer_supported_bits))

[Severity: High]
As with kvm_valid_efer() above, does this logic incorrectly reject a valid
clearing of EFER and accept invalid reserved bits if at least one supported
bit is also present?

>  		return 1;
> =20
>  	if (!msr_info->host_initiated) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630234716.3039=
031-1-yosry@kernel.org?part=3D5
