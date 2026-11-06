Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004152;
	b=PjY2rnNc4ts75MrZQ7pTo9xzf+uTlPuZqqt5GmrU+qZpsJhOjnmRzAy3aAwJcUwOIzFN
	 i0sozOBfqxAmH8UOk/gCijh+6G/XrS7CoA/pY9rwz3+GB0Qi8lCwExbHpk3StRES4SFkv
	 cYobtPlEMQtAbI2GUa1EtfrSuklul4ap/VLONcc8FuDcOCSeLmmqrrdZ4WMThz7H2CzgV
	 1DfBE8gufqUT6rMonIr6MyTfDpas71CregwFHPE/SCfoeuTxZ2y6hmLo0EAPiq82iZdyP
	 EfjRIc+Qqhn3Ib10Mtrnu7fFHHFN223FUXUBhs3szFIzVolvn3cyAEMyhW7iVoDZ8bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=i6wtLwteYwyUZUWdoRocIhX8iiQGzMdlm5waC4g0QLs=;
	b=tIlvCPKFztFxAmunNrvKoF1deg8Nrcxa4dX5rslVmi9VANRx6jtzSbL4BdECkN65bPbE
	 rRmdUbpE5sX0+vHLTy4JeR8yUsDuf5dsZOcWdVxD59hDc1tb0UlLM85AXhWjjAjCiwQKR
	 9FyUaGXzGV0MH54iez6OYmrwXdGvDf8MgRtV5tvcYyni/X6p1noBa58+eqar/RXN4EKOD
	 ImXbqJuheDwpLKJDtSkOfF3vul6qCtBGYgWelWNEYt2Fj+WkRVENPci+SwcydBmaYg2FF
	 czIMY2OBCHlfeov7GJN+2qKOLRW4dJ1m/PRWLQCrveRP7G0zZvl6jQc1NzXedRrwzkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gkl+CmfF;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF230606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 22:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF230606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gkl+CmfF
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ed3f563739so11635ad.0
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 14:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794004151; x=1794608951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i6wtLwteYwyUZUWdoRocIhX8iiQGzMdlm5waC4g0QLs=;
        b=gkl+CmfFQ+Co71nT6Egy2HcSuWbxjmTrMcP4xLom+yPt7cEbNxsDoECW+9ukC5saGE
         +AySoNHT/voHJzM5UxjovhfbBA4XVMmOzenTYYDHMTsRbS8yBDI6QJCC/DhqETSb9rfi
         DOMe5p5m8Jf6QID1xENOM2zAR1ZJEac4eAVE38l+dObMh2ofbhr/jGqeJ6w/wQziIRyG
         7e0XENuBRYE2xUyk1zPMSoXhVrt2mPi/FAktijRb4aYgmhwzysr64/2u5MQmgud0WLGQ
         edRQIb+VHahReTzYz8nVaVx/ZTWIZiGWFzXVnUzS8RaVeSJDFuxuhL+tw/ESiAOBb6g1
         rz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794004151; x=1794608951;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i6wtLwteYwyUZUWdoRocIhX8iiQGzMdlm5waC4g0QLs=;
        b=q2y9z7qjZLZhCWrWcJD/wf5Gy0c0lEC+3Tyr3D8eBMw8yOlgy5P+9j9DIk8uQH6jCF
         KP6cJFLW+aEgtdcB8zdr6VOdidsqba6r72WUNzW3Sg1Y2W0WQpaj6GKxNHtYhI6NQEMd
         IHKSYvUwKtHMMMQkr21+DYyNxM7lwANEfMLTizbi2DHv1KZMSvXimaAAKa/yHRsSQjjV
         QhF9vfiljw3HzXyZKij9SFjrDL5B2bfUs3nfpavRhdCCIYwkUNF9JGXKpi5yTSlRVjro
         OuKl8nXzI2C9Ap1wQLWZGDOYjOmVv0ycMTQpeODmbhlXj1cXs3OeWq2q3viPJY5fjsBQ
         Sjfw==
X-Forwarded-Encrypted: i=1; AL+hErHFnWGg023uIw7dsAeRGp+m7Hj7LJ99ciF2puKZjDRoszA65kkOapSBUYx32Etp1rstsw0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CoV+nbnAdX3+ETM81LhrW3FY8EUvu1fbYnP00SMa/UrExPEqB
	QPiZbF7YAi8EtUE7q8tdbDmFr6sNSATa1lpZHIF3MHCBZ/9/YgLtP/BkThzmCaKxMQ==
