Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A863314C4
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886773; cv=none; b=SJphs1qeXmxcBgru6VNbIbZWfbDtCSHIjgVG+v+42c7dBKucWNncfz3Qr8aDi3IZ1sWAoJEwasSYQwR0p3gVdqBtxMZJvhtoVMrl4e+QcljGzu+1iy6PXEGOh9AP8AWD7r49CPhYdISMUQPepZEoDwuIx1PPl0KsWaFT5tMUfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886773; c=relaxed/simple;
	bh=89JyQv6HRefQDN/D0POA6sjh7E80QJy4cC+vhHi2sXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CJ1JjL9S90EZoE+B5Wp9yHIT7C+1McSnnvyKHFaFRZ91286+oJAsbAAikPb1e+WBdCEl1aqKuL654vIWz+4wjQph/C+fKHjWyQyb7CZgotwbbvn9Q+gcqdTpiiza/ksSvrKl2lzpK8adRHa1mhrbzVd5hqfqHGyTGG9PJDMTFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DsWn6fvE; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsWn6fvE"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso4549155ad.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886771; x=1786491571; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P02jVjanYDtcmjUaf5UDPPw7sZUuSi7rTQrdCOouJNQ=;
        b=DsWn6fvEOLugLNFJ/QFY7ibwTuCh7B2O+6f8lewSSqRCfGfcpOyuHuwY6sNSb22RY6
         0l+81eb16HQ6VzSTDox2sntKxRX91s37ZXB1l94D7Ux8yS5CIibxekNbTimG2h2d3YxJ
         I4MpkBeinkkHy2yI55hU1qYOj67aMC5NZE6zwrA3HPx4WU70D+qqmFgi87p5ZlCnuh1X
         XWhzLsV7qa6nLHY+8fjrt0dj8qKiLHmOTQ1yzK04BEAHrtlAZXJlOPZOufjtjUbj1+bC
         PLO9H1xh+HaeigFzF/ZBy7PyiqHCs+DmR21Ir7fPQ8/ZQntHGmrJQW/qOwchQVSMAcVQ
         RC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886771; x=1786491571;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P02jVjanYDtcmjUaf5UDPPw7sZUuSi7rTQrdCOouJNQ=;
        b=FL9fPoaVv6NqDSAFiKMULNye+8/hwdOrgSJsvz+M4yo4bGQJiQ3p6QFIik0lBdx8Cp
         cJSs1DG6fhJ7Oj3y8oqsDHSFqEnyO8ePPkbdkSH/VAWnpgl+0Qmu3NyaFGLS1oeWaHm9
         OM6ADgzDA3Rnw8oPgpF9+41wtYgVM5FnHEtdJVBQ46OMyL4A4FllxZx6DVY11ZZc7htc
         g3s9MMkN0X52zLWL+io1aNN7av9cm/ywSEJR5EQzuQZ1fgeOgpYVoCN0ds747b1P3d5E
         FoYPDMIs7NxwxWogv+vRBPR6ZojrW3YZ1aLqLB+6zevkB9zsZeUVAPkH/adLJVonCZj7
         ytlg==
X-Gm-Message-State: AOJu0Yyn4ib70absXnx7i1RBuacrrCZ+dWFD+ZVNP7M2PX1US4nGwKeq
	1SCd1EwldJOqOUpJdVww7yOGxcIYvZMFfdMOe2MbwJ5sEJV+v2tk0ZhwOa4RK+mGFajWYS3AgKj
	7j8j/og==
X-Received: from plry15.prod.google.com ([2002:a17:902:b48f:b0:2d0:8b2b:b8a8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:184c:b0:2c6:a772:7e43
 with SMTP id d9443c01a7336-2d0caa040e3mr28687395ad.18.1785886770845; Tue, 04
 Aug 2026 16:39:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:08 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-5-seanjc@google.com>
Subject: [PATCH v8 04/17] KVM: x86: Activate master clock immediately on vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

Previously, the master clock was only activated when the first vCPU
processed KVM_REQ_MASTERCLOCK_UPDATE during KVM_RUN. This meant that
KVM_GET_CLOCK could not return the host_tsc field until after the
first KVM_RUN, making it impossible for userspace to follow the
documented TSC migration procedure without a dummy vCPU run.

Fix this by calling kvm_update_masterclock() directly from
kvm_arch_vcpu_postcreate(), after kvm_synchronize_tsc() has already
set all_vcpus_matched_freq. This ensures the master clock is active
immediately, and KVM_GET_CLOCK returns a valid {host_tsc, realtime}
pair as soon as a vCPU exists.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ce6d155b2ee6..3ebcf2f27f7d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9447,6 +9447,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 		return;
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL);
+	if (!vcpu->kvm->arch.use_master_clock)
+		kvm_update_masterclock(vcpu->kvm);
 	vcpu_put(vcpu);
 
 	/* poll control enabled by default */
-- 
2.55.0.571.g244d577d93-goog

