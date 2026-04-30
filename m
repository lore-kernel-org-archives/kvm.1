Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C139FCA8;
	Thu, 30 Apr 2026 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584927; cv=fail; b=TlKfLjjhCiKDYTU90uEghtebZUBZGU1ITX3U7l8fpHosFbVbdpocM1r3JrQ1ILoftc3rheJ8VW76fDvaEYfObUjQkAMogJK0g3VpfZXXKI6P9QZ6dH16zRh9Q5GLg5UT+izaj+g4Yf8yWEy1kBWOrboapLyelh24plmWXJdHtug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584927; c=relaxed/simple;
	bh=I5YqIBEyPyiUw2aHkjOwIb/JhhjkO3+p1YYvFicWIME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=igD1JOrD3k88csMfVq7AICYOzJVz+Q1VTNjUA+kUi1xd4LysQcCbf1/vn6E9t1sEmfug9e8RClDZFKHy3y9FHrQJjHpMqTpRt+Z638DgR/99f8RdQ0BP77WrSCnEizlmNBQRgMPAQHxSGtEKXNsGFoBuP5oUYlhTFc7l03KTIJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwYJLA6K; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwYJLA6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777584926; x=1809120926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I5YqIBEyPyiUw2aHkjOwIb/JhhjkO3+p1YYvFicWIME=;
  b=HwYJLA6KhWQI7mu1N3EOgwN5Qmqcpqn1jYeyZfhFl7ecVo/IhohhqTAU
   OUxm+IWQmTqjoIN7RwlLWw5Mx1DUgWxrArrrs4ydt26uigN3ZtncT/WxQ
   MiqJ/B0Qr2Q1U5PFyKeUHFYGbIhv3flPtS7KTbGenL/BrNDi63D5zAfIs
   499zqGwf0f4csl5e92M5wibPgo4DhjKe6p/u4Ib6Opv4TxWFofXYO2ys2
   TCEmldp7TgoZ23YxuZClgJeNZ2pcaDNolQ4YjwDQMdCRLekL8FdZsVU7z
   qixtSydFrU8vuH1KqFrnrUAu3H1eJBEHAY82LeTXYi4RdgSI1xDBr5AtR
   A==;
X-CSE-ConnectionGUID: BlyMt36UQsKW7hpDUSs+gQ==
X-CSE-MsgGUID: MAIZba/QQYOoRMlBgSMIBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78604121"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78604121"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 14:35:25 -0700
X-CSE-ConnectionGUID: dF4csYLsQrWpUwLOCIqIjA==
X-CSE-MsgGUID: YiyAmBqhRsmPeiaM6ZinQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="272800592"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 14:35:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 14:35:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 14:35:24 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 14:35:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhLin6Ohlw8shEKsebSSjQvkNRHC2DElhXsz8MNowhwG/j+Rh4YoGzseWyLdy1yc5OpRuOqh+OGI9uRPq3WK1HDTeNijvLSe/WBm+GKTXu3Y88BIm0uN7g/quBSQr+MbF2Px0RARRcQKZjLQ24jfjvBF2kJKqA45hMUvoXBHGNsvWB7QA9exe7rrg5CEdAQO/9BiBfJX0pOv6EmaEbcd7rJpwPBOFa5Z9V8khbtATe+SGSEEPexcfqoNki9n10PNnBRwKcTJp4Tb/aRxIs0JkUZFd5G8sHuE1690bS25spMxIVxaEVKpcOUhoRv+yZmCP9htwFxTI4nmy/iC2d7hSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5YqIBEyPyiUw2aHkjOwIb/JhhjkO3+p1YYvFicWIME=;
 b=RxAvlDuzGnUr7EdrKGwyHj8vd4I1kFrK45CWBT2x5Z4iDOM6SbPpz95wCYCOH21eY9zrid/mWNvYElT7pthonorGFQDRsP+u5PSDrbTXU5IduKXOeMI+v297nAestIwI6hvkGP2TFF3iHwDlH/cwuM44w5pzut5VfmPslgBqJAjm0Y9TODarVPHztSf+Zl+9P839/07qB9TJcur6i//XL3btoRS/NI+/7l6//euMnoXcjPq4yoqLnqS54LqvtY6dg0uPNMYwhvJzKhXMOgNoXEjz79oKGKEBJnDZvH5Y4dhvE50iUXWHxpv/2LLwUF183ACcfL1h+3mc2aHcWJT/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB6444.namprd11.prod.outlook.com (2603:10b6:208:3a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 21:35:14 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 21:35:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Hansen, Dave" <dave.hansen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "Shahar, Sagi" <sagis@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v8 15/21] x86/virt/tdx: Refresh TDX module version after
 update
