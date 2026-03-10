Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDBA2AF00;
	Tue, 10 Mar 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166380; cv=fail; b=k8BzyJRRZ8GKxidXynAMyDvDYKowX2oIla3WHAcBIgr5y/DE+bOoMb74uP0quknZtwEZXShFgx5M3+QSZ9fZ60oK82jGPfkAOVTP4h8E4OmQDXRYVjZsHET0Un1z0CTsO+YY5Pu4igkgz1+97uF/NzoUSr5Q0iSrW2QJdubq5Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166380; c=relaxed/simple;
	bh=Do3BC2J2NtrQvnilYVZTQ7OZaHOzRzVO6amO3/NgPK0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dRPofATNvGvY0qekBlSZPK1THrR3CKQ/oQEIy48F7Jj2N8dkFgUbtzOszMDAhDAjeSk3MGNEYij6X2L5GEojVP0V57/0DwDSSo/EIFOlLYM9+7cS0vU5KyocSrt4ND/81uNGtMwLsKO0lkkRcQO22Zp47z6Vz6tOPW7ns3fu4WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vsojaHF3; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vsojaHF3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phj9Y8vzSW+vhqIcWXRCbQ1Q6R+vKWfSCk/UJVL7/N/yp5gZwNakpZyMNfe3hSmloOxgbVRYTTCQ7apcrdZLudIxNPDlpI/x80Xj0nFpoDoOvXgCu1ZXUPIFOqLUUlLpcR/rL0ajyN1Q3s+3QPwMl1B71LIepQDNeH84SMCeJyS3ZYU28QTjhxVzqr2ZAAImuECY4A0a2p1ejosLRyoVxR5OvK4hPmOSO4el2FXJKVLxLPEzhKnn1Q2mvJd9O3mSiUADtdTJYkma0JtcuC+eGWsBCYxGjBGzDoJ6LkuN1D103bXRhv3/PfOqMDuxVoK9oDaPA1I014rx+BBIxkJqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqvq70EOMvCSdkToHwwUIiKb0eMu/Qh6dfqPELAiaBk=;
 b=IW8E9YLm+4zkFpjA2wKa/H1HmhOpbwwi+ULdWM71iyAZv6Sek1BQScWc3ZwWf9tRhZ5SP1MkrJvTYG/oIztKbx7844jB/rmGZAU4jcEdXBYDBegIKi2HQUUmk88Crksyr0UhckzJX7lOD6IdvI1WiKB26G2i2bxZoXwRVO1OOvF8eAN8mzATCq24Lrctkh2bCVC1EDhAnfbUJhfZVF/8pIwvijiYVsBGptwGJEHAodqMd5IHIJj2lYPBGtCsCVgtVNlI/mjejQz/oFAXcfIj+MzheFXC/I0NUZkj8jfKm5qe6JAudWxxDy3NA0/IA9QlbwA1Z5LUFOcCsOTu9XygTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqvq70EOMvCSdkToHwwUIiKb0eMu/Qh6dfqPELAiaBk=;
 b=vsojaHF3nTGlyZVrevSQY9FGPt1V8oCcI66RKwc27+B5pg66YptL/5MrmVUxrBHfZf5NJ0Nf8dc8ybTfAinNzrIqgMpg47XxEGHPvuSh/OuBCjmfLBBlFcfyrZYenOL7QQw1US7VBR470W4gQNCKjo2/eEWzoSyR59YvEiASdzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 18:12:55 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 18:12:54 +0000
Message-ID: <debf1c3f-f0aa-4b9d-ba35-feed87aa899e@amd.com>
Date: Tue, 10 Mar 2026 13:12:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: SVM: Set/clear CR8 write interception when AVIC
 is (de)activated
