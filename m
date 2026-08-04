Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0094570F6
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886780; cv=none; b=cAPJE4nS/XADqGMVKtW1FR2Hb8sCi1AxSzgBm+HHgD6bjgHxUMFDgb6Sqp9Z7QaVqmoAZGInok2zTM0cK3ROYKQ64kFC8gjQvH7Lu91E0ACiHhS6US5gLb4H+tbD1nEttftRmkFjM30qfkgxl2socAYIUvOEdBvzKg7CUROsGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886780; c=relaxed/simple;
	bh=3f+LeGlTiW8NddqAC0vBItNms1RmHHPfUNRCc7qd5cU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dxAqj2bXw6ECGitAxFWQ8TIMGiDFJdosegPUTTL4owYpwYpSayN+zRGxrt/NrHTgIYqbiTPAD+qPtPQg+CIlf0l10u/STRHPHmytpGqP37vPWVtMB3O9T6pyhqEh7hI4nOKzBxyDigIZEp8qsp457hNeqof6LI6WfhsSvDIkQJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ngg6P0B3; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ngg6P0B3"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce8a76df2dso6656675ad.2
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886778; x=1786491578; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u0AcTxHloFFR8M2y2fMS+T/BunS/UDptibKKxGh6Hbo=;
        b=Ngg6P0B3afcbg0Y+blid4OPBha+cTPwCgNjB5XKZiZqYWO3a1uJJk2wzh5Cx9eeG6D
         9Wcfs9z3QZ+9uGb57HxK1S9P7vlh1UfvqWY+hs3F3EOr8MHl/sZFxSLRw5ehDwaySWKC
         y37JC34APFduWyr9LdoTlQLsSgrTkXfsQUSK+/udb7Bdhud8V8xvi3rVZxys+GS70H1K
         c+NjhLgqBL5oDpfj+ZPGtMeP50db1QIDmmA7qYlsqoP3h8ATZgS/+lIPymdTtO/QgHrS
         7rv5UQQyTzpkYe1cVKgsmYxftZh7CprclPcmSqQD2daMQHt7Ydw2isgoDTBWlgkgNxwy
         G+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886778; x=1786491578;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u0AcTxHloFFR8M2y2fMS+T/BunS/UDptibKKxGh6Hbo=;
        b=AUhEomFuzF0RQ+/7ChokgMkyysnTwkonnHvNJMdHo21/5I7K73SeRtHSGr7GLWX7bs
         axyvJSXSNfxfyzKMLVtEQL2BL1LsKilm42KHGcq4SGZNHoEHeSroWrQaWOoB5NVaZriH
         vczCQsYNs7chslcRNN4rb5jITaQT/1HzBGajQPr/qTSWFQl4C+TjAxcRBpDkYfkpA7KJ
         MrbEp1ITO8b5+QcIubKNm7CUhAmvjPCYFZ8pvogbPsSmLRDPTXnU+rnUY5GFwiUrzMa8
         Q7rW4xmaO/yqeZCYycYC6bIfoQXXRDm1J9wcxkyId8TV3vCAZDtCXcszreIxugVgJ9uc
         IOvg==
X-Gm-Message-State: AOJu0Yz5MRjpVttrVr7Ql/8CL8CVoDS9gP0LYnpTUsdTnyNSm3ygjNdc
	U5yxC7ixhIKjHw3ISj1rlwtyq1ZaCTC4YwKdX0jP/uGpIQmGYVAC1H4CaW90l33RDeZO8L4Bvaq
	jycwA4g==
