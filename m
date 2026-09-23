Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4543B05B1
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 20:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194743; cv=none; b=nRhrvyv6DF+p6mOGpURMDIqEBIyPq0ldnFY+1PD0EHamUOpAf7QZ7+KOaTRN2kEA4nsbc8UgCNCKlzvz5DM65u9L14+yqaJWSt0n/vWXeqjDiD+yQqY3+I81hago3o4yWCvX1liYswpftPL6ZksN2I/jUo2v8S3262ydbzGvT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194743; c=relaxed/simple;
	bh=QjLlivu2dOKEbDVXMk1o8BAQJhqwrAVntDEBrUiGVek=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ThVMfDzprtwFORoTSJaQ1e6WyAyLOHrLAqgd8Eq1meCg3Mo1r2TwQ2JT/O2ankWc+IV157Zkggh16Nln+JXSOPNl/unRThAvJNc44u8ytcHve6LeXraZ5VCg6Myoxxq95RVvIL3uhq2maOpj+pmNGa2/n8RvKsqrhpnX3lNUsuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEabeCqI; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEabeCqI"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso884543a91.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790194737; x=1790799537; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jszBNrH3yEDoF7juZMXw4OW+M7ckW2ZEtY9P8ifTaAo=;
        b=nEabeCqIkEG8p2uVW7Dw6dKEu8LWrw96IQa69SowACZerdVoiYIQ9Wn0IgNAEYpI/w
         SQAwa4jfrWR/SFYPWqVh0cWI2cOJJlZSZKWCI0SVz+ckJLuHiyH7aERaAS/4Lky8AVsW
         7fROwKPe49rYlUIDdLIAKM6v9QFhR/7QCOyuMBtcsKARehm10zXaLXeHLDHrFtelsOD1
         w2z91BWOo5zAia7SMvgRIsWJ1jyG1HfOS5lx4Hfo6VLV6zTz8OjlOIGBeQR1GYHjLRfs
         TCRyGY5lGp9wC1C5kxOBYz9BYiMU0QI8rDojv2OzQ0sLjuFe+hQ9JAcpPfiH4HhbzcXd
         wwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194737; x=1790799537;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jszBNrH3yEDoF7juZMXw4OW+M7ckW2ZEtY9P8ifTaAo=;
        b=kRmkDgjYIRPftm3icicitYU5O9Ldkth6GfWQt9GOStTtwD/Zw2EsB/ZoP3zlgyroKT
         FbkaP3CEbHc6UAP2+N994OQ0J2325dNJ5cCpxNX9C+qZhJg1wKjxLRvYUjmgo/2NtrNv
         w/o5WVTXUm0mRbiRxi7fraM8VB3+/oxsI9MqkwYlJaomCC0ljVoLXtklFf9K3DZSx7LO
         ZK/+IIVrmnqvnXX/ZPbo2Vkojw+3FDqVKyeyP/uUcQ+SG/pmbaNHFR3PYTrFehj/FTim
         UcO3oMfLEfqToEYQvTRp+cqLQ20DPcdNc6QivcyAse4mTkn2XQaclr+9pbmWAnFwVl6u
         3XOg==
X-Gm-Message-State: AFuF++mElUHXo5AZOyhSWw+PQ8lQbJReGQ+yCQoxgnxERLIAp5o37kHe
	Ec6aaydrgQGwWzCYjjdPZoU5HESHyakF1ZIaVW2lRShwjNEec/IYwy1qlravxp7znlsyx51MVVD
	GId0GjCLjM8Erbrsq6xGkKrYLoSSYGuCcbdpSN/PFtHZJ6NCCAP8b9xnyqbns2PGOe+ezfKXLMM
	1M47mYFyUjop0Up52ky4I6QyS57HyNyEpKrhQJ
X-Received: from pgvf21.prod.google.com ([2002:a65:6295:0:b0:cc1:bda2:d09c])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c105:b0:398:e96a:8999
 with SMTP id 98e67ed59e1d1-3a098b3741amr216478a91.16.1790194737205; Wed, 23
 Sep 2026 13:18:57 -0700 (PDT)
Date: Wed, 23 Sep 2026 20:18:12 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAM0tGoC/32NQQ7CIBREr9L8tRjAitqV9zBdQPmlP6lAoBJN0
 7uLPYCryZtk3qyQMRFm6JoVEhbKFHwFeWhgmLR3yMhWBsml4jfBWfaRkS96JlszvhZ2tsYo3fI
 rXkaou5hwpPfufPSVJ8pLSJ/9oohf+89WBBNsNBL5yWolWnN3IbgZj0N4Qr9t2xeoKAILswAAA A==
