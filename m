Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA442903E;
	Mon, 27 Jul 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175020; cv=fail; b=Zsca3OJawn2VJjJfzySqgDKquzi/wxK7UYVnWNM8AyuYWWG9+q3itjQtQaQGN0D872K1SUlM++rOnHS7cdJqjiBEeLfNBnyIjJ2ko5SsT4A6LWERhc45iW/4PcU3BL112RHV7MFmWzJD15A119flXjbnbj3J43j1GcyWpEMW+1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175020; c=relaxed/simple;
	bh=mnNZnupCocUX7N+4k6WxYE0fFJ5DV+492fW2wD6tjjc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O2nrkDYszGlEVqyOzv+56dkjn7n1Ln4MDoFVWUwgLgHDzBq91eLDjQwC+4cRJot9rbylMx6vRQ0FPwWMCJkjAAY12AouZy+ZXgov8XP8rME1eDkGWte2Ocx66YGE8APfshugAicJJfQniY37GfFTnBOVvfwjQJmLepnA1lQADXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsafBe86; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsafBe86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785175004; x=1816711004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mnNZnupCocUX7N+4k6WxYE0fFJ5DV+492fW2wD6tjjc=;
  b=UsafBe860Ot+98E6kAZzSUJwcMXSRjbVUpbuDJNbh3x/Rp19FDdOR+UK
   lA+3WCbaMgEhkNsAcMpXs2/BwPzIZII6vQIFqw77MEeEWzQJQIxcwVyuK
   tCmgSFORFi5MjOkKD8sFP2yx8ehOsgH8DSCGxHuZPFWqkskYB2BCXxbHh
   N1v01krNE0sYUT/KLPug70pl8uFhX2WFsKncP41GUVx7FIEflN2yBBLlK
   78VjZR4A5ObDfG7aqBTLpQP4U60430hQSkSKfS6BfDJvJ2UzILZEzcWLo
   xGPW3ZV1CJN+7dV+WOA52qGe6tPKBZr+JFmARhn13FAAHprXmToJMk3y3
   Q==;
