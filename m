Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A563612E2;
	Wed,  1 Jul 2026 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946231; cv=fail; b=Cdf7zGHF1o/UvhXdqBmA0538NzG5cDsWDNN2UkiWuitCvvnjYR0UIOXX18C4Jq93GJkTseG14PyRaGD4AbevMlX5uWAHxq3r8hLFdHrP0P3jNgCTHWlXHzya0/sXY3IhQSwky59NRN7ie9mlmp0mCG9MQeA6Y/7l309di3WqQV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946231; c=relaxed/simple;
	bh=lOmo92p6+RA8OQ86pEr6bE/IHKlsgCdNPqUCS4AZX4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF3jHUd8urpNyi9hPJb9DqvmGepJzoLagpkUCYkJN9n1kkGdLxh9WO5Tk2wvgkiGFTKvRCCeRaB5Xa92kyRr7J2GKtmts6Ss6y81V2JvxpWZm7aq9PM5cwoyeIkzTYOPO0DMkZn6oPF8mtQ2GYsWgXjPlZcKmLl/a6PGfKjuOXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z5Op/D77; arc=fail smtp.client-ip=52.101.56.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z5Op/D77"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOKHxh/4yf0pHZPeru7PJ1N8M8o7c+kBsyHRH5zgPyfJ+L9srldcS07j0Bvg3Ow5oSAgTjFJrQK0rpSzna2tVjTU2Piy/rZO3SX07P7KSwSyKY+XGtxr6u3rKsTeTQKp/F8Gt2b0npWh97qxuUApkR+XjjjwucdoWAiQhhqdF7ibUSp5HppMxRm1qvvpDt0QWbf1zFRRkrSX6IvYkVCfP68pQgoojgeOcqqVQW43XQa2E5YWMOBA9CtG7za9COS+ABJBHhyemaaNC3w4dIQqrfK5lI6oZBKp452lulrpvpYI+JqDAzJlRF/QvXN0cnTEz27yEe3VaGUeg7dUvhqvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNHNzKCiapUHS6rBIA88IZFj6JtRpTP1mFSVuG1uJd4=;
 b=XqHL8QtlCg0qOg1zJ4cPsqfPddUeRPUwGma28Enc5HWXZJ2Q8w5v/ZwBbYhs1z/j+HkmuNOmRnRz/qQjS05zfgjJXDbZorE7Xc1ATpsrAPDNZpzEBcqAd8ywIK+EiL8i7rigmGKRF9NzbbDMXP/iFwoQUxSc+kubcbIQjtTiXPyr7axJm55jmHfB0RbnUKEEFmZDsFuxJqd3afRps5Bk94twsmyS1756KKquIy6YOwIveI1GQqk2jm7aY2nAHQRxmnSba4aYEopZDtXI7CSq/jXxkXJGqmHzwzoGlDe/Js0+LFU6nSml/sVn0V0saQFkpWR6xD9jtR9bB1ify5e6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNHNzKCiapUHS6rBIA88IZFj6JtRpTP1mFSVuG1uJd4=;
 b=z5Op/D77CPMjhCMj/rGPisG9da4bt3tG5HbohpSdyXirmlQT7Ogwgp/7zBH5aUe5ZoNltjM8KyG4HAcajwAkrHb/eR4OGhiQpEuEKV/0sOiRyiBxuHEHvcQaSozAyM6km1IyQI82EFoSvvMolVl5GdWUNtsK+MFihgvCcXRsU9s=
Received: from DS7PR03CA0098.namprd03.prod.outlook.com (2603:10b6:5:3b7::13)
 by IA0PPFDC28CEE69.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 22:50:25 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::28) by DS7PR03CA0098.outlook.office365.com
 (2603:10b6:5:3b7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 22:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:50:24 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:50:23 -0500
Date: Wed, 1 Jul 2026 14:34:33 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 02/12] KVM: SEV: Extract loading of guest-provided
 VMSA to a separate helper
