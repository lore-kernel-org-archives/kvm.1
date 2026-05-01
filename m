Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA0423176
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667756; cv=none; b=AgTI3nVJbnGLl4rRWvACifp0lK5dtjzsiwv1bBThm+dSQI77vmII93NjOLdKaCK5+WreuvyM33H9dSU4kLtbzsqBvrP1TH1GBGPyQpbKVHKK8X2Oa5yV1w8HHDMfjM6BAKv3pVbeP+gVPDbWtA5E3i9sL2LAQMXdwwG5oqtdclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667756; c=relaxed/simple;
	bh=owBtY1ELTAvA1+3avvZSr0u1v4pPHYD2JReBYyVBKOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T1qF4YxbW+i1DQmqB8VESZM3IM5+QO0qTkNVpWzrljnfWmhtocUCRnkE2oU/3fYr2UzEFc7DOP+BOiplBobIdRtK8m5q9vVp1RAJ39fzcQyeLV8JZGdfRlEF2wJoM753tFTKIuPAutKGCXhbGPNQJmg58qZzzXrf200DyRWYbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmT3E4L9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmT3E4L9"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so1241362a12.0
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777667752; x=1778272552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=f7ChgRzJoZv20LTTFq5AT076grxjadNMggjOvVlT0J0=;
        b=TmT3E4L98GsK7p04jHp0WklS51KJM4oaxuO5Q+ybbxmcmPLssaN5SxwSChQUDwVezo
         +cE7705YaapoNaYHbviieal6VYtNCKyEPZ7Dmvm1v8Lb4RwtPhR2rF+G98h4XVV8vTDy
         JUVKrsxFMFLx7EoE+xnRV3mswAOcQ8jSKCO/5YtWHr55a0ZM0xttD30Roif6FmlGufiH
         sjv7OsJlyIjhs1zB4+qP0QHMP3GvYd6IxoB1ZtDzNFi0adQ2b2c1XVY95e6pjRl4cAsp
         UF43LUfNS0gj5vVbZiUU4O6qAcv9PHiPy7oefhtYxAkY7QyO8TiVUM7LxYCY0i3T6nDi
         pLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777667752; x=1778272552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7ChgRzJoZv20LTTFq5AT076grxjadNMggjOvVlT0J0=;
        b=DuwlVaAkSaJjtcNkAJWP10wXPsX0czKMzrcu0rF08bb3glwjkcXPMjkSBYSAawO/Zq
         gLyDoYtE6DHJlTywaRdxauxzwA3+puPZz6vxYLJyfJAyxTPQqRaZOMcWPc58e9nJqJDs
         gHxfL6XoGSqxt9+zuF4UzhiiFqesDAnGyfvja1MO4EvBFKc5EYOo2DMMzmmIT8MAdrtT
         44qT4l05gq+1KTyhg+oazxsmn6pcxpTBMy2bo9IO8IwcIpl8u08RfXbS3HvSFkKTWL3K
         33YTUeZfrroIxRoRmOSQDYbNLH6qRHcpHkNduNllj0/owv1g8JpLZwfVQSKPfwdB4Ztr
         7NXQ==
X-Gm-Message-State: AOJu0YzYkkCJ3wflxb+qFexDFXfeymcqUVK0HApJt0KsRofGEHbHkYCb
	HaxvUQD8ZZnBaKqpi5+4naIfUQ9olT+WzvsLmpQHocBayKZPi6R5s6QSiBxYZJWXT1wy3MvezEA
	SyVFEAw==
