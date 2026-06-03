Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D423A1D01
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528750; cv=none; b=I5bwkUXqbq8GPl57NlJq7rpmAABtmdgchwtTxCI2TW/xxUTsZzZtq0KxGhYyp9FO32ZeOyX4R1khvlDDIhaonNj8Jrw1NnBmcXNxvGCO+1BRQ65d1gRB8ufKVV3/ouZ86K1aACtatKVaafCyWCBmYpCWHzitvZ+VvQzbcjFPvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528750; c=relaxed/simple;
	bh=Gqv2xee4TZDFvnv+AVdCJd2X/zl2qBOenv++IKWNhcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pkg6M0aKSJ5J9Se8QFRsMQBfBBGjdoPKUCcGNdxVQQ6g9akFMBhjlFaA6ezxnM+eXah/OoCjx88T7Ov+3Q+YH1xCKpeKd8NkDX3O9NVYZNmaX6tQA4K96Qdu0gv1/2fSQvJTgi9LXtJJHSuouew4PDJPKIYS5l/7uTwY5pbJOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k9K/p6px; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9K/p6px"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423f544944so48782b3a.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 16:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780528749; x=1781133549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YCvNgkXpGChYkT9tZle/L+mr+f+wzd2BzbvRltvkljI=;
        b=k9K/p6pxq4eUa25itzAkonBNQ7poMV6ItqP2qLIqwDAdxXBCDGI8Z6usCoq+qoc/r4
         IyusVH+Wjbdgz4+1PkdBDcPbE7WtvtzDa7QmJ+LG9UYRGyt9rmCc5FgPPNeKMojr3wD7
         xqGsG0jhfJ/htjZKfWtlouzWlJcqo+VsOBxtgbDaGcnu6HLrf+Nl6sjHKH7FK7hq7NCW
         lnbsfjKXm3nq1peu/5cIkUCUYa6PKHDhabTKHiICisINdUhNCgTbU9nc1sEGZPU100V6
         DjLPxxsW2Oc9PU91QV+MuzjV92Fj4nk7bKMyMrY5tisNpOJKf29YJIV4IViqsbThzPCJ
         gwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528749; x=1781133549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCvNgkXpGChYkT9tZle/L+mr+f+wzd2BzbvRltvkljI=;
        b=aMgbfnxLusJ1TB91ostJxDa81RZ8bgKIPTrlQkGkgrqbRuyJ3D6fs1OHhUEUPlvyqE
         laxDO2GPWhC4eBaIrbSlCuoepR2IsD32L0S59Z1Y6P/e8ANUUSMf1clQWCbpnHJTruIj
         +wlRUqDgden8/PMMIy4v2w5A84BKiecroo9JIzyJhshRMn4ubVIjJWL/cq5yv7GsG77E
         +U6gBX9LT6uL7cJ3+0OEQhugitljbvDxRRq5txJWMBp1/Y8Bs9YbgUJeSE6L6N852bTk
         2fc5Xh1MJ6MgMrG0W3C1eS9/FVIvIPV0p7mMX7tyxjTHIUki7Z3YE11VmwpRsIYAHX8E
         MinA==
X-Gm-Message-State: AOJu0YyLyBCSUGfKDCzEj67zkRy3RtorU3B/FBsCndjMupoGlRQIejcM
	8vLMiuFpn2N90DTkK7C/dSwgRrzbgY1OrdYUKe5rlIda4/MLthHUtxIDgnexMSrg9CPVIiIfzEf
	Ug0hpbg==
X-Received: from pfbky7.prod.google.com ([2002:a05:6a00:6f47:b0:842:58c7:c162])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3288:b0:82c:ebae:3cb
 with SMTP id d2e1a72fcca58-84284f0d090mr4815454b3a.43.1780528748657; Wed, 03
 Jun 2026 16:19:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 16:19:04 -0700
In-Reply-To: <20260603231905.1738487-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603231905.1738487-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603231905.1738487-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86/pmu: Use hardware value when reprogramming for
 FIXED_CTR_CTRL changes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When (conditionally) reprogramming fixed counters, use the hardware value
of FIXED_CTR_CTRL to detect changes, not the guest's original value.  For
guests with a mediated PMU, overwriting fixed_ctr_ctrl_hw at the start of
reprogramming without actually reacting to changes in fixed_ctr_ctrl_hw can
lead to KVM ignoring PMU event filters.

E.g. if the guest attempts to enable a fixed PMC that is disallowed, and
then toggles a different PMC in a subsequent WRMSR, KVM will update
pmu->fixed_ctr_ctrl_hw and reprogram the PMC that is changing, but not the
others that are now effectively enabled in pmu->fixed_ctr_ctrl_hw.

Note, the perf-based PMU is unaffected, as it doesn't use fixed_ctr_ctrl_hw
(which is also why keying off fixed_ctr_ctrl_hw works for both PMUs.

Note #2, fixed_ctr_ctrl_hw won't mess up pmc_in_use either, because the
latter isn't used by the mediated PMU.  Its purpose is solely to release
perf events that are no longer being actively used, and the meadiated PMU
obviously doesn't create perf events.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260528005419.0228F1F00A3A@smtp.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 453cb3d3ec9b..a73a9515d96c 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -56,8 +56,16 @@ static struct x86_pmu_lbr *vcpu_to_lbr_records(struct kvm_vcpu *vcpu)
 
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 {
+	/*
+	 * Compare against the value the mediated PMU shoves into hardware, not
+	 * the guest's desired value.  For the emulated PMU (proxied via perf),
+	 * they are one and the same (fixed_ctr_ctrl_hw isn't used other than
+	 * here).  For the mediated PMU, KVM needs to reprogram the actual MSR,
+	 * and so needs to react to potential changes in the value shoved into
+	 * hardware, e.g. to ensure the event filter is enforced.
+	 */
+	u64 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl_hw;
 	struct kvm_pmc *pmc;
-	u64 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl;
 	int i;
 
 	pmu->fixed_ctr_ctrl = data;
-- 
2.54.0.1032.g2f8565e1d1-goog

