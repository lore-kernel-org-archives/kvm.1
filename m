Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF92405E1
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860184; cv=none; b=qsDBSxmcWmCmRfq3SZdWCSP2lWYSFYwo8o2ejrllbLUcVb4WMXrEhwMnukbaB8VxP/4RJhVfPfS1aXAA5to1UEqlGq2FgRCL5Ix2J0Xap4D8jNp4TTq5e8WjsN44Ei5+SfacJAW0BZCZAB/KnGqNqFWMZD+VoglYiTZtOrpPKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860184; c=relaxed/simple;
	bh=ckzSbRdfj3GjtaU6LvW/bPgFTeEU1LukN2m/Yio5YiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EXAN3reGqaTfWFnuA1PJp0/uGgY/6ZcO188I59nfIgIhETi3GtVpd4YEwY4gCH4+gRP3oPupE/GYmqRr/ytHtM8aQUcZkq1mpAI1RG5w9E/Rt06RzXSJ5r4nE4MXw0sMqWagr1VDanzfOSQsHxES1cs+f1XXx9fEcu4OsXmFGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjsc3ea7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjsc3ea7"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d97955899so53330a91.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860182; x=1783464982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RqLzSEbiwp8bFgXqWMU4fMK8R9fc+pYc6UvhgAoac7g=;
        b=mjsc3ea7w/1n0ueN96bi30N42umT1rdfpNY4jHyCU3ApArh/GeY7kPYibZV6s/z88+
         kMDRHpGr5hWGHvUAYci+Ea+E8cZpUHkRHYiV+NBGXZElgmX2v7eu6pbsApxgXAxcAwMc
         3L3Qo38HhVv0OY7ESPfpSHXpEcqchksyp7/IAWHZe7kNTV5L6FUqKXJd8D+ob3XOfoTY
         Vs6UZ9ss+34f5bCPWEy0gvxNjyVyLJQZ4xNFowdirPDOGjf3+U6chGQ5DXZ+2S5h+ZP5
         KKFft3O4lN3DziUyx1gx2XgzRhK6viSXsqTVUie0L3MjBUDNW0HWdcRmjILrHjoVrkR6
         ClAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860182; x=1783464982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqLzSEbiwp8bFgXqWMU4fMK8R9fc+pYc6UvhgAoac7g=;
        b=AChJB+HMUoypIw63qzzlLCHXwmeK/HHUR8ftictcjxWYP1190172L+NmAxOztO4WEo
         VdTjJWkS3CUg1RiwatssoRC0fcD4qDSh/Anen5CIe2jLV3K8a3oRr6teOyB8pK6XQraa
         LgZkpVCIIF6LrnuN98YIQbEqdNmbGxgDgxPjSZihacNctaaMN3uzqO1ImSJ6Uo8SB42b
         kRkqkg+FcP48zCrpXESrYn/iPKbKaqGCYIy+5DSXqA23y6DmoZ9l0pix7U5w9/fadGNs
         XSq6O7ksWeQLsytjjHHdc0XONWfuhcQwoKnWrAwIS+8V9ArYXnDe2hAvZAqbvBS19W4x
         fy+Q==
X-Gm-Message-State: AOJu0Yx66XtEm7L2UZEPBfZdceHVP5mFFQlpSL/ZpUt8B1Oql76f8DS/
	/2pnHqOG9v3X54UFSIqB5yMqf0AA/PgcRuGnmw2WhHbROnQM66/wjLh3k3X/20fjAk4kZjMN0Mo
	vcTx31w==
X-Received: from pjbgc7.prod.google.com ([2002:a17:90b:3107:b0:37d:95c5:815d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:37cb:b0:37e:a09:2640
 with SMTP id 98e67ed59e1d1-380526b1b7amr4561425a91.7.1782860181922; Tue, 30
 Jun 2026 15:56:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:56:08 -0700
In-Reply-To: <20260630225619.511632-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630225619.511632-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630225619.511632-2-seanjc@google.com>
Subject: [PATCH v4 01/11] KVM: x86/hyperv: Get target FIFO in
 hv_tlb_flush_enqueue(), not caller
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
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

