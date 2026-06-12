Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226D3DA5AA
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305600; cv=none; b=pboTVzU52OuOPidTKhTFwbQft9eHMpudkJyu0lzp5AuhehbGXvS+TACa07yCJDTo1R6bK25rhL0XTe5i6/iMnfnyeT0MVVT77fOpnVlGjNGkbUg22r2wipdPGS1shn2wkFCSmxa7byyVGZkQRTG3aGlOZrYRTJ/++cPYDRQsaxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305600; c=relaxed/simple;
	bh=IsZj3GCjbyKgtlPYUFvawVO77VGZHPyAp0mIzBAb3tw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qN8inzrBWIF9a46KqhhAtOan3ZjfnuH5m9/1rdblSjzFkv7fkbYpRtcOnMnemUzq4xFcgSNwFx4cSYOtpc0cH+R0zhrFE5afc+9CGCc4UFT2paKiP+Np8j46HgEHHlz25DWZDcCv7vpQsHAsusxVKHbI/dc2nZsW5/MbllenFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/atfnRT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/atfnRT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf1dece2ecso15411325ad.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305599; x=1781910399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzf6kQdtL42DvWCKAV6DWM3aXCjqzDNCsirfABQj8mg=;
        b=A/atfnRT3DoPDBN+s2sjjff32+TUFJViK43cZNbDbUNb7+LrGVxewzEOiyy0vhANG3
         RxQeicXz4tXQAkidCNPQOti5kM/OpvUoQSn/7VMBLJV/+/CElC7jtcpo0J4hdFUC8G6E
         s4c2wBdv8ZL5oGGLjdae1vdPG9TzpGvjjJvKd2jvmu8gUgi6t/MBokTGU5ddD1xTeiNW
         wuJkiE/PhumxNRhgkRZtOyUcLuZkh+m95o4lJVqB+ecI1Tcp75/iGEbV1gdYR00YLucR
         v9O8mpdyrzJ09iE7Wak3NUGAERP0wQiYulrtXbk8a73ICY2I39Q8WKTpt1rDz2/if5cY
         Z6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305599; x=1781910399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xzf6kQdtL42DvWCKAV6DWM3aXCjqzDNCsirfABQj8mg=;
        b=ZszUclr55i+smpq4GrHGmTNl+YNPXtAdXqkoCRj5eewmmP8qYANKWVqftxFlUAaNNM
         ni9UnBypjZEDNpfuUNYf1v/Lho6MlgSpe6g7lrEldiTb+eAWJxpZNhn1L6HM4ts6N3Zb
         2KYvNxtKN/42qLabf4fxfS2Pn1ot5u/Mepzch4KQ4KzjHe9cloDesAfo52AZm6S9gFKQ
         CYkLbc0CqEheaXSKAcLSxnzErZPoJ+CqIxehcx9xcwrAWXx9gRNG/vcFyEO/Y8Dzjzf9
         kTNW72UoMl2TnT+sLdiXVWl79K/0iGmIpvH9HY9qeCoLfUAVxg7MXjvJJYmMrSiW9PYh
         6RpQ==
X-Gm-Message-State: AOJu0Yw5y+3J2SWKG17CCEXrDb9Io+1CYXT8UH6i5YRZAPPIuTDKuRPE
	cZtB0PvnsBwU1EmMOgC+KHIWM3QIHftCUqIooEbehIkzhnONtESiX3br405RysubsVUrneJh/v4
	g2ZyYhg==
X-Received: from plbku11.prod.google.com ([2002:a17:903:288b:b0:2b2:51df:a515])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccd0:b0:2c2:50c7:58a0
 with SMTP id d9443c01a7336-2c6642743ddmr15600155ad.23.1781305598994; Fri, 12
 Jun 2026 16:06:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:06:21 -0700
In-Reply-To: <20260612230622.687665-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230622.687665-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230622.687665-8-seanjc@google.com>
Subject: [PATCH v2 7/8] KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Assert that either vcpu->mutex is held or the VM is otherwise unreachable
when using the normal vCPU => HyperV accessor to help detect improper
cross-task usage of the HyperV structure.  When accessing the structure
without holding the vCPU's mutex, e.g. to send interrupts or to queue TLB
flushes, KVM needs to use the more paranoid to_hv_vcpu_safe() to guarantee
that it can't see a half-baked structure.

To avoid false positives, open code accesses to vcpu->arch.hyperv in the
Synthetic Timer callbacks (can be reached if and only if HyperV state is
fully initialized).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 6 ++----
 arch/x86/kvm/hyperv.h | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 107eb7df20f1..7efe2907148f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -599,8 +599,7 @@ static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
 {
 	struct kvm_vcpu *vcpu = hv_stimer_to_vcpu(stimer);
 
-	set_bit(stimer->index,
-		to_hv_vcpu(vcpu)->stimer_pending_bitmap);
+	set_bit(stimer->index, vcpu->arch.hyperv->stimer_pending_bitmap);
 	kvm_make_request(KVM_REQ_HV_STIMER, vcpu);
 	if (vcpu_kick)
 		kvm_vcpu_kick(vcpu);
@@ -614,8 +613,7 @@ static void stimer_cleanup(struct kvm_vcpu_hv_stimer *stimer)
 				    stimer->index);
 
 	hrtimer_cancel(&stimer->timer);
-	clear_bit(stimer->index,
-		  to_hv_vcpu(vcpu)->stimer_pending_bitmap);
+	clear_bit(stimer->index, vcpu->arch.hyperv->stimer_pending_bitmap);
 	stimer->msg_pending = false;
 	stimer->exp_time = 0;
 }
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 821b586ed746..f78ab3c8d11a 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -75,6 +75,8 @@ static inline struct kvm_vcpu_hv *to_hv_vcpu_safe(struct kvm_vcpu *vcpu)
 
 static inline struct kvm_vcpu_hv *to_hv_vcpu(struct kvm_vcpu *vcpu)
 {
+	kvm_lockdep_assert_vcpu_is_locked_or_unreachable(vcpu);
+
 	return vcpu->arch.hyperv;
 }
 
-- 
2.54.0.1136.gdb2ca164c4-goog

