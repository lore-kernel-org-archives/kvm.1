Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4371C5F27
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530930; cv=fail; b=ZwAX0fU+Nt1SEHf+Gtn0DMTbT9S6+gp2i/eiFWMUdO3WyIIgmLtLuVy7PfKzWg27JDsvxB1jMEcJpHc7fOGWofLgFTjZg7qgYygWqEc+R3+CGnJy99b8QbWcmleEPw/sm/LrD8EgOza4cbRY/b4+sXrb5FJdD56/hC0kxZcNMJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530930; c=relaxed/simple;
	bh=xuk7EQn44hCZbZBZRHsjy13KiRaLh+XbS1+0kfr6kZk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1DYiWTxjABRGyuegNBap4GNSXUBGdz3zBTeL9OsJlgvrtmIAZaoLn2eHQ18YM06SH/tM3eMZu/BPhovR1ryQCSVm/FIy8seY0gAyiawbONdVqCWSnyYwrozxZ5IQp11EEPNO2TGYrP+SReX/cKLRtLhhlPF0zjetE0Re8+QyR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CEwYTgv3 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CEwYTgv3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDf089NdEnoM55XPN908W0VFcHTUI5rHCmXW/bGcFl4eGU5d4wpm1DlCTy/yJ9XbEb+BCpvpcudAMx4d/IIcWI4iXQRO8bfiCV7jALngBm/JwEJubyVh237cDnoReEgQjFvlXPxDYMmySu7RHKKNwAq97nD7knVDOtwTN8pRrxJHXSMgbodhOzKDFDxaYoh7+dSUIQF+5bJ/4w1BrHOwXEqae5O7SVJ8cB7D+iyamORUlPoMxuPEmrVcJ3cm9fQxi2nZaKi4yJhUYvInheawRA7s+pK97atHsmT3O2qs/QPmDgDNbilwfiOidQYxdL5j1krAD30x/fibtO79YH1nlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71/AxoMS4W534AS4VwAb58Yxw3tbGbNowc4M+Iapwec=;
 b=tRTk6CTnlkum7kuTlLTF01Ur02tgXbWcBvUcXBeYZAtYKmVdE9DqzRbWRmoPwIff9KFPQpgQI6dGecX5KnIsrw+JbSoSOzBgzAb11cnTgTzSVuYn/EgJCcLqgqr7VGkmWZO6Pl/C1FNh//Qe4DP0amh/siUwW9SSXpMipw6PvZQl0ri2OwPro3PB9JDh/9yFdqc4fVHxOCSy9t42Lv7czZJf+ohQyjQsbN5iUllNcbWka95xvOn2DGNDmC3Lw8OdKBwRQe7xLnuHDFfbAES2KA71t8ZluPFJaBxb4dItbPQmPTd+/cQeZCWa86q0B2rp+P4OKvJ4xjwvWftp+o8ULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71/AxoMS4W534AS4VwAb58Yxw3tbGbNowc4M+Iapwec=;
 b=CEwYTgv3pWC+6ZJuvp/hL2Ty0dKTeZ3V9AKYIHZxTC/q6ow9DAE4svfF4j/wcHarOieDGAWi8yvN9mVfkLkFRhuyh+BFvn+ewTqCogWaP+cSuakXQF+QOFvlzNKInXix2KmJIMM4NICojNvAP8h21tqC/STvHSZGL+TdhfcuCLc=
Received: from BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::13)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 3 Jun 2026
 23:55:24 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:59d:cafe::55) by BY1P220CA0007.outlook.office365.com
 (2603:10b6:a03:59d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 23:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 23:55:24 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 18:55:23 -0500
Date: Wed, 3 Jun 2026 18:55:08 -0500
From: Michael Roth <michael.roth@amd.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <sashiko-reviews@lists.linux.dev>, Ackerley Tng via B4 Relay
	<devnull+ackerleytng.google.com@kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v7 21/42] KVM: TDX: Make source page optional for
 KVM_TDX_INIT_MEM_REGION
