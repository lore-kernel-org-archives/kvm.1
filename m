Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037B3F4DF8
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724210; cv=fail; b=rxjQCVzXvVkAwNPxNUGW8lJtjV4ALxaGMpVY1LkgZqE2Ei/reJLvT3J9en5SygAK+j+gTTVN4jY/4n8XDzFOr4YpoJ3QEziEmilWg75FJFPX6Xl1iUKfrcXhdaoXxwGho+7AnSQBuptOdkpMe/U2JVwppuUQHV9vAb8HlNN5eYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724210; c=relaxed/simple;
	bh=U7nJrQTi13DsmfsUG71uhIhfWV7GTRYESO6ruQ+UMw8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gFwP2pelTb5U12OCGRBi9mUFWGDE0D5nGxUw3ycSbNJmMaSyINC8zXeoDZ6zqpn8hGuXHX4w5Zui4X4SXQju+JvAlJH6iIP1wV94CrIQ7GLF8A7va8VrhBpoEoA5sWVQcbJPL7X0Lu8MnPsRRoPuqpYULlJKN2MMF2G/jI96has=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1A/SHFy; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1A/SHFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789724208; x=1821260208;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=U7nJrQTi13DsmfsUG71uhIhfWV7GTRYESO6ruQ+UMw8=;
  b=V1A/SHFymT/6NI28YiRbXNRceQ3dhhTa/193abc3xKyQMnxg0eLW400j
   74OaKmuqoliHp20Yp0I4WDthWSnfXCqdScbzYHNfiLxwmvAoB4sXBuXK4
   qbOG67OV+osVuivDaycXvWkKbfdwvYXOa+WG3Zb82WgtidJ/F5SAUUkyp
   40Qke2dHiu3iYzl4u7VtWrGiNdqgeY7A44Kjkm4hyE2c96z/LHwczF+w1
   o1SsvQZVuMl5OATQFAjgX41mZq3ij0WiyR33g5l7jMZkwJHnqX5VVZ87w
   yjMGD2uMHLFFCuT4Kr++c5/KBUIfveiZHAjb2Y7Ii0MmwM8IgcFgmkezD
   A==;
X-CSE-ConnectionGUID: plD/Ic4eQ2WWRlbd+8VtpA==
X-CSE-MsgGUID: XCO6da0OT9Kd6HZY4EasFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89150382"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89150382"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:36:47 -0700
X-CSE-ConnectionGUID: ZjbcLf6hTIqekDfORXEMOw==
X-CSE-MsgGUID: zht1JqjlROiaIVgj4D6j+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270636404"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:36:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 02:36:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 02:36:44 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 02:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmccUtYLB1HUs3OJ+6vGfO1A0sdUBgQ37wELAgw+T76HOH7/FcxVr9c9znPfPY4DkjFbZAc57uQUsLvoSY2C1P3ImslowfkX5cAutPdt9By+XLM2b5ISs2FGHzNEauO2cQxYbXC/LH/ajpNE02EsNOMKDAjZTEd7wRF6nDxHr0NveSz70lzGF8LDngZLjd5nWX/VwVg2C3uC8cHBmFgIOR/TS9dyDe6EJAtB1o9GazeOMbGdlKtfK3z/NXPPFJqSbZFoOxMFkOUJu1qS/y8iNxwPBM6uiumHKAU64/fqChR6T7RHUh1Ii/op4v3ytPBnUZkuDA7ed//5Wy8Jd4YADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2SuiYY+hYxWw2i+NIp62UI7mBgCf7C4qD0986GOqFQ=;
 b=W5z0lEBF7ITESJ4hBBrpLC4I+vPQ4bQ43njQ27AukC3FxzmIHRYx865jjSbbJE2V+YRmZxke4vdXCadpUL1NBkS9UiHJ3MdHvlmdmQRMUIwQLkzHgHFE7DM6HN6aLRj4b3PbhCcvTiZ9V1o87LH6He7FQQJCiL1wjqxcMIi7A6ls7Bq4U76Ig2lkN0fmlrEcXt78ASNdBnqL2y9EexxDKjGInHgeo3IcVFO7W9V35ONQn7vHBuCkEL6FGxqKILQFBh1SIO2zyFf0TTOWatGbUAX1ffz8s3V+Bejb63IlF6Zq/Z+O52gnGZvBTATSVND0udxCW/kMZ6PfUwSaoK4dVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CY5PR11MB6342.namprd11.prod.outlook.com
 (2603:10b6:930:3d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 09:36:35 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 09:36:35 +0000
Date: Fri, 18 Sep 2026 02:36:29 -0700
From: Peter Fang <peter.fang@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
CC: <dave.hansen@linux.intel.com>, <rick.p.edgecombe@intel.com>,
	<xiaoyao.li@intel.com>, <linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH v2] x86/tdx: Harden exports
