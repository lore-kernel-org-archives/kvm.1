Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9DD1A9FAF
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 04:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782189788; cv=none; b=Z8ZTYEi+NssAiaFS1z05RUEvp97dvg/YN/5H+mC8WSZI67yjFQy+cgQr6V61G+GIE2k8yU/80B2dB7GvKdWxcM9CLlF66ywPaxYpldkJb+BU0A8cxRLT96WHf8AMeyIOGQpyQsg62fw+dT9Sg+2FNo8TGLIaQg+I1WrtTJrHWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782189788; c=relaxed/simple;
	bh=ZsASNB6xwi4hB/Brmvx1YPPMT9Lcnpz9GIoVzXqQH2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lJzpqCCNwQA8IhwBB2jrJqxgJBOaFKdO2RVqYjjO/S3BIT+AQRQ0DtlN6s1DLCo/wUoxCU80PIr831kJL03kSTGNEW2LJvL6enKeUEXQYvwrZH10bjIpyGpHJbI8iVT+u6/eUq98902LTOjnsImG+0UgSlnKzVggsOFKDRunQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcVSIPi0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcVSIPi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8341F000E9;
	Tue, 23 Jun 2026 04:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782189786;
	bh=3qqSVMYaBQim+nay/ZFvRiVAtRQ2SPhGEQpdoXXEEtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mcVSIPi0HLeS0vIfV75C41LPGAy0UwAufVtE3Kt3WLZyMeUeS+QZSCMAfyJfx17WY
	 ux8Ez4u/UhXQ0dtNfqXvpA6ga6A3/EJNvjuXPV9F+CKhfgY72PgZU6BxXAXMRfmkss
	 0I+5RlAi21W3tvKJ+LdntH06uSW1/9sZTTuLwmYAvAYNPvlz1/iIn4TX21RGVmUqzF
	 v8owN1c6SptZp3tE5lAbAQ9cPxzU0bi36qIK0XAUNSBjKgiFf5+9OKjvWhT1D9T+8I
	 /6+cjU0b5QPL0L7DLqAXI7vSbQ9ZkY8+SM1SPmdYGGxADEp/G9nzB1poIMwt/Yetu8
	 PScL4UkHXoueQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 4/4] KVM: selftests: Add perf_metrics and fixed
 counter 3 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260623041927.178256-5-zide.chen@intel.com>
References: <20260623041927.178256-1-zide.chen@intel.com>
 <20260623041927.178256-5-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 04:43:06 +0000
Message-Id: <20260623044306.BD8341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM's emulator unconditionally injects a #GP on guest accesses to =
MSR_PERF_METRICS, breaking instruction emulation and nested virtualization.=
 The selftest omits forced emulation coverage that would expose this.
--

commit f588cce382d8777ebda7951bd3447ee7ba4c18ff
Author: Zide Chen <zide.chen@intel.com>

KVM: selftests: Add perf_metrics and fixed counter 3 tests
   =20
Add a selftest to exercise IA32_PERF_METRICS, i.e. architectural
support for Topdown (TMA) Level 1 metrics, enumerated by
IA32_PERF_CAPABILITIES[15].

> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/=
testing/selftests/kvm/x86/pmu_counters_test.c
> index dc6afac3aa919..d4688a7d1e556 100644
> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c

[ ... ]

> @@ -318,6 +322,56 @@ static void guest_test_arch_event(u8 idx)
>  				FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
>  }
> =20
> +static void guest_test_perf_metrics(void)
> +{

[ ... ]

> +	/* Sanity check after PERF_METRICS disabled. */
> +	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
> +	wrmsr(MSR_PERF_METRICS, 0xdeaddead);
> +
> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), 0xdeaddead);
> +}

[Severity: High]
Should this test include forced emulation (e.g., using KVM_FEP) coverage for
these MSR_PERF_METRICS accesses?

Currently, the selftest relies purely on native rdmsr/wrmsr execution.
If these instructions were emulated, it would expose an issue in
intel_pmu_get_msr() and intel_pmu_set_msr() where KVM's emulator
unconditionally injects a #GP on guest accesses because they return 1
when !msr_info->host_initiated.

Could we add forced emulation coverage to catch emulator issues that break
instruction emulation and nested virtualization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623041927.1782=
56-1-zide.chen@intel.com?part=3D4