To: Naveen N Rao <naveen@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Srikanth Aithal <sraithal@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
References: <20260203190711.458413-1-seanjc@google.com>
 <20260203190711.458413-3-seanjc@google.com>
 <19935696-36cf-411b-af90-aabe6a98d7e7@amd.com> <abBSPkKmMiFCfKek@google.com>
 <947bf241-d149-4933-874a-de96aeb73dff@amd.com>
 <abBYiODdL4405KbB@blrnaveerao1>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <abBYiODdL4405KbB@blrnaveerao1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:610:b2::34) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: f8932211-6e42-40b8-918c-08de7ed0a690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KNBtV5bGuMsUn59cdTLThNed/xT3dmKi6ndcvAnrf/ZF/XW/2lVtrw9RZrr3jmnS6+I7f6AWePcvXI/WaUivzljFeOnqPLZnAFsTPyrLr8WBr4YPq3lnIQe0rm3XOuHMr78FV3JIDrKMXxAYTZ8uiJA3+XMKiaFxPRaAHCpeVC88p8i4P+Q+CZcVam5/tzkQ6XKfVODvrxnxBTMmgBhTjM7n8HQKTFkZ+NrO8JrSO8aVMOB0c0X1R/Z4FTMKk1+s5dwNeBIu302BlL91S7dNl4Q3uOFpXTGn43dmA0O7JzbdGNc4X07K3lyOo+P6mzX/Z3yalwMvIYKujKNdgq3A//wstjBPTuD8yV/PkObV7pfGJiDj0KeNqczPTZ2+SLJ+4H0CNtMutf8iUgDAqZaPFA3q2jfRJjppmITkZmDbK/kXmnFMNAi7xwbQME/J7buDGUUTUGQqIRPjJ3YJlLG7DeiNwfr3FyNuUXmsX730bH4BIglEgtDSnWeSSfDgqko7yVsBCh+Zmg3c1Fh8qS5a1VYKDPobqZeCOXdA8KBh90p92eKpx9EZCtxjirFrrjpt/3m8rEstd/fpK4P3ENRztA7TsxdDq8NDO5YljjPI2VggHEj4YVy+TjMoJU9e00BGiEhE7lT668V+006LmYTPUnQoGq9YWpGzH2K2udoX1YgEez8Dru93kAZy9BvKpltDlSZhbK6v51I+DpVtYyXEi5S+y31nB/T03pfhfay0n2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2hqTjBwRnRQUEpyVVFIWXRtWWhnaEpTb2ZOMklSdnFlR25jc1hlWERLd01h?=
 =?utf-8?B?MU1Xa3hKTnRsVngrL2tjNzlKR29yNTVZT28rdndkZlBTNzYxUWtCMlpRbTRj?=
 =?utf-8?B?S0c0THQwVVJVTFp0blJ1R1h6cjJGM0hKc1FLV2lCdENMQmFZVkVFeUNsb3pT?=
 =?utf-8?B?cHV3YWNlVlZTMHdGWmo3aDQvcEREVVlhdUVpWmxaa3NGNndQcUR6VHE1UFAy?=
 =?utf-8?B?RlEycUFjNjN3dHdXc29WdGJXYVIvVDBMamVESmRsSWhlTktXN2RLQkc3c25v?=
 =?utf-8?B?cTBWM2N6djRuWjhNbEh0eTNrc29tVnhVb2hCa2FGU05OZjBmRHU1SzBBMWRQ?=
 =?utf-8?B?M0hRcHRvbzdndWROS2NRUXhqYUNvSTBwTTNRU3M3UkpHS1paRjRVZzdRRmpN?=
 =?utf-8?B?UXV6ZkJGRS9kN2hrQnNIU2hxZVRhNjhUL3U1TVkwZEtpMG9nL0RxTGFoMGVO?=
 =?utf-8?B?NTVPQ3hEc2oxZndreER6L3BVbis0WVorUGpPamJLNzVhTkhMK3Rpa21WZGY3?=
 =?utf-8?B?cVFTdmVWUWYzZXRGaXVpVmZyMSsrRnYrZTF1ZVFyZEF4MU5HbWYrRkV2cWFm?=
 =?utf-8?B?eTMxVkkwemVMVkVNNTg5NzladjNYNnZMSFo0YlQ0TStQSE4vREJia28xeWZY?=
 =?utf-8?B?dUNFY3B4bkNRZEwwZUoyckdrZ0tMZ3preU5Wa29rcW5aYXlEcHh1dVRTQitN?=
 =?utf-8?B?MzZMdWM5a09DbnhMb2owWkFuazZ1c2FDcjM4aXdjaG95b3Blcy8yUUI0dlJ2?=
 =?utf-8?B?MjZDclY0UUE1S2lhVysxRWdldzhlU0JYdWQwTlZXT1JuUWpnb1pzdE1DUE9E?=
 =?utf-8?B?ZlZXaVVPaVpSR29LOG1SWlpPNTBnMENyVUtxTy9vRnZoejlOZUxybXQyd0gw?=
 =?utf-8?B?bWJGb3phcnNZdDVhaTFsZkhKekh0ckhXN1R5RTRwUm1yd1BaeGt6K0VJRDU2?=
 =?utf-8?B?cjMrV3NXYWZYTjNBdzlaSitKMVk2Mk5JWlBINjlhanpoclNaNFVTSGttOXRn?=
 =?utf-8?B?ZG93cTh4TTJ6QzF2VW4yeWp5bUNRZ0g0aEVkZ2QyZTN5MDE5KzI1UGQxMmdF?=
 =?utf-8?B?MXVSY0x2amo5elRaZmlJak13NmlsSWRoSXZJSDRKNzBPajBLTWR1eDl0QWFE?=
 =?utf-8?B?dXNLWm9lbjVEZ0VVc2tibGw5YlhMTHFTN2ZDcnVDbHh2bklZL2F6RXdjWFc3?=
 =?utf-8?B?UmxwM05oanJGQlkzZStZYXVEL2dDc0RXNU1ISFI4OTNLM0pJZGNwTFQ2ckFK?=
 =?utf-8?B?SnRzUmYzNVVMR0VXQjRValNUMkljSXlzdGpMUDRGZUlOdjRJdkR6Z3Nlb0k2?=
 =?utf-8?B?VzNiK2xkcGEyd0d4MDI5Z3lLTGowUGR6dER0d25vSk9BVWkvU2NZNVZVT3hj?=
 =?utf-8?B?em5yWG84ckFGdVJYNHR2N1dkR1NwdFRUODNVVHdPcTJKR2p6ekNRbE9GU1p2?=
 =?utf-8?B?TndMKzFXckI1L0N3YTBCdXordDFhVzc4dHp4dFNMTDhRbDhTdnRlRW0ybXdv?=
 =?utf-8?B?R1BuSk1KQkIrcVVRemJScG1VdUQ1ei9tMHc1NVpYRzFlSWNreDJoQUViQjJy?=
 =?utf-8?B?SnlXRDFVSlVWYTB6WW91RkhQL2JFejJiSHpVaWpVcjNkK0tqcWZqdjdncERJ?=
 =?utf-8?B?SnAzN0FKRlFBL3RDY2hyd0lEbWFZZks2OUlhbExROHcwS2VFdGZPWWtNMkRv?=
 =?utf-8?B?NkFZc3B1ZmwvMENlb0N6dm9OVEd0SDVOS1JJN3NVek9HTEd3MnIzVXhySFRP?=
 =?utf-8?B?dWh6U1hjbDZDVU5MTlJPcnkxNWFROEFvUDlFNWlTV1o4Uy84ZXBHUldyQ0d6?=
 =?utf-8?B?aTU1emFvV1djdzA1bEFnZCtOdXdMbXpDQ1l6MjBnODcrWE9VbzVTQ1VyWFNQ?=
 =?utf-8?B?ZTNnRjRVWVcwMTFwQmJ0Rzhmb0doZDZ5eUEvbGJGSkgzZnBmVkxaeWtjTnlp?=
 =?utf-8?B?bXQreXpDNnk4K084LzZDSUtsZWR1TG82eTFvZG5tbTZ5RjIwcGZQbURvZ2s1?=
 =?utf-8?B?dzd4c21pTmpNaGp0dVpMMlRnYU4zNXFFdFAzNnN6V0ZZRENRWnRKcXhTMjNh?=
 =?utf-8?B?OFBYYWh0cXk0NHpNaGxvaHNxeGRqWDMxVVUvR0s5d1dNdjdEMllrcXl6R3RW?=
 =?utf-8?B?L05idzh1UzJIS2MrTVIzdm0rdTAzTFdSNWpKRFl0bEt1SkZPNlhLV2djUDZJ?=
 =?utf-8?B?MVdSYTk2LzMwSzFnVmZVSmhMK0dDdk1ucVpLZXBmS2pHWkJnQ2ZhZ0tscTFz?=
 =?utf-8?B?ZFNDeXFwVWk3VUEzQzg2SlI2YmRUckpZWUNoOVVFL2pQNFFtcWkzUEZLYUEz?=
 =?utf-8?Q?7jr7TResyq3jyi8TM0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8932211-6e42-40b8-918c-08de7ed0a690
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 18:12:54.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoKeXgf+MipYPTu1OpsneC0Pv5vUO1NMeLTiL/aSD1lOC9DyUvw0RVGr5fZvb3qDIw3esz05P4vJJMHM7jXPbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191

