Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A17233951
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783904633; cv=none; b=GFlVgDeKdfN681p/c45+g2MAV5l//ACWAqkRdv4iHYzhQIF7rZaEqk2P+b5dqfIjkwvv1AVypo3q6aShLOtmOywJ4ksAgDXleqOVqbELN0PPMm/vwpmQ2ka1A7gv/kBqu7RArDVra28FI73SA5UEUyWyPwnMcoQqefxV4Y8z+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783904633; c=relaxed/simple;
	bh=FH8Uhgh1pcvytIsiV9o2sHL0nTuhzb9K7bh5qTOi+jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyFIMbLuLk9L6MfQ1+peEiZ2B3K0gln1FPyhmqD+VLGoFXrezzXtAJ4MiVC8ve1Q5l90HvdMscwq2xStZ6bzuE0rANFJCda4odMSgqozXnr5kc4LkWcejPAvXgIiB2HY0b0iCqKUnvA2e7HD4aMA85jLCUu53gzfMgvLVT7Nyxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7nObPai; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7nObPai"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2362003a91.0
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783904631; x=1784509431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4wtNmoMKQodXeWiOSWDyChURk6Jt6lHeZLiT5bWjNnQ=;
        b=I7nObPaio6bAQg/MOnpS+vXRwvcEzZK6eTCeJ7BQqIuZGbDevBtUOlixJJbHoFhPDV
         bTTNdu/3cW2DB6bScE/gUcAAZQVGfrur5rkPDrrvauvXhRb0z0z28dj0ADji0laKQlu3
         SxPqLXMuorGXDyhnmEptqrX0upJAOKtxcUQe3EzAORyH6FtyR620ntv8BH0CO7117Zsh
         ybyfR0Uc/j2sIT16ZigB2Yz0unfzBKPEwaBZjFbxA98nrI/nz099aOwzEJMQr3ik2gbX
         50kWp+i8cZf3QTLE8uzS+6PVj9rdq7ZM3Dp0CRZZqfAoJsJ+WngLarxQ/d5B6IZOQUnU
         QQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783904631; x=1784509431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4wtNmoMKQodXeWiOSWDyChURk6Jt6lHeZLiT5bWjNnQ=;
        b=V/cg3OsgTpcsXOBMh2b6LtCRoPcshrmfK0Le/QbgTlcyE4WRPnyH5PCvqQkgoLoq0T
         8VDAI2YqlH1lMJhIUbVApSh58ffJRjwZd/6an6W1jIL/Wt56XrkNrG4jkSDOZpCJQKB7
         vWpvLhv7jW9TsAze736LU7ezMtXXltuOM1snY3tepHbdBeMw5mwMt5GYSGi2UYDDMa2A
         E3qormZ9hjdlCOLItjzX+T0D5tdLYWjuj3KdteeibDZZd+7aNdEQNBNpZAfxg07nO40K
         z1TV+WKKoagEuwoVFygCS32ewjgKPdqDgHVZgqg49TTfKJgVi5Jq+TvP3/6wOvruU0je
         CxiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp72maBoCCEf3+cWhAwoIi8PBl5BtEKVnRk7ZodYPlbk8G2O8vrPiktnc/OW2r51U8Wq6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YywemkHsbuTzzs3pw/LgjUBOo7LahOJG4dCjxaBPsDlgHwO1Q5g
	Ncx1uilHlAlqMAxSoqK8hF/9wKbF1zM9E40sbiQV/6QQ0acvwSMp+qNu
X-Gm-Gg: AfdE7clJbhXV8UazQzWTfV2oTOZzcQ2cHLLvU3SCudcfwEAvPskyLACamdRzuBJvLBn
	kOslNcWkLhyOdkwoXcY8W3pUc684Z3SZZZaOr2TjwsohxXEtLt45N50kswi2H0P/EboBZkmLBxk
	W2hnT19Op4TdnZ3D8bvNRHwbFzuwrzlpbDApuR2h7sJh1Hp4mKooQGZ8NM33RsWUELjDnhC5s1K
	LUDwUG6ZipZ2l/ZyB9J8oJmBdD8Bkiln0dbeLABhQGPZR2t+opXgW3lZJwcAMKDH2S8Whmu6xkz
	9XSU00QbNj2L2DW+dIt5EpVWHreMVJsavcpu/CSXk37OwhNE3EBuJxZB7EfqE5O1qcvFc2Zk/a9
	45KfgjFN25V9qaL++uLJVaVIWTqKk6+ZMWKwcK6PdnaSJ7dmBibGNFgE7si3aK1B+3J+YmHPTUR
	TQe6lTgut4gVo=
X-Received: by 2002:a17:90b:47:b0:37e:b6a:6cdf with SMTP id 98e67ed59e1d1-38dc77ee830mr7343814a91.20.1783904631435;
        Sun, 12 Jul 2026 18:03:51 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55a47286sm5549380a91.10.2026.07.12.18.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:03:51 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Andy Chiu <andybnac@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Thomas Huth <thuth@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v6 1/8] RISC-V: KVM: Add support for Svadu FWFT features
Date: Mon, 13 Jul 2026 09:02:54 +0800
Message-ID: <20260713010302.303278-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713010302.303278-1-inochiama@gmail.com>
References: <20260713010302.303278-1-inochiama@gmail.com>
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
 arch/riscv/kvm/vcpu_sbi_fwft.c    | 76 +++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

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
index ab39ac464ffd..4d474a439b29 100644
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
@@ -137,6 +176,34 @@ static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
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
@@ -246,6 +313,15 @@ static const struct kvm_sbi_fwft_feature features[] = {
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

