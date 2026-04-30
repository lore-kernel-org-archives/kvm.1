Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D2184;
	Thu, 30 Apr 2026 05:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528226; cv=none; b=L9h/xrB/wJEXaJr9xE9DlB53CfdwscMmliJmSHzQdbpr08uMPVCNvb1wOElyAYWZtq3pOq6zkOdMm38VIGUpKSHykGquW1QSAw9aJ3I0gbi9KKvqAsTMIWNDNSU9EqwnFOS7pSc+gPXzHw3j//HR1WBa7soeWQfFVq/VXDPug3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528226; c=relaxed/simple;
	bh=QYZk6ei2b3p8RfGHhL0DRkUCY/CVqZesAUlbclCooP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pd67HjE2XCZWeLy95AYPx6L9SxN1WyzKicmUKVnQKvxcKUSsurl7j+3cWayKp2LpFva2HXYIczzI2Los4RrPo/b1BFK1vRJeBLSJFm4Li0UDSmBetZChjDH9hNM6i1vGA2B29P7HQsH4IcYAlYFlHkVNhyZp8oKGinQPuV9rm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tKmJiRIA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tKmJiRIA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U2GAIM523254;
	Thu, 30 Apr 2026 05:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=owmjtlgxhZ3jXS8yeS0VEKzCSvww3herCYfHShTAw
	ek=; b=tKmJiRIAG++6kfz+3rWOH4zvoOpcoa+62w5t+NkKf/1RkRTDQIYVgCnio
	6SdPHueyJ6WIifbvuwCN6zKJ29GMX9u2duUO1/rnhTY/SSVUK8Qmt4zSwaIzAV+U
	wVUBCKfCzzqyfSBg9/RrNLjhj+/QjpjlIMEIUEL44vp0MhstR5P/Xx4/kRIp8HUm
	eawQmgJNBpDrvfWEQSWxlILWjTC9OF0GkKpe6yykWNhYFDClUM/mP5l1eSZlZkEL
	zOZ7OZ1FfiN1EGBCpXjqcw2Szrz2cuJcqqaXIiR+8wAnLsGFOTHyxFil+9zSePYz
	dLZCtJ5pGUI0aofzi6II0Oohq9A+A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9re2k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U5cqj1025955;
	Thu, 30 Apr 2026 05:49:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw1nkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:49:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U5ntwo60162342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 05:49:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B82A220043;
	Thu, 30 Apr 2026 05:49:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 997BB20040;
	Thu, 30 Apr 2026 05:49:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.70])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 05:49:51 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 0/6] KVM: PPC: Handle CPU compatibility mode for nested guests
Date: Thu, 30 Apr 2026 11:18:59 +0530
Message-ID: <20260430054906.94431-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-GUID: d8zTUNCndk9tKeMj84mKiUdjekEBvPX-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfX/WAG8EUC84l0
 A9VTSw5dIXDmEZ4CLB++1VwdIxbLl+GTiUI4Lp2g8eh+oeYI7GJRoTkaZvtyOZZ3VAMRUpDhXNt
 2cBQNgPca0eB/5H/hTx31ZiInFZisSXO+4/XOs4ptXEmPIdbmO6UbN8vXsEMb6XaeYM49sfNMmo
 9iuHUDx1meJNnX1uOLGOs8Fc/llEN7/6qSmv6bqzgjlEX541r134jIRwX3MJ/e9TQXS9H+eigQu
 6oxU56qeH7ZGsEQmW7eKHxWTloVk/+vSPOAIXOy/VWUEZiuCneiSDCcMaHbzNQk2Pfq+brAicJY
 pYzrzRdMyri1pp+7sMrY+hy5gpTzlJzqVo/XiLuThModhY2kX4w2fiYk5kkecCKktogH2W5vRFi
 5tJ49WsGkckfiWxT13at1Wm5sIz5WGrLLXKjagxeWwKlgiAkQIA5n82lrHYKbvuOiOc0KElJD7C
 NZsFF8HE070haL0Y1sQ==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f2ed89 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=3pgwaEq9XIEntMmap7EA:9
X-Proofpoint-ORIG-GUID: pQubjeeb4m7Z2BXmodPYaTsTe5eVKfs2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300055

On POWER systems, newer processor generations can operate in compatibility
modes corresponding to earlier generations (e.g., a Power11 system running
in Power10 compatibility mode). In such cases, the effective CPU level
exposed to guests differs from the physical processor generation.

This creates a problem for nested virtualization. When booting a nested KVM
guest (L2) inside a host KVM guest (L1) running in a compatibility mode,
userspace (e.g., QEMU) may derive the CPU model from the raw hardware PVR
and attempt to configure the nested guest accordingly. However, the L1
partition is constrained by the compatibility level negotiated with the
hypervisor (L0), and requests exceeding that level are rejected, leading to
guest boot failures such as:

  KVM-NESTEDv2: couldn't set guest wide elements

This series addresses the issue in two steps:

1. Detect and reject invalid compatibility requests early in KVM to avoid
   late failures.

2. Provide a mechanism for userspace to query the effective CPU
   compatibility modes supported by the host, so it can select an
   appropriate CPU model for nested guests.

To achieve this, the series introduces a new KVM capability and ioctl
(KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
compatibility modes supported by the host.

The implementation supports both:

  - PowerVM (nested API v2), where compatibility information is obtained
    via the H_GUEST_GET_CAPABILITIES hypercall.
  - PowerNV (nested API v1), where compatibility is derived from the device
    tree ("cpu-version") representing the effective processor compatibility
    level.

This allows userspace (e.g., QEMU) to select a CPU model consistent with
the host compatibility mode, avoiding mismatches and enabling successful
nested guest boot.

Patch summary:
  [1/6] Validate arch_compat against host compatibility mode
  [2/6] Introduce KVM_CAP_PPC_COMPAT_CAPS and ioctl
  [3/6] Wire up ioctl handling
  [4/6] Implement capability retrieval for PowerVM (API v2)
  [5/6] Add PowerNV support (API v1)
  [6/6] Document the new ioctl

Tested on:
  - Power11 pSeries LPAR in Power10 compatibility mode (nested API v2)
  - Power10 PowerNV system (and QEMU TCG PowerNV 11) with nested
    virtualization (API v1) with various combinations of KVM L1/L2 guests
    in various supported compatibility modes.

With this series, nested guests boot successfully in configurations where
they previously failed due to compatibility mismatches.

Amit Machhiwal (6):
  KVM: PPC: Book3S HV: Validate arch_compat against host compatibility
    mode
  KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
    KVM_PPC_GET_COMPAT_CAPS
  KVM: PPC: Wire up KVM_PPC_GET_COMPAT_CAPS ioctl
  KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM
    on PowerVM
  KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM
    on PowerNV
  KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl

 Documentation/virt/kvm/api.rst      | 35 +++++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h |  6 +++
 arch/powerpc/kvm/book3s_hv.c        | 58 +++++++++++++++++++++++++++++
 arch/powerpc/kvm/powerpc.c          | 19 ++++++++++
 include/uapi/linux/kvm.h            |  4 ++
 6 files changed, 123 insertions(+)


base-commit: dca922e019dd758b4c1b4bec8f1d509efddeaab4
--
2.50.1

