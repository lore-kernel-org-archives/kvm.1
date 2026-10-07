Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665C4AC152
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380737; cv=fail; b=Q13c7wMwLlMFxdyF/gpVhvUp/jtWR/McZUvOgowZw0EemvKD9mh+7DefEccS+2TdH8wht/PAphpP5225dzDS6o5VudhIgInNBteTMrI/R7DwcLPJrrPbyd1Y0+K0olscaGvctV4aMMBMImQ5UGVfcrALa2EJZ7w8Jks7hBVokMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380737; c=relaxed/simple;
	bh=JpO4SL/w8bX64GMuwKwMC2iaXKOtTqJRokwg743uyX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUuZ+FS6TmxsZCeykPS2BLBUVealOVDOWWS5hMdpwMFPTc/cw/8ELDSLMXiQAD+fhH5Baq3xlfVswchO6DUMuKqM37trX7PKNJNXXcAMSx+coXouE6Rx+bxc8cd5ztl7V1FYoCmcoohKGj8oajrQIfxRZ0O8pBv6MkBaPbmCmmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wa880FHU; arc=fail smtp.client-ip=52.101.53.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wa880FHU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZC4i0GVInR2XLyO2xv6wHlLL3s0aZ7I6TMVdVjUabKdrx0qX1+LbQchajUarjcVW07YtOktXdIZ9vh8LNMeW64LaSj3kIH5I+OcZQZKYeC0NQ0iRUS6ZMu3D+PEOd79tEXTWiZgsxaiRVE+lWhyOBYTaZyGhS5JBN0T0WYdNh58BjYD/6fm6FuF0xGvwWJYsmOUUywn5s/VzYZw5qD5YFha1aI0MTK0T1vPxVcJaNyh/PVA0cHNrK/wXyqLb7FOVYFvgKa7karIWhYNyG4kDdEqUHI7YA4Xx1FndbuJytdylFOgsjkaEvpm7TjqmYDMGdlmjC8rICkLZ/bLhO32tVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoV8TRF2yobFk+awYT3I+Qg6S5t4Y2SoQRddPGytxOU=;
 b=YZjHeLB+TcpQKnfZMx5R5n1e5fJvNl1GjIpetfaDODgL0ffe+9orWnmfceoLVEGSsK74q5rnR/yT6IEf2p3zAEELxTs6uUIY0shdB9ULXmHqRZTcePqpou/oCMV3ogfrUjA+A5z+1acGzbewp+yT2/NvK6IRFBeEB8dsIm8Yen/59x8kPoTb8XQat0inTgTi0p9AiME/LygXeYCh6DrbzqdRSaSKAAyCOfAlK5+cG3wDSB3C5rHalL5/SPPhDxQE4iwR1rzPAYPvKlNc9Ar/UWXjczSXmWwaOvwHuJm26lzXj6HzS56dxBmYKfgeywVHUHqWfvDtR1OQuwRO9rEqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoV8TRF2yobFk+awYT3I+Qg6S5t4Y2SoQRddPGytxOU=;
 b=wa880FHU5i9gjdlcvWtNx3Bl15OtgUvz3eO0bLlsqiozTLrvd4jiop9pWWTApq9xP+Zl8vWgwtRy4PmxdRcTLV3lKGqkWMG7+oB+g4F/m/MBZ8l1UmGFib1plgn23hAqqatzBAthU1hQh9VDyVblTrhoFI5QKO8ajQd19hPALHc=
Received: from BN0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:408:e5::32)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 7 Oct
 2026 13:45:13 +0000
Received: from IA0PEPF0000003C.namprd03.prod.outlook.com
 (2603:10b6:408:e5:cafe::38) by BN0PR02CA0057.outlook.office365.com
 (2603:10b6:408:e5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 13:45:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003C.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:45:13 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:45:08 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 12/19] accel/kvm: Re-order attribute notifications for in-place conversion
