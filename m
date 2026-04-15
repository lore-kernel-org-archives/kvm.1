Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC791BD9C9;
	Wed, 15 Apr 2026 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273591; cv=fail; b=BUJy+eGtM9F8qn8ZiG+vazIfRVad/WoBy4u0gZFy8hp4wXlGBrqnG5/drMUHs9IN0b3P/aYt1rXC/HqWv16fGiSRHdLbjXIs4/9NJ3LSFkXWSi3IFIp55m2dDCAAEUTQTOoGTvKMWaq1ceuiBqjhozi5qqS4tLDWx9xSUIiEZkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273591; c=relaxed/simple;
	bh=ftOxBMosmX2T/nNItLrxqTd0PuwBsnO5brr8X4XanyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EoSLZ5MDhv+q1TdBT7Bu9TKeoe63i2vdcMgiqh5dCUlHl6GxiU9p33hLSaMdtTPQU9NDhGwhQqU3vJn1ytzMpr4nu0L5qYiqcVBJ35zFIsOyDNL4qxF1zA69r+Uy2m4Zz8DxdIcEpyhaW//F1LHOrNMXlq//xYAfj5lK+GIcsXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcTiWxdL; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcTiWxdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776273590; x=1807809590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ftOxBMosmX2T/nNItLrxqTd0PuwBsnO5brr8X4XanyY=;
  b=FcTiWxdLf4LlQYuAF5Smtb2prbTmOcm28Ew+TY3vwZTYTqJvBIFnrv9O
   pFTdMfzqe1EPOZw/4BVc1jXVHWWCO+PwTkAPW2ST8TH/CcUKFOv7HCARP
   ddjC2lxzYoIeZL/DES1E4l+jJH2hZ/BTGb3PpUfYmIVVAMINOPLwMG/x4
   p5zNvYzYFnAHHnCNp0fTue7aexMhn/fXmfM4w5GgX6yo+DUjmog/w18ET
   2B5cZ97tGFWXRb5rahj1/+FU12HrrLR/V9XRFICZ0S6AFVuXr/Ww+5HYS
   fLKBskZd7mcdvm/PJHDQuFk+35+gvwd13TKLtmfL3wzt8KHnol2v+x13K
   A==;
X-CSE-ConnectionGUID: V13/sYTWRZ+gUH4F+1aPlg==
X-CSE-MsgGUID: lnHNERkhQc2Yf/W3uh8ECQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="79845461"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="79845461"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 10:19:49 -0700
X-CSE-ConnectionGUID: D6c+APvpTHy0I2JrBO4Pcg==
X-CSE-MsgGUID: FXGjjo8IQfynb2mYRAdILw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230726403"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 10:19:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 10:19:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 10:19:48 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 10:19:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eI03933GiHQbI+gdb4o8yB1pInTvLrkNZFoUNHYzfGnn8r3lx8D5naoWsfqwBMZU5/x2w2swtn4oMIDzHiNfDpTHnnazaqHVjcsloVk+jAs0jwl1Y3zLxtCiCzgres5k3Brbt/t3DeFyRRB060MIeS5ciyOq+PwUPjL22dAKl6pvwv0rAXmUUXIPCVt8EeDlvbCKTdpIvm7Mqhr4P3E7aTPeyz90oYezhVhywYfn4s0cRKU5J/pKcW61wJHJxoe58CQVw0fo6ANUOogLc1ra3kyKmOSgCzcaoliv+r3uwpq/sLPYYIEq8W2gA0mZSGCvVo7NAy23v3Hb4LLfgYZRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftOxBMosmX2T/nNItLrxqTd0PuwBsnO5brr8X4XanyY=;
 b=m4ugQSnl07Jyc9NH2C7zZ8Cj//wX1Up+tA3VPKa4Bl9hLsXOGpvAW7uBuk6BPvAEzTypHda54WDyICk1iKY0Atew/4TTuY5MkT3TCUXxk/SN461LrN+hICvxnKIV1cH2Yt0No+bTS/01e4l3aVk4eqqnmOBQJpVctV96qHeJko3tOFaxLMv3e0dFBsGmpX4plfp66kl33OHDuElVT/O3S3XdSdwtlm1dUMve2yhC28Or2pZ8CXR+j+4j2jjq3UNFOgo/bDp9NGNK9BuO7NIdSNH+n8T7lA3+ixiBXu/2ccQvRKI7caeHu5beSnTsSsQsuwH2Fjw2dAvSgTRtn4BerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 17:19:45 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 17:19:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"Weiny, Ira" <ira.weiny@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "sagis@google.com"
	<sagis@google.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [PATCH v7 08/22] x86/virt/seamldr: Allocate and populate a module
 update request
