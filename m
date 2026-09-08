Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4143CEBBB
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901124; cv=fail; b=Q2qSc6QalD6KSnTLGP5J8/5K6IUoWcZq5Vdhp89ST7TZMiaMd9+HzrVKdXI07PHQJljptt14hKfIDI+/g+9Tggze0kLzfGEyRkU0372xWAQjamfcUwGpQSH8Qy9Dkkrv1RIXdRHDmk6fIbeW2GY6Qc8yFCohChU10vysklF3WgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901124; c=relaxed/simple;
	bh=uh2CLz8sKs/ojku9m+ra/ehFMEGk/P+wIg8qGVg/Nws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TI6JJGHWJD/arLT/VHVw5BJDU/I5BDuE50OeoQXMdgnV6KOoC60BofiETnfhbna44SQqPDGyLmCJh3a006j8rn0hG/D4S08Jy4J9QL2pdvjeHPdEju2Gv3AFkZ7cA991QZJGYNlnfAcp5YymPs8j3rGgNYIXaRrWacFf9fenRh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kphK35t+; arc=fail smtp.client-ip=40.93.195.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kphK35t+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO+Q1EIhfVns80B4Q/AajDkUeYUMilg21i3MAkqCxXTo0Ihcqkz/n+058ZaVZMwll3V/zVrSgblPnRu9jhEF2NFtq4Av+hZ7k9kfl7lDK352uXng9jLp8v+wa6cbFvj3RRZP9ejsLrc0qlAQNu2i830q3ajX8fT/ghXrlbTARfT23QBRbGVBtDqbPf9aY1UtCvTWF2J72O3j+sOFrSeFXYVEKfqG3uaZixqqBO9kLPbxXwNBQyqBBKBmWb38mgIcY9omvOJX7m96y+6mCeuGakN4VDfjdZ30r1TIkJSH20kOU8RHULtfZYXEYlpwUo8dAUbpjOr8pXY7FXQlS5zQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvB2PR/zaSyA4fLQjvAKI3+dCiBn5nc9K1Y9cifjV+U=;
 b=YblFStbRr16hFBdZXC+GikYQ57+4jFpHvq2mE5SeNjoYsB77aVNbFbhsvuSrzRUEktmVy9XWUn3AsQ4gyRKUKJyC/R0L1r0A5040yoTSWrqMA6H58tfBUY8VT8hvmIrPfWkmP6FIFawVPXj2mK8N1ACACvhxtUnp+isAGb9Lg/HtIWM/mIDHoMU6bv2Ka1ebQ4xRhSiUH1kEN+Ni0Imm3HPKq6C6uDL1H4mu/aejZPMig+o0KVxWpvFQjXHE7ZAj+BX9N9K1pMhbYjeizFDGxsAb4l0U1MK1ndmjL32VTRE5aY4GFKEO8ANZy12iXO6qtZqrvuwiYEQu+S6zpNwEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvB2PR/zaSyA4fLQjvAKI3+dCiBn5nc9K1Y9cifjV+U=;
 b=kphK35t+pCIksoq5iziU45ZKYT00bzbmqQa5xE88g8zB8L9l7lZ+EXdBbPku25XKmv0rv3Kz+5bBeNCkB4GeQ+YE3sOE6+pjvpNXtwOKd1UKchis3PmtoDaZDcQcPpQ+2QXlLwIvS/2IRvvJhId0QI0A/HTGgBLqIaNOLuuUotI=
Received: from DS7P220CA0089.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25a::7) by
 CH8PR12MB9768.namprd12.prod.outlook.com (2603:10b6:610:260::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.6; Tue, 8 Sep 2026 20:58:38 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:8:25a:cafe::3d) by DS7P220CA0089.outlook.office365.com
 (2603:10b6:8:25a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 20:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:58:37 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:58:30 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 04/19] accel/kvm: Fix handling of conversion ranges with multiple MMIO holes
