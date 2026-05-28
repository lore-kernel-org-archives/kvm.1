Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A563E51C3
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968339; cv=none; b=gNA63Vp9iVm/tYp26NecDY8ssO+/O2ZS4vr/cMeBPiyzqLv23LILGr16OzLqyUFGFRKT1JAlHV2r+oPZUu40HTnQbn/Hsc/BWwM4TF4hxMVKAmN//sGDFXGj8qeqdIRJyxtQDo3o1kfp0nLoS9a35dMhzSKurQHiYlQzmttawSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968339; c=relaxed/simple;
	bh=R+idNd6VQHryMkE7s+xh+chHq0O9Dd0htuOKJxMUPRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4DTXFWrdsXvhGkH7HHb36oyQYBH2yPWeiCRyAmlSqqGTrCbskWcegL8/TBIig5jd6mL3dFaS5OpEq4vs3YC1tbkdF7hI8XRh7pQb0Ecll1wZT0oN9Z38L6WQ0JduzoOtrCFr9GiLPEht4oNZs9gbJywNHZqaBMOGlXwIuMvCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meWzqMFl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meWzqMFl"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b4650d5f5cso53561255ad.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779968334; x=1780573134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQOVqn7f6Wpqd2/fSU+ahSddV1Hbd7ryZ20yjrjfDWg=;
        b=meWzqMFl3d8z49Vt2+bTgy2xVVVq+gyz3ZObwOqZHrh3IkyRIgDdRNjdlCLk2lVX9B
         iHmm80AKtAeEbgzCkEiBukayly8CgFJ9m87W1uTL/RiCLM9dq20izt57mAeWFki9KpHR
         MQF1SEOoxlWbKqCGxtkdTMe31it1Md5H+HY4jImgpoW9gSMWRkG8AVKDUvnFraqwyM+4
         iVZLB3xilqeXy3KnAEeHuAsENuwYaTASkojDrbgqT6XZVcs+MDAUnjL+E4/W94QDRZEJ
         fxi3JDVN7kj7+CcMYmTOlh/w48ELzNmOlE+slw76ZG06CWjEEUqzj+JOsbr3Ca1C1I7n
         g3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779968334; x=1780573134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQOVqn7f6Wpqd2/fSU+ahSddV1Hbd7ryZ20yjrjfDWg=;
        b=cLkcpV16MOYYQsDO27ivgDDJZfghHjNWe6poZRcQQlQ94oOtEHw5yMxt7y7EGbQHJR
         GuGxZiW7ZrJEpvnr5inpAzq5JS18n1IViybSL/h/Yxs2Os+8Kmqj8yX9/PfqQaECXp34
         qcjQa4/cgOzodS2UQZ0eIFICHXbhNy209fcA4KON3OyVZY7BlcPNhu+lbFEMTQ79SloP
         /kRIcIaRJ37HPIkLe66wqofBR4HbLC/RKbC7eBTBmgpz0CVrUHOt5KRPh6jIlzN3gfIP
         H/xFjAW7aDIKAdjdmBr8uFxIt1tlMsaiQJxu5H31v668eh8h39XvyjobYs9JoOKyQlnJ
         7aZg==
X-Forwarded-Encrypted: i=1; AFNElJ9BtGgS0DyD1du/sMa7E7mxXU6+4gMpsNZcpDCQHV6jsKXEZp8TQuxXBRQRMois/CNZuos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuVfBOMNCA3RxGAIMW0J6AoyJmqyNPHRRLdA3xYH0eO9UGxwEd
	9iKprg9ebDZbR2LCrTPGVI6FRb7T6s4ztJ8KBdhd+mAVGTNZBruRPsqG
X-Gm-Gg: Acq92OGrIdl1+W7ddcacrJlQDDb4AAUkfpmhF4i7j1L2oK68nlmykOKm3zleGpnbj75
	xY9c/g4mRuumY9Eb1LkzhFaOEkxjt1QEBYE0RcpYcKhvlsRVS2yOb/hSWz1Xe6YzcsV0ZMlPB9j
	HnJ8Fu12MpfJZrGSDamGY/fRvvs62gmJK3dWHW1BS6tg3Za8GdXrL/3Ox0TBePy6pgcRSVqJ6zN
	wnokON259JnUd4vIiXnD3AvfXo83EHUhNU6BHm5nmLqVi9TQzxf3e0D/19y4bBilWYb3GGlWDrF
	nbnCJKfMLEvLdGiMPirSlI1PXdZWo3rQFTy3VuKcR5jZfdH3LDhwBsdj0xo1fDhLzQdyJmCddOf
	ZeW+BmlSsQBKXW4Ysdw4+q5cHE22QwT/9C9NXCTaqqxAej/ELA7dUtB8EDd6vmTmgeBP0ILKJh3
	InnySCobPF0TRLeOfIAweVtdNEtfZ1F+mtiQ==
X-Received: by 2002:a17:902:cec7:b0:2b2:ccfb:8387 with SMTP id d9443c01a7336-2beb0613c3bmr312598815ad.28.1779968334356;
        Thu, 28 May 2026 04:38:54 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56958d3sm170611355ad.12.2026.05.28.04.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:38:53 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] RISC-V: KVM: Enhance the logging check for mmu mapping
Date: Thu, 28 May 2026 19:38:39 +0800
Message-ID: <20260528113840.2629186-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enabling dirty ring, the dirty bitmap is disable, and the logging
check is always false as the RISC-V architecture does not select
"NEED_KVM_DIRTY_RING_WITH_BITMAP". Although the dirty log is recorded
since the write path already trying to add the dirty log, the logic for
logging check is broken and some side effect will occurs.

Enhance the logging check for mmu mapping so it can check both the dirty
ring and the dirty bitmap.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/kvm/mmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2d3def024270..b5873bca9dce 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -142,9 +142,8 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				enum kvm_mr_change change)
 {
 	/*
-	 * At this point memslot has been committed and there is an
-	 * allocated dirty_bitmap[], dirty pages will be tracked while
-	 * the memory slot is write protected.
+	 * At this point memslot has been committed and dirty pages will be
+	 * tracked while the memory slot is write protected.
 	 */
 	if (change != KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
 		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
@@ -433,8 +432,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	struct vm_area_struct *vma;
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_memory_cache *pcache = &vcpu->arch.mmu_page_cache;
-	bool logging = (memslot->dirty_bitmap &&
-			!(memslot->flags & KVM_MEM_READONLY)) ? true : false;
+	bool logging = kvm_slot_dirty_track_enabled(memslot) &&
+		       !(memslot->flags & KVM_MEM_READONLY);
 	unsigned long vma_pagesize, mmu_seq;
 	struct kvm_gstage gstage;
 	struct page *page;
-- 
2.54.0

