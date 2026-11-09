Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794258387;
	b=VO9rRFKjYQ5CCw+MVXD8SWCd29HEkUPXBCZWJ4Ic6C8vngGcl8MNZ67caqbXx09iGawN
	 5Nn5FB59+GTMB8MGe4rZpDxPzZ2LVMZkAKWpoPi+xwMTwipEZ9yO5e1pxJujaeG4nkY90
	 N7cz4aOLLd3I2ZrF5BLYoOKSKdc5JpI1qgnKUQ10uVe9g9FyqOKl9f30+kTVWOvHurxd9
	 L40WLe2rPcK6uNPIVRTpC6zy8VGoEmptkrVDBt9Mj9GTlaOUA6Q/ll37uUEhvl3TdD5au
	 veGajvgR76AWy06M8cKu+wpz+gxdqMnQGxJT+zs0AMF8RAKA1aMRiqjO9MDb7JtNmMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258387;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=x2CrBJo5T7CTQ7QCFmXsbH0Vts7TDO7m2cx6l9YR/nA=;
	b=PKDS9YE2pFADxPev547hGN/HGLyXQ88tEsIm/2h+UF5ykQUxKrNL2UQjXvkudrmqEQ8n
	 wnKtPt8ZxLyI1BYv/81xKzPS4YRhPwyrAUbfHS6KgmSuGkZ2Zfvdw07n+xmSKfTpqO1Aw
	 2hoyVXLyMPZoYDnt4RAlJ0hTVFesLcNb0q/D3ZqUG3q3WY7APRjDnt9yawVaf6dOFb8LX
	 fPw5YeK7o487fc6oyjoCTB6wa1sqeq+txoWOiPT4O7E8s2IzttU5PPyzDeVqdZglZGiNq
	 DKAXDJN/Htqv7lCZJYUkOvZ0bWzYk23/B1O0zlggj7Moru7rVwWxloV1Q3Im17RslvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CWg0nH9s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.8
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF178606A32A;
	Mon,  9 Nov 2026 21:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF178606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CWg0nH9s
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzviRgipwV1rzPUFX9F1U/GhTi5wI6SNyOwFjnxj/KW0eF05fYQ1Ck3fOWUlS9LmJuhL481iUk+c/RW84yt8SYzVe4i44xgIESiLQ5FtpO/GCZrL8RltUhm7mbgKgGVHhOSfYCNtqxOxcOodHlHyQTeIeVswIkCLCJWVkSjbR0qlOJ+sHoo5ZA1ql/e4Wv0PekeEX6rHVh4Q3gpfHUXn9BjTALLlig6uS5ylAD7RbYfiC5Ow1ISwh81sl61Oo+/0nh4mLVodJ4MH7xmj9K9wat+bAhTI39rnmroug0MuFFCd2Zca5GObeC+9+rVix6hzs4l37fgHu/Ml88h56pmUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2CrBJo5T7CTQ7QCFmXsbH0Vts7TDO7m2cx6l9YR/nA=;
 b=r1eHz+fMdvhMTXPYKrjLnL22PkFuKYaPEYIHUq8qUkxALudt5yuU7MHMeDobFmFn/3M7NCYvqt/kIBb84IEUFcg15sL4sFq3KdQVIuB6iLm8ybJlnqGqAigdsDNaf0KfkVrTC92t7WVWABwVD7xhrpmrW+UERzzfToPecNtfgb7cst49IqwCom8+BEpwgjI1IevI9bWd9YnxFPgFsdkKzIgWkgD0e2Ewr3kg1VdPMyIJ4GVBb1yVtMJungDSw6fU6Uy+Mu/891Qk8ixULp05zZGEvX8j7lNJOJO8eESQtNG/2TMr8DwUHLQu5yTuTfkBjdLxvZbCttzDsAG9u31cWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2CrBJo5T7CTQ7QCFmXsbH0Vts7TDO7m2cx6l9YR/nA=;
 b=CWg0nH9svLr0TKFWZE7dJKOdknz4diIXYyj/tSXrOxWh1voQ84n9DVEBD4koV/XlUm+aA7lBF2v/ZcJo3m3qvxICuCTtoIr+EDJOwziql6A3IcUgp9LC62u6UUBzqZotodDw5weFo34Vdu8KjFId6PV7YAh5tJhvtojr6mt81cU=
