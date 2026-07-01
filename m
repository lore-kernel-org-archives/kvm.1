Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC536A340
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871716; cv=none; b=ZG8dvSpMLrqPJI1aFrJY5Vz0kddvHFuVDuTmCgPdBVfGCgEKfmJlFwrYKsmtOBqO0slYSb2aCGqboqCQp/RXpUIM8xResk/+zBLFI+NwbGmY9NvVaX1lMsCRFkYzPcRkRAQhZltmxoJBwAZTWQv2sw39wbbzmh3k7nQiyROF3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871716; c=relaxed/simple;
	bh=Snq43EZiqkG/pdRD1SOZH5YvHYsezwtyIDqRKqEgFtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKWEsiQ6WNuCMoANQL39F9xWDnFo2mbq1WABAHlp7dolL3pbu09cV88ICHjPcOICZt8jRSPwcpYH0SmPHBEI0G6glpghiQl6fEw80yEywKPnx/XJzhQLs1mo59Q2bFn5YJQA9nbpblqY+jUIb/qO0PAKbS5bS2ERgYrnvpqbWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2+Qj1Dv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2+Qj1Dv"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c9dbd00f1dso773425ad.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 19:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782871713; x=1783476513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNDnGLVvnD4tmjeYRO+s6FPAGzn4En+qXlh/M6ZOC2c=;
        b=Q2+Qj1DvLw7DQQ58cXouM5IdvhpgvmjYsx27kNpys89v//YajOzpenpSjw4T5B5+ra
         GmsoUVHyNVoslDcLOhPcPMVcGgpDCB7ECZq1dML7AWrjO+blG2p+Ofv/jVfFo98EnXO+
         AWLKSeRJtCo5S0vzaQzqhY+9AqDdgw8aqeKzYyJ7Z7VNcJNdWH1fV40LUZhj0THFXi6L
         FY0jlDHv1E0SMo0zr3dmha/JGVaVld2WIoqduJ+YVdNzPjQbLHwP+wVQ1o7JIYEdl/Pv
         D7ooL1RpiCyXHzMsm/UwspxWKRtNqbOQrPmBf9W2Z5vywnogaUlC6bteWm42sSgKPymZ
         BD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782871713; x=1783476513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xNDnGLVvnD4tmjeYRO+s6FPAGzn4En+qXlh/M6ZOC2c=;
        b=RX4HSOTq3uVl1Rxh5kEw6LywCQhoV+fNVAc5/Ag8aVjJcy7IF3SYmAN2j9hIkT+GfM
         hlaOYlShBmm/0knVZJGu+uru3O+F9mdTbthfWpr7cWY9+Y5rBB2fe+0a9V/2s0logDcR
         B39hq5rR7QWI+6LEMRQzDg/uSBkTqntrFpT7tT1fPJl0XGf+W2rNmGtEsVPkCoyi+RIt
         FuSaOI9IUliN6ILMBpDd8SeLU8w1XM8UA9OPbT9Sb/b2KcTbKJ5FxA+OJG+8yZVfoOgZ
         so8xOMfEeqhY1i9QPKgfypumqJzLZgIrXypQB3sRhCjq5mzhHr4fESa9CyOrtSA+CwU2
         w29A==
X-Forwarded-Encrypted: i=1; AFNElJ9IoxkfkS+kNKPZpv/Ewyt9oM9+SQNxi9lP6e1ldbpMXS4KHrSfr7j+XrkDouQdGizdULk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjd1J+lNCug+XiXvDkfjPuv85LmqSgXs+uvFMwUG3qYXdgP+Ti
	2RZytyAhPqukJaui0Ro50NIf7JST+h2smVWgapgj1QXhqd/M0bu7iosa
