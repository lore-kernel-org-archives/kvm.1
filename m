Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07003921C1
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380104; cv=none; b=koZjwT/WHki0LWhcs9EtM8+Bu5bRfkuqcOn7rbgGs3G67wdsQYxbfW0scd+VUgbkN12IKFEnOP5d2QgiMHbrBHwtATlyMwPKqmB2TMJ/qkwMcHdvPrzBGZY5A8zhhueVQICEQOOLvEoTIat/hqzHF8iGZ7fNcpJpYlaXmLO3JUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380104; c=relaxed/simple;
	bh=wkmtikmkxQwjZuZgSGvmeWZzCD0oweMncxQ39GhWbgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/LzIoV7hpqS3khynU62USbaTduuquK/M8eDaIZuyJNO2vJqgOGwpci4Ub9DpqQYrhYzTLvVCyso7/YFaJ9jVBbXbNMftLL5uAnTV9XTmbeHFPmIR+oR1yeCD9AYS1wAHz4qipn1tnNptlLisFmrxiku2SWPdYTuYeyoMpm2efM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lczfyOD8; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lczfyOD8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780380097; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZTJNGBzKsmx3/vuD5sFb6sPG8ydhBqE4rYnSSTejiXQ=;
	b=lczfyOD8nbzwyJZcj+qMCUag6FVH2Ah191vw3ZaTeOMlAcYIYRYWnW+m/PFCRMwrhaUtgN9V4hCAQVJ3TXXbshajOcyog33mEezzieSgMBjbr8gscWKBKCdDfJ9vQV7cAUSwxii0UhYiG9P7PwF4M+HjJvFCuBD4xj/+AoIscWU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=yexun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X43GaWy_1780380095;
Received: from localhost.localdomain(mailfrom:yexun@linux.alibaba.com fp:SMTPD_---0X43GaWy_1780380095 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 14:01:36 +0800
From: yexun <yexun@linux.alibaba.com>
To: kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	chao.gao@intel.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	yexun <yexun@linux.alibaba.com>
Subject: [kvm-unit-tests PATCH v2] x86/lam: Allocate test page from AREA_LOW instead of AREA_NORMAL
Date: Tue,  2 Jun 2026 14:01:16 +0800
Message-ID: <20260602060116.35206-1-yexun@linux.alibaba.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lam test does not set a guest memory size in x86/unittests.cfg, so
QEMU falls back to the default of 128 MiB. AREA_NORMAL starts at PFN
BIT(36-12), i.e. physical 64 GiB, which is never initialized in a
128 MiB guest. As a result, alloc_pages_flags(0, AREA_NORMAL) returns
NULL and test_lam_user() ends up running its LAM checks against a NULL
pointer, which is semantically meaningless even if the metadata-bit
arithmetic happens to succeed.

Allocate from AREA_LOW instead. AREA_LOW_PFN is BIT(24-12) (16 MiB),
well within a 128 MiB guest, and bits 63..47 of the resulting linear
address are still zero, so the LAM48/LAM57 metadata-bit checks remain
valid. Update the adjacent comment accordingly.

Fixes: 0164d7595c85 ("x86: Add test cases for LAM_{U48,U57}")
Signed-off-by: yexun <yexun@linux.alibaba.com>
---
v2: assert vaddr instead of pfn
v1: https://lore.kernel.org/all/20260601035401.39303-1-yexun@linux.alibaba.com/

 x86/lam.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/x86/lam.c b/x86/lam.c
index 87efc5dd..33772ecb 100644
--- a/x86/lam.c
+++ b/x86/lam.c
@@ -231,13 +231,13 @@ static void test_lam_user(void)
 	bool has_lam = this_cpu_has(X86_FEATURE_LAM);
 
 	/*
-	 * The physical address of AREA_NORMAL is within 36 bits, so that using
+	 * The physical address of AREA_LOW is within 36 bits, so that using
 	 * identical mapping, the linear address will be considered as user mode
 	 * address from the view of LAM, and the metadata bits are not used as
 	 * address for both LAM48 and LAM57.
 	 */
-	vaddr = alloc_pages_flags(0, AREA_NORMAL);
-	static_assert((AREA_NORMAL_PFN & GENMASK(63, 47)) == 0UL);
+	vaddr = alloc_pages_flags(0, AREA_LOW);
+	static_assert((vaddr & GENMASK(63, 47)) == 0UL);
 
 	/*
 	 * Note, LAM doesn't have a global control bit to turn on/off LAM
-- 
2.54.0