Message-ID: <aq0GHXV67ROAhILB@intel.com>
References: <20260917110714.1587301-1-nik.borisov@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917110714.1587301-1-nik.borisov@suse.com>
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|CY5PR11MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 161e94d9-5598-4ee7-46a3-08df156854c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Fuge3HQntYVlTgkG81790ktCFwi2np0hPH8uiogv0ayVMb8PZLFdeDCZOOcOcJOgj8mR0JN/5QMhhxkhYcme8vue1uW9pgANWnzq33IkL6wqGYW4FbYshuMf5KOrmTat4dLhbTh/vUGcZf3/1cVtWZSGN/coa58avd3OgdbigXNCmP6SdrzviALzEklXH7cPq+c4sEeorZutN0RCQnxudE23ZW+o4fvRQ2YndYJDGpcs4E3Wp6tyx25kKAfv8qRtiaY4QPpMehvSMN2FKJd+bdy9+M6OWHdaWIG4keAC3Ib5RUdK7GGaqUwScNMd8uo82CRjxQlqX7+aMwjkCv217LveFvM5efTh7tH+tuL6Az0ab//3RWsBvlVatPRediyyXg8Auu1d/sfma/wBIO0FiltrOhIZejFxz71vjlUYtoZRgZuNdGvvLL6tXjVTAlO2AddlxAwBdhEUQ1JzEHRgM/EnXsa9sftN03gWJLwlOPSTSkVpDbuzFQdaD8dcQfPzOjqkbfgPZhSy0KHh2lQ44N0EkoWTKuoA0G8w7vB8yiGt2MNnlLHGvEJ92K0P3F2/NODm+YdeeidAFgAuXNO4TMbFgng3R6OHtf1NY88ixbsc0wWd4V+YAw3ILITp6gbRL85vdEpilXA5RNZvf3RV3iSXjLfWyf2GadASFoWLP5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEV5bGt0S2J5VmY2UHE3Mm83cWpWaHpVQ2NjODFqVkJFbk44eEVhcGE2Ym4w?=
 =?utf-8?B?d1Q2aW5NbVdFMW9QUnZDbExCbWMxbG5PVW1CWnA0dEdSa2hMbHNmMmE3a0Mz?=
 =?utf-8?B?ZVNjazRjTU5Wa2hlSE5uZ0xnTFI4elV6eGQ3b2w2ZXJLMUpMcjB5TWdBZitp?=
 =?utf-8?B?Wi8vQTVVak9pN044S0VVSm1CUmo4dWtHVCtYQnZFNlpIWnNoN090aW5sTGpV?=
 =?utf-8?B?ZnMrek4wOVk2eXBxTCs0KzBtTlgweVZNdjFlZ0VsV01PdXp0WUd4YVBqY0Y1?=
 =?utf-8?B?cWRBY3ByN0IyK1VLN05XS2dnQ3dBdkVEeExEaDc3ZGFaOWdYQ0M4aUlwNEgx?=
 =?utf-8?B?NU9IVXhUcVpoMWNKYzBJVmxZcnBVS2txRVFFL3JDR0dWMVQvQnZxQjE3Nllp?=
 =?utf-8?B?cWdRa054Z3FTSWhkTXhmWmN2dzlFNnlNV2lPOXpoRUZDdm1TZzlOYXNlMVh0?=
 =?utf-8?B?L0FCemwxL1BYTlVvL3JMeFJKUWRQWVAvQnBEMGoxdm1oaHdUU21MOVF3bjVB?=
 =?utf-8?B?YWVrSmtBWWUxL05tcjRLMzNManRVSUZENWVCY2h1eGxtNEpSWnMxQ3BzWDVC?=
 =?utf-8?B?ZHppSFlzY2VlNTdlUnQ3eFVLTFhPdmNCSEgxZXl4YmZSNWhZSno2Y3kra1Zm?=
 =?utf-8?B?TmFreGF2bkVZRkI3MDlCY3FHNm80Ukh6Zjl5bGdqeENLZTR6ZGZFVEw3dnM2?=
 =?utf-8?B?U1E2Q2RZYnduazJSWnhOYk0xZnhUamZ6dzJVejRFbVdKY3JCQlcyVmlQS0Yy?=
 =?utf-8?B?aTRTTkpITjcxT0NlWEl6Y1RBYWFVNU1ranQzKzlsRlFjdWlLYWs2UVMwbmZM?=
 =?utf-8?B?dWVPY3lYK3FNazVmaFdSYkxSWUU2cmEvM0pyTWh4WGtOcXZkTlkyVU5yRUVD?=
 =?utf-8?B?bUdYbzhwMXZnU0pIOHNnNlVIUEtwYklKKyszWDJBNGRyV3lKMVJBd25zZGV2?=
 =?utf-8?B?L0QvdnFzMlQyZVNhenFNRTVXWi9uVFFrQkJyWmhqdkl6dHZwUXN3THY2b2I1?=
 =?utf-8?B?TUxtaFhmNzh0Wis2UFJzMU9zdmlzc1Fwak8xOEowYmUzV3hxQlNZbkJJNVJl?=
 =?utf-8?B?REhkZFd3QXErdUhvRGVMVE9KSjNhUWRvTlJFaHJmcEkrUVRhdFRHaWxEWWkz?=
 =?utf-8?B?S20xNzk1ZGZzb1pndThLejlLTWplYVBiUk9JZEg4eERUZlN6TmFLdzluRUZs?=
 =?utf-8?B?TlZTZ0RsdjNXVDRKbVhqNVl2RVhjM2w5WjhLQzdOQjluaGVVSkFHN015NGFI?=
 =?utf-8?B?S3RqdkZ1LzkvRmkrZWxSQm8wMDZ3RXNFLzFNMFZ4WCs2YkRrdUVsTkVZbHlZ?=
 =?utf-8?B?ajFaSUFodmhFSmVVbkF0QWNpYXB4dERSei9ZMEZuS2RFZ0wxcHpWQ3pkbXlU?=
 =?utf-8?B?MTBYS3VoME9qbzc4MFFrSlVzTFlHZFlTV1pqb28xa0kvMTIvdHljNEtiNVht?=
 =?utf-8?B?YUVGbFpWV0Z6cXExMzl3OWpsOGgyUDV5OTFiOG90WVpSMjMrWkN2aDkwZVA2?=
 =?utf-8?B?T0FWSFBKNC9iVlhjRjYrbWZTdkJPeU9vbDZBV2FsQ2NqZmxWSWJ6bllUYXAx?=
 =?utf-8?B?SHE5VElxa25vOGd4TkxKWTh4WjJ5THRyeVFxZlFSb241amYzTXk5ZVUyQmNa?=
 =?utf-8?B?Ums2alNIY3ZUVW1DS1NrcFpzSWRFMkc1VDRObjVGVXhvRzRRazQwQzdNWHNF?=
 =?utf-8?B?NXpVN0MyOG1RUlNmbEp3RkhlQlB1dXNnSUhRdnZUOEhFOHhJdDVocVBTRjFJ?=
 =?utf-8?B?c3RIeGJscWlZdlpZMlVVQXd3aWVXSDJkb3ZuZ2MvSTRjUjZBbFRuejBFNHA1?=
 =?utf-8?B?M3Yxam5jVWNQeTFvVElhei8vTVFrYWlhc1JMN0tmcHFDWDNCVjBuSDV0UUdD?=
 =?utf-8?B?N1RTZGhUaU5oc2o5d3NhRUFsdXNCSTdTbHUyY29IeW1jdERNb0V4WFY3SWkv?=
 =?utf-8?B?dXUzUTkxeE1pQ3lzdlBsUk54Y25ZNWhtcnRMdEt5VVovUkluQ0poZWpJSnlK?=
 =?utf-8?B?YjlOc1k0QnlIZkZESjFDZ0UyV1Z1N1NBQmkydVdHeDNxa2Ryc1A0cEtFUmRp?=
 =?utf-8?B?bXFyMmtNV0ZYa3lzV1A1VkxwTWhzMnpJUXNmbXJrOVcxSXdIMWpBMkQycDh5?=
 =?utf-8?B?YXBjeTAweFRqQnFPN056UlZBR0NwalVYT0xDa21qejhXZTVWc0lmdzgvQ3Fq?=
 =?utf-8?B?VlZvR28wRU11SXFtOW5iVlRvMStJZmJGVnNHZnZ2UTBLN2dsYWZxSTZYZCtW?=
 =?utf-8?B?ajA2KzRyNnRJYmJIMTdIejNNMmlOa0l1amJMMG1YVWw1VUdkNHdBZmdVSTdZ?=
 =?utf-8?B?RjNibktYVVZMQ2JGaHpJazV4anVuSlQxdkxBb05aN3dyTUZSbXR0Zz09?=