Message-ID: <grg4uvllrymsfxupqwvreptc4xbzev6qn7hrawgpmiurmd2vqn@hifn5hlt3vd2>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630222607.497895-3-seanjc@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|IA0PPFDC28CEE69:EE_
X-MS-Office365-Filtering-Correlation-Id: 13316488-9f8d-4f9b-093d-08ded7c3231e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|6133799003|5023799004|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wc6P40xJbM8Y1pap4JyyfWzHCwGiw2VVqFD8J8Re8IZYJ63qjWjpIbO1BheXbnToPz51rtgxtH+9V/pmrY9RlQvaTbAP/w0D1J5305nNw6Y+N4kYWQTEJVv1tEa5F6f0J6635ALbpaFgPi9xRMdef+UWHsmNbJTQuxbLfDf1YYB37RrFWM5axUSf+qHemCR1xTVx2pOFwkF6C3K8dkPazuA1z4jwi/DQum3zvr6cTNUwd1xvXtNgW8EFOOjmS3+JDmrAdUZqIVeOAXgFINet6Cd1rot/xHcL+T5DyZeYjnvdqfgXaO60+OUphXqd74XFdBCQzEIJ9CdJzM9HQUe1aew6bIHKebxGzBkVxP181sRoDG6QTrItt2XX5AZOepjdHk1mplf6h7csMQNPmWtC/VpcuhcSzL8crrBREOMRSuf46AkT0Q/SbF9M/JLbH3EAi9tcfIhdxp2IeHZyu++v1tufyTmAUDT0XHGUWqkTlRBu4ugeG6y/Cnlhz++N/tMq3dUgSNKkQgFOSwE+3qSZDn0qM5cixajXl+A511PWeDSGfPFjacxvl+uwDnQLiYk9gr6hXOvuGMPoArKSwH/k5xkYYTD396kno6BmQwWpy1WRWX8BTZnjmMAVxCxVph9OOdJjwLDz2MPLhhJmz+zql7R4qluIKZjx+Uj7KZV6cRom38H5yXNG7LMJfBTfaIJpHC0cD3MQJ6EGKJEPXvjBuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(6133799003)(5023799004)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MluBXtp0lXaOXcTYzZpcjtoqv7uV2Jl2rmh3ifrqwelBiWaa1ApBiLM16y+4H0u6B8kU1vTvhP4kxbhdVQOiH6BTPMRDuDSfSrtgkp8Nr9939X37XUEkhkSsZBebdaf6K6sfWB8r0/L0HQ30NuQlR9E4seKDjVc+CNJ9x+rdXDZIJsMSG0ZvEhyUyPpdBSW9HI2VCE4PPtH4l7FJxOwYQIKQZ3tb0eAq2yKzIvccZ6Bp2VIR20n8aI4NcEQ+gl0NxGnBS6u9QjwXT8uAAXPkW38iFYCarxt89gILbdad0JcF4ieWPrHMvgBllO9hjfhwidPg/X5v1qE5QRjI+4zujYH9SKoR4QeXOwblvlRQLStG6duj02cD0hhSYeR1kXbD6SGhjfHGgCoKtJhZ4zJVamKMi3vCH0/nPnDxociwUuotmbobHcL9gfOD3ZKaUjso
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:50:24.0308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13316488-9f8d-4f9b-093d-08ded7c3231e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDC28CEE69

On Tue, Jun 30, 2026 at 03:25:57PM -0700, Sean Christopherson wrote:
> Extract the loading/retrieval of a guest-provided VMSA to a separate helper
> so that KVM can reuse the core logic when refreshing the VMSA after an MMU
> invalidation from guest_memfd.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  arch/x86/kvm/svm/sev.c | 52 +++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 827f5dc06102..d8ed00f76aa3 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3979,29 +3979,17 @@ static int snp_begin_psc(struct vcpu_svm *svm)
>  	return snp_do_psc(svm);
>  }
>  
> -/*
> - * Invoked as part of svm_vcpu_reset() processing of an init event.
> - */
> -static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
> +static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	struct kvm_memory_slot *slot;
> +	gfn_t gfn = gpa_to_gfn(gpa);
>  	struct page *page;
>  	kvm_pfn_t pfn;
> -	gfn_t gfn;
>  
> -	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
> +	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
>  
> -	if (!svm->sev_es.snp_ap_waiting_for_reset)
> -		return;
> -
> -	svm->sev_es.snp_ap_waiting_for_reset = false;
> -
> -	/* Mark the vCPU as offline and not runnable */
> -	vcpu->arch.pv.pv_unhalted = false;
> -	kvm_set_mp_state(vcpu, KVM_MP_STATE_HALTED);
> -
> -	/* Clear use of the VMSA */
> +	/* Clear use of the VMSA. */
>  	svm->vmcb->control.vmsa_pa = INVALID_PAGE;
>  	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
>  
> @@ -4011,12 +3999,9 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
>  	 */
>  	vmcb_mark_all_dirty(svm->vmcb);
>  
> -	if (!VALID_PAGE(svm->sev_es.snp_pending_vmsa_gpa))
> +	if (!VALID_PAGE(gpa))
>  		return;
>  
> -	gfn = gpa_to_gfn(svm->sev_es.snp_pending_vmsa_gpa);
> -	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
> -
>  	slot = gfn_to_memslot(vcpu->kvm, gfn);
>  	if (!slot)
>  		return;
> @@ -4040,7 +4025,7 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
>  	svm->sev_es.snp_has_guest_vmsa = true;
>  
>  	/* Use the new VMSA */
> -	svm->sev_es.snp_guest_vmsa_gpa = gfn_to_gpa(gfn);
> +	svm->sev_es.snp_guest_vmsa_gpa = gpa;
>  	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
>  
>  	/* Mark the vCPU as runnable */
> @@ -4054,6 +4039,31 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
>  	kvm_release_page_clean(page);
>  }
>  
> +/*
> + * Invoked as part of svm_vcpu_reset() processing of an init event.
> + */
> +static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	gpa_t gpa;
> +
> +	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
> +
> +	if (!svm->sev_es.snp_ap_waiting_for_reset)
> +		return;
> +
> +	svm->sev_es.snp_ap_waiting_for_reset = false;
> +
> +	/* Mark the vCPU as offline and not runnable */
> +	vcpu->arch.pv.pv_unhalted = false;
> +	kvm_set_mp_state(vcpu, KVM_MP_STATE_HALTED);
> +
> +	gpa = svm->sev_es.snp_pending_vmsa_gpa;
> +	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
> +
> +	sev_snp_reload_vmsa(vcpu, gpa);
> +}
> +
>  static int sev_snp_ap_creation(struct vcpu_svm *svm)
>  {
>  	struct kvm_sev_info *sev = to_kvm_sev_info(svm->vcpu.kvm);
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
