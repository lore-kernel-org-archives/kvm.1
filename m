Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A03515DB;
	Fri, 21 Aug 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347139; cv=fail; b=kAMKSJXww635O387MYAuXqe87dcQMx+dPsoKWzq7dPF3LI3N+yRS7FWO/5fTUlqCj/F9+e3sWbgPHrSy/5TYgzwPPwjfPmQU5lUDz9S0X0T6lFNpM8ETBfsdqq+S0cctW7xW0Pyzh5RhmrE3Gi8wGYD29ukQUvGRDriuoBc6oh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347139; c=relaxed/simple;
	bh=I6VS6dC+QteZdXoP6RG6zQT0XqFxsqMkDQW176f69yY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IQ7tbVOavvkouk6iK9uP8kBfvgcqfkJW5jkygJ+W/s8jPvdVEpVQVSJlxMHE5CWyCckbEPMgtyimrh+O8arzwgmE206tLUUzDaNMb0OarW8/HXbBwX2kjBXxSm0uH0ZuYilrMYKkN5QLx3RZcP9paNqG6d5Lp9keyQCN4JR28s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JR1WVJjf; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JR1WVJjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787347138; x=1818883138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I6VS6dC+QteZdXoP6RG6zQT0XqFxsqMkDQW176f69yY=;
  b=JR1WVJjfyzOuJVGE5ZL49oT+CoGtvQyY/SQE1rFmiAv7pL1L8WVNBlx1
   h5x1UYTgnOVmYayZ1DwDXkRJfi193JnKyJ/qswda8a4JjWavFImLzCWPy
   CKJtZYpZN33GziSeb2XoIE2pXomDCe0nbf5PYa6mSlfUsie/rBsOXj7Zx
   8G1wO6u30bkVvtDq6TnOgztC+ahx55HftOXCduChKmpFq6bbmxIy8tfH4
   WLUAL1FGD9jQUGLCUXfWryqUuQR3OMWNjq7vDmKAHHNrpU5l0c0sKFjcI
   j3DigpsyLZ7iHjjv2s56R0bNTf7pcUZVpOllW3lEdHFHxRaWslHCGO3tl
   g==;
X-CSE-ConnectionGUID: TVtlaFRoQd28sAisQo5L8A==
X-CSE-MsgGUID: LVdDJx6qScuZivBSd9pImQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="75439273"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="75439273"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 14:18:57 -0700
X-CSE-ConnectionGUID: B0tS9N6nR9CZKEBudxwaSQ==
X-CSE-MsgGUID: S77B46QASzaixa5y0QbwNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="304652435"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 14:18:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 14:18:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 14:18:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 14:18:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4LWrIyyjKfGhAbAlBMZUIt/7l1KC8iX6NuZulV2SooqrjZxPq6nu+MMAwBGCpEG6hOuolXENrmn6kdUPEZvJtH0O20Tp0cw43VeSO95UerV5Rx7xO6namF18f3C2Uweh2SKhnSqhZZUpoTiMo0DXhP9SvaKUlLP5r6Ok+qv4GOrENQh17vEfMpI3NGma8L1XD2SuxX0j2zflbizq2c9arFMeOp4hYG/xlFPgWK1ifK3spAyBUluf8YdjWQYvA1HL7ADp3vRq6RW0F6rf4OWZc1nQsYSCjlgcGuHUcYha5AoRON2v10esm3xApb5xM2jczUXjiYS7Y2LcoU0eF2Vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6VS6dC+QteZdXoP6RG6zQT0XqFxsqMkDQW176f69yY=;
 b=W9W+/bkDMchR1cuPXlLOUkhyFifJIlREu58b1zy3ua1i+0sife7Mo4synh8p+85Qfn54RUjMU4hC4zdTVQoF9Yv17wNIj2q8McM/kBn88MQjyLfmR8lYWbicO6fOUCfdjUyjBzYB+oYRA5ZvbjEvgBkRmKX+v0z71w591TM9+Gt4NSR4a6XC7twV9uLZ9twYlAHxwwFcKFly5eGaEZh/L+2DXUxT6dTvgkB7wwXF4ec2G/Mqv65LtqKv5XDkU3eoTe8kMcmD5c4BzGtpRBr92zIGivbeBNpj8kmuh+a/TzjU9oMJ4NGGuOXZgf/mbmjFPGx0OXKsujWlxgUpstzFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by PH8PR11MB8288.namprd11.prod.outlook.com (2603:10b6:510:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 21 Aug
 2026 21:18:50 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0315.012; Fri, 21 Aug 2026
 21:18:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Hansen, Dave"
	<dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH 2/6] x86/virt/tdx: Configure add-on features on TDX module
 init and update
