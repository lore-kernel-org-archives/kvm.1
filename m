Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400D3EDAAE;
	Wed,  1 Jul 2026 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946319; cv=fail; b=ezl0TnKx+eZ2FveOaMenH8xpv2MCRGmuRxJP4Ahlwb6W/xuimR/mFpgPt5gRHfjXxbaOuDP5HtIzxbv3e0rwWLgvNVGHTM/YdSTW3aeWE+s8mZLhBatQEDd+if0QliQiOMOEOx3ta/pomjz31b0nA8OOQ0EbOJ/i6ocmDgwSGKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946319; c=relaxed/simple;
	bh=XoSkZWpe1JQ6gq2PvDaRcay1LRhg1yTefk3DPv7xNeA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rdp++wDqw2L1D+YuTRKkDZEUCjWRGUKKGKKNpIPlat+5TnVDhRPo8RuV4V3VW6Dp7+/bwJfZAUIec8J09aA68H8JvTKw/PJb7Gm6KBPuQD708JHZuAn6huSyWWqbbV9cTsgS+rm8eQrm8/n8UQPqhsc6Za6oDtb0Oa12iLzrjNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=htwUsEAi; arc=fail smtp.client-ip=40.107.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="htwUsEAi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4yhm5wl+jFSQcetnG1a9fakVaohBlMMZGsyATkUGqBvYwPIB1D7/OPX0v98GBCuRj2kzpTvVn15CUln4EVd6ZaFS2NB/BDWRwknYW6V4Sd6Di/0b/M2xmgDDjqCBtJOiEWIJcERWa3K73Sz3KlT1znUlh5eVkz7VwvX/K6m08OxA7mQ/olwFPhDhNhOZtMsebUK8CePUEhjJrd4cTeOoc/yMQ5vzttg/2O0ZRfc3wP1GBA+4AA/olkLdToexzrkZM+qGdPy1z/Ymbo4rHANYefJk4PP/MBQW9WXK0Ku/Sr4bm3swIJNqezgkzVILeyJDsxkg0QppX1bHMu59S68Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpB/zkRBhg4PLQ5x3qoCtxpDfOZM1GWoK45x5Kh6KKc=;
 b=O3YApK5BdmkfJZHtWuSN1Y225zNNxgz4Blx2Aulo3/+tdnBQUJLfYvT6Hv1Dx2zIHAEyAd5AuS2mypsOhAXq5fgxu1bGjIiQsA3IP3lc6XiBVKgX2/XgxKMe7H3a0r5ocRRgzvrf4cTTFKUr5jF6e5AVdlUBh9TqoEBOM4ZhYKX1AlKz3+rGX61Fze9o3u9ZWgqeLCqx0aDjg1+BRO5DoapBO+exUboNTiTijUZHFF391/4wZKyNhKxFUSh2xhis//Lwp6sM6qDeDMrUi0R9/ruG6AeD6q7rCr4/Y/uknhJ0D/yvP4P+aubd7IsY1VFXqNx1x6c4qPmBmM2e0bY3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpB/zkRBhg4PLQ5x3qoCtxpDfOZM1GWoK45x5Kh6KKc=;
 b=htwUsEAiTugxxoWWhK6bAZHEPDhB5Fyn4DAQWzleoPUDhKcLcdJuAMj/RQH39G+qpjeCln/tEs17Tmv1IXte8cgl2cCriJETI+8ebOVgLpeg7VBhDVsM8m+zDGPXFSfEdwM3hmZH/GTtDESsSG6Pk/YH5m2FFPO1cn2trydYn8w=
Received: from DS1PR04CA0014.namprd04.prod.outlook.com (2603:10b6:8:44f::12)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 22:51:47 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:8:44f:cafe::83) by DS1PR04CA0014.outlook.office365.com
 (2603:10b6:8:44f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 22:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:51:46 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:51:46 -0500
Date: Wed, 1 Jul 2026 16:59:03 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 05/12] KVM: x86: Serialize writes to disabled_quirks
 using kvm->lock
