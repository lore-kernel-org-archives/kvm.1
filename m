Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3FA44BCAE
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079800; cv=none; b=RCQuNG8iXUJwB3zWuQWTwowvnzH9o1fPbLJiwDNkNhzNYgq+B5UZ05uRm3jAbebO+jAU60jbf+oPHwzWoModZw619Y9vb+jDgbrFwE40LHjV+lXX0HIfhGb/ycHpKYFY/Fa4Gm+ie6uJ1jvTxHpQXWRHTsWYKDCshdiV1lmcuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079800; c=relaxed/simple;
	bh=HFan/JApmEWnmTSuXMk9cfG+lv/KHWfT+K+r0sq3rN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwEwXDkKrryWAgEAnYnk3Z1kzrQqFJsAKg5rmfVxZ/i6CvUZG26T3tvgFn9iP4irEx09fk3W89KpCiec+VvlknqKcOJAe+vdTwGg1HemAM/HLEJlP2A3mhvlnq+59VV5nhrr+WillQGkuHDWQJzAzVJKDjD2LmuGwqiMY0tKTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXGGkklJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/qGFlu/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXGGkklJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/qGFlu/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgVglsrid7Bemu25RQaHLDDenSgALocYZBi9heN+Y3M=;
	b=WXGGkklJacmAJy7kaqkoU72tx8MiHf57WEkuCiLyvDBupys6JyS9Rna2A+ewyttHN8ZGZK
	tHXlDM1tdFoNiS7tcHCk9EGgmTIQsbKvZXEilKUGqlqt5k29MbTnZPr43Em1i4s2+FylPf
	MwYOXRmwCjZZ/jgzzU35hTEcFOCu1+4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-2MaL-1W5N7WbrMK_Vzn_Pw-1; Fri, 29 May 2026 14:36:34 -0400
X-MC-Unique: 2MaL-1W5N7WbrMK_Vzn_Pw-1
X-Mimecast-MFC-AGG-ID: 2MaL-1W5N7WbrMK_Vzn_Pw_1780079794
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef0af9517so891529f8f.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079794; x=1780684594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgVglsrid7Bemu25RQaHLDDenSgALocYZBi9heN+Y3M=;
        b=U/qGFlu/GNXkfTSuhY7P6KYkCDcvglHTPmhF5Z3ANAfSCTfVL+gP4Lh4Kyx7bAReM9
         ElLpHWc+4f7Ghsda6UFXFa3IV2gnotG7EnDNXtTD0BGc7umwjZbGEBOdMKGrx84UvMv3
         tb3QrOSb8VndAGitzUcwnYbW5xWXHt54uwRcWh+WFdPeFxJs2+AwEOTPLABZipSOgOc+
         AjT+tBk2SJf7/7GsHSu+RZHcsHuNIhSFxeDTnfIpRdRGiRF6RjcaTwYdcXRsUzdC4TbI
         kKPAjabXrQg7IEcC9dVjCkPuEehysplSQrmOy33KJRr+H1yPQEiO5UND/TPl8aovp0FM
         9wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079794; x=1780684594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JgVglsrid7Bemu25RQaHLDDenSgALocYZBi9heN+Y3M=;
        b=rhrlGH8QG7y8rvAH3EhghYXzUwhEuPN4waG7g7hxfOrvDKPxdULXx3qEXC86KLmRel
         trN95WAg+K/TSOLJo2WjA63B8slVQPI+tFHp1FTQMFMJTydk/f2k3Tm7tyke5PiHR0Qw
         VqYoY5uV4HuQY2MqZYOajn8uVBs9I5mhgs7ZtqmjWEY0QOqf/V3IIOCpwPpHuA7vjzJU
         zOB8EkAZ8HCDHQ+lDpmxA/ZU7MkJyQVSdM49fzAzVbFhf3i5/OWZ6y3ndmcjJq8XoGI0
         sTyE9zXSbznch0aqFbVBSdsKRcV3sVnKrPyXF0iWAXS006eK7YaWmVVeYDi0L1yDq9pY
         GUSg==
X-Forwarded-Encrypted: i=1; AFNElJ/7JGRllSMLyUbseGpAEG0jxBWFmXD2ciLG/qrRki4BjWthq1Rgxc0eEMuDo9c4N6M1a6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9/61VegbeAclahfmlgwN/F9nliZKuaJ+9dZH3E87Yu3fCTuX
	V8cAN5gyDmUfDBIYiqnV7LEw/AUzi3t3Xv5TJMOpExb2B5riEgZgAPpO7RX7WLKAt+PxjgEgZ2w
	gRYSf4M4eQyfVmp8nmexVS5CmlOY8/58u9a4FEesAuOa5BTnT9tSnJw==
