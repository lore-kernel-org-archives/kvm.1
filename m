Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFA3803F8
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381062; cv=none; b=T9cHqbvnvL9rVs4G0IaUcgCODXrSkP4nlVGi9+4fvn9dqgy0Xlpy34/8yb0lZhd30h/K4leJMh4gOMUXQShvE26IuoecVTWTziiWmDa95MdH+YPw3GPp1c0uR8e+6TpEZhkZI4ajUl24mANem1Ppbs2dZx5uGBXyjMhY7wm+Xk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381062; c=relaxed/simple;
	bh=85ORCOpy0tBEfyyTiUwYsB5sebkTBrSUPiI1VxHClOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WzinQHSA4TSFnZ9cxFx4P/E/buoCYOL1BXm0NKblZos+aJYTIkzDw7JkoxN+XHX4xvyABeLpnfL3w8CqA8A8GoOmJ7hkNufLaF1GZJUiBnptIQb1uK5HAmVoL6ed+7dxS3vBa7CDNx+T9vhUtJSIYsi9HoLU+dHGiKAwdYzZde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBeOzKtx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBeOzKtx"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7691378914so26139a12.0
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776381060; x=1776985860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jNbNgJLHKhmCy6JtsDJ8ebUiJV8vqj7Fm/YHhQltXZ0=;
        b=pBeOzKtx1GzaCXIhEs4pEhp0XDFfFdAvA5uC1DQ6bT72KFhA9xdDJgpTawZjTOkJrT
         uO1RHC1QoQh3zastL8WLb5r+zj5/1G26P4+3QnZRlXgpA1Ak1eNj4BhxfRpdYTM9tfmt
         Q7HenjX4lcdG0VUbLuslqCodxRTeIciBmilPpNgcW7zR6kD4mtEaIvcjRF7Ja30lK4tc
         zUJCqIrXj67c6YJHwbgY8AsVnMTlWg238XkrMJO0j+Vh2DXzr8TdsHiFjmdJGwa8ivLC
         MXfafc6IXrFNNZ+Tm8/7uA5NLjA66UWmf5QDmJf3/HqdzlZm7mSS+LdkxiNi2o1E2H50
         VC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381060; x=1776985860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNbNgJLHKhmCy6JtsDJ8ebUiJV8vqj7Fm/YHhQltXZ0=;
        b=hL2tHxt2VzIrPUg2i4VpJzkXCIqdgN3aISijjp7Ca0FURZjtWfW2AYKeOFaR5RJ+Bg
         CU0IRYck9TWAR4fTB8wZuYeQSpYyN7f6+EuLor96jr06yweqfVFrtnH5I1zL7RaLV0kP
         m9kBwKznslUaTQSkVPNFuqaLm32ZuBY4t5fVyb/Jl2BrcEz9wP5KSF46HPYv/V1bO94n
         jStTizFa8HNBjGWlDgbiYX+01tCvhvb4m+H55Mw12NA2Uj/hfBy/kBd0TWqg4eTGXOx/
         LoZcYmeYX/j4lGsxBYafoH0WQWDPKETEPM+Ti4mbCOFg7FHW8oFK3z6hwKrdm1/4PIuK
         zcHA==
X-Gm-Message-State: AOJu0YzXS32RqMjOXztbEwqaP66VnAkcDORfa7OKQ7LI+T8NQA+CVsJb
	Ote0Ol231KV55icTMJvM9DBHtnDjWVi8NIBmkrwrhPXhMRKaSujpQhbzP37X+S+0x9ALe6A/UZP
	p80Vm+g==
X-Received: from pfmm8.prod.google.com ([2002:a05:6a00:2488:b0:82f:3774:4736])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f88:b0:39b:e40b:fcae
 with SMTP id adf61e73a8af0-3a08d6f21e4mr289701637.10.1776381059837; Thu, 16
 Apr 2026 16:10:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Apr 2026 16:10:43 -0700
In-Reply-To: <20260416231043.3402410-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416231043.3402410-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416231043.3402410-7-seanjc@google.com>
Subject: [PATCH v2 6/6] KVM: SEV: Allocate only as many bytes as needed for
 temp crypt buffers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When using a temporary buffer to {de,en}crypt unaligned memory for debug,
allocate only the number of bytes that are needed instead of allocating an
entire page.  The most common case for unaligned accesses will be reading
or writing less than 16 bytes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 69 ++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 89586f821c9c..0865ce4bcecb 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1253,53 +1253,34 @@ static int sev_issue_dbg_cmd(struct kvm *kvm, unsigned long src_pa,
 	return sev_issue_cmd(kvm, cmd, &data, error);
 }
 
