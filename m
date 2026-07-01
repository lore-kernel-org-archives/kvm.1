Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3FA38F620;
	Wed,  1 Jul 2026 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782882901; cv=none; b=I10Ed1C40+OCo6RXqEmE7wuJD71Xxr+3gi0DeXen5NHoNxck1gkHtJpZq30AzaBIF8ch4/V+S9agtG/RH8Ox6mXysa76eG/A/6qNkE7EQhbLq4nD+8YhTRuvJPvINOj1dmgBlGitK1YTa6sFRTWVZUiLgHOPFt2uMlAHQfJ5x/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782882901; c=relaxed/simple;
	bh=R9GrNE9eA/5pwYh64ySykc/PyFlHn/HQJDmMa/Cfu5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+y5QjNMi9dZtBWnQoqSrk0uOoPOJfh+u1qiL3Ta7QI2zQjJyij9QgV+KLiIhaWV2Bg6TZjYsRiIil7+Hh3H5w5X+wiWTNExieDqsusJmrDOvzGnxdO7iURyxxJ/VTFDQEu0hDBSLVSoib9V0CyGgSYVi/RrO5KPREMLYs8mxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QQyQJ1Iw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QQyQJ1Iw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6613IEKv3925066;
	Wed, 1 Jul 2026 05:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=svIKEkUWgcotjHRwV
	tdK/jkwHAqLuSHYQH38GiViSBo=; b=QQyQJ1IwT9T2KiidpCy4rEB9osrXvgzKg
	M+pMuxlC7t8kIkmLjNjidgifDMxhVNoDoc+dY6S7hvLODCxTtv5ZBvvjLRBAsA4A
	YSPJI2KIY7Dzhh1hft/dvtaQe7I+ehqL7w+d27UpoUCcPw1Cx5Xf6ZG5TD28N6H5
	CZLjLWsMvCv2IRigHFuq6lf4zI+3UOrv0a9sXMUaHhSewX37OlhyQcpP8P9Rr2tM
	gk/HaQM9C3kAFAZTjJng+7rBo0JmpW2ye4kmgidZingqoHBIViuZRCr1bGpqamTZ
	vqNHijYHaKkIQSF5F+y3QqB/Mw+xvV5ZQp1QJtRW5pp7OCnuj7K/Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe2p0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:14:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66154hfh005495;
	Wed, 1 Jul 2026 05:14:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhdnyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:14:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6615Egr456885648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 05:14:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEE6420049;
	Wed,  1 Jul 2026 05:14:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B09C20040;
	Wed,  1 Jul 2026 05:14:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.211.190])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 05:14:38 +0000 (GMT)
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
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v5 3/4] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
Date: Wed,  1 Jul 2026 10:44:08 +0530
Message-ID: <20260701051409.51820-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701051409.51820-1-amachhiw@linux.ibm.com>
References: <20260701051409.51820-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 91QUwB4qurX2nT0OHYZBQiF6AfRV2MT8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA0NiBTYWx0ZWRfX8txGuyzbRHDq
 NytbqtxpEBJFfhVS0IDpEs0mJXAlpMxwTnTbm9vISOCaq0azP9kMiXe2sJziW0cyEDy1Fve2ek8
 STgoL4w4yEHuLSpWPRDzvME76YwEEZk=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a44a248 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=DLIAxpZkpLpJS96MVYMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA0NiBTYWx0ZWRfX6JkcJ0YK0tUl
 f3evS36RPbD5rIkr9JV+SU/QXXKiL86xqtQnL5E5j05Jmyxh8WPMj4n+w3leEDaHIltGNqYfCmr
 6/69WxctwuOKVoL/on5atAMSb5ayTTjL5AqeX+z+7eirYhSFuNl/3O63eAbcXvnY7FUTqwXBrua
 lXYhGnFugjnp2I8V+Dr4tgXsejCs6FNbSkOSn85qR7/Xhg7s/6pFvrAADXt2V6F194u2SWgLEzD
 D2xYFB26RtsYt+t+RNcCKbbP9fmbyeGDFkKbTx+vHZGo1ajxsGXinStqrsCE7QLDaK7emjbks+d
 erqC+pmU7BL4VlWwPQkTjBhwo8UH/WZz39h7jb3PgSgIvz/3JzNxpzrG6OPL/a8S+r/3gdeuIEI
 6QkaO9QDqrRTTtD+FI1uC7RaeZnbhQkej/RudOsVcVmOg4vJaha3tLo3qrDQ8y+pQlOm/Y5UOPb
 NI2L1RYvn8Ysiy1Lk3g==
X-Proofpoint-ORIG-GUID: 5-C-EE2VdzzeNPqG4723HE_YWBImOana
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010046

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
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
  - Converted switch in kvmppc_map_compat_capabilities() to use fallthrough
    for cumulative compat mode reporting
  - Check for 'rc' error before assigning 'capabilities' to
    'host_caps->compat_capabilities'
  - Call of_node_put(np) before break in for_each_node_by_type() loop to
    avoid leaking the OF node reference

 arch/powerpc/kvm/book3s_hv.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 152cd08a5b38..ba4b2b3aaf4e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6523,20 +6523,58 @@ static bool kvmppc_hash_v3_possible(void)
 	return true;
 }
 
+static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
+				      unsigned long *capabilities)
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
+	const __be32 *prop = NULL;
 	long rc = -EINVAL;
+	u32 cpu_version;
 
 	if (kvmhv_on_pseries()) {
 		if (kvmhv_is_nestedv2()) {
 			WARN_ON_ONCE(!nested_capabilities);
 			capabilities = nested_capabilities;
 			rc = 0;
+		} else {
+			for_each_node_by_type(np, "cpu") {
+				prop = of_get_property(np, "cpu-version", NULL);
+				if (prop) {
+					cpu_version = be32_to_cpup(prop);
+					of_node_put(np);
+					break;
+				}
+			}
+			if (!prop)
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

