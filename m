Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794775448;
	b=sGHY6/UzG6T0w+liqE6iDXq83MQHBsOLZJppaaMUugmJ3Z04Gx5b9gPbsvWPHiwaifWu
	 I1VRqs71h3GuZKATiBwoFIUK0LAH+GPW1fgM/ZQQEw1/RG2y8fS9O7rFuuYK7cdp8g931
	 SN0dp9gKD0PsvN99Xi8xS5Wk4u1SoasQtlS9Rt4SiUMO1xXYWbyg/EpQjoDhAjsktoLfz
	 odtb3GoBxaorEfHXaqJFLx0W0N5ij0RCmxKx2Z3w0xfGsRBLqXm7KnLQvQS8Nk3W2ZfbB
	 boZhRGkhDEGB0drTv47riTT+mS/N7kqX66JYCnzZyM/PeAaBMJly1QV41vfF6UUIBIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775448;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TtiSOYQpTfWjjsDsF1zSvxSAoFO2srp3DLSB8hB/LOQ=;
	b=RjzPZVhzNgO7ZKtnlC9lrK+tSToSH4fe63asR2kGmPYXGUAbLNQp57g0zAgck5JYwOHE
	 IWYRPPG/WCOlKMnYNlejvRJkVcDkKiX6eDv5q442z23Inq3s7mT/dn8s+9mweHBkoMmhc
	 HQXxUdeSXcLfRnETQeOCgTbWb82VaPDNcuLJDi3DKBHriciY8IuM+w0YyboqiC1uEPVpY
	 zShBxMOXEmwRGkxAVYtEfmRxb/Lq3oWwC56HDgwfUTun/axPtOXxN2TvQS1Ku3PyNOJ05
	 WF/GWdq1Yf9ogFJw83t1oQNUasixhrXeryDj4rQpuQmKQLPP0gPTwdcODSTmZIUbLLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S3brw4KI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.67
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA5606A31F
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 20:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFBA5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S3brw4KI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGnRj39fpnjbavrnHL24sq9RA0IKV9yCyAudM4eDwJtJeVBMi/TKkyu/reQj0+sDguqukgbybOlrdC5YoH2kBX6mvRdpiBqoGLr3H3xT2iDTfwJG0N9i42QcubXssD9WjkAY97GBEE0z9pgXRqK0XWgKLr4CgSiSY1syw9IRjBDsGg41jCgHkJkgdxdrtNfFOWLmHiqzPCyCPn0UIRRdSGNsrjvuXnbICY9ryRzmGDH5YZZqMESVxV63uiEhJ9lS+veqVtVWAPK34iI/Es1zUXzXC4npZEjqFvUCb2S7BYaQLkkeUHSrvpyIj6JB/9fUwsxwmroMaBV7gKaHO94y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtiSOYQpTfWjjsDsF1zSvxSAoFO2srp3DLSB8hB/LOQ=;
 b=ROkgSE8jKKdb1pudQvURfSwyPeGY9lFs7GB3Ucogn31yhep6lQwKd687QdzNo3Qg3AvrB9MJJkKuctkbOsEwlHnLKnoFfVhc/UkZQgSPE0sF1s8lxj4mDhM9YW5ja6PVzw0Ni702Q+Ljvj+gxttsm3JWAhRES9PzoEgLi/y+b8CgueoXnF025MQMRJnC1+t15ThHYFKFEchVEQRslP0B7SYR+/wIewjkQhNZXGdurORWRIbf9CVnoYxMYb567cOmTt/hNbm1CZWOqeD7nOvijB1BvJVwWqeu2GScZP/FU/kvYhZPBB14qMXAwk96T6taPOG7LcEemVtAfl1vrUUN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtiSOYQpTfWjjsDsF1zSvxSAoFO2srp3DLSB8hB/LOQ=;
 b=S3brw4KI6oXILwXxFJwqughrSUOl7/AKrP0hRkiHhLhUa91paLZWooUz1zBizpKfbMhkalJzdNo83s8UebpD+uLD+BgzTxdA3U4XIVL20vYBI2p3/t/mZnmJ0VGuz0DjZ2nbZ7zUsew96KnARFjet/t8Po0o1kvSl0ma0j9MSUA=
