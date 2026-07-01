Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445E361DDE;
	Wed,  1 Jul 2026 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946173; cv=fail; b=r6dwinJGz/cz0xxhwE7q8sdVSYE6LicX6N6q3Pz/lwDeB66vZ+Z354Ud4EdCCjzOUu6fvVnAyFx44+zI7UErhkxIArKvEs3Mpcm0SsQfnVBMxw6QaIKGCs/SMLuyB7wVZHQ4wRNxpgdctVoTfECR7t+kqzgX4AeN2JJcbb283ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946173; c=relaxed/simple;
	bh=a0IVp7jX5DaHNgEowPtZWZ+QuA41lzN1mVzFpmwL6Cg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiSpdNzKG6Bq8yeH+bRkKkQTPxFdGBT3sq2VhdRSfBqBm7R948T8JNNrhS3TBavNQSxWlpIGGrwh6z+5qI5/Aibuw05eCZWJ4qCGrleOSmtIe5+PynbJa5UcHYa+OVL6QpYDHztpitX+hYani+r/KMD0otLFZl0gQtstNt/rTPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CJsxJE/2; arc=fail smtp.client-ip=52.101.193.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CJsxJE/2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ov+MlaXHt9AVylc9Qb8tk24qPzRJdQKeyrWDdH4C351NDbdsYX5XJ1jPPAOPCeAlYVjJHB7hCalnnwUwLn/6kN3o+aTBl+mmtPdJ43EvkjggMts0LMY+Nx2kJr5anJhivd5G3Qf8V02JNANhkhVo0aSzDatih1nQVwOJg7q6gpTf/HCU9rrM0nWZk7JDfT13rigZHnG/B8dOsgKbLGYopKw574JfFJ9EkIF+tOoD6DmIh+paunnSm6nK6LE96Aasgef8R2XszXvxd0oSEJJhXkeq8KCfkL+RU2SPlVrGfHhaA9ez5aikdshZRCFORYz8fbDu7m2o0xBEeHOouB9TKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjZbIn2sIfwD9Q+c+SS2g7MYSVOR2In0UwsgGgk2J+A=;
 b=nke9iXlb0M5+V4uLftXJV8XrFtLjJGoCKD1/JfkQk1jopcvCSDg92ni1pqD4ML/D5shieQxgX8f1epTu0DcZTVtrargLdK+dHXb5zk8gJ+4iixva00+qxdxnzmAx3M2R+TqkGQaOCBMaRHs3x1QedBW1IQ8QT+onvgP7kehQmdmvuu4KVgZQmlm4RT4j08F6Rxq5owOGurGDEBhBfVRdoa639DcyGBYlftClpkTEVMQQ1L8xdoWN16fwdX8zUDZhIZE5hmHTu7SqYhpDWKjpS3cf7FkUoo6gNmasWL2qDmOZ/2i/ukL8DHNmoNJLAMLC4WLJRPMUPqp6nSafPlkqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjZbIn2sIfwD9Q+c+SS2g7MYSVOR2In0UwsgGgk2J+A=;
 b=CJsxJE/213+eezHL2LBcfo8DLvTJ59Kl6FvQmosTMiTsROG5+mz+z13Nw4jmzIBZPvP0TKN598s7Z/mLqHbytMSTtYjUnDuR05EyfkK0aZvV0oPWht6QerIxmbs+yaDI34ut/Zt6zb/SOYSDYOIfd7IMBlQ8a64czSk7l1CIG5Y=
Received: from DS7PR03CA0175.namprd03.prod.outlook.com (2603:10b6:5:3b2::30)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 22:49:22 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::27) by DS7PR03CA0175.outlook.office365.com
 (2603:10b6:5:3b2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 22:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:49:21 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:49:21 -0500
Date: Wed, 1 Jul 2026 17:42:33 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 11/12] KVM: x86: Guard .gmem_prepare() declarations
 with HAVE_KVM_GMEM_PREPARE=y
