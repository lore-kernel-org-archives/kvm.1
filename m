Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621228;
	b=3h3qOcl1cUtiKGB5bHKXWGsqfG58Nhvm8/RX4INANNmzK6qtHs6yMyNVcaZ5QLxSrZwV
	 8JCoGTdBo2aycj4Gk/GSvHuD2FNdMy0/m/EuOGNtBSKZ/2QZkRA9DXEnu8N9G/83qdmhl
	 YOaa9by9eZxwhxyv132iC0XA08sa4UkFJ5qMrJY6MV5rHmUZce5JI7JmvszZ/sJTs8b83
	 6bheqsEDoeQl9uHSlhWSctyGkXP6PHjQ6ucuR+O/MiO0IekH/IXkQcsTK7DO9caQSS14p
	 ntiLhv+T07CaKb9N5Q+MqZLjoni/Ajdwo9np48qeK/8frQvn7RDaYuCUzI4l6/lFk9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621228;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qGdCpnc7tSNkp+/hq+v+wVlfJc/jxdnMsSqXuvQBh+I=;
	b=OlZFK7FS9bYhf1A0qWowr3Jdof3aIFZL4K35J7oejpiMENwndWcInKW+XjnH4lvsUddq
	 3b0n8Df6eRGw158FFVJBOWhtEth63p4oI3Rltqi5CRtjx/LwfHt0rc7Edfpxqt8tqY56r
	 D9H186c6CDY8N9aCdJqLvDoRIeIMnChMXPG9OcmLAlzvCbH5uwDZOyqss4gxfGVucpWFO
	 J4pmMMWNUsAqH+ET+yr17PEXi+Zu2oPHgFWIwu3wH1aiB67dl8BZ/zqhRZn8yRK5m1F1a
	 6ukvA8JIxfrqdcL53HuvXdo7e4oUAvhURZdJl+uUf0gt1FcyXzvuW5kSORGcjuVEh8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=REaWDlPg;
	arc=none smtp.remote-ip=95.215.58.150
Received: from mta1.migadu.com (out-150.mta1.migadu.com [95.215.58.150])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156960A263D
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6156960A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=REaWDlPg
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lb8BBu6vkMdX5G7iUnn28ZdhIQyxfI2a7cuVlYmS8Uk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795621223; v=1; x=1796226023;
 b=REaWDlPgaaxEsy/J1WtooAUZm4ymW7XTsrHExh8GJ/RUnGZqQf5q5cVBGcUSQSxPyW/QoxEY
 6uuZUrB/urAuR0ExNcjEOLWizShD8u2mL31UcjpE4hjuWo0TD9ToUxLdO8UwFrW0aFgE310ywhI
 Kpgk4poMETMBSO8U+1gK3Ky0=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aac5ae651e0d1d96;
	Wed, 25 Nov 2026 15:40:21 +0000
X-Mizu-Trace-ID: aac5ae651e0d1d96
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/20] KVM: arm64: Advertise TCR2, SCTLR2, S1PIE and S1POE to protected VMs
Date: Wed, 25 Nov 2026 15:39:03 +0000
Message-ID: <20261125153911.106793-13-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125153911.106793-1-fuad.tabba@linux.dev>
References: <20261125153911.106793-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise FEAT_TCR2, FEAT_SCTLR2, FEAT_S1PIE and FEAT_S1POE to
protected VMs, with S1POE only when the kernel supports POE, as EL2
doesn't switch the POE registers otherwise. With the fields set,
vcpu_set_hcrx() sets HCRX_EL2.{TCR2En,SCTLR2En} for them, and since
the previous patch their PIE and POE registers don't trap.

