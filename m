Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCFC3CE4A3
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787640246; cv=fail; b=sFXLOgx9dpSSi2KNq2Ik8bP8baSZ/URST8zAVHhj+AwHCWVHTdtV413fYdWStDVb9u2FA8HgtUawPoYy2k3gS1nxfeDNEwz+YLBBauad3GIgakW7Xb1g/qihvwT2xAf6WzWAwLmAiFIpd8ycSjiiQhC9vOQRJXGXgdI8bGNciAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787640246; c=relaxed/simple;
	bh=NZsXAF6U+5c35T6gI8PrVmReM40KjdCC1ypra5voawE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pt1ulV5u0pwtF4lTDKHQwem4FeaLwLj9W5F+VG339xmHep2sIHi4uzfeZdYcs+sE0lsmPRIP1SznrBmOqqC0061nH/1xB8skUE+zBInY+Plw/M0SV3I3r1WSXy9A7o3r0XpsEFZiUshKZ5JlT9wGwVK8P1KaShDmYKWRYDjzSD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0U8GfJjv; arc=fail smtp.client-ip=52.101.46.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0U8GfJjv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGN/7evLk6MzUBwSW6HRy6QgSLHLzPJHg8PjhIvautHkxYrgPcOqOjGqdr8fZjXyx542ecRN+AaIb5swRhDksGDufCpRs2BjwwRk7GF0WiC4u/1l6E2hztvX7ik06uzcvqH+s2zQg/gywRBACNlNmi33oGCu7wZTbDlJmYIyNVg/1wVwwaLq8X8VSj2bOsxi/+aThic/v2ntE/Z1kCShVl0i7CWyXZ5AzZeC/G1L1eRdFOPcXg5RW+xxIPAFUmUuR0zyzaowWAn/fNo43b8vycj4kbiuW9RtWpVgSrz5lmngxy3bemfMgLw0daUOCEu4e0B+AdMBC8oSU+8fn4qjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JHjIxOITqJtWYfUXh9uGXwjmw/FcWF6jhTGt6MzD38=;
 b=rmCvCkrzOWvu5dHtDygAuT3JQdnjWggmSwVNWhWMIA1ypK7Os7wUUyJfknBXsojTTQkF5YzN3A8rYqI2q0YFl9VC1A1ylf4kE7ZR/4lOQHpijCNVIQl3x0x/U0pumybg4DULttR98AMr6qkCMLenife0gkho13ezKVVDiVIkjSt00Bv1kySWYPqziLQPZt0Zk1EjE611WpCbzmNGLUXacrEJl9gXskhmRyy1wWpXjafvVeyZXYla9Xp6adWgbmjBalZleQrHgpHL3YoWEpNDDrWe8thcIqc6ziE/Qw360A5oSE+Bqsg7LR2FVvVjAgQojPYbCWh4Q42ZNMbfvxs2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JHjIxOITqJtWYfUXh9uGXwjmw/FcWF6jhTGt6MzD38=;
 b=0U8GfJjv6NJiVMEglu/nDS/sdNrMV+w9wPfTzKAz7T8Ag/88piTb16zgsHu+nlPd3WpOk2g2XNV9d7Xg8B4J/V1FSeLdN6Zw8+Mdsr0rguf0xh3IT6xwq6joc83WsCBgOV1r+2VVawW8vyYJgCMwHgRRmHYQfuus72qtZgmkP5E=
