Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683174DA9AC;
	Mon, 19 Oct 2026 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405165; cv=none; b=FT+ZFgq7av2JgFash5v5HORqA9GblW0cmyuu7vCulm6AWtRVdi1nImNLCiCKDxus8oHnFPIL4TrIgmyS+qoDm8pTs72Tfcutv6yRoqDIJMT+W4iCMfwrLDDV9J72lZaq2VX/W3Dd6vsan9d51pNU/XfhMAvQTpAtWnqfof3FZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405165; c=relaxed/simple;
	bh=iaoi1kwn+Q3Yh98G7EmHcVKwOrakjlKvAQTTzvobGJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRD5xr6qBDSHHNVRCmGmRg0HH2Q4dA+ey8l5ES+vVkqb3CUqG6rF7XQEXwgz8iWGe0LZ6YbW5clHs7GLOnpHJjNwpu2EQnDEWnCkPkSsZ1AQdwnL5VU7EuxG1VZtTyQwe1yGIU+w8RfPKkfKiaX8qHYe4HJ2jSPByupVj9Vy2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OTdN9aVG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OTdN9aVG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8iM6B3347787;
	Mon, 19 Oct 2026 10:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ttWTj2WQ5sU6Dt8NU
	VOW7LvYepXNg6L8fRu+PxYx6Uk=; b=OTdN9aVGASXFhYK2y2k0fGvmsteZBMoCx
	g20JWrdh2rhqoX1irUvl//v1hgEoI6knL7sSbGger4VY4ohhwYI0bKjZxzvY2IBW
	XoLs5Nbh/hA1g2psDyWyAQpEISI4Dc7oQl1SmIeDQWvSpnIwHQ05q3Me/TIRD4oY
	ie89KzcTwqdXeLIIZbuEuGcftWzAHaIqGBVskuJvCj0p/EG7p5dHSCeoHvLq7DRE
	ojTe4SdEchmncgzmwDJd3LPWA2Il1I2Na2I/uwAhFSvohRpGIDM7F3+roRvHGksK
	5hC1TRRwa7kSXXyE+zn8GM7yh7T3CwHH2sykyiGa+KQlXr1x/Uxkw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvsq7d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:19:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Z0Vx3889583;
	Mon, 19 Oct 2026 10:19:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmugw5mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:19:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JAJ5UM49676590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 10:19:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64BAE20065;
	Mon, 19 Oct 2026 10:19:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADB622004D;
	Mon, 19 Oct 2026 10:19:01 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 10:19:01 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v5 4/5] vfio/spapr_tce: Normalize EEH IOA error injection addresses
Date: Mon, 19 Oct 2026 15:48:12 +0530
Message-ID: <20261019101813.45085-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019101813.45085-1-nnmlinux@linux.ibm.com>
References: <20261019101813.45085-1-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX/eDKrTfsehsW
 JqgNhnXGU3zD0DBLKBtypWCLOirIo+PmxoRqw+sJ6gM9QRFvtjEo8IX8p4xnU4W7t+3TOkTlQ53
 NlmnV+mR7Qjc+jt9QqQoVD/jLsEKiww=
X-Proofpoint-ORIG-GUID: LDNNxbHFjBgwfU5oTI-0QlEG5crcsJFA
X-Proofpoint-GUID: S4noOf-vz05zpqUwbQiciNimI9hOcwTS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX/tEAe4aeVfD8
 ImPvWN4RVQ5D6GrqMNoe7sYcvXjQOJxbM76LehDvXfn9MGV+5rtJbG8gOHvZaWZh6DBxxk4RrHq
 KusM9xlK3xjtPtItSOduHhBsSbPz9L7wNKfuecwQXBDpTnd7v4RxEtEofXJbcRm5g4j0taIffkK
 TznhMn4lN9bW5160aXUzA86KZEb2S9j4sE+XXEQW5h3x1/9Kk7BNJYm6uEU1fAze/hkWihJ9r1J
 O3vcgF/fEm1ZS9s8xngfTVabG9HDujn7GFp+SnoOPEpRSdxVyL6opAze8jLd3N3YEK7gAFe6/Sm
 GOq0ibJo3bNgoWTDypkMazKbEVNW3NSnuTsrkbuzOFZLTDqbeXNxFVoW6+yHshVrTjB50J/4CLW
 GskRcJfLae+yCPt+bI+4KJCO/XuXseUOJgPpTQwaqvKrpshulAtUbLRt2q5zsXxm9G7U4VLNsIf
 UM02tzhPIvfzdDaFwDg==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad5ee9f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=WTuDyPl4slZZHiUw8mUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190040

VFIO_EEH_PE_INJECT_ERR receives a target address from userspace.  For
userspace such as QEMU, this address may be derived from the host Linux
BAR resource.  The platform EEH backends, however, expect the PCI/IOA
bus address used by firmware error-injection interfaces.

