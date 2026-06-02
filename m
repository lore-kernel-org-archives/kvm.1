Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAA9199E89
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431040; cv=none; b=hdYmz6igc8KHdrcyTyZqGfTaY39y5FFjqomo9lLuDNgSeWV2J6iJ17w1fNjWiH2cCepOMYLODAF06esgYvJ1chyH1VQhrq2L1zEdKfgJlAnS82dV2+bL9FF8/HiVsZ3CQHT2XG6ZEJubD8ZTMMKCpQP+Ufw4jHf6kJNjR1UtBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431040; c=relaxed/simple;
	bh=O59ZPGa69Kq7uOFA6LEsfqEHOEEHKQjalTavv8h4MDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PJ3+QmIUq8bOy7CwT42qXKtOMr8tFo7LYeoaY6lyZfS1WXZ2P/D61mxHIeU2vFWZ3mPDfZoFWv4AJqkGh0UlIW4YPn3pidH7yEcKFKWbrrgy5+iN4RR62Vpo6AWhITH+3VU39VqsU1SOn7HICZXb9dmItvXqBseIxqAiNA2CyMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb+ToZXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb+ToZXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384491F00893;
	Tue,  2 Jun 2026 20:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780431039;
	bh=37um7KbrpWl0OBd+ijBoLmR3H2aZQLW/8lWU6B+XP7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hb+ToZXprhl3mCq1Bl6qdlvgdM7jhnskfXiOa0qae01nL+hBwovN0tf+Kuarr/d2d
	 K3qCQV7e4xgSgGN3XEYaIuLVW2i77RhiCu6rjERfVwfVK9BbohRdFZ1Adth7rYlMrG
	 mVzYJkUgXNxTVeUy/G61S15otBOYrQnsqJThAM5oB91BDQ7qfBlGvC/ozxrslTafK6
	 QwGVW5eFMcNcvz4RTvSoBPembZAbLUYb2ipEqbVfDuBMj+l0N1Vh0UVzi2n4vZHzsh
	 dnG05EE/KlSU/r9L1B2i2H6x4kTkiEPLt2TwDOv+8P4NadgoJCyrLNEqG0aJ5xYlr8
	 /4Mr24CX85lpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] x86/cpufeatures: Add X86_FEATURE_AMD_RMPOPT
 feature flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <5f587ed487c037ce6a1174fa8cdf25112d2c8eac.1780427587.git.ashish.kalra@amd.com>
References: <5f587ed487c037ce6a1174fa8cdf25112d2c8eac.1780427587.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 20:10:38 +0000
Message-Id: <20260602201039.384491F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Mismatch between the feature flag name in the commit message tit=
le and the actual code.
- [Low] Missing synchronization of `arch/x86/include/asm/cpufeatures.h` wit=
h the corresponding tools copy.
--

commit c36f3189418bf1ed5bdfdcfed5326214cecfd96a
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/cpufeatures: Add X86_FEATURE_AMD_RMPOPT feature flag

This commit adds a new feature flag indicating whether the RMPOPT
instruction is supported. It allows RMP checks to be skipped when 1-GB
memory regions are known to contain no SEV-SNP guest memory.

> x86/cpufeatures: Add X86_FEATURE_AMD_RMPOPT feature flag

[Severity: Medium]
The commit message title states it adds the X86_FEATURE_AMD_RMPOPT feature
flag, but the code implementation defines it as X86_FEATURE_RMPOPT (without
the AMD_ prefix). Should the commit title be updated to accurately reflect
the macro name defined in the code?

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 1b4a48bff18f7..14f23d19d8645 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -76,7 +76,7 @@
>  #define X86_FEATURE_K8			( 3*32+ 4) /* Opteron, Athlon64 */
>  #define X86_FEATURE_ZEN5		( 3*32+ 5) /* CPU based on Zen5 microarchitect=
ure */
>  #define X86_FEATURE_ZEN6		( 3*32+ 6) /* CPU based on Zen6 microarchitect=
ure */
> -/* Free                                 ( 3*32+ 7) */
> +#define X86_FEATURE_RMPOPT		( 3*32+ 7) /* Support for AMD RMPOPT instruc=
tion */

[Severity: Low]
Does this update need to be mirrored in
tools/arch/x86/include/asm/cpufeatures.h?

Adding a new CPU feature flag to the kernel header without updating the too=
ls
copy typically causes tools like perf and the check-headers.sh script to em=
it
build warnings about the kernel ABI header differing from the latest versio=
n.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780427587.gi=
t.ashish.kalra@amd.com?part=3D1
