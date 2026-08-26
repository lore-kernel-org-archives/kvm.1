Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA53403E1;
	Wed, 26 Aug 2026 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729018; cv=fail; b=GjVAPvYcwENH1PuXFpGSjxI1T/+Pz+aMZjhz1AMxHOozLvuar8uftj84AMb+g+x57Zfi5KohTB/Yq+/GrN0H05Obry8eS9RsyZYjCzhOZnH5EnsM0WDPbTT6scdDngEZoWctF32UPv59+ZDKOgEqLydk8rgb25hGOLsVadCeOYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729018; c=relaxed/simple;
	bh=zbEYBoht9GfVxRt3uQ7C3U9aSnM6EeJQ75Hf5PF5RPA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nDvT0zWqsdBQ26hGHBerFTOwF31oXghZgul4pvK+NaMOiLl/D2qefRbjILfj+Lrj1983MGf1xKwYNpSBTC6IxBEPuTEva/LhncS9E6z6+j8xMlCE+fpbCpqxY0qMwHALk5kO7GesjNJH7DK06tKpEbsgRAR9moQabvJZlJJSdI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsLCykSp; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsLCykSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787729016; x=1819265016;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=zbEYBoht9GfVxRt3uQ7C3U9aSnM6EeJQ75Hf5PF5RPA=;
  b=YsLCykSpSpupC77tnV8vxKIV1IhHUUSpTpDgDpFRyqhz1RH0EVLjzsjh
   R3iF1uGqaaJyQW7xFteQPz3wb7kHixNZlZZjpl5G85aJUcoZ5SmdqBXzn
   tDlxdhfCP37kWrtWgQ0ZXXCMipSGKQHN3/JBYJ8vtbegSc8drbKirirJL
   fzRQkAIa3YnKjb+6Vvj6YtbdQSHPdW4jvLIKyfeHnKG179J9Gv4wn/Gir
   COtSyLew0eWEgX3jfmNcYOiU/QxevxTbGxtOouUC53K/sDA95D/zw54Hu
   asoWuoY3ritSZyWG7xIZKZ9jGhCIE1oqCIy+SEGLJT39OCA1MaIYjbsES
   w==;
X-CSE-ConnectionGUID: wn42n6OvSbmBTtvrpYcWyw==
X-CSE-MsgGUID: 9G0mJBMgRw2ljO46amKkkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88231672"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88231672"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:23:36 -0700
X-CSE-ConnectionGUID: 1fi3PlVcQVywA81Vw97WXQ==
X-CSE-MsgGUID: VAAHwCkxT0+2u1FP0damGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="268079670"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:23:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 00:23:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 00:23:35 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 00:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkWWluxLO+2ktVeNk0oeoe3HpJDMkDqtorT4tf2hr0sINXDme4YG2bjGfG303As5K1o4bK1fZJySWQ+XJhhbpP/Wy/6YdeRdZrPYuqfkzaZj9zIOvEBRzZ1/YCAMxcOlxb9nWrTRM9c6B2pBI2yF91V8WG00r8zoXf4JYrJAPqLl7k7YDaJW9/mctYcwy83JFqA/M+DjzjkFCwy46Tfqe8ucaBi6ot6CkXVM08Cm7dqjqay25QqMwefSsusZK6a1OZ3rV3kWyM3zHJDb81jWchZiUK3FhPfygGFDDmOt5PGevQdWFU5+RfmbjdRDl1fnXp2Z1Kza1LdzfFE/Q6oT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljWKhmFp4R5veCr9L4oVQGm/lvn1KZKQrEheJjJbFVU=;
 b=P8BMP/u1yIfi3kLswJt7L6EwZigRVkvcya8qR3SQ2mD1KzP9rUUrgguGot3rWi5KcpWaaxGSOlcBo9nPHBKjV5pRcSVAleFaiinbay29Mg33UfY1f7dcL2d2qM0VDgWBc6gv83R6wi8+jgoqU5/S3TLxkMi0S+TmTyk9JEfI9iIZJqL/V6BLyWnaFobCzs5F4LLMADCmPvu1+FFIYU7IPRevtp6AjZvBQUB9Wfnx2/K0MQkVFVPhx48I9JZ6rrX3wZaKTNaH2d6gVHP2doOkJ3xucT2cNUhs8qRdsQSaqIxZAuOyh0VrjqHhRY0YK50vU5MEhpHUSvEDdEiy/oqKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 07:23:24 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0339.008; Wed, 26 Aug 2026
 07:23:24 +0000
