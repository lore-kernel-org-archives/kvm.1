Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793687461;
	b=Ik2HNvQiSOWdZYfxxx8tKZJbW0mdERBjI8OFn43wZ5xOqt3PoShPxtRb/HEyf+Vtg9Vs
	 GtScU1tsNwn3nbjrYC1divwyhxaVqr0JUbC6lgGn0w1LG2E429c2TGjpuzZSUO8mb6Zop
	 Lo5dUAhQLe2qG4Jf1wc4x7Gf0TzW/ZezNbjqPkrWCBvCfbTTxCSf/dRMb64gjP32CExgs
	 dx/IMtPOmBUguBKwpQ8wCpeEc6TyAQ2q6HXEs+V8RSttYThwzb+V7q+I8g/8CR9IGA6v0
	 l/5C7xDn8atzxPP4PlngB45tVCX65FabnqcIbfpPw07ytA2JJEtZXat2XYmdh5c5Onw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687461;
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
	bh=45l8P6tFk4BgFS7Ta/i9+TJqCt073V0MgDViP2MASLE=;
	b=MojRCizbtFjybHxvPilA/0H7FFZKJmpNX0vPQBYI8Sx+ygGRTQ72C2Lc3JsxQHR3oAz+
	 KY7ysW/ubzcdjKbUHYxAf4hyD/+n5DdqxAkWQ+MRdnwFwlHMTre1qITgMzhm3ZlTJI9K7
	 UkRVSCFoW+ijaSKb2B5zwOm8j2fvEa6skE4MhPJN5oJTckoyKCISWQ706vP31VCN00bcT
	 nh4K7j/LlKAASAbLBE5Ka/M5WKpuvRQot+tAcsrvlorZilex/1KLgLUv5TLa6ThduK5hj
	 dSj4BSqNWFC/k06VLAr4xVBXdakUcZ7huEmzv1s+RE9+kxzNVbCwb9wjx/sG7HCzJ2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f6fT8I9w;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76CA606A324;
	Tue,  3 Nov 2026 06:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E76CA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f6fT8I9w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793687459; x=1825223459;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nl1bi69whbR3wAZSX2YcH5RTZE8IV2Gwfy8qe6RF4/c=;
  b=f6fT8I9wvE7hp6ZVkYY8ioxbabB9QWBhwYQyg8m2oa2fgZg5x9Itafi8
   P1vXmExNagIDpK7HREGe/6S+14ylMHzrVba45y1IKZQC8YIXsFS+Zjdyc
   NvmL7h/TWIo+IGZY/PinxJZTn/qGCxsRFe0pn55Me/dBQHru0efntzPQi
   HcNFt4dL/drTFrtjMW6FwCv2m5ikLdhOmgB/MMMsBMJjsFcUxj4O2ECnq
   9xb9AUXBqpecUGIidBQBfQXbRNApcXY7u1RItZ7kewMKNd1kvhBWu6p7Z
   IWZcWEJnHBq+27E6N8Hk2X31GJS8H2Nh8v/qEmuxBHGXLDQtdS+hW07n5
   Q==;
X-CSE-ConnectionGUID: QnIMVaf1T5uTLhf8JxioNQ==
X-CSE-MsgGUID: ++nqCu/YQueZVQL+qT0IWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2503543"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2503543"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 22:30:58 -0800
X-CSE-ConnectionGUID: t+X7AwdgRxy05B4A79B7Ew==
X-CSE-MsgGUID: WyEmyScJRY6SwVwFZ2Zm+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6342233"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 22:30:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 22:30:57 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 22:30:57 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 22:30:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkW0/At+IBpro2nQU2FvzE95j3ZEYcn1P+SPc3+yTWb+Q7GuxklQE2ldqc/JHZxUbS7vUE+EYdALkUOonOVUHihMrh2m0S32YyDhdexez5JFFRUxoVXWYL1HlnAIY49NKD23NFzxSArOEpob2N2St6jUO3C7Ur6ftJHUon0nxBFnXjXuIsJ2fA7HYZKEC81FO3ZciG5AcNSJtqWhFr2ZVqAamnCl3MK2rDmp9UElHFaGlTrBYFeO/nDU7rP2R1LBR9w/9xLnEaI3E+KGSs2KrzegupcWbvgIVd2oZ+5P3iOFGwWsbuwHaYTGjNqNafaiiFOIA1hocp2CsnrIct0rlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45l8P6tFk4BgFS7Ta/i9+TJqCt073V0MgDViP2MASLE=;
 b=q/nf4fJhb3kQQesrfCHfxKWwjm8NYeyRs88sBqiJsoSgPxForvHIZbllWAjIVwzOx6dCEY5tEMvBoxAt0T9g6rNbSjfz92bJBRmW5IJ1kHKjtIw7Bp5KqCsHYh43uQ1KJtdzEBfyEXuM3LIjoH1MrsGSX3Qwb9pYHSRjjHOOz3YDsvBqZp6ym/RsQZi0Vioj6sE3D8f+llT6TXcFcO/3Mipq8cmznqIZK3divdRr5kfVfhgyhkWEr8PTJCoh7SLC/bbJmhqOdeUivfPa00ntDLCJuAs7fkeYRDchDEn49F+I65g0ORIe9ZaCGMry91yQ4DNDq9VCLsEucTxdlDo9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SA1PR11MB5873.namprd11.prod.outlook.com (2603:10b6:806:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:30:51 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:30:50 +0000
Date: Tue, 3 Nov 2026 14:30:38 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Van De Ven, Arjan"
	<arjan.van.de.ven@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v1 1/3] x86/virt/seamldr: Allocate 'struct
 seamldr_params' after image validation
