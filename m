Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0102D2248A3;
	Fri, 27 Mar 2026 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593702; cv=fail; b=S/iNbXpEHpxw5kGVCrDLNcwfJj2MCmokfTLdF10y2GbpcmBverTK8L6y46oKhA5yjzAVJJO4jkB7U5u2uF+oC0wVtSJZAGqlsY39bbh7kE90+hDfqw6GxUSpCIY2pFZmBxXxt4Rj3aZXztsX85CRc6hvTPyu0EkGubtILdsXs/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593702; c=relaxed/simple;
	bh=LbMpme01VHC2LdCH1NX2VIOetwYO2Bg1j5KIDKZE98E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g/B43SdDlNBtAxq+SPrK2eJ8U6mlqWD/iQGdLUSO7V2YZ+CBH0Yp5I+aV6ofK1Qd0YH48i2QN744ciTC0pxE1y0NODogwRCXjwB1GAzzaYD0Y4QXhEqDxxC2VwdeTeDvIOU5OZDBbL0hTR1+HnD6vLVapfxeTYJ8+T6+0hd6EhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xn9Afl0p; arc=fail smtp.client-ip=52.101.56.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xn9Afl0p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrhmmAX5Nv7hoMbe3kuIAVEy3Wtzt8mm1Y8Cm5slAVvGPHAtTPA8IOJEOP+FM6fYPermh6LFdvbHSikzUS/IppXodJhyV/PFKXHTiRpYjUgaAkPP4sAzO6Eb2Jsgq9UVtlOpeYAuAe40hR2bfQVgN9JExn1LogrNt0ZqDPXGo8NDQMqBwpaCOlZQUXLov/oRLfgaNBLrlRNI3edRZqLs0oJnyMT69Q4fsg6zrPtxtLz6nHxWYNTKJMaDUc3L1SFIHmGZ1UB82PHi8Dd2RqG3jIZgLpMLszdmEMpQhitp4BXiu2SElUYmkYqWArTDve5mep/MJzEA2eOJGFpuJt82+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpECH2ONmxDS/ZrX5zHT1mAT60mFYbij+AevM1wOarY=;
 b=GuhyZq0xAxIZ/Vxxk3V/o8q8vJfnb3LL5htvgzhgcSAE/RenL0F5p1NFV/VPVrwhcmvhPInaWuprZ3WvEvfuzrRBYw0kFaG6fiAfB8LLpCxUznl9gzT/MZfNns3B65kRsxLKBKDDwBQPYdkktqtY1fulZp8HNJw1y6Nsnp2i6kKolKuK6/MccqqRAE5TAQuCrTcFpZfKS3gLiSTiNF/m/ihvV+e+pAckvIFCLiL43lPJ8BBK5mtfEHOY9pkwrDoqoSU20iDEogEaXaiIXV4YeMu4mlonOK+jTWaMTFNyaMkWW57XZRNg9v/S43EJycAUs+gBbBEmnudkxXtfB9BvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpECH2ONmxDS/ZrX5zHT1mAT60mFYbij+AevM1wOarY=;
 b=Xn9Afl0pX3NFPlwPi/cM1Pkg3DQPDCDq8EuOIg3p7Xu275KBR9GRFlytEJ/p9Fb19Y2P97j4sJGovof7NSvvS5bGUyglupL5qEtS6AxZ6bSCVQi/t7RIf8wdqRbk2NE26I35MAUuOOy1PaYXCzr5higw92cIelwbn42y9sX7DWA=