X-Change-Id: 20260910-snp-invalid-input-5dbb6a408e7f
X-Mailer: b4 0.14.3
Message-ID: <20260923-snp-invalid-input-v2-1-c00e0dd077ca@google.com>
Subject: [PATCH v2] KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer
 access failure
From: Jacky Li <jackyli@google.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Jacob Xu <jacobhxu@google.com>, 
	Supraja Sridhara <suprajasri@google.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"

Currently, snp_handle_(ext_)guest_req() returns -EIO when
kvm_{read/clear}_guest() fails while accessing guest-provided buffers.
Returning -EIO causes KVM_RUN to exit to userspace, likely killing the VM.

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

Additionally, tickle the response buffer before issuing the PSP command
so that an invalid resp_gpa fails upfront with GHCB_ERR_INVALID_INPUT.
Do not return an error to the guest if the post-firmware write fails, as
the firmware has already incremented the VMPCK sequence number. Exiting
to userspace avoids creating an ambiguous failure where the guest has no
way to know whether to advance its VMPCK sequence number.

Fixes: 88caf544c930 ("KVM: SEV: Provide support for SNP_GUEST_REQUEST NAE event")
Fixes: 74458e4859d8 ("KVM: SEV: Provide support for SNP_EXTENDED_GUEST_REQUEST NAE event")
Signed-off-by: Jacky Li <jackyli@google.com>
---
v2:
 - "Tickle" resp_gpa before issuing the PSP command. [Sean]
 - Keep post-command write failure as -EIO; returning INVALID_INPUT
   creates an ambiguous ABI on whether VMPCK was consumed. [Tom, Sean]

v1: https://lore.kernel.org/all/20260910-snp-invalid-input-v1-1-fb2e03da614b@google.com
---
 arch/x86/kvm/svm/sev.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f41..37a2a2677d3a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4221,6 +4221,7 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
 	struct kvm *kvm = svm->vcpu.kvm;
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
 	sev_ret_code fw_err = 0;
+	u8 tickle = 0;
 	int ret;
 
 	if (!is_sev_snp_guest(&svm->vcpu))
@@ -4228,8 +4229,15 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
 
 	guard(mutex)(&sev->guest_req_mutex);
 
-	if (kvm_read_guest(kvm, req_gpa, sev->guest_req_buf, PAGE_SIZE))
-		return -EIO;
+	if (kvm_read_guest(kvm, req_gpa, sev->guest_req_buf, PAGE_SIZE)) {
+		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+		return 1;
+	}
+
+	if (kvm_write_guest(kvm, resp_gpa, &tickle, sizeof(tickle))) {
+		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+		return 1;
+	}
 
 	data.gctx_paddr = __psp_pa(sev->snp_context);
 	data.req_paddr = __psp_pa(sev->guest_req_buf);
@@ -4244,6 +4252,14 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
 	if (ret && !fw_err)
 		return ret;
 
+	/*
+	 * Exit to userspace if writing the response fails. The buffer was already
+	 * tickled, so failure here indicates the mapping changed in flight.
+	 *
+	 * Do not return an error to the guest because firmware already incremented
+	 * the VMPCK sequence number. Exiting to userspace avoids creating an
+	 * ambiguous failure ABI for the guest.
+	 */
 	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE))
 		return -EIO;
 
@@ -4295,8 +4311,10 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
 		return -EINVAL;
 
 	if (kvm_read_guest(kvm, req_gpa + offsetof(struct snp_guest_msg_hdr, msg_type),
-			   &msg_type, 1))
-		return -EIO;
+			   &msg_type, 1)) {
+		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+		return 1;
+	}
 
 	/*
 	 * As per GHCB spec, requests of type MSG_REPORT_REQ also allow for
@@ -4335,8 +4353,10 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
 		 * As per GHCB spec (see "SNP Extended Guest Request"), the
 		 * certificate table is terminated by 24-bytes of zeroes.
 		 */
-		if (data_npages && kvm_clear_guest(kvm, data_gpa, 24))
-			return -EIO;
+		if (data_npages && kvm_clear_guest(kvm, data_gpa, 24)) {
+			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+			return 1;
+		}
 	}
 
 	return snp_handle_guest_req(svm, req_gpa, resp_gpa);

---
base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
change-id: 20260910-snp-invalid-input-5dbb6a408e7f

Best regards,
-- 
Jacky Li <jackyli@google.com>

