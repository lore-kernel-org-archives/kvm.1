Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B054AB3C8
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052417; cv=none; b=ZNW9UQfTte7AEXatjLts90IDDOFNaB3gkLqTxd8cerFgtKOleJcXM8N6yzpOQmnu8AY08rsL+6Tq/FyKQF0c3L0mGRoljsVdQAGK7QmQ3zkzkHSBlXYroXNTNakfMrEq1PR39fs/R5sS0WQxKIsUfMKl9c3pD2M004CPslYnvC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052417; c=relaxed/simple;
	bh=H63zxjWp1jLDvdHp4Krl+dOy/FAVseUmuLwFmUPXyfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRLveHo2u3nbuiH0sJk0sxJK68H6EoNtGJYx6P/g1uK0cm5GOykaep+oKAc/FD1ece2OqAjKtA6ZjVpe1F/8qdwqvMrDzj/fJY4M8K7P3QsJAXUwGN4xIsvbt0Q4G7fOhJdHhzkpod2wyUAA11602CbAlnDF/RAQU4OVzUX60Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNO5wKWU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNO5wKWU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so44631485e9.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792052414; x=1792657214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H5Vd8qfuBft/Q+5AUgWTrpKu6Zh/Rd4i1LR0LLBN6fE=;
        b=gNO5wKWUwsngt3KmuEMRTtXlJL4SAvEd/CF+nBwCWdL1L9O0ZnMJvhZocXnK/GY9Tj
         aJw87xgCCQpDGwuGryIMAB188ETAK2x6CiixfryatHHj9jtHUJkhhxmc0kmWuZGBJIJo
         1rB+0anfQHnsvqwXZCl6azBaLmj6mmQnXJmn5cTtvBUigoVHPzUcMyg13jU0CNmxWKI0
         YTuAmgUf7BgoIUyvQlj3snbC6s3ANIx5/v71cv7ZeCALizWjAsl9E/iyXbcGsk/chT4G
         Srxj8rkLvWWICi/7fdPKr9/uQFdwWkGgVP/D+UuuA0Wr8B90KlkxpRjQn83HZDBt3HrL
         xHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052414; x=1792657214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5Vd8qfuBft/Q+5AUgWTrpKu6Zh/Rd4i1LR0LLBN6fE=;
        b=OkNInjK7trdCn4Y7o8JIucekK+3pnXDM3lOI2iI+i+CB9wTNwEhoPwmqdRP/1zK9/f
         guJ0W2jjL1Q8bX8S7SnH+tfHpeUsJ0Vjmp2Gd1O+SN6bnZKSRQLnoqNMGruVuuhv0l4z
         14pUMHoVkuF3FpHZPSlOMWWGcS71c7L3Ql9FOd5oEeVwLuz0UcCz4KEP859pFO/w88ZS
         SVwm592d9QREdhX1fNWbCIRsLGN7o5IfJ80PlD7vqkDpNgzXynXUg6zip/EcU63rM751
         osARrWIs2JmA99zHrYnxTqgF3SFyElLrxn8kmj1bc1u0DKjtFVE9GLK/hPHOA9GZedQz
         wA3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzxBWOG0bwCZPSHOvQgW8Rv6ittHCN8sGobi/TQb52KhNK3HZJ3IJMxzNnao7JMHAQvA8o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxFp/R80TD8cvQI0Rjm8kcrWAPx1P3GDf6E5k+Qks+TpR7N51N
	3wxyxwvQ5ipppSR/P21PHGNTXY/7usNEp+oXHmdGVp8FAV9Dw4JCbSAt
X-Gm-Gg: AYBFou1ywnWYuvc5W0VjPdbq4fV8XLXeY223slg8Z47BbnMmOU0S+vNI6IyC8YcdyW1
	6liwW/f+UHVmHxBdVMm6aGSRx3njWYpIcU7riT+RRDyyR/hiGmCskAI9p3wOuygSViQ5Q8y0dhX
	mcjVmR5sFem+LmSGuU/xQgSDVxFvD7Fn+i1Tqs/KDaODl/goxLSIjlYBdDOrgo6eH8rQ/jYzTOB
	pyDdN4vRm1a01L/6oBegNo7zx6drxbU94JoUUmw+h5q87DogYLoHQKTSFOl2/ywmAjwa/1DYs0/
	Ju5W4KgDusCuMTtm/B7+5S+cxvsrgYDNzwVAWTwd9h/aFI5FsSa99X79EF9S5CYyGbQ0n11pJT1
	+bv3pdr4t4Y1IgaF9tZ95IMHlmh0W72kOsGRfbc3oTKlPZqkLOYOEN/kMJazY0GcVJhLX4y68SX
	No/TdHcRVzj7HW2EPCG9RLyO35GVE5Kztyv1j7bbO/vwgN02qUxEQnusrRxOtAI2VmmFteWzEvw
	4myKTTznZ1SkhXN+bjme75g11IaBELd0fJGUu4ofD2I5Q==
X-Received: by 2002:a05:600c:8a09:20b0:4a1:9687:bbd4 with SMTP id 5b1f17b1804b1-4a19687bdcamr221742185e9.31.1792052412468;
        Thu, 15 Oct 2026 01:20:12 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b35a6sm49003545e9.6.2026.10.15.01.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:20:12 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jiaqi Yan <jiaqiyan@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] vfio/nvgrace-gpu: Separate the fallback-mode open_device
Date: Thu, 15 Oct 2026 10:19:33 +0200
Message-ID: <20261015081937.405320-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fallback mode, where the ACPI memory properties are missing or the
C2C link is down, nvgrace-gpu opens a device through
nvgrace_gpu_open_device() but closes it through
vfio_pci_core_close_device().  The open registers an empty usemem range
for poison handling that nothing unregisters, so a second open fails
with -EBUSY, and the first open after an unbind hits a KASAN
slab-use-after-free in register_pfn_address_space().

Patch 1 gives the fallback table its own open_device, as Alex suggested
on v1, and is marked for stable.  Patch 2 drops a usemem length check
in nvgrace_gpu_open_device() that only existed for fallback mode.

Tested on x86-64 under virtme-ng with KASAN, not on Grace hardware.  A
QEMU cxl-type3 function, bound through driver_override, takes the
fallback path and is opened through a noiommu VFIO cdev.  On v7.3-rc7
the second open fails with -EBUSY and the open after unbind and rebind
reports the use-after-free.  With patch 1, and with the whole series,
neither happens.  Patch 2 only affects full mode, which this setup
cannot reach.

Changes in v2:
- Replace the usemem.memlength guards with a core-only open_device for
  the fallback table (Alex)
- Add patch 2
- Fallback open no longer fails when BAR0 cannot be mapped; Ankit
  confirmed fallback mode does not need that check
- Rebase on v7.3-rc7

v1: https://lore.kernel.org/r/20260925161024.189771-1-parri.andrea@gmail.com/

Andrea Parri (2):
  vfio/nvgrace-gpu: Use a core-only open_device in fallback mode
  vfio/nvgrace-gpu: Drop the usemem length check in open_device

 drivers/vfio/pci/nvgrace-gpu/main.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.53.0

