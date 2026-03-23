Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3BB299937;
	Mon, 23 Mar 2026 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774234583; cv=none; b=WPDA+sZL+sRtn9zyyh5zB4LwvI8ajIpUrVhNMTXbqTEipqGxAD6ehk8r895arduY2PiTaSaOk8EEpR8k6HS+pZnNsn0OthL4ok+29MZKDNK24Ju+kUEcV9lTp57SmjIJ5qmxVQYBLCUixVkwSVsUzk0TPXdzdQjLucK1N2dIf+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774234583; c=relaxed/simple;
	bh=vJn81t4uxYYWNgXRhGeseiQqdg75Zy7PleMWDkS5N6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbwV4k0k+GUo2Brkr+8X+CP8Rru6GbjN59B24tCMTdihjgSVL4XwP/9NSnh0FCG55OXhLPPxTZY+xnfkb2fSdqbBxojmBM/7GGbbXGBV2FwDSPa1sLn5Dc1fKU8Ux0yIPE6cIZINC4AuLpmuv7bu5aODfT660Cf1rjez4kyg2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxssDTq8BppqYdAA--.25936S3;
	Mon, 23 Mar 2026 10:56:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxbcLOq8Bpcg5bAA--.40805S5;
	Mon, 23 Mar 2026 10:56:17 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 3/4] LoongArch: KVM: Move host CSR_GSTAT save and restore in context switch
Date: Mon, 23 Mar 2026 10:56:12 +0800
Message-Id: <20260323025613.3260876-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260323025613.3260876-1-maobibo@loongson.cn>
References: <20260323025613.3260876-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxbcLOq8Bpcg5bAA--.40805S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

CSR register CSR_GSTAT stores guest VMID information. With existing
implementation method, VMID is per vCPU similar with ASID on kernel.
Register CSR_GSTAT is written at VM entry even if VMID is not changed.

Here move CSR_GSTAT save/restore in vCPU context switch, and update
register CSR_GSTAT only when VMID is updated at VM entry. At most time
VM enter/exit is much more frequent than vCPU thread context switch.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/main.c | 8 ++++----
 arch/loongarch/kvm/vcpu.c | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 2c593ac7892f..304c83863e71 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -271,11 +271,11 @@ void kvm_check_vpid(struct kvm_vcpu *vcpu)
 		 * memory with new address is changed on other VCPUs.
 		 */
 		set_gcsr_llbctl(CSR_LLBCTL_WCLLB);
-	}
 
-	/* Restore GSTAT(0x50).vpid */
-	vpid = (vcpu->arch.vpid & vpid_mask) << CSR_GSTAT_GID_SHIFT;
-	change_csr_gstat(vpid_mask << CSR_GSTAT_GID_SHIFT, vpid);
+		/* Restore GSTAT(0x50).vpid */
+		vpid = (vcpu->arch.vpid & vpid_mask) << CSR_GSTAT_GID_SHIFT;
+		change_csr_gstat(vpid_mask << CSR_GSTAT_GID_SHIFT, vpid);
+	}
 }
 
 void kvm_init_vmcs(struct kvm *kvm)
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index e82b2c84ce17..8810fcd7e26e 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1695,6 +1695,7 @@ static int _kvm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Restore Root.GINTC from unused Guest.GINTC register */
 	write_csr_gintc(csr->csrs[LOONGARCH_CSR_GINTC]);
+	write_csr_gstat(csr->csrs[LOONGARCH_CSR_GSTAT]);
 
 	/*
 	 * We should clear linked load bit to break interrupted atomics. This
@@ -1790,6 +1791,7 @@ static int _kvm_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 		kvm_save_hw_gcsr(csr, LOONGARCH_CSR_ISR3);
 	}
 
+	csr->csrs[LOONGARCH_CSR_GSTAT] = read_csr_gstat();
 	vcpu->arch.aux_inuse |= KVM_LARCH_SWCSR_LATEST;
 
 out:
-- 
2.39.3

