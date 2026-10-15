Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87A45A284;
	Thu, 15 Oct 2026 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102129; cv=fail; b=P7TZllWzIaItCVJr00vZU4OShkPO35PguRdaDl7v+fIjztNLe872btJ/S3NGJfnD6ZFn9cUJnMBljOFQbyhoo1MC+O1j8SI47WFrzkV6aobdCaA5VJ4ceLJ1TR/BzCa3DR1MMmZyoQ9pScyR4xn1slI/ygeFQti09h1uTrmT8r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102129; c=relaxed/simple;
	bh=Io46RzmgLdcZ576h7n5ajqfvXYqUnDe8mtjyZjuh4/8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=meh7Kp3xrAFvE1+J6Z9k2SC/f9GEa5Nfqiv8NxEz+kDwOG9aLPYj9J620n19lILuNe/YRqXeLmaiqj6AxIm0ugFHHZTpA2XYC0jZKQ2yOZgqIbcwRwUP4EhWBRZ3DtcmGveroQ70xdPFWBtY1ltbh+ZwSfgjcr3DvcTk6Ldfpuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V838cy5k; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V838cy5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792102128; x=1823638128;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Io46RzmgLdcZ576h7n5ajqfvXYqUnDe8mtjyZjuh4/8=;
  b=V838cy5kwgZg+nTugu/5qPnc67AfaqrOePVV41k6PBYhKmJuXHa4wFFS
   sOoMX7eX8CS+GnDq6CYeiaT15WadcW2XNal+zu6P0P+rILAuH/X73Lvac
   L4/ewBtCyumb1nqMb+nE7s+E55Px8GiFgojRLibCpe9tcka7bH7ItGdV4
   SVM+ACr1Q3kKwOy6H9crQhtBEXycKphnuS0N3wv6Vn3EF5lMI3UshBO9F
   9eeolzXvpD74HCXo6pUi18glzxD2sCqden5VccHghZ0SOZor0EWJQ/fP2
   WQcqlEw6GN9LdI6EqGkbKM7+sFp2pvcFNFmQYT3iFC3rl252bp27gM4cw
   Q==;
