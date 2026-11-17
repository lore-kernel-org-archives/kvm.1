Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794948339;
	b=b1v8ia/ZL7vLuKP3JT/k3j59wzAKxRwuz73Nvg0s42uVXobWfuZ1xi8lZeSn4XscVkvZ
	 QBDh+tpxuY531ukFogNDSOmSZtcczYBYvb5qgiEB4uTXUJMdIIbdyINdIdho9qJJRvKQo
	 94WUE0qzie5CeLpuezTfZWJ6hTuDUpXQYW3QSyqazBGi85Ib0L9JXJWCMbv+IJv32B0/4
	 FwV8UFmonnCGryOlpyvpaLzGS35AQZZCsj8cDKA/5d2oam1LspXM+PVfW4z4ArAcEEqnv
	 2JxUhM7lcyisUtpdmfsBPZpYmIGDeS0jDcM3KoXfoxI6j18hOvlb7fqExkuA+xjoS6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=HGXQysssI9IIITPAFgPzUZG2M/Bh6Ayigq869gs8CCY=;
	b=ntlQ3CKjDIzEOhj8Ib7gVn3/AXpzto7wlqP53A6/Q03pjL5lrdt84u82oKLnBGFlbaEI
	 c++PrWmG1LFC4MEGLctA83E7mTc50QelKnDgwRTTsV6HJwigJnkR7Ik9VUq2v0k21dCbh
	 gR6KYa8zmhBDTnnjmAeSK8wPtGMSStvyoo1wGWbZsh5OM8DuVLjgdqFgpi0YPUHfJjoJa
	 q3CoeOPT5aw+fnJiTtVMSr73zYYH0tW5mT56FyUIJf/x8/CkMEdFTCoSQnFMUX1SqncuL
	 SDDZG23/HGOuO3oeXD4ZeTsH5JWbD4E6LdYTl/V7cV7+4Lc4OoSdpeUvnTyDrQzOOOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XO4i0Ipc;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6DA606A332
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 20:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE6DA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XO4i0Ipc
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4db3db8687fso151898b6e.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 12:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794948338; x=1795553138; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGXQysssI9IIITPAFgPzUZG2M/Bh6Ayigq869gs8CCY=;
        b=XO4i0IpcUTTemyH4FhJiThMAO6FqtaVWNLI3aaiXE0uYm+PbSDfmWPj3l3H2fF7xiP
         fpwAmG0xSOkd07z5jznOK+07xJXDhayMsRt9++sYmP1idpFip7xL0K4vfZVTvcdLxGnv
         a41SDGu4OSsKl7noqpBTF83Jc+q7qQE3EtpI5UaFB9eUpZMq1QGPpbA+s+kjsorG5WCR
         3+pleoYKtm9R4spXx7HC33VnWukI2BDsRKweyw+sVPK6tun3b2rLnA/Is0Rlnrc10lcY
         vmliRE7ullx4OFd/jF1Q0FtAuBiGNCwO/54GRKNduOz58xN1bMW2s5N6w01kFrRfwToO
         yovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794948338; x=1795553138;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HGXQysssI9IIITPAFgPzUZG2M/Bh6Ayigq869gs8CCY=;
        b=JXPH+MFz0S0kUga3FVjJ6cgLhuICalKbimJ8Sm3L8uUwsdJUeogmnfxIM61f2z39Va
         hX4moSrX9qug9K8o+EW0380x1AdRYjrWB9tjkZ9+dtFwbn+w8S+gq5wGL9qt/uYf8TZL
         PIoOvJdcygBvIXG5ZEBmXKdx44POelGP7XM/eSYFfKEZl/RypL3MRTH73teDB8qtESRB
         5kTgkwzGRvG4HODCfqzKbhXRbuqTirOfzrgpn3+NRFpGiTzYQoJCAusLeo4p3i1CK0Uw
         voU8JFiO96uBaUI95w2ibbFEp5vXA3Zi/uenMMYXvAjASs8uS/8vjg54hwjvJ5VRb8cI
         Drxg==
X-Forwarded-Encrypted: i=1; AL+hErEgHcUs2/sTOgP71WzjrAU5MVAfEZqWHvwDcl77Ia4sJ8luNEPE2oYd77FY0m5j8mzWdqU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bowCjGH7h/zAfn4qB4xfFggN/9Q8q15YlkNnFlSnh/I2knl6a
	hHWv3xAbDTlF9o8QU0toleIEXwFeNOQ8InuxjjxIuukqzJ/eNZPgpPm0xLtPrAWSNq9d9KfKHeG
	WbnIXhkcCqlT4bY7WgXM4YL2rwQ==
X-Received: from ilnd10.prod.google.com ([2002:a92:d78a:0:b0:543:4359:a143])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:bc9:b0:574:524d:f242 with SMTP id 5614622812f47-5773c52675fmr1094757b6e.26.1794948337558;
 Tue, 17 Nov 2026 12:45:37 -0800 (PST)
Date: Tue, 17 Nov 2026 20:45:34 +0000
In-Reply-To: <20261117204535.4036191-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117204535.4036191-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261117204535.4036191-2-coltonlewis@google.com>
Subject: [PATCH v2 1/2] KVM: arm64: Fix inverted E2H0 check for HCR_EL2.NV1
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Leonardo Bras <leo.bras@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, kvmarm@lists.linux.dev, 
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

Check kvm_has_feat(kvm, ID_AA64MMFR4_EL1, E2H0, NI) so that HCR_EL2.NV1
is treated as implemented only when E2H0 is IMP or NI, and forced to
RES0 when E2H0 is NI_NV1. Rename the helper from feat_nv2_e2h0_ni() to
feat_nv2_nv1_not_res0() to clearly reflect what it tests.

Fixes: b2a324ff01fe ("KVM: arm64: Use HCR_EL2 feature map to drive fixed-value bits")
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/config.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index adaf26ab93b85..a975ac73ed876 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -256,9 +256,10 @@ static bool feat_nv2(struct kvm *kvm)
 		kvm_has_feat(kvm, ID_AA64MMFR2_EL1, NV, NV2));
 }
 
-static bool feat_nv2_e2h0_ni(struct kvm *kvm)
+static bool feat_nv2_nv1_not_res0(struct kvm *kvm)
 {
-	return feat_nv2(kvm) && !kvm_has_feat(kvm, FEAT_E2H0);
+	return feat_nv2(kvm) &&
+	       kvm_has_feat(kvm, ID_AA64MMFR4_EL1, E2H0, NI);
 }
 
 static bool feat_rasv1p1(struct kvm *kvm)
@@ -1034,7 +1035,7 @@ static const struct reg_bits_to_feat_map hcr_feat_map[] = {
 		   HCR_EL2_NV2		|
 		   HCR_EL2_NV,
 		   feat_nv2),
-	NEEDS_FEAT(HCR_EL2_NV1, feat_nv2_e2h0_ni), /* Missing from JSON */
+	NEEDS_FEAT(HCR_EL2_NV1, feat_nv2_nv1_not_res0), /* Missing from JSON */
 	NEEDS_FEAT(HCR_EL2_API		|
 		   HCR_EL2_APK,
 		   feat_pauth),
-- 
2.56.1.750.gf70dc682cf-goog

