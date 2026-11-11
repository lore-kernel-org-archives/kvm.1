Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794378617;
	b=k5Qnn0bYhhh4OaZ2LgXRcxgM/SGnbg04ZKPuZaX9c+rI9rcOzlJWUuEXvLYGwc/bB6jG
	 WjIfPSYVkrdbfsY7+G3CRsougj5MhZMlEHES4/Macr6XpEnKkcDUXiY8y865eTzidoTws
	 EqX4Q5sGEqDSK7L609Qi8lu2QgPSJTkYHcFkZqAlL6+em8Ixp+lMQDg67vOboduWJCqCo
	 bZhW+mW7UfREQcT1ELvOy0hcCmwGEC7Xk3zb8C1bfX8sUWpd1Xd32G9Sp751KywDJ5Z2d
	 ShvGGApj34slhmS9Etr6CbZyuUX6eYDEC4rYA0fxWDJbEFWCrCzxKobyAVKEgMzuEpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378617;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:Content-Language:
	 To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
	bh=DRSfQhqGqGyFG9jEWgtk99ttkeQVsD11HtTzAcs4mKA=;
	b=g0GvquNUP63WtKx6UY51LeBbiQbqcAWhvWRlll8a4FkNGiDhGOhewpaRJGzsgDDMiecF
	 fh9dNQaiZ9Uaw6LNPsUOyMttBFDTGYqKWnVMBMhcG/2AJSiyvTLmKQZpwD8CnIoYIFAF0
	 cPuM8e6laQ5z+Stc6sV9gtj9GWE4FP1UAKcwL6o8aFfunwV/dB+XTeEJ9mC5IqpCds4h2
	 5pzQLiLZs0OD6cW58dtaoMXC2H9vpjCPrWwxtWtgCt0diONVxydSo7V8kfDkDDEUWD/Aq
	 WNVrsweIxe9iYPk0T5tMf29eYoxgbJ/508s3AMzNORN+GAFj0r1l8aEGzTmQe3ZDE5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="G+/D+mBI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.24
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3311606A33B
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3311606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G+/D+mBI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGnEuTHlPFchI6phaR/9U5Se03h3WTb2WrRLgytitIg4SylIZasEfcNQdn4TzmWviMkUsartsx5Xs5RdvcisE+xBgDKaOjpKzrrGJtjkGMsTqlS2x9W3Y0BeA1oSX3Bq+vNanI3BmvfDQnkIlPJHibcrFqTupfSTWv3Rt1WH47FmkUl8OLFR+P2S0TAqX5Vg5zmoLuu2HvHKPRnT0WNjtB2Hr4B9titRfVV+wyOsufl/cuvV3OElgHXRAkoII1w8ViWWKLDw+n8kW7LQkNs78E/dXd5WsM+ikxTtp39348Noet7afvXilH7XQ/sRsBQr8vAGHYEITjbpzM5aZ1mYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRSfQhqGqGyFG9jEWgtk99ttkeQVsD11HtTzAcs4mKA=;
 b=LnZIxTSrA0tddFuw1cUTpyHutmxdNuaTJXUdthHnsWJsXaoOhVWoUNWnCo0dvth9k128CEb0HHHqqoy+jBySa5bdtD4M7H1JM5R1MJWh/EL1XTzGfcZ0hMgTSNF7KX041gAUqFPScttdGwKIzAx0ttJqAPFrSwOo/NdCerSpNuyazzUZYhBN+zXmM2joH/O8tWXoQYHr2ytdpizx6mZ+7vcz7mx4qPqJxE3c1KOnvOUcQpLcH3oSumNJrtC5mCzUK8lWw/zMGENizgyaQqo6Kr+dSrO5qu9pEu5c6CtohIccmS+Vg5CsJbrrzN7wwDvpNyZ46iebu6xlyV3J2w6LSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRSfQhqGqGyFG9jEWgtk99ttkeQVsD11HtTzAcs4mKA=;
 b=G+/D+mBIs+t4G7fdBMkCM/3m0MGk63Z7t4p/MUYbN7tfdOh88jh2qvB16v3v4rujL17krFPkoMNQoNFa/zFKsKee7bIcJ+sMK26eJLg9MzBLE2xzQNbmOtc0qB4rK8uT14Rva8uhgvAPW0jSYVrXTrCAJ5Y5AVFgbGoSnP5HxVM=
