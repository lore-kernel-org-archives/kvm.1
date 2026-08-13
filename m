Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013005.outbound.protection.outlook.com [40.107.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02DB212550;
	Thu, 13 Aug 2026 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609160; cv=fail; b=oY6YRc3PWzIGDMtfLwIZCODG73nVmd9lOibS41Y4miI+FIjO6Ese0HXk5n1ZAXqu5mJGvYTM6l799N8bRL0NiFVtSCG4ka5hZz7RfBP50z+dvakVzufTjl4UR7BmknrYbP3+VRVrUontuQiJbR6GPyfjrYJ4yYtj/1TCzCZ3Twc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609160; c=relaxed/simple;
	bh=9BkWNO+Jwjvd7WiQxWX63g75a6nATdPvC48SIIDKB6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p2tFlHFKwIcJrLpkxKA2tDfizhU4PkVf3bVLNp9lfWu+P5YgSemK0JAq5nkI+eUXtpAdgjfQ7o2BEFETzPbcBjpwZ6tbrjeuuB5S75EvrPWs50PKmcqFhbTnxm6sr42X83cZCWeISuCivEApKbLSVrq5F2w2u0x1AJRK1lL6odI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q6nZgMTj; arc=fail smtp.client-ip=40.107.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q6nZgMTj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2htcDa2lOYloj5IdDRwl/+7hqOiF6dcBDam2IJnNYIG0h36sAzkAuYwO5RwCApz+J9p/gr23SqlibDADW+ms8U8+cTq0UCbPMKLL7JemiDUx+cdyVlrdMVn023PKmaTdaH0fBFD7shMaTCCEvggfAAaT89WW3GWA/+MkUXzwSsOL1ZJ0RsB+O1AfPjsqLn5ID0OHyJLux1x/c7JRzvEKB8yPKbdKXaZBTuy4/7GlvwCT5hnfu2GVgRgE36fCmoinwhvhlNfrFHEWtbJkAb2w1rSTpvPs7HFp/u5PzvXFJbeLif7TMaReNBxhVO92hKc7VHPjoiUB8EYhf7F/RgfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6gw19CcCaA3UTF4KT1nap2/5nnmzssnE4W4Lo+RyFI=;
 b=kS+McZRuNdUWYiT7zNinTHOHSIhLDh+jIgWoQ0FwK4aYwkBtVnBHKdgXk2DN8hS07b47bYwxIcpmjL/kzwDOSb1IdyCeQf6FClvzZVHMGXT8QdhOh9kcgSNITs/LhUYTsRDFv7KUU++VloC9EA0pYK1TSD9lsbUfDDcBcfBLrVLSSrdF1aZhCM5clYxVBGTrNt31+0ZIEpjxzrXlq6vF9h34zxtx038BuL3XDAvgmDyEMojeHnGKbRY9giZJKpOiIp0lFN6FrGeDj0PYZnT+C3nw15LKP/gXIT74fWjSdbKIPihRJ/oT5iLWGr0xwLlXrCNuA0+gTtkr0J+tt0foeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6gw19CcCaA3UTF4KT1nap2/5nnmzssnE4W4Lo+RyFI=;
 b=Q6nZgMTjgQjZPm3du0OYHRTcGLGEX7C0OUa2OUHqyzOlSuioEg/jbKm+vai6KplDiuxDIRGEEPxi4KCbnlcUxDP7dgNG16zBmZNzUiXODkemTQgDsCSwuucIA5xnJHnRiT9xlEVxIa0qsYJEt4+0YrzWSbz46bk9L25zjBnpz/s=
Received: from BY3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:254::32)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 08:19:07 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::8f) by BY3PR05CA0027.outlook.office365.com
 (2603:10b6:a03:254::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Thu, 13
 Aug 2026 08:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 08:19:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 03:19:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 03:19:06 -0500
Received: from [10.252.195.98] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 03:19:02 -0500
Message-ID: <fede3476-5c56-4cee-b0a9-2e89e5a334ae@amd.com>
Date: Thu, 13 Aug 2026 13:49:01 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] KVM: SVM: Enable save/restore of FRED MSRs
To: Sean Christopherson <seanjc@google.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
CC: <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <xin@zytor.com>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-8-shivansh.dhiman@amd.com>
 <aauJ80pZrw_SfF31@google.com> <db768f80-dfda-42a2-8601-8d0af35c2959@amd.com>
 <an0BbcxUNRKqnUSJ@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <an0BbcxUNRKqnUSJ@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 88847687-0a12-462b-1a78-08def9138b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|23010399003|13003099007|4143699003|10067099003|5023799004|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1cuJpiYVUY/VH8jakgVisKPem63c0Nv2hjJeAHxcemTfxzla1Cr/LBNfE6D06ZhF/IYr2k+pdnRVP4GuvVAw3xU1ZoKExSKt9rlujJvy6HRLiJvjDCdeinK+iLk9iEbe9WgJClNhoYzXa7V654e1ycElHPtOhVQc0ycSTztSbdg+hbEMZZYgak0M/qDtm6AqxIt7yqPMp8HOQ+1i8xzh1VQwElMN2WAuUE6NCma13G4WIKUf0Z+xOGZHo2KyzMiR8PzIKzvV78zL1KyvJ9vW8r/FXIIFWLeCt/RO4z6f/boxV8wNIJkHfXzvg6Lo3wxuzohUPumwn9xSH40HJbcnPnUEyem/ZBlKqSjX0QJyJbML/OHrTXDCgQzRmcBE6ayCV+op5Q9IsOBhEDaglJh4Y7Sou9ZxBImL0q1iHmKM6YegqrKtvOJ3rus5cAJ/uRmlSvMROSvLiGP39O56kso+AfEDLwKG0Mmk66XfYBTfMGyEM6Msco7QpIq3yLqPVU36WsJYtr8elZI35ZsFSqza/exTS36gq0lHjrx7NkYHsD9ajgFYC5BW4NeR0G+kj4+s73F6cVsqjKeigQIrDmdOG63d7zIscIg0s2nDSEi4JUWZxKd35H95+hqyKpXkxdbL1NxkvsIqwimBYzPq7+JaukNV7J8zxkURS5CY5WA3KvNSTLAQgRvDdabdmPpfeBI+MMC6NU6Tz2LF/QBPi5UNtg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(23010399003)(13003099007)(4143699003)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NaN4Wg6LBJJ/ImvpfE0VEGRt8T0NJYHhyPMnaEd6J93vp2lmrz+grgC1YW7bkiRfSYEKS6lKndTyzJt/Iy3b1zG96rubI+TLQnBIj+JAphPCHFdE33qKZwrquqOltarRV//H2NmHGwBm4od29S95lpZpZAcIQAv5DO/AWLqeHAStjQKunnX8TgsHQ4vhMOB0XKbUPOAjNMBaaW1HkBviVj4BGw28KNim1LaWRk0iw4xtfCwVsMpCGqUa803JM+xpYj7vbN1sbk/OMYSMNoJ9n62N9GeJfFIN9dCflZaQfqj2N7nARoj7zU3F6PEAtYsfYM0/T+p1pnQDTsdkDsG7efJg0RiU+eg7pDx/f+qhfwcpngMOtbiajim8EnfaS8BiKyxEdtcT69N3ZzFrIiIi36wxTZA8796+fGAq8G5DPEzKCihlD+Yd1/BQYm+gONEw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 08:19:07.3939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88847687-0a12-462b-1a78-08def9138b9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396



