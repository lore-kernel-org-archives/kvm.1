Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ACD3BD651;
	Thu, 13 Aug 2026 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786662326; cv=fail; b=dg43lganOR37sDYNfDvpBG6aOXFPyhSC41dmRgl2jUQRcwNywudf6YgL9rdEE3J0CGdQL3vg7YAWZxftlLqrfLmFyFBsbnP+Jy6pdcx8aZOGtkl7XKPtjSrzhMxbDwO8up1nmOuyftv88HYXyBTBvSzBouBYRlVZwQWvK2LcCJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786662326; c=relaxed/simple;
	bh=YoN2bfKZ1Zl1TGtbCw71X/bhigmBp2vUOfomx5MJaYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mnZXQejfA5KTtDhnFHhVMSAIOe4AurdyVHYQ95BQgWxv7sf2sy//sKw0JoVtN6Rtn/3hAmJnN9BsoAbUg/udGRad8S2HqsQFPt6I/ZtXtkYrTR/Fvz3GaHicxsXVvjaeZqxm3fjhwkai46E2Ya4qICbF2Zmp3mN20uvkhIjwG/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlD30eaj; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlD30eaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786662324; x=1818198324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YoN2bfKZ1Zl1TGtbCw71X/bhigmBp2vUOfomx5MJaYw=;
  b=mlD30eajazYk/aSyltZSlHCW4/pNJLNh9gBUpDpNEtjy1iY0DFp+Qiyy
   E6Mx2rixOz6h4wt/hkLE9Zt6vWXosqWUsu+sjU16aD55QC9xf/TI9yKGT
   Sk9xldwlzTLV1Oz2E7ELzKuZ61yOOMVga5CXJYPU00SYLQMOKDUrd0kys
   W+6Y5MbBm3TXu/bTl6lTltIGUCNCYCA6mvee7ufC/LrPtRrHrtD10Evx/
   fMFfhG3tqUjZd6rbuElLGp7mJTBWlf2WdLLXJXop/KWZ5q9Nx1sZExqaj
   pKERfxA9NGXSHL5RfQ851BB4HXKbSqMk5ouOlf6wEmE2f88OtvZjkXn2z
   Q==;
X-CSE-ConnectionGUID: s8AY6pSoRSmi5hRM/KFmOg==
X-CSE-MsgGUID: QfhdkQLvTs23PfTtlxe0wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="91121160"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="91121160"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 16:05:23 -0700
X-CSE-ConnectionGUID: GLXhB5vDTHeue3M+okSJlg==
X-CSE-MsgGUID: W0wwKNkAStGMfPbQAI57cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260798621"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 16:05:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 16:05:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 16:05:23 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 16:05:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUyxNHkCo0mUUPPIl46bwJB5Uywl/4NsdTGtIVpvL3WhgSpzma8s3hbT2GO7XfEiuSe0U4n9Pp1/pvA04cBvSO/y4zc48LUNFKkfn1/2BvyewgXY1PGZxuZADaGMe84Fnn0at5Cblnl1N+Sabl+tM7qLDlYsCKSKyOVcM/h8F/xo6VR77+rLzzW6fjadMcaEVgOG1CQzGvdIPmvSAONHzVQS8cKmx/qTb3D8pEOsAJhjqkjP+oHIVJgyVG6ES4xDDLMVIsTfX5iDfg50neKSbo4a16/Fv6nz1i+ib7uv/Zrb6RToShuUadXpzH57G9Lsaxy5m1N9Qlhsma5WSxMK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoN2bfKZ1Zl1TGtbCw71X/bhigmBp2vUOfomx5MJaYw=;
 b=mmfCwdHSIezabmbQhUsjDbrKpBMTzagRpcSaDGy+hX8TyiqOVpfSTB7dMTzlM75ZA5vysIkJtukaalawHMucfh+HyN1Xsp3SW+XGPQnwXzb/4XHX4TKvCT6j0P/Tr/mTme8Zs9xlIueZkFYAba6372mAXY3y3XL2/gOzFELog3uctnV37mD3szgNI/nI2NgxEW1FXjkF/l238lcL9RlnnfwGNNMut0wtnEXiZAUOXirjdqfOr/KpRB+rFdzjq4djJ/InJv5kpnOfIkIcDJNFT3aU8RTdyDiFDszUfPxEBY/dQI8KpoolmQR0Km1gcEoj9TaA8/k2Lv+kKMYmqWmtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA4PR11MB9154.namprd11.prod.outlook.com (2603:10b6:208:55e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 23:05:17 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 23:05:17 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Aktas, Erdem" <erdemaktas@google.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"afranji@google.com" <afranji@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "seanjc@google.com"
	<seanjc@google.com>, "pratikrajesh.sampat@amd.com"
	<pratikrajesh.sampat@amd.com>, "oupton@kernel.org" <oupton@kernel.org>,
	"wyihan@google.com" <wyihan@google.com>, "sagis@google.com"
	<sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>, "Wang, Roger"
	<runanwang@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 00/22] TDX KVM selftests
