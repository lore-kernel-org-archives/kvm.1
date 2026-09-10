Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DBE3AB29D
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074412; cv=none; b=Qbz/n6OlnAbjWJ/w8NE5LuaoZeBETzcTNF2TihAKHWmA5bCprn7/wvZI+KGsIqLcRdyDZCYwXuNYibaoOoYrANDsu5elBjLLujVbS82vSn4wLP9UWu7s/46X0+Y1NTOOSsQoyJo3eOG+mK4knykjAEhxItPZRgwBOc1d8+s8zxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074412; c=relaxed/simple;
	bh=+QJuiFNNU2WuMiOfbuoDhSNfC8EPo0OvHi6oF2IXUBk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=soM4hd0Ej9DA0+wF19xuDusI1ostpUmtKXvpuidzTpKgMj6KE8w8HpmD65eSHtkcEyOM+EdPplmOmjQdsa34b20QyECvSfIMwRqK76zGQiw+TKqC5G+MXWci0fdDtFqHKl+q6NnK8s0I7Toi9c5fqR2CugeCFE0lktJXYHMHERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lDfDQ60A; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lDfDQ60A"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfa4e4684bso2812375ad.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789074403; x=1789679203; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gNFeNcyltUj1f0y6EIQIHeGiYuc25QrluAzkIS54884=;
        b=lDfDQ60A/xRzIoOlqH9MAGMnIsM9B8IGS2CfdNOxxigbqzgsDTFtrf5OH+ZoOUeG0A
         ddvM4MTBojzhq0mwKOaA6w7LtBAY4aGrwktu/0j/PFZrG2/fY5m8Ws5BpxJLjY9PdLKJ
         /Y3384bV2v9+LkmF68Kjk7/chXhXNjTq+1Qo1jdfj6Z2AyYmt1zeLUX1iKm63FIgIU7N
         txlCD5H8XFYH+q8BTcvfZLm+WvsVCqGlyDnTY7MwTzLwhx/ThBupEAW7qTHHOEFxW3kb
         in90wpgqOX4HqT7KgceJ4cp537vBnwQzkMQ+Rg1P2q/s+gv4F9B+qVMLXChZ1n1BHMS6
         xFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074403; x=1789679203;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gNFeNcyltUj1f0y6EIQIHeGiYuc25QrluAzkIS54884=;
        b=i8H8ezKR09R5dB1UN4xqsnKTLiHVKZCMdSC20O8yeTw3jxPPmsCgDIVQjsW3Phbqm2
         j45v9HIBw/pi5c8J9YQwh6fi3RotpktgCQcdIrY2qf6wBg1axBg6adk03ouPbfsW3mvl
         8UAdYEZ875JiAeS06R0s3xVPK420mihEaB6XUFQql01JjaIBC5HaBwu9O+MqiywQYuaz
         zCGG24Pn20PdktLbJMwfzN5D5FBEybrXePX9U3ZaYUh4wicpdeLWrTfngiEE+MeZTcqO
         reMbIE1cT47sCZSV2vt29CtbnYQ5QW1kLMu/ZB0KLqz5Z5tdduD2TRDsNAyLmw6Iel/4
         k4ug==
X-Gm-Message-State: AFuF++kCQxPGXjtK8nMfUsBLC/x3OTGBVi/jToUm+wEyyWBW3hug2wAu
	djY1SdJBf0TCIfvmr1Rw+dvYheWN10BvmAYD4YUfWE+2yoPfuif0Y1a4v8kADTbwvcl/cs2AUWl
	syJIOwvGgodbkPj9tKm9cMTkgcxICjLuqBkL9m5u9bqaZ6FyQirRdyUeS3RUhqacMzdDb8X4nm8
	eBR4HsOb/C2JJl7N2FkNCbpDerUZf35fqS3Dz8
X-Received: from pleg20.prod.google.com ([2002:a17:902:e394:b0:2db:814a:e864])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea03:b0:2d9:1dee:43db
 with SMTP id d9443c01a7336-2dd2a34fd9cmr23427655ad.15.1789074402904; Thu, 10
 Sep 2026 14:06:42 -0700 (PDT)
