Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEBD29BDBB
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554124; cv=fail; b=O9fO/8324Rl/lDZDh5vY+Wz0Ve08qAFJhDzKkbVK0EdFS7ycam5DvHRq4oQ2t9LenXXnQcIcFhM+P7cCoOfCBBQQSMjERKFS34oy8sUeVxyUdUT9mnj7FiTV1nz7XM+bnOSnri2xukocWhBO272zcLxMA84QBvvEXE10+c3jH/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554124; c=relaxed/simple;
	bh=WjfcZ8mUqPxmT1eadyTA9ePp/nm4qq3EkljCAWJHuMM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2Mvq8taUwPXGiyqzMqleEWP1OoyM/sY+JxedB6aIkMCC31cpRt+3IjI4xUD42FaJjfdnPWVmWStDD/0C51bC23diPS6mAHRO21TCySd++K91EOq2CfsW2eVCXiOkj3ytWyB3kOyXBv80hVOmnD7bMvpriJsl2cRU+GG2xUnCgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xAtIbhiz; arc=fail smtp.client-ip=52.101.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xAtIbhiz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0JYk8rbVbkirQfKrwcCL0I/GHrJfPv5FAKAA2LjgwZefhvHSjdpUC49570mKyzYgmI9U6g4SP0BkcQTvlB2gpBAOkagU9a8KY7pXQRuFh8vxnguhpySuUThD/WUn/pTQni8WeESJlTOIYiVpWnT2dh0456RKUW8x+bovZs/c1HTeflSsW7dbQEdfUG+zX/zK1799qHbij9gyf4tTYJHyU7liqPw2gUu0MNpZR396a7kTfkyU2rWezlhFpTBlKRM9C88IFg7PDicQ5x5CnJ/T6DNzKtvR0l1Ewh3zm3BqTiZh5X2kVkqHfaOWH9NKI6t5aWYRHSl5Q0t54nIZHKxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ+ORChzsSN9D0AZMA3X1vCoUNGax1MOH2pCseLOSWg=;
 b=hhF1/hp7FpLyyHVfALlI4R+4EtdrMV01ogf6XmLhgT7q6IONhR4XfLriRmh2dVk3NvGZldWwzkKVG8YNYpGf4uRdGGz4ib8CCw/Kez51enJgbTJoR7YpIn6leLSHKJIOEyjT/DsJNrRyJ5mqLM+XAveE2ik1jfnJXBRR1YCGiuVcVQSnfdPlBVFSm3tB4943EjQzNNEknssaPnolPf1AzEfGjSUhyDC9m+JE2CxilqEfKortfwpEaqYVWCOKXsZ5+xzKaoJhZEesbcEIhQTUdC2gbrtPk3fjTNzPOBJOD4Fj1gcAS/cNz5NhJGM2XQykPKS3v6tV12lhiAB5Dhk30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ+ORChzsSN9D0AZMA3X1vCoUNGax1MOH2pCseLOSWg=;
 b=xAtIbhizBAQQviTgrzdjbe6BYLP+kCKLrKETEiC1fGbM0oZOW6gM9DSYVYcGB7DG07f27pYbqnhmbZlNvYahRt3/13vD2pNVhMv9wVSxVijm44GvJHHzeumq0JJDESssp9gSU3VfDHc+I8uJnjVZ0CEpXYqMILDFRoFOoj9mH7g=
