Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7C3FF1D0
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763171; cv=fail; b=uZOFQmo3w7tx9lGpY6BZqeF40s087etPqbY8yi6eGTpp2NnwkT6S2dP88wB5uKfy8urS4COTtoXs0mkolKIGC2hecNCXGG2YVGMkROmIxEct1ERNVoiK2l07dkxxEh5D8xOV5tJAgVzLSO1Bu9C45efw0oy9Rp3+hFOMVORyuUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763171; c=relaxed/simple;
	bh=crH+u+Jvzk9tPkYi+jkycGhsy1kcr+P+BsZp+CGZ9Js=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eg+z0Z8yszs/HapV28hBSQr9D1XvxWgDMVITeOzX5SIEI9wm4ZWa5FHSlXuhMF6o83834l4551jz2QR91v/3qTzx1BW+CDX1683C4mte5BhKnCbo5oos5QNvrvJIOb4Odoi1rbQp+iIoKDjRFxHIYXr2yDN7O9pcpGQulfXC8q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cLIGRCPf; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cLIGRCPf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6UgQh0XrDqfkSkZIjRNolSx/G9+pybmR08Rex+VeiOK6tQV/bbbg9C98PjyiQny31AzZ+BN0MUzBOh4jEVYqYPbF6ygm07QAWkAc5rFNF5c20JIDtTPRaFkexcW2MgZiuudACAaMvgclQMRlkXJmqX7SUDR2vt1XoUPcZkW5bm4X1qliWSe0VUNC1LlDt4J74pGtwgTNPBo7Zdx8m2VoAE9QxBAzLrYiW+3ZGawTvpJrom2IgBug8xXUDLY+Q2sHyt1fjWcE22GzreUtNzDZsA1XN5Eaa/7VMaMdyctQdIWANLhmu28FctkSYMQvKEfeZxVga07w5q76pdizD4aUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7am9N624dp6yfisTYb7A5lQlHdtarFEWwpKTOos9k2A=;
 b=A3LccbPsyAODtrdGWvv5boOoENZLdgnFdcd0maRxZxl7V4iVVobLye0jikU/u4zGEsdbkypntqn2zMvayhQZas8+PX/eKaWYtf/z4eWl15osa2JWCpGC8cLw/EU4keqi/mVhihrQfRVHeG7mjTVR2aC9DiB7ExxNCrfVtYPRYlvgH0MUlpTXGwcgwo795MFjykBr1enB6rt206rFICzbz4OKwgMY0nQdHQY8oLxVy/dqR9+TU+cDb6E02gDK7cfZzsmu2Pe0TFy7vpmeW4v/JE3eqvqkb9BGIrsWpi9Q/yEnE3V8anjYyRMCG4lMudGVSnZquxyLe527rx9GF/cKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7am9N624dp6yfisTYb7A5lQlHdtarFEWwpKTOos9k2A=;
 b=cLIGRCPfMonEbbVKkll00Jg5N1q8NfZeT+FeOiAlCU22M3shvPhjib5EVf2D9sy1R6lWjbM+BsTvG3aQJlSnScTJ1KBYDOB+ozdmHlwT28L5y9AsL2sjg5OyO7O3YtS1iIDkshImehzk34aQHzbJoIQFV5U6bdwiUQBd0Vb/sKw=
Received: from SJ0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:a03:39c::22)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:39:25 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::8f) by SJ0PR03CA0347.outlook.office365.com
 (2603:10b6:a03:39c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 06:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 06:39:25 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 01:39:22 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v8 0/8] KVM: SVM: Add Page Modification Logging (PML) support
