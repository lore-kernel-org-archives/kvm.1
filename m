Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D063914E8
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620754; cv=fail; b=CUH6jTMZIAHYE3m9o4kkRbRBZ8B3tY6lzRPnKeeCEy0IGcm7zzTqr3agVYi9/XF4uU5wZZQb4nqCKAkxvZsajdmjT1Zdu/ciP1d/7zIFYLjLRe3cot174KRprULY5Mr1g07q2tC/L3fo4MD8DcyepPdxdxW6blKunzeRJPvIGGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620754; c=relaxed/simple;
	bh=cNov14qr7rUHEGmm7KiSZlaSeHD7qzPTcT2KlfFvlZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JL2xH4hKcOA1+70wJHU3KAiphvTC6qu8lkY+WMLTrs0Y8CHGamiSmIAu8kGI6xhXaIQK3dIaKscGRGiBbyWQwMLEUbcJASpP3ZJhwVTpypC6U5i/puybVX4q/TO5SsTiHFyHkm9kOa0twsGNFXiNXHzQJvs2WtYyiG7NXygHEjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PnUhp0dA; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PnUhp0dA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4ycH+FgtYLGWnuOojtat7scixCd7fiJSqc5xweM6HvTk9ZPW12zw2eRxptc582pnmgBWLhavDc5W8FtjOqyRqvlcDI5G6ZtURbL55XIiJB0kap463rEQQeHJn5grUNPzSZFVF3Az0t0jGWXpShMMdGHs+TZY4epKvSMZb4JJ+JEtMetEZc8HwyjfLyDlm1oYgZ8kZcvb1LVcum2crqSS1UzbYC3iEyF5l5uGrxmLL6BSTs8bTHIBCwXfBcGSRzFnQeOA2Fn0SAL9xe1JrzufUBmm9hY3vW7cYhBIBAg67K5fMTGNLww06JMqXNLuKlfqAQJMbgW+BHg9u9SnRwrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9t4F8RNHSlBfH2LkEevH5qlVrTI/rAcVpp8nmEkOOM=;
 b=chiaQQkgla+RpoXgapzDBfLHd9hT785ccPuBeRN20T4/CQdNc39DGQepCczV9olMzERw6PJfNqWuKBA35YO1M7UFZeOfgrSN2aA54YKCfxYc1A4+goggZKMUAUtnmrKc4btx52+SxO4cTH8Y4C5eocRyzo+CdyXImnELr7ZS4UzHjulrpg/YrS9D2HcebVjhLJm7dMskY46P4q9/1P56OMe/h3tMPJS5pmkSdNYzpXhyk/d8QapsQaTI1Mc6vaHiwekelcXe1xIBL63TkcwZRZ4o52qa99RVQh+A3AIdrnQi8soZPs43MDH+GvUJeX4gunwizESGYp6H31rE8YD36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9t4F8RNHSlBfH2LkEevH5qlVrTI/rAcVpp8nmEkOOM=;
 b=PnUhp0dAch8d+L559EyJ+WR+EDRyP/QMGi0iVLkMxO4gW8+u2SkFClKvw2xSZ5RePCKoU5m4nOU9s3LWZVwTr7WzQHV6BNriPSWltQbCenM5fF1Tkc8Xs4iFcsr3Xolq8aUJdwJEfTX8yCatx98HLnVjctMOG2yuLjpV6KA+P40=
