Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31123472F74
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455447; cv=none; b=H2Xq/P6owcvmecWUNshInpr1JKIdSINsTUvIdKW8zp/QN9pZ/5dtVXXENt2VQRCqsRH0JijLhCdxEuPntpGUYPWF6j6v14RFN0B8l2iK13Q6dM2JxvHqJwfljVndMDak5od09JyQUn/XEGClyqACb6xPzDBhbRt6apHyI+0mHyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455447; c=relaxed/simple;
	bh=rDS6BdX+EbByd2l4EUb5bRG5V9IxQDRsbRW1jLQQ+qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfO2Z4xUDfy6V3oJ7IRomuSfsgJ6LREWmw9eJmTX3RJPSfVxKcs7xZ4sOCaryVk5clBX1HJZGz4LasO56KsEZN4dokRCpl8c4tEfuyZ0abuWe12Stu5MxP2GtmnWrx3E9UxuVlt7xkOH6Re3GB8tjzY/QT6ogeVCJf1nlvw9Yog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTAKnmZ6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTAKnmZ6"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc50ad2d650so1737015a12.1
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 03:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791455445; x=1792060245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D/PrLkJqH6eNdn4uSZzb8qrmiJsHXO2a6FS8B1i/DfY=;
        b=dTAKnmZ6tDK7V6OrPFcZ7/ZKXvoQMkMpmgAsP6uKhU4SnVvLmRspRkgyZ/hEJLK57e
         AMmQQ54zPRuYvnH2zZqG53brSAfZQTGVHY0nd6YQJlqJUY5dQ81CcS24CbDOY3VPRO2I
         x2cnOk/eXUS3RG+JxmX8u4Jt18HvxkygQLABJ6rJ1IbHi0K3Z1p14yEzV8+BG9q2Mz/n
         B7NO6Bu/xqh5fiSvN1ABTvPH65cyhWfITosyqOlghrx2xoxIP4d9qoNzgoRzccZh+Ezz
         mURxRffDk847cHOhwmKCEGLQLHHhp2dNgSOorhLpZl7Zt5CB4ueDhC3UubM0bhw+CWU5
         iTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791455445; x=1792060245;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D/PrLkJqH6eNdn4uSZzb8qrmiJsHXO2a6FS8B1i/DfY=;
        b=oInHXu/t4LhBhBnTohlwb8SoEAbRKFTNovf17oLheaBQ25Z51w9LCwOAz6rbFQfTb3
         mbPvXzrtJOCwJbC7V7ydTY+rBFQ59UkqSyK3Wj694l+ZEYwXYfRszJqIJ2iGnnNCK5Er
         PgPmD5zLttRp/xuBs7v91ae3E7+EZXg3LUKNt/zf/928TQf4KrDFaa6n0Q5ZlCgoLBWp
         NNJlEd+1BwnKly4VLasbIIuvvfEjIqo6vRQHRs8a9OfMBiLMEV0DTSElYD9qikOz1GfX
         j/+G9R7VI01q+UG2OXH1AXmqB7iV6b3UxlbxRgt/i2R4CiQbFx74hkqKRUXTGLE499QI
         wnAQ==
X-Gm-Message-State: AFq9FYKqTjNg3coabv+GEqKFhbJpzcNVC0Lv0Lm6fa+F9KnzldQSOwHZ
	40xwiJ64D2Ro7scppQvwj40Ndt/dhbc8Mg7KoCjWqJTTy7y6MVPkIIxkY4Hfb/Q4wQ==
