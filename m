Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DCD3546CB;
	Mon, 27 Jul 2026 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177060; cv=fail; b=dzL5JI8gkPMnH6MOfWaeQVxTBCBLDPolqHDOvY2eIKdHKzsldhcCPkhzctk9ikgVrnCtYQaEqlhbO007KAH/C2zcYJQGEG3BlQ1GWHKyCzF1Zncho2Zg5OSvBYBVyZtkKOdTyarAHCeZ5y1zogT8cRn6rce/i8wu3P8kqsJ5/WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177060; c=relaxed/simple;
	bh=VWV/5IFi8VVNEYmaoOoYuZWra281rAgDZNlTvET/AY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R6hEtjv/yaoTstu076rNYm6ZtC2qZNdDq2iWdpVMe37yMlWVP9oEclT28I/cCRucNsI725TyLRyjsRpGLv3TWZjzYVevjrKWxX67nuallB4A5OP+G0AOkJxvPv7j3C+RdgkJAUJY09JI4qAJkiMiY2VbPWsGG06rr37aGop4nJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNPqiCHn; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNPqiCHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785177057; x=1816713057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VWV/5IFi8VVNEYmaoOoYuZWra281rAgDZNlTvET/AY4=;
  b=fNPqiCHnAHAZDL8tuatCA+FhIo+/qw7K5PtEpSqsKJvaaiq8SHq9KIuN
   fQ3hCO+M0CLQEJw6Wa/FUvLp2gNm7Nk3Bn1M66iVdV3lWKU3N/fj3ts+s
   4uq/PhnjrNSXZNDu7mCa0EIFXLaKrjrGUdL9fwtCViuC4N25gJ3Bmat4N
   HlaHQNmMqH7mIjSljm+2S3+S3XJcz9Bqyqc36KDQMVjChgMAbf0y4MTsD
   Z4fH6QhzgLvXWuaK4MwCpUB0Y46NmoFE87P3fLDy9g2EeDtvQkyBZjiwu
   kfYXuRY1GtFYwV9HfQJxm/Pl72TkOPt2G4RL3kQcbNg7Ujp257vU9FrRH
   g==;
X-CSE-ConnectionGUID: 4nKjbI9/RJCEMGd329jNaw==
X-CSE-MsgGUID: m/0gTF2MRXah2HR00H+uAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89573110"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="89573110"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 11:30:55 -0700
X-CSE-ConnectionGUID: J8DnHW2YRD+zYAOD/bK2AQ==
X-CSE-MsgGUID: szofXihfSTCBzZvIDc/JaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="284013939"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 11:30:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 11:30:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 11:30:54 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 11:30:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZIhqR85weB6NdJ021H7WI9Ek55wU19VzoL9hL1JGb/RcO81gBqSkeaXmTat4VQbCG5gMjlSMajxGK521yb8QA9IuWBTrYXY9cIIL+q4zaA3VTr8NaI8u48kHRZCWLOp0vV79FcHGfKvj/UqjshIqHpaHB9hVKnhYrg+Ur1iwuGHK3NBmr20kPaIwcXhSV9bE0B793V45S3Uos55DH3pIzgn7wQzdv5iAIktb+2R416ruwDdBTSrMp1QPhcGayhHNsN21ykrBZpWkgIOFyJFg62DO2ym8LZqcIkVwFr471+Os7cKPDBpdfAv/LBvvYjdZt9SdZcdqnt/82bKZYcZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWV/5IFi8VVNEYmaoOoYuZWra281rAgDZNlTvET/AY4=;
 b=PFL2NCEKwLlDaNzUPFsMztapnTKiXTnRhzSU90zkhee6iFv72joroVwQxoSN7uTy/Tw5cK/BGkidxs0HZiDgsei0Ef/UZRmFhYnMLabeUdMwCdDJ3njH740rhuUP+8uy59GBJsDyhJAQ5r/bqDeuS6lUDyfvLvRIfdng4s3zzQZtj2CrgKb/0+YsX4NxvWpqFllSPZCWFROODSZTqbvyOGrqa/Bwb8T0tJJYhq+atJ1mqAHPluXENGsfrWZXV5kKJuNOaiRwKBSkYynw8xAfYrZ2TMpUA8m2iNLdavNlmtbRShgWNMS7zSznv04NKZo8xnMqzOHLtGAFavjOYdqx0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7214.namprd11.prod.outlook.com (2603:10b6:8:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 18:30:48 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 18:30:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "Fang, Peter"
	<peter.fang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v2 05/17] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Topic: [PATCH v2 05/17] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Index: AQHc/v36g1L+ufGXX0q4hjYY/UOH/raB7wOA
