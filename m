Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F6421F1D
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667760; cv=none; b=tcT2nn3xJ+2uW5Q5wZxKTkeTxAXJ7zTg1y/XzM3/DX6Yrt1LUONewLw4p95zKs0r48qVAIefl+Ge/NcdGjIKdT/vz6x1s7EBfCR8LzJcyM9Sfekq0MnV/qc1P1+l7w46FF1G5Q+aMeoOhA2h7VDpc9/Z0eTqEFMjUwtA6AMtsTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667760; c=relaxed/simple;
	bh=zbH2ZSJhkTnv7M6GW+1yYa9nXucIRak6aeyoMh/dwdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RrYa4a6vDSepxLmg+ybkV9GdrQAOgez6JWHNilV7UvtpwMF2fOyOGOeCIiyrKN3DhLxNFKIz5wWH4euNXzeQAxKOS5xn/fJTMDrnZA50FGIJPuiMD6Usxfcg6kSt8YOJ9+2JkgcdwmiUsDctHqAiMFO4bl9ziE5nGcy/7VIA/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdMSkQRa; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdMSkQRa"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4678c6171so23055835ad.1
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777667754; x=1778272554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2rmwcvThwjw92x9D0plyk0s/qULXiJrO5D2DLQI9XGw=;
        b=fdMSkQRaoWtBC+/v2fM75t1VOpgap1y/zAaWot+MGt/URr9Gt0WVnK11O8ttgk9vaX
         BCrX2MCeBFEWkrtrMvIjwaZ/2YzPNVXMg3hT32CEzbybwky45YeTFrX1a/CYIEEpzrFL
         B7FjCuC/d7ZeHt3uB6UfcXhxXXiMRPxrHctV3DDSHYlbfKkYEdlHsFGuP5S+52oinJsZ
         u29UQfzViy8PwnfmZg2MsYddXMwej4hnUNwe5VUxLYOrX+ixCvA2idAAIGbzcQ+zIFDM
         +u/M87qaY3lb16HbEPgwCEPzlWtjfe3LMxo4yfGXScLMuMqoMneIqVyxAcpme9fwJDs2
         DdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777667754; x=1778272554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rmwcvThwjw92x9D0plyk0s/qULXiJrO5D2DLQI9XGw=;
        b=QWJfDjgrN+4klx/INPR1Z3D3jHg6uML627m55/0tbvEG+fO3I98q/vTs0jY3heCNcI
         Z20nrBCI7NkKpCMnnCFjch7YpTqqhz5gwXhp3/IP7miBNny/cQ4sls43pGixBkDhPv/q
         Af1M/XFjudXqBfT9zQxVKI/SAtNnmhk+jJAOfLcYPUUo4RjOBnFljU81esceF5K34Zvt
         /mZ0Acr8IMd7dDxcKvIzw11FYDJXpmhhoNH2jUhSZm1rGu7tm3o4uFLZsrSBIqNw/XLN
         VSnLtZn45F4jEk29ZosX9kG4SuD+XSHXgH5ItIMSYWM6tPb7UJA591R7AL7AeoVtzrTO
         MNOg==
X-Gm-Message-State: AOJu0YxalAda8savlc0NWkS9pqx0pajD1vKHf6Rr9BQJyt1puuSCfNiq
	J0mEgbs09VsvDpKFywydCYWt9zWJzQAvltThV+D0Md6cS47lhT87eMp0X1WKd32sskVKJ07mdrB
	CZaQqTQ==
X-Received: from plmt18.prod.google.com ([2002:a17:903:3d52:b0:2b2:cc58:2a31])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3e0d:b0:2ae:6092:8d93
 with SMTP id d9443c01a7336-2b9f2825508mr4439065ad.28.1777667753622; Fri, 01
 May 2026 13:35:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 May 2026 13:35:37 -0700
In-Reply-To: <20260501203537.2120074-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501203537.2120074-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501203537.2120074-7-seanjc@google.com>
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
2.54.0.545.g6539524ca2-goog