Date: Thu, 10 Sep 2026 21:06:21 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMwbo2oC/x2MSwqAIBQArxJvnaBR9rlKtNB81oMw0ZJAunvSa
 pjFTIaIgTDCVGUImCjS6YqIuoJ1V25DRqY4NLyRfBScRecZuaQOMoX+vlhntJaq5QP2FkrnA1p 6/ue8vO8HL8zzAGMAAAA=
X-Change-Id: 20260910-snp-invalid-input-5dbb6a408e7f
X-Mailer: b4 0.14.3
Message-ID: <20260910-snp-invalid-input-v1-1-fb2e03da614b@google.com>
Subject: [PATCH] KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer access failure
From: Jacky Li <jackyli@google.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Jacob Xu <jacobhxu@google.com>, 
	Supraja Sridhara <suprajasri@google.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"

Currently, snp_handle_(ext_)guest_req() returns -EIO when
kvm_{read/write/clear}_guest() fails while accessing guest-provided
buffers. Returning -EIO causes KVM_RUN to exit to userspace, likely
killing the VM.

Fix this by returning GHCB_HV_RESP_MALFORMED_INPUT with sub-error code
GHCB_ERR_INVALID_INPUT to the guest and resuming the vCPU.

Per the GHCB specification, guest-provided GPA buffers that cannot
be accessed by the hypervisor (e.g. private pages) should be treated
as guest input errors. Because kvm_{read/write/clear}_guest() only
returns -EFAULT on failure, treating this failure as an invalid input
aligns with the definition of -EFAULT ("Bad address").

Returning GHCB_ERR_INVALID_INPUT also matches existing SNP handling
in KVM, which already returns this error code for unaligned or
overlapping buffers. It also aligns with other hypercall implementations
in KVM (e.g. Hyper-V returning INVALID_HYPERCALL_INPUT on
kvm_read_guest() failures in kvm_hv_flush_tlb()).

Performing upfront validation (e.g. via kvm_mem_is_private()) is
avoided because it is prone to TOCTOU races with concurrent Page State
Changes.

Fixes: 88caf544c930 ("KVM: SEV: Provide support for SNP_GUEST_REQUEST NAE event")
Fixes: 74458e4859d8 ("KVM: SEV: Provide support for SNP_EXTENDED_GUEST_REQUEST NAE event")
Signed-off-by: Jacky Li <jackyli@google.com>
---
 arch/x86/kvm/svm/sev.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f41..d07562310519 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4228,8 +4228,10 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
 
 	guard(mutex)(&sev->guest_req_mutex);
 
-	if (kvm_read_guest(kvm, req_gpa, sev->guest_req_buf, PAGE_SIZE))
-		return -EIO;
+	if (kvm_read_guest(kvm, req_gpa, sev->guest_req_buf, PAGE_SIZE)) {
+		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+		return 1;
+	}
 
 	data.gctx_paddr = __psp_pa(sev->snp_context);
 	data.req_paddr = __psp_pa(sev->guest_req_buf);
@@ -4244,8 +4246,10 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
 	if (ret && !fw_err)
 		return ret;
 
-	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE))
-		return -EIO;
+	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE)) {
+		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+		return 1;
+	}
 
 	/* No action is requested *from KVM* if there was a firmware error. */
 	svm_vmgexit_no_action(svm, SNP_GUEST_ERR(0, fw_err));
@@ -4296,7 +4300,7 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
 
 	if (kvm_read_guest(kvm, req_gpa + offsetof(struct snp_guest_msg_hdr, msg_type),
 			   &msg_type, 1))
-		return -EIO;
+		goto request_invalid;
 
 	/*
 	 * As per GHCB spec, requests of type MSG_REPORT_REQ also allow for
@@ -4336,7 +4340,7 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
 		 * certificate table is terminated by 24-bytes of zeroes.
 		 */
 		if (data_npages && kvm_clear_guest(kvm, data_gpa, 24))
-			return -EIO;
+			goto request_invalid;
 	}
 
 	return snp_handle_guest_req(svm, req_gpa, resp_gpa);

---
base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
change-id: 20260910-snp-invalid-input-5dbb6a408e7f

Best regards,
-- 
Jacky Li <jackyli@google.com>

