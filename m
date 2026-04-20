Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C519382391
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667145; cv=fail; b=mqIJE24aRkdcMVd1oPpFkOkDwKYXhqliAxfyR9osEB32kFgeedknDfDTQrg4KyF8I9y72LIRJgl+z4hMJIwWV6c1edV2Oy6+sn43OO4kAf6N9mZ1zz8xxFMXbfOg94/V4f9TtvuyNbekueQySlG1G7YhaUTFpdwh0pn0JkSBZIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667145; c=relaxed/simple;
	bh=dKvn41r2lXd4v/qh8YmGO/Aym38A07lR1J+712idAok=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qKk1ABHwzNQ6/IoCTTrW8f7pe0sPz+VNuU8RqASL0fxuKw7mK9NYkid8UJ3Q4G9c4QsQ/KSlFQ8UTQtaXiDjRBLPuRa/cfNNTcPi+UPOQVN2HoX4xxeT99cvf6wu/afoOmTlNAxq1uTd0Xfj6mqoXFlT/t/iji4DeeuoNtWz4u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V3splT8O; arc=fail smtp.client-ip=52.101.62.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V3splT8O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXCU/ZaPZe9EXpMkS8cw8UcbuzG5MRctdS1QWvqjYk5CyFVPx9BayqFxCY/Zqu/0di7AzWca50F/8rysu5VqPIQbzzgfb67LqPe2hhWk3AoT6oKuT+4r2utUm7aSgLDZw555O5k4s0IzmoYXhKDJzEUcacE93lWD4lVWVEDZYUT0V7ZOe2i3n1mgwppbQDe+CxMwWbKkW7iQqgcFhHL+s70h00nZBiti73YVTto2OP0jR4ofnYGJzeKlsCIBHPIZrW3pS2nasUSlTHJw31NEtfWqDYK3hoB6GwlMK1ReO2JsCUqxQdS4KmxdKJt1qg9LedLCB+R59+JzbSkC8dw1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5iFD41BL/gXVpYgOxHv7Cs6kuaoEzHqKT0WdscRGfo=;
 b=JDfgQtMaowhQq0VE4hagaWIwLx7cdpgoKKVJMaoHbMdwONO5Z07hf4Mv5tzZ5r+khpk+CtfXcIEPUgDpLFcdxBNN0LYUGHiBEYPhhmU+DkQN+BY+jmi1c4g5lVQQ6r2rp5khPox46E5cJx0rCNTs/igPaKjAm0HDQ9MzzLThxs/4xoi+YSG6u3Aw8OEfTzXLxHQXeArLBPeR/mYAsCeBT8wW8XqoeCUJShDNNtUaO5ok09fnlUesqf0jPEhPrO1MkndZIxnbWUVZ5bS+p5XDGgSnSZem7JnyYvwp1kvGryGKJMVoBh3uP6eX+BJckG+WyO3QMFdObVKGbABAp6x1PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5iFD41BL/gXVpYgOxHv7Cs6kuaoEzHqKT0WdscRGfo=;
 b=V3splT8Oa+yCddzN9R8npDvw71blwWypqVNW106mmwLtuB/3w0UfkhqhZCWdzcpcvxnLwNXiMB1veKNqfRIKdLvo8UAqwnH7WBDmUYLhmfBKegJAdwu09agRytStY0wPI5IWk6r4kuudDKX+biizuVpstl3I/5xwvjetlVGQil0=
