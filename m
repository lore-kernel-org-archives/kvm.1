Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC92285CAE
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782883447; cv=none; b=GbY6ePDtpEtk2ox0EabN/b8xFAzn6sFv1lruMbwflEOu0JNV2DQlff97lmGANEmoiEMMs94+FKQnZ0rgVCfDnctanjVZaU5BN22HIxvF0FV6ro1Nf9Pcmqt7d/Bea7aLFIXfyKHV+DL53LiUnjy9XSEaOF0grMZtisiWg+E7uzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782883447; c=relaxed/simple;
	bh=5gURt5aGar6s9kkwzPjtTkR7Nkw8Zok9ODZk3HwHRP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJn3akZNz3uGf5QD9D+Aj35y6Q5l8wT30xwUMMJG51gJN9dtKhSa0Cr0qyuaq3jqDBnsPFoq2X1gF6/887MD05sE54Ql/QrooQGwIEvDhaK+mgoFl5LaWzuXaXDdKD72t/1zgTMEtetfhHdapXH3/H3Pk4NQysVgAzNNwKTCiRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BC4Le5Nl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BC4Le5Nl"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6613IOf23867500;
	Wed, 1 Jul 2026 05:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rw4Re/OX7p6AOLreA1pkC3CiRIGKZikeQoJz2Rx9W
	Ik=; b=BC4Le5NlHilo6Q/kOX5WvSP5WFcKc+EAi7k1SSmarcFv8Wj+dEOCqxr31
	xWDN+p3sm4tjiIlpeHXNsRbOPpHnF4wb7OxaYdjtgNiwWbn0z8gRLKDakf4Ye+70
	bmmDXajvNg3sb4Tu9fD4BzgMuZbxfx1IsvIPPw4mjhL3lGO3+cjKB0dLHY132fkj
	dvcsCAWZqGf7QQ2lxzktzD1G6UaWwYAhptz3NUTIeRNbNNlHUiaFNdmk7N3gnFca
	3q2UFcjaJZW4dL9+ySCsLHP+bxLjM8hW3xmssfOVEdOVCa+7/EEYcltpTgmjDVrY
	1vWnod9SaX7x6UCfohVDtEIK7OxeA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5tp6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:23:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6615JkL1015845;
	Wed, 1 Jul 2026 05:23:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w5uxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:23:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6615NsrB49742144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 05:23:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D0182004B;
	Wed,  1 Jul 2026 05:23:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6261620040;
	Wed,  1 Jul 2026 05:23:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.211.190])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 05:23:51 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: [PATCH v4 0/3] ppc/kvm: Handle CPU compatibility mode correctly for nested guests
Date: Wed,  1 Jul 2026 10:53:38 +0530
Message-ID: <20260701052341.62289-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA1MiBTYWx0ZWRfX8IOzqTeHMsuu
 hlWrbfYpQlF4O4smVnizOLZXNUPZolRhDRNoAkuPoqggOghwMJIksbd2Xm94NVugEkqZ0ub0GE7
 07b3iVJEW+kOGc8l8WM9ANE09rzVKqIG+v/xEoQNDdFtGWzLp3h79ctcARccvY2R9sQ1QcV+k3S
 OMYoOAshSBv5UztEE54u+aQ3zb3F2KUY60L422yEhUte3ad52YPyzZQU1aqTshSM2VdOHSOkMy6
 TYl4Yan5imGprjjeBUUNZ4uBXgdfuFBLmdoBjP9KKe0fmCAYKoOQLQrTUD45HYrHMGFSjhzko4E
 sYJC9yekVtCwlbVZxJhabhkOz0bEgZDyLfmH3uJQ6AXkFCiu7exl4k7GpXKp6GuSEM73c53BM81
 bqjEI3/Ahgv/7OWjv971NFgXCsOiyI42oJaBPkDrWzwQEPw/JmDiuk2Unmus4asQlbaPQSfX8gp
 rVPpKgC9SvBsfkXFdgQ==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a44a46f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=iyjcYo-jlGdn1xPYdsIA:9
