Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8178389119;
	Thu, 12 Mar 2026 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773300436; cv=fail; b=PKULlqlRcSL9j703ZPdwkGpcuUnHEQkpgiGJRCEDY9E/JQZ/wA0/pamb6U/ixPGn2bv3oQ/wi6BITH/uF3lrC7dWGtG5fFL5jZIUWiCkMVki3GWLHl9OeweSOZB63/pnQuCtN8w6sB+M+CKiQM4e7M45AwwlW/HOxO2bS2jgbac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773300436; c=relaxed/simple;
	bh=KO3G8dQXB/X6az3EHJg3tKwI149KyglAVGvesrq12tM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=W4QO10Y/ARpEje5g1L+HWPquQkRHwASRG+0w1dl8W3+lk8vFzgkr4jCUGfotMMxNOgmeRv2s9uJXFYASecrn7KwP+RHhgq/UUJGqWAbSC9Or7HrsytudPT5t4p6ivNi3zVCjgq3//hyivHSmRWPnYc/y/y6xmiOD4+wZKY4TPVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zh1erIlI; arc=fail smtp.client-ip=40.93.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zh1erIlI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wzbot4kIy6UoDiFO2AGmJ1lApMwU4FHRis5JfZuF25SwuRe2FEvtbhX5YiU2hsY5VGbwSo2mIeZz0IOjJMsqSOEJUoeZ356L0a8uRHpeC5ENaP5QINjXI/JupYiJRSN12vjDDjfth6y4JsTf5/yZ56vbH21uBwZVIzLzVaeHK59/adKzKu0oSMtAxXohMOCDHQnfpxSQFnZrvoLEt2vZHzDSiRpazuQjzKUbWx1rE/1kEgIQZitvCUCXOF7pqdS1vrNIlA1rLoKi2/fa5Iv2jfryEwDEy1txYbCNzD7ZnbK5mtVxh8nEliotRHIBG263Uin995vpB7AsCduDgvncVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KO3G8dQXB/X6az3EHJg3tKwI149KyglAVGvesrq12tM=;
 b=UbIy0ywq1hJvgu9eDX/MPo4Nu0a4W/KmcSboy4uHE+IynUmQMDFQ22Sr3+oCFoyw3kVKTNXl0xhLAqgERJmuIEllQkZ3ma5OUjlS+SjrtIMQObkWBg8hihJS4t+5C8Z2zqe8G6y5W1YMgdIiuRikmMg+PHrB+owl+fxKzrK/JRV8Tp6CKgL4ha3hOymmnRfQDOcAaaH4Aa1WkDLRT89Lh1YEWdCaO51n6u2F/yGWvS8CDOGlx5uHkjFI0VRybcajuHBhid4wfIo9sg6DjbdrFVCp3HxFeCA6UJAEPr7kEmo0h9A8fR34QuofHgTTiWdkeaQQ0B0vPGLoK4wAgHgmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO3G8dQXB/X6az3EHJg3tKwI149KyglAVGvesrq12tM=;
 b=Zh1erIlIGzsYUlc+mVPdVQ9BlBP/AbRBkee7pAonx8/sLktHi9VOlVVqf4xKZpOxM6p1ZVq7rhmOd5hwPKzpo/pGrVZzRDihn5WWfakhIxltkE9gdGWUmodsu0zzNB6a1EyzaFTyDdp44j3t1jK+UuzLOvWwHNIT70GN6wpY9gk=
