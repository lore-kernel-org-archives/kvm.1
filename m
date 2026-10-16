Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A58470122
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145717; cv=none; b=aO6zWO62DqyNq4sbB4giO5WKTRbZVVvKmjs1xwwHv5Qic9aMWRhyYrS213+JzsmWNUpWOqJWHjyr3pn2gKgTwvBFBWS0WFPp3UF1wg4PL/THUQwnH4K1m8q3UUl/hr2C0fR8qreP4mQN/YXYS8Ap4Qn+KqTb/gEDSmWsb8wKmo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145717; c=relaxed/simple;
	bh=5+Mp4TeDYq2o2TK3O/vdVC//j8jljTpTyZBFtmJvflw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iojmA1Yk1jEDiDhcSCVnrE0jT0WmKVhjiKdZnXc2KjxVuLZc2jv82LFg4evWoPexZARwUb7Skaxh+3nz3nFrhpU8WgE2rER0HLssuAs8ZspowGLRB6Q0QncRLxScNk9PV5eHSF/1nJcewmBKBZxw2d4YInXkBlFAwg16U7MwOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYjhTfry; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYjhTfry"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e987b4a710so2631485ad.1
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 03:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792145715; x=1792750515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vf6qHtCJHYPPUhzxjpIczur0NsiTKA4BX6nz592iMDQ=;
        b=BYjhTfryOnMsL2nJc/pxdvotLlKoa8WSJ+zs5hTyG6HElTUdnmUC/9W2iPP9/AyP15
         CSJpET4eNB6wRyfZe/08CAI6I+18ukOQo7bAeBFfFKurYs6pOcl6yBUvnbopE/fZmdKo
         n4SkE1maVnDEvl54LJQnTmNXTKu8IXMzi7JMqdLHDPPIvO8CDS75My3tdiJqQJt1OcMv
         XoSlq/DDEGupu701v6DxsiaxCNCYp1z3k+GiLErlXfUXGjxzvMU+OC0H5OQ7tdc+mrsD
         svobjx+8d/Vjx+vpaWCYQI1mB7Rsl4VjHvsSnqh5x372jVpxOZk1xMyAoInhhK2z22e5
         V4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792145715; x=1792750515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vf6qHtCJHYPPUhzxjpIczur0NsiTKA4BX6nz592iMDQ=;
        b=JwQ3YPb1iKCF7NZmJnc77CEJJjPQW4K/p8sidmVXzhI/DpfsIlkHGUTfap8HdR/VCD
         b/r8pwGCeJH1KJhxJ37QSqNo5L3dGPlWGOJRK0KSfBalBLI5gz548UHTI0ghLzhBlgQj
         32xPxsl+pbUpQpbCG0AhW6OiQChJJuJll7bp5IWfL5GgTDP7KE9B2g0NoXuWIF/XLxrj
         JX0H4+0Wd2ehzBxBieGIRRpnI6Dc/Wxf8Ut910pHN9TWC9Me50naYIFpArwCtLK2c5ys
         Gj0CyJ0M02w/1iOMiF78HTw939ustFNJ+Z0cwHdFQTN6YHGpnG5bL0YjX7CQdPzQB6xt
         WHfQ==
X-Forwarded-Encrypted: i=1; AKwUvByMvttnBarbQC3hPhZGRuWDoD4nsTAvsiFdhy3YHbeMKqDbMiaKFZA9kX4rF2Ry5cPTaq4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJb0DF+Qz9I2HAL5ioYqzrabDMp6RcgOXFPo/031rTXrtn9lPS4
	oej9nSoIeW6u68pffm89g2S5gwyTAb2pEw8MM/aNbqltavYVKikpfg82
