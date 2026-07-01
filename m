Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C0A3F39C2;
	Wed,  1 Jul 2026 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946382; cv=fail; b=ipIGjkgd/BvYLO6G9i4aOoCMZ2acWA3XIWc8uB3WRySaCdsGfjaWRcA+PrbUrOcR1mqV7nJdDvfrAkCK0mo6LrU6f+OHyD2KiskDFeJ/7S0rDbZVvuDkkA7ZqWY2noprXQQiuZQaeayd8vvhJMFtDSjc1vuPVHPKycnyGzaKRYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946382; c=relaxed/simple;
	bh=S/TIpN8sR2ZILnxOyej3tzR8gNRccfnpzUjbw1HVD8Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS7h/HoCy2zD9dQEDky3XCOq2j6Y/i3G/yHUUuvYABmcYyGn5XUu5hyL4gEmGNC+auFNl2gz07UayBLJOkmokbV5d0EGooBbC+ce3RJAaOuoZtNeWueOgJ1QXXacqumTCKmgasD1b7tFLA0DjJo3aZkKnMDcVPnoqs1D+r0cjs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YYFjoB+N; arc=fail smtp.client-ip=52.101.48.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YYFjoB+N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FR+gUmhIzS0BsRiW0EGfyK51pZYgCi8Ke1EOEKmDGvse9AHSBuQLQANWxAznt98c9omwh2RnpQ691KPfnosovtOZCUdIEbBqlEj9SPlA6XIei9dDQ0gOfc34NHkPKw59jBRehYPAWSa4M//Kh2WHYb1Q9kDg/cnyy+LbAhwu24J62KGUW8crzfKPS0Yu+dnTngid1GBKEq2fqFVhXeKQ647bjaIyohd64nayIaLew7mcHBazzaVKQe46FOeEtFXmXS81Z1TazulNomBYwv9Psu6AJbCPgfYPIvuwMV2Wqa759wMWq4qrVNeafTa4ScQA5gmoPLqg2u8pfNNMk36MPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmPdxf1ZOqvoVGCnyBLEv5cnDs6/OmD/ZTwdEuULLmM=;
 b=WvwGZwgGPX1T2TgPBqsOr6+hUczyBx6A2V+5h29XXGKLf12ZFQ/4itouBzxwt5s3HPNMiF0LdEqev68XJb4GrJRuhWhMo8N9nO2EnCDeH5L7pbznHWSlsZlVt/0iFLDriOnDKbB/aOZdQDqiZupa5g7l2tA91WWEsHQwH/nHsh+pUvEuw5JlgvhC643aEBD7Dwm3Y++P4AlRAGzM+4Wvak8ApfO8F7Fg+W0qugUcfByP22K6pWbA5PoV9Pf+3+venPkrg+n2zMFgVXFP9ZCMn1siOefjRpz1ThNZL9a9s3smJqeSJ3EtkoahleoLBrf1vg4cGjjuBkq0TrGDlWpUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmPdxf1ZOqvoVGCnyBLEv5cnDs6/OmD/ZTwdEuULLmM=;
 b=YYFjoB+NEBPYThZZA8P3ayV+UqXNuJkXUFrkxLmGLizC74F75lGe3uKXxPzUMEDbJZ8jw6+AGD6kf+cxQxSUXbqU5VceoePb/52FPLA1j3JD9eviFckIy6k4Fs9KSFHolgY3Dy1rGAriJRkwNlrItToamTlxRTFcr4uWTur4RF8=
Received: from DS1P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::17) by
 MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 22:52:49 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:8:451:cafe::2f) by DS1P221CA0004.outlook.office365.com
 (2603:10b6:8:451::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 22:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:52:49 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:52:48 -0500
Date: Wed, 1 Jul 2026 17:07:42 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 08/12] KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into
 "front" and "back" halves
