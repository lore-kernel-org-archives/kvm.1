Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD63EBF37;
	Tue, 14 Apr 2026 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176655; cv=none; b=jh99smQ9GslYtEfB6LveHcvd+gHeockDlK4gbDLdHvGUZm89FGu6dY+fXECgpi4xgl3AUgB/cWzhtOxAFJ5BPFCbT/vE0H3mPBgrNDFC4I3VwMXCSZw9jCBRJaWHEPi0QxVztpl3QRHT5k9NJnEZmcG2D6xS09iBX9xW7AC7Mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176655; c=relaxed/simple;
	bh=wU9XhAWdOkm2epOMZqX4k9UHuR2i8O/RDnn4cDbflLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAsZuw29gd3g4CP8D4VU3ciIYLw74ELWrzfVTVGWRG9QZ0vBL13SH+4uVgV3oWcHKleu6LfJI4OqWSR1Lb7dmG1SSQ/adAea6wYPEOxiXOtJS+snf3T75pogbpmXqBC9ws1s1kdf2YE48W7YseljwKCjvfX/DnAdDIXe8E7dCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1DIGAsn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1DIGAsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8A7C4AF09;
	Tue, 14 Apr 2026 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176655;
	bh=wU9XhAWdOkm2epOMZqX4k9UHuR2i8O/RDnn4cDbflLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1DIGAsniyY8vj4+mAakxpkv9iBsInZPGyST0/WXXjMQGAuCTtS8/cmieVr3Ye5Ul
	 rF6mcAKzF684kHK2IctebHCD8ljK9Tv2VFCyG7oSLj1PAGSJbN/gvuIWuE/aYe8iJP
	 P7fUpR+L9IXRzv16wGuwtf7IFh5r6lQCx6AMmIlgF8Q0Lj8c2hdTI3/q4tfckAqL4i
	 p2K6ICCBx6Rri0H/Uk8AhigoALkVc4ZBFRbIqXB2Tw23ajt2XK3+sGk4QQFD7BXWS4
	 PPHbcFBvo3JNfaj7Wku9j0LGRhHmnF3e8aH55BCFY4Qg0TGVUfKVBB8wyn3g9c6zu8
	 i6nJt/in9MD6w==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 421D8F4006F;
	Tue, 14 Apr 2026 10:24:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 14 Apr 2026 10:24:14 -0400
X-ME-Sender: <xms:Dk7eaYqI27hsNvix2EPZxKVuvcYdoPuEppH7El0A6dfwJ6sLPvumYw>
    <xme:Dk7eaVl8QJKm5Gg4FHtOxm7VUZUoqBRHyGs-eG00kdOTPUoadqPBBaz84ExolXrpS
    ybwi5Xla3zUi57zYAgsah3tun21RAmEJrF1Eh8tloIa_-L7GO244gs>
X-ME-Received: <xmr:Dk7eaSQ6KLe9DBEXvv7zUze0hStzZpwuck1YZOzwuCgewegYvcM-QRB3RsXVww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfmfhirhihlhcu
    ufhhuhhtshgvmhgruhculdfovghtrgdmfdcuoehkrghssehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhephfdujeefvdegkefffedvkeehkeekueevfedtleehgeetlefg
    feevveeukefhtdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqddu
    ieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghessh
    hhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopegu
    rghvihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehljhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    rhgvnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:Dk7eaXBRQxby81eJQ09tIpX5wnaqAWdYU9yTBINeIx-4Voth2bS4Cg>
    <xmx:Dk7eaSpBc0PsFsAeRHo6gQptwun0PvtIEjUBNtK1NHywsoSAgsZoHQ>
    <xmx:Dk7eaVhSKEC35Fqwid3zGuX0_-Sy0RNp_Xl-uhts-r_xtg74dNxszQ>
    <xmx:Dk7eafxnkvdJQBYXnFFycV1qd9HnMMH6h18AfVl4GDhb-NEUs3Brmw>
    <xmx:Dk7eaTL9FTMXqSC84SYr7DyvLsWGLK9jQdMCbnVbmbk5lOdtXjAk1YMp>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:24:13 -0400 (EDT)
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
Subject: [RFC, PATCH 10/12] userfaultfd: add UFFDIO_SET_MODE for runtime sync/async toggle
Date: Tue, 14 Apr 2026 15:23:44 +0100
Message-ID: <20260414142354.1465950-11-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260414142354.1465950-1-kas@kernel.org>
References: <20260414142354.1465950-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add UFFDIO_SET_MODE ioctl to toggle UFFD_FEATURE_MINOR_ASYNC at
runtime. Takes mmap_write_lock for serialization against all in-flight
faults. On sync-to-async transition, wake threads blocked in
handle_userfault() so they retry and auto-resolve.

