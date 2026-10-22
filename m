Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708262;
	b=G0Y4edGlPuTQGpf6hkk7GcD+sVGVWBSpUnZKDMUHCkIwm47uh+me2djgWiL365JTRO3h
	 SIpWPKTJXGvkj7BKEU709gYPE6sT3BbM2kSCsI1FL0KK1lgkoSE8/SruLDZNmC+sMx/2x
	 AfmFFx8pnvbE9eOV6AYWVyeu8n1yC4L42DFfPRXl2yyLh6b69UVKFge+dl3N6kK+iPjSu
	 mjNNDs6uEjn+w89AuR/br2cIh1jvK54KNWDrduKjwZntFVNCW6r3IiX7+hPAXX6AhK/9Q
	 bkgeISnO3oLZVczV7oinbZGXpbZAAf3GOtEYsEBcOyeJHi3jni+R8xlY+uE8SduH8pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=yp7cvsW9FF4jZB/yRmxi3xtRDI4TkEokIlw+zMvDPUE=;
	b=RaCnFBCwR+FJcq/ZLxz1x9yDNN+H0aDwU6CGSqsVuVsLN4GxP11aG9//fcMCSJeOLCJs
	 VAzP9/Yo8SVN+c4gve5JP/8HJKBmwYWCxthi8hd7osZNesQs/HbWKspbZ5cy9+6EIOsUm
	 1OoyEko+PQoimC2ACDqU3iUKtddBnzXyYxjU4vVQCVGZyxsGPtz2OxZJxTGkT5+C/zAg0
	 7Cwrz0qkVXUOJinlqFBsqB9ikcSFxCrurcuHL5mDlSpCaHzNVpUY95xEEdrqghA5akQJI
	 RK27zyZqN3sqMO/NLhjR61OL3eVi3pGcmhR/DC2d8yEqnDPTEhWP1pAOHpqtT0DcIrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="eOZ/X8eS";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102FA60A261B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 102FA60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eOZ/X8eS
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so390499a91.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792708256; x=1793313056; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yp7cvsW9FF4jZB/yRmxi3xtRDI4TkEokIlw+zMvDPUE=;
        b=eOZ/X8eSEp+IhmAPBIui8CIDly4l/AsaHdCZldR8InHBxNE4Lq85f9kzucvh38q2ms
         o5VneHekNc5zEuUPFEw+Brzz/4LYK1ZBPnEPXvUi7q2ZuMvmbdg14H9dj/yTjNQUpqk6
         y5VWhzvhxfYX8Vp7LE/7v9mh/Ud2BbYuibdo+bWDFMiIl9ixro3jgcDpKjWuT59YFn/H
         XDN2g1Gqtdz7RUYA7ssAEyvbj/rufYU945NKIp00UapkHnbXSmxbJfuuXXIrkS7JthZX
         tcx9E0h7tGuUdG5QSF3bIYPuaXN6xO4YMV4UQOQSTWPOV0aE2ngP7X15ZKU3fDIinI1u
         awzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792708256; x=1793313056;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yp7cvsW9FF4jZB/yRmxi3xtRDI4TkEokIlw+zMvDPUE=;
        b=JDF4Z4LBda8TD6A4cAjUa1G3uTDVyKUy4wZwVp/HDOsPzy36kl/H8/6agYKyUazb6f
         TGSyFcIvZ1jGb2eGr5U5E5Ls2sqR7br5P9pxghheSkGqUMhRWv+POYQPX3uG3/rHPXF1
         0rm32/oaHHfRbF5v1tAJDldPRQNSfr5k1u9kQKvEEuU2vT1ez6XOAEdM2Btt8BOVTm2K
         HJd3Ruwe9Gg4dLCmbP5du7Ua4nnXD6ltzFpITmCbQ61Wa9qQIc4W+J8LuvP3UC/ti8LO
         9DepZxhaZpt+JeTjlAPEZ/MtaCE+Bs1gEOJ9e9fTnw9MbOGMjLPjYLpJ7kGccgZ3EoKo
         K7ew==
