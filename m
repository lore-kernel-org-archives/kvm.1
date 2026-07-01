Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED73947B5;
	Wed,  1 Jul 2026 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946252; cv=fail; b=STOoZ6gLhfT+Zi29gvkh1zoO6+5pLvCTZ1Qcpm4862hH11VF77i9rKbEkT5RGPak2KZ06/FqO6l9w0NEfjVdU8cgYOaIIVC3RkGFX1IR9BuY+nia6p66UvAOV/AyMvtsmTwxEihnqEYXxGIEYgXgiu2KCcVeHF1bj76iR//KPjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946252; c=relaxed/simple;
	bh=7tf5/k2GEMaOZlX9p6epuVsOvx/sdlj+iieJtvaCtYo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1p3AhXHOsOMV3Fy1Li+1L5MOFr9xnQ/59pyjb9RQUFyiUsRHq/BDh20eQu0puOJ7MwjNSap71Lx9XkYB717eL4/svGtIs2eZc8MZVmH6ESG3aEqiBuhypoqBcXoGJ01mnTuQnGT1DpUAXd+VI3Hw41h2ZyVKXxPVzrThnWFYbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4qIqgQaX; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4qIqgQaX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvi1Fhrxcff2QF/RuybB188F43AQi+6nGbqWwTLnfxSjDaOHWmjWLXhBy+lami5TR1O1ubrvfhoZVPxW3Z8OA6NEJ4pJhTVdSYJc9merAWy/+btoCZQ3e0okL2GABBpQIqjlik7RVtO4Lbr5H9yc9xsfo99MToGxhj6Yd8bboDVQJ4F0L2l/g2DL1Es+nWLSAWv4MtCYC/FRDYq2ECkVEfeNtw/rvGKhqWkAXF2cCcoJ/Oc38VwS070ys4rqXNLxS9IW0CIq94bnSIDqXIix4CPw5lOuKhoTOKHD2s5Lj1eIQWYRm+V0J8zA45CBBKz+pzY2inNRuMjIV+UboN30Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+C8Hwc0C1Gsy+3Eer9YnZoSqL/2u/qBXBJLAxr350k=;
 b=cBJQUHN+Ik/6WwhfylV4DgRQkztO8EmxnAYM86iZ9Dk8frxOc1YqKYYt2VCVK5qk/K4Dm2ZLo7r9DbeYXoJBDANmpgCYBS6Z/RSoOhsV4OM2qoUFWdagJsWB6CnNPAdnFDM8KgZNVPbA1zG4rOXoH+0VqVcRQQmSJ8bKBXghhFTCPS8Im7QrvqMkgF5loAzUGVFYqCH+5G4xOnoQilDDEfN7wkjUGjRhi/Rs42arUU6D+2WVKlvV5DwUtQhu1YlCK3rYqqFIHyeCel5cEOAZ7RA9EBPPqBscmkXHdDqw5NlXvI3gJEWVbp07bTmdookZwa+PzwaxhoMEGuynVEaVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+C8Hwc0C1Gsy+3Eer9YnZoSqL/2u/qBXBJLAxr350k=;
 b=4qIqgQaXt6s5L5MMXO0YXpnG33PO0ERynPOfFHimUPKMlkQWjCcyeGpgYtZvt9IE+T/04yz5M2KvzRCVxD7SdpeotQ5qMy0dAK0ngFabGGeozulnIR3/Hhb51ehBmsDrh0WZ5s8Z9hWOs4HA+dSfC+B/WtdtOvnj2Dif7VGmLFQ=
Received: from DS7PR03CA0119.namprd03.prod.outlook.com (2603:10b6:5:3b7::34)
 by DS5PPFC9877909A.namprd12.prod.outlook.com (2603:10b6:f:fc00::661) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 22:50:44 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::f) by DS7PR03CA0119.outlook.office365.com
 (2603:10b6:5:3b7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 22:50:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:50:44 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:50:44 -0500
Date: Wed, 1 Jul 2026 14:36:57 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 03/12] KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE,
 even if VMSA is unusable
