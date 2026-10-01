Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27B3B1EEF
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894747; cv=none; b=BqSlNVj9Zgv0DlJVCbKkV6N4FFXB7Y2NTPswIHzXdal7T7c0/nFwonSwJmcXHRIaJMrDZTw9aMmpzIwrk4Ard/72zVlxP4H1uORFNYe3ajcvUzVT60QXpKRuB43fIWNFRWKLWhsOUE2xAWCp0yWZ6odLxf2HZuglbuY/UGYJDqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894747; c=relaxed/simple;
	bh=1lmvz1gSrAujeaxqnCoydH1/hO6InoEWG6kj/zEEDSY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DhwdVvJNzrXZ2xsKySR8MwNME7D+evvb3WTmIXlkliPbpTXkznXpuImQ213IDU0NBpBhmazSJwtBPqV6PNSQkN6o1QWrvZB/iLGN7NfuJemgZI+WlQSf850CgkSrhc4WfZmQC136rItUrs2Ke7WEHvj5J0LHQT0z0sEy/U25Ots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S12QMDAM; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S12QMDAM"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so5110918a12.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 15:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790894745; x=1791499545; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N7eSAUXHwsAygHXMeAum7tZT9f+Wmgg5m71MP+aREYo=;
        b=S12QMDAMqQRddohmLKtvCjCjVMpwjreCCWbCR6r26AvHGWMh8rdE3K1oLE+YIWKTX9
         o2F0UMXkS5PJ1U7Kt4EhJlUszyOJhRvZL/RN8J/06fCrbHWqZGBQ0AucilndlJ5uPjKK
         EkG5fUGtzBLU/BiLBk+EgAo+6qzwxXZqHuCtfh3nQBEiCqMbG0K3u9MOicGt7l7Xtjvf
         g2dQWXjmJN4CQc9qah5kkc8Uofm8YUenTDDrpHhwJ9iOAUY8z5BzzWID395Gr/uTl3p0
         gxcDXnpn5ggAzuTFVIvnl7lzOJn82oVxxOrFLWRAXeWsWoE8XDv+O4W97Tm2iP2BtQxs
         F1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894745; x=1791499545;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7eSAUXHwsAygHXMeAum7tZT9f+Wmgg5m71MP+aREYo=;
        b=Kz2Gv24bfvXojUgF7CoeWjhRDLuUIl+dwpVRKnHYZ4bcHlnv4MCs9eOMWSnNpr0YWh
         Rj1JchvpixuM6lnEXvozMzaXKRH+2FyzTn/lqzCqFYSpH6mFqDJtr0UQBiQj4p2Mursd
         WvNGYpVx52uK13Uxp8E6pLkXGeI4SLX9FmZHNT6tBSYG778KL9aDSDdQCGxuEMYvlAik
         ueVeRiyvFDMR9cPnFcDvgol25Ehhcrx7cxG6NIfCSN68c+lAhCVw3uPLl4oZJwdGy7C/
         D+dPt7hzu2KnbvoeUoV0ZIJWvW54lL219nxrS9M8NCF21z+DlntSNA6bSGU5lqHZ3AjS
         jEBA==
X-Forwarded-Encrypted: i=1; AKwUvBwjuFzffzIjH/YLm7uwc1iKF04duGGV9e0DlVTRi5tddD2fTI9nuww7lQ9Q8vtxddLLCiY=@vger.kernel.org
X-Gm-Message-State: AFuF++nB1aGmCU5PltDVTnUxtwaa+7TBwHjnwCwKSi7b1gP8cMRw73C+
	CPD6VWNjImA7YbuqsP1wmLKLbLy9oDbeFNCNnvI7EFcaa0xX9KxerY+Qv0m6wTziSxxE/C/XJza
	62A==
X-Received: from pgdh4.prod.google.com ([2002:a05:6a02:5184:b0:cc9:f746:40c4])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a344:b0:3dd:a00a:7ad0
 with SMTP id adf61e73a8af0-3e0bd3e5169mr730038637.61.1790894744569; Thu, 01
 Oct 2026 15:45:44 -0700 (PDT)
Date: Thu,  1 Oct 2026 22:45:24 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001224531.765278-1-praan@google.com>
Subject: [RFC PATCH 0/7] iommu: Introduce Page Table Observability Framework
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Logan Odell <loganodell@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce an observability framework to track and expose IOMMU page table
memory usage per domain. As VMMs and userspace drivers map and unmap large,
sparse IOVA regions through VFIO and iommufd, page table directories are
often left allocated but completely empty. generic_pt frees a table when a
single unmap covers it entirely, but tables that empty through a series of
partial unmaps stay allocated until the domain is destroyed.