Received: from BL1PR13CA0297.namprd13.prod.outlook.com (2603:10b6:208:2bc::32)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 20:44:00 +0000
Received: from IA0PEPF00000043.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::5e) by BL1PR13CA0297.outlook.office365.com
 (2603:10b6:208:2bc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Sun, 15
 Nov 2026 20:44:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000043.mail.protection.outlook.com (10.167.249.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 20:44:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 14:43:59 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 14:43:59 -0600
Received: from [192.168.29.217] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 14:43:56 -0600
Message-ID: <0552ca9c-98bc-42b5-855f-3fe6245a68d1@amd.com>
Date: Mon, 16 Nov 2026 02:13:54 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: SVM: Clear VMCB save area instead of entire VMCB
 on shutdown intercept
To: Sean Christopherson <seanjc@google.com>, <pbonzini@redhat.com>,
	<mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <thomas.lendacky@amd.com>,
	<nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20261008062643.1183018-1-shivansh.dhiman@amd.com>
 <179441837420.82293.15548104733852212417.b4-ty@b4>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <179441837420.82293.15548104733852212417.b4-ty@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000043:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 28319020-7bac-415e-40bc-08df43592d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|4143699003|56012099006|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261009223027099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	GWb3FbWz0sl+Gb0svz8X1Qvs/tbU4fwNNuKn8jsSrfmx2aLc7FvWRxg8EV2Dggy1wupNp9N4ItmCyBWRZEEDjo5UA+8Z39r0IcLaCUriARIMIoeL9oXlsbJykXz1dApUMMPwxjkEwTcODTl3QuLHxW3Ymj8ToEC+y/sKquqHqkEv+Pxpm00Zrsdx4PS99FjsrqSnLFYi1IbLoU+57kaEeSVH80rZ+obVdr/Fs3FPQm5OM+3aps7uNGVFAXnGO0NKFbIhcXd4OpsP7DU5eUMSouXwWXlQqmupXw/FVyNTJcEt5iA8/AaxKkxxs8/4tr2UQAjIy60A9jSegml29GliTbwZ98RtNFPFGNGHqwgPlpOqKsCkTb4DHRZL7UepnMnmUdMRww+YicHH5WzV08xpa8YtnzypNh/Lq9L6WmrBHjRCp7Bv7bPQ4AovtR13psL8CA2w/MY0NBrKLgjwo3f+QQkyNfz01f441ZgEf99pwCe6/BIgNd4w99cuh8rYtkMil370iseOV3IvI5ojIXrYRAMzR51Qmt35H5YkXRzeuj9GMlp+6br1kN510VIdh6SQCiSiXynNhTsPPe2KfQ3kmnw0gGl8rvDIcML2jPPhe9iFDfBZ5+wIhcfMuyoraaZwAV+nkQvoa30ef3jw+99GxBqUKKtjCHBCYoSURFhAwW0Aa3n3Qbnw2lK9GoOV74NycPeZ4fPdcWbwaOwT8E+boQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261009223027099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z2ebbdzvy10q86cUaSVMN0I3XvJbTAymYtAukYLt+nB0NGGjAuzwu0NULfhXcVj9Z8tuupLW6ILdBlPhY3M7hYNiDcBEY0jXUQhUwOTyK+m1DP2vHXXxB5q888pZo/GdZC0j7EBlyjA0HGCxzBAitqCkUWGLmSdecP75IuivGaZH3W3/aLt5R4oQcV8ideLIevshuQ/27kuAPkLDoa+CU8kGLMX+JAWop/mWMRhnxRXW7LKRA4ZLZT4ua05h+2U8+DeilYtvqvYeTc+GaB52G7hXwoMNg6G3E4Ed6Aohxe1stryLjs9WBMtslrzlYTTIOkkt+eEvM6oAkEaw0dOeuhhHIcFCST4yD7EDRgV6nTCDbw+EsHAw4J7e0bIhtX9v2pPByHLvsjvzpPKHb0OwPfPY7tRaghzMFbqUt32whYzbTEAgr6V/FKuUDMmmgwsX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 20:44:00.1632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28319020-7bac-415e-40bc-08df43592d5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000043.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135



On 13-11-26 19:16, Sean Christopherson wrote:
> On Thu, 08 Oct 2026 06:26:43 +0000, Shivansh Dhiman wrote:
>> The AMD APM previously stated that after an intercepted shutdown, the
>> entire VMCB state is undefined. In practice, only the save area is
>> undefined and most of the control area remains valid. Revision 3.45 of
>> the APM now makes this explicit:
>>
>>   "After an intercepted shutdown, the VMCB control area is valid (with
>>    the exception of offsets 60h, 61h, and 68h) and the VMCB state save
>>    area is undefined."
>>
>> [...]
> 
> Applied to kvm-x86 fixes, thanks!

Thank you Sean for merging this patch. :D

> 
> [1/1] KVM: SVM: Clear VMCB save area instead of entire VMCB on shutdown intercept
>       https://github.com/kvm-x86/linux/commit/bdd05706f146
> 
> --
> https://github.com/kvm-x86/linux/tree/next

