Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF34DDB57
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605902; cv=none; b=DEdygt21YMQRLQcsTb79BvuUNiA25iZdd9YT8IJSAB9xZEGqIjDsV8mcIpyfaDazTul9ANDMjdkHlXlbrlkgL5i9oWgU4R4lFRJZgp1UynLQpDZhbJzrHQqOaL6zIQHeiZWqumHvPWHfpdAc1ov3abIS63v00/dxel5tWqLV7iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605902; c=relaxed/simple;
	bh=H5GiHK6ztFKrLa7xReiffciw7VCa8JM2dUKAkH6u0T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6AfvXUGtOSttKK3f34gAqp36iWCOBfwmZUiJ/N8uzotUaCzX8IcYrvrxuVSYWyKRX7IsfxniJz9pKS2sW7GvYqMN7D8LSNZ3q3IOQ70KZtzYtzJTVe6IzpbjSOnvMLC6LwEqOQaVE7Nx3PNgtPdc4mwv+/4S3TmhiawvkfxI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WEJVLUt6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IMejttRt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WEJVLUt6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IMejttRt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAOjL2294806
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=z60xJj9fp2vRAD3QTBKkgHGd6KjBHDRVy/O
	SLFJMMjU=; b=WEJVLUt6Qgndx5YiL7HpWyG8kpXQW6l5olRaMN4FmaJtiSAMI7T
	3yv/pOhRBpkLZyiKRu0CfqCIbDxYg1vdaHIBC73J9OOf/tSqGMkuhLADt8b5ShH5
	BBBWHHl4A3D2+X1ObB3j0llCuQrJgtg29SJEBbeGast4A4kD2OXm+BAihAAGIShA
	BgZ0QlwUae0plvs6QYFxdtCn8m2+kcG9SqUn7P3XW5f+co5y7bdt6hJLhfJIzh9X
	c4ISX9iTXWVvLjlGbhpAY9jv8e/3I4XsnmtFwE/KWcOm9EtiAQ4z5l6gsYcoSSMt
	F177KeS7x4cTW3Fi7Mbg/muDcB24nsKEd8A==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubj0vh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:31:34 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97e9909eeeaso251069241.3
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790605894; x=1791210694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z60xJj9fp2vRAD3QTBKkgHGd6KjBHDRVy/OSLFJMMjU=;
        b=IMejttRt1+Ccu7pVB4V3at0FCK5IHYO9zYD4i2kEEYff0Bvx36ZtnijBN2QUec7Zh1
         g4Znu9TAWML3OwNUaSGsc9hn5L0ceQFoz9QoHA2fA5p/uLwAB9cdFXPLWyx9CoJuo4re
         AQbEAMmIWDMcPNauJ+vFHQPQnq50eh8ZuVOLDE4CKcIV/zmwgu2MAIAFY9oUuvbXoLCp
         lBUFuhvah1PbphkoNa1t3zzpAOXWv3C6zSbXyL7tngGwk0aEZyAFGD4McEDT+GQYE060
         JMLdror/xV+kHi6Qi+G/dCW5PZn0K0kgVLz0BvcuzIUh0GEEYCMYrvXYDtdDRRoj3ES6
         1kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605894; x=1791210694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z60xJj9fp2vRAD3QTBKkgHGd6KjBHDRVy/OSLFJMMjU=;
        b=gRR6uqiv0goMDCTRWkjYLxld0zilQxaMIjuEfqyhMJ34dtRwrlMPpfR6Nu/eoxRt5J
         rZxX4DSOIJyi6zX4tvieqMosQ8GOE+JHzKLt3QO/EnLaRBvNCrT5FVMWUuXL7Gc3gwNf
         HvLNJn+zWK/4wlGTixYkl0/ucexpsQGxdqlyQVvC/rZQI6CEUBRupCw9M5RJoh7Rc+Dr
         YQVTursa3UqEFHzkebr05iXOLOsKdvKEHKFF2NKRuzszKnbEDYcGKe3ztOXRd0JyLX7E
         Mv96YBLtv/6D0iaab4f0gCKnUI/8iEEFDfwemIC1qVJCihihtOU3XMFQSP1wwh1IVPC1
         vAkg==
X-Forwarded-Encrypted: i=1; AKwUvBy4GtwnSmyORSs5walfInDKmk8CWYX/FoXMGW5ox4Kc2mvLOUhKrzeKlRsH9VA4ChoPjSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSZAsTXg80Hghv8csYmPPh2A/2DIcqZ5lm3kbijBHho0HZ7Xf9
	mTA/HDIqpE4+376WBBs1i0dWBZQaB/nDNE9vtIao4ZrUlYYtk0DunMTK3rh+mrbYd2ACzAMeJlq
	mTdgqnObKdENSi7tOnjterNCWlTChTK/ut1NOKe/VTReYkS6qtTrlOoA=
