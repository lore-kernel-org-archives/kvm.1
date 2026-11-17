Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899461;
	b=dtYUx1UxLzRf7NI0o3g2EbTRVLBeF/9zlfxEyi5J3M0tIdS7z14+6ar1y+sQh3xrMrhD
	 G02QULj79CxFasv48HaGmME73V8qkWII8Xef6CwI7bxCquOhblI1VB013J7oOt9ligZj1
	 7X/ruuanZbTQ60jo/fu1hOCM8YHkf2v9szFjba6DyuPWvSHNTPWmFZRhlug1zzJMnOLJY
	 RkMSpibHbcH10v1O3SxeqH1ofB/sG8nnFpppRWBIQUWW3kmSAUsAjajezfgvyswujK1dI
	 cslvfMzdEYYsDBZVKhnlMQfDQQ8e07X7j7rBM13RaHJTMqXkpQ5QysfnMnnb9BOdxMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899461;
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
	bh=KeJFt+9H17LiXBHaNeznIeiRG5buG5pNmTaeKTspgoU=;
	b=skGncWdIQ/kzkwgtll0wwsPVSuIbm0bH6Yq1/fFkq5sRzNzeblNJp4AqeHRVC+pGGdQE
	 WAKrw/JXYZyr5Npwapk8Oty83dSbbf4ZTmBZ4DbXX/SYZv7SAjEvcZR68wTbBiIROhuN9
	 4DDKtsOceh/+FLkAz3szUAEtJ49u4gPNDEvpGPsJCxpaNZdHM19rRoGlRIRXTsUtHmN48
	 UqoL+GMYqE4jU/L8YIxn/yPg7MTFaxr7X79x64d3zAfuaST4PR3PucBh2OgEq73mL/fnd
	 R6e4nL9UpbLKCztLfpBD5sBN7abtTzJztsJkvrlcupZ8+D6z7XabgDxri9s0sLXIWuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g53PHGcC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.37
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB8606A329;
	Tue, 17 Nov 2026 07:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FBB8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g53PHGcC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkz1y/k3dTwmBT11wzb6LipwhLNpF0e3TOgI50c422YbNn/xAAaxgeDDuFH+lfgT386i7CCuCF9mZ3cpo0b+10C/KHU5NAcW7gJM5FVvRrG1Rq5Oo5v0sdThdhWTE9V2drl6d+4zVcu0ZQxIxZM4sNXHYh8F0DF5+Q2m5hcYFsmd9xztIb/5OqhPkApHE3eDoCJ2pBlCn4KJXiJxeYdrjwZjaQyFFTUBre2iMk/nfDABJmEyO+cVqm+jm4vyA8HHyc0BWS0eJ23Q4dGAbx0dOuzxFNTpn9sGxTk33In+3a0joUdA0XwKbd/dwQl1H8HHmaXG/+rsT6oB4P4yE8lB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeJFt+9H17LiXBHaNeznIeiRG5buG5pNmTaeKTspgoU=;
 b=hSy4GezN+/T7KDv0EvBrJX4Bq4tSvmd9twgaIfyQ2X4IMVdP63lXesw7C2861ljbESY66a3oSGfYA1c3MwVXdMXWQmkgZ9+LnRqbHhiz89uR6y0SKVeh6vmaJnY7peisQXNa0DTA7nq3cSUC0Dt3um6YdW2+tkxn9ESY712is1hd+s6KHwA9NEF7iE8OzfbtgT0IBQP1XJ8D4B/0ISfBRiDkIfj0JBbdFl7LWmby5x0kvq3nj+pfY6R+tU2ZlxgcaNpW1MzTdZ4GMnH1f6K6t+CuwV13BnBgBD4XdQMTM/b2J9tGSwI9j5wAyA4GcWs1TKc/OoWTccf+AIsq75sb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeJFt+9H17LiXBHaNeznIeiRG5buG5pNmTaeKTspgoU=;
 b=g53PHGcCBTnFyIa3MzRgnqwOk/U0paJW5f93Fv7LSXVjZ/6YqjxdR8q9tio2oa6VjLBWwLIe+/yzNz+6db9wcPp9jfUOQsw2Agad6pR/SIJ5u0pHyOnd2o3LYnrIeK2y39uJvJE9i4Rzv2NJi0BkLFl++XNHm0KCYgyQEcdlAAw=
