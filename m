Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F75393DC7
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856415; cv=fail; b=dEHTn51EOHMqmfC/MdQJqvO5Jw0iulX+euRZvrGfwx0ILcdh1npyh+Ixsqz7/Q52NigT/3dcS6nM7Z1FFWUReRRANMtyc05r45RwQ4xYeby7Am9TIq5iR0zFBqvVv5f7sf5oGW20o45n/wPmAAYkMcA60J2/etLJimlhyalFbnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856415; c=relaxed/simple;
	bh=m/n9zj5E7pl1bX28ms3FiifUCLu2A33XUN5qic+co8c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gGiNJBj3IaA7BSyfMkhnfbe7Bp18Lt+JuNzQXBQLIkFtCHpG1npK95L3gbAF3fWKBRt9vmf/is1GghLNY4098NH9c4KvK7u7bHjy4WbGn5clxfHnC7IW8UbqsEc3e+36O521wSw0qJY7dlRD6B4cgdhLaAJnczuTk4xOmeSbKnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bSVJj3tV; arc=fail smtp.client-ip=52.101.53.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bSVJj3tV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL2jAB0zO5Gwxe3Hsht3dr5v02SVKflIS/89WeeVmc8ZMIoETfh6Nk0QECv3VHIOb4ldsMnEDLn94oRMyv/Y1fbySJ5KJvJIDncXlCMZKCnSFZP8cvHsS+5rdx+8YS9BWPz0cyaRfwSZV9u7AUABVtJB4qcqyFNTY0FUkskiN9FP8PwdEsHJCsoJiRNG/fpDrH4ee/VNNerLh1ofNJvsZLC9BbRlO3+uUIRgZ2OT6//kIR5kd5n+S0wWMv6iWUIy959Y53jSg+Nuh9v/YXtQcr/AtBSXzscc/pAy8q9eVQybXZel1P6k4nDC4yJl7ea8IwsrQJRP4w6fdN20/D2Cxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsSPkaNVrc0A/RNsqB/ESsVEiSRSIANNbqIEtSlA7yY=;
 b=B6xuD/jQkwPP5Qm02fIfs5N8wWEzgIW8oLquzEoJQyWZqj4aeJbcxdAVRtFNI6nSSGH9fiJstcVTSp4M2huCACZFweOQAJslflIjfS3k+TU9MAApvhII1nGBUklh1BE/i+n54GXb/UtA+gc7FtlwpfVh5DhTZ5AJf0KNJ/rNBoMjMjRKfVvKYjS3S+q97CNJ900yTSImmj1A+8iyHEMEwSQto6P3bvTQxCd3Nl+OpAdRP7JH8Sp9MYxpOBB5jX6hsh/Ben0T1jVfIvGxBWcTy0KqhyrVJyD8ux+B5g5eLCi+PlGgIApj6wWXxXElcrRwLURjY4SfN7VDWnsVwC+1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsSPkaNVrc0A/RNsqB/ESsVEiSRSIANNbqIEtSlA7yY=;
 b=bSVJj3tV8ryI+IRRQ4hhexTmxrA2aheNTC+FJlTm4cB6ZwE54zShg2ptVGheEUwyBgMw3PbicHak7SpW4ivaCbwIif9ZJLysvHVT1fsRrRSGLOM3KPPThxsQvlp0j+MiCW4iTQgyjNffXV1+T51OHUcbN0zU1lON+F6R7EHC3i8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 15:13:24 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 15:13:24 +0000
Message-ID: <e853c904-cfee-491f-85a0-162e1a3997d5@amd.com>
Date: Tue, 4 Aug 2026 10:13:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: SVM: Serialize the owner's mirror list in
 sev_migrate_from()