X-Gm-Gg: AYBFou1G/CV8iHP5curlDKbu7wtVH7V2CpOSSOX5WdSFseftZ13V/CsronK8+d+wEH7
	Qphrs40hn+KZI/6C90cmN0SSncKbc1c+9CHyjb5gx8uJjj3OGdeCpipWyrIqiULNtcVl0ufytNN
	BFR+UEubmvJIw9WV6kXFnvnF/O81Yu6lBpbLWL/60pVM2PCHkArgk4VPuoKlCO3U4pUoV3stI4d
	3NM6Aouv+P1nFthyricMhFTgOPsrWPU6YeqE3cWQxM0EGwJD1BVSx2Fx7k60fQNxBrVOqN2mLcG
	r1+RfqcVgGSZSuyytn1NNm18f12qdWiWOrN0/z2dBiKgqNwNxhJRhmWpMtDt3g9h178k3haM0F7
	PM1u4s459ylwfeytK3ofKMzrBxuEDDlODtPk38w==
X-Received: by 2002:a05:6102:c03:b0:7a7:196a:84e6 with SMTP id ada2fe7eead31-7b390445334mr1520070137.30.1790605893566;
        Mon, 28 Sep 2026 07:31:33 -0700 (PDT)
X-Received: by 2002:a05:6102:c03:b0:7a7:196a:84e6 with SMTP id ada2fe7eead31-7b390445334mr1519697137.30.1790605875667;
        Mon, 28 Sep 2026 07:31:15 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3bcadbsm292389266b.72.2026.09.28.07.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:14 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 00/14] iommu/riscv: Add irqbypass support
Date: Mon, 28 Sep 2026 16:30:59 +0200
Message-ID: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hS2IfNXD7fv9nbrYVCCSV-6X01A0LS5P
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba7a46 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=bDdBU3oEAAAA:8 a=EUspDBNiAAAA:8 a=SRrdq9N9AAAA:8
 a=JbFp9CTg7fNynJPQWhgA:9 a=1WsBpfsz9X-RYQiigVTh:22 a=DN7SgORnOiO7RqxRx1GC:22
X-Proofpoint-ORIG-GUID: hS2IfNXD7fv9nbrYVCCSV-6X01A0LS5P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX0153ydpTej7j
 z4k4FtW6vHFeW0iCCds38kvF/H9T476W28KQP+IbdyFzLdTRkq4KQ5DmSzyjakon3pKGBY79Iz+
 ROr2fSEGmQ9Jcaqyb3hpyqNd9wwjr4qT0zprPpY6Q9Knl796EmRhzUm2wm1tJ3/U+HO25xsKNNZ
 QPQKyMgMdMVCNvV447Az49q2HNp49FaiaPt2uR4wfE8nSuCPNOhOuvNFGUbq5xETHnPqVAqpXlO
 bmFx2rFdtVG0cp3jYbqA1viDFxhT/7SWV//vi+h9X2aAC9J1K6BjzlooUvp4jwftBbijudlZgYg
 iZp1zFcKkb3evXYUpZz2T4XSngpb1DczE7vp4qSyIEkCvv/f16Qz1Hor2AfdhusWHX/ii9N4ZoX
 1Kw04y9IG73tvI50olJ3gIYnAc3ac0yc9Fd9RUvcloAlYanxZSA5n+nbKaZXlm0KuDEuoFPVeFn
 uWiINsz8l6VkRmsO1lw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfXz+j/4b6QtXV7
 2VzUoXUvanvZh8QR2+lfmxDmc8U2MvbQF+2tsraTjj0DeQ+hppL9vt78xEoSatgdLve+n3lgTfK
 1SJwhrx7Op/EK33Pp7GprP3yK+f/THg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280057

This series adds the RISC-V IOMMU side of IRQ bypass, allowing MSIs from
assigned devices to be delivered directly to guest IMSIC interrupt files.
It uses the IOMMU's flat MSI page table to translate guest IMSIC addresses
to their host backing, with support for both hardware guest interrupt
files (VS-files) and memory-resident interrupt files (MRIFs).

It has been a year since v2[1], and much of the design and implementation
has changed. Host MSI remapping, IOMMU_DMA, and VFIO enablement have been
split into a prerequisite series[3]. This posting contains only the
IOMMU/IRQ-side support. The KVM patches will be posted separately: they
are currently a minimal client for testing this interface, with further
work needed for general device assignment.

The design evolved while considering two-stage guests in the discussions
with Jason on v4 of the host MSI-remapping series[2]. With a guest vIOMMU,
the address in the device's MSI message may be any guest IOVA which the
guest's first-stage page tables map to a guest IMSIC GPA. The hypervisor
cannot determine the target vCPU simply by decoding that IOVA. Instead,
the intended hardware path is:

  Guest MSI IOVA -> S1 -> guest IMSIC GPA -> MSI table -> VS-file or MRIF

An MSI-table match completes the translation; addresses outside the MSI
pattern use the ordinary second-stage page tables. With S1 Bare, the
device uses the guest IMSIC GPA directly. Populating the MSI table with
all guest IMSIC targets allows guest changes to S1 mappings or interrupt
affinity without corresponding MSI-table updates. When a vCPU's host
backing changes, the hypervisor updates the entry for that guest IMSIC
GPA, leaving the device message and guest S1 mapping unchanged.

