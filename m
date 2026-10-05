Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011010.outbound.protection.outlook.com [40.93.194.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF5231839;
	Mon,  5 Oct 2026 05:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179219; cv=fail; b=n5BpIf4wg6MFLewcVbsWfkPY1z1nO1Ql6EOLuxsfFlVs6zNWRCbf+de0Mr9+a7ZV9ZnciH5NCEDBFQIRJVBJCjZj6a+iWEV2rgpzWr7j7SPixVWwX5NH+XWfyViKaXTkGbjF72D+L2/AOQecJcsbViCurNyBgECRUcQetgMPfeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179219; c=relaxed/simple;
	bh=9lj0K+HY1TtHn4/X0jlf8kRaNhRPDIBu4iluzKYgamQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qbrIW8LaJTTNNnEtZ8LY3+//JuoSyrV93JP1IfCyJicpvVhNnmTPHkWCIQdk7Ut96rufw4tdevmKRxage5rMUBS66555BrsLFeAUOspv8AQyaJtyZ9aPRBVRJfLYobZzXFTnWQQ5HH/IcZc/JtOu8R87I5Erwgso6CAv1F6KEAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oRQkjye3; arc=fail smtp.client-ip=40.93.194.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oRQkjye3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENf8ZClzbfIlZA4WXQzldvSvJmLeQpC/ClYR+TPJiEX2k1NKcZ5Hw1UdcThUuz6qM2B03lu4QC2CqtHYgPtf993Zce6h4pozh8yHRfNDyNIWaN+xnOU3Wds2zwjkci8ug0u9z6hKjO/vsUQmLJCkW14dLWI0cZyIj0nYbxEJOAnbYfjjQGExJ0xrjHu+Dw07SFKsVCZEdGWopqF2prpqVhCcmKSP/KFBTUAz7U/zw/EadM+TjyD9247HTPcwYfbSgfpptJYvQB0ssdZx4x49sPBnRW8N2IlDQDUfcQbJtYJHDfNQJSgtrp9zpnObBmcem/1dSjLChufMUOrfiTK23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MoSxWiyAFUxLG2iPB4oyRIK9Q/RCu+p6TLjl3sh4ec=;
 b=MabxBSBy9dTw+B6FKLH4wbi+DeWcVMCoEcSTZ4C3WuuC4Dy8VrbBEQ+u0j15S/2HjAs4JsNTwpHDBz++5Or/B1/lGsW6aQjjEtiYMQFNmyKMGpQbGreU5Zokw2ANRI0LQmbtqu5ml+4481Q9LdPorVNs+V0ppw40inf/Bz9ffe6BsYSj2zOr0HMwSbnJaAWkeNVyrDW9K5hw3zIhS7kf57L3q2WuGr64HTB6BGH26yiyIHTKjAbkKJmudfGGGJql3wqlIWmqRXuykeo4J/F8wxo/dTs36/au/6+FnQxkQFoXZGprau6XQQjVny4mGPsnbSHDfi9KSeCxAKX9jKW4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MoSxWiyAFUxLG2iPB4oyRIK9Q/RCu+p6TLjl3sh4ec=;
 b=oRQkjye3axMuc5EOaiajIw0jS4dsvvU7UELPBja3yr3d0zCDtxzRcvwcDcFWJ3nMzl6tUAxkg+WLkhaPrYV1xVUkI7vnZ/dCqhihgp/pxgLLqcR3tI1UCru9CgTsec/kjed/ooT3e6RNJHQLSZkMcD1p4pS2lwgeJpjkeDO+6M8=
Received: from BN0PR04CA0191.namprd04.prod.outlook.com (2603:10b6:408:e9::16)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 05:46:51 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::92) by BN0PR04CA0191.outlook.office365.com
 (2603:10b6:408:e9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 05:46:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 05:46:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:46:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:46:51 -0500
Received: from [192.168.1.2] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 00:46:47 -0500
Message-ID: <5d149509-e9dd-479b-9a98-60445dc040c0@amd.com>
Date: Mon, 5 Oct 2026 11:16:46 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] KVM: x86: Bus Lock Detect fixes and SVM support
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yosry Ahmed
	<yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>