X-CSE-ConnectionGUID: m139OobBQlmghbV7G+4XeQ==
X-CSE-MsgGUID: cZGmVYeKRmya54vzawDaJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="769897"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="769897"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 15:08:48 -0700
X-CSE-ConnectionGUID: GnDMUgKcRcyLFklrp0oldA==
X-CSE-MsgGUID: HgfqWvomSBy9Vwvx34E46w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1866594"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 15:08:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 15:08:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 15:08:46 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 15:08:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPWHLbuUxC+hJ2O/8mjCVm21qB663pKrvloC92nhBzmLuD3g6FDTlh8UfJtB3IGUaA/MX4PRqVRjAV0MuV4o95KYE3I615yTGh8nJs5sgHW+l1c1y6h0tt6OcrRVqfawIlsGtLxk74q9ZsTp5PKXEndNTbcF8w4hdxZQVe1tXw1JmvKBEVBx4qMnJNGcbyxTjZjZnBxAilOj+8+ocGrsRbCty/ehDtUhGnWfXs2KNmpNiEWtnLcn6A7zjB4yVK00WGZjklVVkNHOySRyEWQwWACpN5aPUA7XauHthr8YryaCK8Gv8vwKib4kRP5h6VBux46oAE0KMisIThTH8ySGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuivBKoebr5cFHbni6LbYJQpMX+0xMiokoS5dMMzcWg=;
 b=mQua8Lhe8CS9YIssw5/u3qwX6Ccwnen9BOLruS4Ix64gr1P5/52BBg0rFrUAkeb+dX8UHn0Xtz8E+buMsfLWaWfZ6lxtBGC1h6dE4oMd2i3e2cDr0EAM4h7ZvcTCJ3j5piWzILeTSSU73H5aEInbWZW2MoSh5w6IibW494Hv04LJZJ0tYwrWODwPcOD1v7QZn2x2cNMGegxSmB3izCsgvlOJLJcKAI5n3MDuIaSOAISLu6fkiG5kx/RTDo49Praye+w8sNphNVFJUbfAJzXmaVsiZ5kRsoJ2XAaPqF/BUjrpGO5O8Scj6stLq+CHwng7U5S5M0tEQDhOCoy0jjEYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB045191.namprd11.prod.outlook.com (2603:10b6:8:50b::20)
 by CY5PR11MB6535.namprd11.prod.outlook.com (2603:10b6:930:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 22:08:39 +0000
Received: from DS4PR11MB045191.namprd11.prod.outlook.com
 ([fe80::f07a:5bab:8057:4961]) by DS4PR11MB045191.namprd11.prod.outlook.com
 ([fe80::f07a:5bab:8057:4961%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 22:08:39 +0000
Date: Fri, 16 Oct 2026 00:08:36 +0200
From: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
To: Alex Williamson <alex@shazbot.org>
CC: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
	<kvm@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas
	<yishaih@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>, <intel-xe@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/xe: Add CRI and NVL device IDs
Message-ID: <atFNmPDkwgjpnAIh@nostramo>
References: <20261014131849.157593-2-satyanarayana.k.v.p@intel.com>
 <20261015142616.2811a3a7@shazbot.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015142616.2811a3a7@shazbot.org>
X-ClientProxiedBy: VIUP296CA0150.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34c::14) To DS4PR11MB045191.namprd11.prod.outlook.com
 (2603:10b6:8:50b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB045191:EE_|CY5PR11MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d6acbc-b5b3-4d4d-90d3-08df2b08dde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 1BUhjsSn/eOsBHIkMEwP6ib+TBOjl9/wp5f024ic+PXBlCngTs84Rwyni22HY4oHo//cn8iSmuV0zW5RGRvAIcHl2gEoO7DSOtLg9m0m/WHWphYsdLehtr4ZaNZ00nJxzJ6V51x6Uglnhj1RmPqzhCx3eG5TDGR4zXXsM3ghwXbLwgbQVQTOnx/bTYNxxK3lCcW7jJUacuNss2wLm35w9ruqxoouWQQGUzMAh2tIldywIWTBwzoruvtMPQ6VPX+BIjyC2XQNDX2MTUNoQ0sDliXEvUNkNliAMin4APsQWBcjiMohUcudfNUWzgqHQ/KPBn6am4yBrtVTXItMTvctrxUj3aumn/2E1ZvBaWuEd+ebhIfh+niljkzrLsOgBMNkqHnm8CNyAcYhm3mIGsrZLxxEH91snlEE26EsAhU7tykCCwqS6JV83ruHzbHjCDncMjmXxZ2R/pz76K8LPkDXuxtzTuVJM6NnuSvMg101IfNFf4Rys5eUPhG5AK1DhmuieXBLFZaoptRs1nIBsFlN/7Umn2NAf4gm8BFrX/cemMGJVR0fQ6d4OMKpevUUvO3msaw2Ujd4pOR/qZMhVYWn61IoLjUFHsVSts8nzI+LqOU2THuRSScyGrFAElcc7m4TpINspiDrknA1qMdshm8sT+5ksxCIScOi8fIhOMFy4oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR11MB045191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG5GVTh1VjdJWDFqUHduenFXaDk4UmtGamtFdzV4M0twZnNHRHU2aWtCOC83?=
 =?utf-8?B?QzQ1ZkRoV0Y4aks3ZE1VbGNHZEtKMjhDMWJFbmFnc3drWUgwendYKzhWSHlK?=
 =?utf-8?B?a3g5aFZDZURJYVRnc3VtdUhYL2NtR3M2WTREM3pEQVRDOWVJbjVaSFRUUnpP?=
 =?utf-8?B?b2RYdzR2YWZvMjR2NGFLbmM0Sk5GVEpJOENVQldvWXBGRmt5NDYzTnM2YWFN?=
 =?utf-8?B?OEs1NWlqNHFyQk5vZFJVZ3FDUTk2cWRJTXBHZHYvL3ZCMXlnT1ZRVmdPZlRv?=
 =?utf-8?B?L2lHdlRjcFRKaXVSSmd4UWxKRGhuVFE1c2lDaWZxbHE0aWYzc3VTanRxTkJu?=
 =?utf-8?B?SUtUNWo3amhJRENZajJMZDB5OHdLTzVKY1licXpESUEyQjRUeUlpSGpveGZT?=
 =?utf-8?B?WHlmSkVXeUxHR1JwUmhkL0NxcDdLbFdpcGRQUnJTM3NTdkY1K3lFSXU0MS82?=
 =?utf-8?B?eUJ4Y081WEZhUzB4YkhPQk1DL3dFNFJsOG1ZeXZZelV6Ti9iMk1VbCtzejlh?=
 =?utf-8?B?cEwramNiT1oydFdOY1BYMS84NHpaQ2p0dUN5ZUNvUXo0Y3prVUZXWk5yK3RS?=
 =?utf-8?B?Z0N1Tm9JM2dibXV2R05rLzZqN2Fpa3YvZE9rWGRnbmRIK0QrdjJOeHEzR09y?=
 =?utf-8?B?NXZyVnFrYjhMY1AwYmhNaGRzSGRLM1AwSEpBMzM3b2x0czAwY3BRb2hiRmNP?=
 =?utf-8?B?V092djZHUXh3ZmpGeXVNYlR4Z3hxNXJxaXhiNXcxclNtYk1ZQVV1SHpSQ3FT?=
 =?utf-8?B?VC9oanorNFRLaWxiOEZZOEkzNmVSd3BKNkVFRStVellqTHJEWmt3OGhzbHZo?=
 =?utf-8?B?N0hFdjl3WEc0dVBHMVZBeUpacUFpOVVLbWh0KzBMNDc4MG1SYWt4eWVta1lz?=
 =?utf-8?B?OGkydTd1ekRKcDYvRFBnaTBqQU1MNkVldGkrOFBTZWR3U0JrdnZ2L0poMWd5?=
 =?utf-8?B?SE9sZnpRN284cng5LzZFQVI5R2YzZUJsSk43TVVXak45OVlSMU9hdkdUQ1dy?=
 =?utf-8?B?WmpjVThBM253MHdFZlI1elJJS2FkUGZxejJPYXpSa1JrUWNRdENYdlR5aTZS?=
 =?utf-8?B?cVZEWTIwSWpNdWRQOHJJUzh3WnpRWnRKTGtwVHlCWm5FZnpZWGpJWDFjaGRN?=
 =?utf-8?B?UlhzL1drUzlBd0NKZW84QVUvN2xDOVR1S2hhNGpDK1RDUExOVnRBbWY4UnJP?=
 =?utf-8?B?ZHBXOUtIN3FwV25wbEVXcnoyWUhNdUp0VlkxaE9DNHRneGlvU3JwNGZyWWNj?=
 =?utf-8?B?eEtFcmNnbjFuS0ZXUkw4ZzRDd1EyWW8wMFZTOWFsS21kN2pMSHdqSjZTUElr?=
 =?utf-8?B?K3hOcjBKSUJXNHhpUi9RK2JGbWxZUnZpeE1qbXJWcWkzV2VJelVWMTc1dXdo?=
 =?utf-8?B?YnREZTErMTVWUUV1ME5TZGR4cFZ5SjZtcmlLNklQSUdnRi9wR2x4Mmx0eHhY?=
 =?utf-8?B?Tm5QSERGNFFoVlN4dnUrN3ZYTUgvRkxnSUFMSGpva0s4RVBrektwQXYzM3E0?=
 =?utf-8?B?b1FSaDRSQ1JRaVF0WFBKczVFcERxUzNEV1J3RHBIMXNhNGRNdGtkRGtlejBZ?=
 =?utf-8?B?QlV3QzhLSDU4QkdqaW5sdFFiTCsxMGw3dzN1R2hJRm5tS21OMkUyYmtwbVFx?=
 =?utf-8?B?TDljdWhiR0dTS014TjJVTG8rcjdzL1ZzZUZmQUgxcmV1NU5DZjJBM2ZBVXRy?=
 =?utf-8?B?NThYYnNJWHNWaGlDYmUzRDlpRzBKZVRhNEdVcHFiaUdMMklSTk95bEl3Und5?=
 =?utf-8?B?Z01ueHRFRjBSSEJTOThFWVVJOVQ2SlVzcU1aVnZYS1IrN3M2Q3EyU2F3MEJ6?=
 =?utf-8?B?OGF6SzlINXc3RmJncVVkaU16Z1gvOWhYMmoxNUFHY2NSMXpxVDZzUTVlRHFY?=
 =?utf-8?B?ZkdSc0pueElyUC9YMDRxbVVFcno3WmpFRS95SFRuNEkvY3VSNWF2MkxjMmtn?=
 =?utf-8?B?VEd4VG9RdDRNcUhXNHNVVi9FYnVwQUJEdDdxUFhjYnNYVDI4WHlRVkYzdFY1?=
 =?utf-8?B?SGdLTTh1VUZaZzRWdGpDd3VlYythSE5TL3k5ampvVldhbFJtREhiODFDUURU?=
 =?utf-8?B?aHE1OStVeEVnY3ZnVk5ZQ1NENk0xY0p1SE56T0NhanJtVU0zK05iU1ZmeVRh?=
 =?utf-8?B?RlFiMVRpSE1lN0pFbmFUZmF0Z2tyZmU2UVVhV0h1bnowdFRsRUxwbGI1ZEhE?=
 =?utf-8?B?N1lHU3pybEg4ampCTWpjdjI3c3RiNlF4ak1nSWMxSHhYNy9sVlRxa2FITjRC?=
 =?utf-8?B?cHRRZFFhRGVwRjBhd1BxMVlmZ3o2TUR0VWlweW1vQkNyb2x6Y0UxT0x3ZnZF?=
 =?utf-8?B?Z2R1R096ZVpEVXN6RngreU1adjAwVm9QOExySHUra2dqc2ZVdEZlZXVjZDBT?=
 =?utf-8?Q?7eaPdNpVxb8AosjY=3D?=
X-Exchange-RoutingPolicyChecked: fBfvbr2thel4PjRNvB1KrFB//JTrN+fi4Fi+br0NvCCCd+KXcbHabrbBdnl7hLyV6NZVnY6OxdlYVKfP/f5SPBmKt6j6f2hL1NTl9vh9CeFjLV9oZXCB/rreW2bdFf6SYbpk3ry+PMzqcojEA7CUcHAhGOlG+ZRqNMrZyekUT+rXGazg1HuebakSfVhmkIkqtX/leQe7824jA4glYVOicb9CXwsIFot6Z79KC//Lv+NBXl1sJOIkNz9G4eh4Lu8bktOquxWG9DaDNps7s4xrblqqx+JxE4InHJOLHnQjYRr7SCxnOiazE4jOb0B8N4vi9hl7lCiIhQGRCz9vHjD3tg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d6acbc-b5b3-4d4d-90d3-08df2b08dde5
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB045191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 22:08:39.3242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEwOvLSBHYtvVjLVTzObb5JbHNZc7D07XaoQkfefYu/TtBZwgrCPxv7S9OM7hpbODfb2RaEd4RMcfWZJt6fU2HIPPiWIrHP0azGXI1zyVUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6535
X-OriginatorOrg: intel.com

On Thu, Oct 15, 2026 at 02:26:16PM -0600, Alex Williamson wrote:
> On Wed, 14 Oct 2026 18:48:50 +0530
> Satyanarayana K V P <satyanarayana.k.v.p@intel.com> wrote:
> 
> > Crescent Island (CRI), Nova Lake-S (NVL-S) and Nova Lake-P (NVL-P)
> > support SR-IOV in the Xe driver. Add their PCI IDs to the xe-vfio-pci
> > device table, so that the generated vfio_pci module aliases allow
> > userspace to select this variant driver for their VFs.
> > 
> > Also reordered the table entries.
> > 
> > Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
> > Cc: Michał Winiarski <michal.winiarski@intel.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Yishai Hadas <yishaih@nvidia.com>
> > Cc: Shameer Kolothum <skolothumtho@nvidia.com>
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: kvm@vger.kernel.org
> > Cc: intel-xe@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/vfio/pci/xe/main.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
> > index cbff5af385ef..8f1237751d51 100644
> > --- a/drivers/vfio/pci/xe/main.c
> > +++ b/drivers/vfio/pci/xe/main.c
> > @@ -574,9 +574,12 @@ static void xe_vfio_pci_remove(struct pci_dev *pdev)
> >  }
> >  
> >  static const struct pci_device_id xe_vfio_pci_table[] = {
> > +	INTEL_BMG_IDS(INTEL_PCI_VFIO_DEVICE),
> > +	INTEL_CRI_IDS(INTEL_PCI_VFIO_DEVICE),
> > +	INTEL_NVLS_IDS(INTEL_PCI_VFIO_DEVICE),
> > +	INTEL_NVLP_IDS(INTEL_PCI_VFIO_DEVICE),
> >  	INTEL_PTL_IDS(INTEL_PCI_VFIO_DEVICE),
> >  	INTEL_WCL_IDS(INTEL_PCI_VFIO_DEVICE),
> > -	INTEL_BMG_IDS(INTEL_PCI_VFIO_DEVICE),
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(pci, xe_vfio_pci_table);
> 
> LGTM.  Michał?  Thanks,
> 
> Alex

Yeah,
Reviewed-by: Michał Winiarski <michal.winiarski@intel.com>

Thanks,
-Michał
