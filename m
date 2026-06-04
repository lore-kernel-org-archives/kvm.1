Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C13358B9
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585324; cv=none; b=jqnne3gk4jgvyzxz9XRcpSMpp8dVBBC2s6L0f0Haa9EHEzOShkWI/4oRDN+GiDvRAyBFPghGbvuAME7n0jLiRUXHiO3EgKDxokAxlKtv1bjIYCyIJ687k1eS2rPubVpyGHdmTMK6NBeqkOOdbXp35XiuxkySpw/KZbs9B2882uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585324; c=relaxed/simple;
	bh=ugi8jDRcPzL1WqkEZW8QFJz3JbQ/n6QVLYj9qIogyFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUkWU1D2kPyUEnBWWQPvSAWI8/ratLqOUxO/ikar5pP/1DfZrj/OM2l5MckJK2nCkRhmRW+el0B4klW9DENMIWD9W+Ewa5qfOHw2PMOJhfqFZAwl27nwDjw64hK8eGw8nfh6hwpcnc3p2CSedckZmK5hw4v2TnaXlznDdrPY4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu4VVDF6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu4VVDF6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so6546315ad.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585322; x=1781190122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4avmxi/DteAkFA5/0YsT4Z/7bVnyoihvSIvhh9yQxIo=;
        b=Nu4VVDF67GJyyjqYrBOL6CXuIE1QHdnEC8c7NVUfmdDxzSAwm95s5Gop3d04LelDMM
         K0p9E8JIt3wkGCE86d3JQxpz8wVLM0se+Dw1ACQWlpK7QkqZoNcOkTPPQGT9uMg/nL46
         FP39Usp55Ep87E/nTU3T/zxfPcENKsbxk+CxUcwnHgh6tCzdwUgcRkjjaBYx6YI3EEib
         ZPRwpwx+S6O0m6SImm8wmL47SvhrlatBwZNgsmVKBwoyjZQGb69abbzs4ktbCl3YZTXU
         rNk2udLfgK/LcrL/jjFu+/gmdatPEyLG2slisjDcMKVD67z6ODjASXlyGjJmeiXDmKd+
         C6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585322; x=1781190122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4avmxi/DteAkFA5/0YsT4Z/7bVnyoihvSIvhh9yQxIo=;
        b=oF3+fEBzQMppk8d4I5GQ4QIka+khKECUoR78YQfIzNDzB5sUIkA4l8jJ8d3ePUs5g6
         FEKvoGvjDSGiOtAfYZ/HZaKqYOXCc258RDKSKtFeg7lxlkwpQp0u3mgMFui16PJcAqYQ
         316GXGhINklYi4vxLi63NuU6HYx89g6y3HXYJ2wz2L8QJ09IEuVXvI1JtG4aQImYOy8w
         mSzbPoA7aKT24iDTg9SxEMVBMr/ruG4zu6ioUwfsTTIqx/uMPGmamzjIdCED6dCM7JUU
         c66arAjtoSPbKx0qYqS4VFP7MinCMgKuD/EgMcJbov8rFEHqPPcyXb/iY4TtH527C69X
         qeMA==
X-Forwarded-Encrypted: i=1; AFNElJ8Ay6s8LL65WQiP0IeVUAXts5SjVve/XgLgPY6SCvsi8hdvsrcbJ7Rce+h8IZv2NAsL0aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsdRl/ulEVBa73BBP0iOLbDiyd/m60gXAMGYSeh/lJTur9tSp
	2YhSvHE+5zHZCBQQf81TdO/up/fE7gdwMrg92xhe93zKqgcasZzFjgR2
