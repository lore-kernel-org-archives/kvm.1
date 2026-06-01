Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAFA34F462
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303442; cv=none; b=LfBnFn5lnW8t7tD/vmup3wjftUuPxmHZ3TU19zUrhGD+Twjv+3l/+icfECIkR2w+aYeb4E9jlGpteKQyA+e0XciBy6EPjN5dG/4Bj4nzsfgJJlsJWOni86wwwTo9PkGIBKo6XzEpjbBnEfax5DqQrdrCe+paFWE9JODrWXaYP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303442; c=relaxed/simple;
	bh=RTxTTusmwHBtYj40ntfpMb5fbqAkYBYXJYk7jt+gJYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxaubFUqzJX8ymQGavf/oJ+GIu+hx6Si4QtUNCox74cCWV3HL7e6f/yz1u3Q+yOKLkwHC9a5G556rsLRpfKKLazzV+h8pjmAqu9aY8b4oPeKd1Yr3s6lm5mOp1u9PO1kWAiF4xX29msmmlroLDPtqB/dcyuhAINXUurrLsizXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV9VF6LI; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV9VF6LI"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso2758447a91.1
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780303439; x=1780908239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0aaMax2/oVHcxkIeEgQqy6mX+q/RNO/BVNGIuJ0S4E=;
        b=OV9VF6LImMTXbRCH0gqo6VuSw+4G25dgpYx11XPRfWM+3gRT4rKhrIl++o7IVtfWoT
         638cHnO6Blbj4U4TninUqkBWSQghFVYpHow7EvYLG3Vkv3VasqYlwEdAR8HTUrBHmglw
         HfvYiRU1hNnhm5v5g/jVtorGvsNFPY2X7J0kqw5mYsZVUBAV/YDsvEez5QtwuhhtZ+r+
         BWIuuJL/GrfoaftvUyGCYD0TaUa8OuFPpObudJeo3/Wj0xvn/duyEVTWD6iacHZg04hU
         5Grjp0bcrOKrQtqfphjcH/B7pN9BMJvA3ofZc2tNBudzhNfESLL2T0jw7ySah3mRe3Jg
         ghNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303439; x=1780908239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0aaMax2/oVHcxkIeEgQqy6mX+q/RNO/BVNGIuJ0S4E=;
        b=UZOi1ShGfFv+qvjWrUXblP8aax+mn6f73BHNJxP03S+VlnU00xKfHevNeIUbf0sciH
         hpzmF26AiNBQBk9ExY389HFUFgbPnqRn1r9YiRioBgaY6FM/3gERfiFVl5bH6wv0BZMU
         AkhkaZb2eBOs8C5H/bTwx87R7r+tqqbyirrM8sIbIHyexN+s5k8DJ0/+CaG2jjtQdSpl
         /euj8UpK0eNxke+BF7+IxAd2OXSyZN5Y9XGsXERnuOAHSIsUZJ5jKZO4WYu+OfgwPh3o
         l/bgnqMU3vlllwfkeScMV3iXrQBJXhyGezFGKdlCmQJ94Ms0sFFqzUmVAYwVZRM4TuFU
         wQjw==
X-Forwarded-Encrypted: i=1; AFNElJ8SCSk/UI9pP9zi9GZPVnW6byZW9/xhbN7Snsq3iHphFu8P1aiNnve1+LfpuZ/9N3fMswQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQQJKDsYrH8mbIpfVsDlwD2P6WYRQ4jhhxNOehDdKY5WkzrAd
	HiTgqB+YDIBq1mRRdSLV9JmVMU5j5htnt5hQt5uMWPbM/XIUsx/ZxPhh
