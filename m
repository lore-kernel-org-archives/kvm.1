Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76BC184;
	Thu, 30 Apr 2026 05:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528256; cv=none; b=eW3sda7wNkZ45mkqpNyyfDotkW3xLCtZUxDS27FTFsNnSbvoXK7AaKRlTX2JI4PoBxjLD6RNKNNmLNY5YVXW8geYUz86rZ+oR6iZ+fFlsPoEIqmBT8C8oNYp4YCqEdR8vqjEk4MJBApM+p8twb7ziBXdQyDsID+2i6md2Oy2o+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528256; c=relaxed/simple;
	bh=aujlOtU2N/6iCPPHtsTBon27sXSbLXCHgZkMMbIcPlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isJcnVKCNBMvzvjHfHGzTMl1uF0ZQ93oJbni6dj3W1JcmRiVAzvlmuXfylMPPhAYoyU4XyV5aBG2S76X3gFyYJPgNKc+DN0g924OdoZMGviDSODGJTM1e95hEP6++gGegQd83IcSEZ+OKPit0uj1vUC7XHu8hAVumTaenveivgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cx5io097; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cx5io097"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNPjfX3102032;
	Thu, 30 Apr 2026 05:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BhEenOdIb0zci+cfo
	D2CfrCg7b4bPrp2JC0oafympkM=; b=Cx5io0976BUxCqiqvdVFimnjVYME7bxy1
	EzM35Che9djq69jvITsug3m2/dNosTl3VIK78WMj5ptPPvDRZUKS8WHPxJH23WpL
	7qyvtmQva52tJ0WIIQS9RN/SCMe8tNqNEcVddzXQ6S75ZaJEUApZSALZHcZcKW7a
	SXhISXzP4vfBtLdB95xsqjqXnRbOsubCbnt2cBbRXDijK906/PztBL1ZbXaP/nyO
	4fwi7QSewl4DGsXNyFlOYzwOTbiC6z5DbVsFgb9wHRDDZKMNpmuKQWf/YxCeV2H0
	RsOc+2Nobjek28qSMkeiCyIEBGXDS1sAy9t/S0rmxjQiDgP4pBy1Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44x703-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U5cq0A010295;
	Thu, 30 Apr 2026 05:50:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyhbhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U5oeps52035998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 05:50:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6340B20040;
	Thu, 30 Apr 2026 05:50:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 267F720043;
	Thu, 30 Apr 2026 05:50:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.70])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 05:50:36 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM
Date: Thu, 30 Apr 2026 11:19:03 +0530
Message-ID: <20260430054906.94431-5-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260430054906.94431-1-amachhiw@linux.ibm.com>
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: fNuj-0nRG1olPKrXOSyc2CDSXB1z5DsD
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f2edb5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=lI54la875Hh5wgzWY30A:9
X-Proofpoint-GUID: Bf398W9isCBf2MLnAisWhCddQxZ6KQc7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfXwgPs3Mzn4hHv
 4Qban/7Ju94/giip/gc7xpq1kvGk1I3cilRfUUeLIr8pvZRUhms5E5XdvNDdkxPkrk+zu3mgC4z
 /0jp/7XXQ8cXGvwMoDU1nUZxgXBKDsAzJwbKH0Wx6cb47tM7unZvOJFPIxn7VnHrh2lhmzuWxys
 GpQCIH/k1R85ufNU66y3FfCsRpkEKNgylZgq+oWDVExmi8vRTmZ9PjZl8jnDzuwco6VYV4TCx+2
 Njw4sZ2kBAn74yOZEOTCiXTKJymCeMmGObrFe1aU4ia6R5jawHlYDSuJFYhJIYQrJ3rNPnmVbrE
 hCophTfjQB720rVmNnmsl3doPzKXi2M+owKDVBJNFshE1FG9AgaCOIOUAsVNZp2wTCO4tWvRtte
 ZkFqd47njVQxTqKPbXztXbAREL0fVYA5R+5EsR9kP/90gV+JdYUG1TuLdOwnUWVazh71jj1nQlx
 s3GwQ4iKKPhFXsGmCsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300055

On POWER systems, the host CPU may run in a compatibility mode (e.g., a
Power11 processor operating in Power10 compatibility mode). In such
cases, the effective CPU level exposed to guests differs from the
physical processor generation.

When running nested KVM guests, QEMU derives the host CPU type using
mfpvr(), which reflects the physical processor version. This can result
in a mismatch between the CPU model selected by QEMU and the
compatibility mode enforced by the host, leading to guest boot failures.

For example, booting a nested guest on a Power11 LPAR configured in
Power10 compatibility mode fails with:

  KVM-NESTEDv2: couldn't set guest wide elements
  [..KVM reg dump..]

This occurs because QEMU selects a CPU model corresponding to the
physical processor (via mfpvr()), while the host operates in a lower
compatibility mode. As a result, KVM rejects the requested compatibility
level during guest initialization.

Add support for retrieving host CPU compatibility capabilities for
nested guests on PowerVM (PAPR nested API v2). The hypervisor provides
the effective compatibility levels via the H_GUEST_GET_CAPABILITIES
hcall, which reflects the processor modes negotiated between the Power
hypervisor (L0) and the host partition (L1).

On pseries systems, obtain the capability bitmap using
plpar_guest_get_capabilities() and return it via struct
kvm_ppc_compat_caps. This information is then exposed to userspace
through the KVM_PPC_GET_COMPAT_CAPS ioctl.

Hook the implementation into the Book3S HV kvmppc_ops so that it can be
invoked by the generic KVM ioctl handling code.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 948c6b099a29..d602d90111d1 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6516,6 +6516,22 @@ static bool kvmppc_hash_v3_possible(void)
 	return true;
 }
 
+
+static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
+{
+
+	unsigned long capabilities = 0;
+	long rc = -EINVAL;
+
+	if (kvmhv_on_pseries()) {
+		if (kvmhv_is_nestedv2())
+			rc = plpar_guest_get_capabilities(0, &capabilities);
+		host_caps->compat_capabilities = capabilities;
+	}
+
+	return rc;
+}
+
 static struct kvmppc_ops kvm_ops_hv = {
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
@@ -6558,6 +6574,7 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.hash_v3_possible = kvmppc_hash_v3_possible,
 	.create_vcpu_debugfs = kvmppc_arch_create_vcpu_debugfs_hv,
 	.create_vm_debugfs = kvmppc_arch_create_vm_debugfs_hv,
+	.get_compat_cpu_ver = kvmppc_get_compat_cpu_caps,
 };
 
 static int kvm_init_subcore_bitmap(void)
-- 
2.50.1

