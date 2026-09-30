Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A3B497B7B;
	Wed, 30 Sep 2026 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812014; cv=fail; b=V6iGjjVNqz06iFCHuIZUjHp5D21RWlUuofZ1+g4tB72Yh7qfa6W2eJgkEg4/2Cef7OZfC3KqceMtwS3/bTR0XVVRYz+RO0IRVI9Fk384+PyouqjcXv9s8Gu/OAmUEVoZfFm9zypanBD9TRS9ZLCVgVZezJY+IkJPEcXcrliA3t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812014; c=relaxed/simple;
	bh=J3QPaJkLuwtiJgXPhO7DMNhzOI+TkmIhRPW5NKcF9IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NMEyqt9rUJiQ2RqOTllD37ZkHFlqCHlLENgR3wYMljpfDmILGPbWspC9gS8NudkiQigbcdjKnTMjSROLg9o5elfhNPCoVsCG7ElT70CJduugfHKH/+gqdv/fYjkDhlTeVjRYTivmzWu6lPwl7uJLQMq7IxiNu2Vlifd6xvPyXbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bd/FWitb; arc=fail smtp.client-ip=52.101.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bd/FWitb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJiMjav0f1mjOc33o4nzzMvTB0mIWYQqxke774I72mVUGeBvBV1kbzRr41kEwXU1KA5cYC8ZkvjeFm6Ojh4yCatUwNLBoUu95ASSD4jAiDv7RXlwlBT3NwR3Y070+2zO23J4My1Zbxzs3xTja7tY9UYg8OP9OZaz7H38z2lxhQLXPPWIYyjrmX6pKCh8iT4wdzP7WB6Zye9I2LZ/Egph5AD+wbwsKIGjMYlGReP3T6mcsPbvFBHfMGp1dal2gTw92mYGhVsfpTlc8tEsUy1B3PH45KlggdML34cNrF+0gt3GVrSsbC3IwCXl0OPeAb9eBZnxGUQn6fOSneHjXYpQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHEweDqe05ll9w58JUKdjSZmhi8cbpullj1XbvgbQn8=;
 b=bt2XqyQ6oe1Ml6coIjch8K78eUtypuS7jrd4Z1K0zvryGRya2/jgtYph5sHpDFoCDMzCJFaIhmcviRj9Vj0yLWnMVzGJCACGHn3YHDlwNttM2vMMrck4AcFBY3v+32Jbw1pg0A+49YitCqTjTCTs4vRPGuAaQmQuAiPi7HrKE7cNo+Il8/iShcRmwF+J3bgB1d9JXsm8XXsnlDKmJtZHhh5X4s6K9ljXlGgTWehkxZJ+GfOiycv+gQDod3n5NGSSVYVF7c/b7ON5NrRH2VYPAomTEAK9DDrlta8o8SIHqo7lqI2BFhR+4iRePW55zlt5H4hstUydunOyqQUlK15HOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHEweDqe05ll9w58JUKdjSZmhi8cbpullj1XbvgbQn8=;
 b=Bd/FWitb4iRecCgs2LACytOCTO0ESmdQkdPBvTVys5H73zOPB6L093jcdVqr0HeYniJqIPeluHOBK5IRRvD3JyTh1mO1MkScDrJRlpKG9CzYMzNwKPDHSdD8RWnPy8PssruYdLUIidD5PVkfHwc7H2zEb6zgPknPUVAW/G528I0=
Received: from PH7P220CA0052.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::34)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 23:46:41 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::94) by PH7P220CA0052.outlook.office365.com
 (2603:10b6:510:32b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 23:46:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 23:46:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 18:46:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 18:46:40 -0500
Received: from [192.168.1.13] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 18:46:37 -0500
Message-ID: <52f72fb5-d472-4800-856e-1157be67487d@amd.com>
Date: Thu, 1 Oct 2026 05:16:36 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/12] KVM: x86: Preserve DR6.BLD (Bus Lock Detect)
 when delivering #DB payload
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yosry Ahmed
	<yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>
