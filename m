Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3846AF2E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079823; cv=none; b=LoXiUjwZOso6ZgXRRKDTLeWYkvxEYv6bcYF4WeUKByG2LnsdqN7SzpWkvhpc8vlzh4dfNtGjpemhhw7tNpWvV345TAx/CtjG6DuKvYuFGvvHw1fTps2yoX67StxcvfaJBCB7B8TQu0+wAYb8NWXFnTGsHke2TmtXKya/B3XgpDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079823; c=relaxed/simple;
	bh=7gTKTWT1Lchsb/Z3dfump3Pz5JO6jhXvzUWfg2Nn1O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJM1ZUtkmh/pJo1G1srkk4w2mNP8nWmL03GvMCmO9NgDO4yfd2eQVfpZG3Kel8jIDdG4smmkO/amxUBaa3jkd5nHQpAA2YhnfjmPADUMRk7hZaJ7GOBy7yIbcDCebuGaxKdL9QaJoa6+Gm/1qzDrcGn+FWliVz3kMxQr0mh27Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3luuG1q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kvVkRPgV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3luuG1q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kvVkRPgV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYgJqK8ObqKkOVttmt0YkpLK2Sa2oRcDa7IpTgVfKT0=;
	b=F3luuG1qk2/VCcXToO3Qp/OOkoL2socSmuszs5LG+EgutjM5bEzgl88+jpZsXa6/S2t5st
	wPbBGBYTxsb/M/lqxiTWyrhfm40Hi5Gk/z1NNxoVUku3rJR73RXwtIYNv/OgwMz/8InD7v
	Y2djjykdGI0L2PWXNcLc1PdTct24bUc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-PErrUmwVObmKXOzQ7N5-Dg-1; Fri, 29 May 2026 14:36:53 -0400
X-MC-Unique: PErrUmwVObmKXOzQ7N5-Dg-1
X-Mimecast-MFC-AGG-ID: PErrUmwVObmKXOzQ7N5-Dg_1780079813
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43fe791a398so10499729f8f.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079812; x=1780684612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYgJqK8ObqKkOVttmt0YkpLK2Sa2oRcDa7IpTgVfKT0=;
        b=kvVkRPgVbpbRsPM3dwcJJqVBqNEQBm5javNXVMu1wlHW+bdLK73YC7QoWjoApYvMCG
         QOwtWu3brbEA6FSS/6JzadphVb9qwREB1qt3TEKsYj76Epimw7ZX7M5Nbp0V483VwySc
         z0t6YFhHX4syKvv/wo1I8Qf8nWFc3cA31uFEgrEGA7Jj7NKVkZVYNDajo5KeDkluMIgh
         6rNbA6wbt78eIA9SnZiMO5kMRpdql25siq+VJB0mqxUpaqx1YrU6RTwQFiIlT5gdrwr/
         d8oFxanJQkdIGC2G7M8l8VXoVRGPfhrRsLdysxl/DdOZOhbWh6Y0/jDgnUsajhjR8O64
         JPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079812; x=1780684612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zYgJqK8ObqKkOVttmt0YkpLK2Sa2oRcDa7IpTgVfKT0=;
        b=MMAqT/mmBF3mu4/MxmOr9o7slb0yjYz5DZLnhVLUDXbhehNOMaiw4n1fzE2xyJudB+
         hh1SIpprxdZUNGbdHnKNjEUF3eJFbtaDCDxaNl5CfUy+iMeHtgPVmTrpRjPCLJxBNNw+
         BU1q0b4L/jzdFuEElzUieuG4452OrzllLzqTZfHvX8ly0QI3W36azCoLy/sQrs4xUScK
         0P36ccwvrTjLWfc9PhkNs4w/0vpj0JDU8EIyxsnUvExQBmfcGoGTgy2thRIe1Kap9zAK
         0pkZM26TbXLsIplDxc40sRW538sRVjFivGQ+vUpEw90+CC18ChUzaT6831/ywmn05CT0
         WV/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8ius1tL05k+mqi31vf3GnKAAV0W8yWRqCLh7yIIzflnGvTpzsxbuUELYB8BBlKJXo5Yqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfMQGqn0o+zp3rbZMWZxgw/UchfFVwH12Km/i5bZGJn8hilV1
	LKo6hau2AJiGSpb4fD/jVxKGSJ4dahRk7l+U1uzGxkxsD4nTBlmDQ65ttaWGpuRV4iovAMzzatC
	Ji3IJG+0aemtWSfdY/oliw6319c6db9q14Q5CJgeV7ZZKkxK6ZcR2+Q==