X-Gm-Gg: AfdE7cnLLvyfYWpPWRLa66aNkRZYdWzG0FA8RHfABlHvMHGtP+uaXBNm5YUA3OjTQpw
	RQju26dXLkNtTp5/CEIQDQuLxjsU9Lq2ptgMbnIDCOeEgMJK/D9f6Q9R+vI1R0JRSdfznr33r0P
	WlBPKgyQZ5U1CiVo+JsFYR9Oa3uXV2mkeSA5oy3COVABJmXdNGSpTlWnHHS7bihj/gkgQFgSoZS
	wX4csghwuxrg2/+KGLPf3ZLBEtI8wteyKeCHQVwXKkIh0qyZdwqX/e0ETdiRPywWA7wv1zIuog6
	QmIJTInDERUL3spSOCiJIA0bwsEVRnzoipoYCBDyXHEDndqXQkeX7/CPMuIKhUGQlcVN+NH7jzE
	H/0H+j3h6+i56w5DPpZbPxglvA1WbgcqqpS0YAIGRFhkVlakdYVeB5NFX4hU68TUOWm3Lj0IAA0
	UUIbj4Mej6JqkHmg4wPXG5yQ==
X-Received: by 2002:a17:902:e806:b0:2c9:ff29:3f91 with SMTP id d9443c01a7336-2ca5a55b720mr28253325ad.6.1782871713354;
        Tue, 30 Jun 2026 19:08:33 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a3863sm22650065ad.57.2026.06.30.19.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 19:08:33 -0700 (PDT)
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
Subject: [PATCH v4 7/8] RISC-V: KVM: Add support for control-flow integrity FWFT features
Date: Wed,  1 Jul 2026 10:07:44 +0800
Message-ID: <20260701020746.170157-8-inochiama@gmail.com>
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

Control-flow integrity is controlled through a WARL field in henvcfg.
Expose the feature only if the Zicfilp/Zicfiss is supported for VS-mode.
Allow the VMM to block access to the feature by disabling the ISA
extension in the guest.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/uapi/asm/kvm.h |   2 +
 arch/riscv/kvm/vcpu_sbi_fwft.c    | 107 ++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index fd4c81697617..20d9959ca44f 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -248,6 +248,8 @@ struct kvm_riscv_sbi_fwft {
 	struct kvm_riscv_sbi_fwft_feature misaligned_deleg;
 	struct kvm_riscv_sbi_fwft_feature pointer_masking;
 	struct kvm_riscv_sbi_fwft_feature pte_ad_hw_updating;
+	struct kvm_riscv_sbi_fwft_feature landing_pad;
+	struct kvm_riscv_sbi_fwft_feature shadow_stack;
 };
 
 /* If you need to interpret the index values, here is the key: */
diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index 7192c229a19e..cb9b9721ec88 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -176,6 +176,95 @@ static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
 	return SBI_SUCCESS;
 }
 
