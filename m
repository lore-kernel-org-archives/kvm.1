Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150573BADA9;
	Thu,  7 May 2026 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158844; cv=fail; b=r1b5E0h/OK+z/vlcLKJRdVslLrUSxDzHVDJIECBeVHD/uKi3l8qGc0gWcZ0ErTIcDXvDkzGs4rDU27+LPuwZN/jtnCO1u97lXWKARcuMPfWvPJCmpxJJcTNKFIjrsBjnPpVo9ZTV67Jwox4FtvgtYvijpvxrBrEjj0rjLRP04iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158844; c=relaxed/simple;
	bh=4uudz4ONJAbfph11Wy7UTrNhDv9ycKSnRMSnrtIxuhI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jVjY58TCT2LxAeAok/3Nj2SjYYhW8kxUvOvWHNcszeorQ7bOGlpEy9WBQJnouAWqfGfp086MZyfV7eIFOgxIf9tnLGGus2yHuHgUGNeVvF684pBDvNTi0cii5WalXWOLOrksXJ1Jx8y1RmlClJwuXKya7AmUzyk5Kzmn7XeCUUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIDIUtS5; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIDIUtS5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778158842; x=1809694842;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4uudz4ONJAbfph11Wy7UTrNhDv9ycKSnRMSnrtIxuhI=;
  b=JIDIUtS5csZiz585d1yXnQO/kxxID4KtGxEP6U8uvb+zWOW4RvIfw9tE
   V8fLGT1WdjlTGmqHwKV9Vim6XXFhyT3AYn13STrk3FSvVT7w+0Q6BnRAf
   149FiHCkBlTzZWTFtdacEamAVl3Ff/G06KeGhLBBiGI6yRsj31NrQgt4w
   latAq2knnoTj02sPIUZYZ2PJdbdEkweAJFtVT5R/FHGUoMQjRsyIFwUpz
   xMm5+UdDNj9B1tZls/Dj2Hr4a6xaH1LyTvl7vZj2RW+1B94BZ/FSP3IaV
   SzBV8TBJKNAssJ/JMAZODU5PmN8hcnjz5xPSz27c/j0bY+tCrIKLU6ELU
   w==;
X-CSE-ConnectionGUID: dXa37TCFT4SrCo4BpqPhAA==
X-CSE-MsgGUID: P8A+EJcVSiuybo9bRC33/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="66634525"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="66634525"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:00:38 -0700
X-CSE-ConnectionGUID: KrvnBm4pSgeN/RCy9lC67g==
X-CSE-MsgGUID: EkELAagmSVuFXZUEalv7Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="233793362"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:00:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:00:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 06:00:36 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:00:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKzAVtEizlCI/t7LeSUwLthedsO0U3Ry+I68coQftN7FRFMcJsiLV+ofuqghvFKoMUa1SWuHKIaVDx4A82nQz7xl6X5pJP5KZ5j4SIv8qiTj6QgbniIHyGQEcAfKEaQ/gOP9Af3IY/+zDdP7fsPQuaeNjeRlD8Yhe9XNy9jvkMSiviKwxqWdsXbJoj6yyWF6lZCIi93N4I5xZY6OUg0FmPm/0nOnpoZ2i+XX5dl5K1vER7NPRZAV34up6JCF53NmSnYbf8llIYX1QdMttNT3VHhSHzFUmO7TkeneGIAoftq+CYHL0yzmoUGFZXXcWH37qvxFztSJScW1VWQ2FNnJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJ8n/xj3kGU3OH6WAwxLXJf7lwwIsm38Vk0f/Q7440c=;
 b=XKRURGSqUIqywFD+op7qXS+kjfVPSQBahEOw91gtKUhFjO8+Xy6ACQzbCFdx/q2Oy6BpOanXji0GhUEKtYnqjI+/Knrti7Nx+ldJme0XhkUMrvV1Ng2eJz4V1SycEweCcV747hmnwSrv/LzUzwuy7Y1vJvVSxaafz11GgLzQJ9PTWC62FLl2EWI1bWEJK5F6vB4aox0VjpGhZVBOeOGCPnDMpmj7ioHEU5q8PS37TT9yjWhqfjTgELc5sPDtin0e2as8YdH2KwCaSp3ItqpuIIW58JuVMRVRJh8kbkEYseTfC7S5tl3bDYURyzcEUajF0XA1sYZLm+AVz5UKWvdBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3282.namprd11.prod.outlook.com (2603:10b6:208:6a::32)
 by DS7PR11MB8826.namprd11.prod.outlook.com (2603:10b6:8:256::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 13:00:33 +0000
Received: from BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19]) by BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 13:00:32 +0000
Date: Thu, 7 May 2026 14:59:59 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: David Woodhouse <dwmw2@infradead.org>
CC: Andrew Cooper <andrew.cooper3@citrix.com>, Xin Li <xin@zytor.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <chao.gao@intel.com>,
	<hch@infradead.org>, <sohil.mehta@intel.com>
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
Message-ID: <afxm400MglHAjoje@wieczorr-mobl1.localdomain>
References: <20251026201911.505204-1-xin@zytor.com>
 <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
 <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com>
 <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain>
 <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
 <afpPt7gObsyFkPRy@wieczorr-mobl1.localdomain>
 <f4650572ea8277dcde8d68e4fa5317e1abdb988c.camel@infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4650572ea8277dcde8d68e4fa5317e1abdb988c.camel@infradead.org>
