Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B63FBEC2;
	Wed, 29 Jul 2026 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785365715; cv=fail; b=AR87GmfxNO4qMApD++4Yv41K1heyaGUJgODLff9WEQju3sPC2lMOo4al6i/ry6BKV2MVyLwwToIgg2xagOLF1im0g/692Uuh+veXyxzfrPOCa9vU0xeRIaVRLCNn7syrLKJNeLP85o+TQKV0n3HWq8Dce4XTBVYEV6WdzQJcvn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785365715; c=relaxed/simple;
	bh=6lIBW8a+u2yUiPK/0aW1rXK4cPicTIiYCY0rDlt4dJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mA3HHSLIK2MU6KXaZC99VkBEZNuEDULHc2tCgbjKA0im+SSzYTjjKEEXvgk3GepWN8zlRThx6KLvqPBV51Z4c5NF0u3QExAuqQw3j4UcJPr767sAzj5DxixQXf4EX8uExD41dcYAsCRmqnFmrvurGXG1K5CbF1uJlPPxy+jPzFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQQmFLRg; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQQmFLRg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785365713; x=1816901713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6lIBW8a+u2yUiPK/0aW1rXK4cPicTIiYCY0rDlt4dJg=;
  b=WQQmFLRgKC3NL615QPJHnyvGm7F0nK3KqnrvfPbp4AI2luQu3wyJpfRZ
   yI7NjDBt0BPAlYwumSR3S4aRfMpmA3aMF1cIBKn9vRcRrTvWCrBWEXVfG
   dkMcMiJXcA7I63XrJUSl32SOfPWHgQ0QWEieGrQew2u5GiFkZ2p1GWANr
   +kok7uziZ1aJpSj3b28GV76J95ev1hA6qvFeP4cattgdYri2xhzSLgtjg
   L/HtOLAcayl/5gTusnFhpv9/pMCiWVjiVFIFX/fj7KAqq/utH2Vpm+6Yi
   /Z+fwKoqlh3B75gaU3+SMtCiIshPerZ9HW3UcS6P0SMzS7+DPvlZfyYoC
   w==;
X-CSE-ConnectionGUID: ouhYIIfMRmiXASC1p3UAYQ==
X-CSE-MsgGUID: UhCOaBwGToqFM+JqtDzFPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103520167"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103520167"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:55:12 -0700
X-CSE-ConnectionGUID: VPNwDlczSMiuOGyBMqlxFg==
X-CSE-MsgGUID: /Elef4HmSDKH8K8OhgXC9A==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:55:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:55:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 15:55:11 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:55:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE0Dw5/qAK2Pc0gYOhI1YQUAMbYbK03gPDoBJ2eoj2EeA+vLiXvfjlb8SCoEwyAPuUINAnblaoMAfcYmf1YV0AHFR4mmx9t0QNgOFJeEwyOvaKX8FyKfbviLyzgnuedWEvpSsO7AMG0+lQ8FBbhEQUOPLltYJEWMFbHryVuJRInWQnvOFZoTpZBUIcEY+8aF1foOyK9UGi71PVOkjje4DQYV4X3FQwsI+INQRC7bwBkKqBysshAEMFjP5aU3Phl4AGv/4+KDV1L8q/TUtcc611RJ3Vhqd3QiLPjJ2fIheUe57rcU6o+pne9xhdPr57sJImh5nCtHQ9ERhW33t7l3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lIBW8a+u2yUiPK/0aW1rXK4cPicTIiYCY0rDlt4dJg=;
 b=ZG5v3d5s5gnuUnGdaGEmmEDH2Gk0gnaqDmZfqP9hCCGjaxuwmVw7LsEtX5vZYnW4y1cweEkMim1/f3kPqR5A39VP60qI0ZwaX+4corklJZPzAc0zrO+AoukBJmzxW3rkPf7eJJugX0OKazaBW5E2UaaluKNkSSIls6jEZ3ABWKBNdfILfOmSPRZFfB0OqKz2cfUozUNXvTWHs0Cjo6nlTo/0YxYjTjbnQg35wXAjN2wq1Icrgdu4Rl1o1/oAmyk//DQlnXL9/osyADsknlLttS38AIQH/tj6DfeCMS3fNBVTgz4xCoJDmEKGUyxCLFAL4Qa2ynE3ZRA6/SSB5AfcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 22:55:08 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 22:55:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "djbw@kernel.org" <djbw@kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Topic: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Index: AQHc/v34tfo3elz6N0uAdpZoN5jBM7Z8ksGAgAT5AYCAAFmtAIACN0iAgACoJoCAADbhAIAAYOAA
