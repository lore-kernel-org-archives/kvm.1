Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B73D0919;
	Mon, 24 Aug 2026 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552513; cv=fail; b=oIuRes2poypjw4np7hm7wIm+CjcD5RL8T+HhzexMzpCMtvN0gdcwkVcAFQgk6gkFWzHFCmrz1sJu+KYIZEblrHVwqfPpY1EBjRGqH6r66HfmlbvAe8QyLIEZJYCHlqixPhQfxiDzueGj9CLwSky6ALqRIbMRHduhDbwHdPm6bgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552513; c=relaxed/simple;
	bh=e9/QOFaMYg/v3hJW6sakKhAbsGr8KPudwt2fWlYbI98=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jLhNt1O5npChW03kGwxE3HAVe5ZDZUxnMZtOr7xwUE6oxs3XqRQRx4YujcJmZSMiVCup3PciXAU221bvDCEQwNhCH2dB5SM/kfaFMHGZq1GQWNzoMDTxclVmyrkk0Bplkf9ZC3FWGtUa/JtMrt6Vxy9CVYYsTf/MAEHzmfdH4pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=35S4EGLA; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="35S4EGLA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imHYZss4XGBP47mJl9S4bikpMPZpiIIeM99aq0Wav0bktMsEr1j+GFHWu6bjGq4P2cBqIFCUjQJxA1F5vZ2GdIyXUxbFS8XUlidPj7M8Z2ak4mrXaM052cinPHyUUXUNKrkxNq/cTfOCx3yYZZ91CwSSB0LVjONyrevLhLo31tRJuLgt96pKSb3RyeH9khFu/OkoFthxFCVjXc8QkjxRfPZjaLJlOUZxy8UB81UT1p7RelQi0XOG0J4TBTJoB8bU2i3u5zGge30+k3n+1jHv4ugz4AYWBPhWHNIXz5AS3/qLgdysD7vuZY2UixYOgKjsJgBvbw7CQDKNDk/4T1XxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c9UXBOWBr0TZqLJJzV8cfCkUVul/2dkkOSvB71Cg3E=;
 b=IZp/6EGWWz7Gf3MgzpGiCw8FJrK2wAP/QpyUX4gkH4owcCkwDJxihs2v46vkuIkaDOwBYPzyOqc4rW8rUjhvSGIvaGVOXvAIfdeQEWx1A0wDWdsVj+opWuc1DFxshCZTdye+Z0J0jPRn6DzP/Ahxc4HzkyRvQ2TBUdLl8sAGQByLx2RL9wpNF+2JCMX00sHLmg91hueJmIMcaSRvdxjQn3zdkR0mcJHtDENAeToWGyZ3YXpx7l6EANb0uRGTWlCocubILCBawnVM2yp/Ajoc42IIfIDXZ6DwgyNOJfUYU7C8AMeAAJaizWjCeQEv0V+zNlEyLRJ6JYgqZDVi4SBVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c9UXBOWBr0TZqLJJzV8cfCkUVul/2dkkOSvB71Cg3E=;
 b=35S4EGLAuYHHwkFZYqbFaqcINM3qiw/1RPSi1OkGD9GXZMxwPW9yUFzBd6OiGDeZ1bHbxIDvfdyEhcXYEiHusMIPvkbsefjo9R6j53YY0j4/vIoNq+Uhh4kGAD9KKNBQkax2XSX/hqqVbk/ALVk0DegZaxzi5aY9YAA2FoEYsN0=
