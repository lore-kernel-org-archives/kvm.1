Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95093A1A5D
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964244; cv=none; b=lbq6FE0m8KdWa1L8GpufMuz8Eh67RXF6hwTSWTApFKkKbmsvEkDE184W7kZL5k/nce/+hkXqp2Rn2ifCOTivoYLzOIQ6A69em1yQ7nqzSYk7jU1/flAK/K1OCVMi2tvZF2/udt+zgKux7LrAo1fgZAHjud3JE8zC1PexlBRldBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964244; c=relaxed/simple;
	bh=PjL095tSFIg8q7WA/4EM2scDZC3+SKVeiuJZVPPDZiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t21aapefQGRLBQxThQc2RZPRwifhsjKiOQYhFQ3soo4+uyzCb5vw2VAoL+9ZSdPNgEdkPjABFIQD8hXvAHAAF/T3O0Y3J2Ne5fdDIz7NLU+hkX+rQfFNqclulVsgIXL4L3562Isu4stbQTxVQZJIg98Vmzvo9m7y7RIaQbGWjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2fFKEOS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bc6geNmL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2fFKEOS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc6geNmL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777964240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OkvB2g9TIRVT/EYnBf5Sqf4mqtiJXj4gtABaXOHNaLI=;
	b=Y2fFKEOSlUh5h/alvPvR2qF6EEojr7fqqOyzhd8fp8xq1RCKf8cnRnM0lOVyHAjNRYk6T/
	7f7Ir2CKTjymYN+g/fQX2xoB7N2Sd+oawDwiA5Nt7JocInqM/QaHCFhu5ePX5mZcv3Ia3Y
	icLOnLN5F3jskN510bmomkDAGR+O43I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-0TpW9OlXMkO_rqI6-o5Ayw-1; Tue, 05 May 2026 02:57:19 -0400
X-MC-Unique: 0TpW9OlXMkO_rqI6-o5Ayw-1
X-Mimecast-MFC-AGG-ID: 0TpW9OlXMkO_rqI6-o5Ayw_1777964238
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4411a1f9601so3618038f8f.0
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 23:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777964238; x=1778569038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OkvB2g9TIRVT/EYnBf5Sqf4mqtiJXj4gtABaXOHNaLI=;
        b=bc6geNmLwjV9s5ZP9lribt3sbcPwQ0yp39XfqO7yZSe0Iv0LFG3AQmhtW60DD2fQQs
         bHzFrfnRWasf8ka3DoEgM3fI1ODwybDPHq9XKhseN40k8cKh+cywn7XjofqqVu+8vJWl
         BKRc4qcttBAnSg0vZf0NzMgGBn2rHBQLRlJCDUw7EhHHYAIjx2MJyxndzaZ/LY6Jc6rv
         gtHMFpWTcX2GA5hUdJjhg5WBXJXZ+fSJpKSAUVs++e+aqH46yx2mqNQiFGZsrxwWNFQe
         1W3zWr09MSjkJrL1Ah/iycViEbefaXhyNUmy8B9UTKBwOhxWNsRsq0DW+zSpvmYk+kUE
         Q+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964238; x=1778569038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkvB2g9TIRVT/EYnBf5Sqf4mqtiJXj4gtABaXOHNaLI=;
        b=keIKsmJ9x0zZuwp0Xl5xugtiCuM0njvg5luxTKl6zsjItjh9EZU50KL9UGy8btcqhq
         RJ3RBTggnV5cMVlgIwmJVUx3U7GBXwLypXa87ORuc/LCY8gWG7DkTbOvBmraPWUgO/+s
         yQ8vZE9qjvtLnUTKyAQiAfu+za1aFpWXzmOo/WV8+ZVuoSX7ojrJpktZwVLyoeZJz/ou
         zq8Nb3q4PZNLhpb7paXOrEK3gq+Lc+OJS9I4rz5v2p44H84zNsW5k8Ui57KPYWhypR+V
         wqqYmyRd8sUpN1WSZWfyPhP/HCez0CrHhPtKPF9HeRgdyqe0KxWh0U/xZgNU+3J7RdDv
         Nc/g==
X-Forwarded-Encrypted: i=1; AFNElJ8pXDDkRiQEBxS72/q4CCIF02gozovnrfVhZXqhTD29nZ4U2/9rFQnKnvmSCUDYSRnH/Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjhbD9w1QyyINmtlg19FmLMWpwvDzDgPXBePb+aCM59o20uEf
	XeohMF4cG+ZxINZwVVUeaAz+Leh+zxRMeOQmziqZZhdJ9vreaVRKfPtFRnCSFHcVm90+Gz9cGdK
	LzKfjYuJF67DYHno1uj6QXtUVU/wvsrYIzQggskccykyA1OQ7walQHQ==
X-Gm-Gg: AeBDietQcahJMSOZUGbOWYa12VArQisV5DoK2TxlTGZRysU9Z7M3ADwht9NGgb3j9Ye
	Tx1OAwDE4PHSrjFw/I2TT4gMQ5MS0MgCjLCB/lQP4ociyMuE7d1+GVpgDWGSF04BzONPOgGuy/+
	JskObEbJvb9S46zCKtwdvWu38dBN6WjYTn3R17OO52e+QvrZI3uWl8ZAR4xEMaQ2xMVIjOztjrm
	6Gwje27VVanKCIv0ryMCVhnOu9AuqJOz8g2yrhVQ0K/kNCm4JfC3iuqFrm/TVIL9IYeC/rzCcFv
	LhGY7654T9T+EdeWzdsR2nA9afraVkwkSaa2A5oh77HN5tDOriT1eppUvcxdevNG69q4m2KJbNa
	EJCaNHIZRWo0ef2bSRe23AZP9HKNK01xOu5Y2d9UJ1vdd9FU3W1LBBjvcfPN9MsuvA9dRL4VkaB
	vzne6qBTWZbluxFNlEGJXQWg/MNrmSxCEtmlzo4Bo=
