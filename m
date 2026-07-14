Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB076350285
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023861; cv=fail; b=WiDkfEsFpGcv7rgVpoQrYIDPEMAZipbRGXGXM4/B+1pT2tbf1WGpPmXpM6HiYhU5an6exFZW0hRBH8ckob8ptT7NZQqSXcVeanCmbE1ziUM7FZdByhfUyVKS6lQ33k0qkz3ih78q1k5Mz+2y+8AP4ok0VWv1hAtGjG1kMMTUpfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023861; c=relaxed/simple;
	bh=F7/O+3ga68GRWAeu6g1ZIHWdbvaTfGzP4iCpxD5p+GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CVs6CKv98O6HUBGgRaT8J3dDNbYe+HP0KqwYNRnxUbxvwK2oZKl3h7yaFgOb3+UbyrUddiYu5rjUO2ttE4pmxSHe9efoCe4/5Q2dhaYfFUvstqxYGBJu8GWEf5oaXegIVZRMf6tFWVUWmSOMCQPgmMneMYAOS9VzgUegRDTehaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0qTgjoZe; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0qTgjoZe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogubCXpwh93b5l1FVay64v0x2vPfwCUyPn/Rj+ppdDkcaHCHjoYMGknqe2UmrQKlky6FD59aw4GZzH9Rn8b1suuxolE1Qno6UEbZJ4KtChh8rAaebGgKnt7uQJShPuDsl6iTtpqvlqXVyddB6V6PQ/k/jzqLWe+hqqitDo8HJX14Lton+4caVfoWC9v0Ps4s/A9oK9G8K4mXXCXXHxLLk06IDR/oateyDjc97OF6l+Uda5xd6cghmfPnCjXaplHlVwQ3uYyoafyxtAvOr8tYksXE8bkNGpSPCIR0two7lxPjht5bfb/AC3qVi21lsTihXQuJuBxcTXZFwO9aBcl8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IxCaCTOY4ScMUSMh9FJ/mQKjTXCveR76V9GQ10sZc4=;
 b=kptE8966GfrQodP1mzPEV5Wt2LkyBVoV+RHjOSuXiEV0p4wIwFX4B7hsbp3ARakd8mbxba0YEK6Z0cf5mshJUrFZ4KlBLVHCctE68slFfYaJnLOw9zw7IWUnXpItTFho8UEsqDsgEZpUrIZaULNqgHsGCanMFirLGXH/qJp43zAGCTwhLTejMMorG40OoS8SWeS5xEjfgaohdrzl4BAYhU0nxRPQ0uy9RL8voQsraoTjDGno/onwknMeIf6L3HpiJcmRs1ptPMHzSC5VAbtof7gc2JN3JKx+TETcrSiNU4UMTJVONth3YphO2I4ka3Jc6x2IF4fc6IUdTqU9EI1MYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IxCaCTOY4ScMUSMh9FJ/mQKjTXCveR76V9GQ10sZc4=;
 b=0qTgjoZeir4FzdaZ2xCNNi40us3gZXJNM6Gr1UmCLk1P3DBR4OGRef7njSt9BPAuDrSWp3dSDTQOaR5rpZw0zGpCxnk0cI9oSdxQ7d8yFn1Q7m4KbRfmnwcutQaY8zH3ufp0/jxFP8DP5EOTNRV4hBsQ0LQTObpBc9tmIqFC2Bg=
Received: from PH8P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::20)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 10:10:56 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:346:cafe::6b) by PH8P221CA0045.outlook.office365.com
 (2603:10b6:510:346::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 10:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 10:10:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 05:10:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 05:02:42 -0500
Received: from [10.136.33.156] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 14 Jul 2026 05:02:38 -0500
Message-ID: <1532d3dd-3165-4209-81c8-c09c7049f537@amd.com>
Date: Tue, 14 Jul 2026 15:32:37 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] KVM: nSVM: Sanitize nested DR6 using
 kvm_dr6_fixed()
