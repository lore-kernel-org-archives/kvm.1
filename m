Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012051.outbound.protection.outlook.com [40.93.195.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116B9EEC3
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927014; cv=fail; b=eH8YfUXGwFKiF4KtackbVYHoo2iFWgcKDMWkzo4s+wO7uFtNdtvu2DFdsjxoGvsMhMLJE4YboqePUDKVWcmYM58LY/4/X7eZGvQ7WvIrLvzSkSadw61trwRx7PDseX4wIsyyuF0dwjV3jYiRdpl+gVOgdtreW6WU+bkB8ePmf50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927014; c=relaxed/simple;
	bh=k8G8EjxZvVGljrFiDtDgzA/qv6RaV+DldCIMpVbYlaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lB8RfXcGPPJ2yTlSPeG6rEiLiQqw0h6+PIyQWcigtIqClsQ2ijx7+cqE7kIaGmfv1vqG/Sg4EuxpFd59MuXOOUEkLX9VUibGUxCay+efsAu/e8zfFLNHxlqvyGkqWVTa6m/d/2nmmToXRWs3Uc3IqDSoo8JjiZ4asGM+I5+0ZwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZiMkAAvG; arc=fail smtp.client-ip=40.93.195.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZiMkAAvG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF+k6uHgww6e5U2Q8UnAChkZkBstySpwcSv0Zls8yoQ992isYfJIxMjnD4KhboJUmskJ50J1gmulrN1y7nzsVtYyHmhrXE6bQ6PXSkps22HDSAHIIDYghK3Ihbl9sMoiiWtr/aTlq8pzskyz153J/NjGkcCXdkokS8x9WY99yUvGF9hWdbjfunwgwV05c/My/ety10/bjnHq18WK4b/4R4Z+pQubuj4VED9yPDstwL8EU63/93ADmSS8OKe00So728jD7xqeKglEK/ii7Mh0z4HQIJ2YcxrcUpAIFaW9qoSyd4UBw/plfSdwQB8TTJp34+O7jaq8pkwAZU/te33w8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LceuBicuZGmcuyCPtb5jUIuhCH3B16BA1QZbo9M+MEQ=;
 b=nqRa1bMvu3Yh1smSkR8b5o0WMQ0cdWmmI9DV73b565OMAAOIGhT8CFcFx6zDDevwXCoxLqlKbUBYDgbwS+jVOACuZiVk6zK9YKoRnI+OqFxKLug+z7AY6Ml9OcFGqdvSwltvickIBHp4Mm777sNWp3INe+ssIj3ZSotyy69gMEK1YSFTwG2gqnHVBh4iheQbsCdrXZnVR6qO2UADOQJbTSxLfbNNdGeQ/X3bQr8CpRZGBrG7JzM858P3FcTe8rtUK9I/ucRhIzFVuEz8hdfE7zJo8jlfuI8lUjFFkurozldDpBj/UCPvGV2MWqGLbW1snfLp1Qmo9EPSPlMP4ohYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LceuBicuZGmcuyCPtb5jUIuhCH3B16BA1QZbo9M+MEQ=;
 b=ZiMkAAvGmDGKf2WFixX0hXWuT2EUJRPh7581CvSp7MYMSzVyq6sDoTVvMmLZqgqmEmRsYaf/fnuxrPq7nwH5t+kP3e68H0sVpB6mEjDkgBLS22aQIzkn+WeZyPh5iBAzzP7rdeDrSqq0We+oz8tthSlb/YCNZ0Tt1vEoTcswXY4=
Received: from SA1PR02CA0002.namprd02.prod.outlook.com (2603:10b6:806:2cf::6)
 by IA0PPF6483BC7EA.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 00:10:06 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::58) by SA1PR02CA0002.outlook.office365.com
 (2603:10b6:806:2cf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 00:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:10:06 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:10:05 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 08/12] accel/kvm: Re-order attribute notifications for in-place conversion
