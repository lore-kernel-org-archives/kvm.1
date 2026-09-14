Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2D46DFE3;
	Mon, 14 Sep 2026 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404970; cv=fail; b=D6OxfW+n3CnC+feI1A/AnVvjHo6oloRJciySO3QtygIk3h2PiZqFzNPMOnx9RVBWld9kmw366WBoX8g2dPMDw4rRvsTyanQ8j3t3sdg/NS/jE2tKPSgm8vYiNBlTTqc+BD+uPh2n3gEGB4QFKoJH/8KS5h1xcZDgdzUxizXVjLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404970; c=relaxed/simple;
	bh=s9+EIzBWHqh62gV7/9O8k8mIl0HqGbXM6zKKSEW1AVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c+LrkiWm1Ul5NTLn73R+3pmbxtL28/ExRaXF/Gf+Sv6EYDx7berTuVoz7HNz1c719NTL4VmJ6sy6Gfk7aOJId/gwFB1uw6hDplsbeHMwKF6n8Yw/i/sGDsCNDpHgJvcVFgG8Mt39XnVTd/yJ2JZ4kO1nIP1ynayDTELCG1mO1Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2AZS6ubl; arc=fail smtp.client-ip=40.107.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2AZS6ubl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1Q+pGap1XAjSCVmbM2gN/4xk233IeFYxuJR7gZMa3mWOipY31wrot4540ilkGMvvv22/JuofCvylvDA8W9cO1LEm1/nMY4YsjQKrqv7Wp0fYBA2GBjjKMHMly1/BRPc+dEnpuwGIlmCVSMyITUs1K5iWHSrp79s8XdmfKWNOORQ25P9S+UNu6NCj/LD9QzmQaI7it3tv+BQHukg6ZnWOajtl9qBYXI5r61i2u3go4ohER8vW7oiPFJwbnM+QmQDJdDgZ2bwZyiDG8wBdXXgbiYqF76LiI5eqdN/Nn3EAXY5XxYsrDyAW3J4WczIzOI1rK+GV2sWWSXP/OFMe96R2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNVSIe26ECwTmUUdu9OxBK+AwYXJ65bqxbe6rSsRV5U=;
 b=eR3tERF6RtVPVTaCsJd8uxexttlN6Za1cEZmQUeRhzchtPETrSuHgcpWy8BCAsrcT19czmkg7PTnXDcf+MK7N+n5P09i/ZFwaqFcSJWyAo9HAZ0hFkhz2bhiNoz3DGsNQV2TbhCLiKmQq0GVovDqHt1zIJ7CBLAlEp5lnbrYerQls0YtRha2f/0eCqOIzGyP49I0BChRxfSe5G7oFv5xRGJQWJEDj1FbRC8xT35qfHqUbPeAhSRqUegowG+LmRQ6ZyWeEedQ6aRQxldtaQpp5JZvnim37IDnGCSDdb79/zCb9VmK+8IakS4at8pDDGps3ZKqupHXv9kVzwLstouulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNVSIe26ECwTmUUdu9OxBK+AwYXJ65bqxbe6rSsRV5U=;
 b=2AZS6ublLqfF5bDtMZ6YOWRXe2uGV3ySe7IXzlINmsBoQVef4gk1GxODjAA4AayNmsseEishdsKYHy7XAj7ZDBsHyscIL6//U1Txww1iWpPF/HnU87qoorPglHHc6kPNAWSpZi57iYLNnP0GjuVChWzQc0lcR7ysOFQDEUkvxS0=
Received: from BLAPR03CA0173.namprd03.prod.outlook.com (2603:10b6:208:32f::35)
 by BN7PPFA42F4F89B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6dd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 16:56:05 +0000
