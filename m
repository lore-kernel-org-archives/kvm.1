Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C793B995B
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785308878; cv=none; b=iICQ5PHPB/2QZ++/IOsV8Wkoeys+e7m180LLPAbMica161xwmm/T2bLukGt48SQpJM4pTHyBOg9UToemTSSIoD03e4ZLzj4iZT4QWly/oJAnXCOuZv0scfl09QyZPmn1FleksWNfx+Gqk6nQNJO9GcYSpoWZe8dscQysbEyqbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785308878; c=relaxed/simple;
	bh=uxkXFNWNZi5D34tDH/Krd7LciHBRYBtcyiQYP/YDYjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJQx9TGYccIVcrVog0o2TXQ9pOr2Y18nJNdksSccMREUGarHq5Lo9hTx4at911BJVS05FQLZoG2w89104Q/YUf3nW7cfPA/9+yR2/sVXWqQ/2bE81/WVW+83Ov6BVZqXhG/XtaSlRjbrScEyvFLL1u14bJqhhDogRNOiHNgw+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqeoQe//; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqeoQe//"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cab1b0bb489so459493a12.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 00:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785308876; x=1785913676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D50VgXdohjCe0RlJun/XbYhvNc02+cTyZmQgaJjzY0o=;
        b=MqeoQe//lTtdct+e3KLoiBKgA6gPKkcLv0VE+wiBqVxK0pbZYRr1jS5Vz1P6RvGqX3
         7nlvGw6n34zoC6fmk4dS2RqhofaHuHv0j1hpfZTW+oOQzAuVeF4ZPhKYlX/2T8Y8hdWM
         zecJremX+hxC9fTNPQGhqZ1XJJ9HlpUSZvyXx/PbXmf//ABONZc37N3PuF/Ny90LPwka
         kQXBIrjEg3JL8/cZph0gHYhOlwYXIEjWDwXc4oTQbFLE1Ascr9ZLvNL+kQ0S12S6i9xA
         wSOLoswgKZAn+t/fNaeykcSj3wZvGnOPv3fc/T671JOpZDU59dKt7HeSxpulNX6DX6fF
         JmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785308876; x=1785913676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D50VgXdohjCe0RlJun/XbYhvNc02+cTyZmQgaJjzY0o=;
        b=Ern+1sS0xvf/1QOOp74wvRRPfS1kCTZ00cpVegkmiJzeo9eiNPn/5MUnOyPAw9ceYv
         eLEchDU4PXX6UNQmtmuBxvJREMblcyIwQundSQUJPSC35RWsM8cDnLD8CHQWzs9Ic44K
         ZAzUmXQjCqYZieaaxml2cChTYVpHVWa4wAAQ6raP1pOd/f/s1DktdSq3CfTgvXHPJZlM
         q6gjhumPj5k0rl7AAWcF+Xkjgk28pncsb2YAoEtFaDvPWST6E69eyYRcqRQ9nCx3HqL5
         jyvYnmi/CR2qY5eO8Hq33JwCWd08wVV8mPURzu6b6vUdVnm/AeIqQbsZz/OdiiwSSSrG
         On/w==
X-Forwarded-Encrypted: i=1; AHgh+Rr6poWp3dkeMPny2RBoDquGgwuQJjWvSurjRCoVoPw9QeNcVHKP3Yg8cF56cOOwUU5wry8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKHFwLRPwS9x9Ph7Y+hCKXbVQQxVtA96qQwDY07DDfN9EQOj/J
	YKKxSgnQ+EtJDfmwloHJNT+9dLiZDgv9K51GhegwZyuE/qbTur4HPYTd
X-Gm-Gg: AR+sD10K5PJaPtQX2jYev/UUFg0nrZDBw5lpv9+GnX78ECiSfWBaj9WsIrMQ0CwBqOG
	jIIRxHEh9HwjtxTOPjV76A8ihKkw7a9LS8AW8JUaewqXG6YPl4InSpFFUruMOvY4/B0VV6vrOEm
	rR8/ffNYCwwmxguGF6GdLuD3J6QQemwi/N4ziFdldY9xtbLn3QEuZ6YKFz+S9/mJZQ+sWce5gB2
	0vykC+0dt1cosypTPhXvAPFSHi2m5jevHvx7BtOuzg3z6KDGXN4m0oVJ2pB82gur623QhAyTFAj
	myhHVGOfGcqSGuFtVVWAP331VtWwsQZlWufPuVwDFzH3QYp1FpXU/pnfhSXep2GpQ2BSdFiCGQj
	U1H0aMSseyHmm9S9UUPosqFLzxdNJ1QV40ADd/pvjHO3OhqXvyi+eZMauTgMZwt/Gnvlasx1bKZ
	mjvY2pT1/4oH0r32RYvAy7ewcTqrEZdg+iONz58LQd8oG+94rpJLqh2SF853cczDDFBYEc3we0c
	M8Mj/5MsXlddrBv5372WL/jQw==
X-Received: by 2002:a05:6a00:cc6:b0:848:467d:293b with SMTP id d2e1a72fcca58-84e931b505dmr5656775b3a.11.1785308876062;
        Wed, 29 Jul 2026 00:07:56 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03d3182sm890181b3a.54.2026.07.29.00.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:07:55 -0700 (PDT)
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
Subject: [PATCH] RISC-V: KVM: Fix spurious -EEXIST and clean up gstage fault path types
Date: Wed, 29 Jul 2026 15:07:49 +0800
Message-ID: <20260729070749.730218-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
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
     guest physical addresses that would be truncated when stored in a
     32-bit unsigned long; gpa_t is u64 on RV32 and holds the full
     address.  No functional change on RV64.

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
 arch/riscv/kvm/mmu.c       | 8 +++++---
 arch/riscv/kvm/vcpu_exit.c | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

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
index 6c8530b9f29e..76cceecee5ab 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -17,7 +17,8 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 {
 	struct kvm_gstage_mapping host_map;
 	struct kvm_memory_slot *memslot;
-	unsigned long hva, fault_addr;
+	unsigned long hva;
+	gpa_t fault_addr;
 	bool writable;
 	gfn_t gfn;
 	int ret;
-- 
2.54.0

