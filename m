Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795045044;
	b=HzoNftqP+izO+GiZmV6+H5JNKqLccXGKKtaqLhG6zW2kkk3ZFubWkxlqp9dd10inewVb
	 8WnKeYotYWwzszr9/Qx5qMZV9iLXnHZ2wSeZbbbOng9UKxfdPiVpxYV3ks0pYBr53wCZj
	 GM2NaSL4zxUhvej0J1CkAI58z6aYfBtF+w1UU8L4a+ICqVBTLFwAMVSikUIXjASR8SN0Y
	 GmETuy6LNcraPGn9SlgjnAfG25nEsc47ot5qJbcfrIEOl/SkB0rgV2wViBx19pbyOsGwD
	 ak1l9AmZaPdOUYZ9Eiqin/19t/ywrst90JgJ3sbwdhafuObOwcsckVf7NvwjPokltQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795045044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=oxGRhGQXP+saO4hdaaeuycHrsZeNHZNVjp3QPLTuF0w=;
	b=vxFy0Rrr+JtNZJ95bnMG9Rvm/H8XjiddYMjMUIYlamXei4b/UxFvbpJg/H24jy3A1+8L
	 FToPrv+n7Q+B0S1hG2X2bKwupCJdqg8ylatPytkS7dMAwNvZe0Yf8VqSfjmfgbZDzGFnF
	 UYIDCf+1Yso3HjGVj9qg7HaS/w3BmW50DZiUjeZdsIG2x5Uk+m4JLPNBJr+TWy6M1nJQm
	 hnft6oEGXYZnUmtAb5F7oMG9iNS/n+2AbEyQYflLasd7XeamZmq/C6aViFXu4wJuo6Ivu
	 ko5KDnOARMpnAWUjrWinbj+/mvX9J3eiwUpUtl4tfowA4ptjE6P9l3wu5k9LHWQlV5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PYktBma3;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63622606A32C
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 23:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63622606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PYktBma3
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-55bf11583d9so480210b6e.1
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 15:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795045043; x=1795649843; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oxGRhGQXP+saO4hdaaeuycHrsZeNHZNVjp3QPLTuF0w=;
        b=PYktBma3zGnmgU3FEdhSeE3oExDUfohiUpQetb31i0M8L5INWjBsjCM4IaP4qQ+3Aj
         YBUNGH07aX6lMBWJX8+I0hAff+oRIKIBSQA0mYr22EO4shaWxDSkGp393sjibvOmqLli
         Shw7sK3NjguuAQYsIJbyBV9pBFzykc+jfwlSgWq1TGilA0laM2fGVgigOCqZZahqbqzw
         VHd7ODkk9lkQ0S1k/W75zgeYf3IKGxIMnEWByuuDY1YlW2vipjw2Jsor7aOJNgjag/yJ
         wPiNtTuw/lQRY5R7bDgayvDu48DkVHYqIQQxNEqaoso/29pLol8G9ZYNqBcFYyspehYk
         REuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795045043; x=1795649843;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxGRhGQXP+saO4hdaaeuycHrsZeNHZNVjp3QPLTuF0w=;
        b=YZM1/09iRia9rMvocIyQT1vdP7cC29g3WUEcF9Lf9qdaRtVwO46q0Rvsd1YHxAeThM
         ItPY2mb4MOsm7rcIAl7makRMDdjdilLNBo/cuNCBoOFqtsj0wExVkZfk5SsBb07kz4Dg
         65fvat9riLJZQ/72UiUwOvWEEg47l994U55IdqpNFC5it+tujF02lVEpFaz4yM0QM3aL
         FtrVM/kSsniefRbC2pzgnMWwnS1+fSZHzrCnRvUMBf93mpmSc7+IYnE82uOIjyGMxGp6
         NHEVBRpiqO+s356kzqy3iar1+eRRjyKb6RK0RgC9KSClr9HIBn9U75CDUs8dG4qt8m5O
         sMBg==
X-Forwarded-Encrypted: i=1; AL+hErEAThQrqAcoR2IWIJBlFyWc9sbYKR3XnahRooNXCyF+Jpw9ETpjFrZNSQ4fFiqsGN4JQqo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TnAqzV9u+HdaRd8BCNRQaN5P1DroWU7uYSz4bU4Bd0OWqrxa6
	79OVTV03NJDt0ab1zBLq7+pMEttbkDQIUZNRyTTz/9gQwnryaYpyLiqcHDUHUwV+dRdVg1YeT5j
	vOtLNtqtX1Ye7aQ==
X-Received: from ilei20-n1.prod.google.com ([2002:a05:6e02:61d4:10b0:54e:8720:76ce])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2f13:b0:53a:1c29:cb37 with SMTP id 5614622812f47-579083c6501mr264180b6e.38.1795045042975;
 Wed, 18 Nov 2026 15:37:22 -0800 (PST)
Date: Wed, 18 Nov 2026 15:37:19 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118233719.2101265-1-jmattson@google.com>
Subject: [PATCH] KVM: SVM: Set V_IGN_TPR when enabling a dummy V_IRQ for an
 IRQ window
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Per the APM, the processor takes a virtual INTR interrupt only if
V_INTR_PRIO is *strictly* greater than V_TPR, unless V_IGN_TPR is set to
bypass the priority comparison.

In svm_set_vintr(), KVM injects a dummy V_IRQ with V_INTR_PRIO=0xf to
trigger #VMEXIT(VINTR) as soon as an interrupt window opens, but it does
not set V_IGN_TPR.  If V_TPR is 0xf when the window opens--e.g. when
CR8=0xf (in L1, or in L2 with V_INTR_MASKING=0) while a TPR-independent
ExtINT or userspace IRQ-window request is pending, or in L2 with
V_INTR_MASKING=1, INTERCEPT_INTR=0, and vmcb12.int_ctl.V_TPR=0xf--the
priority comparison (0xf > 0xf) fails, and hardware masks the dummy
V_IRQ indefinitely (also stranding any VM-wide AVIC IRQ-window inhibit).

Set V_IRQ_INJECTION_BITS_MASK (which includes V_IRQ_MASK,
V_INTR_PRIO_MASK, and V_IGN_TPR_MASK) in svm_set_vintr().  Note that
svm_clear_vintr() already clears and restores V_IRQ_INJECTION_BITS_MASK.

Fixes: 649d68643ebf ("KVM: SVM: sync TPR value to V_TPR field in the VMCB")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e30ee80624b7..2c60413597ae 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1622,9 +1622,7 @@ static void svm_set_vintr(struct vcpu_svm *svm)
 	 */
 	control = &svm->vmcb->control;
 	control->int_vector = 0x0;
-	control->int_ctl &= ~V_INTR_PRIO_MASK;
-	control->int_ctl |= V_IRQ_MASK |
-		((/*control->int_vector >> 4*/ 0xf) << V_INTR_PRIO_SHIFT);
+	control->int_ctl |= V_IRQ_INJECTION_BITS_MASK;
 	vmcb_mark_dirty(svm->vmcb, VMCB_INTR);
 }
 
-- 
2.56.1.708.g77570a6a1d-goog

