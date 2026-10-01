Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7799531612;
	Thu,  1 Oct 2026 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867528; cv=fail; b=kBu10HorqO7qMS4H42eonUYnnvRgEODtMekBaG7If7Iot9MhFExoKgd9IujCxqROYEJusG4AZDqUi2vgGlgrjAXlfLDRziWhxrM0wqPbp7Av6zxY4KMGvbrIqGnrceshQ2yAbdx7FvaQeooWQB1sAAchhQ78p8C+MJhFZtemhjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867528; c=relaxed/simple;
	bh=3jszYyz/+wjPHXhbyXnhSbdKG1yIOcuyFWPRvgmgXWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9j3fqplh6NC5ZZUjxhvFHnsbPMLlhkUHn0T7y+xz7B6r524a7tUipUelsIUPNxvQL8YNWjDEoSti2qPbSVjLZ5ROZUaDdt23LHgx+XTRuSQx5BVkwJoduhrqyzmgFNe2KGMQPP+exNSS6jbICE5k5mwM/YyZYhCjP7B0kBDMx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e/W6ifUN; arc=fail smtp.client-ip=52.101.56.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e/W6ifUN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlYxfxhIhpc2piiiPNs9uAQxbF5AQqdl3QKVcc6Xz2i6M5ZoFeuVXhvjogfEzxkp//91tq75VED8b8h2Q9vEtFdd8lgjZe6jWXMAjpO98u+pvIToGTxiRmzDho+N9sirKmMSOUwsFF344yPS3HC6XJ7V4LnV4AxeUs4rT+jmkR0loeKqLa5h6Wx0uqBWOqiQCRImlIbMJMi857iZ/+d0op2TDDN/NcZ6F4IjP3GYm4JsoQEKHUyA0Walgk0TY6ahBhzaBOQEr4LhTaknV/cajVOgWaJpc3ns8lSXtB9MKUDVkPe6IS7a6cqW9Keffaru409Q6+kzgprfrRUdxi/Q2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/p0s/e3aokOQUY1YRjVMBuFtuyLrLIa5xBHzOXawss=;
 b=VVjyyyY33cfmoQ2QkQ6wQ3ZQ20DfKzUlPHlsodyBQzaM8chDdrt0ku4jkq/eRRTjSRaSMSMDWscQwKHn2xRaYHC+G2XgD6Sa7Sphoxcd90X0/BHkL2mF1HOBGjmEwImQswaHvW7yBB5LSmDnVA+R2p7zxiaWpRpZmNPl5Jj3McoApH+S0bzFPf8W5kfNa+HTo+F5p7mcvhnEQyZCdlV61hoXuu+iXGWrEqo3ZcfeYzUiI2eomQqXTZcR4ZHIFP7BSUs37bdLyuIBYMUM8S08reS07gyBm5oe+nZAxnhC7EiXKj4iHANKlLw+ycOG64OIMXABt7MCU+MqSDPKIaRlMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/p0s/e3aokOQUY1YRjVMBuFtuyLrLIa5xBHzOXawss=;
 b=e/W6ifUNzWVL5TdeJ3qnW8TeThTvZFmAcEkt6LQFBf40BJvl+VrfMM9+YffpH2LQrYriSXQVuQl3B85mf0Bd+KP6pRahX2nRH6PbOqEWijYCQFD5Y/sop2GmTYMG48Ax0MRDeH3s8WeS+4xIWNM5J//xpIElbo88NZMIWD8i1W8=
