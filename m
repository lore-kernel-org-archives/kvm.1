Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0352F0661
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010779; cv=none; b=K85BrX9QX0bEyzowwbOMZ4pYf79ZXrGlIgEn/ut5qACw7iVvQY7WbwygbPyMDOqxVe+qPWPq8ymO8aIhrS8I6Ch4FnaA0h5yJBuAkFEz9RZ62sKF2m4iAt19P7oWiHFp+rUbIdXh8DeARUL8+/X1Y4oEMm6Bu9Libe5Ab7+1M1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010779; c=relaxed/simple;
	bh=xcs8N8Ir2k2QH3s5gxdqyKJrgcgQ/V8AjLlcJ3QFRiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoGNpvHjtRDG0IRmaq0MT2F6EBkodRB7RKBwxpjHF0D+wH4yn2Vu5qbMLNzh9Nt5aoTnTK9k6rI3/bb3HlrlRUf0E1pAidUF38lzzk9t7mmPSmda69YfIeb3uLc5ly+CUN37NrUYsaJqdF0DE3uhl7URqC56/Wx8X7fm8J1skJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3lzYs2u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhiIDW3a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3lzYs2u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhiIDW3a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qA4QxJ4Rlo1GYMPxqmoz7ie3e/DH4wp8z5r8HqmqNfQ=;
	b=T3lzYs2uRO5B2WvYFS7RvKVupnzUIujwQyy5vKf6GE174qsvDIRL7/3zlvKNUVZtg9WHZR
	1H2kX5f3nb1poRQhQIN18u2/FbyhboMNgnY0lZ0U4aZcjpBej2QuTkjM9gs5to02QTMNED
	FnwyoVS5dCxyDv//YxiWmUveIlrb5vs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-GMHDGeOlNxmWIKMBUEbBpQ-1; Tue, 05 May 2026 15:52:55 -0400
X-MC-Unique: GMHDGeOlNxmWIKMBUEbBpQ-1
X-Mimecast-MFC-AGG-ID: GMHDGeOlNxmWIKMBUEbBpQ_1778010774
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4891f97aef0so35184915e9.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010773; x=1778615573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA4QxJ4Rlo1GYMPxqmoz7ie3e/DH4wp8z5r8HqmqNfQ=;
        b=WhiIDW3aTECtSvkMJdv9UcbPLH8EpKv/Vv7OIcnxWJO4tMjKoeqt/Q5ohfZ5zy3b9D
         x/PZT7hB8zO4ICQ3QOadP0v3Lc51OTvZ2IKB4YaWYpy7sgyJhVmfIaKT2dJLOHHNQnJW
         4Xgvy3OwMGxWDrGHRR2LPsg2EclYQp0IRFiqCw6wCCbKyVm0Ov6bOvAdCsQuaXfRlLv2
         zL38rCHIHbhfWVURanS29JsJlO2lzR6QHAfW89hMckvDrF9zGNnNsVdIdtXwTGx1LhF/
         BKwPryuLXBO4HxvbpmBgY5YYk7wnC+8iL2TzPqYul1+oAcVn3dXzSZShujl4ceJzbZJh
         ikxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010773; x=1778615573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qA4QxJ4Rlo1GYMPxqmoz7ie3e/DH4wp8z5r8HqmqNfQ=;
        b=icsLMZu2x9elc1biRg4/hS1Y4sC+gFwWaPWdTCkJBSxy+Z+/xMjnYyARMydW1PE52z
         wcE/Ho8jvmK7emN4ZCUZK9oyoYP80mY/VFIO/zmtW7h2RYiI6OSWpo9OaEGQgQz37+CZ
         MUlth5vrdUh+5nstTyJm12Li3D08+qr+ubUra3L0qDypdwLHRuy4uF4jPX41/rjJzt7h
         1OsPLm5g+8lr1O3JB/DNNJsMiRZbUYA6oolUDmYkKQpdBu0y+FJwe4SndjlIlPXWNT4X
         +vWo7hKrmNrcQDZ1+iqfQW7GhR7YX0UxKNJYYC910e+UDz9SjTOG1YCOBvLAzafnwUVv
         2naA==
X-Forwarded-Encrypted: i=1; AFNElJ9V7lAxN/2y9gwX/PN/0ATtQNj0AmmmbyanTUTs/HOB0wssw/Ah3/DbkWoYuMhy9UFhxoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4EB1JubWdvndW+SPNGK2pNBgP6VsXkpRzIJck9U8f4rz8qRC
	RA7sOghezzgtDYFlFdeXjbJKCV90L6S2qdUGlmMXOnEe2yJV/w1eozokgXOi+lgVh+rJ7NCMgLn
	QJRwxQoFNi/P0DARghAJpqdNhzvSgDeshzm15pmdHmyz+55phRdyzCZnFuOxOjg==
