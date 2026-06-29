Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29E3D1AB7
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782776709; cv=none; b=WzlJS2EopnSvqgfd+/kIVl3gFsdp9jEUsn6iQZTG57BIF5QCHxN926ct/9Lb+NO0fIEYyoCP+FVWSSR4ukbNZbguhLdnchg9dmTKP5EqsKYp3x4HZL/dRwDsMgphDdASkmmBap/VmfvKln+nKIlKsdvtJDdNrmeRgFGiLS7ukjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782776709; c=relaxed/simple;
	bh=u91mt2pWY/QeS7R/L7ePKxehGUjzRZq9qGfr1+oSNbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P0rZJ5LH0nzkuPa3a31+pGD/jkRM8HI16v7N1Rjhn100yheSoBHYq8evQ1nvLekaKjqkIp6YIrVKh8NP/nrPRg96cAmWz8JkxlsH78qSwrOfZ9yMbgyc1DxUqCz9oGeagwCuXBzfuAazhktfaHcS87UIhvYZs0iKIQyzY81lb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMWhljAd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMWhljAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE3C1F000E9;
	Mon, 29 Jun 2026 23:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782776708;
	bh=N80gBL6usKaD42ewhw7dJwtbXJUJTkFe5DTCdVNlKK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QMWhljAdtXbm1k2xSPDGWrFQuSHyCuqNUyld3uZ0UXcGIMX4X8768gUcd2Lniw4ju
	 f6QPZeOfQKh10cnpJCFCNZdsCBBTumIvibPcWf1BT5wfFiQaoBOy6+0+fp2LykLh1c
	 rOjB5KMiZteTOlA9qd6clnN3VVKTBKf2leWHq+o75SFKUv8UlETzQRMvN713TQcCmq
	 5xKFtzmon9Sxv6+sLV8DDxC/nO2xKS2oK2nbCMDXTSbMfHeHvIUATGz8iJO7KUB8eS
	 COTozJNy9YXshwKaYqcLFYTW+U83ojzjOPoAWgY4lVFPk5CbdQ0ZBkYl0Is2I7bHH4
	 pNfO7wjx8OfzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/8] KVM: selftests: Add PERF_METRICS and fixed
 counter 3 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629231938.15129-9-zide.chen@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-9-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 23:45:07 +0000
Message-Id: <20260629234508.0DE3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added test for PERF_METRICS writes a non-zero value (0=
xdeaddead) to MSR_PERF_METRICS and expects to read it back verbatim, which =
violates Intel's architectural rules and will cause a #GP exception on hard=
ware.
--

commit 35ae6d43235ee910691fc703d1aee89a9dbe653a
Author: Zide Chen <zide.chen@intel.com>

KVM: selftests: Add PERF_METRICS and fixed counter 3 tests

This patch adds a test case to exercise IA32_PERF_METRICS, verifying
architectural support for Topdown Level 1 metrics. It also extends the
PMU selftest to cover Intel fixed counter 3 by bumping the max fixed
counters and validating basic functionality.

> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/=
testing/selftests/kvm/x86/pmu_counters_test.c
> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
[ ... ]
> @@ -318,6 +322,75 @@ static void guest_test_arch_event(u8 idx)
>  				FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
>  }
> =20
> +static void __guest_test_perf_metrics(void)
> +{
[ ... ]
> +	/* Sanity check after PERF_METRICS disabled. */
> +	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
> +	wrmsr(MSR_PERF_METRICS, 0xdeaddead);
> +
> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), 0xdeaddead);
> +}

[Severity: Medium]
Will this write to MSR_PERF_METRICS cause a #GP exception on hardware?

According to the Intel SDM, software should only write 0 to clear the metri=
cs,
and writing a non-zero value like 0xdeaddead may trigger a general protecti=
on
fault.=20

If this occurs on a host where MSR_PERF_METRICS writes are passed through
to the physical CPU, could it cause the guest to crash with an unhandled
#GP(0) exception and fail the selftest?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629231938.1512=
9-1-zide.chen@intel.com?part=3D8
