Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B8421A07
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079782; cv=none; b=jl3U2Cj+2iJgAW2qhTwgFE0fPquBwqMwvWFs5W+sNS3CY/IGIfycNucrDJA1FIN6UeT60XiIm7uUF6mIkDmViA/Fbj0oZpNl5NqyvAo4mXobtTUNkU7ILZ0Y2HlzeL5TwwxDEowbys9TvKe2pxHeMgvcHgqvYTiStfhYrQsUN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079782; c=relaxed/simple;
	bh=Rdf4N65bOt7x8Nwrw5ueMoXtOuEXS+ZMINlCI3t8Sys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VF/k+iJyew1x4glhnJ9JovF/iN+O+x5UXuGXyHj8auCvWcPSlpvIc+ARTKZJv1DBoqnb0GdG5wmkYd8rq/NO54BF4wpa1Yqp2Fxm5P0GKYzAEgqpgNzB0M+wZiiwBbPh+4APBasyAbpl5vSYSBHA+7CNVPY7EGPOKGWgZT6L8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NS3CCaR2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hIeMoaCF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NS3CCaR2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIeMoaCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6iAVB9mfQ/7q9K71+HvMK+Lw89cTkPEsSBKbCzolaQ=;
	b=NS3CCaR2ZKJuseoQckyxLIBqeLvuHYCShMUyvIv/cMfwaR8nStxyJ51OF6YV7qkveUeuPE
	9lBM9LqWmCg3+Igyc3eN9xam0oZQSmvsyj37KAebtadRW9vVzFyXzImxuH51A53T+RvEYV
	g3xdQ3qy43TXx2B1fT+dwCfmKTYsJ6M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-ZCMauU_7PZOX93UNvW6ghw-1; Fri, 29 May 2026 14:36:16 -0400
X-MC-Unique: ZCMauU_7PZOX93UNvW6ghw-1
X-Mimecast-MFC-AGG-ID: ZCMauU_7PZOX93UNvW6ghw_1780079775
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49058295985so43197135e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079775; x=1780684575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6iAVB9mfQ/7q9K71+HvMK+Lw89cTkPEsSBKbCzolaQ=;
        b=hIeMoaCFudUrTMHCPGwG+QndgOsetPGNO8qbXkR91riPOic+wxJnAOu5qOa0GG/dBO
         LZgRoXg7GIfXhFAmMzwgAsojlnrGvImh2/VZTGmGU48rB+tE4vKA/+ekFd5VRKSz0wNL
         4rZxex9GMu9Uz/y1TEaratSKS/faooYyuku46BRZCOS2Ly527X0PL9t7iAeOI1GIlx8l
         xER4arrSzTHuk18kJiUZb1Js2tvykIfRSA63ezctGCCRYJ0k/HUUzPfD4l444/elyTa/
         MesRxhpJKCP47xwrvTP3QEdX0iLB+jp1U02LepTltRgga2Dmot59YeFmoDxyaW7wplp5
         +h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079775; x=1780684575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S6iAVB9mfQ/7q9K71+HvMK+Lw89cTkPEsSBKbCzolaQ=;
        b=ULAwEi2Lyum3ZgQyN7icf7fFR8PciR7GjrozIjGpo0vEnD5z8ooUVk5nx0Fg78Hz2w
         zvD1vFkXgqNuRIgNLGez3XCFJZ/miRpWi72zz3EGDAEsQwiDbdw5yWf8OgBbsPD9liB9
         Cb2XKW8XyOiAxuwxLxYOf6elKozFuNGiQJCUwYJPJE/gn4tMEvIFmfnPp2kkt07QOsJ7
         Feyuf+y3TN9Tb4bpvzX+dWMsp6Sh0nSfqfWlt5qXLU6KKe1GQDQkCSznqx62ToOsUS/M
         qKT/oFwtM5pjgXAygK/BYTFOZyvsLCjW8whbh/u5Md+b5ZBpM338JIP/sDC5igV/2a5z
         CpYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jfjvwcN9u9en0RT71fU1T5nexSNU9jzCcxq8VHXkV3ZJYfhOYXwMPMmsOCNPEUqweWw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyMXEx3VinVXfDLUYmMeAkxfk89tUAoXqM1MeidtzAXM/LNV9m
	LEaNRg28cslhEMlX42XW+UeBVqC4pnWIivTjeFR93Hcbv5dK9bgokZFKiMB6Cr+ryGj/z1Zf3po
	cQp5217e/MCKIoytlLxXxbuUEaQAWzGYzJm0k2g7sPoyv9b6f8w1Nmg==
