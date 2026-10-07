Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A764AB3CC
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380919; cv=fail; b=Chs3WbKzD4T8ndO82AnZjsfV4YAnG9W2jWItH2wR3J+j73vR1s4SziQ1d9miJ37B53SKltLlGFyN2jBPcrdHFrFkTxxM9cbAFM73akgvH8ZuI8Ff3dgT4nGyx4fME/pS9SYYld70nxF8XrBZzPlpSkutVxafXRMTo2vsKLoLPfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380919; c=relaxed/simple;
	bh=/I0TtcLP8X5IJxkLFb6Dys2w/Cg7yxAl2VgNQSwFZlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jg2+/E+5uHu0by/5VH/+n857JN8/YUm2/2vmzXqSfYVPpA0jBNQySt8/Ztq1wy20Xyt06VKhDRUNVIzwC2MAIrQsd8GDoaBm+V+04DVtS13zvCGKF6O1cb/NsJFRv8I71xVtKUEtwomlgMeCMN9SxwQdToNGRAn5QL5eYBvRXoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xFO09SJK; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xFO09SJK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pW5cyi3jyUc4DlJ0YHcJY+m+6yLiBBbmlFYlhYSdChb8RYp+MGHnmSa8fM9SefCCVmMMf3qf7VbGanfjPgs/ZHbxBnEg901Xg2mSUTaXjmWtB+flS2Gx3XfJ0od1XI6iaor5wt0Rx/lHqqodtzULK5Jp5NoJzDOHNBvo1ooP2/McTtvsYeaJUbzWkpOxT3P1Lougre2YU1t+yq3nvjRQtrP+dptkZjVUxUg+d9cg5iz/xXgvJuHMDXgJrwgDaMoXtvxzTrja6zpw2fTfpZDYYDQ1k9e7xVqcjdPko3LtrPU1sY++FE69KfQMBkoX3gmGY1FXI/rQEb+O3GmxrgLhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3w86TgdE7KjIg2Wup4AaxvjND2DiFb3KAKZLmuIFnk=;
 b=yYii1tfXh0WLBER3GNg/JVYlHKqbDszoL+Mi/qwR7afkw+3Dkfnl/pob3oziiBMPlKJQBh/H0OTk6pyRtsG2BNgBNhzHZ6QVuQ+3Z8fD/F9P0kUVqu+1gaiKlxmKL0PFmOSO0VaPPk6Gj2hxzTQ7At+rFN0OqQ2OCPhy/ADCId0foO0DrPHXLsMeSxP6Q8WZ4GbKBmpXtoZMSINrtCA19gT+9PAKw79XVozySpGAsm1Waq+E9O9JvbLhq93z4eo8lCHC6wPZK0G/uuMBKaHEtPtXaYc0XSX8Kc5nBd9tQ/Z/lKlUC2c4pky6TponbpukksIQl4yEe7jp1fVgOJpRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3w86TgdE7KjIg2Wup4AaxvjND2DiFb3KAKZLmuIFnk=;
 b=xFO09SJKk7xZdc79DB8Y0gyhs5+0l/W2YU4VsHn+PT5ku3upkv3/rEeoz60PP2+t85SlKrcv0thYm1smjVko/ca+gTCjouxl2uiKmHZsuOhrFfMG5rmxC4SjEzlwVTa+qW3uLSkFrRxwj2jgTVfm7bMOZbARtCTgs46BbUPmeXs=
Received: from BY3PR10CA0008.namprd10.prod.outlook.com (2603:10b6:a03:255::13)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 13:48:22 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::19) by BY3PR10CA0008.outlook.office365.com
 (2603:10b6:a03:255::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:48:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:48:21 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:48:19 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 02/19] accel/kvm: Fix kvm_convert_memory() calls crossing memory regions
Date: Wed, 7 Oct 2026 08:41:26 -0500
Message-ID: <20261007134323.1606088-3-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 933fadf2-bfad-4a0a-fc28-08df2479a6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DP5ood6jRiDIinpRX1krGIdvYbM1b6MV36GHQUcbcIzgbgNt5oLUtmXCXUmolefuCZhR+J8B0UO6lLaHd5Cud5jxnFHC6RwWEwEiT8534r+qWpgiJim8cOHZv8+dx2ud6BIqhKKz+nb/p7u/O44h1Li7VR5IZwiacXUEqAawVpsLHmOO8YSWBwfjeMRwgLZTT5p/l0GHjzi5HBHEW1aQ9475X1d2Eo9qUSInBTL0Y0FUeH1AOAbPAkLouY7KTJzF+rVKIQM4zXeBMhIVr7ozn/jqtg2w3SuCdHvGN5Ewi0JoMKH9ji3FATfRhBv8PqAJPbOwlQZSVj0I4J7+Dm653WmVRMpBmc8Y9dEUlEhWyrjeHacUpxzTgn/v3Ito86rcyhAAz7OkOdvbcCk+xN3tKXE6gvDZHu7TlHByEGK7EuC2IflzbPVrwl16TY5c7nycPPaqY2QXoeBhcfNoNBo5F5wp9wmhtOx871Gj9fGmiL7+LLt/1Ee0yvZDdelSH5Deg6+M8cwrWgbEyHmvhSbS+lW7d2mxDR4JbAOvFlT8ndb51DVea6lHXtEaqchNH/WN9ELUwXILfTMdnyfCYR4k0ioK9aLrBZXlF0h3aXMbCdIGMxAfK69lYx41Hryr13pwQTnz7Hk1Th4pfUmQFjwkcg8c3Hgf4TiohwKdUXzwjTcPkgFXFV+dJroyyelfqlIN3hH0EgFvLRb6tp1eQQjSMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IO2DSFpX19z5d+mW0jrNOzYmjmLZI5TjmZddT4LIVmoxKQnPQdfzS/M3SmjNl+1sM+FkaA9VdSxfn7fclr4G9q59J+PrDqg/QRtQhAp8K1vlJ4focD2qg2rqWRrlHWJG8l0K4cFAsCgyq6W+09wxOzdOPzYSpbzR85GKl1i6ulQl/UFe/mBR6vPogA3u+NSLdVHsFUzBRko5KOPQ8NAwA6xcbG0scQ2FQX0QeI2tv1DgpQzUtXHeU/i+I1RUGLbJlUHucDGxDTvpt9qEP4ull87TMr/rZt2lfS/Na7TKia4wERanqS57PfOum14yWgFqxtsRlpTlv2ymGaQ9UmgYE/0vEqUuvTaDapHJgrSjSYQbR2P/NeTHeyVGqsDiIYoAKOuDwhTgziKbj2FvnO248fwu3RMKp3u0aCOBn1uhNTyFjU7AS3SWwQUN45ig+mw/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:48:21.5072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 933fadf2-bfad-4a0a-fc28-08df2479a6b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328

