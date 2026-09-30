Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4350EBE8
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803117; cv=none; b=NRcwnx77E5+doUxkMGFbJ27Lt5IuLXU3kN2elbCFjx1SOsD2Qg8BNNBv1VIRB+BhYqGcyLqvs+bhTQ7F0C92apAmitTKmBIFTlLshPbrRKqb48EAzpsoqgM8/tFgkKDJcYULZuU7krMwzUefcypiWSJ5idWVvC0mVnzNT1xrRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803117; c=relaxed/simple;
	bh=bBIz71XabS8gsl10MkZY2WdwbNn2woPnnwp8G7PdlC4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G8SQk/DeqvpS/FrElwhHd9SwkIO87EeM1fFgH+6XVlCtQFCHkRwZ+TdutEHoGPxsoJVyVw4grCtDtZ6gDAbtdbyLPd0x/e3iupRYz9Z45dN6quwAwzsOfVeoSvGcJoqClPBTqDP3rrwSAD+4fOotGIe6O6/8Px/M2CsNvzCedcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d9unN/oq; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9unN/oq"
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b28deb7ee3so9944808b6e.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790803115; x=1791407915; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=631pnrFuqDRXd3BfizV2s6nQYFa+PIycK6cr0Zp6o9g=;
        b=d9unN/oq8JFqoulfoY1odb90kkrMFH2Fgy0ZKNdLnzWsARCsIzRJX93qv3aaQ+yBi+
         6zR/NRw1F1i2xOFaae03qAg3iKByHnww11wA3oRhY7KD+8jBlNV30buToioygXIG8Zok
         ETEE488jUn3taQVTqDOBZ+K9n9PBez8GDTvdd6Jvz+BUU4MEIpIFvvC/BdXufzm09JAp
         uf9dBhUVZcXkXYnspYQtC3SaiNmur6uKpRGYTbc1ZOaJTHWwdBLBmCXExHIIWdXXrFew
         2yotWQgHoMo4yvWXpZGWKp64S0jmLJvN7y1I2qaMtGVWNFnb9xfUjKXj0VYN/rA0ETRf
         jipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803115; x=1791407915;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=631pnrFuqDRXd3BfizV2s6nQYFa+PIycK6cr0Zp6o9g=;
        b=UHhHbn9lGq505NSsoDA6dau1TrM+3UyFY04QUbxz7IE4LYw062uvsGv2KcFXpWjZNI
         Fx8SCSJiehqHB/2WV+GDXmzjFnF3aV6BEUgTui2aaXER1q+uR1C3KA2rWimOxT8m59i3
         98E5j+WtMEN8YSXBU1yaFSWunEb3Hgj7naXpE8Dp2wjvSOkpC2y9+vJ6rburTTt7ZjaB
         uFnwuTd9gEmljYMBOZz8NkOEsICpvmCByiqWKBSoiecMDsu0KWR0ugfqlP/joP6pahje
         lZjXpF49uf6ewGuP3JTOR1VVvtg5HkVVCfPTRou4+jK6IaZnZgy8vg691jFTHgya/I+l
         Sorg==
X-Forwarded-Encrypted: i=1; AKwUvByasIZPU98/WJh8Oi1n5qZN6urBIO6VCh6+Fn4IjCLZ5ml4+jMr7yZI3e21Uro/BKq5XLo=@vger.kernel.org
X-Gm-Message-State: AFuF++npVIBBOkyGAUSdNfanb+yuJ3IyzEF29m3aHiA8oNDm1pVvlzRi
	uDvi8S9amvgdH51hIEw7J9kYCJ0YpDybWydFTEcByyvKZ+6BAYlfQR5iuIvXuYqPkjy9IYs+JhR
	2Cv8ElV4sRHLyn+uNS3qDnEMzYA==
X-Received: from iocrj27.prod.google.com ([2002:a05:6602:a71b:b0:9c7:5b85:f7d6])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:14ca:b0:4d6:92b3:5c8d with SMTP id 5614622812f47-4f1bafb3d3bmr3357156b6e.67.1790803114797;
 Wed, 30 Sep 2026 14:18:34 -0700 (PDT)
Date: Wed, 30 Sep 2026 21:18:32 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930211834.2773546-1-coltonlewis@google.com>
Subject: [PATCH v2 0/2] KVM: arm64: Handle hidden FEAT_PMUv3 in ID_AA64DFR0_EL1
From: Colton Lewis <coltonlewis@google.com>
To: kvmarm@lists.linux.dev
Cc: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, pbonzini@redhat.com, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

When userspace initializes a vCPU with KVM_ARM_VCPU_PMU_V3 and hides
FEAT_PMUv3 via ID_AA64DFR0_EL1.PMUVer, KVM hits a WARN_ONCE("Unknown PMU
version 0") during reset_pmevtyper() and continues to expose PMU system
registers instead of emulating guest accesses as UNDEF.

Patch 1 handles ID_AA64DFR0_EL1_PMUVer_NI in __kvm_pmu_event_mask() and
removes the redundant kvm_vcpu_has_pmu() check in reset_pmevtyper().
Patch 2 updates pmu_visibility() to check ID_AA64DFR0_EL1.PMUVer via
kvm_has_feat() so PMU registers are marked REG_HIDDEN when FEAT_PMUv3 is
not advertised.

Changes in v2:
- Handle ID_AA64DFR0_EL1_PMUVer_NI in __kvm_pmu_event_mask() and drop
  the kvm_vcpu_has_pmu() check in reset_pmevtyper() (Oliver)
- Drop Cc: stable@vger.kernel.org (Oliver)
- Add patch 2 to check ID_AA64DFR0_EL1.PMUVer in pmu_visibility()
  (Oliver)
- Link to v1: https://lore.kernel.org/r/20260929220411.3756519-1-coltonlewis@google.com

Colton Lewis (2):
  KVM: arm64: Handle ID_AA64DFR0_EL1.PMUVer == NI in
    __kvm_pmu_event_mask()
  KVM: arm64: Check ID_AA64DFR0_EL1.PMUVer in pmu_visibility()

 arch/arm64/kvm/pmu-emul.c | 5 ++++-
 arch/arm64/kvm/sys_regs.c | 6 +-----
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

