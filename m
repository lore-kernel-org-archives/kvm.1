Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792443962;
	b=vTRcZuzmCOVZK7opVwWW9vtVqBB5wZgD4Mrc/ET8305WLaz0xgOjwYhf674l8d24RVY0
	 D0Jflz/Y/aJ3WkI9daVjB/uVbo74xXTXB4Ky+NHghZ8Tlnwy00wKB8oBwn8WADIDyr7Oi
	 m6raSlniihjktmi3kXAHzUY4iUnbf8yn4zogqI+kbpTiYnmyuHyib7sCHwh57MeKwGGRU
	 osvo94JijpwfE15r+7/KLRNGwz8dJtQPFfyjzyDl66s+K26E547hBvpS+/Qsy9QbEHyR+
	 L5YcN0b21QvF9IblvXilBoQABgf2OntWLzDkhrhNCJKiffnpzzOdpSoo1tUL1i0+41A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443962;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6DRbysi3jjwGOzc7VQYybo3W8E3Gm/yePuOZdV/vrdI=;
	b=wUzrkQlcXrOMOepgC68j6FXnX1pMbxsklcsWigupzFXenkgBRXZ6XLnshr6PxWke3zFn
	 vFzzcQoK6yC4udnrYagPp7zpggUB9Uq1jL0muJDvDVuaUrk8XXOp+Enf/49ohz+8rC7hC
	 7sNiiLjkhjPgZ9MrZXQg0PfT8EeVBaQnCcG/qpWH36E06KdF+iAv5z0HwBgYtx2g91a1+
	 Ert0vwC8r/i98lAW6JqVDGo1UM/DlDoN3JR19ogVSjk9gpiKQGJXXgV1zSwrS80v2AqyP
	 oOt8GBlY7CF440VkZxUNUYDpeif3YSv4lqqoopAfObxHv7YndZNBHjIJ+6q9XPavwZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2+Xs35LJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.54
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B5606A31C
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C1B5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2+Xs35LJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dV3hiM2IQMLbJbAVu6SY7si2O7mQQ2ipoq9zlHRA1q0zO8BzDQ7AJP9jt2n5rdbQTesWWWYKtNd+D49rsUJnBq3ShQIyNJ6FuomCWx7nY+MuKvmPOHvtJ3XfNsAB25otiXr08V5RaFZyoAH9zAgkC2Yvox165FMZkh1QOoI+1F992Xa70PYSdgOcQCLyZFD1dPzcfFEIcj7R1Kr1jOXb3X3Yoa8+1T7gBvczBS+AXj6q6jyIF26c2kzcDlTSyw2sQPOdQ1Md6Y1rXss7ezpEhdElXXm68EO+QNVxyrHF99XYbOLJtkULv8irtJ97xx/OZiAiLxY2kbi71cLYuCgTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DRbysi3jjwGOzc7VQYybo3W8E3Gm/yePuOZdV/vrdI=;
 b=zPB4+jOtfuxeo5GjAnxScmFThJxaiWcnatcr3aTRlan9rs66aEMOm4kmHRhxpLKQDVv6G0U5B+9cZ9M7aKYX/SPnoGS+kKs7WdIyZVOncFHOzdaDyB2328n/pv5de2Bhe6hJFMKA7ajWxNhddcxQ14GNNdcXlMX6GfmcjnieKulcpC7S0QZ5WGbj8xkd9gs0px5zkGLNmSz0ldGArIibKIyfKAtqDvNO4ZfHL1NCq9eyTxDOlzcRFBYVdHJf9ofwJr0PeV0/SF3P9VURuOuqbIlmAAHUd8tGRotRz7dtQzSF8dJ7xjuMWgEU4zlHzPvmTESiNQI3vND4mPX5be0SUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DRbysi3jjwGOzc7VQYybo3W8E3Gm/yePuOZdV/vrdI=;
 b=2+Xs35LJdKhHiDwhSTOZZIF60hyK0JpXzm8Vq6NiS39MfOAKp9OXKbhXKdYY4VhKrcDxUqPSQ+4b5TreAkHNQZmLVhshk6w9IaQgORwuqatdm/Rl/BLJQU4AX7YHU5ij/CzgvhBLrxRbGmvrgokm2DVEv3jj7Jy09xpxAPo0xHg=
