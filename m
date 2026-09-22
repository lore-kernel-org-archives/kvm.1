Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AAF4BEE54;
	Tue, 22 Sep 2026 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109937; cv=fail; b=KIkObvnRH1KuH4leBZBWGev+iFUCUi71MVzSYQR3eMr/tv2MVrCf+UjKx6/t967dWhywH9/ji6tSXslo/PCwJIosNf/vkiwvvGu6Nq0SZB1E9/05r4Hv2D/cfSo5HN+kuIBKdcWEwF2DkAJyeE/f5Gi1Q4VjXRFAJ9BRf+/YIqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109937; c=relaxed/simple;
	bh=2xLbOxJSa7bwtGItR8nfeMPlBk8iUM2wRT6rbrSNEHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rbjBT+PJcfqTmgq0Kl5N4UCmjnbqZiYzh/Cez3iMdHAyfhwuAUwbY2zgSQt7zWlgRMKsTX3lYOJXAduwJG3s62KnjtmAnx4OpQTLGNOh+Ap96Hzx3DUCTXgKQxcQ70WtULwCILJBDhgnvnb2k0hL24E/7aTGGy/LFwcwwHfgKFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TyBMBhVn; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TyBMBhVn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzVg4ngpEHhPyu77O55OM4gi0sw++JE48XaHurscyPsa2udv4T1dKuGkHgSRzEFiAdCKt/Nf/z/jenV20s8qw85MNKfMl6AY6x7Fbq510EyuOQc3hyf6XZjXISQz/ewN6LGsiawKFNsa07fHI3nMW5S2YPDr0vZRvazr6zHozZSX4QTEsY08QiS3x9zVWY2QhqXYccQeG2U51Dm4Zyt1VtiaCOeU+e86jtajspiSJciD/T4Ko7UTvU2ysU6zcGsdLy8vASbXSXe2LLU5igN20ERQV7qz70N9+6dCl1hVupA6UjEtSnAsxzWMoHzgrY7XzBdBuUCqn+wR77e2TBdRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byX2fRaaCdkCqsxpUoABscL30WBVxeiWc6SLj8E75eo=;
 b=yU/ys2/xFMSVwp/U1jlGM31KdP+p5Z9O27KyRQjxxbq3KUWe+hqdZHmRelnDl/D1U6kmuV0D07L9lz2Emg4IZYYW1Zz4+ICyAwvxegJDAZwogokppT6LVzGYLBT0/n21C2N6YJm7TAgu785oFiB7rrGPz2J8W7ntejv10KmW9HghL79KBnnq9JAfWeB05KTa/n447xsOwLWbQVDOiVGFOcFx6IulaYz4m0fAIYgzJDdex0Qb+GltfDqxpRjfdzO71rLxBC4SgxTsVMU7il2rQGsBnGFSdo5ngJqiOO+MEUowzbcDx1PYp1SvIeeFheLS5Rm5irKPNUj16c75By5vGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byX2fRaaCdkCqsxpUoABscL30WBVxeiWc6SLj8E75eo=;
 b=TyBMBhVnmnz91rma3kydfPImfIApzRybzqLDXLrxJQ+mg3U/yeZVA4+41ZZiLhxJ+rPhLmvaOishPJEmZzIQjk31I3oxS/xdB5plV7si3wMmkARpr8n/lTbI64yzoy5ATX5Tr0+HdLF2qOX+/qn6cn8Ty2Vg9abEwKaNAheqOjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by IA1PR12MB310634.namprd12.prod.outlook.com (2603:10b6:208:5a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 20:45:07 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:45:07 +0000
Message-ID: <55683a14-5888-43e5-8e73-04c85d2750ff@amd.com>
Date: Tue, 22 Sep 2026 16:45:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] KVM: SVM: Re-queue events that were never injected
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 kim.phillips@amd.com, nikunj@amd.com, michael.roth@amd.com,
 ashish.kalra@amd.com
