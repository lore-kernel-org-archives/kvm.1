Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748B15746F
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781129838; cv=fail; b=EpeNTxuu+o3PY1amOVB/rXHAViFiq0ZbUEsrunUldDRjKVdEW7mqAZCZSQ/1P9BRi/yrgO8/HHfPDQ49LBqEfM1g/wjyt601mgtcJgRa5WCqti7lFese3lYvJW5lKeFM2KZcixQgqfeOmgeXIHxVdxSMLPR+/vhkeOhLUf5SGSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781129838; c=relaxed/simple;
	bh=I0sXv5LYw8MB13Brg/oBp/Mu+SQMQ8pW+iRLjKkMd7I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnSWVZxDpXdyfTd67TF2AApIL0iRK04zmp1oVWn9/IAsbk1avunSGl3CqM5m3KQTNfEXxLf5WF7q7XCPv3E0Wv0eZv2FOZ/7UV/VzYvp6Q8ty1LTYU+MA96xXbPqxNsGZQKtRKFQPY1XoPMY65Cth3r+8o2l3rSB2ZeH7ZLDAQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MHs5Y4IA; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MHs5Y4IA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jw9EohAJQLjsnI/vnMZj1I8YPxV6vR6XB8zKGn/9q1ctFiNWgLmVb7qO1NlI6Ac7aDRDa02JToic0r775lQWCSOCs9Ez7DwNnujFDdZetE0Yq+75OD/DR2oKEhi/BETFp1pjp14HSmxR6L/BfjhJazQqFyzdYxltJW6ILkeQ6n6jgTgXGM/f5I8AwK9oYe5Q16aDKHumsz+Z06pKNf4hLzvu/xk15GQc45EWFk4i07o+mu8RTdtuiru9y1FuFWxod15KyyWXWAIG8J/qMDIYD+S9stm1pzlDM7ECs3Dp+GfCJuHkZTxI6XZQsQE6RvNMTCxL3J55fv6QKgxiorUxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcPrSK7FnZuvzYXwvC9nW6i3kL7ss9suZR4xgt21UF4=;
 b=rvxZS3/L1x624RciO7/xnQUt2u0k0Qe+Sq40uprJMbQhbB9P5/fs0Lt0XUfAE3GNknHvKz9cKotBPlX880ktYAuciMSXSF4faK3oQ4HcCOvKJofbc5EzlgNF5XlGHqe3jPFPealp0bHkMwOo8OYdZo7I/b9/KH0PjsRxeYOas77pP+ghSNEYueIZv6QewEez5zCTiHgkb9UMGwJv18qxp+yxtd5rU2l7oMLGgLDs9zaa6K2TaZkg5F3J7q/mkYPGfKhKJoBXhRmgrLG2eDt/X1sBuoJPA0xI3qvn9CF9rkfEkScro3naLE4lM4bM62pF1vadH45/jWwxaWtgaYEK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcPrSK7FnZuvzYXwvC9nW6i3kL7ss9suZR4xgt21UF4=;
 b=MHs5Y4IA2lIcfH+eeRZboMbr1KLlUgY2/IuLWhtN9cdyRSVNxhYTX2+NIhfZdt0umE8WtPpfCJF+mBvwAjqiNzbLG8Czt8Mqh3r6tKGpr1UqqhEL5H07XZSrk2srSS8qBOTH7cgLHDRwrZcGJQ2QTkc58xv0DXN5BGKVUoOHyJw=
