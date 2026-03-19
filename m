Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8339DBF0;
	Thu, 19 Mar 2026 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904488; cv=fail; b=S8WILfKvwmZLplzdz4eDO6hOkSg+v1H6hsunBdRTI/9DWNjT1jFy41lDrtM/PJswjyErClQALo9kprXr0ue0jR/bCT5I0DA1KcWMRljnGkN5j1BuL2zJ+m1uy+VOX5S4h1Lae83NbXld5MmEci7C81ijZ4542pnwYnb4ugwWZb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904488; c=relaxed/simple;
	bh=bLZGmDfj+Zj42rDBWfThz+r/0Q8mTMSQ8X+7XVN1sMc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JB3mZgGCrvqVTugzjof3K/YjSfSjg+jS0tDoYUDLjLhTxJx5isbMac3zf/ZVeq9lfDkzNcq7tFo92ew3dSTTMsZtSrzU0X3O1grKkH8bpe0gySjhRyZfhTZMGENEIiwD/uMryET47mz991ECznZvJqoemmB4QbilN2qDX7dxQcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=At2XB05E; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="At2XB05E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773904488; x=1805440488;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bLZGmDfj+Zj42rDBWfThz+r/0Q8mTMSQ8X+7XVN1sMc=;
  b=At2XB05E7YlukjzG0FatBOGSLyKyOepejcfaVl6LnKhm5cGLFlo71jz+
   K4xZfeZ5NC4GnlJqTBb3OV50dc4y2C5Tr1+iFzjY9r+wWuTtlN8PJFg6u
   IUSs52sV+IaAWD5TgcMCLjWe3xR2RtFzaEEZdLNL8NWAAXq8YV3YkiVbQ
   ZqXNig+ikDlV39b9H6bYKhVNui0BKNHwixG1TR6qVrQi0RzcGp2XddpOG
   XSH/yP4qlCwH45huTL/5xBsCqvMOTua0YF6prZ+FjHARjVOiln5a+Tbpi
   wD+JNXRzqPRwc2Txbq62sRA3KVuBvGf+BobIuc91SL/g8C4KSj3IKK+UI
   w==;
X-CSE-ConnectionGUID: qY+nisUQRKmX7GvI4/v+QA==
X-CSE-MsgGUID: Uh5ulFxyST6zT/aZunQX4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="92352621"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="92352621"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:14:47 -0700
X-CSE-ConnectionGUID: 370CuxMQSqWtIiRJmEUFaQ==
X-CSE-MsgGUID: jGPdhjHOQYGfPC4wBlZcKw==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:14:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 00:14:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 00:14:46 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 00:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrZBvG56DXYxIqk7js1hEmkXflwS3cXYg3XNmUodh6fefqQSJzNjzfzTPnkzXTRVxqEvq0WKWfoKIz/6vmvYYvXNbEKja17aNfooJz1DoqKhLjOCBL8zhUTAx0zybPoHGfuMlOorOGiUsEh4ziEXtJdTo4jfefK+F3Zsi5oNzqoAHLErihKcp+TTJG18QS63GN8WrhtbI7Fd21pyh+KAYQPY91npTdBfIxr/X1z3dDiDvkBuLwULlmkebm2xScFMzFFdKxnmDMCTS2DjdP0tre0tX0nQtXtNgOcn793pK81SP1Ic+53tkZMP76/s4y/OPSbQal7fcR2cVQtE87Wyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5k6X6bOULgJFnVqlza9Gn3hFgqjHObjDH8fTjmwmYE=;
 b=K5TXAsGHXc4dOCK1W/MdyWaYMrcTcZHtX1LXJbKDIRxvoQkHHSionxMeZGBAHiQRP53DXLh7thXmqRAegxZI8FEPobXZuZPEJwMO+A3vVhWBYa71p8/hrxFyMft9SPwlGzV34pLhKbvpT2fIb5k9g0rqVy+LpExpG5vWM2fN+6x5NP4Alq15NSL4r2G5I1O3x7JSzZuY/y0AYfx8XFMopLxtXpcpQDnW8JF6v8gytZ/SzkyjDoS1A3h1Hi1Gzc0GJ5G84+hDAaJDQTlqczD/Ijl/QlNW+yS9z3dc1f+okh/Zh1r6JgCzlJBtvsSUQ/PYm/WSLjEZKeWENlATMZQppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DSVPR11MB9767.namprd11.prod.outlook.com (2603:10b6:8:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:14:42 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 07:14:41 +0000
Date: Thu, 19 Mar 2026 15:14:29 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <kas@kernel.org>,
	<nik.borisov@suse.com>, <paulmck@kernel.org>, <pbonzini@redhat.com>,
	<reinette.chatre@intel.com>, <rick.p.edgecombe@intel.com>,
	<sagis@google.com>, <seanjc@google.com>, <tony.lindgren@linux.intel.com>,
	<vannapurve@google.com>, <vishal.l.verma@intel.com>,
	<yilun.xu@linux.intel.com>, Farrah Chen <farrah.chen@intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 04/22] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
