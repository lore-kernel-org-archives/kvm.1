Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78F3E0C44;
	Wed, 30 Sep 2026 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782355; cv=fail; b=qGtBtN+IexUF/fxbt2MwYeV++ozgBSeiUXDqNqTMXIoTkeVCrE4oPto9hKlxNe2xHY/nIZkK0iNI8n7iJLMrhe/aZ42SeVjnW5H95YaQQSHuvdCShm/4rABGvByZivFJwBKmzgmTVAkGF9qQg/Q/Vqb3Qzal2tMxoCxVZH0nNPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782355; c=relaxed/simple;
	bh=yDQwuaECQWqATx3O7B3tSG/8XXqUR3IrCzUPlpmHPPU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ar8FqnRXi4M+lkZDnnkyXRNlFD58helgmvVLF4q8a/jDGpgxml77tbV5K17/CVR1ybav7lnJdr51aZ5vjBBETvw4BHfLa3GEJMtoUUz0XBkgzbvulQDD5Dm3EpeTuI/6msh5APSSOmroc3XZxFsgw1Sscg/q+IdWn+/s98Jl8Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kEb3RVe2; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kEb3RVe2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlG6x3QxvPh1uDTSUBDM/yNRKMN2eSsFhxGAvQH9Va2gghSup7wqGvC999svEc2+yzEkCqP41Cbh03QUcfDhQjwoX6NvZpv5y2Bop9znbl0dpInFZvlRvmFB/3tEIcWpOVrAeofnVGVeC3eBiK3A804Y5+1Ac+k24nhinHntvQT/7TRjB0f00ziC9/f6flaZEpDElkqX3mfbw3xHLImby8Y6SPVGo2n3LkhhWBn2G/WtIiNkYCUb6LCjEvnJG7zdf27pla3gQ0JoVPrCC8GDMZ243a2dpf0HGYSHxWlLVD/nzzx2j3lBk3+CbqQHOaVrtfangHB2TtCUOw9Q45n/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9IgtqlCjJX+Q6AKo/SZmzzhpaFljZyI0z0Z4iusfdg=;
 b=h7wn4w6XS85NYz8VH/9EGy91J+HNpf/WeS2y+GsgxC+udBvTcolI3lb4GIfkZ1brIgzZgdw2XjX3xkkYwALqmMri2IdtFbblNfUGupnG/kkXPp5jNGzmDiSzMTX6oBDHIL0dtZD2ia27la8bbOnT6LMvrF8MPVy1XnbzX34QslcAL4mvqZkrLXP314WpOXYWKxxpWFXSDJmI1Fq6NqUiDOBeUQSbytpefhBb+DQ/7UKHp8bruwhO4rgN1qxMTHAO9BblrAqu+ScXfkmmYFB6PTmcARDQeoSTwNxnqFbj6bTZq1gugLVWqGkMjfRoe1isNSHWMvienVCyoKZs/Dyy9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9IgtqlCjJX+Q6AKo/SZmzzhpaFljZyI0z0Z4iusfdg=;
 b=kEb3RVe2mSiqEn6k3v4sXjaLaP+D6lFWfx5sOuznLTupfIPNQHcYjA3SLI4AO6X1rROnbnQ7DjCc1XJ8ZSZpbSY5U+pw7njkT+9zQfCketDDfGDZ+I67A2/yzQS34iM0rfi+Cdiy9zdyenFYnDhy+GNB5CdmAx4uarnqBT6BZ9sV6V9lis1TydSbEkiCA4pgHDcczufIfGNeB2x11eek6ehp2M69emNbvCOmMlHSHldN2wmgIWEIf+hJX5ldmim+Usl4bE3KUOP4avBMHE7oPZxxTRX3JAOPJ+aSu7MWpcjjeNV3niVuiGYm9mruQ7beLhjjlFWbdmKO/uNynec6Ew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6)
 by CH1PPF5EBD457EF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::610) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 15:32:08 +0000
