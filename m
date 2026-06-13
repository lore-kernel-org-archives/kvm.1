Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03546223DCE
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309034; cv=none; b=IUeIIzcFgpx/sSfgxyxN8wreH1AVEVF6EaO0Bn+kGe7nyjXpDHnFmXso/blvV/LM1oZfCoNTIJiIlTAVhhg++0Sgb8oXys/vM7t9SkDSgSfJ0+NVbKWXUx6Rsyg2Dv3nB2vJ6/bmOECj9YNtHLKUIU6NzEleb+4b2aLjXXeQjlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309034; c=relaxed/simple;
	bh=h9cznt+BZf/eapV/CMYBDaU4d5VpFVZOTgaLWWpfFzU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZXz00wAqK50NwXVLbl0yQdVjYXe4u3JzkvXP0uqfM5u2IwmFMVJPyLXS7Casmi1C4AYswaP6/xq0KdY3OSOqqOVGP7hmj3SZsegBz/19t+1DV+ceh0AU16jvxysXf+mz+vNq3UqDT0cpOV8LAygP98Mvg3ggL23eYRaIpqwyTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oT5aoKOt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oT5aoKOt"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so25000235ad.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309032; x=1781913832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NCA5hBO+hMlQdhwEzHDBkUNVZA7RV2Rl0pjc6ph/Peg=;
        b=oT5aoKOt6nAtNP2CsudgjJD8PE1Az7VrmgWhJO3sJVMrliYt2Wty/LXL9h82QQ+bt4
         gfXNiixQ9HKGSxKP4lGOzSKytWqB9SEEK6BvQ8EfNVBV/VMPQaEGqMU6jugpfC64f2gO
         S75PF1N6LisuQ6mOQh75xUjt2t2BphV2pYc4+9VQc4eP4wez039KUK/TtJk96///FSWU
         cnhuoRSvWAyFDF3jNgWVKmpBlxLXH7wt5OX6COn0z9RyC3bTJSMtaFi952UhbEFSxjI5
         xX6OPFIWl/Evi7Ek1XFzI/a50Rz1kZVsasfvRlc+Zm02g8kilCl5qDwSZmGy2DSWB3VR
         X0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309032; x=1781913832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCA5hBO+hMlQdhwEzHDBkUNVZA7RV2Rl0pjc6ph/Peg=;
        b=mXVKExP7a5zjZ4TqfYDBhe/YfaRQpdlXisohC2N601ZfxHltcdkXnZwQc9gLlB8GmK
         OR7zqX+/AKSQ8KsM1vuSWNX6VKt0uBkD8Nmuy+kSh9cQQ0ZyP6qLCY5O4cDRm6kDbbiC
         a+TNi+eppiGUC4olcjkfHd9lbkxTGI85LS012g6gsn+8AgK+rk7hrAn701IOzlrKFcJw
         Cmaywgs/IV1x/q4PHsSQPg3P9gTX0nVQosBP9CmzbitP6v76KS4IthT+a5L07qVYaHD9
         G98ocqRDeaTIhzg6rkNRaROkf1gHJo8OSA08ED+dygcTXmI/CcooVuM9qr8fpQ6qLeJm
         wA2Q==
X-Gm-Message-State: AOJu0YwWBxU7/4+8zAXuzrhVER2oxja/uhM5Bi4czKeQ2LzPVFk62ghl
	BMBOY0RAalb7yYglZhrLLZFuK9eE6fe5daeh+Wlnj7R/iqmLLTT0yw/fwpmK3IEG5IPUJs2dm3e
	rYhJxHg==
X-Received: from plzt12.prod.google.com ([2002:a17:902:bc4c:b0:2bd:9e64:2df1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e742:b0:2c2:4ce4:c5d4
 with SMTP id d9443c01a7336-2c41235e5cbmr60165765ad.17.1781309032164; Fri, 12
 Jun 2026 17:03:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:12 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-14-seanjc@google.com>
Subject: [PATCH v4 13/30] KVM: x86: Expose several TSC helpers via x86.h for
 use by MSR code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Begrudgingly move adjust_tsc_offset_{guest,host}() to x86.h as inlines,
and expose several other TSC helpers in anticipation of moving KVM's MSR
code to a dedicated msrs.c.  Unfortunately for KVM, several MSRs that KVM
emulates can affect TSC state.

Opportunistically drop a superfluous local "tsc_offset" variable, whose
existence causes checkpatch to complain about lack of a blank line.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 22 +++-------------------
 arch/x86/kvm/x86.h | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ece8d53fb7fe..316ec7a57f7d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2225,7 +2225,7 @@ u64 kvm_scale_tsc(u64 tsc, u64 ratio)
 	return _tsc;
 }
 
-static u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
+u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
 {
 	u64 tsc;
 
@@ -2266,7 +2266,7 @@ u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_multiplier);
 
-static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset)
+void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset)
 {
 	if (vcpu->arch.guest_tsc_protected)
 		return;
@@ -2380,7 +2380,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	kvm_track_tsc_matching(vcpu, !matched);
 }
 
-static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
+void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 {
 	u64 data = user_value ? *user_value : 0;
 	struct kvm *kvm = vcpu->kvm;
@@ -2448,22 +2448,6 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
 }
 
-static inline void adjust_tsc_offset_guest(struct kvm_vcpu *vcpu,
-					   s64 adjustment)
-{
-	u64 tsc_offset = vcpu->arch.l1_tsc_offset;
-	kvm_vcpu_write_tsc_offset(vcpu, tsc_offset + adjustment);
-}
-
-static inline void adjust_tsc_offset_host(struct kvm_vcpu *vcpu, s64 adjustment)
-{
-	if (vcpu->arch.l1_tsc_scaling_ratio != kvm_caps.default_tsc_scaling_ratio)
-		WARN_ON(adjustment < 0);
-	adjustment = kvm_scale_tsc((u64) adjustment,
-				   vcpu->arch.l1_tsc_scaling_ratio);
-	adjust_tsc_offset_guest(vcpu, adjustment);
-}
-
 #ifdef CONFIG_X86_64
 
 static u64 read_tsc(void)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 635a21bfa681..31e67b060148 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -345,6 +345,25 @@ uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm);
 bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
 int kvm_guest_time_update(struct kvm_vcpu *v);
 
+void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value);
+u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc);
+void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset);
+
+static inline void adjust_tsc_offset_guest(struct kvm_vcpu *vcpu,
+					   s64 adjustment)
+{
+	kvm_vcpu_write_tsc_offset(vcpu, vcpu->arch.l1_tsc_offset + adjustment);
+}
+
+static inline void adjust_tsc_offset_host(struct kvm_vcpu *vcpu, s64 adjustment)
+{
+	if (vcpu->arch.l1_tsc_scaling_ratio != kvm_caps.default_tsc_scaling_ratio)
+		WARN_ON(adjustment < 0);
+	adjustment = kvm_scale_tsc((u64) adjustment,
+				   vcpu->arch.l1_tsc_scaling_ratio);
+	adjust_tsc_offset_guest(vcpu, adjustment);
+}
+
 int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
-- 
2.54.0.1136.gdb2ca164c4-goog

