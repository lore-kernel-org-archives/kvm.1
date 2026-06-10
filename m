Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834BF198E91
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059432; cv=none; b=Wv0/OGdHFQvVTEjTO1Pb3UQdVyujxvpln0S1Rd+deeKDFHWFhISJedehwL6ssGP852Y+JKqPnE2Qcuk1m4Sk2GeKbNlKp9iuRjJFibUOthXgDUze53xtvxKeZjxqMXPnsr6aI3sV7UoFpIZAy5oHyFddeungYCM2C5NeIqRy68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059432; c=relaxed/simple;
	bh=UVmuRw+KeSF0hbQLDPK+h8qdZmI0zpEwXwHWx3ELfHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qDNMkzSepiUJYa78u/6GxKrAVfLxkWyfG6F5G427Zuo6ngimJCTqiNK9/kVe63PH3yuyJ756Xd8u5JTb9jbJyxeqpbtwXMyR9q/LARkbP12ptcCG5flpmWCD0+8A629bak3CbyO4LigXbyRjNSY66IvSY5TvDvPU/WH2raxyGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDRNBCR7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDRNBCR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13471F00893;
	Wed, 10 Jun 2026 02:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781059431;
	bh=Mhi9kvPrF658ofeDbpp88ooisDT0bzddNtQd/Hk+/0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YDRNBCR7PSxmu4x1jz51IpzvZS64nkcR8ITddW2LB9XvApVK54zYNaBzBvubR7K9+
	 Ete9773bpNYXWJL16rEEkGjBmWSYXSkAtx6lG1DLls5x2/7nMGBGCXtRwrwvCDTihj
	 /7hs/UkdMfV1sskEX5xFOtzyRTCH88KzDL3VZ5zmENvWRW/heWT/ZQH9BHjXuUjuip
	 rhhOzB/yzXffYOsxyvxzXwpPQ5BrpTy/iVttrw1klLFBfKh2hpipjDfORJvPSa6lTD
	 xOVssTzJUtBYXYKWzfcJ/aAvZVpfHikVledZJ37fUdoGY8CM6zOK79yGV9+459+hOM
	 l407k/GIkHgNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ewan Hai-oc" <ewanhai-oc@zhaoxin.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260610023512.3690734-2-ewanhai-oc@zhaoxin.com>
References: <20260610023512.3690734-2-ewanhai-oc@zhaoxin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 02:43:50 +0000
Message-Id: <20260610024350.F13471F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added CPU feature flags `X86_FEATURE_SM2` and `X86_FEATUR=
E_SM2_EN` in `arch/x86/include/asm/cpufeatures.h` are not mirrored to `tool=
s/arch/x86/include/asm/cpufeatures.h`. This discrepancy triggers a 'Kernel =
ABI header ... differs from latest version' warning from `tools/perf/check-=
headers.sh` when building kernel tools.
--

commit 9ee6d6c060dd6911df4ff4999acdeb3563ea4667
Author: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>

KVM: x86: Expose Zhaoxin SM2 CPUID feature

This commit advertises Zhaoxin SM2 instruction support to guests via
CPUID 0xC0000001 EDX bits 0 (SM2) and 1 (SM2_EN). It registers the new
capabilities in the KVM CPU caps initialization and the x86 architecture
feature lists.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 1d506e5d6f46a..20b33413189c2 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -136,6 +136,8 @@
>  #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* "hypervisor" Running on a =
hypervisor */
> =20
>  /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word =
5 */
> +#define X86_FEATURE_SM2			( 5*32+ 0) /* "sm2" SM2 algorithm */
> +#define X86_FEATURE_SM2_EN		( 5*32+ 1) /* "sm2_en" SM2 enabled */

[Severity: Low]
This isn't a bug, but should these new feature flags also be added to
tools/arch/x86/include/asm/cpufeatures.h?

Leaving the tools copy out of sync with the main architecture header
triggers a warning from tools/perf/check-headers.sh indicating that the
Kernel ABI header differs from the latest version when building kernel
tools.

>  #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
>  #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610023512.3690=
734-1-ewanhai-oc@zhaoxin.com?part=3D1
