Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794900334;
	b=rl48byphlHD5ZSjuTJAdIAQeIE7L861DjuEIDRsn7GgFBMOBYh/mtn4LBKGCgU1Bwq+8
	 taua8/QrE3vJ8s1jBATqRkIfMPNCZqVeJ1TwmBG7t6OHMfKZP4qHPhO3nEb3DFe+262rV
	 Nm310iHPRYs+UxNw0dAFbHj8hGB838E+scCoLblZZVEHZKiPK1/9wCUt9BLQjvPTRdYC9
	 JyAOqvSlOUtMLAHF0/V0hociV6+Bmimjp6D1jel/ZH4US+Ci7Halg9NegKrdhXFXmdu+z
	 pxJRfwrokwZGsLxDgKXghrl4cYSRsMXp0hYDxv5eiOZsCabm2smu5kxszby44rdKnoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900334;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KRx6HHZFMN916V0dprcQvG6/STP443OYep9LaExbmjo=;
	b=OfzIFQq/rugQphGMnRm0/leQx7KxMUfv+8k5lkcVcbxQEr/+QrCpcr7cc2c6KJbF+1RR
	 C3zsVImnlUu0ULWn9oJzSbLhxSwM3eKhF6L9gilU29M0bcMEeKHdgp8+fl3AUleIRHJAc
	 BU9ZINRZFME7fl7kKjQNUYPaWW2zpNjVLLihRB1rA+QK2IbrL1Ch3aDZd8zVcn0kaqb2D
	 UZNNPTb4pLI13ubL7FfPQkWcvkUmC2QLP/11MtDGgOmH71oj0zq4Zuun8EjbHE/F0077I
	 LZ6TOxumOSWOUTQxWm7QhXY8p7eANa/ID8+oHA5sjrkL4ArFsr7jh3+vD1zsG2huUZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=By5UqhBX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.7
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D3606A31C;
	Tue, 17 Nov 2026 07:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D2D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=By5UqhBX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUvhC80Lx+T1NhxNGcFVCnqDAAqr8ssTnAskSkUNQiHovikjdg/xizLkuu9H1zs/9YImIoLyHO18xL+Mh+JGllJn/ukgyfCnm5QGZ4ioZJMdAdVic422QXSjLsXa2wfRAS61e/mmDW1P4CNVAEnHktS7SMQe1+uvlokq7+ebn4YpW6KzZzW4u/5RZvc7v3tusOAbn3lxVaemjGlSkixG3dwdDbpnAF9uz80r+ZEpI4xdUCdo6XXo0y+TKbgUMYfEjo6CnPjkqzlc6mUw6xraJ8/MVCB0jV0/097eQV+/ntabwTwyGzRpUCUbYE/6DjoNGxwMEqbosqqzs9+AfiQUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRx6HHZFMN916V0dprcQvG6/STP443OYep9LaExbmjo=;
 b=txgohodByEki1UCF88Jtsmfg3qkTLh7xJKaUsNH6EEJwU2VVaAQLaX+Q8+Eb8uipy0SccoOSjgkzaYepe6ByDe+RwKcOsX62Sok0fvY1OxJras0LuHgnWKsTmZgELAxsVbILgiVSLQzSA4GyYQZsAQqniw9dUZj5OYSQV9FvKpwpDkiqhgVF9DELqY/uNo/JtUXz01UO8PrtUXeV7x+z9uHTy0V3ptGqx2Xqbe4yN9iFSe7ciT4Smsj7iNRjdaqBaUqii9+x+SqscItwah3JsrDD78B+jFwjeIy1NjgkQcTYl4ovEn7/aVX4vCrGcP0EUno4R5FQVvuSWL/wWk9F9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRx6HHZFMN916V0dprcQvG6/STP443OYep9LaExbmjo=;
 b=By5UqhBXFlx0lv57DGpVIHofE5yvJtmAG1QTHVXQBTj5T9RkYfngw0dLbteZVuoUYlqoJLkT3P+tsWMndayYOYNFwj9SUjKUxmAZokwSr4VuTak9YgZw1NqrPPuSsFLXqOWiSJ2lHUntEtfD4RE+RryP3kP7F26tjGZea6AV9o8=
