Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E0439F62
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164877; cv=none; b=HZE+YZGJL6af8ss9ymN9H6iIwYQMdBQE+JjtPIr8/KNUtL4GcsTkH6KdsT3d4/iQzknYLzHQ01k0r+9GF+Xy6488rkVJ8GCb8ZUsHulbkYrvnA+2xbNjx++si0Yu+shMY74syw/WITU5GCts8TWCskvK7vufwRcRhDiu39aRMdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164877; c=relaxed/simple;
	bh=mwW23+BzBDe+67yBdFyL5lAUIK/XQnEZQtkrKHgZMwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=svAU3YpF2Wl3LFVUP72Qh/fVWi1Ib5GwG/Nz2iqxUvf33Fyshdk7eMgSU9A0jgB3gl29tsA1hDvz1n6ixx2FW3t2RyL17LlZYzIRRLvVccYWOgVVdVUJZXx8ydmO0XyVJ7Y7RWj+Be0iSOC3kiyYReN+bsirTjXc8QkweUpE/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIKxlqDM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIKxlqDM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B500B1F000FF;
	Fri, 11 Sep 2026 22:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164868;
	bh=mRs5i/rebltySkSYK0btbiVJSGXf5n3O0jUplJ8o5Dw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bIKxlqDMoUzyYgeGfdg2P9rPaKXy2/RrCd8xgnPQkcK0RLvarQxlM9m+64Qas8rq3
	 aYZCkQbuupP5yEJIF1bI8f+eX2eusL1xErkQncMMlxB1+VeDz652Q4YjRABgoAEsQY
	 F20418tmVfo+FKMwIZm1p+0eBv+6sNt1s5H8i3Y2ZMmTg4xpY85gpZITZiVMPvwnUo
	 Lct2oCJnmKwzBOrPUWOsxeCWrvDi5TyJw4T5mIqh8erSIhCZbi6tcm4qLi1ZEJkETF
	 Nxj6fY+frQajkrAr1Vqa5o7MaGlAXgZjOCko+OFXJtFkfox+b2XYslp2ozT+abjEJS
	 C4iymo6gghymw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 15/28] KVM: x86: Include CR4.FRED in the emulator
 CR4 write mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-16-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-16-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:14:28 +0000
Message-Id: <20260911221428.B500B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `mk_cr4_64` erroneously attempts to preserve the upper bits of C=
R4, contradicting x86 architecture and breaking future higher-order CR4 bit=
s.
--

commit 3026fdc333b24532424b51db68dd9e65b0a1065c
Author: Xin Li <xin@zytor.com>

KVM: x86: Include CR4.FRED in the emulator CR4 write mask

This commit updates the emulator's CR4 write mask to accommodate the FRED
enablement bit, expanding CR4 support to use its higher 32 bits when the
feature is present.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -5552,11 +5552,17 @@ static int emulator_set_dr(struct x86_emulate_ctx=
t *ctxt, int dr,
>  	return kvm_set_dr(emul_to_vcpu(ctxt), dr, value);
>  }
> =20
> -static u64 mk_cr_64(u64 curr_cr, u32 new_val)
> +static u64 mk_cr0_64(u64 curr_cr, u32 new_val)
>  {
>  	return (curr_cr & ~((1ULL << 32) - 1)) | new_val;
>  }
> =20
> +static u64 mk_cr4_64(struct kvm_vcpu *vcpu, u64 curr_cr, u64 new_val)
> +{
> +	u32 shift =3D guest_cpu_cap_has(vcpu, X86_FEATURE_FRED) ? 33 : 32;
> +	return (curr_cr & ~((1ULL << shift) - 1)) | new_val;
> +}

[Severity: Medium]
Does this bitwise logic incorrectly preserve the upper bits of CR4?

The x86 architecture specifies that a 64-bit MOV to CR4 overwrites the enti=
re
register, and a 32-bit MOV to CR4 clears the upper 32 bits. The val passed
into emulator_set_cr() already contains the correct architectural value
(zero-extended if 32-bit, or the full 64-bit value).

By preserving bits above the shift boundary, this could prevent a guest from
clearing future higher-order CR4 bits once they are set. Since the bitwise
AND mask will preserve the 1 from curr_cr and OR it with the new value, tho=
se
upper bits would remain permanently set if they were already present.

Could emulator_set_cr() simply pass val directly to kvm_set_cr4() without
attempting to merge it with the current CR4 value?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D15
