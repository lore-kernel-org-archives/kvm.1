Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4738D400
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054420; cv=none; b=I286s1E6hKiYp9ZRK6JeX57/hIsCzM3FuJo94hdo2DL7fo3iW+Nrw7ew6F2hAtzjtVlDo/X0FVRKdT5DwBcHprSj4M3GHfOMcwkywE4kqBVbrBQgCorPnXiiHMcVQRQQ42QQoX9ghCy9cEW3wF+H+zuMyaJjU+r29jcDK6HE7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054420; c=relaxed/simple;
	bh=3JEFFMIv64O6qEomO+fGOI0mPQFOkHieJg/o0/UVJss=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qsyTdGJyE1kNHTI6QCTMvqi/Z23XP0FxIZS9I0X5VlM02F4oowEvu2E45C4AP0rTloSbT1PSoqPskpUV3Rzj9mU6+xJqlL15GYC8itg3QmaSqjvnp42FNupgKuRcwxAp0bwW3Xe5bSpb1JsiRYWA3hCUjXF2tEJzwm9ZGtLC8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BSZ8TPEC; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSZ8TPEC"
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6c07dcbe60eso214093eaf.3
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789054417; x=1789659217; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a4dUztj95AfrP93mx++ZxE3WbYbS4/Zbuw76gVFaLAM=;
        b=BSZ8TPEClMDoUKiv5dOsKgdBxL7N7WuH16/u75dughm08dKsYmNVqLj08+k3wcabEj
         rEFAvcvWVd8lO0LhpTjkoB1FDyt41SGYVK0NKxtdkQILUENnaXEUzEet/u1t2UihTLS0
         7ek3ffogJQ71n4ZixqSTXHnxc8T1vruGvdNvmhWFOL/R4G7WQFpr/mJ5Pp7LqLIKDlQW
         +Mi9JIscP/TK84HxofdDrU6NVU1I8EJi37N9G9uSzPTCn/M60HGtl6XcaWguUOvteSjw
         jVmKJMacj6lBi0p91u8XFA5H1W9P5eVOwO+JVn+BDtGR9OD9fxGuX1dLK2bdgat9DHyO
         jDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054417; x=1789659217;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a4dUztj95AfrP93mx++ZxE3WbYbS4/Zbuw76gVFaLAM=;
        b=Q95gWv9m6CIFS+G8kkbeGM+vHUKEMSBCoRIwwKmKmSqrGMsOUT0EpTKvL6lblm1EcB
         HgjCSpDQb6xC9e1JfVkU+VvoMHwkogkJmM5eakJW+F8vr2AXNOkVEPRnyzzwb6q7GOxL
         rtqzxbI1k//p23hX5GULCkufg2MZ/wybRXAajZn3oIcIJpSUcwUPDVOVKcAZd6Zp1wHO
         hbpL0M2Haz6rK1PQHwu06cpas7PF1iQgHOfIbOQhD1HrQDEk3d7grZ3dBlkImq2w/k4i
         zUyPkw9zsH/PfyA/whluYMa7DRTTlJg+gdXtAbw677rcpgEYZ5R1Ey9oCZ2l6Sd1sZAd
         Bhsw==
X-Gm-Message-State: AFuF++kkz2H/zawUXK53WhG34Nbtl08Rm53neUlBDy1y46ZbuwsAOrLF
	dMI+ptZ1cfr/+OmGwmhbqYdr7vfugt6bDi0cX9ibznQi+vUH+1BVe6i3RrgpXqeDSz3dJ86kmoX
	FMGbdMotrbIMtDxc6prxHUFBZazyzgxuK9WLunLvkWbAcHV/5S5kzp4TimHdKuBVVOTw57oHF1i
	PFFQ+To7zy4dKeH0iHOgUoxAQnsuA7eF4F1t6UDA8ye86sJ9qGJGYKxA==
X-Received: from dyckx3.prod.google.com ([2002:a05:7300:c7c3:b0:339:6ab1:8fb])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:80f:b0:6b8:1306:8567 with SMTP id 006d021491bc7-6b813069aa8mr20014062eaf.57.1789054416161;
 Thu, 10 Sep 2026 08:33:36 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:33:22 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910153326.3085937-1-aaronlewis@google.com>
Subject: [PATCH v3 0/4] Introduce vfio_dma_mapping_perf_test
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

Changes in v3:
 - Replaced raw printf() calls with ksft_print_msg()
 - Updated the TIME macro to preserve errno
 - Added 'fd' and 'fd_offset' to struct dma_region
 - Simplified teardown_memfd() by removing redundant error checks
 - Replaced the command-line argument passthrough (-a "...") approach with
   first-class support in kselftest_harness.h
 - Added collision validation in optstring_append_custom() to prevent custom
   options from overlapping with built-in harness options.
 - Switched test_enabled() to match exact option characters rather than
   tolower(opt), ensuring custom options that differ only by case (such as
   'R') do not mistakenly match built-in single-case options like '-r'.

Aaron Lewis (4):
  vfio: selftests: Assert the region was unmapped in iommu_unmap()
  vfio: selftests: Introduce vfio_dma_mapping_perf_test
  vfio: selftests: Add memfd test to vfio_dma_mapping_perf_test
  vfio: selftests: Allow a size for vfio_dma_mapping_perf_test

 tools/testing/selftests/kselftest_harness.h   |  86 +++++-
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/lib/include/libvfio.h      |  31 +++
 .../vfio/lib/include/libvfio/iommu.h          |  14 +-
 tools/testing/selftests/vfio/lib/iommu.c      |  24 ++
 .../vfio/vfio_dma_mapping_perf_test.c         | 263 ++++++++++++++++++
 .../selftests/vfio/vfio_dma_mapping_test.c    |  11 +-
 7 files changed, 406 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c

-- 
2.55.0.1003.g10538fe699-goog

