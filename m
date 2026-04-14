Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6983E8C5D;
	Tue, 14 Apr 2026 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176641; cv=none; b=DKAN/c+MZl9egacnVx4Q+Wnh5oaEPUDpvY3SAFF4XoOWPiSRehJRC8tQskHE532G2v+r6nUL3XPtG/D6uZ3E4udBtIJvfvORLk30OtNwY8RGpFT6SF5clpREL/YHkOTOGEL65+CHqDl6YtKo3+fyVDLkVFoRCFDXFDKDryMI/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176641; c=relaxed/simple;
	bh=bxAJ7DEU0c8W9EDIeCuV7eYhdJmY4/plj4fpznSsaWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyeLAsWzGQZUbNyb4dLqsZ0VErDkVFPbFmLiV+fD5RPrE34pIEzlQVIEmsYIWx4PxgZe/6QWwcnTyiMYU9fkQmWlQfPjNS4j/xsbHKBiPYQihP05yQDInKz4BZVwMv9IQw71/XA7vvhipxMApm7KBtd3yFNersMcf0TD0n5gUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNC07lkp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNC07lkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DE6C19425;
	Tue, 14 Apr 2026 14:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176641;
	bh=bxAJ7DEU0c8W9EDIeCuV7eYhdJmY4/plj4fpznSsaWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PNC07lkpEWnmGuIw4RQ3p0swT7wwprKfoNCH9q69rZMjPQEKg3bcH8z7leYqtnN9d
	 3FOVETsOWs8tBhSFUGsMty3w/mVyjpNF7pVCos4JsK29ZyO1S1xkkF/Dat45eMwbxq
	 OqOKqLDJAgoW/ilWIGQYDgu6Y9VhoDtcUwfvh4sldyUWm+XxBJTfiDe0qqs4dwN7D5
	 Xeo4vangahMPI1WZe1mc2KIPNnhlhLEVGzBRv/q283kkG6QhllAK3H1Ha2hLjGmOSA
	 1XVpynGj5DA1N0daVxjFVdwuIR985L6LCvLG9or9hMvZ3q6K7oJldWl7znkvB9ZvRq
	 d0u2XfwJpNbZQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 54360F4006E;
	Tue, 14 Apr 2026 10:24:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 10:24:00 -0400
X-ME-Sender: <xms:AE7eaRshi_3Xgp-KKwM0WVCjinEUJLFI9P0yzvzeKjpx3E70oKvzlw>
    <xme:AE7eaRa4wvcvnHZPs5PmTfa-9qi1YkIFsIZ8RqeChSkI05zdiy3sWAPwB8zU12qFJ
    ALinR10FGGGeSKPomuO38sBdPKY-h0lncDuWjwVm18T7igE8uy6Iw>
X-ME-Received: <xmr:AE7eaZ13g-mmJY-DC2zF7I8FMTPwu2pg8yWGhYY8W6XXcWKD2fFG574TOs8xJw>
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
X-ME-Proxy: <xmx:AE7eafUz4xl-vmdYY-DSgxJMVdjn4ayzF65pPsCEbuQOBaO3UHUjKQ>
    <xmx:AE7eacsxppwmZvDp95qZ-xkSon5s1fKlMsUUfo_lCqSdhu64nnUUKg>
    <xmx:AE7eaeVsdXFTi-LB9a7H9mCGzjF-uXx3eVGxNFtPm7PjAaIcmRzYmw>
    <xmx:AE7eaQVkPfvJsckKKXTsh2oRO5BGETrZJlANDLUWN3H7zwt0ZIU2zw>
    <xmx:AE7eaQdjn4f27NUHCVkeiDBJeFvctgSQghUzDumC8SKJm3KHHIAxEqCj>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:23:59 -0400 (EDT)
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
Subject: [RFC, PATCH 02/12] userfaultfd: add UFFD_FEATURE_MINOR_ANON registration support
Date: Tue, 14 Apr 2026 15:23:36 +0100
Message-ID: <20260414142354.1465950-3-kas@kernel.org>
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