Received: from BN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:e4::24)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 07:25:28 +0000
Received: from BN3PEPF00022BCE.namprd03.prod.outlook.com
 (2603:10b6:408:e4:cafe::1e) by BN0PR02CA0019.outlook.office365.com
 (2603:10b6:408:e4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 07:25:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BCE.mail.protection.outlook.com (10.167.248.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 07:25:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:25:28 -0600
Received: from [192.168.29.217] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 01:25:23 -0600
Message-ID: <41a0fa08-9787-4a7f-85ee-46941c296070@amd.com>
Date: Tue, 17 Nov 2026 12:55:17 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: nSVM: Check full nested state size before writing
 to user buffer
To: Priyanka Mani <priyankamani2100@gmail.com>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Dan Carpenter <dan@pereq.eu>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>
References: <75b8ccd5e278ce8f13bedeceb196f5b4ee9c5256.1794545500.git.priyankamani2100@gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <75b8ccd5e278ce8f13bedeceb196f5b4ee9c5256.1794545500.git.priyankamani2100@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCE:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 139cbd0c-3e03-4571-88ef-08df447bf4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|82310400026|1800799024|36860700016|376014|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|56012099006|11063799006|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	k1weGREViFg/NJBzWULB2S/RTXf831H7Eef7t7hqrmG6HjWbxl1avBjhQK98stqZrzjtx+DAY1LeCacgoPsMyNVofEIj1JiQtYAMiw8SmI//49ufLYEp/GGAg25vLn0GpetE9cgsOlRLlCipsFZ8JcrLETo7zhpX+0XVyXRNd9VBrpldOw6LIRKx17WbC95I+m45CDPRkZTrUEiO9aLPUawj9mn79nOwELaxAYCNkfq1AUdTJxpRqhqKrZ4XqcNKg+pA7qcPGPgQImIkjLTGex5Y0KmuBnQiy8G69RAh9N+pLfRGXDEXRTKXakVH8rl1+sdtzMUQHINX7N2pIYVrry9gzDcH/HLw+cnzYjnFMA+m7etpfOU/57LIShnO41PoJWZdUPzBwX8LWfL3bqx3dP44lvLOfITrY7OFHbKO+tpQEPQC1zzeHGkRo7SqMXhJSB2BGU0xghE02F2uZFGMhWS/tX5gNg5u1VCpyTR6Xc+JLORfqUVO7zrxG3xfXBbqvGxv4UQecvNPH7/2uZUwmnzDba0ENK3CSIWQydnTaWgKDRj0SWA9agtMIt3c5xeRS9Zj885T3hxV8lS7kAbttaz28/tEq4Kz4KelFhcCkDSB9XyviHk0G4lJD9gpQ2uLveVpydgbwVb9hChJXFewWCYVwdJih3EUXJgtcaobM797rEu8OvGZu9AlBqvKYkHgYKGAU1XMUwkNcvYI6KdKOA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(82310400026)(1800799024)(36860700016)(376014)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gqZiz3YzkoMxY7/B/oIUukMU1zteuLE16VKtgkIvpzgQk6k7SaitCM3dnRWq4s7tiSUZ8cLZ1LtIadP3uW5qy7hmTFHCDQQBmtvyYhL8HKZe3yN4UpP5zDHM2kvcPrhh1z0/MBVnUiZORz7oL6FU2fuohzdCH7Q2MxpldH0foq5Trx6/Cs8WrWilcja3+UgtBDTyw8qGAXO4M6C0ijovDGx/OJ8oSY+bOJZqc5T8/ROzcKM72skOoAbsucGdCaWdLF6g6sH/N/2i9Ty2+U6q43LfwCUVdXrp3UeIymHlCLt5YQUIILq23ijJ7Y/zKHQjAYHSSTsa5fB2Hgj6f5C56hEuXTykK06XozdYu4FGsBePlpZmQQ14lq+WdVWnQLmgH01GZI+pw8WxXae0WHggbjRIZwh1gG2Tkh132yEOYpnknJrzjQQmnbvH8xJjdtGE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:25:28.7143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 139cbd0c-3e03-4571-88ef-08df447bf4bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763

On 13-11-26 10:31, Priyanka Mani wrote:
> svm_get_nested_state() compares the userspace-provided buffer size against
> kvm_state.size before adding KVM_STATE_NESTED_SVM_VMCB_SIZE for a vCPU that
> is in guest mode.  When L2 is active and userspace passes a size that is
> large enough for the header but too small for the vmcb12 payload, KVM thus
> skips the early exit, copies out the header, clears and fills the full 4KiB
> vmcb12 area past the end of the buffer described by userspace, and only
> then does the caller notice that the returned size is larger than the
> provided one and fail with -E2BIG.
> 
> As a result, KVM writes up to 4KiB beyond the buffer userspace said it
> has, and if that memory isn't mapped, the ioctl fails with -EFAULT instead
> of the documented -E2BIG without reporting the required size.
> 
> Move the size check to immediately before the first copy_to_user(), after
> the header, including kvm_state.size, has been fully filled in, so that a
> too-small buffer is rejected without writing anything to it, and so that
> any future additions to the size are automatically covered by the check.

Tested the patch by passing various values in user_data_size (0, 127,
128, 129, 4223 and 4224) while L2 is active. Now it only updates the
size field and returns -E2BIG for every too-small buffer, and succeeds
with the full 4224 bytes.

Tested-by: Shivansh Dhiman <shivansh.dhiman@amd.com>

Thanks,
Shivansh
