Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BADE1DFF0;
	Wed, 23 Sep 2026 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121754; cv=fail; b=M8erHcElgFwWY3i/JCl/xodaqbcOmEd6cJ+1IUG5J8L+Sm6/7tjXKHtTDfgvQU7EFe0k/GqpFMlIfyf2FAuQnOsisJif2gAUaXcZJ+R9L6ENzhPWxNZKeCE1WQBXRUIqAGMRVm+LOyJ62YyttaNqo3VCRr+ScF4mJeEeCm8saUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121754; c=relaxed/simple;
	bh=Z6TgGix8Q2ZtzppmfQ+rj6E8hM7aS2kZDiDGyF8Spco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LmCH8lsObu40fp477G+Pg/FpzGc6lFMNQvWok8Vg4jcXtQloc06b8piBjR5X1q9MCsTvftK5vX7/BewPgLMVluuqgxZ9NUR2NPWhGf7BVrrxAoWd4ISzYUR3rgcaA7fpt8vDt02ssS6z2yxRK/uqqVgXVtbJOh3yx5asqkSrS00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/CTjnCL; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/CTjnCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790121753; x=1821657753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z6TgGix8Q2ZtzppmfQ+rj6E8hM7aS2kZDiDGyF8Spco=;
  b=e/CTjnCLuYsiKeuLKuoEwezNoBNnw3NRkdTt60zin/l+oP56W2rrJgqn
   U891wXXC4JZED2yeLsfb17w7LeEKSULqPzla5z36bsmMfPrUuGkmWWDGw
   4px9rVRhhl+ShAQOQqMJDdsqtTp2IH/MNnonTBXeonSHQ0f8MA+qSNFhs
   M7T0+9q2a5Cr1xAtqpbgfLnckcOgZ7bqBdO4OI6CIXE/zspzaz/T91RLW
   ubonGDSNngqx4Spw3JMowxAHyfzwQG5kcprlrYBp/p+FaKpne7Xjh/vqL
   zfZb7T/vzHj7vBaS0gl3AspyniGA/r805GKPAq25LzeeWmF+JFelni18p
   A==;
