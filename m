Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A9B421F04
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079773; cv=none; b=Svm4X1mnJM1TiZCJCGcjf+pTz46zaHRPIqbVLRlZSzdbeKQKiqOFA7uYUOzGa8zrDarg97Bh6gxhU5HDghn93dF0QuNQ4L5QfxvrypI62UJWN7zTsSIdzKpVAlwXeR7vl4oAeFMbGqzC7At5yAAeEjbtqvblZeo5/pm4KsoJKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079773; c=relaxed/simple;
	bh=kCJYzqXTAo2sSN8mAzbW86qeCbAgWhHaLeZkmv0/cPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tivlT+oRN4EXuSRacvYxIZh9BxSG28qzTQq61fbO6p50aTfcO/BwpX98OLjtIoo1ThMp0405NL1xfKWGoJnwm3xDUmcn2mnX51GhL2WWviphUClFAZ9YtUqnw9DxbsoU6VGDMPissftdfjPZFmCINx8RkDSSN/qozwg4bcCrfcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAYudX1t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d14oMkgE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAYudX1t";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d14oMkgE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yqaeQPheI7We5TEAetxbjBel6Xe0oWr5Lp01EOcbc/I=;
	b=ZAYudX1tL1ojQq3lLChOgxhi/qpqLosOsueM8UBg2RMGUbNUXvJHw0CHVOW1uxH4tfQ/v+
	rJpWcZotCyBy7GYOMdxn4vlObw9Q74XSxnBxPRngHK7ZfjcFgJJybmdp2CPHzu72BQ5Co5
	lw5bTm0dcuC5RTu0XRuzr3P8YLEZvgE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-0oIlrKOMM6SUgLpFTCTYeA-1; Fri, 29 May 2026 14:36:07 -0400
X-MC-Unique: 0oIlrKOMM6SUgLpFTCTYeA-1
X-Mimecast-MFC-AGG-ID: 0oIlrKOMM6SUgLpFTCTYeA_1780079766
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4909c0f0ba2so7786105e9.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079766; x=1780684566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqaeQPheI7We5TEAetxbjBel6Xe0oWr5Lp01EOcbc/I=;
        b=d14oMkgEicC91GzBTA3BJGipjZaVOMh3Zytx7RoIE4UWVkxrHbNaRchzLJ/n53OzgP
         CCsaaw3jxTnJO3eELDpJlFjvx2AHa+wGFz8zac+VyWeeVyTDIEPeGFBwNEguo1tM6evQ
         l3NuBmmzUcpf55dVkIuZvqJfTpoNV0BKkj81C2Hhz9dz1qU8aH3HVwJBsfE69Nvj+Sck
         72RZnIvzkZ+s6lZWUG6ykgPTp2dKxrc5I2tHv0/YNyT/3joWh7DI8RPCph6hw0+WZhCP
         +rEla6Gu9d34WedPSp0yCUwbi8h6PflfmQqAQFh21YQpqk0xJzl9zfjVLX/3VFYZIyJi
         cxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079766; x=1780684566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yqaeQPheI7We5TEAetxbjBel6Xe0oWr5Lp01EOcbc/I=;
        b=iVDrHbXfbiTqy+4azgIQSa1D2/uctv/AwiE0VXv+FqNHG4gaNgPPHgzdBUbVPhl6p4
         FEQR7imnr4l+S4J/4IfJTXCqp+cP4EoVQH/uDt+qcFx5nkl0hghWF3hM64xQBmfJfwR+
         k1+al7d7J5CCgQc8glspln3C5iI3OXVSIiv+u/jku087fBWYOMXQbrXHRhf/RWLLmKky
         083vNxmmFMFZGh0oV8c4hzozBAzueNdjq5fU69QktgoYhVKMCa+NsLZmele+X7KWmFT3
         Oyj+Q54GZVXOAhf4cSGSFJ1adIsrY2tWC9LJIB2lXPuZqjQ5rlUrPFkOxcBhGlYqOpVp
         mZDg==
X-Forwarded-Encrypted: i=1; AFNElJ+QyHOA6rpXUgmnvyQOE0ayU/hNUn/AfKFiqiWOOjAt0Lfb/vUHv9t080KJ/Oj9vTMxVR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Hd4BWh6umvdMcIzTF3jTXbHoJ69RZfkJZp4gdTJ19jlscE82
	RejcHN1W3wdnf1qA4t1MdeaVWLd7t6YUB75LAJimvLd1iznq+KQGkQS6JY4PTztLGee40Ezn5as
	MjPSG+g02bI5KN2XjwgM7KO03emiKdji37aA4922/tR1Zt/FKTz57sQ==
