Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C526466B77
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079813; cv=none; b=g+M2HMxKPPDw8XyHy1ATnm7qXkmsa8ygiBOR2YMZ7ZIOsHqP3oKKxAEHybCM/wkMcTCP+pQ6CI8gFkTxQP2x/avsncO4sHrVKzaVIGxvvJF/zpKQXJs4mqcidxuFfDInEtepgteTN3TE8g8eO6D9AuMwxsApp+enKJRwwyoYzqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079813; c=relaxed/simple;
	bh=Gs0LUEJH0VfnDiZiVYYAXOxGvbwDeDdsb7rBc4+0oUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6kA4ylmjMnO6JJqu/Fy5JBdsq5PFARKgEigCY/eAyRyxBD6YQCVF3DilFW23xRR7orgTONcgsF6hZDWop0kOXeopRlYIjdw1Ji25otknupM4HLmokn2aSQCqY4m/4jmFNEh/0pt/dMwMTnPdo0UpFe625R8QahK765GTL4GMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LweQTF9j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mjGyhQxi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LweQTF9j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mjGyhQxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMxep7AfURhp5jLM/CGXWdIbroUSuDElEQcy5Ibtd84=;
	b=LweQTF9j4/Jd/u1rQzhZ9lw6N6VIeFbk6jHL7s5rIuVyvqysv0YGjCGTrEjDv+Z/vLxdDe
	HLbuTygIAkWC9C0KEjZfFByj+gze92WQ5MDn6KaYblMixV/Nkd32OwmH9eG6Cwbq713pgT
	bz6CIlTgsaSkfNVrXoHT+dbYhAVAp9U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-PlktwbM-N16JTkZNZG4yDA-1; Fri, 29 May 2026 14:36:48 -0400
X-MC-Unique: PlktwbM-N16JTkZNZG4yDA-1
X-Mimecast-MFC-AGG-ID: PlktwbM-N16JTkZNZG4yDA_1780079807
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef63d1214so281611f8f.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079807; x=1780684607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMxep7AfURhp5jLM/CGXWdIbroUSuDElEQcy5Ibtd84=;
        b=mjGyhQxiGRuQ4JiDLuwJJeQX8vtIBcuoP4AdyxabGm+Awg8mHrlPkOIZUwMv0V5jJp
         T35D+OmnWMdjzc7idinFY7MCkLeAUH9tt9ikSMgskDCl8HFuhVOdjFDOf+5gbdxbUsnP
         qfW+B5DtWkEEUu2lSThhhpL77OBNbVMQLvwDfA2Uj7rkaAzLJmk1olmLQGMihUOjEGg6
         w2Enk0yA5AB1qqPBtNCwgeWjZs20Pg+22tggbBC8Qz2ZAE0++QY4oWGBwjOlupVhgxp7
         304iZ0n/xUPp7VlSHUgt1cHqKeQy2QSkjGl5cwNt91y9fFU/N6sr5Dg+9AaZQ5slk7n/
         tmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079807; x=1780684607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PMxep7AfURhp5jLM/CGXWdIbroUSuDElEQcy5Ibtd84=;
        b=Ftjmr0L5G3rfGyWk1So1GMD+GPTOVfMyCOGLjDVN43vzggiJSWv2UVbaIxXcaX0GTw
         S4MJWeb68iHuDNqdvUuXnoef0QzrK2XjXDAXtqGhPqXdrqIs/nihp7LkfqlrESYLbgCh
         XG91RM9HU256cL0W+2pbFzZ8hBjuE8lD4hFOvX5/MR6PG0BjKiY0yChGXcjNn+bhLgxy
         hgiH5cfgeH38JQ5Kbzsgt2NDU4p7p8b+H4gHAoQ0796VUSA/OAarAOhNOVzhHuNvhokF
         eyn9RMEEnAHWbbqu/Hc1hyTSbNVC0FuhSeSCeK5B816l9o72647Y6d/YkAdVPdAh66hM
         2EcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Iwxsb1xwDuXhQZ7vvHkwv7aMeRM787bqpaIYiyPCNAR1Ca1fuK6Mt0I5C6tfdgxguVdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymfb+dDMEgW6J6PMrFn9UE4lTSxyclAZi0pMUc+xTDTG0AGKwj
	3RwX0RwH0zwZrCEy9RNYvvF6FLvZBspMU7VnkH4z4Y+3R5h0Q7Fm17RkMEmfetcHQUnVgMObtfa
	kCzb6Gk0jx4XrVC0RbGPxnQ75N6UhmJKyzDCB/TPm8JvPbvzGtR2FYpbR9SqyJg==
