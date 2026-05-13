Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8037838F24F;
	Wed, 13 May 2026 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653589; cv=none; b=qJVoTf7zcnXwjqomvGDO+iBV4Y+vbEZjcGg+T2NPkiqNGGFooSZYgbKGkRxUjG0jANDYMrfs0EtkXOMQkKbTn8QdeznsDwkQQwpluU7FDTkU0yKzezsm9HDxHLjVvmtAL+JxTajJjrNPaVVtIYmYslavkBsMrybLAVa5YNNjvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653589; c=relaxed/simple;
	bh=WRpCesEyBqP6szFtxr6if4BD3NBtaZqRj0HEyWLq85g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGVgxSllZt041ZcUdwuBFGknka3Iz8fwygpSb7BqFLlMzSRNXBP5fgIrc0lmCM4g/9xs/cAdjxe1xDg2SqSDkbgOcal7jGmYxtS/FCVfCyedSigav5ahtj4CZtufGNi+Ek2NAMgzL0K1XTTuPpaIOMKQnG9O+bVy/klN/t7TfB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9OLqzUv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9OLqzUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D003BC2BCB7;
	Wed, 13 May 2026 06:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778653589;
	bh=WRpCesEyBqP6szFtxr6if4BD3NBtaZqRj0HEyWLq85g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9OLqzUvX0tw1qb7cvP+RqpcTbSFYfOSwUQiPhtM0FCh7ggToRkJ9KWVECh6QyNrr
	 AwVlLbA3L1dgMhtpsln6j89GeOYCbyMi7f/NWCtnPi90igPZCjiXIJjJubmupOzJj8
	 5Us6DZSWTSnjpruKgHgYMmOEBYj8OPzb4mUVdzrex2pDJ1/MCpF9r6b1VEXJZ7VMgs
	 t3885zHJ2kuf3YV1NkAUx5VC7gKNY/FaPF2bXUKnyKz0iYlkq+QnNHjvBTx0Vgyw9T
	 HZ1N5Y8/TuYzDKqsRAhxLegJK8V9P59kh+yp0HCH2Iqx23aP/iszLHhioMJKNlBpsE
	 06hF/4v5TjSZQ==
Date: Wed, 13 May 2026 09:26:17 +0300
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
Subject: Re: [PATCH v2 14/14] Documentation/userfaultfd: document RWP working
 set tracking
Message-ID: <agQZiTUQNviaGIim@kernel.org>
References: <cover.1778254670.git.kas@kernel.org>
 <0b6f87fd4809245f9eebee73f34e2fb14230330c.1778254670.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b6f87fd4809245f9eebee73f34e2fb14230330c.1778254670.git.kas@kernel.org>

On Fri, May 08, 2026 at 04:55:26PM +0100, Kiryl Shutsemau (Meta) wrote:
> Add an admin-guide section covering UFFDIO_REGISTER_MODE_RWP:
> 
>   - sync and async fault models;
>   - UFFDIO_RWPROTECT semantics;
>   - UFFD_FEATURE_RWP_ASYNC;
>   - UFFDIO_SET_MODE runtime mode flips.
> 
> It also covers typical VMM working-set-tracking workflow from detection
> loop through sync-mode eviction and back to async.

We'd also need man page update at some point :)
 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  Documentation/admin-guide/mm/userfaultfd.rst | 226 ++++++++++++++++++-
