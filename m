Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C844E325C
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657666; cv=fail; b=QuHdlehb1ESn2pu/zKbzCARfiWzEcXXZuyzBrK8YWb6NrpAlZHrnDpAax1ZCGTblTUv8HQ/RXSmdDrYqCe8Vyrmb8sIJ/9oUC5n/DBl9BsY2uOLgtRoobfwywg4wLnkXxACc0ieFJwDx3qW4wLdGv/JlZ2hz4oGz1vurLRSLTag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657666; c=relaxed/simple;
	bh=YpNk4pHfxQCVpmKYGksZd3K+R664z4OwCOd1miIHXPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J9HScYa24iknjHh77+G/w/GV5GB9eSS+sKIsnu4OShuOldIDT8cMwxB5c03h56lHtdt86xPZ/3JhR7uNNe/ZZsHZyCsucSyK5vH4LZ7lYvyyc8Y2p70bqBPhYfSg1NoPtK7bI0CPMTahLmlht64LDT1qVt9iDrDYoUgPdz6xang=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hHUtG1/9; arc=fail smtp.client-ip=40.107.200.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hHUtG1/9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxWVHTfRoMl2IhnyfZYVbwYC7TKtaiNU4VwTX1dUbpZmxfS7W6orC2oDKJxQ/Ef8fQA0+fktGjV6T3BDSr3LZjrcsXyGh78ZL8LBGbcw3deVNCerDuTLvFHZczPf/foZWtv6KYYcuPjFGGwA3beS12hBlbzOm9ey751RU4Mn0NFGub7FF3njESb+ntY2GpeXwQe+IAp+zLGlA3Q6av65Yx2No511Hxozj7/gkgjBrLYHnvTyBy1ixXfUoQ1WZSEuDm9O01fSmfyPsydtPM5ZYz3K1xJY4WOT/NE6eo3dVtLtvgJYcbyeEh3tixQFMmT4kD5mRHgAcKdr1QmgYqBs1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpeEOiEtEwbqUt04pig8Qa9MsVrqsyY9atddECtUbJ8=;
 b=Ya6l9a5sCbL2FrvtBTbSFlYcXjDSkHUmmCUOMp9sOTEWastQUuGAWm9ZRG0ZEqDCvR/xmSRlnD6QNK74gkXDQBqonz60szGH5O8KSgfFu4mJriRGhQEC3XB1XJY08bSpj1I8l7RfoWz1Ivt5PHy5h18ox5048I/oqlvEUrCi5v4Nj5UBV0jmbZHqgt3PGVztAM1ugG3YrrjqLmbbHpA7rIYqYgV0IdrmfcvO8vYdMeScWH/xhqPgbn4kfZfjWjlnJF12yJndYpCdZx8/r4JpVuUO9MP/DXVZ4Mm7gRxwLDNcgxB2sjT+B1PbIQHWHDGhE/Qy4yqIy+KNBmNK1lRpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpeEOiEtEwbqUt04pig8Qa9MsVrqsyY9atddECtUbJ8=;
 b=hHUtG1/95J3DtNwujeqY99Rjq3+vie+k1ifSyj4VYPw410C6+NhH+qJRRhPrDcEPQQ6d+EV+ad1ReZbk+UUWBgmq+TV6jxsfhY1HHGGarmibjakY4yMjWN3t/JK6ewGwXdbN1V0qF6KgEswFAvOXbCOU2oNGEqhkTqO004Y5baA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 15:07:25 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 15:07:25 +0000
