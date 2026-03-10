Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A8264A97
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773124620; cv=none; b=Nd8FxBxWd3axuzHREIfry6P2ydxA1hBa2jKtuW+wpzZkYJkIvHA1kmYZY8TALuebugS7T8TeynDFW9F156W0q3M1bshnbaGgQFWKxp9Xm//0ZtskVRArhErtrctWkFUveRaRgCSuP9HDR9njyAfhkaJSCbI3NQSGDHm7Cer2Q7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773124620; c=relaxed/simple;
	bh=0+8U2b8VXYGXrDNtU4h6DgW1k26pziiM3lKC4kN1Ru4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Aa6sO+wMdwp3sQ0JYVyD17CylFVi+ZS7e2liAu5K0CiZhSyOQ8bhY2MhAJjaDLLjBPJ3ERz5/Ragro8XNxjRyKqIy0iSl/SCNjVIIbJNQ2ZOJvTRmgJooooPZ34uLwjMDGI3xBvQBHpeoWX77tAK+mYoLnGWMZpN1xz3l4NoxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=SUTRTPfi; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="SUTRTPfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773124619; x=1804660619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZBxIO/6K2vcG2mFfsbi0JwgR3ZSXAQbjOnmiOv3SSb8=;
  b=SUTRTPfiR1TV3D7OF+p8A79yxAHTH0iIlmtfMscivuYSXmJ9vOrJ2bO9
   agDVVPo7rnh+N0mZTa+9M30MT9/W0kyEa3Ks2wCuEEQxUHrxvAi043gAK
   WkItL8tRiZDamw7hbRLGp+4m9jghjEZxm/cDH8Khi2PtRbhAZhIX1rLFS
   8a4wSjCPMAhw6GLnGR26OYnWXRL2Kd7K0+t1ocNLnZ86aoJU9i+MS4Oj5
   TxZwBANYwgLRZJ5k5vAprQ3EeNbxzHKnZyMjtE8LB8fKn6A9r3AHVgZ75
   Xni2E4P6aYSKX0/UJbVUVWuxG3R4Y0S3UWG/ffEnOP7GW667YHSQp5K5M
   g==;
X-CSE-ConnectionGUID: 2lORn6mIRiubJ6N51zocQA==
X-CSE-MsgGUID: thzzB5dgSWGnWNHc9NNjUg==
X-IronPort-AV: E=Sophos;i="6.23,111,1770595200"; 
   d="scan'208";a="14690291"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 06:36:56 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:8137]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.3:2525] with esmtp (Farcaster)
 id d5e9b66b-a635-4444-a6b7-3b769a8654e1; Tue, 10 Mar 2026 06:36:55 +0000 (UTC)
X-Farcaster-Flow-ID: d5e9b66b-a635-4444-a6b7-3b769a8654e1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 10 Mar 2026 06:36:55 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 10 Mar 2026 06:36:53 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>,
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>,
	Nikita Kalyazin <kalyazin@amazon.com>, Patrick Roy
	<patrick.roy@campus.lmu.de>, Takahiro Itazuri <zulinx86@gmail.com>
Subject: [RFC PATCH v3 0/6] KVM: pfncache: Add guest_memfd support to pfncache
Date: Tue, 10 Mar 2026 06:36:35 +0000
Message-ID: <20260310063647.15665-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

[ based on v6.18 with [1] ]

This patch series is another follow-up to RFC v1 with minor fixes of RFC
v2.  (This is still labelled RFC since its dependency [1] has not yet
been merged.)  This change was tested for guest_memfd created with
GUEST_MEMFD_FLAG_MMAP and GUEST_MEMFD_FLAG_NO_DIRECT_MAP in the feature
branch of Firecracker [2].

=3D=3D=3D Problem Statement =3D=3D=3D

gfn_to_pfn_cache (a.k.a. pfncache) does not work with guest_memfd.  As
of today, pfncaches resolve PFNs via hva_to_pfn(), which requires a
userspace mapping and relies on GUP.  This does not work for guest_memfd
in the following two ways:

  * guest_memfd created with GUEST_MEMFD_FLAG_MMAP does not have a
    userspace mapping due to the nature of private memory.

  * guest_memfd created with GUEST_MEMFD_FLAG_NO_DIRECT_MAP uses an
    AS_NO_DIRECT_MAP mapping, which is rejected by GUP.

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

The core part keeps the original approach in RFC v1:

  * Resolve PFNs for guest_memfd-backed GPAs via kvm_gmem_get_pfn()

  * Obtain a fault-free KHVA for NO_DIRECT_MAP pages via vmap()

=3D=3D=3D Main Change since RFC v1 =3D=3D=3D

  * Hook pfncache invalidation into guest_memfd invalidation (punch hole
    / release / error handling) as well as into memory attribute updates
    (switch between shared and private memories).

