Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9609442EEDE
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079781; cv=none; b=ugxLuq28L6siI9CCoSRLOorYDKZsmU6I11XkiMJUr6A2Csa6rwMK9b9OXhClTCkVNLH/VaIv2vSvqbXoSq7q8tmV2npJ1SNKRqVb9xDL5FaMDkf+VtRq8HUR/v0xgyUO+4KHchiinU7SIiNqN4/PcvIdR2D47Hgo+k34FudJBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079781; c=relaxed/simple;
	bh=ocrp7UiS1WanCwFhsgzTGR2ip9lAk7udP5dDEIw2HFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S20N6JdO6b4WllI3Yg1h7Mxhfh5v8ex55A3ZMsKwQOWmtuTPilB4K93CPImpWpVKRmfFIJiKCIgptca2pFbVbYOOTpN9aOY9hkle148oXlB45WY70/lPfzKmz69eYmd86ttHXNq7U3eYvet7W4BM8zwZW81isHIFpjPx8po4ZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+qttPKx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGH+xCF4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+qttPKx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGH+xCF4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ku/ngyswLIZ+ZhY/zg7dChYo6WlT7EL2y3Avs5NIsP0=;
	b=e+qttPKxT3DW7pTEWTJxL80biBALNS+OPOwi84PGMCjZZOVyz2c2jMAZXtDuTzOkUvcqx0
	dnIZhHpy4jeKlGsV6OniCCfc7AZ5pdGKlaTS8H93ZlLRME6SfW/3FilKX4GZknevqaXSpo
	OJ0NQ8++qG976U/nej7zxP8JaPqSm6k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-XLmLXq-jO9-2WF_-cRDZuw-1; Fri, 29 May 2026 14:36:14 -0400
X-MC-Unique: XLmLXq-jO9-2WF_-cRDZuw-1
X-Mimecast-MFC-AGG-ID: XLmLXq-jO9-2WF_-cRDZuw_1780079773
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45e7c7289c3so11184426f8f.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079773; x=1780684573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku/ngyswLIZ+ZhY/zg7dChYo6WlT7EL2y3Avs5NIsP0=;
        b=NGH+xCF4jFJnHxhlOunyscmGKYEc7DaPRYcJnSW9J5nzB04PqiFqprrTaTDMB/6Xyw
         9frEclL06kyjdRtgzhiNPBgtsSEOulkatCPrxI08ETs+Hyuu4CSFS/XAELyfBnWJcbwc
         rBZyE0TjD4eCGbtPxFkGLPCcZpkWgv2r8E4f5MtG1Zp4zcyVzvTQitjWoOFKkWAJZUip
         dk0MsMY+kkWj+4A0zXxx8H0SGqTtvyakYWqg9O9DG7XaCjaRb0oKpAZH2eLXo5VZnvAd
         Hl6UKNnLog8kcp5XMUHW7nRLXL29XblFZkb8NLbPAksgqX4ara1kJ8CItlwOVb6Nbzfh
         xNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079773; x=1780684573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ku/ngyswLIZ+ZhY/zg7dChYo6WlT7EL2y3Avs5NIsP0=;
        b=Duf1Dbue1mUpTA4BXsY+mb+mij1BCU3Sd83Rqx8CAtKQa59t88cZkSwYTHDj6U8ksA
         ULYSN0WnWF1MSyGO9XZtF6VnKZUICzloLW5bjjmmx+ZIgMBTmqcPCC0s+acVBJUTe5S6
         ee33nQnmeDum7TH4fRbdUK+I1ayXEqy8+gMqFLYnzYJbxZV7sIPEd2SZT+6Y+KP3MfPm
         SZASnCy+3fPl4qvpmiUoveBhdeaTZ9YfGq7iGzYF+Fj+VRGdexo2Dm6z0Haif+7EmPGk
         TDI/Vco1Br52oA+n/bf3iXqD6Z5LSYuB3Qcbih9cB8H0LmeJ+sCNNyW6dqW08vsbtwCN
         8NOQ==
