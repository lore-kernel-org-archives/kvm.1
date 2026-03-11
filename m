Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A8331205;
	Wed, 11 Mar 2026 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236588; cv=fail; b=kCm5U0pZvWdK6s03j5lntBzNdeemKzC1iqWNLrIQ4+1zaX6tK+PwapE38Ugbzf1SjGFktHLk7VZfrJmuPvHpAHXHEIGe4abv2lKzARsPCYTJb9q6GGEXy4F744nGfw/YuUzERUmFEnJnXpVM6+vFKUAd9lNeh3lR96aPVrl0/2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236588; c=relaxed/simple;
	bh=1Qo4vHE6nZzJFodmIdyH61lMPeaTpB4KNjCjfPF9So0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qfhkAtMAvO+fp9tXTSeggUyRL9t0/WAO743h6zXRTP8SzUhYRGn1girQFeMvWmylMYLnLG3gP2Y3jVJkfTYui9AwEGd3l1+muFemCNGxJivsz1QVzYHqNLRw4kNkyMjl8ulIb+PAAWn0au8cwUvidDejPu8cXJ16Gd2gEdS6Rpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2JVxskHP; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2JVxskHP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrMA2AQqKKjMR3yY9N+wfisotpwCwQIzqFBLrHNesTcqPZo43jWpB+NeE9HtNc1X+2xzCe2Lf45lAN/ELIr3OWAeTbvFZ/TNEoJU4dQ5uJBoU05s7ZqqcH85fig9xPf2V+9KxnZa0tZISo7jEAbKrIrPIPUkSQc3VNqZJq9PKra4z3EbmnVv8ynf44hWziESfRUhk7l4WggQTTjbXELHxPq1FcI+cKmbmPoctteAJZ0+H/KayxTlcgsV8Fg06q9naXClAYVtyXNyCLX70mrP3lgZsfmVjjJMqR/aF0b/01xitaqwOX72HuhsfW07y0xHFI85VYZkYUETkhT7RcQfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkyXJa/bm2M5fexD6+EvUzxf2j2ZVAbESvz77hWn1Pk=;
 b=GW2K5GvM+Oq+aR2wpLHSo0eu6UNueQiQ078NErBEAzmi4izpd64dG0MK9DTS0vEmM7pH6911j7eks9zxl4SYlmuXGbgua7nSYw79tq2A0v5jB5ISEmFafluVu2lTDXCbXvpN4t6Esv/uwM9Cak7dKrk+P4QGM8oAKqHqy5XpwJh2A11b4jgojGefHD9MlGp97a7eR64T4rAHYivlmsy5oH/bQ8f9pQOzivDNRnVGmTVRxgXe5QP/jwzeqsxeLCnT9RO5ZqOUOJzMo9tUH1GR8KXnZoSNmIzUxbxKNrT2/nby+o8gKCTwnaoYjkGiTEn3NSY/zE2u/03duSwsGFgQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkyXJa/bm2M5fexD6+EvUzxf2j2ZVAbESvz77hWn1Pk=;
 b=2JVxskHPhEufScHMFah6PCkyADAnNql95Ezi/T/UDWlBM0DDsQQo1tjGluF4iPi7tou1FYhkwejr5OcNKojF5Bkj+FuTR4/xIWlmtLMEGyIliOsNUiEnr7qAEoHE4LdfOxTaNW+n8zqgwYMNC5v24PB92gh3UDsOChN+tE9+s+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 13:43:03 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 13:43:03 +0000
Message-ID: <a0aec477-b422-4557-b243-f0abf9edcae9@amd.com>
Date: Wed, 11 Mar 2026 08:43:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: SVM: Set/clear CR8 write interception when AVIC
 is (de)activated
