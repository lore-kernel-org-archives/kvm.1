Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.215
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213169;
	b=IIz1NsBZZiK29MwHBmb2Oq9UQVhnPijW2QsQUeNpaJkN4DT8K6hjOOLegSEEKu4eJs2v
	 zAK+qI80kQNW1XUX6j+GXy/mD/tZmk3FrQHmLuDN9XnCjXZB0ZgK6nQs5doEe2RE1D/lV
	 3h9rnwQWfWmQqjrbNw/rNHmjovGl4UocpbtGngV7vIyfZFZx4I9bkxuog0dWuwmNioZkz
	 vI33RrSQjzB7rqMibxhC2xOWI5YXKZwVJfcP+I4QC6joY1ynznS6ljEGnXBXV1LzSBNo2
	 E385IrS/6iq8G0GWqtakIDcxTZog7mqoKC4Rrn00U9O+cXZQsYWwlmrIU5x42Wd6llg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213169;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zfhi2uYcrWS/onncXrRxzhgsb74qv1ON63T8diGgF5g=;
	b=fJj0aT7Jmcea9E4l0zJeAUkvDwXnisBRa5XfZcR8RFizW60ssx4vwffiaq63OIve+RIR
	 VRW/gYMbDLQ84nk0Bfe3tp2dZYAFlv4QD0aJyk3MiRB58jR5IcnnTdILVZwS3csbeUgvl
	 mgNMagBd6I6l209PW4yOokm38dokkrn6nclGNdds8vX9kyC1Okl+x3/FEfcW7MjRSWX2J
	 +5hXNZDe+XNwGYympD307yHsbE6pL70FgyTHoQi5zjlCcQmMQGYhsPWD15N7D161D1nwA
	 XT7TzPdkYi0oIrMnDJtsy6QiCNpfu2FENty6RFQY1WzM9UnjJGrOiTLnOencLpM46lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YL6YeJQ3;
	arc=none smtp.remote-ip=91.218.175.215
Received: from mta0.migadu.com (out-215.mta0.migadu.com [91.218.175.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFA6606D83D
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EFA6606D83D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YL6YeJQ3
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BurFVrCnVIlezKhxQf4QLGiBVCBkQ4OWvY1E35/7u7Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794213165; v=1; x=1794817965;
 b=YL6YeJQ3kRqwqwNZSS8RsoE2Zbl+cSfHej+ruOe+b5T9E+ofFbKuxCz74feHWrOLAU1iAeHS
 4m9yU+/sZaazyd/m2xfW2plFzHyvTGchqE7VOn/2tWzHsp3SYGdniNKKe6Mzd+KaN6XGVt2KdJF
 R5VTrouhvmt0SL5dN1R/beII=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5055768b8c5f843b;
	Mon, 09 Nov 2026 08:32:45 +0000
X-Mizu-Trace-ID: 5055768b8c5f843b
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
Subject: [PATCH 12/16] KVM: arm64: Advertise FAMINMAX, LSFE, LSUI and FPRCVT to protected VMs
Date: Mon,  9 Nov 2026 08:32:01 +0000
Message-ID: <20261109083205.806619-13-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109083205.806619-1-fuad.tabba@linux.dev>
References: <20261109083205.806619-1-fuad.tabba@linux.dev>
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
index fe60535e4f358..1981646df42ce 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2831,6 +2831,7 @@ static void kvm_hyp_init_symbols(void)
 	kvm_nvhe_sym(id_aa64isar0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR0_EL1);
 	kvm_nvhe_sym(id_aa64isar1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR1_EL1);
 	kvm_nvhe_sym(id_aa64isar2_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR2_EL1);
+	kvm_nvhe_sym(id_aa64isar3_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR3_EL1);
 	kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 	kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
 	kvm_nvhe_sym(id_aa64mmfr2_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index b325bab5431a8..73ef47a8e687b 100644
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
@@ -223,6 +224,14 @@ static const struct pvm_ftr_bits pvmid_aa64isar2[] = {
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
@@ -289,6 +298,8 @@ static u64 pvm_calc_id_reg(const struct kvm_vcpu *vcpu, u32 id)
 		return get_restricted_features(vcpu, id_aa64isar1_el1_sys_val, pvmid_aa64isar1);
 	case SYS_ID_AA64ISAR2_EL1:
 		return get_restricted_features(vcpu, id_aa64isar2_el1_sys_val, pvmid_aa64isar2);
+	case SYS_ID_AA64ISAR3_EL1:
+		return get_restricted_features(vcpu, id_aa64isar3_el1_sys_val, pvmid_aa64isar3);
 	case SYS_ID_AA64MMFR0_EL1:
 		return get_restricted_features(vcpu, id_aa64mmfr0_el1_sys_val, pvmid_aa64mmfr0);
 	case SYS_ID_AA64MMFR1_EL1:
@@ -722,7 +733,7 @@ static const struct sys_reg_desc pvm_sys_reg_descs[] = {
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

