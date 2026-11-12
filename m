Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794458261;
	b=zicDfshvhWQwpH55KxTe2sqOL7wfFE09kzukPGDr/N54b8OsOdD3MxsEwwz1oLCwVySr
	 FV2jxJqzeUhs75C74rWnccHDpAzhd0VxdZriTL7FNgfizRDF6V9DCv57Gq5E9vogLSrJ/
	 BHOj3ZnfOK7qSy6GXBTvXpBNW5jXUjkb/Es/OzVnbhTKKr3mDo9P6/3Q3b3ZRrE3CIJdz
	 r07SlAlWzy/eosy7oav1Fic+ACe0d/4oqgNpBgviCoTwMchV2YDEQLYAsGh9z50pgXfHD
	 8jNuxeFckfhhH5HkvIIgNaa7UaOfCqZOHE9/vSK5Q42FVyZ+mvscSbK6iLvNg4TvpcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458261;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=nl+A8ZjbEaZ99S4ND/LJoh3I4rcj+ttftE0Dv+hZ0Lg=;
	b=AnOOSRc+CTm6NK1xuwNJ4qjQvGcnzuy6espx5bsqdZ4JiY1hzm3SJcxDdkSZjVmVMTVO
	 r6isuW1KJunJlOaNHjlWuOgJ33fRXvH6bGT7tKiOFkrJHlW6n0dQJMYrooex7NALVO6qA
	 n1y7bp9gqNershI8bpJAXfVDhMG6MFFY1UCYts83WwKIJpuZtRWzPK2wSyStAR5NrCAQ4
	 Omw1qYSU1KF68PkFLskTYEUkyKkSn8OP/Z9D6Fh/mF0F/YWw6VkaHK0gocPp9JQZmY4+D
	 y+V40cxwzTmRBDjcwafrCVVxhl8THu/hzb6elTJ8p2asoOFNjB8DLsR1rosSapA4MEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H0Xk3jla;
	arc=fail smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C963606A323;
	Thu, 12 Nov 2026 04:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C963606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H0Xk3jla
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794458260; x=1825994260;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rOA7Pmj6Ay6K0SxeWTn6wSrGf1jg+AR7kzUGgqt0kjE=;
  b=H0Xk3jlaPTFEL+dE63rSdO5vg6c/dNmExQ/JJEbWX/j2FnW93OaTzPaF
   AxCO9QosSPa+lyiFcr+s+gOtYCJjrqbQdGGHOlQ1ldm7qVjAm9JrCgfWI
   yxRbVG0jqOsJKkndU4FW9zQaR99zL2sOgsBBXxIDNYTTFWjuhPSUFRWHP
   roCWAVgtVhdgk/OleBtK04e1ZVeoGIygtZnxesTxK0jn9NH/HASvvl8e4
   1Z7iIolJbr97Xfdd2Xj7lEWcQp+pZIbAifAiUJj/LG/nrACBZ0cxPrHar
   98G80zY1qlD5iWxL2lD8tGAtZ8amG2mY2KoDd3sbnew18CR6VUwzJAHrt
   A==;