Date: Wed, 7 Oct 2026 08:41:36 -0500
Message-ID: <20261007134323.1606088-13-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003C:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: f6eaa37d-91d8-45aa-5559-08df24793693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|1800799024|376014|82310400026|22082099003|18002099003|6133799003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	AeYkp7nkrZcHay1FrhiAJLB5X4DsbeWTAidNb9J03ERzzNjQFkfqCADHZDvtwE/PWnZ2xGE+eI9NyLcG9P0lEG/n4waO++Nc68q6QUAapGe13wN/WLBa7dmwSWTtWFSYp6MHNO2hsabsCQCEKvktfUlUDTOotueAzwA4YgpZ69KuxjJ+3uszhd3+x8dLK44ACRIEsmYXWvb5/5jlNnWXFgs+SljOmWd1jqUrGyI4pn/ejnugtseRYPFpNEw7tLIipRdmz6IyZnZTP8u9RQNzLQMysjBK/OXk6VSIki/MD6rYOLnFEv4wz2xEeZrpV0+v4so0VvZiY2C8XTTG9lwXDeEXnI4tACmIqYfSBCp8lw2uXKJkudGpeZfC5XGMrm2/0a/H2AouDaq1VBs2Q2BdBCddgFhTYYVmzgdTl9uvwd/nYIYzA/6iA+FCKeDq2Mt93gu8Bu4WGksGwAmeaMXVAGvisLw2YlRTx7gIYFRgK+VEgQJ63hFu1TrtWBAjMhxH1yB8Rwj7Rq3WpCT5KSdN8a7ksQo+pjolXoKTcne5BDXZVejM7Rf1diPiXON3K/KCvfPVYcP5ADAlI+CxM6TXzf5RzQXmnagETo2cwNvorQwYgT9Rqen4D7TM1LehKuYZpouwMyDHyEoecmAwkqi1Q1dMIOkc29i6MqtLxBZzfyET6OikRDe+LCUpZHoAfbXQ4QcUQvmyKBcABPwntZSxQw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(6133799003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ynsIU8HIiNHG7NZa5HPmeRpSWmiMgURdkUIYNmvzqtgw3K38t5IJRrjwSjtkN7BTwoZBXJxOtgtX/1QFT0kHyVtGA5jJeKnS21D3YDSJj+VBvjNzyPN1nK40U54DamIaWOgymdUCeJkB/vvL1SklN0b8NocJHuCXq2x6rvrRSK+jQe+AHxt6+mHMqDw/ERdu0g0S1iGmsIn1yp/vjRVThb1Jo4yK4BbXVnwnmVdR120XhaIcVn+/2xOEfI71c97xp96UTX6nB04cG7nF5RMCOlDt1dUi9AZKdOnAya2zI4E6ZPbFKQJd/OHJQr3GJ2lvEThGvYqkx91Rk4b7zAq0ZRC6+rS9rKTNLiwoJAB9HrksbZw3yXwILguBJJsK+CjhnpxGw7IMDikaX++Z5yGizinLyTsz/9xSQOMzdl3DFJ24mWjkXYS2MUqiF+LqOOq9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:45:13.4707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6eaa37d-91d8-45aa-5559-08df24793693
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

ram-block-attribute update notifications are currently sent after
conversions from/to private pages to trigger DMA maps/unmaps of shared
GPA ranges (respectively). However, with in-place conversion additional
requirements on the kernel side come into play which require this
behavior to be adjusted.

For shared->private conversions: the attributes need to be set to
private *after* the notification, since when using VFIO it may not be
possible to update the attribute while it remains pinned due to the
IOMMU mapping, so issue the notification first to ensure unmappings are
done in advance.

For private->shared conversions: the attributes need to be set to shared
*before* the notification, since it will possibly result in the page
being mapped into an IOMMU and trigger guest_memfd's fault handler,
which will expect the page to have its attributes set to shared or
otherwise SIGBUS.

Implement this to enable passthrough support for CoCo guests with
in-place conversion support enabled. For non-inplace conversion, pages
mapped into the IOMMU are not the same physical pages as the one used
for private accesses by the guest, so neither order risks DMA accesses
to private memory and that path can be consolidated to use the same
handling as well.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 60 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b824b803cb..60ab5193c9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3448,7 +3448,7 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
     return ret;
 }
 
-static int kvm_post_convert_section(MemoryRegionSection *section, bool to_private)
+static int kvm_pre_convert_section(MemoryRegionSection *section, bool to_private)
 {
     hwaddr start = section->offset_within_address_space;
     hwaddr size = int128_get64(section->size);
@@ -3458,16 +3458,66 @@ static int kvm_post_convert_section(MemoryRegionSection *section, bool to_privat
     void *addr;
     int ret;
 
+    if (!to_private)
+        return 0;
+
     addr = memory_region_get_ram_ptr(mr) + section->offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
+    /*
+     * The attributes need to be set to private *after* the notification
+     * of a shared->private conversion, since when using VFIO it may not
+     * be possible to update the attribute while it remains pinned due
+     * to the IOMMU mapping, so issue the notification first to ensure
+     * unmappings are done in advance.
+     *
+     * There is an asymmetry here in that if the subsequent memory
+     * attribute update fails, this notification is out of sync with the
+     * state as tracked by guest_memfd, which isn't ideal, but memory
+     * attribute failures are not expected to be recoverable any way so
+     * there it would be a waste of time to roll back the notification and
+     * re-trigger things like mapping the page via iommufd.
+     */
     ret = ram_block_attributes_state_change(rb->attributes,
                                             offset, size, to_private);
     if (ret) {
         error_report("Failed to notify the listener the state change of "
                      "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s, ret %d",
                      start, size, to_private ? "private" : "shared", ret);
-        return ret;
+    }
+
+    return ret;
+}
+
+static int kvm_post_convert_section(MemoryRegionSection *section, bool to_private)
+{
+    hwaddr start = section->offset_within_address_space;
+    hwaddr size = int128_get64(section->size);
+    MemoryRegion *mr = section->mr;
+    ram_addr_t offset;
+    RAMBlock *rb;
+    void *addr;
+    int ret;
+
+    addr = memory_region_get_ram_ptr(mr) + section->offset_within_region;
+    rb = qemu_ram_block_from_host(addr, false, &offset);
+
+    /*
+     * The attributes need to have been set to shared *before* the notification
+     * of a private->shared conversion, since it will possibly result in the
+     * page being mapped into an IOMMU when using VFIO and trigger
+     * guest_memfd's fault handler, which will expect the page to have its
+     * attributes set to shared.
+     */
+    if (!to_private) {
+        ret = ram_block_attributes_state_change(rb->attributes,
+                                                offset, size, to_private);
+        if (ret) {
+            error_report("Failed to notify the listener the state change of "
+                         "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s, ret %d",
+                         start, size, to_private ? "private" : "shared", ret);
+            return ret;
+        }
     }
 
     if (to_private) {
@@ -3530,6 +3580,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
             continue;
         }
 
+        ret = kvm_pre_convert_section(&section, to_private);
+        if (ret) {
+            memory_region_unref(section.mr);
+            break;
+        }
+
         ret = kvm_convert_section(&section, to_private);
         if (ret) {
             memory_region_unref(section.mr);
-- 
2.43.0

