Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE522E401;
	Thu, 30 Apr 2026 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528231; cv=none; b=kfVh64GmCiauywoyULKufcRpEfYkZogFQkrgkZTFdhBJYAoMqmPsSIutvAMRJwmMIznVc/8vJ7oFKhxQ38HgludwhQKRaYiobHghLhf+axeBgUAwpD0mUGXEOrfOtmPY+GnGa3fYHwBsnrgvlKJgQhViXsSXsFKpZTMznc1eiE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528231; c=relaxed/simple;
	bh=M0SjA1f10uVxQ2w9Ge9hE+2+S3awl2IFtkUjUTWswbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUTkTfemoGPSBtbKhVL+HcPcHVXi+Jbxzv6dFQf2Z239LtBmEa05AbAdx9UCZsB3moyDeOg+1DV8BpIiFHhm5VNiVJaf5iepouYu96T7xmJQ7bzUxdpQpaEetGzjd80Aq9qt2UtPIZFi5iX4p6xumHr6TxjO4nP7gx8vWJuJ2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=svjj4TBr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="svjj4TBr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TGvvQD1895497;
	Thu, 30 Apr 2026 05:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ubv6yMYn9d//u05u3
	4jzNdKgQTaW5W4pj0AddL7IWss=; b=svjj4TBrn4aZkvDbzolMj8YF6qj+ob52Q
	rsn8OX1ObecoIX8ZIuRbgDBR8X9HZFcU2uYs10qthTT6TqHV5aZwLIISlqIf95QF
	l4/LfKU4WArc4cYBOK5GeH8KreujIBBWDbf6qQziafCRsuj2l+fQEDN6fv4vc83V
	pMRT7oqT9GoAV/MZHDGo+kKJnBE5O1k8hMfAhfg/lkhVTffEJhnaztl4eKofKuwA
	8PyR07wbY2KGy4UGUG+nN9gZLIj9UsWwvMKm9yf7r5BXEq/Fu1K/t/X63QN3fRTZ
	us5Yj3qHfe/zq2wt8gRf/E3UfSuzCCVrU17MTiSRl39ihKIGVX6gQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e4f9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U5cnE8018013;
	Thu, 30 Apr 2026 05:50:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk9k32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U5oCU040829312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 05:50:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E93B320043;
	Thu, 30 Apr 2026 05:50:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6EF220040;
	Thu, 30 Apr 2026 05:50:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.70])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 05:50:08 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
Date: Thu, 30 Apr 2026 11:19:00 +0530
Message-ID: <20260430054906.94431-2-amachhiw@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: zt7r0mqoNlX3WLlD1khd0zPKSRuFFnQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfX6OVWkafEfjB8
 mGOxl+gtNffqwNC0wEugg5aIzIDy5P9Eo/9wtpRfGvyESiLF2M5y3Axw/+ZW7aScOwaXXoxAX0C
 67UhbAH/fqnIStVlf04g4Et9Cr2090B+++Q9UvCU1ErcWuU6SfUhaKk/X91DBO3P+XNyfkYt3ZS
 L0b+ovgMHuZrp5mndhha+k38YvNUds1s4yhs1mPBQVGLiFf3GwdSsHQn57Uf24FGYbeg4yfEn/F
 kq3nRTEV4MNX3LtwXSaZI74+ZPJ+RA4jNhU1vr5xsdbEselicHS0LUwbuyQGzsWmWeJxyLMct8u
 Czx8wB6UGGPGJKPhEBVlAGFTKw80SXvceCALTM79Yc/TqTGHscAaQs8UhiDewJ0fCklHv3mROV7
 vu6ApxZdtiQzoeYFRQ4Mf7djOO38oEdTq8Mbtj71M0tF/sEuCe6N1NLZX4aDxQocQP8xirnGtq7
 WtOyJeHgbivWYO6N1YQ==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f2ed99 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=9nGdcix9NZkGgJ1vRr8A:9
X-Proofpoint-GUID: CQNBagWsl1eIXAex8tZNSm3NPZAAFrRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300055

On IBM POWER systems, newer processor generations can operate in
compatibility modes corresponding to earlier generations. This becomes
relevant for nested virtualization, where nested KVM guests may need to
run with a specific processor compatibility level.

Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
logical partition (L1) booted in Power10 compatibility mode, the guest
fails to boot while setting 'arch_compat'. This happens because the CPU
class is derived from the hardware PVR (via mfspr()), which reflects the
physical processor generation (Power11), rather than the effective
compatibility mode (Power10).

As a result, userspace may request a Power11 arch_compat for the L2
guest. However, the L1 partition, running in Power10 compatibility, has
only negotiated support up to Power10 with the Power Hypervisor (L0).
When H_SET_STATE is invoked with a Power11 Logical PVR, the hypervisor
rejects the request, leading to a late guest boot failure:

  KVM-NESTEDv2: couldn't set guest wide elements
  [..KVM reg dump..]

This situation should be detected earlier. Rejecting unsupported
'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
invalid H_SET_STATE hcall and provides a clearer failure mode.

Add a check to reject Power11 'arch_compat' requests when the host is
running in Power10 compatibility mode, returning -EINVAL early instead
of deferring the failure to the hypervisor.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..948c6b099a29 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -446,7 +446,13 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 			guest_pcr_bit = PCR_ARCH_300;
 			break;
 		case PVR_ARCH_31:
+			guest_pcr_bit = PCR_ARCH_31;
+			break;
 		case PVR_ARCH_31_P11:
+			if ((PVR_ARCH_31 & cur_cpu_spec->pvr_mask) ==
+				cur_cpu_spec->pvr_value) {
+				return -EINVAL;
+			}
 			guest_pcr_bit = PCR_ARCH_31;
 			break;
 		default:
-- 
2.50.1

