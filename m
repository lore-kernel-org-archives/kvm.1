Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621249;
	b=CyoekYHhSpO5HfbUsb7GB85Zv5YdQSogq2yaBnuxCk9hwzamRFOOkK+4DlyCCs802NJk
	 9iRS3ZuvyXb24xvmfw2c+Jchz61R2G2yb7QV6oe43dze/3lpDssUN6bk7IxhDM8oHYaqB
	 bKjTCsjviSEI868mjCFB+O7LHNFlBwRBO5U1xB1Q9rtSg3nkEAB0gYVLujNHoSa9TwzB2
	 /W2khv+fz472mv2bTILDKtCmNBwJI4xLGYM/bppNRQ2pmPNbXuEMtg5HCHVxaedL/ax3N
	 c5HwT0R/E6WxOOl9pv0oQ7SpFuUzKEibk8SlXsAFbdmMnG2+jkejq8XAu5j1ySWGMFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621249;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oJyjfOujmSBUsGvM1/SgdU/YJl1D0UryFNbGYP9HTmI=;
	b=1Mrx5vOB6SXyCPfkLFWKYFI5TbJb3I4CEA7+eVTNBc8knBTtSb43K2f3frdJ9Blh30Fx
	 nMZrcJBRYMBd66+LqrcQ4O3L5Du7epXKNVwYkL7SPV6n/8iu3OzBaX8c6pqQJIXUlXRHP
	 Q9iWuC+W1+Cus0zZyTdXHg+GCkLbhAwlEBS51PgiLtioh4ZjuFHPK3CeiS3PHKzMy+37K
	 gpqXHwuoy2yUglah5kK5sI6qskzCaOQyNn6ZcvyhpfLlPpmJ3uYooQqw8ahCjBp4gIf/s
	 4QRsi8SxBxdqOv9TPm2S0LEL8jVcxDooJG81wdk3xTk92z3apSi32UORBOdEA9yqV9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dA4yyyra;
	arc=none smtp.remote-ip=95.215.58.194
Received: from mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D697D606A336
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D697D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dA4yyyra
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j1+9jq4DNPjKmn/CiJVqGm6EPhi92kwiCRK4Zpjn4qM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795621247; v=1; x=1796226047;
 b=dA4yyyraWlRd0mTERY4HDESFKEKwlMYEgCWvtQd0esCUToGTOgUTYXacZEg3doebLyMusUQ5
 jSEesaJMPAE077rK/7fumTfK9ICsejd85CAcnafagjiqJhNgIWlOzYPhUbEfmKds/FHpJdRYHUc
 nNdiMw46LrULcAmuN0JDRUcc=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c6dde43742fe7882;
	Wed, 25 Nov 2026 15:40:45 +0000
X-Mizu-Trace-ID: c6dde43742fe7882
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
Subject: [PATCH v2 15/20] KVM: arm64: Advertise HBC, CLRBHB, RPRFM, CSSC and LUT to protected VMs
Date: Wed, 25 Nov 2026 15:39:06 +0000
Message-ID: <20261125153911.106793-16-fuad.tabba@linux.dev>
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

Advertise FEAT_HBC, FEAT_CLRBHB, FEAT_RPRFM, FEAT_CSSC and FEAT_LUT to
protected VMs, with CSSC up to CMPBR and LUT up to LUT6, as for a
non-protected VM.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 4ba947bd3d125..2c22317a76a5e 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -213,6 +213,11 @@ static const struct pvm_ftr_bits pvmid_aa64isar2[] = {
 	MAX_FEAT_FUNC(ID_AA64ISAR2_EL1, GPA3, IMP, vm_has_ptrauth),
 	MAX_FEAT_FUNC(ID_AA64ISAR2_EL1, APA3, PAuth, vm_has_ptrauth),
 	MAX_FEAT(ID_AA64ISAR2_EL1, MOPS, IMP),
+	MAX_FEAT(ID_AA64ISAR2_EL1, BC, IMP),
+	MAX_FEAT(ID_AA64ISAR2_EL1, CLRBHB, IMP),
+	MAX_FEAT(ID_AA64ISAR2_EL1, RPRFM, IMP),
+	MAX_FEAT(ID_AA64ISAR2_EL1, CSSC, CMPBR),
+	MAX_FEAT(ID_AA64ISAR2_EL1, LUT, LUT6),
 	MAX_FEAT(ID_AA64ISAR2_EL1, ATS1A, IMP),
 	FEAT_END
 };
-- 
2.47.3

