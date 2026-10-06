Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CEF49E5E4
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302232; cv=fail; b=OtXbI3x0GkS3cDuR93ISqMJQMpXtmD7+5fOrZy0dkbV7DSnn0b3eMLbVHMmlazzdnRm2Dos0z8FK7r6EZhw7TvKivA9/UWSJiKYWa0sHd7H0SR8XPVWt+el4Z6MXAwrVrh0WDDTytYEIMGPxM9Apxfr2bWgHuYJk21x/r3OozlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302232; c=relaxed/simple;
	bh=7qkA8nZRdpRpIXq6+FGVSJyAfl1qVBjGWoko0nhwv9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tW6RtdmI5SPR1LOdF+vgS+qBEuLPLpZSiXvZBAn3QdcE0TMqgAnlpNAwruZxs4wHpud3VZ2Aim5GDaBX9NGNo5kT2txXr5mRXo7b2JIRU+wjEibCnBxShnY8OaN/wN26OaSfM/8jIIQC+o0U0PERGxOD01sGrbj+hRl6gQQjVBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XZ/BaixR; arc=fail smtp.client-ip=40.107.208.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XZ/BaixR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUEM+RqA5XNsGxkvN8sODUTAIiQHmXSneoQEVuAgY4A73sHyOCtsCbgPOFhtrBIBvbtXtNUr7lyJr8XplnDKJdF7T1nn1LiXKj7ngr++gOkw1f1WNShPdZYa1VUjB5stbg3aZ23eH0EDwuF5R3wjf2zX831Pl3lOlyd721acZKbRNPkqm/s9+e4ITM7XTbAHV7cYjUTOXprWzTFobyPP1dPcG9orWwTOdmHz7WlGebArnrGn0mIGWwbIuKUMN0x/2OI9fExPWXFrh01MmfKcrpqw3pLWxN89uUVZMSpZCBCd55CtqmgTPZdPr9iNpDEeLx99e5tBrxrDNKaD97Iqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2atmfyBppi6QW09clGnxYyxnQW+Fbjsh0SyUrIOAI5Y=;
 b=IIOWBn1HM+ZLrfRyEHON7WJ076C3XqCk/Rc5WwRHnsRkGPcFtR8EWsMclsRkDeGUxbUt1bx3DhRq+vqNTqlL1dtRbyLx2h4xEpcuTO7dWrGIC3S6aHmGGBuuOVeL8A6obY9/Wn7lL5XUONYRnU8q6RX3CwTouFhKZJUezU2OCg7AaRC2GOE+00xBFClITVGA/9WRnOdqwQ1dmVBDiA+RqDE4kXwoRIu3ASA7vjvx8FMHHHX3Mrhlby/YPmtSpoTsDItiz2YlAWsXszPsgesnVjalwfkNfpxocojDSK3e+7L4ffaPaJzVpRERJcPIL/dKJHv5WFUQ6qXwvtzYWRWI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2atmfyBppi6QW09clGnxYyxnQW+Fbjsh0SyUrIOAI5Y=;
 b=XZ/BaixRqrFS+Q7MXcqoQcFZc8PRI5zLPtq9VTd24uVz/XYkgoGq51Fk/B1bWaFQTGP1vVsrsDcbQu9X8CMLchQD6Ekwsi1iZRVJcqCLP4ca2tTHxH3ZnWXmTXA6zjV+57JCpjyoNnbxd3PI7ayHXcmm3shS7VT7unlysZ/lnu0=
