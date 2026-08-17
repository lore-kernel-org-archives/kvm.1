Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE20340280
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786993074; cv=none; b=RqaIs9ZfwRnHXdp1DjcdzOzoYokCzp6JBSZ9VJz7UVyht6YpqvMQOyfNTMkVkI3VL2Vk2T1JVOYvLeNkJ2FwvKvmO/srmwG3++Bl/VIZ63Gb7rrbTOs8tiVo4iGwTEm74F4lY6JDh+rYApwEyIemBtwwl9pKLqqxTjE81aZE3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786993074; c=relaxed/simple;
	bh=egmA9exPVNOMULm/4yYyTjHvLNp+l0NQWIiGQeSAsqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FFn/C+NQfwi31pmNZv/Qqe8OkO7eesbLvSM+SWyIha+WcVrJUX7VPML/2KlM6wXtfI/cXK6jjG3/4EBreeq9MUKYZVie5C3lLigEuB2djhT8qnylKFICAv+cj0NVcfgQk/W1ZqYMCFrPpQEgScklXacUE71RUrFlr9sOOsIiaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3h13urf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3h13urf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605521F00A3A;
	Mon, 17 Aug 2026 18:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786993073;
	bh=Ri5AiNhZXHMzPDoA6P4Ud+Pf14qy/yTM6+Zf2kv+vb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y3h13urfbMD9ILeqm4DpPdZ5LpZEXW0kPM0ONsNtMnhQ7AjiUdAZZO7tpOny3OzYK
	 iMx3APFDVJLcU1oZj+9D6gA3wJYVslH8YOiXwNieRavFvS3w31723RJEORaE1g+9Km
	 /B6Zrfk/0up/EXkDzSAVBU6wwNYUlzEeQXcJid6LFkymwrBfu2LUtdBzkhyBRdM3r6
	 gnmzAdmi1XXtPP66W8iPJt5uAqBX/Hj3JGUR7hevt2mTP3QZvDjgECMRhEHvbf7i+E
	 1jT1CdZK9KrPOffVHscTCEbGgHxtT2bFFR6Enaj3cFEALYreh0NMT2HTZKDSMWdKbY
	 jz3+31KrjFLQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 8/8] KVM: selftests: Add PERF_METRICS and fixed
 counter 3 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260817183143.226156-9-zide.chen@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-9-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 18:57:52 +0000
Message-Id: <20260817185753.605521F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unhandled #GP / Selftest Crash when writing 0xdeaddead to MSR_PE=
RF_METRICS.
--

--- Patch [8]: [PATCH v8 8/8] KVM: selftests: Add PERF_METRICS and fixed co=
unter 3 tests ---
commit 19d6869fac1fbdcc63ff54623403cec33b922848
Author: Zide Chen <zide.chen@intel.com>

KVM: selftests: Add PERF_METRICS and fixed counter 3 tests

This commit adds a test case to exercise IA32_PERF_METRICS for Topdown
(TMA) Level 1 metrics and extends the PMU selftest to cover Intel fixed
counter 3.

> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/=
testing/selftests/kvm/x86/pmu_counters_test.c
> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
[ ... ]
> +static void __guest_test_perf_metrics(void)
> +{
[ ... ]
> +	/* Sanity check after PERF_METRICS disabled. */
> +	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
> +	wrmsr(MSR_PERF_METRICS, 0xdeaddead);
> +
> +	guest_test_rdpmc(INTEL_RDPMC_METRICS, true, 0xdeaddead);
> +}

[Severity: Medium]
Will this wrmsr(MSR_PERF_METRICS, 0xdeaddead) cause an unhandled #GP and
crash the selftest on hosts with Mediated PMU pass-through?

Writing an architecturally invalid non-zero value to MSR_PERF_METRICS
generates a #GP on real hardware. Under Mediated PMU, KVM configures the
VMCS to pass-through MSR accesses directly to hardware, so this fault
would be injected into the guest.

If the hardware silently discards the write instead of faulting, will the
subsequent guest_test_rdpmc() assertion fail because it expects to read back
0xdeaddead, while the hardware holds the previous value?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817183143.2261=
56-1-zide.chen@intel.com?part=3D8
