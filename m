Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7B3655D8
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039528; cv=fail; b=JVzneEqLO1ti1iX92mCHW7WMLkrhhVAZgS/ybR+hSyJ+ydsP3HEO5HY6n6f+zJ99azFPrMYjlOuNg6g++WXbRK8T64WxagBOC6f5mamfAnQtTqRSL770cmD//cF+TVXMkXiWUANh6bUG7hLBXyViMbSK7i/LqDreuLt6SLVYuuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039528; c=relaxed/simple;
	bh=LEVdIEQuIP4IVXNV6u7PaDgZQJuYkq3qHN7BfU+/ZcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pqGLs22eOSQKVymOXbhostfsQbR3pu10J3/+QDSU1KUDUUVsvV6LI6KwCjH6e+jzRoDdUBXqOzp9OwLsJGqXr5Bl089i0/nnaY2FQmz02e90nSbc+RJM5J9sMVaQIKQqyy8tghj8o+7OjtE70kQyjKgWuhY3L9VJGx1Eip/bi+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LseS6VCx; arc=fail smtp.client-ip=40.93.195.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LseS6VCx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFqDEvJsWPiWG7S1McIdiZQFhoOx8Fg/fzYC73NzN9VEbb8CI5iI7FubQFd/3qQOTwgS7rxtLqLyNqSSFrAmuml04YXeErdsOKICViKpagDlCw9xxh3nxMY2RyLeNicEuZSbtqGHYga7C105aVXu28dckLvVIQAzdpQy/GkKK1LK0Da0ZVMgAseMVtlNs05Q6jyzTUTAqIvUnenVoZ/kzMZ0FHZ+m4Ni2JH0XYiJ6mljCS3znYrGELa/GqDm8YRd3Lei48DUn0e8yOcOZ65H463Kg8nY3ixEON+FDphoADELxAqAIhbv3ybruoCxd35L+TRxG9U8q0AHciyNzXfxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OF28a0jv4cWf7x7I7Z+q69/FvTztOmPC0/kNZHtpxF4=;
 b=YIjPXs64SZ4JO3VL+xBQ8Iv3v0w2NAC+VKiKkcbzDfv9WgeZStYM9pmupBp1F+wXPPgTleUcHfHEkQW8NOd88sff5YGUICtgkkhCpfa3ONyWLrMflijrfJK1OvfBiUddqH6YNQ+OMt1dRVzYA7Idn07QABIh1YjG7cpxtFUiXu/oVrd3hEVfi4pigoyZvfTpeCWTMEvcwsQtQKHldtcpdlI44pm9/LghgJVU4ZhddusBKPiknXqEOSyFIuSrYoSVpQu/wDlOVm7L8tXys5955ZYOEgI6e/WnCUuCLgRb6F0oyvDPXNzj715dY07FbAr/LcqENSKTO7YwYMtcomKwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF28a0jv4cWf7x7I7Z+q69/FvTztOmPC0/kNZHtpxF4=;
 b=LseS6VCxm0uOGOJd8eSBHzRRsfC1begrnKODEK6huFeB4jA/w48oY8LNI1UpT1QU2Nl7WkQFwkUToKmeBj2wTkxwaBi0lo7r5dJCyh04ACcJ6WUvMhUrBNGNggINO9VAfH7TsF3G5d1j1fKaPEW0BSK1ztYDSyfKdPzpfVcYYwc=
Received: from PH0PR07CA0046.namprd07.prod.outlook.com (2603:10b6:510:e::21)
 by SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 14:32:03 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:510:e:cafe::3) by PH0PR07CA0046.outlook.office365.com
 (2603:10b6:510:e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 14:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Tue, 14 Jul 2026 14:32:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 09:31:14 -0500
Received: from [10.252.195.157] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 14 Jul 2026 09:31:13 -0500
Message-ID: <3064de27-d5e7-4eb4-a269-8b8a3325e972@amd.com>
Date: Tue, 14 Jul 2026 20:01:07 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] KVM: nSVM: Disable LBRV in nested control cache
 when unsupported