Received: from MN2PR22CA0014.namprd22.prod.outlook.com (2603:10b6:208:238::19)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 25 Aug
 2026 06:43:57 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::8a) by MN2PR22CA0014.outlook.office365.com
 (2603:10b6:208:238::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 06:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 06:43:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 01:43:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 01:43:55 -0500
Received: from [10.136.18.168] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 01:43:54 -0500
Message-ID: <7fd7a6dc-9429-44d4-94b7-c7930536043a@amd.com>
Date: Tue, 25 Aug 2026 12:13:53 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SVM: Clear VMCB save area instead of entire VMCB on
 shutdown intercept
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260824131824.6040-1-shivansh.dhiman@amd.com>
 <20260824135155.6B0A41F000E9@smtp.kernel.org>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260824135155.6B0A41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2df9d2-5912-448d-31e4-08df02743cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|10067099003|6133799003|3023799007|5023799004|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	OlAAhhEaOMOC0IAqGxszA7xDPWpiKNqT7hJAMsx1KbV+Je25/TtguUGLGhjvch975bsFLA7Q75Q3jfP/9iBT0vfmTlOvT9gVowNockyPgOZrej9bPm0bpSlbw1JLMP7SlFTknRBgSP2IKlbHm1xE7f+HTDAPxpsrCzKJXd1Sgc9eX1DOdoSdQ+UKcPWbI5naNvdl9KVPLDz6CUOs1KcYiq9YAiLWIKh+CMfB04wc+ERWc9mIvHRXK/x47Hibgd/bUdL4L/GoBks8nMWaXHIcbWMRXV2vPX5eILhsvno69opXjc8i3jtPveRrtM8PjXI+JyrS+VmMRwc2CrO118zZmAs8rvnmbqQbAtEysMp6W1kF32K616UpCr2tiIUfK+5vbQRGXz4NLEl22VOx5Wv8WN66YqpDPEK/Tms85JaPR2eIkgccUDcUXSokEXC0Umt4+cLxpAeCnfOtecJov1OuiXCs41r45RLnnvVj9e5ow+O8nGMFndvZjfjKeBAzbMOrlBkyx/K6AgMIiFQvQvC8+9qIJ2DvF0mXjYFBmuWPllkwUXfCFnMGH5+Dm7Rl0XYP32HDf4XN0f1RABUjlHZR1Q6cr+QA7xf5r4/hIHXI3b/OGgsMpYOITDecDjlIDdGJ4W2ji+hKIYzc1FWIYAShvzdmQmWK/zDaNbGzCaIeSMGE7sX7QR11mz+MOkAQ7077sZke2dfGT/UVSW926eMNiA==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(5023799004)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3aV3o7j6fj54IHOIWP6PVrB3nCTYD87d/LyHRq3BMiaKLzff5DE24yHDk/Cq1Y51M03Ivzm9jfbulJIck8F9uhc3CECfkFwfhNkTBEfm/y7pGnrtBgMAcXXi5ZjixCcNE7fXFtiCmQsomoyUUHgG+mVhAh9swqndrkWuvaPNNseUIZeEOVSa9uUw31YXqB31Uel/5/PiM13eQ3iLk0edLqN1KRoRIEEGiNQrqa/k7Nob09WmeMeLmA/GP5g3KV3W5jEdB4TiR/NkxJk0JH37pD3uYNtA2e/tDl0tCdGmSrgK825nKdJNj0eJpyu1YIJFyia6Yh+1QsD9HZ7zCgo8vQ9j6bWkKtAI5bNogkTUtjwju+duGm8jTHl80PSe6D8GY5kW1B2/p3YgAgv6ZpCJqJf8PHWjn3JyHRiVzR4x4nRfFvD+KeSMiI3cJo1C/Xr9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 06:43:56.8189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2df9d2-5912-448d-31e4-08df02743cd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678



On 24-08-26 19:21, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing `clear_page(svm->vmcb)` leaves the `control->event_inj` and `control->event_inj_err` fields intact across a SHUTDOWN reset, causing KVM to spuriously inject stale events into the newly reset guest and leading to an immediate crash or triple fault.
> --
> 
> --- Patch [1]: [PATCH] KVM: SVM: Clear VMCB save area instead of entire VMCB on shutdown intercept ---
> commit 887c839299b43bfbaf990edaf22e0335bb4c3119
> Author: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> KVM: SVM: Clear VMCB save area instead of entire VMCB on shutdown intercept
> 
> This commit updates KVM's handling of intercepted shutdowns for AMD SVM.
> Instead of clearing the entire VMCB, it now only clears the save area and a
> few undefined fields in the control area, aligning with updated APM
> specifications.
> 
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
> [ ... ]
>> @@ -2164,18 +2164,23 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
> [ ... ]
>>  	if (!is_sev_es_guest(vcpu)) {
>> -		clear_page(svm->vmcb);
>> +		struct vmcb_control_area *control = &svm->vmcb->control;
>> +
>> +		memset(&svm->vmcb->save, 0, sizeof(svm->vmcb->save));
>> +		control->int_ctl &= ~GENMASK(15, 0);
>> +		control->int_state = 0;
> 
> [Severity: High]
> Since clear_page() was replaced with targeted clearing, do we also need to
> clear control->event_inj and control->event_inj_err here?
> 
> According to the AMD APM, hardware does not clear the EVENTINJ field in the
> VMCB on a VM exit, which leaves the VALID bit set if an exit occurs during
> event delivery (such as a triple fault leading to SVM_EXIT_SHUTDOWN).
> 
> If the EVENTINJ field is left intact across this shutdown reset, will KVM
> execute the subsequent VMRUN with the stale EVENTINJ_VALID flag still set?
> 
> Could this cause KVM to spuriously inject the old fault into the newly
> reset real-mode vCPU on its first instruction, leading to an immediate
> crash or an infinite triple-fault loop?
The latest APM says otherwise. The #VMEXIT sequence in APM ends with "clear
EVENTINJ field in VMCB". Hardware clears the field on every exit, so there
is nothing stale to carry across the shutdown reset and the scenario can't
arise.