Message-ID: <lolr2wiyruk7fja72oomeyvfgkkwfynqfrqcurwn7qbh7u6mis@5qa6qp7ibwft>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630222607.497895-4-seanjc@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS5PPFC9877909A:EE_
X-MS-Office365-Filtering-Correlation-Id: 525ea8fb-1bfc-493d-d8b3-08ded7c32f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9xf9RaH3oGRYe4CaDHxCNkVOBnyZm2dCn/fMeAyE0DWUYqlEiDW2h9m4Q7UQQlsIZxrETrl1S5qL1e83A/mM+VKeAEPyGtT70ap4aOCpaJ/W1C6QBkUFdm0hotLB6USD4IpP8Ko/CCIsd8d4475/b4LoUMwfNe4kSeKBBIVbpU0dPQNOTQORTa9FPPAUhzEaQqjCdhHBmjdKm5EFZ34xn0X3Aj/vGR0Hm89f0IpW3Y+a1BZ1OqlD8d29ZuZmdXR4yPAwlweepyKNsP349U0/xyniMAU3cY+lATXz6Cd6GFHAAo/IAFOLJ/3qAMhqX64rBsrfhLr0BTN1SMHpdb9CFDXQr2gCdMLpeIyBBhI9ITvRefOjJtCWkPnwbKvPyZ4CO0Qw/Tn6wMrelWnzR7DECDsVYhJhBU/EcD0l98896kkAtj0B3eesE8beW5HK84oiqxZrATmMkxzvrTrRjUK8LynD0yzKnTbBcbUYgjgwU4icZuYx2+LXa950EVnp8Npx1/An1Ung/JqP5vRyxOVkMDepJu/Cn05UCmrBwDOla8F/0v2gUT4Gni6XqAuPyIrg/CAeJpn9dEYOCqrp8/2kGb64mMxc1i3tQ+tH0WtXcNeXfbFQOGuL77BKpKfFLTMVTbEKu4eukxpm85j7bWqHDwym4U8SrtpxiZVvfXTssaGQNqZaF7IrMO1GDQ2inFt1aEcQBIKNiIgvJsMjdo350g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n713X/nz8ZL9IG13Fo8GeBuOocjifRrOvE5fu96R3SWbQKqvdqWvZqvRwx4v9nj6agecWReO5fQaxy5Z4fESLu/EHOza/kNQ8aQB6POann5VuuCC/NUf9f+GNfRJD+nZ8nR7AB0u97wfKJUJ+j/2Ich+p+LXTCZyBC/9VZlXf9XtYYGsVQLIfTGwrDaYBjQnM9X7KXBz90HAGksVGxabre0krq9FKGKlO23KqwOxpXJbKiwxleXn1z5S8FHKMbccR/ztlXiMPQ0d8/+XJIyiWeUvmnBpuxpDQhtg5sMwXe0DTaxlXkvhioJIc4/hNvuuaPqvw/3A2L3iaQrZeHK/EVeB7FJSj5GdaJO3vERFcSWtgABx1G3622GCNhpUoHqzDWZPSUFX9QYSmgmkB8Ymi25huElFuJMjTpiDh/olgeJYwujm6dN8lPD/FKyrkpD0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:50:44.6645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525ea8fb-1bfc-493d-d8b3-08ded7c32f66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFC9877909A

On Tue, Jun 30, 2026 at 03:25:58PM -0700, Sean Christopherson wrote:
> Always mark the vCPU as RUNNABLE after responding to AP_CREATE, even if the
> guest-specified VMSA is unusable, e.g. isn't backed by a memslot or doesn't
> have a backing guest_memfd page.  If the VMSA is unusable, leaving the vCPU
> in a non-running state will effectively hang the vCPU instead of reporting
> an error to userspace.  This will also allow retrying the VMSA load in the
> future, to fix a bug where KVM doesn't honor guest_memfd invalidation
> events, e.g. if AP_CREATION races with PUNCH_HOLE.
> 
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  arch/x86/kvm/svm/sev.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index d8ed00f76aa3..30792adcfc8e 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4028,9 +4028,6 @@ static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
>  	svm->sev_es.snp_guest_vmsa_gpa = gpa;
>  	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
>  
> -	/* Mark the vCPU as runnable */
> -	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
> -
>  	/*
>  	 * gmem pages aren't currently migratable, but if this ever changes
>  	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
> @@ -4062,6 +4059,15 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
>  	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
>  
>  	sev_snp_reload_vmsa(vcpu, gpa);
> +
> +	/*
> +	 * Mark the vCPU as runnable for CREATE requests, indicated by a valid
> +	 * VMSA GPA, even if installing the VMSA failed, so that KVM_RUN will
> +	 * fail instead of blocking indefinitely and hanging the vCPU, e.g. if
> +	 * the backing guest_memfd page is unavailable.
> +	 */
> +	if (VALID_PAGE(gpa))
> +		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
>  }
>  
>  static int sev_snp_ap_creation(struct vcpu_svm *svm)
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
