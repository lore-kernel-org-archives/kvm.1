Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305836F8EB
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361736; cv=none; b=jtDw7rLQzY6KALAuP/JU7mAcPfsDhy0/n+fpPGJT2v9cJtEXjX9QxV+wNrCv3dCy5RENEJIFylT1LJspMLKoJmLL9HyNGP6qdciVZyhI/Qr+rIZUtLaqYMXN4nG7U8GIlXjOCbiPIKloQQDde+rOjSa+i0OQRIGODKOUTDjyhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361736; c=relaxed/simple;
	bh=WiV2HBNbFUEP1GjVkUv4n+dl1M7ndOxBOCEt4dD3MFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jV/nZQU5wHHICMvG8RyN+RaylugccoQmDoXUeL38e1vAIUikX4P2KMaav/PIVDXqKiZFcodNuVfuEBtyhxs0CMbR3vDwXErcfljqMgE17/cRN+gV33CxSa8oNh0osHegL5Q00g3Akxvuhm81UGdqdE2atFFvSbT6mqbee/uEI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IfZOqdAC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IfZOqdAC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF6Ix832946;
	Mon, 6 Jul 2026 18:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=o6ISkWxspWCxp9KnHzWXzyl/5pgR9sSj2EM
	01eapVFk=; b=IfZOqdACovuzPx6YPDZjASNQAjR0/R+c3XNppswP278/MYGfasb
	6/745B9cuFiqNI6kEGcuD5TGMeE/Yd5rb3JIJbO4mCmgoEUrJ/DX5SRFCiIakYBX
	Z++J3rsKG4REi3CtpDI0/uQxLjRiBhJoJXrKV+8q8UQkOBFe3BXydRbCPryk62TH
	NyJaI8zvRmCkPC7McaMxogSkV6OkcEo4GeUj6rsFGnjmPN5serJoNWdRog1T4tBH
	yE/9s5KFszNFZxd0/OM6yJC4wHvJgib/e0z+YnBVuo3GHBmZfzIDswZ/5qoKNEpK
	rOi0RiCGBM111pNvQ/2BlC49hr2MQ6Eukzg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98j7ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 18:15:27 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 666IFOJi001963;
	Mon, 6 Jul 2026 18:15:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4f6u8jphch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 18:15:24 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 666IFObt001958;
	Mon, 6 Jul 2026 18:15:24 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 666IFOLA001956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 18:15:24 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 4E946222DF; Mon,  6 Jul 2026 23:45:23 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>
Cc: Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH v3] RISC-V: KVM: Zicbo[m|z|p] block sizes should be always present in ONE_REG
Date: Mon,  6 Jul 2026 23:45:22 +0530
Message-ID: <20260706181522.2003922-1-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4bf0bf cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=Is26oSYgSJ-TJNtENMMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE4NCBTYWx0ZWRfXzujtoVJZN/HP
 xwxsHwBStJj7LVJB5BkknPc9G4d7T19n9wvaObStNzNV0o0uEEYAaI4+y7nd/gaq8v5sVkQGTku
 mDXuUF2wNyyJDtRXlAqlSmxu9pbHEc5ba3chxdBU+5q3OXC3I+dnqYE0+8cqdVBoFfQgg4eSmTY
 uquTVHhJV1pryBAozho6bPqvMfYitS9mRCBuYw3qN+xjq800y3PXhHqYIHwkUBG7/52iBMiXew9
 GaMSiKfn0CJWJmkrMJBIfp/BhVcG093KJrrc6KzSMlcQ1aRPPIrarqh+jjtTztJDLqCIzcHw0MS
 A/s5PlfThxwxhcnSnCIcOCcnJTXLc9REj5EX4mp03pNfmlqggegybwCvXlFTFM/7WfuKdI/LpxQ
 /Sle913u5aWY+4GigPzGWAMbDGCAVcYG2gmVdA9ncNSmmsW1KbP+LC/2gPGNLrg0PFeYt9Q0FTD
 edUzBNxJdl/D2/y8M7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE4NCBTYWx0ZWRfX+E03xURmaaDn
 wIA/XH+iK4vxWV5YkbACVCPPfiBAdEPjURZKmyQJDsLkp1Bz4Mn4u3CrNtMGg83/4+Z2F0jHUMf
 XUW7J4DFk9+t4LtwHHpR3yXOZGCScEY=
X-Proofpoint-GUID: w1gJeEr1SvQPD65bBULpglEqdcNwDSce
X-Proofpoint-ORIG-GUID: w1gJeEr1SvQPD65bBULpglEqdcNwDSce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060184