Since ctx->features can now be modified concurrently, add
userfaultfd_features() helper that wraps READ_ONCE() and convert
all ctx->features reads to use it.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
 fs/userfaultfd.c                 | 95 ++++++++++++++++++++++++++++----
 include/uapi/linux/userfaultfd.h | 13 +++++
 2 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 43064238fd8d..0edb33599491 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -79,24 +79,33 @@ struct userfaultfd_wake_range {
 /* internal indication that UFFD_API ioctl was successfully executed */
 #define UFFD_FEATURE_INITIALIZED		(1u << 31)
 
+/*
+ * Read ctx->features with READ_ONCE() since UFFDIO_SET_MODE can
+ * modify it concurrently.
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
 
 static bool userfaultfd_minor_anon_ctx(struct userfaultfd_ctx *ctx)
 {
-	return ctx && (ctx->features & UFFD_FEATURE_MINOR_ANON);
+	return ctx && (userfaultfd_features(ctx) & UFFD_FEATURE_MINOR_ANON);
 }
 
 static bool userfaultfd_minor_async_ctx(struct userfaultfd_ctx *ctx)
 {
-	return ctx && (ctx->features & UFFD_FEATURE_MINOR_ASYNC);
+	return ctx && (userfaultfd_features(ctx) & UFFD_FEATURE_MINOR_ASYNC);
 }
 
 static unsigned int userfaultfd_ctx_flags(struct userfaultfd_ctx *ctx)
@@ -122,7 +131,7 @@ bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
 	if (!ctx)
 		return false;
 
-	return ctx->features & UFFD_FEATURE_WP_UNPOPULATED;
+	return userfaultfd_features(ctx) & UFFD_FEATURE_WP_UNPOPULATED;
 }
 
 static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
@@ -435,7 +444,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	/* 0 or > 1 flags set is a bug; we expect exactly 1. */
 	VM_WARN_ON_ONCE(!reason || (reason & (reason - 1)));
 
-	if (ctx->features & UFFD_FEATURE_SIGBUS)
+	if (userfaultfd_features(ctx) & UFFD_FEATURE_SIGBUS)
 		goto out;
 	if (!(vmf->flags & FAULT_FLAG_USER) && (ctx->flags & UFFD_USER_MODE_ONLY))
 		goto out;
@@ -506,7 +515,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	init_waitqueue_func_entry(&uwq.wq, userfaultfd_wake_function);
 	uwq.wq.private = current;
 	uwq.msg = userfault_msg(vmf->address, vmf->real_address, vmf->flags,
-				reason, ctx->features);
+				reason, userfaultfd_features(ctx));
 	uwq.ctx = ctx;
 	uwq.waken = false;
 
@@ -668,7 +677,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 	if (!octx)
 		return 0;
 
