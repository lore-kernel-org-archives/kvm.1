Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621227;
	b=4ScBPUTtZMnn2lYa6jMz0fKbgnYKMrJCw6oR4YRqdw1/i8tT2TX8hVi46LjdjzczwwVr
	 7nM5Syt3vSVE+yGrimx38NmRJVADiKm4it9E1o1r5tmEKwk4RE5iFcSLFUzp6OLNcHogZ
	 WjyUcyw9azXVFkGZZ5MMCqFW7XGcGUCJXmqmYQZhjFKjpMix6W3nvRzGIxAVdsNoRxHQ3
	 fWaI5qU6L8Kk4ETDtrcOqd3WCSy0lLyE/yx13Xp4IzVOVOemARpG3hMliOjAOeqbh3uID
	 VAW4Y/44sHERAZpkRjiufNlQcBzPlYraIe4n0zkU0Cbgrpf3tJrcxOHrUPbke6LfPyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621227;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=drJVa0QgayGuhGYi4NP8p1Ez5UctzVZvNREYNVMNp/Q=;
	b=tLuVf9NdQo77mhbHZww9LIDkCpiIBr9wbBI/IWs67XNdB2gq2nUaSImaLK3FA1oVWYld
	 B28A5qm+ANncfu44BsiUG+C5bEa2vm7D8H6gUXrv3RTqjnvly6MVdc2KquM1/366pgCMH
	 R4ET1smm2ydOSFKNjZihwJRNVg8H8c/KiC9166odLdtsND4fym8xM1E96iAN2x621N4uC
	 u9oK2b7h7WMmmEhHnprzTOB2AwwWtDqG86YF+qil3Ru/DFyYmy24EjzFTqeSKyT/ItdPE
	 DwND6BPoBvkmcnh7h5cOlTS+9nBI2UNm1i0o87FD+AD6CJLVbsaWYY+gKtdOlof0+WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MSIK33pk;
	arc=none smtp.remote-ip=91.218.175.170
Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8105606A69F
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8105606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MSIK33pk
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zMg8PTnJrl2Cv/LZHpJ8HIY5Hb3RY/8jdSaxT7wXvrY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795621224; v=1; x=1796226024;
 b=MSIK33pkW5SLAkFSlDjWESlN2TNtGLntBgTj0HhD6CDWpyf3Ko/FdjqJZ/4UknAM5q914Vsq
 dOhC/dZhFZvexZk4eU+bLaz+EbCMIAClsQ+aNrlyZkiK54COqCV4JdQ1boDmlgkYxNWTNmHvPfJ
 r2p4g2BX5XyPRFB1x3QH3ye8=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e60406e83a0946bc;
	Wed, 25 Nov 2026 15:40:23 +0000
X-Mizu-Trace-ID: e60406e83a0946bc
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
Subject: [PATCH v2 13/20] KVM: arm64: Advertise MOPS to protected VMs
Date: Wed, 25 Nov 2026 15:39:04 +0000
Message-ID: <20261125153911.106793-14-fuad.tabba@linux.dev>
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

Advertise FEAT_MOPS to protected VMs. With the field set,
vcpu_set_hcrx() sets HCRX_EL2.{MSCEn,MCE2} for them, and
kvm_hyp_handle_mops() already handles their MOPS exceptions.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 4f13b100007fa..acba7489809f3 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -211,6 +211,7 @@ static const struct pvm_ftr_bits pvmid_aa64isar1[] = {
 static const struct pvm_ftr_bits pvmid_aa64isar2[] = {
 	MAX_FEAT_FUNC(ID_AA64ISAR2_EL1, GPA3, IMP, vm_has_ptrauth),
 	MAX_FEAT_FUNC(ID_AA64ISAR2_EL1, APA3, PAuth, vm_has_ptrauth),
+	MAX_FEAT(ID_AA64ISAR2_EL1, MOPS, IMP),
 	MAX_FEAT(ID_AA64ISAR2_EL1, ATS1A, IMP),
 	FEAT_END
 };
-- 
2.47.3