References: <cover.1789399214.git.prsampat@amd.com>
 <d946de080e3dd34844a665c167179e4910fdc9d4.1789399214.git.prsampat@amd.com>
 <arEuMojZa_kv9VXA@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <arEuMojZa_kv9VXA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::12) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|IA1PR12MB310634:EE_
X-MS-Office365-Filtering-Correlation-Id: 83497869-6bc5-4767-9513-08df18ea62c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O7uONnFzkx3iMcHEXOV27WS3e35F15UZSrR8iU2tooKZle33DFn4GCYsF5evJ5o+eOVrAJlUyJ2gKtomnGFKIBSN0j8+b6bjl7KBVNf1/Kiji99MtNTHV81ckappsKQiG3N5iUvxIkfpaMmUA6l+vjuxBDNufYIIWly77zom0TPjFiamk/FlaGCswoUXN7hnr5Bx3yXLjebaVbv7IuWZ0Bt8SQ7JVjbjnRuFQR72APoV+3EF1YwTW4okPxGxHIa+Oejg6ubIpvWUUOa30AxzsYKpkJjOUmYTjUmEMv40cPSCt8zn+hLAYQXm9T1mHOA5BAnl2g9rT+HOnUgN5Abl9gkdphtzT48PcLkkJBxTIfA8FrdDK8OBs5/ddeXQ5VdF/dxKjXCcyBoxLri2/FtiRNd5NSEha6v1yGLoEmgweuHMLDF33O0+nFfZ2yCvjD3GmuL6quhSvDXP1e8n9IAqUBA46GQJGcMshIHynXUSwCHBnkHh4/rxCf6DDrWogLUtYX/vlExNyHCZcgJ2VssGtAGXtFr86Ze2W/MWk4cPG+15c0HlulYlTAnRJIFPsR1fTIsYYu46celQ4e+ppCJAMuwJzJ0tuNCrLYebbGH0rIIIB/JMP+DYtGaFkUSvUb/OtvsUEllwlk4aUYV3Xnlg5TVF+8EGQZWzGxp3ByQO4WY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uld4cGxVbVpiWiszQy9sOHpTRnJBWE50QzRITnFYeklOaWlieEd2WTJXNkZY?=
 =?utf-8?B?VkJRcmt0aXZCOGhRY1lUbllTdkpmelg1Qm9zZUdMeDQxa0M5dWlZZEdCemFC?=
 =?utf-8?B?TFQ4UWREUHNHcjQxN21qZGcyempTSEVYak9FWXdTaWRZMGFDQmQvamtNZ2Mz?=
 =?utf-8?B?cC9FTVFYbWlCbWdjUDN4d3V0Y3dqaFNpY2RLWDAybFkxU0FaRG9ObFNkcHFN?=
 =?utf-8?B?Y05hWWtZNlEwRmpyUGhIWGxQaXpRUzhCMWlJV3pHbitmbFRsd1gzYW82Zjlv?=
 =?utf-8?B?UjdRQWxhTVR2cUU4R1J3bVBvUEV4RHZwVCs5TmRDb2ZtcFBHcWw4NWp2STYx?=
 =?utf-8?B?SG8vYlZwTk44UFFhL0p4S3pzbmdTQmVFZzdWTU90clVnZThCRWVzRm54VTVR?=
 =?utf-8?B?SXZQNHNIcnJKZXRPR1Q0RndMM2R1SmZnS3ViTHltd1hzYzRvSjdsdWxqN3Y5?=
 =?utf-8?B?bk1pTnRndVhnRlRjZVljREdvenBWMktmYnRiSGhSd01GdkZ5R05ZUHh2bTdB?=
 =?utf-8?B?OVRleWR4TWFhaFRkc2FzY2V4QU8vWnpKbFBmVTJYZ1h4MytxMVhuQlFpNGlW?=
 =?utf-8?B?RHp0TGVuYlpPUUhoY0tLR005RXNIakJ5TXJtRGhhR3lsbHh5dVloN3NSWDBt?=
 =?utf-8?B?WFFtVjFOWjdoVkU3d0pKUmRwcXd6THVEWGhBTERMV3NtaUJpWW5kUVZnWGlP?=
 =?utf-8?B?ZTdBejZOaEtDTkNmRytCOThWTmtLSnZ2cHYwME1ZckJwYjhDN2JicitTdmUz?=
 =?utf-8?B?a2dvYnFFenhEZVBXWDVlNkRkQmVXY2MzeHlpWlVoQVdlY2I5NmFzWUx4QWdX?=
 =?utf-8?B?Z1I4Y3AvSXF2T1g0SnNBc1ppZ2toeng4R0xheFU4VTM5UFR3aWVxMUtIdXEr?=
 =?utf-8?B?L21mSS9QNDVVQmRKN28wSG55SXA5K3Z4U3BSWm81Z0pSelNpMHlUZjVXNFYr?=
 =?utf-8?B?dkgxM1phUGVjTHpLdE1tbWpxeDRBVmtLUjlpMFp3dVkvdzJWTGFHcEVlTGJk?=
 =?utf-8?B?dW9xN3g3THFyNklJYVFaQVJUZi95TG52ODJtSDFpWDdGdFQxc01HQmZWU0Nn?=
 =?utf-8?B?UFVob2Y0Tzl6MjZFQkpWWWZ6aW1mZVNCU0RlWFdSeUJLdURPZkMzdUZjT3Y1?=
 =?utf-8?B?aU1MVk1IK3B3SUlUZ3h1MXI3NGhWdnJKc1BlWmdTV2kwRXJ5YXF6emZGZHlr?=
 =?utf-8?B?SGh4aXk3RHhPN0I5ZDlrU2ZiZlo1bEhIeXpaQ1ZRZHdVRFpOa3ZnQTFRRDFv?=
 =?utf-8?B?MFVnRnJkeC9uMnNhRVBZU0NFUkdrU2JWbmFMTHdkTTFBampvYm1LbXkvVTZK?=
 =?utf-8?B?NE8yd0xQNk1hTCthVjVYdmVlcjM2cHdsQVJZM2dZa0xESGk1ekF0d2xHVmx6?=
 =?utf-8?B?aU42ZjlrN3RpbVI4L1B2K0NacmU3elpIbjZ0ZSswekpzM2ZmQ2RLU0hmMXZ2?=
 =?utf-8?B?bXdsMlA1bmtuaVdtNGVJSjlDRWpZbmdrMDBNaE4xdE9qQUdzaWR6RjByKzZF?=
 =?utf-8?B?eFRab1ptbE1wTXpURDJLWGdVZUNZY1JyY0dpVlV1Vm9DVGp1eWNJRkExaTlR?=
 =?utf-8?B?TEpUdUpuc21NRll5clBSekx6RjJPaTRONnc0bEVSN0VyUnQ1MmFaWThqajRj?=
 =?utf-8?B?eUdBcGpFTmpNNk1MR3ZhZVQ4d3MxTUM5TGRnVHIzcXFHUDZPRkU5Rmd3clBr?=
 =?utf-8?B?L0M5K3NlSEZOc2RaM0hObjl0T1E0c2M2RVFtaUt1UjMzWFlWdjQ3MUt2cTJa?=
 =?utf-8?B?bFh1MjVsYlY1N1VUL3o0bWQvRjdVVzNZQURJeXRPaGlsYjAyazFMTC96UmJl?=
 =?utf-8?B?RWhyL0Q2Tjd4Ykt6RTh5ei92OW9Zb1RWRTd3bU82eTh6VzFHaWE4VWtNaHpE?=
 =?utf-8?B?YzQzQ0luRnJJdTRvdjN1eWxMelNTZkxranFjdFlQUFhJZUpoRWRGVmJlbGFC?=
 =?utf-8?B?cXBTZDVNVlZjdlZ1MHhzMXFwYmp5WFdycjRCREJaYUZYbFVyR016TjhQS1Ja?=
 =?utf-8?B?dmJURnBPUWlQT0ZObnVzZll3eVpVVndDUi8yM1hKdGhibUxLaWpRNDQrZ2hh?=
 =?utf-8?B?VTNmeWpydXQrR3VlbXI5Tm5KOWJQMEtEZitpVkpNellMaXVad0ZqdUtvc2NN?=
 =?utf-8?B?YXNQeEM3bXZtMkZWSDJUYXkwVmh4RlVNejc4VUR4TkJQS0U1c3hIYjd3MGJq?=
 =?utf-8?B?bWYrRTBKZmlRLy85L1ZvN3JmeThncU5ybjNUZTFvdVhZbmVGZkF6Q3ROMm9Z?=
 =?utf-8?B?UDdDTUFSVW9EWWZaN3pPbmd3Q2FxRVVkUzNSdlIyYys3QlRyRmJUUFRlMUM0?=
 =?utf-8?Q?BUnTQtmOfU4UtFmcou?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83497869-6bc5-4767-9513-08df18ea62c7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:45:07.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMKtUED1B/y/0wBrcHpI+Mf0zOeiD47/G83y8ngD4pwuyX3nRzuvEfxlq4uOK6nPJfxGRFKsx1bu8iV3cqQ9nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB310634



