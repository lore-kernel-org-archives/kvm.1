Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662527;
	b=RfII7JG4lekM//lqgxNglSGBFCvOtKkOdhJgkSiqE9k7ksScPiVL/3lZOEcrq3Noa8+v
	 /YFhygjAJmIW7ZI2R7JZgApmDQPcJMxwvbQK4nABI2DeFmA59N58iRW9cwl6hGKlFw+OK
	 YdLDAuKeP0kLvUkjPZM5QXaFAJiDN7oSzM5RS4oGjpby5gq/POZhxDKZxyU8RZ4XEEniN
	 n5vvI1n+4SdfB9P4mqz3QpQMm8wDQImpJOXWSo8jKouuljB3zD6x4BNSir+S6M3Rdkn9H
	 ocuGCY3JQ7JjJbv2RJ8mT49hukk+7c7GJFbKb8ebeNCMtnyuQlMDVeDM3GtebTVXOHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=s+9Hu3UM2egN38MZu88OBSAAZcGtjqWd9rwLazpIXwA=;
	b=yHOR3iRX+UsPr9r0g8uixeD4+Na7LmJBbAXD6kXKoYtq9cOhxHnOz6F7+GGbJ4y8NnEM
	 tc+RIpyxzjwO7xHC8PYucDXlYaizbHKpbAlqGF5ywwq2f59jDJyLzqacKguzJBIG0Ig8Q
	 WL42zCR/iyH3h2X/OmzHWHa0V2P+UFa/q3NjsnJ9kMaqt3dQ6ieWQvHOA/6j69tkiKfJV
	 IN+eT3+6gfiiYrCRx6Tx0XoyC3CBmBsIxNaOiqXCPLIsQxhJaDQI/3EvfgxNkzOHbgqYz
	 GuD9rEHUoSEc/iJ7QOqp41x52yAVSX7cunQXYg/N3m/QBwuCv3B2EkisH3gYaytjynQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bncfTbHL;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CF606A323
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 13:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B1CF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bncfTbHL
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3724667bc16so1209742eec.1
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 05:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794662526; x=1795267326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s+9Hu3UM2egN38MZu88OBSAAZcGtjqWd9rwLazpIXwA=;
        b=bncfTbHL1W9tQ0kN5vy6blQXY1nwquvXkviPBSymOAVM6JM4F/y4xUzJ0eJKxe7SpV
         mA6PN3rumsKaHirSFPklHL1j81nVTIU6TgqULRa8kNHOtWDkKActXq13bcOaJPUJAYg/
         WYXS7e6pPLXZZ0N4ko9v5hTj71ecdW1DbTJrTpOsksGVyyaw0y3B1f8vW8Yj1mxL9nRK
         VBXaXfWuxNx4LVniWrjxl2aNJJgbCF8ZXNPVmQupO9zfpoybIQ4igeUEr1RtMoh7TVj2
         x66Ts7JmaLzcOME3+9ofDC1mZRAMx/nxdlanc7Yrus6S5swkNfancUAOSGVjWjrOjior
         yQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794662526; x=1795267326;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s+9Hu3UM2egN38MZu88OBSAAZcGtjqWd9rwLazpIXwA=;
        b=zfKQQ2ioGp5x/vZrm/4p0HrftL/3eqDD8dzFGg2jcurKvhOJvl8n4LzwRLcrSZ5YPw
         bekSXTF5Ls53y1YAexrUTJ8U2fH+SSoX41cYO1NW1AdxxvsNaI9wPIkjghfQ4cmROUay
         5815JVnr+0sAPAUcMmcw6vG4Y5UxsR6alelVOKcZ9X9v8y7lMH7vPeOTTRURuVU4s07g
         g0xMotefPu9llRIoU8KslFaWEFrcWjXh9R2Pd2YADRoSQLrXz4j+yJ7V85tOA+ymsY70
         kOp4CLT4UHBjV+iMi+MGVazK2TWQTZu/7H8JKQjVxo2soN2SBnCyk1AZHWrRlTksVdWZ
         gE+g==