Received: from MW4PR04CA0299.namprd04.prod.outlook.com (2603:10b6:303:89::34)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 15:57:05 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:303:89:cafe::3f) by MW4PR04CA0299.outlook.office365.com
 (2603:10b6:303:89::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 15:57:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 15:57:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 10:57:03 -0500
Received: from [192.168.1.2] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 10:57:01 -0500
Message-ID: <c1e318dc-8260-41d7-9735-21647857f335@amd.com>
Date: Tue, 6 Oct 2026 21:27:00 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SVM: Clear VMCB save area instead of entire VMCB on
 shutdown intercept
To: Sean Christopherson <seanjc@google.com>
CC: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20260824131824.6040-1-shivansh.dhiman@amd.com>
 <20260824135155.6B0A41F000E9@smtp.kernel.org>
 <7fd7a6dc-9429-44d4-94b7-c7930536043a@amd.com> <asSA2uApsOMMCvgI@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <asSA2uApsOMMCvgI@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: f20d8177-53f0-48c5-76a7-08df23c277b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|6133799003|22082099003|18002099003|10067099003|3023799007|4143699003|260925021311599003|260925022911599003|260925021911599003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	jD6yTwz5d7ojlI8t1Uc/Zvb1LxbX/hKA8afApxr6W299hSPz8FsYGABzydEvZGG/KZE/tJ0A14QWRXgsYhFsXZRde2wrF817pluwK5uU3Ms96NRJmoMNw0hEnzTi8S//U/xJmoPaR6psKZw8LZkjhVcBYNuSry+l9yjwFQTBAtxEHNgJIqpfvo1Axh1MD9kbsVfs+dA2W4fmAM1QsG30/GOBaqnPKRfkQ4HgwikW2EZxlagTz0bkKU764uv7r+IFYjnSjy+glbEtz13xy4KY8XPHjI4eD50R1j88ilm2jzEzGfDoqt/BkwOsnJpDFaHz5R0ND4G0GwJw48n5sBfV96q9cgblxtNYVx+Lot+mNLGX737w/JNrXfj5c+/hLMmWpWMK7yAwHGDspSMnCT3VprTBHP6Jhq62jVJXB8aa4sbzVzogR0WwxfL6EwDYlHp3NVCBqf0vgSVCootrOIEIJVMTEK4smTjBuqvUEMxGUxSLizjfgs12WHPzCsL8qgDWLSaOjGXeXxmynItmL18EKpAfCjs0yhr1lRRdwRL5BT9iA53V27wD1g7qQGDvMb0azryb5R/3m0EIZS/CuCE7knDUlWvTdBwT0YFfSTo5KNABQB+qt8vuMLtTmZ7e+PH7O02vVCXkpGkRL4DlRPhrng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uzbHRFUv6RwdYlo1Js1zYgLC/TtcRZ5wzJkshu78YTNleMB0qNVC3p1raeL2YY5ykJhmf77lKZWg4apJ9mABRU1I7VKSJfaBVL0XOg0Yi41jyT+SWuHNtG/TVgpiISNhQlr5/lPpEhiORTpGRPG2Qyq8khufzxHt7WhHJqVrtg8OX4X06+4MBfeRMh3FTMJT600uCUdBCqfo/9aBkN/FvvAyrFit1XMfHJsNYz4FDhSXamqxd7uUk+mqYT1uPUW35V1KnpabpwMadoOYnEq1yPo+yeVb0sYIA7TIGHK52ZxbQUAAQuhrPLv/k/Oib5VbKgZzRzrPnBxaca29ZafoZoFlzz/K3NjQPQzGb3EuIiyMTaVhjabmCH/rLa12HNw/yyorEVn6nMCARi/fycgFpv9u/6gWrAG/L+t2mnJcJ/quiYJsLJFHTVBh7rZPma8a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:57:04.7302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f20d8177-53f0-48c5-76a7-08df23c277b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425



On 06-10-26 10:32, Sean Christopherson wrote:
> On Tue, Aug 25, 2026, Shivansh Dhiman wrote:
> 
>> On 24-08-26 19:21, sashiko-bot@kernel.org wrote:
>>>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>>>> --- a/arch/x86/kvm/svm/svm.c
>>>> +++ b/arch/x86/kvm/svm/svm.c
>>> [ ... ]
>>>> @@ -2164,18 +2164,23 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
>>> [ ... ]
>>>>  	if (!is_sev_es_guest(vcpu)) {
>>>> -		clear_page(svm->vmcb);
>>>> +		struct vmcb_control_area *control = &svm->vmcb->control;
>>>> +
>>>> +		memset(&svm->vmcb->save, 0, sizeof(svm->vmcb->save));
>>>> +		control->int_ctl &= ~GENMASK(15, 0);
>>>> +		control->int_state = 0;
>>>
>>> [Severity: High]
>>> Since clear_page() was replaced with targeted clearing, do we also need to
>>> clear control->event_inj and control->event_inj_err here?
>>>
>>> According to the AMD APM, hardware does not clear the EVENTINJ field in the
>>> VMCB on a VM exit, which leaves the VALID bit set if an exit occurs during
>>> event delivery (such as a triple fault leading to SVM_EXIT_SHUTDOWN).
>>>
>>> If the EVENTINJ field is left intact across this shutdown reset, will KVM
>>> execute the subsequent VMRUN with the stale EVENTINJ_VALID flag still set?
>>>
>>> Could this cause KVM to spuriously inject the old fault into the newly
>>> reset real-mode vCPU on its first instruction, leading to an immediate
>>> crash or an infinite triple-fault loop?
>> The latest APM says otherwise. The #VMEXIT sequence in APM ends with "clear
>> EVENTINJ field in VMCB". Hardware clears the field on every exit, so there
>> is nothing stale to carry across the shutdown reset and the scenario can't
>> arise.
> 
> But that seemingly unconditional statement has hidden clauses[*]:
> 
>  : >> The second half isn't. Clearing EVENTINJ is not part of injection, it's part of
>  : >> #VMEXIT, and it's unconditional.
>  : > So that doesn't mesh with the above comment, which says:
>  : >
>  : >   Hardware clears EVENTINJ field when it injects an event.
>  : >
>  : > And it begs the question of how this patch is at all useful.  Because all this
>  : > fancy new paranoia is clearly generating #VMEXITs, and if #VMEXIT unconditionally
>  : > clears control->event_inj, I don't see how control->event_inj can be non-zero if
>  : > KVM attempted VMRUN.
>  : >
>  : > I.e. either this is all broken, or the APM is buggy.
>  : 
>  : My wording in the comment is misleading. The clear is part of the #VMEXIT path
>  : out of guest mode, where it is indeed unconditional. However, VMRUN can
>  : terminate even before the guest mode is ever entered. With ESMTP, the hardware
>  : can give out a garden variety of exits at the sync point. In this case we
>  : get a VMEXIT that implies the VMRUN never actually ran any guest code then
>  : EVENTINJ won't be cleared. Since the exit code isn't a reliable discriminator,
>  : a non-zero EVENTINJ is the only way to tell.
> 
> Ignoring that IMO the APM needs to be updated to clarify exactly when EVENTINJ
> is cleared and when it isn't, I don't see any point in not manually clearing the
> field on SHUTDOWN.  Common sense would say that it's unnecessary as SHUTDOWN can
> only occur if VMRUN gets into the guest, but the cost is completely neglible and
> there is zero chance EVENTINJ *needs* to be retained, unlike say the PML index.
> 
> We can certainly add a comment saying it's paranoid, but I do think we should
> manually clear EVENTINJ and friend, e.g.

Agreed. I'll clear event_inj and event_inj_err with your comment and post v2
soon.

Thanks,
Shivansh

> 
> 	/*
> 	 * EVENTINJ is cleared on #VMEXIT, but only if VMRUN fully entered the
> 	 * guest.  Manually clear the fields even though it should be redundant,
> 	 * as there is no downside to doing so.
> 	 */
> 	control->event_inj = 0;
> 	control->event_inj_err = 0;
> 
> [*] https://lore.kernel.org/all/d946de080e3dd34844a665c167179e4910fdc9d4.1789399214.git.prsampat@amd.com

