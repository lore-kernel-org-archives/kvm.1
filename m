Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413A9364EA4
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368758; cv=none; b=UJS3ELpVyL6/xj0o65JwxjL4bCujd6SjgRcdFrnLWMFaMGVdWhevZEYVopSeVqHi1OvlJ0mzPadNp03RGOvfyNxfp03Zb3viTkhL6ZjOmorcdk8Cgm9Hv/yZ7dj7XE7+6D+w5MMaupWCSXfujx3Ri1siLsyUw/xIMCtvMuehYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368758; c=relaxed/simple;
	bh=cqbbgRmfcXn9lGk0h6YRMK+KxxzJoEthwgpHpBD1C74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oAIyXmmdVUyFkvW7onP2TLPH22HYTApgzodZFRfOhGokrvDB4hpP1WvdAKLSho7Z8sm3FExi3C+fOvyJV4HjAWsh/4d4Hf/5s2REbCmbab3Z35Zo94kaUHicDdWyuACf6JCZYfFBql8J9I9eq7DKmrMEhF8ZKIEFeQP/4uXoDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UixOhkJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UixOhkJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D231F00893;
	Tue,  2 Jun 2026 02:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780368756;
	bh=HaXK0Vtim3naOoRvGhv7tnlvTmNef3j6AXKreGz1mdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UixOhkJwtAFx50ob7cYyV+o15y0SDpwLyfqj3DSXSH0kurunFob18EjgUA6U8Zkry
	 +y4Zgz4El0KqPsQZpAyrWdqpvb5Dg/ygWrsdAwF1LIfEQ2ysSBeiPaKlil85mFCYZK
	 U/gocf/75aTttbM8Wv/e1zFJoOiL4O/NKnQy7hy3itH0PhplvPvWoCndkYRMJvmj55
	 fHPw7gaCthk81GQpCVo2gPKDIp8w+tKyvrbL8NuQTqOQg9ZfXjuoiN0x7XtRioDvcA
	 bM46p4Odr3/RypkXumvBc4cT9AQ3PB88m2Ckmhz4KL8dcCskvpyNqbNmbnTxUtRGL2
	 HylugX1uUyiDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] KVM: selftests: loongarch: Add PV TLB flush
 performance test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602021819.2373404-5-cui.tao@linux.dev>
References: <20260602021819.2373404-5-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 02:52:36 +0000
Message-Id: <20260602025236.C4D231F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Omission of new selftest file from the KVM selftests Makefile.
- [Medium] The test bypasses the automated KVM selftests framework and requ=
ires manual execution inside a guest OS.
- [Medium] Integer overflow during argument parsing leads to stack buffer o=
verflow.
--

commit 3eef713b92a18797245bf05fb771c17910daf380
Author: Tao Cui <cuitao@kylinos.cn>

KVM: selftests: loongarch: Add PV TLB flush performance test
   =20
Add a multi-threaded benchmark to measure PV TLB flush performance
inside LoongArch KVM guests.

> diff --git a/tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c b/=
tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c
> new file mode 100644
> index 0000000000000..63efaf9ef1cd0
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c

[Severity: Medium]
Is this test intentionally omitted from the build system Makefile?

According to the KVM selftests subsystem guidelines, any newly created test
file must be integrated into the test Makefile. Because this file is not
added to TEST_PROGS, TEST_GEN_PROGS, or TEST_FILES, the automated build
system completely ignores it and the test won't be compiled or installed
when make or make install is run.

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
Does this bypass the automated KVM selftests framework by requiring manual
execution inside a guest OS?

KVM selftests in tools/testing/selftests/kvm/ are designed as host-side
executables that programmatically create bare-metal micro-VMs to test KVM
ioctls.=20

This patch introduces a standalone POSIX user-space program (using pthreads
and the standard C library) that is explicitly designed to be manually
compiled and executed from within a full Linux guest OS. This fundamentally
violates the architectural model of the KVM selftests framework.

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
Can this bounds check suffer from integer overflow?

If a user supplies large positive numbers for nr_flush and nr_idle (e.g.,
2,000,000,000) parsed via atoi(), their sum could overflow into a negative
32-bit signed integer. This would bypass the MAX_THREADS check.

The subsequent for loops would then use the original large positive values
to iterate millions of times, writing far out of bounds on the 64-element
stack allocated arrays (threads, results, completed, args), corrupting
the stack.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602021819.2373=
404-1-cui.tao@linux.dev?part=3D4