Message-ID: <aul_jq5X63s7QnTS@intel.com>
References: <20261030085304.3886520-1-chao.gao@intel.com>
 <20261030085304.3886520-2-chao.gao@intel.com>
 <5397736259f9743da43ad41b2e2a995e6372f1f7.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5397736259f9743da43ad41b2e2a995e6372f1f7.camel@intel.com>
X-ClientProxiedBy: PS2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::23) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SA1PR11MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbdab49-a6cf-4ec4-c08c-08df39740099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|6133799003|18002099003|22082099003|10067099003|56012099006|261102123227099003|261009223027099003|261022105027099003|261022115727099003|261028144727099003|261021121427099003|261022075727099003|5023799004|11063799006|4143699003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: AUrf0gAEZFBkzNFsbafDnD5fGuoxmwL/C1WyXe0VYAz0+mJHnfKM5SpCzAlbP+9l2xD5cSc4b0GeDzaYfJ9P6edo0PfP9o57u/hrwnIMCt2p6Gyyz3sO1Tf8FoE4pfNPMmmeB1VkkoZpJ0REYDeqEaKcQYG3pfN6udNLFjDVEGJ0AGhASnmQqwmn0Fvl8YdXlLyM/kAt66FsCG3jd1yOZbiTpCYvgxtHiK2T8yatz7PwqpicWiBv7vBDRBImw0Rd63vtraiSQqhze9UpTHSWrQ179+GBfT5AQ8ZzkpIGOgtF9PWDXVlaWPubz0nzr5Mwqs0RzPGzj93vBpr4xAizH/SvTodNpfPz0R+QPzWdgYRsD8mJdXHO469scOTb7XLX2SzRf6bMiMUeCJjm4ss+oV6qNTa5g/zGy8IBu1k8cNMM1ilN8GDjeh+Ig7XWwhDknnk3F3FIU4ZIgWEc9mv9Y26FJy6tHaU0xqsReMLjiI4f/h5lFovpVyLYtBTPT7nwh9bUubw2VdH5NiapoF2lJN6mnXoFRihFBp6RKSEW9ru2dP22oz4QikKVdm38nHXDjbtme9fpQLjqyGYkHz/tIfN9uD5p+ZXcMOLFhV0Ge8DOATO4F3KbB8S7SsCyJ4NBkplVesAXAFU9bQXQRQC5wAjUCyeom+7j/i6o0uPGl0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(261102123227099003)(261009223027099003)(261022105027099003)(261022115727099003)(261028144727099003)(261021121427099003)(261022075727099003)(5023799004)(11063799006)(4143699003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2DZWYbbmz6HPr/eApbTk1DdBnDoXS0OTx4ato48Kpbg3Rk3ZNAHp7CBsPL6T?=
 =?us-ascii?Q?qXI0SELR9WcZYhYN6KK5XsgIb1IhT1sHXAw3JJAlY9r/cN6kaRr/AoKg1wGi?=
 =?us-ascii?Q?xpkOP6UUzw0LPe+E2vLkXDOJNgauKH7QUKVPAvyhI05qx0CQJ0H6rcr3B6yc?=
 =?us-ascii?Q?cFwOgPy7p46Kr+goOC/AjnVfI1qf9E6mJFyeICYgrx1nkxu/7GLvGzL9sGfH?=
 =?us-ascii?Q?UBLeJa17JoSyZZ77UlPqQWlA3VJ89OvmWzXEQvqkzkDDVUoWFqz+h1C/OEPF?=
 =?us-ascii?Q?HnKbDf5n9ONKTUDL3Q0JZnQkNMWcWyO0YiDbYK2Pgw13FyR9lfGDExAuhW7w?=
 =?us-ascii?Q?9biqMsFy92bT+IgK8vo4xalIznem7YZk2keXg3SOON5tJY84CC5i1n+WnJ+u?=
 =?us-ascii?Q?V1mKvOnHi+CGxMMJC/PowkFazVSDV1IWotTvfr+CPo+bT0yYPpzA3+2jiyM+?=
 =?us-ascii?Q?lq3rZZP5XmmXDXhgI0wQT8r0O+kzsAbftJs2DklpplQKhRWXX26xmMaQKnal?=
 =?us-ascii?Q?O56AKnvsR9Raey/3SAC57IbLAataR5n6ffcraWiBgVOtkiwaHh3qWaAOdu0B?=
 =?us-ascii?Q?QPswhDebMJmgVg50SjkzO9uf6aua+vFF7VE69LwM0N41Ug1yVntLc3frOQDL?=
 =?us-ascii?Q?/2InVmZX42/NQC+E/B6p7XaJOHzh+UIvXeK9qEJPEKv7fTWBgID6IDuzyQHP?=
 =?us-ascii?Q?Jsij03FZEjceuQV7t82fB4dTtOcGMN8H+gdAc/RJcG+Y4FUErONWbVrOHw+P?=
 =?us-ascii?Q?pQLEOvHLhUPHAl0ubSUqC3rqTILV83bNofwuiCFQn4xMX7+6lBuxVxVZ1fSY?=
 =?us-ascii?Q?ptSckQROVDuywNUutaJlVQoy09gI7x63AXrTnDcubqzsPp3f5DK2NZZHlMkt?=
 =?us-ascii?Q?qIWmPN0G5ItPfwfbtXc4mst61hoLCxvzwomiFpnY8s1dSDO3KtruUWrRbBBr?=
 =?us-ascii?Q?vHG+Li3POdZemd9fIAh0fGy1CThe0Q5QbYiahR7o8wQcvm1MAmP9vuktC6WH?=
 =?us-ascii?Q?5SAZqqFKRKk38m96H+WZqFMNNVhsOSm1XZ8SYTVpToSJ94LMmAwJE/oQBikE?=
 =?us-ascii?Q?VB7jSQfZU6+zTVE6E6uTQ2lVP/OLup7t+c889OvCisSt+JiWzTIzrflipybY?=
 =?us-ascii?Q?xt7b/kG8Kgha8F9a5LX5AaC2BXjPwe2ATKK4XbItpOKQJYMlEIlcvfGKI8CL?=
 =?us-ascii?Q?iwpUAxd7QpeRqFRRl0Ssr7HY3ukMjoMyhBl+CNyDeJnHUdfAf8U6KHHXF5VP?=
 =?us-ascii?Q?vQaB20c5EpVgyoDCaQx4//yQswlYJLg2YvtN4iVft38kmeXCYciGXO+gjvGp?=
 =?us-ascii?Q?yX1fqO+ZB0+cU+ytkoIWBhtAYO/SqPfgtIweVGOZXKOEPYS8XprQhTWsFUWa?=
 =?us-ascii?Q?2gT6s/A23GkopcJdmX6DgwRAnSTu0w1kswJ31uTT6t9eP/KXLeAIy8rUuHtB?=
 =?us-ascii?Q?BGjBYr5XqqS2VyR+TqWUiwO1X770We/jhkwOTV1sY9qLMPw84O6GLMJZDnmB?=
 =?us-ascii?Q?XSnt2br9+m92jVhV6jgnNIXTxUT524aMQnCaGUb8ALZ9VuwSIhYKhyCql85z?=
 =?us-ascii?Q?oF/yBRPi5VFNhveLxNxQa193Gy4h/taWjIHOlOTr+44hGgJ5Bw47oUtGtA/q?=
 =?us-ascii?Q?OyrGDz/NpTQ6rwE02eo51FMaA3nsRr/6TkV1uZ6a8RDcP2UF1cDr+Fo+DV1m?=
 =?us-ascii?Q?ePDNhUPjajwtBJVHzJwmCb1GkHoDcFjIkSZZOiu649YBa18gC/Gqku+j4BaJ?=
 =?us-ascii?Q?saI7+Vw2Nw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 1zLT9MUMwBD4feTeULwwJINZZ9NW5YkNnx2TRkdRsUJ3M6w3XCtDXstlORQjrH7Xjuzt1VzzWKavq/pXs4hRLEzXwnFnpVWMj9CBcq0XJ6Ucl53tU4uoGm4VRUuYrbXNmKXlxKf3Fb4e5iM7Tz70atPzKiNNr+6GXGawYifqIi23ZhkoefyHcwYVbHrLJ44MMDA9waEVKljE9Hp2qQ/W0gARb4suvhb1eCxvaj/uyFwnA/9qGd+RJLRgE1us4o/iAcr7xw6gJfCrusML55O+iS8AQj/an2Ih5+K5sDZHZkzm4Ph9PryJYrOlku8s3mHqdvJgGzKD95rdTIcEXNkZfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbdab49-a6cf-4ec4-c08c-08df39740099
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:30:50.2095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGSVh/yVb/Ijl4Wt1lD77s0p0FeqzzcGaFO6kU0Z+BMC+dCY8+xb3CQov6SovlvCpZrQ9yCsNyFjjjpO6L9mig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5873
X-OriginatorOrg: intel.com

On Tue, Nov 03, 2026 at 07:58:06AM +0800, Edgecombe, Rick P wrote:
>On Fri, 2026-10-30 at 01:52 -0700, Chao Gao wrote:
>> 'struct seamldr_params' is the in-memory ABI the kernel passes to P-SEAMLDR
>> to update the TDX module. It has a fixed size and is allocated before the
>> update image is validated.
>> 
>> To support larger TDX modules, the ABI was extended to let
>> 'struct seamldr_params' link to extra pages. The number of extra pages
>> depends on the module page count, which can be trusted only after the image
>> header is validated.
>> 
>> Move the allocation after the image validation in init_seamldr_params(),
>> so a later change can allocate 'struct seamldr_params' and the extra
>> pages as one buffer. Rename the function to build_seamldr_params() since
>> it now allocates and returns a buffer rather than filling in one the
>> caller provides.
>> 
>> No functional change intended.
>
>So we want to have the allocation happen after header->module_nr_pages is
>verified so we don't allocate some ridiculous size. And the verification
>currently happens all in one place. So move the allocation.
>
>Did you look at just moving the one header field check earlier? Wondering if it
>requires less churn.

I didn't. It works too, and we can drop this patch by doing the check in
alloc_seamldr_params() (added in patch 2) instead:

static struct seamldr_params *alloc_seamldr_params(u32 nr_module_pages)
{
	struct seamldr_params *params;
	u32 nr_chain_pages;
	u32 nr_direct;
	u64 *link;

+	if (nr_module_pages > SEAMLDR_MAX_NR_MODULE_PAGES)
+		return ERR_PTR(-EINVAL);
+
	/*
	 * Number of module pages that fit directly in
	 * module_pages_pa_list[]. Minus one as the last entry is
	 * reserved to point to the first chain page.
	 */
	nr_direct = SEAMLDR_NR_MODULE_PA_ENTRIES - 1;

My concern is that this spreads the header checks across two functions.
The churn is a one-time cost, while keeping all the checks in one place
helps readability for the long term. That said, I am fine with going
with less churn if you prefer.

>
>Hmm, also, this is an admin only thing right? What goes wrong if the admin user
>passes a huge value?

Right, it is admin only, and nothing too bad happens. A u32
module_nr_pages can ask for about 32GB of chain pages. Anything above
KMALLOC_MAX_SIZE (4MB) hits the WARN_ON_ONCE() in the page allocator,
taints the kernel and fails the update with -ENOMEM.

So it is not a serious problem. But relying on "it does not hurt" has a
cost of its own. Every reader has to work out why the unvalidated value
is safe to use. Using the value only after it is validated is more
straightforward.

>
>In any case, I think the log could be simpler and more plain while still
>explaining what is happening better.

If we keep this patch, how about:

  'struct seamldr_params' is the in-memory ABI passed to P-SEAMLDR to
  update the TDX module. It has a fixed size and is allocated before
  the update image header is validated.

  A later change will append a variable number of pages to the
  structure, sized by header->module_nr_pages. The allocation then
  needs to come after that field is checked, so that a bogus header
  cannot make the kernel attempt a huge allocation.

  All header checks are in one place. Move the allocation after them
  instead of splitting the module_nr_pages check out.

  Rename init_seamldr_params() to build_seamldr_params() since it now
  allocates and returns the structure rather than filling in one the
  caller provides.

  No functional change intended.
