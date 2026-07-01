Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C11C24DCF9;
	Wed,  1 Jul 2026 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946190; cv=fail; b=Ksi+C3KbQ6NcdWncAy3/J0UnpO3utLZsfVrrIKs/XeYuPrMQLqwq9OmKKHOym5YQm4OKL7neJNX+clfdfZBEyilK8eoSZErw8NnYWvW4miUukrf8tFRNznpkWHd2pZiDlsF9hO3UmxClBNzL6qbbs60DcV3vnNEpvyRsUf26Gkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946190; c=relaxed/simple;
	bh=r5vpUUW95izMRFyJM3TxgXdK5FgXUraYVDFLaFWgCsU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFPtOhkxJUxb49duWlSosmlBu5uYj5B/FPVO//191HtpHnPVczBa6/aTKC9kPlamQget0uHEPXxg+sYFUeEoEcI8HV/t1xHh3D90oRa9EnEs0aWCz6kq4kcobsfBcoHBLAlRiCb5ISRmNsg1LWLqf8Y1RwRdKCl01ZUQq276pRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h4YX38mm; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h4YX38mm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBgiqTfQNVjfcqE7hQdLgv0U7VBZ/mzoN+WutHV9ne92MXjv5Yms5MOfl7QjtR3x9V0UrYL93HNFXxjPbQF4L+yOa7CXIdiC8wZjVNP1qHB1LVW8RSvm1WP5/QzNExO6z0RJUTDEN7GMVKunN8Flgv8gPIPNHTB7VtmPEMsVsvmgJ3i3HrcExYjL9+b8As7zmRXGw/tg2NdeUSWhmabuYhrnwq282AQ3dk0ujLquiJCCznn3naKMWHxoa5PaKzaDVPpF7mpIOG6iX6L/DbXo0bV/Cf2vdl1v4dCwd/m9uURpXvvGpb8bNGKJXmagSwUGoZLbNkktL/C48prWth976Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZwtcvn+t3k8pGxDEwI7T5NeYvxIBj5QbPLC6DUTrU0=;
 b=EsjmzB3tOEHV9NGiH0CYT2qnzKgQVf0FPCsTMQCoqzq1yMVM+Q2mvtz0GbBdBGzOJrCcqYg85v9OQMxz3m65grygX8L5m9cw8YEt2CsiPr+1RIwlBgh/mJUfrKO+EKVljpOkoSAWGCB0q43Cmf1iiS+P7GkyXbh/3BbWrWyfaPQrK0aPlaz47kTOYpf3AS51TV/uBHO5EWmxjVDs9zIOtopr9+YEmrsix6KPTGLEzwYQBYp2oKQ/qlFktgn+CshLNgxtcCVbiJ2ry50YdNPQ86a2dzdtc6rHs8YePcy1XIlQ0uQNlx21H2Snmj3h2h52ZW/UmbOfHE0MxypJeF4Zgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZwtcvn+t3k8pGxDEwI7T5NeYvxIBj5QbPLC6DUTrU0=;
 b=h4YX38mmg7oGbQIFMfkeWD4gD3ykSL4qoCnaaBcuY0rUh3/ccIs6N9D/8+L3xjRvDMLcB/+vbCPPmMgIIep8U2x7RSXTZjFv3C09dri2cZyPxr4Wm9++2S9iNyiGu4ssEEwsVrCYRgs2IknjlIJa0Y2n/4SIXVq7GJo5PT3fAtE=
Received: from DS7PR03CA0159.namprd03.prod.outlook.com (2603:10b6:5:3b2::14)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 22:49:42 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::a8) by DS7PR03CA0159.outlook.office365.com
 (2603:10b6:5:3b2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 22:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:49:42 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:49:42 -0500
Date: Wed, 1 Jul 2026 14:33:40 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 01/12] KVM: SEV: Track the GPA of the guest-controlled
 VMSA used for SNP guests