To: Shen Yongchao <grayhat@foxmail.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <tencent_625C0F42824E542C72B34733392AF2C49709@qq.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <tencent_625C0F42824E542C72B34733392AF2C49709@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:610:75::16) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: c602eada-f986-484e-484b-08def23aed6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|5023799004|22082099003|6133799003|56012099006|3023799007|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2gk2IKcqFyq2NzYUQm6cpfFJkjSAFSoYeC6rThHVbTx0BD25I6zsdhmyca8tAMZVDN/moi0sJtGzNAntL4Rl4axzcE0+BjY/oXGysIrSBNH+eamfVL3lZfrFWPoDg87DmLYu+u803vVaN/hc4RKAaA7e1GkPnfjoYeDmf8p/AfMKDAbkJSmRfO2UwLvy5h90vm1xU1izWO/DWHjFI1RfZFvqGjzGAgjq4VYQim68nnK6gdKDbwTtTxp3BOkKqz0N/BrgbTTllRIGMsvtN8pq/F3IfFNHtrRs6NxEipQXyado8I235ovhhEorFFfJs9jIEjAOSZHkCINF3b2RA+j5EnbpbhG1PNm33BE0IsXuC07atO1/Qwlj0TFnEbvLlFd0PiaSuF32n41noSgmzp5BKLM/gauZBB5UJ1Fwtc8vpqhb2KrT7vVARD5T0qYvVrqLEXplzBWPZtnjHFU/IZxRms2rJJpgWA1HpSqaPtKnA5iQU9VsaNduL8Yj3ceJ1KxMSf/sc2KbbLCz7ueEYPbitCXpkSDu57LTTJgkd3l9FStGa3o8ksblcNCsQPB0rxbbqY2f5DzKeYDNKYio28VSaIiL3hks94JUf1jesQKuuOhL/Ps9nd+A2s1ITKODTG/71TX7EJl9MAPI1qtxpLOZmEpwQQmXhYM/frenCpJIJtU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(5023799004)(22082099003)(6133799003)(56012099006)(3023799007)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3FFOGg2VExjZnF5azZMZ01zUWp5cGo1RkpoTjFaa1c3N2VsSnRnbHlTaDhh?=
 =?utf-8?B?dm1XYS93R1huZEF1RGF6alI1aXZuWXFUV2dzd1RJdHM3aEdJRUw1S1p3S3RW?=
 =?utf-8?B?VVBBU0VLM2h2ZXNlbkFxaHF6d3VxWHBMdTlmQmdBVVIvbTBYK2ZHZG41N0ZM?=
 =?utf-8?B?WHNBc0xRZHBSekt5L3Frak1rdjJxY1gyMitlbWtVUTJLTG9XcWNEdW85OXlN?=
 =?utf-8?B?c1RqL2JlZ2FYaGZnU3ZjZmM5ZUdQSnlKQ29TNndISTMza3pEb1RKUVNWOTFs?=
 =?utf-8?B?SVpVRG5DOHRSSHEyeHpMZ2dBejkxdjdzTTBzNjhKMU1LM3FEUmlaNWxITVpF?=
 =?utf-8?B?MjIyQVBHUWE3cFhkNDBDcXVVYkhoV044TnB6Wnd1eXRtNXdTVktqTUNRaWpH?=
 =?utf-8?B?VVhjbHlwTlJqTmpFVUplUEZ3Vy9YNDMxYUlLV2c2dW5QV3AwS04vREFObE9S?=
 =?utf-8?B?dlBWOUlLeHB5Y2oxd0pHT0lnWXFJZmdoQVYvQTVBMDYydWVtZzZPSzhxRWhx?=
 =?utf-8?B?enUveUJRT0RTaW10ZTJrQWFWL0JsTjFzZGtoQWM2NUVONUVkSmhFR1FXZXVp?=
 =?utf-8?B?ZzF4TkJ3U0RWRWlXNEhmUlk1MDc1LzRtdmg5YUtiMkxhVng0eFNYT3YwaGxr?=
 =?utf-8?B?a3p2bFE3WnBqUTRQSytrMTZGYlk3Z2g0cVFodUxpNWsrdEdjTjl6b201RDg4?=
 =?utf-8?B?USttY2NQRDdhSVcxbWtKVitIL210bnFkdDBOQ3IyU0pqWUxzU09YdU82Vksx?=
 =?utf-8?B?V2xXRUNKOGJSRFFlNmIxZ0paRUtWKzMrYXA5MlNnVUlaN25HK2JXdXhSN3Zu?=
 =?utf-8?B?VGZTU0xEYW1xY0lMZzkzbUUrN3FQbTZZNWsyQ3k1NXFPWThVWGp5VnpuaFJy?=
 =?utf-8?B?ODA5dGNQbjFhNitMMHY0d0ovMksxOWlXYkVSZFFwMmhEQkR0TkxXVkFDdVVs?=
 =?utf-8?B?YkRYRlU5RXJVK05WUzhJRVN4cWVaQ2NVTFpNb2w2dytDcEVQOWVaRlhEblJC?=
 =?utf-8?B?Y3Z2aTBWLzYyRlg2Nmk0aWlzamkvejJPV0pCRTllL0Zlb0hqSUpxa05PT2gw?=
 =?utf-8?B?OVlFVnZhNk5tdkpDNXcvRE5SdXM1Z2NEeWtrNE5BemRHeDNIempHQ0g5a24w?=
 =?utf-8?B?V0hJTzZMWmNyUS95cDcrWDhqUzhMVEJmV2xaRXJPcWFsQ1pUSGlXYVRtZzR3?=
 =?utf-8?B?aTZ0bGlXbnNZcmIvWWM5SkFDZm8wa3grODdSNHMxZldMVFZuRXRMSlVTam9W?=
 =?utf-8?B?eGE2b0NDQ2RPbTFKdHhiS2hhd3Q4YlBQY3E3UGd0NVpBNVBPMmtTdzF4QVJP?=
 =?utf-8?B?eWIwejBNR2JtdE9ERlZHbmZ6VTNLOEFxclFGY0VHdXZFSEVSN2tTaDRHUG9W?=
 =?utf-8?B?ZXNSclkza2I5VUowbWN3RWZndkl4Mk1nZ3I4Wlh6WEo3RnNJek1QTHo3TVIz?=
 =?utf-8?B?WmhLSW5BM251MHYwVDN2aXNLZ3prVnJJc3k4bWI5TXhMaXREczNJWnZuZEls?=
 =?utf-8?B?Q3pGTDhsaVFuMHV0VUdwMlhPdHFOU0srcUluY05FazN3UmhoelFCZGw5R0Mz?=
 =?utf-8?B?M2J0Yys2MnhkQmtaa0VIRFljeVc5aEtoV2FvQXYvLzYrQndkNEJIS1lOY2FL?=
 =?utf-8?B?ZDhVRlI3KzlhakFPTk5KYmhoWXM4YzZpWFkrclVaUyt4R1kyS3JYQi9pVU02?=
 =?utf-8?B?R21zWWFYc25vZld5SStpRXVWYU53WjBrMTdKSndrVitHeTE4NDc2WEM2QXlZ?=
 =?utf-8?B?aXljdXJFd2NNT3pvQmRKYUxieW10QlVBL1pvOWREc3k3VWxteDFqS1pCYmZH?=
 =?utf-8?B?dDhhV3JrS01ZL25yTFhudnVTTjhSSUpPSytTK2pySGZaakNQcmlMUTlJQjc0?=
 =?utf-8?B?bW1TMjNHN0RCZjVMSUE5NlhLWjcyR3Y2cE1qTzVpdlNWOTd1b0d3Tzl6eXVq?=
 =?utf-8?B?dWl2cWZDaCtVUGg1M1QwTjFhSXQ5WHQ3d3lsMFduRFFIWkFUcGRBVkh0NTZS?=
 =?utf-8?B?OFJXRFdnSlJHY1FrTEFGY2Q2VDVVNEUxbWJ5OTE4T3djNmtFeDJnOHRDZlIw?=
 =?utf-8?B?c2Via3gzVGgzbWlwaFZ1SWRMT21QdnlwcGRGWXhESUFVa0dkWkFaRW81VzA4?=
 =?utf-8?B?SFFscU1HN2FvdGowU3M2UlpZbmVjRGZpVG4xTDhtVUxTOGREYURkcnZwaDVa?=
 =?utf-8?B?UnR5dzZTNWFOYlVQVS95d085TGtGa2hWTnppOFVEeXhLZVlNMFJKbytLOXFT?=
 =?utf-8?B?bVhQSWRLNnVjbXV1VmdlVU5kVFo4U3gxN3BkSGRiczRnTUZiZGZMVkt1WThD?=
 =?utf-8?B?U2hnVmdEVFdMTHZsMTM2LzVDVkpSWERWdThVK1d5RWZEeUhUdTg1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c602eada-f986-484e-484b-08def23aed6e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:13:24.0820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yghd0TJaOPV/9WhqO82GrA4V9GdVvsUriKqfSUDG1optbI6n0KYEiXNBFUCc/ac4yIA7o0cVXoQqOHs7j1P19w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401

