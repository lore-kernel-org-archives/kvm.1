Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A1394470;
	Tue, 23 Jun 2026 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782256963; cv=fail; b=a/B4ICMQ9ijE3ScPXB7/zWLnH+07Io97QTX9dE55xn3ZkeUsYtR1zjwy/jfimSqhVOjYMgfKL8+/JuC6fTKJDLGoROh81nScaePO2WxBMiOmfRrB/87WJJEzUjhd1W8z7bajjvrqji8/p5sKBpxP1f3GL3MQiusP2FoSEXuF/DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782256963; c=relaxed/simple;
	bh=xQHJD74L2gMuDGvn3WkBxZ10+gUI7uhTzFhaFhfzO2I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgvYIIVozVceMTz6TX7ZTxmKr3/juUbk5a5pKmUyzM4J7mfWZED1OAJGhX8W/NUFhoLOfsSS5SPQqrtoSSuQlTRTbADmQd2h9CH2Ja2o6jMQme8ccMH5cm+OcFOzTN8JLOwjHnIp+2u/RM+FRR/Z8eBWhdphKODSJitxowc+/dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pIZsxznN; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pIZsxznN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAwasEfM5sjzexwz21jPM2OP9ZW5cyKZmSGpohe3NtLeVoetflyLTTl3XKT1uPzouccp4JZChD2kBCsLAokS6EPrfCLBsx206d5VAw4rDUlA49phImJQalLRHeN3fx8bzucgOkChngiLVwdrlgCX+T3GTIS5F/yHeurg2Q64NqbW+MOd/9Ey0YsIKgc+P4bQX428nF9p7xrg1lFB3z9mrNlcMBR+Zex5iJNw6UDA6xvuSmcdd1fN9mkwviA/mHdcENC771WetYQXBFa4IICy7YUklHiePKCwsmIk2AVZAgZvpVEC4BGJtaIxs6Yzr/uxyBKSLADvx1Z/loonyC1pbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68kTSJd6mv7p9bYktadgLNuVcXsueRwR4nDXOPmgvC4=;
 b=xEsDbd+GUcrzMHNwgGbydLLoOBxvkcZD1DKcZkbI5IUFTxJVC35O7yjBjnKaEiFLPe/A4CMlY60s5o1Z6cLSm87fx1RItau0UGDdP+mxETLtjFnBPtCZsRROdEtIM98qqpHRqcTWaG+ZBatMJQk/UnMmawUwasMeHNjnSKVEcjBeEUn7jTOHy5yCozC39S4QitO721hrHDxBq97ES2ODDiqw8JsqFx9EMdWdG4NPdhg/DATequ+cmn46qfSBshH6H1Jbl3BgzNYheVJFKukWNX9tMzqtMutJ1BxaOq0yIftBEYpz4zwgNJ20iBdOOreVctYZX6rlmTcvxPOo8FNgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68kTSJd6mv7p9bYktadgLNuVcXsueRwR4nDXOPmgvC4=;
 b=pIZsxznNF5saY3x5yWUOhf3Oz5Rd6zOoETOfwFaYsJ2Fasg0+pzR/ZX7uPUVvITxzrzslBh2XqSWtOZwxkGgZNiq2SdG30XWSh6rp3J/IR8bzygjRz1Bim/Tq/TVoZdEPPGN1C6SaRTIyIkeicJHGU+ebMmxxj0VwnZzBXWE6zU=
