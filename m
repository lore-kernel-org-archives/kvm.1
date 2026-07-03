Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC373E5ED3;
	Fri,  3 Jul 2026 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085812; cv=none; b=kbePTV6v2se/WbYmRXo0bn1Pudr73T4nWnp/FQDnD6/vnFT6OD0borV5nncvPIjzMUC64GIOp6xZnYxpVdRh0Qek2T6OxwnY+B7dru7ZlsArV4Z3QenyQbJsALF32R+tgF313XGRqcd6hm6jfwwSLxeF0sgpMsb5UZ+vl2WC+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085812; c=relaxed/simple;
	bh=mgxGf+izPbqYQsdbAvzWpW1MLphfyyb2wsSHsBzCplw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnLsgoRauGsjegylGYRPSivWQywVIP9kzo8N0ij29tcIMR+nOOQlws6HaPaoaol7DJksmcr5eo/WMHcr2mMrROaEnRFN/XWcPOXYw8rIrxLuQvmlW2T0JcgagF3YZcpgvNq/v2YQJ/rdfIKmYHfwEa2cSqtpfSO6lu4PIAQS5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=hCcVtTuI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RQUVtja/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="hCcVtTuI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RQUVtja/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D3A61D00089;
	Fri,  3 Jul 2026 09:36:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jul 2026 09:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783085809; x=
	1783172209; bh=mdxUu2oye/uPbhzvJowyuT/K3tsRfsLqm46GQayd71E=; b=h
	CcVtTuIzxqwhTaVW+4L8IzrGG6vnpvLU0Kxj48ZHigo+oVNCWNV02R5tLDbv+2n1
	2ZiUsAN8RJKMQmVlO191DTE0VLuKHlDVpazT5dkr0Z3wKNqgfw0Nc8toTB0MOUye
	OBYm4OuIv8NdVbP71CwDou7bOfaXcDKSSFE7HfpPW4V+lizJd70Twtk8HBDhgu+t
	IRqLckkZhd4FJLAChtX7sVpySaPs0zPw38vIDzF3snJfJvyIe+6gM/+xkCQ4vWnG
	iOW6IGSKgogB0/IJKPMUMFyo1WSWP0PhkpjpL7D0SDkcXRffmR8por5d3MZwD6nL
	wkY5EsuuBOP/ZSaj/UJzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783085809; x=1783172209; bh=m
	dxUu2oye/uPbhzvJowyuT/K3tsRfsLqm46GQayd71E=; b=RQUVtja/XwVi/Nj8H
	xCBRZhpTCzdBa5tEO/c1XpvCftakpcSY9zLcQVeZXJwI25ODWvw2uDhK1Y/ng+pQ
	Df4dugQq8qkJMSFdBF3tIDj6geYAhj1TN8sokkgRn3aFK3I8Iw6h/q3xX1liyShE
	T+b98JKOC9cA8SALDYsaPYvjlbdsgf0B0BggwR3YzEnXRcOoZlUukZjxVBvWJIO/
	xGwXeXww+sedk40IsmRjUkAi9XRNA50L4mU2HfMlhWRZ6reDIyIeUgWw9PKkMv0N
	8VGR85+dtmHZNb3PXVzUhBd8vZvlXRhXckYsYYw0msDO3y521lMJb+/NEIBiupm6
	63NaQ==
X-ME-Sender: <xms:8bpHahhD2OODVbAC7gQC4Atbt4SYHHsoEbqCOxkO0IvEpAOOE3VAIA>
    <xme:8bpHap9opsfXmtD97K-lpxq6dxsqCZEW8V0U-JjYLT18j90h3w48JcgdqVA0dRoT_
    pMVaBDDT5_sfw_51PcIvfYXU4rSWiTp5jTAty1rjHTsZxfTqQMlFiQ>
