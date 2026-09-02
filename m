Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039D4A64E6
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374841; cv=none; b=qxu5ZWD4IbCQHswii4TcXHOJLkVEEMNPkna+0RfukHnVtDJP4dVaTVXhIThi0FAkxmh2tBMu55c0r3BPswncpG/a5K31TlTzACmY1QenxGbEo0YQZa1k0Fd+6uGuEUf66gk8Ww59ZZ2JuORs7aINDDk5IynkGzpFzqJ0rOad70U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374841; c=relaxed/simple;
	bh=y+y1OsgbGST+lI5Rpb04Wns/HoJZclWhhlRdnSD4Se8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KQ6bNpAe9VSfWf4Zc+WhZPLNf0zpvFrCUE+hD4uQ4MiI6qOEdSgs9lU8To8DNfIyumRPs1rkZ7Gil/JW97yKlLNo3XWq2F2HtIT/2iYMtzpaHM61+YomndGPFhDQ5j2+Pb8ENepENmVaOgzkVjzWxPhzFryNpExAzLi8uiEs50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F41JzNAC; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F41JzNAC"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso1758929a12.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788374839; x=1788979639; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xxdWU1HBkKlwZ8Kwkk3ZMEr1bzk/dxW1PATxCsdD9kQ=;
        b=F41JzNACWG3gfDH7sp4Z5DQWCiaDOyyh9dl7YokJ75KT6WNt4IqNONLtRhPp0mMVG+
         Es1FNglTKggIzuSNKR65/J2sHpZJtvlFVEgyCM8JrwDVTecKQB2zxM5YoryeYRTHWe0h
         2wMHPdBzcgR1gYC6zKcu9q2eFfnAW+Ya0PAA1xp3WZPX+OBXp4TZKvEgyHBRIuAP9ld6
         SYeN8AzSXLb650dlbiLn4ChdbzutxzghRKy7bhok7cDZe+RbfxM6aaQQ34LxcFNQJKJ/
         rscgWJ67gb9o7YkgX+oVmQcAIe8NUHS00wKCIYMW55xzkpz8ol4txmr68ZtlqakX/QlL
         dPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788374839; x=1788979639;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xxdWU1HBkKlwZ8Kwkk3ZMEr1bzk/dxW1PATxCsdD9kQ=;
        b=jG+Jww/EZ9fiZfuZuXAH8keaW4MR1IzS3yppvF/S70OdBCL/tKCh+DsZ63cSa2HtYX
         hQJX7ocmRBC3rkZuwj2TY09mEC9mFuW8M8GwBvdqg8Bd/k4t8IcbWAQvZziMIDaonjBy
         EGQIPHbBzWoZUj8M2aAMyRKuRZk3EujO+8OwXX+5Bau1Uy+afmCF7BERcRIfwDw/HqHn
         //uIrbRw8SUlwUMZ3hakoZT0eJoaTX1xvSrqoiPRYwsz0GM9AFR1bLPJ/a8OGILM91q4
         9k1bIiw41OmhytleDak/omrG7ejfJCQWwaHlBhdOyZH/vwZdFtphJFImwNlaUODwRIgj
         view==
X-Gm-Message-State: AFuF++nO9+J87hU4Ivvll8oygyQYfO1GsYuecB3KqU1ybyuwUOCiNr8X
	OFEPn2k+yZQCCQTBTrwZMGmSNMc1bdV7GXvL8e6akiYu7VHwodAH8mrOEpWRzQQiABulOqfBjnI
	zyHEoJJ07o7bvMw==
X-Received: from pgbm8-n1.prod.google.com ([2002:a05:6a02:6188:10b0:cc1:c65d:a771])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:cf85:b0:3d3:ad3c:49a7 with SMTP id adf61e73a8af0-3d9ae3bbf11mr11547335637.21.1788374838806;
 Wed, 02 Sep 2026 11:47:18 -0700 (PDT)
Date: Wed,  2 Sep 2026 11:47:11 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902184711.138538-1-jmattson@google.com>
Subject: [PATCH] KVM: x86/pmu: Move Intel PMU global MSRs to intel_is_valid_msr()
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, likexu@tencent.com, sandipan.das@amd.com, 
	yosry@kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit c85cdc1cc1ea ("KVM: x86/pmu: Move handling PERF_GLOBAL_CTRL and
friends to common x86") moved the existence check for the following Intel
PMU MSRs to kvm_pmu_is_valid_msr():
 - MSR_CORE_PERF_GLOBAL_STATUS
 - MSR_CORE_PERF_GLOBAL_CTRL
 - MSR_CORE_PERF_GLOBAL_OVF_CTRL

That commit deemed these MSRs valid whenever pmu->version > 1. It intended
to share the check with AMD PerfMonV2 because both vendor implementations
require version 2 or greater for global PMU controls.  However, as noted in
the commit message, AMD uses different MSR indices for its global PMU
registers.

Commit 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
subsequently added AMD PerfMonV2 support and set pmu->version = 2.  Because
kvm_pmu_is_valid_msr() validated the Intel MSRs whenever pmu->version > 1,
KVM incorrectly permitted AMD guests with PerfMonV2 to access these Intel
MSRs without a #GP.

Move the validation of these Intel MSRs to intel_is_valid_msr() and remove
the common switch statement from kvm_pmu_is_valid_msr(). AMD already
validates its own global PMU MSRs in amd_is_valid_msr().

Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/pmu.c           | 8 --------
 arch/x86/kvm/vmx/pmu_intel.c | 3 +++
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a7d60c8785cd..d2fd47ee5ec8 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -823,14 +823,6 @@ void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
 
 bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 {
-	switch (msr) {
-	case MSR_CORE_PERF_GLOBAL_STATUS:
-	case MSR_CORE_PERF_GLOBAL_CTRL:
-	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
-		return kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
-	default:
-		break;
-	}
 	return kvm_pmu_call(msr_idx_to_pmc)(vcpu, msr) ||
 	       kvm_pmu_call(is_valid_msr)(vcpu, msr);
 }
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index bfa8612fb450..70a8c4816135 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -187,6 +187,9 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	int ret;
 
 	switch (msr) {
+	case MSR_CORE_PERF_GLOBAL_STATUS:
+	case MSR_CORE_PERF_GLOBAL_CTRL:
+	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
 	case MSR_IA32_PEBS_ENABLE:
-- 
2.55.0.970.g62bdec98f9-goog

