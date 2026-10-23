Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738880;
	b=NK8GUM+nas2+vVBkzdLI3ZncOG097bT+SVDebSyyz+D2rLugGEXF7Jbq4h50g/uPVF9L
	 qrZsAsygbMgnF1QlTbhQ5fX+AtvH8i5ZTnUkqBkzBRUYbC+jzLB0zcqxmpagLIFgS15ZA
	 Yl41Eg/B01OzhhinE9nu7er5QPcUtrAETQ8FGVmkcklWaJHyA+ykAW2rPI3jB/M7W0zF0
	 dg3CXORTJtrI6T3MMsJeeb+QycwAwuTWEo3KtkPEX08snL19toBWoyXrk0lzBCOuBLyTZ
	 6eczbpJJBqG8NvhVL+TteAoCm08+SXl61rZRP1SAeI5PmlhcLIA1ZX0pn0UhYDNDQNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738880;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IthMuZ/X3+pBoLoIufpj4zbJGn8A/2aYhe0XUm0DWMM=;
	b=uPoGx3x/mj2MWSDzRScM7gB8pzEiz8lVfcUSEDSa+HYh6KCM4iNNBDuxSijN9OcL0GSR
	 a/otVnTcnmymSMdXX2fLGjJfrl+iVdZSoZCj6cfaCzSU1WaM5RzEe7kK/pFibIo+yBXWn
	 H7Wg1Pho/cdraVFsOKW2LtEStQyv8P2q7B9OhKF3KrsBn1rntB0HrjmnY8y6qnEl2pFfP
	 csOzfAp05IaepPaicD01r/WTaUrYhqpydAlddkuJag35oP0g8vi26uucLMG5wkB2F1CyA
	 VZfTYp1O02+6absmWuc5yCIJqQOsiHPURdqQkRPSIr4d/yH5uQm+6pZCRa0hK3l5xsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VIIyaJ0S;
	arc=none smtp.remote-ip=95.215.58.62
Received: from mta1.migadu.com (out-62.mta1.migadu.com [95.215.58.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5C606A320
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 07:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE5C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VIIyaJ0S
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bc/l25RHGTThA1qU58knnGQTtBxP0XgtC5Ldu46NdMg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792738877; v=1; x=1793343677;
 b=VIIyaJ0Sw52+V97m1HKFMIqSa8yNktq8sfhmwLCLfRwHTvhwV0dPleik4OXIPg2DcDAfVuTs
 yVRIUsm/0QDbsndkPZ8u3CEHzlCuhbWSoLIFMxsl3QiNzNSTJBfnt8tWlqqrFHZzL9tRocntdjZ
 bLk6ry6z00cJbZ/RFAUTs7Mo=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c1557c2947e98bd9;
	Fri, 23 Oct 2026 07:01:16 +0000
X-Mizu-Trace-ID: c1557c2947e98bd9
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
	Yicong Yang <yangyicong@hisilicon.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: arm64: Hide FEAT_LS64_ACCDATA from guests
Date: Fri, 23 Oct 2026 08:01:09 +0100
Message-ID: <20261023070110.1833446-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023070110.1833446-1-fuad.tabba@linux.dev>
References: <20261023070110.1833446-1-fuad.tabba@linux.dev>
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

Since commit 58ce78667a641 ("arm64: Add support for FEAT_{LS64,
LS64_V}"), a guest sees the host's ID_AA64ISAR1_EL1.LS64, but KVM only
enables the FEAT_LS64 and FEAT_LS64_V instructions in HCRX_EL2. On a
host with FEAT_LS64_ACCDATA, a guest's ST64BV0 therefore traps and hits
the WARN_ON_ONCE() in handle_other(). ACCDATA_EL1 isn't trapped or
context-switched either, so every guest on that CPU shares it.

Rather than support FEAT_LS64_ACCDATA, which requires ACCDATA_EL1 to be
context-switched, cap the field at LS64_V. The guest's ACCDATA_EL1
accesses then UNDEF. This hides FEAT_LS64WB too, as it implies
FEAT_LS64_ACCDATA.

A VM saved on an older kernel can carry any level up to the host's, so
keep accepting those from the VMM, capped the same way. One saved at
LS64_ACCDATA or above restores at LS64_V.

Fixes: 58ce78667a641 ("arm64: Add support for FEAT_{LS64, LS64_V}")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/sys_regs.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 44aae52c473d7..7801166991b12 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1958,6 +1958,9 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 				 ID_AA64ISAR1_EL1_API |
 				 ID_AA64ISAR1_EL1_GPA |
 				 ID_AA64ISAR1_EL1_GPI);
+
+		/* ACCDATA_EL1 isn't context-switched, so no FEAT_LS64_ACCDATA */
+		val = ID_REG_LIMIT_FIELD_ENUM(val, ID_AA64ISAR1_EL1, LS64, LS64_V);
 		break;
 	case SYS_ID_AA64ISAR2_EL1:
 		if (!vcpu_has_ptrauth(vcpu))
@@ -2403,6 +2406,22 @@ static int set_id_aa64pfr2_el1(struct kvm_vcpu *vcpu,
 	return set_id_reg(vcpu, rd, user_val);
 }
 
+static int set_id_aa64isar1_el1(struct kvm_vcpu *vcpu,
+				const struct sys_reg_desc *rd, u64 user_val)
+{
+	u64 hw_val = read_sanitised_ftr_reg(SYS_ID_AA64ISAR1_EL1);
+	u64 ls64_mask = ID_AA64ISAR1_EL1_LS64_MASK;
+
+	/*
+	 * Older kernels let userspace set LS64 up to the host's level, so
+	 * keep accepting those values, capped at LS64_V.
+	 */
+	if ((user_val & ls64_mask) <= (hw_val & ls64_mask))
+		user_val = ID_REG_LIMIT_FIELD_ENUM(user_val, ID_AA64ISAR1_EL1, LS64, LS64_V);
+
+	return set_id_reg(vcpu, rd, user_val);
+}
+
 /*
  * Allow userspace to de-feature a stage-2 translation granule but prevent it
  * from claiming the impossible.
@@ -3428,10 +3447,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	/* CRm=6 */
 	ID_WRITABLE(ID_AA64ISAR0_EL1, ~ID_AA64ISAR0_EL1_RES0),
-	ID_WRITABLE(ID_AA64ISAR1_EL1, ~(ID_AA64ISAR1_EL1_GPI |
-					ID_AA64ISAR1_EL1_GPA |
-					ID_AA64ISAR1_EL1_API |
-					ID_AA64ISAR1_EL1_APA)),
+	ID_FILTERED(ID_AA64ISAR1_EL1, id_aa64isar1_el1,
+		    ~(ID_AA64ISAR1_EL1_GPI |
+		      ID_AA64ISAR1_EL1_GPA |
+		      ID_AA64ISAR1_EL1_API |
+		      ID_AA64ISAR1_EL1_APA)),
 	ID_WRITABLE(ID_AA64ISAR2_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
 					ID_AA64ISAR2_EL1_APA3 |
 					ID_AA64ISAR2_EL1_GPA3)),
-- 
2.47.3

