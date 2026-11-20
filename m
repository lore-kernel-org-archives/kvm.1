Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795143510;
	b=1UeLr99iqqsGlEwO1ebKAspPPgQZrw/UjkZgNgW22sg28V03oxgetk0g+QHlsaiGaU2Y
	 I2RuKahdUy70mIjNLoyQwp+8zlVyyPrMzZtdffSAA7pzE03z0JOfNjyrsrJqqX2ZjG7Md
	 U2OHPINpAVDBWLa4CS+0IZkdNy8bziMLhNKcIJM6MzhIBAxMmkwgCHGGkPkPCsADj4z3F
	 0ISeoFyTsmHN+dnDI4Tm+qIxbTpraCgo89ic//NAYRAHKD2mEq183jep2oSPctrkbsa2S
	 8qb+/ym+5wyTcZGXfaLO9yv6NTH6z47aFCCiLEQOhqlgGC+04JmRyi3E0VJr3vJ+wvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143510;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=fvSaiXmH6immr/fWxsfs/P4Ufd7RAnhs6HfBch3IG00=;
	b=LBFzgHzWyqCQf/PKc7OVpcPFIY5afybWehAMfooROVyk0FxOtLnnUTeT92hxyEIEdPrQ
	 UUv4+sNrtNlTwd69oPdzTt/21SVe6bdSOuaZUrkR/60rUiIy4KJ37/km4kg/QiQ0Qbr64
	 gI53bErVO5o1rKppzOiiCnHEPTSL8A16QZi8q91Eyc1T+VGhmiIRHm6ektbKmWdfTGz7C
	 Vqjs4TmtqTA5G2dhaChHqf3MWN4v9Yj/ENgSGP6jpHcc9iCG/V1Ey6JqMEFXM6mJl5zjZ
	 Wy0vHt5qosVP1/HRwmFOhqQ0cpkRrajwzggGgk1ugYK+WZICBOWZGrv3QJ5hhDjOuaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="TGoBEoa/";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=E3VsM8ms;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCC7606A33C;
	Fri, 20 Nov 2026 02:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CCC7606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TGoBEoa/;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=E3VsM8ms
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795143504; x=1826679504;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n4/ObFILEcHbGOZH/IYZy8AgT6RXWFCcz7x6bXATPpY=;
  b=TGoBEoa/fSblxwqVf8o9KtwS0eTRjgG2mZExrIEjKy3misLm7eztlsAQ
   GUD5ix+fTs11jS4ComMzbLLT1ZKCEPbgcbg9C7FU+0xZ9TbgsprN/MmMu
   9MVCetBSLutTW0EXf/2aWNN86jKIqc6FtFjFTpfscVj5Eg3S/XUDoWmhq
   fK8W/AtS8U7ww5U7t7d2RmhhNHwbOAkEXFVmVEqTrKNymAvd9Py73Fprk
   AvPcID9jg0BN68OMYPyvMW4BbElfC+mmrqMYKnyWdb6ernUvxMMUuhBho
   nEJ4dqRSPjWiWuZfR6yW0m1G3Nt7QtpYSjuRp3jrDHf7LoAA7/0qS5JQG
   Q==;
