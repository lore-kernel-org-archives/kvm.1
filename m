Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835913E556D
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441789; cv=none; b=JUY6d75kZbEEIPwmYBA12tjxWPTiNN2PQCUQ1Ssp21EJHmIpzPsE8hp4R/rLJToopk1Sc+lm1bjIBWM/+IhQLWwu/OJT42KrrbMa/Q/VUk71h22Oj95dK0KvWHymxyfBz1TOiRMyqKyEMo8keErtwcPSHlGD6Wj429AeIpGzs8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441789; c=relaxed/simple;
	bh=KXv1wCnD4xxnPNIkZdmB1UtsgOX6M+hK6zF5vvz0T4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9lZxpW4w/2hwAc1tA/kugkqSTvm1tzWPPRQY7NzWU4YGgFFeFey7sD6N48uUI0lfzfrJ75SgS7+arMrwhNeVjlSzTiSB1CUd6Jo43mNx39fS6U1a325c/6YVePrT0hrZOXrsRaTjy5CRstao9iKB/bN5105Apt49PY66BzX2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwegdxFH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwegdxFH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F061F00A3A;
	Tue,  7 Jul 2026 16:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783441788;
	bh=qrTvjx6hus7PgBARqNi5S4WKvXvQglEmBs2sOR+PR4g=;
	h=From:To:Cc:Subject:Date;
	b=MwegdxFHNBEEq9GN+P4Jmp2LFy4tllYihsOgoKBrNH8hLOc0b+X7fapP7BV0pY1GA
	 kmqqL9j29xxjRGfKSkF4VWppq/Qg0POmqD1paZEDtupe/SvP1tQ+31i6djHWgNpD0M
	 eQByd2qKeejiTXZLrXhLvZo5hDRLn1lR2gAKwOBpjbW1cwJXYwabys3Bcjz8Uq3i/5
	 kZDAequAx3t+ThniS87gvb5pJe8w+vYOjhGWjHjLTgC/9z88iCRQjr3t5laeGG2OTp
	 KKMX3PNdx1Z98tPBZVTinM7hrzQBIo+toYN4LXtKL+9+wxF7DfFxWAZgRGQeYsOpnx
	 2SGVxEg7AVOYQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wh8g6-00000002V1E-1guE;
	Tue, 07 Jul 2026 16:29:46 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] KVM: arm64: Fix propagation of TLBI level in kvm_pgtable_stage2_relax_perms()
Date: Tue,  7 Jul 2026 17:29:35 +0100
Message-ID: <20260707162935.1900874-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, broonie@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Assigning the invalidation level (an s8 value) with TLBI_TTL_UNKNOWN
(a 32bit signed value) is not ideal, to say the least. Instead of
this, only pass TLBI_TTL_UNKNOWN to __kvm_tlb_flush_vmid_ipa_nsh()
when we know for sure that we don't have a provided level.

Fixes: 100baf0184896 ("KVM: arm64: Ensure level is always initialized when relaxing perms")
Reported-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/akztC7H2IsEKaq4i@sirena.org.uk
---
 arch/arm64/kvm/hyp/pgtable.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 8754c99c22f2f..70dceb20dfada 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1356,7 +1356,7 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 				   enum kvm_pgtable_prot prot, enum kvm_pgtable_walk_flags flags)
 {
 	kvm_pte_t xn = 0, set = 0, clr = 0;
-	s8 level = TLBI_TTL_UNKNOWN;
+	s8 level;
 	int ret;
 
 	if (prot & KVM_PTE_LEAF_ATTR_HI_SW)
@@ -1379,7 +1379,8 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 
 	ret = stage2_update_leaf_attrs(pgt, addr, 1, set, clr, NULL, &level, flags);
 	if (!ret || ret == -EAGAIN)
-		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa_nsh, pgt->mmu, addr, level);
+		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa_nsh, pgt->mmu, addr,
+			     (ret == -EAGAIN) ? TLBI_TTL_UNKNOWN : level);
 	return ret;
 }
 
-- 
2.47.3

