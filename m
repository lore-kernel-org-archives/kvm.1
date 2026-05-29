Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99943D50D
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079787; cv=none; b=DLIXkt9oWqRDViz3K7DeBbgd1tti7Y4fSn/M+fchEa4rroBxX1k41lUUKJEYRGNLZwFwK4GPs68mhnFX/J7squrhwuYq1/Dn0WfcvJHxhpDgZiobIOgCzJEc/LPiE2rCNHqNadp+xn38Lvbk1/C47zH7O6UcksjLdbnLNRFiM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079787; c=relaxed/simple;
	bh=m/pvpCaBC3h93498zeO1pRjVuNqRfnOpOUwLMGrQfvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YquxwXtuSdMGP2bOxAUy0jg0itK9hlCJXejWiALLEmsu8uu5dsLpsDJPxou+MVFgdIF6nOUqy6JRDTKCg5F1GoWlZSfQkjwUtROXvs7mdk7z1FWOpy+SQlxGTIZdLQzbKBArIiXKSvlQ7zt5Nt73JHYDzbrs+2EHWxXgmlFt/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdwuQwTn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oeth7Mtq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdwuQwTn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oeth7Mtq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGX8HV+j3qIlq8encb16lzDWVML/br9GjtwZC+22G7c=;
	b=BdwuQwTn71SZdoCB4VRZvcMrVw8AMruWcr9nxBp3RvtqCr2uQ+eXDxDtDgf/cjFn1lBxoh
	aMBAXtcbbn0RjzZdFCbxFMTArF4oYlAfeBLmhG3S8JhXlrGemUz31fMR16EyWCiDp/lyVR
	JtS8g6j+GwUqNQqargyIjK5Fh7JpuDI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-z_fWLPJoPTSL-RMZk9CiAw-1; Fri, 29 May 2026 14:36:22 -0400
X-MC-Unique: z_fWLPJoPTSL-RMZk9CiAw-1
X-Mimecast-MFC-AGG-ID: z_fWLPJoPTSL-RMZk9CiAw_1780079781
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490261c79fcso56608825e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079781; x=1780684581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGX8HV+j3qIlq8encb16lzDWVML/br9GjtwZC+22G7c=;
        b=Oeth7MtqQ8d7pooPKXxivUHDjaKgL6PZexSduurK7Caw2benKFUPGokkkoKJkCMeM4
         Tsr6drZC+iz4CLodNAPCU9aOGuwcLMRiFTqXp5FHuLDm3JbcKG12Pu6D9bK2iXDdGxVe
         yGCN2tt9sV8V2bhbnfKf8mVaefncRdqtHdjlr9LCVpxaug+o+LtWk3nUgs1725fGeAwJ
         0MJqoz7uQtTYn9BRVzeleUXh/9VXVtaJMlfsb2P2LnR2LoO8QWi6hMwAUY36nnFwhUey
         7jWDp0zK5KUJYTI0XZA4ktIUrRBqk+ZHpiivk8S9ByS0CNyN1jzxcIS0TfphSzUFLgFx
         KdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079781; x=1780684581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oGX8HV+j3qIlq8encb16lzDWVML/br9GjtwZC+22G7c=;
        b=jCAMM6qpcH7nuVivGa3pjEi1N4vOC1eqg5DQL5SP+F29jEUuHk8rKicwiJkprQz1ds
         ENXKP7lwFK9V6kmNgaUEi0HhQEzq1Qpw7TbFsi8iTze+e0910FqZA6HjrfFEeNOo1CbL
         UcRpICRsypStmcfQx1VtIDoAEgbqiQ4/ojSRt4io5s5bRSI49iUMl3NiWoZQX53P5JiM
         emSnlG2kPFyDFVjg9eEIMjM1aREZlfv/DiKYG+qTEQwmdZk5f+9BiqaYlc9tRXiqzkzJ
         ydjEQxMUEW9gvyMgTplRkofy2zFPovs36mPS4kjweQ6L8W2ViexXW7r8xQZrZ/kTatQD
         AIdA==
