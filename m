Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013031.outbound.protection.outlook.com [40.93.196.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B61E98EF;
	Fri, 18 Sep 2026 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772443; cv=fail; b=Hdxbo5cmUsjTRjF898xv5meNLJwSiTH5mKwICnRXLftMF6LIjkaSGWuvP0BzSKR+/McQtglx3sqK7JFR6L2/tymvNjzOcJSBhq4yt1vxbOyGf60FZho8EVGoup8Vw4kZNjytQ+8Gayit/gwoPA850yqIUq3j0v+pZ4N3eTyAbJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772443; c=relaxed/simple;
	bh=vOZw96XBj/2QzdlAoPXLGown+4IxJoA8tbR3hUsQJVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZiRvAmR5RPGpKEocUDIzT3WFZpUiT2+oT3Ay4+DRXOJWo8LLn+ah/UY0O/Na6JxEiSYuPU4MLT/s7Bk2ia+UJznYUsG+W47kjeLepIM2niv4ucistXGtDEnq5iPbjyxTEsT3BMbOtqdWe3+P/j6qNbOAlcJW679nTNOs8VpCiw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JnhUUJeC; arc=fail smtp.client-ip=40.93.196.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JnhUUJeC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTcvPrOpgWcmp3q1POfwQxOXSFaOWHxMcq1tyhys+7t6Qy11Q6E7QKzP/JqCiAFkr43cDqrli2wWSEhD3sKKc7pxBGabyi2J3bijur3CRgWVGbiqBne20YjjsY+IS6o2SIvcN/WhLa+xpezVxWIkZrkwqqwGIBfEcP+aWLPoEqvBpfkHiMyxXAtyaEWILfC3KW3nKs77MOomKyiyU4Dvg8K2DnSycY1y8okd2RqaEIxfKOfiNblkZZZd4831kA7sW2zUK8UXHVu9r9Gvkb9YR3G3BbgUbr/UoOdZJCA0xbgeiAZyWpLJn2UlDsyE9ay7r1y+OQWjJZ8FFM12nn2OOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLhrJ9jjIckdmgrFPezkzoXAcrUL9/oi2WBVeq9cRpM=;
 b=YLP9i0vvy0BXHbk26dRIQmn+PIOV7rkwkJx7fgnbpJ72wQ1QlqSRw3fzBOAaqIQO6JimWoZClpMLHaPJdkort9W/jE+4y6nh41ZfFhL9Pa1JXhj/sMDvjv9sQtCr03UGUH1GO57ORNfn4rMS7kFY45uqVVHUA7UGHjGRgbsdh7Ux98mXRrOi/N4dcxL2RbspckHbmSmpFFJzVEjblE3D0hn/r2pATAkjOzcDm6U1921VimA7FNxbpmMvCbjRbSnok6mVOnct5zLmUGcav8VPCG9TPkazywqcdZHprWAcVKcOIaunk6unGsBwOgELskFnxpHThla/6iNWn+3m85rD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLhrJ9jjIckdmgrFPezkzoXAcrUL9/oi2WBVeq9cRpM=;
 b=JnhUUJeCDU457Hr7tiVzezWjsq4yaBp3k9rsERVhN4dpbjVazzx2fDqUqNocoefBYXQKj2gZQcsFD8aL0WYSnkHqdXLliA+ljs2ZUTFPgiad9GQMXWDkInzRERRcXOaXLzJfC0HLL/puOZ+t1p0+iEsjHtNj0U+kPeMxreB+plI=
Received: from SJ0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:33b::14)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 23:00:37 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::7) by SJ0PR05CA0009.outlook.office365.com
 (2603:10b6:a03:33b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Fri, 18
 Sep 2026 23:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 23:00:36 +0000
Received: from [10.236.30.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 18:00:27 -0500
Message-ID: <01b57e61-df45-44a6-848b-c19eae226ad0@amd.com>
Date: Fri, 18 Sep 2026 18:00:21 -0500
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
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20260903040330.GNapjxkgMd2Ey38egR@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: acaa61d1-1f3b-4153-93f0-08df15d8a6ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|56012099006|4143699003|5023799004|6133799003|3023799007|11063799006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bbnT5xYXOjAgo5iyqgIlJGjJfBw8KUvs7AdpHOp5plOpGdF6AlrQsvJcBThz8zGtJzUEJWfsbwm14pIUFKEyWBcRfmNs9zYdXsbdBxed2NdbcaI8IUfoa3fOEyG0UunXhT2JLW2d90i0y4Xlwqp42O3dmgbkVynJnU0ZHKgqKox6NzGyuJwIp9bfS6FW07dpo/cPZZnvmtisOpcxe9zkCtXnm2YCzMC02+T1yibYSKfQe7rH62EsPbg0vPfpMbwz3kR2WytBVAo3wyF+Kv9NAOsQHoUq8TSlykUrEkl85yEaj8yTJ3j+LiSlEaQBroEKFZkiXtNyMZavDL64MwHGmdlkR81jOnKZP2zVA5dUnVw3u27wqbkQurfYnC6y1LFYEtEO/mByHfb1rJdYxO9kVgnkNN550zFAIpEuR2gR3n74wAQQL59b1TkOuWDvPaTj6dpYJBFOGu1p/7dEDzOO3JanlegQjrshIiB4DHKI+e4cmpZ0963KKuRyjEaeBaME5AATxviybOR0mq9C0jU98j5WVKi4e6LVn06L+O8ICBBnUn0J1NFjjX7ftMdVWjbyeRLSOU8AE7Ib5DZ+/y2qFmWmwsa0PXxYFZRtq87Xlp3Pmb/uqoZU7LmFa//yvagGj+46xGfPCVj3oZqzHNBAOjjE8E7mO8BGLQF2ZTdH6dy9Zlyysf0rpThPxPba0NHQmYBS9Q35yof4E4H+vRKzdQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(5023799004)(6133799003)(3023799007)(11063799006)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o4Wk38uqRSA2Rj8MG6rKQ47hhpzlWZIHymA9mJiCQE1rFW+4DpyAPzBIKcPUHTQgyHu2zoFNi4Jz6NCwRnrOidEUgJkUw6J47gRk/VnU7UFSMl/ZEaLzLjQU8Z6jf5hCLLxTaG/B2Du3AGJNsBZujkZZNnp8XnL9y4iOdc0G8O1K3tseH2CN/AGC8CNoPYIYCovxGe8FwtDlOCQRpeSxgrJU5mqbv60iYjxdhtfLiXwT48VNynl5osSB4onJRTQZZ1GPJ4iSc71XB996RutX8bZBeL2B0lJcSI8vEc9pEeWxBjw4Q4p0z2Mk7W8F72UZe+rxYqOylmW38DUOoduzYLPEaIP4ErNIBhDp/t6TxMziR5EU/wBz4Mm6vReT3bhHIKXEVs4jXuaIJe5WaMV+RgJcXeotBDKe9h3ogdi68ZJLOrIfDAkwHc8uTlAOimQk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 23:00:36.6660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acaa61d1-1f3b-4153-93f0-08df15d8a6ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134

On 9/2/26 11:03 PM, Borislav Petkov wrote:
> On Wed, Aug 26, 2026 at 05:35:03PM -0500, Kim Phillips wrote:
>> spectre_v2=eibrs currently enables retpolines when SNP is enabled,
>> instead of AutoIBRS (EIBRS) because the commit that disabled
>> AutoIBRS if SNP is enabled stopped short of enabling
>> X86_FEATURE_IBRS_ENHANCED.
> This and the comment below in spectre_v2_select_mitigation() is somewhat
> hinting on what you're trying to do here, and I can only guess. But
> I shouldn't be guessing. Rather, the text should explain it clearly.
>
>> Change the logic to enable X86_FEATURE_IBRS_ENHANCED, and move the
>> decision to switch to retpolines in the default/"auto" case in
>> spectre_v2_select_mitigation().  This allows the existing
>> spectre_v2=eibrs logic to work as intended.
>>
>> Condition that switch on CONFIG_MITIGATION_RETPOLINE being built in.
>> Otherwise spectre_v2_select_retpoline() returns SPECTRE_V2_NONE and an
>> SNP host with AutoIBRS available would be left completely unmitigated
>> against Spectre v2 in the default/auto case, which is worse than the
>> userspace indirect branch performance loss AutoIBRS costs.
>>
>> Also emit a performance loss warning for using AutoIBRS with SNP
>> enabled.  AutoIBRS is activated for all three eIBRS modes via
>> spectre_v2_in_eibrs_mode(), so use that helper to cover
>> spectre_v2=eibrs, spectre_v2=eibrs,lfence, and
>> spectre_v2=eibrs,retpoline uniformly.  Word the warning in terms of the
>> eIBRS mitigation enabling AutoIBRS, rather than naming AutoIBRS as the
>> selected mitigation, so it reads correctly for the ,lfence and
>> ,retpoline variants where another component is also active.
> This whole text is explaining the diff. Never write about the "what" - but the
> "why". Why does this patch exist?
>
> Please structure your commit message something like this:
>
> 1. Prepare the context for the explanation briefly.
>
> 2. Explain the problem at hand.
>
> 3. "It happens because of <...>"
>
> 4. "Fix it by doing X"
>
> 5. "(Potentially do Y)."
>
> And some of those above are optional depending on the issue being
> explained.
>
> But do not explain the patch. If there are questions about it, I will ask.
>
> Thx.
>
How about the following as the new commit text?:

AMD's AutoIBRS is the hardware implementation of eIBRS.  When SNP is
active, AutoIBRS also applies to host userspace, which costs indirect
branch performance there, so commit acaa4b5c4c85 ("x86/speculation: Do
not enable Automatic IBRS if SEV-SNP is enabled") made SNP hosts use
retpolines instead.

That fallback cannot be overridden.  An admin running an SNP host whose
workload is dominated by guest activity rather than host userspace may
well prefer AutoIBRS, but asking for it with spectre_v2=eibrs silently
yields retpolines instead.

It happens because the SNP check sits in cpu_set_bug_bits() and simply
leaves X86_FEATURE_IBRS_ENHANCED clear.  Without that feature bit, the
command line parser cannot distinguish "this CPU has no eIBRS" from
"this CPU has eIBRS but policy turned it off", so spectre_v2=eibrs has
nothing left to select and falls back to auto.

Fix it by setting X86_FEATURE_IBRS_ENHANCED whenever the hardware
supports AutoIBRS, and moving the SNP policy decision into
spectre_v2_select_mitigation() where it applies to the default/auto
case only.  The default behaviour stays as it is today, and
spectre_v2=eibrs now means what it says.

Keep AutoIBRS in the default case when CONFIG_MITIGATION_RETPOLINE is
not built in: there is nothing to fall back to and an unmitigated SNP
host is worse than the userspace performance loss.

Finally, warn when eIBRS does end up enabling AutoIBRS on an SNP host so
that the performance cost is not silent.

Thanks,

Kim
