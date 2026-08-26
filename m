Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F25494811
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780012; cv=none; b=c0DuJVI5xB20Lqxs/JfWtHt4rX/XhAFT1qTcuPgcjFlaQRuc2gzK/QRbYJkjTIa1F1J4o+Sm/i74gepVMpHXpvTM6DK9wUH//Rz24ggELl7GEjVxa992FaE9mZM1ea1JJdXk+tDwKPaoMswflJ/EzdQDuBoP5kiW44Pn70yLqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780012; c=relaxed/simple;
	bh=5o1ucxtr3buA18SWRKhpY2bxC7WdEGghBR5g0Rxi3wM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PavVOD6xCnl+YAgdyNwDx4Q61VoeVUqRyVeeNIihjNgAh4dJsOhn8j8e6IIAQgA3wsU2ePYsJr+C7GPaGtqbjXS68TxlsBhHqaKXZBCsaoEY6Gg50s88RC3x3U3codCbH5jU5hxBCyvje29c0Ur3KMp4w1nxCIFTLHkYP8Yy9LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ph21pb/4; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ph21pb/4"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6f75c1219so29573335ad.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787780005; x=1788384805; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UiH12BgSBfe0UjZRWynvrUBvNJGP2GUeAXjWBAJFBLE=;
        b=Ph21pb/4O1HCECZpP8VXLQV7yUva4/iJFKHjKqL9LjSGMteOsX0LTEFsZeZ2o4uCza
         DYR5SxD562TOQObS6aHyWN7XL90Uw44bpgCVytwnZ9l7R8nlYDJyAZSogomftgf+hHkP
         fGBC4fPkgNXBsvx+iN9rfTIPVnyAE0hQ6AKojXrGBV8Ud4wiOiIkz9W5jMa7tdMCLZSx
         n5Jb6QwpJ+swGhz64/qUmWPlqixIacrccBL+TO2lgiIPYkn/ECuEgzvWVoevPMDIvtLK
         y8MS5TtqQ43ij0q8ucyikJcQXfJ00PwMuKv85g7E1DUJxW4oS7cpfLEmIR1eHqF+LwUh
         ps8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780005; x=1788384805;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UiH12BgSBfe0UjZRWynvrUBvNJGP2GUeAXjWBAJFBLE=;
        b=gaoVvnUVMq2pO1rXD4s8X3cFv3+VqpKwbpay2jjHZ9jdIqP7rbHYRsB/uM86xvfkZb
         B2CwDjyEHU+wSG6wC8fBexCoqQIcABpNIdtDTRqpNlYbqhaOiNsuc/LIme2XqDpF+emH
         KOqBbyK4fw2LvIKblvruzIilIwRdxFNVEDSg92gDQy4DLfmKZ7/QpoDuKc/xcKrE5Jvt
         CYUIkIrAUzUdf4txIU8ks99ohknuUJm7lxcfEIglmTyrOnpu/Hzjzip9juVqdSOEPVPg
         ujPpL/xFtsT8VnKTB/RrBMqfxvD8KH2XLhu1rq4KDK+Y9HeXtkx59RHA6LvyfXray8e4
         Xb0g==
X-Gm-Message-State: AFuF++k+SRaBmVenRkuCVj4ryrup8SjbUwZJ9vCHzUjqvPnqJYMTMvhi
	uXL9mSZE8g4TJqHz1vRMWckdLstwa8j0YWg6Ccq6pHVKbC3c0dp7KaPgmWAMgawmPAGxZzdGH74
	rfq2kCw==
X-Received: from plbmg8.prod.google.com ([2002:a17:903:3488:b0:2c7:f626:ec80])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3810:b0:2ca:d91d:d3a7
 with SMTP id d9443c01a7336-2d707aea3aamr193928235ad.10.1787780005172; Wed, 26
 Aug 2026 14:33:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:58 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-19-seanjc@google.com>
Subject: [PATCH v10 18/21] KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
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
index f7d9dfe6046d..51a8250e758b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1155,11 +1155,12 @@ u64 kvm_scale_tsc(u64 tsc, u64 ratio)
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
@@ -1321,7 +1322,7 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 	bool synchronizing = false;
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-	offset = kvm_compute_l1_tsc_offset(vcpu, data);
+	offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
 	ns = get_kvmclock_base_ns();
 	elapsed = ns - kvm->arch.last_tsc_nsec;
 
@@ -1370,7 +1371,7 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 		} else {
 			u64 delta = nsec_to_cycles(vcpu, elapsed);
 			data += delta;
-			offset = kvm_compute_l1_tsc_offset(vcpu, data);
+			offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
 		}
 		matched = true;
 	}
@@ -2627,7 +2628,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
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
2.55.0.887.g758fc8c411-goog