X-Gm-Gg: Acq92OGSiSwoxJ3UXchO18ZQTnDw+SoTaPic5jnn6pGNnr1oXITgPCuliLwGW7802Iy
	14y4b1K2GLH/wYZ1cQsiigL13SSjwTNYpfEIFKtID9zP+Kw+pHTcOKW8m2VqtN50F6/m0A83M4h
	+Su2c8HCaGKs326dB1k5KwgTgMuCA+8iFy4lsDTC15DHYG3MonEu67IvieJ2334VAX/brmkAYwv
	6wLUzeGWKhEmM6Wds1hFpfaAheYiVhtFNRXXJRZGi51ggDwOacr887D900crUuq2M5hdEKyf2F7
	dVnyzNjBTymFxkvUfqkgb7DctglGRwYefyM3K+1CQerVaDG3l70Pe5Uu4XDb9JoaE4npgoiycjN
	i1qcBS3L980KMMxPPQgmxuaY6G9xzTIZYbAK3CYW6JHoAkYEkmJ/vAR7dz9MDocrwH/iPZRZLnv
	bTTlSwqNpT4nYnYT9sqCOT8RH+1NmOl4uwXlXC2Q==
X-Received: by 2002:a05:6000:22c7:b0:45e:ed10:8e0c with SMTP id ffacd0b85a97d-45ef6b19bedmr1756092f8f.14.1780079812498;
        Fri, 29 May 2026 11:36:52 -0700 (PDT)
X-Received: by 2002:a05:6000:22c7:b0:45e:ed10:8e0c with SMTP id ffacd0b85a97d-45ef6b19bedmr1756050f8f.14.1780079812120;
        Fri, 29 May 2026 11:36:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35598e5sm5051062f8f.27.2026.05.29.11.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH 22/24] KVM: SEV: Handle unknown #VMGEXIT reasons in sev_handle_vmgexit()
Date: Fri, 29 May 2026 20:35:47 +0200
Message-ID: <20260529183549.1104619-23-pbonzini@redhat.com>
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

Handle unknown #VMGEXIT reasons in sev_handle_vmgexit(), not in
sev_es_validate_vmgexit().  This makes it _much_ more obvious that KVM
simply funnels "legacy" exits to the standard SVM interception handlers,
and is the final preparatory change needed to reduce the scope of
sev_es_validate_vmgexit().