X-Received: from pglq9.prod.google.com ([2002:a63:5049:0:b0:c79:81bb:79dd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d26:b0:3a0:71f:ea41
 with SMTP id adf61e73a8af0-3a3d21b2f69mr7795242637.33.1777667751923; Fri, 01
 May 2026 13:35:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 May 2026 13:35:36 -0700
In-Reply-To: <20260501203537.2120074-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501203537.2120074-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501203537.2120074-6-seanjc@google.com>
Subject: [PATCH v2 5/6] KVM: SEV: Rewrite logic to {de,en}crypt memory for debug
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Wholesale rewrite the guts of the debug {de,en}crypt flows, as the existing
code is broken, e.g. doesn't handle cases where the access isn't naturally
sized and aligned, and is so wildly flawed that attempting to salvage the
current code in an iterative fashion would be more risky than a rewrite.

E.g. when encrypting 9 bytes at offset 8, KVM needs to _decrypt_
destination[31:0] into a temporary buffer, buffer[31:0], then copy 9 bytes
from source[8:0] to buffer[16:8], then encrypt buffer[31:0] back into
destination[31:0].  The current code only ever copies 16 bytes, and
bizarrely uses a temporary buffer for the source as well.

To keep the code easier to read and maintain, send the unaligned cases
down dedicated "slow" paths instead of trying to mix and match the possible
combinations in one helper.

For now, preserve the basic approach of the current code, e.g. allocate an
entire page for the temporary buffer, to minimize unwanted changes in
functionality.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 306 +++++++++++++++++++----------------------
 1 file changed, 139 insertions(+), 167 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 4146c91788fb..89586f821c9c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1237,159 +1237,140 @@ static int sev_guest_status(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
-static int __sev_issue_dbg_cmd(struct kvm *kvm, unsigned long src,
-			       unsigned long dst, int size,
-			       int *error, bool enc)
+static int sev_issue_dbg_cmd(struct kvm *kvm, unsigned long src_pa,
+			     unsigned long dst_pa, unsigned int size,
+			     unsigned int ioctl, int *error)
 {
-	struct sev_data_dbg data;
+	int cmd = ioctl == KVM_SEV_DBG_DECRYPT ? SEV_CMD_DBG_DECRYPT :
+						 SEV_CMD_DBG_ENCRYPT;
+	struct sev_data_dbg data = {
+		.handle = to_kvm_sev_info(kvm)->handle,
+		.dst_addr = dst_pa,
+		.src_addr = src_pa,
+		.len = size,
+	};
+
+	return sev_issue_cmd(kvm, cmd, &data, error);
+}
+
+static struct page *sev_alloc_dbg_buffer(void **buf)
+{
+	struct page *buf_p;
 
-	data.reserved = 0;
-	data.handle = to_kvm_sev_info(kvm)->handle;
-	data.dst_addr = dst;
-	data.src_addr = src;
-	data.len = size;
+	buf_p = alloc_page(GFP_KERNEL);
+	if (!buf_p)
+		return NULL;
+
+	*buf = kmap_local_page(buf_p);
+	return buf_p;
+}
 
-	return sev_issue_cmd(kvm,
-			     enc ? SEV_CMD_DBG_ENCRYPT : SEV_CMD_DBG_DECRYPT,
-			     &data, error);
+static void sev_free_dbg_buffer(struct page *buf_p, void *buf)
+{
+	kunmap_local(buf);
+	__free_page(buf_p);
 }
 
-static int __sev_dbg_decrypt(struct kvm *kvm, unsigned long src_paddr,
-			     unsigned long dst_paddr, int sz, int *err)
+static unsigned int sev_dbg_crypt_slow_addr_and_size(struct page *page,
+						     unsigned long __va,
+						     unsigned int len,
+						     unsigned long *pa)
 {
-	int offset;
+	/* The number of bytes to {de,en}crypt must be 16-byte aligned. */
+	unsigned int nr_bytes = round_up(len, 16);
+	unsigned long va = ALIGN_DOWN(__va, 16);
+
+	/*
+	 * Increase the number of bytes to {de,en}crypt by one chunk (16 bytes)
+	 * if the aligned address and length doesn't cover the unaligned range,
+	 * e.g. if the address is unaligned _and_ the access will split a chunk
+	 * at the tail.
+	 */
+	if (va + nr_bytes < __va + len)
+		nr_bytes += 16;
+
+	*pa = __sme_page_pa(page) + (va & ~PAGE_MASK);
 
 	/*
-	 * Its safe to read more than we are asked, caller should ensure that
-	 * destination has enough space.
+	 * Sanity check that the new access won't split a page.  This should
+	 * never happen; just squash the access and let the firmware command
+	 * fail.
 	 */
-	offset = src_paddr & 15;
-	src_paddr = round_down(src_paddr, 16);
-	sz = round_up(sz + offset, 16);
+	if (WARN_ON_ONCE((*pa & PAGE_MASK) != ((*pa + nr_bytes - 1) & PAGE_MASK)))
+		return 0;
 
-	return __sev_issue_dbg_cmd(kvm, src_paddr, dst_paddr, sz, err, false);
+	return nr_bytes;
 }
 
-static int __sev_dbg_decrypt_user(struct kvm *kvm, unsigned long paddr,
-				  void __user *dst_uaddr,
-				  unsigned long dst_paddr,
-				  int size, int *err)
+static int sev_dbg_decrypt_slow(struct kvm *kvm, unsigned long src,
+				struct page *src_p, unsigned long dst,
+				unsigned int len, int *err)
 {
-	struct page *tpage = NULL;
-	int ret, offset;
-
-	/* if inputs are not 16-byte then use intermediate buffer */
-	if (!IS_ALIGNED(dst_paddr, 16) ||
-	    !IS_ALIGNED(paddr,     16) ||
-	    !IS_ALIGNED(size,      16)) {
-		tpage = (void *)alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-		if (!tpage)
-			return -ENOMEM;
-
-		dst_paddr = __sme_page_pa(tpage);
-	}
-
-	ret = __sev_dbg_decrypt(kvm, paddr, dst_paddr, size, err);
-	if (ret)
-		goto e_free;
-
-	if (tpage) {
-		offset = paddr & 15;
-		if (copy_to_user(dst_uaddr, page_address(tpage) + offset, size))
-			ret = -EFAULT;
-	}
-
-e_free:
-	if (tpage)
-		__free_page(tpage);
-
-	return ret;
+	unsigned int nr_bytes;
+	unsigned long src_pa;
+	struct page *buf_p;
+	void *buf;
+	int r;
+
+	buf_p = sev_alloc_dbg_buffer(&buf);
+	if (!buf_p)
+		return -ENOMEM;
+
+	nr_bytes = sev_dbg_crypt_slow_addr_and_size(src_p, src, len, &src_pa);
+
+	r = sev_issue_dbg_cmd(kvm, src_pa, __sme_page_pa(buf_p),
+			      nr_bytes, KVM_SEV_DBG_DECRYPT, err);
+	if (r)
+		goto out;
+
+	if (copy_to_user((void __user *)dst, buf + (src & 15), len))
+		r = -EFAULT;
+out:
+	sev_free_dbg_buffer(buf_p, buf);
+	return r;
 }
 
-static int __sev_dbg_encrypt_user(struct kvm *kvm, unsigned long paddr,
-				  void __user *vaddr,
-				  unsigned long dst_paddr,
-				  void __user *dst_vaddr,
-				  int size, int *error)
+static int sev_dbg_encrypt_slow(struct kvm *kvm, unsigned long src,
+				unsigned long dst, struct page *dst_p,
+				unsigned int len, int *err)
 {
-	struct page *src_tpage = NULL;
-	struct page *dst_tpage = NULL;
-	int ret, len = size;
+	unsigned int nr_bytes;
+	unsigned long dst_pa;
+	struct page *buf_p;
+	void *buf;
+	int r;
 
-	/* If source buffer is not aligned then use an intermediate buffer */
-	if (!IS_ALIGNED((unsigned long)vaddr, 16)) {
-		src_tpage = alloc_page(GFP_KERNEL_ACCOUNT);
-		if (!src_tpage)
-			return -ENOMEM;
+	buf_p = sev_alloc_dbg_buffer(&buf);
+	if (!buf_p)
+		return -ENOMEM;
 
-		if (copy_from_user(page_address(src_tpage), vaddr, size)) {
-			__free_page(src_tpage);
-			return -EFAULT;
-		}
+	/* Decrypt the _destination_ to do a RMW on plaintext. */
+	nr_bytes = sev_dbg_crypt_slow_addr_and_size(dst_p, dst, len, &dst_pa);
 
-		paddr = __sme_page_pa(src_tpage);
-	}
+	r = sev_issue_dbg_cmd(kvm, dst_pa, __sme_page_pa(buf_p),
+			      nr_bytes, KVM_SEV_DBG_DECRYPT, err);
+	if (r)
+		goto out;
 
 	/*
-	 *  If destination buffer or length is not aligned then do read-modify-write:
-	 *   - decrypt destination in an intermediate buffer
-	 *   - copy the source buffer in an intermediate buffer
-	 *   - use the intermediate buffer as source buffer
+	 * Copy from the source into the intermediate buffer, and then
+	 * re-encrypt the buffer into the destination.
 	 */
-	if (!IS_ALIGNED((unsigned long)dst_vaddr, 16) || !IS_ALIGNED(size, 16)) {
-		int dst_offset;
-
-		dst_tpage = alloc_page(GFP_KERNEL_ACCOUNT);
-		if (!dst_tpage) {
-			ret = -ENOMEM;
-			goto e_free;
-		}
-
-		ret = __sev_dbg_decrypt(kvm, dst_paddr,
-					__sme_page_pa(dst_tpage), size, error);
-		if (ret)
-			goto e_free;
-
-		/*
-		 *  If source is kernel buffer then use memcpy() otherwise
-		 *  copy_from_user().
-		 */
-		dst_offset = dst_paddr & 15;
-
-		if (src_tpage)
-			memcpy(page_address(dst_tpage) + dst_offset,
-			       page_address(src_tpage), size);
-		else {
-			if (copy_from_user(page_address(dst_tpage) + dst_offset,
-					   vaddr, size)) {
-				ret = -EFAULT;
-				goto e_free;
-			}
-		}
-
-		paddr = __sme_page_pa(dst_tpage);
-		dst_paddr = round_down(dst_paddr, 16);
-		len = round_up(size, 16);
-	}
-
-	ret = __sev_issue_dbg_cmd(kvm, paddr, dst_paddr, len, error, true);
-
-e_free:
-	if (src_tpage)
-		__free_page(src_tpage);
-	if (dst_tpage)
-		__free_page(dst_tpage);
-	return ret;
+	if (copy_from_user(buf + (dst & 15), (void __user *)src, len))
+		r = -EFAULT;
+	else
+		r = sev_issue_dbg_cmd(kvm, __sme_page_pa(buf_p), dst_pa,
+				      nr_bytes, KVM_SEV_DBG_ENCRYPT, err);
+out:
+	sev_free_dbg_buffer(buf_p, buf);
+	return r;
 }
 
-static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
+static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp,
+			 unsigned int cmd)
 {
-	unsigned long vaddr, vaddr_end, next_vaddr;
-	unsigned long dst_vaddr;
-	struct page *src_p, *dst_p;
 	struct kvm_sev_dbg debug;
-	unsigned int size;
-	int ret;
+	unsigned int i, len;
 
 	if (!sev_guest(kvm))
 		return -ENOTTY;
@@ -1404,20 +1385,29 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 	    debug.dst_uaddr + debug.len < debug.dst_uaddr)
 		return -EINVAL;
 
-	vaddr = debug.src_uaddr;
-	size = debug.len;
-	vaddr_end = vaddr + size;
-	dst_vaddr = debug.dst_uaddr;
+	for (i = 0; i < debug.len; i += len) {
+		unsigned long src = debug.src_uaddr + i;
+		unsigned long dst = debug.dst_uaddr + i;
+		unsigned long s_off = src & ~PAGE_MASK;
+		unsigned long d_off = dst & ~PAGE_MASK;
+		struct page *src_p, *dst_p;
+		int ret;
 
-	for (; vaddr < vaddr_end; vaddr = next_vaddr) {
-		int len, s_off, d_off;
+		/*
+		 * Copy as many remaining bytes as possible while staying in a
+		 * single page for both the source and destination.
+		 */
+		len = min3(debug.len - i, PAGE_SIZE - s_off, PAGE_SIZE - d_off);
 
-		/* lock userspace source and destination page */
-		src_p = sev_pin_page(kvm, vaddr & PAGE_MASK, 0);
+		/*
+		 * Pin the source and destination pages; firmware operates on
+		 * physical addresses.
+		 */
+		src_p = sev_pin_page(kvm, src & PAGE_MASK, 0);
 		if (IS_ERR(src_p))
 			return PTR_ERR(src_p);
 
-		dst_p = sev_pin_page(kvm, dst_vaddr & PAGE_MASK, FOLL_WRITE);
+		dst_p = sev_pin_page(kvm, dst & PAGE_MASK, FOLL_WRITE);
 		if (IS_ERR(dst_p)) {
 			sev_unpin_page(kvm, src_p);
 			return PTR_ERR(dst_p);
@@ -1431,41 +1421,25 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 		sev_clflush_pages(&src_p, 1);
 		sev_clflush_pages(&dst_p, 1);
 
-		/*
-		 * Since user buffer may not be page aligned, calculate the
-		 * offset within the page.
-		 */
-		s_off = vaddr & ~PAGE_MASK;
-		d_off = dst_vaddr & ~PAGE_MASK;
-		len = min_t(size_t, (PAGE_SIZE - s_off), size);
-		len = min_t(size_t, len, PAGE_SIZE - d_off);
-
-		if (dec)
-			ret = __sev_dbg_decrypt_user(kvm,
-						     __sme_page_pa(src_p) + s_off,
-						     (void __user *)dst_vaddr,
-						     __sme_page_pa(dst_p) + d_off,
-						     len, &argp->error);
+		if (IS_ALIGNED(src, 16) && IS_ALIGNED(dst, 16) && IS_ALIGNED(len, 16))
+			ret = sev_issue_dbg_cmd(kvm,
+						__sme_page_pa(src_p) + s_off,
+						__sme_page_pa(dst_p) + d_off,
+						len, cmd, &argp->error);
+		else if (cmd == KVM_SEV_DBG_DECRYPT)
+			ret = sev_dbg_decrypt_slow(kvm, src, src_p, dst,
+						   len, &argp->error);
 		else
-			ret = __sev_dbg_encrypt_user(kvm,
-						     __sme_page_pa(src_p) + s_off,
-						     (void __user *)vaddr,
-						     __sme_page_pa(dst_p) + d_off,
-						     (void __user *)dst_vaddr,
-						     len, &argp->error);
+			ret = sev_dbg_encrypt_slow(kvm, src, dst, dst_p,
+						   len, &argp->error);
 
 		sev_unpin_page(kvm, src_p);
 		sev_unpin_page(kvm, dst_p);
 
 		if (ret)
-			goto err;
-
-		next_vaddr = vaddr + len;
-		dst_vaddr = dst_vaddr + len;
-		size -= len;
+			return ret;
 	}
-err:
-	return ret;
+	return 0;
 }
 
 static int sev_launch_secret(struct kvm *kvm, struct kvm_sev_cmd *argp)
@@ -2727,10 +2701,8 @@ int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
 		r = sev_guest_status(kvm, &sev_cmd);
 		break;
 	case KVM_SEV_DBG_DECRYPT:
-		r = sev_dbg_crypt(kvm, &sev_cmd, true);
-		break;
 	case KVM_SEV_DBG_ENCRYPT:
-		r = sev_dbg_crypt(kvm, &sev_cmd, false);
+		r = sev_dbg_crypt(kvm, &sev_cmd, sev_cmd.id);
 		break;
 	case KVM_SEV_LAUNCH_SECRET:
 		r = sev_launch_secret(kvm, &sev_cmd);
-- 
2.54.0.545.g6539524ca2-goog

