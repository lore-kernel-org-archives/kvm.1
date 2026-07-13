Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844FA17A300
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925256; cv=fail; b=MgzklKkIZbT7jVPrXXjmzr5bI3K7evvUZULsANVJjppmmdJNxiOHV31RMAAS2shdlHWLlrTpg3JLm0hC1H899WmzGOrK7X4vm165ce4Tw2H63EoD9A38mVXewD4CFA9QJ6Qw3jiNhZMRS75tuuquJwhW/iIwj5+MYf4LLaxb3rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925256; c=relaxed/simple;
	bh=+fWYPObcPhKak9Z6by9Pc6XxsZ2HENOabkLCoFsUPAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uMZpAJ1qZ/Eag/qxoFtPMtA9xB2mJUvH+4eHHMJWb2xFNhUJ+IEXsTKvzdcqI8Y2EqkdAPaCZiEA4OxwPIXXJR+rUMGdYhvXM1dhA/+myxFgE1donKg5lrKUg/EiM2KWcL0BENthLvJPU6UE9zT6lad3XhcZcwEdkFNDH04oOxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DEagfobN; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DEagfobN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7HqZJcIH4s7EBKOLUteMu2Jeb6Ip/G+p0H8GIOsxadMwM3UAUK9xPwMxo1EMjrKv5QPdRdYfrom+8+TMyLjgmgz0eYyJjXO62Y7cXXbd/aBqMe+xF7nD7dNxbiiwsgwzDEe20fxKCUp5lvlO3dL+Ut2ORRJI/fbK2g5eHBLE9o3uX+LXG9de1DtEj1m5LToW3WXk2vN3qg9MnNkbDqPwo5iyYl9cX9+DrqGXDZ/8KSXuJLDID11IZT3VYpcjaPUzqQi9L54A7BoTR7yT9iP9eU+Qg8ZGhJuEdR4kDPiCihfBT4ZgvU21hkgDx52KtRYsis0VtTTyLBAImQ3+sUqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQ/NAPVxYmuFqNcaynhLkp7K+3+fL34Y9iWy5h2ZYhs=;
 b=owhvjTRgU8ZS9w9Wizfarth0uTs8pnL0xFqHrj7GbtdHpo8yfov/a5Dc4KITm4ma68exjwHUdFveICMD2G9kGdBgFQoVNylEvfyFvz0vCnzCqy1S7IGBHZODe7/JpqvGJkuG9vCnwrZgthG99m3oFLdA3q4+3OzXivITqs1zx5Kw0R76cdiZ7oVrx9n00S4A9eq6vZhc5xVVqqdhCw2wO01VzJVh0vLstlAyFFn5JQbH0g1a7zANY0AkoTu4zDnz5tm4iQOl9pHwc5A7lpo5oNdsf/Lor4yQqcOl8TK9wUvTgAwsDH9g7gRscLgji4IIPvCt2Va8LvKqqr5FQZFFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQ/NAPVxYmuFqNcaynhLkp7K+3+fL34Y9iWy5h2ZYhs=;
 b=DEagfobNJMeB7yUe5suhBUsrYe1jATyi2bdxQ0fJJxZAn/BOE9KnliTcijmeq9FrUisRdkPdCHBLzAs0rUidi34//U8Vsb6dzZmQkv6EywMRhhJfmnPHvyCoCzW2DpzgcXGRi6wCjFbv+k179ydxBdedWXlGBLsRWXnAB5aXi4E=