>  1 file changed, 220 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 1e533639fd50..5ac4ae3dff1b 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -275,16 +275,16 @@ tracking and it can be different in a few ways:
>    - Dirty information will not get lost if the pte was zapped due to
>      various reasons (e.g. during split of a shmem transparent huge page).
>  
> -  - Due to a reverted meaning of soft-dirty (page clean when uffd-wp bit
> -    set; dirty when uffd-wp bit cleared), it has different semantics on
> -    some of the memory operations.  For example: ``MADV_DONTNEED`` on
> +  - Due to a reverted meaning of soft-dirty (page clean when the uffd bit
> +    is set; dirty when the uffd bit is cleared), it has different semantics
> +    on some of the memory operations.  For example: ``MADV_DONTNEED`` on
>      anonymous (or ``MADV_REMOVE`` on a file mapping) will be treated as
> -    dirtying of memory by dropping uffd-wp bit during the procedure.
> +    dirtying of memory by dropping the uffd bit during the procedure.
>  
>  The user app can collect the "written/dirty" status by looking up the
> -uffd-wp bit for the pages being interested in /proc/pagemap.
> +uffd bit for the pages being interested in /proc/pagemap.
>  
> -The page will not be under track of uffd-wp async mode until the page is
> +The page will not be under track of userfaultfd-wp async mode until the page is
>  explicitly write-protected by ``ioctl(UFFDIO_WRITEPROTECT)`` with the mode
>  flag ``UFFDIO_WRITEPROTECT_MODE_WP`` set.  Trying to resolve a page fault
>  that was tracked by async mode userfaultfd-wp is invalid.
> @@ -307,6 +307,220 @@ transparent to the guest, we want that same address range to act as if it was
>  still poisoned, even though it's on a new physical host which ostensibly
>  doesn't have a memory error in the exact same spot.
>  
> +Read-Write Protection
> +---------------------
> +
> +``UFFDIO_REGISTER_MODE_RWP`` enables read-write protection tracking on a
> +memory range. It is similar to (but faster than) ``mprotect(PROT_NONE)``
> +combined with a signal handler; unlike ``mprotect(PROT_NONE)``, RWP only
> +traps accesses to *present* PTEs, so accesses to unpopulated addresses in a
> +protected range fall through to the normal missing-page path. It uses the
> +PROT_NONE hinting mechanism (same as NUMA balancing) to make pages
> +inaccessible while keeping them resident in memory. Works on anonymous,
> +shmem, and hugetlbfs memory.
> +
> +This is designed for VM memory managers that need to track the working set

This feature? Or RWP mode?

> +of guest memory for cold page eviction to tiered or remote storage.
> +
> +**Setup:**
> +
> +1. Open a userfaultfd and enable ``UFFD_FEATURE_RWP`` via ``UFFDIO_API``.
> +   Optionally request ``UFFD_FEATURE_RWP_ASYNC`` as well — it requires
> +   ``UFFD_FEATURE_RWP`` to be set in the same ``UFFDIO_API`` call.
> +
> +2. Register the guest memory range with ``UFFDIO_REGISTER_MODE_RWP``
> +   (and ``UFFDIO_REGISTER_MODE_MISSING`` if evicted pages will need to be
> +   fetched back from storage).
> +
> +**Feature availability:**
> +
> +RWP is built on top of two kernel primitives: a spare PTE bit owned by
> +userfaultfd (``CONFIG_HAVE_ARCH_USERFAULTFD_WP``) and arch support for

Please spell out architecture.

> +present-but-inaccessible PTEs (``CONFIG_ARCH_HAS_PTE_PROTNONE``). When both
> +are available on a 64-bit kernel, the build selects
> +``CONFIG_USERFAULTFD_RWP=y`` and the ``VM_UFFD_RWP`` VMA flag becomes
> +available.
> +
> +``UFFD_FEATURE_RWP`` and ``UFFD_FEATURE_RWP_ASYNC`` are masked out of the
> +features returned by ``UFFDIO_API`` when the running kernel or architecture
> +cannot support them — for example 32-bit kernels (where ``VM_UFFD_RWP`` is
> +unavailable), kernels built without ``CONFIG_USERFAULTFD_RWP``, and
> +architectures whose ptes cannot carry the uffd bit at runtime (e.g. riscv
> +without the ``SVRSW60T59B`` extension). ``UFFDIO_API`` does not fail;
> +unsupported bits are simply absent from ``uffdio_api.features`` on return.
> +VMMs should inspect the returned ``features`` after ``UFFDIO_API`` and fall

Lets s/VMM/Callers/.
Although RWP is designed for VMMs, it's not limited to them and I expect
other use-cases will be coming along.

