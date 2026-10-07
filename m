Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD23B6C16
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380935; cv=fail; b=I6txXtZgHudv0sJvJmWBKwwFFQ+PzOEYRTkdqqfkSduqP7u0/ZeRK9FUHLNH65a8KiVHFSsi5mkQunPWwigXxt9Tk2roAxoQmBOtkgB+GL1VP9nJ4W7V6moqLZPB9FB6VkziAfd2mwwDXfbY1PtpPGFcAy/qdnqGsayiyhISygE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380935; c=relaxed/simple;
	bh=5PxmS8CkkexNc4op+c9Vdk0o3VsKuhnXYsUGidMRhDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXG16a4/l2kP0kY+HCFvsq5NT3tDxN8rdbpikPOvD1M1UwO6s/hjan1H8In/MnaxgZfy5f86yg9C13wxmyiq9Xronht9kqRR22mMXl2+ql4WHd2fGubnNlceim6mpG7WUciNZFgCcmjwgn/frL1h8jLIASTqU/Surr9N5nksNyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vs6BDCTN; arc=fail smtp.client-ip=52.101.46.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vs6BDCTN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpP/Y+cVvWzSd5fIr5y6pa7sKyKzHjT2G/9jUu9YOSWWp2m7l8Yod5un27GHWWFNc2G/yvixi9hqWcwzqyf/RObKlWMMwmLfISrFtRKq6kO5QkzYFnj2zBfgmdInYBc06asi3YyRSBr82bznlif5r6lPedr4z9I6R07s/k6VR31fhJictgn8LvZoOD70TLjKTZBHkRE4FfOR0mtc0q17wSncceLE5bXOlf0zpsxw5xdq32/w23tHH+1lV6go/N68pXo/G0Pzg4oIESf4Cv0pBo+kZwSrZm80VNXGNpvfpZINmaPUQxFl17kQfYTgroHHE6k54+NcJjeLWoAyjoYq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve6goKI93JmufcFnOkaUrpF+t0ucNSfu9oY8npEq3Jo=;
 b=DE19Nx7fm5m9g9Ko/TY6XymVNfWyfrnH9YlcZFEpdUznl1GsCADWwf0/jK6toiG+/NTSTfGEsAtxHtX0m1pIrqIT9NEZhvLVAuK5yCM3zzj0psxOGf9kDls/ZDJjfotlbPxwdkWIQw1UJ/5Tzn/DjWbQhiWh7LEnk5HfSoMGl48rlSel0P2GGJvPhP0IYDaM1s/EGri3efN7EHGJhcLe6QfzKsYm3IB33iJoQ6LojZWbF3vJSBLH/a22kxD0WaSBzAgBfJaZ4UvOSuFtv+liNc2dezVba9EQAuI8Q3+TU0Fq6OeH7JhWNDnZBtNJXiOR1c9Wq4pfGIRiFXVQGbAq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve6goKI93JmufcFnOkaUrpF+t0ucNSfu9oY8npEq3Jo=;
 b=vs6BDCTNJaS/RnZzKXZ7ffuUspsYM64AV+DjXVN+h8coR7S8UaJW9Sj4AwJAm6Nofz2MLmLODXVfjmxJwmSYQetW0p5UZqZQMvrXFnR45h7ae1F+mtUFer7jCDhi6CECtQClNSbTTRg6Sf6VImpPdfQ5L2umv/6zdI1p2Nm8yDo=
Received: from MW4PR04CA0241.namprd04.prod.outlook.com (2603:10b6:303:88::6)
 by CY0PR12MB628325.namprd12.prod.outlook.com (2603:10b6:930:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:48:42 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::57) by MW4PR04CA0241.outlook.office365.com
 (2603:10b6:303:88::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:48:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:48:42 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:48:40 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 03/19] accel/kvm: Fix handling of MMIO holes at start of conversion ranges
