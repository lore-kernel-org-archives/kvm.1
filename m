Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7603B7B7F
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402526; cv=none; b=oUWtyyVa/LN2fSYjjw5pUXix/L1usz/jZdoChFeP1bj79Ju9rYfTaVX2UzXDCxJ0NvIgy14TSuWyYoLPsGZB9ArR6y40XXYr63uA6jb8uVLJr9rUWNGThiDNZJnQJnN/pcZZ6paDnKYIs283fFlcYv7PNr2I7WmyazBkSsEVQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402526; c=relaxed/simple;
	bh=B+zYaK0jv8vr3cfVGCR9hMeAybdTIs4VKA2n/3aUX4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nVm7TVbnUSUm9doeKuos/778/nlt7mltAbuTHqfWauhg9BaxDVeg3xcAtvyB8UuG3T81jwYjXtfX232i/wAALkK0t/cA4N2G9OpeF0OyKaccB0tK6s2lCsisUsjjAMQNHLomilUOPbBg7nlmoBmMfQXFV+VONCBnFp6/HY/KOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2icogYW; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2icogYW"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfa4e4684bso70385965ad.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402517; x=1787007317; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dxR15fCIX+zSacQBw3/oP3E10naqYejo6NYc0FRWoJM=;
        b=K2icogYW1E0eiFD/KV3TAZ/+1oYl/SOaDpeQ/mcq3yNHsvUFQSBPbHKb8L2SVwkdQp
         gQ/8+mhMgQeffmE0aoD2vspXRp5hOUXr3kQNTJ/xdh2EcOy68W2aEBinFHQj/vwfNcRf
         Yi6S77H2z/zE4kmNdfQ+J00KS8T427bpsDvS+nOLsJsQSQXeUNq/KSX2DArtYxXKqW8d
         nslmvw3RNu2ph/UddTMlr1hGk8yV8ynfn+11H/oNn0xIo13WEVgjAL9t8o4gPiEoxINu
         uyZhlQpyUSFCeOGQvHSYolnnpdwvoS8FcQE2PF3b910JRyEmFeoCUxByvJHe6YP+AB4u
         t1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402517; x=1787007317;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dxR15fCIX+zSacQBw3/oP3E10naqYejo6NYc0FRWoJM=;
        b=UqYmmi5f5JMAEA4o7KMmTOF3wRnJtBI/EDrQZF+s0eCJn5595cUnPW+mU8OW61CpEh
         6B9aG52+tA/JNOndZjBcZtq4A7gg7xvGiqAWSgqTWpQOEpiCQxIcTl5nUc4SdeQ1YRMU
         o/YCdmKzL1D9aWrg7JqEaMI2J3SuOdJO4rpFQnRI1V0yW9lhkwOT4mnnzatWXih/8eDM
         QYCecrisIjszH0aE6zqKMglOwo5I2rj0lI+sYMCbz+WP9nemSMRyuqr3RgzPeL+asUHg
         do9R+X7vv37nCLyGbZvh/SoX0fIcyCfKY+og4i304zmttVDkd3tp9u30yJuE6rnzvAQ0
         EFmw==
X-Gm-Message-State: AOJu0YyUJcCZ432TeZuLFCEhWpV3w7HQz+/mQQk0W9rA0WLvIUfxIVuj
	ExXz13VmTbMYzicIynFTGv4Bwq/nAEcKVcetDuaaS9grw9AdhPw2lXkdtTCgGRgNfbhHNFsqH4R
	3CA9C1Q==
X-Received: from plgo14.prod.google.com ([2002:a17:902:d4ce:b0:2cc:79e2:e717])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c1:b0:2d0:cc92:f7ae
 with SMTP id d9443c01a7336-2d294b29499mr283668315ad.3.1786402516633; Mon, 10
 Aug 2026 15:55:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:49 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-12-seanjc@google.com>
Subject: [PATCH v9 11/21] KVM: x86: Fix KVM clock precision in get_kvmclock()
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
index 33ba840d3267..61c65241554d 100644
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
2.55.0.679.g6767b8d81c-goog

