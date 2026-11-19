Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795050935;
	b=IWQgIkczdjiomRguAaybnm/LoKMi4uZHzXCqRCz9ToMOqTI5OXCdEdMnJeBil1i4yy3v
	 GN5ZQTT/p07kA+7UB+auh5uJe4hfGuTmJJ2l6w4JJPu8H4vxIAxKJE3rin0nCKTu5QWFU
	 kmNcRedSkliJA1bzrkrp7JcRRGVSXeUq/WzplDbWwkZ7uXy3rCa0D305QSVIxpN7L6uxR
	 GFcDZtYuFawJw4Ixgxe88zZst+rZXD9DthnO6rjbyiXvPw+fvvQPMsBFX4Mog8BYZQ8/A
	 JqfUnSesgpuubUV9NcMamkfCkensJucEqpcV2wH790psyag09SzKN3njMjeW8la6P1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050935;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:Content-Language:To:CC:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=ZxwukOUQAgHXFx96JW4vaD9x7mvOzAmBOPfBbMFCotY=;
	b=ImFkniXsu73ZewSRC7EXgneOHyi2o3/WatM9YqiJrOEs9KhPllyXaK4A8PsgZB+BrKJs
	 5001rw0/sCnO/EpF/AA99Hb0andg8wP+ge6UQ4wUJ4kwWbJT7wQAMbCfcJkkBcNxgpSbk
	 B9o90h9qjGDkqWRh1frGTOcvBDmLm0uQrwVZLH7GOckt0SlMy8ZsTNDxJAe4ezYpcJeXg
	 Pghu0GUGdRpRDvClImgLiTCJWbsntmD5VUHl++fs+L35GeOYooQY3OokcioGDG5Ase9hM
	 qzvdbWeqbp3zognskDAX1oZeMMMarO0Z53Ey2RDXRHqEE+166LueahCTzmrRQqUYBfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=asp2pG3H;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=O2v7sC26;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B71606A31C;
	Thu, 19 Nov 2026 01:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07B71606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=asp2pG3H;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=O2v7sC26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795050936; x=1826586936;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3kkKCwjZSJJGTWQu4DDflJk61N57OOInxGqXIZZGgJo=;
  b=asp2pG3H7QoPHjiglWDxxL8yasnf2njJ2R1wAR5WAJu5kTolYtmRLQlr
   p5q5QUQVR/+W5UgdPXodlukO7gOqvoJrk1N6l34W6g2o8zrkr6k3vlnyI
   JyQV0sHFzkoPJjhnDivLmNmIUKv6z4lBXrbv4YTOQ1umyu3isHhgMnGrO
   bbw/f0DFhD14lNTbKJyC6fEMzzBUmuCTWlQYyBsrDn+XVA6Rysj4VEWdS
   U36t9lM+mE1wQYLSjtgV069jJQ5qqPh5Bb69rhCfTvL7edkfwIdGCOB0k
   eKzesk+sEp++hRV6jU1Y4KeEFtHS98nInZlsAUbyPHR6h0wUwpCCm/hu0
   Q==;
