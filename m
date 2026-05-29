Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776D43E49C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079788; cv=none; b=Bd8aZL0BjSYeSnsztDeD/65J4kvklyHR81cGwA+mBuANDvqyC0cGhZp2iazbhUBASVshOXp+XHIuQlq/j4LzF27TSNgg+VbU4txiNVAf5s3gUwtJ6kg1AQ1xw8WpB2mFQh6UBsK5HtO5m5g/2t1G/LHsmbCw/cOPzAjjytkfGiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079788; c=relaxed/simple;
	bh=LiFc3B/oCWIx4bWkwIOcLZN3wPQ0d5KDRXuPzPzV/wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PToowyt/aK0NPgVRRtn3tcRGF5Fv8dlgb6g5WZ11aRnkdM+eb+4f6gmaWc1G71YfGlKckuTrXBaxhgynemolZuXFGVuNG6/y0ajPN0gJR3tM1j6JV/ggpj5bZOmkcPE9JxZlfJxm8CbA1LkE5EeQdcak+w5B1MOCbOMj2kc9YmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtrxmLnR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUpVQtl4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtrxmLnR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUpVQtl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elPT0XXkTpOYA/RUY63VmCp9ekxpXBo6/F+wCh3tfvk=;
	b=DtrxmLnRkUyIbklr7aNBl+0BJ+ZwlIMpXR9Et1YSMYcTzPeuYionBpWAMgXzBzE6p07QCF
	2wp/SPfrB+aO/m6I236UJtnPM63qIWYMMliowj77aW54mwgTPMSjWFf5s0DX+Tt08X2hKr
	L6gcfhWhCAp53NvxxGQXshfAAxRWoQE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-VScB3touOZ2poyw5vsaDTg-1; Fri, 29 May 2026 14:36:20 -0400
X-MC-Unique: VScB3touOZ2poyw5vsaDTg-1
X-Mimecast-MFC-AGG-ID: VScB3touOZ2poyw5vsaDTg_1780079780
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49049100a40so50208025e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079779; x=1780684579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elPT0XXkTpOYA/RUY63VmCp9ekxpXBo6/F+wCh3tfvk=;
        b=FUpVQtl4EA9WyFsNTxNc7viozjECveVFl1sHO6JxvkoXzahZXN0zvsihOz4R3S3af2
         y+AqezrPLlrhwz4gi867gRPryusDAbFxoxkwm/Ky0qm6t+UHbhIp2Uo3FC4R2yMK9rrw
         QGGwcNRWAH8Cx7WA8sUzvY8OkMkJrZZz7aR3NW7/T9XS+oB1IbIOCaTNlOmo7TIs5nw9
         PqKHPc0TRjI3PAhGPMtpXVXU0SM6BBlGyEsg0TzBLpX0i1JztelTDzvCKonQqJc9j8yC
         31KU3fdUnfXASKzQjOaWz+Qv20MFIGXDTlaAx9ipALNeOpy7qP5VYZgKlaD1Y6rOGBDy
         yMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079779; x=1780684579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=elPT0XXkTpOYA/RUY63VmCp9ekxpXBo6/F+wCh3tfvk=;
        b=YdF5xphyjQnzDKruJ49khb3lqUyBvgWTxXIFrd8fylrIOViZ3DnkGgYOR6hkUnLs8C
         dbpUMVZTANEcS+iXnF7wAk+PpJdsIKXUGzHRgEktkDLa4uIxahLqqSqcZgBzcQ1tgXbh
         izEbfYP9BSc2YM894a+3zQ1CsmqR4yXkeCfzRPp3K5a6SMm6cGrrztcb7QU/W2VGe/Fq
         tLJ08x3ILbXflM9zOG81/mdSZv2iRrAaJtutnvKFIAnwOKpbS8dfQ1C5PskhDbt/8SQi
         3otRHIiJKi1vVrbrqB2MXYhDS+PLQv6WFd47dONqPliuCZo0RXDOZkYP5gzyMrs1FvWv
         6fug==
