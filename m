Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635505;
	b=l31AObspvL/M2HGh4zr9td1FrVkUGDbLg9Fj/+qy5D1hCGYYekbhYYXZn1+yhmflWzS1
	 ZCFZZ0CdgFDBbzRPJLEb6i2ZUITATeSV48j7nE82mzKyNzLKZl24yZihikKFDfVY9DKcC
	 V0HEST+VDYl7tIvGpL/tSyBsTFOD4BzhTqHzGhsUkGEZ6folPeC6Niq6FkyfYubnha9NT
	 XIIOvh8LtdY3hybUIZk9xSlTXGVAbxoquw9evYy3ZGyL3YnW7fyukSVGnEJ2NwxiTpruP
	 5Z9WEaO8R7Lt7kM3a8MJ+cfzZU8J7BjIPzpbt/yUSpBxFkoAH+VT7NdF9xWeKAg/AJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=zKOY3KM6W7cTDdHPqzyzy77JGlYO/MSVD6fvE2c4CzM=;
	b=j9z+ANAx2G1SDb5bdkbhZNvB81Tw3+ZiBkRzkETCTw9qtoXNTVr9gAxFgkiu+VpZoJfF
	 YWx9sIf/t5Xpvnq5lyKS3oFodf3v3pn9IXmNnfv1oVT2ooUN7N8DNf4lFM0wOilyFEFq6
	 jilci+NJ2nzI6F5WXxGTX0xeGesNoxR0F/FyrysexMG8DV5i++2lHwvAOpYzwT+W/97cp
	 Z9Tem50yATFqZAEK62J99vYGgkUv8dU0GipvxpSrLx4sRQJm5PQFjF1vGpBhww0yPA0AR
	 TmRUy02W8l7NbJSIErDL530AbcDkh5+urb2co+aj0Tayddm1NF75tp0g/ja9Zfbg3Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QKVmesTO;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3C606A32A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDE3C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QKVmesTO
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad3fc547bfso1234985a91.2
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792635504; x=1793240304; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zKOY3KM6W7cTDdHPqzyzy77JGlYO/MSVD6fvE2c4CzM=;
        b=QKVmesTO/tg+usxx4kVKRSyM9RPnxeQCvRRGHurKCKkI7MOiaYNY2akdqtUblKap5y
         SmpQeXyiVhNzj/k8yGtId1byXHKARKfTwvof74QU13Ng/Q60bL1qWOIxHwMhzlnQbQNZ
         pjfi/S42kyluBGL5+Nv6Pxw9fr8TUnh+FEgdnSL9MU/1U3XiqvM3zAu0jyIyHUYe+NUY
         ZKjHAixOJ8p4AUTQvwbEqkCOM2TE5dFUDMfCfEOArWCn6U907wADJmsVpIo5yJP0eToU
         J8el525NCZP3nA0PdQhJZPwmaa2UyEWDnuqZFlM47Tx8yASLsG0QBbqXt67uiQMGSOxC
         mdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635504; x=1793240304;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zKOY3KM6W7cTDdHPqzyzy77JGlYO/MSVD6fvE2c4CzM=;
        b=dXsXd681t/sDaaJtWbDIrrb8gQQn4v7jsf7DDeaksRutduzcoaib4bzBZr+V4eJP+H
         GgnXufGTeC4KXYW/zsXrs20TlV2tyRDrS1kr4ObZpOaYjNC6gxyB+l7PEGX9vu/Q14+l
         SRwS3ItIIk4OUHFep2dx5016junjL+nVfeSrIAbz3hOYo6nYNegmOiXZYe4QX1Yt58LS
         xmnxmaUjIVem9qgimiwCwfLL2md7NVkzheq23++Krvp+KfM4CNQqdC6AzDVscno58NJK
         TpFVZG/IqQNGhQDhWJl7Jiuqc1u2x6pDk31D4sltYrLD1DpAYkROIrhTLv3UUseb98KA
         CL9w==
X-Gm-Message-State: AFq9FYLZdl6pxXLwJeXxVpOKNx3YNWYgyLTYHtKosUDa0cFH0NC9OfEk
	jrBQPgnPAN+rjAQR2xVNM4W5AdvBre/HjikDD4mIfwz4lWtDhT1CdrER8LKazY3cl2LD5utssSO
	fLXqxTQ==
X-Received: from pjsa18.prod.google.com ([2002:a17:90a:be12:b0:3ad:4377:79ba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224e:b0:3ad:6781:da6b
 with SMTP id 98e67ed59e1d1-3ad86cd6d65mr3204983a91.62.1792635503892; Wed, 21
 Oct 2026 19:18:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 21 Oct 2026 19:18:19 -0700
In-Reply-To: <20261022021820.298886-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022021820.298886-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022021820.298886-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: nVMX: Save shadow VMCS when getting nested state iff
 L2 is active
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When getting nested state, copy the shadow VMCS to the userspace buffer if
and only if the vCPU is in L2, as that is the only scenario where the
shadow VMCS is "active" and thus needs to be explicitly save/restored via
KVM_GET_NESTED_STATE.  If the vCPU is in L1, then the shadow VMCS isn't
active/cached by KVM, i.e. is just a pointer to memory, and doesn't need
to be saved/restored (userspace is responsible for saving/restore guest
memory as needed).

This fixes a bug where KVM would save the shadow VMCS, but not account the
size of the shadow VMCS, as the accounting correctly checks for L2 being
active.  Note, the restore path also consumes the shadow VMCS payload if
and only if L2 is active.

In practice, writing more bytes than are reported is likely benign, as KVM
correctly reports the maximum size for KVM_CAP_NESTED_STATE, and no known
VMM invokes KVM_GET_NESTED_STATE twice on every save to precisely allocate
its buffer, e.g. QEMU and Google's VMM both allocate the maximum size when
the vCPU is first created/allocated.

Fixes: fa58a9fa7497 ("KVM: nVMX: include shadow vmcs12 in nested state")
Reported-by: Josef Bacik <josef@toxicpanda.com>
Cc: Chris Mason <mason@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..c2586bc9ebb5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6875,7 +6875,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 	if (copy_to_user(user_vmx_nested_state->vmcs12, vmcs12, VMCS12_SIZE))
 		return -EFAULT;
 
-	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
+	if (is_guest_mode(vcpu) && nested_cpu_has_shadow_vmcs(vmcs12) &&
 	    vmcs12->vmcs_link_pointer != INVALID_GPA) {
 		if (copy_to_user(user_vmx_nested_state->shadow_vmcs12,
 				 get_shadow_vmcs12(vcpu), VMCS12_SIZE))
-- 
2.56.0.218.g1ec904b173-goog

