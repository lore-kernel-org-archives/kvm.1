Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91144746D1
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234756; cv=fail; b=qoN3+wmXMR6Bcn8iR4/WOpS8y/J07dCqkDIirCvEGsSWdKbUZQrqUo8kMwpZ3BAEBIpVneE9bj5scIWIeOx8talQq5Yl5Qz8sVlT3hIjerhGshpQJzTvdfunWpysu1G/nh55oKh2M+bDGmfa2bVgbyjDaIB/3LFoGwcaEmKtyPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234756; c=relaxed/simple;
	bh=kU7pQRgZl9EkFh+KJruAMXJDAOHIfEPutl49d79Pklk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L7b9C/rPDX0MJL3PRc3Xv1nLeQYIw4TVwnKWMBOFb8LTy1Qui1Gx2k6SljnFiAAA5Caf06qUWEgiG4S62cwHJskI59jlRg9Gfr/iCs+IqoEWhaSDmdvUPR7WJ8QsPO+zSqcEs0SXrH5B+usw+Zz70VTX8+tZMfJIdxz+c4y5lV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GzpstucJ; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GzpstucJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aB7k03nAqh84gPLAzXtxDfom9UloXiVNr14YfygIxDHevPW2E1tUCjw+JDrwWKjdDNtEmGc9ZX9IXNg6dbQc4X6J/eDwlScRTVoXO85/Q4Lcaepu9oGOCxOzUXDeUewX8ucH9Q/10nBIdYvoD86ba17Yc/+UyUhnSm+83fRUAHo4tLL97bhAn/Mv18stQlyTRPlKDnHtVqT/9v/kXyAOrMI5KMZFE0OMXOVGdkpkiu7ADUksgNwmvj//bNeB27Rtz9sJm3S+xb75TLwLP0tBp9czGp36EDalZuTk06FhQZT2vd4rq0KLnZq23Cv29eObENTbngXGDuD3ciIcrsllJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaeRPknB77XpEHGBCc7nG9DN0iW6oXU0kKwUUF6HxqI=;
 b=nbq8uN3srrGsSCpPC0cGpxHVgFAtls1wdQIUHSguE+270sVlqFMKtN0drprUcPUxuPqT3khQQJMtdvADNFnahA6gwOGw731fwlMjy5zkOIU0GM11kRE1EmzsDKMEGKmxdtH04WfpGnjH9+qT46j/TfSvCQ0HA3oLiTxDZvCTbRJzR6KLILvE8NG0Bkd/kNVVGVhbw1PI0bFwBRi/iEPwI19MUR6Y5CNmOg4GeRf4wxIe8GmxYDBdGp0mdFQe2SMxALRcYtZLpro/QSrjVGS/11JnIrauf6NwE3+mo/o9eYO+Gg/i+RrbJG7jrLlC5nuVmCnTvjq9Mzo6adGqSNdItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaeRPknB77XpEHGBCc7nG9DN0iW6oXU0kKwUUF6HxqI=;
 b=GzpstucJ2SZHtns4dx5i5yPcFiEv/6mqOOTbVEaS+TVc70xHuqd7b2GA5x7OLD/aPENyTArDKDCGmOGPPu9uTSZrLqufTfjWxXfCjDsjU2IPJO2CKUqrloPHkVWHWJpz/K+Z87aQk7Gbz47jL8Q29x6yuJC/j7+HicZn4EsWGMc=
