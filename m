Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E73CAA3C
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625372; cv=fail; b=Z7+Cakfptest/QOrZ2IoB9NlqazfdIddNG56c1+KQHQZjy1LwXky8ma4UXoGU4MctVj7qOPX6ceXhWYxtjE0eBaeseDglXPbJm3SWJZjabO4MUuP8U7Seempbof9LO2Dar6bIAijqE1K3tNmqdZ4bDtqDHp1+ZtyqRb6fqD9vCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625372; c=relaxed/simple;
	bh=fy4JprjR3XB/76D9ZSQxpwaUNbrIVjk6fpJS6d4hT90=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tJzq0jkCLp8WeU7V5io0T4dEUtEQ/sbKhN9NmQ8FWutN5FU1KIpbGAYIc9ZxqjMSMShL2FhtrRWN8YasB81DRmIk3oteJW1sUqPYAiALOHTCKTkU9F51o0nXk+ZCbu/bFj0PDZFesq936jJpgcxBuC9a6s/YlFOaIhKo35yUvxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=skzbQN7Z; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="skzbQN7Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuiLsmMFSwKXBZiieCvhzo2Y3YfqP6k1MqH8tMjgpbkFKnw/loBU7sCaR46vDcu54D441lI2yt79rA5ehP1BhD64D0U17M7dOPHKobhlBTDfYqY1Ci57x56xOyfVpGwJwOqH9Gnhk2h1t0x+NAZg5ZJfyRuZfpxuc6iG6KG/OCgTNbzw2RKThQHDK3KBzatbiJS0CYtBaq7bhm7A2SyrUYHk/UT2kX3WqpomZzTWDYrmgMPJvnsFk2CMAR3pGV4+7qUsme10c2WImjMQUvwX5gp1RfN3fOvw2YE5/0a3SzDWyRKi/P0xmBVmrZsmBTPascuzGrgtwLa6DbYak8X1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtHNFZbjBuwJWnYBKZLgmkZ1S4G8l5PeQzuQTP3K1DI=;
 b=ypsmv+qa+jJ5Wo6FKViTFyAefDUK4oVedtx4+s2wVGuDxcVmFfclYQ675BrFyDDz4pSRRdjZmwl6R7gurFzEmPg1+oU7x8oJYEFjLbB78PS4m3VC2Yhp9T8Fbeoyu/NlcCSuoQxpgfkzTj+MOjpaRFc/Us9cnq+0tymvGnD0EWlPB8yzo13t+IfavXCf3t4xVawfWGCGl+kzXRyT5uxAGroAmFFnL8YSHYRtB4zdVfcdklYE1UvBoRBnf+JIqM+t1D5UxE2xILVpXtxcEfyD6zoVLQaQZVTpOXVQLEQidjCOYp0a6cG5gGRC3US1ft7MN6K5auSYprhdx3PxkuJRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtHNFZbjBuwJWnYBKZLgmkZ1S4G8l5PeQzuQTP3K1DI=;
 b=skzbQN7Z5kaEHjvQz26VFBrl64xkmvAPObDYFoHiB/x5Kc2Y8sn+Mn6jzUqycxUNqJrIgH99/gn0rKoML5zP4uLIX0wegbrhAGxDJHS+lMyY8goqVUxKWiY2cQ6DGHsp5nBwFoFzRLrBM0Vun4ApucG0FLZOUmDeuLAEEjqt3jk=
