Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E270477998
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079826; cv=none; b=f1ssYT7j4rGbG1ZwyXJP+SiUbU6EEsaLd0V/+iIn8spgTT44lNhluHBL2aaKxzcaMFD8nPWlL5YwDDpdkCpAmJtL+GzlBUtQoa/N6u1LFAe12xf9Z/QM4iRoCSAiDL23j3VGW1pdaaOMFCmTeWMogT9pjB8U7VLJrkjrgnXpwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079826; c=relaxed/simple;
	bh=XMgSUVd06jABBSWfczQttemRZ67nF8LRt692DiWCkcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVEt/WERfOBPZVcHrKHd7WnAgEmaW02tN7I/4pbVnzpQnMPS1TOMmxgDJmM9D1NL8EezjNmFKA6FxsDOMbq/eTpoApcrZ2yBHmUXLB01UpHGlLBwi2y2GdDNcvzyg6/mD7zDciyJQOi9EZkNOFI5t9StgMJnpHKdGl5VARynSqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNDmTPUv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLjg5opP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNDmTPUv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLjg5opP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9sAUXk/eVKAgtInIqwXX6aN0giUoEB/mKNSTu4u0gM=;
	b=XNDmTPUvxoJ00M3dug2g/frF4JSrujcbq04LaLEPFKcEpIydrkE/a5IYUuFai7gP49xB55
	OfxZYa9xoLPUkpCizDkq8UReo0G36nNpeSElI46UkyVZGZjJA9IPS1mRTz9HbY/Gng48Yr
	SWUzf8ofinWHaprw3v+bTmXg8Bwp4IQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-hL2d1qPEOQegJCPsTEEaDg-1; Fri, 29 May 2026 14:36:59 -0400
X-MC-Unique: hL2d1qPEOQegJCPsTEEaDg-1
X-Mimecast-MFC-AGG-ID: hL2d1qPEOQegJCPsTEEaDg_1780079819
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45eebc943bfso1030408f8f.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079818; x=1780684618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9sAUXk/eVKAgtInIqwXX6aN0giUoEB/mKNSTu4u0gM=;
        b=dLjg5opPVKE8UyiUqY3wk54jr0Aa/rdzIQSw/8YFZwL1x6lkZ00tarYSVREvOcvI+e
         SVl3mkE4J9PbsuxNjs4xLeS9C99oPLEk+lx76fMiKqYEP2ubYr9UCp85GL7OfbsR0oH9
         q7YsOeCA3eObighCmv3PQ7Uyxspg8KuQtilB5eE6PsNP+ePXN3rOU2cDHODdsDLK6Hr8
         lZKr7Qc9zK8pYYIePH9SGYgaA0Czxkzaviuk32TYqpVId3Ae9ZMWlm0vKeQulJVJ4HF1
         ce9N31nr/ufqCHy6tqqHEEwxpi3gPvEFKYfur/awhyTirZ0VHy4ZWaPAf/t3khxXBImw
         QJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079818; x=1780684618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T9sAUXk/eVKAgtInIqwXX6aN0giUoEB/mKNSTu4u0gM=;
        b=efPc2rtv7R2uCzjJhcDh2psILTYiYX7y9f0AiMmLijs34Cs/COyjdG42kBDQlI+2Do
         Rh9E40fhUq2gYgh3sZtG57MFDd/2VQ849k7jmfhiomE+MJqsEmdNWTlq7W78I5ypzDbM
         y6tLwwnGIEIIAqy3BIGH0HcjFWRqjf4dUu5bUb2WV+35kyC8YKWEfZBJHg6QcO3cSOkk
         XzY6yS7Xdg26QIjTjamn+yFIFRlBbcMGXruhO7EH2ynPpWC2Gc47q6otQyoVlPLPjIn4
         bMtTqF9qVwt6tIua7gUiUwoNlO1Dxs65yRI/2AuvAu2JiW+5Qj9DPF7h71v+ZYu7sl9Z
         gayQ==
