Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781848C3EF
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780004; cv=none; b=CO4shR4FUAt9TS0I5YUxIWBqMrUD7d9t/Y2dyJQSRQMJIcFn1SPcC+dGSws8LLa5IFjYPOqBmLLBq2i/EAQcL7Vb6EyeIhKvWn2qixpE05Resw44Jkdp7hUMtAc2iHsoMDer46VSaiCgd6iF979n7mnhMRU2xUcijxpjh9A2e5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780004; c=relaxed/simple;
	bh=sXDQZzyLfMpNXHAU0iuO6oPpDwKknuBXN21wmqthJTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tCsufLKkRqFzW/sWkGmTeXbzZnHCPdMeiV22iZXwEnw4tnz240a+3mzTNgOyvboHV9H3OavMr/4ghNsE0VmvnQvnuo5xG5G7VBmy2KZlJRkZzoX5DmEtIuV7w3eXAt8A/WRy7p7pllG/t73P6SZz/E2oWtyu+iawRHyMPv66nTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D5umEJZp; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D5umEJZp"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso27791a12.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779998; x=1788384798; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FRbtodcnc3a4V5kRubqK5bV3gSLOL5hK3M7G07fabw4=;
        b=D5umEJZpMz2NkrqUejCRmjgDHcsWWNEV800abF3hqyR5iE7kBauZgb7eAUy+Dd4Vz6
         AQ/0TWU0lxxB625NNssWMjKNUEXP8WjJ9gQ26h9h1nuNG4Wm2D7zq1EB3lcYe0zK7LgC
         6hiFUv5IRyVhuYg5IkyGOQapoPVCRfswaSeGhuot8JKkg9bunMGslLWicrVqsokHxpbe
         pEUTd70S7iawjCuudk9rxqH2X41GRrDuGqto1EVIfjmXJ3wm7r9e4wUJ5iFqQ3qPegB1
         X5MdNJ5k4QLc0obKxOWo/kGHySvx+OTg5EnsRVpmmElfb5Yn7PL+Qs4YVO1BTNO9Pip7
         Uy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779998; x=1788384798;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FRbtodcnc3a4V5kRubqK5bV3gSLOL5hK3M7G07fabw4=;
        b=bJeEQOR1F1R4bdG9p18iqtgD6Lqe9iLmAvs6Ak00plEsdc19G/QVVB7skuctQJAWPd
         2Fv1iUfNCmyMNtgA8HQXd5864VfONjDLn6hyIR5DXJWMSblf8JZ4CHbKN+KambFkeoMx
         oD2EbdOaLhoc2M6rW9ZIHGnmvyi99d2oNjLiwNt1Y27lycuk3FbBiTLMJHK9kbBPJevr
         2fWqVKWvguNLP4s8KIcwUM+ohN3+jfl6lAIQ/rqOg6sK7P21oQAuJ04KUdZRJc3dy2+0
         C0FQa50Vzo74sVqs6Vna9U3HOl0kKDGuvwVV0lYBRPZ2fIa8pydAdcCi9VVCVFcE7JLy
         hlvQ==
X-Gm-Message-State: AFuF++kvZWCtRiUjIyyCIPVGuAady0B6KNutagRj1rMcQ1UNrRBTQCNd
	smxkRKJx5BmZ6h0YUKOzrMRpZnntFhbk5sgP9CO1095WXZiPZJDNK/xCYMUYlQ44drjSmr3hHRH
	s4MjGWA==
X-Received: from pgvi20.prod.google.com ([2002:a65:61b4:0:b0:cab:ba03:2c9f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4596:b0:3d0:cc29:ff63
 with SMTP id adf61e73a8af0-3d0cc2a04a0mr7937373637.12.1787779997474; Wed, 26
 Aug 2026 14:33:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:51 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-12-seanjc@google.com>
Subject: [PATCH v10 11/21] KVM: x86: Fix KVM clock precision in get_kvmclock()
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
index 0255ca6b24c2..b958a6ff7f34 100644
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
index d8bdc64b31ee..1da7b60fe274 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1249,6 +1249,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	kvm->arch.last_tsc_write = tsc;
 	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
 	kvm->arch.last_tsc_offset = offset;
+	kvm->arch.last_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
 
 	vcpu->arch.last_guest_tsc = tsc;
 
@@ -1561,6 +1562,8 @@ static bool kvm_get_walltime_and_clockread(struct timespec64 *ts,
  *
  */
 
+static unsigned long get_cpu_tsc_khz(void);
+
 static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 {
 #ifdef CONFIG_X86_64
@@ -1584,9 +1587,30 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
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
@@ -1660,22 +1684,10 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
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
 
@@ -1685,10 +1697,25 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
 
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
2.55.0.887.g758fc8c411-goog