X-Gm-Message-State: APuU4Z+EVBRyLfYfMYfIMjpT61ULxscjcin7L4ZbySVpRm9wdt8bpI27
	+BzIB865KS0FB9IxYpjIt0oyzzeH67GhoBCo6bQs2Iy8X9yF1gsWUOTThaGxeoHLiteROuAGWa8
	bOu7bU0odOtbp3lK2e+5Q9l/tk9eBc828M8AbY8E2GfAq64QOvay/3I6zYtzqrDPFhnR41Aymei
	XE8v8S70DJQNALEZw3F0ZTssE2zlUAElDIqMZoztqIHV6HNkDhgjWfLg==
X-Received: from dybnj2.prod.google.com ([2002:a05:7300:d082:b0:375:5ce5:6e37])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:87c2:10b0:36c:a3ae:936e with SMTP id 5a478bee46e88-377e093dc83mr7948432eec.5.1794662525774;
 Sat, 14 Nov 2026 05:22:05 -0800 (PST)
Date: Sat, 14 Nov 2026 13:21:55 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261114132200.113697-1-aaronlewis@google.com>
Subject: [PATCH v4 0/5] Introduce vfio_dma_mapping_perf_test
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new VFIO selftest, vfio_dma_mapping_perf_test, to provide a
configurable tool for measuring DMA mapping and unmapping latencies
across backing memory types, IOMMU backends, and region sizes.

For example, running the test across various region sizes (backed by 1G
HugeTLB pages) makes it easy to collect and compare latencies:

Map latency:

IOCTL               |      1G  |      4G  |     32G  |     128G
--------------------+----------+----------+----------+-----------
VFIO_IOMMU_MAP_DMA  |  0.39 ms |  1.38 ms | 11.62 ms |  46.54 ms
IOMMU_IOAS_MAP      |  0.58 ms |  2.27 ms | 18.08 ms |  73.49 ms
IOMMU_IOAS_MAP_FILE |  0.01 ms |  0.02 ms |  0.10 ms |   0.32 ms

Unmap latency:

IOCTL               |      1G  |      4G  |     32G  |     128G
--------------------+----------+----------+----------+-----------
VFIO_IOMMU_MAP_DMA  |  1.51 ms |  5.69 ms | 45.78 ms | 187.66 ms
IOMMU_IOAS_MAP      |  1.84 ms |  6.83 ms | 52.53 ms | 211.75 ms
IOMMU_IOAS_MAP_FILE |  1.78 ms |  6.74 ms | 61.26 ms | 213.70 ms

The numbers in the tables were collected on EMR.

Changes in v4:
 - Split kselftest_harness.h custom CLI option support into its own patch
 - Printed usage help on invalid options and passed custom optstring to
   test_enabled()
 - Skipped variants when the '-b' size is not aligned to the page size
 - Renamed timer_start() to timer_get()

v3: https://lore.kernel.org/kvm/20260910153326.3085937-1-aaronlewis@google.com/

Aaron Lewis (5):
  vfio: selftests: Assert the region was unmapped in iommu_unmap()
  vfio: selftests: Introduce vfio_dma_mapping_perf_test
  vfio: selftests: Add memfd test to vfio_dma_mapping_perf_test
  selftests: harness: Support custom command-line options
  vfio: selftests: Allow a size for vfio_dma_mapping_perf_test

 tools/testing/selftests/kselftest_harness.h   | 127 +++++---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/lib/include/libvfio.h      |  31 ++
 .../vfio/lib/include/libvfio/iommu.h          |  14 +-
 tools/testing/selftests/vfio/lib/iommu.c      |  24 ++
 .../vfio/vfio_dma_mapping_perf_test.c         | 279 ++++++++++++++++++
 .../selftests/vfio/vfio_dma_mapping_test.c    |  11 +-
 7 files changed, 444 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c

-- 
2.56.0.611.g1030f0b940-goog

