Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5FE384CEA
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219978; cv=fail; b=OyYvKVWXkBR2qbXb10ylNn/uBx6ND22PCsGcr/1Sk0W/l2l5/ZGNRldmyF7Nr78bSNnBIoR5Ke8C75WBk379vC/OmVCgkyGgLS66ALBxv/3VvyDPVjJXb4w5i+uXRa8QErijxISq8BSrzRw4n9lf30WCLPEvrrBLTsoMx+XiduM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219978; c=relaxed/simple;
	bh=8DRAJtZhWqj/fNqy1j29OZ4/BkoqsiRbRF9JvxxG6mc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjrl5LDXyVazvDQ+jpMVEra59YcRBNL32+JBwvXsb8pjsJ7CpeSzgNXCScaeuvaSlvoKo/OD9ejgrutJ9bePHsQPs8VpgotWPoHD1eIFDVCJq6cvwf16CzntmGg++qWgXYGolwwFHFK2yBtfqkOBN5LnlX8pDELX3eqRmMmWDR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ch9vin5y; arc=fail smtp.client-ip=52.101.46.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ch9vin5y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnWwIcQyCACqwumnzgFPv5T+anN1gm9cNU93etJfcFtmUWMXU36VtjPoBlWow7ICnlxkC/m97ChIVrjVVEPOKzk3QQY/RezByZnl3QEhsxESUVMlGZtUiMuFq2SyF1G35KKq2L1awz44w2rTxIBk0f1y5yfOZAxt1mR/++ZUivJQQXPw7sBjXTRhOCioOuW15Rw/Rq4Xj7QLch06LkMvXwPcN4GVWqZA0fATcU9/O7Ri2f6dCuvbwAvWlgqn/lfx3jyhIwmgYkMqMdbS4ery6OL9ownDGGz1GL5BJ3m6WaYXJnuNUyNBkNRgkdBi+4YrPGaGmpK6TmNY5daFS2wx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDYLIBYdY6q9Bv8NDJRK9GnIXdI7QrD+r7xBTb9yev0=;
 b=X9c9VxwQDadx7oqVIIauYnGSNmytqYjAsYvxL2MrZewZNaF03pEoKbkL8FmVLr4pp33klhOkVtHM3J7hGIqMYz4KsMVMGZB2GueKTbh/TjU/nlIwJH6I+XLblRwBaWjc3VhPG3Ep1bA0+1k8Qzsw3sgijV4I2qQPCmRDQD8oxaMMuaLhYqvpzefeKYYqcC6dsESIBIJvOb93F+4LnmHjB3tzFFOC94kdDh8TdR+YWx/tnhDhV27NgspBRp1zfJLf1BNBr9FqRn0EVfNDOrHA3gOnC4xAt83aPTHlEVQh/aFhB3vIsJbn+KVukqERpJnw3pmML+FFtLB/R7I4rw6nVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDYLIBYdY6q9Bv8NDJRK9GnIXdI7QrD+r7xBTb9yev0=;
 b=ch9vin5yuffLm77dSF2oC1EgoXAAwVD6lnf3anH1ihk6PN7oXgEtlW3n+bRG4Ot1OLCD6fDEzMY9DBs/BS+dZ3GbAngXlJ26aWk8gTYaZIym73b9h52lgAlQQ9bp+zWx5w7CaX4vLdYCxhwPJSBYU2nHv1ma+InTydbIzRLwSm0=
