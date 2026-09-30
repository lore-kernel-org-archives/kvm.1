Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150A4FDA54;
	Wed, 30 Sep 2026 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806463; cv=fail; b=kdeRVWfhDWga9runU75vb7DICwTkdk7EyTWYzOphfQn1Z58DFBFeylVcF8+HY0Qrr5eYkY8zL6zbOYIFZ4mHOKUKQQnbp975Ti+6Ux9SMc0KzC6pgoerpvAnxgrVRwk9vmRUUlpX3JUKaSJuLhNWHPUUj15EqmXegxpwTIAkz98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806463; c=relaxed/simple;
	bh=KWN6myS99mm/G5e0yluk6kB51Fwp9NxlLVKsBkx7wLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AX8amUXLbSyz1Md2ODzETCH3mxYlWvCuCBLUppG4X33hcPtAgMxFFttw8hRNGFPVVjfZYn3nLcdrNiU1fj+vfUVaSzPCmoisgG48W3Nc6eNex3vOfvsNruShvroZ8nNJsjQESpIai1OjkPSjcu1DuZawPSf0dlV1K6osXe4FoGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mB24Xq30; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mB24Xq30"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790806458; x=1822342458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KWN6myS99mm/G5e0yluk6kB51Fwp9NxlLVKsBkx7wLk=;
  b=mB24Xq30QDo0e1HnJFGKIPjI9wBXRu/U1WtthOv4Xk01WbuItJDn7ISY
   Qoeg1K3FyxbPv5Iz4ICC5ZcVj028uKkd4CyMiAk3Wiz2ahG0O25dCcXel
   u7CzT0tBRVo+jM8s5x4NGXCN7p5SfKIJ1fy/NbuI3WcvAKZ543l3nlZiR
   CpukVLui3SINgQEk0dkuzKTw8ObBRIHGGAOIk4ddDNUYLH3k0tznRfDnI
   e/I7+08q6jOmsRIKjsT/h10rQZQz3HxbUJWqOV6xzDA/Plgmle1ccseqd
   iI58E/d6bzLwUlm2ubisF9LmwcwH8DrGpznwuhfBv7ap1ADtIdpwz3ScV
   Q==;
X-CSE-ConnectionGUID: U+EmT/W4SlaV1zPKp7jX1A==
X-CSE-MsgGUID: LZmhrpsrTDq5tja/q+DPUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94038137"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94038137"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 15:14:17 -0700
X-CSE-ConnectionGUID: 1WNsILuzScuvfXN0PotwVg==
X-CSE-MsgGUID: fo2FAVAvQrKnQ/5uk2xpGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="275013057"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 15:14:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 15:14:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 15:14:17 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 15:14:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC6p9CEDZeZ9nJg45OKU7ZfC0vqrmjvrl+3rpbuG4riAzN+F57GPvaQdTMVoTOLgWc8a/5GN/2J8gEuFqaGWcXWKiLJ34GMx0uvXp0OvjGMGBY3cjsg2gY7U3qXQUXkzdQlWAV/sBuxuGeWG9s4WM+tgNVN5FXMctWA2g63dnfr3rhCeuvUpq6A5+7QDIr0KnKVKEH1IngBhUK4YU+m4P2eoRRhV3I/aX4uFFIlPNLbqE40xUqOla1I40g+MMfJuyMGG5FmNKuMuI4WAZLfM6h/UIyRugLGdhCxnCgKURddD/8/K1DLjGddVjQ6dpvj9kKxJZRbcHe4cebiobSuSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWN6myS99mm/G5e0yluk6kB51Fwp9NxlLVKsBkx7wLk=;
 b=Q9aDlq0Yv7Xxya62jg3F+J6tbY3TFUXalb4Lt4aik+SMZH34IjSFbhIxfbKQtKbc1/xO7QuJekWGUk39D2fojgaBVAiHvIr0S3f0GtVih8bzCg4N5i+vJozrm6gRL6fq7sjH6f/JHrf6cDcwJFzm/QuuafnyCDf/voku+Aix7YWh6cY0Xkn/VZPZNaItYhymlYmMMKrdr5Kf760gbDCG0DSFz+xj5eyUR0Ps9DC78mz0MbprxSemiWO2yiRJNIRSI8SAo4WFcG6hUHMorElofjq8FiimAQqMDbXqwAtH+oPOIiZnqTgrcrGz0uWZ83LrF7uQCU0g3tRaP6qzRVFzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA0PR11MB4639.namprd11.prod.outlook.com (2603:10b6:806:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 22:14:15 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 30 Sep 2026
 22:14:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v6 4/6] virt: tdx-guest: Add a helper for the Quote buffer
 size
