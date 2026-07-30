Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB143EDAA3
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403039; cv=none; b=czrp2mUsZoWTdDUfPQkcC5ij/EvJhj+Wry342aENN4zj0WROh7yitBUl8v4hnLOujiXZHqoO7xkWHY89I0z/z8XQWMI53ivB2E3JzQVra6uqrLKH4baznhQGCH2n3MOhMhCflUY8Z5fkz8aDfcMBn09NEf31/Xztw+7d/35tobs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403039; c=relaxed/simple;
	bh=60vYiIIgj+T21RufVqRtXsKfrK60n4K9r1ZXF+KK7CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iARIxb63lCVljHXYHZllCQjJ0UV6xTM74WOdf9Ltz1aWfvTfI4EGgcDyjiqzbNUbOVVER+2cYjQj5cUOHHQUt1x3BBfEov77GMD1MpV1M1qApQeuLQG/gzjkH38r5uPBfAMg+fm6xU+yq6E74rUT4uneFmowv7K+zK/EDXSlLXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiXUnJXR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiXUnJXR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceaf8a1265so24086235ad.2
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785403037; x=1786007837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=luAWvof38jeXPbjahnYlH8nET33JhWw2Qecg1TNtU7U=;
        b=EiXUnJXRZzwFhKAI7KmeapaoA9CUpCJ8+F1LXQoOzbvfr0YsZGRgFFEXq3rutMAxNv
         Jni8v1FFzx1HSsMcy0RTns4sY5R0kdGNy5wsta56RoOdW8y4VjT9w38SiFtKVqyfE7VN
         1P4lTZ8EbjrXYyOjn/3KbX2h0ZJ5oap5qOaZ9jaCvcE3tUjXyvtF30BSfkzr2hFPmCJ3
         oXOb0905yF1nuS0hwqtfeQz0aI7WN1ArLd0EJ9/cK05eJRzrfbH1ZB/VdlJJwEycx5p6
         2etTA8vupSrp+Udb4AUr62x5l4l6Q7hwrfu28wi01x2TxtgWZrGBFZ0omaU+3MlqjTPn
         yyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785403037; x=1786007837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=luAWvof38jeXPbjahnYlH8nET33JhWw2Qecg1TNtU7U=;
        b=XXHAHNIMTjXRUpApuAM9d7mJSV83BPp8dnHcf05a2W862kwptQO1NE3cKd7aX47g3M
         XytWmW+UJKHHjLu6wPV4QnQmdze6m5I8T3nNHY5D38Dj9tbd1N0P9jyCIJCfue/hfJib
         zWFyV4ZeNQ4PdtpBz/ubTxnFXFeEE5wCEqRU2J85N+Zvk+LS5/qL0gmqN2cchv7Y0xO4
         PFcbZ2OQtm8Jn1adXXpbhXtFHE1S2pRYg/fX+j8Fh1XGT+82lY1++xR4fyFc34Z0KHRP
         rct1rG0IqYiy5MfbaM+YCco/jVt9P4Ui1ab7vMHGt9qJeAhABF7kGBiV6fz9BCzXQ+Zu
         6hZw==
X-Forwarded-Encrypted: i=1; AHgh+RqhTM9diiVX8w+I/Cz8v9vlZHmOlJ7icsHrCIuYGab/XUk5ws1LhsKT+jbADLjHWHARqWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7i1D/Ipldbmg3048MMt1rQxf+VbAuKOvYISgDiSUPTkHbFmiD
	h7g22QTlAZmcDQVb/ZhuOLrhyFPv7Zj5vn/94nCQARENX+ng7rnt8+ZB
X-Gm-Gg: AR+sD11ahT9I9jpn5FoE/eqZ0JaqQbU2jAPnIwh4/mW6kFg9AB1+vpKmJuB8WY4xqEi
	Mq6PzIS/yNJKPHj7vUL44kA2IPlhVPhmLDUUnrsQ6VcRbTbBNYe7PbW0oMzq1gao42qteUFneB7
	b0aijFvYXcA9cX6aBS2PV/wa9ijwTRCvPrpQeTtJtT75/7EzvDaG2OGI9QdR/6Niq7nRf8UUh0J
	7I94V5Pg31TzwLB7n8jbgTGYLpQ527qQZ+PeXuzJ2MxoKN9Gf/4QDXRhEnTPTqZm+AJDWbXVrfL
	qAghwVPNPxlRdcGlB4Xnoffv67ILU4MKzNpFIzyhK/6bdg4Uq7bWWQAgKfx1cZYPVm292jB+BSw
	uUg9h12Dp5SClRcozrpPTCleBOcDNe00kZsY68GqJbW3FGYMUWKMp+t/SsRiD6kAVVGYDgJfmm+
	raTGo9w3Ej/WTgkPzSJoqTkPV5LHW8G50FJBTdHGfIkrXvs77NPzFtyZqImQ9f0p+MqDWc7zbyX
	tdVsQ==
X-Received: by 2002:a17:902:d4d1:b0:2cc:f43b:fa4a with SMTP id d9443c01a7336-2d035ce64fdmr16534475ad.24.1785403036908;
        Thu, 30 Jul 2026 02:17:16 -0700 (PDT)