X-Gm-Gg: AeBDieukIMqEwGlXdkJ9dMq5tm9on5av7a2qJgs3d6ahXOSXi2hI6DdmLevptArYpEd
	p4VQBZI6hCAyIvedBmrs+4Ye7ePTF/ayW1Cvm2iVL28CbpDNpNZsNDPziuSwAhvLeUijH3cFdTK
	QtJ7KxxAwM0lWrT7jYXeK/iAvmfx+3QfOn97MVB7dJVdNbFcvXdvkKWghI8vcZ0M86/I0lxUiYo
	u7oFJGsvFUBBtZfSWVW+NpUBdkBbYeH6Srpu5vVDIGxn1c0CGxRmPo4MjHxTnVDW94yySzAYlL4
	HeYMbzlAr3JzG9Fg1jrirWYSPs4wF6Sp3sg/RZdzqGem1YoRSxCtZp6bqYMdAmKmwembp6W9YeH
	EHg7GR6QSDHQMvslPH4fYon6toax9EEIMPlZBcwUEiQqvKvBbtkrnAwYK4Wrt0B/PgyAbgMQL9b
	u4Pb9GHhKCd8epOno+kDEzRT7xxmjwuF2TgWF2N3g=
X-Received: by 2002:a05:600c:1d18:b0:489:1f97:6b1d with SMTP id 5b1f17b1804b1-48e51f4844emr10534365e9.28.1778010773082;
        Tue, 05 May 2026 12:52:53 -0700 (PDT)
X-Received: by 2002:a05:600c:1d18:b0:489:1f97:6b1d with SMTP id 5b1f17b1804b1-48e51f4844emr10534035e9.28.1778010772750;
        Tue, 05 May 2026 12:52:52 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm334741325e9.10.2026.05.05.12.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 10/28] KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
Date: Tue,  5 May 2026 21:52:08 +0200
Message-ID: <20260505195226.563317-11-pbonzini@redhat.com>
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

The XS/XU bit for EPT are only applied to final accesses, and use the
U bit from the page walk itself.  While strictly speaking not necessary
(any value of PFERR_USER_MASK would be the same for page table accesses,
because they're reads and writes only), it is clearer and less hackish
to only apply MBEC to PFERR_GUEST_FINAL_MASK.  Allow kvm-intel.ko to
distinguish the two cases.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/hyperv.c          | 3 ++-
 arch/x86/kvm/mmu/mmu.c         | 3 ++-
 arch/x86/kvm/mmu/paging_tmpl.h | 7 +++++--
 arch/x86/kvm/x86.c             | 3 ++-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 9b140bbdc1d8..cf9dd565b894 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2041,7 +2041,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * read with kvm_read_guest().
 	 */
 	if (!hc->fast && is_guest_mode(vcpu)) {
-		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa, 0, NULL);
+		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa,
+					PFERR_GUEST_FINAL_MASK, NULL);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index fa6a5e4ee09a..46412e4d207f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4348,7 +4348,8 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 {
 	if (exception)
 		exception->error_code = 0;
-	return kvm_translate_gpa(vcpu, mmu, vaddr, access, exception);
+	return kvm_translate_gpa(vcpu, mmu, vaddr, access | PFERR_GUEST_FINAL_MASK,
+				 exception);
 }
 
 static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index fb1b5d8b23e5..567f8b77ffe0 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -376,7 +376,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		walker->pte_gpa[walker->level - 1] = pte_gpa;
 
 		real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(table_gfn),
-					     nested_access, &walker->fault);
+					     nested_access | PFERR_GUEST_PAGE_MASK,
+					     &walker->fault);
 
 		/*
 		 * FIXME: This can happen if emulation (for of an INS/OUTS
@@ -444,7 +445,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		gfn += pse36_gfn_delta(pte);
 #endif
 
-	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access, &walker->fault);
+	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn),
+				     access | PFERR_GUEST_FINAL_MASK,
+				     &walker->fault);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..ef1e3ae13887 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1072,7 +1072,8 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * to an L1 GPA.
 	 */
 	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(pdpt_gfn),
-				     PFERR_USER_MASK | PFERR_WRITE_MASK, NULL);
+				     PFERR_USER_MASK | PFERR_WRITE_MASK |
+				     PFERR_GUEST_PAGE_MASK, NULL);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
-- 
2.54.0

