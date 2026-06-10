Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B71257435
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059519; cv=none; b=q6UVdVpfdRndp4SvazR3/O+jbcF+jOOZkSOOud3wNRl6qVOBSlfJ9wrHoByRwaUMWUJGwI01Q6aKUm5uZhaPmLU5Jl4jHZis/cfDuyAgomXeMSXsy3b0UqrV6wJxYQCtyuwIoJbuTpzYKm1FrI/yvZGiNYI0nIYIAxvSAvlNlzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059519; c=relaxed/simple;
	bh=ABPzTbNM34L8vHrjGSH4I8y2WgzMlSxxLRTGAmy8rWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gM3Z1hkuCNMo7Tf8yUcnKwapBLjKRi3IAGmOreLYHR1Xr46uCTN/xki1NLfJZzH52npN9IEeIa6ieZtWJXz/7pXqs3VbAMSURtFwRgH83InpYzYykKpBGrK50ApeYxWpaVbmUnL5ztmcpgl38lirkq8/uEikJsQE7aXiSIv/6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwZkj750; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwZkj750"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F95D1F00893;
	Wed, 10 Jun 2026 02:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781059518;
	bh=HqiEBW6bysyy9DQ7mzsn+21tl2EZjzatUAC4wwlcsu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kwZkj750PJLqUdVae7Kfe8kSNQVBgvlV8IAotld+YLG61yA6ARfoRjULRmUg1lUHt
	 n/uvA07a9MmWGwPj/80EWweSs0zKGUpVhRtYD1LJcLkZS8xa3aE03qnL+skUHOSaIP
	 31CWZya7EhAf8dq99xILOxAgu58grXrmQtFOk/H80g4QlUtjKLjoULh3fs3YiT41HM
	 jU26HZ70ZwZuCdqmjWgBsbCUWp/jppAq8gyJEgVqERNNSg0y0IJP+uycK2q5SUD2mB
	 mn1pNPKF77BkywgzDNiSsVIsz/kks2Hjnd/gK0wrES0mMVC0jKq+EPmM6gELoQb3Qc
	 Ie1/c8dX70HFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] KVM: x86: Expose Zhaoxin PHE2 CPUID feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ewan Hai-oc" <ewanhai-oc@zhaoxin.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260610023512.3690734-5-ewanhai-oc@zhaoxin.com>
References: <20260610023512.3690734-5-ewanhai-oc@zhaoxin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 02:45:17 +0000
Message-Id: <20260610024518.3F95D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch adds X86_FEATURE_PHE2 and X86_FEATURE_PHE2_EN to arch/x86=
/include/asm/cpufeatures.h but fails to update the corresponding tools head=
er tools/arch/x86/include/asm/cpufeatures.h.
--

commit 3f9973df29d33e555520e65352e2ad0d4e602e77
Author: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>

KVM: x86: Expose Zhaoxin PHE2 CPUID feature

This commit advertises the Zhaoxin PadLock Hash Engine v2 to guests via
CPUID 0xC0000001 EDX bits 25 and 26. It exposes unprivileged instructions
for SHA-384 and SHA-512 support.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index e264758d58e22..3702d7a30ae61 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -152,6 +152,8 @@
>  #define X86_FEATURE_PMM_EN		( 5*32+13) /* "pmm_en" PMM enabled */
>  #define X86_FEATURE_RNG2		( 5*32+22) /* "rng2" RNG v2 */
>  #define X86_FEATURE_RNG2_EN		( 5*32+23) /* "rng2_en" RNG2 enabled */
> +#define X86_FEATURE_PHE2		( 5*32+25) /* "phe2" PadLock Hash Engine v2 */
> +#define X86_FEATURE_PHE2_EN		( 5*32+26) /* "phe2_en" PHE2 enabled */

[Severity: Low]
Is it necessary to synchronize this addition with the tooling headers?

Adding new feature bits to arch/x86/include/asm/cpufeatures.h without also
mirroring them to tools/arch/x86/include/asm/cpufeatures.h usually causes
check-headers.sh to emit a build warning in the tools/perf tree.

Could this patch include the update to the tools directory copy to prevent
these warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610023512.3690=
734-1-ewanhai-oc@zhaoxin.com?part=3D4
