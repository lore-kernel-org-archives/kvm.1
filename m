Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8C28150F
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775107208; cv=none; b=uGRPfYdftGPB2h3nn4ZSWIRjZbqdkEEPzaDGW529XUnUQ8qk6OpR1HS7RrkORAwXq350MndORbUzBa5XtMVQTw9kGEKupouLmepSn6n2fCzOPjHFBh6pJIChaAzQkpYu1E7nj4quPNKx6TJPhHp5bnsWgGgngHRhqjJbyKba6n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775107208; c=relaxed/simple;
	bh=rirG7dXdlaZs85SD2FS2kk5f6PLtuyhPDVjoQlUhFFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDcNb1dvL33NDNwgl738lE3kVV+7AjINfUWEFHM06l6jrbflDlilI5atcefOld31ZhfB6YttbcwUD8mNrxYmhm0D81qW+gIVGJeJN1z57U2V5En6ABgOgctkJenki1CvNgR5iPrE6hPWW0Fied41e0ez/38R+sF9e+K3IWUJ9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVxSkwSQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVxSkwSQ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35daa02ea08so17423a91.2
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 22:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775107206; x=1775712006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xaxw8FD+mFZydbFnh3nyyzgdnrrrUvvU4FLHJUXGXks=;
        b=rVxSkwSQcxAPMiTMYgi5VMqdOGLQ9JqiZodBFW/HznBFeXcgtFaD/syGMT8TFgzVzZ
         Ib8bXdmcQZlGQRNiy5A6g+NDWcUSOPcoWvy/MNoUn24Q/tmodo9GHzf07joG9vRNry6s
         iaWUybbX9szcxBvhN6QGFQxmsuuOUAvmBzvF+9yeawHgCBS5qmNhyD01t8XYjmKzQwVt
         0aV5C9Kw6vcBfLA+754fMmI0S02G44aHmnunvCFSMUUXNVYKA4lmxPKsLtNA2b+Ft5Oy
         2d9AmGA1HtuRZdYBCj9rgsFKvg4F918QvIvX0UP1RomFMjENHp6+77hOu3BSiKXd0PMV
         KfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775107206; x=1775712006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xaxw8FD+mFZydbFnh3nyyzgdnrrrUvvU4FLHJUXGXks=;
        b=kY3hZiJC9ZOBYy8KPtXFLwOQBT2uKVXvSp1tO2ORLGCRcLeJ06v6kbw/kdGa4B4WF4
         ZAAJgFNw7WlCJftVTh/+2l4ov+YB7KzpskVwCVZK8RQBPVcw2bFn6KIGcFfGelzeKKOz
         ubvwmGgn9J2MAJkU9G/omJBwU0mIHIGY8pE+LUi4fLqO3PTExtdpfN/WILrKP9670lS8
         y6gyv9UsCrDLwzPmTNJnGEMx6AIMXg1LT0fUzpYlPdVVys3TeTL70LVNUhz5RcD+uVGc
         r4l480ZYvRFnQod/ljK+LlXgAh+0qK+9gXAR/aEhHLTVeza9yaXGqeqiP4REn2woQvRY
         6CTA==
X-Forwarded-Encrypted: i=1; AJvYcCXxwin5MKpShA5AMxe9pB0Cja4l+ps+dnzJsxUnWA4x+AdkEpBVj95vH+2guPH1PgqCppc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzit7yOgkct4JUlR/RAf45i5zVhaDaxi7uAm57FTa4MbkFwC8lq
	OAAJEC6VadSQy0v4hQ7GepJnLMl1tW+qwiqwHOcmDgica6R+N2zPwoti
