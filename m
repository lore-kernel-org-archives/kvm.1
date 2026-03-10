Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DA739C00F;
	Tue, 10 Mar 2026 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158206; cv=fail; b=QNntzayIJfMfr0RBN9tlRXoRCf/D5GceVEh70oV0CTJyAF96GOfiKygtaSRDTAMhSpgzI6KCcbwH9swuiKNh/VfhfiQH3hPvkMqWY6zFViH2k1iHNCnpOjdiSH5dtjOqCQrpbXZeu5alIMN/VwLV3WcEDBXm2/4lDEbGTOUf5pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158206; c=relaxed/simple;
	bh=rL8PhQpDzdJUvfnace33enK63LIRquVEtxBeFby8+0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ckSxzvOGVgNxUL/aVo8kQZJRZjn2ZjxVya2+OtChMGpTIlHNrJ5PILaGLJ6XRJV8ktIG4pTks2xr9ffS96b46SfUJ/lY2F6mN+KqsK/rM7WHSDiOFy6D8Ayo1u7BbP35C/tUbQn7w8ubyI8kBIMG5cS8PDaw46yutli92P7mOPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZjsqXo04; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZjsqXo04"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/sNfCrQvW6Zmd5OWgdTtyTmewwACJnyxu1Zuz9AbTVkZMGx8/A3sEkSOwMqpCF6oj5QnpBL4RnEt6S7lGIQ8fHi5JslL6sVtQvNkPc/Cs0xu0JfQu0ZlUoICyk+gDvkoI/A9H97ObIzENe020zTBGB0K1t43Gt5I+/LUVoMXp357GSgETylGJRNdPUFGLgoJIT01WsZ2x3ZnS5OEinSdHPqnLspoQzSkJ0nTFGmDF0n7PZ7xA0zF0Ruxth7fV0n2FWIKpoTKUQdnc2UUXY18ulISXSgoVuy+wrFYdJSOMiMGg92H664rgK47wwWBd9Ly7vTJL4O9sbNiS43lLSH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjK41hxYWuKP9ZwuwSGPeP5Bu3aHjavzVQorhEUNt78=;
 b=TCZVZU2NM3KAhJDZ2CFvYa6ll8czPdrmFFUaCtsLCGDfvgX/eFc+MA1UmbkCNlmym5gC8CZAm0sMqZGJbOfq9MqSPTUTtVPhqp0Ok6/ulL+jM9ikAK3giH8nTRGTo9XubfNkirhUzJciSypRhHNhvZpluigSBCvgluRzPxQL2/063p7rZ30mqIevtBL8Y4LelEvoDB6WENYcwXJO5kgqO3WvxLEnn+SgMmTbznLEulFAdM9rDleV6WHzrrNjF4bA74xPiUXTMRu+UN2/aiCRGW/Frl5Oohs8F0fnKh/nSrxeMkuuYqNKGksrfp3guvsN4J6wnEOFVM28h7vGIsQIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjK41hxYWuKP9ZwuwSGPeP5Bu3aHjavzVQorhEUNt78=;
 b=ZjsqXo04BVQjPDM6ESH9GHPFbHNJmmlLOZB1e4emYET9ayQbEl3wt6EbsvoWfGiH4P3+jgoPaEon0Ot4jfeq5F/xSwlE/TpYf57/llLgB6yMAXFLUCO8cz1PipMwcjlPBopFRAOXMxRumLpPWKIT44AXG5s4xRbJNqHQ+zwjmyo=
