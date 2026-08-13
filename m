Received: from mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307EF3624CC
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663558; cv=none; b=VaQZLjB0nkcXWS4Y1X0Ug8AcFEvUODpOt0KVSx9I21LEkNmceFn7i5ag7dPhx0le6lMN55WLuXUg4IGghZarzzk06iVKd9/tvLq8CfDmi4gSYt/8lBEpr88d2aYnoTW6+TvkjgFU9xUbxdAoXPxqu6fpBY2v4WjgNyPAjM7f0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663558; c=relaxed/simple;
	bh=Enf+YsjOMprKXPN86ka3rREmGOuZZK8yt2Up1k9KAKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCOGVbudhGIEA17MDWG4/xk2iia825qtXn47HO/hn9LJfQIZXgZXYh8PH/h+q9dbYpSDaZ5ejUafMzBl8rWRAmGxxLF+VKRQBZRz2UdHQt8Fz4Rkej1BxxkLzr62DJV87Y+fEXfEf79mF/EmJqwql/GwKByGCkK2PKTzHbhXoaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uQ04qzyE; arc=none smtp.client-ip=91.218.175.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uQ04qzyE"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Enf+YsjOMprKXPN86ka3rREmGOuZZK8yt2Up1k9KAKw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786663553; v=1; x=1787268353;
 b=uQ04qzyEQJ/HBImk1gyaqt1tYKSL3EyOot8lJchCEssS6xSghXNTRDk+qPtG0xX71QJrM7zi
 uvjUyTZU87aRByHDI7Tu/mB4Dk11lJZK3f1CU/LMA+UoahNWV2YOizMFpSFBeKSjpYbEBfPFXu+
 +rNyYiVrwdLSCj8mFQUrclzI=
X-Envelope-To: kvm@vger.kernel.org
Received: from ctao-book.. (111.162.215.50)
	by smtp.migadu.com with ESMTPS id afc9b2f00fdf83c6;
	Thu, 13 Aug 2026 23:25:53 +0000
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn
Cc: zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2] LoongArch: KVM: Fix TOCTOU race on pv_features
Date: Fri, 14 Aug 2026 07:25:42 +0800
Message-ID: <20260813232542.2098930-1-cui.tao@linux.dev>
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

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---

Changes in v2: use a spinlock instead of a cmpxchg loop (Bibo Mao).
Link: https://lore.kernel.org/all/20260810081321.157258-1-cui.tao@linux.dev/

 arch/loongarch/include/asm/kvm_host.h | 2 ++
 arch/loongarch/kvm/vcpu.c             | 6 +++++-
 arch/loongarch/kvm/vm.c               | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 23cfbecebbd7..cdbbd90e0584 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -128,6 +128,8 @@ struct kvm_arch {
 	struct kvm_phyid_map  *phyid_map;
 	/* Enabled PV features */
 	unsigned long pv_features;
+	/* Serializes pv_features updates */
+	spinlock_t pv_features_lock;
 	/* Supported KVM features */
 	unsigned long kvm_features;
 
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20c207d80e31..551ed39b2d1f 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1165,10 +1165,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
 			return -EINVAL;
 
 		/* All vCPUs need set the same PV features */
+		spin_lock(&kvm->arch.pv_features_lock);
 		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
-				&& ((kvm->arch.pv_features & valid) != val))
+				&& ((kvm->arch.pv_features & valid) != val)) {
+			spin_unlock(&kvm->arch.pv_features_lock);
 			return -EINVAL;
+		}
 		kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
+		spin_unlock(&kvm->arch.pv_features_lock);
 		return 0;
 	default:
 		return -ENXIO;
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 1317c718f896..b984cc54f305 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -76,6 +76,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		return -ENOMEM;
 	}
 	spin_lock_init(&kvm->arch.phyid_map_lock);
+	spin_lock_init(&kvm->arch.pv_features_lock);
 
 	kvm_init_vmcs(kvm);
 	kvm_vm_init_features(kvm);
-- 
2.43.0