-static struct page *sev_alloc_dbg_buffer(void **buf)
+static void *sev_dbg_crypt_slow_alloc(struct page *page, unsigned long __va,
+				      unsigned int len, unsigned long *pa,
+				      unsigned int *nr_bytes)
 {
-	struct page *buf_p;
-
-	buf_p = alloc_page(GFP_KERNEL);
-	if (!buf_p)
-		return NULL;
-
-	*buf = kmap_local_page(buf_p);
-	return buf_p;
-}
-
-static void sev_free_dbg_buffer(struct page *buf_p, void *buf)
-{
-	kunmap_local(buf);
-	__free_page(buf_p);
-}
-
-static unsigned int sev_dbg_crypt_slow_addr_and_size(struct page *page,
-						     unsigned long __va,
-						     unsigned int len,
-						     unsigned long *pa)
-{
-	/* The number of bytes to {de,en}crypt must be 16-byte aligned. */
-	unsigned int nr_bytes = round_up(len, 16);
 	unsigned long va = ALIGN_DOWN(__va, 16);
 
+	/* The number of bytes to {de,en}crypt must be 16-byte aligned. */
+	*nr_bytes = round_up(len, 16);
+
 	/*
 	 * Increase the number of bytes to {de,en}crypt by one chunk (16 bytes)
 	 * if the aligned address and length doesn't cover the unaligned range,
 	 * e.g. if the address is unaligned _and_ the access will split a chunk
 	 * at the tail.
 	 */
-	if (va + nr_bytes < __va + len)
-		nr_bytes += 16;
+	if (va + *nr_bytes < __va + len)
+		*nr_bytes += 16;
 
 	*pa = __sme_page_pa(page) + (va & ~PAGE_MASK);
 
 	/*
 	 * Sanity check that the new access won't split a page.  This should
-	 * never happen; just squash the access and let the firmware command
-	 * fail.
+	 * never happen; just pretend the allocation failed.
 	 */
-	if (WARN_ON_ONCE((*pa & PAGE_MASK) != ((*pa + nr_bytes - 1) & PAGE_MASK)))
-		return 0;
+	if (WARN_ON_ONCE((*pa & PAGE_MASK) != ((*pa + *nr_bytes - 1) & PAGE_MASK)))
+		return NULL;
 
-	return nr_bytes;
+	return kmalloc(*nr_bytes, GFP_KERNEL);
 }
 
 static int sev_dbg_decrypt_slow(struct kvm *kvm, unsigned long src,
@@ -1308,17 +1289,14 @@ static int sev_dbg_decrypt_slow(struct kvm *kvm, unsigned long src,
 {
 	unsigned int nr_bytes;
 	unsigned long src_pa;
-	struct page *buf_p;
 	void *buf;
 	int r;
 
-	buf_p = sev_alloc_dbg_buffer(&buf);
-	if (!buf_p)
+	buf = sev_dbg_crypt_slow_alloc(src_p, src, len, &src_pa, &nr_bytes);
+	if (!buf)
 		return -ENOMEM;
 
-	nr_bytes = sev_dbg_crypt_slow_addr_and_size(src_p, src, len, &src_pa);
-
-	r = sev_issue_dbg_cmd(kvm, src_pa, __sme_page_pa(buf_p),
+	r = sev_issue_dbg_cmd(kvm, src_pa, __sme_set(__pa(buf)),
 			      nr_bytes, KVM_SEV_DBG_DECRYPT, err);
 	if (r)
 		goto out;
@@ -1326,7 +1304,7 @@ static int sev_dbg_decrypt_slow(struct kvm *kvm, unsigned long src,
 	if (copy_to_user((void __user *)dst, buf + (src & 15), len))
 		r = -EFAULT;
 out:
-	sev_free_dbg_buffer(buf_p, buf);
+	kfree(buf);
 	return r;
 }
 
@@ -1336,18 +1314,15 @@ static int sev_dbg_encrypt_slow(struct kvm *kvm, unsigned long src,
 {
 	unsigned int nr_bytes;
 	unsigned long dst_pa;
-	struct page *buf_p;
 	void *buf;
 	int r;
 
-	buf_p = sev_alloc_dbg_buffer(&buf);
-	if (!buf_p)
-		return -ENOMEM;
-
 	/* Decrypt the _destination_ to do a RMW on plaintext. */
-	nr_bytes = sev_dbg_crypt_slow_addr_and_size(dst_p, dst, len, &dst_pa);
+	buf = sev_dbg_crypt_slow_alloc(dst_p, dst, len, &dst_pa, &nr_bytes);
+	if (!buf)
+		return -ENOMEM;
 
-	r = sev_issue_dbg_cmd(kvm, dst_pa, __sme_page_pa(buf_p),
+	r = sev_issue_dbg_cmd(kvm, dst_pa, __sme_set(__pa(buf)),
 			      nr_bytes, KVM_SEV_DBG_DECRYPT, err);
 	if (r)
 		goto out;
@@ -1359,10 +1334,10 @@ static int sev_dbg_encrypt_slow(struct kvm *kvm, unsigned long src,
 	if (copy_from_user(buf + (dst & 15), (void __user *)src, len))
 		r = -EFAULT;
 	else
-		r = sev_issue_dbg_cmd(kvm, __sme_page_pa(buf_p), dst_pa,
+		r = sev_issue_dbg_cmd(kvm, __sme_set(__pa(buf)), dst_pa,
 				      nr_bytes, KVM_SEV_DBG_ENCRYPT, err);
 out:
-	sev_free_dbg_buffer(buf_p, buf);
+	kfree(buf);
 	return r;
 }
 
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