X-Gm-Gg: Acq92OGfwrGKBSRPPyfAo4szuX1FpUk7BcQfni6tM99pK1/aKQYgEwYCIRf1CVuIfJ5
	fVyBfTXttbWc9ek5to/0AXNQN7xj7Ji1biSVKWYj/TrYTaYgYu99af2+nX8uOgK8W0TxK6lmoDp
	m4WVBiJyNPInl3LpOgwNbyOE1UZwHuG+xb32ULYR9q/wVLEQHbb92t2QywAdLadlYYFFi1goLpL
	moWoNxWjRnMo2Jc9lNCHBPIzViLrLnt2LxGal87jxacIoLmYs2zmMjFvPLzrU2KiNvR9P4R+j08
	KTjHbL7rDIggl0DFm/FAOHUJ/eljMKYifOjdHSLu75XkI7+x3qKNNFpBoEXN94gG/NK7SRsSBPs
	ynz6WYGwVT8dZOOE8EqNJgtzcAK18BNVQijM391xg7oNuTyoGWGmODhEvcw90GBYkTsVlii8E8D
	P8o6yt4TrSintFLEANtSAR/Dis/Z3/UzmZUklX/Q==
X-Received: by 2002:a05:600c:3b14:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490a2904d7fmr14591345e9.7.1780079775212;
        Fri, 29 May 2026 11:36:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3b14:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490a2904d7fmr14590955e9.7.1780079774772;
        Fri, 29 May 2026 11:36:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c110243sm29636005e9.6.2026.05.29.11.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 10/24] KVM: SEV: Use READ_ONCE() when reading entries/indices from PSC buffer
Date: Fri, 29 May 2026 20:35:35 +0200
Message-ID: <20260529183549.1104619-11-pbonzini@redhat.com>
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

Use READ_ONCE() when reading entries/indices from the guest-accessible
Page State Change buffer to defend against TOCTOU bugs.

Don't bother with READ_ONCE()/WRITE_ONCE() for cases where KVM is writing
(and not consuming the result!), as the guest isn't supposed to touch the
buffer while it's being processed.  I.e. using READ_ONCE() is all about
protecting against misbehaving guests.

Fixes: 9b54e248d264 ("KVM: SEV: Add support to handle Page State Change VMGEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-11-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6e8cbae2135a..62b5befe0eed 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3872,9 +3872,9 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
 	 */
 	for (idx = svm->sev_es.psc_idx; svm->sev_es.psc_inflight;
 	     svm->sev_es.psc_inflight--, idx++) {
-		struct psc_entry *entry = &entries[idx];
+		struct psc_entry entry = READ_ONCE(entries[idx]);
 
-		entry->cur_page = entry->pagesize ? 512 : 1;
+		entries[idx].cur_page = entry.pagesize ? 512 : 1;
 	}
 
 	hdr->cur_entry = idx;
@@ -3938,8 +3938,8 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	 * validation, so take care to only use validated copies of values used
 	 * for things like array indexing.
 	 */
-	idx_start = hdr->cur_entry;
-	idx_end = hdr->end_entry;
+	idx_start = READ_ONCE(hdr->cur_entry);
+	idx_end = READ_ONCE(hdr->end_entry);
 
 	if (idx_end >= max_nr_entries) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
@@ -3948,7 +3948,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 
 	/* Find the start of the next range which needs processing. */
 	for (idx = idx_start; idx <= idx_end; idx++, hdr->cur_entry++) {
-		entry_start = entries[idx];
+		entry_start = READ_ONCE(entries[idx]);
 
 		gfn = entry_start.gfn;
 		huge = entry_start.pagesize;
@@ -3992,7 +3992,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	 * KVM_HC_MAP_GPA_RANGE exit.
 	 */
 	while (++idx <= idx_end) {
-		struct psc_entry entry = entries[idx];
+		struct psc_entry entry = READ_ONCE(entries[idx]);
 
 		if (entry.operation != entry_start.operation ||
 		    entry.gfn != entry_start.gfn + npages ||
-- 
2.54.0