Received: from BN0PR02CA0037.namprd02.prod.outlook.com (2603:10b6:408:e5::12)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 09:16:08 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::4d) by BN0PR02CA0037.outlook.office365.com
 (2603:10b6:408:e5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 09:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Tue, 21 Jul 2026 09:16:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 04:16:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 04:16:06 -0500
Received: from [10.136.45.190] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 21 Jul 2026 04:16:03 -0500
Message-ID: <82df2284-462e-478b-b4d7-da7bc31b1115@amd.com>
Date: Tue, 21 Jul 2026 14:46:02 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] KVM: SVM: Refactor svm_update_lbrv()
To: "Nikunj A. Dadhania" <nikunj@amd.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<yosry@kernel.org>, <jmattson@google.com>, <thomas.lendacky@amd.com>,
	<nikunj.dadhania@amd.com>, <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
 <20260721050600.87268-2-shivansh.dhiman@amd.com>
 <9dbf6e5d-c367-4caa-9506-95d9cbc74769@amd.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <9dbf6e5d-c367-4caa-9506-95d9cbc74769@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: 006f17db-a737-4f07-0a85-08dee708b2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|6133799003|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FbeAQn9TrumgrtnfdGK0zmypWNxZecnEtk51ci85tGES3WeqmhmeyH7prWXjhkvBaM8p69+vFh+QulTmbiEits9yw3LZfQNFL+xE3sqpHb+sVQmgW48fguUGfVdXT+jVICKnMkgqCCXGEeBFYj0IP0GLLd1cc0jHGTNPaQjZKfwenz9crycHMPOA9EOu4nEGSx3vUvgAkQTumO4ZIAl3nYkVoMglBkLCesliuxl1UMA1CrgV2LCbzUydwzRZTQfYJVI011j6YfXEkNKF/IIdwF8ztb5CCK+pUae5Tg2dUmET09BwS9TcP9pe2J2b28jzQ+0Q6y10EfUkPSBT/PB8RnI36WuHgozeA5SQcSPUMbCwe0v0Ytq9lv+brUl7qn5ZRWwbPvIbumijF0jJzBB4c2aC9I/3bzF1Ym12WhD33U0025CDlXuxrGHixK64UvgDstG9Nh33m8RDJR9WL4zHnF5nvNxqTq9bxKkS0hcmw3xzGUAm2Uwlndq6mLOcPvvtTvdiCIohqg+K2U4TbMjYTrt6Aw+g0ejYJyO6MDV9Tg8DAJ7+cr52dlYl99Ni9rjlBE6HdXoN/EQwSu2cT3ePZs0ITFuL2OztwiKn0iuTMVO1dFkcPreiBnIJSDMwyQZ0cI3W2pgSmaplm5BHTFalj7rwsmitAnvlbqzz4p10zeJfEl5UquQzgCHjHFvyaMu9sfVE5scw1FEnCqVxQTxL5Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ob45rRKTRTiMtKrrQzvQuJgYJA52OUBRx6F5EbBPQVjKhfO8qO8igpLVJiUcV1mFnHqQpwtEw/wBSMU9UsR7oeK7q9Wm2CkI/TnTZ70aezzj7esSlNfSK7zRQjaPwXfU6+ZB0hkOZJQYdiPLReCfvS8dVqwpqpKSXNl1Urud7x0pIa7Aw5xQxLqdAnSU4w+EMTRAhZnO6ydMrXIFDz+GwW/elpZxEDNz6famTjEfOb4k+21mIeqRZyKZaMqTkT3KFf3n46RVI1Lq5wnHzj1DeRRcqv7yWLYKLEL5s8G1DUnynwiKuezZEYlPubC6A1FIPVXAIK50J6hLVZ69PR9Gj3rDRJwG5Rh68sL++/CBbGGsSu4bYEctvl752xYz8Y7FEYXkJmN6u0RYON+94XKXBndx+Xls/Gjp1K3Av2rflJpwK58WbyQyEAntLfU9Bazi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:16:07.8072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 006f17db-a737-4f07-0a85-08dee708b2c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165



On 21-07-26 12:10, Nikunj A. Dadhania wrote:
> 
> 
> On 7/21/2026 10:35 AM, Shivansh Dhiman wrote:
>> Rewrite the enable_lbrv computation in svm_update_lbrv() as a series of
>> 'if' statements. Rename nested_vmcb12_has_lbrv() to nested_lbrv_enabled(),
>> expose it, and use it instead of open-coding the nested LBRV check.
>>
>> No functional change intended.
>>
>> Suggested-by: Yosry Ahmed <yosry@kernel.org>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> 
> Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
> 

Thanks for reviewing my patch.

Regards,
Shivansh
