Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD9664
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926829; cv=fail; b=rbVVCID4JZUJmdFhCpI5+FU/w7u2ZnpI7ahv2YFz0r9eQz1zbnDnBCyiT7nOXkWzSzB1ujI327KDDCESd2LtDkA2pcB/AxiSHDePk3ZrC7D7kmPFaKtbWdgAKoVS5nZNlF9AnLevEuZt3Hiehd8l7XOFHONHzAv/XmgkSsI332I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926829; c=relaxed/simple;
	bh=v56aEEinsm/c+cu46debqvmO6oZH6kozzYbLNMGx4E8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8ISLxmiL4IxLVluYnX7wpprXu7JzdwAn4e+ZPil/Kovm5NflNJQQN2N82nJpiOzSzwAwwdAlIFvJGmwnBHh6DJ/SKRF0gNYg58JhtJuQuBFo+i3pVBGhdiNw84fq0q7XIpTWeJw/l0IZ2f7/gwC8pqw9eTnNtB1Ajr10RpFV5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U+G/5UwR; arc=fail smtp.client-ip=52.101.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U+G/5UwR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZTDSa7JhMNgrXKqhzpkcRrrPgHcePV6/RUtLw8vj3NiTRXWhdjAkLQcHpLcKy385nkhVPzmf+HemcDKNBvWOpar4eBFUya7TYGBRzyVs6QsF/UzScHNxhFmlkLqAUCNpCoqA4CG8wjZu5sTpwXqT5wxRTPJimnkHSshDo1Kx6/aZntaZYTLMGGzB7vUk3nCSYZnrig2btrnkZX0xeHVdCvu8HgAnEuvcM7WYrUbymgiQ1KVZXCDWcu6hosQNJv9V8N+DSKkQUZ0Qomnnluh2Qa3519fPFJy3pIGxOf/JQKDQOHWLmLysXelxio47J1BPInEJU23JxCxGW+T8CwbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPSEL+debwnbzMHvk7DlbLgXycL1K8gupIP8QRoxvik=;
 b=d30NMuv5cuwfMs5znklHJ0Iyze1QeUY3EqpmaIYgBKBtLGsYmG4Q7TN19Pkuae13cHXFU/zOnfcZqJGamQtKY//zUt+Ty0D0QbVErMuxCuWiu4QXBw3wLpSJE4aILL84ODcdN+E92xr7pDbEf26MpCo29MmD6OJMWVohGPcD6tYv3kLe4dPiE0c0ompT+uerptzut6iCId59925rtZ6TYlZiyQo1f90kutCN6yyRrl9LQcue50yiosMPfMpyyG/S1uJ2h89etTVdww+WKJMWiQoJ1T1AdpklrPGtB0iG/kU0kq4NpQbmAtmUHVZpt+abMg87x2GXQMnPW37noYVyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPSEL+debwnbzMHvk7DlbLgXycL1K8gupIP8QRoxvik=;
 b=U+G/5UwRFmM1HCeOsTmYHdFr4qmObaqcilfOg6G9B6OnkJ6l/+YhfBucHmtUWKz8q7BKIhqvddlWk2KPsdgr+j5TRpElDi1o2Ix1JQEFQcj4TFhikzE1potOtjkCWnxFfXuDHEShhMN7PLRrb/SZnqWrQPUonpV5C1hEAylw44I=
Received: from SA9P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::30)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 28 May
 2026 00:07:01 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::22) by SA9P221CA0025.outlook.office365.com
 (2603:10b6:806:25::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 00:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:07:00 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:07:00 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 02/12] hostmem: Introduce dedicated memory backend for guest_memfd
