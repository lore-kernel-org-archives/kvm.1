Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429573396EE
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700077; cv=none; b=YyZ2Yh4msWGXKpDJ9pGYWpvzHkoJQyKJuT63aM8PV0FDIE7aVNHIpqMQTdqx1YlBQpMBTQhOGw3YXzS5L7SP2/weehwE02bMUk83CGx4t/3Q0doL+AFkl/nEPb7P8gCkDna/VV+HZvFsk2+Z42Tt8AvAGMdHxwzlQshRcMEt/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700077; c=relaxed/simple;
	bh=9TN4OiXcuxlQjj1L545GimSHnDjoX3PVFD4/ClS30P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QviBQ8q2G5DIviYlSeG8LFYdBDycWN9/BgCD/JYb2hHnwkORrUnNoebJSSC44pe53L8xvN26wDnZo58bZ313w5Eo2SfK5CKmLrLUzLWwfIVgD6a3yQY4RWq+aa1cButNW1B/P9wMIMGgLkolMTGJnDurlgEKO5U9B5+Yw5SkbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YCdkmUiY; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YCdkmUiY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776700076; x=1808236076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJGGLcBpKhVtD2lBxtvU3QC61TM4tXnib4QYH85QQzQ=;
  b=YCdkmUiYlIR8ndjHfukF38TfkMp7YFFtFriMJYoQ8sVXoszHBgi2D8RN
   7L1yviHK5rOFEtGsFonf6BNardDa7aP7FKa2vzWVmkM8525xTHrhddwVG
   A8sVbDsurYKLloDedyzbgUflVOQ14kwTNOtOouUcUIAFXBTrQF1PmDQyT
   5b/YXu90RfwR4U3ULesFJ0b/w1VsZwIK85QJv/laMxiglmAODWAp3s/wU
   GCZcB01ezRp9sWFwdHW6vPdNpA94sTOK36lQ+mohz3NVht6fBe1Il74CJ
   enCc+OTQs0pLZpKXtnxLm4nk1aw82ODYBcSbZGtVHHSQ3nC1ITQ0gE4m6
   A==;
X-CSE-ConnectionGUID: WpigEnrYRdyxH39hoJs02w==
X-CSE-MsgGUID: 9mJmKPJURJ2fEkps6qM0LA==
X-IronPort-AV: E=Sophos;i="6.23,190,1770595200"; 
   d="scan'208";a="17734786"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 15:47:53 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:17624]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.92:2525] with esmtp (Farcaster)
 id 5a46d770-ec7e-4862-b79f-1af6be79379c; Mon, 20 Apr 2026 15:47:52 +0000 (UTC)
X-Farcaster-Flow-ID: 5a46d770-ec7e-4862-b79f-1af6be79379c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:47:52 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:47:50 +0000
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
Subject: [RFC PATCH v4 3/7] KVM: Rename invalidate_begin to invalidate_start for consistency
Date: Mon, 20 Apr 2026 15:46:04 +0000
Message-ID: <20260420154720.29012-4-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420154720.29012-1-itazur@amazon.com>
References: <20260420154720.29012-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Rename kvm_mmu_invalidate_begin() to kvm_mmu_invalidate_start() to
align with mmu_notifier_ops.invalidate_range_start(), which is the
callback that ultimately drives KVM's MMU invalidation.

While the naming within KVM itself is a close split between "_begin" and
"_start", conforming to the mmu_notifier_ops naming is the right call
since invalidate_range_start() is the external API that KVM hooks into.

  $ git grep -E "invalidate(_range)?_begin"  **/kvm | wc -l
  11
  $ git grep -E "invalidate(_range)?_start"  **/kvm | wc -l
  16

No functional change intended.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 arch/x86/kvm/mmu/mmu.c   |  2 +-
 include/linux/kvm_host.h |  2 +-
 virt/kvm/guest_memfd.c   | 14 +++++++-------
 virt/kvm/kvm_main.c      |  6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d3e705ac4c6f..e82a357e2219 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6859,7 +6859,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_sta=
rt, gfn_t gfn_end)
=20
 	write_lock(&kvm->mmu_lock);
=20
-	kvm_mmu_invalidate_begin(kvm);
+	kvm_mmu_invalidate_start(kvm);
=20
 	kvm_mmu_invalidate_range_add(kvm, gfn_start, gfn_end);
=20
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2ea5d2f172f7..618a71894ed1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1566,7 +1566,7 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_=
cache *mc);
 void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 #endif
=20
-void kvm_mmu_invalidate_begin(struct kvm *kvm);
+void kvm_mmu_invalidate_start(struct kvm *kvm);
 void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end);
 void kvm_mmu_invalidate_end(struct kvm *kvm);
 bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 5d6e966d4f32..79f34dad0c2f 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -206,7 +206,7 @@ static enum kvm_gfn_range_filter kvm_gmem_get_invalidat=
