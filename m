Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301637;
	b=x5NZ3lQhCcuNAkeF1eojRTCRSmKqfLk3aRtqmlAGDtPa7g+dJ4KK51qad+wlLfkgQqqw
	 0XUqtVkUuBaKMAizTYW3LVGON5IyKy2Ap5znZrDwSMFtnUE78V5PnlOhU60JwDkKep6Xx
	 n1aGyA42xDgBiVqnPrQebFkouELF59kuSUjYB+j8QrO/UooX/6BCiKcuSbrszCvJffQzk
	 awld5nzuz1ohjOwJhq6h3NHv3yMiYoWRTGptsSvcI8jfAhhnkrTJ1BzjtFjrcb8YTuzmc
	 PuI/kesYLRB6EF3ZfckdFSc72IsY5sL6DMbtBo4/rjLohE4prnCybTDk0Oi5VP8AYOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=14aLGLsWkqwOe+y/LxSquOFPPznEs4fAM/FiOWbWkA4=;
	b=obYYAgEseuQVTq2TCkgl4VmvUqe/NycIfmNVDx06eNy4n/WRUHSjkmXly4/fUkKE3v6N
	 XdnoijHQRr4SISygtM1j98HWQJtaiWxcgbDn6aERLZBid3/tOrmPQg77TySBcWhMfNHg7
	 qA6alZm29c2wlus1YC3SWTuyO5tYIM3pcncJ38AuOyybRrKF1ZAQsr+cZTrDp4Q/omFED
	 4skyaLhF57lfkst1KA4H+lnm6wK2nOhEz8lzrQRd36K3DoxT9j9a7gONBL9wbcLD3F5qL
	 MIffTSSnJ7iLGSxQOz3F2i2z/oVGM3Xxb9dfghhljnl4Trwie/rTycy3UlWqVTUvGww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CZnlSJYZ;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE084606A31D
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE084606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CZnlSJYZ
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8ab395abf79so23792277b3.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301636; x=1793906436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=14aLGLsWkqwOe+y/LxSquOFPPznEs4fAM/FiOWbWkA4=;
        b=CZnlSJYZ/tWIl/rHPEYZboy9t4UflbqKCUbeQ2R/5vGK6ZnLpKMhxvQFjmrWEJO4BI
         cBC75mIRcTo12jW4KwWFARPrKsZgUSfYp1YFmfrMVoG0V3mTeIFYpDuf8bpmMoGQsAWd
         VhLNG2I6AemeQov+6sEGULNIas+2oVCz86Z08a8SCBsfn9+yOCSzY/aHSTjqXbTpd9hi
         iHeeTcppH7a86dUfRtUvBj1t44VvbseC5BEd5CCuZ5UZtkjkj3d1w5YUm3Q33dtVTh3q
         7Kw1zrXfiqkfOM4RWfWfQbNvVMGoBxDd/90RH91Pfp7NMomlxt+df3M9EF8Elh69BpMd
         lUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301636; x=1793906436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14aLGLsWkqwOe+y/LxSquOFPPznEs4fAM/FiOWbWkA4=;
        b=QjUOjzG8OF6bwHhxJ64n0OSLByCZpAqhhCHUXV8HpfvgjZw8I1HCsDwhsAFmsp8ZcG
         hIa+zSHWCxspK/CdLHwmOWtjCiO2fXpjyNcXTzZOmOYWm6FZTgAXnJ3sZ5prAfiy4p7S
         LtjM9cIm221F+vfVlD+5T6QspcfjVJ0YFDQUUn1aSCG97diGzAifzubEcQHdAdgt74n6
         XLy6lCmDvsuKWZNUjXzglDHBXCGh7ErYvqjkmTTaLWD4z4mGPvcm1Qg5kCAKkWzoNjOz
         zqVnvBoZp+6+PMG8rkg4CEiym6RZoIrsyvuFps3qjXFTeNhuoWYluCPSKnN+x06QBEPj
         ddvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxU3prGf8J9TWleeOfF0PZUUY0Vyh//B010g5B3CmZkkOxwIwieVKpwep7WEvMXpCdiZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLy5ZeAnAfFfXoUG9TZ3G5OjGKQlIs+z7Q+QeV3cy1txM584JMt
	oOZXOCOH2bVQjHUIed+b47YeI63IJfV18jAttN/vqTcCVVBj1sBaW9S+
