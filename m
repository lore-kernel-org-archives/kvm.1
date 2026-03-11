Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F130ACF2;
	Wed, 11 Mar 2026 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234392; cv=fail; b=J3M1QnqthyTGmeMeVqfMlG733Nq4XpPZ4GBzb5cS4u44tLpFEvKsyd8DHRGT3yAAWMwSdeyYXPHOu+qVf9IhST0mRLt43v2KLCkITRABifPLjGHe91C9UFYLiFeXbbVVNX28y1i/H+/iRFetaoszeCY8m8ah8viiuZmx2yO8bWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234392; c=relaxed/simple;
	bh=Xq9tBR3Qeq1+H/LLxaLjPiZA+BciW8QAljriTrrUAQY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rDLdDTzXtx5NkC77Z1oXj8dgMhrFdaFj7DYSdeVmg2I5z8FRq9BrfLPX8rS5sGzv3xpfL5lH8faDJmJpFcjJXGPu6eKMJeGGcY9E/jzYkY2M9YfjA/zrHxTx6tJLx3FxzJS9IabgXM26RpWsa4vwJdi/jEM82/Pv0O+hXgqI8WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t1lSt6tu; arc=fail smtp.client-ip=52.101.57.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t1lSt6tu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mB6UcnCnn8jvixNe6VdPEDGy2EGEVL/nF0biCMJbCWml/gfGP5UN5uACB+InoSmifU56K8hybRAioKHEXj+j/kpr4q9lRNG9M4x7Y7I7AToBZXnmtQPNjEgU/q+FBSOv8ooLFSHwXZXbLE+jlf0KqtOYgItkW9qrMU09gaCWlNiqHz1H8btjg5ACFwPIM297YnNNl7r1k8paYfU3s89LRM1iTGL9iiDV/o6UQe+YLL0Ij68adFg31KWwsLA7CTCoa29efSQeEpmaxEwzIK9WQMrL/ilkOQXlR7qNidl6mYlPf+WXJW2lbP360wyrFy/ZJ+VLv5Al3xxteLOM82EPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqF8hqsk1aJr3lFs9kLZIWpplMkP7VSZjRWIaLVZKAc=;
 b=sJSjDhR4I9+jQ+hx1VanQ8ev2lRJwFkA63BuhayMJqOKnhexT3YqrC/asn0UJZztbNkBJ5wLs8sYcWKXaWpnTHwx2/YrP4r8Z6hePA4IvityimiRadDg72DLVPGXZrCGqmkhXxLKte0cbBHtouVr0ij1Id3dvQyasOosJ7Z0VF4WJ9CUoce3ToNhRbzLqGpx1tvqVeNOuClFGW2N4dAl9bbevth64s9cjMbeNXrZKsSYneOyqmIXO8cpb6xZcqEOrl/o687SZvLOwdfXwTJRBOjPGbRgOAMmogQu+ThGq2lk2TNNtMPbKJVLrSRhg04vKWa+DV3QRK2ysubVkBQKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqF8hqsk1aJr3lFs9kLZIWpplMkP7VSZjRWIaLVZKAc=;
 b=t1lSt6tuScrBUReCzG7/lJKS1bxKsWjyAWisj8LGsDH1O+BeVBUbRsSsMwJG1NSaic6pUCMHZ0OGENvdRZnSykOkCIt5JyZjxESZ5fqWRF2uLRrHvHHtYiJrG8Gjmd4WHZ+U61UhgqhSiWMTyyx08NVZ/GZ/SwYFHcTMrt8RDxY=
