Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5C81724;
	Tue, 28 Apr 2026 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777417240; cv=fail; b=nmvkDHdfDp/M+OFli2Rlqu9uhJW408z00623+cRUISCCwBdpj7m2ZWtmK2jkKUBs3snraq351ztim2VoQFkoyPVewwlONAS8xZeMFOae8UZg2+KXBx6c1aCkMErYhHauzpUBic0TRxvA2c8p8bzqrxMoQYQZAb5MfIx7x1RzMck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777417240; c=relaxed/simple;
	bh=0MkUTNZhHE2trJ7T4JpGH2WE9BS7iy0N/sU/Z2/TbQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qA+qgQR5eMAjtHcsROpJjmNsPYEJE72HF7j4Ir9A7mGvIIVpjmR/BOka/jr18mNdYwHiDrqTSpF1uYo/k5UwJ/aTtX5an6YntA5vEasXA7AT9n8qJIyG959fyKFAHuqxKa8Dg3xL0R3Tay5WpISA/7YYJDL0OFn6LJ1spB0//SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wz/pRv1t; arc=fail smtp.client-ip=40.107.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wz/pRv1t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVu+7GN3+UwxWaEdUsTnHaQMrh4NzPxJlMWmB5TNfhoUT8kbW2aP8XTvvVOsQ7quKTgCVdb6vHobUhtDoSSNnvvNm4gf4ebtQUU0fYpzNMDGWlNjiM0plijuMxs8UrdLaHOu2qYJb5NDXT04xkhdZfpppt4towo7GgXoXOWxCWkr7/uJLfVYofuAAYqXvPbSobYjJDWkglz56NUrApcc2+VflvL0WdildprDy26ZOkCtZ4SJDvOiv3BStk2cJHpsW3FWEi5lI7DNu0LpwgSNJMl6WufV8yotQtjE4IsWIwaOdRhZvf1K2kKWVLDRMvpomqg05/q9Z6UpZc0KBCWgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ft1CrdIvlAPhHUUzCfDVjFJ9At60m+ulAS6DjDGRlZw=;
 b=pssOFhOW2+zhqk8BTFIV7nY/4TvvfztxFndc68tDxRjrRlYsj8nojUziUEWUCVzjpk1bWZTTCrQGGYZuOGjiaJy6xav5j6hNQSj75LKw4fhscFX7vJSwdUq4BM+5kaBUtJqJg5ft0G2jIjEoMgmnVOX3Ubpcqw/xTkPHiye21h15jE7ZEUirZz+mkqPuV2dETvT8BrHKUwU9UbYgruMImLl/OEBlpqYR2dq+MaIfgZQoLk9+6T+3HY9HrBryrlwURz+GTyc5Z72r7xaXC3PKeD+Fn0K+YyDijlj/H/CuQkzNw1MBS9WFLrf1m6EKPziGIjb/VCN64OM7m4IX3YORnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ft1CrdIvlAPhHUUzCfDVjFJ9At60m+ulAS6DjDGRlZw=;
 b=wz/pRv1trnyvchVFanJf8kWuG+GwgIkUg0bTZ0ebHYF5ay2ElEJRxEJgkCdcAN1SoxPMaPecpr92eV0wSIf4O5jODnT8MO7qMzgspvnbI2WJVzvZe+eAXyQSOvRXowL8szjHmC6v7NbqAsYHKanQHoQMAuZna4hI3/zlHDpi0As=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.17; Tue, 28 Apr 2026 23:00:36 +0000
