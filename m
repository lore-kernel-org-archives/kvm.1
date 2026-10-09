Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012016.outbound.protection.outlook.com [40.107.200.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27FD4477FA;
	Fri,  9 Oct 2026 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573714; cv=fail; b=P6HZr3ahU/7bqJtkyWUYFzgsJm/FVaqXsOOcVaXhjMTzT4dgzOrl9AC8cu3NI/Bi1MV9OoXEMsQkk5EwQfSgLx8q7p1ab7R5qJhttpPcGXskTtrFR8GE1Y1IObIsu5Q8dK6JqAjsXAUaNYZkhWG8ARWEB4n9dT9jPRR9sYnXJ7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573714; c=relaxed/simple;
	bh=JElGrJ10sGNrUcg/E0BI1pTxS17HpI755JRtQMTWoro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EDr4jBMcAmBef0/gg6/Tt8ynW0x2kRZPREopp9O0FBzlWcqosNFcYrLHkR3mP0GKLiSYFSXatGQjTEEqUN2VaIjsgRs7DUcCtheSmluT0V6PIPjBS+sBpx3oWiJ9nH9E6ndTe/HXFH3Rx9yC0UzP9z6fEkjFsxWqHra8r7fE4GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IAiwkj29; arc=fail smtp.client-ip=40.107.200.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IAiwkj29"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4ndI5ENNzjIAL/KnWEGZyJI6TtRTHh2T7gWsABQCpv70BoirSCKkEakn9GM4qiS597zkydzO1uBBnD5d/oJOFv5wCcsJMWK2hYtdPYgjdBVehL3eBWfw/HA9LRpDMgRvV5hNuM1NtPumlpo3ZCsfuqvj7ST4WKisscxF9urkNPQ0c5WsLl0hbdOUa32nTF13NNhvQs57syW7BhVTx0xlBufwoqBadBM2/M/cnN8/yK9wp1utMOf/ev13fkzNmHN29PIs1kZchY90aBb9pvcQjjdPFWWypIP8dsybHCAjjbecpHfl8fYRw9H3P+3q6ACkbv6LVQ0irU/nyLfEC0oJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQbKKccWgslAIEANf4p+0nmHKLz8cFvtIh4fUEF3LXw=;
 b=wnG8/2lSWiyPmyCjrv6Bn22ya8wLGjDIh9VrMMIcFU1QnwO1/5S9sK4GsWbDJ4eS3g1RuFObjQgLj3Wfvc2GDDsum+FYSTRY73DwPucJ1bAJYZlxcrgL+pP9QzTdy3M7JuS3iZ1hs/oFbO2tStOCt5z7Ead2tKWsTFtjZM89LFc7wG6f84EQHgmet4jbIwbqIwBkshSQPHw1z3SFlGYWP7EJw4HZff18SMbwzHqkUMhvp1Tjvl5nhnIPj698bZjbfmLGsg1vO1ZEoujFEFMvWNh+6tWINHi0C5yAOwRNfRwPUSdHfEPCC53MShjp7qTOitSZDQNY/ANmJSb9QaGOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQbKKccWgslAIEANf4p+0nmHKLz8cFvtIh4fUEF3LXw=;
 b=IAiwkj29Zzum69SGpAhe1zPffI6UZpZ+ZhMVh5e5J2qPeLqn5c5WLTAFEswYw4OhMQb7l69UqGbnwRxevRY+kTMEK2ucztPtyiR5tkE4gZJ3RZ5Eug37p8QW7vs8A4wsfZg6NrTvyeWppuppxzd2OWNoDGT8mYodZcMDnjwLYSM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 19:21:47 +0000
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2]) by SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 19:21:47 +0000
Message-ID: <0b99f2f4-14ef-462f-9cac-2a091ed355d0@amd.com>
Date: Fri, 9 Oct 2026 14:21:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/4] KVM: SVM: Re-queue events that were never injected
To: "Pratik R. Sampat" <prsampat@amd.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, seanjc@google.com, pbonzini@redhat.com,
 kim.phillips@amd.com, nikunj@amd.com, michael.roth@amd.com,
 ashish.kalra@amd.com