X-CSE-ConnectionGUID: 79XFSGftQUmXMNSQf76SkQ==
X-CSE-MsgGUID: xU4rzHQvT3aR/Lx1uEzzTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1270484"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="1270484"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:02:32 -0700
X-CSE-ConnectionGUID: 0Po3uIWKRVW7WZQ6kYjk0g==
X-CSE-MsgGUID: 0GZ/EEsnQIyTFED4rupaZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="272853850"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:02:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:02:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 17:02:30 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:02:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOp7W3cLAvamlidleJ2WJMZ4nUOfRgbDJNmXo20bMUGuz8qOugxvQXfDsemdZpRIU100IUjcchTwPt6VZaXewwOQ5NgSkOS/7yDu/UwSu8yKbjWvgYcyf0t5qgBhAQWjVJfdurEVFrKUtC/qKPbqqOHjzRpEQbI1qwYYJHHM2yD65B5+5V9+0BDLyqZNwV85AkJL2IC/0jyhnB/YVpNUpwtWKwwMV4xyOM3P9uP/ymG2VSB3vkzMjizTXw3HAsxxz8Vi/8p8jFZRwDrjej/wl/8UXdv7dOaDcRcmB836IcZ6K8nyQA6Q66D9gz+uIVMBbT/TxKhk+v1lGUZLuKxt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6TgGix8Q2ZtzppmfQ+rj6E8hM7aS2kZDiDGyF8Spco=;
 b=EkQMYC0QAccwrzDqqP5+YG7/puNhMU/Q4D2zOtBMtl0XJ0TyRfallNPZHE9G9gJujOKCx0pUyV6xofKSDqQrY6v4YV8jUq6uvAz5CgruIx4cA3VGGDmg3E3a5Hqux9hhouqktiAMnTimy3TgdVJz/+8+YE/U10bgCN8dj/wcx2k3u1YvgNkxyt89pMvRzMLVabGqQ14zKomLS0XNklaR4NMDEaxNcP5UWl/C1dSsxzgWriyVaDlhp82K+vHGZ/xBNm+YjvJkZTUdijZ/J27T+LyzPCeoDUrl59CvCnWKJwrP+hc4Qv/vFIV7u7rDupGeaQ+9yzyG6fxTZ2t7MMh7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA0PR11MB7955.namprd11.prod.outlook.com (2603:10b6:208:3dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 00:01:56 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 00:01:55 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
Thread-Topic: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Thread-Index: AQHdRnUxZ7ir+OFvoU2rBazg3q+3u7bbUJEA
Date: Wed, 23 Sep 2026 00:01:55 +0000
Message-ID: <a8ce5d830a04d99ec47cdc727e1761bd4031d544.camel@intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
	 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
In-Reply-To: <20260917072548.2314491-2-binbin.wu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA0PR11MB7955:EE_
x-ms-office365-filtering-correlation-id: c3ea982c-6056-4921-0624-08df1905e180
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|5023799004|4143699003|38070700021;
x-microsoft-antispam-message-info: dZwi+yRat4xvc5VwPuym3VPk6ZPcwG2esZTo0b4I1SB8rZuoLQ2SLpEZCG6RnVPE1Pc41HMCy+EujXucMx+aaFn2SRpmq4aQqakByq9Fi1xu5EH69uhUgmUSP+8ob0rpwtFmM2SLQ1uEK/HTd/mITOYTW1DfXz4USq2CkWM3fkE8O30YhV2BGreH+IW/8g5EZCWcH03ZX+oo6vmvyj6QGSYaGupvbhwVIFSNc7wonba3IP3ksZzO2yyVSgTqs54sWtJ5BW2lQq+1HM0RhA2UFoMktqrCgJepwtAXD28TGy2WY42XTN++o0z43yTo5lgguURKS7kXuucmDC30tdJF7LooVpmn89dke+I12pcoKI7ukkJcPR0SRCDnwoicOWu0HCWrMRFMh4oDAYN7Aq/5Hbx6lwTQd7XiX5ZXJ/BDSTTv0thAjq9ioUhmkrZJ7OOs/fzYm3ISNDV3F//ahkI3yiufNxerLVRK5xz7qe5/HP925G+/AfBNNWkEfbbUIzMv6SZdaI91KAMztvVYhCMUBOMF/mrf8TEgeqlgVCx6Yt9+JVngy/2dgctxhtm6Hi+WFbh+l4xfQRuJsZ7AJc1DipWx2i2kSCOsfw4LAI+iubT5xj5ORFgz1ZcnTwDizYKE/ecI/jb2srdzGIiGUT77oOQbDjWWGAHLf8VBJExIBQaoWfjWrUjTu+SUJYBHc0VPCxcdlbmu26tglvez4+RExeAigNsxDxKjPr568diiCOw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qy9KRWRNMVgxR0YwK29mQ0dDM1k3Kyt6dTJEa1c2ZFdxWEhmcmlwWkRKbnBU?=
 =?utf-8?B?Z1RYMVFWN3Zad1lLT1g2QVprSnlDOFU0Uk1RMDZLSmV5YVZxKzNuSGNWV1dr?=
 =?utf-8?B?YytveS9WdWwxSmUvbi9ENnNwMEJ3Ym9MRFNVeENMUGpyOWlRRURuTkdPZjBZ?=
 =?utf-8?B?VnFPZVVQMmRVUGRjdElxRWUxa2M1V2k5SVBHc01nUDFTbUhrbDJlazU3QWpR?=
 =?utf-8?B?cFptSlBaV0txeStTMWM2SE4vNUdtWFpwRVh4bWRBYWt1VlVaYk01bC9JQXdL?=
 =?utf-8?B?bGdNOFh6dmJYcG4vT0JEL05JTTg5cHluSXhmQzhYVjlveS9mRzZPK2QweWkz?=
 =?utf-8?B?UXVCUWNKTjN1S05mbW5KNWVabXZUOU5yY3NtbkkzbGUyc2RXWlptRHZkRU5n?=
 =?utf-8?B?dllONmppMkNodU5WbmJXcUJkTnRYMnJZRGdTYzFjUkRtNUxLTGN6d3hQRXQy?=
 =?utf-8?B?K05xMUVSVVhvVzdJcm91R2ZIb2Fhc1VqVEZWYTlYQVpqVVlaZWZBdmtxMVJN?=
 =?utf-8?B?OTVXK2tTZmpFN1ZhR09aY3lmSUczZUtCZ2svZ1d1cFdGbSs2Y0RRR1dwaGVt?=
 =?utf-8?B?QmZJNVpjbnk2RnRWcDBLcnd4c3g3bUZTUVRqSVZVTW1VOVFvcnQ3THdxK1Ix?=
 =?utf-8?B?YlkvbGk4VFpoOUJ1Nk1aLzhSc3ZYQjVSR09ab3pxQm55Q2NUNWlEVkJpampG?=
 =?utf-8?B?dEJ5OUZyM1pxZ1dqVWFiaTNpUndwcFZVT2lVRFludHVnbFVwd0ZPT2p4RTJ5?=
 =?utf-8?B?VmRDTXFlckRyQ202WmE4b3BGUWM2UHlxRUx4TXNFancrM01YQ3JqbkhVWTkr?=
 =?utf-8?B?MzFmUFBkSktyQk9ING54QzZJODJVNDhLQXFkbytkK0pQWXhXMm42MzVLbG1K?=
 =?utf-8?B?bWFRTVdwSXpwaEcyMnVrUXhraW5nQk8vQytQcnBVR2UraVJEZjQyV0g1Sy9E?=
 =?utf-8?B?N3FhVm1GMW1UNVp0bWU4Q3J5QU1uYWlJOW9vdmNyNm9YWXFZOXFSemcrL3RC?=
 =?utf-8?B?c21HUFg4RFlCUjM0OWdVOTcwTXdRZEVaWG9ISXVWbnNHQXpSZCtnL1RVeTJH?=
 =?utf-8?B?azJ1RDUxa2xqU3NCVjlhaTFrSnFaMDFVVVhSaHYxSWtWZGJLcWxLQitFUERq?=
 =?utf-8?B?NDQ4RExPeDhHbGs4b3ZtdGFnNkNlT3d4N1dvQlh5OGU4QXhReFE1SjlXeW5k?=
 =?utf-8?B?eFY3TDlRdE1NVklpekFHY2xCNVZkb1lGQUpRMVM3dVNGMkY5eFBMNGVybEl4?=
 =?utf-8?B?cmV3c1hoa01RalYxa3NqbEQ1Qm02bGZ2Zm50L2hUZ2JlL0ZpeGhKVDRWK3RF?=
 =?utf-8?B?MWF4aFNsUEg4blpNRlpCbXM4TFl6YUx3MDczOUNDSDlSZ3BZS3FXb2REdUdS?=
 =?utf-8?B?Nll0dUZ4K0lYbU5RajRDM0RBTy90enpEeC9Pdjdud3R3TU9iWXhLWDRzRGNQ?=
 =?utf-8?B?OVQ3WjVNTFdzZlFtTmtleFEwQW5JbEpYY3NpTEplMmQxdFAveGo4czB5U1Zi?=
 =?utf-8?B?U2VmWFhSU3lnS2VVQ2Q5dlZzVWtGa1EwVk1kTGE5V2hmQk5tY3YvVXZSbTBk?=
 =?utf-8?B?RTh1RzJ5NXdnSElmYUM5TnMvM1ZTY2hqSUdycVpOK1lwN24yOUJ5WktjaHZ6?=
 =?utf-8?B?MmlkbW5Ccm85azRzRTV6QkNQQ3RPQUx3MTZlNFdIOFJzTW9IYS83RjZMalV3?=
 =?utf-8?B?U1IvNDNFTWNwTWYwUCtLeHZTODJUNm1LR0tyWEtlcllaNEprWHduTW9Ic1Q5?=
 =?utf-8?B?VVRiYjdRZHlGYkt4ZDlZM3NINllWUVlrd3oyem83RjFJekN4bDh5cXRrMnlv?=
 =?utf-8?B?WFNxQVdpVVM4anFUeGRNWllXbDFXTk95UlpwVHN5TG50V1NkanZhQko0OVVp?=
 =?utf-8?B?eUlVRXQ3L0dCR2NuT0ZrSE41QU9KWDhkMTZhOU5EQ21EcFZ4Smd0SUV4bThq?=
 =?utf-8?B?NC85SktVSU9oUnVDbW9NNHVWcWFJeG5KWmVUQmVlR0hDTVZ5Wnh5OVhSUHVS?=
 =?utf-8?B?MXhKbTFSN0x4Y0tuRCtGNVI0RFN5d1pkVUkzTythWEVJNmlsYitZRmx1TDc3?=
 =?utf-8?B?RVJaRTlKdEVOYVd0SXhKbDAwVXdUWGJ4RlhYR3c2ZEZhcEN4V1o1NTlpd3p0?=
 =?utf-8?B?Z0k0VnpwdllxQVQrZ1h6VEVvNzNOOUh0MTR1c0RheEJla3JoMnVybmNUV3JQ?=
 =?utf-8?B?K1phY2I5bCtnUDJvYVhnaHpoY3EzYVhQS3pBRTlLUk0xa28yY211a0pxTHQr?=
 =?utf-8?B?RmRuQ2lRS0k1bTVCVTQ5cFRKOHdPa1lUa0R0cDdHa29GZFJXZlNDMDNIajdt?=
 =?utf-8?B?ckJFb1NUdUhYUklockVlUmErZy9hVTBEU21zb0tlUHlIdXZoTHUvMlVzQkVC?=
 =?utf-8?Q?pqrnulf/omPiZ5PI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76135CA951BA0E4D95822E61BF5BA418@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dJcCyCmQwUd9KkHvN8mJOohD658xur97RwFRvxUSL6Z+Bn1DGmaDlOjfB/e5AJ/B+iXv+ShczJMwR/8XSrYfbavkJHwttdMQFhSUn8IM0JxKcwJmHMYkk1Lzc9BTlEX9TUSolZCT+x7c4RmebsRucrzx4jyae2yePdmhA318EASJNdK+1XfNqUhacdBgwbeHNYGmAX0SV/Z6Spq01KWTIHEy+NKRYzUKCLI0iOlVcQEyVrHdlVOUbOJ7KaNTx6n+NdHzLgmlTum2lkMuNxZYc60CyuaN5E/kZT6Qx/J7OhRiTigb6Z3e15Znc77IwbkwCf7P8wE8tcJEapSXDTAXgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ea982c-6056-4921-0624-08df1905e180
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 00:01:55.8545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxevKi2oWcYzKpousaw1WjKGEXySBIaSOy8Cy0oeBXi6tb8Fejq48dtdpBEuwkjYS34wHyNIVAkA2VEj9N02GnZfzIzdV05a1ipNL33Dwfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7955
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTE3IGF0IDE1OjI1ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IEFk
ZCB0ZHhfY3B1X2NmZ19jYXBzW10gdG8gdHJhY2sgdGhlIHN1YnNldCBvZiBURFggZGlyZWN0bHkg
Y29uZmlndXJhYmxlDQo+IENQVUlEIGZlYXR1cmUgYml0cyB0aGF0IEtWTSBzdXBwb3J0cywgYW5k
IGJ1aWxkIHRoZSBtYXNrcyBkdXJpbmcgVERYDQo+IGhhcmR3YXJlIHNldHVwIHZpYSB0ZHhfaW5p
dGlhbGl6ZV9jcHVfY2ZnX2NhcHMoKS4NCj4gDQo+IFRoZSBURFggbW9kdWxlIHJlcG9ydHMgdGhl
IENQVUlEIGJpdHMgdGhhdCB0aGUgVk1NIGNhbiBkaXJlY3RseSBjb25maWd1cmUNCj4gZm9yIGEg
VEQsIGJ1dCBLVk0gY2Fubm90IGJsaW5kbHkgZXhwb3NlIGFsbCByZXBvcnRlZCBiaXRzIHRvIHVz
ZXJzcGFjZS4NCj4gQ2VydGFpbiBmZWF0dXJlcyBpbXBseSBhZGRpdGlvbmFsIGFyY2hpdGVjdHVy
YWwgc3RhdGUsIGUuZy4gb25lIG9yIG1vcmUNCj4gTVNScywgdGhhdCBLVk0gbXVzdCBleHBsaWNp
dGx5IG1hbmFnZSBhY3Jvc3MgaG9zdC9ndWVzdCB0cmFuc2l0aW9ucyB0bw0KPiBwcmV2ZW50IGhv
c3Qgc3RhdGUgY29ycnVwdGlvbi7CoCBUaGUgZXhpc3RpbmcgaGFyZGNvZGVkIGRlbnlsaXN0IGNh
bm5vdA0KPiBhY2NvdW50IGZvciBuZXcgaG9zdCBzdGF0ZSBjbG9iYmVyaW5nIGZlYXR1cmVzIGlu
dHJvZHVjZWQgYnkgZnV0dXJlIFREWA0KPiBtb2R1bGVzLg0KPiANCj4gRXhjZXB0IGZvciBhIGZl
dyBmaXhlZC0xIGJpdHMgcmVxdWlyZWQgZm9yIGJhc2ljIFREWCBzdXBwb3J0LCBob3N0IHN0YXRl
DQo+IGNsb2JiZXJpbmcgZmVhdHVyZXMgYXJlIGVpdGhlciBkaXJlY3RseSBjb25maWd1cmFibGUg
b3IgZ2F0ZWQgYnkgVEQNCj4gQVRUUklCVVRFUy9YRkFNLCB3aGljaCBLVk0gYWxyZWFkeSB2YWxp
ZGF0ZXMuwqAgVHJhY2tpbmcgb25seSB0aGUgZGlyZWN0bHkNCj4gY29uZmlndXJhYmxlIGJpdHMg
dG8gYnVpbGQgYW4gYWxsb3dsaXN0IGlzIHRoZXJlZm9yZSBzdWZmaWNpZW50Lg0KPiANCj4gT3Jn
YW5pemUgdGR4X2NwdV9jZmdfY2Fwc1tdIGZvbGxvd2luZyBrdm1fY3B1X2NhcHNbXSBzbyB0aGF0
IHRoZSBtYXNrcyBjYW4NCj4gYmUgYnVpbHQgd2l0aCBzaW1pbGFyIGZlYXR1cmUtbmFtZSBiYXNl
ZCBpbml0aWFsaXplcnMuwqAgRGlyZWN0bHkNCj4gY29uZmlndXJhYmxlIG5vbi1mZWF0dXJlIGJp
dHMgd2lsbCBiZSBoYW5kbGVkIHNlcGFyYXRlbHkuDQo+IA0KPiBUaGUgYWxsb3dsaXN0IGlzIHBy
ZXBhcmVkIHRvIGJlIGNvbnN1bWVkIGJ5IGxhdGVyIHBhdGNoZXMgdG8gZmlsdGVyDQo+IEtWTV9U
RFhfQ0FQQUJJTElUSUVTIGFuZCB0byByZWplY3QgdW5zdXBwb3J0ZWQgQ1BVSUQgaW5wdXQgdG8N
Cj4gS1ZNX1REWF9JTklUX1ZNLCBzbyB0aGF0IG5ld2x5IGludHJvZHVjZWQgVERYIGRpcmVjdGx5
IGNvbmZpZ3VyYWJsZSBDUFVJRA0KPiBmZWF0dXJlIGJpdHMgc3RheSBoaWRkZW4gZnJvbSB1c2Vy
c3BhY2UgdW50aWwgS1ZNIGV4cGxpY2l0bHkgb3B0cyBpbi4NCj4gDQo+IEJ5IGRlZmF1bHQsIGlu
dGVyc2VjdCB0aGUgYWxsb3dsaXN0IHdpdGgga3ZtX2NwdV9jYXBzW10gdmlhIFREWF9DRkdfRigp
Lg0KPiBSZXF1aXJpbmcgc3VwcG9ydCBmb3Igbm9uLVREWCBWTXMgYXZvaWRzIGNvbW1pdHRpbmcg
dG8gVERYLXNwZWNpZmljDQo+IGJlaGF2aW9yIGJlZm9yZSBnZW5lcmFsIEtWTSBzdXBwb3J0IGlz
IGVzdGFibGlzaGVkLCBhbmQgcmVzcGVjdHMgS1ZNJ3MNCj4gbG9naWMgYXJvdW5kIGRpc2FibGlu
ZyBjZXJ0YWluIGZlYXR1cmVzLCBzaW5jZSB0aGUgcmVhc29ucyBmb3IgZGlzYWJsaW5nDQo+IHRo
ZW0gY291bGQgYXBwbHkgdG8gVERYIGFzIHdlbGwuwqAgQWxsb3cgZXhjZXB0aW9ucyB0aHJvdWdo
DQo+IFREWF9DRkdfRVhUUkFfRigpIG9ubHkgd2l0aCBzdWZmaWNpZW50IGp1c3RpZmljYXRpb24u
DQo+IA0KPiBBZGQgY29tbWVudHMgYXMgcGxhY2Vob2xkZXJzIGZvciBITEUsIFJUTSwgV0FJVFBL
RyBhbmQgRlJFRCwgd2hpY2ggS1ZNDQo+IGRvZXNuJ3Qgc3VwcG9ydCBmb3IgVERYIHlldC4NCj4g
DQo+IEFsbG93IE1XQUlULCBYVFBSLCBhbmQgSFQgdGhyb3VnaCBURFhfQ0ZHX0VYVFJBX0YoKSwg
YXMgdGhlc2UgYml0cyBhcmUNCj4gbm90IGFkdmVydGlzZWQgaW4ga3ZtX2NwdV9jYXBzW10uwqAg
VGhlIHJlbWFpbmluZyBkaXJlY3RseSBjb25maWd1cmFibGUNCj4gZmVhdHVyZSBiaXRzIG91dHNp
ZGUga3ZtX2NwdV9jYXBzW10gYXJlIGxlZnQgb3V0IG9mIHRoZSBhbGxvd2xpc3Q6DQo+IA0KPiDC
oCAtIEZlYXR1cmVzIGZvcmNlZCB0byB6ZXJvIHdoZW4gI1ZFIGlzIHJlZHVjZWQsDQo+IA0KDQpT
b3JyeSwgSSdtIG5vdCBmb2xsb3dpbmcgdGhpcyBsb2dpYyBleGFjdGx5LiBUaGUgZ3Vlc3QgY2Fu
IGNvbnRyb2wgaXQncyBvd24gdmlldw0Kb2YgQ1BVSUQuIFdoeSBkbyB3ZSBuZWVkIHRvIGZpbHRl
ciB0aGUgaG9zdCBzZXR0aW5nIHRoZW0gdmlhIGRpcmVjdA0KY29uZmlndXJhdGlvbiwganVzdCBi
ZWNhdXNlIHRoZSBndWVzdCBjYW4gY2hhbmdlIGl0J3MgdmlldyB0byBleGNsdWRlIHRoZW0/DQoN
Cj4gIG9yIGxhY2tpbmcgS1ZNIHN1cHBvcnQNCj4gwqDCoMKgIGZvciB0aGUgYXNzb2NpYXRlZCBN
U1JzOiBFU1QsIFRNMiwgU0RCRywgRENBLCBBQ1BJLCBBQ0MgKFRNKSwgUkRUX0EsDQo+IMKgwqDC
oCBSRFRfTSwgVE1FLCBQQ09ORklHLCBhbmQgQ09SRV9DQVBBQklMSVRJRVMuwqAgSGFuZGxlIENP
UkVfQ0FQQUJJTElUSUVTDQo+IMKgwqDCoCBpbiBhIHN1YnNlcXVlbnQgcGF0Y2guDQo+IA0KPiDC
oCAtIEZlYXR1cmVzIHRpZWQgdG8gSUEzMl9NSVNDX0VOQUJMRSBiaXRzIHRoYXQgYSBURCBjYW5u
b3Qgc2V0IHdoZW4NCj4gwqDCoMKgIFREQ1MuVERfQ1RMUy5SRURVQ0VfVkUgaXMgc2V0OiBDSUQg
YW5kIFBCRS4NCj4gDQo+IMKgIC0gRmVhdHVyZXMgdGhhdCBjYW4gY2xvYmJlciBob3N0IHN0YXRl
IGFuZCBsYWNrIEtWTSBzdXBwb3J0IGZvciBURFg6DQo+IMKgwqDCoCBGUkVELg0KDQpJIHRoaW5r
IHdlIGNhbid0IHNheSB0aGlzIHF1aXRlIHlldC4gVGhlIGFyY2ggaXNuJ3QgZmluYWxpemVkLg0K
DQo+IA0KPiDCoCAtIFVuc3VwcG9ydGVkIGZlYXR1cmVzOiBQUkVGRVRDSFdUMSAoWGVvbiBQaGkg
b25seSksIFBTTiAoYWJzZW50IGZyb20NCj4gwqDCoMKgIFREWC1jYXBhYmxlIENQVXMpLCBBTVgt
VFJBTlNQT1NFIChuZXZlciBpbXBsZW1lbnRlZCBvbiBhbiBJbnRlbA0KPiDCoMKgwqAgcGxhdGZv
cm0pLCBhbmQgUkFPX0lOVCAoZGVmaW5lZCBvbmx5IGZvciBmdXR1cmUgcHJvY2Vzc29ycykuDQo+
IA0KPiBGaWx0ZXJpbmcgS1ZNX1REWF9DQVBBQklMSVRJRVMgaW4gYSBzdWJzZXF1ZW50IHBhdGNo
IHdpbGwgaW50ZW50aW9uYWxseQ0KDQpOaXQ6ICJwYXRjaCIgLT4gImNoYW5nZSINCg0KVGhpcyBp
cyBkcmlsbGVkIGludG8gbXkgaGVhZCB3b3JraW5nIG9uIHRoZSB0aXAgc2lkZS4gSSdtIG5vdCBz
dXJlIGlmIFNlYW4gaGFzDQp0aGUgc2FtZSBhbGxlcmd5IHRob3VnaC4NCg0KPiBzdG9wIGFkdmVy
dGlzaW5nIHRoZSBleGNsdWRlZCBiaXRzIGFzIGNvbmZpZ3VyYWJsZSwgYXMgdGhlIGNvcnJlc3Bv
bmRpbmcNCj4gZmVhdHVyZXMgYXJlIHVuc3VwcG9ydGVkIG9yIGNhbm5vdCBiZSBwcm9wZXJseSB2
aXJ0dWFsaXplZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpbmJpbiBXdSA8YmluYmluLnd1QGxp
bnV4LmludGVsLmNvbT4NCg0KT3ZlcmFsbCBpdCBsb29rcyB2ZXJ5IGdvb2QgdG8gbWUuDQo=