Currently, this *stranded* memory is only visible in aggregate
(nr_iommu_pages in /proc/vmstat, and sec_pagetables in the memcg
memory.stat). There is no way to tell which domain, and hence which VFIO
container or iommufd context, owns it. On a host, it shows up as a drop in
available memory with no corresponding owner and has resulted in OOMs
without any diagnostic information.

The series implements the tracking infrastructure to attribute this
memory to its domain and exposes it per fd, so that userspace / telemetry
can see which VFIO container or iommufd context holds it.

Design
======
The tracking is implemented once, within the generic_pt library:

 - struct iommu_domain gains an atomic_long_t nr_pages counter.
 - To avoid expanding existing metadata structures, struct ioptdesc
   repurposes the unused page->private slot to alias the owning
   struct iommu_domain pointer. The ioptdesc layout stays identical to
   struct page.
 - The core page allocator (iommu_alloc_pages_node_sz()) is wrapped with
   an attributed variant, iommu_alloc_pages_node_sz_attributed(), which
   charges the domain on allocation. The common free path uncharges it
   using the stored domain pointer, so no free call site changes.
 - generic_pt's table allocator uses the attributed variant, so every
   driver built on generic_pt gains accounting without driver changes.

The cost is one atomic operation per page table allocation and free. Leaf
map and unmap are unchanged.

Userspace interface
===================
The per-domain counts are aggregated when fdinfo is read, and exposed
through /proc/<pid>/fdinfo/<fd>:

 - VFIO container fd (type1): summed over all attached domains.
 - iommufd fd: summed over all paging HWPTs in the context. Nested HWPTs
   are skipped as their stage-1 page tables are owned by userspace.

Both backends report the same key, so tooling does not need to know
whether a VMM uses VFIO type1 or iommufd:

	iommu-nr-pages:	<pages>

Only domains whose page table is implemented by generic_pt account their
memory. If any relevant domain does not, the key is omitted rather than
reporting a misleading partial count. The field is documented in
Documentation/filesystems/proc.rst.

Built on generic_pt
=====================
All users of generic_pt in this tree: Intel VT-d (first and second stage),
AMD IOMMU (v1 and v2 page tables) and RISC-V. ARM SMMUv3 will gain
accounting once its conversion to generic_pt lands. [1]

Open questions
==============
 - Is a single, backend-agnostic fdinfo key preferred over per-backend
   keys (e.g. vfio-nr-pages / iommufd-nr-pages)?
 - Is omitting the key preferable to reporting a partial count when a
   domain without accounting is attached?
 - The value is in pages, consistent with nr_iommu_pages in /proc/vmstat.
   Would bytes be preferred?
 - Is aliasing page->private through the ioptdesc overlay acceptable?

Upcoming Work / Roadmap
=======================
An IO page table shrinker, which reclaims empty leaf directories under
memory pressure, is posted separately as an RFC. The two series are
independent. Per-domain accounting is useful on its own, and also
quantifies the memory such reclaim could recover.

There's an alignment session at Linux Plumbers Conference 2026 for these [2]

[1] https://lore.kernel.org/all/0-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com/
[2] https://lpc.events/event/20/contributions/2624/

Logan Odell (1):
  vfio/type1: Expose IO page table usage via fdinfo

Pranjal Shrivastava (6):
  iommu: Add infrastructure for per-domain IOPT accounting
  iommu: Implement domain-attributed page allocation
  iommupt: Enable per-domain IOPT attribution
  iommufd: Expose IO page table usage via fdinfo
  iommufd/selftest: Add observability test for iommu-nr-pages
  vfio/selftests: Add observability test for IO page table usage

 Documentation/filesystems/proc.rst            |  34 +++++
 drivers/iommu/generic_pt/iommu_pt.h           |   7 +-
 drivers/iommu/iommu-pages.c                   |  35 +++++-
 drivers/iommu/iommu-pages.h                   |  25 +++-
 drivers/iommu/iommufd/main.c                  |  38 ++++++
 drivers/vfio/container.c                      |  21 ++++
 drivers/vfio/vfio.h                           |   2 +
 drivers/vfio/vfio_iommu_type1.c               |  21 ++++
 include/linux/iommu.h                         |   2 +
 tools/testing/selftests/iommu/iommufd.c       |  48 +++++++
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_nr_pages_test.c       | 119 ++++++++++++++++++
 12 files changed, 347 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_nr_pages_test.c


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

