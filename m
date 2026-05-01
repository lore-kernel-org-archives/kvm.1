Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180E4219E7
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 20:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667751; cv=none; b=B4d0Pq9EQOyXPvxi68NrwYUopVcjWHh4bWMN7ClMTVejBAcN+dafaXsFJHC1nn0l80IKKP9rviJR9n52fC4GMRvse4cJTjvNEPVePXgZHOs6+KJH2nABouIGtAKlxb8oHXkXiYeZnqAzRSkdWKNS8Smvy1nyZ4LlFipeh618QhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667751; c=relaxed/simple;
	bh=Rlg4Fh/OJMOGGM68mvWjoZtGIv4+CjGrzl5e3f/h7OQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HU9Qp2b952S3U20PRWO9qpalSVZfKHL5prn6KpHOVKUGWX/niDE1ReZ0606mcutDwgu7uA4RBG0mxRlbez+t1pgIixFwlF22CY1Ed4AA3OiL8oZnKWjAqy+RsEi2KL0NuYP1jhBaXvhNLUx4jDYafbAJuj0hqbZl3J8CpDhIR3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aGTgjfCX; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGTgjfCX"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f504f6b75so1230897b3a.1
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 13:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777667749; x=1778272549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=K56fVDi5EkAo7p4gllqrxnHbaoeRU2pIE/SomnN3Fyk=;
        b=aGTgjfCXJ7phaQ0DopTy2LAUNmGddZ9gmgA/7mzUbQPF15nNJG274/nVDE87VLcRTv
         BwA94zYh5eetUvmIlWNhDsorfBnb+9kSMubOFtXVd6Rj7Vwk7phAGDW4kniMBu6Wy2EG
         pow7m/taPj1kmmN3XBPh/sRVbQE5soyKNQ3GBMTsEyij5aq14IcsDS0AOQJxrJGwJTSZ
         p/K/HEU8RJBezNh3icZrLoG4XjAERGsL3Q8jntm+e0tYGMa1ONSavUFNjBzDB6v5PHdK
         8immsamlrkc9CrFZYTkkCjUoP8vueQJ1map+6wPwHYfI9aVHjPCfmw9ShkWOdy7IyU2t
         Qz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777667749; x=1778272549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K56fVDi5EkAo7p4gllqrxnHbaoeRU2pIE/SomnN3Fyk=;
        b=nJwU2jSYOmWhENj1APDd+OZuZt58j+zcsAcf66jr/5cz1qhn5PbgksNlg+otaHovcI
         R2VM3zRdJDRomoCnXCw7GNmMZCRwD2rqDJQb64UlPP6iGuWN/vgig+jbldqc5nXDJHwt
         CoZrjesgn+MRF9mjzoiSqugKyHBH5qEj8eRJjyJtVXrMklG7Wyq98pGvFjqqgrMFVUkM
         pSsqEVYGgmmQzEGlnKEJQChPVdpZ26rFUb8HhGVC+NIx+YT2/Ma4rxpp+5VZVDKGI57b
         E6KQzTtny+/EAhvqtbPhrOc3rGqZ92Roq5u32YLNVyrtJYuC7awehGqFtEA7eGUytsah
         5FoQ==
X-Gm-Message-State: AOJu0YwmUDX69+tY36dBRbiksJOV/N2mRzftxG/7Mnfamddb+UOcs77e
	2cN68lB02b256RTZaSImS7etNAH9t+b9xqXunlg+YPf+IcakP6tuYqpxthH3ReThquZRZUvSepa
	GMM7YPg==
X-Received: from pfbbn21.prod.google.com ([2002:a05:6a00:3255:b0:82f:8cba:4285])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:430a:b0:82c:6b23:6d10
 with SMTP id d2e1a72fcca58-8352d03a355mr645681b3a.3.1777667748889; Fri, 01
 May 2026 13:35:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 May 2026 13:35:35 -0700
