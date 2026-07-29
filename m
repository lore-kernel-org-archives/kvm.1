Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83637BE84
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785308931; cv=none; b=Gzd+3azgy51YDySAxiyCuRLDDverMjmC+ot6MvH6Xpth5Ooxqz60EUfVYigTdSC94MzN+TaPiB8JGOawLogwuECO0b+RS6s4KAsYwudAuCTANNTOFTmTR0i4vscwLouHcejyqlMBBz2YfVIvuw9U4YrGKfLz7026XWSYankyy+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785308931; c=relaxed/simple;
	bh=TxfbZ5d8J7BDtj84nnJrE1wjtj8GQEMHhQxRQDTjqsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDrOqMFwPI4qyK+/pCt5QJGMg1fnr1+ukcJRfSUdG7PNH5iG6+/6UfcJW4Xbxv6owD3vjz70rcq5N/y3zg6AEI8Uh7/Acf5Sa4Jb8VfXtnSmsN1mZu/s0B2PteSxh0QHmiEqDyAt0xoPiIXyjerPACKs1nIBEAiGUz1KWlyrc6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idPklV57; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idPklV57"
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2ceb5a39c48so2223435ad.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 00:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785308929; x=1785913729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zVkfFwU99PAS9bFh1/EwhXDgeOkNzrTt6+RDhpCA128=;
        b=idPklV57uk+Ol/+JKm0/YQCNHr7R0edRoqnJoPG1JH9DwtmYUaAjHWGLdx6tKBWDSQ
         7CAQexVbFjzHPsMPR3CGp+rkvEzsLlZ1GvGszxCkmOF+10/erkz4fZHNZgXYFRI2O1nv
         AvZtMMNOozo5GRVfzc6Qcyblvv4FK6LY4fUIVjJayrRnzvxJt27/W9xqOX/rug8YLXJV
         zHIb3fibvox08W2rsHM/9ay6ViZaYjBFQxp1LCeGSIzsh0zNUl/EVJngn+wazeGPlPSJ
         cm4yHrg46jmku5ycti1TSvHK++ICyLYEg7ltR25AEABw2HbIvIB78LnHaTQ6R/LTpMHL
         1Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785308929; x=1785913729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zVkfFwU99PAS9bFh1/EwhXDgeOkNzrTt6+RDhpCA128=;
        b=suJP+v7cuH4AjAfyR8rghJq4dugMFRt4B8U6k1VxvisRYl7IGq4eG9CRIcuL1I6zvb
         WP8XKRZZlXgThyR27eOokv0JML0qJgkuCIDH9eUjneFuQEYKwtFlrZqSJTZy1U/NQF7d
         pWuSIN4jApD3Cilokq1Hof77Nh7y5yY2ThocCUvyMaF9sTdxUXxpRLlHxiBtWEHtIU+1
         DKXKd9musRQDciDDfkYAWRzK7749BmBLhRbzQURkfJ9+v5T7fyD59ViXhkRtKNJKJ4K1
         hv3+U8Z7b0iLmQJir4XZ35ZbNQelv2iabCHZwntvPYhHhPndJ1LoFs0FYqBjx/EMp3hi
         u8kQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIWz/jGdEywJz0aPOzejaiDaiOYcBQs6r/fhn8ECR2nIGAOx6tYxNAF84sS6/YphCAgps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJV/Vkrze8MzC+eM2C6j/7k5L4TPLziDnJ7Dtod0btq9WQe0N
	QRe+8veTgXdQriOHh8f0jV9ziJr+zjjeG42YSj1oxuGzr65ROlqNKiZl
X-Gm-Gg: AR+sD13db1kHdEk/NM+wbCWtHfYljj7qY2/rM85ocEjq2J6cm3ARhDcdxFNMqpTvAJS
	YYHq14tZfGmRP+BFN3paV91SYG2rNRaGtKsyMY1MG3lEmCnIvcGK1DrPZBvG1hC7BtZBqxNJrkd
	UI63vehKxILHn9C4p8pnxPkzUrLY6DJW/ZcG6evTRbvdX2nf+lhTIRLULjgEu6fsqcEdPjOHA5H
	ZP2Wn6k7GiTjMA0fpDLIlEnRaEUmUNX3sFEXOWOg03IL3hQCmisT5hsBespRyv3FiCxxfKbMLuC
	JDx6urND7ismaB9LELEgzKzwOpBeS4EEtiN9JkTB1/9WoA4b3VKrjfe3dAw9bFlxx3fMNCRaP/t
	eAqDv3crPM7lPA2LhPT1uTSQDgpRivsKhkn4/sk6pRmRkujrGQkkzFzXHEOdtz7QX8+AnNNyUfg
	DQqlDcKYg6GXQFmJTP+EvqK4OECXl0GEpwD0R21b1FU8Jr/dKdJ7H8GoUbOonIjdm00orGyseWh
	Nk=
