Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577334A64DB
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380828; cv=fail; b=WPYpen0r5EdtOOS0B0NW3gndi+PcDXvgQW09AJNKcRiGa5FdQ91OFfiHgLLLddqrzoZrt9VVYJc5tRcAj+srHl1lZlDsaYaE8Rvm7Nb7vcXHb1xnkUFjMpaHaG69JgfiuhxgVCdf2Gl4LY4i7Y5NGhN0Rxu3pTcrJvh0K3E3Wf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380828; c=relaxed/simple;
	bh=LQYq9WJvI60qmqc7BGeP/TQo6KvSrmZN5sJOY7y0BfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPQ9lYp6pDqKKlRN/TvPNaRbsrEORBMD+lkSFTcojBgKJxkXGnqHQLw+mITlTObEs4v5J2H+TKczWfccL11jEmcKFdHJMtpXI/mZZMOMmevLM65Dkj9LWgxmXufCD8YTTIJoNYNAYP3rGQVAR4TEnm2MtFqH/+SJhoFuOxnIzcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i0AiZroS; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i0AiZroS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbfGSSirErQmylAVCY98mLdlq7KGncC16ftZ89zyq7YdXtZAqr13dd8GbVuCRw4N4SQwOz3LGhyWkje52p5EDlCCos1ZzfmbH4gZ7/WlXO8fLnPITmnJ9LEF09sJSCkQrKKfgfHeZUcYnwWCiC7jLAYXqZCDvatDrwPM9W23ZbibtsaFEMTHNrWyeVHL/rywUWYxBdaXgun+1lhbwTK5PwF2MxoP/POc06HTILIDg6aVEyMqR//f19sKkVuOAlo6OqVpGvoCKj412hE/x6iagHilsH7VvGFkdCYYV9LLS2M/XQ69UNkuyAvZk4SxXbRroF8aUcqWIK5QqgaJX3uBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knK6nGIDZ1AfqKIwDkPZq2quvP7gU2pwPedJrM/SGjk=;
 b=bweL/2jmTBoVv97HgucrCuiyDepp85aorNhwfmeOD1x+77KE32YRQMta6k8KaLTvmgDrjxhvNX2zNMGG3VW9y8WHQ8MK/rI+YhLvIMaqIHNHqaMYvnWo9dd5XZci2jv1pVpHZoet5PIsgkzKyBxTexJi/4N/aGHlG1QXhm2kJ+XkCeyopHZoW5U8bP7BKQ5B6VaalwXRKbfGrxmP8fP4U4/5h9HWDGkoxaVcX+M9zBZPfqTbVaxfat4HWoOYWjH99k24lIRO4INrLN1rbZTlfptmRKxzVJqsLWuA9NRhj67U0DNYKxIpUTSxasokJZvL1v9muhTWMNCcp/ae/DT6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knK6nGIDZ1AfqKIwDkPZq2quvP7gU2pwPedJrM/SGjk=;
 b=i0AiZroS5EqZbwkjPNpOk9sX2QQRp4sV99wIQk0751PaLht8q1bpqkZgB4ijTSRlFUKCXKJrlqHTaXsW3OPZzRP2tYFzA4tYwvGZCIVdaocxyvx6uYRdYLrqlk3dSymxDkiP0PrZYhwbf4b/YIF7880v5EF1SEf2AK8lIC/kajc=
Received: from MW4PR04CA0254.namprd04.prod.outlook.com (2603:10b6:303:88::19)
 by LY0PR12MB736177.namprd12.prod.outlook.com (2603:10b6:404:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:46:55 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::4f) by MW4PR04CA0254.outlook.office365.com
 (2603:10b6:303:88::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:46:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:46:55 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:46:51 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 17/19] accel/kvm: Disable discard for in-place conversion
