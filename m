Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857C372051
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618152; cv=none; b=sGEgrcmmISVWjPGQWX6p65I2k4qy5ht3D7wpMzozF3YpYPXvIs2qVXQFvxblaGdSMlnEzzSZJCGrRssem3pu07rQwGbras6/mjeZjOwa+xwQKDLRUEc6x9miavBHt1SGky6+qAJcioiIHdw42r2iPufacqamKEcu+dip9AwufeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618152; c=relaxed/simple;
	bh=+8qmKSsyhkP8Jf/LfnIW3AabMKgsYWSoMF/pmOjlCX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=le5Y7MVGxo2X2LTUARhS6ltzuy0Vh8DG2mjaVM2sZ/Ff+VEsMzx5Kb2sxDGjdjIm5XQmhDKblozKLdOjdG1T0Z6fPFA7EqGlU5WZkrJ7yZhdFfmK+TwMS/6zyKUquB9W91NW0zwzBfIWW93fTDN5MMsfMkOZNuk8kgCe0xvQfug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVJI2Hc8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKARRKii; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVJI2Hc8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKARRKii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778618150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ztOyQwPRhqqvpgfjevxzRoq+AUcMk4Pm33VrGDd3SiY=;
	b=MVJI2Hc8niy7pGGRidwGJeHc5QhuXazi9jUsV4WlffiMFYNTUzJ0Ey2cOkaEitz7jUqwiL
	fNcTBQavifhPdDQVtZBDjM+tyQBrkK7T8I7b+hXgTGt7aKQWnza+R9jEe6wynIE6DFozFr
	9ECLZjpN+IKlgC8wVh0Ug6M2gWDomno=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-ZwY8ZyX1NTykmxthVUKj1g-1; Tue, 12 May 2026 16:35:48 -0400
X-MC-Unique: ZwY8ZyX1NTykmxthVUKj1g-1
X-Mimecast-MFC-AGG-ID: ZwY8ZyX1NTykmxthVUKj1g_1778618147
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44b2b38648eso4693158f8f.3
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 13:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778618147; x=1779222947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ztOyQwPRhqqvpgfjevxzRoq+AUcMk4Pm33VrGDd3SiY=;
        b=iKARRKiiNbJTlTdjfWqu03brJkSXMfcSDLyFTfFZaiAXLQ0vK5nMe1i+4r4GKmuOg6
         zXSUzXB6oJUWNIdsb5FYkPtzwTW6hm2SUZd1JXRlRJFZ+BwsalcuCpRNl3IbYvXxXebQ
         t+7XQEV9DB9R1iTK3uzS8DkcENWqE0Dq17RKBb02RhXVTEcFzPg93G/JYrK7yZTJ5x8w
         Qlk6pOk/o+2w63bONKTLJ+Ng84ftHSBoREO+wjgK/FtubeQ5A3rnptneD6kquBYX71Io
         37n86ynEWRN7PCysZB7K7LxL9mw9695jeDlTwjzwVUWRsttBs40tSzQ1CjlTvS60s4SN
         K/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618147; x=1779222947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztOyQwPRhqqvpgfjevxzRoq+AUcMk4Pm33VrGDd3SiY=;
        b=Jg/0k1cSVLX4ZzMLIYxEZu9D9Wyf9iLkg1TNsGgWq0EytXf+lTMc5Cz8y/lEeWX6QL
         S1zAAinjquvhZEGEo9YQ8EYqRcgbNsttP+z9xju06qGOOuUz15WaDmKDAWFXnf626eW7
         /g8m2DXF5gREwGvO66N8JnnHXa9XTcuudIxSFIUJatsugU+rhFFl3CCerF8aOqRpahG8
         6mrViEsbtvmfIt9utDZ2kzlg3L17fxTecrRqfbzjsbN50QrNuaduMq357WmykvlQDSDb
         yfcV0TlIjNV0+PIPCsxStM0hIDkHRUHuHUX7Yz5tiNU5iZo5ZKT/d7iDuGBLiTC//ydb
         KIlQ==
X-Forwarded-Encrypted: i=1; AFNElJ88XDVX9M6w/MmYN4WxB0I3Z0IY7o0Qts31NDdvxZSHUNNJspIojHxzxN2sOXYZK2BAQ+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXiEdEX9li7SM8W81JhF+yg6hmxH1Gl/JJ6R40EuGsIGhGqIhM
	LG1bC0pIdPfauYW5lTyimpBw89mncjkzlKQeInYNqrRRcvhM/XOQiZP6QA4e9hWbaUqAL4f235j
	vGOKs3MzQicAmsg3Z5XecRXQ4c6WRxW1c3/G0nxhC8NqDnJhqB/mgVg==