X-ClientProxiedBy: DU2PR04CA0357.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::32) To BL0PR11MB3282.namprd11.prod.outlook.com
 (2603:10b6:208:6a::32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3282:EE_|DS7PR11MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b6bce3-fa78-4016-22d2-08deac389e7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: DXjgXh+wGnjMnLUS94E8+2OcRltd6XvnsrgihImgYrQn+CwifX7+fgoMBZOYPu0bBuK9FSBgL7CgsxCfJTebWu5/chEmeksmPuMBt7Y4fJ+HQ7CNJmLP0HfjOWZx0KqSDcUqwUNgylCFFxQb3XsAdV+xuIxTRXJxOd7CF7/mCl7sVKvamJjInAVOy/MYoqlqAcUTSfmMq9zFpxzYQqRgQOn+q7TxHIQyPFhDJSuE7JlJnMZ6qkdZom2zkAVimeH0KrvfAEAMGJdAk6cy/LYJXjmTffeAEOire6IohFPkxINjaX5iLQwHcQHAZgIteI3ldmJVuvlXo3GAyCiLOgQMaqYEALC4RQ455a5xFXQHQWz6pBYx+nLxRZVzRNkyOMm82E34Pbg7gqIwK0bfof6qLBdmMY/coq3Y4Nq8BOnAcOsv82ohBXqBKcRIF32q6IH3dD/nhK2T03twu4LeCGxVptWLqkBdAA4MBWJiMo0j2bytLPuuoIT8g7BPHcYOU94VFwhsYSsDfUWwH143QdYomKsLxLPCPCwewTNC+r9CnTGCpXDsP57gTtKSZFsoeOK+VqZd4aiVvePZDgOL6LhJIsjElbK/XCe+82HClq5dIeuGYmKehhF8tpBLq5W/qRwYfo+CiGpYUT7n6ZFwQmunJ/cvdTwGUmHg4IH+71gSoj+P12RDH7ZvN9STF0m2jrhi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nejwur5BFWDVkzZrbMqio1dSOQF//bE98SAXkiMwyI3cHHaW2NnTIutjMm?=
 =?iso-8859-1?Q?81O+fj0mm+BqK/63kf0vDuB4okyhsw6H6Ht8+SspaqcfnIwssxAPgk501e?=
 =?iso-8859-1?Q?a5pAwdyTLXt9pFQkr69RVLwZzhFO2K3ByeX3vy6rZtWftone4YEBczw/Ea?=
 =?iso-8859-1?Q?CZ9b64DInT3O+spNk3ADaxNnGBj/SMDfgQuB8xoVDc6W0vIZdi/qslfUg6?=
 =?iso-8859-1?Q?ZMiIxghTi0faj96SvH/eIqEQExWhfrYxwuok1a+L7H5w4y0DBtenT2xsdU?=
 =?iso-8859-1?Q?KeuOlIONG0geAlq7v29AB4vd2Y+S7UjBqTohYtkLLW2i64hp97QJGBRaG4?=
 =?iso-8859-1?Q?fZ2emUcOTw0SdbCdAp2reMF14KA09GaknaeFk53A7JY9lvvmnnBC1cKVzB?=
 =?iso-8859-1?Q?Ep/QDSqbwg/rxGuK7oVi4IJ1zBJEdv3TB59RQlXwI9PhBopo2WN7lCFBwe?=
 =?iso-8859-1?Q?8rgME+i5YDx/v4V1sSw7dW2d2YJjw5aUGirwZCTMqNKNjeaTcEWxraCCqc?=
 =?iso-8859-1?Q?ENOS2CIfgH0rQu8RCqMIJgc11GMWMAkcE9yS5Z9CWjhXSdAxVsOeY/Zmlv?=
 =?iso-8859-1?Q?HyITTV+NVBb0MSg/YHOODCSeJFkQ21jfl2AfGRUkJNOcn00L6CUZEiJ9Mm?=
 =?iso-8859-1?Q?/TmYxb3Ka1zhwu5ogsr5zLMqqIsbhDyBLFY73vu0d+lXxyni3A2qOQwhPB?=
 =?iso-8859-1?Q?frAlNqKBljZE9Jdvt0JAUuuYmk/bK+/UAgk2PLCX2MS8w0Welj9ALerPiu?=
 =?iso-8859-1?Q?P042iBlvrGfNbnsgBgSrhRc96KXIV1UkghL+P5EgwvnVCFrDpGMp0uxQLJ?=
 =?iso-8859-1?Q?LoQMwPSjipev+XJuWsZHEUVmn0pO2N1sFIdgR+uG5KbHcMx8dPBtPCj76N?=
 =?iso-8859-1?Q?+WvunsPMoPBsuWAmh7Ts7vcOS38Xrm4exA4uaUnlOgvY/TkslwSVsyjsbR?=
 =?iso-8859-1?Q?E8NPgzzM6s/fH6cuxEVZ4csK3yfoVAF2nSZ+O/YFpwy3Nxd//sOjaoSbq4?=
 =?iso-8859-1?Q?MOCJW6kA3g5NRzgePyfZeRmtO3Vn4OkeJupxs/RGVxSygBqIjwu6yAMva8?=
 =?iso-8859-1?Q?TblMOgzaIBSn8lSOANQnmskAuVnXXb6+d/mPS7+L66fYZ2gT2hm38LzVBc?=
 =?iso-8859-1?Q?4dXQykmUm4bMetRPqzKqRf34bCzVUY9A8KCn4zLSENJHrqEo+OSJjaXrSd?=
 =?iso-8859-1?Q?/XjmjY4qIVToDM97gGLSMob/8H88q2MLY29ynzuaZXkeI0ViZFx9egFGp0?=
 =?iso-8859-1?Q?HqlqZRxqeZMR9n7unsr4TdwXJFniR7aWxhYqP2OPzsvmohAIFnVZrlOGo1?=
 =?iso-8859-1?Q?jQTUShiZqKKAEJv3oNt2ESXSeiTl5oCqPvKbDeF5NulQOd3ghYykHmzqxP?=
 =?iso-8859-1?Q?ThakVrigZu+o/nbl2JQ2SlEhFf8W9o5bfFh51knrY7n9dRJXx1s9PZmA1M?=
 =?iso-8859-1?Q?2Wt8nxA7Y8EMnqC+sn3nm/GTvC4rg4tm1jXC5K2BqfUlZClNWYXVe+0ug9?=
 =?iso-8859-1?Q?JvFLF7EH5E5hXnHSARaxa0z6ZtmSnGxk9sX3wECDpjSTM2okSLrcBzy9Op?=
 =?iso-8859-1?Q?d101TbKr4qZm3+JrLumwAAEizdke+XGxedImnJlDOCkB/SBDpnPQFaGLaX?=
 =?iso-8859-1?Q?xSSAU+6oTLC0hwRep+lKOXuER2JLFawJvnL466Hza/x0oFrZ4BNPZrVCZ6?=
 =?iso-8859-1?Q?50tR7+kyheuS3OY67M9WeDipkY+9s9kfAVz9fpEGZ4Mbzsd71s5aHIWdmL?=
 =?iso-8859-1?Q?nqrGyQ3B9vhgBcliM0KesDSq+kMNfQYnPt2AntpvrYM/5bDPMHqu281F8+?=
 =?iso-8859-1?Q?W2swUnjG6yXW38sy4SF3Mqs5hpXstONcRIa/EecKjcMesPKCdqkF?=
X-Exchange-RoutingPolicyChecked: dBcBHcxvjilShezeMa3m6qHygfYWHSV/OhBXfaj6JB5noUewHxEYMhfM2xNhvXy2r9yTCtMzxaCh8MAqXIl12zFnHYCPr4oN9bYAKAb3eeRmLrmQQaFfweLVP30KrekHZm3c03Yh7izY9nU5EKQ97jVJ2Z6hRwnSwkgmhIVPnKDfj1+N6hAquOY/maKk20bSFwYVZhfmBPN5kpCZmbDn7CoVHK/K31K4/UCekHINYyJ+bkjhMjU3vpHFrkaw+MlJSEEpcFmdUFbtxI0XNKPWeB2AjeRa96vWiLFOM0XM8agUrV5dtDsE1nP/eaLUNrL7GW3b17ehe6M1Nd/Y03tgig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b6bce3-fa78-4016-22d2-08deac389e7e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:00:32.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD/HnGnm4Q9lgm9TqeQdXwzbkShzDTOYHpx4ALOKwClkxV16Cks4b8bglEKkRS+EmLtA1TrKAXHA8Ud4ZQo0cWpdAHOkLVbuahKnN/NOdXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8826
X-OriginatorOrg: intel.com

On 2026-05-07 at 08:49:27 +0100, David Woodhouse wrote:
>On Tue, 2026-05-05 at 22:20 +0200, Maciej Wieczor-Retman wrote:
>> 
>> I take it you mean dropping the ICEBP selftest test case and just checking INT3
>> and INT $0x20? In that case the other two tests pass after a minor change -
>> namely in guest_code() the expected_rip needs to be volatile as well. Otherwise
>> there is a RIP mismatch.
>
>I don't understand the part about making expected_rip volatile. Are the
>asm constraints there not correct? If not I'd rather *fix* them than
>use 'volatile' to paper over it. I can't see the issue though.
>
>Can you show the generated asm both with and without it?

---------- not volatile ---------------- | -------------- volatile -----------------
#APP						#APP
# 156 "x86/int1_fred_test.c" 1			# 156 "x86/int1_fred_test.c" 1
	lea 1f(%rip), %rdi		      |		lea 1f(%rip), %rax
	int3						int3
	1:						1:
# 0 "" 2					# 0 "" 2
.LVL42:					      <
	.loc 3 159 2 view .LVU146	      <
#NO_APP						#NO_APP
					      >		movq	%rax, 8(%rsp)
					      >		.loc 3 159 2 view .LVU146
					      >		movq	8(%rsp), %rdi
	movl	$6, %edx				movl	$6, %edx
	movl	$3, %esi				movl	$3, %esi
	call	check_fred_event.isra.0			call	check_fred_event.isra.0

I think that when the FRED event happens it doesn't save RDI and overwrites it
before going into check_fred_event. In the volatile case it is saved to the
stack before check_fred_event() (.loc 159 is the check_fred_event() call).

The below does work, it generates pretty much the same assembly as the volatile
expected_rip. Do you like it? I'm not sure if it can be simplified better?

	asm volatile("lea 1f(%%rip), %%rax\n\t"
		     "movq %%rax, %0\n\t"
		     "int3\n\t"
		     "1:" : "=m"(expected_rip) :: "memory", "rax");

-- 
Kind regards
Maciej Wieczór-Retman