Message-ID: <abuiVSWkO/9MEPA6@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-5-chao.gao@intel.com>
 <935081ba-9f66-4bdf-a408-c19be32c6ad3@intel.com>
 <abpxvVk9XrEU6ssJ@intel.com>
 <8c319f32-b088-4594-a1b6-d6a755074a1b@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c319f32-b088-4594-a1b6-d6a755074a1b@intel.com>
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DSVPR11MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d52175-e279-4548-fb6d-08de858730b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: MWKUUrOlmEDYzxxgwdcJKTUD6buRaaTIb14n2Tco+FJ4zhKbWY9rSBhl1pdaZ0i1PXXyeVLsN5zw8w/sqiHrQ0wZQjXNwPXuJcUeExOjTxw1K9cPrLhowJcU9Cs6FgWIvaN95OFhxaZdUrENOe0lhGymYatohD3mCX7sAlK3UW7Dea1VTd32vOAIpXpA8pw2tpwHxMRdJKgG1vYtjwW5wWokBrYnsg62XOuNsn7jEqcKnmbG4aKnXGGdoJTYR9fymbUu/JqEd8vv9t7idxYiruCZW33z0arJ8zvSdItnnQHqADNS/9f40MI/ABPSqgGYd32eI6YvZ3y1JowpdjF0TEyjgXsMerVqER9gRWINWACcC2K7Igv4Dvcy8q6yJADt/msePQNZnbX94WdJMeosapkUV4Mh/1EzH1kWKW3IcLn1HSFwB/Uq+xiGuZMd9smDtadHfneFi7uR0acQpqJUSZ1G2T78ohVUxJK+EhK79W4nxX/TopiWMq6bQ0k4T2SmK1oyDFe6LzV0DTi2joyg0NAeMUsLCmEkiils4J2/iX9HNNxmBu7tJVVq8O0fgo06M9DzSsmYOct2PzS3rifjMqQ3vxoz3HK9U/nh0PhqprXweGHyrDorILiFvw9LbH9xT+xgyVVIRRvU8Bf7HamaxNRhReT1Zw+j50jH6LmX+SlWLkbHbWA0QVO4rs64+OugmL/DLtfiqW5OlR4qiEQe1JdfTwy+CNEgmiMGaDS4ylv4u4RIZtIHZ5jAf8JPsHrO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TU1vG/YEts1t5H1fhm7/TmUT620lTMjNQaur8KInzFbbR+lz+ofKbABLxx?=
 =?iso-8859-1?Q?eC3Od9oPCAb4npwomIPSMe+aG05bnz2VbigWlbK2W74aTth8mPOk7mv79r?=
 =?iso-8859-1?Q?MFR6JQZoDnXBzmfkOG0kuhJoWoh7CWryAWPW4F/4ti6OLX1dzJGR4vk/a+?=
 =?iso-8859-1?Q?KTLCJZYkNK9ANyBiPSiPn8n8bvniQmlrK+Uytwv5Mr7AVVCTgE7nRdv4lA?=
 =?iso-8859-1?Q?ZNBYE2LISwIFX35pWVhU2vjFbFtMmm5c6XdBCaxs0Fhr68nfk9XMD1D8bf?=
 =?iso-8859-1?Q?YTZoUZRzewiW+pZvOZdMhw6x7TSSCNgPhYg5fm9/lI+lvCF2bGIGhOyXMy?=
 =?iso-8859-1?Q?bNXyW80S7BGl3ZbtbZJ7tfQRA7N02DP4GdY1oUd/T/ey2jZikjpvk0KzZx?=
 =?iso-8859-1?Q?hTMFpJDkfzlrVEYjL/ec6fqyUU0uVTcLMTWHwZxAqLLQeqcynO1qlub6I/?=
 =?iso-8859-1?Q?HuuCTCW1iGlqc9VewEZ+rjRDuXVb9wHRfOBQ90WXdAT+L7BvxU5J0MUHO4?=
 =?iso-8859-1?Q?8bZpBsUFqnn6cdlZOnuEuJYEw/M180lSd+B3TRuOj6FfKUFYWqfceFFZ9D?=
 =?iso-8859-1?Q?/anPJ57jD3eA69TQNrHV7pPAtG01ze/Ab7xheE90SNE5jyH7yjv2Glgwe9?=
 =?iso-8859-1?Q?uu3oRy+lfnvK3SIraXlyXPEQ2QSGKmz/fTyijscgU4Qj//chxc9Ui6nWdp?=
 =?iso-8859-1?Q?mRO76Ypc130URQvaAUhO006C71cV7XNa+sUyVusm0KDdKxsKK05h5jpDXr?=
 =?iso-8859-1?Q?Lo1etSY+XJJZfB1shhYKzZPhWPowTtLALxsvP0rgJrLRikVEdyWY0NaRgt?=
 =?iso-8859-1?Q?Z/4T+RY32ibPwRQxUlZ3zUjeOuuWOP0h23oKl5xcETT8mh1oNcoXTFNW2E?=
 =?iso-8859-1?Q?KVsKgsR5yDKep/ohy3oEzmbm+HZKDgWN1RdJmDoXlpvbNsW27CyDfT4yh/?=
 =?iso-8859-1?Q?jpLeLCiGv3L+rtKnU1AmkS42UnBAXWz8aV7tFj7y8QCQUGnLEIg6IcH7lh?=
 =?iso-8859-1?Q?snq6dTkd7dTi3gBm3EIVGTxBGLljAJH3S6sfonkJIDnBKBxjCHvpU7+3Ds?=
 =?iso-8859-1?Q?EL8VdE54FJ+MD8WEDZHP6jL5A1t8mRJudRNfBVF2gLcOL6Uahs4A0x9xMK?=
 =?iso-8859-1?Q?L0f/w3JTB/7vJkCzSk5HifF/sojK5ro2vNYmipKoHnbAKWS4oN5ragKnqx?=
 =?iso-8859-1?Q?Sq0bx3OXRskRWilbdk1+YNOC/9H6gZ4qHsM27dU9864DAJ+MbsEtMDQKmY?=
 =?iso-8859-1?Q?HSWgnDX+DxOEE3UaD476r28E7HK6OSxvi9+/dvjIVKtxdKRogGMjGuJMiU?=
 =?iso-8859-1?Q?G9Iw7T7H10qBVfw7rvKsVihyWOSOep/gcvNTUxPFU/cvKHDSyIDXJDDAs5?=
 =?iso-8859-1?Q?5egeSt0058vhSoCp7LFgqIxeHPxN0lk4mnBy5ETGv7fiCg5NTixeo0j6gm?=
 =?iso-8859-1?Q?6RYb9w59MvcKwhEzSbPll3mceKIAKewGsf0871sAdQNyhUDL49/Y1Bi4GC?=
 =?iso-8859-1?Q?26kIUdbrW/4Vxs49wTaofUoCbYaBRXEgdroD3Vd0wQHpdXg8HDuJAJfWHX?=
 =?iso-8859-1?Q?Lb9HnwuAPGmVQ5tZ6zUFx3uFCPM2Ydnq2PZB05jPSl56D58hyb7Hq/ytEU?=
 =?iso-8859-1?Q?I/Lr0cVJusYEOlvtSHhoke1Prgcra79v7T7rIKH2RPTZO8EL+DwvUYh6vN?=
 =?iso-8859-1?Q?yjVD/4UTJsB7VlOU9E6Nc5RFsWE9SUCh+AbkmU8QlIAOt540/E0BZo9HME?=
 =?iso-8859-1?Q?2/fbNjaLVOLevKtNvum5uJWR88+pIdMyNiNz0N2pEHMgT/7FtKSvai3+9A?=
 =?iso-8859-1?Q?PZyD0QxRZw=3D=3D?=
