Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792851716;
	b=LFTzTQcLlmX7I8Fx6XE3PyJWXV/97V/tstMDrlBHs6Ib7XYDFLeWuPxHevXWUFumgvoC
	 JnFreSjDKGbH9Lnia9kn6MtmlyBJ8ho89E5WJ5bEaIZs0Tjbu1KAxQhiNZMHex3WPnn/B
	 6VJcjXpZDMqvP2fIc9uUQxoo/9DgnySJ6Ne3MZhr5jlGQtKdMabCGizA4E6czHASgI4PG
	 0XXfJB1v/FOdOtmiww27/K3tLdt+6y1D/+JTNB8lIwlKzc3bmTV7l5MfdsBjWYCrQ4I2Y
	 Iv/OCXqjDkMFCpwVqx/RPdOgG0pDVn8ESodQj57waz9eVnWmDTnFmXPb5jJW0TSuARg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851716;
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
	bh=SRwaV0kOSCSKzqcfYpFOnCujfajzuU55xCT10abXGZE=;
	b=qSsAm33PEmldyZTYLzIhi54GgzALQ9unPihAkgNZgCqpGcjSsZhgzwofMzB/eGCTP7dl
	 VYZmgYqCns65eB0ceEvY00eqBU0o+nWNmh/QhRJ5MVxB8UNPg/TSAS3Dd4PTuGVBwf3e9
	 fz7VB0QbqtfYednO9TAS/tFl2QJS4QeRdNRktXO/FNv6OxEHy04sW2t895HppIAs2aV9q
	 e0jQOFvUrVOroOpMfQgHMYFEiM91158ABTCIB1xImrsMJXWrezKAI1I9ICf5NCXt25/7p
	 Rk41IHnOA70XLTMlpbXWHVmLxIDkzno6DeiAM3goapuybERteRwF8afc0YIrfxuQbrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Mcm4sQ+z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.25
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29266606A31A
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 14:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29266606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Mcm4sQ+z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gcqdy+umoqjZqLYj3QRKdrjkHz3U8cCbzfcFY6eJMx26FDOM3sL/6oraeZCtqXGSpvzVqwqivO1E+5Hs1m4vIJJ0IO0vm098XZenQ5gZl/wZfxWOrYQ34AWmqUr4d9JygucVINdeDtTYA8ejAr3IlPI/dgZ0Y2EcnSjNzHysWo5u8umFSCg7GUFyAkazHBPmQ5Ls+rGl+JgFQkOavm1ciGXkTmXtIkylaZTgm6DQ3d7mlvKtvy9OyMaiU3R0RFUApZqaEfKTnvrzLoRdLUfj0ZkgKvxpCDNge+v1sIeXdlmU8SMzbKrxd3x5zkerTvDmXY0OGZHb3BloAQZXY87MOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRwaV0kOSCSKzqcfYpFOnCujfajzuU55xCT10abXGZE=;
 b=XDxoZlUGgoxgZU9LyL2YLSfTuJjJgDvw8VHz4JDyoEgS85H7foJxRtwF6a53jZzeI9jE6uwSmAG8uTZY7ael7T3FwpU7ZCCcBIOcHjQSJ/oylgKYoF/iwATP1J3VOwRBy5WsrlD0nJefBV+95XoNfUp1AKniWV66fevOGu2aV6n2Ag46Fdagm0mv9fPwtZ8liZFwsCq5chbukoU6fl6ZqFN2aApNu/1BQqxfYV4pJ/Oaty1ERQldic2NdBMJQROxjmMFwnfQVKq25oVADOYeuy1PcAN6ife4LkpYflCButg5I2cmrl4hTVgvR2IoNremqvkkSZ2uf8yO4qch8Vo94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRwaV0kOSCSKzqcfYpFOnCujfajzuU55xCT10abXGZE=;
 b=Mcm4sQ+zlJqtvN3x+qQwFMkXWbpKO3eEDgflM95qFNC4dR4hvABTUOqFoAaOeFPLCAdfK5pmw3abWsoRrx8BpWCpbrtq3cUNPbAEsMAnFKNaXFUgogsgUc0LlO0pKwZz6oYxW1RdUVNJbEtPOuKWf63dDGGE+pTo22A13l/qxpk=
