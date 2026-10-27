Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139149;
	b=lrcYKKeIxVlF4Bu4EpToYPxjgWWu3Dap4oTjyqlI+O8o32iuKvIR0LeTiv0fAiehV7mS
	 JEuXvnrRoczSG5m23St0SUtvehBJe9np3UH+9ZLyyUabeI68M8C3U7V0O3G0fP/DVGVGE
	 kC6+7ytvtfBdkyoRXc0a3N3JKLVt9QPgyQVfVK2z+OEObCRA/ZR9lgx29N01VC0UzlCjS
	 b2+5ZVuP+SldEZllvYpjJrcHnvLU55TDfVOgKLgB5yFPX+LOPvZVI23hSwKP4NHwEOpWv
	 0CvSzqKceTuPpN7A8sm9ItgQl6p6FCxDGJsWOfiiwD8F9xpxKM8Up6pLTBP7qsbfoiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=dYm1W2He5BBY6NKWGt29bcYFb4hGcqDS3Vh4Emo9n8Y=;
	b=W44iz4hkZgNcm9+ohvL2aQrJO1aVJ2t4XnzKoHiqsapmmjgkgcgo3BrM+PpjKz8dX89+
	 reHz9g86wLZhkWXr8fbuU21CIae9ypkRwhFAOTBOojxCjFRS+nXHm7E+vLGPxfyZi4KKt
	 BeC+xVePuyC5B//OhNG7gyA+EH3TSQAxcYBNvi4sBETrrLYKA6rcy9YUarH4OUaZ0iiBF
	 71iwD+jZOaMrY0ymqRvfgJXcXLKiEJwxB2lrUPBIBIOpyYqrj0M9dSkYGiX+XZuRKnV+t
	 3/U1yPOZ+1hVLHBg9jcJJbFKisc5XLuPr0J6jsNrtRquW9tGsJWR5r0GAaTfscQvXlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="l4RrGY/F";
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE731606A331
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE731606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l4RrGY/F
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e93e2f72bfso4403215ad.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139148; x=1793743948; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dYm1W2He5BBY6NKWGt29bcYFb4hGcqDS3Vh4Emo9n8Y=;
        b=l4RrGY/FMDBqf87GwbGjx4Fyem/i+cVr9NOuPaEIrVyQSLfcmJ+4/GxrWF1kvkc91A
         sIi79j28WVnd8FbwCtUqLjxffEIOaau0Ej75LovdttAtMUA0CnZAHcoubPFpHj8uCczH
         GW0KSPq8uo4dvIKNctRvQHXCcqAnIy9SMeqeal16xG8xv8x5LMM7kFPWA+LlED44n5Le
         6MrTOmpHPt7KF2W3+XRasxETeY0FYmcLzd/jqrNTPqYAuVmOOGAylOKT9Ku6dPDfkZ7t
         F1hBmmL9WOWg5za8qvtMtq8CWYd8iyNtobNya69FHAicPC8X45dT+S1uuJBt+D/44U6g
         dRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139148; x=1793743948;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dYm1W2He5BBY6NKWGt29bcYFb4hGcqDS3Vh4Emo9n8Y=;
        b=cHM43zRT/Flzb6nBZc2T3Udor9nw4cmc2zM0PrCJymuRxxnZJUxId6EQcC/JEtYi5B
         sDC/Y6YmFh7bDgsHKqe8B17mG0xb4nug97Q+gD1nNY1yiSZseK08r9i68moOlG3IoZeh
         iBz+xdj9kzQg7hJD+RvwrMSUgOhvHLRi42t08nPhLUz3EUmMll1SF/PeR1fEtG0xMHrB
         Ckqlyhi2Opc4l1lLDFY7WBiOVwZiVFuy9nOduJQoAwyYZB4SGbawslxn2shxBkoO8UK1
         iwcWQMEDSNJMyglKNEb+pzA/74RPyvqH1OHYdXMJ39Xi8zGuisJDC3Xd3d55VK2YqXck
         egBw==
X-Forwarded-Encrypted: i=1; AKwUvBzpeZTRKbaeUAVb60KCZsI44LJ/E1I9iD2V2HZ8iD4ARtnus56qFzbj9VAUEJuG61Kfzpw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIQPl46HBqX/aYZXVsXElzg4p04KXsSRNFJETOnTGPSDg/953j
	tvZj5Odr/gfTomv0oKOGpHW6zjZmnCpaH3cKZeqEIt7TqTzqb4V4IdvD+4Z5qrSj0VnZCbH8+J/
	FP8+Qrw==
X-Received: from plrb5.prod.google.com ([2002:a17:902:a9c5:b0:2e8:8642:f035])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18c:b0:2e9:60fb:5e41
 with SMTP id d9443c01a7336-2eb005809a9mr5348485ad.50.1793139148246; Tue, 27
 Oct 2026 15:12:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:05 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-13-seanjc@google.com>
Subject: [PATCH v3 12/15] KVM: nVMX: Cancel the nested VMX Preemption Timer's
 hrtimer in free_nested()
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Cancel the hrtimer used to emulate a VMX Preemption Timer for L2 when
freeing nested state instead of precisely canceling the timer if and only
if the vCPU is/was in L2.  hrtimer_cancel() bails early if the timer isn't
running, and KVM initializes the timer when allocating nested state, i.e.
canceling the timer even if it's not fully in-use is glorified nop.

Canceling the timer even if L1 is active will allow KVM to leave the vCPU
in L2 without having to retain an "is_guest_mode()" check just to cancel
timer.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1b30ad7731ee..553915015a75 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -339,6 +339,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
+	hrtimer_cancel(&vmx->nested.preemption_timer);
+
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
@@ -401,7 +403,6 @@ void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 
 	vcpu_load(vcpu);
 	if (is_guest_mode(vcpu)) {
-		hrtimer_cancel(&vmx->nested.preemption_timer);
 		leave_guest_mode(vcpu);
 		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 	}
-- 
2.56.0.307.g5fe7bd680c-goog

