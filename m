Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C03C3420;
	Tue, 14 Apr 2026 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159857; cv=fail; b=T1JVeLFbAZpaJ2RokyPz4NxQ8ODMRLtpYOSnqGYBBRW/PB31P0pQqrTQ9Pr12INMLF+cbl0CoOPpLIfJBYDNKWMS6NgEx3Dv/RjCgOPDi8mBDayEkkh4dfhKf2SkZLKDt+LmMi4yPPzVMCmszMx5+0gmmFLbF+vHyklz1b7DQnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159857; c=relaxed/simple;
	bh=o5Zna4B3mA/QhiDDgUsl779vSwHhvSfXsQ+mrvgxKak=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VPwgqPU5HNL0GChdwb5mO2fsrnGDl6Wp7tfXj8x85Rw08LKGrclNHG2rwbv6HLJH3sKtfszpTue+O1o1WDEus+BZUpl/+cPeGoYVcDUVZT56KT/Ch9fc6e1hGPxJvMjFO2hgH4JDQgZIniuabD15KvqJqyBgYflxg+RmF9zMAO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRaEa83D; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRaEa83D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776159855; x=1807695855;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o5Zna4B3mA/QhiDDgUsl779vSwHhvSfXsQ+mrvgxKak=;
  b=XRaEa83DOgNMuNWTBD32hO8CKn0nHrVyI2zUQ14vPmahWRlGz8aN94oR
   u4NGf7GrAfdVWKSBJ8R7l0aVp8PURMmucJtzMXIvGQJtTPbEtY9oUVkas
   IkqQC9CAwBPHdsdSJAIbOE9kHHS2ODB+pHY5vgaEepf5A9oSkS/m6IeUv
   gW2HesTwCTRg0tyi/2wWfTLk82XmXUTjrvWJiuEdiZR9f8vlU54O9hMZR
   bEFxRf+zqelwwoR6FZ5kxBZLc79x2QybjcRBVgh7QtbUnkEBsEWTSh2ch
   a5VGpnGsEJw4XOpDJvSUcS0bxHHWw01NxD8FY037lzMiwUdX9n/YciS56
   Q==;
X-CSE-ConnectionGUID: jGztDUHXTnKDqt25pHHbxA==
X-CSE-MsgGUID: tfwJUHb3R76vFJD502PFDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="87415978"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87415978"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:44:15 -0700
X-CSE-ConnectionGUID: cBgHb0UPR0ueMDmzjo2rdA==
X-CSE-MsgGUID: sMjvF7e1Sq2/M/zS+R+v7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229921540"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:44:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 02:44:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 02:44:14 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.32) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 02:44:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr0u7T/80ZgsOjIvkw7t7Dhiyr/9mInVJ9Mw/7uty7Wp7b/i7GN2ZGrxQOdx5q9WEVZnuNHO8GofXVRw15F3LL+9dVHoZ9vKvxXF8BWneLAmAJDhFRVjEVvJv86D5t4ozgaBsWiUempW8iXYnglOSUYCFtoUtmAxnxI6mU210pNTZORGypprOPYip5XdractfTnQH3t2mYb172f9O0e4rneuwP5wUOjY5zh1wRC/AteM9fBUxXGIq0HqidJH35SpjW/06/Y7r2RyvQu6FWKbBfT+kMB8lX/Wm3mSg2Dlx6GqO406Gh+9wQ+PbYINhKparlkZ+Pv6ow1gJkWneIyuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwN9VqbSCDodoIVu+Gt2z8w+0IWoGSWgqOzyCtjI8sE=;
 b=JN0JgRcOs0nJ49+UR1SobHnABmEvlQRdwuj785+j4shQU8DCrUndgQUE51Qfw0gmdoT2+RXNptkpWH5FmOh8L5Ql3lhbMk0ZPFngfCdndHLKcM3dyaIElLnGHtsOborYZKFuZk8EUsw1/bi2pH416Z3hG3zwAqQpbXLWjKiqgoprTiA0dcNjRYcJAqWVfj2fVZskSToNXp6ep0l3WPWo9srm59by1PkmVNsaRB5rOfXHVOoBRKgsKaXIy7PJI09cF/7CtVFc+3Bl7yE602vr4nttg1d+uD0tYE3ySyZyXxZXFFX9RqmVRtXzNSbOpGj8iCrPcn28meN6Sww+CbcHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 09:44:08 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 09:44:08 +0000
