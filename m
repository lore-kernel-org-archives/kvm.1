Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D622DFA4
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585336; cv=none; b=QFJQXDbsYuLS01yanIq+5uMRzIRWN3ua6nnoNNkd+AFEaPGJ+RrvbN8RcAeSOsP4/j1A4lY24+QdEeQh1+zs4hoSjbp/5hOvv4pm76Vdxib63byP03TZ3pLmf6B3pLKlBrsSK1v25SnCXPII2pOD+37D7IFmCAUzdLwJQWla8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585336; c=relaxed/simple;
	bh=tReqjMVmX8uLzSTwc3ozu852Tj7RgIMuKLWFv2xESLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNVJRAy+h1K8puW2Py7xmKWGAjgcFeb1gnTpklwhp24JXW0CbBEZ9rNUnYpGdh2y+QAjb2xD3QC5IySlV5v+CWtKz2F+lZ9eoW/Khe5qYfx56SElTWij64PVmY+zCISnJdyIssCqY8AkzEjufWRvcmZxSZwlZMt9+KROE9pPjvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AStqxT8J; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AStqxT8J"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso6078685ad.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585330; x=1781190130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ5QlRlqJf2BWfjEpgZtMhqYoBzzggdHeyuHigzWBDQ=;
        b=AStqxT8J4d+U3PJKtHoBsu6k2npRaUJiPATtnTiw8izzOc3m6W485/174c6Y/T0U1c
         FUVzjtBPUTN5jBZcHwkUbssAOFlHMjGHjrMyBtOwPxVe9uiSKOBo7OhVbvi4jDcGe6Ns
         QEeol3C95KapGGQbUmToSzzB8HrwxqdW4KMozHqKKkT43VU5JwGMz9/IzWwYHQ/oPwi0
         KZ61AZymwp71lJFN2sxtWJ41qw7HAKgYkcJEgynVx7EKT/uMT1g6Z2PSgL+1kNWrqLfh
         NbORZ1X8qEKteaMJFCfABuuq4gMfVT1woMQWP0qXGP+LPGHrT1UfXU75AneXAyXFDULk
         zisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585330; x=1781190130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQ5QlRlqJf2BWfjEpgZtMhqYoBzzggdHeyuHigzWBDQ=;
        b=asAVpclkyTUWuHFauPpMU2Twit0eir7xsPXpr8jmcR+w4QGNDDEValiLtkhkajGT6l
         bxpv9qbq6qkPA1JoSkaj03SrOUdH0/wE/DhuIq/AusgK3BdzRQhuWfauGiurPAdwE0oN
         8D7eziAByBp4veZ5D35czKb1bCFjc2ct0/SLBDNWkrVclVDeH4PApgJ1vg0a3nC54QIk
         5Mh+5tdvEZLb2b2UTAxErnRYIywQLoeLcsaAVnu3agYS+QF+OYLMpGeBXaJ6XzgNpPAI
         wtcS6f2ySCLJH43V3h2fqsukW0A7bRMk4JvoVUggl39X5fJLCcO2tJHg/y+j2lzMz/Cr
         UNtA==
X-Forwarded-Encrypted: i=1; AFNElJ//jqdzL79H8+BsDt24FMZmPPJwmqYjbH+NTRdaGIKpW1WC+9pk94uqUUgXMTMhBa+j+HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVV0cK6AVtIaazPUN9pA6dPqGrvre25sJDCCbIqwSZNAOmh9UQ
	hnFv5/abHRmrSFUCszpl1lqGFyQstS9niOgQqsEwvGiS1VYOtjqEBvfC
X-Gm-Gg: Acq92OEGvtwIGBMhD/X7xTYdivuSxNdx++l7ZbobmILCZeFA0GnqNzLVEoWAqA7OPp9
	IKzCqoEBxqkoT0iCj2BGZEWQJffJAyewDXTkrLv5FsWYu6Bk7uGfeqZO1EpPLE9yLI+l+SsGEZb
	IhICh7P+Mw6KHUEUEbHdAwotglyBqtvRtqxkb3pO0nV/Ed19cJjtBTGhV8HpcTbXuAu8heU16Gl
	XTLJMhVMF4tl9ivO0yIuMOrW+MLvUGkDI6es9PnaX3pBKTqUp14T6RbgGrGoeraiEDFVZ3EWbUZ
	iXuQdgWCJZzE1cO7029Qt86iesZLwwEFxRXcKicLiR5AIUUzzMTVS37f25Xqrh3yM5clhY8+uiP
	UdtKoIBsEkn5SimO2dGv4btBcaIL7haKzNTj4uyiL3z/Vpb5nadAK24GqMp6byXouBQQhQ1Ucbo
	FE79lzrAa5HK/mCzlCdAXE6OBRK/1CAsHNYr2j5B7FJzadp7p0
X-Received: by 2002:a17:903:1b07:b0:2c0:eee2:fc45 with SMTP id d9443c01a7336-2c163a28b9fmr86640905ad.4.1780585329440;
        Thu, 04 Jun 2026 08:02:09 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609df79sm62219485ad.42.2026.06.04.08.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:08 -0700 (PDT)
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
Subject: [RFC 09/12] PCI: Add helper to compute VF Routing ID to pci.h
Date: Thu,  4 Jun 2026 08:01:50 -0700
Message-ID: <20260604150153.3619662-10-dimitri.daskalakis1@gmail.com>
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

The VF RID computation is identical for SR-IOV and SIOV. Add a common
helper so we can share the logic across both.

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/iov.c |  8 ++++----
 drivers/pci/pci.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4aed4f6a42c3..5d65413ce98d 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -25,16 +25,16 @@ int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 {
 	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
-	return dev->bus->number + ((dev->devfn + dev->sriov->offset +
-				    dev->sriov->stride * vf_id) >> 8);
+	return pci_virtfn_routing_id(dev, dev->sriov->offset,
+				  dev->sriov->stride, vf_id) >> 8;
 }
 
 int pci_iov_virtfn_devfn(struct pci_dev *dev, int vf_id)
 {
 	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
-	return (dev->devfn + dev->sriov->offset +
-		dev->sriov->stride * vf_id) & 0xff;
+	return pci_virtfn_routing_id(dev, dev->sriov->offset,
+				  dev->sriov->stride, vf_id) & 0xff;
 }
 EXPORT_SYMBOL_GPL(pci_iov_virtfn_devfn);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 73b913bcb87a..45411960fd2e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1017,6 +1017,18 @@ static inline int pci_resource_num_to_vf_bar(int resno)
 }
 #endif /* CONFIG_PCI_IOV */
 
+#if defined(CONFIG_PCI_IOV) || defined(CONFIG_PCI_SIOV)
+/*
+ * Compute the Routing ID (bus/devfn) for a VF or SDI under @pf, given the
+ * capability's offset and stride.
+ */
+static inline u16 pci_virtfn_routing_id(struct pci_dev *pf, u16 offset,
+				     u16 stride, int id)
+{
+	return (pf->bus->number << 8) + pf->devfn + offset + stride * id;
+}
+#endif
+
 #ifdef CONFIG_PCIE_TPH
 void pci_restore_tph_state(struct pci_dev *dev);
 void pci_save_tph_state(struct pci_dev *dev);
-- 
2.52.0

