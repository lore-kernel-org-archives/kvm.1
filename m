Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28DF224F3;
	Sun,  7 Jun 2026 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780807016; cv=fail; b=OccrM8AanO9e04vrgTZUzYqNg1JazV7PJeFeMpBJWPBbLsk+XSrlBEpZYnJ5i+WJB2P7VPqeDp5vCj/m+kIkQbqXD0fLmshyw26Y1YU5YAH0CwZk+TPdz5NCct0txnQgnxzLmx2zqCkISlCLa9A3/1nP3PkifQ92QIkx7/dfO+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780807016; c=relaxed/simple;
	bh=hD578u0vqQ6yZ1btTtQYdqmYdLqEkNITEUbj5f0+2lI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RQ7DIDA1LEqedXdn7G9BP6ra+EByHFjG5iWvh8PWZcFJsOEISmRRFz4wJPUdPddGrvfLmlg68Gzc9NLpQDuVu+hHUnXQGqL8HYZRXp56JSxdJ8WfnHGqwKev6YEWTb+oOLBhGYP3lTeG0OyDqsqGN/rp965F5kdSH7+SsV4xV+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+E/GSKU; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+E/GSKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780807015; x=1812343015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hD578u0vqQ6yZ1btTtQYdqmYdLqEkNITEUbj5f0+2lI=;
  b=d+E/GSKUfMvyXnDLtIuk3GZm2x4qWPhfgyCxO5PyB5H3/lTVGqXwWRN5
   puhWVWPgqIc6nd6mp5sYjDELld9oAmcdxBHwZDcTC98cWQBFzQsbTmogl
   eLe+/m6DZNB44zq95n6w1dEXxq+xjrlwUfE3ycrIXGNW0ngUCzvUBs1u5
   4VxQaMR0FAYVTx8dOJyxEXod53sGeSDvxi//svBSG9Vqh4Nm/7cqMwz1Q
   Hsi38UCbo+/fWXvorGflarGknz7L8tKJytgwLVdzENzl9K9rqaCAeQua7
   KK/wiHkBbHZ1+uVZjQlekWwt1P+MYNmtkq+DSNVzxpDudW+H07l22/DNt
   A==;
X-CSE-ConnectionGUID: JH8qGR/vTYWwy+EIQgv5zA==
X-CSE-MsgGUID: nMlUspWzQOSl0lEDirRQRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="91903305"
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="91903305"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 21:36:54 -0700
X-CSE-ConnectionGUID: KGAsCdRWT9Ws0vhtD9/UeQ==
X-CSE-MsgGUID: 41VgFowiT8yBLJVd5w1kTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="249534795"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 21:36:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 6 Jun 2026 21:36:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 6 Jun 2026 21:36:53 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 6 Jun 2026 21:36:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tc102MUW+/Xn4h9Z+vXPQ9xuCaJABsp6Z0JGfzVnT2KrPYW3X5sdAS58EGhy5w0o2IVkPriTSWzm5jVlbe0iDtikCGudgS39ECn2iITMUi5nz4LED/O+OiuuHLBbJkgU3Rpjl/eZr2L0xFFE/x/XvJ7vnTXBJ6jYM7AJDQkHtrUmHRQwOXb5OyDFBZzwnlMigx6rKDifaFpXmK0NtLORvFLe5YzDEiPr6naiDLdMc+gbrGg4XXWpn84pqZZb3poCyIHPmxGzxV12ZCBbl8mWLs7TRm9NXVNFki1gvqv8BBaZV8mjO2caQSGKLXmWf1gref2wbOQ7jVoVwZhTHXyJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HljJ3ml3QZJ6jE5okk+fum/Dwzmc/6vsdjyLnNdHEU=;
 b=IRJ2B79GrUsGJIF6JQexUJBYNBFUNQQxsj3NnpgnqM3E23ag1dJ0Ry4PBzS28rmG5+gxagYsewCi1YIe0wPHD5R0+BxICa1KbjEMqCBfiVlwq/brXqmtftQsom82ZTwsgWCL3uVNzuSx7etg5R8rZq/xTtWzMbtfHgOuJ9256JuFErUQqC7QK1ySSdOI8LyCKW5+miH2xxwkDcaAqMkVoElgjvBPBFtLfCnO/6NMQdgA+u1UMDU4vbsRMrbDvBRbc27AH0txQ4dzsajpCfnN+hE1BD8UxcbXGNLIDbyTxtTKAg+nqnG7jOpB9eWAGtrfcZG5XL3fIvaoPXKdA8nisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.11; Sun, 7 Jun 2026 04:36:44 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0092.007; Sun, 7 Jun 2026
 04:36:44 +0000