Date: Tue, 8 Sep 2026 15:48:24 -0500
Message-ID: <20260908205236.838281-5-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|CH8PR12MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6f8d8c-18d9-4aeb-084b-08df0debf458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	toqLyZIMEKjpadaq2fvd9NWGYPA3cdgXEnQHR3I4UiDUofUA3wH1Hg514kJFMhB8zTDvAnkhNo/53M42cvTkrQ3U8vSfESw08oOTwGvVr52z4V8oVCkLQhDc71s2b1DDJoYPCN2kOd8/Y92n4VeZ1kKmJ2Oqvq/gSpZ9+UukP46+HT7WB5fufSnqifGItEgiC8SwrcdAxlGCLngjkuScYHun9yWKDsPxGtj5hZFPL8DloMXRTtpOTqUUFTdJZS4TVgCwVhf4L70KooHn7WfqlxLNPhSp8uiRZGwONZihi01Ay5HKEpOruxJL3Kc7qAb+51xnH+Cd3HT816kLxdt+PHJaUgankFtG43+Qkz2rXV76Bj+ZlZggA8W/sBDpVVGwlr0UF4rPT782nX+zikEYijJ0CUmU1E63WiLhMFO2PoQSB2IpUjjDqqoz/5Ax9y8Y2vWgtppnOa4lS00u5ohRDowaOUGCMOA0JOtP8LdSi+sO+6C86/JonRJfLqQ0mC3lCS4sZCKh5xkyzTJll9BKMD1b72AsvT/xel3mSVNdtF1Ydl5IkCUi8Mu30ucz10zk3iDFeQZwkJAUeoHmEiWGtTxrRihUc2wwP3+FUvLCDH9AgRcJvodlfEKDENrkfUqK61jVBFGNbqQUT+YMmmBuqAj+BNMt3mkiDLpfp1YNjtkmOu5lhM0jmmU9nO4ip7ndF3IfsE3iyP9nJuITtTefVA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mOTGUkGu00Yis/UeafREKD6i0Ls+9NU1Q/l1JCSdJbk9SCRpNNka5ZXe12TVLULXHMt+Q9iNADtBy88PZ8Cl9eVX59TNafUtCa+cEI05zTTCGlEky6JKzSPJJF50S3KOrPD/eDnTF9VXuodEzDvJHxaFN45AkE99nNEF7t4OZuwq+mj2hwdQiayLFSpszPxHxlyBIFZUNHvk58D8axJV8OE5wsfeoaT5PjcWX/VyKviE7UsSLRvzih6tgGL2WmfngYgE7/1CFC1XXDBZMtK4HcXQkW0OvmtawSfWnhIl8wZUIM1FRtnO/bVtZfY1WdPZvtb7ezrkqu4Y8NNyI285eJNENzJSL5nI7zgX5SSMcqy/3q7WHGXTDBtE9Xd+CFCUn3F66HPgx50a+Si6kR5YT7C9NuQdqI6cwBSm24balcxqjZoAQ/KuyVpeVhvBj/29
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:58:37.7047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6f8d8c-18d9-4aeb-084b-08df0debf458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9768

The current handling will properly handle MMIO checks for holes anchored
at the beginning of the conversion range, but misses subsequent holes.
The current handle_memory_hole() helper already processes all MMIO
ranges up to and including the sections found at each iteration, so
handle this by simply calling handle_memory_hole() for each additional
section/sub-range.

Fixes: c5d9425ef4da ("kvm/tdx: Don't complain when converting vMMIO region to shared")
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 463bbdadd2..518baa35b9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3492,7 +3492,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         ret = handle_memory_hole(&section, to_private, start, &skip);
         if (ret || skip) {
             memory_region_unref(section.mr);
-            break;
+            if (ret) {
+                break;
+            }
+            size -= section_end - start;
+            start = section_end;
+            continue;
         }
 
         ret = kvm_convert_section(&section, to_private);
-- 
2.43.0

