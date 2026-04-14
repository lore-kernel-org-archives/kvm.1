Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DE3E92AF;
	Tue, 14 Apr 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176659; cv=none; b=rZxTSDBIgTksKe1vVqLCe89MsY+L5wVXrPz93fYJzQ3ohCMT5AhwWPmPQwY5xgQLfG9hKauS+Ct8+u0ab6X2CGhRWHMVhiZ1dNud43O7t+gkL4og8swN7PI6EI9LpjTazMcpwErfE9mAZfcYspk6JCAgvBF6EC+NgqnmDMesbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176659; c=relaxed/simple;
	bh=ib6BF6sXb1GJqhq34QbrG0+ehgQcsgDUzfrc0LMzV2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTTaMypGvyq7ZNRfTHvEyK8a3w8TJ4bR183pXknUDHgtnVDrcSl7SK7plVSmetlDzRriDcbLtzb4XWRXTkXaf76x3PLzZCSH+ClI90Gba/6UCzdxWnw6/tqlqeLS3gb8F1MWr2CqvD2C94k++W0g3w7SON758HfiiTWT/i/Tn0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boRW0RtZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boRW0RtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EE7C4AF09;
	Tue, 14 Apr 2026 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176659;
	bh=ib6BF6sXb1GJqhq34QbrG0+ehgQcsgDUzfrc0LMzV2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=boRW0RtZhQ77L3Q7DgfzHaUcZY9LjSod0vEHXhfpdeexnRMRfbyR9x7kb+KU1xo79
	 zvpFov8b/PWMjWMRGKuJqjpUx5U6cfcYn8Ad7FGFhRtBo+xkd/i4OzP1nwXTk0Mz3Q
	 fVbSAR/EVeyT0hlrh8QkPGL0SDoY2lmSSdH1d3Yw0dUX/KZn6GvSHGxwQin3icGb2n
	 8ZlLVAchxGWECobr2/qz+2IXGfNuLTjj7lR3VRJrDNnYN85Q3v1Ws+ib/2bRBPQ07A
	 4fRBPUHyDyufxyGwaY6knbf3R4dt3wp0fgfialPCZnY3L5Q2zIU8ZYAp6pS8NplKUI
	 Oqw0YcW+fbsXA==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 94FCFF40068;
	Tue, 14 Apr 2026 10:24:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 14 Apr 2026 10:24:18 -0400
X-ME-Sender: <xms:Ek7eaSq22qZaKbpO86six6OpUmf-pnTIdn1lgVRbbCCI9AntKjn2wQ>
    <xme:Ek7eaXmpZPoD_hpYk-2g1fw6teoGJFqU0GmC4CtLLwiEYfa1cg50TsVk6trIYX5Iy
    oml-Balu5PyYN-y7eSSjs52fPq3cs6gofAHXJhYnf7SdasYzE8zZkU>
X-ME-Received: <xmr:Ek7eacQwmuhyW8LTitgVKaE4q9ufsyof1wBeFJ1aVYUNTFtPbFNi0mGPzT212g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepfdfmihhrhihl
    ucfuhhhuthhsvghmrghuucdlofgvthgrmddfuceokhgrsheskhgvrhhnvghlrdhorhhgqe
    enucggtffrrghtthgvrhhnpefhvdefvdevjeevhefhhfevudefudejfeduvdekheeludfh
    iefhhedujeffffeigfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidq
    udeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgse
    hshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopehpvghtvghrgiesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    uggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    uhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgt
    ohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:Ek7eaZAT3aJQaPi5S8rWub9GJgZn-6Bbob-82C-6AEDGuyu3yv5Y3w>
    <xmx:Ek7eacqo0_pbYaSNq88MVS_N3hQRcnzzT7ee3ax7PDY8tof9yw-kcw>
    <xmx:Ek7eaXgxzjhPjFxRFAsbk_G90LQZkRqUarqbvzzyIG4_S9mJS1lu3g>
    <xmx:Ek7eaZwoKU7MfjkdtO4VE0RIbvEpsUEFkeP5ln40aYPZM_1L4bmUhA>
    <xmx:Ek7eaVLB1dXZ4vI8U4Fyb_CTPszURIDRhcRXLtS9rRZ-WDicAsBcqV2j>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:24:17 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [RFC, PATCH 12/12] Documentation/userfaultfd: document working set tracking