Message-ID: <5c06bdbc-c847-4dfa-9c89-afbb52946b8f@intel.com>
Date: Sat, 6 Jun 2026 21:36:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::28) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|CO1PR11MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: b316145c-a825-4216-3d07-08dec44e6089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: eFfOqse1iVGm3v8CPs39koVWfGSV+MSKzmKtdZRra7XOCyxubmPHHmlsCMPjsBG7HWt/6upgw2NvOvRaS7gKdsSVedzRi3kjD3seEpAnRFWYO3oScj1kb1vRbYp3gSbDYqCxghMBWSzBtWEjJVFfNmB7xQ3yTj6pyZGd7KBdGNlgGB2awDs+obCKNbe5N3U1ERtvN6p77dDQrBnlN2p2/7qKkj/Fjvuk00yK+MZkN9j8xJM67m7ZqOblS8bFeAVKoLGoHeYrE2/lmgXe0YrM/RLWI9kuzYBdkZLNwhKL05uGDuT5gCKqpF6CsX2cKBciBk0X4uTnB4uaqn/0KaBLJ45iF6uyCKUrfzTcPMV/hiFwMrJI8gQ5p9EPu7uGH5dAtnnjzl9d50mKsregk9ZYhZ6sM2MkZI5035yHgt5vHVtiBspRrIACjboKQrjT7K3UMymxMLGhFSyJDg5AsAMNrVR7qtONiVCBQScfxRS2GAh8H395/CL0v3hjteNpA9U8PDNZhM6F20kX8Leo3FpsNIzO5pJQ/dMHRbTzrCep2koSXSZBOSFwZge8wR50XOepE9quvveFriH2J0bKm8eA5NYaRar5R0rtNmkPSSlbh05dMPuMf2sDX7ySWrz1UyoZKpKHbyAWWWwPAjg9raY1rBePbqRTpBFaHmMAEYQpiwKRMt1MSmOOAIrKwSX8p7xU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkVFQVJ2a0Nwd0s1eEQ0ZkdleERIaUdqRitqb0JKZzRxMEw2bTB5UzdjN1dq?=
 =?utf-8?B?RzN1VFk5RDIzKzhDT203YlBvajE3SGtHNC9BUTBFaFdZRll3Tm5Ra00wT25a?=
 =?utf-8?B?QWc5MS9yVEtXdHhHbmY4aTBxWExkaklOUWRBTUNTSEpMQzRPaXdORDBLYWNK?=
 =?utf-8?B?RGkrRDJtSWh5enYzajloZXIxRFR0RVdSbnVmaHRRMXFrbWErWEF4N2p2MFE4?=
 =?utf-8?B?V0V3SlZRaXA1c29mOXRlREpCSitEL2RFa2JoV2hnc0NiWCswSjlEQm9pVE11?=
 =?utf-8?B?OUxVenplVVZ4RHJES2FaajhzNHBnNDhUSVF0UVhkOFRLY2NldHMvV3RpVEtR?=
 =?utf-8?B?clZIc2RjdUdKN3J1ZVJSa2w4dTN2TCtCc3NhdzZDaDhSNEJuYWlmN2pTY2lJ?=
 =?utf-8?B?aVN4Tk50N0VCUlcyWEkwY0drd0c2V0pHaG9RREUzWFZJMng3ejgrNjF2TzlF?=
 =?utf-8?B?OUlYTWZ5RGNscHNJOXBFaUNhN0pRdEtpK0NFQUx1TU5GbUNYOGxENkVVWldH?=
 =?utf-8?B?Qk5tVFVTZ21OTjNRSTh4eGM4WnRUY0UxNEowWndxRFFkanZJck9HMDhXWXA1?=
 =?utf-8?B?b21QOW9TWjBWZDVuSi9LM08ybTducWZ6bGdMeURHSng1bnBLYnIrQ09la01u?=
 =?utf-8?B?VG0wNUNZSURiRFZLMHQ5ZDhWa25EWVAzb3FBMWYvRXl4OGZieko3NE1hK1o2?=
 =?utf-8?B?UlozclIrdWhwZHJsaVU3YU5MK2prcmFMVDd6ampOWUdhZWtoYnNJNzZqQ0RI?=
 =?utf-8?B?akdLK0pRSWx6UTJ1Qm5hdkJnVHpHR2J6TXd6RDUwd0RheHlOREVMYnhKWkpl?=
 =?utf-8?B?Z1NyM1lFMGoxY2VrN2dlK0dYeDM2M2FlQ1JHL0d6K0RHVGd5VkRsNUZRYlAr?=
 =?utf-8?B?OEhaS3pnM05COS9pU1d2QnpEYkFkQ1JhaG45NGtnNXhZTFVoRnBFenVmV2Zi?=
 =?utf-8?B?eWl2UkJyKzc5aktsT1Z3MzVyQmJtNmtGbnV1dnYyOTNtMXhlOWVSZVZIOVdM?=
 =?utf-8?B?VzdPeEYwYWRkRVRnMzh0c2VuM3FpVnFyOEJ3S2VLNWNLbHNsbG15QjlxTUwx?=
 =?utf-8?B?T2RDSElaaWtKQ0ZySGY3VWNuMDlFbzdIMitQV0NsNzc3Q2MyUXlMY2lHSWU5?=
 =?utf-8?B?bUwrOWhOR001dkw5L1JVM2xXZUdlUlFJQVRNTjcyMjUyUmpONVg3eWlKZUg1?=
 =?utf-8?B?TVlrT2E3dW84Nm9jaXRxM1V4U1BXN3A3N0ZyRTdGZDBKWjdyckNWZkRHVUMz?=
 =?utf-8?B?MitoWC9XRUsvVUZrSmlUMktCdzVWNnpJQ2lLM1hXbnNzL0JHdEI3OWtzdVhJ?=
 =?utf-8?B?S0FPRXQxZmRROFd4eEFGcWg5TUdJWGh5Zk81VE1OM3duTVEwNWZPZGZCOWR2?=
 =?utf-8?B?RjRVTE5HUmVCWHpjQ1k3bmxaVUdBbkdEZDM3UmVMdjdEQU5HMk9FV3ZvcThD?=
 =?utf-8?B?dExoR1BTVjU3TW0xOGlvNkxOYUFpZm9yaUJmaitBV0NjME5GQ2VXRU5tNFZt?=
 =?utf-8?B?WmlBbUxjak5DcFpSQ0ZEQlBDU09CM1lWWVNUQmZid1JSaTJkVDRTR0JFSEMv?=
 =?utf-8?B?NGZjam8rL2FXY0ZUWTZDc1U4a0F1ZHlrclhsSmtPVnIvM1Vtb2JnTGlNU0dD?=
 =?utf-8?B?aHZCeGhzQ3dXVHhZeGp5elA1L2UydktPMmNtMlpwWTRkR2ZiVFovTUlQQitS?=
 =?utf-8?B?YUZmQXVuMXQvM01ILzgrQnRLQldrU29VMUxJYjJhNGZVc0lidmpla2NxZysv?=
 =?utf-8?B?VmpTSENPc1J3NklCdkdscjZWd0VLS2RVVHJmZitsZ0Z4R0tjdXNmZU5PbWNK?=
 =?utf-8?B?cVNlL1paRGhQN3ViQ1FyanpsR1p3UXVpRHBXMzhrRlVFVjhTYW5DTTQvS3R4?=
 =?utf-8?B?dzZPa1NUMVMzSXlha3Myazl5Y3JiMERvdVRHR1dSUzlyTXJTTjRPWHY2TXJ1?=
 =?utf-8?B?NThmR3p3RkRvVVZqT00xWkp6UERNMGx4cC9kNWRtKzNNNEJ2eU9XcjRPdlFk?=
 =?utf-8?B?YTVMV3pOYmVJeGtTV0x1VllWREhNN0dvS0QxMFltK0EwQk9iU2hGVHRoMjho?=
 =?utf-8?B?KzM2U3EyQWtZOEJ4NXAxSzM3NkUyVmpMbjNXd3hldWVWZnNuWFFtSU0yN213?=
 =?utf-8?B?RHBhVHlGc2lwSlhvRk5Nc0t4QTJkZFAxK3VpSllrQktkUTdiR0dIbmFCbHUx?=
 =?utf-8?B?Skt0aUUveCszNkJYaXFNVGF2ZlhGcDJBU0RGTlU0VnUxRWdpdkZGN01xeWE2?=
 =?utf-8?B?K3RVVTljTG1LOHJPdHRNaW1FRTl1QmEwaHkxVzFyQTljSmV4Q3ZCZFArd2xm?=
 =?utf-8?B?VnNFOGJueWpCR1hBZlRnNS84TWN2VTEvb2tERUtjRUQvcDBIM0VNdz09?=