X-Received: by 2002:a17:903:948:b0:2cf:ca89:499d with SMTP id d9443c01a7336-2d015abe469mr65912835ad.7.1785308929138;
        Wed, 29 Jul 2026 00:08:49 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a15215sm6786125ad.8.2026.07.29.00.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:08:48 -0700 (PDT)
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
	James Houghton <jthoughton@google.com>,
	Bingyu Xian <shanbeeyoo@gmail.com>
Subject: [RFC PATCH] RISC-V: KVM: Enable KVM_MEM_USERFAULT support
Date: Wed, 29 Jul 2026 15:08:43 +0800
Message-ID: <20260729070843.730578-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for KVM_MEM_USERFAULT on RISC-V, which allows userspace
VMMs (e.g. QEMU) to handle post-copy live migration via userfaultfd.

The implementation follows the same pattern as x86 and arm64:

1. Force PAGE_SIZE mappings when KVM_MEM_USERFAULT is set on a memslot.
   The userfault bitmap is tracked at PAGE_SIZE granularity, so block
   mappings must be disabled to ensure every guest page fault reaches
   the bitmap check in gstage_page_fault().

2. Check the userfault bitmap in gstage_page_fault() before installing
   a G-stage mapping. If the faulting gfn is marked as pending
   userspace resolution, prepare a KVM_EXIT_MEMORY_FAULT exit and
   return 0 instead of proceeding with the mapping.

3. Advertise KVM_CAP_USERFAULT capability to userspace.

The mmu_notifier invalidation flush on userfault enable guarantees that
we never fault on a page that's already mapped, so the bitmap set bits
can be safely checked without holding the mmu_lock during the lookup.

Builds on the gstage fault path type cleanup ("RISC-V: KVM: Fix
spurious -EEXIST and clean up gstage fault path types"), which is sent
separately as an independent fix.

Depends-on: James Houghton's KVM_MEM_USERFAULT generic series
Link: https://lore.kernel.org/kvm/20260618205753.2600064-1-jthoughton@google.com/

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
---
 arch/riscv/kvm/mmu.c       | 6 ++++--
 arch/riscv/kvm/vcpu_exit.c | 7 +++++++
 arch/riscv/kvm/vm.c        | 1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index d2a06a54be17..c33810b71d89 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -583,7 +583,9 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	else
 		vma_pageshift = PAGE_SHIFT;
 	vma_pagesize = 1ULL << vma_pageshift;
-	if (logging || (vma->vm_flags & VM_PFNMAP))
+	bool userfault = !!(memslot->flags & KVM_MEM_USERFAULT);
+
+	if (logging || userfault || (vma->vm_flags & VM_PFNMAP))
 		vma_pagesize = PAGE_SIZE;
 	else if (is_hugetlb)
 		vma_pagesize = hugetlb_mapping_size(memslot, hva, vma_pagesize);
@@ -640,7 +642,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	 * possible. Hugetlb mappings already selected their target size above,
 	 * so do not promote them through the THP helper.
 	 */
-	if (!logging && !is_hugetlb && vma_pagesize == PAGE_SIZE)
+	if (!logging && !userfault && !is_hugetlb && vma_pagesize == PAGE_SIZE)
 		vma_pagesize = transparent_hugepage_adjust(kvm, memslot, hva, &hfn, &gpa);
 
 	if (writable) {
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 76cceecee5ab..0919e1c8a6ad 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -63,6 +63,13 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		};
 	}
 
+	if (kvm_slot_userfault_fault(memslot, gfn)) {
+		kvm_prepare_memory_fault_exit(vcpu, fault_addr, PAGE_SIZE,
+					trap->scause == EXC_STORE_GUEST_PAGE_FAULT,
+					trap->scause == EXC_INST_GUEST_PAGE_FAULT, false);
+		return 0;
+	}
+
 	ret = kvm_riscv_mmu_map(vcpu, memslot, fault_addr, hva,
 				(trap->scause == EXC_STORE_GUEST_PAGE_FAULT) ? true : false,
 				&host_map);
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index a9f083feeb76..1bb3918c70da 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -186,6 +186,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_READONLY_MEM:
 	case KVM_CAP_MP_STATE:
 	case KVM_CAP_IMMEDIATE_EXIT:
+	case KVM_CAP_USERFAULT:
 	case KVM_CAP_SET_GUEST_DEBUG:
 		r = 1;
 		break;
-- 
2.54.0

