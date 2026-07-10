Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3E34A76F;
	Fri, 10 Jul 2026 01:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783647296; cv=fail; b=tev1HHJCQNYCBXAZz95aMqRi1ZfJA5gzG134AGLNWD+Ms9Prtumk9KYzHbIbXU3FQug1obm0D6uD27rtCHezVvgywmZHQjl5YmcJv8e6R5UgB2/zv96vqTgCf7oIpToanhsxMXH7QpY+b8DT6zI3ZgQsrGXBfipkGF+28xyHBZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783647296; c=relaxed/simple;
	bh=WmA92rNd9QOcbTvrEZWpO5shBrkS10RvlPDyKs1cwkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f6U9SYDNlvaABf0VaTeOLVr83rWvRRta8kstJVEn1eDfs1EQkbjA443rQ4Q72PLXLEfL/7o3sVawuxPDz9S5WWwTqJy3pRg3vXIOImLoWc8H6/QKkM57DMhRlIKwy/4bYw8CoBbh2yaY30hqa23PvNOmg+gtfDDsEOffCX2dg4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luzlrYsS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luzlrYsS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783647294; x=1815183294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WmA92rNd9QOcbTvrEZWpO5shBrkS10RvlPDyKs1cwkA=;
  b=luzlrYsSGryG1fsc3iYvEZz7dUIhZ5nqVR+pQh9ZfXPTFIczjht7WD7L
   O2ClXqe+W7x5FrRf7p6CCFoBu4HDZvqAURuC1lDGm7xr4YoTcEgxgffw0
   iLxDbGDZm0hajGaF8YrDYtn8yozF6iRxwe1bVsNFCWMB+Yo1hWAyVsJwh
   1lSlBZqNo5LBVFN0H+Khw4I4CqpJjWsk7GFroFvtqe8tnSIah53GFa+cl
   bWGKI9CNXIaAfAekRk8gfj6CBhdpyrAZ2I7DGNqzp1yQC2XUcayyLSWaQ
   eBg4Ae6Onyb9Gs3T4LL+pVHjYMQRiy9VJaL/VpwF3Zk2Gu4HCBasqwtOt
   w==;
X-CSE-ConnectionGUID: DNAf/AR5R6O4qOh1wSpdQg==
X-CSE-MsgGUID: n12k6S61QL+vqmp0mI665A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83463038"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83463038"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 18:34:53 -0700
X-CSE-ConnectionGUID: ShC+8vGDShOBXGFyMx50Fg==
X-CSE-MsgGUID: PepxUWdOQnq2TCYNr7MBvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253012286"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 18:34:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 18:34:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 18:34:52 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 18:34:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq61y2fM8QbP9SX8VDMtoigd288they7aQyc+fit+1SZ4NcRE8BBw7UppMAbq1T11u7tz6vNKZJC/UkJcwJ7ZqWQu2l4ejhc/p4M9Pmj9utUUR1eFtNArmZSfmoO2xh011PHQxrJtHJMd+Kc0F35o9wCMvUK3Ihlest3LEjcNenm79nXb06wGNX1QGfFWtYxiYZz9GSD/Bg72Zw53bMkzaTquezNPmnumTK8eHDyZG13mXSumDslQhbYRWvJvmfYw2GbK972LZL91I5kRJZL/Z4oHCc8KQkaK92ZhqAFuAhBDpWTCKnJsYJyVnqfZ81F5tgWT8fqmN4XOIbEMy4rxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmA92rNd9QOcbTvrEZWpO5shBrkS10RvlPDyKs1cwkA=;
 b=yE4iR6fXV4eWPermoZXMrtX9f6Ps4Ye25my44/kBSvR7j8mp1FP+q5nESp1xh8601tgwt8Ulqno8L4B4PLgT6oyQDRXkT3pWLOwInsdKa+91YzxcSQ0U796R5wcZcYpVmvNGeDwKsr1lRLOYX+89aQrhlg008Bp0m1vC7Kc+5GhkVcI1qphc0/6rZmYjl7PfkHWQ4cSM5E1cRRKrQGYepyF048SdE/kRXHXsPT/aZ+evaEvvO1jbifcaHjsrp0qvMSlWKgmeuxO6Dnpl8RA6m4mNGdWVGsqipdeqb+t606KpDhigWBLq0dwqnPRRgUy/FyxsRYBECOBfbebNgZmHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SAWPR11MB9710.namprd11.prod.outlook.com (2603:10b6:806:4c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 10 Jul
 2026 01:34:49 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 01:34:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 08/11] x86/tdx: Add APIs to support Dynamic PAMT ops
 from KVM's fault path
