Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917EC1339B1;
	Wed, 13 May 2026 06:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652388; cv=none; b=d+7WAlv77fdFWNRkUDEBVPU1Ncj0ek4W9k69abJ4KnsyDSQASDgvASgY3tN2Uxf6iHg+I2sw1WkN7+/J6iLwyUCLJMa1JAJJ562ijOLGzU4ibygbf1VC63AuPIZjkNjsLwkkR8yG4dkXqudDI75ISe+fdXI/rlhgOETaHVDQGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652388; c=relaxed/simple;
	bh=zk+jyEY+gvdAJSWh+sBXT03TINreZu3ay8x4kAlMhRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVTItul4erJxF1/GVyJwyaJieEjXB9VjRQU6juPaRW1qATZfmHzF4TKmbnfEPxBZLYoae8T1thF3L4DI23faQdlXlIoxoJkOKDvrV3Vmq/0x7awUDCviH1fUD1gLLQ11gg8f5S6AlxwS4ieyjJw0hDGlCg9lms7JibsTfO76pQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/FAgAGM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/FAgAGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34381C2BCB7;
	Wed, 13 May 2026 06:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778652388;
	bh=zk+jyEY+gvdAJSWh+sBXT03TINreZu3ay8x4kAlMhRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/FAgAGM0l58W+Z92pbTYUvV+bqtfoF4TUZrVpuU0wNm68hp1U04Vfkrurb/AkWoT
	 yiAadgZNKkLKtxvU2hpfRpneeQ7Q9P92rgx3t0tsDjXqZt1e0Ff3bjtlJDv/T/EtsI
	 CD8IGCk1cACSkG9B79Em9o1Y88TIEkufhhZqVBPiT6B6sWCf3my/6SsbniJbud8zWC
	 yoqlSx8hyZjHfgLJxRKFej6Wawv5eC2RMlPPdiviq4oKjEm+dSUALDaJmAlmTdzfqH
	 HctYJ78TjNxdW+KNSk2wM7CiCq5VbaBUCD9PGDS58v4bLhMLrvzNdFvkrQ9GqlyJOj
	 lW0rSVETiyLDQ==
Date: Wed, 13 May 2026 09:06:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@kernel.org,
	ljs@kernel.org, surenb@google.com, vbabka@kernel.org,
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net,
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com,
	jthoughton@google.com, aarcange@redhat.com, sj@kernel.org,
	usama.arif@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 13/14] selftests/mm: add userfaultfd RWP tests
Message-ID: <agQU2c2b3VqpYRdi@kernel.org>
References: <cover.1778254670.git.kas@kernel.org>
 <e097db49bd0ada5f3c22f9c98c548c3b8ca24ba7.1778254670.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e097db49bd0ada5f3c22f9c98c548c3b8ca24ba7.1778254670.git.kas@kernel.org>

