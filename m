Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E469F547067;
	Fri, 18 Sep 2026 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772534; cv=fail; b=nMRXunkOnR9CIkpr/u6yGXLEQ5oWo0KU+rIp5ZVvRfsObwxfArWnWTm6c/gg+74QyqrjAWTZAQvQem/lJlRYQ27brfWWftvcR6JIoI2nWmka80UO1JJBhXQl14ZWqbi4hs8LPgpw49uwhtAf0PzT6SyHfUQxo/ABLnb1Zmd7UTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772534; c=relaxed/simple;
	bh=M2HEcTSpU8xxnTY7i10BrxusFTmH/BINVcNUAnOg6Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jdIORoNpYlqe0R48BhJVneQCpXp2wh4JuhUOQ5i3PIyYJdRr5BZv+VqOegk52BQ8DXpJF4sPOlQmY/uDevlIp8DxipSW/AtM9INe2BZeNj8IxdBuryXIBUqdoTyhxsfg3mgEEJ9HbhlPD4BwoW6az+/4e1zf+Jgp+yXwJ892KU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CRFySAUB; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CRFySAUB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6avkbmZtOKjJTbCghJV6kdDE8zZI9TPYHePCYIHsckepthVCSJloTqu0Rc22ahgmLEyjudYFEr2hJ2BX2zXSnvZpR+Mn+dq0EJ4RggSz59le9n/p0B3aBvoTIjsJ5ZkeKWSMM//eqsjtMZ9ubobeRoD2eh3gPItQJOymKJRArWGeizzBPzi4G9jIZON5Rcak/p7CitIpVc4DGsM7sNojmmVMFsoe4DCAoixbp98gb3meyIG8Wu4ehJwZpx2EC/jNzkEuaF5MAUyimJE7NvGlvX6WlwN6azzcxOl38jOh08Gd/EyxRtcyjrr2T/OT622rh48+6HP9kwoePPPAbgwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2HEcTSpU8xxnTY7i10BrxusFTmH/BINVcNUAnOg6Lg=;
 b=tCR/IFE+Qy5uEc+L5lHTMUBrf0KI0SItzDkjKTnhAW67Db9zksPgkXqT6SObJ1mzHhd8Fz4ha84vVGdNEo+9iF6V4llCCN07D1gAWGCVhR9I7QU+ts1YXWWALAyXLIo688mBNLhQZE8dBXnD3ICHV7TeJYJqFgmKwdMgiXpNCMZY2ouG2D7kQrvafUB0JU8VahMwUdNK2INYzYPsKt7X15lfvVAqBJnF0SPjE97VDjzYhQ92AQBKB5qRP/aZmkqOY2FAxQ6NltHvvMp9dTCAgbskRBfnR8MEC1sdyICIYLJJqbuAWPNMpNBaGmPpHjP3uRnBqeaDnH0Cem+SQqjelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2HEcTSpU8xxnTY7i10BrxusFTmH/BINVcNUAnOg6Lg=;
 b=CRFySAUBqEk2yjmObDV0H/8/leIkJUgZtAsmFcTA4IdyJzgF45T9i+4FrxsBVrD7GoxLGpOdldDhEYhLqdE3zFW9LEiXvPLFub5rWswpv7qiLsjSmI+kGJL+jjKUIvqxeRv4VQ3r3Z92tn0wFHiVYlJM/6NxTMjETdRODcCDJM8=
