Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B0630BB9B;
	Tue, 16 Jun 2026 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601735; cv=fail; b=GOTcFU8TTvNEuCEdFq48BkYNGgnyP1QVe+MbUTQAs52nJNjtFY0CaUOT5DE1bWpZF1Oa+LD64i9pcxHG4pN0i9d/mga+Bnh2Wh/w0icsqbOKe7leSUSx3x6zWzlEJAnMf/P9tn0GRa/yowdy4YHTgvvZO4wBnM6QFi5545wJxZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601735; c=relaxed/simple;
	bh=1KcvgprcsLn1dKmNzCDf0ekC8UJJILROMy9seDC+/jE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t+zox1F08FX88J5he01xnwZnEK5jTqPWgzHo/B1kuvf4hz9iWNUhhZvVdgCGqiw8P8GIhEAwXB/z6wINWGBDTjroERx/PaFK54tYc9aRWoY79tummmXtq1lP2hE3QQNxFEWJampKoNAdXVhWl1H+EaI0RVRRf/QdSeiHVlqyNtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8Rv/Grp; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8Rv/Grp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781601734; x=1813137734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1KcvgprcsLn1dKmNzCDf0ekC8UJJILROMy9seDC+/jE=;
  b=h8Rv/GrpAisCueCbb4ZrQEofIyBtMfU3zyIjqdwoQppNfqjkQSX7We9a
   MPt2RoT5r6HXsHMQsNtkBDwSuwYN9LftZ2P/7YLn+sBuRtwyRCvqbVilx
   s2Ldms04+590mtcQZSPv2RfZVHmvh1pfNtRzzu/kkE6ynIJQD1allvG7R
   i4OtxCkEXhlnLcp3h7RPvW41cOZombPbIJ7iF2VDWUcOrxjqV8DlsqHwt
   RDHDGhuifiBwh8W4NZrjMuYzTCY5OhHLxSHa3VxvYgvhUnb75/BSzUMWm
   qPKcW129wTmJsTfdn3WXnAS5ha8aiECbpB+dKgUI2bhRN/J6ozTaUU8cm
   Q==;
X-CSE-ConnectionGUID: 9MlYR8VITm2yyNVn5pahdg==
X-CSE-MsgGUID: gb7Vp1R+SAisXt1DPW3QBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82260776"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82260776"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 02:22:13 -0700
X-CSE-ConnectionGUID: ydtJG6VtQuWNFM8++VBEZg==
X-CSE-MsgGUID: BpX6/6pNQ1aSWcYCHTEUxg==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 02:22:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 02:22:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 02:22:13 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 02:22:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWL7S/07tOP7qdZ6v3g2HIAlADDC58pIeUqI9f07gUneat3W4I4aqzx9NqRRQErNO4uphjv/eO7HoRx56dCwtPmeIfmP9Q+keDjOMEcBN0coZS5V6xqHW7UK27FoYjG6oiuP0jwYudkLJVIPyQewzit1TNK83x+Or35LgqvTEi6mHEqKMuzMIWvR/5+n1p399cVMpFfg4kqGGtldJNJLCF2uTL34kL4NEZdGrCr9Eq+F/E5aObkD5idjnO+x74JRz3ShDO6GNMV70neLG+dfBzlbUqv6qzafCG+bBXCA2ESNrCJMm4DeqFHvX7dHKlzsuQ2vRhXAx9F+Xuz3fclxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hjb928fDBzV17T2hFro4TsJt+S/fAwl3r0oJQZVvaTE=;
 b=oiv4me4019XhN+maFrww54Ok1VlXLHoiynBlWeAYH+FdtqAjz3VWe2M7W0gZsumXEvFH8p6LJArlqDiGuKJsSKhKHTrolQ0k1htQVcYpp21pSN4pNcvXLxkqxhMbNAG/TEYaiPiJFdi6krNCuHCcDvJ7G4YZyHKejmd/dR/4dXxWVS6x/K6m98WrN31kuI1CzffzoofN7Bo7J3X07hY2TRxDwSX/cIlGVvi6PG4y2mOaJFWbTgUipZeA43Cs8EXcHXKfMt7nb4PuDfSCiOB7vOnD69SMCnYzMPPE0vJk9PHTpVU6esdcMv7idOKs0gqp6IL3I8ltmGpQhgppU+qHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 LVTPR11MB9912.namprd11.prod.outlook.com (2603:10b6:408:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:22:05 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 09:22:05 +0000
Message-ID: <365d3cff-8165-4f27-aee3-704f05cf3b66@intel.com>
Date: Tue, 16 Jun 2026 17:21:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 08/22] KVM: selftests: Add TDX boot code
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Ackerley Tng <ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, "Isaku
 Yamahata" <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, "Sagi
 Shahar" <sagis@google.com>, Sean Christopherson <seanjc@google.com>, "Shuah
 Khan" <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
