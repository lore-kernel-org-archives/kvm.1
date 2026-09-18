Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83150522686
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762096; cv=none; b=O5JfhD7brYIiJZF/43nID5uZamB5uSWNa6b3NfVQHlpTt+SCojEnU9NQ0R8EeS/MW5UYrWQSdahvVu2dazQk4QKlDFtpK+cKgL4ak6VxRxqtxdZIGMeSezyEhnoWOR1dhVm3g+Tsh8ijPIW6R5jwJ9ay6bL3ZsaeQGcqlGwk+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762096; c=relaxed/simple;
	bh=4wyqbNce6IoEvTw5m98sp4bUDCTv5oQVmmy4lvwfuL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rDCCl7pA/diszsiElY3KQsFe1KbcxG9MKmLgRxN1BwAxXHaJ9sYIdLRd1PrV73506+sTpWYI4ktsOTMzRZqHXpHHLwJNbukp9kL8BqY4b0pkMutbdyGHIdI63KEtGvIvGQ7mWka6EM972LOirXcDbG1NihZDSzzym18lEzBwR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUaLgsTh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUaLgsTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC4E1F000FF;
	Fri, 18 Sep 2026 20:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762095;
	bh=zmMbBiqCNnREUjZ8/Rno6bX0OXs+Zw5eRmtd9w64BAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YUaLgsThljBsCpecxdgyogD1PvujTFV8xMVDtQZANGBF43pE/lCzLBbUrxU3hWt0R
	 Gz5sUM1MECOBTkkchO4RuIexVGbtzzm4U95Jklo2qFjB9QGtYvlAjX6MO/QH7QA9eG
	 2BH4blVVbUTgsR7WXalJ8+Ga60GW+BimP+u+/wdDfn5uKJpmDGK8CttPBEDnBVLlVc
	 ivp3rFVCmF4nCpE9h8XfEsauS6mA/nLseqa8j3MaHoebU1/W0mnuYt9Xolrkbrcukv
	 dC94+QLpF88DKoNAz6zxbfdsPhpbFI//OK6yCwd0DiAHhVZFVaFOoV5cXBG/IQXLvK
	 zPPh1aeO5uYpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/12] KVM: selftests: Add PERF_METRICS and fixed
 counter 3 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918193937.569414-9-zide.chen@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-9-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:08:14 +0000
Message-Id: <20260918200815.2CC4E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: unconditional MSR read causes assertion failure on ol=
der kernels
--

commit c5ae582e90bae306393c4bf2f37f04a11e37ba5f
Author: Zide Chen <zide.chen@intel.com>

KVM: selftests: Add PERF_METRICS and fixed counter 3 tests

This commit adds a test case to exercise IA32_PERF_METRICS for Topdown Level
1 metrics. It also extends the PMU selftest to cover Intel fixed counter 3 =
by
bumping the maximum number of fixed counters and validating functionality.

> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/=
testing/selftests/kvm/x86/pmu_counters_test.c
> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
[ ... ]
> @@ -653,8 +657,85 @@ static void test_fixed_counters(u8 pmu_version, u64 =
perf_capabilities)
[ ... ]
>  static void test_intel_counters(void)
>  {
> +	u64 advertised_perf_caps =3D kvm_get_feature_msr(MSR_IA32_PERF_CAPABILI=
TIES);

[Severity: Medium]
Will this unconditional MSR read cause an assertion failure on older kernel=
s?

When running the selftest on a host kernel prior to 5.9, KVM does not
expose MSR_IA32_PERF_CAPABILITIES as a feature MSR. Calling
kvm_get_feature_msr() unconditionally in test_intel_counters() causes the
underlying ioctl to fail and return 0, which triggers an assertion failure
rather than skipping the feature gracefully.

Other MSR accesses in this file appear to be guarded by checking
kvm_has_perf_caps first. Could we apply a similar check before reading
advertised_perf_caps so the test remains compatible with older environments?

>  	u8 pmu_version =3D kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
>  	unsigned int i;
>  	u8 v;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918193937.5694=
14-1-zide.chen@intel.com?part=3D8