To: Sean Christopherson <seanjc@google.com>
Cc: Naveen N Rao <naveen@kernel.org>, Srikanth Aithal <sraithal@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
References: <20260203190711.458413-3-seanjc@google.com>
 <19935696-36cf-411b-af90-aabe6a98d7e7@amd.com> <abBSPkKmMiFCfKek@google.com>
 <947bf241-d149-4933-874a-de96aeb73dff@amd.com>
 <abBYiODdL4405KbB@blrnaveerao1>
 <debf1c3f-f0aa-4b9d-ba35-feed87aa899e@amd.com> <abBkgY9W4_PD1uef@google.com>
 <23ec6b06-96b9-42aa-937a-908b2ce73a69@amd.com> <abCT69PvxOo9ERu2@google.com>
 <dc6809fb-ef44-4fce-b98a-bd80edf7d64e@amd.com> <abCd7FfaG_UvVz6m@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <abCd7FfaG_UvVz6m@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:610:cd::28) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 6852f26f-18ed-4226-4fe9-08de7f741e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EhY2mWAbRYCNM4e0ix+4t9ePEZmzWqVKWTs3+0g3wxyrW4qGbdn9uKiy1DHuGNQklXN0c29Ub0VHKSldVBvT8dvmX7KQd91YeyVA+7O+YLMS7Oz9yEBQ058ByN1XUu11pE3szRh9arTPcqMw0Zc8bifSY+4HfB0UpALbicaxSEyxeq4KSj8c6K8fxrNuxRu+QAxH2CfeU9BIU02z41nvU452UgoQhwzpcm0ebl1xicAUCzeY7iHsiTli1v1UN88hFJ0cw+14SiR0BmSmcPvmPwo2aMAiVveHs6PObq/m9K6K/OGxiQgIbU5Zt7pgVUNWgJxyamnbGSW6M6tFPtdcHzMs4SsNhfRrc5PsqeiU8wLNQxXpKF6MxgzfCb4ujxNsyB6Z1u4DZGItb6TVxoqYAxk9Mn+b2o2PC+/mP9Qh52Bc+kV1yj9GE7/aciSKvV59n7V05Yb2Ya3yPOSNJTRmutDzuJktgAWExENvHltFP064IWeyotpolnzPcObJbvUVsYp5i4rrITDO0C9/oZunF0Zq7Kcvi6dBnld7xZ6TWerl2uOYHGq1oMoc/9mgEv3KpEytsjBfGuKv2is1xcoUVOKms0h5rAhEjC2Rzx/wtm6YL0SckPmedi5Yeyyovc+95pQllKfw97XjSeUcL2atE4vYR203gvyLOVfExp7SX6diu/V1BcN8ttDwCb3aJO7wD3jrU2V4M1QfbN2sau4KTfN9nPlki91G0WEdg+9BEcQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2xFb2dTRzFlVzNYSTNlY2RDbWh5eWhQUFJhZEV0ZnUvUTArc1NXeXlwNU9U?=
 =?utf-8?B?aFFDcFJQSWNYU1JGSzJEdzFFREthRmw1UVhEVmo1NHVLMzl3Q1VxNmtST2lH?=
 =?utf-8?B?dnlrenpmUjBlTG9nUVJwMlJuNGswUkxQNG5KM2V0V3hSUVBQa0laUEtrd2pD?=
 =?utf-8?B?OG1KTCtWa044KzFZaCtSYjl4eUJSb3pEYmoxUFpsd2Z4WVdWRTB5NzI0SXVT?=
 =?utf-8?B?YzhrMkwwZzdYSFNzV3FyWUNKSUZNSGJZeXpwT2MzZ2FKclI3M01kR29KVkFt?=
 =?utf-8?B?RWhrbUlibm1scXdsd3JGWjV4SVA5anRHakwzNVh5YnVPS2lvN3pzYitOZU5M?=
 =?utf-8?B?cDI4aCs3dkg3TTZncHVIcDlNNWxxQ2M1QkU4b2tRSitIMDBLVjJkMWg0SVFI?=
 =?utf-8?B?VVhIWTFZMjBlZE9JTHFTY2c0YTlwdXV2c3B1cml4aENnYldvK3NKM2xUV3lj?=
 =?utf-8?B?OEhhWjUwNHAzVk5DeXFnRE5kZy96b0JwOVpYU3F5blo0bnd1bDlBelJUd2l1?=
 =?utf-8?B?YjVTcTBSaTlMaHI0endMbnpMY0d6WkJkZTRlM1pwUnNnRVIvOFRsUTdwcDQ1?=
 =?utf-8?B?M0VRa3NGKzlYaXNZZ1h2L0lyb0NIVFhqL1pHYTU4bnhJZ0NaS1lIZXdGcUJI?=
 =?utf-8?B?WmdlaXNBeFBQNkl4Lzl6TlhDKzU3cUFrcWVxNllZTXplQkttWisyb2hvSDJO?=
 =?utf-8?B?WkF1aGhvSnVRbk1DY2FjOHVVS0pxLzVhSlVyMzRLamZvSGxHM1VpMC81M2lK?=
 =?utf-8?B?TUtSNjVnTmZhSXY5ZDhubVRyNkJubmxPOTMxVDlRUUdHZnE5MVpJOE1uL1R3?=
 =?utf-8?B?OE1jNFRnb3Fud1hYdXBvVTdUSjBUdDBhNklUZnBDVzdFREhQbGRSUFhhK1J2?=
 =?utf-8?B?Qnhickk2VUVYNFJiT0x2M2s1eW9udWVGR2t0VEUybWdMUmJsbnEwNGZFdUlC?=
 =?utf-8?B?QjRrT2pCRXRjQnBhMU9BTGFHUS91TDZwZGw4dm15emV5ekEyZ0NoQTFidGhD?=
 =?utf-8?B?bXlzckJHTzI0alFLR3pPc3RNcmpZK1laLzRheE9PcmtNZ3N5N3ZtOWFyOGky?=
 =?utf-8?B?REtTTUlqTStzc3owbzZUNldYdEhBZHlRWGYvQ1pkNjZha0RZVUxTS29OZlNM?=
 =?utf-8?B?TVltcnRvakJqSldETTcwcVlGK2hhWFMveWU1UDZwa3Rmd2hQOXJ0QjNqaFRX?=
 =?utf-8?B?aXBYUVlDbjlNK2k0Q01VZ1EyVW1ha3daMWZHdXV2cHNPTTg4eUJGZ3FoS3NR?=
 =?utf-8?B?Q2RFNnd0ZDR5OVRkRzVWZ1VLK2IxM0ZweVpkZ2xUSmtja2VIcVdsZTdFc0dv?=
 =?utf-8?B?bHJQMTQxQ1lwdXp4Wmhxc2VNTWhFaW5TN3lZSXB6MXdPQXp3eUlYV0RsblhN?=
 =?utf-8?B?RXY0TDFjb1N3R3ZwZnZFalJIK3BpYXBoSXE4ZUhRQTMyL09KdTRSOEMyL1Ni?=
 =?utf-8?B?UExjSFYyMTdBK1pFS0xQNEgrWkx4dFhRM1VjdkZlNStGWVZzQ21IUlNBMzE3?=
 =?utf-8?B?S29IcFNDaWtXd0dMZXZJSzlWSVNpR3dsTDRwa1RQUnFWUk1xaWVJTkswdW8y?=
 =?utf-8?B?WFVYZXdFMFNXekZ1Uk9jUkgvZGFEZDhsOXhyeFNVajlzUDc2ak1abVY4QmZz?=
 =?utf-8?B?bHlnbGVubmJzZklyNk5JUnJzdVJVZVdhYWRDelgyR3duS2lNZHRLd25wNDQy?=
 =?utf-8?B?MzZlbGJ0eE9xME1oam51Q3RmSzNlTmw2d3RFNmg3R2xrUVJmUkxDSWFMUk5K?=
 =?utf-8?B?bGtxeTVDZzd5TnhBQTFhQlhkMXJobTVmNFcyUVFyUUp0M2JzWjgvQ2JZbWVm?=
 =?utf-8?B?Ui9kSlhhYXBQaG9vSm1WcWJINno0RE4zUXlUZExmZ0N0RGdHQmh2SHM0OFJI?=
 =?utf-8?B?OFluOStWbTh2dTVzU0dyNGRtSzVnaHBoRWxGOEtZZnFNay9CVWRnaUFPNW4v?=
 =?utf-8?B?eE1vNlBBQzNMcXhVTDMxQmpLeHZoalVoOHRFU3hqalJxUXRGNDIvMnUwMEo0?=
 =?utf-8?B?OHJERmpUaTVrZUJWSy90aXpGSmZkTzdIZ3FSbXZhQ0I1R0NGT3BFZjBKTGpY?=
 =?utf-8?B?MFF3QjVZc3h0KzYyKzFWcnFWeVgrK2duSkUzTDJpT081RVhuMXd6QmNOTTQr?=
 =?utf-8?B?eDB0SUl6NzZ1Y0g2UFNlYnpEM3k1ZXU2Z3BoU3R3Z2U2UGIvQ2svNlBrU2Fh?=
 =?utf-8?B?bEZRNUtqTkZuTGd3QXZpMFI2R0tqb0JKalEycVJvY1ZSd1JneUZDbmlKYVUw?=
 =?utf-8?B?Z3FIajdITStOUnBabnhHbzVUeXUzVnUyNEdIZUEzYlUvbDdTQUw0Z2hCQkVF?=
 =?utf-8?B?eWlDejBZTnhBNEJnMGF5eVdoay9JY3pFNDlDV29pSEtYUUtpMmdidz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6852f26f-18ed-4226-4fe9-08de7f741e2b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 13:43:03.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehJ9Co4YT/QjYnTM/YlrR4K1lrRqsF8ZVKed8WMRC4n7NlZ/XSmz8BXPC3+4Ck/V+SBZCMX1aiLLkZYxVEXMFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

