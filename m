Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476B524F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426987; cv=none; b=EfaVXBvQ7V+kts9Tn2LwMtNfcxXfwHXRgPP38sOhm+Drsx2GqpsKDxL+ZlbFMIDhI77iiFcwjYb5/uSkkWK5tIhCq2vs3uEYZKKmPH/ZYrVgYZhCTwf5WFV7+YyaKGgQvzvAFOpNOElaAnVORU5q6ti80HWapwQkfzqP9Mq7/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426987; c=relaxed/simple;
	bh=ckzSbRdfj3GjtaU6LvW/bPgFTeEU1LukN2m/Yio5YiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NqDDBLQptBLoaqiKoXwoMCkj10FpmgP3LfZewlzCyQgCQsdP+ym5ZVykeC1lHAffts/L8p2tbrbLS5qTiC9HJEEIhEmsGv5l12E3n1UD7UJfu8qSzP+Furi9zk7cehcycpiDEOGweiwyDyD98+OQ2wOxU/iwq0bhwH7bxjiTDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=enkhndEZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enkhndEZ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84245e2bb00so184830b3a.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426986; x=1783031786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RqLzSEbiwp8bFgXqWMU4fMK8R9fc+pYc6UvhgAoac7g=;
        b=enkhndEZYxDlJMvMxYQRf+ER1GMo4gM9ztk3hZsc0s90OsXoN6M1SWyrcleLyumuD/
         pHUECJftIyWWchVvvR5z6JC2AcvW9+eiE9Y7bnmzW3Wl0q/MVj2HDr6ScEFLrpeP3siA
         e2haSMjLNhoCR2Hup20uiW0y9XL6urNVnoUDdgjIOoyrDBzpzhgXLVleUJxcBKT1UoRC
         /el7sK/L5jOvHV7pdHjZMqv+wzKIyEXcwpWL4YN/yFm4tHFX7NKtLWu9kL0T7FWt2CJx
         ZuYQ3SuGCn5Q2hq50KoCpKvIHMzCVZL47mVrDKqdY540zcix75ZeABe7Eim4wX4FLh+8
         stjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426986; x=1783031786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqLzSEbiwp8bFgXqWMU4fMK8R9fc+pYc6UvhgAoac7g=;
        b=PuyvPPSaD3shaLoI4KLplgVzeAqaU2ADp3+2051Svd5O++flKbseCMTXuaw0KPG3pq
         GLEndi6cdkCZrvQtHKcmZE2sscyP1rvxp4428ekB3+dIL+AOxcKGpQl+1JBC8JdQbZ9O
         brvepnuPh1vLVrfd3yaqLASfWL0R6xP1JGnYaVdpYNNIXmlGDFly02/nkEpsEFCe6XoF
         prtY3kl6ddvcriBBWQu9mdtpLmkfnJZ9w27MHbyJYg3VfVidA59FOV5cE3ZUGtT572Cx
         5bIVNMm791louqxE7BWrntGInF7FxemAESlGt2KgmbwrlhxSAO3hU9v77+igbjRa/jYp
         HSqQ==
X-Gm-Message-State: AOJu0YwCYfExKdvyFcLH0+FbDvALLw4/KfC+U4/r+lFjQVb+biLKVhFz
	nJzcYixyWvqeD6VpQExkgK5VAbIaGd6frz7d5QYUI3eoEsVnBuK9Ra7EVPLw1KloaqvZv9J73fa
	6/1Do6g==
X-Received: from pfme12.prod.google.com ([2002:aa7:98cc:0:b0:842:1ca8:3c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ccc:b0:845:3fea:965
 with SMTP id d2e1a72fcca58-845b3b71200mr5210367b3a.23.1782426985442; Thu, 25
 Jun 2026 15:36:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:36:14 -0700
In-Reply-To: <20260625223623.3376478-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625223623.3376478-2-seanjc@google.com>
Subject: [PATCH v3 01/10] KVM: x86/hyperv: Get target FIFO in
 hv_tlb_flush_enqueue(), not caller
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
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
index 1ee0d23f8949..2dc3e64b3f2f 100644
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
@@ -2144,11 +2145,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
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
@@ -2158,9 +2156,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			v = kvm_get_vcpu(kvm, i);
 			if (!v)
 				continue;
-			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
-			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
-					     tlb_flush_entries, hc->rep_cnt);
+			hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt, false);
 		}
 
 		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
@@ -2191,9 +2187,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 				continue;
 
 			__set_bit(i, vcpu_mask);
-			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, true);
-			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
-					     tlb_flush_entries, hc->rep_cnt);
+			hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt, true);
 		}
 
 		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