On 8/4/26 09:54, Shen Yongchao wrote:
> In sev_migrate_from(), when the destination KVM is a mirror, the mirror
> entry is moved from the source's list to the owner's mirror_vms list
> without holding the owner's lock.  All other writers of the owner's
> mirror list (KVM_SEV_MIRROR_CREATE, sev_vm_destroy()) serialize on the
> owner's lock, so a concurrent COPY or destroy can race with
> KVM_SEV_MIGRATE_VM and corrupt the list, e.g. leaving a dangling
> mirror_entry that is later dereferenced.
> 
> All kernels with SEV mirroring and intra-host migration support
> (KVM_SEV_MIRROR_CREATE / KVM_SEV_MIGRATE_VM) are affected.  The mirror
> list mechanism was introduced by commit b2125513dfc0 ("KVM: SEV: Allow
> SEV intra-host migration of VM with mirrors", v5.18, 2022-02-18);
> upstream mainline is unfixed as of 2026-08-04.  Triggering requires an
> AMD SEV-capable host with CONFIG_KVM_AMD_SEV and a local user able to
> create SEV VMs and mirrors, racing KVM_SEV_MIGRATE_VM against
> KVM_SEV_MIRROR_CREATE or mirror destroy (instruction-level window).
> 
> Take the owner's lock around the list operations.  The lock is taken
> after sev_lock_two_vms() and the migration_in_progress flags prevent
> two migrations from interleaving.  The owner is a third VM whose lock
> is not held: the destination cannot already own an encryption context
> (sev_vm_move_enc_context_from() rejects SEV guests as the destination,
> gating on ->active), and a VM cannot be its own mirror owner.  Hence
> SINGLE_DEPTH_NESTING is sufficient and cannot deadlock.
> 
> This patch was drafted with AI assistance.
> 
> Fixes: b2125513dfc0 ("KVM: SEV: Allow SEV intra-host migration of VM with mirrors")
> Cc: stable@vger.kernel.org
> Assisted-by: Hermes:deepseek-v4-flash
> Signed-off-by: Shen Yongchao <grayhat@foxmail.com>

For future reference, you should run your patch through
scripts/get_maintainer.pl so that you include the proper people/lists when
sending the patch, especially the originator of the patch being fixed.

Thanks,
Tom

> ---
> Reproducer: static analysis only (no SEV-capable hardware available);
> no reproducer has been run.  The triggering sequence is described in
> the commit message.
> 
> This issue was initially reported privately to security@; Sean
> Christopherson OK'd handling it on-list.
> 
> Mitigations: none; SEV is an optional platform feature and the attack
> requires a local user with SEV VM creation privileges.
>  arch/x86/kvm/svm/sev.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 944aaea6501..4fa4e9bf408 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2050,8 +2050,14 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
>  	if (is_mirroring_enc_context(dst_kvm)) {
>  		struct kvm_sev_info *owner_sev_info = to_kvm_sev_info(dst->enc_context_owner);
>  
> +		/*
> +		 * All other writers of the owner's mirror list (COPY,
> +		 * destroy) serialize on the owner's lock; do the same.
> +		 */
> +		mutex_lock_nested(&dst->enc_context_owner->lock, SINGLE_DEPTH_NESTING);
>  		list_del(&src->mirror_entry);
>  		list_add_tail(&dst->mirror_entry, &owner_sev_info->mirror_vms);
> +		mutex_unlock(&dst->enc_context_owner->lock);
>  	}
>  
>  	kvm_for_each_vcpu(i, dst_vcpu, dst_kvm) {

