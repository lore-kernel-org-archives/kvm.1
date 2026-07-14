Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B514ADD82
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042126; cv=none; b=bN1t/MpBu0PDLc9dCw9Xt+rQ88aLYFcSMkcC18TkshiG8R5FegadLZp1yy1K75BxJD1dClHI96SyVQ//hghLEfxBIPZL4vd5DUT/neNdpuOlA4aXzUV7XhyP0XU3rxM38Em5nlNzVFkYjbcL86Y/Uu3GwlWY16Zh/rH451MHV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042126; c=relaxed/simple;
	bh=CuAm2Qbad2+WXKfFJI+2wHhyeOkWA/h5aLdYHlm9P2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J3CFVs/qIyFpf48jIbiFqZ5BAg4VnlTzIoHmbiT82bkC1H8pdeDCQHnpaVNmWeqQ4N45of4W73WVenLGhyj8shEBudkrEIlt3U0qB8IdeANX0vt4vc96LPq7Vt5HjnvbHZ33QnObymu+in2OUrr3R9ya1xlLFjGl/lHE9KDfTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNoqJHkl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNoqJHkl"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8482b95574dso5639358b3a.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042122; x=1784646922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=14GlidItFhGsteVDeFZQr0b0Q8bnxkhoEthNZJCEcqI=;
        b=CNoqJHklWgUNa0uJQRa6gWAjbX7l5cQUpLhQUWBZedfLTgw5HSndhK8z9cg+T7fjTn
         T1VE89VifZbgnIeI9jQTOonfM7E94NhMiD8IIqdOcPMmVesd7KYP0FeA2wUkP9V8kNgZ
         a4Fz5TjqZB6lw5Gqz5FxlQI/qIanJf92Jfaeg0Kla6TETUaDvZlPKy4FECd5pbIQioE7
         bNJmQ8uKIhCx1OItAr7IrdVuA2F9XHfUIkc9uw36HE7SLGYxM7HNZ76DFz5Y7UgH62dR
         IiYcyLHfKjpnauK2CCCbAkuVlZ18dZk46swv8Lri5G6dUzcHK1TpCGYKIW9a/vQLN1xp
         03NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042122; x=1784646922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14GlidItFhGsteVDeFZQr0b0Q8bnxkhoEthNZJCEcqI=;
        b=pgZ8YnA9ORKvBYV83Vi/wdHFPRbaQgWmp9zVFEaZNRXKp1FaW4oGU2CznrmnPXhkxV
         5hw+UBsavkg3UV+aM/p1rR9AJ40sv7Hab7xLfK3Zb/aYxTLqbREugotmc421KKEtWk1J
         JHq8TFOTDrQ61ETacv7Rtcu7sZQs3sY0+PJrGVZvvw3GuXgARo31zY1NT+QgGpxZ8q2u
         foAII5Wxa95wrGvO74ZC3fh8cu+jG5yi1PID77iBntUCluelm4PsHYkXrZFZpe1mzRr4
         XLdL374jbjj6Tvg+2od85TZZGnmuAfZSi71JATcWbW2JYVzPAiEN2V5Lw4XvCDnRTYZi
         TGNA==
X-Forwarded-Encrypted: i=1; AHgh+RqWIpfVcp72sQVsBzzH+jNYKSzjCk2J/BTR7vQPL3MXEKhG5G/y54VvXSuEcURxceq/2PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhwzgMb2In48B4mtXNLEXvy+EpjIiecDxW6bSxJ31XtdExLY4J
	1RWo9bELshzDDUUVetJme2hVf9gAiMk95N1qEzvwJuDGO5h0wm+/o9/+t8YO8/Yus+PRyoyfOjP
	9RNLSINI8tg==
X-Received: from pfoa23.prod.google.com ([2002:aa7:8657:0:b0:847:99d5:ef10])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca3:b0:845:d286:1fbe
 with SMTP id d2e1a72fcca58-848897aa414mr11307298b3a.60.1784042122068; Tue, 14
 Jul 2026 08:15:22 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:57 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-13-vipinsh@google.com>
Subject: [PATCH v5 12/20] docs: liveupdate: Add documentation for VFIO PCI
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
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
index 2bce2644eba2..20f1d2e20508 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -38,6 +38,7 @@ The following types of file descriptors can be preserved
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
index 77a35742de0a..43b3165d1c68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28328,6 +28328,7 @@ T:	git https://github.com/awilliam/linux-vfio.git
 F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
 F:	Documentation/driver-api/vfio.rst
+F:	Documentation/driver-api/vfio_pci_liveupdate.rst
 F:	drivers/vfio/
 F:	include/linux/kho/abi/vfio_pci.h
 F:	include/linux/vfio.h
-- 
2.55.0.795.g602f6c329a-goog

