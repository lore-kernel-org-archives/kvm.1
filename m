Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9903D3D00;
	Tue, 14 Jul 2026 06:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009899; cv=fail; b=bbFYxVK3bwpkUL+F5EReQk94MQyk44/LzTrKaxPBONsszuMTp+8F2VWyToRIfQNYfCUeM7EWl/lQzGNjmdELt2jME5HYTIDPJuprAbFi06kMGIykw9eEzFTU+lFhRo/nDnxuWPv2FHqeAQRU6e8zPZTtddi4D/PHDCWFfSSbsAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009899; c=relaxed/simple;
	bh=Md4/r6vyPgccMDOZBSPa5+dAWw8nIfb+mGRyO9xK5KE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HGudmVzjcT6J4VK3zZhWtMwRHkpBSaEzjX+SZMQgp/u8MvYbybvj5NNF5UWMmHUqMpiKkaxaRV0pLvhQr7yolTGfjieysCBt1UiJ+Cia+54Pgmp3Kq/TAXO2z/cUberazEBm7VCEuZ+GkvWVpN/j/SHKJkznAEGIvTeb9IEqWu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lR90rMJi; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lR90rMJi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784009897; x=1815545897;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Md4/r6vyPgccMDOZBSPa5+dAWw8nIfb+mGRyO9xK5KE=;
  b=lR90rMJi3h9pTH6WPgNnaT9tCGbJOTDHkrB4q7ITxcy6ugHguLatq+Pf
   TCTnywK1Yl5wFo/X9UNa9NUeJUzqgHVpTQaDrWzFsAG7aYpizhP0GvaBn
   FGoIInxpmDmwtlmchSRSF/bq55bpOZ16oeWSBk0uWHPYB+Y3rSHd+IMbb
   QAx2u8ruc/OzZfjuHFNfVGZVblq6YJ6SQiJ0oD2vpqjaY5BtrPnRbRPJS
   X9tXsziX3nLYEz+zyHjtB/nmGy1/oOHlOqzkQFw5yhjS2O2TgAQOeU/W6
   Tc5W663MxcivDm1llRsRvq/NSFFZ1OnVge9obELc9oDbjw8ScBswNGU9O
   Q==;