X-CSE-ConnectionGUID: pa1QNArhRZ+clks7sN/Ndg==
X-CSE-MsgGUID: ZoNUD1ijSyy5LC9RtIiHaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3889694"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3889694"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 17:15:34 -0800
X-CSE-ConnectionGUID: KM8ipze8ReqaDNbXkxCpyA==
X-CSE-MsgGUID: 2U9UcjlcQ+Ojd6FjGlbJzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10857779"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 17:15:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 17:15:32 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 17:15:32 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.29)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 17:15:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEdrHT8TJ3piQmeRbWZTA+mPDCfvzZNvWhuHENL0M31z4gbh861hYc1CvK65q4SfD6tBi+AVN/+XcUoG0Ut+wEa9weOHReMcNNSzhYn5cJ3/tUldlGW+Hnk54yPBEFzXN4RT4nfd273jDHOOTnCiZp0m8M2ZZlxLDdDwLgsMlGYXu62B5PQM2/5PCDAOWhzotZEtz+zLLdmBeSEYd6IuS7tV9mDbQj7b6kFIOs2f2mnVDSlLdw3JGnWTbTz1pzDTotNKe7Um4U+CJHGCoJn30rK5tdNb76UvuDLlvXuc/7j9hSf8XGQpK/20vSTPlv8X4mcGZRkLUDROp088i48azg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxwukOUQAgHXFx96JW4vaD9x7mvOzAmBOPfBbMFCotY=;
 b=IMkWpYf1kaidv8kcdcGrnN5NMY6F6pJVIM7+CuILVNeeojbAWz0xl0MdMlr8GVV5yARAMJhLG/GdejkXpPnmlBtlaifXT74Epw+/rQ4TME5hrhipDzxUWbsMr6hZ6yqxVSps4PRI8HqFdcYT+gEPVsvtcxoJpK+zIwBhOXdBeZgvRKcqV0rIJpsUy4NFsqme2TGfO4l0vtrL9BaO+DzcUphQt0zVuiO76K7Wpuw3FDKwwpnEns4ix437URlD9zODp8WnDdty2iZpFI/jECJCC4OVKj7s9sPvlGzEgq5apPHP5ttWb8bsm9xJpn9+Bwk5yoEwT29fb0+NkwWtVyUA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxwukOUQAgHXFx96JW4vaD9x7mvOzAmBOPfBbMFCotY=;
 b=O2v7sC26YsFgMF+HhRwMb+2OZgpJv/eGHxPeyi4meowW+Q5DPWmbX0Ls9J2PXYX+Wq0CVrcwGfP13DKZVB/wBc6Y4u665WcQRFqlf/XCPd8a19xR5AybT++k17mmSjb0pUltUcj9vAmDlBupJ7TczV8j3bizCZNk5xNXg2B3CqE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by SJ0PR11MB5055.namprd11.prod.outlook.com (2603:10b6:a03:2d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 01:15:28 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0615.009; Thu, 19 Nov 2026
 01:15:28 +0000
Message-ID: <f5e8085e-0482-4f65-8f63-ed5f4e7ef85a@intel.com>
Date: Wed, 18 Nov 2026 17:15:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 22/28] KVM: nVMX: Restrict event data VMCS fields to
 FRED-supported hosts
