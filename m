Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B237F8AF
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492425; cv=none; b=Ol6mcdMMatdlf+m6yIPQ1IjJDailXrSNqE7SEbKoiETJagfuF6AGCrDpB4w3k0tCW3te2XTSG5vQDycE7PB22YdWTXtapQb5EHsuhJ+gtpibUpuqB7sZuO4XTN6pxUkQSVezWCkwmGm7dNu+66UZnyAvqHc2TRhfYkAbxEB4qI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492425; c=relaxed/simple;
	bh=BGqs+7XB3gWUIESu7X0yek1Mhw0+X/DZjjKlREjWL90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TO+Pw6vAMHehY52oaszGreMPuXmV2z9RCo5uO6qw54GN0qzatWgMjci2F3W4W2+vbNxXp36wR8GrpFzUedPOzgw0YistOa8WC9cDWFi5mShD7FdGfsASakfuVAUvw+BvTKiVrdfdGmpGnP3xq2Xcm+YXJLmKz8MKMdJP07D65bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+Hga5ar; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+Hga5ar"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-369467ab5bfso6791728a91.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779492424; x=1780097224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YszyzLPcvTIfPw6dM2pGXcfV2rGCyaVWTXh+SVSGVWc=;
        b=F+Hga5arj5VQrayHbC/PehReCvaA/hcJZ28QXIydOPYARuoBeh8SA5ck9oTD4dMD8Y
         4Z90Llvz2jAL8W+ODUMkSGAMlghORLXB1iz2Q/g9ZlvOJVTR8LhDRCuOhke7opGlhXIh
         MIOWdiMSGy6ztcQkaCdEbqPzeFosOfdLpCH539+grFDhHTrJDW4Pjs49qBe0YIlyseAB
         YDFP2qrLMV/8X4JfPZQcwN1d/8REYIzray3u8BT440sZLK8YlLr+KWQQ5au+DpSD9qMm
         VREHzfoHq7XscVN5CSAjJ1BY4eQyemsYvaHg7DIS1wj1bAwc8+G4xJ2IDZk8VeL0zYn2
         Mu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779492424; x=1780097224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YszyzLPcvTIfPw6dM2pGXcfV2rGCyaVWTXh+SVSGVWc=;
        b=eArZ+MzvQul/6mZxTqvf10EHxefL5r23ervtNg3GNpWW84Fmd8AKoNObNXD3bonNRh
         qbhyCyafxZpiMCh5I8jB3FdhUKEaN7gMEuOig5vLIaS1QiA53NJbMVIXtluLY+WioiWG
         WFyRo39RMWhuTUhMF9QJJ70Dn86/NEBAjX3E6iV6cLv37gxXOYmjhWMPDc2kP5zepnKK
         VpjKh8BS+A+MXIcuuvMv3CPFsioTt5kkEV+bKgZ1HgPSLepyxATYJZ1BceKFLQPjON4i
         fOovcgR9//L/QpCRqE2VlxVtVzj73wDsfWwoYVbFFT05Ck9rG0vpOGJ9c6Ab29i5L/jT
         IVTA==
X-Gm-Message-State: AOJu0YyK7Ky0DI/SlKZ4/yX5SQJCoI7+NxIgrOEGJcSyrC/VkgYZb+qY
	b13Bl4lC8t4vT/vXKQP8Aj+CWOEG0JW5ahXVsZAJAkkTi8zgTLCJ1e/aZ1pIDVyLPsf+2VYPoWD
	xGHm6zA==
X-Received: from pgne12.prod.google.com ([2002:a63:744c:0:b0:c79:22b6:a345])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5343:b0:35f:bb33:d72c
 with SMTP id 98e67ed59e1d1-36a6773cf81mr4485356a91.4.1779492423541; Fri, 22
 May 2026 16:27:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 16:26:57 -0700
In-Reply-To: <20260522232701.3671446-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522232701.3671446-2-seanjc@google.com>
Subject: [PATCH v4 1/5] KVM: x86: Widen x86_exception's error_code to 64 bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Kevin Cheng <chengkev@google.com>

Widen the error_code field in struct x86_exception from u16 to u64 to
accommodate AMD's NPF error code, which defines information bits above
bit 31, e.g. PFERR_GUEST_FINAL_MASK (bit 32), and PFERR_GUEST_PAGE_MASK
(bit 33).

Retain the u16 type for the local errcode variable in walk_addr_generic
as the walker synthesizes conventional #PF error codes that are
architecturally limited to bits 15:0.

Signed-off-by: Kevin Cheng <chengkev@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/kvm_emulate.h     | 2 +-
 arch/x86/kvm/mmu/paging_tmpl.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 72aece9ef575..f5df31a52996 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -22,7 +22,7 @@ enum x86_intercept_stage;
 struct x86_exception {
 	u8 vector;
 	bool error_code_valid;
-	u16 error_code;
+	u64 error_code;
 	bool nested_page_fault;
 	union {
 		u64 address; /* cr2 or nested page fault gpa */
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 07100bbfc270..51f8b4522314 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -328,6 +328,12 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	const int write_fault = access & PFERR_WRITE_MASK;
 	const int user_fault  = access & PFERR_USER_MASK;
 	const int fetch_fault = access & PFERR_FETCH_MASK;
+	/*
+	 * Note! Track the error_code that's common to legacy shadow paging
+	 * and NPT shadow paging as a u16 to guard against unintentionally
+	 * setting any of bits 63:16.  Architecturally, the #PF error code is
+	 * 32 bits, and Intel CPUs don't support settings bits 31:16.
+	 */
 	u16 errcode = 0;
 	gpa_t real_gpa;
 	gfn_t gfn;
-- 
2.54.0.794.g4f17f83d09-goog

