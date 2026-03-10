Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6C2E9730;
	Tue, 10 Mar 2026 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164177; cv=fail; b=f6048tq7Q9pRSQwGa2bfliO9Y+M2qd7hqRAAZIJFlbxaSFiB0uMD/HwOxImComb1vTvoVa339p5UF30poFrGtoHAJ0vSXQ/L3Z3aNLrRMdes7PMwBHXJlK7+D3+D6NxzLu+MQjtqEdpUl2ydydMdRpasAwft6RLzRm2ulYPzRYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164177; c=relaxed/simple;
	bh=y3L+9tn0LSixike/SFwC67h5jIURIpHpgj0qI6+TiIs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ovI4HAzPlSpHUSdIQfjttbCYnWDb63iAlWWqGKGw4Tgc5Rnievv34jncvivx/magFKChM4vD96138bgMnUWfy20c4QUBDX2TpcP38Cp1TFAFLJtXiGlG3MhImAlw84n8Pg5uc4nvJ770/gmUo+79j7Y2nPBF9g1L1dRuokYlTD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AN/8fUDz; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AN/8fUDz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1OxnVb6o/ebVEjNa1jI4N3j+3ANSAR4XyJsIUB87bMinu9VbTNoIz0tDIUVC3oyL/gO46oS+zplluLPLriko85Qkwdxzz7jC7M6/RNrwQcJoTlOhjXPC/4GJ5Uv69AaI0dVu5H5DPqfZaT5m3bpNjI/D0AKrpCBoPQ8jTszRKBtcSGk+poX68f2U2ygNCUqgNtATj8Mt8pKj2kGK6VzZucQVHeSIx/TxFhXDFW+IHg7cLvpR08fDHLnn5ltx5ws8JFLyRw6KQlYAsP5Lsm1v32wXMebW3bPuh2Plx/myMVh+WTCyGk8QSDK0sg/+w1YBAiMKneVZgJGY2dat7qcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFT9hyr2H0iA4x0WyhuxtB4nHvu06gQbKXb5t2GNp1I=;
 b=VhcMOIdjU73t29/oFP8KKmQLnrLOHTbkjyqYfd3VMp4vzgLucnK/qmn91q50lHIXRwJZRv36lhdkvez68yITH09ygAGHMcPThhgooHE3UjU8iov5ul5g6NBbC0JgaadyHKDWNNqUUnJi1ksJYkXQoBMjeq2VbeNUGD0bdam0l1oD8PY12R6Wz2YHmJ5veivL9aE12rH/5KbeBXEItMzYaGxQrJaNf1ZK1KCYCPc+osu6iRSeOZ1qabC7DkRXB4mXQaZpe6agi8H01pK4ihP7qOKn2gAXnsKm2k68uVUmGZWO7nhhtyOf9y+Ugxj1xt61mytnyPwq9vn+ng8KSK3s1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFT9hyr2H0iA4x0WyhuxtB4nHvu06gQbKXb5t2GNp1I=;
 b=AN/8fUDzBd2Bqlpt8K5GNeehVKzwchVdyCdPLYPCdCyyDYJvrrUbsMpz7fdT4XmL/jKS7y2V5qS9tO8/Iu3K7YnwuaM451fjRwquRyZaJZAESWcDO5hKgjUPy7ssftMW55zpcBQmWkbM41PFLCj59XNoU/0CMJSZpJpvwxLDV3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 17:36:11 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 17:36:11 +0000
Message-ID: <947bf241-d149-4933-874a-de96aeb73dff@amd.com>
Date: Tue, 10 Mar 2026 12:36:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: SVM: Set/clear CR8 write interception when AVIC
 is (de)activated
To: Sean Christopherson <seanjc@google.com>,
 Srikanth Aithal <sraithal@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Naveen N Rao <naveen@kernel.org>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