e_filter(struct inode *in
 	return KVM_FILTER_PRIVATE;
 }
=20
-static void __kvm_gmem_invalidate_begin(struct gmem_file *f, pgoff_t start,
+static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 					pgoff_t end,
 					enum kvm_gfn_range_filter attr_filter)
 {
@@ -230,7 +230,7 @@ static void __kvm_gmem_invalidate_begin(struct gmem_fil=
e *f, pgoff_t start,
 			found_memslot =3D true;
=20
 			KVM_MMU_LOCK(kvm);
-			kvm_mmu_invalidate_begin(kvm);
+			kvm_mmu_invalidate_start(kvm);
 		}
=20
 		flush |=3D kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
@@ -243,7 +243,7 @@ static void __kvm_gmem_invalidate_begin(struct gmem_fil=
e *f, pgoff_t start,
 		KVM_MMU_UNLOCK(kvm);
 }
=20
-static void kvm_gmem_invalidate_begin(struct inode *inode, pgoff_t start,
+static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
 				      pgoff_t end)
 {
 	enum kvm_gfn_range_filter attr_filter;
@@ -252,7 +252,7 @@ static void kvm_gmem_invalidate_begin(struct inode *ino=
de, pgoff_t start,
 	attr_filter =3D kvm_gmem_get_invalidate_filter(inode);
=20
 	kvm_gmem_for_each_file(f, inode->i_mapping)
-		__kvm_gmem_invalidate_begin(f, start, end, attr_filter);
+		__kvm_gmem_invalidate_start(f, start, end, attr_filter);
 }
=20
 static void __kvm_gmem_invalidate_end(struct gmem_file *f, pgoff_t start,
@@ -287,7 +287,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, lo=
ff_t offset, loff_t len)
 	 */
 	filemap_invalidate_lock(inode->i_mapping);
=20
-	kvm_gmem_invalidate_begin(inode, start, end);
+	kvm_gmem_invalidate_start(inode, start, end);
=20
 	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
=20
@@ -401,7 +401,7 @@ static int kvm_gmem_release(struct inode *inode, struct=
 file *file)
 	 * Zap all SPTEs pointed at by this file.  Do not free the backing
 	 * memory, as its lifetime is associated with the inode, not the file.
 	 */
-	__kvm_gmem_invalidate_begin(f, 0, -1ul,
+	__kvm_gmem_invalidate_start(f, 0, -1ul,
 				    kvm_gmem_get_invalidate_filter(inode));
 	__kvm_gmem_invalidate_end(f, 0, -1ul);
=20
@@ -582,7 +582,7 @@ static int kvm_gmem_error_folio(struct address_space *m=
apping, struct folio *fol
 	start =3D folio->index;
 	end =3D start + folio_nr_pages(folio);
=20
-	kvm_gmem_invalidate_begin(mapping->host, start, end);
+	kvm_gmem_invalidate_start(mapping->host, start, end);
=20
 	/*
 	 * Do not truncate the range, what action is taken in response to the
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 60a8b7ca8ab4..5871882ff1db 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -678,7 +678,7 @@ static __always_inline int kvm_age_hva_range_no_flush(s=
truct mmu_notifier *mn,
 	return kvm_age_hva_range(mn, start, end, handler, false);
 }
=20
-void kvm_mmu_invalidate_begin(struct kvm *kvm)
+void kvm_mmu_invalidate_start(struct kvm *kvm)
 {
 	lockdep_assert_held_write(&kvm->mmu_lock);
 	/*
@@ -734,7 +734,7 @@ static int kvm_mmu_notifier_invalidate_range_start(stru=
ct mmu_notifier *mn,
 		.start		=3D range->start,
 		.end		=3D range->end,
 		.handler	=3D kvm_mmu_unmap_gfn_range,
-		.on_lock	=3D kvm_mmu_invalidate_begin,
+		.on_lock	=3D kvm_mmu_invalidate_start,
 		.flush_on_ret	=3D true,
 		.may_block	=3D mmu_notifier_range_blockable(range),
 	};
@@ -2571,7 +2571,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm,=
 gfn_t start, gfn_t end,
 		.end =3D end,
 		.arg.attributes =3D attributes,
 		.handler =3D kvm_pre_set_memory_attributes,
-		.on_lock =3D kvm_mmu_invalidate_begin,
+		.on_lock =3D kvm_mmu_invalidate_start,
 		.flush_on_ret =3D true,
 		.may_block =3D true,
 	};
--=20
2.50.1

