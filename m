Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859461;
	b=MKfLvy/NTXImMyOzQ4aLdeYOCgexsSqQtXwcJRJw84uwpDYdM2qE9IBwKn4Fgy93xTva
	 625Fub0KUBljfb4YGg3DyqmN8F0uN29C1YhXvdV/5o1qCfMcw1htx7gZMTL5VZeeM816g
	 pQKLQjSgTBN3pdRBXe4ZZThzGbljn+SnSgieHUUB5k8jqrI/Kpo3jJIkfp476zxOooG4D
	 UiSEO7zrNo5Rzvpwc1yL1Ul06/Ra9etUAKAX//PSKgWuBOKULOSvMQJrN7QrBrYgjLuK1
	 3CrRFhcOLQNm0Kwfg0MpEkSiIUP9gq2ztUg52SozDPURyQ8I+Gl9UEH2MaetFaKYvGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=9bIAYBNiz3NB6EQnZLvtp2y9CTLyvsz22fhiOVY49c0=;
	b=yBWZdp6f8nFBkgKLsPLIMU8t1uDy7FWQQZK4X9VIGKA5XczO8dt71daAl6qFaOwO5m3b
	 9IJQcNDxI3TTb70XOma1uUfomchBtRt1KoYezCaUh09IsmRaQB77TuTp5JQ7Av5NxybA+
	 n4tpirFHb4kVTHBsjiCZLYf//eD/8WxD1DfRfjImgg3MROXIsVPkRZZW3ezdGy1KsE1va
	 JVTGqdLdSkW2tkn4euBpnn0vSm3WD3Sx3SfkkBqyuX8x6XFQnVve+VWzmkeR7ZhbPc65b
	 IiMKfNvdy+4Kg0PVQO71tkGbfaoUuFwxkEDSSA07pP+K4mE1OiXksmNMWscH9+/OHlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kFM0luVl;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C82606A33E
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 20:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20C82606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kFM0luVl
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-57289376805so2136607b6e.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 12:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794859460; x=1795464260; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9bIAYBNiz3NB6EQnZLvtp2y9CTLyvsz22fhiOVY49c0=;
        b=kFM0luVlAyaPnMpEWBHZHbtT9nQHMti5+YD7xXHIEjvpiSWGcR1jxqzmVRhcdQoL1H
         e1GTdSnKKtLt0AqjruwQN5b14Eb11WkzOsx/p+sxMTzAR69HjKRVVZfxfPURYC8pnUtD
         mx1H7nFJwodVXgiNqAsmmVA8WayS9g+TSZHQWIvitH6H4ZAp+1mRDVCS4Wl6pMj9lhR5
         D9BWXLBH3ubKPehBb/xjl54AfUd37KU+FwyKKLRjtkS0qHepXley/lT/hgpR9fl7BWkS
         4JeaUkut0V8u7x91IMLRMfTSzKQrZBEloSrIMIfnIYZq8K2qNBQQdplukIRLEOwigmlS
         Bb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859460; x=1795464260;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9bIAYBNiz3NB6EQnZLvtp2y9CTLyvsz22fhiOVY49c0=;
        b=dasb9FQiZR7bOtiJX2JP6KOqEYrbmhv2FlZIv+NeMlPJw1Gl6uuBXH7dqDEWBlcp0p
         kUBQuQJjovKsRt8csbjDyiHYt0KiOb5Fp7xE6iSu8xNMP0m+iMrYql6avUXKBHNyIpQZ
         SCFdUdu7BgGIEfBhSGyajExNFcNxnOUDD4/lXq5C6dN3fKOzgnRFjfeiDt78ro+M2/DX
         Qora+XiYN8hmxabtDoN7s+ma4MbVZyF5IwgzcdEJrbJ66BlMuh6HHfG0sGHf7r/Z7i26
         ISY3zP9giTRrjLb1NUCwUOtUrrD/kYNvaXPTXemUhBMUkPgDzjUdnfud1e3ubdZN5ml9
         xR9w==
X-Forwarded-Encrypted: i=1; AL+hErGE+D99eoJRFG2Q+C3rJftZePQkTUpe9ONu9CS+eOwVgzZu3zUlII4tMoYGdoYElcQh6vU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IoSPWQPQ5awFO6v4CLVxBECMA8OjuIU06IrkM+zNVTCJANYtP
	8Sro9VCAiY3E3DywxlPbPlHx3glX7+ie1hcNDSLpe/ml5S4Npz61jpmDTQMwNBqOGOJRUFVU6fy
	1QuDAvqmRu3Z23B18aYnZioJZTw==
X-Received: from iodf4.prod.google.com ([2002:a05:6602:62c4:b0:9ca:727a:80b2])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:152b:b0:4e8:721f:2824 with SMTP id 5614622812f47-56e65625626mr9335826b6e.60.1794859459512;
 Mon, 16 Nov 2026 12:04:19 -0800 (PST)
Date: Mon, 16 Nov 2026 20:04:16 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261116200418.3535619-1-coltonlewis@google.com>
Subject: [PATCH v1 0/2] KVM: arm64: Fix inverted E2H0 check for HCR_EL2.NV1
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

When commit b2a324ff01fe ("KVM: arm64: Use HCR_EL2 feature map to drive
fixed-value bits") migrated HCR_EL2 fixed-bit masking to hcr_feat_map,
feat_nv2_e2h0_ni() was written as !kvm_has_feat(kvm, FEAT_E2H0). Because
ID_AA64MMFR4_EL1.E2H0 is a signed 4-bit field where IMP is 0, NI is -1,
and NI_NV1 is -2, !kvm_has_feat(kvm, FEAT_E2H0) tests E2H0 < 0 and
returns true for NI_NV1 (-2), leaving HCR_EL2.NV1 writable instead of
RES0 for VHE-only nested guests (and conversely treating HCR_EL2.NV1 as
RES0 when E2H0 is IMP).

Patch 1 restores the check in feat_nv2_e2h0_ni() to
kvm_has_feat(kvm, ID_AA64MMFR4_EL1, E2H0, NI) (E2H0 >= -1) so that
HCR_EL2.NV1 is implemented for IMP and NI and forced to RES0 for NI_NV1.
Patch 2 extends the arm64 hello_el2 selftest to verify that HCR_EL2.E2H
remains RES1 and HCR_EL2.NV1 remains RES0 across both guest EL2 writes
and userspace KVM_SET_ONE_REG writes when E2H0 is NI_NV1.

Colton Lewis (2):
  KVM: arm64: Fix inverted E2H0 check for HCR_EL2.NV1
  KVM: arm64: selftests: Verify HCR_EL2.NV1 is RES0 when E2H0 is NI_NV1

 arch/arm64/kvm/config.c                       |  3 +-
 tools/testing/selftests/kvm/arm64/hello_el2.c | 34 ++++++++++++++++---
 2 files changed, 31 insertions(+), 6 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.1.750.gf70dc682cf-goog

