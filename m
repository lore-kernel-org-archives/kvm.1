Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F74388E70
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543606; cv=fail; b=SijXXPrWA8Ln8QMECFemHHsNpC2f7+AYi6HRfIh91i3cJA0DZmmrA3ZEms/iWCc6W23eM10FcaoOPnR1FvVrXKyngpXXTwNjAtsGsKpWRL1KMzY/PrNyd2xFqLbfRiNv5Kmv+GimghbZgSj/gKqlWgiJW8otObfAmQoSKwtv874=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543606; c=relaxed/simple;
	bh=dZtiKjRnhE8vChv5mVKts65bDEMzFHI2SgN4P4CM/Oo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LT1C0x3qsZxO7EAyjZvpMiJ/nS8jDLKRWGUxSMOOU+Rxr31d0YFOCEg5QIDB0WZzL683wSMZlYd6E3LLDu+Ieo/eDG/tESxEr9F4Fw3NWH6lgbKQ20/DJ3yMLP7l7pG2CMLxSI1s6plC6UaMsucxDCRnjkutoWuiJ9saqZ15bqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QAbrW75K; arc=fail smtp.client-ip=52.101.56.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QAbrW75K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1cVAcmnziZUjaK9/DrNdgR47iqIQuP0wd032m2EwqYEXU5R6Ho3RzSkWuajS06Mp/MtS5x834jX5GblGZpAYKGMcoVrWWP34bUmhYDPmJhpeXtV1JaTZ1Kxms1Pgq+PVhN9s1Hw3W/BT1vZ2P6pVUSKGbjlFp7jmt/XeND9wMj3GuErhzgChejjcmRMVhj03Sn3dBBnFk9KiEyjI6F8HaDNTTwrMiUYdjEM1MJk6Byd/G1kyBc5NJg/qOjp/v1gSFhf7tNPiipA+6Xwm9EufTI+Jiu/kR+11yI5+/iHkfEfBbOF1pHLv5OWG8ca4oYs3TOzLKqjr54y4sg6y5KKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cyHafCNmhp3wzSZ1RyaYPPrzK15tXOpr7kpICuqxfk=;
 b=uja0vZEYA8eA0VGhCRxvUxT17CJ2SQHrJnqtK+bC0bwyZhOBDsNcQmvRHkDamwp7wlESVs7FSZYIBzmeQvWa2AXteeFLVeNs7QE+k2VBnjT9/Or/HBqvMkLLfooW4hdtopg4N7H7T6fGV0HFdPV0+Uk8ZYZyEndj5kknV66qz2qCfE1nhEl8Thpg7XwKt/kJi6WhFYKfvQEBkHo88WlnDmBNvZ5QHJAl7GxvNs/PnmyfAtGq+kjr4hA2FsFoNQl2+1hsoLdRzoOS7u9xGxzDy+sENverOPrwOiq1akFnWosdDr95fSSzVmk1ewuN2PCLJWoyGkJdYIYH+BPriPWbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cyHafCNmhp3wzSZ1RyaYPPrzK15tXOpr7kpICuqxfk=;
 b=QAbrW75KUZMu1U6OnNmTZy+Tr2Pxj3+35/CCpM2tsrrtetlAtKnasVI8stSt4eqMP2MMbfp55fN/Liha80oF4koKj7a5yDgvC/bxg6fmS8uaUVyujJLTdyWgUJjIpEtYCmpTjcQYcbf8Q0gmlDFD72aqEfqFR8Z2x22i12sRI9Y=
