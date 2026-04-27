Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5F30DD3C;
	Mon, 27 Apr 2026 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290471; cv=none; b=Ftaq55m18I81g6xvnGgKkD7X1qFoibGepXiOceKCblCSvrG3vjWexvB79QIC5GAtAdcCqnQjFWaBNFjdT63buUxOShiraQmBgbKkDiLkTxVqwjgW9XW3DW0xnJgRW/qrXHy4/LFNnCJD+jdIxD5ThArCHnu0UBqNcAwClKq5yOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290471; c=relaxed/simple;
	bh=hRY7obmR9e6QVqFUCEmAN4SbG7l3gAQ60qItIMhRPe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbJniCcdOQvO/iYq927t/Wn0Kgm+OSLxa58UvwHRmYG6ujBX22yJAzAnMrBMKcDUBkT0/jvpyeU7hNGi5PbdaXRHOVpEvBuLjvCFqxKdikDIl5OB+PXslOiM0BvsK5qViMUu0HfUVJ9M6MYzGt5S6kHF+qxO1b2xnWoabThnXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg9Jiiou; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg9Jiiou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DBDC2BCB4;
	Mon, 27 Apr 2026 11:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777290471;
	bh=hRY7obmR9e6QVqFUCEmAN4SbG7l3gAQ60qItIMhRPe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eg9JiiouctuUABW9G2hFJPK56S97wwLRrS8UqsN9Ib0aV3769tFkptTI1EEhujooF
	 4jqAGKkPNrGNHf1Lj128ABqR/ossA4jknjuJtPQJ5yGArfCcUuktoDuUdZ91JAORKR
	 N4Yv9WWppQm6uAF9fblyPKF0bnM8dTcrU0ySXLnyN/aBluBAkMsdxRz0A4zI3cMej+
	 XTSviGI1Imtrc34OsdffAoYhSG0Bp+JPrPBW9YUAuSmWQeiH3EBtoSX5Tg2v9Z8/6+
	 f+RuI9E9A3rCRl2RX/eB5su/kTEng+mXdR53osoPJFGX4bEtil201v1bEhkM4wsw3b
	 dYu5ZoBoNh9tg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5BD14F40069;
	Mon, 27 Apr 2026 07:47:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Apr 2026 07:47:50 -0400
X-ME-Sender: <xms:5kzvaUFy18kEp-30nW--_kDEeHiGd8r_oAfIRp8aZFP_3ueBK_Gh2A>
    <xme:5kzvaRRTeAF9VXtfEtcCebKV9XO3YSaZe1InmaD4DaDZxrtO4bj2b58B4_t3AFkG9
    xn8BbCyH7O7UawwDsUGmGKFEDNB4kloY8xOkb__JlB-XaBUSSrcPheE>
X-ME-Received: <xmr:5kzvaWqXDPJf5myhpjL0KHo-GbMvyeiZbFTRMqkjvqUwSIizXYEkIyM9yYM_Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepfdfmihhrhihlucfuhhhuthhsvghmrghuucdlofgvthgrmddfuceo
    khgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpefhudejfedvgeekff
    efvdekheekkeeuveeftdelheegteelgfefveevueekhfdtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprg
    huthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhk
    rghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtph
    htthhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhn
    uhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrphhptheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphht
    thhopegurghvihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehljhhssehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepvhgsrggskhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihgrmhdrhh
    hofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepiihihiesnhhvihguihgr
    rdgtohhm
X-ME-Proxy: <xmx:5kzvafrE-VLf03Dqrii8IRIE8tHz18hhXPbkaCy1byZDSGf8txAhQw>
    <xmx:5kzvaR3NkexKgdevnXOo5PA6H09IT1dRuyNcxGlAJODKolB-Tbozdw>
    <xmx:5kzvaTh1YfSIsrYFWWFGqfLifJogcLEWOJLaJJvDBoOQRuu1qC5ORg>
    <xmx:5kzvaQlfYIxjLrQWjA0ZJAwnSJe59haFuy8aHV9gvA4P53i_Gz1jzA>
    <xmx:5kzvab-7WB1FQj8Ax7uhnqOW2NE4CKXLo68ACPXeDiKtx8IWGZ7JeMV7>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 07:47:48 -0400 (EDT)
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
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH 12/14] userfaultfd: add UFFDIO_SET_MODE for runtime sync/async toggle
Date: Mon, 27 Apr 2026 12:46:00 +0100
Message-ID: <20260427114607.4068647-13-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260427114607.4068647-1-kas@kernel.org>
References: <20260427114607.4068647-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/userfaultfd.c                 | 130 +++++++++++++++++++++++++------
 include/uapi/linux/userfaultfd.h |  14 ++++
 2 files changed, 120 insertions(+), 24 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4a701ac830f4..83e759054464 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1871,6 +1871,107 @@ static int userfaultfd_rwprotect(struct userfaultfd_ctx *ctx,
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
+	    !(ctx->features & UFFD_FEATURE_RWP))
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
+	 * Single WRITE_ONCE so the fdinfo lockless reader can't observe a
+	 * mid-RMW intermediate value. Hot-path readers already serialise
+	 * through the mmap lock + vma_start_write() drain above, so their
+	 * load doesn't need an annotation.
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
@@ -2109,29 +2210,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
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
@@ -2201,6 +2280,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
 	case UFFDIO_RWPROTECT:
 		ret = userfaultfd_rwprotect(ctx, arg);
 		break;
+	case UFFDIO_SET_MODE:
+		ret = userfaultfd_set_mode(ctx, arg);
+		break;
 	}
 	return ret;
 }
@@ -2228,7 +2310,7 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
 	 *	protocols: aa:... bb:...
 	 */
 	seq_printf(m, "pending:\t%lu\ntotal:\t%lu\nAPI:\t%Lx:%x:%Lx\n",
-		   pending, total, UFFD_API, ctx->features,
+		   pending, total, UFFD_API, READ_ONCE(ctx->features),
 		   UFFD_API_IOCTLS|UFFD_API_RANGE_IOCTLS);
 }
 #endif
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
-- 
2.51.2

