Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034189;
	b=p6qolaH9TQJrL8bdkby4gdjvAv4tfsgvrdLiado9vJDP050lZtZm/Jsr1D7J0P97yHVN
	 XHA0kPqeAMiIjImcyY/9lX/pw+znP4THzQpx1LX/Ee31k32Vpe0eAIrt46RAMNdwxJPJD
	 B8prlrfbmvFxLzAh1/kZK1b4x8mJDwl3P38uDwAYH8hpjcxWrLI5YiLrdX9TFjjDIdPwJ
	 hj8rnzy+dV3QqPgzggulC1ZX7iPPlNsuxPSMXlK4bCTkHLdPpP51qRxbzM8FnaMkAlsex
	 5jE6bn1OtVFafQqGno0ViMf5qmf+1fHWy4fpKk2XSFCzUaAd5IG4RSbM4MDqvTvYNiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=lv45tREYCt7GqWPtl8xyiubGXsrPN8dnOBdjmKX9gXA=;
	b=pFs288PJZh2yCK5Bj7y9WcAnqlfD/vE+P+tKQqZjZ4TlCLOyAK/iPY0+8PhK3V9DDQSk
	 LZw4RIekWO2IY/QeFhZE475j5+f1y5LwDpKYkk+dDN8+0b0HUpMhNHhCvBsUXUWZTmJCn
	 FyJRL8UGwP8pT/pb0Cp3Z8K9jFE6CPbXr6ofJe0vACHQoM517bq8d5QVwRBxlBaKTIhxP
	 rBuM4Yrp76tK/4ZN8VeEcR5DxmZ8ljM5gNDsEB9mAEj4cqzkWwAE4xNfYzwde7Rr+RgVR
	 lEeUKByF8UmzH1K/4lfx9OMezpyhuW9tv4azbOfOTvJu+Y3G6M1sVp85Kay8khe/Cag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FYbddi6Y;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7EA606A336
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 20:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A7EA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FYbddi6Y
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-5735cd94235so1382042b6e.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 12:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795034188; x=1795638988; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lv45tREYCt7GqWPtl8xyiubGXsrPN8dnOBdjmKX9gXA=;
        b=FYbddi6YV90/uod/Pr7WEfiEWdsdPsB2OGckVrsrUJvCcVD47FPftzcHkAz/tOYvqK
         7/TCudxMEbJEJhlMknuWZ/xy0fjvDf3zBaTs+cqHTHf0k7heaHkzts9DyAd6TY3nk9RS
         v+9+yGsVX7EG0pHOm2sX545OjjnXkgudL0trIl+Ya/X5+389pZeOb7ym8+pUiBxNJxNB
         kHRsiHfUa0xrNgN2Uovlq0Pg8UwKvVTN8oxa04MCHbwOjQiu201M2v+g28/+ewJkE9b3
         WndZQ9bgVcXqL9pSV5ApVXzcjcwKmXuygzKLdGE2ZBPisW1/zGPhKW3ZM0f6hao06jGr
         NyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795034188; x=1795638988;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lv45tREYCt7GqWPtl8xyiubGXsrPN8dnOBdjmKX9gXA=;
        b=DeE84YLF6eaE2sxYtxPpwHF9k0VPa/GhMthVnmIir1DYcpV1AIA6/Fg7AtgoX5KYQ1
         5RNA3jVTw/r8siYRaFNvb1JGGRbs74EvuC3XYjedAtpgANnagnx1pXUztyWQf8oFBrXB
         qSG4NSLnMwGFqk6a/QyskbFWS6UltJIEBGbVHw2cX+bZrV8MlgA1e6s/NFyTpGJagkRj
         zuHNuDrJ591hBBk9+ZyOzMgA5V99j+vLmya3BuP2vXHbm+hDM5gO8mkNhYceLvsdF4r1
         8QvEXOLm0OMA/hG5KOEYVn58Rf/Wxy8ERp7HGDgz2fu7syw8zr1xUb0V4+4IrZOlmCPX
         ImcQ==