Received: from SA0PR11CA0113.namprd11.prod.outlook.com (2603:10b6:806:d1::28)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 23:19:29 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::8e) by SA0PR11CA0113.outlook.office365.com
 (2603:10b6:806:d1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 23:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 23:19:29 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 18:19:28 -0500
Date: Thu, 11 Jun 2026 11:47:37 -0500
From: Michael Roth <michael.roth@amd.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the
 host
Message-ID: <i6x7yq3f23mzxnfgzdy2yivir2wolkt6rufxgyv64pc25c4nzd@xp7sx7b74bye>
References: <aimMWzAf5b3luM0b@v4bel>
 <wxamg6zqn2qmsci2fwfepbqou5vtgydqmonr67mu7b73nkakbe@zedss5vzeci3>
 <aiqNPBQzoU9f8RwI@v4bel>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aiqNPBQzoU9f8RwI@v4bel>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2ea0ca-daec-4cb0-337e-08dec80fe309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|23010399003|82310400026|1800799024|4143699003|6133799003|11063799006|56012099006|18002099003|13003099007|22082099003;
X-Microsoft-Antispam-Message-Info:
	HwA/qlN/RXJOg8cyWymg5GnKIVHGTAS2uw7JMoz9rN9TCZnMNDyIxhZFJw0L2sdSOTGHTjYkwcCHqsoPJZViTIB9pKSX7d4/WUDkS9RmoFaUPKF4w/uSqPRjMn++U5b0RSELkxnrzWwwmP3L37cvfHHhqRD2xYGOBfja8E+20MCEcFQ2DSUevGO74WrdCfjaEOLDduM5Oj4s+C/a4oLBRvG76jmskWnhiISfnPzlCLNZVY/kEL+W0m63p1skx1IXHQ/V3Isny2A8QbeY3SPM9B20jk5g96O0qA6c9y9Jl/dCEMWN6NDruui0QeXN506NlgN3/sOebSyyTiCheeu/oKkLheiAKaFT+q32C/u/WRgUUOfmxDNsRpQe8wIqQLha3KIiR0iTQgTz3AZ8piJZcWlBOSYTaoPTJQueJlVKVu0m5AJdea3t8MFOzK+Th2+23OykfC4fznTqTDpLHFhS6TptQg+ASNJFEKnVMjoxj70AyQ0basp4jRk0eNDXqAerZ4hEk5WO2cwOHxn/YaUuAtCNfM1OP3S9KPwjTEWEvK9PQ8xaxq0+SFvXN8+vHpTqCviFFdnI9RdxUIvJHbq6KsyJ+yxMjHpEMnPSZu1aQw18tAVKL73E/WwDhJkglIRAwzZlIAt3uGlsYpnVQYqJgWbDox5hn0vskn4vLHm91Ok8hIoYkcnIGXHKYMA1faXGC7o2h9fpeAU6FRwFfJYjBHiIDY5JPqCup2zlqVRK6HA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(4143699003)(6133799003)(11063799006)(56012099006)(18002099003)(13003099007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dK2X/tR5oyH8sb9wTGIZFhlKPvPK+zQczmKwBu5QEU48IdxxC6zjKvg8eeaC1zp8nHOT6sKWqMDxfTTjEqYHL6f+SRqZHyHQZv03Ra29K+e6nQRCUxJZSffXe8AULn6PAWuxj6LiMuVfTREjHya+9uF9T9YiAX9vW9cSrHfBB7EX7PmYpdJ1Os+zal3fR1OMqp3JZ4XgUOYrUsPiuOr7SvdVd0P4t4ILGsPR+teXzqWasN9N0qPh4KhSAjbjppDSxb4gIM4qUcUq7rvl1S/8BU/sRlcOgvKuT5o1URRgLcidNmtBbOMdxwjWkmtb6aB3YcMkGXxaaxPDrXw09oczEQz+Iv8+ETC5WDuMZffKkP31gvOFl2SGExF/cOInixhC/fVFBDQO3e/iYF/uOOn1vTqpPXj5+1Ujdq9g+1TXyYI2D2V93WS/d//4BD800UDy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 23:19:29.1675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2ea0ca-daec-4cb0-337e-08dec80fe309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552

On Thu, Jun 11, 2026 at 07:26:04PM +0900, Hyunwoo Kim wrote:
> On Wed, Jun 10, 2026 at 05:16:57PM -0500, Michael Roth wrote:
> > On Thu, Jun 11, 2026 at 01:10:03AM +0900, Hyunwoo Kim wrote:
> > > [You don't often get email from imv4bel@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > 
> > > sev_gmem_invalidate() is called when guest_memfd frees a gmem page.
> > > For each PFN that is still assigned to the guest in the RMP table, it
> > > transitions the page back to hypervisor-owned via rmp_make_shared()
> > > before the page is returned to the host.
> > > 
> > > A guest-assigned page can reach this path while still private,
> > > because the free path does not transition it beforehand and
> > > sev_gmem_invalidate() is the only place that does. A gmem page used
> > > as a vCPU's VMSA after SEV-SNP AP creation is one such case. When
> > > rmp_make_shared() fails, the RMP entry remains guest-owned and the
> > > host cannot use the page because of RMP protection, so it must not be
> > > returned to the host. The existing code only issues WARN_ONCE() and
> > > continues to the next PFN, returning the page to the host allocator.
> > > 
> > > Leak the page instead of freeing it, as kvm_rmp_make_shared(),
> > > snp_page_reclaim() and sev_free_vcpu() already do when a transition
> > > back to shared fails. snp_leak_pages() does not take a reference of
> > > its own, and on this path the page is freed right after the hook
> > > returns, so take a reference with folio_get() first to keep the page
> > > from being freed.
> > > 
> > > Fixes: 8eb01900b018 ("KVM: SEV: Implement gmem hook for invalidating private pages")
> > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > ---
> > >  arch/x86/kvm/svm/sev.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > index 6c6a6d663e29..8fee6ec529f9 100644
> > > --- a/arch/x86/kvm/svm/sev.c
> > > +++ b/arch/x86/kvm/svm/sev.c
> > > @@ -5178,8 +5178,12 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> > > 
> > >                 rc = rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
> > >                 if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx error %d\n",
> > > -                             pfn, rc))
> > > +                             pfn, rc)) {
> > > +                       /* Still assigned to the guest; pin and leak rather than freeing. */
> > > +                       folio_get(page_folio(pfn_to_page(pfn)));
> > > +                       snp_leak_pages(pfn, use_2m_update ? PTRS_PER_PMD : 1);
> > >                         goto next_pfn;
> > > +               }
> > 
> > This roughly aligns with what would happen if snp_page_reclaim() fails
> > in sev_gmem_post_populate(), while the guest is being initialized via
> > KVM_SEV_SNP_LAUNCH_UPDATE ioctl, which calls into kvm_gmem_populate().
> > 
> > However, in kvm_gmem_populate(), we still free the page. Maybe, to
> > address both cases, we should just add a parameter to snp_leak_pages()
> > to tell it to take an extra ref and use that in both of these paths.
> > 
> > Or we can just do the direct folio_get() in both cases, the above
> > formalizes the handling convention a little better though IMO.
> 
> If I understand correctly, an extra ref alone still seems to leave the
> LRU corruption that sashiko flagged:
> 
> https://lore.kernel.org/all/20260610162623.061BA1F00898@smtp.kernel.org/
> 
> A gmem folio is on the unevictable LRU, and taking a ref keeps the folio
> on the LRU. page->buddy_list, which snp_leak_pages() uses, shares the
> same union as folio->lru, so leaking the page overwrites the folio's LRU
> pointers. Both paths deal with a gmem folio, so the same applies.

