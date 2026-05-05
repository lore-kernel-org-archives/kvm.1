Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CEE3C277C
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010779; cv=none; b=d33mNGaTgZAyQGRbsNUOWlvua8H+Urbk0tw9Bba68NPGYe+wX1DG8qDDQDwo4NkKoHwETTX0G8eN2v6cvWvlqn77rzm7uL6Tp1QLaT0mVsACWeit4tS/XtBs/pKZv43aT1hWHLAX0WPAMPOYjDc9GcvNHcpLrncWpm3EPYgJlOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010779; c=relaxed/simple;
	bh=A+1lOYkdtnvg2SkTvtSOKColo3PwzJPGsi6uKT4HdMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0wTKnQssTEAguBvYM3cF7uwpYQH1byGnHkOOs1RmQAvdEdzJtztvQT06VTYyYcW+GPsJ8xMbWOMc/BqadIfpgmnpJgv5stj1CB5rXt7NF8rN2WHLwY8bAs/+HR+r/9s8k2kp5pD6cdIR9ARoYUI/NHAnNsSCww3htVHAWz0VyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBR5ztB2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLM5EYn1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBR5ztB2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLM5EYn1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V476EO8yuC0CrlvdRRJREdNPE2It58vwHqgvy1pOsNo=;
	b=iBR5ztB2kGuUkrb2RihzVdpRHq4j+x24fVKR0xC56IQYN5BI3bJZmgWmKhS1kqkj4lWqQJ
	4TbOnRccaPoXCyL0SxWwSzvJlIxRWYCQFgQ/2hS3gB9ygaMOm1S7jf6I2aX1MJEU4sUYuM
	W1XnyNZhDveiItONvYm3Dd4EGO+EPqc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-piQxBcE9OTibyzlIomL9Aw-1; Tue, 05 May 2026 15:52:50 -0400
X-MC-Unique: piQxBcE9OTibyzlIomL9Aw-1
X-Mimecast-MFC-AGG-ID: piQxBcE9OTibyzlIomL9Aw_1778010770
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso39942125e9.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010770; x=1778615570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V476EO8yuC0CrlvdRRJREdNPE2It58vwHqgvy1pOsNo=;
        b=gLM5EYn1pwQfiNAPU55JFNYoocpmLz4SjOrjMT5Rex6W4DxuWZmMY6u6/25M1rCTHn
         wWW2koO/3z4cqZiagO6u8y3p6JtkW2A89zLBVLVRRn16wk9LDMQZ3vdP6vwcSC6cMDkJ
         B3kLGu6sF3yCRGwLf3CX7VS/qISPMzEX9kTC+2wCJlshUL+e2odSCe9QTwnCba5unSqt
         rnCVCPmdv+gqexhtNguct28LsTxlDXPo844ogNucIhEmE+K0MqsAAq0mBe3AiMmJYu5x
         qwCu9lEpbiZgRuMiC5VhtXqDAoEa0DPBV7EO6a8RUK63KaQb4fr2fI3YZMOuWUle+VFs
         Q7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010770; x=1778615570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V476EO8yuC0CrlvdRRJREdNPE2It58vwHqgvy1pOsNo=;
        b=WAkKz8xC5qMsgGfRXzTfn30QCMM8aHbFUEIXpF/SLqPWTyyuOm3rAwu1Ucqt3/nEA2
         BCF+iiuDvkzYRRQdVBYbmlqxsgOQTZtbp5J0pMfZqBhwymKz/akJuX2m0BTc8mEGNdtQ
         4cAqBVJEdNr3++BWITLW91CmbvmPFMmr/X/cJQd0Gc/3uz//6jdbj6argiqYhtsmsc+G
         xPWjSlHsUwYOhQ+ybLO8H+4zBJZ6IFtQjhPzct4mwrj+fQVmICQcffuqh/RcZWAQiZzl
         ta+4OPhehXKEBloFHeslAHN9VeJYe7qDAik7AuHkbsow8BIgVJ+i29CqbsNmd8dTITy3
         CcSg==
