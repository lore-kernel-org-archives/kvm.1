Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429441;
	b=iicCdNe40JJusH5nnmHyzfq8mRmH2zM+DiW78A3EdRe4Y96JYAYOEQ4ccnL3fQGO/6+A
	 rn51HFd1WcGLbWtCFNK9xJebbXQGlVT7lwaKWNpQ+c0mxoZF1oUq1fWn8boQ+NCX16MPN
	 TT7Oz2SG+zM3ty6q0+61QotM1NCeWtkL9KXCUy4Bxf5oADeBbNtE8cA0dr4TWyYphe/1Y
	 g5lPqOYscYHc2hfuH+fa30aS00x/anFdO/y6GStdqZicv0zO5wpNRE4vDsPEHYVHIq5dc
	 65nxHxPn2j0jTNJMmZeF7XfiDT1J9kYieD/P6J/tG0YMxE+JX5bYBTX8jvDfW22ntlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429441;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wpDaWMBSigyyX3qQj3g5pzISsgLs4qVp/n7EpqzqoHg=;
	b=zMIl80AwryAPan1yqFNp8aGmcQGq/yHxhKa8R3H8L/a2pbf7S9Y7l8O7HSzoCNR67x1o
	 HMN0KbCPLKr9xfy5F4OpRnSWYWhUKzLtywbAa8FMyaG7d2DCKrtEDzRXYD5EtfEF2HVGh
	 0h94YBCwuR9qV0txmYJaXsVnNXu58krJnzfGYkGRBmFiZYc44UwfT2Gp5hhjcdf8tIowT
	 ir+laclz+JEfqbQ3fdXg543wQC8t2qhyoOXzpRe6gMhIRde6ntDfmzuAQEP5xSg2OnPK6
	 La480VwemTdSq51gnk59ATZ1PhobWpoafumNQCI3JKgVsKcWAGFRLfWUblX33hB/Zsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ixhfsF1T;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D787606A335;
	Mon, 23 Nov 2026 10:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D787606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ixhfsF1T
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9YjTc3242703;
	Mon, 23 Nov 2026 10:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wpDaWMBSigyyX3qQj
	3g5pzISsgLs4qVp/n7EpqzqoHg=; b=ixhfsF1TGgqnuXPQqNTehqKFN1sxXgtK0
	j/4vuwPelYFunB9bUt4G85zBao9f4bCmE4xkpDGsQilgWKq70K2KZ49cJDHIHVfV
	vPYQFPFLJ+r+VOSHrtswfhsj4tnPdnPW2J0vun8ZQE2Uwo7PWs4G1FuEMNKRkodn
	bOzDwga3Ns1ciuVsks44v0qJnymKT6biLXoZROCTGQQWedJDG96LuEDOz0hhIVKB
	waxzPBcXJ1jgkJo/96LC7nIZvY9ZluVy+s8sORlSCeaRmquiFQGM/0QWzA6pThTO
	pH/4bKKP021cqt8lpT537kjmifqatvZiFg7a7v+JpCjECfLxeED/A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkamd4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:23:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9JGrg1617281;
	Mon, 23 Nov 2026 10:23:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3nmqegje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:23:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANANVUD51380724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 10:23:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A19102004B;
	Mon, 23 Nov 2026 10:23:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCA7D2004F;
	Mon, 23 Nov 2026 10:23:28 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 10:23:28 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>, sourabhjain@linux.ibm.com
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v7 3/4] vfio/spapr_tce: Normalize EEH IOA error injection addresses
Date: Mon, 23 Nov 2026 15:52:41 +0530
Message-ID: <20261123102237.95860-9-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123102237.95860-6-nnmlinux@linux.ibm.com>
References: <20261123102237.95860-6-nnmlinux@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfX1MKG6Y/WWZzs
 YMvoRUU4fA1Nao9Q11fz+zlXv12IazAIcKZrBKPVE041IJYJjfY0WIfM47PhqLodeDhSlXH6w1A
 kbeg4VlfpPgd69+Qn0vWKviqGX2M5VEPnXFzJGCiyLV9Yq/rENe3FQ/CcAHvp1TptCyFV177PeL
 u67qpv02h51ppnvMNzqL674VDLQAj1ZznVLanm3pK/IYYChI/psfRd9j3d4CSgz0XkLFjC2PxSF
 3jbN4/eq2kQLIa9HnLVMYCkZfyOe6LMYiW+gIj2MUofTrq9Y7HBnT//HvjQ3gd7EFQ2G9CU9JoH
 W6+PbsXPPQdfyoU+o7B7N3Zi3eep+3J9xeDdFDnfSVecirFRHDt/tQbNVPbbd0GX9hrCWhRLcAt
 sl7ffjtW5LXALnc8sgifzS1g/PvGAeVwELSzl6UeMilbb3JTWfig58Wn+K22/CRTlguYxsYIjqA
 fOLN03ZdKWOkgG+N0zA==
X-Proofpoint-ORIG-GUID: qwrpq41fp0N8KTZF7Y1IbDT1tTddzp54
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfX5pph5drzAgx9
 LlMuUAA+f/STQz5C9IIaUQ48ZAZGguFjcIZPztHKYfLAbmW/Cr4QYvXQ6J/weT+0StcQDCQ5Uj3
 QsRv+uc1oRQZaZVidYGfSs1omC4maBg=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b041428 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=EGYj-OwPAAAA:8
 a=Y26Cy7KvGLPL97oF5_IA:9 a=xQyHFheebwQZ3wMG2Lhb:22
