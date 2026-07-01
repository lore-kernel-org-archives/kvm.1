Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1EC431E78
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938007; cv=none; b=dJJUH4hsVpXvzaOupvakmqtPK28Rzld/aCL9Ow9mvKzUEm45QcYe5kNvN7pGslrXUtmxrY929m+GCu24j/lyD/WQ3Stb4JKD1bvDL+ywR6xUO2h0oKrLkRZJovmm2gfuAznA37CIekNH0mUjgioFiHrOQGNUvlK1PUCH4W3cyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938007; c=relaxed/simple;
	bh=mERkGN8vgcxy2dpZZdXoK1jJj16i6XYVDaaWmBjoDro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aH1GiFlgNDXcEk1JNMD2b8ofdL2X+JjPQmOUQEQv2t+iaT272be2mUK7JyFPHkq25hEJ/eRvNxvmKzXcFrnN2wk5FbtTlfEG1H0/hFO5IlnjVCUpnlP9mRo/JVo175/rBc3hV6cA51ZAHlos6lHfUdJNehotZWm0H0Xml2AmEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTJAPS63; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTJAPS63"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37e17ec1940so1160536a91.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 13:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782938005; x=1783542805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xfsGPaSbOB42xE6v5VUZd7C7R5nORoppmgO+UJ73LEM=;
        b=vTJAPS63GRhUEE3d8bxQS1cKCnZHqNR3yHDXrieJzf84fo/3lVjbZLeZ4Nquwuyhg6
         71f0Uu3p90JLuZaSk1w5K+XNls7sKLxX+78eTdvKy0UxlDx9wcvlXQnPLHl2Mi6/yL6h
         QN0cdPb6apiy56Uu0utLWNjxeA9LZm4znQlzMQBhMZQJYmUcFFob0ONkNxFcnJYxjBzz
         /7uul6GjK6Mr4ZZRYwPgalFLsFkzye4SdV8CfAAqtJSKZqX9zEO4bDjyK4l70HCq87wq
         wWi0RCE/fIWq6BI216DLoP7S7+rCHgYHHfqpWzPy1tJJgHkVIDwW9CT9SPiWKsWBnjah
         gi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938005; x=1783542805;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfsGPaSbOB42xE6v5VUZd7C7R5nORoppmgO+UJ73LEM=;
        b=ZHgp0lrkS1uV2EfpH6MVNOgmtK6L5WULitocJ6wBOOtM3WXcZ/5H+NsAfJn5RKYU9f
         qSfI9uDlZTraYRxfQvx0PmS3fbYBOHK1OcS9yYTr/yG+DKanaG3H1M0c9Jis30JaaS6V
         dWxB35goBaSpwLit7YaQgXvCCwY91/vQuQGbNxNUtIQgBe+H8gCdUzkb9Rqulnjki34Q
         qFUzlVhybbVsQJNVeQLI8mypcfvXq7yDSYnRpZ0RtQUnA/PADgRG2NdmwyDcnbM4fRUb
         Qi1/3YvqYqxhUj6rzNPIDmN7WAAlALdbxNw+oCj6KbzhWU+KfHvewtVRjHjjT7f6kXlZ
         U6hA==
X-Gm-Message-State: AOJu0Yz8WYIEWQaR5ApivQ7Ny+bJ9u0HKWpaVgWf8ATH8HocnxzO9fAw
	0DqQMlE/8kTmtsHCROntP0tCX65DmygoONeGtkGCfjqy7h/0aLXTmt9EZHV0+VCRzQvby4pMz9c
	/gbAGUjxmranWkL2scBqCVV2TLjTjQw+1wq8JJWVYk3pLVgNPa6nFE3GOX29o5c00lQcoELXv2H
	NAradyGUMrzRDSy1i6nJOtzEc8B39DDekie5mjMNaIT3sNJTI8H+/ALg==
X-Received: from dycmg24.prod.google.com ([2002:a05:693c:2518:b0:30e:953c:b43f])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d40b:b0:36b:7c2a:263e with SMTP id 98e67ed59e1d1-380aa1a5ab5mr3055582a91.20.1782938004768;
 Wed, 01 Jul 2026 13:33:24 -0700 (PDT)
Date: Wed,  1 Jul 2026 20:33:07 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701203311.326798-1-aaronlewis@google.com>
Subject: [PATCH 0/4] Introduce vfio_dma_mapping_perf_test
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

During development, I abandoned an approach where I initialized memfd
globally in main() for all tests. While that allowed memfd to be
initialized once for all test variants, it proved awkward because a
different memfd would be needed for each supported page size (e.g., 4K,
2M, 1G). Also, If a user is only running a single test variant,
pre-allocating all sizes is unnecessary overhead. Therefore, I dropped
that approach in favor of test-local allocation. However, I'm open to
ideas on a better way to handle this.

Aaron Lewis (4):
  vfio: selftests: Introduce vfio_dma_mapping_perf_test
  vfio: selftests: Add memfd test to vfio_dma_mapping_perf_test
  vfio: selftests: Allow a size for vfio_dma_mapping_perf_test
  vfio: selftests: Allow the flag MAP_POPULATE to be set on the cmdline

 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/lib/include/libvfio/iommu.h          |   7 +
 tools/testing/selftests/vfio/lib/iommu.c      |  24 ++
 .../vfio/vfio_dma_mapping_perf_test.c         | 380 ++++++++++++++++++
 4 files changed, 412 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c

-- 
2.55.0.rc0.799.gd6f94ed593-goog

