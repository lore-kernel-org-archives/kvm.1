Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA32874F5;
	Thu, 16 Jul 2026 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784229468; cv=fail; b=DLfy5TOjw+F4f+RC3jIzRxNgRVrbp2L2nCpp3KBUJ5WhBhWz+NrHytevKQy0G079lnSqEmgTheAdURkrAQkFFRouLF1SdKtlG1Zqxabo+EwQlSyLhhE7fcRN3TOjHkaQUhmAMiVT4PPpWbq/c5lxJp9DfyTp9Wly8IyIK6neLrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784229468; c=relaxed/simple;
	bh=U2vzSUs1/HlK5Jhd1vBlHG5PsMMxDrv10F3U1u5t5ks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EEvmtIdNaYWjn0RWmHBE7WxLYkVS1PmqSOSMnC5BleiNiCIcGXsC/nflLWCyhT9DXvNnIB4uUV1h1RJ7csZlyq/2xvd7P3XqZsz2vkxMnr/Stp6CJHy8qkc7+1p9GW6AEueBPcoQFTsY8TA0Y4fQnq33HbxHL2cce8ESNgWp+Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vfp0q7Rd; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vfp0q7Rd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784229465; x=1815765465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U2vzSUs1/HlK5Jhd1vBlHG5PsMMxDrv10F3U1u5t5ks=;
  b=Vfp0q7RdOfGLldABia3JhQZcO3mVnE7Ali2U6rNzXJdWC+OyK+QMU7ID
   M9SJQ0XCZ4jIiTdQKH1v4cZMG6/ckTHTXign3CJ0udE3NQWIGU4AStq95
   K0f+TD56D7pk3GcfTmc2IiRZepgyQ61rijpTsVnq1G+y4WGI7kFyBnvjB
   Jnb2jEuIPPaZ7XJ3eqxCzDvBPx8kWHG5n7Vg0X43qR+cAlOZQCdCGVaQ/
   jVGN+JT0YakFfk2wYRGxFKy/xINQiwwaJsd17/udjLn2mDXk2JE40DBzz
   wRc2YqL7aOrwAQTpCFZsVBWdpTyWztGpDNYNcw8v0L4kDVoOr3E57MGnh
   Q==;