Received: from CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b]) by CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b%3]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 15:32:06 +0000
Message-ID: <d90ce22d-3acd-42a3-89a2-fa9c53c95034@nvidia.com>
Date: Wed, 30 Sep 2026 11:32:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] vfio/pci: Give drivers control of PCI driver_data
To: alex@shazbot.org, jgg@nvidia.com
Cc: dakr@kernel.org, acourbot@nvidia.com, yishaih@nvidia.com,
 skolothumtho@nvidia.com, kevin.tian@intel.com, jhubbard@nvidia.com,
 ecourtney@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com,
 alkumar@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, zhiwang@kernel.org, zhiw@nvidia.com
References: <20260930143641.4160785-1-xinmengs@nvidia.com>
Content-Language: en-US
From: Simon Song <xinmengs@nvidia.com>
In-Reply-To: <20260930143641.4160785-1-xinmengs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To CY5PR12MB6549.namprd12.prod.outlook.com
 (2603:10b6:930:43::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6549:EE_|CH1PPF5EBD457EF:EE_
X-MS-Office365-Filtering-Correlation-Id: d740a372-58bf-47ff-7ac9-08df1f07fbc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	sjPctykdUXQXu7DwhD9XJTLBw8Yn5+LmSp0iUmhwVCFm2KOmwzwSOaXyWzLUZNqtzJFv1OCcbdZXzFLwOZZoeuFEgn0OHYDMkjBvQq9gnApO0geV9ZDHUBFRC2TQuNdei0bhri/kgSHFxGe1GU3v9NIJyTBG9Ya/UGdebm2aX97RH+xfp/41mrYGSJ58j8NZ/KIZ7Ouv+RyS3yKvkHm5E3Y88pOldTMEYKN2qKQHajjhDKhO6Avw3YWxsLJqELZ4OTsfooyA8MRqRQqehVBv4NxuktOTgh6IaEvp0ZYlVZlNHyvCmIaC6opqDlvLkE36O/V0qi8xBeAB/Pz/wKGYItAkaFY4mFCk/5NZhsNgTeY4JMrQL3Q19iWnpza8sA9V2c/P/nQlKKFd/54MeeDwMeMZY/PRYnmMA5QWCBVBCDFn67ksF/7qNJQ+YlvtPri5RvA20akMPFVq7PTYQnYIxp0c5BlrK/1nwtHv31+VertbfD/NMqqdy+e2ZWKiSVBcJt8oeLQUz+RqGDiviOdeIxQif814dYqBa4GDoYUrO2yE+UxmGAr2PcYoPyTtThVqJaSOwqai6hQWU+N0FiWjfMZknuLD7gdb+R0WgSq8kRQ9SmWUEo6INIkx8dQNMHgLPhnNbovrLphMmX+pagFrJQEY/qVzzzzFbrk4H5OdA/8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akwvcTdhaHFqMEFIdUkxdU85b2YrdjlpRHZON29Idll4U2UrOW1TWnNxTzBC?=
 =?utf-8?B?TWhNR1lDUE9aUVZyY3haN1NHRFdsL01JSTR3SWdrRWtqalJDZDVXUzBidWZj?=
 =?utf-8?B?Tm5tMzduSkdybmNRUmo5elVsOTUwOHF5aVRFdHRHSU1aU2tBbllSaXozeSsx?=
 =?utf-8?B?eXFhRGJmdDhXaFEyRkhQVGt3elUvUFE4Sll6ajMyV3B3Nkh6WElXdGpOVkhT?=
 =?utf-8?B?c2ZIek9yU0Z6WUdhOWc5bDA0MWhOWUduSWZBWGc2dGNoUkxlZzFmcGMvYmdJ?=
 =?utf-8?B?L0Z0WVdwREFhQUZnZ2s1cFRDdElwc2FjMjJXamJKWHc4ZHBWVGtzRm5IQW1j?=
 =?utf-8?B?RXhzNEZKYlRNWGNScTlXVjZ4KzkrYkJsMU9tWlBDR29pbDgvRGVTR2VIbnVh?=
 =?utf-8?B?KzlmWWNmelRZbmVhR0tpV1BvQXlTVmRzSUZScGZyOW83aFJhMzFVam9vNXBT?=
 =?utf-8?B?dmJSNHZnTmMyUmwzcFNhK1VrcWcyb2xrWndlMWU2czhiajgxbUw2T0hKa2F2?=
 =?utf-8?B?aE84c3JyUGYyWEZ6bnJYWldzWHBxSS92Q2p5aFdYRDhPY0J5cjgyVTcvQkdI?=
 =?utf-8?B?MnY2aXVXbWxhbG05ZVZWZllzTndXL2tYcU82Qmc3V1ZxK0FzNHpVTDhaOG5l?=
 =?utf-8?B?NU90TjdYbWJYaWpWVHAwK3RsTzVYbEpnL0p0UkxtZzYxUWhORm9RWXp5YkNI?=
 =?utf-8?B?QWl0RkM1ckVPR0xueWdjTFVWOExjOHd4RTdxa2J5eHA3czc2dnNMTjJRTDZa?=
 =?utf-8?B?cUtrMnROZXFhU2NhcmZFbVp4L09sS0tsU2lGTS9TZjVDYmRiZk1lMVdydXNt?=
 =?utf-8?B?N2IxVHQ4ZVM5VzBZNkJUcTZlOGhHYmdiYWlEN3NkODdEbmVjUDVldlVyTThp?=
 =?utf-8?B?U1ZlRFRGTmE5UHo4aWRnOC9PMTlhVVlvRjB6eVhzdXpMSWJiTkwreitvVW0r?=
 =?utf-8?B?MUV5NC82dnJPcUl3NFEzMVhVTXlrTGdjd2R1Q3c1eDN1c2JqVWM0OTc2UzZs?=
 =?utf-8?B?V2FjS2l4K3RtZkRXMmtWbzF5K1pTa3ZxNHBOdDVKYlhKSWtUY09pSTZOZ2pD?=
 =?utf-8?B?WlR1aTVZcDZSdTErMnhzSFN5cEtld2pDZmt4ZmNoL1ZBQ3ljaXhGVmlGNVpK?=
 =?utf-8?B?V1BkVEZ5RGZ4S3hYZ2NmOE9XS0tlOUZYQlBaL2R5S01IbVNWZmZCanVpYXk0?=
 =?utf-8?B?NUlUTTA2aTNXUUxablYrb09KVm0yNTU3eEZRY2tRM1lpajYxZWR1NitOZWRo?=
 =?utf-8?B?OEVBS1ZBTHBjck5XQVBqRGtlOUIwSHpvc1ZVWm51K3RucTZhNkZPelc2T3o2?=
 =?utf-8?B?dmwyL1lsRVVFMzV5SXcrOHFIVkFLUjlqOEZ0cDdJRUZibWNPMUpDWDF4Y3ZY?=
 =?utf-8?B?TVJWRTJzelZPY0JEWjFCM3FROGwvTDVsNXE0dlBvNnVFMTNnTHhsalZuaHdK?=
 =?utf-8?B?Y0JtanlkVmxTUzJ2RXNxSXlSUTVQS1BNVmYrQTNaS3JSU3VETUdZVU9aWFA2?=
 =?utf-8?B?SVVhWTZ1czV3dTBxdjJQQVR2UWQxS3p0a0RmZGlzNjFNbGpwMGU1SndycnZM?=
 =?utf-8?B?MitTdTRiNitJK2pEbmNhL1liNFJrT2k5SGtuM2N3Myt2RkE0YUJyU0FWZThX?=
 =?utf-8?B?TnJTckk1MVlROFZUTkJRd3ZNcW14b0U4NjdaQjNldEpOWk1WY3UxVlRhbEwr?=
 =?utf-8?B?QkczSWRQaThMVDRqdHpldzZNUUdYT3pwMjU2R1lteUZlWHl4WUk3YThiTmZt?=
 =?utf-8?B?a1Z3dDRVdjVoMmRvbm5pNmRLM3ZocnNPK0NjL1IvN0pTUXdaY1dVY0czSHdw?=
 =?utf-8?B?RytNM0ZBSkJDbExKMEZEa3lRVUNKWlFLb2YybHdHNklCSUNmcnZIbGZmbTls?=
 =?utf-8?B?ckV6emE3QTdGSEtaMXJKWThMZTZMQmhGU21qNFpzNTVRNXJyYTJUWjRUU0VB?=
 =?utf-8?B?eVo0THdEdGJCUXBJT0pid1M3UTllNmFYZThGR09yNUFDcmZzcVdCVXl2T2JF?=
 =?utf-8?B?OEE2eG9jTGZWaGduSENka3FlTVlYQnZvYU93K0pDQytuNEZTS0ZWaGRGaCtL?=
 =?utf-8?B?WUVxN1ZZanR3NmZhMlJBRWxha2dRZUZINmVyZmJHc3dRK2RoNmNUNktSbkdv?=
 =?utf-8?B?dmQvVmpBWm9TS2V1UG51Z2V3YUpZWU1YemorS2JKbGo4TmRBd1ZldnVmV2Yy?=
 =?utf-8?B?UXJYaTBnaXhYYUNYbnhmQVJsUW1MN2NPNytBZGFja0hSdllLa2xSaG9hc0tT?=
 =?utf-8?B?bVZMcDk5ei9LSHkrR2I0RUx5dDFPZDQ2Y1hScmZzN0RRbGNlNmF1NjZnTS9o?=
 =?utf-8?B?ek9nTVpRc0phZWxsNktOM08vZlVST2pnYzRQSXlHaHl4Q1hRdkM4dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d740a372-58bf-47ff-7ac9-08df1f07fbc5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 15:32:06.1303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sa67fejrl4WwI3iVko+IyRWVzPLO0kS4QS3CDQ8oD1rg8D4vRvXR1h62gNS2VQfI+xEIeyhebalBWGZd9EpOTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5EBD457EF

On 9/30/2026 10:36 AM, Simon Song wrote:
> Hi All,
> 
> During the discussion of the proposed Rust NVIDIA vGPU VFIO variant
> driver [1], Danilo mentioned that vfio-pci-core requires pci driver_data
> to point to vfio_pci_core_device, this conflicts with driver data
> managed by proposed nvidia vfio variant driver.
> 
> This patch moves the responsibility for interpreting driver_data to the
> pci driver, the vfio core functions (PM, AER, VGA) takes an explicit
> vfio_pci_core_device pointer and no longer depend on pci driver_data
> 
> VFIO_PCI_CORE_DEFINE_CALLBACK marcos generate the wrappers for existing
> vfio variant drivers, each driver also assigns its own PM ops table to
> replace the operation done by vfio-pci-core during registration.
> 
> For VGA, drivers provide its decode callback to
> vfio_pci_core_register_device, VGA setup/teardown remains inside vfio
> core registration/unregistration, this preserves vga initialize
> sequence and also remove the core dependacy on driver data.
> 
> 
> [1] https://lore.kernel.org/all/DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org/
> 
> Simon Song (1):
>   vfio/pci: Remove the core dependency on driver data
> 
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 27 ++++-----
>  drivers/vfio/pci/ism/main.c                   | 19 +++---
>  drivers/vfio/pci/mlx5/main.c                  | 13 ++--
>  drivers/vfio/pci/nvgrace-gpu/main.c           | 19 +++---
>  drivers/vfio/pci/pds/pci_drv.c                |  8 ++-
>  drivers/vfio/pci/pds/vfio_dev.c               |  5 +-
>  drivers/vfio/pci/qat/main.c                   | 12 ++--
>  drivers/vfio/pci/vfio_pci.c                   | 33 +++++++++-
>  drivers/vfio/pci/vfio_pci_core.c              | 60 +++++++------------
>  drivers/vfio/pci/virtio/main.c                |  8 ++-
>  drivers/vfio/pci/xe/main.c                    |  8 ++-
>  include/linux/vfio_pci_core.h                 | 42 ++++++++++++-
>  12 files changed, 160 insertions(+), 94 deletions(-)
> 

Hi All,

I forgot to include "changes since v1" from the cover letter, see below:

Changes since v1:
- Extend VFIO_PCI_CORE_DEFINE_CALLBACKS() to accept the driver's private
  structure type and its member (Jason, Alex)
- Select VGA decode callbacks inside vfio-core and restore to use 1-argument
  vfio_pci_core_register_device() interface
- For vfio variant driver, store its private driver_data to pdev instead of
  the vfio core driver data

Thanks,
Simon
