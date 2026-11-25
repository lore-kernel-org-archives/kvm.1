Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621261;
	b=41lpwcST1m8nr3QQwrklnFnbsmN0v4JEZQpqK4vtXWQYIu/9JAKkSwTjWZ80sAPbRSiR
	 XknzxL/G85XsvjMHUYznkma2xZDLoxvFL4pocKeuYjov5gsC7impE3dVGHHsJ1UTutg81
	 hKI4M9LRKE12jFR0Hvfp/ubA8TEPupbQfueQHT0JbaqPXfuZjcZSWuxOQOphlbE9x6EIf
	 48PqChAvSLb+BmpNGM3W5SRJ3AzEbYtduULoeoG4ks/O3Y9z0pPq4skqqLB2erkh72H7h
	 KdQGBVgy1Gyd6kA6/SBLDw4SbotgDHopiGJ4rHsbWpo4LNOUrzDpVF8J8V8lw2JIOFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621261;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mzsSnVFmueVAmxucWap/1diLt/xkb4/Iudj0Azmpcto=;
	b=YffnLpg/qNcbQAQSi7uXX4TZi97noJAFuKTsGYgG6Brm/UiRmIxAoAUC8GO5yYrDAOLI
	 yMCWRYaCspaxl4VNqIWt1uCKhGaF63ufnyatbsw4fmbBIJe1/cE99bOUV6C6y1dx3I2zk
	 FwaPlBLEHIvToSjaQ3BqtdxXL8634WaUQAZSU4fPRlBh2n0t8OGw0/LFNVa1ugcWcUmTe
	 JvjMzdsnwHRR+2iyqiIJFHMqIDm6n7ftypBMyrbYcvPkQugP2+AjqK7GPW8RbbNQTwT0w
	 qkVjADZXp55BUfpraUijtUwru8nr+hKrWDFUKv4XcxWTRJQH9cw0oa6xXedAYKYfzow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GB68hZxD;
	arc=none smtp.remote-ip=95.215.58.231