Message-ID: <gzpaagweemyjpxo22dyawjng4arspc3tn76osdi2rqucwpibun@7mxajv4p5wjt>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-6-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630222607.497895-6-seanjc@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: d26230b7-4367-43c8-c71d-08ded7c35480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ehENPwHm2aiDH2d4yxPFcerd52/Yg264qK47xoMlEQrC6IOM1z+bKjd9Ap3dkwiEA6FQlYcjHAnufEB9j3uDoZRe0gvhDm8PYBIP77GoC8Tj4lukkjOW6+OLHZpsLW1aKROyCnDr8vpz6XDPYe0iKV4febfWP6RqziSSyNjUVC9SRkTTeYzj2EOVhgOE8lTAb6kKLWcKcHNzocRHODG85hac9ehrUnfGFvUjCONkXMWIgqOO7/iff78FwDzqY+N9tmMeRP0fzbYoAULHRw2WVbTvvx8/v1eiXmFVb5/o1JCuWq44BMnYu9Wp2h2mXil+wqg7pOQrr8KhSdL7t29Vp8D5bfSRdtfz4BdAR+mHNotWL5X4T0DJbCuCVFZ2xrk0vzy/FWW70d9b8vlKmJRQvKzAqxycKVliKIKilSartmL9Bqktj22GPPmhC7fdmxn3cxPRh92tkHJT1k2Hiwfg3onTvbhj3HZW0wMgXugbTvFQjvNkY7Jt36Z+4LPtyCvf5M0/vZRZWUTegi0PyNlXKubGgGOnrOJo1lFQLQd47kAlhrXZ9DOBV3elH9Lu6IRsLxKJ73SsTFdn/SvZikq/jonuRToErdeqYzz4rt2Gida0BDJfZGGQfhYoWQGTWT1obc3vRWLvkkrTgLP/BDrIcjT3khINTmiB4KEwAyTvF6tuJmJPLroWaNMYnpIUp8U9dRtb+lDd5i2amsC2aTaOCA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a2E7e74Ohj7kuWeFcs6TW5Y0wu8w3p5/yt/yJWciTz+MHHUrPVKm6nzApeV0lt/TVR+N12LYUKEpzhm8N5GydQ1gHnrF28ipkkCFzsN9mGWXtof1FcLqrT88k6djib4+c2Co5KhZ/EXsvLi09jx3bkYjR6cTmp/qKZ2xJGbk5ZvwluOJ4dqWlcIJyc7j1B+rla3bNdc6J+SbO8qDr1tK/EeaJeIGE9lumGd6u0xErcunIBnmIYZKCGzSccKTx3R3ZEwfH9+su8H9QUatMFSjrhZ5XkG1I14LGVWa032YjFw0yRtpludsNxrUF5o3lEpqIMF2duqg60J9eLnsTyXHe76BscA9t4L6cbrfNmK61WwEeHgLE0aXIPxjWmdXTXwYMVmHryFBkctYnkKY29gu8L+vJDNrFnwWNz2yCSIxfjYp9C3JWDzx4ZKX7bp9MM1G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:51:46.8851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d26230b7-4367-43c8-c71d-08ded7c35480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223

On Tue, Jun 30, 2026 at 03:26:00PM -0700, Sean Christopherson wrote:
> Protect writes to disabled_quirks with kvm->lock to ensure KVM doesn't
> clobber state in the unlikely scenario that userspace disables disparate
> quirks from multiple tasks.  More importantly, this will allow wrapping
> accesses with {READ,WRITE}_ONCE without "needing" to also guard the writer
> with a useless and confusing READ_ONCE (since the RMW wouldn't be atomic
> anyways).
> 
> Ideally, KVM would disallow disabling quirks once quirks are "live", but
> that would be a potentially breaking userspace ABI change, and while all
> existing quirks are fully live only after vCPUs have been created, several
> MMU-related quirks, IGNORE_GUEST_PAT and SLOT_ZAP_ALL, are partially live
> at all times.  Because populating MMUs requires a vCPU, the guest-visible
> behavior of IGNORE_GUEST_PAT and SLOT_ZAP_ALL requires a vCPU, but for KVM
> itself, processing the quirk (or not) has functional impact, i.e. for all
> intents and purposes, KVM can't prevent those quirks from being disabled
> after they've been consumed.
> 
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  arch/x86/kvm/x86.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6b9a1b0b1460..74f1d7169218 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3939,7 +3939,9 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  			break;
>  		fallthrough;
>  	case KVM_CAP_DISABLE_QUIRKS:
> +		mutex_lock(&kvm->lock);
>  		kvm->arch.disabled_quirks |= cap->args[0] & kvm_caps.supported_quirks;
> +		mutex_unlock(&kvm->lock);
>  		r = 0;
>  		break;
>  	case KVM_CAP_SPLIT_IRQCHIP: {
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
