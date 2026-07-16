Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C6841F34D
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205828; cv=none; b=ZwaCTm3f4eMDR7T0Eask13teaJMqqzq63FituCpdnX3ukGMcQcqcm2RuBj3tuT7nfKI/YxpYRx516beDvbn9RaC7cN5IGf7a0IMtnRS4W+6cOSXKWFpZjThrbDEXEpgvTwah9oZNzQdNdGf5GNXBPuF78WYroXcFAULHwbwiQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205828; c=relaxed/simple;
	bh=GTL7lfLqQg2oKlzbVmjbLCLKjuhCvVW9dLIhh8F61C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LXbJiCbBYevnFUljwzlu3fv/m61khK4w+enRGkcev+HPtNKiuY2d5vT0U7QOkuqjrXlaocwEsUhqrm7KKRFaUYQC6KocFvcEHouWux8eoyysVuKLvft2YFmb7SYoqcFppTXb8jhHoe104J6WZEY2+BFl4LQxsKXpI5gSUvk0hls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=F6q0PAQX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="F6q0PAQX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8484f229529so2313746b3a.2
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205826; x=1784810626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qpVNfPM2loki1/2WSjY19UJOAg4x0MrZ4b63t+Pbr9Q=;
        b=F6q0PAQXwf5d0w1jOqLx2K0qoVg2fk8qgi+lsTSlnjUvCqj7fSXus6MPZqkQPM9Kaw
         SaDC+UrciFz7zxDe3qWf6RvsX2I/ss5sSWunCKtTFaxpkSCq9jRZR7Tat7rrixvVsYnA
         Xz00ht/xgMvKkXnJFZUYgkMr+xUnXsCLhihGDkT2BaPTEctRxiaoJiUdvNubcWyKZO5O
         bKpz0cq8h71x+3JBALKBTDw7Ku4SZxlza2f8fZLSua4FnbBaffiDTbvwKd7Z0FNJeJw7
         KqP8uF+gmXcRK+K26obDJFO9yCszjcUWWGH7QBAm7XhGhAsKMPieDsv8HM1aoj+pKARU
         pRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205826; x=1784810626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qpVNfPM2loki1/2WSjY19UJOAg4x0MrZ4b63t+Pbr9Q=;
        b=CbZzimRvuYdF+c1KWNRt2HKxFWXyisER2+8kCKRDCs7VhsDHgiKBkUv2xwGMNCNjIu
         YTTlf4OTAjubLjhALhsZxGidAnVgqt36PMmoObwdpoinPXkCepLqvrgty78u+yM2Z7rR
         Yk1BzBhqkwS2aJGzbgbJOqjMbZJN4592BEsI6NHLfLDPKo5kmvsiAgg+OT19XPbOwvum
         faAwBj79l3OQHxToSxYtdvfw/YrvlKcFLDfSc7qjjjUK3UKV6Gw4nOUc4nups28yxRAw
         kpt5rQMSOLX7a/T8/sx3mmQ4TM3DI7JfP/KOY9l/oAJ7lLLVVTWlB3vlYquhJzq99DNO
         1erA==
X-Forwarded-Encrypted: i=1; AHgh+Rpkh09acVL3x2cdRN1ef6b+BEwj+VmttfW1Fx71vkEQSNUA1uKkTL7dugPBaMpeamqpuqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn6n2BxJwWqtSl6OO4arwSOQ2Ul+I1u+j4NJUiWZoxTtVbCpd2
	y+6GF4IX/fRYleYNR2wdmIJOSga/ql5CxdVQp2StbhwCvsuZ/my+oT9wdk2tli8mLRU=
X-Gm-Gg: AfdE7clW68Aia3SWofdRoC7LOR8De9eBQbA2JL6HF9XR3Wu3xcTfXF7PTtdkj/FmlQr
	2X4mkzRHg4yVEGc2Fq7DwmqEUj+MFjseGfA/umj3fIRqFUJ/2vjexZZkjhf4rD87QoBFdb8DKtC
	zk6b5qQOQAxmu6BW4z9z8DTu5kwLlWyDa5UOzv3urGAqkG6bbyzFdNjJ/pv1gFcUd12KII/scd9
	r4bbVy9s3gQ4bvlazqTWlh1R83DFgCr2Wg2mQBTdl4k15HRGgcy3YGEAXWb7aw+vGxcDnstGWWJ
	VYQEpJXIuh2AR7SLGvf4zC96U39YaNLJgXMAaeobfxEQe5ojFbPFoUutYZXaImkkR4gIg7yaEn8
	mJ+jiq8y9v0whUdkwMrptP/OvTMqw1MurMXZV2wrobPO2zLyrGKvBuiNcFSweCL1MSoC73Tnsnl
	sgSj+pmUA/OONUClLoMoFd8OE=
X-Received: by 2002:a05:6a00:451c:b0:848:2f74:d8d8 with SMTP id d2e1a72fcca58-8488986dd0bmr19929855b3a.73.1784205826475;
        Thu, 16 Jul 2026 05:43:46 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.43.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:43:45 -0700 (PDT)
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
Subject: [PATCH v2 07/15] riscv/mm: preserve Svnapot leaf-size semantics for page-table consumers
Date: Thu, 16 Jul 2026 20:41:42 +0800
Message-Id: <180084b20de76f7ad61641e9b7abe6d103caf5f3.1784201104.git.cuiyunhui@bytedance.com>
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

Svnapot keeps a folded 64KB mapping encoded in the page table, while the
public PTE helpers may expose a logical per-page sub-PTE view to generic
MM users. That logical view is suitable for leaf-style PTE consumers, but
it must not change the effective leaf size reported for the mapping.

Use the original page-table entry for leaf-size queries, so page-table
consumers continue to observe the Svnapot leaf size instead of incorrectly
treating a folded mapping as PAGE_SIZE entries.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index da7ffea0dcd98..e4b9c05014c00 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -580,6 +580,17 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
 					napot_cont_size(napot_cont_order(pte)) :\
 					PAGE_SIZE)
 
+#define __ptep_leaf_size __ptep_leaf_size
+static inline unsigned long __ptep_leaf_size(pmd_t pmd, pte_t *ptep, pte_t pte)
+{
+	pte_t raw_pte = READ_ONCE(*ptep);
+
+	if (pte_present_napot(raw_pte))
+		return pte_leaf_size(raw_pte);
+
+	return PAGE_SIZE;
+}
+
 void __napotpte_try_fold(struct mm_struct *mm, unsigned long addr,
 			 pte_t *ptep, pte_t pte);
 void __napotpte_try_unfold(struct mm_struct *mm, unsigned long addr,
-- 
2.39.5

