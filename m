Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834231F938
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 05:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779944602; cv=none; b=Dcex0ZRoV8Ylpciuydi7NLIMgJtODMEBHz/pG84JA0hBkEC1wle8KuVYBYWxEVRE8SAX4m3bdahU8Gm8zw4vL48UZibLTJYjmR06SdD8nCCwySiaahwYtA5RZx60JDgiKGffQmx9eiVAUaywspLd1oBD1SBHi8Lm4/F/foX1Mkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779944602; c=relaxed/simple;
	bh=rDQOxxxSBx1DSW2b6HbCu4OKCaBO5K35yqDlaOATt6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fH04eS+nCZs4uEQHKttTJY4+rUnuaIn8VnEvL2r+b7F4WTafGewdNXuPQGXYKzc3QcXiR8XymPBr9MJLrHv6Hdh1+ElXkinat2WsK6VvlA0tlqZbAyHfXQKMUzpbv6TaC8vasPr07dwvcQYATFIyI4X9ByUeV1FjYC0Fq0UKkG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzNwEzo6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzNwEzo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD3A1F000E9;
	Thu, 28 May 2026 05:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779944601;
	bh=EHOVr1wPshRCZx8z5C3nKjsUMIyxufovc/8SKG6WjPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WzNwEzo6ZvfD0EgUcgAkqpLG0APml+PqXIlLcaWFbN6H9zchqvbUvb66yCrozq/tt
	 bIexsermU+yH6a1dYIOSFDZqn6vSQ4FpDPC76X8SUFNHc+pBADHwOlFKnh/uXZOkQn
	 R9qkMiw9egLiVZ8C7HvIJHhXUF2wqXRNWV0/7cmq2AvegD7oKfAbOzLnUPaOg5kd/Z
	 6gw+ZIhurkdyw6ZsjWGGeZ3ry2u9Uqdxm9MuVDbML8AGYNh/Dc4ppW6aeEiVeRTptH
	 hgdOdtwawhpkqvqhDyCQDyOtVoobhv3KyfYogE2H3HDvgoF0sskonw9lr8RTGkIHSY
	 /GSJ2yNgXwbtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] KVM: x86: Expose Zhaoxin RSA CPUID feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ewan Hai" <ewandevelop@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528032234.1322565-6-ewandevelop@gmail.com>
References: <20260528032234.1322565-6-ewandevelop@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 05:03:20 +0000
Message-Id: <20260528050321.0DD3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Exposing the RSA big-number arithmetic engine to untrusted guests =
creates a severe local denial-of-service vulnerability (Instruction Time Do=
S).
- [Low] The newly added X86_FEATURE_RSA and X86_FEATURE_RSA_EN flags were n=
ot synchronized to the tools/ directory.
--

commit 39b1d23089ffb8d188fc17bb71d4da69fbf1ff4a
Author: Ewan Hai <ewandevelop@gmail.com>

KVM: x86: Expose Zhaoxin RSA CPUID feature

This patch advertises the Zhaoxin big-number arithmetic engine to guests
by exposing the RSA and RSA_EN CPUID feature flags. It allows guests to
use REP XMODEXP and REP MONTMUL2 instructions for accelerating public-key
operations.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 3702d7a30ae61..a769c83588f7c 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -154,6 +154,8 @@
>  #define X86_FEATURE_RNG2_EN		( 5*32+23) /* "rng2_en" RNG2 enabled */
>  #define X86_FEATURE_PHE2		( 5*32+25) /* "phe2" PadLock Hash Engine v2 */
>  #define X86_FEATURE_PHE2_EN		( 5*32+26) /* "phe2_en" PHE2 enabled */
> +#define X86_FEATURE_RSA			( 5*32+27) /* "rsa" Big-number arithmetic */
> +#define X86_FEATURE_RSA_EN		( 5*32+28) /* "rsa_en" RSA enabled */

[Severity: Low]
Should these new flags also be synchronized to
tools/arch/x86/include/asm/cpufeatures.h?=20

It looks like check-tools-headers might warn during the build if the tools
header isn't kept in sync with the main cpufeatures.h additions.

[ ... ]

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 3fb81f7a61076..94ea9abae566d 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1290,6 +1290,8 @@ void kvm_initialize_cpu_caps(void)
>  		F(RNG2_EN),
>  		F(PHE2),
>  		F(PHE2_EN),
> +		F(RSA),
> +		F(RSA_EN),

[Severity: High]
Does exposing these instructions to untrusted guests risk a denial of
service?

Since REP XMODEXP and REP MONTMUL2 are unprivileged and support operands up
to 32768 bits, can a guest user-space application force the physical CPU co=
re
into a prolonged computation?

If the hardware doesn't efficiently yield to external host interrupts during
these massive operations, it seems like this could stall the host, delaying
interrupts and VM-exits, potentially triggering host RCU stalls or watchdog
lockups.

>  	);
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528032234.1322=
565-1-ewandevelop@gmail.com?part=3D5
