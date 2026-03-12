Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30323375F7D;
	Thu, 12 Mar 2026 02:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282867; cv=fail; b=RDTJUlcB2B6bYq4z9Zd4EycX1qbdoKsXRTLQHOYbT2NiVcWqw4fCd5/pq6RpneJ7A+FDcBvPiS3f5We7I8Usp6rSX0BBwCANOpEEoWbJ4w+PWKIMaefGZTrgeo6bB7YyJauDrR8bHpGcRsWLsnRuIaBMNwmNxwM4R30b6goZWiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282867; c=relaxed/simple;
	bh=Rw/PDjIxleI01Ku40ZWnPwOUCyQ092nOtGKj2OpF/NE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=teQOd9fVYqCmcOs7nwAFVdowwIRk0sl3lPzgKO/T4/yL7UtwWRGBk+gcOp9A+Gf7amZKHK3sSNSY0hY9Jx4nNUL1jdp8/AeGzJg1HIswqkSjYtbTQ8OecdBsGQOUs3R1dX3TvAVEYFoyDs5rvdeJZm7wUQJ3q7UB1i0/OHELe5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AacDEXss; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AacDEXss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773282865; x=1804818865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rw/PDjIxleI01Ku40ZWnPwOUCyQ092nOtGKj2OpF/NE=;
  b=AacDEXssQQvJAX39V+lwJL/Vq76wSmx3BwbxbVx12t8ZsPJ4rm1rmd83
   FL621/VEkhYe92qbBF9P8bxkGduFEUNlkDlq04ILgfes32earq5RaANIo
   gOCEGTZ0HVxB8BTBMorUC/H747wMTExEeUG7WnchvY3ReceQTJn4pN2Au
   jN8UIYBCqN8GTfN8HfgfxB3gEAQg3iI6lfhuPuCQhs66ruwnCCls2Ck0Y
   ViW7yAmTxf1GCiOI0Q0ANI3uaaNIyCk1cle7RG/cbQuHvVag8HLeRYyoe
   CXTgVctpQilunQY4pggsuViydE1RGtdZUkl5ta32clOsxv7rzWROdB3Ex
   w==;
X-CSE-ConnectionGUID: 1eWc9A+VQomsBUpqKpbNcg==
X-CSE-MsgGUID: 4zd0aYhrQ96GAyiAl71YrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="73382515"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="73382515"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:34:24 -0700
X-CSE-ConnectionGUID: W2ZpvLDcThufTBpiR77dnw==
X-CSE-MsgGUID: 2ij0GxLQRJ+BsFYpNtvvnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="220621568"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:34:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:34:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 19:34:23 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:34:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5ezWR01u6fRzhN+RBjBRRwGRGgXKHWIzXm70iIWX9Q9jM8dXJ39xicwrkyhf8lgiQh0GC/tBlsvqPqVNNOYqhUwNrkT0AJkgJm2pEoh5Gxh6QIw7xs2VB34ACeNKJZK61+SYGVf9RuljP9z7D8bZT69wZqDRO6Hv2cAzvkxMKF3rFZ6HuMeemOlYpHfF54S8kbUosu4Biqi22+MCabKWhqk6wSyOmXAo95Uxg+oZU8S51fp/4r5CG/1y0e8a9PbKI4mXSdqudtc/Plk4Mc9cFDO4MyCHwZdertEkdqSrFMxtaQR8oCg08Vv839d9/5m1KOTOtU84JOe02QsTplAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rw/PDjIxleI01Ku40ZWnPwOUCyQ092nOtGKj2OpF/NE=;
 b=HTdqFJqdHnCsMZ9U1j5HTGdELA4rhikiMGX7oLiAEEo5Kdgks73cBimVqb5OwO66j6UzmCleZtIYCMcVECXIvt9QFsz1/eDXU3Zcxg6kQRpyYK+NR+y0INEvvn3QpEup2ab2i0LtG9GSKg1HJjPe1BjZ+cwDnXC2zBye5QsSx3HMVE4TvYhbbIPDWuvGPRxIbRw8CuJi1Ixf1EeSVttAtH6o7w8xhCRsz8WuKikWdCA3P/Eu4icOPa4YxOkiPkm9RUuPDzuCNXhA5xV8iVfj+1HgBuFVtAMWo30jbgwklGvD3n/DgUwmwEHq2VceCDH2dRFaGAAHVRbjc/xiBsErQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 02:34:20 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9678.017; Thu, 12 Mar 2026
 02:34:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>, "Huang, Kai" <kai.huang@intel.com>