Received: from LV8PEPF0000005E.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::55) by BLAPR03CA0173.outlook.office365.com
 (2603:10b6:208:32f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 16:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005E.mail.protection.outlook.com (10.167.245.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 16:56:05 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 11:56:02 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [PATCH 0/3] Introduce Enhanced SMT Protection for SEV-SNP
Date: Mon, 14 Sep 2026 16:55:53 +0000
Message-ID: <cover.1789399214.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005E:EE_|BN7PPFA42F4F89B:EE_
X-MS-Office365-Filtering-Correlation-Id: d93132ec-d51d-4bd5-4a8d-08df12811113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|13003099007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	lEDhI2u0Yu9Y8aHmHKwfdoLc3/GwrJr0GkzoewWKC5WrpEyONbutM/C6nCPfpblPZGCYdgmG6JH5vQQ6beb4LNRUypbZ4jvZ3T7bU1W0wnieFKz7RRFaVh8TGRxm3mtz6akibHFPtB1oPzqrGkTYnPvA+w3V9wZAT3vu2a7FsqThygIGXMHRSuJE5ZL5jbIZvRf0e2jsSVpQwa+fW/K34mHtKUozrY1thgEO55kST6gGgy8gTuo05pH8ziiM4biYx3VP9+x8LpOlDSiy5YQctqHQc9ltcmeAiTQX6VKSkON0bet/2ZQbA6B1MTZ6OhTKBQ1ZT7/WxIf5aIEvC2F20v1YcA4bqDtZMLzkDUAwR+VoA0PaajXLO3bYAZ7m7YmzqB7dcTKfytC4c77QbKBIcwvsPXrzV1J+P5yNot0pE6o7RNhzVnmu1oxnQfnrxJspV3pREdEyHCa0q8zul0ErLvaRPFWj0ib6rQlbKebA8jAo+aiMmWxwZ+75sr7GYD7RisJKKR74HFgYNrYIGmFtRel7ypm9M+vThQ6W08yDLdR8MbmEuWqxuwbuTNTxemDXV1KnebT8XeOOXODzgwocxQldb16c1tSW5Qlh5rBpKlXLxrBd7iLtM3cvKmCdiYSnl4jZyY9VE8xEFSPY/kGsN37ObXbdUn+zlNypPO2faBJuPb1Cm9KfWjckL8mCWD3/fXPr/ri5tce8MzTxLY+n8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(13003099007)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RRekC2oQE7YPJVRhrHKzMgAzH/APyhCtgeZpWKKxBeRMJXZyXbjd4e/LnsdjbPNd5A4iOslHuVZTO+v7A4xD9OnZn1aIMFiqdzTmJ3nmY49wd2xJZJzY0PWN8ne9PwpBB2bu3Mqn07QYnNX/7GVl2M6T1pKObNKLkFP004JRhVEyK6nR4UTNP3MiGCAATsld2mRMsX9h2nOOvuhKJBEnhvC30mqhU1SIVE/U6HK408P20up3ddme5mDKu4azQuBXRx6o3xOplwTSwTIrW7LoQdVcIdjoERj37+5lEsWFE9X+u725/UF+pvTGd/kowyi1QUCnYpzhhcLvm2fmxd5V33S/Llq+sGTfqfT8FyGC20OzaOvfYtsBs1Sk2SqIUodGEqygtvFDjsziS/g7zZqLS++6PYDCz9EEVDve3wxjN/CiwodWzZOhAVNfiN1reHE2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:56:05.6021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d93132ec-d51d-4bd5-4a8d-08df12811113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA42F4F89B

Enhanced SMT Protection (ESMTP) allows an SEV-SNP VM to require that,
while one of its vCPUs is in guest mode, every SMT sibling thread on
that physical core is either idle in host mode or running a vCPU the
guest itself has declared a legal sibling.  This mitigates the
side-channel risk of sharing core resources with untrusted host threads
or with another guest.

Unlike core scheduling, where co-residency is a host kernel policy
expressed with cookies, ESMTP is enforced by hardware. The sibling mask
lives in the VMSA.  The host is not trusted to run arbitrary kernel,
userspace, or interrupt-handling work on a sibling thread while an ESMTP
vCPU is active on that core.

Both KVM and the guest fully set the VCPU_SIBLING_MASK, which places
every vCPU of the guest in one group so that any two of them may be
co-resident.  Combined with the ASID check, the sibling of a vCPU in
guest mode is then always either another vCPU of that same guest or a
thread idle in host mode.

Usage
-----
Requires patched OVMF [1] and QEMU [2] builds.  Launch an SEV-SNP guest
with ESMTP enabled on the sev-snp-guest object:

  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,esmtp=on

ESMTP is opt-in because it carries a performance cost as VMRUN stalls
until the sibling runs work from a trusted vCPU or is in host idle.

The guest reports the feature in dmesg among the SNP feature names:

  # dmesg | grep -i SEV
  ... SEV-SNP ... ESMTProt ...

Empirical test
--------------
* Identify siblings via:
  cat /sys/devices/system/cpu/cpuX/topology/thread_siblings_list
* Pin the guest on the siblings
* Spawn a load in the guest e.g. via stress-ng --cpu 2 for SMT=2.
  Expect the guest utilization % for both sibling CPUs to be at 100% as
  the vCPU siblings are deemed trusted
* Spawn a load in the host latched onto one of the siblings.
  E.g. taskset -C X stress-ng --cpu 1
* Expect CPU X's utilization to be shared between host and guest %.
  Also expect drop in CPU utilization on the thread Sibling CPU as when
  the host task runs the guest will be forced idle.

Patches based on cryptodev-2.6

[1]: https://github.com/tianocore/edk2/pull/13128
[2]: https://lore.kernel.org/kvm/cover.1789399242.git.prsampat@amd.com/

Pratik R. Sampat (3):
  KVM: SVM: Re-queue events that were never injected
  KVM: SVM: Add host support for Enhanced SMT Protection
  x86/sev: Add guest support for Enhanced SMT Protection

 arch/x86/boot/compressed/sev.c     |  2 +-
 arch/x86/coco/sev/core.c           | 13 ++++++++
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  5 +++-
 arch/x86/include/asm/svm.h         | 12 ++++++--
 arch/x86/include/uapi/asm/svm.h    |  9 +++++-
 arch/x86/kernel/cpu/scattered.c    |  1 +
 arch/x86/kvm/svm/sev.c             | 48 +++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.c             | 40 ++++++++++++++++++++++---
 9 files changed, 121 insertions(+), 10 deletions(-)

-- 
2.43.0