Received: from DM6PR02CA0115.namprd02.prod.outlook.com (2603:10b6:5:1b4::17)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 23:22:36 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::9b) by DM6PR02CA0115.outlook.office365.com
 (2603:10b6:5:1b4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 23:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 23:22:35 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 18:22:35 -0500
Date: Tue, 23 Jun 2026 18:22:17 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV
 {en,de}crypt debug ioctls
Message-ID: <6xyh7xa53k2s7bytlkcys4pyq4756rwoly5q7swrifv3td6dey@3h5e2e67lkvj>
References: <20260501203537.2120074-1-seanjc@google.com>
 <20260501203537.2120074-3-seanjc@google.com>
 <ajNQ_Ix5e0p6FuFT@google.com>
 <tx3hcnrhfbcz2p7e7umc5o2zrw74pluzuzgtlqt4dz5cc5nhxx@6tzzorc25nqw>
 <s7jfbw3tnfgmp6blfqlfoi7yhq6f5n6xl62zzty5up45cqtsty@ljpjlvqw2gyy>
 <ajrkryMxHZtsMvga@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajrkryMxHZtsMvga@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a0ea79-85b2-429b-0e70-08ded17e4f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|56012099006|18002099003|22082099003|4143699003|3023799007|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	Eshl3Bt07cyT4uS+farUzjeboIVPEOMgnKN0Y0TPRIHVamKZYQFHf2NOKL4QekqC1I4Uf0HNgz7itbAJDJoXj54Oyso8Ud2Uj13J73SG5QyN0n5zTdxxtE5Kd9Gywyd9vQJCoSzMXbJw2IbYHKE6Qg4XZz9DlhxAq8YxpCXeaWKOjxfTg4YsLnKsL2fRMfUMlCEJHpI9zrwRb4widQF+H0+ASFUyp9DCXr5squwRZvLvcdkzAfgpQkvYYjI8wFke702c9YNfBiqD8VDRT6e0GePw7Teetq0EZ7AxEOBSM71hljdUDP2I0H14l0go8C2Ou/xmKLtq5FE1oYSlkvsA3M/E5hGmVrsUGf/6a5m1aI+ZktRqkfVcgdiSWIfWcezBYNWurACjZbxgevrwkn5pmuERqpEjI1y5el9M5F4jtc7ZLxVkYv0YQe1o/VjJOoEjojc9AvFn47Trp8HMS6goSo/6gt4k9smQYxCKPiFv2RgXBejWCk3KcdH6zqA8OpZdtO+2XaRYALEWcNsstXY9JzZRvBnQaaLm2hK0p3A7rM5WRTTp+nWr9MhqNUfKmuUYTMV/IyCibs67ECk4alvX6Yh55XwizR/XMa6CVEkcLUHsVoKTpzDe7Y5aRfmV4KltVq7IBwTO93JsJHe3cHxAPUzGvRonizaMfrfd9X+Uvej1I6fGAscWKFiat1TCNQ893m6LaxPreIOVGfHVe5tYUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(56012099006)(18002099003)(22082099003)(4143699003)(3023799007)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ev79k44qnmXZiPwa3HOA8BTT1h3jMf4z1pFg3BqXzOCxxtGmwVJEKZRTLkE4nQoN3UOPmHrr8jVgqWNTmT43meBE7XtFgKGdJwhIpIZrICb/O12dKTboJvoCp9HH3sFvdLfK6M84rpq4oYqUw4wGYW+bf4npseph0EvvI6VA5Tqumpp51BvVtusYuy/ykp2XDTjsnZr632ovZXsvCWk4Lq1VIVHc555NQOL42vP0FgMJ1y80EidFajtLKw+8hkIOUSo8iq4kPYDiRs8R9ekjF9rSN9Xi1VkE+ytlMv7R+Q5fJw4g66+uMoRtWwYbnYxyJQYxiNn8pQdtSOm9/M4baz+3fXwbbSyYDw02HYyoIBI+QYndKZTEiOeVrtoUhuflQNx8CLuIOaxxO+f8c4GAKrD7QcGUGLLHS28AbUua+TR4TF5mR96NP1FvuuopE0QU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 23:22:35.8581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a0ea79-85b2-429b-0e70-08ded17e4f49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561

On Tue, Jun 23, 2026 at 07:55:27PM +0000, Sean Christopherson wrote:
> +lists
> 
> On Tue, Jun 23, 2026, Michael Roth wrote:
> > On Thu, Jun 18, 2026 at 10:18:03AM -0500, Michael Roth wrote:
> > > On Wed, Jun 17, 2026 at 06:59:24PM -0700, Sean Christopherson wrote:
> > > > off-list in case this is double-ungood.
> > > > 
> > > > I ran this on an SNP host today (I think this is the first time I've run the full
> > > > test on an SNP host), and it explodes with RMP violation #PFs in weird ways.  I
> > > > don't _think_ it's a KVM bug?  Because I get the RMP violations even without ever
> > > > running an SNP guest.  I'm using kvm/next, at commit ef057cbf825e ("KVM: x86/mmu:
> > > > Ensure hugepage is in by slot before checking max mapping level")
> > > > 
> > > > It might be related to edge cases around pages, or maybe large sizes, as the test
> > > > passes if I comment out the testcases that focus on the larger sizes.  I haven't
> > > > narrowed it down further than this (reboots aren't exactly fast).
> > > > 
> > > > What's especially odd is that on most of the crashes, there's no apparent reason
> > > > for the RMP violation, as the RMP says the page is unassigned.  I did get one
> > > > crash (#2 below) where the RMP entry was non-zero.  That one was after booting
> > > > an SNP VM, but it was quite some time after shutting down that VM.  The RMP dump
> > > > is equally confusing to me, because AFAICT the RMP entry is corrupted.
> > > > 
> > > > Mike/Tom, can you try and repro and debug?  I don't have the bandwidth to dig
> > > > deep on this, and even if I did, I suspect it's beyond my abilities to debug.
> > > 
> > > Hi Sean,
> > > 
> > > I was able to reproduce this after running the test in a loop for a few
> > > minutes after a clean boot (trace below).
> > > 
> > > Not making much sense to be ATM either, but might be related to RMP table
> > > memory itself. Will keep investigating.
> > 
> > It looks like this was a recent regression caused by changes to how the
> > temp buffers are allocated. I tested the below revert patch ~14 hours
> > and the issue seems to be fixed (I generally was reproducing it within
> > an couple hours or so max so it seems good).
> 
> Thanks for root causing!
>  
> > Planning to submit upstream today if there's no objections/concerns.
> 
> I object :-)

Drat :)

> 
> > From: Michael Roth <michael.roth@amd.com>
> > Date: Mon, 22 Jun 2026 22:47:03 -0500
> > Subject: [PATCH] Revert "KVM: SEV: Allocate only as many bytes as needed for
> >  temp crypt buffers"
> > 
> > When SNP is enabled, the data passed to firmware must be contained
> > within pages that have been transferred to firmware ownership via the
> > corresponding RMP table updates. 
> 
> IIUC, and I'm pretty sure I do at this point, this is wrong, or at least *very*
> misleading.  Nothing in KVM performs RMP table updates, and so saying "the data
> passed to firmware must be contained within pages that have been transferred to
> firmware ownership" is completely inaccurate.

The driver will place it into the 'firmware' state ("5.3 Page States" in
SEV-SNP Firmware ABI) prior to issuing the command to firmware, so from
a kernel perspective I don't think it is inaccurate. It's true that this
is handled transparently to KVM, but I don't think the wording is really
in conflict with that.

Just trying to clarify and understand if I'm missing something more subtle
here, since your proposed fix seems nicer and more complete anyway.

> 
> Piecing together the changelog and diff, and my own observations, my understanding
> is that **firmware** modifies the RMP to *temporarily* take ownership of the page

rmp_mark_pages_firmware() in drivers/crypto/ccp/sev-dev.c does the RMP
table update as part of preparing the command buffers prior to issuing
the firmware call, placing the page in the 'firmware' state, and once
the command completes, firmware modifies the RMP table state to be in
the 'reclaim' state. The page will still be 'private' at that point, in
the sense it will have the 'assigned' bit set.

The hypervisor can then take it back via additional firmware call
SEV_CMD_SNP_PAGE_RECLAIM and subsequent RMPUPDATE to normal/'hypervisor'
page. So the transition out of 'firmware' does sort of happen
automatically, but the overall reclaim process requires explicit work by
the hypervisor.

> while performing the {DE,EN}CRYPT operation.  So there's no requirement that the
> pages be in any specific state, the only "requirement" is that software needs to
> either prevent concurrent accesses or be prepared to handle spurious RMP #PFs due
> to the temporarily RMP modifications.
> 
> SNP_DBG_DECRYPT does require software to convert the destination to be a firmware
> page: "The firmware also checks that the destination page is a Firmware page."
> But this is about SEV_DBG_{DE,EN}CRYPT, not SNP_DBG_ENCRYPT.

The above behavior isn't really specific to DECRYPT/ENCRYPT, but one
example of a general requirement that when issuing legacy SEV commands
on an SNP-enabled host, the memory that firmware writes to must undergo
the above transitions before/after the actual firmware call:

  5.3.9 SEV Legacy Commands
  The behavior of the SEV-legacy commands is altered when the SNP firmware is in the INIT state.
  In this case, the SEV-legacy commands require any page that the SEV-legacy command writes to
  be a Firmware or Default page.

('Default' state is for ranges that have no corresponding RMP table entries
at all, which isn't really applicable for how things are implemented in the
kernel currently. The reasoning there though is that those pages can't be
used for SNP guests, so legacy firmware commands can't be used as a widget
to try to mess with private guest memory).

SNP_DBG_DECRYPT calls it out explicitly since that's how it as always
worked, whereas for legacy commands these are additional, SNP-specific
operations that happen before/after the legacy commands, so they are
documented in a broader fashion.

> 
> > This is not compatible with uses kmalloc() allocations since kernel accesses
> 
> As is the statement about kmalloc().  kmalloc() of a PAGE_SIZE is a-ok, because
> the kernel will always hand out a full page.
> 
> > to other allocations within that page will trigger an RMP fault and crash the
> 
> And it's specificaly about other *accesses*, not simply other allocations.
> 
> > host. Fix this by moving back to page-based allocations.o
> 
> Always forcing full page allocations is overkill for SEV and SEV-ES, and robs us
> of the opportunity to document that SNP+ is special, which is especially important
> because AFAICT, none of the specs are so kind as to document this "minor" behavior.
> 
> Rather than fully revert, just force PAGE_SIZE allocations if the host supports SNP.
> I haven't run anywhere near 14 hours, but I was also getting failures on every
> single run of the test, and I ran the test 100 times without problem.
> 
> However, this only addresses the case where KVM is using temporary buffers.  For
> small, nicely aligned operations, a misbehaving userspace could induce a crash by
> coercing the kernel into accessing the to-be-{de,en}crypted page via a kernel
> mapping while the crypo op is in-progess.  I don't see a less awful option than
> forcing KVM to use the "slow" path, e.g. if the problem is limited to the dest
> for a decrypt operation:
> 
> diff --git arch/x86/kvm/svm/sev.c arch/x86/kvm/svm/sev.c
> index 87025d0d2f91..7e3334c90c57 100644
> --- arch/x86/kvm/svm/sev.c
> +++ arch/x86/kvm/svm/sev.c
> @@ -1406,7 +1406,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp,
>                 sev_clflush_pages(&src_p, 1);
>                 sev_clflush_pages(&dst_p, 1);
>  
> -               if (IS_ALIGNED(src, 16) && IS_ALIGNED(dst, 16) && IS_ALIGNED(len, 16))
> +               if (IS_ALIGNED(src, 16) && IS_ALIGNED(dst, 16) && IS_ALIGNED(len, 16) &&
> +                   (!cc_platform_has(CC_ATTR_HOST_SEV_SNP) || cmd != KVM_SEV_DBG_DECRYPT))
>                         ret = sev_issue_dbg_cmd(kvm,
>                                                 __sme_page_pa(src_p) + s_off,
>                                                 __sme_page_pa(dst_p) + d_off,
> 
> But if firmware temporarily converts *both* pages, then we're "stuck" because at
> some point KVM needs to actually target the correct guest-owned page.  The only
> option I can think of is to require capable(CAP_SYS_BOOT), *if* the above doesn't
> suffice.

Not sure I understand fully, but snp_populate_cmd_buf_desc_list() in the
firmware driver requires the transiton for the destination page that we
write to both for 'encrypt' as well as 'decrypt'. What the issue with
using a temp buffer as the destination for the 'encrypt' case?

> 
> So what exactly is the behavior here?  Because I can't find anything in the specs,
> I can only make educated guesses based on the SNP_DBG_DECRYPT documentation.

Hopefully the above references help somewhat, but I agree there's still
an uncomfortable amount of connecting the dots for this flow.

Thanks,

Mike

> 
> ---
> From: Sean Christopherson <seanjc@google.com>
> Date: Tue, 23 Jun 2026 12:21:56 -0700
> Subject: [PATCH] KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on
>  SNP-enabled hosts
> 
> When {de,en}crypting memory of an SEV or SEV-ES guest on an SNP-enabled
> host via a temporary buffer, allocate a full 4KiB page for the buffer to
> ensure the kernel won't concurrently access the page that's being
> {de,en}crypted.  On SNP-enabled platforms, firmware modifies the RMP to
> temporarily take ownership of the to-be-{de,en}crypted page, and so using
> a sub-allocation results in unexpected (and seemingly spurious) RMP #PF
> violations due to software attempting to access a firmware-owned page.
> 
> Note, it is unclear whether the RMP updates are considered architectural,
> or an implementation quirk, as none of the documentation for the non-SNP
> DBG_{DE,EN}CRYPT commands say anything about RMP updates, nor does the SNP
> specific firmware ABI spec.
> 
> Fixes: 4c735bf1bc22 ("KVM: SEV: Allocate only as many bytes as needed for temp crypt buffers")
> Debugged-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/sev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 74fb15551e83..87025d0d2f91 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1280,6 +1280,16 @@ static void *sev_dbg_crypt_slow_alloc(struct page *page, unsigned long __va,
>  	if (WARN_ON_ONCE((*pa & PAGE_MASK) != ((*pa + *nr_bytes - 1) & PAGE_MASK)))
>  		return NULL;
>  
> +	/*
> +	 * If SNP is enabled, i.e. the RMP is active, allocate a full page to
> +	 * prevent concurrent accesses to the page.  Firmware modifies the RMP
> +	 * to temporarily take ownership of the page while the {DE,EN}CRYPT
> +	 * operation is in-progress, and so concurrent software accesses will
> +	 * encounter seemingly spurious RMP #PF violations
> +	 */
> +	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> +		return kmalloc(PAGE_SIZE, GFP_KERNEL);
> +
>  	return kmalloc(*nr_bytes, GFP_KERNEL);
>  }
>  
> 
> base-commit: 9d4853b044beefa21c4ee3e18c40653601a64ced
> -- 