Date: Wed, 26 Aug 2026 15:23:01 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: <kas@kernel.org>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <rick.p.edgecombe@intel.com>,
	<pbonzini@redhat.com>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<kai.huang@intel.com>, <yilun.xu@linux.intel.com>, <vannapurve@google.com>,
	<ackerleytng@google.com>, <sagis@google.com>, <binbin.wu@linux.intel.com>,
	<xiaoyao.li@intel.com>, Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/virt/tdx: Warn on !4K level in tdh_mem_page_aug()
Message-ID: <ao6UVdWNbhQaAFsm@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260825025533.25663-1-yan.y.zhao@intel.com>
 <ao2ZH8dmkPfBDnGv@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ao2ZH8dmkPfBDnGv@google.com>
X-ClientProxiedBy: JH0PR01CA0098.apcprd01.prod.exchangelabs.com
 (2603:1096:990:58::17) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|PH7PR11MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb7167c-2d9a-4c7b-6589-08df0342ea65
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|56012099006|4143699003|5023799004|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C4qoVb+AHSLPlQ+uRRIabqLTKbgznBiEistybHenvOYgFGVGAUGvFerFLVWTGOmI7obWPLJ05YA/+vZgvZOo+q/KzIipnTMg3Zihd1skP/oePAwQmCEL75x+wfxhtyoRy719vWS8BxlHb6geoBXsrvF0VgBJNOe1fJJLDPPSvv18wQZqmAdZwF3AlH8+4RyYOALgTCYgpnyNwVOYjBZnnTeSXv3pufXmtAD7mYHbXFebFdJe8ldIlSyd7qwJJi39Ht69/cdjmrReGzcxtyd+QZaalvV7H9lWzKKMUdzypzffmB8rlF1O3t6VP+J3ZLOt2gEyam6jiuAwWO8AFmxfAjK6y4K/uXjjY8BJGpWsb3zP8pwhUajmbVVU6XscObRru03fEkCVaPsdJFK08X3panlUcq0IreHUmZRRalvm6Rj3vhETl49fEbG8Bd13bUqBcFq+EAT3dkhdRFCBTSAZNgdMSeDUqMDsSwFD+Ww0pTp0UMBs+WGq6VHBhtFUkZ3e8l3O5M34QOSyoN9/noTe4TX6Ru/G9Fj/JXrYMC3jbVcwcO8deNrL5vM2J6b3iD/R0CgXYuHp36EoNZ2LbQke47K1ZI14Z6Wlchl7f9xXrXDbUDGLkAD/PVfK5ynBYd2au8aCnqBdWHxa5m84J/0EXuhKVXMXsSRZnqzCEhcebLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T3qevhPZff67X5w7FVlE5efqVq096r8uANVjH1oknZMN+FF/iFlZ1zD1ycuP?=
 =?us-ascii?Q?KI2hII7BNl59eMOYc/l27dg6H+IzuOxvDJ5eCJZNrIUiS+gf/WBbTzsoHnuc?=
 =?us-ascii?Q?GAT3Adoll0I+xIEjnkelxUdhXhdwA6WA/LUTH+oN9yBAX5heR6prmzIuwI3j?=
 =?us-ascii?Q?yLktN/z9XWaFOxibFyawujXMfyEjVildSPjZHST1RVOsLay39izV2u0pPpc3?=
 =?us-ascii?Q?nPuJPMNTpD2hJcD6coJlyMeW7TbbdGcpiVGfvtrRHsXfKePubrUcxqbrXq8Z?=
 =?us-ascii?Q?bgssTEpXfX3FTIoJazLzAj4VAVd/v7ZiXknkr1TYnGUyiX7+dHso8Sla9njO?=
 =?us-ascii?Q?YqeEWv7JS6awq+HTll/8K3eFAYYXaX1beD5fZoMRXNUZJIolKvJq2Kf+CAvl?=
 =?us-ascii?Q?KSFeAIt+VbxLIj3TK9Z3O4+Jfv16V4GjlwATcIZSZpa16ZZyGs9tFmfzfVL7?=
 =?us-ascii?Q?7DrLZeEqlghk+YlhQTKttckpBzBXFIRFE+grWZgBTbNb71HJUl9rfa7vyr8H?=
 =?us-ascii?Q?XG21XvxlVsgBRP9mcB01Mj+EwvIBZ4RX96Eg9JejgpuaijoM/B0hPwDtWPCg?=
 =?us-ascii?Q?toQhu57IGfDOP+Vo97H0wwjQN3ti98hZ0mLfomRBujqYqo2wBY1uHgXo+iEF?=
 =?us-ascii?Q?6T1IdEOOWl5i7B1xYzt8NZjiGzHokyyGUPswCqRHiO188Pm/BSnBMw2QbqKS?=
 =?us-ascii?Q?AbUxHjUPMICr8o0xkprFXqSicZMiDjHn3XIg/2BOA3Fc3CKZOg2vOM2Aid4J?=
 =?us-ascii?Q?/rIl1UbuEqJ6C+ytdwpi2Ze2VNeyZebN6D+Zc7xsYKN0Hxx9u0FZ0w35KPmU?=
 =?us-ascii?Q?z2QMUVRYgBF3W0DR1i+0L/EuYjyzF2wFLWIhx2JMn8i338ur5G0ci+daYNGE?=
 =?us-ascii?Q?Sg1uKmwnt7uG14m1sJb/GE8+54FKyrncqP85BilfbPpPi8Vq7fIgyiXE62wG?=
 =?us-ascii?Q?QDYkVgk474RCjFhK4BDj1JI0SUC002chWISCaQkwZh4T0fXWfdMUdRppV8gH?=
 =?us-ascii?Q?OtrD4UAvck8w3FIClK5QHYRsCNkWbfZFj9DVNP8DxlDYjg9TsFEIVLEnxJNJ?=
 =?us-ascii?Q?+vL7mPCsHpm2dVY9XwC/OsT/j8jr/wJDhAyJVAH7W/1ol3yTVEnTKPD7eTGi?=
 =?us-ascii?Q?Q+PNzPuyus5TVERaioBm7an2qeJT//dJ7iblalQJBy1XAArB890rChWUZONr?=
 =?us-ascii?Q?gIggsferyIQEuhdx8mCW6uHmGyO65OalL6AOWHIOMFtbTwNJZXh97jzdNPVI?=
 =?us-ascii?Q?Vo/wBtVkB8oXEnimkgZtyNCwkkGvSpA4Fo0oBG0i1VmUwd/hhayGdWvy0kiq?=
 =?us-ascii?Q?dE7cl7J3Z8aCVlXjSCZBPF0XbrKeqkKoRg3MMOXaT9YNDr31+JF6jTI8Io+g?=
 =?us-ascii?Q?Tq5NaV+LwiTqMdnc5a0Sgo/jUhHne9hq976lWVy0/jO4AABY13j3Ht5JjIg4?=
 =?us-ascii?Q?y4qaFNQAmxCQgYTpbQb/JQ9kYYEWNhtelRVb8K5PfQ/qfHW6KYuQVLE0rMiA?=
 =?us-ascii?Q?fUwmNFRFHiI3U5XA8jLTA9V58zggjCD9P2ErpCzNXFC3J8PH685R1w41VjyY?=
 =?us-ascii?Q?VdAYpAVT1lU9KSfUdQhvJS+Uk5V7zqYUv2EP9Y4cLM7UHER8A6ybtu2TN1xD?=
 =?us-ascii?Q?GIz0VR3/GmActgYnf425SIlGzSGswRQIq6yWY4PLRjcYpy28ERBAwGJrle9X?=
 =?us-ascii?Q?ZTGcuU+K+3JyeqUs6CapOeW1V9h3todr75RMT24tcAS/svkVhS2lgKHhT+Xj?=
 =?us-ascii?Q?mHLRBgSgzw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 0mSdxU7jxwGNrODhj0URbJFcAUPlvvpT5ujB0K0pP0YXOET/+fh9+8rAafxxuqHGvXEDMpB4XGIPzF0MB5ggDrYkfml4erEc4FxlrmDWUI11ZvUTZYo6drnCyod/oUUiG5gX+D0BO169AbIaHsDkloBGJFYVzIqdM5bhXheC8Jbxe7NpgPBEhq7pIZUJ67eNcnPHIpjW2Xyr5hjkh0rDWGLKdfdfQkxgiJBX9OtlhSOnTd+fD64s2t23ZKBVLnv+jSAfSdUE7YFPqgAYUfa0ihF7ukkIHU8ukoMZOWgO2GrbFkXfXB3ODPHSwnf/DWrSGyHhm9R2vj8HvdRaKHhrfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb7167c-2d9a-4c7b-6589-08df0342ea65
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:23:24.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yH3ID9YrYwwrEVQxYzYbgH6gFGhrxYXsrYQ1jso4EWZdWw9WAkocZfbgDgP7lwUd/a3g+/5zkLOIW1YGH85VkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-OriginatorOrg: intel.com

