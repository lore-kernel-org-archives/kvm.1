Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A345BD6B
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079812; cv=none; b=BYr34/+Hz7HxAHOlUMloJ2HiVO9kTw3JL3tLjIm8ySv1LdtqJrBwvxXwzxHDb3dr4RHALZte4bZOi31g9t+cggDW3QDulMVW7wkwa/EluXd4XyTtNzyYY+qUxJqngp3oKb3Sw6kwpKdZTf0eTVQJzZdKqmT5Esc6n4htZUIrrkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079812; c=relaxed/simple;
	bh=GPVgJwMV79jQCtFTmJHYFUk8lo/Ze/eyh7yu+TUXh1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPhnCyZx0SzimvIRIoVkrEduDqyEXRHoBeNBdd6HzC0uPi+Tm/92rLhJZAdQT5c9U1deZkchXWGDTyBO0HcMRUYqLNuaX1HVQz+t6lgXyXa9Ir938YczvKK+s95K5jcrcnZfXLfLiKZ5sQOobEizVlSmHQrOOjCn+L2eMSXN3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qx/E7gKJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmrJ1qRt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qx/E7gKJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmrJ1qRt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+Twr8CVFouDlcQRM41p6WqaCoEvHfdFFepauY7rVzw=;
	b=Qx/E7gKJoJbPC49ive18gqRQ+4h+4l6bhtZQeeyqeQvqRUH4S71N8Ofkb3K6huOSbCu9G6
	SiTnaHd3Zmt4pfo+4DSR0iNvqUoDSaQcupypG4QR//HqM8zhveRG8s34k1B2TgMfdnRUkM
	+iBAyYXJWyavbkSXDYKd1rH6fP7obgw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-W7FUw9-lOPaw4cpWmdOEQw-1; Fri, 29 May 2026 14:36:46 -0400
X-MC-Unique: W7FUw9-lOPaw4cpWmdOEQw-1
X-Mimecast-MFC-AGG-ID: W7FUw9-lOPaw4cpWmdOEQw_1780079805
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4903dcb32f8so71074115e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079805; x=1780684605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+Twr8CVFouDlcQRM41p6WqaCoEvHfdFFepauY7rVzw=;
        b=XmrJ1qRtclkBVtUdd0hjMUclYTFZQaohG39KCMCjZcdialsGQJaCtFt+SkKLCPhu95
         vovHwXH+Oj1opglbZ7TS2lL1prDoKrtbPzfUQGiNIYPrNbzW4ouxS4KS9ZNtE4BEjq4/
         1I+DE+ZI4wy56kq7wEoxzFns8cdMM3xcScOuX1qvGvgrHUBxcqJ4om3TZNvf++HrbYzy
         cBiCIbOIhTHbAdE0/laFzgrUh9wExDe62nOCLaOXWS8asJ070CyX45/JzD3QU1C0bnpb
         wOVDbA4MU1ZsB4bsSuFzqX3S6zdm6A0MtWzM5VixYUvk25f0B/+1a+ZJe68jVil19gBN
         rnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079805; x=1780684605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f+Twr8CVFouDlcQRM41p6WqaCoEvHfdFFepauY7rVzw=;
        b=YfHQqGb2eJnf2/hwKApRuG4NjUgwpjFgrD23FZ2x4+4+FqLxJLNllVRj6bTXBOne2f
         3IvvD87AqazS6UcMDLXaeEWBSflNC8UhbL7G9Nz7XRy19Fx6sOAR2aKy3QoAwR+3X4e2
         ULsFap923qtbjl7uTyI3IhG69gyk77KjNjGybvg4Mkhvd1rBBF+TQzbKTVgRpXmZsM/K
         0myadi+HVTGHO+z0jd/w0X1cm7hNqq4doYgzqBi72i1Goul058v5+k9D0wqoz6k8vPmD
         5XsXTDIFVloCrE+6yDqfr9t6t9WgKN4g4d8fd1fRoOfIkEp7+IFKF/7kv54MlZwOOtnb
         lQUg==
X-Forwarded-Encrypted: i=1; AFNElJ+YY72p93UAdjIdtmFYCW4eOd0BnGvk26cctE2p9wGHRKz9LLCYVasyxvR9skd8j+AsdDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9Qs/pZ3ftaWLFHFkDmSvAWSKqBH4E2XVj7EINwYdoIn2V76Y
	etK1iw4PjMHMfEiFIZl5eepYlMnvqWk8TGW6nY7gxB7LMmAwrzMMMv5eSg0XjGP7CLXAllTLHMn
	ElbwnlgYfaTukMCpUiYLYWBwuAaAMGnH1pNWePUll4C1gbt7I8f81sg==
