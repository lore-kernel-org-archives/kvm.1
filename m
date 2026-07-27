Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47953DDAEA;
	Mon, 27 Jul 2026 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137368; cv=none; b=RovmBd3qXEWr6ld73VoPWOmG2bQi8mY6akOgyn7ndZJfreVrvDX1reloy4uZMHOicGvADlB9+GixWrpCrbN/yCzgYIl/PSobRIfdjosg90Ry+/InDMP7qHCsVrg4ryTQPk9nDraTqaxoUsP9TLDb7+DaAnXIZyEhZ5RYozN716k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137368; c=relaxed/simple;
	bh=60TaggGacK3e54TrYNWOzj+HB0NKhFt0VvdkyRusQ4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOABae60dOaDAkue3QNTUKurkpYeK9xZQgCPqeqD4acnFJ+JbAgunGhiQzEdNjUzlb+Ogb+EqpOLhz6BAn2Tlr3m3JIvN3WWAJ4xjqpt4ij9a4SWOul46gNbbJKDRE3oZ6mLmTcig7C8a1JYGU+A/bmH2DskPrCx8HSjdJ+RoME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxGOvUCGdqPakHAA--.27284S3;
	Mon, 27 Jul 2026 15:29:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxKcSYCGdq8j0aAA--.1000S3;
	Mon, 27 Jul 2026 15:28:44 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Arnd Bergmann <arnd@arndb.de>,
	Xi Ruoyao <xry111@xry111.site>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] LoongArch: KVM: Add vmid support for stage2 MMU
Date: Mon, 27 Jul 2026 15:21:04 +0800
Message-Id: <20260727072109.2151675-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260727072109.2151675-1-maobibo@loongson.cn>
References: <20260727072109.2151675-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxKcSYCGdq8j0aAA--.1000S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

LoongArch KVM hypervisor supports two-level MMU, vpid index is used
for stage1 MMU and vmid index is used for stage2 MMU.

On 3A5000, vmid must be the same with vpid. On 3A6000 platform vmid
may separate from vpid. If vcpu migrate to different physical CPUs,
vpid need change however vmid can keep the same with old value. Also
vmid index of the while VM machine on physical CPU the same, all vCPUs
on the VM can share the same vmid index on one physical CPU.

Here vmid index is added and it keeps the same with vpid still.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h | 3 +++
 arch/loongarch/kernel/asm-offsets.c   | 1 +
 arch/loongarch/kvm/main.c             | 1 +
 arch/loongarch/kvm/switch.S           | 5 ++---
 arch/loongarch/kvm/tlb.c              | 5 ++++-
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 23cfbecebbd7..ec7b0c402385 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -189,6 +189,9 @@ struct kvm_vcpu_arch {
 	unsigned long host_tp;
 	unsigned long host_pgd;
 
+	/* vmid info for guest VM */
+	unsigned long vmid;
+
 	/* Host CSRs are used when handling exits from guest */
 	unsigned long badi;
 	unsigned long badv;
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 1b861cbc5e10..32ef6adfc8dd 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -300,6 +300,7 @@ static void __used output_kvm_defines(void)
 	OFFSET(KVM_ARCH_HSP, kvm_vcpu_arch, host_sp);
 	OFFSET(KVM_ARCH_HTP, kvm_vcpu_arch, host_tp);
 	OFFSET(KVM_ARCH_HPGD, kvm_vcpu_arch, host_pgd);
+	OFFSET(KVM_ARCH_VMID, kvm_vcpu_arch, vmid);
 	OFFSET(KVM_ARCH_KVMPGD, kvm_vcpu_arch, kvm_pgd);
 	OFFSET(KVM_ARCH_HANDLE_EXIT, kvm_vcpu_arch, handle_exit);
 	OFFSET(KVM_ARCH_HEENTRY, kvm_vcpu_arch, host_eentry);
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 3e1005526f4b..6e3e8efa1dc2 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -223,6 +223,7 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, int cpu)
 
 	context->vpid_cache = vpid;
 	vcpu->arch.vpid = vpid;
+	vcpu->arch.vmid = vcpu->arch.vpid & vpid_mask;
 }
 
 void kvm_check_vpid(struct kvm_vcpu *vcpu)
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
index ebdbe9264e9c..38daf936021d 100644
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
+	vmid = (vcpu->arch.vmid << CSR_GSTAT_GID_SHIFT) & CSR_GSTAT_GID;
+	invtlb(INVTLB_GID_ADDR, vmid, gpa);
 }
-- 
2.39.3