Received: from SA0PR12CA0006.namprd12.prod.outlook.com (2603:10b6:806:6f::11)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 14:05:50 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::54) by SA0PR12CA0006.outlook.office365.com
 (2603:10b6:806:6f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 14:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 14:05:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 09:05:49 -0500
Received: from [192.168.1.8] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 09:05:47 -0500
Message-ID: <3a330905-d8de-4176-abca-0e05184f5ea1@amd.com>
Date: Thu, 20 Aug 2026 19:35:46 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] KVM: SVM: Emulate guest accesses to LBR v2 MSRs
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
 <20260724195040.630468-4-shivansh.dhiman@amd.com>
 <20260724201318.8A4231F000E9@smtp.kernel.org>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260724201318.8A4231F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: fda89706-f79f-4f73-d68f-08defec42374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|4143699003|56012099006|10067099003|11063799006|5023799004|10063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Y2wEbBJGIAS599i9SuQ8SOG4vqlwaV2Mnxc/ZxH5MXDzqhsK+hzw7Z2TY/8fzcv1CjWtA+elNyrhdlMWpnS8lxuM0In6C+CWum7d9JY7G1t1o/dXYQfWaD6mD6Bw8KTeJCyBuoLnMcMYonarBmlDc2wlhbs8bsfNgNZ7+iZPP2Jl7BiSQ7uVRE68Tu+f8CSivaerQD0c5o6RRNeVRUuuNtF5mHrr/YSqUBdq7039MvqkRDQfcpYVMpmqjq673Jf9WjkzBISmDQDendiFutHn26XauNqnCtFKgnWV0B17CVDUwgfb9BbQHXeCdMJi+dRayb/pLvOP24KTLYL3vwtbv+Rin5G8v01W3vuOrMgb+RInma2JQwl/rmh2N49WWsdOs4PR2zhbV/nW4IqO7lOG9EM5BlzZQXesqTjMUphyRgC/xKatx+WOMQHt3SwzrsJML6NxwdUeR6Q/R4k61+f8N0qiHKlR9l0ePonq36JsCz5ziSJROwfiX3GqBPYEUbz6ciaC48GduBjm04pK1qWtF4YjAibYyGReZ6rL/WNXZ3XJU8N0op6sQsDcq49Cw8MGlhCPHGil14st7jVW+o+bMbj3YyUH/lb7TnFxqdIaGwU/C8tXNWmHm8CjhUzNxBrFitEoVI+A2NlDtyDqbG7CnjNNcSCS1bypC3wdnG5zvVA5GG4wK7YHRZFQLoMjRl0DeHkrswzqi30hDF5HFHeSYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(4143699003)(56012099006)(10067099003)(11063799006)(5023799004)(10063799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/DlfHbrK0hvfqIdkLOPUPtbuTgS/V6lOM/DETW6SUt5jneiNUi542RtxQNcbgQSaU3LkxPGgGVZjkXkDyyuiZ6DY7u47bCJJztaRWVdY1BXPe2zLsD7Lh+puS+4anY3jSCPdWAal8Ojms1Udq/ljeAZQtVLY+C1SxeNBKlLE1Dz+BIyywhlJFtIAZoX8k1DbtS88R/z4/Vn9nAEtsg/b+4jDQmFfamSShyer7S2bcaQWSqTohe3UxtqXgHrU5zVP8xn/RTdHLkJZWW8uLcBUdU9VzpLWNpSY22JqSm7JQ17gL32DQmJ9RijKaN5mW+c+pgLNHsKht44Mz9DFpkxs1/NQY8opc2e6LrW4+1XL0c1WK+eOwqlAGJYv2c5kP1d75eavwOWffwRrnuQiYJzdruobVi1qjHi1LnnI3/4fp1rbMGU+cXuRUCkR4ukEKjb6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:05:49.4682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda89706-f79f-4f73-d68f-08defec42374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858



On 25-07-26 01:43, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] LBRv2 emulation ignores the `lbrv` module parameter, allowing guest LBRv2 usage even when LBR Virtualization is globally disabled.
> - [High] The newly added LBR v2 MSRs are missing from KVM's list of saveable MSRs, causing them to be silently dropped during live migration.
> - [High] Missing nested SVM state synchronization for LBRv2 fields causes state corruption and cross-tenant information leaks between L2 guests.
> --
> 
> --- Patch [3]: [PATCH 3/7] KVM: SVM: Emulate guest accesses to LBR v2 MSRs ---
> commit ea17366da9bcd5ccfa5c4c9307a6f68cda7d1255
> Author: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> KVM: SVM: Emulate guest accesses to LBR v2 MSRs
>     
> Back the LBR v2 MSRs with their VMCB save-area fields in
> svm_{get,set}_msr(). This is required when guest accesses to these
> MSRs are intercepted. This allows the guest to retain the values
> of these MSRs on VMRUN/#VMEXIT cycle when vLBR is disabled.
> 
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index ef69a51ab27f9..13ac62604ca05 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
> 
> [ ... ]
> 
>> @@ -744,6 +744,12 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
>>  	svm->lbr_msrs_intercepted = intercept;
>>  }
>>  
>> +static bool svm_lbrv2_supported(struct kvm_vcpu *vcpu)
>> +{
>> +	return guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2) &&
>> +	       kvm_vcpu_has_mediated_pmu(vcpu);
>> +}
> 
> [Severity: High]
> Does this capability check need to respect the global lbrv module parameter?
> 
> Unlike the legacy LBR logic which explicitly checks lbrv, this function only
> checks the X86_FEATURE_AMD_LBR_V2 capability. 
> 
> Could this allow a local guest to bypass the host administrator's explicit
> disablement of LBR Virtualization (when loaded with lbrv=0) by directly
> accessing LBRv2 MSRs?

