Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ED946AF1A
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079823; cv=none; b=Io0x7rQy6s05S7paGrbkggjErUrvwC8w/j1+sbzPA/ObXPCxjjOoLkHsa9dto/FhmQ6+OgtilQAtg549lulREiE1lhw595vtSq8/sTseLukr3bFfugBofbbsv/9RXTd34idwfhoyiv/MTCMr5QpL7T6CZ8evB/tayP8EnJRQOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079823; c=relaxed/simple;
	bh=tjfpEUwp7NjqnZssVekMLaSUU2OL7s9j2o+WE02R+2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blG4khFwFLTkrLzMH9X6htgjJESLV73be0sZPTUr6uNqTT4RLUi+ERCnlc5oEZSR6eED0cJrj/V1x39PEpEohB30Vail03S0WAfDSDX0N9vvpVUJOmNTrHSb8C3RvkjqZAA/O2qEhNBGUm0Sqlmoc3YBZ6nal+0NT1assa4NWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHu2YDWi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwUm9wQq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHu2YDWi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwUm9wQq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVKpEBiTR4taCtQY2hcoVT0Go0ezbWRb/8iyh1YmSZw=;
	b=DHu2YDWifWHoh1ClTWDYQX+cXAeY0JnkAthhEwMsegFItQvmthokR/DjSXGZiiXiXmx32d
	YdhPiPGHQyL9Hbd4W6sogMgmKkml/YEIgytWk3uhdw9DodJx5EeCeg3h56kivPRdwKlBqu
	wodLsMZtnWoqK5ptv+G4K5H9CJ7BeSI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-5edltK2IPoOvIhanJ37wng-1; Fri, 29 May 2026 14:36:58 -0400
X-MC-Unique: 5edltK2IPoOvIhanJ37wng-1
X-Mimecast-MFC-AGG-ID: 5edltK2IPoOvIhanJ37wng_1780079817
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4903dcb32f8so71076085e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079817; x=1780684617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVKpEBiTR4taCtQY2hcoVT0Go0ezbWRb/8iyh1YmSZw=;
        b=iwUm9wQqWrNE+0Ouc1xGrguToDSAA5/i7R+DDf1BceM8t4yxmjV7nFWGwz9JOtnpNx
         Lxufw6v5oDF8Qmweb2bEiKKlco4EVLvk3SqHckGcIgu0PQbpf7YXIicHQg8bp/bKCCS8
         /VHgvRgA/asrzuVef4e9Tn1dIAmNx93CTQhVeu2eE1zd8OiQquPMqTW4e65o4RXJi+Q3
         r6AWYTsCxkciUgDcxmikKwpC2HhBd7F9+Rnh7AEJrYXU8DcTEMcCCayouEtVDl1qzg4i
         LFc3DKpGeKHV7OzTcAEuCxFGlG9U6sw/bljlV2TCcuM/XOzijs80Lvaj5WTeAYlRKBLm
         eUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079817; x=1780684617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iVKpEBiTR4taCtQY2hcoVT0Go0ezbWRb/8iyh1YmSZw=;
        b=gJvjVOoZ1NdnUyYfYwJ09HjZffx/saGHAsnAPyBh6UgWP6bNAfbdBh4DoEoWcMCN6K
         CrnGMt+DExlPWBXM4mI3xIR+oRBCIOwm8MkS0wiqRcylmtYxVfif9dEK0AiULV43OxlG
         alusiivbasFpGwiFZ3jg3lCCqd1AGLNWaxymhe5EXlUDJ4DCHQ3Yo8TqcnGpxOR5q8jb
         BP74FIC/aDdrx3vCTzQb/h+KrZ5j85GJ9iB2oxzAIIsvdQi2YbeDoRioO5XBB8YMjbEu
         6QmO0GDGxHS6NRD1DCNGW4fslBrd2b/Zefr0LRCGUCl0YmioPHwVBLUmUNAspvgCSv2+
         aKHA==
X-Forwarded-Encrypted: i=1; AFNElJ/hzrq64jomsHOg3LL53TYnPN1b+RUeACzuWCshYbJLTCIC64rF+6iKmSE9MGxH0rcNjxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUcgFmwnI/Qog0rU8w2syp5GK4hJaPwdLtZwtUCcukD1GYROg7
	tqbvfiITwqhCSzKC3tPuX8KUfhPSRe1/nUqwGpgjsmXpPqi4kdOi7tsD7kPFBGvoZH/1LoxobXC
	76KEcCY9JJuCI0+VpNBpd3bRv7phKL79fWhCOFkPUTiOZRolh+k4M+w==
