Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06814282F24
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589228; cv=none; b=JNuaRKoMx/Jp9X6jXitfNoJ7HpsYUKpbeBxeAJ+nJhXtigqtGbjPOAKMK3gnJyNE/iMbJ17cPbNgiSpE5SolpnC8maViXbOHRuUoiKDsRB1kyb0psXg8PiwceF+QDWA8JwjmwK40hfufSHPg/v7CK5N+xVHH/3QOv/pf2A5JWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589228; c=relaxed/simple;
	bh=BHdqEsfwdrP3jBOc4nJt7zjApEj1hbmpfyyO0+FUmA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qSYvlxvwPuX/31T0HF5nToT92yCmW7WLrfeyKVxTG8iWU7OZqAoEZPoBTty4+yi8OCszGr9vYgrf4APkLWdBIfjoBTYyphSi63LMMNkbmZSxRkG2s7hYOo4kqOibYSb9y9yz6Lv7fdsdVacHMpbzH1e91IMtH/9/zQB43wRO+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCGg7Qqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCGg7Qqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18511F000FF;
	Wed, 16 Sep 2026 20:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789589212;
	bh=93ISHLStDi7MmJsAkhCOms+TpDiDryEJb9GxP6QnuoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QCGg7QqjZ1unv4K+e3JmnVLg5n3qX58Bt6sXCc/POsnA2w3C2bvTJ0ZVi3mRNeK4w
	 Gmmg7/gSNTLvpr34r3hqqpFhLkb7lqa7g3pvKtgsu3V7/OMNFSe/CoT8AoGoCpH731
	 Gh4TnPfiEuhoTCOoJRr6XKXZuzcY/JDtdnJFza3sKNQF6QqR7XD82UttzZp7d4R8Fx
	 Pxvcb0k7bPxRkmZDI8FrHDtsOBqczu99oOb5RqhG+tXCvW8kPI7Ytp6qaDnLbhtxl7
	 te0TSYlwNmQAbjiUYb6Md/64uvK8T9u0t/Lu3GcEYNYdpSIixJBQmlMorbXOOw1L3c
	 bR0IxgyjAAwFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 3/5] x86/sev: Initialize RMPOPT configuration MSRs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <9d57b0584549df093c5134660ee5a76f7972a1aa.1789586444.git.ashish.kalra@amd.com>
References: <cover.1789586444.git.ashish.kalra@amd.com>
 <9d57b0584549df093c5134660ee5a76f7972a1aa.1789586444.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 20:06:52 +0000
Message-Id: <20260916200652.A18511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] x86/sev: missing X86_FEATURE_RMPOPT cleanup on probe failure
--

commit 1564212e828a7dee0758e1b6a358828053507df5
Author: Ashish Kalra <ashish.kalra@amd.com>
x86/sev: Initialize RMPOPT configuration MSRs

This commit initializes the per-CPU RMPOPT table base to enable RMP
optimizations for up to 2 TB of addressable memory. It introduces
snp_enable_rmpopt() to program the RMPOPT MSR once SNP is enabled and modif=
ies
snp_probe_rmptable_info() to clear the RMPOPT capability if segmented RMP is
unavailable.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 558f7924a3f85..f458128b9864f 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
[ ... ]
> @@ -699,13 +735,21 @@ static bool probe_segmented_rmptable_info(void)
> =20
>  bool snp_probe_rmptable_info(void)
>  {
> -	if (cpu_feature_enabled(X86_FEATURE_SEGMENTED_RMP))
> +	if (cpu_feature_enabled(X86_FEATURE_SEGMENTED_RMP)) {
>  		rdmsrq(MSR_AMD64_RMP_CFG, rmp_cfg);
> =20
> -	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED)
> -		return probe_segmented_rmptable_info();
> -	else
> -		return probe_contiguous_rmptable_info();
> +		if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED)
> +			return probe_segmented_rmptable_info();

[Severity: Low]
If probe_segmented_rmptable_info() fails and returns false, does this early
return bypass the setup_clear_cpu_cap(X86_FEATURE_RMPOPT) cleanup below?

If the BIOS or firmware enables Segmented RMP but provides an invalid
configuration (e.g., missing RMP_BASE or out-of-bounds segment size), this
could leave the X86_FEATURE_RMPOPT CPU capability flag erroneously set.
Consequently, later initcalls might unnecessarily allocate resources for
RMPOPT, even though SEV-SNP initialization will subsequently fail.

> +	}
> +
> +	/*
> +	 * Segmented RMP is either not supported on the platform or is
> +	 * disabled by the firmware.  RMPOPT is not supported without
> +	 * segmented RMP.
> +	 */
> +	setup_clear_cpu_cap(X86_FEATURE_RMPOPT);
> +
> +	return probe_contiguous_rmptable_info();
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789586444.gi=
t.ashish.kalra@amd.com?part=3D3