X-CSE-ConnectionGUID: KUuCzI8zQISfh60E349J8w==
X-CSE-MsgGUID: Kp187hkzQnqMgSOmoePi9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3863272"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3863272"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 18:58:23 -0800
X-CSE-ConnectionGUID: 9Uu781EpTpKjLCbqj4562Q==
X-CSE-MsgGUID: JLCTZ8mOSq2DVHKR0mx4cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10878596"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 18:58:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 18:58:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 18:58:22 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 18:58:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tS/jHOlb2u2PQ7UDDKph9Be8vIJmwGeCYCTU4m+IuZW0Je+CUUVVz/7i73dYgK/6JgCPtXXndZlZw/Yp98XGBfnA1Ltd24VWI2EO6eTBGxA38Nd5A21NPQvlaxMt9VHL8Sx0fOo1DL33kkfSuCKinIVpjv6yLSioym+lOJ7JzVYbrSiWnK3HoeP6ML0DD17T+PBUXW5RcdWqq142RQ0i+CxN59voHZgsdL1etLFB4B3DWBx5uKrMAhtCOAWRql+teYdcxXROZwa9PJbqEQAVOMFPMLZl2wYcn2XZs2OsZWF5qV1c19ZBbgalU5LdzZEQVLo+7AhY67b5POyaBDpXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvSaiXmH6immr/fWxsfs/P4Ufd7RAnhs6HfBch3IG00=;
 b=HXywBWLbKqgDM9cDczFM0lix+dyZIUOZtWDNOmVoud+oyFI0Wye1p9ppoShYzj31dXjEv7Nc0l9Jt/izRHbkmo2iFQDHil/hPtfnJcb5XhmFgg/L3MOceDd+1tOgQ/iG07XkpNB/aMYaBIBIHAwEzNXSYX0Z7zZznzU0W8Rucl23J1LacdYjWJi0Tv5XmDS1bfl6mI5jXXGEiU6nbaQoq6FMaO7yi6rK6x5nsbGkSYs/mMKUtF6cq+WAGSBNWeK+49/Qthjw7RD4OQCvJ3BMs+LUn8IL5D3bUnd/UDHvh+K6El4FSXNGp9da1e+wIeoIKASTAZ16npfO1WWvU39NHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvSaiXmH6immr/fWxsfs/P4Ufd7RAnhs6HfBch3IG00=;
 b=E3VsM8msDXg2kxbtcBof9AQdEHgzJiVlS49PC6eTK6LLnCd9lZDi5pI2MdD/8j1VuLbp7DElEe8UKvObYm4jcix7ezjN/QSGEpy2IB4Cj+vwhvAwnztPSnujeDzQhSB/I9kNWEm3D5M2Neb1+ZBXBZ26vm2BTHVGtQUQjcaLf2g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by IA1PR11MB7271.namprd11.prod.outlook.com (2603:10b6:208:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 02:58:14 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0615.009; Fri, 20 Nov 2026
 02:58:14 +0000
Date: Fri, 20 Nov 2026 10:58:01 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <yilun.xu@intel.com>, <arjan.van.de.ven@intel.com>,
	<binbin.wu@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v3 1/2] x86/virt/seamldr: Support large TDX module
 binaries
