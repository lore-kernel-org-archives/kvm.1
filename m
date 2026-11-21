Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795282536;
	b=Qmm7SKV0ubLOrx61bDJDvhsw9WDzZykcel+AZ4/JeknLlp+y4rdC76ufta7N1NqtsYqT
	 yZm5QS7tLKpjZk0tYoH+iZINmfeZPHKoHGCNbJdBM0DLajsS9j2ksnmvzlfI0amGHhKIQ
	 EJHBEpACXP2I29rR7yJNWQOzdvdZHRIVQr+59ZGyHleT3EcRdvQgAYb3zKUZf/3/BnXL2
	 jNBHEXyUZ4xI4f2iYuimSUMlanPC2AorjkHkWvfrX0WI0L0y+n8n9TEFJKrxFJPmPCBn5
	 4OEEhWFcqlk23VUkx+fZcnlAIZ5ymLl5qjfdzHiSWji7a+M/FMs5Dh3tR3J+tL/UzSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282536;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qHeKLgNV4yAZV7ckWSm2dWZylQww6/FiZgK96BZQmJQ=;
	b=kiBkHxLdvPjsnrdm8aKzittQlzGKvh4p6lKGdqMMHr8I1aRADN3X/bsIQh7AgF9KQde/
	 M7TaMhcK0qVKPc5SgUBW8lGixtpLrlKk0m5eI0KXIg7j9IvcizS/toSDTQe3k8btdzPR0
	 S/jk2/sEucJBDwozVnKQplD9WUWSmKV6ccGCESUPDA99kU7NDCZT2YqgNkb+yFbaEtjcA
	 deHIMdIxKuSLksMhW1nWE61tY/7Qf6gYgES+Lmh8u5FAKIfqqeeLFDG3rHBrLx5f4/Csr
	 6dnJbMFCDhgobG/NPevRgigsY6PBa0pUxk7z7ZwkEVvGFS4cQlHHxtzaX1vrUgyCaiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=OJ1iPKyd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.120
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021120.outbound.protection.outlook.com [52.101.125.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94AC606A339;
	Sat, 21 Nov 2026 17:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E94AC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=OJ1iPKyd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8QDDeEIjySf2mUnas8yPEg1hOLxDn0pSShhorNxQOq0em3YHMjB10HW09Iox1A/W0lR5LY1NnrSmCqzNogyEjtoryc6wMWSYMv6sfmTX5AVmYE4f+/BioXI99196J4Da1TavlONiQ9J2mWb+TOK2VMMKWAPSDg2GeIhpqQNBfKPza4rdVrERW/5DqfniLZLm0F89yyNKEvV4NzilZ+LvgG7pt8yYsC5QudtcjA+iheUxROzE4LYDdUcISF8T6LaI7uaWvBXi+D0+37Isr/CCzOq8IS6GnC4Cay3IT/L9zxhlsp1D3PARfJzeKehqRFlmywvcBSGnYg0Ms/hR36J4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHeKLgNV4yAZV7ckWSm2dWZylQww6/FiZgK96BZQmJQ=;
 b=mMJAP92nmWJ02158Ev92jhv3EqgMPOPLVALwO5ks3YZlVJdCsHE1IO41dE9QWtdMWmkojlFx/Oy2j09a25I0uwXct9XrhPd8POEgNMhKlH6Ne3tCf/xLIhdEbGYZQtn3UPotYkveqaz7ZdCvnQlFHdyDsP/pQWM6JoCGzS2XztwKXKeWk8lKcpT5nxhzb9tEP2ihiMaDWGt8pZXEwskXcuuKHtZs8/19wRTq989rqEBOqO5Jgelu39S1O8zjzbodZStEe8R3xYy6lefS48i6HF+RqMh9B+5Tdtfw8WkW6Upp4P6p39rHiE1J9oLSJJzlaXwdtaWUAuJzLQbY/2vntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHeKLgNV4yAZV7ckWSm2dWZylQww6/FiZgK96BZQmJQ=;
 b=OJ1iPKydXCk9bLJPzdZywoZ2aC4IWFGzUuyiCq2LMRuJx5pZOCMqPiM9xKE87uWV4cFOLlQ3gsGM9inFWN6480HWGzyBg6iw82bQohNa/eZqqge3s9J81RoDuI0kiGtUNj7ozBfLv5c8JobzuABgaSHcBmFz6CfKK0oEg297YZA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB5134.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:30f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 17:35:33 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0639.012; Sat, 21 Nov 2026
 17:35:33 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <andrew.jones@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Bingyu Xian <shanbeeyoo@gmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] RISC-V: KVM: Batch user accesses when updating steal time