To: Yosry Ahmed <yosry@kernel.org>, <sashiko-reviews@lists.linux.dev>
CC: Shivansh Dhiman <shivansh.dhiman@amd.com>, <kvm@vger.kernel.org>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-3-shivansh.dhiman@amd.com>
 <20260709085012.C802D1F000E9@smtp.kernel.org>
 <CAO9r8zOV+9M=REzRSLLE_ZqcyFP5xdaNHmKti1N-SE_Y=8=VpQ@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CAO9r8zOV+9M=REzRSLLE_ZqcyFP5xdaNHmKti1N-SE_Y=8=VpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab8361a-e95f-4571-1882-08dee1b4ac17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|5023799004|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	RdnHmePJVHbjrmN95g1xWu5GXe/6DgxNQWIUm+HWLhoZAC9fRqynCBiQWmQitxVwZ5cBjRaagvVSZRcyF76heG7LVffi+amNivd7DFip2a5UnZ1nBgN+uSEvjgxsivpJv1IhEf0+3pULE3ttPW8h7AwUwi3DvvzJYZMLPIZ4ZDOYq9/2v7kW6i0T3g50/DrYOctN+2CykV5htRyEF6OOx53/V7cAkwAXu4PHVWNX18PAbCGJ/6HUwex/1vBIN0kU9VaLnNFzFKTv4MnDP29s80/Usmikq6ggUkJEsHKD0Y+5yzqspOQV2VLzctKIOQyNz6Y2LPkKwN6J1ttZJAEaYzIPsN5RK6KTwvaoAc0RwBs921n5ZrN1888a8D+5QKzOe3CRQDO386VHa6wulXBwWOQ8TDsfkcj6kb9DbO4GMqy/vhHuiedzLoO+vtYaeFID2huRx8HsAind320Pmw74F8LxoZybAXhfAMUpD7TckUkbW2zLGNhYcBpAXYA2mCM8oEPU6nCJixlLYvkyv2bXeuulzLG+6/E2C+YuNIaeB3sx0pvXIZXakC1u7dBfgRZa+Aq52+BRcbli0YO9bDgxpUO9NKFxwjpvv12j4JitkmCDH6M/ZFUfPlcVwGDDETdFeOVWqAlBVXhAR4efnWqhAGKAm5gKzZj9jlOa0K/fghmuS6CUeniHytflWIZ038kAPTRg4lgv2WU6g2POcMNHDQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(5023799004)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TMHftfypUE5ZO0XLg3YhFuWJERQtAXw+4JT+ASbRx5GNoeFsINQhyDn6N4P/LGwriB7Zi0cgcLggUyVSgFVqOcbAnk1RyEmVpKhq5hVgjtLRJJj7t9M66hiG22lFpz2s+Dv0JQ5n34yZnu3r8d6UnaWHB86C+o0CGPIx+fst1n5gqPZW3yHRF9eLz5V0y8bLIiUOgLwHNcP6baTyGFJsbcllbvqRkp1UWMo/tTWVemQekcX5aSdnTw+4bkJYUe9t0FLotwhFinz75iH9hnNylhe+D+TtpQXHXNdiFwo6aod+2qyouEcsr1ZnxVMDxUo8ReqzDjqcx9gVshC6enbzrmqBOWAXGSWfbsXsn6/xdM36kucYPEIJZuUr8nMtAIq0GNcxFDPU/J6WoOiA5VftaUl2LgyEZhh+NOZUGIqPqKGiZlkTC/6K+pD5QI3yI+eh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 14:32:02.9014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab8361a-e95f-4571-1882-08dee1b4ac17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163