X-Gm-Gg: AeBDieuIPB3RydwGb+JuMAXDhaeNyg0Bg337b/RmOtC9ku63gFYQtAgjERQ8o9V2qSN
	QM+QyLbgAUkYsUkolUPwuQqM21JAvWI3wdrUqfZfads8ju6jUtDEXZesFN4cWFvPRUkb+kpMyI0
	IpREjjH+dmy0/5OQhBbSNvwNgTcb7MWQHhNjI4765VyLAr2uG9roif8eK6n1RnRudojDIP+xq9v
	TJkAabBoQk2sjWBoV3SQRgM2nD8EstwcuqBL1L6rJqmmNENpRwc3l9pAP1mR4GL11JG6V9LnTWr
	pW6wt1lfVOpsnWM/YlEo/PlPlrB6keTfqaihIt1vwmGr1Qej6hwP+7n/sM5idzTY3dqR75NcQNV
	09GDHr8Q+DRExpnjNAvfMEhQaZZwJjeyd5+DvVFUAlWMN0zDFp/1PiU7e0mYK/5exFpGCEKQFBC
	mZlPAkaHcje2ibvloNzgAXs+0D7vbMSmSslttrNl3z/vMZARrcQTpDe+fsDZQDnSgZUj8=
X-Received: by 2002:a17:90a:ec86:b0:35b:a241:ffb2 with SMTP id 98e67ed59e1d1-35dc703b635mr3600154a91.7.1775107206477;
        Wed, 01 Apr 2026 22:20:06 -0700 (PDT)
Received: from BraveProgrammer ([2402:e280:3d94:585:407a:b266:f3b0:4e10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd36a1d04sm1841668a91.17.2026.04.01.22.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:20:05 -0700 (PDT)
From: BraveProgrammer <spujari79@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: yan.y.zhao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com,
	vipinsh@google.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	BraveProgrammer <spujari79@gmail.com>
Subject: [PATCH] KVM TDP MMU FIXES- Replaced unsafe panic calls with proper error handling
Date: Thu,  2 Apr 2026 10:49:40 +0530
Message-ID: <20260402051940.1051-1-spujari79@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unsafe Panic Calls Converted to BUG() AND BUG_ON()
AND
Added Proper error handling: Using WARN_ON_ONCE(), pr_err()

Signed-off-by: BraveProgrammer <spujari79@gmail.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 9c26038f6b77..3396bf157716 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -590,14 +590,15 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 		pr_err("Invalid SPTE change: cannot replace a present leaf\n"
 		       "SPTE with another present leaf SPTE mapping a\n"
 		       "different PFN!\n"
-		       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
+		       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d\n",
 		       as_id, gfn, old_spte, new_spte, level);
 
 		/*
-		 * Crash the host to prevent error propagation and guest data
-		 * corruption.
+		 * Return early to prevent invalid SPTE from being set.
+		 * This prevents guest data corruption while allowing the VM to continue
+		 * in a degraded state for debugging purposes.
 		 */
-		BUG();
+		return;
 	}
 
 	if (old_spte == new_spte)
@@ -1453,9 +1454,12 @@ static bool wrprot_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 	u64 new_spte;
 	bool spte_set = false;
 
-	rcu_read_lock();
+	if (WARN_ON_ONCE(min_level > KVM_MAX_HUGEPAGE_LEVEL)) {
+		pr_err("Invalid min_level %d for write protection range operation\n", min_level);
+		return false;
+	}
 
-	BUG_ON(min_level > KVM_MAX_HUGEPAGE_LEVEL);
+	rcu_read_lock();
 
 	for_each_tdp_pte_min_level(iter, kvm, root, min_level, start, end) {
 retry:
@@ -1887,7 +1891,10 @@ static bool write_protect_gfn(struct kvm *kvm, struct kvm_mmu_page *root,
 	u64 new_spte;
 	bool spte_set = false;
 
-	BUG_ON(min_level > KVM_MAX_HUGEPAGE_LEVEL);
+	if (WARN_ON_ONCE(min_level > KVM_MAX_HUGEPAGE_LEVEL)) {
+		pr_err("Invalid min_level %d for write protection operation\n", min_level);
+		return false;
+	}
 
 	rcu_read_lock();
 
-- 
2.52.0.windows.1