References: <20260930193634.3415089-1-seanjc@google.com>
 <20260930193634.3415089-2-seanjc@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260930193634.3415089-2-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 198040da-b486-47c4-ab28-08df1f4d1370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	TNW5wRVOncnITZjKC/hXzCuOST9lWXrirHmmpaWQZHoxLiLDs80QU9UfPaRV+98ZQATkklHZpGsXd2l6TiItlXosZ6zUPGOj1SSSNeZvMr/lB3IuD3OWMIIUaHNOYiNXNzQ3TumfYz8Np1oqhFlgJ5Y6GLEj8+abhllNKZ8sC6RtLxWYcwInlVGmkfgatgndN0sG/OxB+yaQcxumlGLEGugsaYZYT2bFsqAtrX/hxaEMzUXJ5AqQ6n3iCIlsJGUjkQlFGop/vP8gwU/r0p4RDdRL2w7zwuJbQKNT2fcSKTgkSDISIFXQEtE1dCOWpBAibxQ6TsPfdJt6125lkkwhnFt8zANwMuMatXT+of9rHV36VABntiY0MOfyXneqKR+8/iM6Hw7qJ1cQ75FdDZwYAd2Zxx6qwg50MOAIeH9iDc+qhs0741MZMgx9+mIeNnghkQrRLWatlr7wo2R3hmlpMMVnaml2/yvQjkKy2X5jfwRuzy6Sft2mjRPJH/47YqSqSvj3GbX8OdN4j7VF2Svd6YM8pPB7iuTEXbiKVfe7fU9y53BWeSHCx4aC/htCcja1Kvm6/rCE0cI3CD5Q+qSZkoX8XCep0Sn1iD+2D0CmyYdJ+MzV2OgOSTaCvTbcqbhn376O7qnv8wpJXOJ4MeD3eIghqnyFzz8i7QyBKouBPTP0cuZQZzur6Z0OVKKaBOGPcNDEmnQlrhonUwZOwFwd0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5XmCojdmO+OyDPK/BHIr2pcumrqIMOqRFnWg/Mk5eqHilnkHZV+i0W4OPFxeUXNAwsy/vsdRC1FPTslkQjluI4QA7E8V06OGaPnkh0fEnOK0JP8fU8e/o6KK8U1EKb2A4A0uTD8Qrf3hzuFI1NkTBGW7mmhmylNgbsHH6O9iPc+WTdaUbbYQt1ozsjfjmTiJbgekFWxfqRJ3+50B17g9pPPHqhsMmrNSIupTCwyU3nlZKjk4TX+4bZG0gaBzCSL9b24Hz7Q5JrtOwnaXsohKYAMB7r5mMMZXLJ13Xffm1OkaUcOzzNhOmZKcmjgUCwZGq72GJd7bqAj8U29fKiICdWmpwnKAr+/fQDnN+2Ky/BYgfSP5upZPDkQG+KQ9+rYAfZC6iYkLV7fe2hpBD5t6akC7dk4sjS9IFQzfNOZ7tC/tyKdjkYce7EeZtOBHQfz8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:46:40.8375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 198040da-b486-47c4-ab28-08df1f4d1370
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094



On 01-10-26 01:06, Sean Christopherson wrote:
> Preserve Bus Lock Detect if it isn't present in the payload.  Unlike RTM,
> which is explicitly modified on every #DB,  DR6.BLD is modified if and only
> if the #DB is due to a (coincident) Bus Lock Detect.
> 
> Per Intel's SDM:
> 
>   Other debug exceptions do not modify this bit.
> 
> And AMD's APM
> 
>   All other #DB exceptions leave DR6[BLD] unmodified,
> 
> Restore the explicit RTM handling that was clobbered by commit
> 9a3ecd5e2aa1 ("KVM: X86: Rename DR6_INIT to DR6_ACTIVE_LOW"), as the
> semantics of any given bit are feature specific, i.e. are obviously not
> consistent for active-high versus active-low.  In other words, while the
> bug was technically introduced when support for Bus Lock Detect was added,
> it's really that attempt to genericize handling of active-low bits that set
> KVM up to fail.
> 
> Fixes: e8ea85fb280e ("KVM: X86: Add support for the emulation of DR6_BUS_LOCK bit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Tested on Turin with Bus Lock Detect enabled in both L1 and L2 guests. The
expected bus lock warnings show up in dmesg. Also, all the KUT tests pass
with Sean's KUT patches applied.

Tested-by: Shivansh Dhiman <shivansh.dhiman@amd.com>


