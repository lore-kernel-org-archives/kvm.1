Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1F3B47DD
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901039; cv=fail; b=ss4I5sROSPKjMytQCkttuM8ah3lDuOsjXRx+S1TGlkE/edrnYh6TBnReJNRNgDh0dC2uAMLNSlZ+bKzF8cT+jsXajJ877gD+HasJrzk5xB8dQ5vUVROdMdftZjU/G8bXRXLBMhMVdYv0qCJZy6+Q7r1VZ3hkW0jK55gO6+C5bGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901039; c=relaxed/simple;
	bh=zwZcmC+TW2TxPG3c7lGHcsODPpQE3QLggBnOLmPFAjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfldQpL14MoKufhdzb8VL24xnAGnjg4JeNn9Cz7IV4wA3OrB6wrlHw2t4i49VDreK9GxsZYN/Cvrx4YhgJatO6pmpZ3G+6JrTI/mXer5pxDIsDKHB8ggkDuFihdizpjsuTfeJBpk2gnLVLQUIEvz/euG9sjshBXsOTIgjrtgMGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rPBbVxfE; arc=fail smtp.client-ip=40.107.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rPBbVxfE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBQy4h9DrXD+MjW1TWFypuUtVYSr3RNDFXTUF8LMYhFRXUHng0kNTpKSnn0bK3OS00r5jRowmb6WM8xESu+2FTeSYkgELYTVws/+IR+iHv7N/+pdgTcgkn4Drl4wGU0wLWm6LAYOH/wLmSm6PAQrI7wqmwifNpMUU8m9YCHQf4HJG0lMuNAZe1AeEEvyFdvaMhk6YbyCK7EA6Oa1MaOQW0vOf4D69eRSrMreWSnKNGThB3t9t/7ld56a0UfKYg+zJiBZUWaxLVaT78SVSN1KWLmPW8gu5I0WVPbNliLPsRnY+jQsycOdTxksXdRY7DVB3wedi2QslYp1jY2HgxvSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSaVACk1QKzdOchQHcxYxDY+BjmYwoEOlDOMHbWhWwE=;
 b=nAcUWzNgxVj4OS0yI2QhaeaYDbX6fBGXyp4uyPCJNoeH4Ud7byMSaIysmZCHmNEVVusUWvty2ahnOWp6lD+XxUiAfgJHafEtGByXGVgNCr8sZ1sdKSzWZVMGkMDErK39ntmoGPIG2WS6YUBPuq0fbiOTfSImpzFSLsDdgQGdjM1Vep5QAzuZmgrTWVw7FT+p1tgCfRCCa99iKkAAJidA9m0NpeukTUTGlRvh8AmcFt7MlGdW4XuAPfe6RbWa8NrC1U/e5Rx/7DeKcOSsplUa0TTVh8kK7AwqgNIJ2UycG7M+UJtozzNncxrpNq6yy6cw/d6xLUDpJV+C3ystyNUntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSaVACk1QKzdOchQHcxYxDY+BjmYwoEOlDOMHbWhWwE=;
 b=rPBbVxfETOTA5bJpoPZOt5QFy92Rb9Xd2gT5eVXCVJiX79b7rYO7ECPXXpG8zQY0fC3qd/NHfMiWGsQ57+g3BSQI4qk2vlUtSMuYWGi+wYq9fFSPJ0TKyZXZT2e3WuDDrF9+XDxrn/RrMhjugc9X/BFfieT13fVg2v0YY2nr9qk=
Received: from CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::26)
 by CH1PPF989868826.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 20:57:12 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::4e) by CH0P221CA0017.outlook.office365.com
 (2603:10b6:610:11c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 20:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:57:11 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:57:07 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 19/19] hostmem: Automatically select set guest-memfd=on for in-place conversion