Date: Wed, 27 May 2026 19:03:27 -0500
Message-ID: <20260528000416.8161-3-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 4968c41e-bae7-4877-dce9-08debc4d0a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	TcqXHLrXdQMQpooAD6zkNglNOt9l+bW+6C9mOkUlU+tSlmAu3LjFWOtTGdidcNpa0vRiEN3JVWPx6SzUif/Bvh1uaSFbEziOLO724gGjLTg2lCKxUBZujUwIjnmAloB9pgjbEKjcOPgnHCBvxSKh/TnPU4uBc/0TMRhEkQFBo5XbWQstW2C3cZFnMW2nsdm5fUXT6K02JM1FOwEAeYd2Hdr05YC2QAKlGnlykSCc2YYMIoFQ2CSy39twKWMxH0jeTcqns0J/ff79ZX8w/lqdFGhF5gmKVZvGKv8jXw0oJGE2X1qfTqWqxKoyKUzJ5L8dVZfvqXxMbIX9SlW4zR4w5qXJp5Q28avrpQ9B8f6aGiI5CxgAhlegx5JWZWj3+98TJyrB1MLeD4Z3OaFQCDP7xpv8dTMKymw3a1LWS6voy+miQ0rX74LEqNRiqXESKk10spoAOfbb0AOTl457moYDuXU+KuZ0l4eO4n29hffPlclACZXOUGah5tHi8hDXAoUaj7Oot7WBztt+f6IqF+Ik5uRDKVZcW/le0ARVKnaa8+Qs1gEwaZcOb/meE5aqE8EqG918agQYG1BTGEsnuLb5fJ2TQo2S5B9r0/sugA82WbcGh3y262ZFVO+wRu1bPXkSQykUS1IPvP/mZJCQu0hSAEsZ7nfv2o3LOEsBLYVSfGnoqhJQ2y6YpIEffXRLhYlKivDMYSEUUTQe9a8YDLtCwvKz8c5LDMM2a9vcyW4Y3yQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HelIj+BSiMAhAPxbJZIlPLJ/ofB/5GQ0s7I+aX0D27konJ3SSkGYP5jWvrINeiS9SNV4aWkNRfGd3s9C9BBCw8W1LzG62LsCG2NpVEKkW57aVRm9g9BY4x/rlPL37c1gvgVXQ5cpy78bMRvX4ssOeD7GGCx1RQS5LYoRG1aig8Z0RPsqbX2doIGoBQWuQSbjH9F+1fq1FwNjny0t5PEKvx3IwDD+V9Lu3+Q0+tmSUMMpRgWiCPqBaY7HvARNgo92LibLy7oa2u20doI3Pl2/L2vQVVH5x4e8eyq9SUovQIHMBDann5zVMgi3JpJvPT6/dSigPJeleWJVl+Hz10NpVj0yJslQtQvTJfQGtjLarMGI6OYOSup0OttyTyoFFRqwEQlSmUqBc53OShkRgQhzEvmcdlSBo+WXkUNXsL6Tly2SMUEyPtMc0V2I0yuM8Aeb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:07:00.7850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4968c41e-bae7-4877-dce9-08debc4d0a89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659

In the initial implementation of guest_memfd in the linux kernel, it
was not possible to map memory into userspace for direct access; instead
the memory provided by the memory backend would be used for cases where
a confidential VM wants to access normal/unprotected/unencrypted memory
that can be used for shared memory use cases, and for access to private
memory a guest_memfd could be associated with the same memslot. A memory
'private' attribute set via KVM_SET_MEMORY_ATTRIBUTES could then be used
to have KVM route to the approprate backing memory.

In that model, it didn't make sense to introduce a specific backend for
guest_memfd, since there was always a generally need to have a separate
backend type to handle shared memory access/allocation. Instead, QEMU
configures the guest_memfd support for the associated memslots
internally for cases where it is running a confidential VM.

However, with recent changes in guest_memfd kernel support, it is now
possible to mmap() a guest_memfd FD into userspace and use it for shared
memory, as well as continue to use the same physical pages for the same
GPA ranges after they are converted to private ("in-place conversion").

To enable the use of this mmap()-able/guest_memfd-provided memory to be
used for normal/shared memory instead of just for private memory,
introduce a dedicated guest_memfd memory backend that can be used both
for confidential VMs that wish to make use of in-place conversion, as
well as for non-confidential VMs that just want to make use of
guest_memfd for normal memory (which can be useful both for testing as
well as a stepping stone to things like software-protected VMs where the
host can be trusted to provided some additional degree of isolation for
the VM independently of hardware support).

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c            | 15 ++++++
 accel/stubs/kvm-stub.c         |  6 +++
 backends/hostmem-guest-memfd.c | 92 ++++++++++++++++++++++++++++++++++
 backends/meson.build           |  1 +
 include/system/hostmem.h       |  1 +
 include/system/kvm.h           |  1 +
 qapi/qom.json                  | 19 ++++++-
 qemu-options.hx                |  5 ++
 8 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 backends/hostmem-guest-memfd.c

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 02911ff6e3..e6ae2e8ced 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -108,6 +108,7 @@ static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
+static uint64_t kvm_supported_guest_memfd_flags;
 static bool kvm_guest_memfd_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
