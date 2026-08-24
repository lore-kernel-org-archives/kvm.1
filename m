Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162553E4504;
	Mon, 24 Aug 2026 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553046; cv=fail; b=PKNYgA5BM06M5sK7Phf08g+w6aF2lLl8iuBxj3o8rKRhnfchMz49XWRkL6fa5NTGJcX+NgK7lddGill3B2KXGR2Bnc7j8CCtvpz4bZsX9XfHGwOHwCDumEfifen4kaobybFvcJVBYZIDKl5sx8lD4owRA1HrlX70RyGNs8JV7vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553046; c=relaxed/simple;
	bh=xeIGL9NruUvpHSu4rFL6x7rBZJg1T7R0vvl+tvBQLv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kb53mXjs+bnfLf+kWpaO7FvRCgk1O0KhDRB5OD2QdsTEcEZZ+CaXkR8bppuIJwjq4azhPAiB5T01hOhBdmUhIBtrLrHS3IbZ6ZPFIJASrK+fnLgfAJoZ4gNzzrtcumTLrUosf/gM7AvUXi3Tgi5esCtcXTM3A7/pPufVdaFUKRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jxb/+SEX; arc=fail smtp.client-ip=52.101.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jxb/+SEX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxCc3jxHZ3jz8s5xbirKGTdkoxPS5flQoLNfFEzW8NhdolYd7C1XLBAYDkQZa8Erp+BcVTAqFCn+q9zqUq46LOvDz5uHPI6+g83cUa7bWLe46eK2vKVvCyOiA014l12FtBC4sOneUNB6gPOa0PuRYvJ3kaIbq8TcVKLW7cQdVfEN3ow+BjNwYr/HESukqXq8gMyagOvmhwOlDm+jcNym/D1zMJupaDiuEjnIjGkPzLnR9nWmeDxpHzguVMW8gJ53r7qj+ZHfR9zpOrQfZhWi4W1rgNkdKwzgsFYzAau2khnBk/QAa3eqjIG7kfPq1TdPA7ilKZfPcbmA2vOFJbL2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAPbtIlWmPTVa8OekpSCV/8I9fePSJTGpNs7SefLGYQ=;
 b=AK11TftClFQSkha5lwMB7emL+45i54cf5uGczWm4Ua6IQQGV01hQgNVcYlLqwv3lmbEVWHQpyXak5e3uIlpYHHZ/xD4K+uZcWccDALxlNWPcyDGu3hxVcsC1TrSLDht4aretG2TjNkOdfU6lAQYco6b/yqVKa0QG8FkPrIJ5nVecEOlXenc1HtkvldDbXTwqNLtsZwVgNewvciOpd4Cg5UKriOEVJKtvzBRv1N+C+B4lN05I5fe82pbybHvoMKyH29PL9dXdTMn+9LLiB1b+9A39r3M5Css17s3ypUkFvwJTjaQr1hTatuteeQDW/8XpMMDXFp+OwJvVu6ceVm1V2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAPbtIlWmPTVa8OekpSCV/8I9fePSJTGpNs7SefLGYQ=;
 b=Jxb/+SEXko2BUNF3zxkF4FMYbu9cn2syPQ7rnjpI2qe3a7QFpduAWyWvTBNqcmE4f8oxMduAY2RShfZ5FuA9O8E7oDl1huDHYOyqs2NGp+MrXUoqZfgLPFastkPIBAFuMqq8pXgyme/W5nW6gfUUGa3g1hynlJwdsr4gSKi+F1U=
