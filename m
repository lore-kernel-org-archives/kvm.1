Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8266372675
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381060; cv=none; b=D41Ae9d5WXt7TeH+DOMBP2cGRperICFoO77RBu1jmCcIHg0J4qdfaojoUjD4J13DHyCf2Z3iVTZcexmSwbwDSE4TAS3piauX56ojszdmWkxCPS+F+VZafp9uXlP/9jgsPFkPLCV0bcjMapuP254CQ7+g1qiEreYMl4VIiPukieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381060; c=relaxed/simple;
	bh=AqvreRcUrDcVAklDELALQJuhHMkS0iYZ2X6C9pDWxOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sDJafiZtU7DCrv/9poUOyhFYB2pXDo6ykX1vLkMqeMRk5AguwbArMVWEQM3tD6jYdMF2BEhi8ydN5G5XHa2AxsBSEviTw2VjPxv6sXIlS+WKxknaqSZR9hGiB1mdk3Toe4bvwLoq57z/0Lm+q8Zg5zJ1tirHLyryvLbMxNx8MtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LltwWCYG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LltwWCYG"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7691378914so26135a12.0
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776381058; x=1776985858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eOmi0SGJneN2bKDEnlJdJDSqg2s6V8AvI55vj4MvzeU=;
        b=LltwWCYG4orBUo41PR5IBBC5v3U/CUyhSy/GtM8guySEFvQRQ/bHaDtrMqcAYwnJPh
         aledTtX415hcnJwA0RX07q0sGuWaVoncJTy2eXMw4VOmXs6Xz3RaCcBxBF706l1K/OIo
         zaiack5fhIjTTKFQxYerp/zla+ZfczjALys0PkGjFvN87MIAQQSYzIOdNM7IxiV24/5l
         VMhuZ4JMrltLtfc4LUFKrFczeWQzb4Z3xjXupq9KqSt/FzbbGddOHVdFAylP7dB9RADy
         LMVGXeJyRism7h+JNURfkYUL9hnJjto0zBCAvP0ufpg72tFYFwBO2y6rWNfo1w7OsMZy
         06aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381058; x=1776985858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOmi0SGJneN2bKDEnlJdJDSqg2s6V8AvI55vj4MvzeU=;
        b=BWMBjlUKI+J/3tvZ5/zk1PhdKx4RIjFhlfNcCut1A49w5Crbx2Ukc36eZZEISdT/5c
         uXd7Nd7z7YewrZ7HZ5iAxzzBHvJ8wohoVheHaYrrdkpet6luvtM037W9oA2FF/wHf0oV
         iHIXPqhPSuKjFhpLRyndsD9YEoK5lhIUb+bZSpBDTZjMipbJU0v4NYfi24jF42+gXn1+
         D989o/wF5z3zoFT3Z0JCQe12zyUK/bf5qe5SaTnXiDLFLfkhztZqY6tgEbP05N2PxRPG
         Dzk5ki98vas8AMXjWJqywOfyB86g2d1P45PyLqqF6CiPs0g8MfwDVm+IT7DHoyzhTH/Q
         hdhw==
X-Gm-Message-State: AOJu0Yxlj+Y6/Csn8Gpoy4A0TtE6VJ+UoPA/njbW/VDiabF3fmIbKlpK
	1p2e+/lpoQMwejdoXVBHScd7xx3g53kFluRqfho3cpjQHbwdQVsktZ2+7EDDOC9tfd537onWeIr
	wVpFxcA==
X-Received: from pfbdo18.prod.google.com ([2002:a05:6a00:4a12:b0:82f:75de:5da4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d28:b0:829:8942:2c93
 with SMTP id d2e1a72fcca58-82f8c7d10a9mr246512b3a.9.1776381058149; Thu, 16
 Apr 2026 16:10:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Apr 2026 16:10:42 -0700
In-Reply-To: <20260416231043.3402410-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416231043.3402410-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416231043.3402410-6-seanjc@google.com>
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
2.54.0.rc1.513.gad8abe7a5a-goog