Received: from PH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::9) by
 DS6PR12MB262455.namprd12.prod.outlook.com (2603:10b6:8:530::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Wed, 11 Nov 2026 06:30:13 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::1b) by PH0P220CA0021.outlook.office365.com
 (2603:10b6:510:d3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 06:30:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 06:30:12 +0000
Received: from [192.168.0.108] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 00:30:11 -0600
Message-ID: <73475327-eeb9-432f-a2c9-ea669e2a8253@amd.com>
Date: Wed, 11 Nov 2026 12:00:08 +0530
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
CC: <sarunkod@amd.com>
Subject: Re: [PATCH v6 7/7] iommu/amd: Provide kernel command line option to
 enable GAPPI
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>
References: <20261022140425.27465-1-sarunkod@amd.com>
 <20261022140425.27465-8-sarunkod@amd.com> <sashiko-outbox-181630@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <sashiko-outbox-181630@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DS6PR12MB262455:EE_
X-MS-Office365-Filtering-Correlation-Id: 2477d183-f034-4e07-59b1-08df3fbd3de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261009223027099003|10067099003|261028144727099003|261102130727099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	q5aAGXxD+YuYQkoO3RYm04wYD2RPasl+LVHHP6OnFE53fZB+oGsedYuyvJFGGeQ7cuj6RbDbjX9CtLQ40c6zS/+w/GKgRaEbP2WSybfhiITlTdO1hYF2u0Xc936fJs9tI15TGqombJ5WkMqjWyBpiDGWPYkpzOkWPXZ1b23uwpTDWwMxSdszDTNMpxDkM+dltXEHJvozeny593eKtJwxtUA477b/gE5/qCnn1EniDR6tSJSNn0gU91ovJAtpr0AzAwRa5gxQMtn1knjifU7cq3TSVXfJLO191+z6Vw671itECPZTrKyk8gV09k7k9gX+CCTujr5Dgmx1tdugzDyLLT7ORwSvz6L68F6FF6p5TyDzcu9SudijVbWaGPVxXmSwN2Vho2B+o/Kuywo9jegf7uFcZCUxKzYIhUFaDu8qNqlTJXOhLBFIDPccm+OBBCg0oUkZwPveXAzKzsBExTsuRPLBd4zthtL/3SeTxacXJmGGUaJDTLQ2D3uMsn3Wq1vzA+aBMn+G/JYHCGL0os2QjgrmdiGCKlYcbfh/8cop6aBjODVexvD7AWaIUXiT2Y0zjVn6xNLNRbun7rPzZaUXtlsAsoO9gQffML3g6WeNKCN4oJgL1bApeP3LsCtQj2qeAe3Mi6jSQ6Hd5N12GQw1lWTcan1QMvF81d1QrUIQxT21JguBZNkFjXWNuCbvZDEuaX21IUysO/kS3oBnR4nrrg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261009223027099003)(10067099003)(261028144727099003)(261102130727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bEgAmhUaVlkRuM8t3ViDaHb9r8KNbiIKNDS8h9lXnJw9dnAiOlNep76tt8UZP/fgQ47qsAmYsabMduJsBbUgnVdwjJ394TuerYdZrotnV951d4GSXTs1lnz4NwpClSK85+Ki1O6evAZjFeQWY2W94b6JwcDzKnEklyAHiqXGFtol5zRfagCLkF+WsIaUwMLLBd+u5JoFGhaonIjLYOjdj9P3JOEWEX1C29viS1hcUYXjZObLxcyXJEo4rlkclMmSaxCfxakMym9oN/alnHWZG1Yi2CJPAVEgNjp9Ix5LBSrr9hoUA98TFXgV7FZl+Ddvs8QY8yU+nHFR0JBVBlLVo4yYfKwTu4oyeF1Cc2QKmwOw90TxSRwJqaOLHpH75H5qbWpIrxpGDFFy/4W5Y/2j4rS1MTk2S1ItxSL5nAYq71YBvq3+J/mmUKxxM2XtKumt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:30:12.8638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2477d183-f034-4e07-59b1-08df3fbd3de4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB262455



On 10/22/2026 7:53 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] iommu/amd: enable_iommus_vapic() leaves amd_iommu_gappi true on early return
> --
> 
> commit 2f329c3e02b74f486082bc1f7b970f7b86fabe68
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
> iommu/amd: Provide kernel command line option to enable GAPPI
> 
> This commit adds the amd_iommu=gappi kernel command-line parameter to enable
> GAPPI when the hardware supports FEATURE_GAPPI and Virtual APIC mode is
> active, along with documentation for the new option.
> 
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 78e3c14dc1c28..72394c92a3fa0 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
> 
> [ ... ]
> 
>> @@ -3027,10 +3037,19 @@ static void enable_iommus_vapic(void)
>>  		return;
>>  	}
>>  
>> +	if (amd_iommu_gappi &&
>> +	    !(check_feature(FEATURE_GAPPI) &&
>> +	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
>> +		pr_warn("GAPPI is not supported.\n");
>> +		amd_iommu_gappi = false;
>> +	}
> 
> [Severity: Medium]
> In drivers/iommu/amd/init.c, parse_amd_iommu_options() sets the exported
> global amd_iommu_gappi to true during early boot when amd_iommu=gappi is
> passed on the command line (with CONFIG_IRQ_REMAP enabled):
> 
> drivers/iommu/amd/init.c:parse_amd_iommu_options() {
> 	...
> 	} else if (strncmp(str, "gappi", 5) == 0) {
> #ifdef CONFIG_IRQ_REMAP
> 		amd_iommu_gappi = true;
> #else
> 		pr_warn("amd_iommu=gappi ignored, IRQ remapping is not enabled\n");
> #endif
> 	}
> 	...
> }
> 
> However, earlier in enable_iommus_vapic(), all paths where Virtual APIC mode
> is not enabled or gets downgraded to legacy GA mode return before reaching
> this check:
> 
> drivers/iommu/amd/init.c:enable_iommus_vapic() {
> 	...
> 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> 		return;
> 
> 	if (!check_feature(FEATURE_GAM_VAPIC)) {
> 		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> 		return;
> 	}
> 
> 	if (amd_iommu_snp_en &&
> 	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
> 		pr_warn("Force to disable Virtual APIC due to SNP\n");
> 		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> 		return;
> 	}
> 	...
> }
> 
> Doesn't this mean AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) is always true
> when this check is reached, leaving amd_iommu_gappi set to true whenever
> enable_iommus_vapic() returns early (including on the
> MMIO_STATUS_GALOG_RUN_MASK poll timeout) or is never called because the
> IOMMU is disabled?
> 
> When amd_iommu_gappi remains true while IOMMU Virtual APIC and
> CONTROL_GAPPI_EN are not enabled, avic_update_iommu_vcpu_affinity() and
> avic_vcpu_free() in arch/x86/kvm/svm/avic.c still see amd_iommu_gappi set
> before checking list_empty(&svm->ir_list):
> 
> arch/x86/kvm/svm/avic.c:avic_update_iommu_vcpu_affinity() {
> 	...
> 	if (amd_iommu_gappi && is_running) {
> 		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
> 		svm->gappi_cpu = cpu; /* Store cpu number as target for GAPPI */
> 	} else if (amd_iommu_gappi && wakeup_intr) {
> 		apicid = cpu_physical_id(svm->gappi_cpu);
> 		kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
> 	}
> 
> 	if (list_empty(&svm->ir_list))
> 		return 0;
> 	...
> }
> 
> Wouldn't that cause KVM to unnecessarily call kvm_pi_enable_wakeup_handler()
> and kvm_pi_disable_wakeup_handler() on every vCPU load, block, and free when
> running guests with AVIC enabled?

No, This is not possible since AMD IOMMU driver does not set
IRQ_POSTING_CAP if it returns early, disabling the posted interrupts.

Thanks
Sairaj

> 
> [ ... ]
> 