On 3/10/26 12:48, Naveen N Rao wrote:
> On Tue, Mar 10, 2026 at 12:36:09PM -0500, Tom Lendacky wrote:
>> On 3/10/26 12:17, Sean Christopherson wrote:
>>> On Tue, Mar 10, 2026, Srikanth Aithal wrote:
>>>>
>>>> Hello Sean,
>>>>
>>>> From next-20260304 onwards [1], including recent next kernel next-20260309,
>>>> booting an SEV-ES guest on AMD EPYC Turin and AMD EPYC Genoa has been
>>>> failing. However, on EPYC Milan, the SEV-ES guest boots fine.
>>>
>>> ...
>>>
>>>> Bisecting shows that this commit is the first bad one. When I revert it, I
>>>> am able to boot the SEV-ES guest successfully on both Turin and Genoa
>>>> platforms:
>>>>
>>>> e992bf67bcbab07a7f59963b2c4ed32ef65c8431 is the first bad commit
>>>> commit e992bf67bcbab07a7f59963b2c4ed32ef65c8431
>>>> Author: Sean Christopherson <seanjc@google.com>
>>>> Date:   Tue Feb 3 11:07:10 2026 -0800
>>>
>>> Gah, I hate how KVM manages intercepts for SEV-ES+.  Though to a large extent I
>>> blame the architecture for not simply making CR{0,4,8} intercept trap-like.
>>> Side topic, is the host actually allowed to trap CR3 writes?  That seems like a
>>> huge gaping security flaw, especially for SNP+.
>>>
>>> Anyways, this should fix the immediate problem.
>>>
>>> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
>>> index 33172f0e986b..b6072872b785 100644
>>> --- a/arch/x86/kvm/svm/avic.c
>>> +++ b/arch/x86/kvm/svm/avic.c
>>> @@ -237,7 +237,8 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
>>>         vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
>>>         vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
>>>  
>>> -       svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
>>> +       if (!sev_es_guest(svm->vcpu.kvm))
>>> +               svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
>>>  
>>>         /*
>>>          * If running nested and the guest uses its own MSR bitmap, there
>>>
>>> Argh!  The more I look at this code, the more frustrated I get.  The unconditional
>>> setting of TRAP_CR8_WRITE for SEV-ES+ is flawed.  When AVIC is enabled, KVM doesn't
>>
>> AVIC is disabled for SEV guests (see __sev_guest_init() and the
>> kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV) call at the end of
>> the function).
> 
> AVIC gets inhibited globally, but continues to be enabled on 
> vcpu_create() opportunistically -- see kvm_create_lapic(). It only gets 
> disabled later during vcpu setup via 
> vcpu_reset()->svm_vcpu_reset()->init_vmcb()->avic_init_vmcb()

I'm just saying that the unconditional trap for CR8_WRITE isn't flawed
for SEV-ES+ because AVIC can't work with SEV, so there isn't any time
that CR8 writes shouldn't be trapped.

Thanks,
Tom

> 
> 
> - Naveen
> 

