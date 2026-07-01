Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F33ED3CA;
	Wed,  1 Jul 2026 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946354; cv=fail; b=psxBYb4pDrI0BLkSngn1plCG353yQnF1qvOXC2jZ6iLiuXUAJkzbVz2BIzFiimnvVvMJrDhRhGWOJTyKr7uBME587Z45HyTvstUaQ3zv9Ew99UYfVOSocnti7IhHaaGlzIEggzAK29fx5SZU04XFIJtepZgMcwzzjv3HpSbddMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946354; c=relaxed/simple;
	bh=mgODuYnIiWfUeDG97NIRDchtIDfNUWtbuQKvaRbA2JE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnwFoEfFSL/iwc7kNgGgObad+jtOKCMCcQ7DbKhO7rJjHt5ySTb6a3dX77sbgcEmUCsibNeyaqGCyryzSxvfEojM8OMDQfKf38jR5pNOgOwvy1OFkgeOkwCeg7x8/bJeTyHL/JcI2f8GJjazn9I3UXJnyknyrjj6/Ef5kUpMj/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PEgp/Zh6; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PEgp/Zh6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awGXp9l6LTWK3y3XiDaxGHy2iyLg1jloaMNFTMOft32B/fFwUuHzfVUwHmEkwsK2Kvn/u9PqhuINWqBF/0A2BF1hkoQgM+sTwjjNCA5ENue1Rv/HOBXbEnv7xpfojvqSx1kmRHvJ5DoLPB8zg8775xWN2tXoKbWqrBS1/aIUQDFZJRW4FbLSc8eVEu0ydC9ubc0PFb3QV4H58XtdNHwa7J7yqpKBuXIYkHbaevx67fGpauPrNd3SpBJNYkTQbaLMshnt8OTGnmnQvH1zS3o0Ff/3qMqQyjjcRLgC5uEz9Su6N8zxYvaMfJgnDHpB1y4uH0K+xUgdhTqZL0g9oIyE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnTyrqXtt63trUsTOTffAZ3oZpsMPyd3BZ06ZwTae9g=;
 b=wn0/Jz1GVSZ4KsJ7mlQAmkr+6x6JN49ptQIXArl2TIFPU+dA5Zfd25ezvMFmY6pb+piNMw7cpACp1vXXq4/LdV6eVous+IvkWzvi0sZA1ZhiwFeL00oGH3QZyDC9Z7XQ49cDxzvOOnZX23+lnKk6fKyriUS5UxUON1j/LhRRbc/kLvIT/c8GjQfmyz63Qnknrjb/hrev9VvresvVDllGKfGTlxhDdwu816h7TebpeFYRSy3SFMk1BJnHf+KSaS3ZPvrXLeXZPPHXBOAlLQPlpM9Jwwud7Hy6WpLPQ+a6NJgH90CwpHxY3O95OTQJn+rmHhTUDITFN9sDYQDduO5xAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnTyrqXtt63trUsTOTffAZ3oZpsMPyd3BZ06ZwTae9g=;
 b=PEgp/Zh6vw031DOH3jUihSGpfWx6YBGuaRo+hZaD225K+LXTeBch9Q9ZnkysFaQTSaHZgMONS8ep/39Aym3sVrnToAYUuBjNIwQmCR1H/BC1PsS8iIaSygX0d5BfYScDbtu1QhgXxpvWQPN7TjiaUs1Opc6GmqlX4BH3IvvTjZ4=
Received: from DS7PR03CA0187.namprd03.prod.outlook.com (2603:10b6:5:3b6::12)
 by BL4PR12MB9483.namprd12.prod.outlook.com (2603:10b6:208:590::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 22:52:16 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::5) by DS7PR03CA0187.outlook.office365.com
 (2603:10b6:5:3b6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 22:52:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:52:10 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:52:07 -0500
Date: Wed, 1 Jul 2026 17:00:17 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 06/12] KVM: x86: Ensure runtime reads of
 disabled_quirks are resolved once
