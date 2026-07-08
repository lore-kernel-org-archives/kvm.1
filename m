Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1E844210D;
	Wed,  8 Jul 2026 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509295; cv=none; b=jDNBq2yB1CCwpJhVUPb4J5SFjhsyyJEa871iNbQf0BTPWUb/JgxsD5UWDIa87GSi2NrfSpgnJwDNeNQIRdmwlqGxLDp5xX0p1CTtyolSZMcePu5XRiqre8DXYIiQdY9StysMaCh8GYhrgClbCis2QMpSUNIyisqX0RVP05DGv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509295; c=relaxed/simple;
	bh=3zRzAdFgsdNyhpW1hksmD7jbA9nTqdbSJymPIMm5vgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nfsm1XlEgTKkdN1oAgXaHaiCqN6emGDZGPVTa//gADBkTCIT5vplbQJaiSqLMesFygzm4PHRtlycFmuSZOsV7ISF/oTjld68Q73R77W6Asb8oIw01bf5DWZW+EGXW1VHM4Q53sIkbfIzYEpFrxST47MxqRgmSW9Dn30GkHMr4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Bmse3gtz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j79Ujjkb; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Bmse3gtz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j79Ujjkb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 895B47A0155;
	Wed,  8 Jul 2026 07:14:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 07:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783509292; x=
	1783595692; bh=veK4EOe5tp1fZpM7DVI7JRbCnEQ1JdzuePEQOb/OATM=; b=B
	mse3gtzRrxmOdIJkrO86hRZ+Amevd4CStUmExQImtT9j+bXe1XrKD1oARhHEecZg
	OlRL6M33TF4lGoEMJaRIRuVjGSfgxdzqp0qBxfERosj9QVOXHFy8bLPByyy4WYWO
	VdxwRVNMLTLGOHKpXF/cQf3rO6gP8xJSB6lfPXNZXiQjoUMZ6F3gflFyZB2YAvKF
	UvkCCK/ZOUVjS+XM6HAM2Q5eaS2J8UdmIdjAat8tXsNfSETDwArXG0Q3n44NTVw/
	JVU2DZlaaxo0e3IeWVn6r8IVdoVGi+XYcp21DCrbY2AnXgbRoBR6AIBC9aqHFOgF
	MxUTi27tceQ8UfEV2dSVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783509292; x=1783595692; bh=v
	eK4EOe5tp1fZpM7DVI7JRbCnEQ1JdzuePEQOb/OATM=; b=j79UjjkbRReiHfkZx
	ecJTE/bpn7ALSnsG4n3u0+C4P308F4Tsvysymv7IjYpcaKEU3K+KrkbIINn/+o1H
	Ei7sKeRWyS4QUBS+ocm1EY+8LhErS/mMbNMa3fHGNvZjb/CsLK3HdpReHJ8iq+Uh
	HEPCTWwBf7AxYlJZ+6PLQAfxnEmodSzrj8EN7ak5utdutKaUTunTmnduUR1oowQu
	K6TCHfppwhh8nI5w9NvGs7YxlBNgPsLcjrkDZcDen6+HF3xHOgU2miSkeTaW5kcv
	ysY362YHaSbBvsraFtyxVq1/X4WI88WNhk386/+rAi7jJhpqZBeZ0oJk29TOl8y/
	zxtyg==
X-ME-Sender: <xms:LDFOav6M60F2iKzc5d-w9uvBTyLaCO8dthDazsFKQyyKdNGBBzkFiA>
    <xme:LDFOao2DSb5sLN25uJ6Zq4dH9h2sSdq1PnR-BKtSzsd9CctHIVAQ1z8pSqCPdFb04
    CgEPdRO3VniUJ7MN6-f4Y5BuWN962fxROqwQP0u-blshl41VcUoaTM>