Received: from BL0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:91::17)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 15:12:00 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::28) by BL0PR05CA0007.outlook.office365.com
 (2603:10b6:208:91::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 15:12:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:11:59 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:11:57 -0500
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <tglx@kernel.org>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <fenghuay@nvidia.com>,
	<kas@kernel.org>, <rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>,
	<rppt@kernel.org>, <dapeng1.mi@linux.intel.com>, <elver@google.com>,
	<enelsonmoore@gmail.com>, <jlayton@kernel.org>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <seanjc@google.com>, <ewanhai-oc@zhaoxin.com>,
	<binbin.wu@linux.intel.com>, <peterz@infradead.org>, <ashish.kalra@amd.com>,
	<superm1@kernel.org>, <chang.seok.bae@intel.com>,
	<prathyushi.nangia@amd.com>, <kim.phillips@amd.com>,
	<ackerleytng@google.com>, <elena.reshetova@intel.com>, <naveen@kernel.org>,
	<darwi@linutronix.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
Subject: [PATCH v6 08/18] x86/resctrl: Register RESCTRL_GLOBAL_ENABLE_PER_CPU when PLZA is available
Date: Thu, 1 Oct 2026 10:10:31 -0500
Message-ID: <05717f15f11f9e11f6b2a2737f4ed2f01fd9733b.1790867441.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790867441.git.babu.moger@amd.com>
References: <cover.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: a66933e6-2dfe-4c5f-a715-08df1fce5766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|23010399003|36860700016|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Iej4+NapjIoAh6domzVGpVt4FmjiWI7smVaPU5GlRfDVPfrqR84i4B6nxVQI8nXyT+XwgZbSOQ0XlmfnxZ8dIGfSCChMVK8u8eY+jB+I4nIMw9EJ0w+UBDtmE3rrgQ7lB0DPPgm2Ec8w36sgKk3SW685rAbysFZr3ZvkbaKPebX7SLW1pAxNd9410j4uI4ysrken+3c7yxjNNl2ReDXFmZpmgM9TMgqzb2U9VkraOumPThCPAVC7kkzwmfRUg1mR5R1iiF0++QD0yDMFBpjAvne8oJpBnaFP7uqzzQTooBTYFSXDM6AimM7bHvwOY7cLPW3wkVJm5Vf+KR9YotYtOLC+GWBEVBjPsEN+soIIPpx8OP7EhIj2Pej7KLkNdnpN6Bexn+nxwXvEx44NLXh6IvTP+5mQIrlrlgyOeRT2qhFrUk84VZecauTLXVFWdHCFswJcPtoNuU1Jd7IQBXneDbVHQKCtFLMbY+JBK68ObNt+kwUk6P3tmClbUzPxztwYyumntRXh0zKOUhoONsGBMvl17nsH1hLAvVmTJGdYGyg9TBLmPV6+P/0QRa0/c0oknVGhqDR8nkJR9EI4apUuQrdb6HoB2TFJHKdOw1cQKa3kDH3Uh5eahja+VoRnTSaxgMUjE6qQB6UEO3lvfg1WLTfRlX2vLFf08b4cgA5OqCQ8CBH5509+44eaTD3GZ+Zf8QqYA5yTpBPLwskgSAZN1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kSF8i1ydSFQzRJlsCUzwLzu8DJdh9vFVoJDlnsttzz19Ovc7LlgYKeAoiPNIgdY08HxnTl71mzYMc2mvb68aGjK2zi7Tvjb6LLkQrQ5ppp0k87OSJ+mYwgWxbX69OOyjVdfBWP2DYI3I0RWPmtO6N2jC4SThpbu0SAzypD7Yeu9pgfP1MUkDhmKEZOZSUyK/EiUK6KUyGB0FYY9ApvTxN9BuKIQmPN5OwH0UGX3au+Sn6k98uf9xyMltXQArsBHdPP9yXib0ut/ithlsEeMx49PeamUr94OblTl3PUI3d0Y2KPS0D+H8F2ez/S0hn7Cjl+BshfstDtvoE9zn3k5EM9VwxsB/QXQksFln/QF6+fNEsn+rPY+R6NMrF9xKHX/7/3I3ZVoobES9QGg1D088K0IACXCI8TIe4pm0GrSEobayVO0FVcLftTfuxWR7vOn0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:11:59.9539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a66933e6-2dfe-4c5f-a715-08df1fce5766
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890

PLZA (Privilege Level Zero Association) provides the global per-CPU kernel
mode, RESCTRL_GLOBAL_ENABLE_PER_CPU, allowing kernel work to use allocation
and monitoring associations that differ from user tasks.

Add x86 support for this kernel mode and make it available through the
resctrl kernel-mode infrastructure.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Use RESCTRL_GLOBAL_ENABLE_PER_CPU.
    Rewrite changelog (not a bugfix).

v5: Update the patch to adapt new data structure and resctrl_set_kmode_support()
    changes.

v4: New patch to set the supported features during arch init.
---
 arch/x86/kernel/cpu/resctrl/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4ca8bedeb995..fc59d66f77de 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -1021,6 +1021,10 @@ static __init bool get_rdt_resources(void)
 	rdt_alloc_capable = get_rdt_alloc_resources();
 	rdt_mon_capable = get_rdt_mon_resources();
 
+	if (rdt_cpu_has(X86_FEATURE_PLZA) &&
+	    (rdt_alloc_capable || rdt_mon_capable))
+		resctrl_set_kmode_support(RESCTRL_GLOBAL_ENABLE_PER_CPU);
+
 	return (rdt_mon_capable || rdt_alloc_capable);
 }
 
-- 
2.43.0

