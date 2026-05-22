Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8BB37C912;
	Fri, 22 May 2026 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463706; cv=none; b=RkP3nHJ6zQKgv4Z4rlMyCIKsWysaAqbbhFBpNadClz9ZfWPUpMVaB8dsB50P3yHsK6H92wCeK8BjISrFuVyKm8ME6TX9JNp6CpChyGOkvbJTb/Pku8b6Mgm6NU+NPoP7gtXrxReZ5ae1CXU5XQ3MvdgoYmod1y8EYEu7eyGEX7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463706; c=relaxed/simple;
	bh=UIkIfPZO20lWvIgpb6SIYMzzDEZXmVrxyBdHDP4iguc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEDozp6lMWg5mgjpsubHGsLIH/TGyj/ph81KMl3XYTB0GY+2D9TS0rEAp82xSl83gsMJD0x3ZIq8Voe5pRD8ltf+g1JmE+EpASNSA2eNSCC+Ch+xw4aWmtm3J6Xm0ddlSGFfmZ/DEa+6u5EP6PaYNJP0Z86RHdAAJGB0tw7/DoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B7H68ktL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B7H68ktL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MAJgsf3901160;
	Fri, 22 May 2026 15:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HlzLwUEbsW8QdQxb7
	lYhwn6gUTRl2qROPGjwrMiKiNs=; b=B7H68ktL5LnxKn6HPV9aIDAX8YXWsy3qI
	FUc5uztPE7QPn11hpdkmQQvbjSGFEotggtq7Wo3FBx4b4URYCuAXWDIEVlrGisSW
	Zf8BAc5+rjJoYSgFBTsbPvYQNajxSEEI1OVpmCK7o079MgKc/OXlMCWFbWF29wTA
	xwcvNj9ukImWdKzt3AAbKx2kGyquuIOPTIyFASDgWCIHj9TA5tX5M6zkBaxU+Gm8
	A+vpjibrqAEA0lljxlIaqepFTOwhkUgHq2MGSHysU1qv5hnkKge/IWIyc1SPz41a
	NSBSnzG6M4VWJWkgGrw/f6c0Apgz5Ge7aGjDB5XYzUpyNWUlhnnMQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n4kdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 15:28:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MFO4Ag013948;
	Fri, 22 May 2026 15:28:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyh5xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 15:28:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MFS7Ht15466906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 15:28:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9E7B20040;
	Fri, 22 May 2026 15:28:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 427D320043;
	Fri, 22 May 2026 15:28:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.126])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 15:28:04 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: [PATCH v3 3/5] KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM
Date: Fri, 22 May 2026 20:57:42 +0530
Message-ID: <20260522152744.55251-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260522152744.55251-1-amachhiw@linux.ibm.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 8x443_0NNgPaYrItxbmbQtZrA7izogX8
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a10760c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=lI54la875Hh5wgzWY30A:9
X-Proofpoint-ORIG-GUID: F52EeqLHFmZPzn7Oq3UHEsm1vX45xMvt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE1MCBTYWx0ZWRfXw7+x5m7JvnR9
 /MBOYmE8stV/MOVUN9ADkoQZfIoP2zwIqe9+zf7g83Y37ZOmwXSpf3pdgd+RceiQVr1jePOpd7x
 bqC3c1qmly8BSwXKhoCOJZOnrmDcVu3yFjdn5Be5w8YuysCHe1uXe37Inz+mR6FIVug0XFng3pl
 UcmHvD+QOT2hkguu31CLRGEMiFkw583fYYRNyZsRR84v4kviilxGbRR3DwyRe32ChUbdK5gjU2b
 +XDZ9eYUnL6MZMLCQlyixe9BKXY/4XkNg28SL4hXcduQFhAmXKD4JRt05jJhL7zpv/u3X3tAbHx
 G3Ghj+byKfmACuy9g4XVLYFVA5xbAqNqh1w1PWyYPEPDNAAlCV6nV9EMKCakpkTItgzAXXrT5Ap
 TrR7bY+uuMCGpiuciUJEHEuYAyjifq2MyNUTDgkseDMk1pMjSWIZ5lB4thx0MIn8BLozXTHw85K
 20d73tX5d/f3xBnKdMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220150

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

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
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

