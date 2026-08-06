Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07433B71AD;
	Thu,  6 Aug 2026 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982499; cv=none; b=nOmX6hMY5AASL+5bsqu9dVBr5xLk31xSKBifJYDX4ycBdkiyc/A8Q9nKEh7rI60c2eKiKCfIv/9nuYtX01RLOJgSUxO+rqLQYAdCHu+7gwWgRYyuVWI4ackVdcX9x77VCApJZTgba8kG1adbcud+c87dVwraQ0LoAVOQhJ/pWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982499; c=relaxed/simple;
	bh=mq0+r5Y3TSjSaid7n9JBYBQEiS+qH7k4yc7FfrOG6NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h/JWOp3H0B/KVp6Fh1WSLEpjDMaHNof3cIw6gH4Tjvx3VELDFV5GimDa/9j0EOhg1hI03r3szBhfczWIN0B1VAdMDBwOvYMmh5q3xFwdWCVLZjrQ4ocQhKxugKvzu4lw9cGP1mM75fG9ZOT7BQ5Fz4fuQSEv0AptBvQyxPO72Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxvKEg7nNqM9sKAA--.11711S3;
	Thu, 06 Aug 2026 10:14:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBx3wce7nNqB1QlAA--.7102S5;
	Thu, 06 Aug 2026 10:14:55 +0800 (CST)
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
Subject: [PATCH v2 3/5] LoongArch: KVM: Add separate vmid feature support
Date: Thu,  6 Aug 2026 10:07:37 +0800
Message-Id: <20260806020739.2149268-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260806020739.2149268-1-maobibo@loongson.cn>
References: <20260806020739.2149268-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx3wce7nNqB1QlAA--.7102S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Feature cpu_has_guestid is used to check whether separate vmid/vpid
is supported or not. It is disabled by default, add this feature
checking, there is no function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/main.c | 14 +++++++++-----
 arch/loongarch/kvm/mmu.c  |  6 ++++--
 arch/loongarch/kvm/vcpu.c |  3 ++-
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index ac804e77e844..c36e62ab0d91 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -218,7 +218,8 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, int cpu)
 		++vpid; /* vpid 0 reserved for root */
 
 		/* start new vpid cycle */
-		kvm_flush_tlb_all();
+		if (!cpu_has_guestid)
+			kvm_flush_tlb_all();
 	}
 
 	context->vpid_cache = vpid;
@@ -282,10 +283,13 @@ static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
 {
 	unsigned long vmid;
 
-	vmid = vcpu->arch.vpid & vpid_mask;
-	if (vcpu->arch.hw_vmid != vmid) {
-		vcpu->arch.hw_vmid = vcpu->arch.vpid & vpid_mask;
-		kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
+	/* On some machines like 3A5000, vmid needs the same with vpid */
+	if (!cpu_has_guestid) {
+		vmid = vcpu->arch.vpid & vpid_mask;
+		if (vcpu->arch.hw_vmid != vmid) {
+			vcpu->arch.hw_vmid = vcpu->arch.vpid & vpid_mask;
+			kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
+		}
 	}
 }
 
diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index e104897aa532..714640a2e614 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -929,8 +929,10 @@ int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsigned long gpa, bool write, in
 		 *
 		 * With SW PTW, invalid TLB is added in TLB refill exception.
 		 */
-		vcpu->arch.flush_gpa = gpa;
-		kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
+		if (!cpu_has_guestid) {
+			vcpu->arch.flush_gpa = gpa;
+			kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
+		}
 	}
 
 	return 0;
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20c207d80e31..0b2355aec932 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -210,7 +210,8 @@ static int kvm_check_requests(struct kvm_vcpu *vcpu)
 		return RESUME_GUEST;
 
 	if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
-		vcpu->arch.vpid = 0;  /* Drop vpid for this vCPU */
+		if (!cpu_has_guestid)
+			vcpu->arch.vpid = 0;  /* Drop vpid for this vCPU */
 
 	if (kvm_dirty_ring_check_request(vcpu))
 		return RESUME_HOST;
-- 
2.39.3

