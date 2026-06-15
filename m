Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296522B8AB;
	Mon, 15 Jun 2026 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498355; cv=fail; b=LRdv/sWcZrkoBkUrDQtarX+GXxCojdPMGkcNwufVW7T5azFi6bHNI2Xrf5rKLEE7JwymK8QfCRlCQmHPWK3pAHfBwt6kPss5ho8dlwlEabAwoOmHdvfuSFFAMRq/fWBha7c0SRQyO7vyeg2OLIECi2JIOVVsATlxxh6PKQmPlzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498355; c=relaxed/simple;
	bh=dkJ9SlU77I3PNo74T0dRwm7LS3NeeIycn2xlvMwjm0o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QF7Bp19WihLeLU/e4ftpQWJwz31K4wlSS1dTnB3+2OhtqekLWS5vpBpGepDXGw2VEB9ocmBfJBVaVLtyD4fuHpGAOCHgUV4DTdEQ/N9n27jzUGuRChWsGcvEW05ViTceU72zjhCerxnIooqcBFEFjEhoCb9FYRyR26zAg52+E0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGhHzG8w; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGhHzG8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781498354; x=1813034354;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dkJ9SlU77I3PNo74T0dRwm7LS3NeeIycn2xlvMwjm0o=;
  b=jGhHzG8wT+AXXu83q2bnem2bks6hItZJi5RwxJF37l6JRYaUU3QDdpMP
   bmorwUYKKIq2zayxV156V5rArdsB9Z/TLgB8KA20MshLEgCPD8iKOUEjw
   g+o3Jquz1PejDfAozc98ecI8mVC6c3j0dar0aW1T0MQ4bmg2xlLEYzvSw
   /9VOBx8NRcFaNW57Q7o4PGz866agdf8/YavHW0Ngl+VSrNcjBxgdU1Jcb
   tnIbq1W3h5eYJUfrQl7Snl4N7+9mO4vqaeFO+ELJ0G35EMGxZx4zFXsxy
   tc9zm3nDQp2HJy96gNynRrMUDL02FcPC7bjG2c92jctoxKsKxj/sfUevm
   g==;
X-CSE-ConnectionGUID: t3jFeQo+TxSUeDtteFdzug==
X-CSE-MsgGUID: 5wSQ8ASFQSKu4QC9+s1j1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="93617773"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="93617773"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 21:39:13 -0700
X-CSE-ConnectionGUID: jwi913GHS/ObHsdz3nUJQQ==
X-CSE-MsgGUID: bq/X3pbWQ5Cxhx7LFRMuqw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 21:39:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 21:39:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 21:39:12 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 21:39:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGPxpnmNjdAkLgn3C5+VvtAv/lTHYnpjt3+saT4+XDO4L3EiENBrNPET0WlW2mNR7WaKZ1vr4RUFT8fEr1D4nuIeTwreR6aKKvjJlUpxzX0Z6K+r/gOZvQ/OZOXQ8Pb6K7eZcnkC87BOxyfF0PY2cwOfte34G8T718+vkvx5W/0Jkv8ikYq0d7CZtxePgsS5hVJP0IdI3Z0RRwp59fW4AcTJxu6g6iZSn9xLLgr97igr9BoTYzKs6AWj34cXmQUbR+XaOqsENAml6FDhUuKtdgrd8xua2AqXy4JK7kEChtUso6tmWrCr1lLEb+DinPMoJy4MKWBcKsqvQDr7DN24xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfN0cu3UoWoXRKBN8E0yzodQL4RXD2FPCLq2CybXKi8=;
 b=Xh5Pf5YdOyyF3wC2YM87dZfU334Qvdw2yffGy2hftsst+o5V5lgdx6BIjqalLVdggPJWuKAwO/Tn+ygROGNcQS8uT4lijPonsUhf7l9l1gN9ISPrXAlBuZADg4aj7l5Pw4fh5RDm/VwyjSMeD6QrMnbZloGWlpCOQEv8PizjPRvGa/NjWG+FiIotcj6lERkxwz5jz/NjW22SAtK7hcV0XqzMbPMXiIL9jBMBV4hR/OAcqA8ZmlzXalozfaOgtk+p5mHiDbuAeLwcWOBtRA12VSYkS9xfF1uO+rM0zGqfSYTjewM9eocjgRKiVgCe/kwFrTI9yc5q0hXpCJQmtYgW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH2PR11MB8814.namprd11.prod.outlook.com (2603:10b6:610:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 04:39:07 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 04:39:06 +0000
Message-ID: <2ae7d9a9-11da-40dd-a11d-b9e1bf111e1b@intel.com>
Date: Mon, 15 Jun 2026 07:39:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/15] KVM: TDX: Support event-notify interrupts only
 with userspace quoting
