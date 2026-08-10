Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645343A808
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402517; cv=none; b=GuUyRJC0qLKEGzP3gSPnhF1S6LRfgOGScBvsxQgfqPV8p585DxlYuh6Xpd5sbw3pslKzXsPrnDxFArMUJ0PIwd22tZtK1NsbqVB+Hirlk57fxZtkL/bMKroIG7X3g9btX0IEJ8IBBYQkh5tTtcLYs1M3oSlNZdX9FfcoVidDQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402517; c=relaxed/simple;
	bh=9BxNKatIzOp+xBlZ24WPtnSnWe7eyb03hrAe5A7xVqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nMRYuU5getoNkxEmLDYxwvHv/yOnCpGVFVi04XmPDjzKcfp241/ix1bl9oaXf74g0Q4YD0BYbVK+JKWHdHm1L7a1/LDLCLTZewrgRDsw00IRWCu0iUtIBBvtwRf8q7j8toY+FvKNXJqPuC61FmzI3LN0wLkHxC7dJhIp3VgPFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kM+swXEA; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kM+swXEA"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbbb9c9bfc3so1475787a12.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402512; x=1787007312; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8sMALTNTQlRzIqiHYR1y7kSkpzP+a43a92KpCYzzzdY=;
        b=kM+swXEAqFhOdxmJlWYoBOW2bZXFZYjTu4S24ubFHHDfj/Nmvyf3EOPz0J2aYzeZUx
         SVRIs0fIQe23VoPnuP422yODwY2YbM5dAO6mAuHp5XuRigBvhMvncY5PIB7if8gsmy2V
         AlUg4F52JIpYJv/Za/Nw7Z82+lvaQ8pOSt1uzgysJyZ8of11nPc+RRI8a/742MvUnC7m
         2u5fMzBJvRnw3Ah7lMqs9wfhp33WaAJ6/C4qtTMvljOBXmlNCDAzXvoMjhFSWMxVMQZB
         1PdSaGsnf45OMzgQbwPubhQQZtrLgxI7ch5oEycHqXSosO9s5EGP4HQZGmJfTxRZ9Y55
         qipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402512; x=1787007312;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8sMALTNTQlRzIqiHYR1y7kSkpzP+a43a92KpCYzzzdY=;
        b=s8LnR2xHwf2FBowrlhMjgkbvng0YkpXzC0Yn9QJCOOoFO364h7R1B9A46WlRifZtFC
         Lp/gRqopVR30vIPmwvaxnf+N7gRG45yIMieJUuAnn3DfyKTMJ8/y2xEphYFdaGPlmSbu
         vu1/3n+NTP3RrWwJtEnQZjv1FKKpR8974hV88DpOOuHsdgRnEbnaD12LwDppeUzBy4Ci
         U2s7+d5qyCRn07XVYcB/cOBSs/1NyPoXNICbfthU3b7CZEwwYllB11mEu4oIu88EItu7
         S5jRrI52bdBko55+5XMDQ2L60hmNWMr2cOYJqwFcKkoqVGH9irCH0jpu7F8ZVp24DEvF
         yTfw==
X-Gm-Message-State: AOJu0Yz5G6adzuMXxjpNB03ESecKh0lWSjO9Yabqfvo5AE1xfHwOgaV6
	YgEowNuaM9uMiS/o3lzO7h6UIrlok4Z7Kmu7k44M7o8zM0UGJmaY4vfms0oSCA7eq8wL85W7+Fv
	y65nNDQ==
X-Received: from pgie15.prod.google.com ([2002:a63:ee0f:0:b0:cb1:bfdc:f782])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3181:b0:3cb:9594:91b8
 with SMTP id adf61e73a8af0-3cbcea0aa13mr26685395637.35.1786402511717; Mon, 10
 Aug 2026 15:55:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:45 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-8-seanjc@google.com>
Subject: [PATCH v9 07/21] KVM: x86: Drop unnecessary CPU pinning when
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
index 93b49be0d887..56e095b14441 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1655,13 +1655,18 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
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
 
@@ -1675,15 +1680,13 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
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
2.55.0.679.g6767b8d81c-goog