Content-Language: en-US
To: Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Nikunj
 A Dadhania" <nikunj@amd.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>,
	"David Woodhouse" <dwmw@amazon.co.uk>, Zhao Liu <zhao1.liu@intel.com>, Yosry
 Ahmed <yosry@kernel.org>, David Matlack <dmatlack@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-23-sohil.mehta@intel.com>
 <f5a4c1d5-cb66-4efa-80c6-92b7d8f543d4@linux.intel.com>
 <ausz2bKMJQ92ZsPR@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <ausz2bKMJQ92ZsPR@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0196.namprd05.prod.outlook.com
 (2603:10b6:a03:330::21) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|SJ0PR11MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ec4573-c95f-48ac-ab55-08df45da98be
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|56012099006|11063799006|4143699003|261026121527099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: C4Sb244nfTMNTdi1EVkABINxi7YcXq5xcPWemaJ2Kr+wSQyopufbM1Xn7CJZhxADAvfKdpfbaPdz/T8ZsUEJ7eOZl6kWdk11n3ceyQHak+yyFRF1r1fr/zlOxgTCNjSDSrrVTWgRgUkEV+EgiTwlX9dxPJdx81eTZqqnH9JceubvvCYp2zFXTogHqlQtYOmQ/R0BTT5Xeek98SeCs14IWsGjSiStQro1cnhT/CGykdPaHaIf5WM/+lcHj9X0BmmziOdDOe4HSnfX0w7ODbihJRbdMulCdTny5PAQ85FGaf1rYzSzMd0J9rT3rMFIq94w1RDzZitf1Lb+ZsM1pdbpWec+LM15A8yVES21Psc+Ed7eqz8esb0bpdopnVodBzSGB/ZGtSyKktz4I9nfm6Ji3NL5w0ZIPhF4tACEw0KEZA4u36oAW4cXuBVV82pAdj+7qk0HQtIBcnA1Dhr73GfenLu/vGHTx46w8KYI0ylrpBoJYC0g28TKM86FIjXa9LegfZNwFm3oYMX7gL5N0DN6x/5YyRtFMWrFQSCAWD+a7PFjKo2GyTEd1MSJeCBD68CS6oZNaXB24oiR/hhZAKXV9e8GTb2eeertaR8R3fjVnDrESLwWFgP2umwZGvWKSXMHPr5gVIVlwju0WUDXhtb9LYFnH7htdjt4zCJDlW9kDMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDV2bk9yeTdjSk5rMzFwZnYwZlZWeUV0WWhZbVI5REViL2licmpQb3hBUkUw?=
 =?utf-8?B?cm80YU9EM1M4NjBrS0xlT050MkI4aFlQYzBZUTloS3BBSUgvQnNWSjZqdFdJ?=
 =?utf-8?B?elU1SS9odTA0aVdxSW1MM2xRZmFTOUdjK29aNWgvS2dFL1NFR0NOdlJTa0ND?=
 =?utf-8?B?dnlTbkVuYXJqbkozVkFuSG5BQjBKL2V2cnNxYzVsV2pqZVNIS0N4Z0lhV1VQ?=
 =?utf-8?B?N2QydXZ0QnN1TUZqelh2aXlCL2I0TkRiMGJ0bGxLdXpJWjdwRllQNWY4ZjJR?=
 =?utf-8?B?aDUvRjd0dDFTYVFDRmNhYVlMZVd5TzFvNTFZaVNtd0g4ME9ONXRTVGFWNk9x?=
 =?utf-8?B?RWpZeEhDTU5lT1B0aDByRE9sTzd1clZJeWNYbDJRSUd6dlpMdnBMK050QW5X?=
 =?utf-8?B?U2ZCUGxFYVpSYk90WXBxejlmQkdSY01LWEM5VVcyTm1YdDNLcGdib2VOeXRn?=
 =?utf-8?B?Y3RVc0g4RkdITHpMMnFXUlczNUM5VkJFWG5TbXZSZlNkR1JRWkV6TXRlYXMx?=
 =?utf-8?B?RUtnMzN1N2dUSml0d2I5VllTL1ZIcWpoKzRRM1JpMzdPeVpnM2g1S0t4Vzdi?=
 =?utf-8?B?ZURWc3hqQ0dEQkxLeW5hVS9Ma3V1TldMK29oWFVwQ3RnajhQcVY5RjZCNUYr?=
 =?utf-8?B?ZXI5SC9PL3J2eHg4dG9VQmFqMmZTYXhXY3BQS3B1YUNrQ3Y3N1daOHlVM1Ju?=
 =?utf-8?B?U29xWUVNd0JqdDJCVm8wQndMcXpLdDJZcEZWd25temRPQ1VJWEZGL1JZazFJ?=
 =?utf-8?B?QUdSbGZJR2tycENIYXM2WkwrU1RmejJMZUt1UFQvZFF6S1NBWi8vUHlPWnhW?=
 =?utf-8?B?bUVwWUpRSDhITXdJRXN4NjJFRXhoL3pHajNBRVNxYmhSM3ZLNHphSlUra2dm?=
 =?utf-8?B?UEQ3aDlCTXhJWjhzdUFqMEJ0amt3ejMvSUdva1pXYWQ1NnUzbXVxdmFQOFlt?=
 =?utf-8?B?VnRoZjNyWmk5cy90MC90QndycWkxRzlKdVN2TlN5R2xwQ3ZEdG9zc2JJUmwv?=
 =?utf-8?B?SkhPcW5rNndzZ001T2ZuN0x3YUhISFpZSkN6d1VkeW1MSVg4dG16ajdZQXV0?=
 =?utf-8?B?QlV4RDQ0T3pKR2lJTkdSQk0wejhucDRJZFZLNThUM0o3Mk5FelI3RmVObGdW?=
 =?utf-8?B?RHptd2U0dFpPWlJCZktkZE9RNjlONFBaaExNdWFNcVRNcFg2UHNMK0p4M0ZT?=
 =?utf-8?B?N1lWUmM1ZkVsb2wyMDU4SlB1R0MzMmU1Zk5hMVJDbHlXSUI3cVdEdURyTmVh?=
 =?utf-8?B?Y3lpYzAzS2JGTnFFK1Q3OHMxREVBcHBuU25oS3FJMmlaNkhGVzNDdkRMcTFx?=
 =?utf-8?B?eFBOaHYzN3gwakpWTVptaGNnYnExamw4OWFHcVZhRytXeDVtNk1KQWQ4MWgy?=
 =?utf-8?B?QlcybDhzWVRVUDlCRGk2Z1Awc3NFRnJMdWVZVmJCVDhEdXpqaUFmckVUOVAz?=
 =?utf-8?B?RDh4LzZpN1BnamlkU2tlUzNUUkpHUkhRcERHSzV0NWlBaVVmSndtdnRxNUJ1?=
 =?utf-8?B?SXFkMTI3Y1FNaGVkdnBWa0V6MG1HMXloeDZzNU5KSDFXS2tMendkdFdtY2tL?=
 =?utf-8?B?TnEwbnJkemNCbDNsNTdNUHRML2N3a0pJZ1VFa09YWlpLRlc3RnZDWnF3bi9u?=
 =?utf-8?B?OEVzcDJYUUNyUXQ1bnVPL2ZqSEN0TFAySndOZWI2eS9ZZllDK1NCQXA3VHFp?=
 =?utf-8?B?aDdEQlZTRFVTZEVicHRTaHYvOGt2NWorRDBPRnh4OFFxNDhKVDZ4dFFqTHhW?=
 =?utf-8?B?NzNSWkk5azhGQm1Fc3RPb1JhTnZwNlVvRWs0UHo3TmpDL0NjNitNOU9tYjhq?=
 =?utf-8?B?Smc3TkdhRjZHMWdsd1hidFlhYS9WQWFOQTZpSm5VSERMYVh6Vjl2ek9wWDRK?=
 =?utf-8?B?ejY0dHlRRS85M3JzVnhHNzhka1NiSnE0SnZIY0lQczZxQkR3YXRpdjhLSHJn?=
 =?utf-8?B?VHdualljMml4NXh3bEpnRTkwbkxJa1lleFMrZzlqOGVvUHZaWnV5Z0xNeGpj?=
 =?utf-8?B?aGVObnVYRWU1NEwvUDBnRUd2TDhhMTdSK2VyTzNSa3czWWROSFJxYmR3bkox?=
 =?utf-8?B?aC9iRnpLZ2VPUkcvd3RDMTdySnJSeEwzOWc1M1BGQVRHL0JvaVVWWm9DejF2?=
 =?utf-8?B?TWJFRlFlOXA4UFc4Uy8xUHRTNHJlWGRCMlVEbG9zbWprTldLdHFjcGxyMU9q?=
 =?utf-8?B?UkJmU21PcnlvVFlxWkY2L2ZXV2R5OU12V0hUQWUrVU5sOTBsVzBzN3dMZHd1?=
 =?utf-8?B?dS9SN2dyMFRiOEFqRzROekR2YUNTclZBQlJjSGdvMjhSN0h0Wm5QVmRTNVdY?=
 =?utf-8?B?a1lFc1Z4azJjL2RlelpickhyNUlNblFmbk1WTEltVkVOY0FBTXRnZz09?=
