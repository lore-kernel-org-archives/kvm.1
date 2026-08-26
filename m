Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B68404BFF;
	Wed, 26 Aug 2026 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783735; cv=fail; b=hR8jwUPKWdSLZsQceHnT3iDwjEX0fpx34EgbheoGGOad8AeqUEjBRerBeb6q7+ktJzhif+gbjGe0XyzneHLVRcfIFDA7a//4blBfX1/67Rs+iWccew7X4sTYkgpADQvx5j5w1MKJ48PGJmvO9ardlJX+jKwahsQced0QaZsKi+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783735; c=relaxed/simple;
	bh=dEPlowdhLAcrP7lwc7VCwdX86Gmjqmi4SIzTgvG8Z2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lv+hVGjcoSD1QHhhs044PKhf+VZcmoCZAECnyQN1GqmXGjEghXA3NQP3EFVyBqXBscdkyD8nuiaHEwIC16bpyfSVpp02bUaE/aOrZ5Xtzip9ZEFHbBhNi5jyKS3CtxzkEKmaOkZ8tMDc+o0K8OTNuqf/ac2ilpOSoHLNswv7kmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EUwtXbZA; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EUwtXbZA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKPmfD+m0xAk252vZNrUejLAQZxc8vf+G+wy9eP+y+mZxa2MbWDUqGhwXXJItXfQTWbx1LPwDR5sMKxzNKOAOWrxiKdzR6QUgGalthI7E14rqPc57D1iP/g+Rn41dIBGKLBiUrTXoawh4UjtUdACXcrq1NWuEYroR84EcQaL+VTjgQfkuOs2r8S1gYrPlrnI1DbTG+SDEnrIM/7YydO2zG3L/H8Lqkn7+uZKKfRAbkc8O+khDyOpV88Iegdw7ks1iStcEGmeYpC7kAXf6Cz7mwZmwYlex2rMjBGPBNIpydftDHS3tgaYwLbyysB+L8d/LVcM5MYX1qoCUSQvBVQRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlMfJf2YEpYx/mgOUx7h00zVJAj4j5CyDNOS1kD1Qf0=;
 b=irZPoS3Fc4kFZaHDahq+blY89KCj1NLmM2MnPhejGifUsRPhaXk6ZPaQ0Oz37Q9sJmL0vicjMZsfDppMtLP0cPfeRAMopbs/oN8gTYCFz1t07ItjpGcfaftYZFmPCDvguCYVqqH1irQ0YqlLja/nW+Tc5XkryLlny5Pc93qNDaQ+zGwq1XljZZIaYCdLzb4iRRM1gz7FXtu6ISDd5w4Lt4BFSMR2IaChaKMJDbTulYefHGyj+0+dS/pi2IjosHEVp4PgZoLBXBCmKZbrmGcHa7LYtAUlgjVowHUWoQIgNvmoWa4fZOU86xwtwhv5aOyLY19sW0GvSgF3xZtVrAKy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlMfJf2YEpYx/mgOUx7h00zVJAj4j5CyDNOS1kD1Qf0=;
 b=EUwtXbZA2xvJJqOcLoxA3B8RSAEjepw441tcZHS6Choq7ECJdX+X0L+kxJgPT2rsdjxh1IB1CzAeYlCxPmrlggu50OQV0AnctKqbG+vzzkOZkmSYMFOhGuOhNl1bUWr2KoLDwh8VE0pAL2IeJPtiD9C4TUKyczyRW0th4ALxkEY=
