Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3937C923
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304496; cv=none; b=CAD6pqB2ngGjrxw49Nrp6g4NcG5l4cbVZAXJxqSuZBTFZ6aXIECiI1vcjtgjrvtWWg0knWsGtZIicO3BanZtzTiF2ZwU0mEt8T/YGlrbilvPDr9BIyRP8UUeGLSpc4a0VTgsKIq6PWsSjOPg4BcPlpMKMZxvUaMiAQo0a/QptkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304496; c=relaxed/simple;
	bh=MKcM0tP19vCkKjZtVB0XVvUWewGHvXSskCJnk32CE+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0a3CnU58CHAqYGHZqsmXgEETtcFlLt/wm7jfac5tBd/+S75fGAwFhlNb8yXlUW+UTnMOwq+EKQptwovRvXfOSIt74epDe43zcTtUPqOqfEfy1IZRbB6w85BRWFtyPC1bvCl0YpmHU6MDGn+Hm2s5W8LXPb/HPVMKk9wkJ8kSuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjIUQMRz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjIUQMRz"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so1942139b3a.1
        for <kvm@vger.kernel.org>; Sun, 05 Jul 2026 19:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783304494; x=1783909294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWXXbXM8qG3ZuT8JFgvr3zN3NQWJY6TPhUqR1K2Hkx4=;
        b=XjIUQMRzxoRMgeB/j/c8fY1GAgKozmVGG5M9pkooRE6Jc6hiQuxFyWWetG3n3YXy6C
         d/En0qzcqYq+lDnNaTc+pRnQdA5GLA+mo5WF8eL3SS9+iHSifgAx9CNEFZ5JGO5DFU0d
         OYUpqc9qs6TooquK9YfSuL+CaIBCyxfDOYN5JPh2DhMguhyzYZcfOuIWNuJlsqj0czYQ
         bomeyYFHNJlE+77m/z1XIHDrZmM6CYIEP9RgXFtgZMcs+nw8hi+QBBBIJW1srlhyjcfP
         O8iSFLc0UyOAozSudg6Q1ukAAjoo5tlLY7s/av34YnBt3lzD6raPIvmZ0Oz8ZJAbRTAy
         Necg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783304494; x=1783909294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qWXXbXM8qG3ZuT8JFgvr3zN3NQWJY6TPhUqR1K2Hkx4=;
        b=DKMFNi9NNeMFpAmDAlJJ6xWE234LcWdQHQqOOy0cz0763RAdPJJLkQN8fC4DfRbNWi
         v4t1Xf0OqS5r9+Xp1LkAQfUGmzPx5+1ELDTkvCDP8arwYvrVbp2YWyjJR3fnGB805Hh1
         M/uiYuKkz4NeTjdUuWaVhkfPgDlKjAqI5MwRpmudgvx+ZcWIND5NZ1mfss3QfwWqjtYZ
         3a1gymBlt2/9ZI+olcVBo4xHelXfc3HC3tEPk5/ayydFDYnljD6JT2YPtg4K5r6zy2Yt
         8PQpqrJ40g6IezDMDQMfzWK64ClvOQQWUxtcfILLYMsZIaWWNyTpvQDwXVFckkmpXbuU
         9jmA==
X-Forwarded-Encrypted: i=1; AHgh+Rpq+0g0lyqlyWnXx0ZHJi79kYbwzz9+ZUzw7kcfGnQWMQJE82OVgZn+t5YfrAm3gJaD3Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvd24iTiixKFZKfP+g6cmRdd/nIxna7eFGsWdLuYCxLxu7eeA6
	1PEj2lBNtognZUD2YZ5QMYw4Xvdv4qqEKJaFArVB6630kw7GFRA5y4zR
X-Gm-Gg: AfdE7cmpl0bc8um22iMaWIQ8GyJBcZ97UHVlsMwI/Th3X0nY9nRNuoHdwKv0uXfihan
	Xs12QFfmEwQ7axePMx2D3Ut0+H9gn48C0xk4E6QXDIGAQBM1D8vWzD0DanCuRCOnL6EriTjfw9H
	hgZZVHOcGAREYoyfdLNyvcfXYIMhkdzrgXe//hs4vQbBRnaPDrTuy+mhB8/bv22dm/eLCvpvPZu
	h9sw1hLyfWx03nXISbBi/RV+JSohpMJ4EtSY6Q993h5ZhjpOiiE0S3MZ7spnVwFDB+GH6JA6Ful
	nym3sVu4I5mPGvrSNOd/Qh1SN+thpypn0RUCGO4SguZ3cMRwJ9NXpp6qxSNWhEq2sqCLhMGMKyl
	NM35H/DGZzYskd85A/2DBlhLWzFJAzqSMv6NPthrQAW3lAN8gJGqxZcXad6lOgF07
X-Received: by 2002:a05:6a00:440c:b0:847:888f:9b0f with SMTP id d2e1a72fcca58-847f8675f1emr6341733b3a.15.1783304494664;
        Sun, 05 Jul 2026 19:21:34 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b96998sm2844797b3a.16.2026.07.05.19.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 19:21:34 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Thomas Huth <thuth@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v5 1/8] RISC-V: KVM: Add support for Svadu FWFT features
