Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554F3E835F
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630201; cv=none; b=KTKRHRF+5HN1ig3JeEAY0dhYXxm+OHJETf6wDmEb6vBZ+hANRwSmaWvI/DowsV8FY947/7isPOFtjhc6oA0jBCzuXhrV7ga06Eq/72WF7x7pYCZA7CGP3Bm4P5I49U5gyLXYf0UUsbiZP78sYYER5AtPHrIoJ89JByBSiKPbPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630201; c=relaxed/simple;
	bh=WaZJ7P0SHOolS0ZYzuBxtL7zgUXLJrMDeC09btwdKto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cpcvAYhbb/BN/7+gTDG56t0ntXS99c86JfD4kk632whKsskvGtbt6WH/M19UsBblZfUfJ4BklEIhA5LSfIXiBEUPbqxbcUAlGpnj2mGM5dFZRx2ubkRBXDGx6dvBGrCj8W6eZ6MzZ0RAYLiHAKMBNPWtgCxV0UqiIplWcHnDCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uDJt+mmS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uDJt+mmS"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so3536265ad.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630200; x=1784235000; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bdJmrm0DM0tqLrnWsA7Ix9+cw5cKAYmoXa3Fe29H+DM=;
        b=uDJt+mmSM5HU0/5Y+SxlYISeRwBIJdg+joYkrbD5rfgTNrSLavwjr4Fu5X/eQsSLqM
         VMlJbXtL0swcKgke/5TqEtZofjwZGde+jkPHWQlP6yxf90pgN1U/UdlBPnV/9IzDqe5G
         6V1avxU8NetLioylrQRWWHabPyLEpqqKHClSANwqYX20T7+UAJbX/SJHokMCH1bEFW7v
         8BnsmdaS9shYsRMxK1aXfjhiHGN8VgO91H2Aud3/f6azh8d5NIAzvIO89gpr+riRoP/y
         caRJmjC2pcYjMA1TmaXNGc7pIE9QyktuQWXAKUpNiTRZSCACgV+stYb7tJNi8iNpX/57
         hdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630200; x=1784235000;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bdJmrm0DM0tqLrnWsA7Ix9+cw5cKAYmoXa3Fe29H+DM=;
        b=Eqm8ngTYMGr2je+s3t1AjJQz939eIcQ6w8Q3fAHmMmPipsahi+LJ+FvgRsCQIcptSh
         BPWh79g15GtY/RdPJuNNbo/Dj0R/NN8KGOOG/V7/fwDt/IV/SAxu8fUR4EBDnFKszIA+
         eBIo7Gqa90c/xgRo8PLqSo1V+suBt/Ku8VfsSqwZYW+vzjwFfnA+F8eSFey/OlUT83Dg
         i8aS3B8/WhT5st1Sxg5K8oqKr2c2zdg3GZQuQhtFuveqie2Rigjn6BWuN61hi7ZvoT+N
         z8koTi/PVOy+E8STjphOpe4j+i2OyBBr3tWi0L1grcwbI1Kafk6ln/YMU8urEE65hz4S
         lohg==
X-Gm-Message-State: AOJu0YwEQJgOfUG53QQoWVH2veg8gfAotZRHJAQAuzzaDPOxvZZbFe8E
	9oDY5daiglAZvscHhGN0u2xIqnkbEYpP6HAl6vpi00ohcxE3QHsQi/aE8O2pSyZzBuebUh2FyNr
	jL8gBVw==
X-Received: from plps17.prod.google.com ([2002:a17:902:9891:b0:2cc:2c68:b71b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b48:b0:2c2:be43:39bc
 with SMTP id d9443c01a7336-2ccea42ee1cmr85833005ad.22.1783630199534; Thu, 09
 Jul 2026 13:49:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:38 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-9-seanjc@google.com>
Subject: [PATCH v4 08/18] KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into
 "front" and "back" halves
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Split kvm_mmu_zap_all_fast() into a "front half" and a "back half", where
the front half is everything that runs with mmu_lock held for write, and
the back half is the code that runs outside of mmu_lock.  This will allow
putting more code inside kvm_arch_flush_shadow_memslot()'s critical section
without having to take mmu_lock twice in quick succession.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 223d80b12b9b..a5c2a560a88a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6921,20 +6921,11 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 	kvm_mmu_commit_zap_page(kvm, &invalid_list);
 }
 
-/*
- * Fast invalidate all shadow pages and use lock-break technique
- * to zap obsolete pages.
- *
- * It's required when memslot is being deleted or VM is being
- * destroyed, in these cases, we should ensure that KVM MMU does
- * not use any resource of the being-deleted slot or all slots
- * after calling the function.
- */
-static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+static void __kvm_mmu_zap_all_fast_front_half(struct kvm *kvm)
 {
 	lockdep_assert_held(&kvm->slots_lock);
+	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	write_lock(&kvm->mmu_lock);
 	trace_kvm_mmu_zap_all_fast(kvm);
 
 	/*
@@ -6971,8 +6962,12 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS);
 
 	kvm_zap_obsolete_pages(kvm);
+}
 
-	write_unlock(&kvm->mmu_lock);
+static void __kvm_mmu_zap_all_fast_back_half(struct kvm *kvm)
+{
+	lockdep_assert_held(&kvm->slots_lock);
+	lockdep_assert_not_held(&kvm->mmu_lock);
 
 	/*
 	 * Zap the invalidated TDP MMU roots, all SPTEs must be dropped before
@@ -6986,6 +6981,24 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 		kvm_tdp_mmu_zap_invalidated_roots(kvm, true);
 }
 
+/*
+ * Fast invalidate all shadow pages and use lock-break technique
+ * to zap obsolete pages.
+ *
+ * It's required when memslot is being deleted or VM is being
+ * destroyed, in these cases, we should ensure that KVM MMU does
+ * not use any resource of the being-deleted slot or all slots
+ * after calling the function.
+ */
+static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+{
+	write_lock(&kvm->mmu_lock);
+	__kvm_mmu_zap_all_fast_front_half(kvm);
+	write_unlock(&kvm->mmu_lock);
+
+	__kvm_mmu_zap_all_fast_back_half(kvm);
+}
+
 int kvm_mmu_init_vm(struct kvm *kvm)
 {
 	int r, i;
-- 
2.55.0.795.g602f6c329a-goog