X-CSE-ConnectionGUID: 2DeZig4xTwSfivOnMC8qtQ==
X-CSE-MsgGUID: ToBOdJQGSvWvbMic7YORgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88303920"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="88303920"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 23:18:17 -0700
X-CSE-ConnectionGUID: Mkuu+dm2QIOUR6MdPlCMJw==
X-CSE-MsgGUID: hGwE7rtFRMCNc6IX5/VaHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="256408469"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 23:18:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 23:18:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 23:18:16 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 23:18:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK+npCUHtQTSXLdR7G8sPHg3/p9ee15qEwE30B7qDc8caC2ai3B7o9wIxYhmEsyxA9GRS3I+8gM9Fppa8MuwiWHbNc5EO771IOpIYsMULHVICU6JI+ZEkD/fj7zTlyPu2eC09dYTkx3RZEqn+1+Kd0lLKi/uR9jxhq8U9klpsJPpxhxJOMnwx7XDKfIyAD/CGjHPnlRmPx9ukM2pdKNtHcGkbSeByll7DJ5AcUsKkhX/QwzSdXAiw3VfgRnFNeGE8nLPRnC8nqS7w6ipuwQtJgCreDI7/L0juf9tv0vis1Dign6t32SnYnMmkiYiHVwQIoDZSfxUHurV6SEDvdGqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BogZRzjYmSw8G02NivnDiLcLZRjvzN3q+fQEeBABx4A=;
 b=YA8KBBmuJgDtxfd7HmSwjsGXCH6XLf4Eb+5Y3quqpM8QHLnVdrQ2JkdgEH0BEdiHDBBsx+a+nRlQ+tDfJY9nvx87boS5qvJZZt0yZe+h+IxUCr6vHn6WJttTBKR3rTYX2lSO0bxrlhxqK08QsJlhPkbnovTmrG40P9E/G1bi2Ypm892ckx617Nx2iMzpT6FlYS1Jv+ylQMmfNTEWxUVrAEKhupqW9HU+i/10Vw4eLODdKRpV7Gbvq/Xe62OHdMoQ0yvUHhzXCnkY4fuVOlocJUbksY7aMSz811YSFfPxOEQPx0cZq4N+uin6nOScj35uZe98VaoyO93vSsE5pbGVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CO1PR11MB5106.namprd11.prod.outlook.com (2603:10b6:303:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 06:18:13 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 06:18:12 +0000
Date: Mon, 13 Jul 2026 23:18:11 -0700
From: Peter Fang <peter.fang@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <20260714061811.GD3178326@pedri>
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-3-peter.fang@intel.com>
 <62069ec6-b586-446a-a696-6aa3356ac665@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62069ec6-b586-446a-a696-6aa3356ac665@linux.intel.com>
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CO1PR11MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: dc49cd32-2dbc-419e-738f-08dee16faefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: RSJ2n8Om2HAy+MrqZKDwajTjv8II//469kBcPfJPFNa0xKVNxyhidWpfBXmqFf1z1ROUcegdtJXZXsgKBb3askYh8B1HX2pfZPEpI5kkd6fk4RGTJvbNOmN4zj/KeFzNkcWwk5ubt8gKxw2oAtSSWpU7QIeVOoEBL2DP8ypaRxd2kElc6RF5DX1I+cGn/chMBVwW4PiSF1eoA0/baf+qEbTH11L7uViPiQUUCuR4GVl+0Kuxgs13yVDr+Xr9ogFqbajvt5vMRKxF3ivrIpIcY+YNJGoPfkhCy+KM8QEn7muUYn53xNMGPGS8DwvooM50hJwADjJAad1gq1ABp2YG9CDdR8KnOFIMGh+RpFDkkFukQ9FLN9ZWSP3DYN1LP3EHiOnAqjnqTAvYRV2ZONdzZg2CC9BFyD0F3qlRgE2ozhP3Qy6n4M14n/6aOJA0MDi6jNu9iWXpJKiYqYcbPTx5SaELxPd5aDLYlvnfv9FyujkxHwPoAoUqjEv7teap3UdIMciB8BbrcVxsp51PbvsWJvpOjmEYX+dZmfMq4O7LaAzx2pMflDU1mI0DGHFg0BZkTgVc6G+pan4SZrqf7GgzctMXhZx9m/MidjgghHLWuhU9gaySkxSsWSHlUXRrck3W8zMC8X6X9pDG0MfIGruSP0CTRTJ9RnCkoXtagNn4SGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NaPECAij5jB1ZsRekGoyCISUWmgEHlZolImIEGqlp3d/fzutl6vYUOSVRVoY?=
 =?us-ascii?Q?WCrS+nRUlWow5eoYaJiusywOR+l8bHsrUizk8Kg77xDf36QBJTO9oNhHJa1h?=
 =?us-ascii?Q?5pfh864XHFuwitswmoZmwH2pXadDtfWw0OGb0vsfrCJpb8N+OfzN234hk9PJ?=
 =?us-ascii?Q?DtUpWfWSeLKcF92p2+YG6BnMlDLmSOV7lT6NLtZZ/O8jibjcdY+AAXeyjZdu?=
 =?us-ascii?Q?X/o6kKNE6xUD8gto9bJhU73C7fa2EwdhUuJgGr31kBQKOx0u/vsS/MCfRLvm?=
 =?us-ascii?Q?v0/csclar2ISM8vPoAiJ4u+u3nYe9io6K91/HF67KPXk08GogwZUyGV/dy0A?=
 =?us-ascii?Q?OnkYKH2apl8zrj3BVqWdtEpwVocgQy0W3ZIvHWWt+h1+mTANPYeG6TBCxuZp?=
 =?us-ascii?Q?UMeRBfHtgzoq2L1wSw9wimvWvmXbPaQzvn4m8gIvejQ3RNek+Pi60rLeUBSq?=
 =?us-ascii?Q?V7pF/Jb974Gfp8nUt58VLrrFKbet1wI663h02MUO135ZY/PEHx3rQQba6BGf?=
 =?us-ascii?Q?Zd7zHX5KQjc+lL8VqnXN3/yPrI6HssHLektT7darJ8O7Nwz9NNwggZ6VjWev?=
 =?us-ascii?Q?covDFtbXLoZI3V6VZAuZFCRxoP4niav9ZOQs4CAOtkAxbxHKN+++K/ll0ugv?=
 =?us-ascii?Q?/qLg7jyP6N2GYJqtPxSx4SCzHmFXyeEqNUTBVsRkAG8XrjaE9/XOpZ3xorh4?=
 =?us-ascii?Q?yb8HpQhw2ZHoU4RQJwGLeZUgSWMEfr6zpRkDmsEDdA5kPIqYP9enrw64KJWT?=
 =?us-ascii?Q?tkL2mDEmdIlRVnTP/wrWVFLk30YsC8n3RdRgj0SsoJJnDtSULtVaDunmsKBH?=
 =?us-ascii?Q?H/Vo3EA75iioF2O23MdL2VTEzScbm2yH5cXgsx5P1G5K2Mkz4j9r3Hj6nXEy?=
 =?us-ascii?Q?EL7fDQ+H0h54oeObZ828GGx73tCpiu8rAQ5tF7Kl1HvYgli2efi94GFVnwXI?=
 =?us-ascii?Q?gtUve+cRB/mWj70VpdE/+ccW6v9r4ZqpAQ4jVbg88imldDae/FD6gxZ1ALOT?=
 =?us-ascii?Q?X0N4citiV3UFRDkf6Ni08nx/wOCFXsEZnYfWNEym/HcZzaqaqYoPI7eiWwUC?=
 =?us-ascii?Q?cY7pR9YGWbIZBWe+/ifM/DbMOrazIG19Le47VeKmUErBBTXUYtV85en3D35G?=
 =?us-ascii?Q?y0ui7N4KIL2TMuZv34tev8r23U07GHaoFPwBsY+JcWbmcZKlDlxCAZEsel8I?=
 =?us-ascii?Q?s/WVknYgrZgnEz+hCddrqPMuzEpKAaey488mdzHUyX1Eb+6MkGttWLy3vgEb?=
 =?us-ascii?Q?S7CDX1fULjBXoHZLPmSLNyspepqDzMt0ds9E5+E3rFCqdMrZ+SBkCzeXaNGs?=
 =?us-ascii?Q?yq6Invq4/vWzrT1+JmjofyjunkVWe08Nr/fxvNGfuFcbj6V5Htu+2y2plh53?=
 =?us-ascii?Q?VRhbUEHPU6k5IVxyRrfWrSGdNUT4ve9YX9aK56Lz6L6cIo3eM+5/V+WH4x/c?=
 =?us-ascii?Q?r9K41PLPOiszR6my/WS32/xxWMKpdZzKMotN3bOSKMlN6+kG9zUkvHKiERD8?=
 =?us-ascii?Q?aDkIRKJiuKlC9PAj3ZGqe3j1wlkwal8yMl9Sammy2QpY+RSGkLW/LXNvAQEC?=
 =?us-ascii?Q?uX00PJ9+Rh5xCMiGrdLgnOWUMjL/kzQJNYHdYpnS9TLYET+f/Vxm0rNf/HWB?=
 =?us-ascii?Q?ujbmWMXWE2KavgYqa8pg9pYAs7Ze0RTPwNGDKdIgE336S+6zP865Ll3b5pAc?=
 =?us-ascii?Q?3lSbyJdhO4IHzeLGV8VXjRxqBSLKoBoBAgxtuAOX8ImMSjxjNNsliU13DCo/?=
 =?us-ascii?Q?/lN9AYLe0A=3D=3D?=
X-Exchange-RoutingPolicyChecked: iwC4Sb4l6SMCRj20500IemUYgPNEqLz5ydH/bBh0YmSKOno7h7uqthDLdyKt5T9dq6W/XriRCwBfmuN6jm6pLMhDDSZQl1QtDzCvGDJfiK/KauiS87mCOpAEmzVV85dqvIswBf2zeNqAvGVcGTmHK80UAhzxD5+r6Z72I5hXlqZFdN+6DIF3jqf4R29JhkhSxzGuXFBLksvwG+g+iUlEpwYCIfP1VRuG52OoF0dBoQyU5qhew2xpznT6WKMzW8N61KfE4MjHOk2VYCzO2hR2E9CWC8J5fU1YV3C7hcEVrVvXDqyDwp5IQZbfR3S6zvZlQqiuB1F6dRDeOefMpFCTSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: dc49cd32-2dbc-419e-738f-08dee16faefd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:18:12.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCs1zl/ndXWBh6FLlnREvjv7qr9zIT7adFxzzg4+/C16ARttKoWr0Y8crcRaSLcF5vgF6+1g/vMysnq3z13GOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com

On Fri, Jul 10, 2026 at 11:32:55AM +0800, Binbin Wu wrote:
> On 6/12/2026 7:08 PM, Peter Fang wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > The TDX attestation driver currently uses a fixed 128 KB Quote buffer
> > shared with the host VMM. This may be too small for Quotes using schemes
> > such as post-quantum cryptography (PQC), where certificate chains can
> > increase the Quote size to several megabytes.
> 
> Nit:
> I think the description here should be more accurate.
> "Several megabytes" colloquially implies sizes that could easily exceed 4 MB.
> And it's a slight contradiction VS the 4MB limitation below.

Good point. I'll make this clearer.

> 
> > 
> > Allocate the Quote buffer based on the size reported by the TDX module
> > instead of always reserving a fixed-size buffer. This avoids wasting
> > memory on platforms that do not require larger Quotes. Older platforms
> > fall back to the default 128 KB buffer.
> > 
> > Because the Quote buffer must be physically contiguous, its size is
> > bound by the buddy allocator's maximum page order (4 MB), which should
> > be sufficient for current attestation needs.
> > 
> > struct tdx_quote_buf has a trailing flexible array, so use offsetof()
> > instead of sizeof() to calculate the header size.
> > 
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Assisted-by: Claude:claude-opus-4-7
> > Assisted-by: GitHub Copilot:gpt-5.4
> 
> Same issue as pointed by Kiryl in the first patch.

There have been discussions about this recently [1]. I think perhaps I
should drop the "Assisted-by" tags since I did not use AI to write the
actual code.

[1] https://lore.kernel.org/linux-coco/akxHbKbMyF7PZ0Av@google.com/

> 
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> 
> Also the use of struct_size_t() instead of offsetof().

Yep.

> 
> Otherwise looks okay to me:
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Thanks for the review Binbin!
