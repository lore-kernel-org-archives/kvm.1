Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3AC4C650F;
	Mon, 12 Oct 2026 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830463; cv=fail; b=Dz4dB058XZ1Niq0yWin1RVeqoEFWVWLEpsB0yzTsP2usZc/2Nr90ghtGX31+4Gv1IkZEY2K4VLlJlAtd1gfuTpYTBb2anWl2sxjiYM4f2LsvSeI+iNKsONG8+8mxMPgHGhKCZ9Ua6ljPIUT7RArBvp2FkP7g0BeFuz+y3Ch5aRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830463; c=relaxed/simple;
	bh=XwAfUxgyu0MadKMxzBV5L8wq5A2SWO1z7RK+44MpejU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F5rMkXWETOaeCossy0UrWiaNI5px1DV5z6MreTikAmTbHGFmWXxri4+Nl3COZ8G1nKUOUTYWu2hG0vQ5clLuEtJCAD1zzfenRVrZ2MhT5ue1Yc5FfTGd5GD+rk4xXHOpX5YWUZf150xmuzFmndNIV5qAc3Vgnt72tkZy5O0G/ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnhZizhz; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnhZizhz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791830459; x=1823366459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XwAfUxgyu0MadKMxzBV5L8wq5A2SWO1z7RK+44MpejU=;
  b=mnhZizhzRz+wHMs+rGSZpXiMcptSNh+OZlfM8JwKDt14cZiVBo58jjvU
   O1T61QoczOZxtI2t70kiTGLtuPe8tScve8RnFZ7eiPssirJrJ8s9jyajH
   b2JHGiDRtvshOv23h7VT5uuZuqa0E0LaW595fAHME+4NJsinDAtz3WHBm
   XdoddkiAfan6pfd7oUVjq4jertEEcc6K8tb/ZTDOfh4PWTpoyF+7P7T63
   ykQYTM35knVo7aMtZeobPzUDjpEP06WY9lNuuJGlsJHx5Rl7FunfzWXWd
   BuQbAR3zIpZ56Pt3mP5CRVFG6AXSyldCAoS+hB6IWOl9n7cpwmX2PGDPF
   Q==;
X-CSE-ConnectionGUID: HHfHlR9JSvuNIE8GmyP7gg==
X-CSE-MsgGUID: oxytxJ6AQdCzv2UgRbTVdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="421591"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="421591"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 11:40:53 -0700
X-CSE-ConnectionGUID: REoFVCkeQfyIFT8TRvLwdw==
X-CSE-MsgGUID: O1vRu5niTeG6fYBxEV7IeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="873579"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 11:40:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 11:40:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 11:40:53 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 11:40:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWiZ7ICAhEZTSbdr5jYsOci7tLyE0kxNCfT5j2FVvVCL5mqDS2FwvddMCg7lCHNlxpZ+G8YGB+BfRGiY4MsArn4HbYBHy31GJFhUSMc2Qk3XvFe672Pfbj+0zUk4QeolKj8lxMpGnrFzB2vSg8TfxdSGQ5XAi1f3ZfHc7zYZcBeUz+zBvHzUl/CMlVuXYvDyKSbkqHVrHoHfLsmmzNpAe1ayGKLdBKMgITrtZefDeUGFHFhJitMsmkCzVJ0TmEQS0lPL36s5Xh8aTyV0dwfMFebII5JGSPrQVimxxZjxbNP2pJadrDuqtk6t4pelfCBoHU80iC8HtS2BpgTXsYaPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+IbpoGVgzKJb2wpAO+Bu8ypz39+5IHN7kxR8Z3s7Jc=;
 b=Lpy0mAMJ1PwsYMpEVIEiU0fXoOszoyM9mx/KfIhKQ3VxnmE9G2nqy6gv10wQIvRBRQ7pPl8bUBBmS4BkM58gwXeb0ynv9yMg5eaasoy3AK9EMaAqxw83B/LbW6qtJZtxnMJ9McAxkFwJmzFJ3nqLbEp7cW4y+ZcwwTatlrlpo/hJtDT97XmPabdSF6SQ6phnKmxRkcmBGDmp/KA/RqTKJK+VKG5qHUg2/Az4b3UGnkTY2jNgo15LYSKcJ1IqMWwbiqGXpzkh4EWsjcAVoqT0Gv3QiHQhxkotHfoczclqPYBY3TdVlwegoT0MlOq4fsihSFrieJTtnA4NZmk7yvubhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by DS6PR11MB745858.namprd11.prod.outlook.com (2603:10b6:8:532::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 18:40:46 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.018; Mon, 12 Oct 2026
 18:40:45 +0000
Message-ID: <0ce0ac49-d0aa-42c5-b0a3-08b09b9f130b@intel.com>
Date: Mon, 12 Oct 2026 11:40:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] x86/resctrl: Fix ABMC counter programming
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1791589412.git.babu.moger@amd.com>
 <94c453ca762ef0c32680ac1163099c30866a99c0.1791589412.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <94c453ca762ef0c32680ac1163099c30866a99c0.1791589412.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:303:87::9) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|DS6PR11MB745858:EE_
