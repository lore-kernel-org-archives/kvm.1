Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE13D3CF0
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311572; cv=none; b=U3NbLSCMSYWY14CpVfBeMpNqqPaRKRLBVnpmRV2LLnfLBt8hfxx9kmpu3laPD9/AQ69opW50mTZ1+KlIg9WsPRVciVfWYdnxzewOSVgOSw/hSug76WHkEgETOsu8FS+z7j9vh0/FN4CrTwj87aa3Nsy3LDSJvcpldroADgJVenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311572; c=relaxed/simple;
	bh=0RyNL+d2u/8qwasZjrr/jkYtIiYWq7qAhWxhy72Q1r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2DZtSOKHGslV/+xqg9Xcv0VSFZSLNdN5Rt8zrfXBEUOkWzU/az11jScXWlztAQeK4SgW8rA3SvySu6YV1p2qibjKLgEdVauxzOOVZVIla3UhwCfGn8C15HpUJkM84dC2D5+a8vt5iP0ebqYd1ssLDKsqvB275B4rvrP8tKYrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVFjAxve; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVFjAxve"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38f0f8ab050so527459a91.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785311571; x=1785916371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+S7Jp8AiRPMxLwArOeWjXj5fI/6HZ3Xr4zn06sU+Ak=;
        b=JVFjAxveBp6dABTFparZhMY8bi6GnYQ9mr4/RWNYZtw6gOKnzowtPmshkI75GKnulu
         uhkrD9T0P39jTIWfP0d4oZeBtCRh9vHVgbRaogWYDN5pvDfEedOIPZGff7lsWAoLYe3I
         YpEUpMDMO/Qls0V4+RadMLlkdZF3kkfd0Yd/bS2HG+yQeVmedfGQocKkRSfJh2aYYbrO
         i1eAjgq76CQ3+kkBMO2VgZskKcf3EgjTjTCy3tYZXAtOynZ5u5kRFQU49vnXo70eYAmT
         W0DtS2OGHhiIQ5KoiS+ZPlP/2Jbmgb4WdtYZsXJ08HhiTK2OPhCMgeoHZ+ngZtLn3DNn
         uAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311571; x=1785916371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+S7Jp8AiRPMxLwArOeWjXj5fI/6HZ3Xr4zn06sU+Ak=;
        b=jHBfx3IxoXsLtmiIYGtaM53hw+YkSCxzqfYEabjtWMBG0h4h/9l7w/C7rkSZbmAhWI
         x3OW16Kxox0Oi0mJTXCbtss435P4l1HLb0NBOb/MvDX6nKWYOtLPDMNUXkRYGLTTNHjA
         P/RFj04s/0U6iTludwm80gxoVACETU31HYpLPDUsMKS1w1X5nBodO0PAVnL5si8+KSFS
         7v1ENlhtSamnX3wWS87ZxIbrLGCpRNj8PfAcz+6ZWJYh0xwDJ+xN2qm94T/ogKS8Viol
         hZZW0cXAzSxgR7bNfv15ElQWhaR6vgEHHvbVZxXtMLQOcC3MHvEmrjKM/HRjltN5sUiL
         ZGEA==
X-Forwarded-Encrypted: i=1; AHgh+RrC8nByw+kpiqFPWk1kORA+HIN+5FC/dIfA19RC6Hi2YkHq2FRuOxBMjT9tkUYTEVzIaUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5I99QMb2tOJAyIDOvK1OelnXPcqIf51y2uVxs4Z2WmvSUxcJ+
	UOQXPwuToX2i0vej5gXKKLS3RkJFS0GR4tWGpBUm/9ycl3kYSoCTOOoR
X-Gm-Gg: AR+sD115LK59CurybwHSDKNojuoH8TGaZD5bhBDKbi29QXuNBDS4LRTFYNLwPBRXXHv
	CYViPCUJWNbKfW2SnOGInXZ9l+LlnWP4HzWkp3NbVuESmXD/OUf8RLcDMauoJ120yeZtfdSBPZx
	soQ43fnWfhMAupJHKjmRLDRqeUTVw7HAKRyL7PMIabRlv1F9hUjT0/FqwKAwjjJjpvG5ob03DIx
	QZ1/h6G1cLpzoYZoUlYW6H1Kl2R6iaGPOCF6VHsmDzCfOfLQmrEiGxBiOFrVtUcTyp7MRUzoNLu
	AzcNX8leJBldWYFKXwLY+6Q6igd4MQkZ/h1GkUPgVy5nHa2lSXI51fr4p27vHmRbujiCo2Ott9d
	w3t7TEnYPXeSdzmWVHtZPNdyG3n/aJkB+kGQDwtiW+6Rxi+CZ/UskZbimFfb9X6ICFUrvvnrh1X
	watKVfd24EKsReEnRsnmdrqaongy3+PH42B5xXzAT6DNz2PLlwHjsiIJjAxotCNkACoSn3wJ1/5
	FU=
