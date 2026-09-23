Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE92C08D0;
	Wed, 23 Sep 2026 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123663; cv=fail; b=p+ebLQfLi2JPYGQqe0HCeQ2G4p6D96nMThLXeS1dAvEI/yNkPG2ha1KFc6n3imwVrLm/u3qQXqBx4FDMx1K4rHgyy9WmsvUt4WNdwfgXOSfL+85iY7NQ0R2psMnlk3hdzRnZJSzQM8KK6H72SyMfcnfInokUQI2t0g82SWmZYms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123663; c=relaxed/simple;
	bh=Q4kxdglGTBVwbePftdvNxY728zBziprConPCNym3E1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RXBdGuKz5YZrUV5oAFRXr/f/n5qHcQytCnCQbiKq3PbG91CFlPPlGsVau/G7I+RAP+kDOYVOsAW7M7ndUQTNGtcnxVCi+dBfHJ3TC1RC5RkC/5pIL18DuyCTwrLvZblDp9CTmBW3AFIigJg2Czen0hl59u28hiP5bBiXmCHEgJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSGcbNRl; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSGcbNRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790123661; x=1821659661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q4kxdglGTBVwbePftdvNxY728zBziprConPCNym3E1U=;
  b=LSGcbNRl5sehIbwdWFxoHV4NS0Bg74RDFdc0uiDR1N4dyuuWa4Q4yrLe
   07EBFCYcYVCXnbeBE1H2k8P64Y+m2l5rFv7LtZThot6sAH1C5ALstmhFU
   fUbVGrjAI3tPh7b2IjabE+bruKNb8vGU4tUHLGo6TELSVcRRhAE7erAXx
   EAIOM9M7uxNx5Tq0bS6KTUlCm6s5WHdxNPVvsQx0E1MHt9x7METaMMn4e
   ykb1w0WyCOQy3+s7t1Z2N3yB2N+0o/ZoNqiknJvG6n6PXpqs+Blr0nzdQ
   a7562LpAQ91925ACyFfdNQ68l1/HNVLf74WKsxuKLTBsZo9yCsdY2Alvt
   Q==;