X-Forwarded-Encrypted: i=1; AL+hErHlB35OwtXPyogbhzysstm33R6sqDmU8kAh8/y987dlstNUSamsn8TvBqIRbw1kO8vRqMI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1tXDQFCbHDL21rMEs3AVtT4gzgoBi7m6b2sz4FEwwWo/PVOWC
	GFF/+d9OfmWKVMLSx/dn5+md17As3KA1owo2Kjrte5FaDv0FpdZgnTqDSUZsXqUMw1SnbNx0w16
	y0jYt4CkdHLFy747nihJebuws5g==
X-Received: from ilrb6.prod.google.com ([2002:a92:dcc6:0:b0:547:9c99:d6d5])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:f13:b0:573:399d:d487 with SMTP id 5614622812f47-57742f41c5emr4038906b6e.65.1795034187562;
 Wed, 18 Nov 2026 12:36:27 -0800 (PST)
Date: Wed, 18 Nov 2026 20:36:24 +0000
In-Reply-To: <20261118203625.743428-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118203625.743428-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118203625.743428-2-coltonlewis@google.com>
Subject: [PATCH v3 1/2] KVM: arm64: Force HCR_EL2.NV1 to RES0 unconditionally
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

When commit b2a324ff01fe ("KVM: arm64: Use HCR_EL2 feature map to drive
fixed-value bits") converted HCR_EL2 to hcr_feat_map[], feat_nv2_e2h0_ni()
was written as !kvm_has_feat(kvm, FEAT_E2H0), where FEAT_E2H0 checks
E2H0 >= IMP (0). This inverted the condition: feat_nv2_e2h0_ni() evaluates
to true when E2H0 < 0 (including NI_NV1), leaving HCR_EL2.NV1 writable
instead of RES0 for VHE-only nested guests where KVM advertises
ID_AA64MMFR4_EL1.E2H0 = NI_NV1.

In practice, KVM cannot handle HCR_EL2.NV1 being non-RES0 in any
configuration: limit_nv_id_reg() exposes either VHE-only EL2 with
ID_AA64MMFR4_EL1.E2H0 = NI_NV1 (and E2H0 is not userspace-writable), or
FEAT_E2H0 without FEAT_VHE or FEAT_NV. Checking E2H0 in a feature helper
is therefore unnecessary.

Drop feat_nv2_e2h0_ni() and mark HCR_EL2_NV1 as an unconditional RES0 bit
using NEEDS_FEAT_FLAG(HCR_EL2_NV1, FORCE_RESx) in hcr_feat_map[] (shared
by HCR_EL2 and NVHCR_EL2). Because HCR_EL2_NV1 is not part of the
architectural HCR_EL2_RES0 mask, check_feat_map() accounts for it as an
implementation-defined FORCE_RESx bit.

Fixes: b2a324ff01fe ("KVM: arm64: Use HCR_EL2 feature map to drive fixed-value bits")
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/config.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index adaf26ab93b85..2e81f45dc9921 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -256,11 +256,6 @@ static bool feat_nv2(struct kvm *kvm)
 		kvm_has_feat(kvm, ID_AA64MMFR2_EL1, NV, NV2));
 }
 
-static bool feat_nv2_e2h0_ni(struct kvm *kvm)
-{
-	return feat_nv2(kvm) && !kvm_has_feat(kvm, FEAT_E2H0);
-}
-
 static bool feat_rasv1p1(struct kvm *kvm)
 {
 	return (kvm_has_feat(kvm, ID_AA64PFR0_EL1, RAS, V1P1) ||
@@ -1034,7 +1029,7 @@ static const struct reg_bits_to_feat_map hcr_feat_map[] = {
 		   HCR_EL2_NV2		|
 		   HCR_EL2_NV,
 		   feat_nv2),
-	NEEDS_FEAT(HCR_EL2_NV1, feat_nv2_e2h0_ni), /* Missing from JSON */
+	NEEDS_FEAT_FLAG(HCR_EL2_NV1, FORCE_RESx), /* Missing from JSON, RES0 as an IMPDEF choice */
 	NEEDS_FEAT(HCR_EL2_API		|
 		   HCR_EL2_APK,
 		   feat_pauth),
-- 
2.56.1.750.gf70dc682cf-goog

