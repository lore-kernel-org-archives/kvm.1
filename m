Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903013F0AB1
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289124; cv=none; b=GU7CaZ1ImPXV2P5K7yCkTxWCWm8m6YD3Ns6asudOKrSW9JmYEFFFXaKTJdn7RbZwYMQpa7kd1x2AVPlVLCC+NbLomKtaHa257mk6SX4y1jS5f1RD5mA5HgD9GFpC5YNGUHFGckO7CcGgre0giX1enm37bFfCM0kfusJ5K4PCG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289124; c=relaxed/simple;
	bh=/XR/hf5HgYX8ITiX8XjjAVSfpYy2QvWPJLIZdCYIcSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cL8f1VedPZXusCEjiyNDS2LZZ9j+RJWfjrWXHE7CDAAcqJTNKBPXehCFtfXOF54Gj7ZJnpAGxRuho5IGzVHKO0JwBgkOlLVCHKv9Zc+wXKp4vbT/7EEgh/7RCvwfe4a05wsi/jU1if9UtZ2GBo/V+qmiax66fgR9MVjdD5X5Ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrHMEG9p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=suZFuDf9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrHMEG9p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="suZFuDf9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779289121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7As2ky9zH3vSqIGY3uWTsOuE1eOMq3Xz3KeWzY+8Zk=;
	b=ZrHMEG9ppUi8fN0cmsWYkIjbJv/Q0UPbGmCb37tT+vmauvx7gwv/FlcXeJrcGtd+VJasM6
	xStVgVX9cEckbEz8ab1PZgZtwBjVv1iM5CejnR/shEUZBnl0OocZITYPIyzX15R+3SBFlL
	tczKLmh6C80Jv7GS/19ezJiidhxEDrU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-1HEqJGecM7-gJ_LmmQfVbQ-1; Wed, 20 May 2026 10:58:36 -0400
X-MC-Unique: 1HEqJGecM7-gJ_LmmQfVbQ-1
X-Mimecast-MFC-AGG-ID: 1HEqJGecM7-gJ_LmmQfVbQ_1779289116
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48feb8b9acfso29923595e9.3
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779289115; x=1779893915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7As2ky9zH3vSqIGY3uWTsOuE1eOMq3Xz3KeWzY+8Zk=;
        b=suZFuDf9EDKTDNuJYP/nQZPwohiSA8kp7fGkVVoEzvn9ivxwB/oPtL6/VFEb2Zjl7G
         Qm7RQ7sMEYWRoUlItbIB8SvD8mCemZxbSaWvp6dSe3svyuTmplPGCT44dknLTetXKy0X
         8rZFMFOPe7waix0YDuXP5ZhyjAnGQoiQ/HTllbG8WW+/4CrkWBdYddW42uWE/tGHogpq
         V2fUJgc6QckZ1auIEmDwrZfroS4bbwyovLaAPWIQ6KvqaC9Nyl/Tw2/yL4ihub12TT5P
         2UFmKWxi6GZr5KF9IQx9SVtx+qSvGNz8fz3dP+R7BSSllZn1xtlhYmD9G76ClA7bk7tG
         DDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289115; x=1779893915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7As2ky9zH3vSqIGY3uWTsOuE1eOMq3Xz3KeWzY+8Zk=;
        b=lXf+z5cAMwXke+BYt/13nNLhZ0v6mThi+KHyLmRCaLeOxrFauqjzCXZE8ut0T5Ehdt
         y3BOJ5WqFdunDgxX0IWsUKN3AlJt8f1LysSdrXWcQxSujXBxKHy9cXKhAIo3O5ovZuK/
         djdGRnm27wgwQwnDQKD2n6HBDYNuXHGXPwWx/bD0HcbAlN8xtLf8yNVtqiWkqerE+tGI
         kbriu1bR6lwlL/3HKusXxsRWuNCMVFbwNNQppxCWtKMGn2/BChD4dKCBfR4UlKQNxmmY
         JB8iMD8WFl4B+pQTN9NFRll2ZHNJA+tybhAJ/FSNBAotKw4u+IRo70eve7/2uHyrDBG4
         ljSw==
X-Gm-Message-State: AOJu0Yx8F1fcBaG/kzDR7N69ndRiiIZNzT2twPLfTEeI8q6q7XzGyPh9
	SkrUWS8Ul6C0zI0rx51zo1cyb5nOit4i99zuBVU/YRFssv9ZIoeetGokZ4RsrCMNyqtoemO22KB
	SlwMkDeKA1OSw2yp07IDvBnc0SpgDuLRDtPN0qm7XF8UYCJCxZYzmm9SR8/DKUOE2UBd9wt2Wtb
	4hyYbFOFU1PS5Y1EyAkt5G1nXRwuBoPoIm6adPdGS4
X-Gm-Gg: Acq92OEFrDJDMfdzp0dfhMG0QDSkDSnIWxMaMAUKMVrQJLyO1lDWqzsRb3S20+P5wJV
	3aF6UFkMojTgOSy/wcQDt0VTUBVVMpqVs/SR92CscYmlzKqvCs+FaPmuG6wFjw2gfbfqIHA/Xa5
	D4/djZKzXJ6v1JP4q9drIDSynJfpd4/5dvyTvPS/YCXkKkuP+eTFY4uV5yJtqqb/+hb3d/y2tjA
	dly400qzu9BB8jDZUcPhRcJBLeJFoXH1x7kPrYoIt180j8v8XVeLi38A7Vbystr2qbxxn4/xb90
	Zg6T5C6r7HzTJStjZpc4apYk9LBOdNYzMinx/k2N/PlnlDpXSob7/5/poVwJT1G1wWEBAOb3lJg
	AkAZFJrNeEdukNsKtpO0K8fiNtCC30zLB88rl/lVyNK+Hqa+QzIW0SPe+9kaQOFMZnT3me90sYP
	/Pc3k/otcjQCKg9Zmbt6xzeZjbTPI5UzZAJw==