On 3/10/26 17:40, Sean Christopherson wrote:
> On Tue, Mar 10, 2026, Tom Lendacky wrote:
>> On 3/10/26 16:58, Sean Christopherson wrote:
>>> On Tue, Mar 10, 2026, Tom Lendacky wrote:
>>>> On 3/10/26 13:35, Sean Christopherson wrote:
>>>>> On Tue, Mar 10, 2026, Tom Lendacky wrote:
>>>>>> I'm just saying that the unconditional trap for CR8_WRITE isn't flawed
>>>>>> for SEV-ES+ because AVIC can't work with SEV, so there isn't any time
>>>>>> that CR8 writes shouldn't be trapped.
>>>>>
>>>>> Yeah, I forgot that (obviously).
>>>>>
>>>>> But sync_cr8_to_lapic() is very broken, no?  INTERCEPT_CR8_WRITE will never be
>>>>> set, and svm->vmcb->control.int_ctl will become stale as soon as the VMSA is
>>>>> live, and so in all likelihood KVM is crushing CR8 to zero for SEV-ES guests.
>>>>
>>>> I don't think so. V_TPR is written on #VMEXIT even for SEV-ES+ guests,
>>>> and since it is a trap, CR8 is set and so V_TPR should have that value.
>>>> That would imply sync_cr8_to_lapic() should do the right thing.
>>>
>>> But isn't svm->vmcb->control.int_ctl stale?  Oh.  "control", not "save".  /facepalm
>>>
>>> Ah, and I assume Secure AVIC hides vTPR from the host?  Or at least prevents the
>>> host from setting it?
>>
>> Secure AVIC will prevent the host from setting it since the backing page
>> lives in guest memory and is encrypted/private.
> 
> What about vmcb->control.int_ctl though?  IIUC, that's the source of truth for
> the effective vTPR, not the value in the virtual APIC page.

