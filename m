Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859462;
	b=NDyJBNHa0T/wx2M2+qv6Nk+hZE5Kh2wSVkBfL7usAjqP+kDchroRHc539Ui3L9+whSlB
	 TIzIIQcEfg6u7Dccpp6zzeQ6KEhLLDEPPh85fUCez8w0KeY/WKiouqvanfNNbLbmTcwvh
	 1GqZihIVVzbxrlSL+8hUeltdpQGpnOIOjmQ4mdjY81EBmnIC/XZSBko+CBoKgx7HamMzN
	 7BNrKLvarR9+Tf8lmTJ4/hy7ZA7j6mAVY6i/wQIGJo6ShI/e8E8uJbYjm4tNFoTeyqVg8
	 6mbd8lhy9aWkNP4tG34iK/uD1RDMv3Vt9auz/7GurAY9UYxGAI52tl+HT3iHwdKZpCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fLiUogQDb6C/5hkqgN4Zccv3qSnCF6DVX/+qKwo4uaw=;
	b=S5/1k8j1QqXGiUiHSyH+u6hcvZX+7ZvQkImsFpkeFbvMGYYpGly5Uyts0K8SHBf2zM9I
	 KBWroeI6fhGstLVXOuUQnkGLsgmOklJfE1DDiRScNUOxzkC/P9n4nJEDwe9AWutI2Uis3
	 ysuG+v/GvDHHsUiok3vZedxyL9u1REe63PfAQSGlVaDHhmKl36LF+IkYog+4qxFr8upjv
	 x+hc3ec4aZ7L71/369y/lrzh8cGH1TWd29nG2P8+A49AWYDOv6xywDTAW1oA3eLjE1WBk
	 JjPDt3FTYHTTzoXZoV6iChvf4x+w0xd1WS9+7vrKXPboBf1/9D27OJot8Q+QD2464fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RDEQRVk+;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE6606A337
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 20:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9EE6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RDEQRVk+
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c55ba309c2so4637824b6e.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 12:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794859461; x=1795464261; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLiUogQDb6C/5hkqgN4Zccv3qSnCF6DVX/+qKwo4uaw=;
        b=RDEQRVk+yllJqIPIQjT4G3hNKoTlmWNFC9b669xhX8fvN0OTHrYERCTP5oIPp3h/WS
         qvY3lOaiN1lx8pNWRzZUZUoa20dnklNupLoI7iAEkq0oycd6J7KPOlYagJ5+FGkKM6tE
         Z1LGnkkmGrjSx2PtSObfovA8hHE+HPfCTLHax7nd1W4fr0gBlc+y3ZXnWAFaoCEoVBOx
         OBd6nYsw5iEnw1MvuiWPt5arne7mR17iGJ3jJuHwHC1LV9ygL45nAVUzuu0lvVWd2Jow
         3ESp2QdqAD1KjSwyqVnZ7mjoneYP1muhn2ccNAqbjqLUOkQvNA4xyVswt1rChhCHnxG/
         2/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859461; x=1795464261;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fLiUogQDb6C/5hkqgN4Zccv3qSnCF6DVX/+qKwo4uaw=;
        b=SCXBBhbjSKoL9/xePNwlcGGVmIw54GN1lpfAKZYbFxJ8Lwwoeoo7CKhrFRh43IGbcT
         +Ct1XFgvmvihNwqDIrCoVXCbFNAonXmyJAAnarxfRwZ1vMotwoOJfUVoz6Ut9T2fvHbc
         SYxmYgQULfS5UORW9zgOM/hOPxyW0YHw3iiMmRNiMoHVtlDyIerVXI92r97TeB8Fk3S2
         NN0b64qzALxFMzXbB18li5mHNo9QGZSVBoIPE7JAGffLg6M2ax6PcwavLfkpyuhBO3Kl
         jQ4RoE2GWt5ZNnYG2pNZw6ounARvNFmuHejD/YcKWJgTXv1Y6xitsSx10U8qgsQnZuxq
         JNPA==
X-Forwarded-Encrypted: i=1; AL+hErEEyCz7r+8+a0cud+icTbMwNSNsdDuwotJaMBmnEdsMt9dc7ccEa3qEyaJ2Jai41Db5Hy0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pqwuOlSQ5KtWROto2+iZpX7NhNdRTnFerA4+qks/ZjqdDvmoc
	8whEoa0rkVGEAiz5/QgGdCNtfrtIlppi66+PVRpWEDDiqsi0OkxkukE5KkIaOhCssO73aOiCs91
	1tcseiIpFrckDkLwR4bJABPvuOQ==
X-Received: from jacnj25-n1.prod.google.com ([2002:a05:6639:299:10b0:60b:77aa:12a3])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4d06:b0:572:86c8:6b4c with SMTP id 5614622812f47-57286c86d22mr6304607b6e.6.1794859460579;
 Mon, 16 Nov 2026 12:04:20 -0800 (PST)
Date: Mon, 16 Nov 2026 20:04:17 +0000
In-Reply-To: <20261116200418.3535619-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116200418.3535619-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261116200418.3535619-2-coltonlewis@google.com>
Subject: [PATCH v1 1/2] KVM: arm64: Fix inverted E2H0 check for HCR_EL2.NV1
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

ID_AA64MMFR4_EL1.E2H0 is a signed 4-bit field where:
  - 0b0000 (IMP, 0): FEAT_E2H0 is implemented.
  - 0b1111 (NI, -1): FEAT_E2H0 is not implemented, except HCR_EL2.NV1
    is implemented.
  - 0b1110 (NI_NV1, -2): Neither HCR_EL2.E2H == 0 nor HCR_EL2.NV1 is
    implemented, and HCR_EL2.NV1 is RES0.

Prior to commit b2a324ff01fe ("KVM: arm64: Use HCR_EL2 feature map to
drive fixed-value bits"), kvm_init_nv_sysregs() marked HCR_EL2.NV1 as
RES0 when !kvm_has_feat(kvm, ID_AA64MMFR4_EL1, E2H0, NI), i.e., when the
signed E2H0 field is less than NI (-1), which matches NI_NV1 (-2).

When converting HCR_EL2 to the feature map, feat_nv2_e2h0_ni() was
written as !kvm_has_feat(kvm, FEAT_E2H0), where FEAT_E2H0 checks
E2H0 >= IMP (0). This inverted the condition: feat_nv2_e2h0_ni()
evaluates to true when E2H0 < 0 (including NI_NV1), leaving HCR_EL2.NV1
writable instead of RES0 for VHE-only nested guests where KVM advertises
ID_AA64MMFR4_EL1.E2H0 = NI_NV1.

Check kvm_has_feat(kvm, ID_AA64MMFR4_EL1, E2H0, NI) in
feat_nv2_e2h0_ni() so that HCR_EL2.NV1 is treated as implemented only
when E2H0 is IMP or NI, and forced to RES0 when E2H0 is NI_NV1.

Fixes: b2a324ff01fe ("KVM: arm64: Use HCR_EL2 feature map to drive fixed-value bits")
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index adaf26ab93b85..b4f555d39f54a 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -258,7 +258,8 @@ static bool feat_nv2(struct kvm *kvm)
 
 static bool feat_nv2_e2h0_ni(struct kvm *kvm)
 {
-	return feat_nv2(kvm) && !kvm_has_feat(kvm, FEAT_E2H0);
+	return feat_nv2(kvm) &&
+	       kvm_has_feat(kvm, ID_AA64MMFR4_EL1, E2H0, NI);
 }
 
 static bool feat_rasv1p1(struct kvm *kvm)
-- 
2.56.1.750.gf70dc682cf-goog