To: Peter Fang <peter.fang@intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-14-yilun.xu@linux.intel.com>
 <7090f4af-3a6d-40fd-82ab-0ba6272534dd@intel.com>
 <20260614125750.GB3425618@pedri>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260614125750.GB3425618@pedri>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0212.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::7) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH2PR11MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 6906a5e8-8c08-4084-e49f-08deca9808df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|3023799007|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3zxjKbLb1CoJlsPR34OdKQBxmiHp0QsJfEKdJNnpACscl0LjNmWC4tGKHWETsO+LJhocDghM2IFQgxD4K0RUqeK2A5zNVQkIh4jarqjhWjMcty42KdSmFKJ4UMT8oavT6u++F2Vy5c5BOT8kJNq50W0piFfC9Kr1nM1SORXR2EXZmKv8uhEEzYwaNErkFLwBO7sF/Q/pM5o+gWAj6CAD9EFy63GHkuVW3at3lgkKUgwQu5Z/6w6TPAVm7uQueetUywQwzX/9lnNY4G5dzXiphhtUBNKx5/Kir5UO3bQuar6rPNQUQBkiBSaoQKVg7YuNRfcYYvG+mzfMSTYVrv7m1KfrLooP09E9Dl+Pf5C594v9rLeClrOTV/qYOaK23LUd84wiSSWPTd2llAya5bfctfumo11XJSiGhbtuiKCYRMEzX+rXmogGf9eII2nbZXegNUZkSCSZ164yuzlFAF82sYtsGVIvUC70ovL8CQavEiCnM8Nf0HrImSPRAEwKx+nrNpNO6L5q+sWyEa/y9CUePQh9lIwXbw1iZPg22uVdED4gGFD0AhezpDHW+PB+f6Atdpb8pz4VCv2RIbsA7lmBQb0y7Hyd1ILFVgOxYJwzAqjXYBg7L2WpFlhqNbIYCpu6+Tz6s6lNJBdBPPVykn8ve6dwBtMUoXlR72dRbMlDTJuidMY2Q3mO4IwAZBwhRckK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(3023799007)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3lpYVBjMloycE1sdW9ZdkRKSC9EQWxLZ0NUMkpiem9zeS9QTjNUT0ZRK2E1?=
 =?utf-8?B?RXdxbU1mSFVzZThISWhJUzk5bFAxbm5PbnJIOTA4ZVZsbDZRWUlYOW4vYzVr?=
 =?utf-8?B?UW44bnZkQ0JyeldHQ29qVTBiV1lXb00venhSS1hFeC9oUXBrNnB4RFBuOGJT?=
 =?utf-8?B?Ym9rVEF6WlFhS0JiS3htRVhKT0xnQUhUWXNNVFhKVDhCbWJzR3c3TlFGbXZP?=
 =?utf-8?B?REMrZmFoc0JZaWRPanR4RytHYTRQUjlFQ2d0MXpLMElyekJ6RllwTWVJZnJm?=
 =?utf-8?B?MFdydnBtRTJFL3B5Wlc5WkUyOTZBb09VenpOSWtKZ28zeG1pRVJzSlVIYUg3?=
 =?utf-8?B?ckxrL2Ztd21rVlF4azRzbWp0ZGh2MWdTS3c0SVlRdW1NVHY2QW9NT1FuL2xu?=
 =?utf-8?B?MUc4M3FHTkovTHBhd2E5dE8xMkR2MGt3WFhQeWVEd2MvUzhGOFI5U0RqNHpF?=
 =?utf-8?B?em1RazBGS3JReWJYcCtlSDVNTUJ4cjhWUEJXL09nUFl6Rzd6dmNyY0dIRjVC?=
 =?utf-8?B?YWlXTEh5VC9UR3lZT3Q0aDM3ODJSVzFibFVaNTBTSTIrQ2sxMG5jaEE4RW5D?=
 =?utf-8?B?ZEM0RVJpcXl1bkRReGpwL2V5L21TUjlNSldYME1qZ3VPRFo5REs2Nk9GR2hw?=
 =?utf-8?B?QUNSZ0N3aG1ZVEJqZWo0WTcyd0tuL1d4ZnNBcEF5TllXcjF0aVVYaVFYajc0?=
 =?utf-8?B?L1dzajRvVVViR3N5RGFySVhJTzhhazZHdnpsdk9oZ1RxSEFuQzZFMG1JT0x1?=
 =?utf-8?B?Q0x6ZFZGRlBOc2hqTkMwYUtkQkd1OW1OaUQ1V0RmSnd0Uzg3U2taYlVRU040?=
 =?utf-8?B?OXBtcXZjaGd2Y2sxek5OaG1wZjBRYW00M3JNdk52V0pUcmQ1d3ZwNU4wYzln?=
 =?utf-8?B?NXdON2VTd3RsMGFxZS9Ia2hpVVpRbi85NEkxZG1VTDd6WHdrbmdUb2F3NzE5?=
 =?utf-8?B?QmtIWk1hMVdGWmZRVDFXZGNyR0tRVG1Eak51aEllRlpEK0JKSnNjU0JKUzJF?=
 =?utf-8?B?cllEY2ZQb0RqUnBuQnpZTjZNY3lyb05GZkVaRmlEc3RCYXcrajZvZWFSNVVw?=
 =?utf-8?B?L1BsMnlHR21HSFdudkNBU2w4b2pBcUI0WFhrQU1mcDJsRDZqZlA4THhJOGtm?=
 =?utf-8?B?U1BHRm1aZjVqeGdCSUJEZmM2cXNpSDNEbEtHUGhkQmZxTTdxY09MeUpoeXBW?=
 =?utf-8?B?MjFIeEZKZVBDZGc0VnkzOTJMUnJmZEEzNWQ4MWM2d2UvQWdJWEZNTXh2OU5Z?=
 =?utf-8?B?dFZEOW5CMlZJbGNCMHBYUTBBUS82ZXJIRkhaaFM1RlNnU2llVWJyMm9HeExT?=
 =?utf-8?B?OHFxS0UzUGlQbXFIN2ViZnJCVGJQbTN3WFM0UDgwZit5SDJvOHVSV3E4KzI1?=
 =?utf-8?B?MDhsZzU1ajF2K3dCVDU0Zm53SzFjT1VNRDlhbGhHZXdmUTZQeVQyL2lWSUUx?=
 =?utf-8?B?Tk9jVGFiaFQ0MGt5OTJzSVRhZTF0R29UaWNlZE1FYVliOUZ5Nk1qOTBJWmRH?=
 =?utf-8?B?ejdjSC9yZUpaSm1xaHNGWXY4K1M3RWliYXNuUndBYlBMd21YYmRWQXF2RitD?=
 =?utf-8?B?UllLdU9uRzJRM3dCOERPbnBtM2JiRUp2Vkg5cWE3OVk4RjFpcFBDQzFXWEJN?=
 =?utf-8?B?R0FzcUNIL3duMFpPTjkxdHRBRUJJMVladzVUUzJqR2RsRW9HSWc5V05abjVD?=
 =?utf-8?B?TDZieTBXU0tRalBOTG02NzQzMTB1d0Q3ZXNaUXQ3M2RmTWFvZEkrbWM1Vzdx?=
 =?utf-8?B?UDNsMnUvaGR6eEFaSFdpbEphck1veW5URXY5TnBGLzRNbHFrVFpHU0lWb1lj?=
 =?utf-8?B?QldDb2J4SThOZ3RwQkhMdTNFc2ZvRi9PTnpsd1lURjZGeWxIYVlqSTVlT0Vk?=
 =?utf-8?B?azhwYXh1Y1hsQ2hGV3pnZEU1TjFrUDJkOHdMNXNmd2hZZU1jSm1Ga2dqZC8w?=
 =?utf-8?B?NGl6dUJWc1h6bEEyMjEzV2ZLV1k5N2w5cE13WHlrTnVGbXNjcm9ZaG4reEFx?=
 =?utf-8?B?KzA2d081ODQ3cFNUZEFNSjJsbU8zckdndzVpQ2RKRTF1c21ReWQyNmNZaXZO?=
 =?utf-8?B?V3ZqWkkwUjJaeGlZaG1ycWlVVTVObU1GdDk1Q3BWaVlLKzBaeVlUTDBsTkZL?=
 =?utf-8?B?UDBPL28zQWlnUzdubVdFS3NtZFQ3ZkNGSm4wTFBzWXZwNVZlbThPbUdxaU0y?=
 =?utf-8?B?RkVncWZVQ2RRQWtGRmp2QUJETGVob3hzbitpWXErK0VoWFdPZ0NaNWpYeVBL?=
 =?utf-8?B?RExMS2ZJbkhHcEFqRlUrblpjaTg5aU14anVEdmdxSkJoZVdMaW1Ic0lIbGwx?=
 =?utf-8?B?b2hjQy9OcmNJY0Fyb0VEOWJWRUcvdEZtb1MrNWFBZVR2Qjh5cmhuMk12ci9o?=
 =?utf-8?Q?iPu89yYQH/RWxdTU=3D?=