X-Exchange-RoutingPolicyChecked: XeevWZ0hUs0TYicTIK6krspVRswVPweIMugILKJ49Ibg5gYsbnv1njomqHd2mCb5AhJ+Tp08iuXw2weY534uaBPDuiW3WNYfzHDJ/D+6xmqQFKZDKYUwRcCAlHBQUfOBoSv3dYmHAtVoW7laN44CNyKC9jelx6HpNMLOOI8k720MG1fpzPgfSB6Bm455VKMwKnrKAmR88wj1gyYZGDnD6TNevUnb38YMOuGoEZ4oBgBtTW1zshiKYkUhRRlztkxkDeO+mOE09G3JdT3DeOSvjCmgJn4bAC8LoJsCVgK3IbxOpQYm/OKAtgorjZ9U2sNv1HbklBUnBhtl/rr9XCGlAA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 161e94d9-5598-4ee7-46a3-08df156854c0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:36:35.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47yVvnP/tRXKRlu3K0upioy97USNhc0VmaHSBxj3LjWb2sBSDcePjGeJtq7+LWKYitZueU0eVbmxRQzkZIbabw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6342
X-OriginatorOrg: intel.com

On Thu, Sep 17, 2026 at 02:07:14PM +0300, Nikolay Borisov wrote:
> tdx_* function aren't supposed to be used by the kernel at large, rather
> they are mostly used by KVM and a very small number of them are exposed
> via the tdx-guest/tdx-host drivers. Reflect this fact in their

"exposed via" sounds a bit off? Perhaps "exposed to"?

And this patch only touches functions exported to tdx-guest... In fact
tdx-host only uses functions from arch/x86/virt/vmx/tdx/ (guest code vs
host code). Maybe the log could be a bit more precise.

> EXPORT_SYMBOL* declarations.
> 
> Reported-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
> 
> V2:
>  * Drop the change to tdx_kvm_hypercall
> 
>  arch/x86/coco/tdx/tdx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