X-ME-Received: <xmr:8bpHapmlKiFrcDlURv_D_53wgjQOf6M5av9dry_hl23w9spRKXyDT09V4sApiA>
X-ME-Proxy-Cause: dmFkZTGmmVcSqc1ifmQn6XT5ZUiwwX9N2nBOVuQVUkn8E1VmhORLccagOf8n2iB9wYOimT
    VzJiyUcgIqy/F0CFPKO3A/DQyvjGeTlZjtILSrkvsXFDgtW2/LwSNqnX5y3lfCjPv8KT3y
    pv/7yUocU0F79ppz7Ja4LBUNuFPFOlR+UkSCRCi85W7w3PiYdJWamj0Yvnexj1ymZQshib
    QPJ8v6Uvr3wPfhejR1DMCrATOEIEqdDaqDi/+pTxD6COhr4t8Y6r8u3UoT9065hT5et/xu
    b2Mj9gqnBcApBMrR+ydSZ96PlRnTO/2cg0/pxM9weE3L0EHx9ppj7MXSHbWsD/J+EG70az
    O4dkHtCW5xfi0bUGa1wCxKB4GsHUe6PhmugEvIPP5uheEGBCx7g6qVZQP3HBs6nbUigsmt
    QlineLJs71igRXieLpxssuBZ2Npp/oMQxgh8sUdII58jdTuALXzRui2PnGVZN0dcBhOZCj
    SRnKeuv+RiMESDhbBNnIHId2nUAunxspvGTsbvsWaOY6txd99R7xjjUvD5hhMWS7tKHI3k
    GLXt2dhY9k2EczoBB4OjMcuXZHJ+SVlrIw3NwQUXFhpsoG+K8mAOEPaXYdwZjiXPdXBDWi
    zuNoqeLu9gvsgc4nlgMlIyu5d2XR3qw7hYahzLwo6nJvltFYO/8ZIkbhAz4A
X-ME-Proxy: <xmx:8bpHav0I2DgKtTCXWxxpkLrd2KROPOXMGjQLBkJYy2J3YWMIuKev0g>
    <xmx:8bpHamR0E8rt6GV-RBxIQHGkqzJEseCUNUaS3bMT_66k6wTomh8eNA>
    <xmx:8bpHanN4U4h80oNQPZO8CERky5mDYZ8G_MgBBdog2YwEpeoTjh2Ksg>
    <xmx:8bpHaijBth0pPAAv_a0z10jc0crkBgOhox5vzdFpcOGmoaLiDpTY-Q>
    <xmx:8bpHanj8mOLqe1U63eKNpouPXnyBlkTagP2nJUHif4GgC2J3pTJwuQvd>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 09:36:48 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
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
Subject: [PATCH v8 13/15] userfaultfd: add UFFDIO_SET_MODE for runtime sync/async toggle
Date: Fri,  3 Jul 2026 14:36:12 +0100
Message-ID: <20260703133615.1039465-14-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703133615.1039465-1-kirill@shutemov.name>
References: <20260703133615.1039465-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

Add an ioctl to toggle async mode at runtime without re-registering
the userfaultfd. This allows a VMM to switch between sync and async
RWP modes on-the-fly -- for example, starting in async mode for
working set scanning, then switching to sync mode to intercept faults
during page eviction.

UFFDIO_SET_MODE takes an enable/disable bitmask of UFFD_FEATURE_*
flags. Only UFFD_FEATURE_RWP_ASYNC is toggleable today; the ioctl
rejects any other bit with -EINVAL. Enabling RWP_ASYNC also requires
RWP to have been negotiated at UFFDIO_API time, mirroring the
UFFDIO_API invariant.

Fault-path readers of ctx->features run under mmap_read_lock or a
per-VMA lock; the RMW takes mmap_write_lock and calls
vma_start_write() on every UFFD-armed VMA, so those readers are fully
excluded. userfaultfd_show_fdinfo(), however, reads ctx->features
without any lock, so the RMW is written as a single WRITE_ONCE and
fdinfo reads it with READ_ONCE. That keeps the lockless observer from
seeing a mid-RMW intermediate and removes the audit burden when new
toggleable bits are added later.

When switching to async, pending sync waiters are woken so they retry
and auto-resolve under the new mode.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/uapi/linux/userfaultfd.h |  14 +++
 mm/userfaultfd.c                 | 150 +++++++++++++++++++++++++------
 2 files changed, 136 insertions(+), 28 deletions(-)

diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index c10f08f8a618..cea11aad6b54 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -49,6 +49,7 @@
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
+	 (__u64)1 << _UFFDIO_SET_MODE |		\
 	 (__u64)1 << _UFFDIO_API)
 #define UFFD_API_RANGE_IOCTLS			\
 	((__u64)1 << _UFFDIO_WAKE |		\
@@ -85,6 +86,7 @@
 #define _UFFDIO_CONTINUE		(0x07)
 #define _UFFDIO_POISON			(0x08)
 #define _UFFDIO_RWPROTECT		(0x09)
+#define _UFFDIO_SET_MODE		(0x0A)
 #define _UFFDIO_API			(0x3F)
 
 /* userfaultfd ioctl ids */
@@ -111,6 +113,8 @@
 				      struct uffdio_poison)
 #define UFFDIO_RWPROTECT	_IOWR(UFFDIO, _UFFDIO_RWPROTECT,	\
 				      struct uffdio_rwprotect)
