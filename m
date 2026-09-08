Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A998560AB7
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906191; cv=fail; b=qitD/hC/Ghh11bJTKHsuC4V5f0ZRz2df6PKETybVbhkvDOHs2JwXOuq9oY18B6aylNfLHmFJsvIvc2kJdu2AaWAozGektIi21VBPG2NKOfHYuV0UGm+weDoHTLAvhkOiBInI5oCK4NFPYjgVTGEhUoCrvKD0gR3uPFWZzpGi/WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906191; c=relaxed/simple;
	bh=qR/+9tMQkNZjNEiVNIxHeLCvEQE6JQJzT7SBOuY3rnc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXWpWvrcneT0ViU2mPYiXe7CulzYsia+ctcMgnu2HD4UWltkXGya2gB+r3spa/5ZF/+OKPHH8j17Z5I8JGRvobCcnGUv3fC3wYEWhjz5uVNYURaBFLfvB7fxBv9VBPJwJhvlRLfetqM5cMfkLi9uOw0Q3Zt2qBy9j1/QzOG3e58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DqlwZVoV; arc=fail smtp.client-ip=52.101.56.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DqlwZVoV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Si0NENry5tV3lykilFzhHSkSiYPk9OuA+qmuNBLDgCWZc7t6Q4JqjnchTT2L8MzAwoj/hEv5aTUztBvg9+xPpMb1gAb89eLI5Jcy1iGuTLG7iIXuEOCpE706VBdTxtiOKY8v9DRB2erNMV6q+WUP0GmaBaK9ltArPG124Pn+QAUPmSeub5ZOXlDx6UATTl0MYtpTS/VwGVo7SDaid6/OtFDiJaXXFBjooIHi8knqA5FCfkCRg+myFD3q9vTs9rc3HSXinTgNKsSHBn5EezTMY7ivzxT0DX6tswce7D3/iNTMX2NZ7JgZccNzIcVc7C2PPcNrtx7Y9wkdnQW3t0tIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m29YhAAm/SoT9w0XP090ccn3lyhcOpMaq0641APwl10=;
 b=aA5Q1JsYAOw4K0gyB92gCRIlaOXFtrRWSZHkhUmgAWZdBFHXKepVOBScHpPXoFtpzNqdQd6szUyCuaNgXs/DBF46k0Gx0agxRUl03kAwUahpOipedVKiYLiIR7wyOPpx24vqZC4Kceg51XOqZoZJfpf+XNSWz4shkFXG/U4KjxL1jcz7dIXiwuVaN8NAn3EQNs12VeN9x0hT0sLSJ7LHNrPuHTRKtgbP512qtmFXJFkEcs5SCsTzG+yFlLha+qi26aKZKJmfLQVczjrMb3yVphqiDj7xPIhtaluM09ZL01ZtOkfbfAALIcPrEmQ3vaej6O8tg1mo+wMGHWCaVDpvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m29YhAAm/SoT9w0XP090ccn3lyhcOpMaq0641APwl10=;
 b=DqlwZVoVhqSkcCLBDJKmGZHCWeiI6MeHcbdjEamv0hr+w9jAzoECQAbIjVedbM7L/1eQDjkbWgfSp7IM24Q/h43+7zOSqTJiw3uSSDsuBQjjeQI1b6hqmz8MtLMSi9AG9PPLbUAm9/4bKCui/QyE7bK2XNnqNDAU+mqZicIKYWE=
