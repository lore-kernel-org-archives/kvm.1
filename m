Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2793624B3;
	Wed,  1 Jul 2026 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946210; cv=fail; b=LYqGp72+V4pICJOBA7Vt8TiXVZTlGuNXrcszTY+T1ISGkVFd/VnbqceYP/PbiXpP6pCpBVRMU1TpZtmUjHL44BpYDfvzD518+ay9UrCWoK9er+Lx6XLnHjZ6u65HaEK0VHUiEj55PsCeMry6UJefUp0Av8bCVRyBof9mTb1FJwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946210; c=relaxed/simple;
	bh=+qEGwmACpoeJaryF1MvRiW8IKX1QzkmWMj9dXVaxh0M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/K+/krkGL4oN6BKA+NkX0bL58dv0EB9IzUVTxJXGucelI17dbTQA8Vqrs75oh8FqfuM70JXzkg+sbYF4UH72oyorWoHVvL0zyx8SQZ372yR6Bfizm5bsAFjO5kfh7q5jnqXLpFwQSC10kGW/FLtXp5AI8C5pZ7mg9rmsJ5KXzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fhddb6LI; arc=fail smtp.client-ip=40.93.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fhddb6LI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdTsS3/p9ckRO8Dw+H0NNg40kUFJ0JPo/pXhiUL3TSha8Cr3AdQU1hjc6z6l3vZX+5ZCGS8FAlji8TV1sA5DH5sl+vFguC2OBDYuez3WcqW7C2LSgPfOdYFcZPRsWbffvchGFvqzJ12Xa9AfVVp0IJssrQm5MmEy6NKlbL8vIxBgTgM/7GGqDmAxT0t3KTCUMra9WQL5TLcPv30rjSG/8f5hLmkm5BMkh3inMVNysUbl5pxYPdRn1IdNFWq1OuMGHAQzj00VVYrdPjpRdQyRx0Dy/My1CLjeJdlbHRVMy9gwtEi4Kj+u3JgO1kkRVXHo0DH7Rr3UKouk84g+Txozgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjzAfiH6WO4AqLaiLb30sd5EN/s6eR3Y38wcq1aKmBI=;
 b=bvgJqAntUweNojbWnLsZkB3W8cTd66VX4nZaJMkCYMiKej6n+L331UYYS2Nn2/EBLBIi0NDnoitcTcFqOVD/gW13qsJNSOICiFWAWJMmxkR7Eh0PBXyXupAIixfQv2HV+wveGHXTnyiw2WzXj6qMApRiXc3YHr2W1cLcouLoqSELoszRfZP1NlR1GT3ko6E0BZBDkt76A4Loaz0wN4YxwnHdN9urA8TEadAXYneZEqOf4Dr8ODY/gUaVWbJGqrevVEAY4CWqfC1tksEItTvxBT+zC7arUxy6AWYle0kEmhYN6NxQa40azuqwYS2evSDnk5v89UQBTpa5OhgnAMDNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjzAfiH6WO4AqLaiLb30sd5EN/s6eR3Y38wcq1aKmBI=;
 b=fhddb6LIYrKMiwyTqoSQMp/KvxL/fow1AoJvzMS8CJzbMAZbLh4BEMWAteNZ+zPm5UF0YJxCcOp29QKLZsefWdegRmeCCPxelFLLWZoKP0qlfP4tlRE0Y9O24k1cSxtNs3i9sWVRq8WqLgNyVkwMfrzjKPniJxMAW43AEaYHyUI=
Received: from PH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::7)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 22:50:05 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::22) by PH5P220CA0006.outlook.office365.com
 (2603:10b6:510:34a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 22:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:50:04 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:50:02 -0500
Date: Wed, 1 Jul 2026 17:47:18 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 12/12] KVM: SEV: Mark vCPU has having guest-provided
 VMSA even if its invalid
