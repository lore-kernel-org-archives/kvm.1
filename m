Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90F3939DA
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368335; cv=none; b=GoqYzaexrlnNYGH0OwJejfMzaBBEOfCc1m2gn1r77Al6JaYoPBu8fKAqTwjpi1jMcvhSob4A5OrzzrdYQZxeM5/gIJD1uCjHIfX8Ci396Jld2xM2L5+ugoDlNb6R2nvUezm6ru2ivbjChRGO3vTz3NhKd3AvV5tTJZKKlEWrfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368335; c=relaxed/simple;
	bh=JgozdXml0m51ghTfPkQn1GKMCQ1X6tI1UI+hIPBs+2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TyXyRTXhyoeFPJTu6NU3lRQiqC+bJrR7Qi3I+vBM42RRG+t40H5mZd4g0hoV/JAROs1jzt9bApF/msdfxLwT9MWS6jVa41CMKiz32kiXrxuIviDUXxk6+uR1q6U4/Cva2sPivFQq/CwQB1KHT3WveQeLZhO6vOPWaQK4FWRXqbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQwiHG/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQwiHG/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A79C1F000E9;
	Mon,  6 Jul 2026 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783368333;
	bh=15ipYWdE4oIVKqIBODOMQYGlb29BOwbUSdj5wyIadQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gQwiHG/K+SsIszF42VzhutLJZsAJkg+J3OKU/17HW6iQ9Tq+mx81XRM09wgObeJI9
	 ReRiSoYZh26o9fSyzCLmpY6TBoRGgFrq5T5BAkYbPtRoPDN/tB0daOPS3+eeiSp8Yr
	 DRYirrW7cdF5XKhbiC7TqHYECJSxWwOEDKX6onorZGR8/NXTwXEohLJlDcIZfONJyT
	 d1xRWMzp3INP2EjI5u3taDv3X2TzyJB7Ls6OKOy7iLb/2bs8EdV8b3f0+j4LDlL4YZ
	 phN3S6/SzpCc2ictpjwDodq+E6e/qCm30npCDoVp88wL17xKLsddqdZCG+4luFLj2B
	 MHgNsjYu44lyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] KVM: x86: Move supported EFER bits to kvm_caps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706195413.1966458-7-yosry@kernel.org>
References: <20260706195413.1966458-1-yosry@kernel.org>
 <20260706195413.1966458-7-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 20:05:33 +0000
Message-Id: <20260706200533.8A79C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Leftover function declarations for `kvm_enable_efer_bits()` and `kv=
m_disable_efer_bits()` in `arch/x86/kvm/msrs.h` after their definitions wer=
e removed.
--

commit eef68f2b444ee82f826a87d9dc12393124877c19
Author: Yosry Ahmed <yosry@kernel.org>

KVM: x86: Move supported EFER bits to kvm_caps

This commit moves the supported EFER bits into kvm_caps.supported_efer_bits=
=20
to allow them to be recomputed during vendor initialization. It also remove=
s=20
the kvm_enable_efer_bits() and kvm_disable_efer_bits() helpers in favor of=
=20
open-coding the updates directly to kvm_caps.

> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index 10669c5418da3..66fa7140d65d9 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
[ ... ]
> @@ -650,18 +647,6 @@ static int set_efer(struct kvm_vcpu *vcpu, struct ms=
r_data *msr_info)
>  	return 0;
>  }
> =20
> -void kvm_enable_efer_bits(u64 mask)
> -{
> -	efer_supported_bits |=3D mask;
> -}
> -EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_enable_efer_bits);
> -
> -void kvm_disable_efer_bits(u64 mask)
> -{
> -	efer_supported_bits &=3D ~mask;
> -}
> -EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_disable_efer_bits);
> -

[Severity: Low]
This isn't a bug, but did this commit leave dangling function declarations =
for
kvm_enable_efer_bits() and kvm_disable_efer_bits() in arch/x86/kvm/msrs.h?

It appears the prototypes were not removed from the header file when these
implementations were deleted here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706195413.1966=
458-1-yosry@kernel.org?part=3D6