Received: from SJ0PR13CA0152.namprd13.prod.outlook.com (2603:10b6:a03:2c7::7)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 06:21:42 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::98) by SJ0PR13CA0152.outlook.office365.com
 (2603:10b6:a03:2c7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 06:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 06:21:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 01:21:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 01:21:41 -0500
Received: from [192.168.1.7] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 01:21:36 -0500
Message-ID: <930eccc8-23ca-44c8-b91d-3567708e317f@amd.com>
Date: Mon, 24 Aug 2026 11:51:34 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
To: "Xin Li (Intel)" <xin@zytor.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <andrew.cooper3@citrix.com>,
	<chao.gao@intel.com>, <hch@infradead.org>, <sohil.mehta@intel.com>
References: <20251026201911.505204-1-xin@zytor.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20251026201911.505204-1-xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b9b3e2-de28-4259-3be8-08df01a7f6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8FZJqiFt+fYsi331oPGVV8XvyEq8SkTEeYbqITm70ilqNP78afeHKQ3/iJp7j0y+BNzmVqc+gFeXIXRtIYd608XfwQFfrOef85SQ9z/sai5/zbIX5qHqlB9PCbq0j4kFMYzOUhkENDdwiQ4GMbrr/NCwTO63BVs/q6UqCbjhYJqifNaF848zoDhlutyHyzf3E5u2VS+pkkQcyymWlEhjjsSstV7SsseA8SQPOvX+dxhYn+neHiWg1IFWNmiDY0ZLsQBa+gBY2aYfW7ly+x7QtGUYGBAW8V0+Tbg/8pDzPuOK+BLdz1FB47PMX9/cRSQ+xyThVjzv0pvxwf4kkfXmY0ywaVPgid9iU2ZtB5kQBvjunetBhTAXGF1VCA/NN7Cox3GdIOwrLYIIhfcCjwCd/xBFABl7Cq2t6n7lEnZmiiEpSOXTXY8ICZep2TDNsaKN0OGWqHdGhyNLRU/B00JL+JxQQjTsH3dzqsKbYtEw7q0NqCvpbwpIUllwA9HNLezQBKRWtmiAqGXby75cyiCsy+mACzc9kzg/rtlQzbq6qdlxM9pK/mdoqPDhq2Z9HYTuRdUnEnnfBUL4gOe/Enx1ullYrx3QZVCB94JPG9tmyCugT5P7CD3jZ86ATH/tYRrTtufVBT6nrWCcyuDkHM/I33rmXvRH5aysGW61v5N9IL6Mw1laK3v1cZXcpMIsZnU8M/BNamLxmXzp26av3LcMIA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Kf6qCUkYZkp+g0NlPX4rakP8+zxQMH+ZMd+20uamcgMVNZU54aHVoy6IoySzR3fVdb9j4+mc8xVnUfu0Hm9vqE0ImPPqoyjFHE/JycMK23qjJhXJO3H1loFZy8Ic3FCI5NLTMClNwHHjc5m+Co6TZM9x6Yl/2zZ0Nof2IsUMmMjxfoJ4lLE0Jf04QbUyKcJ4ZcyqisgPVwc6KDe27S2NVfFl2fU7FtxIWeQ69H+78pEZFHhO0SiDDTM86ve70EWY4HLzfKPBdhm4EUvhYxina9uu7bIyhpkMPkK6jMqxuf+evEfsANHodqxCkAdGt+CydRaWnmzKztGJ4+TBVdtOH/ir/1iqPeCY+jK3ypxiq3BcBghyy8BiyWqXsDAZUq79VJkgB3RhBCXz5CoHh2AF6EIcy9gr3zTJQI9nnBl4+Vg2eWmdVY86QylgmSYjgiT/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 06:21:41.9849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b9b3e2-de28-4259-3be8-08df01a7f6bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265

On 27-10-25 01:48, Xin Li (Intel) wrote:
> This patch set enables the Intel flexible return and event delivery
> (FRED) architecture with KVM VMX to allow guests to utilize FRED.
> 
> The FRED architecture defines simple new transitions that change
> privilege level (ring transitions). The FRED architecture was
> designed with the following goals:
> 
> 1) Improve overall performance and response time by replacing event
>    delivery through the interrupt descriptor table (IDT event
>    delivery) and event return by the IRET instruction with lower
>    latency transitions.
> 
> 2) Improve software robustness by ensuring that event delivery
>    establishes the full supervisor context and that event return
>    establishes the full user context.
> 
> The new transitions defined by the FRED architecture are FRED event
> delivery and, for returning from events, two FRED return instructions.
> FRED event delivery can effect a transition from ring 3 to ring 0, but
> it is used also to deliver events incident to ring 0. One FRED
> instruction (ERETU) effects a return from ring 0 to ring 3, while the
> other (ERETS) returns while remaining in ring 0. Collectively, FRED
> event delivery and the FRED return instructions are FRED transitions.
> 
> 
> Intel VMX architecture is extended to run FRED guests, and the major
> changes are:
> 
> 1) New VMCS fields for FRED context management, which includes two new
> event data VMCS fields, eight new guest FRED context VMCS fields and
> eight new host FRED context VMCS fields.
> 
> 2) VMX nested-exception support for proper virtualization of stack
> levels introduced with FRED architecture.
> 
> Search for the latest FRED spec in most search engines with this search
> pattern:
> 
>   site:intel.com FRED (flexible return and event delivery) specification
> 
> 
> Although FRED and CET supervisor shadow stacks are independent CPU
> features, FRED unconditionally includes FRED shadow stack pointer
> MSRs IA32_FRED_SSP[0123], and IA32_FRED_SSP0 is just an alias of the
> CET MSR IA32_PL0_SSP.  IOW, the state management of MSR IA32_PL0_SSP
> becomes an overlap area, and Sean requested that FRED virtualization
> to land after CET virtualization [1].
> 
> With CET virtualization now merged in v6.18, the path is clear to submit
> the FRED virtualization patch series :).
> 
> 
> Changes in v9:
> * Rebased to the latest kvm-x86/next branch, tag kvm-x86-next-2025.10.20-2.
> * Guard FRED state save/restore with guest_cpu_cap_has(vcpu, X86_FEATURE_FRED)
>   in patch 19 (syzbot & Chao).
> * Use array indexing for exception stack access, eliminating the need for
>   the ESTACKS_MEMBERS() macro in struct cea_exception_stacks, and then
>   exported __this_cpu_ist_top_va() in a subsequent patch (Dave Hansen).
> * Rewrote some of the change logs.
> 
> 
> Following is the link to v8 of this patch set:
> https://lore.kernel.org/lkml/20251014010950.1568389-1-xin@zytor.com/
> 
> 
> [1]: https://lore.kernel.org/kvm/ZvQaNRhrsSJTYji3@google.com/

Hi Xin,

Any rough idea when v10 might go out? I'm about to post v3 of the SVM side
and would rather base it on your latest than on v9, so happy to wait if
it's close.

If it's likely to be a while, a question for the maintainers: would it be
reasonable for me to carry the common vFRED parts of this series as
prerequisites in my posting, with authorship and tags intact? Some would
need splitting out of the VMX patches, so only if Xin is fine with it.

Thanks,
Shivansh
