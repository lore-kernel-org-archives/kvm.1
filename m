Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96909401A02
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737211; cv=none; b=iRYJZIJ8JqnaezS/tsxrNPe2ckjnKkdjfzYopZg5Xz81DP4roF0fsEsxswFxkYSKAeZ77l+too8wFbS/fgA5cwdAiqvzFkdBZRY1RKQ9y/yKdXlm95p/fRafPbsUETnuMH1Ta7tmesOECnlF+duCT+o+ryF90BJaN6nVnkwfhFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737211; c=relaxed/simple;
	bh=oqs48+9jvkfY0hzwcO8iHhu99xBifqyRccT+3wCiQWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U7Ace5Ys3rHJ6u0HDQ6w0VgkDmFbf2B3BhYYkHmaB91f58x+pun1EcfFRmRQg6Y6Gx1cOtg+2i67qXg80Yoam6z68CdH7Fvme5g/2yS9HppoXAiZib5wd67/pbiaqQLOC3WaJTizlCJoFN69l/1flA8ACezls5Ae4qBRawGHgRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+QoKviq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+QoKviq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2978E1F000E9;
	Mon, 29 Jun 2026 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782737210;
	bh=RvQpt0HBZUo3VZf2hvBTnU83Yr4q/rewCVYAxbY445w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y+QoKviq/l0FClJJ+s2MsQoI74dR7MMFiAp0QchjtW6pw9NuR32nI87YbH93JZQUE
	 D0nOihUOh8H+yjc3lycDlObrxTUYTozVctBUhbBsb+mln15izxvmfx1cK+D25Fd1qh
	 f636VtyHH6cC3cjXi1WrMNXGYqhXbdUfV7WDuXBrsDMYsrXgRyr46MlXDipGOkKru+
	 LnANMOLP6WSscx+lF8vvesmVNeEnI/YkGzoay4+AnlV/jf2Gg/QiE6i62snl6YnUoU
	 7hDcZAWCy5nUDt7vNE11cvy+Q4kZLQZ2I7sOWSpCsKmkFVZLul7rzWpXMzbSkGEt1j
	 GiiJ7sGkGQRlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/15] selftests/mm: add userfaultfd RWP tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629120749.566063-15-kirill@shutemov.name>
References: <20260629120749.566063-1-kirill@shutemov.name>
 <20260629120749.566063-15-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 12:46:49 +0000
Message-Id: <20260629124650.2978E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] Dereferencing a `void *` pointer causes a compilation error in s=
elftests.
- [Medium] Impossible PAGEMAP_SCAN condition causes `rwp-mprotect` test to =
vacuously pass.
- [Medium] `rwp-mprotect` test will falsely pass if `mprotect()` completely=
 strips the uffd-wp marker.
- [Medium] `rwp-fork-pin` test will falsely pass if the uffd-wp marker is n=
ot inherited by the child.
- [Low] Uninitialized stack memory read when PAGEMAP_SCAN returns 0 regions.
--

commit 636eb23e25c814d00a52fbe1a8d08dc386ad4472
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

selftests/mm: add userfaultfd RWP tests

This commit adds several tests for UFFDIO_REGISTER_MODE_RWP and
UFFDIO_RWPROTECT to the userfaultfd selftests. It covers async and sync
modes, PAGEMAP_SCAN, mprotect round-trips, GUP, and fork interactions.

> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing=
/selftests/mm/uffd-unit-tests.c
> index a6c14109e8188..8c49191835ea1 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
[ ... ]
> @@ -602,6 +617,687 @@ void uffd_minor_collapse_test(uffd_global_test_opts=
_t *gopts, uffd_test_args_t *
[ ... ]
> +static void uffd_rwp_pagemap_test(uffd_global_test_opts_t *gopts,
> +					  uffd_test_args_t *args)
> +{
[ ... ]
> +	if (ret !=3D 1 || regions[0].start !=3D start ||
> +	    regions[0].end !=3D boundary) {
> +		uffd_test_fail("hot set wrong: got %ld regions [0x%lx,0x%lx), expected=
 1 [0x%lx,0x%lx)",
> +			       ret, (unsigned long)regions[0].start,
> +			       (unsigned long)regions[0].end,
> +			       (unsigned long)start, (unsigned long)boundary);
> +		return;
> +	}

[Severity: Low]
Will this evaluate uninitialized array elements if PAGEMAP_SCAN returns 0?

The regions array is uninitialized, so if ret =3D=3D 0, the kernel won't po=
pulate
regions[0]. The check ret !=3D 1 is true, which leads to reading
regions[0].start and regions[0].end in the failure message, printing
undefined stack data.

> +
> +	uffd_test_pass();
> +}
[ ... ]
> +static void uffd_rwp_mprotect_test(uffd_global_test_opts_t *gopts,
> +				   uffd_test_args_t *args)
> +{
[ ... ]
> +	/* Round-trip mprotect(): PROT_NONE -> PROT_READ|PROT_WRITE */
> +	if (mprotect(gopts->area_dst, nr_pages * page_size, PROT_NONE))
> +		err("mprotect() PROT_NONE");
> +	if (mprotect(gopts->area_dst, nr_pages * page_size,
> +		     PROT_READ | PROT_WRITE))
> +		err("mprotect() PROT_READ|PROT_WRITE");
> +

[Severity: Medium]
Should the test verify the uffd-wp marker's presence immediately after the
mprotect round-trip, before touching the pages?

If a kernel bug causes mprotect to overwrite the PTE and clear the uffd-wp
marker completely, the subsequent memory access will succeed without a fault
and set the hardware accessed bit. A later scan for cold pages would still
find 0 pages, allowing the test to falsely pass.

> +	/* Touch every page. Async RWP must auto-resolve each fault. */
> +	for (p =3D 0; p < nr_pages; p++) {
> +		volatile char *page =3D gopts->area_dst + p * page_size;
> +		(void)*page;
> +	}
> +
> +	/*
> +	 * After touching, no page should remain RW-protected. A stuck
> +	 * uffd-wp bit would mean mprotect() silently dropped PROT_NONE and
> +	 * the access never faulted.
> +	 */
> +	pagemap_fd =3D open("/proc/self/pagemap", O_RDONLY);
> +	if (pagemap_fd < 0)
> +		err("open pagemap");
> +
> +	memset(&pm_arg, 0, sizeof(pm_arg));
> +	pm_arg.size =3D sizeof(pm_arg);
> +	pm_arg.start =3D (uint64_t)gopts->area_dst;
> +	pm_arg.end =3D (uint64_t)gopts->area_dst + nr_pages * page_size;
> +	pm_arg.vec =3D (uint64_t)regions;
> +	pm_arg.vec_len =3D ARRAY_SIZE(regions);
> +	pm_arg.category_mask =3D PAGE_IS_ACCESSED;
> +	pm_arg.category_inverted =3D PAGE_IS_ACCESSED;

[Severity: Medium]
Does this create an impossible PAGEMAP_SCAN condition?

The test sets pm_arg.category_mask to PAGE_IS_ACCESSED, which requires the
bit to be set, but also sets pm_arg.category_inverted to PAGE_IS_ACCESSED,
requiring the bit to be clear.

This impossible condition will cause PAGEMAP_SCAN to always return 0 region=
s.
Since the test passes if ret =3D=3D 0, it will silently pass regardless of =
the
actual page state, missing regressions.

> +	pm_arg.return_mask =3D PAGE_IS_ACCESSED;
> +
> +	ret =3D ioctl(pagemap_fd, PAGEMAP_SCAN, &pm_arg);
> +	close(pagemap_fd);
[ ... ]
> +static void uffd_rwp_fork_test(uffd_global_test_opts_t *gopts,
> +			       uffd_test_args_t *args)
> +{
> +	unsigned long nr_pages =3D gopts->nr_pages;
> +	unsigned long page_size =3D gopts->page_size;
> +	int pagemap_fd;
> +	uint64_t value;
> +
> +	if (uffd_register_rwp(gopts->uffd, gopts->area_dst,
> +			      nr_pages * page_size))
> +		err("register failed");
> +
> +	/* Populate + RWP-protect */
> +	*gopts->area_dst =3D 1;

[Severity: Medium]
Will this cause a compilation error?

The area_dst field in uffd_global_test_opts_t is a void pointer.
Dereferencing a void pointer directly violates C semantics and will cause an
invalid use of void expression error.

Should this be cast to char * or volatile char * first?

> +	rwprotect_range(gopts->uffd, (uint64_t)gopts->area_dst,
> +			page_size, true);
[ ... ]
> +static void uffd_rwp_fork_pin_test(uffd_global_test_opts_t *gopts,
> +				   uffd_test_args_t *args)
> +{
> +	unsigned long page_size =3D gopts->page_size;
> +	fork_event_args fevent_args =3D { .gopts =3D gopts, .child_uffd =3D -1 =
};
> +	pin_args pin_args =3D {};
> +	int pagemap_fd, status;
> +	pthread_t fevent_thread;
> +	uint64_t value;
> +	pid_t child;
> +
> +	if (uffd_register_rwp(gopts->uffd, gopts->area_dst, page_size))
> +		err("register failed");
> +
> +	/* Populate. */
> +	*gopts->area_dst =3D 1;

[Severity: Medium]
Will this also cause a compilation error due to dereferencing a void pointe=
r,
similar to the instance in uffd_rwp_fork_test?

> +
> +	/* RO-longterm pin so fork() takes copy_present_page() for this PTE. */
> +	if (pin_pages(&pin_args, gopts->area_dst, page_size)) {
[ ... ]
> +	child =3D fork();
> +	if (child < 0)
> +		err("fork");
> +	if (child =3D=3D 0) {
> +		volatile char c;
> +		int cfd;
> +
> +		/*
> +		 * Read the pinned page. Only reaches the fault path if the
> +		 * child PTE is protnone + uffd; async mode auto-resolves and
> +		 * clears the uffd bit. If copy_present_page() dropped
> +		 * PAGE_NONE, the read would silently succeed and the bit
> +		 * would still be set.
> +		 */
> +		c =3D *(volatile char *)gopts->area_dst;

[Severity: Medium]
Should the child assert that the PM_UFFD_WP bit is set before performing th=
is
read?

If a kernel bug causes fork to fail to copy the uffd-wp marker to the child,
the read here will succeed without a fault, and the bit will already be
clear. The child will exit 0, and the test will falsely pass, masking a
potential regression in copy_present_page().

> +		(void)c;
> +
> +		cfd =3D pagemap_open();
> +		value =3D pagemap_get_entry(cfd, gopts->area_dst);
> +		close(cfd);
> +		_exit((value & PM_UFFD_WP) ? 1 : 0);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629120749.5660=
63-1-kirill@shutemov.name?part=3D14
