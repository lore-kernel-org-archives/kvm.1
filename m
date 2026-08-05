Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E016DEB1
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890054; cv=none; b=WLshHKWXeufm6Gj5tls0XfhoJyiGfIK5RbR5LbaJoBE7uEtf3gOUwcfdfosOYaxTQ3qa/RFV8km6g2WRmTwecJ/fpqhtFudTUElF1MLe97BNkglrhPeB6m9SlGnD/INB4lQ6bVQSIUt2tH27tP4jjhXefzKfyU3GUULNZtCXC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890054; c=relaxed/simple;
	bh=txfxTrmu+bo3oAJ8VLDmk/FEIiIVSSTxEa8Qi/4Y5OM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QAo1Cy96Y3lIc0EuIKUuQ1VIIISPaqZ/1hv60a2CBFEgmKDPJ+a4XqkwPS9Fr+JQ7YNA5xcrscL6mBFaJlk+mR6+8gYoWCkqkWFeIPCBPtIBkw0PXgpO6+cDFp01ELu+Emc9s1IACAo0XrX0bq3XGW668Euaw161x7nGOoZFnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i9tsLmln; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9tsLmln"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfa55c9430so4110435ad.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785890051; x=1786494851; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9QIg9D06eO1oZhT/bjT3ycpnRcl5W9Zb/r8esri7h6U=;
        b=i9tsLmln3eeRAlV2jqyPng0vS9QG+/YRZX7khntGbwfqjiBpsA7g5sK0jX0mQJ9QHA
         5l6aAfHszzubnmtf/ZQLs13qRIUHEU/hWxxEQtk4htQuMVHnOZ8MpFvoEWBuCgz2TvrZ
         T0XTzKMxolv8cMW4pC7o2ht4+ItxZC0i7miWptBXbA1CQqKebE/mt9nj8Sq7T8sbkfRZ
         R/p9JRcoCj/XkYF0o0ZSCEsA5vW86iTwcwxRQKSrhRtRuFiziNRZuwLs2Mwv2Eky47nX
         /p0UZ3QJmN0F6jDuwlEHCJtrgMBxG5v/S9y4VpsV6i7m42ZgWCZEvWpND/0Y0GJVugSt
         4tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785890051; x=1786494851;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9QIg9D06eO1oZhT/bjT3ycpnRcl5W9Zb/r8esri7h6U=;
        b=JSKzXo0ovXx0tJBYk283iSgoMENp5WZ853TFwUny4vOg1iwfZ0G5SKrULAypBVsxxm
         qrRjefv1OW/JLu554KxjLAnI20e3SgEOF6VeUpqoDvhi7KRKxrva2wYc95sE8qO1Tv6P
         3CyEG0zflUU4qWEk8zDUkSBnrf9tRgMbV0Jc9hhO8ZFAn1MuXPw+teZY+3NxLbBVmH0v
         QYMMx+cMx4MGUVekO8x/7Ydnau4/pLybA651V3GjeX0O7peTM58D8I7U6S8SKpcYXlur
         0JOz0m+n8otshxERaj5WhF26qsE/XWwULrdIbithNbPj/E24gKsxFEHK1+TlTi32DoW6
         ejQw==
X-Forwarded-Encrypted: i=1; AHgh+RpZxFXcU6QGHAEpwSjUAZ2eh71VgGrwnP+MnSqK2aw//rBecQRbV8a7erZZiaGkP99cP8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcDxJK5U2jffEzY0FK0k8+c5fN4o82q+8BjobKDprTgy+ZbtN
	gfcrpeOftnPg2+zrHmlBLLtuU5J2axhuRokHIwqV+tiz0qQPFN8l9q4r3I2hyD09rmWfru7Aa+6
	DeRe94jSYNA8dWw==
X-Received: from plcm11.prod.google.com ([2002:a17:902:f20b:b0:2cf:ee73:1d9d])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1aed:b0:2cc:8267:31b5 with SMTP id d9443c01a7336-2d0caa03976mr32512675ad.19.1785890050806;
 Tue, 04 Aug 2026 17:34:10 -0700 (PDT)
Date: Wed,  5 Aug 2026 00:33:54 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260805003355.728299-1-skhawaja@google.com>
Subject: [RFC PATCH 0/1] vfio/pci: Disable sriov on PF device close
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, bhelgaas@google.com
Cc: Samiullah Khawaja <skhawaja@google.com>, dmatlack@google.com, 
	Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky <leon@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When userspace closes a VFIO device file descriptor, the vfio driver
performs a hardware reset on the PCIe device to ensure it is returned to
a clean state. However, if the closed device is an SR-IOV Physical
Function (PF), it may have instantiated Virtual Functions (VFs) that are
actively bound to host kernel drivers (or other vfio instances).

When the PF is hardware-reset via VFIO, it implicitly disrupts SR-IOV
operations at the device level. Because this reset happens without
notifying the core PCI driver model, the kernel drivers bound to the VFs
remain loaded and operate under the assumption that the VF hardware is
still functional.

This creates a state mismatch between the kernel's view of the hardware
and the actual device state. Subsequent attempts by the host OS or bound
drivers to interact with the VFs will fail, leading to unexpected
errors.

Disabling SRIOV before resetting the device avoids this issue by tearing
down the VFs and removing the VF devices.

The fix in this patch only disables SRIOV on PF reset for devices bound
to vfio-pci drivers. But this probably needs a fix for kernel drivers
also, maybe return -EBUSY when SRIOV is enabled?

Looking forward to your feedback on this.

---

CC: bhelgaas@google.com
CC: dmatlack@google.com

Samiullah Khawaja (1):
  vfio/pci: Disable sriov on PF device close

 drivers/vfio/pci/vfio_pci_core.c | 7 +++++++
 1 file changed, 7 insertions(+)


base-commit: 0f6da28aab51b16762ed82e8fdeaa5042da45b08
-- 
2.55.0.629.g250fe7f194-goog

