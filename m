Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BD3318EDF
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356023; cv=fail; b=Y+8nbjdXmtUQXx5Znhql2L3eznPaWBsSav6sTAXqYU96xjSBU9CGbzTxLOY8/kvUXVdr8Sd03t4XGZCLWIAVWvxxgW/QWMPgkh/ZpSU/6/s3evs3dP/ZY2ACKNyjkBNRRyB6nz6ErUQp2mtTuy4zaQtF31tpK5kKrkYvJGSBICk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356023; c=relaxed/simple;
	bh=Rpgtkojc5qcYUeBi1VXcrO0l3Z7dLbxRN1qIXu1G3h0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c5wSAmZ+CdzUAXU4I8/4ZxkSdQgRyUcFP51ZlOdGmdiJ91MlLtKLOhk2/y8iZuwpk5V5UcOVnDRkVkxbB2ghvihj2IYwUQ4wxEcs97NEvImfTwSSF1ibyKtjKmCa21XapigZ9QXd5sCdvcvxUYq0Oba12o59MWp+Rfw2lCLrhCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TgGcYoeC; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TgGcYoeC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2x2LUN8mlDZCwDWFunSqHMUaHx1sU9Uixh+ZFMF/GgZV1xUx7gtFU21EN8V3I/mhKSboRAELzT+i8qbLeIGPiJRPNK0HCRnQnYcApinfgHULT1IcNg04S88SFItmwlNYzktggy+wUdz9WpimO4ZIULLfm5YDga0ahYLHo3Z/OB9xFtacUqCAqXG0QDNwsn06x6fk5nDwApsrvJo7lbFa2inJIwO6MrizN+jwe6VCtmMeGxs37Z1mw9Qm1/M1WV5Clwkdbh2sLI5laMM+zPaDfYLZTwr8obC88u9qEJCqr84+tJ2jdjT5g98lcGUnaS2v96TvARts5wZJFZKALSchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fpeZ3s1G7usxLrl1bRQgwb0J757qQc9nMLkt7nKzmc=;
 b=e0tdX8lgr5DwS22+pdRVd27ImJMAmGOe2+zpSsinkKiq0XbRKPnUlUjF59ph59ErSa7mxTu8CfoTcNtfC0IG3lQK40ktxMrBfm11Yq3NMVWuxK0XqqGk40VbOWIYeEy5hhpLUp5x7PcWhn667SbBw8RfbtPrhy2FIXPNiOijKCv/XbPzWs1byY0rQvf6M0urEjnUN5tu0XqSf0dMEY/04fMb4HSq7sAmAh8evfmwg/hbuVoAmOefEX/kYY86wifY+yxYrXfamvsR4KumTso87dir9nTDQOTq0KWcABibyHEt62jFphTRJgt5qd/zMBGmxRke1k1Fk7pLSPxbsEdBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fpeZ3s1G7usxLrl1bRQgwb0J757qQc9nMLkt7nKzmc=;
 b=TgGcYoeCWRsXFHEOGxjDR3rD/9gZHc95cddojKMcWzt8yruougjuA5mPRmb4Qw4bYsRpOgQQl6Sh/QYVvJB5uQxpF7rHyHSziLSM/nxx0EGFeR7ekaq+iYUTH91Z3XK9vRQW6BYqDZ2XfCdzF5ot0YRw5K3Y4xHaaAdFvD0xiFM=
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:40:17 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::b8) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:40:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 07:40:17 -0500
Received: from volcano-f23bhost.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 05:40:16 -0700
From: Manali Shukla <manali.shukla@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <nikunj.dadhania@amd.com>, <Naveen.Rao@amd.com>,
	<ravi.bangoria@amd.com>, <peterz@infradead.org>,
	<dave.hansen@linux.intel.com>, <tglx@kernel.org>
