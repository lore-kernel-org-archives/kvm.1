Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD23D669F
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305591; cv=none; b=bWzMdEvHct8IMLB+dNev8WyrkwhrfftpPtQsIAXrWmFIZdKhLLOWGbRbMIqbZ7kuzeH4bD1sik5O9+HnFKt0MXlnTjSrQRjVEN047P38S9GOnt5VIJ4i0oMRrOpm13DAVn/Pi2/pkjqTfgznVwWGho1ExMj4QOG6Odhi9EZgAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305591; c=relaxed/simple;
	bh=cLoeO8KfiClGgJNI08IgErFX/9v34pzll+2dbsgolRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m8GelArh5ZYnSuqDcU1UAXJBfYhdyUTF4c5pYJc772TnmuY/c3EyQ8NjSMQ/x/8cuOxAyaKsXYhahRAIXVfy8NHYIoTEl+mRdsDtzms6NlGYEYYu5y4puvrkODzANvOjMOe/DaD8UViUmbzKBPxz3U8xC5NAVKL1ducb7+5CF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDLVx86w; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDLVx86w"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b934a336eso1165958a91.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305588; x=1781910388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=m5kR/3woI3rfb1R3e3eUF/PdaX7A3Ic+8QINcyng7RQ=;
        b=UDLVx86wl8Oc3D3RsC4mkmbsy+FJtRh/+UiiGx1DP9lrZYeE2/QyLU6CXHA7oNMD1y
         KLfCJltihfJsKXbuvDVuPpi4yDE6o2Ctof4HYwV+/iyw7sac3HQbXh0H6bD7IKFWmnj+
         kaEZ9YxSQF/lbE3dsZET44NFRcwfhVRGQ56tXXsbkdyHp8uOFdMhHTNIVJGXlOYN99JU
         RWPPnOsqIpcqGkhYoEeoV4yfZ872fWWO6rtEfeUONj3s7YJaZbYCMzoXI4XViJxzQjJs
         dLPZwtkjF2XYWLcu3PVc5TtfQshmS6knHktgHr6Hkb5VuNKt6k22felzCGJP6QRPe/Rq
         eGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305588; x=1781910388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5kR/3woI3rfb1R3e3eUF/PdaX7A3Ic+8QINcyng7RQ=;
        b=K/xJE3EO8iC6K/8wO3KRufj08Mvjas2tJWwah8L/9y56Rvq7KuijEgKJL4AFc2bX23
         4T1UiDzFKgbBHPK5G/B5Ql/bYh7xiZ0zAmZMUaq40W/GpW6EonS53s9kG46gMNtsVmou
         hDKlK3sSLg3aHX3m5ISARGoZJsiyfOIj0nIM3y8xgJrVcNTMEc4qety6d0jrDPNYUsri
         rs+o3umWcWg3sCw2AeZUJp8mjSmkfDKbU5WQugEcQCkKlSpxy5K/PNpi8xpc9Sk/V48u
         DPnR8pRNmgI3TmskF4qbITB6i4eC1Wj5XxD/T64pcq9rgZqbDwQnTYTGlTII4MZMrViG
         2/bA==
X-Gm-Message-State: AOJu0YyTSVGNt1fRKCiCIf4KG7JJ/vGrdWWOb8gjT/MVm2YTkf/6nzBY
	iFwLaGyCKglwbrOQlg8itukyKWbcL3QF8aZmJaUgmrh6gEq7WKBKfGCBrSwejSjzo5/ZUCKVKTp
	YLnbKrw==
X-Received: from pjyf13.prod.google.com ([2002:a17:90a:ec8d:b0:369:3e28:9233])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac4:b0:367:bf0c:54e9
 with SMTP id 98e67ed59e1d1-37c2bd1244dmr1139509a91.21.1781305587712; Fri, 12
 Jun 2026 16:06:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:06:16 -0700
In-Reply-To: <20260612230622.687665-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230622.687665-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230622.687665-3-seanjc@google.com>
Subject: [PATCH v2 2/8] KVM: x86/hyperv: Check for NULL vCPU Hyper-V object in kvm_hv_get_tlb_flush_fifo()
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Check for a NULL Hyper-V object in kvm_hv_get_tlb_flush_fifo() instead of
relying on the caller to do so.  This will allow fixing a cross-vCPU race
where KVM can access a vCPU's FIFO before it's fully initialized, without
having to jump through too many cognitive hoops to reason about the
correctness of the logic.

Ignoring changes in ordering that only affect the aforementioned race, no
functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 11 +++++------
 arch/x86/kvm/hyperv.h |  7 ++++++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index a894e3d2e594..ecd344b91739 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1939,13 +1939,11 @@ static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count,
 				 bool is_guest_mode)
 {
 	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
-	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	u64 flush_all_entry = KVM_HV_TLB_FLUSHALL_ENTRY;
 
-	if (!hv_vcpu)
-		return;
-
 	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode);
+	if (!tlb_flush_fifo)
+		return;
 
 	spin_lock(&tlb_flush_fifo->write_lock);
 
@@ -1972,15 +1970,16 @@ static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count,
 int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
-	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	u64 entries[KVM_HV_TLB_FLUSH_FIFO_SIZE];
 	int i, j, count;
 	gva_t gva;
 
-	if (!tdp_enabled || !hv_vcpu)
+	if (!tdp_enabled)
 		return -EINVAL;
 
 	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
+	if (!tlb_flush_fifo)
+		return -EINVAL;
 
 	count = kfifo_out(&tlb_flush_fifo->entries, entries, KVM_HV_TLB_FLUSH_FIFO_SIZE);
 
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 65e89ed65349..e6c74cfbb1cb 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -201,6 +201,9 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struc
 	int i = is_guest_mode ? HV_L2_TLB_FLUSH_FIFO :
 				HV_L1_TLB_FLUSH_FIFO;
 
+	if (!hv_vcpu)
+		return NULL;
+
 	return &hv_vcpu->tlb_flush_fifo[i];
 }
 
@@ -208,10 +211,12 @@ static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
 
-	if (!to_hv_vcpu(vcpu) || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
+	if (!kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
 		return;
 
 	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
+	if (!tlb_flush_fifo)
+		return;
 
 	kfifo_reset_out(&tlb_flush_fifo->entries);
 }
-- 
2.54.0.1136.gdb2ca164c4-goog