Received: from PH8P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::15)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 06:38:59 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::79) by PH8P220CA0030.outlook.office365.com
 (2603:10b6:510:348::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 06:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 06:38:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 01:38:58 -0500
Received: from [10.252.234.93] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 20 Apr 2026 01:38:54 -0500
Message-ID: <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com>
Date: Mon, 20 Apr 2026 12:08:48 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<kai.huang@intel.com>
References: <20260407063245.2755579-1-nikunj@amd.com>
 <20260407063245.2755579-8-nikunj@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260407063245.2755579-8-nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: d0eaa050-38b0-4081-9d84-08de9ea7808b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bDwosH4vvSPfuQ9NrAUO1f0oEDq80lScfu1Too7aI2GpTdMf8PPlygeBIUAJiji5aStcjJgMk8sqlzeYj2FU5lGbYB/EW/imBqzRtAb9sY/7iDMeIcR4DIrGG90FXVDuwd90hB/GaWhob3aW+nu6q8ukE99SaN99us8F8vkR2Wj6MN+6WiiGKepRYuCKW1uhNMvW4PpAs/jcVMI28kmzn1RYsxqppgOdjxHg9x4Is6Ol/zCnY70YvIRSVQVzBcLEhVUKJQC/sYlf6Mwp4tw2bC/n0Nogp3Q+NKRqAAf/eOW+FNP8ZnAM5iHjupwIK6eiknz1Dx4mMXDssqpuImE7vURACaxlt1ZBBjRMtLnlEJxoEHhZK6tkL146/me8ThJVz/eTD9joDGEvcTltPDRBUzwymBze0YkDAltEs86xoEkkLgnvccJe76wMTCRpL17AZy8OjhMmLqF82HNk/4Cw7izLwUjTiIAzGiqRKGZ/63LJZVPZr0YOt8U4El7XlOTOAAlZvmDZK/ZKfNvW4TaiKTDbit5bQB6s7iY+/jVR+d5l84pm1588HPQ2xV1Yinj+FNIyRVl3GmRCv3AoE4HXEGGckCP56VgVauDZwdvnipCLJ37thk6FBJbXPu5dWqa4T4YTx/kFHbXel+rD0oCX3zF1hPT2BzarUoP/8HnWdBeLW+phnUsx9aYHAamJIM+HEfZnhz6N3O/YMfk+q7Kw+rG36MrxAtgokxag6FfEm9w=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l5gEPzval4jENQsvzbc76JyfpIOE+jgaU9jTzgObLu7a5R1taLQn3nfijdK53hpbNbQ8oWzy8Dx5hj9CqskvSHDRNg0imZNeObGmvf1AB0SskaKQDfAyO+actO2rVwojlzxq7VxT7bOPqxffofpHwwovu4fvcmye72gdfLYnwVISJ8DPKs5XxmQIIS5yNJXMUzojikPYgK2Y9GOZHI52gA65Q3CV2dTFGngyvX3ZZW5R20vGudJxeOHFii+WFZ53Y93vtPIIoXBVLs8/zOyR5A/YFVN5vXWhkswDgJo6j0WHW1R6aPnHZ7e4EogIuT14We/NtI3QE1sVqzYq3es26gwreH55nVtNyz4HODSUhptoaJPLlWhn3nc5Z2wEWlFKGIHRvw2eRpk4+m/974z50CvhwPdmwvjxBDy76iaFngPFERMKlqLqKO/WLycVKTGF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 06:38:58.5932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0eaa050-38b0-4081-9d84-08de9ea7808b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750

Sashiko reported a couple of issues [1]. Let me address them here:

On 4/7/2026 12:02 PM, Nikunj A Dadhania wrote:
> @@ -1206,6 +1209,16 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
>  	if (vcpu->kvm->arch.bus_lock_detection_enabled)
>  		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
>  
> +	if (pml) {
> +		/*
> +		 * Populate the page address and index here, PML is enabled
> +		 * when dirty logging is enabled on the memslot through
> +		 * svm_update_cpu_dirty_logging()
> +		 */
> +		control->pml_addr = (u64)__sme_set(page_to_phys(vcpu->arch.pml_page));
> +		control->pml_index = PML_HEAD_INDEX;
> +	}
> +

> If the guest receives an INIT IPI and init_vmcb() is called to reset the
> vCPU, does unconditionally setting pml_index to PML_HEAD_INDEX discard any
> un-flushed dirty GPAs logged by the hardware?

There are two scenarios where init_vmcb() is called:

1) During vCPU creation time, where we need to set pml_index to PML_HEAD_INDEX
2) During vCPU reset, when init_event=true

  Before vCPU reset:
    vcpu_enter_guest()
      └─> kvm_x86_call(vcpu_run) [VMRUN]
      └─> [guest executes, PML accumulates dirty pages]
      └─> VMEXIT
      └─> svm_handle_exit() --> PML buffer flushed here
      └─> return to vcpu_run()

  vCPU Reset:
    vcpu_enter_guest()
      ├─> kvm_check_request(KVM_REQ_EVENT)
      ├─> kvm_apic_accept_events()
      │     └─> kvm_vcpu_reset(..., true)
      │           └─> init_vmcb(..., true)
      │                 └─> control->pml_index = PML_HEAD_INDEX -- PML buffer was already flushed
      └─> kvm_x86_call(): Next VMRUN

> Could this result in the hypervisor losing track of dirty memory during live
> migration, leading to memory corruption on the destination host, since
> svm_flush_pml_buffer() isn't called before resetting the index?

AFAIU, no. The PML buffer is always flushed opportunistically at every VM exit.

> +static void svm_flush_pml_buffer(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	struct vmcb_control_area *control = &svm->vmcb->control;
> +
> +	/* Do nothing if PML buffer is empty */
> +	if (control->pml_index == PML_HEAD_INDEX)
> +		return;
> +
> +	kvm_flush_pml_buffer(vcpu, control->pml_index);
> +
> +	/* Reset the PML index */
> +	control->pml_index = PML_HEAD_INDEX;
> +}
> +

> Since the AMD SVM architecture aggressively caches VMCB control fields across
> VMRUN instructions using VMCB clean bits, will the hardware recognize this
> updated pml_index?
>
> If the VMCB isn't explicitly marked as dirty here, for example by calling
> vmcb_mark_dirty(svm->vmcb, VMCB_NPT), could the CPU continue using its
> cached index? 
>
> That cached index would be less than 0 after a PML_FULL exit, so would the
> CPU immediately trigger another PML_FULL exit on the next logged write and
> cause an infinite VM-Exit loop?

I got clarification from the design team: No clean bits were defined for the
PML_ADDR and PML_INDEX fields, so on a VMRUN, microcode always loads them from
the VMCB if the feature is enabled.

Regards,
Nikunj

1. https://sashiko.dev/#/patchset/20260407063245.2755579-1-nikunj%40amd.com