X-Proofpoint-ORIG-GUID: VX4viZWmcoAeugSujkuAynLg2T9B8E7t
X-Proofpoint-GUID: UWMcDBcjiMvJyckQeG4p5Y1G-A-urBrG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA1MiBTYWx0ZWRfX4aoc8pfjTQI7
 kQidvBQNS31Zv+TNRsiyjdzSsCpRoTaGgawQGNlEKjsHX4NkpiZl497IsdjRRp8xfEw384r0F+6
 fTIVhK9q1tIEbPt/bFi17hd++WWpDh8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010052

On POWER systems, newer processor generations can operate in compatibility
modes corresponding to earlier generations (e.g., a Power11 system running
in Power10 compatibility mode). In such cases, the effective CPU level
exposed to guests differs from the physical processor generation.

This creates issues for nested virtualization. When booting a nested KVM
guest, QEMU may derive the CPU model from the raw hardware PVR and attempt
to configure the guest accordingly. However, the host is constrained by the
compatibility level negotiated with the hypervisor, and requests exceeding
that level are rejected by KVM, leading to guest boot failures such as:

  KVM-NESTEDv2: couldn't set guest wide elements

This series addresses the issue by preventing fallback to raw mode when the
host itself is booted in a compatibility mode, and by querying the effective
CPU compatibility modes supported by the host via KVM. The kernel interface
uses copy_struct_from/to_user() for forward and backward ABI compatibility.
With these changes, QEMU ensures that nested guests are configured with CPU
models consistent with the host compatibility mode, allowing them to boot
correctly.

Patch summary:
  [1/3] [DO_NOT_MERGE] linux-headers: Add uapi header changes
  [2/3] target/ppc/kvm: Add support for querying host compatibility mode
  [3/3] target/ppc/kvm: Use host compatibility mode for nested guests

Changes in v4 (based on review from Vaibhav):
- Patch 1: Updated to match kernel v5: ioctl kept as _IO (not _IOWR) so
  the ioctl number remains stable if the struct grows; the size field is
  read first by the kernel via get_user() before copy_struct_from_user().
  [Vaibhav, Amit]

- Patch 2: Replaced fprintf(stderr, ...) with error_report() for error
  reporting in kvmppc_get_compat_caps(). Replaced __builtin_ctzll() with
  portable ctz64(). Simplified kvm_ppc_host_compat_pvr() to switch directly
  on the capability bit value instead of a derived index, removing the
  KVM_PPC_COMPAT_CAP_P*_IDX defines from kvm_ppc.h. Dropped the post-ioctl
  size mismatch check which is no longer meaningful with the
  copy_struct_from/to_user() model. Added a function comment to
  kvm_ppc_host_compat_pvr(). [Vaibhav, Amit]
  Guard the kvm_ppc_host_compat_pvr() call in cas_check_pvr() with
  kvm_enabled() to prevent a segfault when QEMU is built with CONFIG_KVM=y
  but run as a TCG guest (kvm_state is NULL in that case).

- Patch 3: Added a #ifndef CONFIG_KVM compile-time assertion inside the
  TARGET_PPC64 guard as a sanity check. No functional changes.

Changes in v3 (based on review from Vaibhav):
- Patch 1: Moved compatibility mode check from do_client_architecture_support()
  to cas_check_pvr(). Instead of error handling when KVM rejects compat mode,
  now prevents raw mode fallback when host is booted in compatibility mode.
  This ensures guests cannot exceed the host's compatibility level.

- Patch 2: Added size field to kvm_ppc_compat_caps structure for ABI
  versioning. Changed flags field from __u32 to __u64. Added capability bit
  definitions (KVM_PPC_COMPAT_CAP_POWER9/10/11) and KVM_PPC_COMPAT_BITMASK.

- Patch 3: Added size field initialization and validation in
  kvmppc_get_compat_caps() to ensure ABI compatibility between QEMU and
  kernel. Changed from H_GUEST_CAP_* constants to KVM_PPC_COMPAT_CAP_*
  constants. Added capability masking with KVM_PPC_COMPAT_BITMASK.