Normalize IOA/MMIO error-injection addresses in the sPAPR VFIO EEH
ioctl path before dispatching to eeh_pe_inject_err().  If the supplied
address is already a PCI bus BAR address it is left unchanged.  If it is
a Linux resource address, translate it to the corresponding PCI bus
address using the BAR-relative offset.

Normalization applies to EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64; other
error types do not carry an IOA bus address.

An address and mask pair of zero represents a no-address injection
(e.g. a function-level error with no specific IOA target) and is passed
through without BAR translation.

Only standard BARs (BAR0..BAR5) are searched; ROM and bridge resources
are not IOA bus-error targets.  Hold pci_rescan_remove_lock while
traversing PE devices and their BAR resources to prevent PCI device
removal from racing the lookup.

A pr_debug() is emitted if the address cannot be matched to any BAR, to
aid debugging without producing noise in the normal path.

Keep the helper local to VFIO so the address semantics of other
in-kernel EEH callers are unchanged.  This provides common handling for
both pseries and PowerNV backends.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 105 ++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 1c0eec228cc6..dad9ba54bae6 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -774,6 +774,97 @@ static long tce_iommu_create_default_window(struct tce_container *container)
 	return ret;
 }
 
+static int vfio_spapr_eeh_normalize_addr(struct eeh_pe *pe,
+					 unsigned long addr,
+					 unsigned long mask,
+					 unsigned long *normalized)
+{
+	struct pci_bus_region region;
+	struct eeh_dev *edev, *tmp;
+	struct pci_dev *pdev;
+	struct resource *res;
+	resource_size_t pci_start, pci_len;
+	resource_size_t res_start, res_len;
+	resource_size_t offset;
+	int bar, rc = -EINVAL;
+
+	if (!pe || !normalized)
+		return -EINVAL;
+
+	/*
+	 * addr == 0 and mask == 0 indicates a no-address injection (e.g.
+	 * function-level error with no specific IOA target).  No BAR
+	 * translation needed.
+	 */
+	if (!addr && !mask) {
+		*normalized = addr;
+		return 0;
+	}
+
+	/*
+	 * Walk standard BARs (BAR0..BAR5) of all devices in the PE.
+	 * Hold pci_rescan_remove_lock to protect pdev lifetime during the
+	 * traversal: pci_stop_and_remove_bus_device() requires this lock.
+	 * ROM and bridge resources are not IOA bus-error targets, so the
+	 * search is limited to PCI_STD_NUM_BARS.
+	 */
+	pci_lock_rescan_remove();
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (!pdev)
+			continue;
+
+		for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+			res = &pdev->resource[bar];
+
+			if (!resource_size(res))
+				continue;
+
+			if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
+				continue;
+
+			pcibios_resource_to_bus(pdev->bus, &region, res);
+
+			pci_start = region.start;
+			pci_len = resource_size(res);
+
+			/*
+			 * Case 1: userspace already supplied PCI/IOA
+			 * bus address.
+			 */
+			if ((resource_size_t)addr >= pci_start &&
+			    ((resource_size_t)addr - pci_start) < pci_len) {
+				*normalized = addr;
+				rc = 0;
+				goto done;
+			}
+
+			/*
+			 * Case 2: userspace supplied Linux resource/CPU
+			 * address.  Convert it back to PCI/IOA bus address
+			 * before calling the platform EEH backend.
+			 */
+			res_start = res->start;
+			res_len = resource_size(res);
+
+			if ((resource_size_t)addr >= res_start &&
+			    ((resource_size_t)addr - res_start) < res_len) {
+				offset = (resource_size_t)addr - res_start;
+				*normalized = region.start + offset;
+				rc = 0;
+				goto done;
+			}
+		}
+	}
+done:
+	pci_unlock_rescan_remove();
+
+	if (rc)
+		pr_debug("vfio EEH: addr=0x%lx not found in any PCI bus BAR of PE, injection may fail\n",
+			 addr);
+	return rc;
+}
+
 static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
 				       unsigned long arg)
 {
@@ -818,6 +909,20 @@ static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
 		if (copy_from_user(&op, (void __user *)arg, minsz))
 			return -EFAULT;
 
+		if (op.err.type == EEH_ERR_TYPE_32 ||
+		    op.err.type == EEH_ERR_TYPE_64) {
+			unsigned long normalized;
+			int ret;
+
+			ret = vfio_spapr_eeh_normalize_addr(pe, op.err.addr,
+							    op.err.mask,
+							    &normalized);
+			if (ret)
+				return ret;
+
+			op.err.addr = normalized;
+		}
+
 		return eeh_pe_inject_err(pe, op.err.type, op.err.func,
 					 op.err.addr, op.err.mask);
 	default:
-- 
2.54.0

