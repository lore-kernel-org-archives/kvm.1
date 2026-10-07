Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE673D954D
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380711; cv=fail; b=rjoTPXQfHDSwt6HQPHEQJ4mhbnuzfn3ZQ6HWhN4FVKv4g2kJS/TljfX0P/2hfqO2yJ5zQoDyjUN5X4SKe96ASuF7lwvmGpuimhyzBlb1Y+VzI1RBpz3fng7dshHOLWGEia8O7FsND++0m2mwWhMumHHV4s+ceeODxatWcb4kQfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380711; c=relaxed/simple;
	bh=Ebmlg4jRqH1JqHCgRcTtWSrWgz+2JKS+M91jW/wxhXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aU7mGzHh2J7cfCFRQ1KJvcuAbnZLoqGeqrpHeZxhFiExTi1QphjHfwOYFXqyru7VxEFDVxAz1C7BGqDzrh6KA0MkZVndU5g0Axaz6TRQ4O+CK/U+ZHBKWxU2QB8y8iavnFrQPSPC5qa/F6e3VLCWe1FBnuxSEhapCfm2bvaKKl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0JKLhG+B; arc=fail smtp.client-ip=52.101.62.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0JKLhG+B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbIzayLPKxhwYpaT+AuBMpFdF6w0RzxPe2e40YMTFHf+hZBajA8XcVZQTGo+6LxJ36LX+e8jyobqUJ7LUqtsBAI+CT9PYu698eqVmlNaEea/xz+qlXncF/HmDCOsIJUTrc9Ed4wJZT8jbVmikHn8IF8/god8zqW9uO4/l4Lfq+HWtOLiYhG9XoPnnl8+4bXX1ImpxXt6hes+I2mhvfMKmqStBtq8UvTKU1hLXWYSnhllSFq2PGSULylKAhdAXAY150SnyRw2JztpaW9J/+A1XYXbmIZh64/h3IM0tRvJeetrbBCAUlhX+4cdHmNG4phFMZKBy8mg8YtsVOSGCvykOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfaxWhJESjdAaPl6lor0aGqn0le6Iz1fBpsD6EIZ9hQ=;
 b=qHLHn/I4C3Y3rku6rCcxyI+jtBtTGGEF1ovZrysC1oTyknTWdpPwDnTJwk5Y774eEx3BAraxZy0SkDtGCPMxnEn1dOWMpexZPcc4KQauLrrUKy7cNoyHD47KY+mGF+R7NsppA+VdDgQ8S0bn0XinB1QDt7cN0ywyOSNkVUoarlxTiKI4p1HGqiEzxA712syLN3ZTFMT/mKLkegIhId8AY/rZExJrlyfclzCoDvu3kjSHdh7jDdxM//8btn1dmrlECR52YMh+W0ub6TUB8Ql55h4tVbKvZ9uWZDGo8VMKrEz4N9m/juSImy0VQBxGydTgDSdph2pABY4459lcfGF4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfaxWhJESjdAaPl6lor0aGqn0le6Iz1fBpsD6EIZ9hQ=;
 b=0JKLhG+BWI7e1eoGp5ubRBVOdOesg+9HcYmK/VCkoGMcTBu9Zm0We7FATCtVXQCAZ3dRUoIkRbx4tvZYgFg7ptwA8jeFloi87FyXEh2ags1/buy8kOEWearoNmKz6KlpPbZysw2YdWc4RLe6RznLhD7egK2BwMNTfA0AcHeQ0cE=
Received: from YT3PR01CA0138.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:83::25)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:44:49 +0000
Received: from IA0PEPF0000003B.namprd03.prod.outlook.com
 (2603:10b6:b01:83:cafe::2b) by YT3PR01CA0138.outlook.office365.com
 (2603:10b6:b01:83::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:44:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003B.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:44:48 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:44:47 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 11/19] accel/kvm: Move post-conversion updates to a separate helper
