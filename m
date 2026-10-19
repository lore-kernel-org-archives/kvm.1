Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792426622;
	b=nYuK9lXyAEI4P2SdCRBZ6r4IOdai7DHUvReqGlhjH7rIQHJ9qRfT85hJnZQBj0fKJAOs
	 /R9k9O5SEowGY6vXx6AD43RKVueDGVSn1ZEPgWWS54plRLul/5vNvIQQQdzuI8+F5yyTJ
	 0ZXvvrum5d4rGA1BycJS9nSJT1rwBFmbV29HB03tgd0a9MaEdYJ/Zds3HxsmCKauAkWDM
	 5kOx+X6hdGH/YwV+qADHtTmMKxozCGEHnA96U3ZmZuL1b/8M2eKGvMZZmaQRPzZl3jgAB
	 1BkpVWX9M2pCgWaZr1p8/rc44uZoOjIIoZkqRSIGvwNPRlH1+SI+MNGwTAPgHacrg3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426622;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=ED4Z1tjutcqWXLRf15vj3+isg/AYNyP61d7x5U98mIk=;
	b=axws4IvgCJayp5ZmEEQAKRrUGt9tWbdNG3t/BbU665Du7gO7/39/2Pz58VL0MwADL1Y4
	 i5raQoxlNQ9tw0bQIfvqetpvgfjS6bB7F1LUJccRWCjwVWy0Xxc6HWC3Mqgw8CYvs0J+Q
	 ONGxVYwJON+sPyquByxKqapj0LAhG9FduZceK6LiRpnm5r4+FZJ71QFCkCT82zZ1/u+SB
	 rvfxkF7evjIxYm51aIoii0nB3rkq0WXLynvyiZaF0YS8uLSbcfRrCYGF5ao41A1+Uf+uw
	 ivnoUuF+S5QuDJ0+5F6Z9HNULtLwuvrz+ewc/Xt1ThLcLT+oqTTRsX5kSOj7sQ2vqFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y6sj7HLY;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B1606A31C;
	Mon, 19 Oct 2026 16:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E5B1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y6sj7HLY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792426621; x=1823962621;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EvoD0i60hlN2ixLM/IzzOxpy4DF+kLOzDXYg85UoiF4=;
  b=Y6sj7HLYMSJkjiactQ2exVCjQNkc2nx93UyqXr0OWPT5dar1ptKuy2kD
   bykU2MBYXZas0ydHWQTexGN/UxbXuLVJgAxxIJEcOXnqxuTiaiX0FwGvx
   PjHsnHOFRs6KjO6Dyt83w+BxOuA/Kv2+22ani+8PYWWG5kndogouOtyxL
   P/SrXD52nl5yW0QK6GI10oNz7D5gI4sM4IZtjuUTpHQDCUpu+hK4R3utc
   gxipzDKMpLwxpwiEU07royxkGrUoTOONnFst3cGo/hU/b8x22wA1Hlc46
   ixPvpF+ZfDmisOMrV6Y72LApo0dLgYZ4Sth2KUrlfaFG1TfWWo2/pHSj0
   w==;