Message-ID: <ecbb6fb8-fe61-4028-880b-245f94db0f9f@amd.com>
Date: Thu, 17 Sep 2026 11:07:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] KVM: SVM: Re-queue events that were never injected
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1789399214.git.prsampat@amd.com>
 <d946de080e3dd34844a665c167179e4910fdc9d4.1789399214.git.prsampat@amd.com>
 <20260914171628.8A4631F00893@smtp.kernel.org>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <20260914171628.8A4631F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:610:e7::31) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb7fd09-c9fb-4f74-4d5a-08df14cd61f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	sBQHEIp0hPDVquJTlIPMpbOq+JbI4jesZmbU1kv2JfmyQ8v3ZSDXhbrChhjNiLhxSybgOU4vTezWBiaHht8TPA1/olCH72weFMi0zuXMe2TylF6e+AajR9jXwIU2/thwd8tVN9kiVKwwanJz/Q8INQ1PNwGr5Q8GFVs6wVXuCILgeSwbjKlIqmnVVYENu4/aSsmaDv7ogYSMaHAftNlWlQc48wAIoOorYrQIP8uReDgNEHaeAlYzCCPfqHJbqk95mxQMNhIXfp0hR8J7pfO36wDmh+wOJT44F7uldqkJtp5sSiVfLFZv4N/W8zp+SPpqAEWm4y5aLecVZcn7b44Ze4onXawreidsEhXiR1o8nW8OD3jrZcjN5LfCy01Y39MhVwwBukYj9j76CES1tEkyht9fCmd/uHJW8nVmAdXF27ulKzb8PvdlvyyBbj0b/kDGEn8q9ze3o8WX6s2SUQWAc6rO5US13W20ssZ9Z1bvvy8HMpF5jwZ1UxvNuZMw9FAFHVHQFilZJO7xipXmgR2ZycEaViQvN7fydnTvqYczSpPuGgn4yZ92NpiSjrvsesZ9Ss8L3qcEBc0TXELcyAouqa7o2KqvJca5pfGtTydHVTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVVkL0poMXNSSnFBL01rNmsxYVdUakdVMFozUy9zb0dvSVNUeVhXWUNyM3Qv?=
 =?utf-8?B?U1cwM2o3WW5YMW9yaFh2eHRaWnhBVVh1UVBkZEhiWTFPbm5QV2VweVkweVNj?=
 =?utf-8?B?cWJYUS9ZL3BiTWVYRk9nT1VYTkxSamlmT21VQjYwVUJRQUNUbThKcDZrZzV6?=
 =?utf-8?B?SWRaNW95RFA5cFBYZnVjNWNPUG9GWS9yMSs0RnArWWQranpDTW9EdlQrbUls?=
 =?utf-8?B?WjFQMmF6WEU2MkFCeURWQm5SNWVOL3I2TXZQTlhuTnVwVzJIZmJJcW8ybDhP?=
 =?utf-8?B?YnlodldPVU13VnlGU0wxNFUzRU1zcFdIc0FzT1d2MEhUTmdtQVZJSkFvaXc0?=
 =?utf-8?B?UmhzczdvbzhIZWRVV0dLYlQrdXovTVlvdStCcGtLQWhTdDZQTjRXNnN0Smpu?=
 =?utf-8?B?UllLRW5xWDdiamw1RjRySW4zYlJ4MUo1R0dLRDdXbEtEUk8yNzdwTXc0SkFM?=
 =?utf-8?B?L1JSMVhFRVMvdEVLMWpiWXVtNTc3MHB6S2pkQXUxV1JaaENNQ0k2bjcrQlpH?=
 =?utf-8?B?L2ZSLzBwcDBldk9sTFFmZlZWZnFKQ20xQVBCZFFyN3hKYXV0dW9sQ0Q4SXB5?=
 =?utf-8?B?NHFiR1Bqdy81Yzh1czdHVGNpVm4zSjBIZWR6ODgvK0p5K0ZidjRJamE1dDZS?=
 =?utf-8?B?SjFrN3RrS2VxMldJSklzOHlnajNMNEg5WUErcU4zVmUzSUlYSGs2dGx6SFhN?=
 =?utf-8?B?K1VINS9PMng5bGdId1QyUTJOZkUrVHNpY3VUTUJXZ24rWFR1dVNNUi9Yd2N1?=
 =?utf-8?B?N0xmVXhKMnE3U3VnMTg5NWNXc05QRHRLaWN5MHlpTDhVOVFpWXpkWjlsZ2hs?=
 =?utf-8?B?VDZ2T2JZcWRCTkh4ZUpRclh3NVhXRnhib21vRjNSQndBd21sSUEwdm11bWR4?=
 =?utf-8?B?TjA5QkZhTmgrQ0NUZk1zbkFqTmJyTnQzUG1FV1pLeEJ5Tkx3MjdlWDc2VE9s?=
 =?utf-8?B?cnIyVCtEd2pVWmF3UU15MEg4bEV4elJRUFZUNWxrUXR0bXRlOG1WdUJ5Yzdq?=
 =?utf-8?B?c1JUTEpaejA3ZjJKTWlvNVlVT3lJNWFVaUMrVXg1RElJZE8rOWtEWUd6RWha?=
 =?utf-8?B?SXFQSGFhYkFJMEFnU2l5RzZFUXVzSlRLMDNTNXM2N2I5OGpmdnN1b1N4NGxX?=
 =?utf-8?B?T2tZSE55K1NkNm52ZFBNbi9uZzdpS2s5N3J1Y2VzOVRndERrQWJOMUdHanNm?=
 =?utf-8?B?dmdyS3MzZmRQQlNEYUxqaWhDVVlhbHlqWHo0cHRmd3J6RSsyVHJlNFpkZkZE?=
 =?utf-8?B?TUdPQWlIZldKWE91NndqY0NFR293K2NEcXNnWFl6dHptQTBSLzhLUVJRN2Ri?=
 =?utf-8?B?UWNBZHpxYXE3N0RsWHFaWS9xQkRMQ1kvc3lCTlV0dzMvd2tuU2VsYU1EMHFk?=
 =?utf-8?B?MEFGQ21xZS9YSWZmY3BDditBdEZwbTU3K2Y4c3ZaWG9KajgremlrVkx6VmFU?=
 =?utf-8?B?N05jZVhJcWVHZzNSNm9waVhjSE5zVGluclpzOHFOS1V0QnhwVWhZTy95OGRP?=
 =?utf-8?B?a1BNaENQUStWQ0F1MmxDbVZFa2RUVW5pZ2lHRmpmODZ3Q0MzWnBSRG1NREQ1?=
 =?utf-8?B?dHdwSWRKRGtteG5vWHBVMnRBRDEzdVBJdFZEU3RBd1p1elZ1M3FXUFNKdDZJ?=
 =?utf-8?B?TDhkVWpOZWRqZUxnNDcyTW9hcS9vN1RkLzhyNkYzUk9xQzVaejZpSENvUXpn?=
 =?utf-8?B?VzJQTmFzS2xWK3pnTjdYUHlRTis2VUVqSGlnemk5TzU0RFJiYlYwNGJMUGJP?=
 =?utf-8?B?clJLYjJnbWlYSHRqUzIzQzBPTDhheE85blhWcmRLcjMxcUg3QlN3LzZiaE9u?=
 =?utf-8?B?ZU9neGJhN0RiNDF5N0I1VkRZbXRzanNmNmNLRy9mU1I4MjhHUmZhYWtZb0tM?=
 =?utf-8?B?SlIvbVRIbldIbEl6dlZUK1ViQUo3TWNNSkhjKzVPMFkvbmFGYWpQN3ZVVFBO?=
 =?utf-8?B?cjRHTHJNUkFaVTFKa1BXdExveTBHeHorcEJmc2hEdHJZYU1KR1VpdlNOUGtC?=
 =?utf-8?B?dGt3QVNNWk04OTEwcTQrTVV5Um40dXVzSitubHNnMksvRzA3ZVAvS1pkTVNT?=
 =?utf-8?B?WDdIYWI4cGpZUnNKamxRM0ZHMS9IT2p1VUtmSE9QWUtmQ3E0UkZXK00yajlv?=
 =?utf-8?B?anhpM1RPenFzQ2xEam1tWFdPNzZ0TVlkMm9JZWlYK094dDZFeFgwdVhWbXR2?=
 =?utf-8?B?bDR1bE1NRUxyeS8xcXhrM0dvQmJaVm9sS2xCcit5ZmN6Ry9WY0pOUjJ6R3lC?=
 =?utf-8?B?eUh0V0hQT0ZRRStxSkovTGNaYnA5TmZpTE0wa05FZnl4UVdEcjFaWFVmcHV1?=
 =?utf-8?Q?JUYsRB6kqMLTHqAN1v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb7fd09-c9fb-4f74-4d5a-08df14cd61f9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:07:25.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCCeTu4zHBc+tMzueTXMKobXU7+5CLfkE9d6shNMR4wZaALHJlMSj6Q7s8U/2T3j9qxvp3LVXdXSrOB/W3UYgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955