Received: from BN9PR03CA0737.namprd03.prod.outlook.com (2603:10b6:408:110::22)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 21:06:19 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:110:cafe::66) by BN9PR03CA0737.outlook.office365.com
 (2603:10b6:408:110::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 21:06:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Mon, 9 Nov 2026 21:06:19 +0000
Received: from nigeria-2635-os.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 15:06:18 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<seanjc@google.com>, <peterz@infradead.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <ardb@kernel.org>
CC: <pbonzini@redhat.com>, <aik@amd.com>, <Michael.Roth@amd.com>,
	<KPrateek.Nayak@amd.com>, <Tycho.Andersen@amd.com>,
	<Nathan.Fontenot@amd.com>, <ackerleytng@google.com>, <jackyli@google.com>,
	<pgonda@google.com>, <rientjes@google.com>, <jacobhxu@google.com>,
	<nikunj@amd.com>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH 2/2] x86/sev: Add per-node RMPOPT windows for >2TB systems
Date: Mon, 9 Nov 2026 21:06:08 +0000
Message-ID: <5a2ab10ab9bc50c2f27bfd432ea30b0219ec397f.1794257678.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793921823.git.ashish.kalra@amd.com>
References: <cover.1793921823.git.ashish.kalra@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3bc93c-215a-426d-89d4-08df3ea54d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|36860700016|82310400026|921020|11063799006|261021123027099003|56012099006|261026121527099003|261021121427099003|261022075727099003|261009223027099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PdSNSaR7OrHCVjzJb0EDJKG672CUMGcTUJtI5wkZY8tYfWvVyxj3nWUe8EmNnUZjqDzBBkkb0MxwGOqY44cQUz5a0kRTyriomlVPDoDfDuY5Ezbk12ob6STT5Hb/uCCGLW4HCy8ib5lXokI+yyu7njhgZPIsUv3sGDnAx+MGXRguaVQnMK6JwjTP3FUa/bXlnC1qjOqnSBNYmEMbkSGQQ17J0UUDN8qYXFQjsJI533XSpNP97I3A8ChJLE4fXHzERva4mNS8S7/FYPrhG+hvPy1ED9FG/0KgzGHMOmTja5yLKcjgp8BxKZ0lMG1H7B6O1mXGRRjMDi/VDyNFuxgA1n4ALnhYyiyHrMae0CYevZAjdXDv5G0oZt2x7TDay2x94YljAC2wl9weRGZkuiArN6TXsuL9DvAgC1wkZeOdQKfIAoN0y9SjSK0qBm04J6wUQRzNDxVt9J6yNuwWHM1v8YTviTJqmoNj5/vi0hBDKXo6QK4KbdKZN/i8uGgDO5HIXr6/wLloVOO//9nvNX8z3beNB4PvOEBzx9hGOdLBXYMXKZjC3MMQaTDC27lKESVZCv/ujvWIJyJXREiOJgUEHK+kE3v6KezifU0e0jk6mhvgxAHcm95Ud7tFC/w+lI9tXglDwaOJB7ekLp8KhNeNxDH97o+aFkN6f9bMJKfuwaSWBsD9YOb9bQr3ri40d9pV+tArczJfU8zzJtQJCF9Qm40LgFuSpYCUO4nO7fVflIfM31dy+K1q9DaBHBrmR/Ss
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(921020)(11063799006)(261021123027099003)(56012099006)(261026121527099003)(261021121427099003)(261022075727099003)(261009223027099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZFOrDFcBhDa3OQZfM0MsFr0McwWhlpsRSmYlySmd1T4VOX/OfFT9irqFNOiq371O7YIRs3Nqzo6dzbzgKgJ2m95tR1rvne3WvoMk9jGEVs7/+IzNi/Q2oSrzRAcFwjWQ7/Xgf7vZnJbWJBjMRMyTgRTfOKeusws0StgWYS9mXQUvCeoIpCw5NWmYcKdZnRBJqRfknXmjMtjtuVkHfVwSC9w6wO7UI/sHES0/sse/fXg/g2XmeFl/cKnz495Gq6fh/m2OYXJZGCNjgYJ/2tFbTegyWzFk9JIDk/sEUH7tejIBdgvKBiJhIR6FU223jn+AC4BoMlbiGqTD99ZrVT/etQ6DwVIorxT4utHTzCinZu3Z+o+FIBpIC6z1b58amHdC75G8AIrDNx9eeeDhpDEF82CRnAzWRBy2XjrbTrmF0qjJXCGFQ5X66tHmMED0HdVG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 21:06:19.7660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3bc93c-215a-426d-89d4-08df3ea54d58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601

From: Ashish Kalra <ashish.kalra@amd.com>

A core's RMPOPT_BASE covers at most 2 TB of physical address space, so on
a system with more than 2 TB of RAM a single shared base leaves everything
above 2 TB unoptimized.  Give each NUMA node its own window, placed over
that node's local memory, and program it on that node's cores.  A core
overwhelmingly accesses its local node, so spending each node's 2 TB budget
on its own memory puts the optimization where the accesses land;
whole-machine coverage is the union of the per-node windows.

rmpopt_find_best_window() picks each node's base with a sliding-window
search: it slides a 2 TB window across physical memory a 1 GB at a time and
keeps the 1 GB-aligned base whose window best covers that node's own
memory.  When all of RAM fits in a single window the search returns the
start of RAM, so all cores share one window as before.  Because the
per-node search is bounded to the populated physical address range and
accounts for unpopulated regions explicitly, a node's window never falls
off the end of RAM into empty physical address space.

The warm-up then covers every window.  A <=2TB system has the single
shared window and is warmed once; a >2TB system warms each node's window in
parallel on a node-local core via schedule_work_on().  Either way the
warm-up runs with interrupts enabled, so the expensive first (uncached)
pass never runs in the interrupts-disabled fan-out that follows.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/virt/svm/sev.c | 149 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 137 insertions(+), 12 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index a2756b18d5f7..1ed1fba3b62d 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -134,6 +134,9 @@ enum rmpopt_op_type {
 static struct workqueue_struct *rmpopt_wq;
 static struct delayed_work rmpopt_delayed_work;
 
+/* Per-node warm-up work, used to warm each node's window in parallel (>2TB). */
+static struct work_struct *rmpopt_node_work;
+
 /* Software RMPOPT facilities initialized */
 static bool rmpopt_soft_init;
 
@@ -146,6 +149,9 @@ static bool rmpopt_soft_init;
  */
 #define RMPOPT_WORK_TIMEOUT	(10 * MSEC_PER_SEC)
 
+#define RMPOPT_GB_WINDOW_SIZE	(SZ_2T / SZ_1G)		/* 2 TB, in 1 GB units */
+#define RMPOPT_EMPTY_DISTANCE	255			/* SLIT "unreachable" */
+
 static LIST_HEAD(snp_leaked_pages_list);
 static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
 
@@ -632,19 +638,125 @@ static void rmpopt_scan_range(void *arg)
 		rmpopt(pa);
 }
 
+/* NUMA node backing the 1 GB region at index @gb, or NUMA_NO_NODE if empty. */
+static int rmpopt_gb_to_node(u64 gb)
+{
+	u64 pfn = (gb * SZ_1G) >> PAGE_SHIFT;
+	int nid;
+
+	for_each_online_node(nid) {
+		if (pfn >= node_start_pfn(nid) && pfn < node_end_pfn(nid))
+			return nid;
+	}
+
+	return NUMA_NO_NODE;
+}
+
+/* NUMA distance from @node to the 1 GB region at index @gb. */
+static unsigned int rmpopt_gb_distance(int node, u64 gb)
+{
+	int nid = rmpopt_gb_to_node(gb);
+
+	return nid == NUMA_NO_NODE ? RMPOPT_EMPTY_DISTANCE
+				   : node_distance(node, nid);
+}
+
+/* True when all of RAM fits in one window, so every node shares it. */
+static bool rmpopt_single_window(void)
+{
+	u64 first_gb = ALIGN_DOWN(PFN_PHYS(min_low_pfn), SZ_1G) / SZ_1G;
+	u64 last_gb = ALIGN(PFN_PHYS(max_pfn), SZ_1G) / SZ_1G;
+
+	return last_gb - first_gb <= RMPOPT_GB_WINDOW_SIZE;
+}
+
+/*
+ * Return the 1 GB-aligned RMPOPT_BASE for @node: slide a window across physical
+ * memory and keep the base whose window covers the most of @node's own memory.
+ * When all of RAM fits in one window, use the start of RAM.
+ */
+static u64 rmpopt_find_best_window(int node)
+{
+	u64 first_gb = ALIGN_DOWN(PFN_PHYS(min_low_pfn), SZ_1G) / SZ_1G;
+	unsigned long own = 0, dist = 0, best_own, best_dist;
+	u64 base_gb, best_base_gb, gb, last_gb;
+
+	if (rmpopt_single_window())
+		return first_gb * SZ_1G;
+
+	last_gb = ALIGN(PFN_PHYS(max_pfn), SZ_1G) / SZ_1G;
+
+	/* Prime the first window. */
+	for (gb = first_gb; gb < first_gb + RMPOPT_GB_WINDOW_SIZE; gb++) {
+		if (rmpopt_gb_to_node(gb) == node)
+			own++;
+		dist += rmpopt_gb_distance(node, gb);
+	}
+	best_own = own;
+	best_dist = dist;
+	best_base_gb = first_gb;
+
+	for (base_gb = first_gb + 1; base_gb < last_gb; base_gb++) {
+		/*
+		 * Sliding-window optimization: the window advanced by 1 GB, so
+		 * rather than rescan it, drop the region at @leave that fell off
+		 * the bottom and add the region at @enter that came in at the top.
+		 */
+		u64 leave = base_gb - 1;
+		u64 enter = base_gb + RMPOPT_GB_WINDOW_SIZE - 1;
+
+		if (rmpopt_gb_to_node(leave) == node)
+			own--;
+		if (rmpopt_gb_to_node(enter) == node)
+			own++;
+		dist -= rmpopt_gb_distance(node, leave);
+		dist += rmpopt_gb_distance(node, enter);
+
+		if (own > best_own || (own == best_own && dist < best_dist)) {
+			best_own = own;
+			best_dist = dist;
+			best_base_gb = base_gb;
+		}
+	}
+
+	return best_base_gb * SZ_1G;
+}
+
+static void rmpopt_warmup_fn(struct work_struct *work)
+{
+	rmpopt_scan_range(NULL);
+}
+
 static void do_rmpopt_work(struct work_struct *work)
 {
+	unsigned int cpu;
+	int nid;
+
 	/*
-	 * Warm up the RMPOPT cache on this pinned per-CPU worker with interrupts
-	 * enabled, so the IRQ-disabled fan-out below only issues cache-hit RMPOPTs.
+	 * Warm up each window on a node-local core with interrupts enabled, so
+	 * the expensive first (uncached) pass never runs in the interrupts-
+	 * disabled fan-out below.  A <=2TB system shares one window and is warmed
+	 * once; a >2TB system warms each node's window in parallel.
 	 */
-	rmpopt_scan_range(NULL);
+	if (rmpopt_single_window()) {
+		rmpopt_scan_range(NULL);
+	} else {
+		for_each_online_node(nid) {
+			cpu = cpumask_first_and(cpu_primary_thread_mask, cpumask_of_node(nid));
+			if (cpu < nr_cpu_ids)
+				schedule_work_on(cpu, &rmpopt_node_work[nid]);
+		}
+		for_each_online_node(nid)
+			flush_work(&rmpopt_node_work[nid]);
+	}
 
 	on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true);
 }
 
 static int __init rmpopt_init(void)
 {
+	int nid;
+
 	if (!cpu_feature_enabled(X86_FEATURE_RMPOPT))
 		return -ENODEV;
 
@@ -654,6 +766,14 @@ static int __init rmpopt_init(void)
 		return -ENOMEM;
 	}
 