Received: from SA9PR13CA0086.namprd13.prod.outlook.com (2603:10b6:806:23::31)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 06:41:28 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::83) by SA9PR13CA0086.outlook.office365.com
 (2603:10b6:806:23::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21 via Frontend Transport; Fri,
 27 Mar 2026 06:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 06:41:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 01:41:26 -0500
Received: from [10.136.45.190] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 01:41:23 -0500
Message-ID: <f5c5bdbf-c910-45d9-9934-662c2670a421@amd.com>
Date: Fri, 27 Mar 2026 12:11:22 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] KVM: SVM: Initialize FRED VMCB fields
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <xin@zytor.com>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-2-shivansh.dhiman@amd.com>
 <aauGTverUvkEJnPd@google.com> <7c5d0db9-5151-4edb-9b97-0f0b268cf36e@amd.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <7c5d0db9-5151-4edb-9b97-0f0b268cf36e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 713f9e51-5f41-4d0c-e70b-08de8bcbdf9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AqxORriAluTTb7BgV507hkJscc6FliEz1uLz1kEfIRPkKC/87RQAyaycc5aXIf9Wo/UZkZXsS2j7bGX8I1N6P3nMbKxdZ5xf1bOl3KdHh8u2Gt79wxVm/eZP2rRMF58WdHuG+sherIDl4vhnmso9sY25M3g2dwqztmoP1cm2r5o7lo7lLFjWhEXcoqNnDp2JvHmoGpKZAIsJPPvUe5fT5OH2Eaq0kvlVQMxK5QpwxmbGpJx0B2CnVuAsOHmH6069eM5IRww368nb9Dc4bliUK65ZdLcFfPNckf85nI23iaq9xr0Rw3+uu/8IoH3T6A8AgFniQDVn4+EgpVrBf6fhiXPoDyBr0H9BsMl5fmoWi6Gt3MOIki6oHfo4qX93+d1HI2ANvY1zhL4i7XgQ8/K2LO58mHPDQ8ErkD4XlE/pWtLfDe/dpbwZFuD2nQLrUsO27Ng8Lv6gtCSVII0vTtcG+jiqbThwrWe0djoTOInWnxc9ynjXCu6n0ndqi85dvuc9YLMDEyzJ55RsLWRuqDy+dKGubFzvFsx30xw/eM8YBh0eIjnAs5QmVAxRh7pHzi55UkGGg74KFQZdej9PFU4AaK+7zoJVRCuFc/MxD+rFdcZhdYa630kcCeinFyJysWZMrIJu8ahHo1jkPtvdDaz2+dSMMUk8+B3czNSqHwrkJeRtKrwg+4+NAFMBqLf2wuVKfixsvqH0VYMMGEGrL6faKM8ZhhyLlQ6kFxC4wipdq2/OeVZxH2jEmMAxXh1Be2vC7f+Qya539eD8SAbW0IOpcw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TeWwmav9bGMN6S2uZNbobVAHucZBuGsOL0sJNR6gFQJUT34RfG8ced8OII/3SVY7mCMlQpLhu0sL8uhGSYazN6jQeyWEf0QZUM6OKiSD2p9/Zeck/DzV/38XLsgVb2AUdVuGsx8SPkd40b1lIMyo25bIui6zJNrDb6bH1Gs5w8Dyj/o9yCiwm1RwU9R+fBQKIMwvpVCUzP3dkHvU4RdY9aQT6IdnQ+BEKkgy256jZ1YUI2prYqtGpZGpxFVh/fxiHBZAntGJpBiOCZj9aeFO6B7GEymtYF3KQii9srQMwizcKS5j9cS1SHWQTtkWb/kQEzWHfYO2puScKwQrOCwNKO/NYPbNUpXcvcxVFLgGvVIP+8l92c+xiwzf9hb3wb7IzytfngjK2dEAZ6T9YUFiqeUxMu7XIpDAkaWzf+vaICq7VUlbp8V/0nFq1PQ1C+Rn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 06:41:27.8605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713f9e51-5f41-4d0c-e70b-08de8bcbdf9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279

Hi,

On 09-03-2026 23:16, Shivansh Dhiman wrote:
> Hey Sean,
> 
> On 07-03-2026 07:28, Sean Christopherson wrote:
>> On Thu, Jan 29, 2026, Shivansh Dhiman wrote:
>>> From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>>>
>>> The upcoming AMD FRED (Flexible Return and Event Delivery) feature
>>> introduces several new fields to the VMCB save area. These fields include
>>> FRED-specific stack pointers (fred_rsp[0-3], fred_ssp[1-3]), stack level
>>> tracking (fred_stklvls), and configuration (fred_config).
>>>
>>> Ensure that a vCPU starts with a clean and valid FRED state on
>>> capable hardware. Also update the size of save areas of VMCB.
>>
>>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>>> index f4ccb3e66635..5cec971a1f5a 100644
>>> --- a/arch/x86/kvm/svm/svm.c
>>> +++ b/arch/x86/kvm/svm/svm.c
>>> @@ -1110,6 +1110,16 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
>>>  	save->idtr.base = 0;
>>>  	save->idtr.limit = 0xffff;
>>>  
>>> +	save->fred_rsp0 = 0;
>>> +	save->fred_rsp1 = 0;
>>> +	save->fred_rsp2 = 0;
>>> +	save->fred_rsp3 = 0;
>>> +	save->fred_stklvls = 0;
>>> +	save->fred_ssp1 = 0;
>>> +	save->fred_ssp2 = 0;
>>> +	save->fred_ssp3 = 0;
>>> +	save->fred_config = 0;
>>
>> Is this architecturally correct?  I.e. are all the FRED MSRs zeroed on INIT?
> 
> Yes that's right, the FRED MSRs are zeroed on init.

I would like to correct my earlier statement. After consulting with the hardware
folks, it turns out the FRED MSRs are not zeroed on INIT, instead they are left
unchanged. I had incorrectly mixed up the INIT behavior with RESET values in my
previous reply. Apologies for the confusion.

I'll rework this patch so that the FRED MSR initialization is only applied on
RESET and not on INIT events. v2 will address this soon.

- Shivansh

> 
> - Shivansh
> 

