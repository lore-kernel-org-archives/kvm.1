Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD245349A
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079806; cv=none; b=cSlAsgfwq0YjphUISy9JgsIhTK0UEvzHYZ3L1jn/8Z1r70s/fTUb9XuconxN/pKWjoeVSio3clvOtZOdDbzpW5r05v7FRmB91STAgwljR/m9jKd2sxJLB1+B3w3TWWGj3vT+RVyfcuRjXgdk/+Q9AWHUA9En2jJ/jfJhoeG04IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079806; c=relaxed/simple;
	bh=qhNRXPjJiLrNoLYnZFebbOWX1YrMRfkvrSsBcG3U8go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6qHeABxB0tEq2atmak0e99Zpf+9RPJDDh7QaLcONt8wbBotB+onbFDS34H3Szg5qf9JfWJEJrL5xgq9TrV66HQNEZ44M7sNqxYTds07Leom5aulB+V730be6B0nj+sxLE6xFScmKO102WUVnVv3PauzCmLQXT7CSUVIBm/mKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUEE2exu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FXEG7KX/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUEE2exu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXEG7KX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1XJAuHtEwSrf2OyC4wSiD7WDpcF6b/VSFdi0YQ2gfw=;
	b=QUEE2exuqbF/Rb5maPz9hGt6tCUrm4mrqeuC5JsuFCJeCqmmNuTDhqpWxTfu3llAn0aIN4
	t9QJZV1MLhk74vrFfmPRu5Dxn+RR2h6EmxT7QCdPWOiF17HPLsg8KEakdgg/rakpTbn/HI
	ehCV25m4n0uGK9cvkN5AReGrrbuXLtE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-_RbBthGePo-Jueb6mFYFFA-1; Fri, 29 May 2026 14:36:41 -0400
X-MC-Unique: _RbBthGePo-Jueb6mFYFFA-1
X-Mimecast-MFC-AGG-ID: _RbBthGePo-Jueb6mFYFFA_1780079800
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so62197325e9.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079800; x=1780684600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1XJAuHtEwSrf2OyC4wSiD7WDpcF6b/VSFdi0YQ2gfw=;
        b=FXEG7KX/dCeQdfM8fDrgMQMqAQTjx+aTJFMux/gQ193edRiRQEknx2gTeZsYUza353
         MK0qoy4SeAUSK9PE9Fy2xXgSY4YOjmGU7Zx/TfyW4n+mU5r3lEO5hLa/Q3hmxNOcI/te
         n49EMDbfPPfsJb9sdNDjttnWcSvL/ioefdBMGJKqvoqFZZvIvrAHjQGSVQpcspFlw4qq
         LDBgOBl5LR7AB8K4fz0HzlJQPRKOjfjJ6QvtXDvX0KGUL4lfFF5apslua32OQRxf1SNg
         IZR/MtHiLTDV2yTmkCHRTKS59xIkADpHXBQx9SkGk3NmgPNfYOg2dzI8teqDWAKGVsUR
         iWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079800; x=1780684600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+1XJAuHtEwSrf2OyC4wSiD7WDpcF6b/VSFdi0YQ2gfw=;
        b=IgfFijuU3M9K/38qjfBNfGA8ucMaYbII4kjF34/wTrfez5gAi8emlIk1xGOazzA7Pb
         C72+XgKDukxdIOgm5DmdJLIlfB1m+KxvzDoxP+DboPtM8AhU/56jB2FaVUlT21RO4nIf
         K71aRWY07gif1lyoae9wL8dvCB7jbqZAppdFF+oy8puR0wYOOiGpOzRxbpjb+4IpXGMi
         FonUm5PqM9Wa/OM7Ja6Vxv5Q3Lw0hbVucAWGvWDm7YlJxuDhGu0PufZwpERmGKJjZlcy
         Zg5U1ann8iWBdd2U+tUgzCv16/EYOUdrYBjWL43qbmADr5RAL+QlQKBO/aLd/cs1yCww
         IUOA==