X-Forwarded-Encrypted: i=1; AFNElJ9OLKuJyKoMdFJuInjCoTn84c4iMDeusHITjEHuVUM2X3lZPV11brjkeAf7ktig6kvOUPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx51tP88Er1B+/AujWpByHONobp8vS7LvWMkc+gsKKx+hwW9z09
	AthfO18ZGVOmkphS7MSS/JgaGZZQKk0beYimxCsCsehfYRZTP1X/CG2bxtAVndLLAgMmIXahGlG
	DTaqF5AB7dMewun+Gbl3LomeWYlO7i6HKDt7SL18HRL83AAIUkGAaxA==
X-Gm-Gg: Acq92OEkJRBTo/gx1X6SHh5LB7ZplhqZ4NAbCHh6X+PXCp+UBNK8c1EvTTfL14spY2l
	WLewjC5kzqOUfu4mTubYoRkRGzJZSKrsl7vAdxGp5lJCPp5Kb+Rt3Ga2Bd0l8grslD1jtyL19n/
	ncUu0POCPpuk989+84q9Onk1CVnGHVTZDpsgYGIjfsNjcINQbCGQBx6PDO6Qk2UUXCefC/BTUnE
	ZKJHzYI2mOIo3FU/lRyK8uNb9eU4ORbPuPUv2e+s1NpZSL3fRXL1q45WP+RZeeovqmdBHyUnkAO
	TYoS95TvovUHkv49Q1nX11HteNMkM73AQGxmtacFuHmLjV2rd5R7MUVnctEc7TvqcMi/M7Qgusw
	XnxBgUKuHYP8PEvT5rU7saLrhN2NjsRCDlXiMgrL+D0JmgnvoNk6F52gOMTr4XRL/ch38Jbmooc
	4IZf23HWnZ42GUqecWO55FloUlu5fMzI5KORYKJg==
X-Received: by 2002:a05:600c:c168:b0:490:5000:917 with SMTP id 5b1f17b1804b1-490a2a02ad9mr8878345e9.1.1780079818473;
        Fri, 29 May 2026 11:36:58 -0700 (PDT)
X-Received: by 2002:a05:600c:c168:b0:490:5000:917 with SMTP id 5b1f17b1804b1-490a2a02ad9mr8878065e9.1.1780079818030;
        Fri, 29 May 2026 11:36:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909dff2a80sm61952865e9.3.2026.05.29.11.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH 24/24] KVM: SEV: Remove sometimes-used function-scoped "ret" from #VMGEXIT handler
Date: Fri, 29 May 2026 20:35:49 +0200
Message-ID: <20260529183549.1104619-25-pbonzini@redhat.com>
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

Now that only two case-statements actually need a local "ret" variable,
refactor sev_handle_vmgexit() to have all flows return directly when
possible, and bury "ret" as "r" in the two paths that need to propagate a
return value from a helper.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-25-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 74 ++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index bb70df2bf1a4..bc9dd39778a1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4418,7 +4418,6 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	u64 ghcb_gpa;
-	int ret;
 
 	/* Validate the GHCB */
 	ghcb_gpa = control->ghcb_gpa;
@@ -4503,12 +4502,12 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	case SVM_EXIT_WBINVD:
 	case SVM_EXIT_MONITOR:
 	case SVM_EXIT_MWAIT:
-		ret = svm_invoke_exit_handler(vcpu, control->exit_code);
-		break;
+		return svm_invoke_exit_handler(vcpu, control->exit_code);
 	case SVM_VMGEXIT_MMIO_READ:
 	case SVM_VMGEXIT_MMIO_WRITE: {
 		bool is_write = control->exit_code == SVM_VMGEXIT_MMIO_WRITE;
 		u64 len = control->exit_info_2;
+		int r;
 
 		if (!len)
 			return 1;
@@ -4518,24 +4517,21 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 			return 1;
 		}
 
-		ret = setup_vmgexit_scratch(svm, !is_write, len);
-		if (ret)
-			break;
+		r = setup_vmgexit_scratch(svm, !is_write, len);
+		if (r)
+			return r;
 
