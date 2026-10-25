Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792914722;
	b=YL2bbLSfVLU3ZiGHuy0e1OnyQb69sZ8g3NHqjbq2BCA4Bcw8L6s+c43zIC7FQTInMeBO
	 6H2lr7IFq2HSUZVW9K6Bqvh9GIYkIO6xzD7oFE9UbeB+UlgZl6KPHeWhtJyrJ1hpswYco
	 sswGCfsj0OluEy0LZ3dy5t1aoXilx8nXbFmujqDOeZ2o40G+7nWSr2UQ4ixMCzDQGN2fO
	 6I6g4w3u0KuHSHzvddVrlzalDzaOUsXkMcnPfpyfwnQFfS59dMOfJBNkFCP+fbA1zCTiI
	 JsWBg36RHODNRKoQTSY2xp0YQ08P22F5P3pOpE/kzsAkQBSXwTadsTktZKXSRwUpj7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792914722;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kd+dIHLAZ0VbjKhoBYhi5STIRTNamR3vQAK0UqVJG5I=;
	b=4bXcxciPoGYZkNuf8sQUrg4FpHqk13uO7MQkFwmY2xq3DdSxJl49Sqsg7NXE+8LyjE9s
	 b5lEdlwsrovSv96ytcRnJuFex1VOleqwOkDraIONCExGkq5w4mTC4knBAjKbijjWY7ts+
	 JCGNcIJ5N4CP0BIEBAoEEn6W8NUjNJn8XuxWsVx01MRTUhrW7TuxId6tRjPGAqL0a1geg
	 iYm3ToVB5Xy2604uAZ87oHXGEIJEO4/4n93eUOHA9O1nbtDOPuHvQMGKlhMYC8sHBQuTg
	 W/QHtwVadj2KfRTm3l/uA59MnHsJL5ZFDoAel00Tg7+34mWmh2x9X/7w4zp4AglOLJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cTdjI3+Q;
	arc=none smtp.remote-ip=95.215.58.106
Received: from mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A286606A324
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 07:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A286606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cTdjI3+Q
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z2sHLhxFVy/B5w9Rnnrt3uG5g0JTtJ0jVUFIyN0gxO0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792914719; v=1; x=1793519519;
 b=cTdjI3+QvXqk4cYmtvjSsIsx9AxR1NBU4tX5SFFx5IrPusBpErbKSqfMj5ku4tEGygh1et58
 ue4XDPxhIWPAdl2lwzx6C515AB+AtoBJ6458fpVGROXWsONM9z5hBaSBTaaG4AHGLJe3qTzsUq5
 YoUvKQzENrNc7s3wYu7O1IIA=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 48f71797eadf8a7f;
	Sun, 25 Oct 2026 07:51:59 +0000
X-Mizu-Trace-ID: 48f71797eadf8a7f
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] KVM: arm64: Add context-switch of ACCDATA_EL1
Date: Sun, 25 Oct 2026 07:51:36 +0000
Message-ID: <20261025075138.2919734-4-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025075138.2919734-1-fuad.tabba@linux.dev>
References: <20261025075138.2919734-1-fuad.tabba@linux.dev>
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

From: Marc Zyngier <maz@kernel.org>

Add ACCDATA_EL1 save/restore as part of the EL0 context. This is
conditioned on the guest's view of ID_AA64ISAR1_EL1.LS64 reporting
that this register is supported.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Fixes: 58ce78667a641 ("arm64: Add support for FEAT_{LS64, LS64_V}")
Link: https://lore.kernel.org/r/20240815125959.2097734-5-maz@kernel.org
Cc: stable@vger.kernel.org
[Fuad: rebased; switch ACCDATA_EL1 for guests only, as the host never
 uses it; gate it on a new ARM64_HAS_LS64_ACCDATA capability, since
 in pKVM the host controls a non-protected guest's ID registers, and
 an EL2 access to ACCDATA_EL1 on a CPU without the feature is UNDEFINED]
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kernel/cpufeature.c             |  7 +++++++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 23 ++++++++++++++++++++++
 arch/arm64/tools/cpucaps                   |  1 +
 3 files changed, 31 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 32102c3912fa7..b5720c56eebc9 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3225,6 +3225,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_ls64_v,
 		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, LS64, LS64_V)
 	},
+	{
+		.desc = "LS64_ACCDATA",
+		.capability = ARM64_HAS_LS64_ACCDATA,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, LS64, LS64_ACCDATA)
+	},
 #ifdef CONFIG_ARM64_LSUI
 	{
 		.desc = "Unprivileged Load Store Instructions (LSUI)",
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index c382848d31947..4a008c8a696ba 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -17,6 +17,7 @@
 #include <asm/kvm_mmu.h>
 
 static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt);
+static inline bool ctxt_has_accdata(struct kvm_cpu_context *ctxt);
 
 static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
 {
@@ -67,6 +68,13 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
 	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
+
+	/*
+	 * Despite the appearances, ACCDATA_EL1 is part of the EL0
+	 * context, as it can only be used using ST64BV0.
+	 */
+	if (ctxt_has_accdata(ctxt))
+		ctxt_sys_reg(ctxt, ACCDATA_EL1)	= read_sysreg_s(SYS_ACCDATA_EL1);
 }
 
 static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
@@ -131,6 +139,18 @@ static inline bool ctxt_has_sctlr2(struct kvm_cpu_context *ctxt)
 	return kvm_has_sctlr2(kern_hyp_va(vcpu->kvm));
 }
 
+static inline bool ctxt_has_accdata(struct kvm_cpu_context *ctxt)
+{
+	struct kvm_vcpu *vcpu;
+
+	/* The host never uses ACCDATA_EL1 */
+	if (!cpus_have_final_cap(ARM64_HAS_LS64_ACCDATA) || !ctxt_is_guest(ctxt))
+		return false;
+
+	vcpu = ctxt_to_vcpu(ctxt);
+	return kvm_has_feat(kern_hyp_va(vcpu->kvm), ID_AA64ISAR1_EL1, LS64, LS64_ACCDATA);
+}
+
 static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, SCTLR_EL1)	= read_sysreg_el1(SYS_SCTLR);
@@ -210,6 +230,9 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
+
+	if (ctxt_has_accdata(ctxt))
+		write_sysreg_s(ctxt_sys_reg(ctxt, ACCDATA_EL1), SYS_ACCDATA_EL1);
 }
 
 static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 2775ba3359cfe..f01719bbd6037 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -49,6 +49,7 @@ HAS_LPA2
 HAS_LSE_ATOMICS
 HAS_LS64
 HAS_LS64_V
+HAS_LS64_ACCDATA
 HAS_LSUI
 HAS_MOPS
 HAS_NESTED_VIRT
-- 
2.47.3

