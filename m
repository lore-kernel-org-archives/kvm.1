Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92579342CA2
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700066; cv=none; b=pM5uNQXEEw9ZO24Y+nj6sX2scSv/74UHDKYooWtXvw0KxWKXxm6AgwLrk29oGNN1wBzB/F/HF26LrBh7tJeYzWacJ9USxXH4tzm4tKIGfvGGE3Y2DGNeGoqPCN9faDI3ZAkLXBTs1mxtk9qUHhtr9QBqwtH4ySnEPB0HH3UGd0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700066; c=relaxed/simple;
	bh=jPYVEwW1lXE/WVSI6Vhc2jO1m/MP39I8N3x4KH91U/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuinvjzpYtuSb8Sca91CUpykkrm9DbNptsIk7OZWTbO/XW66MWZv3b1ky7yuCWmOR+huGG2Ors7oqOADcv5GBg3BqkJUcSLBBSmp0e/9SuTgNMvOySkFOKtK9Rt8E7wW7zAKKbVWCTfSZyVuxU6ySv3oa2JyhRC+bf9bJzyGppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ibs9i/Op; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ibs9i/Op"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776700065; x=1808236065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=22p6u2/T4frvBgCFMaq8pWaJ3irvRleY8pPfYexYrlM=;
  b=Ibs9i/OpBtiU9Su8wTPIQSlSp2AfBJSjTTAh7ZBjDgDUybAZBo92Pjyg
   LC48jK9VsNgzwqmS87v2cnU4Gg0+ABLcnm7+jNQmzvY281n94a6iP4x40
   Lur00e37sEpHstpgu/YlOEWmejhOyi5yRBIhNok0p6jdAJoZlRfW0YeCA
   V8PnBEFEIcFfcdIWK1vh0IsUyuWq3tqxngG6/wDiPdPPmaEVXZajSI85L
   wxbvN8RJKuL4nxOqAADXRcF0YLV6m++itRy4TF+Ihsb6cjNlGBowVjdxC
   5W/TP0WJDdaLdzw8tpdZrycb/Mr1t/XE4HiVyQSSiVM8UGRYboFxd+vQB
   Q==;
X-CSE-ConnectionGUID: LxzWrAcyTtyILShF50YkAQ==
X-CSE-MsgGUID: pHK1pTZfTGq77RuRA7VnuQ==
X-IronPort-AV: E=Sophos;i="6.23,190,1770595200"; 
   d="scan'208";a="17741643"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 15:47:43 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:19487]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.92:2525] with esmtp (Farcaster)
 id 99b7f631-35e0-466d-9256-40321b707662; Mon, 20 Apr 2026 15:47:42 +0000 (UTC)
X-Farcaster-Flow-ID: 99b7f631-35e0-466d-9256-40321b707662
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:47:41 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:47:39 +0000
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
Subject: [RFC PATCH v4 2/7] KVM: pfncache: Obtain KHVA via vmap() for gmem with NO_DIRECT_MAP
Date: Mon, 20 Apr 2026 15:46:03 +0000
Message-ID: <20260420154720.29012-3-itazur@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Currently, pfncaches map RAM pages via kmap(), which typically returns a
kernel address derived from the direct map.  However, guest_memfd
created with GUEST_MEMFD_FLAG_NO_DIRECT_MAP has their direct map removed
and uses an AS_NO_DIRECT_MAP mapping.  So kmap() cannot be used in this
case.

pfncaches can be used from atomic context where page faults cannot be
tolerated.  Therefore, it cannot fall back to access via a userspace
mapping like KVM does for other accesses to NO_DIRECT_MAP guest_memfd.

To obtain a fault-free kernel host virtual address (KHVA), use vmap()
for NO_DIRECT_MAP pages.  Since gpc_map() is the sole producer of KHVA
for pfncaches and only vmap() returns a vmalloc address, gpc_unmap()
can reliably pair vunmap() using is_vmalloc_addr().

Although vm_map_ram() could be faster than vmap(), mixing short-lived
and long-lived vm_map_ram() can lead to fragmentation.  For this reason,
vm_map_ram() is recommended only for short-lived ones.  Since pfncaches
typically have a lifetime comparable to that of the VM, vm_map_ram() is
deliberately not used here.

pfncaches are not dynamically allocated but are statically allocated on
a per-VM and per-vCPU basis.  For a normal VM (i.e. non-Xen), there is
one pfncache per vCPU.  For a Xen VM, there is one per-VM pfncache and
five per-vCPU pfncaches.  Given the maximum of 1024 vCPUs, a normal VM
can have up to 1024 pfncaches, consuming 4 MB of virtual address space.
A Xen VM can have up to 5121 pfncaches, consuming approximately 20 MB of
virtual address space.  Although the vmalloc area is limited on 32-bit
systems, it should be large enough and typically tens of TB on 64-bit
systems (e.g. 32 TB for 4-level paging and 12800 TB for 5-level paging
on x86_64).  If virtual address space exhaustion becomes a concern,
migration to an mm-local region could be considered in the future.  Note
that vmap() and vm_map_ram() only create virtual mappings to existing
pages; they do not allocate new physical pages.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 virt/kvm/pfncache.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index ad41cf3e8df4..682dc3ba2216 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -16,6 +16,7 @@
 #include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/pagemap.h>
=20
 #include "kvm_mm.h"
=20
@@ -98,8 +99,19 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigne=
d long len)
=20
 static void *gpc_map(kvm_pfn_t pfn)
 {
-	if (pfn_valid(pfn))
-		return kmap(pfn_to_page(pfn));
+	if (pfn_valid(pfn)) {
+		struct page *page =3D pfn_to_page(pfn);
+		struct page *head =3D compound_head(page);
+		struct address_space *mapping =3D READ_ONCE(head->mapping);
+
+		if (mapping && mapping_no_direct_map(mapping)) {
+			struct page *pages[] =3D { page };
+
+			return vmap(pages, 1, VM_MAP, PAGE_KERNEL);
+		}
+
+		return kmap(page);
+	}
=20
 #ifdef CONFIG_HAS_IOMEM
 	return memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
@@ -115,7 +127,15 @@ static void gpc_unmap(kvm_pfn_t pfn, void *khva)
 		return;
=20
 	if (pfn_valid(pfn)) {
-		kunmap(pfn_to_page(pfn));
+		/*
+		 * For valid PFNs, gpc_map() returns either a kmap() address
+		 * (non-vmalloc) or a vmap() address (vmalloc).
+		 */
+		if (is_vmalloc_addr(khva))
+			vunmap(khva);
+		else
+			kunmap(pfn_to_page(pfn));
+
 		return;
 	}
=20
@@ -250,8 +270,11 @@ static kvm_pfn_t gpc_to_pfn_retry(struct gfn_to_pfn_ca=
che *gpc)
=20
 		/*
 		 * Obtain a new kernel mapping if KVM itself will access the
-		 * pfn.  Note, kmap() and memremap() can both sleep, so this
-		 * too must be done outside of gpc->lock!
+		 * pfn.  Note, kmap(), vmap() and memremap() can all sleep, so
+		 * this too must be done outside of gpc->lock!
+		 * Note that even though gpc->lock is dropped, it's still fine
+		 * to read gpc->pfn and other fields because gpc->refresh_lock
+		 * mutex prevents them from being updated.
 		 */
 		if (new_pfn =3D=3D gpc->pfn)
 			new_khva =3D old_khva;
--=20
2.50.1

