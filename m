Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895FD267714
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051803; cv=none; b=k3IV/WVJybLrdUMFUHbVgc6d8nRqvP97LB4KpxYQGWtWDM5hXLDNYGg6i90/17V4sGhyKMy7MZT9PiYI9W8POLb2AOgxMP3qyPIA2agqqz12nOn6OVy8haaFstgSPkH2LwT8ZYrtAla0yKafEFtS75Hgvm4EAwyWHPpR9mK9+yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051803; c=relaxed/simple;
	bh=C26AKlcqhxES8P78PlFAFfTqVSHkV2KhanGxvACIoSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qS3yMvLwFP/yytDSv/zSspponnKrR7brJwdIPFdtgP0Wn8F2hVIdrVjCDD6U7HytFd4CM0Dufw/mfC96+S1H5bty7LiJ9a165tGya/38+N5TYpp5IOTtGsL/EdNfq7R4PncHpf6KBChqPdU2fU56LSUmY+aUm3e5tbQCDMXapPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGn1U+5I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGWOjP5N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGn1U+5I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGWOjP5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RAFXUH565cQlW4EoICJT88q50/yfKIJoFVq4Wl4i3Y=;
	b=IGn1U+5IgNz8dHH5MDlTzHdFDbM+wdq5LyNOFKeKX91D476hMlrZY7EuucsJHGe8Hq34RY
	qTfW6uTHcYlLLC5IPZtmt0RmSHw2JjMU16W5GvCrQnDl36LjOPrLk8qe/AOTBxi5sTy9fd
	z5PRNvFd9cMVOwyE7Kb2kZ9v7J9eabs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-BGVucs2jOEiODVwl_pRT8w-1; Fri, 20 Mar 2026 20:09:56 -0400
X-MC-Unique: BGVucs2jOEiODVwl_pRT8w-1
X-Mimecast-MFC-AGG-ID: BGVucs2jOEiODVwl_pRT8w_1774051795
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48378df3469so18293975e9.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051795; x=1774656595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RAFXUH565cQlW4EoICJT88q50/yfKIJoFVq4Wl4i3Y=;
        b=eGWOjP5NZeKgxoidf6ArcSzevU+dVDAJPbUxjqrkGxsQ258g5jEfIMNRYF5ga3z2y7
         lNPWKsFS7w+hNR4t2kNjJhSnIeZLOyhmiT4soahb2DswXNmjWitedjw2Emej/j7EJhW6
         Zkq2z6vvbySQmofm5XWFZ9HHwxvr3TgwQhSKMCVUJjm3RK/ARNgn6fb7HtwRfk0nacxH
         EcKVsRhEufg/xa3CrC9U1VGYw0QnzjtOwtVt4DI8h3eMfhY6PjTZxga1RtSq6d1XB4uE
         3OE+2BfeHEwxy3Q23Lapu73mKt3rSoE6mOP9OY2sgrPQFsWOrSeYyCENpDt1H+e3RKSp
         zN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051795; x=1774656595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4RAFXUH565cQlW4EoICJT88q50/yfKIJoFVq4Wl4i3Y=;
        b=pu6zWphi0/0xueSi8VUGrD4V7udk4/NI8/ZmK6OB9+i5QPtQlmPDDHWvj0hqD2Opt2
         DyxToX8pHWTvAlgj48/K7iuDU4npxCCyo4n4HmKJ9K19csbaHfaM2bHKjhIF+twIiHv+
         6eFg33+NNw2YlRZf8dUyuRe3ru4Y5j6FcfczZtpngmC7cQZzz9UydYViJe9Ook11Uxvu
         wvoj4id6lFWMqnPoACbdvMfn32WUbl5oFzOIeSwHRJ9fuShAPDL3IUNRxfduMYlP7shf
         f7LVy3acsuqR8nvJ2dWvU5bArXprBa+7e77LZ+25EZgAm5380YAMwgTCTqgRA2akHCL9
         Lyvg==