X-Proofpoint-GUID: DO1aR8ktW8krtna4jszs1AfUHB1Kj7xk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230040

On pseries, RTAS error injection takes a PCI bus address for memory and
I/O load/store functions.  VFIO_EEH_PE_INJECT_ERR callers such as QEMU
pass an address within a BAR as the sysfs "resource" file exports it: a
CPU address for a memory BAR and a PCI bus address for an I/O BAR.  A
CPU address can differ from the PCI bus address because of PHB window
translation.

On pseries, convert the address before calling eeh_pe_inject_err() to the
PCI bus address of the matching standard BAR (BAR0-BAR5) of a device in
the IOMMU group, keeping its offset.  Memory functions match memory BARs
and I/O functions match I/O BARs.  Unassigned and disabled BARs are never
matched, and an address that matches no BAR fails with -EINVAL.

Config-space and DMA functions, requests with address and mask both zero,
and requests on other platforms are not changed.  The mask is never
modified.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 131 +++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 1c0eec228cc6..c56b649d7094 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -23,9 +23,11 @@
 #include <linux/mm.h>
 #include "vfio.h"
 
+#include <asm/eeh.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
 #include <asm/mmu_context.h>
+#include <asm/machdep.h>
 
 #define DRIVER_VERSION  "0.1"
 #define DRIVER_AUTHOR   "aik@ozlabs.ru"
@@ -774,12 +776,116 @@ static long tce_iommu_create_default_window(struct tce_container *container)
 	return ret;
 }
 
+/*
+ * Look for @addr in the standard BARs (BAR0-BAR5) of @pdev whose resource
+ * type is @res_type, and translate it to the PCI bus address RTAS expects,
+ * keeping the offset into the BAR. Expansion ROM, SR-IOV resources and
+ * bridge windows are not supported.
+ *
+ * @addr is in the domain the sysfs "resource" file exports: the CPU address
+ * for a memory BAR and the PCI bus address for an I/O BAR.  Each type has a
+ * single domain, so a match is unambiguous.
+ *
+ * Unassigned BARs are zero-based and flagged IORESOURCE_UNSET on pseries,
+ * so they are skipped, as are disabled ones.
+ */
+static bool vfio_spapr_eeh_normalize_pdev_addr(struct pci_dev *pdev,
+					       unsigned long res_type,
+					       unsigned long addr,
+					       unsigned long *normalized)
+{
+	struct pci_bus_region region;
+	struct resource *res;
+	resource_size_t len, start;
+	int bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		res = &pdev->resource[bar];
+
+		if (resource_type(res) != res_type)
+			continue;
+
+		if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
+			continue;
+
+		len = pci_resource_len(pdev, bar);
+		if (!len)
+			continue;
+
+		pcibios_resource_to_bus(pdev->bus, &region, res);
+		start = res_type == IORESOURCE_IO ? region.start : res->start;
+
+		if (addr >= start && addr - start < len) {
+			*normalized = region.start + (addr - start);
+			return true;
+		}
+	}
+
+	return false;
+}
+
+struct vfio_spapr_eeh_addr_lookup {
+	unsigned long res_type;
+	unsigned long addr;
+	unsigned long normalized;
+	bool found;
+};
+
+static int vfio_spapr_eeh_match_dev(struct device *dev, void *data)
+{
+	struct vfio_spapr_eeh_addr_lookup *lookup = data;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+	if (vfio_spapr_eeh_normalize_pdev_addr(pdev, lookup->res_type,
+					       lookup->addr,
+					       &lookup->normalized)) {
+		lookup->found = true;
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Convert @addr to a PCI bus address using the BARs of type @res_type of the
+ * devices in @group.
+ */
+static int vfio_spapr_eeh_normalize_addr(struct iommu_group *group,
+					 unsigned long res_type,
+					 unsigned long addr,
+					 unsigned long *normalized)
+{
+	struct vfio_spapr_eeh_addr_lookup lookup = {
+		.res_type = res_type,
+		.addr = addr,
+	};
+	int ret;
+
+	ret = iommu_group_for_each_dev(group, &lookup,
+				       vfio_spapr_eeh_match_dev);
+	if (ret < 0)
+		return ret;
+
+	if (lookup.found) {
+		*normalized = lookup.normalized;
+		return 0;
+	}
+
+	pr_debug("vfio EEH: addr=0x%lx not found in any matching BAR of group\n",
+		 addr);
+	return -EINVAL;
+}
+
 static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
 				       unsigned long arg)
 {
 	struct eeh_pe *pe;
 	struct vfio_eeh_pe_op op;
-	unsigned long minsz;
+	unsigned long minsz, res_type;
 
 	pe = eeh_iommu_group_to_pe(group);
 	if (!pe)
@@ -818,6 +924,29 @@ static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
 		if (copy_from_user(&op, (void __user *)arg, minsz))
 			return -EFAULT;
 
+		/*
+		 * Only the pSeries RTAS backend takes a PCI bus address, so
+		 * PowerNV requests are passed through unchanged.  Config and
+		 * DMA functions do not carry BAR addresses, and an address
+		 * and mask of zero carries no address.
+		 */
+		res_type = eeh_err_func_to_res_type(op.err.func);
+		if (machine_is(pseries) && res_type &&
+		    (op.err.type == EEH_ERR_TYPE_32 ||
+		     op.err.type == EEH_ERR_TYPE_64) &&
+		    (op.err.addr || op.err.mask)) {
+			unsigned long normalized;
+			int ret;
+
+			ret = vfio_spapr_eeh_normalize_addr(group, res_type,
+							    op.err.addr,
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

