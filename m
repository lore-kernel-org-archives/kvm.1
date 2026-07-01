Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115203624DE
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871699; cv=none; b=geyZpKOZk6wUn73XIua2jBjHrQiugE+4y5CGzftibXFE9i4cxbPLpSm2g+P9bywaDFSWuk9oN3Gw83rN+SGiGlNsQUBDYq0v6W4qu7BVeuIpCKi6MXrtiTCbh+taTHc1Fx3LFpF9TjfrY3mSxpaIWCw/iHKSQHbKXzTILiukhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871699; c=relaxed/simple;
	bh=RloR602Dyun9OubYeLwpwrmwOmTdaUDS6w9g7e2DSxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEEiSytnpyA9t+FFZPly3W+7X6uA4AmfQO5QZutTAvH0infW4kMok767ZnG8ZlOmWMuu2yPi7VJ/N8xGyh0hTbVFAjotUvmliGYiS1z0gHUOjW6c3xPvgqRcyTNpsYCZW2kRXyDNbsXfdVrNSku0HFZZURWMzeP4h0gJixPxQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGv4K2rf; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGv4K2rf"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so47678a12.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 19:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782871697; x=1783476497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xn87s7In+F3eOVUqsrjIa2N2Lz49wpP+uXxKTq7hWQ=;
        b=KGv4K2rfoqdQP6uIVT6zRGZn0VTd8KQDKKiIdIWXq1gY8x8+4KIDCjOnYLJ4Az0GjS
         GpLNoUa9uH7bxE7meqQt/rXOTyuVFQ2XBMLq9jaXDdk2H1Vvl/886ciRQ0OhQLC8QwmT
         JIy2pCr377UJGx/VOrXiIFMcB+CCICeXxYKqYKlsrn1JpbuxdfSdbfhgBhbVdp23TF2B
         wJ+2XqPKp8uk36MtHOaFCh4S7LLnjSEmRGXRJvpY1/23mZIzcbCTv4LsuHsPt1cigesV
         7OLO7MggcySiQTzHZG7WFNmvu5kAWtC7E9mG9KulQQ+8e05RKlVmC/76MPSP7RCUiosC
         M68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782871697; x=1783476497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xn87s7In+F3eOVUqsrjIa2N2Lz49wpP+uXxKTq7hWQ=;
        b=TSCaltsYGamyB5z1cWJcHu+Ztmagtw1p/mbhRGyTlndVtP6PLaEp1cSyh+wx75UZH9
         A0QuZPaSuySi67CkkH6OpFSW/D7teJHuImnHHCY2AlZNfLQksOB4RJ1qXCuWvchBJPIG
         YGfoio0x8DhDmNeJmENqEErW6MIP5fSJb8pCyqM9p3hFU2IuBPHuGKLwRhhVs8sqBYTA
         a8o0Zs15b3qOiuQ+17GYVJexvczNWDOvCMgqnN9pvqyQjuyIipm6zgSMU9prPZvmtkOQ
         oMeZbaj5k/nek/n46Zo+pUO/PJ+5iOmmaKENtk3EEU9Rf3DFN1U/p9jBOovu4K5q0bfK
         xyoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpvli37TINPaESK8ceqT6P3RHJMIjnZZCOa58DTLPTR2XLolAiqklEdRZnzNvRjUI2lyXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcdwme1eFiNNAJ/FUhSfxZXTcipTGsnaDj9qiNeVtFE9LBsLCH
	r98pJcwWPJTOCTVNEoRQWCVJMVvxJ5ZVksTlOVNZm9XALE23BwycRY3N
X-Gm-Gg: AfdE7cl/RBym1snT+XpPEOe7EM61j4cWJy+Abc0t6L7BKSwm8iFxF8KnLT6kc3a81/z
	w4GQmJi/UDj0Yvxiz4SrqyHn61+xDh61s60Yrv7tTKTXxGWysQNxSlTBz93cm1opdmr562ehy7v
	IDu7HL+Z1KftvWxiFcV+a2nvY9a2sxZn8+ciLdwaNktpoLadfjQI7TQhSAC5Vi0qs040MAefdG7
	UMGhGSItwr6mHSsrqc2NHn2pOvczMr1hI0zzUGqiknDRO4BdqlnaWaEDdcC4xkcvPBv4uc7g5c+
	voo+MrL6wx+tFQ4+oUooFveCxnwLz3gZ6rquUngaMJJNKul8nGrwPFKIL8Ko0CNwp77l7silYtP
	aZqn++e+TKIxc86Gdlp6a/kCooaIdalk5SkS4+3cBGB2BoGbPZOXctbLIEXuI5nT/9BaRwIN5f+
	MklZijLX8pBMI=
X-Received: by 2002:a05:6a00:80e:b0:845:eb73:411c with SMTP id d2e1a72fcca58-847adeef6cemr2978992b3a.45.1782871697291;
        Tue, 30 Jun 2026 19:08:17 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479ffff404sm3114718b3a.22.2026.06.30.19.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 19:08:17 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Andy Chiu <andybnac@gmail.com>,
	Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v4 1/8] RISC-V: KVM: Add support for Svadu FWFT features
Date: Wed,  1 Jul 2026 10:07:38 +0800
Message-ID: <20260701020746.170157-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260701020746.170157-1-inochiama@gmail.com>
References: <20260701020746.170157-1-inochiama@gmail.com>
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
 arch/riscv/kvm/vcpu_sbi_fwft.c    | 75 +++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

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
index ab39ac464ffd..7192c229a19e 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -94,6 +94,45 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
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
+		csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
+		if (IS_ENABLED(CONFIG_32BIT))
+			csr_write(CSR_HENVCFGH, vcpu->arch.cfg.henvcfg >> 32);
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
@@ -137,6 +176,33 @@ static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
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
+	kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_ADUE);
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
@@ -246,6 +312,15 @@ static const struct kvm_sbi_fwft_feature features[] = {
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

