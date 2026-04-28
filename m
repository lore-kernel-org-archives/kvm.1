Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D71A3172;
	Tue, 28 Apr 2026 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777403852; cv=fail; b=NGRPjDL6zjVbIHRo+I9RXT1drKx02yUOr5Ddq869oj+HG7Y/jqVhYY5y83Nyymk9W0uyoxg7YnITFGUQ34U/M0wJQn5xGERuPW/gADoa+hB+ck0mnH/+m9CD3JD2XuYFN4o0CFOuTeZDdDQ4M7M3K6TiXb1EaSVGa0TMdHQdoV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777403852; c=relaxed/simple;
	bh=Gu1dxAX2AqCLjotZn02vpFkIr0N/ZJbF/smA8M6MRzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bSnDztqAcQjQss5zcOxqV2+476l1GtpYaG4E6jiyNE+4DsU3FbYSuMmohk4VQZxfZ4kRm5Y0W1xedwZJ8lMH17OKDOgdGyfR8Hqc60wVfunImksI4kHYMLTmPxZGw4XM/s0f4l+p0JReQD0hcnWabYtQDCOFczaO6F+HF6rSTyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2WuWuioa; arc=fail smtp.client-ip=40.107.209.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2WuWuioa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIrLPkIo1pJmuSUfAwjOqbBjzUwRWDXp0s15Zuvt9ABbLa6MaCMeI3Qr4CrGDp9CBLoy2JiGiiNPPIQ9y3YdIHo3e9PLQfRI2fYFo8OGPYLJmYTFXP9/G4gXdH9VQTKf0rLv4grjch6Rpnt/2W24257kaUiO4oNgDJWPHPKfdrR6yRVwpu7o4Oyq9xQa6RAz7i0/0YAr8viiSdQY+ulM0TwSxWJ1q/B28DLNT0B1yWfK0l7MCJ9d6QSV4YZWeN/M2rX6j00jOKHN5CY87fdayR/kGRyQ56ct/FY8pMH5z+8iiM9n5whCB4xKbQYpyyOZ0TZ94wPmAdtsfbDllfzpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyTpyblGBEd5zE86mzHWFbNu+NRJ+6I4R/GeSkPcAzg=;
 b=sEGIQLruoBN27WY8nQSq210vjRyR5g9iimUP58WmxoXPCEo6mqXh3Gq6LBFPwrofLug1mKCqffzrEeGQ1X6IzAwakznpOqGtBvJSmlPDYk5moK4y30MFEviDj4W7fjvj30Bk5YtJmTvJ6OYm2NbSq7n/aAWTflG/v+LBVAp9j5LxgxKzBmFdMpk+c6afjeGVJs9Tf7ijRrfyAj5/k9w5mJVSou03oYvq4SIBM5NWWYt3oKoH7yJy/D9WeKb01ibVGzteoCMKrwze/zHyGCAdruID27t+Zx7YF6PuxlT+wBbMtBHXb8Jn3ACuVFUzEdTzSxuVW7hAu+3mDVxfhlXPtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyTpyblGBEd5zE86mzHWFbNu+NRJ+6I4R/GeSkPcAzg=;
 b=2WuWuioaUeQCecYR8N7Xp99w7iF5y6bIeeKkLmuvNAeb5p5Xsm3OoKxKGQ6+cq8ox6BxOvVND74loQrxWDdBnO7T1RzPnB6mzSjges8/EsfPaEQ8gT/ZMLfZYxHwaNG4nw/osbd2BNVYeyzAectZrIh1LyRF4rKtotAJIEJ2v/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 19:17:26 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 19:17:20 +0000
Message-ID: <73cae6f5-9af8-4951-87ef-88c14cad28a3@amd.com>
Date: Tue, 28 Apr 2026 14:17:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] KVM: SVM: Inject #HV when Restricted Injection is
 active