On Fri, May 08, 2026 at 04:55:25PM +0100, Kiryl Shutsemau (Meta) wrote:
> Coverage for UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT:
> 
>   rwp-async          async mode — touch pages, verify permissions are
>                      auto-restored without a message
>   rwp-sync           sync mode — access blocks, handler resolves via
>                      UFFDIO_RWPROTECT
>   rwp-pagemap        PAGEMAP_SCAN reports still-cold pages via
>                      inverted PAGE_IS_ACCESSED
>   rwp-mprotect       RWP survives mprotect(PROT_NONE) ->
>                      mprotect(PROT_READ|PROT_WRITE) round-trip
>   rwp-gup            GUP walks through a protnone RWP PTE (pipe
>                      write/read drives the GUP path)
>   rwp-async-toggle   UFFDIO_SET_MODE flips between sync and async
>                      without re-registering
>   rwp-close          closing the uffd restores page permissions
>   rwp-fork           RWP survives fork() with EVENT_FORK; child's
>                      PTEs keep the uffd bit
>   rwp-fork-pin       RWP survives fork() on an RO-longterm-pinned
>                      anon page (forces copy_present_page()); child
>                      read auto-resolves and clears the bit, proving
>                      PAGE_NONE was in place
>   rwp-wp-exclusive   register with MODE_WP|MODE_RWP returns -EINVAL
> 
> All tests run against anon, shmem, shmem-private, hugetlb, and
> hugetlb-private memory, except rwp-fork-pin which is anon-only —
> copy_present_page() is the private-anon pinned-exclusive fork path.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  tools/testing/selftests/mm/uffd-unit-tests.c | 774 +++++++++++++++++++
>  1 file changed, 774 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 6f5e404a446c..a35fb677e4cc 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -7,6 +7,7 @@
>  
>  #include "uffd-common.h"
>  
> +#include <linux/fs.h>
>  #include "../../../../mm/gup_test.h"
>  
>  #ifdef __NR_userfaultfd
> @@ -167,6 +168,23 @@ static int test_uffd_api(bool use_dev)
>  		goto out;
>  	}
>  
> +	/* Verify returned fd-level ioctls bitmask */
> +	{
> +		uint64_t expected_ioctls =

can be const uint64_t and declared at the top of the function to avoid
extra indentation here.

> +			BIT_ULL(_UFFDIO_REGISTER) |
> +			BIT_ULL(_UFFDIO_UNREGISTER) |
> +			BIT_ULL(_UFFDIO_API) |
> +			BIT_ULL(_UFFDIO_SET_MODE);
> +
> +		if ((uffdio_api.ioctls & expected_ioctls) != expected_ioctls) {
> +			uffd_test_fail("UFFDIO_API missing expected ioctls: "
> +				       "got=0x%"PRIx64", expected=0x%"PRIx64,
> +				       (uint64_t)uffdio_api.ioctls,
> +				       expected_ioctls);
> +			goto out;
> +		}
> +	}
> +
>  	/* Test double requests of UFFDIO_API with a random feature set */
>  	uffdio_api.features = BIT_ULL(0);
>  	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == 0) {

...

> +static void uffd_rwp_pagemap_test(uffd_global_test_opts_t *gopts,
> +					  uffd_test_args_t *args)
> +{
> +	unsigned long nr_pages = gopts->nr_pages;
> +	unsigned long page_size = gopts->page_size;
> +	unsigned long p;
> +	struct page_region regions[16];
> +	struct pm_scan_arg pm_arg;
> +	int pagemap_fd;
> +	long ret;

...

> +	/*
> +	 * PAGE_IS_ACCESSED is set once the uffd-wp bit has been cleared
> +	 * (access happened, or the user resolved). Invert it to select
> +	 * still-protected (cold) pages.
> +	 */
> +	memset(&pm_arg, 0, sizeof(pm_arg));
> +	pm_arg.size = sizeof(pm_arg);
> +	pm_arg.start = (uint64_t)gopts->area_dst;
> +	pm_arg.end = (uint64_t)gopts->area_dst + nr_pages * page_size;
> +	pm_arg.vec = (uint64_t)regions;
> +	pm_arg.vec_len = 16;

ARRAY_SIZE(regions)?

> +	pm_arg.category_mask = PAGE_IS_ACCESSED;
> +	pm_arg.category_inverted = PAGE_IS_ACCESSED;
> +	pm_arg.return_mask = PAGE_IS_ACCESSED;
> +
> +}
> +
> +/*
> + * Test that RWP protection survives a mprotect(PROT_NONE) ->
> + * mprotect(PROT_READ|PROT_WRITE) round-trip. The uffd-wp bit on a
> + * VM_UFFD_RWP VMA must continue to carry PROT_NONE semantics after
> + * mprotect() changes the base protection; otherwise accesses would
> + * silently succeed and the pagemap bit would stick without a fault
> + * ever clearing it.
> + */
> +static void uffd_rwp_mprotect_test(uffd_global_test_opts_t *gopts,
> +				   uffd_test_args_t *args)
> +{
> +	unsigned long nr_pages = gopts->nr_pages;
> +	unsigned long page_size = gopts->page_size;
> +	unsigned long p;
> +	struct page_region regions[16];
> +	struct pm_scan_arg pm_arg;
> +	int pagemap_fd;
> +	long ret;

...

> +	memset(&pm_arg, 0, sizeof(pm_arg));
> +	pm_arg.size = sizeof(pm_arg);
> +	pm_arg.start = (uint64_t)gopts->area_dst;
> +	pm_arg.end = (uint64_t)gopts->area_dst + nr_pages * page_size;
> +	pm_arg.vec = (uint64_t)regions;
> +	pm_arg.vec_len = 16;

ARRAY_SIZE(regions)?

> +	pm_arg.category_mask = PAGE_IS_ACCESSED;
> +	pm_arg.category_inverted = PAGE_IS_ACCESSED;
> +	pm_arg.return_mask = PAGE_IS_ACCESSED;
> +
> +	ret = ioctl(pagemap_fd, PAGEMAP_SCAN, &pm_arg);
> +	close(pagemap_fd);
> +
> +	if (ret < 0) {
> +		uffd_test_fail("PAGEMAP_SCAN failed: %s", strerror(errno));
> +		return;
> +	}
> +	if (ret != 0) {
> +		uffd_test_fail("expected no cold pages after mprotect()+touch, got %ld regions",
> +			       ret);
> +		return;
> +	}
> +
> +	uffd_test_pass();
> +}
> +
> +/*
> + * Test that GUP resolves through protnone PTEs (async mode).
> + * RW-protect pages, then use a pipe to exercise GUP on the RW-protected
> + * memory. write() from RW-protected pages triggers GUP which must fault
> + * through the protnone PTE.
> + */
> +static void uffd_rwp_gup_test(uffd_global_test_opts_t *gopts,
> +				     uffd_test_args_t *args)
> +{
> +	unsigned long page_size = gopts->page_size;
> +	char *buf;
> +	int pipefd[2];
> +
> +	buf = malloc(page_size);
> +	if (!buf)
> +		err("malloc");
> +
> +	/* Populate first page with known content */
> +	memset(gopts->area_dst, 0xCD, page_size);
> +
> +	if (uffd_register_rwp(gopts->uffd, gopts->area_dst, page_size))
> +		err("register failure");
> +
> +	rwprotect_range(gopts->uffd, (uint64_t)gopts->area_dst, page_size, true);
> +
> +	if (pipe(pipefd))
> +		err("pipe");
> +
> +	/*
> +	 * write() from the RW-protected page into the pipe. This triggers
> +	 * GUP on the protnone PTE; in async mode the kernel auto-restores
> +	 * permissions and GUP succeeds. One byte is enough to exercise
> +	 * the GUP path and avoids any concern about pipe buffer sizing on
> +	 * large-page archs.
> +	 */
> +	if (write(pipefd[1], gopts->area_dst, 1) != 1) {
> +		uffd_test_fail("write from RW-protected page failed: %s",
> +			       strerror(errno));
> +		goto out;
> +	}

Sashiko (https://sashiko.dev/#/patchset/cover.1778254670.git.kas%40kernel.org?part=13):

	Could this write() implementation be bypassing the intended test
	logic?
	... the write() call here will trigger standard hardware page
	faults during copy_from_user() rather than the intended
	get_user_pages() code path.

It also suggests to use vmsplice().

> +
> +	if (read(pipefd[0], buf, 1) != 1) {
> +		uffd_test_fail("read from pipe failed");
> +		goto out;
> +	}
> +
> +	if (buf[0] != (char)0xCD) {
> +		uffd_test_fail("content mismatch: got 0x%02x, expected 0xCD",
> +			       (unsigned char)buf[0]);
> +		goto out;
> +	}
> +
> +	uffd_test_pass();
> +out:
> +	close(pipefd[0]);
> +	close(pipefd[1]);
> +	free(buf);
> +}
> +
> +/*
> + * Test runtime toggle between async and sync modes.
> + * Start in async mode (detection), flip to sync (eviction), verify faults
> + * block, resolve them, flip back to async.
> + */
> +static void uffd_rwp_async_toggle_test(uffd_global_test_opts_t *gopts,
> +					      uffd_test_args_t *args)
> +{
> +	unsigned long nr_pages = gopts->nr_pages;
> +	unsigned long page_size = gopts->page_size;
> +	struct uffd_args uargs = { };
> +	pthread_t uffd_mon;
> +	bool started = false;
> +	char c = '\0';
> +	unsigned long p;
> +
> +	uargs.gopts = gopts;
> +	uargs.handle_fault = uffd_handle_rwp_fault;
> +
> +	/* Populate */
> +	for (p = 0; p < nr_pages; p++)
> +		memset(gopts->area_dst + p * page_size, p % 255 + 1, page_size);
> +
> +	if (uffd_register_rwp(gopts->uffd, gopts->area_dst,
> +			  nr_pages * page_size))
> +		err("register failure");
> +
> +	/* Phase 1: async detection — RW-protect, access first half */
> +	rwprotect_range(gopts->uffd, (uint64_t)gopts->area_dst,
> +			 nr_pages * page_size, true);
> +
> +	for (p = 0; p < nr_pages / 2; p++) {
> +		volatile char *page = gopts->area_dst + p * page_size;
> +		(void)*page;  /* auto-resolves in async mode */
> +	}
> +
> +	/* Phase 2: flip to sync for eviction */
> +	set_async_mode(gopts->uffd, false);
> +
> +	/* Start handler — will receive faults for cold pages */
> +	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &uargs))
> +		err("uffd_poll_thread create");
> +	started = true;
> +
> +	/* Access second half (cold pages) — should trigger sync faults */
> +	for (p = nr_pages / 2; p < nr_pages; p++) {
> +		unsigned char *page = (unsigned char *)gopts->area_dst +
> +				      p * page_size;
> +		if (page[0] != (p % 255 + 1)) {
> +			uffd_test_fail("page %lu content mismatch", p);
> +			goto out;
> +		}
> +	}
> +
> +	/*
> +	 * Stop the handler before reading minor_faults: the last fault
> +	 * resolution rwprotect_range()s before incrementing the counter,
> +	 * so the main thread can race ahead of the increment. Stopping
> +	 * here also makes Phase 3 a clean async-only test -- with the
> +	 * handler still running it would silently resolve any sync fault
> +	 * the kernel erroneously delivers, masking a regression.
> +	 */
> +	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
> +		err("pipe write");
> +	if (pthread_join(uffd_mon, NULL))
> +		err("join() failed");
> +	started = false;

I think 'started' is misleading, would "running_sync_test" better?

> +
> +	if (uargs.minor_faults == 0) {
> +		uffd_test_fail("expected sync faults, got 0");
> +		goto out;
> +	}

And it seems here we can just return and then started is not needed at
all.

> +
> +	/* Phase 3: flip back to async */
> +	set_async_mode(gopts->uffd, true);
> +
> +	/* RW-protect and access again — should auto-resolve */
> +	rwprotect_range(gopts->uffd, (uint64_t)gopts->area_dst,
> +			 nr_pages * page_size, true);
> +
> +	for (p = 0; p < nr_pages; p++) {
> +		volatile char *page = gopts->area_dst + p * page_size;
> +		(void)*page;
> +	}
> +
> +	uffd_test_pass();
> +out:
> +	if (started) {
> +		if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
> +			err("pipe write");
> +		if (pthread_join(uffd_mon, NULL))
> +			err("join() failed");
> +	}
> +}

-- 
Sincerely yours,
Mike.
