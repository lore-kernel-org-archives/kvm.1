Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50E0391850;
	Fri, 29 May 2026 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075700; cv=none; b=SPjkMH9PdYJmcUwUgwDTUkqG+WW4bCTJAsfTYwhhhOfiUFUQVOlY/QJKrjgmRCpi+8PYNOeO6TH5pmxA8E3YyctZBiC1bLHtuNZyjApZCCiX7cLzyKHaCdYhbwOdtFERWYSoovb113/Y+mGcq+h8JVl6CgDdXShGDVLmPg1bZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075700; c=relaxed/simple;
	bh=ECJp/SwN+SvABQG3MNxZ61tl15iK0iHjERJkwYyNR4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTyRNGM9Ullm6EwK2jsgFRYT1IKIaArszy0Uzh/7CC0qsFCIi0+vKOPIBlls1JeaOvYNslId15TrOFQHzqnPRxraofc5iiqtO2yLwfB3MH4I1hVZPb/xn96SVEC3wvT32fRttbGLh67uWHmP4Y5OYPqw7RQCxOrYhYj6GEfSLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wzjt4seb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wzjt4seb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBCB1F00899;
	Fri, 29 May 2026 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075694;
	bh=MIQxxozRIu6+nnGJE0oJP6Nk3SNPcpDq2i+v8EPL78w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wzjt4sebkPZ6jVBhJa+W3B7qhYvkYj/u3xwrMJvT43wGuv3oysK0vjE38by/BDDSD
	 Muahw60ipDLwR4SVDM7YeuO6cRle2cbvGq0kkib51ZdYxCq/D89DVahF0tEOTX0zCc
	 nloBqyNqoS9ARUc0yG31esZOHcMpZ40I5MlWdKPFcaAEwgqF7FnOgNp8564XeLwTO3
	 pmZUBwg3ovZ+Z1s8E1eSWsy1zFRwfTrObhUnyKqQbP56SkVAbd9TFZbfN+L6TORNw/
	 RXxajWOwaPljfscjWU6VcADGdo3LkZJrszFo6Xkkem65TtNWSmWVOTId9dEoag8ckt
	 UcpOa8+uc5iLA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id EDF8FF4006F;
	Fri, 29 May 2026 13:28:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 29 May 2026 13:28:12 -0400
X-ME-Sender: <xms:rMwZagkKYcKQFFBKd_SWBB-aFCgt21IgrgJ3Zg9hPAKz3LqgmG81MQ>
    <xme:rMwZajyjy87xQU400APzCR8eCNX_j7uQwnOME_UKYT8CxWK--t4dTHa8wLvSdVLG_
    rtQwP6nPU3tu7VeIL0kD_DH_C7NkDo2rhFvXH18k2yNurCYt-qmI-U>
X-ME-Received: <xmr:rMwZanKoac070pK0WedjvyKZ6D7sYzcsAHEL1eFLGexcg44HML_8Pp40msCDlw>
X-ME-Proxy-Cause: dmFkZTGBi04+ZX5edMs6arnVhjz5oTtZuLX6rF9F7dBMO1f7bo0/ibgVknVxOLxLEaTw3V
    SP8XCWrfEIm+ORQdwtFgGmZbSjd5PWqHK7OyczVLOTkfernQnqiFyq/o6xwE8cbLWskv8V
    +iZNmtaHm6WeW6aqk5t6K7mKlErgu7aQt0UjXT2ADQ7mf9nBrz2Zxt+3DgC32qmbL5bfPS
    wp7fg604KU/dBYc/nC2f3KAKjHsrOYa0CCMIHhOSv9QOJzU1reEx7CzTRePC09oBWGnLrT
    o+Pu2UEaZ81TuKLWkyHIRAb9DY0C7evn8G3qQgUz8zVG7T+c5/VvKECJCsNluq96Jwivtj
    dSsiyOB9JK1+TqpuilG+0oS9Uz8ZJtNYcFKsnGxgHV/a00Q740eP/GqRi2+fD4HWViNz1N
    l1MUW3aPaBSPOJBJH4X1DAHkBkCWXUqal/HVx0w93oZbm+raHUlRozRwpFZ5gWcn0WjiVs
    /BHjthOcCrulBbD06r7frzLXf48yDnKzoh9G2ZWGjiLbqpOYQVglNT0r5bui58+iN0m2X+
    5boxVqkorYKY/H1175kziF5tVhhelAbabXyOQns2oz01ntmpZ2NT0KJLGVRJAn4Ms9FLOe
    zAedmCzLH+PXoATcn11B/eMhoIeBKJh/5BXhh1oQNTMgeTwD2qMp8P2YC86Q
