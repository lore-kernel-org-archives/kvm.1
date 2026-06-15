Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE73C5526
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512167; cv=none; b=c0y3QVNQ07WVQIXrpHlahG8k4mbOe3bVQUwaB7sWvdS0ZtaFfEV752XxB2T3LHl4mFl+YIkoKEbOSaQdp68ktOXU0LkCczQhYMJGGALv97xCFB6pK2upPUjUr6sRM2gTy97dbZ2uNTHFfCU00z7uayQbDf+8zHn6hHbBEomWjhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512167; c=relaxed/simple;
	bh=NIxgb9FP9mTIXb2z3wkuDUD65wNg4QT0c+b69QbcvM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dOIFfWTiDgD0uIH3DZN52r1BX8j/7nlw3lOpQPbAgAOiUM96hTjHz6gBlwY6s+Jh3/LBB3UtZlDnIHU+scuUfUBUyKLwgOANF5k5FeDLOG58xcNO7auQPdVNtS42tdsTecTPGcDxmLgHiavSE9qc4Ij7z5GGDjI3Rmdnsc8r4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+ANMfn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+ANMfn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6941F000E9;
	Mon, 15 Jun 2026 08:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781512164;
	bh=KmSgAnebXfkfsofG+Dj4OrfQN56OTz92g6qyB7YrP0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+ANMfn4yAZvIZc9tukvuFFlwGBmYey7u1aQGsC0ZXN6W6lbzI8CIgplrJV/pW7jN
	 uEF5I2Qn+uFJXJI4GXLKfW6FGMNgOXY/sPmmyH9nRUjfv7vGqcLY2pfJe3OrdLQ+yr
	 C8M9EHj07XMs7QeI9XSevc+QRoE/DgTEXFJWNlSfosHi1smQp0YlRXetT4bE63RjZv
	 z0jGvdTOyhjauSy5JVElS6gHqvqERyfv8E+0uuwxcf5dgZvoTguzuYRLPipg8rWwgX
	 LetswTzRda3pNap90+p5rVF6In+JTYEIq3fkkMJKX1aiL1MUNOxKE7F4EVFUxDbhNS
	 hqICQV2Alm0Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] KVM: selftests: loongarch: Add PV TLB flush
 performance test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260615082154.42144-4-cui.tao@linux.dev>
References: <20260615082154.42144-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 08:29:23 +0000
Message-Id: <20260615082923.EC6941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing Makefile integration for the new test file `pv_tlb_flush=
_test.c`.
- [Medium] Signed integer overflow in thread bounds check leads to stack bu=
ffer overflow.
--

commit 56616f9df639ca6715014c26c5864780ced6ff41
Author: Tao Cui <cuitao@kylinos.cn>

KVM: selftests: loongarch: Add PV TLB flush performance test

Add a multi-threaded benchmark to measure PV TLB flush performance
inside LoongArch KVM guests.

> diff --git a/tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c b/=
tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c
> new file mode 100644
> index 0000000000000..63efaf9ef1cd0
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * LoongArch PV TLB Flush Performance Test
> + *
> + * Measure the overhead of remote TLB flushes in a KVM guest by spawning
> + * flusher threads that repeatedly mmap/munmap (triggering TLB shootdown
> + * IPIs) alongside idle threads that either sleep or busy-spin.
> + *
> + * With PV TLB flush enabled, IPIs to preempted vCPUs are replaced by
> + * deferred flags in the steal-time shared page, reducing flush latency.
> + *
> + * Usage:
> + *   Compile on LoongArch guest:
> + *     gcc -O2 -static -pthread -o pv_tlb_flush_test pv_tlb_flush_test.c
> + *   Run (inside KVM guest):
> + *     ./pv_tlb_flush_test <flushers> <idle> <iterations> <busy_idle>

[Severity: Medium]
Since this test is provided as a standalone script and not added to the
selftests Makefile (e.g., TEST_PROGS or TEST_GEN_PROGS), will it be
missed during make install and automated test execution?

Also, is it intentional that this test bypasses the standard KVM selftests
framework (kvm_util) which typically provisions VMs and runs guest payloads
programmatically?

[ ... ]

> +int main(int argc, char **argv) {
> +    int nr_flush =3D 1, nr_idle =3D 3, i, run;
> +    int ncpus =3D sysconf(_SC_NPROCESSORS_ONLN);
> +    if (argc > 1) nr_flush =3D atoi(argv[1]);
> +    if (argc > 2) nr_idle =3D atoi(argv[2]);
> +    if (argc > 3) nr_iters =3D atoi(argv[3]);
> +    if (argc > 4) busy_idle =3D atoi(argv[4]);
> +
> +    if (nr_flush < 1 || nr_idle < 0 || nr_flush + nr_idle > MAX_THREADS)=
 {

[Severity: Medium]
Could this bounds check be bypassed if a user provides values that sum to a
value exceeding the 32-bit signed integer limit (e.g., nr_flush=3D1 and
nr_idle=3D2147483647)? The signed addition would overflow to a negative num=
ber.

If bypassed, would the program then loop nr_idle times and write out of
bounds to the stack-allocated arrays like threads and args in the loop belo=
w?

[ ... ]

> +        pthread_t threads[MAX_THREADS];
> +        unsigned long results[MAX_THREADS];
> +        int completed[MAX_THREADS];
> +        struct thread_args args[MAX_THREADS];
> +        start_barrier =3D 0; stop_flag =3D 0;
> +
> +        for (i =3D 0; i < nr_idle; i++) {
> +            args[i].cpu =3D do_pin ? nr_flush + i : -1;
> +            args[i].result =3D NULL;
> +            args[i].completed =3D NULL;
> +            if (pthread_create(&threads[i], NULL, idle_thread, &args[i])=
) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615082154.4214=
4-1-cui.tao@linux.dev?part=3D3