Date: Sun, 22 Nov 2026 02:35:25 +0900
Message-ID: <20261121173526.892344-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261121173526.892344-1-den@valinux.co.jp>
References: <20261121173526.892344-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: f59d5496-574b-49c8-fc71-08df47f5d82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024|23010399003|18002099003|22082099003|56012099006|261028144727099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261026135527099003|261026140227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jDrb2+1hj77WyjXftO9mQssQzBVE3HTwbAVZ/TX1sc1Xewz9dE2cVRpAFKmD3xOZHhhpJk3e/p5tulWcX8rz/ZP8wvlxcEUKxwsdCtJ63I+JGs9O8kqrFsBpjPa+tljvZRYSzTvnaBomEa9AAMcGkJ4ZXgU0pClyqMJTIrhxhTp0YngAA6Bp+LoAyeJfy1AagcYperEL3BE2FH/njoYm4xhvxEFIAnCmu8dl/qwl42a81D1urmo7n0TR9X6cS5LBU0YwiSrKkwZN94GDHW2fwh2Tw7oi7K7BWSddGFAVhdtniSL1a25te9Fn7WYEM939ye3G1Xa4JfXpBJo+0Hs+Q7O6Y+gNUgfKnQ7wyvn5dk8d8n8DWlbsTS8S/GP/NrvdPbXfHrxddRuMSbt+jilQvuKJFTTKBxcgs/NNwDUhiSvjjHGO8d49YawfOfW4o/K7RANsjnLV/L2zWnfTsIjfXq2E8jVH994/S8+8q2/k83EcQMNXv6RhyjyguFm5EElVY1NsBKSwNUwyQfumg1BB25iRxELAL0BaBpWwUDdflIBhWlscYfthbQroiTDiLUAV1grkipEmaOoi/Jr1Aha8C1mQ3YQMX6XA5qb7UtebcL9FBs6rEoDHPxCRNmaa97am
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026135527099003)(261026140227099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KvQ1qIb8LojWxv52wZUwt/6AFlynX70uGSAhbpO00heGb1TE+Pa4/p8arXtZ?=
 =?us-ascii?Q?2eTF5+PJW/TiBUNWvZjaI7lAD9f2GFGTa2Geb8S4rJ49G/hszDO2Cc1D3JOc?=
 =?us-ascii?Q?BTvi+8THI8RWIEpvc8Du11XT7g0U2xbHAwFwFsluJNYav+9SYvERrR3KO6rd?=
 =?us-ascii?Q?v89gSkSf8qKR9Guz/ETKEtBVe7TRp5Q2abG1uAyq+vSv69S643slwCpJreXZ?=
 =?us-ascii?Q?xldSVpUqZ+gi7vjL6Nvf9ZLjEtj0aux43sB2FH4BrxgRuql4Ctx/XoYjlGEY?=
 =?us-ascii?Q?TTniKWerlQPaUMboA+sSWucxGbvYs1HCHCCSzU31HLibW4UoCOQiHTUncm8L?=
 =?us-ascii?Q?m1UA1rrItaPM8+wisSnXLLHIAj81crdVZWvHINjBf8hceZzPcRD+I3nTJuNg?=
 =?us-ascii?Q?nTyCOfpI9e1448aB/EsnftC8Qj+wkZ9nX273hom8U5R4Cebld/wCqm07+AdP?=
 =?us-ascii?Q?+FqlpUfOWm7+RhcgAtUyjAWvEE5J+LmKUaru1MeugtXn8uqMECgcFaujc5EH?=
 =?us-ascii?Q?G2V6oZjBaVKa+dSl0kRAoD+PCYjd6I86wAUIbfasf9n//55lpPrykm3mDP+X?=
 =?us-ascii?Q?jAZn9CTSu2Uih4k/KGvOYgEQfpXAyUG3Q9Lb0mb9WuwCaazqym3SZtp2SPrj?=
 =?us-ascii?Q?Qm2VeKRy+V0CRSvT+FqcSOULUPZuT9cm+MAyPN8nKVDoHKhxYOEwveDwBELW?=
 =?us-ascii?Q?Y0IJkwfkXs4y8RQSJMdh3ZnR9HnXxXllGriLhzuWVaWmZBfaW48YOKqcaXQ8?=
 =?us-ascii?Q?ieUUW71WWdZLmiBMp6zO1Id8xVlc4fkDDU0e4A/JVyqi2IfSy5oDOa4y6laR?=
 =?us-ascii?Q?kLFyzIfa3RSWXEL6jOsk8pX92rMspoI01fFhABo8WCDxnGGjbQ1M6K0HQc+k?=
 =?us-ascii?Q?Eyx3tYXOrLpy0S23ws/mGX82Dq4pp1boBjjzR4z9qMSpF1kDGNqgr2gMf5/9?=
 =?us-ascii?Q?bdSfygv/TVMqnc5Tuqq8rhRSeVe/EJ/K1s+t8VVn4Y6dPVcwKKGMiZlQqNan?=
 =?us-ascii?Q?V+kpPto1WiFS9DIlDdRxB2plmBaBiuZeeVpBElb/BY0vIOk6zbx5m5n2ONwz?=
 =?us-ascii?Q?ToFuGKHZ/eE8Liq5cTKEpzA+vSujfhKIOdH6n7vVXmrr13rmbk34NceTosrs?=
 =?us-ascii?Q?8hVwbiWZl8LFJui4FylN6yHSt8QbzgiXFO4+Xqh47ya9Ki2afxPI8TA45IKR?=
 =?us-ascii?Q?VLXII6erF52XImo7NsWw6J2fWqc6vWaZNOzbASdyyR4BKHtA2q/Z8PCFobaT?=
 =?us-ascii?Q?3QDS9wDCpT2iJaNTatZsR1bIkwzU7h69rKrYuMJ5BaMPGPGigp7EO6aYzGL4?=
 =?us-ascii?Q?IbewkaZaNWxPkMcVNIS787oiFRIt41ZTQWyxR1/Yjr+lgbqZSiGABROT4INQ?=
 =?us-ascii?Q?FDC50sxNiNZaDlDSYDHuSBmRxk/e0IQdp/86eaxdPCuGExLlytadWpeaHcuy?=
 =?us-ascii?Q?Ettmyj1DQz/1TyWYjaW23MZEpHnKl+BVinI2+VsSN0qLEP3gaafMtk9iaNuW?=
 =?us-ascii?Q?hEmGb8qbia8mKDcNpknas6B5x1RRhMPlFDySrU43k26M5KwUi9F0Z/2/H6XO?=
 =?us-ascii?Q?Sf4sWd9faf6sRELxDx1vaxD9J7aYIbTITPEdX9SjEDMIhd/pjK7MKTFw7dz4?=
 =?us-ascii?Q?RCiOp749Uj/bC9VxiUFVWIeu4nCgMYFRe52Dz5WwNPnGekxAKQTv4Jr9rnkU?=
 =?us-ascii?Q?2tzU1aRAHtDSQnYSngnH0lCL7A4P7WLcN5iO+Zrgu+aOBE9u1xVwS0n4DPHc?=
 =?us-ascii?Q?u00LlLR5ZluxrOZlu1sbJfUu9/v0iMMLFbj9GFwbR8Rx8OhxJ4NN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f59d5496-574b-49c8-fc71-08df47f5d82b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 17:35:33.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWbrzFKqxQwU0QuLkmUIoNO8Z/3+gZjLYagqeppa5udM8E5gS3e3ntCpyr3NyREiUdepcNkUGpQnOYOn3vhAuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5134

Updating the SBI STA shared structure performs 2x get_user() + 3x
put_user() calls, each of which toggles sstatus.SUM.

Keep SUM enabled across all five accesses to the shared structure.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v1:
  - Drop might_fault(). (Andrew)
  - Use scoped_user_rw_access(). (Andrew)
  - Use le32_add_cpu() and le64_add_cpu() to avoid the extra temporaries.

Note:
  - I haven't carried over Andrew's Reviewed-by since the scoped_
    conversion reworks the fault paths. Would appreciate another look.
  - As in v1, I kept WARN_ON() for uaccess failures.

v1: https://lore.kernel.org/r/20261118062242.2914385-2-den@valinux.co.jp/

 arch/riscv/kvm/vcpu_sbi_sta.c | 60 +++++++++++++++++------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index f1be90b514b2..68d54696dbae 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -8,6 +8,7 @@
 #include <linux/kvm_host.h>
 #include <linux/mm.h>
 #include <linux/sizes.h>
+#include <linux/uaccess.h>
 
 #include <asm/barrier.h>
 #include <asm/bug.h>
@@ -15,7 +16,6 @@
 #include <asm/kvm_vcpu_sbi.h>
 #include <asm/page.h>
 #include <asm/sbi.h>
-#include <asm/uaccess.h>
 
 static void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
 {
@@ -27,13 +27,9 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
 {
 	gpa_t shmem = vcpu->arch.sta.shmem;
 	u64 last_steal = vcpu->arch.sta.last_steal;
-	__le32 __user *sequence_ptr;
-	__le64 __user *steal_ptr;
-	__le32 sequence_le;
-	__le64 steal_le;
-	u32 sequence;
-	u64 steal;
+	struct sbi_sta_struct __user *st;
 	unsigned long hva;
+	bool updated = false;
 	gfn_t gfn;
 
 	if (shmem == INVALID_GPA)
@@ -52,35 +48,39 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
 		return;
 	}
 
-	sequence_ptr = (__le32 __user *)(hva + offset_in_page(shmem) +
-			       offsetof(struct sbi_sta_struct, sequence));
-	steal_ptr = (__le64 __user *)(hva + offset_in_page(shmem) +
-			    offsetof(struct sbi_sta_struct, steal));
+	st = (struct sbi_sta_struct __user *)(hva + offset_in_page(shmem));
+	scoped_user_rw_access(st, no_write) {
+		bool wrote_steal = false;
+		__le32 sequence;
+		__le64 steal;
 
-	if (WARN_ON(get_user(sequence_le, sequence_ptr)))
-		return;
-
-	sequence = le32_to_cpu(sequence_le);
-	sequence += 1;
-
-	if (WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr)))
-		return;
+		unsafe_get_user(sequence, &st->sequence, no_write);
+		le32_add_cpu(&sequence, 1);
+		unsafe_put_user(sequence, &st->sequence, no_write);
 
-	/* Publish the odd sequence before updating stolen time. */
-	smp_wmb();
-	if (!WARN_ON(get_user(steal_le, steal_ptr))) {
-		steal = le64_to_cpu(steal_le);
+		/* Publish the odd sequence before updating stolen time. */
+		smp_wmb();
+		unsafe_get_user(steal, &st->steal, finish_update);
 		vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
-		steal += vcpu->arch.sta.last_steal - last_steal;
-		WARN_ON(put_user(cpu_to_le64(steal), steal_ptr));
+		le64_add_cpu(&steal, vcpu->arch.sta.last_steal - last_steal);
+		unsafe_put_user(steal, &st->steal, finish_update);
+		wrote_steal = true;
+
+finish_update:
+		/* Publish stolen time before the sequence becomes even. */
+		smp_wmb();
+		le32_add_cpu(&sequence, 1);
+		unsafe_put_user(sequence, &st->sequence, mark_dirty);
+		updated = wrote_steal;
 	}
 
-	/* Publish stolen time before the sequence becomes even. */
-	smp_wmb();
-	sequence += 1;
-	WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr));
-
+mark_dirty:
+	WARN_ON(!updated);
 	kvm_vcpu_mark_page_dirty(vcpu, gfn);
+	return;
+
+no_write:
+	WARN_ON(1);
 }
 
 static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
-- 
2.54.0