Allow UFFDIO_REGISTER_MODE_MINOR on anonymous VMAs when the
UFFD_FEATURE_MINOR_ANON feature is enabled.

Replace the bool wp_async parameter in vma_can_userfault() and
userfaultfd_register_range() with an extensible ctx_flags bitmap.
Add UFFD_CTX_WP_ASYNC and UFFD_CTX_MINOR_ANON flags, and
userfaultfd_ctx_flags() to build the bitmap from ctx->features.

Add userfaultfd_minor_async() helper for checking async minor mode
from the fault path.

Gate UFFD_FEATURE_MINOR_ANON and UFFD_FEATURE_MINOR_ASYNC on
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR. Validate that MINOR_ASYNC
requires at least one minor feature.

Not yet visible to userspace (not in UFFD_API_FEATURES).

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
 fs/userfaultfd.c              | 49 ++++++++++++++++++++++++++++++-----
 include/linux/userfaultfd_k.h | 19 +++++++++++---
 mm/userfaultfd.c              |  4 +--
 3 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index bdc84e5219cd..8d508ad19e89 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -89,6 +89,27 @@ static bool userfaultfd_wp_async_ctx(struct userfaultfd_ctx *ctx)
 	return ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC);
 }
 
+static bool userfaultfd_minor_anon_ctx(struct userfaultfd_ctx *ctx)
+{
+	return ctx && (ctx->features & UFFD_FEATURE_MINOR_ANON);
+}
+
+static bool userfaultfd_minor_async_ctx(struct userfaultfd_ctx *ctx)
+{
+	return ctx && (ctx->features & UFFD_FEATURE_MINOR_ASYNC);
+}
+
+static unsigned int userfaultfd_ctx_flags(struct userfaultfd_ctx *ctx)
+{
+	unsigned int flags = 0;
+
+	if (userfaultfd_wp_async_ctx(ctx))
+		flags |= UFFD_CTX_WP_ASYNC;
+	if (userfaultfd_minor_anon_ctx(ctx))
+		flags |= UFFD_CTX_MINOR_ANON;
+	return flags;
+}
+
 /*
  * Whether WP_UNPOPULATED is enabled on the uffd context.  It is only
  * meaningful when userfaultfd_wp()==true on the vma and when it's
@@ -1271,7 +1292,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	bool basic_ioctls;
 	unsigned long start, end;
 	struct vma_iterator vmi;
-	bool wp_async = userfaultfd_wp_async_ctx(ctx);
+	unsigned int ctx_flags = userfaultfd_ctx_flags(ctx);
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
 
@@ -1345,7 +1366,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 		/* check not compatible vmas */
 		ret = -EINVAL;
-		if (!vma_can_userfault(cur, vm_flags, wp_async))
+		if (!vma_can_userfault(cur, vm_flags, ctx_flags))
 			goto out_unlock;
 
 		/*
@@ -1398,7 +1419,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	VM_WARN_ON_ONCE(!found);
 
 	ret = userfaultfd_register_range(ctx, vma, vm_flags, start, end,
-					 wp_async);
+					 ctx_flags);
 
 out_unlock:
 	mmap_write_unlock(mm);
@@ -1443,7 +1464,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
 	struct vma_iterator vmi;
-	bool wp_async = userfaultfd_wp_async_ctx(ctx);
+	unsigned int ctx_flags = userfaultfd_ctx_flags(ctx);
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1505,7 +1526,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		 * provides for more strict behavior to notice
 		 * unregistration errors.
 		 */
-		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
+		if (!vma_can_userfault(cur, cur->vm_flags, ctx_flags))
 			goto out_unlock;
 
 		found = true;
@@ -1526,7 +1547,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			goto skip;
 
 		VM_WARN_ON_ONCE(vma->vm_userfaultfd_ctx.ctx != ctx);
-		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vma->vm_flags, wp_async));
+		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vma->vm_flags, ctx_flags));
 		VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MAYWRITE));
 
 		if (vma->vm_start > start)