X-Forwarded-Encrypted: i=1; AFNElJ99cWkkDt5ViGbunwUwcp+Oz2f3OQW9bAKBh8eAC9FOl0QfvFID51mozCNA0sJ3TiWNcuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1MzzVjlrk/mZTDfdWwk7JWKSghNSUkwjxTZrAnLzqql04a51
	SOXvDAetBnoW3T2FJBE5SsNYRTS5wkmZDLPtIEppoaMEabz0U02h/TouRC4fNb3f1cV4L8c83O3
	Rlxkx8/YMDtYRslEjiFEJYWeVjyiezJL0SVcxQ16pIomgAdhEovc2fIa3KNgDww==
X-Gm-Gg: Acq92OFXNbVFsfEIW6/fjax7VjDgiTew6k4gnTvLb0nhZ+cjOHxAVUt+xcdZJFy6LH3
	zPfuGiHjXZfIMmitEB2nGdjp73VsR5hvGcV6kAWjwscptuhvwpHVX4ljRjpO+xWJCgviPBYi1RV
	IyhD1medK1mkFz3iyNvlB5e3ALaPcLM1QSZsW+JTbgyJ4SR3rfA5caXaUUwkQljATwkcoDpQ9c7
	LGZH5xpgj47LdXZs3+FMCdii1HyqowQUL2DnUrIwY853uBMwsTd3EI04hRLag1DnDb8zXe/dSdO
	SWWd/KkI5cyYuF99+RMgwevZAWww6uALZJbBXjRt9mEsiG5kStgnNmNvPba6fYtOaTK+qZuXY49
	Tru4S0Ja/n4/6wCebz6sAgrc2Ewx+GgjwTCxBTTakVdmWrkrTiGayso+63DY3265G/IMpDvfHHA
	y2EacxnxtsbAoRseBnCo/ewa0bn7f9GZEuwDpYSg==
X-Received: by 2002:a05:6000:40c5:b0:45a:5392:3a19 with SMTP id ffacd0b85a97d-45ef13794fcmr7447995f8f.16.1780079772771;
        Fri, 29 May 2026 11:36:12 -0700 (PDT)
X-Received: by 2002:a05:6000:40c5:b0:45a:5392:3a19 with SMTP id ffacd0b85a97d-45ef13794fcmr7447963f8f.16.1780079772417;
        Fri, 29 May 2026 11:36:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354b7edsm5207945f8f.22.2026.05.29.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 09/24] KVM: SEV: Check PSC request indices against the actual size of the buffer
Date: Fri, 29 May 2026 20:35:34 +0200
Message-ID: <20260529183549.1104619-10-pbonzini@redhat.com>
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

When processing Page State Change (PSC) requests, validate the PSC buffer
against the effective size of the scratch area, which could be less than
the maximum size if the guest provided a pointer that isn't exactly at the
start of the GHCB shared buffer.

Fixes: 9b54e248d264 ("KVM: SEV: Add support to handle Page State Change VMGEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-10-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 8577451b82b2..6e8cbae2135a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3903,7 +3903,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct psc_hdr *hdr = &psc->hdr;
 	struct psc_entry entry_start;
-	u16 idx, idx_start, idx_end;
+	u16 idx, idx_start, idx_end, max_nr_entries;
 	int npages;
 	bool huge;
 	u64 gfn;
@@ -3913,6 +3913,19 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 		return 1;
 	}
 
+	/*
+	 * GHCB v2 requires the scratch area to reside within the GHCB itself,
+	 * and PSC requests are only supported for GHCB v2+.  Thus it should be
+	 * impossible to exceed the max PSC entry count (which is derived from
+	 * the size of the shared GHCB buffer).
+	 */
+	max_nr_entries = (sev_es->ghcb_sa_len - sizeof(struct psc_hdr)) /
+			 sizeof(struct psc_entry);
+	if (WARN_ON_ONCE(max_nr_entries > VMGEXIT_PSC_MAX_COUNT)) {
+		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
+		return 1;
+	}
+
 next_range:
 	/* There should be no other PSCs in-flight at this point. */
 	if (WARN_ON_ONCE(svm->sev_es.psc_inflight)) {
@@ -3928,7 +3941,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	idx_start = hdr->cur_entry;
 	idx_end = hdr->end_entry;
 
-	if (idx_end >= VMGEXIT_PSC_MAX_COUNT) {
+	if (idx_end >= max_nr_entries) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
 		return 1;
 	}
-- 
2.54.0