Received: from SN7PR04CA0003.namprd04.prod.outlook.com (2603:10b6:806:f2::8)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 23:01:57 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::36) by SN7PR04CA0003.outlook.office365.com
 (2603:10b6:806:f2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 23:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 23:01:56 +0000
Received: from [10.236.30.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 18:01:55 -0500
Message-ID: <9b85be41-db5a-4bdb-95b4-beffb05a5ffc@amd.com>
Date: Fri, 18 Sep 2026 18:01:55 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] x86/bugs: Allow spectre_v2=ibrs on x86 vendors
 other than Intel
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
 <20260826223510.3669875-3-kim.phillips@amd.com>
 <20260909210101.GBaqHJDWSUnpjqNcyB@fat_crate.local>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20260909210101.GBaqHJDWSUnpjqNcyB@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c683cc-d1c6-4590-1def-08df15d8d69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|10067099003|5023799004|11063799006|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	pFP0aLA5oYsi7TmcdvjPNDIV/OcyZKbQtUHZIhKSSHBevqjofqbi8Ab7+OGknryKCIK/dTTbPK0C9prFHzG9Yo7/Le399QHOqIOqia4l9kn8H0mGSUfu4XB7YkBISPMP8vHCcjRytKlmrmaa6+37tBFZ59HuWxLhAo6OwPAjVy3pVaivErkZc9nrApJ39BnqrqTd62hpSRPHrS4m524C2qW7FFxEzgC3/r0rZs/dqHzl77YwGYpoxz9gucZBYPPvYKX6tMSGC4pQHO3fTB47Q8XALYbQPj9wX4R4t2a5WkWpVCL7GDSVOK+sgTh6iTr+exVeKlsVR5nzeZ1qssLWZZfhfla3SvtckYQUeth2mfJMxHXfdE5Sdb9y6YBghMVSWI9U9bYZeNTqhYREUmme8raFuFdcVVF4E80b0loJtMyrJHc4FYhWIECccbVUamCt4z7piIqKTiKvuWM5rKE8iPdu5tKhGtk1xb5LMEW5I6pSPnhWqroTSuGGvxCSiW0G3/FN+qT43KqXr16trHGKauVWlu5LJtTzlN+yn2KZRnBG1qS/xXWVvc40zdcwtsuzZwsfHe9VVpu8DZU53CJ3onkPyWAtUFJLe2/rZU8JtyNBDaBCBi7Ft1wgutycIJX0e4oSq+YCxdPpbyaCmGM0faBho/DDDcT8KmgPsfeceP/W+gIqFPFGOk95C/0Ynr/kKZhU06sjEhMUmPdYSqIyCw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U+cV2OnSMEdljUOGTpLCUanaQX+mBXeUkJOJzOqNnLX9+5ccGcscNh5oc23bUtDKOKkGVIvqU+lut1Mn3qQo4++vTpWLYT25Tz8xrWMj4dz2wBlOqe5gMmBL/Vk38j6DXTt7LdcqK+/94/pJmgBupefDLw6w/JvWJ9PdSZg3GCLg8bYLjJ1Pb/JLWNu1zYPBOhgleOA3tNFGT0l55aXGsVUdUturNiV1yeT8HuKUFj9HAHtB61P8I1PJnszFISuSjFJyaAM5SBom7cBJi0VxqdxF/qe9L9YB2i54n1EDf0A1MbLvMBIjaQmqWxVuogNMiduKOwpuwr/N6JCD1G/E5DDUIL7HBKkE1ti9S2Y2l9kh7gfWyfMhYUom9D1sJ17ElEx0WfDHS9xRtA1ZGtCGWDSU/DYqqjVnEkQA43Po8sHT/j9pGvWg2f89Pikf3+cz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 23:01:56.6475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c683cc-d1c6-4590-1def-08df15d8d69b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145

On 9/9/26 4:01 PM, Borislav Petkov wrote:
> On Wed, Aug 26, 2026 at 05:35:04PM -0500, Kim Phillips wrote:
>> Prepare for legacy IBRS toggling on AMD, where the BTB Isolation
> Same question as before: why?
>
> This commit message is explaining what the patch does. It needs to explain
> the why.
>
ok how about this as the new commit text?:

SPEC_CTRL.IBRS is architectural and behaves on AMD just like it does on
Intel, but the kernel offers spectre_v2=ibrs on Intel only: the option is
rejected at parse time on other vendors, and MITIGATION_IBRS_ENTRY cannot
even be built into an AMD-only kernel.

AMD's SNP BTB Isolation needs the kernel to toggle legacy IBRS in order to
optimize the VM exit-to-re-entry path, and right now there is no way to ask
for kernel IBRS on an AMD machine at all.

It happens for historical reasons only.  Commit 7c693f54c873
("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")
gated the option on Intel because Intel was the only vendor that needed it
back then - there, kernel IBRS doubles as a RETBleed mitigation. Nothing
in the IBRS_ENTER/IBRS_EXIT mechanism itself is vendor-specific.

Fix it by dropping the vendor check from the command line parsing and
CPU_SUP_INTEL from MITIGATION_IBRS_ENTRY's depends line.

Keep the IBRS-trumps-retbleed logic in retbleed_update_mitigation()
Intel-only, though: legacy SPEC_CTRL.IBRS does not cover AMD's Branch Type
Confusion RETBleed variant because RET prediction comes from the Return
Address Predictor rather than from the indirect branch predictors IBRS
restricts.  Letting SPECTRE_V2_IBRS trump retbleed on AMD would silently
drop the UNRET/IBPB mitigation that does cover it.  RETBleed selection on
AMD never consults spectre_v2=, so spectre_v2=ibrs neither adds nor removes
RETBleed coverage there and the retbleed sysfs node keeps reporting the
truth on its own.

Two more things need handling once the option becomes reachable on AMD:

AutoIBRS-capable CPUs would take the EFER.AUTOIBRS path for any IBRS mode,
handing spectre_v2=ibrs the always-on AutoIBRS behaviour instead of the
toggleable SPEC_CTRL.IBRS the option asks for.  Restrict that path to the
eIBRS modes.

And EFER.AUTOIBRS survives kexec because head_64.S preserves the incoming
EFER bits, so a kernel that ran in AutoIBRS mode leaves the next one in
AutoIBRS mode while its sysfs reports "Mitigation: IBRS" or a retpoline
mode.  Clear the bit at the top of cpu_select_mitigations() next to the
existing SPEC_CTRL kexec cleanup - a cold boot has it clear already, and
that spot precedes the init_real_mode() EFER snapshot the AP trampoline
uses.

Thanks,

Kim