Message-ID: <ib6aiquio2dggfl2dwkaptayqna7aemxuubfiap4bpcnk25rvi@pd3lrbk2dsze>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-13-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630222607.497895-13-seanjc@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 183e44dd-2655-4f13-2b0c-08ded7c3177e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WWPI8W7moQf4vRdRcPEYeaQ73eKmgIgh+fwd6X6c/c5kyzlC5EImkYxLlHhzcAwNNmKlUWwbt52jb0sCBL+XLd2/WKO5jibZliwBw0E8Z4MfcsBIS/R5KA/HpUUMqWd4VTFgyjkxGfZgtlUR+qLhYbKqQWbgg6nMgu1VBKx2dSOYOLFaly9v74RC7TpwiwSuG1JHfqDETjesSZcModBt2Po/iJqsRna3/8GEfN4oFdBK4l/CqDRmQWMMY9kDF7KhD8XAtKK7T0fYL90R3vHIvnBDDDauyoFoQ8fG8HWk6ViTSEKkgoKHcV3/vBU1eHzJZcUiqqkA5WnDm6UIuroUauY4OSkljJ8X9v02xk5SbFLGw1Jc/mrwCxuPzmemt4qXmBmZQFwyfpyYjdQRl6w7kPcHJXJ3xJd3XdPsDGbMSO+RkqGPZ/eQxE70dVfODtwO3EAmEspaNI0wErrxbvdtbSLaP0xRrCuXaAfcauAuSH5DJcvuBs83dDSnOVWpa4TDJgwReCDHKJgtb4GiHy3Rg1xKbDDrz+WkbRix+o23vna9qZkzYbalwcrCLlWhli93FN8HHI5EADq+iHEiL4nl/SKBdQRYlA4IDzIKD4mr7vvgIhDVk/YyqZg7RyLQ+uQOprRNAPS8CZfFBvAT1M9QEVl50jqqLlVwZVxtQ68vqHbyn8I/ggxt4vwnjykstUIHNO+uItuLW9jqyxdLkxaiyQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4UONDplX3ZCbSZY1WSNXEKHvWkLW3mcLivXn4FVMKI9kJdv4v3Frfrdmf0e3ayf+0/ZLy25XDHrsYom89ayOub8wHL/eIFbm3Trz4e+1v5TfuqPUO7S05gDxiv9KUHepJgO5UbulyYsSQexM6/eh/bxU9FQMo8LoRaoBrYF/rsB1KAeNFCZ1QlLN1DsldTA/N6AuPOH0fO0CY9Gvut7XL9I+EreKo2cc9oNjLq9KZ1Mz1i95LCgjQqoxwGMtMQXBkbTN0rdqhwUCxCQI/Zn5Senef39HBZFYnVm3ojZK3RrIncCrOvIBW0Br/QfR7aNAVY2eWyiiLA8JEsKNkj/r5Ui1e2T2CvjAn5fXr3zCBI4SGzMIZC9tmH+04j9gfSmgRd5SDawy/ZSB4mb/CzKfjXyTJ8tKErcN7pcBkvgP1GbindiyDHiXIc8kIr9EySvi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:50:04.5262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 183e44dd-2655-4f13-2b0c-08ded7c3177e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085

On Tue, Jun 30, 2026 at 03:26:07PM -0700, Sean Christopherson wrote:
> Track the guest as having a guest-provided VMSA as soon as control.vmsa_pa
> is invalidated, instead of waiting to see if the guest-provided VMSA is
> usable, so that KVM doesn't switch back to the original VMSA instead of
> exiting to userspace (due to an invalid VMSA).  By the time a vCPU tries
> to load a guest-provided VMSA, KVM has already communicated "success" for
> AP creation, i.e. KVM has committed to using the guest-provided VMSA.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  arch/x86/kvm/svm/sev.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 2d2c159f20c2..ec426a5582aa 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4005,23 +4005,6 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
>  	 */
>  	vmcb_mark_all_dirty(svm->vmcb);
>  
> -	if (!VALID_PAGE(gpa))
> -		return;
> -
> -	slot = gfn_to_memslot(vcpu->kvm, gfn);
> -	if (!slot)
> -		return;
> -
> -	mmu_seq = kvm->mmu_invalidate_seq;
> -	smp_rmb();
> -
> -	/*
> -	 * The new VMSA will be private memory guest memory, so retrieve the
> -	 * PFN from the gmem backend.
> -	 */
> -	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
> -		return;
> -
>  	/*
>  	 * From this point forward, the VMSA will always be a guest-mapped page
>  	 * rather than the initial one allocated by KVM in svm->sev_es.vmsa. In
> @@ -4033,6 +4016,23 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
>  	 */
>  	svm->sev_es.snp_has_guest_vmsa = true;
>  
> +	if (!VALID_PAGE(gpa))
> +		return;
> +
> +	slot = gfn_to_memslot(vcpu->kvm, gfn);
> +	if (!slot)
> +		return;
> +
> +	mmu_seq = kvm->mmu_invalidate_seq;
> +	smp_rmb();
> +
> +	/*
> +	 * The new VMSA will be private memory guest memory, so retrieve the
> +	 * PFN from the gmem backend.
> +	 */
> +	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
> +		return;
> +
>  	read_lock(&kvm->mmu_lock);
>  	/*
>  	 * Save the guest-provided GPA.  If retry is needed, then KVM will try
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
