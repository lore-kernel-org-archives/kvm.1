Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24D30677E;
	Fri,  9 Oct 2026 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576347; cv=fail; b=W4M8dYak17zu/PTyxhKac76gr+B14CMmQtsS59BZZQaS0EeRhofP+07mhA2LtegVuwDaFRZi7jdtmNQ/mAK0q9Snb/xsarsw66pZiJyRXoQnTSaq5DSF9Hb+8vrPorKRQfrQ2KEIzsQtdMyu6Kbul1757lqqzcImvOYgsoxBp9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576347; c=relaxed/simple;
	bh=lAGVe8otIxavt5YdxMcomzA6WR2/kdf6/eSKriQ8NkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L5lZbRWMxg3NwP9c7C6Fw+nZWbM7ivHfo6tetiHw/6tfRoNRN22VxPCwSwYlO3Q2g00v7a+iNnVtaE3eCuJ1pgnju+tn9Pq8cV19f0x4PKsPbj28/poio6h8muCTtGmEsSF3HfxfWL0O1oRaHebr5XY9pxwIZvLfqdkZLtQaiJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vlnk/2sm; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vlnk/2sm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5Mvxcl1+67BGjyWvYf/+9ZVeIW7eAAwVJ3JhtC/geSAr+AjLjt5TpzKUWx8MwwIoR+guEkGLJyXUTkMc6IBoWrIW3Qi/OXnO46zPe5PgDR8xPEqm0CdghiaP6iBKDv6eoQLyOfkC61rBV5vsPOQ/va2SvX5NJiKjr9KH1kLOmlziUCZPLN9yB2RKlIJ/PAgnPu+Yo7c+pGvebvcCmUz1UTK18nNBY4qgf5E3eEvw9h59C+Mp+YiQY4D/4pZayM7qkN/orkSJUUokVIj3XXUpgO7RMHyHyXjEqBEcFMRfbMn0u8GcP6ThsWzJj1E9X97ezdgqtQcBydNuIHdoPCoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcoarpjexFHDWFD9Ss3Zg7l2UowcrKiJe0g3V2/rHUE=;
 b=P48dOxr1ip9Y0cwYtdT51J/02HbvnEJVKL0JM16DLXicGoAMO6nqkSGJ/CPYQ06kpRkrOldkW62tMYxVSoPfJZ+h79zSyXCjfP+j45CWKXCo3w7LgK92+Lc7CtPbjWvVWw/HekY8+Ybck0Ep83TroXnDJ3VYoJDG6ZRk3UvPNsmeLSzhHoBBo3PDKeRU/ilLdvIrrm5e2S8hlpSCBpYFmqT/YJA2AAx/VJ3EHOoI5JFroONETOtY5pXIcAUFqc59BcDu9AEKHPgeGXzxJkUNlTwg9gTLyJYTDIRA9fiAcK5oAipHQQpfonb9nNx8D+5ww6rE1F/dGrSqkFjhzpXs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcoarpjexFHDWFD9Ss3Zg7l2UowcrKiJe0g3V2/rHUE=;
 b=Vlnk/2smVSwmP7hJIHnTC12wtFG73oApqiEobkS+ZEtHqhhrKIX4TrLA8keYoyLtiWvfV+0NVDBWpgX8gAHj9HkYGYZ9gjwmrCIIJcwfj4iGxbohouTy21jPYVhyoCXe/ZqcIiUopu6KVii3ftZcwALGDQ1nJhmwOoZK7Be6kD0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 20:05:43 +0000
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2]) by SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 20:05:43 +0000
Message-ID: <d72aecef-d7cf-4cd0-9c2e-b4e1922b6c99@amd.com>
Date: Fri, 9 Oct 2026 15:05:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/4] KVM: SVM: Add host support for Enhanced SMT
 Protection
To: "Pratik R. Sampat" <prsampat@amd.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, seanjc@google.com, pbonzini@redhat.com,
 kim.phillips@amd.com, nikunj@amd.com, michael.roth@amd.com,
 ashish.kalra@amd.com
