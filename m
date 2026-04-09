Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52993A6B77
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778995; cv=none; b=WxA/TbAfGui95qIAPSfJw+3vvCAHytOdeMvC2U5qkGQxZe8CTG4bhY6Wid8pbtlJ2SejFt/axS+YplA6045/f0Ip1ywiaBzwpshUQQSVMHIb/kF3I5CM8/VhXiIkx7zVdU1rjavjUT79Wpe95nJA4GtERltEHOB0/oBixwAXikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778995; c=relaxed/simple;
	bh=8luSUTiSxiEmwv2/oJj3HyqMubdjdwcxJD07lIZ3FUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XiCmdA+OMgrsKHnEsEiJIreszen1nJ5FAAoF75XFxAnIztbwm0AY6jfAHEFjGlCuVo6RRG5Qgl2+f0N1elcgjV/UiiaaPIeQmJy3DInZa0HXpW32ENI0sZupIOw2jh/Mx/b3KxIopirdTF7AFOTohfrDdnp1zJoowufLZqk4zhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKquPUSs; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKquPUSs"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a6906e35fso1142815b3a.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 16:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775778994; x=1776383794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+obVz777OwFP+JzReVag0dKSAF2HbbEGxk5Pup5au8=;
        b=fKquPUSsfAuzo55WAgUNQK3/xZxxv2mp/AoZlerz1BI75VP6ermF3vqa7O8kfy1s8W
         PKtdhQHpa7My8FiANHqE3/bqiKmdPZSXCAHR484+TCRyOipFBOYjFUTQ78FXtLE939ba
         uW7iKahxkh021L3wKpIeLzQcmZdbJsy4dpRoIKxM9Gdn+9mIUhOeJJCo7/qPKa6vlg0f
         EZMoZFdWhymK7ZNN7v/IdQq4csnS5c1PR9kbQ+3kE3sCQYTwqMVwvMeWZOKgleTgjeNn
         bxK9ra6b+eE0xldsyYeC1I5ViG0RZqKboNMmk3maZHbMF47647I7V3eX2PZHeMED1Luw
         NCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775778994; x=1776383794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+obVz777OwFP+JzReVag0dKSAF2HbbEGxk5Pup5au8=;
        b=AfigWUpHX9haKpJj3xiZyLg/J/uKaAXfHWr28E7FmGNicakvffa30pKJUJify29Wdf
         gwv+Cr09YrsdFV/UwHqj8aCWi+/GG5EgnOCfMKjCnYfPA8xBQ+vKSLVI7OfcOaKeBaBq
         GbCUTH25jqBLsmNathNL8o1yMpHlSsHw40lZ0nufUnZbkw/qUPvsNGfN2eDRp8a5ZYfT
         JYpxSfo88FFpi/S8rY4VKJaQAuq+Z03r0wLMMjj0mGZTEQL3GIpCZj9oC0w/xLbEbhR4
         NPaa/LhTMGb+p7HX1jXcH/L8u4Y8Qfvz79ZKQvKiHAlLGkIZMjkjF4/BE9jbU4/QiXed
         wiCA==
X-Gm-Message-State: AOJu0YznI8/nA0rHyfzjI/x41iuiVgOzcqzGkoi+K5L+JrzDrA97KNkn
	ckCEGCxItNOw4rrKvTs/6aA4UCX3h0UwJvlU3vZ4DcJ2ybX5fotELh+759k1IhKd0z0It009W7/
	jQI3j4A==
X-Received: from pfbhd4.prod.google.com ([2002:a05:6a00:6584:b0:829:93d2:8904])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1306:b0:82a:146d:36a3
 with SMTP id d2e1a72fcca58-82f0d34b279mr656582b3a.21.1775778993594; Thu, 09
 Apr 2026 16:56:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 16:56:14 -0700
In-Reply-To: <20260409235622.2052730-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409235622.2052730-4-seanjc@google.com>
Subject: [PATCH 03/11] KVM: x86/xen: Don't truncate RAX when handling
 hypercall from protected guest
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Don't truncate RAX when handling a Xen hypercall for a guest with protected
state, as KVM's ABI is to assume the guest is in 64-bit for such cases
(the guest leaving garbage in 63:32 after a transition to 32-bit mode is
far less likely than 63:32 being necessary to complete the hypercall).

Fixes: b5aead0064f3 ("KVM: x86: Assume a 64-bit hypercall for guests with protected state")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 6d9be74bb673..895095dc684e 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1678,15 +1678,14 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	bool handled = false;
 	u8 cpl;
 
-	input = (u64)kvm_register_read(vcpu, VCPU_REGS_RAX);
-
 	/* Hyper-V hypercalls get bit 31 set in EAX */
-	if ((input & 0x80000000) &&
+	if ((kvm_rax_read(vcpu) & 0x80000000) &&
 	    kvm_hv_hypercall_enabled(vcpu))
 		return kvm_hv_hypercall(vcpu);
 
 	longmode = is_64_bit_hypercall(vcpu);
 	if (!longmode) {
+		input = (u32)kvm_rax_read(vcpu);
 		params[0] = (u32)kvm_rbx_read(vcpu);
 		params[1] = (u32)kvm_rcx_read(vcpu);
 		params[2] = (u32)kvm_rdx_read(vcpu);
@@ -1696,6 +1695,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	}
 	else {
 #ifdef CONFIG_X86_64
+		input = (u64)kvm_rax_read(vcpu);
 		params[0] = (u64)kvm_rdi_read(vcpu);
 		params[1] = (u64)kvm_rsi_read(vcpu);
 		params[2] = (u64)kvm_rdx_read(vcpu);
-- 
2.53.0.1213.gd9a14994de-goog