X-Gm-Gg: Acq92OHVatnSsSoC/+YbQcj3S5x2aTdHsaJDSj+ReRBnkQKYEJy4woRIs9quW3t/GVY
	y8P08dAmeQs2241WJ6EOjIyrjkLh9KguyG5IsdeVGZDIQOVF2KeC4ZV4UkRvpy46Fpv06ieF0tO
	1b3v7/ps9fWbqtOBjKE31E1gcocWUuYdDbkI38EMZBITMLyUF2edRiPqjmnYoLm6qLQdONJBJ/y
	FnPPayd/PhvqOoZVPCXWbgahgcy38haouDTmZr1iHVPzbSeRkf39D+Yfb2m+O64i667dwRhz/ti
	YC4kDZ0ENkykOKybLCYEjd2XJz5VT5BKcQ+lFdx38URPDBAMD2ThTKQ5Xz8hY+BruF85PSLTA3y
	ZEX9W1XpYEJCZbZbXOyV7rTagdxJnGAxXWBVwj53+TbifsZ8K907G4JURB7plV6NSpbBCdf4tfO
	Dq06Ut3VKY+05Q7XFsIZVPBO4UZET7If9veCz/tg==
X-Received: by 2002:a05:600c:400f:b0:48a:5821:5ff2 with SMTP id 5b1f17b1804b1-490a2919a2emr9350315e9.8.1780079805155;
        Fri, 29 May 2026 11:36:45 -0700 (PDT)
X-Received: by 2002:a05:600c:400f:b0:48a:5821:5ff2 with SMTP id 5b1f17b1804b1-490a2919a2emr9349965e9.8.1780079804757;
        Fri, 29 May 2026 11:36:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c121d63sm19041295e9.29.2026.05.29.11.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH 19/24] KVM: SEV: Move GHCB "usage" check out of sev_es_validate_vmgexit()
Date: Fri, 29 May 2026 20:35:44 +0200
Message-ID: <20260529183549.1104619-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529183549.1104619-1-pbonzini@redhat.com>
References: <20260529183549.1104619-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Move the check to verify the guest's requested GHCB out of
sev_es_validate_vmgexit() as the first step towards making said helper a
predicate whose sole purpose is to verify the guest has marked required
GHCB fields as valid.

Using a single "validate" helper sounds good on paper, but in practice it's
difficult to verify that KVM is performing the necessary sanity checks (the
usage of state is far removed from the relevant checks), makes it difficult
to understand that "legacy" exits are simply routed to KVM's existing exit
handlers, and most importantly, has directly contributed to a number of
bugs as adding case-statements to the validation subtly removes them from
the default path that rejects unknown exit codes with INVALID_EVENT.

Deliberately extract the usage code check first so as to preserve the order
of KVM's checks, even though future code extraction will technically fix
bugs.

No functional change intended.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-20-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7c2ebc81306f..880a2acd77bf 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3416,12 +3416,6 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	u64 reason;
 
-	/* Only GHCB Usage code 0 is supported */
-	if (svm->sev_es.ghcb->ghcb_usage) {
-		reason = GHCB_ERR_INVALID_USAGE;
-		goto vmgexit_err;
-	}
-
 	reason = GHCB_ERR_MISSING_INPUT;
 
 	if (!kvm_ghcb_sw_exit_code_is_valid(svm) ||
@@ -3534,10 +3528,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	 * Print the exit code even though it may not be marked valid as it
 	 * could help with debugging.
 	 */
-	if (reason == GHCB_ERR_INVALID_USAGE) {
-		vcpu_unimpl(vcpu, "vmgexit: ghcb usage %#x is not valid\n",
-			    svm->sev_es.ghcb->ghcb_usage);
-	} else if (reason == GHCB_ERR_INVALID_EVENT) {
+	if (reason == GHCB_ERR_INVALID_EVENT) {
 		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx is not valid\n",
 			    control->exit_code);
 	} else {
@@ -4528,6 +4519,14 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
+	/* Only GHCB Usage code 0 is supported */
+	if (svm->sev_es.ghcb->ghcb_usage) {
+		vcpu_unimpl(vcpu, "vmgexit: ghcb usage %#x is not valid\n",
+			    svm->sev_es.ghcb->ghcb_usage);
+		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_USAGE);
+		return 1;
+	}
+
 	ret = sev_es_validate_vmgexit(svm);
 	if (ret)
 		return ret;
-- 
2.54.0

