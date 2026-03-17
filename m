Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53F37B018;
	Tue, 17 Mar 2026 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773720792; cv=fail; b=EczILjlcgWggzBevxaCGFMpwKpyjiua9gTJ43qZ8ee5Pho8IaYli/2nl9sa4oLGaFxJ9d5iRFYFNScMk21PEm0OBlEeaxGkoLVr0v7zf4rL6hQTQCSTl9c9p8GDlsZiMaBIFW4LmgZkkObj4tKXe3/PA6BMGN9jwjGZB7FFgSzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773720792; c=relaxed/simple;
	bh=HsDtuQpVtzV40w6oi/7LC9zGEcvrlMoW3qSujwB3eak=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cFAA1XVzK3te5zK9rJfD6m4pNy7t/8F2JxzPL/fyB+amXWEVKeNKRAOa3W3M3+Rc5ehR1lOtOLmi/7JMxZ7qC4nNcPwOPX7wDn8CJ2PzjYroDHcpqwE4Cz/i8aLktKKOTdo3m49RkHK+yOtW/JC5OdazetlkXuTVsZXzTeMU4FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c9aPx6Zc; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c9aPx6Zc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4kGjYiRv6J1PAmpfRbFfhtaM2+T7e2CzJ5D2HwXdoFZdvRTt+WW6oR9Rju5kxgcgyw8Nss3JBkuz1f2CZF/nFdRkkg2BnaGBPrJAWPJ8LP26UmN44FEiL+xu0AX0k1lmktm8+ztlGfL4l0/wbb+PJP9+jwqeLimUPa3UHQ4ynszAA/SBR/nvxYVdxZizHDPSDd4qcRLh+EN6lliVnqLQPs+eCglV84x7kN1PEiIV/CkefhfwywXq3J8rffilJ9flK/W4XvfXgzF3TTeeGyMXYYNSbi4q6pGSQib62/0gX8FZviYWSlhSXpue3OpgNXmbk+YIuosqBMrurMX+PaRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lWoDdabWpAcCxwa1uM+V7Cl+SZyC/QM0mDZC/lM2uA=;
 b=rRWT0V35Bl3uLOgzuFp7wihevY71/h5CV6JgLeL2LNPRxJpqAlkSPydSmrxCKmRy+0MjqUU4KZEKWCZD1FGEf2x8wKX3vnoChyZNVHwgSd7lu4ZhY2Spgo0th7co0Wh8zpt2ls6FAOV8Wk0tVkhzPsA/qKCKyisiBcBtQgEA/JAbzl+RE5L0refeGHkVIJWAxuwbiAa1eQAbLmU5j2DwKUsMm0K+d5wJ8L0ZHzXUUIn3vOwXEdZZjTP43OA9mJwGAOSxzDNHt60blEkycn0GWjdxawUuWv51VDpoe4obwLLqzpO01xYlnxwLHm30FxJYj1lRw9F85nj22408Sri3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lWoDdabWpAcCxwa1uM+V7Cl+SZyC/QM0mDZC/lM2uA=;
 b=c9aPx6ZcM4c/QO9F4UjYRlde5AZErWyYZXhysYD5BLM69rni5QSJ+WHU19k9UlpW2OV2e05odx+JuygI+rC6l4xSEO0nNKixEYCJCIayraDAIfHgSkcvRiamzM6jbE64PFHcJr+nl0sTSTylFpI/zQFUALdWBHFXMIV+U6SmvA0=
