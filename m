Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5225935E1A4;
	Thu,  1 Oct 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814609; cv=fail; b=hxpXMUdhaYMBGBJgkFk47lupH+pXbaT+86XkVtAbd5Tgk5NO8mEvetGNP55ExygzT7NZdEJgy6i8yvN8tQ2EpJv6naAOkBZ++Xj+0wTs3a+aBfWj9X3XcvBBNr2JUcBCjCJ2CIXLZipIF4b/PG+3aOlNtTht7naOy/gNhcqR0rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814609; c=relaxed/simple;
	bh=6L87wn/xClrotUHU3hVW2N4Nptd7ze0NZnnBaVtGVxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P4abw3ZjmHvT8VF6rEc6Qb9TaWyGjnKTPhA3mjQUTRrZYd4PQvEsLtb+J63KOHnoiauav0MPf1z3vz+g6MomvU/O8SnSadyx/KaH4WlDJ/oPrNcCXqN94/bTSSwmvLPFs20wrNuGkzqGIzsHcrd59VeKU1tEBhe8/3qy5wbOb2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GChAe6JV; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GChAe6JV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790814608; x=1822350608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6L87wn/xClrotUHU3hVW2N4Nptd7ze0NZnnBaVtGVxE=;
  b=GChAe6JVtklu8/dufkOySoLyyjW/ZltET9pXrqJn6QYuCcKxejqmn7a/
   VDyNh2woEPLptO9HWh0AGacOvOQRTI+nEOi40BvOItVULPvSEvKBHL3Vj
   C3K60y6MpGP+1T/uLmAAlJpx6XqmQqcF4PVziIPph5uo0YeztrfImgJfH
   5VmphpLh7QjkfPrd9HgkdaDVv0CNyhnFsmM2HTv1iFQIUOKvItS6aXWb9
   b/tSbePbJ2EdE809/K6fK+iCTjY7iu0BTthiiknxmc3Sz8sPx4/cCmzdR
   XFFopDo+BCcBV3dCx8lAypvMGkq/rfmTGr+wijDAYQjGS+Ocekoufzdmp
   Q==;
X-CSE-ConnectionGUID: dy1m1YLuTn6l/I74z3Houg==
X-CSE-MsgGUID: lAlJPMriSZ25d0kB0ITGlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="100897898"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="100897898"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:30:01 -0700
X-CSE-ConnectionGUID: u2Kd4ZZGQOGW5TFil1vfJg==
X-CSE-MsgGUID: 5WuG1n15SsKXZLzZfM+aPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="274455480"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:29:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 17:29:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 17:29:59 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 17:29:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3RyR68HSELBCzyEvOtJyaE0nnvLfs46IQg4oNnDkEwpPbCelrwICdqDRtWnELNWCK0OHWD9iZCDzoIm6fM/zZ+LEziJ+F02L9CnH7nnFx6Ohx5DglFVdbfS6jNa8ufPha29XkFhVeSKEt4aD5kv9ftLhe/tnrSvDHmKdr2eZI7/TiPVBlA+qvWRb0vFamt+2KiX8t+ok9wDsToG//ZgWVN4kRAUIqenaqmrSWm+yTZDQwswE1iNCvAjPtEtpcfLUZqr9+40fnSg/akiDTmITrKLfL5/6NYtp1Z/3KBkg8WuFhvwm4AwZM1PATwWqiG0ECoc88t7t/RZN0PMC0nuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6L87wn/xClrotUHU3hVW2N4Nptd7ze0NZnnBaVtGVxE=;
 b=nwVqbApTuWRmOdiSNrDcgNaJJeZGksJY3GoHnM6f2ffAmD1GfgU3u9Y82dnavLTlEunz7vEYqsKDr8+4YaBnyB3esdZoJEZhhMd4AAGGfnimuYJInsmVMPnvr0t9cOQvdTMPYAED3rmNz8H4/1Yx90XBy4xVyzAMzArHZrC+lWT9boBlTU0nN6sU10s7EYlF8Kp1EdjWkKN5L+pYcrLy9/7kL0K79jFB2AmoO7s2vmM4LDeNyIVnVHvea0dhdQNn/BayeyhYpXzqGztovYXnnwb52CxQUMaYE34JWig+ZUp4xpFIjEz/sKdAk1iRKTfd4LyS3CEm6pjEVL7RgwwOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 00:29:54 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 00:29:53 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 10/10] x86/virt/tdx: Verify structure member sizes
 against metadata field IDs
Thread-Topic: [PATCH v3 10/10] x86/virt/tdx: Verify structure member sizes
 against metadata field IDs
Thread-Index: AQHdUJ5RkSO2mATLuUG7cLVP2anF1bbn1rYA
Date: Thu, 1 Oct 2026 00:29:53 +0000
Message-ID: <a96b1ed40648cf049ef374bc57c314e29ee133f6.camel@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
	 <20260930053901.22528-11-chao.gao@intel.com>