X-Gm-Gg: AYBFou2616bn5d2tFtXCGFncEKUvN1s4rep3yu1BvINzZQ8z4F6AgrAFq/xLckoYqEl
	v/sFZNb4KiCKdSDT67ZZc2A/MChfOsokPc40qcP3mU3u+kpUelqDu4uMGBiW139fiu8BgpvJMPD
	98IKnDm/XJeCy51qMQHFBqz54hGtI7zhjgiDq/r32E0niBlzQyOy0wB2+RXrSd7m5vXlxrrTlqU
	eYny9s3MFZinJJHU80Y6l2bvUoO3O46ez8WVzhilY4RZfL7NZxYWCqFx7+gAx4V4eX85CopzcLB
	ngD6CaPPRXzc5IiC6VBPgS2x4ocoKUV9gvNbr8UbB56HNjW0CJaMIwWfBylrAXJpF0Nbu0u4Vcp
	HGlXiie+0OfX3rX4znolVdt+w722nmS0PtMoXKc7G5qbB27+k9tgI87hIaADLE9T+k3mXyKZadG
	JPeH3IhdiGE4tGYeLg7KIj2/yI4wQottM1BYZm7CMA5MRyHKt8FjNnwMlpLJEXA6O2YXB0tYnA8
	P23SJ6kLWLiC1PmlKej2vWwORl5MX2E+W6476WzOnzTx0W/Yhg09ILqQAymlmo/PSUPf9/Oj2kC
	x685wV3d4CxducDtIAool3mYYVmXYTmIGNc1aX9r9O/Rr/oBXqg=
X-Received: by 2002:a05:690c:34c9:b0:8b0:76e5:ecf0 with SMTP id 00721157ae682-8b1b59e36e3mr50161477b3.4.1793301635871;
        Thu, 29 Oct 2026 12:20:35 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b4b396basm668987b3.32.2026.10.29.12.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:20:35 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org
Subject: [PATCH v2 0/5] PCI/sysfs: Wait for config access lock in sysfs attributes
Date: Thu, 29 Oct 2026 12:20:24 -0700
Message-ID: <20261029192032.1325629-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many PCI sysfs attributes that read from config space are using kernel
accessors that don't wait for pci_cfg_access_lock() holders before reading:

- serial_number
- max_link_width
- current_link_*
- *_bus_number

If userspace attempts to read from these attributes while config space is not
available (e.g. during a reset) there's no telling what values will be
returned: All ones, zeros, or garbage.

Looking at attribute addition history it seems like this was an oversight
instead of a specific decision so this series tries to resolve the attributes
above to match the sysfs attributes that do use user accessors: config & vpd.

Patch 1 is a prerequisite for the rest of the series. The kernel
accessors these attributes use today skip devices marked disconnected
but the user accessors don't, so switching over alone would make the
attributes start sending config reads to disconnected devices. Patch 1
adds the same pci_dev_is_disconnected() check to the user read
accessors.

Note: That check also affects their existing callers. On a disconnected
device, VPD reads and writes, VFIO config reads, and VFIO writes to
PCI_COMMAND now fail with -ENODEV, rather than returning ~0 data or,
for VPD writes, timing out with a "firmware bug" warning.
pciconfig_read() fails with -EIO, and the sysfs "config" file and
/proc/bus/pci still return ~0 data.

Changes were successfully tested by continuously reading sysfs attributes
while a reset was issued.

Changes in v2:
  - Patch 5: check DSN read errors in serial_number_show() and return
    -EIO instead of an all-ones serial number
  - Collected Reviewed-by from Keith Busch on patches 2-4

v1: https://lore.kernel.org/linux-pci/20261025000836.58294-1-thepacketgeek@gmail.com/

Matthew Wood (5):
  PCI: Add disconnected device checks to user config reads
  PCI/sysfs: Use user config accessors for bus number attributes
  PCI: Add pcie_capability_user_read_{word,dword}()
  PCI/sysfs: Use user config accessors for link attributes
  PCI/sysfs: Use user config accessors for serial_number

 drivers/pci/access.c    | 57 +++++++++++++++++++++++++++++++++++++++--
 drivers/pci/pci-sysfs.c | 37 ++++++++++++++++++--------
 drivers/pci/pci.h       |  2 ++
 3 files changed, 83 insertions(+), 13 deletions(-)


base-commit: f4319f548f7d8cb595ac1c91bfd459876399eeb3
--
2.53.0-Meta
