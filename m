Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C39486656;
	Thu,  6 Aug 2026 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036053; cv=none; b=uPbcmVLg4AAdeIuLVkZZdGrx2wF85iOtBt8WW0EPBQTP3hddP62QJMu31FGRqPmsa5rthiFLd+19f4QKAXFTYtHPP0wICOYoP++gdhDZwVvIwW0G+xP1w02X6nNjVMKBwO+TsWRYZrbrDTATW/VZOzTV1t+z22pUIMb0aC25MSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036053; c=relaxed/simple;
	bh=h5gGSAJqwt9dfOnoJKv5CZ1c5uD/ojyDb/nuDlHko6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr2G+DuECVR/As6n6puR0JC9GnnhweBYq34JWVvfg7IYhXT00VsTLMCYBKteYnBFq+0RyDMdTII3hSOpNYVAl6SdHhavnuwVpR7SJTJCjkYh+uK5aXT5OeUyrIVIAoWgHIF8LnwmwIS4pbkyzeGuuubvRUxQwFx7wtemFO+i6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gkc6Zz1u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gkc6Zz1u"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EnKvo2964512;
	Thu, 6 Aug 2026 17:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yMuovlYNoPVAGbCdU
	wJL8fEbqTXkZMqSQabPEyNkVFo=; b=Gkc6Zz1ukzBR/YXdeVmaogUkQ6wazJUlK
	rChF1fdOhLwd5eaw6hVt45GTojrCJdRi4DCbtxStEfnR6AoHf5N5rNNBxXNvtAcT
	J5mz2tDOwtF9kKmAyrZetHQbwbg3WBc1NRyQB7cDrt2teUWO7txrsZMV71/5heCr
	lx844n0dbf3KceSPCLwFohNUG/0cpzNFKqui2/28hxMyONXpgsnsFg1TGXI6ehI9
	2++Z/q3TzKehBnGl6q/iW6wZi8iWhEBq/I5PB7BmYAPjW4z5YcfVvLhzu+kBin2y
	a/IlhVWvuYfZzUCqc4Mdy/JNT2JSglrrURMv7xFXCALOGZdcHcDbQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h59gqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:07:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676GuK9r027179;
	Thu, 6 Aug 2026 17:07:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qv86d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:07:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676H7CEh35193124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:07:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD6A92004F;
	Thu,  6 Aug 2026 17:07:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65FE620040;
	Thu,  6 Aug 2026 17:07:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.29.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:07:08 +0000 (GMT)
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
Subject: [PATCH v7 3/4] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
Date: Thu,  6 Aug 2026 22:36:44 +0530
Message-ID: <20260806170645.11892-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260806170645.11892-1-amachhiw@linux.ibm.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzMSBTYWx0ZWRfX0yCfz5mMpgvI
 1cnABRKDnHez0P4BX7wZC4x06D2amM3xPU0KdHe+PhjA0oSrXEVHoDw+jJVNb04OSkH5K4EULOx
 EPgUPHWfLKHCsOeZ7Yt3SXjZPtXA2lI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzMSBTYWx0ZWRfX9MvE3AaHZ4zL
 ziAXDij/lu9mFLsM6Xk4FKtoYw64Nip7QUd9I0QFHnRgd1xGDNLo3FfxxRhHB3uCSRW7lFsFCar
 IeXTmANbn9Sh5bKG0iT7PQ4RZm+4w7kv3JKviWA6TsCbFmx4neXXZdx+cTDuyenKH9XZcDpVY1g
 T2oFfz9GWgOwcHfK1IkYYp2S1qCiiMY4+CSu0YSgk07lEoTHFo7FPLzXAqqUypJYHOwhxx3al1W
 vvCb1CzDIOgU7A3SK434a/Eep58q9ERJGrsheO0Q99tJXI7XE7AgYS6IlqpPUrK9mRkrVBGm6zW
 xvUc0t4UGYoWoZTF/bZGlfxBUabxjzaxjsT2KwDSCDo2r/8Kiyown5ym6hf99XxzOh7Upo6DHap
 KdsLgEo/xCYoZI4qdD46JIs/rv2FCV6OnN0TJKTexHSskdkr8Vv/HjkZNWghMVePpqdxs9QU0y4
 rgTb/pguL6zVxXMicPA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a74bf45 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=jUdWb-NNBahwQYUnPB4A:9
X-Proofpoint-ORIG-GUID: vCfhGG6qW97fI-tVMJhJ0cdl5PPjASml
X-Proofpoint-GUID: f-mfj4m961nYMKtJ0-UUgSaEHB8x6QgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060131

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