X-Gm-Gg: Acq92OEVWBeyx2xUTCHFTp2rx2xcfA2fhqWQjVf3BDPc9dlz0cFH+EDyTJ+b1ZnJDbQ
	IBR652Yv7tqi4Ba8plpX5BNJ77dQ4AqkKEkvSjbFe1i/6vhpwX6dbQrx4f2cXDB2+qR6kmq2nPV
	wIX1IDxFRDPjEQxvNZsyStdnIiPJGNkjgSIVi3+ms+hRNSEn5/0S99CBV749jzNDUXFKsazOxww
	EUwX6EF42ckJVbM1NINmc5fKrDYrMA6Q5yadbgX9YEEll//LdvBCVWKfbbHjCRebXAEplGprDTu
	gzyDsvYAXZ49uMedSL8lp+H+m99SWXeiD/AmrHHC6NryZoxZfaHjDEFF9Mn3aIYdEebBalGW6iC
	PUdBMjsabQIPdqCtnJGZK5W3X9yAzZRuIilJBUQ9ZrtWNpTbkTulU2PbX79cYX+bNoV1Za8CKCV
	W1w5NsBygdAJq2DU1hltxKlYoiLIoea1xRTgdoQg==
X-Received: by 2002:a05:600d:8497:10b0:490:6869:9601 with SMTP id 5b1f17b1804b1-490a292a48fmr9986855e9.6.1780079806756;
        Fri, 29 May 2026 11:36:46 -0700 (PDT)
X-Received: by 2002:a05:600d:8497:10b0:490:6869:9601 with SMTP id 5b1f17b1804b1-490a292a48fmr9986575e9.6.1780079806451;
        Fri, 29 May 2026 11:36:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0d5dc2sm27451735e9.2.2026.05.29.11.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH 20/24] KVM: SEV: Return INVALID_EVENT for SNP-only #VMGEXIT from non-SNP guest
Date: Fri, 29 May 2026 20:35:45 +0200
Message-ID: <20260529183549.1104619-21-pbonzini@redhat.com>
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

Signal INVALID_EVENT, not MISSING_INPUT, if a non-SNP guest attempts to
invoke an SNP-only #VMGEXIT.  Opportunistically move the checks out of
sev_es_validate_vmgexit() to continue the march towards making said helper
a predicate whose sole purpose is to verify the guest has marked required
GHCB fields as valid.

Fixes: e366f92ea99e ("KVM: SEV: Support SEV-SNP AP Creation NAE event")
Fixes: 9b54e248d264 ("KVM: SEV: Add support to handle Page State Change VMGEXIT")
Fixes: 88caf544c930 ("KVM: SEV: Provide support for SNP_GUEST_REQUEST NAE event")
Fixes: 74458e4859d8 ("KVM: SEV: Provide support for SNP_EXTENDED_GUEST_REQUEST NAE event")
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-21-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 880a2acd77bf..b59adddfdbcc 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3491,8 +3491,6 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 			goto vmgexit_err;
 		break;
 	case SVM_VMGEXIT_AP_CREATION:
-		if (!is_sev_snp_guest(vcpu))
-			goto vmgexit_err;
 		if (lower_32_bits(control->exit_info_1) != SVM_VMGEXIT_AP_DESTROY)
 			if (!kvm_ghcb_rax_is_valid(svm))
 				goto vmgexit_err;
@@ -3505,13 +3503,12 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	case SVM_VMGEXIT_TERM_REQUEST:
 		break;
 	case SVM_VMGEXIT_PSC:
-		if (!is_sev_snp_guest(vcpu) || !kvm_ghcb_sw_scratch_is_valid(svm))
+		if (!kvm_ghcb_sw_scratch_is_valid(svm))
 			goto vmgexit_err;
 		break;
 	case SVM_VMGEXIT_GUEST_REQUEST:
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
-		if (!is_sev_snp_guest(vcpu) ||
-		    !PAGE_ALIGNED(control->exit_info_1) ||
+		if (!PAGE_ALIGNED(control->exit_info_1) ||
 		    !PAGE_ALIGNED(control->exit_info_2) ||
 		    control->exit_info_1 == control->exit_info_2)
 			goto vmgexit_err;
@@ -4476,6 +4473,19 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 	return 0;
 }
 
+static bool is_snp_only_vmgexit(u64 exit_code)
+{
+	switch (exit_code) {
+	case SVM_VMGEXIT_AP_CREATION:
+	case SVM_VMGEXIT_GUEST_REQUEST:
+	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
+	case SVM_VMGEXIT_PSC:
+		return true;
+	default:
+		return false;
+	}
+}
+
 int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4527,6 +4537,13 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
+	if (is_snp_only_vmgexit(control->exit_code) && !is_sev_snp_guest(vcpu)) {
+		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx is SNP-only\n",
+			    control->exit_code);
+		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_EVENT);
+		return 1;
+	}
+
 	ret = sev_es_validate_vmgexit(svm);
 	if (ret)
 		return ret;
-- 
2.54.0