Thread-Topic: [PATCH v8 15/21] x86/virt/tdx: Refresh TDX module version after
 update
Thread-Index: AQHc1lrB7LdRSitZuUOsI11fdtpDdrX3/nAAgAAnUAA=
Date: Thu, 30 Apr 2026 21:35:14 +0000
Message-ID: <793ac5a9339a4de0cc4571a33d99f2f1fe649980.camel@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
	 <20260427152854.101171-16-chao.gao@intel.com>
	 <28be5180-ff74-4e4d-b392-7ba7a9b4c1c0@intel.com>
In-Reply-To: <28be5180-ff74-4e4d-b392-7ba7a9b4c1c0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB6444:EE_
x-ms-office365-filtering-correlation-id: 7b08a88a-01d5-4bd0-84a7-08dea7005dc6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 9nWjSJAHy2FM7UM4Ml/nmJYPQqPOv4iPfg54MabyTJQE+caVP74wKeQOk4MY3YeTE9HZsjeUJ+J97DeYgMrIxlsDia3R5RWICAyuSfce2NDKYiPPpCsr3xXb2OhT3syku5AytzYkxFDceCEGkbFscUK20wCdpGrlWwS6mrIdy+xNx78d3PDDHLdRwx8OEF2sD0bp3R44rulTVnV6n993ehN1Tmb6YvGf7PR9+oNiW/5gukV9ZwpPXayDXG9gUiIx2sqMHnuIrg1VysA+fOM/IkV5TzC5ZzOC7FdiO6n/f59K3KtggtidEEXAbP3tKn2PLQ46eYQ5AYUmzSjjubRAK2D5ptst8T+U4XwFJqWBYpf1C3locmBpuyByY39/KJ5NMrTk165sz5WlXq2dGlrN2MSLMS3OdoLZ+YTgePIkNOPmgrrqoahzUORXlPLfNsNJRYCjWtKOaM8NvJCdBC1Vd3UqAfVceg7PvKsozzHsPgLQR/xoXWQsBDEC8MiT9gijxQmDe1Mrb0+hZv/ZNMDPPEVqvZiLEc48ROWwbneukDjvNlVlJwrwryIfQkrhROgMZl/chq9+O2EPaVVMOmkaEbc4S7zztxA/2nijoQ5XJQdWwZqOOpB6SAmxISpS7Uicl4a6bESCuEOMk0/DNLsp6PCU21x91+l56l9cQjNrUhCy4OEbGu3gnu7XmdlJDsqPQoqnSI90VudMDj2ewVPu6zk+VCs4+SK6l+30ZjwXeo3cvDPPRm28i7iKHmT/EtYt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGFxN1JXM2VOL2lvMU5WdU9pSzEvVWc0NXNCUWE5WDhENFJBYmNyUXJVazkw?=
 =?utf-8?B?M09xTnByL1BnRjNxNmtxd1VxZXpjODU2R2QvS2VONUNpbkVaZ2xjNzNxOEU0?=
 =?utf-8?B?aFBJeXVETDQxL3huVjZxRnpDdXd5OGdWRTlGUDJlUTZwbkxyOXZmakc4YUFx?=
 =?utf-8?B?NGd5UlpCV1VxY3M0RnJJcUhYV08vZTlnMnVSY05LS1lPY1R0ZTY1aU9hWFhn?=
 =?utf-8?B?ZjZSVXdUMkRmY0oxNW9CMmE2ZEpUNTIzQk1KSUZGVGJUWXRiTHNETkdzZXF2?=
 =?utf-8?B?dm0rbnV6UHdzUGFFZENnd2Yxajl4OFFqdWZzYk9rS20rNTZ4akF5V3pVOVg2?=
 =?utf-8?B?RTBUeTBRRkFMdGxrRnVxY2xSbVF0cUhqMkpYVGJYb0xJbEJvMDQwMWpkMEVo?=
 =?utf-8?B?eHd5R3NnYm9iR2hEdEQxc3haWVFkaTk1MGt4MHIzSy8vMnhva2dBSVpJbTk4?=
 =?utf-8?B?ODZtc0xuT3hybHNMeHREdkJWNzlodVhhcExZRk1YeTZYNTlsQ1lnRDBtaEN0?=
 =?utf-8?B?VVFZb0hGaWVRcVFpek5hSWkwZEdkYzB6ZTgxVnBQRUV5cEhGZmMwaERHVnRw?=
 =?utf-8?B?QnRGanc0cXJqUS9GWmhIdUlUVStyb1pXZnkrazFValY4bzVXT29uUHJCQ0Vu?=
 =?utf-8?B?a3l4UGs3K05MTnVzKzlWa3JkODNOR3RSZjNVb0JGUDMwVnNiTjREQ2h3bExW?=
 =?utf-8?B?WDU2V1g2Q0hCVHErQVVIT096MHRzSlJvQW9OcHBvZEptTjh3aG1udHJCOWFj?=
 =?utf-8?B?d29HTmZ5R1dnRnRkUW1lOThDUU1lUWZyeWcrd1hjajB1THJhUFpmQkswU3B2?=
 =?utf-8?B?ZHdWQWNzRWRobGFURTNNbjAwcjNVNUlwWjZ0U2padlRZYUlhUHFlcTdldko4?=
 =?utf-8?B?V05oY1hoYnA3Z3Z1MGN3SVFOSkNwYTN2dEJkZ2UwZHV1a0oyTm5iekxpWGF5?=
 =?utf-8?B?M2M2RFJ1THdubENmUWZYV1huQjBtMWdUTitSbnA5alQwdFRyQXY4MnJoYjNR?=
 =?utf-8?B?ZG1YYmZ0K0Y0aXZObVM5L2JvWnhIRGNDZkxuR3dSZVRIN3RpNTdSc0xOdEpN?=
 =?utf-8?B?RVJ4aEFxSWV2NFJKT05aVWlXRFZ0RDRtczFvRzJBK0hzeFUyVjJYT2hDMG95?=
 =?utf-8?B?Zlk4cTB6L2FTZXpwamJxNWN2OWQzZGdVK0xLcWdUSmM5VlF1Y1FRYnRibDJV?=
 =?utf-8?B?SlczSSsySktFMXdtNkxJM3NNVWZzVW1tcTNQd05ncmJNUnhvR0xxS0FHS0Yy?=
 =?utf-8?B?VHRodCtlZlJKakhoQjZqQnJQaDZVL2RjOTE0RnAzcmdrTG5XL04rZTRPQXRF?=
 =?utf-8?B?MWU2OCszbEU2aFV5bWJreElvQmpSbllRUjFSSVVqajlncU11b0JYakJ4VVNs?=
 =?utf-8?B?cVkvZXhFM1lrYmF4SXIzMGFacDAwL0tYbDNGMVpVRXZpWVVCbk1PQlEyajd3?=
 =?utf-8?B?S2Q4eHZraG5qbUFQUHZKeEZhTlRVRW9lV0RWdXpKRjJUenRrT1NhaE9pN3Qw?=
 =?utf-8?B?MVhYQlA2cUxoVFk3WlpLYi8wcjBoWEVsMUdlZmRsbTNsOURkazViaDlRVzF0?=
 =?utf-8?B?NjlGdkthcnFmUllORG4rL1A4WGhTaWhEYU1XbWJtVzlCZTVpQVkzYU9xSzFv?=
 =?utf-8?B?SnluMFRXcFYzS0s2YkFyWjdhSy9EVG1XWmNTTDg3TCtOS2trVU8reUhabDAv?=
 =?utf-8?B?dXEyTWZKTkE5TmhBU3BaVFFpSzBEWVVvd2ZIcDQ0UGd0dzMzWWh0eDFlME9H?=
 =?utf-8?B?UDB3MkVYWEJ3RG9TVnl2c3JoTWRzMUtHb3FnNHNMQ2lIUjhiNnBPNUkvTUw4?=
 =?utf-8?B?MGRtR1NzWG52cEEzZkp2MFZEbEFETi9CSnljcUJ3Wk44TmtQN1h5ZHpWYVJQ?=
 =?utf-8?B?b2ZsRjlCNmhPSlR3cXJYakM5bWNIVUVJUVB3bmVHVHl1M0x3aGVvZFdrR3ZY?=
 =?utf-8?B?djFCbjMzalNyeS8rUFJQODlKMmdMOGVDd09aOVdPcHlIWjFKWnJTUzU5NW1R?=
 =?utf-8?B?WkUwM0RjTnlBUTVzSVJqY25CQmF6bXFrZG9aclNTaWlDK1hXeWF1SWdRSWdS?=
 =?utf-8?B?K3Iyd0NvSmFqREhZTlE4anIydzJyZ3VrRnQxcTVEYmE2RGxQME5PTW9YSER1?=
 =?utf-8?B?dzkvUjQ2ZTNkTUV0WWtRNDFRNWZ2blcrWW1KZjJjMmkzTy9ZUHhja3RtM1RG?=
 =?utf-8?B?a05iMlU1RTA3bTRMeXFvQzUvd3NubllQeDNPbTJXSE9wcVF1TG5Ca3RyTnlr?=
 =?utf-8?B?TzJiWUF4TjM4bDhidi9jeEhkaXhpaEduUVZhNjZhNmZxZlJHZjhDYklkaXRR?=
 =?utf-8?B?V0FyMlZrdEVxcFJnaVZQaUIvYm13LzRPRE1XN2l6SFRseGFiMTVZeldSUVUx?=
 =?utf-8?Q?4VSbRRTAL7d89qis=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C2AF67E7400414CB1928951658F3080@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q0v6AwRld9z88FU1ZCtlzeuWs4B2Kyq7pAHLUriqtAjXmqmAQ0u0j+Ql//cnXfSzmpCaSMH+Sw+EC+F2nfCvJWfrD2RQLq5aqQWWwF4B0pGHN7Npw/C4JEBU/sxpLY/ClFdDt8R4RzDCrk1aH47b8gAm3dW1SKrfasfonERy5A4FEd4FSByK8l8j7SwzDlaflMCjFwtvLWdncuxQaf0h/HL6Y13epTDDseUn+Ngyk7Ev0GFVmkwxVvLsWswvUByO6kZKxF9eVF9i4pJPQ2Md+u/dwN8lMWl1oziCvKzcsp5ZqmC5loS1rwQk8GGPn1uRap3RkDMlnnYF4mm2gmfrOw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b08a88a-01d5-4bd0-84a7-08dea7005dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 21:35:14.7854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zevkdR4F+RJeOZ2iC5doYkdj4eIiqmJFHmgWrC9yZi8yYCojVHUg95Qfx7viN1gtWLemJr2EeuKzXO5IPw5tsFMTkmZFDspl6wcFvIzKTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6444
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTMwIGF0IDEyOjE0IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
PiBEbyBub3QgcmVmcmVzaCB0aGUgcmVzdCBvZiB0ZHhfc3lzaW5mby4gUmVmcmVzaGluZyB0aGVt
IGF0IHJ1bnRpbWUgY291bGQNCj4gPiBkaXNydXB0IHJ1bm5pbmcgc29mdHdhcmUgdGhhdCByZWxp
ZXMgb24gdGhlIHByZXZpb3VzbHkgcmVwb3J0ZWQgdmFsdWVzLg0KPiANCj4gVGhpcyBuZWVkcyBt
b3JlIGV4cGxhbmF0aW9uLiBJIHRoaW5rIHRoZSByZWFzb25pbmcgaXMgcXVpdGUgbnVhbmNlZC4N
Cj4gDQo+IHRkeF9zeXNpbmZvIGlzIGp1c3QgYSBjYWNoZSBvZiB3aGF0IHRoZSBURFggbW9kdWxl
IGlzIGFuZCBjYW4gZG8uIElmDQo+IHRoYXQgY2hhbmdlcywgaXQgbWVhbnMgdGhlIFREWCBtb2R1
bGUgY2hhbmdlZC4gU28geW91IHNvbWVob3cgbmVlZCB0bw0KPiBhcmd1ZSB3aHkgaXQncyBPSyB0
byBoaWRlIHRob3NlIGNoYW5nZXMgZnJvbSB0aGUgdGR4X3N5c2luZm8gdXNlcnMuDQo+IA0KPiBX
aHkgd291bGQgdGhleSBiZSBjb25mdXNlZCBieSB0ZHhfc3lzaW5mbyBjaGFuZ2VzIGJ1dCBub3Qg
YnkgdGhlIFREWA0KPiBtb2R1bGUgKml0c2VsZiogY2hhbmdpbmc/DQoNCldlIHNob3VsZG4ndCBy
ZWZyZXNoIHRoZW0gYmVjYXVzZSB0aGV5IGRvbid0IGNoYW5nZSwgcmlnaHQgQ2hhbz8gSXQncyBu
b3QNCmJlY2F1c2Ugd2UgYXJlIGhpZGluZyB0aGluZ3M/DQoNCj4gDQo+ID4gTm90ZSB0aGF0IG1h
am9yIGFuZCBtaW5vciB2ZXJzaW9ucyBhcmUgbm90IHJlZnJlc2hlZCBiZWNhdXNlIHJ1bnRpbWUg
dXBkYXRlcw0KPiA+IGFyZSBzdXBwb3J0ZWQgb25seSBiZXR3ZWVuIHJlbGVhc2VzIHdpdGggaWRl
bnRpY2FsIG1ham9yIGFuZCBtaW5vciB2ZXJzaW9ucy4NCj4gDQo+IEknZCByYXRoZXIgaGF2ZSB0
aGlzIGluIGNvZGUgdGhhbiBhIGNoYW5nZWxvZyBjb21tZW50Lg0KPiANCj4gSWYgdGhleSBjYW4n
dCBjaGFuZ2UgdGhlbiB3YXJuIGlmIHRoZXkgZG8uDQoNCg==
