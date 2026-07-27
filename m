Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB36175A94;
	Mon, 27 Jul 2026 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137430; cv=none; b=O6S/+YywVVCYx1Gre3ukTT2a9H2NURWggvVAa0YfnKow2hx3iB+dCpiQvLlTyKj3Q26eoI7y9QIzTzB8HJoD+KNO41aoTp3nenTu/mGpytvaBwQhuXtSzgNYJUMPF0iA3/o3BZp6Gdz9YgHs4fsoMG2ZUZILaF6AdueJUB3RtnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137430; c=relaxed/simple;
	bh=0+7UT9wjMDMgcTHIL5J95mTVshQkHOH9nAQ9Pkjb5PI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDKuvT0bfEVOYFQn2XHKp4HkKeaOjESZBQQEVs42CIY227L8C2pFnfqZSz2V3Au5OnzQWK2O4jlVT40aZX0JMnUfGqdxQ7Bd6WMVwe68MBi5JHdtAjJt7O5KVtxbvvGcBb2crAP+0xqJai2gMrNEbmyQH0rBK89Mi+/HRZgxubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxJOgTCWdqoKkHAA--.4083S3;
	Mon, 27 Jul 2026 15:30:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxLsfqCGdqOz4aAA--.51743S2;
	Mon, 27 Jul 2026 15:29:46 +0800 (CST)
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
Subject: [PATCH 4/6] LoongArch: KVM: implement vmid updating logic
Date: Mon, 27 Jul 2026 15:21:07 +0800
Message-Id: <20260727072109.2151675-5-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJBxLsfqCGdqOz4aAA--.51743S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

For every physical CPU, there is one vmid calculation method. For
vCPUs on the same VM, vmid is the same. However for vCPUs on
different VM, vmid is different. When vCPU is scheduled on the
physical CPU, it checked vmid of this VM and the global cached
vmid, and judge whether it is valid or not.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h |  2 ++
 arch/loongarch/kvm/main.c             | 42 ++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index e93307cbe740..a01623c42c7a 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -79,6 +79,7 @@ struct kvm_arch_memory_slot {
 #define HOST_MAX_PMNUM			16
 struct kvm_context {
 	unsigned long vpid_cache;
+	unsigned long vmid_cache;
 	struct kvm_vcpu *last_vcpu;
 	/* Host PMU CSR */
 	u64 perf_ctrl[HOST_MAX_PMNUM];
@@ -132,6 +133,7 @@ struct kvm_arch {
 	unsigned long kvm_features;
 
 	s64 time_offset;
+	unsigned long vmid[NR_CPUS];
 	struct kvm_context __percpu *vmcs;
 	struct loongarch_ipi *ipi;
 	struct loongarch_dmsintc *dmsintc;
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 3df46e02594f..7b3661da8958 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -281,9 +281,33 @@ static void kvm_check_vcpuid(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void kvm_check_vmid(struct kvm_vcpu *vcpu)
+static void kvm_update_vmid(struct kvm_vcpu *vcpu, int cpu)
 {
 	unsigned long vmid;
+	struct kvm_context *context;
+
+	context = per_cpu_ptr(vcpu->kvm->arch.vmcs, cpu);
+	vmid = context->vmid_cache + 1;
+	if (!(vmid & vpid_mask)) {
+		/* finish round of vmid loop */
+		if (unlikely(!vmid))
+			vmid = vpid_mask + 1;
+
+		++vmid; /* vmid 0 reserved for root */
+
+		/* start new vmid cycle */
+		kvm_flush_tlb_all_stage2();
+	}
+
+	context->vmid_cache = vmid;
+	vcpu->kvm->arch.vmid[cpu] = vmid;
+}
+
+static void kvm_check_vmid(struct kvm_vcpu *vcpu)
+{
+	int cpu;
+	unsigned long ver, old, vmid;
+	struct kvm_context *context;
 
 	/* On some machines like 3A5000, vmid needs the same with vpid */
 	if (!cpu_has_guestid) {
@@ -295,6 +319,21 @@ static void kvm_check_vmid(struct kvm_vcpu *vcpu)
 
 		return;
 	}
+
+	cpu = smp_processor_id();
+	context = per_cpu_ptr(vcpu->kvm->arch.vmcs, cpu);
+
+	/*
+	 * Check if our vmid is of an older version
+	 */
+	ver = vcpu->kvm->arch.vmid[cpu] & ~vpid_mask;
+	old = context->vmid_cache & ~vpid_mask;
+	if (ver != old) {
+		kvm_update_vmid(vcpu, cpu);
+		kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
+	}
+
+	vcpu->arch.vmid = vcpu->kvm->arch.vmid[cpu] & vpid_mask;
 }
 
 void kvm_check_vpid(struct kvm_vcpu *vcpu)
@@ -400,6 +439,7 @@ static int kvm_loongarch_env_init(void)
 	for_each_possible_cpu(cpu) {
 		context = per_cpu_ptr(vmcs, cpu);
 		context->vpid_cache = vpid_mask + 1;
+		context->vmid_cache = vpid_mask + 1;
 		context->last_vcpu = NULL;
 	}
 
-- 
2.39.3