Date: Wed, 7 Oct 2026 08:41:27 -0500
Message-ID: <20261007134323.1606088-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007134323.1606088-1-michael.roth@amd.com>
References: <20261007134323.1606088-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|CY0PR12MB628325:EE_
X-MS-Office365-Filtering-Correlation-Id: 484a0055-400c-4197-8a88-08df2479b347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|82310400026|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B2yrA7CYHwy0upkfim5cGGcXm8Qb/wzH3RzU6VYPpClsPHyL/G+LnAvc2RJeKYD5hR2rXKfjYKzCqt4xGJBZ3TfR3niELrkCbLRuKk0RUMFVdpmBHNw6KEae/L4BcBdq+HjztQY+DzWp0Rf/opb5OZcpeofzMXQS+VRYnl4Ka41ENFZxrjYjJWcGHLpiC5uWvohpZW8tHCthKVJ1mn1xEfHfolmRY23GIQrFP6lLsL3wPBeGeWBR87p+kSFkHkGlYWC1QbubSN3ePVsPdlm9OQdpUZZw+8DSkZPXlkYzl0jGmu/HVClNp3wGnum+cJCqBKRUAgX/oGwuMQysqo3IDZXpeX+KehqUoosLavQCfkz/3G2ONV1Pv2GRmqva63YWBaYg9N0153S++FomCvZqZc9/tklEWTGTiPHWuMctLgv6pAEnQLrcoE4i6i/9a+C+eidoW0xdZyVWGAw7VbqCjMqB+dF9OjydGQpuyEUuzD5eMTKiiuWuQaMhNKAUQUd3Il1TAUcD0wiVv1SjZHDpBa8TenwaoIM+IenOK9Q9GTOnZK9fTjkCcGygPJeRL6ns1msLTk5nx6EOrqvOfaf5vKtqrSeXE7GpVWiXOyuUeKsgZOItC2AASst7dHIDOj6Il54LHJYKumxdDyDGP19E0eMiigUK5ViAyQjiGiVj7QI4lmynNMeW7/ZqUncArbaItnQbK6Ieloq3gZ8d51KABQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OfiKCn3G93DfbUUJyaeErWaszEvgxgFGsxyEGpB4zQa5SVJQPmp6z8KOSjjAOjEb0wu/FExSCK8tAljNqMrHMah0aUfdu8J1cYdX31pBY4/ur7XX7kgzrRLMcncbw+XiaeA1pXgKrxFPRauzQNHDe8L6aR0OTZi/AZeCFTvWLe34o8FhHoxIfY8ZohiCl8+t87XKpRa19JsJQTf3JSNZzTx9w0ddPIR83GBNSW97CL3b4slIOpKnocrSXVuJIHD3ldb0o/QWyzYcF62NJDoFTDh3MoB3eOLCTwlV+dj96yEp9eIGfu5xg/YAjfnczKhOVYipuTX6ejYlE9OJX9wFHeoTqZgVhJvvfT7+C03LVWDrb6Buxsby8OzXCqCmIeG9jz7DfGVmQQrEmhCP5JRxpjtMIX6E8PgflqOmbtFPMYTfphXJWCgMwW+vf3bxDbHw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:48:42.6094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484a0055-400c-4197-8a88-08df2479b347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB628325

Currently MMIO checks are done for ranges where memory_region_find()
finds no regions within the entire range, or for cases where
non-RAM/ROM regions at the beginning of the range.

However, if the first region in the range is a normal RAM/ROM region,
then the portion of the conversion range that overlaps the region is
processed normally, but any MMIO holes that might be present at the
beginning are ignored, so the checks are bypassed for those ranges.

Plumb the 'start' GPA that was used to query memory_region_find(), and
pass that into the MMIO-processing helper so that these gaps can be
detected and MMIO checks can be applied appropriately.

Fixes: c5d9425ef4da ("kvm/tdx: Don't complain when converting vMMIO region to shared")
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9ba8462f5d..f0a79c9bda 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3344,9 +3344,14 @@ static void kvm_eat_signals(CPUState *cpu)
  * non-RAM/ROM region that should be skipped as MMIO. In the latter case, the
  * 'skip' parameter will be set. Returns < 0 if the conversion request is not
  * valid.
+ *
+ * 'start' corresponds to the starting range memory_region_find() was
+ * called for, and is used to determine if there are any MMIO holes preceding
+ * the region passed in so the appropriate checks can be made on those
+ * ranges.
  */
 static int handle_memory_hole(MemoryRegionSection *section, bool to_private,
-                              bool *skip)
+                              hwaddr start, bool *skip)
 {
     MemoryRegion *mr = section->mr;
 
@@ -3391,6 +3396,16 @@ static int handle_memory_hole(MemoryRegionSection *section, bool to_private,
         }
     }
 
+    /*
+     * At this point it has been determined that the region is itself
+     * can be processed as normal memory. However the caller still needs
+     * to know if there was a preceeding hole relative to 'start', so
+     * handle that case here.
+     */
+    if (start < section->offset_within_address_space && to_private) {
+        return -EINVAL;
+    }
+
     *skip = false;
     return 0;
 }
@@ -3475,7 +3490,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         assert(section_end > start);
         assert(section_end - start <= size);
 
-        ret = handle_memory_hole(&section, to_private, &skip);
+        ret = handle_memory_hole(&section, to_private, start, &skip);
         if (ret || skip) {
             memory_region_unref(section.mr);
             break;
-- 
2.43.0

