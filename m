Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3AF1A239A
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052285; cv=fail; b=Xpld28Hvru2WTXtZetiWzQKXhtAcZ9vuiojuIIJ8SkEU7sf7kOtziOX4YXXbstMPFjQk8YXp1ShrIXN9QWi8c87XIbMWpVD8ETUG2YamUYHvFz5IoWHjtPiH70pP2UagnxRlzho8xNaMUoE2nniJzovO3UtyQHrLym5Jo3H+Jxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052285; c=relaxed/simple;
	bh=M1FJu6YWYkukKmsJU1apPFjG39N/OEVkNXXz8/34FAQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3UjoVIGeOgDj67qoTqWCIeN2igksH+ddjxJimlN2kbi2rnwpqUMmj+9YvAt+YrfK38cgLCqoTDV1PP5PxA2+WO3to8k70Wm03nmq8Pz3ffdFZCv4o9c9j/fYigwbR8Fg5yNlRt3CcyXvklHdm0iq7BDb7pMPVIeLfxREtojh+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BwUzS7Ru; arc=fail smtp.client-ip=40.93.194.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BwUzS7Ru"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYJIqw8U2p0dEyO8KNytQWdiWM7x3ZsWtUFPfcwfvTxHLHH8C4C33VjSx8cryrAq48wDRTKD/02/qbTCZqD1Qh0di5qG1JdP9aAOwI+xf2zJtZWsS6isVGloE1HKw1EDIdPOvy1bi4AlILVYw6A4NiAsf1pq6E3b9cpgoUl3Y52KGdZk5v/h4BWliH+9g0pseVpVTJEDWQ3xfwlhhDmDirYpsjnl/Sz5RqrTMrqFm2df7NCyC2Ow7P2M8JgJ4Z7aJrAGerx4Bkuw0ZmvhGg8c4xzyG03YyTdt9p2jNjsvhduvlS/ZbTK4sioOoZ8vrMesemWCVm/PBRnGenvOvoTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gDtHQ4NCm0aHvP0tfhfY9MtuH6T8fLcvrfx0aZfIW0=;
 b=shQ22J7CU7r1VOJoR0d0S9GnGvf5KvAqZvE7xwMWjrbbesRDOQ1LfHYxSPjHdJZgfoPoK4SMIiJG8Cr1WHuRPpk20CV3v5XbfZGRmb/TzQrjkFvxPXhzOgOhImwOSKy6HkTh0VsT6H6V5RNy2UhmtO5iTfKMLj6BhGIFXLpBXukYK0NYrUJDl0ftwbG6Rp8+PpsbL2wuaXvNPl0ts0mpPCKuuD8S4QkmFWyRc33kW14n9fXjllEuJ/tIVHQmfk5CJdKFEq55TfwGGTpK6W0nUgyr9xPQEqEtrjzff6THONr4qQMHxa2DwQzcynt3lv9IyTwr8EllMgnAHI/p3+AmtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gDtHQ4NCm0aHvP0tfhfY9MtuH6T8fLcvrfx0aZfIW0=;
 b=BwUzS7RuydQT2gBB6x3LpSsjfy3jmTDTyhLpSHLXPZbD5ZfZGT+tsNsn/2Y300nda5igUzQ5BVPGe6YzMF7J/INKsjAaYdK5q6UBaIAqghNBVkBh6K+47jm4cD6n+MjVfmeY6aJnO1AKNMa3GmQVH8Yk0/lFRomH/G5SFZf+YUM=
Received: from DSSP221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::6) by
 LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 00:44:37 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:8:3d5:cafe::5d) by DSSP221CA0010.outlook.office365.com
 (2603:10b6:8:3d5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 00:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Wed, 10 Jun 2026 00:44:36 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 19:44:36 -0500
Date: Tue, 9 Jun 2026 19:44:20 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Ackerley Tng <ackerleytng@google.com>, <sashiko-reviews@lists.linux.dev>,
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH v7 21/42] KVM: TDX: Make source page optional for
 KVM_TDX_INIT_MEM_REGION