X-Exchange-RoutingPolicyChecked: N1c8YovNVdL/fo6+u7b7Ea6TbNaIzdiytlSnkw0+/iDv1+umTIj/cu+CEqPyrtnTYswgQXMlww5zQWoPRMRR+XMLtcB+jih7ijlVZeQiy9LonhyBOE7AKaL8mitfntMk0A12pSPI7IxY5uS/P0p9xxsCfKIuDGbJ8MVBlw596rDfzOZkMw2tTm8cJ/5E6bb9uEsmC6E4qT1DVOq6Ppp9abn0GKXGtUW6AC+YmsEDC30vtmxIQ6iuVLvG4ywdsnVnC4lt23t515pszxQaAh/QPn3sIrBQ8RYiKBtKrOW9kc1IALVV1PYE89DPJoWcodG93fr+3LSQrshrM11kGXu2sQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6906a5e8-8c08-4084-e49f-08deca9808df
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 04:39:06.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvN0T7I5RJdHRmAXxf1Ev73y0DJVM7CJ6XElCw/KmMvEUMj86aQ3WkYJe7YG/THvOVzL4blyu7P6so8UDlrLvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8814
X-OriginatorOrg: intel.com

>>> @@ -7335,6 +7335,9 @@ inputs and outputs of the TDVMCALL.  Currently the following values of
>>>     queued successfully, the TDX guest can poll the status field in the
>>>     shared-memory area to check whether the Quote generation is completed or
>>>     not. When completed, the generated Quote is returned via the same buffer.
>>> +   If the host kernel generates Quotes through the TDX Quoting service provided
>>> +   by the TDX module, KVM processes the GetQuote request and it will not appear
>>> +   in userspace.
>>
>> There is an Attestation section in Documentation/virt/kvm/x86/intel-tdx.rst
>> that could be updated too.
> 
> Can you please point me to it? I couldn't find that section in that
> file.

Sorry, got he file name wrong: Documentation/arch/x86/tdx.rst