Message-ID: <44o2z5j553adpapnyequmk2t6cukor2wjm5urujhrnqhufogh7@jbsolz5b4i2b>
References: <20260522-gmem-inplace-conversion-v7-21-2f0fae496530@google.com>
 <20260523010752.CA7AF1F000E9@smtp.kernel.org>
 <CAEvNRgEVC=fFuKVgZYvWyZD7t_zvUZihFG8hrACjvtkD5cwugw@mail.gmail.com>
 <vawib73p6wsjdihwz636soxorvp74v6zyqona2a2nnpuc673lt@jvlhihgqrs6t>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vawib73p6wsjdihwz636soxorvp74v6zyqona2a2nnpuc673lt@jvlhihgqrs6t>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: c80d4c2b-26d1-467d-0e7a-08dec1cb943d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|13003099007|22082099003|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	4xda5+vBg1oyOi0ChY1s8SKSEh2A06Y/WsTpPmmOEj0xqFlhZHvClTBFtfV3PO5e9jZbOfP8oH94Y0UJqHroVCo69y8XIUYokphxRgS3nKGz975UvQKBZVn7pjZQxFODD4g4cQolOU0rcJUziC0dZS0Z5jlI8zUqhW9VdVh3yLww4ESTfOKtek11T2uu2zrjthHJEyDNLQ70uLABMg0wrVAP5tWR5egO03YujU1tDZikvPT9n5KtafF8ERy5owTGbaUtUJCTVAv41Io9lAxOTucdwC8GFPiGRVSn+2vf0UtzAllwThQ2hhW2cHtOXjK/0zygb4y1XqD1dV4IxVfqwdvGkjwnAAfdPFpcSCXwmnCjRGfSS2ynU9Zl8J4V0u2E9ZPnXjCeHFwqWkU76Dtz5Z9L69pQXo/ja2cUfzazOo0Xn9fLp0+ADAQtzMxIOIDNzP+l8YJnvQL8inKEWRnsxPxAyG18XRM+Cd7625RidXUIGRdy2eO5sl0PvTf45zdYMAaiDyZ746A+4V29qz59Urj/CdnuCM1Uls/k/Zama0KNIJZDENJXH+c8rilfWU/9kqKyS62QC7Xhn+1sLj77zOqRqQi9ypFjo2o17f5k6hBSYzs4FOBZdowwmcqrsVX+ZK6O5z/tWAS/b6EBLfwDP+cxhIYIdNpJTcqU0DioIrCrVxbOU2o8+mUHxcLIkeG1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(13003099007)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bnv0/TxlqEYwYFjubdsXEZoj1sM2SWeNRYjMgIMPimMLGwqcFtvw3Ibx7SMm8BBUE2oWOzOsq5kpwAIMmtrm8CiMlvK8NN4SIASk5FMAC4yHnrXifnA9IJL40Wjhlv+ljbnsZaVy0ZobEs39wZHQTywyRZedtsjCyddR1PVSfeD4WAlKw3MzmGBge9kErMXakj89FOfwEJBnk6yGex6empI+Aw7B2vzm6UIGKzLREmoOuKNjRx0TzpdnnIYVCJqgLgqOsIR0ka5pocALK9shduZlB7YE5tuDt0EB4Ntj33URSF04T7cAMrEF47btt3RU/vRLWWg3MvzdmzLlD4Kebt/1WqdElkK1I+tgbfYBBUd0lC2++uoA1WKdG8Ur10B3qRbCBnlCwGzmJdJo1EDnF8wk2mOE5XYz5X5O6Agy1oE3TAnlO7ZHoVy9bskAn1s4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 23:55:24.1393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c80d4c2b-26d1-467d-0e7a-08dec1cb943d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001

On Wed, Jun 03, 2026 at 06:45:37PM -0500, Michael Roth wrote:
> On Wed, Jun 03, 2026 at 02:22:15PM -0700, Ackerley Tng wrote:
> > sashiko-bot@kernel.org writes:
> > 
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [Critical] Uninitialized host kernel memory is disclosed to TDX guests when performing in-place population.
> > > --
> > >
> > > commit 38e76d2ce3c699d4b64b580ab16a7b4cbc2b189a
> > > Author: Ackerley Tng <ackerleytng@google.com>
> > >
> > > KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
> > >
> > > Update tdx_gmem_post_populate() to handle cases where a source page is not
> > > explicitly provided. Instead of returning -EOPNOTSUPP when src_page is NULL,
> > > default to using the page associated with the destination PFN, allowing
> > > in-place memory conversion.
> > >
> > >> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > >> --- a/arch/x86/kvm/vmx/tdx.c
> > >> +++ b/arch/x86/kvm/vmx/tdx.c
> > > [ ... ]
> > >> @@ -3116,8 +3116,12 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> > >>  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
> > >>  		return -EIO;
> > >>
> > >> -	if (!src_page)
> > >> -		return -EOPNOTSUPP;
> > >> +	if (!src_page) {
> > >> +		if (vm_memory_attributes)
> > >> +			return -EOPNOTSUPP;
> > >> +
> > >> +		src_page = pfn_to_page(pfn);
> > >> +	}
> > >
> > > [Severity: Critical]
> > > Can this sequence lead to uninitialized host memory being exposed to the guest
> > > if the guest_memfd folio has not yet been populated?
> > >
> > > When KVM_TDX_INIT_MEM_REGION is called with a NULL source_addr,
> > > __kvm_gmem_populate() attempts an in-place conversion. If the target
> > > guest_memfd folio is unpopulated, __kvm_gmem_get_pfn() allocates a new folio
> > > using GFP_HIGHUSER, which lacks __GFP_ZERO.
> 
> For in-place conversion, if src is NULL, it's generally because src *is*
> the target and it makes no sense to copy the page to itself because
> userspace already initialized it, which means userspace should have already
> trigged the uptodate flag to be set via kvm_gmem_fault_user_mapping().
> 
> So maybe to address the malicious case that Sashiko seems to be worried
> about (where VMM purposely doesn't touch/init the memory to try to leak data
> into the guest), we just need to error out if: !src && !folio_uptodate(folio)?