Received: from MW4PR04CA0364.namprd04.prod.outlook.com (2603:10b6:303:81::9)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 06:47:30 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::a5) by MW4PR04CA0364.outlook.office365.com
 (2603:10b6:303:81::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 06:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 06:47:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 01:47:28 -0500
Received: from [10.136.45.190] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 01:47:27 -0500
Message-ID: <6df492f7-fd8e-4f07-97a5-66620ba0abb2@amd.com>
Date: Mon, 13 Jul 2026 12:17:26 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] KVM: nSVM: Sanitize nested DR6 using
 kvm_dr6_fixed()
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-4-shivansh.dhiman@amd.com>
 <20260709085100.C04BC1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260709085100.C04BC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: ecaaf19e-6159-473b-3736-08dee0aa9bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	eC1r9Era9lwb+W7WGMV8ZJXaE8s8CDsRCVQT0XYJ5SYDvQyra1Krf/L4F/b5Js8RsA+dqsReNeA4K3N6nFyOX+8xVVxDmpXgvtO6o0kdUFUedL/l7LUiE+ZvI+YvASIgulHJabQ/nSo8YZagOSL8myoPpWu3ueO3u6tgdJ3aRyUqyn7TzjLC+VgVJA+wYxf+jq/w3SHh7iEKYGbjvqETYck2WVXqjIIpDdo7b2ZcoTqOGONVVAJZIG4QlpH04ZJMQwFt9LIecgA4K13TBQdzYBXNxb/PAurguUpAjKQ7J8HZ7rNBCvfomniv2xx8mI6T/ZqfG8T52lglORiveNM1r+cuyQL7nMYCO6wtLhjQrKynxkxO7+aEZMJfq3e+BG+u+U+aoCFQc6XaUmTL2Jqg0ryyUx2i6VT5vEeyfc98D+bPjHn6ZGWGE8+TQs0j3aV4Owxk4rPOAhkLs2M0ZB+0I7lCXq8b+RYhu6qpVkUYYSeUMIUn2ZESRo5Acc3szch2rbuNVcD3YUvC6kAbaDKTfDBIYLjFxlzg67VLwK1lcR9yOqVZ4UKvQUc1egmgTIkak1bzgltJKP1lDcgtxKKQMk4QIJiJErz/8/lz/R6eTN4QefQcu8DmveP2iETby9QU5Da1z/d2nb2QQFD5yTj5DQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(4143699003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UMMd3LzlAfZNPzqCugwVBYUVH0XeDtFueA3L9aeaw0ayHTNlP9hvWHdAxWuxmuLWQ+Y5vNRZB46rPSCYdUNZR5GPu34wv3fvYhPDsPfPSitfFQvVPJltItjN8mosu4vV75YxdGT38lz41PtJIGoqLH1Movmv7OniCCvGMxrJL5TwLBaa+tyiaIL4E30gOWAqB0IkORujqlm+Av/5Wy6vOs88ZYtiRMnRgCeZlmm5cJDxBM1UbivFFjNq4jW9fPiixZxSbUBJVQDH0q/+CtFcu5U7pjiymMccavoO/I+69bcz3LI3tjXSqVb065gNow/FPOqw6R/JDuZI/Yzw64hQZS5UX26morjT9wmSWgDfHFv1x4Rj4Z/kFc23xRaDYIXWJQTFDdFFGLJdzztKeDqZJVe8XbCsZ604xIyWcoKEUYpqbMnL/9C+9fgJvCGeH7WD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 06:47:29.3127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaaf19e-6159-473b-3736-08dee0aa9bb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254



On 09-07-26 14:21, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch identifies that DR6_ACTIVE_LOW unconditionally sets DR6_BUS_LOCK (bit 11) to 1, and replaces it with kvm_dr6_fixed() in nested VMCB02 preparation. However, the patch fails to replace DR6_ACTIVE_LOW in L1 vCPU initialization and #DB payload processing paths, completely breaking Bus Lock Detect for L1 guests.
> --
> 
> --- Patch [3]: [PATCH v3 3/5] KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed() ---
> commit 0ee3ae36939ed695ccbd636580058ad35113add9
> Author: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()
> 
> When preparing vmcb02 for nested VMRUN, KVM ORs DR6_ACTIVE_LOW into the
> guest DR6 to force the fixed bits to 1. DR6_ACTIVE_LOW forces bit 11
> (DR6_BUS_LOCK) to 1 unconditionally.
> 
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index 84248e6665cfe..0a9e28a02692e 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -811,7 +811,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
>>
>>       if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
>>               vmcb02->save.dr7 = svm->nested.save.dr7 | DR7_FIXED_1;
>> -             svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_ACTIVE_LOW;
>> +             svm->vcpu.arch.dr6  = svm->nested.save.dr6 | kvm_dr6_fixed(vcpu);
> 
> [Severity: High]
> This is a pre-existing issue, but since this patch correctly identifies that
> DR6_ACTIVE_LOW unconditionally forces bit 11 (DR6_BUS_LOCK) to 1, should
> DR6_ACTIVE_LOW also be replaced in the L1 vCPU initialization and #DB payload
> processing paths?
> 
> Currently, DR6_ACTIVE_LOW is still used to initialize L1's dr6:
> 
> arch/x86/kvm/x86.c:kvm_vcpu_reset() {
>     ...
>     vcpu->arch.dr6 = DR6_ACTIVE_LOW;
>     ...
> }
> 
> It is also used as a flip mask when KVM translates the exception payload to
> guest DR6. Because Bus Lock Detect is actually active-high, XORing it with

This looks like a false positive issue, since Bus Lock Detect is active-low.
Meaning if DR6.BLD=0, then it indicates that a Bus Lock has been triggered.
See APM 24593—Rev. 3.43 13.1.1.3:

	Bus Lock Detected (BLD)—Bit 11. The processor clears this bit if
	#DB was generated due to a bus lock.

> DR6_ACTIVE_LOW incorrectly inverts the bus lock bit the guest sees:
> 
> arch/x86/kvm/x86.c:kvm_deliver_exception_payload() {
>     ...
>     vcpu->arch.dr6 ^= ex->payload & DR6_ACTIVE_LOW;
>     ...
> }
> 
> Similarly, SVM constructs the #DB payload by XORing the hardware exit DR6
> with DR6_ACTIVE_LOW:
> 
> arch/x86/kvm/svm/svm.c:db_interception() {
>     ...
>     u32 payload = svm->vmcb->save.dr6 ^ DR6_ACTIVE_LOW;
>     ...
> }
> 
> Could this leave Bus Lock Detect functionally broken for L1 guests by causing
> them to observe corrupted hardware state (false positives or false negatives
> for bus locks)?
> 
>>               vmcb_mark_dirty(vmcb02, VMCB_DR);
>>       }
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709082953.69434-1-shivansh.dhiman@amd.com?part=3