X-Forwarded-Encrypted: i=1; AJvYcCV6nX5Xuzmi1DkiDpgtGVC2LngZ1MrJ9fe37Yq76Vs0zxdclEAA7Eg0tTL0aENeR3VJkKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2OzpTViUVzKMX47kXfCMUDZuy/Wcli1m7anFUNJPC0RgVnZO
	qN+Ulcq/cGTZRZFkP/Rnck4M2+trSMp827sDs6nyC9ekhx4UmnwnaH/67dF10srw2gisdr4b24/
	hXPkA042tpGc7xwt+U5ZrhHlvpHETvBgrIQvDk2fy/y1humq34zqcXw==
X-Gm-Gg: ATEYQzzKxoahjD2fzz3wuBvXNE1tMWJYpIn7cxM7rgYigLmVkMP6Cn2YhYkiZkkuyDc
	BNxOwBQ4f6Qoz9fuOtjrEIN3uu2ZutcBuLLcmPoWDGchWSb6JCapT6AU+fwQeicdYz/o9v2I6o+
	s9L5ckeNRo7u7X4GPdHhf+qQM/eM7xFaXHszHVpYeD0qOWwgCAFRFo/t0Sn69Gg1sTxdbbl6ORQ
	G6JR55Oax0IC6vBhiMGFNCnRblz979hb5so5nPKpPN2CcOQ0YI5H2/UTiaKv+SOvcMw7B9ZpO1s
	MgbYqvGhCDGoen0mRwYq8WT7NVMjbT5g5bIf4e9aGfK2upaMxaIRw2W+0amQ3J6wwbn4fNmX6/0
	hjRUkZtPW+bxKTo2P/CvsA5OT35jsh1LO8cL1fgOZPT5iRrep29s0d7PxjvquMW2noPGRRW3poL
	eQgKRVX9cvdB6M5VYbTkkiXO7i
X-Received: by 2002:a05:600c:8215:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-486fe8e4038mr73838515e9.11.1774051795150;
        Fri, 20 Mar 2026 17:09:55 -0700 (PDT)
X-Received: by 2002:a05:600c:8215:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-486fe8e4038mr73838295e9.11.1774051794749;
        Fri, 20 Mar 2026 17:09:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1e6029sm49600975e9.9.2026.03.20.17.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:09:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 09/22] KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
Date: Sat, 21 Mar 2026 01:09:18 +0100
Message-ID: <20260321000931.1947084-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Now that EPT is not abusing anymore ACC_USER_MASK, move its
handling entirely in the !ept branch.  Merge smepf and ff
into a single variable because EPT's "SMEP" (actually
MBEC) is defined differently.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b87dbf9e42b9..b7366e416baa 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5452,7 +5452,6 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 
 	const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
 	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
-	const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
 	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
 	bool cr4_smep = is_cr4_smep(mmu);
@@ -5485,21 +5484,24 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 		/* Faults from writes to non-writable pages */
 		u16 wf = (pfec & PFERR_WRITE_MASK) ? (u16)~w : 0;
 		/* Faults from user mode accesses to supervisor pages */
-		u16 uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
-		/* Faults from fetches of non-executable pages*/
-		u16 ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
-		/* Faults from kernel mode fetches of user pages */
-		u16 smepf = 0;
+		u16 uf = 0;
+		/* Faults from fetches of non-executable pages */
+		u16 ff = 0;
 		/* Faults from kernel mode accesses of user pages */
 		u16 smapf = 0;
 
-		if (!ept) {
+		if (ept) {
+			ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
+		} else {
+			const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
+
 			/* Faults from kernel mode accesses to user pages */
 			u16 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
 
-			/* Not really needed: !nx will cause pte.nx to fault */
-			if (!efer_nx)
-				ff = 0;
+			uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
+
+			if (efer_nx)
+				ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
 
 			/* Allow supervisor writes if !cr0.wp */
 			if (!cr0_wp)
@@ -5507,7 +5509,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 
 			/* Disallow supervisor fetches of user code if cr4.smep */
 			if (cr4_smep)
-				smepf = (pfec & PFERR_FETCH_MASK) ? kf : 0;
+				ff |= (pfec & PFERR_FETCH_MASK) ? kf : 0;
 
 			/*
 			 * SMAP:kernel-mode data accesses from user-mode
@@ -5528,7 +5530,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
 		}
 
-		mmu->permissions[byte] = ff | uf | wf | rf | smepf | smapf;
+		mmu->permissions[byte] = ff | uf | wf | rf | smapf;
 	}
 }
 
-- 
2.52.0