Message-ID: <yl72hx3dx6nfakhrss4ga4hjocmmfusfuoipjzhe5ui3irkgs4@n3wgrmys7gtj>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-9-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630222607.497895-9-seanjc@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 7882d648-e876-47b8-ad36-08ded7c37991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9PosrLmK8KyfQz5SvN/ea5if8IH1klP4H4r9B0vEGFSJ4iZS2oSd18Ze6/TiWBSHyx9PCN8Q4AFrH/Azlx8x2kLJb9glC0vS+aQmmb846kMIJ63BjrIF5bbdp3NTc5vCJrtkZdb0hJ1ltOK2mHFD7Kl2LNqM4whqCtAIQDDil0uIV5nrRsluNe0XFLe8E2Xo8TefRxvsGqUoN+Dn3KuGATF6i13M1616CjSdYeKyEdcn0Nm2lR9RWonJFA50OwQfGHun8MaWKEfju+yShmntOPElhLyKiI9E9TjruoSVVA1dBK3a15qljnMLHusMYWwfH4ahp388YqROliIEKU09xpSs358O4QRXikoV1rUjoF4S7yKcAY84Raqiz9xQNoIlr7EZs6CKLqSQNuNgKaL2+PC1OSWqd+Yk+2hkQLRPLqheZz347WiIwCa5BckSJKRkt3herZUXq8z961zOIKSNP3dsWMssh81QpUbLOWNsSnknYQJl4+x2WPDtch++FEDwn6PjvC2t6y3wZdQscW7N3CemL1ZFkhAmQDnkmZs+65s/kfSMY8nS4/VyZODFJmEQ/1TtCW73htxo/YOSfN0+Qcwl13ZCIKX2KBGHkNHE5mtvkezZDOVpy049UbMXrUMUH5X63yzEh5Sr+ufqCwM+2UgNtAvAdBEsddYKhJX/IbWKQHYHZpU4bc5sOyrtWy+eoVORVYhncZkij3+JHrAb7w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PhA+jAdkWygd2lblxMlc6a8+Tg48l4hkKsRvxzAquxW1tKjmiUAsUbc7ABeqNIWjZI/OjyTEHyub/pyCUTX9SktryYCJTpWPfHXvbneyDlV5shYXfOBrP6m4gykBwe39A6apcgfhzdQECLSmNT6u+GCQOy4U7J9w0OYsjk8i1eJ5YSzrmpyiMap3v1FIZxsEUEYo9CMCCXEDqZrraHBx1XxZg2fXg4/bSdS1BBBdL7XvVoA2JhT5+kwyFxFEgIi9sT+xPJxMPFTtjOE+Z0ZpY0wIeARJi2tnOLmwnDJeEfstE/XTtlvp7K3FOhuuVm+/Nvz6a+9Wo9y98IUrVpADokLW2mgKW3rvFfcmj97yfOvEzHgrckV+QUh1TSRABZpV+aSIyBPzC6ZUIgpivvSWx4gA4inqtacc0KwfgUZoeFQFjFF4xRn+FDLSMJ2gjm1O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:52:49.0734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7882d648-e876-47b8-ad36-08ded7c37991
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

On Tue, Jun 30, 2026 at 03:26:03PM -0700, Sean Christopherson wrote:
> Split kvm_mmu_zap_all_fast() into a "front half" and a "back half", where
> the front half is everything that runs with mmu_lock held for write, and
> the back half is the code that runs outside of mmu_lock.  This will allow
> putting more code inside kvm_arch_flush_shadow_memslot()'s critical section
> without having to take mmu_lock twice in quick succession.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  arch/x86/kvm/mmu/mmu.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 223d80b12b9b..a5c2a560a88a 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6921,20 +6921,11 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
>  	kvm_mmu_commit_zap_page(kvm, &invalid_list);
>  }
>  
> -/*
> - * Fast invalidate all shadow pages and use lock-break technique
> - * to zap obsolete pages.
> - *
> - * It's required when memslot is being deleted or VM is being
> - * destroyed, in these cases, we should ensure that KVM MMU does
> - * not use any resource of the being-deleted slot or all slots
> - * after calling the function.
> - */
> -static void kvm_mmu_zap_all_fast(struct kvm *kvm)
> +static void __kvm_mmu_zap_all_fast_front_half(struct kvm *kvm)
>  {
>  	lockdep_assert_held(&kvm->slots_lock);
> +	lockdep_assert_held_write(&kvm->mmu_lock);
>  
> -	write_lock(&kvm->mmu_lock);
>  	trace_kvm_mmu_zap_all_fast(kvm);
>  
>  	/*
> @@ -6971,8 +6962,12 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
>  	kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS);
>  
>  	kvm_zap_obsolete_pages(kvm);
> +}
>  
> -	write_unlock(&kvm->mmu_lock);
> +static void __kvm_mmu_zap_all_fast_back_half(struct kvm *kvm)
> +{
> +	lockdep_assert_held(&kvm->slots_lock);
> +	lockdep_assert_not_held(&kvm->mmu_lock);
>  
>  	/*
>  	 * Zap the invalidated TDP MMU roots, all SPTEs must be dropped before
> @@ -6986,6 +6981,24 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
>  		kvm_tdp_mmu_zap_invalidated_roots(kvm, true);
>  }
>  
> +/*
> + * Fast invalidate all shadow pages and use lock-break technique
> + * to zap obsolete pages.
> + *
> + * It's required when memslot is being deleted or VM is being
> + * destroyed, in these cases, we should ensure that KVM MMU does
> + * not use any resource of the being-deleted slot or all slots
> + * after calling the function.
> + */
> +static void kvm_mmu_zap_all_fast(struct kvm *kvm)
> +{
> +	write_lock(&kvm->mmu_lock);
> +	__kvm_mmu_zap_all_fast_front_half(kvm);
> +	write_unlock(&kvm->mmu_lock);
> +
> +	__kvm_mmu_zap_all_fast_back_half(kvm);
> +}
> +
>  int kvm_mmu_init_vm(struct kvm *kvm)
>  {
>  	int r, i;
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