Received: from SJ0PR13CA0206.namprd13.prod.outlook.com (2603:10b6:a03:2c3::31)
 by SA5PPFE91247D15.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 7 Apr
 2026 06:33:18 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::f6) by SJ0PR13CA0206.outlook.office365.com
 (2603:10b6:a03:2c3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 06:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 06:33:18 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 01:33:15 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>
Subject: [PATCH v6 0/7] KVM: SVM: Add Page Modification Logging (PML) support
Date: Tue, 7 Apr 2026 06:32:38 +0000
Message-ID: <20260407063245.2755579-1-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SA5PPFE91247D15:EE_
X-MS-Office365-Filtering-Correlation-Id: e501ee89-1afd-405e-dfdb-08de946f8e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5UswrAgpofHO6KRCW/Y5yNAlooh+c0DDKkSUM/LSWdCWSVrdL9igwahmSvZof2Fq9eifFH0WPaFlxzVw+ZpldB3CxHlDex5VhvkW4xD4HpYHKzTrsz++zilgfAODGcP30MvwejJsfs3rGpxyydUJ9Khj6FspsB1QFHloBIjSF8//O2zAUTIwVt9GMTmJv3nHwXUdB2MP+3R0raurDQdrn698gzBxQmp8Xv5X9PiIx9+YZ7GvUfrxtR2yvY4riB5oWsDtTxCLPdiKdD6w/iCMZhJetThf85MArETVlX/OhZIVXJOPNbPSNzbM0XO9WJB6JiG+fj0slJw9N57fYfqjGrbU+bGbFcETzbUrS5b20Fw4p0S8H15gThnHEPngK0/dKDHJx6hU1INtuc2h4zn/rNQPGuitn0996nsSgJjCUE19eHHUCbeRzaTgsZE062yUdAZdLgpyPlTjoPBD3XBm3tLp2L/GZQBYC4b7y8FjBGK/TvEmysNy3harEuQ93M+2w3a5T64r9flSS+AP5GEopxJKrbSv/QO9Qd63McMFXO8vEC1D8sGc8lpmlZdCqeImEWgYGaX0cjenROZfwdKdSU+PS9V0NGYQ7d4w27+mX+bl4y4wS+LcuaUBDSZGApo8gyPxlPRPZMzC7X0eW3EKMRY4yLa/yeivZiNjPbJE85FdLgULq//JpXwTccM4b3/d33PgWhpPBlr30JbBlmfNieFkP1GKm4ZdXkKs9iv27l+TfujSXLO7mu0FMbCQ2zoA3peqR3gX8EcdtV6vVPZFdw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	72aDj65Z7wuhzT48cQ8MKulrRbD0j7usXOLQQCTHpQvuWSeVum4nUK+XDJGdpayTKnHcNVeCJ2Vo5tCgBgI090UIj7OscVZXjnpPeZP81b4A+/fkyLkrX+uQkQ0K8YXoq3IeEYhUjs0D0fYNxreB92xDtAkZ/SmzG1tcFNbTX94AS6NDMeR772iDf4PihJnOJYssmxN2ADIbSu1MHRmis9f2zdlkXf3kFpDX3CPQ9CzWSuIcle4p3US9pdJAOOVHUW3DiNPVpPbR+xkCo1ac7Bbm5g+AERMLFnWk1lQpDzfLR8vE+ih7sSMb7Mi9ICkgZEJH0P031bpChLj8B2AviOw8tfUSmX0m4j0UAMK2OOMFol6iLoNRca+wKZYxDVgYyVy0Lny1b8ig1y2lCcOCcQib5laxQS/Us1CB3EmHRGSZ6HtgN/ctgM3XxqfREEbg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 06:33:18.2383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e501ee89-1afd-405e-dfdb-08de946f8e51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15

This series implements Page Modification Logging (PML) for guests on AMD
processors, bringing hardware-assisted dirty logging support. PML is designed
to track guest modified memory pages. PML enables the hypervisor to identify
which pages in a guest's memory have been modified since the last checkpoint or
during live migration.

The PML feature uses two new VMCB fields (PML_ADDR and PML_INDEX) and
generates a VMEXIT when the 4KB log buffer becomes full.

The feature is enabled by default when hardware support is detected and
can be disabled via the 'pml' module parameter.

Changelog:
v6:
* Collect RoBs
* Rebase on latest kvm/master
* Dropped SEV PML selftest (Kai Huang)
* Added guard(svm_vmcb01) helpers to temporarily switch to vmcb01
* Use guard(svm_vmcb01) to ensure vmcb01 is targeted during PML updates when L2
  is active, similar to VMX. Dropped patch moving nested CPU dirty logging to
  common code; upstream now updates vmcs01 on-demand via temporary VMCS switch
  instead of deferring updates.

v5: https://lore.kernel.org/kvm/20260105063622.894410-1-nikunj@amd.com/
* Rebased on latest kvm/next
* Use EXPORT_SYMBOL_FOR_KVM_INTERNAL (Kai Huang)
* Use cpu_dirty_log_size instead of enable_pml for PML checks, with this patch
  moving enable_pml to common code is not needed (Kai Huang)
* Added SEV PML self test

Nikunj A Dadhania (7):
  KVM: x86: Carve out PML flush routine
  KVM: x86: Move PML page to common vcpu arch structure
  KVM: VMX: Use cpu_dirty_log_size instead of enable_pml for PML checks
  x86/cpufeatures: Add Page modification logging
  KVM: SVM: Use BIT_ULL for 64-bit nested_ctl bit definitions
  KVM: nSVM: Add helpers to temporarily switch to vmcb01
  KVM: SVM: Add Page modification logging support

 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm_host.h    |   2 +
 arch/x86/include/asm/svm.h         |  12 ++-
 arch/x86/include/uapi/asm/svm.h    |   2 +
 arch/x86/kernel/cpu/scattered.c    |   1 +
 arch/x86/kvm/svm/nested.c          |  13 ++-
 arch/x86/kvm/svm/sev.c             |   2 +-
 arch/x86/kvm/svm/svm.c             | 125 ++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h             |   3 +
 arch/x86/kvm/vmx/vmx.c             |  50 ++++--------
 arch/x86/kvm/vmx/vmx.h             |   7 --
 arch/x86/kvm/x86.c                 |  31 +++++++
 arch/x86/kvm/x86.h                 |   8 ++
 13 files changed, 206 insertions(+), 51 deletions(-)


base-commit: df83746075778958954aa0460cca55f4b3fc9c02
-- 
2.48.1

