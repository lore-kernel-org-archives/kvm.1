Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145837D12E
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304514; cv=none; b=qT9uGs7CHQYGSwYUBsJmq35sMNWbpInlkUATLTn3LwSzTU8E7DfNCfzqX9i3pxuUwVbOGWOeZ3pB9v17TugqK66wNxZSFhoyOJkITL1DcsHgXGg3dbKBd9VHIc4ygfb07XyK5tTEkpJsOoqBw6rH0+O2mY4ncyIxIgfT17VVsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304514; c=relaxed/simple;
	bh=qtYETt9eSUder8hy7hY8m5n00M4lkiJsEDAC//Xe8f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUevAzU82LfmFo5u37ELzQBev6Eb3bukaCbggPa7EUQ/MbLcbQl5GMEXY61GsH6psoFuhuv2sy4t38F5hZcI05GXcupWHbDpS84Aw58ufvshNzxquwfAif3ht5fY5mI7ChkaPfMi2QJfkLq3jbm20w7w5rS5pZS2L3TAZdiF45c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHLsV2I/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHLsV2I/"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-845c92bc464so1591686b3a.2
        for <kvm@vger.kernel.org>; Sun, 05 Jul 2026 19:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783304511; x=1783909311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ShPHOlhN1u5tvpzPZGQiz8nFEPzIrEgLjUdaX/pyxM=;
        b=GHLsV2I/1lKTQNF0mqPhIdL11YfkrBwCdWngdYTuRqfJQA2ubdTFcJ8o94qHY7RKe3
         Pm9W+vP/yBxqYWYKp/UaJFsi+iqzc83UW8YHj30fzvBC5wL7g195SGlOjX+gVa5RPHtC
         lW/tHggv3vdM39pX64hc/McO+HWBW1AXXr2u68+j2foPxlF0ZE8uApCkBUH9NcWBZcoO
         4rIA6xDmqyhg4EuCOHFa9LYMk/8scAG5Ws1nwchn6Y4CXcC/KjNxR6OO6K7jHFXHNOMp
         z60DBtNsndaTIn9bdqQXguxmRLIu9RcgbKe6nUmu96Jz+Q4u0YrTREEF3uzkqojmHB6U
         yKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783304511; x=1783909311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ShPHOlhN1u5tvpzPZGQiz8nFEPzIrEgLjUdaX/pyxM=;
        b=NRZ/4LURKfy11d6o5ZE5taYXWeILn6GAPpNrEOe/JfSo1s1WCAM2GBCtZaBGXvwe5U
         H+G5121Txi3l/OxdDRuAi5t2o9xmObl7n8MWAq9wxZq50EezT+oxTpAoDiyhRfSEEmod
         dLV3OhbtpAXay9jBbEdpRVnRG4Gk6m7Uv082pkAmlj0y8+D/EP8ohr6NjSnuBgU+Xju1
         n32LumVcdWAgzCGsZOyr+xDMXIfZxNIqTEIs+2Fp68SJ6D9LMeBHD6TPj2uRNoBUihme
         kBlSQSZC2VaglyIw56mqNbcP3jUbMbFFbcXXK2mVShuKt21BUb6pnxeO06KlkxuBpaT7
         nnrA==
X-Forwarded-Encrypted: i=1; AHgh+RohrEf6d62rGKC9Qp5bdYB2aNjts+p1x+tSLxWQ2QQEyHsZcrTI5vOrSpwFwBbYN6wqfk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeWaULFhwqhbiHwJJspwEtHy1vJzDPOuWRDhwKkhSKHvFSAEja
	/iqnQ+XaGJcbRnvpDifznx+lNUL6n3f0a1jX7beEsKr05mqtkegZoxhC