Received: from DS7PR03CA0241.namprd03.prod.outlook.com (2603:10b6:5:3b3::6) by
 IA0PPFFEC453979.namprd12.prod.outlook.com (2603:10b6:20f:fc04::beb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Tue, 10 Mar
 2026 15:56:36 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:3b3:cafe::db) by DS7PR03CA0241.outlook.office365.com
 (2603:10b6:5:3b3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 15:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Tue, 10 Mar 2026 15:56:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Mar
 2026 10:56:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Mar
 2026 10:56:35 -0500
Received: from [10.143.207.7] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 10:56:29 -0500
Message-ID: <948e099c-ae1c-4586-8aa8-ff4946f47e18@amd.com>
Date: Tue, 10 Mar 2026 21:26:28 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] KVM: SVM: Support FRED nested exception injection
To: Sean Christopherson <seanjc@google.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
CC: <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <xin@zytor.com>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-6-shivansh.dhiman@amd.com>
 <aauIc-wOXr__Qn1u@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <aauIc-wOXr__Qn1u@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: shivansh.dhiman@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|IA0PPFFEC453979:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4ef1aa-92fc-4913-4817-08de7ebd9ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ja75dxAPt92VU+djoEWjD+2MaXXMdIphRvu++byJUxlf9hxSrkTJIgzZzXm48N0WmslM2Rj7ZUqnF2kufFyPHYwgvhwMfWEGuKG/ygCAcMLJvxw8nu/wELBbfKsYbPjGTBpbZwFd81yqeAZFo1XiK+Mq+cTkqDMnx2qsC3spxKvnqNuouMbvJCAqL/mjLC8qvkaBDt+vN855UAeHEZ9acy/4yIjjH06dCIXs4gDcq/hINBkz0EQb1enUjdpLVZtrWKin6BqNUf5ELbIWwMke6gR9gb4E5QvPhvhU3bmJvIUfq5qc3H+UMgKRlwUm5utRVQXCNSgCps2O+CvaEQo5KXBcZDkHRF0GNN9P4heli7xkugg73/xHLfWAF86OLDgDfmjLISQEl57aPRgZsLnEIp2SYQGbdpwud96OtBVUdwcDTY4VqPU3THPZZRKRLqIWPAzs4lR6pgzalu+T8JWaeP4znqiPbHQiut9qx7e+xPgxAHWjXl1gdhK2cF8gEQsOBkChHzyMihUyP3MnKkGHFR4nwUAF2NIJTh9p/qDOPnycl6wof5NF8Ub7M7vgqFuQ9EliJVnD/6LgDg2TfTchK8nF+xczv2NGqyeF+hTmZzC6XWxUkC4sxhLKcr4BrE1cXhHLfbVqwBfcYPpM6kPmvHAX6yB2mgYrRlv4ccwAsbRaLgrre53m0T/4zzG414W9XQAkx4S7BDG04wp+I8CieqnnA448K41LuFbDFvoOG0kyXBpelKXhrUqvoyNqu2aeRX405IK1NQBkC7zX5CoEvg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GpuSjUjLNKhkWivnXhRvmWIrnT52WWLwpBIqDRqa3eW9I+0m/aBYEEF6X7/7F1TPYOHJ0KkcuMswEB7BB3lmJLv26lKConYr5grzVpxf8zGGdxBfGZQySHRdmc1f3u0/lzC1PQTmTnA2DQJTPjeD3HkjtzNczShqzwYdNoV6CcvNnAHAoL8eXvCxwRbCex6TrSp0qHMD8Eb07RyvV821q79hrsuxwIi6pcb5LJqPDaFx7xRAnppqyZppc8dTlgvZjvQu3OjhrjynVOFfhBtfQeAqdDcwUDKqZxfTI7Y4h7fJf2Yb2ZBwMtSX1GtUu0ojDsiZrDrg2NSrPlk7oRaLhLIQPpZpENxwvw2Z05fuj1l2ccH68aNzRnu7arB383bTw1uu+tiuQOTCJVl9e3O9+VieuOK99nDKanl0Lf3x/oG+O3ra0ZHsJitJoZ6t41qC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 15:56:35.7854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4ef1aa-92fc-4913-4817-08de7ebd9ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979


On 07-03-2026 07:37, Sean Christopherson wrote:
> On Thu, Jan 29, 2026, Shivansh Dhiman wrote:
>> @@ -363,6 +363,7 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvm_queued_exception *ex = &vcpu->arch.exception;
>>  	struct vcpu_svm *svm = to_svm(vcpu);
>> +	bool nested = is_fred_enabled(vcpu) && ex->nested;
> 
> Reverse fir-tree please (swap this with the line above it).  Similar to my comment
> on the VMX series, us is_nested to avoid shadowing the global nested.

Sure. Adding is_nested() helper should be a better choice. Will do that in v2.

- Shivansh