On 9/14/26 1:16 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] svm_complete_interrupts() incorrectly checks if (control->event_inj) instead of the SVM_EVTINJ_VALID bit, which can silently drop valid hardware-reported events (like guest page faults) by clobbering EXITINTINFO.
> --
> 
> commit 50716e3ba11eb9d000a0186ffad984ac08df1dcb
> Author: Pratik R. Sampat <prsampat@amd.com>
> 
> KVM: SVM: Re-queue events that were never injected
> 
> When injecting an event into the guest via the event_inj field, a non-zero
> event_inj value on #VMEXIT means the hardware was unable to inject it.
> This commit adds a check to recover potentially lost interrupts by detecting
> an undelivered injected event and re-queuing it.
> 
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index d0971685034b9..e2be2cd86c320 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
> [ ... ]
>> @@ -4323,6 +4324,27 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
>>       svm->nmi_l1_to_l2 = false;
>>       svm->soft_int_injected = false;
>>
>> +     /*
>> +      * Hardware clears EVENTINJ field when it injects an event.
>> +      * A non-empty EVENTINJ on #VMEXIT means the vCPU never entered guest
>> +      * mode, and thus that the event was never delivered.  Migrate the event
>> +      * to EXITINTINFO so that it's requeued instead of being dropped.
>> +      *
>> +      * An undelivered event doesn't imply a fatal VMEXIT_INVALID. With
>> +      * Enhanced SMT Protection, VMRUN may exit with an ordinary #VMEXIT
>> +      * without having injected that event into the guest.
>> +      *
>> +      * Clobbering EXITINTINFO is safe precisely because the vCPU never
>> +      * entered guest mode.
>> +      */
>> +     if (control->event_inj) {
> [Severity: High]
> Does this code silently drop valid hardware-reported events?
> 
> If an L1 hypervisor sets event_inj to a non-zero value but leaves the
> SVM_EVTINJ_VALID bit clear, hardware will ignore the injection and won't
> clear EVENTINJ.


The first half is right, nested_svm_check_event_inj() intentionally returns
true when V is clear, so vmcb02->control.event_inj can be non-zero with V=0.

The second half isn't. Clearing EVENTINJ is not part of injection, it's part of
#VMEXIT, and it's unconditional. APM vol 3, VMRUN:

  Upon #VMEXIT, the processor performs the following actions in order to
  return to the host execution context:
  ...
  EXITINTINFO
  clear EVENTINJ field in VMCB

KVM already relies on this, nested_svm_vmexit_update_vmcb12() zeroes vmcb12's
EVENTINJ rather than propagating vmcb02's, citing the same thing.


> 
> If a genuine exception occurs in the L2 guest that populates EXITINTINFO,
> this check incorrectly evaluates to true since event_inj is non-zero.
> 
> This causes EXITINTINFO to be clobbered with the L1's invalid event_inj
> data. Because the clobbered value lacks the VALID bit, KVM will then ignore
> it and drop the event.
> 
> Should this code check the SVM_EVTINJ_VALID bit instead of checking for a
> non-zero event_inj value?

I believe we don't need to since the valid check is made later below.

-- Pratik

> 
>> +             control->exit_int_info = control->event_inj;
>> +             control->exit_int_info_err = control->event_inj_err;
>> +             control->event_inj = 0;
>> +
>> +             exitintinfo = control->exit_int_info;
>> +     }
>> +
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1789399214.git.prsampat@amd.com?part=1

