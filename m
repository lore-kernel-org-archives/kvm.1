Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F4A3290B0;
	Tue, 11 Aug 2026 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786428174; cv=none; b=Fv8Ib92DQpSwsWjR8foxYbqrW7Y87CelF0TmYiRjsr4MILacXqCtgUVAWKny41jRMbYhs+4quMWUMf3MIB2LHCeVJ8WNtPZ1PESWxuhtowLtHAYNfrnTD+UflmJMlQU8D9aAuUT8XHFocdcI1PiPkvywFpxc+oUdsZzrCFlXiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786428174; c=relaxed/simple;
	bh=wwIC3eX7Fml2Q+kjJARL44tlkprsNjlDDjhJKw7k/rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq0T1To2XEG0IqrWUeDQreK+tb7LpRL6i+/da8WB4pw+ZRoyTGdfsot8loCaqobQFvydmaLvjcB101QZ7qUKSqNvTqvadsfwJmesm2cOW0+Ad6EDt/zDXb5jEx7CKI6BoirUrYRhn4TqnBV46gGA3NkxMdzIxIfyBefsCRk6+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pltt4ir9; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pltt4ir9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786428170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUZulxlEFenT7RvZakt+p4GE/qxIk5ggsq3u1CDIY8o=;
	b=pltt4ir9SgvTNXLl3RctP7iMfp9rqSS4CsqaZtRka/0EOFVWPuoI2fzM9gEMBH6tQS8k1u
	O8eQxdOau6l3dPoYFv8qOcQZhnSuZ1Jz8FJwZ2GCKsrNWJuJZcJM8tFvPVfZBKwPOoiA45
	1LA85MbcZIBFjtxHbTScXVrvOeb8Cbw=
From: Jinyu Tang <jinyu.tang@linux.dev>
To: Anup Patel <anup@brainfault.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>,
	Jinyu Tang <jinyu.tang@linux.dev>
Subject: [PATCH 1/3] KVM: riscv: Implement KVM_PRE_FAULT_MEMORY
Date: Tue, 11 Aug 2026 14:01:32 +0800
Message-ID: <20260811060134.106973-2-jinyu.tang@linux.dev>
In-Reply-To: <20260811060134.106973-1-jinyu.tang@linux.dev>
References: <20260811060134.106973-1-jinyu.tang@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The generic KVM_PRE_FAULT_MEMORY ioctl lets userspace populate KVM page
tables before running a vCPU over a GPA range. x86 already supports the
ioctl, but RISC-V does not expose the capability and has no arch hook.

Add the RISC-V arch hook and reuse the existing G-stage fault mapping
path with a read access. Report progress using the G-stage mapping
returned by the map path, so the ioctl can advance by the actual leaf
size that covers the requested GPA.

Unlike x86, RISC-V's G-stage fault path does not return a detailed
result such as RET_PF_FIXED or RET_PF_RETRY. Treat a successful call
that does not return a visible G-stage mapping as no progress, instead
of reporting that a page was prefaulted.

Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>
---
 arch/riscv/kvm/Kconfig  |  1 +
 arch/riscv/kvm/gstage.c |  3 +++
 arch/riscv/kvm/mmu.c    | 33 +++++++++++++++++++++++++++++++++
 arch/riscv/kvm/vm.c     |  1 +
 4 files changed, 38 insertions(+)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index ec2cee0a39e0..8ac209e8ac87 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -28,6 +28,7 @@ config KVM
 	select KVM_COMMON
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
+	select KVM_GENERIC_PRE_FAULT_MEMORY
 	select KVM_MMIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select SCHED_INFO
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index e5002cb9cbef..6bd8b8fd6ceb 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -280,6 +280,9 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 						    out_map->level, true);
 		} else if (ALIGN_DOWN(PFN_PHYS(pte_pfn(ptep_get(ptep))), page_size) == hpa) {
 			kvm_riscv_gstage_update_pte_prot(gstage, ptep_level, gpa, ptep, prot);
+			out_map->addr = ALIGN_DOWN(gpa, page_size);
+			out_map->level = ptep_level;
+			out_map->pte = ptep_get(ptep);
 			return 0;
 		}
 	}
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 6035b5ec9503..c96e21740c91 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -748,6 +748,39 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	return ret;
 }
 
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				    struct kvm_pre_fault_memory *range)
+{
+	struct kvm_gstage_mapping out_map = { 0 };
+	struct kvm_memory_slot *memslot;
+	unsigned long map_size;
+	unsigned long hva;
+	gpa_t end;
+	gfn_t gfn;
+	int ret;
+
+	gfn = gpa_to_gfn(range->gpa);
+	memslot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
+	if (!memslot)
+		return -ENOENT;
+
+	hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
+	if (kvm_is_error_hva(hva))
+		return -ENOENT;
+
+	ret = kvm_riscv_mmu_map(vcpu, memslot, range->gpa, hva, false, &out_map);
+	if (ret)
+		return ret;
+
+	if (!pte_val(out_map.pte))
+		return -EAGAIN;
+
+	map_size = PAGE_SIZE << (out_map.level * kvm_riscv_gstage_index_bits);
+	end = ALIGN_DOWN(range->gpa, map_size) + map_size;
+
+	return min_t(u64, range->size, end - range->gpa);
+}
+
 int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
 {
 	struct page *pgd_page;
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index a9f083feeb76..58500a19b33b 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -187,6 +187,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MP_STATE:
 	case KVM_CAP_IMMEDIATE_EXIT:
 	case KVM_CAP_SET_GUEST_DEBUG:
+	case KVM_CAP_PRE_FAULT_MEMORY:
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
-- 
2.43.0