Date: Tue, 14 Apr 2026 17:43:53 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 08/22] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <ad4MWR0DyOaI0C50@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-9-chao.gao@intel.com>
 <a6a3426ba9b84ea25f3653e33a181dab0096b35f.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a6a3426ba9b84ea25f3653e33a181dab0096b35f.camel@intel.com>
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CO1PR11MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a4721a-7561-40d4-83f4-08de9a0a5fc5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|22082099003|56012099003|18002099003|20046099003;
X-Microsoft-Antispam-Message-Info: KXlK+MlQAqqrtH5gtlKSGjRO6swj/UgT7ZzQAPSPJ6RYk8gAVKsyN3CwJ5IuWpuHA44mmIhiK1xreXfyn0vcVTL/VlGnt6g1yVuIFge4L84pIz0lwXPYcGLgwCQ8EdgHyNIYxSZqGl30gHNGU+/ZyDzFPMSFM72D20luQH+XqQ11VIo+CsChin3fjYNMLqw37EoP61loVuSXV6J6DbCQ473lqaG6VmHrNdzp8tJSaodt8zFUohkuIQCCUvitaB3tbkSE1J24k+1fJhkd0dgDOo2+p0DbbXjURdaLUtDFfgE+Q/42zlxDmqCrXGNEADNcrkfwLEBSZHAULGiC3ZjzPJSW9DbWd4SipvhfHtbx7cu5YphKaa1H9klwTUD5W0sAhIxZTRzsMZyE3So9FEU9WbCuGBpkRoaRluy5V0Cyu9g7XkSzaWRkLibtjxS7FhjKoeKg+Wun6sjGOboI3qnWNkcxsbeCCo7jI4L6nMWDuXEsnlIIK9i+NbtOmf/+EPxebpsxBzBLIA553ovUfozpCIYQVjThwOy8WBYHpEHqeyubKbjOOfITt1Jzu/l065M1YDZARzJV2y/jXGhf389VR+cnhqdRMHgv/JHSB35TbsoRuXVxa26iucpfkd+qzNm9MOXC5T0BDMYKbQSjND7hz/x2Jg6xgBj+GCLUKLnndoXXmVooeH/n6MW0ZW21SUymO9JzArcE2Ljcrn6jFi3EIWP4gY7YBSWT3hG41lcbrME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(22082099003)(56012099003)(18002099003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xi55wjSKoTniPVek/sqMxMMh63yjVdFUclehFE/863TzHfTs8orq4/htQtgz?=
 =?us-ascii?Q?j2L125USTjKX+VXJbDu0sGe8izpa7pFUCgGKnDuG5gnqWN9UtwmLy5omanlx?=
 =?us-ascii?Q?nDUbFzMekKJtAvLsvR/ReXWW95Q1QPA/s23dMtywsjCUIJ4jIKHEIItUkUbK?=
 =?us-ascii?Q?55wsgxl4LE+GNDyuvwnxu1ZoA2v1PVF2dlwebqt7LRnNhPvf0KfhduPkazv6?=
 =?us-ascii?Q?GlH/i+SKTeMZyREQfvGsPj9AVXL5pmoO8G4Qk6/ZCWZCOZFNZ33jPO8lS8f+?=
 =?us-ascii?Q?L6YQ1IALVAIB+n40e5EIo3pRkNZGGBU12/CODmEHwN5xj08MNgkZk4t3BiW6?=
 =?us-ascii?Q?fqrH/YXGTDtBEsZ8dtTfeay108hsX2BQzvVr8RRpAmtUNFnO+2NcUW/zg31h?=
 =?us-ascii?Q?P+MemyF3nAgc5cw2lgMhdRLJTT5oqrtDsglpJ7C9iOtPX1+xytv7LpBTnQbe?=
 =?us-ascii?Q?Oq2gm7QoJMlrEZ0hu47+haf/0hEtFUWpWvsOmGgcfjrX3iJgOlJl1oFbsdf4?=
 =?us-ascii?Q?+QODHhm9JPjVAYr7AmIJw/1x3TJbu4TEHYi30kG8IlGakqAncod+Qu7z0h8M?=
 =?us-ascii?Q?DAYmt3UIL40lmHqEH0K2Z+6PILMiIpfDBC1DFtN3x90KpHSZoVzWohuiiWDW?=
 =?us-ascii?Q?Q353jc2zFGQ2KH0uabXZpgcB8PDGnIoJa1wvq19Lry8V9VTBiYL5LbRrs9GS?=
 =?us-ascii?Q?cksPlOJVxhXncleAQ9etpKu7io1an3hTooD3gQEmonhxgCd/AwzOMd4BgCMq?=
 =?us-ascii?Q?dl/wZry83BC6KGyshit9yI24nfyRhWWjcg9WNPe9SoVRmHQWSKw4LDYyxJAM?=
 =?us-ascii?Q?6Jq7BXxTMB63qk0M3XnL23NeJQbGl1nvy92kBQGMIBbeyslbZLPpdnSrnVES?=
 =?us-ascii?Q?9DGkoc63PJeXkmZSQkmVEQsXIjnjRC+6f3a9htTz1rRu9yES/y4abQnzu+D0?=
 =?us-ascii?Q?ZLhdHC71/AIgYRC33EqMit3FvnPHzONKSzYlIdxJL02vQ7hsHBj73kOG86oW?=
 =?us-ascii?Q?iqzREsrWT8qVTUlxWMUQIRFb+z1eK8a5v4LxAieQqlpKMMUlgAFh05h8fl2j?=
 =?us-ascii?Q?ZDszrIPpDPReLPIWuZ4pzOnoIbF0BOPHxzV3FYpQlJ6+Q88DuqLinLuJyQmm?=
 =?us-ascii?Q?0HDN6qmgq/l2uAHrQd04mpXz37JB5QXAnr1uhYiabulCRV2AirEUwp8VbCz6?=
 =?us-ascii?Q?1f9fJDeahUtC2kH6QBjEnufGlTt0NssY+vAVxpHLcPoyy5qiLVXAwfO90fGq?=
 =?us-ascii?Q?i8gu+WcuoNW4sw7RS6mHmIMaAR2x/37ko6Y3GhMMd85vNZISTyAyDF9JvCm/?=
 =?us-ascii?Q?ZhC2VjVzrsfA8qHkX1cll8rDJGC5B42vXQKo5sYjYOpZ+UayiGvyQMGUVusF?=
 =?us-ascii?Q?n953UWFr2Co9jf/iNXjhM8e6laU0pZlfzsjAdUMDlRsFYhF8oHFXmS9MAowi?=
 =?us-ascii?Q?+3RRfptHN9+41dH4ONW3rCcDzAnP3IJyCINgcbr3Ko5jYP3HZMciyljY9058?=
 =?us-ascii?Q?8NbUpY7yTwSLtL28PVJPX7nibCJq6rVZBGExYKqEx//uZjFjVNEVsxz05o+Z?=
 =?us-ascii?Q?9oU3/VxW9+bbfDXa1kU2gp4tdU//XQcI+vzmZ0iY73AAXfm3iYioTt/4YlYC?=
 =?us-ascii?Q?4O6ePRWrbbHJGqBu9LsPfSgy/jBw16vq8uPc6qQbBkloEBM+607hTzqnKg5/?=
 =?us-ascii?Q?GN9xDtwI/OyygEN1n0/qJA52xKTDY5N+ytTHoEd/io7o3EA0bacFLnthP8ND?=
 =?us-ascii?Q?LPG85cTjTA=3D=3D?=
X-Exchange-RoutingPolicyChecked: GIiXxI9EJPopdqJdK6IqZzP48DJwaVoCRJZM3BWSKmTMw3/jtAFqoxbBMqMG4bZvKZaSEqFdkdAiTXUQYdnUQKfkfsBLOLdLCKQG1XArPLeEZuhhFi3AypCjC7pYHxJLtuTaOXsNYBgyZ7hTWu3XpTcpeYSQIkIE25LgLJncU6SZHycP1u+CW1q217tzwWpg+VR/Q31aVTDEnCs9XWWxJ0E0y5DeqUiu+axJagw+jTPUFhSzNAwrlxPY8eOn+S5NOAhCZbC7lsxEXFaS3Uvk4fW76nIC2mqfpsntSlXcrVS3+l8UEpGaP3VBJUVZLakuoBeP4Hzqd/yoH9e9wTMsDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a4721a-7561-40d4-83f4-08de9a0a5fc5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:44:08.2089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkqpkY8qO33GhZpLpagtUPq3ZtmY1W93sDNM/XpZEz+tPzJLLti9lJ9xmeXifvmnzjLtpOEiajkVSR+jtmAKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com

On Sat, Apr 11, 2026 at 09:14:36AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-03-31 at 05:41 -0700, Chao Gao wrote:
>> P-SEAMLDR uses the SEAMLDR_PARAMS structure to describe TDX module
>> update requests. This structure contains physical addresses pointing to
>> the module binary and its signature file (or sigstruct), along with an
>> update scenario field.
>> 
>> TDX modules are distributed in the tdx_blob format defined in
>> blob_structure.txt from the "Intel TDX module Binaries Repository". A
>> tdx_blob contains a header, sigstruct, and module binary. This is also the
>> format supplied by the userspace to the kernel.
>> 
>> Parse the tdx_blob format and populate a SEAMLDR_PARAMS structure
>> accordingly. This structure will be passed to P-SEAMLDR to initiate the
>> update.
>
>The thing that confused me about this earlier was the exact reason why we are
>checking all the fields. We discussed that we need to check the fields that
>kernel processes, but we don't need to double check data that the TDX module
>processes.
>
>Should we explain it?

Yes. how about adding the following in the changelog:

Parse the tdx_blob format and populate a SEAMLDR_PARAMS structure. The
header is consumed solely by the kernel to extract the sigstruct and
module, so validate it before processing. The sigstruct and module are
passed to and validated by P-SEAMLDR, so don't duplicate any validation
in the kernel.

>And how it explains the checks below?


>> +static void free_seamldr_params(struct seamldr_params *params)
>> +{
>> +	free_page((unsigned long)params);
>> +}
>
>Do we really need this helper? This doesn't work?

No. This works. Will do.

>
>DEFINE_FREE(free_seamldr_params, struct seamldr_params *,
>	    if (!IS_ERR_OR_NULL(_T)) free_page((unsigned long)_T))
>
>
>> +
>> +static struct seamldr_params *alloc_seamldr_params(const void *module, unsigned int module_size,
>> +						   const void *sig, unsigned int sig_size)
>> +{
>> +	struct seamldr_params *params;
>> +	const u8 *ptr;
>> +	int i;
>> +
>> +	if (module_size > SEAMLDR_MAX_NR_MODULE_4KB_PAGES * SZ_4K)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (sig_size > SEAMLDR_MAX_NR_SIG_4KB_PAGES * SZ_4K)
>> +		return ERR_PTR(-EINVAL);
>
>I don't know if it's worth that much, but we could do a MIN thing here to
>protect the loop, and lose the conditionals. If userspace passes a blob that is
>out of spec they can deal with the module error, no?

I think we all agree: we need to do something to protect the loop. So, the
question is just how.

looks like you prefer:

	module_size = MIN(module_size, SEAMLDR_MAX_NR_MODULE_4KB_PAGES * SZ_4K);
	sig_size = MIN(sig_size, SEAMLDR_MAX_NR_SIG_4KB_PAGES * SZ_4K);

But I think the MIN approach actually requires more justification than a plain
bounds check.

With MIN, the reasoning chain is: we don't want conditionals -> userspace
can deal with the module error -> and that error won't be fatal to the
system (or even if it is, it's admin-initiated). That's a lot of assumptions
to validate.

With a bounds check and early return, the reasoning is simply: the input is out
of range -> reject it as invalid.

>
>> +
>> +	/*
>> +	 * Check that input buffers satisfy P-SEAMLDR's size and alignment
>> +	 * constraints so they can be passed directly to P-SEAMLDR without
>> +	 * relocation or copy.
>> +	 */
>> +	if (!IS_ALIGNED(module_size, SZ_4K) || !IS_ALIGNED(sig_size, SZ_4K) ||
>> +	    !IS_ALIGNED((unsigned long)module, SZ_4K) ||
>> +	    !IS_ALIGNED((unsigned long)sig, SZ_4K))
>> +		return ERR_PTR(-EINVAL);
>
>I thought you are going to reduce this checking to just to reject invalid input
>that the kernel processes.
>
>What happens if we don't check this?

If the blob->offset_of_module or blob->size is misaligned, the loops
silently drop the unaligned portion. P-SEAMLDR will then reject the update
after module shutdown and TDs will be killed. Since this is admin-initiated
with an intentionally invalid blob, the consequence is acceptable.

>The vmallocs are all going to be page
>aligned anyway. But even still, does it mess up the below loops somehow in a way
>that hurts anything?

I agree addresses/sizes are page-aligned for valid blobs, but they are not
guaranteed (e.g., if offset_of_module is misaligned) for all inputs. I
removed the check once in v6 and Sashiko questioned it, so I thought the
assumption isn't obviously correct to everyone.

Without the check, we'd need something like:

	/*
	 * Assume sig/module base addresses and sizes are page-aligned.
	 * If violated, P-SEAMLDR will reject the update.
	 */

It's a few lines of straightforward validation vs. a comment that requires
readers to verify the assumption chain (vmalloc internals, userspace
contract, P-SEAMLDR behavior). Not sure the trade is worth it.

If you think the comment is sufficient, I'm fine dropping the checks.

>
>I might be confused, but it seems different then we discussed.
>
>> +
>> +	params = (struct seamldr_params *)get_zeroed_page(GFP_KERNEL);
>> +	if (!params)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	/*
>> +	 * Only use version 1 when required (sigstruct > 4KB) for backward
>> +	 * compatibility with P-SEAMLDR that lacks version 1 support.
>> +	 */
>> +	if (sig_size > SZ_4K)
>> +		params->version = 1;
>> +	else
>> +		params->version = 0;
>
>I'm a bit confused by this part. What does it mean to support old P-SEAMLDRs?

All current P-SEAMLDRs only support version 0. Version 1 is a planned
extension but not yet implemented by any P-SEAMLDR. Always requiring
version 1 just saves us a conditional but disables updates for all existing
P-SEAMLDRs for no reason. I think it is not worthwhile.

>But also could it be:
>
>params->version = sig_size > SZ_4K;

ok with me. I just wanted to make it match with "version 1" in the
comment right above.

>> +static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
>> +{
>> +	const struct tdx_blob *blob = (const void *)data;
>> +	int module_size, sig_size;
>> +	const void *sig, *module;
>> +
>> +	/*
>> +	 * Ensure the size is valid otherwise reading any field from the
>> +	 * blob may overflow.
>> +	 */
>> +	if (size <= sizeof(struct tdx_blob) || size <= blob->offset_of_module)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (blob->version != TDX_BLOB_VERSION_1)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (blob->reserved0 || memchr_inv(blob->reserved1, 0, sizeof(blob->reserved1)))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/* Split the blob into a sigstruct and a module. */
>> +	sig		= blob->data;
>> +	sig_size	= blob->offset_of_module - sizeof(struct tdx_blob);
>> +	module		= data + blob->offset_of_module;
>> +	module_size	= size - blob->offset_of_module;
>
>Did you consider just passing the tdx_blob into alloc_seamldr_params()?
>Basically, this function checks the blob fields, then alloc_seamldr_params()
>turns blob into  struct seamldr_params without checks. The way it is, the work
>seems kind of spread around two functions with various checks.

Fine with merging them. How about:

static struct seamldr_params *alloc_seamldr_params(const u8 *data, u32 size)
{
	const struct tdx_blob *blob = (const void *)data;
	struct seamldr_params *params;
	int module_size, sig_size;
	const void *sig, *module;
	const u8 *ptr;
	int i;

	/*
	 * Ensure the size is valid otherwise reading any field from the
	 * blob may overflow.
	 */
	if (size <= sizeof(struct tdx_blob))
		return ERR_PTR(-EINVAL);

	if (blob->version != TDX_BLOB_VERSION_1)
		return ERR_PTR(-EINVAL);
	
	if (blob->length != size)
		return ERR_PTR(-EINVAL);

	if (memcmp(blob->signature, "TDX-BLOB", 8))
		return ERR_PTR(-EINVAL);

	if (blob->reserved0 || memchr_inv(blob->reserved1, 0, sizeof(blob->reserved1)))
		return ERR_PTR(-EINVAL);

	/* Split the blob into a sigstruct and a module. */
	sig		= blob->data;
	sig_size	= blob->offset_of_module - sizeof(struct tdx_blob);
	module		= data + blob->offset_of_module;
	module_size	= size - blob->offset_of_module;

	if (module_size > SEAMLDR_MAX_NR_MODULE_4KB_PAGES * SZ_4K || module_size <= 0)
		return ERR_PTR(-EINVAL);

	if (sig_size > SEAMLDR_MAX_NR_SIG_4KB_PAGES * SZ_4K || sig_size <= 0)
		return ERR_PTR(-EINVAL);

	params = (struct seamldr_params *)get_zeroed_page(GFP_KERNEL);
	if (!params)
		return ERR_PTR(-ENOMEM);

	/*
	 * Only use version 1 when required (sigstruct > 4KB) for backward
	 * compatibility with P-SEAMLDR that lacks version 1 support.
	 */
	params->version = sig_size > SZ_4K;
	params->scenario = SEAMLDR_SCENARIO_UPDATE;

	ptr = sig;
	/*
	 * Assume sig/module base addresses and sizes are page-aligned.
	 * If violated, P-SEAMLDR will reject the update.
	 */
	for (i = 0; i < sig_size / SZ_4K; i++) {
		params->sigstruct_pa[i] = vmalloc_to_pfn(ptr) << PAGE_SHIFT;
		ptr += SZ_4K;
	}

	params->num_module_pages = module_size / SZ_4K;

	ptr = module;
	for (i = 0; i < params->num_module_pages; i++) {
		params->mod_pages_pa_list[i] = vmalloc_to_pfn(ptr) << PAGE_SHIFT;
		ptr += SZ_4K;
	}

	return params;
}
