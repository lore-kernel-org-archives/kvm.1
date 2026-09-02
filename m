Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FDD39EF33
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378436; cv=none; b=dbt+d9qdxWVIIbL5J2tOKIzBaQI4QjMeWdr3HmtvCc+5XAkM7Fz043i9Jyu8pif24GkSIUPBysmWhv5N1Zj+cMh8sM/Nk20SRN6yGxnIS1YcPjU8ar/T/4fy1ewl50yC0Vy4u8K0UYcktLgbAm6KJ7BKfK4YcS8uk2m0u2ML7GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378436; c=relaxed/simple;
	bh=ygs5b/4pGa9bJCsjvEaGg9guWrDVzMHPo/gVLjTXl70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0pghyjgMieZQAokcnKw5Q1pO8tsQPgIPp1wcwiUAxudTKEmWBvzugndTja44EhKaVQhzk2zcQ2yd+BwwwIetnDAo+kHNxhbn7DDSKl3TeAHPBwwG34Aj1awc3v5KPPbK1GLnKn6+DjRc39dTLpkFJX/0AwF9aYDP9lCoAm/FlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TyLxme58; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TyLxme58"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2a449c57so17981581cf.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788378420; x=1788983220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=043T58xMxK5U0+nF6j3a8AXR/ljZlHLZb140yWsthLI=;
        b=TyLxme58Qv0Ii9reFzSLtlTWKlXrBTmbXc0Cm05VwvrLo5Z2gn2AXnqy/3HjCBrLKD
         ZRvMgvXLB+dejUPByPJ16ijkiBZhysNjLflrtSihPnZWhi5TbyCkETdAiydABAwwJio4
         QS4ZksBVz8YhKXc/lvvpU0xQ20t+xKtyMmcXvzqLzNMIeHUstLrMYdP+ZVtujUTD6w9+
         3cH7f6M6ZfoQmaXbStfotCIeYs853eTyF2MC5+dICkikpoitkXq/oRHia5s3TUL2y1d4
         5R6QYmD1Xxpi0bQLdNfa2TXDMUDSonFyS0qr0q+VYiFoQ7xC190f+FAhwzSUzqt4vqdU
         jkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378420; x=1788983220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=043T58xMxK5U0+nF6j3a8AXR/ljZlHLZb140yWsthLI=;
        b=KPXkbi07gBPM1SJxqCEqU6LJL28+35VjIjmuyGBP7QiHcx1i2Q4XYReQg/3+ai7n/q
         SvCJzV5znwDeDHiOr1wzPCR5gCe91ZGyST8hybQFuXMu3EGhmx5MeSir876dU1T0h1DM
         1GVrZqM06IYgJwSDOte9b7mijDQKpH9d0ZdVZx9lOTbdKj5Y128h43Tm/nbTJtla044d
         5G2TmzgYCeph3/MqoD0KkumEWZqP4BE0awOXw0CaSi0LDTWkj1UowcqwNHhEBvjgfnVs
         3TnK/5xRfq7rSmQ0rhAzPgqujV8VLJAMuxPM+m4Lgo90E2CN6XkP3qVizICTFHIzGbzs
         pbhA==
X-Gm-Message-State: AFuF++malWCsIkFvBbpY6QvRPE99LWQLsANYapCjddh8fEB/zokA3SQc
	H9hMDevt6j7kKLV03wc+k7jtkNo0bQS3UrEdRn1pC3Cq0ba7DbovziuhWybohe1UXm0=
X-Gm-Gg: AYBFou0waxratCnf5XDlH6R65b4lOPIW09cXGxTaI8beoG8WMvI4QzaLCWe3zpdvD56
	yQB7Waj09fcgdKEHbs9futiBsUXR/uVHP3n3IufnMFKBhmB7j8Hwrh+mXJmJeEoU/VcpL78WJhd
	9v6/Tr4UE28fSnW3F8Rx81Lprw/puHfmkmZFrdUnWoBFWQDRjlpcGvPKTeNPtjRjqalDcLYJUn4
	fEF4MUrkkLo+OthgdmOmnbceYidTJ7IkkZMmL8hc2aMJ0w5xc+htRXkr6WM07HmbQDL43ssdnij
	Li4NjhCA/5kEH9YOIMvxcznR8yyphFhPrW0AJr4ViSIIEkSKs4S7F+/AKaUcmgvx8NqcTFMOG89
	SHnOGsIP5Vw0RzoTcqdeUyU3uAbMKGsAgCLyKukfy0jYJWESL3tE8Oc2m53XxuYok1OdagxXxKx
	AVTyYeK92Ax1ydIT+WV+JhVqfnMxoWD44NBQtcT/kp4g74MbE/fPMlinGsWBdteBKDT+3IugwYb
	gSLHRAf+uKVT2MUg0d9in69nPQ1zkA08850E4LZq/LJ2CdWXkmUBwUs8zkf