Message-ID: <yvgwrvy5v6vynhdhmvm5fr53mhbsrukorsffpvxbfqn7dl3tm3@dr4qeadhpfp6>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630222607.497895-2-seanjc@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 49915e37-0d6d-4e19-117a-08ded7c30a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	x0k+mxDoIRdGep0/pzQPd5E/W5Ug/TyvcLa1zlNvNVksLc9zgWr7ajsKfx8iwngmmE6uwgY3z0MbmbxmnwmILQ2Lw9Wz4LzNXLg79TsKq0s6LMvE/a4zxJtVtxADloh4Vr94Cb2ZjEv+H4W3REF9LVJlnfOoqTi4FWGnACFUlsL8PHST0kb2x5nf8qdGwqZRhzwTJm2z92lBnop6YzV082jbescCAoi2BTA+33ztXuZwACKEDFW/BqDgN49Ac7J9p8l3x0ee9V7ZqyEyEIkBZFPSxb8AK8PTCxza5GQyNbGM58jYCddGv9mxEM70G8JRPE754/Ms7LcLGovRq5JohXhsRnxiBvi04W7fOZYlErX04snepMr532uPVRpLE59ayTMpgLjTLpEs3/K5IbL9mS/cYZd88Wi/CzI66rtk9zUe5Kyqev93Iqv3jRByPYlx2ZLIBmcrfwqpClTmHHpz/cwYpJdL5RnyQxmBD2oZjSTu4z+/Om1PAuY1LoyC2ZxEau+79VvYhD2YssGSNWCffJJIIxGx8Qv4ZT/AVeddJS9ZHUOkH45Ep1cbSh7Byhsq2DQjdrVqAMbFK3Mi2TvUlgIV9R5kgFpVPNiZ5kXExEZ9vv09QkgIewF+Ws3oizyM+HXTN5jLS96eBfQ8uAx5yZ0/g03SVrJ6dm3T8AAAJqQy6Xif7jYNDyg+5kby12gLhsuqlwcEgwekThDWh2B3UA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rR/gppzV9CnsiWRIbutegsKJXcL34Rum70GAkJUzuFZXErp9Lph8JEiGiAXQR9w8eGEXkwDlvHUjHOJ2h3flBlh/jVBWsYra+F7AT1BCg8OaplBRT312u9SBXN/rs1O9JCIpTzFLXJ98evldI2w/freVqrYBFsJyJm+faMFfmK6Ka1J+xplaASeWvzlz7K3Z+Fs8AfzL+6tYWKXOtUG2xhr8d8fcc7RnweXYsZQ0SB9sG88vSxNFss7XoODcDi5H27MGlzle91l0LH3rrm1ZN7AxSFOwkVUG13Ef6cmf9vajBEWxI2mnV/h8RX/oMrA7lfS9t3LkR44PPzr+CHKFi3lTRmbBby9j49XdvBsoVygD1568dyHeCnV5IczrQgx0mNLJjwBIvhEcjYFeJWezxY4zv5twC5dnNj94DoT2/8afAt/MsmbukDN7UslpPKLX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:49:42.7043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49915e37-0d6d-4e19-117a-08ded7c30a7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372

On Tue, Jun 30, 2026 at 03:25:56PM -0700, Sean Christopherson wrote:
> Track the GPA of the guest-provided VMSA used after AP_CREATION events when
> running SNP guests, instead of simply tracking whether or not the vCPU is
> using a guest-provided VMSA.  KVM needs to know the GPA of the VMSA that's
> actively being used so that it can react to MMU invalidation events, i.e.
> so that KVM can drop the VMSA if its backing guest_memfd page is punched
> out of existence.
> 
> Opportunistically rename snp_vmsa_gpa to clarify that it tracks the pending
> VMSA GPA, whereas snp_guest_vmsa_gpa now tracks the in-use VMSA GPA.
> 
> Note!  Take care to track the GPA, not the GFN, as VALID_PAGE() won't
> behave correctly if an invalid GFN is converted to a GPA for checking.
> 
> Note #2!  Keep snp_has_guest_vmsa so that switching to a guest-provided
> VMSA is sticky, even if the guest-provided VMSA becomes invalid.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  arch/x86/kvm/svm/sev.c | 14 +++++++++-----
>  arch/x86/kvm/svm/svm.h |  3 ++-
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 74fb15551e83..827f5dc06102 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4003,6 +4003,7 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
>  
>  	/* Clear use of the VMSA */
>  	svm->vmcb->control.vmsa_pa = INVALID_PAGE;
> +	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
>  
>  	/*
>  	 * When replacing the VMSA during SEV-SNP AP creation,
> @@ -4010,11 +4011,11 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
>  	 */
>  	vmcb_mark_all_dirty(svm->vmcb);
>  
> -	if (!VALID_PAGE(svm->sev_es.snp_vmsa_gpa))
> +	if (!VALID_PAGE(svm->sev_es.snp_pending_vmsa_gpa))
>  		return;
>  
> -	gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
> -	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
> +	gfn = gpa_to_gfn(svm->sev_es.snp_pending_vmsa_gpa);
> +	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
>  
>  	slot = gfn_to_memslot(vcpu->kvm, gfn);
>  	if (!slot)
> @@ -4039,6 +4040,7 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
>  	svm->sev_es.snp_has_guest_vmsa = true;
>  
>  	/* Use the new VMSA */
> +	svm->sev_es.snp_guest_vmsa_gpa = gfn_to_gpa(gfn);
>  	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
>  
>  	/* Mark the vCPU as runnable */
> @@ -4105,10 +4107,10 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
>  			return -EINVAL;
>  		}
>  
> -		target_svm->sev_es.snp_vmsa_gpa = svm->vmcb->control.exit_info_2;
> +		target_svm->sev_es.snp_pending_vmsa_gpa = svm->vmcb->control.exit_info_2;
>  		break;
>  	case SVM_VMGEXIT_AP_DESTROY:
> -		target_svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
> +		target_svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
>  		break;
>  	default:
>  		vcpu_unimpl(vcpu, "vmgexit: invalid AP creation request [%#x] from guest\n",
> @@ -4791,6 +4793,8 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
>  		return -ENOMEM;
>  
>  	svm->sev_es.vmsa = page_address(vmsa_page);
> +	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
> +	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
>  
>  	vcpu->arch.guest_tsc_protected = snp_is_secure_tsc_enabled(vcpu->kvm);
>  
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 716be21fba33..d077783c287e 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -271,7 +271,8 @@ struct vcpu_sev_es_state {
>  	u64 ghcb_registered_gpa;
>  
>  	struct mutex snp_vmsa_mutex; /* Used to handle concurrent updates of VMSA. */
> -	gpa_t snp_vmsa_gpa;
> +	gpa_t snp_pending_vmsa_gpa;
> +	gpa_t snp_guest_vmsa_gpa;
>  	bool snp_ap_waiting_for_reset;
>  	bool snp_has_guest_vmsa;
>  };
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