X-Forwarded-Encrypted: i=1; AFNElJ/MMnlaX1CUSkmh/Mz58/us86l7/sxP9ToYfWx2ieM7ZtbmPelXCoGKkrmld3MApQx/xkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMisLroPDKNV/HvfiCC4fajJRfrGptbOTUz7M698pyOEl2nY2
	aQQF4G/qMnf1KsbWW+LZzxKUuuWsd2UzP2wKH2292XKZy0fMpEW8LiY2EDbdy3QPwQieI6VgaMO
	rTCbZoY1wqqX8Ij7W4dNSTMLC1I1/FJOxj8XbxZfz81boTjoXFxKZnRQEl5HpfA==
X-Gm-Gg: Acq92OGeNWqTnhDMcRdsZ7QLrHDgJvu/GrbzRLv08NmAKn47SBZrucpfTDVv+HJpVr/
	I+evefO9g5tIpiT2z37R7H3eF7X/pjna9IekRAnhhGvH/5jo2yyQPjqDgo9tjjq2hV54m8PJZ66
	QZMrLZqeJ3BycWTOV8qrhlKJetW34M7W5iCUHQrcNJhkwUHzXm8E8wKX+r0rdfF6Trkw5MA8Q4n
	UnE8aeToanBaypNso8YuyJznDVcu/dg4dIx2VE9YgbaI8DYUDpBtsRvKydiJzIUzb8d3dke0c+V
	LGbqlkjrRsIRX1gbVKo2h40wZG56HGvhdSGjtvPwjMaZDqzQ99vqUBj/c2AjaMvLJGLFR18gl14
	ZlI8uVcgX+SJJlKgA6Gyx/aZFkqbRjfHVoMqqqH06sYsbFKWuR4/nmuE44tJ7ToFwjf2BBZvtOy
	4SYxevq1TyK3K3SB5wtW+SVC+Qr6spq+g01nHBpA==
X-Received: by 2002:a05:600c:37c3:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-490a2a2713bmr7298385e9.7.1780079781388;
        Fri, 29 May 2026 11:36:21 -0700 (PDT)
X-Received: by 2002:a05:600c:37c3:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-490a2a2713bmr7297935e9.7.1780079780823;
        Fri, 29 May 2026 11:36:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68b853sm59239705e9.3.2026.05.29.11.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH 12/24] KVM: SEV: Add an anonymous "psc" struct to track current PSC metadata
Date: Fri, 29 May 2026 20:35:37 +0200
Message-ID: <20260529183549.1104619-13-pbonzini@redhat.com>
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

Add a "psc" struct to vcpu_sev_es_state to avoid having to prefix all of
the fields with "psc_".

Take advantage of the code churn to opportunistically rename local
variables to "guest_psc" to make it more obvious that the buffer is guest
data, and more importantly, guest accessible!

Opportunistically rename inflight => batch_size as well, because there can
really only be one operation in-flight (per-vCPU), i.e. "inflight" _looks_
like a boolean, but in actuality is an integer tracking how many pages are
being handled by the current operation.