Received: from BN0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:e6::34)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 20:08:39 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::59) by BN0PR03CA0029.outlook.office365.com
 (2603:10b6:408:e6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 20:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 20:08:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 15:08:33 -0500
Received: from localhost (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 13:08:21 -0700
Date: Mon, 15 Jun 2026 15:07:18 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Hyunwoo Kim <imv4bel@gmail.com>, <pbonzini@redhat.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<thomas.lendacky@amd.com>
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the
 host
Message-ID: <df2pel4lsgwt2l3q2h6zy4th4hbibx5v2pfottzmcipzmxm32r@oxyv5x6ixqko>
References: <aimMWzAf5b3luM0b@v4bel>
 <wxamg6zqn2qmsci2fwfepbqou5vtgydqmonr67mu7b73nkakbe@zedss5vzeci3>
 <aiqNPBQzoU9f8RwI@v4bel>
 <aiqueNUndQsbMNud@google.com>
 <airAthcKDZeDfzXS@v4bel>
 <airS1G23atiuWdTl@google.com>
 <sbub77galgn2zcecmeiznzi7nvgykby5lyqbebimfpd3wmsxgc@gxfth3taum3p>
 <aitOWNQk8KfUdp5x@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aitOWNQk8KfUdp5x@google.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd3e7d9-3567-4d6c-430e-08decb19e3c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|23010399003|36860700016|18002099003|22082099003|3023799007|11063799006|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wWaztdG2f79JVfRe616rSKUndz1N4vfNNebxdjLz3C+lKMRsJzZBR5uuJNU+VwQxhLPRpZDgKMrDCBrwYybBUff5x3cemoH4XlOd6EK383mGpueKZaT+PsjTUkMarpTmyAkOgK8annVnFtJMrggWXTO2WJp/6nnpguEXV234ByF6Z3TSbXyyrJuFFsDI/7/k3Hu6ntRpN/UjswggxlhvcoB0jlqX+7gf3inJAGl0yc4YQRi2FBalRtSA0pTDSAhkezRjjQHV2RN1LEQyFCWrUMu4EPTjkjI39FM4/hIuIVS0WSlpNBiwEA8xRJ7KpiipneKzg4uwzVhOFB4NllcmPFwfSRiREaVq/uqK23Fn+DR/gf6zbbch2IspsxX5FHu0IHcXyYGVZ8NJy2ZWO85KfbP43T9qqyh+ZmZ8COhZzbd56+zw5UAVhsUImtJk/hSKUpnqYAvi2273sPOdH5KYSB3NLKIJdl8G2z5dOIgfDZ9wGlUhX/ZHwsBShU0In5O+OexJxW2mHqVZr5w+ZY6lbMYD6bNiE5n7UMq3i/fHNvHu3e3goNhQfKzHMMb8eokuoxPsgpcVZcMEpicOzsQo6MGe16u99swTyyQsnb3tZGi6RozUDqQk8wAgvfvzUE73Zg7JAP3xh6hETPtOiFPX6VWsDViHy9tXYWuJMPYZl0H1gK/bLMqCyYeU6B1qKEbflVVbu7uLEBIoZMCw0u/+A+N4H2+WckCi5lyPpzi2Wa4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(23010399003)(36860700016)(18002099003)(22082099003)(3023799007)(11063799006)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vr8hq5ACGhzFUn4qJTO2b21wls2MdJ6jWgyXYA535XXJwLRd0x5zfqZbnEK2WLcoaplhlxtRPN2TyiBUH+BsCfW+f/rd1RRf0DevV3tSpGDwV6d79x4exVNmLaFkudPtcVmWly3bptuK2kuc61808bPEbvQm53cNbK9VDB2u6darV63P4sQt9s8iN6k4/7ZqgxImTeUOrFi0z2RMCRsxgWtH0kORSdLgbpzXa3B4shDBtoSlUJvbpB064hCz2kLiruu1ACvqQxLQvc6hspGXm8ZZPGf+nma/RLwL3+Q+ntwICzXUIJaZSBRhh8gOeO0PwHgZnHH4ZF9H5HwgyHnFYzdMVwqHmm0RDABbl/n+aZp9d48T1TKKFV+fnlC9OaUoyp+a6ej7TZubZzQaHGP2Jidv3mskZERaGBHmUfjFNbZdC1X6VH0wDTwja+RYeVAg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 20:08:38.8566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd3e7d9-3567-4d6c-430e-08decb19e3c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409

On Thu, Jun 11, 2026 at 05:10:00PM -0700, Sean Christopherson wrote:
> On Thu, Jun 11, 2026, Michael Roth wrote:
> > On Thu, Jun 11, 2026 at 08:23:00AM -0700, Sean Christopherson wrote:
> > > On Thu, Jun 11, 2026, Hyunwoo Kim wrote:
> > > > and if that gfn is then hole-punched, a page that is still assigned to the
> > > > guest is returned to the host in sev_gmem_invalidate(), which looked like it
> > > > could lead to a host RMP PF, so I sent the patch.
> > > 
> > > Yeah, I suspect you're right.  But leaking the page doesn't fix the underlying
> > > problem, which is that it's possible to free a page that's being used as a VMSA.
> > > 
> > > We can't simply pin the page, because IIUC ->free_folio() is called when the page
> > > is removed from the filemap, not when the folio/page is free back to the allocator.
> > 
> > If free_folio() triggers, it would call into the
> > kvm_gmem_invalidate()/rmp_make_shared() path and clear VMSA bit, which I
> > think would cause a subsequent vcpu_run() to error cleanly. So that part
> > maybe isn't the issue, so much as the stale VMSA reference we have once
> > the hole-punched finished at folio actually gets freed to allocator..
> 
> What if the vCPU that's associated with the VMSA is actively running?  I assume
> trying to reclaim a VMSA page will fail with FAIL_INUSE or FAIL_PERMISSION;
> that's the scenario I'm worried about.

Hmm, I think that is indeed the case according to APM:

  After a successful VMRUN, the VMCB page, as well as any AVIC Backing Page and VMSA Page are
  marked as in-use by hardware, and any atempt to modify the RMP entries for these pages via
  instructions like RMPUPDATE will result in a FAIL_INUSE response. The in-use marking is
  automatically cleared by hardware after a #VMEXIT event.

we could potentially spin on FAIL_USE in RMPUPDATE with the
understanding that the vCPU would need to exit at some point (and other
cases of FAIL_INUSE should be transient as well). According to the APM
it is actually possible to see a FAIL_INUSE on a fully-functioning
system, but in practice only FAIL_OVERLAP gets used for the transient
cases.

It seems justifiable to have the RMPUPDATE spin on FAIL_INUSE in the
same way as FAIL_OVERLAP though: here we have a case where we can see a
FAIL_INUSE (due to hole-punching/invalidating an in-use VMSA page), but
eventually the vCPU would need to stop running if the system is functioning
properly, so it seems transient in that sense.

It may be an oversight to not already handle FAIL_INUSE in that way since
firmware could at some point decide to start using the FAIL_INUSE error code
for other transient cases.

Would we be missing anything at that point? Kicking all the vCPUs would
be a nice assurance against looping forever, but I can't think of a situation
where we have a vCPU scheduled forever that doesn't cause all sorts of other
lockups and system stability issues anyway.

If that seems reasonable I can get a one-liner-ish patch together for
rmpupdate() the above and tag it for stable after a bit more testing.

> 
> > But KVM would never be accessing it directly while it's allocated for a
> > vCPU (it would be garbage on the host-side anyway), and I think the CPU
> > should only be able to write to it as part of VMRUN/exit, but those
> > should immediately fail since it's not a VMSA page any more at that
> > point.
> > 
> > It's sort of a precarious state, but I think we might hold up okay
> > there.. so I'm not sure we actually need the changes below, unless I'm
> > missing something.
> > 
> > ..but on the VM cleanup side, we'd end up doing a double-free in that
> > case, so we would need still need the elevated reference to handle that.
> 
> I don't think so?  KVM doesn't free vmcb->control.vmsa_pa when tearing down the
> vCPU, KVM only explicitly frees svm->sev_es.vmsa.

Not sure what I was getting at there TBH... I think I meant if, in addition
to addressing the FAIL_INUSE handling as above (or as your 2-phase
invalidate/free code does), we also hang on to the extra reference to keep
VMSA pages pinned (so KVM doesn't somehow try to access it after they
get holepunched), that could potentially double-free when dropping the
folio ref during shutdown (after it was holepunched)...

...but it would never have been freed in the first place, only truncated with
the filemap refs dropped, so maybe the elevated refs would work okay
after all...

...but I don't think KVM has any business writing to VMSA at that point,
and reading it at any point would only lead to garbage, so maybe we're
okay with just fixing up the FAIL_INUSE handling in rmpupdate() for now? I'm
hesitant to start added extra refs in the code while we're trying to land
in-place conversion since the ref-counting logic is more sensitive in
that case and would maybe bring other considerations into play.

Thanks,

Mike