X-Gm-Gg: AYBFou3qH5hjIQ7n28g0CI+j+PkxySarZML6otLagRcpNYxDfBhtMXpDMW1gcWe/p32
	sC772n3hM7J1romPgYxn/tsnsKje2upRzADNcIkDeU/1U7aRs+lt4XmWRsDdWMYuLe4E07i0NhV
	IjxEdlYqnqcVe402qiIyNM1g6iu+xWD+eH+dtRUVhKCMe06gWQutjnTBBXTUjYA1MgY88aPn9k1
	8v4HJwvJA2044CLYktMxN4671BjsRzUKMl9c+/wTOoZBL9Ap8wLZTAeyLEiAd7YWjPiICdQ7k8+
	zCzeak4N3VT1oxS7v84+ofgE1sEKmkoZiFQ52/J0dJoMOsPols9dp2WON5xCJctBMAdC3PsJo8n
	FDQw3sr6IC4dIVFbXVLNKRNNgqCzNTLhiSiOzNYwGwRCVB44ZcrhuQQtFlg0pZtpiz+/Pealt/u
	VnEE7b7uHhJXhs5IhwkcN1pZfU58UP6xQzxp1evueuHXJDqGoF0x66FDwOX04UO+zs5/HHlWd1X
	KXsjfh3dxfHkE8HABxWVaGnc50K8aMrL3o53qwvUOPxaZHFeo52BRVlX6FlmG6rc+uDESNkFYe8
	hTCE36jLz0YcWHu9IQhIJ61qfe/3OJvKwviMeHBIJpWed2lEP4f/7HvEDCZL8YopnKtaFmem3Ic
	8NfQptbc4GioYEVeQXrPK+9tyeoQdtypj61BevRi1Y0A=
X-Received: by 2002:a17:902:ef11:b0:2eb:188a:1c06 with SMTP id d9443c01a7336-2ed6a865b76mr263955ad.9.1794004150728;
        Fri, 06 Nov 2026 14:29:10 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc27e829sm775868a91.0.2026.11.06.14.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:29:09 -0800 (PST)
Date: Fri, 6 Nov 2026 22:29:06 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, 
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rdunlap@infradead.org, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 04/27] vfio/pci: Register a file handler with Live
 Update Orchestrator
Message-ID: <au5T7qouVfxJSDmr@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-5-vipinsh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261102153656.1431701-5-vipinsh@google.com>

On Mon, Nov 02, 2026 at 07:36:33AM -0800, Vipin Sharma wrote:
>Register a live update file handler for vfio-pci device files. Add stub
>implementations of all required callbacks so that registration does not
>fail. Register it with both live update framework and PCI subsystem.
>
>This file handler will be extended in subsequent commits to enable a
>device bound to vfio-pci to run without interruption while the host is
>going through a kexec Live Update.
>
>Put this support behind a new Kconfig VFIO_PCI_LIVEUPDATE. Initial
>support is added for no-iommu model vfio-pci devices.
>
>Co-developed-by: David Matlack <dmatlack@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>Signed-off-by: Vipin Sharma <vipinsh@google.com>
>---
> MAINTAINERS                            |  1 +
> drivers/vfio/pci/Kconfig               | 11 ++++
> drivers/vfio/pci/Makefile              |  1 +
> drivers/vfio/pci/vfio_pci.c            | 11 +++-
> drivers/vfio/pci/vfio_pci_liveupdate.c | 75 ++++++++++++++++++++++++++
> drivers/vfio/pci/vfio_pci_priv.h       | 14 +++++
> include/linux/kho/abi/vfio_pci.h       | 28 ++++++++++
> 7 files changed, 140 insertions(+), 1 deletion(-)
> create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
> create mode 100644 include/linux/kho/abi/vfio_pci.h
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 5d1b58271989..167aa9d66ce8 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -28662,6 +28662,7 @@ F:	Documentation/ABI/testing/debugfs-vfio
> F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
> F:	Documentation/driver-api/vfio.rst
> F:	drivers/vfio/
>+F:	include/linux/kho/abi/vfio_pci.h
> F:	include/linux/vfio.h
> F:	include/linux/vfio_pci_core.h
> F:	include/uapi/linux/vfio.h
>diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
>index 296bf01e185e..e8285ad93a69 100644
>--- a/drivers/vfio/pci/Kconfig
>+++ b/drivers/vfio/pci/Kconfig
>@@ -42,6 +42,17 @@ config VFIO_PCI_IGD
> 	  and LPC bridge config space.
>
> 	  To enable Intel IGD assignment through vfio-pci, say Y.
>+
>+config VFIO_PCI_LIVEUPDATE
>+	bool "VFIO PCI support for Live Update in no-iommu mode"
>+	depends on PCI_LIVEUPDATE && VFIO_NOIOMMU

Can we handle this dependency in code instead of doing through
configs? Are there any build dependencies on noiommu?
>+	help
>+	  Support for preserving devices bound to vfio-pci in no-iommu mode
>+	  across a Live Update. It enables a device to continue working (DMA)
>+	  while host kernel is going through a kexec live update.
>+
>+	  If you don't know what to do here, say N.
>+
> endif
>

Thanks,
Sami
