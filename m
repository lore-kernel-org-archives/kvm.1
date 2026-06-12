Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632D03A5E9E
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305588; cv=none; b=jufSFLcOIqKIehSmCab7WQUpv0LjLmmqpA9N7ZZjZf27KevrEUH0LrGLQaq8CCHcQr3iPk6uS0etk5fm7akclF5WScPZCslrdwME5hkPW1zqkpoAvChj2cbLnqf7ltuMrFt86/RaKvoHVLlVlj3D3VaMyZYtohg9EECQST/uFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305588; c=relaxed/simple;
	bh=Me0Bhs5/EQQZjcTAZ/V1yRJ2/LW8GnZyPuXt9LJK+oQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sGwZx/J8WvzMHXy0NmbTzG1qHC95S9bZpZQVStklI6P/945I48R7QVDoY05JLC6GELLOPIKyCmvirMqlIM6JujIgGGQbU2cDS/gd/woI5xpIJ8gjFPaDVQ+brB+eK38TEuW2e477bEackppZx+2uZt+5PSmgRqk9yMM6QRQe+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpubkjuN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpubkjuN"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2c305d0so722082a12.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305587; x=1781910387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/Hg8GhN12QlOv0K4ONCzUqIsw11l/FiOwKl0Rw2yUVA=;
        b=lpubkjuNsILIbU8jPPILJcr3UxUo+jOfksrzD6QNIe7wtue0twuS8RaRelVwwxCIzD
         G4ZcpDmt04x4ukEuEeadwIcr8+6Z62megymXlj8SdW4weQPpYHANxHksRVfwbN7LYWa0
         IBiu2njHQ/iLQckwYJI1ISvGxtOaHr4Js+xy0upv5KE0aAnU8WxrI8yb4qaMOUqH4S4U
         CKsfhAfuP8BJxnlG8NTNF5gwgxcqW6VbZ7+2Zp9GxXmRu7pTy5Cmj6Nz5WBeVeIjEB+N
         BQKKToz/+zbA2k3+NFcsbFYzIq5mrXIxbYdmCpzInxMXP0SwjOCZ73GDsBsPn8K6XgIH
         CfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305587; x=1781910387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Hg8GhN12QlOv0K4ONCzUqIsw11l/FiOwKl0Rw2yUVA=;
        b=Gg+k8LZ8D4IvbgIK8XipZ/Fk80FIx5tMTabVIpsESP2s9fPWtHdED41qGkhg1LBauU
         5CN5y3JRquQS8Y/ZEZhaedBLqzPNgHaMGxAGq6DDHV+8crAlmhGJc+aONrYpFgGlCm1A
         RqRitoRNUAabLxPLVb8Z9KUzVWH1C6YULRz4MZCrbA8YeNEHqno5ihpujlUVpNbMpi7v
         SCNCUhSqCWixDUgigvPP2OtR/HkEqf/poDULX73+RcD4HeWaz50yV/w9P1SXJyvTBq5D
         rmSoxlu2Lx/C4BiT+9z6ivY+NisSbBX0w7/2Pw9IKQtI89FNAAHOzDcd8Fc/vhpavGaE
         iC8A==
X-Gm-Message-State: AOJu0YyJR8TgCyIQIn9NIkIsfEDjCtCSShcJ1X+pzIOBjYhJ7/zmYQlY
	uzZQa0YXOmUqbYPbuF6CWG6M0y2uvni9vLyLsgMYgnHXO2Fd3LZzFaEitbPP642yj3K7efVAIIg
	CPosrXQ==
X-Received: from pllh1.prod.google.com ([2002:a17:902:7481:b0:2b0:b22a:e6ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234b:b0:2bf:bd17:90d4
 with SMTP id d9443c01a7336-2c411d79937mr55905765ad.28.1781305586571; Fri, 12
 Jun 2026 16:06:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:06:15 -0700
In-Reply-To: <20260612230622.687665-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230622.687665-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230622.687665-2-seanjc@google.com>
Subject: [PATCH v2 1/8] KVM: x86/hyperv: Get target FIFO in
 hv_tlb_flush_enqueue(), not caller
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

When handling Hyper-V PV TLB flushes, retrieve the to-be-used FIFO in
hv_tlb_flush_enqueue() instead of having the caller pass in the FIFO.  This
will make it easier to fix a cross-vCPU race where KVM can access a vCPU's
FIFO before it's fully initialized.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index fd4eb1e561f7..a894e3d2e594 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1935,16 +1935,18 @@ static int kvm_hv_get_tlb_flush_entries(struct kvm *kvm, struct kvm_hv_hcall *hc
 	return kvm_hv_get_hc_data(kvm, hc, hc->rep_cnt, hc->rep_cnt, entries);
 }
 
-static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu,
-				 struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo,
-				 u64 *entries, int count)
+static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count,
+				 bool is_guest_mode)
 {
+	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	u64 flush_all_entry = KVM_HV_TLB_FLUSHALL_ENTRY;
 
 	if (!hv_vcpu)
 		return;
 
+	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode);
+
 	spin_lock(&tlb_flush_fifo->write_lock);
 
 	/*
@@ -2017,7 +2019,6 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	struct kvm *kvm = vcpu->kvm;
 	struct hv_tlb_flush_ex flush_ex;
 	struct hv_tlb_flush flush;
-	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
 	/*
 	 * Normally, there can be no more than 'KVM_HV_TLB_FLUSH_FIFO_SIZE'
 	 * entries on the TLB flush fifo. The last entry, however, needs to be
@@ -2145,11 +2146,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * analyze it here, flush TLB regardless of the specified address space.
 	 */
 	if (all_cpus && !is_guest_mode(vcpu)) {
-		kvm_for_each_vcpu(i, v, kvm) {
-			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
-			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
-					     tlb_flush_entries, hc->rep_cnt);
-		}
+		kvm_for_each_vcpu(i, v, kvm)
+			hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt, false);
 
 		kvm_make_all_cpus_request(kvm, KVM_REQ_HV_TLB_FLUSH);
 	} else if (!is_guest_mode(vcpu)) {
@@ -2159,9 +2157,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			v = kvm_get_vcpu(kvm, i);
 			if (!v)
 				continue;
-			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
-			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
-					     tlb_flush_entries, hc->rep_cnt);
+			hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt, false);
 		}
 
 		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
@@ -2192,9 +2188,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 				continue;
 
 			__set_bit(i, vcpu_mask);
-			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, true);
-			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
-					     tlb_flush_entries, hc->rep_cnt);
+			hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt, true);
 		}
 
 		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
-- 
2.54.0.1136.gdb2ca164c4-goog