Date: Wed, 7 Oct 2026 08:41:41 -0500
Message-ID: <20261007134323.1606088-18-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|LY0PR12MB736177:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b6962a-13a6-46ab-03dd-08df2479732f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3gKVBW0p4PNkFsK4Y87kvv2ixGXeFO1j5HoHK74KykxmkofblZw6qEaLIUUjJPOiPAa/OJCK9cRbGTQhQ95alU3WjetqjOnDoZRmIU7q4oEh8M7zvh2rwAf+q/3GjGioXTFi0USlhn5Z7GanRNf1SrVqDmh6/hnjeGkqSsR2WyG1jsqYkNRE4Lk18a6I0qhmK0/Fouu72GWHgMxMQbJeXFc6ezPr360Qxtwa+ZAIMEB8s6oJzjt/RIunhtY/CsVD0Uh9ig9lcy7fxr7QGAyLJOCxUX2xshBMhsT0IBtDG35aH10hAY1kvgDjyhZ55PqvCYgYN+ZtESZTChkMy8hSB6WuhVsx7z4QDePcdKNEF8eDm8cMyHTS5QVHBpwv3GHN8llXn/LBQQ5MUnKSjZT7z+HaAuRD7XoDyLmExEHAUfR9bGy/ldgXuW+YRTdmRK8GXsRlDCSJDWvT3BPLAgQVaNLAV2HVZW+idyQ7QYp0dFUlDUOo0F4QAk3/C5JBRYDkTLi3k/Oz/ZVtEbongLbex54AWLLEH8iURtb4/8HmucFAcF+o09v5mYPdbpkQHN4YrIJ/uQ5AMou498XJjOfrtMdv2OT84ReDVJhcA26fgGCS/a6mzSjad+pqqQnOCfHICqkzfmufppRObcu/rCAPIet9pN0wOrnKWlMaWUpOy871VuHfSGK9iNDeyrsUqr2uhNt2cxbZQRKrfdI+LRXqAw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7BtH2RhoTHOm+LGveXBMz2+s+9DoIV2ut8/vx3APyJiBIc5+EB/ZJUyZ3UVlw8MFRs3ipcGErHwMS1hYcigjbXRkSvxv0SG2kOkTuHWkd3HpXxa0D8edFV9yyDYH8M7XATNvm9ATEgeSdLSYtW7/brG48+O5ee7cm8zRpKJlPnu3F53YAZKgWS04aU/Xc44thyB+huUPmjjK83vvAZOFTX/AYmdLfLuHK3eThq7AljjqntZRwZeFEkOLnfzRrLuwdwmkUdaaaG2u7q2Tt46nkBaOUe5m8UJ9nOSuwfG11maSwVwOiWF0Fz4ZzXyUw032cZh1uYmvZ4+zXFtIOEWq4rjlabYt2c7TJGYQidulTtvKyH18OWBkIQCp+abZioschZ6g3k5BHrQiHf/oEV8wfQRwiU+/fBIVSe0JDru7PjqOfAxLFeCWxaTm+VeuK9zn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:46:55.0730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b6962a-13a6-46ab-03dd-08df2479732f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB736177

When using in-place conversion, there is no need to discard memory after
conversion because the same memory will continue to be used after the
conversion to back the same GPA. Discarding it would only cause
unnecessary reallocation of memory after each conversion. Instead, only
enable it for non-in-place conversions.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index bfb8b4a190..dfcfb3b5cc 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3588,7 +3588,7 @@ static int kvm_post_convert_section(MemoryRegionSection *section, bool to_privat
     ram_addr_t offset;
     RAMBlock *rb;
     void *addr;
-    int ret;
+    int ret = 0;
 
     addr = memory_region_get_ram_ptr(mr) + section->offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
@@ -3611,17 +3611,19 @@ static int kvm_post_convert_section(MemoryRegionSection *section, bool to_privat
         }
     }
 
-    if (to_private) {
-        if (rb->page_size != qemu_real_host_page_size()) {
-            /*
-             * shared memory is backed by hugetlb, which is supposed to be
-             * pre-allocated and doesn't need to be discarded
-             */
-            return 0;
+    if (!machine_require_guest_memfd_convert_in_place(current_machine)) {
+        if (to_private) {
+            if (rb->page_size != qemu_real_host_page_size()) {
+                /*
+                 * shared memory is backed by hugetlb, which is supposed to be
+                 * pre-allocated and doesn't need to be discarded
+                 */
+                return 0;
+            }
+            ret = ram_block_discard_shared_range(rb, offset, size);
+        } else {
+            ret = ram_block_discard_guest_memfd_range(rb, offset, size);
         }
-        ret = ram_block_discard_shared_range(rb, offset, size);
-    } else {
-        ret = ram_block_discard_guest_memfd_range(rb, offset, size);
     }
 
     return ret;
-- 
2.43.0