X-MS-Office365-Filtering-Correlation-Id: f6496ff0-9802-4398-8945-08df289053cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Kre3R6ELoym3vNx943sh3SojNJy0QiV54QrnkdJm2NtIwyCwoMiUBA8ReyBI5fgbpSbDeJrc3y8A4m+aSCEphxcOtpuRczovf1TtlEWYJ0MBiZPferIXSryPVPbQQyZkKTaKt9TpPGL8kgxsMKlaFQXMNvd3VmYaT17wTNldV71QdEmWcZdOZEc/WRfeQFJjXqpZlQrmblIFkF80t1ZyJcEe2sIdwxvj1jbZfrDYoa1ZCV8tNdox1tU2Gtu5njomIa0+HtOrJqCDBOvEZ+N/hS1O+RabN+YVm2AopTOk7n+/ZXF6yLvwt5NyuWHuWUd/WWtXFzPc2i9kv3A7oJVrYEoTNaYPgMvr2SQmYKhHbDiteWxHefeM80HV7NbkuZCMdUldIPvWXfYUy+maMm0G4E40/O1+b7dFMt5Jz3Z52bY+UZ52C7pafIjy4QH2ovzmLjKrICFTby97/7TpFLtdrrYea0VKsdY0DsxrHOqew1cdchUUKLRRGUZHJ3f1Y0fCPQFj2gPvdx+XiHES6us1BC0TbRO0eWPX3CPeGBFA5L+3SclQltiaJ4oFwACxXL2SLHWHVSk/N/8GmQagWZuqVj9nzGffj5gvlVtNxev3vz3QgSkbPq94g2q/rUDB5mXbk0LaG6Mo0Oof9xMXX/IorvIdZ+ve+NFES+9/OyXE4KQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmFMd3R3TW1UUkVCeG9aNE9vWFdzWFlaeDRMNUlkOGwxQnNWRTVlT0RrNW1C?=
 =?utf-8?B?RklVTDJDSnc0b01VelA0Zjh6OHRVMHl2ODFnSHA4MlVsRC9hb2NSSGs5aUtC?=
 =?utf-8?B?QThSRVQyeE0wMm5jeWJ3RVFrSUovR1pOUnNiTTRiTkhEc1NnN3dBYWlQSnNW?=
 =?utf-8?B?WFBsb1lERU51bFlPSEZGdnJRQU5hajBwbHhnMkgxQ05YNTFVWkh1UHVvc1Nh?=
 =?utf-8?B?a3lkVXBsdmlEUi8xZVZmcThOVGFHaHpxQ29zeUUzZXp5UmVkMmpvbTdNVDNo?=
 =?utf-8?B?SERDTUdQVk9zN2s2aTZMVlpmNUJveFJzRHpsSjJXVW1HcWJTSnlDWXJaTjFJ?=
 =?utf-8?B?VXhLS0FyalhmQ05UVXdpVTlMOHg2YlZxNlJjcDFkcWJoSE02MmFRalNuNFVK?=
 =?utf-8?B?QzQwRFRRdkhBYzYxMUdQSGNkZEZKUVd3dTZ2UWlEdCtkYjBCcm1ORC9uM0Jj?=
 =?utf-8?B?RFlBTUhybXcrWFF2eUkrOVV4RE8yb3JZZ3o2aFlsN0FPNXV3Y0ZabmI3M0Y5?=
 =?utf-8?B?MitYN1FabXBsZGdRV0xSa1c0TElXcnlEZWl4TUZBclpKVlc0ZXRsS2FWeGlI?=
 =?utf-8?B?dEVDQVZ0VXZBVFBvK0Y2MW9rNUVZZHJldlZaNUcwOFlPTGZzR0VZcFNscExz?=
 =?utf-8?B?bEIrTEk0UHJkQXAyUEhWYVgwZ2sxSXg2QWxlSTg5UFFGVXQyVFZhaElEekY1?=
 =?utf-8?B?WXFveWJJMzVPa1BlbEkxUzBFOEZJNTZRQUJ1eUh6bUs4Q3hkTUZPaTR4enJr?=
 =?utf-8?B?RmRhUFROc2ZRSTlISjZ1RGRXYXE5SlVIMkcvb0xRMWlBbExlMXBrMUx4VlVE?=
 =?utf-8?B?dVZDR0FIL05ZZldpQWtURnQ5VmpkT2NTdE1Xa2ZEdzZ4Z0UvdlF3aFNBb2hy?=
 =?utf-8?B?VnVXY0hzV3U5a0xKUjEvejNjVlRFVkdmczBzcFcxYW5Ha0E3TldGTXR6VFl4?=
 =?utf-8?B?RVdmazdVUVdqV1lOUys0MDR5NUlWNVlZdFVMcnhZa0RMNTlTaEVzNlltSmNH?=
 =?utf-8?B?dFIrT2VuRlFnbVBWTW5kSmpYYis5RXZnUXgwaGRiZDRXSzNlcVcrQWpGdTc1?=
 =?utf-8?B?Rm1KOE5CekRvUUdaZ3V6b1p6QzhaVzdyN2swVXBuQmtXZ2VLVjRLYmRVS29E?=
 =?utf-8?B?cmRQY0VoblNLRjNrTHR6Z3pqSlFWcEhjTkhEZG5oWWJ0TFR2L1lDQzF5MXpo?=
 =?utf-8?B?Mm8vLzJ1T2dLMlhiOVc5ZzNZM0M4Rk9DS3RxZ1ZLSWQrakcrQnJuWi9NLzZZ?=
 =?utf-8?B?bTB2SyttWE1mM3NGK3V6enEwVW84dkl0V3hyYUFCNWZLNDNQY1lzMkM4YXBv?=
 =?utf-8?B?VHRORmV0VE9kcXRJSERYSUtVejlNZk51eWpCbThZMjB6YllGQlZpRnNTRE1x?=
 =?utf-8?B?K0RUT09GN3ZVcGJQWnVsSVVHY2txWUxJL1dzSzNta0RMQm40UnkvZFpnMFVP?=
 =?utf-8?B?WGwrM2FnSWVHOTRwNmwzUjlVZVpqaGtGUHNLemlCQm8rS1I2QUNuSW1uTFRQ?=
 =?utf-8?B?ZEhBMGxjcGI0dFB0dmRabGg2STJjRGtURWVEQThjb2c3QllQdXY1TmRPanU1?=
 =?utf-8?B?MjlhUlVsUmZlVVhjTEZoemlScVNJT0daNllOOUhSbytFZmdsZ0FpYnhIbEda?=
 =?utf-8?B?cm5ja3luZlNaTWE4a0ladnlzMytSZk9VR1dmeDJCSWdtcml3WlRPUTlGVGxD?=
 =?utf-8?B?RmNISlhBTllYWUMwOWFra2YxUmtXNW1RUVU3MnU2RzdxekhSOFRjUVlJbVRx?=
 =?utf-8?B?NmlveUMxbDQzK2tRdGNnczFxb1E0ZGhQczBYeEZCQXJjSnpiM1gzR0NXN3Rj?=
 =?utf-8?B?WC9tL21QNHJobVYxaDhpa1dzNjY3WGR6eEdzelRkR2YvL2pGaVZiZ1F0Y2Np?=
 =?utf-8?B?MS8rSVZZYUgyVGcyNUxQc1J6V2VtZk1na3RQdklTTHQyR25VRitkR25QZlF4?=
 =?utf-8?B?Qi91VjNwdkZrVFF4VENTSVZKZEVKaEhJSHhOT0xHZzNDWGNLWGJ3ZEpFTUt0?=
 =?utf-8?B?bStUTitvcjRWazV0eXUwSEdqeTdRcVphNzNyMzltTDdFSlQ3OHhqY3RXWG1q?=
 =?utf-8?B?TkIrMXpldUJpK3NzTWlPdDBDZnRvdVNzOUVzY3h0ZFJ3em1hZEk2MUpIYmU0?=
 =?utf-8?B?UGM3T2pheDVaaVFlK3BUcjh1ZW9CbUY3R1diaERDYmk2ZlVqa2ZFNTN6alNr?=
 =?utf-8?B?dVVuODBkNGpWRXpualUzWUgyOHd2bXFKNHVxb0lWRjFXa1Jha0VSQTFpNkcz?=
 =?utf-8?B?bHE5amU2cEJwRmwxaUJ1elNnbVdrQVpveUo2anFWcUoyR3hLOWVhS1U3QjV4?=
 =?utf-8?B?d3oyU2UrN01FQ1B5SXVpM0NGU1hwamhPamh3aUJDaUVyZkthdXI3c3VxOE9Z?=
 =?utf-8?Q?Y9fmO/TEzpIxY9dc=3D?=