Date: Mon,  6 Jul 2026 10:20:37 +0800
Message-ID: <20260706022046.214956-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706022046.214956-1-inochiama@gmail.com>
References: <20260706022046.214956-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardware updating of PTE A/D bits is controlled through ADUE bit in
henvcfg Expose the feature only if both Svadu and Svade are supported
for VS-mode.

Allow the VMM to enable/disable this feature by change the ISA
extension state in the guest.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/uapi/asm/kvm.h |  1 +
 arch/riscv/kvm/vcpu_sbi_fwft.c    | 77 +++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 504e73305343..7bbea8812d92 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -240,6 +240,7 @@ struct kvm_riscv_sbi_fwft_feature {
 struct kvm_riscv_sbi_fwft {
 	struct kvm_riscv_sbi_fwft_feature misaligned_deleg;
 	struct kvm_riscv_sbi_fwft_feature pointer_masking;
+	struct kvm_riscv_sbi_fwft_feature pte_ad_hw_updating;
 };
 
 /* If you need to interpret the index values, here is the key: */
diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index ab39ac464ffd..01db40b53295 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -11,6 +11,7 @@
 #include <linux/kvm_host.h>
 #include <asm/cpufeature.h>
 #include <asm/sbi.h>
+#include <asm/kvm_nacl.h>
 #include <asm/kvm_vcpu_sbi.h>
 #include <asm/kvm_vcpu_sbi_fwft.h>
 
@@ -94,6 +95,45 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
 	return false;
 }
 
+static void kvm_sbi_fwft_env_flag_reset_helper(struct kvm_vcpu *vcpu,
+					       u64 flag)
+{
+	vcpu->arch.cfg.henvcfg &= ~flag;
+}
+
+static long kvm_sbi_fwft_env_flag_set_helper(struct kvm_vcpu *vcpu,
+					     struct kvm_sbi_fwft_config *conf,
+					     bool one_reg_access,
+					     unsigned long value, u64 flag)
+{
+	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
+
+	if (value == 0)
+		cfg->henvcfg &= ~flag;
+	else if (value == 1)
+		cfg->henvcfg |= flag;
+	else
+		return SBI_ERR_INVALID_PARAM;
+
+	if (!one_reg_access) {
+		ncsr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
+		if (IS_ENABLED(CONFIG_32BIT))
+			ncsr_write(CSR_HENVCFGH, vcpu->arch.cfg.henvcfg >> 32);
+	}
+
+	return SBI_SUCCESS;
+}
+
+static long kvm_sbi_fwft_env_flag_get_helper(struct kvm_vcpu *vcpu,
+					     struct kvm_sbi_fwft_config *conf,
+					     bool one_reg_access,
+					     unsigned long *value, u64 flag)
+{
+	*value = (vcpu->arch.cfg.henvcfg & flag) == flag;
+
+	return SBI_SUCCESS;
+}
+
 static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
 {
 	return misaligned_traps_can_delegate();
@@ -137,6 +177,34 @@ static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
 	return SBI_SUCCESS;
 }
 
+static bool kvm_sbi_fwft_pte_ad_hw_updating_supported(struct kvm_vcpu *vcpu)
+{
+	return riscv_isa_extension_available(vcpu->arch.isa, SVADU) &&
+		riscv_isa_extension_available(vcpu->arch.isa, SVADE);
+}
+
+static void kvm_sbi_fwft_reset_pte_ad_hw_updating(struct kvm_vcpu *vcpu)
+{
+	if (kvm_sbi_fwft_pte_ad_hw_updating_supported(vcpu))
+		kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_ADUE);
+}
+
+static long kvm_sbi_fwft_set_pte_ad_hw_updating(struct kvm_vcpu *vcpu,
+						struct kvm_sbi_fwft_config *conf,
+						bool one_reg_access, unsigned long value)
+{
+	return kvm_sbi_fwft_env_flag_set_helper(vcpu, conf, one_reg_access,
+						value, ENVCFG_ADUE);
+}
+
+static long kvm_sbi_fwft_get_pte_ad_hw_updating(struct kvm_vcpu *vcpu,
+						struct kvm_sbi_fwft_config *conf,
+						bool one_reg_access, unsigned long *value)
+{
+	return kvm_sbi_fwft_env_flag_get_helper(vcpu, conf, one_reg_access,
+						value, ENVCFG_ADUE);
+}
+
 #ifndef CONFIG_32BIT
 
 static bool try_to_set_pmm(unsigned long value)
@@ -246,6 +314,15 @@ static const struct kvm_sbi_fwft_feature features[] = {
 		.set = kvm_sbi_fwft_set_misaligned_delegation,
 		.get = kvm_sbi_fwft_get_misaligned_delegation,
 	},
+	{
+		.id = SBI_FWFT_PTE_AD_HW_UPDATING,
+		.first_reg_num = offsetof(struct kvm_riscv_sbi_fwft, pte_ad_hw_updating.enable) /
+				 sizeof(unsigned long),
+		.supported = kvm_sbi_fwft_pte_ad_hw_updating_supported,
+		.reset = kvm_sbi_fwft_reset_pte_ad_hw_updating,
+		.set = kvm_sbi_fwft_set_pte_ad_hw_updating,
+		.get = kvm_sbi_fwft_get_pte_ad_hw_updating,
+	},
 #ifndef CONFIG_32BIT
 	{
 		.id = SBI_FWFT_POINTER_MASKING_PMLEN,
-- 
2.55.0

