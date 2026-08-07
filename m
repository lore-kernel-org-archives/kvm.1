Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4C40EB9C
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786133653; cv=none; b=JYvMvboRfZV0pITwadr2F8WqOhWTre95wW4dZKSiAfpRbPKr5UQojKt7qE0RQ5GEOdOzWKIbpBg//2AYsrNqs2BFXOmqjG8Aw4Uwnnyz5TawvBZITnOGwaAS6zBV79vJxcm10aYtrV1HH2QNMKFuHj/o4qr2ie80e2C/RAn78AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786133653; c=relaxed/simple;
	bh=5rNp68+R40BGQmfkY3/WO4qJbrt+ow4vjgJ4ryV1oaY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pCFGaOm7n0W6Znk1N34pQ8j7kCHtVdmze1WbPYe8qoA3phnMdQtwj5QNhB7IxBoO9SDpVskNBfw0HtKBfgNobEuOjExUjIyk1Z2q83DvtjBVoVB4OXfYO1fyZfnjUBDK7+WP7GQOWb1f5StIX+WXimyq/eHy5FF8rtNbIvrbK3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZPh/CcFV; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPh/CcFV"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso4590774a91.3
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786133651; x=1786738451; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C/tZuAguZ+jLqZbm1tQw6HjSeO9yj89pOL8SmKdqQE4=;
        b=ZPh/CcFVtdjSBaLpyHMN5uxfcjyeQQWv5Eu2BiRlfPoxPYxrmIk/BQfULpHJ7dMCDc
         yjRJBEvN4QRKshY/2SUHx2ggyhAevzqacyVB0S6WRQQjKGaXJziKIVVlwHI3L+vJNVua
         f8R+rnZZcBXVTX5ngdgQgmJbq06jeugbQPVYpCVruOJBXMXWjPYbSUBYh3vnM64CJSsN
         LCcEJLnaNtUoUGAT9JiLfX5klSqaBK6leixjM0M0kGiVnZtAjGnhfd1qennuiHSN6Hg5
         sbqKHHsT9jmD5JnchM7Qq4I35q/KQF6GVc2cvasC6luG4O8QhvgEhhCaN5plch+W4AuL
         4gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786133651; x=1786738451;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/tZuAguZ+jLqZbm1tQw6HjSeO9yj89pOL8SmKdqQE4=;
        b=ZSZZnevp8BHR/rJK246BjJMNcV9RIyr53VdjoF00Ze/ZFowH3iWrOOBgDTzvmHjgl5
         arALNTmhOGEFzQFJl46D0BIGzpLqhTMUusfAPV8GlBgEzcBm3kScGPopIYhGok8sTFX1
         HeTkSuKEfpAUuR+wlRZ9xl0uXgSh5bozqhW1lQe71m92iCgcCibnGQy+cJfAe4YmsO0f
         cqnRtrHPBFLgS/SEGIusjgfFFSkDY0ey4U1UfW7dDdciqcQ3yiRO2z17MiFvT0rK57aU
         tDB6yEiAdDiS5yojF3R81va3MVQP/mL437iENWTEt3ZxnvXSAjTqKXd+qNN3mN8No78w
         n4RQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5jXQ5OgHsQxOEUspcnJo9fPRM4jEoI62J8mumqhgo51gfENfJFJ5Gii0AF8rJ+9wdZDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqhm4M072iIGmg9fsrytncQi9l3f4v1+sQPi0K/8bOSuA9vah8
	Ah3CM5/qWRxpNx5lUCiRzsz6dvZkS9fqQIqdg6KKxRnqdXDc2QYvJuGp9hiWbTpJEn+A2bC8wP8
	JJA==
X-Received: from pjboj7.prod.google.com ([2002:a17:90b:4d87:b0:38e:a577:5cbd])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2548:b0:36b:77b9:5c8c
 with SMTP id 98e67ed59e1d1-39282428edbmr2346413a91.17.1786133650733; Fri, 07
 Aug 2026 13:14:10 -0700 (PDT)
Date: Fri,  7 Aug 2026 20:14:04 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807201405.3717430-1-praan@google.com>
Subject: [RFC PATCH v1 0/1] vfio/pci: Revoke BARs and DMABUFs during
 sysfs-triggered PCI reset
From: Pranjal Shrivastava <praan@google.com>
To: Alex Williamson <alex@shazbot.org>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Leon Romanovsky <leon@kernel.org>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Jacob Moroni <jmoroni@google.com>, David Hu <xuehaohu@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce PCI .reset_prepare and .reset_done handlers to safely revoke
active userspace mappings and exported DMABUFs during sysfs-triggered
device resets.

We are seeing a situation where system health and monitoring daemons 
(at times erroneously) issue device resets via sysfs for devices bound
to vfio-pci:

  echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset

However, because vfio-pci does not implement the .reset_prepare and
.reset_done error handlers, this hardware reset occurs completely unnoticed
by the VFIO driver.

Consequently, active traditional userspace BAR mappings and exported DMABUFs
are never zapped or revoked. Importers of the DMABUFs (e.g., RDMA drivers)
continue to issue DMAs (such as PCIe Memory Writes) toward the Endpoint. 
These transactions are silently dropped by the root port or trigger CTOs 
while higher-level actions (e.g., RDMA reg_mr) continue to succeed.

We'd like to fix this by implementing the PCI reset ops for vfio-pci
that revoke the DMABUFs and zap the BARs while holding the memory lock
allowing concurrent user accesses to sleep and fault back in once the reset
completes.

Note: I've tried to handle the locking as a first attempt here, there
might've been some cases that were missed. Also, for the RFC, the
drivers that implement their own pci_error_handlers (like nvgrace) are 
not altered for now.

Quick Note about Matt's DMABUF mmap Series
==========================================
While this patch is aimed for the current upstream code, I believe with
Matt's refactor [1] these ops might change slightly. If we have consensus
on this patch, I'd send another patch based to Matt based on their series
for them to include it in their next version.

[1] https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org/

Thanks,
Praan

Pranjal Shrivastava (1):
  vfio/pci: Revoke BARs and DMABUFs during sysfs-triggered PCI reset

 drivers/vfio/pci/vfio_pci_core.c | 88 ++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 32 deletions(-)

-- 
2.55.0.679.g6767b8d81c-goog

