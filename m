Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDBD3A8745
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549072; cv=none; b=rJlot9PmtNudDigypclw6/mDT5WAzceHI92XBgEY/MryNzM62bA0U+mcIRLWhTX33NO5EJQpM28pMuXvx4d4N13JQtnlQTRw4h4RSv6KjSlaPfFW5CvktUd3Jxd4qbA0aINu4i4BgHflM6Ppaiz4NGWF4m3jRbdgWU/mOM42fGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549072; c=relaxed/simple;
	bh=DmwSj31cAqA8fbZFdzkQEEIbD8DZuAQfK9Iu7JvJLPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HomuPC4gt/aZolXSNFaRVeGb7LwG+IbPDK0PTfVG5UXO8rzS1Y3OYk5besMuscIG+8rzd5/eZdcv5cKgxKx6sOzGVB9ZFu6hMi+zrY5T0hnDloxy5gbIfcJz0R1J+5sQ0cGNiVLp6+8gWVK4ebybdx3pMAunQrAgXvE6BMnMOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chG50r/1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CADiJYEG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chG50r/1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CADiJYEG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piO1nL/pS5Yr4rvE1o1jj+wOaY1ORSkY1ednhzkEqCo=;
	b=chG50r/1FzaRivcaGXp3uUJTGJYPWGj/seIuu+fnqLG6U2zfLkTO0vFzSc06ZGfk16dEr4
	k33GlcBfpjYGNTT4Rr6VVaD/7TMW/fQ582ogUPKd7//6dqMwkL7+CuRtZv5hf6Z1InSqwh
	CM2fiu/dclNgCXJPjfXz3HX1v57WKZc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-XXjiRzrMM7aq3KYQxBjwfA-1; Thu, 26 Mar 2026 14:17:46 -0400
X-MC-Unique: XXjiRzrMM7aq3KYQxBjwfA-1
X-Mimecast-MFC-AGG-ID: XXjiRzrMM7aq3KYQxBjwfA_1774549065
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so11016875e9.3
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549065; x=1775153865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piO1nL/pS5Yr4rvE1o1jj+wOaY1ORSkY1ednhzkEqCo=;
        b=CADiJYEGAzoys8nmTekiDrMuOMRExeF9Zz/83VjrdihvVgokndZEXaAk3yiUMXciuv
         909brPO/j63dU5K/no7mG0k9gd70FpNgVbmHt+kf6oXFskyCPStgUzrZw6u7JIJ8kfhL
         gap9G7kvB+1gGz0B2LPMohABKE/XjR1Msc31G263MqfTwpl8WNK7YE5aCrpu15serXj1
         SJt/64yBbAe5OMrwqTbPBmQ43xqOkc99RzE8EjoKRTYkEc5Tl9WDUjH3o7fULHqeJzsE
         icmv6xYQDFVQnKtVD4+CnzKrYCXlT3pia3mY9KpdY8QclvSN5ZEX1h6wL7QhcMD/Xl7Q
         y7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549065; x=1775153865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=piO1nL/pS5Yr4rvE1o1jj+wOaY1ORSkY1ednhzkEqCo=;
        b=S/U725j4pet5vDMrPqWkQ1pyokKBsqwMZcQKcCqva1WY4Jw1HZ0IsWBiPbuIX/Ui0f
         EhqRyA8Y7bdIk1bFPtaoG+60mAi93t86RJI44g7NYsOYRp/ya/hPtkfw6hn0eYvbTRTs
         dPfnxm5Zy7cBBu2gPZJwU6OPm3Suz7Idv2frAAQ5o+3ZyxLdsNscGZ4ak7eKpbXKGRqV
         +cnp9T/pEEhmyKiQN0bA971WxbpVjYHHN8aFzvRAGEYFg4/lS30gW/NQgWnSicgM9Ye0
         VW2wY/D9pNbVdiuAhzocrx58OWTs2HNK99hk5eixXv26wx3HIYPfyLydgWG2kqlxdUa0
         3w9g==
X-Forwarded-Encrypted: i=1; AJvYcCU/Zz6lVb/7ouzZkaa0FHvAjs+OTJ23/43K9IlmWrLvG8WdfWsqYbJ+M8EmjF6evwRv/uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUFW25rjCNgRGtj4dq7HGN5OzVez5nH2IT6jCbsQsAM/fZbUh9
	vf7BHoDCW/jcWfkhQLMrsUbQGfYvDLjzsX2JNbfAB12p1tejZw8aJfpoQII3Xf8TTjiLwrbDTWg
	FpEoGMcm+jOWS2h7cELAyRW7EVrYbmWsKxsO1PBclmqeoAuC7R4JYag==
X-Gm-Gg: ATEYQzxbawVGyKwhyPhgIGWkl/XHajVeAzAb8qdqU9MT2UMEqR5OjMp7+by5Jgyo7lX
	VQPh6YHzLWe+HvnFbSQ/wUl6j2kU23j1gm+7tk5rXYkZvn4LfEUSG+xYeSOCz1DTWpljDhTJ917
	ge6b/2hTDLNcHK4NqgXVblLrh1Z8FIsx3UyCmPG26XtpbDXCWW+v0F2xV4k4Otuv2eNmiph056M
	G4o6xZE7NJkFkx0aCh7qvQwb47wUG6Ps0eERUhqmTO2DCAKTRFNDFKDp2DIYqZrldBTMlS8Ts0j
	QjqpKEKho8c+qDcOe3cCnt52C0gEbXLrHR5bc2LXW61qZ3NHUOahBqS30SBHsZ/5mt73PcqMB2E
	3F2LvAyAxJZMJepaw24nQ3i+EoJ68307NyO+gXqRKf0wjAaUHb69C1/ny4bN66LUGwtwAyoP1Zh
	9hE0wORKYORvU1llDNFQxN9f5r
