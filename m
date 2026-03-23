Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E902C3BED59
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283909; cv=fail; b=as0UFuIs00vLSjQiuwGZqNsCPX61TUmNg08nd73p2brjp6ZfKu2XApAtFjBYZcJUeRffpyhskE5U1Si44WTeT2benS/Gk6xYScDsO5Ev/SKmlE/6HaGUaMcbwpaHLIP/p3GuNVbZGOMpk/XO6iwoZp3YHAptuzpZFA8quZauWzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283909; c=relaxed/simple;
	bh=gQKKAA25dgM+oP/+Iu/CBpOWAdt/+7oeQHUhWPIOhS4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FAIHQUhq4alJV0JXi8MzkRuYNczTPKLB6BrecVxcIQ9zc1s3ejfDvfNqV4SusZbkhEhcZWjRRXrY+lQqFfUtefx1Xl5TGmmzotCXBEK0aY5B9FVYeifx6qSuDxigNylX01ly1DBvu4jhA3uiF+iwhYWmnCBuk8p+nwt80ZUK9/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkLUQJao; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkLUQJao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774283907; x=1805819907;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gQKKAA25dgM+oP/+Iu/CBpOWAdt/+7oeQHUhWPIOhS4=;
  b=kkLUQJaoMgYruiXVReudl6JvAsPfampNqkqMMrAL6A17aHnvx5of4TDm
   VxFo2H8QktWmI1JXK0FVsgSy3IRuvI9HUlp8PbgdoLKsQwJ5MHTKJeJH1
   ouPn4c7HCDDWUlVjLT0Ligfd9mYjSwpQ4gpKVZbzdwiVfNv5NIL7DubIS
   1NkFGlSn3x3J73cjdLHx1ESN1/UbmA9fNg2QHXdq9KGWe4+sJQl8Y7a2o
   hI0hIAPZFT+RLMRpnk7b5jwEcMzskEenK2616D0LhKwfT/iGx2nW3vXQw
   HyBLgkHL/OtqXbWx3fQlUtiBknMz/lOYXf6oQ4cV/aTgl586kx8iIO8ti
   g==;
X-CSE-ConnectionGUID: aM44gqGqRRKl59wdhvOCTQ==
X-CSE-MsgGUID: JUfgOEAERmOUl3TMM52fIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="77897228"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="77897228"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 09:38:25 -0700
X-CSE-ConnectionGUID: VctzZZevTlC9SPY0jLviuQ==
X-CSE-MsgGUID: DEsrVv0wQpi8k7a0vMlsYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="221244312"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 09:38:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 09:38:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 09:38:24 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 09:38:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSvJQXOz1FZsBjPgH1rb+fezkm6nYvidNNJmDfYdBYoERw4lfewEgvM8kiFuwunGrsHjP/dsNQXlLufUYsbbGXiaFzoe3eBSELtN5QoWCY9hacjNgVJUysS63za+qdh1gFXEtIaMIFuEQ7ofCUpV1bsbpz3/7Hrf/Fz1/+yDHvlzBwgJj5Hf6PMdJuKHLctDz5Pv21jtYTjBQky6eylcMKvpiOMCy5XV0DOs/Mwi/pTN/RbTi2FQQlsitbHROtRvt5YhoUqCDPCReYdBK9SJQqxM/pnQYQzUu/wXYWQ2tFAliJ6IdKsam/RsyE2sZC320SRa2D4SIVNiGY2kVpGp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/PvZdbDppnDAZQdNUaXxrdLYsC23glqPcXLqkTZ4VQ=;
 b=gySZjGUs685xk+aWnloM/oW/ARCrD8r2PRKXy7e0DPN0rK4jb+rRh8JMLi6bJN0dTR52SOpzih7g+t0I+uLEEfqC3/rHLDBj2quqwhxT8xcHD24Acvziic1npn1rtJLpEFWd4ngYpRNScYxZyTjIfSqfH9M4Ah5fsfCN6qxmLyq2i0tIykeeVX+pMjcY90F2dWFyDWKTg+0mrMd8VarMdbK76XlL54HjfHzk5gDnf6uf+neJ+LgPeu4IfnEe8AYaQlY5gEdSZcR0bJzELddEmONXZvRTUCI72ACNyfBUKdj8dwjHeFTeLEHACJZ0qtvLDDwimQN/NwHHNbUH1SKVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13)
 by SJ5PPF162366726.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::813) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Mon, 23 Mar
 2026 16:38:22 +0000
