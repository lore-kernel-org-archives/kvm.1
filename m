Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C72036E9
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539187; cv=none; b=HpMn0USsMPY6iT4Mf+RLrkzUusz6nn8z/v7DaQRCCAtTpY4Iq3/QQPSGPCIYlJvtFAGo7uBv05RyUUqXM7H3k70LAKAKIHqTWwxT8j7RuoQEuKyxkfiPAs6IoHAcRCURRun1P0pnMUq+La5IAUYxNoFvURFnqhaPxnUBtwJQROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539187; c=relaxed/simple;
	bh=ZPDMmz6X2SY5BqpVXlQikPXuaGwbYBCl3Hs4tWTQN3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R7dbqECZeiHHO11a5VgEoJdmcfwaW1n2Ya6ZkZUJzUn712Rbki6uuRbRBrwiwXdYL0Krd2rIkTtWV37ggtWhfuNdZJEp5cYQcgPtjZUrzT2TyrQy8QlSQlHHpuFulmg0CrzmoMx3XR/uVZm1OYVvxlnyYRd7wzpHcOxrnway2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHEX2jtD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHEX2jtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0F91F00893;
	Thu,  4 Jun 2026 02:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539186;
	bh=aWLQTNtnKlIGjvz20YvAWXmo/bvTiYdd2X2MNatrWuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bHEX2jtDERri2V10ixNBM8QjpmIXtJBGTTl09Ip4yvwAgYSRiXcqivm16cVcLQGrr
	 l2bTJUwU1+aQlWFpRdeVIEwRcCaNEVAtYWWnV4CwkoT8YkPCvtB3ZX5Y14oDmjBTcX
	 a6dl3nC+xxanjmWjrQz78EaRhEQS++hsfxjudb2LbOGorXbhIeJ8TxrjxWfxklKUpB
	 fEfYJA3HfCCoutUOF3WW9SL7XnyoZ5GKhDXLzGS0TvAw3G596Sz0wyIDOppA91P/H2
	 RC7DDmA0BMPr/uA0//e+n9VT6/k1rf+fLmnodUfcPetvq/sYWAdlZnNhLEiOjQGBKo
	 7cXrAoSUDGy8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/21] KVM: selftests: Verify interrupts are received
 when IRQ affinity changes in IRQ test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604020143.748245-11-jrhilke@google.com>
References: <20260604020143.748245-11-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:13:05 +0000
Message-Id: <20260604021306.4A0F91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test incorrectly assumes contiguous CPU topologies when gene=
rating random CPU IDs and ignores `fflush()` errors, leading to silent fail=
ures and buffered write accumulation.
--

commit a578bd3957ea3e342b8ed83cc29e669f1b6658b8
Author: David Matlack <dmatlack@google.com>

KVM: selftests: Verify interrupts are received when IRQ affinity changes in=
 IRQ test

This commit adds the '-a' flag to tools/testing/selftests/kvm/irq_test.c to
randomly affinitize the device's host IRQ to different physical CPUs
throughout the test. This stresses the kernel's ability to maintain correct
interrupt routing and delivery.

> diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selft=
ests/kvm/irq_test.c
> index 5b42d8abd1ea0..90cff165c3512 100644
> --- a/tools/testing/selftests/kvm/irq_test.c
> +++ b/tools/testing/selftests/kvm/irq_test.c
[ ... ]
> @@ -187,12 +199,23 @@ int main(int argc, char **argv)
[ ... ]
>  	for (i =3D 0; i < nr_irqs; i++) {
>  		struct kvm_vcpu *vcpu =3D vcpus[i % nr_vcpus];
>  		struct timespec start;
> =20
>  		kvm_route_msi(vm, gsi, vcpu, vector);
> =20
> +		if (irq_affinity_fp) {
> +			irq_cpu =3D kvm_random_u64(&kvm_rng) % get_nprocs();
> +			write_proc_irq_smp_affinity_list(irq_affinity_fp, irq, irq_cpu);
> +		}

[Severity: Medium]
Will using get_nprocs() here generate invalid CPU IDs on systems with
sparse or non-contiguous CPU topologies?

For example, if only CPUs 0 and 2 are online, get_nprocs() returns 2,
which means the modulo operation could generate an irq_cpu of 1, targeting
an offline or invalid CPU.

Writing an invalid CPU ID fails with -EINVAL, but it looks like
write_proc_irq_smp_affinity_list() uses fprintf(), which only buffers the
data in userspace.

If fflush() returns an error that goes unchecked, could the glibc buffer
retain the unwritten malformed string? Since irq_affinity_fp is reused
across loop iterations, this might cause all subsequent affinity changes to
accumulate and silently fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604020143.7482=
45-1-jrhilke@google.com?part=3D10