Date: Tue, 8 Sep 2026 15:48:39 -0500
Message-ID: <20260908205236.838281-20-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CH1PPF989868826:EE_
X-MS-Office365-Filtering-Correlation-Id: 1079e8a9-5bc7-4881-ac27-08df0debc120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|7416014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7ECmAbuWaaXUcZVjS8kbs1ieW3B/hIsegoohwckfyA/pTABgtj+ly670HPoXOaXdG0r+OBnVccpn2nMMsedR3znVrC/RtBtLfF64ecKt/A91Y3MBAKcELbQavQukSR1B5zDzgiwHYHzUBP1p7/EmL+mqMkvoJx+ZibiRwgGX6DRo97XKQjfsQfnEcB/m/xDAGq8faRxb+ANhzgiF9ykCk7NFU5PEF+6Lalq1kcl3t+zCUAnVZebtdh+W1q1LeZ1xX4vIqZf4quK+ob38EjBwZ7VxOfTx9RZ9mILwN2NJPg7qf4j2ny/kC7d1Cdm1o7YQD2uIYbvbbLfWGiIObCBLv12RDxab4fh27M502uKSq3lXmG3kGAyHMeUACxSC72crI17c6J8BgvjjUOwuzAh0+Z57CJm/cpUC19sWyn4iN7UmwlpaLPssS5P7L4Nvr0mL6ylsbRzhUDGgiqqqY2B2jiCfCtqcW7CmStXM9UbRqEDb+QW38mnmqYHLLk/eamokCQ3zOCWJ597Hq9oSudSY/7obF8P1eqSQB0IZYHSW/JI9Mr3elsulACffuJInOUaPnwQd73jwXXnruN2Ev3JumjoN1fFR/bB4WLCcx1zTI1PsYi9aMW6GKoNMRt6Iapdcexd6r65GqZcuBSpjb4YCnsoGmjIj+leYTQr6MtsMwM2xjYFDaluO8301WzZ4wl4QAhGEz9O+NmRarbQ0QtvaJg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(7416014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L09sqQot4BjpjhvmCZvPrao5me5QQ6/pMcr+STWd0aihJiwzWGkyrMYDqNK5nVb2maa86ZXZL8TL8eKgCoaRueZfKycKHGJwvgPoK16C8nzwqqG0ZtHnC3vTYY+lMAkY53YfbHu8sxbg68aP4L2rYaPKBB6VD/TfLT/52ME2JwSFg4+1dqZRzQCJyRBXWVgVKIEOJzx4qKDhO3JIh69KmRcOT3ENNxclyAkvq80ohwu80ALH3GbT1VWdAw0bxaKdnVu77Z2Ec1lqZ0ufkQQZW4FAFM+AMSsKAAfxMYGcgeDgmzAKrL79xVxESeIXLUMAGvny/AAIxk5PlNJUMRVjTYJAz/lCdCv9WklmsZTYa9mhvV3yuSUovlUN/Z4mL0GpVwjmMgTy0bloAQNROGaVpokLp9ldTeKS7rHOL0mWTiADNjuc2Stt6eCHb89qvOm7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:57:11.8236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1079e8a9-5bc7-4881-ac27-08df0debc120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF989868826

When in-place conversion is enabled, both the shared memory and private
memory must come from the same guest_memfd instance. Thus, the
memory-backend-memfd options must in turn correspond to a guest_memfd
instance, e.g. guest-memfd=on must be specified. Since there is no
use-case for enabling in-place conversion without setting
guest-memfd=on, just set it automatically if in-place conversion is
enabled.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 backends/hostmem-memfd.c | 34 ++++++++++++++++++++++++----------
 qapi/qom.json            |  5 +++--
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index de51cf738a..85ed973082 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -19,6 +19,9 @@
 #include "qom/object.h"
 #include "migration/cpr.h"
 #include "system/kvm.h"
+#include "qapi/qapi-visit-common.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
 
@@ -35,7 +38,7 @@ struct HostMemoryBackendMemfd {
      * private pages.  Instead, this flag marks the memory backend will
      * 100% use the guest-memfd pages in-place.
      */
-    bool guest_memfd;
+    OnOffAuto guest_memfd;
 };
 
 static bool
@@ -43,6 +46,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(backend);
     g_autofree char *name = host_memory_backend_get_name(backend);
+    MachineState *machine = MACHINE(qdev_get_machine());
     int fd = cpr_find_fd(name, 0);
     uint32_t ram_flags;
 
@@ -55,7 +59,9 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         goto have_fd;
     }
 
-    if (m->guest_memfd) {
+    if (m->guest_memfd == ON_OFF_AUTO_ON ||
+        (m->guest_memfd == ON_OFF_AUTO_AUTO &&
+         machine_require_guest_memfd_convert_in_place(machine))) {
         /*
          * NOTE: guest-memfd ignores seal=on/off because it always
          * implicitly seals the FD by definition.
@@ -91,16 +97,24 @@ have_fd:
                                           backend->size, ram_flags, fd, 0, errp);
 }
 
-static bool
-memfd_backend_get_guest_memfd(Object *o, Error **errp)
+static void
+memfd_backend_get_guest_memfd(Object *o, Visitor *v,
+                              const char *value, void *opaque,
+                              Error **errp)
 {
-    return MEMORY_BACKEND_MEMFD(o)->guest_memfd;
+    HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(o);
+
+    visit_type_OnOffAuto(v, value, &m->guest_memfd, errp);
 }
 
 static void
-memfd_backend_set_guest_memfd(Object *o, bool value, Error **errp)
+memfd_backend_set_guest_memfd(Object *o, Visitor *v,
+                              const char *value, void *opaque,
+                              Error **errp)
 {
-    MEMORY_BACKEND_MEMFD(o)->guest_memfd = value;
+    HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(o);
+
+    visit_type_OnOffAuto(v, value, &m->guest_memfd, errp);
 }
 
 static bool
@@ -191,9 +205,9 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
                                               "Huge pages size (ex: 2M, 1G)");
     }
 
-    object_class_property_add_bool(oc, "guest-memfd",
-                                   memfd_backend_get_guest_memfd,
-                                   memfd_backend_set_guest_memfd);
+    object_class_property_add(oc, "guest-memfd", "OnOffAuto",
+                              memfd_backend_get_guest_memfd,
+                              memfd_backend_set_guest_memfd, NULL, NULL);
     object_class_property_set_description(oc, "guest-memfd",
                                           "Use guest memfd");
 
diff --git a/qapi/qom.json b/qapi/qom.json
index 20d6fefb04..32df7cb794 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -772,7 +772,8 @@
 #     resizing of the memory (default: true)
 #
 # @guest-memfd: if true, use guest-memfd to back the memory region.
-#     (default: false, since: 11.2)
+#     (default: true for Confidential VMs with in-place conversion,
+#     false otherwise, since: 11.2)
 #
 # Since: 2.12
 ##
@@ -781,7 +782,7 @@
   'data': { '*hugetlb': 'bool',
             '*hugetlbsize': 'size',
             '*seal': 'bool',
-            '*guest-memfd': 'bool' },
+            '*guest-memfd': 'OnOffAuto' },
   'if': 'CONFIG_LINUX' }
 
 ##
-- 
2.43.0

