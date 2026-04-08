Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ACA352F9D
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624981; cv=fail; b=EhW+hBuFBzQcPiH/rBHn8CM8REf60sD5cxGjmAeG+/ZbjRFWeBshlcwE7nDIAYJuCey0czfXo3+pLd7jZ/aTkkSdIIYZyFzyG6UmIsvTJc4/ClqSBwhuFgpuetqfLvV7R9s6jGY1scEYzVWLdyz1tdaQ5RpXKX3Lq/ZsBfIQ5Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624981; c=relaxed/simple;
	bh=jjpRlkpJQVs+p6uSlpuniQH6XxgPhuHdyRFL8mcmso8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ryGlJZ6begaUROsv9kBuBl7V7MxFVmXJ+/Z156gMUJs7Q75pbCfi+VQ8+VzVCTDzhrI80S1ZVCKj5GfHdeKZ0S5icqdPZMJodgJE3mW+0wWUpsK4etYOvVNzgwSor7yS2HTChPO/X7haH5wnyVit8c6OTAOC7drHKS6YdGtVKt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qMhfI/w9; arc=fail smtp.client-ip=52.101.62.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qMhfI/w9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUDju3BBTG044GedShJSnhlmba7uuJIrtWfd/D56Q4OH6EGKUJZC3zRabnEWmAQRXJMVskuRQkcvxUIVMqkeXrX+LjqD6140tIKz0Y71dI5uvebPQOYM7sxFdiWNkA61PK9i0WwpCmFNyDiueMI7vZiUEfXVdJ+osQLk3ze7Jibc6x4IROXAQDTjmiIdUWPO8mrRYP0bvtz0HAA0TM+wwogX51jWzRiE2cgaWArh3aRxHRUYqFEhDcVrOHBWDHD8gbxstf7X36kbsJeMX/aXmFQSqpDCZ+xkziZ2ixG5CrQF2ho3lp0ABZLNy2jNYF22CXVGKA/bmT2RCYgq0qVIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=He/UOx5vAOWg9+GXn0pX9V8tKefqOTlqEMl+6DiJK4g=;
 b=SGkNRx9W7GAELDMRRo7uoIvOTnB9AOaDfg0Y/juUQGoqZ219tunntHLHoFfDATuCZzThGiNmN/fYpmBfD9gu5g0KjQ1iITToU9bbabYcTl6zF86QsFOrtzhNumJpnLOpwfGIGqoKgQ+gHOrhyZhJ+SSAIJS13Ql2E91g67AL/wcIh/lqI0y9IDGz/Ad3ZWWEPfoF2VGV5kPeqePXiOS1PO/uYZJrAbZ4JGWYjIRTsf67mj/pP0SXOROf/tfLX1vyIQqox9CzfvyMzDL4DOPwdHfj5/mOt3loiHp2vtTrZaqORhHlQhJBOHmrsEzkuszs/XHlQdLCSvSSFIRxX5DuRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=He/UOx5vAOWg9+GXn0pX9V8tKefqOTlqEMl+6DiJK4g=;
 b=qMhfI/w9bryga6xSxvTHWf9Y10Gomi/ZF8LTzIy8ntsh2rhV4K8bnlpuBu66S7zsEFQLYb0t1SCNo6f8Jyrrt8ctTW1+TmnCGo4UZh9UKICssPBEx0sL4hoOdmS1wJ/VXzUgDxm/03yl+5oVpLOobrLfICwfgfmSQOheZufSG8g=
Received: from LV3P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::15)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 8 Apr
 2026 05:09:32 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::78) by LV3P220CA0002.outlook.office365.com
 (2603:10b6:408:234::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 05:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 05:09:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Apr
 2026 00:09:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Apr
 2026 00:09:31 -0500
Received: from [10.252.219.255] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Apr 2026 00:09:27 -0500
Message-ID: <04a522a6-fbbe-42e0-8395-a9b74968b8be@amd.com>
Date: Wed, 8 Apr 2026 10:39:26 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] x86/split_lock: Provide KVM helper to log guest
 bus lock exits
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <mingo@redhat.com>, <bp@alien8.de>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <nikunj.dadhania@amd.com>,
	<Naveen.Rao@amd.com>, <ravi.bangoria@amd.com>, <peterz@infradead.org>,
	<dave.hansen@linux.intel.com>, <tglx@kernel.org>