In-Reply-To: <20260930053901.22528-11-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB6736:EE_
x-ms-office365-filtering-correlation-id: d9512f05-70df-4b16-1e25-08df1f531cc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|56012099006|5023799004|3023799007|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: yITA2mzC6ph5yLd1+TAdW70rj0+pKcyzDMGlaAbkY4KmYrt2/CXf2wTu2ruiYbmJYK9zeY23WaSHaWCfN9qEQrSLUj8fRaRg0OhPO/l0YW4FB0F4awJairKsNdnTrSKMncFfzty8sVtvrDyDXjGB1FvgCY09Ef6Z5ClUN0/hYipt3LNahvOHMZSvt2KuGk5px6V98p8ckNZrcl4jyUkJmgPbUNk2tJUlB5XHRjvM/l9b7bdiB/kxruU+QX0CzKNxeehsyHlV93Yg/ZyjyG7JTo6VVE/7Sbhle7OO8Nr4osDifoqhzlXYPH7icHParVPn9w10KvUDG/cX8vZlKVTutTWFBtanHt7yorb/6WeuAhd2B0pDQm6pnDR9EEMh1XjjZYcIASM/vUjI+/uBiwjiw7GXD2sYM/hGQWy5hkiZN2/GnSGd6uoV+PHS5cO8rrc2rZPNeDAslHT14uNxTpDsUh26rmrFGPRPWeHV/A3q7xuaWyeTO6qGxJED6RgwSVJIxwrKdjKxm7Yp3ToQn4Co6/gzH/VCDoinGYy69pN2lSzUWkYp2XjLz8qv7p8sNhIYMaPz3Ykqtxe9a9vZonX+n8HzyTy/FIZKAwWucJSyWF6wl0u8SzcSFBncna3AwAzf6KBWDn+HzFnjEZkByvGlGiRBG0qwMrk2GAAwsF0uk/pOknszePOyGE5u0LQ6UNPGYGFPZt1Coyd/C4/4zS4J9l7LlAyobqTA5d2gwofelzA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(5023799004)(3023799007)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWRRTGMwN2V2ZmVsdko4Ukl5TDkwMFlGSkszOUs1WUFEdm9DYkJMVXRqamdJ?=
 =?utf-8?B?elJZVmhpb1hZeTZuc1pIMzYrMGQ4TzZDQm1rUnUxc1o0WkVjaXVLWElDR0Zu?=
 =?utf-8?B?K0RReFRNQnRCL3llM2lSQzhzSWloYVpKaDBFUTU2dFZRTDcwdkRVdmpHQUpm?=
 =?utf-8?B?TC9HTUNSUUJCWEhDUExSQXhwcEFPbjFMYVp3UTBRRWh2V3VyWW9JZGZWNGZR?=
 =?utf-8?B?RzdpcklSeUhrYSt0bm84cVEwYm10Ti8xZ2hGTmRwUlNEUDBjVXphQkxaT1lH?=
 =?utf-8?B?ZWhYZzhiLzM5djVmNHpqTkdqYkNuMnZaTFNqaHlNRTBWM1JPWFBJYnkzZXFO?=
 =?utf-8?B?b3VaMW4rZGx3STlidUJmTGRVOGg3bnREZGJadUsrS1FleTAzUnZLT1B0WVZw?=
 =?utf-8?B?YUZtK3pRQ1ZxUFphNWZhb293UHdWdjJHSmlsOU5CelZBbGk4UDVoOTFMSkg0?=
 =?utf-8?B?cmF5K0dONEo3bmxvMDlheittNk5RMG9BdkdscmwrME9KMHViTmxabnV4MkJm?=
 =?utf-8?B?OWZBWHVpTTZHWXJzTnp2NE5Hd0V3Q0JLNkk3cSsxV2RJQkVvRThaREJSa1JC?=
 =?utf-8?B?eVlyVU00T2Q4elgxOGp0bmUzWS9saDZpektRcUtwYmFFdXlaYmRVN1RsK2wx?=
 =?utf-8?B?VDBnZ2c0cm10K2tWcTlKTHU4M3hhb1gvQVgwU2t2V0hBYjJhaUQrT3BLaXFH?=
 =?utf-8?B?Zk53blBtNUp6dTFXZDllWmZkeTdNZGFsQW5BTGoxNE9PUzUrdmFJemM2Kys4?=
 =?utf-8?B?OWhjZWc4bjcrWDVMVXpWOXREUFUxUHArSjErZVFUNUVYd24wc0Rkcm9LUmhw?=
 =?utf-8?B?V0NlN2FWRDN2VTVRUkxQbVNDM3pHZTZDd2RqSS9NaCtXRGgyZVJjVExuZm9G?=
 =?utf-8?B?WVZ2OXV3S09pUDZIVmFlYUZIYnhucjJpTDJCdjN4ajdYa1VvOGU2TnBabWJR?=
 =?utf-8?B?eXRsUFg5cHZ6QUZoZFpMYUlRbEEvL2VrMUZNa1J1MFpxZzQ0UXpuQmpRQWdN?=
 =?utf-8?B?VTJ3aU1meEZBN3ZXZ25UNkJObWkrWjlpZkl2U2RON2h2aVVIWThPaFlDSity?=
 =?utf-8?B?VHVkYldqWDFIUDUrNU16SnZueVV1aEY0bmZtTExTWVA1UldTb3p3L2JBUE1z?=
 =?utf-8?B?UldldU5YeERadmlKejVtWHZoSmUyYjN0cmUvZ2luUTlUb1gwdWdCZnpRNWZ4?=
 =?utf-8?B?M2toNC9Hemp1TXphVEdwMEF1c0FmZFR1UllnYXh1V21MOWROcXBXdWpsMXVy?=
 =?utf-8?B?VWhkS20vbS9QNkJpWE1TMXVOUkt4YzNIZkppa09McEZVdlBzRXNzS2F5U2lx?=
 =?utf-8?B?TWYwSmVETjMyK0FvUlVzNGR4ejA4KzZQU2hxOGk1VEg1NFc3dXN3OUtadGxu?=
 =?utf-8?B?NXRpUjkydElrelhzcWdqWW5qcVEzY3pYS0xUT0xTTmNCKzNwaG9lYWRrYnZC?=
 =?utf-8?B?bC9wem5ldkRGeUc0cWdaZkVQWGREYjc4eE5rZHZKRS9OSisyNjJka1ZwNE1x?=
 =?utf-8?B?NzZza1VpeU5qc1RxSzB4TE81Ykd0SzhZdW1CdHU2cU1JaS9pckhmQk8zNURK?=
 =?utf-8?B?UDJTRWlCaUl2RTZ1NmluZ2ZqckdSRXM1Z0pCUlVxZUcxa216WDhxRXlSWEVC?=
 =?utf-8?B?ZCtSSFNQamtqT0pCWHVabTRHQ1BPMWdENWQ0UityUHQyWnRjZEFWM0pGU1g1?=
 =?utf-8?B?YXVnZ0FQZEdCbjYrTUZSYWhWYlVQWHUrSTRPYXBFajYxWlZzOHdiRWc0L1pu?=
 =?utf-8?B?dXJCbnhlaUJLUXhmR3dJSTZoUlV2YTNiRGVmRGp3aHRxMGhVK2ljdkxzTkZE?=
 =?utf-8?B?d0lLY2lLSVRucS8xSFAvUXBSZ3VwbXhaT2xwTkNPS0NRcHhIUU5qdGsxT3ds?=
 =?utf-8?B?VVNwUnVhVlVkOVlnenlyYkZ4L3ppcDFXWWJNK0luNTFtUk1peGhvMkZQOHps?=
 =?utf-8?B?UTI0WUcySlFQNml1UDNBMjNpUTE2WUUwT251dkdkNFpGeFZQMnBUOWQ4WXp3?=
 =?utf-8?B?WXc3WW9IYTlDcGVKc3JhejBqWkRKNWg0L21VdXBxRjhySjZSWTdUa1N6b3g0?=
 =?utf-8?B?S2piQ3J0blZiUHpNYzAybFFkNCtFR2cvTGxFZjlnN3VSVjMwTndaYnBsN1do?=
 =?utf-8?B?bWE2Zm9aSG5xMUVnNk1OSm12dnZDaTVxcmMzc3Z5bmFWVFlLaHFtbnNJVE9o?=
 =?utf-8?B?RW5GQkw2M2NwaXFuNitrbzcxZ1g1SWozSi93Vkd5bjBpejZiREJxRGNGVHV4?=
 =?utf-8?B?SVo2aDgydXROUUpHVXdOUEVYSUVkUnVxRDNQcGVXNk9zdm4wY3k3OFgwaWVK?=
 =?utf-8?B?dWo1SDZRb0l1VXNGa1VGNGtsQXM3T3JHU0gvSVE3aTI2WUdrbUxxS0ZLVVVT?=
 =?utf-8?Q?cIaQUT2sRLeLmII4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0325AEA56D63854084B4038E4EC2EC80@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3ZYyIcFqcm9+2ET7GftjZKooxn+IL4/VwQ/wKMUiFYuYAgOuJdtrkgBX0WUM25UDhZnc5j5102KTQBMVUdiJdmJGuPYJp3MF5IMUbUZfhnEn83G1GIbCvCB/5X8a0wR1I19DqVR7wIM6oeTcXQe+k6V9yT0BSjZgYyxFrFxgxYBQOg3vQbeTsxnaMTUDKNORjguRJRKdIaPCK0E3H+/bNsCPlRATZRRvYSVb2UQcaWdrrfdXZ8xqh7ZfFbiBSIgW5ss7N04DFVi5YKzy7V4ypMZZUUA5dtL0C93DplUFP3emmx65bh5z2COUFDWkt1hOzsA0wH//r2YjY3IXfdPStA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9512f05-70df-4b16-1e25-08df1f531cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 00:29:53.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTtnPXpmBN1oDM0JqQhm25pd+hG3hlZLdPsSCPzL3iNRlxSVjpRQsGmOMUTk388n1wFkXdLXicqzyuZBloagIwmk942f2cn65JrsNWMO1gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDIyOjM4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gKy8q
