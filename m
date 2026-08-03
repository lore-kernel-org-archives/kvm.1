Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168D8412C08;
	Mon,  3 Aug 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765337; cv=none; b=g1QmGTsQ6lrNRipYSYbYk7+6hcvnKJyiOvPYCsC0wDlB5j+5DrxR8AcfdI4MFaJTSYqUOMVu1W3rkfCOG9jBLpvfBKos3eaiflPLE+5VkP8LTMWXdbqfwuwlL6ee0AukCItrEJzzFIkidU5K6L61QypV2ZjrWdhyjtLxfU+O0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765337; c=relaxed/simple;
	bh=G6HYHfCi7INwqQUp6u6NXbIdEHGHdzr8vKztR9xYr/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpmYXezyvYBTzNlHxdxL0v209mM51S1atCFauUsRYkK0kEzlnqzfMhXdxClc4iv2NfKUVFGw6xYpRAY0kN/N5XCf5OljxiV0ChuznBDckWpzwJ8a1F/vcyDsLKtqCotqZp/zGjjMLqyh1Qn5575e7D8SyxfmG95mAxEeEKpIbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aquetkbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aquetkbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D471D1F000E9;
	Mon,  3 Aug 2026 13:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785765336;
	bh=/wWrSnfW58pauafNrE+p0KzqqpQFCnPVL21BrXaLMbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aquetkbGJCwL2l9qEk33SedqffSbzmgdGlkzRTXPNGyUVCVQWi30wZ79AkHKC1sxx
	 lVBBvn0a31gjeQw2TDWBkny2IJdZ2dhcLQGvX1K7SHN3eaib+eWZzMCrsvQZ78hgsk
	 ib9lk0EE+dgK3U5mCi+7hyw8LcZL1ih4UeiwHGdZ86GyIg7SOeoXfQU/YCTlwRRMIZ
	 tvmd4jLnLU55HCHUczdUVKx54bioUztPGKmURbqEkJCxKnrhBLY1/pLE6oA45bMz0s
	 ToRFQV69nd8jvmgDB86aLIX1J6ZN8SniGiRwA6peUuievcOEP7yOLyoU6ZrIfgtGxX
	 bE7TdyAmtXsYg==
From: Guo Ren <guoren@kernel.org>
To: guoyaxing@bosc.ac.cn
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	majiuyue@bosc.ac.cn,
	minachou@andestech.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	"Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
Subject: [PATCH] riscv: KVM: Flush VS-stage stale entries
Date: Mon,  3 Aug 2026 13:54:54 +0000
Message-ID: <20260803135454.2726112-1-guoren@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260802050015.104795-1-guoyaxing@bosc.ac.cn>
References: <20260802050015.104795-1-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

When a vCPU migrates to a different host CPU, the new CPU may retain
stale VS-stage TLB entries (GVA → GPA) left by a previous run of the
same guest. Issue an HFENCE.VVMA (all ASIDs, all addresses) inside
kvm_riscv_mmu_update_hgatp() whenever the vCPU is loaded on a CPU
different from the one it last exited on.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
Does this patch solve your problem? I would prefer to issue a full
HFENCE.VVMA whenever a new VMID is installed on a pCPU.
---
 arch/riscv/include/asm/kvm_mmu.h | 2 +-
 arch/riscv/kvm/mmu.c             | 5 ++++-
 arch/riscv/kvm/vcpu.c            | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_mmu.h b/arch/riscv/include/asm/kvm_mmu.h
index 5439e76f0a96..f0c5d2d01052 100644
--- a/arch/riscv/include/asm/kvm_mmu.h
+++ b/arch/riscv/include/asm/kvm_mmu.h
@@ -16,6 +16,6 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		      struct kvm_gstage_mapping *out_map);
 int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm);
 void kvm_riscv_mmu_free_pgd(struct kvm *kvm);
-void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu);
+void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu, int cpu);
 
 #endif
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 082f9b261733..b76a90f5811a 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -705,7 +705,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
 }
 
-void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
+void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvm_arch *ka = &vcpu->kvm->arch;
 	unsigned long hgatp = kvm_riscv_gstage_mode(ka->pgd_levels)
@@ -718,4 +718,7 @@ void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
 
 	if (!kvm_riscv_gstage_vmid_bits())
 		kvm_riscv_local_hfence_gvma_all();
+
+	if (vcpu->arch.last_exit_cpu != cpu)
+		asm volatile(HFENCE_VVMA(zero, zero) : : : "memory");
 }
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index cf6e231e76e2..9692f5f5a70a 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -593,7 +593,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		csr_write(CSR_VSATP, csr->vsatp);
 	}
 
-	kvm_riscv_mmu_update_hgatp(vcpu);
+	kvm_riscv_mmu_update_hgatp(vcpu, cpu);
 
 	kvm_riscv_vcpu_aia_load(vcpu, cpu);
 
@@ -686,7 +686,7 @@ static int kvm_riscv_check_vcpu_requests(struct kvm_vcpu *vcpu)
 			kvm_riscv_reset_vcpu(vcpu, true);
 
 		if (kvm_check_request(KVM_REQ_UPDATE_HGATP, vcpu))
-			kvm_riscv_mmu_update_hgatp(vcpu);
+			kvm_riscv_mmu_update_hgatp(vcpu, vcpu->cpu);
 
 		if (kvm_check_request(KVM_REQ_FENCE_I, vcpu))
 			kvm_riscv_fence_i_process(vcpu);
-- 
2.43.0

