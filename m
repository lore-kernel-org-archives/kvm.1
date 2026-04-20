Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24F33AD9C
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700052; cv=none; b=oB7Z0SkoXJEL/yZJIfZyoweZLus/BbpWCVmModfVmGQZB5B7Ri5eOyojW+On8vD9J3XOrJBuxaDa8DqfvW4jpPMFwBOU81rxzXBEQKywwWoYvButAcxIZB0ooGzAtmweVuAPTRJnJ/ja5ajRKBwFsZKao5YPqN4D8DOBx4Kxv6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700052; c=relaxed/simple;
	bh=m5oI8xKR95LnUc3sU4s6kScic2hB7omltXqMbf1r0u0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BnaUf5M/eJgXYfYLat4p1GDx3hi34naOIHZAGkQUPiPjSd0HWX3gnjtVDsnn7TGHm+mr+keLrkQFJ5DaXf+ROQGdrs4Ov+zbeBnxVlYbqbCk56EtrMu8MQVofwJbijFs/RD5cfQrwneZiT9cartoR49OxoT/G3p3Cu5ajagRKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Rg1AZW7I; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rg1AZW7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776700050; x=1808236050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O3WYh4WiFl4swQuKBeZd4hQQsq4vCwQKdbasa49RtYQ=;
  b=Rg1AZW7Id/J2boUtMkWMZ+uBhvN4z44pE6QK6a/hNJCc40tCqG3h/6tJ
   1jXRz4aQkz8XNsO/1p3hHtXx/tAEcG/27/iFZTHQSo9WRLmFfZMyI4gR5
   SLNXNjazPYDbkbD9dWeF33bFrw94YbN2jNUbeL8J0yTC+Mv7jOcqHCsHB
   chfIpoXhzknHhHpUGvTeIvITzBXENmwYLwHLoBjYLC8ofzKjbOT3DwdSf
   7t/XcvtY0QPUNRLmUnFXkcwLqUuAQ7+k9e0GzCgZKmK3x5mrYoxw7bxWr
   uxHutQZLv5KhZ60yPS+jfD1WfEanpOB4KWnv2ku6WriySdRfjqvsenWhW
   w==;
X-CSE-ConnectionGUID: ohBSaHU7SLinuYED3IC9XQ==
X-CSE-MsgGUID: 88uobVRZSoiq03WMdjms3Q==
X-IronPort-AV: E=Sophos;i="6.23,190,1770595200"; 
   d="scan'208";a="17538909"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 15:47:27 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:31648]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.92:2525] with esmtp (Farcaster)
 id 98c82ca6-cc61-4dae-80a1-0073c11efa62; Mon, 20 Apr 2026 15:47:27 +0000 (UTC)
X-Farcaster-Flow-ID: 98c82ca6-cc61-4dae-80a1-0073c11efa62
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:47:27 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:47:24 +0000
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
Subject: [RFC PATCH v4 0/7] KVM: pfncache: Add guest_memfd support to pfncache
Date: Mon, 20 Apr 2026 15:46:01 +0000
Message-ID: <20260420154720.29012-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

[ based on 6.18 with [1] ]

This patch series adds guest_memfd support to gfn_to_pfn_cache (a.k.a.
pfncache).  (This is still labelled RFC since its dependency [1] has not
yet been merged.)

=3D=3D=3D Problem Statement =3D=3D=3D

pfncache does not work with guest_memfd.  pfncaches resolve PFNs via
hva_to_pfn(), which requires a userspace mapping and relies on GUP.
This does not work for guest_memfd in the following two ways:

  * guest_memfd created without MMAP flag does not have a userspace
    mapping due to the nature of private memory.

  * guest_memfd created with NO_DIRECT_MAP flag uses an AS_NO_DIRECT_MAP
    mapping, which is rejected by GUP.

In addition, pfncaches map RAM pages via kmap(), which typically returns
an address derived from the direct map.  So kmap() cannot be used for
NO_DIRECT_MAP guest_memfd.  pfncaches require fault-free KHVAs since
they can be used from atomic context.  Thus, it cannot fall back to
access via a userspace mapping like KVM does for other accesses to
NO_DIRECT_MAP guest_memfd.

The introduction of guest_memfd support necessitates additional
invalidation paths in addition to the existing MMU notifier path: one
from guest_memfd invalidation and another from memory attribute updates.