-		ret = kvm_sev_es_mmio(vcpu, is_write, control->exit_info_1, len,
-				      svm->sev_es.ghcb_sa);
-		break;
+		return kvm_sev_es_mmio(vcpu, is_write, control->exit_info_1, len,
+				       svm->sev_es.ghcb_sa);
 	}
 	case SVM_VMGEXIT_NMI_COMPLETE:
 		++vcpu->stat.nmi_window_exits;
 		svm->nmi_masked = false;
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
-		ret = 1;
-		break;
+		return 1;
 	case SVM_VMGEXIT_AP_HLT_LOOP:
 		svm->sev_es.ap_reset_hold_type = AP_RESET_HOLD_NAE_EVENT;
-		ret = kvm_emulate_ap_reset_hold(vcpu);
-		break;
+		return kvm_emulate_ap_reset_hold(vcpu);
 	case SVM_VMGEXIT_AP_JUMP_TABLE: {
 		struct kvm_sev_info *sev = to_kvm_sev_info(vcpu->kvm);
 
@@ -4553,14 +4549,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 			       control->exit_info_1);
 			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
 		}
-
-		ret = 1;
-		break;
+		return 1;
 	}
 	case SVM_VMGEXIT_HV_FEATURES:
 		svm_vmgexit_success(svm, GHCB_HV_FT_SUPPORTED);
-		ret = 1;
-		break;
+		return 1;
 	case SVM_VMGEXIT_TERM_REQUEST:
 		pr_info("SEV-ES guest requested termination: reason %#llx info %#llx\n",
 			control->exit_info_1, control->exit_info_2);
@@ -4568,23 +4561,20 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		vcpu->run->system_event.type = KVM_SYSTEM_EVENT_SEV_TERM;
 		vcpu->run->system_event.ndata = 1;
 		vcpu->run->system_event.data[0] = control->ghcb_gpa;
-		ret = 0;
-		break;
-	case SVM_VMGEXIT_PSC:
-		ret = setup_vmgexit_scratch(svm, true, sizeof(struct psc_hdr));
-		if (ret)
-			break;
+		return 0;
+	case SVM_VMGEXIT_PSC: {
+		int r;
 
-		ret = snp_begin_psc(svm);
-		break;
+		r = setup_vmgexit_scratch(svm, true, sizeof(struct psc_hdr));
+		if (r)
+			return r;
+
+		return snp_begin_psc(svm);
+	}
 	case SVM_VMGEXIT_AP_CREATION:
-		ret = sev_snp_ap_creation(svm);
-		if (ret) {
+		if (sev_snp_ap_creation(svm))
 			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
-		}
-
-		ret = 1;
-		break;
+		return 1;
 	case SVM_VMGEXIT_GUEST_REQUEST:
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
 		if (!PAGE_ALIGNED(control->exit_info_1) ||
@@ -4595,12 +4585,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		}
 
 		if (control->exit_code == SVM_VMGEXIT_GUEST_REQUEST)
-			ret = snp_handle_guest_req(svm, control->exit_info_1,
-						   control->exit_info_2);
-		else
-			ret = snp_handle_ext_guest_req(svm, control->exit_info_1,
-						       control->exit_info_2);
-		break;
+			return snp_handle_guest_req(svm, control->exit_info_1,
+						    control->exit_info_2);
+
+		return snp_handle_ext_guest_req(svm, control->exit_info_1,
+						control->exit_info_2);
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		/*
 		 * Note, the _guest_ is reporting an unsupported #VC, i.e. this
@@ -4609,17 +4598,16 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		vcpu_unimpl(vcpu,
 			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
 			    control->exit_info_1, control->exit_info_2);
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	default:
 		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx is not valid\n",
 			    control->exit_code);
 		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_EVENT);
-		ret = 1;
-		break;
+		return 1;
 	}
 
-	return ret;
+	KVM_BUG_ON(1, vcpu->kvm);
+	return -EIO;
 }
 
 int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in)
-- 
2.54.0

