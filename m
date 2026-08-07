Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD0C1DDC38;
	Fri,  7 Aug 2026 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123517; cv=none; b=LZ5DHaCFndC7U9XcJK7cQHg2qAoJrh5hvdgKUq2zienG0ZXSYbsDbmQrMVjbU5ghwxyT1TY5iCDSDhzGkhpEk3KX8Qsh4vFZ+B4y9luLW8xUxb6fnYe7udWWT8KNMipSNBDscWC7IkDYjVPpy2Th/zYuKrrIvnWDEc4cAIEWujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123517; c=relaxed/simple;
	bh=5h/s+AAYgQlPhirHpaBQESgx7qCL8kqNs1uxioqPv9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu2+0cIK6i22gZ3BqUlfTlorbOjbRdUPivlMGwi0ignmyCZpFOlCckm9KcmJV9HOr56Vjb5QR4NOwHNkOITkEYdncioTusSH/kEhF3K48M0dVcXAAuSAjHv5qD5k+wnK54bj9jnuzZg+sw+n4q2wukoTVW7RIL0Tx5wHdgft6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SsSTgmcI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SsSTgmcI"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GlWrq2029326;
	Fri, 7 Aug 2026 17:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JK/HgCIRS7bWKsUL0
	/9kFYeCHCkOOqKTR3vxOapEigE=; b=SsSTgmcIk7+v9Ugn7B9nI+8uS7UJk5NyS
	JoWgQhrf8xS+GbK7X/tzTd2TVlXI3/XTWWRnreUjI2rYsPaYQV/D/0Y9OK93ZT40
	vPHnssu7vUY+c8k/60a6hHvx/MrTmnzPADBfbQNGXJWepJszf3qvvtyeYZYYyAuf
	p98oFU2KbOwWl01QYzQ6FH7YdfFG0sIAaXcWplWgiZbFDux0ZcCE02vBf+PXbGJW
	Jhv4hKm0BRRSUt5qIVlxKD/jsOdmuLVSIPPIMzFgDIni3HiaLaOnT9yStRf5UUrw
	IECx/aI3dk01TtxxmhBFQytLx9D5rOtW9IUbLeMe9hjR+DNQRkkhw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyw39t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:25:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677HBGHS009346;
	Fri, 7 Aug 2026 17:25:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgrfas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:25:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677HOwCS26477032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 17:24:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8026F20043;
	Fri,  7 Aug 2026 17:24:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B78F20040;
	Fri,  7 Aug 2026 17:24:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.72])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 17:24:54 +0000 (GMT)
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
        Shuah Khan <skhan@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v8 3/4] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
Date: Fri,  7 Aug 2026 22:54:32 +0530
Message-ID: <20260807172433.82045-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807172433.82045-1-amachhiw@linux.ibm.com>
References: <20260807172433.82045-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a7614ef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=jUdWb-NNBahwQYUnPB4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX1Snl4TzWlYkC
 tVBQsvSNndo3+tHseXWQaD/tqmQBjW1RlgRLsftCSqQGe8gz4wvmf41L5yPUr4+VZpu9G4/17oj
 cfOAwoFTS4Uh8OEBgJjhkPVnfF88h9Q=
X-Proofpoint-ORIG-GUID: 7_2383a5b3hge9jzIonl5iWQY4wg5EK5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX6QBKb/qqbDwf
 AsKzQsU6FyJY4GNkJDKOdIu0QZX+qIzOFxw9aTy0POBd7TAiOellvjpYExlkB1eEj5uLc/bIax7
 qYLoiW61mWf0cNZzfmmpzg1eM6hb+IcGlk0zMKXuk+W3Scd5p0oSQwLaEs1TnMm4jkCMLWq9Lkk
 6uKvgrxSFg6vBl5ckPXNGTzqQM27iMGNdaTN9mHr17JP9rJa5Y68XlKpzsgMtzfIod/eWpr9Sgv
 1y3T/BTT33N5sciWkgp+Xy35Ed/1AYgn9gapZOql5Pdo+2Ips0eKymZjamGaz8PBo+rSMc+nfSj
 HRhXHKKLJ7FMjMRdiAk0Pjio2ufrE7IBWJjV+d+//mz78rTWf7RPH/SZbd/pdVziflHMeJ197Jp
 Gkmerj49StQxAuBPl9t4uNGBiz4QnMuxX5D+KsVegeaSsNakd45GgqwX56LvtjoDQA5FfCbyGLL
 nya1lR8cSqHWtNKD+Ew==