Received: from BL1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:256::30)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 13:06:23 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::ba) by BL1PR13CA0025.outlook.office365.com
 (2603:10b6:208:256::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 13:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 13:06:22 +0000
Received: from gaul.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 08:06:21 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Kim
 Phillips" <kim.phillips@amd.com>
Subject: [PATCH v2 0/3] KVM: SEV: Add support for BTB Isolation
Date: Wed, 11 Mar 2026 08:06:08 -0500
Message-ID: <20260311130611.2201214-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: b19bd280-3181-4772-f824-08de7f6efea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	VtGYETefPUXzZE0vJ2+8rRaEcEuKoqZH8yvc2kTWyZxI8F4EOqGcTOWNYDflehxPXEH46wjDKIdU32HiA1eNvvEWcF6XLL1jUijHMC5EudRci4oH0sE05HBqx/7h9BV+kZD31H6lVR0TNDwoWKfKSLfs5tw7Krr4uHDYFo5hhC0n4wqd41kKY3pOPT+6JdEzxEhUi3Vm1oRhrJz4Ji5p5zq8idiUrI3LBBwmD+dR+CVMrtz7kbfFjyfAHRq0R2ZGoNWbwxNGWDfan8xKXQ6IlPMi5RclMq/FrKw8TNnO6/Iv6uJF92RuMmJcj8CTTID3x35wgP04Uo9eXRPBEWCY2f6+H4NhFtZlJDFTp6BGzVMjA41RCkl1QGIX41KKn8pVgNoV+X68iu0EI/egRdcdH7RCHenGMPJvxpx0tS2Rh8nXPDQcLYgatGpPp8A3+vbokne+syf9CqIg4BDkPC9iSk8fj2Gre3g34fpB3VcpqHc+b61waEJ2y3uTZwAqaZhtjTLHPSDkLkotRaPaMLngg82tJ7poHpL5ZyHs4sPYD3zyjz6qtChcTyFij/zXtymjqHEbK6UwX5qJOQ7pj6JKp5FFy8Z1Z0py0wuhWiHwaQZYTd2LkrBRYwJWLz5k/0PSl3OnlI6tFbEhy/ttFLZJkuZiTRYXiPKhStaLamlP/j5m8QDHwiioP7C40f5uaW7nDPkjztZqUlNJzEk/oPxjNt94bNjcYQ9PZe+n3yNYHjY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YIxwTvjOGzyDtQ/qPTjl31qYQh5OfcYQhoUbUVLYyRaHcsg3M5idWH0Q1zJvb2peb7khEKh0lzWIk9XQmxZRhICLscEaz0/ETPXXXNSWdBAT4ALH/6CdF2HNBKfVrD9v/oYCKdQF1vJmL4D8epIfEZBgS6e6E0xQTxR4BQCBieAh2KjJ8qftHARYBBiagWXdot+aoKHmP4HpDuYaqzHnX+vI5HCO9wne/ozqyPesh7tcIJF20YF7vrv8kL8wFXdDFzOFABleFEoY9GvnvGSV4beZdN8KwRYYNmGfmDNVp6hczov4Vc7uJPLozioXCuudGLRi5UmDeJbfMLBreEzLMSJQ/BEP2yqcbIeerxaOeQx3MILIwuzkj7tvjZCKzC5XvPxmC7RLdNoI3WSaHF9E7iW2GA18OpBY4ebiqgFa2zqtf6bEDGC6/z9D5pJL/MJ+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 13:06:22.8011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b19bd280-3181-4772-f824-08de7f6efea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606

This feature ensures SNP guest Branch Target Buffers (BTBs) are not
affected by context outside that guest.

The first patch fixes a longstanding bug where users weren't able
to force Automatic IBRS on SNP enabled machines using spectre_v2=eibrs.

The second patch fixes another longstanding bug where users couldn't
select legacy / toggling SPEC_CTRL[IBRS] on AMD systems.  Users of
the BTB Isolation feature may use IBRS to mitigate possible
performance degradation caused by BTB Isolation.

The third patch adds support for the feature by adding it to the
supported features bitmask.

Based on tip/master, currently 7726ce228780.
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

This series also available here:

https://github.com/AMDESE/linux/tree/btb-isol-latest

Advance qemu bits (to add btb-isol=on/off switch) available here:

https://github.com/AMDESE/qemu/tree/btb-isol-latest

Qemu bits will be posted upstream once kernel bits are merged.
They depend on Naveen Rao's "target/i386: SEV: Add support for
enabling VMSA SEV features":

https://lore.kernel.org/qemu-devel/cover.1761648149.git.naveen@kernel.org/

v2:
 - Patch 1/3:
   - Address Dave Hansen's comment to adhere to using the IBRS_ENHANCED
     Intel feature flag also for AutoIBRS.

v1:
 https://lore.kernel.org/kvm/20260224180157.725159-1-kim.phillips@amd.com/

Kim Phillips (3):
  cpu/bugs: Allow forcing Automatic IBRS with SNP enabled using
    spectre_v2=eibrs
  cpu/bugs: Allow spectre_v2=ibrs on x86 vendors other than Intel
  KVM: SEV: Add support for SNP BTB Isolation

 arch/x86/include/asm/svm.h   |  1 +
 arch/x86/kernel/cpu/bugs.c   | 19 +++++++++++--------
 arch/x86/kernel/cpu/common.c |  6 +-----
 arch/x86/kvm/svm/sev.c       |  3 +++
 4 files changed, 16 insertions(+), 13 deletions(-)


base-commit: 7726ce2287804e70b2bf2fc00f104530b603d3f3
-- 
2.43.0