Received: from CY5PR15CA0249.namprd15.prod.outlook.com (2603:10b6:930:66::16)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 18:39:05 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::8a) by CY5PR15CA0249.outlook.office365.com
 (2603:10b6:930:66::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 18:39:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 18:39:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 13:39:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 13:39:02 -0500
Received: from [192.168.1.13] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 13:38:58 -0500
Message-ID: <87db41f8-e025-4152-b152-94131735beac@amd.com>
Date: Tue, 29 Sep 2026 00:08:57 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] KVM: SVM: Add Bus Lock Detect support and refactor
 LBRV
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
 <arazNV7Y93gnflU2@google.com> <arb9YBIW8C5KXuXK@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <arb9YBIW8C5KXuXK@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 84889881-405b-4d30-c86a-08df1d8fc613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mjNlCEo/dUPw4Hr0NZxZmXV0bJdszMzG2Qj1nPDm53DFdEJZgPXKnbU7+F0hYo8fj0HG3Sxaelr1/HePURrLliu4Y3yJqEZVN/5qyrFVYlYiHkVxECaW+JltC5Nzqxk+Dj0TkS9mL25RwunEFKIzjmsBHcuC/l2saxQYodQoMRe9rhlXwEd3PC5EMJXkcJqWFu6dea7EVAxYAtIuN0hCcQ+cgeb2nTXw82XjqTFzZ2XvoiXSYv+rMlSvRA/+NIu8+gKUatp+aSDtAXpUDtYdAFWYZ6X+WOcLuptElNiF+d3Zs2pJG2kBbOFG50sBEerOQp1DJ8Td6tbssTEtDKqrVi+ja0lFf/iSabG9Q6AW7kshv8jHf9vfWBB+eIqtIha/9P/qk6V66Y/j6bANQfKRWoPBm96KskwRMwpJ0cJdoQV8kxsSwhuIu2wH6t/vwqP7B4/fjBOW3p5XBfI+DrdO8ASLRFxii5WmrtWA6Zwpz5AnasOePvOOFecVS/LCidKJcptaX50MEma+2dpz5nJMhVPdQX1+35fJiVi7198x+ETdCDJaidgLaXz4h7HGLV2TgFC38ELOzwxNoOAohUUZ2iP/x0KMBJNLDsf99lM4Tz4L6KddLfYCBilFW0odFbOYpV+KH+M8G9OCJcyDjWwesSWhkmbABEH5R4cTlB05aUW6GL1zF9F0ZnQHIfmST2uisIyATfw3b6mJKSUYCxhE5g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WDDnrxwbjFloby/8hfOfKXNqTQA9EXGOnSJ1ar4N69mIgxSct5DCohsiLuu6pWmJ10S2VkEvHKBsDe5CTb5XutyzEGmkVIlg0wxb7TNgwrCas9gihItjxo76nzv0AAQXicPb8V6slCygFpcTFsR7/FkScB9/KvNkjrBV4eeYpnbtyxmpZQFeJdrTton8rzfyD0ReCn8VOoXBJ47/5TNTYmJp+HVZThk9o60hKwLNnpHU9P0avTF3UsbvaQE5Qwqp9x2KWAESKVh2XTnCnyqVHVi9YN9U4t7iq3YRbn1pQj79CAWvsSE5s6Jej57FCZWQjmpJ0HXwC4aP4C2c2X0wBLKBJtMKH/bcGfdN4xCCMRDQFhVPs94ifKgxUUBP1G3KrZt3n/5gU76mJbME+JW+9aM9zwg8PcPSt62yPBFp4uygagH2xtqRDj61SQCpq4JN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 18:39:05.0266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84889881-405b-4d30-c86a-08df1d8fc613
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265



On 26-09-26 04:31, Sean Christopherson wrote:
> On Fri, Sep 25, 2026, Sean Christopherson wrote:
>> On Tue, Jul 21, 2026, Shivansh Dhiman wrote:
>>> Shivansh Dhiman (5):
>>>   KVM: SVM: Refactor svm_update_lbrv()
>>>   KVM: nSVM: Disable LBRV in nested control cache when unsupported
>>>   KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()
>>>   KVM: SVM: Turn DEBUGCTL_RESERVED_BITS into a helper
>>>   KVM: SVM: Add Bus Lock Detect support
>>
>> I'll send a v5 as I have variety of changes (I already responded to each patch),
>> and I'm not in the mood to deal with another version as I'm quite grumpy that no
>> one bothered to follow up on Sashiko's bug report, or to write tests.
>>
>> I'll also post a KUT testcase, which I created to verify the bug Sashiko pointed
>> out as well as the fix. 
> 
> You know what I *love* doing on a Friday afternoon?  Debugging ucode bugs because
> apparently hardware engineers are also allergic to testing.  Or maybe the APM just
> sucks more than usual.   But the behavior fundamentally breaks virtualization, so
> IMO it's a hardware/ucode bug.
> 
> On Turin (the only AMD hardware with Bus Lock Detect I've tested), hardware/ucode
> forces DR6.BLD=1 if DEBUGCTL.BLCKDB=0, even on software writes and even on loads
> of DR6 via VMRUN (this last bit is what really throws a wrench in virtualization).
> 
> Software can still read DR6.BLD=0 if DEBUGCTL.BLCKDB=0, but if anything touches
> DR6, DR6.BLD gets clobbered back to '1'.  E.g. if the guest gets into a state
> where DR6.BLD=0 and DEBUGCTL.BLCKDB=0, then AFAICT *any* #VMEXIT will end up
> setting guest.DR6.BLD=1 on the subsequent VMRUN, which is just a wee bit problematic
> because it means asynchronous #VMEXITs, e.g. for host IRQs, clobber guest state.
> 
> I'm still going to post v5 because I'm fairly confident the KVM implementation
> is correct, and the bug is easy enough to workaround in the testcases, but needless
> to say, I'm not happy at the moment.

Thanks, Sean, for taking up this series and digging into this issue. We're looking
into the DR6.BLD behavior and I'll follow up with more information.

Shivansh