Message-ID: <zp4xygfzvlumyht2m4vcriwgzxvut3v5igavr3vqbhzfax3rh6@q22orpcjrtht>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-7-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630222607.497895-7-seanjc@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|BL4PR12MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: b774557f-c15a-485c-2307-08ded7c36282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YhIjnA6e0KjCOsLYWvm/RR6v0CilFLcXJzpGrMk8QeGMtl2sNMEtIUP49WXKloFI3ESxDjbdtLJtD0uym6+poDlJiC0kbnvua1tTS/CFUihCCCd4Dn7ESXGolDDiKsUHuJXWXh2KHnhjS7DXuG+yyOzL/W4L03I5CM7cB+iro1xlxLo+fCw3dlPYke4VKhz1q9u+ShW3Q+/oKfHiSyeIAoPIGj95U4ICIZ24DDCTg+ouuZP/s7daFlE7w+j1qjlDGSX0vVUB7fzymDTT4BNoRfMTHw4Qv/SR7CgyiU10b5d3qP09u6X5yhiYaFuLCMF/Twx3wcoBK621SqarD24RoguqzACFuah2yBFXTQFcPfXKR5o/8WJjOLAWPNw76S6hCbHzB3te3lr3d0dfhuKtuagyMNts6vtPaFG2LfO9j3QuQFxFcP4DKpQtLQlOUfewLF6JsbRWX/m+j+/RfLYkBZmIC372h3/+E9n95CnJtnARCgHO0iuivYIA6cYiWaCKxhK3w0mYsI8/cjyQxjuIzmEsi8CUrKgKwJhoNlUV0mTpgrvrFG1zRDtLYPq4YkcSz7A6x8keYMwYvquvxt1z+XJF9KbWTPxTHT/7TudxqV2cYNhBC3I8fdLs1TYiKJwu9aaIB1HiHTJTpT8PaWK6gj+nt8ud5Xmbb1eJmnbWeEqTRiilr9qXvStprMLWWNoBHRV0k3tXmYJ18k0w6OZw3Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MbgDGouAcR7XNyr2fv5wVn6N8g9LF55OUmvWMQj5GEL/alKrP5zMroeuMz9e+tenxpC5AGMLz+JbkIjHSPCxDBfDfB/yK/DoQf10SB0qGArGMuvZpfpWGEZiIK4sCM4RCpdv7g1svQuIzMD9BBhJDr8tOQ3PMaHa+cAEvAuaJT0ATcsiJm6x0f1q4P7COHhBbnfMKbYu1uB8GuSggpJIahsTrHkfpBBd9kPYK7eU/v4t0H8/gsXuHsMUzsM5A0XYhnSev9eakaxok9XAokC5MOXeVGswgqaZoDjZpWNqNFQEEIWuUbxrsvULrwf3bm2b2hntQRHUDGnYMKYkHdeOYmyYInpJFBz+TvDvE1EhHEvreN4WU0NqEpM6yAOhDGvan1PMKPTm4FbQhM0zAqC4C2CbT6VByARPPL446gOVR8k86ZgLsA+s59abEcBv2nCI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:52:10.4066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b774557f-c15a-485c-2307-08ded7c36282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9483

On Tue, Jun 30, 2026 at 03:26:01PM -0700, Sean Christopherson wrote:
> Wrap the sole reader of disabled_quirks with READ_ONCE(), and wrap the
> post-VM-creation write to disabled_quirks with WRITE_ONCE(), to ensure
> checking the status of a quirk doesn't re-read disabled_quirks *if* the
> caller needs such a guarantee.  This will allow splitting the "fast" MMU
> zap into front and back halves, without potentially skipping the back
> half if SLOT_ZAP_ALL were concurrently disabled (which would be "fine" in
> the current code base, but far from ideal).
> 
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  arch/x86/kvm/x86.c | 3 ++-
>  arch/x86/kvm/x86.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 74f1d7169218..bc0c3163f4a3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3940,7 +3940,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		fallthrough;
>  	case KVM_CAP_DISABLE_QUIRKS:
>  		mutex_lock(&kvm->lock);
> -		kvm->arch.disabled_quirks |= cap->args[0] & kvm_caps.supported_quirks;
> +		WRITE_ONCE(kvm->arch.disabled_quirks,
> +			   kvm->arch.disabled_quirks | (cap->args[0] & kvm_caps.supported_quirks));
>  		mutex_unlock(&kvm->lock);
>  		r = 0;
>  		break;
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 8ece468087a8..75f13d88db58 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -304,7 +304,7 @@ static inline bool vcpu_match_mmio_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
>  
>  static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
>  {
> -	return !(kvm->arch.disabled_quirks & quirk);
> +	return !(READ_ONCE(kvm->arch.disabled_quirks) & quirk);
>  }
>  
>  static __always_inline void kvm_request_l1tf_flush_l1d(void)
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
