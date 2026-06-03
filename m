Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DAF45348A
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530441; cv=fail; b=pBi6twq/+8gsM9DJKrtv4g5d+P+1Qde/dzoSHRCXWGlOF0Mn3kRAcyNlifSCRcCTqblKEuZkdtuC7eOLRvjLjOwaMPt+trfE5gOJV4IOEaVmGIBstAL2Z36cIVAUoym/BDlgFIlZlsziMR6VZnLVd74SjoZ9HMENlLe9GDyTphM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530441; c=relaxed/simple;
	bh=MxB+jf/dJFD8M3ztXBpzSW4OSpEflwkXhNbgTPOPKS0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxSoLbBToehJ1rq7rR7sTi1aMpBNjH2wGck1d8JITcd4hc3ZCStxNX6v0xXcsN1bOmpSo9ewDulEdF+lmx28g7a7UfuFn1Lzx0nCZDyrQpvOkw/3mNbwzBv0XmHEJsjMNmecPs/90sHWPUe7DWaU8ynn4cvC0iRdN1IgZ248E7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rZd449f8 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rZd449f8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQrJ/iBcWS/ciA+f50hBHRJ2U/1U+anwEEEy5+gZ/fU/NNX69TxprmIUcKLDkxBHOjcbyxHvWpQoGaid1c1dlbC7cnXfEw4BJUC9bPghoD28vQ86xI7OYyr1EqA6atz1fR4/O/E5yINmPBMGaKOdJjycZN2JLC7DwQ3po/g82mGrbce0EVrQfqGrRqoexxwV0js3H78l0OWN0IilaftzONalZb+lC3FPF9F8pKqrHA9oeoILNADqeWLy2SqYruPKhpOpDL+pGuIWZdtWDLd291BUHKq9sgYJ1HePliiZUVAmq2KaQHhbIPX6jijtMSkwkTu2cjx863W9lk5rJNgvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTNJBpvhH7kLn/DLmmXUiRoTwJc8z6QkGdexJiVPbRQ=;
 b=WNg3F/Xg2sjerYSamCYyvT0BMUEBjEDOHwVudq5ucZljapYKP1b3MQPJ56FgKw1ve37C2pR7YtAB0VDgWs5bcC8F6wdzOIGPh63vISmOgPZCi4d4eh30HH7UR2PMNhIiWHz9n9BG/c8PMYiU60fUaZOo6567YAxzoaOIba9wzJsq6LiBAr4zo5AqBcp+Wk7pDzIvLlQc1K7fLh1sIKjbmpsyplFeZFYAIGvk+udSuNDmMeUY4dDN/C5VbXB16nFNP9Bjelf4kOu9KeN3M7MM1DIOE5wG1HNvRm/XS8JdnVyGzFz4KaYq10qcnL150MHTU7PPXR8e2j2W5IrSAwDWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTNJBpvhH7kLn/DLmmXUiRoTwJc8z6QkGdexJiVPbRQ=;
 b=rZd449f8tWGE7zwguQp8OY2JzlzSn2ak+HN0+Z7bL1vg/2EbFjYShowPglGdBRo/wTN6Ed5y8YZgjDtB8OOVjhpiXG1FRGNeqrdcJ/Dteoo2ftUcMzgaAw9qHoRKpkvJPQuck2+XAekuxBpdv++pVUvShHOxI9ZJvFqXgAOENxE=
Received: from PH2PEPF00003848.namprd17.prod.outlook.com (2603:10b6:518:1::65)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 23:47:15 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2a01:111:f403:f912::4) by PH2PEPF00003848.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 23:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 23:47:14 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 18:47:14 -0500
Date: Wed, 3 Jun 2026 18:45:37 -0500
From: Michael Roth <michael.roth@amd.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <sashiko-reviews@lists.linux.dev>, Ackerley Tng via B4 Relay
	<devnull+ackerleytng.google.com@kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v7 21/42] KVM: TDX: Make source page optional for
 KVM_TDX_INIT_MEM_REGION