X-CSE-ConnectionGUID: K+8eevUvQd6erKD/Ynzx0w==
X-CSE-MsgGUID: S2rdGrmBRB2MkZrZp5J1rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84757236"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="84757236"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 12:17:45 -0700
X-CSE-ConnectionGUID: U1npDHmXS/y3BXdsUYTL4w==
X-CSE-MsgGUID: HijLDdZVTHyMylZzfZF5QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="294802187"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 12:17:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 12:17:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 12:17:44 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 12:17:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxiL4QMNNI+YOr4uexzshpl6IIV502MlXG7Ob6TIWqpRzFt00HezU9n/Ex3lHDIQs5QRLsJAsVvjKmM1M0jx0H8VQmvZp3biSiZxzW5WtON7VnaFRlasy8ScwGra4TFsaLeM2Q44WsVu+J0SVCyvUER3Qf4hAEET467zf4oMUB0afflgxg98PylFNf/DayTzqZ/0utZDSieutR8YqKjdgeRDEDzrNySxiAp31gNEnoOpeYhjjfp2cW2yaU4v2Job073ng+7GdyKzgey2HAHx3emOpfqb15TGzsCqKsHIMunwqQBMkcCyKSfhqM7uHd9Hy7X1p+a5J03JnqGJ7ycLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2vzSUs1/HlK5Jhd1vBlHG5PsMMxDrv10F3U1u5t5ks=;
 b=tOMlA7nadS3FOgT9woC1zNe9wyP2tvQm6U+EtQhxDFfT3dTF5F3jm0xrIIFMLDyjov54ash1ZX3oRVrw54sI2RHwNouWwnvM5qphvhasLRpOr6s14IjC9YsrNz0A93FJVG4vjkXQSpwMkhaaI32LavtDgysRJu5GKPJXiJqGEINsbAuVAQNUgG6dmhoUPlhFgsPpoprvub83Xy/704qwNpM/S+TutRQsiarKwbPzego/uLgKucpUC/C1y/MV1kffyLlHfb5tfbI6TSSLz/iX/mLc/8E8Tj0zb8oFSDG9QAIs4LNtiqmm6s8tnI2rMBAGG4NE9tQn2YM57lYHRtshZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA3PR11MB9063.namprd11.prod.outlook.com (2603:10b6:208:57d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 19:17:42 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 19:17:41 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "nsaenz@amazon.com" <nsaenz@amazon.com>
Subject: Re: [PATCH 11/24] KVM: Take memory protections into account in
 kvm_read/write_guest()
Thread-Topic: [PATCH 11/24] KVM: Take memory protections into account in
 kvm_read/write_guest()
Thread-Index: AQHdFVfFyr1GE4QSNUSgNATx3wqoGg==
Date: Thu, 16 Jul 2026 19:17:41 +0000
Message-ID: <509c8e8d78745c46b3f180655770a211e0132b15.camel@intel.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
	 <20260716181456.402786-12-pbonzini@redhat.com>
In-Reply-To: <20260716181456.402786-12-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA3PR11MB9063:EE_
x-ms-office365-filtering-correlation-id: 9bd9aa4d-bf66-406e-966d-08dee36ee870
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|22082099003|18002099003|11063799006|56012099006|4143699003|38070700021|10067099003;
x-microsoft-antispam-message-info: vLCHFJ2OW81HETLMaL1vf1FWaAG3lFiIswCt4kfLpuuhsRv5Z5q5rggscLH43cgz75/LNlG3HyWjsnjJJu2sumLobn2S49xM+xU+WmovKPIzZI0aj+6Ya/cajLUJlzvBglRsUcfBdZWYmO98/UTpQk2znwba0C4nS34oSnjxSuNvN0wjFybfaIRZooisMm0tPfmKVR4TFEJjUwOUwaer9WJGn+4IVxyKu36t4YZkO2y2aoHA27DlWpztU8R+HGshnmhah/vYHMYDZFcgkt0vVeblgMa6vRfr0FJKofjuEbe9ZmKQW5aTq26jpfN44Cf2IAuYsc23iJGMfgq5j9YO/UPhgEx/iF2KiPpphPSHPbJYOQ+Y07mnTwBdGO1sd37BcHkBn3kmKfn/fMlqQXQPELZWiFLxFyHetu22CmFTpn4H9c669dWen3f9PnGuMQR+xxG4ZsB3Z5JBmdYr1BVU3h3hbfZPjiUXpTNQCQzuFiFeGkHIogmxHXg7DDtUTtd1qjI55NigmA3W6pMAMCP9v/aXXNqueWNKDw8xEw7wmrRQxZGF2ZsaGArjb/RXJ9856jnUcmJWZiq+8hlREfTivdxZlRRASswoQwujY7dsw8JpAspmgJcqPjNCi0InPWqTW8NRdWPzn8tnNXdH3H94/owbDvaLC1TBTnVSWsg/FpXwy/Zv0yGsNn4XCDReLbvBCklHFYo0vOySoLoJXQkCGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWFuT045eEVUL2lGd1B6ZFQzWlFHQWMwWkFxcXIyWmgvaEt5djNDeTJHaTh6?=
 =?utf-8?B?amk5aGg1UW9wblJNS0Nqbi9sa0Z5UWQ1YVhiWC82VFNVY1E0TXQ5OHZUN0Va?=
 =?utf-8?B?S25IV3VRdmVFb0pWZnYva3FFTzZDZU91U2hXUGR0QjRFYVptMEpDeHNhc215?=
 =?utf-8?B?NWJPVElTV002dDkzZWRaWGNHVlBwczdtak1CYVRzWG14aEZoUHlwNVVEMWVM?=
 =?utf-8?B?QVZTTU1uYkI0aXRFcU5GV0VTS052UWZiV0pwMGhSdjdBeWFHVTlMSS9iVTRt?=
 =?utf-8?B?U08zOCsxRmtRZnpxUUgzOXhUbjc4QmZWZzFjQXFxRU0xZVBDK1Q2SjFtWGxT?=
 =?utf-8?B?OXhrcjhYQTFseE5IQXd6UnZXUkVERFFEcHU4VGpnbEwxdEVDWjNFbEpGV1Ay?=
 =?utf-8?B?dks3RWZ6R3NHT0NvZkNVVlRtMnIrSUpPNW15dlVkNlZvMWNBa1VwU25TS0pR?=
 =?utf-8?B?eDB0ZjhtQVRiQ1NrRHZNaG53ZHFUSjVJT2JEWmEwY3p2NkxkM1lob0lhNk9m?=
 =?utf-8?B?WFhXNkNsT2U1cmR4V2RidmJlS3BEWlp0Q2pQS2JuVnM2T3pLSUpIaVJSWnhz?=
 =?utf-8?B?MnFoVVhTZ3I3NHkvNnBVNkJnaWNNRU1iTjVISUZVZkwvZUliN0VTVHd6QVJ2?=
 =?utf-8?B?NzlZOHZaSFBhdWJDTUNZUUhmY2xzMFJGSDhTMEtXZTl2TVJpZUFRTklXNVFJ?=
 =?utf-8?B?R0pMazA1RXN2dUQ0VEM3cC9ZZ2hBTkF0MC8yNnNzWjk1WW95b1Q5bDlnc2lC?=
 =?utf-8?B?d21uWWpPMWRUSlIrQ0JINCtlQlFUSE01OGZHUzgwSFVlTlpQaVQxZnpicS9j?=
 =?utf-8?B?WC82NmZvRHpOYUlnN1RKanlIMHMrclNsRWZqZzNjWkFvaytRYUk4NFlia3Fs?=
 =?utf-8?B?R21mYzUzSWN4QjdVM0xuYmhlaTJzUjF5WnNjZ0xRLzFNVGNFbTVsdXVuYkh1?=
 =?utf-8?B?djJVMjlncFN4L2todWxCNkRWYkQ0ajI2NUxkdHBqZ2NkbU5yb05WWnFIMDNY?=
 =?utf-8?B?cE01eEhkRmx2ZjkrVWQrbUp3cy9PM3JGd2FSUFVwU0pqOEx6MHQySE9pUUp1?=
 =?utf-8?B?YjFPNEJuVWQrRW13RE9MSGxTS21QZk1GWGVBOWcyLzFNbmw1M1FPWXVLWVJ4?=
 =?utf-8?B?MkNFRDdBOEIwdm9RcXF1ZzRBRUVscXQ4ZVZwNzR2ZWVyZVZmejZtZ1dRK2g4?=
 =?utf-8?B?ZFA2SEVPbU53M0VOdzd5SU45ZzVSWkVhOHc0VlY5M01HTDlraEI3bStvRmZC?=
 =?utf-8?B?a2RSVGplNzRNdWJwbi9vR0xNR1NSUi9WUU9MOEpnMHVDMG02NG5ZZk5manRN?=
 =?utf-8?B?M3hmcWM1dThlNWlKOWNjN2wwc3pIOVhvOXdJNThFTVBZWVM2WGJrQWlxWlBy?=
 =?utf-8?B?UFFDNy95OEk4NVYrbUJybXlSenNPYUUwWWt5dDJXS21GUXNoT3JBa2J4N0ZU?=
 =?utf-8?B?L2hFdzVhMXNDWEs0OUxMaVNzc2NJUXFQY3VwSDJRUkl3SFVZVUlIOTFhQ01s?=
 =?utf-8?B?QXlPeFl0SnFZdit2SXBUd3JjanNSRHRwTko2bUcxV3JUZjRTSWpHVzJSc1Ev?=
 =?utf-8?B?UERiczF0SGNhd3RVM0svUVg4NFhrbVo1MENJY1BVVWNWYkliNUxTSjF1elNR?=
 =?utf-8?B?OVhnMURvdzgxRjAvUHE1ZHp3Ui9iNlZxaVU5VXI3aVZMTUhkanlDbk9obVJ0?=
 =?utf-8?B?ZXFFVi9zK29CeVEwazh1NXEwcDRIVnYwK1ltVTBKRGk1WTVIRzNoNllaS1Az?=
 =?utf-8?B?SHJBd1ZKQTY0STBsRXBCZ1VCMjQyMUhESlZmNG4wejFwQytpMi93S2FEU25t?=
 =?utf-8?B?cmZGZ2prS1Jna1c1dGY1MTRnMDg4L0hQcS9YRW52SWlXclpNQlJnNFAyZ1da?=
 =?utf-8?B?alBJU3dOZVRWNkswOU9BSkRoeFgvWkJMSWI1QVRtWGdvRkxwbkYxT0QrTVhZ?=
 =?utf-8?B?cm41TWlUckxUY2NRdjVma05lQjlzcDRGVjVmc0JFdDRuVkxOcE8rSU1xczZZ?=
 =?utf-8?B?WG40NHl6S0Rsd05CcTc1RnB0WGV4NGwzNzdXb0svU1ZRTExrT0VNL2ZEZ3V1?=
 =?utf-8?B?dWgrdjEySlEyZWxlc3hEVFRwY2FRYnJmY2ttbFBrVjRTTDZsMG9wZ2lZaWtJ?=
 =?utf-8?B?SzNCWm9JYU5YNmNTc3V6dWdGY2xWK2RYN3ZCRGlGcUNPREl1bHFuU2wxQklo?=
 =?utf-8?B?SnRWcjRNbyt0Nnp4bFg5QnAwUThzQ0lGNWtqSXRHbzJTY1Nja3hTa09nQWZn?=
 =?utf-8?B?WXIzTkR0V2NoT29GUGdIVW5lL0JHTU5Db3hwdFI5ajFCT1FCMUlVN1g4OUln?=
 =?utf-8?B?SmVTVDRhaXFNNkNrWWNXVm45bTA5Z29sWit1d0RKbkh6cUwyaUVWNW1GQ1p2?=
 =?utf-8?Q?rUxf/zD0Khsg8fKc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FF381DA68B0764E867D8A6851970C81@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bPZk5usircts/t27Rfpo8jZIuOn/iKDSOvk/bc0trLQWSKR/+9SmbQH6G8Bk6DkPgUpqwn2ncB/w4ZoB4aSPc185DT9F+wbtG1B4CrCy58Lr02wD31DNUvAEnpToTAmDqJj0y32zjs0rt5NTuf8RQaX5383lTOjGC5iFX/xX9MO58qaS82eWnww+v3+W8qZMwlGg/NEU2d0IvRXMdOcnICuWwEyVew2Qq2MZHo8dUpc1ChpRUDSEohd4E7sPXJ3TPQwYax0WSCu3XPS03H9JhOAydV52LnzciiBo8ft+Dlyztxy7aWR/R2UxmAmGSQnxY/SMOtej1e39ibWQ03Q4SQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd9aa4d-bf66-406e-966d-08dee36ee870
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 19:17:41.8737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNP8iyE9tDdemU0MUeT8ORSKNhHewdqqmotE2dFMd+XN3L+PoWqgBzj/elI/pNmzXOT8cv8VZhqCEByFT+uEKrybffa7Tho5/BOQlxxehmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9063
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA3LTE2IGF0IDE0OjE0IC0wNDAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBAQCAtMzI2MSw2ICszMjYxLDEwIEBAIHN0YXRpYyBpbnQgX19rdm1fcmVhZF9ndWVzdF9wYWdl
KHN0cnVjdCBrdm1fbWVtb3J5X3Nsb3QgKnNsb3QsIGdmbl90IGdmbiwNCj4gwqAJYWRkciA9IGdm
bl90b19odmFfbWVtc2xvdF9wcm90KHNsb3QsIGdmbiwgTlVMTCk7DQo+IMKgCWlmIChrdm1faXNf
ZXJyb3JfaHZhKGFkZHIpKQ0KPiDCoAkJcmV0dXJuIC1FRkFVTFQ7DQo+ICsNCj4gKwlpZiAoIWt2
bV9tZW1fYXR0cmlidXRlc19tYXlfcmVhZF9nZm4oa3ZtLCBnZm4pKQ0KPiArCQlyZXR1cm4gLUVG
QVVMVDsNCj4gKw0KPiDCoAlyID0gX19jb3B5X2Zyb21fdXNlcihkYXRhLCAodm9pZCBfX3VzZXIg
KilhZGRyICsgb2Zmc2V0LCBsZW4pOw0KPiDCoAlpZiAocikNCj4gwqAJCXJldHVybiAtRUZBVUxU
Ow0KDQpTaW5jZSB0aGUgZW11bGF0ZSBrdm1fZmV0Y2hfZ3Vlc3RfdmlydCgpIHBhdGggZW5kcyB1
cCBjYWxsaW5nIHRoaXMsIHByb2JhYmx5DQpzb21ld2hlcmUgdGhlIGV4ZWN1dGUgYXR0cmlidXRl
IG5lZWRzIHRvIGJlIGNoZWNrZWQgdG9vLiBJIGRvbid0IGtub3cgaG93IG11Y2gNCm9mIGEgY29u
Y2VybiBpdCBpcyBpbiBwcmFjdGljZS4NCg==
