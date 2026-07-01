Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE1361DDE;
	Wed,  1 Jul 2026 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946147; cv=fail; b=F5qEFWhyLe28PrRbCLraNryXgqpBh93Xy5TBhEz9qSkR7bT2OzTrSceei08+n2ofJROvOx9XqdP1m158NctRV6jIipC+i3X3rdDktsYpKo1eQ/NhUqU0MGjxhxB+mgtsaxb38RySufZgNFxmuwKXzOf28+0REpcIaCv1QQJEMII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946147; c=relaxed/simple;
	bh=qHM8cm/Zyb/X8PyN6NrCD6P+M8HuJ147KnjvAw1fVAk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtQTjP7a+Ah89hYNK4hKujYVnmnknKdV0X+pyLVQw4E6CWFCOrMhpogEI6EjnQ1SXECXQxtl0fzqOe0RLsau9PqBogg8Tz4VsTSfOzBRVaNytROlPVFMrx0oPxbTk422EQsSv9ZvLRLwkYGOwfEktm6LtAr2sIm5stVx43IWoVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H9cfEkeu; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H9cfEkeu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkpfjG+DLEJMWDn1sGamW8Dt/efapmrkOl4fVMO0sp4Ka+jQTUTE21fALNzqZSEG8WUG2LhoYqvcF81TNqGpwsaT/qCrHG0QNOjubJhCrDHkwcOHGuacPuttxKGQRria3+DnRU7roUDnokXek10HqUpftn/2kVY7iaDMgsGrWZMM+HUUkSQkbK7iEucCIb0QX8Ff9SF2N07c/Rw4Gimd8pkSWLmVL1PQ1olMijboa9IeyBIYKivy1eyKQ4W6kr52YwIIVRrdZwKtXoowEIG+3c/gy9mZkNiabH534OL27C1O5YiDPFHFHuSy4y8GOKHUF/N+lAHgNdbNtjX3THwA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwXqRIh1c/FWMjIk7wTKdwpF2Bywt3m5HE9ybhSO+G0=;
 b=i8rlBu3zwVk/N0MZUMQdl3qHIyIjs1i7FyNDPG7Zadg/lf7ZLPB00JAqxzxMlfJh45zCtEYDIw08v+uNQUEHZFUCHsSMOhCaK7d+QGOiIVzG3CkxbCs/w0C3Na3EzA3JDJUr746Ah9VBRvjqY8vIMDQjiBgk66Bh9oXL7OSy0VgRNPBl2pH/V/gW1eNwvVqiTXAhaQVZevlWtDBZB0sYdyV5/fnQq2K4XrJ6F15NF0u3qyHdXgDZE866USMiRcDNHM1YM39Vo36gWp29Nbxgm64CyxdMnMsLGhoM0aeoBPb9hRsZ/fHSMiUOHLwgHTciFva9+RjYzWBJHcyx2KNyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwXqRIh1c/FWMjIk7wTKdwpF2Bywt3m5HE9ybhSO+G0=;
 b=H9cfEkeuaZylTNl1SvkbDezTvrMMfdwHp7bQnZZ6dxFZRD+jXwFouw7MhImH2jvW1nbUsHhbJ7VhoGCroAyBlx34hApunukPuKBatc70V7ja1IbcjNOvQC1oXOhs2NrIPGOqRBWauklW2JMZZ0MzeHDv3HP53IB4QCkcl5GtNMo=
Received: from CYZPR05CA0006.namprd05.prod.outlook.com (2603:10b6:930:89::10)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 22:49:02 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:89:cafe::71) by CYZPR05CA0006.outlook.office365.com
 (2603:10b6:930:89::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 22:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:49:01 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:49:00 -0500
Date: Wed, 1 Jul 2026 17:19:08 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 09/12] KVM: x86/mmu: Use split "zap all fast" helpers
 when invalidating memslot