Date: Mon, 27 Jul 2026 18:30:48 +0000
Message-ID: <3fe95102b8b76b16fb21cba2c042604b6e06bfa4.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
	 <20260618081355.3253581-6-yilun.xu@linux.intel.com>
In-Reply-To: <20260618081355.3253581-6-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7214:EE_
x-ms-office365-filtering-correlation-id: 4f798d9b-fe64-4473-0198-08deec0d2de1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|4143699003|22082099003|18002099003|10067099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: /kFqzPlkUz6ek28jnyYohy0RPePmElJJ6ue1TVksjXYi72wi19s77b/O2NGfQyO/IGOxwwk/YirSq/4FqMe+4rEVeFUL+COzyYEy45OqOcBOny4gEMXVrjv/VESvJ//f8F2FhbCr8K7zvPtlvg3oj2GEm5Mtg6vJM5Zt6dSqx6jEMMq7RPxC7IFSPGSZo0Icmn9pi+GwqQL0M2bj09ljZKBfLWJE0AtYtVJwe2xIyFLJK5U0IuCp4EsZXGaxswzPwhSoHAGtP8JwgadiZj9cNgEgxcWOa0qculWPt9igBko2B48J+DWgutpjkJrT1FElaGclWTZBgbVo5nBURJB524Ci0Ws8hW1gCKEeHnAHyCyhmwiE0y6hz6oM3xm45dqiW5PHOE3pbSbae79fYenBadj3C0tIlrV5hIT75t8qNh4JlA9lhB0LMYFlHkv/UU0YCVEYG9gvi0AcqLIQ9mTen+Lbsxu0+I3YxksnAVAWQnB2vAQ57lByzKhSvXkiJ8JAfI23erX6WyJjU3mVZdBHqppRmT9d1jC/Gyd2PUQryGoZMnQ9G9ZPYUXuQ9QUCRvqKo+KuOmYCm9OJer99KMs/CjoZMaexjOrOu17Yvxrni/nR6Qlg5sdRrFRCiDDkxGYNX+Vsb+h0tj40uYoc7eemFo27AfUX3IzJKh0Rw6x83kEhMJzB2WCr2L04l1b5CnP8Rxm2X4jUnCcBBk2+TnjwBNxuL1BKe+qQK1Bc6m4YcE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(4143699003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVhSYnlxOFc4UHlTamRNdDNMajhQbHN2aVRnVXE5SHZ3QTRwV0FpendhejQz?=
 =?utf-8?B?Y0F6d1ZINmdGelgwdUVFV3lsTlgra1ptdDJ0bERya0xLK1M1Zi9GVTVBL096?=
 =?utf-8?B?OEhnbGhNS0VSOU0yMzdTZXY3N3B4eXNUOXhEeEJJc0UwNUF0dE1RQ3NNNXZG?=
 =?utf-8?B?bG5ZSVBwanhMb2xyUmRIeWdjZDhxdDY1OFNhdXVxajFSNUU3QVh0TGlocDM4?=
 =?utf-8?B?WmNEWHNjcFg1Q2V1ZHJrenNSVC9EWVZEbjB0blJoNWh0cDIvaGZCRWpzN2wr?=
 =?utf-8?B?eTFWcEliaE5xckh6ekRORk9hQ2hVZzlFbkg1eDJPRnE1MHpPeWhTZ3FRYmFR?=
 =?utf-8?B?U1E0OXJ6dEhzdnp4OWQ2UmRqRDhEY3dwdUZCMWl2YUxkaDBUcnNLSUMzMU9j?=
 =?utf-8?B?d085ZC9LYmFZY0pwVUNOSVp1cHZxTzE4L3dvYU5ycUJOdW1lcmJUMDdiWDRD?=
 =?utf-8?B?LzYxbFFFY29JZlJPQ3ZpbnROWEFBUlN1Qm5CVjNSZHk1MHhuVEFvRmM5WEtG?=
 =?utf-8?B?cnM3azFoVE5NZkVhTEw5V1RZRG1wYStscURtc0VYNlZCVzgwNk9Pd0hMdVBK?=
 =?utf-8?B?Y3Q1TENQOE1iWmZVcExoOEN3ekpJa2ZPQ3U0eXZ0cmdKQUtWWStDbDVHMVVE?=
 =?utf-8?B?YWhnNVl2THRaVTFVNndGUDlpQ3pmZ3ZVdm52dDBzMG8zT2phbml3YWxIZE04?=
 =?utf-8?B?Vi9yclduRXJMR0c5V0loUURyN3BQSSt6NEhxcnZST2U4Q0RFU3FmVDlFaDZV?=
 =?utf-8?B?aTUxM1pPMFF0OHFHMDIxdmJpQjkrZ2lob1V1U3dsU1ZXRDU4TmpEK0t2Umo4?=
 =?utf-8?B?aGpGZ0d5SFdSdXpZUlk4RjFXeEdIc3MxbjZ6RE9wQzFzdkt4d001WmtDZjUx?=
 =?utf-8?B?UXhOMFJTWjI2THk5SUxBRzAzamFXTGVYb1dRZjBtb0Z0ZFc0WUViUlBycDFa?=
 =?utf-8?B?RXFFVE4raXBjeW9qSmIzd3J4T3ZqMG14Nzd4SnZYalVCcjlOampaVTFBZTZs?=
 =?utf-8?B?WWZ5RTBmK2JHMldhRG40V0N1SzN5RnJUTEsyLzdEOHA4SVgzeEdnL3lGTWw3?=
 =?utf-8?B?OE1TSVZJZGJKeTFHSGtGbUFUTEZnRTNRTnhpaUx6dU5LUHljMXUvVTgvMXpz?=
 =?utf-8?B?NmliT2tBYUJIOENhazNZNUdmTStnWkU4K1dxWDRZK3JqVmJQQUh1T3hrVnBD?=
 =?utf-8?B?Q0F6eEwwSnJhWkRiUGpjcG8wbkIyNDRsTTZ2VTQrL0RybXJJWTlQNjA5ckIr?=
 =?utf-8?B?eFdiQ1lVajJ6cU0yTVk4YVFFemgvLzBEU2pvVXBhV2Q4QWtwWVNIT2RKWGVW?=
 =?utf-8?B?R0l4SDMwQmtyWHRGdWw5SDZkS0xNRzBmMVVjc1F4TFh5OVNYYXJVaExDTVQy?=
 =?utf-8?B?Um1vWmVXZ1YrdEtxNlAzVm9CRU1sdnJsc2tGc2RpRFNURlRIdTZFemNNTDM4?=
 =?utf-8?B?LzRvTHBOZ09XQzViNytQV3p2MUhUZ2s0R3BzQWRYOUZ3R2V2V3RvR2F6Ylcz?=
 =?utf-8?B?ZEFMelJEV25DSlppOHpEMEtVK2JwWk80all0YVdZWjRTL2VsaEJqaTZ2QWRq?=
 =?utf-8?B?YUdFSCs5SFVKeGZubWd0NWVSRVFlMGhkY3BxRVlTVFk3b1MwMHphOVBBMzZu?=
 =?utf-8?B?RFdQeWVhWk5UNlB0S3RKUDhaMUFPek1Yb0t1a01WSC84RU53YkRsWWJuZVhF?=
 =?utf-8?B?QjAycjduZHhQcDRZcE1FeDJZTUFTV2FSRC9MZ1ZqRXpzTVZucklLd0ZPNEpw?=
 =?utf-8?B?TmFTSUZoL1dHa1k3K1NLZ0NSQThISFcrTGZRM1BLRzIxMVRuS2lTY3B6c3py?=
 =?utf-8?B?OWIrTDF0Qk1RYXJHclZmNjNnaER5RmtYVFJrQUNubFB3YVpwYVFpc21tSGZ4?=
 =?utf-8?B?MGFzRDJsUVZJaVRSb2FuajQyYlN1NjVUbkhkdEQ4ZHJjUFVaTlgveWMweEFY?=
 =?utf-8?B?ZGFycFlBbkZqeWRsck84UWRYeGgvb3ExQ3lNOHBhRk1lcXg5Q1NVaFZ5UzFO?=
 =?utf-8?B?dlBFSk8yREx1Z0tZeko3Z25HMlZTT0hnVEl5engzSjdHREpCQzdTLzBRRWlS?=
 =?utf-8?B?b0txdVZmUlIwZjZzS2dRNUQzNDBuK2F4d1JsMWd6dTk5N01NSjlyOTBqaG1K?=
 =?utf-8?B?eWJRbUNFa0txc2UyQjlwSGVrNVRxR1NjdkRZc0doSXN0UVpRNlArOTNBTFFk?=
 =?utf-8?B?NE14NVJ2dGp0QkNVSmFiK1lhbC9uKzcza3EyVGdrejRCMXdiU1hqSGZXWmZm?=
 =?utf-8?B?OXpvVW41QWVWM0R6SzR4aEVSTmpPMEpLUFAwRUQ1SE9HZnpTeHphdFUwQXQy?=
 =?utf-8?B?QldaUTRGcCtYakk2TG5xNzZqdHRHSkVNWUNSaHNSMStYVTJlMm1hOEUvODgy?=
 =?utf-8?Q?hP5knuUMfd5mjHPM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <446C815E7936F540807A663AD54B2BE3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aSIb9sNtnPSh/2o2dzVViBTKVONx8a+lH05GfPOfm4h+qKxSGMPbb3idy0Lxy680SiS9Qgg/Y6c+2RnOTbi/bFRKCHAsg1NaCuNC3s2Ft/KBnTnmWPdaZgLJWiYzlcySeWHxU7kr/wkbCRJ/2H+OiD/oktsvpVEVTQdJW7SZhNc76BOEuQXRw/XXMs3rhkBf+t4JIfFoGqp+uimCIDs3Dydh2od9l2BHWtX0rveMLnvHGKydEoqbrTDN3OQ3kIe+PoIY2ZCkuUmbbf4b8aVgagnqN7NzB/kwOoZvuDyg5BS5GX1BMHFNpUcX507rqOuX3ItDGUEamIfCElUBkeHumQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f798d9b-fe64-4473-0198-08deec0d2de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 18:30:48.1087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvbiWNdss7zWYn57yqWkzwWi5RPk/o9qi5uRt9nJlybqwtN8/FUnpSXHLQNQnERprpb0IdgL8sx0KvB/wEnshOoUAD5NY5/x90qBDrxC3KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7214
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTE4IGF0IDE2OjEzICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gQWZ0
ZXIgcHJvdmlkaW5nIGFsbCByZXF1aXJlZCBtZW1vcnkgdG8gVERYIG1vZHVsZSwgaW5pdGlhbGl6
ZSBURFgNCj4gbW9kdWxlIGV4dGVuc2lvbnMgdmlhIFRESC5FWFQuSU5JVCwgc28gZXh0ZW5zaW9u
IFNFQU1DQUxMcyBjYW4gYmUgdXNlZC4NCg0KUHJldHR5IHRoaW4uIE1heWJlIHNvbWUgaW5mbyB0
aGF0IGl0IGlzIChhcHBhcmVudGx5KSBhIGdsb2JhbCBpbml0LiBQcm9iYWJseQ0Kc29tZSB2ZXJ5
IHNob3J0IGJhY2tncm91bmQgb24gd2hhdCBleHRlbnNpb25zIGFyZSBleHRlbnNpb24gc2VhbWNh
bGxzIGFyZS4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGxpbnV4
LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFhpYW95YW8gTGkgPHhpYW95YW8ubGlAaW50ZWwu
Y29tPg0KPiBSZXZpZXdlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueS5saW5kZ3JlbkBsaW51eC5p
bnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGlu
dGVsLmNvbT4NCj4gLS0tDQo+IMKgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5oIHzCoCAxICsN
Cj4gwqBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgfCAyMiArKysrKysrKysrKysrKysrKysr
KystDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5oIGIvYXJjaC94
ODYvdmlydC92bXgvdGR4L3RkeC5oDQo+IGluZGV4IGExMDA2MzQwODdlNy4uMmRlYjBhNWM5MDJl
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmgNCj4gKysrIGIvYXJj
aC94ODYvdmlydC92bXgvdGR4L3RkeC5oDQo+IEBAIC02Myw2ICs2Myw3IEBADQo+IMKgI2RlZmlu
ZSBUREhfU1lTX1NIVVRET1dOCQk1Mg0KPiDCoCNkZWZpbmUgVERIX1NZU19VUERBVEVfVjAJCTUz
DQo+IMKgI2RlZmluZSBUREhfU1lTX1VQREFURQkJCVNFQU1DQUxMX0xFQUZfVkVSKFRESF9TWVNf
VVBEQVRFX1YwLA0KPiAxKQ0KPiArI2RlZmluZSBUREhfRVhUX0lOSVQJCQk2MA0KPiDCoCNkZWZp
bmUgVERIX0VYVF9NRU1fQURECQkJNjENCj4gwqAjZGVmaW5lIFRESF9TWVNfRElTQUJMRQkJCTY5
DQo+IMKgDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9hcmNo
L3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gaW5kZXggZGFiMTc4MjJjMWM2Li45MDA5MjhkZTM3
M2EgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiArKysgYi9h
cmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gQEAgLTExNjcsNiArMTE2NywyMiBAQCBzdGF0
aWMgX19pbml0IGludCBpbml0X3RkbXJzKHN0cnVjdCB0ZG1yX2luZm9fbGlzdA0KPiAqdGRtcl9s
aXN0KQ0KPiDCoAlyZXR1cm4gMDsNCj4gwqB9DQo+IMKgDQo+ICsvKiBJbml0aWFsaXplIFREWCBt
b2R1bGUgZXh0ZW5zaW9ucyBmb3IgZXh0ZW5zaW9uIFNFQU1DQUxMcyAqLw0KPiArc3RhdGljIF9f
aW5pdCBpbnQgdGR4X2V4dF9pbml0KHZvaWQpDQo+ICt7DQo+ICsJc3RydWN0IHRkeF9tb2R1bGVf
YXJncyBhcmdzID0ge307DQo+ICsJdTY0IHI7DQo+ICsNCj4gKwlkbyB7DQo+ICsJCXIgPSBzZWFt
Y2FsbChUREhfRVhUX0lOSVQsICZhcmdzKTsNCj4gKwl9IHdoaWxlIChyID09IFREWF9JTlRFUlJV
UFRFRF9SRVNVTUFCTEUpOw0KPiArDQo+ICsJaWYgKHIgIT0gVERYX1NVQ0NFU1MpDQo+ICsJCXJl
dHVybiAtRUZBVUxUOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gwqAjZGVmaW5l
IEhQQV9MSVNUX0lORk9fRklSU1RfRU5UUlkJR0VOTUFTS19VNjQoMTEsIDMpDQo+IMKgI2RlZmlu
ZSBIUEFfTElTVF9JTkZPX1BGTgkJR0VOTUFTS19VNjQoNTEsIDEyKQ0KPiDCoCNkZWZpbmUgSFBB
X0xJU1RfSU5GT19MQVNUX0VOVFJZCUdFTk1BU0tfVTY0KDYzLCA1NSkNCj4gQEAgLTEyODUsNyAr
MTMwMSwxMSBAQCBzdGF0aWMgX19pbml0IGludCBpbml0X3RkeF9tb2R1bGVfZXh0ZW5zaW9ucyh2
b2lkKQ0KPiDCoAlpZiAoIXN5c2luZm9fZXh0LmV4dF9yZXF1aXJlZCkNCj4gwqAJCXJldHVybiAw
Ow0KPiDCoA0KPiAtCXJldHVybiB0ZHhfZXh0X21lbV9zZXR1cChzeXNpbmZvX2V4dC5tZW1vcnlf
cG9vbF9yZXF1aXJlZF9wYWdlcyk7DQo+ICsJcmV0ID0gdGR4X2V4dF9tZW1fc2V0dXAoc3lzaW5m
b19leHQubWVtb3J5X3Bvb2xfcmVxdWlyZWRfcGFnZXMpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJl
dHVybiByZXQ7DQo+ICsNCj4gKwlyZXR1cm4gdGR4X2V4dF9pbml0KCk7DQo+IMKgfQ0KPiDCoA0K
PiDCoHN0YXRpYyBfX2luaXQgaW50IGluaXRfdGR4X21vZHVsZSh2b2lkKQ0KDQo=
