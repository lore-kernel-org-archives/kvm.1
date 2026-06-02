Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15E303CB0
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366720; cv=none; b=FbQXN9yJ7gkT6n2bPdKmyZAs2XAZGkpZp3aNwHyXejEuagrrDpiJiMEzH3uTJj8epHFEtYn8lMXCbgjG8po7rhRtCxDzHgR+wBwa9M7Dr90f/dx4xPX8PT7Z8tfe4a/4wbex1EvRGDCyddx2vi1L+QjxOqVMCzbmm0VxXIVFXt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366720; c=relaxed/simple;
	bh=ZpFTNH+QkWNUcCDLzTLmEFbVca/j5IsiXGD3w4XLbqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPHUs2VlxMFkj5oa85CoDxVwav+CMag3EvyRSm4b7Q6EJLowVn2U/+cc0F17DlSrBtdeBrr0fAky31j1SOLjMI12DIyFsd5HhKcCnKw33TChiJLFgpXwxwk5pupQeHsSgD3YIUsUzM8NplIjUkao2b9t7Pa6nx7Gm65PIaNojqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cUYrihdF; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cUYrihdF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780366716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=InnnE+6dN1zfjc/jLh3Hb+9OxcucI0SB7SooXYpEBNA=;
	b=cUYrihdFRYzt+y3sSymqVea9Pje2cBiFxg5n5q8tAYOHsfkx0LNCmPYDUVISuYXQoHeVhB
	/ZFEyi93mNfkeK+hp1+MhYhe0GHQWm1r7GHvhhdn3p6WftVjUo5LfuN15XG+Pw+qBIEe+U
	F0h3h5qlpnj+6XT0wx8gC9WfsKN7Uis=
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn,
	zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v3 1/4] LoongArch: KVM: Preserve auto-enabled PV features on userspace override
Date: Tue,  2 Jun 2026 10:18:16 +0800
Message-ID: <20260602021819.2373404-2-cui.tao@linux.dev>
In-Reply-To: <20260602021819.2373404-1-cui.tao@linux.dev>
References: <20260602021819.2373404-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

When userspace (e.g., QEMU) sets PV features via KVM_SET_DEVICE_ATTR
with CPUCFG_KVM_FEATURE, it completely replaces the kernel-default
pv_features. This causes features auto-enabled by the kernel (such as
KVM_FEATURE_STEAL_TIME) to be lost if userspace doesn't explicitly
include them.

Add a pv_auto_features field to struct kvm_arch that saves the
kernel-default PV features set during kvm_vm_init_features(). When
userspace overrides pv_features, OR the saved auto features back
to preserve them.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/include/asm/kvm_host.h | 2 ++
 arch/loongarch/kvm/vcpu.c             | 7 +++++++
 arch/loongarch/kvm/vm.c               | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 776bc487a705..903cb67ca817 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -127,6 +127,8 @@ struct kvm_arch {
 	struct kvm_phyid_map  *phyid_map;
 	/* Enabled PV features */
 	unsigned long pv_features;
+	/* PV features auto-enabled by kernel */
+	unsigned long pv_auto_features;
 	/* Supported KVM features */
 	unsigned long kvm_features;
 
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index e28084c49e68..47a59ce9e561 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1165,6 +1165,13 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
 		if (val & ~valid)
 			return -EINVAL;
 
+		/*
+		 * Auto-enabled features (e.g. PV TLB flush) that userspace
+		 * is not aware of are preserved so that no QEMU changes are
+		 * needed for pure kernel-internal optimisations.
+		 */
+		val = (val | kvm->arch.pv_auto_features) & valid;
+
 		/* All vCPUs need set the same PV features */
 		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
 				&& ((kvm->arch.pv_features & valid) != val))
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 1317c718f896..8af874e0b36b 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -57,6 +57,7 @@ static void kvm_vm_init_features(struct kvm *kvm)
 		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_PREEMPT);
 		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_STEALTIME);
 	}
+	kvm->arch.pv_auto_features = kvm->arch.pv_features;
 }
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
-- 
2.43.0

