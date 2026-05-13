Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9E3921E4;
	Wed, 13 May 2026 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666944; cv=none; b=ZLh52Ycvb6vF9r/1CTvXx7e4xxAOhHHFFmafSxSXTkevPTnat1KU0ZH8eCFwy96+yQ0SuOdpwdVzG9gcn031esiYYjfG2FO1ogDnSEVkFSHvzO/38F/4utfkemBUvSDGcWT1e0gjkzG9DbjQ1ccO9vN5V7CkUvwqGOGGcHFIFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666944; c=relaxed/simple;
	bh=IZ2d0mynhllzNrhh3ZrLEKJCb36UcO98QBhwzj23ZeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQXtcITXyhMk1stwVPErq3arBGnYJ0zR/KJsoPPrVHbHZErii1DLBUgATpzODq/LVF1S2Rogk8dXuj3vLXpEqMlVSd7JwcMeP87qocA+kQr3Jrl5LnRUDbud2jVYVH/XZ1R7KoCsqTzRSW/yQu6SiKzFWSZMfgcjU54JbP5v1f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bFQVzXzy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bFQVzXzy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CH0Dc03678855;
	Wed, 13 May 2026 10:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=joVrI7uY5yjtKuPEN
	WybqFccqiCoZbuRt2VIrtKJ/Ss=; b=bFQVzXzyyJR46ABBkN3lhMFmNB3QFIKZ4
	nkx5nU9vBsvoLfBu1gdLtWDY6Drz1FKRP1LPo7WC0+F/lQoST3RO4OI5nzieaKIS
	wUXkCgfluqn4Dtd6hxkB+PEEeSkt4zAGdZUtyLhrALfXwUOtxmm1niLHCtDj4VEY
	7C9uP1+VpiHUaU36199ndl4nooFXDTH0p7EBhBUrrgWNx/wKUvXGuSLLZ/2hyGtV
	VKcBrbOtaA8993aNkr+3NYOAGONdoUizvpmxiYqgt2/tpePUa0ocmyJw4I2uRS/s
	Fi/yWqFrWwMtkVE8hLKF6U0Bjt9ncP+IvVJJesPJbgvIezKWXFgdg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nvdy5st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 10:08:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D9dXBw005872;
	Wed, 13 May 2026 10:08:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgf8mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 10:08:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DA8ewp52035936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 10:08:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9EDD2005A;
	Wed, 13 May 2026 10:08:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FCA52004E;
	Wed, 13 May 2026 10:08:39 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.0.51])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 10:08:38 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM
Date: Wed, 13 May 2026 15:37:52 +0530
Message-ID: <20260513100755.83215-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513100755.83215-1-amachhiw@linux.ibm.com>
References: <20260513100755.83215-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a044dad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=lI54la875Hh5wgzWY30A:9
X-Proofpoint-GUID: whn5_bf2zPMcRbtsCAA92mu5E2BrUYqm
X-Proofpoint-ORIG-GUID: 7Wtuqf8pNosA2WC1Dosc5UVEH8u9k6tW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEwNSBTYWx0ZWRfX1VjU35OYLQhd
 GTxU7natxTqLK8I0aI4HS3A254rCB3KQPAAjgOx9fICZkQewFHAcgE8p9ak/vRI1/AA1dXOBGio
 ymvYG5ffWrfYmWmwybN1PW1M2W5Mkr4bLNVjqRL9BOwtjE0/PSCIyj0Vk1hV1ShNrMLfe3NiE10
 udRJKOp6mCWher1ybFHkxYfNQLJz5lGq+qV7hWMHWzBkJOubFCv2k3Ir6/92rI9p8RGEBUSMgqT
 rT0E8IezGGv3Y6wTIJhLB+t3/Oo1sJm7X1AL4MANv4Q5d5Qb2XBK72eM9p3bnbxmPvTW4by9cNC
 n2kf0+m9WsWhjPwBHnTZCp6YMbh9VdV/vSEvfmGcm8uQCGYqn4KvFTiVR55ddmFMixOk2j9xEyy
 d1k2hYrrllan28lCmKzu1yqm3afIF3b6JxIkOpdSRZS0eXQEEAyh+xT4C5uERD0Hd9ByC7l0Mwz
 pIRSDtpTr90lmlaXRlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130105

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
 arch/powerpc/kvm/book3s_hv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 249d1f2e4e2c..38de7040e2b7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6522,6 +6522,21 @@ static bool kvmppc_hash_v3_possible(void)
 	return true;
 }
 
+
+static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
+{
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
@@ -6564,6 +6579,7 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.hash_v3_possible = kvmppc_hash_v3_possible,
 	.create_vcpu_debugfs = kvmppc_arch_create_vcpu_debugfs_hv,
 	.create_vm_debugfs = kvmppc_arch_create_vm_debugfs_hv,
+	.get_compat_cpu_ver = kvmppc_get_compat_cpu_caps,
 };
 
 static int kvm_init_subcore_bitmap(void)
-- 
2.50.1 (Apple Git-155)

