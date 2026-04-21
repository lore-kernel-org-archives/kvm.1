Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669733451A6
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763578; cv=none; b=G3TjhnCmw8y6oavItxWWmh0DxfF2jFGF/Rb8RSNAPQrqdSXplUZTTSHDOUHV5ROhenXQFIXVMKUXxLx2Ax+33Z4ZUBbvN+D4tvevOniZsqur0jGv178cdWiDwS0DccBu+GhNSzj1slq49yjZ+D3JStK0bG8Z6vHUY8RjfCZko/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763578; c=relaxed/simple;
	bh=NqIa/AVjalXxIFvZZGUvR0dRYemXOYMzQmU4EZu8VMY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ALIRYMRK0hjc4UBBWT56Oe0fU3cfOiJzY5ipz/HUiu3ns68VPKR1x8FOCuN9DsekR8irUQyLYknys2nPkLnHz6fk7YzJmLMQeOpUWCvH649huOlhcF6olqfG5uF7Yzi2EnAoG2SuQXafqfLguDkHzCMYFUu4EPlgp/lvTHG2/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k6STzqCz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k6STzqCz"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso2499856a91.2
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776763576; x=1777368376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuusCw6rlfDGFySSxpy3cAwZYM4fJMPSUnMyh4fNp+s=;
        b=k6STzqCzh4nQJwlUfc7Dq+aZKHTOH3FAx/Yfnx1vUnkIWPz+5dAS95O4t4E1PvQIaw
         Vp06O/tCOIi55uNnDoKonOa8x2E+ab9kPixsievWw4CiSvHAMTh7ItbB9XEu2nA+FUjB
         ZsRhSxig1AikZ9TW8VoT/geODGCoegvKd/koJRaAW34cjZUtC4sb4xFQ6Prg3VXBjVfg
         LPUyMRVLXHUXIRm7uLwLOBCnjTYlfqAtLYd6ngjq4OKtaR/7JH4yS8VAxxHiWxKWpJgp
         M7SotZF+N+pjrgWRAEF8R4M/W8qqVjHiyzKg7GW/YQMn23UpHHoFIGftvu7+WfmkAx2e
         erKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776763576; x=1777368376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vuusCw6rlfDGFySSxpy3cAwZYM4fJMPSUnMyh4fNp+s=;
        b=AZe3BklO5DGxBr3T0eLdtEq3qm6Wo5ravPewDEWGIvUeA1quQh5yme3fWY0lj1Iqla
         XybRyiTpMKTks0B4WTZIuiISvLaVNHdjEPb3KBnyHBDt7wqDIVObAbvndExUWX+nk3HZ
         T22wMYIPfHZSDl/jWeffa3g7L2mb2L7kW/UOon7oXQ56rM+mIxZAxmvb0cqpKvfVqjeG
         4tDpgWn4qOrjuIdl2IVCLWKjehEeucpOzobvIuWzIfxSgtiXmsswmFVROfNBn4GZI/60
         kZrdo4w2Cn4DgyndhspksV3rARNTd4GNo1DfcurcSo71bVWskI2BL6VCmk2T2fftQcPQ
         7zXg==
X-Forwarded-Encrypted: i=1; AFNElJ+OfzqiaYTVjWrg4GFNaMfvlgu2OEzg7JS6bIkTKEJ3JebaYXUkWtI9mdW2yqjcOVe/kNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpdI7CEx/ZblnI7sUftTnkrEdi+3UMfm6wx9A0hz18OHu7mYnU
	DGDVZVTknSzNO+k7/ar7z69liwihitwgzZDC98Zqt9RaIm6Z8bQycuvTMkKiTteahuM=
X-Gm-Gg: AeBDieux9x6oOhWl6If4qOo5QYOJPEcP5EW6s9ueqIM5P43CAGSuNYAE2EGEaGu3CRF
	Qw5eWy0Sk/T50Qa6A5Kp1eDH37UH/YH4BtnljZQHTIhaooS363J5uff2w7oLglvhMKWskv9XbaG
	k1ha4BzcVJHucrYaI5H2/pabz8LskmlAp6jLUMt6d3Lr+GWo2g45huEV4xd4tyw7g+0VTacCrJf
	m7VcKKfl+AD70xK4NiI+BDroGufs2tkdIBEO2PLMVfJWsqeuzChVZ43kdjbCE2Mq8BjXVPpFoRe
	iV3MOZT/z8jcW3v43tztjDpnHx7OTJgHdpWkuFymjRAlWtTMT1VSOzglG89t3pvxcpLCnxrlt2m
	GGNv7rYOA0fe14S5aS1iXOkJmT9hAJwK24uswzC3toEJQimSYvxKMiZHk0i42XdvkFhk4Q1FcnW
	P8L+UMXoGLRfF/9fnazURNNQbuEBjaRa2yNnMX8UbHFxzOneAOZSoNUglOXNLsUV3km7PU
