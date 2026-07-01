Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558ED3AC0C1;
	Wed,  1 Jul 2026 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946359; cv=fail; b=YDYm0gv6qxRPIYRbxSAm4JBqgvnRAOgRS73GttXilfO1yHF7+H9fDu+GKxeb7lc4or+yUthVSGy6dZQNDpNOrZFagBdCnflWmKFJOkoMt+RggPxFsXCLUele1peXtOxhsBp+WwZd5xYhtlx38Fp3tE0lAfkiQf6GnRkuK1GsyrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946359; c=relaxed/simple;
	bh=t/Vs/i0mUxJsheQbX7InLRjq6u/YU0wd5eChJp/kDuw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ0ksS8AoAQtoEpAc86Q1YKLetQ3dLYRO3ybonRUoQH51nJio9VXnxHSLrc2csXKdR3rl0SKoajbM1jxJXp9RJRdV0gO29Wg9a/SBTgDkOe43FsCM9CwMeHZjhjybSxdjJzeVMiiWkne6sN+aVBSDyHIhYRqeMYf54FPFiSXmVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0GMYiTFY; arc=fail smtp.client-ip=40.107.209.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0GMYiTFY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1AeQwDZBPDPB0CVcBGTsWZDO75kjGfnlN7WSDiZQk9s8NdmXZCRe5XIB+grecXWLOVS0I+Bxk68YZPulkpPHdXLTR5dQBQYlzMTbGSkO4xXdInb/NYkXS4SSntYE+QQt+TvpQpY/NR6rriOau+wfrpGb5MZrXu5CbEC9KdRKDsa43QvwBT36iXpXlM+rFs8e7lunPCzOpijgkyanunIN19LW7XhvEp6Lq5kbavEOBQl4XqXkNs4EsbjaEWYeFL9XcNtFbQ5bi8nhA2jPLkhUXJhRNh9pr+KweBSvqwSlyUsyRKRxzC2QMFUtNJUDFtAO4lCo8LLLcHuZO3gdp7QOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6x+uaSDMlGF06t5fQFtUXQtsNQHuPVGPO9Zq5Vn2y0=;
 b=wPuqdEWlGjUwgoYidds8GcP5qKWeoPjJ7mJE1CjdCR5aQWC9+tee6fiPcNtjotGv9jP4yKgqiUJO0TmBzcLeOCsNZUz//XxNp7a4mkFxZ9g81UCpN25Fi807w6oJiCxOA1R7sQdldzEkCo1Ve1u6SscOnelohkwQUgNMPhM9pOM4mw7N2B2AUpKq4E70InOPYp+Rc+VNKeUATTBltgK0fH7AvtjCmAGCA2UwMRSy+c4P2CHcLKPo04xalKJnlOjB1G5nPxeOKdh1NUZaFaWj919Q9gdbyrUbS5SNwcNXS+oWLgCZjMqFLbuTIWoMjgmyYUd6ffozH8CLYXinor8jYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6x+uaSDMlGF06t5fQFtUXQtsNQHuPVGPO9Zq5Vn2y0=;
 b=0GMYiTFYBmb7a6jBMapo+WLClyJJ0LzbEcOSmoHklmccZ8jVi4cA82Ztuu5IWijSiNpUBVLlkBj2w9UcKgYmJL9Q06hSow8tmIKcCXpXDcC+Ee5gc+eMPYHvAUckUtHQRbsDxS8uddsUrJF4Spuw4tHMnjPEZ2i419RA8gIvGa8=
Received: from SA0PR11CA0051.namprd11.prod.outlook.com (2603:10b6:806:d0::26)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 22:52:28 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::4b) by SA0PR11CA0051.outlook.office365.com
 (2603:10b6:806:d0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 22:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:52:28 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:52:27 -0500
Date: Wed, 1 Jul 2026 17:04:05 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 07/12] KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into
 kvm_arch_flush_shadow_memslot()
