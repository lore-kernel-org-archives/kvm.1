Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C54949E7
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320738; cv=none; b=QqwEXtT6wmHF1NS4NaoEVyfqMUToZ4m93SLYzxrAD0wsUmK/eWk9vmEbEAk1NcYjecP4pGpZz/YNntcDBmLFolmc4WSFZltl4/R34wHS0BfMetrHbtZj5W7nGk8S85jEUSaru33TEarGXncv2dztjON0RHJUSAW8nR5rNlSECqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320738; c=relaxed/simple;
	bh=8gw14F8mw691RX2t9+9JgTzk3wrZzRYdDpkXeeKEAXo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z1IafTcPze6YEr4BEO82y3NkzCTpmAwlaRDBjg5+FUNWzYZoSgVlfoBbRHBkhXj6LqYe3ypIcrR52XuJ4KDUsvTklE9l2IvbvnLTeZnZXCHiEjT9McfOs+PoA6aFxruLgmSYemvIgnMI5VcoYk5Stc8no05mzaRJWGYclNM04GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeBqRPCo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeBqRPCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD741F000E9;
	Mon,  6 Jul 2026 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783320733;
	bh=cq7XcALMbNROdscBahABlPPzJ3u46Kt7rwDfKQyg7pA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NeBqRPCooc0/+Q6RW8iINQcfuzWJ7Y7nOHRKlVlUlD1lpl9R0zOE9sviQ+pH1P1/E
	 qQuoWS9cS6A0xey983jQUJembwV8b/m51LiYknY+jyOK5Eue6gRja1ULZjBvydlBov
	 ZL91JTZkHSyS65xAA0F3ScVqcjdTcVoPfdWWIUZmpVED5JZX5M7nBL7qWIFkb4aMmx
	 cyhU3AVQtwRfSQLezRDpJVAJM1HxYjbZ/b+tCjYB22IJcp+Dv6b1IXDD7rX/f2U9h+
	 yDTSH3RhQR3+F+GjfdhgYNxcWp/uoT9ZSCe8qGLobBB/24t0TQEEUfuLED2ygy/x1q
	 XXENHC1KkY38w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706063035.1139-2-sarunkod@amd.com>
References: <20260706063035.1139-1-sarunkod@amd.com>
 <20260706063035.1139-2-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 06:52:12 +0000
Message-Id: <20260706065212.CCD741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The 32-bit stub for `__try_cmpxchg128_user_asm` incorrectly eval=
uates to 1 (success) instead of 0 (failure), silently skipping emulation wh=
ile falsely signaling a successful memory update.
--

commit 11b4c82317b376374b32df0435151f876d6239e5
Author: Sairaj Kodilkar <sarunkod@amd.com>

x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands

This commit extends the user CMPXCHG helpers to support 16-byte operands
on x86-64 using the cmpxchg16b instruction. It also adds a 32-bit stub
that is intended to always return failure since cmpxchg16b requires
64-bit GPRs.

> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> index 367297b188c39..123755d471099 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h

[ ... ]

> @@ -551,11 +594,18 @@ do {										\
> =20
>  extern void __try_cmpxchg_user_wrong_size(void);
> =20
> -#ifndef CONFIG_X86_32
> +#ifdef CONFIG_X86_32
> +/* Always fail on 32 bit arch as it do not support 128 cmpxchg (i.e. cmp=
xchg16b
> + * instruction).
> + */
> +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) (1)

[Severity: Medium]
Does this 32-bit stub correctly signal failure?

Since this macro evaluates to 1, won't the surrounding unsafe_try_cmpxchg_u=
ser
macro treat this as success (true) rather than failure (false)?

This could cause the wrapper to negate the value and return 0 (success) to =
the
caller, falsely signaling a successful memory exchange without actually
updating memory or the old value. Even though there are no current 32-bit
callers using a 16-byte operand, should this evaluate to 0 instead of 1 to
ensure theoretical future callers don't encounter a silent atomicity break?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706063035.1139=
-1-sarunkod@amd.com?part=3D1