Received: from BN0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:408:141::33)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 22:35:28 +0000
Received: from BN3PEPF00022BBC.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::96) by BN0PR07CA0024.outlook.office365.com
 (2603:10b6:408:141::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 22:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BBC.mail.protection.outlook.com (10.167.248.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 22:35:27 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 17:35:26 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Kim Phillips
	<kim.phillips@amd.com>, Nathan Fontenot <nathan.fontenot@amd.com>
Subject: [PATCH v5 0/8] Add SEV-SNP BTB Isolation and IBPB-on-Entry guest features
Date: Wed, 26 Aug 2026 17:35:02 -0500
Message-ID: <20260826223510.3669875-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBC:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: d64a83b3-e0c7-4241-d5a9-08df03c25412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|18002099003|11063799006|56012099006|5023799004|13003099007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ka+ugnXJMqIDStX7vAZ/2abmu8z8DB8DvCdElduBc6yO5QcOgIP2qXIjv/5YbpIp00Km5zE8OXXucL9GzDm4laClGW0Jw4/MZeVVb02NF1OyZZBvR0BDin0boJjGlGwZS3C7Cs3ZaMAtVCjAZNOhJAtwO/R0oY44Axjnlgi/MnVHwemnt1o84Sz7euULmcqI7QKL08Ksoj56otpTyNDpn6i9Bfz03P7wyYO6V4OaYLRaN6C3W6hazck7WozWr66VikEA+OQXSj8Xr9AxVmipWF7wfTIFItRbdaqYtFg3ohpOhq2FvV9JDa8NYtL2OnJWDEFjE6kmhTIfXDNc/SevhFZNbKVjZwcl2OySxNWRmIzQLfyq+1xVwgFzs1kuZnWwiyQjNhzHTE5AKuK71H9Qt8CXy4I8Ekn2iMEaEnek2guYpQYR3Jfk6b2LYGbdVBBomHe0T6ILjbX0nnhFq0QPqKzHJcsPIwZeBLSPu0IxWpaxAA7D+f6PP3UyEsvM/Y0OOon6S/wfA71Wmxh4LiANy1ARuYv+aC6RaWfsb2DHosir96fTH12nBNC8zyanNprkZ2rVCKVoNHS5ue7/Am3VxrNU57+vZLLI37NnoMeGF7flQgOPrO0YiTVQAUN307z4ts5r6H7RyY/jeOJaKREcEclCkjEra1VNa44Klj5alpBtkjZQpp7NLX/Jm396kLiTJ5VlJ5PXI2u+6fcLPsnNGw==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(18002099003)(11063799006)(56012099006)(5023799004)(13003099007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tafv2dsXsag/8vJHtve+mgsi03y9Un8Q0cd0ZOfSdQO01UU3qiH2CeU6zE/oiZdJ9eHDwFug/Kbx2engYAwq69yXy/bsZaD11ibsRNAZVJSb+hAC133bV62D3S1jlMW8B3u2etTJik2lqfa6389hKeYhPk+kftNhGLRSkFJV7uurhuKUE9mUsytIpfUsBNieZsAP0F9TpZrOUgNGMQHm7WNs8jyTeZ88iPaaL7CQzIf0v741dqOfmXqEj9p/DOEB2HRejvfYub+HjnFE92QleGoKjjmvf9zU6u05xHt9fnPlbZStXIXEhulo/MZhMljogJxRw8I7JSWqaS6YnqIW+YUeIT5jFevjGYrJZ4S5z5BuffRPQnksO1JzNNIoWUiDVkqPPcyP5tQeJZDb0nzusr87bSiiQ0GI9QRrVtwQaPAlmuMdKVj+ww7CL4QN7mW9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:35:27.7218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d64a83b3-e0c7-4241-d5a9-08df03c25412
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172

This series advertises two SEV-SNP guest-selectable side-channel
protections through KVM's vmsa_features ABI -- BTB Isolation
(SEV_FEATURES bit 7) and IBPB-on-Entry (SEV_FEATURES bit 21) -- along
with SVM_SEV_FEAT_SNP_ACTIVE, and fixes two x86 mitigation-selection
bugs that stand in the way.

The cpu/bugs patches come first because they are prerequisites, not
drive-by cleanups:

  - Patch 1 fixes spectre_v2=eibrs silently selecting retpolines instead
    of AutoIBRS on SNP hosts.  Commit acaa4b5c4c85 ("x86/speculation: Do
    not enable Automatic IBRS if SEV-SNP is enabled") suppressed AutoIBRS
    by never setting X86_FEATURE_IBRS_ENHANCED, which also disabled the
    explicit spectre_v2=eibrs request.  Set the feature bit and move the
    SNP-prefers-retpoline decision into the default/auto case, where it
    belongs.

  - Patch 2 allows spectre_v2=ibrs on non-Intel vendors.  BTB Isolation
    uses legacy SPEC_CTRL.IBRS toggling to optimize the SNP VM
    exit-to-re-entry path, so AMD needs to be able to select it.  It also
    makes EFER.AUTOIBRS explicitly track the selected mitigation, which
    matters across kexec since head_64.S preserves incoming EFER bits.

Patches 3-6 are small width/ABI cleanups and the SNP_ACTIVE and
SNP-only-feature-mask groundwork, and patches 7-8 add IBPB-on-Entry and
BTB Isolation themselves.

Note that BTB Isolation is advertised unconditionally on SNP-capable
parts.  That is deliberate: the APM defines it as architecturally
present on every SEV-SNP-capable processor, so unlike IBPB-on-Entry
there is no host enumeration bit to gate on.  Patch 8 spells this out.

Changes since v4:
  https://lore.kernel.org/all/20260804235611.4053375-1-kim.phillips@amd.com/

 - Patch 1 ("x86/bugs: Allow forcing Automatic IBRS with SNP active
   using spectre_v2=eibrs"): only prefer retpoline over AutoIBRS on SNP
   hosts when CONFIG_MITIGATION_RETPOLINE is actually built in.  This
   folds v4's patch 3 into the same condition and avoids the
   select-then-fall-back ping pong.  Suggested in review:
   https://lore.kernel.org/all/lctyimdlenyb5kvfxarzajs2ggzkwn4yehxu233lojynqwa7ej@wjur3lh6szlr/

 - Patch 2 ("x86/bugs: Allow spectre_v2=ibrs on x86 vendors other than
   Intel"): move the EFER.AUTOIBRS kexec cleanup out of
   spectre_v2_apply_mitigation() and up to the top of
   cpu_select_mitigations(), next to the existing SPEC_CTRL kexec
   cleanup, so stale state is dropped before mitigation selection rather
   than during it.  spectre_v2_apply_mitigation() now only sets the bit,
   which keeps it much closer to its original shape.  Suggested in
   review:
   https://lore.kernel.org/all/ga63o6nf7xebndlo66qqasjx7axpopyph7ilkwhvx3enfaqs4w@r4qfr6eo6kcw/

 - Subject prefix fixes, per review:
   https://lore.kernel.org/all/20260818232204.GBaoTpHK8k7wD9mMk4@fat_crate.local/
   The two x86 patches go from "cpu/bugs:" to "x86/bugs:" to match the
   tip tree convention.  Patch 3 goes from "KVM: SEV:" to "KVM: SVM:",
   since it only touches arch/x86/include/asm/svm.h.

 - Tag cleanup, per review:
   https://lore.kernel.org/all/20260818232204.GBaoTpHK8k7wD9mMk4@fat_crate.local/
   Dropped Cc: stable@kernel.org from both x86/bugs patches.  Patch 2
   drops its Fixes: too -- it enables spectre_v2=ibrs on a vendor that
   never had a use for the option rather than fixing a bug anyone is
   hitting, so neither tag was right.  Patch 1 drops the kernel test
   robot Reported-by:/Closes: pair; that report was against an earlier
   posting of this patch rather than against upstream, so there was
   nothing there for it to close.  The part of patch 1 that is genuinely
   -stable material -- an SNP host with CONFIG_MITIGATION_RETPOLINE=n
   booting with Spectre v2 unmitigated -- will be sent separately as a
   minimal backport once this lands.

 - Dropped v4's patch 3 ("cpu/bugs: Fall back to AutoIBRS when retpoline
   unavailable on SNP CPUs").  Its fallback is now subsumed by the
   CONFIG_MITIGATION_RETPOLINE test above.

 - Dropped v4's patch 1 ("x86/bugs: Only log missing retpoline when it's
   actually the missing mitigation").  After the rework above this
   series no longer needs it, but it still fixes a real spurious
   "no mitigation available!" on Intel + RETBleed with
   CONFIG_MITIGATION_IBRS_ENTRY=y, CONFIG_MITIGATION_RETPOLINE=n and
   spectre_v2=auto, where spectre_v2_update_mitigation() afterwards
   promotes SPECTRE_V2_NONE to SPECTRE_V2_IBRS.  Being posted separately
   as a standalone fix:
   https://lore.kernel.org/lkml/20260826222228.3668418-1-kim.phillips@amd.com/

 - Added Tom's Reviewed-by to patch 8

Kim Phillips (8):
  x86/bugs: Allow forcing Automatic IBRS with SNP active using
    spectre_v2=eibrs
  x86/bugs: Allow spectre_v2=ibrs on x86 vendors other than Intel
  KVM: SVM: Define SVM_SEV_FEAT_* flags using BIT_ULL()
  KVM: selftests: sev_init2: Use BIT_ULL for VMSA feature bit definition
  KVM: SEV: Disallow setting SNP-only features for non-SNP guests via a
    single mask
  KVM: SEV: Advertise SVM_SEV_FEAT_SNP_ACTIVE
  KVM: SEV: Add support for IBPB-on-Entry
  KVM: SEV: Add support for SNP BTB Isolation

 arch/x86/Kconfig                              |  7 ++-
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/svm.h                    | 17 ++++--
 arch/x86/kernel/cpu/bugs.c                    | 59 ++++++++++++++-----
 arch/x86/kernel/cpu/common.c                  |  6 +-
 arch/x86/kvm/svm/sev.c                        | 21 ++++++-
 tools/arch/x86/include/asm/cpufeatures.h      |  1 +
 .../selftests/kvm/x86/sev_init2_tests.c       | 20 +++++--
 8 files changed, 96 insertions(+), 36 deletions(-)


base-commit: ec8477a492cb24f2c334847c8734ca56c7ffdd29
-- 
2.43.0