No functional change intended.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-23-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 74 +++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 84421d9a116b..864d6aea544b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3414,9 +3414,6 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
-	u64 reason;
-
-	reason = GHCB_ERR_MISSING_INPUT;
 
 	if (!kvm_ghcb_sw_exit_code_is_valid(svm) ||
 	    !kvm_ghcb_sw_exit_info_1_is_valid(svm) ||
@@ -3424,14 +3421,10 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		goto vmgexit_err;
 
 	switch (control->exit_code) {
-	case SVM_EXIT_READ_DR7:
-		break;
 	case SVM_EXIT_WRITE_DR7:
 		if (!kvm_ghcb_rax_is_valid(svm))
 			goto vmgexit_err;
 		break;
-	case SVM_EXIT_RDTSC:
-		break;
 	case SVM_EXIT_RDPMC:
 		if (!kvm_ghcb_rcx_is_valid(svm))
 			goto vmgexit_err;
@@ -3444,8 +3437,6 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 			if (!kvm_ghcb_xcr0_is_valid(svm))
 				goto vmgexit_err;
 		break;
-	case SVM_EXIT_INVD:
-		break;
 	case SVM_EXIT_IOIO:
 		if (control->exit_info_1 & SVM_IOIO_STR_MASK) {
 			if (!kvm_ghcb_sw_scratch_is_valid(svm))
@@ -3470,10 +3461,6 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		    !kvm_ghcb_cpl_is_valid(svm))
 			goto vmgexit_err;
 		break;
-	case SVM_EXIT_RDTSCP:
-		break;
-	case SVM_EXIT_WBINVD:
-		break;
 	case SVM_EXIT_MONITOR:
 		if (!kvm_ghcb_rax_is_valid(svm) ||
 		    !kvm_ghcb_rcx_is_valid(svm) ||
@@ -3495,23 +3482,12 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 			if (!kvm_ghcb_rax_is_valid(svm))
 				goto vmgexit_err;
 		break;
-	case SVM_VMGEXIT_NMI_COMPLETE:
-	case SVM_VMGEXIT_AP_HLT_LOOP:
-	case SVM_VMGEXIT_AP_JUMP_TABLE:
-	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
-	case SVM_VMGEXIT_HV_FEATURES:
-	case SVM_VMGEXIT_TERM_REQUEST:
-		break;
 	case SVM_VMGEXIT_PSC:
 		if (!kvm_ghcb_sw_scratch_is_valid(svm))
 			goto vmgexit_err;
 		break;
-	case SVM_VMGEXIT_GUEST_REQUEST:
-	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
-		break;
 	default:
-		reason = GHCB_ERR_INVALID_EVENT;
-		goto vmgexit_err;
+		break;
 	}
 
 	return 0;
@@ -3521,16 +3497,10 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	 * Print the exit code even though it may not be marked valid as it
 	 * could help with debugging.
 	 */
-	if (reason == GHCB_ERR_INVALID_EVENT) {
-		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx is not valid\n",
-			    control->exit_code);
-	} else {
-		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx input is not valid\n",
-			    control->exit_code);
-		dump_ghcb(svm);
-	}
-
-	svm_vmgexit_bad_input(svm, reason);
+	vcpu_unimpl(vcpu, "vmgexit: exit code %#llx input is not valid\n",
+		    control->exit_code);
+	dump_ghcb(svm);
+	svm_vmgexit_bad_input(svm, GHCB_ERR_MISSING_INPUT);
 
 	/* Resume the guest to "return" the error code. */
 	return 1;
@@ -4547,6 +4517,25 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	svm_vmgexit_success(svm, 0);
 
 	switch (control->exit_code) {
+	case SVM_EXIT_IOIO:
+		if (!((control->exit_info_1 & SVM_IOIO_SIZE_MASK) >> SVM_IOIO_SIZE_SHIFT))
+			return 1;
+
+		fallthrough;
+	case SVM_EXIT_READ_DR7:
+	case SVM_EXIT_WRITE_DR7:
+	case SVM_EXIT_RDTSC:
+	case SVM_EXIT_RDTSCP:
+	case SVM_EXIT_RDPMC:
+	case SVM_EXIT_CPUID:
+	case SVM_EXIT_INVD:
+	case SVM_EXIT_MSR:
+	case SVM_EXIT_VMMCALL:
+	case SVM_EXIT_WBINVD:
+	case SVM_EXIT_MONITOR:
+	case SVM_EXIT_MWAIT:
+		ret = svm_invoke_exit_handler(vcpu, control->exit_code);
+		break;
 	case SVM_VMGEXIT_MMIO_READ:
 	case SVM_VMGEXIT_MMIO_WRITE: {
 		bool is_write = control->exit_code == SVM_VMGEXIT_MMIO_WRITE;
@@ -4643,18 +4632,21 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 						       control->exit_info_2);
 		break;
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
+		/*
+		 * Note, the _guest_ is reporting an unsupported #VC, i.e. this
+		 * isn't the same thing as KVM getting an unsupported #VMGEXIT.
+		 */
 		vcpu_unimpl(vcpu,
 			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
 			    control->exit_info_1, control->exit_info_2);
 		ret = -EINVAL;
 		break;
-	case SVM_EXIT_IOIO:
-		if (!((control->exit_info_1 & SVM_IOIO_SIZE_MASK) >> SVM_IOIO_SIZE_SHIFT))
-			return 1;
-
-		fallthrough;
 	default:
-		ret = svm_invoke_exit_handler(vcpu, control->exit_code);
+		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx is not valid\n",
+			    control->exit_code);
+		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_EVENT);
+		ret = 1;
+		break;
 	}
 
 	return ret;
-- 
2.54.0