X-Gm-Gg: Acq92OFKsB42tRAdXfCVESYy6k33XTEOKvh4qFJ0WnIP1luRFHRZUdkbV6X/yj2TGxg
	QBHid5JeWpJsDQJS5xIV59/o73LqL691fsI6J0pheAkPRqrbRszP3YNpfYn0rMojWOSlhPmzHsh
	PvWZJ5C6sxZ1+WAbehR1FFwkGxJhoGl8p2Z7WiauX689IMBwjxR6ucVzxH2ZbN1yZVttEfEg1ll
	pUXo/ydoPi2xpWioPg985NRp0COA/G7OD0C2/wfgOwZ0xLSfeixKPCviEmVO0oi+c/zFe3Guwx5
	vjxKuiFV8Ujyke6FE+f1MjsB5BcjOdDKOLJKhSa0hJ00vkA6YutW4lsfYPmAcVIkARI8oe2fdTw
	g2QNJfiSCwfq3ohiXvOp8FuCEjwNvdgwqf3RsKTk2Lqj7vGqwwg6d91Nxv+SkmXi4OsuwhWD5BS
	Qd6difAXg8IR216nnBWzvbQ+gD1gJX
X-Received: by 2002:a5d:5f51:0:b0:453:f951:4e5b with SMTP id ffacd0b85a97d-45c584a86acmr429442f8f.13.1778618147195;
        Tue, 12 May 2026 13:35:47 -0700 (PDT)
X-Received: by 2002:a5d:5f51:0:b0:453:f951:4e5b with SMTP id ffacd0b85a97d-45c584a86acmr429411f8f.13.1778618146799;
        Tue, 12 May 2026 13:35:46 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ba2aaec3asm5293703f8f.15.2026.05.12.13.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:35:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: [PATCH v2] KVM: x86: use again the flush argument of __link_shadow_page()
Date: Tue, 12 May 2026 22:35:45 +0200
Message-ID: <20260512203545.3031339-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Except in the case of parentless nested-TDP pages, mmu_page_zap_pte()
clears the SPTE but leaves the invalid_list empty.  In this case, using
kvm_flush_remote_tlbs() as kvm_mmu_remote_flush_or_zap() does is overkill.
Avoid flushing the entirety of the remote TLBs unless the invalid_list
was populated: instead, use a more efficient gfn-targeting flush (if
available) and skip it altogether if the caller guarantees that a TLB
flush is not necessary.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 892246204435..f0144ae8d891 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2526,6 +2526,23 @@ static void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator)
 	__shadow_walk_next(iterator, *iterator->sptep);
 }
 
+/*
+ * Note: while normally KVM uses a "bool flush" return value to let
+ * the caller batch flushes, __link_shadow_page() flushes immediately
+ * before populating the parent PTE with the new shadow page.  The
+ * typical callers, direct_map() and FNAME(fetch)(), are not going
+ * to zap more than one huge SPTE anyway.
+ *
+ * The only exception, where @flush can be false, is when a huge SPTE
+ * is replaced with a shadow page SPTE with a fully populated page table,
+ * which can happen from shadow_mmu_split_huge_page().  In this case,
+ * no memory is unmapped across the change to the page tables and no
+ * immediate flush is needed for correctness.
+ *
+ * Even in that case, calls to kvm_mmu_commit_zap_page() are not
+ * batched.  Doing so would require adding an invalid_list argument
+ * all the way down to __walk_slot_rmaps().
+ */
 static void __link_shadow_page(struct kvm *kvm,
 			       struct kvm_mmu_memory_cache *cache, u64 *sptep,
 			       struct kvm_mmu_page *sp, bool flush)
@@ -2541,8 +2558,10 @@ static void __link_shadow_page(struct kvm *kvm,
 		parent_sp = sptep_to_sp(sptep);
 		WARN_ON_ONCE(parent_sp->role.level == PG_LEVEL_4K);
 
-		mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list);
-		kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, true);
+		if (mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list))
+			kvm_mmu_commit_zap_page(kvm, &invalid_list);
+		else if (flush)
+			kvm_flush_remote_tlbs_sptep(kvm, sptep);
 	}
 
 	spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
-- 
2.54.0