On Tue, Aug 25, 2026 at 06:31:11AM -0700, Sean Christopherson wrote:
> On Tue, Aug 25, 2026, Yan Zhao wrote:
> > Add a warning on a !4K level to loudly flag the unexpected condition when
> > callers pass in a level > 4K before tdh_mem_page_aug() supports huge pages.
> > 
> > The warning makes the unexpected condition more obvious since the SEAMCALL
> > TDH_MEM_PAGE_AUG does not necessarily fail when the level is above 4K,
> > while tdh_mem_page_aug() only flushes the cache for a 4K page before huge
> > page support is added.
> 
> If the only problem is the lack of CLFLUSH coverage, why not simply fix the
> bug?  The changelog spends more effort justifying not fixing a bug than it would
> take to fix the bug.
Yes, the only missing piece for tdh_mem_page_aug() to work with huge pages
is the CLFLUSH coverage, which is exactly what's done in patch 1 [1] of the
TDX huge pages series.
(Note: [1]'s changelog is not well written. I've updated it in the internal
verion of TDX huge page v4 like this:

The SEAMCALL TDH_MEM_PAGE_AUG currently supports adding physical memory to       
the S-EPT up to 2MB in size. The wrapper already accepts and passes "level"      
to the SEAMCALL. The only missing piece for the wrapper to work with huge        
pages correctly is to invoke CLFLUSH on the full huge page range, which          
conservatively ensures that any dirty cache lines don't write back later         
and clobber TD memory. 
).


I should have inluded the justification for why not extending the CLFLUSH
coverage in this changelog.

So, would the following version look better?

Add a warning on a !4K level to loudly flag the unexpected condition when
callers pass in a level > 4K before tdh_mem_page_aug() supports huge pages.

The warning makes the unexpected condition more obvious since the SEAMCALL
TDH_MEM_PAGE_AUG does not necessarily fail when the level is above 4K,
while tdh_mem_page_aug() only flushes the cache for a 4K page before huge
page support is added.

Do not extend the CLFLUSH coverage to make tdh_mem_page_aug() work with
huge pages. Not only would this scatter huge page related changes across
multiple series, but it also makes little sense to have tdh_mem_page_aug()
alone work for huge pages without implementing its counterparts in the
unmapping and splitting paths.

Do not drop the "level" parameter instead, as it will be needed once huge
page support is added.

Do not use a stronger BUG_ON() because the cache flush is only needed when
the TDX module exposes a CLFLUSH_BEFORE_ALLOC bit, which has not yet been
observed in any TDX modules.

[1] https://lore.kernel.org/all/20260129011517.3545883-27-seanjc@google.com

