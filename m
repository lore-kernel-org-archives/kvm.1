Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B3423142
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079762; cv=none; b=M5b1/Q2DNyS8bBHwmyUcZz3heaWRKjfdQyE/dJp5qHRjkdPzkfD7iRUtksEMZM6NfKghNWNtW7mZX5PV5QmQ09VQkOBSejDNUz0xCKqTXM0kEQVKCEkLWaHUbZE5D2b7AbMNEOAFCo9lNbpCFwZr2rbL/ToumMIZO8ifeSDdHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079762; c=relaxed/simple;
	bh=d9xvjs+tTx/sVZNCwndNXY07gix+BakluyzBTGottoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCCQdohzXjcGZA2CU0DUQBb3TykyAjQDdJHM2vWPxctQLViraclDniLgcOSNypJcMDx7+waZT0YN8eJOkDbmEiJNIUIUleAS4+IalV3l3OpsrefkVIPq8tgNc3DLbHWzBtQMcP3RaWvqLSeUpVPwxD46r9jTq6jq9F3oZSoxPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLviFvUQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbgtCbQ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLviFvUQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbgtCbQ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bItx102/eY014jSvfKnVDtrZQixF/uHwn/vTfUZ9ulM=;
	b=jLviFvUQab4Qy4n65pSnHDzdtzttmctCsLj0gB2WZyU31IGOrIMSQVeoMqR9wYrO97jdds
	jZqUlPimzhDnLtNnRYu/pv2g2AEwBMaanpLAah44Wd8Q5oTky1QD7v9bVohCvevQ8fPlB4
	v9xsjywOx6hq1wxtqqqlHlndFsP4q2I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-0cdKmTWgPoezrqqIu7okjw-1; Fri, 29 May 2026 14:35:54 -0400
X-MC-Unique: 0cdKmTWgPoezrqqIu7okjw-1
X-Mimecast-MFC-AGG-ID: 0cdKmTWgPoezrqqIu7okjw_1780079753
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4909c0f0ba2so7785425e9.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079753; x=1780684553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bItx102/eY014jSvfKnVDtrZQixF/uHwn/vTfUZ9ulM=;
        b=NbgtCbQ010XyI1gQ6VOPWKSPEcwOXucv/uB6U+6QjR1MsGeSBmCyv4fgwID7Qd9RlC
         hOeHuKyLTt19NVFFDp0dfnH7pS7IPVzs/U0gCpRLWD469fId6MWP5iA9vC3Nxt+rVpSs
         X5GtCiTY1Uhx13L5yZESp/2Y/9rvIfetDZAzGTF0f+ypJUWRWPia9WD/2jWqKsyR7T7c
         9/KYr8zMNWwhifwJSEZPl94Q5b41J5JX/RkLfJ2mtonRK0VO77suVjZhKaEL+HXRHdDE
         0nUukwyQko41cI9h5gj8W0sFvqNolZv9nu4fwoWvLWpZeh9knrCTzed6ghlT9yk99fgx
         LG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079753; x=1780684553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bItx102/eY014jSvfKnVDtrZQixF/uHwn/vTfUZ9ulM=;
        b=rsCQHnwHERXBfce6x3LaQbQaOm4IRlfkiNLKJOGzWAL/czFMGPtS9J+uvoDKH43p/w
         SpckotPHZDKAB+3MlvUVVriAK6S6pKN40YZpgpfdqQ75MZuQt0Qql72xRvPhBfkoiA0Y
         6miT5bCAtoVdw+eqxEqA6SRdmZpH2KaCDKa8VlQvAYFVl/qU8LUDUcAE9sn79ibk5wOn
         TuM7ouATmEbBQSB9Erkcl9C4b/V8Y/UdZJoXCgt8wSCi7lO2s9ATRLv39qkluMowxqt+
         gajFv6khidpPE9g273+WBe2g/Gg142x64VQ/awgr7TkcfDgGqwKAdoVUmXBR03jowTcI
         E0+Q==
X-Forwarded-Encrypted: i=1; AFNElJ826sx6QNlTmp4b587qCzD9mFHtY5XlEuiaTIOWUO5oNqCG2v4CD4zeN09MF5bqR1Iczz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ExCKvEhrfl9tcArF5zMlNrrKEv1gzzMoUiKw82HqeQUco+nJ
	TU/GlDuYCwq4SFF+k7I8qTcjJt0DLve927TAnOhq8HvYqsTH2NUR9RN4XRbqm70QIrH+wIxavV1
	pw1pCfnOJbLtTJGUBhOFiOexvIKQ0YMyxhUqtWnWtOwFPoYNvZyGfhA==
X-Gm-Gg: Acq92OHLnsK6HdIffBefVCIkeOcm0TC/zBeNfIIdsZyYeYSNmHUn5Bga8uB513IrVbK
	29k+AO6rFfqytsGwb7qlp60zSWye72Ux9azZz6jr9xMtJM3bYCtnmXZkl2ci8pJ+7EGZ3/jsKiK
	ASwyaiiMAiwHn4vNBe/foGAg41CmgQhtsS/SkSCHsIUseFzRdXpTZ9bngMr1VJnzpPuJAuXKKBv
	MFyUX4NuP3rhUxITA0ksUdGcO2gKLbcl8O19Cpez6UdeIje0jU16I6LQR5VDUq5HcbFqLfm00cn
	NU86iuWpavBzgY6KNNtrLbih9uXeB2Oh7nUJylwM4VUlTBpGov5LDFwnJcZ8TLxD9x+YHKXS4vh
	/n5I9f0JVCop8A95q1dWm5/jZ2bpCAl/qsse/ZeXcKbxXa/oeK3Xu5Sv7NO+gHBR2kurwmr9lEr
	HuIwoDKNeWd/LzSm83qOVveS5qnxheqcucvJESqA==