X-Gm-Gg: Acq92OHPln2axpHeAzSSzhbFIyumjhSP+sz1I7U6zO7oqLIU1mhURtbPm8mQDQ17ce0
	8NVib/TEf1aFsSNMFJjnBdEGRVe/oDRU5HkUICA3UORFKiFkm7j2eFZsXgbF0+gzp55f9EM3qfU
	0pMU1sWLMWAlomJ+fyN2SfZ2BELIEpoBjNBAwe51BQ4+6EJwmNZkNRcVtQWUMumBBGOouvD+nXH
	Z6AtYd3mnr7clnhDuP3X7ferHP5mTQOy4gZ2+R7y/8Yk0V/sTmTlmf651QYSKANdBeKfT1oFHPy
	twCBdmAuvpnJAr2S0FOXZduOY/v8Lc0YRCiYrP5WxxG/uunsCF9QgMJtvAbF8jExZ01L8ex1uTA
	yE6XTqSBSfzENZxHdEyPydrF41tHuYQDIhhSsui3Ng5td6UOd6KEq6vgYrWgW4LUzFKnTF1ff8T
	0rWZS9xFCvVMeuGLkMId5S33bvM63gSENelokQMMk=
X-Received: by 2002:a17:903:37c4:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2c1644ca7bfmr89624145ad.25.1780585321320;
        Thu, 04 Jun 2026 08:02:01 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6e2adsm67111415ad.5.2026.06.04.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:00 -0700 (PDT)
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
Subject: [RFC 04/12] PCI: Convert arch/powerpc to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:45 -0700
Message-ID: <20260604150153.3619662-5-dimitri.daskalakis1@gmail.com>
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

Convert SR-IOV-specific is_physfn / is_virtfn reads in the PowerPC
PCI code to use pci_is_sriov_physfn() / pci_is_sriov_virtfn(). These
call sites are all SR-IOV-specific: they guard SR-IOV state
dereferences, VF PE management, or sit inside #ifdef CONFIG_PCI_IOV
blocks. Converting them keeps SR-IOV semantics intact once is_physfn
and is_virtfn widen to cover any virtualization type.

Files touched:
  arch/powerpc/kernel/pci_dn.c
  arch/powerpc/platforms/powernv/pci-ioda.c
  arch/powerpc/platforms/powernv/pci-sriov.c
  arch/powerpc/platforms/pseries/eeh_pseries.c
  arch/powerpc/platforms/pseries/setup.c

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 arch/powerpc/kernel/pci_dn.c                 |  4 ++--
 arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++---
 arch/powerpc/platforms/powernv/pci-sriov.c   | 10 +++++-----
 arch/powerpc/platforms/pseries/eeh_pseries.c |  8 ++++----
 arch/powerpc/platforms/pseries/setup.c       |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index a7b664befed2..cf44ec368a36 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -176,7 +176,7 @@ struct pci_dn *add_sriov_vf_pdns(struct pci_dev *pdev)
 	int i;
 
 	/* Only support IOV for now */
-	if (WARN_ON(!pdev->is_physfn))
+	if (WARN_ON(!pci_is_sriov_physfn(pdev)))
 		return NULL;
 
 	/* Check if VFs have been populated */
@@ -221,7 +221,7 @@ void remove_sriov_vf_pdns(struct pci_dev *pdev)
 	int i;
 
 	/* Only support IOV PF for now */
