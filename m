Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040D489868
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779995; cv=none; b=ol/om/vVhw0fd3mdk8l+zeT9mvxafe3l4v4nVFGT5PyD6K/y0H/XOXpJZRTBwnoiircxrKBrQq9pJujx7BK8g6MTxduYizi/8GChMhKLdHxje55zhsV3mXGUQUrZGAUG/2BQymDyw/tIYbJPgJBuiNkSFF4gaZPgO2akLBOi2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779995; c=relaxed/simple;
	bh=BCTNpvjwr2susxonlk0tuu8f+ghkxuHDIS6503fQLHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F276iD+FL1pCFcZF43TVMcZ0IRyIfd93qelF6AHjsR2dBPiGNLbQBtp6LIoTdSWQuQyQ/aPtBGaEyqWzCriMQpsiIIJkO3iC4K1fjJJqX+JF/HCDfkbRQTJd0ZLfo9qIlwww48n60bCbziXIgkZVQBjB0xm5JgQWBO7GrkbgEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTCjIesV; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTCjIesV"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca8aee88725so1759457a12.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779993; x=1788384793; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jTWuF2bXHv9bsWC/HQQ9abPeXt+ugeBz2F3xzAoOZxE=;
        b=bTCjIesVIwwelgjmq+qn6JDaopdYAzBpTmfVOrxZOjXrF3yDYIv3uZPsnoeRKXR84L
         SBAtV98cRYaWvS5tgt1SjwdtNdQaWqH4kYCo4lRwnjRSRKBoYL7JhkQgtN6a3oQL+Mtj
         qfQPvGpKEtQ33eaHvqkGpQv2rIKnzptNxkFvGYAnHxQJZtCxASbQhnxZuQziqz7XhQ3G
         cwI4rAu4cUjxGEEIG+D9bSwgBr/5WPMrp+9PKTxSsBlzyC8v2109TZgUi+PLqQ6sP039
         SDciTHMCvPd20CbvLhDlU2gBjfPfH5qn3OxVgy9xvluTEifl5u6lbPu6MfVwueWwTyh4
         mhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779993; x=1788384793;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jTWuF2bXHv9bsWC/HQQ9abPeXt+ugeBz2F3xzAoOZxE=;
        b=Qd8pTvj7s+S5ORDtu3psHs+niDkLDAtW23PClaXTUvU7aS7BRWbFYzecrgxTydc6Uw
         DL4n2yi2m81yHfG61X1T3W8qNB3CHBvAlt0403jLkPY2VjUwD+5FzRq5RBEiPdjj1w39
         42iOQNFygjyN3b4x29aQ/E1JqeeKMXGMNVbRAC4Q3zfslIN2qMReNSEtOMRT5zl1v+S3
         famtoUMhturH+iUH1ghMKZHuIVhMuDVheMmapekOZNb/6lO0TacxYd9fniosmPnAtlJ2
         Dcm9DdbsaiONM2G/xw/8v1qAHuJQmIl2hyXYgY22WaISQZHEVAVNOENNdvtm7+BrlBX8
         siLg==
X-Gm-Message-State: AFuF++lOLVpP8L3ZflzbagcKl+6cVE64jwxf0mVkQGW3MqCfgxgNiHlV
	p8mRPFhrBPqnEloLtKHQAnme3Z5HinAwC4lKeCVwb4HQnyeZvKBApK7LRwJQuk6rLD+xIwdMJc2
	0eTItuw==
X-Received: from pgzz12.prod.google.com ([2002:a05:6a02:682c:b0:c85:735b:ca4a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:116:b0:3cd:61d5:f342
 with SMTP id adf61e73a8af0-3cf83b22bc2mr21127205637.9.1787779993030; Wed, 26
 Aug 2026 14:33:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:47 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-8-seanjc@google.com>
Subject: [PATCH v10 07/21] KVM: x86: Drop unnecessary CPU pinning when
 computing/getting kvmclock
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

When computing the current kvmclock value, don't pin the task to the
current CPU for the entire duration of the master clock path, as the
CPU pinning was never about ensuring rdtsc() and cpu_tsc_khz would
agree.  As pointed out by David, ka->use_master_clock can only be true
when the host clocksource is TSC based, which in turn requires a stable,
constant and synchronised TSC across all CPUs.

The CPU pinning was added in commit e2c2206a1899 ("KVM: x86: Fix potential
preemption when get the current kvmclock timestamp") purely in response to
a CONFIG_DEBUG_PREEMPT=y bug due to accessing a per-CPU variable with
preemption enabled.  Despite what the comment would suggest, including
rdtsc() in the {get,put}_cpu() section was opportunistic.  In fact, Paolo
even said exactly that when suggesting that KVM guarantee the rdtsc() would
execute on the same CPU[*]:

 : Also, rdtsc() should really be on the same CPU as __this_cpu_read.  We
 : know it's not really really necessary because the master clock is
 : active, but since we need a get_cpu/put_cpu pair, better be clean.

Nothing has changed in the last ~9 years, i.e. the rdtsc() still *should*
be on the same CPU, but super strictly speaking, all will be fine if the
task is migrated between grabbing the frequency and doing rdtsc().
Dropping the CPU pinning will allow dropping the rdtsc() entirely without
having to resort to a large "rewrite get_kvmclock()" patch.

Opportunistically add a comment to explain why KVM needs to snapshot the
frequency, because that _is_ a hard requirement to avoid reintroducing the
bug fixed by commit e70b57a6ce4e ("KVM: X86: Fix softlockup when get the
current kvmclock")

Link: https://lore.kernel.org/all/ae8de642-8f14-a70a-1fab-57e2c4093cd5@redhat.com [*]
Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ed7986669bdb..75b689ec074d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1657,13 +1657,18 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 {
 	struct kvm_arch *ka = &kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock;
+	u64 tsc_hz;
 
-	/* both __this_cpu_read() and rdtsc() should be on the same cpu */
+	/*
+	 * Snapshot and validate the TSC frequency as kvmclock_cpu_down_prep()
+	 * zeros the per-CPU value when a CPU is going offline.
+	 */
 	get_cpu();
+	tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
+	put_cpu();
 
 	data->flags = 0;
-	if (ka->use_master_clock &&
-	    (static_cpu_has(X86_FEATURE_CONSTANT_TSC) || __this_cpu_read(cpu_tsc_khz))) {
+	if (ka->use_master_clock && tsc_hz) {
 #ifdef CONFIG_X86_64
 		struct timespec64 ts;
 
@@ -1677,15 +1682,13 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 		data->flags |= KVM_CLOCK_TSC_STABLE;
 		hv_clock.tsc_timestamp = ka->master_cycle_now;
 		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
-		kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
+		kvm_get_time_scale(NSEC_PER_SEC,  tsc_hz,
 				   &hv_clock.tsc_shift,
 				   &hv_clock.tsc_to_system_mul);
 		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
 	} else {
 		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
 	}
-
-	put_cpu();
 }
 
 static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
-- 
2.55.0.887.g758fc8c411-goog

