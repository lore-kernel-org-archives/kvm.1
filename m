Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792670439;
	b=kMrYiKXJPBpu9rKz9vFMBpBfs5NbxGZ75m+At+Esm08oLfTLlZQmNXO6KummGBHITc1p
	 fk0Zb7F3uju/c7lezdeRrXNlttXugdY4tHzxyBuZiJcg7EgeeixGqJdc9birBqkEb1w3M
	 KrZ+FCZwrWJng3gmjnh64JqPmumjdbO+RILp+BUz9ssKYloRgAHFOFkVKqrCmfQJiB0cJ
	 +Fl/C0Ldck9HhMK6pAXeuwGZxNMvSkgpf8+S3aVWF7J+0lxK5rQ9CzFyNwlepQVOvKumz
	 8BgM2qAP0qzs3dwnzgD3SCj4GtD4Oqj5VzE2enLp0s22FI1qQrXvYzyojruHPXhjg3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670439;
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
	bh=xhfrWCA6emNkpecuXr6NbnizrX0Jxr2uvHO5R5VbHKo=;
	b=4VF0AdMVlXwOWAOCimnrg8PL0VLR2Vmskj5oXYnS9b6vgcLXoKTaH45sAGFbWhxbZn1T
	 RG19cJB105UtwefpLQH5rtyqx6r0Vm173CwPot5dnnW5QMVNvhmDzT85UCUy3iqPzjsYO
	 i0S06LVin6/jVpHaU0QkwEPKbCwBENZPoag1RbwLMy/ZwR45nfh/IzVkRgubOK84uFfsg
	 SfamSoTxUvGu9EVs0o1tUyK2+l1Bk8uiza6yNriXCerjVE68VuUK+OrnNPxVBpaV4fsRl
	 bbcqOBbzVC7DwnV0Fjrx8v2dKgbztK8J4DFeM+V5My7C/y82opDnNsbyByUaSMRjfhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wp9obF5J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.48
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6F606A31F
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 12:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8F6F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wp9obF5J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bz8nXHOykdi6D8bXe8QUVaUe82ru/wvTeoCC2tnyNe9IhNCy2VWoQd2vS0LEJwnYz8D4HSTQm1kMiZl7Gd5Drk4vDh2PusstKauquUpPIud3m2dcsSsOeqPC93ZU4brwox0GqWrWj/gdpBkmrJKbC4VyBTdJPJC2msL8kMS9Esdzvi7bTRWjXLK1/c9EwXDb+SJ7v/nuoNy/V4XTc7loZTAbVMTjgsRc4SyfdaB/xOkz80pdv76+suSja1DHPq0EBxOWSg0uHxwpTy3+d+lWT19tsroMA9a04dLTwMteDlV5BZZPT9r0iK9mC02mSG1Y4WFv5gwHCI0DGkLbrAOjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhfrWCA6emNkpecuXr6NbnizrX0Jxr2uvHO5R5VbHKo=;
 b=f0oCE0T+++VhBAVyWjWVBCWmHs6gl/+uhn9KwhK/8xvchzFHh7FH8x36Esg2r3wPmZ7O1SrI2X4q1BylaCJH47Ue47BRBGc2nDyocx00E7tIQrO+KCjttn34Jw1m/9owghWWARK7aA7DbokSJsqnRJPwA+4cBDlfS6HLHMYzLJ0LRmenlSQC+7Hls2SyumStkYi/f/dXA5+jF4dyxhZQ5mtJ76Cec5TrIWKOZ0fK29sTpSd9jeRzbd25rH6LAnVeE5QIGLM5jAGijJPK5oCf9/6jBxtnbniIKnkpdTz5E90nTfJevn4Z/sD1ptxcvO76TPeA0tcA6MeAmQbYBwrnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhfrWCA6emNkpecuXr6NbnizrX0Jxr2uvHO5R5VbHKo=;
 b=Wp9obF5J3BGSRhiYxUWiAzPQddjqYfkfKPOfrQ1D885QxVT7hxSlTpXlwPGvmeIb+YmJbFHX8dJIM1/7qf/lT9jJhZA+VM6kg0ArN6gagVzMOreIXt8gZO5tNq3vpnRblKkVwR7Y3x4Ix15kgaBhOjtVoYsOLYDCWEakNy+ImkE=