X-Gm-Gg: Acq92OEeq1SwEj4wR/WjNV6bL11M0kNrc11aZOAy6XBHv5OFxAZgMD6DQV53ELrS6tl
	3MjupONe0UQmUZyqAau93aKAf80ts0D/tyQj3m76s6d2st4e218wcaLWEmKxABh1bo6tPv1pBlx
	Io5GW6AUmsPJ7VosO7Rv/kv+6V0OJj9/oPMKpKtbHG90afq61F4GfCopx+lUnXpg9Q/iHFoMXVH
	1R1U8bmcpIR1lDAEtiz7PbGXjjZcvkTXLbhvCO4T2QrTf+WhsAgyW7BZtsgYP4fsrpLnIIpbAZF
	1912oo0nN7qAggyQz7mvlfGZWI2sGOnwXYmgGdamh5foJB1dg58bjcYfx4wqFcIKUSa49WyzD+I
	2zmpiXaZqmNs0VBtUND/CyFpYlBUXmPuZ8U0afVeImaxPIyORTWvHA32SMQx/2KEq7Wwmzqaxxl
	14pFdbwZKCpoY40Gq3ASuTwnARtynLBtd2GX8k9Q==
X-Received: by 2002:a05:600d:6446:10b0:48f:eb8b:997a with SMTP id 5b1f17b1804b1-490a2965784mr10246935e9.31.1780079766144;
        Fri, 29 May 2026 11:36:06 -0700 (PDT)
X-Received: by 2002:a05:600d:6446:10b0:48f:eb8b:997a with SMTP id 5b1f17b1804b1-490a2965784mr10246445e9.31.1780079765370;
        Fri, 29 May 2026 11:36:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0a4dc0sm30754325e9.2.2026.05.29.11.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 06/24] KVM: SEV: Compute the correct max length of the in-GHCB scratch area
Date: Fri, 29 May 2026 20:35:31 +0200
Message-ID: <20260529183549.1104619-7-pbonzini@redhat.com>
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

When setting the length of the GHCB scratch area, and the area is in the
GHCB shared buffer, set the effective length of the scratch area to the max
possible size given the start of the guest-provided pointer, and the end of
the shared buffer.

The code was "fine" when first introduced, as KVM doesn't consult the
length of the buffer when emulating MMIO, because the passed in @len always
specifies the *max* size required.  But for PSC requests, the incoming @len
is just the minimum length (to process the header), and KVM needs to know
the full size of the scratch area to avoid buffer overflows (spoiler alert).

Opportunistically rename @len => @min_len to better reflect its role.

Fixes: 9b54e248d264 ("KVM: SEV: Add support to handle Page State Change VMGEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-7-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index cbb3040e0778..6072fecfe994 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3662,7 +3662,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 }
 
 #define GHCB_SCRATCH_AREA_LIMIT		(16ULL * PAGE_SIZE)
-static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
+static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 min_len)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	u64 ghcb_scratch_beg, ghcb_scratch_end;
@@ -3675,10 +3675,10 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 		goto e_scratch;
 	}
 
-	scratch_gpa_end = scratch_gpa_beg + len;
+	scratch_gpa_end = scratch_gpa_beg + min_len;
 	if (scratch_gpa_end < scratch_gpa_beg) {
 		pr_err("vmgexit: scratch length (%#llx) not valid for scratch address (%#llx)\n",
-		       len, scratch_gpa_beg);
+		       min_len, scratch_gpa_beg);
 		goto e_scratch;
 	}
 
@@ -3702,6 +3702,8 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 
 		scratch_va = (void *)svm->sev_es.ghcb;
 		scratch_va += (scratch_gpa_beg - control->ghcb_gpa);
+
+		svm->sev_es.ghcb_sa_len = ghcb_scratch_end - scratch_gpa_beg;
 	} else {
 		/* GHCB v2 requires the scratch area to be within the GHCB. */
 		if (to_kvm_sev_info(svm->vcpu.kvm)->ghcb_version >= 2)
@@ -3711,16 +3713,16 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 		 * The guest memory must be read into a kernel buffer, so
 		 * limit the size
 		 */
-		if (len > GHCB_SCRATCH_AREA_LIMIT) {
+		if (min_len > GHCB_SCRATCH_AREA_LIMIT) {
 			pr_err("vmgexit: scratch area exceeds KVM limits (%#llx requested, %#llx limit)\n",
-			       len, GHCB_SCRATCH_AREA_LIMIT);
+			       min_len, GHCB_SCRATCH_AREA_LIMIT);
 			goto e_scratch;
 		}
-		scratch_va = kvzalloc(len, GFP_KERNEL_ACCOUNT);
+		scratch_va = kvzalloc(min_len, GFP_KERNEL_ACCOUNT);
 		if (!scratch_va)
 			return -ENOMEM;
 
-		if (kvm_read_guest(svm->vcpu.kvm, scratch_gpa_beg, scratch_va, len)) {
+		if (kvm_read_guest(svm->vcpu.kvm, scratch_gpa_beg, scratch_va, min_len)) {
 			/* Unable to copy scratch area from guest */
 			pr_err("vmgexit: kvm_read_guest for scratch area failed\n");
 
@@ -3736,11 +3738,10 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 		 */
 		svm->sev_es.ghcb_sa_sync = sync;
 		svm->sev_es.ghcb_sa_free = true;
+		svm->sev_es.ghcb_sa_len = min_len;
 	}
 
 	svm->sev_es.ghcb_sa = scratch_va;
-	svm->sev_es.ghcb_sa_len = len;
-
 	return 0;
 
 e_scratch:
-- 
2.54.0

