Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52123EB818
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117543; cv=fail; b=TkL1DuVn8ObBmpuE/r0B4Vb5Mea24z8WXro0H0/5WWkafKPaU3S/ZYjCOKeN02bIM8nPHOwPI5Xp2dM1t8D1n+VUDWcT7iX72jUY8r7n8H0I5iGCvw4m4YjBifETsKmjm76z7HRoBcLQtj4Ia2n52WLV8z00qDa0UDRtgOggrnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117543; c=relaxed/simple;
	bh=V0sF8mmjgIQIVi6IBVB5MVbRsFaX/gTEH6mPVR+M92Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=dBduXf4LUHtxb5oa2skmgk2s9RYS3YDVrPw5WLRBsaKdRqAc5eGN7fseWrxMleMjbDzzCtGi9MFCbALDqbg0gL7NoxsauE5wSAawuK7uCjEV/TOCASApGsxqg/KPWJLRHKbRnDyQFMge0O1WGl1VuJHWAt4Rd9R4iLM743fFodE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2HRmiOHP; arc=fail smtp.client-ip=52.101.193.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2HRmiOHP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxrY9CeMdCC6bF2DZwaN/OzgPnh59DORU1jC/VrVyOrstvRt6DSxV/o7XrzSomkihV1QKTYhgaZPzG1vXBuNEUZBz+Yj1WcvUpmr0GraLNAGiUwoER5j6w3AWis3cTSt9ksYsQtu9BdtPwPsSnOsyTHG6Eyzo/go+76ZMlRFGq4yqvmubTZ2b/yLA5fecQzTXeQTHM0GMkw6OMiaynqV20vgFLNEbdPgxDqbPkGiAZ6zFlPhM8e2INB1Xb3O9W/eD+/FxHQYftWiAEY/2XNVH0qHDQBNSqN/WlFROs8GWJy72Ow/o88x/R4iFDE6LAPNfj26oSeEw+uHEk+hLkDlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4TpMZxRIYGl+JDgZiT0/fMFHdishjwcexCa1DTX6mY=;
 b=hQ04a6tdeRM5aFHQBDNHy9Bvx+dYddb4rGQeqLxhbZAWyXwIOYVzAotUH7eKcHks+QW1ogbIhCBWl3mSX0JiKwHoX9filJ4RJ0dnG639XPCzoRRSrJ8m3Of5VSg35lvJ80zn9JEy6RNedN2qsEs16KdfQw4iBOb2TFYGWAE1eZomGI951qh7u1qAHE/yPZJxtnsHSgb33XhaSVy9YoXaXTjQscY7//c5+8e+pesR1tubmuOGft2VG2M5Bsa+L1VWJNhaoU/qquU59+uE6rb/KGEkFHQ95bsD9+nRF4BT1DKfQPOeP5F3v4MljVJ848vkJOICvYrPirUAD9d4cTFEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4TpMZxRIYGl+JDgZiT0/fMFHdishjwcexCa1DTX6mY=;
 b=2HRmiOHPNFINBtZO0rBwI+1mwb8dgZXoc2tXMkxH7zRgZNhaBrLXP7BG6YGvzVqJdk9vj6K/RiSnJ1wr8a8pSy8p3gXFZB4ykbs0DuevpSYBc+is8a1MMaqKTJYLs5MnEZJ1Mv0sGs+lSZMhE/cSLMRxvpt1tbOVd8kudRnQ2V4=
