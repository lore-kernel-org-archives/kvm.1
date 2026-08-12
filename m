Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7943744C64B
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554574; cv=none; b=IvR+gPmhOOQcJUp81uofxJ+dCrKfLe77uAxdzg2mYHdQaOElDCLY5hYpf3dv0cw3dDiNYC/iSHeVKIwiJ0Cqgaytu1Me7Q5eYD92PDOAgZBdO+FMNJ22mwjcjb4klaEuWrW5vuT2LbGrL7OkRc9BAHJ993laUZco1X9w1syFELo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554574; c=relaxed/simple;
	bh=u28/2iu+TZiJy5QLfzr47do+lsVLxYiY2IYqsYYge5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cwo4jh4T4h+j3ZAGx6WQpE1mHzwOaQm5WPGoEM67zVX17Q9eO/8lcSl6EJlWUqjkohqBwikKGRi2doz6wNiI8fDvRu+IeMxh0Ov+0u9/rfzDwG/0wqz0k5GR3xoI2wAeQ0DWjz62O6ivLXoCyA5m7wyJtsyUtT2Zp+J2WP+NXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cSQJoJb3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cSQJoJb3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1bmH3994408;
	Wed, 12 Aug 2026 17:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bDjdvjh6Uy0TA9n9krj/qzBdKdW3PaklSf2x3C4Il
	nM=; b=cSQJoJb35ChUH9RblXFxb9/zsh46U+a+T7AuiLNHF6asM8nDp+Cw2qXW7
	wE52Alc1/UKteaAOnC4bKdBdRYIB4LkVp83vtwxf89fxsXLYCYQR3VLvaXvlrheq
	IiMIZYvJmd/hHzWqNPG3ZFzGyxcSeRnQcO1oNk7onxFLcDrlbcIn2HNk0UKW3FCy
	QJIo+J2IGGDoN5Y+LyB9ca+wxK8Sk72ooyFhmZtBWBCHhlM8xwzE9wB4Z2dOKngZ
	5WPtA7VrwCf5zLamJoy/mTpme/Zh0280puJ/w8VfDylLdq1n1W1mBOQ5lELeP3f1
	e8jX+YCQ3HHM9UqePVXl1G9AdYD+Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp32ubp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGutEl031265;
	Wed, 12 Aug 2026 17:09:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h71b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CH99pW43647370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 17:09:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A88D2004F;
	Wed, 12 Aug 2026 17:09:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DB4420043;
	Wed, 12 Aug 2026 17:09:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.26.117])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 17:09:05 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gautam Menghani <gautam@linux.ibm.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: [PATCH v6 0/3] ppc/kvm: Handle CPU compatibility mode correctly for nested guests
Date: Wed, 12 Aug 2026 22:38:51 +0530
Message-ID: <20260812170854.58709-1-amachhiw@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7ca8ba cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=2eESetWJmRnmctodxWgA:9
X-Proofpoint-GUID: PRvUNZ0LNyyzvHdkxtrWP5tOpGZ5mVG7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXxiD9V4+e8VmF
 ybfMYK9iiBJD9AGDn1iRZj4mcbbULHq3jPERwPDLEbc14Pahf3PX/TeIaDuxFRcS1BmjBunE6hg
 hG38dPmm3qe+SO+8iHR899Ac4shz+aB7aKnS4yfGJI+N+Fpy0H3JTEAGNZDs8MrypkW7SdfU9v0
 yS8XEnvXBYRdPFb5erezo8jCp0Oh2TvFadS+23N+1u19rG29m50yfP2I3jTwAapsWwm2bpUCRm4
 7ndWOh561oKqks6Con1pvL+Zckpy9o20+iET0/yOBtFaeNTb3mjbJc+u9qRZaMf7EB8MUE5F8XS
 3SM0KFDappaHuLSqWrmWf0vlS8ohZbkNZYm9QhTYz+L77t72vOoV6s06pZyXW3AqUZ9zhrG2Ros
 oH9/8mbXvD8I/Pm0QXhkiOHSoK3iS+a+XibA/TcgEjRHj+XOUO68BGUw+rjZCvjzPYwLF05Nxw/
 Xyg8YRakvkoOJbTPdQA==
X-Proofpoint-ORIG-GUID: 2yRRuWiwwy3sEoJGCA08XHKU9WDIZrSl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXy6D3UVnLLEOD
 mzCw2thcluGYihPoixbEKVew+gCGmI4HYhAlOIAD26h2CUwrDx/DHmMaHYbHcwgh5HbspYqymLw
 WPSSruhxTyqqLqyO4j9QytZvtd82Fco=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120138

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

Changes in v6:
  - Patch 3: Drop redundant #ifndef CONFIG_KVM / #error guard; kvm.c is
    only compiled when CONFIG_KVM is set (enforced by meson.build), so
    the check can never fire [BALATON]

Testing (with kernel v9 patches):

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

Note:
1. Patch 1 is marked DO_NOT_MERGE as it contains linux-headers updates that
   will be synced separately via scripts/update-linux-headers.sh once the
   kernel changes are merged upstream.
2. The corresponding Linux kernel patches (v9) have been accepted into the
   ppc/next branch and will be included in the next pull request.

v5: https://lore.kernel.org/all/20260804182914.83091-1-amachhiw@linux.ibm.com/
v4: https://lore.kernel.org/all/20260701052341.62289-1-amachhiw@linux.ibm.com/
v3: https://lore.kernel.org/all/20260616113915.25589-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/all/20260430061333.37905-1-amachhiw@linux.ibm.com/

Previous kernel patch versions:
v9: https://lore.kernel.org/all/20260808161148.66673-1-amachhiw@linux.ibm.com/
v8: https://lore.kernel.org/all/20260807172433.82045-1-amachhiw@linux.ibm.com/
v7: https://lore.kernel.org/all/20260806170645.11892-1-amachhiw@linux.ibm.com/
v6: https://lore.kernel.org/all/20260804180705.59160-1-amachhiw@linux.ibm.com/
v5: https://lore.kernel.org/all/20260701051409.51820-1-amachhiw@linux.ibm.com/
v4: https://lore.kernel.org/all/20260616123314.82721-1-amachhiw@linux.ibm.com/
v3: https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/all/20260513100755.83195-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/all/20260430054906.94401-1-amachhiw@linux.ibm.com/

Amit Machhiwal (3):
  [DO_NOT_MERGE] linux-headers: Add uapi header changes
  target/ppc/kvm: Add support for querying host compatibility mode
  target/ppc/kvm: Use host compatibility mode for nested guests

 hw/ppc/spapr_hcall.c            | 14 ++++++
 linux-headers/asm-powerpc/kvm.h | 19 ++++++++
 linux-headers/linux/kvm.h       |  3 ++
 target/ppc/kvm.c                | 84 +++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h            |  7 +++
 5 files changed, 127 insertions(+)


base-commit: e8d693e12af9cbb89d724baadfcc08559669e279
-- 
2.50.1 (Apple Git-155)