X-CSE-ConnectionGUID: l2YJ/whQSJSQNkQN1Fi4ag==
X-CSE-MsgGUID: t6oAs0bRSFKYh+391ZV4Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="94602144"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="94602144"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:34:20 -0700
X-CSE-ConnectionGUID: R93NNYEGRHmp3U+B4xrw7w==
X-CSE-MsgGUID: RXB1TS45SZuUNoLpVGJcHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4384045"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:34:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:34:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 17:34:20 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:34:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onf7lzecwq7rX/I598tUG0zirIVD0AyMGUOXNisbpSAJSnmzU8Zj5N73GCyhKvo0aYFbAgwC6rAaPtd8GeMEyYL/jO876BzwD0NttO+F43aTleWckMF6LRjBlLW3HOxdLKp0pXCpHno9y69bWWNJLA9j6AqwlsXJe6JDx+WXs6wb6092pSFI5SOAP74Pj1jCJ7hzbPjrMF4HcPLo1d1c2hEY8qZmCK4+ohGTUebwJcrUhD3lSMmoUrn7UD4xQKcGQJTj6OcgZ2YwZrOwZ8IfFuc9zVEdPVLNK+yvC/uQUM6TE4gP7M+oXjLNLAKpjcoP62jRrmmXjgqUUDolWmchCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4kxdglGTBVwbePftdvNxY728zBziprConPCNym3E1U=;
 b=Y9nMD/C7fyYf2+cBomweTopjQF+sg/pldrgWPUFBQteNI2Ic4Wt1Pr+egRBwe/W3MpXCipLGc5kzytQZD1JdL+QLE7iUK+LbsD3/pGmiGY94eqQlu3HbXk3g75317Sin3xhpZA2RMYoJSLhdmVxPuGlRaZrdd529g4qA66ngOBYhhvnkcnCxKhpP1zSP8ZTl97otn3k5g16lc/ERTcGuX3uX6nXX2ni0/x+GB+4MTVPTX/UoljYC1eO4Vk78lO7rJsiDkx6rLEdiVoVtkIwyEpuSdv3WgJ/f1hAYer50K2S/Kl9MyEdF9zPG8dfccUf2vSDOgJsawWiB75xNAco53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS4PR11MB134916.namprd11.prod.outlook.com (2603:10b6:8:4f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 00:34:17 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 00:34:16 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Maloor,
 Kishen" <kishen.maloor@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v4 3/4] KVM: TDX: Filter configurable CPUID bits
Thread-Topic: [PATCH v4 3/4] KVM: TDX: Filter configurable CPUID bits
Thread-Index: AQHdRnUzPgAzWhphJ02QA2Q5FI7th7bbVJaAgAADSACAAAG9gA==
Date: Wed, 23 Sep 2026 00:34:16 +0000
Message-ID: <e7182b3c03a0e39cb60392b4d75111255418d6cf.camel@intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
	 <20260917072548.2314491-4-binbin.wu@linux.intel.com>
	 <d6bf5183b74b6c6f595001ee753405ea94a6042d.camel@intel.com>
	 <4c553712-d2b3-44d5-9c09-ba51a5f3729e@linux.intel.com>
In-Reply-To: <4c553712-d2b3-44d5-9c09-ba51a5f3729e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS4PR11MB134916:EE_
x-ms-office365-filtering-correlation-id: daf3b86a-d4bd-48bc-ffdf-08df190a6673
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 4J2a/DKSMYETqJniBVUawvhLDmgM27drs47J8v48Py3QlG3Iu8p9gG3yrHX8vaKPJh/s3RzaKAvSP945Rx+4Uzuixkbj3c7KAqtw7j2M4I2fwz7CH46m5qtYzDBWUKmdU3awU8100M5GJIZe/GRgrXVUsqr38nwCJ20cyGE26vAC8kSKOA/5M4LWmsFXjiyGrnNdyiMMtAkkzTCKWukF9GJSt6BBIvNPBDtSHg695/N5RbfDOYJ8oOXhBZ5Y8a52PtdrOuSzb9HOXWGNHa9mwSf9TAexelkKBe0pFDQTTz7MLCiN+gxbg6MXyWSH5yP6SGH3TsMblv62R/JYQtHsuucAxC6sq3mVGlIg1GzmDS+GGMPl/wKIwvoONy33j7++yxRx+vwKylk4FVbEw/93/UjvQZqDezoGDpwHmCzea3mUCgGB349eKZlPTml5Xv35f2/AeAYc2UEspecCVx/YwYr1JfyMdy0jk0KFo0kWKJ/OUUR7FW4VAu+AoBTgA9JO0MoklWX3S1kxxYMGtMF4qyMZq737TxXr8Eto+bSA7CPolmzXc616S9QBas9l5DMqSdOfl0VgdiL8GG1Vw6Q9ZROGd0JQfiT0xndzeYGTEk885kNUEVa8TDputkKUV2Tuikn9rAGBFdUuGwkixQxFhERoKwChMXs8AvOMydSgTnIJ8Jxf3GP2REvgT9DTQftPhYo7wnDYamPl4PsxK8ABLMVUNAeiiczMQeO3fiK2Mcw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2VMVk9QZUxPQ3k2SGEwM3hhcHdXRjlhT2VEb0JKSmhnTlBDVndCVlAvb2pL?=
 =?utf-8?B?S3hNdmNrbmFXR0ZqK1hVWlFVMXlkUGRRbytTdi9rUDVjYndKajk3T0U5RVVu?=
 =?utf-8?B?MXBYTUJVMnF0K01rSVVCM2FVNHRYWjhrOWdnQjFHMVUwSWtod2N6RVUxY3dN?=
 =?utf-8?B?bGFtR08zZERjWi9UZWxOMzVnVWdNTFVuNkVLQ28yT0FhalZSN05td3Ntd0JQ?=
 =?utf-8?B?NnZkZk0wU2svTUhxR2hjZlV1S3Nna3ZzdkRUTEJpemZteExkQkxyWXhhVktu?=
 =?utf-8?B?ZmxaUHRjMGZzUlVnUFVGT052VmJYRUN2TnJGcmNXN0hZY0E4aTV3U01nNmtG?=
 =?utf-8?B?ekNPQU52aGk5YWxvQXpWdkZNNW51b0tBbEZLZzNJZ29La3Vta3FLRUEvV1lH?=
 =?utf-8?B?Z0Iwdlh1YVVVSlg4dy9SWEs5dlVqc3lHQVZreUhuZ1piRHlRY2NVWUUwcWhJ?=
 =?utf-8?B?d3JQNkFWTHhnOWd6YjdZdFFUdGVMMzNkb0JMQndTUUZnSldybHhTM3A2SVBN?=
 =?utf-8?B?WmdKckplTHlwVXpoaGsyVUU3NEpFcWdqYnZhSUcxZEprRjd6N1ZVVldIU25S?=
 =?utf-8?B?TnQ0UDU0SnNNRERmSHI4Nnd6bGNCOUtSaTRGYTRRL3dKL1NmSVk2QzF2cFZa?=
 =?utf-8?B?dXdDYU9EdG5yTUI3WDFTbEYzZkJOL0w0WllBSndWRmZJaEw1bzQ1VEpreDly?=
 =?utf-8?B?Z0JNL0doMzVxQUFhdXhGWDI4TmY1RGFRYzh1Y0dTQWlWRnY5K3EzYjZ2aXdt?=
 =?utf-8?B?R0ZkUFRQcDBwd1pYUnNxMFVaQU45ZFppRU4vQVNDaTh3V2Rna2hqOXJwTVZy?=
 =?utf-8?B?M3N2YWRnNS9jN1M1WFFBSjVDYzFpK25KdGxQeEx5NWxyOGpodFZBUk9jN3R4?=
 =?utf-8?B?cGdaNnViT0hMVUxCak9PWlRoQ3pvQzdScWxoczJObGJab2VSV0JCblhNQzdD?=
 =?utf-8?B?TzRjcko4MFNpU0FzNThEUDZ5S2l4a24vR2pVVkxxLzlKZUtVZlZQMWVLU2l1?=
 =?utf-8?B?TGRZc0dpMUd5bUlSQ3A2R0NHUWZrajRhcGVBK0xmRGhZc2RSdmsrc043QkJF?=
 =?utf-8?B?ZVF2OEZtMlBSNFpzaDhRMWdETDIzVXQrN1pLNXZwYjZDKzFEQzJJNFRnRzF4?=
 =?utf-8?B?OEcvSVVzMXpabTduUmovY3NCWS9vVjhJVXYxOUhjcVk2d052OUFzQ0F2THVl?=
 =?utf-8?B?M3EvK1dVa2pCcTBTNjJJTVFLWFdiZG5Ed2QwbmtWSEdpMUlGcTh1V3BLNS85?=
 =?utf-8?B?SEtKTUM1Y0pUOGhjQ0ZZVzIrSkJwRW4yRThaOW1oVS9sY1NyNnhDNDBsdWs0?=
 =?utf-8?B?TTF4TG55TFhhTHNMMmFIV3dBT1JaaEtyWFNya0prTnV6L2YyYjFTWUNGbldW?=
 =?utf-8?B?amE4ZUpad1FqcGNmNGRuVVJlbHNNM0kxNWtTZlhralNsdlR2M25CQmhrcHR4?=
 =?utf-8?B?Y05EVVRNUzl1Yms3TGxTdGRQVUczaU5zQUNxVk83SGFsc2RMR0dvci9rOXU5?=
 =?utf-8?B?aUsxbXFWd1FrUUFjbkNneFpyU3Z6ZnU4M2tvS3JtWVQvQm9WelkzbHl3RUhR?=
 =?utf-8?B?b0tGeU9jWUlkcU9WM1FxRXBoWDQwd0J6K0lBVTB3K3RNVkZrRzZBSHpNTVJF?=
 =?utf-8?B?NVQwY0Z2L3ZjdzBZbTNZNkpWZ3ZwNHd6TVhodjNhR3BZeko0ajJXWWdYem5q?=
 =?utf-8?B?OXFRWkppWUFIaXVsNGNsRlg4dE5PZGFHc3lwUmlxOWFRRTBVeWZEMTkzTEFu?=
 =?utf-8?B?Y0lYbGV4YjgxMllZcW5rMGZ6UDhzYzdJcjNsRFlwWm4yUzJHNnVicHdxZmI0?=
 =?utf-8?B?QjVvWGp0ejFBM25DcHV5LzRNNS8wOUlKaVdpNnVhUzladVYzQ3U2SkpNZ0ht?=
 =?utf-8?B?OEh1d0ZBNXdYRkRuL0RiZ2ltbExHN0VCK3VRSG15SlVpNDBXREtQWVJ5U1Vl?=
 =?utf-8?B?aXBnb1NYQVBsWEdWVWpudkNoeDlkL24xSXlzM2x2U0xqOTBDQzFEc1c1NDFz?=
 =?utf-8?B?cnlBVUZMakN0YmtHa25vQ2s3NExQZVFGSXpRblFISnRCZEREZGRHaVU1OHlU?=
 =?utf-8?B?djNoenA5elNEMEIzS2xUL1JXMzEzZHhvQi9wWWdiYmwzcnY2cENhWjJvc2dO?=
 =?utf-8?B?UjkydGhiekkveXN3bllYbFJlWldvTDN6dEpRZDA1ZXpEdnNSd3JzbFJ0Nk54?=
 =?utf-8?B?MnlsODdaSm5jbDZrc01ldzJadHJFUTM1SWJoNUlLUFprR2pyTjM2Ui9UaWNK?=
 =?utf-8?B?Z09iaWM4ZExBc2VDQmxtQ1FoYUhQZTljU0RoMGNCTFVtcitBRUFiQm0xeEt6?=
 =?utf-8?B?M1BzaTg5L1c5SmFWTDlKeGU1b1YwY1d0TXFSVmxXUFZTNUczZEJ5YXVwbEU3?=
 =?utf-8?Q?nlYcaWzJlsP+ZtGg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D68FDB3A9CA4F84BBD3B87B76AAF7258@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ovUN4Kpl/UhyiKnJbj7RXgX5SmFrbeN2w/eRM+7GByqaXolgVH5JEmh57Pn27L1o7pM3YiK26Si0Si2xIWHATb1Y/5yAhg9Gcs9XQPvlLMaXxl2crLN+6XeSkbSQjOx3m4ymzwsnVtgpFRHjj4jHabk+rFhUTQ4harAVgyf1VUAkSNWH6MeqWxSHBt4d2jg0LzcsAggW6V+JxoRynqMQ7LSK1MEV8681wtEyGh5afQrl1Ss6I/Nvb/HJqMSbgP1n6HSXRdTM3OkYN4PorfTGn8VuhVdkEzSsZwcCvIseIXZkjsESg/gKq7MM4fxx8si+A9paFaSi8zlWu2AmlDrPxg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf3b86a-d4bd-48bc-ffdf-08df190a6673
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 00:34:16.8936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+toqOaVitymfeKWGrM2S6b92MNaunoVblQJpGeoW9N/8Fzz2vyMNof7d1M5gtO+EUjhqim72Bmmee3MkFsCxmMWx3jQ7/oPBT8Cj7NTWDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB134916
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDA4OjI4ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IFhp
YW95YW8gbWVudGlvbmVkIGl0IGluIHYzIHRvby4NCj4gDQo+IFNlYW4gc3VnZ2VzdGVkIGluIHYy
IHRoYXQgIlJlYWxpc3RpY2FsbHksIENQVUlELjB4MS5Fe0EsQn1YIGFyZSBuZXZlciBnb2luZyB0
byBiZQ0KPiByZXB1cnBvc2VkIHRvIGhvbGQgZmVhdHVyZSBiaXRzLCBhbmQgc28gZ2VuZXJhdGlu
ZyBhIG1hc2sgb2YgYWxsb3dlZCBiaXRzIGFkZHMNCj4gdW5uZWNlc3NhcnkgY29nbml0aXZlIGxv
YWQgYW5kIG1haW50ZW5hbmNlLsKgIERpdHRvIGZvciBDUFVJRCAweDQsIDB4MTgsIGFuZCAweDFG
LiINCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtL2FqMWZpXzBTQnhNSzVXT0JAZ29vZ2xl
LmNvbS8NCj4gDQo+IElmIHdlIHJlYWxseSBoYXZlIGNvbmNlcm5zLCBJIGNhbiBjaGFuZ2UgaXQg
dG8gZXhjbHVkZSByZXNlcnZlZCBiaXRzIGluIHRoZSBuZXh0DQo+IHZlcnNpb24uDQoNCkNvdWxk
IHdlIGNoZWNrIHRoZSB4ODYgYXJjaCBmb2xrcyByZWFsIHF1aWNrPyBJZiBTZWFuIGlzIG9rIGJl
dHRpbmcgb24gdGhpcw0KdGhvdWdoLCBJJ20gb2sgdG9vLg0K
