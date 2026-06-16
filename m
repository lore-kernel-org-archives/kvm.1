Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028D361DCB;
	Tue, 16 Jun 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613328; cv=none; b=Q2MqvAH7s7weewTYiqVzdlmNH6QSi3PzoF6caMImYVqqiFQBsaF8Ufn02P5siNUx7dCgVWq0TmQF9bBHU/tEt0r+YvxNoHytxUDzuagbdhKnXQ+E84or6ZOlz/rqNVYMU7LmXkn8Wy6/vQqgBRqU97Ju8lSkvLQJduWxXY9PUJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613328; c=relaxed/simple;
	bh=psOTBtcdSjSe51zxDffpgKJ8+R/OZ3hZ6GaI9xTBPxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkOtJPDv6qizWiFw0DEOe4PlHSvFCmgBNZg4pe1iX2ofrvgruZLVL6YtSSBJOC8uWfQUSWLNp5pNlDiHS5/T7B7JvTgNCvQ/4/C2ug9Hb9+pZ1TXm05pns19s0eWIcD8LDWCi+EdglayBOR3VjwMGPRAyczM1qDBeiEvV9/Kafw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dLNNhT2T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dLNNhT2T"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIHsx1245320;
	Tue, 16 Jun 2026 12:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wXBmQPTutCKk9MOy1
	06NgB3YCZ79YKXNsfvEqri4S5o=; b=dLNNhT2T5WQcL5O4HXVTUFuokd56R5Bll
	tXSjZNZxJ5o2JqlppSroBhgMtm2YuyFXsVDQ3w8vtYg6JtiLstp0p6MrOh1OPDS3
	gR30gKkZKIWkDwtzdIMHn1MZEbYFRo/HaAv0+RbUavEAkzHqIlB/NAtWiui/vxPl
	7RQK69lyLZV5Z3xPOkZLeWLkA+/wZM9efLfXR0ANgmht/yeqsw2P2TStax41ndcU
	1FNdIjesdDrgXUBxdKcm3oOreYOmvUAUT2zQrew6lOkkItGQHfE+FO0ZIa1tpCnK
	3c7Ly2UAUW5Gox+ZNX8rmh6R6/A2TmowKnM0W3LgxiY64AjpNCM1w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nnja5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:35:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYlfq010205;
	Tue, 16 Jun 2026 12:35:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhk399u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:35:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCZ8Iv43057644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:35:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 112332004E;
	Tue, 16 Jun 2026 12:35:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4582D20049;
	Tue, 16 Jun 2026 12:35:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 12:35:04 +0000 (GMT)
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
Subject: [PATCH v4 3/4] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
Date: Tue, 16 Jun 2026 18:03:13 +0530
Message-ID: <20260616123314.82721-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616123314.82721-1-amachhiw@linux.ibm.com>
References: <20260616123314.82721-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a314301 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=CHrZwK8WiAud27lQVR0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfXyIa4FBZdUfYq
 nyvS/MXeP2F2QhQgZEJKw+/WKjjbQrv4BUkPsS+4p45QW+vP6aouLQg0Htf4MfpOebHx0UTy5oW
 hYNyiG9TixMq/8bHJw3g8zzIJP11if607aDsTpyfSlp1oR4TIgRPIfjCFDlBwFHHsSitOQuIUVM
 QpcCh6/zMN39+DmAxUq3n+9MEbsh+DDgnsYDVQMymQad2eYbYaT9Naaia3q/nsWPCNU7YqYXIPy
 nyPbkhWsFO7pYzeKmByBlTM0NiZzcU3hox4KxcM3alBWa4zT7B6rRK4cXnSAiDFQFI+zK3sO4nD
 OizWVoTmXjQWe9cP03t2KayJWZgRQl952h8830zW7vv1Fq9WvymLFirQRi/hU86pSdVfK4VnTpc
 SV/ITEGocCBJnwfpFsA/5gVSi1X8b8qCLrsDwQ5xFJKPd8pWMBYD+PGutStvJMpt9n7Kc5K2Li5
 zbY75usKj7SPAA5H3UQ==
X-Proofpoint-GUID: eu5vbqMKks7y4fxCs0TM6ZADZLnr_62L
X-Proofpoint-ORIG-GUID: wSQlymCgu2ljCUgDELkn_TjDV5w78V0h
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX8Jq/MkJeLq9c
 s9uydRJHw5zMBS6WpX2cx+aikxK5dNdVUOfJ1/Xhr+eWXONFdAMgheTtbs1xY/orpV5GDojjI+c
 vUrPK68fVU81Q1HXQALSr/b5U3BPIWg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160125

Currently, when booting a compatibility-mode KVM guest (L1) on a PowerNV
hypervisor (L0), the guest runs with the expected processor
compatibility level. However, when booting a nested KVM guest (L2)
inside the L1, QEMU derives the CPU model from the raw host PVR and
attempts to run the nested guest at that level, instead of honoring the
compatibility mode of the L1.

Extend host CPU compatibility capability reporting to support nested
virtualization on PowerNV systems (PAPR nested API v1).

For nested API v2 (PowerVM), compatibility capabilities are obtained
from the hypervisor via the H_GUEST_GET_CAPABILITIES hcall. This
information is not available on PowerNV systems.

For nested API v1, derive the compatibility capabilities from the L1
guest by reading the "cpu-version" property from the device tree, which
reflects the effective (logical) processor compatibility level. Map this
value to the corresponding compatibility capability bitmap using
KVM-specific constants.

Introduce a helper to translate CPU version values into KVM_PPC_COMPAT_CAP
bits and integrate it into kvmppc_get_compat_caps(). The implementation
applies masking to ensure only supported processor modes are exposed.

This allows userspace to query host CPU compatibility modes on both
PowerVM and PowerNV platforms via the KVM_PPC_GET_COMPAT_CAPS ioctl.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 37 +++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index f674386df62c..375e7a7fa9f8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6523,15 +6523,50 @@ static bool kvmppc_hash_v3_possible(void)
 	return true;
 }
 
+static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
+				      unsigned long *capabilities)
+{
+	switch (cpu_version) {
+	case PVR_ARCH_31_P11:
+		*capabilities |= KVM_PPC_COMPAT_CAP_POWER11;
+		break;
+	case PVR_ARCH_31:
+		*capabilities |= KVM_PPC_COMPAT_CAP_POWER10;
+		break;
+	case PVR_ARCH_300:
+		*capabilities |= KVM_PPC_COMPAT_CAP_POWER9;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
 {
+	struct device_node *np;
 	unsigned long capabilities = 0;
+	const __be32 *prop = NULL;
 	long rc = -EINVAL;
+	u32 cpu_version;
 
 	if (kvmhv_on_pseries()) {
-		if (kvmhv_is_nestedv2())
+		if (kvmhv_is_nestedv2()) {
 			rc = plpar_guest_get_capabilities(0, &capabilities);
+		} else {
+			for_each_node_by_type(np, "cpu") {
+				prop = of_get_property(np, "cpu-version", NULL);
+				if (prop) {
+					cpu_version = be32_to_cpup(prop);
+					break;
+				}
+			}
+			if (!prop)
+				return -EINVAL;
+			rc = kvmppc_map_compat_capabilities(cpu_version,
+								&capabilities);
+		}
 		host_caps->compat_capabilities = capabilities &
 							KVM_PPC_COMPAT_BITMASK;
 	}
-- 
2.50.1 (Apple Git-155)

