Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33147DF96;
	Sun, 20 Sep 2026 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941157; cv=none; b=bmfPxwYr7XLfWPiwTA0Iqy0MPwU6KaYtRxoTFlPBWlxxOvX6X1InpgFugsQHQHBBQKnx8x0gRdzZjWHOiJvf3oGMlCsMTMrgRx0lft5/hO5Vk57mVHsWpvzZUY6X0Y2j5kbtN8/esLZX5cLx14zXXyujJ9i073MIMokwNWA/SSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941157; c=relaxed/simple;
	bh=IyF6I9KLcog7pVpa0HnRNZwDLZheFTtIKxXETePtr5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gcpMmEcoX80wqlQ+EhYaHtZhgx2HKtDW4J2poAzXuqzkzRSV5Y3O12O4NOX7mCr+0Rj1w658oIjcsw4pYArRxOB6GvORXSVw18NF38AyTci0hSc9469ueYHtGucmRy4bBjlsBFWj5Wz9PEh0Mn31PwPG1WtXVLzqYnv/PdUQpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zey0Z+YM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zey0Z+YM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8101F000FF;
	Sun, 20 Sep 2026 21:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941150;
	bh=7cE4PXIzTIq437QoOKpSxPaPezbXHu295g3uHn2fslw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zey0Z+YM4IF7uwIQ2pYAupuYvbKCwPcFy4X87bGH3xQCfcp2bzTMBnu5cP193luqc
	 phCQtyQScrx1/MweeXsnoSFKo+C+ywpVxMFPPD5Qx/IJ2ghUsjo4DWI0o+UAdLUus3
	 UmLzjNGa3bvDuN6RRu0lA7LGLEbkDeFW7Zzmk7WmeFr/ePzyTWvhVYezo8ublnx9mo
	 eWH8ZjA4GwJYhk8C1AUNrYL1Uqhy52MTN12hJINvwSYSM+bQb6RN1Ye7R56IZTwVUa
	 cW/mwXHMdqivzg5MJf62XLLxtiCjkUtcqaRMte8L4xcLdUT3N/oDlIVyRRlUgrvg+9
	 1va9K/i2A+d4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/17] KVM: selftests: Add nested transition benchmark
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260920211920.928306-18-dwmw2@infradead.org>
References: <20260920211920.928306-1-dwmw2@infradead.org>
 <20260920211920.928306-18-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 21:52:29 +0000
Message-Id: <20260920215229.BA8101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: mismatch between commit message (100k) and code =
(10k) iterations
--

commit fe906ec5562df5e882aa5dfe67e35c886ebd82f2
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: selftests: Add nested transition benchmark

This commit adds a benchmark to measure L1 to L2 nested virtualization
transition costs. It tests the reflected-exit phase and an MSR-intercept
phase on SVM, reporting performance metrics from L1's perspective.

>     Measure L1<->L2 transition costs from L1's viewpoint, in TSC cycles:
>     a reflected-exit phase (cpuid in L2, forwarded to L1: the full
>     emulated vmexit->vmentry round trip, exercising the vmcb12/vmcs12
>     access paths), and on SVM an MSR-intercept phase (rdmsr in L2 with
>     INTERCEPT_MSR_PROT: exercises the per-intercept lookup in L1's MSR
>     permissions map). Reports min/avg/p50/p99/max over 100k iterations.

[Severity: Medium]
Is the iteration count in the commit message accurate? The message states
the benchmark reports over 100k iterations, but the code defines N_ITERS
as 10000 and explicitly notes that 10k samples is sufficient:

> diff --git a/tools/testing/selftests/kvm/x86/nested_transition_bench.c b/=
tools/testing/selftests/kvm/x86/nested_transition_bench.c
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/nested_transition_bench.c

[ ... ]

> +/*
> + * Keep the iteration count modest: every timed iteration includes a
> + * ucall round trip to userspace to report its sample, which on a
> + * debug (KASAN) kernel costs milliseconds. 10k samples still give a
> + * stable p99.
> + */
> +#define N_WARMUP	1000
> +#define N_ITERS		10000

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920211920.9283=
06-1-dwmw2@infradead.org?part=3D17
