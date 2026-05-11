Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EA63BED16
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543319; cv=none; b=T1PfKuEeNZ+R3mw0+2rjMXANNJh2CUmf43aY/tBixpIgCw9eoXcMuGNXCaagmnkdGmOhOJ3Z8CC3q/h1nBp7U1l//kPF9I2L4/hCOpt2B2al70MnWH97KeQ5kXCDQdoY/hcCYxKActAXrubsr8X4XSbgU119RBcCxmY4F0mvOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543319; c=relaxed/simple;
	bh=2O3kiZbxsoqPdSkkFfZY/ZsPS5GCY/RmMZMzns7zjr4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qob15q7dpgxEBBtM2Icviu6IO9xrvqrcCvF3eboHrBnWu4KiR83uC/3/1U1qFvK4iatnbRm1NtDHNZLXG0yFoQlZB6kzkgcvyJYsbcII33i5qg0oMqGDwWqttNA9hgTeFTNIIxTMqU5xChn7U0juIRnsj8DR8MzE4mql5o/xiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipDJcFIh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipDJcFIh"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c44bf176so5879265a91.0
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543316; x=1779148116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ciHF9s89MGSV42RioHjLjFryxlWaYoxn0O9vl4XFI1I=;
        b=ipDJcFIhdiURZAVFmzT9q6Vqy7RliouHFFE1Xj3ZlmXy1nMO7bMTgNrgVJiOODxoB9
         at+NI71ZRYNF3bF25/xIP7qoMEjWIMGJgYyUof/kOkxEytVAw7jmKOnPxSPdGt8ikFCT
         ZGrC7WfjcKmDsPlDBnX5joQ1O2Gt3Ywuw8/9sWeZ8S2EVbSGYG3IhkonGJMIg1KhAaBJ
         jVBdAHRB1qgZ5qD1AbWLGXW5PYuSbZcbTziTAbidlENoM3ZDQF+etwybV2X56yHcyrt2
         LvWhLQ6FhXIhVlqSkglp+DkPhJydEblQA4Fq3AHjhfzDSGsi69jYc5quRyZ81IwNtJx5
         KQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543316; x=1779148116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciHF9s89MGSV42RioHjLjFryxlWaYoxn0O9vl4XFI1I=;
        b=aw/Or2vxwK4Qn6ZJykUpqSLqAPp0O3uLe7515bypUXoxA2GTe587AXTRxkuf5K9rAT
         MU0GJ922xJ/RBrvBNuUd6pfzsUJSMx6wrXBRzf0ogPvK7OGWVETn6V6b1DChAF+0HMUP
         nJBqEqX+P0/q5KtN34qie1DBXelv4X3FFg3mhRZbWdYQTT/Fs3eipURMy6ihVyELes/F
         QG0SFPLCv2n5RaZAveppyk0hpD9eK9M5Z5ahMTrFl4Mk4TGnr0l2WMSlqe5egx0iFIu3
         2kpYt4cBjb8BJ+MGy7p97lsW+Y1JmO6nrp0N/pMfcoNzM+8YkNwc80m+tg4IQkGOkxNm
         j3og==
X-Gm-Message-State: AOJu0YwdXTWjXa3OFtOuEk12rc1p3XqxM+QbLsme8G4fjO2+q7eNQWcI
	/DTdBW0DhGi/TIdTO0PbLaCSKplTWAfmIWnynz7eNj+2kY4fdPti7cLBmJ8eVW4YIVrLPkLU+7m
	gvLXy3AJcP5bTDVqAHaJ68M4hq8esI+3YS8oBs+H0C54SZPIS5QtXNmxViASpzN4DH+h0u1q3SL
	VU7gXhYTx4zI/0BFDZ+/gFAGlQGcMz9lnkNRCE+w==
X-Received: from pjbdt11.prod.google.com ([2002:a17:90a:fa4b:b0:368:aec2:8d2f])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1cce:b0:368:5367:d67e
 with SMTP id 98e67ed59e1d1-368b24ffb1bmr755202a91.10.1778543316136; Mon, 11
 May 2026 16:48:36 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:53 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-8-vipinsh@google.com>
Subject: [PATCH v4 07/16] docs: liveupdate: Add documentation for VFIO PCI
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, 
	praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add documentation for preserving VFIO device files across a Live Update,
generated from the kernel-doc comments in the code.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 Documentation/core-api/liveupdate.rst         |  1 +
 .../driver-api/vfio_pci_liveupdate.rst        | 23 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 25 insertions(+)
 create mode 100644 Documentation/driver-api/vfio_pci_liveupdate.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index d56a7760978a..c55d0d9d1d3b 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -34,6 +34,7 @@ The following types of file descriptors can be preserved
    :maxdepth: 1
 
    ../mm/memfd_preservation
+   ../driver-api/vfio_pci_liveupdate
 
 Public API
 ==========
diff --git a/Documentation/driver-api/vfio_pci_liveupdate.rst b/Documentation/driver-api/vfio_pci_liveupdate.rst
new file mode 100644
index 000000000000..1098b84e5ecd
--- /dev/null
+++ b/Documentation/driver-api/vfio_pci_liveupdate.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+====================================
+VFIO PCI Device Preservation via LUO
+====================================
+
+.. kernel-doc:: drivers/vfio/pci/vfio_pci_liveupdate.c
+   :doc: VFIO PCI Preservation via LUO
+
+VFIO PCI Preservation ABI
+=========================
+
+.. kernel-doc:: include/linux/kho/abi/vfio_pci.h
+   :doc: VFIO PCI Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/vfio_pci.h
+   :internal:
+
+See Also
+========
+
+- :doc:`/core-api/liveupdate`
+- :doc:`/core-api/kho/index`
diff --git a/MAINTAINERS b/MAINTAINERS
index b6c33c2bcc7c..737c5ed1ce38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27979,6 +27979,7 @@ T:	git https://github.com/awilliam/linux-vfio.git
 F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
 F:	Documentation/driver-api/vfio.rst
+F:	Documentation/driver-api/vfio_pci_liveupdate.rst
 F:	drivers/vfio/
 F:	include/linux/kho/abi/vfio_pci.h
 F:	include/linux/vfio.h
-- 
2.54.0.563.g4f69b47b94-goog