X-Exchange-RoutingPolicyChecked: JIx53kUAEpM+sFLRi6skkPcvSd0GiA+zLYyQIr7WeNeupidfXgrBYtpfLBZYORypJehFVcKVKiXr7Z+l9SYSvNk3L8RdZ3HHwz4tdy9KtHrKxo9MZhknRWgN+fLy6zNg6ohQ4yNamzLttCHmekdAqYQyolOgYnaJwq4Ysu60ifZQLGt5aOijeWT3+ttJRJykkZuFAROdzHn2n3f5EokELh2qciI5vELAq8mck2clNzNaHWRnE2yA4dt3ycWHIqXkQHx9fEsW4a8QTNd2+JJcZPDkGyvNajvMqX94ZZzCbtw9QL/i51oI5+HcNBd2QH1ouYkuNUsP/YoZGyeOHK7AtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d52175-e279-4548-fb6d-08de858730b1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:14:41.8931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DP3zxNtROHVm/4mIbbW0Pj3aATLU8nR8GTHvZ5E4Ywv44svvE0Y6rtfki8DV0nq0gtR3CJtdpNhgCSIbxuNw8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9767
X-OriginatorOrg: intel.com

>> I didn't realize that. Thanks for the information.
>> 
>> But I don't think this is a stale reference. The SDM description is high-level
>> and points to the same spec for details:
>> 
>>    The details of such transitions are specified in the Intel® Trust Domain CPU
>>    Architectural Extensions.
>
>The old "Intel® Trust Domain CPU Architectural Extensions" spec has bugs.
>Remember
>https://lore.kernel.org/all/20251014231042.1399849-1-seanjc@google.com/ ?
>They have been corrected in SDM.
>
>I'm not trying to say it's a stale reference. I just think directing people
>to an old doc (especially with an exact revision number) can make them get
>outdated and incorrect information.

Ok. Let me drop the whole paragraph.