X-ME-Proxy: <xmx:rMwZamI1R_qTlll5NroPbxMs3j6_hjQ5bu_i2p48ObJaMjSN0emiFA>
    <xmx:rMwZamUZaIv7ahaSN3Uj-OAdpYyvKmBP0Wl3X6Bq57S9a4N_nQSR3g>
    <xmx:rMwZauCfiODAsI2XUhnX-c_lnhOCEcjlsd-HhBtaVazmqWRbxrxFhg>
    <xmx:rMwZapF4QExaxQAp8tu2clyz44LbbZHUe9tMLuDQJWJeNYAGGyC_ag>
    <xmx:rMwZaqfKE6AbvOQQDCgjcoYl6dvm-8iW6P2GLfQ_Bg6kCQWkFSb9IT3t>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 13:28:12 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	david@kernel.org
Cc: ljs@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Liam.Howlett@oracle.com,
	ziy@nvidia.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	jthoughton@google.com,
	aarcange@redhat.com,
	sj@kernel.org,
	usama.arif@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kernel-team@meta.com,
	kas@kernel.org
Subject: [PATCH v6 15/15] Documentation/userfaultfd: document RWP working set tracking
Date: Fri, 29 May 2026 18:26:44 +0100
Message-ID: <20260529172716.357179-16-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529172716.357179-1-kas@kernel.org>
References: <20260529172716.357179-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an admin-guide section covering UFFDIO_REGISTER_MODE_RWP:

  - sync and async fault models;
  - UFFDIO_RWPROTECT semantics;
  - UFFD_FEATURE_RWP_ASYNC;
  - UFFDIO_SET_MODE runtime mode flips.

It also covers typical VMM working-set-tracking workflow from detection
loop through sync-mode eviction and back to async.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
 Documentation/admin-guide/mm/userfaultfd.rst | 243 ++++++++++++++++++-
 1 file changed, 237 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 1e533639fd50..2a72e54962c8 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -275,16 +275,16 @@ tracking and it can be different in a few ways:
   - Dirty information will not get lost if the pte was zapped due to
     various reasons (e.g. during split of a shmem transparent huge page).
 
-  - Due to a reverted meaning of soft-dirty (page clean when uffd-wp bit
-    set; dirty when uffd-wp bit cleared), it has different semantics on
-    some of the memory operations.  For example: ``MADV_DONTNEED`` on
+  - Due to a reverted meaning of soft-dirty (page clean when the uffd bit
+    is set; dirty when the uffd bit is cleared), it has different semantics
+    on some of the memory operations.  For example: ``MADV_DONTNEED`` on
     anonymous (or ``MADV_REMOVE`` on a file mapping) will be treated as
-    dirtying of memory by dropping uffd-wp bit during the procedure.
+    dirtying of memory by dropping the uffd bit during the procedure.
 
 The user app can collect the "written/dirty" status by looking up the
-uffd-wp bit for the pages being interested in /proc/pagemap.
+uffd bit for the pages being interested in /proc/pagemap.
 
-The page will not be under track of uffd-wp async mode until the page is
+The page will not be under track of userfaultfd-wp async mode until the page is
 explicitly write-protected by ``ioctl(UFFDIO_WRITEPROTECT)`` with the mode
 flag ``UFFDIO_WRITEPROTECT_MODE_WP`` set.  Trying to resolve a page fault
 that was tracked by async mode userfaultfd-wp is invalid.
@@ -307,6 +307,237 @@ transparent to the guest, we want that same address range to act as if it was
 still poisoned, even though it's on a new physical host which ostensibly
 doesn't have a memory error in the exact same spot.
 
