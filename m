Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D23EFD1A;
	Thu,  2 Apr 2026 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155391; cv=fail; b=omiUk2HcOZJfs7dQQoRDdcy9HqqDlhnWkhTDlDXSJHbEpvU42KKuyWwVaMkNzU3qGbS/o1T/lQNDmuwLkgiQrSFfTMaGrkFmP+9/uZpglEK0KSo1Qmd+Msb8OF7r/Xkf4TXh8hJJ50eKFZj47PjZgB37n7mXayzc4tgMXBmuhkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155391; c=relaxed/simple;
	bh=vV6W5GtC2ysS0Qt8XNUI3gVzEGe+A6ySZDjnCvkPGZ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Op/wq4rktBP7JrnHnDQJTStm2zpL3O9dXaR65Ry8NFGVKrRnN2btyBH8yXG4nYyc1QT7jofKKkQ0ao2RJo0ck8SQlwIIQR6IbgYswmtl854PAjgwLUq3hHCooddm/cRT02iVvVJ0pSA/aYjsrYIYXRUEBIl3Eh8mfpuizaXIwDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3yvOU4uh; arc=fail smtp.client-ip=40.107.208.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3yvOU4uh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyfnH+DntjGkB2eHcX7AJJAaEcdm/gMmK2UBb2x4raVHEw+P1CkF+u6nJsO7aCFPgziEHNBwcabPkVkqz8p+4uP0SuKBvjnwHrORBsZP0synXElQOrgOHX4mjJ6Zxa5TChiZQLAWctr670v/4bMETmf7GzJVWV5VvJREPyHHPEhpgKFhqhIqF2CIpkRSaI+k2ZWm3cIDXT8xgLGZlA8CbaBhF40OO7Kwnzw4tIk1v095xbaj23n5JU9r2ACcxqXG+vTMKSEhSvULymP7MvMXm9afl9jPPudHhlPtHbPJ4OwJRGo0TilzZOpa29trouUA/vLERHFjbtx8uidExGFyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SN4atzLF1fnQ9Su9eFQaCYD8EWXYPgIPB7F6lnuBCw8=;
 b=p3rI5sNRLJxpPSvbMy8iE2BlEiE1WSlwN+xOpVDtHYPSZwzy7d16endryS+nMt2kLYqKxw1GnLvgt3Ndva/U+gQOYCDft0SiFWpbn1QBJKh5+1Q+MNBVTUGwP+lo0wPYEDekeuOBeUpGT0qcc/5qZ5CULsVYP58B/f3ZGzxDQ6dIRWnbQ2cWrYbC7vWBvFHrnsEEO6bhfA0508/tMD4PfhfelyTwelLZcd+mOQOo6B71akFtatryuSk3+ZRJVLbwiGBqzdrj4oNIPYw8Dy1uze+SsmABby2p0Eg60DIi81S0/tR+ybaKDPcc83IUy26b4lIRJE1L0TwRtYZwYDg1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SN4atzLF1fnQ9Su9eFQaCYD8EWXYPgIPB7F6lnuBCw8=;
 b=3yvOU4uhNIdtZ/M1P9JBEJa6t10lx2A76H72T4ju/x8b35G140FtDf2Rh142LdWW6N6Ik4yKO2HMrKCHJj0hSS0DO3hGVN9HN/4HT1rpQmZeI34BLVRcjt2E9QnXmuWzJbZipPEsovRlZC+gyfz+r+Oj35KNZ2HzPZoDvwUAw9w=
Received: from BYAPR07CA0038.namprd07.prod.outlook.com (2603:10b6:a03:60::15)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 18:43:04 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::c5) by BYAPR07CA0038.outlook.office365.com
 (2603:10b6:a03:60::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 18:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 2 Apr 2026 18:43:03 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:42:54 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 0/7] KVM: SVM: Enable FRED support
