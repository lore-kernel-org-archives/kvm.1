Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ABE4418F0
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079792; cv=none; b=FyUJKzvCdhg9yK83fliiytvq0wT/TQiypRr1Rz4T4/Owwq8uGupgHqJRsIIeMwA78cK4B8kzLYfX7KH4oLV/KbrdvsgdCaCs2RsHHxakG3YCERJqKSmQcj7DYxR80zU/qiLuVTsQrRRxnsB9ZsOUsNRgY+zB52y3bWRTGEWEPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079792; c=relaxed/simple;
	bh=ALykjJLg0jwTLlECqz7GyV15Ngx/tKSeHMUCtZHEuSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQIsMkFLTpTrvptjCST8SQGLB3htAK5PHFYmHCZtzP7UvXowo1fAcZAPfmu1RFVUZ+02YZHdhOhnd9vq/0Lu2okocy/fCdZ86WvnXDFABH/XmfGZM8IhlfeQ0I+/pz/1mfJZKsVrPvms1+xfnmMxRQvmwVnrGPnFo1TuX8cpYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jcup0MWs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjVlU2AJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jcup0MWs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjVlU2AJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47mo1Ny6jZGBCjDoJJxdvUaA6xkQu52qjPdgKSzkiu4=;
	b=Jcup0MWsTOcMFZvN7ajxQwuvLHbqwPJqQ3dmhRl5meT1qbGLs0NI2C7XIMxlcCw4JZfyBA
	BZBQcbAIMXjtDAziKaMaZxgez7KVBWqHIxH3bFrfAUHLCOt0DA/ZUpuyzfYFyHfwh/3Nsq
	30Z9lot/zMoZgf8njayOJq7q6bYtLBI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-bOnAE75LOkmAXuxRKXuIiA-1; Fri, 29 May 2026 14:36:27 -0400
X-MC-Unique: bOnAE75LOkmAXuxRKXuIiA-1
X-Mimecast-MFC-AGG-ID: bOnAE75LOkmAXuxRKXuIiA_1780079786
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45e2f74da10so12866905f8f.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079786; x=1780684586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47mo1Ny6jZGBCjDoJJxdvUaA6xkQu52qjPdgKSzkiu4=;
        b=cjVlU2AJPFnG3Pkws83xefQGcA/95z38aRVYiuvC16ksvL8hJxI7/gVEUCNXASAIwY
         7WTg4mvIzSWuJwhi3+1q91jwMJMX/5P3bKvs/rp5xlddL//+m8uKrAvuivquc1k32C6S
         cQWyK9C9Y0XF+RQHwAj3PtsEI9CWdzqKe0McNeWwm1xqJomERuLmzttbFa8DfshDnNk4
         DmM2iot9nOJ9rglJ0g2P4dNFeimOv+mHIXuaCLJJ51RsGK+8pjZR1KdBCwPIUOzV+95B
         aK8FwomIuhTW0HxrWH5/e/8hJzV/JxUiMtQ6609zy578obIEAOs1VTohsM+HIp+OnMr5
         wdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079786; x=1780684586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=47mo1Ny6jZGBCjDoJJxdvUaA6xkQu52qjPdgKSzkiu4=;
        b=f2c263M/i6SHhZriR5afEUlhcokKFc7JE6njJ4Ajazgq2Q38c5SixuepqtNXTNi9Ld
         py2XMTKJnOzq6eYeoauVnsEJ73qMauqclerT3a9ek0LuXZydBCW5jz4blFYusXOT5oCm
         K3gGXB8TUBJn8JRrTxAeTr+C0SPt+JADgZ5HiYc2WO4DU11cIhKQ/IDfjKlM1etrNvAA
         flK5TCe5AFoanT8vQGKtyaufM/ZOzf+0tU1b2Ih3zwJAiILbOylKBrUWLBjlCdhcQ+yK
         qjQBpTPcKx/bElorPNF7Gd9A/8rdwF+D/meEwILzRZgk9h8XrYHt8JRGiCr/refDhHm+
         xkJA==