Received: from MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::14)
 by DS0PR12MB999104.namprd12.prod.outlook.com (2603:10b6:8:2fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 22:23:06 +0000
Received: from MWH0EPF000C618F.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::62) by MW4P221CA0009.outlook.office365.com
 (2603:10b6:303:8b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 22:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618F.mail.protection.outlook.com (10.167.249.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 22:23:05 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 17:23:04 -0500
Date: Tue, 8 Sep 2026 17:16:04 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: Re: [PATCH v2 18/19] accel/kvm: Disable discard for in-place
 conversion
Message-ID: <kkcw2m3f4jqfxrj7l5vlxltduiqzx2nqvsi4lrvgrdvyinawzv@6qydw4wgahda>
References: <20260908205236.838281-1-michael.roth@amd.com>
 <20260908205236.838281-19-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908205236.838281-19-michael.roth@amd.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618F:EE_|DS0PR12MB999104:EE_
X-MS-Office365-Filtering-Correlation-Id: ee44700f-b0d4-44e3-45ee-08df0df7c116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|1800799024|36860700016|4143699003|10067099003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	zXDeczhuIiSzn1D1zUwOS+5xzRpdfU2nj0hT+ppqnKMOuVXLPdI2Gin5ykv2zbT+PZpOX58NPnOQn0vsuhLBrrJz7ka0gs9YIP8Hrny8u4gIs583dWJ1a5HFhsHk3z9bmPZ2O+GfFeyPfFO9KOqzwaS9hErPcSZwSauTk/M3yyQ17+6X6zKbIaoxw1gT+14wn6Wp8pCMjXgSWTOZVrIfGX+ruqSl/V0oX1lYr7i5wlRM4Bgppt3zA/2secOq0Z7Qi46zTYq+NkKrIrYu3SpFBzr87+y9kRDYV/lotMWE0nUdEDTf6NBNDWTi6GBN7SS9CecjgqPoSdawb5/l1ZkzUBfZwxsHnXrJXTjCxBwfgWCxa7/W+Sr6Gos4tXIe3V+GDQNW/8TUaRPPz2dehBO+SbB/eewdB3VRQiV8fgkqlu0cW+pGtmMCHMsxbX8u2FxLGo5AET1OS5nne99AuTUQJXAbAlRJC17ExaW4WjeJJ2WbC7jvKkG55JPW+1PtkauB/Qqn83sKmxyFI5Al2rwF97m5hrILaYI9nUotKqdPGIerX8D1wBl9yYcblsst8qRyOZAJVYxybC3aJ+N4d6zUO/F93KTqw4836RtSJT4b1lklRicdAGrWWiRq9yiWKLbgHytXa0pJRBPjY7dA7bP3d/4US0dyWwCgvvmSgJDNiqFvUqLxxiIm1wn6x0VYK4OGBEJ7lIMT8AX0cFZeeck5tg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(1800799024)(36860700016)(4143699003)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	38NDwIIZFv8k+JsTwSUhNVdk5O0K4/4DrxmvjrtquLjb5hGd/syxIdTYu+RoAtySy2oyc+O1TACIvmeHycuKAvf2r4/NJG8AOhNiNYSskOF3FvWk/RV3JgVH5e2pxEc5vi1zmVn1Wl3vdT7MCjHU/VF+UzeGGt7u9om/LmAx9dIYUjjWOyFOzo8XxhqXOp1hG0qMh23PFCTL1TTicFze/weZbodoIC8l51vpAjzQ44fS7oClnKac/TNtSO6GAu30W2GnlyHYrqEFDe8tCKJPx2iaqfxLwZOJoLOKE8UHOrJD3CJLwhbBgoUnOUq8tnWk0g4/w1/ExRg25jMyhlvdDrikGw1bXTt5msEQKUM1J5o1vZRMUYj7Q+91x9RWqRNm5FSfjvpCjh6O4VzXSR6k2ORnL0P1MJoO44YIBzCHhsD3AuRYKTtylCRtQdT+MOMU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 22:23:05.6112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee44700f-b0d4-44e3-45ee-08df0df7c116
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999104

On Tue, Sep 08, 2026 at 03:48:38PM -0500, Michael Roth wrote:
> When using in-place conversion, there is no need to discard memory after
> conversion because the same memory will continue to be used after the
> conversion to back the same GPA. Discarding it would only cause
> unnecessary reallocation of memory after each conversion. Instead, only
> enable it for non-in-place conversions.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  accel/kvm/kvm-all.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index ff07050935..b28c9fbd33 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3611,17 +3611,19 @@ static int kvm_post_convert_section(MemoryRegionSection *section, bool to_privat
>          }
>      }
>  
> -    if (to_private) {
> -        if (rb->page_size != qemu_real_host_page_size()) {
> -            /*
> -             * shared memory is backed by hugetlb, which is supposed to be
> -             * pre-allocated and doesn't need to be discarded
> -             */
> -            return 0;
> +    if (!machine_require_guest_memfd_convert_in_place(current_machine)) {
> +        if (to_private) {
> +            if (rb->page_size != qemu_real_host_page_size()) {
> +                /*
> +                 * shared memory is backed by hugetlb, which is supposed to be
> +                 * pre-allocated and doesn't need to be discarded
> +                 */
> +                return 0;
> +            }
> +            ret = ram_block_discard_shared_range(rb, offset, size);
> +        } else {
> +            ret = ram_block_discard_guest_memfd_range(rb, offset, size);
>          }
> -        ret = ram_block_discard_shared_range(rb, offset, size);
> -    } else {
> -        ret = ram_block_discard_guest_memfd_range(rb, offset, size);
>      }
>  
>      return ret;

Sorry, with this patch it's now possible to return ret when it is still
uninitialized, so a "int ret = 0;" is needed above. I had the change
made locally but apparently didn't amend the commit before sending :(

I've gone ahead and pushed the fixed patch to the snp-inplace-v2 branch.

-Mike

> -- 
> 2.43.0
> 