Message-ID: <av-3OatHEGZXmWr0@intel.com>
References: <20261119074925.3933804-1-chao.gao@intel.com>
 <20261119074925.3933804-2-chao.gao@intel.com>
 <bed831ec-b4e8-4762-83e1-f4a72075fa9a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed831ec-b4e8-4762-83e1-f4a72075fa9a@intel.com>
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|IA1PR11MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e02a118-a296-4e95-f31d-08df46b21e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|261022075727099003|261102123227099003|261022115727099003|261022105027099003|4143699003|56012099006|261026121527099003|11063799006|5023799004|261026140227099003|261028144727099003|10067099003|261022113327099003|261021121427099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FSQAtBb202NEKZmnvDoKBMQuA+fzD6X7/aaO4Ib2qm4MAk/NA4iJI4FuE9Am9lLqTJNfv8w+NrjgCPNWqAgi/F8ffPcUHx/epGzK5Yz7pZA87+qxHj8ZQEh2qYBfV4+dAd0RxyJO0g45N1bEhY/0p4sK0g5wgLQ11omPRd4G23AydrqcMbTvteSnw7hYkeeAOFPTcFEsfNAOKqtJDMucgZhr7rsvRe/hGIfARQouJt6v2vIY6N3zEdHDgCoHphKYd4CRcrOYvb1RCARPfxnC+ZcBXJOCSHGRILqHxLI32hldjH5E/3XlJn7o3/oPh1PcT0MpHQE3YEQIEQhGQ3e56IjJzdPL5jWP08ZiGM4B1bFhE2tnhHwjEW4NoKXFWCOL+MRiZFi5y+YoXfifJZfmnntsd7kGZ5pWviDBEDQ2lMlngI2j9U8T1puKCfFZOLw3nUmeJXaetd31/IPjyO0YEfeEnrEyMf9T5Frwheg5CfpRB4Ogs/0d0MKCenIgIk1mGw5e+Sw4NHBdI+xmN/PS6H8nP+6dx5z04c05BITUwEtzmf8MZVVl/Xk9M9Qhrw6EIqr4FMxKGVVKG8OqoUG20UI5U64nY2UAhirEjV8KHm9aWeTZqRdvGMHu84BZorO1S4R14qRtJQ3URMv/RoB8u2Peeo4GaKc6f1wNfTxe2Uk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261022075727099003)(261102123227099003)(261022115727099003)(261022105027099003)(4143699003)(56012099006)(261026121527099003)(11063799006)(5023799004)(261026140227099003)(261028144727099003)(10067099003)(261022113327099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YTDpz4LcOWU0DHOIcdPuAwMFY9fJzkELlaD9IYLh2qYwsGxxrjSNN1Nqtb7i?=
 =?us-ascii?Q?2mi9aV7uW08FK4LEtqmWbc3uKHWbiLyxXiPiqZW6W4fuQ9eVqqsCKBvlk5AK?=
 =?us-ascii?Q?F+U/owBYYX3ushPBE2zKcDjglPA0UNgdVGbkwMQCX+gi5bEayRlfRYpX1iuc?=
 =?us-ascii?Q?8cj9iHL/HJ9PLDleD7X6bFm+D0vqB+IBze86S1eRPnUPUtFIqJUrIYM8OkEi?=
 =?us-ascii?Q?lqPtJVfF1EjQvsx3OuRjTjIF2aUqgiRrJRacSU+XQUZ9KKZrCHFbmFRo3uQJ?=
 =?us-ascii?Q?SlwIyJi0UusBW87LOLLe9HYE3f3FELxW8lrOTI0hZcLexCdxHgGfDJLuS/gy?=
 =?us-ascii?Q?KbdcgrP2sXhlaXv14NmZJH2+F4cpxSVaNU4WxGiVOi+eBn2t67CwlubouHRa?=
 =?us-ascii?Q?1fj5y1YCy7x4NuSjMAquXaXK2CP4G4JUS2F3WOFC50CYlKsCt9sGWnJjzIf0?=
 =?us-ascii?Q?RKFYqPy5Sagv893BS3vlCKDOuNEjqLG9T0CMVcf+9aCEDvJzMDrxqYO1QlY2?=
 =?us-ascii?Q?VpdIBXdugHvhw3HSJ/rxqPRLZiOAQF66IOD1w6U/eFLGidyZ79Rh4Z869w2r?=
 =?us-ascii?Q?tPKcXlm1K4seCBIpNe0uzhgtRMHV+//rtzbczUeObvWipSUlKpZ2ZTjB4b0Q?=
 =?us-ascii?Q?qg4cOsWx84wPbY7I8cf/gV/LJZXNI6yZq38vJe8CMfWNfHJ4lWSpJuuBqEzb?=
 =?us-ascii?Q?/E076dgu1OUw5x5VJ13ap89Q2SmCRvKDIuvKIAO6WPklO5xdG2Xzb/HG9V36?=
 =?us-ascii?Q?J28u+Wme4xM98p3mR+aXhyKRvjpfk81XWv0w0iiiykQenpo2RVJ/GF7Dk76K?=
 =?us-ascii?Q?P2hUxeVKVhS7CdOlaZcB1JC01g+w8yGWqTIKWa/TZdzmPAlyA4Z2njaKkP3x?=
 =?us-ascii?Q?2nZq/9h0lwo+jwcLadoYaOBA8tF7F2Gg+MwVRL7+6cY4DsFy2l1vEO35zL+W?=
 =?us-ascii?Q?3mPuKCySvi/BkIhont8+z6nxucII8zvkuMfv9QZFpBHa52zVF9YlQfj6D3Iz?=
 =?us-ascii?Q?UVyJpwM7+4YDlotWEohRA4xSB/5cx7y6dsLomawwiIYvBLqMrp/wm8MqrzAf?=
 =?us-ascii?Q?gHpAQ6F6AFsx7jfrmUQn7WeVPLvUtyMpVC2JqPMsHNxiKAu3d53kyIggLA0E?=
 =?us-ascii?Q?j8uzCaaVLMlN0PdLs4GxBqk/HIdlIzEuGmabsPdUDyzAcy0ZM0leDGsT785w?=
 =?us-ascii?Q?dIjHZvSwxJe7jfZa/2lb5GhaYEUBEC88ARRo3uItxe6pxCg/6fUDiQdjL0TL?=
 =?us-ascii?Q?94U/GMgSzNeU6vXoH5TncwgkyZ/eV6DK5bz7FI/3wY2Rmxi4qmXUcAROjGo2?=
 =?us-ascii?Q?l4AZSqtKJ8bDgzDjA8bjZnzsjPbsUJppYxJlYu4t67fSU8DyZAD8GTQIVyhk?=
 =?us-ascii?Q?0dyhRAOtVnUEWQsg0Xdn4TOmRhAK8H8ESlxt5RcA+W4UHyB/m3LTMiYSEM3s?=
 =?us-ascii?Q?hQUVe7siOZembxR3/rAP6mMhkhYYPDcHHrdklY/jr8xylQvJ5xVB7NwPFLfK?=
 =?us-ascii?Q?RvsZxEVgxozNJ80SMhdkxlQpnGgrdMYAb0SnFxXZs0v5LEmzwjpWm+C6zmlf?=
 =?us-ascii?Q?RocEkdfaZXllItmiNOXijhSG5I0EE+sDZBJcGlzprHI1wVhBa4Fw0cXVym1f?=
 =?us-ascii?Q?FsID/zzPhaM2+Teb3LYWQR+uCY2xyQ2Yk0rPliWiAcOabIdWWGtxnhFp0C4g?=
 =?us-ascii?Q?UAeMMcpIskXVzdg6Dm95J7GqjYByVtNmCfOT7ZfMhTLx9RBJHFkwHDaovHeK?=
 =?us-ascii?Q?bPBkZGdtRA=3D=3D?=
X-Exchange-RoutingPolicyChecked: C0X9hKb0Gs1lzO3cQb4+vExkbyzdU6sdEY67Hbyh4+OMDhwz9/DJPSvO59ylBzBK5Nl77HHPqDjHjXssdziuxz7s5oJKaZBOySX9xOizy8YJpqmKoyoX397qss22mdTUC5qsHbF2oAhHRTZUKrYD9Wr5wZCylxYsPHdaw0P6QlidhfxVN9GZCa54OYrwh9v8N+OpsXY0c6CKf7Vp3uGHbYBpDaao5CvKG9fIO8rwffgcu6KG7c5QxJEtwtB/HL8GzJKx+vY49jWI9SDspCqqr3W9sboX8v/K5As7saH3DcGoK6SWcwZa42luzG05BJsGGdavQpmxwBWCcXJ4tT7LWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e02a118-a296-4e95-f31d-08df46b21e4d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 02:58:14.1350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xoRYSQciwhcINfxdnHTuNova9RtZaETw4IVZEy4I727f/n+kiAZiKYzf/G9LQ+RnE5ze9aPQjQY36Y8ZpWerg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7271
X-OriginatorOrg: intel.com

>On 11/18/26 23:49, Chao Gao wrote:
>> TDX module binaries are limited to just under 2MB. The binary is handed
>> to P-SEAMLDR as a list of page physical addresses in
>> 'struct seamldr_params', and the list must fit in a single 4KB page
>> along with a few other fields.
>> 
>> TDX modules are gaining features and are about to outgrow that limit.
>> 
>> The P-SEAMLDR ABI was extended to let the list continue onto more 4KB
>> pages. The last u64 of each page holds the physical address of the next
>> page, chaining the pages together.
>> 
>> Grow module_pages_pa_list[] so that 'struct seamldr_params' spans 16
>> pages, and chain the pages together in populate_pa_list().
>> 
>> Each page uses its last entry for chaining, so the maximum module page
>> count is the array size minus one entry per page. The user-supplied
>> image is checked against this count.
>> 
>> The 16-page size is somewhat arbitrary. It fits modules of up to about
>> 32MB, far above the roughly 2MB of current modules. It wastes 60KB for
>> today's modules, which is fine because the memory is freed right after
>> the update.
>> 
>> Do not query P-SEAMLDR for chaining support. Userspace selects the
>> update image and is responsible for ensuring the module is compatible
>> with P-SEAMLDR.
>> 
>> A 496-page module (the old maximum) used to fit in a single page. Now
>> the last entry of that page is used for chaining, so the final address
>> moves to a second page and the module requires chaining support. Do not
>> special-case this size to make it work with a P-SEAMLDR without
>> chaining support. No released module has exactly 496 pages, so nothing
>> breaks. Leave it to userspace to ensure any future 496-page module is
>> paired with a P-SEAMLDR that supports chaining, as with larger modules.
>
>This seems to be getting worse, not better.
>
>Maybe I'm being dense, but I *still* don't have a clear picture in my
>head of what the before and after data structures look like.

I tried to describe the ABI structure briefly in words, but that was not
clear enough. Here are the before and after data structures.

    Before (one 4KB page):            After (chained 4KB pages):

    +-------- 4KB ---------+      +-------- 4KB ---------+
    | version              |      | version              |
    | other fields         |      | other fields         |
    | module_nr_pages      |      | module_nr_pages      |
    | (128 bytes in total) |      | (128 bytes in total) |
    |......................|      |......................|
    | module page 0 PA     |      | module page 0 PA     |
    | ...                  |      | ...                  |
    | module page 494 PA   |      | module page 494 PA   |
    | module page 495 PA   |      | next page PA         |--+
    +----------------------+      +----------------------+  |
                                                            |
                                  +-------- 4KB ---------+<-+
                                  | 511 module page PAs  |
                                  | next page PA         |--+
                                  +----------------------+  |
                                                            |
                                  +-------- 4KB ---------+<-+
                                  | 511 module page PAs  |
                                  | next page PA         |--> ...
                                  +----------------------+

I will add this diagram to the end of the changelog, in a background
section.

>
>> +#define SEAMLDR_NR_MODULE_PA_ENTRIES	((SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE - 128) / sizeof(u64))
>
>The "128" is a hard-coded struct offset. To me, that's a big
>anti-pattern. Use the structs themselves.
>
>I'd suggest a way to do it if I had a clear picture of the data
>structures in my head, which I don't at this point.

I tried offsetof() first, but module_pages_pa_list[] cannot be sized
from its own offset. The struct is still incomplete at that point, so
the compiler rejects it.

We can group the first 128 bytes into their own structure and size the
list from it:

	#define SEAMLDR_NR_MODULE_PA_ENTRIES \
		((SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE - \
		  sizeof(struct seamldr_params_fixed)) / sizeof(u64))

	struct seamldr_params {
		struct_group_tagged(seamldr_params_fixed, __fixed,
			u32	version;
			u32	scenario;
			u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
			u8	reserved[104];
			u64	module_nr_pages;
		);
		u64	module_pages_pa_list[SEAMLDR_NR_MODULE_PA_ENTRIES];
	} __packed;

Note: struct_group_tagged() keeps the code that refers to those fields
unchanged.

I considered this but decided against it to keep the diff minimal. I will do
this in the next version unless you have something else in mind.