X-CSE-ConnectionGUID: M6brsk7oT82NCt7zVmu8zA==
X-CSE-MsgGUID: rCsqS/MpRrGul16t8mi1Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85834775"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85834775"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:56:36 -0700
X-CSE-ConnectionGUID: O/Yfev0XTjCnoKukVWFzEw==
X-CSE-MsgGUID: EAJSKIySTKqslSinOLQMBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="258917894"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:56:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 10:56:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 10:56:35 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 10:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRyOkVd+P4h3bwfc1y5CEp4cDGbneyord8QbNYb2FwhMHyGf4GuwiwimI5l6jRl2qL2llz+OhW0g5yxbVvh7sfkSDU7Xd3L0Otv7r0QhcPwTWbbzq689EU63mP68K1wwWy1QdKm2ZSuuPmkLXSIP1GjEW5JUxmcXEVp47j6ft8ol+QZWr0El7yb23195TS2eZqzVYxuiGnWSeR0ncecUmlVPGCZVzNyQNjXloNkHp5aWfjcJ7T5Gw7i6kS5imaXd2FhHGweHfUmF5KH14sjbXvpLsGjCs7Vqz0Mwwt9XtIv2LfjUrBq+i4BW3jHnZ76dPaC+c8e0lS3uXW1j/mNHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnNZnupCocUX7N+4k6WxYE0fFJ5DV+492fW2wD6tjjc=;
 b=SWWjWIXGYTcm0Z0XtA3HKaAymPPOrbUbafbGcvZ1Wu0DnkJdg6X1UvORNLUgLdQsk+Hd9lq4A2aUBknxY1hGbvDpo/xB1gtECpa8AwtqinYst0NQBQIRc2SpZCFuy20Y2gIrxoLtWapNPld3/gtgycYeFwilTKVrsstsz7AaZIo1Yx0gl9/5d83r+3vv2TAdRtmKYaazxSKsPE3B62lYye673ecJGw9kui8wuhsg6ukCLXFXOfcg496aXMQ3uMdRACKsPsUgRHHBq+G9r2m62F+zhYNIpFm3MP8ktdAVjUv5jDjUWCVbB4edykYcMQnqku0NsgQPvr8N8u8cR0gE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MN6PR11MB8104.namprd11.prod.outlook.com (2603:10b6:208:46c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 17:56:31 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 17:56:31 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xu, Yilun"
	<yilun.xu@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "djbw@kernel.org" <djbw@kernel.org>, "Fang,
 Peter" <peter.fang@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Topic: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Index: AQHc/v34tfo3elz6N0uAdpZoN5jBM7Z8ksGAgAT5AYCAAFmtAA==
Date: Mon, 27 Jul 2026 17:56:31 +0000
Message-ID: <7611fe250925614d64f05cac8d398f54ee386583.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
	 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
	 <cfeee0fe-c61d-447c-86bc-8d8244090879@intel.com>
	 <amdRWaoKa0k324JM@yilunxu-OptiPlex-7050>
In-Reply-To: <amdRWaoKa0k324JM@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MN6PR11MB8104:EE_
x-ms-office365-filtering-correlation-id: 685047ce-2abd-47e2-f277-08deec0863e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|7416014|38070700021|6133799003|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: PpvbvV0wLxVYAkap0HIyZTt/hU1LsOh4ri4uhebPdXYC2yooJWF8+Ioo8++vMo60RJuaULwF+Qz8Pzg2SUxLA5v7XKuRPFlHCYkKrYRGhdVkkeXhNI41085uiCGtijmJO97hTIucPO9VOeYDDeHNUhmj8ArXRa0Q25lrRbo1J3BTbTvqsKhIStWUc3g4mKMTooxSmPX98tunaBXPZi4sTQWxpFmykL3HvNNdeKcR3VWlbDZnNbhjGdlbGZ+SEd0SYAxgE5SsGK9u4ggm6CgHv0SjnStxaI0qpwk/I7JkULKmNh7mNVCOCwHMaGPeem/A74zPv71OsmAzsRutVuSzRvdrT68ksfY6wqZQPU9NQ4OhO8AsItZHzAjAfAkNhk04QS4SZxNgKUGcsBYP7jsWKDrDeT/SL8dSyiiVqF57dmidBrd984ol9RqoCW4amS101FHA5mjigMyslSRyIqfuPqEW1pg8Dlb2WZJb9xMMKRskt/T+1Ra0HOnzn9xWUx9v/qBoUr094hyDqvRPeAbBpNrm1K1OU+6HZaFuR0jSsSlHRYKseTtAyIa0szbM/3Tp9kbcTzAWNX/dfM00TdqbeHXeOM9kMf+Vq4fd0uDX9Q0z6m8doO9s632WiZ7/PtYujdUNLnk8eVycvnmHQFew71jzTElL/KTR6LcdcQiMa42OZ5w3TjsvsJgyY56XfeOyyqToTUbyTMhoHARUoUVg1FVhsbPiItqtoJHmchOATbU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(7416014)(38070700021)(6133799003)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnJWRjlQM0ovZTc2RHB2dTNtcFA0dmZvQ0QrSXhLQnE3QmNiS3hSQUFWTG5Y?=
 =?utf-8?B?YkZnL1cwV1Y3Y3FjQXlBeXprZlk5QXoxem9DOWV4NmZEN0c2clpOdjF1MzN1?=
 =?utf-8?B?eEx0RmNvRCt5ZldveVo1ci83QnpmY0h1aXV5dGhka2x4UVE4TlU4b1JBOUdj?=
 =?utf-8?B?YUV2M0Jnc1FCVGhudlMwUlJuUTJ3SjM1K1BraDlkeG1CeTA4UlVGZ2NPTHVN?=
 =?utf-8?B?NkNtTXhLWWhvUzJwQXlFcTZUV1MxV3VVTXZzLzhRL1R1d284SGRGanQrS01y?=
 =?utf-8?B?N3ZqdWFKUnlXVUJtQ1ovWExyWFB2LzFJcGUvS3dLTUtValV5K0pmYWJXZVBu?=
 =?utf-8?B?N1Fqa1ZBZGhFU0JvZXJINlVhRmRmdXdZMm5BdHp6d3BKZkRMcFhubjNMSE10?=
 =?utf-8?B?RnV4OU9pNDdPV2drK2NvbVlaaUxhODd1YkpzWjdIRW5DbDBpTlhycFVjeUI0?=
 =?utf-8?B?RXp0a2hwMy9WLzh2dXRqTmRKZFdPTVRwZjVCdDZCSmRHUlZENjlESC9HYmFH?=
 =?utf-8?B?ck1zdjlNYTJRYjhjNENCclpiMFBXdTNNV2cwWHdudkwrMnFQL29QSlBmTFhE?=
 =?utf-8?B?US8wRDQvdklRTzBocmtkUVhQczlYRElxaGFmL3lEZmxvR3hpMVF1bmI0QW53?=
 =?utf-8?B?VWx1cmxyd0wyaG5OZ2trd3RMeG1uKytDYzFPYWUxNVR4MkRwQytObXYyNXV1?=
 =?utf-8?B?dmREcmFKNDhXK3lCK3BXeTdvRWlpRWFlcTZXVFJ2NHZrL0NsVG84VDJvSzdH?=
 =?utf-8?B?cTNwQ3AvOHdDcFMrQ2VrL1Nxa2h1cGdYNGp4V3BWRmhxcTV6VnkrYWdBVEN4?=
 =?utf-8?B?Wld3cmd1SVZDbDFCMVFPa3crT1BmN1dzTHhpSmRaRy9Ra3krL1lZWFZCYjdo?=
 =?utf-8?B?bHo2VW5qMGhhWFdoY25OZ3NJTHBjM0VsVVVWLzQvalR6SXhtZnplZ0cyeHAv?=
 =?utf-8?B?SDVuVE4yY2FPU0MyMlZVZEhtdEZNNHJEd0wxTGFrOEgzWU0rNE5XWnJ6Y1Z0?=
 =?utf-8?B?V2FuQmNuQk1iaUluZ2c1NUNNUzcvKzRqYytEeWRINzNXekdYMWM2cENuZ1J4?=
 =?utf-8?B?cHA4eVExY0RTcGdlSm1rcW5reXJlUDNLdEZ4a1ZlOHZmRXI4emFDdFJNUXNl?=
 =?utf-8?B?bFk0T1ZVVDhtcnIwalBFOEVNZGNJMlBNYk56OGhPWTcybE9BVGd5MFdoYXN6?=
 =?utf-8?B?SExqcHFPMnorbnBTMEFZK01xdjg3SHFlZ2ZrMHRRSTFNdkRhYUlwelpRMWEr?=
 =?utf-8?B?elRmaUFTQXNxRmNudnM1NGVRaTVXL1ZqK05hQkN3NU9YK2NrYmhNNTVrQzVr?=
 =?utf-8?B?VnN2QzJ3RWhrY0dQMUkxbkxiRmpIckMwdHlRd3Buay9sMEtTVlhqcnhOY1Ns?=
 =?utf-8?B?UkdUWkl6NHJjbFdwL3VXZVNtMWQ3ek52MFRoK1V4ZlZTbmcrR05VamVOZmhv?=
 =?utf-8?B?MlNVYlQvbG9oeW0zaS9uTGRRazdnR0E5NTlONkhkdjB4STl4d1BuVzNBYnJQ?=
 =?utf-8?B?aGpSRk1HNHhqcW5CbGxBVFJZWm1xOU5aQis3Q0d6bmN3NzBhcGlDYXBia2Jv?=
 =?utf-8?B?Rm1ORm9YSmZpaVVzQ2hyWktqVmRnUVR5LzR2MS9iVXMzOEpCZk5qYzVIaTk5?=
 =?utf-8?B?YzhiaUlCRjI0WGFRL1IyODN6MkluYmpyWGNPSldKU0R5azhWblhWZWZYUVRL?=
 =?utf-8?B?a3pFQ3ZUQjNjRXgxSmpsL2ZlSXZOcURIdnd5QnhHa1k2SGNpYm1aUy9lZzF5?=
 =?utf-8?B?U1NybDZXdktIbDFiVys5V3laT3h0cFRxZnBCbE5OTG9ISWxsRGpUd3FHbnNZ?=
 =?utf-8?B?aHIrVTdZYUFDYWMrbXFwcFBLczk5NTAyQUVLRWZ0ZlREUS9XYWVQZVBuM0c3?=
 =?utf-8?B?UjBKOTlSVWFxcTlRVUlOd2NVRXJCTkN1M1BFN0MvdjZ2aGs5Y3liSFArN29q?=
 =?utf-8?B?ekc0cEgzYzNwQVhZVVlkaW5XM1lOQmU1eDY2dzBaS2FkNHNJUVpwN2theUpp?=
 =?utf-8?B?bGhrM1hTcDVyeWh5NFpmeCs5aDRnWjRFdUM0a25jNnJ3dTNreGd5c2ZyVVBL?=
 =?utf-8?B?SkY1RW16K0hRUEt0aDBSSTJ1bU1leEM4N0NCMUJjWUJTRHczRkFLajZxUkFD?=
 =?utf-8?B?WFJlY2NBaXB0cGRPOWxTZ3hwOEdMNjFOUXd5YkN3cHFpZEoyMXVCU0E4QmlP?=
 =?utf-8?B?SlEyMXk4OGMvU2Q0dHNBdXVnZEp6aWdtYzdUQ3IvL2h0NkEvMHlWUHJNL0tv?=
 =?utf-8?B?NW9XbUFwRmFBc0VkSExRRldPeCtBcm9UQnlpS2NseU1ZMDJEaDlWMFhzMk40?=
 =?utf-8?B?S2hBWFpZUGF1MTNvUkQ0dDZhWnI3dGZ6Q05GNDZTSUJnVnFBeEZFZnRyOGJw?=
 =?utf-8?Q?xov/rvYl/0YjoCRo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C423565585A6BB42B149FC5C66B94216@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JeEcTR5CWOdj7GSantvVR+eADNjvRj3HDvvJ1pE9B69QSGFOBq96TL4HeXbjXhNBp7JM4QG2ksDb7+OGkfQNOe5MVLAuz4pvD/SK8b1lYeIrO6Ca2O/z/s/BH3fWddvCXNw9zHXWje9KuaZvMVCZsnrzeg4YbxrLxRX3XOW5/tqv6mxfc8knL4lRtAWOAWfwdRFPH2oZZXY7pU95T4si87D/JwZub5Dug/r1DrOffqEkiR87oDI1nAa3dIPaSHcfAdXB4OelDr6XoitOMZYZ3gN7GJIJ2Q0/y8z3dqh+8wq0nVcI2DBD4X3Wl+lXxS3G0SAcD+Zdb4+XjCCRvjyqpw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685047ce-2abd-47e2-f277-08deec0863e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 17:56:31.3000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JP4QlB8iRzhgu9ffnQre0/uw/xRIsSrHTfbj+C8f1V8q9SfncLWANbPD7Vlf3vD4LLPTR59ZsADxDsg1WvCKxR+uTHGXrLu4Re82adxyYDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8104
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTI3IGF0IDIwOjM4ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiBU
aGlzIGlzIG5vdCB0cnVlLiBUaGVyZSBhcmUgc29tZSBub3JtYWwgKG5vbi1leHRlbnNpb24pIFNF
QU1DQUxMcyBhbHNvIGFyZQ0KPiA+IHByZWVtcHRpYmxlIGFuZCByZXN1bWFibGUuIEZvciBleGFt
cGxlLA0KPiA+IA0KPiA+IC0gVERILlBIWU1FTS5DQUNIRS5XQg0KPiA+IC0gVERILlNZUy5ESVNB
QkxFDQo+ID4gLSBUREguTUVNLlNFUFQuQUREIHdpdGggdmVyc2lvbiAxDQo+IA0KPiBObyB0aGV5
IGFyZSBub3QgcHJlZW1wdGlibGUgYW5kIHJlc3VtYWJsZS4gVGhleSBqdXN0IGludGVudGlvbmFs
bHkNCj4geWllbGQgYW5kIGRvbid0IGhhdmUgYSBnZW5lcmljIHdheSB0byBzYXZlL3Jlc3VtZSB0
aGVpciBjb250ZXh0LiBZb3UNCj4gY2FuJ3QgcmVseSBvbiB0aGF0IHRvIGltcGxlbWVudCBjb21w
bGV4IHRhc2tzIGluIFREWCBtb2R1bGUgY29uc2lkZXJpbmcNCj4gdGhlIGNvbXBsZXhpdHkuIFRo
YXQncyB0aGUgbWFpbiByZWFzb24gd2h5IFREWCBtb2R1bGUgZXh0ZW5zaW9ucyBhcmUNCj4gbmVl
ZGVkLg0KDQpXZSBoYXZlIFJFU1VNQUJMRSBzZWFtY2FsbHMgdG9kYXkuIFRoZXkgYXJlIGd1YXJh
bnRlZWQgdG8gc2F2ZSBzdGF0ZSBhbmQgbWFrZQ0KZm9yd2FyZCBwcm9ncmVzcy4gWGlhb3lhbyBp
cyByaWdodCwgdGhpcyBpcyBub3QgYSBuZXcgY29uY2VwdCBmcm9tIHRoZSBWTU0gc2lkZS4NCkJ1
dCBhbHNvIHdoeSBoaWdobGlnaHQgdGhpcyBmb3IgdGhlIHBhdGNoIGhlcmUuIEFyZSB5b3UgdHJ5
aW5nIHRvIGV4cGxhaW4gd2h5DQpleHRlbnNpb24gaW5pdGlhbGl6YXRpb24gbmVlZHMgc29tZSBz
cGVjaWFsIHN0ZXA/DQo=