X-Received: by 2002:a05:600c:6211:b0:48f:e230:72fc with SMTP id 5b1f17b1804b1-48fe663152cmr379527275e9.33.1779289115605;
        Wed, 20 May 2026 07:58:35 -0700 (PDT)
X-Received: by 2002:a05:600c:6211:b0:48f:e230:72fc with SMTP id 5b1f17b1804b1-48fe663152cmr379526915e9.33.1779289115188;
        Wed, 20 May 2026 07:58:35 -0700 (PDT)
Received: from [10.110.4.204] ([87.215.26.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feb8d838dsm135784485e9.1.2026.05.20.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:58:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: mlevitsk@redhat.com
Subject: [PATCH kvm-unit-tests 5/5] svm: add test for 32-bit PAE guest
Date: Wed, 20 May 2026 16:58:23 +0200
Message-ID: <20260520145823.408884-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520145823.408884-1-pbonzini@redhat.com>
References: <20260520145823.408884-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test that runs a 32-bit code segment with PAE page tables.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/svm_tests.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 3ba3b09c..0fc897bf 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -802,7 +802,24 @@ static u64 svm_32bit_build_page_tables(void)
 	return virt_to_phys(pd);
 }
 
-static void svm_32bit_guest_prepare_common(struct svm_test *test, u64 cr3)
+static u64 svm_32bit_build_pae_page_tables(void)
+{
+	const u64 leaf_flags = PT_PRESENT_MASK | PT_WRITABLE_MASK | PT_PAGE_SIZE_MASK;
+	u64 *pdpt = memalign_pages_flags(PAGE_SIZE, PAGE_SIZE, AREA_DMA32);
+	int i, j;
+
+	for (i = 0; i < 4; i++) {
+		u64 *pd = memalign_pages_flags(PAGE_SIZE, PAGE_SIZE,
+					       AREA_DMA32);
+		for (j = 0; j < 512; j++)
+			pd[j] = (((u64)i << 30) | ((u64)j << 21)) |
+				leaf_flags;
+		pdpt[i] = virt_to_phys(pd) | PT_PRESENT_MASK;
+	}
+	return virt_to_phys(pdpt);
+}
+
+static void svm_32bit_guest_prepare_common(struct svm_test *test, u64 cr3, bool pae)
 {
 	struct vmcb_save_area *save = &vmcb->save;
 
@@ -818,8 +835,8 @@ static void svm_32bit_guest_prepare_common(struct svm_test *test, u64 cr3)
 
 	save->efer &= ~(EFER_LMA | EFER_LME);
 	save->cr0 |= X86_CR0_PG | X86_CR0_PE;
-	save->cr4 &= ~X86_CR4_PSE;
-	save->cr4 |= X86_CR4_PAE;
+	save->cr4 &= ~(X86_CR4_PAE | X86_CR4_PSE);
+	save->cr4 |= pae ? X86_CR4_PAE : X86_CR4_PSE;
 	save->cr3 = cr3;
 	regs.rax = 0x123457678;
 }
@@ -828,7 +845,14 @@ static void svm_32bit_guest_prepare(struct svm_test *test)
 {
 	u64 cr3 = svm_32bit_build_page_tables();
 
-	svm_32bit_guest_prepare_common(test, cr3);
+	svm_32bit_guest_prepare_common(test, cr3, false);
+}
+
+static void svm_32bit_guest_prepare_pae(struct svm_test *test)
+{
+	u64 cr3 = svm_32bit_build_pae_page_tables();
+
+	svm_32bit_guest_prepare_common(test, cr3, true);
 }
 
 static void svm_32bit_guest_prepare_gif_clear(struct svm_test *test)
@@ -870,8 +894,20 @@ static bool svm_32bit_guest_finished(struct svm_test *test)
 static void svm_32bit_free_page_tables(void)
 {
 	u64 cr3 = vmcb->save.cr3;
+	u64 cr4 = vmcb->save.cr4;
 
-	free_page(phys_to_virt(cr3));
+	if (cr4 & X86_CR4_PAE) {
+		u64 *pdpt = phys_to_virt(cr3);
+		int i;
+
+		for (i = 0; i < 4; i++) {
+			if (pdpt[i] & PT_PRESENT_MASK)
+				free_page(phys_to_virt(pdpt[i] & PT_ADDR_MASK));
+		}
+		free_page(pdpt);
+	} else {
+		free_page(phys_to_virt(cr3));
+	}
 }
 
 static bool svm_32bit_guest_check(struct svm_test *test)
@@ -3806,6 +3842,9 @@ struct svm_test svm_tests[] = {
 	{ "32bit_guest", default_supported, svm_32bit_guest_prepare,
 	  svm_32bit_guest_prepare_gif_clear, svm_32bit_guest_test, svm_32bit_guest_finished,
 	  svm_32bit_guest_check },
+	{ "32bit_pae_guest", default_supported, svm_32bit_guest_prepare_pae,
+	  svm_32bit_guest_prepare_gif_clear, svm_32bit_guest_test, svm_32bit_guest_finished,
+	  svm_32bit_guest_check },
 	TEST(svm_cr4_osxsave_test),
 	TEST(svm_guest_state_test),
 	TEST(svm_vmrun_errata_test),
-- 
2.54.0

