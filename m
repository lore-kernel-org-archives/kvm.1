Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DB43822BB
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868192; cv=none; b=p2RPuJh9i4G5dEYvHBALu8DJkAcg0nr383I0n79TnaZZ4mGbRTGUkKDFgsZILpkF+deQ31M/k8c70VyNAKLsQlB6gDlSkTmtj0NsS6mnU7U52k44X2VrXrjhHOqMgccfJnizqhBPs4aUy/FQSsas37dkOL38OUdvXwOs75aSXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868192; c=relaxed/simple;
	bh=eg4zLM8j/VfSs0vkSwoCFpUQCcES7ORgnNUbqgqybts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=opRQZ7Dtu602Jg1YuA6ERsD25bPsjhuFkFjVUa3nkCZvWADfwgKQs57tyOc8jxRCpHtaI7x31lMHF+DDa3FiJrszGnED80/MrIHtfENiQcRoyb8EZC7g0/LQBk+tD4cHEGvE/pAl2R8p0AgX9MTvryBKa5G0hfUs1vTofDK3IeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=anenTvb2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="anenTvb2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FmEIC3600817;
	Tue, 4 Aug 2026 18:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LS4Ntbe6O1u2w3+s7ZO0YTOey+XzrpOJYXqGd+14g
	nI=; b=anenTvb2ESWKUKCee+9RY9ZcdhD1yWuASJXGUYd9B1HekmHaWcuV5GfAA
	6fDeMxopoulQTNM6+ynMdtrhP4p61BLJC7P7f2JyDPEozxX+4Vbf1cS0p/V3xH8i
	2m1WrC80bJ+GeDA1Qw7zfj4xNaKsIcxfsbKjJQnM5WHXmymtC1MuRaLEXcYNhIJ6
	tXPoHYD7Kg1O/mceEQ0TdOSG2P3szXOyyzvhf8wnxm5BU+c3sw/h/qrQIosiMUuV
	iLi4OvVa7Mb1GmGYnzQhwEZNLO5ju0y3XnV2k73+Ds5iEzY3Wxbu4VUGEKy4HmkX
	sZ62k3A7B6xwnH5zND8tzOTFxD57A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqqav8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:29:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674IQFEn010370;
	Tue, 4 Aug 2026 18:29:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyk0f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:29:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674ITX0J17433006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 18:29:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C6CD2004B;
	Tue,  4 Aug 2026 18:29:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C12B020043;
	Tue,  4 Aug 2026 18:29:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.28.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 18:29:30 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gautam Menghani <gautam@linux.ibm.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: [PATCH v5 0/3] ppc/kvm: Handle CPU compatibility mode correctly for nested guests
Date: Tue,  4 Aug 2026 23:59:11 +0530
Message-ID: <20260804182914.83091-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-GUID: -e33zt2mtJ6Pi62G1bq1SgE-Rl-OO2Op
X-Proofpoint-ORIG-GUID: Rc4L_TGfokDbS5XNv-KcGLABCwnMuwol
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfX45yZcTmzUu6l
 JhI6YRr3oT8IOZAOj3c/252zQHpO82iRMgcQG68zQF4Kn9Ln7f2UPGLxxZZURWq3rK1X0CDpM7x
 ba32swIsyvpS1z+d9nGnsr63G1QEMLI=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a722f92 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=2eESetWJmRnmctodxWgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfXxHMQoYPXpygZ
 U3af0SXOeHdorp6yQ2dEasKzgtzYcXN4K68GqykffaZgj44hdXnQAdzSTYbz6zAj/sKb84cSjbO
 QWcdycpiLg+ZB7krBasK47iVQz1uCw85NR0nUlNKUNC/Epz+Oz0fDYcddFsIbVJNKCy9PsqzNqr
 TyySV1/krOVhHc3go0aX7AJ8oaZkOND62MfmqDar3VZIe7Sav+miCYxh2ppi3dv9Gm0QLlt3/rh
 52HXAwYVKrE3GbufJUyGA4vHR8feE3SJqM4qjqac5REvTIjXx+wy+ywvI1GqNi6uwbIQcekDJml
 ga573xfQPknWx8Mn9Lfco0xsX77DWqPtq6OFJNsJoU4fluDWbm4F7OIFFS2AFYoScAZ1vX7z8Z4
 hlV2IcZbY8/uC93mIplqyLUyPGH1aVn1GfrK+0dl4DN3ruC+sSBn261JfxxjjZGzV3df+u129+e
 yyPbyK6LKHHgyBtTy0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040148

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

Changes in v5:
  - Patch 1: Updated KVM_PPC_GET_COMPAT_CAPS ioctl number from 0xe4 to
    0xb8 to match the corresponding Linux kernel v6 series change; the
    0xe0-0xe3 range is reserved for KVM_CREATE_DEVICE fd ioctls

Testing (with kernel v6 patches):

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

Note: Patch 1 is marked DO_NOT_MERGE as it contains linux-headers updates
that will be synced separately once the corresponding kernel patches are
merged.

The corresponding Linux kernel patches (v6) are being posted concurrently.

v4: https://lore.kernel.org/all/20260701052341.62289-1-amachhiw@linux.ibm.com/
v3: https://lore.kernel.org/all/20260616113915.25589-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/all/20260430061333.37905-1-amachhiw@linux.ibm.com/

Previous kernel patch versions:
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
 linux-headers/asm-powerpc/kvm.h | 19 +++++++
 linux-headers/linux/kvm.h       |  3 ++
 target/ppc/kvm.c                | 87 +++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h            |  7 +++
 5 files changed, 130 insertions(+)


base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80
-- 
2.50.1 (Apple Git-155)

