Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693CE4E73C8
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609143; cv=none; b=k0tCjy+l2FSMCMYR+CHzBGNKoAg2nKboQuFg+LJZnSC5jVSb4YrzjS6zKeMcyPS9Tr2IwGmnQGyqDbStWd8edbET3VaMasW2YcQD5s5cC/YQfGJIfHqsRWxQh+tOyG9gEabOcnD7mIxAcaR/nes4ez9R/j7zH93kmxF2VENPMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609143; c=relaxed/simple;
	bh=UsrrMKeoU6FyB7ktPMuLLTHGrlKvgJcUMP9CZWK2MkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQZZXSMfJBNPYjK7f3xS3d81fd5HhOaV4fl/XQ7Qv+Diqu1NhxAAm124O6TlPOjhHyjo7wJz6UJsjNKeaHkmIuCGknOtop7u1KXB18+WSbMUGCEHLVptBiVY5o6SeUIjO1i/Um7Hw1gnZiceUGN2w5SnZZUJXqXWweEA1/sSoGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYt5ziIv; arc=none smtp.client-ip=95.215.58.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYt5ziIv"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UsrrMKeoU6FyB7ktPMuLLTHGrlKvgJcUMP9CZWK2MkQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790609139; v=1; x=1791213939;
 b=nYt5ziIv/3E20y3DRnAM19W1Yns0ZSvwjweI4mhJwzoz+yuzHfSfNw8FeqnCdt9hupruQpSh
 TTWfbJgMJfP9J5F/cI8RLuIs6TKRdCQH3lKxCe9zib9GpYBYM2xRUGJRjdgkZLkWyHbrpGDzaED
 vXmxoA0NZNdmOqXFkaIxTd0A=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1db0060865db2ffe;
	Mon, 28 Sep 2026 15:25:17 +0000
X-Mizu-Trace-ID: 1db0060865db2ffe
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
Subject: [PATCH v1 02/10] KVM: arm64: nv: Don't WARN on an invalid VTCR_EL2
Date: Mon, 28 Sep 2026 16:24:59 +0100
Message-Id: <20260928152507.2116110-3-fuad.tabba@linux.dev>
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

Before walking an L1 guest's stage-2 tables, KVM checks the starting
level in VTCR_EL2.SL0 and the IPA size from T0SZ against the granule
and PA size, and sets a stage-2 level 0 Translation fault when either
is invalid. The check also WARNs, so an L1 guest that programs an
invalid VTCR_EL2 triggers the WARN on every walk.

Drop the WARN.

Fixes: 61e30b9eef7ff ("KVM: arm64: nv: Implement nested Stage-2 page table walk logic")
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 3c4fc566eafc6..98c1f8c193319 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -279,7 +279,7 @@ static int walk_nested_s2_pgd(struct kvm_vcpu *vcpu, phys_addr_t ipa,
 		return -EFAULT;
 
 	ret = check_base_s2_limits(vcpu, wi, level, input_size, stride);
-	if (WARN_ON(ret)) {
+	if (ret) {
 		out->esr = compute_fsc(0, ESR_ELx_FSC_FAULT);
 		return ret;
 	}
-- 
2.39.5