+#define UFFDIO_SET_MODE		_IOW(UFFDIO, _UFFDIO_SET_MODE,	\
+				     struct uffdio_set_mode)
 
 /* read() structure */
 struct uffd_msg {
@@ -406,6 +410,16 @@ struct uffdio_move {
 	__s64 move;
 };
 
+struct uffdio_set_mode {
+	/*
+	 * Toggle async mode for features at runtime.
+	 * Supported: UFFD_FEATURE_RWP_ASYNC.
+	 * Setting a bit in both enable and disable is invalid.
+	 */
+	__u64 enable;
+	__u64 disable;
+};
+
 /*
  * Flags for the userfaultfd(2) system call itself.
  */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 1a3504c63597..a7659b0a1147 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2484,19 +2484,29 @@ struct userfaultfd_wake_range {
 /* internal indication that UFFD_API ioctl was successfully executed */
 #define UFFD_FEATURE_INITIALIZED		(1u << 31)
 
+/*
+ * UFFDIO_SET_MODE updates ctx->features under mmap_write_lock with
+ * WRITE_ONCE; readers that run outside mmap_read_lock or the per-VMA
+ * lock (poll/read_iter/ioctl, fdinfo) must pair with READ_ONCE.
+ */
+static unsigned int userfaultfd_features(struct userfaultfd_ctx *ctx)
+{
+	return READ_ONCE(ctx->features);
+}
+
 static bool userfaultfd_is_initialized(struct userfaultfd_ctx *ctx)
 {
-	return ctx->features & UFFD_FEATURE_INITIALIZED;
+	return userfaultfd_features(ctx) & UFFD_FEATURE_INITIALIZED;
 }
 
 static bool userfaultfd_wp_async_ctx(struct userfaultfd_ctx *ctx)
 {
-	return ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC);
+	return ctx && (userfaultfd_features(ctx) & UFFD_FEATURE_WP_ASYNC);
 }
 
 static bool userfaultfd_rwp_async_ctx(struct userfaultfd_ctx *ctx)
 {
-	return ctx && (ctx->features & UFFD_FEATURE_RWP_ASYNC);
+	return ctx && (userfaultfd_features(ctx) & UFFD_FEATURE_RWP_ASYNC);
 }
 
 /*
@@ -2511,7 +2521,7 @@ bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
 	if (!ctx)
 		return false;
 
-	return ctx->features & UFFD_FEATURE_WP_UNPOPULATED;
+	return userfaultfd_features(ctx) & UFFD_FEATURE_WP_UNPOPULATED;
 }
 
 static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
@@ -4297,6 +4307,109 @@ static int userfaultfd_rwprotect(struct userfaultfd_ctx *ctx,
 	return ret;
 }
 
+/* Subset of UFFD_API_FEATURES actually supported by this kernel/arch */
+static __u64 uffd_api_available_features(void)
+{
+	__u64 f = UFFD_API_FEATURES;
+
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_MINOR))
+		f &= ~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
+	if (!pgtable_supports_uffd())
+		f &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+	if (!uffd_supports_wp_marker())
+		f &= ~(UFFD_FEATURE_WP_HUGETLBFS_SHMEM |
+		       UFFD_FEATURE_WP_UNPOPULATED |
+		       UFFD_FEATURE_WP_ASYNC);
+	/*
+	 * RWP needs both PROT_NONE support and the uffd PTE bit. The
+	 * VM_UFFD_RWP check covers compile-time unavailability; the
+	 * pgtable_supports_uffd() check covers runtime (e.g. riscv
+	 * without the SVRSW60T59B extension) where the PTE bit is declared
+	 * but not actually usable.
+	 */
+	if (VM_UFFD_RWP == VM_NONE || !pgtable_supports_uffd())
+		f &= ~(UFFD_FEATURE_RWP | UFFD_FEATURE_RWP_ASYNC);
+	return f;
+}
+
+/* Async features that can be toggled at runtime via UFFDIO_SET_MODE */
+#define UFFD_FEATURE_TOGGLEABLE	UFFD_FEATURE_RWP_ASYNC
+
+static int userfaultfd_set_mode(struct userfaultfd_ctx *ctx,
+				unsigned long arg)
+{
+	struct uffdio_set_mode mode;
+	struct mm_struct *mm = ctx->mm;
+
+	if (copy_from_user(&mode, (void __user *)arg, sizeof(mode)))
+		return -EFAULT;
+
+	/* enable and disable must not overlap */
+	if (mode.enable & mode.disable)
+		return -EINVAL;
+
+	/* only toggleable features that this kernel/arch actually supports */
+	if ((mode.enable | mode.disable) &
+	    ~(uffd_api_available_features() & UFFD_FEATURE_TOGGLEABLE))
+		return -EINVAL;
+
+	/* RWP_ASYNC can only be enabled on contexts that negotiated RWP */
+	if ((mode.enable & UFFD_FEATURE_RWP_ASYNC) &&
+	    !(userfaultfd_features(ctx) & UFFD_FEATURE_RWP))
+		return -EINVAL;
+
+	if (!mmget_not_zero(mm))
+		return -ESRCH;
+
+	/*
+	 * Drain in-flight faults before flipping features. mmap_write_lock()
+	 * blocks new mmap_read_lock() callers, but per-VMA locked faults
+	 * (lock_vma_under_rcu() + FAULT_FLAG_VMA_LOCK) that acquired before
+	 * this point keep running. Calling vma_start_write() on each UFFD-
+	 * armed VMA waits for those readers to drop, so no in-flight fault
+	 * can observe the old features after mmap_write_unlock().
+	 */
+	mmap_write_lock(mm);
+	{
+		struct vm_area_struct *vma;
+		VMA_ITERATOR(vmi, mm, 0);
+
+		for_each_vma(vmi, vma) {
+			if (vma->vm_userfaultfd_ctx.ctx == ctx)
+				vma_start_write(vma);
+		}
+	}
+	/*
+	 * Single WRITE_ONCE so lockless readers (fdinfo, poll/read_iter
+	 * via userfaultfd_is_initialized(), and the userfaultfd_features()
+	 * helper used elsewhere) can't observe a mid-RMW intermediate
+	 * value. Hot-path readers already serialise through the mmap lock
+	 * + vma_start_write() drain above, so their load doesn't need an
+	 * annotation.
+	 */
+	WRITE_ONCE(ctx->features,
+		   (ctx->features | mode.enable) & ~mode.disable);
+	mmap_write_unlock(mm);
+
+	/*
+	 * If switching to async, wake threads blocked in handle_userfault().
+	 * They will retry the fault and auto-resolve under the new mode.
+	 * len=0 means wake all pending faults on this context.
+	 */
+	if (mode.enable & UFFD_FEATURE_RWP_ASYNC) {
+		struct userfaultfd_wake_range range = { .len = 0 };
+
+		spin_lock_irq(&ctx->fault_pending_wqh.lock);
+		__wake_up_locked_key(&ctx->fault_pending_wqh, TASK_NORMAL,
+				     &range);
+		__wake_up(&ctx->fault_wqh, TASK_NORMAL, 1, &range);
+		spin_unlock_irq(&ctx->fault_pending_wqh.lock);
+	}
+
+	mmput(mm);
+	return 0;
+}
+
 static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 {
 	__s64 ret;
@@ -4535,29 +4648,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 		goto err_out;
 
 	/* report all available features and ioctls to userland */
-	uffdio_api.features = UFFD_API_FEATURES;
-#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-	uffdio_api.features &=
-		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
-#endif
-	if (!pgtable_supports_uffd())
-		uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
-
-	if (!uffd_supports_wp_marker()) {
-		uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
-		uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
-		uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
-	}
-	/*
-	 * RWP needs both PROT_NONE support and the uffd-wp PTE bit. The
-	 * VM_UFFD_RWP check covers compile-time unavailability; the
-	 * pgtable_supports_uffd() check covers runtime (e.g. riscv
-	 * without the SVRSW60T59B extension) where the PTE bit is declared
-	 * but not actually usable.
-	 */
-	if (VM_UFFD_RWP == VM_NONE || !pgtable_supports_uffd())
-		uffdio_api.features &=
-			~(UFFD_FEATURE_RWP | UFFD_FEATURE_RWP_ASYNC);
+	uffdio_api.features = uffd_api_available_features();
 
 	ret = -EINVAL;
 	if (features & ~uffdio_api.features)
@@ -4627,6 +4718,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
 	case UFFDIO_RWPROTECT:
 		ret = userfaultfd_rwprotect(ctx, arg);
 		break;
+	case UFFDIO_SET_MODE:
+		ret = userfaultfd_set_mode(ctx, arg);
+		break;
 	}
 	return ret;
 }
@@ -4654,7 +4748,7 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
 	 *	protocols: aa:... bb:...
 	 */
 	seq_printf(m, "pending:\t%lu\ntotal:\t%lu\nAPI:\t%Lx:%x:%Lx\n",
-		   pending, total, UFFD_API, ctx->features,
+		   pending, total, UFFD_API, userfaultfd_features(ctx),
 		   UFFD_API_IOCTLS|UFFD_API_RANGE_IOCTLS);
 }
 #endif
-- 
2.54.0