Received: from PH7PR12MB8106.namprd12.prod.outlook.com
 ([fe80::95d6:81b:325d:1923]) by PH7PR12MB8106.namprd12.prod.outlook.com
 ([fe80::95d6:81b:325d:1923%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 23:00:35 +0000
Message-ID: <635b3e09-0b90-4a61-a947-fd0658278bd4@amd.com>
Date: Tue, 28 Apr 2026 16:00:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] KVM: SVM: Inject MCEs when Restricted Injection is
 active
To: Tom Lendacky <thomas.lendacky@amd.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joerg Rodel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
References: <cover.1777048608.git.huibo.wang@amd.com>
 <51f8c478c5fc09b3bdeb8329c682a01fbe0ea5db.1777048608.git.huibo.wang@amd.com>
 <c1e1f24e-3407-444d-b17a-9c543d8d3edd@amd.com>
Content-Language: en-US
From: Melody Wang <huibo.wang@amd.com>
In-Reply-To: <c1e1f24e-3407-444d-b17a-9c543d8d3edd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::17) To PH7PR12MB8106.namprd12.prod.outlook.com
 (2603:10b6:510:2ba::9)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8106:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a52e88-2f38-4da5-9926-08dea579f521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TKfLuJiznThgeloUfBQCmhoEJb+iMIvuwBoiwM2WXtvfbnUp4TdbOGps18YX9h3rM5+pweeqo6gq5VOT3GR2YQs2bFPbLHg58+C7yLhyIRfOuTV60b50HwUmhB2S1gPuO34rZXjSQ5maCZNKpE8lNgZXWWPlB0b1lPMlQYVhTG2iRQg2FTtvG6tJ9qWLozmyUBi3ua8WvK8vLcK4lEHUhdtdpAdFs30g4rBH3qBUADiU/CMpqEQ6kOBPcuF96KCO0gGVDx369qoWKE0L4vFH3GlhS3LprTNwRc9+pVKGfBkKuZ3/pkbicKNjro44b+SawsP4Op47EuUiFkARQ3BnzVzahzoPov2/Qjrhas2efJDBo+TIOiX6egOWmdXCq9DPXL1vIog/1pTD1ulp3r30obYlZ/F5gObyjyBDqSXBrowUpl+9pa4748Kyf9TnhmdlKe0xpYjdOsCQbaAFs57uzEmr9yeJi2cX8Nq8jeICBtnUlPf7duGBf5RfqGAzpOIWbL8DoMmkJQ2UMosyD2hvt1/xlf1Ig0rbEcAcfhj6MjXPtplNawV0WFEcHJhcXYiufq0o+9H9p1DCK+ygE9Tvmv8xNYQ60BKXXwDAoH2bjlSWBIAUpOIXtR8tmDkWiV/0cZfjvbbJ5SI1Mm67pV6U88ouP1O1GBrjDa+TL9DrTxwOvQ0p4NJKczvoJUlK3/Cc/Wzlleh4sJYPiXCfDf9icpMmHnersiQtGBWsQIRzGhE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8106.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGovc0czRkUvK3FybG50Y1RqRTRkd3VFTFZ0QXNzTVlXcUFpeGxoU3NUMmkv?=
 =?utf-8?B?WFlzYlAvRUEwTkV1RVYzdlFqQ29VY2R0eTB3ZmszcmFyNEkxVHEyUVExMldz?=
 =?utf-8?B?OWoyMVRwS0IvK1BPbjVjVDZOYTZwY1ZHb2I4NFNFOXFZYzhkVG9FU0ZoRnFP?=
 =?utf-8?B?R3ZJcUdGQnNaRmFTOGNPNWNaeVBCenU0V3VIamd0SVRxaTQrYW9sTVV6MkdW?=
 =?utf-8?B?TDhuV01KUkFpdmNDU08wejZncUpUTmFkM2RhNS8zR203MXgwN1dQaysxMFJu?=
 =?utf-8?B?RENSM1l1dEhTOWJ5cXBRVHNyLyszYTVPSnVFd00yNjBMN0NSeW1YbDBjVThi?=
 =?utf-8?B?Y3BYYWo5MnBGcUVFNm5SelNoWUh0YVgrTGlCYWZRL01GUVlWTmxFclBScFpX?=
 =?utf-8?B?cnMvMzVIbnRRZE4ycy84OXVqSnM2SHIxWG5wU0I4bGVjOEFOWjE3VkQzUVVU?=
 =?utf-8?B?eFFEald0NDg2K0dHWXlnUUhRcUJOcVVad2ZmY1p4SmVlRHJodFZ4a2ZIc3Bu?=
 =?utf-8?B?eHlkVFFLa1ZhT2JwM0R0djV5OGFzc3hwTmErMXFUamxIZUJ3K1c0UVZtWjQ2?=
 =?utf-8?B?dWovT2dZUHJ4aWJBRGVuRWJmU2c4TFhQMG01dHJ0OXcwdWVyMnh2ZUN4ekVw?=
 =?utf-8?B?QlNtL2pOWG9uSEhBbDYxK1c1V0NuQ0hTUG9MeTE4ME5aVVAvQ3AvbjArMExK?=
 =?utf-8?B?RldYM3I4VU1mTjFwMTB0ZFFOcWYzTmJ6M0V3R3FOOWFPUTc3SXZxZkVuZ1hX?=
 =?utf-8?B?d2pYY3J2c25jTEZOemZXWlMwMmJJUU5KNEVEemY2SUdnQVh5eDZ6N2daZ3NY?=
 =?utf-8?B?MFJJWDZzbkNaQ1hOU2NENmR6VjFJWTg1QzI3cTlCakxkUmVST2w5WVpBc0Mr?=
 =?utf-8?B?ODR0SVNJSko4RDFiTStIQzBON3pFYlVGT1gxWVYwdjROQUZHR2NVSHdiZjMw?=
 =?utf-8?B?L2V1djF4Z0pSUjY3T3RzSkV0M3ppWTk0b3lWTzJyRHV6b0ExNVhHY1dmcDh3?=
 =?utf-8?B?UHlxQWJHRjVhanM3c1dDVHBhMU5XdGtnYURzangzblR1NWd0aG16RTRJb0NE?=
 =?utf-8?B?ZXBQTStpbkcxSlp2cDk2dWY3clEzbU5waENaT0JDaXc2QVdVZEFmUUNnZ1gw?=
 =?utf-8?B?R2NZUjFuQ2Q3b3BwbmJoN3BOZEJvWU1TWW53b0lXY2E2VWRKS1RxK0hZa3l1?=
 =?utf-8?B?Z1R0dGlFUC92QXhnMy9iVU5TOFdvUWlvQ2F0b24xNEI2TmZaUG50MVNyNkI3?=
 =?utf-8?B?UEkvRzJJSUgydEhDYitBU0JzNHBHOHBzNDNHSVM0QUo2ZVNESkpvamhwWEhO?=
 =?utf-8?B?dEd6ZTA5SS81aWdSZWJ2RUhxS29qWGdRaFJPTW1JdU15M0dNb0oxeWN0L0FR?=
 =?utf-8?B?Z3lwQy9QSHV5Rk1MZ2tXdHU0aFpoYmdPcUpJK0wzbXU0NW9oZjNyaW94Q3Ja?=
 =?utf-8?B?c29OSmk5RjI0RGhIcTFYVjZZbVFZMmNLcU5SSUljTXYwTFhleHR6TXlxVjdV?=
 =?utf-8?B?OTVWTkJjQ3JNN0ErUUpCaEFEY01wdFRhanNkN0cwamxRd0VkNklxd2dhOUtK?=
 =?utf-8?B?N0NJU2FhcmpFTTRZbjZQMnN5TzNzclVUMHcyUWRObHRodFpxaW4zbUFuU29z?=
 =?utf-8?B?R1dPalVERkE0NWJXVEhXZW1wNkRtOXpWbWNDNjVyUE1lVTdsSFdDbnZkemVD?=
 =?utf-8?B?WTVuV2t0dEFhblNUQ2tUNlF4dmhmTU9nZ0JNTHFnU05DNzlWMVFpNStmc0dM?=
 =?utf-8?B?MlQ3TzNISVhBbEtTTlplYXl2ZkpCcithTVY2aDFNcWk1eVNEY2taalA2Q3lJ?=
 =?utf-8?B?T1B3MGRwa2NKWEZDZThXSlpaNXdWTlozeEJzWmtHcVI4ZDliWGpnU3NHVE80?=
 =?utf-8?B?eEZtZGszb3N1VkRwUitCdjhkdzNmSkI1M2tPYnVDRW5kZ0c1QjFwMUE0Umwr?=
 =?utf-8?B?aVZlN0NGSUdKVEo1VS95d25ieElDYlhiU29XSkdkd0hMVS9GVlI2S3VLY1hw?=
 =?utf-8?B?c3NobTN2d2QyM2l0RmY1MTh6R2lBQ2hYWXlNUFRYYlpPc1p0Rmprd0d3cEpF?=
 =?utf-8?B?VnRYeE9JOC9PT0xKdFpuWlJUQWpYb1JnOWs2bS9QbFZZNHU5aHlJTXdaMU5R?=
 =?utf-8?B?cWZzbUVySUIxbGxsYjJkNDMrcjduU1JTeG1tdEtZeHZ6MDN6SmRFSHAwNWFq?=
 =?utf-8?B?L2Y4Z2dWNDhPNmozb291V294WXl5aEtiS05yRWM2WkdFUDRjd1ViTHZ0djRu?=
 =?utf-8?B?WnZBOWQ2ME9pT3EvaDEwN1lzRjlGTlN0OGFVYTByeGFsa3MrSXlzM05QUUkw?=
 =?utf-8?B?WmF6S3hKNXJnQmJKb0xmdDFKaGhyUzJRaXJJWmZhR0hBQ0EvZk9XQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a52e88-2f38-4da5-9926-08dea579f521
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8106.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 23:00:35.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqE2PsAWcBS7aBExZHtq1g0vF4IdyQKFg7eiOwdIDHv8lmGtZb1FsY2J7b+Yh+04z6y811TETLQncTaasy6TCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327