On 8/13/2026 4:57 AM, Sean Christopherson wrote:
> +Nikunj
> 
> On Mon, Aug 10, 2026, Shivansh Dhiman wrote:
>> On 07-03-26 07:44, Sean Christopherson wrote:
>>> On Thu, Jan 29, 2026, Shivansh Dhiman wrote:
>>>> Set the FRED_VIRT_ENABLE bit (bit 4) in the VIRT_EXT field of VMCB to enable
>>>> FRED Virtualization for the guest. This enables automatic save/restore of
>>>> FRED MSRs. Also toggle this bit when setting CPUIDs, to support booting of
>>>> secure guests.
>>>>
>>>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>>>> ---
>>>>  arch/x86/kvm/svm/svm.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>>>> index 954df4eae90e..24579c149937 100644
>>>> --- a/arch/x86/kvm/svm/svm.c
>>>> +++ b/arch/x86/kvm/svm/svm.c
>>>> @@ -1144,6 +1144,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
>>>>  	save->fred_ssp3 = 0;
>>>>  	save->fred_config = 0;
>>>>  
>>>> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
>>>> +		svm->vmcb->control.virt_ext |= FRED_VIRT_ENABLE_MASK;
>>>
>>> This is completely unnecessary, no?  CPUID is empty at vCPU creation and so FRED
>>> _can't_ be enabled before going through svm_vcpu_after_set_cpuid().
>>
>> Hi Sean,
>>
>> You're right for vCPU creation, CPUID is empty there and the hunk does
>> nothing, so I dropped it in v2. While preparing v3 I hit a case that does
>> need it though, a triple fault:
>>
>>  1. The guest enumerates FRED, so the FRED MSRs are passed through and
>>     FRED_VIRT_ENABLE is set in virt_ext.
>>
>>  2. The guest triple faults and KVM intercepts SHUTDOWN.
>>
>>  3. shutdown_interception() does clear_page(svm->vmcb), which wipes
>>     virt_ext along with the rest of the VMCB, and then INITs the vCPU.
>>
>>  4. init_vmcb() runs, but svm_vcpu_after_set_cpuid() does not.
>>
>>  5. CPUID still enumerates FRED, so the intercept recalc puts the FRED
>>     MSRs back into passthrough.
>>
>>  6. Nothing restores FRED_VIRT_ENABLE, as only svm_vcpu_after_set_cpuid()
>>     ever sets it.
>>
>>
>> So the guest ends up with direct access to the FRED MSRs while hardware is
>> no longer context switching them, i.e. it can clobber the host's FRED state.
>>
>> Setting the bit in init_vmcb() is the smallest fix I came up with, so I'd
>> like to add the hunk back in v3.
>>
>> Would you prefer it handled in svm_recalc_fred_msr_intercepts() instead
>> while setting intercepts? Or is there a better way to deal with this?
> 
> Take a hard dependency on an upcoming APM update that states the control area
> is valid after shutdown, and rework KVM to not clobber control fields on shutdown
> interception.

AMD APM 3.45 [1] is now publicly available and has the updated wording:

    "After an intercepted shutdown, the VMCB control area is valid (with
     the exception of offsets 60h, 61h, and 68h) and the VMCB state save
     area is undefined."

> Nikunj, I was actually expecting that to come with the PML series.  But looking
> back, I see that you proposed a targeted fix for PML[*].  That's probably fine?
> Rewriting shutdown interception just to avoid a one-liner is a bit ridiculous,
> but on the other hand, we really should do that sooner than later, because PML
> obviously isn't the only thing affected by KVM's conservative read of the old APM
> wording.

Will send a separate series to fix shutdown_interception() to not clear the
VMCB control area.

Regards,
Nikunj

[1] https://docs.amd.com/v/u/en-US/24593_3.45_APM_Vol2