To: Shivansh Dhiman <shivansh.dhiman@amd.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <tglx@linutronix.de>, <mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry.ahmed@linux.dev>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-4-shivansh.dhiman@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260709082953.69434-4-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc06df4-aad6-4aed-fdea-08dee19031b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DxNDc5fSnR4mxG9/It3pIU5zriEafIX4eEb6TyAaLUK1xxdK55r82D1XIGsfEYBBr60GRPkVDH/3LJl33qpcw269b4ryX46ocSTNAw6KlT9sUSBg6FSjWFfODidiVCzPDwdC6/+oew141Ek35yKRvDIVYme51yH8JbnzoGyC5GYnG6PxrTIpW8rBKYaC3ZKif5MbajNvyGmw0gG+/TEiCUR63iy2vXdKgzFk2a9upsjyZYQGZlNDBUvuGKwXPgwk4o1oLHkG0G6n0hN1EHqynwvPAPn1Bjc8yhWBst6DebKFgVMQvMdA6FyntekpEITvn9whjlVC2EBW0NTwlS4Kr7Zj/4ktEokiveaEuPsYU+kUz5znoSUK17Cz8qdzW1z5hHs0s5I5uolQ2W0FpmJ8CpwKiY9O2ex7c7m5RR6/nf/LXQ5Wt3G0VT18E1u8md1R2hBeC1dQRFJnWx1JCji57NoLTLweGubVib8fTBlamJhSVYGSZgyhN9N6h0gonIszN4xqr6qfp4sgJB7fZA38Fy4dL9U0VnEadEksXZeBMoJamXyzZvruRJLer7NCKcnqDH0Dz6Do438HS7YMTesp5BVrLccKqfvjO8MYoESt3GNJch3Md1NljyUm/bNK5w+sVsrjDKv+RpXQlZtUK0+/5lXUSD2LZ+SECa06ecYugG5FBVcgBUwjwgDEnYq+lA+Qb69P06JNAnEGdEyJvl4Lxw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zb1fSSJ0TBKpczPmcQiQHIkg3OWBe7XafrSvwiVeFk3JjyTKQ5JzX+PdHPaPbh0j3NOvVg8RYBGVAzsNWQHt0lQWc2FtnqotOmGWKV+k+Z6kQ61UvAZwA9VznQfyXfM+dFhCPtkgf0E5MH6/mrXg9LI0ARQbh3wgE9QUQgaq88iFBJ2K0reK2BFrzw9ID5QXKtYHFxjJjcJhy+zp+SjaZ1FTZqY8B66qUAS1d+tJABqNwGiGku0bv1iRJmyGCIxpF27y7GX8R2Eq+TE46OwWordlCCpTpDsARZD/yXZjSIoUtsMojGTj0fsYR4cM+aK6sYcxqsa8JJ//5uO1FujCQ8VPUtb7ph/Rxq3h8AIwvJf4uLh2TdcGmayrLgAznQ3w/pPqiuaA+bjkRYSMEIKUrEVhO/nRj2S2KsWheuIc/6b1jk1JQV3VsZSz2WPIG6Ma
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 10:10:55.7982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc06df4-aad6-4aed-fdea-08dee19031b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823



On 7/9/2026 1:59 PM, Shivansh Dhiman wrote:
> When preparing vmcb02 for nested VMRUN, KVM ORs DR6_ACTIVE_LOW into the
> guest DR6 to force the fixed bits to 1. DR6_ACTIVE_LOW forces bit 11
> (DR6_BUS_LOCK) to 1 unconditionally.

It would help to state what breaks as a result when forcing DR6_BUS_LOCK
to 1 unconditionally. 

> 
> Use kvm_dr6_fixed() instead, which forces DR6_RTM and DR6_BUS_LOCK based on
> the guest's CPUID. DR6_RTM is a reserved bit on AMD and is thus always set
> to 1. DR6_BUS_LOCK is left writable once the guest supports Bus Lock
> Detect.
> 
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>

Regards
Nikunj

