Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37F2E9730;
	Mon, 12 Oct 2026 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791847104; cv=fail; b=hnH2Ou9AvuAAxk7I/c7xvvm/0GBk+EhH6sDrpaP9TkyJ1W8vZdYmvCy9kZV2umP7Le/PVL03rzZYGil0+nDnjFOdmdXxEe7gFL8HTg8pq57q0eeRvEDiuan8x7YULBS9UvWE/SJXAWflcMqkX0H7SqBe13RSvnK+i7xrG+o4OcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791847104; c=relaxed/simple;
	bh=EkVkNgggfTsnmIQAaixNVSW94yEiumqDJiV8DRcZ0lM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XPQ8blLAiUodONVqbD4xVaFr1H4seE2vTW9NenahzaXaMMczjlFgY4lGQDa9MJ9R7R1ovu428TtFDRrJQ8XDerrWvp9vqQF6BQJH1XMHEOYlUkGq4VCJNl0SQ+yt5ht/196rtdBMnm6YJsDsDb6KR0e+jHKYF0f5p48C+nTgOGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SyJMgIQm; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyJMgIQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791847103; x=1823383103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EkVkNgggfTsnmIQAaixNVSW94yEiumqDJiV8DRcZ0lM=;
  b=SyJMgIQm2Fg7ak7MQ6ADwgLM5Ue9V2KSXP8BsS7R48w3ERuHI16F6lgn
   /54xKl81FL+VJ0WYcxWG0Y4D20XgmAaPMX5vcMyNtPVyogJq+Rf9cCycc
   tK3p+6uXfWDmSRhmxow9dMNs0FDaiocTwUMGBB/9x0DC/z4SscKXq52fb
   ED8rok9h8s4fNbNVumihftjjY7csc4TBpQrAyA55IlCGH57qm6NvnFZ/g
   9w9cwgRYH02Ml9hZ4icUukzauFhblb3fc5HuLamQpHF6V0L4p1XKzdSjQ
   lcPU2ajQ1Gi/oT2exaUgeYXk3C6DJyRLAPPKbzlXN/os+O23V6SSsRdcq
   w==;
