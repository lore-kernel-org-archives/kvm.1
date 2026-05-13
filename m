Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC063914E2;
	Wed, 13 May 2026 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666921; cv=none; b=ovpEa67rnFN2wTyW6D6jfRLofnXkGLyKiCq0+sxopmNpr4JSpZDy+wSRslNozOUJRyAAlJoMNFmpJu165zstT6jtgdhCq6DSBo+kfSoP5rxcrZd0CzeDPdLDuMWhBcHLoalmyLBO3qyT+XUmhadu+7sq56XrqR8+O9/3s5BNvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666921; c=relaxed/simple;
	bh=U7tF20pssz6me+fheOnlK6BHi1qvp3Lu2OPMgCaxh0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ut6jzPdjDWJSPohYaUmfXSwAyXcE4M+77w9R4CF/sK3WyyMEmfrZgsJ0e/12jBgslIotq6ULIOt7XzR9n5oGrOAbSMKmATWctH7U4/Q544yq64eht+H/PNVzqiPYLn9jIS/Pxu/6X0aF2FcYbkGV7NNIUeMXjOLSp/jMBDjBMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y4zNzKab; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y4zNzKab"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D2WbKl3185718;
	Wed, 13 May 2026 10:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fHOsSxshys3nROBe3
	I3bMAVl02Qok1BmG9nH1qsqhQc=; b=Y4zNzKabRJC0EPjW4LjDjFeYyYUilmwJz
	/TuEx+h8W0HsIr91DliPJcRzKJ5Dxgj4RaowoqccL1IRx1wO1rCBeqLiDQ7RjEOg
	l4zjlW7pVgDbpw/8AQ637QYkiBNq3BAXBzotQKFKytHPLGKY7a52YhTpHFHK2MAu
	gbpBKJZEsbeSbMANV2UC5/rS2sPGDgie2tyJgcGfu9yR4T36ZfF5kvyHIeJVTvGK
	ENLo6gaa8kH+8pn0UFuw0eewaA9aY9gepBAvmLndEYDUeUFYV5WaraBQ5NbL9DKc
	U54+B4gf9ZzNUJtaYVOqmZe4EiB8pv7nH7nqUIoqXYRT71NctndPA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5f65d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 10:08:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D9sQ5H017710;
	Wed, 13 May 2026 10:08:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgq7ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 10:08:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DA8MiY23331106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 10:08:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 559AA2006C;
	Wed, 13 May 2026 10:08:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FC222004E;
	Wed, 13 May 2026 10:08:20 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.0.51])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 10:08:20 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
Date: Wed, 13 May 2026 15:37:50 +0530
Message-ID: <20260513100755.83215-2-amachhiw@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a044d9b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=9nGdcix9NZkGgJ1vRr8A:9
X-Proofpoint-ORIG-GUID: UOi0TGmF9l-2LvZA5Sn0gQfMb8zVuClu
X-Proofpoint-GUID: WE_86_NKnGijjWFHy_BtKp0_fF5mPlzq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEwNSBTYWx0ZWRfXyya9usxCm8iP
 sagDQDo12e/XYQuntprat5e03gr4jSf1gb6vk6TPpnnUi1b6dfFMuEOTiRYMEs9sP1Cnyjp5Gdv
 2rjB9E76KJODVK4Ax9YyYgtzNkqj/EOtn7FEe5yka8cb60yDs9y7SVhDTSyWhTPvjo92pOIXXZN
 qLg2VoTLJZgMSetLxFTj/nUZyisJV7wyp6XZTt3/wmjsqC5IQQp94zPb/JmtN88Lp6s6vWPEYan
 KDk+VzK4w4L4VZyFVtK5H9/+8bHZVLX5DrZt8BKskHWZDwo8D+nqQIxnyJUOzDIc6w3RQhu8wJh
 gRgJ+IIy2aSjXf9Zz4jTdrWaorkiocVd7dXA/CkT0sPfY6S26nuZw3ka588S8KSlID6mwAOO2df
 BHYvTnWmYk0/HZBl8X2rw5WC9n64vTIKJGCzrwwzuJxnnCBsWIz/M1LpDHDHfUAJhP5/fgquHlI
 a4qVQEzeRTMH43F/8hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130105

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