In-Reply-To: <20260501203537.2120074-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501203537.2120074-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501203537.2120074-5-seanjc@google.com>
Subject: [PATCH v2 4/6] KVM: SEV: Add helper function to pin/unpin a single page
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add helpers to pin/unpin a single page, and use it in all flows that pin
exactly one page.  None of the single-page users actually check that the
correct number of pages was pinned, which is functionally ok, but visually
jarring, especially in the decrypt/encrypt flow, which separately pins two
pages, but uses a single variable to track how pages were pinned each time.
Again, it's functionally ok since core mm guarantees exactly one page will
be pinned on success, but it's ugly.

Opportunistically use page_to_phys() instead of open coding an equivalent
via page_to_pfn().

Note, all users of the single-page helper pre-validate the address and
length, i.e. don't rely on the sanity check in sev_pin_memory().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 145 +++++++++++++++++++++++++----------------
 1 file changed, 90 insertions(+), 55 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 9d2044fd910d..4146c91788fb 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -720,14 +720,50 @@ static int sev_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
+static int sev_check_pin_count(struct kvm *kvm, unsigned long npages)
+{
+	unsigned long total_npages, lock_limit;
+
+	total_npages = to_kvm_sev_info(kvm)->pages_locked + npages;
+	if (total_npages > totalram_pages())
+		return -EINVAL;
+
+	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	if (total_npages > lock_limit && !capable(CAP_IPC_LOCK)) {
+		pr_err_ratelimited("SEV: %lu total pages would exceed the lock limit of %lu.\n",
+				   total_npages, lock_limit);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int sev_pin_user_pages(struct kvm *kvm, unsigned long addr, int npages,
+			      unsigned int gup_flags, struct page **pages)
+{
+	int npinned;
+
+	lockdep_assert_held(&kvm->lock);
+
+	npinned = pin_user_pages_fast(addr, npages, gup_flags, pages);
+	if (npinned != npages) {
+		if (npinned > 0)
+			unpin_user_pages(pages, npinned);
+		pr_err_ratelimited("SEV: Failure locking %u pages.\n", npages);
+		return -ENOMEM;
+	}
+
+	to_kvm_sev_info(kvm)->pages_locked += npages;
+	return 0;
+}
+
 static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 				    unsigned long ulen, unsigned long *n,
 				    unsigned int flags)
 {
-	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
-	unsigned long npages, total_npages, lock_limit;
+	unsigned long npages;
 	struct page **pages;
-	int npinned, ret;
+	int ret;
 
 	lockdep_assert_held(&kvm->lock);
 
@@ -743,16 +779,9 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 	if (npages > INT_MAX)
 		return ERR_PTR(-EINVAL);
 
-	total_npages = sev->pages_locked + npages;
-	if (total_npages > totalram_pages())
-		return ERR_PTR(-EINVAL);
-
-	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-	if (total_npages > lock_limit && !capable(CAP_IPC_LOCK)) {
-		pr_err("SEV: %lu total pages would exceed the lock limit of %lu.\n",
-		       total_npages, lock_limit);
-		return ERR_PTR(-ENOMEM);
-	}
+	ret = sev_check_pin_count(kvm, npages);
+	if (ret)
+		return ERR_PTR(ret);
 
 	/*
 	 * Don't WARN if the kernel (rightly) thinks the total size is absurd,
@@ -764,25 +793,14 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 	if (!pages)
 		return ERR_PTR(-ENOMEM);
 
-	/* Pin the user virtual address. */
-	npinned = pin_user_pages_fast(uaddr, npages, flags, pages);
-	if (npinned != npages) {
-		pr_err("SEV: Failure locking %lu pages.\n", npages);
-		ret = -ENOMEM;
-		goto err;
+	ret = sev_pin_user_pages(kvm, uaddr, npages, flags, pages);
+	if (ret) {
+		kvfree(pages);
+		return ERR_PTR(ret);
 	}
 
 	*n = npages;
-	sev->pages_locked = total_npages;
-
 	return pages;
-
-err:
-	if (npinned > 0)
-		unpin_user_pages(pages, npinned);
-
-	kvfree(pages);
-	return ERR_PTR(ret);
 }
 
 static void sev_unpin_memory(struct kvm *kvm, struct page **pages,
@@ -793,6 +811,29 @@ static void sev_unpin_memory(struct kvm *kvm, struct page **pages,
 	to_kvm_sev_info(kvm)->pages_locked -= npages;
 }
 
+static struct page *sev_pin_page(struct kvm *kvm, unsigned long addr,
+				 unsigned int flags)
+{
+	struct page *page;
+	int r;
+
+	r = sev_check_pin_count(kvm, 1);
+	if (r)
+		return ERR_PTR(r);
+
+	r = sev_pin_user_pages(kvm, addr, 1, flags, &page);
+	if (r)
+		return ERR_PTR(r);
+
+	return page;
+}
+
+static void sev_unpin_page(struct kvm *kvm, struct page *page)
+{
+	unpin_user_pages(&page, 1);
+	to_kvm_sev_info(kvm)->pages_locked -= 1;
+}
+
 static void sev_clflush_pages(struct page *pages[], unsigned long npages)
 {
 	uint8_t *page_virtual;
@@ -1345,9 +1386,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 {
 	unsigned long vaddr, vaddr_end, next_vaddr;
 	unsigned long dst_vaddr;
-	struct page **src_p, **dst_p;
+	struct page *src_p, *dst_p;
 	struct kvm_sev_dbg debug;
-	unsigned long n;
 	unsigned int size;
 	int ret;
 
@@ -1373,13 +1413,13 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 		int len, s_off, d_off;
 
 		/* lock userspace source and destination page */
-		src_p = sev_pin_memory(kvm, vaddr & PAGE_MASK, PAGE_SIZE, &n, 0);
+		src_p = sev_pin_page(kvm, vaddr & PAGE_MASK, 0);
 		if (IS_ERR(src_p))
 			return PTR_ERR(src_p);
 
-		dst_p = sev_pin_memory(kvm, dst_vaddr & PAGE_MASK, PAGE_SIZE, &n, FOLL_WRITE);
+		dst_p = sev_pin_page(kvm, dst_vaddr & PAGE_MASK, FOLL_WRITE);
 		if (IS_ERR(dst_p)) {
-			sev_unpin_memory(kvm, src_p, n);
+			sev_unpin_page(kvm, src_p);
 			return PTR_ERR(dst_p);
 		}
 
@@ -1388,8 +1428,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 		 * the pages; flush the destination too so that future accesses do not
 		 * see stale data.
 		 */
-		sev_clflush_pages(src_p, 1);
-		sev_clflush_pages(dst_p, 1);
+		sev_clflush_pages(&src_p, 1);
+		sev_clflush_pages(&dst_p, 1);
 
 		/*
 		 * Since user buffer may not be page aligned, calculate the
@@ -1402,20 +1442,20 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 
 		if (dec)
 			ret = __sev_dbg_decrypt_user(kvm,
-						     __sme_page_pa(src_p[0]) + s_off,
+						     __sme_page_pa(src_p) + s_off,
 						     (void __user *)dst_vaddr,
-						     __sme_page_pa(dst_p[0]) + d_off,
+						     __sme_page_pa(dst_p) + d_off,
 						     len, &argp->error);
 		else
 			ret = __sev_dbg_encrypt_user(kvm,
-						     __sme_page_pa(src_p[0]) + s_off,
+						     __sme_page_pa(src_p) + s_off,
 						     (void __user *)vaddr,
-						     __sme_page_pa(dst_p[0]) + d_off,
+						     __sme_page_pa(dst_p) + d_off,
 						     (void __user *)dst_vaddr,
 						     len, &argp->error);
 
-		sev_unpin_memory(kvm, src_p, n);
-		sev_unpin_memory(kvm, dst_p, n);
+		sev_unpin_page(kvm, src_p);
+		sev_unpin_page(kvm, dst_p);
 
 		if (ret)
 			goto err;
@@ -1698,8 +1738,7 @@ static int sev_send_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	struct sev_data_send_update_data data;
 	struct kvm_sev_send_update_data params;
 	void *hdr, *trans_data;
-	struct page **guest_page;
-	unsigned long n;
+	struct page *guest_page;
 	int ret, offset;
 
 	if (!sev_guest(kvm))
@@ -1723,8 +1762,7 @@ static int sev_send_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		return -EINVAL;
 
 	/* Pin guest memory */
-	guest_page = sev_pin_memory(kvm, params.guest_uaddr & PAGE_MASK,
-				    PAGE_SIZE, &n, 0);
+	guest_page = sev_pin_page(kvm, params.guest_uaddr & PAGE_MASK, 0);
 	if (IS_ERR(guest_page))
 		return PTR_ERR(guest_page);
 
@@ -1745,7 +1783,7 @@ static int sev_send_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	data.trans_len = params.trans_len;
 
 	/* The SEND_UPDATE_DATA command requires C-bit to be always set. */
-	data.guest_address = (page_to_pfn(guest_page[0]) << PAGE_SHIFT) + offset;
+	data.guest_address = page_to_phys(guest_page) + offset;
 	data.guest_address |= sev_me_mask;
 	data.guest_len = params.guest_len;
 	data.handle = to_kvm_sev_info(kvm)->handle;
@@ -1772,8 +1810,7 @@ static int sev_send_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 e_free_hdr:
 	kfree(hdr);
 e_unpin:
-	sev_unpin_memory(kvm, guest_page, n);
-
+	sev_unpin_page(kvm, guest_page);
 	return ret;
 }
 
@@ -1878,8 +1915,7 @@ static int sev_receive_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	struct kvm_sev_receive_update_data params;
 	struct sev_data_receive_update_data data;
 	void *hdr = NULL, *trans = NULL;
-	struct page **guest_page;
-	unsigned long n;
+	struct page *guest_page;
 	int ret, offset;
 
 	if (!sev_guest(kvm))
@@ -1916,8 +1952,7 @@ static int sev_receive_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	data.trans_len = params.trans_len;
 
 	/* Pin guest memory */
-	guest_page = sev_pin_memory(kvm, params.guest_uaddr & PAGE_MASK,
-				    PAGE_SIZE, &n, FOLL_WRITE);
+	guest_page = sev_pin_page(kvm, params.guest_uaddr & PAGE_MASK, FOLL_WRITE);
 	if (IS_ERR(guest_page)) {
 		ret = PTR_ERR(guest_page);
 		goto e_free_trans;
@@ -1928,10 +1963,10 @@ static int sev_receive_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	 * encrypts the written data with the guest's key, and the cache may
 	 * contain dirty, unencrypted data.
 	 */
-	sev_clflush_pages(guest_page, n);
+	sev_clflush_pages(&guest_page, 1);
 
 	/* The RECEIVE_UPDATE_DATA command requires C-bit to be always set. */
-	data.guest_address = (page_to_pfn(guest_page[0]) << PAGE_SHIFT) + offset;
+	data.guest_address = page_to_phys(guest_page) + offset;
 	data.guest_address |= sev_me_mask;
 	data.guest_len = params.guest_len;
 	data.handle = to_kvm_sev_info(kvm)->handle;
@@ -1939,7 +1974,7 @@ static int sev_receive_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	ret = sev_issue_cmd(kvm, SEV_CMD_RECEIVE_UPDATE_DATA, &data,
 				&argp->error);
 
-	sev_unpin_memory(kvm, guest_page, n);
+	sev_unpin_page(kvm, guest_page);
 
 e_free_trans:
 	kfree(trans);
-- 
2.54.0.545.g6539524ca2-goog