-	if (WARN_ON(!pdev->is_physfn))
+	if (WARN_ON(!pci_is_sriov_physfn(pdev)))
 		return;
 
 	/* Check if VFs have been populated */
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 32ecbc46e74b..63eacc8001fe 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -987,7 +987,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pci_dev *pdev)
 	pe = pnv_pci_bdfn_to_pe(phb, pci_dev_id(pdev));
 	if (!pe) {
 		/* VF PEs should be pre-configured in pnv_pci_sriov_enable() */
-		if (WARN_ON(pdev->is_virtfn))
+		if (WARN_ON(pci_is_sriov_virtfn(pdev)))
 			return;
 
 		pnv_pci_configure_bus(pdev->bus);
@@ -2379,7 +2379,7 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
 	struct pnv_ioda_pe *pe;
 
 	/* The VF PE state is torn down when sriov_disable() is called */
-	if (pdev->is_virtfn)
+	if (pci_is_sriov_virtfn(pdev))
 		return;
 
 	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
@@ -2391,7 +2391,7 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
 	 * the iov state at probe time since we need to fiddle with the IOV
 	 * resources.
 	 */
-	if (pdev->is_physfn)
+	if (pci_is_sriov_physfn(pdev))
 		kfree(pdev->dev.archdata.iov_data);
 #endif
 
diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 7105a573aec4..1113488f4372 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -225,7 +225,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 
 void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
 {
-	if (pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(pdev)) {
 		struct pnv_ioda_pe *pe = pnv_ioda_get_pe(pdev);
 
 		/*
@@ -235,7 +235,7 @@ void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
 		 */
 		pe->pdev = pdev;
 		WARN_ON(!(pe->flags & PNV_IODA_PE_VF));
-	} else if (pdev->is_physfn) {
+	} else if (pci_is_sriov_physfn(pdev)) {
 		/*
 		 * For PFs adjust their allocated IOV resources to match what
 		 * the PHB can support using its M64 BAR table.
@@ -479,7 +479,7 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
 
 	phb = pci_bus_to_pnvhb(pdev->bus);
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return;
 
 	/* FIXME: Use pnv_ioda_release_pe()? */
@@ -508,7 +508,7 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 	u16 num_vfs;
 	int i;
 
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
 	iov = pnv_iov_get(dev);
 
@@ -620,7 +620,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 	struct pnv_iov_data   *iov;
 	struct pci_dn         *pdn;
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return;
 
 	phb = pci_bus_to_pnvhb(pdev->bus);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index b12ef382fec7..32030ac9be51 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -54,7 +54,7 @@ static void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 
 	dev_dbg(&pdev->dev, "EEH: Setting up device\n");
 #ifdef CONFIG_PCI_IOV
-	if (pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(pdev)) {
 		pdn->device_id  =  pdev->device;
 		pdn->vendor_id  =  pdev->vendor;
 		pdn->class_code =  pdev->class;
@@ -68,7 +68,7 @@ static void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 #endif
 	pseries_eeh_init_edev(pdn);
 #ifdef CONFIG_PCI_IOV
-	if (pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(pdev)) {
 		/*
 		 * FIXME: This really should be handled by choosing the right
 		 *        parent PE in pseries_eeh_init_edev().
@@ -731,7 +731,7 @@ static int pseries_call_allow_unfreeze(struct eeh_dev *edev)
 	if (!vf_pe_array)
 		return -ENOMEM;
 	if (pci_num_vf(edev->physfn ? edev->physfn : edev->pdev)) {
-		if (edev->pdev->is_physfn) {
+		if (pci_is_sriov_physfn(edev->pdev)) {
 			cur_vfs = pci_num_vf(edev->pdev);
 			pdn = eeh_dev_to_pdn(edev);
 			parent = pdn->parent;
@@ -779,7 +779,7 @@ static int pseries_notify_resume(struct eeh_dev *edev)
 	if (rtas_function_token(RTAS_FN_IBM_OPEN_SRIOV_ALLOW_UNFREEZE) == RTAS_UNKNOWN_SERVICE)
 		return -EINVAL;
 
-	if (edev->pdev->is_physfn || edev->pdev->is_virtfn)
+	if (pci_is_sriov_physfn(edev->pdev) || pci_is_sriov_virtfn(edev->pdev))
 		return pseries_call_allow_unfreeze(edev);
 
 	return 0;
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 50b26ed8432d..8165ae9adbd6 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -778,7 +778,7 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
 	const int *indexes;
 	struct device_node *dn = pci_device_to_OF_node(pdev);
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return;
 	/*Firmware must support open sriov otherwise don't configure*/
 	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
@@ -799,7 +799,7 @@ static resource_size_t pseries_pci_iov_resource_alignment(struct pci_dev *pdev,
 	if (!reg)
 		return pci_iov_resource_size(pdev, resno);
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return 0;
 	return pseries_get_iov_fw_value(pdev,
 					resno - PCI_IOV_RESOURCES,
-- 
2.52.0