Received: from DM6PR18CA0020.namprd18.prod.outlook.com (2603:10b6:5:15b::33)
 by CH1PR12MB9693.namprd12.prod.outlook.com (2603:10b6:610:2b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 07:27:05 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:15b:cafe::1) by DM6PR18CA0020.outlook.office365.com
 (2603:10b6:5:15b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Thu,
 12 Mar 2026 07:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Thu, 12 Mar 2026 07:27:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 12 Mar
 2026 02:27:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Mar
 2026 02:27:05 -0500
Received: from [172.31.177.76] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Mar 2026 02:27:00 -0500
Message-ID: <2b4ebf7f-d534-4380-a6f4-cb835f90b7bb@amd.com>
Date: Thu, 12 Mar 2026 12:56:54 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
From: "Nikunj A. Dadhania" <nikunj@amd.com>
To: Dave Hansen <dave.hansen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<xin@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <jon.grimm@amd.com>
References: <20260226092349.803491-1-nikunj@amd.com>
 <20260226092349.803491-2-nikunj@amd.com>
 <20260309134640.GOaa7PQJli_C9QATGB@fat_crate.local>
 <cde957ba-3579-4063-9d17-3630e79ea388@intel.com>
 <20260309161516.GAaa7yFMulhdzNQ-pt@fat_crate.local>
 <70644e1d-dd0e-4f0f-81c0-fd095e46e50b@intel.com>
 <7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
 <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
 <81046249-09e2-4c39-8b77-992de916a7ba@amd.com>
Content-Language: en-US
In-Reply-To: <81046249-09e2-4c39-8b77-992de916a7ba@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: nikunj@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CH1PR12MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c296cde-d383-40a8-15ef-08de8008c339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zCKnmMCn+QLy6o6gvS7a1EMitKj3xZ2+/QFV8BK4t+gJN3GTFklvzKZ5lsm1cFe3CR6DPFW9vsxF3+NvWxDqaTgiL8rnCjNZSGj4crbUqihpVaL+6TX9Z0y3RjCZj5iZL2KiSCxPlWPWaXD2km9C8ULu2vCLhM8Ylzw76gDVANELQQik00EY5oSLMGbfqP8iM0Lu27lv7E++iWchX6k+biDlo0KpJEM28dD71P/aCWy/mb2pUPQHLnbP8X8hlVhlSajno6uuJrK8nKD0wI54a9MbyqYfPXPttx1xIWTH7T2qlzWnNawW7ewbqLM2IvlTFEn+MG6JhOp9JQIXHcpFf58H45lFSm/MEHOinHeAXDNiewAe+pp1DnJAU1SVu1d9EXBVcHRR7E7m6XLDcOteYw85ED6DcI7mJwwuaIPY8Zba0UXpugZLtpj6Z+pc2ge2JtGFRyDF3MNbE8NeIyXdvfog2s4cv8yBFpWj0Mq82hrnJ83lEzCcLexxDGll4fZrDPAcZEXqeD0kqJuVTD4+NY+ohv6hLsVRIMFIUjXZLJBtQ+YpyFXmww6bsU8e9E0F36OpP1bs8krAgrH0kCkeoCvSWli8WwcXuPc68Awt9tCJJfkg5RYzM3HqQGgqTt4RauvTOaFswxyFeDnK6w/UlF2ojwq9l1goKm4vfYwoGgx+XU5lmtSVBsmw2zjyje+Gk69XaykXQZl2yfnWsw93/zshxi8brLSYIf2s+jR7kcO2fXD94T+5CjhR2jF/rl+Tm2aQ433mN0z9Z+SHtMLqwQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bssqmHVSPtEmFugDHgfT0YsqDz+mmByIb+hgo+OqlI6OgAejsKmQS2bWPSnocbR/a/qCZhLqaiCzG0Vu38bbpsCQiGhDNIp+q8exIRjzwfHU7kbVgV9L3VCUott6dunypl3EdErXFaT4h0TqDOapxB3fgverPz/wYc+1hLW3DE6gsHLInFZatV/p++7NdJ0aLq4JIaXedXdDuWNrpikIeuTi9gzSKIaQFwQriY1R3pPhqQP40oMv+lmZowmpYtF6q6S+Tqsl9WlUJHTEsjTSVHfGkZQCM23craFPWkh5hytkJzoiM6xDK171SllCtMLQmuj+LtnEcfF9oAoyjTq7t30pcoSSFnPHKT/atJ/HjH0H2SGXdMvRFVYnEsm8/WIfrMWy4YMtoDZeBJDTlR9GHmYR5hxmNVuPF4tO9Z9eVKXBOCq76AagxKcqS0w7J1Gn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 07:27:05.6045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c296cde-d383-40a8-15ef-08de8008c339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9693



On 3/12/2026 12:51 PM, Nikunj A. Dadhania wrote:
> Right, this approach becomes much simpler with the boot_cpu:

s/with/without
