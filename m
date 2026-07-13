Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2F35F165
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924139; cv=fail; b=b9O4sFOa5cFTXn5rqVmFpSEUUZTWGvC6FJ+orkFbMvjtYLvNx81zq5dafpSvbKCnaOqqWnwrDqMXWs5AGRxhnHFVeyyGy1cgJBTwlQBb70Ba6jgGcbdk/UAYtExkibUYzD7Q1+5qV11Y897cMcKciIRWT+2xdYTzehgzm03iGV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924139; c=relaxed/simple;
	bh=k2QeE2mtOsgWPNXddiOFRm4Rguj5gg7NKVuSWEUkRS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X/SKHJzQwrfkBJ6ow7qJpH7HLWLWK1Uq7q+MM5ICieaj3NmfmNPKlOJ+GRUcAXtwoJg7kGgPoiL56eW/AOUHMO98i+Rul96EYQP1cLrC6JNJ5Ag5UseqsZgd9yPOQ+Jo6wMHGvDrNikuB3UZiRCrhjid29VAC6B8lIbKc34TIBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W2mdjwZe; arc=fail smtp.client-ip=40.93.194.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W2mdjwZe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD7DAp3LLmZYtLGALo+N4TIdusCQPL/6zx/iTnV0SenUoiblkgEfdmS1btOGbBCDRbJ+MVjHnEL14ipqi6uebMC3ee4STQZ1j7chfprMvE0KCzDP+MyQRJIbb4+OQ64ChFfd5WiZgZGPJiJblEyl568CoWKAaFNGZSX0QEzMC091zzTeQUXMzTKuqy87uct4SLD+qAd2Je39IGZ4cmlpKUY1KPX+tfUrASZYLgQmqhTmJ54Ps9ELRCAnfd+DXoFMhU0R0Gl6vdhJHHpKOgDQr0VJHiuHiUxmBniMEhgF+fqzw7GN2USwB6X4j/Yt/rTgF0TAQcAUDaioEhjIJTIpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7mLbIy1MZV6uHlI8av2dc0YprLPNkZt9SCpaWftgeA=;
 b=HTM/XzpbrrRRacPsVzJJki7Rmmw40ErekO6oI+I4k9t0m2tzczMpCFVxIWm5jNJMKiZbwkPfpgRicCI6UitoQb1GD3hpSgKzUU5iQsMU/f81XJTzA2GteHbH6jqOVYrBJDj0XkvZt9tFqzr50/3HVdN+0xfWMubCo+1IpQKguGoNiiJh7d5tndHt002h/ExMbdjS75qO2fXj1DIPeEla6nd/ctXkLNK5W61FaTlq4z6iuM4oSMkEsDujyZQevbOVEuUOM8bW6Cwl/fA9aEsRey1hswCF5mZIRwMOVM9+EeAn8fg15tqVVldGpl3VjH2TkInJWhMeTJKe3hAwiz991Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7mLbIy1MZV6uHlI8av2dc0YprLPNkZt9SCpaWftgeA=;
 b=W2mdjwZe6+SOv29YFbm2IFil0EQ5LtnFjbqjLBYye70Df7ErsPNllzAvT9hY7VYmkLMPMrptu5MpAK6XX8weRpgTYBXRjRhiEu4S0J8BTGZFaDTvcQTEQCQKm0JwNY02mVjCBoDWxwOC0rss8mK6eIZDRrG9hxMsPSYaJf34aRE=
Received: from BY1P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::16)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 06:28:51 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:59e:cafe::62) by BY1P220CA0040.outlook.office365.com
 (2603:10b6:a03:59e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 06:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 06:28:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 01:28:51 -0500
Received: from [10.136.45.190] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 01:28:47 -0500
Message-ID: <175172b6-94d1-4552-a477-e07c202de3bb@amd.com>
Date: Mon, 13 Jul 2026 11:58:41 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] KVM: nSVM: Disable LBRV in nested control cache
 when unsupported
