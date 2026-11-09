Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213168;
	b=sA3cKm38WqhY5Rwbc7CgEOrdfvOLRmrW+M0Kttp0J5KbK/wseb9BuNMaxFln04w4nFxh
	 f/bEaG1+fj+xlB7N0aI1xHTdacemO8vVEwf1t+j9ajC+OCNcq8c3SV3gx5tRebFAXU8WP
	 FAxB470bbwcafioK6h7xpnPhIC5mkzf9QwQLpyIuTuBOUG4hIB6ivJyEAYwdcwfpltf71
	 Imxq0TiiVnzUrlztgjrHYjZTEvMDLE2jJd6mqJTij4zSeBHLO3onhAoENCrz6VAL2k9Q6
	 /TFyLT0SXTQPV2NJGvu54FkM+t+qxzuFG8ogLSofNNRyfzsK6uqEY9HbJmhwrAZNcEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213168;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bo1WlELU8ik+Rr+Abdwa067G5JksNkxTfxKiETgF/pA=;
	b=aLe3gOKk8Xbd6SflA+4BJb2vIfzI2LVh0SwH9FNaU7aaEtnCY6r9j2yQw/Yoh1dg7sCR
	 yR8i79pUs1C6vVs8IOyG0ShHYXHXDD15fQjhbB23NX/xCTJ0189nDPDN8Sn8QDqPM5R4s
	 9uDDyYk7xGFFMJXbM/RGAmQ+ltyIuB+1IsZkzMixwMcEvLgvt+TB0Fnqjmipb3z5kDmk7
	 RWskDhKMAbU1zrKheCgXbgdalZixqiyH7umX3eMmNhuvcUiiPcdJpfkrOC1mZxUVLUT81
	 8gEkqIBX3olx1utlLG+UGXhn/DLwIrjEpU2Buq1XJGMafL+HymBCCzyleT9y9L+o12A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=S9jMCK95;
	arc=none smtp.remote-ip=95.215.58.2
Received: from mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52C606EE85
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B52C606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=S9jMCK95
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W7dlvw4NdcdYKD2+I77uCjjseY0CwzVUAyYBCfePwsI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794213166; v=1; x=1794817966;
 b=S9jMCK95QtcoMLf+7bXj5kUxvWLP+RKC3Y6fSEZhcv58cQDtKU+0kt+GkJkWHatYSbGK6KJg
 IlMykHYdMLqNAxO8qrnGq2hAky39aOsP1i4a8dvo1yfJClM/VQTaVgrJVJY2tDxyGad1qRxefYG
 LQn5WdLi51Kxu1L9Zo+JDv4k=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 909104da5cd6237e;
	Mon, 09 Nov 2026 08:32:45 +0000
X-Mizu-Trace-ID: 909104da5cd6237e
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
Subject: [PATCH 13/16] KVM: arm64: Advertise AFP and RPRES to protected VMs
Date: Mon,  9 Nov 2026 08:32:02 +0000
Message-ID: <20261109083205.806619-14-fuad.tabba@linux.dev>
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

Advertise FEAT_AFP and FEAT_RPRES to protected VMs. Both are controlled
through FPCR, which EL2 switches with the rest of the FP state.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 73ef47a8e687b..08805c7e4e5a7 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -169,6 +169,7 @@ static const struct pvm_ftr_bits pvmid_aa64mmfr1[] = {
 	MAX_FEAT(ID_AA64MMFR1_EL1, PAN, PAN3),
 	MAX_FEAT(ID_AA64MMFR1_EL1, SpecSEI, IMP),
 	MAX_FEAT(ID_AA64MMFR1_EL1, ETS, IMP),
+	MAX_FEAT(ID_AA64MMFR1_EL1, AFP, IMP),
 	MAX_FEAT(ID_AA64MMFR1_EL1, CMOW, IMP),
 	FEAT_END
 };
@@ -212,6 +213,7 @@ static const struct pvm_ftr_bits pvmid_aa64isar1[] = {
 };
 
 static const struct pvm_ftr_bits pvmid_aa64isar2[] = {
+	MAX_FEAT(ID_AA64ISAR2_EL1, RPRES, IMP),
 	MAX_FEAT_FUNC(ID_AA64ISAR2_EL1, GPA3, IMP, vm_has_ptrauth),
 	MAX_FEAT_FUNC(ID_AA64ISAR2_EL1, APA3, PAuth, vm_has_ptrauth),
 	MAX_FEAT(ID_AA64ISAR2_EL1, MOPS, IMP),
-- 
2.47.3

