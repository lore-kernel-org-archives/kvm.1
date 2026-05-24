Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3853AB27F;
	Sun, 24 May 2026 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639640; cv=none; b=BVLsqvoYHBGWop9qr0ceqNtcwHPh1mxp6Yr44LJR9BzJoyFOgPBZ47MrZoXPyeWLdj2p0MO1XWyl28To/SsYT+SiYtJZb+q37vP2vRosjx20gXwDrEn0dnLCRfefGqrVKcGOAZc8IK7soZjLbQVFOgDUEzWwtJeTVFQT3r6WqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639640; c=relaxed/simple;
	bh=cCbi42ybHYA2NVsRMLs5aL9DmiZNh9mQbasKc5As6so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6yI0AUbYby4U26Nr1PrtS657UynyboDaf+ZBhdBVJSBA6GuCi/99X+V0v6+RW1T3hh6x5g4EzmBhLB82mrA9LO/Gp2DsaBZSvimWM9visBAM0QCIoRlj/j3MWiksnc5abMqgAyPbFEE34v89Stwgzrgl8EjE24wkZ/NsUiCD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k2QPaU0q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k2QPaU0q"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O580dV3828788;
	Sun, 24 May 2026 16:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VqN21vzvn/n
	BLPhaHYlcmo4rXms5WRMKGKY9USyjovA=; b=k2QPaU0q2xkZq3uFvPWs7ZiRQuo
	jONnKErO8dKrfxGpXXqTSCXbeGBPPtnNcizAH9lCAaaldw5A4VzShzRWuxDzs3SJ
	M+DiCJWDnuTUoDkFYHU/c8JTGuJ4qVCpY47JBMPg/Z4lkPxgtmadyuDhFweCDltI
	OyLSts2Wo+UpudgyI60tPGM2SOVabnTwA2CPf0RctLk5dJINoA82vNdji4eArb5n
	SshxxDzy/nCHxvp3fNyBRCYKJZ+CNVx7te3Taq83GNKDRn6Dk4Yd6ubjnV5SL+dy
	2ePE6tkNjsiHL8F3R1F/dM1M/ap3ZQ1M9sfNGuDvsXqiaGoGZ7TnOwh1GMg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w31va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 16:20:23 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64OGKKXq025073;
	Sun, 24 May 2026 16:20:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ahj3ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 16:20:20 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64OGKKaW025057;
	Sun, 24 May 2026 16:20:20 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64OGKKWi025055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 16:20:20 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 674A62161D; Sun, 24 May 2026 21:50:19 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>,
        Thomas Gleixner <tglx@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH v4 1/2] irqchip/riscv-imsic: Add nr_guest_files in per-HART local config
Date: Sun, 24 May 2026 21:50:08 +0530
Message-ID: <20260524162009.2602535-2-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524162009.2602535-1-anup.patel@oss.qualcomm.com>
References: <20260524162009.2602535-1-anup.patel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a132547 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=oD6YGmB8v4GqGCjrqTEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE2NCBTYWx0ZWRfXw3j6nvSVJOnu
 HOT7etP0e4Hfu031CF/UDHYcND7I73A5PCKWTlq0mghR2TLbNsb259vMJduCNHv5yXYX6pAqnnA
 cz/NLo41ZjIjfqpwOfI19rHNZ+Ym3JJjOBiyzla5ObmNj3IGl9GqHq+ZMravbM8av7rzfFV3E0D
 NNDnoSrlbOF3ky2Hm3ioAXbkcGdwse615xRww3nU6iJ1oZIwWO+/E+N0HNnOgA5/Zzn7FWrvKf9
 Mp5JyBHy06FXP83ykpxGDVQfOGRhXKhTeT6rStT7ov/32Lx0gajN9P342PW8sYgllLqRpG6AxCK
 Ujve59oNkdEkWJKaxINGx3vjU+/EF0IN3WFd269JkwkYNuBnkRSMU4Mmmbqycaqdny8LN4jperQ
 GckXTecs7sZXws1KvkFQ9W/Tlp8d96CXEraVSIEeYMUmFNh2QzyZqdKyNb2SRMyhYpOxg4j5bSK
 c0EAfcxOiqAJBORW9QQ==
X-Proofpoint-ORIG-GUID: eT-G80Yv_dvz8COasQa9XDhyTRmGUmPJ
X-Proofpoint-GUID: eT-G80Yv_dvz8COasQa9XDhyTRmGUmPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240164

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

Add nr_guest_files in per-HART local config to represent the number of
guest files available on a particular HART whereas the nr_guest_files
in the global config represents the number of guest files available
across all HARTs.

This allows KVM RISC-V to use nr_guest_files from per-HART local
config for asymmetric big.Little systems.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
Acked-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 drivers/irqchip/irq-riscv-imsic-state.c | 9 ++++-----
 include/linux/irqchip/riscv-imsic.h     | 5 ++++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index e3ed874d89e7..b8d1bbbf42f7 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -920,13 +920,12 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 		local->msi_va = mmios_va[index] + reloff;
 
 		/*
-		 * KVM uses global->nr_guest_files to determine the available guest
-		 * interrupt files on each CPU. Take the minimum number of guest
-		 * interrupt files across all CPUs to avoid KVM incorrectly allocating
-		 * an unexisted or unmapped guest interrupt file on some CPUs.
+		 * KVM uses both local->nr_guest_files and global->nr_guest_files
+		 * to determine the available guest interrupt files on each CPU.
 		 */
 		nr_guest_files = (resource_size(&mmios[index]) - reloff) / IMSIC_MMIO_PAGE_SZ - 1;
-		global->nr_guest_files = min(global->nr_guest_files, nr_guest_files);
+		local->nr_guest_files = min((BIT(global->guest_index_bits) - 1), nr_guest_files);
+		global->nr_guest_files = min(global->nr_guest_files, local->nr_guest_files);
 
 		nr_handlers++;
 	}
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index 4b348836de7a..61af3a5bea09 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -40,6 +40,9 @@
 struct imsic_local_config {
 	phys_addr_t				msi_pa;
 	void __iomem				*msi_va;
+
+	/* Number of guest interrupt files per-HART */
+	u32					nr_guest_files;
 };
 
 struct imsic_global_config {
@@ -68,7 +71,7 @@ struct imsic_global_config {
 	/* Number of guest interrupt identities */
 	u32					nr_guest_ids;
 
-	/* Number of guest interrupt files per core */
+	/* Number of guest interrupt files across all HARTs */
 	u32					nr_guest_files;
 
 	/* Per-CPU IMSIC addresses */
-- 
2.43.0