X-CSE-ConnectionGUID: 8kA8qcxZQn2XLTUnFotoqQ==
X-CSE-MsgGUID: Rnh+hJLhR22AhUpzjwjXdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1151888"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1151888"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:17:01 -0700
X-CSE-ConnectionGUID: gRzaI5xuTRu/rbdBtLhcSw==
X-CSE-MsgGUID: C22kqsQFTBmKgbxbqAcC0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2871472"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:16:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:16:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 09:16:58 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:16:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNN+eTzwLgA4NeTl/2792+TkxNbJrKAJhd9o/DOa4JNVYT6KvBDHE3el/xNBQmWPeCFxOBo+ErK3+hDJi0FaHpRcI5I7jZqPG1RCl5b6HIsb4y8BcAPQo6rSr4X+3lIHjzZ6MEoHg+2PJmFPwX53pOYq5TiSrDkj3h9j/T2o5wBlgvPm4paIhKmj3xXjgXRdT1F2NkS3PG642qW6zf8e1D+d5/ne3Co90DIkt0a72QVUI3YdSUaqui63+IY8+ogek66smtlRVf4iWXkare8alzYNPAVplp/FpCNTnjH21j7QfjbYsmbtFyegmSrcch4eCFxd2Qa9gouTXKCxNuq9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED4Z1tjutcqWXLRf15vj3+isg/AYNyP61d7x5U98mIk=;
 b=jCXzYB2BJ7igjF2AE88+rntCOVefhDNxk+1IscLpRxm8PZAHxZ2+qcQ7XNIsw4tRAyKhBRBz898ORdKUM0B18xcfBj4dOwOmZ/5tWvJFIrX+QBwfmDPgWtmMgYtxG3V3O4y4l4SPbH3+2ihoeC9BjGARwfq07wmTO+mUwZ7D6TIdT7eZtsO6UFlDuqiXIN7RM11we7z7ageAi1uamTw5reC5R7+VQnlIl4uTEJbIyhC4ScAswNp11L/1n0BYnO78Cnz5i9b6WCdWTdwJ51yaeLXVSxy/T2Xo5V1PQPAeJwwXgal/ku+mH08JwUFfKxaHWEDq8m5Dzt2KT5Gdv0gF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by SA1PR11MB8349.namprd11.prod.outlook.com (2603:10b6:806:383::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:16:52 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:16:52 +0000
Message-ID: <dde507b4-6592-4450-80c6-41af64c1796b@intel.com>
Date: Mon, 19 Oct 2026 09:16:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/18] x86/resctrl: Add PLZA configuration definitions
 and data structures
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <608876cedf5eece3f8b9297bcf21663a86a6380d.1790867441.git.babu.moger@amd.com>
 <bf4bd727-eac2-48ba-ad85-539a818524d6@intel.com>
 <c557ea83-11aa-4747-b305-93d554d3fbc4@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c557ea83-11aa-4747-b305-93d554d3fbc4@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:303:84::33) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|SA1PR11MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a88e47c-08f8-4dc1-6b12-08df2dfc62d0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|6133799003|18002099003|10067099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: OfdS8nnNFILipZUKRXQYQk2zaOHpn/kgZnMKDTnEphLPz8VfIGRXzaM/gRwcbpftm4IsGORZ+6E3X6/eJsgJbtBW5srgk4KtERigqveJqSF6/6gdJJLSoRWCrJKFEdyGI6SjtK/obSU5xda7TnUBkeXGxIu1WGtRpufOSeO91KjUr2C3MPg6ag0xiQJg70pDi+O41nwskIekD8HQurfJsA6s3pt8XbtsmeHvSpZTPg7AGlX5w/s4Mfd/HlvzSKLVl/QmX2Rv5OGI8JtbUAHKxtKhsCwJU2ip5gxZhUjC0re5J7xX2wuOWqraBMfoM/Oe6ua7aV3RhIe5BUrxdsYq7sKxMgHf/9C1N6nHyMSo5SMmJvoUOqv0lS64ZQm5AmdXIseD1OqVEJW3Bw85nodZSw4krwCWm8AItoahrY4eB7+WtxkSfVKYZO9oVFz47FVt6QH7KO1WgRPX+GU+JJo2Kb/Xqv7NDL68aGIe+r8RdvvyJx3z7MPOiUQFxK8kBlPavHw4d00dpJJfW0U/Fy00Cl+5kfOpuqpzjNOTQRoKcJDARrzoC0BvNGAEba620xh+1O53Q/vEJh/3IUOdwwK1u6OWuH7Bf8vVWLv2iZBp1MBwV7hhR5eLwLRZjwod6VZEDr9D+LuXV1o4enIS02aEVZazn0E/q84ZtyD9AchoVlo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZThrWUViUTlweEYxMHpySHVub1J3NktKWXFrYXpCME8rNG5UZDF1ODlBbHBi?=
 =?utf-8?B?Tm5KOVBvM1pkTmVvMUxFUVJSSlUvMGN4eStzVzNBeU9sNFdTRkdYVk1Wa3Zs?=
 =?utf-8?B?Sktvdk9PbWpENEM2T1BUa3JnZ1pQVHoyZHljOHJnY3ZBQ0hFQ3ZXNldMaFkx?=
 =?utf-8?B?MThES09LdFpRS2U5T1lKMTJFM1NrYVhUOE1pTjNaSlRjUU8vNFU1VGVUbXd6?=
 =?utf-8?B?Z1lXNW9JaURPWVgvKzZuaFMrSnF5bHdoUURzQVU1dkJwYmltODI4ekEwTWJ4?=
 =?utf-8?B?Z0pHYUxPa3lxeVltM1ViZ29hd2xhcHlRREdCZjZYRGVZem15NDJrbENDRzlh?=
 =?utf-8?B?UmI4THdtV2hKQnhvM0xlMU9RMGlRSVhNbTVuY0hnZkVWL0ZSRFZhUWhVZStv?=
 =?utf-8?B?VlVEQ3c2ek9DWHRWS1dEWXY4Zi84elUyTm02UU9UV256NnZiWlN5UHNoQ1Rj?=
 =?utf-8?B?VDA2ZnE0ZkEvQUtqUHZtbVFaeVRVTXhmNGpDbnQwbGVIbHg3bkkvZkZmcWV6?=
 =?utf-8?B?cDZDWWpxenBvMlRZMGM2dHhZMFBiZXVRVHMvYVQ3T2JueGJMeDlDOHg3eTdR?=
 =?utf-8?B?UkVzaklaSlZ1Q24rNkZTZjFaTStvUHpLeWxGQVJGU1lFSHhyQW1OMUcyV1hl?=
 =?utf-8?B?QndndGgxYUV0Z2xDd1JqbitsQm1VQXc4SG91b0EvQTdGTVBzbWhPckk3R0Ji?=
 =?utf-8?B?ekNzbWRVRUpVSm03MThVTE9YcWg5WklKT0V1VGRWMnRBK1ZkMHFNeVBBVnlm?=
 =?utf-8?B?M2pyWWR6aVhKZzZmSi83TzJxdXBOVUs1WU9YVzZYbEFEaHZjaGpNMlM5MzU0?=
 =?utf-8?B?NWlCVWZLeWdrZFRacTl6YldnVGRDREtiZ1BmM0d0VmNBd1luODRKS2R6eU1S?=
 =?utf-8?B?bUNaVU5vRHFOME0rbm5lVVJRT0RDenhCQmFEci90ZkQ0Nnh5bkJLcFU0OFdn?=
 =?utf-8?B?QWtiVXRMVFB5S0NNY2V6M0p2cHAySUFoUXhrU1JIQzFjUzNRM3h1NGZpd2lU?=
 =?utf-8?B?RklNRGlBVnRueStaNDByMTFFeXI4bGtoNlFFUmtXbzhaaVFBZFVhYm5tb25z?=
 =?utf-8?B?eWQvN1E0UzFwTmpKUU43UjNzOW5GWDIxSVc1cXJWOVhFdlN1amR1VmxrV3A2?=
 =?utf-8?B?QU5VZFJtb0dJcVI3cUtuWGllS3owaVoyUHRJOTZXdDVFWW5rdlFiTTNjUGZu?=
 =?utf-8?B?WDhQV1Uxa2Nwa05WK3dtTnZOVllTNmg3N3d5ZitqU2RYNE5RRUk3eFFTRDNi?=
 =?utf-8?B?QUJMZzBSWWVCd0NocDFZVjE0RnRneXZVSTF6eXA1ZThiTVZqSGRTeHQ5Q2pp?=
 =?utf-8?B?YnVkeWg0UG9RZXVSZUx6L00zVE8vS2RMMkY0WGVlcmNVUHZSZ2srd1ZZcUln?=
 =?utf-8?B?a3Z5SENTT2thN2FCRmJGd211VUJGaGFreE85cytIbjFoSG4wcHF1c2VabkZT?=
 =?utf-8?B?TlJtRC9sVG92dXdIYTAyWjZKTTluR2FmbU1xcWVwR0ZuT1JDUGdvZVBpbjNS?=
 =?utf-8?B?UVQvVk80d251Sm1XUlpkd1ZRUmZ2ZUc1ZFdaTWtCV2ZkQXlUTnZqRW9wMnRC?=
 =?utf-8?B?ZzdkWUpycUQ0YlNFWWQ2dWRLM3VtT214VVdZUU5LT0ZhTEhML3pCc3hQSjJD?=
 =?utf-8?B?YkU1YzE1aVNpWVZrUElib1lXSG9PR0xOMSs1MW93VE8zNWZSOEc3alhscnZo?=
 =?utf-8?B?eGtxWkFUZVNvc3dhL1JlbG5mWTA5anBTVlRicmRlTFNSUHNkeDlkRlpFa3Zy?=
 =?utf-8?B?cG8zeGpDR2wzZXFFOVlXaStPa3ZyYmh1MXlJTTQ1OWNNc2xob3ZxNG5XNlZ3?=
 =?utf-8?B?V3JYazZ1L2syYXd1ZVc4Y1ptaXZvekFwTU9jZEFrTmhZV1huUVMxa0VRUEhK?=
 =?utf-8?B?NE5GbmlMUWpFWXoyYjY5WHoza25xTk9RdjVhWk95RG9RZkVxTXVrOU11VmVQ?=
 =?utf-8?B?UWJVRFU0MU1mL0poT1BaL2NEYkI3YjR2d2o2WXBPMXhOZmZhbjBWRjBjYk14?=
 =?utf-8?B?Z2tZQUkrK0lWTzd5NFZMNnhLcWtac093dk1YdXo5aUx6QTVEaXZyUjAyME5x?=
 =?utf-8?B?VTBvYUdLNWVhQkk0cjhibm9jZ3RtZlkxQ1J3OXo2TmRoZElmZnVwZndXb3RQ?=
 =?utf-8?B?VU0vRUdldDNQQlUxNjNzZUUyTHl2bDc4Q3lMMWNsdlZxWFpuSlNSRzJxV01T?=
 =?utf-8?B?SGM1aDJzbkw1TG12VU9YemxZUlgwM1N0ekNnaVBpTlBtOUJkOHE4OUJVNmZn?=
 =?utf-8?B?RDB5Z1ViQllwRXJFcllTTFVFMU81bXVNSjU0aWtuSG9Fd1k4cnFwcUNoRU96?=
 =?utf-8?B?ajFCTjZiUDM2S281RTVDL0QwaXM0UmY0ZHJFVE1vR3ZWMlp4MnV5ZjFLa1hF?=
 =?utf-8?Q?bd+sXUDB0ftvF5Q8=3D?=
