Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201130F545
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953321; cv=none; b=f5pN9unXyBZPK8VuttAdIO4UyG9GjLgISsjo31ug3T5qShmmVFXJE+60txBWdbMF6BmKRIoIpL3oXQYhlirwUNMUCt3CuxApgvSPEqsf0ENNVSXF9Td1ElSzIs2vYb5ALCdvsBsBINwM/kkeet3rNSP4yE8cx1wkq5UmQj775rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953321; c=relaxed/simple;
	bh=65TgkQMg08z9v98/QTGjXbbOnmeQBFmy04CCI+ysCzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r2tDAc3aRIi0uHs5bPqTMW4DpFWSETunws+jFsfjGvWCjtGzFbKLgc10ReOOTBpf705TuYxr1R4+VopgGhLPnYB2oVHdTN4uR8oXMclhb5jFCqkJObJJLZrRaf2/Ehz13SQH1qPy9j6lhXA4lIiozG+zLwvqQRQo8iRwL6oDcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oz3IgbMx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oz3IgbMx"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7ada7b25f0so839299a12.2
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 07:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776953319; x=1777558119; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UfIb6NzFIHZCd+Kbl1hnaEGGr8JTvNw7w7yttxL+M6I=;
        b=Oz3IgbMxPkbbExU48TIM1lg6tVEXLVS+FdQfqrixe4n0FfWGql2wfIH+c71OgwD7A2
         tXpGuY/J51TmNhRcL+ZMDE2St+yFfcxBCWgfcSvM/5Z0j3wGWDtpoSnL9MJFZDa1Hj95
         IPxAG5mJFBFG8dHMCOut4PYUa/GwHe+f17TMnV20W5//EuQupAHPrxdMAd7x0Sx9xROo
         yTzUqZetoPTGUyi+iZqIprZ7DLFnzq6C3bFuEWiPXK82yWmO9MEiDFUBOELn0pOJzVzZ
         Fq3K4i4aG/mElOh4gZWw6BVZHnGozA5UPYHvJx4a/FTLoCn30ZaaxSA7YESWc4uRS36b
         vI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953319; x=1777558119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfIb6NzFIHZCd+Kbl1hnaEGGr8JTvNw7w7yttxL+M6I=;
        b=gvKaGlySr8bKC8YOWfMgR21JOwY/DUh7J/c5S51i3Ib1CnhAWxbb4sQfJvasu0CBJ7
         nef+ZSGas9yvpRGbxer89lMPoMDeI/hy64fyaq959dMJiynpH2JAH8gtZzP5Wvv65nO0
         yEEWM2xBxkk7TlvyZNp/OwK9UHcZJ7swn/2+W98vDUwxEz4PRfoxo8PGuK26uKhkshDw
         HlCSy/F6jF7WvsnuQ6y7Vx+0x7JAUGMLjjaigCpH6l3SdGWrZL2U5y5+FtrLOfrLNG+u
         yyP4lXgd45sGUJXocNfEMrUx5BIsnREbDbB0o0+9srsqH93nW/gkgpUTawYzpP4K5zlk
         kRLg==
X-Gm-Message-State: AOJu0Yylw94XKb5FQptOsQO8753PinZirR9Z6er7H3VDefr2yNbNhTfN
	bHXFRbXudoekQaQl51OtCPnIWaSsml26G75gpfh8VwPU98BFmCjj8F5EpSKUT5gOA/egbJUCHL9
	pN66gHg==
X-Received: from pgbfq24.prod.google.com ([2002:a05:6a02:2998:b0:c79:3224:837d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a110:b0:398:6bb5:54c4
 with SMTP id adf61e73a8af0-3a08d67e3c8mr31388062637.5.1776953319082; Thu, 23
 Apr 2026 07:08:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 07:08:29 -0700
In-Reply-To: <20260423140833.439512-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423140833.439512-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423140833.439512-2-seanjc@google.com>
Subject: [PATCH 1/5] KVM: x86/hyperv: Get target FIFO in hv_tlb_flush_enqueue(),
 not caller
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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
index 9b140bbdc1d8..3b7e860bd8d4 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1930,16 +1930,18 @@ static int kvm_hv_get_tlb_flush_entries(struct kvm *kvm, struct kvm_hv_hcall *hc
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
@@ -2012,7 +2014,6 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	struct kvm *kvm = vcpu->kvm;
 	struct hv_tlb_flush_ex flush_ex;
 	struct hv_tlb_flush flush;
-	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
 	/*
 	 * Normally, there can be no more than 'KVM_HV_TLB_FLUSH_FIFO_SIZE'
 	 * entries on the TLB flush fifo. The last entry, however, needs to be
@@ -2138,11 +2139,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
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
@@ -2152,9 +2150,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			v = kvm_get_vcpu(kvm, i);
 			if (!v)
 				continue;
-			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
-			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
-					     tlb_flush_entries, hc->rep_cnt);
+			hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt, false);
 		}
 
 		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
@@ -2185,9 +2181,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 				continue;
 
 			__set_bit(i, vcpu_mask);
-			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, true);
-			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
-					     tlb_flush_entries, hc->rep_cnt);
+			hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt, true);
 		}
 
 		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
-- 
2.54.0.545.g6539524ca2-goog

