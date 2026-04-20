Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD93385B6
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700060; cv=none; b=AOwiOmuDU5gS1NQBwwtMfakiHTEVLS8/XoZPER79Q1jAAPYRWqAJCE1Zgz+VRSGhZRPwz/fEVK37tGT/kuYrV/WPz0AWP4TZ6pB8jV+i54zksK20Tp2F0OPNZvKujAp2hBfDuoO23cjWAr6Alf4Yk+xmN8oqvKMMiSdkP44lSJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700060; c=relaxed/simple;
	bh=OcLrLLIE/hIaG8bggXrTmijf2mk1SleRxO9jo9uCh70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPJ5LUa7EJ+em6e+vrNomdo7nqWpOACjHHxuI5+7nahRcbt1vVj7YxH6k3fdz2JdP9LSD+2bJY9Wc7qEtIrKu6uIbac8aMl5RSgr9XHOVjx5xnbK7c6hj5up0weqyki6/oYQLx4CZz61MxywgyFx/MC3nk2837Q38AJbpGzoYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LnlgGjBa; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LnlgGjBa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776700059; x=1808236059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I2FOsfuSS/Ww2ymrNnWkOmfFguzo1BZYutmy3hHFVLs=;
  b=LnlgGjBaUWLAOdldGpMOQJSMXxYazIpQC93MdJ60jZ+yYfnH8urQFXxN
   oxe2Pud6zJqnWGavznDuVlbKFvhKXozuMBvHdv8Mip0rhkd+C/zMIHK7z
   SyaZimgrdsfkrOmGrnJXQp2O7sqo/S6PGs9FAapSj13jo9a3GGfgylTZl
   MCPAzxDdlFCerOTTSlY6/HQ91A7/Ad0JbmxMnhyySe9XUutsVFupewg/g
   ju9oC7hkfHraCp9De6/D4AIyFvta8qPzdQATawfIUdnEKwzlWclbq77gA
   HAwycbbqiwk9uhjpGYKCtLoziUUi0xhOiTQ8BRnMzdiZVZOzo5vBfgFxS
   w==;
X-CSE-ConnectionGUID: rq8PJla2Q8eClmQImyPJKg==
X-CSE-MsgGUID: 0ckO+/8UQ8uhsEhkT5UX5Q==
X-IronPort-AV: E=Sophos;i="6.23,190,1770595200"; 
   d="scan'208";a="17618016"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 15:47:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:8921]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.27:2525] with esmtp (Farcaster)
 id 6c462ef4-4dd2-4ffa-9e8d-adacb80059e0; Mon, 20 Apr 2026 15:47:36 +0000 (UTC)
X-Farcaster-Flow-ID: 6c462ef4-4dd2-4ffa-9e8d-adacb80059e0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:47:34 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:47:31 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>,
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>,
	Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick Roy
	<patrick.roy@campus.lmu.de>, Patrick Roy <patrick.roy@linux.dev>, "Derek
 Manwaring" <derekmn@amazon.com>, Alina Cernea <acernea@amazon.com>, "Michael
 Zoumboulakis" <zoumboul@amazon.com>, Takahiro Itazuri <zulinx86@gmail.com>,
	Takahiro Itazuri <itazur@amazon.com>
Subject: [RFC PATCH v4 1/7] KVM: pfncache: Resolve PFNs via kvm_gmem_get_pfn() for gmem-backed GPAs
Date: Mon, 20 Apr 2026 15:46:02 +0000
Message-ID: <20260420154720.29012-2-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420154720.29012-1-itazur@amazon.com>
References: <20260420154720.29012-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Currently, pfncaches always resolve PFNs via hva_to_pfn(), which
requires a userspace mapping and relies on GUP.  This does not work for
guest_memfd in the following two ways:

  * guest_memfd created without MMAP flag does not have a userspace
    mapping.

  * guest_memfd created with NO_DIRECT_MAP flag uses an AS_NO_DIRECT_MAP
    mapping, which is rejected by GUP.

Resolve PFNs via kvm_gmem_get_pfn() for guest_memfd-backed and GPA-based
pfncaches.  Otherwise, fall back to the existing hva_to_pfn().

The current implementation does not support HVA-based pfncaches for
NO_DIRECT_MAP guest_memfd.  HVA-based pfncaches do not store
memslot/GPA context, so they cannot determine whether the target is
guest_memfd-backed and always fall back to hva_to_pfn().  Adding a
memslot/GPA lookup is possibile but would add overhead to all HVA-based
pfncache activations and refreshes.  At the time of writing, only Xen
uses HVA-based pfncaches.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 virt/kvm/pfncache.c | 66 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b488a..ad41cf3e8df4 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -152,7 +152,53 @@ static inline bool mmu_notifier_retry_cache(struct kvm=
 *kvm, unsigned long mmu_s
 	return kvm->mmu_invalidate_seq !=3D mmu_seq;
 }
=20
-static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
+/*
+ * Determine whether a GPA-based pfncache is backed by guest_memfd, i.e. n=
eeds
+ * to be resolved via kvm_gmem_get_pfn() rather than GUP.
+ *
+ * The caller holds gpc->refresh_lock, but does not hold gpc->lock nor
+ * kvm->slots_lock.  Reading slot->flags (via kvm_slot_has_gmem() and
+ * kvm_memslot_is_gmem_only()) is safe because memslot changes bump
+ * slots->generation, which is detected in kvm_gpc_check(), forcing callers
+ * to invoke kvm_gpc_refresh().
+ *
+ * Looking up memory attributes (via kvm_mem_is_private()) can race with
+ * KVM_SET_MEMORY_ATTRIBUTES, which takes kvm->slots_lock to serialize
+ * writers but doesn't exclude lockless readers.  Handling that race is de=
ferred
+ * to a subsequent commit that wires up pfncache invalidation for gmem eve=
nts.
+ */
+static inline bool gpc_is_gmem_backed(struct gfn_to_pfn_cache *gpc)
+{
+	lockdep_assert_held(&gpc->refresh_lock);
+
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
@@ -161,14 +207,6 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_ca=
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
@@ -206,7 +244,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cac=
he *gpc)
 			cond_resched();
 		}
=20
-		new_pfn =3D hva_to_pfn(&kfp);
+		new_pfn =3D gpc_to_pfn(gpc, &page);
 		if (is_error_noslot_pfn(new_pfn))
 			goto out_error;
=20
@@ -319,7 +357,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *g=
pc, gpa_t gpa, unsigned l
 		}
 	}
=20
-	/* Note: the offset must be correct before calling hva_to_pfn_retry() */
+	/* Note: the offset must be correct before calling gpc_to_pfn_retry() */
 	gpc->uhva +=3D page_offset;
=20
 	/*
@@ -327,7 +365,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *g=
pc, gpa_t gpa, unsigned l
 	 * drop the lock and do the HVA to PFN lookup again.
 	 */
 	if (!gpc->valid || hva_change) {
-		ret =3D hva_to_pfn_retry(gpc);
+		ret =3D gpc_to_pfn_retry(gpc);
 	} else {
 		/*
 		 * If the HVA=E2=86=92PFN mapping was already valid, don't unmap it.
@@ -441,6 +479,10 @@ int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc,=
 unsigned long uhva, unsig
 	if (!access_ok((void __user *)uhva, len))
 		return -EINVAL;
=20
+	/*
+	 * HVA-based caches always resolve PFNs via GUP (hva_to_pfn()), which
+	 * does not work for NO_DIRECT_MAP guest_memfd.
+	 */
 	return __kvm_gpc_activate(gpc, INVALID_GPA, uhva, len);
 }
=20
--=20
2.50.1