Date: Wed, 27 May 2026 19:03:33 -0500
Message-ID: <20260528000416.8161-9-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528000416.8161-1-michael.roth@amd.com>
References: <20260528000416.8161-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|IA0PPF6483BC7EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca6247a-5b22-4f7b-e0e3-08debc4d78fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Mi/mcoDeHKfw2jESjMO+CumVRpRmFStO/M8FOtfcGYebSmsB3u2P3qF2AhU+4/blS/pPYptvzzbRxQWEPrPm3DS9gQ555YVWnOn1uiDnq6YFzB35YIKRmiP7XAy+p91/BcNnTXPf3eCcS+jMPUjUbuvNt+Iq5UJvRDlt1foxn8sr1PR2UbjI3mLv/Pctq/R/xAgnuBkuPtWnYEdC8ASyFEbmLljwynIRk1VsMb/fyvkd7VwG8buUBdLIjwafrbOSbqtef5LHT6PGoLWHwxrpxWF+W4t/xfy04PsNYcpEf1CO/l2+z+56FxY1yjN2lCDId4l4ef7tqEbGMTS5MBaj7NeYIt1ku0bsQC5G5OTc+VR9Va9RRtsLw6t6pqnkVG4Y8be+25VL612bet0DI94expu4Eu5tonoHP+8RLGE8txthpVSXdD+F+rdIRF+GntPg7kfJ8gRLOUutQSw+WcscvJFUzgiMZegaC22CeqvKRqx9EKA370kQTyRjudDzqaiWT0sXB+ZbHqZTXbEzYtp8MbgfyEGlDhNzJvej3rH+lG0GEDeCDOGmVx/DCr7/33dJo+VAK2UBKl45Sb3Vl6fHCB8IUmAVqiT05uZoconHcXcrakjacONboPZxS2fGirft0GE0VxasyuqKDjdsLz+p4xbYfQ1+mOs/we2LVkxpxZU1q/gCs8NIs1FmceRPKNK0DYKjRt00iJM1Wq0H6Pa0VxM3RbhsbqBIpghFJIBDE+A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WGQmH2xLySiBEocOb5JBl0m8rDUb9mL66lLWRcHf6tuJrIq6HaEIjtA1/M98QvCdk1zLIWyU+iZvXo5bhXsaFXn6Es/UM4AaLPEteV2jvIY2LClZi92jrZFg4oEx1UJmAtSxrrB0ga2d4epdSzBh7GuH/M146MdLHHxg6bxNwX6E0ll71Y8sUlvkvicITlxPcx2WIoasmUl2tHS4NpHtCKvVCYRDSiqGXKbauhbInbyI8QcX+zbQZ3B205HcRlqhOfUXpzVFVVZi5iafmxpQL2xOEAqIkroVXhfvpmJu//F2kfr6vAa8fP9rvJ0/AIjFuxdL7EDRf2Vbv6RB45MajJ7O6Riu69DQ+iRnWl3Wwoqz3Vajn5O3+CI/WqK+aausrEP/HKU/jldyzQDxrdpMSqKSuqUdRYr+JQjcXbUOhYr9FmkMc3XHd3tFvfbr7dyZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:10:06.0791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca6247a-5b22-4f7b-e0e3-08debc4d78fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6483BC7EA

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
 accel/kvm/kvm-all.c | 70 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0e6ff2de4b..62f2e8aa15 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3456,6 +3456,47 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
     return ret;
 }
 
+static int kvm_pre_convert_section(MemoryRegionSection *section, bool to_private)
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
+    if (to_private) {
+        ret = ram_block_attributes_state_change(rb->attributes,
+                                                offset, size, to_private);
+        if (ret) {
+            error_report("Failed to notify the listener the state change of "
+                         "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s, ret %d",
+                         start, size, to_private ? "private" : "shared", ret);
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static int kvm_post_convert_section(MemoryRegionSection *section, bool to_private)
 {
     hwaddr start = section->offset_within_address_space;
@@ -3469,13 +3510,22 @@ static int kvm_post_convert_section(MemoryRegionSection *section, bool to_privat
     addr = memory_region_get_ram_ptr(mr) + section->offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
-    ret = ram_block_attributes_state_change(rb->attributes,
-                                            offset, size, to_private);
-    if (ret) {
-        error_report("Failed to notify the listener the state change of "
-                     "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s, ret %d",
-                     start, size, to_private ? "private" : "shared", ret);
-        return ret;
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
@@ -3538,6 +3588,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
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

