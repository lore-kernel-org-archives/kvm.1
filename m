Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FE140B6EF;
	Thu, 24 Sep 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275577; cv=fail; b=tutoti61HX8vLnRhzzOAII4jFoNTFBHhycOUlNWkY2G2mQCWOCQSCJG0jYhwc6GCJPgUwU1oOb7VHfyejCP6a1OjFdvc7byPSehEwkpQJT7x6wn4N/q914hN0Tl9PoioS0ibUQt1SFZW6owM2c30ByoaJS7caqo1WCKKz4J5HFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275577; c=relaxed/simple;
	bh=8gV05qMyjfjrajbnW3RuyPA5l6nE7BL0xD4qYmAZTrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MVo3TX1KOyuggK8LSxYivRX5Df9B1lRKJINfDJJ+HJ90PQ7FhmOAMdrVWdi9QKJiwIjyYbqe4e9lS+yMtjIegbet8LSMZtoH5aHF8z4m088OR3fQuJevEqLp4EuoeuYn5/qVVNldCEFc7sUGu/9OjzGvMeqoNapX0kmF7TvSDDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sq+1zJUf; arc=fail smtp.client-ip=40.107.208.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sq+1zJUf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RafGZu2SLtdhoib0wFsPi+m+KljG899OWhqgRcvXGk+tNY7lNzrATSbbieJ+imoX0t9GfUjQjppI6Gt450KWIYva1pX5MJLiw4gFBNShxe9zwGM1yrf0QBhzKivvKdLCqeLBpDufZURspJ9btR+b9ffQ+al9x+KYFnM16aLNvt1NK6ad+RnXuN8uk+GjRW1vE89pjuvkr7XZoADcKhnpSiN9Hy+4Qsdww6o1Cdb1j8fnOOHg+f8IEqT4YfmZ5lo86epSw/R4vQpjtSaJLV1QpqEyuAJ7UsNHXrKzqIPwHiL50wVLyjXyuWxfwPZDQltRG1o9lpXJIFhpKR3w9TP5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIKOiK9iX5yGwcQZGLTB/RCKAfdrHWGIRHMcC53fGe8=;
 b=Hg7BuhbJzgxHHVWCI0q/BZRDYetIkcVGSW/R6XZu5yoyeFK1BeILEMNbckI2qzrHxENv6bfJlmnPTFs9hT1U8FJBCYEjcHMFmD2Wh3ht652cqEr0oqaNQtq91GoRIJqj/IrdCD1QdND4B4lXjW0R2+/aKyERhP7CSiKqmprQpJcKoh5HV5lq04BP7f2pDFQZLZNVb8hr33QIf5Gf64ysGmki+qKW+UCD7kT66BwdqfYQLwangdPtBfn9EoPugMRJE0mByoHt136jgJnsXTw7y3Y4TCp5ZCEjm6BBnib+fXPMjpCnpWZDRi87xR7+YfdSSy5bv5lBKsWcgBHEnZ7G+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIKOiK9iX5yGwcQZGLTB/RCKAfdrHWGIRHMcC53fGe8=;
 b=Sq+1zJUfMjfagPqswAejdVKafjYGEYC/XxvIqCNhbym4vNGUXUMYVUp90bVaNZNIn6CprZx8oOnxYqZv9CEtFPrVhqqpAvEM/jQKWDDHCEokPlRjRreRNxr6FJjqQZp4asxXnw1Q5aL16TEmHMdRjHVga0UXgleS8SzlJRVo9eE=
