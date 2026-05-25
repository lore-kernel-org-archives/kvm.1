Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73583405E7;
	Mon, 25 May 2026 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702602; cv=none; b=kyvOdyKl2gyGi0BVtZVGVpXQLeQ/ZQzaC+qvzlsT0+NbaaRLNbjQinI2/McAcAwEzfleZHv5NtJgetS6unV8fOIIqv8OEi5+wXDJARjeG3XUDqbKyMjsHvmPsIH0KIaiFbvM1x89PGQMXldhfGLLwf1Fvhf9a/F8puWS9Nhh1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702602; c=relaxed/simple;
	bh=cCbi42ybHYA2NVsRMLs5aL9DmiZNh9mQbasKc5As6so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8qJqmG2k/ZOYVW28NLWZOw5v4lS+aGuMC5unWdqu1K3bMZ7Q7Q8/ppAV8Pqf/e71kdFU91VGjJOUujbLFxRjznaRkZWHlqoFMZv6stymHbqpm1Ds9Ej0AkP5EXMQDRwQomle4HgADz4N/eU5JLWC9hF7nIQq2BYnZHbpWWRx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T0ii8/yK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0ii8/yK"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P6WfYt119484;
	Mon, 25 May 2026 09:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VqN21vzvn/n
	BLPhaHYlcmo4rXms5WRMKGKY9USyjovA=; b=T0ii8/yKWFykk/tg6D2QXTyCnyj
	I67W33GEjvREhOJnwsZT/+tPXNXMZWcDCkuw32UA1XB/viGf4CL3d3GVoWeZg9qA
	Qz2pzs+1FKtoBx1ZahcbMW6D+PlChAkkkTm7nN+8puVtZw6MGvobkKmleFkJw/oh
	JgMgTX1R+tSBlzv9bp165cr0pco9/SpfS/NNRitG32LLVJ1o9+fUMqU4ncZYVlCO
	cMHpNqHYnlsGx9T0y6MY2SkPTLcLYjhnlFpK3Sv7xygvn6032VZSMSzTIZd7VWdC
	m3oTqSCoZkxRFSCLUM9bEoY/fSbS69BjmZ3RGX/SSRTcKJClqnrGW2LCcEg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3e2ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 09:49:50 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64P9nl5S019449;
	Mon, 25 May 2026 09:49:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4eb5ajeh9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 09:49:47 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64P9nlV6019434;
	Mon, 25 May 2026 09:49:47 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64P9nlQH019429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 09:49:47 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 6577422668; Mon, 25 May 2026 15:19:46 +0530 (+0530)
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
Subject: [PATCH v5 1/2] irqchip/riscv-imsic: Add nr_guest_files in per-HART local config
Date: Mon, 25 May 2026 15:19:44 +0530
Message-ID: <20260525094945.3721783-2-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525094945.3721783-1-anup.patel@oss.qualcomm.com>
References: <20260525094945.3721783-1-anup.patel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: uaoG8qfql68Ha4I_kExK7fwOk16HLcuE
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a141b3e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=oD6YGmB8v4GqGCjrqTEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEwMCBTYWx0ZWRfXxh21r715OrRZ
 IoiofQqtz86YjHQXjcOf03tL2uGHei3y+Hfe38VSvNj8H9pmxhBFiv0Wh2SK6AedUnnuA0H+szA
 izW+Ok+20WB3RPgCKACEMvx0mcKxfv9AZ6BY8lV6oqbDW8loeCwlt/us2q/betZ8OHTYMGyCSGV
 YLk8258QeiCJYJstjGzYCgluy3LZ3KyX8hyYWN7X4obgld1PKMDDG1jVt82iA1cpcwTCcZFqdqK
 f8nc1/pFoDeiu5cMST5CphDyq2SK45lFTwPchT8ZXmtRib332Az0d7iSmKVXYBemBmllQ2chC/G
 94j+r608Blh3v8J6KGBVV6eHk0VkF7/BxSS4Vtr196QDbJdB7yTsYUPZ1s6knFtglGuSvHrnZRp
 P7huH1kn5ByRp9FGNh2I+7VGX9sa4nphgTlWNUxC02rSc1qhyizSVIMeBfas7asFbwX/ALCe7n+
 4W9WKVis+zO4rxRelLw==
X-Proofpoint-GUID: uaoG8qfql68Ha4I_kExK7fwOk16HLcuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250100

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