Message-ID: <bqbshpf6lvy233kawlar7zhw2kprxwqbj37btos3dplg3nigpk@fwap6msdbsqm>
References: <20260522-gmem-inplace-conversion-v7-21-2f0fae496530@google.com>
 <20260523010752.CA7AF1F000E9@smtp.kernel.org>
 <CAEvNRgEVC=fFuKVgZYvWyZD7t_zvUZihFG8hrACjvtkD5cwugw@mail.gmail.com>
 <vawib73p6wsjdihwz636soxorvp74v6zyqona2a2nnpuc673lt@jvlhihgqrs6t>
 <44o2z5j553adpapnyequmk2t6cukor2wjm5urujhrnqhufogh7@jbsolz5b4i2b>
 <CAEvNRgFkfqirL6hZDk5eugeaf4u7J_=a0xj6RdE=QnG5T6N29A@mail.gmail.com>
 <aiirsJFic_naddv7@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aiirsJFic_naddv7@google.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bf97de-c200-4013-de51-08dec6897288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	g0IFxri1cEwnB3K1pKHSx8zbNjKaDTmg/bpYRf3wxs8OkRGYUNlEt1+VcOTY9W9BQP10Ma04AdTLrx2c+Q5+x++1vJg6GW6kLhiaI+MO1D7JtM72Ctf/7R4Sx37w2XMix54g198crmZ75Xi4LGcOA8JNiE38qDOADz1dO+A/cGGdTUh+fv4qodRc0J7b5lNf1iNR6uhxBlWnLvkFpgILYcNbqKWkXYv4QRuUKvYrtOVCdN5xxmlltCiIlu5a6LlHUHWji38GR0SfIlAZK3xFdayr/heXMp4z25jkEdLmFxvGET7me6I7n2u+7nHRgm+dbUDqUqtdcyvLgEPS9UBEJwsU1DkxERRU/b5434zNHlD9s9VY3rAvDBqAt0qiVjdFWze7HGfRaMX3ZE2uUjt/UjPx1Fxoy8FsiGSnWj4WSbJJOlkQAjGBRW0urLN43I71pEbV8XQ5rVgSjgn2g17aQ6bL52xZkopuoIce3uSNKR3NvvATCWFILDbrYruGQkVPZR+QtZEWF2XvxeL4XKS2EbGpq0sbTxl+sWbjO38Ggg0mO0EuZSG+z7b8yLNLLnQsyo7pmkkHie+KmBgfmCffGeadDI20IhJfP2uaDutiDARpGud7GDdfpa9RrY5hssH+2OWKendEnbUEta2rRki3VFu6rr2sDVE2KYi5JdNmW3+ZOkIVBbvNGfQjVc7OUMiyJe0/ZKudaFB507agz99YhAS3LEo1JIFQW2TeuA2Cixk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	prcWHyb/QBU8LTRF+oZeq8PalczmVek1caWMS4C5TBVi7/adE6+4AWBXeHpgdQw2YDOMdAeH+eZxKKcC7ifyZ4TEUk2s3P4kKnjpatQptpsGE8eo2dORoPI59gWdgWxImwKGApQ4CaqGUkVWz/UrRNlKqOSwVnMmepCsYiSFM4pmMzofS5ey4SnpbkhljWoxuaXSHTDCn0SW/ZAeXI2Sj43/26nDaa8Ev97gxTcjJ5isAC5hff1qSXQ91SKjBxAnZLKzT7Pugjp/f1pBr2fCZVLIn7Dhq2Y4DJ9QcZlgIxXqCUG9gOxm4PDz4gmACthEje6wwCyvK3ddeaJram7+51LheLlrea6i+aSjEWca9GlfzmLPgCNk6eKmcxoGck9EC/ebDPhCiPhRhoFsaETXa6XEhKJl0pzWekxcDYkuaGwGrotJ07n+w/mhi7bQ54pU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:44:36.7025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bf97de-c200-4013-de51-08dec6897288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081

