Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7013B47CC
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900870; cv=fail; b=nozuwkdE7mK3qQUViRbs2Yb3qtILo0ujqh0hJoWMJ0/qFKGr7JSRPlXmXajb4+Oxaab9m+Nx8rqVeWraXUkN67108orBjz+eYI8TqbFCCNgAJSRIazi/imDynxa5MXGBHR5lS0JcEqoNHTMwmIECSMzYyRUrwSZh4923vYg2iQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900870; c=relaxed/simple;
	bh=OXHVz2NoopKPrx98s9QVrnPqqG716ugMZMCBi7mzSfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqoTdKE07ETv3Y1RszHouRQKLrb7FYUb1OZM11ODXHD0kvyv6j21EF76Lu7r19jg25TA1VGDzpJ7/i8J8GYNWPTDmkZu3IhRrlhxfZalEAmx6s6uW53ay23LitnLygiqvLyaTWL5R2bCGucXQhmkrteBA6Xsnyse2wW2sbUK62A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cbwBqQG7; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cbwBqQG7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJKRZHNaTzm3Y2+lJk9c7AQ1ULcPYPsU5vx7JGw1HQq9/ofP0G7TE/t/5Kq+wB5aQm1VAwVpYDeWquKgnbG/Cz82QGsrpc6iqbVCZTLm9TRSZFPKmvRrE/QQAEl8m6/+KkpFH0BkU8Htb+0QR1dKqm94doWT2w22d0HHKxUSZK2i7rbZveC3VA9+CtMmQzTaws8SHai7qKsHAiqegMZZ3AvefxRvtN4lFH4BP6/bgPbo2nZR6i9ua3q2Y/lpEGHQx8u1IxVRsAm3YsuKNUvlD6QnC4G+HSD3lg4JpHgKRS+URGqBSugdykP82BxclHhiQb6I2NghFks7XC1aKKbr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A3fx22BjFILEGOnOCgXQYJanWV9QN2/jwNgofmQzwM=;
 b=qaQrtLRpxoJYkShAKta4bXmrjfv18rg4Gl1xNGegky5r/jQp6QKxV76BD2k31v5xrz3Sjv3M3BSxh0kGWwCicdtIfMFJ94RPoSGKab4cNLHtyvN9nfyT3p9nzYnS9oPhifYTMfMGP4qYAvyOTgW6wqNpSzCSH1LE9jn00BizpNo5ZXkJ/p4Fq/vinQV6vFIwmPsWJ4wkQAgH0fsr4a6d4cPJbv2aQDIX9IAdQmkl3I9+AoCkutN385Lq8YTslxYEjj0z50HNQeRuVGLMGexCt7cmVBb2ecIvvyEZ2TBcqrHsOlxX2p5H4O0fEsRmkT7vQf6jVFFVqTFoMqxI9GEsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A3fx22BjFILEGOnOCgXQYJanWV9QN2/jwNgofmQzwM=;
 b=cbwBqQG7SvzNeks3fqkepFjY5ngrLoegwKecCNw2EFf3sxxNCdEp2W2i71cAxkU+IoP4X9p5dkYfGjPVy5Z2agJfg5fn3TUlwSxfdNPBQ8Gq8tE35wwVB1LyVUberPaXr8no+DA1mgylJBTlBAi1ZW1P36N0MfgbdqQcil5vi4A=
Received: from CH2PR12CA0008.namprd12.prod.outlook.com (2603:10b6:610:57::18)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 20:54:26 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::a5) by CH2PR12CA0008.outlook.office365.com
 (2603:10b6:610:57::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:54:24 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:54:22 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 11/19] accel/kvm: Move post-conversion updates to a separate helper
Date: Tue, 8 Sep 2026 15:48:31 -0500
Message-ID: <20260908205236.838281-12-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 03915917-c662-477e-80d6-08df0deb5d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|376014|82310400026|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MYmEEtgli54Vk7Ygi/3SuuZI0nUdM6wB59uZd8DgMs2mAs/IUv22VRqExN6rrAt/D8W/jVRpQYkJbHpj6BOsEgwSoMAoVcGG+PkW8IB9Qkc5yf4MDG6wUX20lLFgUyi39V6rZN0sPXKEmjyJGQzBUB1Vb8S+BL0RLK323qO5oQOoREmhG6D/ZCL4H7FCCEprBwsLJfrCdDaF1f4WhUG8oCn+f4IbEthNtzJw1w9IIXhtVQ5bPBQddiC2uxnJCG7S9xy/0ZtnD9P5thFtUtH+9qphpr9PwILIh8XXOvGEZH1AS4vNwTnaFAQilwxhptemc5iTKKdLyT6miiQCBCLou7iJc0kS2mY+Dw7u0ZQJPFDL4QUzWe/aHA1jvLLFHaOTd+6amoqA7ekW/ThS114KtbN6rpodI4Jm4gmvL3MjrxT0F4yeL37gKCcpg7laHV8vqfyN7+bSidYyeZqO/+Ho8GotjaDhNKsZZKobSxpG38FY/45jZAmkWxfZtu6RlDDwnM7FeDciq2S9yCUTUGuAlN16hgEjYBY5XsuDM9fZtjDAIZ+sYqJkmroF71xEVu6j+ci6HwRohyA2m2XTBpxO3m07fwHh9sXyHQK7UKqp5caRmyu6RYsu+n1B9Slj0UyRFH/V2O+H0gzD1pwHswTrUmELR8CXuJ7Y6LmmWm0igHL+7XTjFSCHHCMFW4nv/AQFjwzoRoEdQd7mz3WemAnN2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k6K2Q22viyC08WIix2mOHhW3UAcHMwnatklpbz458tAV56hge9OZ4TGWeY36uaZmcCKAxovZnxZD4W6XMz4HlymaKWS4hlVkAQ1/HnSuXPdvsX3gm5yyvALBB1fHM/ip2T6MwRA4iR1RV4NuNE1lPTtTFIwBV4HIA7qd7F/F9pvErQGo6S8Q4JLnb8aC0nqKJ8fSbUsRFEjkAV6t6dQDf4e7E0hxrbyNY0WadrpXykTEsboWNfrCgwBtKG7um2lzrV9Uoxep/v8cyxEVsY+SNzamSrxB7AqHWEufePYXRr9XHh1yyFnRnYXiktIx+4lBjG+DXhyCiNnGzO07sClfOKZXxnbcv7QDRBtnn8hKNFLnSSMloG8p829+zL+q9ZtYRpFS31XiWTLrvWc9YNw9cSlo6iOlU6oYrWpCEwJHDQ+xvECDUCc8jSvbwgzEFEEn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:54:24.6781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03915917-c662-477e-80d6-08df0deb5d84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442

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
index bf81a19423..b6a3839055 100644
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

