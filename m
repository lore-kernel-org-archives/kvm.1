Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05735313283
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196489; cv=none; b=EkTUIySvlMpMXDj1MyfQ6hPw1m5Xvj3iHUE8sg9Ma0IBVOE8dK2vGG/xGe/N8ktk0aiRS0S01c8DKOyRFWhwRAsk36hrDorqgqOze1ILjRurukm3MQSrt1i6Cfo969DK/jPbVOAMx45bOTcY3CQNb3+LLIFyV0f/kS/ldvNo8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196489; c=relaxed/simple;
	bh=0JdSEfgAVgO/L7bsCHzX4DJzUNLdqutxKoKw7iNGDsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlXpEy4XjSZXosxhC0kD8WUAwvFAYwgkiraML6C7oH2Z9NWspHaeiVzduRXsfPPr3WdJ7vA2ctsBlYHoTiZcDxdEL90PNGYVQej/iFvP/WvqstaefbytjCP0GDVHrbb8tUORttVuS2GMFjXl6WHaDSM6OkhiE0Dk1ojDxX5rFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ko1Br3B7; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ko1Br3B7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784196482; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pUYM84ocghtsnSmh5pKhh7fbVoEF0MqzNRBNTH72wY0=;
	b=ko1Br3B76vtmBNs8PdLVumFtVV6ZGEweIpUZOoYbDCyF9+P1GA3k7Nj7HYx09XqHblIs7R4AMlFa/6Ou+rKyUKoYQnhPGtZ3EE83F4k11/6tS+IDxpfsLpsXYibKCzv1a9ENVvze69ymaqu/WKl/amz37elIcKVuAuHM6mLMLhA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=yexun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X7E-JGC_1784196481;
Received: from localhost.localdomain(mailfrom:yexun@linux.alibaba.com fp:SMTPD_---0X7E-JGC_1784196481 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jul 2026 18:08:02 +0800
From: Yexuan Yang <yexun@linux.alibaba.com>
To: kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	chao.gao@intel.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	Yexuan Yang <yexun@linux.alibaba.com>
Subject: [kvm-unit-tests PATCH v4] x86/lam: Allocate test page from AREA_LOW instead of AREA_NORMAL
Date: Thu, 16 Jul 2026 18:07:16 +0800
Message-ID: <20260716100716.1313-1-yexun@linux.alibaba.com>
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
Signed-off-by: Yexuan Yang <yexun@linux.alibaba.com>
---
v4: Change author information.
v3: Change static_assert to assert.
    https://lore.kernel.org/all/20260603015831.41664-1-yexun@linux.alibaba.com/
v2: Assert vaddr instead of pfn.
    https://lore.kernel.org/all/20260602060116.35206-1-yexun@linux.alibaba.com/
v1: https://lore.kernel.org/all/20260601035401.39303-1-yexun@linux.alibaba.com/

 x86/lam.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/x86/lam.c b/x86/lam.c
index 87efc5dd..63a36539 100644
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
+	assert(((u64)vaddr & GENMASK(63, 47)) == 0UL);
 
 	/*
 	 * Note, LAM doesn't have a global control bit to turn on/off LAM
-- 
2.54.0

