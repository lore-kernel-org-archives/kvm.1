Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621158;
	b=qADGLCObHttdA4uDWHlWfC+z6NaukramrjCzv/ObZ+Hmbc6Mugh3au24hSbvX8i9sN3U
	 n6QNkD82kapxBmnxYlk09KQ1Zt2oYIc4wVOFNT1OyBKHDIrf4YQ7FAX7kU4KIqSsw9ov1
	 TfpdK5XVZTZcIegB3E9knQPJscj8iz0lNgzQ2ClIe7vDU2mZmZBsd1w3FS1E1hucntuN+
	 lISjnPYnqq167pdaYEybjzpCoU2v8WPcSHd/08bkWMgkfm7gTG+JzaAkLJfmlLcI8aCHM
	 ubjGfqGdb9NrywLRB2Hs64mW5j2kBE1qsP0wFtExRsdvSf7bwBSSNdSkhAeuqiBS/ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621158;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eCGx1X8DR+pHjH9W44J3Lh82/2sl2cpI/RianqMEYjE=;
	b=yzbmer4TD1S81QxGAf/Upezkxhfd8C/GN5I9coRVteArxvedd6edd7NlgkbFD5Gy/Ucn
	 SKcxAiknzBQ08j394rT0R5D+fn6tQYRGciAe/KJt9EGisuh2q73kcaOkdYhrHByoEiCm5
	 AP4X6/5TyZrHF9TslrMiGnOqFI4/5WYRs296SyGAqZrW00uXsvoA6UIN+ns5XxDbN5l1a
	 9pZea164LMYvrJqkb/rQu2HrKTo5YQEtQTReGdx0D8di5JW6J2Xg9BOUwdF6gZUi5MrLP
	 dZgfRP0Uxcf//sfvIU1Rid11u2N6JWIiRZzfm/PZYS3zkk0d9OwWKsvQrrmxAcfspiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="uEGoc/GK";
	arc=none smtp.remote-ip=91.218.175.93
Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871D606A334
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5871D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uEGoc/GK
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=plWnGSA+t40iciXF75RUGdCCByZ2c9Fur5xw/PdG3iQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795621155; v=1; x=1796225955;
 b=uEGoc/GKCvssycowstrnGLuAYNix5t8Pc/tsZFyFww3d1R3QZXd1AiauzmkCYdr5ziZAf+Rq
 DZivHihoNF5+liWvKQJuiUXgeO2xc6S/Wfmd7O9EAIweS5pW1AQ7WYrRyjUlRcr5UqVLh6NXpAm
 T8kirCGpv0l8GVxnfDEM08cU=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cccc4519f60a0c77;
	Wed, 25 Nov 2026 15:39:15 +0000
X-Mizu-Trace-ID: cccc4519f60a0c77
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
Subject: [PATCH v2 01/20] KVM: arm64: Only allow ptrauth for a pVM on a system with full ptrauth
Date: Wed, 25 Nov 2026 15:38:52 +0000
Message-ID: <20261125153911.106793-2-fuad.tabba@linux.dev>
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

EL2 allows a protected VM both ptrauth features whatever the system
supports. An id_aa64isar1 override can leave a system with generic but
not address auth. EL2 then doesn't trap the guest's key accesses, but
it doesn't switch the keys either, since the switch is gated on
ARM64_HAS_ADDRESS_AUTH. The host can read and write the guest's
APGAKey.

Only allow the ptrauth features when the system has full ptrauth, as
the host does.

Fixes: b56680de9c648 ("KVM: arm64: Initialize trap register values in hyp in pKVM")
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/include/asm/kvm_pkvm.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
index fd042d2b54624..155ac35069245 100644
--- a/arch/arm64/include/asm/kvm_pkvm.h
+++ b/arch/arm64/include/asm/kvm_pkvm.h
@@ -76,11 +76,14 @@ static inline void kvm_pkvm_vcpu_allowed_features(struct kvm *kvm,
 	if (kvm_pkvm_ext_allowed(kvm, KVM_CAP_ARM_PMU_V3))
 		set_bit(KVM_ARM_VCPU_PMU_V3, allowed);
 
-	if (kvm_pkvm_ext_allowed(kvm, KVM_CAP_ARM_PTRAUTH_ADDRESS))
-		set_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, allowed);
+	/* Without address auth, EL2 doesn't switch the guest's keys. */
+	if (system_has_full_ptr_auth()) {
+		if (kvm_pkvm_ext_allowed(kvm, KVM_CAP_ARM_PTRAUTH_ADDRESS))
+			set_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, allowed);
 
-	if (kvm_pkvm_ext_allowed(kvm, KVM_CAP_ARM_PTRAUTH_GENERIC))
-		set_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, allowed);
+		if (kvm_pkvm_ext_allowed(kvm, KVM_CAP_ARM_PTRAUTH_GENERIC))
+			set_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, allowed);
+	}
 
 	if (kvm_pkvm_ext_allowed(kvm, KVM_CAP_ARM_SVE))
 		set_bit(KVM_ARM_VCPU_SVE, allowed);
-- 
2.47.3

