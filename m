Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F29741F34D
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205873; cv=none; b=XggOe1znHLMjJDiIzjafpmiCe3xzkiQuvQUyS2LaiBY6rEYXtZalxVEn+ESQZcsckbHrR1z/LFJt9w3EtrK9bNLTMLmJ4wenFu6mOdUvZUVnmikpGz/rXxubwzwvqj9wkd6cPj/kc1jpUngLlWjobmtLYRB/4AXrZCsZnVJGB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205873; c=relaxed/simple;
	bh=z8jC4aCjR+Oesc+bLFA5i5JVDTkwm+Fh6FK3DV0FuyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BAOHP1Fs3DDv1XLhBWtj3+TcGMk8qgI2nLvY1VL4mMq+ilsNiKqiAfzJY6UVfDSl/r4s4kRmcgqKHh5RuS6mJRPQT9fcHxFvXddjlWov36q9pLOfRCgaiJzcbDaGWPZL/xQ5ERFKsIU3L8MdwF5gvjJw7wfblWZK2qdGNPTz08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C45IRpyv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C45IRpyv"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8485b358552so7269903b3a.2
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205872; x=1784810672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0haKjxFEA+XqfWLiPeMGRklJhvkZG2bsdABvuKjaV0=;
        b=C45IRpyvX6HmHdRZR3ZZ+1wy3BA5jkkEbDBp8+0GIb3o9EyyKPwbNvHw2gGop+WH2c
         pJiaNzVp6Tniz9si9bxp1FJoCGkPE8k84euMkqm9kHAOFakSHiXZCDq0Q+XNGenmtk0X
         AcNSdJFQzBIV3POW6J76B1U56B9a2HCGgTukkQN1LtUpyVMDf+QoJHwDHIP6cYbYhScP
         4Dl8WlrRhjr4kPy3MarWxpCJp9GcpM6nLT8uYIJ1cgPvf+qJwvLg+0bPsQ6qcGg1d3A1
         k+9C/SiPoGlnyNUZlQMiavpIldAGPonCUQBrMKCOqletZW6U9r8Ivbrkc7cDS/RvKyUG
         xz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205872; x=1784810672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s0haKjxFEA+XqfWLiPeMGRklJhvkZG2bsdABvuKjaV0=;
        b=ZZRCQg2J1NL9P6c7enjsU9xEEmSdBiobss3P8T8IoJqrOKi2f8BZo6KJC6Wbxq2h9G
         tmJ9m0VghRJ5QWex5AXjJmHAzZxy4xvaUWZRce37PTwar/KEsahx+yhuklc164Ul0bHs
         1fuG2+almI2NN7XIQxCELIQDNozonOEsAl8JLuTc/aFnjP3QIfqIy38eyD4STNHpMKnZ
         rAFGu8kzHtxygeJ9d8DYyDjlmiZqwOrN/ArzumYTJhsNwPVnr4SZJtkrYW1lzfQwidM3
         2UWRuWkIb//yKu4/B+03BQd4Fm1yr83meUyGDeloXPfZpINIUqsU2jiHPaYXDcioB/b1
         SPHA==
X-Forwarded-Encrypted: i=1; AHgh+RooG/RW4alJIE6Z55QghYxdeXjWWM9moq+/h9IwH6OSg0igP82h5i6IURN3TYolI44/w6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMgCjxZTJdzdCHd2h2KotOkHyZweG2Kt4t3y8ASxxeZ2QA8x3u
	c8/meqXZxbl1Kx0h65Yxl65xXa2ZSY9gkoBPMR8QoXvlKJFKCQh1jGKlXfvqLULnzWU=
X-Gm-Gg: AfdE7ckiO43wk7yx+9RI4vfA4kFc2n6smoSs2wO/PxeOVjYNMa/q5XnDMb0FJH428b6
	DaXN6iJk3I09D+H4AVvqSn1XQNV9hfxPxXzcdn9i2TcPAdhERRcqIMllNFKRiQebnOnL08/v6T8
	qTa5lKaVw+6ZDSxqGN2MjsqTzOu/ZFMZlHuYyHTwQ4reN17j8xXcH9s2cBDLBiXAlRzrrUI30Qo
	LyDL7wxdKs83VYlMPCLjFEnXHR301G3W1aNipIyG31XZqsCXhzKDLIQYAdna/7A+LPKD1uG6OZU
	Uu6MtQgw7ATGNzoU7ky8w35Tpvm7ayGhGMptgMvbFrqmR+/6lHQHjPQXC5wts4eei9i8Z1hUCUj
	YcUQgHoBr8gKmaUTEJqPvPGxHMdbPPGd7wJNHs3fe0UJeKeoec36/zLiZ7Xdori6HcSFmjk1eWi
	mJm3Uq0EmWPUK4TlKGBo6sDSSxkOG4BiUT0w==
X-Received: by 2002:a05:6a20:e615:b0:3c0:9c19:6590 with SMTP id adf61e73a8af0-3c3576c37f6mr12235735637.74.1784205871769;
        Thu, 16 Jul 2026 05:44:31 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.44.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:44:31 -0700 (PDT)
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
Subject: [PATCH v2 12/15] arm64: mm: avoid contpte A/D aggregation in fast-GUP
Date: Thu, 16 Jul 2026 20:41:47 +0800
Message-Id: <92fbae3247b4bf0d7989ba20a8763ecb836d0279.1784201104.git.cuiyunhui@bytedance.com>
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

fast-GUP only needs the PTE state for the current virtual address and
revalidates the raw PTE after pinning the page. It does not consume the
contpte block-wide accessed/dirty aggregation provided by the public
lockless getter.

Override the fast-GUP PTE helpers to use the raw PTE for the current
entry and raw revalidation. Keep the public ptep_get_lockless() semantics
unchanged for other lockless users.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/arm64/include/asm/pgtable.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 018781a1fcbee..d1e08dce9f7c5 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1760,6 +1760,22 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
 	return contpte_ptep_get_lockless(ptep);
 }
 
+#define gup_ptep_get_lockless gup_ptep_get_lockless
+static inline pte_t gup_ptep_get_lockless(pte_t *ptep, pte_t *rawp)
+{
+	pte_t pte = __ptep_get(ptep);
+
+	*rawp = pte;
+
+	return pte;
+}
+
+#define gup_ptep_revalidate gup_ptep_revalidate
+static inline bool gup_ptep_revalidate(pte_t *ptep, pte_t raw_pte)
+{
+	return pte_val(raw_pte) == pte_val(__ptep_get(ptep));
+}
+
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	/*
-- 
2.39.5