X-ME-Received: <xmr:LDFOau_wNuaYRpkgjPenPxsi9YE1HDC3ou40f2GZCabO3fR1sFdQEuyuSHbhyw>
X-ME-Proxy-Cause: dmFkZTEJi9ZHkvDal0XEjRCsT0iNAnPRCAk5kgEEgoJU4yePjdqzpQExdGAZUIqUz4XnoY
    CGRiH09UEs58yMb7jVo9o3dysSfq9x1efgmppI7lHvhuEtJ5wtzlaX36rjyD3dyJgEcUne
    cSdzGz73az8FTXudTLzY8YyDYN5WXjrbOvPnhM23MDt3NOVJYIdcsInRJJM7xALp/juNzS
    gCYb/eO1pnFD+VNq7l7R+7JXGe7ondFgt9CnCItExjxpAvby0V7XIEK1+63B9sQSAr3JGS
    KluYT5l6ncwNXD3VUAUxRr+BGxhNZRyMu1ycb8Q7pcQShai19QEE7PCpl2I+0HNcLz6Keu
    0dBkFz+LckzuyinfDfBPlumeaGH9v3ug+58RjT26effdichFLPq363rOMeRofOd9CoWCzU
    yA48wwkJzyioKKFUHdgFKPmHmfmrQ4Vc23bYZFietMEy4oIQEBJa/OLyC3VCn6XNSWpJxI
    lLbxNTxANGetYmFdUrGLPiD9Arm8hb567WV4IcGH9gAQ9BYS/2t6sY4BtdnxQNoHw2CWVs
    XHoOVKIgNg1ONWTI02EBrKtPiJcbtBWhmEyJYrbwfO9Bf73abTtZtfAhThkyxhf39BNIFA
    WAaGp2G8sPg4FXHOd33qSHTiP5BKXSdbkAPs2aL2xmNWJy/ojOpDlMGwcwCQ
X-ME-Proxy: <xmx:LDFOaptgCzJ9UBJABadjNud1Dx1B9cbRVwdQjLxhscy7yPwrIlWgWQ>
    <xmx:LDFOaqq2T8-3u-hs4Ra0ksaBBGhImiDHOjSj01Drb_51GlG1UeOB6g>
    <xmx:LDFOakGUDrPbAfaArI6s41cVgMvEg9W07B9vLAewaSuMgx4zogRSXg>
    <xmx:LDFOat6rRLD0lJJkPJtQg9Rd8vGpHAYX5uLs3MIFfO6YzdCAvCQfsw>
    <xmx:LDFOai7Z8vP-SwlZGNhOVLROp_-S8uYKWSqvJW3otr_UftJlCjcGGasu>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 07:14:51 -0400 (EDT)
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
Subject: [PATCH v10 13/15] userfaultfd: add UFFDIO_SET_MODE for runtime sync/async toggle
Date: Wed,  8 Jul 2026 12:14:14 +0100
Message-ID: <20260708111417.173443-14-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708111417.173443-1-kirill@shutemov.name>
References: <20260708111417.173443-1-kirill@shutemov.name>
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
 mm/userfaultfd.c                 | 152 +++++++++++++++++++++++++------
 2 files changed, 137 insertions(+), 29 deletions(-)

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
index 3c887aaa1056..73f32299453b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2486,19 +2486,29 @@ struct userfaultfd_wake_range {
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
@@ -2513,7 +2523,7 @@ bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
 	if (!ctx)
 		return false;
 
-	return ctx->features & UFFD_FEATURE_WP_UNPOPULATED;
+	return userfaultfd_features(ctx) & UFFD_FEATURE_WP_UNPOPULATED;
 }
 
 static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
@@ -3750,7 +3760,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_RWP) {
 		if (!pgtable_supports_uffd() || VM_UFFD_RWP == VM_NONE)
 			goto out;
-		if (!(ctx->features & UFFD_FEATURE_RWP))
+		if (!(userfaultfd_features(ctx) & UFFD_FEATURE_RWP))
 			goto out;
 		vm_flags |= VM_UFFD_RWP;
 	}
@@ -4310,6 +4320,109 @@ static int userfaultfd_rwprotect(struct userfaultfd_ctx *ctx,
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
@@ -4548,29 +4661,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
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
@@ -4640,6 +4731,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
 	case UFFDIO_RWPROTECT:
 		ret = userfaultfd_rwprotect(ctx, arg);
 		break;
+	case UFFDIO_SET_MODE:
+		ret = userfaultfd_set_mode(ctx, arg);
+		break;
 	}
 	return ret;
 }
@@ -4667,7 +4761,7 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
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

