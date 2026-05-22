Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C58472786;
	Fri, 22 May 2026 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463712; cv=none; b=gTnDtQT1HOyaZ+o8REHHNe+61a0AZY/Ycz107PV6hcA55HTcjeq5wF/1AULuJK0cF3PF3tQmHaokrgbiy7eaKGaC2SavmnnqEAuhMeHCZc6HtguH5wvUfNvbQaj3L+mCNXY+jcnWytSuChlbyPXl/FTOQdnbCKOEySJS7DzAjQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463712; c=relaxed/simple;
	bh=CT9fx/78hNFVwXN/u7Q/1NAzBoypA6sleGOiWGsAhUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6AIL8wjlQpsu+wx6Kb8hpQGDa1gGhqD6Zrf0pdtGmBIeOW70LEbzO41tqLRNpRhrv8L0Y/fgoWz/8ykE5fsaNkq4Qrc2mpIP6fd2dEEx9IKkiyMM90LJlcs+kfiyS2yqrZiJEedBRg8l82SGmZUDpUOpcTUbYUf//wY21BnOFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CqWhncWF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CqWhncWF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MFR62c2799624;
	Fri, 22 May 2026 15:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aC/QD095aT+rxtsNy
	euzUGaJhNG64GyJ51ZMW6GygUE=; b=CqWhncWFSJY7Vmq2wylhtIPBKWVLtuYOh
	NQzfT2qntfMsVvrzxT9YOTaWPKoiKME7aWygtGpg6JfHzgISpOb8Jc5cGkWXZzfe
	YLUyh/HSH3xOOW5fJyx4JRUrO/aB/8YybsF+9vzlsCSpWdbBJq6tMvYtlvfzvSMO
	SXE0PvIPx9JPFpMw3r15HbHDJJt1aQYK7/7MexCd8KfbUWezihay1I8rHGZv2f5d
	fgTeqQwYKU4jUQOHJTSOes5ukrL+B+Z/FYZndAmhqxXYthwGbKhRCPjn4dVxGQm8
	WXRMqYcwOWi/KsUfgxZkJfTMTNtOQ0qbYd8o5LKT6gLqd2XyFOZ+A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawk6ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 15:28:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MFO8UA013645;
	Fri, 22 May 2026 15:28:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gs7sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 15:28:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MFRwlr53215690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 15:27:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F151220040;
	Fri, 22 May 2026 15:27:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8038C20043;
	Fri, 22 May 2026 15:27:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.126])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 15:27:54 +0000 (GMT)
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
Subject: [PATCH v3 1/5] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
Date: Fri, 22 May 2026 20:57:40 +0530
Message-ID: <20260522152744.55251-2-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE1MCBTYWx0ZWRfX73H+plhK0DSS
 25I0LFmmYg/XwN8fhNwjRzvKrKrYffjKUbBNoJzbhSO8fZ/iuJAMju3F51Q6JPcjedYPorn1hrt
 VhnNizNaSI+85OBssAQFvku7nxrHDCJBAClFsVTKnTZiq172Rx+395bdoWnsQWh9vw5v6g7MFcd
 MfMVRtJ+l3uzDb7cWD1kFDXKazeOIiUrzfhl3tHhBbfFheo/qW7uVpYkSywrZwTDBrvgLt4Ir7d
 zEG3m173nZY7CYxZAlO3O3Nh+aR7g75bnieowcGlQVlADwv/HXbGYjpKNetrEST7CMdhNMF6iNc
 7zsmJVWzonoKaqlx9yiUzZF1ujXpk302tU6Uv4iQaGryWJYtSyzkuuj/Js7LXUJ7iqrI9yNJCwa
 rpU5GiwK6I2RSOErx5RUclvJXGJ5sRw26ryLLuJ3J+HB78EI1PajED2qmVpqAtUV/V0vXf+OQxa
 G+cgWurXIw1wmW12efQ==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a107603 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=9nGdcix9NZkGgJ1vRr8A:9
X-Proofpoint-ORIG-GUID: zLJ0M6e0kG7nOLGPJiPkVAOcvDIPBuIh
X-Proofpoint-GUID: Ovko6TasHuGv4yj1U_3ln28ygmsd6Zc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220150

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

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..249d1f2e4e2c 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -446,7 +446,19 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 			guest_pcr_bit = PCR_ARCH_300;
 			break;
 		case PVR_ARCH_31:
+			guest_pcr_bit = PCR_ARCH_31;
+			break;
 		case PVR_ARCH_31_P11:
+			/*
+			 * Need to check this for ISA 3.1, as Power10 and
+			 * Power11 share the same PCR. For any subsequent ISA
+			 * versions, this will be taken care of by the guest vs
+			 * host PCR comparison below.
+			 */
+			if ((PVR_ARCH_31 & cur_cpu_spec->pvr_mask) ==
+				cur_cpu_spec->pvr_value) {
+				return -EINVAL;
+			}
 			guest_pcr_bit = PCR_ARCH_31;
 			break;
 		default:
-- 
2.50.1 (Apple Git-155)