Thread-Topic: [PATCH v7 08/22] x86/virt/seamldr: Allocate and populate a
 module update request
Thread-Index: AQHcwQv/4R8odDpJ1EmXBBfIkPnQIrXZHwaAgAVFSoCAAIRfgIABJHUAgABpboA=
Date: Wed, 15 Apr 2026 17:19:44 +0000
Message-ID: <8b41cfdc060fa80a68ae37e8dcba03eecc4ff0bc.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-9-chao.gao@intel.com>
	 <a6a3426ba9b84ea25f3653e33a181dab0096b35f.camel@intel.com>
	 <ad4MWR0DyOaI0C50@intel.com>
	 <1016261178d32a5c6f20d1507f28388dd01a15df.camel@intel.com>
	 <ad9wuJPdluqJrcBM@intel.com>
In-Reply-To: <ad9wuJPdluqJrcBM@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB7521:EE_
x-ms-office365-filtering-correlation-id: 7360cee9-3d92-4b97-87ad-08de9b133031
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|18096099003|56012099003|22082099003;
x-microsoft-antispam-message-info: Vg1P6rykNe5yzO76xO7I83zRHibny/8BPjkk3UudFySM14+f4hdoc5NdBmMQmM2gGJ35ROI0todIKQkOqWmw4VsSDVQY0hOZvKgFpep+c01VVGN8HltZtv5LmDpYof4lfOG6nbPHGflOAxfcCUlGrD8quxaCPLBukdd1eQcslLMXu/7MyP2R5Jd1wudLsgfBYf6h0QbAo6UW57nhGwnsQoHRaHeOuknyO9RezOY6qupxlcmtL3C93j3AjyZg5uIstqt5Vqea/KYpV88CQ4kR6KepCIiZYv1cqICtZEqt8jYLLQFtdEO7nfNSkwMJ0hQijSOyJUdQCn4aEVcKJuFeO5lL72aufoi8d+GS6BS4OIR5nxzviwPpWNfHw8wtcoTrv7jmlMiEnE+mbQDEMvcdMrEmVyc3+wWE9/pLHtlsiGybj3S8nzZKTdHcodNuECDN0ah5kqjm9mUl77D6t+wXXm7g724iBw/HgWIwWKHkq7d7fPt1J6UA6dz4z67OwJvQUHPZ7TReeJXh48qVmnf1Nh5AgKRxU2AdMzY1d+gF7Qnrglzs+1tgkH4iiujxWHbWLcYTPprn2ebVMLTyk4tA2a6vziig/qsvB+YahxVhKHD5cROeKaI0+7BXaGE3KCCOwExxa5tYhRnlKlO/qvX2mOZvtE0mpuja4CduVpUnxY+xWON6NLsx/qJINRnYP/Y5Rn6WQROGxTOR0lz47zKIf9oDbOpFp4t4qqXrmPFBGppu+oLaDBHu49TEOVQ0xe+fDQD6/fN1K3AkWd965OGaB2bp72JSUQPtkiDUCz9ukFw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(18096099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXZGS0xOamppdEZ1cnNObmZ3Ni9MRVVrNWE3VGxub2RsY3Rad3ZoMXpnYWho?=
 =?utf-8?B?dzNtYWxGejVlUWNadXdCek8zMlBmZmJnd3MxNUFNV2dsbVY4TEd1SkZtd3pW?=
 =?utf-8?B?UUc0c003SU14RURDcmlXMlZWUDFwc0lTTVIzR0JuK1NUWVh1K2xWZ1lQVTdC?=
 =?utf-8?B?cVZhV0pEcm1tNHJ2c1VwdjAwRWljaC9sajB6dGUyaVl0VUxRUGhyNEVMY3BU?=
 =?utf-8?B?QmE2ZzFjUnZTTUtZR1NZUitoMUhSL2p2N25SVWxYUHE4SUh5R2hzSUIwRHN0?=
 =?utf-8?B?eXlwOHJoN3QyNTVjT0tpQkYyS1RvTVhvZEk0RWFWdlNLWE5sTzE0dys4UjN1?=
 =?utf-8?B?M3hxSWxmRkoydHB3UnBwNi82L1ZFcFNPOGhMTnBEN1I4SmxhNUtXMDJHNFBr?=
 =?utf-8?B?eGtMTGRrQUFUT0VFS1RvVmo5U2QreW1pWkNlb2JlYU4zc1lDRVhxK2hsQUtG?=
 =?utf-8?B?d2xuQ3JQc3ZmOW5PZEZLZCtZc2xGZVk5cmxyZjhtUDR2THkvN1R4Mk1RYkpw?=
 =?utf-8?B?NW1SM1NFdmEvc3ZUZ2Z0L0ZOVnJOWmhwUHQvRzlaR3lqMWl6VmdQZTlzV3M2?=
 =?utf-8?B?VG9rY3BpTlc3c0VZQzhoV2pBci9LNHBjM3EydkNGV1Bkc1FlMW0yYmhScUhW?=
 =?utf-8?B?c3B0QmllZ3Y1MEluYWwvNTVCYU5PK0M3TTVSdjl2TG1hSEt1SlkxNEk2QXh0?=
 =?utf-8?B?WS90WmxsbzZQWU9WeTBiUER1TGh4NmE3NnZiWVdBc1hxbGpPdlNyamNtQkdx?=
 =?utf-8?B?TUVqcVhXYTVFY05zQlFjbnVSU0lPZ3l2VTlWOUJuam9iY3hUMFQzLzMrNDFu?=
 =?utf-8?B?OVRPK2plRUlqMy9ZN1ZZbmtqT202cmxPRk0yUkxWSnhJRTZkcmFnK21TUHVD?=
 =?utf-8?B?dnhXUk91SVBzK1FEalpLMXBtM25xc210T0RNemdyeXhWcWwzdHMvWmNkNHQr?=
 =?utf-8?B?TnlPZ2UwQXlSWXhmTXYzYnNMdEYvTFkwdmJtZGRITjIySEdYaVQyN0x2MHZL?=
 =?utf-8?B?U0xSWkQxK1IvaktYTXVxbTBBT2pXc3JMWDdoT0JBOS94UnozNmdYeGJTV2dS?=
 =?utf-8?B?dG1ZQ0ZmWVY4WUF2dVMrcEM2M09EbGc2MXlybFQ1aUdHSGUvYWthTDVQV2xN?=
 =?utf-8?B?aVYxQ0FhSFAybC9Gc3lRWUE2MmlpcUdyaTduNTRmcGJLU3h4ZE5VdEppWXl1?=
 =?utf-8?B?NGtXZ2VNQ1VJMUdCUUZVN2huL3FGVWtxNTV6dnNOdG9JZEJHc2dyVDJ1S3Ru?=
 =?utf-8?B?Tm5FRXNMZmZVV0I1V2ZUbDBRQ3hndGNsQ1lOZ213eVVQdUQwQlErRERDQTVn?=
 =?utf-8?B?NkREYm8zVnNDb2RjL2JSUjY1TmlZbEYyVGlkOWM3N0lidjczejdZNFpleE5t?=
 =?utf-8?B?OUxHbWt0OEV3a0pnOURJNG1OS2gxOGNBNFRET1dHdlRTSUpNaFN2eUlmMXgr?=
 =?utf-8?B?eSt2TmxDQnJGT092OWpUYStGKytOTjNKbi9BQXFNMDVVWW5EaU0xVTNFK3ov?=
 =?utf-8?B?U0NGZURoVUR2VXAwWG5XVEVUQUZSV0NyL0llUWhSVmd2a1NCdUNxS3pkRXJK?=
 =?utf-8?B?bEhkcHFZN0h5NmlYN09DVjZVaUt6b2lRKzdHekRHOGJPT3dVVUhJL2U5OCtm?=
 =?utf-8?B?Y1FZZ3VidXdYcDk0NUFXZm96SHQ3NTVEQzIrcEdXWnJ5cVZ5NGlRczNYRUdM?=
 =?utf-8?B?dmRCQ1NwN3JoZ2xKY1VPWmFJVWZxdGk3cWo4dEh6d09QMnRQbDB4Q0tSVnhV?=
 =?utf-8?B?V1FlRlVYOVFTZE5mYTlFQkNodE9oRVRJcVJhS1dCVHNQRGM2ZXlDSUtIVk5Q?=
 =?utf-8?B?a05UeldHbG5RUkJsTGgyWFpKM1ZXeVFsSUU2bkxzdkxlSU5KUWNabDlCd0JD?=
 =?utf-8?B?YVJ4RXhHVy9admRLd0NxOTdabkd0MlpiUHZhMEVCODdiMW1sNDBua3pMTFZq?=
 =?utf-8?B?QzFZMmxuMEZuU0NOSGZGV0Q4K1hWMkJrc3NqQTZGMlJ1ZW5JY1Q5eHc0akxS?=
 =?utf-8?B?cEdyeHJWcnpaVjN4WjBtMEFicmNRRFJHNnAzZEJRWjBDMU8vOGRzRXhQSDhm?=
 =?utf-8?B?U1VwdldJSmJWM0JjTEJaRHRKMHNjd01uSGc0OWlrV2ZOTzNDU1lOem1zZVVF?=
 =?utf-8?B?ZmM0MFI0R1FyOEZQVThxRDF5dysyTE1vTHlzSkhPYXpNMnVUTmp2dmlhaTRY?=
 =?utf-8?B?alo5ckp4a0xCaldnV1NMK3pMd0dVNE9kOURQRzQxSHNPdFVmL0VCbGt2K0Vp?=
 =?utf-8?B?ZWsvNUxzTGtOREZZaFR6NCtyM2RVOTZNcXBhdHAzMzIvOWlkVnRQRW5jcE90?=
 =?utf-8?B?S1crR0lwcVhZL0VGdWFMOEhTMEVPNSt6NkpxY2gvbDdhUDlYM2Y3NzVLZE1Z?=
 =?utf-8?Q?EdaVg7Xkgyd1Hwok=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69545243B8278E459AD209D91C858256@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lJcTdfdvjgtlWZXEB2gjg+kKalusQrwR3CTTEw8/4jCd4LqyRIV6yXR9FMsfUQw5qdddvBqBbNGWHX9HAeR0KHYu2k6CDnff2P91ujD6GWdTwyw6N3bDFlOv2aP4g7Nl6V7Q3QIGWyT6td/PyubZ9ZpTO0lwv6OxCw4dy05mOjiWmontY+D+T38HCL9Mkh6u9wdaP8o1+qlZazJqR/yKAiDMTJ0YJ/Q428bmW1im84HioNI0mEPDSZyqGbUe+qR+Gx5U6y/hIaAfYKkSRVvl4qroatKaZkcu2XBeUKY5A1EW3cn4Tz30w8TPWNP5d5rFAJhmI1Y4R4LEpJJyQ3VwEg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7360cee9-3d92-4b97-87ad-08de9b133031
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 17:19:44.8051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+pQGNdw2J9qXF8gituxTenGFJwybgnGx5TBdP9TCXLWRaeB6wIzq40SwsZ3h8r+i/Sph5Vt7WlzHtfnQ5/RRkfFZcGiqKj2LsHnvyRvxMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTE1IGF0IDE5OjA0ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiBJ
IHdhc24ndCBzdWdnZXN0aW5nIHRvIG1lcmdlIHRoZW0uIEkgd2FzIHN1Z2dlc3RpbmcgdG8gaGF2
ZSB0aGVtIGVhY2ggZG8NCj4gPiBhIGRlZGljYXRlZCB0aGluZy4NCj4gDQo+IE9rLiBTZWUgdGhl
IGNvZGUgc25pcHBldCBiZWxvdy4gTW9zdCBjaGVja3MgYXJlIGluIGluaXRfc2VhbWxkcl9wYXJh
bXMoKSwNCj4gZXhjZXB0IHRoZSBsaW1pdCBjaGVja3Mgb24gbW9kdWxlX3NpemUgYW5kIHNpZ19z
aXplLiBNb3ZpbmcgdGhlbSB0aGVyZQ0KPiB3b3VsZCByZXF1aXJlIGR1cGxpY2F0aW5nIHRoZSBt
b2R1bGVfc2l6ZS9zaWdfc2l6ZSBjYWxjdWxhdGlvbnMuIFNvLCBJDQo+IGp1c3Qga2VlcCB0aGUg
Y2hlY2tzIG5leHQgdG8gdGhlIGNhbGN1bGF0aW9ucy4NCg0KTGlrZSB0aGlzLiBBbGwgY2hlY2tz
IGFyZSBtb3ZlZCB0byBnZXRfYW5kX2NoZWNrX2Jsb2IoKS4gYWxsb2Nfc2VhbWxkcl9wYXJhbXMo
KQ0KbG9zZXMgYWxsIGNoZWNrcyBiZWNhdXNlIGl0J3MgYWJvdXQgcGFzc2luZyB0aGluZ3MgdG8g
dGhlIFREWCBtb2R1bGUuIEFsc28NCmFsbG9jX3NlYW1sZHJfcGFyYW1zKCkgc3dpdGNoZXMgdG8g
aGFuZGxpbmcgcGFnZSBjb3VudHMgb25seSBhbmQgYmVjb21lcw0Kc21hbGxlci4NCg0KQmVsb3cg
aXMgbm90IGV2ZW4gY29tcGlsZSB0ZXN0ZWQuIFBsZWFzZSB2ZXJpZnkgdGhhdCBldmVyeXRoaW5n
IG5lZWRlZA0KaXMgc3RpbGwgY2hlY2tlZCBpZiB5b3UgdGFrZSBmcm9tIGl0Og0KDQovKg0KICog
QmxvYiBmaWVsZHMgYXJlIHByb2Nlc3NlZCBieSB0aGUga2VybmVsIGFuZCB0aGUgcGF5bG9hZHMN
CiAqIGFyZSBwYXNzZWQgdG8gdGhlIFREWCBtb2R1bGUuIERvIG5vcm1hbCB1c2VyIGlucHV0IHR5
cGUNCiAqIGNoZWNrIGZvciBhbnkgZmllbGRzIHRoYXQgZG9uJ3QgZ2V0IHBhc3NlZCB0byB0aGUg
VERYIG1vZHVsZS4NCiAqLw0Kc3RhdGljIHZvaWQgKmdldF9hbmRfY2hlY2tfYmxvYihjb25zdCB1
OCAqZGF0YSwgdTMyIHNpemUpDQp7DQoJY29uc3Qgc3RydWN0IHRkeF9ibG9iICpibG9iID0gKGNv
bnN0IHZvaWQgKilkYXRhOw0KDQoJLyoNCgkgKiBFbnN1cmUgdGhlIHNpemUgaXMgdmFsaWQgb3Ro
ZXJ3aXNlIHJlYWRpbmcgYW55IGZpZWxkIGZyb20gdGhlDQoJICogYmxvYiBtYXkgb3ZlcmZsb3cu
DQoJICovDQoJaWYgKHNpemUgPD0gc2l6ZW9mKHN0cnVjdCB0ZHhfYmxvYikgfHwgc2l6ZSA8PSBi
bG9iLT5vZmZzZXRfb2ZfbW9kdWxlKQ0KCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCg0KCWlm
IChibG9iLT52ZXJzaW9uICE9IFREWF9CTE9CX1ZFUlNJT05fMSkNCgkJcmV0dXJuIEVSUl9QVFIo
LUVJTlZBTCk7DQoNCglpZiAoYmxvYi0+cmVzZXJ2ZWQwIHx8IG1lbWNocl9pbnYoYmxvYi0+cmVz
ZXJ2ZWQxLCAwLCBzaXplb2YoYmxvYi0+cmVzZXJ2ZWQxKSkpDQoJCXJldHVybiBFUlJfUFRSKC1F
SU5WQUwpOw0KDQoJLyoNCgkgKiBEb24ndCBjYXJlIGFib3V0IHVzZXIgcGFzc2luZyB0aGUgd3Jv
bmcgZmlsZSwgYnV0IHByb3RlY3QNCgkgKiBrZXJuZWwgQUJJIGJ5IHByZXZlbnRpbmcgYWNjZXB0
aW5nIGdhcmJhZ2UuDQoJICovDQoJaWYgKG1lbWNtcChibG9iLT5zaWduYXR1cmUsICJURFgtQkxP
QiIsIDgpKQ0KCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCg0KCXJldHVybiBibG9iOw0KfQ0K
DQpzdGF0aWMgc3RydWN0IHNlYW1sZHJfcGFyYW1zICphbGxvY19zZWFtbGRyX3BhcmFtcyhjb25z
dCBzdHJ1Y3QgdGR4X2Jsb2IgKmJsb2IsIHVuc2lnbmVkIGludCBibG9iX3NpemUpDQp7DQoJc3Ry
dWN0IHNlYW1sZHJfcGFyYW1zICpwYXJhbXM7DQoJaW50IG1vZHVsZV9wZ19jbnQsIHNpZ19wZ19j
bnQ7DQoJY29uc3Qgdm9pZCAqc2lnLCAqbW9kdWxlOw0KCWNvbnN0IHU4ICpwdHI7DQoJaW50IGk7
DQoNCglwYXJhbXMgPSAoc3RydWN0IHNlYW1sZHJfcGFyYW1zICopZ2V0X3plcm9lZF9wYWdlKEdG
UF9LRVJORUwpOw0KCWlmICghcGFyYW1zKQ0KCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCg0K
CS8qDQoJICogU3BsaXQgdGhlIGJsb2IgaW50byBhIHNpZ3N0cnVjdCBhbmQgYSBtb2R1bGUuIEFz
c3VtZSBhbGwNCgkgKiBzaXplL29mZnNldHMgYXJlIHdpdGhpbiBib3VuZHMgb2YgYmxvYl9zaXpl
IGR1ZSB0byBwcmlvciBjaGVja3MuDQoJICovDQoJc2lnCQk9IGJsb2ItPmRhdGE7DQoJc2lnX3Bn
X2NudAk9IChibG9iLT5vZmZzZXRfb2ZfbW9kdWxlIC0gc2l6ZW9mKHN0cnVjdCB0ZHhfYmxvYikp
ID4+IFBBR0VfU0hJRlQ7DQoJbW9kdWxlCQk9IGJsb2ItPmRhdGEgKyBibG9iLT5vZmZzZXRfb2Zf
bW9kdWxlOw0KCW1vZHVsZV9wZ19jbnQJPSAoYmxvYl9zaXplIC0gYmxvYi0+b2Zmc2V0X29mX21v
ZHVsZSkgPj4gUEFHRV9TSElGVDsNCg0KCS8qDQoJICogT25seSB1c2UgdmVyc2lvbiAxIHdoZW4g
cmVxdWlyZWQgKHNpZ3N0cnVjdCA+IDRLQikgZm9yIGJhY2t3YXJkDQoJICogY29tcGF0aWJpbGl0
eSB3aXRoIFAtU0VBTUxEUiB0aGF0IGxhY2tzIHZlcnNpb24gMSBzdXBwb3J0Lg0KCSAqLw0KCXBh
cmFtcy0+dmVyc2lvbiA9IHNpZ19wZ19jbnQgPiAxOw0KCXBhcmFtcy0+c2NlbmFyaW8gPSBTRUFN
TERSX1NDRU5BUklPX1VQREFURTsNCg0KCXB0ciA9IHNpZzsNCglmb3IgKGkgPSAwOyBpIDwgTUlO
KHNpZ19wZ19jbnQsIFNFQU1MRFJfTUFYX05SX1NJR180S0JfUEFHRVMpOyBpKyspIHsNCgkJLyoN
CgkJICogQHNpZyBpcyA0S0ItYWxpZ25lZCwgYnV0IHRoYXQgZG9lcyBub3QgaW1wbHkgUEFHRV9T
SVpFDQoJCSAqIGFsaWdubWVudCB3aGVuIFBBR0VfU0laRSAhPSBTWl80Sy4gQWx3YXlzIGluY2x1
ZGUgdGhlDQoJCSAqIGluLXBhZ2Ugb2Zmc2V0Lg0KCQkgKi8NCgkJcGFyYW1zLT5zaWdzdHJ1Y3Rf
cGFbaV0gPSB2bWFsbG9jX3RvX3BmbihwdHIpIDw8IFBBR0VfU0hJRlQ7DQoJCXB0ciArPSBTWl80
SzsNCgl9DQoNCglwYXJhbXMtPm51bV9tb2R1bGVfcGFnZXMgPSBNSU4obW9kdWxlX3BnX2NudCwg
U0VBTUxEUl9NQVhfTlJfTU9EVUxFXzRLQl9QQUdFUyk7DQoJcHRyID0gbW9kdWxlOw0KCWZvciAo
aSA9IDA7IGkgPCBwYXJhbXMtPm51bV9tb2R1bGVfcGFnZXM7IGkrKykgew0KCQlwYXJhbXMtPm1v
ZF9wYWdlc19wYV9saXN0W2ldID0gdm1hbGxvY190b19wZm4ocHRyKSA8PCBQQUdFX1NISUZUOw0K
CQlwdHIgKz0gU1pfNEs7DQoJfQ0KDQoJcmV0dXJuIHBhcmFtczsNCn0NCg0Kc3RhdGljIHN0cnVj
dCBzZWFtbGRyX3BhcmFtcyAqaW5pdF9zZWFtbGRyX3BhcmFtcyhjb25zdCB1OCAqZGF0YSwgdTMy
IHNpemUpDQp7DQoJY29uc3Qgc3RydWN0IHRkeF9ibG9iICpibG9iOw0KDQoJYmxvYiA9IGdldF9h
bmRfY2hlY2tfYmxvYihkYXRhLCBzaXplKTsNCglpZiAoSVNfRVJSKGJsb2IpKQ0KCQlyZXR1cm4g
RVJSX0NBU1QoYmxvYik7DQoNCglyZXR1cm4gYWxsb2Nfc2VhbWxkcl9wYXJhbXMoYmxvYiwgc2l6
ZSk7DQp9DQo=
