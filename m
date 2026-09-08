Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1B3AB289
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855569; cv=none; b=k0ZlgmsGN0FYJWQsC1MUqDsapUjCLWNkNhMKYQLv5JJvASGsOOWE5I1Io2M97xzTDi5f/SRI8plH7L2R1KoWbYFYf2tPy74s1nCQJw76po8Hl3+sk2kzTHD7JcvUO1HnVFs45lCvFg/KWKLWTjcQUTsCvUhAyA6vu1WXHZxqvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855569; c=relaxed/simple;
	bh=xCkRDYYfTpfIMlho18Se6JBKE6cX5oP1rBcWzlfn+Vc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U/z8kYHxxtkBG+eyI4dl4h6PKqU2pCMGLRj3/KAGWEi+o6hsvNYYh84ugsDgIe+LhDb37rhjMh2PTrk3cqRRssYSwpB4mekk6VWE5Gvgf3Vl3cv3cSQjDAqYkp3ce5wY/ZquHfYYw2ssKxt9DSBDqSkKqX3boikL3vTOBRmiIjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFbhR2cv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFbhR2cv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7D21F00A3A;
	Tue,  8 Sep 2026 08:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788855568;
	bh=1+N3heE8DTmi4tozTtf83ZbUtJop5WCpKUeUD93LBSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eFbhR2cvPcVFosR9ilTtPcikz1ipngAKxbu+A/xpGy9cqqY/lFKZF8xQGiK+nv1bP
	 psUp1Wwyk9GkTFhpjVmEwWEC01rgE5iIOWHzhutSmvj0esFWtaXt+oJ1q0fnMWvoP2
	 +ROU3VZCCQqUFLEA6DTt0zdE/Nv9j5hrp5flnFE/EjR1D5/7d6j/YMOREjHM3Lsu3N
	 Vkvo3GmD19dP5n7x7gxsBV2oFd0VaOZ+BUk1qo+ffaV8OYMVq9fjIbJHMksMhsUWVr
	 UG7yjmh8M0YtK2iRnCCnEuR9KqbrX+ZRJTrGp0zhxHThEZRIdPmfRXWichPlHUZjw4
	 cLgT8DtT4xQsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260908074739.10748-2-sarunkod@amd.com>
References: <20260908074739.10748-1-sarunkod@amd.com>
 <20260908074739.10748-2-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 08:19:27 +0000
Message-Id: <20260908081928.2D7D21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] When the host CPU lacks CX16 support, the 16-byte fallback returns=
 a mismatch without updating the old value pointer, violating the cmpxchg A=
PI contract and causing infinite retry loops.
--

commit 5f4dae7c1efaa8622accc402392f8d8a532481b4
Author: Sairaj Kodilkar <sarunkod@amd.com>

x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands

This commit extends the user CMPXCHG helpers to support 16-byte operands
on x86-64 using cmpxchg16b. KVM uses this to atomically emulate guest
cmpxchg16b on guest RAM mapped via userspace addresses.

> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
[ ... ]
> @@ -580,6 +634,14 @@ extern void __try_cmpxchg_user_wrong_size(void);
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

[Severity: High]
Does setting __ret to 0 here on hardware without CX16 support violate the
cmpxchg API contract?

When boot_cpu_has(X86_FEATURE_CX16) is false, it returns 0 (mismatch) but
fails to fetch the actual memory value and write it into _oldp.

If a guest executes cmpxchg16b on an MMIO address (forcing KVM emulation),
KVM's emulator decodes it and invokes unsafe_try_cmpxchg_user. Because
it returns 0 without updating the pointer, x86_emulate_insn skips
writeback_registers() and returns EMULATION_OK.=20

The guest registers remain unchanged while EFLAGS shows failure (ZF=3D0).

Can this cause a denial of service where the guest endlessly retries the
instruction with the same stale registers?

Should this instead use goto _label; to cleanly abort the unsupported
operation, which would cause KVM to properly abort the emulation?

> +		break;								\
>  	default: __try_cmpxchg_user_wrong_size();				\
>  	}									\
>  	__ret;						})

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908074739.1074=
8-1-sarunkod@amd.com?part=3D1