Date: Wed, 29 Jul 2026 22:55:08 +0000
Message-ID: <8474b76a748157de5e95b68209293e4cd47ff57b.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
	 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
	 <cfeee0fe-c61d-447c-86bc-8d8244090879@intel.com>
	 <amdRWaoKa0k324JM@yilunxu-OptiPlex-7050>
	 <7611fe250925614d64f05cac8d398f54ee386583.camel@intel.com>
	 <aml4cVnFkKvmJimj@yilunxu-OptiPlex-7050>
	 <ce4c800ccce210e65aaf8432c0413a342f1765c9.camel@intel.com>
	 <amoziNqNW3lfLJUA@yilunxu-OptiPlex-7050>
In-Reply-To: <amoziNqNW3lfLJUA@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW4PR11MB5776:EE_
x-ms-office365-filtering-correlation-id: 90a7d62e-8c21-41ca-6de1-08deedc4705a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|38070700021|6133799003|3023799007|56012099006|5023799004|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: ewCfyNkAJZH4zKCMpw4IHYEpCc6DTDcDQS/jGsUw6xbYOY1pkfETZ6M0mQ8weX/AZX8Yk0mh2iGYi+xS2mxpyUPdeG7cxb5QDqhHcuQwyXDIblEV2WO7YcZniWf19viLZi+LbUPoBhB9dQ4NoBls3/UtMItzQbyT239/+a6ycOb68QX9Wuxm6EKwrqPQcXqlcAAM0Y4Htv4ELgy6+TyxLGSVOWwQm14i9Vo1NlskAhmXoM1iqJEFsmK20tpqUZwsZFLqA5DwDPc+J7uAV8G9hkn8ChFdh+lkEnJ8cYQBGT3nEJmnIy5w7MpmpDqemd1x16xA7mk6wqj74sz3b6qxyolfdw9blntIwjVzi0UAGn/q9QbrDUAEtwCHpvwanMm/nT+srESQpwYA8HVO7jJIYHBjxwN+/cGB0e/t9MfYK5dZWRSl2LwBmhSxQKIQKtIBicogt5Pa+hK6m0Yj0SjP+K1poSEloKMRnNsTVlc6tT96tdED3oOsm04V8bsPfHq8bchLBtvHfcAZtTF6AOctH0xJ+CWoiPFPRgrVhaLY3QSFhKGf1zjAD7HwlFdVOr3Lbt9pwH+rCG/1lBOQbKxPxN4U/DcVF9eYf1Q69VQ8l6XqTRbVDBbGMpuOODoUDgoCj24t/sRwEhMC7mUQGYvnRfTM0IyTLHUqZNYV08l8Y23CSfexlleWZJwvngPIo8I3BYLIrPDt9HUEa/cbzb+4xOGa5UY1A6DAB6EAg06rT4E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(6133799003)(3023799007)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDM0cXhocGpzajA4bys5OFRnUzFiZk5YVW8wU1dROU8yVEpudmVjV1prM3hZ?=
 =?utf-8?B?MWFIWDlvWnhQY002dFJhNVp1eVJORTV4UUpQRGlGei9zQUs5ZnBVaFJsdzZz?=
 =?utf-8?B?SEMyV0NqUW82V3lETURSVklKNlh6YmEvdEJVUW9veXdId3Y5ak5TVi96aTk0?=
 =?utf-8?B?QmsxK09jeFFLaDNtWW5WcytCQkdoS2I1QzhBTVFPQlNMRjMydVdDN2NIQ21r?=
 =?utf-8?B?dXR4ekRIbVRaU3JRTFQweTVPcWZlZEdvL3JxTkhoVEo5UU5md0g0NW5KTUFK?=
 =?utf-8?B?QXp6YTIvWnQyckgrRFdaYVJtQk4zZllPa1FUMWk3YkRidG4vWnVCWUYyRUlj?=
 =?utf-8?B?MVpuNjFXTkdkYkpXOWdzZEFqRHJ5WnByQThYR1ZhK2h4VUtNc2d5ei94T2hy?=
 =?utf-8?B?dzhrY1NZZWFlaXlxN1ZIcUJUQXM0WXMyeUFhSlVvdkkwK1V6aTdRMlo5K1RG?=
 =?utf-8?B?SU13MEx6clVNdkFmZlBieTFSbk9qeDlpcXRUTkpwdWJEWnhVWllBVzJkaWpG?=
 =?utf-8?B?MG5vQytjcDA0ZWxWeDNXZVBaZ1gzV0g3dXZESC85aUVSYUFqWHlYNzcrVmtY?=
 =?utf-8?B?RkdvWmV1THJUUlNUVDl4L3A5V2pZcjdpRUpPN2NITlJlNm5HYzZWSWNxMFRl?=
 =?utf-8?B?dTdIR3Fqdi85ZUtmTkVlSndKazc5NTdsSjZNekpnc3VWcytFb256NGh5a1oz?=
 =?utf-8?B?UlF5SGJvVUdzWXdPYWN3UGM3czJMNnd1UWwrbHdTcWxodEVEZmhWUVhFd20v?=
 =?utf-8?B?QllyaTdia2hjNXNiNjIrcmkwNkp5SkdDS0w5YklGZ3liMWJUbEowK0taS0xy?=
 =?utf-8?B?THRhZWo1R2drTWttVTFqYU5SSGk1NEh5NUFXNmtVclBHRXVLN1ordUQ0b2FJ?=
 =?utf-8?B?TitiS3N2ZlE2SzdWSVJoMmNDMHB5NWpKeXVvWFhsbklRenFqZ1VnU2tnN04v?=
 =?utf-8?B?WXlGMW52Qm1Rbmt1ZkhBVXFiT0RKVXRHbi80dDZxMEpoZUQ0c3ZFWUsyOTdy?=
 =?utf-8?B?emM4aFhzQ2RaNFh1QXlmSnZ0NGJRMGVHK3FEVjB6cy9ldjM5QWszaHFWL25D?=
 =?utf-8?B?aUJIb2RGdjJGQ1FySVNCMXVPRFF0RCs2Q0YyYkIySlNybkdGdEFVSjJFRmNB?=
 =?utf-8?B?c2pna09GbnNnbW52VVV6azFhOUk0aUdKMkd3U29ZZ2haL0NQdWZEb1pUMGlt?=
 =?utf-8?B?by8wYXFTOGdhakpXT2xUUG5IUmNjeG54dDZNSW5LUDk4czFzTk1UbUl0djhl?=
 =?utf-8?B?Y3hlbCt1aTJuVE9LZGs5am91RVE5T2pRVW9jYkxMZ3VLTWwxeUNCZlllRGl0?=
 =?utf-8?B?QUgzRUFlcDBiMzRkbVl0cisvazROaWJLZXZnajVFNWEySkRYWmFUL291MXQw?=
 =?utf-8?B?WDlPWlFUZEZITlRmN0hLcDJsaEhGVjJEQnBGWEFPVVVQY29wZEJIVGdvUVVN?=
 =?utf-8?B?dUZWdGdxQXRRYUdLV2xzQUhHWXcvbTAzREpwaEF5OFMxUUdSQ2g1bjVhUlZV?=
 =?utf-8?B?dTcyZTBIZ2F6RjArZTdTWG9EUTdDa2tldEJ1bEJSYXRzR2xzQjRjczhJc0ZC?=
 =?utf-8?B?Z2VSZE5KNnVneE1yTVQ4ME5XVk1EU0R3YUxGUU5TZjRNU29PajVwZjcvbzVy?=
 =?utf-8?B?dUEzbWQwckZ6UmdtWkJpR3ArTEZndHZTcHhPNGFGWXVvelErSitXbVRxUnZW?=
 =?utf-8?B?OTFjTjdjYjhwNkdVODJGUFZ6OU4rUUt5SFBHdjkxNnZ2MVhjbGNIYU9iVmY0?=
 =?utf-8?B?T0M5Mm01WFdRNVN5bmVkYjJ5Mm5OL09vSksvS2xCZnY3U0R3a3JuRUc1ajRr?=
 =?utf-8?B?b3orZEk5bFk4WDkyOXQrZllwaHFRZmcwNEhDbGtRK0tvaVV6dE1RTTN3U3Zi?=
 =?utf-8?B?NExRNkZqd2JVT3p1SlJ0d25MblQraXJoQTVKYzE0MllOaE0rOGhNaXdtbUE2?=
 =?utf-8?B?bUtUWGVBNlR0cGZBYk44eHlJUmJqb1REdEJhTE1HNG93SkZ5a2REcW1BbHN3?=
 =?utf-8?B?TkZlSUpJbGhOcS85b2JUVVd0NHdyMDBUd0ZpeFFiZkZvNWErRVcxM3l0S0o3?=
 =?utf-8?B?NzVGUFlLTnhnbHc3MFBKcGF6OStaTTdMc3djVHd2WFRTa0F6NXZXdmNoZExP?=
 =?utf-8?B?SVk1V0FoaTdPOGdhLzdsTGw1UlN2Zk5VMC94eXpTcVp0WkxCOW5BRjJEWkRr?=
 =?utf-8?B?b1ZPR1RZVDkwVytkWk1LNVR6RE9ZVVJ4UFRvaGUwWEljZ21mMXZWTGw2K0py?=
 =?utf-8?B?eThPZ1JpMEliUjArZ1FlQ3JVbnpqYU5Wditvc1JyT0xJSERNVU9ESm0zTUhH?=
 =?utf-8?B?RWZPQjA1M0J2RFBOQ21aT1FVaGtPd3RjOExGSVREM01NT3ZHejlJbUllUUdG?=
 =?utf-8?Q?iUMOo+W9AyNEumUI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <039E30E4E9DE4C42B8064054468B82F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mOdi6xK/7m+ysT4HKNxNk+Xabw/f/T1zCzJZP4YrLv8VVEN2zG73ZcIMZQGgMaPL56BXJfdR/tvCU6RADQ2MSbJpC8Tm0QQ1pMXKCtUxNZ5vD8fc9+hPr+Op9U7J0Y1xM422k98OQVqASroX7Hj4AIeLqvWubdVem4BTK11bORMcbkIf3/7dPZvMTO/hwL4r+M5Pr82VDevwHWVEBeFkWtY+rZ0e96MnAQVU4jzVSrYCF+aqYOzg0eKt7H4b0CEWzfX0g3WudWJbvgKJTc20cpqA4WkgNNs7OGa2lLuCZXtT+3AE/qEnAsB04F+qtuVJuF9bCFDpTeiy/8YezVd/ng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a7d62e-8c21-41ca-6de1-08deedc4705a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 22:55:08.7077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKTizYpefNPz8vc+rB07xRFwn8qgbBcshu8cexgo5isMm6ZgIpSi76sxD9CMg6jt2enF1YWEJlb2SxbVLqTDIK28bsiYFFnyRUcRuzABMeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5776
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA3LTMwIGF0IDAxOjA4ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiA+
IEJ1dCB5ZXMsIGEgYnJpZWYgZXhwbGFpbmF0aW9uIG9mIHdoeSB3ZSBuZWVkIHNwZWNpYWwgaW5p
dGlhbGl6YXRpb24gaXMNCj4gPiA+IGdvb2QgdG8gbWU6IEEgZ2xvYmFsIHNlcnZpY2UgZW52aXJv
bm1lbnQgc2hvdWxkIGJlIGJ1aWx0IHRvIHByb3ZpZGUNCj4gPiA+IHNvbWUgZ2VuZXJhbCBjb250
ZXh0IHN3aXRjaGluZyBtZWNoYW5pc20gaW5zaWRlIFREWCBtb2R1bGUuDQo+ID4gDQo+ID4gV2Fp
dCBhcmUgYWxsIGV4dGVuc2lvbiBzZWFtY2FsbHMgcmVzdW1hYmxlPyBDb3VsZG4ndCB0aGVyZSBi
ZSBvbmUgYXNzb2NpYXRlZA0KPiA+IHdpdGggYW4gZXh0ZW5zaW9uIHRoYXQgaXMgbm90Pw0KPiAN
Cj4gQWxsIGV4dGVuc2lvbiBTRUFNQ0FMTHMgbXVzdCBiZSBwcmVlbXB0aWJsZSBhbmQgcmVzdW1h
YmxlLg0KDQpNeSBtYWluIGlzc3VlIGlzIHRoYXQgSSBkb24ndCBzZWUgd2h5IHRoaXMgbmVlZCB0
byBiZSBkZWNsYXJlZCBpbiBhIHBhdGNoIGNhbGxlZA0KIkRldGVjdCBpZiB0aGUgZXh0ZW5zaW9u
cyBpbml0aWFsaXphdGlvbiBpcyByZXF1aXJlZCIuDQoNCkJ1dCBub3RoaW5nIEkgY2FuIHNlZSBp
biB0aGUgVERYIGRvY3Mgc2F5cyBzb21ldGhpbmcgbGlrZSB0aGUgYWJvdmUuIEl0IG1heSBiZQ0K
dHJ1ZSBmcm9tIHlvdXIgcmVhc29uaW5nLCBidXQgSSBkb24ndCBzZWUgd2hhdCBpcyBnYWluZWQg
YnkgZGVjbGFyaW5nIGl0IGEgaGFyZA0KcnVsZSBlaXRoZXIuDQoNCj4gIElmIGEgU0VBTUNBTEwN
Cj4gZG9lc24ndCBuZWVkIHRoZSBhYmlsaXR5LCBpdCBpcyBub3QgYmFja2VkIGJ5IGFuIGV4dGVu
c2lvbi4gTm90ZSBhbg0KPiBleHRlbnNpb24gbWF5IG9ubHkgc2VydmUgcGFydCBvZiB0aGUgZnVu
Y3Rpb25hbGl0aWVzIG9mIGEgZmVhdHVyZSwgZm9yDQo+IGV4YW1wbGUsIGZvciBURFggQ29ubmVj
dCwgb25seSBTUERNIHJlbGF0ZWQgU0VBTUNBTExzIGFyZSBleHRlbnNpb24NCj4gU0VBTUNBTExz
LCBvdGhlcnMgYXJlIG5vdCBjYXVzZSB0aGV5IGhhdmUgc2hvcnQgb3Igc2ltcGxlIHJvdXRpbmVz
Lg0KPiANCj4gPiBXZSBoYXZlIHNvIGZhciBleHBsYWluZWQgZXh0ZW5zaW9ucyBpbiB0ZXJtcyBv
Zg0KPiA+IHRoZSBURFggbW9kdWxlIG5lZWRpbmcgbW9yZSBtZW1vcnkgZm9yIHRoZSBvcHRpb25h
bCBmZWF0dXJlcy4gU28gImV4dGVuc2lvbiINCj4gPiBwcm9iYWJseSBiZSBpbnRlcnByZXRlZCBh
cyAib3B0aW9uYWwiLCBub3QgYXMgZW5hYmxpbmcgInByZWVtcHRpYmxlIg0KPiA+IHNlYW1jYWxs
cy4NCj4gDQo+IFRoaXMgaXMgYSBsb25nIHN0b3J5IGFuZCBpcyBleHBsYWluZWQgaW4gY292ZXIt
bGV0dGVyLiBUaGUgbmVlZCBmb3IgZXh0cmENCj4gbWVtb3J5IGlzIG9ubHkgYSByZXF1aXJlbWVu
dCB0byBob3N0LCBub3QgdGhlIHB1cnBvc2UgZm9yICJleHRlbnNpb24iLg0KPiANCj4gTm9ybWFs
IFNFQU1DQUxMcyBtb25vcG9saXplIENQVXMgd2hlbiBleGVjdXRpb24uIFRvIHByZXZlbnQgc3Rh
cnZpbmcgdGhlDQo+IGhvc3QsIFNFQU1DQUxMIGRldmVsb3BlcnMgbXVzdCBjb3VudCBpbnN0cnVj
dGlvbnMgYXQgY29tcGlsZSB0aW1lLA0KPiBwcmUtZGVmaW5lIGludGVycnVwdCBjaGVjay1wb2lu
dHMgYW5kIHlpZWxkIHRvIGhvc3QuIFRoaXMgcHJvZ3JhbW1pbmcNCj4gbW9kZSBmb3IgVERYIG1v
ZHVsZSBpcyBzbyBjb21wbGV4IHRoYXQgaXMgaGFyZGx5IHBvc3NpYmxlIHRvIGhhbmRsZQ0KPiBj
b21wbGV4IHRhc2tzLiBBcyBhIHJlc3VsdCwgVERYIG1vZHVsZSBoYWQgdG8gcHVzaCBjb21wbGV4
aXR5IGludG8gdGhlDQo+IGhvc3QsIHN1Y2ggYXMgYnkgZnJhZ21lbnRpbmcgYSBwcm90b2NvbCBz
ZXR1cCBzZXJ2aWNlIGludG8gc2V2ZXJhbA0KPiBwaGFzZXMsIGxldCB0aGUgaG9zdCBtYW5hZ2Ug
dGhlIG92ZXJhbGwgZmxvdyBhbmQgdGhlIFNFQU1DQUxMcyBvbmx5DQo+IGhhbmRsZSB0aGUgc2Vj
dXJlIHBhcnRzIHdoaWNoIGFyZSBzaG9ydCByb3V0aW5lcy4uLsKgIFRoaXMgbWFrZXMgdGhlDQo+
IFNFQU1DQUxMIEFCSXMgdHJpdmlhbCwgbG9zaW5nIHRoZWlyIHNlbWFudGljIG1lYW5pbmdzLiBX
aGlsZSBBTUQgb25seQ0KPiBjYWxscyBhIFRJT19ERVZfQ09OTkVDVCBhbmQgbGV0IGl0cyBjby1w
cm9jZXNzb3IgbWFuYWdlIHRoZSB3aG9sZSB0aGluZy4NCj4gDQo+IEEgcHJlZW1wdGlibGUgU0VB
TUNBTEwgYmVoYXZlcyBsaWtlIGFuIE9TIHRhc2ssIHNvIGEgc3BlY2lmaWMgU0VBTUNBTEwNCj4g
ZGV2ZWxvcGVyIGNvdWxkIGVhc2lseSBoYW5kbGUgYSBjb21wbGV4IHJvdXRpbmUsIHdpdGhvdXQg
Y2FyaW5nIGFib3V0DQo+IHN0YXJ2aW5nIHRoZSBob3N0LiBBIGdlbmVyYWwgdW5kZXJseWluZyBz
ZXJ2aWNlIGVudmlyb25tZW50IGlzIHRha2luZw0KPiBjYXJlIG9mIHRoZSBoYXJkd2FyZSBpbnRl
cnJ1cHQgcmVzcG9uc2UsIHRoZSBjb250ZXh0IHN3aXRjaC4uLg0KPiANCj4gU28gSU1ITyBhIG5v
cm1hbCBTRUFNQ0FMTCBtYXkgYmUgY2FsbGVkICdyZXN1bWFibGUnIHRvIHNvbWUgZXh0ZW50LCBi
dXQNCj4gaXQgaXMgZGVmaW5pdGVseSBub3QgJ3ByZWVtcHRpYmxlJywgaXQgdm9sdW50YXJpbHkg
eWllbGRzLg0KDQpObywgc29tZSBjaGVjayBmb3IgcGVuZGluZyBpbnRlcnJ1cHRzIGFuZCBleGl0
IGJhY2sgdG8gdGhlIGhvc3QgaWYgaXQgc2VlcyBvbmUuDQpUaGV5IHNhdmUgdGhlaXIgcHJvZ3Jl
c3MgbWFudWFsbHkgYW5kIExpbnV4IHJlbGllcyBvbiB0aGlzLiBTbyBpdCdzIHRoZSBzYW1lDQpm
cm9tIHRoZSBob3N0IHBlcnNwZWN0aXZlLiBQcmUtZW1wdGVkLCBzYXZlIHN0YXRlLCByZXN1bWUg
d2hlcmUgeW91IGxlZnQgb2ZmLg0KDQo+ICBUaGF0J3MgYWxzbw0KPiB3aHkgSSB0aGluayAicHJl
ZW1wdGlibGUgU0VBTUNBTExzIiBuYXR1YWxseSBleHBsYWluIHRoaW5ncyB0aGFuDQo+ICJleHRl
bnNpb24gU0VBTUNBTExzIg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gPiAtLS0tODwtLS0tDQo+ID4g
PiANCj4gPiA+IMKgIFREWCBhZGRzIGEgbmV3IGNsYXNzIG9mIFNFQU1DQUxMcyB3aGljaCBhcmUg
cHJlZW1wdGlibGUgYW5kIGNhbg0KPiA+ID4gY29vcGVyYXRlDQo+ID4gPiDCoCB3aXRoIHRoZSBo
b3N0IHNjaGVkdWxpbmcuwqANCj4gPiANCj4gPiBCdXQgdGhlc2UgYXJlIG5vdCBuZXcgaXMgdGhl
IHBvaW50LiBMb29rIGZvciBURFhfSU5URVJSVVBURURfUkVTVU1BQkxFIGluDQo+ID4gTGludXgN
Cj4gPiBhbmQgVERYIHNvdXJjZS4NCj4gDQo+IEZyb20gaG9zdCBwZXJzcGVjdGl2ZSwgZXh0ZW5z
aW9uIFNFQU1DQUxMcyBhcmUganVzdCBsaWtlIG5vcm1hbA0KPiAncmVzdW1hYmxlJyBTRUFNQ0FM
THMuIEJ1dCB0aGUgbWVjaGFuaXNtIGlzIG5ldywgYW5kIHdlIGhhdmUgdG8gZXhwbGFpbg0KPiB0
aGUgZGlmZmVyZW5jZXMsIG90aGVyd2lzZSB0aGVyZSBpcyBubyBqdXN0aWZpY2F0aW9uIHdoeSB3
ZSBpbnRyb2R1Y2UNCj4gdGhlIGV4dGVuc2lvbnMuDQoNClN1cmUuIFBlb3BsZSBhcmUgbm90IHNh
eWluZyB0byBza2lwIGV4cGxhaW5pbmcgd2hhdCBpcyBuZXcuIFBlb3BsZSBhcmUgc2F5aW5nDQp0
aGF0IHdoYXQgeW91IGFyZSBzYXlpbmcgaXMgbmV3IChwcmUtZW1wdGlibGUsIHJlc3VtYWJsZSks
IGlzbid0IG5ldy4NCg0KPiANCj4gPiANCj4gPiA+IFNvbWUgZmVhdHVyZXMgbGlrZSBURElTUCwg
RElDRS1iYXNlZCBxdW90aW5nDQo+ID4gPiDCoCByZWx5IG9uIHRoZXNlIHByZWVtcHRpYmxlIFNF
QU1DQUxMcyB0byBpbXBsZW1lbnQgaGlnaGVyIG9yZGVyIHNlY3VyaXR5DQo+ID4gPiDCoCBwcm90
b2NvbHMgd2l0aCBzaW1wbGUgQUJJcy4gVG8gZW5hYmxlIHByZWVtcHRpYmxlIFNFQU1DQUxMcywg
YSBnbG9iYWwNCj4gPiA+IMKgIHNlcnZpY2UgZW52aXJvbm1lbnQsIGNhbGxlZCBURFggbW9kdWxl
IGV4dGVuc2lvbnMsIG11c3QgZmlyc3QgYmUNCj4gPiA+IMKgIGluaXRpYWxpemVkLg0KPiA+IA0K
PiA+IFdoeSBhcmUgd2UgZXZlbiB0YWxraW5nIGFib3V0IHRoaXMgaW4gYSBwYXRjaCB0aGF0IHJl
YWRzIHRoZSBtZXRhZGF0YS4gSXMgaXQNCj4gPiBuZWNlc3Nhcnk/DQo+IA0KPiBPSywgSSBjYW4g
ZHJvcCB0aGUgaW50cm9kdWN0aW9uIG9mIHRoZSBjb250ZXh0IGhlcmUsIGl0IGlzIG5vdA0KPiBu
ZWNlc3NhcnkuIFRoZSBjb3Zlci1sZXR0ZXIgaGFzIHRoZSBkZXRhaWxlZCBleHBsYW5hdGlvbi4N
Cj4gDQo+IEJ1dCBzaG91bGQgd2Ugc3RpbGwgYWRkIHRoZSBpbnRyb2R1Y3Rpb24gaW4gcGF0Y2gg
NSAoIng4Ni92aXJ0L3RkeDogTWFrZQ0KPiBURFggbW9kdWxlIGluaXRpYWxpemUgdGhlIGV4dGVu
c2lvbnMiKT8NCg0KTWF5YmUgaXQgZml0cyBiZXR0ZXIgaW4gcGF0Y2ggNCwgYmVjYXVzZSBpdCBp
cyBhZGRpbmcgbWVtb3J5IHRvIHNhdmUgdGhlIHN0YXRlLg0KQnV0IEkgdGhpbmsgd2Ugc2hvdWxk
bid0IGR3ZWxsIHRvbyBtdWNoIG9uIHRoZSBpbnRlcm5hbCBkZXRhaWxzIGFsbCBvdmVyIHRoZQ0K
bG9ncy4NCg0KSSB0aGluayBpdCdzIGdvb2QgY29udGV4dCB0byBoZWxwIHJlYXNvbiBhYm91dCB3
aGF0IGlzIGdvaW5nIG9uLiBCdXQgdGhlDQppbXBvcnRhbnQgcGFydHMgYXJlIHRoYXQgdGhlc2Ug
ZXh0ZW5zaW9ucyBhcmUgb3B0aW9uYWwgYW5kIG5lZWQgbW9yZSBtZW1vcnkgdG8NCnNhdmUgc3Rh
dGUgZm9yIHRoZWlyIGludGVycnVwdGlibGUgcmVzdW1hYmxlIG9wZXJhdGlvbnMuDQoNCg==