Of course immediately after posting this I think of exceptional cases, like
SEV-SNP can set up pre-zero'd private guest pages via this path, where
userspace wouldn't necessarily have done any touching/init of the page
in advance.

BUT.... in that case it would be okay, because the kernel knows
everything would get zero'd.

So maybe the post-populate callbacks need to be the ones that would need
to implement these checks, or some API to that gmem can do it on their
behalf...

So maybe your proposed patch is the more straightforward fix for now.

-Mike

> 
> The patch below seems okay too though.
> 
> Thanks,
> 
> Mike
> 
> > >
> > > Because __kvm_gmem_populate() bypasses the normal kvm_gmem_get_pfn() zeroing
> > > path (where clear_highpage() is called for !folio_test_uptodate()), the
> > > allocated page contains uninitialized host memory.
> > >
> > > Since src_page is set to the same physical page here, will the TDX module
> > > read this uninitialized host memory using the host KeyID and encrypt it into
> > > the guest's private memory space during the TDH.MEM.PAGE.ADD SEAMCALL?
> > >
> > > Could a malicious unprivileged VMM exploit this regression by passing a NULL
> > > source_addr on an unmapped guest_memfd region, causing arbitrary host kernel
> > > memory to be disclosed to the TDX guest?
> > >
> > 
> > This is true. How's this fix:
> > 
> > Author: Ackerley Tng <ackerleytng@google.com>
> > Date:   Wed Jun 3 13:24:56 2026 -0700
> > 
> >     KVM: guest_memfd: Zero page while getting pfn
> > 
> >     Move the folio initialization logic from kvm_gmem_get_pfn() into
> >     __kvm_gmem_get_pfn() to also zero pages if the page is to be used in
> >     kvm_gmem_populate().
> > 
> >     With in-place conversion, the existing data in a guest_memfd page can be
> >     populated into guest memory through platform-specific ioctls.
> > 
> >     Without first zeroing the page obtained using __kvm_gmem_get_pfn(), it
> >     might contain uninitialized host memory, which would leak to the guest if
> >     the populate completes.
> 
> If the sr
> 
> > 
> >     guest_memfd pages are zeroed at most once in the page's entire lifetime
> >     with guest_memfd, and that is tracked using the uptodate flag.
> > 
> >     Zeroing the page in __kvm_gmem_get_pfn() is chosen over zeroing in
> >     kvm_gmem_get_folio() since other flows, such as a future write() syscall,
> >     can get a page, write to the page and then set page uptodate without
> >     zeroing.
> > 
> >     This aligns with the concept of zeroing before first use - the other place
> >     where zeroing happens is in kvm_gmem_fault_user_mapping().
> > 
> >     Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 2a719faebed8a..7b1f2f0288640 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -1140,6 +1140,11 @@ static struct folio *__kvm_gmem_get_pfn(struct
> > file *file,
> >                 return ERR_PTR(-EHWPOISON);
> >         }
> > 
> > +       if (!folio_test_uptodate(folio)) {
> > +               clear_highpage(folio_page(folio, 0));
> > +               folio_mark_uptodate(folio);
> > +       }
> > +
> >         *pfn = folio_file_pfn(folio, index);
> >         if (max_order)
> >                 *max_order = 0;
> > @@ -1169,11 +1174,6 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct
> > kvm_memory_slot *slot,
> >                 goto out;
> >         }
> > 
> > -       if (!folio_test_uptodate(folio)) {
> > -               clear_highpage(folio_page(folio, 0));
> > -               folio_mark_uptodate(folio);
> > -       }
> > -
> >         if (kvm_gmem_is_private_mem(inode, index))
> >                 r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> > 
> > >>
> > >>  	kvm_tdx->page_add_src = src_page;
> > >>  	ret = kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);
> > >
> > > --
> > > Sashiko AI review · https://sashiko.dev/#/patchset/20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com?part=21
> > 