+static long kvm_sbi_fwft_set_cfi(struct kvm_vcpu *vcpu,
+				 struct kvm_sbi_fwft_config *conf,
+				 bool one_reg_access, unsigned long value,
+				 u64 flag)
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
+	if (cfg->henvcfg & (ENVCFG_LPE | ENVCFG_SSE))
+		cfg->hedeleg |= EXC_SOFTWARE_CHECK;
+	else
+		cfg->hedeleg &= ~EXC_SOFTWARE_CHECK;
+
+	if (!one_reg_access) {
+		csr_write(CSR_HEDELEG, cfg->hedeleg);
+		/*
+		 * Both Bit LPE and SSE are in the lower part, so it is safe
+		 * to only write the henvcfg
+		 */
+		csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
+	}
+
+	return SBI_SUCCESS;
+}
+
+static bool kvm_sbi_fwft_landing_pad_supported(struct kvm_vcpu *vcpu)
+{
+	return riscv_isa_extension_available(vcpu->arch.isa, ZICFILP);
+}
+
+static void kvm_sbi_fwft_reset_landing_pad(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
+
+	kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_LPE);
+	if ((cfg->henvcfg & (ENVCFG_LPE | ENVCFG_SSE)) == 0)
+		cfg->hedeleg &= ~EXC_SOFTWARE_CHECK;
+}
+
+static long kvm_sbi_fwft_set_landing_pad(struct kvm_vcpu *vcpu,
+					 struct kvm_sbi_fwft_config *conf,
+					 bool one_reg_access, unsigned long value)
+{
+	return kvm_sbi_fwft_set_cfi(vcpu, conf, one_reg_access, value, ENVCFG_LPE);
+}
+
+static long kvm_sbi_fwft_get_landing_pad(struct kvm_vcpu *vcpu,
+					 struct kvm_sbi_fwft_config *conf,
+					 bool one_reg_access, unsigned long *value)
+{
+	return kvm_sbi_fwft_env_flag_get_helper(vcpu, conf, one_reg_access,
+						value, ENVCFG_LPE);
+}
+
+static bool kvm_sbi_fwft_shadow_stack_supported(struct kvm_vcpu *vcpu)
+{
+	return riscv_isa_extension_available(vcpu->arch.isa, ZICFISS);
+}
+
+static void kvm_sbi_fwft_reset_shadow_stack(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
+
+	kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_SSE);
+	if ((cfg->henvcfg & (ENVCFG_LPE | ENVCFG_SSE)) == 0)
+		cfg->hedeleg &= ~EXC_SOFTWARE_CHECK;
+}
+
+static long kvm_sbi_fwft_set_shadow_stack(struct kvm_vcpu *vcpu,
+					  struct kvm_sbi_fwft_config *conf,
+					  bool one_reg_access, unsigned long value)
+{
+	return kvm_sbi_fwft_set_cfi(vcpu, conf, one_reg_access, value, ENVCFG_SSE);
+}
+
+static long kvm_sbi_fwft_get_shadow_stack(struct kvm_vcpu *vcpu,
+					  struct kvm_sbi_fwft_config *conf,
+					  bool one_reg_access, unsigned long *value)
+{
+	return kvm_sbi_fwft_env_flag_get_helper(vcpu, conf, one_reg_access,
+						value, ENVCFG_SSE);
+}
+
 static bool kvm_sbi_fwft_pte_ad_hw_updating_supported(struct kvm_vcpu *vcpu)
 {
 	return riscv_isa_extension_available(vcpu->arch.isa, SVADU) &&
@@ -312,6 +401,24 @@ static const struct kvm_sbi_fwft_feature features[] = {
 		.set = kvm_sbi_fwft_set_misaligned_delegation,
 		.get = kvm_sbi_fwft_get_misaligned_delegation,
 	},
+	{
+		.id = SBI_FWFT_LANDING_PAD,
+		.first_reg_num = offsetof(struct kvm_riscv_sbi_fwft, landing_pad.enable) /
+				 sizeof(unsigned long),
+		.supported = kvm_sbi_fwft_landing_pad_supported,
+		.reset = kvm_sbi_fwft_reset_landing_pad,
+		.set = kvm_sbi_fwft_set_landing_pad,
+		.get = kvm_sbi_fwft_get_landing_pad,
+	},
+	{
+		.id = SBI_FWFT_SHADOW_STACK,
+		.first_reg_num = offsetof(struct kvm_riscv_sbi_fwft, shadow_stack.enable) /
+				 sizeof(unsigned long),
+		.supported = kvm_sbi_fwft_shadow_stack_supported,
+		.reset = kvm_sbi_fwft_reset_shadow_stack,
+		.set = kvm_sbi_fwft_set_shadow_stack,
+		.get = kvm_sbi_fwft_get_shadow_stack,
+	},
 	{
 		.id = SBI_FWFT_PTE_AD_HW_UPDATING,
 		.first_reg_num = offsetof(struct kvm_riscv_sbi_fwft, pte_ad_hw_updating.enable) /
-- 
2.55.0