X-Gm-Gg: AYBFou0xrtVmDA7FkPlSfGAxY7q7buLA2DZSZyBpNCwZkTrGKX2XGxRKNJUgCaCq7LA
	SzXUA3Yt22KmvKtRJXaZffhOFyvMVAvl16xqlSdXCk5Fz1NDCymrh6JZsfPiUf9SmSEo0EnPfdg
	pGI2AOrSqXg7Nr5wC/8EUzxjC2I1maFr2ae2okCrm9zWnJUxlL/5SAyfzU2Vylu6tig29UQ0+84
	OScb7Gjt8lvCD3Wk3Nvn/0Fc+eagZQNm5drFzG5lb68vwQA72XWOw2ejMVX8i37++deB6MrByXg
	ikK6qu/LV3GO4q1IS8382qMLVRB20mV+cxpvG/AUPNHu+4LNzFvqaC1Joavj5UaX9yotkOhM8Mk
	dQpXolt54w8JB0M0FPNTBLvVWPObgu1MlazmuUepuCDySTZ9tdqBzE19Tc2ppbCTgjh7DFFu+m6
	ovx2bUut8haV8C/yEGGUXufRuMvWbHo6VFdbGSoHb4sy8pcPvhenINop4ixTLVpIM0tVgiZaCpv
	mJaZWR+MuSAEMk5MqKP9Q==
X-Received: by 2002:a17:903:2f8b:b0:2df:b004:df28 with SMTP id d9443c01a7336-2e9772b0555mr20367255ad.35.1792145715452;
        Fri, 16 Oct 2026 03:15:15 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e85fd1dsm7876465ad.49.2026.10.16.03.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:15:13 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: anup@brainfault.org,
	atish.patra@linux.dev
Cc: tjytimi@163.com,
	inochiama@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andrew.jones@linux.dev,
	pbonzini@redhat.com,
	seanjc@google.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH] KVM: riscv: Set Accessed bit in dirty-log write fault fast path
Date: Fri, 16 Oct 2026 19:14:58 +0900
Message-ID: <20261016101458.221648-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_riscv_mmu_dirty_log_write_fault_fast() considers a leaf with W
and D set already handled, even if aging has cleared its A bit.
On hardware that faults when A is clear, the fast path returns
true without setting A and skips the slow path that would set it.
The guest retries the same store, but A is still clear, so it
faults again. This repeats indefinitely, preventing the guest
from making progress.

Host reclaim or page_idle can trigger this while dirty logging is
enabled, potentially hanging vCPUs during live migration.

Require _PAGE_ACCESSED in addition to W and D before treating the
fault as handled, and set A along with W and D. The existing
cmpxchg loop retries if aging changes the PTE before the update.

Fixes: 7705be59eb2d ("KVM: riscv: Fast-path dirty logging write faults")
Cc: stable@vger.kernel.org # 7.2+
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
Testing:

On a HiFive Premier P550 (EIC7700X, which traps on clear A/D bits),
run:

dirty_log_perf_test -v 3 -b 256M -i 3

While the test runs, repeatedly mark all system RAM idle through
/sys/kernel/mm/page_idle/bitmap.

Before the fix, the test did not complete its first iteration in
over 11 minutes, with lock_stat showing about 16k read-side
mmu_lock acquisitions per second from the fast path.

After the fix, all three iterations complete, each taking about
29 seconds under the same aging workload.

 arch/riscv/kvm/mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 78a1826c466d..042d1e3b3547 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -591,14 +591,15 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fast(struct kvm *kvm,
 			dirty_marked = true;
 		}
 
-		if ((pte_val(old_pte) & (_PAGE_WRITE | _PAGE_DIRTY)) ==
-		    (_PAGE_WRITE | _PAGE_DIRTY)) {
+		if ((pte_val(old_pte) &
+		     (_PAGE_WRITE | _PAGE_DIRTY | _PAGE_ACCESSED)) ==
+		    (_PAGE_WRITE | _PAGE_DIRTY | _PAGE_ACCESSED)) {
 			new_pte = old_pte;
 			ret = true;
 			break;
 		}
 
-		new_pte = pte_mkdirty(pte_mkwrite_novma(old_pte));
+		new_pte = pte_mkyoung(pte_mkdirty(pte_mkwrite_novma(old_pte)));
 
 		if (kvm_riscv_gstage_try_update_pte(&gstage, ptep_level, gpa,
 						    ptep, old_pte, new_pte)) {
-- 
2.52.0

