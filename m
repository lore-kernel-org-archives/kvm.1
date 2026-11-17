Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794954796;
	b=TkyKeiCjzqVDAtEgkPyHCshT7I9RLFZK5R9LE0PFY2vfdpBd+2nT3L0ibEP897XXAv8g
	 Fk76n1TQPovs3O67wZS7X/LokQJlneM/PQRnxmcWSgoWgEj9mNyV9Vb3QAGa2w+2CBnro
	 8dUgdnmyEVEseX0fORTgT7bLRTAStVyNpRKQPF2nnu29/hM+FgHjNmI/np22/eIM7wuXg
	 2C5uKSGIIWjKD8opiKSDMlkbJtw93ypSe0i+lOffGtvaAW4M7djpUtzIFK8GDhvfTpS6J
	 Tk9vw7S3pKUP+QD//6qoSnH3zLAJJvIVHTx/nQDKrngauYtJpxe30i5ZuBlAn8IXWbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954796;
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
	bh=orsPX4GfxVJkqjyGMhz3Y0tn+DRby4fgLj1BadGJ7NU=;
	b=v0+40/0IA1vZLY4Q3wKCzQtp1W9AWCR5Q8hvLSnQqKhelzajGv2UhlBoVOlt2DBQHhqQ
	 xjsE4IXMYaWY48/OOMsNQRjUPK5hU8S7XB0m10PU7Ci9B79k6BpjVLCuRcZoLMFDQe3vI
	 NVYT4VNhqOaJq6GpPbQ6/kVAiwaRUK8ZUdoK4kju4nbwQ59rt68cr5bSxkAvuKggR8e9P
	 IIlfoDX4fC/VCLTvcphjmdC7UBpDp+P49V0rdpnSkxgt7eLFoOiyeZoKtzBCXEutebu+3
	 cwKJc/kq4uR7w4hiu6sDA/bkctW9+lpUMSJEwWhVWFTyRsAsd4y7OzJNGZ+7sxi0q6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5qQKDfgb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.46
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6C606A31C;
	Tue, 17 Nov 2026 22:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FB6C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5qQKDfgb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUd+Gyj865qoR+JMJ4GqJDX55s57Q1QtkMtD4MgFhJnhN6fzdbddy+LVpEE8G382z4OVKHYQvMOwixEPHxOCkP6sCo55o8y9sfNWwLUZHqqZnD3h9a7RHoFFN9a2Fpp7T77y3bDxv/BFh0LY6Ieo/PP2FJDmMm/pUE4a8SF8+/BiTvPKiMTEIGnHmTAqglyLYwy1ENWTBnWN+TQUIFhWoloPmHzBLrKH6ZIGls6TQUiKU93QfK6pq0gLIs8BhVkB7efqFkQPE7kI/PqhDourCMM7rFL4dYza273OeWOwf0P9Xchlu2jiAkS+CUUDuSaCsqwVL77sxMe2fVj1a2yhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orsPX4GfxVJkqjyGMhz3Y0tn+DRby4fgLj1BadGJ7NU=;
 b=QLJ2vb1by9DWqTb/VRYAi4kI05y0Pa6xkHJ820w8MD2BozSC0Ldxc+ewZLAzOTd/cS9fu8bz+8hSvQ5ep+kIha/z0dNTyHd4XLlPEFln7tMHlb0u2wcmxjaZcw5PaEfr0epOU+3J5y6dPfLeu1+W+CBKu5IbLetZdD28PZR7BKGgA4xRXdFySlgf+3Cjs+nDIMI2ZDjp8o9GldODEFCOu4iQS8CjwIjIPFnjyP2rhBBHa1mn+jcpZGLVLsPgOVTAqqNXyyp+7xm5bZkm1Uan9SciDhTDBZrJMup9YnsmduuS64NtzZVKTZgZ4Pwy3lyyRH3z5sLBQRSS6QUhAVLsBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orsPX4GfxVJkqjyGMhz3Y0tn+DRby4fgLj1BadGJ7NU=;
 b=5qQKDfgbyepBvPzEYbhWTaaQC3/CUdNhdsdsmzyU/23fmoZdzlOSEaxNAgcUHL9+sCSc2cnF/4ACpBnHgY6pvzIm91UwEFc6LDMdPrq1AhHi2aJ8qXsV5Mt9McFw2ANN6pUUXi3+ozHQNkWqCKQgRvFVy6VfI/0YweJl6ssIEQE=
