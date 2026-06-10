Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686098C1F
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 02:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059458; cv=none; b=D/VZMkqhQ0HpCz/RgqBBWGaT5xkF39UITGsBOFlZum+AKUB48jWAWkCRIbPWbWT9vg+vAw0yexlz0T6BPcuRSdStHKsIgdJ+aUfvyeAE5o+DlWb8VZQ1p0cgxwNeds4iYr20cyP0mEO/PWwGBkQTsBx5Wyd4lh4ajbEI+j+iA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059458; c=relaxed/simple;
	bh=5TCBv0QjOTahARAHCB8Bv7rC1n1xrQ/iQGG429KeAiE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jxJ5KWtCEGMIhwi8vzwE6yYD7SGXw+do9EJvjsCYjNF07wKNfDZkqwcNaxZqPR5wEFoTZMr3FpNG3iKSPcxUneRj/mWh4BAj5pv2RsicXdepIo7LaLGFuKG8oxNnl3csPm0wt6deSQ6Y6t26QOuwzaEzFBk6QIESFU8JxjdvWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4hPlWDv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4hPlWDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D811C1F00893;
	Wed, 10 Jun 2026 02:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781059457;
	bh=1gp7MSdtIqrPRyBHBnduBgKMGeBCJG/Tt9jn0TZ9C0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O4hPlWDv1zdn0EdnU6OPNYehpXkgup3txGfpTyN4ULjsgsV+qXEXsH19VQZ/vgSGa
	 DI/gFmgnrrgTuTWgbQcYQOorlAwM4XGhF+9DtuKQiSxMEslioznni3uw9yzrpsIkFE
	 VgIHdNYquM5HE3IroBZB4iz//QtGNwUo0bc4Vb/hEVKH5puHO0RLT8gAIrMrUpnKcu
	 EViKBkSvn5IPc3UT7QPij1be6p/wb/uxZlxtFbPZmZjweVMPPZ5gFq+Csc1lYRDhT7
	 6OHyC8fGL6omY1vXYSCtCbb+hbTgGgukvna5jkOCBKYYkGl5i3V3Fw7y/PvU+74i/u
	 OTinuVJD8vxzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] KVM: x86: Expose Zhaoxin RNG2 CPUID feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ewan Hai-oc" <ewanhai-oc@zhaoxin.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260610023512.3690734-4-ewanhai-oc@zhaoxin.com>
References: <20260610023512.3690734-4-ewanhai-oc@zhaoxin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 02:44:16 +0000
Message-Id: <20260610024416.D811C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing synchronization of tools/arch/x86/include/asm/cpufeatures.h.
--

commit 0ff90b8c977a44dc52de6838a89fc982a023995b
Author: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>

KVM: x86: Expose Zhaoxin RNG2 CPUID feature

This commit advertises the Zhaoxin second-generation hardware RNG
to guests via CPUID 0xC0000001 EDX bits 22 and 23. It adds the
corresponding feature definitions and initializes them in the
capabilities list.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 276e4ef90bd07..e264758d58e22 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -150,6 +150,8 @@
>  #define X86_FEATURE_PHE_EN		( 5*32+11) /* "phe_en" PHE enabled */
>  #define X86_FEATURE_PMM			( 5*32+12) /* "pmm" PadLock Montgomery Multipl=
ier */
>  #define X86_FEATURE_PMM_EN		( 5*32+13) /* "pmm_en" PMM enabled */
> +#define X86_FEATURE_RNG2		( 5*32+22) /* "rng2" RNG v2 */
> +#define X86_FEATURE_RNG2_EN		( 5*32+23) /* "rng2_en" RNG2 enabled */

[Severity: Low]
Does this change also need to be synchronized to
tools/arch/x86/include/asm/cpufeatures.h?=20

Leaving the tools header unsynchronized typically results in a build
warning from tools/perf/check-headers.sh when checking for divergences.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610023512.3690=
734-1-ewanhai-oc@zhaoxin.com?part=3D3
