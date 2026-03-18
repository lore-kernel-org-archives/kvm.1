Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25776374176;
	Wed, 18 Mar 2026 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820645; cv=fail; b=OEcKHr8YCI38YAUpC99g1NH59A8WfXD5NIjyMKDBuL94WoE/4YdQ0xM2Sp2e4RRETMiwmv28b1toRSIZSo944DkiBCy78c4Ya4V+Zfch0rg3MPAWj6itWel1bKph4rne6X//MqaXW2Bi7ioL0pUPZtNK8BSC/6iZfyc2dzT0Km4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820645; c=relaxed/simple;
	bh=V24vgkA4jkwGjHKuKOwblJ1LUNqMgTY/m5QU7yF058w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tsj9H0H6De5m3GX+R+0zVH7BCY5ZQ3rOBosll+hDJj5Wzx+l/aHD9EhDNzUehXnlMP3lh96HlfdzDmy3LvMqW8fIJY6dXr+rkZe/bPp2ynFGxL9xp0A9jJFQsZGVFT6Owil+tNm5GWdZGOyhtmaOpK4QU17f5hD2GQvbxPUND4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uyUtjV5g; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uyUtjV5g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEk2iRdXr6wiybKRtVGC0D/Rf91V+2Mk2ilA4jyQ6bSsy+GhAEnL/v4mJejaEDgmxPwBuwKksxVdZXcfD1B/k7yNX0jAz5W1aKXgqJSk2IcVph50/RvPdAZBkt/Rx8/60aBbxynNjy3S6+V/Q4Lwkd2a+nI59lWHKo/w5+803/Cvp6vJgiVMunuIJ2hupMLlFaGP9ZAlwGNGN8QSxxZPVrv/9PGUw9JbMpMS50UPYMmkvzrgo9I00u81su7QpxKu6O2De37WdcPuokwuRyanKSm3G9Y9eIGVCi/u/YUIgyPl0+k6ciV48p10U+pYq01vGMoXhS6kGmraori5Ro1qtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tRiYzV81pD/mLqZOvIpDxe0pnHkpd+TP1NDyXcu+K0=;
 b=rMjuxqYG7u47R2yapKXfwPyOibiMPewPBjo8mDPox7vB053kTlPTuCNbOm5S92YqCWm/kYE8a+fYR5CEOHYKikrqT4U8oDp83065i9cXgu4Eep0kQ3XUg4rX0uVKDrDXfyWePC8iMGHzKMJOfPDxTnuBgh7SgV24X5IlM96sJcmMGeCQfMydcOlukpX9NTrIbYNrUOuwZIUc8tlcJ4lTA1QdZhRNQ5X4fK7uDqSrj22yzISLISZ3Wgsw+upfOeWwJ/2s33hy/GjSIej7C4s31misYRKY6+czICEWJhDoAiJEksJEP1CvQ4xT0ONZb7N4EFL34R2OBYBW9ic/mrPIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tRiYzV81pD/mLqZOvIpDxe0pnHkpd+TP1NDyXcu+K0=;
 b=uyUtjV5gwstKAlPHKj/vy1advQsoRrA1d97RyGz30FzIriB7igGPgo6dI6wElgQwyCRtRqK5HKr94BtexVJSx1cvV7Shj5zq7HoaeMbyggZu5cy8QhGTjGuA8dhogUq6hJBNYKaq96o+0x8pm+sHo0UfAZS2yQluGvbV1LKGIoU=
