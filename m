Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621255;
	b=Sw+62Wu80p5gzUGOoECUKDnH2tPh30paeHfH+kDWPEpd5JfMBZ4rIgvO16EIYqpHmati
	 ALFaMlF2ihEQyvC01SSxV3D4lK5Zuk/EVg1hDtMZfLuH8qChaE9hfalR3TSPNsi5tdJRN
	 GVB0ntJFWhYHtwCeCG0Vgm8XVONCrHeH8AImcCRJrFOEp02njdgNOOVaeE9qUTj+5NEty
	 GozEL0UZUACJTikDSDNQQE2AlP+eN9JmmQMWdvVovvu+7vytk1ty4OvrU0rZDgwRYENHt
	 rItJbvEMomZWkIKygj6csEdzEj2AMOaiDFQAPMWUI/is8SlY0XSK7bxfF2HUnKy/sSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621255;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TFaLTkdHB+5YDL5f+nojYfBbFLMj9J2+pRtPz6tMP5w=;
	b=pP81FHDgxGRDtT0EZdTVZ7Mslxkqj+uLbfcV79FUZg/kvYTi8EPvCjmeaiEXJK2jg2nK
	 tpFy8G7+PP3AAi2a/5BRwoLz9nKETm9oFSgj1tmtsbtR1c77LDS7XuIVKSALSpJcGm8l3
	 QQYgeC0rodlrc/FPzdFf/9b69zMGOFPMBenbwf+XF4GpHhtnq4cc9uRdrY64dsSTC64/V
	 izXY6yX0ViNCMcSXHNeGl2E7RFWIt/IpcI6ecWbsSxfa6kNa1mbeFvF+gijXvl7B6d+O1
	 zqRppRnMs8OeRS8d8P/JmUn0otVWaka1pkbsAZyW1Yc6cblJluv5vgzBd1sTRHyjXOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BXiaVdjD;
	arc=none smtp.remote-ip=91.218.175.196
Received: from mta0.migadu.com (out-196.mta0.migadu.com [91.218.175.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C71E606A695
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C71E606A695
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BXiaVdjD
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tQx3hAInB2qCvf4Ddz800tK984tgyiqRxbiHM/YoGLw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795621252; v=1; x=1796226052;
 b=BXiaVdjDekymZahhXs+HONT8On8e4zJA11jxaqcRmzOJK/3a4y3CosAbL2TOWtqsWATiw3PC
 jcx3G0vwyQExTBBlPX22VRh8aouq/VFqul5G/a7fx/jwOviIZVDDbHvLno2oDnKu0MMkgUk4fWB
 F7eVKpcQnwgVf13CT8P+tDbA=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 014e2df93ab0485a;
	Wed, 25 Nov 2026 15:40:52 +0000
X-Mizu-Trace-ID: 014e2df93ab0485a
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
Subject: [PATCH v2 17/20] KVM: arm64: Advertise AFP and RPRES to protected VMs
Date: Wed, 25 Nov 2026 15:39:08 +0000
Message-ID: <20261125153911.106793-18-fuad.tabba@linux.dev>
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

Advertise FEAT_AFP and FEAT_RPRES to protected VMs. Both are controlled
through FPCR, which EL2 switches with the rest of the FP state.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 129a6b89a232d..fdf405629dfd3 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -168,6 +168,7 @@ static const struct pvm_ftr_bits pvmid_aa64mmfr1[] = {
 	MAX_FEAT(ID_AA64MMFR1_EL1, PAN, PAN3),
 	MAX_FEAT(ID_AA64MMFR1_EL1, SpecSEI, IMP),
 	MAX_FEAT(ID_AA64MMFR1_EL1, ETS, IMP),
+	MAX_FEAT(ID_AA64MMFR1_EL1, AFP, IMP),
 	MAX_FEAT(ID_AA64MMFR1_EL1, CMOW, IMP),
 	FEAT_END
 };
@@ -211,6 +212,7 @@ static const struct pvm_ftr_bits pvmid_aa64isar1[] = {
 };
 
 static const struct pvm_ftr_bits pvmid_aa64isar2[] = {
+	MAX_FEAT(ID_AA64ISAR2_EL1, RPRES, IMP),
 	MAX_FEAT_FUNC(ID_AA64ISAR2_EL1, GPA3, IMP, vm_has_ptrauth),
 	MAX_FEAT_FUNC(ID_AA64ISAR2_EL1, APA3, PAuth, vm_has_ptrauth),
 	MAX_FEAT(ID_AA64ISAR2_EL1, MOPS, IMP),
-- 
2.47.3