Received: from CH0PR03CA0360.namprd03.prod.outlook.com (2603:10b6:610:11a::11)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:33:08 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::3a) by CH0PR03CA0360.outlook.office365.com
 (2603:10b6:610:11a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 17
 Nov 2026 22:33:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 22:33:08 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 16:33:06 -0600
From: Kim Phillips <kim.phillips@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <tglx@kernel.org>, <mingo@redhat.com>,
	<ardb@kernel.org>, <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	Kim Phillips <kim.phillips@amd.com>, Nathan Fontenot
	<nathan.fontenot@amd.com>
Subject: [PATCH 0/3] x86/sev: Make guest termination reasons identifiable
Date: Tue, 17 Nov 2026 16:32:54 -0600
Message-ID: <20261117223257.748178-1-kim.phillips@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aaa8eec-bbd3-4186-7415-08df44fac15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|921020|10067099003|5023799004|56012099006|11063799006|261021121427099003|261021123027099003|261026121527099003|261022075727099003|261022105027099003|261022115727099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	VfCridpIrybTIdDItUjIbBof0paH0bqGJQKeybN3/saf3BXdG9K8zkEwnKsW4wQvJRTGBWsdPPakM5o4RA5s0Eou2Mo7EpVDez7KB2xiW/mb6zI0SbvAH4V2+3eKo78Bw/ChwKDNZfhgvkj5zjNWhGc0IuGkItJ1HPoxn2Qi5gOnvlRWJufTVPRCvRrmhjP4DqZ0VR+xINIX3mUnGBbDRIw1kyzOJZoWpiKJRn0kN6revsQByS5oV52Trk0dQ3gcYQuowZGOdG6ArOT1WqTKQRWy+ZhVRx0DkwzFjO1ZmDvLmPUGZB9zA9Xr0pws8HwJGEcLKy2LoUCjEONMbUbkoZgwHNHwwRUmk+KmlNm5wT+ngzVSzXHndnP0HKhe1BVnE1VWxrNSPQ/fOwip9fjBXuiRuWitF3w43+bMRkvKHLxxC56atjU/senj8SGQYQVfOtpWDRGHIH1cQvyoXS2C9a2IVSnvh7s0LU6NlimdziYDRVjgJR0HpgEpxwsBrGZkbaBT5ZGy2xVm14bkO7ob0/zmHuS7CVlBz9LjmTuLTAD9ZAieR/+3Oz6zxIxR8BUWvZ2oHyztcEDHWXLVrXJcUSZwflv7S1V20qDhQflMaBRp4a2JMB6bvykY+CIYo20N1rKLZQrz7wVobmnHdI+Hwc5Ft0L4QmgEG8f5mQMgZNK0/q1Ve2/2n3nR6IjSenP+BM/n0Vb17QMySZHMdj6VUlqOco8afmHhrOYbglYnliFt4ngHKeKk0X+xilmSkim6
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(921020)(10067099003)(5023799004)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261026121527099003)(261022075727099003)(261022105027099003)(261022115727099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V/82IdcvUZNbSo0y/md7/nKMgOauC2jjWws+j5AGlBp7iYRF+CFDMju4F+/iq4C1uVyz0oStt6I2kO4A+BmLvkGi4x/xIiiooLdLgjsuS11lles0+c9EdrOujW/FGA7lcUEvxCwEhULp8VRrD+fWX7sw/VXDYKnxSYCbheNUDn2Dd2jdySqZE8aK7cbQxxWOQtigvdBsgjP/oM1a1Hpvg5P/jIWairthh8GitMLV0DACizzlWEANIESeH4CXwlLslYVBqgZ+E2IOxiksOQzFVAcxiNhDPYpyyxcRcZ0vQJpo/yr8ePRLLNNfIV6qld0QoDNUO/WChcqjV+mrwUhb21PU4LX/eHx4H2lAaNQSWNKbH+Pdsv1tpiOBWIHtf8qqcsPOuk+MgjI9RtOqWzp7T05f7kU7pri1kjjZzAWe1a7qSCvm/B6PXjFVfX5C4av0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:33:08.5961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaa8eec-bbd3-4186-7415-08df44fac15a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784

When an SEV-ES/SNP guest dies early, the only thing that reliably escapes
the guest is the GHCB MSR termination request: a 4-bit reason set and an
8-bit reason code written to the GHCB MSR before the final VMGEXIT. There
is no console, no dmesg and no crash dump to fall back on - in a hosted
environment the guest owner often has nothing but that one code to work
with.

Today a large fraction of the termination sites in the guest-side SEV code
collapse onto a handful of values that say almost nothing about what went
wrong:

 - Six sites terminate with the generic (SEV_TERM_SET_GEN,
   GHCB_SEV_ES_GEN_REQ) pair. A #VC the decompressor could not handle, a
   #VC the running kernel could not handle, a GHCB that could not be set
   up, and a GHCB protocol negotiation that failed are all reported
   identically.

 - do_vc_no_ghcb(), the MSR-protocol #VC handler used before a GHCB
   exists, funnels every one of its failure paths through a single label,
   so a CPUID table lookup failure, a failed hypervisor CPUID fallback and
   a hypervisor lying about SEV being active are indistinguishable.

 - Both find_cc_blob() implementations report GHCB_SNP_UNSUPPORTED when
   the Confidential Computing blob they found has a bad header magic. That
   code otherwise means "the hypervisor does not support SNP", so a
   firmware or bootloader bug inside the guest's own boot chain looks
   exactly like an unsupported host - and points debugging at the wrong
   party.

The cost of fixing this is low: the Linux-specific reason set
(SEV_TERM_SET_LINUX) exists precisely so the guest can report codes of its
own choosing, and the existing GHCB_TERM_* codes already follow this
pattern for more recently added features such as Secure TSC, SVSM and
Secure AVIC. These patches extend that convention to the older, more
generic sites.

Patch 1 replaces the six generic callsites, adding GHCB_TERM_VC_FAIL,
GHCB_TERM_GHCB_SETUP and GHCB_TERM_NEGOTIATE. The four #VC handling
failures deliberately share one code, as they are the same failure class
observed at different stages of boot.

Patch 2 splits do_vc_no_ghcb()'s failure paths, reusing the existing
GHCB_TERM_CPUID and GHCB_TERM_CPUID_HV codes - no new codes needed. The
two checks that reject the #VC before any CPUID work is attempted keep
reporting GHCB_TERM_VC_FAIL.

Patch 3 adds GHCB_TERM_CC_BLOB for the invalid-blob-magic checks, leaving
the sites that genuinely mean "hypervisor does not support SNP",
including the CC-blob/SNP-enablement discrepancy check in sme_enable(),
on GHCB_SNP_UNSUPPORTED.

There is no functional change for a healthy guest: every modified site
already terminated the guest unconditionally, and only the reported reason
changes. Hypervisors that decode termination requests will see new codes
in the Linux reason set; that set is explicitly reserved for exactly this,
so no hypervisor can have been relying on the old values to mean anything
specific.

Kim Phillips (3):
  x86/sev: Report distinct termination reasons for generic requests
  x86/sev: Report distinct termination reasons in do_vc_no_ghcb()
  x86/sev: Distinguish CC-blob failures from generic SNP-unsupported

 arch/x86/boot/compressed/sev-handle-vc.c |  4 ++--
 arch/x86/boot/compressed/sev.c           |  2 +-
 arch/x86/boot/startup/sev-shared.c       | 14 +++++++++-----
 arch/x86/boot/startup/sev-startup.c      |  2 +-
 arch/x86/coco/sev/core.c                 |  2 +-
 arch/x86/coco/sev/vc-handle.c            |  4 ++--
 arch/x86/include/asm/sev-common.h        |  4 ++++
 7 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.43.0