X-Received: by 2002:a05:600c:4254:b0:487:2092:b2e0 with SMTP id 5b1f17b1804b1-4872092b38bmr32523025e9.1.1774549064568;
        Thu, 26 Mar 2026 11:17:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4254:b0:487:2092:b2e0 with SMTP id 5b1f17b1804b1-4872092b38bmr32522575e9.1.1774549063983;
        Thu, 26 Mar 2026 11:17:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f58fsm75858805e9.11.2026.03.26.11.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 07/24] KVM: x86/mmu: rename and clarify BYTE_MASK
Date: Thu, 26 Mar 2026 19:17:05 +0100
Message-ID: <20260326181723.218115-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BYTE_MASK macro is the central point of the black magic
in update_permission_bitmask().  Rename it to something
that relates to how it is used, and add a comment explaining
how it works.

Using shifts instead of powers of two was actually suggested by
David Hildenbrand back in 2017 for clarity[1] but I evidently
forgot his suggestion when applying to kvm.git.

[1] https://lore.kernel.org/kvm/e4b5df86-31ae-2f4e-0666-393753e256df@redhat.com/

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 55 ++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b922a8b00057..170952a840db 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5517,29 +5517,53 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
 				    max_huge_page_level);
 }
 
-#define BYTE_MASK(access) \
-	((1 & (access) ? 2 : 0) | \
-	 (2 & (access) ? 4 : 0) | \
-	 (3 & (access) ? 8 : 0) | \
-	 (4 & (access) ? 16 : 0) | \
-	 (5 & (access) ? 32 : 0) | \
-	 (6 & (access) ? 64 : 0) | \
-	 (7 & (access) ? 128 : 0))
-
+/*
+ * Build a mask with all combinations of PTE access rights that
+ * include the given access bit.  The mask can be queried with
+ * "mask & (1 << access)", where access is a combination of
+ * ACC_* bits.
+ *
+ * By mixing and matching multiple masks returned by ACC_BITS_MASK,
+ * update_permission_bitmask() builds what is effectively a
+ * two-dimensional array of bools.  The second dimension is
+ * provided by individual bits of permissions[pfec >> 1], and
+ * logical &, | and ~ operations operate on all the 8 possible
+ * combinations of ACC_* bits.
+ */
+#define ACC_BITS_MASK(access) \
+	((1 & (access) ? 1 << 1 : 0) | \
+	 (2 & (access) ? 1 << 2 : 0) | \
+	 (3 & (access) ? 1 << 3 : 0) | \
+	 (4 & (access) ? 1 << 4 : 0) | \
+	 (5 & (access) ? 1 << 5 : 0) | \
+	 (6 & (access) ? 1 << 6 : 0) | \
+	 (7 & (access) ? 1 << 7 : 0))
 
 static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 {
 	unsigned byte;
 
-	const u8 x = BYTE_MASK(ACC_EXEC_MASK);
-	const u8 w = BYTE_MASK(ACC_WRITE_MASK);
-	const u8 u = BYTE_MASK(ACC_USER_MASK);
+	const u8 x = ACC_BITS_MASK(ACC_EXEC_MASK);
+	const u8 w = ACC_BITS_MASK(ACC_WRITE_MASK);
+	const u8 u = ACC_BITS_MASK(ACC_USER_MASK);
 
 	bool cr4_smep = is_cr4_smep(mmu);
 	bool cr4_smap = is_cr4_smap(mmu);
 	bool cr0_wp = is_cr0_wp(mmu);
 	bool efer_nx = is_efer_nx(mmu);
 
+	/*
+	 * In hardware, page fault error codes are generated (as the name
+	 * suggests) on any kind of page fault.  permission_fault() and
+	 * paging_tmpl.h already use the same bits after a successful page
+	 * table walk, to indicate the kind of access being performed.
+	 *
+	 * However, PFERR_PRESENT_MASK and PFERR_RSVD_MASK are never set here,
+	 * exactly because the page walk is successful.  PFERR_PRESENT_MASK is
+	 * removed by the shift, while PFERR_RSVD_MASK is repurposed in
+	 * permission_fault() to indicate accesses that are *not* subject to
+	 * SMAP restrictions.
+	 */
 	for (byte = 0; byte < ARRAY_SIZE(mmu->permissions); ++byte) {
 		unsigned pfec = byte << 1;
 
@@ -5586,10 +5610,9 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 			 *   - The access is supervisor mode
 			 *   - If implicit supervisor access or X86_EFLAGS_AC is clear
 			 *
-			 * Here, we cover the first four conditions.
-			 * The fifth is computed dynamically in permission_fault();
-			 * PFERR_RSVD_MASK bit will be set in PFEC if the access is
-			 * *not* subject to SMAP restrictions.
+			 * Here, we cover the first four conditions.  The fifth
+			 * is computed dynamically in permission_fault() and
+			 * communicated by setting PFERR_RSVD_MASK.
 			 */
 			if (cr4_smap)
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
-- 
2.53.0