Subject: [RFC PATCH v1] x86/split_lock: Provide KVM helper to log guest bus lock exits
Date: Tue, 24 Mar 2026 12:40:02 +0000
Message-ID: <20260324124002.7670-1-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: b28d14f2-6023-4600-55d3-08de89a280e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3quyRTAWz2KmifVk9gbDTrC2lJzDS3bv46uJwE4ZeEh6se5U3KOonSgiunQfYW0a0G5xbp1Rvyx2IkiqJGyuEB1G02s4dHrqrvDz+bPIPecYdhX6nb/ByNz5OKZSPNlHTFYuALVExLjntx81XIcaxhAd7EHcCtyTTC2HdALAQMs1IQ4fBH88uuaSxJ0MqXPfBrZs7kMyvm3sjosDx04CX8tBykXHCZICmYFDsu4pO2rZTzu0tczyBeNKyOBHX4n6razXp/oMOxsbSnA2irwC9O1crUoNpcX3PIjic9MZFNjT7ikTMPvM5zyMHPTC+whsXBqvYKk0D1USZl/A3bqw4mzd72CD1ke/hngrN4UnKb3fzR659YNib/xtcV/Y0LVawBaCwW8LjffhDov5VBrS5d7PJ2hnJ4G3uQpwcUcMV/sQ/CLJLt3SYzUN/x/clZ2L6QeEimPpF/0c8sdt1bOaYSEP1P1hvNYSLkgVSxln1D3rg0/yCmbUG9Fbn33pJxBJuxQE2cGe0TdUMGdq0X507ogD93/5Qy1/pltiasBufd4qdqHxlp6/J0ojKYEwwkZ69yINYoC0413Y/1XMrEU8qjMpGE6zpuDQ3I1zLa9vP7aC//wInfynJsA4I6Y8wFFVpm+oxFj/OuvkghK5uEWr6k/xmcWXpMVREuCW32JjT/ATFWq4e1lmjHQOMgshYlOR8F/flEd7uleg/XCRtfuuELpgexZyF4zmph+twjd7L30l8rvTYXHE51HeZYTomk9s9KKrQbrkG4h2s19tpauktQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c8hWhlK7jPENcW4PSy4BR9kjxEgSaksDY9OoM32pgHotrsWGS6U+Ice1tfW3N898+xgJEnb0XuJ3JShhZa53HGgJV0expezLB++6iP+br4hvRkzGlxsDqXtsmIH5XacWqj986MUkIqgz02b4/tss3xRyPxcEb/XSfMwKGYVjzPsnE1ooJ9wZXCUUEuOhKD12/Ce2KmGAcJFVU95sVir+h21q4fcHgA+Zfap94fvA5aYd3Mn9PXwnQkp0GpBc7xVeibC+fOfccRYCodLlpIBV5XC1JZTp3a3OAAz7LisY5utYBsDNuKrJbkOT6n/zGxeEzbAP/CCeLSWr8RhLXNj2EQlRWkmv422t5A5zGtWRKTTJxmjuf/eqCG5gAAiqa+wvajbJYZ7HvtkNs0xhNK20kw81/mfoVqbdg5haA87NRt7jjVuFY/X+dp8rx24MaD2v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:40:17.2673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28d14f2-6023-4600-55d3-08de89a280e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818

Bus locks monopolize the memory bus for thousands of cycles, stalling
all CPUs and degrading system performance for every workload on the
system. Cloud providers running multiple VMs need a way to identify
which guest is responsible, so the offending VM can be flagged.

Bus lock VMEXITs on AMD are fault-style, i.e. the vCPU's RIP points to
the offending instruction at the time of the exit. Log guest's linear
RIP and vCPU info to give operators the data needed to attribute the bus
lock to a specific VM and instruction. Keep policy enforcement to
userspace via KVM_EXIT_X86_BUS_LOCK and let userspace implement
throttling or other mitigations.

Reuse current->reported_split_lock to limit the warning to the once per
vCPU thread. Note that, current->reported_split_lock tracks the vCPU
thread, not the individual guest process, i.e. the warning fires once
per vCPU for the lifetime of thread regardless of how many distinct
guest processes trigger bus locks on that vCPU.

----
The intent is purely observational — give hypervisor owners
visibility into which guest is generating bus locks so they can act
accordingly. No policy enforcement is done in the kernel. Suggestions
on the approach are welcome.

Suggested-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/cpu.h     |  2 ++
 arch/x86/kernel/cpu/bus_lock.c | 19 +++++++++++++++++++
 arch/x86/kvm/svm/svm.c         |  1 +
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index ad235dda1ded..4ac5011e10b2 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -29,6 +29,7 @@ unsigned int x86_stepping(unsigned int sig);
 extern void __init sld_setup(struct cpuinfo_x86 *c);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
+extern void handle_guest_bus_lock(unsigned long ip);
 extern void handle_bus_lock(struct pt_regs *regs);
 void split_lock_init(void);
 void bus_lock_init(void);
@@ -44,6 +45,7 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 	return false;
 }
 
+static inline void handle_guest_bus_lock(unsigned long ip) {}
 static inline void handle_bus_lock(struct pt_regs *regs) {}
 static inline void split_lock_init(void) {}
 static inline void bus_lock_init(void) {}
diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index fb166662bc0d..a6d231410535 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -292,6 +292,25 @@ bool handle_guest_split_lock(unsigned long ip)
 }
 EXPORT_SYMBOL_FOR_KVM(handle_guest_split_lock);
 
+void handle_guest_bus_lock(unsigned long ip)
+{
+	/*
+	 * Log bus lock exit when called from KVM exit handlers. Policy
+	 * enforcement is delegated to userspace via KVM_EXIT_X86_BUS_LOCK.
+	 * Let userspace implement throttling or other mitigations.
+	 *
+	 * Only log when split lock detection is active to respect system-wide
+	 * bus lock detection policy. Use the reported_split_lock flag to
+	 * prevent log spam from the same vCPU.
+	 */
+	if (sld_state != sld_off && !current->reported_split_lock) {
+		pr_warn_ratelimited("%s/%d buslock at rip: 0x%lx\n",
+				    current->comm, current->pid, ip);
+		current->reported_split_lock = 1;
+	}
+}
+EXPORT_SYMBOL_FOR_KVM(handle_guest_bus_lock);
+
 void bus_lock_init(void)
 {
 	u64 val;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d98fbc0e58e8..bb8efd877876 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3258,6 +3258,7 @@ static int bus_lock_exit(struct kvm_vcpu *vcpu)
 	vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
 	vcpu->arch.complete_userspace_io = complete_userspace_buslock;
 
+	handle_guest_bus_lock(vcpu->arch.cui_linear_rip);
 	if (is_guest_mode(vcpu))
 		svm->nested.last_bus_lock_rip = vcpu->arch.cui_linear_rip;
 
-- 
2.43.0