> +back to another tracking method when RWP is unavailable.
> +
> +**Protecting and Unprotecting:**
> +
> +Use ``UFFDIO_RWPROTECT`` to protect or unprotect a range, mirroring the
> +``UFFDIO_WRITEPROTECT`` interface::
> +
> +    struct uffdio_rwprotect rwp = {
> +        .range = { .start = addr, .len = len },
> +        .mode = UFFDIO_RWPROTECT_MODE_RWP,  /* protect */
> +    };
> +    ioctl(uffd, UFFDIO_RWPROTECT, &rwp);
> +
> +Setting ``UFFDIO_RWPROTECT_MODE_RWP`` sets PROT_NONE on present PTEs in the
> +range. Pages stay resident and their physical frames are preserved — only
> +access permissions are removed.
> +
> +Clearing ``UFFDIO_RWPROTECT_MODE_RWP`` restores normal VMA permissions and
> +wakes any faulting threads (unless ``UFFDIO_RWPROTECT_MODE_DONTWAKE`` is set).
> +
> +**Scope of protection:**
> +
> +RWP protection is a property of *present* PTEs. ``UFFDIO_RWPROTECT`` only
> +affects entries that are already populated. Unpopulated addresses within
> +the range remain unpopulated; when first accessed they fault through the
> +normal missing path (``do_anonymous_page()``, ``do_swap_page()``,
> +``finish_fault()``) and the resulting PTE is not RWP-protected. To observe
> +the population itself, co-register the range with
> +``UFFDIO_REGISTER_MODE_MISSING``.
> +
> +Protection is preserved across page reclaim: a page swapped out while
> +RWP-protected carries the marker on its swap entry, and swap-in restores
> +the PROT_NONE state so the first access after swap-in still faults. The
> +same applies to pages temporarily replaced by migration entries.
> +
> +Operations that drop the PTE entirely — ``MADV_DONTNEED`` on anonymous
> +memory, hole-punch on shmem, truncation of a file mapping — also drop the
> +RWP marker: the next access re-populates the range without protection.
> +Unlike WP (which persists via ``PTE_MARKER_UFFD_WP``), there is no
> +persistent RWP marker today. The VMM needs to re-arm the range with

s/VMM/User/