X-Received: by 2002:a17:90b:1809:b0:359:15c8:e8e1 with SMTP id 98e67ed59e1d1-361404a8241mr17256461a91.25.1776763575646;
        Tue, 21 Apr 2026 02:26:15 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff39csm131965105ad.4.2026.04.21.02.26.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Apr 2026 02:26:15 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	alex@ghiti.fr,
	andrew+kernel@donnellan.id.au,
	andreyknvl@gmail.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	apopple@nvidia.com,
	ardb@kernel.org,
	atish.patra@linux.dev,
	baolin.wang@linux.alibaba.com,
	cuiyunhui@bytedance.com,
	david@kernel.org,
	debug@rivosinc.com,
	djordje.todorovic@htecgroup.com,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	ilias.apalodimas@linaro.org,
	junhui.liu@pigmoral.tech,
	kasan-dev@googlegroups.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	liu.xuemei1@zte.com.cn,
	ljs@kernel.org,
	namcao@linutronix.de,
	osalvador@suse.de,
	palmer@dabbelt.com,
	pjw@kernel.org,
	rmclure@linux.ibm.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	ryabinin.a.a@gmail.com,
	surenb@google.com,
	vincenzo.frascino@arm.com,
	vishal.moola@gmail.com,
	wangruikang@iscas.ac.cn,
	zhangchunyan@iscas.ac.cn
Subject: [PATCH 7/7] riscv: add Svnapot-aware pte_batch_hint support
Date: Tue, 21 Apr 2026 17:24:57 +0800
Message-Id: <20260421092457.37649-8-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260421092457.37649-1-cuiyunhui@bytedance.com>
References: <20260421092457.37649-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a Svnapot-specific pte_batch_hint() implementation so callers can
batch over a contiguous napot range without re-reading each PTE entry.
Keep the public wrapper in pgtable.h and leave the CONFIG-disabled case on
the existing single-entry fallback.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 19 +++++++++++++++++-
 arch/riscv/mm/contpte.c          | 33 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index db82253efb218..264af77392c6e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -872,6 +872,13 @@ static inline bool __ptep_clear_flush_young(struct vm_area_struct *vma,
 
 #define __ptep_clear_flush_young __ptep_clear_flush_young
 
+static inline unsigned int __pte_batch_hint(pte_t *ptep, pte_t pte)
+{
+	return 1;
+}
+
+#define __pte_batch_hint __pte_batch_hint
+
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 
 /*
@@ -886,6 +893,7 @@ void __napotpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, pte_t pte);
 pte_t napotpte_ptep_get(pte_t *ptep, pte_t orig_pte);
 pte_t napotpte_ptep_get_lockless(pte_t *ptep);
+unsigned int napotpte_pte_batch_hint(pte_t *ptep);
 void napotpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 		       pte_t *ptep, pte_t pte, unsigned int nr);
 void napotpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
@@ -1056,6 +1064,15 @@ static inline bool ptep_clear_flush_young(struct vm_area_struct *vma,
 	return napotpte_ptep_clear_flush_young(vma, address, ptep);
 }
 
+#define pte_batch_hint pte_batch_hint
+static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
+{
+	if (!pte_present(pte))
+		return 1;
+
+	return napotpte_pte_batch_hint(ptep);
+}
+
 #else /* CONFIG_RISCV_ISA_SVNAPOT */
 
 static __always_inline bool riscv_pte_present_napot(pte_t pte)
@@ -1100,9 +1117,9 @@ napotpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 #define ptep_set_wrprotect			__ptep_set_wrprotect
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young			__ptep_clear_flush_young
+#define pte_batch_hint				__pte_batch_hint
 
 #endif /* CONFIG_RISCV_ISA_SVNAPOT */
-
 #define pgprot_nx pgprot_nx
 static inline pgprot_t pgprot_nx(pgprot_t _prot)
 {
diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
index 077ffa49e89d9..134b8c401cabc 100644
--- a/arch/riscv/mm/contpte.c
+++ b/arch/riscv/mm/contpte.c
@@ -187,6 +187,12 @@ static inline bool napotpte_is_consistent(pte_t pte, pte_t orig_pte)
 	       pte_val(pte_mask_ad(pte)) == pte_val(pte_mask_ad(orig_pte));
 }
 
+static inline bool napotpte_is_batch_consistent(pte_t pte, pte_t orig_pte)
+{
+	return pte_present_napot(pte) &&
+	       pte_val(pte_mkold(pte)) == pte_val(pte_mkold(orig_pte));
+}
+
 void __napotpte_try_fold(struct mm_struct *mm, unsigned long addr,
 			 pte_t *ptep, pte_t pte)
 {
@@ -391,6 +397,33 @@ pte_t napotpte_ptep_get_lockless(pte_t *orig_ptep)
 }
 EXPORT_SYMBOL(napotpte_ptep_get_lockless);
 
+unsigned int napotpte_pte_batch_hint(pte_t *ptep)
+{
+	pte_t orig_pte, pte;
+	pte_t *start;
+	unsigned int i, nr, off;
+
+	if (!napot_hw_supported())
+		return 1;
+
+	orig_pte = READ_ONCE(*ptep);
+	if (!pte_present_napot(orig_pte))
+		return 1;
+
+	start = napot_align_ptep(ptep);
+	nr = napotpte_pte_num();
+	off = ptep - start;
+
+	for (i = off; i < nr; i++) {
+		pte = READ_ONCE(start[i]);
+		if (!napotpte_is_batch_consistent(pte, orig_pte))
+			return 1;
+	}
+
+	return nr - off;
+}
+EXPORT_SYMBOL(napotpte_pte_batch_hint);
+
 void napotpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 		       pte_t *ptep, pte_t pte, unsigned int nr)
 {
-- 
2.39.5