CC: "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"sagis@google.com" <sagis@google.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 13/24] x86/virt/seamldr: Shut down the current TDX
 module
Thread-Topic: [PATCH v4 13/24] x86/virt/seamldr: Shut down the current TDX
 module
Thread-Index: AQHcnCz91APNLS7DZUanFp0ObHYr27WfHMmAgAItdoCACQ7bgA==
Date: Thu, 12 Mar 2026 02:34:19 +0000
Message-ID: <f6ecf1b132431852802c9aca19455f165dce38cc.camel@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
	 <20260212143606.534586-14-chao.gao@intel.com>
	 <0c86d95449543dee0369bd83740b25aae595a5d1.camel@intel.com>
	 <aaqM+eFfQ9qmpzyT@intel.com>
In-Reply-To: <aaqM+eFfQ9qmpzyT@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB4837:EE_
x-ms-office365-filtering-correlation-id: 419e2bd7-7bdc-48d6-1991-08de7fdfdd17
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: tJM1gEf4wL6aS+2n+LaF8lZT1Q2JKjnJjmxKGaP/Jw0zXUJmj5fGD5W/+J904NF1uCFoTlQTeak5OZSOK+vawPT3uOr96RZhgxarapymnotaHXMdCpol/nqxUfIeFvxAEjUC+ZE5ucZv5Fjg5esmRdMR563sGL5v178cmUG2H+d1D/sSfcrOjmwLWh5Z6Ei689h48niYkHhUeKnILNpGkMMohmstm3pu6XrsSouGG8bCZg4hZZ9UbWj57yno+HgBmmVFnz+oPXGeYXu4p6JM16/iN2GRBVhNn1Xf39uHPWMkpYpiweo0ob2Jwha5pmhVFT9cJK+OMMNk2nIW9CVhOuK0yygpGtkT/UgWLOG6LKzLxPHInBmLgFvY3fSuj2LuCjstlS4PMcfx16c+MVHun2x3czCoP1Gn5ki1vXR9axqMS3+KPsERYtMaT6/wX31dUOTltaCXC2X0bcN038NVoyrtyOJoF+mEX1ADSobsWqW7byvG0suKxJfaMUiSQZjmdhR8MwHCwCJGcGoHVGu50y2jjlSSZmJ96Hwk+y1/SCdy9ePzBrkb+m0JLD906KD6p+m6Fz94CcblqCK+qnY4cnkMVZ/Q6OW4Amyvn+gjAjpud+43J3AQufP5BTcWRB9iFYDhF81zxpPdMHhHxXV+MYz2j1Eare0g+/0v/BhAzCya+kV/raYvqn6WBIC2KKMRbXbzrLP2ai39GS6EBY6A2Bve0HicjSmyLNEAhLR2f62/ZJ9EqxuMJql4Thf0k+9Yg6pVUWSm0LwIfo1ZPYFMGunOCVnLa305iXlqjsOWA2w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0hwY25weWlnUFVIRFA3Sll6eFFrWjQ0UEx1elp1VDQ1bzI3TzBVa2Q1OGRK?=
 =?utf-8?B?eWJpTE1QY3NJVld1b3kxQzY3ZDF3SXBtcmlScWxGS1dzUjlBWFZWNGNYdGt6?=
 =?utf-8?B?WFZtYXhlbHo4RFR3SEJBcWdsWTY1d3gvTjFtOWpPSk1Oc1BPcXFxdzBEMWNn?=
 =?utf-8?B?NlRMSE1OM2p3YnR5SDVIYzl6b2k0VklVaktIajJoelU0WENZRGNpNkxDc2tU?=
 =?utf-8?B?TDhkNGFrK0Q0ZnVVY2FPdVJrL0tic3U4dUl3bERTTGptWDh0a1l1ZGtTM0RY?=
 =?utf-8?B?QnR5NGRhVnpBY1M2RDVMdTdINjQzTnFETHdBaTlkRjBId0pUMjNuc29EM2dF?=
 =?utf-8?B?WlhkMytMZEtFYkQ4d3ByRXZSR3hiVElieGRDa2JlTUV5TGwyNWlpS3g4VFUr?=
 =?utf-8?B?M1A0NE5iRmRJOUlmeEVndTNnM2t0ODZqNDNpYTlTczVRdXpqbTN0YlBZY1Bw?=
 =?utf-8?B?TUt6aENibE11RWNBMWxNejB5N1h4UVIxUzdNajJpTjRMcHhDb2gvbkVWR2cr?=
 =?utf-8?B?d3M4MWFWeWxIRHdHS2VGOFhTUHFkMll3bkFxNVBEUFBFNU1na2JZcC8rOGZ4?=
 =?utf-8?B?RGZzQUJYdDFFLzRBU29CZHZSSGxQVDFRZ3kwY3dGT25lLzNSalhzeFg0OXpr?=
 =?utf-8?B?dHF0ZFZpR3Q4V3hhelBhV0t3Z0wwWW5kU0RDL1FlYk1UYlRVTVpMRGt1OXlV?=
 =?utf-8?B?WFNSVW9iYW9qVEQ3WU00R1RrcDBJL2crR1VRQnc1SHBLS3gvY0t0a1Q3NXk4?=
 =?utf-8?B?UWVrRFBSZUdIUVBNNDNCd2kwNEZpeUtWK2xJaWlLNmhMYkxrdk5lUlFvWm1j?=
 =?utf-8?B?V0s2MEhjZ25LRW0wR2VoRHRsUVJQTEhoUWRoeUYzQk8vWW5FaHpsMitmTnBL?=
 =?utf-8?B?VVBRL1hHU3dzMTZIRjl4UVg5c2tqRmRiZTZEUmtCU1g1ZlgwbnJTVTk4SmJ1?=
 =?utf-8?B?UWVOVVU5ZzdiZmhIWEpHc3V4K0d2ekNJUnJDYXBGNHB6bWs3MTBkQ2JadzVV?=
 =?utf-8?B?NFJqVmFYVWZpaDV2Rk5nRTExa0NzV2tDRU1ZU3ZWZE1nWUwwQWlIa25aNFpB?=
 =?utf-8?B?YlVGN1hXNVI0V2UvdE8vOU95VExIZDNVd3ZKeWo3M056VW8zT2lsemlwOTI4?=
 =?utf-8?B?U0FNdExkT3FDRVIrUnVhSHhVSkFQbFJMejh2RHJZMXZyM0w4T0o0VHZKVDV5?=
 =?utf-8?B?dE1pM0VQZnUzbEVPRTZoZC9nUm8wLyswYXBSazduYmhTWVhSUHlFUU1ZOUgv?=
 =?utf-8?B?c0hZZjcvYWo0Zy9hMWxmVUk2TVZBbzcrOTBhRzQ4S3RPOG1MRms3NHdtK09M?=
 =?utf-8?B?b1VaVExLT2ExTUJkZTZydFY2VStjamk2SWR6Smk5ODFQNE9Dam83MzJ6T0VS?=
 =?utf-8?B?ZGZsSlNFUGV1Z1BrUWdnQWo4UXMwLzllUUkrWXhzNUNHYklqMXhoT3pZVnZh?=
 =?utf-8?B?MDNucHRhTUU2WVprQjJWc0p3R1FqZWNCMHlIMEUrMFJ2OU5Vd0l5SkN0SjRh?=
 =?utf-8?B?aVFXdHc4RnZBOU03ZG1HZ0kwSDNBZk1ROU1YNUR5dXlaa1lsU2R6VUt4SFdy?=
 =?utf-8?B?ZGNDaFZKOHJiVDlGYUs0cHNxaGxmNkpYSWdmMkVlSjhWSHRrR2tjaVhCZyt5?=
 =?utf-8?B?cnFPNFNrcVdWUDFUTUhmM21UTUdUVG8zZ2ZVQk9pYVpEanNOSFRzcllmLzlW?=
 =?utf-8?B?RWF1Mnd6K292elBIdzFpditwSjVHUlYyeHI5Q3BVbHVyeElHTkVleWxETDFo?=
 =?utf-8?B?T3FabEhWc2NPck9tSW5xR2RwZWdDV05QYzRpVFcvUnMzN2lFempBVWMwZFZO?=
 =?utf-8?B?Nmp2QlJLYVFUQ2tpWENwTzRGbXNMejBuTERxb05mdzJ3eHN3cDJlOVovOVFE?=
 =?utf-8?B?c0pOZG5QdllnaVRsNDlaME5wZnI4VEdVL3ZESVNuRU43eU5ObTY1ZVdJVDU3?=
 =?utf-8?B?cEh4UUVoU3NKL3JoYVV5VjZBTm8vU282ampTK3VGQjA5TTZGN25oa2lWTjBF?=
 =?utf-8?B?bW9oaGRwT1BvUVl0eSt5ZjNNVkI3a3JHS3B3MnRZZjBEWkN5NjJnVnl2dEVq?=
 =?utf-8?B?NVdJcE53T210VVpZYlFJSm9iYVJ5QmtqWlJHU1hUNjhLYndkUmJaL2JkRkhL?=
 =?utf-8?B?SVROYXQ1dktCR2c5UVpDWmdMUVNRRVFqZE1abHpPTTZYK2ZBZnlYWTFpT2lE?=
 =?utf-8?B?M3ZRZnJhL2JzcVJMYlAreFpiSG00S1RtdlZ5UFJiWFd5NVZkbUpteG51Y1oy?=
 =?utf-8?B?K0hDc1dZNUdnK3VYYlkrNVQ4ZlRRRU9zd3RpYm03c1dXU1htTWNaU2RiTkhP?=
 =?utf-8?B?N0hLOFZlcVRLV1NnN0kveU1oOC94ZmJoYmV4OGl5WHdIU2FoY3VTaGlMUFNN?=
 =?utf-8?Q?58+vGVR2QM99FXxQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE88ACAD9F56C74A9DD6B4041F15B55E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IlEBdXr1Csm5rLnXIKy5y/mFKF1vIJCQt8HrKiVXItt92cC+pAuqgonKGQ6Os5Ng7hwDo4i7a0Ls002bqLdWRmhdz8gkzGDcLQziGaSRa215ETC2UlOkoy8YXmxLjPlldCvWcX9omjyyPEP4/R3XvOfCFBpPQYN0nTOx9gRf3M13wBVBmpfWFGIQzwnPH+6eAVuCisBMonBHZp9Hejlf5WqWYKVZF0CYJ+KCA14fALRYfS9SF2Q8zk2hzwu5+ID5TUQGN4lLAx4kXrieVwiLCL4C+BfUGdQQqVx5Zd5vuF4p0iEdQhrcIqznZTHo0ifZgeBpl6mvaEL1mbX8hp6sWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419e2bd7-7bdc-48d6-1991-08de7fdfdd17
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 02:34:19.6455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcVg4c2GSdLzNFX5Z/8ZR+Aj+spr9/pFehwKIIDV59RtYvvtbtyndQ2UwYuydwjpq6isoFo2Ew2L8X0LLovNohlt138iU58Zv5JI3S0Vnuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAzLTA2IGF0IDE2OjE0ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiBU
aGlzIChhbmQgZnV0dXJlIHBhdGNoZXMpIG1ha2VzIGNvdXBsZSBvZiB0ZHhfeHgoKSBmdW5jdGlv
bnMgdmlzaWJsZSBvdXQgb2YNCj4gPiB0ZHguYy7CoCBUaGUgYWx0ZXJuYXRpdmUgaXMgdG8gbW92
ZSB0aGUgbWFpbiAibW9kdWxlIHVwZGF0ZSIgZnVuY3Rpb24gb3V0IG9mDQo+ID4gc2VhbWxkci5j
IHRvIHRkeC5jLCBidXQgdGhhdCB3b3VsZCByZXF1aXJlIG1ha2luZyBjb3VwbGUgb2Ygc2VhbWxk
cl94eCgpcw0KPiA+IChhbmQgZGF0YSBzdHJ1Y3R1cmVzIHByb2JhYmx5KSB2aXNpYmxlIHRvIHRk
eC5jIHRvby4NCj4gDQo+IFllcy4gSSdsbCBrZWVwIHRoaXMgb3JnYW5pemF0aW9uIHVubGVzcyBz
b21lb25lIHN0cm9uZ2x5IHByZWZlcnMgbW92aW5nIHRoZQ0KPiBtYWluICJtb2R1bGUgdXBkYXRl
IiBmdW5jdGlvbiBhbmQgcmVsYXRlZCBkYXRhIHN0cnVjdHVyZXMgdG8gdGR4LmMuDQo+IA0KPiBJ
ZiBuZWl0aGVyIGFwcHJvYWNoIGlzIGFjY2VwdGFibGUsIGEgdGhpcmQgb3B0aW9uIHdvdWxkIGJl
IHRvIHJlbW92ZSBzZWFtbGRyLmMNCj4gZW50aXJlbHkgYW5kIG1lcmdlIGl0IGludG8gdGR4LmMu
IFRoaXMgd291bGQgbWVhbiBhZGRpbmcgfjM2MCBMb0MgdG8gYW4NCj4gZXhpc3RpbmcgZmlsZSB0
aGF0IGFscmVhZHkgaGFzIH4xOTAwIExvQy4NCg0KdGR4LmMgd2lsbCBvbmx5IGdldCBiaWdnZXIs
IGJ1dCB0aGUgYnJlYWtkb3duIGJldHdlZW4gdGhlc2UgZmlsZXMgaW4gdGhpcyBzZXJpZXMNCmlz
IG5vdCBzdXBlciBjbGVhciB0byBtZS4gSSB0aGluayB0aGUgaGVhZGVycyBhcmUgbm90IGEgcHJv
YmxlbS4gQnV0IHRoZSBmYWN0DQp0aGF0IHNlYW1sZHIuYyBpcyBtYWtpbmcgc2VhbWNhbGxzIGlu
ZGlyZWN0bHkgaXMgYSBiaXQgc3RyYW5nZS4NCg0KSSdkIG1heWJlIHZvdGUgdG8gcHV0IGl0IGFs
bCBpbnRvIHRkeC5jIGF0IHRoaXMgc3RhZ2Ugb2YgdGhlIGVuYWJsaW5nLCBidXQNCmxlYXZpbmcg
aXQgc2VlbXMgb2sgdG8gbWUgdG9vLiBTb21lZGF5IHdoZW4gVERYIGlzIG1vcmUgaW1wbGVtZW50
ZWQgd2UgY2FuIHNlZQ0Kd2hhdCBib3JkZXJzIG1ha2UgbW9yZSBzZW5zZS4NCg==