X-Gm-Gg: AfdE7clm7SjnNYQQae+W+rNi3aBOlSfdjj18sVE1m51CdCFUGGRiab8MRJ+PavrrlLe
	DEn7zxZERsKPfL0PLX/M7+6LjInBOvm8r41dxfaaBtWa5PD95kPFbje1FC0j4ucKVDl1xw/elYx
	rURdDI6qHsunrDS0oj3kAXxxwNzVp6vcPAGVSMisM3cSGw8qiXOTgrFLKHc2s2CKny8ww3/ATfy
	JZF2DDjzmr4aKuDdYtc3BsRdq34dxu1ejVQSkRHYEmr5NU5hWGhakWWXILkNJbDuYiMdb+yuX2+
	EvsGehjkdMu6ImxUdv7qyML/yVmQ6uN6LeeW3JjocLY54r03ei+6qAwqWwx3zb5x4j9ArSiXHc5
	0DUmDie08HXOFiEzudKYGnefhBpEPwGGv8UnE7RkiZ2DB2RFcrTFWV2vrjLZaBfEX
X-Received: by 2002:a05:6a00:2304:b0:847:77ae:8845 with SMTP id d2e1a72fcca58-847f6f4740dmr7187750b3a.44.1783304511273;
        Sun, 05 Jul 2026 19:21:51 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b93f8csm3036476b3a.19.2026.07.05.19.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 19:21:50 -0700 (PDT)
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
Subject: [PATCH v5 8/8] KVM: riscv: selftests: add Zicfiss/Zicfilp extension to get-reg-list test
Date: Mon,  6 Jul 2026 10:20:44 +0800
Message-ID: <20260706022046.214956-9-inochiama@gmail.com>
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

The KVM RISC-V allows Zicfiss/Zicfilp extensions for Guest/VM so
add these extensions to get-reg-list test.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 94e33b2ee796..49a4be825031 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -90,6 +90,8 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOP:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOZ:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICCRSE:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICFILP:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICFISS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICNTR:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICOND:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICSR:
@@ -358,6 +360,8 @@ static const char *core_id_to_str(const char *prefix, __u64 id)
 	"KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_REG(" #csr ")"
 #define RISCV_CSR_SMSTATEEN(csr) \
 	"KVM_REG_RISCV_CSR_SMSTATEEN | KVM_REG_RISCV_CSR_REG(" #csr ")"
+#define RISCV_CSR_ZICFISS(csr) \
+	"KVM_REG_RISCV_CSR_ZICFISS | KVM_REG_RISCV_CSR_REG(" #csr ")"
 
 static const char *general_csr_id_to_str(__u64 reg_off)
 {
@@ -425,6 +429,18 @@ static const char *smstateen_csr_id_to_str(__u64 reg_off)
 	return NULL;
 }
 
+static const char *zicfiss_csr_id_to_str(__u64 reg_off)
+{
+	/* reg_off is the offset into struct kvm_riscv_zicfiss_csr */
+	switch (reg_off) {
+	case KVM_REG_RISCV_CSR_ZICFISS_REG(ssp):
+		return RISCV_CSR_ZICFISS(ssp);
+	}
+
+	TEST_FAIL("Unknown zicfiss csr reg: 0x%llx", reg_off);
+	return NULL;
+}
+
 static const char *csr_id_to_str(const char *prefix, __u64 id)
 {
 	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_CSR);
@@ -441,6 +457,8 @@ static const char *csr_id_to_str(const char *prefix, __u64 id)
 		return aia_csr_id_to_str(reg_off);
 	case KVM_REG_RISCV_CSR_SMSTATEEN:
 		return smstateen_csr_id_to_str(reg_off);
+	case KVM_REG_RISCV_CSR_ZICFISS:
+		return zicfiss_csr_id_to_str(reg_off);
 	}
 
 	return strdup_printf("%lld | %lld /* UNKNOWN */", reg_subtype, reg_off);
@@ -585,6 +603,8 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(ZICBOP),
 		KVM_ISA_EXT_ARR(ZICBOZ),
 		KVM_ISA_EXT_ARR(ZICCRSE),
