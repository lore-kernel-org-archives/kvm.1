Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E63CB567
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380675; cv=fail; b=oH6EpwwYHPcGGBx8c8H2fxhRLe1KxdZU8Ori+hWYJn585bvOyP0nS1kCsgR+qHywLvXa4YN4yA634REo3r8AV0RhV4aQSxlvzCc37K/cbS7D2UBLQpLY9Z5mYrSLeEp/jILDIFf1hf4MQYgJSgiXe2KK9+KuBwUAavjl2I1Cixo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380675; c=relaxed/simple;
	bh=oerDnkXpdTJPHOb0GDxADit0XEMiEG+wOzHzolzsIbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHomOCKUf3Nb1Qe603L4nfsbx5k4jTeJG1K2GtDX1LFN2MpDyKgF8Mfd35Q6LDsRVMvzKrP4UhtTcS5PYkm+odQimGHiwSRFAK750c5MGuTkaYL/gwVuNjnp08/1xnE9ILxsfsSfl9crmeM6wQQXj/kIkYvZ1R8yKrU0vsBmrIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cZROhLrX; arc=fail smtp.client-ip=52.101.56.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cZROhLrX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWJyorRjodP3teolZk45NhcdjDhmYOuCgfndMSWt0ni2PRiMVJrRENwdhgWh+h1Nbd4iXTWMT80kgkKJfdPrs0fkIagEYnT7y//kvIoy+NSNkrLpXY/S1UDUZhez148Wa9Sh77x7PbxQzW0px46LTSSD36+2BOAl1rpyI1cwP10ZXkWmnfY/P5VWnKyFQ2u+orsI69GEv2/uTwHYEZkG9O5JsBSIu2B0bzvtITlHtDLKPLYIioRXjyCzOvKZjtzA1YOYCATvVai5y6cnnL0xx/I/Kl+LvmlAIEm28A9k1aTq8ITPqO0V/eiTDXAKr00qGjpNU+ys48N6Hv8WNOQ4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K5b+au/VVkoKHroFGCgTNT6skp3J34/XiCuG7wL8Hs=;
 b=ng95/XsAp/mGI7/47Ki2Hmnd3s0CUqlzHcAmPuAyT2ZaKfKn38zlOMrSVg2jSyV+IZIjbx/UkraYafsU7vdIJqjgpAE9BGrYUqA8jkHYtfTXnt124tr50crGH5uF2uXYR9EdlAqLC6o9Gy35QLe3X0OXL6y0mkIWVdy7aiwLCdvm82Ug0LlbyeceQ3tTsllE0lS8BNmudqKtvqscuEiZ9Lud85LqUqvlwvZsbdTWwaU1YivL5T1oEGj7EMy7IKYC2EFC35VBKBs9YwkIQl/RnB3Ev5FUx6R5hLrwkw1+Otdn9WvQkNnLBzF1H1RSIn6Hd/+8JoshcJk7AtK7fH1stw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K5b+au/VVkoKHroFGCgTNT6skp3J34/XiCuG7wL8Hs=;
 b=cZROhLrXACnnLbVRA7Tx3HsQhGeobnPR3bgTPVVDP+RNDKbK3zB9HEosJ+ZP7WbDNDxYW7GFcvTFVDMYXFeLWH86iNfW3U9CZ6oWUhC8E/NqJ/Xd2wI0wmtsR7FBjGthuSojajwBU/J7Av7KBP7DKmMPQvoEhMaBR5m13SrXQig=
