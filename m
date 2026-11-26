Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674145;
	b=VxwkKnri4MXH5ucaxeLwfwo22vz/pS/cj/7agz/VLRXNaeXBp7MNUIdI+LCQZPnCQvBc
	 84DYT/R2GRjYN6sVoM+dVXb7rVkDYmOeEvFrDna3mti6J/J/FHHL8dFF8a3HHriO7dgrJ
	 hac7VB8rXqFs1BQI5aJ0kYTCb4b2zDDLaGe7MgOT1QQv5rSfTEM1U+XqDM9E/ncOGYlZN
	 XibPvZtNh//8VCX3UMRvHgkcyzdwtlvF1x2cRxxr9bJeduhijxr61RI3LQBlVPrCoImXA
	 EHCTfPcC/2/tLbIqZoi26o5QL3nsMNGv+M4HaiUleDGJbyLYND2xpR5tnUakzqo2N0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674145;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+DyfKkOm3WnV9cMeIKailQPLvo5c+61lU5Py2j5f+Kg=;
	b=S1yuYEgQji2Gg4MtRLf0znhaR+xSO7gt0d/cvW1GBrCy9FkmZBiFxkBW76HSGNCcZQSd
	 ts508HVYB8S4r+WOeHxKLzNE/pmw+u/EGfiCQbRnJyMB80FoU0yNJ7B7Kl15aYVPkcu1Q
	 zUND86+ASv00MY13DsxJoWl7RJ78xpV8sE+4QB3t3ZxzsagRopQVYuSHXyv4h6OBquZzA
	 ZpnGJ2F5XGtzkwLTV0v8ZbJYS+IYCnFyfbeP7YmLO9xE6x8YMc8OQD/m06mPAvdL/hP2X
	 jVYq40y9ZJmrifQ084JDv0JFQt4+TTSSyaV+a3emUi2Li5ulqqlfdcOBC8V7LaEioCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkfPzYTK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F1606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkfPzYTK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382F21F000D2;
	Thu, 26 Nov 2026 06:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674145;
	bh=+DyfKkOm3WnV9cMeIKailQPLvo5c+61lU5Py2j5f+Kg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NkfPzYTKmZ8dUc2DN6odXx/TDeAmXP+Pt1hqspznL5IV/QOjoxRbBkCLfU5OyvvqM
	 MY28Lay7Mr4fGrWkM10/LkvolZAS1SoVvOi6LEMBwzY6fyEYARy5Yq+C4/U5ccpsKP
	 U8Zs+yyQ5e+mMA23164otuZ15wK1JIQgZpDjuEQdsmUnvcutX70bsT/zbXZaREang8
	 It1qqo/i5PLzZT3TPGH5vHQsNATlv8SW9ztg7BjIbTFNYelrvON5+3o1759lRxilt4
	 ePgQpYBhNWHgg9MmhdQrAwsHS7jN1ccRYZLoqxglT4+B7GYiCstxO68UzaapJvOctr
	 HMu7FBGmPoPyg==
Message-ID: <sashiko-outbox-234836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261126060515.2198-2-sarunkod@amd.com>
References: <20261126060515.2198-1-sarunkod@amd.com>
 <20261126060515.2198-2-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:22:24 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] x86/uaccess: wrong fallback when CX16 is absent in
  unsafe_try_cmpxchg_user()
--

commit 41f10bc42b22924b13230c70050428ef6b8cacb9
Author: Sairaj Kodilkar <sarunkod@amd.com>

x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands

This commit adds 128-bit operand support to the user-space cmpxchg helpers
on x86-64 using cmpxchg16b, and stubs the 128-bit helper on 32-bit kernels
with BUILD_BUG_ON().

> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> index 3a0dd3c2b233e..15425af59de92 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h

[ ... ]

> @@ -580,6 +633,14 @@ extern void __try_cmpxchg_user_wrong_size(void);
>  	case 8:	__ret =3D __try_cmpxchg64_user_asm((__force u64 *)(_ptr), (_old=
p),\
>  						 (_nval), _label);		\
>  		break;								\
> +	case 16:								\
> +		if (boot_cpu_has(X86_FEATURE_CX16))				\
> +			__ret =3D __try_cmpxchg128_user_asm(			\
> +					(__force u128 *)(_ptr),			\
> +					(_oldp), (_nval), _label);		\
> +		else								\
> +			__ret =3D 0;						\
> +		break;								\

[Severity: Medium]
Should the !boot_cpu_has(X86_FEATURE_CX16) fallback jump to _label instead
of setting __ret =3D 0?

unsafe_try_cmpxchg_user() returns false (0) on a compare-and-exchange value
mismatch after updating *_oldp, and jumps to _label when the access faults:

arch/x86/include/asm/uaccess.h:__try_cmpxchg_user() {
	int __ret =3D -EFAULT;						\
	__uaccess_begin_nospec();					\
	__ret =3D !unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label);	\
_label:									\
	__uaccess_end();						\
	__ret;								\
}

Setting __ret =3D 0 leaves *_oldp unmodified and causes __try_cmpxchg_user()
to return 1 (value mismatch) instead of -EFAULT, so callers retrying on
mismatch can loop forever.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126060515.2198=
-2-sarunkod@amd.com?part=3D1