X-Exchange-RoutingPolicyChecked: LKfmPh/QbH2ROpoFa5X3Vk5XbXSqAPO2kHkJ9hN0xzdHzHrMlsRKWLTXqrbOzqh2dEOMUhy3QEUU56EeIP/RV8l9bxaKtxGLrv+PsJEIC1XUTnwu+SLGZiYQ12MKU6FRWEqV1rruxNbIhHf0QMSKd9lYPYJWHXDyXAOp8YItbRPm72C6zmD9fk1kPfF2kCqHXBjzW0oK6kQePKV+pjzvKcBZGtm2alg91NBr5hz4ejEtV/Xg1YJjImhVHaSTciZaNM1hasfP8V2rtDwBnAB0KyrTPDS7GFtpAlRlK8MU3dkEL7OE3te3GV9cM4VRe7WhlQangp5HVOgwPRQ7AHOHUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a88e47c-08f8-4dc1-6b12-08df2dfc62d0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:16:52.4959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz+bBfZ26t/IXbk+pw8LbMXRVZHHDeIJA5sAUA0/8BTOic/zQbDXr2wyvR13UlIQknqil5XlnF4d3KNCEK3v4+WxujZjJGefrd07sPgrJOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8349
X-OriginatorOrg: intel.com

Hi Babu,