X-Gm-Gg: Acq92OF4JnIoCTMtSDlSlzS4/lTtoSOC8tv2hESVbiUssG0jhj9aW+Xtl3kDVjCfm/m
	LKlgtPzbWETSRvn5lQZZ+Ju9GPXE81dDaZvDJtsfm+imnarztdTGWmcIFLNZhW5+PRSNgeTMtap
	+/N3PIZtvS1u+yON55GhK5xdZNr/RVeerGpEBq5D2OwF+MPOlHR/m4DiOaBx/3gVOIiNPGC7iKU
	HLGs40K0lbwTd5ur+zjQnKFHdmoe7ktO64dP5IEjKUj4rvqXPAhG19N57yNt5fxant1NPO1X+si
	IO8vJFD0Ikfh7G0THfmFTW0KUhSL/LUUkNRC5LEcEn41kxrXSomZYJ+cGMsAixfS35iPxhToe5q
	5xnxgGY82iu67g6Uj3fXeJ6PQ0FX/kU56nZvF4qW+FYJlf+RItzG3jEmMo+pDddbf5zBTOh+biB
	PxZ/tqvnFdgwDyub2JIB4HpmPoFxI+jFFvOevPKA==
X-Received: by 2002:a05:600c:6287:b0:490:9d1b:f068 with SMTP id 5b1f17b1804b1-490a295d9c6mr13787355e9.29.1780079816759;
        Fri, 29 May 2026 11:36:56 -0700 (PDT)
X-Received: by 2002:a05:600c:6287:b0:490:9d1b:f068 with SMTP id 5b1f17b1804b1-490a295d9c6mr13786835e9.29.1780079816338;
        Fri, 29 May 2026 11:36:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm5290792f8f.17.2026.05.29.11.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH 23/24] KVM: SEV: Turn sev_es_validate_vmgexit() into a dedicated predicate
Date: Fri, 29 May 2026 20:35:48 +0200
Message-ID: <20260529183549.1104619-24-pbonzini@redhat.com>
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

Now that sev_es_validate_vmgexit() is only responsible for checking that
all required GHCB fields are marked valid, turn it into a predicate whose
name reflects exactly that.

No functional change intended.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-24-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 112 +++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 71 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 864d6aea544b..bb70df2bf1a4 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3410,7 +3410,7 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
 	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
 }
 