- Dropped Tested-by from Anushree due to code changes in v3.

Changes in v2:
- Patch 3: Guard compatibility mode code with #if defined(TARGET_PPC64)
  to fix compilation for ppc32 targets. The POWER9/10/11 PVR constants
  are only defined for 64-bit builds, and compatibility modes are only
  relevant for 64-bit systems.

Testing (with kernel v5 patches):

KVM APIv1 Testing
=================
  On P10 PowerNV machine (L0)
  ---------------------------
    - P10 L1 KVM guest -> works
      - P10 nested L2 KVM guest -> works
      - P9 compat nested L2 KVM guest -> works
    - P9 compat L1 KVM guest -> works
      - P9 nested L2 KVM guest -> works

  On Powernv11 TCG Guest (L0)
  ---------------------------
    - P11 PowerNV TCG L0 guest -> works
    - P11 L1 KVM guest -> works
      - P11 L2 KVM guest -> works
    - P10 compat L1 KVM guest -> works
      - P10 L2 KVM guest -> works
    - P9  compat L1 KVM guest -> works
      - P9 L2 KVM guest -> works

KVM APIv2 Testing
=================
  On P11 PowerVM LPAR (L1)
  ------------------------
    - P11 L2 KVM guest -> works
    - P10 compat L2 KVM guest -> works
    - P9 compat L2 KVM guest fails to boot as expected
    - Without QEMU patches but Linux patches
      - P11 L2 KVM guest -> works
      - P10 compat L2 KVM guest -> works
      - P9 compat L2 KVM guest fails to boot as expected
    - Without Linux patches but QEMU patches
      - P11 L2 KVM guest -> works
      - P10 compat L2 KVM guest -> works

  On P11 LPAR in P10 compat (L1)
  ------------------------------
    - P10 (host compat) L2 KVM guest -> works
    - Without QEMU patch but Linux patches
      - P10 guest fails to boot as expected (error: kvm run failed Invalid argument)
    - Without Linux patch but QEMU patches
      - P10 guest fails to boot as expected (KVM: unknown exit, hardware reason ffffffffffffffea)

  On P10 PowerVM LPAR (L1)
  ------------------------
    - P10 L2 KVM guest -> works
    - P9 compat L2 KVM guest fails to boot as expected

TCG pSeries Guest
=================
    - P11 (default) pSeries guest boots fine

ABI Extensibility Testing (struct size 32, extra member)
=========================================================
    - Newer struct on QEMU, older kernel -> works (kernel returns -E2BIG,
      QEMU retries with correct size)
    - New struct on Linux kernel, older QEMU -> works (kernel zero-pads
      trailing fields, QEMU gets correct data)

CI test results: https://gitlab.com/amachhiw/qemu/-/pipelines/2641423050

Note: Patch 1 is marked DO_NOT_MERGE as it contains linux-headers updates
that will be synced separately once the corresponding kernel patches are
merged.

The corresponding Linux kernel patches (v5) are being posted concurrently.

v3: https://lore.kernel.org/all/20260616113915.25589-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/all/20260430061333.37905-1-amachhiw@linux.ibm.com/

Previous kernel patch versions:
v5: https://lore.kernel.org/all/20260701051409.51820-1-amachhiw@linux.ibm.com/
v4: https://lore.kernel.org/all/20260616123314.82721-1-amachhiw@linux.ibm.com/
v3: https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/all/20260513100755.83195-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/all/20260430054906.94401-1-amachhiw@linux.ibm.com/

Amit Machhiwal (3):
  linux-headers: Add uapi header changes
  target/ppc/kvm: Add support for querying host compatibility mode
  target/ppc/kvm: Use host compatibility mode for nested guests

 hw/ppc/spapr_hcall.c            | 14 ++++++
 linux-headers/asm-powerpc/kvm.h | 20 ++++++++
 linux-headers/linux/kvm.h       |  4 ++
 target/ppc/kvm.c                | 87 +++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h            |  7 +++
 5 files changed, 132 insertions(+)


base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
-- 
2.50.1 (Apple Git-155)