On 10/15/26 4:07 PM, Babu Moger wrote:
> On 10/15/26 09:22, Reinette Chatre wrote:
>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>> Privilege Level Zero Association (PLZA) enables the kernel to switch to
>>> a different CLOSID and/or RMID than those used in user mode when entering
>>> kernel mode. CLOSID and RMID selection are independent and can be
>>> configured separately.
>>
>> That CLOSID and RMID are independent on x86 is clear to me. That they can be
>> configured separately is not clear to me in this context. What does this
>> "separate configuration" refer to? Looking at the later patches kernel
>> mode allocation and monitoring associations are always configured together
>> and written to same MSR at the same time?
> 
> 
> Good point. Its confusing.  What I meant is that allocation (CLOSID)
> and monitoring (RMID) associations are independent PLZA features and
> can be enabled independently in hardware. For example, a platform
> may enable kernel mode CLOSID association without enabling kernel
> mode RMID association, or vice versa.
> 
> Yes. The kernel interface configures both together because they are carried in the same IA32_PQR_ASSOC MSR update.
> 
> How about?
> 
> Privilege Level Zero Association (PLZA) enables the kernel to use a
> different CLOSID and/or RMID in kernel mode than in user mode.
> Allocation (CLOSID) and monitoring (RMID) associations are
> independent PLZA features and may be enabled independently by
> hardware.

Which CLOSID (MSR_IA32_PQR_PLZA_ASSOC.closid) and/or RMID (MSR_IA32_PQR_PLZA_ASSOC.rmid)
is used in kernel mode is different from whether the CLOSID (MSR_IA32_PQR_PLZA_ASSOC.closid_en)
and/or RMID (MSR_IA32_PQR_PLZA_ASSOC.rmid_en) is used in kernel mode.

This series uses the high level "allocation and monitoring association" term
interchangeably for both of these meanings and doing so causes confusion.

Please pick specific terms to refer to the CLOSID/RMID assigned to kernel mode vs
whether the CLOSID/RMID assignment is enabled and use it throughout the series.

Reinette
