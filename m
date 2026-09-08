Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285E3B71B2
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900892; cv=fail; b=XKx6jB1cMyTA3LK0jnYAcw2Uxg+e9WyNM29EjV2pzuO4qWQH4Ao7WzA94/IDPQaN4mmcJ0MAWr1zVUvRJyA0BtlOLHtAwHMlVpH6nnUcqZ/ADWvn8qZWWwVZR6/rUqsmoWtX2e19Ezekc5+oxcWl9GqMpyCYYgtx35JOhQuWfDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900892; c=relaxed/simple;
	bh=CegQqRFuqlc9nmUZhONlI9V90i8TTKIkWiyFzRWbXKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dStdIn6grbDywWebziHp3yVibXyNKTup70bseOg/R0ycRFcws/zNUBpGoEhFwtqPPYR68rjjD7gdEtEr1Oz1zNIZI9JA3DLlqy0ocRqj0s1hX2bCWCJ2n7iC0kTMwsi4LI9DeLUZMY4Ex+DvWr51YrBD4+1448iBokhwtosDgk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YHb6pbBb; arc=fail smtp.client-ip=40.107.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YHb6pbBb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ol1GdzSA6CBBePey0o48Tt/hUWGrMKWy+f2jetTp+dJ+8cvP3CyUOy4pEc1qtoP4lDwbvGpXshme9ASsWeY1xLUG+RNm8pkisB34ilVWX5dfSfKMeg0EhuLHoPrxFHIkojHgZShTcC56aGpfSkdXYHrVcBNzlJumetN4ojtObozFJCiliZrIyTMKU2sSyq3P7/5ao/UdZS3NHvjUSURNfGgAbdP1NcRT005zSEqUC+eefamQE6wRe/O9jWdaheO3YZwELHwGeo1bLZzHe7a+gXHWPcUxEV+RQMtd0ICnRPTefEutfE88iJ+4xuTcYdvOavErImGAm1MEBd/hx0h06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDPEkF3O1LEtGIz50Hmld0+RsA/DW3ndoCE2XoUKVXU=;
 b=trHLMW8TAtmqlDL6BV8A/UoOsOrUwuVEBOoc/10RC1uv+YSjm34sR7D6CWV6NQyHFDFCADgPmaEs3MfhfxNYEUl83kKFvmx69R+AJMb2+7GEa/r6NopfakGFOGjNqOuYbPRKkCoaZJXBR6Xvba+YOEu1TJQKhAUFZKlVezO5/xBiW7FMF6xow/5TiggDRQRkVaJQVnbCh7niW+NDV3cZ59BHoCSkpbxMwn7mVIkzwUAZ9V0hLSFetFnOObGUobyfUHTrlfrZGTknWH4ovkwUQRtnNZDmjfDB6fKOMK7l3gAVUUIt2JB739fvdnRaq5CoQUlPTpA27EnCweqNEUFthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDPEkF3O1LEtGIz50Hmld0+RsA/DW3ndoCE2XoUKVXU=;
 b=YHb6pbBb8n7cBChGkFyITZPodh23M+I6ZGz6wKxF7Q6rCpAvhZGCqjdhCYr9ij01Y0SUL8mkYiFGK5ywFrjYGxSqK3WyyyPbKn8yZLwqfHPF2tDLOmjVcff1einvQV7PhCf7oNG6jFcTyBj5GEdlwmRQ1S2c9pDaJxKP6NcJ0X0=
Received: from CH0PR04CA0076.namprd04.prod.outlook.com (2603:10b6:610:74::21)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:54:45 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::86) by CH0PR04CA0076.outlook.office365.com
 (2603:10b6:610:74::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 20:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:54:43 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:54:42 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 12/19] accel/kvm: Re-order attribute notifications for in-place conversion
Date: Tue, 8 Sep 2026 15:48:32 -0500
Message-ID: <20260908205236.838281-13-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 09550cf7-3b63-49c6-2e35-08df0deb689e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|23010399003|1800799024|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p2iwHb+wUOeqsLpS8uX0mJXpmBY1e+dmhXvpS4nnbTwKjOgc/2PVy7gGcvRA9SyIFvm93N1bwkw8Hl3qaRtx6XvaGd7tuSg9I1As7OsDtpSFuNkvPdTcZhaFJNguLbMEeNaRX4JDPr47FyrYAMluQj2PWHGVMu3TU0SWM953lCw6Q57IkKEqYd2VFoJKkDMylefWu6eSYfflVdBcLU7e7eqkzMSRuv1RY2aDmazPjeuVezImccXnrDrRd07/6Qxch0vy/6MIen/viobQJgy5KnCmu3B1mlSu1h2TSiZjNeo8sXpYO2KvO55CuSb+MRhFIy0ZVKngqP9AvAFjeZEHBQ03Xf/hAqQ0id8K8ObGGYkN4/1ByhqFaEPfBXY8mxNSXZm6gnQYTrGgcz/WU55iVA5SuJEVI3h3jHoW4aDpz7VnNb9hmRzQ2HEm39ehpbj0d5ybtersxlYdZTxlai4XcpvsPj7od59+5NJlwZz3nu7P+RcK79V91aIXlMBCO6yljA7B98v6OTf9c8naWKUgGnTkCwOQDaWaFd1g42yTIj9PdCMJbe1aTXj+yn4uHyhgIfBJnaylWfTRax/jaKKboGvjqp4xUj7kbiYQvFn1AoTcYh9FHg6qJxZMEPr550yAHpx/aY8GuCwwmD/Iqzjcgx+pyRE2RnJOo4bfZgABMPUofIh8zfd4DxiXWoAKRTwLQI8OCkwP6ufc82D42L+tCg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n1VDXVrcOuNJpkgkrD04EywYe6qmPdWXHNNqJM9km2CheqqvWpn3iIP2AGEsTgPpF/pUVgbG8uujhmb+pM/M8BlhcZJ6KE3oqZLxVM4/6rsJW2VOlCKEsZrUCWl+1MVa7w27FKhG5vixa5U/keLmACa66V9H3mIhT6tOqIJ6GPgpu8xvK8O69OqIjainDTZ32yREShIOOlRpKFueiLV7H4gesTW3u+zE1Ou3SUlWcnITa+14RI6Yumwpl2tpfeX3ZXxuhDsHxk/hUqvwfTodrMcJ8JgXgTvjvsUcBHxPaBb6bLqDQ6rqpVOQv4a2/2W1ks6PQcb/E35LK1A/bdYhX+t1KdqjqnIrz5RW4ErG10EKxbMPXdcSloikNbh1zqzdiUOqgIg/0ULZ3HZn09UG7Xt++D5KQ+OuYtX+sUJYbveiX3zg5tgbh5xVE8y7B83d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:54:43.3029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09550cf7-3b63-49c6-2e35-08df0deb689e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

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
index b6a3839055..17e25f9074 100644
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