References: <20260930193634.3415089-1-seanjc@google.com>
 <179097462681.4066567.295128970891612900.b4-ty@b4>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <179097462681.4066567.295128970891612900.b4-ty@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4b8f04-eddf-4ec0-692a-08df22a40e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|4143699003|56012099006|11063799006|10067099003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8vcm1w7mxTWBH3fGZux4N294xSzV1bbhVJmDcAmd7a4TM9uh2d7sJyI508wCJS9F1BZCCx4BCUeNg23Trv6+6mXXLEhgAIoFFbq6V5Q5fpVl37wk8YmBwaNsJdfa8p6aioOhwkvHqg4XLoARRLl5i0Gt+ely/AkZci1eCTWTTgVwBhAyhasqG0A96LlE7yzYnZnot0VJmlbkAxyTWmAOYSnc0Gcgr75IY9ks/xlOHV36/RZFI++pwqLcf8GLp+k0+WgvBvhDGxCDUfZzyKTWR8qudRvwZMXK7Xib5ZEtbck5WUNqdGg7wZ4DVbhY3rEzwutbob7eBB7gbRhBZBsGFNQ1RAGk/Jf4WdbYz8OzksHtNI2gmYi5/FqTD+uzs4Wr32Fmcf8/YGwlpmOwB7rQFAizLEpIC1N2Cs9p3LCUQ7Sb/XrVVpSFEGKa7vzkxfGgQDY5B87QSISP6QFxfLegz1DR/SvEvNdpH8ElGgggGoxxQkn2KRKtEKlb+smdiTveU0YU97U4zx09/XefF5yddLQDI7fUtLPu7F0fyxgdftUVlG2qvpVLgN8fmUDXAgro+pHMjH8gqNTzXud3V/kbDdqghsnLJpmX/wRD6tFpR90m2+JhSpak6x/7clYFJC6quWWr2p/4oO5P2t2vkKWWHd7FaAn2sUuckAgs7UhER6+K/Jnl2ZL9m38c6/mqm8TLFkMSiHBfaUYUVB4KcHoiWw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GKxh/0NwrNgFvMFk9pLT8Ngddynzl1zMIlTwwj1RBsqulP6ig28qa7XKTAJAuSIduhi0+dNCuguzQRYwqWADxQTuIjnCliYRFp8Qs2zrY8zhtNDMorXZ3epawiGL9vElYvwzkimqHqC3uye4kOA/lp2gtNmON9JbTjO0WIAozdW7BcJ2YVFPwBdX5DwIpZxRfjMU4vJjDNCjaaPGykLihazpq0OW9O7t7HavG0wu4WITR9MjZcJQtjn5hUZYCVk1BkQpoCNDJeeS4OMOD5IuIvC1YAF1SPiTckIUFX3fnnrgU+KaqmnFO0lXEY1y6FI7D0qCuPXRbrFAV8eIZanSIg+O0+ZCreHhwOx6mx5Xk9tjTdAEsCWULk3WTBhaPLz6GIqo2CSKnyzQDVZjMG3Qr1yBOZCz8cCUN2GGDwVH19/7hVsFuni77euzHi9K2+NF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 05:46:51.6529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4b8f04-eddf-4ec0-692a-08df22a40e21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309



On 03-10-26 02:37, Sean Christopherson wrote:
> On Wed, 30 Sep 2026 12:36:22 -0700, Sean Christopherson wrote:
>> Fix KVM's handling of DR6.BLD, and add support for virtualizing BLD on SVM.
>> KUT tests: https://lore.kernel.org/all/20260925230003.2362261-1-seanjc@google.com
>>
>> v6:
>>  - Throw in the towel, at least for now, on WARNing if KVM sees a DR6 without
>>    all of the fixed-1 bits set. [Sashiko]
>>
>> [...]
> 
> Applied to kvm-x86 misc, thanks!

Thanks a lot, Sean, for taking this over, merging it, and adding the KUT
coverage along the way. Thanks also to Ravi for the original patch, and to
Yosry, Nikunj and Tom for the reviews.

-Shivansh

