Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AE235BDCE;
	Mon, 31 Aug 2026 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170085; cv=none; b=EP6V97uKKB8B8wpuEoU4kiy8zcojLYwM8jTlo07NMKAPONmnXxx0WKs45ikNKJL69lBfg1nX0+JbwgL2wsjedg9Alo09BCb3WhkomcCsqR5dW9GEeytaVCfK760yb+KIRMepBMscpg8gxe3h3ZtjFeOcUlVWGyOW4NYvNmCiLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170085; c=relaxed/simple;
	bh=nfjpZUMOYFDQLVcfDwAxQZxMqqvBDp/2lMAhNMXWNFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r8316sGEXQfG6vyg4346nVn5TItqwgokxAw8OZJZ1C0Tm913LsAEN2amUEXZBgt/FqHOmgAlriFW4iVjMGcoJKnJxy+Q/g98dU898c68y0Zdydh+sVybF9L4hB/dBVXtQ1KAwwu57yWUleiL6VVV5xQWoqRx8rIuSog/8wKlJUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxW_BgT5Vqvt0GAA--.19424S3;
	Mon, 31 Aug 2026 17:54:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxKs5eT5VqDTYYAA--.20453S3;
	Mon, 31 Aug 2026 17:54:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Arnd Bergmann <arnd@arndb.de>,
	Xi Ruoyao <xry111@xry111.site>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] LoongArch: KVM: Add vmid support for stage2 MMU
Date: Mon, 31 Aug 2026 17:47:14 +0800
Message-Id: <20260831094716.4016652-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260831094716.4016652-1-maobibo@loongson.cn>
References: <20260831094716.4016652-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKs5eT5VqDTYYAA--.20453S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

LoongArch KVM hypervisor supports two-level MMU, vpid index is used
for stage1 MMU and vmid index is used for stage2 MMU.

On 3A5000, vmid must be the same with vpid. On 3A6000 platform vmid
may separate from vpid. If vCPU migrate to different physical CPUs,
vpid need change however vmid can keep unchanged, so that TLB entries
for stage2 MMU is valid still. Also vmid index of the whole VM machine
is the same on one physical CPU, all vCPUs on the VM can share the
same vmid index on one physical CPU.

Similar with ASID, there is different ID management to support multiple
VMs and vCPUs, the corresponding ID management function is
__kvm_check_vpid() and __kvm_check_vmid().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h |  3 +++
 arch/loongarch/kernel/asm-offsets.c   |  1 +
 arch/loongarch/kvm/main.c             | 20 ++++++++++++++++++--
 arch/loongarch/kvm/switch.S           |  5 ++---
 arch/loongarch/kvm/tlb.c              |  5 ++++-
 5 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 23cfbecebbd7..5c2f76d1e2f8 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -232,6 +232,9 @@ struct kvm_vcpu_arch {
 	/* Cache for pages needed inside spinlock regions */
 	struct kvm_mmu_memory_cache mmu_page_cache;
 
+	/* hw vmid info for guest VM */
+	unsigned long tgid;
+
 	/* vcpu's vpid */
 	u64 vpid;
 	gpa_t flush_gpa;
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 1b861cbc5e10..f1ad3d57eadd 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -300,6 +300,7 @@ static void __used output_kvm_defines(void)
 	OFFSET(KVM_ARCH_HSP, kvm_vcpu_arch, host_sp);
 	OFFSET(KVM_ARCH_HTP, kvm_vcpu_arch, host_tp);
 	OFFSET(KVM_ARCH_HPGD, kvm_vcpu_arch, host_pgd);
+	OFFSET(KVM_ARCH_VMID, kvm_vcpu_arch, tgid);
 	OFFSET(KVM_ARCH_KVMPGD, kvm_vcpu_arch, kvm_pgd);
 	OFFSET(KVM_ARCH_HANDLE_EXIT, kvm_vcpu_arch, handle_exit);
 	OFFSET(KVM_ARCH_HEENTRY, kvm_vcpu_arch, host_eentry);
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 3e1005526f4b..a98f0284134a 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -225,7 +225,7 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, int cpu)
 	vcpu->arch.vpid = vpid;
 }
 
-void kvm_check_vpid(struct kvm_vcpu *vcpu)
+static void __kvm_check_vpid(struct kvm_vcpu *vcpu)
 {
 	int cpu;
 	bool migrated;
@@ -253,7 +253,6 @@ void kvm_check_vpid(struct kvm_vcpu *vcpu)
 		kvm_update_vpid(vcpu, cpu);
 		trace_kvm_vpid_change(vcpu, vcpu->arch.vpid);
 		vcpu->cpu = cpu;
-		kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
 
 		/*
 		 * LLBCTL is a separated guest CSR register from host, a general
@@ -279,6 +278,23 @@ void kvm_check_vpid(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
+{
+	unsigned long vmid;
+
+	vmid = vcpu->arch.vpid & vpid_mask;
+	if (vcpu->arch.tgid != vmid) {
+		vcpu->arch.tgid = vcpu->arch.vpid & vpid_mask;
+		kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
+	}
+}
+
+void kvm_check_vpid(struct kvm_vcpu *vcpu)
+{
+	__kvm_check_vpid(vcpu);
+	__kvm_check_vmid(vcpu);
+}
+
 void kvm_init_vmcs(struct kvm *kvm)
 {
 	kvm->arch.vmcs = vmcs;
diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
index 936e4ae3e408..af972394fd55 100644
--- a/arch/loongarch/kvm/switch.S
+++ b/arch/loongarch/kvm/switch.S
@@ -66,9 +66,8 @@
 	ld.d	t0, a2, KVM_ARCH_KVMPGD
 	csrwr	t0, LOONGARCH_CSR_PGDL
 
-	/* Mix GID and RID */
-	csrrd		t1, LOONGARCH_CSR_GSTAT
-	bstrpick.w	t1, t1, CSR_GSTAT_GID_SHIFT_END, CSR_GSTAT_GID_SHIFT
+	/* Set VMID for gpa --> hpa mapping */
+	ld.d		t1, a2, KVM_ARCH_VMID
 	csrrd		t0, LOONGARCH_CSR_GTLBC
 	bstrins.w	t0, t1, CSR_GTLBC_TGID_SHIFT_END, CSR_GTLBC_TGID_SHIFT
 	csrwr		t0, LOONGARCH_CSR_GTLBC
diff --git a/arch/loongarch/kvm/tlb.c b/arch/loongarch/kvm/tlb.c
index ebdbe9264e9c..afcacb62988a 100644
--- a/arch/loongarch/kvm/tlb.c
+++ b/arch/loongarch/kvm/tlb.c
@@ -23,7 +23,10 @@ void kvm_flush_tlb_all(void)
 
 void kvm_flush_tlb_gpa(struct kvm_vcpu *vcpu, unsigned long gpa)
 {
+	unsigned int vmid;
+
 	lockdep_assert_irqs_disabled();
 	gpa &= (PAGE_MASK << 1);
-	invtlb(INVTLB_GID_ADDR, read_csr_gstat() & CSR_GSTAT_GID, gpa);
+	vmid = (vcpu->arch.tgid << CSR_GSTAT_GID_SHIFT) & CSR_GSTAT_GID;
+	invtlb(INVTLB_GID_ADDR, vmid, gpa);
 }
-- 
2.39.3

