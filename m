Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98F51B199
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109943; cv=fail; b=mGM6Jg4VpJh7nn+aF6GYRz5stV+KpJFfVCeU9vTRkNB6ochWMPbhQ/fJjxSXc5qyswiHGYJvAVwWiUc54HViYHG2t7uTPoQ+Yrz8zGKV+3PNKElrCGzBEiFPq7gV+4Td1E9jkL3WHNdr1rVjMcc7JAUaQNhfP8FLbr/6K5Yolek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109943; c=relaxed/simple;
	bh=Yzeir+EjYWW0hGrNJEsaizvUwbpFqjxDCPp4XAFsHKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pi0AqScuK+1JMYTzJ+qwHIMnhZXCI4YNcr+W3ui4cWqHFBfZxT9yGLHK1AZfB+7dfCtewAXXYTfA3GungGBtZ6Pu3FPF0txfLbXqRaxR5XuogLUxpF6kiX7zG3V+nJw0WtAV9OG61LJm3VAdD903TqNndHvSbLZWWswH31KsdZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H2t5Gv5F; arc=fail smtp.client-ip=52.101.53.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H2t5Gv5F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5OUUaYbkT+2+S3apYfuuZiU7k/hK5OpqmsIZoLCuAOQpiCEO3BWXMV5k6t/LV+1PYu573vjJitKcBzqpguxl801OBRqrgb8TJNET4JaI2kisuxtOelVjHdXfcHhAGe22gRlZK9xt3xYCC09jl5wFnQPsTzPdeLcSqqpN5XloPGP2tlTkCsQLCPa2yJfh+8jQnRORq6brPki2ITE92QpA7gsLbMAH2e3gVBPZ22QrA6oMDlmn/Mzyr8338hGPR9/6tQIjvPta+SnNhldqtJHC6zqo20ofg776DiTq6ZfojB8Wed2HJvMziIB7cnWBpf+11YUa0fXWu5FVtO3gRZQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnTKqLXaqmCIyNOso0FFHdq5PheHQNpaPEBLNgZ3gC4=;
 b=lMKQg+tFaaU013LmWjI50QP+d8KIUGqTqKVgT05+xnT40ZSvJmqxYRQGsJhGeaa8YVNJraN+kBWZNF9WxR6PVVkFw9F9k5yiACYDBHhSXWJiHUtim2ut4Jepc5SR0SrFNSQJWioMzC7HeYUwGP01xtCH+lsg1r4SVxN6igZMXMqRiHGGDZThkDNzF8X8s7Q3OeQQ/aHu4bSj1YyxRFOw9w0h7kw2oaeQ5iTvVTcu3BBUExTNA3c5tmL/iRegARrwNFwAwxNrluEGPsIrSUaATcviFnhwx9fexjR48QSccz8aemIMx0wNodrr00dyTYtq1svjjddpNbm0QUu5Lo/I5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnTKqLXaqmCIyNOso0FFHdq5PheHQNpaPEBLNgZ3gC4=;
 b=H2t5Gv5F3QTy7NJPNcqm7ileREyaurwKQtndYT0KI4sIc67MIX+V1oM81m+cs8q8ZNHUPDreyNtvuSaz/KiC39PKXD5pdQuGESCp3p8aFtMeLUbztjtEtMTPRzWGf4u5HshlAEAAx+IpMXu6MPObyHe5Hy3GA1Z7FZ17/XzGK3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:45:21 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:45:21 +0000