To: Melody Wang <huibo.wang@amd.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Joerg Rodel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
References: <cover.1777048608.git.huibo.wang@amd.com>
 <954d023cc355d1ab867c7f983c8fa830b29ee659.1777048608.git.huibo.wang@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <954d023cc355d1ab867c7f983c8fa830b29ee659.1777048608.git.huibo.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:610:b3::26) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 42054dc3-03ae-45d6-3171-08dea55ac4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6eCOYfyC9juW2O5F12iteJbGbk04QiLRz20K6Tm91XHGQceg/Kbl3EHnie2Y0eaTwhqN+4YWKodcDNbFIBDAUDoQH8xu3Vv1nA1w3LqHQe4Wghq5STbjofWYXQj2wrahQjzzPzLH6ZsfFYgG/SWsbMhmn34SvblfDv6bVuGY4pBSqWB4f36PfRMTBMu5FdTjwYaLVNeVuZlg7Gstd2Ss9AKGW8S0qMgNmXnhJc5x428MB4/3PIC4ksL/5LJN/I4M1MX93DkBaCQrhw2TWrQFN8+Itj8bdNlJFDXrpY1coZweAGSs1lbg5lW1nzQjHgJWY6/X+YrUZj6jRlIP9DLe17gpzYzj0Rue0EkJsXteD7gGMrkXoi0vJDaIN/O/qTXcZ5lrx0JTvVixlqdrYUNDGcgYKFzNZjDN8r3JWF2up9EZEsx6/EEzRIetkFzB83kKGsu9sY0K85VjG3S5WpsGJAmTpIGqrMSkYQV6f6IIzODFFtpZHZkBypxFcjlxQa6AbElVLzHDOANofR7BL3BEZQG7iqN40ApwUz4PMSKX/hT0H9oRDm2C36iNj9daj/Yf3lR0D5SwXAfk83Lm+2hp81lqmjtgylJZlQG9oEPYEYdWXUwteXOz3yZzeWWDtpcYwrS0kX+SZfpJFAArA6L1tVjUHxJ43tpJXpV5DSj+LxbMtis79kgtEcLNM0cgln8dB5VBY3yYAwjqPd1evWlXcStPsIvcV69n00+lD4R2m84=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmR3KzkxSmFyRkZZRTcraWo2bWYvQ1o4QjVpS0dIWWp4Q2VNOE8vaXZVdXg4?=
 =?utf-8?B?bmppTVBzYmVoSkNscnhZTjBUeTdrUUNmK2N6Z2xmdHpHcU5ERi9ZZk4xbk1W?=
 =?utf-8?B?WmtiTkhpV2pOWGZMOXZtc0oxVHlSK3QyVEd6dHk3TktiOFoxb0N3UXpIZ0pG?=
 =?utf-8?B?SGs2aFpTK0poNjZvaHE2RUVSeC9tWXZDNkxwWVkzY2ZaNStJbGs1WGpHd1Zx?=
 =?utf-8?B?ZnNjSmMvSTF4VS9WRUpYTWc4R1FHbXNxQzRrRXV3M0ZlSWV5NDJvelFKQit4?=
 =?utf-8?B?ZUgrK3NQTzVIbytlejlUNlJZbnhwTVdSTTUxYUpMMmdOUE1SNDBJNjJvSzZy?=
 =?utf-8?B?dHJQd2NwbmxTanZhVzQ4eHlibjRoNFc4cXlhRXRaUVFFV0VnUnJ5TkRFWm1i?=
 =?utf-8?B?WnM0R2dwMVIxMFMwMG9Lc2dvUmFkVUlqUjR3UDQ5a0N6dC9rNVNtUEpzSnpa?=
 =?utf-8?B?eEZIRmdPenRkNXRtc2plZWdEWENxOHhqTFU2dmVaWklGRDRxazNIZmRBc0t6?=
 =?utf-8?B?NlFIaGlIYXQxSGNVb3h0SUR6d1JCWHpIc001Zm1zc1Y0UXpJSmZ2ZGtSWjZ5?=
 =?utf-8?B?T3cyamVZbE5IMlBHaDFjeG00Tk5uQmVqRmJ1VS9nc1pxcmtKdkk4N2x4RTho?=
 =?utf-8?B?a3lDRzZwc3Zxb3IvYVl1ZTRzYSthaUhZS1hjaVc1R3JjdWxIMkJlOHprTlgz?=
 =?utf-8?B?bEFyc2lkOHF2ZXVBZ09CbmhJcDNHVm5la0R0bkxObDgvZGx0Q05OZGpuRkxZ?=
 =?utf-8?B?ZExXNEk5ZUNiS1YxTTIrU0YyNzR5R3p1a01HOW5ub0pPbFFKQk4zL1hpTytT?=
 =?utf-8?B?WVozclVNaDlxVUg3MzU0b0Q4SXJpMUtxci9FZzNZcnI5ZHd2d1ZEOFdKbC9t?=
 =?utf-8?B?Q2RlNVIyVzYvY3h6bnZaenZqdHpkOEFCRk1VWk5mNWMrT3YyTWhVeUx2Z0VF?=
 =?utf-8?B?Snl0MU02dnk2MjRNcDFCS2pCZ0ozS1kwNzBmcFdDZmxYVmlhcm5FbHl2YWRt?=
 =?utf-8?B?STJEU0pTcmkxRTRvQ0Fid2I4QXprL0VKakd6ZXFFZUV4RjNYZGg3VW1zMVpF?=
 =?utf-8?B?a3pOczUrZVo1NzY4L2l5dDZRWFBpSDV3L1ZWNDVEVHptbm5ET2x6ZFE4VThY?=
 =?utf-8?B?cElVUFBGRDBlM1h0RDk4WnljeGpnZDJXSld3ZzFuK3orU1VnS3BFT0RkLzl0?=
 =?utf-8?B?UE43TE9jbFlWc29FdjFsVzlqYjBHRklzYW83SmJYYTlOY1RHUnZ1eGRZM2hy?=
 =?utf-8?B?MDcwU3hVaTFLMXZiajJ4VlZjM2JnYkFEZHkrZzR3NHgrYy9ybG1EQzVQSHNG?=
 =?utf-8?B?MHZVdFZERTFQM2xYa0QvdXRNV21CVXNIYmtuc1FZTlFOWE56VVQ0cnkreW9R?=
 =?utf-8?B?WGxvMmgySFNjenZWTWlzMDVXYU00eHFCQ0xVSU5mOEdQbDlYNytXaU1jTWgw?=
 =?utf-8?B?VHlmV2dtajEzMXFsby9XOWczOEE1WmZVeFhwRzVvU2lCY0YrYU9LaTFZdWI4?=
 =?utf-8?B?b09ONVV4MXFjWW1xVmpYS21XSmE2Rzc2NVRxeXB4c0ZhWjZGWktGV2UyZ043?=
 =?utf-8?B?Z1BKeXU2Lzg4bTJ6dDdXZmdQRWlQUTlva1NEM3N2bmdSVHY4Qkl0aHdQL2FO?=
 =?utf-8?B?NXowR2FCQVpTMEFIZ1NVSm9GaElEcHRyM1dHQUNDa1J3WlVNZEdpTU9oMHVm?=
 =?utf-8?B?eFZJMS8zSXVaczAvNERBU1YvRzdGYzllYm11T3l5R24zekU0SzBkRG11RGhj?=
 =?utf-8?B?eWpNVm02SExhdk9ibytXYmtzL0w4WTFNNEVPdk5KdklwRkhzRlBDNmxzMlpI?=
 =?utf-8?B?RFJkSDdHRkJNVFhJSXMxRWJXelgzR3VvME1vSDRUSUtpNHhjWEZUS2ZLaXpX?=
 =?utf-8?B?MVNGNkhxRTEwb1l0QnFFOVUwTWdBamZURnBka3V4N0daQTlMR0hKNHo5bmdy?=
 =?utf-8?B?QmhIdEhwT2xRcm9WTUcwS0l3SExGUENSRi9WSTc4SmY3RmZUeXA3R0NhODRC?=
 =?utf-8?B?WXFlWUVtWHJKa2hSZXB0enNSYnBOdHU4TFF6U0V3WVdLRmpoNVJyZVZKcVlT?=
 =?utf-8?B?UG9UTzBvUmZpZVNPanRwY1l6WG9nTk5oby8wc1BMdTZhMU9MdDJoQ1RHYkt4?=
 =?utf-8?B?TWZNeGc1Zjc1QUFMUTZMUHExRkx2MDQ1bjZiWTFrSWhJa2toWVp3V1dwMlJN?=
 =?utf-8?B?QUJPdUFrNUJCL1o5d1ExRklJa0djZ0FxRGIzdVNqd1FqNG9UYU1WTU45czFT?=
 =?utf-8?B?QVRmMVdsZmNoWGEyMnRWdG5vVndKWnVtcFVoVm1FM2sxeDY5eXdodklPQ08w?=
 =?utf-8?Q?8h6qVgJK7oIFI5RytR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42054dc3-03ae-45d6-3171-08dea55ac4db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:17:20.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coUxk+NClqKmDc/8iaTtOMLsCOyXJKwnl7xtzNLyolGwCNv0bYHh8/QFYKGmu/RfuWkG4sDyV0NCm29LJ/+3Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181

