Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36929D27D
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059381; cv=none; b=gp4pcOTQHy2ahl0We9H7Os8W8h9oeqg2EFeXmN4jPl12oWpjWDAjMCbtwOpHmwUam5/uG5uvLDEUHPansRgCJ0aiBdQeKoTI2ywV1lAh59Nj5yk7R0Q4MB0PUgqmn2t+MJ6hbwfn+rvRfrHsW9/IVunQHwBoFP37n+gmU5yPXQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059381; c=relaxed/simple;
	bh=IOG34nzflhK0XjHtua4YKiZ+rgR5+RqdgEcM4NniZ9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sDMkVtRRIQG+Dd/JieplbKRsHc6lf5O/T1GbFJyhtjLXJd1wvnX8T9q498UebJcnjgNT/KgEoZgY2zpAu9EBmzy0L40JL29S1IziF+PtjZVG/aSZ+HJZmr84wFldpwLm1NoI6xfvYB67CZ766dEs2Y1nslJ98qHhukSK5KhNgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNGKQegh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNGKQegh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127C21F00893;
	Wed, 10 Jun 2026 02:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781059380;
	bh=TP+VLUmedhrMsuY/Grr3xxSDO/tU10ugNYq+c0vJw+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bNGKQeghLn9ajCkBoB/NNe9sISZkubkyGLw9GFJy/UWwVDE8h+gUq4kvajH+Pdhvl
	 9kzs4dMqu++DGuxH4jWxoyjc+gznkJ5/zLB3wbFtM83uzTqPSkWFr80a168TXL3x2a
	 ADbbaF3cJJp88DANNGR/N1QBrr/fuyvcdZqNYh52B7Tg1/WgrYCoq6daB7UAxkrLxM
	 afGYE81Oha5V1hBo01YoP3JheOoh7kviMpfWXZwWN0wBPYsBoyoq0DpYjHzw+FiY8o
	 9o5tjbkB10PmJt0xARFg8s9m2+eIZWwLG219YfGAHcsiucrkooCb28Vrjsqr2tXKLf
	 DYX+3+HHg4zJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID
 feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ewan Hai-oc" <ewanhai-oc@zhaoxin.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260610023512.3690734-3-ewanhai-oc@zhaoxin.com>
References: <20260610023512.3690734-3-ewanhai-oc@zhaoxin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 02:42:59 +0000
Message-Id: <20260610024300.127C21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing synchronization of tools/arch/x86/include/asm/cpufeatures.h
--

commit 10214672b5ae87640bf83fed59682da6721698f8
Author: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>

KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature

This commit advertises the Zhaoxin CCS (Chinese Cryptography Standard)
feature to guests via CPUID 0xC0000001 EDX bits 4 and 5. It adds the
associated feature flags to the cpufeatures header and exposes them
in KVM CPUID initialization.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 20b33413189c2..276e4ef90bd07 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -140,6 +140,8 @@
>  #define X86_FEATURE_SM2_EN		( 5*32+ 1) /* "sm2_en" SM2 enabled */
>  #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
>  #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
> +#define X86_FEATURE_CCS			( 5*32+ 4) /* "ccs" SM3 + SM4 instructions */
> +#define X86_FEATURE_CCS_EN		( 5*32+ 5) /* "ccs_en" CCS enabled */

[Severity: Low]
Does this change also need to be synchronized to the tools tree copy at
tools/arch/x86/include/asm/cpufeatures.h?=20

Updating the main header without updating the tools copy usually triggers a
warning about differing kernel ABI headers during the compilation of tools
like perf or objtool. Is this omission a minor regression for the tools
build process?

>  #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
>  #define X86_FEATURE_XCRYPT_EN		( 5*32+ 7) /* "ace_en" on-CPU crypto enab=
led */
>  #define X86_FEATURE_ACE2		( 5*32+ 8) /* "ace2" Advanced Cryptography Eng=
ine v2 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610023512.3690=
734-1-ewanhai-oc@zhaoxin.com?part=3D2
