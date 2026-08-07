Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14D34751B;
	Fri,  7 Aug 2026 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786135127; cv=fail; b=RleTObVW5g2jLTW3NlyrfV9LzrOK4hup38BYqqN7tlz6wkX/leUCP/8GFI2FBYr/25DHwpCdZ8nlbWfT9z1TrKEVva86BZfdp7AiM1HLSdYbfznTVyBHi5ZwN8X0mts6oPfL4buQAgDaqqth1tNqefUMDlC6a+HakKDBF0inw+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786135127; c=relaxed/simple;
	bh=Rj2zQ6RF/3tSLdMD41vYkObNMpE0TIqse1apaXiKOe8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMWiDYlRu+IJDWiABjj5opWpX5kipMhh+EqY1grzX+Hh+Xs1x7IDwIADVaq73wypvtvc7NTyE8NDqsdffDaIiJJXxDNDahKRKO33fy4m1sH3ly2SG0Lii5efCJRsbU3LWVkdz6yST4mHReCCKIQhPjGM1lvzojj/PjueOxVx6V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gk2YNAgc; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gk2YNAgc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786135126; x=1817671126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rj2zQ6RF/3tSLdMD41vYkObNMpE0TIqse1apaXiKOe8=;
  b=Gk2YNAgcji2DJkTFpPTvfaooEg29+oivdMIaZq9kQjVusYEEPX/bq2eW
   ARwf/mcYI4KcYch6jmuI1sNkJqKm919gAxhx/J0jV22Tw5ykccC3+Q7TF
   FJ+NlSeOVaFWi9LLtvJvKEpQrGUx8puKdDWedEZTYpMJHyG4HZX/Uh9A8
   mk3TdIL6DVK5RTx89YffbhXk5Nr1bHlpdwtaMo8S+hIIYuw987E9HDOJD
   ChCUkTY/tpAmJGPRRRGHBYnog1W6FAmqN1iWGiXm7Oj2vSbZi9Vyk0gAE
   iNChmmRpUDTGucn3IwmQUi+zPGOv3elJ8rp1fWF3F2/M+leyLniGLAmnc
   g==;