From: Ashish Kalra <ashish.kalra@amd.com>

Page conversion calls can span multiple memory regions, potentially
resulting in a conversion failure if the memory range being converted
extends beyond the boundaries of the referenced memory region.

Handle the case of page conversion calls straddling across memory
regions by looping through the subregions and handling conversions and
related work section by section.

Fixes: c15e5684071d ("kvm: handle KVM_EXIT_MEMORY_FAULT")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Co-developed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 94 ++++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 31 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c824e4d963..9ba8462f5d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3395,54 +3395,35 @@ static int handle_memory_hole(MemoryRegionSection *section, bool to_private,
     return 0;
 }
 
-int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
 {
-    MemoryRegionSection section;
+    hwaddr start = section->offset_within_address_space;
+    hwaddr size = int128_get64(section->size);
+    MemoryRegion *mr = section->mr;
     ram_addr_t offset;
-    MemoryRegion *mr;
     RAMBlock *rb;
     void *addr;
-    bool skip;
     int ret = -EINVAL;
 
-    trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
-
-    if (!QEMU_PTR_IS_ALIGNED(start, qemu_real_host_page_size()) ||
-        !QEMU_PTR_IS_ALIGNED(size, qemu_real_host_page_size())) {
-        return ret;
-    }
-
-    if (!size) {
-        return ret;
-    }
-
-    section = memory_region_find(get_system_memory(), start, size);
-    mr = section.mr;
-
-    ret = handle_memory_hole(&section, to_private, &skip);
-    if (ret || skip) {
-        goto out_unref;
-    }
-
     if (to_private) {
         ret = kvm_set_memory_attributes_private(start, size);
     } else {
         ret = kvm_set_memory_attributes_shared(start, size);
     }
     if (ret) {
-        goto out_unref;
+        return ret;
     }
 
-    addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
+    addr = memory_region_get_ram_ptr(mr) + section->offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
     ret = ram_block_attributes_state_change(rb->attributes,
                                             offset, size, to_private);
     if (ret) {
         error_report("Failed to notify the listener the state change of "
-                     "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
-                     start, size, to_private ? "private" : "shared");
-        goto out_unref;
+                     "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s, ret %d",
+                     start, size, to_private ? "private" : "shared", ret);
+        return ret;
     }
 
     if (to_private) {
@@ -3451,15 +3432,66 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
              * shared memory is backed by hugetlb, which is supposed to be
              * pre-allocated and doesn't need to be discarded
              */
-            goto out_unref;
+            return 0;
         }
         ret = ram_block_discard_shared_range(rb, offset, size);
     } else {
         ret = ram_block_discard_guest_memfd_range(rb, offset, size);
     }
 
-out_unref:
-    memory_region_unref(mr);
+    return ret;
+}
+
+int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+{
+    int ret = -EINVAL;
+
+    trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
+
+    if (!QEMU_PTR_IS_ALIGNED(start, qemu_real_host_page_size()) ||
+        !QEMU_PTR_IS_ALIGNED(size, qemu_real_host_page_size())) {
+        return ret;
+    }
+
+    /*
+     * Page conversions can span multiple memory regions, for example, if two
+     * memory backends are added to support two different NUMA nodes/policies.
+     * Handle the covered sections accordingly.
+     */
+    while (size) {
+        MemoryRegionSection section = memory_region_find(get_system_memory(),
+                                                         start, size);
+        hwaddr section_end;
+        bool skip;
+
+        /*
+         * If there's no region present, then the current hole "section"
+         * consumes the entire remaining range. In that case, update the
+         * relevant indices to terminate the loop after this iteration.
+         */
+        section_end = section.mr
+            ? section.offset_within_address_space + int128_get64(section.size)
+            : start + size;
+        assert(section_end > start);
+        assert(section_end - start <= size);
+
+        ret = handle_memory_hole(&section, to_private, &skip);
+        if (ret || skip) {
+            memory_region_unref(section.mr);
+            break;
+        }
+
+        ret = kvm_convert_section(&section, to_private);
+        memory_region_unref(section.mr);
+
+        if (ret) {
+            break;
+        }
+
+        size -= section_end - start;
+        start = section_end;
+    }
+
     return ret;
 }
 
-- 
2.43.0