Received: from PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::17)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 19 Oct
 2026 21:05:57 +0000
Received: from CY6PEPF00000047.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::8e) by PH5P222CA0003.outlook.office365.com
 (2603:10b6:510:34b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:05:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000047.mail.protection.outlook.com (10.167.247.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:05:55 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:05:53 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 00/12] KVM: SVM: Add support for AMD LBR Extension v2
Date: Mon, 19 Oct 2026 21:05:20 +0000
Message-ID: <20261019210532.378628-1-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000047:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: e1159f69-4a58-4284-5764-08df2e24c43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|23010399003|11063799006|56012099006|18002099003|6133799003|261009223027099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	FBC2VrsBwJSr9MJOX6OdtVZ6V9BL4Z/wLGT0tAGY6PRsPWIap2thC4cEzx+HYoXDc9WvnT3b5rgjlcTu4bYSsSl6GwoAE50w76rMJtT3m5788fOIP46ryRaaj3pPgKuxxHj9APSPguK94d6RAk2uFjnTZqs+A96DdFqCaQ+hFZ8zvT+81Fmc2tGxLXy+EwvFvDQIw5N4pGxbGxfi/6w1NLokyFZTyDD9VVPyxkThNnhoyf4jljPPB58I+FaTea3WnByz+p7Z+/vNpVTXwOoPuK8uSKr9JRNOWV5By7fydtFAmI5c/C6kJ4SSD2xGyaluRAAd24dD1AslPJexbLU6QOvJqRufB7oY8ymUrjgfDzx1b4XIV4qZkzEeH2DT3Z0RoDGl5iAYURjJXxmUiz3pIK+z9o93lv02jzJ+uvHZlxiIRu4ERIUv1/wtRCCjgeCMvTwg3ELs2GMksj3NFFl8hOqnJwY7/sluVX0XpCeZrO03SksQurkzwGyLT4oHI0IvENcvL547Nx7+xlXr3Wm+usHtGc0DXs/9rzBRdy59ukZTi3qirPi2QDW4njigJRWD9XtXMOMYpsHeXV6XXcvnvelfpxa78U9J+IOSo5e6CKs+5XzcqtC1NtFXu+gwfaJFUuHQAPztIKHoZchg5Qm35ndTqVIErPnkC0kLIGDGlL8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(6133799003)(261009223027099003)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gcnXsZo9VLXPD45KgaukJf9/dIOs4/dQhyyUC2EHAlvr2f9Dj6ykBPXWj0Don1ZMd5241dgbYQmm++4cu+U9PTYMzjpY+7zc2fpHs5aOZ4qkRJxfYg0n1YVCUncnzdxDyVHoAqWFMv5/sMyAUa+ZNzNfMr2mG2VqBt+eous9DcBCHDBVRtTNX9PTplOMi5hyeKogL99f8R+nGrUtiSqthaCAEyjko+DV5x13A+65atBdvbKvuY8hn0zPgZpyocaLCOHN5LV+s603bZf2mqNihWfpC8kidZUvoXsPwHcyH/4ZrUhFR5IFQjSSDXQxLqDKt3qm6ARduCBOCG5vJedCZyllpfMot/qEcXqAE9PUtm46VoxpxyMuyJScHUVOk/0UXcxqst8p4E1arJWRyC+zv19fq9/DlSPIOCU0CbrQnpbXvlfcxNV6e203Edr7WXQ+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:05:55.5374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1159f69-4a58-4284-5764-08df2e24c43d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000047.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

This series adds SVM support for virtualizing AMD's Last Branch Record
Extension Version 2 (LbrExtV2) in KVM.

Background
----------
LbrExtV2, introduced on Zen 4, is a branch sampling facility. It records
the last taken branches in a 16-entry stack of dedicated MSRs:
  * MSR 0xC000010E - Last Branch Stack Select  (LBR_SELECT)
  * MSR 0xC000010F - Debug Extension Control   (DBG_EXTN_CFG)
  * MSR 0xC0010300..0xC001031F - 16 LBR FROM/TO MSR pairs

AMD hardware extends the VMCB save area with fields for these MSRs. When
V_LBR (VMCB.MISC_CTL2.LBR_VIRTUALIZATION_ENABLE) is set, the CPU saves
and restores the guest's LbrExtV2 state on VMRUN/#VMEXIT. Thus, the
guest can use LBRv2 without interception.

V_LBR is enabled lazily. KVM enables LBR virtualization only when the
guest sets DBG_EXTN_CFG.LBRV2EN (bit 6) to record branches. Thus, there
is no save/restore cost on VMRUN/#VMEXIT while the guest does not use
LBRv2. The series also adds the dependent LBR and PMC freeze-on-PMI
feature.

Major changes in v2
-------------------
 * Added LBRv2 support for SEV-ES/SNP guests.
 * Added LBRv2 support for nested SVM.
 * Added live migration support for the LBRv2 MSRs.

Testing
-------
Disable the NMI watchdog on the host and enable the mediated PMU before
the test:
$ echo 0 | sudo tee /proc/sys/kernel/nmi_watchdog
$ sudo modprobe kvm_amd enable_mediated_pmu=1

Testing has been done by running perf LBR test inside the guest:
$ ./tools/perf/perf test -vvvv "LBR"

Links
-----
v1: https://lore.kernel.org/kvm/20260724195040.630468-1-shivansh.dhiman@amd.com/

Related QEMU patchset:
https://lore.kernel.org/kvm/20261019201314.269798-1-shivansh.dhiman@amd.com/

Regards,
Shivansh

---
Changelog:

v1 -> v2:
 * Rebased on kvm-x86-next-2026.10.13. Use newly added functions
   svm_get_supported_debugctl() and svm_need_lbr_virtualization().
 * New patch to report the LBRv2 MSRs for live migration (patch 5).
 * New patch to support LBRv2 for SEV-ES/SNP guests (patch 8).
 * New patches to support LBRv2 for nested SVM (patches 9 and 10).
 * Split v1 patch 2 into the CPUID feature bit (patch 2) and the perf
   change (patch 6). Fix authorship.
 * Advertise LbrExtV2 only with a 16-entry host LBR stack, and removed
   the per-vCPU clear of the feature.
 * Use KVM_BUG_ON() for an out-of-range LBR stack index.
 * Do not mark the VMCB dirty on LBRv2 MSR writes.
 * Updated commit messages.

---
Sandipan Das (3):
  KVM: SVM: Add VMCB fields for LBRv2 virtualization
  KVM: SVM: Add the LbrExtV2 CPUID feature bit
  perf/x86: Expose the LBR stack depth via x86_pmu_capability

Shivansh Dhiman (9):
  KVM: SVM: Emulate guest accesses to LBRv2 MSRs
  KVM: SVM: Enable hardware-assisted LBRv2 virtualization
  KVM: x86: Add support for Live Migration
  KVM: SVM: Advertise LbrExtV2 to userspace
  KVM: SVM: Support LBRv2 virtualization for SEV-ES guests
  KVM: nSVM: Propagate LBRv2 state across nested transitions
  KVM: nSVM: Pass through LBRv2 MSRs to L2
  KVM: SVM: Add LBR/PMC freeze support
  KVM: x86: Use SCATTERED_F() for PERFMON_V2

 arch/x86/events/core.c            |   1 +
 arch/x86/include/asm/perf_event.h |   1 +
 arch/x86/include/asm/svm.h        |  28 ++++--
 arch/x86/kvm/cpuid.c              |   6 +-
 arch/x86/kvm/msrs.c               |  26 ++++++
 arch/x86/kvm/reverse_cpuid.h      |   6 +-
 arch/x86/kvm/svm/nested.c         |  51 ++++++++++-
 arch/x86/kvm/svm/svm.c            | 137 +++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h            |  26 ++++++
 9 files changed, 271 insertions(+), 11 deletions(-)


base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
-- 
2.43.0