Received: from DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac]) by DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 16:38:22 +0000
Date: Mon, 23 Mar 2026 17:38:17 +0100
From: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
To: Alex Williamson <alex@shazbot.org>
CC: =?utf-8?B?UGnDs3Jrb3dza2ks?= Piotr <piotr.piorkowski@intel.com>,
	<intel-xe@lists.freedesktop.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] vfio/xe: Notify PF about VF FLR in reset_prepare
Message-ID: <acFrehlp4nfI0I7O@nostramo>
References: <20260309152449.910636-1-piotr.piorkowski@intel.com>
 <20260309152449.910636-3-piotr.piorkowski@intel.com>
 <20260317084340.619c5fad@shazbot.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317084340.619c5fad@shazbot.org>
X-ClientProxiedBy: VI1P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::33) To DM4PR11MB8132.namprd11.prod.outlook.com
 (2603:10b6:8:17e::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB8132:EE_|SJ5PPF162366726:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f31d7cb-94b5-4f73-028f-08de88fa9867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: /T15h/V6Hj2MF7ZFwDNbMzveLqWvARNc3J5XNzvrOxKo7aIHfvk7m1TGm+7vIf53aO1YquYrffdPS/OsUAzqo7RlVnhVzJd5tGLNrm8+uZKOU9zFYoBBslTMUyE6l9ueuOfuwOVPhuouC7lBIwbnRD0AgaXQtCv9d1wHQncUFADaX2TR5cnEpLyMbXZbsawVJcAuwFzfP2hHzuy1WIaptTRe5HkcSFkWIx0Cd7Zq7Rr9C0csfATTCCZGRVVLn8kHi/dCUMSED8F3wT83PXrnieW3qXcrjbT2vRPimAjLlSJLisMqJy4kaELcT8nkNz7oK+y7o2PiwEbYWS9FBw2ikRaxq5jRTSyHSL3VwyPRf1s9hEsKYxHAAkfrg0VlK1TtUyXLZ8z4UDQSLQr2COvAxx3driq56lK4E/jpl8DjWEtjOBKt1tzSnADkqjjnxWhH8RdAJUNpdLho8nI+kt6MLiU3ISND3ogyAaolSbv+fsAlHjypZqk1KXrzagYBhi1X7mT0Db8mluRQd/Gb3dhv7JlEY09nhvNlRfFCrJA7Qb6uuugi3LJfxd300FTdPSIQltE2Yz0J0C5ys8VtQ2NjHLgPonN3g+SDEIe/fatyzyg7oh2SbJ7n5L4jt9efeHaAg1/rs87eHAtoP7wbdrGdH3LyupcYs28j09NLK5SetUPI2rhQFFSt/QRLJNt1o2Ram0onYGeeJC+PuKKcNKKLHgP5aK9fM5nwAA63xUso8MA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDh2aVFjZFIrdDNaVzJEMWdDNGdTdXlEWFh3ZE54SEhkZjNWQkNOcm92K2NI?=
 =?utf-8?B?cnJLVzUwN1pmVGd0Z1MyT3pQWEJqZDBWSk1HdjFsNThCU2Vsb0lVRVBCcFdh?=
 =?utf-8?B?OEw4bU40Z2Y5WHRveDRtY1FWRzAwdWMrMkF2RmU5WktKRDJHR0RJblVidTFT?=
 =?utf-8?B?QmlSSmpob0ZweFBFcUFIVjFkSGdnbFdwY0wzZEtydS9hS1NYUjVhbDJpTWhl?=
 =?utf-8?B?MytCYlUzdVhybldyYncrL3Baay9ibTBRclErQ3ZRNzk0akFxOUtWbDQ1UktG?=
 =?utf-8?B?NGJvaElmaHhvSkI2dVEzOC84YU9mZ29ENU1oMFBEa0xGOU9pY2d0dms3OC9H?=
 =?utf-8?B?dGo1dyt6Z3kySi9HSHZLT2p6SWMzK3c2cUxLQmNUMDd3dm4ydEhUc29TUlZX?=
 =?utf-8?B?YlEwRmN2NjdNbXdWeDJzWkU3QUFhdVdNUCtXaUo5TndyYWE5dkNiRGFDdFFF?=
 =?utf-8?B?MkowRVlRTlpudGs0SzhTaTVIWnVDa2FSbElZc1lQc1FUTHdMNjA2b2R5OTBH?=
 =?utf-8?B?L2ViMkJrZy9NbFh4ZDRiOXg3REo3ZzdnOEJ6OFJrRmpSdW0xcFk4VXFXZ2d5?=
 =?utf-8?B?T1k4YmQ2cmhpNzlBeExlNzhSeEcxYUtQMWJNMTBrZGxCM1FxZVl5MEdrOVdZ?=
 =?utf-8?B?d1p3Z1BVL3N3MFJyQVRQUUd3Nmw5T2NGQWZKMnplWVArS2o5TWlqRGlNdGc0?=
 =?utf-8?B?T1dML1l5M1praDI0MDI1SGlHSnAwU1JyQkpJREFSZHFZbWpjRk9KZG1sekNt?=
 =?utf-8?B?YUg4OVlxVUF4R2cyZHRvcUs2SnllemxPcTVjVFRLSmxDdE5CQ1h3WUFXR25J?=
 =?utf-8?B?SEoxSk5qVkpJTkhmZlJ1ZnlxeS9iMnhFMlFIaHZsakdvZFlabzZ0SWJHYk1w?=
 =?utf-8?B?eHIzUGh1UmJJcXpLd1B5RkVGdUJpZzkrdkdrZzRGWWZGL3hKUStZUHdnREs5?=
 =?utf-8?B?YjFzeUtKemFPaHJpYzB5S3dCb1JVNGNKeHdpWDZHenBjWEd3VUtCalVlVStH?=
 =?utf-8?B?M0U5OUVFbDdmVmREUnI1M0Era0dwMGRTN3dMcXFtZCs2S1hpMXhKckxsVkph?=
 =?utf-8?B?U2ZuVWxyWEJmbEFoS1E1MGNNM0hVTGl5V3F6T1NhVk5nYjdveHhZTFU0ZXJy?=
 =?utf-8?B?a3dYY3hoY08zQmY4alU2a2VNN0dHVk1POTNkNjVPck1qTmFtaEtsRnJNd0hq?=
 =?utf-8?B?WHdpaEdoNGhOUmJoNEp6bTJYZ0RRbnVRRVlDQXNESkxJazhBSGR2SVY1WDVp?=
 =?utf-8?B?eGRsc1FjSDhKRHN5cVRMZWdqOHppdGxud1BXNE5jczVZbU1aSzU2L3lINXZ6?=
 =?utf-8?B?L1BKckwvR29xVXVVWVZKRXFmYUJuRWNrWmthZXZWSElNS1d6YTVaaFprTkl5?=
 =?utf-8?B?VGVIWEJRUzRKVnVIaDc3a1ltQ2dyWGhrajJOSGZ4UDdENmdmUzgrWnNaL1lx?=
 =?utf-8?B?ZUNjK2p3dkE1SS9zWVllU0ljVVFCV3RyYVYwbERkY1c0WXFjWERBaGgveXVz?=
 =?utf-8?B?Rm9VbjN3OFFyOXBxV0F1aFVLbTZ4Y0xFeFJFTUcrUFFtUVBSNEVXV25pNVo5?=
 =?utf-8?B?dk9WaHdDL0lINzlCREV2U2pmVmsvYUR1NVd0a2x4cGwwR3h6TmdIeTZCa0N1?=
 =?utf-8?B?MG9TalZjY0VFTTBlY0RQU2NrQWtTcXFWRjBwSkM4V2w3Tk1RbnlNRWVIblVH?=
 =?utf-8?B?Y2U5bXBRMjl0bHp0dmZZVWIxd1pNRjNVV2NndHVlWnEyWDRFN2kxcm1QYVZ2?=
 =?utf-8?B?eE9jMkdueTFxT2R5YVUwK0VMQ3F4UWFOV0MxMGlLZkNiQ3VSUHRkdTlscHRu?=
 =?utf-8?B?NWRaRG5WOUMyM1RmRzFMUWZjN3RaMi9YbnBDYnJBdTRmeUdCaVcwRCswSnFn?=
 =?utf-8?B?bk0wQVNBUTArbVByUHRMWEZmS1M5NEdLc0gzb2pmVER6Tk5TUmgrdUhkZzhX?=
 =?utf-8?B?MFN0OXR4MjRjL3d1K2FTeHYveWl3OXMwbzBmODZNalo3UWtNcHgwKzIyaG0w?=
 =?utf-8?B?d01CRFIxckFwYmdHQTQ0NXpoRkNBYSs3cmpaVTBOVy9VRkg4N0JCelJQZHF2?=
 =?utf-8?B?Sm1zZHFGMFZSN1Z5dTlQM3VveWd4VmkzN3BObGxmVXhkS0NxUUtvM0E0ZlJh?=
 =?utf-8?B?TFduVXJCak9PV0pIbWh2enJwVlRjMlJncWNOZnZnc2VWVHdqcFg3UkQ3bitz?=
 =?utf-8?B?cHZ4YmJ3U1dhNWNWYTMzNlFjMzdaZHY1VDI1b1EzUUtKZ3Z5eWxQNVpFQlZX?=
 =?utf-8?B?S2VaMTltQUhMbENRcCtRbjRHbkw2WDlPOGN2ZWJVb1VhelpoYWtpOHVjTkxl?=
 =?utf-8?B?REsrTklNZ0sydW9jcGxQNkk5VmdHRFRMOEx4dENXSk9RdVFveVlOR0xRS0d1?=
 =?utf-8?Q?WSAYfkQMt1EH8AMs=3D?=
X-Exchange-RoutingPolicyChecked: lpV3NUnTghOqiYZPtUNpk8gwxHI/6ePGGJwVAm26QU1pb1E3cWKoPNJv9YMMbzVoduS7X6HenUNEw3l5CxQg56+S16CDyvpjuETo88PqV2Ni9f1vPSRSPpSzDMu4CXrIPlPuDcG6yqPz28ET1K40EMvenKwr1TNWRhVEgh1RCgQUqWFupky0C+XoRyf6DfsnlBFg0VGh9YVYgeuHcO63AM5sico7KfyPE68e4JYBktjNFMTjxAdNZ07OL7nFdHcHlMJF4tv410mod5ViprbYLMKvTTBj93LzYxPHShZOKLxE0MmEnr/hE9sAqEj77Hi+tMEsDrM+ksvj5o25SVBAYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f31d7cb-94b5-4f73-028f-08de88fa9867
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8132.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 16:38:22.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VC8Q7Axh/W8IzzWRwJUxlVjrfleprE5HQgLCQWiOqKCgpvBC+uAdBDC6t2JHAo++MnQrDrvr4dmoEe91UO1iJxZcDifjggfh0/TaF3ojelw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF162366726
X-OriginatorOrg: intel.com

On Tue, Mar 17, 2026 at 08:43:40AM -0600, Alex Williamson wrote:
> On Mon, 9 Mar 2026 16:24:49 +0100
> "Piórkowski, Piotr" <piotr.piorkowski@intel.com> wrote:
> 
> > From: Piotr Piórkowski <piotr.piorkowski@intel.com>
> > 
> > Hook into the PCI error handler reset_prepare() callback to notify
> > the PF about an upcoming VF FLR before reset_done() is executed.
> > This enables early FLR_PREPARE signaling and ensures that the PF is
> > aware of the reset before the completion wait begins.
> > 
> > Signed-off-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
> > Cc: Michał Winiarski <michal.winiarski@intel.com>
> > ---
> >  drivers/vfio/pci/xe/main.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
> > index fff95b2d5dde..88acfcf840fc 100644
> > --- a/drivers/vfio/pci/xe/main.c
> > +++ b/drivers/vfio/pci/xe/main.c
> > @@ -85,6 +85,19 @@ static void xe_vfio_pci_state_mutex_unlock(struct xe_vfio_pci_core_device *xe_vd
> >  	spin_unlock(&xe_vdev->reset_lock);
> >  }
> >  
> > +static void xe_vfio_pci_reset_prepare(struct pci_dev *pdev)
> > +{
> > +	struct xe_vfio_pci_core_device *xe_vdev = pci_get_drvdata(pdev);
> > +	int ret;
> > +
> > +	if (!pdev->is_virtfn)
> > +		return;
> > +
> > +	ret = xe_sriov_vfio_flr_prepare(xe_vdev->xe, xe_vdev->vfid);
> > +	if (ret)
> > +		dev_err(&pdev->dev, "Failed to prepare FLR: %d\n", ret);
> > +}
> > +
> >  static void xe_vfio_pci_reset_done(struct pci_dev *pdev)
> >  {
> >  	struct xe_vfio_pci_core_device *xe_vdev = pci_get_drvdata(pdev);
> > @@ -127,6 +140,7 @@ static void xe_vfio_pci_reset_done(struct pci_dev *pdev)
> >  }
> >  
> >  static const struct pci_error_handlers xe_vfio_pci_err_handlers = {
> > +	.reset_prepare = xe_vfio_pci_reset_prepare,
> >  	.reset_done = xe_vfio_pci_reset_done,
> >  	.error_detected = vfio_pci_core_aer_err_detected,
> >  };
> 
> Looks ok to me, should really have Michał's ack as well.  Will this go
> in through drm?
> 
> Reviewed-by: Alex Williamson <alex@shazbot.org>

Reviewed-by: Michał Winiarski <michal.winiarski@intel.com>

And yes, we can take it through DRM.

Thanks,
-Michał