Hi Tom,

On 4/28/26 12:24 PM, Tom Lendacky wrote:
> On 4/24/26 12:42, Melody Wang wrote:
>> When Restricted Injection is active, only #HV exceptions can be injected
>> into the SEV-SNP guest.
>>
>> Detect that, and then follow the #HV doorbell communication from the
>> GHCB specification to inject the MCEs.
>>
>> Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Melody Wang <huibo.wang@amd.com>
>> ---
>>   arch/x86/include/asm/kvm-x86-ops.h |  1 +
>>   arch/x86/include/asm/kvm_host.h    |  1 +
>>   arch/x86/kvm/svm/sev.c             | 16 ++++++++++++++--
>>   arch/x86/kvm/svm/svm.c             | 17 +++++++++++++++++
>>   arch/x86/kvm/svm/svm.h             |  2 ++
>>   arch/x86/kvm/vmx/main.c            | 10 ++++++++++
>>   arch/x86/kvm/vmx/vmx.c             |  5 +++++
>>   arch/x86/kvm/vmx/x86_ops.h         |  1 +
>>   arch/x86/kvm/x86.c                 |  7 +++++++
>>   9 files changed, 58 insertions(+), 2 deletions(-)
>>
> 
> 
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 61e1e54deb07..2483357bdd97 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -5371,6 +5371,8 @@ static void __sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
>>   
>>   	if (type == INJECT_NMI)
>>   		hvdb->events.nmi = 1;
>> +	else if (type == INJECT_MCE)
>> +		hvdb->events.mce = 1;
>>   	else
>>   		hvdb->events.vector = vcpu->arch.interrupt.nr;
>>   
>> @@ -5386,6 +5388,11 @@ bool sev_snp_queue_exception(struct kvm_vcpu *vcpu)
>>   	if (!sev_snp_is_rinj_active(vcpu))
>>   		return false;
>>   
>> +	if (vcpu->arch.exception.vector == MC_VECTOR) {
>> +		__sev_snp_inject(INJECT_MCE, vcpu);
>> +		return true;
>> +	}
>> +
>>   	/*
>>   	 * Restricted Injection is enabled, only #HV is supported.
>>   	 * If the vector is not HV_VECTOR, do not inject the exception,
>> @@ -5454,7 +5461,7 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
>>   
>>   	/*
>>   	 * KVM only injects a single event each time (prepare_hv_injection),
>> -	 * so when events.nmi is true, the vector will be zero
>> +	 * so when events.nmi is true, the MCE and vector will be zero.
> 
> This is confusing. I think you mean to say
> 
> so when events.nmi or events.mce is true, the vector will be zero.
> 
> correct?
> 
Yes, I will update the comment.

Thanks,
Melody
> Thanks,
> Tom
> 
>>   	 */
>>   	if (hvdb->events.vector)
>>   		svm->vmcb->control.event_inj |= hvdb->events.vector |
>> @@ -5463,6 +5470,9 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
>>   	if (hvdb->events.nmi)
>>   		svm->vmcb->control.event_inj |= SVM_EVTINJ_TYPE_NMI;
>>   
>> +	if (hvdb->events.mce)
>> +		svm->vmcb->control.event_inj |= MC_VECTOR | SVM_EVTINJ_TYPE_EXEPT;
>> +
>>   	hvdb->events.pending_events = 0;
>>   
>>   out:

-- 
Thanks,
Melody

