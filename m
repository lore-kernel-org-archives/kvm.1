Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0231346A1F
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773124915; cv=none; b=Fmfo/n1GD5BFyJTwcXUb1QRq5egwLyN4cfxnGEP247FW/32rHhdHG1DrVdhMHjHB/NRLZ8Pky2ptxp1bRNUNqBbdIM+2OA53db2Cpa7TImJ9cFfP8ATgcCumZoJnfRwz2JPdsOgIvqHQARhv4yK66bDAAQl3dW6DDpud7juMLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773124915; c=relaxed/simple;
	bh=P0gC67tnSQX0mNU0HQzopL57yaAEn7ZJ3nGjqkeUUMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuALAFhpfWOe6YMwleGjkVDA1yuLSqTJJN64vdWDDNLyeX0WiNaofarlXmqROzOhtCsJZkGlr7+0ov7vNN2EALD4cn4qP1cL+uMYCgsv0qCQN9e8JcuscTQuz7Ung4LWIGE8SAzE+yTn/HQkt6aoV54aZ89q8EhUGhZNg4aH6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=L1nON9G4; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="L1nON9G4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773124913; x=1804660913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sx8nEAEnqciCcz7NLUhk/REeGA+KiI2r3zkI88b133Q=;
  b=L1nON9G4B5hLcQ6UvD7uH0oMBRSqO7XEir1eqkAu4Q/K0dekK1e0pBnE
   8vPP6HeojjZ0DuZWFbvFxYNtghmN2itGklUs3MJxOwwy8f6cSbumZ1vRs
   Iwt2PDAi3ZjBSTYdnVM/fY8v8F1Z0WQ6+lbDeGUhqqmgaJKW75DpMqc0H
   fER6427/Wb2X/v7s/VxV88bXn9YT9/5dN04/uxpVWQc3lMzEOqPuuDMC+
   CwsIe86XVNdw3YD4nUTOjGr4jCF1Sv4Hm12KOzERzDfVDyosLB8NkmqS/
   JKqHvY5jO/wd945SFSup9nxlCxMiz4NRc7+7nX0qP+NAEoMVDQ6fnsKA+
   w==;
X-CSE-ConnectionGUID: fGZjnpgQS56nN2Es+lcw3Q==
X-CSE-MsgGUID: RoI81XnnQCuUwPsoH1Ikjg==
X-IronPort-AV: E=Sophos;i="6.23,111,1770595200"; 
   d="scan'208";a="14566927"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 06:41:50 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:23213]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.152:2525] with esmtp (Farcaster)
 id 6e65afff-0aad-4d95-b2a7-739569dd8354; Tue, 10 Mar 2026 06:41:50 +0000 (UTC)
X-Farcaster-Flow-ID: 6e65afff-0aad-4d95-b2a7-739569dd8354
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 10 Mar 2026 06:41:50 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 10 Mar 2026 06:41:47 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>,
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>,
	Nikita Kalyazin <kalyazin@amazon.com>, Patrick Roy
	<patrick.roy@campus.lmu.de>, Takahiro Itazuri <zulinx86@gmail.com>, "Takahiro
 Itazuri" <itazur@amazon.com>
Subject: [RFC PATCH v3 1/6] KVM: pfncache: Resolve PFNs via kvm_gmem_get_pfn() for gmem-backed GPAs
Date: Tue, 10 Mar 2026 06:41:41 +0000
Message-ID: <20260310064142.20365-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310063647.15665-1-itazur@amazon.com>
References: <20260310063647.15665-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Currently, pfncaches always resolve PFNs via hva_to_pfn(), which
requires a userspace mapping and relies on GUP.  This does not work for
guest_memfd in the following two ways:

  * guest_memfd created without GUEST_MEMFD_FLAG_MMAP does not have a
    userspace mapping for private memory.

  * guest_memfd created with GUEST_MEMFD_FLAG_NO_DIRECT_MAP uses an
    AS_NO_DIRECT_MAP mapping, which is rejected by GUP.

Resolve PFNs via kvm_gmem_get_pfn() for guest_memfd-backed and GPA-based
pfncaches.  Otherwise, fall back to the existing hva_to_pfn().