+		KVM_ISA_EXT_ARR(ZICFILP),
+		KVM_ISA_EXT_ARR(ZICFISS),
 		KVM_ISA_EXT_ARR(ZICNTR),
 		KVM_ISA_EXT_ARR(ZICOND),
 		KVM_ISA_EXT_ARR(ZICSR),
@@ -748,6 +768,12 @@ static const char *sbi_fwft_id_to_str(__u64 reg_off)
 	case 6: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.enable)";
 	case 7: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.flags)";
 	case 8: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value)";
+	case 9: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.enable)";
+	case 10: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.flags)";
+	case 11: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.value)";
+	case 12: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.enable)";
+	case 13: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.flags)";
+	case 14: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.value)";
 	}
 	return strdup_printf("KVM_REG_RISCV_SBI_FWFT | %lld /* UNKNOWN */", reg_off);
 }
@@ -954,6 +980,20 @@ static __u64 sbi_fwft_pte_ad_hw_updating_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value),
 };
 
+static __u64 sbi_fwft_landing_pad_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.enable),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.flags),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.value),
+};
+
+static __u64 sbi_fwft_shadow_stack_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.enable),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.flags),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.value),
+};
+
 static __u64 zicbom_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(zicbom_block_size),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOM,
@@ -969,6 +1009,11 @@ static __u64 zicboz_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOZ,
 };
 
+static __u64 zicfiss_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_ZICFISS | KVM_REG_RISCV_CSR_ZICFISS_REG(ssp),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICFISS,
+};
+
 static __u64 aia_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1),
@@ -1220,6 +1265,8 @@ KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicbop, ZICBOP);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicboz, ZICBOZ);
 KVM_ISA_EXT_SIMPLE_CONFIG(ziccrse, ZICCRSE);
+KVM_ISA_EXT_SIMPLE_CONFIG(zicfilp, ZICFILP);
+KVM_ISA_EXT_SUBLIST_CONFIG(zicfiss, ZICFISS);
 KVM_ISA_EXT_SIMPLE_CONFIG(zicntr, ZICNTR);
 KVM_ISA_EXT_SIMPLE_CONFIG(zicond, ZICOND);
 KVM_ISA_EXT_SIMPLE_CONFIG(zicsr, ZICSR);
@@ -1279,6 +1326,24 @@ static struct vcpu_reg_list config_sbi_fwft_pte_ad_hw_updating = {
 	},
 };
 
+static struct vcpu_reg_list config_sbi_fwft_landing_pad = {
+	.sublists = {
+		SUBLIST_BASE,
+		SUBLIST_ISA(zicfilp, ZICFILP),
+		SUBLIST_SBI(fwft_landing_pad, FWFT),
+		{0},
+	},
+};
+
+static struct vcpu_reg_list config_sbi_fwft_shadow_stack = {
+	.sublists = {
+		SUBLIST_BASE,
+		SUBLIST_ISA(zicfiss, ZICFISS),
+		SUBLIST_SBI(fwft_shadow_stack, FWFT),
+		{0},
+	},
+};
+
 struct vcpu_reg_list *vcpu_configs[] = {
 	&config_sbi_base,
 	&config_sbi_sta,
@@ -1289,6 +1354,8 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_sbi_fwft_misaligned_deleg,
 	&config_sbi_fwft_pointer_masking,
 	&config_sbi_fwft_pte_ad_hw_updating,
+	&config_sbi_fwft_landing_pad,
+	&config_sbi_fwft_shadow_stack,
 	&config_aia,
 	&config_fp_f,
 	&config_fp_d,
@@ -1332,6 +1399,8 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zicbop,
 	&config_zicboz,
 	&config_ziccrse,
+	&config_zicfilp,
+	&config_zicfiss,
 	&config_zicntr,
 	&config_zicond,
 	&config_zicsr,
-- 
2.55.0

