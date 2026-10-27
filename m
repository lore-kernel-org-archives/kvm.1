Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793083269;
	b=OuwP/kPV/xdgJD55q10081Mmm0Ej+QNlL96f7QrEDjAUrv5ITRWHZ2H669Jz181l1Xl+
	 2sZUsFhgfTvI+JBzsZNSZU4LzIDVjek6bKGZRHdb9Szx9LrawBke4oJEs7qnKjr9F+ewX
	 IP6fjRpMIvcfHfCbtWlI3gY5X/Qy0iCh7QjHzfYH+a44kJc1pHPs040GBs/fD+5SwIfdk
	 FP7JX4PnknyAMjDYKV2smUcHIqm1zpG2W6aw2WDvfwxrWTiu50gjPqh/e+VhpSrTAt/nn
	 XKaMmnEUlwmpx+Q4Vxza/kydgIrg5poKDAJuhcMsYCihy/Qluc1XTIyKKP7nn151wSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083269;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=D9jhrfki5Rzv3EMAPTS/ylJ//+mCdg1LCoGL4dgNgM4=;
	b=lwjQWdzgBEm4zQ8qfelWYzuVWurRfSppTrBflgkqUsRFHhI18CX9MiWspiC8KX73lcqp
	 nW/CrCBhBuRJmdMeCIdSTUXdRu/zYdug870Zp373UBoF82FvCknFgxtetDcbHwsnwh954
	 6htjhNk3ypaJxWx6vQWOwvOvOgHwu8n/hmLGL0IZaA+G9uhnfJWetFqIXMXedecg/zRM2
	 hLSYfViACJ50U4HQGatILP5i+LDrdZkcYxn/fB/qS8d7WAQkQitPgNCi8sEFXBoDO5zHx
	 O0uN4IY5meNJc3elkI7b8f2ToebPKIhjdCBW9xcsCTL+ABs0jAd1EKwkJ2uyp+ISX1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JtFNbwvK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.56
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5EB606A31A;
	Tue, 27 Oct 2026 06:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F5EB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JtFNbwvK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRF7w3kyiDeZC23DfN7iOe3zNO/Eky4EbDfzhJ3f44bkkb6yd+vnWG9EplXRq2xhbIYzHl3xVCCsbOVcifyjubf7IVV8PP/rFry4u859Is9GUVp0A7s+fBL5GSoafBpBHlUgf1AOVo1pNKQ1F6utpqEBYkBex6ZtURvoDzdIdut3He9XMeouhCdOb2+DeBq2bTsqiZqn0Q8ycL5s3EYTuPmdlaAMSAxcJRXyzQ0KVbGNDmI2V8vLja6+TJW9OJ9WiqCJtwEzNQiEwdOW6UVY8VKhZqSFNK6CiXjT8JfYVLjQLgzlfOSAVhhdKEu+MERubaaLD1DKA7RH5W12BXwYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9jhrfki5Rzv3EMAPTS/ylJ//+mCdg1LCoGL4dgNgM4=;
 b=VSImvrZD+XrUupXimj6YmhcY7Ym5T3UZCzzXdxcYbOCiW/s+xYfzLFBUR4Y48zqWJJRuVp83UD08RVdStUlLqyIaQd0HstAfJ/i4szxWBYpFGknzpGgH/8rGtKQvt3PRoJWOVeMgXZWBz63j1klRuffjqVnga99nSWEwX9/2B+yh6um3t4kwlVAdZ59XhFubfOjyMBaE6oJQ6qR+L+MQugSvVRXwZIdr80fi/5f3WvlMw4F0cBH4UNaewft5RiC1+0+X8wSM+n9WQ74yJJ0c6Ma5v4kRYP+RQ4w9HdanU9NyRSit6QUiV9vVaplMEmirAjSX/DU5cgB59h9QK4QS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9jhrfki5Rzv3EMAPTS/ylJ//+mCdg1LCoGL4dgNgM4=;
 b=JtFNbwvKXOuOW3vjUfGZYUtI/CCsN0KtUIx/J0R5ajpyFivtzdb6Auh/fizwbow02hQYryWdO9qRIvrEnMNIAc1QWFUKOd1w9LB0alCf20NFV8ELMiaKssB0OFrSTQp5YLj8JTE0lhMb0NFVOqYAgCRwxhO2huS6VdPXl107WHM=