=3D=3D=3D Core Approach =3D=3D=3D

  * Resolve PFNs for guest_memfd-backed GPAs via kvm_gmem_get_pfn().

  * Obtain a fault-free KHVA for NO_DIRECT_MAP pages via vmap().

  * Hook pfncache invalidation into guest_memfd invalidation (punch hole
    / release / error handling) as well as into memory attribute updates
    (switch between shared and private memories).

  * Reuse mn_active_invalidate_count to synchronize the new invalidation
    paths with the existing pfncache retry logic.

=3D=3D=3D Design Considerations (Feedback Appreciated) =3D=3D=3D

  * Reusing mn_active_invalidate_count allows reusing the existing
    pfncache retry logic as-is and enables invalidating pfncaches
    without holding mmu_lock from guest_memfd invalidation context.  As
    a side effect, active memslots swap is blocked while
    mn_active_invalidate_count > 0.  To avoid this block, it would be
    possible to introduce a dedicated counter instead.

  * Although both guest_memfd invalidation and memory attribute update
    are driven by GFN ranges, pfncache invalidation is performed using
    HVA ranges.  GPA-based pfncaches have memslot/GPA context, whereas
    HVA-based pfncaches do not.  Using GFN-based invalidation would
    miss HVA-based pfncaches.

  * The current implementation does not support HVA-based pfncaches for
    NO_DIRECT_MAP guest_memfd.  HVA-based pfncaches do not store
    memslot/GPA context, so they cannot determine whether the target is
    gmem-backed and always fall back to GUP (hva_to_pfn()), which fails
    for NO_DIRECT_MAP pages.  Adding a memslot/GPA lookup is possible
    but would add overhead to all HVA-based pfncache activations and
    refreshes.  At the time of writing, only Xen uses HVA-based
    pfncaches.

=3D=3D=3D Changelog =3D=3D=3D

Changes since RFC v3:
- Drop the rename of mn_* invalidate-related fields to generic ones, as
  suggested by Sean.  Keep the mn_ prefix.
- Fix incorrect HVA range computation in pfncache invalidation for
  guest_memfd and memory attribute update paths.  gfn_to_hva_memslot()
  with gfn_end =3D=3D slot->base_gfn + slot->npages triggers
  array_index_nospec() clamping, resulting in an empty range.  Use
  hva_start + (gfn_end - gfn_start) * PAGE_SIZE instead.
- Add selftests that exercise pfncache with guest_memfd-backed memory
  (NO_DIRECT_MAP and SW_PROTECTED_VM) and verify invalidation paths
  (punch_hole, private-to-shared conversion, file release).

Changes since RFC v2:
- Drop avoidance of silent kvm-clock activation failure.
- Fix a compile error for kvm_for_each_memslot().

Changes since RFC v1:
- Prevent kvm-clock activation from failing silently.
- Generalize serialization mechanism for invalidation.
- Hook pfncache invalidation into guest_memfd invalidation and memory
  attribute updates.

RFC v3: https://lore.kernel.org/all/20260310063647.15665-1-itazur@amazon.co=
m/
RFC v2: https://lore.kernel.org/all/20260226135309.29493-1-itazur@amazon.co=
m/
RFC v1: https://lore.kernel.org/all/20251203144159.6131-1-itazur@amazon.com/

[1]: https://lore.kernel.org/all/20260126164445.11867-1-kalyazin@amazon.com/

Takahiro Itazuri (7):
  KVM: pfncache: Resolve PFNs via kvm_gmem_get_pfn() for gmem-backed GPAs
  KVM: pfncache: Obtain KHVA via vmap() for gmem with NO_DIRECT_MAP
  KVM: Rename invalidate_begin to invalidate_start for consistency
  KVM: pfncache: Rename invalidate_start() helper
  KVM: pfncache: Invalidate on gmem invalidation and memattr updates
  KVM: selftests: Test pfncache with gmem-backed memory
  KVM: selftests: Test pfncache invalidation for gmem-backed memory

 arch/x86/kvm/mmu/mmu.c                        |   2 +-
 include/linux/kvm_host.h                      |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/pfncache_gmem_test.c    | 222 ++++++++++++++++++
 virt/kvm/guest_memfd.c                        |  64 ++++-
 virt/kvm/kvm_main.c                           |  55 ++++-
 virt/kvm/kvm_mm.h                             |  12 +-
 virt/kvm/pfncache.c                           | 110 +++++++--
 8 files changed, 427 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/pfncache_gmem_test.c

--=20
2.50.1