X-Forwarded-Encrypted: i=1; AFNElJ+9Q/pOJVc4Qkw+rnDe6IXpR6QNkIXuxoFUNLVFpQgDeGcUy7I+HJNp6xvrkrnRSUUvQRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8mV2r5vYgdgO41WXcR7cq1hu39Gx/ceg5wfGGwZCa7Hd2UWva
	sIkKdNiIq1w3/OYkcQZK1+Dyw1zIH7AUZmnmXz/yobcT1EjWHEEDicYf69Od3NpEHMztNpXrJi3
	EoqJcvQe7hXGPv+5cpHHgMxMaBIuY0vT7hc/0WJbYMhV6t+t32xqfFw==
X-Gm-Gg: Acq92OEWYqdLY37SOGfHG7SOf3zECpdbPg3wCrEBQT7DgKLlJ9LJC7tZC5DRKnvXnsD
	XiTF6+NKu8iIsB8IPgk7zS1BLQexs5nsxg36Llf3uAB2LQ7oMTEh7aHUxEqG5tFCBVqSS1TyCMW
	v+IYlCdxlg30IFp/nxqUbkiNdMUtAVqy1hVdKzEQDsTfZ2vEKVyNnQqlEGMWyVJrL6jmZTLh2ww
	qLV2VV4LgcUA489ixZjn+TzO1SbQvcymH+1ZWhCV8IKvqZe+4OaqsJtEkCxbTWzedZV3FTeKVcl
	ehhkdqWtffsDnI5wRA0nBnDI3G2ZHBxsGavCSliX8DlKfrGfiebmXrxvDF6SrllycXC2YzUq3/M
	j9C7prHtGEGIsaFreZa6I2sLCrfKi1wKm+jeCoR6qyeJvGdHr7JYv3OF7zr1HYdQGzn7hUOEfsS
	WbU+p8JquC+o1h8a4L4zDqAtFPGYb722TUWG749g==
X-Received: by 2002:a05:600d:8498:20b0:490:484b:bf41 with SMTP id 5b1f17b1804b1-490a2923b7fmr10955365e9.6.1780079786022;
        Fri, 29 May 2026 11:36:26 -0700 (PDT)
X-Received: by 2002:a05:600d:8498:20b0:490:484b:bf41 with SMTP id 5b1f17b1804b1-490a2923b7fmr10955055e9.6.1780079785646;
        Fri, 29 May 2026 11:36:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca72cfbsm62005255e9.8.2026.05.29.11.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH 13/24] KVM: SEV: Read start/end indices of PSC requests exactly once per #VMGEXIT
Date: Fri, 29 May 2026 20:35:38 +0200
Message-ID: <20260529183549.1104619-14-pbonzini@redhat.com>
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

Rework Page State Change (PSC) handling to read the guest-provided start
and end indices exactly once, at the beginning of the request.  Re-reading
the indices is "fine", _if_ the guest is well-behaved.  KVM _should_ be
safe against concurrent guest modification of the indices, but there is
zero reason to introduce unnecessary risk.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-14-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 86 +++++++++++++++++++++++-------------------
 arch/x86/kvm/svm/svm.h |  1 +
 2 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 9f6543cebedf..4ebe0d449789 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3841,7 +3841,7 @@ struct psc_buffer {
 	struct psc_entry entries[];
 } __packed;
 
-static int snp_begin_psc(struct vcpu_svm *svm);
+static int snp_do_psc(struct vcpu_svm *svm);
 
 static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 {
@@ -3874,6 +3874,7 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
 		guest_psc->entries[idx].cur_page = entry.pagesize ? 512 : 1;
 	}
 
+	sev_es->psc.cur_idx = idx;
 	guest_psc->hdr.cur_entry = idx;
 }
 
@@ -3889,37 +3890,19 @@ static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
 	__snp_complete_one_psc(svm);
 
 	/* Handle the next range (if any). */
-	return snp_begin_psc(svm);
+	return snp_do_psc(svm);
 }
 