Received: from CH0PR03CA0195.namprd03.prod.outlook.com (2603:10b6:610:e4::20)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 22:17:12 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::39) by CH0PR03CA0195.outlook.office365.com
 (2603:10b6:610:e4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 22:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 22:17:12 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 17:17:12 -0500
Date: Wed, 10 Jun 2026 17:16:57 -0500
From: Michael Roth <michael.roth@amd.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the
 host
Message-ID: <wxamg6zqn2qmsci2fwfepbqou5vtgydqmonr67mu7b73nkakbe@zedss5vzeci3>
References: <aimMWzAf5b3luM0b@v4bel>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aimMWzAf5b3luM0b@v4bel>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: a187b781-0cc1-4a4a-d66f-08dec73e0588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|7416014|22082099003|13003099007|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gQOCoYPLWzx4zctIDVW/+bEuM215+LlLaJEST9raPDaHU73fRf5BplD2rh0WksMfu7JlX4R4noasfPCXzLX+aENRlm/JTnUbPabcW+JdsTvBrqAURdbsikC0VLfyWwfq/abKcSuyOcVKjNQQI7WuGpYOeZpQ+FjiuapmhB8RFQTLwvC4gGEqoaRe32M00nwWEykwKHCPyROnThCZDPidFnCH2jd8S7f+XR+tXV1hFtj+g3YnJeRyxqyDz4l32EAWJFSyAzy6Ix7OGAius6Dk8HIR1FKFv2j3JQ6lpqBT+eLlNk2FO+r5DoJuB2SCecDZJpgNiVJG6FCUhO8lUC1Jd/EXmxDI6vGdWTFZ89YgI3GFzH5bpVcv/1uBJljEOwOygcSf6iMX4mGKefWn2C/HVHOZbC20aFrKmrRVhNFO/+fnyG3Xj3XxxEvjfOBUV3/6VqCv3oy17dVZ3tXJ8D/Aw1OuGW5nB7JoQQTO/x0fyTy+472Wcx9YfuJJL+BsjH4PshBwoue+JiN3VQ2byETGpK5KbZhLyl6v7bLhn/0XKV9nHJ/KRXSi5Kq68aWRtZb2lB7V+xzsv5qraY8VPMUEjZ58O6VtIzGWWOI0IxKfNLp4y8h2beBEa1AuUWU8KY40oUVC0RAEVa5sVNGTf0ALj5B1bs7/a2fZ8XMCei0MtKRxct81rIeKac6N+b2oFYBQJhyYtMQ+AjLgpQLy3z5Kn9HxE+HnGI6oAHQNrHcGw2c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(7416014)(22082099003)(13003099007)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y+vnyL4dm/8tG5J/a7IXqPq0ZDn6jhBiG6zDlOs4b/S6R0x11ya/BRkGbCRYYO9eZsiI6RZLA1nMQ66Jrlzk8lTNdGRHkrswGXQoAANHTlp6VoD0pUtB00H3pdFM1O/lXVKM9LHLHmRcysQ+uKNm6vCQOkOhPJxoNNHV0LAyXyhl600TT7BXrYDcDWau6kqYfUzzoTuGIG7avDmMBRmq2NCGjFubAK/H+KElsC2HQ9y2eiTCsHpd3Jyxncl/17TJxV9AoUJD+/gMZ6RS/Oa2jzmkNSIEnb+kfOL/jmVpCjCwlJKauLuNXU6UlGewgTeDJLeoGGyGKpIe5s39KomKXr9/jVbzauLYfDRtgNyNsOkRdO0dqLJSGi24sP09CnQAq6fwQ7msEzxpnPWGacyAx8X+5HpYH1v5ndd6F2CeZvpkmc00V4S/bOhdC5s4J7CW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 22:17:12.7673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a187b781-0cc1-4a4a-d66f-08dec73e0588
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819

On Thu, Jun 11, 2026 at 01:10:03AM +0900, Hyunwoo Kim wrote:
> [You don't often get email from imv4bel@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> sev_gmem_invalidate() is called when guest_memfd frees a gmem page.
> For each PFN that is still assigned to the guest in the RMP table, it
> transitions the page back to hypervisor-owned via rmp_make_shared()
> before the page is returned to the host.
> 
> A guest-assigned page can reach this path while still private,
> because the free path does not transition it beforehand and
> sev_gmem_invalidate() is the only place that does. A gmem page used
> as a vCPU's VMSA after SEV-SNP AP creation is one such case. When
> rmp_make_shared() fails, the RMP entry remains guest-owned and the
> host cannot use the page because of RMP protection, so it must not be
> returned to the host. The existing code only issues WARN_ONCE() and
> continues to the next PFN, returning the page to the host allocator.
> 
> Leak the page instead of freeing it, as kvm_rmp_make_shared(),
> snp_page_reclaim() and sev_free_vcpu() already do when a transition
> back to shared fails. snp_leak_pages() does not take a reference of
> its own, and on this path the page is freed right after the hook
> returns, so take a reference with folio_get() first to keep the page
> from being freed.
> 
> Fixes: 8eb01900b018 ("KVM: SEV: Implement gmem hook for invalidating private pages")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  arch/x86/kvm/svm/sev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6c6a6d663e29..8fee6ec529f9 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5178,8 +5178,12 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> 
>                 rc = rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
>                 if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx error %d\n",
> -                             pfn, rc))
> +                             pfn, rc)) {
> +                       /* Still assigned to the guest; pin and leak rather than freeing. */
> +                       folio_get(page_folio(pfn_to_page(pfn)));
> +                       snp_leak_pages(pfn, use_2m_update ? PTRS_PER_PMD : 1);
>                         goto next_pfn;
> +               }

This roughly aligns with what would happen if snp_page_reclaim() fails
in sev_gmem_post_populate(), while the guest is being initialized via
KVM_SEV_SNP_LAUNCH_UPDATE ioctl, which calls into kvm_gmem_populate().

However, in kvm_gmem_populate(), we still free the page. Maybe, to
address both cases, we should just add a parameter to snp_leak_pages()
to tell it to take an extra ref and use that in both of these paths.

Or we can just do the direct folio_get() in both cases, the above
formalizes the handling convention a little better though IMO.

Thanks,

Mike

> 
>                 /*
>                  * SEV-ES avoids host/guest cache coherency issues through
> --
> 2.43.0
> 
