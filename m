Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395648;
	b=Vr+usxHToh28APvwFD4fL8Sqg6o5yIhnSheFomwwRDzGxmAf0T/VNdVDQSAnBPznZSX9
	 ERIADJyj1D1n/xRn6cCggwcpYUaJ7SbmKG0ni+EbSIsojBaR26BpvdKTFjQAjs8fMtB0S
	 8dwaZOlF8qo7lz9r0kkqNca+k4KXzEGHFEQP3+UDusSlvRt50/jd/UyatXbe43TR65dcq
	 wNz6tQ73Xmbnmw7eNcArmYUrW1wYgPctzROcwOMsklw+wEs8HLGC0opm5EQeB3czzqFbu
	 dzarejFjvWntrMBtSnoPo4m37Qzkahy+0Y/Mw/VAKblK9e2QwF1styjK7W+dV8F+6QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=WCuJ30mnsJiahpujsd+/JbSot3kCKCozDFDV0GhWtL0=;
	b=a40B7TxWVyyneMx36+egGCZpyhlriTa5TPE+gPJeAwPmte8R4Ada2BEUcMy/NdQmfIxw
	 IFSxHHauSBEXFonfNUF6hDJoly6UAilwHqXAzqlmt01e658R6Stb8Kx0V7SErH/lbJshD
	 jXa/gzMxZi/D0Z8SOyEmTiOol9UCcTfAUMZ+7yeAYArDg1ph82nEef9EL9Qrb4k34aQnq
	 w5NljPHKLAD/W8KVEgoS73sgRN79wQTsD2fg9X7lY78Y8DbBKh6P+UCQC/t7Vr+w/Hk98
	 7i0yA7HneEcLs90ksaqtOeIqGKXdtGAZL8hDASTVuLuU7ne/EdDX6S9UgGjkKr15dkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IDfv9IpY;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7460A2633
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC7460A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IDfv9IpY
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3aaf955db5fso1432229a91.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395648; x=1794000448; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WCuJ30mnsJiahpujsd+/JbSot3kCKCozDFDV0GhWtL0=;
        b=IDfv9IpYXaq0P84LPcp0VYrWfxYtIBnj6RRvmBV/JtN3N23tXTXrJyXnSQLid3z2rM
         EBAjYyC7PYs3kdJY0d02lurUaoegBB2HeNhLk+3VDb6z//yt1ehDpwNJklFcocGzVjw1
         sIBTKAp5ARrf2Anrg8VyeWeGgw85MYHewaWyHnzXFCyNdyQNmtGkdrwEhUZJdQiIRgob
         0QmfUEEmoEhfX2aOEbuENjGsARwZIHS8l8E3b/4+BWhLbUBGloX31x3VG9aJ0F4gD2x5
         mgLmYLltWYS8+AW/R5cFH2S43jPTJ52NyAFDNU+3lo/WlxYuUezDQk1Rgj6bae/gMpAH
         dOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395648; x=1794000448;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WCuJ30mnsJiahpujsd+/JbSot3kCKCozDFDV0GhWtL0=;
        b=TWf95vDTYYU/P7Y1d6LKqZZ45VUCEB1Ke6iC23ZCM0/if5N2ECnrVqop//a3tVQ31r
         q3Xp0Z89lZJMlQMXhPpqnyR4b+4mKGFEF1Ww6yUuPN5j3AbgqQQG5Hm0cOczipbduwk1
         i/MJ8U9i2ZfagiMUSx5uiN+/lxLTWarh/sDnLF2IwpWSi2hwWAgmFyJGND7/KRwF96Cf
         MncLOpfLE7N44h6ryoimXmM47bRy3sZquPCe/9dj+1Tbgt4Ehx2tJnsdp1zILbRXQ1xq
         7iI6aQY2XQ3+rxzpjm8YVhJ1mRrhRdeo71TCWQ7zypYPg/zOWmlJ1WRRtqQqvYUnxRI/
         3u7Q==
X-Gm-Message-State: AFq9FYJ/Z7z2g6sPMpgcc2vmUnmhQRa8e7HkW2NgcSrJhc7YrohZHFma
	BR6RpE7LPbkOCjpXMB2SbEYxudhJj3LDxNxZit5vNN4jMraLvFomDWs2wUczyccV0Ls5Qoktpvj
	8WizERQ==
X-Received: from pjqc8.prod.google.com ([2002:a17:90a:a608:b0:3ae:5572:c4d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33c1:b0:3a8:59d3:5317
 with SMTP id 98e67ed59e1d1-3ae89751035mr3002809a91.32.1793395647611; Fri, 30
 Oct 2026 14:27:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:27:18 -0700
In-Reply-To: <20261030212721.2606393-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212721.2606393-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212721.2606393-5-seanjc@google.com>
Subject: [PATCH v3 4/7] KVM: nSVM: Synthesize #GP instead of SHUTDOWN if L2
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
2.56.0.385.gac671c819a-goog