Received: from PH8P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::22)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:45:56 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::68) by PH8P221CA0021.outlook.office365.com
 (2603:10b6:510:2d8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:45:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:45:56 +0000
Received: from [10.236.30.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:45:53 -0500
Message-ID: <67fb182c-4baa-4b3e-b59c-64cec20839c2@amd.com>
Date: Thu, 24 Sep 2026 13:45:52 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] x86/bugs: Allow forcing Automatic IBRS with SNP
 active using spectre_v2=eibrs
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Naveen Rao
	<naveen.rao@amd.com>, David Kaplan <david.kaplan@amd.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Nathan Fontenot <nathan.fontenot@amd.com>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
 <20260826223510.3669875-2-kim.phillips@amd.com>
 <20260903040330.GNapjxkgMd2Ey38egR@fat_crate.local>
 <01b57e61-df45-44a6-848b-c19eae226ad0@amd.com>
 <20260924014517.GEarSArVM12m_ZshhA@fat_crate.local>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20260924014517.GEarSArVM12m_ZshhA@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3f8b25-a6dd-4081-d801-08df1a6c117b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|4143699003|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	WzRpBP1IXXHt6+RNL1dyJaUb5LBZAbGcJuCwfrnhq9RboabCMG6ENGgZeDpVYm/n87FTfCq+M1dbBO3VxdTlyCN0fTuYooicb7jOtHjO5dEiTXA/xteLyoEZXcC10BCGW3I8llRf0XutrN+zVp3trAsSOBKDxeLlLsfiRf8jfY81g9//xwFWpU4wLizARAWoIRtiAuIvGuqCDFfO5GSZ8ijSmIvzZG4hb3KcbG4I4sSgLN6HQYFw7Jji0XCiUV+6OSFO/gM3A/9KJLvqigUw5gP+J85s0Ft6syzKaHc7VXWEeMntHqHsBvsmmMLltw7Gx8izkzlEiMV0d8cOc/C0G1ns0Z1pMAV57QtIg83x9dKaHAurizMLdo+v2+yvRjMTLkk0Nrjec2JPEaL8da5UZ+eosY45GVhpi/T6EwVB2mVUfti+OeZd6FV6U6hKbwKRe+7Txbis+BKFk4SWXRZSkccFGdHqFJ5rnPAojZP2Yv6PgrL/XFUo468b2fsnIYmv8N1i1PjX7xgR/onn7b/oprI07ZYLxdO/CXBuQBvBGg+/yl2fGqHi1tqo4D/JIq3Uxx/FHsIDjJJWoT0Ne2mK8dcyQfvP2LDmQTC9yrPggpuDNOs89anbZBo80eVKyUW0g3H0nJ4gdL5pjZ8fit+ThWouzg6wPnQllIOisfTkhVeTCOUH9BCGiBxhM9PaXePsXt5xZ4lna54CCbG1fwVISA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bzE5xzBoAK0Zv9C1OeZorTXfjDyPIU1At/1baXsVkXIdp6V8EBbIY+mFPoyX3vV1o02jEhD6IIyb+WKk6DMsjz1Lch6h4VJlM59uoVlMGgTX1fCwBGxdTci28v5JM9lJROkSR6b/u4zloUyrJmOB/k4418ZGH+hqr8UdRk4Qcunsrx3lk9Cgi3nTyHQ40STOP/IeeeODRSVXg9zK/juf/+YaZjzMLTV+72b7x4yeVCqz6MKsvw+b2HfWZO159gl6TdwqDF5PfCer3VmMNZ69NuVg/P3pGGRKiEiIgXpjl2jrQ/BHaGI96xXDlxPXeo/a9/MS7cYkqhbXlaRmD5DnuZESBkLFVvsSpwc+6FmjoOoYnMBpV3Out8pXwZPeukXUYUZBh978Lh+7R+cTysDaShwY1f4Bm08rjm26f0yNTyPRibMFH0pjGpf5cD6MLqhk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:45:56.0724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3f8b25-a6dd-4081-d801-08df1a6c117b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798

On 9/23/26 8:45 PM, Borislav Petkov wrote:
> On Fri, Sep 18, 2026 at 06:00:21PM -0500, Kim Phillips wrote:
>> That fallback cannot be overridden.  An admin running an SNP host whose
>> workload is dominated by guest activity rather than host userspace may
>> well prefer AutoIBRS
> Why would she/he prefer to do that? Any persuasive arguments to make her/him
> do that?
On the same silicon with SNP off, the kernel's own default is AutoIBRS, not
retpoline. Enabling SNP doesn't make retpoline the better mitigation; it 
just
adds a host-userspace cost to AutoIBRS. So the admin is being pushed off the
recommended hardware mitigation onto a software one, with no say in
it.

What each side actually costs: retpoline taxes every indirect call in the
kernel, and a virtualization host lives in the kernel - VM exit handling,
networking, storage. AutoIBRS costs nothing on entry/exit and additionally
covers indirect branches the kernel never compiled (EFI runtime services,
prebuilt out-of-tree modules). Its penalty falls on host userspace, 
which on a
dedicated SNP host is thin and mostly parked in KVM_RUN.

For a guest-dominated host that trade plausibly goes the other way, and 
only
the admin knows their deployment.

Kim