Note that HVA-based pfncaches always resolve PFNs via hva_to_pfn(), and
thus activation of HVA-based pfncaches for NO_DIRECT_MAP guest_memfd
fails.  Supporting this scenario would be technically possible, but
would require searching the corresponding memslot and GPA from the given
UHVA in order to determine whether it is backed by guest_memfd.  Doing
so would add overhead to the HVA-based pfncache activation / refresh
paths, to a greater or lesser extent, regardless of guest_memfd-backed
or not.  At the time of writing, only Xen uses HVA-based pfncaches.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 virt/kvm/pfncache.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b488a..5d16e2b8a6eb 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -152,7 +152,36 @@ static inline bool mmu_notifier_retry_cache(struct kvm=
 *kvm, unsigned long mmu_s
 	return kvm->mmu_invalidate_seq !=3D mmu_seq;
 }
=20
-static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
+static inline bool gpc_is_gmem_backed(struct gfn_to_pfn_cache *gpc)
+{
+	/* For HVA-based pfncaches, memslot is NULL */
+	return gpc->memslot && kvm_slot_has_gmem(gpc->memslot) &&
+	       (kvm_memslot_is_gmem_only(gpc->memslot) ||
+		kvm_mem_is_private(gpc->kvm, gpa_to_gfn(gpc->gpa)));
+}
+
+static kvm_pfn_t gpc_to_pfn(struct gfn_to_pfn_cache *gpc, struct page **pa=
ge)
+{
+	if (gpc_is_gmem_backed(gpc)) {
+		kvm_pfn_t pfn;
+
+		if (kvm_gmem_get_pfn(gpc->kvm, gpc->memslot,
+				     gpa_to_gfn(gpc->gpa), &pfn, page, NULL))
+			return KVM_PFN_ERR_FAULT;
+
+		return pfn;
+	}
+
+	return hva_to_pfn(&(struct kvm_follow_pfn) {
+		.slot =3D gpc->memslot,
+		.gfn =3D gpa_to_gfn(gpc->gpa),
+		.flags =3D FOLL_WRITE,
+		.hva =3D gpc->uhva,
+		.refcounted_page =3D page,
+	});
+}
+
+static kvm_pfn_t gpc_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 {
 	/* Note, the new page offset may be different than the old! */
 	void *old_khva =3D (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
@@ -161,14 +190,6 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_ca=
che *gpc)
 	unsigned long mmu_seq;
 	struct page *page;
=20
-	struct kvm_follow_pfn kfp =3D {
-		.slot =3D gpc->memslot,
-		.gfn =3D gpa_to_gfn(gpc->gpa),
-		.flags =3D FOLL_WRITE,
-		.hva =3D gpc->uhva,
-		.refcounted_page =3D &page,
-	};
-
 	lockdep_assert_held(&gpc->refresh_lock);
=20
 	lockdep_assert_held_write(&gpc->lock);
@@ -206,7 +227,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cac=
he *gpc)
 			cond_resched();
 		}
=20
-		new_pfn =3D hva_to_pfn(&kfp);
+		new_pfn =3D gpc_to_pfn(gpc, &page);
 		if (is_error_noslot_pfn(new_pfn))
 			goto out_error;
=20
@@ -319,7 +340,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *g=
pc, gpa_t gpa, unsigned l
 		}
 	}
=20
-	/* Note: the offset must be correct before calling hva_to_pfn_retry() */
+	/* Note: the offset must be correct before calling gpc_to_pfn_retry() */
 	gpc->uhva +=3D page_offset;
=20
 	/*
@@ -327,7 +348,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *g=
pc, gpa_t gpa, unsigned l
 	 * drop the lock and do the HVA to PFN lookup again.
 	 */
 	if (!gpc->valid || hva_change) {
-		ret =3D hva_to_pfn_retry(gpc);
+		ret =3D gpc_to_pfn_retry(gpc);
 	} else {
 		/*
 		 * If the HVA=E2=86=92PFN mapping was already valid, don't unmap it.
--=20
2.50.1

