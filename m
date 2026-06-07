Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B8836E484
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780819882; cv=none; b=drKAofHzp0cCwb9Gq9vhY5q6T6WkVdEbsHnFGFROaqFpedxVKXF+LlkGdie4cByF9IFJCwcpvL2A+4w5VatzwAkkm9cEFdJ/Ks6npnJaCuvgu5zCms2AzphU6Na3XgfxfXZsp1jx7wpseiCK9yWM040xsMa65fkebXfLe8DfQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780819882; c=relaxed/simple;
	bh=SH70S7eZGrkvAFmPtXR5rTve7z758aZ2+DKZHww/9uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPEyAasfB2TWnxHM6mEee/5y8PewapoBDgvq/CT6ycYfO/kpheQ02zZtPyvJyKopi/nuOwuPhVojPwwdoCoS9WDnly4WJGMPNOSPKnGXphlvHwTPu9WtDLjCI7nMiccOkDz+qnDcFzPitUbVo6IKScQp9+gJpeOFCKS9qLYzhjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNz8DOw5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNz8DOw5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so23596755ad.0
        for <kvm@vger.kernel.org>; Sun, 07 Jun 2026 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780819879; x=1781424679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxlUMIwlGQesl8B7Mf1wKdsN0uUMSbOOYMToVqO4zKQ=;
        b=fNz8DOw5/Ej50FuNFXldQZTvX7ewBYwCV9dVkM1V/VQhPQQMXyPS0jhuszMrHpPEjh
         AuMD7V/hKiJVmDihtNlqbyD0GCHwzJvTumA7YWWgB1YU6g0+/SyRFC+PiVb6fIL52QJ0
         T+ELeesqNEsYbb23AJfwJo2dlY1sf2Kb7ikE/G04vzheNcbE81C2BVt64/XYf3LYjNlm
         KWruLfYFhWL96Mc7by9FXpfFDP8lY5P7xO5H7KnUbmm9jzQLFzhhS9hog/MmBkvVtj9g
         WNnZrDtJxxsW7JZX62RiAU9fQZP+71gCVU6824P12NBxj7ri3iu4zqe1LqckWMn9JNFr
         DxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780819879; x=1781424679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxlUMIwlGQesl8B7Mf1wKdsN0uUMSbOOYMToVqO4zKQ=;
        b=HDXpFDTYj3fZpw4g6I73lnW8iTZFdUeYWDcQzJ6RVEx3r13MVuzgItc4Ua+SEl+H2o
         jyM8R9bpaNwEF2tzYZOtbYCzL31HhQfpMtNrSdtXdSfvMPEnXtq8KivR1SzQ6QORsL42
         Oiu/L8r98YyPjzS2HpF3jraGQRc2UxZuAGzjoXXCB8qxBMbnECccT5y1i94Kfie4vSnv
         Heof1OTrr4ZSLIG7Ij7NmxQOb18yK0x8JjJi/L7aawXS585K+s3Ihy4ek9fpnxw5Z4sM
         AGJorvF6u5XHnVdnPY7Ovqrpimd/Q/TsCgvxtEoEy/71uYpEEmHaAxZJp3EFupB2br8o
         KUVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cE9KO31+GjWfEuFg5WcD/mNOVh2vZigtr1iKywttULh1VKnUwzDn/Rwkq5srAoKfY+2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOvooWaAqsIxvBvtDaLkF2PI4Z67atEJyBAPMqmbH8FGh8HPpA
	sp3IbE8lgOouqRtZIYz7x5bO3rr+9zDeusYfEm/oKo6ttbmmdkIb4RYE
X-Gm-Gg: Acq92OF8K34DLwkIkoX1+iAAWafDbo5ObmvWh9wyEB6ryAf9yifxGkD+4h5Y7M88Cvm
	C9n45IfQ98SWVCqXv1MNpUhuRj3CfRtkgqW9nxEEryTIUuXGcr52u66vPZ0laITRDDp9Pz3AHTA
	8DxZMVwsmQXIVk+Bm97T200DjjNQ6Brq6MIUjNiWtgXhk/jIFbO45Wv9SSSBIL812h5ib1W5XfM
	7tS2/1kSFZ6Tom/w6KP68feCMNo43rsUq4zeCqR8A6AqIzLNGHI7W92hu5GY6MLkzsvKFZAhZD6
	gK57xXnAYcgszK6mJeEGnugiOypvRcvlFNBoCW4pQG/WjJlIQiNGHGK4+1FZ6PXN3p8YXo8utEH
	iAZwpRQH7BN+rp94voPhWRDc87rqFbRd3hpVR2wU7ZLlTG0XgWUBI1xwuxMJ7HyYsTyVPPMPsZy
	q6ftTN4er1h/qceeTlLvrhzMSoYJZ2VYuecw==
X-Received: by 2002:a17:902:ccc3:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2c1e80ec2abmr114527255ad.25.1780819879527;
        Sun, 07 Jun 2026 01:11:19 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm145520575ad.80.2026.06.07.01.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:11:19 -0700 (PDT)
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
	Deepak Gupta <debug@rivosinc.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v3 1/8] RISC-V: KVM: Add support for Svadu FWFT features
Date: Sun,  7 Jun 2026 16:10:57 +0800
Message-ID: <20260607081105.993908-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607081105.993908-1-inochiama@gmail.com>
References: <20260607081105.993908-1-inochiama@gmail.com>
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
2.54.0