Date: Tue, 14 Apr 2026 15:23:46 +0100
Message-ID: <20260414142354.1465950-13-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260414142354.1465950-1-kas@kernel.org>
References: <20260414142354.1465950-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document the new userfaultfd capabilities for VM working set tracking:

- UFFD_FEATURE_MINOR_ANON and UFFD_FEATURE_MINOR_ASYNC for anonymous
  minor fault interception using the PROT_NONE hinting mechanism.
- UFFDIO_DEACTIVATE for marking pages as inaccessible while keeping
  them resident.
- Sync and async fault resolution modes, and UFFDIO_SET_MODE for
  runtime toggling between them.
- PAGEMAP_SCAN with PAGE_IS_UFFD_DEACTIVATED for cold page detection.
- Cleanup semantics on unregister and close.
- NUMA balancing interaction on anonymous VMAs.
- Complete VMM workflow example for the cold page eviction lifecycle,
  with a note on shmem applicability.

Update the feature flag descriptions at the top of the guide to
reference the new section.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
 Documentation/admin-guide/mm/userfaultfd.rst | 141 ++++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index e5cc8848dcb3..fc89e029060c 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -111,7 +111,11 @@ events, except page fault notifications, may be generated:
 - ``UFFD_FEATURE_MINOR_HUGETLBFS`` indicates that the kernel supports
   ``UFFDIO_REGISTER_MODE_MINOR`` registration for hugetlbfs virtual memory
   areas. ``UFFD_FEATURE_MINOR_SHMEM`` is the analogous feature indicating
-  support for shmem virtual memory areas.
+  support for shmem virtual memory areas. ``UFFD_FEATURE_MINOR_ANON``
+  extends minor fault support to anonymous private memory using
+  PROT_NONE hinting; see the `Anonymous Minor Faults`_ section.
+  ``UFFD_FEATURE_MINOR_ASYNC`` enables asynchronous auto-resolution for
+  anonymous minor faults (requires ``UFFD_FEATURE_MINOR_ANON``).
 
 - ``UFFD_FEATURE_MOVE`` indicates that the kernel supports moving an
   existing page contents from userspace.
@@ -297,6 +301,141 @@ transparent to the guest, we want that same address range to act as if it was
 still poisoned, even though it's on a new physical host which ostensibly
 doesn't have a memory error in the exact same spot.
 