Date: Wed, 7 Oct 2026 08:41:35 -0500
Message-ID: <20261007134323.1606088-12-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003B:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0fe0c2-f9ed-4049-0ded-08df247927dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cZvD+V5vvZihfYLf/IfBwhhgs0FrlieVoPml1FcaISUDrIgVS/4C8LRL1QvzG6Jo3jl1mkJ4yiEaOT4rq2Yhnxix+6iiyq98XD9UZ8rd/urbpBw5EX74/LT5QH4UmUtuT7vaxA6nyaXbM5505MF6564NUYlaXUWxGrZCbVdBCjQDZdRQnH66SOk9CFy/wjivufHxzIw0zHXBqNBToGDnKHDi1t/+CNtMttYs3B2U7690QTEPJxc8NTV4LU6+28pCBe5n8GXVE1TEFSDLu2gQ7DQTNP6uU41RWVaaINWM3h2ir1N2e99cnnRD8E7viWBWIn6GoOu90zAkRNWNquI6JN9NKEym4k+YW4qD37e5S0ZgTgTRFARmJwHd7aMoJRpRsIQUK7rLQYlZd0ytJ+J/w2z47y60XuiylTDEqF5T3wjM8qYl3D9HnJxea8pJnsO9N5Pu0TM8RoKSyEw3Q7rI+NNFqS5ZXsnMlgWL9aWUlv6zA9zhhbG4MNbjDiHpBbnnN2eGe1u9mDCjhoPQ4IA1kyWprZj3oCVRiNz2JcJ+DkYP/l2jOUW+r8B/37tCepLU0LvVYo01V6xhJtOHkVWDdXnYgrk9yd17XQImnQV4oYmXGpacW91uXfA9I3AUvwtYbAYIOHC37iV/bhOuBO4PU7ikcDz0Pgg8WJXZQ5+cJYP/R9gHS2YgXSUhV0OY15XXgcJJduQG29MECWsCJDc3tQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	itIKb9MNJnWKpIq1Kh8uW2C73wuFjCU7ytdUnvNqOsrSdapl+m8mwBXvMgg7uY3mJ8Xwn8B21ufjahiwXWKYH545JQc8jPXTY//NNAo2MB1pqN/BD8w8DMhgWiu24uewAhLK3ZnGMdSufaHKuP0RQK6lSRc2miCblc6igPBceN00l/mQuoGZ7i4HAjPbYsge561KhNXWFnrZMo3qGMNKbIVVCciXT75HvieRu7wGHpUr280f8q4LGJkEf2YAZgjlj9855H/MmtLjgrvhJUzQb0z1xfk8A/r6k7LqKf8fvrs8AF70Al9lQyQJLbFHk2CAt5ckgLz5FKp4IoVNqgorTKhx8UbaEHpscMjPJhUj91QGAW9l5/Yomnpnqxl0rVFE43ir70ywb+HVCTBW9gJ1BTepuVDzLRJ7pGw5Q4bfq+0fo79ln1GEoLTXsQ1pxL0C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:44:48.7898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0fe0c2-f9ed-4049-0ded-08df247927dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313

Currently memory attribute conversions are followed up by other
bookkeeping tasks like discarding unused memory or issuing iommufd
notifications. Move these tasks to a separate post-conversions helper to
better compartmentalize and track these tasks, and in doing so lay the
groundwork for a pre-conversion helper which will be needed in the
future.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 8cd1671ad5..b824b803cb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3437,20 +3437,26 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
 {
     hwaddr start = section->offset_within_address_space;
     hwaddr size = int128_get64(section->size);
-    MemoryRegion *mr = section->mr;
-    ram_addr_t offset;
-    RAMBlock *rb;
-    void *addr;
-    int ret = -EINVAL;
+    int ret;
 
     if (to_private) {
         ret = kvm_set_memory_attributes_private(start, size);
     } else {
         ret = kvm_set_memory_attributes_shared(start, size);
     }
-    if (ret) {
-        return ret;
-    }
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
 
     addr = memory_region_get_ram_ptr(mr) + section->offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
@@ -3525,6 +3531,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         }
 
         ret = kvm_convert_section(&section, to_private);
+        if (ret) {
+            memory_region_unref(section.mr);
+            break;
+        }
+
+        ret = kvm_post_convert_section(&section, to_private);
         memory_region_unref(section.mr);
 
         if (ret) {
-- 
2.43.0

