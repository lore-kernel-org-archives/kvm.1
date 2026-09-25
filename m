Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95379309EE9;
	Fri, 25 Sep 2026 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337982; cv=fail; b=cU2xqrJzrog21CrV37/otBRzxgkiNrbFcMwWBSGZqTGbqYlsxpFL0wVBKWBjNRa5W1luhTx9qqaNrn42b+ThmEebLu2CHY9t9RsRK3Oz4mJgaHUvCOalOn1liDGvv/kH7fOp5dA850Yn+AmBTGVCbTUCyf+TatfEj1Cb5lTljtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337982; c=relaxed/simple;
	bh=1PH+8lOpMLwxmzCrApYPp8UNyvmmgSBktf4CHv/7ZbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=agkAX+OSeq9ZPv8O+Z9OMTlMPcPqEeFYhLP419DaCwI84wK0x9SG6gJDEYQTS3rEbefTo3RYdoJiQ1NnuZSR9zseTXZdnHazZTobBu4NzUiWcYP013YepkCBZKMVmwG4wVrxJnsd59NyMQBcVAYMf+sDD1/ktq1Cm6613kbQ+DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CofLHIh7; arc=fail smtp.client-ip=52.101.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CofLHIh7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGg4P/wyX7tVZrw3NJjJoWBi6JwTOrbTs1To0GLeT17hM4xecjh6jCFFLmdR5fC7YUwmG6Pk/Z20bdqCPoFBni/MyFHZ5L6gGUwpLwRI8Tszsbf3cv5IHXV0Xgb/D4iT4/acSRD+pF89y4D+Er8xhaG3N+YXoLowoBLCjzQfIgZ3x5G6GGvsgDcgUA7wrZz3hClx9crib53EkqBtyVYy5lKvOVSsDSuxaxWXBF9kEVDSxdpVVtGihS3SAiMZbKWb2SlXuf2nnu7VoPj4G1YhhnYujNOPtr1dmU5cjX8467uho+sPwKGsrgsTEjRGMaKAQov6DjENSafuppGO/EnXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBfXuzhUK90u38RY9Zwwf7qI9raZPlLEuHQofkzEHWU=;
 b=QWL+zESrmzQKzvRboC06uG0616Wf1UQwLEGlPCWc29kZ/F8uDuvq+pToqPQnx6zJ0ZTWMP0/jT73+x8X9USR7VhdDkZqnFULuSnhGhyMPRLCA8UyUZ7STYZQiSjPLk5S4+d3LNF2Judz7dYA5uDASNyO2fww8+U1RavVaFKeisEnk8G5jZsfw5a3NlNul3+x0WoJHyGmy0s8D2PA2oyEaJCNRQsFLjXfh6HGI21yi7WcWB/jYMZDHrk2WlKri/g3efChDmk1QVGcUhEcnNbo4Xjo7coD5BUWy86Vc1WhbSLBe9nLJ5rVIJmGtnJK2AXFB+BAF7Wtjl0jpC62IRkmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBfXuzhUK90u38RY9Zwwf7qI9raZPlLEuHQofkzEHWU=;
 b=CofLHIh7nApRUkXGuxt8hltkk9b0SyH6qaHxTIJj/rs2eMjPzSqombUN3RF1tBkMhvOU+TToxFH0Fg2zxXQD0YtJueDW9nHqGlwjZA7g57xRnwcNJJ+2Yk5JOOLQWjR/Tf6GAe8BqVHInT0Z2UFjDjwx9psPK2vb6Wdp28yasEs=