On Tue, Jun 09, 2026 at 05:11:28PM -0700, Sean Christopherson wrote:
> On Fri, Jun 05, 2026, Ackerley Tng wrote:
> > Michael Roth <michael.roth@amd.com> writes:
> > 
> > >
> > > [...snip...]
> > >
> > >> > > When KVM_TDX_INIT_MEM_REGION is called with a NULL source_addr,
> > >> > > __kvm_gmem_populate() attempts an in-place conversion. If the target
> > >> > > guest_memfd folio is unpopulated, __kvm_gmem_get_pfn() allocates a new folio
> > >> > > using GFP_HIGHUSER, which lacks __GFP_ZERO.
> > >>
> > >> For in-place conversion, if src is NULL, it's generally because src *is*
> > >> the target and it makes no sense to copy the page to itself because
> > >> userspace already initialized it, which means userspace should have already
> > >> trigged the uptodate flag to be set via kvm_gmem_fault_user_mapping().
> > >>
> > >> So maybe to address the malicious case that Sashiko seems to be worried
> > >> about (where VMM purposely doesn't touch/init the memory to try to leak data
> > >> into the guest), we just need to error out if: !src && !folio_uptodate(folio)?
> > >
> > > Of course immediately after posting this I think of exceptional cases, like
> > > SEV-SNP can set up pre-zero'd private guest pages via this path, where
> > > userspace wouldn't necessarily have done any touching/init of the page
> > > in advance.
> > >
> > 
> > Are you referring to KVM_SEV_SNP_PAGE_TYPE_ZERO?
> > 
> > > BUT.... in that case it would be okay, because the kernel knows
> > > everything would get zero'd.
> > >
> > > So maybe the post-populate callbacks need to be the ones that would need
> > > to implement these checks, or some API to that gmem can do it on their
> > > behalf...
> > >
> > > So maybe your proposed patch is the more straightforward fix for now.
> > >
> > 
> > Is KVM_SEV_SNP_PAGE_TYPE_ZERO expected to be used for a large number
> > pages? If not, I think we can defer this to a future optimization, like
> > in snp_launch_update(), if KVM_SEV_SNP_PAGE_TYPE_ZERO, pass a flag
> > through to __kvm_gmem_get_pfn() to skip zeroing?
> > 
> > For all other page types, __kvm_gmem_get_pfn() MUST zero to avoid the
> > issue Sashiko pointed out, right?
> 
> Or we do as Mike suggested, and outright reject the populate() call.  But I think
> for ABI purposes, zeroing memory is the right approach, otherwise we'll end up
> with a discrepancy between the userfault path and populate().
> 
> As I mentioned in the cover letter, initial guest image will typically be a tiny
> subset of guest memory, so I don't have any concerns with unnecessarily zeroing
> a few pages (memory that is ultimately overwritten by userspace).

Yah, and it's literally just a few pre-zeroed scratch pages we set up
for OVMF to use during early boot. I guess in the future there could be
larger pre-zeroed ranges for other reasons, but definitely seems like we
can optimize that later if need be.

-Mike

> 
> > Currently, kvm_gmem_fault_user_mapping() will zero, and then userspace
> > presumably writes the entire page. Can't avoid zeroing to avoid leaking
> > uninitialized memory.
> > 
> > To avoid that zeroing, I guess there's the future guest_memfd write()
> > syscall too, userspace can write() the entire page - write in the kernel
> > can avoid zeroing since it knows which parts of the page was written and
> > set uptodate. Then, kvm_gmem_fault_user_mapping() won't zero since the
> > page is uptodate, and populate will not zero since it was also uptodate.
> 
> 