DQo+ICsgKiBCaXRzIDMzOjMyIG9mIGEgZmllbGQgSUQgaG9sZCB0aGUgbG9nMiBvZiB0aGUgbWV0
YWRhdGEgZmllbGQgc2l6ZSBpbg0KPiArICogYnl0ZXMuIFNlZSAiTWV0YWRhdGEgRmllbGQgSWRl
bnRpZmllciIgaW4gdGhlIEludGVsIFREWCBNb2R1bGUgQUJJDQo+ICsgKiBTcGVjaWZpY2F0aW9u
Lg0KPiArICovDQo+ICsjZGVmaW5lIFREWF9GSUVMRF9TSVpFKGZpZWxkX2lkKQkoMSA8PCAoKChm
aWVsZF9pZCkgPj4gMzIpICYgMHgzKSkNCj4gKw0KDQpXb3VsZCBpdCBtYXliZSBiZSBjbGVhcmVy
IHRvIGp1c3QgZW5jb2RlIHRoZSA0IHBvc3NpYmxlIGNhc2VzPyBJIHByb21wdGVkIGFuIEFJDQp3
aXRoICIuLi5tYXliZSB0aGUgNCBjYXNlcyBjb3VsZCBqdXN0IGJlIGVuY29kZWQgaW5zdGVhZCBv
ZiB0aGUgbWFza2luZyBhbmQgYml0DQpzaGlmdGluZyIgYW5kIGEgYml0IG9mIGZvbGxvd3VwLCBh
bmQgaXQgZ2VuZXJhdGVkOg0KDQojZGVmaW5lIFREWF9GSUVMRF9TSVpFX01BU0sJR0VOTUFTS19V
TEwoMzMsIDMyKQ0KDQojZGVmaW5lIFREWF9GSUVMRF9TSVpFX0NPREUoX3NpemUpCQkJCQlcDQog
ICAgKChfc2l6ZSkgPT0gMSA/IDAgOgkJCQkJCVwNCiAgICAgKF9zaXplKSA9PSAyID8gQklUX1VM
TCgzMikgOgkJCQkJXA0KICAgICAoX3NpemUpID09IDQgPyBCSVRfVUxMKDMzKSA6CQkJCQlcDQog
ICAgIChfc2l6ZSkgPT0gOCA/IFREWF9GSUVMRF9TSVpFX01BU0sgOgkJCQlcDQogICAgIH4wVUxM
KQ0KDQojZGVmaW5lIFREWF9GSUVMRF9TSVpFX0NIRUNLKF9maWVsZCwgX3R5cGUsIF9tZW1iZXIp
CQkJXA0KICAgIEJVSUxEX0JVR19PTl9aRVJPKCgodTY0KShfZmllbGQpICYgVERYX0ZJRUxEX1NJ
WkVfTUFTSykgIT0JXA0KICAgICAgICAgICAgICBURFhfRklFTERfU0laRV9DT0RFKHNpemVvZl9m
aWVsZChfdHlwZSwgX21lbWJlcikpKQ0KDQpSZXZlcnNlcyB0aGUgZm9ybWF0IGJlaW5nIGNoZWNr
ZWQuIExvb2tzIGEgYml0IHNpbXBsZXIgdG8gbWUuDQoNCkkgdGhpbmsgd2UgY291bGQgYWxzbyBr
ZWVwIHRoZSBzYW1lIHR5cGUgb2YgY29tcGFyaXNvbiAoc2l6ZSBpbiBieXRlcyksIGJ1dA0Kc3dp
dGNoIHRvIHRoZSBleHBsaWNpdCA0IGNhc2UgdGVybmFyeSBzdHlsZS4NCg0KV2hhdCBkbyB5b3Ug
dGhpbms/IEkgdGhpbmsgeW91IHNlZSBhIGJpdCBtb3JlIGJpdCBtYXRoIGxpa2UgdGhhdCBpbiBL
Vk0gdGhhbiB5b3UNCmRvIGluIGFyY2gveDg2Lg0K
