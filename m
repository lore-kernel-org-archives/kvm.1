Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBE3F23CF
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473184; cv=none; b=Np+nQrzniLnFFAFgbHxttgUphRiOZkmcb/4uRYaKI5eRa03rlkYHQMxusbUnlnAxpGVRcKrzkOF6jSXpbkGdIVA13ubbpvKs5Qu8cshGxw25oN5q/OWWMkYNGasJJb1ib2Ix7LBnd2O2jRZIzUpgpB9I8zjd1N1rYPbJujJH7mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473184; c=relaxed/simple;
	bh=zLklgwFSYl7YtDQHnnsYt3gGsS6PqKoqQGbciUElPpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT5KPunr7s+OvCq/FUHgaudlhwxlBs3IdgaeqU/lxg6FrviA3jL3BwXXqotOlG+B97xMXD+Xw5Le57wYy50nR3lL//7jMcWgapOOOLqLUKZ6GMnYhMMgFE9VUOQfQgwI9MzyjRqq9zMV5RqlvRPe6LOs1xqDIHYF6eMGDsMbbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUsuYega; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hh+ODfId; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUsuYega";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hh+ODfId"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwixNX9Ud324NM9GYv258HhoqjuhQ4b/EvEuH+s4zXI=;
	b=aUsuYegaYrE/inuucYmGofvWGIKfma596miWxIBJFWF3YE62YoN8YmRuO9CJLsl8WxE+E2
	AH8/f/aux4F25nwPPwAp74o8ldcw4G20lieWED+rt6kkMpIEpPU8t4v8rZxqCbQlOBAEDj
	R1av06Xb9chB41iXNUoAC5sisn5e3tE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-S4FPY6omMDa8_z24E9QVEA-1; Fri, 26 Jun 2026 07:26:21 -0400
X-MC-Unique: S4FPY6omMDa8_z24E9QVEA-1
X-Mimecast-MFC-AGG-ID: S4FPY6omMDa8_z24E9QVEA_1782473180
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4625b4f54c6so638702f8f.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473180; x=1783077980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwixNX9Ud324NM9GYv258HhoqjuhQ4b/EvEuH+s4zXI=;
        b=Hh+ODfIdi2c/ASNcXWrN9IT4JnXKw+e0IqWdr9uFeTrcZaWMwyIqVcZP5n0tv2J7el
         SemckZCl9cC8ESxFn1CHBNGwJeAPQ5HJrtYY/3oeXJTSTgIEQzWKSiSAU8iZx+fiivvk
         r87LyGiFvHmK2XKZR6koQKzH8SLidNHOKAPnGl4h5jVheaRlVobtgOvdoMhi0yZqenSs
         uSU4oDDqW10K2+UrGTmwHz4bnTY3aRS5yfXWFfuQQ/eaHt0pmHpFromEmDYLlMcjxzud
         FriQFV/e1gZurb8iNHdiR2EYYf3Tfnjrk+jTyTN+7wAVo4N1BTdt8UhDERZpy0Vrm6XF
         oKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473180; x=1783077980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwixNX9Ud324NM9GYv258HhoqjuhQ4b/EvEuH+s4zXI=;
        b=VDp35lm/sjOLj0YTas6PzdNVevOFrjy5vjPlCu/UvmovIke0Q4mmmAwKwoK3LRHhtM
         OWxxQsQKzrj+PuhvUTmpT5GnO0+XHFvGTPlCwwIZofMN33kcPVIcNd4cMlM0iF52UqH2
         pcx9u7LsvBvyoV2rivH1av/eTt/1FJAUR2hMN5vLAUG5eY4/7g1S3oqZ0j/SJ1K8MJEq
         8NIxBvJaECYg8kDQxX/TYUaKTnVzjnQFFEkBSTUtZGw+cl1S6YCaPErLf2vnqM6OWxbL
         maTKMRFX7OaoHbNZxiRXdPUJbA+51J7RdYbUt76HCQ51+5Aa6gOMezh12d8NCtjzIvGp
         GyIg==
X-Forwarded-Encrypted: i=1; AHgh+RqxMCVSDleasLvTEGAFuGEozxupRgxrAmBiHbFiNBRfRqTERDQzG9jBxECuZ9UVMcm0Vug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyipBtUGnedfFsgowz9WYv23rZYU+213uAhjJFybBFuehDBZ8O
	y60arKZFvny7jcXMXRKywFnMuJ2Z+oFZRPEuzmqjBkl2h1mFFmHRGvnOolSXHIJm+1QnuS+qKoj
	CDyJPR4QBA/9Tv2IlWB0nuNOY2djrrWr1qT0dwW2lw77+YbuIKae3nFfXxKr/fA==