@@ -3069,6 +3070,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     }
 
     kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
+    kvm_supported_guest_memfd_flags = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
     kvm_guest_memfd_supported =
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
         kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
@@ -4889,3 +4891,16 @@ int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
 
     return kvm_create_guest_memfd(size, 0, errp);
 }
+
+int kvm_create_guest_memfd_shared(uint64_t size, Error **errp)
+{
+    if (!(kvm_supported_guest_memfd_flags & GUEST_MEMFD_FLAG_MMAP) ||
+        !(kvm_supported_guest_memfd_flags & GUEST_MEMFD_FLAG_INIT_SHARED)) {
+        error_setg(errp, "KVM does not support using guest_memfd for shared memory");
+        return -1;
+    }
+
+    return kvm_create_guest_memfd(size,
+                                  GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED,
+                                  errp);
+}
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 1940bcbd2c..e50329f26e 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -144,3 +144,9 @@ int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
     error_setg(errp, "guest_memfd is not supported for this configuration");
     return -ENOSYS;
 }
+
+int kvm_create_guest_memfd_shared(uint64_t size, Error **errp)
+{
+    error_setg(errp, "guest_memfd is not supported for this configuration");
+    return -ENOSYS;
+}
diff --git a/backends/hostmem-guest-memfd.c b/backends/hostmem-guest-memfd.c
new file mode 100644
index 0000000000..deb796a6bd
--- /dev/null
+++ b/backends/hostmem-guest-memfd.c
@@ -0,0 +1,92 @@
+/*
+ * QEMU guest_memfd memory backend
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ *
+ * Authors:
+ *   Michael Roth <michael.roth@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/hostmem.h"
+#include "qom/object_interfaces.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qom/object.h"
+#include "migration/cpr.h"
+#include "system/kvm.h"
+
+OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendGuestMemfd, MEMORY_BACKEND_GUEST_MEMFD)
+
+struct HostMemoryBackendGuestMemfd {
+    HostMemoryBackend parent_obj;
+};
+
+static bool
+guest_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
+{
+    g_autofree char *name = host_memory_backend_get_name(backend);
+    int fd = cpr_find_fd(name, 0);
+    uint32_t ram_flags;
+
+    if (!backend->size) {
+        error_setg(errp, "can't create backend with size 0");
+        return false;
+    }
+
+    if (!backend->share) {
+        error_setg(errp, "can't create backend with share=off");
+        return false;
+    }
+
+    if (fd >= 0) {
+        goto have_fd;
+    }
+
+    fd = kvm_create_guest_memfd_shared(backend->size, errp);
+    if (fd < 0) {
+        return false;
+    }
+    cpr_save_fd(name, 0, fd);
+
+have_fd:
+    backend->aligned = true;
+    ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
+    ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
+    return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
+                                          backend->size, ram_flags, fd, 0, errp);
+}
+
+static void
+guest_memfd_backend_instance_init(Object *obj)
+{
+    HostMemoryBackendGuestMemfd *m = MEMORY_BACKEND_GUEST_MEMFD(obj);
+
+    MEMORY_BACKEND(m)->share = true;
+}
+
+static void
+guest_memfd_backend_class_init(ObjectClass *oc, const void *data)
+{
+    HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
+
+    bc->alloc = guest_memfd_backend_memory_alloc;
+}
+
+static const TypeInfo guest_memfd_backend_info = {
+    .name = TYPE_MEMORY_BACKEND_GUEST_MEMFD,
+    .parent = TYPE_MEMORY_BACKEND,
+    .instance_init = guest_memfd_backend_instance_init,
+    .class_init = guest_memfd_backend_class_init,
+    .instance_size = sizeof(HostMemoryBackendGuestMemfd),
+};
+
+static void register_types(void)
+{
+    type_register_static(&guest_memfd_backend_info);
+}
+
+type_init(register_types);
diff --git a/backends/meson.build b/backends/meson.build
index 60021f45d1..6c53f4a097 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -20,6 +20,7 @@ endif
 if host_os == 'linux'
   system_ss.add(files('hostmem-memfd.c'))
   system_ss.add(files('host_iommu_device.c'))
+  system_ss.add(files('hostmem-guest-memfd.c'))
 endif
 if keyutils.found()
     system_ss.add(keyutils, files('cryptodev-lkcf.c'))
diff --git a/include/system/hostmem.h b/include/system/hostmem.h
index 88fa791ac7..2d0c25a43e 100644
--- a/include/system/hostmem.h
+++ b/include/system/hostmem.h
@@ -41,6 +41,7 @@ OBJECT_DECLARE_TYPE(HostMemoryBackend, HostMemoryBackendClass,
 
 #define TYPE_MEMORY_BACKEND_MEMFD "memory-backend-memfd"
 
+#define TYPE_MEMORY_BACKEND_GUEST_MEMFD "memory-backend-guest-memfd"
 
 /**
  * HostMemoryBackendClass:
diff --git a/include/system/kvm.h b/include/system/kvm.h
index aeb0c7ca8f..b959a6d3df 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -562,6 +562,7 @@ void kvm_mark_guest_state_protected(void);
 bool kvm_hwpoisoned_mem(void);
 
 int kvm_create_guest_memfd_private(uint64_t size, Error **errp);
+int kvm_create_guest_memfd_shared(uint64_t size, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
 int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087..502fafeb15 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -661,7 +661,8 @@
 # @share: if false, the memory is private to QEMU; if true, it is
 #     shared (default false for backends memory-backend-file and
 #     memory-backend-ram, true for backends memory-backend-epc,
-#     memory-backend-memfd, and memory-backend-shm)
+#     memory-backend-memfd, memory-backend-shm, and
+#     memory-backend-guest-memfd)
 #
 # @reserve: if true, reserve swap space (or huge pages) if applicable
 #     (default: true) (since 6.1)
@@ -780,6 +781,18 @@
             '*seal': 'bool' },
   'if': 'CONFIG_LINUX' }
 
+##
+# @MemoryBackendGuestMemfdProperties:
+#
+# Properties for memory-backend-guest-memfd objects.
+#
+# Since: 11.1
+##
+{ 'struct': 'MemoryBackendGuestMemfdProperties',
+  'base': 'MemoryBackendProperties',
+  'data': {},
+  'if': 'CONFIG_LINUX' }
+
 ##
 # @MemoryBackendShmProperties:
 #
@@ -1234,6 +1247,8 @@
     'memory-backend-file',
     { 'name': 'memory-backend-memfd',
       'if': 'CONFIG_LINUX' },
+    { 'name': 'memory-backend-guest-memfd',
+      'if': 'CONFIG_LINUX' },
     'memory-backend-ram',
     { 'name': 'memory-backend-shm',
       'if': 'CONFIG_POSIX' },
@@ -1312,6 +1327,8 @@
       'memory-backend-file':        'MemoryBackendFileProperties',
       'memory-backend-memfd':       { 'type': 'MemoryBackendMemfdProperties',
                                       'if': 'CONFIG_LINUX' },
+      'memory-backend-guest-memfd': { 'type': 'MemoryBackendGuestMemfdProperties',
+                                      'if': 'CONFIG_LINUX' },
       'memory-backend-ram':         'MemoryBackendProperties',
       'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
                                       'if': 'CONFIG_POSIX' },
diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787..3c754c149f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5858,6 +5858,11 @@ SRST
         off will cause a failure during allocation because it is not supported
         by this backend.
 
+    ``-object memory-backend-guest-memfd,id=id,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
+        Creates an anonymous memory file backend object that has similar
+        semantics to memfd, but is also usable as private memory when
+        running as a confidential VM. (Linux only)
+
     ``-object iommufd,id=id[,fd=fd]``
         Creates an iommufd backend which allows control of DMA mapping
         through the ``/dev/iommu`` device.
-- 
2.43.0