X-Received: by 2002:a17:90a:d888:b0:38d:f096:a1dc with SMTP id 98e67ed59e1d1-38f6a40bd71mr5502911a91.11.1785311570796;
        Wed, 29 Jul 2026 00:52:50 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f0edd51sm960739a91.2.2026.07.29.00.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:52:50 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Bingyu Xian <shanbeeyoo@gmail.com>
Subject: [PATCH v2] RISC-V: KVM: Fix spurious -EEXIST and clean up gstage fault path types
Date: Wed, 29 Jul 2026 15:52:30 +0800
Message-ID: <20260729075230.743030-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729070749.730218-1-shanbeeyoo@gmail.com>
References: <20260729070749.730218-1-shanbeeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small fixes to the RISC-V G-stage page fault path, both suggested
during review of the in-progress KVM Userfault port.

1. Treat -EEXIST from kvm_riscv_gstage_map_page() as a quiet success.

   When a concurrent vCPU installs the same G-stage mapping while we
   are waiting for mmu_lock, gstage_map_page() returns -EEXIST.  This
   is not an error -- the page is correctly mapped and the faulting
   vCPU can simply retry the guest instruction -- but KVM was treating
   it as one: printing "Failed to map in G-stage" to dmesg and
   propagating -EEXIST all the way to userspace.

   Align RISC-V with x86 and arm64, which already swallow -EEXIST in
   their respective fault handlers.  This also lets
   kvm_release_faultin_page() drop its "ret && ret != -EEXIST" special
   case: with ret normalized to 0 the regular release path is correct.

2. Clean up fault path types.

   - vma_pageshift: short -> unsigned int.  Bit widths and shift counts
     conventionally use unsigned int in the kernel.

   - fault_addr: unsigned long -> gpa_t.  RV32 with Sv32x4 has 34-bit
     guest physical addresses.  fault_addr is widened to gpa_t (u64) to
     hold the full address, and the shift reconstructing it,
     (trap->htval << 2), is cast to gpa_t before the shift: htval is
     unsigned long, so on RV32 the shift would otherwise be evaluated in
     32-bit arithmetic and drop bits 32/33 before the result is widened.
     No functional change on RV64.

   These type changes are in preparation for sharing a common
   struct kvm_page_fault across architectures, as requested during
   review.

No functional change on RV64 beyond silencing the spurious -EEXIST.

These are independent fixes with no dependencies; they can be merged
on their own.  The KVM_MEM_USERFAULT port that motivated them will be
sent separately as an RFC once the generic userfault series lands.

Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
---
Changes since v1:
- Cast trap->htval to gpa_t before the <<2 shift so the 34-bit guest
  physical address is not truncated by 32-bit arithmetic on RV32.  v1
  only widened the destination (fault_addr -> gpa_t); the shift itself
  still dropped bits 32/33 before the result was widened.

 arch/riscv/kvm/mmu.c       | 8 +++++---
 arch/riscv/kvm/vcpu_exit.c | 5 +++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 8a0aa5e0e216..d2a06a54be17 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -541,7 +541,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	kvm_pfn_t hfn;
 	bool is_hugetlb;
 	bool writable;
-	short vma_pageshift;
+	unsigned int vma_pageshift;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
 	struct kvm *kvm = vcpu->kvm;
@@ -652,11 +652,13 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 						vma_pagesize, true, true, out_map);
 	}
 
-	if (ret)
+	if (ret == -EEXIST)
+		ret = 0;
+	else if (ret)
 		kvm_err("Failed to map in G-stage\n");
 
 out_unlock:
-	kvm_release_faultin_page(kvm, page, ret && ret != -EEXIST, writable);
+	kvm_release_faultin_page(kvm, page, ret, writable);
 	write_unlock(&kvm->mmu_lock);
 	return ret;
 }
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 6c8530b9f29e..28cf9b27bb07 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -17,12 +17,13 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 {
 	struct kvm_gstage_mapping host_map;
 	struct kvm_memory_slot *memslot;
-	unsigned long hva, fault_addr;
+	unsigned long hva;
+	gpa_t fault_addr;
 	bool writable;
 	gfn_t gfn;
 	int ret;
 
-	fault_addr = (trap->htval << 2) | (trap->stval & 0x3);
+	fault_addr = ((gpa_t)trap->htval << 2) | (trap->stval & 0x3);
 	gfn = fault_addr >> PAGE_SHIFT;
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
 	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
-- 
2.54.0