Message-ID: <vawib73p6wsjdihwz636soxorvp74v6zyqona2a2nnpuc673lt@jvlhihgqrs6t>
References: <20260522-gmem-inplace-conversion-v7-21-2f0fae496530@google.com>
 <20260523010752.CA7AF1F000E9@smtp.kernel.org>
 <CAEvNRgEVC=fFuKVgZYvWyZD7t_zvUZihFG8hrACjvtkD5cwugw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEvNRgEVC=fFuKVgZYvWyZD7t_zvUZihFG8hrACjvtkD5cwugw@mail.gmail.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: e34fefd8-d01f-4451-46e5-08dec1ca709d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|13003099007|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HLzWiQO4xE5yKyjZmA+F0utYzgaBIxN4Wot1oP0N86OU6jGM67i/eemkyb78yKsA3njnPNCIcdq5+oteXgvOQkGARhmDwVan5XRWxk4j/EcIgZy20i8LY3A5hRyd/3gSW5h6aMqXvqt0oYW/d/d6rt7AD/oVRDGqwqlexUy6o/pyja5wg0K73asHAaWcDKv7tdQm3ZgFixC6EMrCWlr4HDzmycXUSMy6FygEXx6y69njo7ZRZSigjpe8cSt06CZRONb+Pe+WdeVh1hCuncAoWi/kCbI0bp1+45sKFSP8w5WEDiaKJxPgpYdD8wMPKuNUQ5+2d5KwbISrntMvOENKoz1PQ0+bItclfR3WSx1tN1JzHGEo1ZQQcU4Jkg+e8Y/ncLXerFXSjkh0e4jUPVve5pKCckHptJwnHspYOdl6oxKoH9NMdcQ9j9yuhxIxib6XgfNHOl+qxvElk6EHEUvj9uWVox51zVOUgGUGS7tTxhCzC9OMNbhxLw6sGVfYcZU5OCsRQse+i9GKpjnRxJatLW4K4vPg9LgZ9Tdds27o+373GJ5pW+XaTvHUCPdzawGx7APmzgPGowkYZtrHT65mIoHFN13v4zhZNt0lP4k/T0d6YPGGInp+Y9djTReO1brAmoOTV4gWoE8uyng752kCMGLutywinayGoGzH4B59x1c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(13003099007)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jXyyZ3yBqpwVGzqSKkLmL5z9B/1TkvnaDHHjYFgT8FSjygo9iVxMD1MI8oDUrknuBLCKnHncQCQFqILDqj5CZ3ssBwXcMvnRdDH/V41+akOEssag6PKznulIQMaQBgWHlypGcDQjZzzK0Dh7FVcYh2d+Vzp3DO97IDxKVXeOC7o24UW4LKPk3F+Ah4kaX0VK14gGuFYejPOCj28Uu3CKmIOcskt6hjLeIXqHvjz4d+X1cYQ13LFUqWvfk34YlEb3bOmJiXG88WicNzpQsUGgt9ywjpC8ucSwYaZkbBup6OiAiVfmPZdwcDa0Kfa0iaWYt1PQUd5qsvMywyMyFJEY/Fsg8lt4vMCuKv/HbFrBSPNGaaZRQ2INDkzL3xPckGefrdKUizy+QILSkEqNjYE2zxCWemneFdIQhedgqWwm0wnITrKGKjvpWj7aW0zPSJ2A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 23:47:14.9198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34fefd8-d01f-4451-46e5-08dec1ca709d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683

On Wed, Jun 03, 2026 at 02:22:15PM -0700, Ackerley Tng wrote:
> sashiko-bot@kernel.org writes:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Critical] Uninitialized host kernel memory is disclosed to TDX guests when performing in-place population.
> > --
> >
> > commit 38e76d2ce3c699d4b64b580ab16a7b4cbc2b189a
> > Author: Ackerley Tng <ackerleytng@google.com>
> >
> > KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
> >
> > Update tdx_gmem_post_populate() to handle cases where a source page is not
> > explicitly provided. Instead of returning -EOPNOTSUPP when src_page is NULL,
> > default to using the page associated with the destination PFN, allowing
> > in-place memory conversion.
> >
> >> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> >> --- a/arch/x86/kvm/vmx/tdx.c
> >> +++ b/arch/x86/kvm/vmx/tdx.c
> > [ ... ]
> >> @@ -3116,8 +3116,12 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> >>  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
> >>  		return -EIO;
> >>
> >> -	if (!src_page)
> >> -		return -EOPNOTSUPP;
> >> +	if (!src_page) {
> >> +		if (vm_memory_attributes)
> >> +			return -EOPNOTSUPP;
> >> +
> >> +		src_page = pfn_to_page(pfn);
> >> +	}
> >
> > [Severity: Critical]
> > Can this sequence lead to uninitialized host memory being exposed to the guest
> > if the guest_memfd folio has not yet been populated?
> >
> > When KVM_TDX_INIT_MEM_REGION is called with a NULL source_addr,
> > __kvm_gmem_populate() attempts an in-place conversion. If the target
> > guest_memfd folio is unpopulated, __kvm_gmem_get_pfn() allocates a new folio
> > using GFP_HIGHUSER, which lacks __GFP_ZERO.