X-Gm-Gg: AfdE7cn2SK1a6NQyqqXd1NrLiyqwQHY4sjQYhtd321xBlXISxfqY9Gfv+4ghF1nnt+D
	T4/lF2bHII6o6NXbByh6QmDqTVZbynwEQaTqz3I4DfKOSfWWdaeRXrJq1qRpP8BdmY37OhAr2GH
	6PrxIeoIg6mKh7BusYqfj8lOrGCIB0WQkwbiN2I3pIuRlq4TDb6Snb7BPzez4A/rd/mIBM31Y+O
	20p/ZBCIEFzvZ1Hz5bhi3Z2S+gyAf2bsA+Oek2XwEGkTF7PzPum9fL4GbUqnrtSe/JgAtcS4MJp
	PamKNsxfKDIRTRmjdH+YpMgnTPFu2pRLaM+0YmAlJpiUmTLu2DLJas8uksVhxmEuHedX9DN+orE
	YCVlMzNFy+emhttDElbuxKzBkCmuJLJGPXlZBVwXEFruP0nmXDN71jRBRQ2bs1QZPLAKEeoPQ6X
	uMAPkeHTt+ut+B6nMp
X-Received: by 2002:a05:6000:471a:b0:45e:f780:6181 with SMTP id ffacd0b85a97d-46dc0e04bb7mr10499412f8f.23.1782473179807;
        Fri, 26 Jun 2026 04:26:19 -0700 (PDT)
X-Received: by 2002:a05:6000:471a:b0:45e:f780:6181 with SMTP id ffacd0b85a97d-46dc0e04bb7mr10499369f8f.23.1782473179397;
        Fri, 26 Jun 2026 04:26:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c9f240c3dsm22883423f8f.35.2026.06.26.04.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>
Subject: [PATCH 5.15.y 4/8] KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
Date: Fri, 26 Jun 2026 13:26:02 +0200
Message-ID: <20260626112606.1778248-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112606.1778248-1-pbonzini@redhat.com>
References: <20260626112606.1778248-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 7f49777550e55a7d6832cbb0873f48f91c175b9c upstream.

The quadrant is only used when gptes are 4 bytes, but
mmu_alloc_{direct,shadow}_roots() pass in a non-zero quadrant for PAE
page directories regardless. Make this less confusing by only passing in
a non-zero quadrant when it is actually necessary.

Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-6-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3a5ed9670377..dbc18d4cc572 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3444,9 +3444,10 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
 	struct kvm_mmu_page *sp;
 
 	role.level = level;
+	role.quadrant = quadrant;
 
-	if (!role.gpte_is_8_bytes)
-		role.quadrant = quadrant;
+	WARN_ON_ONCE(quadrant && role.gpte_is_8_bytes);
+	WARN_ON_ONCE(role.direct && !role.gpte_is_8_bytes);
 
 	sp = kvm_mmu_get_page(vcpu, gfn, role);
 	++sp->root_count;
@@ -3482,7 +3483,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		for (i = 0; i < 4; ++i) {
 			WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
 
-			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), i,
+			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), 0,
 					      PT32_ROOT_LEVEL);
 			mmu->pae_root[i] = root | PT_PRESENT_MASK |
 					   shadow_me_mask;
@@ -3506,9 +3507,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	u64 pdptrs[4], pm_mask;
 	gfn_t root_gfn, root_pgd;
+	int quadrant, i, r;
 	hpa_t root;
-	unsigned i;
-	int r;
 
 	root_pgd = mmu->get_guest_pgd(vcpu);
 	root_gfn = root_pgd >> PAGE_SHIFT;
@@ -3591,7 +3591,15 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 			root_gfn = pdptrs[i] >> PAGE_SHIFT;
 		}
 
-		root = mmu_alloc_root(vcpu, root_gfn, i, PT32_ROOT_LEVEL);
+		/*
+		 * If shadowing 32-bit non-PAE page tables, each PAE page
+		 * directory maps one quarter of the guest's non-PAE page
+		 * directory. Othwerise each PAE page direct shadows one guest
+		 * PAE page directory so that quadrant should be 0.
+		 */
+		quadrant = !mmu->mmu_role.base.gpte_is_8_bytes ? i : 0;
+
+		root = mmu_alloc_root(vcpu, root_gfn, quadrant, PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
-- 
2.54.0