Thread-Topic: [PATCH v6 08/11] x86/tdx: Add APIs to support Dynamic PAMT ops
 from KVM's fault path
Thread-Index: AQHc7LhTVxbiq9axPkqkwpzjl/qOgbZlDJUAgAEyj4A=
Date: Fri, 10 Jul 2026 01:34:48 +0000
Message-ID: <6f19e79b49e6f6e32c34a87302a9ab475ad0f51c.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-9-rick.p.edgecombe@intel.com>
	 <ak9LDmWBIp52wv4X@yzhao56-desk.sh.intel.com>
In-Reply-To: <ak9LDmWBIp52wv4X@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SAWPR11MB9710:EE_
x-ms-office365-filtering-correlation-id: 3c8fe1d5-0de3-48c8-d8a0-08dede236e03
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|4143699003|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: NA7x7NQmqPmZN+lu45Htb8B8o7bbsccsg2R2H+g6AjboT1ezwNZiYYP74pLPF4fm/+XcXBoaWfhDCENfTqtUvIokxkYTDuMopfP3o1r1bsEReuD2R0sbfry8PvP27MwIu9JGTgcfnXLequf6Ps511kxDtptZykUMVwlpd1jr3VwRm4wjH6vdEt7EeSeGJ27gNmbe/RpOgZg55hMrB5yGOo6wLwtf9UCHHPd6qL7FC3lJjFfMcLMmz2uxnxEGNYixS1i8rjgmU8+iHIx1IxSbqPZQNQLobwOhVrccjUu3/2AcFmUstzlGSvZHVF1zZEDDP/gYh7gA7P7P74ISeSqOBnChnxOUomuRMzqermgQ8zTBZdJSRz7GWp6nF+bVmOBcBON17mP+MfDQyWDsiXQ/bEN56iTeZfzntuTbFf6Glmm8C+On1EfmO++LgOlSd49Cq1bSHUXS3nHcaC6OkjbDbSmzQspN5CVIRm0Tbs4lkYL8n90ucD4JSsnP/6YuUT9pYb9LvUbxN7cZbTDZbg7mztAPigLPry17WAUmk16oag7xx9rAX1WOLNUF1+HCh3VUY9rDhz4ot3ZE6K3Ql3OH1kZbTd8EgRuW0drZBDT1lGudfcdudpeLMXv+yaTtTjn3/y/lN4HA4KpixmsaT6tsCSBn+Q1CRaeZN+qyWfnO8V8PBY65k6IQdRxLwT1WlcZJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGVCSURWU2I4MDQ2VnFtZ2xUR1FEWkFybWtaQU4xSUJKT3JBeWI2QThJWG1v?=
 =?utf-8?B?RklCc2g2UEN0Zml5SU1EUGpJNlJJdEFHZkRnbnQ5OTBhaDUxU1BwSFhQNHFk?=
 =?utf-8?B?T05RSlZxY3JXTWhzY0JvbGlPOEdJdHRnWjYwTmJNbEVKT0l4MlNseHMxajR3?=
 =?utf-8?B?V2JoWjF6aEhWY0ZyeDAyemNScFU0SE51NjViYWp5KzdMM1MxR3I1djdKK01y?=
 =?utf-8?B?OVJ2MTR2R1lXbWJKYlliQWt6U05aR0ZrWXAxZ0hPVkYyV1Z6QVphblVRZEx3?=
 =?utf-8?B?NW5DYzVBaGZ3M0xDbWhqbWJCNFhPOEJHT1ljcUFsb21iUGIxQ0lzc0lFVmVP?=
 =?utf-8?B?ejlWak9Ta0pyTmhzMWNZd1ViYnhTL2RMUmdnR2hJZ2hKVC9QVWprNkhTdUtU?=
 =?utf-8?B?TzJ6TDN5QUZpQW5xc2w3ckhGV3lsS1psUmJsWEc3TzNmNXJlcTdoZUdhbm5a?=
 =?utf-8?B?WGxqVlNUckxaSDhjY1V5NHh5cE9mdHRzNGdMM0g0TWlKUHlnMEtzeE9EOWxv?=
 =?utf-8?B?eUpoWGxPV2QreEdWZldhNTNrQk13Y0FqTm5lVXZEeGpzdys4RzY2YWw5NU1t?=
 =?utf-8?B?eTVscnp2czFjQ3FYcW9yMG1ocVdhZ3p1Q2pkUUJhTWxFeXJISmZ4QjcxT2tK?=
 =?utf-8?B?WVllU3M5Rlc1ekRtV0Y5MDYzVVdWaGMvMzVxc0F4R1ZpMzdzc3VTMlJ2UmtD?=
 =?utf-8?B?K2hwbUpRc1RoRXA3blBCN2dvc0s4OHNTTzc4cVVHUFFPNm5rcjZKYmJ4b3Zj?=
 =?utf-8?B?bFJjYllWSnp5TXN6R0xpc05la3VRRllxdUI3c1M0NXdBbjFlWUozS3plbjkr?=
 =?utf-8?B?aitzT25tVWZheXBlNVN3akd2MWMvdURjUjhQb1pGdFlaVXFsQnBzdEtJK0I5?=
 =?utf-8?B?RDNyUG96YWN2RmV3VU5DUkVKMFlkWlVJVjZhM1d2MVZhRURxUk8xYnZBRVhP?=
 =?utf-8?B?NDduM1NrQm5ucERpK1lwSUNhb2UwN2wxVFJ6WFhlR3VGOEtMQ29NWkFWZzhm?=
 =?utf-8?B?UFA1Qy9NZGxNelgzSFF5NEhZa3ROdWxWWmxoQlMzcWo0clNWTlhXcXMyd1cw?=
 =?utf-8?B?V2dzbFdrYnFpTElQWUhVT05QcDF2L1pKQy9aVFR3bzA1NzVYS00va1FZcnEy?=
 =?utf-8?B?SVdjQ3BZbnd2UUwrNHE0N1FhNWo1NUVRckRhRUtKN3MxMExURGFXT2o1eXAx?=
 =?utf-8?B?QTlQWFd2ZWkzajZvcFNwQnFsUnIvMU5zN3Q2TmlCcUwvY2xDS2dIalhJODNv?=
 =?utf-8?B?UDlqazk5bnloWndjb0JmaTdoSXJhQlBlaFhKMVp3V1dYUXBWTkJISWxOZ3M1?=
 =?utf-8?B?NTZVTjJPazUzdUkxSGd3SW0zK2M5REtheUowTGRkTC9rUUtFU3BBSVowZEFq?=
 =?utf-8?B?VWhMbUxnSENBWUFUYnUrU0ZqRUdrNlhwU3lIc2NuUDBsa2ROdnU5TnV1b3ZG?=
 =?utf-8?B?Ymc2VmhFZVNWWG4xV3pDaGNkendDOUZVUnNSYnB1VjdhemVNc2Y5ZVpTMzBQ?=
 =?utf-8?B?SFgvRG8rV3BKaXY4NHNZblNXS0xscWxSWmhyM3Y1ZGdQdUNIMUkveG1ndW14?=
 =?utf-8?B?SFdLbzdwUjYzQzZFbkFTRHhmUlBDNFdDd1kxYVdCbW92bzBDUnNrcms1clIw?=
 =?utf-8?B?dkVldHB1eDdzOVdtU3VVSEhYb2FHN294bU1qS29xQmZlTHZWd1hBOFRURXMv?=
 =?utf-8?B?akNNb0w2dkg4SXNxZS9jSGtEcWplZGFxeXkzNzloV0hDTkFaTjY4MWU1Z01n?=
 =?utf-8?B?VStNQ29zc2UrTExKTXlYdlJCV0lqcCtzR3JjYkNaU2tFcHlrL1ZrMlZJcmpP?=
 =?utf-8?B?WkVsQU1kNUFiRGdGMG1LdVhYei96bThUa1FDcGZ5K24vZ2dGck52RDNoMGRt?=
 =?utf-8?B?T0RmcTFlcFNkWXhVWi9YVk9pZSs1M1JNcFg0NlFqdGZRSUYxYVVTeTNDMFkz?=
 =?utf-8?B?UitmeERSTGptNU1CaUdSZnphVVVBK0c1RXc1QXRGd21MQnhMKzhKcEJ1T2tM?=
 =?utf-8?B?VFdRcFpwenFkYlhvY3FTS3JxY2dEeXJyZFBmZW1mYkhLTmJxSXVpL1ZvL04x?=
 =?utf-8?B?TmtieVRNcXRIbVRlOUhScW5qMDJDaDJjc0tYQU9KZkRxeXJoMHR5VkdLREUz?=
 =?utf-8?B?OEdKK2xZdjZiV1J0eDF6akkxeFoydDZYaStaQzZYYjlRRi9laDVjaENmVEtr?=
 =?utf-8?B?QnFrMldBSUNjd3dKa1BVQzF0Q3M0TFgxbk5xMWd3ME14N1dZUmdzYzhzYUha?=
 =?utf-8?B?TTFoclNXS3RTd3hpemh3VXJJR0pLeVNETFNsVTMzTUh1Vk5URFhSYlV4MVkw?=
 =?utf-8?B?Z3Y4UDFlRUZ2enJ3T3JQajhwOHJNYlhTUXhBQ0JyUEtWOWM5YWVFeHZqamQ1?=
 =?utf-8?Q?QUnoJzEJLAh0L66E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FE832DD6387F345B7F9647620BFED3C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q7BW55jxYL2DqkWCzxSVemM8fNQW6iSp9JPFB4EcCJ5vhImwBUE4zoOkdZHm6i+do0Hpg6svjvGVoOh+iCK8qxkWxiIZpl6wXneTT+IEVcvW2GuXA8+QPf4Aq2S0eg9LqQVRFvYcNREou41V1ENzYaQp6reMyhMfKXnPsJas0aGylEea6wHDwFvlZLQa2rqsk01z9BSQt38fmdeeQpSs6hKVAmYnDV6kCLr4RlHTjZVxr0sMoNJcoRUFtpoi7+QdqICw3RujWHTz0QQGA0p5pogDmS+vkzAho5lYwwFTjxGheO9724DcoaVcQxE0YrwLK9mzcoGJMw5nyc9NZVv1Vw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8fe1d5-0de3-48c8-d8a0-08dede236e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 01:34:48.3773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93sg5r/+CYu/6+ein4okf5v1cPqL6Nr1eLJGJL9q5h/vm4muJQBnfvK7ioWfLKqnHIQ86yHQJxQCyD39y0n+PVmk4XLdWgpHnSWljQmYA+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9710
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDE1OjE3ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
TW9uLCBNYXkgMjUsIDIwMjYgYXQgMDc6MzU6MTJQTSAtMDcwMCwgUmljayBFZGdlY29tYmUgd3Jv
dGU6DQo+ID4gV2hlbiBoYW5kbGluZyBhbiBFUFQgdmlvbGF0aW9uLCBLVk0gaG9sZHMgYSBzcGlu
bG9jayB3aGlsZSBtYW5pcHVsYXRpbmcNCj4gPiB0aGUgRVBULiBCZWZvcmUgZW50ZXJpbmcgdGhl
IHNwaW5sb2NrIGl0IGRvZXNuJ3Qga25vdyBob3cgbWFueSBFUFQgcGFnZQ0KPiA+IHRhYmxlcyB3
aWxsIG5lZWQgdG8gYmUgaW5zdGFsbGVkIG9yIHdoZXRoZXIgYSBodWdlIHBhZ2Ugd2lsbCBiZSB1
c2VkLiBGb3INCj4gPiB0aGlzIHJlYXNvbiBpdCBhbGxvY2F0ZXMgYSB3b3JzdCBjYXNlIG51bWJl
ciBvZiBwYWdlIHRhYmxlcyB0aGF0IGl0IG1pZ2h0DQo+ID4gbmVlZCBhcyBwYXJ0IG9mIHNlcnZp
Y2luZyB0aGUgRVBUIHZpb2xhdGlvbi4NCj4gPiANCj4gPiBVbmRlciBEeW5hbWljIFBBTVQgdGhl
c2UgcHJlLWFsbG9jYXRlZCBwYWdlcyB3aWxsIHBvdGVudGlhbGx5IG5lZWQgdG8gaGF2ZQ0KPiA+
IER5bmFtaWMgUEFNVCBiYWNraW5nIHBhZ2VzIGluc3RhbGxlZCBmb3IgdGhlbS4gS1ZNIGFscmVh
ZHkgaGFzIGhlbHBlcnMgdG8NCj4gPiBtYW5hZ2UgdG9wcGluZyB1cCBwYWdlIGNhY2hlcyBiZWZv
cmUgdGFraW5nIHRoZSBNTVUgbG9jaywgYnV0IHRoZXkgY2Fubm90IGJlDQo+ID4gcGFzc2VkIGZy
b20gS1ZNIHRvIGFyY2gveDg2IGNvZGUuDQo+ID4gDQo+ID4gVGhlIHByb2JsZW0gb2YgaG93IGFu
ZCB3aGVuIHRvIGluc3RhbGwgdGhlIERQQU1UIGJhY2tpbmcgcGFnZXMgZm9yIHRoZQ0KPiA+IHBh
Z2VzIGdpdmVuIHRvIHRoZSBURFggbW9kdWxlIGR1cmluZyB0aGUgZmF1bHQgcGF0aCBoYXMgaGFk
IGEgbG90IG9mDQo+ID4gZGVzaWduIGF0dGVtcHRzLg0KPiA+ICAtIEV4dHJhY3RpbmcgS1ZNJ3Mg
TU1VIGNhY2hlcyByZXF1aXJlcyB0b28gbXVjaCBpbmxpbmVkIGNvZGUgYWRkZWQgdG8NCj4gPiAg
ICBoZWFkZXJzLg0KPiA+ICAtIEEgZmV3IHZhcmlldGllcyBvZiBpbnN0YWxsaW5nIER5bmFtaWMg
UEFNVCBiYWNraW5nIHdoZW4gYWxsb2NhdGluZyB0aGUNCj4gPiAgICBTLUVQVCBwYWdlIHRhYmxl
cy4gWzBdWzFdDQo+IElJVUMsIFswXVsxXSBoZXJlIHJlZmVyIHRvIGRlc2lnbiBhdHRlbXB0cyB0
aGF0IGhhZCB2YXJpb3VzIHByb2JsZW1zLCByaWdodD8NCj4gSG93ZXZlciwgWzFdIGxvb2tzIGV4
YWN0bHkgbGlrZSB0aGUgb25lIGJlaW5nIGFkb3B0ZWQgaW4gdjY/DQo+IA0KPiBEaWQgeW91IHBh
c3RlIGEgd3JvbmcgbGluaz8gU2hvdWxkIFsxXSBpbnN0ZWFkIGJlDQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2t2bS8yMDI2MDEyOTAxMTUxNy4zNTQ1ODgzLTIxLXNlYW5qY0Bnb29nbGUuY29t
IG9yDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS9hWVlDT2lNdldmU0pSMUFMQGdvb2ds
ZS5jb20gPw0KDQpPaCB5ZWEuLi4gSSB0aGluayBpdCBzaG91bGQgYmU6DQpLYWkncyBvcmlnaW5h
bCBpZGVhOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vYVhFTk5LakFLVE05VUpOSEBnb29n
bGUuY29tLw0KU2VhbidzIGZpeHVwIG9mIGl0Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3Zt
LzIwMjYwMTI5MDExNTE3LjM1NDU4ODMtMjAtc2VhbmpjQGdvb2dsZS5jb20vDQpUaGUgcHJvYmxl
bSB3aXRoIFNlYW4nczoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS9hWVc1Q2JVdlpyTG9n
c1dGQHl6aGFvNTYtZGVzay5zaC5pbnRlbC5jb20vDQoNClRCSCBJJ20gYSBsaXR0bGUgb24gdGhl
IGZlbmNlIGFib3V0IGhvdyB1c2VmdWwgdGhlIGxpbmtzIHdpbGwgYmUgaW4gZ2VuZXJhbC4gSWYN
CnNvbWVvbmUgdHJpZXMgdG8gcmlwIGl0IG91dCwgaXQgd291bGQgYmUgZ29vZCBicmVhZGNydW1i
cyBJIGd1ZXNzDQoNCj4gDQo+ID4gIC0gVXNpbmcgbWVtcG9vbF90IHRvIHRyYW5zZmVyIHRoZSBw
YWdlcyBiZXR3ZWVuIEtWTSBhbmQgYXJjaC94ODYgZG9lc24ndA0KPiA+ICAgIHdvcmsgYmVjYXVz
ZSBpdCBpcyB0aGUgY29tcG9uZW50IGlzIGRlc2lnbmVkIG1vcmUgYXJvdW5kIG1haW50YWluaW5n
IGENCj4gPiAgICBwb29sIG9mIHBhZ2VzLCByYXRoZXIgdGhhbiB0b3BwaW5nIHVwIGEgY29udGlu
dWFsbHkgZHJhaW5lZCBjYWNoZS4NCj4gPiANCj4gPiBTbyBkb24ndCBkbyB0aGVzZSBhcyB0aGV5
IGFsbCBoYWQgdmFyaW91cyBwcm9ibGVtcy4gSW5zdGVhZCBqdXN0IGNyZWF0ZSBhDQo+ID4gc21h
bGwgc2ltcGxlIGRhdGEgc3RydWN0dXJlIHRvIHVzZSBmb3IgaGFuZGluZyBhIHByZS1hbGxvY2F0
ZWQgbGlzdCBvZg0KPiA+IHBhZ2VzIGJldHdlZW4gS1ZNIGFuZCBhcmNoL3g4NiBjb2RlLiBNb2Rl
bCB0aGlzIG9uIEtWTSdzIGV4aXN0aW5nIE1NVQ0KPiA+IG1lbW9yeSBjYWNoZXMuDQo+ID4gDQo+
ID4gQWRkIGEgdGR4X3BhbXRfY2FjaGUgYXJnIHRvIHRkeF9wYW10X2dldCgpIHNvIGl0IGNhbiBk
cmF3IHBhZ2VzIGZyb20gYQ0KPiA+IGNhY2hlIHdoZW4gbmVlZGVkLiBOb3QgYWxsIERQQU1UIHBh
Z2UgaW5zdGFsbGF0aW9ucyB3aWxsIGhhcHBlbiB1bmRlcg0KPiA+IHNwaW5sb2NrLCBmb3IgZXhh
bXBsZSBjb250cm9sIHBhZ2VzLiBTbyBoYXZlIHRkeF9wYW10X2dldCgpIG1haW50YWluIHRoZQ0K
PiBOaXQ6IEluIHBhdGNoIDksIFMtRVBUIHBhZ2VzIGFyZSByZWdhcmRlZCBhcyBjb250cm9sIHBh
Z2VzIGFzIHdlbGwuDQo+IFNvIG1heWJlDQo+ICIuLi4sIGZvciBleGFtcGxlIHNvbWUgY29udHJv
bCBwYWdlcy4iIG9yDQoNClllYSB0aGF0IGlzIGJldHRlci4gVGhlIHBhdGNoIDkgY2hhbmdlcyBh
cmUgYWZ0ZXIgdGhpcywgc28gaXQncyB0ZWNobmljYWxseQ0KY29ycmVjdCwgYnV0IHdlIGNhbiBt
YWtlIGl0IGNsZWFyZXI6DQouLi4sIGZvciBleGFtcGxlIFREIGFuZCB2Q1BVIHNjb3BlZCBjb250
cm9sIHBhZ2VzIGZvciANCg0KPiAiLi4uLCBmb3IgZXhhbXBsZSBjb250cm9sIHBhZ2VzIG90aGVy
IHRoYW4gUy1FUFQgcGFnZXMuIiA/DQo+IA0KPiA+IGV4aXN0aW5nIGJlaGF2aW9yIG9mIGFsbG9j
YXRpbmcgZnJvbSB0aGUgcGFnZSBhbGxvY2F0b3Igd2hlbiBOVUxMIGlzDQo+ID4gcGFzc2VkIGZv
ciB0aGUgc3RydWN0IHRkeF9wYW10X2NhY2hlIGFyZy4gVGhpcyBwcmV2ZW50cyBleGNlc3MgYWxs
b2NhdGlvbnMNCj4gPiBmb3IgY2FzZXMgd2hlcmUgaXQgY2FuIGJlIGF2b2lkZWQuDQo+ID4gDQo+
ID4gRXhwb3J0IHRoZSBuZXcgaGVscGVycyBmb3IgS1ZNLg0KPiA+IA0KPiA+IEFzc2lzdGVkLWJ5
OiBHaXRIdWIgQ29waWxvdDpjbGF1ZGUtb3B1cy00LTYgQ2xhdWRlOmNsYXVkZS1vcHVzLTQtNw0K
PiA+IENvLWRldmVsb3BlZC1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2ds
ZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29t
YmVAaW50ZWwuY29tPg0KPiA+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS9kZTA1
ODUzMjU3ZTljYzY2OTk4MTAxOTQzZjc4YTRiN2U2ZTNkNzQxLmNhbWVsQGludGVsLmNvbS8gWzBd
DQo+ID4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtL2FZcHJ4blNIS0hVdGs3cHRA
Z29vZ2xlLmNvbS8gWzFdDQo+ID4gLS0tDQo+ID4gdjY6DQo+ID4gIC0gRmlsbGVkIG91dCBsb2cg
ZnJvbSBTZWFuJ3Mgc2VyaWVzDQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL3Rk
eC5oICB8IDE3ICsrKysrKysrKysNCj4gPiAgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jIHwg
NjUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDc2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RkeC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
dGR4LmgNCj4gPiBpbmRleCA3NGU3NWRiNTcyOGM3Li4xOTFkYTg0YmJmMmExIDEwMDY0NA0KPiA+
IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RkeC5oDQo+ID4gKysrIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vdGR4LmgNCj4gPiBAQCAtMTU1LDYgKzE1NSwyMyBAQCBzdGF0aWMgaW5saW5lIGJv
b2wgdGR4X3N1cHBvcnRzX2R5bmFtaWNfcGFtdChjb25zdCBzdHJ1Y3QgdGR4X3N5c19pbmZvICpz
eXNpbmZvKQ0KPiA+ICAJcmV0dXJuIGZhbHNlOyAvKiBUbyBiZSBlbmFibGVkIHdoZW4ga2VybmVs
IGlzIHJlYWR5ICovDQo+ID4gIH0NCj4gPiAgDQo+ID4gKy8qIFNpbXBsZSBzdHJ1Y3R1cmUgZm9y
IHByZS1hbGxvY2F0aW5nIER5bmFtaWMgUEFNVCBwYWdlcyBvdXRzaWRlIG9mIGxvY2tzLiAqLw0K
PiBvdXRzaWRlIG9mIHNwaW5sb2Nrcz8NCj4gDQo+IFByZS1hbGxvY2F0aW5nIER5bmFtaWMgUEFN
VCBwYWdlcyBhcmUgc3RpbGwgaW5zaWRlIG11dGV4LCBlLmcuLCBpbnNpZGUgb2YNCj4ga3ZtLT5z
bG90c19sb2NrLCB2Y3B1LT5tdXRleC4uLg0KDQpPay4NCj4gDQo+ID4gK3N0cnVjdCB0ZHhfcGFt
dF9jYWNoZSB7DQo+ID4gKwlzdHJ1Y3QgbGlzdF9oZWFkIHBhZ2VfbGlzdDsNCj4gPiArCWludCBj
bnQ7DQo+ID4gK307DQo+IA0KPiBUaGUgcmVzdCBMR1RNLg0KPiBSZXZpZXdlZC1ieTogWWFuIFpo
YW8gPHlhbi55LnpoYW9AaW50ZWwuY29tPg0KPiANClRoYW5rcyENCg==
