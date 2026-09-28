Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624214E77F3
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609164; cv=none; b=a33zFSn2tBqFufi5TmCVXMPg8thu9We1fIXarfQb/P+LnMGtQ6pSWbYotEl0I70V1R5jn0uPATz+WAay1nhIARSga52OCC1LjQifuUHUtj0/jXhWezc7tyofJ2gPjI6GKieMfNy9Fvlc8RTNCYj24CMIUGjwjp8+0eDkS/xz0DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609164; c=relaxed/simple;
	bh=bVUARLRy/2fo3UIM94OcGSR9nBrrgL4zvU6NywPOORo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f30U8hzA0YHquTvdwv5FGHs/oVLn6cjel6JLZl12+wGFu64Ic7Yn5XcUr19l+nIQJHnWG/SimkYxLagNhJmlmwj9zRKf6GqVHgDZwQt7QKuk+B0NQgvF4A77F5Z3GYPGzJbCm9Iz5vLSWXZZOtTUjNeDLSZqkFyaZZ9WR5kV40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AWA6If2b; arc=none smtp.client-ip=91.218.175.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AWA6If2b"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bVUARLRy/2fo3UIM94OcGSR9nBrrgL4zvU6NywPOORo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790609156; v=1; x=1791213956;
 b=AWA6If2b3TNQzX8/jZxQaLbPI/2hiuoeTJjhynJ0u5sGo/EJbyyH5TJFCVeE+tmQDIbkLaef
 QxN/onuFnSrIkpxj/5TJ0OZZKW4q8BKdI5h3hXrAw5WGa3ZmzjEgsGTAWWpBF7zJCslPtd0MoWB
 DSGaKycEBHpTRI0S4P1QXxTU=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e326ca226933ccf1;
	Mon, 28 Sep 2026 15:25:56 +0000
X-Mizu-Trace-ID: e326ca226933ccf1
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
	Jing Zhang <jingzhangos@google.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/10] KVM: arm64: selftests: Test AT S12E1R with an invalid VTCR_EL2.SL0
Date: Mon, 28 Sep 2026 16:25:02 +0100
Message-Id: <20260928152507.2116110-6-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260928152507.2116110-1-fuad.tabba@linux.dev>
References: <20260928152507.2116110-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that AT S12E1R with SL0 set to 3 on 4K pages, an invalid starting
level without FEAT_TTST (which KVM doesn't expose to an L1 guest),
reports a stage-2 level 0 Translation fault in PAR_EL1. KVM used to
retry the AT forever instead, so without the fix the test hangs. An out
of range T0SZ isn't tested, since the architecture lets an
implementation clamp it instead.

Assisted-by: LLM
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tools/testing/selftests/kvm/arm64/at.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/at.c b/tools/testing/selftests/kvm/arm64/at.c
index ce5d312ef6baa..61fd217f724bd 100644
--- a/tools/testing/selftests/kvm/arm64/at.c
+++ b/tools/testing/selftests/kvm/arm64/at.c
@@ -73,12 +73,40 @@ static void test_at(bool expect_fault)
 	test_at_insn(S1E1W, expect_fault);
 }
 
+/* 4K granule with SL0 == 3 and no FEAT_TTST is a stage-2 level 0 Translation fault */
+static void test_at_s12_bad_sl0(void)
+{
+	u64 vtcr = FIELD_PREP(VTCR_EL2_SL0_MASK, 3) | FIELD_PREP(VTCR_EL2_T0SZ_MASK, 24);
+	u64 sctlr = read_sysreg_s(SYS_SCTLR_EL12);
+	u64 par;
+
+	/* Disable stage 1, so the stage-2 fault is on the output address, not a table walk */
+	write_sysreg_s(sctlr & ~SCTLR_ELx_M, SYS_SCTLR_EL12);
+	write_sysreg(vtcr, vtcr_el2);
+	sysreg_clear_set(hcr_el2, 0, HCR_EL2_VM);
+	isb();
+
+	__at(OP_AT_S12E1R, TEST_ADDR);
+	isb();
+	par = read_sysreg(par_el1);
+
+	sysreg_clear_set(hcr_el2, HCR_EL2_VM, 0);
+	write_sysreg(0, vtcr_el2);
+	write_sysreg_s(sctlr, SYS_SCTLR_EL12);
+	isb();
+
+	__GUEST_ASSERT((par & SYS_PAR_EL1_F) && (par & SYS_PAR_EL1_S) &&
+		       FIELD_GET(SYS_PAR_EL1_FST, par) == ESR_ELx_FSC_FAULT_L(0),
+		       "AT S12E1R: expected stage-2 level 0 translation fault (par: %lx)", par);
+}
+
 static void guest_code(void)
 {
 	sysreg_clear_set(tcr_el1, TCR_HA, 0);
 	isb();
 
 	test_at(true);
+	test_at_s12_bad_sl0();
 
 	if (!SYS_FIELD_GET(ID_AA64MMFR1_EL1, HAFDBS, read_sysreg(id_aa64mmfr1_el1)))
 		GUEST_DONE();
-- 
2.39.5

