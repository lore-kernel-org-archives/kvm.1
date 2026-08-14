Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7038333C
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786700873; cv=none; b=G7fn9oPvno70QT+EQx7GrPxEg0Wuy4EPtJfLY+IUKuWCk7nesf2uK/3bTQ4rxCwrP6X9vAG2Lnv1rWSKGyb+pZJQnb8ZWFhAfusyOjDC3gNvLo6n8cSkAimoUpeyRdOu4lyo4rMv8ZEPA3rPwsHrhV7rVtS/GYwxACISX4X62B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786700873; c=relaxed/simple;
	bh=sjh+hkIiI+r1dCer0VvlH2yysDJcghD9yoIoJrbQ1pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WgrIbhPVI08gqw5EoCEJjRIfCSaVhbIZ5DDKRsjvsDBfe5vZOC7XhHYv6VVkMegGqGrjJF1L7s5mlhL5nF3IH+t6zpes+3bk3nNEUd5naX9z62LHUC8sjkpu89JybBEttkLnxpoY9lKxZX6eUvSQuje4ELiAV+B4J3QCQfSoma4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jBNBTLOt; arc=none smtp.client-ip=91.218.175.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jBNBTLOt"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sjh+hkIiI+r1dCer0VvlH2yysDJcghD9yoIoJrbQ1pw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786700866; v=1; x=1787305666;
 b=jBNBTLOtySJ8JNzD+V9+50+12faaKKt7KRtAX3SVh2TLlosH8bJMvRQ9bweYpdY9EGOjsvEc
 JaiAk8szFyb3PsivAusMUaj75X73hvOFHbD0I24jCG30LbBpNVJm8QjnjPThNh/iB7ri1dFJYSE
 ru5ZzE95C6xmMY5jkbpZzvvE=
X-Envelope-To: kvm@vger.kernel.org
Received: from ctao-book.. (111.162.215.50)
	by smtp.migadu.com with ESMTPS id fccdeeeffe8d6076;
	Fri, 14 Aug 2026 09:47:46 +0000
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: chenhuacai@kernel.org,
	maobibo@loongson.cn
Cc: zhaotianrui@loongson.cn,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v3] LoongArch: KVM: Fix TOCTOU race on pv_features
Date: Fri, 14 Aug 2026 17:47:38 +0800
Message-ID: <20260814094738.2552440-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The check-then-set on kvm->arch.pv_features in
kvm_loongarch_cpucfg_set_attr() is lockless, so two vCPUs can race
past the validation and set different values.  Add a spinlock to
serialize it.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---

Changes in v2: use a spinlock instead of a cmpxchg loop (Bibo Mao).
Changes in v3: rename the lock to pv_setting_lock and place it next to
phyid_map_lock (Huacai Chen).

v1: https://lore.kernel.org/all/20260810081321.157258-1-cui.tao@linux.dev/
v2: https://lore.kernel.org/all/20260813232542.2098930-1-cui.tao@linux.dev/

 arch/loongarch/include/asm/kvm_host.h | 1 +
 arch/loongarch/kvm/vcpu.c             | 6 +++++-
 arch/loongarch/kvm/vm.c               | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 23cfbecebbd7..3538a199aac6 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -125,6 +125,7 @@ struct kvm_arch {
 	unsigned int  pte_shifts[MAX_PGTABLE_LEVELS];
 	unsigned int  root_level;
 	spinlock_t    phyid_map_lock;
+	spinlock_t    pv_setting_lock;
 	struct kvm_phyid_map  *phyid_map;
 	/* Enabled PV features */
 	unsigned long pv_features;
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20c207d80e31..e47fa463a8be 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1165,10 +1165,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
 			return -EINVAL;
 
 		/* All vCPUs need set the same PV features */
+		spin_lock(&kvm->arch.pv_setting_lock);
 		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
-				&& ((kvm->arch.pv_features & valid) != val))
+				&& ((kvm->arch.pv_features & valid) != val)) {
+			spin_unlock(&kvm->arch.pv_setting_lock);
 			return -EINVAL;
+		}
 		kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
+		spin_unlock(&kvm->arch.pv_setting_lock);
 		return 0;
 	default:
 		return -ENXIO;
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 1317c718f896..86ba7d54e81f 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -76,6 +76,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		return -ENOMEM;
 	}
 	spin_lock_init(&kvm->arch.phyid_map_lock);
+	spin_lock_init(&kvm->arch.pv_setting_lock);
 
 	kvm_init_vmcs(kvm);
 	kvm_vm_init_features(kvm);
-- 
2.43.0