> +``UFFDIO_RWPROTECT`` after any operation that explicitly frees PTEs.
> +
> +**Fault Handling:**
> +
> +When a protected page is accessed:
> +
> +- **Sync mode** (default): The faulting thread blocks and a
> +  ``UFFD_PAGEFAULT_FLAG_RWP`` message is delivered to the userfaultfd
> +  handler. The handler resolves the fault with ``UFFDIO_RWPROTECT``
> +  (clearing ``MODE_RWP``), which restores the PTE permissions and wakes
> +  the faulting thread.
> +
> +- **Async mode** (``UFFD_FEATURE_RWP_ASYNC``): The kernel automatically
> +  restores PTE permissions and the thread continues without blocking. No
> +  message is delivered to the handler.
> +
> +**Runtime Mode Switching:**
> +
> +``UFFDIO_SET_MODE`` toggles ``UFFD_FEATURE_RWP_ASYNC`` at runtime, allowing
> +the VMM to switch between lightweight async detection and safe sync
> +eviction without re-registering. The toggle takes ``mmap_write_lock()`` to
> +ensure all in-flight faults complete before the mode change takes effect.
> +
> +**Cold Page Detection with PAGEMAP_SCAN:**
> +
> +RWP-protected PTEs carry the uffd PTE bit; the fault-resolution path
> +clears it. ``PAGEMAP_SCAN`` reports ``PAGE_IS_ACCESSED`` once the bit is
> +clear on a ``VM_UFFD_RWP`` VMA, so inverting it efficiently reports the
> +still-protected (cold) pages::
> +
> +    struct pm_scan_arg arg = {
> +        .size = sizeof(arg),
> +        .start = guest_mem_start,
> +        .end = guest_mem_end,
> +        .vec = (uint64_t)regions,
> +        .vec_len = regions_len,
> +        .category_mask = PAGE_IS_ACCESSED,
> +        .category_inverted = PAGE_IS_ACCESSED,
> +        .return_mask = PAGE_IS_ACCESSED,
> +    };
> +    long n = ioctl(pagemap_fd, PAGEMAP_SCAN, &arg);
> +
> +The returned ``page_region`` array contains contiguous cold ranges that can
> +then be evicted.
> +
> +**Cleanup:**
> +
> +When the userfaultfd is closed or the range is unregistered, all PROT_NONE
> +PTEs are automatically restored to their normal VMA permissions. This
> +prevents pages from becoming permanently inaccessible.
> +
> +**VMM Working Set Tracking Workflow:**
> +
> +A typical VMM lifecycle for cold page eviction to tiered storage. Two
> +mappings of the same shmem (or hugetlbfs) file are used: ``guest_mem`` is
> +the RWP-registered mapping that vCPUs access through, and ``io_mem`` is a
> +private mapping for VMM-side I/O. Reading ``io_mem`` does not go through
> +the RWP-protected PTEs of ``guest_mem``, so the VMM's own ``pwrite()``
> +never traps on its own ::
> +
> +    /* One-time setup */
> +    fd = memfd_create("guest", MFD_CLOEXEC);
> +    ftruncate(fd, guest_size);
> +    guest_mem = mmap(NULL, guest_size, PROT_READ | PROT_WRITE,
> +                     MAP_SHARED, fd, 0);  /* vCPU view, RWP-registered */
> +    io_mem    = mmap(NULL, guest_size, PROT_READ | PROT_WRITE,
> +                     MAP_SHARED, fd, 0);  /* VMM I/O view, unprotected */
> +
> +    uffd = userfaultfd(O_CLOEXEC | O_NONBLOCK);
> +    ioctl(uffd, UFFDIO_API, &(struct uffdio_api){
> +        .api = UFFD_API,
> +        .features = UFFD_FEATURE_RWP | UFFD_FEATURE_RWP_ASYNC,
> +    });
> +    ioctl(uffd, UFFDIO_REGISTER, &(struct uffdio_register){
> +        .range = { guest_mem, guest_size },
> +        .mode = UFFDIO_REGISTER_MODE_RWP |
> +                UFFDIO_REGISTER_MODE_MISSING,
> +    });
> +
> +    /* Tracking loop */
> +    while (vm_running) {
> +        /* 1. Detection phase (async — no vCPU stalls) */
> +        ioctl(uffd, UFFDIO_RWPROTECT, &(struct uffdio_rwprotect){
> +            .range = full_range,
> +            .mode = UFFDIO_RWPROTECT_MODE_RWP });
> +        sleep(tracking_interval);
> +
> +        /* 2. Find cold pages (uffd bit still set) */
> +        ioctl(pagemap_fd, PAGEMAP_SCAN, &(struct pm_scan_arg){
> +            .category_mask = PAGE_IS_ACCESSED,
> +            .category_inverted = PAGE_IS_ACCESSED,
> +            .return_mask = PAGE_IS_ACCESSED,
> +            ...
> +        });
> +
> +        /* 3. Switch to sync for safe eviction */
> +        ioctl(uffd, UFFDIO_SET_MODE,
> +              &(struct uffdio_set_mode){
> +                  .disable = UFFD_FEATURE_RWP_ASYNC });
> +
> +        /* 4. Evict cold pages (vCPU faults block on guest_mem) */
> +        for each cold range:
> +            /* Read from io_mem -- bypasses RWP, no fault. */
> +            pwrite(storage_fd, io_mem + cold_offset, len, offset);
> +            /* Drop the page from the shared file. */
> +            fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +                      cold_offset, len);
> +            /*
> +             * Wake any vCPU blocked on the RWP fault for this range:
> +             * fallocate() does not iterate ctx->fault_pending_wqh.
> +             */
> +            ioctl(uffd, UFFDIO_WAKE, &(struct uffdio_range){
> +                .start = (uintptr_t)guest_mem + cold_offset,
> +                .len = len });
> +
> +        /* 5. Resume async tracking */
> +        ioctl(uffd, UFFDIO_SET_MODE,
> +              &(struct uffdio_set_mode){
> +                  .enable = UFFD_FEATURE_RWP_ASYNC });
> +    }
> +
> +During step 4, a vCPU that accesses ``guest_mem + cold_offset`` blocks
> +with a ``UFFD_PAGEFAULT_FLAG_RWP`` fault while the eviction is in
> +progress. After ``fallocate()`` punches the page out and ``UFFDIO_WAKE``
> +fires, the vCPU retries the access, faults as ``MISSING``, and the
> +handler resolves it with ``UFFDIO_COPY`` from storage.
> +
> +This workflow targets shmem and hugetlbfs (both support a private
> +``io_mem`` mapping over the same fd). Anonymous-memory backings need a
> +different inner-loop strategy because the VMM has no way to read the
> +page without going through the RWP-protected mapping.
> +
>  QEMU/KVM
>  ========
>  
> -- 
> 2.51.2
> 

-- 
Sincerely yours,
Mike.