Message-ID: <23c9be41-c8a8-4499-9310-fc4e6247f55d@amd.com>
Date: Tue, 22 Sep 2026 16:45:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] KVM: SVM: Re-queue events that were never injected
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1789399214.git.prsampat@amd.com>
 <d946de080e3dd34844a665c167179e4910fdc9d4.1789399214.git.prsampat@amd.com>
 <20260914171628.8A4631F00893@smtp.kernel.org>
 <ecbb6fb8-fe61-4028-880b-245f94db0f9f@amd.com> <arFYHRzNFT886BME@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <arFYHRzNFT886BME@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::16) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 69168963-2c4f-4355-2d9b-08df18ea6b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H0gi/qVj3kNqJJRFlMRUXT9wP68ktQCWPnZPSpyig3zLamRyAe6SGsAc8Z9QncPRIFaUqQtyYodmPanCd860GuJhMb/S0DStDdyp8e1vueQp2buRpibV05mxwr/t3uf2l14lL76oN8NfopEuwBmZV9SvRaaczU8uFZCrB4nZMk2vi+U64JG6iBbJImPKaqXh1ahemxs5ye0zVheNpWrs0OL2ALlsHhlAVLyPDLtZ8zctdeuYmzs3s3fhVeTwnxZO8gagdEwc7Sa8VUChVe14AH5BDJTgQ/Hur/jFkmNbwT6zjBqbsATSdI601qxzHKGwXF3NOf1JbIUvx3kcUF6tSJinpQXb3JYf/SLHrOKYlo0rMP0CuzeZ5BPmEpmHu9XdWE9hznOQP8+ia/MkeDXQIthDnf9fscFY1dCu48tvNJOr4tVI0//Ni9bUiV7f3rzqJJPJyRaRpWDddfQ2b7u13+DqkFJX+So+5vsiW18CecckvvZhySkrmIQV9cysRNLUM5OY71ifpF/VdkJTCbRjyMiWejLBkoxNerOsPm0WXxbjOzyGo8M97C0mudjaF7uX6pd07yGWC9b13oabK5sESxSlDQuZZNB7dDXB5OINrDp0reeXSIek7ZEASQpnauqkvNt67yAigdKu/kZ+rHE9D0e/UDBblq/6AXfT+zW2YhI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGV2N09wZU1QcUFmTC9CdzdtRGIvdFhMNG9RazhqVmMzRnl6VkpGdE1WU1hK?=
 =?utf-8?B?YzVEdkVZb3VYdjN3UXFrNEpZWUVkdkM3UFRYalR4bGpjek1BYXlhdU9Cb0Y3?=
 =?utf-8?B?aC9OeU00RjF1UWtkaEZLa1k2ZHR4NS9nOTFqUEZUSldUSGhjZ1pmMnRmUFRC?=
 =?utf-8?B?RG9ScTVIcGgrbk9CRkphMjVuQ0NjS0VQTFFPNlliNWhsbHNHanB6YlNhODNx?=
 =?utf-8?B?OS9hbmpyQ3g1Z0hsOE5sRWJ0cFV4eGdHcEpsVExxa3JISGxuRVlydXd4YU9F?=
 =?utf-8?B?eSt3YWw2UGM1TTBJaDhYbGZmTjdQUDRUTHFoU2o3aWNvTXZCM1ZYUXpVd1Zp?=
 =?utf-8?B?Z2Y0RTJ6RmJ5ME5Sb25KeHBDTzIreCtIeHhwWlFqbFV4Y0F2eld4OW9QUG5C?=
 =?utf-8?B?bU80MFpUaEVhbVJPcXRJZmhrS3NOSWlZdlp1MW9DVjVpYzRtVGVKK3lKemp4?=
 =?utf-8?B?d1JKUC90d2xLVGlSZjI2L1c5VFFrS1lMeS9hWGZQWGVNaDMrc05CdTdzbnpB?=
 =?utf-8?B?aWVFRC9mNTFCK2s3R1BkNXBVNlVpanM1d1ZaRTNTa2VjWWsrQmgxVnVWUkgr?=
 =?utf-8?B?b3JMeWNPS0xpTXhHazBuOVRvN3g5RUFXZU9oL0VObVFGNFdIcjdSVUUyOE1Y?=
 =?utf-8?B?bUxpNXAvSG5XUmM2ZVlsdTVBNitpRHZpRDR4TFFiQWJVMTdlbkNtWlVmSkNK?=
 =?utf-8?B?QlcxdS8vWGd4RlRhaWJoMDZ1WnA3b29oek96dzh6OWFMU2lleGd6bTEyOTlk?=
 =?utf-8?B?VHo2RWFtNy9jcXRnbzI3b1lGVis5WFpIai8vMWJaUHlUSEhhWlU3SEZWbk5j?=
 =?utf-8?B?RFJ2S3pEcGIwcytTK0FWSlh2WklaS0JFUTFwZVVPODE0NjZwbWtjdEZCaWg3?=
 =?utf-8?B?TEJpRm1zTnFCa1dpelBuWGQ0bGE0YnJKV1VBV0d3a2pqQ0FpODlLaGpPZ2R3?=
 =?utf-8?B?dnB3WG9hZzVsRGhuZUtTeEtuQ3pFOWdyazZ5ZDgrVFFUMnhxZlpGMEhVL3Na?=
 =?utf-8?B?S2YrUGZHT0RSRWtaV1lrT293ZWE5MzRrVHNuWGxyYy95dE5EWGFOODFTTDFJ?=
 =?utf-8?B?ODJTTUQ3NG5iVEdoT05ZQ3NJTjNMRDNGZzlTTzUyRG5RTmE3Tkl4SU00NG92?=
 =?utf-8?B?ai9oMm5lUW1HRDNmall6YThsSVB2cGtMUjdIU3lNUVZwdmZWWlNXekNCRGoz?=
 =?utf-8?B?b0JuVjlQdzRFdFEyNkJvMnVCT0hOekI0Sy9tbmxDTS9pN2VLM2tZU2s4dlZk?=
 =?utf-8?B?dm55VkNUVmc2R2dwdFdWQ1YwUTdNSklaRnVFWlQ3NnpUQXRaeVZSbTNjaHhS?=
 =?utf-8?B?cFJ3N1VlYkdnUGJRandldGhha3pIUEhyTkhXc0Q5eldYUFpxbmlFNlM2ZWVK?=
 =?utf-8?B?NitJOGlBVjNwNnMzcGdYc2hHRkF5eFJvZUpLeERuUHJGVkpHbU54N3ZJQ2s2?=
 =?utf-8?B?akpXY09PMFF5VzdZSCtNdmowdWhtMHNyb2N1QUthRWJadWJTWFRHU2docita?=
 =?utf-8?B?bGVFTTZGQW82b29aRlBzNHBqcjUwU2txVnlmM0JHT05WZDNMeG42S1A5WHQ0?=
 =?utf-8?B?dVJzVVRwak5ORDBKVnJiNlpxVXAyekdMb1RXMDRmNEovZGc2VFZidER3eCt0?=
 =?utf-8?B?My9UeFhOY3BTbVNMcFl4Q3BtT0RKamxjbU0xMkUxREVvUUZvQmdSQ1VXbExC?=
 =?utf-8?B?dWFZT0NDb3hiNnl1MXc4elVnbk1wYUdTdEdQcEdhc1o5VUZNblRLNWZMeS84?=
 =?utf-8?B?Q2lMZzZyeFBYVlJoYlJ4OXlQZDZydkM5Qk5YVzJIa0lycW9EZ0JSZWxhMFBO?=
 =?utf-8?B?aDVXUGFiSndDRk5UWmhTV09ONy8vTzVkQktRc3NiRDlXZ2QzR1JsTnVsaDlr?=
 =?utf-8?B?dzRua2VMT2k1anBoQlRVMDFvN3JRUmxvZFprRDBFZnByQU1IU3pyTWNiUEtT?=
 =?utf-8?B?dkhvVWhMMm04a3l3UGxLMHBTeGRtK2F4dGU4cVk5ZE9wRWlVd0JPZG44WEZp?=
 =?utf-8?B?UDcyaUN3dmExckUwOE0vNXJCTFh5dC9MaVRwdGFJRUg4aWxERlgrcUZKcnJB?=
 =?utf-8?B?Tml1RXA3WHNxSmdMZnFNV3ZTbVFxZnZYeTVpOUxqWHhaSVp1aVJIai9wUWNl?=
 =?utf-8?B?NEkwblFvbEtoQVdYUGYzREtkdU1PbkVpQXEvQ2F0bXl6eWVzVmpNV1ZidWdG?=
 =?utf-8?B?YnovYUJETkVlSzVyVlFmaHZkajhMYkVuQUd1L0tTUzBwYm14bzcxK0w3enFK?=
 =?utf-8?B?VjRPYVRES2NPQ0J6QVFUWVZjcS9Cc3lrK1Vhem51bTdzWVFldzhWK1ZlTDQw?=
 =?utf-8?Q?YgsTsX6UD1S3KQADIW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69168963-2c4f-4355-2d9b-08df18ea6b42
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:45:21.1821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3iV9ol7LiQcjgzCosC342hVaFHlKgSU/LjYEKwKdl9h0ITY4Yy+1W+IOiK194h3tf3gSVDqHOY11FdvLQJuTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197