+Anonymous Minor Faults
+----------------------
+
+``UFFD_FEATURE_MINOR_ANON`` enables ``UFFDIO_REGISTER_MODE_MINOR`` on
+anonymous private memory. Unlike shmem/hugetlbfs minor faults (where a page
+exists in the page cache but has no PTE), anonymous minor faults use the
+PROT_NONE hinting mechanism: pages remain resident in memory with their PFNs
+preserved in the PTEs, but access permissions are removed so the next access
+triggers a fault.
+
+This is designed for VM memory managers that need to track the working set of
+anonymous guest memory for cold page eviction to tiered or remote storage.
+
+**Setup:**
+
+1. Open a userfaultfd and enable ``UFFD_FEATURE_MINOR_ANON`` (and optionally
+   ``UFFD_FEATURE_MINOR_ASYNC``) via ``UFFDIO_API``.
+
+2. Register the guest memory range with ``UFFDIO_REGISTER_MODE_MINOR``
+   (and ``UFFDIO_REGISTER_MODE_MISSING`` if evicted pages will need to be
+   fetched back from storage).
+
+**Deactivation:**
+
+Use ``UFFDIO_DEACTIVATE`` to mark pages as inaccessible. This ioctl takes a
+``struct uffdio_range`` and sets PROT_NONE on all present PTEs in the range,
+using the same mechanism as NUMA balancing. Pages stay resident and their
+physical frames are preserved — only access permissions are removed.
+
+**Fault Handling:**
+
+When a deactivated page is accessed:
+
+- **Sync mode** (default): The faulting thread blocks and a
+  ``UFFD_PAGEFAULT_FLAG_MINOR`` message is delivered to the userfaultfd
+  handler. The handler resolves the fault with ``UFFDIO_CONTINUE``, which
+  restores the PTE permissions and wakes the faulting thread.
+
+- **Async mode** (``UFFD_FEATURE_MINOR_ASYNC``): The kernel automatically
+  restores PTE permissions and the thread continues without blocking. No
+  message is delivered to the handler.
+
+**Cold Page Detection with PAGEMAP_SCAN:**
+
+After deactivating a range and letting the application run, use the
+``PAGEMAP_SCAN`` ioctl on ``/proc/pid/pagemap`` with the
+``PAGE_IS_UFFD_DEACTIVATED`` category flag to efficiently find pages that were
+never re-accessed (cold pages)::
+
+    struct pm_scan_arg arg = {
+        .size = sizeof(arg),
+        .start = guest_mem_start,
+        .end = guest_mem_end,
+        .vec = (uint64_t)regions,
+        .vec_len = regions_len,
+        .category_mask = PAGE_IS_UFFD_DEACTIVATED,
+        .return_mask = PAGE_IS_UFFD_DEACTIVATED,
+    };
+    long n = ioctl(pagemap_fd, PAGEMAP_SCAN, &arg);
+
+The returned ``page_region`` array contains contiguous cold ranges that can
+then be evicted.
+
+**Cleanup:**
+
+When the userfaultfd is closed or the range is unregistered, all protnone
+PTEs are automatically restored to their normal VMA permissions. This
+prevents pages from becoming permanently inaccessible.
+
+**Interaction with NUMA Balancing:**
+
+NUMA balancing is automatically disabled on anonymous VMAs registered with
+``UFFDIO_REGISTER_MODE_MINOR``, since both mechanisms use PROT_NONE PTEs
+as access hints and would interfere with each other. Shmem VMAs are not
+affected since ``UFFDIO_DEACTIVATE`` zaps PTEs there instead of using
+PROT_NONE.
+
+**VMM Working Set Tracking Workflow:**
+
+A typical VMM lifecycle for cold page eviction to tiered storage::
+
+    /* One-time setup */
+    uffd = userfaultfd(O_CLOEXEC | O_NONBLOCK);
+    ioctl(uffd, UFFDIO_API, &(struct uffdio_api){
+        .api = UFFD_API,
+        .features = UFFD_FEATURE_MINOR_ANON |
+                    UFFD_FEATURE_MINOR_ASYNC,
+    });
+    ioctl(uffd, UFFDIO_REGISTER, &(struct uffdio_register){
+        .range = { guest_mem, guest_size },
+        .mode = UFFDIO_REGISTER_MODE_MINOR |
+                UFFDIO_REGISTER_MODE_MISSING,
+    });
+
+    /* Tracking loop */
+    while (vm_running) {
+        /* 1. Detection phase (async — no vCPU stalls) */
+        ioctl(uffd, UFFDIO_DEACTIVATE, &full_range);
+        sleep(tracking_interval);
+
+        /* 2. Find cold pages */
+        ioctl(pagemap_fd, PAGEMAP_SCAN, &(struct pm_scan_arg){
+            .category_mask = PAGE_IS_UFFD_DEACTIVATED,
+            ...
+        });
+
+        /* 3. Switch to sync for safe eviction */
+        ioctl(uffd, UFFDIO_SET_MODE,
+              &(struct uffdio_set_mode){
+                  .disable = UFFD_FEATURE_MINOR_ASYNC });
+
+        /* 4. Evict cold pages (vCPU faults block in handler) */
+        for each cold range:
+            pwrite(storage_fd, cold_addr, len, offset);
+            madvise(cold_addr, len, MADV_DONTNEED);
+
+        /* 5. Resume async tracking */
+        ioctl(uffd, UFFDIO_SET_MODE,
+              &(struct uffdio_set_mode){
+                  .enable = UFFD_FEATURE_MINOR_ASYNC });
+    }
+
+During step 4, if a vCPU accesses a cold page being evicted, it blocks
+with a ``UFFD_PAGEFAULT_FLAG_MINOR`` fault. The handler can either let it
+wait (the eviction completes, ``MADV_DONTNEED`` fires, the fault retries as
+``MISSING`` and is resolved with ``UFFDIO_COPY`` from storage) or resolve
+it immediately with ``UFFDIO_CONTINUE``.
+
+The same workflow applies to shmem-backed guest memory
+(``UFFD_FEATURE_MINOR_SHMEM``). The only difference is the
+``PAGEMAP_SCAN`` mask for cold page detection: use
+``!PAGE_IS_PRESENT`` instead of ``PAGE_IS_UFFD_DEACTIVATED``, since
+``UFFDIO_DEACTIVATE`` zaps PTEs on shmem (pages stay in page cache)
+rather than setting PROT_NONE.
+
 QEMU/KVM
 ========
 
-- 
2.51.2