References: <cover.1791302373.git.prsampat@amd.com>
 <06cc309d12d59aed6d4b36688d8ef37fe8b089ea.1791302373.git.prsampat@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <06cc309d12d59aed6d4b36688d8ef37fe8b089ea.1791302373.git.prsampat@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::27) To SJ2PR12MB8136.namprd12.prod.outlook.com
 (2603:10b6:a03:4f8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8136:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6d2927-03f6-4266-da38-08df263a8fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|4143699003|11063799006|22082099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Vuaw7IiHhUUfThGNZEul8K4mhG3MJYmOSUSXRfVfhkOWdth+AqSpLuBb43eH0C8rAIsKrxs9iME5pqgE7Wbxbf7KLbfEGrDJLrUa1fmdhkrXamKEsy8DQdmqMD352XBGHqS+hHqoZk8+WgDA3eUXSIEoqyS53ur/DtH9nI5kw7t+mYJtcayC4y6NKDn4Rtlvg6VjGMiKAt6Zjy/D+q2dSW0vlqdxGuTBfocTQAWyY5U1Wx38diSL1hdwcqVTeO2Ije4Cva4dXo3P+YJIkrkyOc3owVBL5s5HpN6d9Y9Mx9JIom9sG6LnRsLomiHIHlz6skUf5ug+n7gYp3JvvjbcGNSYeuHkpA3WsHUwfX43mcEgqcNGXhwHOaiVzYu5b6gvJvJ/s0RuS8MrUDkUR3177NXI0s2lWSSzWvKDGXEbcEMtRSFc0o5Y/OcmUYhgm5C6dJEHCeAoT6wDlSpbaK2Yvj4yPBbrnt4dSRL0QsJWFXrwVHZJ0Kpc6IOJLF/qUgg/xfaELjNBESJSnGBHV5kaHCNTjUqrrAO6O1iCNuwdXer40HwGby4mnC1vcbXORyWmXea4rGaHmUI4KwMst6LDkqztabASx/H+iE60sCDVZ93g3RIXMaNbpUAORV1TNL7TWkCfvJ6saNmDS5d+rLj0sQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEdvMFdFM1VNdDhZTW1mODJqR0xCcXNXL0FpeVFqMHRXalBZTExUb1BTRjgr?=
 =?utf-8?B?b3dVVjhoUHBiL0tLZFFaT2ZTZXROYUx3dGJ2cWZXMEJ3bk14c1o2TEg2aEF4?=
 =?utf-8?B?dnZjRmtlRTdzZUptOXBoKy9pNFArMVdXVFBuWHVtVTE4ZWZaaXhsOWF3a1FU?=
 =?utf-8?B?MGZrZEpzN2w4UEFhbUdWWGRhRVN6WldhMzArU2syUFBISEc3eXVBTWhQa0k3?=
 =?utf-8?B?aWFpblpXbE1iTElRNGZaUEREZWVqWGlvdFpCbFcxVHdMU2F1SGpMU1RHUlhB?=
 =?utf-8?B?WlJPQXVOeTZsTHBvVzZ3QjNmdnNCdGpCVXpkS0NBU0xHOWcwaUhacS8ybmFu?=
 =?utf-8?B?OHpwdE4xZjJuM3JxQzZ5K3JBb2c2OWV4ZjRsRGlpbWJmRVFLR2cza2NmN2tZ?=
 =?utf-8?B?Q1BGTDBxU1ZLTEhyTlJZZktuelFyZ3NIR1I0QmFXUFQzQ1A1MFgwSHhJMS9U?=
 =?utf-8?B?MG9OdVB3NHdzTHo1ekZyc3hTeUFBOTRTbm5lbTJGem1vNHJPd2VVM1hSUzl2?=
 =?utf-8?B?SHpKOHdBSThiU2FYeldMQmxWVDdGcjhrNkFmSkFheExJSHQ2Y3Z1U1RsbVp2?=
 =?utf-8?B?Ym1iRk9MZElBRExnaFg1aXJ1cTRiWGs5YzIvRS9yQzNYOXJaeTdpV0o3ejhs?=
 =?utf-8?B?dCtRTktQQ21VTzE5UEQrbGxDU1FyTVA5aDhPTWNhSHowN1BuRW5JMUFrclFI?=
 =?utf-8?B?YlVBVlhxYUtJeTEzb3lNR1BJQ2hQUER4OThRRHlVbmN1V0Q3TnVaOG1ZbUVX?=
 =?utf-8?B?d0FpTkVxVjMwM2tlQVdMMVpCajM2VTNidmJLd09kSGF1MEZPUWEwVit6REMv?=
 =?utf-8?B?UmRsdE93VFlMdFlic1VPS2U3MkFmc1BEdU9SLzkveUlRbzNjU3d6NmFpanlt?=
 =?utf-8?B?dFVMNUZrekxpWk1meGhEaVZUcXJ1MEZuVFJIOG9QNWZ4eSsyb2pKdG9sK2J2?=
 =?utf-8?B?QXhYV05MbklzUTJVVlMreHkyZXRXRGRCNll0aUVkYWxndWpUTmYvekVWRDRm?=
 =?utf-8?B?MlBCS2RJYXpaMi81MFVDV21mb1FZTUVjOHlGQ1FwR0E5NkJCK0E2M3hPOWRh?=
 =?utf-8?B?cnlJTUlGcCtzbGgyWFJYeXFvb09oRHlEUGROWUZzVUVtRWNaK0s0VTF2UnJ5?=
 =?utf-8?B?M3RhMWdZMlFJTGZQZC9sV05hdU05RWZ4L21oNTBCcmYwNk9LRmRMSnl5OUN2?=
 =?utf-8?B?ODBod09OVEFZaHpVb1ltd2F3S3lhWXlCc2xnd0NMV1oyS2phKzY5WUNLeGF3?=
 =?utf-8?B?STU4THJFWXVWTUY3OGtUWjhXUEZ6bHZOR1R4bzBoL1Jua2Jxc2RGYzZmNWg1?=
 =?utf-8?B?Tm5VZWVHTTZUamRnUXo1aGlWR0I2NmxjRmVuL3Uwa0ZINUxDTTJ1Vmh4VEFl?=
 =?utf-8?B?RmkvclBQNzNYRmJiU056ak8rV0lKeHJrRHFCRys3QWdNck1QR0RyMG5rcyti?=
 =?utf-8?B?SHVpemtwekVBbExEMW9WOTRtUmM5akdoT2dhTHRmRVVLVGxBZFg1UEFqMTVj?=
 =?utf-8?B?UmF6UUcwTDVtUEZqNkxZMFRoTk9WcG84WVQ0Mzg2T0RHWmtGYmZoeXlSU3Rv?=
 =?utf-8?B?QXExVjhIMnZQTzluZFduR1hKMncxcnpjdUFodWh0bHVLQ05VVVB0VzJLb3J1?=
 =?utf-8?B?RXcrZ0V0aE0xL00zNHdlSlpHcE9HaUdTUzNFeWlkb0sxdTlGNE1lVXNUZkJn?=
 =?utf-8?B?Nlpmc21rcHJ2RTJ4a1kyU2JtZ3N5T0EyUC9zYjl2NHNFZEdDY05KcWZETGVT?=
 =?utf-8?B?djMrTk9reXowV0VKWjROQU1MTUx3akdrOHVpUzJyWnJLS2RkOGdZWkY4RGpB?=
 =?utf-8?B?S0h1SjArKzBoVVdwZHErdDRJd2NJWHVxSisyZUxaYUVqS3hVdGNsNnc3ZWhj?=
 =?utf-8?B?aVhZTTZPMXZsS09OUXFuNUtneGJaUTQ0ckk0azBwNkViRGF5N2x5ZzlKdGo3?=
 =?utf-8?B?TUxOWEpUUmIxS3RKSXJJWDhzcHZodmVwaUMxd0VFR2lPSmJnR1VUNk1iR0wz?=
 =?utf-8?B?VUVnVnNIazdISmVaZXdQVk1FWVJyZWZqM0VTeGRYNitvMGd5MlM0VFdlVHpC?=
 =?utf-8?B?ZTRlN3Qram5XODJhN2k4bDRiay9wcjMvVzlabUVKNE1DRStUSk02SDVhdkJy?=
 =?utf-8?B?YThhN0hTRGh0VTR0MGhJZkJlbk1ySUVwME9nY0hnQ3FlMnV5d1Y0cjFxVXhh?=
 =?utf-8?B?cTBtelJvMWErUVU1Mi9XeStCUjJTQUdsVUgyS09XYWJtYmJuaDduM0ZrMjR1?=
 =?utf-8?B?ZmN1ZkVrM2xUcE9jeWsvUXZOaWpqeEk2N2NucmxJQmZzams2Y1ZndjRYQUJs?=
 =?utf-8?Q?k8k/LYXmAdNdfbypRy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6d2927-03f6-4266-da38-08df263a8fdc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 19:21:47.5981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/qA9BAzXhRiTNAON50AjOJ/rOrMFGOPewEDjW9CykPv2HoCLYZyPBVS2gXwYSbXFvNKsPc1TZb6fLa0bNM2Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673

On 10/6/26 11:54, Pratik R. Sampat wrote:
> When injecting an event into the guest via the event_inj field, a
> non-zero event_inj value on #VMEXIT means that the hardware was not able
> to inject the event into the guest.  This used to only occur for the
> VMEXIT_INVALID intercept code, which was a fatal error and resulted in
> the guest being torn down.
> 
> Enhanced SMT Protection (ESMTP) invalidates that assumption.  When ESMTP
> is enabled, VMRUN doesn't enter guest mode immediately; it stalls at a
> synchronization point until every sibling thread is either idle or has
> executed VMRUN for a legal sibling vCPU.  If an ESMTP timeout / illegal
> sibling exit / interrupt arrives while VMRUN is stalled, VMRUN can now
> terminate with the corresponding #VMEXIT intercept code, without
> entering guest mode, and thus without injecting the event.
> 
> For example, on a 2-way SMT core running vCPU0 on thread 0 and vCPU1 on
> thread 1:
>   Thread 0 (vCPU0)                         Thread 1 (vCPU1)
>   ----------------                         ----------------
>   Interrupt A injected to the guest             in host
>   VMRUN                                           |
>     |                                             |
>     v                                             |
>   Stall waiting for sibling                       |
>     |                                             |
>     |  host INTR arrives on thread 0              |
>     |  while it waits                             |
>     |                                             |
>     v                                             |
>   #VMEXIT                                         v
>   Interrupt B injected to the guest              idle
>   VMRUN
> 
> In this case injecting interrupt B clobbers the last event. Interrupt A
> is never delivered and lost forever.
> 
> Therefore, in preparation for ESMTP support, accommodate for potentially
> lost interrupts by detecting an undelivered injected event and
> re-queuing it so as not to lose the event.
> 
> svm_cancel_injection() already recovers a staged event this way and
> becomes redundant, so fold it in.
> 
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> v1..v2: No changes
> ---
>  arch/x86/kvm/svm/svm.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 7d59d301e1e5..5d15c706e43b 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4340,6 +4340,7 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	u8 vector;
>  	int type;
> +	struct vmcb_control_area *control = &svm->vmcb->control;
>  	u32 exitintinfo = svm->vmcb->control.exit_int_info;
>  	bool nmi_l1_to_l2 = svm->nmi_l1_to_l2;
>  	bool soft_int_injected = svm->soft_int_injected;
> @@ -4347,6 +4348,27 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
>  	svm->nmi_l1_to_l2 = false;
>  	svm->soft_int_injected = false;
>  
> +	/*
> +	 * Hardware clears EVENTINJ field when it injects an event.
> +	 * A non-empty EVENTINJ on #VMEXIT means the vCPU never entered guest
> +	 * mode, and thus that the event was never delivered.  Migrate the event
> +	 * to EXITINTINFO so that it's requeued instead of being dropped.
> +	 *
> +	 * An undelivered event doesn't imply a fatal VMEXIT_INVALID. With
> +	 * Enhanced SMT Protection, VMRUN may exit with an ordinary #VMEXIT
> +	 * without having injected that event into the guest.
> +	 *
> +	 * Clobbering EXITINTINFO is safe precisely because the vCPU never
> +	 * entered guest mode.
> +	 */
> +	if (control->event_inj) {
> +		control->exit_int_info = control->event_inj;
> +		control->exit_int_info_err = control->event_inj_err;
> +		control->event_inj = 0;
> +
> +		exitintinfo = control->exit_int_info;
> +	}
> +
>  	/*
>  	 * If we've made progress since setting awaiting_iret_completion, we've
>  	 * executed an IRET and can allow NMI injection.
> @@ -4410,11 +4432,14 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
>  static void svm_cancel_injection(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> -	struct vmcb_control_area *control = &svm->vmcb->control;
>  
> -	control->exit_int_info = control->event_inj;
> -	control->exit_int_info_err = control->event_inj_err;
> -	control->event_inj = 0;
> +	/*
> +	 * EXITINTINFO is stale as it holds the event from the previous #VMEXIT
> +	 * (or from the last time the current VMCB was run).  Invalidate it so
> +	 * that svm_complete_interrupts() requeues if and only if KVM staged an
> +	 * event in EVENTINJ.
> +	 */
> +	svm->vmcb->control.exit_int_info = 0;
>  	svm_complete_interrupts(vcpu);
>  }
>  