Reset the new registers as KVM does for a non-protected vCPU.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/include/asm/kvm_hyp.h   |  1 +
 arch/arm64/kvm/arm.c               |  1 +
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 24 +++++++++++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 920c1d8d45b1a..ab22b395d0908 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -151,6 +151,7 @@ extern u64 kvm_nvhe_sym(id_aa64isar2_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr2_el1_sys_val);
+extern u64 kvm_nvhe_sym(id_aa64mmfr3_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64smfr0_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64dfr0_el1_sys_val);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 3b4bc646d894a..71afc5a5c9346 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2840,6 +2840,7 @@ static void kvm_hyp_init_symbols(void)
 	kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 	kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
 	kvm_nvhe_sym(id_aa64mmfr2_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
+	kvm_nvhe_sym(id_aa64mmfr3_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR3_EL1);
 	kvm_nvhe_sym(id_aa64smfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64SMFR0_EL1);
 	kvm_nvhe_sym(id_aa64dfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
 	kvm_nvhe_sym(__icache_flags) = __icache_flags;
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 0a536b237a7c9..4f13b100007fa 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -30,6 +30,7 @@ u64 id_aa64isar2_el1_sys_val;
 u64 id_aa64mmfr0_el1_sys_val;
 u64 id_aa64mmfr1_el1_sys_val;
 u64 id_aa64mmfr2_el1_sys_val;
+u64 id_aa64mmfr3_el1_sys_val;
 u64 id_aa64smfr0_el1_sys_val;
 u64 id_aa64dfr0_el1_sys_val;
 
@@ -83,6 +84,11 @@ static bool vm_has_sve(const struct kvm *kvm)
 	return system_supports_sve() && kvm_vcpu_has_feature(kvm, KVM_ARM_VCPU_SVE);
 }
 
+static bool vm_has_s1poe(const struct kvm *kvm)
+{
+	return system_supports_poe();
+}
+
 /*
  * Definitions for features to be allowed or restricted for protected guests.
  *
@@ -176,6 +182,14 @@ static const struct pvm_ftr_bits pvmid_aa64mmfr2[] = {
 	FEAT_END
 };
 
+static const struct pvm_ftr_bits pvmid_aa64mmfr3[] = {
+	MAX_FEAT(ID_AA64MMFR3_EL1, TCRX, IMP),
+	MAX_FEAT(ID_AA64MMFR3_EL1, SCTLRX, IMP),
+	MAX_FEAT(ID_AA64MMFR3_EL1, S1PIE, IMP),
+	MAX_FEAT_FUNC(ID_AA64MMFR3_EL1, S1POE, IMP, vm_has_s1poe),
+	FEAT_END
+};
+
 static const struct pvm_ftr_bits pvmid_aa64isar1[] = {
 	MAX_FEAT(ID_AA64ISAR1_EL1, DPB, DPB2),
 	MAX_FEAT_FUNC(ID_AA64ISAR1_EL1, APA, PAuth, vm_has_ptrauth),
@@ -273,6 +287,8 @@ static u64 pvm_calc_id_reg(const struct kvm_vcpu *vcpu, u32 id)
 		return get_restricted_features(vcpu, id_aa64mmfr1_el1_sys_val, pvmid_aa64mmfr1);
 	case SYS_ID_AA64MMFR2_EL1:
 		return get_restricted_features(vcpu, id_aa64mmfr2_el1_sys_val, pvmid_aa64mmfr2);
+	case SYS_ID_AA64MMFR3_EL1:
+		return get_restricted_features(vcpu, id_aa64mmfr3_el1_sys_val, pvmid_aa64mmfr3);
 	case SYS_ID_AA64DFR0_EL1:
 		return get_restricted_features(vcpu, id_aa64dfr0_el1_sys_val, pvmid_aa64dfr0);
 	case SYS_ID_AA64MMFR4_EL1:
@@ -706,7 +722,7 @@ static const struct sys_reg_desc pvm_sys_reg_descs[] = {
 	AARCH64(SYS_ID_AA64MMFR0_EL1),
 	AARCH64(SYS_ID_AA64MMFR1_EL1),
 	AARCH64(SYS_ID_AA64MMFR2_EL1),
-	ID_UNALLOCATED(7,3),
+	AARCH64(SYS_ID_AA64MMFR3_EL1),
 	ID_UNALLOCATED(7,4),
 	ID_UNALLOCATED(7,5),
 	ID_UNALLOCATED(7,6),
@@ -792,7 +808,13 @@ static const struct sys_reg_desc_reset pvm_sys_reg_reset_vals[] = {
 	RESET_ZERO(CPACR_EL1),
 	RESET_VAL(CONTEXTIDR_EL1, 0x00000000dbadc0deULL),
 	RESET_VAL(SCTLR_EL1, 0x00C50078ULL),
+	RESET_ZERO(SCTLR2_EL1),
 	RESET_ZERO(TCR_EL1),
+	RESET_ZERO(TCR2_EL1),
+	RESET_UNKNOWN(PIR_EL1),
+	RESET_UNKNOWN(PIRE0_EL1),
+	RESET_UNKNOWN(POR_EL1),
+	RESET_UNKNOWN(POR_EL0),
 	RESET_UNKNOWN(AFSR0_EL1),
 	RESET_UNKNOWN(AFSR1_EL1),
 	RESET_UNKNOWN(ESR_EL1),
-- 
2.47.3

