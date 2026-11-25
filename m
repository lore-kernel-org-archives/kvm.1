Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621251;
	b=YnHHVn5cwqLFj1vKRHEfJtrxDtcKq4GlkAjIXAeO6MXlN9uhI4HqjSA1de1qwkasFl0C
	 +xS6JM9HbBhSE+Vgv1kqfzlppp9au/2oInOBv1UmzVrJhBbwrZTJeHYO9zFnVZWtbkEwb
	 ZzlvCoXJWE2At7vcq3jaD2dO4HxT0uq3MThcVuP8HJD0432kWkPAjtNx7P2v05UNaSZMz
	 EALx2PkUWr9CmeZNIaJdi0SNWA0zo+m8LK06jPcZ5pTlqqTd4vkYnNOvjHQpDvXSFrFDi
	 NWb58EVGOtBlAWkothibTNfU5MnRRy9/5hZ0EsqJfo4AjXpFnqmIw+73PbiXuNfaexw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621251;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ptwHPUcEo7xWDRw6xCl2vxefKLRbA86AY4IfVUAqty8=;
	b=CsVpL9mvuaDUDDCgtjRCEqamih402KIafiakX07oE7tTmMye8YJFgvzW8uocNbiUg/VP
	 lvwqu9kJd/Un/PwiwCKlV+5LctvEfiCGeqFPtoywtMiRjUNfBTke121uGqdc53ECsCJHR
	 ducKbPmA3x3PqFSpWNHCblTsGHbVzOZR0QaAK/exabHU+Zv4L9rq2ATLpGxsnXMenWUYg
	 3vISKf52/jQVfzS5tf7bQfN32i6ihfdZRmm1N8t/K62OJUzTD2BJoa1YCA9q+qnjTpmiQ
	 Bk2XCyUrb4gSC6sqdG0LXGH/vHlXtDCHXh5u4h4R0G6+kbG9dOImixW9b8HePTE9WHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ug7JkI7b;
	arc=none smtp.remote-ip=91.218.175.190
Received: from mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2114606A68E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2114606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ug7JkI7b
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RVnzIkMmrnK+2pDIKdojWsNP5HskZeJ9p5evhdP1FRE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795621247; v=1; x=1796226047;
 b=Ug7JkI7ba135g42jsOR+kQ59z940US29UZV6UdWVtlaTeXiXbchqicwLU1nJvPv/yRCIU51f
 ps7gBA90p3oRdYFCQpiBxiTkucah01l2ur1o8IScQSHA1NHInGNuhv6QOjm6F+vq8moNWGC99Vx
 UowlrX03RskNMNcDV9xztYmM=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 97e0f5aa51df20aa;
	Wed, 25 Nov 2026 15:40:47 +0000
X-Mizu-Trace-ID: 97e0f5aa51df20aa
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
Subject: [PATCH v2 16/20] KVM: arm64: Advertise FAMINMAX, LSFE, LSUI and FPRCVT to protected VMs
Date: Wed, 25 Nov 2026 15:39:07 +0000
Message-ID: <20261125153911.106793-17-fuad.tabba@linux.dev>
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

Advertise FEAT_FAMINMAX, FEAT_LSFE, FEAT_LSUI and FEAT_FPRCVT to
protected VMs, the ID_AA64ISAR3_EL1 fields a non-protected VM sees.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/include/asm/kvm_hyp.h   |  1 +
 arch/arm64/kvm/arm.c               |  1 +
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 13 ++++++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index ab22b395d0908..fa9a99cae32a7 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -148,6 +148,7 @@ extern u64 kvm_nvhe_sym(id_aa64zfr0_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64isar0_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64isar1_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64isar2_el1_sys_val);
+extern u64 kvm_nvhe_sym(id_aa64isar3_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr2_el1_sys_val);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 71afc5a5c9346..e363e8b5958fb 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2837,6 +2837,7 @@ static void kvm_hyp_init_symbols(void)
 	kvm_nvhe_sym(id_aa64isar0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR0_EL1);
 	kvm_nvhe_sym(id_aa64isar1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR1_EL1);
 	kvm_nvhe_sym(id_aa64isar2_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR2_EL1);
+	kvm_nvhe_sym(id_aa64isar3_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR3_EL1);
 	kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 	kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
 	kvm_nvhe_sym(id_aa64mmfr2_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 2c22317a76a5e..129a6b89a232d 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -27,6 +27,7 @@ u64 id_aa64zfr0_el1_sys_val;
 u64 id_aa64isar0_el1_sys_val;
 u64 id_aa64isar1_el1_sys_val;
 u64 id_aa64isar2_el1_sys_val;
+u64 id_aa64isar3_el1_sys_val;
 u64 id_aa64mmfr0_el1_sys_val;
 u64 id_aa64mmfr1_el1_sys_val;
 u64 id_aa64mmfr2_el1_sys_val;
@@ -222,6 +223,14 @@ static const struct pvm_ftr_bits pvmid_aa64isar2[] = {
 	FEAT_END
 };
 
+static const struct pvm_ftr_bits pvmid_aa64isar3[] = {
+	MAX_FEAT(ID_AA64ISAR3_EL1, FAMINMAX, IMP),
+	MAX_FEAT(ID_AA64ISAR3_EL1, LSFE, IMP),
+	MAX_FEAT(ID_AA64ISAR3_EL1, LSUI, IMP),
+	MAX_FEAT(ID_AA64ISAR3_EL1, FPRCVT, IMP),
+	FEAT_END
+};
+
 /* DoubleLock and MTPMU are hidden, but their Not-Implemented values are non-zero. */
 static const struct pvm_ftr_bits pvmid_aa64dfr0[] = {
 	MAX_FEAT(ID_AA64DFR0_EL1, DebugVer, V8P8),
@@ -288,6 +297,8 @@ static u64 pvm_calc_id_reg(const struct kvm_vcpu *vcpu, u32 id)
 		return get_restricted_features(vcpu, id_aa64isar1_el1_sys_val, pvmid_aa64isar1);
 	case SYS_ID_AA64ISAR2_EL1:
 		return get_restricted_features(vcpu, id_aa64isar2_el1_sys_val, pvmid_aa64isar2);
+	case SYS_ID_AA64ISAR3_EL1:
+		return get_restricted_features(vcpu, id_aa64isar3_el1_sys_val, pvmid_aa64isar3);
 	case SYS_ID_AA64MMFR0_EL1:
 		return get_restricted_features(vcpu, id_aa64mmfr0_el1_sys_val, pvmid_aa64mmfr0);
 	case SYS_ID_AA64MMFR1_EL1:
@@ -721,7 +732,7 @@ static const struct sys_reg_desc pvm_sys_reg_descs[] = {
 	AARCH64(SYS_ID_AA64ISAR0_EL1),
 	AARCH64(SYS_ID_AA64ISAR1_EL1),
 	AARCH64(SYS_ID_AA64ISAR2_EL1),
-	ID_UNALLOCATED(6,3),
+	AARCH64(SYS_ID_AA64ISAR3_EL1),
 	ID_UNALLOCATED(6,4),
 	ID_UNALLOCATED(6,5),
 	ID_UNALLOCATED(6,6),
-- 
2.47.3

