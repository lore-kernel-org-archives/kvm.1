Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141369;
	b=e1WP2wPk4zsJFnI20+LCeCQGWfhNwBrra2tLYkGZAZm0r4LFRJrDB3TPr8tQ8O4As6l/
	 makThEC00oks/cA8dck4NYYymWUBAibHjcmBs40d+5aIKfx3OVQ931B6G4qkqdFLT+6tJ
	 afVRZwDwTvjj/8UvqTK3btSH51KGUhUq9h7bQBwY11oJfsAB4Ti7NPH20aKoDDF7cFovz
	 t1PkslalytvlGc5ujlkyMRmxWYVMGJpMEGiefg5wzTly1c7vwKPcDUvLSACNzUScixN5m
	 3JqXHctTSXZTNC97im3q8oh+eRaRq/EsdumLhGg18L7cJNyxO1ZfwbFF3y0uwPbE2KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LAo1rJJbq0hs0qGWFuGYD0y3GxHx8EGe6MZyojkL/24=;
	b=AAT+5beb0Am9gsAt6Y4sTpfgNbjYcOGCA9mUrLMH0XujFlOiI7+Gb/+km72IUhFUsZ5c
	 6rOoX/2pGQdgAsuWwRcx3mhfmysjujVNEoTSmMT4Nsicqgcwxyefxpvrw0mwurIpozpV0
	 8glxIEos3mhF6rjRjEjsgvhyTaUwtL5evYJOo6AubkD0OqVCE+fX9hrv+oRR2wgc5lbA/
	 t6QFFJdVM++jjET2/0zptxjKYF+oTunfTAeBf4fc3TJe/RSMKZJXlZYOvkcYdNiF5ra5R
	 yeSt6Wq5SYu2r2ptdetMaHnFyoxRtL9npEwngreJuyrRdAa6SJn+wcsZKHeGJB5qImw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ibTFb/Sl";
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F081D60A261F
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F081D60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ibTFb/Sl
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ea71803effso2991645ad.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793141363; x=1793746163; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LAo1rJJbq0hs0qGWFuGYD0y3GxHx8EGe6MZyojkL/24=;
        b=ibTFb/SleyCWc3RA1NPUAre+RhGCwzOqefQeF6FekTrfGEzftxoa1HxKCoXlj+lqSe
         WgkkKuSGY+DMSWGpHBwQ7jbcmYeRqnpFw8P/GjhC1zhQNSPOUOO8x8dVrhojvPNTleLD
         18j1UL2MBLRhHQuOZc+ZiMjlJv5YZEJU63GKHRFKuPpdRAdT5oVQ826LDob1tIv52E5o
         xEAqHU/3PVm4vAnn4HxBCukHotVXVZrBMxJIQTDe2Y9f3l3bTMJnty4Bh8RV16I+oJyW
         vEbPFuE9rpe5wyuere93Zs9xRWvRF+8hlvyDQpnZwLNoCqEs3c0ZZ9JNuQvoLmVm+i+t
         JKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141363; x=1793746163;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LAo1rJJbq0hs0qGWFuGYD0y3GxHx8EGe6MZyojkL/24=;
        b=cZNzqOAlqa58fQFdtIxC6gxjJNNjLWxjk4ZSUoJ21YLzjTx+ed4wp8pysvFLI6Skad
         TDs8Zdd/+x2lKEaR4xiDniRG59WdtBS+0JK+xSwm4U5rbdKCe2Vq4T0xTEBsULbLWx3d
         rGBAAtoyynn5Lu3MuKxvqVgQ3sFEV9IuMS+NdkeNn8SA3caz4Y/GbjYeNx/zjZc6F08W
         YD/JpEi+ysQQucrKnYc/Aa/3WOyeL96qyOwceJ7ESK6r9nfzuM7Gx7RUhSj8teJjvel0
         DKgIvQQIRl3C5ll2/m26rB6lmE+Jzkp900HS/YSdMBaY/s3v18mM2OSXHa6Apkr0Eab7
         ypkg==
X-Gm-Message-State: AFq9FYJktojXEC6wdGMnGtlrC3upb78l/FEpSMGucwE8F3kjs39Je8eH
	DPzi6ypGS79Rwr9oUiXqbDjPfyyvHzYdh2zE7hWwetDbDlW/q4GFEg59PLx19kJ+nWsiTcXq1Y/
	CdIVejA==
X-Received: from pjzd3.prod.google.com ([2002:a17:90a:e283:b0:3ad:ce3e:c303])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510f:b0:3ac:7378:be04
 with SMTP id 98e67ed59e1d1-3ae57ba6c8emr378928a91.0.1793141363121; Tue, 27
 Oct 2026 15:49:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:49:11 -0700
In-Reply-To: <20261027224914.1574319-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027224914.1574319-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027224914.1574319-4-seanjc@google.com>
Subject: [PATCH v2 3/6] KVM: nSVM: Synthesize #GP instead of SHUTDOWN if L2
 attempts to clear EFER.SVME
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
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
2.56.0.307.g5fe7bd680c-goog