@@ -1890,6 +1911,11 @@ bool userfaultfd_wp_async(struct vm_area_struct *vma)
 	return userfaultfd_wp_async_ctx(vma->vm_userfaultfd_ctx.ctx);
 }
 
+bool userfaultfd_minor_async(struct vm_area_struct *vma)
+{
+	return userfaultfd_minor_async_ctx(vma->vm_userfaultfd_ctx.ctx);
+}
+
 static inline unsigned int uffd_ctx_features(__u64 user_features)
 {
 	/*
@@ -1993,11 +2019,20 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	if (features & UFFD_FEATURE_WP_ASYNC)
 		features |= UFFD_FEATURE_WP_UNPOPULATED;
 
+	ret = -EINVAL;
+	/* MINOR_ASYNC requires at least one minor feature */
+	if ((features & UFFD_FEATURE_MINOR_ASYNC) &&
+	    !(features & (UFFD_FEATURE_MINOR_ANON |
+			  UFFD_FEATURE_MINOR_HUGETLBFS |
+			  UFFD_FEATURE_MINOR_SHMEM)))
+		goto err_out;
+
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 	uffdio_api.features &=
-		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
+		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM |
+		  UFFD_FEATURE_MINOR_ANON | UFFD_FEATURE_MINOR_ASYNC);
 #endif
 	if (!pgtable_supports_uffd_wp())
 		uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index fd5f42765497..d1d4ed4a08b0 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -208,9 +208,13 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return vma->vm_flags & __VM_UFFD_FLAGS;
 }
 
+/* Flags for vma_can_userfault() describing uffd context capabilities */
+#define UFFD_CTX_WP_ASYNC	(1 << 0)
+#define UFFD_CTX_MINOR_ANON	(1 << 1)
+
 static inline bool vma_can_userfault(struct vm_area_struct *vma,
 				     vm_flags_t vm_flags,
-				     bool wp_async)
+				     unsigned int ctx_flags)
 {
 	vm_flags &= __VM_UFFD_FLAGS;
 
@@ -218,14 +222,15 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 		return false;
 
 	if ((vm_flags & VM_UFFD_MINOR) &&
-	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
+	    !is_vm_hugetlb_page(vma) && !vma_is_shmem(vma) &&
+	    !(vma_is_anonymous(vma) && (ctx_flags & UFFD_CTX_MINOR_ANON)))
 		return false;
 
 	/*
 	 * If wp async enabled, and WP is the only mode enabled, allow any
 	 * memory type.
 	 */
-	if (wp_async && (vm_flags == VM_UFFD_WP))
+	if ((ctx_flags & UFFD_CTX_WP_ASYNC) && (vm_flags == VM_UFFD_WP))
 		return true;
 
 	/*
@@ -270,6 +275,7 @@ extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
 extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
 extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
+extern bool userfaultfd_minor_async(struct vm_area_struct *vma);
 
 void userfaultfd_reset_ctx(struct vm_area_struct *vma);
 
@@ -283,7 +289,7 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 			       struct vm_area_struct *vma,
 			       vm_flags_t vm_flags,
 			       unsigned long start, unsigned long end,
-			       bool wp_async);
+			       unsigned int ctx_flags);
 
 void userfaultfd_release_new(struct userfaultfd_ctx *ctx);
 
@@ -446,6 +452,11 @@ static inline bool userfaultfd_wp_async(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_minor_async(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
 {
 	return false;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 927086bb4a3c..dba1ea26fdfe 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2008,7 +2008,7 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 			       struct vm_area_struct *vma,
 			       vm_flags_t vm_flags,
 			       unsigned long start, unsigned long end,
-			       bool wp_async)
+			       unsigned int ctx_flags)
 {
 	VMA_ITERATOR(vmi, ctx->mm, start);
 	struct vm_area_struct *prev = vma_prev(&vmi);
@@ -2021,7 +2021,7 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
-		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));
+		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, ctx_flags));
 		VM_WARN_ON_ONCE(vma->vm_userfaultfd_ctx.ctx &&
 				vma->vm_userfaultfd_ctx.ctx != ctx);
 		VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MAYWRITE));
-- 
2.51.2