Received: from CH5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:1f4::16)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 12:00:34 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::4) by CH5PR04CA0015.outlook.office365.com
 (2603:10b6:610:1f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 12:00:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 12:00:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 07:00:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 07:00:32 -0500
Received: from [192.168.1.8] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 07:00:28 -0500
Message-ID: <a3eee649-0719-46d7-bd82-4dbdb1c98c8b@amd.com>
Date: Thu, 22 Oct 2026 17:30:27 +0530
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
Subject: Re: [PATCH v3 4/9] KVM: x86: Extend CPUID range to include new leaf
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <mingo@redhat.com>,
	<bp@alien8.de>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>, <Naveen.Rao@amd.com>,
	<dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>, Yosry Ahmed
	<yosry@kernel.org>
References: <20260310060022.15120-1-manali.shukla@amd.com>
 <20260310060022.15120-5-manali.shukla@amd.com>
 <20261008175928.732268-1-jmattson@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20261008175928.732268-1-jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: 208c1aa1-8dca-416b-f72e-08df30341431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|56012099006|11063799006|4143699003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	JDmZ+fTBLhxH4lX4BOYKNL2B/4cEJvr3HtC5pB6QBEWuETEoRYozptWJQ7oyMRQhzLEQcwtYNP03xc93wTcrJwNWdxuqr76iZkrSA1ujy2nfObBQpVsBmR8GU6CjqLC5dngWWi6syPOkX0MSU6szdQ8JwiJI5CP7JRYwggYsjp0W+zdcXlzc8bLsh4XKhhnfCvKOAoDIrK1pFxWjYjpedaT1LM8iILqO99AMxMA+n3FDLgWQlRCGSXKypLlo0J7ARQq8ZJOsBON0g/tOKNYSj/rFb57CXaytKSQaAoGZ7vRB2lPIN1UQ6o6ic23IPzBkeqhmADvlgYlu9m6r3Kb4iPaSd1XDDgtPtCWqqsToFunK9dHI6WWukJlBtrcRaQKV3rh+GH/H10q6UZlCS8sslMZHqeOCHfUcNgffpQjrrm7wyGZVFNvEUU60F8c73JrG+zSYbgLRZijUqzMvdpMQ0y6KMUyqJVIpECT7/3VziQAWIaaUtv5oOS3qEQIAImAlvnuLdGZDu7bJo6p+sPW41u8LUG52Z402D6nQD/VlXLI2VCEJ1GiNKo/XwAX3ePS7xbgx8xfnufjj6DLnNSAbxkrAwQ9Y4WDB5cRs0X12tE5L2TfnJvcISq+O4ftnSVobkuEWKkS9pgKAcHoN5sIB32dvMkfjXuxgeFtZ4p97KQ3fB6q6M1RmZrv+m1JRBclPX6ApyUvAQarpugEymGp2jA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(4143699003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iqYGDwUAmKDoOU/RnR+4yV1p4P9ueJNIEj7SJkNdHuEeez1xxtDLlHk9mxxnhmYG1Z+MktOVMP9dIsGYukb6uu7ZTeKM8Y3KcwU6qOxHEIPD4Vy8vQrBf14aVK4Sn0V1Wvf3usVTF8YmwKg9K+XndRcKXTjkMgGWTW4sReBUpRPI+pPkliYY+RM0PgttRk3QLB4AnwtXpNiCHq3PJnsnGks1leUyX1PyXRVJcNC4WKFOpgG6CJ9WWNcqaOXZcj45l67d+29maqRcmDy56RFiWOxGdVABI76rKCRIhsQeXjXKZAE3Q7meVGAO0+etz+loMJFvidFMalXM9bNV3jTQY/7H3micac6tejduE0Tbo6bkxiIyBJfZ3AAGa5X2oBX0TF14/IBcmyyacFn0+02mJK68EQr8YjYOyZ9h/cmki95Xb30qfBdIiwLDLH+9B3WW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:00:34.4862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 208c1aa1-8dca-416b-f72e-08df30341431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270

On 10/8/2026 11:29 PM, Jim Mattson wrote:
> On Tue, Mar 10, 2026 at 06:00:16AM +0000, Manali Shukla wrote:
>> CPUID leaf 0x8000001b (EAX) provides information about Instruction-Based
>> sampling capabilities on AMD Platforms. Add the new leaf to
>> kvm_cpu_cap_init() using F() macros, which automatically gate each
>> capability bits against raw hardware CPUID via raw_cpuid_get().
>>
>> This allows vendor code to simply clear entire leaf when vibs is not
>> enabled, rather than reading hardware CPUID and calling
>> kvm_cpu_cap_set() for each capability bits inidividually in later
>> patches.
>>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> 
> The shortlog is not accurate. The CPUID range does not change; case
> 0x80000000 already limits the maximum extended leaf to 0x80000022, which
> includes 0x8000001B. Before this patch, leaf 0x8000001B went to the default
> case, which returns all zeros. This patch adds KVM's supported bits for the
> leaf and a case that reports them when X86_FEATURE_IBS is supported. Please
> change the shortlog to say that.
> 

Agreed. I will change the shortlog

Probably something like this ?
KVM: x86: Report supported IBS capabilities in CPUID 0x8000001B

> Also, there are some typos in the changelog:
>   - "Instruction-Based sampling" should be "Instruction-Based Sampling"
>   - "capability bits" should be "capability bit" (twice)
>   - "inidividually" should be "individually"
>   - "vibs" should be "VIBS"
> 

Will fix it in V4.

>> ---
>>  arch/x86/kvm/cpuid.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 96a08a556543..4e626e77e6a6 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
> 
> [...]
> 
>> @@ -1848,6 +1864,15 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>  		entry->eax = entry->ebx = entry->ecx = 0;
>>  		entry->edx = 0; /* reserved */
>>  		break;
>> +	/* AMD IBS capability */
>> +	case 0x8000001B:
>> +		if (!kvm_cpu_cap_has(X86_FEATURE_IBS))
>> +			entry->eax = 0;
>> +		else
>> +			cpuid_entry_override(entry, CPUID_8000_001B_EAX);
>> +
>> +		entry->ebx = entry->ecx = entry->edx = 0;
>> +		break;
> 
> Please put case 0x8000001b between case 0x8000001a and case 0x8000001e.

Will do in V4.

> 
>>  	case 0x8000001F:
>>  		if (!kvm_cpu_cap_has(X86_FEATURE_SEV)) {
>>  			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;

- Manali