References: <20260203190711.458413-1-seanjc@google.com>
 <20260203190711.458413-3-seanjc@google.com>
 <19935696-36cf-411b-af90-aabe6a98d7e7@amd.com> <abBSPkKmMiFCfKek@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <abBSPkKmMiFCfKek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:5a::19) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 607adf9d-af36-46e1-3022-08de7ecb854e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	wKMsOd5/EfmsIl2yT62vjWrOx458ZuLTpJqlNG9A2H4lqsBCZhnTi1AugOOkrxhdtHpoSJZ7DfxR/Co2sYdiy9p7P4koC+iXmTx+qTnPDrU9ntzLAZZ90Tu31sdSt0C3l5eOx09T9dqptksaLIaWIq9ZtKrqqcmCzwNM3ehQ2KRgLCFkYnmrInFezpi/YjAVe+FcH8BPptGlXd53wiWIAYBsbGtAj1LBKuHES0tOV6Folp65SSf1s/9wIa0vLpHTTCRTIgA87lgM1yhSdepDOoZ5XXtAyjM/AJXgIqr8epmBAgLyV6re6jAhsXA7lQGRkgu5Y2CeAW0nfQOGRdtzvbgW9MEWDzONOi+C733UJqSMO9rAHBm0+cbONiSMVOPPd1lEchYf9pU3BujTE5hGEQqj8bwD9P4CU/KvJyiRrsPBKGQxsmesHqY1H5ABhvgPvnoZ32FksHzZh9Zjxtr5QfMO+xSlGUKkxZaIvjHzBC8IEgoozLMSqDaPBkkmQjmnCzv+pZIY4aTid0xLWiEgVZA1nJMyo5EW+UHbCALmiPduN9R9TrAHSy0y3xP+g6k0X+F9QUnULZSc+qcopdwCVPR0dfcRkDtr/G9VOxu+mn/Lugu/ST8xSbYx55YH0OApShztIzN3bGWk2BZsvR5FYM/B5uqlpX8rAdG3J/PgNi0XLTsKD/6mweNrhQ3GSSxzi0ysyrkICUpS+2Sr3toHxGTXYrsDFdB6B0ntOa4qfsc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3N3NHQwUlRpWGpkVzM2UXR1YmNKT3FFQitIUURwWjZTSmpZbVFTb3gyNkhx?=
 =?utf-8?B?L0lweG00YWdRbW9yMjgyRG0wNVFLb0NGNC90Mmk1U1VNUUNkdWsrMENrdngx?=
 =?utf-8?B?SkpXR3FQZ2J0eVhUcExjRXlkUU96aDV2QlFHeXZIa3RUQ0Jrb21wcm1Qbk93?=
 =?utf-8?B?dzY4ZmdvcFJ2SGo3b2l1U1lKWGJ2NkQ1dWRNaXRrVzhGYVRHRXJldVYyMXJM?=
 =?utf-8?B?OXFJOGxqWVNtZ0ZITzlRdi9CV0hpd2FWbE1xMXJDby91T0djV2JLTzJNQ1ZF?=
 =?utf-8?B?Y2M1L0lSZWNGR3M0VUtoOHhUeVFrano3NnNnNTRZNXV1U3J3RUcvZ1V6TXFC?=
 =?utf-8?B?cTNHODZzUklLWG1CaUNNTkFESTJzVlR0eEwxVmFlS25Vc2JpU2pEOUVhdDJ3?=
 =?utf-8?B?dVpQZ1JQU0tZdE1NMFZEMjRhb2x2Q3ZtdlVyV0R3SWpFMUVSU1FraGFyemFM?=
 =?utf-8?B?eUI3dlJLTE4wRzhuSENiQjcrc2JnSy81cmhVeVpNbW8vRU5PNlZ2Ty85ai9h?=
 =?utf-8?B?bGI3WGVVVFMvSkJ4bU9DY3llUUh5ejNlTmt0d2dDaElORG1FdC9aQ3JuV1FR?=
 =?utf-8?B?eDl0RXg4Q1JXWUl2QXVTRFg4M1NjU1FJWnRkeUFpVlRVSnM0TE0wSTBUUmIv?=
 =?utf-8?B?dGRQNjdxK3ZUaHF0SFdFbVprb2JSMERnK1pKeXBiTEZkVTFMUmxCcVk3SHEx?=
 =?utf-8?B?cTJuMUZjb2dHR2wweU9wQndPWnZqMWE4OVdXbG5VSEhhV2EzRUtXdmcycmtY?=
 =?utf-8?B?RlFoZFRYbE9UamNxVUYvRnhCZDRSdFMxd1hoc1k4YmpWTkhqQ2pxaFErQ05M?=
 =?utf-8?B?ZmJUWlVPcm1MZ0JLT0JmNEl4Y1ZGYUZpVC9iOEtEdjdqcHE1dUhleTBWMVlR?=
 =?utf-8?B?NmE0MWVYWVZ1Tm1ZVmJiVTU2Mk51bEpLYWlWeWdnRkFUNzFSN0c2SS93WnNZ?=
 =?utf-8?B?SUtkQy9KeC9iL29WaUg5dVgvL25sY2tIMFhhRGJydzNmWXEzeW9ibnFmbXg0?=
 =?utf-8?B?VHlkZDQ4RmZGMzhlUitXcnBDM0VnMFM5NkxGdVNGcXVsakN6L29YUHBaakcw?=
 =?utf-8?B?K1B5RGxFLzE5MW1vK3V3clhFbk5xTS9BS2FLU1hBRWFNVlc4RWREQ0NLNEFI?=
 =?utf-8?B?Um14RkF5T1FnOHhRbms0NnVlS1BTYmVsT01iSGdIZUc4ZlM3b1F6dVpqWEZl?=
 =?utf-8?B?aEJJb1l1WFJTQWNSdmZzWDRMdFM4bjk4VStDMTBsVWIxWFUzazBNQ2svMVdJ?=
 =?utf-8?B?OHhYSlh1cFBUVDJoWStxdUE1a0phcDl6RzhyTmIxaDZML3FOakdZcEVsa1g5?=
 =?utf-8?B?aW9Obkp0blFZUVVUTkNDSG9sRnpqSnZXczd2cjJOZmVtRFlYOWw1Y2lialJx?=
 =?utf-8?B?N1hPdFNmVFhUbitIbjZiNmhXdG8yZGwrVmlQbjJQOE1BaWN5UTR1UWIvTmpL?=
 =?utf-8?B?cHdJYnJiS2VOdHM4ZTJSLzZjQjNJZDNBckdIZWtqdjlycnJQaEt5TFRqZkhv?=
 =?utf-8?B?UExRUXJmN0ZQZmpCOGJkT2pNUXBqem41S2Ivam9DYUo1T3dad2FVQ1BjVWJH?=
 =?utf-8?B?cnpqejFtRWNsd1d2NVVGUjc2TjFHbFdMQzZQcDlUZHJtc2E2bWVBVm5PM2dn?=
 =?utf-8?B?UTZJaldmT0hMbG5ZbVdncGpSaEhBMldBQUhQVXdLU2pnb040ZS83Ylp2c2VZ?=
 =?utf-8?B?Z1VPVVprU3lXcWhSdUIraW5HeWtNbW5XMS96TlRuM1NsR2JacUdCc1FyMlI3?=
 =?utf-8?B?SzVqK3BGRjViY1dHUW4yVnJRVVA2cFFaZjdwTXRvanZmSEdTR3hXUW5QQmV4?=
 =?utf-8?B?NjBnakJyWVpDZ2svSC9heDA2aThZR1M0aG5obUN4cmttSk1YbU0wV0U0YTRz?=
 =?utf-8?B?ZWNOeVVHTVZKZ3pRd3VPNU5ESDNSTjVsSnBGU2JDWEwveE9QdkI3bkNmTys2?=
 =?utf-8?B?U3dWaFVzcGJ5dzdzbFRTSnR5aFRVZHovaUJidGN4LzVFUlkydkRlVmR1c2Zr?=
 =?utf-8?B?NzREb0kxanlZK3VZRmgrdERsdjJBRWNoUDAxUWp0WllCbU1OTnpMWDUvSW9V?=
 =?utf-8?B?MEFiSlFOZU1pOXNuMjVualIzNE5ySm04bEtzL2l3SUlLVVFFeHBUWmxzQ1cz?=
 =?utf-8?B?UG5ldmtYeVJxNzVOSGJOaktIQnJ4VFRRbVdZdWpPbmVxS0lnOWdDeU1jNFNQ?=
 =?utf-8?B?cGV4WXVYWlFRdERPU1BqN01mVUFRMXhBaDNzei9sbzE3OW8yRjVQeENvRnpr?=
 =?utf-8?B?R2JtS2xkS0JKSGxaWTIyUGlWaFhNSDRsK1BOM2dsYXh3ZW14TmtzZXlabUZY?=
 =?utf-8?Q?/jFnLGH59JxUOizJOm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607adf9d-af36-46e1-3022-08de7ecb854e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 17:36:11.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WJSmElTFDb1EzhRbAATGrsrRg3xASKZyPgJF+ktp7hRuBTFxzuF4wwxhiRQILUuOA1w4rRsXA5Jr2xYih0xxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399