X-CSE-ConnectionGUID: DvRnRZwDSFukPqamZ6HI6A==
X-CSE-MsgGUID: uWg+WKSDR96/Jf5zcX+tfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="462029"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="462029"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 16:18:22 -0700
X-CSE-ConnectionGUID: OT/4qw47RqetjcpAQY0aSA==
X-CSE-MsgGUID: 2V12z65LRN2/Q2lspVq9/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1061670"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 16:18:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 16:18:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 16:18:21 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 16:18:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6ewwq3Cc0RJav+TU12mMxvx92psQ80sD3v9ew4yYOG+lKVB0zMpuuoQtxZYCFkstl+KTylg076nNT0VEjw5uo1DCI7TgsPsFeZcdoYBUHQH/BZlXq+sUWap5vtQ44XYYPvzZLrPVe+LTIhAbYjrLsVjnjvGB9b1XHe69G040WIPSElI3fSjb/E9+5AFBTRY0oCmla3cv/l9pMc9dw60ZNStz2WiQYPjybxPgL6IQSNKFE/F/GIvSp8Ech7cGygl87AhGeBkLveJlKJg9YHFGQ0SIL3nPmrda5Xtl6hOjtSYczyzCThSDlnbrEQDslafpNkd7ZsK2gbgslGmE044Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkVkNgggfTsnmIQAaixNVSW94yEiumqDJiV8DRcZ0lM=;
 b=qv+tNJ0T8Gu+MBnNbC9mkSehzA94dV0hHOwnqEO/f4Qilw1ozEBU6eTp9tDqFjz7fSXMDb3xAMPaEi3YCAc34qmLWxLUSZVHWFxcwCuniJCPlzzuB2UrwTwPgue2wOtUiJ5ksqmscsd3i67N9WLLPaBC7rPxIw4XwIyVQIpJ3wLxI3h32L1RkuFF7O/XZ6F4D/PlupaZe4mzkAnvCi8UPmC/zmfKt7NNryclKGJnwiSoa2pby4cfBavbOEoHlqfhV6RZRth+OqwDnViNG/2iO1RIO3ZlLYA+gDanv5ciTExlTjL2lRf1XlQhQ/+SK56XY3l4E4W/Lt4dCenUA+CV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SN7PR11MB7491.namprd11.prod.outlook.com (2603:10b6:806:349::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 12 Oct
 2026 23:18:15 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 23:18:15 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to
 support huge pages
Thread-Topic: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to
 support huge pages
Thread-Index: AQHdTykCb/i0a5FVc0eZkBiALVPvabbpU5eAgA1PggCAA/5+AA==
Date: Mon, 12 Oct 2026 23:18:15 +0000
Message-ID: <ea3584fd5613223ee066fbd368272dc7070bceec.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928090808.15484-1-yan.y.zhao@intel.com>
	 <e494996660b45273590860e961b36378c4099c03.camel@intel.com>
	 <asoQ/P7sghrEVDQs@yzhao56-desk.sh.intel.com>
In-Reply-To: <asoQ/P7sghrEVDQs@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SN7PR11MB7491:EE_
x-ms-office365-filtering-correlation-id: 9ce54411-2463-4bf4-78c1-08df28b717c6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|38070700021|5023799004|11063799006|56012099006|4143699003|10067099003|22082099003|6133799003|18002099003;
x-microsoft-antispam-message-info: xQW5KnfkscoS0VlCFp7Di84bJjgLpUvv2l9pP/p4PRBqe0HyWFUHwGDlgrOnSAcxjs4Fux10lGGWw/iiLzTzT3zuTyaQ/9bh6Q5VV0d7vg13jBu1mx4XGHBsGkJBbIQejjCuLAyP8IbWXTgIzHTtkuy3JPwwiNbKAyrPW7aXq3ROjBfttVJlHyovxg7Hr/urBInL9MSWg0BD8sOb66veYUNv7majTrlMB3h39CKs6lzpPgpJ2LGnWLx3tNXLaeT6lZayOlNCcSc/+587qjrstRvMVBAJchV0D6uropa8ZlXN6tsIMRAuhvkS+XPHEJOmne8RJjX9ehQ7+oktE/U+DkTiuSBAKHVzpAQc1BEaH3o0OLyRL/s0wexA+5nt1QpzvJ36kgbZGj7Eii5gdnRcJ3ScQe5m4w6XPFEBNETkjcHokrbtu97Tz0nprXZwLpFVPhcchLKVF/JQqTz2o9xIvIcrkp1TIXyrOf3qOBJ9jJAffw5GwUXlkI9p/i/m2MLpG4K0hwpjn9WLwhOdpuLU8l5Y+ZfWYuI8NC2XeP3m8BgGqOjoFs3NO6RPE+c7TNDssOsdqVRX3NdT11k+C25c6NMC4vkRfuItNOEjkL3sdYZtNaEJU7JrTXuBcnFzGlbTou6AQzbh1MAEft9o76qH+u1LBmgxDCVsuuWsOPesy5rydkLT5GWUYtogiMIneIBMArpcLoLAl/7ykkV8B/UaOmKJHAS85Rk3hfYRU2yxUlc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(38070700021)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V242SDZiN1lJcWZIY1VUdXcwa3hGMDJUZXRQT0dHMURDVDZRU3dueVBzeU5k?=
 =?utf-8?B?ZTh5c2ZoNVNQMFJiU3BkK3lEMUVWNUUvcDF0T3FjZnVYYnNIb0dadmhuWSt3?=
 =?utf-8?B?S3AyekRhWTRCd3hGc2NNSStFRG1JQ0ZvS2hhbXVRRHVYVzNyU1ZVa1lqOGVz?=
 =?utf-8?B?RUpTRGRaUkoxUkFhSjc3TkVzdnhlL1JUTjc0TDM4dWVIUTFnM09HWWtPOTJ0?=
 =?utf-8?B?SW1iRll2aHdSZ2l5Nk9XbzZaNWpHWHVhUWkvTkZEZzA0UUxKbUFLcE5iMVVh?=
 =?utf-8?B?Z3pnV0RPMlQ1MmZWZU1XMW1TTHIydGVjK04zYTJ2WWVzRW43U1JxZENrcjZa?=
 =?utf-8?B?d3NiRERxTHFTY0F3R2JBVWhPQ1AxWTgwVUNTYldyN0J0bWJVRFE1bG0xNE8v?=
 =?utf-8?B?WEhEdkprOU5FWWVNeFNoNjVTdXVCUXpORTZkMjc2NUdBTTA0M1lVanJ0eEdU?=
 =?utf-8?B?a3FLSmcyeVdycnB3dllMUWFQTnljcGNzNHI1OWViNE5raVJIR1NZVkxJa2Yx?=
 =?utf-8?B?NlpNMjBwY0tGNEE4dk1DV0VCUW0vckRQK3ZGZklnZ3h4c0lacExPekhsOWR5?=
 =?utf-8?B?RmZZNzhVaGNIWGQ5aWkzM2pMWUpUNElqUzRvUnF6cDdlU0VMeDQ5UEZkSkpD?=
 =?utf-8?B?cDVPVEdZeWNGcGx4N3c2aGVRTmRmSkNlZ09RV25VSGZrdjVwR3VNUFJwa3ZB?=
 =?utf-8?B?UVA4MGplNHNxWjA3QnlVZlMweTZFbkNCL1FMOXQzakdZSFErM2d3aDkrVlgx?=
 =?utf-8?B?dWRacGtDSkt3K0Z0dkZWOXYvQzhJQ0xlYWlHYnBDRXUzbFZaTGFyQ2Q0TzBG?=
 =?utf-8?B?TmpnS2dQRkxzVHdRWkJVMnE5c3hzaWdyZEV1MVNQY0J3ZU54QWQzQWlGcVpZ?=
 =?utf-8?B?b1ZseFFCV0JOc01oNGNMVStLbER4RXZkSU9yTnpoUHJRZUI1UTNvcEFKZ0Y2?=
 =?utf-8?B?Qk5ZaGFmMmVFS1BhRDRKSkliWUR3QnRDZ0VOckIvdHZxUm5ERkdHbmJiNjc3?=
 =?utf-8?B?TTNRdTBCaVMzdDVSbmNQR0FRbE53NEIxM3NEMzZuMHRSUW1uZjcyTGlBWm4w?=
 =?utf-8?B?K3ZjRUlqQ1c4NXA0dzJCdjVUSkt5cDN5ZnpkZnNUT2xTZURpMUZKdnJVOVNa?=
 =?utf-8?B?d3hrWTVNa241RkVsRHZDRWdhcnAxVnE0cHRMNUxjbGhqY0VTRS9DSHZuNjRz?=
 =?utf-8?B?YWhqV2hQbzdxV0RRUlNjS0JtbE5HK3Q5MGk0S3psNWZrYTZxUjRhcDJkY0hv?=
 =?utf-8?B?Zm1pb1l2QnRrSktJSWRBcjY5R2kzbG9teG5BSHZObjY3Y0ZQZ3NIaE1RbEUr?=
 =?utf-8?B?cjdYU2MrbVM4a3BzUkluZU92WlVoYmhEZ0N1QnNnaGliam1EYWgxSzZtbVdC?=
 =?utf-8?B?ZWJmU3ZrVmtkSkg2L2lKTzJTZXFKNGx0dUszNUgxVHhhNlVvc2J2RU9mcit3?=
 =?utf-8?B?TGZ6MTUzbjB0YnpJM29VbUxLWG9ab0VoK3dpbjVoMzFIenZBdUZOR05ubjVh?=
 =?utf-8?B?amVjUE9XRXB4R1NUeXhGdC9FRnhPYmNSSjFsUDMyNWlIUTlxdVM5cjVOUlZa?=
 =?utf-8?B?b0YxbE9sVUxJNW0wQUt2WFNXN0t6Wi9KMkpVbjRrUVpKblNiVy9pMjRGYUFu?=
 =?utf-8?B?dzJybExzT0pQT1UzQWxmOGsxdjRYNy9WaWJUR3ZjNlFRSXZqNWJoNWI4aG1v?=
 =?utf-8?B?eWpWS2tvWXZNV3YxeXVwRVRXcXprRHVMUkNMOWlKUnhRNGxBUi8zYTBPSXpG?=
 =?utf-8?B?cDdHd2xsL2tOL3BhYjhQem1Ub0xLM3JiSC83SVozN2xSbTkra0dLZTB5Nmtq?=
 =?utf-8?B?a1QyQmhMbnRFZEZFTmRNbnhaYm1LMFphS1dDc285dmdaTnYxVmNxTk9WRTVn?=
 =?utf-8?B?d0UzTzg3enhiWWYrUmFEWHoyYkcvQ1Azb1l1b3IzTWswb0RRSW9NdFZ3WkFT?=
 =?utf-8?B?NVc0bDRZUWwvV3g4SEF3NlVQNWdWZFhVSklVdVc0Rm0zdVUrYVBnclhvWGNC?=
 =?utf-8?B?R05oRU14MlRKYzlGRVllQ0RMcExiUnZETGVIRGpSSEdwNDcrSHVEUTBRemQr?=
 =?utf-8?B?RnlXV2lHamoxQW1YeXZwOXZhWXkzYktDTzVWdkU4U1FsS3d6T2JQYXpDS0tW?=
 =?utf-8?B?UUphTWx1a0VmSE1rT2dqT1NxaVNNa0dPUVhxemtsMDNyUU5lSkhnSjN5d3hk?=
 =?utf-8?B?dlpYenhuYzVtaDBSTWdoYmNwdGRrVzBtNFVLcGhSWkpxZ0tFaEQ0SEt4MThY?=
 =?utf-8?B?MUxOcHFHVlZOdmZQRktQVnE2dnp6RW5KNXpNczN3aXlQMDBhT1hRYnFlRHR0?=
 =?utf-8?B?WS83SDdlY0JRelQreDBkSVBZYzdmeEpOUWdxYkhSZlZxOFN2TGxjejNBd3lr?=
 =?utf-8?Q?m3SqhmmZ/VjRnEWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEE6945DF55B5D47A20A20BA8EFC2834@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LbLfjCbbzbK9mpwY959yaheS3+vizrDIza7zx2u4v3NV15xVck7hsFWpaAJyLtYoZLCs4I81RL7uLWLWzAPw5Y0fzqreEz10ogKH3gCUxHy76ZNRkacimFQgbY5Sw8Y5vr4lgPGYRkKnILL0MGLgs2N4oB3VaAAerErC13y01yjRC5IwBF6B3FHQPfCBLw65owTnmsKMayUXhShDziasbUM9GAG/JnYKDc3M6H/+TrziTQw2VGnO9ENAlsvvU0/B4XpND4qF2wKBYsrvR8ZxhuqE3sp3fWtvjge29QeWf9nTtVpXtYGY+eroinq9SKlRezrSR5naQwofdPqytpf3dg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce54411-2463-4bf4-78c1-08df28b717c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 23:18:15.2485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJGNzN6bUzDOIh9o+hEkqfRiUd4mw2/6BAY8UlrbwK9gCMVuIqlNgE0swpyZ/lU0SX9sep1DIP7vbtb4Dh2k1ffr55UsiZOhrdcLdvgI8tA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7491
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDE4OjE4ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
RnJpLCBPY3QgMDIsIDIwMjYgYXQgMDc6MDI6NDBBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjA4ICswODAwLCBZYW4gWmhhbyB3
cm90ZToNCj4gPiA+IFRoZSBURFggbW9kdWxlIHVzZXMgUEFNVCB0byB0cmFjayBtZXRhZGF0YSBm
b3IgZXZlcnkgcGh5c2ljYWwgcGFnZSAod2l0aGluDQo+ID4gPiBURE1SKSBhY3Jvc3MgdGhyZWUg
bGV2ZWxzOiAxR0IsIDJNQiwgYW5kIDRLQi4gVGhlIFZNTSBpcyByZXNwb25zaWJsZSBmb3INCj4g
PiA+IHByb3ZpZGluZyBiYWNraW5nIHBhZ2VzIGZvciB0aGUgUEFNVC4gV2l0aG91dCBEeW5hbWlj
IFBBTVQgKERQQU1UKSwgYWxsDQo+ID4gPiBQQU1UIGJhY2tpbmcgcGFnZXMgYXJlIGFsbG9jYXRl
ZCBzdGF0aWNhbGx5IGF0IHN5c3RlbSBib290IHRpbWUuIFdpdGggRFBBTVQNCj4gPiA+IGVuYWJs
ZWQsIFBBTVQgYmFja2luZyBwYWdlcyB0cmFja2luZyBwaHlzaWNhbCBwYWdlcyBhdCB0aGUgNEtC
IGxldmVsDQo+ID4gPiAocmVmZXJyZWQgdG8gYXMgRFBBTVQgcGFnZXMpIGFyZSBkeW5hbWljYWxs
eSBpbnN0YWxsZWQgYW5kIHVuaW5zdGFsbGVkIGF0DQo+ID4gPiBydW50aW1lLg0KPiA+ID4gDQo+
ID4gPiBDdXJyZW50bHksIHRoZSBWTU0gaW52b2tlcyB0ZHhfcGFtdF9nZXQoKS90ZHhfcGFtdF9w
dXQoKSB0byBpbnN0YWxsIGFuZA0KPiA+ID4gdW5pbnN0YWxsIERQQU1UIHBhZ2VzIHVuZGVyIHRo
ZSBhc3N1bXB0aW9uIHRoYXQgYWxsIHBoeXNpY2FsIHBhZ2VzIGFyZQ0KPiA+ID4gdHJhY2tlZCBh
dCA0S0IgbGV2ZWwuICBIb3dldmVyLCB3aGVuIGEgZ3Vlc3QgcGFnZSBpcyBtYXBwZWQgYXMgYSBo
dWdlIHBhZ2UNCj4gPiA+IGluIHRoZSBTLUVQVCwgdGhlIFREWCBtb2R1bGUgdHJhY2tzIGl0IGRp
cmVjdGx5IGF0IHRoZSBodWdlIHBhZ2UgbGV2ZWwsDQo+ID4gPiBtZWFuaW5nIGluc3RhbGxhdGlv
biBhbmQgdW5pbnN0YWxsYXRpb24gb2YgRFBBTVQgcGFnZXMgZm9yIGh1Z2UgcGFnZXMgaXMNCj4g
PiA+IG5laXRoZXIgbmVlZGVkIG5vciBhcHBsaWNhYmxlLg0KPiA+ID4gDQo+ID4gPiBBZGQgYSAi
bGV2ZWwiIHBhcmFtZXRlciB0byB0ZHhfcGFtdF9nZXQoKS90ZHhfcGFtdF9wdXQoKSBzbyB0aGUg
aGVscGVycw0KPiA+ID4gY2FuIHNraXAgRFBBTVQgcGFnZSBpbnN0YWxsYXRpb24gYW5kIHVuaW5z
dGFsbGF0aW9uIGZvciBodWdlIHBhZ2VzLg0KPiA+IA0KPiA+IEkgZ3Vlc3MgdGhpcyBtZWFucyB3
ZSBuZWVkIHRvIG1ha2Ugc3VyZSB0byBnZXQvcHV0IGF0IHRoZSByaWdodCBsZXZlbCB0aGF0IHRo
ZQ0KPiA+IFREWCBtb2R1bGUgaXMgdXNpbmcgaXQgYXMuIEZvciBleGFtcGxlIGluIHRoaXMgaW1w
bGVtZW50YXRpb24sIGlmIGEgaHVnZSBwYWdlDQo+ID4gZ2V0cyBkZW1vdGVkLCB3ZSBjYW4ndCBj
YWxsIHRoZW0gbGlrZSB0aGlzOg0KPiA+IDEuIHRkeF9wYW10X2dldChodWdlX3BmbiwgUEdfTEVW
RUxfMk1CKQ0KPiA+IDIuIGRlbW90ZShodWdlX3BmbikNCj4gPiAzLiB0ZHhfcGFtdF9wdXQoaHVn
ZV9wZm4sIFBHX0xFVkVMXzJNQikNCj4gQWN0dWFsbHksIGNhbGxpbmcgaW4gdGhpcyB3YXkgaXMg
ZmluZSwgc2luY2Ugc3RlcHMgMSAmIDMgYXJlIGVmZmVjdGl2ZWx5IG5vLW9wcy4NCj4gSG93ZXZl
ciwgd2UgY2FuJ3QgY2FsbCB0aGVtIGxpa2UgYmVsb3cuDQoNCkJ1dCBzdGVwIDIgaW5jcmVtZW50
ZWQgdGhlIHJlZmNvdW50cy4gVGhlbiBzdGVwIDMgc2tpcHMgdGhlIGRlY3JlbWVudC4NClNvIGRv
bid0IHlvdSBuZWVkPw0KMS4gdGR4X3BhbXRfZ2V0KGh1Z2VfcGZuLCBQR19MRVZFTF8yTUIpDQoy
LiBkZW1vdGUoaHVnZV9wZm4pDQozLiBmb3IgKGludCBpLi4uKSB0ZHhfcGFtdF9wdXQoaHVnZV9w
Zm4raSwgUEdfTEVWRUxfNEtCKTsNCg0KPiANCj4gMS4gdGR4X3BhbXRfZ2V0KGh1Z2VfcGZuLCBQ
R19MRVZFTF8yTUIpDQo+IDIuIGRlbW90ZShodWdlX3BmbikNCj4gMy4gdGR4X3BhbXRfcHV0KGh1
Z2VfcGZuLCBQR19MRVZFTF80S0IpDQo+IA0KPiBUaGF0J3Mgd2h5IDEgJiAzIGFyZSBub3QgcmVx
dWlyZWQgYW5kIERQQU1UIHBhZ2VzIG1hbmFnZW1lbnQgZm9yIHRoZSBwcml2YXRlDQo+IGd1ZXN0
IHBhZ2UgYmVpbmcgZGVtb3RlZCBhcmUgaGFuZGxlZCBpbiBkZW1vdGUoKS4NCj4gDQo+ID4gU28g
aXQgaXMgdXAgdG8gdGhlIGNhbGxlciB0byByZWFzb24gYWJvdXQgd2hhdCB0aGUgbWFwcGluZyBs
ZXZlbCBpcy4NCj4gWWVzLg0KPiANCj4gPiBXaGljaCBtYWtlcyBtZSB3b25kZXIgd2hhdCBpcyB0
aGUgcG9pbnQgb2YgcGFzc2luZyBsZXZlbD8gVGhlIGNhbGxlciBoYXMgdG8NCj4gPiByZWFzb24g
YWJvdXQgd2hhdCBsZXZlbCB0aGUgVERYIG1vZHVsZSBpcyB1c2luZyB0aGUgbWVtb3J5IGF0LiBU
aGUNCj4gPiBwYW10X2dldC9wdXQoKSBoYXZlIHRvIHRha2UgdGhlaXIgYmVzdCBndWVzcyBhdCB0
aGUgYW1iaWd1aXR5LiBGb3IgZXhhbXBsZSBsaW5lDQo+ID4gMyBhYm92ZSBjb3VsZCBhY3R1YWxs
eSBmcmVlIHRoZSBQQU1ULCBidXQgaXQgY2FuJ3Qga25vdyB0byBkbyB0aGF0LiBVbmxlc3Mgd2UN
Cj4gPiBhZGRlZCBzb21lIGludGVybmFsIHRyYWNraW5nLCBidXQgaXQgc2VlbXMgdG9vIG11Y2gu
DQo+ID4gDQo+ID4gVGhlcmUgYXJlIG9ubHkgdGhyZWUgcGxhY2VzIHdoZXJlIGEgbm9uLTRLQiBs
ZXZlbCBpcyBwYXNzZWQgdG8gZ2V0L3B1dC4gV2UgY291bGQNCj4gPiBhbHRlcm5hdGl2ZWx5IGRy
b3AgdGhpcyBwYXRjaCBhbmQgaGF2ZSBLVk0gZGVjaWRlIHdoZXRoZXIgdG8gY2FsbCBnZXQvcHV0
IG9yDQo+ID4gbm90LiBTaW5jZSBpdCBpcyBhY3R1YWxseSB0aGUgb25seSB0aGluZyB0aGF0IGtu
b3dzIHRoZSByaWdodCBwYWdlIHNpemUuDQo+ID4gV2hhdCBkbyB5b3UgdGhpbms/DQo+IEFyZSB5
b3Ugc3VnZ2VzdGluZyB0aGUgaW1wbGVtZW50YXRpb24gaW4gdjMgWzFdPw0KDQpZZWEgdGhhdCB3
YXMgdGhlIHBhdGggSSB3YXMgd2FuZGVyaW5nIGRvd24uDQoNCj4gDQo+IEluIERQQU1UIGNvbWJp
bmVkIHY1LCBTZWFuIG1vdmVkIHRoZSBsZXZlbCBjaGVja2luZyBmcm9tIEtWTSB0bw0KPiB0ZHhf
cGFtdF97Z2V0L3B1dH0oKSBbMl0uDQo+IEhvd2V2ZXIsIFNlYW4ncyB2ZXJzaW9uIGludHJvZHVj
ZWQgX190ZHhfcGFtdF97Z2V0L3B1dH0oKSBmb3IgaW52b2NhdGlvbnMgd2hlcmUNCj4gNEtCIHNp
emUgaXMgZW5mb3JjZWQuDQo+IA0KPiBEdXJpbmcgb3VyIGludGVybmFsIHJldmlldywgeW91IHNh
aWQ6DQo+ICJDYW4geW91IGFsc28ganVzdGlmeSB3aHkgdG8gaGF2ZSB0d28gZnVuY3Rpb25zIGlu
c3RlYWQgb2YgcGFnZSBMRVZFTF80SyBpbiBhDQo+IGZldyBwbGFjZXM/Ig0KPiANCj4gU28sIGNv
bXBhcmVkIHRvIHBhc3NpbmcgbGV2ZWwgdG8gdGR4X3BhbXRfe2dldC9wdXR9KCkgd2hpbGUgaW50
cm9kdWNpbmcNCj4gX190ZHhfcGFtdF97Z2V0L3B1dH0oKSBmb3IgdGhlIGFsd2F5cy00S0IgaW52
b2NhdGlvbnMsIEkgdXBkYXRlZCB0aGUgcGF0Y2ggdG8NCj4gZHJvcCBfX3RkeF9wYW10X3tnZXQv
cHV0fSgpLCBoYXZpbmcgS1ZNIHBhc3MgNEtCIGRpcmVjdGx5IGluIHRoZSBhbHdheXMtNEtCDQo+
IGludm9jYXRpb25zLg0KPiANCj4gSSdtIGFjdHVhbGx5IG9rIHdpdGggYW55IG9mIHRoZXNlIGFw
cHJvYWNoZXMuIEl0IHNlZW1zIHRoZXkgYWxsIHJlcXVpcmUgdGhlDQo+IGNhbGxlciB0byBrbm93
IGFib3V0IHRoZSByaWdodCBsZXZlbCBzaXplIGFuZCB3aGV0aGVyIHRvIGludm9rZSBQQU1UIGdl
dC9wdXQuDQoNClllYS4gVGhhdCBpcyBraW5kIG9mIHRoZSBwcm9ibGVtLiBUaGUgY2FsbGVyIG5l
ZWRzIHRvIHVuZGVyc3RhbmQgdGhlIGltcGFjdCBvZg0KdGhlIG1hcHBpbmcgbGV2ZWwuIFRoZSBs
ZXZlbCBhcmcgaXNuJ3QgYWJsZSB3cmFwIGV2ZXJ5dGhpbmcgd2l0aGluIHRoZSBoZWxwZXJzLg0K
U28gaG93IHRoZSBnZXQvcHV0IGhlbHBlcnMgaGFuZGxlIGl0IGlzIGludGVybmFsIGRldGFpbHMg
dGhhdCBjYWxsZXIgbmVlZHMgdG8NCmtub3cuIFNvIHRoZXJlIGlzIGFic3RyYWN0aW9uIGxlYWth
Z2UgSSB0aGluay4NCg0KU28gcHJvYmFibHkgdGhlIG1vc3QgaW1wb3J0YW50IHRoaW5nIGlzIHRo
YXQgaXQgaXMgY2xlYXIgaG93IHRvIHVzZSBpdC4gVGhlbg0Kd2hhdGV2ZXIgaXMgdGhlIHNpbXBs
ZXN0IGNvZGUuIEl0IG1pZ2h0IGJlIEtpcnlsJ3MgaW1wbGVtZW50YXRpb24uIFdoYXQgZG8geW91
DQp0aGluaz8NCg0KT3IsIGhtbS4gSXQgd291bGQgYmUgZWFzeSB0byBjYXRjaCBtaXN1c2Ugb24g
dGhlIHB1dCBzaWRlIGJ5IChkcGFtdF9yZWZjb3VudCAhPQ0KMCAmJiBsZXZlbCA+IFBHX0xFVkVM
XzRLKT8gVGhlbiBzb21lIGNvbW1lbnRzIHRvIGhlbHAgdXNlciB1c2UgdGhlIGV4aXN0aW5nDQpk
ZXNpZ24gY29ycmVjdGx5PyBFaXRoZXIgb2YgdGhvc2Ugc2VlbSBvay4gQnV0IG15IGNvbmNlcm4g
d2FzIHRoYXQgdGhpcyBwYXJ0IG9mDQp0aGUgZGVzaWduIHdhc24ndCBjbGVhci4gU28gbW9zdCBp
bXBvcnRhbnQgaXMgYWN0dWFsbHkgdG8gZXhwbGFpbiB0aGUgd2h5IG9mIHRoZQ0KZGVzaWduIHdp
dGggYW4gYXJndW1lbnQgb2YgdGhlIGJlbmVmaXRzLg0KDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjYwMTA2MTAyMzA0LjI1MjExLTEteWFuLnkuemhhb0BpbnRlbC5j
b20NCj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDEyOTAxMTUxNy4zNTQ1
ODgzLTMwLXNlYW5qY0Bnb29nbGUuY29tDQoNCg==
