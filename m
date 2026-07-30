Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DCF38DC5E
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414798; cv=none; b=IC6Si9G1+Lm6ti808avRmcQQITM80PaeYxQtLMguPTYXHjrTYkhpnQT8cOgChczBSeLt7bFYwum+btXuRrzw0jfrydxyNgKd3P5kVVapgO0dQtY30GyWyBGIQsePe5hkHqgMC2HYum7Wxj2dLx/zHvoeSMiAprvbCnVm/nfoLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414798; c=relaxed/simple;
	bh=WJfwxRat8oPS9S212PSYD+C7cYpFjCH0UAvuYhLhLpg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WIt7hhCU3r5DJYmVqxFF6WqYjwnrf3MFaA9fv8QtclbRpOnpQTeyf2cwhOpeEhQOs8j/UldgoFcV8QEkSLyBEWCCaTeS/dD8E6hP0AM2z0kFoyRrgzvoruWCOKUK3H0mR0jrLVtIUDB3SEPjOMBCJFbrM3agzMVD17tRerNbzto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPo0wGSz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPo0wGSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC92B1F000E9;
	Thu, 30 Jul 2026 12:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414796;
	bh=JVribPP2D8PAbvJIAelj1VeECjnxCntg3y+e407kTb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FPo0wGSzivDX79jxADKOeRHJZuKMv68jrpsbkOd5NUIStkApPdA6AMGIOrXs1ZwSy
	 VOU2SvWqIc8Hef3xPkHDR1XU9zUsAI+qu1Z4ODggQ1Snymf42my0gpAx5nfJ9vddt4
	 xFoDGUkxGXdUd4wIAtB9NX7GvIA74ATeycZ53gCScqlQF6TAPo55L92MRvauogElK5
	 CsuEH5lK1m7DIayhwIJ+OHZEuepprENZUuNZpQJ1pBwYIj94+1GTtA9B81kccBlKkN
	 VZLCjT1zupnnwn9VjYonTZEeRNXtYlKBfCC9EjzVhrw56ExLeY/sznLtlYsrUfTdU7
	 LKN+YdsSzYLGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] KVM: nSVM: Advertise DecodeAssists to L1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <29c2042af283e6d1a0b928b78d944b499153dace.1785411877.git.zhang_wei@open-hieco.net>
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
 <29c2042af283e6d1a0b928b78d944b499153dace.1785411877.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:33:16 +0000
Message-Id: <20260730123316.AC92B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing VENDOR_F(DECODEASSISTS) initialization in CPUID 0x8000000A =
leaf definition.
--

--- Patch [8]: [PATCH v3 8/9] KVM: nSVM: Advertise DecodeAssists to L1 ---
commit 2694559bd05c1133d7f21075f9c95dc19418651a
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Advertise DecodeAssists to L1

This patch advertises DecodeAssists to L1 guests by checking and setting
the X86_FEATURE_DECODEASSISTS capability when supported by hardware. This
enables QEMU configurations that enforce the decodeassists feature.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 6e2ceb700567c..4e01a6ede4246 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5588,6 +5588,8 @@ static __init void svm_set_cpu_caps(void)
>  		 */
>  		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
> =20
> +		kvm_cpu_cap_check_and_set(X86_FEATURE_DECODEASSISTS);

[Severity: Low]
Does this feature also need to be initialized in arch/x86/kvm/cpuid.c?

Currently, kvm_cpu_cap_check_and_set() is used here to enable it, but
VENDOR_F(DECODEASSISTS) appears to be missing from the CPUID_8000_000A_EDX
capabilities array in cpuid.c:

arch/x86/kvm/cpuid.c:kvm_cpu_cap_init() {
    /* All SVM features required additional vendor module enabling. */
    kvm_cpu_cap_init(CPUID_8000_000A_EDX,
        VENDOR_F(NPT),
        VENDOR_F(VMCBCLEAN),
        ...
}

Without VENDOR_F(DECODEASSISTS), this skips KVM's standard compile-time
validation and raw CPUID masking logic. Should it be added to the vendor
feature list as well?

> +
>  		if (nrips)
>  			kvm_cpu_cap_set(X86_FEATURE_NRIPS);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785411877.gi=
t.zhang_wei@open-hieco.net?part=3D8