For in-place conversion, if src is NULL, it's generally because src *is*
the target and it makes no sense to copy the page to itself because
userspace already initialized it, which means userspace should have already
trigged the uptodate flag to be set via kvm_gmem_fault_user_mapping().

So maybe to address the malicious case that Sashiko seems to be worried
about (where VMM purposely doesn't touch/init the memory to try to leak data
into the guest), we just need to error out if: !src && !folio_uptodate(folio)?

The patch below seems okay too though.

Thanks,

Mike

> >
> > Because __kvm_gmem_populate() bypasses the normal kvm_gmem_get_pfn() zeroing
> > path (where clear_highpage() is called for !folio_test_uptodate()), the
> > allocated page contains uninitialized host memory.
> >
> > Since src_page is set to the same physical page here, will the TDX module
> > read this uninitialized host memory using the host KeyID and encrypt it into
> > the guest's private memory space during the TDH.MEM.PAGE.ADD SEAMCALL?
> >
> > Could a malicious unprivileged VMM exploit this regression by passing a NULL
> > source_addr on an unmapped guest_memfd region, causing arbitrary host kernel
> > memory to be disclosed to the TDX guest?
> >
> 
> This is true. How's this fix:
> 
> Author: Ackerley Tng <ackerleytng@google.com>
> Date:   Wed Jun 3 13:24:56 2026 -0700
> 
>     KVM: guest_memfd: Zero page while getting pfn
> 
>     Move the folio initialization logic from kvm_gmem_get_pfn() into
>     __kvm_gmem_get_pfn() to also zero pages if the page is to be used in
>     kvm_gmem_populate().
> 
>     With in-place conversion, the existing data in a guest_memfd page can be
>     populated into guest memory through platform-specific ioctls.
> 
>     Without first zeroing the page obtained using __kvm_gmem_get_pfn(), it
>     might contain uninitialized host memory, which would leak to the guest if
>     the populate completes.

If the sr

> 
>     guest_memfd pages are zeroed at most once in the page's entire lifetime
>     with guest_memfd, and that is tracked using the uptodate flag.
> 
>     Zeroing the page in __kvm_gmem_get_pfn() is chosen over zeroing in
>     kvm_gmem_get_folio() since other flows, such as a future write() syscall,
>     can get a page, write to the page and then set page uptodate without
>     zeroing.
> 
>     This aligns with the concept of zeroing before first use - the other place
>     where zeroing happens is in kvm_gmem_fault_user_mapping().
> 
>     Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 2a719faebed8a..7b1f2f0288640 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1140,6 +1140,11 @@ static struct folio *__kvm_gmem_get_pfn(struct
> file *file,
>                 return ERR_PTR(-EHWPOISON);
>         }
> 
> +       if (!folio_test_uptodate(folio)) {
> +               clear_highpage(folio_page(folio, 0));
> +               folio_mark_uptodate(folio);
> +       }
> +
>         *pfn = folio_file_pfn(folio, index);
>         if (max_order)
>                 *max_order = 0;
> @@ -1169,11 +1174,6 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct
> kvm_memory_slot *slot,
>                 goto out;
>         }
> 
> -       if (!folio_test_uptodate(folio)) {
> -               clear_highpage(folio_page(folio, 0));
> -               folio_mark_uptodate(folio);
> -       }
> -
>         if (kvm_gmem_is_private_mem(inode, index))
>                 r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> 
> >>
> >>  	kvm_tdx->page_add_src = src_page;
> >>  	ret = kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);
> >
> > --
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com?part=21
> 