X-Forwarded-Encrypted: i=1; AFNElJ8QFkGILEbASr2v61XnOrWmUDSRvjAZtccqpdsvyIUgW/Gbn0CoYWMDnXxScWu2KBtTrKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEl1E3LEqOJzWENYYwQXYKuuLseWbXjn/j3XEBsKg0CWGFjXZ
	5Kg7tvHxP+35x44IeUCpkgERRmvS6r6kSqYIYA8kYgS1tcukCyRgOcOCTxLPrzNRkxwJ2X/2WrV
	kiY5JSNQW/EVlvkr0MbEilFl1AkIVvpKf9gbiv+J4QKxHR7v3PlQ3LA==
X-Gm-Gg: Acq92OGYCBr8y1AKqa1+lJghlf72AhdRird7du9X9QsTKLy4mb7C3bu6VB5SVdIeY0t
	7TJe6jKdwIl+595WJhntOSqXmOHh8GxfIbzMcB1eVEvZNMqirwZAB2W+8369KbOMMA+4LLu+mLU
	gi6iwu8ns9Snxd+b5E24nkZ/rdMMe9/cd5xhPY5XmkKIxqaEMQoBQ7vvw+cSbmqDo7JXFvSL6cU
	AG/WB5j4KLUVi71VqtCkeyu2uJ6x+8KRvE8BPMqknU2kPK2m8JkV4fKSpejJo+q9RzpxsPoodbG
	r1+SsBFeUUVCNZi5dlmlEq2Gg95iktTHceHksCQpc6IikMfRBdyb5I5yFCDHrQM8YoeLBdYJrmO
	HbB1V7p2xB14cl0KND1xuPLPrpzNc/pfoVO79ynIezn1Gu47j5ar1Aj4qy4NuZ1qS3K6BA/qjw2
	LQApo9F5tuXLLhKHcTdBoFoFmMkCjWvN9xXCPAjQ==
X-Received: by 2002:a05:600d:8492:b0:490:51e2:d992 with SMTP id 5b1f17b1804b1-490a293fa59mr7911325e9.13.1780079799944;
        Fri, 29 May 2026 11:36:39 -0700 (PDT)
X-Received: by 2002:a05:600d:8492:b0:490:51e2:d992 with SMTP id 5b1f17b1804b1-490a293fa59mr7911005e9.13.1780079799550;
        Fri, 29 May 2026 11:36:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354b5bdsm4989755f8f.21.2026.05.29.11.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 18/24] KVM: SEV: Don't terminate SNP VMs on #VMGEXIT without a registered GHCB
Date: Fri, 29 May 2026 20:35:43 +0200
Message-ID: <20260529183549.1104619-19-pbonzini@redhat.com>
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

If the guest attempts a non-MSR #VMGEXIT without the registered GHCB,
return a GHCB_HV_RESP_MALFORMED_INPUT+GHCB_ERR_NOT_REGISTERED error to the
guest instead of exiting KVM_RUN with -EINVAL (and in likelihood killing
the VM).  KVM has already mapped the requested GHCB, i.e. can cleanly
report an error, and so exiting with -EINVAL is completely unjustified.

Fixes: 0c76b1d08280 ("KVM: SEV: Add support to handle GHCB GPA register VMGEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-19-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6c6a6d663e29..7c2ebc81306f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4520,9 +4520,12 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	sev_es_sync_from_ghcb(svm);
 
 	/* SEV-SNP guest requires that the GHCB GPA must be registered */
-	if (is_sev_snp_guest(vcpu) && !ghcb_gpa_is_registered(svm, ghcb_gpa)) {
-		vcpu_unimpl(&svm->vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n", ghcb_gpa);
-		return -EINVAL;
+	if (is_sev_snp_guest(vcpu) &&
+	    !ghcb_gpa_is_registered(svm, control->ghcb_gpa)) {
+		vcpu_unimpl(vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n",
+			    control->ghcb_gpa);
+		svm_vmgexit_bad_input(svm, GHCB_ERR_NOT_REGISTERED);
+		return 1;
 	}
 
 	ret = sev_es_validate_vmgexit(svm);
-- 
2.54.0

