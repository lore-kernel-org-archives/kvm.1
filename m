Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6781B4F09
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981627; cv=none; b=i2k1mjhe9iU7V2Di4NcIIhu+hOcudIzTmZaRC7dz/7e8pFZuY+begrL+cZxg3HWi9FHDJc+qC6AqwUezE4pCXblJRv4KmIGP6958R4zTrFlIJ03sKu97M/Vyy75DyHKpB9TCdcZK/fTNUsWda2pfFLFWwswkrmlZfh+9aS8hvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981627; c=relaxed/simple;
	bh=wp1cI4JqethnfeJBAv9VYYrNPSEiVo70Q0FgrmiWx70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DSX3MPV9E34fjPyqIWiV+pI4TM7+8q35ZUBL3RJBYu5mRoDGgKV5/Fo42qmXst1i79GS9GCiKSSaN1ReB76Hlu/XzyTUO5S25/dHNNKsEIJc5jhpdbDft1fJZju28Ogv+DF9fN7TYQNOmQ0wNe1rVTBD2jLGPJBOTnXZFBX8xmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBL3bFAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBL3bFAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCCA1F000E9;
	Thu, 28 May 2026 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779981626;
	bh=5uTHx2R1r95EW3vYQM0NZ0VLLq5qCGIUHQi4X1D1yMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jBL3bFAvjohv3oQE1v59lyeQjcdHSCxdXcDwjjJBBpiBn05NnwrxDUKmektnMS5JB
	 1hECUBE31oH9VnGiIWRjo/5IhWpQrPaHY3eJmR7dbAdy+2NYwWi9kJjkr7nH9ESccr
	 QXgKhQFgiREW4HUASuBEMFTSS9Xtqi4XHqMjztVUj/eDAF4TK4IA1L3JD132YTj98S
	 HgKVFU2Rr4iju2YAaQhVG3wPewHUfDV2H+OifTA4xsdJ5DM6DkOXuXpREQAWe/FA4l
	 ByTIkJqCiQcyaRHjK1FXfuMNo+XdF2LGD5FvN5SnGbYj4sc0MEeNOlPrv1+FsAJWnf
	 DvjB6uJ9sYrQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] KVM: selftests: loongarch: Add PV TLB flush
 performance test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cuitao@kylinos.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528133558.2196416-5-cuitao@kylinos.cn>
References: <20260528133558.2196416-5-cuitao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 15:20:26 +0000
Message-Id: <20260528152026.8CCCA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The newly added test file `pv_tlb_flush_test.c` is not registere=
d in the selftests Makefile.
- [Medium] Stack buffer overflow due to unvalidated command-line arguments =
determining thread counts.
- [Medium] Out-of-bounds write and undefined behavior due to calling `CPU_S=
ET` with a negative CPU index.
- [Low] Unchecked `pthread_create` return value may lead to undefined behav=
ior in `pthread_join`.
--

commit 58f366ce7cadb24e8c149ba70d5b875582d7aad6
Author: Tao Cui <cuitao@kylinos.cn>

KVM: selftests: loongarch: Add PV TLB flush performance test

This commit adds a multi-threaded benchmark to measure PV TLB flush
performance inside LoongArch KVM guests by spawning flusher threads
that repeatedly mmap/munmap alongside idle threads.

[Severity: Medium]
It looks like this patch adds pv_tlb_flush_test.c but doesn't add it to any
selftests Makefile (e.g., TEST_GEN_PROGS). Will the build system ignore this
file completely during make or make install?

> diff --git a/tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c b/=
tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c
> new file mode 100644
> index 0000000000000..b799dc4873939
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c
[ ... ]
> +static void pin_cpu(int cpu) {
> +    cpu_set_t set;
> +    CPU_ZERO(&set);
> +    CPU_SET(cpu, &set);
> +    sched_setaffinity(0, sizeof(set), &set);
> +}
[ ... ]
> +int main(int argc, char **argv) {
> +    int nr_flush =3D 1, nr_idle =3D 3, i, run;
> +    int ncpus =3D sysconf(_SC_NPROCESSORS_ONLN);
> +    if (argc > 1) nr_flush =3D atoi(argv[1]);
> +    if (argc > 2) nr_idle =3D atoi(argv[2]);
[ ... ]
> +    for (run =3D 0; run < 3; run++) {
> +        int total =3D nr_flush + nr_idle;
> +        int do_pin =3D (total <=3D ncpus);
> +        pthread_t threads[64];
> +        unsigned long results[64];
> +        int completed[64];
> +        struct thread_args args[64];

[Severity: Medium]
Is there a risk of a stack buffer overflow here if the tool is run with lar=
ge
arguments?

Since nr_flush and nr_idle are parsed directly from argv via atoi() without
upper bounds checking, if they sum to more than 64, the initialization loops
could write past the end of these arrays.

> +        start_barrier =3D 0; stop_flag =3D 0;
> +
> +        for (i =3D 0; i < nr_idle; i++) {
> +            args[i].cpu =3D do_pin ? nr_flush + i : -1;
> +            args[i].result =3D NULL;
> +            args[i].completed =3D NULL;
> +            pthread_create(&threads[i], NULL, idle_thread, &args[i]);

[Severity: Medium]
Could this lead to out-of-bounds writes when do_pin is false?

If total exceeds ncpus, do_pin is 0, and args[i].cpu is set to -1. The thre=
ad
function then calls pin_cpu() which executes CPU_SET(-1, &set). Passing a
negative index to CPU_SET results in an out-of-bounds array access that can
corrupt the stack.

[Severity: Low]
Does this code handle thread creation failures?

If pthread_create() fails, the corresponding element in the threads array
remains uninitialized. The code later unconditionally calls pthread_join() =
on
all expected thread indices, passing the uninitialized pthread_t values, wh=
ich
might cause undefined behavior.

> +        }
> +        for (i =3D 0; i < nr_flush; i++) {
> +            int idx =3D nr_idle + i;
> +            results[idx] =3D 0;
> +            completed[idx] =3D 0;
> +            args[idx].cpu =3D do_pin ? i : -1;
> +            args[idx].result =3D &results[idx];
> +            args[idx].completed =3D &completed[idx];
> +            pthread_create(&threads[idx], NULL, flush_thread, &args[idx]=
);
> +        }
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528133558.2196=
416-1-cuitao@kylinos.cn?part=3D4
