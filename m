Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F504A68A8;
	Tue, 22 Sep 2026 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106381; cv=fail; b=DrmUBQOOYOpeBWbBZZlOSfX6ic4eT/ySVIeTVeRVFmwGVA6beuTov/N55rRf7UN073qI0Ag8KvIGpEG50bOLwIhPLywFpc+/6hk8cAmvQNHrFlVmyE75j9M+G2jOlNCjXsFmSAkwctZvhtrEPwXsPYFQe9l3+H6fmXqztPdGBWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106381; c=relaxed/simple;
	bh=ld0f1xRRSAJHGs/Fcsq/onVuqC5i+tPFrQDwcObXai4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TsO5I2X6QjwG0QaRrt2PzwknBFP5DQLL/GGGgcUgCB/wFm46mDICvfkRzceelipOsVqGqh+XLe83bJKai8rIlS3TJmtn1J6txwRReiyf5KDEgAz9wYKji1yz+2B3TSnTotpw3lbLp+YKu/HNZK4JlaF6YTI40gjYmm8Ij21TiK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ox45k53s; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ox45k53s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790106379; x=1821642379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ld0f1xRRSAJHGs/Fcsq/onVuqC5i+tPFrQDwcObXai4=;
  b=Ox45k53spw3xkePeUKmu1Qs0N5V9Bn+lAAugqhTYm1brINOD5XD0nkxg
   7rTgh59WHX2GQVjv47g3UHRx4F/tN7P8Vryf2ZF+yoJAsLJghPu4yFxWh
   58ORX4W+aoTf0MyCSAvyrG9cNbH0uhFL0zsoQGwfuHYlYDbdhocWFO81E
   Y5ZtgND0iTbpjMluxzFp72LwXhJ1u3utHl19PIPJMAhfeDDm21VvYjb5g
   +9oBbCRhGSdWgOH/BEbZfsu9B1Q+7orMxaYYC2Md/HV2wHZ5AA3H3R4f6
   tQdUP3VvP7qXQqjHbix4oA4FROuEvNxwbnab4OAgYpHY9wKi628t7m8fR
   w==;