On 4/24/26 12:42, Melody Wang wrote:
> When Restricted Injection is active, only #HV exceptions can be injected into
> the SEV-SNP guest. Detect that, and then follow the #HV doorbell communication
> from the GHCB specification to inject the interrupt or exception.
> 
> Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Melody Wang <huibo.wang@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 164 +++++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/svm/svm.c |  14 +++-
>  arch/x86/kvm/svm/svm.h |  21 ++++++
>  3 files changed, 197 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index f09c4236fb5e..509a4f8b5073 100644


> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 4ab58307bf75..b4627884c36f 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -55,6 +55,10 @@ extern int tsc_aux_uret_slot __ro_after_init;
>  
>  extern struct kvm_x86_ops svm_x86_ops __initdata;
>  
> +enum inject_type {
> +	INJECT_IRQ,
> +};
> +
>  /*
>   * Clean bits in VMCB.
>   * VMCB_ALL_CLEAN_MASK might also need to
> @@ -968,6 +972,17 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
>  int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
>  void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
> +bool sev_snp_queue_exception(struct kvm_vcpu *vcpu);
> +bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu);
> +void sev_snp_cancel_injection(struct kvm_vcpu *vcpu);
> +bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu);
> +static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sev_info *sev = &to_kvm_svm(vcpu->kvm)->sev_info;

You can use to_kvm_sev_info() here.

Thanks,
Tom

> +
> +	return is_sev_snp_guest(vcpu) &&
> +		(sev->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION);
> +};
>  #else
>  static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
>  {
> @@ -1005,6 +1020,12 @@ static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
>  	return NULL;
>  }
>  static inline void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa) {}
> +
> +static inline bool sev_snp_queue_exception(struct kvm_vcpu *vcpu) { return false; }
> +static inline bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu) { return false; }
> +static inline void sev_snp_cancel_injection(struct kvm_vcpu *vcpu) {}
> +static inline bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu) { return false; }
> +static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu) { return false; }
>  #endif
>  
>  /* vmenter.S */

