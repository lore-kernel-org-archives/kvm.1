Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E23876DE
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 05:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414756; cv=fail; b=FvECLhFbBbbvTId0W7ejNYEmTQAMCage7ee5k2bQzd/1LJI9IhtOenA0Y1k7GlZGnwFJf8fuAMGuWtLyPhnNpCvefvBinmV4f8NDCftjX8LwEM/QiyFDWsn7BrHybfHuLUlSpDjmJEORLSh+Liipc5YRmaP3E+ZcEwF7ag2+4HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414756; c=relaxed/simple;
	bh=EFiH+y+TlqEw3V/lO0HJeMObXRqfIn/C2PssyjPXtYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nhiP+qiWrq9mXUZ0cQgDaf8RTEXk5dBcUWFeZafuPXqyelOOIsSN3iZLXl7vTIcccju3uNEdSM1P2e8h1pXU7ix+SoG0XgMZwbtbNjQttyyazyIFcf2oHR97EHa3HZRCLGOiFZqSo5Aqc+AWwOJ/M9GUUMv3sRmpLrR7G0Pkx+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q6Z+NgYz; arc=fail smtp.client-ip=52.101.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q6Z+NgYz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WllUYH1oiGp5yXLbrmPsFtFm1dSH1MGQxj0tusqbPlyX94L9xGPmTo0JeitRdNBIUxIsP2kIVBrC5Rw/pAsF/wbZEjt/VTABEnCTam01OUwoWW1K6RxpZPLnBfmU+pOR5Z+GUWURuvjXb1OBss//SmKKRyxrSVBAVW0nTgVohVs8P/iGFmd0/kDefbn9fgp4ibsZBk/OjF92qjZfCjWk06uuda0udUVb91uZ920jMmMW3H1Fpt1MQ0LehMUr8O+BlhunE/1ZvnIhKA+fRJ2Y6mPJLfvzNXNXjblqo5GKw5sxdDUD5IV3AyJ6AIrg5m/FpEI4bfMXgyKgt/7xG4f4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdAJ/pMKYdl1aV8SLuAq9+PXnE6/9LbkK/WEGGsv1rg=;
 b=l2oeLUrLDnva8/Hu6WWP4V0wOfe9w5dIK8nL9JbMWrV2AlyWkRejVoARpgp3qDPJzvRY1ZusnIMY72ioZPyTC/cEg9NCRJOD8k47zvYlB3hdPhj5ZaniAUB032jp0MMRSkSbmDc091p1Q2LbdE5NtNUoRDZ1ENUbSDd9LxVFLxlRzB7nGiN90Tw9wuxF1iMJ6K1W7csf940YJ0z0SlXW0QlvnI33poMH7s+eItpuFHkgos/z2WJNr4JgD3ay9IUk9bHBnouPdaViYLEZBgC4N+PgMzZPq5ys1UIvWPp7hmGE11gTNMR9saG3zp3J1NPXYt8PGnEq2XD96lyC+hkcaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdAJ/pMKYdl1aV8SLuAq9+PXnE6/9LbkK/WEGGsv1rg=;
 b=q6Z+NgYzDoQzJtotMvADawn5x4qNuQGMQrxYWuDy0yo0No1Gfq/a48oveZ6RMq1GzzNbjZYHMmYut9LqzC3xcdQ64zKWcL0+yQEDbvJXmGi++8NRMjMQyvCFV6+VFpQQ3ah+LQG9QCcbZVW+cCAg4agzxv4Jas6PtiboRk95jh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 05:52:31 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 05:52:31 +0000
Message-ID: <cfd5168b-80dd-49d9-b88d-3634c20bac09@amd.com>
Date: Thu, 3 Sep 2026 11:22:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86/pmu: Move Intel PMU global MSRs to
 intel_is_valid_msr()