X-Gm-Gg: AYBFou3h5EMRW4G8bCgimLGsV549Jxgvn8BU7CYEQhu9bCxDT/GdQMzw6D1iDxzsGCM
	+Nd5X3hPSzUO7AgDxSOuY7POpEFa7zyrw2sSZyaaNEOIRRS/Ccf+0meQcPZ7MGVX9EdUdrBsZxY
	EHbUuoRtpoKp1VBCBsbnkDfr8gALK1zdpXNydGpeYpzlBWhEd3pLEDPVjUB7E0OSF7oLoQrsPvu
	mkpBaidfj5pWKoOyi9nWrSwj9pdFTvUEHt2HCXG75A+E4n4L2zX9bNu5MLKgqzbK6EclVhlpVNq
	K8TdUwrKk5PoPKBFM541HqCXMi9+mPdkMO9NB0qn3aaDtiNdtH1OD3Da2oQRGOYye3fyI8TeK3o
	p9hOHV1UqOz60ilXNodH92P95U1tvs36LCVBfkXW5wq7FU97xTcQikRm6O/87bkrBI632biuSeL
	WmrdjpYVRKYdSbRVjo5esS2TEbh+ShSpqmj1TfSjpZmBEUeOieNQZbbb2EnPbxOitncS5bIJPwN
	ZMNu+76J6wYTN4JpPxus/12DPNNBlJiZ+Q=
X-Received: by 2002:a17:90b:1d0d:b0:3ab:c80:9370 with SMTP id 98e67ed59e1d1-3ab0c80f010mr606371a91.20.1791455444714;
        Thu, 08 Oct 2026 03:30:44 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a8b0616esm2814569a12.6.2026.10.08.03.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:30:43 -0700 (PDT)
Date: Thu, 8 Oct 2026 10:30:40 +0000
From: David Matlack <dmatlack@google.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Subject: Re: [PATCH v3 0/4] Introduce vfio_dma_mapping_perf_test
Message-ID: <asdw0Mep7etyQvrE@google.com>
References: <20260910153326.3085937-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910153326.3085937-1-aaronlewis@google.com>

On 2026-09-10 03:33 PM, Aaron Lewis wrote:
> Add a new VFIO selftest, vfio_dma_mapping_perf_test, to provide a
> configurable tool for measuring DMA mapping and unmapping latencies.
> 
> This selftest introduces command-line parameters to provide a convenient
> way to tune the test for specific situations. For example, it can be used
> to observe the lengthy unmap times of the Type 1 IOMMU on large memory
> regions, or to compare DMA mapping performance between the Type 1 IOMMU
> and IOMMUFD. These scenarios can now be easily configured and run via the
> command line.
> 
> Changes in v3:
>  - Replaced raw printf() calls with ksft_print_msg()
>  - Updated the TIME macro to preserve errno
>  - Added 'fd' and 'fd_offset' to struct dma_region
>  - Simplified teardown_memfd() by removing redundant error checks
>  - Replaced the command-line argument passthrough (-a "...") approach with
>    first-class support in kselftest_harness.h

This looks a lot better, thanks for making the change!

>  - Added collision validation in optstring_append_custom() to prevent custom
>    options from overlapping with built-in harness options.
>  - Switched test_enabled() to match exact option characters rather than
>    tolower(opt), ensuring custom options that differ only by case (such as
>    'R') do not mistakenly match built-in single-case options like '-r'.
> 
> Aaron Lewis (4):
>   vfio: selftests: Assert the region was unmapped in iommu_unmap()
>   vfio: selftests: Introduce vfio_dma_mapping_perf_test
>   vfio: selftests: Add memfd test to vfio_dma_mapping_perf_test
>   vfio: selftests: Allow a size for vfio_dma_mapping_perf_test
> 
>  tools/testing/selftests/kselftest_harness.h   |  86 +++++-
>  tools/testing/selftests/vfio/Makefile         |   1 +
>  .../selftests/vfio/lib/include/libvfio.h      |  31 +++
>  .../vfio/lib/include/libvfio/iommu.h          |  14 +-
>  tools/testing/selftests/vfio/lib/iommu.c      |  24 ++
>  .../vfio/vfio_dma_mapping_perf_test.c         | 263 ++++++++++++++++++
>  .../selftests/vfio/vfio_dma_mapping_test.c    |  11 +-
>  7 files changed, 406 insertions(+), 24 deletions(-)
>  create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> 
> -- 
> 2.55.0.1003.g10538fe699-goog
> 