=3D=3D=3D  Design Considerations (Feedback Appreciated) =3D=3D=3D

To implement the above change, this series tries to reuse as much of the
existing invalidation and retry infrastructure as possible.  The
following points are potential design trade-offs where feedback is
especially welcome:

  * Generalize and reuse the existing mn_active_invalidate_count
    (renamed to active_invalidate_count).  This allows reusing the
    existing pfncache retry logic as-is and enables invalidating
    pfncaches without holding mmu_lock from guest_memfd invalidation
    context.  As a side effect, active memslots swap is blocked while
    active_invalidate_count > 0.  To avoid this block, it would be
    possible to introduce a dedicated counter like
    gmem_active_invalidate_count in struct kvm instead.

  * Although both guest_memfd invalidation and memory attribute update
    are driven by GFN ranges, pfncache invalidation is performed using
    HVA ranges and reuses the existing function.  This is because
    GPA-based pfncaches translate GPA->UHVA->PFN and therefore have
    memslot/GPA info, whereas HVA-based pfncaches resolve PFN directly
    from UHVA and do not store memslot/GPA info.  Using GFN-based
    invalidation would therefore miss HVA-based pfncaches.  Technically,
    it would be possible to refactor HVA-based pfncaches to search for
    and retain the corresponding memslot/GPA at activation / refresh
    time instead of at invalidation time.

  * pfncaches are not dynamically allocated but are statically allocated
    on a per-VM and per-vCPU basis.  For a normal VM (i.e. non-Xen),
    there is one pfncache per vCPU.  For a Xen VM, there is one per-VM
    pfncache and five per-vCPU pfncaches.  Given the maximum of 1024
    vCPUs, a normal VM can have up to 1024 pfncaches, consuming 4 MB of
    virtual address space.  A Xen VM can have up to 5121 pfncaches,
    consuming approximately 20 MB of virtual address space.  Although
    the vmalloc area is limited on 32-bit systems, it should be large
    enough and typically tens of TB on 64-bit systems (e.g. 32 TB for
    4-level paging and 12800 TB for 5-level paging on x86_64).  If
    virtual address space exhaustion became a concern, migration to
    mm-local region (forthcoming mermap?) could be considered in the
    future.  Note that vmap() only creates virtual mappings to existing
    pages; they do not allocate new physical pages.

  * With this patch series, HVA-based pfncaches always resolve PFNs
    via hva_to_pfn(), and thus activation for NO_DIRECT_MAP guest_memfd
    fails.  It is technically possible to support this scenario, but it
    would require searching the corresponding memslot and GPA from the
    given UHVA in order to determine whether it is backed by
    guest_memfd.  Doing so would add overhead to the HVA-based pfncache
    activation / refresh paths, to a greater or lesser extent,
    regardless of guest_memfd-backed or not.  At the time of writing,
    only Xen uses HVA-based pfncaches.

=3D=3D=3D Changelog =3D=3D=3D

Changes since RFC v2:
- Drop avoidance of silent kvm-clock activation failure.
- Fix a compile error for kvm_for_each_memslot().

Changes since RFC v1:
- Prevent kvm-clock activation from failing silently.
- Generalize serialization mechanism for invalidation.
- Hook pfncache invalidation into guest_memfd invalidation and memory
  attribute updates.

RFC v2: https://lore.kernel.org/all/20260226135309.29493-1-itazur@amazon.co=
m/
RFC v1: https://lore.kernel.org/all/20251203144159.6131-1-itazur@amazon.com/

[1]: https://lore.kernel.org/all/20260126164445.11867-1-kalyazin@amazon.com/
[2]: https://github.com/firecracker-microvm/firecracker/tree/feature/secret=
-hiding

Takahiro Itazuri (6):
  KVM: pfncache: Resolve PFNs via kvm_gmem_get_pfn() for gmem-backed GPAs
  KVM: pfncache: Obtain KHVA via vmap() for gmem with NO_DIRECT_MAP
  KVM: Rename invalidate_begin to invalidate_start for consistency
  KVM: pfncache: Rename invalidate_start() helper
  KVM: Rename mn_* invalidate-related fields to generic ones
  KVM: pfncache: Invalidate on gmem invalidation and memattr updates

 Documentation/virt/kvm/locking.rst |   8 +-
 arch/x86/kvm/mmu/mmu.c             |   2 +-
 include/linux/kvm_host.h           |  13 ++--
 include/linux/mmu_notifier.h       |   4 +-
 virt/kvm/guest_memfd.c             |  64 ++++++++++++++--
 virt/kvm/kvm_main.c                | 101 ++++++++++++++++++-------
 virt/kvm/kvm_mm.h                  |  12 +--
 virt/kvm/pfncache.c                | 114 ++++++++++++++++++++---------
 8 files changed, 229 insertions(+), 89 deletions(-)

--=20
2.50.1