Hi Sean,

On 9/21/26 12:15 PM, Sean Christopherson wrote:
>>>> +     /*
>>>> +      * Hardware clears EVENTINJ field when it injects an event.
>>>> +      * A non-empty EVENTINJ on #VMEXIT means the vCPU never entered guest
>>>> +      * mode, and thus that the event was never delivered.  Migrate the event
>>>> +      * to EXITINTINFO so that it's requeued instead of being dropped.
>>>> +      *
>>>> +      * An undelivered event doesn't imply a fatal VMEXIT_INVALID. With
>>>> +      * Enhanced SMT Protection, VMRUN may exit with an ordinary #VMEXIT
>>>> +      * without having injected that event into the guest.
>>>> +      *
>>>> +      * Clobbering EXITINTINFO is safe precisely because the vCPU never
>>>> +      * entered guest mode.
>>>> +      */
>>>> +     if (control->event_inj) {
>>> [Severity: High]
>>> Does this code silently drop valid hardware-reported events?
>>>
>>> If an L1 hypervisor sets event_inj to a non-zero value but leaves the
>>> SVM_EVTINJ_VALID bit clear, hardware will ignore the injection and won't
>>> clear EVENTINJ.
>>
>> The first half is right, nested_svm_check_event_inj() intentionally returns
>> true when V is clear, so vmcb02->control.event_inj can be non-zero with V=0.
>>
>> The second half isn't. Clearing EVENTINJ is not part of injection, it's part of
>> #VMEXIT, and it's unconditional. 
> So that doesn't mesh with the above comment, which says:
> 
>   Hardware clears EVENTINJ field when it injects an event.
> 
> And it begs the question of how this patch is at all useful.  Because all this
> fancy new paranoia is clearly generating #VMEXITs, and if #VMEXIT unconditionally
> clears control->event_inj, I don't see how control->event_inj can be non-zero if
> KVM attempted VMRUN.
> 
> I.e. either this is all broken, or the APM is buggy.

My wording in the comment is misleading. The clear is part of the #VMEXIT path
out of guest mode, where it is indeed unconditional. However, VMRUN can
terminate even before the guest mode is ever entered. With ESMTP, the hardware
can give out a garden variety of exits at the sync point. In this case we
get a VMEXIT that implies the VMRUN never actually ran any guest code then
EVENTINJ won't be cleared. Since the exit code isn't a reliable discriminator,
a non-zero EVENTINJ is the only way to tell.

Thanks,
--Pratik
