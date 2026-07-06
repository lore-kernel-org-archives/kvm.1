Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE403AEF2F
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316421; cv=none; b=JmYZHOWzCztGKi9aR1QRx9huHN35IjNl/8Rn1ls/CxZ+w+wapEoT2YXzvKEjdshh2opx97sCBw+zFhxelOPlFedc5L9dJ4lGTv8dk13unjzxDtkj2I5gLcZoEerQo3FNRbs1VhrVD/rhhcC7zaVnm9yrtHXRpc4CzKgBg08tWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316421; c=relaxed/simple;
	bh=5a3qsAXcCd8P1Jz727d+2da0J2+3EA9VsXtCqlqhMaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKL6KKUEv3ztMBmqRxgem6evcoAgWpd/cYUm2JlWxGMZAzDLFisJk6PZnraQRB0WKIe48AJequTjNr5K91v6ZHziiVzFfxy8l0XG6rsjDKWWuoFF4jwiMCaA3Us+8aV+ig09X3h2UZKtAVQDnQXs/vSFfcDdBBP2VzPtfbeLQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EFPjML93; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EFPjML93"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641gpx3402327;
	Mon, 6 Jul 2026 05:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+C38mLKsnPV1WFsxwnDRTIc2w9x1MiAgR+n
	/8xaRsw4=; b=EFPjML93YhRgqCmMJ0EoQVGms4HA9wdZPHVNiVuFrcLT12qe6l0
	yYGc9Ih5ggwAWcQtXxc2KYG+ZnoYMklCxgH4hhVofwS3ESSx0LKQyxyi9QS21DYm
	FQHYmvNftUca3T12vIO5Bb32s5K1gqehS5fTtEdhMKGkGPV3ULAoQBeSAwF/MU0J
	Q0UVh2/a72qYvKiH9p8Vea5TusIcsI5FNFssOTb0sOartxJJeWQntaRTis2D8W7n
	rjenVxTDUl8LYRf/Xa58zH76HN2KV55poBZCxM6r0pYVO4c0Dhnv3IoozMhnNBAB
	5mcGyQ5sbYY6dqkIuovXRGEB1KSRxFYgKzQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ubgmcbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 05:40:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6665YO9i003120;
	Mon, 6 Jul 2026 05:40:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4f6u8je963-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 05:40:06 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6665e6lF012553;
	Mon, 6 Jul 2026 05:40:06 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6665e6UW012551
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 05:40:06 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id C504221CDB; Mon,  6 Jul 2026 11:10:05 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>
Cc: Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH] RISC-V: KVM: Zicbo[m|z|p] block sizes should be always present in ONE_REG
Date: Mon,  6 Jul 2026 11:10:02 +0530
Message-ID: <20260706054002.1089394-1-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA1MyBTYWx0ZWRfX4KxZ7lR/3dad
 fKRUxMV4bh8XbiYM/Wenf1abgmf6OgreyWulgWCtUCbFkZLYQfvbzQ6UxmVk+DBSSK960QdUck9
 0qPbra0oE1tI07hFWWsG1RAmnD4t/uA=
X-Proofpoint-ORIG-GUID: yXKazZIOC6fYOvlswaW69YzyBSXYjBPD
X-Proofpoint-GUID: yXKazZIOC6fYOvlswaW69YzyBSXYjBPD
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a4b3fbb cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=z3A17_TG5Y3XFGgIDokA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA1MyBTYWx0ZWRfXw9tHakokPSW+
 XZzyi4LMFcveIqDjIDJjDQFWg6u6L7YGJdl0PsfVIqpkNkxNSrwHu1pKZK+n5qkVDeGff6a4PxL
 sQeS47G0bhkWJDi5WNR0+MLDk+g52tx787GlIV9GJkrI39jTBtIrjE965tmcMJSSqHLywBFfN2W
 KehifpV03x0wC2WugvyInZI4hFRUv7pB0LVTPL5RZEfea6S2lwQuwdRLo7vN4eq3xXRGUYIKzPY
 falVpWi/FQXCXRYuPojyGxq5d+OZlcRpJETNNK5mVxA5KEk0ik8j9Ox0hZxeu1rg2+o8S59LB87
 Sl5Ki7W9gvq1MZXtmvBLRO3NccygQZNJbmAizw85wzdoDnxksCiQ2vNBgEW++2/HqPctSVqpEeS
 grBBx/qAG3ME48gDrKoa0GBYD6zhHjcQTQQlKO9Wd1d1uGv4DcFwNPxWfLjJaVbiWCPrnSriHvo
 wv3q8bjW4FE4iQ7juPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060053

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
 arch/riscv/kvm/vcpu_onereg.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index bb920e8923c9..26d78987f2c2 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -50,18 +50,12 @@ static int kvm_riscv_vcpu_get_reg_config(struct kvm_vcpu *vcpu,
 		reg_val = vcpu->arch.isa[0] & KVM_RISCV_BASE_ISA_MASK;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
-		if (kvm_riscv_isa_check_host(ZICBOM))
-			return -ENOENT;
 		reg_val = riscv_cbom_block_size;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
-		if (kvm_riscv_isa_check_host(ZICBOZ))
-			return -ENOENT;
 		reg_val = riscv_cboz_block_size;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicbop_block_size):
-		if (kvm_riscv_isa_check_host(ZICBOP))
-			return -ENOENT;
 		reg_val = riscv_cbop_block_size;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(mvendorid):
@@ -144,20 +138,14 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm_vcpu *vcpu,
 		}
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
-		if (kvm_riscv_isa_check_host(ZICBOM))
-			return -ENOENT;
 		if (reg_val != riscv_cbom_block_size)
 			return -EINVAL;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
-		if (kvm_riscv_isa_check_host(ZICBOZ))
-			return -ENOENT;
 		if (reg_val != riscv_cboz_block_size)
 			return -EINVAL;
 		break;
 	case KVM_REG_RISCV_CONFIG_REG(zicbop_block_size):
-		if (kvm_riscv_isa_check_host(ZICBOP))
-			return -ENOENT;
 		if (reg_val != riscv_cbop_block_size)
 			return -EINVAL;
 		break;
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