The lbrv check is not needed here because that capability is already gated
on lbrv in svm_set_cpu_caps(), and the guest cannot have LBRv2 if kvm
capability is clear.

	if (!lbrv || !enable_mediated_pmu ||
	    !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
		kvm_cpu_cap_clear(X86_FEATURE_AMD_LBR_V2);


> 
> [ ... ]
> 
>> @@ -2882,6 +2901,21 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  	case MSR_IA32_LASTINTTOIP:
>>  		msr_info->data = lbrv ? *svm_vmcb_lbr(svm, msr_info->index) : 0;
>>  		break;
>> +	case MSR_AMD_DBG_EXTN_CFG:
>> +		if (!svm_lbrv2_supported(vcpu))
>> +			return KVM_MSR_RET_UNSUPPORTED;
>> +		msr_info->data = svm->vmcb->save.dbg_extn_cfg;
>> +		break;
> 
> [Severity: High]
> Are these new LBR v2 MSRs missing from KVM's list of saveable MSRs?
> 
> Because the new LBRv2 MSRs (MSR_AMD_DBG_EXTN_CFG, MSR_AMD64_LBR_SELECT, and
> the MSR_AMD_SAMP_BR_FROM array) are omitted from msrs_to_save_base in
> arch/x86/kvm/msrs.c, they won't be returned to the VMM by
> KVM_GET_MSR_INDEX_LIST.
> 
> Will this cause the LBRv2 state to be silently dropped during live migration?

Good catch. I missed adding the MSRs here. Will do that in v2.

> 
> [ ... ]
> 
>> @@ -3181,6 +3215,40 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>>  		*svm_vmcb_lbr(svm, ecx) = data;
>>  		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
>>  		break;
>> +	case MSR_AMD_DBG_EXTN_CFG:
>> +		if (!svm_lbrv2_supported(vcpu))
>> +			return KVM_MSR_RET_UNSUPPORTED;
>> +
>> +		if (data & DBG_EXTN_CFG_RESERVED_BITS)
>> +			return 1;
>> +
>> +		if (svm->vmcb->save.dbg_extn_cfg == data)
>> +			break;
>> +
>> +		svm->vmcb->save.dbg_extn_cfg = data;
>> +		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
>> +		svm_update_lbrv(vcpu);
>> +		break;
> 
> [Severity: High]
> Does nested SVM state synchronization need to be updated for these new LBRv2
> fields?
> 
> Looking at nested virtualization, L2 guest state is synchronized using
> svm_copy_lbrs() in arch/x86/kvm/svm/svm.h, which is called during
> nested_vmcb02_prepare_save().
> 
> Because svm_copy_lbrs() was not updated to copy the new dbg_extn_cfg,
> lbr_select, and lbr array fields, vmcb02 can retain a previous L2 guest's
> branch records. When a new L2 guest reads its MSRs, it could observe the prior
> L2 guest's execution trace.
> 
> Additionally, upon nested_svm_vmexit(), wouldn't L2 modifications be dropped
> because they aren't copied back to L1's vmcb12?

Nested support isn't part of v1. Will implement it in upcoming versions.