CC: Jeremiah McReynolds <jmcrey@google.com>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-8-6983ae4c3a4d@google.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260521-tdx-selftests-v13-v13-8-6983ae4c3a4d@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0028.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::10) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|LVTPR11MB9912:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df74dd9-b051-4904-9cf2-08decb88bb81
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|11063799006|56012099006|6133799003|4143699003|22082099003|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info: gHz4m9h+TZjp2fhuum2q0c8tQKdEpcSaS1LA2/Qk9ZmhVkASiGLTOS5NKZKV1qvzBjAkuP8SJzCvDtLaP+9T3i3WfAcT4q58QiP3G6hK9+R0N88wYU1cdo1y0G6Av9uwHOYUeiPRf/G52m/v8gBh3GUqnvEMkRAtUKXyFnEv4bb574/nLbyddxydLN81co9KCfyoryO+10yEelSJcyZ81L58gvP74M8yvIN5US1r1ImQWGDZ2KqEmDzDppG9bzyMd2u5XBFL0hbBJDBy0HU7yQ5tX14WEJkMW6nTIJH7PsA8lN7IP3d2hNgv2fIIDsuYPyDbiGCTShxYWt8wHu1dzuYYoiLzWpoa3kN94T0p2CmRr+0bsCiMwsy6XDc9Kih2uXCj6+KKnrJWb7GYNKjFV6CBmV4Zvj9Zo5Y/wC0QtdnhX2YSYq6QDR3ysC5Pj72khY8uG0JXNo5TV3/TsqkLXLdOks3202EjHYlecs5VlnBk6nYqz9BkIwSJGSAh4rOM7TDchwUVfe5GwyctBEaL3E26f9qICWlQiiAY1p80xBh2NBlLqRYRUEO64DkDb1+838dtPfOY6Krnx4Tv9F8NYkJleGDL8quxH0zJe2Rp1RLj1vkFv9Mhp/o6PEEm1sBS0NvQf8e/PsRVmCbgMSYJhdOjeGN9Uw9zo+/Xl3dUx50PW1CZ3HHDCY9i1onTh4PF0WljEIgpUL/vT3CplKiHxuaCEj1F6QSG2NYI+2fLiMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(11063799006)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjVEeXZhSW9TZ05XQy83bkIyM2txRHJTZzZGTnZhY3pReGxJMVpJMVNOZ2NI?=
 =?utf-8?B?UzBEZWdXc2x4bkVSdDA5MEtQdGx0aldTQlpHcW1KRHdqRCtJaGxKSTEzbVdz?=
 =?utf-8?B?SzB2d1VnMHgrcFVLWmN3SE1GYXRLSXlzcjlqSm1VcHk3aCtQSm5WWml6N2tl?=
 =?utf-8?B?U256TzhaQTl4em5SZzRqT1FyeUxxTXVXbi8zRkZHUGkwUW83d0Y1bC9nMDlK?=
 =?utf-8?B?UEM0d1gweUlIbVVVZFNzMjV1bW94RFcwczBPd0FmUmFqTk9PRDFjZFJVNTh1?=
 =?utf-8?B?b2pSSGFXUkowL0lwMk41QTdmazZ5QTlpZ2dldENkbHdLai95eXNNcjhiSHps?=
 =?utf-8?B?ZHJlcExFeWRzSFJWdDNEQUlTK0h1ZjZialk3d1AzK0hqWE5hN2J3dC9xa0p2?=
 =?utf-8?B?VVJndEhGUVZtNExWaktCRy9zalFndDdtNUpmQTUwbUpxVUhOb3BCemhicWZw?=
 =?utf-8?B?dkRrTHE2YS9oVU5vUEpReGVqdWtpUVNwRVFmQXNLYU0rTU1zUDFjalI3R0pv?=
 =?utf-8?B?bkcxRUJYalZGeWIwKzYwVzZsNTJNem95azl2OElTODNuOVp6Ti9ZNXFpZW05?=
 =?utf-8?B?dWMrVVgrR2xaREVrVkpKNEZwQ3BtdzZ5endlemg2elh0QlNSY2MyaHBXQTF4?=
 =?utf-8?B?T2xBWnlzS20vSGxhU0hzbVZNOHRra1hWS3RWSTNkRVFlcmFlSTB2NDZRdUdu?=
 =?utf-8?B?WXhjaG0yd3dGMkZ1cmRwWVgweU9MRnBZeUtuZS8wZDl0bWZpQVpuNVh2SjRj?=
 =?utf-8?B?Y29udXNZT1RNTTBiaUtBdVd3SVRiSTJnU2dhR0wySHNpUnhaOXIxblZKcTlD?=
 =?utf-8?B?a1lyRFFxRW5BeHdqUjBZdFM5a0hOYnR4bTRqZDVEWEVScHkzRDh2RThWcWpi?=
 =?utf-8?B?RGlEWmMyeHJBOWRhelB2RERsKzFNUVB6UTJ5ZU5JdkNXWE9KRnkvSG52a2I1?=
 =?utf-8?B?TmFqQTdmZXUyOGE1d0I1bW5JdnZaajBJNERURjNtU09mRTFQRFprOHdHY1B3?=
 =?utf-8?B?NFRTY3htL3VuVEtYcThodndPUSt4aVhnbmJUaFN0Y0grdndqYzBUa3J5WExp?=
 =?utf-8?B?S0NxMklHb1picWtsckp2TVlJYnc2SGlIMWtUbFVHMDlOVVllZzc0RXU1cGdN?=
 =?utf-8?B?bEJaeDllaXE3YmlsU1NJem1XZmhuVkFmc2E2TU9FbjVNQlRsRkF1OFNGZHVx?=
 =?utf-8?B?WXdpNHljWXVoR1RQWjlVelhBVC9aUmtQcG1mTUs4TUtiQkI0bzFjb3c2S0M3?=
 =?utf-8?B?T3JQNi9YTGxTK1NwUmtTd2o1OURWOUg5NWI1RDFsV01YZVJHczFiV1E3U0Mz?=
 =?utf-8?B?TG1iVXpUbnFyVUxoWVZsYjh2dUtTYzFBSDR1N1NXeGNYVkVqdmQwQy84S0xs?=
 =?utf-8?B?amFFZUxuSXVTQ0pFemlZMXlMdG9PZlhoT2lSOTFlbVM0Q2JvQy9JUnFaNXFN?=
 =?utf-8?B?aUJRZS9QdENJOFZYcmYxSllSMU1VRWRhczZHWDdmalRpbTNjbGE1T0VOMlg1?=
 =?utf-8?B?UU5ZelZHSGZHdkUwNXN1RTdVQ2VzbGN3cDNtNXprcjEvUXRVUEs1eDRLK256?=
 =?utf-8?B?cnhVU2c2WFYxUmVOczg0eENOaXlFSlhlY015eU42d050Tmtxc2U5TDZYQVZK?=
 =?utf-8?B?QjdVM3JWZ3FxcW5hckU5Tm4xK25MRmNNZGgvNjBkVWt6dExGM0ppVHk4TTM0?=
 =?utf-8?B?emhPaTRoNHhvazRpNmIxWUExZ3QvcW5odVFjeHFYT2MyODEveGNJMkhlQnBP?=
 =?utf-8?B?V2trdHF5Ym5ZRTNaSmtRVG1UY3o0cWtlekZuNndWczRzTWRRMWxqMHk0NitT?=
 =?utf-8?B?SitqczNGNktreDdqUUg5Y0JMMUtDeDIzcSt4Wlova2JvL21KRWhxTUtZU2Mv?=
 =?utf-8?B?clNPNGNvT21Gc0gyWHZ4UkVWdFd0ODl0R1YvWndyNGNLSmlSWmxxZkl3K1dF?=
 =?utf-8?B?R2xNMWF6V2NiVm5uL2paMHIvRlVhZjNwRWxSb3lCTTF4MlRmUUcwMC9LWmNQ?=
 =?utf-8?B?b1AyOXBxbjE4a3JtQ21sZ1psUFlaWGhrdnlMOTFRMWtPZkZNZHBTdHZ5VWdo?=
 =?utf-8?B?R1A2TFNCWExJQnI4M3pVSnBXRGhQV25PRjBPMU9XcTFLaE9KY054ck1hS0pj?=
 =?utf-8?B?SkhidXZxNnpMVDJNUm9JV1IzT01ST1h2Nkd2bzNNTTVwTFhwb0U1U1Q5UmRu?=
 =?utf-8?B?V0tpYWVYUzBlNDNjMlhiNmVsanRuYWlNa2xrVVB4SjQyMmVtZGx3eDdoaUZp?=
 =?utf-8?B?Ni9FZUw3WUxHTDVSc0NBQnVQT2gwZU9Jb1ZwZHhLWmpma1JkZFRRbTRLVnBG?=
 =?utf-8?B?cTV3bVR1Q2lWdVEvbXlDVmZCaTJhQ1oyMzFLZVpPR1NLa3lVMDhaZz09?=