The MSI table belongs to the second-stage IOMMU domain and is shared by
all devices attached to it. RISC-V requires second-stage translation to
be enabled when using the MSI table. This is separate from host MSI
remapping, which uses ordinary page-table mappings prepared by the common
DMA-IOMMU/iommufd code and composed by the IMSIC driver.

A per-IOMMU interrupt-remapping irqdomain, installed as the MSI parent of
eligible devices at probe time, provides the irq_set_vcpu_affinity()
entry point. The IRQ hierarchy remains stable across IOMMU domain changes.
The callback obtains the device from the MSI descriptor and operates on
its currently attached second-stage domain. The irqdomain has no private
per-IRQ mapping state or MSI table of its own.

The affinity protocol supplies an owner, the guest IMSIC address pattern
and mask, and the complete set of guest targets. The first forwarded IRQ
populates the table and installs its configuration in every attached
device context. Further IRQs share that table after checking the owner
and address layout. A separate target-update command changes a guest
IMSIC's backing without changing per-IRQ forwarding state. The last IRQ
to stop forwarding removes the table configuration from the devices.

The main changes since v2 are therefore:

- Separate host MSI remapping from guest IRQ bypass, and use second-stage
  domains for the guest MSI tables
- Replace per-IRQ MSI-entry mapping and reference counting with complete
  guest-topology setup, domain-wide table lifetime, and individual target
  updates. This is intended to accommodate guest-controlled S1 mappings.
- Add IOMMU-side MRIF support alongside hardware guest interrupt files.
- Move the KVM client out of this series

This remains an RFC, particularly for the relationship between the IRQ
hierarchy and the domain-owned MSI table. Jason raised the alternative of
a per-VM irqdomain owning the table[2]; the arrangement proposed here
keeps the IRQ hierarchy stable and ties the mappings to the S2 domain
shared by the devices.

The dependency stack is based on linux-iommu/next at 634706fe6e36, with:

- "iommu/riscv: Enable MSI remapping, IOMMU_DMA and VFIO" v6[3].
- Fangyu's "iommu/riscv: Add hardware dirty tracking for second-stage
  domains" RFC v4[4], which also supplies second-stage domain allocation
  and page-table support.

The branch below contains all of the above, this series, and the minimal
KVM IRQ-bypass client:

  https://github.com/jones-drew/linux/commits/riscv/iommu-irqbypass-rfc-v3-kvm/

Testing requires userspace to select a second-stage domain, for example
by allocating an iommufd HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT. The
corresponding kvmtool branch is available here:

  https://github.com/jones-drew/kvmtool/commits/iommufd-nested-rfc-v1/

LLM-based coding assistants were used during development for code
exploration, patch review, test execution, and drafting and editing
commit messages and this cover letter. I reviewed and finalized all
resulting code and text. Per-patch Assisted-by tags are omitted in
light of the ongoing discussion about simplifying coding-assistant
attribution.

Thanks,
drew

[1] https://lore.kernel.org/all/20250920203851.2205115-20-ajones@ventanamicro.com/
[2] https://lore.kernel.org/all/20260820214150.545737-3-andrew.jones@oss.qualcomm.com/
[3] https://lore.kernel.org/all/20260925151659.419512-1-andrew.jones@oss.qualcomm.com/
[4] https://lore.kernel.org/all/20260915032828.11250-1-fangyu.yu@linux.alibaba.com/

Andrew Jones (14):
  iommu/riscv: Allocate MSI tables for second-stage domains
  iommu/riscv: Prepare domain bonds for outer locking
  iommu/riscv: Serialize MSI table publication with domain attachment
  iommu/riscv: Reject live S2 replacement with forwarded IRQs
  iommu/riscv: Derive the IOMMU from the device in IODIR updates
  iommu/riscv: Cache the programmed device context
  iommu/riscv: Prepare MSI table updates for interrupt remapping
  irqchip/riscv-imsic: Define IOMMU IRQ bypass protocol
  genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
  iommu/riscv: Add IRQ domain for interrupt remapping
  iommu/riscv: Prepare info->domain for concurrent RCU access
  iommu/riscv: Prepare interrupt remapping for IRQ bypass
  iommu/riscv: Validate IRQ forwarding requests
  iommu/riscv: Implement IRQ forwarding

 drivers/iommu/riscv/Makefile            |   1 +
 drivers/iommu/riscv/iommu-bits.h        |  27 ++
 drivers/iommu/riscv/iommu-ir.c          | 505 ++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c             | 352 +++++++++++++++--
 drivers/iommu/riscv/iommu.h             |  56 +++
 drivers/irqchip/irq-msi-lib.c           |   8 +-
 drivers/irqchip/irq-riscv-imsic-state.c |   6 +
 include/linux/irqchip/riscv-imsic.h     |  60 +++
 include/linux/irqdomain_defs.h          |   1 +
 9 files changed, 974 insertions(+), 42 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-ir.c

-- 
2.43.0
