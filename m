Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794948338;
	b=qM5VRmea4yi00mJBRKW8SBdELF/wV3+WT52XDhCDP0XcykXe+Izm9iYANrSHNMdNC6eC
	 HlL0N9UW6vVf9P2Mxrfu+mebOxC9lTtsRjQ18aV6F36qfnwld3jpcVumTDwiyuwCDnVYa
	 PEbgfXsnVqOjHZUKe09swquZWMXX2VapeT1lHL42I2++iZIOQaaMqc/AhY49Qx8S5MSDD
	 zer6I62OqWMIRuaCQaxFcedZ6hdQNMQUneDRUgCCB0t1s/juufWpj5uToKV5r0m7YMWOO
	 sjkHgP8l4uC7kgm43CJTmbC15DTEE7udwvcSIkR0tQ5uyWH4DxbcjAvRSDbHY23t57A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=b6mleucbMdhj8MjjlIVwGs8yhAGAA7tst/tBmXQB1UY=;
	b=gDxIS2t+mDWYpABlofC1hQBSBN1LwdVLvRj8qtsBDlCW7gSNrCjqczv7iusLip4AymYW
	 N0n22HLlYy8pIJF9m+4z/QAL6isdv6Aux2up84/vW7I7WcB4P3NPOS8gIE+tXJR/9G7wS
	 9tCa3DiMkA09FWpU6rXyvTXJDpBwXyR+U0ZekewafsOZQcnO5zgbFQ61hfyWBWB8nlHLx
	 1MZnwE6WldwkzUmLE+ZTDLIe16H6wSizwgdi31kKOdXkIHppbJtophSKiuXI6sttfkQe+
	 SCGcAH/PmSSYO+YNBEAK1pbLGtaMlUWQjw6qEkNlLKHZghJUZKh0UOuT6KutYtRT+8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aPeV3cXj;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C5606A32A
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 20:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D05C5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aPeV3cXj
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-567e742f481so101937b6e.3
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 12:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794948337; x=1795553137; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b6mleucbMdhj8MjjlIVwGs8yhAGAA7tst/tBmXQB1UY=;
        b=aPeV3cXjFGitT+FOJiUVFoAoNlXls/aeflQhDC0JgOwjtiDak8NO0WeizwzFkjQz3O
         bspwRDJySpsRIY0dG4SR9EO/7jEWdVHpH5GXBigT5l+nvyvDg8tVgQW8Eu+pRLxDRqdi
         1bwNKZziQdfySYBTIH83/C2ocBAzeP1Mc86oXeUge5uiX24EtGqzz1BRUjAoWhZMMpik
         pW53kLksvVjKF6d35pL1vMwzg4r3q77xAjWdJuqGqw6QER+Fc8YBswMyifnxkwgmE6JT
         EmXn/PVIQISb0+FXsf36ltXqbcyzNPUDRr35lX7XN83SnvnHKyAI2LjlW7iKDnEqnuTo
         a/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794948337; x=1795553137;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6mleucbMdhj8MjjlIVwGs8yhAGAA7tst/tBmXQB1UY=;
        b=wfnWoOqIOn9JedDzIFCFC+QH6bdRzHWUznefOBnerGYrKas2A2fk0w0rjXcfQtipAf
         M73enBv/JdIxAX6rIR4ljBybO3tU9l+0YDHbGcOC27yGRKKQuRPv1uGVEJFZLOsdjs2U
         pjNnbrlcJZNrrgNe5l6a4knMdtltUTWWhxC2THBuoQW/xFmuYA/Ub7JiahtVmKWAOpMq
         XoxC+GikLtMRXP8q0OZQLrvkSyFK2rNBUgCY6OP83BvRmvhxJREY3iZml5ySlUP34jz8
         KA8/iX1LhsTBCwxN3U71IkzxkFXBK1VoSWKaNW6bpzURDUpAF9Ql4+iCXd0Hl8Q3PkUA
         XYCg==
X-Forwarded-Encrypted: i=1; AL+hErFR52pisvmB3hzxAsJnHOnmg5GuNa9QZKH40cKBgAoc7DjfzA4FZyFu3wkaKmc18dPD+MI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TIFpXITKKQPW8njiTb1Xp7MfDDmDBiSY8xKJwvnRLydVxs/Jk
	pLZqCLU9s3+0OIfnYzDF9TfHEyWJPatQlVqx+krs/BCWk0ERT5C5k4VV0pEz4p8sxG7LDo2S/AJ
	Ewmj9HcEiEho3vPfXdrQsiHd+WQ==
X-Received: from jajg7.prod.google.com ([2002:a02:c547:0:b0:61f:ecf1:1cac])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1387:b0:4c3:e93e:e331 with SMTP id 5614622812f47-5774113234amr977571b6e.30.1794948336458;
 Tue, 17 Nov 2026 12:45:36 -0800 (PST)
Date: Tue, 17 Nov 2026 20:45:33 +0000
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
Message-ID: <20261117204535.4036191-1-coltonlewis@google.com>
Subject: [PATCH v2 0/2] KVM: arm64: Fix inverted E2H0 check for HCR_EL2.NV1
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Leonardo Bras <leo.bras@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, kvmarm@lists.linux.dev, 
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

Patch 1 restores the check to kvm_has_feat(kvm, ID_AA64MMFR4_EL1, E2H0,
NI) (E2H0 >= -1) so that HCR_EL2.NV1 is implemented for IMP and NI and
forced to RES0 for NI_NV1, and renames the helper from
feat_nv2_e2h0_ni() to feat_nv2_nv1_not_res0().
Patch 2 extends the arm64 hello_el2 selftest to verify via
KVM_SET_ONE_REG and KVM_GET_ONE_REG that HCR_EL2.E2H remains RES1 and
HCR_EL2.NV1 remains RES0 when E2H0 is NI_NV1.

Changes in v2:
- Rename feat_nv2_e2h0_ni() to feat_nv2_nv1_not_res0() to match the
  condition it checks (Leonardo).
- Drop the guest EL2 MSR/MRS HCR_EL2 check in hello_el2, as RESx
  read-back from the guest is not architecturally guaranteed to return
  the effective value and ID_AA64MMFR4_EL1 reads do not necessarily
  trap without FEAT_FGT (Marc).
- Link to v1: https://lore.kernel.org/r/20261116200418.3535619-1-coltonlewis@google.com

Colton Lewis (2):
  KVM: arm64: Fix inverted E2H0 check for HCR_EL2.NV1
  KVM: arm64: selftests: Verify HCR_EL2.NV1 is RES0 when E2H0 is NI_NV1

 arch/arm64/kvm/config.c                       | 7 ++++---
 tools/testing/selftests/kvm/arm64/hello_el2.c | 8 ++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.1.750.gf70dc682cf-goog