X-CSE-ConnectionGUID: TUOGj0sXRl+HZUYRi81OTw==
X-CSE-MsgGUID: 3a3ZeePjS4O/fcdLZQLfjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3253022"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3253022"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:37:39 -0800
X-CSE-ConnectionGUID: TxmmSOo9Sv2JtiCUbwK9Vw==
X-CSE-MsgGUID: vOyPJOU7RwO72Y8gsIyIGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8656005"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:37:39 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 20:37:38 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 20:37:37 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 20:37:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XySVv/E5ltQqLpN17TwG9E5M0iR6/bMW3JQqv+I77WS1E+JfxVLsqMhym/9jEu4KQXO7F8E7SxkYd3+/9llNSnixNT8VXF5MrPzdGq0ytAhw1ABMaNIzNdWOZVYJgQdrbI5G9VWBZVqijur1XKIuONfEcxalunVBAt+GlHHjobmOpxto9DFJTLGl6vjxtWgoEp7T2maHxa1J6UCFW7l1KSVs43+eJuLNAsj+7sMOi9xoCvbjK7s5fJLY3gYATwwnP9f47iTc5tMMluQokfhVoa2sfJWqZtepO+f3sOEMxjiYlfMrPjdkQXJvCAABgfeI1Z3QLiyn9is0iUw5JKGp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nl+A8ZjbEaZ99S4ND/LJoh3I4rcj+ttftE0Dv+hZ0Lg=;
 b=Jx7YlHAzuKBQlJZxqizny/JnSvVnKYBls1ijUtEOzDtPAUZYS1qPLgkXrFIl9eECOJETewFvdxpRcOA3gCA0xQFQNIMp+wJSCZ1aD7EwzkXcEnqoAgL2EoWchfptXjG/G9oSUk0qIrMoloStsk1czPeaTHrhrWvI6tL3R5lY/3cYiMrwcJsKZGyWs65im5Mi2VMGtW5EQ7S4Zhngvigt/VfAGVIUiAhDvEIf/MjkO33eYxHPQEUzPVHljiy94o4fVv/ZW1rlye4RY87DAXJe+mRPoEMlPqM1J6tBggGWYjnSlOj4QP4a8W/HK1FKrXKBF0BlW2sRAJWrcL6MpbSpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by IA1PR11MB6537.namprd11.prod.outlook.com (2603:10b6:208:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 04:37:20 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 04:37:20 +0000
Date: Thu, 12 Nov 2026 12:37:09 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <yilun.xu@intel.com>, <arjan.van.de.ven@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [RFC PATCH v2 2/2] x86/virt/seamldr: Support multiple sigstruct
 pages
Message-ID: <avVCddqEgJsmYHJp@intel.com>
References: <20261106132159.1551365-1-chao.gao@intel.com>
 <20261106132159.1551365-3-chao.gao@intel.com>
 <avSxHkwvLYVKrhCv@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <avSxHkwvLYVKrhCv@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|IA1PR11MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: e8af1dfd-d303-467a-cc91-08df4076a396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|261009223027099003|10067099003|261026140227099003|261028144727099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261102123227099003|4143699003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uFfCLJYJfCPWvyRIZohak3/+ibbKEx7sAiqq6n9vULTgus1Z0HBYvugOtgj6+xSqu3bOrujydLvHUw0dmvJV8K0UwYsLODT3aHujU8ESw2IL+4PCq74ODIgZbS37n/5Idz2rN0NCEJnWv1lGeNaJ2x2j7T2ycEqOdChJeTnMtgKrpKsQaPZK7y4G3NZ0d21NApVLZpgZPTVOOXoxKmz2jXZ9DdX53FE90ADPZjYMPXJgYnRBExW92kTtcxj3iWJpdq/jECIqKD+7auwxfI3aDHjGNsApRAO4N554CDg3S+P9I/CBeIN1UINwpFKYbXuCnpBkf5j91C2NtGheQEVT0UJsRH5v8k8FWGyQHicv6riAz1q7xv3908AE0XApfffSTQCXO15TJ3jUZEL01OjM59WzE/nvm6uYfukf0+gMov+3T3JCVtpmnQaFmspHrhKDI+jPTc99HkZ0SgBxFllKe1YQddkrTkVhrahf9LjRCOfZPfBNhMtrAvGPz8HaLdru0CU1cyRiY/oXzWMprE3Ir4Gw2f5UhpMfgyazaxyqrZCTV9Zvq3N+VSKysh+mDJDQDT9Sb4OjcWTemgy3Vk5EVw7YaOj9V/36LCHX5wgUjO+3jboLOgBvz8JIahBWPRWF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(261009223027099003)(10067099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261102123227099003)(4143699003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X6vCLF1UqJpGOfFWpZ5cbcaalhxVx8M+SKy9pl+szXXAJcZvCm657PmF/1X8?=
 =?us-ascii?Q?jtrwBoEffqGJsX09Pt1UN3mJPrMgT4UauP98NzVm+rOVb1DzxnCvGQVlYqGX?=
 =?us-ascii?Q?Ia9Ac8zEi3FwsAN9SLg/h1pD5xw4gU8kVGP+4y0NRpCDBDXesAyw2VgMPBAC?=
 =?us-ascii?Q?gp8bBTLD2HI3k43PQR9LEp07rkb9J3fkVSyduFbMxsXCpF1m+PYm+Kg0P6Y6?=
 =?us-ascii?Q?qmCHIBVeZkSKP/wmiEkOMP0z5Cg19X66t2N2zOfoHHUTfndhOJe6i9UazICV?=
 =?us-ascii?Q?SfFho6Q57ey3ILYWPGm8FhGptEajBQ7PLpZPtC1eq1MPgRttrffLJtbc5FGn?=
 =?us-ascii?Q?gFV+r+AquJyR3QU+9555qCOdBCTSKdDZNDLP460EagDBkp3djpgitH8yUeuK?=
 =?us-ascii?Q?0OdfhJTWgPrV0Qf9nuqgXNUQrWxrhEZNSUvnnFSUtuEaRrDL4914NvwAL0rq?=
 =?us-ascii?Q?6xLS5uM/GPzgOC5T/bT1I+gbUomI0zSqwEze/zVs0jCWuefs7+iG9Aj7bKye?=
 =?us-ascii?Q?rPiSmyhWFNA8JXXhD3J9b1/FOp8IoG/hzg9JGK57XhohrSn98h5BSBRjnI9H?=
 =?us-ascii?Q?TeK+9SA0kgGHXiCcBibmEZK4Lj5Zae5rwgYm/ICYsn9jDkIdXeKZ43/Np5iz?=
 =?us-ascii?Q?9UFFvz+raDD7MqsgWtnhCjVYERefDfV4uWTGPzXS1EAaeGJQrNsmDrfVg2oT?=
 =?us-ascii?Q?L7IHn8mWsHh6Hid0IiCSMSQ8rJbAhMOaEPwfOwmGyBEW3aCMXuZm0U6yXg5H?=
 =?us-ascii?Q?d5wixZRTKYpsIQ06VlBNhTZCGRKqoC2k3MZle9kE6yOu81kn922Bz1/hRDVb?=
 =?us-ascii?Q?YLXyMJQCrR9r+TV0oIHLb68OOH7gu/efp02DhweL2nu7APCMHtHnljUFn84M?=
 =?us-ascii?Q?cKWqS0vT/Id4ZXfTj4j8alIT2EmnMZU4HgC6HRGivbRJa/hEASTi182givLQ?=
 =?us-ascii?Q?vjGPfU+ejcesk+rf8eyasI9AfxGYltT3M06YXtCrb0V4K3wGTcA1+6xlkx8l?=
 =?us-ascii?Q?BcUHQ8QVuEsp4PYKYRItOPP+pYPM3vhG7dqPBjZzWYYOhAAggtW2erMZ78eg?=
 =?us-ascii?Q?Q5LwC/JXQB3QZRKYewCpPxyZPvgtxYIq3JswdTlEAHx7QQdcxLTX/FTRlyHi?=
 =?us-ascii?Q?SZqh0jTBvKTxYbbSQyBA8yyFuj9yZhfTz0xGhiAaD1Lr5G4kwMvJ/RVjwheu?=
 =?us-ascii?Q?n0aZVnbjEFygHrdNow1MQzxDpyqybyASseoTD4oxZ881e+EJsN9drOoC31e1?=
 =?us-ascii?Q?gZNCDDregNweikr1RtPobuyXsCjq7hqv7p2E35kt8cHB5hukfZWxaekK9zHx?=
 =?us-ascii?Q?6LKZU6KSDenJUjjfpCTgGUkDba8XXoKBFznOLFlGSOC19UvYjIdUKV3TfnuO?=
 =?us-ascii?Q?vbzVj4Es8r1BA9TZ685jtDRj1waynjNd1byPCN5iAxDwovZ1tFVttQBRPFeR?=
 =?us-ascii?Q?dCYwRAzbqwab+H3LXTwu50urV01UOnp41g6aDKxQrmSwiVlUnp8ZpE5zSroV?=
 =?us-ascii?Q?ZaRAo51kpfAbz5e5p5bree8pelHxLSBybQlOSDJL8x189W7hn4SLNvFAymq4?=
 =?us-ascii?Q?CnQMPstPCBTCGs/3nFy4ovEVVX+BCVHOuduYolbUvIjug652mbMi4/FhHmuB?=
 =?us-ascii?Q?bDCmIXCeYotsUZVDZv7uI3BN+vPyW5zfkJ7ppqAY0L2QyM9GeyqFEcB9eZP8?=
 =?us-ascii?Q?r3xaWbiHDwA9wgDIunEW7AwscX8FvJYspuIHf/YTc/3gg2yis0nIa66tBRVg?=
 =?us-ascii?Q?rfZDzBCdpQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Uz1bDyzeO1LhQH3rAwOtLFk3xS4Ljuz3XNpfNSS942GPPO6iEEzBwhor0ksrmxCz06PMOq6QntUkRWvW9gWvCmt4ywDqpt0tFQ8cAy5b98wIOtZChLLApX0k7ZypRIi1JigU6n7PNm3Uw/nSRTLAyUZTBb80d+bg4HSR0gfYvJisvWl5aJ0Dte4FTlm7/hEDhXU82QOW7BtpmRz85YEYrae83SwXvLHoKckQ3pXaYTkhOCkXpVhv9x9LeyIzacDjp7u9L3vzWeMlh8T5/KJvMbLPmQFp+BICpD8US7DIXKExoZJnzfvaQ4CZIvV4Z2AVtOPGQAlrYy+YyAfHSffCkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8af1dfd-d303-467a-cc91-08df4076a396
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 04:37:20.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azVo2YQ4W08C+y7DB3wD6CSs1t3Ep4a0KkP1x4KIvMcAOu0Krb7FYT++8YEZ4qQFR0C1JXK7dwN3voZk4SNf0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6537
X-OriginatorOrg: intel.com

On Thu, Nov 12, 2026 at 02:17:02AM +0800, Xu Yilun wrote:
>> Extend 'struct seamldr_params' to match the new ABI. The sigstruct
>> address list is already populated in a loop over all sigstruct pages, so
>> raising SEAMLDR_MAX_NR_SIG_PAGES is enough to fill the new slots
>
>As you mentioned [*], could you add a note maybe in populate_pa_list(),
>that chaining is only intended for the module binary, in case anyone
>gets lost when revisiting the sigstruct part.
>
>[*] https://lore.kernel.org/kvm/aumh_q8olQPwH0pe@intel.com/

Sure. Updated the comment above populate_pa_list() to:

/*
 * Given a vmalloc() allocation, write all of the backing physical
 * addresses to pa_list[]. Caller guarantees that the array is big
 * enough.
 *
 * If pa_list[] spans multiple pages, chain them by pointing the last
 * entry of each page to the next page. Note that a pa_list[] that
 * does not cross a page boundary, such as sigstruct_pages_pa_list[],
 * is never chained.
 */


>> @@ -166,6 +166,13 @@ static void populate_seamldr_params(struct seamldr_params *params,
>>  				    const u8 *mod, u32 mod_nr_pages)
>>  {
>>  	params->version		= 0;
>> +	/*
>> +	 * Use version 1 only for multi-page sigstructs, to stay
>> +	 * compatible with old P-SEAMLDRs that lack version 1 support.
>> +	 */
>> +	if (sig_nr_pages > 1)
>> +		params->version	= 1;
>
>If in future sig grows to more than 4 pages, can we stick to version 1?

That is up to the P-SEAMLDR ABI, but I will ask the P-SEAMLDR architects
to keep version 1 in that case.

>What's the planned boundary for sigstruct_pages_pa_list? I hope we don't
>further bump version on this.

The ABI allows four pages. The largest sigstruct today is two pages, so
there is already room for two more.

>
>> +
>>  	params->scenario	= SEAMLDR_SCENARIO_UPDATE;
>>  	params->module_nr_pages	= mod_nr_pages;
>>  
>> -- 
>> 2.52.0
>> 
>> 