To: Jim Mattson <jmattson@google.com>, seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, likexu@tencent.com, yosry@kernel.org
References: <20260902184711.138538-1-jmattson@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260902184711.138538-1-jmattson@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::15) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: b829f3b0-4c5a-40b6-3561-08df097f8b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j/QbeReLTWDCO6XarDd7tl1U+CWijWwjhdCVGCk2BnG9lv9GFpTFUM3tO1um45nB7nDVPJOGEdkYlMUnFOA0JTXjkMg+iM/uRXPwimsJUBHqsADaYQUen02h7hxealBEdGPv+SyhI47Kje9HEzkszpdUWCcFpLu0USw9UYLjPmPVvA9Dc5Cau0+YckOJCICn56mQV+Duz+X1tOjB0xpyLHJLLfcNZyDFozONx73pO3kQrUTORUd5O3yV7vMuZL4MCocLlYNZrBwCBQRKwRc8vl0suCBk01TNZUV7r/Jz/i07zUkdxpoYay3hBPRH9kNjB/H3523e4OTE8KY2XkQbcwpsL15dI0JJ58jolL5/Y7tiKbpsvpi/f4wpDtgp2uw/fUlKTkBhqGYdWHRsKAS+dl+YS27IDT/bmG2UdituuUyeQlsh/l8RzPBs0NJH2KwOkxdYGkVctty0LRPGsvsH3snyFUCJIFduHsCKEBWfPJ+TRICJkASHDv9ghd4pkxH78bcLtXATSXhoq2MQdCgEhTsIg4heqrhPKeZ8SrF3B386Yo+9pKm3DoT4KMZz/UHlzpISIWuhckQDq5YeNLGRc/rCyqqBpqBJCV4hJtlFS/zFOtKcHi8VVze/w2Wc4psynpyoqLwJ/2qrLVxK2BDq5NQIpzK7dZwB8vzZ8iMgqu4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXp2QlI1ZHFUWHg5RFNYQzkvNWUvMTE0RmdtejVCOEwrR3h3U1p1ZnRZZ1JM?=
 =?utf-8?B?aVM2VE9rYlZMK2NnWVNFSGVkZHh5WXhqTTBOL2UvWDN1OUNuRXJid0RqWjU1?=
 =?utf-8?B?VFNtZyt1VjdIZWI3TklOcHlLWnZ5QW80ei85TW4rRlNkOFdkcXM4c2NWUzli?=
 =?utf-8?B?OHJSQVFoL3VWNC9ockNMNjFIdDlKZGJSN0lORkxON3dBNUF0OVhNZXlIWi9s?=
 =?utf-8?B?TUNJUFF1eWRacUtPNDBHdVIwa1BUZEg0MEFLWnpuS1FuY1UxSDJVejhUbW52?=
 =?utf-8?B?cklXNnpUQTNsSTVVaXgxc3hOSERjNGhvL2EvTXh3WDNtN09ZbzVjN2NqcmVv?=
 =?utf-8?B?aUdHUCtqM01NK1MrVXFzNy9CQUpFbE1DUXZoZ0M4TUNtdllnQnRtbEk4MlJD?=
 =?utf-8?B?eVpETWZ1TTZpbDdUNmpoMFAvKzJvMXBWcGJTZUVBbXB6NXExN3ZYTStReTE5?=
 =?utf-8?B?Vlc1ZVBUbWFlUm1HSElTclBkZTkrMyszb1hyZ1ZWaE9sNzNUd3Q1YTdrN3FQ?=
 =?utf-8?B?T3V1L1djOUhvMzQrUFRWRmNESlF4YUU2cys2UG1aMFFkZkhrRTJ4M2lERHE4?=
 =?utf-8?B?WEpqQzRLbWE3WjVWRndlSW95M3VvTDhxaFRINC9RMDg5ajN2SnFEWFRpV05Z?=
 =?utf-8?B?L011alFGZ0J0aWNkbWtZMmRTanBFY0FQTTVOL1paRmNtNGwrZmdIVXhFZlVR?=
 =?utf-8?B?UWtPNlpLT1E0LzNBNVRMSnRnTkJ6Sk5vOHlWczJNZUVOSHRrcXYrSEtTRjFk?=
 =?utf-8?B?WGxaSkxDL2czRG9EdCtDSzlUNkgwV2lpUHUxZWI2VVR2TFpsM2ovSFRaTGtL?=
 =?utf-8?B?RkRkM2wyY21Bb2JUMThKeEc4YlRqYVZDaGtBM0ZjN0ZXa2xHenhwUXRlaXFG?=
 =?utf-8?B?c01kNFhZUFlINVIrc1RqcTBlMkVKNFBNaWh4VXVOblI4ZmFobngxZUVTZ013?=
 =?utf-8?B?YWVKOUtWbzZKa3k0YnBGdENsa0NJcFNWWUYrYU0wcFVrckg4WjBUNjVTaGxi?=
 =?utf-8?B?OElvOHQyUGY4KzNrMVV5WUZ4S0hINytxcHArMG9wcTlIVHkwNzEyUDMwNldy?=
 =?utf-8?B?V3dKT1Z4dUljUkFYTDlZTWI3QklIdzJQc0lLTDNNOW4zQUxrRzd0YkZPM3pu?=
 =?utf-8?B?WDltWExWdEdGODBuMkVTL3ZwK2hwQlU4L2Q0SWYrcy85eVZxWG5oZ0FpK0Qy?=
 =?utf-8?B?ZzdBSnNBVC9nQUg0dml4YThOeWpBb3NOaFMzR1NCbUlPVms0aVFjZ0N0aVNj?=
 =?utf-8?B?SUlvY0M0VTNCRU0vTEFIYklZSlBibm9laFdKeUJjclN1Q1VZblk2NVpDY29o?=
 =?utf-8?B?Q2YxMmtaTEJGNW93VjBpWTQyY1BBa3hRclc5REh5ZFJrTHdtaFF2d21Pak55?=
 =?utf-8?B?T0lPWHBOQzZiNVBtZEVDYTZJTmJ5UkNPWk1BTFlsUGljSmtVbmlBQk1UUnhZ?=
 =?utf-8?B?Tm9LbmkrODBXU2RUMzJQSjdKMHovdnNvN2RYQ2hjOTNIdEYzbDVvOGRUOTdD?=
 =?utf-8?B?bjNXZjQxc0pTSks4ZGFPNytubjB4SVVPZ21TVmpZNm50c3JwYWFUaUZMMWpG?=
 =?utf-8?B?aFAzRGk4Ujl2ZVNnb0orK2EwcHk5Q3R4M25DeWwvL1dkbUJTNDJEMXQ0Q1FE?=
 =?utf-8?B?Tk1XV2Qva01mdG5OQzJsZWlsbHBYWDRMckxUL1AzYkxtVEh4Nk0zMXNUNzZW?=
 =?utf-8?B?NTVYclFYNW5ESjBva25aR2dWNXIvNEI1cGwzV1ByRXozbEM4NE41R1lwMlVk?=
 =?utf-8?B?ejNtUWZ4SXFHVTJIZ0JRV0c5L3Ntb2tIV3oyeWlpYU04MXh5VDNzUWRzcGFt?=
 =?utf-8?B?OTZocUdXVWpORDlCN3BRTWh2aTh6SkRCTWxRREMvZ05pWEFsUUlwUjI4ME5v?=
 =?utf-8?B?NXZxaXVpcUZjWmM1YmdSdFBucjNsQitOV3NaRWVkVy8xNEpqOVJJdS9vVkth?=
 =?utf-8?B?NDl0OGlRSjJ1VnFXTXFzWkUzTnhoQUYxZzI2SWgvdVBvcHNzSG0vVnh0NS8v?=
 =?utf-8?B?aWNFejVCS1dpcUNPL084T3VISnFTREN0NnFVdHdUSXJ0aWdFQjlZWmNXcEZ4?=
 =?utf-8?B?eU8wYzBMOXp1ejNZc1B6WTVObVZnc2huV3NGKzM5ek9GK09OOGZlMU40V2FJ?=
 =?utf-8?B?YjA0M0FlZ0JncC9PbjNBTkV5bHQ4TGNySEdBaE1MY01FYXJhS0NqUDBRMC9H?=
 =?utf-8?B?WmhIeE0yWkRJRmdSZjdabUZBUWlBWWdZeXRMWVZkeHR1dFVJWERZQ0FQTUNj?=
 =?utf-8?B?cjI5MmV4QmlLRnI4RElRWUJYU3hKeEcwald2QzQ2YXdoSHFuVW9VNjNKMDJj?=
 =?utf-8?Q?TPtPHS16C8zEhuRfh6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b829f3b0-4c5a-40b6-3561-08df097f8b5c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 05:52:31.5672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W32HeC/yUlbAkCsn5w5VczeSif3//a89HpuV0eQLLQBC8hOIHS1WTOg4EkNuZNmC6lqG/oWTK0RGH/sZF87InQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089