X-Received: by 2002:a05:600c:6287:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490a29338a8mr12421995e9.15.1780079753310;
        Fri, 29 May 2026 11:35:53 -0700 (PDT)
X-Received: by 2002:a05:600c:6287:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490a29338a8mr12421485e9.15.1780079752861;
        Fri, 29 May 2026 11:35:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3559645sm5101632f8f.26.2026.05.29.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:35:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Stan Shaw <shawstan96@gmail.com>,
	Peter Gonda <pgonda@google.com>,
	Jacky Li <jackyli@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/24] KVM: SEV: Require in-GHCB scratch area if GHCB v2+ is in use
Date: Fri, 29 May 2026 20:35:26 +0200
Message-ID: <20260529183549.1104619-2-pbonzini@redhat.com>
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

From: Michael Roth <michael.roth@amd.com>

As per the GHCB spec, when using GHCB v2+ require the software scratch area
to reside in the GHCB's shared buffer.  Note, things like Page State Change
(PSC) requests _rely_ on this behavior, as the guest can't provide a length
when making the request, i.e. the size of the guest payload is bounded by
the size of the shared buffer.

Failure to force usage of the GHCB, and a slew of other flaws, lets a
malicious SNP guest corrupt host kernel heap memory, and leak host heap
layout information.

setup_vmgexit_scratch() allocates a buffer via kvzalloc(exit_info_2),
where exit_info_2 is guest-controlled. With exit_info_2=24, this yields
a 24-byte allocation in kmalloc-cg-32 (32-byte slab objects). The buffer
holds an 8-byte psc_hdr followed by 8-byte psc_entry structs, so only
entries[0] and entries[1] are in-bounds.

snp_begin_psc() validates end_entry against VMGEXIT_PSC_MAX_COUNT (253)
but NOT against the actual buffer size:

      idx_end = hdr->end_entry;

      if (idx_end >= VMGEXIT_PSC_MAX_COUNT) {   // checks 253, not buffer
          snp_complete_psc(svm, ...);
          return 1;
      }

      for (idx = idx_start; idx <= idx_end; idx++) {
          entry_start = entries[idx];           // OOB when idx >= 2

The guest sets end_entry=10+, causing the host to iterate entries[2+]
which are OOB into adjacent slab objects. For each OOB entry:

  - The host reads 8 bytes (OOB READ / info leak oracle)
  - If the data passes PSC validation, __snp_complete_one_psc() writes
    cur_page = 1 or 512 into the entry (OOB WRITE, sev.c:3806)
  - If validation fails, the error response reveals whether adjacent
    memory is zero vs non-zero (information disclosure to guest)

The guest controls allocation size (exit_info_2), entry range
(cur_entry/end_entry), and can fire unlimited VMGEXITs to repeatedly
hit different slab positions.

By exploiting the variety of bugs, a malicious SEV-SNP guest can:
    - OOB read adjacent kmalloc-cg-32 objects (heap layout disclosure)
    - OOB write cur_page bits into adjacent objects (heap corruption)
    - Trigger use-after-free conditions across VMGEXITs

E.g. with KASAN enabled, a single insmod of the PoC guest module
produces 73 KASAN reports:

    BUG: KASAN: slab-out-of-bounds in snp_begin_psc+0x126/0x890
    Read of size 8 at addr ffff888219ffb5e0 by task qemu-system-x86/2199

    BUG: KASAN: slab-out-of-bounds in snp_begin_psc+0x468/0x890
    Write of size 8 at addr ffff888351566648 by task qemu-system-x86/2199

    The buggy address belongs to the object at ffff888XXXXXXXXX
     which belongs to the cache kmalloc-cg-32 of size 32
    The buggy address is located N bytes to the right of
     allocated 32-byte region [ffff888XXXXXXXXX, ffff888XXXXXXXXX)

  Breakdown:
    62 slab-out-of-bounds (reads + writes past allocation)
     7 slab-use-after-free
     4 use-after-free

All credit to Stan for the wonderful description and reproducer!

Reported-by: Stan Shaw <shawstan96@gmail.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Jacky Li <jackyli@google.com>
Fixes: 4af663c2f64a ("KVM: SEV: Allow per-guest configuration of GHCB protocol version")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Roth <michael.roth@amd.com>
[sean: write changelog]
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c2126b3c3072..23170b64f4a3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3703,6 +3703,10 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 		scratch_va = (void *)svm->sev_es.ghcb;
 		scratch_va += (scratch_gpa_beg - control->ghcb_gpa);
 	} else {
+		/* GHCB v2 requires the scratch area to be within the GHCB. */
+		if (to_kvm_sev_info(svm->vcpu.kvm)->ghcb_version >= 2)
+			goto e_scratch;
+
 		/*
 		 * The guest memory must be read into a kernel buffer, so
 		 * limit the size
-- 
2.54.0