X-Exchange-RoutingPolicyChecked: 0HuJxs3U9EjIXQOsqYos3M7Emc57ESAn87lj/Jal/WHtmlE8QK+ymJqPgwIP+KhaRQGQ+PyGBK7s4d1BrAIn1gBNvwthnGcD1UGDFmyZ5/SR5uIWKjSFumApxZ71QGJkaRsAHpp/Vjlg3auIM5UzA8R8Q3FWPoPU/uvLnjyFC/Y+WPD0Lr0Nfec8wr6woA4qJ3BC7N97MCKC2kg3Odqw3gzIxglXWgOLbpi+Y6RGGxRlDbLt8OpU2WtfO86ZSnXBZU+SktP8ddcBqX1YGVf4IYzOTkP26Ks6JmIEdc145Rt2QFM9u3NXiedlIVIbreVFqk5jlQ/sPEbt9sdMiE3GjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ec4573-c95f-48ac-ab55-08df45da98be
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 01:15:28.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6s+NNNplxn1aYRI2vJcQGmiJVNoSHnxWr4mQ2aydFBGQO0omAHN3r+qSVYVt4pCCvj2nGV4AW0MqUo8ZQB3o7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5055
X-OriginatorOrg: intel.com

On 11/4/2026 5:32 AM, Chao Gao wrote:
> On Wed, Nov 04, 2026 at 02:57:45PM +0800, Binbin Wu wrote:
>> On 9/12/2026 5:36 AM, Sohil Mehta wrote:
>>> From: Xin Li <xin@zytor.com>
>>>
>>> Prevent L1 from accessing the ORIGINAL_EVENT_DATA and INJECTED_EVENT_DATA
>>> VMCS fields via VMREAD or VMWRITE when FRED support is disabled or not
>>> present in KVM.
>>
>> I think the change log should tell why the patch only restricts event data
>> fields.
> 
> Sean preferred an "unconditional" rule for cpu_has_vmcs12_field() [1],
> i.e., new fields are added there whether or not they are shadowed.
> Following that rule, this patch should cover all FRED VMCS fields.
> 
Sure, will add all the FRED fields.

I think we should also include the secondary VM exit controls case in
the nVMX patch that adds it:

	VMCS12_CASE64(SECONDARY_VM_EXIT_CONTROLS):
		return cpu_has_secondary_vmexit_ctrls();