On 03-09-2026 00:17, Jim Mattson wrote:
> Commit c85cdc1cc1ea ("KVM: x86/pmu: Move handling PERF_GLOBAL_CTRL and
> friends to common x86") moved the existence check for the following Intel
> PMU MSRs to kvm_pmu_is_valid_msr():
>  - MSR_CORE_PERF_GLOBAL_STATUS
>  - MSR_CORE_PERF_GLOBAL_CTRL
>  - MSR_CORE_PERF_GLOBAL_OVF_CTRL
> 
> That commit deemed these MSRs valid whenever pmu->version > 1. It intended
> to share the check with AMD PerfMonV2 because both vendor implementations
> require version 2 or greater for global PMU controls.  However, as noted in
> the commit message, AMD uses different MSR indices for its global PMU
> registers.
> 
> Commit 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
> subsequently added AMD PerfMonV2 support and set pmu->version = 2.  Because
> kvm_pmu_is_valid_msr() validated the Intel MSRs whenever pmu->version > 1,
> KVM incorrectly permitted AMD guests with PerfMonV2 to access these Intel
> MSRs without a #GP.
> 
> Move the validation of these Intel MSRs to intel_is_valid_msr() and remove
> the common switch statement from kvm_pmu_is_valid_msr(). AMD already
> validates its own global PMU MSRs in amd_is_valid_msr().
> 
> Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/pmu.c           | 8 --------
>  arch/x86/kvm/vmx/pmu_intel.c | 3 +++
>  2 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index a7d60c8785cd..d2fd47ee5ec8 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -823,14 +823,6 @@ void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
>  
>  bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  {
> -	switch (msr) {
> -	case MSR_CORE_PERF_GLOBAL_STATUS:
> -	case MSR_CORE_PERF_GLOBAL_CTRL:
> -	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> -		return kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
> -	default:
> -		break;
> -	}
>  	return kvm_pmu_call(msr_idx_to_pmc)(vcpu, msr) ||
>  	       kvm_pmu_call(is_valid_msr)(vcpu, msr);
>  }
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index bfa8612fb450..70a8c4816135 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -187,6 +187,9 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  	int ret;
>  
>  	switch (msr) {
> +	case MSR_CORE_PERF_GLOBAL_STATUS:
> +	case MSR_CORE_PERF_GLOBAL_CTRL:
> +	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		return kvm_pmu_has_perf_global_ctrl(pmu);
>  	case MSR_IA32_PEBS_ENABLE:

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

