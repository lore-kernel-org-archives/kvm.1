Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7F941F5DF
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205856; cv=none; b=bnexhGz1qVq2tPOcHBuanrG3/Df62cP3neKvG8rerF+f06oUg76Xs2TlefYKzeeuq5qvARt27k+f4hjRFEqfgmY7kHOl8DB8fHejsP33uFNwSf/Oo0SW0O4erAzDAjm3f9Ei7FO/G7xhybkHrpywqCBWMKu4sJ/Kcs0WE3Rvm5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205856; c=relaxed/simple;
	bh=4deY2p8H6GZ6zm5fDTusItQoJGUZoIhd5ZPqjCZKV8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcVvOazkgRxD8hGfgAraMyzFhws0Pdc+HwDwOXji4Lxqw8jjAe98W9c41F6nbcrDOqSQ9EOIRhuz4hIsPwypE1jpgdjiV80JEHR/dDd1tsfXMzCK7pA23L5f5mBDxfG2SKZ1zBeW32YBzKkT9LxcO+OcUNCIWMzD3HARt1zWbh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZAj+7QOj; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZAj+7QOj"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848743155bcso1367536b3a.0
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205854; x=1784810654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZqzuyyB7zI40Qj8rdd4/j/Hz77YcBH2L+r/0EHWbI6M=;
        b=ZAj+7QOjASlsckuQXpHLU0FAunWhMybQoKD5W1AGa50FQayUMJnImiyviiMSbReByf
         va4QGfRhrqAk25/wcSzdNnk7Uh+wRnkJmRmorSkk3ZueuR5PhG4jW5y5CLMzyErWfUCe
         PV3JOuaWu6DLe1gZvFlvl2NcWkbb2atm7j7MfDmn56Ndaz6yPyc4P3Buux7GIlpsjUz1
         O9OcZzo5ZEGSFis8y/e4dj8Edgugo5P3zZOn62SIZPiC5lk0LQU85KcX58BXc361Qf7H
         n5qvwflHbCKVpNF1yk7nWMc5X5VbqNH7sSb1x+IXZ4m8L7mNy8+vS2S33zqMuWOk0PaE
         6fYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205854; x=1784810654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZqzuyyB7zI40Qj8rdd4/j/Hz77YcBH2L+r/0EHWbI6M=;
        b=SfhHcntnEL83DxQZl5QxHMLrdDzR5bTKJh0QY5TFSG75K/LeSnm55WuLsHE1MHV1zK
         PigfPtLvn+Vq4fxVjzPfBiV0ekkmSlcg+QNoNDkrGThtMOpJziy+kIojwagmr0x+F6OQ
         AFDPOO2/TYsLSEAB76sm0iYMnnztOTGpaM585XRlAp+4l9ClARjtsqJo5S+JQ9YLvZK2
         g1FfQzdS/bEzAuuPRMe3O0ANIU5GjqeFG3sGf/8OL+JSXBrELiU/nlaas37qiTRoCK89
         XLt83ou/poQVaGAo4AxD3+8Hv4ed9j7Fp6r8OjpFX+aG3tFxnSX7s/X/jNXO6jJOFD83
         MbfA==
X-Forwarded-Encrypted: i=1; AHgh+RpjNAWA2Ru9TYh55aD2MLH0ON0HUyZ3dzqyuNtGu4ChaWNPzWx8W5iOUzR4GtSOvgxxteI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKYCLJZI5noZysu6yNSYYDD4AGMVPzBkMac7O+PJQ3vk2LhZ90
	4gtpncFjCUV9Z5TLxtJAhX5sM7QIPBJ906kse/trQptqdAs70XeijZHuebx1iQlPyKs=
X-Gm-Gg: AfdE7clsUCNzmjmzfF+f90S4V1S44WPuiuoUe8LpNfmO4X7Hx8WN3rNJ10yzaYspM4w
	2ihBUHquYLP28qq4hrwxPdJreD8xZ6ZFFJMlvj4kWiGkjcKwOSDDoh9wdSn+DfGDQwFwirUgSwZ
	YAYdn2gHZat5tq8e4NMVVhOWzR0io8nkeJ7+pokIA3LOCfcTAc6u4An/1Rj0vNiEUZn4ASqXEVn
	oeAiONQSOb9nOoRzrZZHqanNbXMs98810My2DPhZm84fI2LvjCKGMRs/4r/9qyy6LIcY6GkGYKr
	D2NBpW04avtRHWI8JCozt9YIYhWnydhvZKSy6RUXhcy3El17o8+kfLnJLUP8gJ/9LODDsxufjwV
	FX9aRbTlkAKKuPEArVSgAHkY5Xk5INZDm4Ys5SwXZ/kjMLGR3ELMVTNJyTzsTqT9ULuYMrRGdSo
	EP51bi1eMd6SOL6kJdNG6QKWg=
X-Received: by 2002:a05:6a00:21d2:b0:845:c6fc:2821 with SMTP id d2e1a72fcca58-84889604f51mr19555102b3a.22.1784205853705;
        Thu, 16 Jul 2026 05:44:13 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.44.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:44:12 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: linux-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v2 10/15] mm/gup: add fast-GUP specific lockless PTE helpers
Date: Thu, 16 Jul 2026 20:41:45 +0800
Message-Id: <138d74aa9863ae8ff445e16a2798d062895b75bc.1784201104.git.cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <cover.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fast-GUP snapshots a PTE without holding the PTL, pins the page, and
then revalidates that the PTE did not change. Keep both reads under the
same lockless PTE semantics by defaulting the fast-GUP revalidation to
ptep_get_lockless().

Introduce fast-GUP specific PTE snapshot and revalidation helpers. The
default implementation preserves the existing ptep_get_lockless()
semantics, while allowing architectures to override the helpers when the
public lockless getter provides extra semantics that fast-GUP does not
consume.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 include/linux/pgtable.h | 18 ++++++++++++++++++
 mm/gup.c                |  6 ++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index da14328093a86..62943fcbf7046 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -813,6 +813,24 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
 }
 #endif
 
+#ifndef gup_ptep_get_lockless
+static inline pte_t gup_ptep_get_lockless(pte_t *ptep, pte_t *rawp)
+{
+	pte_t pte = ptep_get_lockless(ptep);
+
+	*rawp = pte;
+
+	return pte;
+}
+#endif
+
+#ifndef gup_ptep_revalidate
+static inline bool gup_ptep_revalidate(pte_t *ptep, pte_t raw_pte)
+{
+	return pte_val(raw_pte) == pte_val(ptep_get_lockless(ptep));
+}
+#endif
+
 #ifndef pmdp_get_lockless
 static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 99902c15703b0..72fb147193e55 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2842,10 +2842,12 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 	if (!ptep)
 		return 0;
 	do {
-		pte_t pte = ptep_get_lockless(ptep);
+		pte_t raw_pte, pte;
 		struct page *page;
 		struct folio *folio;
 
+		pte = gup_ptep_get_lockless(ptep, &raw_pte);
+
 		/*
 		 * Always fallback to ordinary GUP on PROT_NONE-mapped pages:
 		 * pte_access_permitted() better should reject these pages
@@ -2871,7 +2873,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 			goto pte_unmap;
 
 		if (unlikely(pmd_val(pmd) != pmd_val(pmdp_get_lockless(pmdp))) ||
-		    unlikely(pte_val(pte) != pte_val(ptep_get_lockless(ptep)))) {
+		    unlikely(!gup_ptep_revalidate(ptep, raw_pte))) {
 			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
 		}
-- 
2.39.5