On 10-07-26 01:12, Yosry Ahmed wrote:
> [You don't often get email from yosry@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Thu, Jul 9, 2026 at 1:50 AM <sashiko-bot@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] The `SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE` bit is never cleared in `vmcb02->control.misc_ctl2` once set, allowing L2 to bypass L1 intercepts or causing host log spam.
>> --
>>
>> --- Patch [2]: [PATCH v3 2/5] KVM: nSVM: Disable LBRV in nested control cache when unsupported ---
>> commit 54bf374923da671433d0174e1a9df561ac634275
>> Author: Shivansh Dhiman <shivansh.dhiman@amd.com>
>>
>> KVM: nSVM: Disable LBRV in nested control cache when unsupported
>>
>> Clear SVM_MISC2_ENABLE_V_LBR in __nested_copy_vmcb_control_to_cache() when
>> the vCPU does not support LBR Virtualization. This lets the cached value be
>> consumed directly instead of re-checking X86_FEATURE_LBRV on every access.
>>
>>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>>> index d3df6b22bfefe..84248e6665cfe 100644
>>> --- a/arch/x86/kvm/svm/nested.c
>>> +++ b/arch/x86/kvm/svm/nested.c
>>> @@ -534,6 +534,11 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
>>>       if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
>>>               to->misc_ctl &= ~SVM_MISC_ENABLE_GMET;
>>>
>>> +     /* Always clear misc_ctl2 bits that the guest cannot use */
>>> +     to->misc_ctl2 = from->misc_ctl2;
>>> +     if (!lbrv || !guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV))
>>> +             to->misc_ctl2 &= ~SVM_MISC2_ENABLE_V_LBR;
>>> +
>>>       to->iopm_base_pa        = from->iopm_base_pa & PAGE_MASK;
>>>       to->msrpm_base_pa       = from->msrpm_base_pa & PAGE_MASK;
>>>       to->tsc_offset          = from->tsc_offset;
>>
>> While reviewing these updates to misc_ctl2, I noticed a related pre-existing
>> behavior in nested_vmcb02_prepare_control():
>>
>> arch/x86/kvm/svm/nested.c:nested_vmcb02_prepare_control() {
>> ...
>>         if (!nested_vmcb_needs_vls_intercept(svm))
>>                 vmcb02->control.misc_ctl2 |= SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;
>> ...
>> }
>>
>> [Severity: High]
>> This is a pre-existing issue, but does this code leave the
>> SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE bit set in vmcb02->control.misc_ctl2 once it
>> has been enabled?
>>
>> If L1 enables virtual VMLOAD/VMSAVE for L2, KVM sets this bit via bitwise OR.
>> On a subsequent nested VMRUN where L1 disables the feature or disables nested
>> paging, KVM correctly tries to set intercepts or clears NP_ENABLE. However,
>> it appears to leave V_VMLOAD_VMSAVE set to 1 since there is no else branch
>> to clear it, and the vmcb02 page is reused across runs.
> 
> It would probably be better code hygiene to clean it, but I don't
> think it will actually cause problems.
> 

Agreed. This won't cause problems. But for the hygiene there could
be a separate patch to clear the bit.

>>
>> Could this allow a malicious L2 guest to bypass L1's intercepts for VMLOAD and
>> VMSAVE,
> 
> No it shouldn't, because nested_vmcb02_recalc_intercepts() will
> correctly set the intercepts() if nested_vmcb_needs_vls_intercept()
> returns true, and the intercepts being set makes V_VMLOAD_VMSAVE a
> noop (see the comment in svm_recalc_instruction_intercepts()).
> 

I agree with that, and verified it too. The intercepts being set will
cause a #VMEXIT, so a stale V_VMLOAD_VMSAVE enable bit can't bypass
L1's intercepts.

>> or cause an L1 guest to spam the host kernel log with SVM_EXIT_ERR by
>> toggling NP_ENABLE while V_VMLOAD_VMSAVE remains stuck at 1?
> 
> No, IIUC having NP_ENABLED=0 also just makes V_VMLOAD_VMSAVE a noop,
> and a VMLOAD/VMSAVE will result in a proper VMLOAD/VMSAVE exit, not
> SVM_EXIT_ERR, from the APM:
> 
> """
> Support for virtualized VMSAVE and VMLOAD is indicated by CPUID
> Fn8000_000A_EDX[15]=1. When this feature is available, it must be
> explicitly enabled by setting bit 1 of VMCB offset 0B8h to 1. This
> enable bit is only recognized when the hypervisor is in 64 bit mode,
> nested paging is enabled and Secure Encrypted Virtualization is
> disabled, otherwise attempted execution of a VMLOAD or VMSAVE in the
> guest will result in a #VMEXIT with a VMSAVE/VMLOAD exit code.
> """

The NP=0 case likewise just yields a normal VMLOAD/VMSAVE exit, not
SVM_EXIT_ERR.

Thanks.