Message-ID: <q4ie4tlr5gjakbavqbeglgolohtips7bzhw3yj7d7kiapwl55h@7cm33lhw7pwm>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-8-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630222607.497895-8-seanjc@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec7e25d-88aa-43f8-73cf-08ded7c36d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kyuRiOKC7FI4epM2Di1ckpgAwbZqToi5ha8MGFJU2gdNSQ0VUu5ZcJp6IBJoPNXzJh3P1K+rQRlg5Iy9kK+Qz0JVtz1i5bncR6H/jUTzT1lNaAMGsnzIdbg/CIx1l1netNG+TMBaUMMzHwvqQAtM6TEUyJop4u4f6AboRJ5VQMTBX5xAhKNXhuPx5HnDA2h+IaW6G1leKUAN5/njsMOVHonU5S3QGDgHgzXra1KMoIwMrvFceOBrBG7MaGQ1LrPl3+qce4yVtuSQxGQrVETztroBMaCBmH0nD0hJXVSbirjrrt8gyLw+/zABeWlE8F3FkloLl10IduhoQHYPgLBBR/uDZrZFa0Z7UeYlwDD71UKvEunEst4k59a0Glp3WsjBT2U+fCQihXfSVbwbILbgJciZLxF+nCIRQzc0++NH17jdm8DF9/ZB+hWvyy0LvOC3NNWtvAi1r08Ps5+z/72yeNZGAN9TdcyGRFDMMHn3UOTAwFZd9wHq0giR7qsdzjtehV9/JBTAj1A99dyAyvH+HTL0T/py/IkumIOsvYrmXgE1LMyiDDYHXvS3SBL5AAMk8wEybZxDEM4myhgHbEwsQA9RVnl/FdJtkhQHZs393VQffhERbf5yA7NUVBG4dkkP4ZcNAHxb3SwUWCpozr8aexbo7t4Pv1kJ5CppjyFiwQWpX9/otO2CjtC0WlKK0WdbftwmYpKgTSvztXjfUNGPXw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bCRqR7u5ZW5UkyfSUQmTGmzM3gQVFuzEtn5Yy+Fyu9/FbR2s59Enzn3Q9kODofdRuRNNI0Z4EQRTVz1mUKa0Rx1LW4PMJZ0JcjDjaXwFYCxSGk90WsYrZUAL9EwPmHNEd3YiwNwdZ36jGTZHy26zxQvo4Lg+9o2fl4zBjqrBkA+KuACBgOF7c1uEwXZxSiSBae5D7vT1pRtiDJLFr5h7HZD6p7afJw1e0sT0lIPhg497urLfCP6gvKhUQxuOL44CrJ1dyKNkMaLXwJAkeRQx/XX4bv9Bj5etiXPKTVM+nCNR+v5AudnRTi29sZ+MlMyEbvs9GveKvamB+K9SDP3pjXdsDOguABygCi5y/CMwUA1FmIgpxuoAT6pHYljaMiAe+JBcnAdGAQ73rpDRx9MzLsHtLUFeKknTCNB0eulhaSiQE6jEbgm/3Vx+crpG7O9T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:52:28.3628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec7e25d-88aa-43f8-73cf-08ded7c36d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592

On Tue, Jun 30, 2026 at 03:26:02PM -0700, Sean Christopherson wrote:
> Fold kvm_mmu_zap_memslot() into its sole caller so that its GFN range
> structure can be used to trigger guest_memfd invalidations regardless of
> whether KVM will do a partial or full zap of the MMU.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  arch/x86/kvm/mmu/mmu.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6c13da942bfc..223d80b12b9b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -7560,8 +7560,14 @@ static void kvm_mmu_zap_memslot_pages_and_flush(struct kvm *kvm,
>  	kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
>  }
>  
> -static void kvm_mmu_zap_memslot(struct kvm *kvm,
> -				struct kvm_memory_slot *slot)
> +static inline bool kvm_memslot_flush_zap_all(struct kvm *kvm)
> +{
> +	return kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
> +	       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
> +}
> +
> +void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
> +				   struct kvm_memory_slot *slot)
>  {
>  	struct kvm_gfn_range range = {
>  		.slot = slot,
> @@ -7572,25 +7578,14 @@ static void kvm_mmu_zap_memslot(struct kvm *kvm,
>  	};
>  	bool flush;
>  
> -	write_lock(&kvm->mmu_lock);
> -	flush = kvm_unmap_gfn_range(kvm, &range);
> -	kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
> -	write_unlock(&kvm->mmu_lock);
> -}
> -
> -static inline bool kvm_memslot_flush_zap_all(struct kvm *kvm)
> -{
> -	return kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
> -	       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
> -}
> -
> -void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
> -				   struct kvm_memory_slot *slot)
> -{
> -	if (kvm_memslot_flush_zap_all(kvm))
> +	if (kvm_memslot_flush_zap_all(kvm)) {
>  		kvm_mmu_zap_all_fast(kvm);
> -	else
> -		kvm_mmu_zap_memslot(kvm, slot);
> +	} else {
> +		write_lock(&kvm->mmu_lock);
> +		flush = kvm_unmap_gfn_range(kvm, &range);
> +		kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
> +		write_unlock(&kvm->mmu_lock);
> +	}
>  }
>  
>  void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