Received: from BN9PR03CA0917.namprd03.prod.outlook.com (2603:10b6:408:107::22)
 by BL1PR12MB5803.namprd12.prod.outlook.com (2603:10b6:208:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 06:41:05 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::8a) by BN9PR03CA0917.outlook.office365.com
 (2603:10b6:408:107::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 27
 Oct 2026 06:41:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 06:41:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 01:40:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 01:40:51 -0500
Received: from [10.136.37.77] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 01:40:49 -0500
Message-ID: <575c1cde-7705-4190-9560-a1d6cfcb4dfa@amd.com>
Date: Tue, 27 Oct 2026 12:10:43 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Compute the max guest TSC frequency from the
 current tsc_khz
To: Sasha Levin <sashal@kernel.org>, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261024174525.1218244-1-sashal@kernel.org>
Content-Language: en-US
From: Nikunj A Dadhania <nikunj@amd.com>
In-Reply-To: <20261024174525.1218244-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|BL1PR12MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7ed99b-887f-4e97-1a55-08df33f54631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|261026121527099003|11063799006|56012099006|261022113327099003|261022075727099003|261021135927099003|261009223027099003|261021121427099003|261021123027099003|10067099003|261022105027099003|22082099003|18002099003|13003099007|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	2dnh+2YT6te7B5M+zAgp7iBYYVs/pWvbjOU41Z8zcax90Secm4h82iz73tWF2X21AXvGIWDkkJRdUOwKjZJ/VOUL/z9zjKuZK9IYVxZvqdVu+cN0edVNR9JyLnmoOVtsrgBen/d9hNdHYlUcSug5CqxXN+NvWuL8NilBTLmMCuAd88WWMHlkjTMM3IT0WHQDM+1TdpW0zXDj+VSS7inAPQkde8FZ3BeLMkBb1HLuIHKYnEIHSITLRCffgxt/NAzU6trVGDM14uCi+ZtjQzf03zifoudTuBXC/Kg2rT/iYFCl1PyR7zM3S8hZRERcuW8S5ZhHE78RmZu2Uq35N7JihmVFvyGl0gdmZeUxq10fKINt6LyMy0ZtE3oy8yC5R3Fmb+vtPG3jy0e/IGg0v5wLijb45idfp3RtKT0jaImiT57ZkQlWZNdx99IvhuqqEtPFXqesL1ieB14IK+24Tx/yP7aqDOElswn84txrTxtAIFzdF7uD+16+vgII1J+RWvn8Dl76LCiiylT+Izv7TmaXf6WmRDgSMnSk4kNWagcea0UXxDRGIRFI3YbmD9P6reRdFjNkhgxBiN0w52G5HSblM6e3jHrARiGTPbnJea3koncxEs4R2u/A0BnwccBIy5WU3rey2ELD+UHx84QasG4/AQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(261026121527099003)(11063799006)(56012099006)(261022113327099003)(261022075727099003)(261021135927099003)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(261022105027099003)(22082099003)(18002099003)(13003099007)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vcfxQpng8NbwSpNDjgxti6NUeGv9L8XignekDw9YuozDCLGPTvudE47qPaJPVNOuz/ab+VMF/rRKQQaqCSlnfuV4f/qeGkUcK9bkctxZizaZX+4dCpE6mJa57RJ+Hoiz1uluGU5t4EQD03b+AXy35ypysy6hSfvfvzRaUldv0YzmDx0RSDoUucoN9egLraJXgi9I06nlB2fYCoLqzmZpG+pBTXhcNMXv/UqdSjTGgBDcEZJhJYoDmeXYVIiOWfY5h7zdw9s8eNIvmFo5mQk2BJprfiDJJgYfBveh7065FA88iikTWc2N4PJFGqbH3Mlw6s6idGePyRM6c/EUh86J4GdvJU7bJ3gCB8xMBOctFdWbcGbFtA8LNj6H3u5Dn6LxFEi/6G4GlG8ZQ3LLGEOWhvqxvOtPAdK9W8eH+7awnPdXZRBLO0qNJ3XjZm6re144
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 06:41:04.7180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7ed99b-887f-4e97-1a55-08df33f54631
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803

On 10/24/2026 11:15 PM, Sasha Levin wrote:
> KVM computes the highest frequency that KVM_SET_TSC_KHZ accepts once,
> during vendor init, from the tsc_khz of the time. When KVM is built in,
> that runs before tsc_refine_calibration_work() refines tsc_khz, about a
> second later. If refinement raises tsc_khz, the cap stays below what the
> maximum scaling ratio gives for the refined frequency, and
> KVM_SET_TSC_KHZ rejects frequencies that set_tsc_khz() would accept, as
> set_tsc_khz() computes the ratio from the current tsc_khz.
> 
> nested_tsc_scaling_test runs into this on AMD: its last case asks for
> the frequency KVM_GET_TSC_KHZ reports times SVM's maximum ratio, and gets
> -EINVAL on boots where refinement raised tsc_khz. KernelCI sees it
> intermittently on a DL345 Gen11 (EPYC). On Intel the cap is limited to
> INT_MAX, so the test does not hit it there.
> 
> Like commit 741e511b4208 ("KVM: x86: Don't snapshot "max" TSC if host TSC
> is constant") did for the default frequency of new VMs, compute the cap
> from tsc_khz when it is used instead of taking a snapshot at load time.
> This covers KVM_SET_TSC_KHZ on both the vCPU and the VM file descriptor.
> 
> This also drops setting the cap to tsc_khz in the Hyper-V reenlightenment
> notifier, which left no room for scaling up once the host TSC frequency
> had changed; commit 0092e4346f49 ("x86/kvm: Support Hyper-V
> reenlightenment") gives no reason for that limit. The cap now follows the
> new frequency the same way. The notifier still does not recompute the
> multipliers of vCPUs that already exist.
> 
> Fixes: 92a1f12d2598 ("KVM: X86: Implement userspace interface to set virtual_tsc_khz")
> Link: https://d.kernelci.org/test/maestro:6adc828a55fda507607f79c3
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>

Tested on an AMD EPYC 9996 (Venice) with KVM built in (CONFIG_KVM_AMD=y),
booting with tsc_early_khz set to the refined tsc_khz minus 500.

The Hyper-V notifier path is only reachable when KVM runs as a Hyper-V
guest; I haven't tested that path.

> Reproduced on an AMD DL345 Gen11 booted with tsc_early_khz= 500 kHz below
> the refined frequency, so that refinement always raises tsc_khz after KVM
> is initialized. With KernelCI's x86 build of mainline 5b0764a53235,
> nested_tsc_scaling_test failed 3 out of 3 times with KVM_SET_TSC_KHZ
> returning -EINVAL. With the same config plus this patch it passed 3 out
> of 3, and tsc_scaling_sync, tsc_msrs_test, kvm_clock_test and
> nested_tsc_adjust_test still pass. A nested SVM guest with the same
> tsc_early_khz trick gives the same result, and with tsc_early_khz above
> the real frequency (refinement lowers tsc_khz) mainline passes.
> 
> This does not change the existing window between the cap check and
> set_tsc_khz(), which read tsc_khz separately.
> 
>  arch/x86/include/asm/kvm_host.h |  2 --
>  arch/x86/kvm/x86.c              | 30 +++++++++++++++---------------
>  2 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 1ee4b127004df..35a74f0eb45e5 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -260,8 +260,6 @@ struct kvm_x86_pmu_event_filter;
>  struct kvm_caps {
>  	/* control of guest tsc rate supported? */
>  	bool has_tsc_control;
> -	/* maximum supported tsc_khz for guests */
> -	u32  max_guest_tsc_khz;
>  	/* number of bits of the fractional part of the TSC scaling ratio */
>  	u8   tsc_scaling_ratio_frac_bits;
>  	/* maximum allowed value of TSC scaling ratio */
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 32563a91fba99..9e22072f39c18 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1156,6 +1156,19 @@ static inline u64 __scale_tsc(u64 ratio, u64 tsc)
>  	return mul_u64_u64_shr(tsc, ratio, kvm_caps.tsc_scaling_ratio_frac_bits);
>  }
>  
> +/*
> + * Use the current tsc_khz, not the one at load time, as the TSC frequency can
> + * be refined after KVM is initialized.  Make sure the user can only configure
> + * tsc_khz values that fit into a signed integer, otherwise KVM_GET_TSC_KHZ
> + * would return a negative value and confuse userspace.  A min value is not
> + * calculated because it will always be 1 on all machines.
> + */
> +static u32 kvm_max_guest_tsc_khz(void)
> +{
> +	return min(0x7fffffffULL,
> +		   __scale_tsc(kvm_caps.max_tsc_scaling_ratio, tsc_khz));
> +}
> +
>  u64 kvm_scale_tsc(u64 tsc, u64 ratio)
>  {
>  	u64 _tsc = tsc;
> @@ -3728,7 +3741,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		user_tsc_khz = (u32)arg;
>  
>  		if (kvm_caps.has_tsc_control &&
> -		    user_tsc_khz > kvm_caps.max_guest_tsc_khz)
> +		    user_tsc_khz > kvm_max_guest_tsc_khz())
>  			goto out;
>  
>  		if (user_tsc_khz == 0)
> @@ -4695,7 +4708,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  		user_tsc_khz = (u32)arg;
>  
>  		if (kvm_caps.has_tsc_control &&
> -		    user_tsc_khz > kvm_caps.max_guest_tsc_khz)
> +		    user_tsc_khz > kvm_max_guest_tsc_khz())
>  			goto out;
>  
>  		if (user_tsc_khz == 0)
> @@ -6749,7 +6762,6 @@ static void kvm_hyperv_tsc_notifier(void)
>  		for_each_present_cpu(cpu)
>  			per_cpu(cpu_tsc_khz, cpu) = tsc_khz;
>  	}
> -	kvm_caps.max_guest_tsc_khz = tsc_khz;
>  
>  	list_for_each_entry(kvm, &vm_list, vm_list) {
>  		__kvm_start_pvclock_update(kvm);
> @@ -7188,18 +7200,6 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>  	if (!tdp_enabled)
>  		kvm_caps.supported_quirks &= ~KVM_X86_QUIRK_IGNORE_GUEST_PAT;
>  
> -	if (kvm_caps.has_tsc_control) {
> -		/*
> -		 * Make sure the user can only configure tsc_khz values that
> -		 * fit into a signed integer, otherwise KVM_GET_TSC_KHZ would
> -		 * return a negative value and confuse userspace.
> -		 * A min value is not calculated because it will always
> -		 * be 1 on all machines.
> -		 */
> -		u64 max = min(0x7fffffffULL,
> -			      __scale_tsc(kvm_caps.max_tsc_scaling_ratio, tsc_khz));
> -		kvm_caps.max_guest_tsc_khz = max;
> -	}
>  	kvm_caps.default_tsc_scaling_ratio = 1ULL << kvm_caps.tsc_scaling_ratio_frac_bits;
>  	kvm_init_msr_lists();
>  	return 0;