X-Gm-Message-State: AFq9FYIXMywRrm37w9p5/qCOQQUjBdBpu1utw6fbHJXBmNHx9Wd5uI/O
	ZY13lCnLrIWO87IEAzJcT9ipz6I3NXMtBAyk1iQg1J8mRoUcqbKbeLInEHomnulK+mWIUrnI6TI
	ZJahIqg==
X-Received: from pjrs10.prod.google.com ([2002:a17:90a:ba0a:b0:3aa:f38e:cb2d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c42:b0:3a6:e99b:bbdb
 with SMTP id 98e67ed59e1d1-3adce833707mr174475a91.50.1792708256256; Thu, 22
 Oct 2026 15:30:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 15:30:50 -0700
In-Reply-To: <20261022223052.646891-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022223052.646891-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022223052.646891-3-seanjc@google.com>
Subject: [PATCH 2/4] KVM: nSVM: Synthesize #GP instead of SHUTDOWN if L2
 attempts to clear EFER.SVME
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If L2 attempts to clear EFER.SVME (because L1 neglected to intercept writes
to EFER), synthesize a #GP instead of a triple-fault SHUTDOWN for L1, as
yanking the vCPU out of L2 and mixing the new (invalid) EFER with L2's
current state is unnecessarily risky for KVM since the TRIPLE_FAULT request
isn't fully handled until KVM attempts to enter the guest, and nothing
prevents userspace from ignoring the SHUTDOWN exit and continue running the
guest.

Apply the restriction to both guest and host (a.k.a. userspace) writes, as
unlike kvm_x86_ops.set_efer() => svm_set_efer(), set_efer() is used *only*
for targeted MSR writes, e.g. not for KVM_SET_SREGS{,2}, and KVM does NOT
advertise EFER as an MSR that needs to be saved (because it's handled via
sregs).  I.e. there is far less chance of breaking userspace that manually
restores EFER with SVME=0 while L2 is active, because in all likelihood no
such VMM exists.

Keep the sanity check in svm_set_efer() that handles the KVM_RUN case, but
escalate it to a KVM_BUG_ON() + -EIO, as it should now be unreachable.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/msrs.c    | 12 ++++++++++++
 arch/x86/kvm/svm/svm.c | 15 +++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 2df42276fd82..c3cb1575fe66 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -626,6 +626,18 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
 	if (is_paging(vcpu) && (vcpu->arch.efer & EFER_LME) != (efer & EFER_LME))
 		return 1;
 
+	/*
+	 * Architecturally (per the APM), clearing EFER.SVME while a guest is
+	 * running yields undefined behavior, i.e. KVM can do literally
+	 * anything.  Synthesize a #GP as that is the safest option for KVM,
+	 * as mixing the current vCPU state (from L2) with L1 and the new EFER
+	 * (if KVM simply forces the vCPU out of L2) may yield an unexpected
+	 * end result.
+	 */
+	if (is_guest_mode(vcpu) &&
+	    (vcpu->arch.efer & EFER_SVME) && !(efer & EFER_SVME))
+		return 1;
+
 	efer &= ~EFER_LMA;
 	efer |= vcpu->arch.efer & EFER_LMA;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 487897ef11dd..a6ff9635677a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -227,17 +227,12 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 	if ((old_efer & EFER_SVME) != (efer & EFER_SVME)) {
 		if (!(efer & EFER_SVME)) {
 			/*
-			 * Architecturally, clearing EFER.SVME while a guest is
-			 * running yields undefined behavior, i.e. KVM can do
-			 * literally anything.  Force the vCPU back into L1 as
-			 * that is the safest option for KVM, but synthesize a
-			 * triple fault (for L1!) so that KVM at least doesn't
-			 * run random L2 code in the context of L1.  Do so if
-			 * and only if the vCPU is actively running, e.g. to
-			 * avoid positives if userspace is stuffing state.
+			 * KVM is supposed to synthesize #GP if L2 attempts to
+			 * clear SVME.
 			 */
-			if (is_guest_mode(vcpu) && vcpu->wants_to_run)
-				kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
+			if (KVM_BUG_ON(is_guest_mode(vcpu) &&
+				       vcpu->wants_to_run, vcpu->kvm))
+				return -EIO;
 
 			svm_leave_nested(vcpu);
 			/* #GP intercept is still needed for vmware backdoor */
-- 
2.56.0.257.gf7497c7d27-goog