X-Gm-Gg: Acq92OFR4ej3QlIdbm1J8qwZJ4bE7KtCZZ3WCTYrbSy7bRZZZUkSN0PoP9ustn3cpEK
	DEr8IcZuAWUi+ln9jxNjFbxCP9mvRigJ8Yr8/I1ssYqfpDqdiGODE8AzojDPM4WM8j0FXwc/yO8
	wDPmCY1IGZVnkMRI4BNzJWyYN5JTwuY7WtDIzU1OaIsM3VX4+5GnPXyL+a/POTxWQZGDnJWWSjn
	FgI6UKImtupX0F9FCyLE/UUKHSNaW3Bq75EZAvp2wY3O7w/+Oesh3XnyboAviUij4+acNgFP9hM
	oRnma3TvKRZ46462vMpDyRgE70jAFyAgVE6vyaFuYwEkK0BlNI/auZGvMtk7PJsTwv6umX6zqtv
	Nhb/3U8jh6hr0aM/llq9FRtISAVk2QdJm2QdNLP3yDL4zW9LsrrhQRGNwIrc7bwMJHtYpRj83N1
	2nBCov0uoyJq/03Odl/BHOe1LlGz0YwBOsfQ==
X-Received: by 2002:a17:90b:2247:b0:367:d850:6a5f with SMTP id 98e67ed59e1d1-36c68478155mr9638126a91.25.1780303439454;
        Mon, 01 Jun 2026 01:43:59 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbdb6978fsm5733679a91.1.2026.06.01.01.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:43:59 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v2 1/7] RISC-V: KVM: Add support for Svadu FWFT features
Date: Mon,  1 Jun 2026 16:43:29 +0800
Message-ID: <20260601084336.2601675-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601084336.2601675-1-inochiama@gmail.com>
References: <20260601084336.2601675-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardware updating of PTE A/D bits is controlled through ADUE bit in
henvcfg Expose the feature only if the Svadu is supported for VS-mode.
Allow the VMM to block access to the feature by disabling the ISA
extension in the guest.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/uapi/asm/kvm.h |  3 ++
 arch/riscv/kvm/vcpu_sbi_fwft.c    | 72 +++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 504e73305343..501e4fc60dd2 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -240,6 +240,9 @@ struct kvm_riscv_sbi_fwft_feature {
 struct kvm_riscv_sbi_fwft {
 	struct kvm_riscv_sbi_fwft_feature misaligned_deleg;
 	struct kvm_riscv_sbi_fwft_feature pointer_masking;
+	struct kvm_riscv_sbi_fwft_feature pte_ad_hw_updating;
+	struct kvm_riscv_sbi_fwft_feature landing_pad;
+	struct kvm_riscv_sbi_fwft_feature shadow_stack;
 };
 
 /* If you need to interpret the index values, here is the key: */
diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index 2eab15339694..375269e43c13 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -84,6 +84,42 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
 	return false;
 }
 
+static void kvm_sbi_fwft_env_flag_reset_helper(struct kvm_vcpu *vcpu,
+					       unsigned long flag)
+{
+	vcpu->arch.cfg.henvcfg &= ~flag;
+}
+
+static long kvm_sbi_fwft_env_flag_set_helper(struct kvm_vcpu *vcpu,
+					     struct kvm_sbi_fwft_config *conf,
+					     bool one_reg_access,
+					     unsigned long value, unsigned long flag)
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
+	if (!one_reg_access)
+		csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
+
+	return SBI_SUCCESS;
+}
+
+static long kvm_sbi_fwft_env_flag_get_helper(struct kvm_vcpu *vcpu,
+					     struct kvm_sbi_fwft_config *conf,
+					     bool one_reg_access,
+					     unsigned long *value, unsigned long flag)
+{
+	*value = (vcpu->arch.cfg.henvcfg & flag) == flag;
+
+	return SBI_SUCCESS;
+}
+
 static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
 {
 	return misaligned_traps_can_delegate();
@@ -127,6 +163,33 @@ static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
 	return SBI_SUCCESS;
 }
 
+static bool kvm_sbi_fwft_pte_ad_hw_updating_supported(struct kvm_vcpu *vcpu)
+{
+	return riscv_isa_extension_available(vcpu->arch.isa, SVADU) &&
+		!riscv_isa_extension_available(vcpu->arch.isa, SVADE);
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
@@ -225,6 +288,15 @@ static const struct kvm_sbi_fwft_feature features[] = {
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