Date: Mon, 7 Sep 2026 06:38:58 +0000
Message-ID: <20260907063906.1964557-1-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6dc6eb-241b-4e24-69fb-08df0caac274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	DJwe7DEclYxfnTp3C0DVZw97emDOjy5yfe9e+Y/b44jpwFeGhKWGebYKYHKvTZGb+/nPROzn/L9Y+DYZ2eCMtvQolHiMSPZeBI7dKtg0EaHCLLfXsh5sHVpKtp0iub/WnwUOkRTql/9OLQVWGirU/UafMquUrwIO8t60ProhUsLkDJ78gUaRO2/iccvfpMCOTG26Yaovtax/P139POQs/uiA0KfViWWEJI9FNBm3OPmzxcHQ3Xl8dRERHbqCMOT1j5r0aWFJT2T42+klbcVdiVc8N+Y2IIa+GoxrTNEoKcdzyjHNzlnAYEN4t0G0WuTvpI7Bq13QuJMKrdAciA0LOo8rHThe4WNpErPgJBo2HvI3w38JRZRdnv4US4kPmSLH3HbHwYUMeCVUIvGcLgffZ6MUeqZGK1uNiixpi1UYBnUc+Mkb6aAzxH+dvZc13+ZHG/l5GoqDrcd+HxrGtQPziac4tNb8skoQaGtVha1GLXwTLqwN86+/ywWmicQ76O2K2tFtseuRO+SBKfkShQC3gHjnlB6jQRMLCRGTJKe8XegrDxwcVIcQKb/XgcM8FHr9PSS/Hb/rbLyBMRt+w/XZwfPzSH2Yrdw1OjjfsNGr3P4nZQF6XeHz2om509HTn4XYcSemwaQMCQJ86mm18hNtK1UN7CcQJ5DtbQmaAMVxY51o72fbMOo0yYmRhWyeg8TH7N1/pQeq16CfESnWmo+hmw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3c/J9HVpEzPAGjhQqTiu6YiTORX+HrxmsAquqwMY7kIiwB+zwPwXTQbz7LzBmXs2FqOlYLxALMKbdRIUJ8DDcgiVaGgnP8VQ0u/7Sg3oODsklsZcA1Qh6TFWKREPDRtvF9V/gwsWZYU+EKcwyzwlBZw8OPggMbbwPM2HDggBWgJqbGYn4bieadUbwIDHqjfXcBFFwvAXR7Phc+mNw39SneIg6seFMwjvN+tNpweHvtQJajCqltIFz3yLctcxI2YZngtpmdZ2CE2fEk2tRDAQp7Xv3j4hLJ6asl1JOhl2xw7ZPynNbQNdwK/rBMcXG+1qQZs4aY69B9xn+9d91jhMosNt1ongZL+Hwk2L8wNoDRE3W5o5wKeISm2Nt8/WNSphwwipN2RUlGFmACsB9CWbhK9nzllfQ/Rneao+9GVYhcXNoLj6rmqTgCFp7gGC+ZUk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:39:25.5275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6dc6eb-241b-4e24-69fb-08df0caac274
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785

This series implements Page Modification Logging (PML) for guests on select
AMD Zen6 and later processors, bringing hardware-assisted dirty logging
support. PML is designed to track guest modified memory pages. PML enables the
hypervisor to identify which pages in a guest's memory have been modified
since the last checkpoint or during live migration. More details can be
found in the latest AMD APM Volume 2 (System Programming), section
"15.25.15 Page Modification Logging".

The PML feature uses two new VMCB fields (PML_ADDR and PML_INDEX) and
generates a VMEXIT when the 4KB log buffer becomes full.

The feature is enabled by default when hardware support is detected and can
be disabled via the 'pml' module parameter.

Changelog:
v8:
* Rebased on latest kvm/next
* Drop redundant pml_addr=0 in nested_vmcb02_prepare_control() (Yosry)
* Fix misleading comment, pml_index=-1 is hardening not stale-data
  cleanup (Yosry, Sean)
* Route nested SVM_EXIT_PML_FULL to KVM and treat it as unexpected
  exit (Sean)
* Refactor update_cpu_dirty_logging() to common code as a separate
  pre-patch (Sean)

v7: https://lore.kernel.org/kvm/20260518045916.2988667-1-nikunj@amd.com/
* Swap patch order to avoid adding @pml_page parameter only to remove it
  (Sean)
* Add Sean's prep patch to pass @vcpu to init_vmcs() instead of @vmx,
  cleaning up all vmx->vcpu usage (Sean)
* Drop guard(svm_vmcb01) patch; access vmcb01 directly in
  svm_update_cpu_dirty_logging() since VMCB is just memory (Sean, Yosry)
* Only initialize PML index on reset, leave unchanged on INIT to avoid
  discarding unflushed entries. PML_INDEX in the control area remains valid
  after intercepted SHUTDOWN (Sashiko, Sean, Kai)

Nikunj A Dadhania (7):
  KVM: x86: Move PML page to common vcpu arch structure
  KVM: x86: Carve out PML flush routine
  KVM: VMX: Use cpu_dirty_log_size instead of enable_pml for PML checks
  KVM: x86: Carve out common dirty logging update
  x86/cpufeatures: Add Page modification logging
  KVM: SVM: Use BIT_ULL for 64-bit misc_ctl bit definitions
  KVM: SVM: Add Page modification logging support

Sean Christopherson (1):
  KVM: VMX: Pass @vcpu, not @vmx to init_vmcs()

 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm_host.h    |   4 +-
 arch/x86/include/asm/svm.h         |  14 ++--
 arch/x86/include/uapi/asm/svm.h    |   2 +
 arch/x86/kernel/cpu/scattered.c    |   1 +
 arch/x86/kvm/svm/nested.c          |  14 ++++
 arch/x86/kvm/svm/sev.c             |   2 +-
 arch/x86/kvm/svm/svm.c             | 106 ++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h             |   1 +
 arch/x86/kvm/vmx/main.c            |   4 +-
 arch/x86/kvm/vmx/vmx.c             |  82 +++++++---------------
 arch/x86/kvm/vmx/vmx.h             |   9 +--
 arch/x86/kvm/vmx/x86_ops.h         |   2 +-
 arch/x86/kvm/x86.c                 |  48 ++++++++++++-
 arch/x86/kvm/x86.h                 |   7 ++
 15 files changed, 220 insertions(+), 77 deletions(-)


base-commit: d4b7fb647204f0c81dfeae2d1a708e4d858e0c94
-- 
2.48.1