Received: from CH0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:610:75::20)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:57:20 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::f4) by CH0PR04CA0105.outlook.office365.com
 (2603:10b6:610:75::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 07:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 07:57:19 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 02:57:15 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <bp@alien8.de>,
	<thomas.lendacky@amd.com>, <dave.hansen@linux.intel.com>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <hpa@zytor.com>, <xin@zytor.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <x86@kernel.org>,
	<sohil.mehta@intel.com>, <chang.seok.bae@intel.com>, <jon.grimm@amd.com>,
	<nikunj@amd.com>
Subject: [PATCH v3 2/3] x86/cpu: Disable CR pinning during CPU bringup
Date: Wed, 18 Mar 2026 07:56:53 +0000
Message-ID: <20260318075654.1792916-3-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260318075654.1792916-1-nikunj@amd.com>
References: <20260318075654.1792916-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7aac56-b585-4923-8bc9-08de84c3fb10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pM3ZX/wesqZ5T15ZTdUYbRR8ydkzYgZ1QfEnnmZBWUF0hJsu93XfWThaD/u3QMb4WvCCiqcDVaaLSuG16IgBLwK4zSbSxbtmNVVDMV+juY/TppHg8JMYfQZTuvyli7Ss3lcK5VqU3xhVO78IZslTnEr/JADunFVNboGBEHcbOT6TfQQriPXvLwQV443s2fVtHtZZ2bRJ4UrWLmsPwLUT0APXRrT0hgyUnz2+IkWaGuU486KQGCurR2tGPeLsN67J5SB0jp3E6imifMQH5h9rm98rFvjpE8Za7PCG3QIxQVWefyCpdiUWYgAHjShFcu3S+5S35Fsoqylhauoh8Ypm0HKzO2LdKK1UJqUYmQ2oXFcgRvTW2hQ2Osi67Bu9DVtGJqjRv+Wm3iUzTJo+y2WSl1J9lQ1qWh1DeqmuOYDBxGtjwmk25SCwdjsl/H/isdXnJxzZM7kF3bm4giuved+FhI9daxTrNq8AmuKmxAo18bU/Kd9g/FrgHmjORkkzrlQg6T6gf7Re+5AMXOUAM384N3xME0nR/Ml5aUiULAtljyIX+q7OFvXXFnyDhrykxNVnUAq/00N2fgnAJnxwHi+e+/pPa73Oo4euP4AcjAkBI0SzARtYIGrHddWssRmm2BDjqG5EOye3VAhBjRrVf+NN541zoma4InBz2tHkLQdWTBguBIKwrE/1EGksdy6x6LJywL8LTyTf13lBnGyH4US0i9Uzg1bIfjKcdNezN8/FtrquW5T4+9GI3r5Olb6qouRjNaz2hHQ8xhBUl2Jia7ia8A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2KuePkvR5O+LJpZo+G6IfCw30Q7HZHyu9V540dgVKb2FbQd/xBR9wNwQrvplp9kKvmtgsQuOaK8DaZRAGbKEXwZgtRtjFfaGGweCyz3mdK+QAlXvUxgXQxxk+EHOk+ch+NGTqdlhBGxLJRaX1+OcqVI7RV1EcEpJ5fy4PJVvRvLiXgGFP7APr7rY41+ZmE33Fd2E0KEoH7WJ2CdL8iIGwBKyT2+8xwJjJKQVqHX+lfgxRAzseByWTA7TmTTw1PJWt8UrwIq2Thlh6r01Aif1oNj5XNGErOYdQ52stOkdnuS+BlHmOp2MaXLqa70oU541CFpqmz9Yqb2WvWraYAr5leDFV2/eqocY2eeKjJkzSXmQi47z7QomLunG/g9zhMQcb18rb5ivKf1rtY8+4YjxbQ0b8i+V5LpcfEr8uwOho3UxBP4g5JBSfSjDL8D0TGJX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:57:19.8041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7aac56-b585-4923-8bc9-08de84c3fb10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368

From: Dave Hansen <dave.hansen@linux.intel.com>

== CR Pinning Background ==

Modern CPU hardening features like SMAP/SMEP are enabled by flipping
control register (CR) bits. Attackers find these features inconvenient and
often try to disable them.

CR-pinning is a kernel hardening feature that detects when
security-sensitive control bits are flipped off, complains about it, then
turns them back on. The CR-pinning checks are performed in the CR
manipulation helpers.

X86_CR4_FRED controls FRED enabling and is pinned. There is a single,
system-wide static key that controls CR-pinning behavior. The static key is
enabled by the boot CPU after it has established its CR configuration.

The end result is that CR-pinning is not active while initializing the boot
CPU but it is active while bringing up secondary CPUs.

== FRED Background ==

FRED is a new hardware entry/exit feature for the kernel. It is not on by
default and started out as Intel-only. AMD is just adding support now.

FRED has MSRs for configuration and is enabled by the pinned X86_CR4_FRED
bit. It should not be enabled until after MSRs are properly initialized.

== SEV Background ==

AMD SEV-ES and SEV-SNP use #VC (Virtualization Communication) exceptions to
handle operations that require hypervisor assistance. These exceptions
occur during various operations including MMIO access, CPUID instructions,
and certain memory accesses.

Writes to the console can generate #VC.

== Problem ==

CR-pinning implicitly enables FRED on secondary CPUs at a different point
than the boot CPU. This point is *before* the CPU has done an explicit
cr4_set_bits(X86_CR4_FRED) and before the MSRs are initialized. This means
that there is a window where no exceptions can be handled.

For SEV-ES/SNP and TDX guests, any console output during this window
triggers #VC or #VE exceptions that result in triple faults because the
exception handlers rely on FRED MSRs that aren't yet configured.

== Fix ==

Defer CR-pinning enforcement during secondary CPU bringup. This avoids any
implicit CR changes during CPU bringup, ensuring that FRED is not enabled
before it is configured and able to handle a #VC or #VE.

Drop CR4 pinning logic from cr4_init() as it runs only during early
secondary bring up while the CPU is still offline, so CR4 pinning is never
in effect there. Remove the redundant pinned-mask application and add
WARN_ON_ONCE() to detect any future changes that might violate this
assumption.

This also aligns boot and secondary CPU bringup.

Note: FRED is not on by default anywhere so this is not likely to be
causing many problems. The only reason this was noticed was that AMD
started to enable FRED and was turning it on.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Reported-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
[ Nikunj: Updated SEV background section wording ]
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: stable@vger.kernel.org # 6.9+
---
 arch/x86/kernel/cpu/common.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 6778ec5846b6..b2a4a506eae9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -453,6 +453,21 @@ static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_C
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
 
+static bool cr_pinning_enabled(void)
+{
+	if (!static_branch_likely(&cr_pinning))
+		return false;
+
+	/*
+	 * Do not enforce pinning during CPU bringup. It might
+	 * turn on features that are not set up yet, like FRED.
+	 */
+	if (!cpu_online(smp_processor_id()))
+		return false;
+
+	return true;
+}
+
 void native_write_cr0(unsigned long val)
 {
 	unsigned long bits_missing = 0;
@@ -460,7 +475,7 @@ void native_write_cr0(unsigned long val)
 set_register:
 	asm volatile("mov %0,%%cr0": "+r" (val) : : "memory");
 
-	if (static_branch_likely(&cr_pinning)) {
+	if (cr_pinning_enabled()) {
 		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
 			bits_missing = X86_CR0_WP;
 			val |= bits_missing;
@@ -479,7 +494,7 @@ void __no_profile native_write_cr4(unsigned long val)
 set_register:
 	asm volatile("mov %0,%%cr4": "+r" (val) : : "memory");
 
-	if (static_branch_likely(&cr_pinning)) {
+	if (cr_pinning_enabled()) {
 		if (unlikely((val & cr4_pinned_mask) != cr4_pinned_bits)) {
 			bits_changed = (val & cr4_pinned_mask) ^ cr4_pinned_bits;
 			val = (val & ~cr4_pinned_mask) | cr4_pinned_bits;
@@ -521,8 +536,8 @@ void cr4_init(void)
 
 	if (boot_cpu_has(X86_FEATURE_PCID))
 		cr4 |= X86_CR4_PCIDE;
-	if (static_branch_likely(&cr_pinning))
-		cr4 = (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;
+
+	WARN_ON_ONCE(cr_pinning_enabled());
 
 	__write_cr4(cr4);
 
-- 
2.48.1

