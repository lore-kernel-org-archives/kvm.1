Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1DC3B6C12;
	Thu,  6 Aug 2026 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982500; cv=none; b=UzGvfpBQw+Gm2kTbS4Gql/mjqbP/l8KRJ5oD5T9CiwC4X0QXOHzGJ+0bfcPTWAgKCfsjnyXqgTvpXRigD36InaH7khLOAqxp1JZTUkPXHuP4jdxvs8KuEWNENpZkgL7SPG9a2CcbSctjo+DNJPzA+gZmeyIpbg40WZExHCnqqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982500; c=relaxed/simple;
	bh=9K7em9CH/pE8OuUB+llqO/Oynnahu2JvHPf10AVk95A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nONSZynl/Xms13aDmjH/+aVZv4aBnhN2SKjuKJCEUCY9Dp2aviP8DEJioT2u2rZNsDqJJ7Xnvub1kYEmIeWnDvmptEjOZVn/fzhjLnVOMChauL4yH1y5cdoscxVNUJkz2nnUl+cjQVf5c3jTxeNI0Y6bEz/5ahYtYDjrHrCUQy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxWqEf7nNqLtsKAA--.11960S3;
	Thu, 06 Aug 2026 10:14:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBx3wce7nNqB1QlAA--.7102S4;
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
Subject: [PATCH v2 2/5] LoongArch: KVM: Add separate vCPU and VM id update function
Date: Thu,  6 Aug 2026 10:07:36 +0800
Message-Id: <20260806020739.2149268-3-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJBx3wce7nNqB1QlAA--.7102S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

There are two-level MMU on LoongArch KVM system, the first level (stage1)
MMU is mapping for GVA --> GPA, the second level (stage2) is mapping
for GPA --> HPA. Similar with ASID, there is different ID management
to support multiple VMs and vCPUs. The stage1 MMU is called VPID, and
the second MMU is called VMID, the corresponding ID management function
is __kvm_check_vpid() and __kvm_check_vmid().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/main.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 401c84f38e8c..ac804e77e844 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -223,10 +223,9 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, int cpu)
 
 	context->vpid_cache = vpid;
 	vcpu->arch.vpid = vpid;
-	vcpu->arch.hw_vmid = vcpu->arch.vpid & vpid_mask;
 }
 
-void kvm_check_vpid(struct kvm_vcpu *vcpu)
+static void __kvm_check_vpid(struct kvm_vcpu *vcpu)
 {
 	int cpu;
 	bool migrated;
@@ -254,7 +253,6 @@ void kvm_check_vpid(struct kvm_vcpu *vcpu)
 		kvm_update_vpid(vcpu, cpu);
 		trace_kvm_vpid_change(vcpu, vcpu->arch.vpid);
 		vcpu->cpu = cpu;
-		kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
 
 		/*
 		 * LLBCTL is a separated guest CSR register from host, a general
@@ -280,6 +278,23 @@ void kvm_check_vpid(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
+{
+	unsigned long vmid;
+
+	vmid = vcpu->arch.vpid & vpid_mask;
+	if (vcpu->arch.hw_vmid != vmid) {
+		vcpu->arch.hw_vmid = vcpu->arch.vpid & vpid_mask;
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
-- 
2.39.3