Received: from CH0PR03CA0105.namprd03.prod.outlook.com (2603:10b6:610:cd::20)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:10:56 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::a3) by CH0PR03CA0105.outlook.office365.com
 (2603:10b6:610:cd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 07:10:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 07:10:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:10:55 -0600
Received: from [192.168.1.100] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 01:10:52 -0600
Message-ID: <09c667a7-f5b7-42ff-aca9-838495738d3d@amd.com>
Date: Tue, 17 Nov 2026 12:40:46 +0530
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
Subject: Re: [PATCH v2] x86/sev: Skip DR7 write during kexec when it would
 trigger an unserviceable #VC
To: Ashish Kalra <Ashish.Kalra@amd.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <thomas.lendacky@amd.com>,
	<nikunj@amd.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20261116230335.1161521-1-Ashish.Kalra@amd.com>
Content-Language: en-US
From: "Aithal, Srikanth" <Srikanth.Aithal@amd.com>
In-Reply-To: <20261116230335.1161521-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d77631d-9709-498d-14f9-08df4479ecfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|261026121527099003|261022105027099003|11063799006|56012099006|261021123027099003|261009223027099003|261021121427099003|10067099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	h7FIcdTpL62zsdI7j+MrUTptP1sydnefkozhEZEVOtoAUp7HfSpvsdD7ts05BwwqDaLakO0TguJWs+3RyozmFvHioLqfp5+2m9IPtWxr63jjYWEH+UQdsDJI1UUq+roS5x+LkvvD1cbBFIBJDfMPcYwuuaDMjiZ0AGVKoO1WBY15q3eAzAeGsZKQmOZgGo4a/QZbX1MbEva+0k86r9REOWs6Djn7Cd6U9nRvIAvnOxv2tmMbohFPJzCWkqTWwCnueIsYhsd70Tr3HTObDNAluFGZrfHG6RmJyzeaDVxjzXEnXWNE3zVwk8mITcWOaFUjISkR/c6wJQYP/3fMShnu8sTrM3Vo6RyS5o+eOZI1xxKbxpuk61ZiIwANhdCp+yTgMtcuifcSAFlIBavnyTbchEcL3nGkV/Q6ox/JfAcdFTIHdZeAlvRkFOtxZnp5+9Qv0DQ277fae7uVrfXszyZZ/RbqE4JJSwC16jpWXp+NMkDTgh+zRIROnjnkOnv5xSudu6tH0O96QSjU6xHj7t1dqaPErrPR5SR/QyCVtkxtyBpZF9SWM+YJEvqkho45EOpNLpgHxGaMvmzc1jwVKz71Ca55uWNIL8jmkruC3EFFJw4qYmwHLRfGgACNYPF96W0mcCZP8/iVhe8kkzWtJgNGDgdHinCGZoqNna0Ls8FHJcJMUTTjYLMH5yEJwAOTQJNoga7yjfCnxHj9Up61imjZoA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(261026121527099003)(261022105027099003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261021121427099003)(10067099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uRvhUSjJOxjECShPC2MLVq4yoqhFGCuuBGUXg13ce1f1Oh1CcT6TprmdzENQhToZ3wqMSl0uNCQCEebXKORIr6eQdCIUDum6fvcXQVGtQVhe7HRTQo1lR0ezqK3q0JMvzaS5cX6I6mcTmqDH9aVtgNvlXecKkHKuN24s/7q0WXBU3pQj6aFslLkSJCFpwg0icgvm4n7gdHbVy8X8MctQG+xXT3oVrsGUXpCB5G5FjULDhSWd0z+TgW0tEFvdouheAv0yqN4F/KOnB7xndunuokHJWqTBIn/H6v9/YUoZTkrfy2rIqzhSmg6rLFwa7ekcBeOq7VWv1GB+fPW5Cqs3qhzcS+fHRsrBi33h57gvtlp5HHU0qAqhKV0IrDcQmtUu62OGDcNAL+XIrDgbZtIQJD7Z22HcgT9rYW2YX7d/p3xNrN1lnMgaInr5FCl2scTU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:10:56.7102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d77631d-9709-498d-14f9-08df4479ecfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327


On 11/17/2026 4:33 AM, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> machine_kexec() calls hw_breakpoint_disable(), which writes DR7. On
> SEV-ES/SNP guests that do not have DebugSwap enabled, DR7 accesses are
> intercepted and delivered to the guest as a #VC exception, which must be
> serviced through the GHCB.
>
> By the time machine_kexec() runs, snp_kexec_finish() (called from
> native_machine_shutdown()) has already converted the per-CPU GHCBs and
> the boot GHCB back to private and set boot_ghcb to NULL, tearing down the
> GHCB infrastructure. The DR7 write therefore raises a #VC that
> dereferences a NULL GHCB pointer, causing a page fault and the kexec to
> fail.
>
> The NULL boot_ghcb pointer is a result of commit 3645eb7e3915 ("x86/fred:
> Fix early boot failures on SEV-ES/SNP guests"): that change makes
> __sev_get_ghcb() return the now-NULL boot_ghcb in this window, turning
> the previously-benign teardown-window #VC (a bogus VMGEXIT the host
> rejected but survived) into a NULL dereference.
>
> Skip the DR7 write once the GHCBs have been torn down; the kexec'ed
> kernel re-initializes DR7.
>
> Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
> v2:
>   - Move the check into hw_breakpoint_disable() through a new
>     snp_hw_breakpoint_disable() helper, so the SNP-specific logic lives in
>     SEV code (Borislav Petkov).
>   - Drop CC_ATTR_GUEST_DEBUG_VIRT and read DebugSwap from sev_status.
>   - Skip only once the GHCBs have been torn down, so use_temporary_mm()
>     keeps disabling breakpoints at runtime.
>   - Trim the commit message (Borislav Petkov).
>
>   arch/x86/coco/sev/core.c        | 16 ++++++++++++++++
>   arch/x86/include/asm/debugreg.h |  4 ++++
>   arch/x86/include/asm/sev.h      |  2 ++
>   3 files changed, 22 insertions(+)
>
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index eb2e853e950a..64a5a037a9c8 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -723,6 +723,22 @@ void snp_kexec_finish(void)
>   	}
>   }
>   
> +/*
> + * Without DebugSwap, a DR7 write raises a #VC, which can no longer be serviced
> + * once snp_kexec_finish() has torn down the GHCBs.  The kexec'ed kernel
> + * re-initializes DR7, so skip the write in that case.
> + */
> +bool snp_hw_breakpoint_disable(void)
> +{
> +	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> +		return false;
> +
> +	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
> +		return false;
> +
> +	return !sev_cfg.ghcbs_initialized;
> +}
> +
>   #define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
>   #define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
>   #define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
> diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
> index 854d82b88ff4..af15e2c928db 100644
> --- a/arch/x86/include/asm/debugreg.h
> +++ b/arch/x86/include/asm/debugreg.h
> @@ -8,6 +8,7 @@
>   
>   #include <asm/cpufeature.h>
>   #include <asm/msr.h>
> +#include <asm/sev.h>
>   
>   /*
>    * Define bits that are always set to 1 in DR7, only bit 10 is
> @@ -108,6 +109,9 @@ static __always_inline void native_set_debugreg(int regno, unsigned long value)
>   
>   static inline void hw_breakpoint_disable(void)
>   {
> +	if (snp_hw_breakpoint_disable())
> +		return;
> +
>   	/* Reset the control register for HW Breakpoint */
>   	set_debugreg(DR7_FIXED_1, 7);
>   
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index c7ea9845351e..f38bb521987d 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -522,6 +522,7 @@ int prepare_pte_enc(struct pte_enc_desc *d);
>   void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
>   void snp_kexec_finish(void);
>   void snp_kexec_begin(void);
> +bool snp_hw_breakpoint_disable(void);
>   
>   int snp_msg_init(struct snp_msg_desc *mdesc, int vmpck_id);
>   struct snp_msg_desc *snp_msg_alloc(void);
> @@ -632,6 +633,7 @@ static inline int prepare_pte_enc(struct pte_enc_desc *d) { return 0; }
>   static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
>   static inline void snp_kexec_finish(void) { }
>   static inline void snp_kexec_begin(void) { }
> +static inline bool snp_hw_breakpoint_disable(void) { return false; }
>   static inline int snp_msg_init(struct snp_msg_desc *mdesc, int vmpck_id) { return -1; }
>   static inline struct snp_msg_desc *snp_msg_alloc(void) { return NULL; }
>   static inline void snp_msg_free(struct snp_msg_desc *mdesc) { }
>
> base-commit: 9f74092fda91ef93c2b07585785c1dc83cd7971f


Tested v2 on top of 7.4.0-rc3[aebb727]; kexec works fine with this patch.

Reported-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>


