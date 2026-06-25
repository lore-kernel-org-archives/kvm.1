Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B252D6E44
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782360824; cv=none; b=RalTAV8VrhcHLw0zrbwkDQxxVuz89bctnMaxG4NxaX+jxoAIW6PJTXFKrl+7Hv24ee/Fs6/8r9zUNvxQMaFTWczM5YaVXyogyzhbfYuRXuuoq7/8gyW1DGSqMU4c/VYrZcbXZ/thTSrvlfa/8D3+UGgJEVXT/TXNPHaczI9PbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782360824; c=relaxed/simple;
	bh=/iopUA0EruxSij3SihZ3vynul3k6nTUQQC9AANpoT4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M+z7G/9CAhpqI0ncAjAidDp3blrRXT4Fj2LCGyCb5NwY/zeOkyk7QAk9MvcaMJo+U7jJM24zqeon+FQCaDAd0KRk+4ZNlfPbkqQEYOE+dYdKE4Dh0MXXZsh3acYh6M/fE3NIAeCNfNBzSJJ9jlu86BXDDkV0k2iTfhlTj7XPDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3vSEVlV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3vSEVlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B303E1F000E9;
	Thu, 25 Jun 2026 04:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782360822;
	bh=JjAT7cWbGZ2zoombqBYHiNMWzrjgfxAHTeP/dPhEEUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J3vSEVlVqqSCu/bpda2m/XpohHju7QmEEP2zaxF2uEeIrBKcUmwHj3iNnhEIZuLwP
	 mwC5PIhJMER77kqWrS7xQyruLX1vgiIES1bCSDNa2uPOexNMH2fpOl8Xysn41VX+xT
	 85/cNZFE9CCO2znykIWwgG5Ygfoi212FPo6t35nblSrLYWxN/zDYgNL0cVtyKRN8Ug
	 p8ygl6nluUVqRYP2mxRD1xig2fSLQp+/chDTv/pUyWPeZQ3FA4Ypsca4nWmRI485Bn
	 cQPeMAV1GTIIsBwo7svF1YgJ8A4yKlnodgVycSdk5BoQ4kh/iT2kKHpgCiPkrf96O5
	 Pfp6/jpBFJvrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 7/7] KVM: selftests: Add perf_metrics and fixed
 counter 3 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625034555.141453-8-zide.chen@intel.com>
References: <20260625034555.141453-1-zide.chen@intel.com>
 <20260625034555.141453-8-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 04:13:42 +0000
Message-Id: <20260625041342.B303E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest assumes that MSR_PERF_METRICS retains arbitrary wri=
tten values like 0xdeaddead, which contradicts the Intel SDM and will fail =
on hardware when mediated PMU passthrough is used.
--

commit e4e21b97cacf777b041e2f100421a3f415696310
Author: Zide Chen <zide.chen@intel.com>

KVM: selftests: Add perf_metrics and fixed counter 3 tests

This commit adds a test case to exercise IA32_PERF_METRICS, validating the
architectural support for Topdown Level 1 metrics. It also extends the PMU
selftest to cover Intel fixed counter 3.

> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/=
testing/selftests/kvm/x86/pmu_counters_test.c
> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c

[ ... ]

> @@ -318,6 +322,56 @@ static void guest_test_arch_event(u8 idx)

[ ... ]

> +static void guest_test_perf_metrics(void)
> +{

[ ... ]

> +	/* Sanity check after PERF_METRICS disabled. */
> +	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
> +	wrmsr(MSR_PERF_METRICS, 0xdeaddead);
> +
> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), 0xdeaddead);

[Severity: Medium]
Will writing a reserved value to MSR_PERF_METRICS cause test failures on
hardware with mediated PMU passthrough?

The Intel SDM specifies that a write of 0 clears the metrics, and other
write values are reserved.

When mediated PMU is enabled, KVM disables MSR intercepts for
MSR_PERF_METRICS. This means the guest executes the wrmsr instruction
directly on the physical CPU. The hardware will likely reject the reserved
0xdeaddead value with a #GP exception, or mask the write, causing the
GUEST_ASSERT_EQ check to fail.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625034555.1414=
53-1-zide.chen@intel.com?part=3D7