Message-ID: <j3yuitpzh5ttgtajpwfosdiqz4rz7ieidfl4vzwkccnzih4hs3@bstoftpjbsbq>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-10-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630222607.497895-10-seanjc@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c1fa8b-40a4-4276-cafa-08ded7c2f1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|18002099003|22082099003|5023799004|11063799006|4143699003|6133799003|56012099006|27256017;
X-Microsoft-Antispam-Message-Info:
	+jlh1JNhmmlzQS31mukOKjGneCYz6A709YVFdnhJp9n3xdx/fw8ZIAOkOYy8gLhc2PdHfPMjHnRKA8d5lk6birOe+F/OF9P6Fcefj0KJYSOKjvpSeLIicre6WpXfgBayIUCuJ7N1w0yitk+lcnIeUKn61P02vaf/aNvVpeI6GdLjhb2GiskTz9Uaa0GTzbcgdM0zDp6wCzVvSuQmWXJi3JOokdLrddDMD88q1paeuV0zvTWz8PxnwysbSpEFdmBm0zMm4RWMflBaDxuMLHV/5id3CpR4qEmsFj+07eR9zEQj/uGtPZtNl32sMR+vH9tuGd9XFIGA/DaEVsQ454i6UDgoSl64lz0jd02v0D3//PF2dIy0MrKkj1i3faSXDTQ8ryo0PdVcA4Y8hCV+WoaeyBjb6KMNo4QazXubcImchYhVcS1C71bjajxXX5Oy2DWDrxJ5GqjNjlgaNlc7fxXQW/dePMYSGSXIpZw5YtFt12oczBTNkVbrAKZpzukHyB/QhO0ZbBkw3LH5bpisIzELw6AQ/6I75JGqMFhdn1Oxc7gJZm3WeR1OzQhlPf/r3Pr3l9ZgGBsyTdsQQQW5CwgQ8x7pl3PBxQerXeA8QKbxqCcL07AOWaTB4Nweti9bTEFr+kaMzsKCxy3aW4WejyHYzJ0hOpun29WbD/LDadziRYyDqwXrDA5tdkg92u8iDMu85iTGmQtVlXtTM0DsFTSlXaiRlkTfZu5z/e2OCkFtJt9UJ9jozoWh+M1fG/i9km3c
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(6133799003)(56012099006)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7iUh0D0TxLZa4ZgR4vePag8bNRFsVTjbA9AKAa5dMOMOjosilGoWs+Sf6rhkIQD11C9yZSuIRumTcK6Lohd5nPooiUKpdim3O4BIyiYsN1BGLYbdhfNGdYKkFlvX5j/xccfN/86gEANibvW7VwEAODm5w4DAwletpufp3ptv571Kh5crKKE20ShWu4EptVr7d0l//m2yT8GPCBOwAlKePqZPAgbtRnV+51FQNCunK9mDkKcvXhkQlHGpzcOIkppbJLdosabWBT3YN8QNGhMP/g+ZcC4nD8+KQILCgNlTzrCFHCx8wZLbwNIDj0FkY+SJ+6pqyr3Imgsw9XGUchDLyiZ67hxAzereNI38KNLWGxI1Ah9PaQkRxMRun9fODfixp29hP+BHYJrJbq1uxS1XcLr0U++8qs9Ijp1vMuMsB8U2RkTeD79xryE0dQ3pfZpQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:49:01.3709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c1fa8b-40a4-4276-cafa-08ded7c2f1dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916

On Tue, Jun 30, 2026 at 03:26:04PM -0700, Sean Christopherson wrote:
> Manually invoke the front half and back half of the "zap all fast" flow
> when invalidating a memslot so that mmu_lock is acquired at function scope
> in kvm_arch_flush_shadow_memslot().   This will allow putting more code
> inside the critical section without having to take mmu_lock twice in quick
> succession.
> 
> Opportunistically open code checking whether or not to do the fast zap, to
> discourage removing the local "zap_all" in a future cleanup, i.e. to ensure
> the SLOT_ZAP_ALL quirk is queried exactly once.  Processing the front half

Enforcement through finger punishment? That sounds surprisingly effective :)

> but not the back half of the fast zap (if SLOT_ZAP_ALL were disabled
> concurrently) would result in KVM unnecessarily keeping invalid TDP MMU
> roots until the VM is destroyed.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  arch/x86/kvm/mmu/mmu.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a5c2a560a88a..3eb1f86593b1 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -7573,12 +7573,6 @@ static void kvm_mmu_zap_memslot_pages_and_flush(struct kvm *kvm,
>  	kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
>  }
>  
> -static inline bool kvm_memslot_flush_zap_all(struct kvm *kvm)
> -{
> -	return kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
> -	       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
> -}
> -
>  void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>  				   struct kvm_memory_slot *slot)
>  {
> @@ -7589,16 +7583,23 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>  		.may_block = true,
>  		.attr_filter = KVM_FILTER_PRIVATE | KVM_FILTER_SHARED,
>  	};
> +	bool zap_all = kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
> +		       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
>  	bool flush;
>  
> -	if (kvm_memslot_flush_zap_all(kvm)) {
> -		kvm_mmu_zap_all_fast(kvm);
> +	write_lock(&kvm->mmu_lock);
> +
> +	if (zap_all) {
> +		__kvm_mmu_zap_all_fast_front_half(kvm);
>  	} else {
> -		write_lock(&kvm->mmu_lock);
>  		flush = kvm_unmap_gfn_range(kvm, &range);
>  		kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
> -		write_unlock(&kvm->mmu_lock);
>  	}
> +
> +	write_unlock(&kvm->mmu_lock);
> +
> +	if (zap_all)
> +		__kvm_mmu_zap_all_fast_back_half(kvm);
>  }
>  
>  void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