References: <cover.1791302373.git.prsampat@amd.com>
 <64ea6ba62315d33b7bfb48ec6cab29ac4ee2fa06.1791302373.git.prsampat@amd.com>
 <961ba3a4-3fe2-45de-af56-92efa43ca2b2@amd.com>
 <b1145255-a272-4f92-982d-ea3131463287@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <b1145255-a272-4f92-982d-ea3131463287@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::15) To SJ2PR12MB8136.namprd12.prod.outlook.com
 (2603:10b6:a03:4f8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8136:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0dd017-79ee-4f86-d800-08df2640b2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|3023799007|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	TEH/HsyitygidZmwDQxCrGvVmQ0JfiMCCPWDjxxgd4ZtP3FemzrMWq0SG2WSTAIH0CPH9eLJIrHWvrwaqkQEFoNHX9oTKYwGV9DQtaQHZdsLNXJvHO/2NWtH563R8erVuDXr3CvTIj37jKIV01ZkCLOaSon8NLawzsWBa3W3HeqhE/NNPRCz71QDjMI866h5THEKAD9ByQ+2CUfXHkywAxRefRjVNQMYmJS6QD2yMQOJiUmtDpSOMGteE4923MwsxN6qYfSpyICjfgsDOYYp4sBOjktkkxAyqQh98FrlDXp0Dh2ILXAKhiz1qvw1RE8eOKfWppL5Plq9JjqhLxdI5lrQG9rrBJucE9lwjInQBTmxuTjod4/wkcIVc3FZo5iI+mx3NqNNm1JJVun1+dZ9magdxef5RyXwzgFSZ9LJ0+Mlrh4+i5DczcufNVPOWOziFUd0rz1cyg2bHgKYfrdjA4ItEZ94QqlZu5tD2vfqn7OUBywEA7GX06TkXJF1NERvpmJrj+v+Mz133d02p6xE1NXFXoAQyWIPoPXIeg8opatUsWJrBvcEl8H58yGs3tfy7XoSdcpuE957r/JtdVjIwV2swXF58uwZIKZDaZ5M/tX/GEz6z7XCIzVgjfgRueww8XNcBJKniY3tc3HN+kYal16OkuOVLVcn9YIrHtZYwsA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MERsT2dtZjc5V1BERWtpUHNiWUtRbzAwazRLZVpQQ0JGeGE2ek5sNFZ6aUtp?=
 =?utf-8?B?ZEJDekxhYjBNWkhjODZxVXNPSnR6eDBvQmdoS1VxWlpsNUFtTXh4WGhZVytx?=
 =?utf-8?B?Y3ZYaUtxSmxET2N2ZlRicFhjaWY2Q2ExS2FYbFNrejhFZzg5cHdSQXpoZ0hV?=
 =?utf-8?B?a3RGZWo1Y1FFb29LY0wyZFBnQUtUSVRIa2hSUkgydkcwWldnWlFjNU5TOGRL?=
 =?utf-8?B?OXVtSnovdmJiQVVMck1KTFdrTW5NWTRhbEhvdWNRWUtDUmZGRkc4OGpqZUVH?=
 =?utf-8?B?eFhDZ2dBTkxFNjVVU0FUZlRZdnhSeFFOV0FYMFBiZlloREwxVGt1Smx6M1Zy?=
 =?utf-8?B?TFBmSjNoMkNwSDNqci9yaFRXZXZ1UnZKd1kyMmovaXNYamp3Tm1mTDM3OVg4?=
 =?utf-8?B?TWVhNFNXVEIvMlV5dEprZStQb2grMFZnUzVUamV5NUV4WGh6NVhubEswNjF6?=
 =?utf-8?B?VmcxbG1zQ1NNMUN5TE5uYVQ2T3ZQck5OVEZ5OGlLS09uYTBvQUlzV05Jc0dv?=
 =?utf-8?B?YU9QaGdOdDJQaXl5dmdTcUdySlFlRSttbzBwTHRWSU9jM3NNOTJTUjMzZDhT?=
 =?utf-8?B?VDdaMk1Pa0tTdVpXUVVMNXZVbEtBbE5ORHJYbnZSTWdDb21QNWZwODk0c014?=
 =?utf-8?B?NWNxQWVKc2NGY2cxZFV5TEkxNzF0b3dpTC9yQjhsTmhpcVdETE15UDNsZGRL?=
 =?utf-8?B?RmdiYklwMk1idTZ0WTNTUy9HMTBtQm5YSmhYWnZ2VmVWc05hbU5RemxnVDl2?=
 =?utf-8?B?cytPNHE1Y1lrY0NqK1ZZMFpPUzRIVzAzOUtCcWRVeHNoRlJsWVkwV1BlenhM?=
 =?utf-8?B?L0NwL1k5NFhpNzBZZU5vZkFxRUlvbTM4d0RGUXBSaEIwSmQ4bVdWdHlCVnlM?=
 =?utf-8?B?TmtyUk9ubWJ2SXJFTTBEYlFtbk45MlhZcWtiSUFJTm43dkMwRjgwQnROQWR5?=
 =?utf-8?B?eEVQa1V0N0ZKZFBDaks2QlhHdldnMnh4eUpKS2E1b3lKQ1dFVjI3YnZYZFVo?=
 =?utf-8?B?bGhDbDhFRFlaOFA4VDRqalo1RVpWOGtMVEJ5REl1bk4vM2ErVUV4cGpFR0pH?=
 =?utf-8?B?UzF1UXgxWlo4bHF6aXpDUU1MZzlReHFkZWptQ20wRVNrVXJwK2FaRGdHVzdw?=
 =?utf-8?B?SWtLUW9MSXhXb0dkdEwrckthUXlpaVR4UlRzQXdLTlBRRUJaWGx4TFhXNjRr?=
 =?utf-8?B?Ry93OVlNVlV2SWNlWEpOQWV0YXl6a1ZWR2o3MGcwMnlycDJqU280aTkwdHJ6?=
 =?utf-8?B?ejlIb1pxQmhlOUJLVEpvSWg3VmRxcEFhRElEaVVkbUVIR1FFZUxMbTVYeUJJ?=
 =?utf-8?B?Ylc2SXdxOGxLb2NNQWtTbDIybWhiWVU2Z1pMQW56bEFOMVBxTUtmV3BySklU?=
 =?utf-8?B?MWNQY0ZXMEpXZ0ErVFIyZlpLTzFQVkRJdmkvWU1JZkZ0Z1ZDWkJNMk5VdFI0?=
 =?utf-8?B?UXJsWDdUaDcwNndBOG5sUm5tY2FUK2ZiTUJyZHduM2J5Y0lpa283N0YrQkpL?=
 =?utf-8?B?RXMwZ1J6QzQ3a1ZWV3Fhdi9ITFVWMURzU0FlN1hTNWtIc1MyRUdMUEROUWFS?=
 =?utf-8?B?NmE5NGt4LzFlSk9kNFNxcW8xNDhXT1doRSs4d3hhMlJjOURlWWhpUmxvZ3la?=
 =?utf-8?B?RFBhNXlLTE5KSnBMQnExSVpKdnVRT2xwYzdXc3dPODc5eWRkL0REN1R1Mmpr?=
 =?utf-8?B?UHB1dllEWnlldHVpQ2gwdlp3NUhLUkduMzlnYXU2bTFreURwNkh6RnRSQ2lX?=
 =?utf-8?B?bmNvdEN3VFI5SWYwaDhWK0RMQVBCK3UvRTdJZjBCZk9heW9EOVIyUno4VS9h?=
 =?utf-8?B?ZFN1NDNzbGNhdCtoa3gxNWowYVpEeEdzbW5oejF0VVRWSVFZcURZWWE4akVW?=
 =?utf-8?B?clc5ZmVjR1djNTZmSStVNllCTUtCZWlHZjU2RUpxaW9kQXJmU2Zrc2V4RzBC?=
 =?utf-8?B?VzFhbEJtTmY5R29qQ3kxNzRvUE50RUZLaUhSRWwvcHRwclZrMnNxaGdpbE43?=
 =?utf-8?B?Sk1qSmpKWFlPd1ptSWNwZTdCVU5UMWxteGFPMVhiMTdpdHFZMCtEaU1WKzJY?=
 =?utf-8?B?SDFVejdXdXRhdkZoSVZ3R0RlaVo5Y21xem5JdkV0aXZreE1zUzA0YzBubnlo?=
 =?utf-8?B?L2xPWkFYWExSeVNkL3BoT3d4dzlqc2Nkd05CeUJPQTQ3SWpldmNjdUtkWFpV?=
 =?utf-8?B?K1FxWXNiSkFSeVdHSDN0aFFOTVV3bG9KWmRBdWkweCt3ck1oNUloZElHdXkr?=
 =?utf-8?B?dlFKckhodnl4YjdOUElPUi9RRFkyR0JVR3l2MTVlckJPbTRaQWpBQ3lMTlhj?=
 =?utf-8?Q?jnWQWzfImYR8iouscI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0dd017-79ee-4f86-d800-08df2640b2cb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 20:05:43.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdgsKiXJDTwCGhiGefzyabSAOEwJO0CNYo25dbd1cnPTU9Ah8E530csP3vE0JKlIz9qvX/6Geig9sko3n73Ltg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564

On 10/9/26 14:40, Pratik R. Sampat wrote:
> Hi Tom,
> 
> On 10/9/26 3:05 PM, Tom Lendacky wrote:
>> On 10/6/26 11:54, Pratik R. Sampat wrote:
>>> Enhanced SMT Protection (ESMTP) protects an SEV-SNP guest from SMT side
>>> channels by requiring that, while a vCPU is in guest mode, its SMT sibling
>>> thread is either idle in host mode or executing a vCPU the guest has
>>> declared to be a legal sibling. A legal sibling is another ESMTP vCPU of
>>> the same guest that carries the same VCPU_SIBLING_MASK and agrees on
>>> VCPU_ID outside that mask.
>>>
>>> Hardware enforces this at VMRUN, which no longer enters guest mode right
>>> away but stalls until the condition holds. Three new exits report that it
>>> could not be met, all of them non-fatal:
>>>
>>> ESMTP_ILLSIB: a sibling thread is running a vCPU that is not a legal
>>> sibling of this one.
>>>
>>> ESMTP_TIMEOUT: the stall exceeded the timeout programmed in the VMCB. The
>>> timer bounds how long VMRUN waits for the core to settle. A module
>>> parameter exposes an interface to program this timer.
>>>
>>> ESMTP_RETRY: If DBREQ is detected, VMRUN exits. ESMTP_RETRY indicates an
>>> internal event and the hypervisor should execute a VMRUN.
>>>
>>> Refer to the AMD64 APM Vol 2, section "AMD64 Enhanced SMT Protection".
>>>
>>> Acked-by: Borislav Petkov (AMD) <bp@alien8.de> # non-virtualization changes
>>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>>> ---
>>> v1..v2
>>> * Move idle wakeup ICR programming to svm_enable_virtualization_cpu()
>>>   instead of sev_hardware_setup()
>>> * Remove cond_sched() in ESMTP exit paths
>>> * Program the IDLE_WAKEUP_ICR for all present CPU siblings
>>> * Add documentation for ESMTP timeout
>>> ---
>>>  .../admin-guide/kernel-parameters.txt         | 19 ++++++++
>>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>>  arch/x86/include/asm/msr-index.h              |  1 +
>>>  arch/x86/include/asm/svm.h                    | 12 ++++-
>>>  arch/x86/include/uapi/asm/svm.h               |  9 +++-
>>>  arch/x86/kernel/cpu/scattered.c               |  1 +
>>>  arch/x86/kvm/svm/sev.c                        | 48 ++++++++++++++++++-
>>>  arch/x86/kvm/svm/svm.c                        |  8 ++++
>>>  arch/x86/kvm/svm/svm.h                        |  2 +
>>>  9 files changed, 97 insertions(+), 4 deletions(-)
>>>

>>> --- a/arch/x86/kvm/svm/sev.c
>>> +++ b/arch/x86/kvm/svm/sev.c
>>> @@ -67,6 +67,11 @@ module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
>>>  static unsigned int __ro_after_init nr_ciphertext_hiding_asids;
>>>  module_param_named(ciphertext_hiding_asids, nr_ciphertext_hiding_asids, uint, 0444);
>>>  
>>> +static unsigned long esmtp_timeout_ns;
>>> +module_param(esmtp_timeout_ns, ulong, 0644);
>>> +MODULE_PARM_DESC(esmtp_timeout_ns,
>>> +		 "ESMTP VMRUN sibling-wait timeout in nanoseconds (0 disables the timer)");
>>
>> "ESMTP VMRUN sibling-wait timeout, in nanoseconds. 0 (default) disables
>> the timer."
>>
>> Not sure if that reads any better, main point is just to highlight the
>> default is 0, timer disabled.
>>
> 
> Sure, your example reads fine. As an alternative:
> "ESMTP VMRUN sibling-wait timeout in nanoseconds (default: 0, timer disabled)"

Ack

> 
>>> +

>>> +void sev_esmtp_enable_wakeup_icr(void)
>>> +{
>>> +	unsigned int cpu, sibling, shift;
>>> +	u32 core;
>>> +
>>> +	if (!(sev_supported_vmsa_features & SVM_SEV_FEAT_ESMTP))
>>> +		return;
>>> +
>>> +	cpu = raw_smp_processor_id();
>>> +	shift = topology_get_domain_shift(TOPO_CORE_DOMAIN);
>>> +	core = per_cpu(x86_cpu_to_apicid, cpu) >> shift;
>>> +
>>> +	for_each_present_cpu(sibling) {
>>> +		u32 apicid = per_cpu(x86_cpu_to_apicid, sibling);
>>> +		u64 icr;
>>> +
>>> +		if (sibling == cpu || (apicid >> shift) != core)
>>> +			continue;
>>> +
>>> +		icr = (u64)apicid << 32;
>>> +		icr |= LOCAL_TIMER_VECTOR;
>>> +		WARN_ON_ONCE(wrmsrq_safe(MSR_AMD64_IDLE_WAKEUP_ICR, icr));
>>> +	}
>>
>> Can you use cpu_sibling_map here instead of going through every present cpu?
>>
> 
> I think cpu_sibling_map only covers the list of online CPUs. If SMT was say
> turned off and then on again the CPU that stayed online would never be
> reprogrammed with its new sibling's APIC ID. Walking the present CPUs avoids
> that, because x86_cpu_to_apicid is already valid for offline siblings.

Makes sense. I know we disable hotplug when SNP is enabled, but this runs
before that occurs.

Thanks,
Tom

> 
> I had used topology_sibling_cpumask() in v1 when Sashiko pointed out this case
> to me.
> 
> Thank you!
> Pratik
> 