X-CSE-ConnectionGUID: i9+4pFwlSICUDUU2OyCE+g==
X-CSE-MsgGUID: hq50t9O5Q1melreKLGFRrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101333912"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="101333912"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 12:46:18 -0700
X-CSE-ConnectionGUID: JO7XTfsHRN+3u1D5p5d3lw==
X-CSE-MsgGUID: MmbNeOqGTVuZGzbv9Dc0ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4337715"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 12:46:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 12:46:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 12:46:17 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 12:46:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRacps4rISju49r8l/SekRKQT7RB/6vkjDQZYx/+jiT7n9cpIdyQ8rUTkwAtY3qSZa9cCNw/8LbcQIeP1eZ4eWqMUl45V20bszLplME7Ih+I9w79Aeu9V1e5fM9L+NwguJLqZkqsCN8rWx2Khszc3TReScqj2uovZ1osNQ5NHNNimI1DkEiIq2bkhtxtQTqB5Vxl+JREtbHDWkWRTqtH6ljp8YeuRkcJ2sLIs8FIezXRtL4esHJDMixXTeZYKpFEXBT0MY8Rty3b/Tx/INLHF24VqU5Uem9JsF/M0m5FDwBHniVjgKioxrZVaTmOI+E93WbSXN5vVM6z+R7BRIRzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld0f1xRRSAJHGs/Fcsq/onVuqC5i+tPFrQDwcObXai4=;
 b=Jlqhyte3npbh4gxpXNWqwPbFnWlSlq1vgBwF3yqTPDInnqAkBE5i1jteiRE+sM76o5CGPnnb8n0WC9Ax1zC01VZhgySuw1XwB+S962gSR/Sokk457pHwHT1wIxdUlNsRmzoqfNRiRFlXtKsqEDcFUHutjdsDTyiNM5EfOaS/N1AFnfzmQwLmS5fMXa8KXH6GH+flfdeT5Up/FUMXrPSnDyqwl9+WotmJQbR8uzaKG7UiOZfzZkN1xP1ON9Rq2u2R9KcUhd3xDMsIlIoIfbHtXRvC7ts3z8TMWDAB0ZBmRzWn09h3N/uFNuDraLRvdge4p+2aWVAMKbFb0PhRYJ/jfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DM4PR11MB7352.namprd11.prod.outlook.com (2603:10b6:8:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 19:46:14 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 19:46:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>, "Fang, Peter"
	<peter.fang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>
Subject: Re: [PATCH v4 3/4] virt: tdx-guest: Use a variable to store the Quote
 buffer size
Thread-Topic: [PATCH v4 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Thread-Index: AQHdRPRrHz6BwhsEpUO3Tjs2zUultLbaadOAgABSUoCAAE/+gA==
Date: Tue, 22 Sep 2026 19:46:14 +0000
Message-ID: <1e6ed0923fe1ac938f3e0fa0f8d05d31eb2d0f31.camel@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
	 <20260915092632.2822169-4-peter.fang@intel.com>
	 <620e7e38-4287-431c-8285-575c84aa1f6a@intel.com>
	 <7ddf42ab-2f78-4edd-be39-ff9e5156d51c@intel.com>
In-Reply-To: <7ddf42ab-2f78-4edd-be39-ff9e5156d51c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DM4PR11MB7352:EE_
x-ms-office365-filtering-correlation-id: 6b4e6a65-88d4-4868-6253-08df18e22934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: SQKr8LJoLS5x3BSHEO2rXBcn6NJu3vZCdhztrbmQLcQhtIzT8C23oycBXekgaoL3RWIiBIXTV0DbzQ4GCNhCl2/sQN1Cmg6v2AGNKsTJSdW2mmHw8PIC7iAieFcjDX7Vf4LpP9DaucX5ewsuL4Uf3jnhhY7dthjTfJyoFCpA/XgkF0nw6UU4D5bnGbAqwVHQJZlECTY0wfxzxs/oizdj65Zs60BudFp7dfZV6mUFR+AtD1qxGYpEnjajTRiSbPaxBsFQNcJDfZ/9MwAghWo0uR+hQ0kAWGDCs54s4V51r7yRju77WFnDAgt5FVi97QsDBvfbbl6TK+ldDRWfUYZUDkn9TBGG7CQxdZLLwku4h4pfdvcHIsA+6bgF8ABIUctxY3wY9ad9SnpQx92R8a2z2SbqLvPdYxIec/pIg0/N56cPWwQWoR5Z4zC1HF33vgBNbgBr3oQFnMZCr2hMC/fXnNieTRmDMFUPxtJ0c6zdLHl+5mhQAIAAuG/3erlc8I+Mj3iRPJGcQCUzjDBIb0g7k4LUlKN0+g65zZY8+TZebhKcoJXVHsFcimrWjJ6MUlGIE6sErbOCemkmlaPb5GKjPkmzfMqyIEAFmWlmMmmFRneeVQPUBkMWrHewyKEhGQMHRsskHazTA31XexTRfLRTmYe2713hWnba7qKLox7fqYfuEyFo5X4EaSRkM3a4Guay
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWQyRnh2NUpoUVh6dlJrN21Nakl3SFBJMkdVbm1PTCtySnZqc2Q0UE5HQWtB?=
 =?utf-8?B?R2FEeCtZRGVxaUQ1Rm1QNDZiVUdMNHltWFQ1Ris4WEtXOSs2M3F5Lzh4ZFBo?=
 =?utf-8?B?UE8yMnJydFBkdEE2UTdPR3FnZ0NGZy9CdmFjZGNLdk1tL0V6US8rVGt4UUIv?=
 =?utf-8?B?Q1pnWExyU1VpV3dnck12N0M0Zk8zRnlQRE5OQSt2VFFabjRlcjZyWS9SeXRB?=
 =?utf-8?B?NWpZdlNMeURzMnF0dEJtQThBaDR5M3RaTFZVdGF1ZWFVSGVmUmdIVDhKQzNB?=
 =?utf-8?B?aFp2QzUyMVduNVlRY2JBaVhXaHJpRHl2b2V1NjIyTFZLaU5UNXIvZ0N5ZFlu?=
 =?utf-8?B?VTRhTUlVWS9MU21ad2FhcnpaY2c0TGhQenhBc3VteGMxYzE4elpTZ3FlZlhE?=
 =?utf-8?B?Z1RJZXVoaU9GdUVBT2lDNzloMmRsdGFsbVVadER3ZEpZdnNIWm5WcEVhV2hJ?=
 =?utf-8?B?ZE5udHNRNkJYbUtPU0RRUTBMVHJsOGIyLzUwUm1hOFh2VWpMaDBULzVteXIv?=
 =?utf-8?B?eG5hRHVVSG54NThPUmluRUdjUzVvdmRHWVBPWU1zUU5heUcycDI4NFdxSXM4?=
 =?utf-8?B?OUlWc1lQdXRFbmUvYVhsaEUrVmhyR2V2eUs4T1ZQa0JCVXphUnV3NXJCVW5z?=
 =?utf-8?B?ZDNJZjVSN3laSWJ4dEpZS3ZudmNoVTJ6bG9uNkJkYVo3VkxZVjZxZ1BuTEw3?=
 =?utf-8?B?UVQ4R2VOdnBqSTdqcC9OL0lkVjlmSTl2Y1dwN05WTnJha0t3TEczSDZvRVJ4?=
 =?utf-8?B?N0ZreUc1dUZja2JjRjcxV0NvMzNYdWdWQWZqQkJaN0kyM1pSUnJ4dHFKRmd5?=
 =?utf-8?B?RGNtb1VrZ0xzeWlCS2lrSUtMRXVJVHE5ZURUMHVLaFk0YlpxY05CL0Q4Zzdn?=
 =?utf-8?B?VWJUL2lvYml5Q2ViOVdYVXRFaUQvenEyTHdPbmZwY2RCSVhsZnZGUlZ1UTZh?=
 =?utf-8?B?RHhQVTVyWUFXWFNudDBQVXVZdUZOV1RRaFR0TWs5ZUVGUjZzQmRwNXFZVjNt?=
 =?utf-8?B?L2NUSHVKRVBPWUxiZ0FHcTJ5RWVoRVQ0QXRTRzVhaHhYRnh0TytqNlRWTlBr?=
 =?utf-8?B?N3R3eCtoWFliK0lVbys1RiszdHBnQjZSMUpkTW4yMFdzamJTdnpCaUt5Vmxi?=
 =?utf-8?B?NlhZdHpkdllzQVF2bm9jTlR3eVNVNVJSOWQ1Y2lxUUFpTDdyYTg3YVpIQWp5?=
 =?utf-8?B?cTFyOE5vdVY1V3hvc2lPQ1ZaQ0ZYcjZWdzZWWHI0U2dNUzZCUGZVOTNGc2dm?=
 =?utf-8?B?Qmdsa0lZQWNmUXZPWjNtcVhzdThOZGd0VkdQOGFrQTJVei96N2trdVBNb2px?=
 =?utf-8?B?MlpyUWdUUjZ4d1ZMaldLZ1VnbUFQUFUwOGlldnFNY2M4TmFRQktmT3V3bndj?=
 =?utf-8?B?L2tHKzhWZ1NweG9jTmRiOXdhOFM4Q3VaSmUwTDdmTms5TkdIa3BzZEpoTStv?=
 =?utf-8?B?eUsyL2pQVG5JaEUxaG92Wnd3VnIrcWhWSmFEektCWVBCUnNNTmtkRmYvUGxI?=
 =?utf-8?B?Z2p4ZjRCUEVvbUZjc3hZc3NSb0RJczA2Q0U2LzlYWWkxbU9XUFIxK09SaE5M?=
 =?utf-8?B?WXpLSGIySnczTDRFQk1BdS9PVnQ3NFE2OVZOdk5DOW5rRUxvbHNDcWNvSHpX?=
 =?utf-8?B?azlqcWVVQk1WVGhmNmtTM0NWK1Y0U1BCOWwybytzbGJFWHYzaDMvMlFCdGFN?=
 =?utf-8?B?NVVjMGpZYU5SQ3VFTzhqQXMyczR1eWJQTTAxNTE2NFNHR3hLNTVUekh2Vm0x?=
 =?utf-8?B?V3dqNklHWVdMejF1RHNKdS9nSTJ1N1phLzhFZUd5K2swWnlWOEZnR3ZHd25m?=
 =?utf-8?B?QXJKemZIUE1UZjBoK1oveE1oaFAxV2dGYlVpZENkQzVoWHExcWJvUm5uY2ZM?=
 =?utf-8?B?RTJlcU81czRSdnRqbGhoZXNUWmg4WjVaK1JYT3lzcVMyR0s0S3lNY3g5T1px?=
 =?utf-8?B?cFhaOWNrcXkvbGg0eTg2ajZLekk5TVZpVlFwSnV0N2tMRWQzaWRoTU9iUFd4?=
 =?utf-8?B?L0ZQaFZLSlIrYlNQd0dtOGpuSGZZS1NZWEJPc0dDc0pQQVhHNkxRdE4wUmhq?=
 =?utf-8?B?Um9sTW9uYkh0WkhGdTFtVm1UNFJtQWtTVGRFSVZOWk52NmpjcFNwNWxjSllB?=
 =?utf-8?B?UEFBZWNaZkFtNkhCaTBkeFVvQitSaEVLK2UzVkdJK3FSeTBVYURCNW4yUFBN?=
 =?utf-8?B?Y3Y4dlhYVTdtSmxBWWY0UUhXOWs4RnV2Tkczd2d4eVV1aHUwU3FHRFYxblZw?=
 =?utf-8?B?YkZUUzBkcU5DQ2VQTHU2bWIyR3krakN0Z2E0TUlnSjlkbUtoSHlyT0g0NWk2?=
 =?utf-8?B?VDF2djBYcXpjYlc2MFFyK3hqU3RHSWNML2ZtQzJjVHZXNmsrSkN4TXgwcHNl?=
 =?utf-8?Q?dczhrwqV4TZP6yoU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC04F8413BD8B64299A7DAEDB53DBF0A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: buqWUfycsI6/WFz1rArNadNWj5UlWVNgp7/J1y03bNzfPx8fKW+EkdiQ1od+p/p/Ans8RG/u46WHyHveGHnOeR2xYiE2EryCqZpeCeCfC0x9rq6mz0NEhKYhJacKBtjJ0nUZcqSZDLxbDhlvPnwTRdfDQKJjLuCFyK9MzwoaZy0RbAzzg1X9l3oVDaw286DB0Psaa24h87YvAYS7b2ltrPz/sIhpBAh/uaK5qjh59XSqMH6gdtrTus2N8WmizDypstjGMPYPgmbltbIeCzDo2P7WZEjSD/ULf2jgXWdaWq2/N0WEAeD+m1jKzqu8Vlxp1T9UxUhf/f46IhUQ3vVQBw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4e6a65-88d4-4868-6253-08df18e22934
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 19:46:14.2707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOX3qmY2gFoBtVJNQvkzp/px1Kd31zeI9djoZ1bSS9V9A+/lwdSMtooeEMdAfmwvbg0xAsgbWEdN+AmhA6dSRqQfYV1aUZGDDz8D7Eznl7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7352
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTIyIGF0IDA3OjU5IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOS8yMi8yNiAwMzowNSwgWGlhb3lhbyBMaSB3cm90ZToNCj4gPiA+IEBAIC00MTcsNyArNDE2
LDggQEAgc3RhdGljIGludCBfX2luaXQgdGR4X2d1ZXN0X2luaXQodm9pZCkNCj4gPiA+IMKgwqAJ
aWYgKHJldCkNCj4gPiA+IMKgwqAJCWdvdG8gZGVpbml0X21yOw0KPiA+ID4gwqAgDQo+ID4gPiAt
CXF1b3RlX2RhdGEgPSBhbGxvY19xdW90ZV9idWYoKTsNCj4gPiA+ICsJcXVvdGVfZGF0YV9sZW4g
PSBQQUdFX0FMSUdOKEdFVF9RVU9URV9CVUZfU0laRSk7DQo+ID4gPiArCXF1b3RlX2RhdGEgPSBh
bGxvY19xdW90ZV9idWYocXVvdGVfZGF0YV9sZW4pOw0KPiA+IHNpbmNlIHF1b3RlX2RhdGFfbGVu
IGlzIGEgZ2xvYmFsIHZhcmlhYmxlLCBpdCBsb29rcyBubyBuZWVkIHRvIHBhc3MgaXQgYXJvdW5k
Lg0KPiA+IA0KPiA+IFNhbWUgZm9yIGZyZWVfcXVvdGVfYnVmKCkNCj4gDQo+IEl0J3Mgbm90IHRo
ZSBlbmQgb2YgdGhlIHdvcmxkLCBidXQuLi4gZ2xvYmFsIHZhcmlhYmxlID09IGJhZC4gUGx1cywN
Cj4gaGFuZGluZyBnbG9iYWwgdmFyaWFibGVzIGFyb3VuZCBjYW4gYWN0dWFsbHkgbWFrZSB0aGUg
Y29kZSBmbG93IG1vcmUgY2xlYXIuDQoNCldlIHdlcmUganVzdCB0YWxraW5nIGFib3V0IGEgc2lt
aWxhciBwYXR0ZXJuIG9uIHRoZSBleHRlbnNpb24gaW5pdCBwYXRjaGVzLiBUaGUNCmhvc3Qgc2lk
ZSB1c2VzIGEgbG90IG9mIGdsb2JhbCBpbml0IGZyb20gdGhlIG1ldGFkYXRhOg0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcva3ZtLzljYmM4ZWRkMGEyZjIxZTY5NTIxYTdmMmRkOWYxYTExMTRmMjM2
MmQuY2FtZWxAaW50ZWwuY29tLw0KDQpUaGVyZSB3ZSBoYXZlIGEgc2VhbWNhbGwgd3JhcHBlciBi
ZWluZyBmYWN0b3JlZCBvdXQsIGFuZCBpdCB3aWxsIHJlZmVyIHRvIHNvbWUNCm1ldGFkYXRhIHdo
aWNoIGlzIGdsb2JhbCBhbHJlYWR5LiBCdXQgdGhlIGV4aXN0aW5nIGNvZGUgYWxzbyByZWZlcnMg
dG8gdGhlDQpzZWxlY3RlZCAiZ2xvYmFsIGtleSBpZCIgKGRpZmZlcmVudCBtZWFuaW5nIG9mIGds
b2JhbCksIHdoaWNoIGlzIHBpY2tlZCBkdXJpbmcNClREWCBpbml0aWFsaXphdGlvbiBhbmQgc3Rv
cmVkIGFzIGEgZ2xvYmFsIHZhcmlhYmxlLiBUaGlzICJnbG9iYWwga2V5IGlkIiBpcw0KcGFzc2Vk
IGFsb25nIGFzIGEgcGFyYW1ldGVyIGludG8gdGhlIHNwb3Qgd2hlcmUgdGhlIHNlYW1jYWxsIHdy
YXBwZXIgaXMgYmVpbmcNCmZhY3RvcmVkIG91dC4NCg0KSSB3YXMgc3VnZ2VzdGluZyB0byBtYWtl
IHRoZSBuZXcgc2VhbWNhbGwgd3JhcHBlciBjb25zaXN0ZW50IGluIGhvdyBpdCBnZXRzIHRoaXMN
CmRhdGEgYnkgcmVmZXJyaW5nIHRvIHRoZSBnbG9iYWwgZGVmaW5pdGlvbiBmb3IgdGhlIGdsb2Jh
bCBrZXkgaWQgaW5zdGVhZCBvZiBhDQpwYXJhbWV0ZXIuIFNlZW1zIGxpa2UgaXQgaXMgYWdhaW5z
dCB0aGlzIGZlZWRiYWNrLCBjYW4geW91IGdpdmUgYSBxdWljayB0YWtlIG9uDQp0aGF0IGNhc2Ug
dG9vPyBJIGp1c3QgdGhpbmsgbWl4aW5nIGdsb2JhbCByZWZlcmVuY2VzIGFuZCBnbG9iYWwgdmFs
dWVzIHBhc3NlZCBhcw0KYXJndW1lbnRzIGl0IHRvbyB3ZWlyZC4gU2hvdWxkIHdlIHN3aXRjaCB0
byBwYXNzaW5nIGV2ZXJ5dGhpbmcgYXMgYXJncyBldmVuIHdoZW4NCndlIG5lZWQgdG8gcGx1bWIg
aXQgdGhyb3VnaCBzZXZlcmFsIGxheWVycz8NCg==
