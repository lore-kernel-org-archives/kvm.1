Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA02E717B;
	Mon, 12 Oct 2026 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822981; cv=fail; b=DLNdohEuM0pIvMRXh6Lr5D1J719hsZgZIZc337Y58B0kr2dji/hM2aGo5UwxUeeGfxlDxSecuW+HmRIswFPDWe2hUzma1Hm6ur1NqkZJkWvgNguJ9qIAOWey6Nnuzp7/oIcdcoGHNieZZm0zSBBoTt55rb6oi3yKAx0UYQKMPC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822981; c=relaxed/simple;
	bh=ogWBjU7fyulgZGVItkFTzuaY5Df+dG08s5xZrK4JqWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQTvEuDFRIvMmmpkIGroKRJ5NAJmenYgdQKjNfXI6SrDvJ3C/bCtmoz3YpD7LlJAzH0q6rKqvXo0l57s08GIaPFPD3A7Xwh+dNuC3VJYeua8DVyYOZiHWIokqW9PhAbRKqxEqaQ1l0o8jogBeeiFyho9yN1kcs1+ZY1VDX0Ze3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWSupCbb; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWSupCbb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791822979; x=1823358979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ogWBjU7fyulgZGVItkFTzuaY5Df+dG08s5xZrK4JqWY=;
  b=IWSupCbbfTLiHmABMaO4gbubfSKhQv4m6CBHq823JWWFESPeityQcDD7
   y5iCD4jQy4yoEVQTsMdfE9QlpU5j0Nw3f6POrBHiyvG0fgR757Dhh7dSa
   TOzRsb31Kq7YJUaJ6uoExq3sxuXPl1X+69Rkumtg9/LT28EW1j4iZHG9h
   skU1X1dDt/pkzSN1gvRWKEMjlhRlvIDQG3sZE99yGLnQEpbiLUPagLBMT
   1v4wQTftR6dJYfP5+9M/WuIulCtKx+z5cb1DMLCZE0EHv2A16f7MFj3UJ
   aVtZagIVs6/TlSTlVeL6eRKeBCmAZkitpO/ww4fqoZ0aE3oQ2TTnI4yIg
   Q==;