Received: from MW4PR04CA0104.namprd04.prod.outlook.com (2603:10b6:303:83::19)
 by SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Sat, 24 Oct
 2026 14:21:50 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::28) by MW4PR04CA0104.outlook.office365.com
 (2603:10b6:303:83::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.21 via Frontend Transport; Sat,
 24 Oct 2026 14:21:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sat, 24 Oct 2026 14:21:49 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 24 Oct
 2026 09:21:48 -0500
Received: from [192.168.1.2] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sat, 24 Oct 2026 09:21:44 -0500
Message-ID: <2885aedc-6749-40fd-85e8-85fac4628c19@amd.com>
Date: Sat, 24 Oct 2026 19:51:38 +0530
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
Subject: Re: [PATCH v2 05/12] KVM: x86: Add support for Live Migration
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-6-shivansh.dhiman@amd.com>
 <CALMp9eSX7aDK8+126wbGEOSonTs1+g6VFPTMxXtS-1-HHWFn5g@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eSX7aDK8+126wbGEOSonTs1+g6VFPTMxXtS-1-HHWFn5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ecb306-22ce-4b12-28ab-08df31da24ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|7416014|376014|22082099003|18002099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	h3czpxpHdbaB6aIs4TzL9Gwt0M8oihMTh6hFxhScFLas0NAoaoMIYmOGElmIK97zPIqMri626UcvLl62lykEhKAYHXpzE+7900ioMFL5UYsFfs2Ba5qr5gKVI3xQm7m116vfVKJXYbDp5z64W271f/aMS2BV4vCNoJm5vRwesb3VoS4gXZdFL+L9q+V3Pfpz/JD3nbZgdgRseZURq02MqAgKPFSeGYriyPINHQq4qXZe7ogdzOrdrzwmYUyoFov5su8Q9E88BLdkIQZ6qsuW1oHz2ckYthW2Q5PjIl0SKah66Wc05bbsKBvGvWWfkIzhn6OvY9abkk2Q0Xbj3XwMPdmvtyamM1nSodF2HpKl71Wg1V2aY3pIzPJVcwD/N5RzG9IclAY1LXkcQZdk8GUNEi6ezsLhZUpAXNKHT9K6lmzTmChLIRRQpneYMiYdyNwGmmC+yLTAPsNTT+gOijgGXrcE354qR+Tqj/l5rLI+inIvpuOSMX2xTUcqT6D+5bBNdFEbBKZVO7j+2tMoSvV+ztvNJC76FcTwWBs/axg/f6Dd7a+QtXmqgI4yjQn3RyexLmyBagTwdbJ1V0jSaVDKyIx8b2RmK4bhD3mYWFyRMLCPOvwkSA7QBEncWYBSlL+pzfvy1o2duY9186H2lo0JhkBQJEQAWyFOucqsvci0z7N2UCoX0FiSkRoJ0pCWeIcKR/RHi5d4X+UrTc8P2iMo5A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(376014)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OhTVSDtqjQqJ5H7NqWtU/k9EJ0C+xirYN8rvxKjIdx9Y8nmTkTvnZBK4j6C9hGNzJzx2cSO5vzlHZ3LgUni4g1u5N6coX2Ujr3TySmx3rUK+DBpOBAr4tmvElTOv5K/YYQpUp6KXySurlT8dEYlEkvQnSudaGegnhpjAurRgIbBMtu5IikX13lgcmwchV9sAgrGDGiy9Igxz/sAZDO5XYNCzDIEvSvzAEuRqSlJOGTwjUrwq3t5qSEJ3V2G4YrisHFdzARfh+X4CFmh2hMz4C7dy6m/YQwS1HVciWN5SNh2G5mTChDXwsVTR7RI6fN0l5yzJ3cDYBUEv3C443N23fJaU91ztsRVUe2ZALI9sMgnTK17cdycSbOH0gQoIL5RxqwDwOYkTgCE6i3n0C+ENbFW6133MPWQtRzBctlPsY3LSVgRCh8P9QHCmr/JZnSTs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 14:21:49.6671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ecb306-22ce-4b12-28ab-08df31da24ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784



On 22-10-26 05:12, Jim Mattson wrote:
> On Mon, Oct 19, 2026 at 2:07 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> Report the LBRv2 MSRs through KVM_GET_MSR_INDEX_LIST so that userspace
>> can save and restore them across live migration.
>>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> ---
>>
>> Changes in v2:
>> * New patch.
>> * Lets userspace save/restore the LBRv2 MSRs through
>>   KVM_{GET,SET}_MSRS.
>>
>> ---
> 
> The shortlog should probably be something like "KVM: x86: Add LBRv2
> MSRs to msrs_to_save"

Yeah, that is more accurate.

> 
> Reviewed-by: Jim Mattson <jmattson@google.com>

Thank you. :)