+	rmpopt_node_work = kcalloc(nr_node_ids, sizeof(*rmpopt_node_work), GFP_KERNEL);
+	if (!rmpopt_node_work) {
+		destroy_workqueue(rmpopt_wq);
+		return -ENOMEM;
+	}
+	for_each_online_node(nid)
+		INIT_WORK(&rmpopt_node_work[nid], rmpopt_warmup_fn);
+
 	INIT_DELAYED_WORK(&rmpopt_delayed_work, do_rmpopt_work);
 
 	pr_info("RMPOPT optimizations enabled\n");
@@ -665,8 +785,9 @@ static int __init rmpopt_init(void)
 
 void snp_enable_rmpopt(void)
 {
-	u64 base, pa_start;
-	int cpu;
+	unsigned int cpu;
+	u64 base;
+	int nid;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return;
@@ -678,15 +799,19 @@ void snp_enable_rmpopt(void)
 		return;
 
 	/*
-	 * A core's RMPOPT_BASE covers at most 2 TB.  Program every core with
-	 * the start of RAM to optimize up to 2 TB.
+	 * A core's RMPOPT_BASE covers at most 2 TB.  Give each NUMA node the
+	 * window that best covers its own memory and program it on that node's
+	 * cores; for <=2TB systems every node resolves to the start of RAM.
 	 */
-	pa_start = ALIGN_DOWN(PFN_PHYS(min_low_pfn), SZ_1G);
 	rdmsrq(MSR_AMD64_RMPOPT_BASE, base);
-	if (!(base & MSR_AMD64_RMPOPT_ENABLE))
-		for_each_cpu(cpu, cpu_primary_thread_mask)
-			wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE,
-				      pa_start | MSR_AMD64_RMPOPT_ENABLE);
+	if (!(base & MSR_AMD64_RMPOPT_ENABLE)) {
+		for_each_online_node(nid) {
+			u64 nbase = rmpopt_find_best_window(nid) | MSR_AMD64_RMPOPT_ENABLE;
+
+			for_each_cpu_and(cpu, cpu_primary_thread_mask, cpumask_of_node(nid))
+				wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE, nbase);
+		}
+	}
 
 	mod_delayed_work(rmpopt_wq, &rmpopt_delayed_work,
 			 msecs_to_jiffies(RMPOPT_WORK_TIMEOUT));
-- 
2.43.0