Thread-Topic: [PATCH v6 4/6] virt: tdx-guest: Add a helper for the Quote
 buffer size
Thread-Index: AQHdUMfMMdIN81NTlUyUWnuGMUIJqLbnsHyA
Date: Wed, 30 Sep 2026 22:14:14 +0000
Message-ID: <007f5865912a9fb40c0e3a1ca9b7bb36d8af9794.camel@intel.com>
References: <20260930103739.2851980-1-peter.fang@intel.com>
	 <20260930103739.2851980-5-peter.fang@intel.com>
In-Reply-To: <20260930103739.2851980-5-peter.fang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA0PR11MB4639:EE_
x-ms-office365-filtering-correlation-id: 2433e70f-5ca4-452a-0bce-08df1f4029c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|56012099006|4143699003|5023799004|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: UBd+2MiHKb6VKM78VuuKqF81vElxrmxjRQAXQlma0yO9w8JFnNucSmpXFwzIDDQexAc3HHNPCJOMINIEOEdhphy5kCudMJJawihECBoxuszj4376wgmLmaLKnpj4BxkVpcwhtgrVZ3MPrDatxtpzyk6ki146BC0wrppfz0N7zhJUj1u6H6eP+DbIErHrsEC0cOcPKXyBLCyDqPRkWCpNfftsMVeXv9qUV2KX5D0gAfCUjM6nEqaJmwNvlh5hv27X1FeiBgAtj+/nsgqwnQ1nOrlY/i5szxZCZMhNtOU0n205ueOllsaf0+5bJXu73b/VW2pPfViQdSSbs5FUL6rewk1tCzh46Xsu3BzWuo/H8LJrYrmmX01I6y+a2ACKY2qxDkQLSad0ZS24xjyMdCoDj9g3Mly4kDNFp/H0c7vvEiy0tKhHtjtYCuLhLvuDOGHI1uC0iy1Mel2TqldJiM+zUuSfQLqg9uvBNtZc8iEGPSmj8Nlg2taSEf1OCBBZbfQKYSUn47TaFvGzqMyF1GSUrRfoVGHELaqEIj8ZEtzXOmhmrR/iGbv9plmmZ6vXaDzhxhV6K0cAcqLXToerk0vNFHmIUX3zTh8W+DZSquFB3r41+apejRhWyxwDk6FnZQ8KrmeaHP7iAOU2Q/xTAd/6W+b0rYXKG/RA1cHWYnJ+m90ImiRr5m72Ervb2YaUJKaehJIcJenK6lH+RHpGt5nR3sE5Pxsr2z4q9cdXeyWs6+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmRtaFh5aGk4MkJVYnRWV2RRVHVnVmRhdVFVUitWalQ0RmRpaTZkWFJNTEEr?=
 =?utf-8?B?b1FZdzBhQUt4a21Sakt6TWdFSzk1cG5DNTdJajErOE9DcmRtSDFTMk8vWE9k?=
 =?utf-8?B?WDZpWG5MU1lqNUphZmNZUEtqU1dtQlZBOUhGU2JUY1lpLzYrVkE0Z0c3ZUlQ?=
 =?utf-8?B?RXc5Zkp0UTRjMXB6c1RUY1prRFFnVjdmMy8vekZMbGlXWW5aS1liRU5nQmha?=
 =?utf-8?B?T1oyME9wa3plMFkwL2NiL0FtNFBRZUw0MUcwb2VyR0Z0KzZISGxXN05sd0pB?=
 =?utf-8?B?dHBFdlRYTkdxUitreFJmb3BUSjNIYXJVY1o3eURZWDRSektkSmkyZ20vWC85?=
 =?utf-8?B?ODVuNk9HckhWanY4OUVESEZYYklLVmZyTkRGei8yUkczVFhjWXcyTkF5UEFT?=
 =?utf-8?B?eFFkNFI3Mk0weC80SE96SC9Kd3RPL2piL1lBaHJmTHRkcG8yQ1VTbW9ybmUx?=
 =?utf-8?B?RGVpUDlmY1BydEtkSDh5ZTZuanVOMGw2VnVPOFJicUlDK0lxaE0vYlpyZnhL?=
 =?utf-8?B?bGl0cWJ2b2dpSHhVN3Bad0ZhSjZ5SkFOblM2RWM3TUplZlZlNml5RFZuakcv?=
 =?utf-8?B?ajJNK09seW5TRW9RSnc5U21qemYzcEFlUEt1NVJ3bmxYVlhwb3FFbzB1NUhH?=
 =?utf-8?B?UHhobVBRNmhxTXlaUTNQMmN2RDBtcjBIenBlbFVDZGJPNGZEY2hwOTdyOVBw?=
 =?utf-8?B?dnhiYVhQbEwrYW05NkFoL0dXaWIyckZyVUVadFRzRTBIMDNZUFdLV2FTN1Vk?=
 =?utf-8?B?TDl2TFk0eHJWMy9CZEd6T290RkMzc0oreU1BMkNuZ0ZqS0J2bWRDcjFYUDJS?=
 =?utf-8?B?YTZXckNiL0VidytKYTVDTG9jOHNNL3BIbmdJSlN4Mjl0ZW9aZUUzMzRhUjVi?=
 =?utf-8?B?Q2tSSlVhck5UeGEweTluRk9ESjJUREl2cEVyWTU0OC9Ua1dFNGZ4aWQvcVpN?=
 =?utf-8?B?bk1ldXBTaWpzZlM5RDE4L3VFb3RmSnBIMDZibWRVOXJVcjZXWE9uREdCdEUv?=
 =?utf-8?B?SVJyL2VIVUZHajJzSCsyQnExUmRDSlpjMUM3bW04SFVYbjBGblRzYmo0U1k5?=
 =?utf-8?B?RG5yY0hoOXZESGVsRDZvMDNMbEF6d3BTd0ppL3htU2lVWTMxVklXQURQRVVq?=
 =?utf-8?B?MWJ4dXp4czlueWpTaHBZb3FnY2g1Z1BnNFg3aG4yME84LzAxRDl5bUJ2bWg1?=
 =?utf-8?B?RGFmYmw2V29XRVFMbXNmN0hOOXBsTlp0U01nV0NMVHUwc3NwZXZoemNmMlFj?=
 =?utf-8?B?Ukd3VkdtWlVTOVZsMk5kY1Y0UGNXdUZHNllzVUpsb2xJbTlJTldPbDZVWlcy?=
 =?utf-8?B?dGlXSU1vNk1BaHM0dDJKNlRrRjMrTGhKUjRjSzg3bzFpczl3UWhDOUFYdjM1?=
 =?utf-8?B?MG5leEFLaldlbk9ZRExydkQwenhGVnRaMHRCUllZMmZSR29FWE5FZE5kRytX?=
 =?utf-8?B?SURWb2ZmT0VCZkUxdHRIc3RFSURnUGtuaTRTaHV3NmJuRy9NYU1pZmFZbmU5?=
 =?utf-8?B?VDEycEdaMGVKdDZVVTc2S21FUGtENTFYVUtBVnNOQVV1MTZiY1hWcUE1UE9W?=
 =?utf-8?B?QjhGOWFkM3QzdmFhYWRQTll5K2F0cHZEUmRaeVR3azVIZStQZmNscU1aVGZH?=
 =?utf-8?B?S3A3QzVuQ2RnZWtrTHpGVzVDL213ZURwcldyVjhhcnB6ZWRwbHMvUVpJY3JX?=
 =?utf-8?B?NHV0UGI2UVI1TStTME9ydlZZeHR5N1JpeW0rQ1RKOVFkOVNDOUpBV3F4VFhh?=
 =?utf-8?B?eURRT0FKbGNPVEdPVWs0Ymk0dVBmbm5qUWtyckpXYVVwVTZMMUNzQXl1akdp?=
 =?utf-8?B?TGh0Q3lZdG1hcW5QN0VjOTlCVjhoSTRVOTkwNDJ3VktEVEJja3hiWDVIaHcy?=
 =?utf-8?B?SUxsZjhXZkZaUDVjOHEzdnNoUkloN3dwNHlYbTkwK1ZKUjRQcjVYcXpQSGJL?=
 =?utf-8?B?TEtVdXdmeHY0aXpkazk4WnVFaDdzL0ZFTmw2RDdvOVhZUlJqb3l6amZ1RzVV?=
 =?utf-8?B?YXhSVEJpMUQxRm8wME9CdXV1NGxLcjUrK0J3K3MwVE5SeGlHOVFDUkZiVHBU?=
 =?utf-8?B?ZjZFdlRCQjVSUUVFbjg1aEg2MUVLQ0FUNTA3RlkzK3pMTGxhNUdMaWVCdzFz?=
 =?utf-8?B?ZVZobjAvWFhFMk51N0FtRUFHNzUyT24yQkhVUkZWQ1V6YnFvaThBQzMvR1pY?=
 =?utf-8?B?RTR5a0xmOEVOSFBGdFV6MVlONENKZmMwbno4VWVMOUNPV245NmhzUDB1dnJG?=
 =?utf-8?B?MnByWFJYeWdRQlN3UCszZWZLUTcwUlBSajk5WVI5aWw4L0NxSXhFWURabTlK?=
 =?utf-8?B?cHl1NjA0aWJ6YllqVEpNY3A4bzhKeDFmWjRWR0RDeE5haUpwbXNwT1VWTVFy?=
 =?utf-8?Q?OCf/RHtWZuZo9wIE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <869E84573E86E645BA6C2E633BC2BF4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B/4hAiPdUt2OxROIySfFIRi2TetWKSg8LCixU2qx1rt91oZsxEjKTexi5c3zZLR/QYtXkqtp75hrWBarJNZ5MYrSOFZXDECVX4RQkT+xgca+epr8eB4UmCt/mh02CJDdstB5oWjYmEDVpJRUK4TVla9Sfet6+61NOmLk+k1Gc6B1olTCKDyd09zzPwHSINRI0/ylm0tBXdhd2S5fYYUAF63o4mvGoG5CnXUc6BqglOcDiny3lMXfuQofPRzlU+oXnNhRfbzJQDJMVqEqC8Buq57a5VBUH1jcGEeFtHTDt9E4eCBE3WXbrA0J0UTmoCl4An5OpJFb1705Qz207HiYeg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2433e70f-5ca4-452a-0bce-08df1f4029c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 22:14:14.8292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyBPDMX3TnzN7vZTPULgAlNMmAnpP7RTC7aDrNgB3mrSnQ91pYhgjsf6sGBpukmTsCAA/pD/BEW+HBeYq5a+R04XLJLlNvXpLrB2GNpjY60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4639
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDAzOjMwIC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiBU
aGUgUXVvdGUgYnVmZmVyIHNpemUgaXMgYSBjb25zdGFudCBzcHJpbmtsZWQgYWNyb3NzIHNldmVy
YWwgcGxhY2VzLg0KPiBSZWFkIGl0IGZyb20gYSBoZWxwZXIgaW5zdGVhZC4gQW5kIHJlbmFtZSB0
aGUgY29uc3RhbnQgdG8gYXZvaWQgdXNpbmcgYQ0KPiB2ZXJiLg0KPiANCj4gVGhpcyBzZXRzIHVw
IHRoZSBwbHVtYmluZyBmb3IgYSBsYXRlciBjaGFuZ2UgdGhhdCBtYWtlcyB0aGUgc2l6ZQ0KPiBk
eW5hbWljLg0KPiANCj4gVGhlcmUgYXJlIHNldmVyYWwgInNpemVzIiBhdCBwbGF5IGhlcmU6IHRo
ZSByYXcgUXVvdGUgZGF0YSwgdGhlIFF1b3RlDQo+IGJ1ZmZlciAodGhlIGhlYWRlciBtZXRhZGF0
YSBwbHVzIHRoZSByYXcgZGF0YSksIGFuZCB0aGUgYWxsb2NhdGlvbiAodGhlDQo+IHBhZ2UtcGFk
ZGVkIFF1b3RlIGJ1ZmZlcikuIFRoZSBoZWxwZXIgcmV0dXJucyB0aGUgUXVvdGUgYnVmZmVyIHNp
emUgYW5kDQo+IGxlYXZlcyBwYWdlIGFsaWdubWVudCB0byBjYWxsZXJzIHRoYXQgbmVlZCBpdC4N
Cj4gDQo+IEFJIHdhcyB1c2VkIHVuZGVyIHN1cGVydmlzaW9uIHRvIGNvbGxlY3QvYXBwbHkgZmVl
ZGJhY2ssIHJldmlldyBjb2RlIGFuZA0KPiB3b3Jrc2hvcCBsb2dzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUGV0ZXIgRmFuZyA8cGV0ZXIuZmFuZ0BpbnRlbC5jb20+DQo+IC0tLQ0KPiB2NjoNCj4g
IC0gRG9uJ3QgY2FjaGUgdGhlIHNpemUgaW4gdGhlIGhlbHBlci4gW1JpY2tdDQo+ICAtIExldCB0
aGUgY2FsbGVycyBwYWdlLWFsaWduIHRoZSBidWZmZXIgc2l6ZS4gW1JpY2tdDQo+ICAtIEFkZCBh
IGNvbW1lbnQgZm9yIHRoZSBoZWxwZXIuIFtEYXZlXQ0KPiB2NToNCj4gIC0gUmV3b3JrZWQgdjQg
My80IHRvIHVzZSBhIGhlbHBlciBpbnN0ZWFkIG9mIGEgZ2xvYmFsLiBbRGF2ZSwgWGlhb3lhb10N
Cj4gIC0gVXNlIFREWF9ERUZBVUxUX1FVT1RFX1NJWkUgaW5zdGVhZCBvZiBHRVRfUVVPVEVfREVG
QVVMVF9CVUZfU0laRS4NCj4gICAgW0RhdmVdDQo+ICAtIFVzZSAic2l6ZSIgaW5zdGVhZCBvZiAi
bGVuIiBmb3IgYnVmZmVyIHNpemUgdmFyaWFibGVzLiBbRGF2ZV0NCj4gIC0gRHJvcCB0aGUgUkIg
dGFncywgYXMgdGhlIGNvZGUgY2hhbmdlZCBzdWJzdGFudGlhbGx5Lg0KPiAtLS0NCj4gIGRyaXZl
cnMvdmlydC9jb2NvL3RkeC1ndWVzdC90ZHgtZ3Vlc3QuYyB8IDMxICsrKysrKysrKysrKysrKysr
LS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnQvY29jby90ZHgtZ3Vlc3QvdGR4
LWd1ZXN0LmMgYi9kcml2ZXJzL3ZpcnQvY29jby90ZHgtZ3Vlc3QvdGR4LWd1ZXN0LmMNCj4gaW5k
ZXggNzdjNjNjM2Y4MjBmLi4wY2YwNzhmMDlhNzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmly
dC9jb2NvL3RkeC1ndWVzdC90ZHgtZ3Vlc3QuYw0KPiArKysgYi9kcml2ZXJzL3ZpcnQvY29jby90
ZHgtZ3Vlc3QvdGR4LWd1ZXN0LmMNCj4gQEAgLTE2Miw3ICsxNjIsNyBAQCBzdGF0aWMgdm9pZCB0
ZHhfbXJfZGVpbml0KGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKm1yX2dycCkNCj4gICAq
IERJQ0UtYmFzZWQgYXR0ZXN0YXRpb24gdXNlcyBsYXllcmVkIGV2aWRlbmNlIHRoYXQgcmVxdWly
ZXMNCj4gICAqIGxhcmdlciBRdW90ZSBzaXplICh+MTAwSykuDQo+ICAgKi8NCj4gLSNkZWZpbmUg
R0VUX1FVT1RFX0JVRl9TSVpFCQlTWl8xMjhLDQo+ICsjZGVmaW5lIFREWF9ERUZBVUxUX1FVT1RF
X1NJWkUJCVNaXzEyOEsNCj4gIA0KPiAgI2RlZmluZSBHRVRfUVVPVEVfQ01EX1ZFUgkJMQ0KPiAg
DQo+IEBAIC0yMDYsMjYgKzIwNiwzNiBAQCBzdGF0aWMgbG9uZyB0ZHhfZ2V0X3JlcG9ydDAoc3Ry
dWN0IHRkeF9yZXBvcnRfcmVxIF9fdXNlciAqcmVxKQ0KPiAgCQkJICAgICBVU0VSX1NPQ0tQVFIo
cmVxLT50ZHJlcG9ydCkpOw0KPiAgfQ0KPiAgDQo+ICsvKiBTaXplIG9mIHRoZSBoZWFkZXIgbWV0
YWRhdGEgcGx1cyB0aGUgbGFyZ2VzdCBwb3NzaWJsZSByYXcgUXVvdGUuICovDQo+ICtzdGF0aWMg
c2l6ZV90IGdldF9xdW90ZV9idWZfc2l6ZSh2b2lkKQ0KPiArew0KPiArCXJldHVybiBURFhfREVG
QVVMVF9RVU9URV9TSVpFOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBmcmVlX3F1b3RlX2J1
ZihzdHJ1Y3QgdGR4X3F1b3RlX2J1ZiAqYnVmKQ0KPiAgew0KPiAtCXNpemVfdCBsZW4gPSBQQUdF
X0FMSUdOKEdFVF9RVU9URV9CVUZfU0laRSk7DQo+IC0JdW5zaWduZWQgaW50IGNvdW50ID0gbGVu
ID4+IFBBR0VfU0hJRlQ7DQo+ICsJc2l6ZV90IGFsbG9jX3NpemUgPSBQQUdFX0FMSUdOKGdldF9x
dW90ZV9idWZfc2l6ZSgpKTsNCj4gKwl1bnNpZ25lZCBpbnQgY291bnQ7DQo+ICsNCj4gKwljb3Vu
dCA9IGFsbG9jX3NpemUgPj4gUEFHRV9TSElGVDsNCg0KV2h5IGNoYW5nZSB0aGUgY291bnQgdG8g
YmUgc2V0IG91dHNpZGUgb2YgdGhlIGRlY2xhcmF0aW9ucyBoZXJlIGFuZCBiZWxvdz8NCg0KPiAg
DQo+ICAJaWYgKHNldF9tZW1vcnlfZW5jcnlwdGVkKCh1bnNpZ25lZCBsb25nKWJ1ZiwgY291bnQp
KSB7DQo+ICAJCXByX2VycigiRmFpbGVkIHRvIHJlc3RvcmUgZW5jcnlwdGlvbiBtYXNrIGZvciBR
dW90ZSBidWZmZXIsIGxlYWsgaXRcbiIpOw0KPiAgCQlyZXR1cm47DQo+ICAJfQ0KPiAgDQo+IC0J
ZnJlZV9wYWdlc19leGFjdChidWYsIGxlbik7DQo+ICsJZnJlZV9wYWdlc19leGFjdChidWYsIGFs
bG9jX3NpemUpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgc3RydWN0IHRkeF9xdW90ZV9idWYgKmFs
bG9jX3F1b3RlX2J1Zih2b2lkKQ0KPiAgew0KPiAtCXNpemVfdCBsZW4gPSBQQUdFX0FMSUdOKEdF
VF9RVU9URV9CVUZfU0laRSk7DQo+IC0JdW5zaWduZWQgaW50IGNvdW50ID0gbGVuID4+IFBBR0Vf
U0hJRlQ7DQo+ICsJc2l6ZV90IGFsbG9jX3NpemUgPSBQQUdFX0FMSUdOKGdldF9xdW90ZV9idWZf
c2l6ZSgpKTsNCj4gIAlzdHJ1Y3QgdGR4X3F1b3RlX2J1ZiAqYnVmOw0KPiArCXVuc2lnbmVkIGlu
dCBjb3VudDsNCj4gIA0KPiAtCWJ1ZiA9IGFsbG9jX3BhZ2VzX2V4YWN0KGxlbiwgR0ZQX0tFUk5F
TCB8IF9fR0ZQX1pFUk8pOw0KPiArCWNvdW50ID0gYWxsb2Nfc2l6ZSA+PiBQQUdFX1NISUZUOw0K
PiArDQo+ICsJYnVmID0gYWxsb2NfcGFnZXNfZXhhY3QoYWxsb2Nfc2l6ZSwgR0ZQX0tFUk5FTCB8
IF9fR0ZQX1pFUk8pOw0KPiAgCWlmICghYnVmKQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gIA0KPiBA
QCAtMjY2LDYgKzI3Niw3IEBAIHN0YXRpYyBpbnQgdGR4X3JlcG9ydF9uZXdfbG9ja2VkKHN0cnVj
dCB0c21fcmVwb3J0ICpyZXBvcnQpDQo+ICB7DQo+ICAJdTggKmJ1ZjsNCj4gIAlzdHJ1Y3QgdHNt
X3JlcG9ydF9kZXNjICpkZXNjID0gJnJlcG9ydC0+ZGVzYzsNCj4gKwlzaXplX3QgcXVvdGVfYnVm
X3NpemUgPSBnZXRfcXVvdGVfYnVmX3NpemUoKTsNCg0KVGhpcyBsb2NhbCB2YXIgaXMgYSBwZXJm
b3JtYW5jZSBvcHRpbWl6YXRpb24/IE9yIGEgbGluZSBzaG9ydGVuZXI/DQoNCj4gIAl1MzIgb3V0
X2xlbjsNCj4gIAlpbnQgcmV0Ow0KPiAgCXU2NCBlcnI7DQo+IEBAIC0yODEsNyArMjkyLDcgQEAg
c3RhdGljIGludCB0ZHhfcmVwb3J0X25ld19sb2NrZWQoc3RydWN0IHRzbV9yZXBvcnQgKnJlcG9y
dCkNCj4gIAlpZiAoZGVzYy0+aW5ibG9iX2xlbiAhPSBURFhfUkVQT1JUREFUQV9MRU4pDQo+ICAJ
CXJldHVybiAtRUlOVkFMOw0KPiAgDQo+IC0JbWVtc2V0KHF1b3RlX2J1ZiwgMCwgR0VUX1FVT1RF
X0JVRl9TSVpFKTsNCj4gKwltZW1zZXQocXVvdGVfYnVmLCAwLCBxdW90ZV9idWZfc2l6ZSk7DQo+
ICANCj4gIAkvKiBVcGRhdGUgUXVvdGUgYnVmZmVyIGhlYWRlciAqLw0KPiAgCXF1b3RlX2J1Zi0+
dmVyc2lvbiA9IEdFVF9RVU9URV9DTURfVkVSOw0KPiBAQCAtMjkyLDcgKzMwMyw3IEBAIHN0YXRp
YyBpbnQgdGR4X3JlcG9ydF9uZXdfbG9ja2VkKHN0cnVjdCB0c21fcmVwb3J0ICpyZXBvcnQpDQo+
ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiAtCWVyciA9IHRkeF9oY2FsbF9n
ZXRfcXVvdGUocXVvdGVfYnVmLCBHRVRfUVVPVEVfQlVGX1NJWkUpOw0KPiArCWVyciA9IHRkeF9o
Y2FsbF9nZXRfcXVvdGUocXVvdGVfYnVmLCBQQUdFX0FMSUdOKHF1b3RlX2J1Zl9zaXplKSk7DQoN
ClRoZSBwb2ludCBvZiBsZWF2aW5nIHBhZ2UgYWxpZ25tZW50IHRvIHRoZSBjYWxsZXJzIHdhcyB0
byBub3QgY2h1cm4gdGhlIGV4aXN0aW5nDQpjb2RlIGluIHRoaXMgcGF0Y2guIEJ1dCB0aGlzIGNh
bGxlciBpcyBnZXR0aW5nIGNoYW5nZWQgYW55d2F5IGZvciBzb21lIHJlYXNvbi7CoA0KDQpJbiBw
YXRjaCA2LCBpdCBjaGFuZ2VzIHRvIHRoZSBkeW5hbWljIGJ1ZmZlciwgd2hpY2ggbWlnaHQgbm90
IGJlIHBhZ2UgYWxpZ25lZC4NCkJ1dCB3aGF0IGlmIGxlbiBwYXNzZWQgdGhyb3VnaCB0aGUgR0hD
SSBjYWxsIGlzIG5vdCBwYWdlIGFsaWduZWQ/IERvZXMgaXQgY2F1c2UNCmEgcHJvYmxlbT8gT2gh
IEdIQ0kgZG9jcyBzYXkgIlIxMyAtIFNpemUgb2Ygc2hhcmVkIEdQQS4gVGhlIHNpemUgbXVzdCBi
ZSA0S0ItDQphbGlnbmVkLiINCg0KU28gaXQgbmVlZHMgbmV3IGFsaWdubWVudCBvbmx5IGJlY2F1
c2Ugb2YgdGhlIGR5bmFtaWMgYnVmZmVyLCBhbmQgdG8gZnVsZmlsbCB0aGUNCkdIQ0kgc3BlYy4g
T3Igb3RoZXJ3aXNlIEkgZ3Vlc3MgeW91IGNvdWxkIGNsYWltIHRoYXQgdGhlIHBhZ2UgYWxpZ25t
ZW50IGlzIGFkZGVkDQpoZXJlIGJlY2F1c2UgaXQgd2FzIGFsd2F5cyByZXF1aXJlZCBhbmQgbm93
IGl0J3MgdG9vIGhhcmQgdG8gc2VlIHRoYXQgYW55DQpwb3NzaWJsZSBzaXplIGlzIGFscmVhZHkg
YWxpZ25lZC4gSSB0aGluayBpdCdzIHdlYWsuIEknZCBwdXQgaXQgaW4gcGF0Y2ggNiBhbmQNCmV4
cGxhaW4gd2h5IGl0IGlzIG5vdyBuZWVkZWQgYXQgdGhhdCBwb2ludC4NCg0KPiAgCWlmIChlcnIp
IHsNCj4gIAkJcHJfZXJyKCJHZXRRdW90ZSBoeXBlcmNhbGwgZmFpbGVkLCBzdGF0dXM6JWxseFxu
IiwgZXJyKTsNCj4gIAkJcmV0dXJuIC1FSU87DQo+IEBAIC0zMTEsNyArMzIyLDcgQEAgc3RhdGlj
IGludCB0ZHhfcmVwb3J0X25ld19sb2NrZWQoc3RydWN0IHRzbV9yZXBvcnQgKnJlcG9ydCkNCj4g
IA0KPiAgCW91dF9sZW4gPSBSRUFEX09OQ0UocXVvdGVfYnVmLT5vdXRfbGVuKTsNCj4gIA0KPiAt
CWlmIChzdHJ1Y3Rfc2l6ZShxdW90ZV9idWYsIGRhdGEsIG91dF9sZW4pID4gR0VUX1FVT1RFX0JV
Rl9TSVpFKQ0KPiArCWlmIChzdHJ1Y3Rfc2l6ZShxdW90ZV9idWYsIGRhdGEsIG91dF9sZW4pID4g
cXVvdGVfYnVmX3NpemUpDQo+ICAJCXJldHVybiAtRUZCSUc7DQo+ICANCj4gIAlidWYgPSBrdm1l
bWR1cChxdW90ZV9idWYtPmRhdGEsIG91dF9sZW4sIEdGUF9LRVJORUwpOw0KDQo=