X-Received: by 2002:a05:620a:5bd3:b0:939:6de7:a623 with SMTP id af79cd13be357-9396de7ccf2mr158269885a.47.1788378420256;
        Wed, 02 Sep 2026 12:47:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f18801asm299300585a.16.2026.09.02.12.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:46:59 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	shuah@kernel.org
Subject: [PATCH 0/5] KVM: guest_memfd: bind backing memory to a NUMA node
Date: Wed,  2 Sep 2026 15:46:52 -0400
Message-ID: <20260902194657.79075-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

guest_memfd allocates its folios through a per-inode shared mempolicy.

Today that policy can only be set after the fact, with mbind() on a host
mmap of the fd. That requires the fd to be mappable, and it cannot reach
folios that are only ever guest-faulted. Neither holds for a
non-mappable (confidential) guest_memfd.

Add GUEST_MEMFD_FLAG_BIND_NODE and a node field to struct
kvm_create_guest_memfd. When set, KVM builds an MPOL_BIND policy for the
requested node and installs it over the whole inode, so every folio is
allocated there with no userspace mbind().

  1-2  mm/mempolicy prep. mempolicy_create() builds a validated,
       cpuset-contextualised policy without installing it into the
       calling task. mpol_set_shared_policy_range() installs one over a
       pgoff range with no VMA.
  3    The KVM flag.
  4-5  Selftest harness support, and the test.


Why a single node and not a full mempolicy?

  The fd is the unit of guest NUMA topology. A multi-node guest is one
  guest_memfd per guest node - or one range per node, since
  kvm_gmem_bind() is offset-based and mpol_set_shared_policy_range() is
  already range-capable - each bound to a host node, with the guest
  placing memory on top. This is the shape QEMU already builds with one
  memory-backend per guest node.

  Interleaving a single fd across host nodes would model a guest node
  whose pages are scattered underneath it. That defeats every placement
  decision the guest makes: guest NUMA balancing, tiering and weighted
  interleave would all be reasoning about a topology that doesn't exist.

  This narrow implementation enables the only clear use case.


User-visible behaviour:

  mempolicy_create() constrains the request to the task's cpuset.
  A node outside mems_allowed fails the ioctl with -EINVAL - the same
  constraint mbind() carries. A task cannot grant a guest_memfd access
  to a node it cannot reach itself.

  Nothing rebinds an inode's shared policy on a later cpuset change:
  mpol_rebind_task() walks tsk->mempolicy and mpol_rebind_mm() walks
  vma->vm_policy, and neither reaches a struct shared_policy. The bind
  is fixed for the life of the fd. This matches shmem's implementation.


Testing

  guest_memfd_test under virtme-ng, nested KVM:

  - 2-node guest, test pinned to the CPUs of the node it is not binding
    to, with the task mempolicy aimed at that other node. Pages land on
    the bound node, so the placement cannot be explained by the fault
    being local. Stripping the flag from the harness puts them on the
    other node, confirming the check has teeth.

  - CONFIG_NUMA=n: the flag is not advertised and the tests skip.

  - Single node: create/mmap/fault coverage, no placement claim.

Gregory Price (5):
  mm/mempolicy: add mempolicy_create()
  mm/mempolicy: add mpol_set_shared_policy_range()
  KVM: guest_memfd: bind backing memory to a NUMA node at creation
  selftests: KVM: guest_memfd: let the gmem_test() harness bind a node
  selftests: KVM: guest_memfd: test GUEST_MEMFD_FLAG_BIND_NODE

 include/linux/kvm_host.h                      |   3 +
 include/linux/mempolicy.h                     |   5 +
 include/uapi/linux/kvm.h                      |   5 +-
 mm/mempolicy.c                                |  75 +++++++++-
 .../testing/selftests/kvm/guest_memfd_test.c  | 134 ++++++++++++++++--
 virt/kvm/guest_memfd.c                        |  44 +++++-
 6 files changed, 248 insertions(+), 18 deletions(-)

---

base-commit: da6c37ed8beb273e3308e42d4bca3ce11b4432fa

-- 
2.53.0-Meta