-	if (!(octx->features & UFFD_FEATURE_EVENT_FORK)) {
+	if (!(userfaultfd_features(octx) & UFFD_FEATURE_EVENT_FORK)) {
 		userfaultfd_reset_ctx(vma);
 		return 0;
 	}
@@ -774,7 +783,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 	if (!ctx)
 		return;
 
-	if (ctx->features & UFFD_FEATURE_EVENT_REMAP) {
+	if (userfaultfd_features(ctx) & UFFD_FEATURE_EVENT_REMAP) {
 		vm_ctx->ctx = ctx;
 		userfaultfd_ctx_get(ctx);
 		down_write(&ctx->map_changing_lock);
@@ -824,7 +833,7 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
 	struct userfaultfd_wait_queue ewq;
 
 	ctx = vma->vm_userfaultfd_ctx.ctx;
-	if (!ctx || !(ctx->features & UFFD_FEATURE_EVENT_REMOVE))
+	if (!ctx || !(userfaultfd_features(ctx) & UFFD_FEATURE_EVENT_REMOVE))
 		return true;
 
 	userfaultfd_ctx_get(ctx);
@@ -863,7 +872,7 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma, unsigned long start,
 	struct userfaultfd_unmap_ctx *unmap_ctx;
 	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
 
-	if (!ctx || !(ctx->features & UFFD_FEATURE_EVENT_UNMAP) ||
+	if (!ctx || !(userfaultfd_features(ctx) & UFFD_FEATURE_EVENT_UNMAP) ||
 	    has_unmap_ctx(ctx, unmaps, start, end))
 		return 0;
 
@@ -1826,6 +1835,65 @@ static int userfaultfd_deactivate(struct userfaultfd_ctx *ctx,
 	return ret;
 }
 
+/*
+ * Features that can be toggled at runtime via UFFDIO_SET_MODE.
+ * Only async features that were enabled at UFFDIO_API time may be toggled.
+ */
+#define UFFD_FEATURE_TOGGLEABLE	(UFFD_FEATURE_MINOR_ASYNC)
+
+static int userfaultfd_set_mode(struct userfaultfd_ctx *ctx,
+				  unsigned long arg)
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
+	/* only toggleable features are allowed */
+	if ((mode.enable | mode.disable) & ~UFFD_FEATURE_TOGGLEABLE)
+		return -EINVAL;
+
+	if (!mmget_not_zero(mm))
+		return -ESRCH;
+
+	/*
+	 * mmap_write_lock serializes against all page faults.
+	 * After we release, no in-flight faults from the old mode exist.
+	 */
+	{
+		unsigned int new_features;
+
+		mmap_write_lock(mm);
+		new_features = userfaultfd_features(ctx);
+		new_features |= mode.enable;
+		new_features &= ~mode.disable;
+		WRITE_ONCE(ctx->features, new_features);
+		mmap_write_unlock(mm);
+	}
+
+	/*
+	 * If switching to async, wake threads blocked in handle_userfault().
+	 * They will retry the fault and auto-resolve under the new mode.
+	 * len=0 means wake all pending faults on this context.
+	 */
+	if (mode.enable & UFFD_FEATURE_MINOR_ASYNC) {
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
 
 static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 {
@@ -2150,6 +2218,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
 	case UFFDIO_DEACTIVATE:
 		ret = userfaultfd_deactivate(ctx, arg);
 		break;
+	case UFFDIO_SET_MODE:
+		ret = userfaultfd_set_mode(ctx, arg);
+		break;
 	}
 	return ret;
 }
@@ -2177,7 +2248,7 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
 	 *	protocols: aa:... bb:...
 	 */
 	seq_printf(m, "pending:\t%lu\ntotal:\t%lu\nAPI:\t%Lx:%x:%Lx\n",
-		   pending, total, UFFD_API, ctx->features,
+		   pending, total, UFFD_API, userfaultfd_features(ctx),
 		   UFFD_API_IOCTLS|UFFD_API_RANGE_IOCTLS);
 }
 #endif
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 775825da2596..f0f14f9db06c 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -84,6 +84,7 @@
 #define _UFFDIO_CONTINUE		(0x07)
 #define _UFFDIO_POISON			(0x08)
 #define _UFFDIO_DEACTIVATE		(0x09)
+#define _UFFDIO_SET_MODE		(0x0A)
 #define _UFFDIO_API			(0x3F)
 
 /* userfaultfd ioctl ids */
@@ -110,6 +111,8 @@
 				      struct uffdio_poison)
 #define UFFDIO_DEACTIVATE	_IOR(UFFDIO, _UFFDIO_DEACTIVATE,	\
 				     struct uffdio_range)
+#define UFFDIO_SET_MODE		_IOW(UFFDIO, _UFFDIO_SET_MODE,	\
+				     struct uffdio_set_mode)
 
 /* read() structure */
 struct uffd_msg {
@@ -395,6 +398,16 @@ struct uffdio_move {
 	__s64 move;
 };
 
+struct uffdio_set_mode {
+	/*
+	 * Toggle async mode for features at runtime.
+	 * Supported: UFFD_FEATURE_MINOR_ASYNC.
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

