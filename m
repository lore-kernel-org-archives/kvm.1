Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448801;
	b=0uPenOHL7csP1/swfgy18bpTUn/xQoAyGOsnUmXuwG/h+ytGnu4EpsGC2P4hAUojCBOC
	 m51KzxlT1IIdNtRmHCPGGMnK6tJkZxfDpDNVXRzY5LIsPooTbRaWQRnVt4QLgMwtcf4MI
	 H/4ICl32eDC3YbAbQT3U5ttfWLjQZJaz3Ohvm293xbmJZHAQS4vJbRBKP2YspoKZpuQMV
	 U2Ot+pMpo0t/II3F+FldaWd6JeM/tbqnPHyNyzEi+/WCClKjG+YX2ht/wusZf2g6/kvfG
	 /GoeCttVVOMKbjXw/1hR4Iela/7LujIe5zPHJ8uje8+qxryfhdE5OZzeYQ+AIrltYxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448801;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TLNJy0uDMYYUVjV658enbXvf5JRt2m8GBU3yXJI/t+U=;
	b=32fucmOoiAVLi1xl3u1D9kEE/6uCqcwwbgzM+dWKknXJ0ouf8Bj7bTfEE5ZzDW4nFIA7
	 IvHiAvfP7reDlDILNgeBvgdUj4EgXct1+/+ABvLiCnEBJQR30sri0IZ1mGR/YCpD9Sji+
	 oHc6h1l7JNzkHq0eUBo2c9k6ivK1oHAwz1ZFJRMB5Z8foUWn6h/8GLR9z6lth22zlJXNl
	 nOz3FIdKmEsel1yDGLKDkrbZOnczA5GxfAoQHW6qMjLTb/YJW9zQoVExkOhWYTW2oelen
	 dCQXE8C/sO9WuOVxgyVoEUWm4H9zgU5ecyQSJFE3VyFdE60wZOTJhljNdXqBKJZ3XRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDFVBHKX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59492606A31E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDFVBHKX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227131F000CA;
	Mon, 23 Nov 2026 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795448801;
	bh=TLNJy0uDMYYUVjV658enbXvf5JRt2m8GBU3yXJI/t+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HDFVBHKXRZwhNVnISaZJrGquFnEAsonPbO35WfG1oAKaRMdOvkO/SPtzaLOwwgx5L
	 8zmh17G8RZDGj0eadRp9H09cLKkmQjToK1qIGDposOBM7qQNMZY7f0wVze8wicLa87
	 DzB9vEQOTtALVY+leBPBtqoYczVFJzrWjbjoZuZqOS606iwPNbb27FvfYmvkfSQVy/
	 ajfwCUZnwmn2UZAodw3Z/ABhTvf407DAxG4CEQDMqAFNKYN0/RbhkH5NbEpXDF4Bdc
	 pbLHR0aql+PES2lv3tOVD6BwfsTBXlrOmBPvYanakcoCurkHflw1CCEYOsWdhrNrZS
	 7EgtfHMEaHxcQ==
Message-ID: <sashiko-outbox-229603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: Test dirty ring pushes from vCPU
 preemption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Mishra" <smish149@asu.edu>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261123153238.1036972-3-smish149@asu.edu>
References: <20261123153238.1036972-1-smish149@asu.edu>
 <20261123153238.1036972-3-smish149@asu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 15:46:40 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] KVM: selftests: duplicate CPU pinning, pthread, and atoi helpers
- [Low] KVM: selftests: 60-second default runtime in
  dirty_ring_steal_time_test
--

commit ed3801d4ab73947519efff505ae4499cdb0daaef
Author: Siddharth Mishra <smish149@asu.edu>

KVM: selftests: Test dirty ring pushes from vCPU preemption

This commit adds an x86 KVM selftest that exercises dirty ring pushes when
a vCPU thread flushing its PML buffer is preempted and updates its
steal-time structure in a dirty-logged memslot.

> diff --git a/tools/testing/selftests/kvm/x86/dirty_ring_steal_time_test.c=
 b/tools/testing/selftests/kvm/x86/dirty_ring_steal_time_test.c
> new file mode 100644
> index 0000000000000..6e65055e8c2dc
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/dirty_ring_steal_time_test.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#define _GNU_SOURCE
> +#include <pthread.h>
> +#include <sched.h>
> +#include <stdlib.h>
> +#include <time.h>
> +#include <unistd.h>
> +#include <asm/barrier.h>
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "ucall_common.h"
> +
> +#define TEST_SLOT		1
> +#define TEST_GPA		0x10000000ul
> +#define TEST_PAGES		16384
> +#define RING_ENTRIES		65536u
> +#define DEFAULT_SECONDS		60

[Severity: Low]
Is a 60-second default runtime too long for a test in TEST_GEN_PROGS_x86?

Because the test is added to TEST_GEN_PROGS_x86 in Makefile.kvm, default
kselftest runs will spin two threads on one CPU for a full minute, using
half of the 120-second timeout in tools/testing/selftests/kvm/settings.
Other race tests in TEST_GEN_PROGS_x86 (such as x86/xapic_ipi_test.c,
x86/recalc_apic_map_test.c, and x86/xen_shinfo_test.c) default to 2-5
seconds and rely on a command-line flag for longer stress runs.

[ ... ]

> +static void pin_self(int cpu)
> +{
> +	cpu_set_t set;
> +
> +	CPU_ZERO(&set);
> +	CPU_SET(cpu, &set);
> +	TEST_ASSERT(!pthread_setaffinity_np(pthread_self(), sizeof(set), &set),
> +		    "Failed to pin to CPU %d", cpu);
> +}

[ ... ]

> +	while ((opt =3D getopt(argc, argv, "c:t:S")) !=3D -1) {
> +		switch (opt) {
> +		case 'c':
> +			test_cpu =3D atoi(optarg);
> +			break;
> +		case 't':
> +			seconds =3D atoi(optarg);
> +			break;

[ ... ]

> +	pin_self(test_cpu);
> +
> +	vm =3D __vm_create(VM_SHAPE_DEFAULT, 1, 0);

[ ... ]

> +	ring =3D vcpu_map_dirty_ring(vcpu);
> +	TEST_ASSERT(!pthread_create(&thread, NULL, hog, NULL),
> +		    "Failed to create hog thread");

[ ... ]

> +	WRITE_ONCE(stop_hog, true);
> +	pthread_join(thread, NULL);
> +	kvm_vm_free(vm);
> +	return 0;
> +}

[Severity: Low]
This isn't a bug, but several helpers here duplicate existing KVM selftest
utilities already pulled in via kvm_util.h:

- pin_self() duplicates pin_self_to_cpu() in kvm_util.h.
- atoi(optarg) for -c and -t skips input validation that
  atoi_non_negative() and atoi_positive() in test_util.h provide (for
  example, rejecting a negative CPU index before passing it to CPU_SET()).
- __vm_create(VM_SHAPE_DEFAULT, 1, 0) can use vm_create(1), and the raw
  pthread_create() and pthread_join() calls can use kvm_pthread_create()
  and kvm_pthread_join() from kvm_syscalls.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123153238.1036=
972-1-smish149@asu.edu?part=3D2