-static int snp_begin_psc(struct vcpu_svm *svm)
+static int snp_do_psc(struct vcpu_svm *svm)
 {
 	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
 	struct psc_buffer *guest_psc = sev_es->ghcb_sa;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct psc_entry entry_start;
-	u16 idx, idx_start, idx_end, max_nr_entries;
 	int npages;
 	bool huge;
 	u64 gfn;
-
-	if (!user_exit_on_hypercall(vcpu->kvm, KVM_HC_MAP_GPA_RANGE)) {
-		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
-		return 1;
-	}
-
-	/*
-	 * GHCB v2 requires the scratch area to reside within the GHCB itself,
-	 * and PSC requests are only supported for GHCB v2+.  Thus it should be
-	 * impossible to exceed the max PSC entry count (which is derived from
-	 * the size of the shared GHCB buffer).
-	 */
-	max_nr_entries = (sev_es->ghcb_sa_len - sizeof(struct psc_hdr)) /
-			 sizeof(struct psc_entry);
-	if (WARN_ON_ONCE(max_nr_entries > VMGEXIT_PSC_MAX_COUNT)) {
-		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
-		return 1;
-	}
+	u16 idx;
 
 next_range:
 	/* There should be no other PSCs in-flight at this point. */
@@ -3928,21 +3911,8 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 		return 1;
 	}
 
-	/*
-	 * The PSC descriptor buffer can be modified by a misbehaved guest after
-	 * validation, so take care to only use validated copies of values used
-	 * for things like array indexing.
-	 */
-	idx_start = READ_ONCE(guest_psc->hdr.cur_entry);
-	idx_end = READ_ONCE(guest_psc->hdr.end_entry);
-
-	if (idx_end >= max_nr_entries) {
-		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
-		return 1;
-	}
-
 	/* Find the start of the next range which needs processing. */
-	for (idx = idx_start; idx <= idx_end; idx++) {
+	for (idx = sev_es->psc.cur_idx; idx <= sev_es->psc.end_idx; idx++) {
 		entry_start = READ_ONCE(guest_psc->entries[idx]);
 
 		gfn = entry_start.gfn;
@@ -3979,7 +3949,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 		guest_psc->hdr.cur_entry++;
 	}
 
-	if (idx > idx_end) {
+	if (idx > sev_es->psc.end_idx) {
 		/* Nothing more to process. */
 		snp_complete_psc(svm, 0);
 		return 1;
@@ -3994,7 +3964,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	 * ranges/operations and can be combined into a single
 	 * KVM_HC_MAP_GPA_RANGE exit.
 	 */
-	while (++idx <= idx_end) {
+	while (++idx <= sev_es->psc.end_idx) {
 		struct psc_entry entry = READ_ONCE(guest_psc->entries[idx]);
 
 		if (entry.operation != entry_start.operation ||
@@ -4044,6 +4014,46 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	BUG();
 }
 
+static int snp_begin_psc(struct vcpu_svm *svm)
+{
+	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
+	struct psc_buffer *guest_psc = sev_es->ghcb_sa;
+	u16 max_nr_entries;
+
+	if (!user_exit_on_hypercall(svm->vcpu.kvm, KVM_HC_MAP_GPA_RANGE)) {
+		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
+		return 1;
+	}
+
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
+	/*
+	 * The PSC descriptor buffer can be modified by a misbehaved guest after
+	 * validation, so take care to only use validated copies of values used
+	 * for things like array indexing.
+	 */
+	sev_es->psc.cur_idx = READ_ONCE(guest_psc->hdr.cur_entry);
+	sev_es->psc.end_idx = READ_ONCE(guest_psc->hdr.end_entry);
+
+	if (sev_es->psc.end_idx >= max_nr_entries) {
+		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
+		return 1;
+	}
+
+	return snp_do_psc(svm);
+}
+
 /*
  * Invoked as part of svm_vcpu_reset() processing of an init event.
  */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 06192bc9c107..5137416be593 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -259,6 +259,7 @@ struct vcpu_sev_es_state {
 	/* SNP Page-State-Change buffer entries currently being processed */
 	struct {
 		u16 cur_idx;
+		u16 end_idx;
 		u16 batch_size;
 		bool is_2m;
 	} psc;
-- 
2.54.0