Received: from PH0PR07CA0100.namprd07.prod.outlook.com (2603:10b6:510:4::15)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.19; Wed, 15 Jul 2026 12:12:14 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::14) by PH0PR07CA0100.outlook.office365.com
 (2603:10b6:510:4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 12:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 12:12:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 07:12:10 -0500
Received: from [10.252.195.157] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 07:12:06 -0500
Message-ID: <b6ef4b3b-5553-4804-86a6-d0b1c23271f5@amd.com>
Date: Wed, 15 Jul 2026 17:42:01 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
Subject: Re: [PATCH v3 4/5] KVM: SVM: Compute DEBUGCTL reserved bits
 dynamically
To: "Nikunj A. Dadhania" <nikunj@amd.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<yosry.ahmed@linux.dev>, <jmattson@google.com>, <thomas.lendacky@amd.com>,
	<nikunj.dadhania@amd.com>, <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-5-shivansh.dhiman@amd.com>
 <7044cd1c-8f3c-4428-9fc0-b940b05b202d@amd.com>
Content-Language: en-US
In-Reply-To: <7044cd1c-8f3c-4428-9fc0-b940b05b202d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc76d7c-7091-4732-2b4a-08dee26a4d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	rHtHo6SU990T01/k9rOmoMwUy5LH5kA1VV4FQmGlp0f9pOPQapHHf7w9fzhE6LDUPAPrQxkIlWWhFdGHm42M3yyXfPswLcHUznHSN7lL524y1PfrkrGurwuJMbVW7+BS4Lih6onvMy5sZ9ydNWOLaMSPX14UKE32yITrHRM6AvesI1LDaz/Hbyjx8fJoY3vJiBL/OmEB+3gyp+zAUzpwARbu4trsDXqRJXu8c3V587oFha69+J9+mbLqaowIOzfLRYOaVV6DnQldEIwNxVoqgsBcoW2ov17pa5eLXmIqIDf3XR3f0e80epHhZ4ICyhvky7FwKPogkVCxHll4lXXGleTzgtBXlI9HTSVWnPQDImuyEoY1tDLKMljyVZBTkygkqVqBySgd6Jv34L+Os9xhIJy1qeob9gW5ZdeyUyv8TkV0DaAtwWtheuvaG1Hed19Q7nk+kMZrlmhv2Ba70W1hnQIZZLMwRknYWxiPJ30bNy5mcf94eduS/K3hrUQ1VKS74PVW5m7FJLywTAlVyC5BNq+C9itSf+sVu32ufvdoAbanPD8t/moeDhEQHTzNjrgZYs6D4Hj4FdTNvxY298WNHK84fh8BmEnA0aBY9lZRjpUk9vrMcxstaPdRYCCOjp5K89084v+YOKvJkVroKJtwy/CjVLQRWMw45pBacyEYz0V8IseQOrglEoh3jHxkWZFYI0Wy/Bt/0/H7WSXKny+SzQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PPoCfyuUvvckR8aAk6LRucfiQC87IK4iKCozuS/763rJYRJ71B0Wd/qW+QAsHU8bvZxHBv1qmxcuhpcoVBc6c0k6ZrCBJssvHufOt8VuOy/UtllrmCbN9H96UjaRirk10GYiwuYHzpt9OOmmokUEV3LG7I8/3SS5A+z5KFGLbsiG46a4XGXZL/nhO/hLNjFW49t4dUGeRiP7dvU6a46hKnBVK2rIXUovdSBBnseIcZqvitN4RO2zduXDeLecqkxVNYSBFrw8kqErZBC5GL2mKXuIwMJ+quJHeEI0IqtVExnOQTo+01jnzER+mogYU8h3GfY7IvXl/Z20rOiODrXmK4S8p7Wfo4Frd9U0Z0qifP+4hopMzD6x74jo88fI6UwnPx6bY5GH9l6Hm3LX947SV+AmbIXrX63FgKyibXK+M7jaJ450YsWOYHVJxYnMdLC0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 12:12:12.1578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc76d7c-7091-4732-2b4a-08dee26a4d2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439



On 15-07-26 15:57, Nikunj A. Dadhania wrote:
> 
> 
> On 7/9/2026 1:59 PM, Shivansh Dhiman wrote:
>> Replace the static DEBUGCTL_RESERVED_BITS macro with a helper,
>> svm_get_debugctl_reserved_bits(), that derives the reserved bits from the
>> guest's CPUID. This will allow DEBUGCTLMSR_BUS_LOCK_DETECT only when the
>> guest supports Bus Lock Detect, on both the MSR write and nested load
>> paths.
>>
>> Plumb the vCPU into svm_copy_vmrun_state() so it can pass it to the helper.
>>
>> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> 
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index 8d77c10cf4f6..402a827f622d 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -783,7 +783,15 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
>>  
>> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
>> +static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu)
>> +{
> 
> How about just 
> 
> 	return ~DEBUGCTLMSR_LBR;
> 
> here, making this a genuine "no functional change" macro-to-helper conversion.
> The BUS_LOCK_DETECT conditional can then move into patch 5 alongside the rest
> of the feature wiring, keeping patches 1-4 as pure prep/refactor.

Makes sense. I'll make patch 4 a pure NFC conversion:

	static inline u64 svm_get_debugctl_reserved_bits(void)
	{
		return ~DEBUGCTLMSR_LBR;
	}

with the call sites passing no argument, and move all the BLD-specific bits
into patch 5. That includes the vcpu parameter, the BUS_LOCK_DETECT gating,
and *the svm_copy_vmrun_state() signature change*. Will do in v4.

> 
> Regards
> Nikunj
> 
>> +	u64 debugctl = DEBUGCTLMSR_LBR;
>> +
>> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))> +		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
>> +
>> +	return ~debugctl;
>> +}
> 

