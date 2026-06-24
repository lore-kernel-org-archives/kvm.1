Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D133B42ED;
	Wed, 24 Jun 2026 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782342707; cv=fail; b=cudT7y/3Mg4bjRq2T7NPNz+Y69L/0UiBxkG+qNH/Wh/5KL9bT32VeBSy5KuQuAtpGDzLGdUZXF9BssZUs8D395uIbY1nmjzXJcRi5w+wOXCAb2l3qpsjyaryQya4IIVN6OBYrKDmhihwBvvycJnCo0Lj7fpS7TYSlwmyMbjdOpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782342707; c=relaxed/simple;
	bh=DRyo4/IKqg8x0xtvGmJcgwKl87qU2hMzivrYIpQ/beI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwoLcpzd3U9jByNtCO1oZ/SQe7crJ1W2vP3zOADbxZx67Gt6mQcDMqIa1FBMCmY24ZoFBlNGFg14makMk2amN1OVVBrcT0jT14tTCLBZgovcSPSbZftTV/8pjSztwobxfL0HnV5Vh5oKKrNnw36Si/RKTyzi1tLGMRbIT3Kdh5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UfLL6ghW; arc=fail smtp.client-ip=52.101.56.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UfLL6ghW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=US1cGL5HZ3686gMpaN/mn3S+2JrC3YMGW+55mgi+b5mInDp52qydNyyMH5XhbbaHVs3uQsufOyZ0DuZ/o7hOgq1DLZmLN7xUQaT3RUS+R5khb0W710SMfK9K96BkJKTyBe7NP6pQJHJS9zwrPyXf6bBWK2gmJ9KwnBL5HDfOTlu2WQi0LdxFxh1eOfnmNx75nrwU1EP6aT2fTDMq2bAw/uFebA7ca1J+GyWGwDpBykhpeBXjG38BA/0xi59wcwOSA00pep8IDNJnPG7zcd4FH+iwbaL7YsLPOjj5x8xbYcPgyAB0WccEdN0YWJZX2a/iSwXqANZxz/HbK2EPCI2iSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHn3xSMgd8CEBrSP3GPFveIlmN7NzH7Albrkw2iojFA=;
 b=By6D8mMHblEfd2DWYMTNJ4EQmGITbYoHN2hdTDpQj53KmlTXEWnrjgowEhDpIu/TfvgloyupSiarSGGvK++xyq0NSEZ/V+zzqRi0+0CyErCjtQg0/eZX0kMl4igEegooo3VZabyE8/GE0imO57XFWYFFa/ez0E2sFL8dtg6KhO6YBt4HBswiIaFmEzDgKoRpRfl+jeQjWYNw3zSBdUdVMISskFZlMgmDmbQiYU1Z6ii8nnqIAucgra8wWVfxWOiUenkECvNMXZWQvKP0dPnDHCorowUnAQASs3bpkxOgTaKGz8j82809t/xoUdpLJfyKDZtSZ53nie5diSUJGEHwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHn3xSMgd8CEBrSP3GPFveIlmN7NzH7Albrkw2iojFA=;
 b=UfLL6ghWH0GZ4UJFjwNpW6GGK0oRkrVewpXxVQZU7iK/ZNq5MWo1K2ED9ZIBRpeznRoiSwdYfUqr5m/08PLw4L3hmaLroPbtjFwzWQHAl0auMgNdivthm9gY3KSDN1R/tt3Ys+KK6WXG2bumK9xqm6n9ynJ7LppK4CeG80sEa1c=
