Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ECC44162B
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402528; cv=none; b=TtEt0YM45EU0FdZs0gKwKHoEWHgixRC3WGQZ2wap+/vzDv+HhF89fkiTmHcFQYfk5VSLxuTNlOReoaWPXfZT2pjVfwBoYbt8VUsDhllNlVb7fdNN65zIrwH+pZojssbQlAIhDGPvYedpyjjlmwBDTvFgiJ0FTESqzvwQI0DSL5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402528; c=relaxed/simple;
	bh=iFcglWk9F6qKya6tgx5SS1bWqEKMAce1EoiI4+P8W3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T7FXQxX5P9+S2zx3uj0pKvFVYU6Dh5hYxPTgP5V9VILQKAwt2klyROzvjwXV+NDBkJXLjaC7ogmNbf5EszxF23hOOm/MdxQ8/Rxom7dCFpHBzCtfqUg82dMjS0KIT4UgTznP3grrsvRe9Xqa25HCnI9pUXX5ZFWo1+aISFSQOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aso5LUE/; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aso5LUE/"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d001671a54so56247295ad.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402525; x=1787007325; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oH/Luzlq4au8ak/t1uoql865pxDvRNySjr6GD/iWdqY=;
        b=aso5LUE/l9Gy0eisYF0N7MjM9i0udyFalYW4cORUmBXSE/YTgZjPfCjqu5iebOWNDh
         7qf+76C3n9AkX7wXWIGdy3ZNdh8uajH++sAkwW2jW3gR8YnTZYDtzPxjSyu+pnOWLz3h
         rBuwW6WrhB250YSenmSnxUuCYWWvRHQukGXsCsddXtMLiLgktEr6x0Q3PUh9HTIQSUI2
         r0rwMljd8O7jDcS9DajT+VtN0nw0XfM7SxT7mBHF/hvehgRykzyykhhM3qqCvRGzajdw
         CANfeygOqZNsGCTImueDX9MsoBPaBMVE/LG1sJHPPPl9JPHoq4d5harjvrhcLY2fW/Rb
         dgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402525; x=1787007325;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oH/Luzlq4au8ak/t1uoql865pxDvRNySjr6GD/iWdqY=;
        b=A6185AXeUjgl/Pg8YRGdWaJhpSOTdsZLYFqxly/vG/Pn9tvY/pkNApk1tROKAUPZrm
         hMSKscuk3QTwgyff4vNSr3tcWHDHUAYtvhHyNT0cQzK5o8hfJbQZLkK0xlZJqWEk4fNC
         5AG1rwQcwdMxLASGpjtPAUamKZtx+rGgiWTxiL1fzQUaoMAr4ahOJHZQRcVBswCaE+jS
         L8CNXn9p2k2D6kEj9av1ox7FiBsrq22L2T59pvPguq5nEs6tEVH6ZbBgWDfx4IqHnPAg
         N3pyZ7d+319gQfeWykvhJPgDebrUnSEmx/p8n9rUrQH20ZCMIiuK2UZA90g57DGVGMOd
         9clg==
X-Gm-Message-State: AOJu0YxsQ3M/59JFpAIqlFTsOc5KkGkD6CtoRKC13ifs88nf8iyim7kk
	s4keEVPU55839OGhdS/IzAEuAEZSZoXUBnVxZ+2vRPSB6mnP+3ttAJmg5k91n/vn+fIT10sniYX
	P3fX2kQ==
X-Received: from plbiz4.prod.google.com ([2002:a17:902:ef84:b0:2ca:b2fd:5a4f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d546:b0:2ca:6c8:abd8
 with SMTP id d9443c01a7336-2d300337a4dmr58949855ad.12.1786402525067; Mon, 10
 Aug 2026 15:55:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:56 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-19-seanjc@google.com>
Subject: [PATCH v9 18/21] KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
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
index 7661c49ccaed..aa39a423694c 100644
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
2.55.0.679.g6767b8d81c-goog