No functional change intended.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-13-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 43 +++++++++++++++++++-----------------------
 arch/x86/kvm/svm/svm.h |  8 +++++---
 2 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 1982d13e71d9..9f6543cebedf 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3845,9 +3845,7 @@ static int snp_begin_psc(struct vcpu_svm *svm);
 
 static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 {
-	svm->sev_es.psc_inflight = 0;
-	svm->sev_es.psc_idx = 0;
-	svm->sev_es.psc_2m = false;
+	memset(&svm->sev_es.psc, 0, sizeof(svm->sev_es.psc));
 
 	/*
 	 * PSC requests always get a "no action" response in SW_EXITINFO1, with
@@ -3860,9 +3858,8 @@ static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 
 static void __snp_complete_one_psc(struct vcpu_svm *svm)
 {
-	struct psc_buffer *psc = svm->sev_es.ghcb_sa;
-	struct psc_entry *entries = psc->entries;
-	struct psc_hdr *hdr = &psc->hdr;
+	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
+	struct psc_buffer *guest_psc = sev_es->ghcb_sa;
 	__u16 idx;
 
 	/*
@@ -3870,14 +3867,14 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
 	 * corresponding entries in the guest's PSC buffer and zero out the
 	 * count of in-flight PSC entries.
 	 */
-	for (idx = svm->sev_es.psc_idx; svm->sev_es.psc_inflight;
-	     svm->sev_es.psc_inflight--, idx++) {
-		struct psc_entry entry = READ_ONCE(entries[idx]);
+	for (idx = sev_es->psc.cur_idx; sev_es->psc.batch_size;
+	     sev_es->psc.batch_size--, idx++) {
+		struct psc_entry entry = READ_ONCE(guest_psc->entries[idx]);
 
-		entries[idx].cur_page = entry.pagesize ? 512 : 1;
+		guest_psc->entries[idx].cur_page = entry.pagesize ? 512 : 1;
 	}
 
-	hdr->cur_entry = idx;
+	guest_psc->hdr.cur_entry = idx;
 }
 
 static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
@@ -3898,10 +3895,8 @@ static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
 static int snp_begin_psc(struct vcpu_svm *svm)
 {
 	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
-	struct psc_buffer *psc = sev_es->ghcb_sa;
-	struct psc_entry *entries = psc->entries;
+	struct psc_buffer *guest_psc = sev_es->ghcb_sa;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
-	struct psc_hdr *hdr = &psc->hdr;
 	struct psc_entry entry_start;
 	u16 idx, idx_start, idx_end, max_nr_entries;
 	int npages;
@@ -3928,7 +3923,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 
 next_range:
 	/* There should be no other PSCs in-flight at this point. */
-	if (WARN_ON_ONCE(svm->sev_es.psc_inflight)) {
+	if (WARN_ON_ONCE(svm->sev_es.psc.batch_size)) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
 		return 1;
 	}
@@ -3938,8 +3933,8 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	 * validation, so take care to only use validated copies of values used
 	 * for things like array indexing.
 	 */
-	idx_start = READ_ONCE(hdr->cur_entry);
-	idx_end = READ_ONCE(hdr->end_entry);
+	idx_start = READ_ONCE(guest_psc->hdr.cur_entry);
+	idx_end = READ_ONCE(guest_psc->hdr.end_entry);
 
 	if (idx_end >= max_nr_entries) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
@@ -3948,7 +3943,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 
 	/* Find the start of the next range which needs processing. */
 	for (idx = idx_start; idx <= idx_end; idx++) {
-		entry_start = READ_ONCE(entries[idx]);
+		entry_start = READ_ONCE(guest_psc->entries[idx]);
 
 		gfn = entry_start.gfn;
 		huge = entry_start.pagesize;
@@ -3981,7 +3976,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 		 * for READ_ONCE() as KVM doesn't consume the field, i.e. a
 		 * misbehaving guest can only break itself.
 		 */
-		hdr->cur_entry++;
+		guest_psc->hdr.cur_entry++;
 	}
 
 	if (idx > idx_end) {
@@ -3990,9 +3985,9 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 		return 1;
 	}
 
-	svm->sev_es.psc_2m = huge;
-	svm->sev_es.psc_idx = idx;
-	svm->sev_es.psc_inflight = 1;
+	sev_es->psc.is_2m = huge;
+	sev_es->psc.cur_idx = idx;
+	sev_es->psc.batch_size = 1;
 
 	/*
 	 * Find all subsequent PSC entries that contain adjacent GPA
@@ -4000,14 +3995,14 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	 * KVM_HC_MAP_GPA_RANGE exit.
 	 */
 	while (++idx <= idx_end) {
-		struct psc_entry entry = READ_ONCE(entries[idx]);
+		struct psc_entry entry = READ_ONCE(guest_psc->entries[idx]);
 
 		if (entry.operation != entry_start.operation ||
 		    entry.gfn != entry_start.gfn + npages ||
 		    entry.cur_page || !!entry.pagesize != huge)
 			break;
 
-		svm->sev_es.psc_inflight++;
+		sev_es->psc.batch_size++;
 		npages += huge ? 512 : 1;
 	}
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a10668d17a16..06192bc9c107 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -257,9 +257,11 @@ struct vcpu_sev_es_state {
 	bool ghcb_sa_free;
 
 	/* SNP Page-State-Change buffer entries currently being processed */
-	u16 psc_idx;
-	u16 psc_inflight;
-	bool psc_2m;
+	struct {
+		u16 cur_idx;
+		u16 batch_size;
+		bool is_2m;
+	} psc;
 
 	u64 ghcb_registered_gpa;
 
-- 
2.54.0