X-Proofpoint-GUID: LcnEmZl0_0ZwACMQBcSHp6B8WfNRBpf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070135

Currently, when booting a compatibility-mode KVM guest (L1) on a PowerNV
hypervisor (L0), the guest runs with the expected processor
compatibility level. However, when booting a nested KVM guest (L2)
inside the L1, QEMU derives the CPU model from the raw host PVR and
attempts to run the nested guest at that level, instead of honoring the
compatibility mode of the L1.

Extend host CPU compatibility capability reporting to support nested
virtualization on PowerNV systems (PAPR nested API v1).

For nested API v2 (PowerVM), compatibility capabilities are served from
the cached nested_capabilities value (populated at module init via
kvmhv_nested_init() using the H_GUEST_GET_CAPABILITIES hcall). This
information is not available on PowerNV systems.

For nested API v1, derive the compatibility capabilities from the L1
guest by reading the "cpu-version" property from the device tree, which
reflects the effective (logical) processor compatibility level. Map this
value to the corresponding compatibility capability bitmap using
KVM-specific constants.

The mapping is cumulative: a system running at a given compatibility
level is assumed to also support older generations down the supported
chain. Note that unlike KVM on PowerVM (nested API v2), KVM on PowerNV
currently does not strictly enforce older generation compatibility modes
for nested guests - the reported capabilities reflect what the host CPU
can present, not what the hypervisor independently validates.

Introduce a helper kvmppc_map_compat_capabilities() to translate CPU
version values into KVM_PPC_COMPAT_CAP bits using a fallthrough switch,
and integrate it into kvmppc_get_compat_caps(). The implementation
applies masking to ensure only supported processor modes are exposed.

This allows userspace to query host CPU compatibility modes on both
KVM on PowerVM and on PowerNV platforms via the KVM_PPC_GET_COMPAT_CAPS
ioctl.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 152cd08a5b38..4d0307f55e06 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6523,20 +6523,56 @@ static bool kvmppc_hash_v3_possible(void)
 	return true;
 }
 
+static int kvmppc_map_compat_capabilities(u32 cpu_version,
+					  unsigned long *capabilities)
+{
+	switch (cpu_version) {
+	case PVR_ARCH_31_P11:
+		*capabilities |= KVM_PPC_COMPAT_CAP_POWER11;
+		fallthrough;
+	case PVR_ARCH_31:
+		*capabilities |= KVM_PPC_COMPAT_CAP_POWER10;
+		fallthrough;
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
 	long rc = -EINVAL;
+	u32 cpu_version = 0;
 
 	if (kvmhv_on_pseries()) {
 		if (kvmhv_is_nestedv2()) {
 			WARN_ON_ONCE(!nested_capabilities);
 			capabilities = nested_capabilities;
 			rc = 0;
+		} else {
+			for_each_node_by_type(np, "cpu") {
+				if (!of_property_read_u32(np, "cpu-version",
+							  &cpu_version)) {
+					of_node_put(np);
+					break;
+				}
+			}
+			if (!cpu_version)
+				return -EINVAL;
+			rc = kvmppc_map_compat_capabilities(cpu_version,
+							    &capabilities);
 		}
 	}
 
+	if (rc < 0)
+		return rc;
+
 	host_caps->compat_capabilities = capabilities & KVM_PPC_COMPAT_BITMASK;
 
 	return rc;
-- 
2.50.1 (Apple Git-155)