Received: from DM6PR08CA0044.namprd08.prod.outlook.com (2603:10b6:5:1e0::18)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 06:30:38 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::70) by DM6PR08CA0044.outlook.office365.com
 (2603:10b6:5:1e0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 06:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 06:30:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 01:30:37 -0500
Received: from [192.168.1.7] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 01:30:33 -0500
Message-ID: <aa5d780a-a367-46ff-bed6-3b2ebdda9c9c@amd.com>
Date: Mon, 24 Aug 2026 12:00:33 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] KVM: SVM: Enable save/restore of FRED MSRs
To: Sean Christopherson <seanjc@google.com>
CC: Nikunj A Dadhania <nikunj@amd.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <xin@zytor.com>,
	<nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-8-shivansh.dhiman@amd.com>
 <aauJ80pZrw_SfF31@google.com> <db768f80-dfda-42a2-8601-8d0af35c2959@amd.com>
 <an0BbcxUNRKqnUSJ@google.com> <829b5c18-6ffe-46fe-bfed-03d5ddde92d9@amd.com>
 <aohSiFQbfqpKoBX9@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <aohSiFQbfqpKoBX9@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: b51623f7-4b5c-406a-9462-08df01a93645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|10067099003|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oU3+vGxmaZP6tq8MksbolPGs/Mf8eTom2ovwQ2ZUUPwyjXsftHJx5VmNogovCXJ7N2G6eqrdR/xlP6fRZLWZvRi/6JKABy0VNfcgooYsttTSLF/i5wrKL3nOVX/6L3uvsJd0Y7HRsWRSYhPVVBkHe29bQr3pTEL+wXhlJ2s+ifGSw2Rag07x3g8WC4csAc5ox46yWKCBzGAMbl8NvYrS7wdRG7ANu8X5OV+WVTR4Gd3aG7ABPYVNk/IcXUP17CEdRi5ESEcMERgFdXtDnPtlXcnpRVGMX+WmOj4qBKbIFdzIL3+KsOcRVPwOQvnCY7UP3j3Oj1NXnXTlzIWubISdZuNfWAxGwiDKJWdKvP/NyGA8tFcB/ZJU67ELxIxcm4ptwbwg2kL46f/kSgzQVZdfR3iznfn4TDKhjWOAgUpb+y8gEWWFbTAYETzLMydiDTPmJjMlI69+Hv30wE0cFMn6d4ZzHBfkjJV7GecVtkSB9HSnt+2IyC9oMOkaHeXXQZiaZASxw9UlG/J4rM0nyZ+3DX3vj7Fn3BKjw+vj21mMEiRu9VfxVxoIlPzNrAOS4ow33H9g4P0M8kIYIBTnpSVPp5i1SSpo6iXjwxVtk4Z3al9w05ByKALNA2YV59z/TceVugck/tlk0DoHUd8vgoWNUJNhtfGmAxmfLrqy+8pA344w++4+ngjEzf+yjnP86ASsW5tOQktvYCCMVMDHcd4QhQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZaVi5LbMGOkAtC3iZ6CO+4TxmxnAs18+/RzfaVg+yz1EE60+t+dAIhvhbNLlc5aqoSiUI9ZEvwwFJ9IN6pzl0uGrHYTyYymauW8E04Ikm/qPyhYX1u7FZea5ySddMCg6AHYkQgFgbcxrDTfQGIETXZI7PYKtwkbxP5Cn2tiE3IayWLKb3IKzJiHTrTmqbzmGS9WN7NhmyJG3by6vbm+9bNBvBkbu8shKjMq6r/geKXmL81aqgXfza41AlDx66nayCyM+qiF6KnDlVtPcGa1DF++VtC6WHDnbyaMTFqZxxSgLo7J/wOmlS2DLiSc58GEtC0XxYHmT8Z9AZSoowaqnlXFlMHj+UmX23abZYR0WtIsP/E8qg0uP1j1WtubIXj1A/t1i/L+7rgGTE9nenRuli9wPIWIN2UFw7LhVizMQCgBbEfZxeGv5S+yzPpDHtXqL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 06:30:38.0884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51623f7-4b5c-406a-9462-08df01a93645
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152

On 21-08-26 18:58, Sean Christopherson wrote:
> On Wed, Aug 19, 2026, Shivansh Dhiman wrote:
>> On 13-08-26 04:57, Sean Christopherson wrote:
>>>> Would you prefer it handled in svm_recalc_fred_msr_intercepts() instead
>>>> while setting intercepts? Or is there a better way to deal with this?
>>>
>>> Take a hard dependency on an upcoming APM update that states the control area
>>> is valid after shutdown, and rework KVM to not clobber control fields on shutdown
>>> interception.
>>
>> Sure, Sean. I'm thinking something like the diff below. It contains three
>> parts:
>>
>> 1. Clear the save area and offsets 60h, 61h, and 68h of the control area,
>>    as per the APM.
>>
>> 2. Zero the intercepts as well. The APM doesn't require it, but it seemed
>>    worthwhile so that the new intercepts are computed on a clean slate
>>    rather than on top of whatever survived the triple fault. Is that worth
>>    doing?
> 
> My gut reaction is I don't see how this can possibly be safe or correct.  How
> does the guest taking a series of faults have anything to do with what accesses
> KVM needs to intercept?

Fair point, there's no connection. init_vmcb() sets the intercepts it wants
and the recalc on reset covers the rest, so zeroing them buys nothing. I'll
drop it.

> 
>> 3. For nested, same fields are copied to vmcb12 when a shutdown is intercepted
>>    in L2. Clear them while copying so L1 gets a deterministic value
>>    rather than whatever the hardware left behind. Does that seem like right
>>    thing to do?
> 
> No, because that violates the rule of "don't make stuff up".  It could also be
> actively detrimental to L1's ability to debug issues (e.g. if hardware leaves
> breadcrumbs in the save area), and risks creating guest<=>host ABI that we don't
> want to support.

Understood, I'll leave vmcb12 alone.

That leaves just the save area and the control fields the APM says are
undefined after a shutdown. I'll post that as a separate patch.

Thanks,
Shivansh
