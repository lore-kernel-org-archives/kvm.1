Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C809155C97;
	Sat, 18 Jul 2026 04:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784349581; cv=none; b=VAxiUj58FlqaN1lS1Uowrpu2+gEeBAGJ0SZFCblGG9XH9azECcMltvU4VZQDuhJ0vhfL/GiSfXhW9n6bIpSdQ0rcEALMrarg3FgM0mG/IRW59nPB0t8N54ZKOxRu9PiBIPzugdik68ahiB6F2xoZVt2hAKlHD8gGeK6xhVzWFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784349581; c=relaxed/simple;
	bh=E3pdaaT3b4OZzfPgcajtxxcyUH5H+YxewJWaDZKqzKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WO2IkZnI7iMbvx/FfGQDOYJjH9mZEELUraMCbLjJyZ8Z2gCPrr9IqJhhG6VmaRfZGgg4UNqwXBWFO+4rZeubwgKE5mUWFUs5NpL1aB2BFbaAOzNPv5jUnnBayDm0CtgRvq2Xdm97O3JyHXSEKPIdcIi6yGRQ8Y4JI3a9/JGulqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAD3AUCBA1tqdlIuAA--.37050S2;
	Sat, 18 Jul 2026 12:39:30 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Avoid one-word masks for SBI v0.1 all-harts
Date: Sat, 18 Jul 2026 12:39:29 +0800
Message-ID: <20260718040000.010.826fe94e-caplitmus-rv@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3AUCBA1tqdlIuAA--.37050S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF15ZFyUJr1fGF1UuF4kJFb_yoWrXw1UpF
	WfCrZxur4fJF17uw1fXrs0yF1jvaykKan5Gws8K3yFqryagr4Fvr4v93y7AFyUJFyDXF97
	Cr4UWF18uF15JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUoq2MUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

KVM already treats a NULL hart-mask pointer in SBI v0.1 calls as all
harts, matching OpenSBI's legacy handling. The current handler builds that
target set as (1UL << online_vcpus) - 1 before iterating the mask.

That expression shifts by the type width once the VM has BITS_PER_LONG
online vCPUs, and a single word cannot represent larger VMs. A count-based
mask also selects the wrong IDs when vCPU IDs are sparse.

Handle SEND_IPI with a NULL hart-mask by iterating all online vCPUs
directly. For remote fence calls, use the existing hbase == -1UL
convention so the common fence request helper targets the whole VM
without consulting hmask.

Non-NULL guest hart masks keep the existing v0.1 behavior.

Fixes: a046c2d8578c ("RISC-V: KVM: Reorganize SBI code by moving SBI v0.1 to its own file")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/riscv/kvm/vcpu_sbi_v01.c | 52 ++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c b/arch/riscv/kvm/vcpu_sbi_v01.c
index c9c323d4577a9..de544ea3f28dc 100644
--- a/arch/riscv/kvm/vcpu_sbi_v01.c
+++ b/arch/riscv/kvm/vcpu_sbi_v01.c
@@ -16,8 +16,9 @@
 static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 				   struct kvm_vcpu_sbi_return *retdata)
 {
-	ulong hmask;
-	int i, ret = 0;
+	ulong hbase = 0, hmask;
+	unsigned long i;
+	int ret = 0;
 	u64 next_cycle;
 	struct kvm_vcpu *rvcpu;
 	struct kvm *kvm = vcpu->kvm;
@@ -46,20 +47,25 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		ret = kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_SOFT);
 		break;
 	case SBI_EXT_0_1_SEND_IPI:
-		if (cp->a0)
+		if (cp->a0) {
 			hmask = kvm_riscv_vcpu_unpriv_read(vcpu, false, cp->a0, utrap);
-		else
-			hmask = (1UL << atomic_read(&kvm->online_vcpus)) - 1;
-		if (utrap->scause)
-			break;
-
-		for_each_set_bit(i, &hmask, BITS_PER_LONG) {
-			rvcpu = kvm_get_vcpu_by_id(vcpu->kvm, i);
-			if (!rvcpu)
-				continue;
-			ret = kvm_riscv_vcpu_set_interrupt(rvcpu, IRQ_VS_SOFT);
-			if (ret < 0)
+			if (utrap->scause)
 				break;
+
+			for_each_set_bit(i, &hmask, BITS_PER_LONG) {
+				rvcpu = kvm_get_vcpu_by_id(vcpu->kvm, i);
+				if (!rvcpu)
+					continue;
+				ret = kvm_riscv_vcpu_set_interrupt(rvcpu, IRQ_VS_SOFT);
+				if (ret < 0)
+					break;
+			}
+		} else {
+			kvm_for_each_vcpu(i, rvcpu, kvm) {
+				ret = kvm_riscv_vcpu_set_interrupt(rvcpu, IRQ_VS_SOFT);
+				if (ret < 0)
+					break;
+			}
 		}
 		break;
 	case SBI_EXT_0_1_SHUTDOWN:
@@ -70,29 +76,31 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case SBI_EXT_0_1_REMOTE_FENCE_I:
 	case SBI_EXT_0_1_REMOTE_SFENCE_VMA:
 	case SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID:
-		if (cp->a0)
+		if (cp->a0) {
 			hmask = kvm_riscv_vcpu_unpriv_read(vcpu, false, cp->a0, utrap);
-		else
-			hmask = (1UL << atomic_read(&kvm->online_vcpus)) - 1;
+		} else {
+			hbase = -1UL;
+			hmask = 0;
+		}
 		if (utrap->scause)
 			break;
 
 		if (cp->a7 == SBI_EXT_0_1_REMOTE_FENCE_I)
-			kvm_riscv_fence_i(vcpu->kvm, 0, hmask);
+			kvm_riscv_fence_i(vcpu->kvm, hbase, hmask);
 		else if (cp->a7 == SBI_EXT_0_1_REMOTE_SFENCE_VMA) {
 			vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
 			if (cp->a1 == 0 && cp->a2 == 0)
-				kvm_riscv_hfence_vvma_all(vcpu->kvm, 0, hmask, vmid);
+				kvm_riscv_hfence_vvma_all(vcpu->kvm, hbase, hmask, vmid);
 			else
-				kvm_riscv_hfence_vvma_gva(vcpu->kvm, 0, hmask, cp->a1,
+				kvm_riscv_hfence_vvma_gva(vcpu->kvm, hbase, hmask, cp->a1,
 							  cp->a2, PAGE_SHIFT, vmid);
 		} else {
 			vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
 			if (cp->a1 == 0 && cp->a2 == 0)
-				kvm_riscv_hfence_vvma_asid_all(vcpu->kvm, 0, hmask,
+				kvm_riscv_hfence_vvma_asid_all(vcpu->kvm, hbase, hmask,
 							       cp->a3, vmid);
 			else
-				kvm_riscv_hfence_vvma_asid_gva(vcpu->kvm, 0, hmask,
+				kvm_riscv_hfence_vvma_asid_gva(vcpu->kvm, hbase, hmask,
 							       cp->a1, cp->a2, PAGE_SHIFT,
 							       cp->a3, vmid);
 		}
-- 
2.43.0