Message-ID: <mxhv67srfonr2nh7eoecujibf2umlbhyrhutdiizmm7qimrwyq@c357mnkz7lvi>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-12-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630222607.497895-12-seanjc@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 01647d59-70f8-42bb-0b9f-08ded7c2fe25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	NueIHkCvO45GxtLwAKKX4YlE9iGVSHN/9ww2uRQaWHMunBmMMYrVxJWh9aRrV9bNp6+HAIst9ydrebB8oicKxjNDC2GxXcr2otVCnaIS9HoUvE6Yq8CH1RUlFLjq+wfumsSbUOVCdTAhYF75gPBqlvugMxpfemaXbVNT1mbjs06upHBTO+SyKAPC3eEjX/nDsXwk0ru5bBYBpoPc84ru4IpSyb6scPfFEeYAFOk/rvLOf5revmWIU0Yj2xxAZaZ4Pided+QzrAXhe8PMYocreKmJ/sYFQAuwbvNcHYBVtdydInn7Vws/qyY5qRKUXWqkY6pJuw99ODztUa2W+wdsGJcFM/zDFPm6vso2ZkvIe062+m2cvQEu2R0nTBSxiLCBn79OkTnwQwQvWheLvNufXpglnddKdlSMy43+rHtYg5v/UD2oRN6eWpvLbKtmOaQJ8sbnxzg6vLhwwqCug9p3NFaUbioNyr+1cbHy5f6bi14FWKlmswWld4S1t/djFsbdXsat6NvJYVIXgcCWnhuPdIpYwCx3kJBVE8A8Ci2qC2wKR2jVwFYctf8tQC3F6GhOLFWirtItgggW2hj7SDAeg75qOgt038UCd/2ESfuNtmURH5cyvE1xXL3xAQ45z0C/vSKmWaGCahVIKevpI5eaThoeuocahiXg6PejfD1jL5fiTdrnHK1w6tAtTh/6DQ0I23SO22kTjTtJOcAkWrygZw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C4wt3A5oioCjCe5r75fMZsXPnqLMZoPwxS9iVANLhOcxzCKiv3r/BojppfqGho8jYl26D/yZAAj61lQQR8hr7Vyr0d2ZF64jZ9SQJfKH+5CcazwRM0khbhObqNwXCrO/+MCOx9XfczHJ0FkvlhhPaJVQGfr1zM9NT906/iKayFaYezRU11XNDpQHHIR9yOapwgs1IVNfhl2mmnoAQG3hNs0fqYxZ6hkt2N4DsYHsBv7W6LGw4qSAcKQdbclTLutLVj9BxuQ+ezQG2vytA/w/2i252NJuDcBPNoRNdPJcT8k/0W4Vnrif7xOLRkFlmkffgZsidB43irvYp+RP8N3RXUSF8QxpG9v2RX7ROg8gXhuVBGjsreRzmi0hvLlUrSVA38UZwuIf52SzTrGqeOuMtWcDANbYJRdYlXOkehgZS4RW2aVO+m678NtSODmRkML6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:49:21.9975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01647d59-70f8-42bb-0b9f-08ded7c2fe25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397

On Tue, Jun 30, 2026 at 03:26:06PM -0700, Sean Christopherson wrote:
> Wrap the .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE so that
> non-SEV code doesn't try to wire up a callback without doing the necessary
> enabling.
> 
> No functional change intended.
> 
> Fixes: 3bb2531e20bf ("KVM: guest_memfd: Add hook for initializing memory")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

Not sure about the need for the Fixes tag, but it certainly guards against
some future problems.

> ---
>  arch/x86/include/asm/kvm-x86-ops.h | 4 +++-
>  arch/x86/include/asm/kvm_host.h    | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index deb3ded5796e..39247d2f29d6 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -146,12 +146,14 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
>  KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
>  KVM_X86_OP_OPTIONAL(get_untagged_addr)
>  KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>  KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
> -KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
> +#endif
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
>  KVM_X86_OP_OPTIONAL(gmem_reclaim_memory)
>  #endif
> +KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
>  #endif
>  
>  #undef KVM_X86_OP
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 93af3bb82869..cf2ec19212ad 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1903,7 +1903,9 @@ struct kvm_x86_ops {
>  
>  	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
>  	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> +#endif
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
>  	void (*gmem_reclaim_memory)(kvm_pfn_t start, kvm_pfn_t end);
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