References: <20260324124002.7670-1-manali.shukla@amd.com>
 <acwFolDAoqlY2ok8@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <acwFolDAoqlY2ok8@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: manali.shukla@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 4279e5b8-5920-4717-e227-08de952d04c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	23XKJqcc7+WNUcOqDOFHklc+GD+wu1I8PWv0M1gHhhWO9biPjqVWCVjPihoC+bnLqZk2stdZlvE/oZ2ZdjilHrTF4Amt302RgFuzPy37ntTTorjSfjJmX9gdMagAs9G1zp87gbXqmPwpeUQ9qx7FJGaUkx+zgljU7PpAy4OLu/spD/v6X0dlo/jytssK55xBWfCQXH1OWxQ3RYdSadDW4eF/WAF0W3gPhll/4sXaoBWn0LXqv9RX4uEwZd/1mYBwPEuvI/MUK6kR7Ry987+paDAm/IXffbe7bbPOTpYG1wqeq6Rbp/ppRXuAFzXYGTxg33jYSefwCTgCFnnVd6sDjock7A7cVCvYWlfYLMeaYkXw8QpN1jhsCDJF/FC8NsEghHn6B1TxniNvhiPcKgZMYsd2yHLSi0vmt5b8iGT9iLaHBUoTAqaTxOuEmpGGYc4VplZET2sS+CkalFO589vK8auizUfTI1Pl/VoXBVV5bn/iaCvbWkaKD/s6p7g7orkCUySjumnI7a0H4V+R2xAqEmykW8XA9wSZ6v8SEhlvP7F7Gw76FxhflIFbA0pfzC2PekssU900W9DS5mnH9gUt9YM9ei60roduOraDef9l0C4lSC5xWc0a/USR24dITQefUG1mHU/D7N/azzCsuRLxnyIrqKpySorT6AXRnxTY1+7yYqha9D8lTNWx1dtctoy5YhQDYI5474o6oeEww9E1M9wtY91SP/uyX2iCRaH3JC3IV6oK32UXu0oFkfmCESU70YuSIHIHTbkAXzH6jtbajA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R2WA+Y223XxCySX/5g0sDiJIYpMzSy51Z+GWkeqqyOuIYPhb+KAy5FHjHFQp9QcxDOALFvqQYrx8G6PKdgpYUF4msaIlrjdGgOyjKTFn9vDgJnqUi86RFdWx6dlu6odqN8Qi+fwClYrLcV1D4KCZiWcVrUEQIpx5DErFXklttbbjJ1eSvz99RzJ5tT3+6enOmWOZFeQHXDBjlWgBsu4ELOiOIVcxndreph1h55zyHxdaWfiptrvglbSV0S3F1/MNyRnWBeVOXvnWJmpvrlP8LH0tP0z1/IaCKjqhO2Y6Iaiv6fyQpMcCC/ToDt9/Oqi4QSFcLuiTDLapsJIQJ9+RW+l0PpKmr2v8rCyvQ/El4aNJK/MJ/ShF5ogF+Ki3LjVsplwx3x2YftIaZsoOkb1eLlG/67V0exmjdNYq5od0Ytq4ps5Sx0VuRiY24E32nxnY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 05:09:31.8860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4279e5b8-5920-4717-e227-08de952d04c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104

On 3/31/2026 11:04 PM, Sean Christopherson wrote:
> On Tue, Mar 24, 2026, Manali Shukla wrote:
>> The intent is purely observational — give hypervisor owners
>> visibility into which guest is generating bus locks so they can act
>> accordingly. No policy enforcement is done in the kernel. Suggestions
>> on the approach are welcome.
> 
> This makes no sense.  KVM is exiting to userspace, the hypervisor owner doesn't
> need to grep dmesg to understand *exactly* what vCPU is generating bus locks.

I agree that the VMM receives KVM_EXIT_X86_BUS_LOCK and knows which vCPU
caused it, and I am fine with that approach. However, this request came
from a customer who wanted to know which guest is causing bus locks at
which RIP in dmesg, similar to how split lock detection on Intel does
it. I am trying to address that use case.

-Manali