X-Exchange-RoutingPolicyChecked: GcHl4gBjz6ZXUPqKVhFofDDeNSW9giSek7q2zjwG+jZrJxoJB9Ou+1AnCQqaGzN15WTv88BCjJPald/pF+xKMkS4ZzRqk7/hnUGbU0OkUeSFCyItPk3d1VPD+VQ2UHBrPmXtx6BKpCfHUdOtkyyfQ0fsSzCid+9wQzzgqSwqBA6jYHjEEC624MEn+tYUUW9OeFADa9EXYK8Eo5FXC72sdq9jKAtV7OZx0bPA+5Tf6ssNTSuNQyc+jx182ig2lq2tOpV4KoCT8vyLZ0anz/mskOaDpZIGdsm8bJt67A7dHuRONzKQU8cy0JXi+/cfMe+QcIxNIHAv7udsak1edIShpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b316145c-a825-4216-3d07-08dec44e6089
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 04:36:44.0443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IU5Uy7daewp8bWbE3VXjHaXP0Fb8gvqN3lzunVXIZC2X4Kb/JTGzcv86zX/QsE5DR+d6oJ0sAYmNxtxoAQEwJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
X-OriginatorOrg: intel.com

On 5/21/26 8:41 PM, Xu Yilun wrote:
> ...
> This series has 2 distinct parts:
> 
>    Patches  1-4:  TDX Module Extensions enabling
>    Patches  5-15: DICE-based TDX Quoting, primarily Peter's work.
> 
Perhaps the extensions enabling patches could be organized more simply as
these three?

1. Add TDX extensions metadata structure and accessor
2. Add TDH.EXT.MEM.ADD
3. Add TDH.EXT.INIT and wire extensions init into init_tdx_module()

This introduces the SEAMCALLs and lets the wiring land with the patch
that completes the init flow, avoiding a separate "enable" patch.