X-Exchange-RoutingPolicyChecked: VXSJXaPgtHt1ubv2zfclOlThRbsy7TSWgyPP4d1OLMIRuE1a8lWNIc5FiwO6HkRBovttABB9CjDXem5dN020qc6MGg8y5pOhTfmYIAxjAdwckXgPmbzzHghuXWj0pfcFbgkKWEWsygIcofj5S7X0TJieDYwEjgkaA6/uDVmWLFY7834bBeV+2GdzEqe+Prp8myCyipJh8R3E6S5q9Fn52mnAaQcWnvv+kXdpf1r3Ij1Sc213oUG6P+DxUXk0jHUh8jcTG+W8jhnvz6v/SMYD0D8CuK3zBH/awmhlMvO6RyoCDRVi+qJ14lb/ZqTN6H1+AkRZpfEoReKiuUyiXbth0Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df74dd9-b051-4904-9cf2-08decb88bb81
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:22:05.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0wDjjUzxbRq66peP+geYpCKtyQzIZa1w8I2BKpEKAscgWg07AVybukqR/RTP0biLT0VHYzFOMM8Gr426GRkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR11MB9912
X-OriginatorOrg: intel.com



On 5/22/2026 7:16 AM, Lisa Wang wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> Add code to boot a TDX test VM. Since TDX registers are inaccessible to
> KVM, the boot code loads the relevant values from memory into the
> registers before jumping to the guest code.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm           |  1 +
>  .../selftests/kvm/include/x86/tdx/td_boot.h        |  5 ++
>  .../selftests/kvm/include/x86/tdx/td_boot_asm.h    | 16 ++++++
>  tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S  | 60 ++++++++++++++++++++++
>  4 files changed, 82 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 02fad7b35eac..929965ca4b75 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -31,6 +31,7 @@ LIBKVM_x86 += lib/x86/sev.c
>  LIBKVM_x86 += lib/x86/svm.c
>  LIBKVM_x86 += lib/x86/ucall.c
>  LIBKVM_x86 += lib/x86/vmx.c
> +LIBKVM_x86 += lib/x86/tdx/td_boot.S
>  
>  LIBKVM_arm64 += lib/arm64/gic.c
>  LIBKVM_arm64 += lib/arm64/gic_v3.c
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> index af4474dee387..e5d54a20ed72 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> @@ -66,4 +66,9 @@ struct td_boot_parameters {
>  	struct td_per_vcpu_parameters per_vcpu[];
>  };
>  
> +void td_boot(void);
> +void td_boot_code_end(void);
> +
> +#define TD_BOOT_CODE_SIZE (td_boot_code_end - td_boot)
> +
>  #endif /* SELFTEST_TDX_TD_BOOT_H */
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
> new file mode 100644
> index 000000000000..10b4b527595c
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_TDX_TD_BOOT_ASM_H
> +#define SELFTEST_TDX_TD_BOOT_ASM_H
> +
> +/*
> + * GPA where TD boot parameters will be loaded.
> + *
> + * TD_BOOT_PARAMETERS_GPA is arbitrarily chosen to
> + *
> + * + be within the 4GB address space
> + * + provide enough contiguous memory for the struct td_boot_parameters such
> + *   that there is one struct td_per_vcpu_parameters for KVM_MAX_VCPUS
> + */
> +#define TD_BOOT_PARAMETERS_GPA 0xffff0000
> +
> +#endif  // SELFTEST_TDX_TD_BOOT_ASM_H

It would be better to maintain consistency by using /* ... */ for single-line comments in this series, such as the SELFTESTS_TDX_TDX_H in patch 20 and other license Identifier.