Received: from SJ0PR03CA0162.namprd03.prod.outlook.com (2603:10b6:a03:338::17)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 23:11:40 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::4b) by SJ0PR03CA0162.outlook.office365.com
 (2603:10b6:a03:338::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 24 Jun 2026 23:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 24 Jun 2026 23:11:40 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 18:11:38 -0500
Date: Wed, 24 Jun 2026 18:11:22 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV
 {en,de}crypt debug ioctls
Message-ID: <45ixyum4upln4b2yvasovm2bmsfxyfezsi23vsr75r4fklelef@utxv4mymvfcd>
References: <20260501203537.2120074-1-seanjc@google.com>
 <20260501203537.2120074-3-seanjc@google.com>
 <ajNQ_Ix5e0p6FuFT@google.com>
 <tx3hcnrhfbcz2p7e7umc5o2zrw74pluzuzgtlqt4dz5cc5nhxx@6tzzorc25nqw>
 <s7jfbw3tnfgmp6blfqlfoi7yhq6f5n6xl62zzty5up45cqtsty@ljpjlvqw2gyy>
 <ajrkryMxHZtsMvga@google.com>
 <6xyh7xa53k2s7bytlkcys4pyq4756rwoly5q7swrifv3td6dey@3h5e2e67lkvj>
 <ajsjQtpZb-h2BdPh@google.com>
 <ajxLCMgLQe-JiRfq@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajxLCMgLQe-JiRfq@google.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 37954f21-1bd0-42a6-f5f0-08ded245f2e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|22082099003|6133799003|3023799007|5023799004|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NkTWWOVWCOJUP5QtYDCDRbZYrno/86DW1SMneznumuSTp4iMy9nxFMXkmUI8eh3i47XOMfJq+yjho75V9nVfFwZSFt2sYz5/BrNpkSztsEv68XCPZXTRtPePA1a0G17g6j8QVFCPxlwzIDqzNOl+3hVqsvZVdWZzjROxgFJTjfZovtGqWfPA8IZdALbf/ppeL/a74RNZ92nTJqZ8qpyY9Ckc+JGbTjK+D0x584CNfXwfD7N4EpSZ8Q9ttEL4ioPl3otBMj+pozaJ7F8UdSa970JYk6M8NY9PqyP40qa3A4Nph58Gq6sguzE3Oyu0YBAeeOznrT/LpnnTO0A8LmKw96pqLR6f3HtS0EcfRDEmOiH2dH26MnwtrMBDH1NPLHNIc0zflDY4ksCFiF45ssNKlgOv5zqwNzU+R0R1zERy6YBVdLMr+O0Hs1a7Q3Go+YRw8k3G5nNrNtG5OJJAgDBioipKIL4FDD3rutKTDzErQCWAHYwYQMV+D29SQsTTmfwwIjRrLztygETNbt5IUBta6+MS9t1SDdMQ9pWx0lB3F7LK93wCg0fXCvTcWqGkDiKoaOiyfwtObEfbwEb7nSyDyUZps3fyRWAHhqZgc2uojCnxcoJ22LOyhwM0GdPilAm95RId6rvJb1wl4yVjnQgIrq/3HAOUqP+MA1EFSBgY6tIGRH0Uhmw7YR1AhrSctKFJrbiArG1dClomfG+7g4nibA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(3023799007)(5023799004)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yJIUsMi4+Tqbho6eJz6uadks6awVLb6DIZJlGI5dGvI1ntKPwGeTSVwJGBPUhiC1pz60waqOPDT1P2h6pv8z9eoA8pxxbP3A7MO9wJtbjV06kywcsPd6/n3yJgE2gbkaj9D/Vz2F46IWbiXndnn8heyr8yAJbOwcQKrGqvWfka/GeXJvrsSbbHGGdFYP6XGhy6+WgitIuUpD37842Q2Gw/ndeyRmyy75YZLcG2vBXu+dcAu3xNvEn0Aq7lPr8VUd525otNr4YHceJji+sR5UsBcs3qlSg+dpZvbhNPbv0LUtpPz5thXfeb7qZqpA3jDN5af1nXQR3fvFX/OwzDYpx2yOyhinm+E4FZMNks/4x9YsBtuVoj4zs6QOX8Q6EV6gTQWAhnpWxCH844SooISUsQqMBGtRDdvE7EBNxu7QcMuppVWkVufeXUtVc7V2Ghzx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 23:11:40.1562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37954f21-1bd0-42a6-f5f0-08ded245f2e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591

On Wed, Jun 24, 2026 at 02:24:24PM -0700, Sean Christopherson wrote:
> On Tue, Jun 23, 2026, Sean Christopherson wrote:
> > On Tue, Jun 23, 2026, Michael Roth wrote:
> > > On Tue, Jun 23, 2026 at 07:55:27PM +0000, Sean Christopherson wrote:
> > > since your proposed fix seems nicer and more complete anyway.
> > 
> > It's missing a case though :-(
> 
> Ah, but so is the revert, and it's not a coincidence that the old code didn't
> bounce buffer the destination for KVM_SEV_DBG_ENCRYPT.

Yah I was realizing this too :( Though I'm not sure why we set
'guest_owned' for DBG_DECRYPT... I'm not even sure it makes sense to
write decrypted data into guest memory since it would only be usable
if the range was decrypted to begin with... in most cases this likely
wouldn't be guest memory.

So maybe the bounce buffer approach would work for DBG_DECRYPT at
least, but yah...I think the issue is more general...

> 
> > The final write for ENCRYPT writes to the destination directly:
> > 
> > 		r = sev_issue_dbg_cmd(kvm, __sme_set(__pa(buf)), dst_pa,
> > 				      nr_bytes, KVM_SEV_DBG_ENCRYPT, err);
> > 
> > More at the bottom.
> 
> Once more, with feeling...
> 
> > > > diff --git arch/x86/kvm/svm/sev.c arch/x86/kvm/svm/sev.c
> > > > index 87025d0d2f91..7e3334c90c57 100644
> > > > --- arch/x86/kvm/svm/sev.c
> > > > +++ arch/x86/kvm/svm/sev.c
> > > > @@ -1406,7 +1406,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp,
> > > >                 sev_clflush_pages(&src_p, 1);
> > > >                 sev_clflush_pages(&dst_p, 1);
> > > >  
> > > > -               if (IS_ALIGNED(src, 16) && IS_ALIGNED(dst, 16) && IS_ALIGNED(len, 16))
> > > > +               if (IS_ALIGNED(src, 16) && IS_ALIGNED(dst, 16) && IS_ALIGNED(len, 16) &&
> > > > +                   (!cc_platform_has(CC_ATTR_HOST_SEV_SNP) || cmd != KVM_SEV_DBG_DECRYPT))
> > > >                         ret = sev_issue_dbg_cmd(kvm,
> > > >                                                 __sme_page_pa(src_p) + s_off,
> > > >                                                 __sme_page_pa(dst_p) + d_off,
> > > > 
> > > > But if firmware temporarily converts *both* pages, then we're "stuck" because at
> > > > some point KVM needs to actually target the correct guest-owned page.  The only
> > > > option I can think of is to require capable(CAP_SYS_BOOT), *if* the above doesn't
> > > > suffice.
> > > 
> > > Not sure I understand fully, but snp_populate_cmd_buf_desc_list() in the
> > > firmware driver requires the transiton for the destination page that we
> > > write to both for 'encrypt' as well as 'decrypt'. What the issue with
> > > using a temp buffer as the destination for the 'encrypt' case?
> > 
> > The problem is if KVM does NOT use a temporary buffer, which is the "fast" path
> > where src, dst, and len are all 16-byte aligned.  In that case, KVM does inline
> > {de,en}cryption between src and dst.  But those pages are also mapped into
> > userspace (they have to be, since KVM pins them via gup()), which means that
> > userspace could feed the same pages to a different chunk of the kernel that
> > reads/write userspace memory via gup() (or gup-like equivalent).
> > 
> > E.g. pread()/read() on shmem-backed memory.
> 
> pread() doesn't work, because the source or destination needs to be a userspace
> address, and so any RMP #PFs will get eaten.  But copy_file_range() makes the
> world go kablooie.

I was hoping we could at least rely on kernel accesses going through GUP
and maybe doing something like unmapping and freezing folio refcount
to block concurrent access to the page, or read-only protections that
would force the GUP to fail and just fail the concurrent userspace-requested
operation...

copy_file_range() bypasses the GUP, but freezing the refcount or locking
the folio would cause it to spin until the folio was released. So maybe
that's an option?

This is similar to what's been proposed for gmem hugetlb support when
splitting/rebuilding hugepages as part of the conversion path, where
we need to guard against concurrent access by both kernel/userspace, so
maybe it's not too hacky?

> 
> Weirdly, I haven't been able to get a splat of any kind, the host just goes
> AWOL and reboots.  But I'm very confident RMP #PFs are the issue, because doing
> the same operation via writes in userspace yields:
> 
>     sev_dbg_test-24385   [049] d....  1892.853197: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
>     sev_dbg_test-24385   [049] d....  1892.853202: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
>     sev_dbg_test-24385   [049] d....  1892.853204: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
>     sev_dbg_test-24385   [049] d....  1892.853206: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
>     sev_dbg_test-24385   [049] d....  1892.853207: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
>     sev_dbg_test-24385   [049] d....  1892.853209: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
>     sev_dbg_test-24385   [049] d....  1892.853211: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
>     sev_dbg_test-24385   [049] d....  1892.853212: page_fault_user: address=0x7fc63f8fe000 ip=0x41cb44 error_code=0x80000007
> 
> 
> > Looking at the full picture, isn't this a bug in the PSP driver that affects all
> > commands?  With pre-SNP VMs, "guest owned" isn't really a thing, since nothing
> > guarantees that the destination page is accessible *only* by the guest.
> > 
> > If we rip that out and always bounce-buffer, then KVM won't have to force its
> > own bounce buffering of sub-page lengths for SNP, and that would eliminate the
> > race I described above.
> > 
> > Completely untested (I'll give this a whirl tomorrow).
> 
> So this doesn't work.  Dredging up some knowledge of how this all works, I'm
> fairly certain the issue is that the encryption is salted with the physical address,
> and so encrypting at X instead of Y will yield different ciphertext.  I.e. any
> command that encrypts the contents in the destination (or in theory, decrypts,
> though AFAICT none of the commands do so) *can't* be bounce buffered.

Yes, sorry for not noticing that detail sooner. It really throws a
wrench in things =\

> 
> I don't see a way to salvage SEV/SEV-ES on SNP systems, short of requiring
> CAP_SYS_BOOT or some other elevated permission to do *anything*.  Or redo SEV/SEV-ES
> support to require guest_memfd for operations that require putting pages into
> Firmware state.

Yah, short of maybe the above approach, I don't see any way around it atm :(
If you think it's worth pursuing though I can give that a shot on my
end.

Thanks,

Mike