I wasn't really suggesting you do anything different with your approach
to the case covered by this patch, I was just pointing out that the extra
ref you are taking here is missing for the case where kvm_gmem_populate()
triggers a similar failure in the sev_gmem_post_populate() callback while
doing snp_reclaim_page() on the gmem page it gets handed: it still does a
folio_put() so eventually the page will get freed back to the host once
the VMM closes out the gmem FD. That path is just as likely to trigger
for cases where this might occur.

But FWIW (as Sean pointed out), we do not expect RMPUPDATE to fail on a
normally functioning system, at least, not outside of cases that can't
be fully contained/handled/resolved within the corresponding rmpupdate()
helper. The only thing we're doing here is trying to keep the system
functional enough to capture situations like "why did I get this trace in
dmesg after the recent BIOS/firmware update?" and being able to collect
somewhat useful debug data rather than letting the issue be surfaced as
a random RMP fault at some future point in time that can hang the system
in a way where we don't get any meaningful indication of what happened,
so it's sort of a best-effort thing. If we can keep the system permanently
usable for non-SEV, that's nice too, but that's also a best effort.

Thanks,

Mike

> 
> To handle this properly, the folio would need to be taken off the LRU
> before leaking, with something like folio_isolate_lru(), but that is
> mm-internal and does not look usable from KVM. How should we proceed?
> Please let me know if I am missing something.
> 
> 
> Best regards,
> Hyunwoo Kim
