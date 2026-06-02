Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E43546F7;
	Tue,  2 Jun 2026 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442882; cv=none; b=N79kKet2bxKHN5I7ltXiZvfojATuIl9uK2/gzUrsNZ4eA5w7MwxTXRYrENHBREPpGRZCMq4g3krZwxUNHAdj+A/RJ/G592pGvppaYexqX9FL6m4SlyUiXU/reJxiQRJMwp/X5T+uNDAUWxQCIo3Bi8GDdaXasQDs1j2rI77R9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442882; c=relaxed/simple;
	bh=bkuewVQcsUGgolWpEzr1PVJK+5AW9KPuFpJCrxj+73E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PT58pI1G8TbRAJJJ0PZJOc/2ltlfiCj4AOoLjjcltybhk6RFmxAuzzOmUcdynEvZfZwlj7DhZo4jOAA3nLZaRljwlMoa8tKE+PPrv0HtJrNgfkDXjK18fAkzj/3MQYrPmPhR57UAA5XT1cSAUHZWpqulPZ0PGXjpo3GDdtDqcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ51mbaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ51mbaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768311F00893;
	Tue,  2 Jun 2026 23:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780442880;
	bh=AAXDYFvmK+nN8xrEvIIaJnPvs0bYcBJuKeg2OYhoS8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZQ51mbaWovA/ewxwkvufkpz1ixvpZCmYZccdX+rRJSFqoE/yf/FhqiSf0+0wsqoeM
	 U7aGVm+6aVo2mDQKWIbNBI9GunzFlDe/O2vPhkLX7cvyIEHlQOnJfsZFbfoJjb0+Hm
	 sy/r+sxAxpdjxbV/GMhmmU8owVO2/RGxiGUu/e+8++8TCDnQh32iF4R54yDLwT8F6V
	 ma6JaLqBODtg8xSTxUgb6VmmrYSI/K9IF9VSm6IunPvaQh9ddksiA2fSZgVzJd4JbJ
	 aSKqQqi+m+bPXcYRHJdDKstZWtNhnfawXRVMShZ6hfMluhyjfiMWoHX7oRYIf0QNjf
	 GNW2yt/OeYp2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/15] riscv: Add Zic64b to cpufeature and hwprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guodong Xu" <docular.xu@gmail.com>
Cc: kvm@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260603-rva23u64-hwprobe-v2-v3-8-5529a7b28384@gmail.com>
References: <20260603-rva23u64-hwprobe-v2-v3-8-5529a7b28384@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 23:28:00 +0000
Message-Id: <20260602232800.768311F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Zic64b validation incorrectly requires all CBO extensions to be =
present, erroneously disabling Zic64b if any optional CBO extension is unim=
plemented.
--

commit fecaace37b018a89cd6931b57477f69defdbcd61
Author: Guodong Xu <docular.xu@gmail.com>

riscv: Add Zic64b to cpufeature and hwprobe

This commit adds support for the Zic64b extension, which mandates 64-byte
naturally aligned cache blocks. It allocates an ISA extension ID, adds a
validation callback, and exports the feature via hwprobe.

> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index e0197160af6dd..79ff431768139 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c

[ ... ]

> @@ -154,6 +154,23 @@ static int riscv_ext_zicbop_validate(const struct ri=
scv_isa_ext_data *data,
>  	return 0;
>  }
> =20
> +static int riscv_ext_zic64b_validate(const struct riscv_isa_ext_data *da=
ta,
> +				     const unsigned long *isa_bitmap)
> +{
> +	/*
> +	 * Zic64b mandates 64-byte naturally aligned cache blocks; cross-check =
the
> +	 * cbom/cbop/cboz block-size device-tree properties to avoid inconsiste=
ncy.
> +	 */
> +	if (riscv_cbom_block_size !=3D 64 ||
> +	    riscv_cbop_block_size !=3D 64 ||
> +	    riscv_cboz_block_size !=3D 64) {

[Severity: Medium]
Will this check erroneously disable Zic64b if a platform does not implement
all three CBO extensions?

If a hardware platform implements Zic64b but omits an optional extension
like Zicbop, the riscv,cbop-block-size property might be absent from the
device tree, leaving riscv_cbop_block_size initialized at 0.

This unconditional check evaluates 0 !=3D 64 as true, which would spuriously
trigger this error path and disable the valid Zic64b extension.

Should this validation only enforce the 64-byte size if the corresponding
block size variable is non-zero, indicating the extension is actually prese=
nt?

> +		pr_err("Zic64b detected in ISA string, disabling as the cache block si=
ze is not 64 bytes\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-rva23u64-h=
wprobe-v2-v3-0-5529a7b28384@gmail.com?part=3D8