Date: Thu, 2 Apr 2026 18:42:33 +0000
Message-ID: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b7ee18-831b-41c7-0f01-08de90e7ac61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	w4qa8hYP5lEAy2E59IoWAV+nzxTVoMDw1zRnVum8TEpGnsxxxsmRGlYa39GGE7y+p+hIxTSyBX8BxqzZQZowkTO1JpH936ij5Cv7PiWsR9iNSgBSvamLuxDw4TARhsW9tGbB7k+zSraR4oSQCoUjE59GmgiSWg5QIMXgiksciaRv5tSkBbNDhOMjDotahPLQ2OUTUSLB8PGQIYG9oq8gqxu4BbDnoQb8pVUVnSqMFWbSisqe90e7qjZB4JK74Sknhjs/W9aNUMbEF8e/BR0Ahp13J+0H6TJfclIskpBla9g2l/WONq96iqyeI1GGcviKYmFKJHdMZ6O5Sb12dUerQi+rjegdhivjBqP+cIryjl51e41qUBNRLXxwV1G4D2qy1NMY+uBsuLBUZ5r7sN7C5sHB4YnvFBYWtGGEQ70Oq5c6rj+tKo12a5x36qTxn5tnK6IbiLmsPglrbqDcdAF9xYM2j4Dn+lOgiDNjIpC9aik01tNL4W1GZVjII9yd7nBawfmpJVuzLEsZUGtzWITzObxYYLPoBhYjgTtRSzJYqp209O4/GH0YfEku/Bms+/lATr+8G8ivH2siPLS/V2opBIoYI67ZSTGLauYBeHojvYhE/VRbQJfy5DoyQdenbjq2VAT21WRCImu/QJY9fX01/tgb+Le6kzJwHj8HtYVitvomgkhHOQ8Xd2Co2Nc3hHguhslMcZ61wchDwwsmsXCcRLYDRU5ffUkBTQCN2puUaWZwgtCntauqYKEJOaW9IldOMHtGlFq0+w9o9HfgmU+rHKShFZnaEgke14Yl5XhbJAw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jYzCy8X+Vu4GEtwMZmOEs7FBR1BBdqd7olt7pB/ica29iJz13VnO0lJrpyVd7Ymf5/veTU7W1a2BKKz1UxZbGcAltWX/jbRUxp65mNRQkLzLabWGyFMJLjRzlFJJ3Fpc+BlwzNVpw6NK1buN8P98kxQBsGGMgBQU6tpCTnQ1WTXI7xQGGJbQIYZtma3I2AXICBt7p7DOln/opcly9DMppAZkaCy7DDqNvkPbcq+xPcewNIvP41Hj6jSb6pqlu1u9SLeQy0f0ghQPs5Z75ejLois0kjNp9pqlIhhVtOsxjboQqIbSDkboZ8uGFuXwjWeSyuz6kwfnukRcZHZIRbiTSC/cTt8yegBg96rvxCjZ1eORqqZ40ASsuU6iNu6Vdnbceej5/v7nJKfs+Nn0bZHLgd/GEsWsa0QWATVSnCZ9tZqeqrI+33E1DLDjjvu2sHK6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:43:03.5732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b7ee18-831b-41c7-0f01-08de90e7ac61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904

This series adds SVM support for FRED (Flexible Return and Event Delivery)
virtualization in KVM.

FRED introduces simplified privilege level transitions to replace IDT-based
event delivery and IRET returns, providing lower latency event handling while
ensuring complete supervisor context on delivery and full user context on
return. FRED defines event delivery for both ring 3->0 and ring 0->0
transitions, and introduces ERETU for returning to ring 3 and ERETS for
remaining in ring 0.

AMD hardware extends the VMCB to support FRED virtualization with dedicated
save area fields for FRED MSRs (RSP0-3, SSP1-3, STKLVLS, CONFIG) and control
fields for event injection data (EXITINTDATA, EVENTINJDATA).

The implementation spans seven patches. The important changes are:

1) Extend VMCB structures with FRED fields mentioned above and disable MSR
   interception for FRED-enabled guests to avoid unnecessary VM exits.

2) Support for nested exceptions where we populate event injection data
   when delivering exceptions like page faults and debug traps. 

Changes in v2:
- Modified the zeroing of FRED MSRs from INIT to RESET and updated the commit
  message (Sean Christopherson).
- Used guest_cpu_cap_has() instead of checking VMCB bit in recalc intercepts 
  (Sean Christopherson).
- Variable rename from 'fred_enable' to 'intercept' (Sean Christopherson).
- Moved FRED MSRs save/restore logic from svm_vcpu_enter_exit() to 
  svm_prepare_[host_switch/switch_to_guest]() to reduce some MSR accesses.
- While switching to host, added a safety check on guest_state_loaded.
- Removed the need for a new function parameter 'reinject_on_vmexit' in 
  svm_complete_interrupts() (Paolo Bonzini).
- Replace variable 'nested' with 'is_nested' (Sean Christopherson).
- Formatted variables in reverse fir-tree order (Sean Christopherson).
- Gate all the FRED MSRs through guest_cpu_cap_has() while dumping VMCB
  (Sean Christopherson).
- Confined the enabling of vFRED to svm_vcpu_after_set_cpuid() only
  (Sean Christopherson).

This series is based on top of FRED support for VMX patchset [1],
patches 1-17. The VMX patchset was rebased on top of v6.18.0 kernel.
Previous version v1 of this series can be found here:
https://lore.kernel.org/kvm/20260129063653.3553076-1-shivansh.dhiman@amd.com/

[1] https://lore.kernel.org/kvm/20251026201911.505204-1-xin@zytor.com

Regards,
Shivansh
---
Neeraj Upadhyay (3):
  KVM: SVM: Initialize FRED VMCB fields
  KVM: SVM: Populate FRED event data on event injection
  KVM: SVM: Support FRED nested exception injection

Shivansh Dhiman (4):
  KVM: SVM: Disable interception of FRED MSRs for FRED supported guests
  KVM: SVM: Save restore FRED_RSP0 for FRED supported guests
  KVM: SVM: Dump FRED context in dump_vmcb()
  KVM: SVM: Enable FRED virtualization

 arch/x86/include/asm/svm.h |  35 ++++++++++-
 arch/x86/kvm/svm/svm.c     | 122 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 152 insertions(+), 5 deletions(-)

base-commit: f76e83ecf6bce6d3793f828d92170b69e636f3c9
-- 
2.43.0

