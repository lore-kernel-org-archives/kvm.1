Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ADB46AF1E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093394; cv=none; b=WTB8ZjVmc4HKNJdUlMiqcKMK7huhjh4EDPXFnK9PgZpobEw4gSuhocNf8uCIs77UIe/zCL5HUPBpP18il5Mh7uqMJfdJRyf/cgloV5nMd8/H2ae29wqh2KuHePtzcoVsml/JOQwAJzjbRG6E9QsNBaJVj/pu3G+uuA7IUuPZVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093394; c=relaxed/simple;
	bh=Uir6IDB0pwquVmxdNK5xocb4DeiDBsUvz1nObKQsLvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=safgllN6Qy0uH99rhslsKSShLN9hpS7FEurIKzx1ZuZQIE69+bEGjw0Wrck+BqIrStLmTVYpesJqOy40EGNLEvPlzKQzdAJ+EGZJ5Wkxp9BzcKW+shf4AZrcZv+jW1cpaZMwMhnu0Dqe9yYatYrvvYCKF3ci3vRvN340niHpxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+/FjJFz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+/FjJFz"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf30576aa3so4715495ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093392; x=1780698192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hdC/WRkAouMWi8Y4ZlrI0Bkm4osriIlBw4YhEZJnKi4=;
        b=B+/FjJFz+2oFdjMJGPkG02uJxCLImDyLZuBFPK/Ft86vq7P8+IBg4pPZgiMSD7gSlV
         ZpXwBie7f36Q65UOUe+5Vkh00pXt1Jh3v29kfkfY0y4VmXgGEJOB4EBzsazZsMWXaMCn
         MPb6V4IIthMHTZ+Om/WBtnX38Q+jnTbZ66hbKgJ8Gd/ASJp4CsTM/9HiXFRfSIMqddPb
         foibd96nKu+erv96s41lPWTWLUna+irkfYTHdHcEniJPXCZyEDVZRAQd4VIy7WBLh3Ra
         DJmNpP1Cfiqpl/EDpZI/6Mpe9hyr/+c0oX5l3a5gXAIJ5DjDBZ5qR34cewZ+shfEZf/t
         lRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093392; x=1780698192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdC/WRkAouMWi8Y4ZlrI0Bkm4osriIlBw4YhEZJnKi4=;
        b=H35N2LlBLZ0NTWJF3+flfPAJ6iiKzJCVolHWmPGYgdE9C/vZbYfYweFfWmobYZulIs
         JJl/QY2NXlENUtiivczT1vBFlsQLI0JyEiZEvPLAwGBMG4EEoG8480frYnEocjuHvY9H
         MQcsq2W/mymTTxH+5FjejzrHQvQU2X02LbWDzc8A9rPbhghqfAVQKNGKi9GzLYbgzWM1
         4VUPQ4f/P3kGnjo9gQJSmKhkz5824SQkjSRK+yvf/w3PD7BZ4cYgz5kxYBTB+JBoMb0B
         p7L4ld1VDZv+YNdf7TYqcWuvnjBGzy9/7sHrx3bKsccwkxdPkrXPdP8eOOWaEe8N9+cN
         krbg==
X-Gm-Message-State: AOJu0YxCJu5atpUroKsAXHSbAoArmlPBPX0Ez1lFIMVtU/D7OgMyfrgR
	8y13xODQ15BC/yDeb3DYyP5PpNf54Dcd875jyRvF8ZyL5IyKBOAu4S/giRxL6gJvqbIyYVBgyRm
	ZSMGkeg==
X-Received: from pldt15.prod.google.com ([2002:a17:903:40cf:b0:2be:b2c1:9921])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2283:b0:2bf:372a:830c
 with SMTP id d9443c01a7336-2bf372a8484mr16584755ad.11.1780093392030; Fri, 29
 May 2026 15:23:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:08 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-26-seanjc@google.com>
Subject: [PATCH v3 25/40] KVM: x86: Expose several TSC helpers via x86.h for
 use by MSR code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Begrudgingly move adjust_tsc_offset_{guest,host}() to x86.h as inlines,
and expose several other TSC helpers in anticipation of moving KVM's MSR
code to a dedicated msrs.c.  Unfortunately for KVM, several MSRs that KVM
emulates can affect TSC state.

Opportunistically drop a superfluous local "tsc_offset" variable, whose
existence causes checkpatch to complain about lack of a blank line.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 22 +++-------------------
 arch/x86/kvm/x86.h | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 64c3680d889b..bf15c122f837 100644
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
2.54.0.823.g6e5bcc1fc9-goog