Received: from SJ0PR03CA0147.namprd03.prod.outlook.com (2603:10b6:a03:33c::32)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 12:06:15 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::20) by SJ0PR03CA0147.outlook.office365.com
 (2603:10b6:a03:33c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri,
 25 Sep 2026 12:06:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 12:06:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 07:06:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 07:06:09 -0500
Received: from [10.85.42.224] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 25 Sep 2026 07:06:03 -0500
Message-ID: <3901b012-3c13-4ff4-8b6b-007905c380fe@amd.com>
Date: Fri, 25 Sep 2026 17:36:02 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/28] KVM: Enable FRED support with KVM VMX
To: David Woodhouse <dwmw2@infradead.org>, Sohil Mehta
	<sohil.mehta@intel.com>, <kvm@vger.kernel.org>, <x86@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Chao
 Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Zhao Liu"
	<zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Shivansh
 Dhiman" <shivansh.dhiman@amd.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <43fb3d8a-0736-44ae-bd7f-01e701d4b7d9@amd.com>
 <55e7eef19801facfd4ac1cb147ab34f0aed0c331.camel@infradead.org>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <55e7eef19801facfd4ac1cb147ab34f0aed0c331.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3208be-085f-45cd-b6c4-08df1afd6633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|7416014|30052699003|376014|13003099007|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	25Db8aeCDX1vmkvBmZ2n+ywY4PCbfsD8Rd1dqEjmUR+Bpdd9jXxZJWE7+26+T+jRGPs3gu0QEOLCXUHfa7Yz2U6bbSYYsUCbhzP1i0Lo4WT9mmx251+pguXLoY8OEo7w/lHdKQYhUIQxr9muivWZXTHQwqFigauUjaeiuR+nJKnUXO369StC0b2kIr5XUHlQ5/npI1Va6QDYHkGkZvA1OyMRWfbRhuCSQi0aagNhfs/8TSMf6ZxIB4vj6Drr3zFKD4FOkFdYX9UVlDYHsjtCkZkEPhrB2Oo1ZL0AkA72wvE/VoMvaYw2YmSmGlzChJnj6otxO55G74GyiVg4/NGUaqW/KdpmnAaUGjtxdVDMm3HdpmWiLztNL6Yw4v9NyAiy5HJQn/nKIGmEgfkXIo5R1V4o4siE/aHbrkaiE5hDQOtb/P1AB/iapnB/xnhfik458uP3ZdJ4lTpyQVsOL7lpsAwodEvoZ5Nu+yU8KRtnb5pVF9g6/jXreO6/vjw44rHhypym0YVAXTeKmyUx5MycM9E1nwJYHNjtsOYsiFCrFx++F33cphrryzX2BBt7DFD2J3rIzdQ2lFiqvjcyHOAw845CKXRUrghBT8NBXp5gr4rCpe/4rwoZH37RRmcgOoMTy2nO4EWXH3tnJ0JGET86gw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(30052699003)(376014)(13003099007)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZaSpFgyr3ioUprJWE+AKxvw3BL7MRadr4cRv52jsu8UE+1/dJXBhDY1CkX5Y33YsfSp106nhf910g97E5u2eI/wCZnPMTtjg8vGhDgGYC+Vsth/n0lv/stFrHBgGn9j2zN+9BzVeMHo1+n8Zw5Jxv1eONpQcpVfFvQ9Ii2/nnc7Ltc58O9dxddkKyKoeGMQ0XQX1jdyFPPEIzelRaJYdxYukoYWZc336uH7DrxVPn/Av/G1drCzvULBXv2KJWKvYF31YdwoqPH+kDjN50u/CUoXtfQncWNPmydO7xpIEHGRP3D8hm+UKsppGy/RLm92bK7EXdsBAHDYoHAtM9ZqLhy5zEelbrh/iAxqT1CVsxBSzHJOELUIZUgo0j+T6/TjGBzpDNae0aU4tIocxayx5+UsyHfcr0OoduIKizyQRuu4p850meR5Vi+YE0t6zWXcy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:06:15.2924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3208be-085f-45cd-b6c4-08df1afd6633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442



On 24-09-26 19:43, David Woodhouse wrote:
> On Thu, 2026-09-24 at 16:44 +0530, Shivansh Dhiman wrote:
>> On 12-09-26 03:06, Sohil Mehta wrote:
>>> Opens
>>> -----
>>
>>> AMD compatibility: The SVM enabling [5] builds on the same common
>>> plumbing but I haven't had a chance to look at the series yet. Shivansh,
>>> please let me know if there are any incompatibilities. I assume most of
>>> the opens apply to SVM as well so resolutions would help both vendors.
>>
>> Thanks for the series Sohil. I've been able to run SVM side of vFRED with
>> changes rebased on top of this series. So, no incompatibilities in common
>> plumbing as of now. Will let you know if anything comes up.
> 
> Can I remove the "Some AMD CPUs (Venice) incorrectly..." part of the
> commit message of
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=commitdiff;h=fred


Hi David,

Yes, you may go ahead and drop that sentence. AMD Zen 6 (Venice) supports
event type 5 for INT1, and the FRED Virtualization spec [1] has been
updated to reflect this.

I also ran your int1_fred_test selftest on top of my SVM FRED series [2],
and all three tests pass. Note that the series stops intercepting ICEBP
for FRED-enabled guests, which is what lets the guest see event type 5.

$ sudo ./int1_fred_test
Random seed: 0x55d6fcb8
Testing FRED event types with EPT fault on stack
  ICEBP (EVENT_TYPE_PRIV_SWEXC): PASSED
  INT3 (EVENT_TYPE_SWEXC): PASSED
  INT $0x20 (EVENT_TYPE_SWINT): PASSED


One small nit: could the message above say "EPT/NPT" instead of "EPT",
since the test also runs on AMD?

Thanks,
Shivansh

[1]: https://docs.amd.com/v/u/en-US/69191-PUB
[2]: https://lore.kernel.org/kvm/20260925114017.2208531-1-shivansh.dhiman@amd.com/


