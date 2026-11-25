Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588741;
	b=ggCr6r0I7HMMOI6uXNRLR2OXFQaarhv60kCF/z/VATRpkl1yn80RLY9i85VvejMFa1Jb
	 omAKRpmlN1Em3zGb0BBBIuaiM9dmrLEZ/4VMnC4IeZ1dYt0a2xXpIFLUYEVCbMmhOgciI
	 BbuFzh+XmmZKB55pywIdOEKH0BHX/U4eo8JvBKvnlO8R2f8r4sjn0pwkv2ELlNESiKMOf
	 xnf6+w0KIHAo9LLM4K+ZDyUGvcdkL/Xw0wo+ho0wdyRetaDf/eecSrY6EbwJg96PF6YvA
	 QaOyqEcNLX++PiLDH5nId9+r0hmTRSHzba/Bj6/G5yxvHIDaBrMBznqI2jqQzFmPS9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588741;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aUyfJgvvGSRT52NKljWjVmDNu/ObxVTgMBErx17yyLM=;
	b=bkgPpzAXcKmqBzkw23VTf08E6KtsJcIAMk8mOb/mWUmarN1klqzp7V+sCPVPuyj4yu8w
	 uR0yUBzNcyPzsVmwbk4ho5QCs3WZALXHHlj4aONWFciQEeBIEyVOxzkHVZ9WTq0dd9Mik
	 LgO3CW0LVizVLxAQTM/YHeoyFiiN7uiIh9DEDLZoHKsfXdFsPnRBaJmzjvrGshzn6Z4vY
	 aIY420koXCUmzH8V3TgFoeqpuNDjwtpdH5Qto5qTNlRkhZxJ0p+2iQ/VMFNI04qBoP8Gq
	 eNOTQMMAO/sCjgD5CbeYoY+ToAzUbKv9GgMSRuftYiIEOvXjMBwtcqrPtj3m7HgW2bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eilJIV5z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6E606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eilJIV5z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2031F000CF;
	Wed, 25 Nov 2026 06:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795588741;
	bh=aUyfJgvvGSRT52NKljWjVmDNu/ObxVTgMBErx17yyLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eilJIV5zoY71EZwlESIZ6hhtNE7Z0lakDGM/rS787+nOMSLawJBbLP/5k4QjsbQzY
	 2PRUWUHgDASwAbC0diH7q8lBIIFRrIED3MdmVIy5gNZlrZaUOVX0M6pGZw3TKYzCZ0
	 GYwDyXpFHzbDTxNnH1rfXmtURwbLOg1N53TO1vJtojaUKMoKvhhhmOG3yh0RnNktlJ
	 kxPJgQLFCAo2IepCloAKbWS8EEKZ4eQSnXZ663m/jrLUVQR+j/mG/baMzaOd7t2CsF
	 i1wS0TAyRxxUyKWbtMuFRD5hEEschaWIT8SPwWv9yPyEe+mr2i41lrs/PUuJmVynqI
	 MY1LL6XZO91Tg==
Message-ID: <sashiko-outbox-232723@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: Test that an NMI-window single-step
 preserves the guest's RF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peng Hao" <flyingpenghao@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261125063000.92971-2-flyingpeng@tencent.com>
References: <20261125063000.92971-1-flyingpeng@tencent.com>
 <20261125063000.92971-2-flyingpeng@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 06:39:00 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] KVM: selftests: standalone nmi_iret_rf_test duplicates
  debug_regs harness
--

commit 3aebfc62612be05298e4bd8add5fc7086d476fc4
Author: Peng Hao <flyingpenghao@gmail.com>

KVM: selftests: Test that an NMI-window single-step preserves the guest's RF

This commit adds a standalone KVM x86 selftest verifying that RFLAGS.RF is
preserved across an NMI handler's IRET when KVM single-steps the IRET to
detect the end of NMI blocking.

> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index 95867977beb3c..2ca17a1cb275a 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -154,6 +154,7 @@ TEST_GEN_PROGS_x86 +=3D x86/xapic_tpr_test
>  TEST_GEN_PROGS_x86 +=3D x86/xcr0_cpuid_test
>  TEST_GEN_PROGS_x86 +=3D x86/xss_msr_test
>  TEST_GEN_PROGS_x86 +=3D x86/debug_regs
> +TEST_GEN_PROGS_x86 +=3D x86/nmi_iret_rf_test
>  TEST_GEN_PROGS_x86 +=3D x86/tsc_msrs_test
>  TEST_GEN_PROGS_x86 +=3D x86/vmx_pmu_caps_test
>  TEST_GEN_PROGS_x86 +=3D x86/xen_shinfo_test

[Severity: Low]
Could this test case be folded into tools/testing/selftests/kvm/x86/debug_r=
egs.c
instead of adding a standalone x86/nmi_iret_rf_test binary?

debug_regs.c already sets up a single-vCPU VM with x2apic_enable() and a
DB_VECTOR exception handler to test hardware instruction breakpoints and
guest-handled #DB interactions with interrupt delivery and IRET.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125063000.9297=
1-1-flyingpeng@tencent.com?part=3D2