Received: from SN7PR04CA0009.namprd04.prod.outlook.com (2603:10b6:806:f2::14)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 04:13:05 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::7c) by SN7PR04CA0009.outlook.office365.com
 (2603:10b6:806:f2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 04:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 04:13:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 23:13:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 21:13:03 -0700
Received: from [10.136.46.44] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 23:12:59 -0500
Message-ID: <2b33bf8e-5f19-46c7-b1eb-89fcf74d74f8@amd.com>
Date: Tue, 17 Mar 2026 09:42:58 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
To: Dave Hansen <dave.hansen@intel.com>, "Chang S. Bae"
	<chang.seok.bae@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Borislav
 Petkov" <bp@alien8.de>
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
 <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
 <ab5bf7bb-6511-49dc-a65d-86911e0f7091@intel.com>
 <c13736a1-3151-476b-a91c-035383d2a29e@intel.com>
 <541cddbb-22b3-4865-a374-49ba3ba48a5e@intel.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <541cddbb-22b3-4865-a374-49ba3ba48a5e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f875bf-0df5-4725-5547-08de83db7d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	3h6h40klIFZE80s/oUkE/kcz08B0bjGxk8w5kDkXO7nqZBU/bkAncvdrPHsp8qIv0yfbW97xItvwqI93pvCwXYt9o/qhWQEv+LbgkARFaqTO/FKLFz7JCmiX4ZxurA72z7KAU2pegNQHcjsmCgsfpzl9IUucTewgOVRsE4vEv3jBAtDK7omEietTLRi/NtyzKKYET7BWq9AmC/8wLhoS1XidPCyvTj3BeGPBvIMGUnq9ijgAwX+i2k5UgLcT1iuX9x88ZJ2S3g33Zw2vPJzEF3MtwgrF+vUj71svZLNdeZ3lBj5coXtm9YncNysl/lVRxTXAMD3Bihh2q5XiMRPthq0JX0m1cQjLGjIAcBTwoAjXTMZGsMIdAD9tsoNBaMbEaE4DWwXOHCQCUadw8HQTyzzcqUaVlOb0uyHzUyJQQXMN5h655WhlOyiHG7wZ4FRA3jkCWy/MpbGzCS9TqVb6EDjVv8cmt9+xZseRgbA7fPqwZIj89u4Ri/hHJBzxCiC6UazMiyV/a1QoeFQO9Lg61RUFYoHJcj1AgXb/tAGr7YKtyuSW1FR+kiRbm2We81ty9x6nKlhXN+cksnkLsI1se9XsJHhskWO6Fc95fGmI52kgz1HFteb8hVFtNWp3lXc/YNhMaClpvmKTxRShSpDXiIJ1Xyb94FNTok0cqu9N+qyDabNdsKyY37opDhIta0mPWaVMFjm/jHMevieEKhrK5dAnaCvcB1KuY0rPZ855LuG/DiTGZpn4HdMwoko4DX3GWzxSXsHJqG7lNykutsUfXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(56012099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aa9vWhc3bzdYF27rA2bgUJffpOEAejUQurUfqCdyWvRiKCUdjGfgnviHJvHhVPm4VXlWCaelwl0yso+iUyI79b8VCnhftaUgN0o+ZsctukEZipFb/EzE9yBmP+K835beXDFttcCQSLut+O+/mItUBGarf6X0a/mJEKq7jBeKFay/D5KJtiUaEVDPoVAuM+fgO3juDf9pCETqC1mNhSkqj8x7T0+xrpCwQ3vg8/1Tbz9898/yHg+wyn0mAWag4v62ZEdZLiXLx2Nbw2Mim5gX4IVbrAhtBBfjyojModQVhc8q9ntVZhuAGyiynHHCatZF0Zkv7zp+iUs0ivFVNVTFZ7YDGDLPWpVgHXb2aGeJsChzKoo5o/WRkxzrLz3oAaUtq8PzwuT3IcxQBCmWopwiNOb14Cz/IhQ/1joJvjnNeHI4zFQVD0bR7OUqTgDBEerL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 04:13:05.5002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f875bf-0df5-4725-5547-08de83db7d40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090



On 3/17/2026 3:13 AM, Dave Hansen wrote: 
> Either we change how alternatives patching works, we use some other
> exception code, or we try and get CR4.FSGSBASE established as early as
> possible on the secondaries.

Right, I moved FSGSBASE enablement to cpu_init_exception_handling() to 
establish it early:

https://lore.kernel.org/all/1439b4f4-ff0c-4b6a-ac86-5c0da2d26cf5@amd.com

This:
1) Enables FSGSBASE early for secondary CPUs before any exceptions occur
2) Consolidates initialization for both boot and secondary CPUs in one place
3) Eliminates the double-enable issue as in cr4_init()/identify_cpu()

Does this approach look good to you?

Regards,
Nikunj