Received: from YT3PR01CA0142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:83::24)
 by CH1PR12MB9718.namprd12.prod.outlook.com (2603:10b6:610:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:44:14 +0000
Received: from IA0PEPF0000003B.namprd03.prod.outlook.com
 (2603:10b6:b01:83:cafe::81) by YT3PR01CA0142.outlook.office365.com
 (2603:10b6:b01:83::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:44:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003B.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:44:14 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:44:06 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 10/19] system/memory: Default to guest_memfd for RAM for in-place conversion
Date: Wed, 7 Oct 2026 08:41:34 -0500
Message-ID: <20261007134323.1606088-11-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003B:EE_|CH1PR12MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a30e544-2045-49d9-907a-08df2479134d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|7416014|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	IA3ru05ElPhKkwoMWTXanNgFi9bkVlgBkx9oCa5kcsYLBk8ZE1Gl6WpEb24BNEqdjDDV/LiNYFAZ+CiAnz5F3Tmus/GVQCj6LqdxSQbITY6hbwQ1tu4GFKVZ/tJ2hGq94FPTjSgyYvFU/sHc74njz42ttZLzh2Ewu/9I7zv9tyHOmoSiC7YabbY/le9LgLVTeSCEw35qvPQflmS0+taXnENB8MCpZtycil6UiuPS7RzG9rP/iIaWrnUMLnL6VLhNQoxwHwFknktDVf19JVdY16CjHk2Y7vq5V+qy5s/P2SVukDxm7ZZMeNKHCK2vBvJESeqPUN2fZKV++6N1mjzHZhd3dIZ3QNGQ2cDFYjNAcjtIyllpTUA9knq0GdKR9/TjTpNMxOVGBx7/ZbCI1hJmVUfh6U+M/ghB/Go8IykZS7PV0lugI2AkE8M4fgD9nksJT7msZI6CRioRDUYtpq3qbu3Y3dmBoj3C6mwim2iJE/1Z/1k4Alqk9IvEiOq0y9y4e/8NuLBlurGiDxqoLIcRekh0TKULRBhDUMman6rWAFmzJpUXJX0u+K688UIcAASu8GbP4zQu9BrW62gdJxIgvDTUxkwHW4aO3CRm422MH5SzgUT/pYpqv+C4+6jEBuXyaUDHkB7g0dfks7ahTf/5K0jqMi0OoD0docMhEWqkyRDszWl0Pcb2dmoNm3AZxpksobkrUEcjiSRQIg1BfnqqOQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1nLTJTU/Gn8vMZpL2ZNj9gQQ6BJd1b/lDl2GWFl0D7brROmr5bhACxPXsgWW8mg0lbN0GZx5LIpUCsbnraQ+5Cb+4YBEpu5mnA2zPo7ZCTQcW/YD+3XrEOL79LsfoL558UiEExxwKOdCZo9ePVRsMxhBqF/WsjwB8ke+x/SW6Su6yOMpcJTVy83CKd/FMJKMN+f+Yick598DEOJGah3VTDa3061TOYlu/g1J8ZI7PSX+xgVJIQDjTRfeu2LB/rHhCUDqaN0TS4gQ8Z+Girz9szC+zKM6e3a5EamnsUbopk9+raUSpUWEGzZcncYnDu8MJKS/AbfWWdhvHK8cEj3cvCY8vEoKbBEyCn4hL+KAWZL09sp2xPEa5ihdmOHuulJ5fqSjFfUyfKXUzzDRoieVkkrpbvm97QMv8vi/nvBpMmr5swVmyVdjG8OlxukAExxN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:44:14.2932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a30e544-2045-49d9-907a-08df2479134d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9718

memory_region_init_ram_guest_memfd_private() is called in some cases
(legacy BIOS regions / IGVM regions) to allocate a new RAM region with a
guest_memfd FD under the covers to handle private memory since the GPA
range can be converted between shared/private guest RAM.

When in-place conversion is enabled, the conversions happen with the
guest_memfd inode itself, so the same inode must be used for both shared
and private memory. Handle this accordingly when convert-in-place=true.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 system/memory.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index f1910af8a0..4d302fb55b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3598,10 +3598,27 @@ bool memory_region_init_ram_guest_memfd_private(MemoryRegion *mr,
                                                 uint64_t size,
                                                 Error **errp)
 {
-    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
-                                                RAM_GUEST_MEMFD_PRIVATE, errp)) {
-        return false;
+    if (machine_require_guest_memfd_convert_in_place(current_machine)) {
+        int fd = kvm_create_guest_memfd(size, errp);
+        if (fd < 0) {
+            return false;
+        }
+
+        if (!memory_region_init_ram_from_fd(mr, owner, name, size,
+                                            RAM_SHARED |
+                                            RAM_GUEST_MEMFD_PRIVATE |
+                                            RAM_GUEST_MEMFD_SHAREABLE,
+                                            fd, 0, errp)) {
+            close(fd);
+            return false;
+        }
+    } else {
+        if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
+                                                    RAM_GUEST_MEMFD_PRIVATE, errp)) {
+            return false;
+        }
     }
+
     memory_region_register_ram(mr, owner);
     return true;
 }
-- 
2.43.0