+Read-Write Protection
+---------------------
+
+``UFFDIO_REGISTER_MODE_RWP`` enables read-write protection tracking on a
+memory range. It is similar to (but faster than) ``mprotect(PROT_NONE)``
+combined with a signal handler; unlike ``mprotect(PROT_NONE)``, RWP only
+traps accesses to *present* PTEs, so accesses to unpopulated addresses in a
+protected range fall through to the normal missing-page path. It uses the
+PROT_NONE hinting mechanism (same as NUMA balancing) to make pages
+inaccessible while keeping them resident in memory. Works on anonymous,
+shmem, and hugetlbfs memory.
+
+RWP is designed for VM memory managers that need to track the working set
+of guest memory for cold page eviction to tiered or remote storage.
+
+**Setup:**
+
+1. Open a userfaultfd and enable ``UFFD_FEATURE_RWP`` via ``UFFDIO_API``.
+   Optionally request ``UFFD_FEATURE_RWP_ASYNC`` as well — it requires
+   ``UFFD_FEATURE_RWP`` to be set in the same ``UFFDIO_API`` call.
+
+2. Register the guest memory range with ``UFFDIO_REGISTER_MODE_RWP``
+   (and ``UFFDIO_REGISTER_MODE_MISSING`` if evicted pages will need to be
+   fetched back from storage).
+
+**Feature availability:**
+
+RWP is built on top of two kernel primitives: a spare PTE bit owned by
+userfaultfd (``CONFIG_HAVE_ARCH_USERFAULTFD_WP``) and architecture support
+for present-but-inaccessible PTEs (``CONFIG_ARCH_HAS_PTE_PROTNONE``). When both
+are available on a 64-bit kernel, the build selects
+``CONFIG_USERFAULTFD_RWP=y`` and the ``VM_UFFD_RWP`` VMA flag becomes
+available.
+
+``UFFD_FEATURE_RWP`` and ``UFFD_FEATURE_RWP_ASYNC`` are unavailable when
+the running kernel or architecture does not support them — for example
+32-bit kernels (where ``VM_UFFD_RWP`` is unavailable), kernels built
+without ``CONFIG_USERFAULTFD_RWP``, and architectures whose ptes cannot
+carry the uffd bit at runtime (e.g. riscv without the ``SVRSW60T59B``
+extension). Requesting an unsupported feature in
+``uffdio_api.features`` makes ``UFFDIO_API`` fail with ``EINVAL`` and
+leaves the userfaultfd context uninitialized; the bitmask returned in
+``uffdio_api.features`` then advertises the features the kernel does
+support. The recommended probe sequence is therefore to open a
+throwaway userfaultfd, call ``UFFDIO_API`` once with ``features = 0``,
+inspect the returned bitmask, close that fd, then open the real one
+and call ``UFFDIO_API`` again with only the supported features set.
+
+**Protecting and Unprotecting:**
+
+Use ``UFFDIO_RWPROTECT`` to protect or unprotect a range, mirroring the
+``UFFDIO_WRITEPROTECT`` interface::
+
+    struct uffdio_rwprotect rwp = {
+        .range = { .start = addr, .len = len },
+        .mode = UFFDIO_RWPROTECT_MODE_RWP,  /* protect */
+    };
+    ioctl(uffd, UFFDIO_RWPROTECT, &rwp);
+
+Setting ``UFFDIO_RWPROTECT_MODE_RWP`` sets PROT_NONE on present PTEs in the
+range. Pages stay resident and their physical frames are preserved — only
+access permissions are removed.
+
+Clearing ``UFFDIO_RWPROTECT_MODE_RWP`` restores normal VMA permissions and
+wakes any faulting threads (unless ``UFFDIO_RWPROTECT_MODE_DONTWAKE`` is set).
+
+**Scope of protection:**
+
+RWP protection is a property of *present* PTEs. ``UFFDIO_RWPROTECT`` only
+affects entries that are already populated. Unpopulated addresses within
+the range remain unpopulated; when first accessed they fault through the
+normal missing path (``do_anonymous_page()``, ``do_swap_page()``,
+``finish_fault()``) and the resulting PTE is not RWP-protected. To observe
+the population itself, co-register the range with
+``UFFDIO_REGISTER_MODE_MISSING``.
+
+Protection is preserved across page reclaim: a page swapped out while
+RWP-protected carries the marker on its swap entry, and swap-in restores
+the PROT_NONE state so the first access after swap-in still faults. The
+same applies to pages temporarily replaced by migration entries.
+
+Operations that drop the PTE entirely — ``MADV_DONTNEED`` on anonymous
+memory, hole-punch on shmem, truncation of a file mapping — also drop the
+RWP marker: the next access re-populates the range without protection.
+Unlike WP (which persists via ``PTE_MARKER_UFFD_WP``), there is no
+persistent RWP marker today. The user needs to re-arm the range with
+``UFFDIO_RWPROTECT`` after any operation that explicitly frees PTEs.
+
+**Fault Handling:**
+
+When a protected page is accessed:
+
+- **Sync mode** (default): The faulting thread blocks and a
+  ``UFFD_PAGEFAULT_FLAG_RWP`` message is delivered to the userfaultfd
+  handler. The handler resolves the fault with ``UFFDIO_RWPROTECT``
+  (clearing ``MODE_RWP``), which restores the PTE permissions and wakes
+  the faulting thread.
+
+- **Async mode** (``UFFD_FEATURE_RWP_ASYNC``): The kernel automatically
+  restores PTE permissions and the thread continues without blocking. No
+  message is delivered to the handler.
+
+**Runtime Mode Switching:**
+
+``UFFDIO_SET_MODE`` toggles ``UFFD_FEATURE_RWP_ASYNC`` at runtime, allowing
+the VMM to switch between lightweight async detection and safe sync
+eviction without re-registering. The toggle takes ``mmap_write_lock()``
+and calls ``vma_start_write()`` on each UFFD-armed VMA, draining
+in-flight per-VMA-locked faults before the new mode takes effect.
+
+**Cold Page Detection with PAGEMAP_SCAN:**
+
+RWP-protected PTEs carry the uffd PTE bit; the fault-resolution path
+clears it. ``PAGEMAP_SCAN`` reports ``PAGE_IS_ACCESSED`` once the bit is
+clear on a ``VM_UFFD_RWP`` VMA, so inverting it efficiently reports the
+still-protected (cold) pages. Require ``PAGE_IS_PRESENT`` too so memory
+holes (which carry neither category bit) are filtered out::
+
+    struct pm_scan_arg arg = {
+        .size = sizeof(arg),
+        .start = guest_mem_start,
+        .end = guest_mem_end,
+        .vec = (uint64_t)regions,
+        .vec_len = regions_len,
+        .category_mask = PAGE_IS_PRESENT | PAGE_IS_ACCESSED,
+        .category_inverted = PAGE_IS_ACCESSED,
+        .return_mask = PAGE_IS_ACCESSED,
+    };
+    long n = ioctl(pagemap_fd, PAGEMAP_SCAN, &arg);
+
+The returned ``page_region`` array contains contiguous cold ranges that can
+then be evicted.
+
+**Cleanup:**
+
+When the userfaultfd is closed or the range is unregistered, all PROT_NONE
+PTEs are automatically restored to their normal VMA permissions. This
+prevents pages from becoming permanently inaccessible.
+
+**VMM Working Set Tracking Workflow:**
+
+A typical VMM lifecycle for cold page eviction to tiered storage. Two
+mappings of the same shmem (or hugetlbfs) file are used: ``guest_mem`` is
+the RWP-registered mapping that vCPUs access through, and ``io_mem`` is a
+private mapping for VMM-side I/O. Reading ``io_mem`` does not go through
+the RWP-protected PTEs of ``guest_mem``, so the VMM's own ``pwrite()``
+never traps on its own ::
+
+    /* One-time setup */
+    fd = memfd_create("guest", MFD_CLOEXEC);
+    ftruncate(fd, guest_size);
+    guest_mem = mmap(NULL, guest_size, PROT_READ | PROT_WRITE,
+                     MAP_SHARED, fd, 0);  /* vCPU view, RWP-registered */
+    io_mem    = mmap(NULL, guest_size, PROT_READ | PROT_WRITE,
+                     MAP_SHARED, fd, 0);  /* VMM I/O view, unprotected */
+
+    uffd = userfaultfd(O_CLOEXEC | O_NONBLOCK);
+    struct uffdio_api api = {
+        .api = UFFD_API,
+        .features = UFFD_FEATURE_RWP | UFFD_FEATURE_RWP_ASYNC,
+    };
+    ioctl(uffd, UFFDIO_API, &api);
+    if (!(api.features & UFFD_FEATURE_RWP))
+        /* RWP unavailable on this kernel/arch -- fall back. */
+    ioctl(uffd, UFFDIO_REGISTER, &(struct uffdio_register){
+        .range = { guest_mem, guest_size },
+        .mode = UFFDIO_REGISTER_MODE_RWP |
+                UFFDIO_REGISTER_MODE_MISSING,
+    });
+
+    /* Tracking loop */
+    while (vm_running) {
+        /* 1. Detection phase (async -- no vCPU stalls) */
+        ioctl(uffd, UFFDIO_RWPROTECT, &(struct uffdio_rwprotect){
+            .range = full_range,
+            .mode = UFFDIO_RWPROTECT_MODE_RWP });
+        sleep(tracking_interval);
+
+        /*
+         * 2. Switch to sync BEFORE scanning. In async mode a vCPU
+         * access between the scan and any eviction step silently
+         * clears the uffd bit, so the scan would already disagree
+         * with the page state by the time eviction begins. Sync mode
+         * blocks vCPU accesses, freezing the cold snapshot for the
+         * rest of the iteration.
+         */
+        ioctl(uffd, UFFDIO_SET_MODE,
+              &(struct uffdio_set_mode){
+                  .disable = UFFD_FEATURE_RWP_ASYNC });
+
+        /* 3. Find cold pages (uffd bit still set, page present) */
+        ioctl(pagemap_fd, PAGEMAP_SCAN, &(struct pm_scan_arg){
+            .category_mask = PAGE_IS_PRESENT | PAGE_IS_ACCESSED,
+            .category_inverted = PAGE_IS_ACCESSED,
+            .return_mask = PAGE_IS_ACCESSED,
+            ...
+        });
+
+        /* 4. Evict cold pages (vCPU faults block on guest_mem) */
+        for each cold range:
+            /* Read from io_mem -- bypasses RWP, no fault. */
+            pwrite(storage_fd, (char *)io_mem + cold_offset,
+                   len, cold_offset);
+            /* Drop the page from the shared file. */
+            fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+                      cold_offset, len);
+            /*
+             * Wake any vCPU blocked on the RWP fault for this range:
+             * fallocate() does not iterate ctx->fault_pending_wqh.
+             */
+            ioctl(uffd, UFFDIO_WAKE, &(struct uffdio_range){
+                .start = (uintptr_t)guest_mem + cold_offset,
+                .len = len });
+
+        /* 5. Resume async tracking */
+        ioctl(uffd, UFFDIO_SET_MODE,
+              &(struct uffdio_set_mode){
+                  .enable = UFFD_FEATURE_RWP_ASYNC });
+    }
+
+During step 4, a vCPU that accesses ``guest_mem + cold_offset`` blocks
+with a ``UFFD_PAGEFAULT_FLAG_RWP`` fault while the eviction is in
+progress. After ``fallocate()`` punches the page out and ``UFFDIO_WAKE``
+fires, the vCPU retries the access, faults as ``MISSING``, and the
+handler resolves it with ``UFFDIO_COPY`` from storage.
+
+This workflow targets shmem and hugetlbfs (both support a private
+``io_mem`` mapping over the same fd). Anonymous-memory backings need a
+different inner-loop strategy because the VMM has no way to read the
+page without going through the RWP-protected mapping.
+
 QEMU/KVM
 ========
 
-- 
2.54.0