Received: from mta1.migadu.com (out-231.mta1.migadu.com [95.215.58.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E1606A6A0
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 864E1606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GB68hZxD
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nUFxnpIOM1wpWH0/JGGRjQFQhyZ2Sfp/JeawXNUQhRc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795621258; v=1; x=1796226058;
 b=GB68hZxDejEmlmEobgOXOcO/OanROYasrc6Y/sN82THyrmf2idGu3vxks4iI26bqOZ4msDFU
 ZQw4McuPQsHP/Kpo4VWHSeGT/d4D83f6umf90qnZONpgYzu0RLjIrHtSp0/zve5JPyqNCJdpgcz
 TM/Zra/HPk8TzpHHSYALCTTw=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aa3c62e7ebe12e60;
	Wed, 25 Nov 2026 15:40:58 +0000
X-Mizu-Trace-ID: aa3c62e7ebe12e60
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
Subject: [PATCH v2 19/20] KVM: arm64: Advertise FP8 and F16MM to protected VMs
Date: Wed, 25 Nov 2026 15:39:10 +0000
Message-ID: <20261125153911.106793-20-fuad.tabba@linux.dev>
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

Advertise the FP8 features and FEAT_F16MM to protected VMs, the
ID_AA64FPFR0_EL1 fields a non-protected VM sees. Their instructions
only use the SIMD&FP registers and FPMR, which EL2 already switches.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/include/asm/kvm_hyp.h   |  1 +
 arch/arm64/kvm/arm.c               |  1 +
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 18 +++++++++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index fa9a99cae32a7..09b19f2c3c090 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -145,6 +145,7 @@ extern u64 kvm_nvhe_sym(id_aa64pfr0_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64pfr1_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64pfr2_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64zfr0_el1_sys_val);
+extern u64 kvm_nvhe_sym(id_aa64fpfr0_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64isar0_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64isar1_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64isar2_el1_sys_val);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e363e8b5958fb..5dbe66de4f05e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2834,6 +2834,7 @@ static void kvm_hyp_init_symbols(void)
 	kvm_nvhe_sym(id_aa64pfr1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);
 	kvm_nvhe_sym(id_aa64pfr2_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64PFR2_EL1);
 	kvm_nvhe_sym(id_aa64zfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ZFR0_EL1);
+	kvm_nvhe_sym(id_aa64fpfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64FPFR0_EL1);
 	kvm_nvhe_sym(id_aa64isar0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR0_EL1);
 	kvm_nvhe_sym(id_aa64isar1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR1_EL1);
 	kvm_nvhe_sym(id_aa64isar2_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR2_EL1);
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index dc7c70ac46f2a..4b95128663aa8 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -24,6 +24,7 @@ u64 id_aa64pfr0_el1_sys_val;
 u64 id_aa64pfr1_el1_sys_val;
 u64 id_aa64pfr2_el1_sys_val;
 u64 id_aa64zfr0_el1_sys_val;
+u64 id_aa64fpfr0_el1_sys_val;
 u64 id_aa64isar0_el1_sys_val;
 u64 id_aa64isar1_el1_sys_val;
 u64 id_aa64isar2_el1_sys_val;
@@ -148,6 +149,19 @@ static const struct pvm_ftr_bits pvmid_aa64zfr0[] = {
 	FEAT_END
 };
 
+static const struct pvm_ftr_bits pvmid_aa64fpfr0[] = {
+	MAX_FEAT(ID_AA64FPFR0_EL1, F8E5M2, IMP),
+	MAX_FEAT(ID_AA64FPFR0_EL1, F8E4M3, IMP),
+	MAX_FEAT(ID_AA64FPFR0_EL1, F16MM2, IMP),
+	MAX_FEAT(ID_AA64FPFR0_EL1, F8MM4, IMP),
+	MAX_FEAT(ID_AA64FPFR0_EL1, F8MM8, IMP),
+	MAX_FEAT(ID_AA64FPFR0_EL1, F8DP2, IMP),
+	MAX_FEAT(ID_AA64FPFR0_EL1, F8DP4, IMP),
+	MAX_FEAT(ID_AA64FPFR0_EL1, F8FMA, IMP),
+	MAX_FEAT(ID_AA64FPFR0_EL1, F8CVT, IMP),
+	FEAT_END
+};
+
 static const struct pvm_ftr_bits pvmid_aa64mmfr0[] = {
 	MAX_FEAT_ENUM(ID_AA64MMFR0_EL1, PARANGE, 40),
 	MAX_FEAT_ENUM(ID_AA64MMFR0_EL1, ASIDBITS, 16),
@@ -297,6 +311,8 @@ static u64 pvm_calc_id_reg(const struct kvm_vcpu *vcpu, u32 id)
 		return get_restricted_features(vcpu, id_aa64pfr2_el1_sys_val, pvmid_aa64pfr2);
 	case SYS_ID_AA64ZFR0_EL1:
 		return get_restricted_features(vcpu, id_aa64zfr0_el1_sys_val, pvmid_aa64zfr0);
+	case SYS_ID_AA64FPFR0_EL1:
+		return get_restricted_features(vcpu, id_aa64fpfr0_el1_sys_val, pvmid_aa64fpfr0);
 	case SYS_ID_AA64ISAR0_EL1:
 		return id_aa64isar0_el1_sys_val;
 	case SYS_ID_AA64ISAR1_EL1:
@@ -726,7 +742,7 @@ static const struct sys_reg_desc pvm_sys_reg_descs[] = {
 	AARCH64(SYS_ID_AA64ZFR0_EL1),
 	ID_UNALLOCATED(4,5),
 	ID_UNALLOCATED(4,6),
-	ID_UNALLOCATED(4,7),
+	AARCH64(SYS_ID_AA64FPFR0_EL1),
 	AARCH64(SYS_ID_AA64DFR0_EL1),
 	AARCH64(SYS_ID_AA64DFR1_EL1),
 	ID_UNALLOCATED(5,2),
-- 
2.47.3

