Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D03242BA
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585319; cv=none; b=m+0dtaJGxPR28wB4wD9DDV5WziybYqY/O0J/nVgB6DIDiIprSgfi2CrPO2Jpu/LJ0iq4/o/ZCwynM8CasYaMfPmLqmCLVFCGPbj4O9P3T53j2kV0qnjYo7rNj4nLUJnqvvIr2/9qDcSkXZ33Jz6JsB98YGvDwRiqg6IGlNbcooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585319; c=relaxed/simple;
	bh=1Hbl5Tk6BAE0V7gO4BCDGqQK5b7r6ozkSuW8/n3pCu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YL/CaTgg+ttmju21xOnIGJTFElxfb7ejQiMGrCLGV0pEbbCgMr7qLZREPigjdYpNY3kB9x+s814EbYsdowOcOAGx3gICDCQ5r6CD524dFBnSXcl6FbwsM/zuU7rY0oTRcaBHfSwAsr9ttBnZTeVGparq9Zo4AwHyi5xEbr+u7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAILAdFo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAILAdFo"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c85893bce34so336586a12.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585317; x=1781190117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnSLmeLJV6kE0iVS5+3SJmFGhHsRiD3c0F7TGZf1V5w=;
        b=qAILAdFoYY2zB/+tu0xDFqfySALoJC/HXq+8tgNW4C6WSj45sEp8IyvcNQMDXxbU3u
         y9p3OzkMnUR045U6xZ97bael+M00BERez6XSOMEadRXuZkKr1JHyMLq+d0YrIvnOU27n
         iqOwzNMCPN56DV4D5u5InXH4qBcvXqmeZ9vc/O1w3aUcaP+SeQFihqpTdHsm+niPpryJ
         y2GnPr3nH2Md03ClN9EbQhVqFxUhxWXRXWvlMBfVE1cwLlo7ksHje5YUK8U1V4TkhE8c
         GtN69e2Gf4L6P4r5yVNNIVkmfXGSH2KOsgh5PqyDRFoHfKRwB/puriCdcGlhMB0YRufR
         cP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585317; x=1781190117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jnSLmeLJV6kE0iVS5+3SJmFGhHsRiD3c0F7TGZf1V5w=;
        b=I9lm4LKB724LyW+7slULm0bIpYAzBu8rlD145ssHKzjMPMBGDG+RIyZl6NbWnziMaY
         kQVxjZhva+B3JupgwenCe+5lVfAmhVy3Hs6drCCJPKlaGuOZxjDWqZLwBE64Y0cqe8Qi
         zydiVt52pR69AIqjwPCuLcd6cKDd4HI/ESnp04m9sfZA1914HJwUsbVAjMu84GISX1gt
         QjjE2HhCmr3DKF9hoTz8gdKF7qeQomr1mnIFoiAfPN8GdoG64Epj0qU5W0eRnrqfY+oK
         G4NzMtAve4tdckl/XRLCKPa2iSvSgEIrR/fVylUvSsW5uKr5QjjBflYryi1g6S2a3jaV
         ThbA==
X-Forwarded-Encrypted: i=1; AFNElJ/gKpwzy8JPvtr7pd4Mk6d/fcqt+JDiJC5lu2+OEzko/4pFlPV9as7jaFCiQ8IDGiptqY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMMtSa79qCKardCxvH/JE0f47M9JSiGq06VPwNIRlGiIS5kRa
	MGxrmp/tC0iwn4pJwYf2XQIUjq28m7tBZdbO96Sa1VgvsQ75ItcveNjd
X-Gm-Gg: Acq92OF37togLgmoX9wEoAnvWFstj+zQAAJd3rqLZBTOE8uQRgC/GLyH+9S85BfpyWF
	rea+gDgS9NEUN+tBe/zQUzDIWXhzMeIvw8wovL3K1jkpxS3lI6L02bfqh2KTeytzK4FJKI2EGBl
	JJJwQltJZpPu6M5ydLZcrLQ5ycZDoY6oirTzDbFmUMsyTB90alPZIAPUsQwkPFDRbYh3fPWk6dP
	zG62yGMxuka22TOE7o5h9rTQqxQ7hZBrTh1wh1pW/5Z72j1d/cju3WR2DIVS2TBnkC5AlhR6IKS
	+NBeikuF+gPIzjWO81Z3WXhrZFzz2MIx5p92dB1QExRboD8PllP0qxUkqBvkAE74+dmrwBQXeNI
	gCq0wmovHXjS5q87YOrx3SaI93WEviGFuNJduVFHEnmndMAtxuZe7acK3BPGrXUdnLrQLDOn4p0
	jTb4qV2Xl3CWJf6WtdhPjxJu9GJEeFOH8wLgQqCcc=
X-Received: by 2002:a05:6a21:6083:b0:3a3:a9c4:3d60 with SMTP id adf61e73a8af0-3b4975cdbe8mr9228482637.27.1780585316708;
        Thu, 04 Jun 2026 08:01:56 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:5e::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0bdbe4sm5661594a12.32.2026.06.04.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:01:56 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 01/12] PCI: Add helpers to identify SR-IOV PFs/VFs.
Date: Thu,  4 Jun 2026 08:01:42 -0700
Message-ID: <20260604150153.3619662-2-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dimitri Daskalakis <daskald@meta.com>

Throughout core the pci_dev attribute is_physfn is used to determine
whether or not a PF has SR-IOV active. And is_virtfn is used to check
if a device is a SR-IOV VF.

These attributes should be generalized to represent PFs/VFs for any type
of virtualization. So in preparation, wrap the existing usage in
helpers and use helpers in subsequent patches to ease the transition.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 include/linux/pci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..28892243f49f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -604,6 +604,16 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 	return dev;
 }
 
+static inline bool pci_is_sriov_physfn(const struct pci_dev *dev)
+{
+	return dev->is_physfn;
+}
+
+static inline bool pci_is_sriov_virtfn(const struct pci_dev *dev)
+{
+	return dev->is_virtfn;
+}
+
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
 
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
@@ -1277,6 +1287,7 @@ void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type);
 void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
+#define dev_is_sriov_pf(d) ((dev_is_pci(d) ? pci_is_sriov_physfn(to_pci_dev(d)) : false))
 
 /* Generic PCI functions exported to card drivers */
 
@@ -2207,6 +2218,7 @@ static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
 
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
+#define dev_is_sriov_pf(d) (false)
 static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 { return false; }
 static inline int pci_irqd_intx_xlate(struct irq_domain *d,
-- 
2.52.0

