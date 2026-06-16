Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103B331EA5;
	Tue, 16 Jun 2026 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646509; cv=fail; b=gqmBLz8WOoGO/2KK2tGnf3J1lG8A3H/9jX8qFh8uhl+n6YnlIrvxUhFCR8bCtT4OORN801pbgPftdLjBuDmM5e+RN6L9QPuif1UXvz7MPbjKHWo3rZgOFE3AZ4peSkE8eBQM1kaH6pDL6GFaJxER4x/z2UlXaB9hst2mc4ePSIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646509; c=relaxed/simple;
	bh=jJhOwGu6MqQm4GbcaMraCGnfTCOlHFNZDejh/1XKdvg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TKGBbK9axVVXwiyM4BISjOQprjsyCdBOGdhXrP6hu4aIdRqMJ4WkyDDPhLd//E2r2dSjzfqy7VDjo0Zym1fv05bhLyKohZCBA5ooJD/0T2YiUoo7bFQqVDYW31nflnkzfLmKGrV/Qooh8U7jmfOhpuIiqJ7zf10ZTsB3oghdDvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g9YXPA4U; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g9YXPA4U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iv8lkz2GoghhCKcxbg3egeJq1q4BC0TQEVZk0zY+ExnOWLnI3CgwpY0AX0WRLU4er8DR195MHekEUZVjALalvsxFs2B8dBW2zoNIxN4bQN0A94tWXf9FCJd2LASz1x+dyYCtBvg1TM7yTJ8BFaihoFaRgpKGioLNVPFSUAAmtunrKwvwUeuDXLH6XaNYMFcO3EjG0v6a4KHGsJ9HsOywglaKziZ4CUgWvJQKaZsoMTztF1G2ZpDkuPztlK6Y8Fw0a4CjEvoyfBh65nSEBCoB92c6ORkXyeBYoK88BeapG0YiDINVPnRv2MjCoRCtwpiVEwYHrZJ1E1g2rcfXL5974w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8JdV36phplOj1mwQ5UViIFS3a1gYZOHSHHQ/QXh2ak=;
 b=Ubd1QMhIsC/4nmkXyebFXgVUSdybs3EEpo2c+29ljyTuMFTQ6Riwu/OTluPouqvtAQN0M50G2gPlPe/KdCMJI0PUL9mEdngM3ZniEmGk2WOgtUFWHtBrnAQ2Gxq0rpoNl2wqi0TLWFPiV5VSAseHMaL3pA/yxg2/FbyG5YG1eqkBmYuYnHC2K4KBo8FUdVYkymCKvWoy4tja7xagTugmx2cCwpUOuyi0pWzdezSJ2J4XTCZpT6ZeCByoeywsdZ/+CKMR8I8QJxxn8qQ5NPD9kRDXw28UIWFpWizMapjHAwtYA9HdAal8Q2jdq6yEQ/xTOv/gD5bj0V+ShsnIDwqUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8JdV36phplOj1mwQ5UViIFS3a1gYZOHSHHQ/QXh2ak=;
 b=g9YXPA4U7d1mlw3wCbkzOgaq3PMChpL758W/rjFDQpx/gmkxzhjkRxbPMbOTFQvI7zsC9ut5V8wl7VTYetM6bI1+E39Ex+3NeHqRlEIP92siWr3NczvOIlw/yOZdpYAWOwUZUnHQXl5NoD0yt4FP4M+F7qiTivYIcabSMF/mePA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 21:48:23 +0000
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2]) by SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 21:48:22 +0000
Message-ID: <1035a0d2-9239-4cf9-8606-6b1d34efbf00@amd.com>
Date: Tue, 16 Jun 2026 16:48:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] kvm: svm: Support guest-provided VMSA for launching
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev,
 Joerg Roedel <joerg.roedel@amd.com>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-4-joro@8bytes.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <20260611123528.572255-4-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::19) To SJ2PR12MB8136.namprd12.prod.outlook.com
 (2603:10b6:a03:4f8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8136:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: d01d0ad2-44ff-4ed4-a987-08decbf0fcc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e7DU7kcSj+4gxdbpJGK/0yRkYMWj5W8iMmutNj875CMJBmPhiwlvzTHxAW85hdsRUBpscO5wxRoJVigOZilvtpUk3V6U5oUZDWw4u27LGDbMNayRW3b8ynt77w0SJ0i78E4zD7PAqCXPBsQ5Ne0385x79EkRkQFGazCI1kPe1FnJpIuDpz/dm8MtnjS75lYHyLGpxRrQpLVFaPHLcSi7UGs1004xZTJXwjwa0dtSWFtw11DWJXt/eiOspbSw9VOglpQ2BxkuIIGE7UcP4GN6sU71PBZl14AIu9LlcgksILzZbxJevky+VWpVz2Q3O2M46F5rCtMU0vkgTJizIXJi6rqgrqTrEmClT/WcqYpoiKn9l/RObtGSgRPl1NR4wt8/ykIzzUfJ8pIW0hG4Dm9yrugydH2snLOhvu6bnCwmdwKCgL9W8VMV8uNHv7NnYCfBs2nHlQPQxUOLUYivwFXQ/uHPxXOHAKoTTe4fIVoL5jhLZ/CYVH2FfKNI/q8FhFfS65d/HmXa4CyirmMF0J8hbF0TVBAm/bPbZRvmo6mfbC0LiKnKeDKul1oBf+m6CcSKoz6m3kBT7tZXBtN/k3U1hk9VN3pJ8TgKdWKvodnrCcyRoufJeUK8BxYcfGbwD269LKCr85APbTLK01H0YjBh7aLiBcELEfomsXbEfjU9CiF7unDWTVgtGR1EcWn36Duv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE9na2J3cWM4eXpnaDhmZTNmNk1ZbURIQStrOERHcFdOcmo0OHdiOVNmZ2Ry?=
 =?utf-8?B?SHdsSEg3b3dhckpKb1dPenVLSFBwWHZZWXVpcXRqd3JxNW5MWjl3UkZIYXV4?=
 =?utf-8?B?bWl6STJOTWNRd1dkYTdheXB2Q3BJMGxweGRsSEIwWVJsTlZCYmZkMGMwTVRN?=
 =?utf-8?B?YnE3elM4Q0E1dFR2QjNnWmMyU3U1QU9uNTRJNFZwK0FSMmlOaXNCc3Z3andI?=
 =?utf-8?B?RnJWVGJGUlp1NlR6WWgybDFWY050MXNRVFp0SnJEa2N1VE5RdEhmcmdJZlJu?=
 =?utf-8?B?S1l6UmtONkZoN1hOV3pzamtvKzNLRFQ4K3JlRmtmQU0xcW5iQ2E0SFhoYUxl?=
 =?utf-8?B?Qnc1M01PdWpSWlFUT3Yrdm9NT0FpN0hZMC82SjdXREtCVTY5UWhwWkJLMUpt?=
 =?utf-8?B?amxxOTZ1SGFtWmpLNWxIUkcwS1psdmFoSnlIVHBNMERWWklMdXh2R010Vlhr?=
 =?utf-8?B?UXI1ZTB0TVIrMlhENkYwcUdubEJuTDNseWtESk1hMUhxQ1g2TnhTZUszNTBL?=
 =?utf-8?B?QlpmZ09CYVFSWXlYTXR1Uk9CMHV1YkxUMzR1dUpZNWxwQ3RxNkgyVGliaXBy?=
 =?utf-8?B?Ym9SVUhHcS9sYkNDMDArVWVzeENzOUllbDZ0WEMzWVFaY0s3b0Fvc2NEQXFk?=
 =?utf-8?B?U1ZIUXd4MVMrS0xNc3ZEMGxWQzdUN3dsTzFiNy9nS0RxajZxR00rQ3Z2STRW?=
 =?utf-8?B?Zko1V0V0d3pqYzh0L2ZyVjdnY1RZSzdybTBjLzdJZXBsL0s4MU5CY3ZQV0V1?=
 =?utf-8?B?cUVOaEVwNkRXSjdkTUd0b0hXRGFMNnowdmQrYktCbnFYNCt0dXZaWFkzeGJ4?=
 =?utf-8?B?S3d0djkxRXQwY0NsZXpQajFPUFBvcUZRS3pjS0V5L0VrRHdTeFplT1Rmb3NJ?=
 =?utf-8?B?ZVJWOXFqS1hITXNsYzhkcmJrdUkrSXhvWHVFK2w2YUtoSXJ3eHcyblRzTGVG?=
 =?utf-8?B?QXhuVmdpQXFkM3k2aUlBSUdWc2VCSGJPY3BhOUgvR3F0UUc3a0RreWFzbklN?=
 =?utf-8?B?cWExTm5BMHpyUGhnU2RxVVAzbkZaK0ZHcmFIKzZTNXQ1NzNjUXI5czNDYkNJ?=
 =?utf-8?B?K1RQSjd5cndENHZxZEtmeXpMZ1lxYUZPclJCZmxpWThiM3Byc2YyZnpZemhL?=
 =?utf-8?B?R3J3RUdkb0VVQ284M1hNRVU2aGtnMndqNkpUdFNBK2JLSVRuS0hXdUl6SWdJ?=
 =?utf-8?B?clRLUGJ4aGhVQU9kb0FoZjl0MHhuQy9mVmF5eWszY2M4TmVpdUVjTi83T25o?=
 =?utf-8?B?L3Y5Qkx2SXVnNktjaGdHSmRXQlh4OVZnWDhDeW1MRE93eHE4akl0ZWdNZ3B0?=
 =?utf-8?B?YnpkSU54VHVCMUdTWWVXY0lnOFB4cHRyaUc4QVQ1czdxd2pzWFhpNE9LTFAy?=
 =?utf-8?B?YjlqUk9CR2tFenFaSllsMkJvS0lRN0ZMZEFXRUI3QjRJQkJ6VkFwVTlJNDZY?=
 =?utf-8?B?YVZKeGszS0krb0lDWEVvc2djMGUrWkJ2N2RMVjNWWjczbDZCK1hRaTNhNlFU?=
 =?utf-8?B?ZmV3QXYvVHZqRlpjc2lkMzg3NmZVK2JHM2FaSzdLZFUxK0hLYUl2bXlYSFVZ?=
 =?utf-8?B?RjFQVzRKMHVIZm93ZFoyT3dGVE1idnRtY3BUNW5Obm1qcWdVQ1pTeGdNalM3?=
 =?utf-8?B?OVc1cTNVSjVDeU40ZksxT1UxYjVhZUlmK20wVVp2eWorVmVlZnpScGxmaUlF?=
 =?utf-8?B?VGN4SmExWG5jZVFuSDg0SThId21Ddlp5SE9LTURXaGQ4U1JzcUk3OG9oaGhO?=
 =?utf-8?B?NEFsek5ZS01iQVRMclo2RmNPUFU3eC9BdWZ1ZDRTdjZmUitxRTl2QkZDdG5N?=
 =?utf-8?B?WGZDbWRTYlRrbmhNSVRsOWo1RGVVNy9UQkJPODRnUEhSNlFBcU5OMGd0N0w3?=
 =?utf-8?B?TVlJdmVEM1dnNXIxV3FYWWQ5bENWc2ROc1d5OG11MHhIeDdyWVVCblZNYytN?=
 =?utf-8?B?VWJxdTE2TEZFMjFnR1VNTlZOOUFJUzNvU1lNcFJXcWxGUlRQYkpSRzVxVGIy?=
 =?utf-8?B?NnJVajhlN2J6djBmWVMzNXZQaHpWYXlnRjdIc0RxODJoUDZZd1FtSlVsL0o5?=
 =?utf-8?B?Mko1T0Y0ODJiSWwxN0dCV1NiU3JXOWVWNXNGb211Vk1YWXdGV0s4ODgwSmpX?=
 =?utf-8?B?enRTdm8vQXJ1Z2RiZjlLUDBpSTJYSDNKV3hmcjZFT00yanRNWkVpUTdiVDQz?=
 =?utf-8?B?Vk9EOUdFTGRPcTZ2Q2YzQkNwenJGQ3dVdzNSNklJUFpnTHRORFc5TDBkbUlp?=
 =?utf-8?B?NmdLNzVhL1oyOURCVkovZnoybHBFdjhuWTBIQ0luQURYdHJoT1hOaTVLQXRR?=
 =?utf-8?Q?f+hOPKtr+WxA92Itrx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01d0ad2-44ff-4ed4-a987-08decbf0fcc2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 21:48:22.8040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzC5WlGV7wYndS/11KUBgKSffbuwt/QeC/9KQwrT1vFlaFbh3Q4NJs5QCi5STTh2yLTypAZHm10olzrl2jZ0DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265

On 6/11/26 07:35, Jörg Rödel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> 
> Introduce a way to provide a guest GPA as the initial BSP VMSA and
> avoid allocating KVM-managed VMSAs in this case. Only one
> guest-provided VMSA is supported at the moment as IGVM also only
> supports to set a single VMSA.
> 
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 62 ++++++++++++++++++++++++++++++------------
>  arch/x86/kvm/svm/svm.h |  1 +
>  2 files changed, 45 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 350bb97c32c0..88db83b3ff8e 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -726,6 +726,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
>  
>  	INIT_LIST_HEAD(&sev->regions_list);
>  	INIT_LIST_HEAD(&sev->mirror_vms);
> +	sev->initial_vmsa_gpa = INVALID_PAGE;
>  	sev->need_init = false;
>  
>  	kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV);
> @@ -2680,6 +2681,46 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  	return 0;
>  }
>  
> +static int snp_init_guest_vmsa(struct kvm_vcpu *vcpu, gpa_t vmsa_gpa)
> +{
> +	/* Only one initial guest VMSA can exist (per IGVM) - so it belongs to the BSP */

Maybe expand this comment to indicate that none of the other vCPU VMSAs
are created by KVM, that the guest is responsible for creating them for
the first time.

Which reminds me that you will need to provide the GHCB APIC ID List NAE
event support. If OVMF was ever to be built as an IGVM file, then
without that GHCB event support it will perform a broadcast INIT-SIPI
for the first AP startup, which will fail because no VMSAs will have
been created. If OVMF sees that the HV has advertised the event, then it
will create all the VMSAs itself and use the GHCB AP Create NAE event
for initial startup of the APs.

> +	if (vcpu->vcpu_idx != 0)
> +		return 0;
> +
> +	/* VMSA already private and encrypted via LAUNCH_UPDATE */
> +	sev_es_set_guest_vmsa(vcpu, vmsa_gpa);
> +
> +	return 0;
> +}
> +
> +static int snp_init_kvm_vmsa(struct kvm_vcpu *vcpu,
> +			     struct sev_data_snp_launch_update *data,
> +			     struct kvm_sev_cmd *argp)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	int ret;
> +	void *vmsa;
> +
> +	ret = sev_es_sync_vmsa(svm);
> +	if (ret)
> +		return ret;
> +
> +	vmsa = sev_es_vmsa_ref(vcpu);
> +
> +	ret = sev_es_vcpu_vmsa_make_private(vcpu);
> +	if (ret)
> +		return ret;
> +
> +	/* Issue the SNP command to encrypt the VMSA */
> +	data->address = __sme_pa(vmsa);
> +	ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE,
> +			      data, &argp->error);
> +	if (ret)
> +		sev_snp_vcpu_reclaim_vmsa(vcpu);
> +
> +	return ret;
> +}
> +
>  static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  {
>  	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
> @@ -2700,28 +2741,13 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		struct vcpu_svm *svm = to_svm(vcpu);
> -		void *vmsa;
>  
> -		ret = sev_es_sync_vmsa(svm);
> +		ret = VALID_PAGE(sev->initial_vmsa_gpa) ?
> +			snp_init_guest_vmsa(vcpu, sev->initial_vmsa_gpa) :
> +			snp_init_kvm_vmsa(vcpu, &data, argp);
>  		if (ret)
>  			goto out;
>  
> -		vmsa = sev_es_vmsa_ref(vcpu);
> -
> -		ret = sev_es_vcpu_vmsa_make_private(vcpu);
> -		if (ret)
> -			goto out;
> -
> -		/* Issue the SNP command to encrypt the VMSA */
> -		data.address = __sme_pa(vmsa);
> -		ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE,
> -				      &data, &argp->error);
> -		if (ret) {
> -			sev_snp_vcpu_reclaim_vmsa(vcpu);
> -
> -			goto out;
> -		}
> -
>  		svm->vcpu.arch.guest_state_protected = true;
>  
>  		/* VMSA encrypted - put it into the VMCB */
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 3d4799f09b23..cc7e84c230bb 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -117,6 +117,7 @@ struct kvm_sev_info {
>  	struct mutex guest_req_mutex; /* Must acquire before using bounce buffers */
>  	cpumask_var_t have_run_cpus; /* CPUs that have done VMRUN for this VM. */
>  	bool snp_certs_enabled;	/* SNP certificate-fetching support. */
> +	gpa_t initial_vmsa_gpa; /* Optinal GPA of BSP VMSA - SEV-SNP only */

s/Optinal/Optional/

Should it be called bsp_vmsa_gpa ?

Thanks,
Tom

>  };
>  #endif
>  