X-CSE-ConnectionGUID: pNLItSVNSym7/TdCdf+gCg==
X-CSE-MsgGUID: nu8+EGadSReFRal/deFHug==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="430926"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="430926"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:36:18 -0700
X-CSE-ConnectionGUID: TLB5Glu2SJeaMqlKQhrc6w==
X-CSE-MsgGUID: DnICDZofQKmEYk2hq6IZlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1129713"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:36:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:36:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 09:36:17 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:36:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyZJNQv1dpaGPDmRnVPdFJZYdxKc+q0TqAdbMpXB1z5ULU/7Iohj1I9FlY+UIi1HSttMOaYXYxgOKiUr4ORr/WFxze3dEueXdK+esL9EB8ZEaRAsHKXQxtHCjGhY/Q+FavsffzFAZMMn+U5/hzhERLpyfMvx6a53k7XaR09Z1nJ7hpq3Wq5FyvmLin7AgGVUMCJ85YcnrOsPgR+yapb+eBKkFMxY8bnb6FibpPOxYwXZLArvWqcNpmMQGCibM437glydzczWgFFFNptTQDu1lMkazl9nOw92blpNO3HGrjVxb8QM1U7tuQv2isNGkRo04yHZGCfWL5MpbQZ7qFlPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogWBjU7fyulgZGVItkFTzuaY5Df+dG08s5xZrK4JqWY=;
 b=jqbFiY5wgWWUj+fhFW6utp3vQ2KFKlnSe596YQSl+bPI8mDC7pfNII7Wqcah5YX5XihCsBuFhzjnedfhCnJUrO59B3xZA/8K2BwfbpQXGQkUZkXnyHox8UlP7JszaBNWxcsudZ9r/bNUps642G0w64NNsLZjFG82eWIV4yUQ/jNlHGuu7zfpVQv6aVOzsZEOgR0wX9Nfx3rV30sntY424giC/YGDY26TiM/QCYvjRLiUm2CSDbU0hIjMvAb27X+KSo3y4/q/RA7XV7YcB6xR9v3oohAGenbryDCyQp7UP43+XJ+ylEYukCUyTeMvUxTl+kc/NsI3N1DDrL8OZ8WPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LV0PR11MB9815.namprd11.prod.outlook.com (2603:10b6:408:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 16:36:14 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 16:36:13 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Topic: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Index: AQHdTylT2fDCHY1RikeRNXt5wj90e7byvXkAgAApaACAAhZUAIAA2vcAgAB1o4CAA+N3gA==
Date: Mon, 12 Oct 2026 16:36:13 +0000
Message-ID: <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091035.15599-1-yan.y.zhao@intel.com>
	 <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
	 <e126bda86263fc4d6af53112eec01a95da48570f.camel@intel.com>
	 <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
	 <594befb577b9142dc0c90b7be5bb65888a3a2523.camel@intel.com>
	 <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
In-Reply-To: <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LV0PR11MB9815:EE_
x-ms-office365-filtering-correlation-id: 660010e9-cf5f-4660-c94e-08df287eee3f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|4143699003|11063799006|38070700021|56012099006|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: +Q5PCSE8X0/lYU3xfO0Mv/JTxW2oweONmIDcjVGA6D4pwZ7PbC6nH0hRRUsU+8A+5bwlJNSCawOeFX+8o6uIPaeN3rcF8CGXoR69CJBoghpKp8i++5pYYPlMtimFgZEDPZ84esuPFylUGworzLxf4n5/1+T9BT72xnAu6NWAlPbTKUdYncXu55M3ieiJjr1ebiy23KJPyrdYEzGJ4F+PgHm4JCCQbQN4Z/cZLRcQNhgRJ0PgaVY+JDETAkoUIzYhMVvXU7XL2/PWzDY+uYu6FOxRDGCs8CqBr5ARY/eo2MkHakLHM5CuCUa6kt1N6NuAla2+eKRRXlaXqgvhgbicm9kHup24L6canMlObFit0yHcdha6Za+3r7e+WadGxm43VAreZr3uqMkgc+ATHIOPuFhicTZ59e9Jp1Y/Er9usx1uyb0F2K+TD33J2gNlFqSWXudIuB9adWSQxIs2uDY2+K/gTz73n1kBCGkRxBbsd5GJ5EK6mwt8gHeDth2YVLxP1KP+cNqN50SBkEd06niU1USGafsAj+q9MAHPWwbyYXIjAlLlKTcJ5XgBJ/zvUKIlW4obK7pOV3Kue3tVrLMx/VnOAaP7JOdzruM84X2ld1WoA5Sd6v9Dbfwr6tCBZkdvt8GUOrBjN1jP1vJ5fEvF0eLW/Pbo1c3enyWslvlOcLqsClkH0TO11LpSVCNLRyIGYLT89DfMgq7H+y9dMk/nZOdNUkD8s/lh2PXaDwcDtW8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(4143699003)(11063799006)(38070700021)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTBvalBTcHN0RVY0bEF3aDJLTGY3VzBrNU92RHN2SWNtRFk1YnVOb1ppQmlh?=
 =?utf-8?B?eG1PWFVTeHdNcXVrYldYWVV2K0RqYjIxWFBXN0FVQ0tLNE5HM3hTRzRNSUQ1?=
 =?utf-8?B?Y3pLUzllK29tN24wdm9WbDdacGJ0RzZaU3RPd3NMcjkxMFJtRlIrR3BNSUdF?=
 =?utf-8?B?YjgxamhKdHhwd0hBMGFZMWV6d3Z1cHlxc1AxeCt2U0JxNmdaOFVRc1RjMDFw?=
 =?utf-8?B?T2FqWHVQYnFFOTVRaGdFam5aYkZBa1hRaU8rc3doZHhabkY3M3NvQzZ4dTIz?=
 =?utf-8?B?QjlFcVI5eU5POXhhSW8xWjBRcCtEQ0tCQ3dicmJrVXgrclJROHlaeFlLTkMv?=
 =?utf-8?B?ejM2bUZtZVpuZmJYTGJEZkNXVnppYVhFQmQ0ZVJiQlVSNjZCZVBXNGg3NU9x?=
 =?utf-8?B?KzZCdnJBOUk5TzV2azFyRlpqQUxmYlVuT3c0RTVSa2hQZ3o3cm5WOTdtN0lQ?=
 =?utf-8?B?TnNwSHNJYmQxRnkyeHdpTXJpbENIeFNFamJEZFVuNFc5a2dLdXlkUHlOSFJm?=
 =?utf-8?B?WWFMQlNwb2VGRnVNMmtNS0dLWWl2clg5U2w1ajlqMVB6N2xWdkMrUW1WYU1X?=
 =?utf-8?B?WEJ1Nnhnc0hrdUhnck9HM0owb2I5TUxiOWtjaGhTdjB6TlJzZWF2Uyt1dE5C?=
 =?utf-8?B?Vi9zYUhKUzhRSS9UMHpwUEh4dWU2TWRtVG9NRzU3QXo4OFkzbmpJcGVOdE1n?=
 =?utf-8?B?UGdIclY3aktCUU1FUXA4c25JZUdISk9OMlJXZVFEZUtVZy90UWNoTEp6bGQw?=
 =?utf-8?B?TGdOOFVOOWNHRU95UnRQREpFSTMvSExkQk9aM2dQbHFFbjZabVVLNU5GeGM4?=
 =?utf-8?B?OWVuNTJOZ3RxMU9GWDdNNVB5UHNROXVyc2dUSms1d1BLZXdWQit4U09NSmVj?=
 =?utf-8?B?eWFqa0dvK3diRzlXZVk2UG1QcG82NGQzSDZmQkxlWWQyYm10eFdjQmpPMUNm?=
 =?utf-8?B?c2d5ZC9oK1orcGZLRXpQUkJ6RWJJQVFZa21vdFFleDI5dTVGQTF6WTdZK2wx?=
 =?utf-8?B?dWJvaGo3ZjFyMmZ1NHJQNDdNUG9zWDRMaWl3TWcxVjI4NUVxOVMzdnh0LzRt?=
 =?utf-8?B?ZDZBY2FHU0FSdm5PWnJKbHZVSVcvaENRcUsvaTdtTnJVMlREcFBpMGtiLzdp?=
 =?utf-8?B?cm5XYXd5eUxOd0p3TG40cmRzcUN3M3RQYzNSNTloanNkY0NKMG9RMWI3Q0l2?=
 =?utf-8?B?eE52RksxQUVnaU9NR1FnbFBTWFRBdUZkZVBWTVpSbCtxUVFya3h6am83emUw?=
 =?utf-8?B?UTdubDBlNnRCOHUrY1MrR2hwMlBuV0J4SHNyZjJibGlDNDlLcnE4cDlZN1pl?=
 =?utf-8?B?T1JHb204UzFvUEZHT2hURm1IOHZmZmg0UFMyQ1JhWHRBQWcvUlZrYVNtZm5U?=
 =?utf-8?B?d1NvN0NTZ200am1pKzg5MjR3UGxSa3E2bnVrUmk3UEcwaTIvSWc1R3pxdmY2?=
 =?utf-8?B?Z3ZtUUljMHNIc0tHWXFWamRqTWgySzhrVUhOL21CS1V6Ykx0Q04rcnlGTk1I?=
 =?utf-8?B?aTV2a0NTNXNsQ2F0aVM1TkxPdlZrTlhKQTlBWWdkYjE3NnNJWnpKajFKMWJj?=
 =?utf-8?B?Z1hWajkrMDFndUlrNGRrNlFsNkQrYVVJZHdiMnNUbEVzVlRZNU5uUTFBZlRS?=
 =?utf-8?B?cm5XTXVTVGFsQUxrWGZvRmc1ZWY2RXNYbWhRVFR2MWtxV0tjZFBzUEtKeGhl?=
 =?utf-8?B?cjNQNk56VE1zRkd4dUpsL01wZDJGOVAxenlDajIvVUxpdU5hRmJ0NWo4ZFZQ?=
 =?utf-8?B?c0I0UCtUQlVQcXVSV1pmczZ5bVV1dzE5RWFlUHcvaXBqMFAyTlg5VGJzelVl?=
 =?utf-8?B?by9BOUNEa1BDZVNyek5menVDekh3eTYrd0tXdEoyMHp2ZC9OUG12RVhMUnY5?=
 =?utf-8?B?Um9JMHFENkwwZUdPMy9RVnhUaE1jRG9UTkltZTZaODJjLzFQaDI0WENhU2Zs?=
 =?utf-8?B?ejZUem1FdkVxZ1BBdXkzZ0Yrek9sS0N6Rjdmd1IwU3hUcjZpQno3bm5RRTZz?=
 =?utf-8?B?eUp3TnRuVlI3UzAwMW5wT3NqaXVJNVF4dUk0U1JucXJlTkNoczZ6cTV5cTVV?=
 =?utf-8?B?Rm5RdHNxSmh0M3RXeFRJeTVXSElneUdIS0szd0xCVG8yVnh3WkVBVElWK0dO?=
 =?utf-8?B?UDFDOFlzL3poQVlGQ3J2UHpWQk15c0VsZHRONkFqZjQxRkN3R2tDYlQzZ3Rn?=
 =?utf-8?B?ZFZVWVpWRko4YlcwRUxSN1VXVjBlOGs2RlZOTldvbDhhZzFydzA5V2tJK1pL?=
 =?utf-8?B?QnIwQ3ByWXM3Z1JBZFBKUUpJV0RGSGhxcllaSTdsTGdzSmFPbFRqdmR3RFFY?=
 =?utf-8?B?UnlQK1pBc3dCUFczOEpGMG9aV2VPc05TZVQ1ejhrTGRsWFVYVDI0VmU1SkxX?=
 =?utf-8?Q?cH18FOKPgSTaiDLg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4B2BCB4B19F104997290E0EE3E77DB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yXNgXZlShsLTCp8jCptfka9oOogzzkbUKfLRa6k5XSGtbqPzOL7a5Yey3jOwWjckgigVLyJ6y8q7NAh+Ck0YTuE4uyXt1v9cvtr8icafBSi8TldLiXcvL+ovBfpisSGmqhRf+pkd+TZNS7hjMdYYoLS7/rnkSgHuTiZQ4c5gA3E/SiiLgrkAfzb/J2TU/QjAKGR6DHP9oQ9QIYoHzKN93fD/wD5godRrYwZFCUiIM0bo0dSx1XJqnrk9/XpGn5J5TQO5+e/4UGmiR2pdzWIprMGmlTFYG3i5MGRAM/Zh+wzfd6V1xkujYYTFlIFPeKYbWa18gwwDz7DLVB2EzNAeeg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660010e9-cf5f-4660-c94e-08df287eee3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 16:36:13.7653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14yGNsZ7kSKf9Wju/GFRCesntSg6MPclpoOzRo8iOTszhSZjdLENYXVdxq7O4g4Q+2nrjlDrVQfSnDcNAB4CbfLZMbrrWzhgw4v4rBDIIhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9815
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDEzOjEzICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiBG
b3IgZmF1bHQ6DQo+ID4gdG9wdXAodHJ1ZSwgdHJ1ZSwgUFQ2NF9ST09UX01BWF9MRVZFTCAtIDEp
DQo+ID4gDQo+ID4gRm9yIHNwbGl0Og0KPiA+IHRvcHVwKGZhbHNlLCBmYWxzZSwgMSkNCj4gSG1t
LCBoYXZpbmcgdGhlIGNhbGxlciBwZXJmb3JtIHRoZSAtMSBjYWxjdWxhdGlvbiBnaXZlcyBtZSBz
b21lIGhlc2l0YXRpb24uDQo+IFRoZSBtZWFuaW5nIG9mIG5yX2V4dHJhX3NwdHMgaXMgbm90IHN0
cmFpZ2h0Zm9yd2FyZCwgdGhvdWdoIGl0IHNlZW1zIHRvIG1lYW4NCj4gdGhlIG51bWJlciBvZiBz
cHRzIGV4Y2x1ZGluZyB0aGUgcm9vdC4NCg0KSXQgbWVhbnMgImV4dHJhIiBiZXlvbmQgdGhlIHJv
b3QuIEhvdyBhYm91dDoNCg0KaW50IHRvcHVwKGJvb2wgcm9vdF9zcHQsIGludCBucl9leHRyYV9z
cHRzLCBib29sIHByaXZhdGVfcGFnZSkNCg0KVGhlIGlkZWEgaXMgdG8gdGVsbCBleHRlcm5hbCBp
bmZyYSB3aGF0IHRoZSBmYXVsdCBoYW5kbGVyIG1pZ2h0IGRvLiBJdCBtaWdodCBhZGQNCmEgcm9v
dCwgaXQgbWlnaHQgYWRkIGEgcHJpdmF0ZSBsZWFmIGFuZCBpdCBtYXkgbmVlZCBleHRyYSBzcHRz
IGJleW9uZCB0aGUgcm9vdC4NClRoZXNlIGFyZSBhbGwgY29uY2VwdHMga25vd24gdG8gbWlycm9y
IEVQVCBhbmQgYWxzbyBoYXMgYWxsIHRoZSBpbmZvIG5lZWRlZCBmb3INCnRoZSBjYWxjdWxhdGlv
biBvbiB0aGUgVERYIHNpZGUsIGFuZCBhbHNvIGRvZXNuJ3QgYXNzdW1lIGFueXRoaW5nIGFib3V0
IFREWA0KaW1wbGVtZW50YXRpb24gZnJvbSB0aGUgbWlycm9yIHNpZGUuIFRoZXJlIGlzIGV4dHJh
IGluZm8gcGFzc2VkLCB0aGF0IGlzIG5vdA0KbmVlZGVkLiBCdXQgdGhlIGdhaW4gaXMgdGhhdCB0
aGUgY29kZSBvbiBib3RoIHNpZGVzIGFuZCBjYWxjdWxhdGlvbiBhcmUgc2VsZg0KZG9jdW1lbnRp
bmcuDQoNCj4gDQo+IHByaXZhdGVfcGFnZSBhcmcgc2hvdWxkIGJlIHVubmVjZXNzYXJ5LCBzaW5j
ZSB0aGUgc3BsaXQgcGF0aCBhbHNvIG5lZWRzIHRvDQo+IGFsbG9jYXRlIERQQU1UIHBhZ2VzIGZv
ciB0aGUgZ3Vlc3QgcHJpdmF0ZSBwYWdlLg0KPiANCj4gPiBXaHkgaGF2ZSByb290IGFzIGEgc2Vw
YXJhdGUgYXJnIGV2ZW4gdGhvdWdoIGl0IGlzIG5ldmVyIHVzZWQ/IEJlY2F1c2UgaXQNCj4gPiBt
YWtlcw0KPiA+IHRoZSBsb2dpYyBtYWtlIHNlbnNlIGZyb20gY29kZSBLVk0uDQo+IFdoYXQgYWJv
dXQ6DQo+IA0KPiBpbnQgdG9wdXAoYm9vbCBoYXNfcm9vdCwgaW50IG5yX3NwdHMpDQo+IHsNCj4g
wqAJYWRkX3RvX2NhY2hlKG5yX3NwdHMgKyAoaGFzX3Jvb3QgPyAtMSA6IDApICsgMSk7DQo+IH0N
Cg0KIihoYXNfcm9vdCA/IC0xIDogMCkgKyAxKSIgaXMgZ29pbmcgdG8gbmVlZCBhIGNvbW1lbnQu
IFNvIEkgd2FzIHN1Z2dlc3RpbmcganVzdA0KdG8gbWFrZSBpdCBvYnZpb3VzIGluIHRoZSBjb2Rl
Lg0KDQo+IA0KPiBGb3IgZmF1bHQ6DQo+IHRvcHVwKHRydWUsIFBUNjRfUk9PVF9NQVhfTEVWRUwp
DQo+IA0KPiBGb3Igc3BsaXQ6DQo+IHRvcHVwKGZhbHNlLCAxKQ0KPiANCj4gPiA+IEJlc2lkZXMs
IEkgYWN0dWFsbHkgaW50cm9kdWNlZCBhIHNlcGFyYXRlIGNhY2hlIGFuZCBvcCBmb3Igc3BsaXQg
aW4gdjMsDQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjAxMDYxMDIzNDUu
MjUyNjEtMS15YW4ueS56aGFvQGludGVsLmNvbS4NCj4gPiA+IFNlYW4gbWVyZ2VkIHRoZSBjYWNo
ZS9vcCBmb3Igc3BsaXQgd2l0aCB0aGUgY2FjaGUvb3AgZm9yIGZhdWx0IGluDQo+ID4gPiBEUEFN
VCtIdWdlcGFnZSB2NS4NCj4gPiANCj4gPiBZZWEsIGJ1dCBoZSBkaWRuJ3QgaGF2ZSBhbnkgYmln
IGFzc3VtcHRpb25zIGluIGl0IGxpa2UgdGhpcy4gSXQgd2FzIHdheQ0KPiA+IHNpbXBsZXIuDQo+
IFNpbmNlIHRoZSByZS1pbnNlcnRpb24gc29sdXRpb24gbG9va3MgZ29vZCB0byB5b3UsIGl0IHNo
b3VsZCBiZSBub3QgYmUgdG9vDQo+IGNvbXBsZXggbm93IDopDQo+IA0KPiBHaXZlbiB0aGF0IHRo
ZSBmYXVsdCBwYXRoIHRoZW9yZXRpY2FsbHkgYWxzbyBuZWVkcyB0byBhZGRyZXNzIHRoZSByb290
LW9ubHkgLTENCj4gY2FsY3VsYXRpb24gaXNzdWUsIGhhdmluZyBzcGxpdCBhbmQgZmF1bHQgc2hh
cmUgdGhlIHNhbWUgb3Agc2VlbXMgcmVhc29uYWJsZT8NCg0K
