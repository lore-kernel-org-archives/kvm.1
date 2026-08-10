Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25E434407
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402527; cv=none; b=l5FRc9mzYeEIFL+nmYlW3nk6IQGT9vveBm3JmSPcPhijJIbeR/P22TMGM3O71epLBfpgkLRHyhZAnhgirHRgnBNDcgBTTbIUnyM2z9D7eADRXLT727OoxlTTNJhvY/fsLUvTleaEHo8tbF0733sODymPD4VPM0kamKO0A2xv02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402527; c=relaxed/simple;
	bh=qE7twB9LHqX5wJ4D249ZvlxpYPETv3+Tb+pc76veePc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G1WDK+ZcBVOT8OWeDlGpGrU6MjGwYaClv4cq+QLiQzkb9ZrVox5X9gP100QbP5Ly6wQyszVmQLPK11m6GLqdrul5ehXGMX/fXvSo9OMjNxvXshtfb7h8H5kaCf891AlCBDU8N7nSATAM52Vp3gJi1+Idofp/zIFRs933YfbBZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lynp2I6Y; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lynp2I6Y"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccd1958e8fso35602465ad.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402523; x=1787007323; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PvqJXiept+sy/D9olFJ27hxypc4xjYNey0XP8SG3v0U=;
        b=lynp2I6Ykd/Dekh/VtgdZuDWbpKcmmlMPGt7hHHVI2h/Myo0gsobElPMMftlXyuNc2
         gb2iGmk9iFX7oSxK5IG6woftKAJ8Rgm9nOjSvmvS4RfAlWWDq2L6xb3oQaPXxo9J6tYW
         Mhy6YDDdx0pBzJkmY8UTF3qOV9l3GqVfS+tn5nJRjhwHiX1lGpYDmm4cpRRyofg08iFm
         83FHunQqylfJNr0sQaSyp3/+M26zWbk71HCGPNKUaMAKfYIOKOsYCR8wCaJiIJP2SQeT
         G6byMIGXJdxj2cSlk1GDsbb4z12BfmVbm2OD92E883Wvr/XVM4SlppUqc1nKzuUWK9Jd
         VONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402523; x=1787007323;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PvqJXiept+sy/D9olFJ27hxypc4xjYNey0XP8SG3v0U=;
        b=n4S9ZhqdGiP1s5LS28tJU9OayrKbbeo+heXR2E3yc9UdXNFgBz8jaAfutAJRcca+t8
         RrHuJr3aj5aZ7reX5A9ETYVBk4FI9kPQVp9VSOgCSmnF4My0wSXVK8Ax6DLbSyW2bi2A
         tgelhxvOupw+dH9nRDj9eFqQkUVMqxGHKeOXuZK/THKIrgrRRj1IhpgrDNz1wbGjINpP
         f3hXBoqjNzrOg07C9mwqZ0yf9VZufHVuYUjtrN9Le6+OluAk532/YvrXH3to6Sl4n8dj
         OdFkwmRi0ZLcD7X4uxSwRfzHVkBrPU0wk7vP+NwAp/9ZtCpgD20djgBP5tuzITATfszW
         OFUg==
X-Gm-Message-State: AOJu0YxnFUHR1352iNPEAx/NhhfBZzRhWgJ+q5balQYjcx2f6uHJKukV
	e8fe/pX4LiZtMcdzCMp9EQgWrnHlZrUNkDpCE+alqhVpaFacnz6p4s8j24XKlvmOFA9jHIfgGjE
	gOR8tgQ==
X-Received: from plbkf6.prod.google.com ([2002:a17:903:5c6:b0:2ca:cba4:f740])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2392:b0:2ca:b8fd:f31
 with SMTP id d9443c01a7336-2d106da9160mr413442285ad.15.1786402522932; Mon, 10
 Aug 2026 15:55:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:54 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-17-seanjc@google.com>
Subject: [PATCH v9 16/21] KVM: x86: Upscale TSC to "now", not master clock
 when updating PV clocks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

When doing TSC upscaling in software, e.g. when the guest TSC frequency is
configured to run faster than the host without hardware support, always
advance guest TSC to "now", not to the master clock's reference values,
which represents some time in the past.

In master clock mode, there are two points of time which need to be taken
into account. First there is the master clock reference point, stored in
kvm->arch.master_kernel_ns (and associated host TSC ->master_cycle_now).
Secondly, there is the time *now*, at the point kvm_update_guest_time()
is being called.

With software TSC upscaling, the guest TSC is getting further and further
ahead of the host TSC as time elapses.  So at time "now", the guest TSC
should be further ahead of the host, than it was at master_kernel_ns.
Not taking that into account means KVM was advancing the guest TSC only by
the amount appropriate for the snapshot taken in the past, *not* to the
current time (which is what RDTSC is supposed to return).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d3630b2bfd3b..56c2fe11d866 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1796,12 +1796,11 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 
 int kvm_guest_time_update(struct kvm_vcpu *v)
 {
+	u64 tgt_tsc_hz, tsc_timestamp, host_tsc, master_tsc, master_ns;
 	struct kvm_arch *ka __maybe_unused = &v->kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock = {};
-	u64 tgt_tsc_hz;
 	struct kvm_vcpu_arch *vcpu = &v->arch;
 	s64 kernel_ns;
-	u64 tsc_timestamp, host_tsc;
 
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
@@ -1814,10 +1813,16 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	do {
 		seq = read_seqcount_begin(&ka->pvclock_sc);
 		use_master_clock = ka->use_master_clock;
-		if (use_master_clock) {
-			host_tsc = ka->master_cycle_now;
-			kernel_ns = ka->master_kernel_ns;
+		if (!use_master_clock)
+			continue;
+
+		if (!kvm_get_time_and_clockread(&kernel_ns, &host_tsc)) {
+			use_master_clock = false;
+			continue;
 		}
+
+		master_tsc = ka->master_cycle_now;
+		master_ns = ka->master_kernel_ns;
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 #else
 	const bool use_master_clock = false;
@@ -1883,8 +1888,18 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 
 	hv_clock.tsc_shift = vcpu->pvclock_tsc_shift;
 	hv_clock.tsc_to_system_mul = vcpu->pvclock_tsc_mul;
-	hv_clock.tsc_timestamp = tsc_timestamp;
-	hv_clock.system_time = kernel_ns + v->kvm->arch.kvmclock_offset;
+	/*
+	 * If the master clock is NOT in use, the reference time placed in the
+	 * hv_clock is "now".  If master clock is in use, the reference time is
+	 * the master clock's snapshot from some time in the past, not "now".
+	 */
+	if (use_master_clock) {
+		hv_clock.tsc_timestamp = kvm_read_l1_tsc(v, master_tsc);
+		hv_clock.system_time = master_ns + v->kvm->arch.kvmclock_offset;
+	} else {
+		hv_clock.tsc_timestamp = tsc_timestamp;
+		hv_clock.system_time = kernel_ns + v->kvm->arch.kvmclock_offset;
+	}
 
 	/* If the host uses TSC clocksource, then it is stable */
 	hv_clock.flags = 0;
-- 
2.55.0.679.g6767b8d81c-goog