X-Forwarded-Encrypted: i=1; AFNElJ9ZNVcZ4+hetrM1nU7OIDKa9zJ/NVZUTwJM9IUUKSouvmca2YbONtE9kUbJvhs37CxIn8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59g8TkRVO0Z8vfuZuj2PFDvn+cfFzqxeGz98IwFmlJ8CO6EXl
	jenOBnkByc4+EvbnPBuXYGaZyvosP2ixeKivAwLO7Id1RJ47idX1riOZvsTo/Kjgs7AvuPSwFlC
	8LW0ofD9J+bk1Oo+LVlVquFGE4yIlUgCZUZBvSa2hNu256bIpqpNeTg==
X-Gm-Gg: Acq92OGBdzCYjdN1jTwb64iOCPntT9B1s7Cs71rxWWxWu9NLetJYGTvpwyLrm/S573N
	Bf1L3TDSTW6LsYwqgMSh3IduYiwr6UX4eTXZ4xMpX93vOeBoRcrDo2qJtTNDuLe6xjXJ7Em4oPG
	8Wcpy4q8zzAPRbQ/VbwO6U0vMUfA8ugx5RdSrhz4afluVlW9Ck+J0xZVqYmFYbXg1+CmKa7gPkc
	siYw4saie91ILGqe//OJltICyecddc/pNZ9jDatFmtazEc9xDa7Rl9RLVdjbrUrAm935WLa74hT
	3notH2jqHob8+QOtxr0GTWgoEpFaWsk0fFjwhIFkmYfQYb0rSJ0lSUeWu6UMkbg+8goNrIXOMHo
	r5t/WOCdlCPWWGnt8X9gi7Rh09U6RH5E6n2xh3Hcbn/xPhy9d2inxciYKG/w0ju0rYc5qHX2Yb0
	rAmZXB/+OHE3rRSCec1WqzfRfFqbpqbgFed1hScg==
X-Received: by 2002:a05:600d:6447:20b0:490:6e12:542d with SMTP id 5b1f17b1804b1-490a292fdb8mr10523045e9.19.1780079779739;
        Fri, 29 May 2026 11:36:19 -0700 (PDT)
X-Received: by 2002:a05:600d:6447:20b0:490:6e12:542d with SMTP id 5b1f17b1804b1-490a292fdb8mr10522675e9.19.1780079779424;
        Fri, 29 May 2026 11:36:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c967c6csm64129235e9.2.2026.05.29.11.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH 11/24] KVM: SEV: Make it more obvious when KVM is writing back the current PSC index
Date: Fri, 29 May 2026 20:35:36 +0200
Message-ID: <20260529183549.1104619-12-pbonzini@redhat.com>
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

Increment the guest-visible "cur_entry" index outside of the for-loop
when processing Page State Change entries, and add a comment to make it
more obvious which code is operating on trusted data, and which code is
touching guest-accessible data.

No functional change intended.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-12-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 62b5befe0eed..1982d13e71d9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3947,7 +3947,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	}
 
 	/* Find the start of the next range which needs processing. */
-	for (idx = idx_start; idx <= idx_end; idx++, hdr->cur_entry++) {
+	for (idx = idx_start; idx <= idx_end; idx++) {
 		entry_start = READ_ONCE(entries[idx]);
 
 		gfn = entry_start.gfn;
@@ -3974,6 +3974,14 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 
 		if (npages)
 			break;
+
+		/*
+		 * Increment the guest-visible index to communicate the current
+		 * entry back to the guest, e.g. in case of failure.  No need
+		 * for READ_ONCE() as KVM doesn't consume the field, i.e. a
+		 * misbehaving guest can only break itself.
+		 */
+		hdr->cur_entry++;
 	}
 
 	if (idx > idx_end) {
-- 
2.54.0

