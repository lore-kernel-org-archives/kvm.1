Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207D51E43A
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803119; cv=none; b=nqYynJFsXnA97yis2tp1ucUQCNsR6Z2RT62avS9l1NGLm+ijGOBZ6lvWQ01iSwyDgyVZCfdBs066XtVwgQSdndhW5DxuGoxb8tj5Z23ZjjlONoW1YubHQe0W3KVtSpwuC11PMs40+itPXGn71wWsMgQi6NDlY8w/kOKGQcQVoXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803119; c=relaxed/simple;
	bh=1zpGeqQhQHL87M4JhAi1mEkbl1rvBkOkkOhj9EwgPFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZQujmYEP58+vPcT8V9ve5vJ5v8VXyOQVpFlxGh3ZHFbK9yLozxpyyycgNJmF95xbv0u4TfYllomjFWqP5uQcOxNUmGL+ntbYrv1B2GBT+R9t5bgMSBkxcGGgMpI++p0DZT0MtpCipgp3LxzRHVN6NQSe12OScUuTNrGaSlJ0zbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CrYxZnEf; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrYxZnEf"
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a41f46d629so9823764b6e.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790803116; x=1791407916; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IvNQ4tIxSouECNeVr4s6zto6hS9KDqxG0yViEXlduVY=;
        b=CrYxZnEfYm+l1P/2utU8zz+ySYiUCCdIPg6XDUIoF3RnpM8/DcBXFHaRW0uVC4uBkG
         AChKuUdwpS0+5cLAvu+hUuBHjnvU5QMh0CaOiSiaH6/UC8WQGiK+ZuBhj2yrE9kSbqDU
         TEzL4oAcd/ZSzs7HW0d4pjevM/r4VC4G1pYKM6agE63fzSVw/bQBUSXsWymXM8jWqu4Y
         kH3QP+DiSDM9BNpyc+4dx4CvNoVFLEXWd+Co7Ufv6RXP2ny8PHRJEawLTeMAoZeHf9yc
         OwXoBE6VP8G7QMACkDPOnLAQ1J/nBzBA5B9vxlXlpUGU7GzCKYALNxs/kp3ymVYfCZ1m
         +AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803116; x=1791407916;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IvNQ4tIxSouECNeVr4s6zto6hS9KDqxG0yViEXlduVY=;
        b=FZF7MZHgKznUJ5f87CBtSzGut2bgtMxvOfKAF2ivjg3+lEqEZFJPW1qujdBv5hxRR+
         0iHt333xMlX+lAUvCjAAJhEgl4p5+E9j6H+Wjv+SRh2RDGD7HSRwih+a/u7ivmcQxh5c
         ZXsF9Xs33Asg2pGfT7P3oGpNJiZ4/q7SCoHTTc6QSM0iufQc5rao49RT0NhitF3F3Htb
         PZVog6KyeYazNhmQ9KteU2LgWwAm7srUu5+f+FkzeSjFV80t7FBAEjwP/W9HtmbMFGJ4
         GV+WM4wkGtAU3rxgRIt5MmNOe3hfruaGhQ/a3V9PSshzjf5Mjf9mMXnEXg9YAXonLnGy
         EoUQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8HKlghD0Hedv2YVMtxfPMtqvPSVWn0/7DJTliR5S1JkWKgGf+nigGWsnqK7GIRq+2tMk=@vger.kernel.org
X-Gm-Message-State: AFuF++n+AKTSwPizsylAsuvoRr9GwE5MGNaL5dEd3n3hdlaPqyUak0/P
	R1V1zKeC2ZCq94GqhKmOb3OXnKjA8kCbYjthHTa+wrV6dX3y4BgB8vtVRo8q3LzMEQOAvvpKT9l
	dn5fmZDn994lQQGy3YP1fwJ/gdQ==
X-Received: from iljm9.prod.google.com ([2002:a05:6e02:de9:b0:50d:b61e:e6c3])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1190:b0:4d6:9153:295e with SMTP id 5614622812f47-4f1ba4fc340mr2480554b6e.47.1790803115577;
 Wed, 30 Sep 2026 14:18:35 -0700 (PDT)
Date: Wed, 30 Sep 2026 21:18:33 +0000
In-Reply-To: <20260930211834.2773546-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930211834.2773546-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930211834.2773546-2-coltonlewis@google.com>
Subject: [PATCH v2 1/2] KVM: arm64: Handle ID_AA64DFR0_EL1.PMUVer == NI in __kvm_pmu_event_mask()
From: Colton Lewis <coltonlewis@google.com>
To: kvmarm@lists.linux.dev
Cc: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, pbonzini@redhat.com, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

When userspace initializes a vCPU with KVM_ARM_VCPU_PMU_V3 but sets
ID_AA64DFR0_EL1.PMUVer to NI (0) or IMP_DEF (0xf, which is sanitized to
NI), resetting the vCPU invokes reset_pmevtyper() and calls
kvm_pmu_evtyper_mask(). Because __kvm_pmu_event_mask() does not handle
ID_AA64DFR0_EL1_PMUVer_NI, it triggers a WARN_ONCE("Unknown PMU version
0").

Explicitly handle ID_AA64DFR0_EL1_PMUVer_NI in __kvm_pmu_event_mask() by
returning an event mask of 0, and drop the redundant kvm_vcpu_has_pmu()
check in reset_pmevtyper().

Fixes: bc512d6a9b92 ("KVM: arm64: Make PMEVTYPER<n>_EL0.NSH RES0 if EL2 isn't advertised")
Suggested-by: Oliver Upton <oupton@kernel.org>
Assisted-by: LLM
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu-emul.c | 5 ++++-
 arch/arm64/kvm/sys_regs.c | 4 ----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 5b1af7e2176fa..e2b28dbc0451b 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -50,8 +50,11 @@ static u32 __kvm_pmu_event_mask(unsigned int pmuver)
 	case ID_AA64DFR0_EL1_PMUVer_V3P5:
 	case ID_AA64DFR0_EL1_PMUVer_V3P7:
 		return GENMASK(15, 0);
-	default:		/* Shouldn't be here, just for sanity */
+	default:
+		/* Shouldn't be here, just for sanity */
 		WARN_ONCE(1, "Unknown PMU version %d\n", pmuver);
+		fallthrough;
+	case ID_AA64DFR0_EL1_PMUVer_NI:
 		return 0;
 	}
 }
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a2f4e769a4282..e4ad9c171c7ca 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1059,10 +1059,6 @@ static u64 reset_pmevcntr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 
 static u64 reset_pmevtyper(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
-	/* This thing will UNDEF, who cares about the reset value? */
-	if (!kvm_vcpu_has_pmu(vcpu))
-		return 0;
-
 	reset_unknown(vcpu, r);
 	__vcpu_rmw_sys_reg(vcpu, r->reg, &=, kvm_pmu_evtyper_mask(vcpu->kvm));
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