For Secure AVIC, V_TPR from the vmcb->control.int_ctl isn't used,
instead it is saved to and restored from the VMSA. The APM should
probably be updated to be clear about that.

> 
>>>> After attempting to verify this behavior it turns out that writes to CR8
>>>> (and CR2) are, in fact, not trapped, but the APM was not updated with
>>>> this information (I'll send a patch to remove that code). KVM's CR8
>>>> value is, however, synced with the proper value through
>>>> sync_cr8_to_lapic() because V_TPR in the VMCB is updated on #VMEXIT.
>>>
>>> Oh.  Huh.  So doesn't that mean that supporting Windows (or any other guest that
>>> uses TPR to mask interrupts) as an SEV-ES guest is practically impossible?  Because
>>> while KVM can observe and manipulate guest CR8, KVM won't be able to precisely
>>> detect when TPR drops below a pending IRQ.
>>
>> Could we do something with virtual interrupt support? Today KVM uses the
>> virtual interrupt control to detect when an IRQ window opens. We could
>> do something similar by setting up the virtual interrupt priority,
>> V_INTR_PRIO, at the level of the current TPR/CR8 level. When the TPR
>> drops, that would trigger a #VMEXIT and allow the pending IRQ to be
>> injected. Thoughts?
> 
> Uh, yes, that would work?  I was thinking we couldn't model the priority, but
> obviously that's not true.
> 
> FWIW, my preference would be to not add support unless someone asks for it :-)

Agreed.

Thanks,
Tom