Thread-Topic: [PATCH v14 00/22] TDX KVM selftests
Thread-Index: AQHdGi/fD3HeSKoX5UGSIW2nqtNBd7actxyAgAAE64A=
Date: Thu, 13 Aug 2026 23:05:17 +0000
Message-ID: <4828f8e29801adb29a4d48b8980d3b3a0a813e06.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
	 <5a44a6925715e1edbd379ac0ea5526ec990eb819.camel@intel.com>
In-Reply-To: <5a44a6925715e1edbd379ac0ea5526ec990eb819.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA4PR11MB9154:EE_
x-ms-office365-filtering-correlation-id: ec7463fa-9343-4a10-1b53-08def98f5756
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|38070700021|921020|6133799003|11063799006|10067099003|5023799004|4143699003|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: lirL6r28UdZoGDx4et7CXNYmS10bQQPRNLf5PIVH+D9Cg88e891flbFFiUYuHw4B1Pq+qhuyWyNAIB5Tz51KevfDhqMTYRPwiWCyEAOOe9eQicLcwlpCdRCMGAvFxX2X6QWnZ3WmEoYGo8IeS1S30iayFU6MJ3Lugfw6yCs7EIS3THxtMb2Jl+h4rmxKoeDnlshdr7vq6539ANcEVywK+waGvJy1TWeGtgycdoXSROwRTvU9UUUouw6wRY7yQJ36PcqeqlDKi/dLQ4RSboZkmdI5Pl1Aqf1PvZ65t6zvp0f9PWNjs04TJzw/6ksqvN+jpAyA3ThsGqmeCodrCjzhICXNDTwD/DanNT3JyiIYeIPTOO+wP2B4+A8/MtNTrWN1SlHbiL0JPtuWUuP1prnRL7wC0uYMZgnD2pptdd3RU90rKX2zvnGjMtbYGaEndhfkaVBzU9JPsgxsQ8+6oFhVYimUi4hyE9hMOgsjJaljNQZFjIEvzZccP0tVQhBM/wR0kB/IbwE9vAncO4MSkz2/Oj35flabxSkwks4iqaW9hEjQj0qMCeSKvUvKJ6EK5tcQWnblhwA24kNy1IN9LUnDxW1twbOpDGjNOgFWw2qZQSdd8FSCI5M/+IzDXSwZu2Nd2oQqogRboG02dtUzRVUFp3EPvB8P65vtm+fgTm6UrBN+64lDrVL4WKO3QoMBQWgn01zCu79Swey/HUdAZ0txKGotvewea881hn3cV1WB7/SW2TtjdpEcZQAl/K3stj/j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(38070700021)(921020)(6133799003)(11063799006)(10067099003)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3YydzhZUTVwMmZIUGk0blFQd1BjY2lSVW5SSzZWNVJDM2xPYUh6Qk16L2oz?=
 =?utf-8?B?bk5oNEdMRmE3a2NMZ3Y2MnlXdXhEVHd4Qld1eTVKM3YwZjhoUE50Q0xnRFY2?=
 =?utf-8?B?bjk0S2h6QVN6TG9HQVRSa2lOUkY5bGQ1bUl4ZzR0azBQQjhOdHBPSVR4QXp3?=
 =?utf-8?B?SExKNWZQWjY2dmVUSEtxTk42dURJSjAvaU0vMlF2MHVMWlRWaEU4cG1JdWJo?=
 =?utf-8?B?TmQ4VS9tWEp1OE95c1l3MWpoZEkveWVRRUlIZDRQNXZuYVptOTBkK2tnaEJq?=
 =?utf-8?B?dFUxS1AySDhaNjZXWjRydlFITFFvTkhKL1dxUXA4SWVPTTFlT3ZJVGlFZWJK?=
 =?utf-8?B?MWlINGZ0YXoybG15L2x4dDQ4OTZyOFZxTmEyUUZFRlpjTE1MSEhlT1cwNmdX?=
 =?utf-8?B?MHl2ZFM0WVl6cjJDd3A5L2lBcHkxaVhXUHFWb2pGSG0vTzh1TUErUGIrVWh0?=
 =?utf-8?B?V3VtcGNvYnRTRGl0Zy80SktYUDJvdmJ3RDRPMmRPR2ZzOHY3QTIvQVB3NWNL?=
 =?utf-8?B?REdDbGtTeTAzdDhOOC90bzlVaWU4SXBWczNYSWdVQ2x5S1E5eEo5dTA2SHF3?=
 =?utf-8?B?R1JwV1pFSk92c2xKOUs1ajZKNUEvZFFlNnhybi92TmxkMnVMQ1JnRlR5ZHh4?=
 =?utf-8?B?dURuRGYyNVJrU0ExaHlaamJicW1JcDRWdzdXdndiM2xWYXFRRVZHeDJQT3hD?=
 =?utf-8?B?OWl3QTlIN1l6YThQZ0t1clAxUW0vYW1zWXRuRm9mVTduR1MrUEJXZG14ODRP?=
 =?utf-8?B?M1NhRWFpaDNKTCt2UE1saFlDeVZYanZaTHdXNHJ6dGhzZ1NEbXNyRWY3WEho?=
 =?utf-8?B?MitUZ2tuSGdjdFkyenhsT2g5ZlBuSUdLOGNtQW5GclVHemFLZml0RVBpZVh5?=
 =?utf-8?B?R2lXQ2Q5UDN2RjVoUDAySjAzenJrZjdXTUNOMzJwVktjbjFuSXFpUTl3N2xr?=
 =?utf-8?B?MXh4U3dlTjU4YzVabHp4VzVXT1VBdTl1emhxaGJhVGhHZkNIbjlzUkRvYWp4?=
 =?utf-8?B?TkkrODVmM0h4a2lUY0NNa2pySnN6U2c2MDFCZ0Qyb20wOXYvTGZSUGo1eElI?=
 =?utf-8?B?YStWbEpsdU54a0pXNWFTeEsxRnVZR1dBcUlaYnJkSUtKbUZDSmlzOVV5VXVy?=
 =?utf-8?B?R3ppNVlBanNuUjJSa093SGZYZFpYL1RFZlRXS0VaU2RDclZueEFpckxBSUZs?=
 =?utf-8?B?SGgrN1ZEZWNJZmRqTktFUWVBMzROQStLVVZKRW15WStvTy9rSEZBZWpock8y?=
 =?utf-8?B?YjdrcGhTcExPM3pjb0dRNUlDNXBpN1pLVFAxZGRVcVB6WDFIblJTS2JrYlFl?=
 =?utf-8?B?Zkk0NVVGemNGd3hMZGNWQXdTaDhSbW01K3ZObWwyTlJwVE1CSlkwcWlFS2Vi?=
 =?utf-8?B?NEdrNVhJOUVUZ1JnaWZIUFhma0xSckxHdXVuMWplZUhKdDUrbDFtYmlJV2pP?=
 =?utf-8?B?clZnQnMveFNnUUhKRVpKWWJxNXBPQTVsUktHdWdqOTZPMFlGUkF5RzltSGZ6?=
 =?utf-8?B?Wi91SXJlTGZKaHRmam8rQUtOcVlweFpBRzhpVnB5TWdwT3FTcGpJY2F2U0RS?=
 =?utf-8?B?R1dFOXJKdzVkUUpPdVBaZ2VuN01HTS8wWHhaSlF5VTBWQUNNSklsQjlHL0Y4?=
 =?utf-8?B?bXdmdDVYS1NHOUhOR1NIQ2ZEWisrYjNaQnlWNFNPenpIL0ZWREQxL01mZkg3?=
 =?utf-8?B?b2xQaG92QnpRNm9JNU9iSkViZERmUngrY3NiR0FkUkFyaE5seURJVzIyUlVX?=
 =?utf-8?B?RXYveW5mS1FISTNLVVFFamRUODZpT3dOMlZUcEg2UVVKMjh3NkJUU0NQeFQ3?=
 =?utf-8?B?OUZ4dVhVemh4VDdDMVJVSkxvM3Y2QjFHMFZxSW9BT3pvL2pUa1VsTU8vdks5?=
 =?utf-8?B?dEhLc3RPZ1ZLZ09hNHRjR0xDNWZEdGZkMHY5UTZ3UENNbGdkU1UrUVZyMmlY?=
 =?utf-8?B?TG0rTXprYjhVK2hXaTFUWmlieEpvNXhSdEwrWTZLZkhpeHBKZ3BKa0dOZWtl?=
 =?utf-8?B?dlIxVjl0aUxBQ05YWTk1V29Jak9rN3JqS25JT2xmSjVzUWMzRmxvZFZEdXJy?=
 =?utf-8?B?aFBKNG1aWTNyV2NyOGl3cDZZNGV3Q3lNZHdMcVRjaytuM3IzYWdkbkoyU3Ev?=
 =?utf-8?B?UG1BUTZlcUVJbDIrU3kxUGhQWGxpTm8vVWhNWkN0dkhXSzZmZ0pUUVBVSWFl?=
 =?utf-8?B?MVJGV2tYTytLU25SY01VaXc3NVROQS9UZW01eFl1S0RlV1k1d3R0ZlV3Wjc0?=
 =?utf-8?B?TmRRZGl6cW5TT09zTVpCT2hDQ3M1cEVEdFMwdkthMENvQUZHb25yU1Izdkc2?=
 =?utf-8?B?amY4VXp5ZEF3T1lxSzF5amxYS1JhVnRMQTArTXJWSHl2MWlCRTdWcnltR2xn?=
 =?utf-8?Q?xyVzf4Tq5WewbGWs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B4C06CE917E554C9ABB7EA81DCBFBE6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sJBmxaRK8Tq5DyelPfwmrwS5ZnpoAi5qDfsQ8ly4Tneotnyy8IIWT9dk0z9qruIXgtRiOdNia9jb1xhDdok2jws8wXeQGDVStRPBb+1SCvEOOLI+GQ7AWiHmcCRDMC/p1s1RmrffHa2dIs8LZi5QlLaqAEmyyBcd0eptxSO7aF5tV+qI5bNLAAmSMveBt5U3l8jjnzT+2QibFHVMssC2DEJHmWixqqcOxlBZiQZEsvkV4PFTxn35QE4TOKBPlkhnaXUBSxGcIpbTTX69dkmcT2yQOSwxdB3tGKqNczkcK6yqonMKvnrcefQGFm/1Ae/wH1EIaVuptpVboOHuJXCpEg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7463fa-9343-4a10-1b53-08def98f5756
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 23:05:17.3074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAjPJPIj011N0NXxQ3JbltYI2InpGnM3GJCQvllgjXmPt3ZsORCFUBXA2H/i6fz/7n0TwtXqUzhP/W/0YhjTAXEC4kl9+TCowIj9HE7MpI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9154
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA4LTEzIGF0IDE1OjQ3IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gT24gV2VkLCAyMDI2LTA3LTIyIGF0IDIzOjEzICswMDAwLCBMaXNhIFdhbmcgd3JvdGU6DQo+
ID4gdjE0IHJldmlzaW9uIGZvciBURFggS1ZNIHNlbGZ0ZXN0cyBiYXNlZCBvbiBrdm0vbmV4dCBh
bmQgZ3Vlc3RfbWVtZmQ6DQo+ID4gSW4tcGxhY2UgY29udmVyc2lvbiBzdXBwb3J0WzFdLiBUaGlz
IHNlcmllcyBuZWVkcyBzb21lIGNoYW5nZXMgZnJvbQ0KPiA+IGluLXBsYWNlIGNvbnZlcnNpb24g
djkuIEZvciBlYXNlIG9mIHRlc3RpbmcsIGFuIGV4dHJhIGhhY2sgY29tbWl0IGhhcw0KPiA+IGJl
ZW4gYWRkZWQuIFRoZSBjb21wbGV0ZSBjb2RlIGlzIGF2YWlsYWJsZSBhdDoNCj4gPiBodHRwczov
L2dpdGh1Yi5jb20vZ29vZ2xlcHJvZGtlcm5lbC9saW51eC1jYy9jb21taXRzL3RkeC1zZWxmdGVz
dHMtdjE0DQo+IA0KPiBBcmUgeW91IGFibGUgdG8gZ2V0IHNhc2hpa28gcmV2aWV3IG9uIHRoaXM/
IE9yIGRpZCB5b3UgaW50ZXJuYWxseSBzb21laG93PyBJdA0KPiBzZWVtcyB0aGUgcHVibGljIHNh
c2hpa28gY2Fubm90IGZpZ3VyZSBvdXQgdGhpcyBzdGFjay4NCg0KQWN0dWFsbHkgd2h5IGlzIHRo
aXMgb24gdG9wIG9mIGluLXBsYWNlIGNvbnZlcnNpb24/IEkgdGhvdWdodCB0aGUgaWRlYSB3YXMg
dG8NCmJyZWFrIHRoZSBzZXJpZXMgYXBhcnQgdG8gZ2V0IHNvbWV0aGluZyBiYXNpYyB1cHN0cmVh
bToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9hSi02SnBIRDZ4aEF2WlB5QGdvb2dsZS5j
b20vDQoNCkFkZGluZyBpbi1wbGFjZSBjb252ZXJzaW9uIHRlc3RzIHNlZW1zIHRvIGJlIGdvaW5n
IGluIHRoZSBvcHBvc2l0ZSBkaXJlY3Rpb24uDQoNCg0KQWxzbywgdGhlIGJyYW5jaCBkb2VzIG5v
dCBidWlsZCBmb3IgbWU6DQovdXNyL2Jpbi9sZDogLi4uL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290LlM6MjY6DQp1bmRlZmluZWQgcmVmZXJlbmNl
IHRvIGBURF9CT09UX1BBUkFNRVRFUlNfUEVSX1ZDUFUnDQovdXNyL2Jpbi9sZDogLi4uL2xpbnV4
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290LlM6MzA6DQp1
bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBURF9QRVJfVkNQVV9QQVJBTUVURVJTX0VTUF9HVkEnDQov
dXNyL2Jpbi9sZDogLi4uL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9saWIveDg2
L3RkeC90ZF9ib290LlM6MzM6DQp1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBURF9CT09UX1BBUkFN
RVRFUlNfR0RUJw0KL3Vzci9iaW4vbGQ6IC4uLi9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9rdm0vbGliL3g4Ni90ZHgvdGRfYm9vdC5TOjM3Og0KdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBg
VERfQk9PVF9QQVJBTUVURVJTX0lEVCcNCi91c3IvYmluL2xkOiAuLi4vbGludXgvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMva3ZtL2xpYi94ODYvdGR4L3RkX2Jvb3QuUzo0NDoNCnVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8gYFREX0JPT1RfUEFSQU1FVEVSU19DUjQnDQovdXNyL2Jpbi9sZDogLi4uL2xp
bnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290LlM6NDY6
DQp1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBURF9CT09UX1BBUkFNRVRFUlNfQ1IzJw0KL3Vzci9i
aW4vbGQ6IC4uLi9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL3g4Ni90ZHgv
dGRfYm9vdC5TOjQ4Og0KdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgVERfQk9PVF9QQVJBTUVURVJT
X0NSMCcNCi91c3IvYmluL2xkOiAuLi4vbGludXgvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3Zt
L2xpYi94ODYvdGR4L3RkX2Jvb3QuUzo1NDoNCnVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYFREX1BF
Ul9WQ1BVX1BBUkFNRVRFUlNfR1VFU1RfQ09ERScNCmNvbGxlY3QyOiBlcnJvcjogbGQgcmV0dXJu
ZWQgMSBleGl0IHN0YXR1cw0KbWFrZTogKioqIFtNYWtlZmlsZS5rdm06MzUxOg0KLi4uL2xpbnV4
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9kZW1hbmRfcGFnaW5nX3Rlc3RdIEVycm9yIDEN
Cm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uDQovdXNyL2Jpbi9sZDog
Li4uL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290
Lm86IGluDQpmdW5jdGlvbiBgdGRfYm9vdCc6DQouLi4vbGludXgvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMva3ZtL2xpYi94ODYvdGR4L3RkX2Jvb3QuUzoyNDogdW5kZWZpbmVkDQpyZWZlcmVuY2Ug
dG8gYFNJWkVPRl9URF9QRVJfVkNQVV9QQVJBTUVURVJTJw0KL3Vzci9iaW4vbGQ6IC4uLi9saW51
eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL3g4Ni90ZHgvdGRfYm9vdC5TOjI2Og0K
dW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgVERfQk9PVF9QQVJBTUVURVJTX1BFUl9WQ1BVJw0KL3Vz
ci9iaW4vbGQ6IC4uLi9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL3g4Ni90
ZHgvdGRfYm9vdC5TOjMwOg0KdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgVERfUEVSX1ZDUFVfUEFS
QU1FVEVSU19FU1BfR1ZBJw0KL3Vzci9iaW4vbGQ6IC4uLi9saW51eC90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9rdm0vbGliL3g4Ni90ZHgvdGRfYm9vdC5TOjMzOg0KdW5kZWZpbmVkIHJlZmVyZW5j
ZSB0byBgVERfQk9PVF9QQVJBTUVURVJTX0dEVCcNCi91c3IvYmluL2xkOiAuLi4vbGludXgvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2xpYi94ODYvdGR4L3RkX2Jvb3QuUzozNzoNCnVuZGVm
aW5lZCByZWZlcmVuY2UgdG8gYFREX0JPT1RfUEFSQU1FVEVSU19JRFQnDQovdXNyL2Jpbi9sZDog
Li4uL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290
LlM6NDQ6DQp1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBURF9CT09UX1BBUkFNRVRFUlNfQ1I0Jw0K
L3Vzci9iaW4vbGQ6IC4uLi9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL3g4
Ni90ZHgvdGRfYm9vdC5TOjQ2Og0KdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgVERfQk9PVF9QQVJB
TUVURVJTX0NSMycNCi91c3IvYmluL2xkOiAuLi4vbGludXgvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMva3ZtL2xpYi94ODYvdGR4L3RkX2Jvb3QuUzo0ODoNCnVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YFREX0JPT1RfUEFSQU1FVEVSU19DUjAnDQovdXNyL2Jpbi9sZDogLi4uL2xpbnV4L3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2t2bS9saWIveDg2L3RkeC90ZF9ib290LlM6NTQ6DQp1bmRlZmluZWQg
cmVmZXJlbmNlIHRvIGBURF9QRVJfVkNQVV9QQVJBTUVURVJTX0dVRVNUX0NPREUnDQpjb2xsZWN0
MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMNCm1ha2U6ICoqKiBbTWFrZWZpbGUu
a3ZtOjM1MToNCi4uLi9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vZGlydHlfbG9n
X3Rlc3RdIEVycm9yIDENCg0KSWYgSSBhcHBseSB0aGVzZSBwYXRjaGVzIG9uIDhjZjM5NjlhMGI3
ZDQgZnJvbSB0aGUgYnJhbmNoLCBpdCBidWlsZHMgdGhvdWdoLiBJdA0KbG9va3MgbGlrZSBhIGZl
dyBjaGFuZ2VzIGFyZSBtaXNzaW5nIGZyb20gdGhlIGJyYW5jaDoNCg0KZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9ndWVzdF9tZW1mZF90ZXN0LmMNCmIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMva3ZtL2d1ZXN0X21lbWZkX3Rlc3QuYw0KaW5kZXggZDY1MjhjNmY1ZTAz
MS4uYjA5OWIwOWNiYWUzZCAxMDA2NDQNCi0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2
bS9ndWVzdF9tZW1mZF90ZXN0LmMNCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9n
dWVzdF9tZW1mZF90ZXN0LmMNCkBAIC0xNCw3ICsxNCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2Jp
dG1hcC5oPg0KICNpbmNsdWRlIDxsaW51eC9mYWxsb2MuaD4NCiAjaW5jbHVkZSA8bGludXgvc2l6
ZXMuaD4NCi0jaW5jbHVkZSA8c3lzL21tYW4uaD4NCisjaW5jbHVkZSA8bGludXgvbW1hbi5oPg0K
ICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4NCiAjaW5jbHVkZSA8c3lzL3N0YXQuaD4NCiANCmRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL3g4Ni90ZHgvdGRfYm9vdF9v
ZmZzZXRzLmMNCmIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2xpYi94ODYvdGR4L3RkX2Jv
b3Rfb2Zmc2V0cy5jDQppbmRleCBiODFjZDE2MTk4ZWNmLi43Zjc2YTM1ODViOTlhIDEwMDY0NA0K
LS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2xpYi94ODYvdGR4L3RkX2Jvb3Rfb2Zm
c2V0cy5jDQorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL3g4Ni90ZHgvdGRf
Ym9vdF9vZmZzZXRzLmMNCkBAIC01LDcgKzUsNyBAQA0KIA0KICNpbmNsdWRlICJ0ZHgvdGRfYm9v
dC5oIg0KIA0KLXN0YXRpYyB2b2lkIF9fdXNlZCBjb21tb24odm9pZCkNCitzdGF0aWMgdm9pZCBf
X2F0dHJpYnV0ZV9fKCh1c2VkKSkgY29tbW9uKHZvaWQpDQogew0KICAgICAgICBPRkZTRVQoVERf
Qk9PVF9QQVJBTUVURVJTX0NSMCwgdGRfYm9vdF9wYXJhbWV0ZXJzLCBjcjApOw0KICAgICAgICBP
RkZTRVQoVERfQk9PVF9QQVJBTUVURVJTX0NSMywgdGRfYm9vdF9wYXJhbWV0ZXJzLCBjcjMpOw0K
DQo=