Received: from 2045L.tailb1cd6d.ts.net ([36.112.122.101])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2d022bca9d7sm23779615ad.52.2026.07.30.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:17:16 -0700 (PDT)
From: Guidong Han <2045gemini@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Naveed Khan <naveed@digiscrypt.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guidong Han <2045gemini@gmail.com>
Subject: [PATCH v2] RISC-V: KVM: Fix PMU event info array size overflow
Date: Thu, 30 Jul 2026 17:17:10 +0800
Message-ID: <20260730091710.1366757-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718153620.829378-1-2045gemini@gmail.com>
References: <20260718153620.829378-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SBI PMU EVENT_GET_INFO stores guest-controlled
num_events * sizeof(*einfo) in an int. On RV64, num_events = 0x10000001
makes 0x100000010 truncate to 16. KVM then allocates one entry but loops
over the original num_events, causing out-of-bounds reads and writes. A
nested guest triggered:

BUG: KASAN: slab-out-of-bounds in kvm_riscv_vcpu_pmu_event_info+0xa4/0x142
Read of size 4 at addr ff600000074d46b0 by task init/1
Call Trace:
[<ffffffff8006471c>] kvm_riscv_vcpu_pmu_event_info+0xa4/0x142
[<ffffffff800690c0>] kvm_sbi_ext_pmu_handler+0xca/0x268
[<ffffffff8006779e>] kvm_riscv_vcpu_sbi_ecall+0xec/0x1e6
[<ffffffff8006008c>] kvm_riscv_vcpu_exit+0x48c/0x540
[<ffffffff8005ea0a>] kvm_arch_vcpu_ioctl_run+0x37e/0xc80
Allocated by task 1:
 __kmalloc_noprof+0x19e/0x4b0
 kvm_riscv_vcpu_pmu_event_info+0x72/0x142
 kvm_sbi_ext_pmu_handler+0xca/0x268
 kvm_riscv_vcpu_sbi_ecall+0xec/0x1e6
 kvm_riscv_vcpu_exit+0x48c/0x540
 kvm_arch_vcpu_ioctl_run+0x37e/0xc80
The buggy address is located 0 bytes to the right of
 allocated 16-byte region [ff600000074d46a0, ff600000074d46b0)

Store the shared-memory size in size_t and reject multiplication overflow.
Allocate the guest-driven array with GFP_KERNEL_ACCOUNT so it is charged
to kmemcg, and use __GFP_NOWARN to suppress allocation failure warnings.
Use kvcalloc() to allow vmalloc fallback and an unsigned long loop index
to match num_events.

Reported-by: Naveed Khan <naveed@digiscrypt.com>
Closes: https://lore.kernel.org/kvm/178345245327.72065.13249716450708539854@digiscrypt.com/
Fixes: e309fd113b9f ("RISC-V: KVM: Implement get event info function")
Cc: stable@vger.kernel.org
Signed-off-by: Guidong Han <2045gemini@gmail.com>
---
Changes in v2:
- Use an accounted, no-warning kvcalloc() allocation and kvfree(), as
  suggested by Sashiko.
- Naveed Khan reported the issue before v1. I missed his report at the
  time, so add Reported-by and Closes tags to credit him.

Link to v1: https://lore.kernel.org/kvm/20260718153620.829378-1-2045gemini@gmail.com/
---
 arch/riscv/kvm/vcpu_pmu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index bb46dcbfb24d..8e1f6abb84e2 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -12,7 +12,9 @@
 #include <linux/err.h>
 #include <linux/kvm_host.h>
 #include <linux/nospec.h>
+#include <linux/overflow.h>
 #include <linux/perf/riscv_pmu.h>
+#include <linux/slab.h>
 #include <asm/csr.h>
 #include <asm/kvm_isa.h>
 #include <asm/kvm_vcpu_sbi.h>
@@ -479,13 +481,14 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 				  unsigned long flags, struct kvm_vcpu_sbi_return *retdata)
 {
 	struct riscv_pmu_event_info *einfo = NULL;
-	int shmem_size = num_events * sizeof(*einfo);
+	size_t shmem_size;
 	gpa_t shmem;
 	u32 eidx, etype;
 	u64 econfig;
 	int ret;
 
-	if (flags != 0 || (saddr_low & (SZ_16 - 1) || num_events == 0)) {
+	if (flags != 0 || (saddr_low & (SZ_16 - 1)) || num_events == 0 ||
+	    check_mul_overflow(num_events, sizeof(*einfo), &shmem_size)) {
 		ret = SBI_ERR_INVALID_PARAM;
 		goto out;
 	}
@@ -500,7 +503,8 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 		}
 	}
 
-	einfo = kzalloc(shmem_size, GFP_KERNEL);
+	einfo = kvcalloc(num_events, sizeof(*einfo),
+			 GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!einfo) {
 		ret = SBI_ERR_FAILURE;
 		goto out;
@@ -512,7 +516,7 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 		goto free_mem;
 	}
 
-	for (int i = 0; i < num_events; i++) {
+	for (unsigned long i = 0; i < num_events; i++) {
 		eidx = einfo[i].event_idx;
 		etype = kvm_pmu_get_perf_event_type(eidx);
 		econfig = kvm_pmu_get_perf_event_config(eidx, einfo[i].event_data);
@@ -525,7 +529,7 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 		ret = SBI_ERR_INVALID_ADDRESS;
 
 free_mem:
-	kfree(einfo);
+	kvfree(einfo);
 out:
 	retdata->err_val = ret;
 
-- 
2.43.0