X-Forwarded-Encrypted: i=1; AFNElJ97KA4MAacPjc0V5jT+xxg2uI9MiXh1tYOpxwqTPzjaWtIeufXsQxUx57FtkAcDlTQ/RRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLEqeaNseO8UJwlQ/K4qLBX84+rCjkD9efZ400p2tDLzmBwnkQ
	fmU2UQ9D1wxftWo3SlHnPEWB/vvPLd5bPvM24+bbEyZJKLT6dbe5yBTAlUpdLk2BbEwfrAKd3uf
	8J25vLkc3YAil3NHhTRm06skt57VBZFaTEJC3bQO4VxO2VBpLhcjaWw==
X-Gm-Gg: AeBDievlS59Aq/wyfuMVCxcNLFBuTzoDqcGsoBi/cKyFBbwHw5YtY9RcOhcGj6QBvH1
	vWc6HAWjrpe8t8WjDP8pILNOvkzfFtwppt3243Fqat5kdVU2NcCsDU4RRYQxcynLj5j1jIProiE
	c7zB03yAu5Ydc8HslF7X4iuCG66tBpWXQSDVPTRePA9TTuGZjQWhHz8EVlruO2QHvWqqN9bleHA
	TMsfYx5XpGcMgmrZS3U2HSTopaK9Amxg9ioI1vD/wg6VhoyvZIYQsmaMHYsVCKYIptWNbHKlQ50
	GPGQQYpo7NcK/R5eOBDgQZaDCLFXV31vifih6WphtWnftP0BBxB2/4ozidjhdSlrMdwNRzqyyQ4
	7Hnb/HMXcmPbTQIFowo4mmxrJB70qLAA3YSTz7NJvYLfU6m9kJBFaT+7PW3Pr12jZ7vXTnWEXJc
	YL/x7BTAfJ2Y+7D1KXHCaQYEYRjYD6OROgG39KngQ=
X-Received: by 2002:a05:600c:a10d:b0:48a:563c:c8e0 with SMTP id 5b1f17b1804b1-48e51f21e7bmr8375895e9.1.1778010769691;
        Tue, 05 May 2026 12:52:49 -0700 (PDT)
X-Received: by 2002:a05:600c:a10d:b0:48a:563c:c8e0 with SMTP id 5b1f17b1804b1-48e51f21e7bmr8375705e9.1.1778010769349;
        Tue, 05 May 2026 12:52:49 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301b7bsm496832835e9.11.2026.05.05.12.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 08/28] KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
Date: Tue,  5 May 2026 21:52:06 +0200
Message-ID: <20260505195226.563317-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move more of EPT handling entirely in the existing "if (!ept)"
conditional.  Use a new "rf" variable instead of uf for read permissions
for clarity.

Merge smepf and ff into a single variable because EPT's "SMEP" (actually
MBEC) is defined differently and does not need smepf.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d94a488db79d..fc34536c536b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5584,24 +5584,28 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 		 * that causes a fault with the given PFEC.
 		 */
 
+		/* Faults from reads to non-readable pages */
+		u8 rf = 0;
 		/* Faults from writes to non-writable pages */
 		u8 wf = (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
 		/* Faults from user mode accesses to supervisor pages */
-		u8 uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
-		/* Faults from fetches of non-executable pages*/
-		u8 ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
-		/* Faults from kernel mode fetches of user pages */
-		u8 smepf = 0;
+		u8 uf = 0;
+		/* Faults from fetches of non-executable pages */
+		u8 ff = 0;
 		/* Faults from kernel mode accesses of user pages */
 		u8 smapf = 0;
 
-		if (!ept) {
+		if (ept) {
+			rf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
+			ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
+		} else {
 			/* Faults from kernel mode accesses to user pages */
 			u8 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
 
-			/* Not really needed: !nx will cause pte.nx to fault */
-			if (!efer_nx)
-				ff = 0;
+			uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
+
+			if (efer_nx)
+				ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
 
 			/* Allow supervisor writes if !cr0.wp */
 			if (!cr0_wp)
@@ -5609,7 +5613,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 
 			/* Disallow supervisor fetches of user code if cr4.smep */
 			if (cr4_smep)
-				smepf = (pfec & PFERR_FETCH_MASK) ? kf : 0;
+				ff |= (pfec & PFERR_FETCH_MASK) ? kf : 0;
 
 			/*
 			 * SMAP:kernel-mode data accesses from user-mode
@@ -5630,7 +5634,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
 		}
 
-		mmu->permissions[index] = ff | uf | wf | smepf | smapf;
+		mmu->permissions[index] = ff | uf | wf | rf | smapf;
 	}
 }
 
-- 
2.54.0