To: Yosry Ahmed <yosry@kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<yosry.ahmed@linux.dev>, <jmattson@google.com>, <thomas.lendacky@amd.com>,
	<nikunj.dadhania@amd.com>, <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-3-shivansh.dhiman@amd.com>
 <CAO9r8zMxtKYFwmMcTgedrFu2gT+SECmFJaiPFmE5iuRAkxs_jw@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CAO9r8zMxtKYFwmMcTgedrFu2gT+SECmFJaiPFmE5iuRAkxs_jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 153e87bc-b248-4cff-815c-08dee0a80154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	GuiBQjaKIfH5DpT/J+kxecqSIhtz5gZo/VHtWrKOKf0hFdKGk5u/4Vi0rhjuJoLdOovJD8p/oa3pfW8HhJ0V6DhrSjYO6i5b4/HlAl2edToQq3bZi4V+axCMDj02ZLQ+eaBM8s2H/RwY2IVJO1GwWPVWcVM+UPU9sPBdm7HeW0SfguneWGv9flNjo6KF49OKwBsTGbcwPPyA3COD3z4iTqEGZO7tP1wOZDDF6a9pn522eEeLOpfMmThQZXFDyux7qCJdthv2p1FGxk02ydNU59R3P3/xGHOC/Q2IzqEljZHb4RyZGLw6EoCqWYR4B/D/MPqoV+9TzINEru3n5NEMZdMJ2jXRHm9SHw/Rnf/ZK93BQaF5DW4fvaDBytz/GbFSdg3UXhoeHzGhqn3jgdcT3P6jAGe1EGUHJdUR+K3Z6hIpqQefSJ3rtXT7Tw26WRrU670lJTSTVFf7zouoaaf6r8MYudlvz8UrOkgLnh4UOIGmF7Xp+KdjDFm5hND3nxfcOWmvNOQWh1OG5pxStqoLMOJs9RYkLT573ie0wTDzWBCE3A00I8fqf7XspDK50Ls5FgIiX9kv+5sMZXgrnizCgxkHTD9v6rHNBtNJJqGhlGE3BjRv/jlyNWVHrnPlX+JH7AMNhNbR59OSmsQgIZqoM0/SaC0GiZTljmjLulpJW0Fynbmmm3oJuz3hgGEWTvZ7xntdyX6QesPXC21lrVqkzw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NjcV8v1Zf5NIL7wcULN4C7FaSTc6zcnUgajtoBIx3tdm0NbUPstSkDyD0zNX0HJViTetjs7xrB8kc42nz5RwFkACRtqC0nVeGE1cj6gmC5IzkM9R+nr8jnf8vWFSrDMdWlzWp7UZ9mfuDf+FwQgbrASGSjvlE8jONbfSfNIUqBLChPy7hNe4d0lw3AGItz2eGe2zIXjWIO6GabKDYPfLndmPPtWdi8qH2/x8c6BonI612qI0leEyc5muRxcqU2YIYQtKKF5JoLE5zo/E2TVGn38fLL42gnjLXLVP9+V8j8OmNDS7ZWld9hTDxcBK2su9y056lV6JC+eQGStOvlZfy/+xu/dp0Xj71Gjw+cYDkuCacj2rgzfGslLizmsTRTH/JZzl/IVT/NWct8w6vKEg6prQHPumU5dEYe7qh7gzvUbqLEJpOeksqqgkd7+DxIRS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 06:28:51.3988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 153e87bc-b248-4cff-815c-08dee0a80154
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063



On 10-07-26 01:18, Yosry Ahmed wrote:
> On Thu, Jul 9, 2026 at 1:32 AM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> Clear SVM_MISC2_ENABLE_V_LBR in __nested_copy_vmcb_control_to_cache() when
>> the vCPU does not support LBR Virtualization. This lets the cached value be
>> consumed directly instead of re-checking X86_FEATURE_LBRV on every access.
>>
>> Suggested-by: Yosry Ahmed <yosry@kernel.org>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> ---
>> Changelog:
>> v3:
>>  * New patch.
>>  * Sanitize V_LBR in the cache and drop the redundant X86_FEATURE_LBRV
>>    checks (Yosry Ahmed).
>>
>> ---
>>  arch/x86/kvm/svm/nested.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index d3df6b22bfef..84248e6665cf 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -534,6 +534,11 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
>>         if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
>>                 to->misc_ctl &= ~SVM_MISC_ENABLE_GMET;
>>
>> +       /* Always clear misc_ctl2 bits that the guest cannot use */
> 
> I think the comment here is unnecessary, the comment above for
> misc_ctl should already make this clear.

[...]

> 
>> +       to->misc_ctl2 = from->misc_ctl2;
>> +       if (!lbrv || !guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV))
> 
> Do we need to check lbrv here? KVM should not set X86_FEATURE_LBRV if
> lbrv=0 anyway, right?

Makes sense on both comments. I'll remove the comment and the !lbrv check
in next version.

> 
>> +               to->misc_ctl2 &= ~SVM_MISC2_ENABLE_V_LBR;
>> +
>>         to->iopm_base_pa        = from->iopm_base_pa & PAGE_MASK;
>>         to->msrpm_base_pa       = from->msrpm_base_pa & PAGE_MASK;
>>         to->tsc_offset          = from->tsc_offset;