X-Gm-Gg: Acq92OH11/z2Q47+Qj8PnUM5fDzTy23ovfZ+VDlIW2mQgEGPJpteq13jzx/p11reV7p
	mszg5sRKwLSEGh3oOFd1DW3saur7WwKtsjokPxwhn8AEj8ocMyuafCo/Uk5lsrYt9od/sHbdj/6
	NgyHUHYJyhM63xHATeXUbWON5d66+nN4rHUSK5VVl0ns8aFZfS06KGzaA6Yjs6hXE40inGBNth2
	PMZN0LJ57iFbuRHSaj3XEP/rxGe87TK6Wffb8/UaH+oRTu0JGNE+PhpZDTzcwUpLhUuBgbbZOfW
	EpxzKkY3Oc5VEy1+UimCVQoBUepSoYl7TNOiiaIzELLvEz3isnF/PzbaIq1Rqo+LiR8k1XBNjCP
	Rv5Kxw9f+Y01FKQ3RLZUsVkf5zakVvpU4lcnZvvRilUWrDFZOaKLCwUWynfoSP+i5uXzY0nWWlw
	iUFThC1dYlffdC47mO0aonIxOH9lrC/KvkSjn0YQ==
X-Received: by 2002:a05:600c:a111:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490a2933355mr11002525e9.12.1780079793675;
        Fri, 29 May 2026 11:36:33 -0700 (PDT)
X-Received: by 2002:a05:600c:a111:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490a2933355mr11002175e9.12.1780079793305;
        Fri, 29 May 2026 11:36:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c116e2bsm20236265e9.28.2026.05.29.11.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 16/24] KVM: SEV: Decouple the need to sync the GHCB SA from the need to free the SA
Date: Fri, 29 May 2026 20:35:41 +0200
Message-ID: <20260529183549.1104619-17-pbonzini@redhat.com>
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

Decouple synchronizing the GHCB SA from freeing/unpinning the SA, so that
the free/unpin path can be reused when freeing a vCPU.

Opportunistically add a WARN to harden KVM against stomping over (and thus
leaking) an already-allocated scratch area.

Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-17-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 437282f0ea94..11d46600cbdc 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3560,20 +3560,17 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 	if (!svm->sev_es.ghcb)
 		return;
 
-	if (svm->sev_es.ghcb_sa_free) {
-		/*
-		 * The scratch area lives outside the GHCB, so there is a
-		 * buffer that, depending on the operation performed, may
-		 * need to be synced, then freed.
-		 */
-		if (svm->sev_es.ghcb_sa_sync) {
-			kvm_write_guest(svm->vcpu.kvm,
-					svm->sev_es.sw_scratch,
-					svm->sev_es.ghcb_sa,
-					svm->sev_es.ghcb_sa_len);
-			svm->sev_es.ghcb_sa_sync = false;
-		}
+	/*
+	 * If the scratch area lives outside the GHCB, there's a buffer that,
+	 * depending on the operation performed, may need to be synced.
+	 */
+	if (svm->sev_es.ghcb_sa_sync) {
+		kvm_write_guest(svm->vcpu.kvm, svm->sev_es.sw_scratch,
+				svm->sev_es.ghcb_sa, svm->sev_es.ghcb_sa_len);
+		svm->sev_es.ghcb_sa_sync = false;
+	}
 
+	if (svm->sev_es.ghcb_sa_free) {
 		kvfree(svm->sev_es.ghcb_sa);
 		svm->sev_es.ghcb_sa = NULL;
 		svm->sev_es.ghcb_sa_free = false;
@@ -3685,6 +3682,8 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 min_len)
 		goto e_scratch;
 	}
 
+	WARN_ON_ONCE(svm->sev_es.ghcb_sa_sync || svm->sev_es.ghcb_sa_free);
+
 	if ((scratch_gpa_beg & PAGE_MASK) == control->ghcb_gpa) {
 		/* Scratch area begins within GHCB */
 		ghcb_scratch_beg = control->ghcb_gpa +
@@ -3706,6 +3705,8 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 min_len)
 		scratch_va = (void *)svm->sev_es.ghcb;
 		scratch_va += (scratch_gpa_beg - control->ghcb_gpa);
 
+		svm->sev_es.ghcb_sa_sync = false;
+		svm->sev_es.ghcb_sa_free = false;
 		svm->sev_es.ghcb_sa_len = ghcb_scratch_end - scratch_gpa_beg;
 	} else {
 		/* GHCB v2 requires the scratch area to be within the GHCB. */
-- 
2.54.0

