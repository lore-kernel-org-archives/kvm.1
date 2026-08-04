Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A684A3E3160
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862691; cv=none; b=ERoH79xaJG0ovXqBaEKDZOXm4nQ7l/0HCbvk2vsTSyT3YwtLa1V9xocOeZ7M3x7t4nYVhkIjf/15FqPYPTHWcSiFGtzBpblKJQf/slNN/OEtcXHZXfdaIfCtlC+6zyEzXUeyHUYqLGb1VqAdrvzBwRV7BVHbmgxYN1xlKzwtH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862691; c=relaxed/simple;
	bh=aEq03hVd1VqCv8H9eT+31jEh9G4AVqdXNw9p8XpWoMM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l5U3KoROMZ/l7FgpqyttWliKb80g/kBZUj/JlMGwLOmxyVhJ07kHAeOfuoDxEA3bsdgbWHhODC9dHtGMm9RB8YWdOyfu6RNAZkEe4e7YG6OF2FWW6A0SezmfMMRjhiSCc1iGfE0Nbdp9A47dfuFzQZGYfTuvly6P3rL9r6QSCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MixVyoug; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MixVyoug"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfca8558d2so769065ad.2
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785862673; x=1786467473; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZU6BXABcw5TcG9MPR13YjBzowOlQg7/qkmOdX4qPjsI=;
        b=MixVyoug0dabABvP0VaV99SlMpbCuNh7HCHbF+OaaFVDdftskwT1pNbxvdT7s1wOmX
         mePSRJr9E0hfl0WqsyKgTsaIv6fM1xJA6GFiv+aCmVI/sUyQHqzVESli2Rj0Vx8aJmwT
         Jh0r+ZfKlEpMM0fJULoLF5X2Pgj3tyc8f6FugS1RYyfE9qsZNkjKaihg9YduVtCUR/UA
         bXQQoPN51lzpDiFtu3b4kbekwjPO7JY/w3iGvCAwZplpMTTS+/SvxqG+UkrrmSIbSy0m
         I69bmK0uvncG2EdvSAlhOj9eJk3LQY9bMkabrzDAeFs/Zex12tJ4qo4eYix40bD3kzrL
         mqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862673; x=1786467473;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZU6BXABcw5TcG9MPR13YjBzowOlQg7/qkmOdX4qPjsI=;
        b=jhMzmqFkhmRjgMYYHJFL6qzFxrsgxV8mhN4PpEH8yQSbNOiAGMy+DeThK9PYIlcQPW
         lvYv42YOo/VL0FKoFcvk9pLjYqfs6iVxxHeHpd7suYzuNhY+WNqff/zxzhN5Tlu8+BFf
         1osvajXjOx07n5GMXFUOuqaPmbsd4rAc/izhKLyLXVSUlV9GllDHAXvKjFSty/AuX1yc
         FH6yDG24i5b6/vmFDy5Qu24FgG6+zqqlUG7mLgwdxUTTvWB7W4x4As7zJAq2SgynUQc7
         +O0wx0a48b6t6Icg5ujKVp5hNi+DdBqRvqYI56P+/jnTw5EO8Qo2dRT6JjsaU6yNTF+e
         Zmrg==
X-Gm-Message-State: AOJu0Ywl6rqzvUWjtC+korCks/Kk4+uv5j8H7AugB4pB/HJtTvyB4uVN
	l9u4MA8ukXMiopwS9jpyjOYWajmHbfVogBwtrTDuMpSE1K2IADslyMjJQMuY/W6FTBJt/E3YCwa
	sg7BxowsNc0399h5yrmTE/7zKOt8eTeHw3vWSAZPSM2drSz38FHHHQjCofTICZEuVItDRtf/X6W
	Yo6NjkZfvw/dFW56dQPU+gtPqtVrj73egN01vImN/pRovpkyQAb4xf8A==
X-Received: from dyx1.prod.google.com ([2002:a05:693c:8201:b0:313:d984:da01])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d547:b0:2c9:b8b7:5d1c with SMTP id d9443c01a7336-2d0ca7faee4mr1907945ad.16.1785862672208;
 Tue, 04 Aug 2026 09:57:52 -0700 (PDT)
Date: Tue,  4 Aug 2026 16:57:44 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260804165748.1060476-1-aaronlewis@google.com>
Subject: [PATCH v2 0/4] Introduce vfio_dma_mapping_perf_test
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new VFIO selftest, vfio_dma_mapping_perf_test, to provide a
configurable tool for measuring DMA mapping and unmapping latencies.

This selftest introduces command-line parameters to provide a convenient
way to tune the test for specific situations. For example, it can be used
to observe the lengthy unmap times of the Type 1 IOMMU on large memory
regions, or to compare DMA mapping performance between the Type 1 IOMMU
and IOMMUFD. These scenarios can now be easily configured and run via the
command line.

Changes in V2:
- Assert expected unmap size in iommu_unmap().
- Remove unused struct iommu_mapping
- Create a reusable TIME() macro and move timer-related helpers to libvfio to
  output nanoseconds
- Unified latency reporting by pulling over the TIME() macro instead of
  distinct test-specific prints.
- Drop confusing prints mixing size/addresses in favor of parsing-friendly
  outputs.
- Fix potentially undefined behavior on 32-bit caused by passing u64 directly
  to %lu.
- Refactored memfd tests to run only on MODE_IOMMUFD and drop redundant
  variants.
- Removed MAP_SHARED from memfd_create flags to avoid inadvertently aliasing
  MFD_CLOEXEC.
- Fixed memfd_create() return validation to correctly verify against < 0.
- Updated the map/unmap failure block to properly abort/SKIP on ENOMEM hugepage
  failures.
- Store the device_bdf parameter statically within test_params to unify
  configuration definitions.
- Eliminate memory leaks in populate_harness_args by correctly piping argv into
  wordexp with WRDE_APPEND on subsequent uses.  Subsequent uses now works whether
- Halt execution and exit gracefully if invalid configurations or the
  "-h" flag are supplied, preventing test execution dropout.

Aaron Lewis (4):
  vfio: selftests: Assert the region was unmapped in iommu_unmap()
  vfio: selftests: Introduce vfio_dma_mapping_perf_test
  vfio: selftests: Add memfd test to vfio_dma_mapping_perf_test
  vfio: selftests: Allow a size for vfio_dma_mapping_perf_test

 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/lib/include/libvfio.h      |  28 ++
 .../vfio/lib/include/libvfio/iommu.h          |  12 +-
 tools/testing/selftests/vfio/lib/iommu.c      |  24 ++
 .../vfio/vfio_dma_mapping_perf_test.c         | 331 ++++++++++++++++++
 .../selftests/vfio/vfio_dma_mapping_test.c    |  11 +-
 6 files changed, 397 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c

-- 
2.55.0.654.g21b8a5bc05-goog