All config and core registers of the KVM RISC-V ONE_REG interface are
expected to be always available to the KVM user-space and the KVM
get-reg-list selftest assumes these registers to be as base registers.

Currently, the Zicbo[m|z|p] block size config registers are only
available when corresponding ISA extension is present on the host
which breaks the above expectation. In fact, KVM get-reg-list selftest
fails when any of the Zicbo[m|z|p] ISA extension is not present on
host. To address this issue, drop the ISA extension checks from
kvm_riscv_vcpu_get/set_reg_config() and copy_config_reg_indices()
functions.

Fixes: 031f9efafc08 ("KVM: riscv: Add KVM_GET_REG_LIST API support")
Fixes: a044ef71043e ("RISC-V: KVM: use ENOENT in *_one_reg() when extension is unavailable")
Fixes: 48e2febcda74 ("RISC-V: KVM: Provide UAPI for Zicbop block size")
Fixes: cf05b059d59f ("RISC-V: KVM: Introduce common kvm_riscv_isa_check_host()")
Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
Changes since v2:
 - Update kvm_riscv_vcpu_set_reg_config() to return -EINVAL
   only when value is non-zero and does not match underlying
   host cache block size.
Changes since v1:
 - Update kvm_riscv_vcpu_set_reg_config() to return -EINVAL
   only when Zicbo[m|z|p] ISA extension is enabled for VCPU
---
 arch/riscv/kvm/vcpu_onereg.c | 38 ++++++------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index bb920e8923c9..61988382570f 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -50,19 +50,13 @@ static int kvm_riscv_vcpu_get_reg_config(struct kvm_vcpu *vcpu,
 		reg_val = vcpu->arch.isa[0] & KVM_RISCV_BASE_ISA_MASK;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
-		if (kvm_riscv_isa_check_host(ZICBOM))
-			return -ENOENT;
-		reg_val = riscv_cbom_block_size;
+		reg_val = (kvm_riscv_isa_check_host(ZICBOM)) ? 0 : riscv_cbom_block_size;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
-		if (kvm_riscv_isa_check_host(ZICBOZ))
-			return -ENOENT;
-		reg_val = riscv_cboz_block_size;
+		reg_val = (kvm_riscv_isa_check_host(ZICBOZ)) ? 0 : riscv_cboz_block_size;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicbop_block_size):
-		if (kvm_riscv_isa_check_host(ZICBOP))
-			return -ENOENT;
-		reg_val = riscv_cbop_block_size;
+		reg_val = (kvm_riscv_isa_check_host(ZICBOP)) ? 0 : riscv_cbop_block_size;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(mvendorid):
 		reg_val = vcpu->arch.mvendorid;
@@ -144,21 +138,15 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm_vcpu *vcpu,
 		}
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
-		if (kvm_riscv_isa_check_host(ZICBOM))
-			return -ENOENT;
-		if (reg_val != riscv_cbom_block_size)
+		if (reg_val && reg_val != riscv_cbom_block_size)
 			return -EINVAL;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
-		if (kvm_riscv_isa_check_host(ZICBOZ))
-			return -ENOENT;
-		if (reg_val != riscv_cboz_block_size)
+		if (reg_val && reg_val != riscv_cboz_block_size)
 			return -EINVAL;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicbop_block_size):
-		if (kvm_riscv_isa_check_host(ZICBOP))
-			return -ENOENT;
-		if (reg_val != riscv_cbop_block_size)
+		if (reg_val && reg_val != riscv_cbop_block_size)
 			return -EINVAL;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(mvendorid):
@@ -614,20 +602,6 @@ static int copy_config_reg_indices(const struct kvm_vcpu *vcpu,
 		u64 size;
 		u64 reg;
 
-		/*
-		 * Avoid reporting config reg if the corresponding extension
-		 * was not available.
-		 */
-		if (i == KVM_REG_RISCV_CONFIG_REG(zicbom_block_size) &&
-		    kvm_riscv_isa_check_host(ZICBOM))
-			continue;
-		else if (i == KVM_REG_RISCV_CONFIG_REG(zicboz_block_size) &&
-			 kvm_riscv_isa_check_host(ZICBOZ))
-			continue;
-		else if (i == KVM_REG_RISCV_CONFIG_REG(zicbop_block_size) &&
-			 kvm_riscv_isa_check_host(ZICBOP))
-			continue;
-
 		size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
 		reg = KVM_REG_RISCV | size | KVM_REG_RISCV_CONFIG | i;
 
-- 
2.43.0