X-Received: by 2002:a05:6000:3110:b0:44d:4898:7ed9 with SMTP id ffacd0b85a97d-45005c805fbmr3177325f8f.23.1777964238191;
        Mon, 04 May 2026 23:57:18 -0700 (PDT)
X-Received: by 2002:a05:6000:3110:b0:44d:4898:7ed9 with SMTP id ffacd0b85a97d-45005c805fbmr3177268f8f.23.1777964237757;
        Mon, 04 May 2026 23:57:17 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b03e04sm2375596f8f.21.2026.05.04.23.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 23:57:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH 7.0.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Tue,  5 May 2026 08:57:15 +0200
Message-ID: <20260505065715.186759-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit 0cb2af2ea66ad8ff195c156ea690f11216285bdf upstream.

The shadow MMU computes GFNs for direct shadow pages using sp->gfn plus
the SPTE index. This assumption breaks for shadow paging if the guest
page tables are modified between VM entries (similar to commit
aad885e77496, "KVM: x86/mmu: Drop/zap existing present SPTE even
when creating an MMIO SPTE", 2026-03-27).  The flow is as follows:

- a PDE is installed for a 2MB mapping, and a page in that area is
  accessed.  KVM creates a kvm_mmu_page consisting of 512 4KB pages;
  the kvm_mmu_page is marked by FNAME(fetch) as direct-mapped because
  the guest's mapping is a huge page (and thus contiguous).

- the PDE mapping is changed from outside the guest.

- the guest accesses another page in the same 2MB area.  KVM installs
  a new leaf SPTE and rmap entry; the SPTE uses the "correct" GFN
  (i.e. based on the new mapping, as changed in the previous step) but
  that GFN is outside of the [sp->gfn, sp->gfn + 511] range; therefore
  the rmap entry cannot be found and removed when the kvm_mmu_page
  is zapped.

- the memslot that covers the first 2MB mapping is deleted, and the
  kvm_mmu_page for the now-invalid GPA is zapped.  However, rmap_remove()
  only looks at the [sp->gfn, sp->gfn + 511] range established in step 1,
  and fails to find the rmap entry that was recorded by step 3.

- any operation that causes an rmap walk for the same page accessed
  by step 3 then walks a stale rmap and dereferences a freed kvm_mmu_page.
  This includes dirty logging or MMU notifier invalidations (e.g., from
  MADV_DONTNEED).

The underlying issue is that KVM's walking of shadow PTEs assumes that
if a SPTE is present when KVM wants to install a non-leaf SPTE, then the
existing kvm_mmu_page must be for the correct gfn.  Because the only way
for the gfn to be wrong is if KVM messed up and failed to zap a SPTE...
which shouldn't happen, but *actually* only happens in response to a
guest write.

That bug dates back literally forever, as even the first version of KVM
assumes that the GFN matches and walks into the "wrong" shadow page.
However, that was only an imprecision until 2032a93d66fa ("KVM: MMU:
Don't allocate gfns page for direct mmu pages") came along.

Fix it by checking for a target gfn mismatch and zapping the existing
SPTE.  That way the old SP and rmap entries are gone, KVM installs
the rmap in the right location, and everyone is happy.

Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
Fixes: 6aa8b732ca01 ("kvm: userspace interface")
Reported-by: Alexander Bulekov <bkov@amazon.com>
Reported-by: Fred Griffoul <fgriffo@amazon.co.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://patch.msgid.link/20260503201029.106481-1-pbonzini@redhat.com/
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dd06453d5b72..729240bc00a2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -182,6 +182,8 @@ static struct kmem_cache *pte_list_desc_cache;
 struct kmem_cache *mmu_page_header_cache;
 
 static void mmu_spte_set(u64 *sptep, u64 spte);
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+			    u64 *spte, struct list_head *invalid_list);
 
 struct kvm_mmu_role_regs {
 	const unsigned long cr0;
@@ -1287,19 +1289,6 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
 		rmap_remove(kvm, sptep);
 }
 
-static void drop_large_spte(struct kvm *kvm, u64 *sptep, bool flush)
-{
-	struct kvm_mmu_page *sp;
-
-	sp = sptep_to_sp(sptep);
-	WARN_ON_ONCE(sp->role.level == PG_LEVEL_4K);
-
-	drop_spte(kvm, sptep);
-
-	if (flush)
-		kvm_flush_remote_tlbs_sptep(kvm, sptep);
-}
-
 /*
  * Write-protect on the specified @sptep, @pt_protect indicates whether
  * spte write-protection is caused by protecting shadow page table.
@@ -2466,7 +2455,8 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
 		return ERR_PTR(-EEXIST);
 
 	role = kvm_mmu_child_role(sptep, direct, access);
@@ -2544,13 +2534,16 @@ static void __link_shadow_page(struct kvm *kvm,
 
 	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != PT_WRITABLE_MASK);
 
-	/*
-	 * If an SPTE is present already, it must be a leaf and therefore
-	 * a large one.  Drop it, and flush the TLB if needed, before
-	 * installing sp.
-	 */
-	if (is_shadow_present_pte(*sptep))
-		drop_large_spte(kvm, sptep, flush);
+	if (is_shadow_present_pte(*sptep)) {
+		struct kvm_mmu_page *parent_sp;
+		LIST_HEAD(invalid_list);
+
+		parent_sp = sptep_to_sp(sptep);
+		WARN_ON_ONCE(parent_sp->role.level == PG_LEVEL_4K);
+
+		mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list);
+		kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, true);
+	}
 
 	spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
 
-- 
2.54.0

