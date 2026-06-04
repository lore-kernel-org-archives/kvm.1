Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590733803F8
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606209; cv=none; b=ilpGI3F04m5FmfTVquCDkkerwdEJGz5w1JDuZk2nhS/p8DGgRbxI4NqP9wBOSDSm3NWkavQQp6/v9cFLkhrudVtUutJOiGDmnMuo+hq8LbFH6R47gB8hTRdV3GhaP5qqCMHuXG8aYE914uL3wsViNkCvwN3Q3+ynd0yayMwyxdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606209; c=relaxed/simple;
	bh=vFKR69kLb840DbB1SEzRt2/wl+AD9G94++k66jbarTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jeourr2dUIgTo6Xeg7hnppL/CkpqnxlUCn8FvaqF+d2ZFvn7EJu6zw44+THDFai2TQtsUFr79jy5PSSrKVSDfa8J2OPWJwXxi31RSD5Q0XC+C+peZjOTfp5cZwhp/vUY1WfUPAo+qu4iJqS7axppJikbYyw6CNu8m52KZ1Zs2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsIgnYUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsIgnYUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D004E1F00893;
	Thu,  4 Jun 2026 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780606208;
	bh=jp+T1LczJpSeDiMr1sFSkbhA432zxmvVyeVyRuLwffI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MsIgnYUOwTI4nZejgTEaxFfrwGgXxumeIRj4BQ94KShRdE0hJchKkyuYStW9f9jpf
	 Bjb98Iu3VCYjkZeULbLVk3Yx9wSLWlG6wuA3j5H4IU2GDoIj4eBjOBWjhG0j4+i+x3
	 HYYOJvcdu/u9qoKjUvrMPxraIhDuRVY322+ifU9DE1B5NwpBDfFEFV315+WNi2Msio
	 ycc682gLR/8BDqDxujR9QyZTZyaLozAb6fNrrOjnpoJAybgRwFsVkprzStW6C4i75t
	 CbErWLNpVbKkUbnrKmMCRBNISxaGK63cQcLVq7d0hPjtHARUlf3OQoJ6nmznHY1ab0
	 emQu0rB/yqDNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] KVM: selftests: Drop
 HORRIFIC_L2_UCALL_CLOBBER_HACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604203546.365658-7-yosry@kernel.org>
References: <20260604203546.365658-7-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:50:07 +0000
Message-Id: <20260604205007.D004E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removal of the ucall GPR hack causes L2 register corruption in E=
VMCS nested virtualization tests.
--

commit 15ef07c71219fb9256d8d4da6427386aaf993fbd
Author: Yosry Ahmed <yosry@kernel.org>
KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK

This commit drops the HORRIFIC_L2_UCALL_CLOBBER_HACK from ucall_arch_do_uca=
ll(),
relying on the nVMX test code to preserve L2 GPRs across nested VM-exits.

> diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/=
selftests/kvm/lib/x86/ucall.c
> index e7dd5791959ba..38050c60a0670 100644
> --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
> @@ -10,36 +10,8 @@
> =20
>  void ucall_arch_do_ucall(gva_t uc)
>  {
[ ... ]
> -		     HORRIFIC_L2_UCALL_CLOBBER_HACK);
> +	asm volatile("in %[port], %%al"
> +		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory");

[Severity: Medium]
Does the removal of this hack cause L2 register corruption in Enlightened
VMX (EVMCS) tests?

While standard nVMX tests preserve GPRs using VMX_SWITCH_GPRS_ASM, it appea=
rs
the EVMCS helpers evmcs_vmlaunch() and evmcs_vmresume() in
tools/testing/selftests/kvm/include/x86/evmcs.h were not updated.

These functions still use a hardcoded inline assembly sequence that explici=
tly
clobbers %rbx and %r8-%r15.

If L2 triggers a ucall and an asynchronous event forces a nested VM-Exit
to L1, wouldn't the L1 compiler clobber L2's GPRs, causing L2 to resume
with corrupted registers and leading to a test failure?

>  }
> =20
>  void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604203546.3656=
58-1-yosry@kernel.org?part=3D6
