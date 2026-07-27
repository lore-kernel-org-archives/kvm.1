Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967E13DD51D;
	Mon, 27 Jul 2026 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137408; cv=none; b=ofiJAI+Skhjd+ePBIxNU/2gClA8M8T7hDN8GH7RxGLEJRWdLV5aJcJoMTDndOWhGxcvwXuPDSWcynSBe6hrkkLNDrhis2XX9cfGaCvrLmebAEkpOv+FeR4MPXFbhvQO+GfpPEkql56y7K3lmCSLq5FOkYHmfzaHpRAkNpOvpKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137408; c=relaxed/simple;
	bh=W82s9ibKgIWoZ8NeDklPqxkgvU4mP3R2IkJ4jT/viuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WUlNvmLKsarMzI0LgZHSki6dXOvQlRANEwf4EU8dUGt9eK0ja//FaVaEAeXlK3mXW0T54wXhLKOpiJiQMOH4ffFP/qzFuV1GH9qYqglnQjtIrDS2TOQdzWxBA4hhkdJ1LcwEQjUWLx93v9gnBQKfrf7rwKLnOts+XUTn3Ckdr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxFaD9CGdqfakHAA--.4012S3;
	Mon, 27 Jul 2026 15:30:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxKcSYCGdq8j0aAA--.1000S5;
	Mon, 27 Jul 2026 15:29:24 +0800 (CST)
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
Subject: [PATCH 3/6] LoongArch: KVM: Add separate vmid feature support
Date: Mon, 27 Jul 2026 15:21:06 +0800
Message-Id: <20260727072109.2151675-4-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJCxKcSYCGdq8j0aAA--.1000S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Feature cpu_has_guestid is used to check whether separate vmid/vpid
is supported or not. Also add different vmid updating function.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h |  2 ++
 arch/loongarch/kvm/main.c             | 18 +++++++++++++-----
 arch/loongarch/kvm/tlb.c              | 14 ++++++++++++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index ec7b0c402385..e93307cbe740 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -319,6 +319,8 @@ bool kvm_arch_pmi_in_guest(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
 
 /* MMU handling */
+void kvm_flush_tlb_all_stage1(void);
+void kvm_flush_tlb_all_stage2(void);
 void kvm_flush_tlb_all(void);
 void kvm_flush_tlb_gpa(struct kvm_vcpu *vcpu, unsigned long gpa);
 int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsigned long badv, bool write, int ecode);
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index c1e1d8424fa7..3df46e02594f 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -218,7 +218,10 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, int cpu)
 		++vpid; /* vpid 0 reserved for root */
 
 		/* start new vpid cycle */
-		kvm_flush_tlb_all();
+		if (!cpu_has_guestid)
+			kvm_flush_tlb_all();
+		else
+			kvm_flush_tlb_all_stage1();
 	}
 
 	context->vpid_cache = vpid;
@@ -282,10 +285,15 @@ static void kvm_check_vmid(struct kvm_vcpu *vcpu)
 {
 	unsigned long vmid;
 
-	vmid = vcpu->arch.vpid & vpid_mask;
-	if (vcpu->arch.vmid != vmid) {
-		vcpu->arch.vmid = vmid;
-		kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
+	/* On some machines like 3A5000, vmid needs the same with vpid */
+	if (!cpu_has_guestid) {
+		vmid = vcpu->arch.vpid & vpid_mask;
+		if (vcpu->arch.vmid != vmid) {
+			vcpu->arch.vmid = vmid;
+			kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
+		}
+
+		return;
 	}
 }
 
diff --git a/arch/loongarch/kvm/tlb.c b/arch/loongarch/kvm/tlb.c
index 38daf936021d..1d95e2208e82 100644
--- a/arch/loongarch/kvm/tlb.c
+++ b/arch/loongarch/kvm/tlb.c
@@ -21,6 +21,20 @@ void kvm_flush_tlb_all(void)
 	local_irq_restore(flags);
 }
 
+/* Invalidate all stage1 TLB entries including GVA-->GPA mappings */
+void kvm_flush_tlb_all_stage1(void)
+{
+	lockdep_assert_irqs_disabled();
+	invtlb_all(INVGTLB_ALLGID_GVA_TO_GPA, 0, 0);
+}
+
+/* Invalidate all stage2 TLB entries including GPA-->HPA  mappings */
+void kvm_flush_tlb_all_stage2(void)
+{
+	lockdep_assert_irqs_disabled();
+	invtlb_all(INVTLB_ALLGID_GPA_TO_HPA, 0, 0);
+}
+
 void kvm_flush_tlb_gpa(struct kvm_vcpu *vcpu, unsigned long gpa)
 {
 	unsigned int vmid;
-- 
2.39.3