Thread-Topic: [PATCH 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Thread-Index: AQHdMR1Pq6sFAWadj0WCNSD1lSPhrLaok0sAgABvyIA=
Date: Fri, 21 Aug 2026 21:18:48 +0000
Message-ID: <a8dfa2fc181bba446264fde5f5036778c2fe66da.camel@intel.com>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
	 <20260821032920.256225-3-yilun.xu@linux.intel.com>
	 <27321cc1-5428-4590-a88d-b2824659c89a@intel.com>
In-Reply-To: <27321cc1-5428-4590-a88d-b2824659c89a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|PH8PR11MB8288:EE_
x-ms-office365-filtering-correlation-id: 4b36f011-7201-4617-7186-08deffc9cab2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|4143699003|56012099006|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: vd5cXFlvI/0+tlsjmV31Z7DuA6ff4iYpJl+gBgGsfEq/Y19dFNh56VokYqb8BT7rhvhtKAbpsVtiR+PdR41YQ3HbxvcJxuRAPHpkzyRuJQNiLqLTNIcvmobF0VefDfyzBpDbHbDZEJCHHblnyb4APKXEMNPtsTqfjd8j+v6YKZpQyqzN1ImQWN9Gs7TGhCFamrAGPfm4BD1hY5pgDGbrfL16vP5TxOUfCVFSG4O0/LElfbLWfzM+t1bUSQQSVhdB6Wc3ppqGncYy/2adEfIA/jIt/l+8+TJ8zzoCqwgjfHLJE65nmr0WuvtXUCBqpSbdlSaijMCpq6RSO3GkRrFlufgrY2yFjIjL27Kb8OfFuTN1f8AEftfdaAL7IItZRMHmonrRkHy+MELua0ys3pIKoXYjs4QHwLtIYR26W3ECs2RUckODoVh3/jbE0F0X88l/lVq1WnE/SY/DDH+IK24UhL46Kt1WGKESyFM1fZhS7ezCEUWzJ1KiSAe+4efA5ViAvDIajHnBl5QhrxzL/xzMs8uNd/gCFYDJWo1lz2MbVydPKhgXHXPtM0C5OxMxRkY8wwBhOKahVnk05MrajRD/D1QGcLHVFlFM/ufMyoAdO92U/Tp/rX/ug9FEKP9S96DGlxTMpiSzM/clMgUUVBr+BWLGiwOpQdIiPORGyiH94YyNQD/tLxWQYiKCB3K0BOp+NdWB/tcWm8kft2jepZSOX07oUjeYBBUW3iQoWSBzM5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnpmWjBJQ2p1d1dTRXF6YlV1bE0xaFV2dW5vQ2F6RDBDcXlWalVZajRIeERG?=
 =?utf-8?B?b2gzTVgzVHVCdzZQNEVSWkxCRlZUMjBFSGFNL1o3alc4UmZyVURVcnNtN29T?=
 =?utf-8?B?cHRoVTJrUkNISjdzbkFQeGEvSlZQWi9IUHhQRVFMa054L2tmWWo0QUppRHlh?=
 =?utf-8?B?aWR6MVhxRTR2MjZmQkVkeTZDRlZIdnBNd21uZnNMcm1QTVpHQWVYcjNjUnp1?=
 =?utf-8?B?dEcwZXJGYzN2Q2lFa3BXSTB1aGxZTm4xcXRvcWZqL3Rld1BSNkhySU9rdWwr?=
 =?utf-8?B?b014VmNIT3JwUFVTZW4vZ0x6Z3QzNCtXY3pDQTQvTEVEdi9odm9NWmZodDk1?=
 =?utf-8?B?WmkzVlJ6UkZISDY4WHBxYTBEQ3dVWmkwbEg1QjNrWmMxS0RURWFyOW44WnMv?=
 =?utf-8?B?RUJjTk5ZbGd3eHFmenU0TGVWU0hTZk5odjBtVmZFZ2tLaHFoNDB6Q3Z6Zkc0?=
 =?utf-8?B?amhQODlTZlB6aGJhVWdpamdZYUpvWmxWdHROUlMwalBCZDJWSStZbWVkRnA1?=
 =?utf-8?B?UndqK2ppbGV4OWpqZVdGZVg5anN6ZVg3aHVWbWxqQnpPRnBldFhPWDk2WkRl?=
 =?utf-8?B?QzhpR2U2eE1sOS9oaExOMU5hVmdNdkw3eHRHZnMrNlJzT1VxUHdTc1VMblFm?=
 =?utf-8?B?emh6RWRzRjY4ZWZXVXFDcDBRT0krS09LMjBYSStaeUkxY3pPd1NUOTdxdXVE?=
 =?utf-8?B?K0ljSXVWY2I0YzFJZ1BGR2g5NWVtTGgvUzlBeHVnbm5XSFU4MS9wR21scHVI?=
 =?utf-8?B?bDV0K3ovdnFnWHIyR0IyWmVGZzRXZkhQZkZHTFhRVTFyV01SRE9iWGZQU1Y4?=
 =?utf-8?B?QVZueWpiOTNoYXNycDFWVFhpdHlvaFdldWVWU1JtTzZPcU5HN3dub1FIYVJZ?=
 =?utf-8?B?YUwzYU5paG5UeUh0T2tWVVl0Qk5lakZua242Q0h2QVlqdkVzamg2WmlKSWVU?=
 =?utf-8?B?T2tyQWkxZmFMekUwNmdnMTd1YnlFcTE4eWdEUU9EVlhscHJlSmVoWFlMT0k3?=
 =?utf-8?B?ZE1scFQxaXhXQ0QzUU1PSW9uNEFFNXVvdXlmdENpTHRSdkQ0ZlpWYkVGUlFN?=
 =?utf-8?B?cFVndVJhOUdld3VTZlR1OFBSRmxxM25Edit6R1l4ZEpNZTBjcFpWVW50THpT?=
 =?utf-8?B?anFmZHRnUTNzK2w5bFNLQ1Y3ZzI3aVVlNklHdEpIMU80TStCTnN1RWxyZ3or?=
 =?utf-8?B?RlhmdlBzejYzem1VK0RGQ0EzMit4SG81d3J2bXhtQ29BcGpQNy9oS05hQmc3?=
 =?utf-8?B?NWsvSTJPeDRHeGtOS2VVUFprcjM2WVRybFhwQjZuUHV3QjBiRUdpUVV4a2ZJ?=
 =?utf-8?B?QnI5Y2dZOXpFK3p1M0tnekJDTDBnbXllYSt3UmhXVFZ0LzBxMTgwUE43dkov?=
 =?utf-8?B?ODRvRlNzN3lMZk1VeUthWmZNTFBXbElYbks1dnhGTUpvZU9raGhPQ1pDQVBN?=
 =?utf-8?B?V2RwMmNBSXRacHYyS0RJZUc2Qjg2Sk01cERyNksxYnNLbVI2djJIVzU0b0VV?=
 =?utf-8?B?dExHd0ZzbzIzNmwyZVNtOUloVDFFUXhvNzRNUkw2eDFVU0lSWHJvbVhLQXhq?=
 =?utf-8?B?b1hMUnlPMkJGYkp3VTJkSFlhNmhFaXJtSktQWE1QRlA0ZkJQRGs3WDk1WHcy?=
 =?utf-8?B?Y0Q1TEF3MjIwOGIxazVWMHllN3ZtRjBaVGRpbmpNY3kyTk9rRHBoR1N0Lyt2?=
 =?utf-8?B?NHZWYmNSTGMwdUVUeHNDR0xDSlp6eCtBNVdYNFEwd0QveThGazh6dXBwVEVJ?=
 =?utf-8?B?U3JPVXA5VlNTcmtyLzZJODVVVFQ0c3p6N3JIZWI5UEpBeGNIRmJleW5CUWZN?=
 =?utf-8?B?ZEtCbVZaRkl6dUR6ZGtWY3JvWVN6S0dvOHN3RmNONGFJYUd2dkhydVpWbTdW?=
 =?utf-8?B?M3orRm5UMDhsYTgrR2V2UlppVjRtM005SFJOWk1iajBSR3Fvekdhc0I0dlBy?=
 =?utf-8?B?SG9yd1RMUWZMMDRnWWY5OW0xV0l3R1FOdExmblcwcnJoVUJJRjQxZCtQYkZH?=
 =?utf-8?B?b2k4SGVyUDMxMFdQMGxobHc4RGFVTkVqMlJCRmRtZDlQaGlHSFpidllmbU5m?=
 =?utf-8?B?dmo2MGtmdjNVbms1WFRudzFHNEF0T01qa0dvaVRUNHpub1dYRytGWlFjS0ZT?=
 =?utf-8?B?bVhMV3BqR1BLSGRLNmRWRkVYTzFLb0pMcFFXSTk5TWNJSml6WFlEQlozN05D?=
 =?utf-8?B?WHpJRTVaT1JBSW9LLzkwK3BxcG41dk80VGlmbVVwRSswNEZRQ3E0NmtxTWZ3?=
 =?utf-8?B?YUlBVnlTUkdIR3dReW51bEt6c1A4cS81Y25PVlhtQ3dQVFNtSE5ha2p0L0tz?=
 =?utf-8?B?Y2JDRXFsZGhlOUplOTFoUEdzK3huUjk2cU55ZEliYmVkZGdLaHY2c1RINGds?=
 =?utf-8?Q?fY/obOfys7nuG/LY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67BE52AC013B014392AE77535C4CB675@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iCbp+TpI2+6iflTX0es+PaZ52hsz7sM8YRX6QDgQr9KYmdD7aiR1Q9VL+g76ZZRXZXu3YnshO36f2er3Bv3WxksBJcUR9b034LYE0IN8MtyDAdGpUOiA8ao+hdZdJFo8iSdWeVfv3Ht/MyIHJpv4Px7LW+UIjH8Rn9lu4TSTKcrKLoeQv5z5biaSI1FkxV5LcUqk08/MvpcPp3C0s8b+cW5xz+bNiGzCwfdud8w199KzD2xIMHb32DHuQXNHzGPtFFlfOngBzeJhy/2frlnP3nNqML1CnjIqrtLqv3ysVlkWkkEWkBv0+JswPQXFNayiM0a9W196gw+/OG179RiO/A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b36f011-7201-4617-7186-08deffc9cab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 21:18:48.6851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72Gf3IfakHewECloXM01hX7am0p6/6fep2s8VbiVId7Mwmla2eXTaT8P3mcgd5RJa17ZoLvuwkagi5h4XTxdWGNbDk5WdGk2AJ1PIptmzNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8288
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTIxIGF0IDA3OjM4IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOC8yMC8yNiAyMDoyOSwgWHUgWWlsdW4gd3JvdGU6DQo+ID4gwqAgc3RhdGljIF9faW5pdCBp
bnQgdGR4X3N5c19jb25maWcoc3RydWN0IHRkbXJfaW5mb19wYV9hcnJheSAqdGRtcl9wYV9hcnJh
eSwNCj4gPiAtCQkJCSB1NjQgbnJfdGRtcl9wYSwgdTY0IGdsb2JhbF9rZXlpZCkNCj4gPiArCQkJ
CSB1NjQgbnJfdGRtcl9wYSwgdTY0IGdsb2JhbF9rZXlpZCwNCj4gPiArCQkJCSB1NjQgYWRkb25f
ZmVhdHVyZXMwKQ0KPiANCj4gYWRkb25fZmVhdHVyZXMwIGlzIGp1c3QgYSBjb3B5IG9mIHRoZSBn
bG9iYWwsIHN0YXRpYywgbm90IGNoYW5naW5nDQo+IGdldF90ZHhfYWRkb25fZmVhdHVyZXMwKCkg
cmV0dXJuIGNvZGUsIHJpZ2h0Pw0KPiANCj4gV2h5IHBhc3MgaXQgYXJvdW5kIGFzIGEgZnVuY3Rp
b24gYXJndW1lbnQ/DQoNCisxLiBJbiB0aGUgcGFzdCB0aGVyZSB3YXMgY29uZnVzaW9uIGFib3V0
IGFjY2Vzc2luZyBnbG9iYWwgbWV0YWRhdGEgd2hpbGUgc3RpbGwNCnJlYWRpbmcgdGhlIG1ldGFk
YXRhLCBhbmQgaXQgd2Fzbid0IGNsZWFyIHdoZXRoZXIgdGhlIGdsb2JhbCByZWZlcmVuY2Ugd2Fz
DQp1cGRhdGVkIHlldC4gQnV0IGhlcmUgaXQgZG9lc24ndCBzZWVtIGNvbmZ1c2luZyBhcyBsb25n
IGFzIHdlIGFzc3VtZSB0aGF0IGNvbmZpZw0KaGFwcGVucyBiZWZvcmUgbWV0YWRhdGEgcmVhZGlu
Zy4NCg0KQW5kIGZvciB0aGUgc2ltaWxhciB1cGRhdGUgY2FzZSBvdXRzaWRlIHRoZSBhYm92ZSBx
dW90ZSwgd2Ugd291bGQgY2FsbCBhIGNoYW5nZQ0KdG8gdGhhdCBmaWVsZCBhbiBpbmNvbXBhdGli
bGUgdXBkYXRlIEknZCB0aGluay4NCg==