X-CSE-ConnectionGUID: Zulw618CRju8+RsUzgmdEA==
X-CSE-MsgGUID: k0VQJB5nTbWS4F/2ncSbmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="90630259"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="90630259"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 13:38:46 -0700
X-CSE-ConnectionGUID: eZpm93TBTK+ZulR0tQd0Pg==
X-CSE-MsgGUID: T3e2oZgeRsKlnBpyr18PKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="261200865"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 13:38:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 13:38:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 13:38:45 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 13:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCdNQ+bs+CQJwMTUDycZR2ooYsTsTGKdRcIRNI+pzjNSaeQLOlx1SqjKHoGbh59v9Zh+SSt1S1rvlwuyEoLUp06LYvolrlkUtnUY0eJzbloj8Xjw/W/BswRtOmAdd1a7Rzf4DOPXPC4MJm2CtmdOLja9iHzWod67iJolV0Tjl0Xf3IB/x3FtQyUrPY5TS+rgtpfLik5TlTodOn+YGalR7+aSGeXUsjFRL7d310XEC3a3Iy/60o7rtum1A4VsVb5NgB9NwBoaMJfLLb2M6q9rmp5zqcaIgTPtjAaDOsLbkTPdCXjWFNy7hN6hU2i/t1ffHCzYtI0IOXILBeSk83ShUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj2zQ6RF/3tSLdMD41vYkObNMpE0TIqse1apaXiKOe8=;
 b=rirSwnV8xorlOvuUC7ywBXOSBi1lnHukQ14bHvbF0C8llRS8542mzHkjFsKhEP7EjNHF98EkXTUBwvSKLf0Nb62Mz5VVIi4tiQO+Isnxw42i6vo+7sqLvWMX/8xvHizH5vMNg9XNLrp7bFRgVFSCe0XFzKzqIckEjTKHYhhY5eUlokmM9OznWGGINXbFaPRLEpZ4Q8BVl6ComN9iLQClhP5hE0mSvel6stioExlC4rnMPnZ9kk3RTQUvxawXgGq4NrIazaidrV2NMOQzggxb0sPE7lWK24CuvW+rioKekwpUt+3xsotdSaHauQP4C6dyUf4pQw98c+0JqQRyY3xFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY8PR11MB6937.namprd11.prod.outlook.com (2603:10b6:930:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 20:38:41 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 20:38:41 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Huang, Kai" <kai.huang@intel.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Top-up memory caches when retrying "map
 private PFN"
Thread-Topic: [PATCH 3/4] KVM: x86/mmu: Top-up memory caches when retrying
 "map private PFN"
Thread-Index: AQHdJexOBXYG+xaP8k+TlGwBevb9sLaTDZuA
Date: Fri, 7 Aug 2026 20:38:41 +0000
Message-ID: <7867c759880de0ea4628deccfaa077a5d1c5fce9.camel@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
	 <20260806214050.78058-4-seanjc@google.com>
In-Reply-To: <20260806214050.78058-4-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY8PR11MB6937:EE_
x-ms-office365-filtering-correlation-id: 0c268c03-8a50-4937-7b99-08def4c3de01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|10067099003|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: McDJRo9G6e97cKP4+Z9DIR47SNLt9d6q4FX+iT/Hzjbu6BPIc3SZ4RjDAQRL87M+fsS6ZPoQkTus2gFQXedO4fg1wNOL9M9FMdLdHEOjYb9rEWhqXCgyK68zRGq3YCSAcGLA0mnMD8Tjp1YrRvkYTYG4g/p98AnIldgthDq4x5UFegG9BQrcg2PND25Qw7emMrzsb+QirDJAkTI8cdfwhqWI+S2lSWM5S0/Af/Dp7nt7SLI6vuhtIUTSLhXi/4ckPznx6Z3Ajo0a1lYw8NcSr4QU+gBWrqCO8ctKBzLK/oKxAcJB30uunU4HBPZ17bdQJ01m+r0iiDHwYnv0Ax7O6R5UTafBR8qLnFhjvh0s/w1tgJTzcmG0TSLwMGAkc44CO3NQa/S+TAHo2rEXAI1+WNeN4WZOk+ruoxLQDb6pPYPICXFBexz/Fj/QFfPrVrUdpdQAof1c5DGE12clq13MU5wc3f6fw7eRevITUGpiRmPTYP1CepJra4+pH0jLc2BCcfgXAhsl+7NwVOTlYkLDdQqH6N59CghVZPA2llos4BUCQ2/1aaPi2G7peRnRSnlORdvGdpeFUYQENw+fWfWumKMJItEJ5uGOvxQIUub6+7BnajKnEWCk5eyoalzH0qQxet2Gg3HpmbfIXC2StuCcABSpota6pAdCq2UrwURdWP3s2TjhLG7y0Ed/YxRuxBHHV2147iqfqk9PF+CCquNJxL/6ToUKijjggVoRHbZHr5M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHJmaStaZXNDTy9FTzVhVlY1N2l0d1VCT2lRVVgrc0JFUmhWZVE2TElaNzJP?=
 =?utf-8?B?aVltWFp6ajRWQWIreHd0WDNWN2tBaDZzaURHU2xNSDV4RXFPcnlHQXZJTU54?=
 =?utf-8?B?SnJJQ1BCeHpJSUpSZnExYk5Kd0NXRkFsV2dqTGJWNVA0UG5HaDErY2l1MUdw?=
 =?utf-8?B?WU5OczNBc2YrLy90SmxNN2xoanZ5SE5qVTUwejdwTXBhdTJQeHlkcHhrMitE?=
 =?utf-8?B?a1RqcHY5a0l1TFhyaFBuM1l3LzdsZ3phV2ZiYjljVks3WEdyUnlnT2xXR3ZS?=
 =?utf-8?B?UHZHRTJrUzA2cG52MGxwbGVxYmZab1poUk9CTWliWGtYejErM0JVOStWb0la?=
 =?utf-8?B?OUZkaXZVQ3JOZHkyUEdyRGttc2xxeUNHTVgyQUQ3UU1RWnBXOW1tZlNLbDNz?=
 =?utf-8?B?Ni9nckhsMDVSZWlqcy9FalB4Y21RZVdyOTRiQk9nWnlOVHhPaU9WdEdEY1VW?=
 =?utf-8?B?VFg5d08wRStpZitVL285RklsZXFkcTdlVEFhMDkzbmcyQSs3MDMxRkZzQVly?=
 =?utf-8?B?QzdqVEtzTytVYkxNcW1Ca0ViQm4zTGlMZ0x4bDRzWkxUZzYrMHVDL0djZjdu?=
 =?utf-8?B?QUpQWTdQQTN2dWd5eFQ3bnVncGxoSFNUQmVFWnZqMElPNURvVllFZjgrb1JC?=
 =?utf-8?B?V21YZklBdnBET25nencxR25JRVByWmlJOTFTU1lXb2VkQnA1MWtyOXBobEFp?=
 =?utf-8?B?N3BUaEErd1ZZVDhBblFMR1JMU3JUeHZFYlJhdkxUT3pha2U2TkdVU3VXb1BZ?=
 =?utf-8?B?S0VHUmV2SE9qNEFKUHdwcHdWeGdOTFc1NnBpQUNjZ0FwdFprRDNIZHk1aUxH?=
 =?utf-8?B?MW9GKzBINFZ2NU5NUi81VDNjNklDa0lDQ3B3MmdmQUlFYUM1a3A4NDBmVllx?=
 =?utf-8?B?MVM4VGtNYUdUTXZCWjR0a01ySDNYZGtJOGFDN2E0LzRyZ0xkNE5FWDV6anY1?=
 =?utf-8?B?RyttZ2FjLzc4UlVoYmI5VkRVRnpUZzBXRTNVTExqcnBTSmtmZGVvazhnRmps?=
 =?utf-8?B?cjhFY3NVQWZNM3ZWeUhRYTJzcytGekQ4eGZlZ3BMbzhIRk0xVEZJdDI4SGRW?=
 =?utf-8?B?TElTR3Z6Vk5iU0ZPbXpIK3NubnVWQlZZMm5TWmVrL0o5cGprenYyeDlxdElF?=
 =?utf-8?B?VjlLVFRlQW9rSEVjamV3MEVlQ3NuTEUyNm5PSTVRT3B0VDVTNk1HWFNLaG5I?=
 =?utf-8?B?cFJNMVI0c2FIUlRBSDBqUXdyUzgyd2E4V05YbFFCM29FSEgzbkNMSXhaNlo1?=
 =?utf-8?B?QlFBNXRXOWl3aFNnMEpFd1NWMFFjc0dWYWZZMXpJcnNQREIxWEVzalZxTEJl?=
 =?utf-8?B?ZllvTzRvM3FjcGovR25FUWduWFNXRCtHYm9ldEVFQ2hkVlh0TzB6MDNRbmVQ?=
 =?utf-8?B?OXprVHdYUmJNVlUwRmZJQUdmZnBCMjNvQnI5N2lGUlJyT1Ryc3kxR2RTZWdN?=
 =?utf-8?B?emQ0enh1T3Z3WFAwNU5KYkxuaDRvNk1yWExhS3RicVo4N0pQcVE4bVpQUzRK?=
 =?utf-8?B?d0xKR3JjYnJEOFUxeHo3SnN2aVBmVkd6Uml4ek9wL09aM056TmpRU3k1Qmpl?=
 =?utf-8?B?c3Nvc2J2dWlYSWQ0aHkxUlRDb3AzM3NTSks0czNJNkN1VUl3NHpHMUxtWlZ2?=
 =?utf-8?B?OXhqbXY0OUNDOTdMN3pQYm1RU01DcWRmbjJBRWduQTNnckVGQ2YwaW5VV1ky?=
 =?utf-8?B?enJQYlFBaXUzaHIrOGJuQ0hlRWJHeGUzaVZxZ0NyOGh3Ym1oYzBqVlNsNUVY?=
 =?utf-8?B?NTlLMlNNL3o3NjBVdEcrSTlBQVkyZkhmb2xlSXcrUnBGTWo3OHdMcHVQRXYz?=
 =?utf-8?B?d2pZWVFRZ0wzRDZ5SlhGS0QyN2ZDVDhHNTM5QTRRNkdjMzZQVklDd0RLd05W?=
 =?utf-8?B?ZXVVS2Z2VExjSHBVbW1CSS9GSk5EZkFwRUpRRlZGZk53MWJHM0pYeUtURUJt?=
 =?utf-8?B?SUd6eTJhL09XUm8vSTVyT01xN2ZheDNpRWxKVEtHck4wbFhwNVEyZEg4b0Mw?=
 =?utf-8?B?VkFJV1c3cno2TUU3UVNDdHNaN1pleXRLdEFwMCtiRWZJMHJqZ3QyMmtSQXFJ?=
 =?utf-8?B?MDUzdzZPeXFyWFJYUVBoT2dUdWdvc0J1UUFoNlZra1pVQWxzdGZFamN0Q3lv?=
 =?utf-8?B?cnlvT29URnZvVGFacERsem9YRElLRmc3eXlvcnR3WGFhVjRZcmJoL3NwTVla?=
 =?utf-8?B?Qk1DVXJNWlNvc3ZTQVdQak1EdEFWYTkwTGtwYzFvNEdNTmdsU29BSEtnamIr?=
 =?utf-8?B?K2RkVis1QjlIWE5lbXJ6c1FtMmNMMHRoeW9ITXV3clJ2RUZrQkVMelpwNENm?=
 =?utf-8?B?Y09MYUVDOWVENU9HdjltRmJwd2FOWUZJZVZMazRyUGQ1dHhDOGkwME9aMFhz?=
 =?utf-8?Q?pwfV22q7cO4IrzRs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F47BA9C2EF5DA459C55360293F243FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CDxXoQbpa7MY43vQPiCnGy7LJehDEZg4dCBR3JITR3G8tdmaTTvdzYlkBwk9kca2OvEcfN5VOUCV41pgsYMZg7KrZ5cGOg99y353hZKLSjQxr25QB873EceTmacgSMznfJyVvvlWShRxXqLM5QoswMcoRgrkv03cUz8qyosGpfwlOvs0eU/XxMDgLySWKESCLTRaiyzcilRrPTYnW7VMrDdqwtAXxKq1RT0YftbW0riS3yMjUsIXdneJ7yXzpqg/Q7tSWG0oJiurtKf+xI8m3Jc4g1ho2fFtXQQlkorsyfnKdKik1QZaHytwDN1Es4g6TvdrM0bwWwXwxy1zGqOgTQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c268c03-8a50-4937-7b99-08def4c3de01
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 20:38:41.3367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMh3+vHJg61BsLK6A2Uv0Pk/r9GTkcpAcMZ9PsdgTfUL6nV0SkXQvrtnJFtuGMG+bFlkiFiKEre1dPweF7LWtxgkTuIK05CzXra0FS9U+wE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6937
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTA2IGF0IDE0OjQwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBXaGVuIG1hcHBpbmcgYSBwcml2YXRlIFBGTiBpbiBURFgncyBwb3N0LXBvcHVsYXRl
IGNhbGxiYWNrLCB0b3AtdXAgdGhlDQo+IG1lbW9yeSBjYWNoZXMgb24gZXZlcnkgYXR0ZW1wdCB0
byBtYXAgdGhlIFBGTiB0byBoYXJkZW4gYWdhaW5zdCBidWdzIGluIHRoZQ0KPiBtYXAgZmxvdyB0
aGF0IGNvdWxkIGNvbnN1bWUgY2FjaGUgZW50cmllcyBldmVuIGlmIG1hcHBpbmcgdWx0aW1hdGVs
eSBmYWlscy4NCj4gRS5nLiBhcyBwb2ludGVkIG91dCBieSBTYXNoaWtvLCB0aGUgaW4tcHJvZ3Jl
c3MgRHluYW1pYyBQQU1UIHN1cHBvcnQgY291bGQNCj4gY29uc3VtZSBQQU1UIGNhY2hlIGVudHJp
ZXMgb24gVERYLU1vZHVsZSBsb2NrIGNvbnRlbnRpb24uDQoNCkkgdGhpbmsgaXQgaXMgdGhlIHNh
bWUgZm9yIHRoZSBvdGhlciBjYWNoZXMgY29uc3VtZWQgYnkgdGhlIGZhdWx0LiBJIGd1ZXNzDQoi
ZS5nLiIgY292ZXJzIGl0LiBCdXQgaXQncyBub3QgbmV3IGFmdGVyIERQQU1ULg0KDQo+IA0KPiBI
YXJkZW4gS1ZNIGV2ZW4gdGhvdWdoIGNvbnN1bWluZyBhbiBlbnRyeSBvbiBmYWlsdXJlIGlzIGNv
bnNpZGVyZWQgYSBLVk0NCj4gYnVnLCBhcyByZXRyeSBpcyB1bmNvbW1vbg0KPiANCg0KVGhlIGxv
Y2tzIGhlbGQgYnkgdGhlIHNvbGUgY2FsbCBwYXRoIHdpbGwgcHJldmVudCByZXRyaWVzIGZyb20g
YmVpbmcgbmVlZGVkIGR1ZQ0KdG8gVERYLXNwZWNpZmljIGRldGFpbHMuIFNvIGluIHRoZSBwbGFj
ZSB3aGVyZSB0aGlzIGNvZGUgbGl2ZXMsIGl0IGlzIGEgYnVnLiBCdXQNCmNhbid0IHJlYWxseSBi
ZSBoaXQuIFRvIG1lICJyZXRyeSBpcyB1bmNvbW1vbiIgc291bmRzIGxpa2UgaXQncyBhIHJhcmUg
Y2FzZSB0aGF0DQppcyBoaXR0YWJsZS4gSSBndWVzcyB5b3UgbWVhbiBvbmx5IGluIHRoZSB1bmNv
bW1vbiBjYXNlIG9mIGJ1Z3MuDQoNCj4gLCB0b3AtdXAgaXMgImZyZWUiIGlmIHRoZXJlJ3Mgbm8g
d29yayB0byBiZSBkb25lLA0KPiBhbmQgcG9wdWxhdGluZyBhIFREWCBndWVzdCdzIG1lbW9yeSBp
cyBhIHNsb3cgcGF0aCwgaS5lLiB0aGVyZSdzIG5vDQo+IG1lYW5pbmdmdWwgZG93bnNpZGUgdG8g
dGhlIGhhcmRlbmluZy4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBTYXNoaWtvIEJvdCA8c2FzaGlrby1i
b3RAa2VybmVsLm9yZz4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
NjA3MTgwNjEwNTAuRTE3QjAxRjAwMEU5QHNtdHAua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5
OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gLS0tDQoNClRoYW5r
cyEgQW5kLi4uDQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21i
ZUBpbnRlbC5jb20+DQo=