-static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
+static bool sev_es_are_required_ghcb_fields_valid(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
@@ -3418,92 +3418,53 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	if (!kvm_ghcb_sw_exit_code_is_valid(svm) ||
 	    !kvm_ghcb_sw_exit_info_1_is_valid(svm) ||
 	    !kvm_ghcb_sw_exit_info_2_is_valid(svm))
-		goto vmgexit_err;
+		return false;
 
 	switch (control->exit_code) {
 	case SVM_EXIT_WRITE_DR7:
-		if (!kvm_ghcb_rax_is_valid(svm))
-			goto vmgexit_err;
-		break;
+		return kvm_ghcb_rax_is_valid(svm);
 	case SVM_EXIT_RDPMC:
-		if (!kvm_ghcb_rcx_is_valid(svm))
-			goto vmgexit_err;
-		break;
+		return kvm_ghcb_rcx_is_valid(svm);
 	case SVM_EXIT_CPUID:
 		if (!kvm_ghcb_rax_is_valid(svm) ||
 		    !kvm_ghcb_rcx_is_valid(svm))
-			goto vmgexit_err;
-		if (vcpu->arch.regs[VCPU_REGS_RAX] == 0xd)
-			if (!kvm_ghcb_xcr0_is_valid(svm))
-				goto vmgexit_err;
-		break;
+			return false;
+
+		return vcpu->arch.regs[VCPU_REGS_RAX] != 0xd ||
+		       kvm_ghcb_xcr0_is_valid(svm);
 	case SVM_EXIT_IOIO:
-		if (control->exit_info_1 & SVM_IOIO_STR_MASK) {
-			if (!kvm_ghcb_sw_scratch_is_valid(svm))
-				goto vmgexit_err;
-		} else {
-			if (!(control->exit_info_1 & SVM_IOIO_TYPE_MASK))
-				if (!kvm_ghcb_rax_is_valid(svm))
-					goto vmgexit_err;
-		}
-		break;
+		if (control->exit_info_1 & SVM_IOIO_STR_MASK)
+			return kvm_ghcb_sw_scratch_is_valid(svm);
+
+		if (!(control->exit_info_1 & SVM_IOIO_TYPE_MASK))
+			return kvm_ghcb_rax_is_valid(svm);
+
+		return true;
 	case SVM_EXIT_MSR:
 		if (!kvm_ghcb_rcx_is_valid(svm))
-			goto vmgexit_err;
-		if (control->exit_info_1) {
-			if (!kvm_ghcb_rax_is_valid(svm) ||
-			    !kvm_ghcb_rdx_is_valid(svm))
-				goto vmgexit_err;
-		}
-		break;
+			return false;
+
+		return !control->exit_info_1 ||
+		       (kvm_ghcb_rax_is_valid(svm) && kvm_ghcb_rdx_is_valid(svm));
 	case SVM_EXIT_VMMCALL:
-		if (!kvm_ghcb_rax_is_valid(svm) ||
-		    !kvm_ghcb_cpl_is_valid(svm))
-			goto vmgexit_err;
-		break;
+		return kvm_ghcb_rax_is_valid(svm) && kvm_ghcb_cpl_is_valid(svm);
 	case SVM_EXIT_MONITOR:
-		if (!kvm_ghcb_rax_is_valid(svm) ||
-		    !kvm_ghcb_rcx_is_valid(svm) ||
-		    !kvm_ghcb_rdx_is_valid(svm))
-			goto vmgexit_err;
-		break;
+		return kvm_ghcb_rax_is_valid(svm) &&
+		       kvm_ghcb_rcx_is_valid(svm) &&
+		       kvm_ghcb_rdx_is_valid(svm);
 	case SVM_EXIT_MWAIT:
-		if (!kvm_ghcb_rax_is_valid(svm) ||
-		    !kvm_ghcb_rcx_is_valid(svm))
-			goto vmgexit_err;
+		return kvm_ghcb_rax_is_valid(svm) && kvm_ghcb_rcx_is_valid(svm);
+	case SVM_VMGEXIT_AP_CREATION:
+		return kvm_ghcb_rax_is_valid(svm) ||
+		       lower_32_bits(control->exit_info_1) == SVM_VMGEXIT_AP_DESTROY;
 		break;
 	case SVM_VMGEXIT_MMIO_READ:
 	case SVM_VMGEXIT_MMIO_WRITE:
-		if (!kvm_ghcb_sw_scratch_is_valid(svm))
-			goto vmgexit_err;
-		break;
-	case SVM_VMGEXIT_AP_CREATION:
-		if (lower_32_bits(control->exit_info_1) != SVM_VMGEXIT_AP_DESTROY)
-			if (!kvm_ghcb_rax_is_valid(svm))
-				goto vmgexit_err;
-		break;
 	case SVM_VMGEXIT_PSC:
-		if (!kvm_ghcb_sw_scratch_is_valid(svm))
-			goto vmgexit_err;
-		break;
+		return kvm_ghcb_sw_scratch_is_valid(svm);
 	default:
-		break;
+		return true;
 	}
-
-	return 0;
-
-vmgexit_err:
-	/*
-	 * Print the exit code even though it may not be marked valid as it
-	 * could help with debugging.
-	 */
-	vcpu_unimpl(vcpu, "vmgexit: exit code %#llx input is not valid\n",
-		    control->exit_code);
-	dump_ghcb(svm);
-	svm_vmgexit_bad_input(svm, GHCB_ERR_MISSING_INPUT);
-
-	/* Resume the guest to "return" the error code. */
-	return 1;
 }
 
 static void __sev_es_unmap_ghcb(struct vcpu_svm *svm)
@@ -4510,9 +4471,17 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	ret = sev_es_validate_vmgexit(svm);
-	if (ret)
-		return ret;
+	if (!sev_es_are_required_ghcb_fields_valid(svm)) {
+		/*
+		 * Print the exit code even though it may not be marked valid
+		 * as it could help with debugging.
+		 */
+		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx input is not valid\n",
+			    control->exit_code);
+		dump_ghcb(svm);
+		svm_vmgexit_bad_input(svm, GHCB_ERR_MISSING_INPUT);
+		return 1;
+	}
 
 	svm_vmgexit_success(svm, 0);
 
@@ -4599,6 +4568,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		vcpu->run->system_event.type = KVM_SYSTEM_EVENT_SEV_TERM;
 		vcpu->run->system_event.ndata = 1;
 		vcpu->run->system_event.data[0] = control->ghcb_gpa;
+		ret = 0;
 		break;
 	case SVM_VMGEXIT_PSC:
 		ret = setup_vmgexit_scratch(svm, true, sizeof(struct psc_hdr));
-- 
2.54.0