X-Exchange-RoutingPolicyChecked: wi2efKIcO+Fl2f74O/UikpguhPHXybib1+6CLZPawLutwwIr+9dFkGbKr+xHImCaq5NBBLeAiN2laBd/WbrdNLEUY49mPZFv3PVnH1rCZbf2rAQrGLOXwvi9BgqjKkA0TPssDns60aw3O99bkaF1Xoz73BcTSI/0ZpieaC+vWHwY9UDkJhyYOz2jnHAKH0WbYJIJal5jwvl3Lzy8wA2SX2UqEUZAR5HvQN7Ry7x2G1qm0/qtmaGNmin3PfzdZO3ZDr25rtFvd/G6DypTCvHIqWXL7bBHAJSovE3BDoiUudL9EDAWVu6Sffq5Qt2IgQDld4pm8EHSrclIgV5QNs1E6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: f6496ff0-9802-4398-8945-08df289053cf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 18:40:45.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Dv79BYf1YILfS9y2W2XpPi6Ok3N0Nr6mvO6w7EV+1D8FmwsLqghRlWtF+9jiIffiBmd1ecS7sUFNBBMUg93BcY06nNwOywzeHmyoFf8OEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB745858
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/26 4:44 PM, Babu Moger wrote:
> AMD's Assignable Bandwidth Monitoring Counters (ABMC) are configured via
> MSR_IA32_L3_QOS_ABMC_CFG; MSR_IA32_L3_QOS_ABMC_CFG.cntr_id selects the
> counter the configuration applies to. The number of counters a platform
> supports (the number of possible values written to
> MSR_IA32_L3_QOS_ABMC_CFG.cntr_id) is enumerated separately via CPUID.
> 
> On platforms that enumerate more than 32 counters, the current 5-bit
> encoding truncates the counter ID and misprograms ABMC.
> 
> The AMD64 Architecture Programmer's Manual [1], available from [2], has
> been updated to widen MSR_IA32_L3_QOS_ABMC_CFG.cntr_id from 5 bits to 12
> bits (the published revision 3.41 does not yet reflect this; a future
> revision will). The CPUID enumeration reports the maximum counter ID in a
> 16-bit field and may therefore report more counters than a 12-bit
> MSR_IA32_L3_QOS_ABMC_CFG.cntr_id can address.
> 
> Widen MSR_IA32_L3_QOS_ABMC_CFG.cntr_id to 12 bits to match the
> architecture. Cap the enumerated counter count at BIT(12) so every counter
> ID used by resctrl can be written to MSR_IA32_L3_QOS_ABMC_CFG.cntr_id
> without truncation.
> 
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
>     Publication #24593, Revision 3.41, Section 19.3.3.3 "Assignable
>     Bandwidth Monitoring (ABMC)"
> 
> Fixes: 84ecefb76674 ("x86/resctrl: Add data structures and definitions for ABMC assignment")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Cc: stable@vger.kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
