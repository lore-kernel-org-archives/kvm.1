Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5430274D;
	Mon,  8 Jun 2026 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882357; cv=none; b=nImhhfqSTNplZxYl+xN5p9+//8IT/gGzKVbOpCjhDXqr2xnYp2kDLygwyo+XnKJ1T7+Nk8a7BB3dcijxEDKfKvk1bT7pNOwjxzHjM62tAvuK9aJleCH3wuc2AYQgD2fe5C7c5oleG4eJ5J7qJ3RP4ro8ygvbJ/LpHZwIFlbyQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882357; c=relaxed/simple;
	bh=8xk4jwJ3RGc19PQEwYu3FIfdG1523kR6HC2z/MVXCTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QGM3ZTH2l7erQa0Z9sHuSNKfvPZGTu/K7WeJbtNW7V9Rr/AqcncKWgdNFqsG25cPKChHGGM3eSLLr5SuoRanRx14FzOaq43547BOEKhVUQwoZEJCxZfDqhnFkzXUQOZtX01iJKhblVShS6t4AjDal5VYvsg60Jrfwdwr7AVLbxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cxf+urGyZqM5kRAA--.46837S3;
	Mon, 08 Jun 2026 09:32:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMKoGyZqNTafAA--.39164S5;
	Mon, 08 Jun 2026 09:32:27 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] LoongArch: KVM: Remove some middle FPU states
Date: Mon,  8 Jun 2026 09:32:21 +0800
Message-Id: <20260608013222.375257-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260608013222.375257-1-maobibo@loongson.cn>
References: <20260608013222.375257-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMKoGyZqNTafAA--.39164S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With max VM supported FPU type enabled, if VM supports LASX, there is
FPU none --> LASX, no middle FPU state such as FPU --> LASX or
LSX --> LASX. Here remove the middle FPU states in function
kvm_own_lsx() and kvm_own_lasx(). And it becomes simpler than before.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 7f55875d8b3b..53abf7aa61f8 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1389,21 +1389,7 @@ int kvm_own_lsx(struct kvm_vcpu *vcpu)
 	/* Enable LSX for guest */
 	kvm_check_fcsr(vcpu, vcpu->arch.fpu.fcsr);
 	set_csr_euen(CSR_EUEN_LSXEN | CSR_EUEN_FPEN);
-	switch (vcpu->arch.aux_inuse & KVM_LARCH_FPU) {
-	case KVM_LARCH_FPU:
-		/*
-		 * Guest FPU state already loaded,
-		 * only restore upper LSX state
-		 */
-		_restore_lsx_upper(&vcpu->arch.fpu);
-		break;
-	default:
-		/* Neither FP or LSX already active,
-		 * restore full LSX state
-		 */
-		kvm_restore_lsx(&vcpu->arch.fpu);
-		break;
-	}
+	kvm_restore_lsx(&vcpu->arch.fpu);
 
 	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LSX);
 	vcpu->arch.aux_inuse |= KVM_LARCH_LSX | KVM_LARCH_FPU;
@@ -1418,22 +1404,8 @@ int kvm_own_lasx(struct kvm_vcpu *vcpu)
 {
 	kvm_check_fcsr(vcpu, vcpu->arch.fpu.fcsr);
 	set_csr_euen(CSR_EUEN_FPEN | CSR_EUEN_LSXEN | CSR_EUEN_LASXEN);
-	switch (vcpu->arch.aux_inuse & (KVM_LARCH_FPU | KVM_LARCH_LSX)) {
-	case KVM_LARCH_LSX:
-	case KVM_LARCH_LSX | KVM_LARCH_FPU:
-		/* Guest LSX state already loaded, only restore upper LASX state */
-		_restore_lasx_upper(&vcpu->arch.fpu);
-		break;
-	case KVM_LARCH_FPU:
-		/* Guest FP state already loaded, only restore upper LSX & LASX state */
-		_restore_lsx_upper(&vcpu->arch.fpu);
-		_restore_lasx_upper(&vcpu->arch.fpu);
-		break;
-	default:
-		/* Neither FP or LSX already active, restore full LASX state */
-		kvm_restore_lasx(&vcpu->arch.fpu);
-		break;
-	}
+	/* Neither FP or LSX already active, restore full LASX state */
+	kvm_restore_lasx(&vcpu->arch.fpu);
 
 	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LASX);
 	vcpu->arch.aux_inuse |= KVM_LARCH_LASX | KVM_LARCH_LSX | KVM_LARCH_FPU;
-- 
2.39.3