X-Received: from plat19.prod.google.com ([2002:a17:902:e1d3:b0:2cc:6ddb:debc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1666:b0:2cf:c543:2c7e
 with SMTP id d9443c01a7336-2d0ca767b5fmr21739275ad.10.1785886777885; Tue, 04
 Aug 2026 16:39:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:14 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-11-seanjc@google.com>
Subject: [PATCH v8 10/17] KVM: x86: Fix KVM clock precision in get_kvmclock()
 with TSC scaling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

When in master clock mode, the KVM clock is defined in terms of the
guest TSC. But get_kvmclock() was computing it from the host TSC
without applying TSC scaling, leading to a systemic drift from the
values the guest computes from its own TSC.

Store the VM's TSC scaling ratio in kvm_arch and precompute the
guest-TSC-based mul/shift in pvclock_update_vm_gtod_copy(). Use these
in get_kvmclock() to scale the host TSC delta to guest TSC before
converting to nanoseconds.

This avoids "definition C" of the KVM clock described in commit
633d7652f80f ("KVM: x86/xen: Do not corrupt KVM clock in
kvm_xen_shared_info_init()").

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  4 +++
 arch/x86/kvm/x86.c              | 61 ++++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6ddc988576d0..2878a5181cd9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1236,6 +1236,7 @@ struct kvm_arch {
 	u64 last_tsc_write;
 	u32 last_tsc_khz;
 	u64 last_tsc_offset;
+	u64 last_tsc_scaling_ratio;
 	u64 cur_tsc_nsec;
 	u64 cur_tsc_write;
 	u64 cur_tsc_offset;
@@ -1251,6 +1252,9 @@ struct kvm_arch {
 	u64 master_kernel_ns;
 	u64 master_cycle_now;
 	struct ratelimit_state kvmclock_update_rs;
+	u64 master_tsc_scaling_ratio;
+	s8  master_tsc_shift;
+	u32 master_tsc_mul;
 
 #ifdef CONFIG_KVM_HYPERV
 	struct kvm_hv hyperv;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7768a8909cf8..f13100a7a63e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1247,6 +1247,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	kvm->arch.last_tsc_write = tsc;
 	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
 	kvm->arch.last_tsc_offset = offset;
+	kvm->arch.last_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
 
 	vcpu->arch.last_guest_tsc = tsc;
 
@@ -1559,6 +1560,8 @@ static bool kvm_get_walltime_and_clockread(struct timespec64 *ts,
  *
  */
 
+static unsigned long get_cpu_tsc_khz(void);
+
 static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 {
 #ifdef CONFIG_X86_64
@@ -1582,9 +1585,30 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 				&& !ka->backwards_tsc_observed
 				&& !ka->boot_vcpu_runs_old_kvmclock;
 
-	if (ka->use_master_clock)
+	if (ka->use_master_clock) {
+		u64 tsc_hz;
+
 		atomic_set(&kvm_guest_has_master_clock, 1);
 
+		/*
+		 * Copy the scaling ratio and precompute the mul/shift for
+		 * converting guest TSC to nanoseconds. These are used by
+		 * get_kvmclock() to compute kvmclock from the host TSC
+		 * without needing a vCPU reference.
+		 */
+		ka->master_tsc_scaling_ratio = ka->last_tsc_scaling_ratio;
+		tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
+		if (tsc_hz && kvm_caps.has_tsc_control)
+			tsc_hz = kvm_scale_tsc(tsc_hz,
+					       ka->master_tsc_scaling_ratio);
+		if (tsc_hz)
+			kvm_get_time_scale(NSEC_PER_SEC, tsc_hz,
+					   &ka->master_tsc_shift,
+					   &ka->master_tsc_mul);
+		else
+			ka->use_master_clock = false;
+	}
+
 	vclock_mode = pvclock_gtod_data.clock.vclock_mode;
 	trace_kvm_update_master_clock(ka->use_master_clock, vclock_mode,
 					vcpus_matched);
@@ -1658,22 +1682,10 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
 	struct kvm_arch *ka = &kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock;
 	struct timespec64 ts;
-	u64 tsc_hz;
 
 	if (!ka->use_master_clock)
 		return false;
 
-	/*
-	 * Snapshot and validate the TSC frequency as kvmclock_cpu_down_prep()
-	 * zeros the per-CPU value when a CPU is going offline.
-	 */
-	get_cpu();
-	tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
-	put_cpu();
-
-	if (!tsc_hz)
-		return false;
-
 	if (!kvm_get_walltime_and_clockread(&ts, &data->host_tsc))
 		return false;
 
@@ -1683,10 +1695,25 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
 
 	hv_clock.tsc_timestamp = ka->master_cycle_now;
 	hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
-	kvm_get_time_scale(NSEC_PER_SEC,  tsc_hz,
-				&hv_clock.tsc_shift,
-				&hv_clock.tsc_to_system_mul);
-	data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
+
+	/*
+	 * Use the precomputed guest-TSC-based mul/shift so that the kvmclock
+	 * value matches what the guest computes from its own TSC.
+	 */
+	hv_clock.tsc_shift = ka->master_tsc_shift;
+	hv_clock.tsc_to_system_mul = ka->master_tsc_mul;
+
+	if (kvm_caps.has_tsc_control) {
+		u64 tsc_delta = data->host_tsc - ka->master_cycle_now;
+
+		tsc_delta = kvm_scale_tsc(tsc_delta, ka->master_tsc_scaling_ratio);
+		data->clock = hv_clock.system_time +
+			      pvclock_scale_delta(tsc_delta,
+						  hv_clock.tsc_to_system_mul,
+						  hv_clock.tsc_shift);
+	} else {
+		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
+	}
 	return true;
 #else
 	return false;
-- 
2.55.0.571.g244d577d93-goog

