Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBFE42AFA8
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886788; cv=none; b=tpePy/bkch5/exjfGZevXorBl7gLHX9ibhO1qv9jZlUaFMTf7nxIF+OkSFQXv9mQ9/ihpJ7WQIkoSXtBVY1yo6AgZC2Wd6+LIQWrFivUZUH8taiQXfVY9+sOXBbz4isZJSWrJ2B3RnAAQPuzYXd2XFSJxvyyaNwn5S5uIj0iY+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886788; c=relaxed/simple;
	bh=8lvDeWtkfX+uoVNKASmySKo/OUYCoXFwueXvmd3AzkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MRkK5AsSLQ8jvkbkL+cMvgZ28YU7emr2hg2EJiigr1FdA+pYkxVZ8rOIlnmXt5woGou0lsehpLq03AkUHLnjnHaE8tWH1JV29AZQgboDYuxa3mUS/KtmJ2EdPqjkZQ7mn+N9ZtJCoXmuHJGIiRaAdwaphQs11t6JysXdoW0Gv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iSUJBOiY; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSUJBOiY"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8486ffba174so690758b3a.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886786; x=1786491586; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MegQ9HN/KeyZhKX/8lwjVe1LaOD5fsnTzVy8ULN73io=;
        b=iSUJBOiY+HgMLbUGMNAotMbU5PiXqIaMaWvXY0MLVIr9o+tIRmg6rA0psRegaAno2r
         ffPGMyGzwkojgesHc4giEzFwT0V0CdlY4ty6biHI29cTtl+vtaNOy6Fm6ucCKt/3tPDF
         LiuiI3Zx2VMqjbHKPWlECEuhXu5JXMTPVLPEIs9S19BU3KX0/PICNQlsocBDVji4che5
         +5NxrItGiI8B/3VsleiH0Y9kQLdiso3/VYKDR9iPTzR/yIOoOSGdkf79rNILTbj34HMW
         vJC/BU/3drXDBH+rtCoJ+QG+7rLeJPL7U3NY3KZzD97br35c5KCsTe/unOc+9oHUPb5b
         b7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886786; x=1786491586;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MegQ9HN/KeyZhKX/8lwjVe1LaOD5fsnTzVy8ULN73io=;
        b=PNU7ieBOD79UwwLP/0h9YcZsW3eKapIBslpNcdYdXjVo/g/T3LR8n0E94/TW/w2X5R
         CvIWUbSTSQtQJ0AMCUvxArQ6PMjwzLTUNagcifL+IjyyP+zYml2jbR1MYIjsKE3GTyIT
         NWqKRsIvj+4fSqFvJcdfRNNuuJzXXpHhH8rBftSSWIETv8FPmItIsPuxrWxjQtXisPXk
         F+qo1Kv0WBgojrMflO/9SdNQ5CSo5qeVIG4w4LEUIZxGMYtoVE6uyATbdO/aTWDFDxIO
         XtDSn6ghJMxh6qicBgdwNXjZdfGZXVqfbnJazirVLHVecRXIW0KbjL4Up+jfcakCR8kx
         f1kA==
X-Gm-Message-State: AOJu0YzPpxWe012ZPQQYJjTRVwsi6TDTvOfAnf2nMzd2yJ9FcYbfm1yc
	S0Rfn+K9jOHUUSJILQS3Enl8R9fK4d7vLKxArIjwowtRraBtmGo+vqFq0CBiF6ou5kmCCzfnLwv
	7vN8E/g==
X-Received: from pfbfv6.prod.google.com ([2002:a05:6a00:6186:b0:848:487e:d23c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c95:b0:845:3033:6cb7
 with SMTP id d2e1a72fcca58-84f2dfc8ec7mr1879050b3a.9.1785886785607; Tue, 04
 Aug 2026 16:39:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:21 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-18-seanjc@google.com>
Subject: [PATCH v8 17/17] KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

Let the callers pass the host TSC value in as an explicit parameter.
This leaves some fairly obviously stupid code, which is using this
function to compare the guest TSC at some *other* time, with the
newly-minted TSC value from rdtsc(). Unless it's being used to measure
*elapsed* time, that isn't very sensible.

In this case, "obviously stupid" is an improvement over being
non-obviously so.

No functional change intended.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/msrs.c |  3 ++-
 arch/x86/kvm/x86.c  | 11 ++++++-----
 arch/x86/kvm/x86.h  |  3 ++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 66fa7140d65d..22ceb39d41f6 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -1631,7 +1631,8 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (msr_info->host_initiated) {
 			kvm_synchronize_tsc(vcpu, &data);
 		} else if (!vcpu->arch.guest_tsc_protected) {
-			u64 adj = kvm_compute_l1_tsc_offset(vcpu, data) - vcpu->arch.l1_tsc_offset;
+			u64 adj = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data) -
+				  vcpu->arch.l1_tsc_offset;
 			adjust_tsc_offset_guest(vcpu, adj);
 			vcpu->arch.ia32_tsc_adjust_msr += adj;
 		}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 02c389523f52..cbe4fd3457b4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1153,11 +1153,12 @@ u64 kvm_scale_tsc(u64 tsc, u64 ratio)
 	return _tsc;
 }
 
-u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
+u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 host_tsc,
+			      u64 target_tsc)
 {
 	u64 tsc;
 
-	tsc = kvm_scale_tsc(rdtsc(), vcpu->arch.l1_tsc_scaling_ratio);
+	tsc = kvm_scale_tsc(host_tsc, vcpu->arch.l1_tsc_scaling_ratio);
 
 	return target_tsc - tsc;
 }
@@ -1319,7 +1320,7 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 	bool synchronizing = false;
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-	offset = kvm_compute_l1_tsc_offset(vcpu, data);
+	offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
 	ns = get_kvmclock_base_ns();
 	elapsed = ns - kvm->arch.last_tsc_nsec;
 
@@ -1368,7 +1369,7 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 		} else {
 			u64 delta = nsec_to_cycles(vcpu, elapsed);
 			data += delta;
-			offset = kvm_compute_l1_tsc_offset(vcpu, data);
+			offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
 		}
 		matched = true;
 	}
@@ -2625,7 +2626,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 			mark_tsc_unstable("KVM discovered backwards TSC");
 
 		if (kvm_check_tsc_unstable()) {
-			u64 offset = kvm_compute_l1_tsc_offset(vcpu,
+			u64 offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(),
 						vcpu->arch.last_guest_tsc);
 			kvm_vcpu_write_tsc_offset(vcpu, offset);
 			if (!vcpu->arch.guest_tsc_protected)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 0f5919b092e4..1d9a66048b01 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -335,7 +335,8 @@ u64 kvm_scale_tsc(u64 tsc, u64 ratio);
 u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc);
 u64 kvm_calc_nested_tsc_offset(u64 l1_offset, u64 l2_offset, u64 l2_multiplier);
 u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier);
-u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc);
+u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 host_tsc,
+			      u64 target_tsc);
 void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset);
 
 static inline void adjust_tsc_offset_guest(struct kvm_vcpu *vcpu,
-- 
2.55.0.571.g244d577d93-goog