On 9/21/26 9:16 AM, Sean Christopherson wrote:
> On Mon, Sep 14, 2026, Pratik R. Sampat wrote:
>> When injecting an event into the guest via the event_inj field, a
>> non-zero event_inj value on #VMEXIT means that the hardware was not able
>> to inject the event into the guest.  This used to only occur for the
>> VMEXIT_INVALID intercept code, which was a fatal error and resulted in
>> the guest being torn down.
>>
>> Enhanced SMT Protection (ESMTP) invalidates that assumption.  When ESMTP
>> is enabled, VMRUN doesn't enter guest mode immediately; it stalls at a
>> synchronization point until every sibling thread is either idle or has
>> executed VMRUN for a legal sibling vCPU.  If an ESMTP timeout / illegal
>> sibling exit / interrupt arrives while VMRUN is stalled, VMRUN can now
>> terminate with the corresponding #VMEXIT intercept code, without
>> entering guest mode, and thus without injecting the event.
>>
>> For example, on a 2-way SMT core running vCPU0 on thread 0 and vCPU1 on
>> thread 1:
>>   Thread 0 (vCPU0)                         Thread 1 (vCPU1)
>>   ----------------                         ----------------
>>   Interrupt A injected to the guest             in host
>>   VMRUN                                           |
>>     |                                             |
>>     v                                             |
>>   Stall waiting for sibling                       |
>>     |                                             |
>>     |  host INTR arrives on thread 0              |
>>     |  while it waits                             |
>>     |                                             |
>>     v                                             |
>>   #VMEXIT                                         v
>>   Interrupt B injected to the guest              idle
>>   VMRUN
> 
> So how is KVM_RUN_FORCE_IMMEDIATE_EXIT supposed to work?

I don't think KVM_RUN_FORCE_IMMEDIATE_EXIT should be affected negatively right?

On SVM, it queues a self-IPI before VMRUN. Normally, VMRUN enters the guest,
consumes EVENTINJ, and then exits with VMEXIT_INTR; EXITINTINFO may describe
interrupted event delivery.

With ESMTP, the pending IPI could terminate a stalled VMRUN before guest entry.
EVENTINJ would remain valid, and this patch would requeue it for another
attempt. That should preserve the intended behavior across retries. Of course,
progress would still be gated on it being a legal sibling to begin with, but
that should be fine.

Thanks,
--Pratik