On 3/10/26 12:17, Sean Christopherson wrote:
> On Tue, Mar 10, 2026, Srikanth Aithal wrote:
>>
>> Hello Sean,
>>
>> From next-20260304 onwards [1], including recent next kernel next-20260309,
>> booting an SEV-ES guest on AMD EPYC Turin and AMD EPYC Genoa has been
>> failing. However, on EPYC Milan, the SEV-ES guest boots fine.
> 
> ...
> 
>> Bisecting shows that this commit is the first bad one. When I revert it, I
>> am able to boot the SEV-ES guest successfully on both Turin and Genoa
>> platforms:
>>
>> e992bf67bcbab07a7f59963b2c4ed32ef65c8431 is the first bad commit
>> commit e992bf67bcbab07a7f59963b2c4ed32ef65c8431
>> Author: Sean Christopherson <seanjc@google.com>
>> Date:   Tue Feb 3 11:07:10 2026 -0800
> 
> Gah, I hate how KVM manages intercepts for SEV-ES+.  Though to a large extent I
> blame the architecture for not simply making CR{0,4,8} intercept trap-like.
> Side topic, is the host actually allowed to trap CR3 writes?  That seems like a
> huge gaping security flaw, especially for SNP+.
> 
> Anyways, this should fix the immediate problem.
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 33172f0e986b..b6072872b785 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -237,7 +237,8 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
>         vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
>         vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
>  
> -       svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
> +       if (!sev_es_guest(svm->vcpu.kvm))
> +               svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
>  
>         /*
>          * If running nested and the guest uses its own MSR bitmap, there
> 
> Argh!  The more I look at this code, the more frustrated I get.  The unconditional
> setting of TRAP_CR8_WRITE for SEV-ES+ is flawed.  When AVIC is enabled, KVM doesn't

AVIC is disabled for SEV guests (see __sev_guest_init() and the
kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV) call at the end of
the function).

Thanks,
Tom

> need to trap CR8 writes because hardware will update the backing page.  I'm guessing
> Windows doesn't support running as an SEV-ES guest, which is no one has noticed.
> 
> Actually, it's worse than that.  sync_cr8_to_lapic() will straight up clobber the
> backing page.  Presumably hardware never actually uses TPR from the AVIC backing
> page, but it's still gross.  sync_lapic_to_cr8() is also beyond useless.
> 
> And all of sync code should pivot on guest_state_protected, not sev_es_guest().
> 
> For now, I'll just post the above (assuming it fixes the issue).  But this code
> needs some love sooner than later.
> 

