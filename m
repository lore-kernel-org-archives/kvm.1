Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0225435509;
	Mon, 27 Jul 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174626; cv=fail; b=R4OsKhWu77wRBtZ4zJBGYRXQDbjjKDwElNA0DeK+GA8GVFHJOYwfZBUHTkl4KHWe4e5+LahpORyerB5UiNPiVTXVc7x55lYiU/CGsLQKh1BMbPovrYOjdPK11K7M6sJk0G8F9UT99TYDTDMUeRYFZ9gJCgvAst8h1ypjRuWvdtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174626; c=relaxed/simple;
	bh=qT9I3P0p7A/V8FnD/THwW712gxRZI6lBjAcfQUo9jyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1boqMNHpZUQVq9caCvzSBXoDZaX/ex0LLwmJbLWvmrSt9gGIBEACu7Co6X6ytn68q9RblLh9S5RHziEKm7no4f0orHU3fGVfy0PlWF9kfxhYmTggTIUdFKxbmygjGOjtkA0SyA/DQXaCYlD/eCAQNpKnPYec4tTBr9kH4xSK8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m176An7i; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m176An7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785174619; x=1816710619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qT9I3P0p7A/V8FnD/THwW712gxRZI6lBjAcfQUo9jyE=;
  b=m176An7ixJRXCqfJf6xbHfofNUsLSFQMTr36KGy9mQoUkZgF/7HwHqSm
   xCeaPaFKlzdGUUt57QkdWXIDZAv0Qp6q2Tskjj2NR0K0ZHEmPFaqFCIAu
   bfxIf9SRgDssCnCc+ANlU75aznIIcTsB4r3PJKIGxqNW+xnUHsMV3ReG+
   BhHhsLNLfRUaGrViurMe0Y8tRIQHZ2M8BHc/OJxeDWJRXEHzCFFFIDHOg
   DPa0FJV1VX6HE0W8MYXMjWJMyetddj5N947tLfD7jnGWMnmU2cPmBfdGn
   fWq9nX3219Ro6w3whZbTOz4vm4h36O6l+VdZ+ovc29sWcEklpuM4OM1Oj
   Q==;
X-CSE-ConnectionGUID: bCr65A4HRVGnXKzuoJkJ8w==
X-CSE-MsgGUID: CMB2g2YTT1eZ+HbsNMt3UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96903206"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="96903206"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:50:12 -0700
X-CSE-ConnectionGUID: 1dz+4rCDSzqVz6qFw21I9Q==
X-CSE-MsgGUID: to6F16HfTIiDsI+Y/WrsZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="255539185"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:50:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 10:50:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 10:50:11 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.17)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 10:50:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7ejCIENbUcRz13IdE9pKptN7c2KPOjKq12PzVaPzXJBacqpFMegDWoR1FVIeejL8D2aPgmSTWSZ5jrwEyzE0rxdu4+ICkpJItp/J9j9lB0wUK6zchCH9NeoBO3tnNWk0GaSXOWim8lQ1M1N8XZPu/oRAQPX4FouSlY+hgWREUZTeh7q5MIpNchA62dJs++dVHT4L58JQ4Ile8LdWLcSO9sTvwFDSd3N4dCs+Al/PdyCKWUDuvSCnbB57zIpS8IDfRCA26zeUnng3mKwto5Ul+z1GsE3gYnGmlpUFXqYIztHWOQ0o2wWsHMsNC/tJ/Ob4k/epd50XLdM0n8sA1jV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT9I3P0p7A/V8FnD/THwW712gxRZI6lBjAcfQUo9jyE=;
 b=MywvuU3pgrix/KIby1mFN9wrPs8ObIebDLP0wflTjcGMfUAvuoXusduN/aySARtJ7xK0ytQndOsccQxisQM6w2JmqZd/J33voTwnJU0HUmN81N0wlM55C6FLt0XIFHNLsBQIDPfMNqMD+MR09PQQsrBgjFy76HhtA9Czs86r4qvGCPqYKxCmEy/U2kI+q99OCWsbV7S3BCiCIxRZhhT2y0yB0nSYG25mr/Ge/CPsGfylQqeS7ui8uKT2Sb2gdDVD1S2DmrP9Pm/d0Ho+HaRCOSzqbgL+CssXfbOIBbsATdv2EVn7L33so/Srydf1P8GxIF0sorgRUf+sZaF0TotefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH8PR11MB7048.namprd11.prod.outlook.com (2603:10b6:510:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 17:50:07 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 17:50:07 +0000
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
Subject: Re: [PATCH v2 02/17] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Thread-Topic: [PATCH v2 02/17] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Thread-Index: AQHc/v30KFdak/ZWGk2xzh56glvkdLaB46UA
Date: Mon, 27 Jul 2026 17:50:07 +0000
Message-ID: <2d138a8acb685385016e0bb0535e7213952e44e5.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
	 <20260618081355.3253581-3-yilun.xu@linux.intel.com>
In-Reply-To: <20260618081355.3253581-3-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH8PR11MB7048:EE_
x-ms-office365-filtering-correlation-id: 15a49140-db03-4924-d15b-08deec077f40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|38070700021|6133799003|11063799006|4143699003|3023799007|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: QaN21kWnZ2O59s+sI4uxby8rTGyugA+OrW9WYuB4JwArZqVtxmDbrOq1sIRPQWqQh4ixZw2ED2wJYyhP5ilDZqo5c2eHhkIJxsmJIbXTHv2hIaSIX9bcAROigOFfsWn+QrgirlGLqGV4ev4wYwRzxkI1NDVOP8DnHftoK2/uzFvwJah1OWHErrq8Bwlqk1W2h5Y0ToKXWJel7tuPPmJEdDa/A6z6yAnSYffBEfX38rAwyQ5EIY6jFragfx2lkk0hwE2Ugn681uWyBV9AjW+Iqz2nq+XbwmryC63CgW/bEfD99zV7oPeB0dqVqY9eD8gr10KHTUZqvTIONCMLAa7XIWTFBqx97NyIl1asjYh1RyhUJvzNrn9V+LroMUtKvtv0qkZlhr70Cq3guV2jO8FtXgcnYtw7RwQBjBGNV0NX4YBso/zbpK1MxrCwhLsQA2Khxf41U+YhcmIcD15ghC0Ez3YS/C4PMcWb8c/ohhGoYxq63A05PD0f2vCvUGJbZ6Dil7/T9EU8e28myxSYXuZ57B8yVqHQ3ieDIkbiwyx5hSPrhqYxvVrpydjR7Eg7r2U0B5xU6MSuVxGqYgLrtC7OBNfzevuxKXj6JJWVYL4uXUQOO3Pjx/J97ao34liIHgNaoIKSyL1zGIbY9PFpysmlG6bXsnSAoo4cC4Bnk6zxEUAbqLq5KDacg5/E6BleBmQhw8MhmYxaUL+h4YFVXxpCeBexIQ9UsL8nx4qegt5WtMc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(38070700021)(6133799003)(11063799006)(4143699003)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVVSN1Fla3B6MWRoWkdWbU5qTmJQdzFnK3o3eGs2SUhqSkZuNGRLMWhuVTRZ?=
 =?utf-8?B?cElDZzJjS2RIc0l1UGc0WnIwQmwwSDRxb010WUZJUG5kQ0wycmZyZVQ4WlJW?=
 =?utf-8?B?WkprNWhBakZ4bjNQcVp2b1ZZVC9HbWNGUVJZRDZLWXBqS2lKOGdPdmhVN1h2?=
 =?utf-8?B?MHZiRmk3QldOSFg2VDYza29BcGRGa0RidW9JT1JQNmxjRVM1VldhS0loWkU5?=
 =?utf-8?B?UDhYWjZLa09EdFppa3FpUUVRTGlCeVZKb3pDa1Q3Y0doWEpkZ2pXVTg3Nk51?=
 =?utf-8?B?VENrRFp6a0NYK2VQRGpBWnY4ajl6NWtRZmVOZlBTQ0Z3WDlsUjFFbEFVbHJs?=
 =?utf-8?B?aTJFVDV3dUw0RVliNE5yQW5sN21XOEV1bWh3WVB4dWxYSUxpWjFveVpNWmVI?=
 =?utf-8?B?amJZY05udFF2RTNoNmVXeCtPcHFJeXQ2a0lKa09hUWRRL2pGVTY2VWxBcXl1?=
 =?utf-8?B?d3NEVlVjc0N4clVjd0FzOWlIUHE0NCtEc3ova1FNU2VWTW1sSWQ0cUsyV1pw?=
 =?utf-8?B?ME56dXFrZHlEazBPVUFjSHZORURwRzd3eUZGRER2L2pZQkhGaXpGczZaQXFC?=
 =?utf-8?B?NTRLVG5KY0V4VHBJaEhkMXo1dmRiNy9oT2tYNklRNTFoakoyeUNhSnFDcHYw?=
 =?utf-8?B?ZkZoM2JvTmZVcno4RXZDbm56b1pLSVFsd1lDYWdsMXV6NTgyU1VWb3NvUkJV?=
 =?utf-8?B?anhxYU5CcGYrdUxMQTViVUs5WFlZM3hhYVVIdGNURE1BVC9WaEhncWxQd0ZG?=
 =?utf-8?B?VkZlblh3OUt6R24wcUdLUHk4cjhkcGFYa0FPTzVtRENnMHRIeGU3eVVrTml4?=
 =?utf-8?B?SnNnTlowU1JZY2s0dVd2VWtST0lSZjY3Vjhoemk4LzUzemZqYUhGVnNGMzlm?=
 =?utf-8?B?a25OcTNBUGEremxmRGd4ZnYrbi83U1Uyc25MbXRCcHo2MDhDYjNxbU84bm9w?=
 =?utf-8?B?U0QrUTNNSXQ2WnlxMjlFTC9QVUo5S2dibWxnNFhuTjRiZ1FRQkV2dTZKaklM?=
 =?utf-8?B?V3lkU0trejFkdjNrQzJGVWtXeC90WWVpTTNxZzBicCtUdUYxTGZZaHdEeU01?=
 =?utf-8?B?RG5sZGZZM3BVSmxZZkZYdkJkc08xdVpJV1hBUEZTRGhmVnlXMkdIZnZ6K3Rk?=
 =?utf-8?B?SElPazNzMkh6STNOcFhJY05tMVJpcExMcy9pbFJvZ0lRWXY4SUZ2RTdPTXpu?=
 =?utf-8?B?MVBlTU5hNStWUlNLZ2R5aFBWdUZHeW4vQkxkbDJNb2tNREFCdXZRZWRjbFZn?=
 =?utf-8?B?dllaVnlYZTc0aDhFeWtrb0RlWnJ3d2FFZ2VHRmZ4NlBSZjErSjhlOHRiRHlt?=
 =?utf-8?B?TkZZbWNicnQzRXlyVGthVElDS0VwVkxWVHBtZWpjSnlWOTVlaFZwejJwejRk?=
 =?utf-8?B?NFlUbkhlVEtRMGJNQTkzZkhzOVpicmxSc1d2cnRycnMveDFWQWJXVk9EVWd0?=
 =?utf-8?B?OWl4R3l5cGgxdFVHRU4zcHY3U0lWZiswZlBUazhxMmIzbHMzSng3UUhwK2p3?=
 =?utf-8?B?V295d0R6NlExQUd6aEphaGIvbTBYd0VjYjkxTXNBV2Znajl1aG90b20yTHNP?=
 =?utf-8?B?UDlPZVpHeU95YU5BQzUyWjRmTkxZdm1lVFhUeXJrelhPU3Faa0FDalJhS3A3?=
 =?utf-8?B?Q3lVZEZ2c3ZpODc3a2VKcURiSTIzQko2UGNHdXJQWlV0OFVZc29lMWhxaUhK?=
 =?utf-8?B?MU9oTmVjVlEvYXlwb2tZR2FXS0tHWHkvK0FkOGtaekRvckhqVzBEdlVwaHI1?=
 =?utf-8?B?ME1qdURIWnlhbW5aUEs3WWhYQkVuYXJDOEcrdlJuM1RhZzJXMEdNM1d2MTM4?=
 =?utf-8?B?ZExnNHF1c1dkQUQyTjZVUUFEcnArclZ0aGpKNnhDTlRIbzhjV3d0ODZRM3lI?=
 =?utf-8?B?dFg0VFdvVDc0Y0szckFyYXF2ZW1GNC8wWGpmMTg0ZStvVUZ4YmtIRlIyd09K?=
 =?utf-8?B?RGJhckc5ODBXa2ZVVWM0SFRQcFRJVTVpZ3NvUGNnaFN0eStXN290MGlLbkVT?=
 =?utf-8?B?VTFCQkVER3phZmFubEJIcVQyVjNDS2VHZ1I4aWdvSldIR25HU1hpbkVoQVYv?=
 =?utf-8?B?RmYwWFpIN0h4WERLR2ZNY3ZlMDZKdnZ2dGliTFB0TzV2SUU0cXBSM296L3p1?=
 =?utf-8?B?R3V3N2ZJbWtXTnp0dGdUTFFES2lRNE1LUWk1WTN4bFdlL1djaHpkb1JwK0JO?=
 =?utf-8?B?OVJvUTNiK3N0RSs2UlRrWkRFYm9NbGR4dWNqM3RiUWt6dFhieGE5R1ZMYzZU?=
 =?utf-8?B?M2NKb3E1WmRlVGhMMUwzS0xkMHZuRTNqRjErSjZoY05sQjljVnNIeXBCa1Qz?=
 =?utf-8?B?NmE4R1FvNytjNUJSSktQd3c1ZTROSERWditaWVU0dTI1clFqdmhVMTUwSGlk?=
 =?utf-8?Q?jTgWGVu8LMfzb32U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45CEC46800CEBA419273A0FBF317D37D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: d1i82R/eGYAMjgIPxJKfWCnERG5Hd9cpujGHXJ36Ur6NJHpOwY/8vL8LMx4aExgOiZYRuPv9gz7u9Nw0pheg1rVPJDNP6DWe29klxqEEPcKMNY/zVl7XXTpUwsmuccd/qXMsAeehDebd4i6RoJYhMvuDwrTAkjS4LrZzjsZOXsHZoDF2BWi27msghIvXY/E3onFYipjoK3d205SkiaUOio3JKxkgCHtxtUOOraHLHZOh3Qsrl31kT3A6kkKN7yD3gW94vSrXvyeCwoRmjplMg0z3crDJ6W3o+353yb6YjbcVz7/p/ylojrWZMXNMkH1Z029IQV8OXxjMqtTryjic8A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a49140-db03-4924-d15b-08deec077f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 17:50:07.6572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LstVtpv8S1lCr/X25B8YkGXFEsX8f9lv6DVRRr2NBoQ8FdUCMwt//uZZmUeCTIUB1SdcY2Ik2tcmaH9XobavBu0madp3shRKB/JYNUAr2SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7048
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTE4IGF0IDE2OjEzICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gSW4g
YWRkaXRpb24gdG8gYmFzaWMgVERYIGZ1bmN0aW9uYWxpdGllcywgVERYIG1vZHVsZSBwcm92aWRl
cyBhZGQtb24NCj4gZmVhdHVyZXMgdGhhdCBjYW4gYmUgcHJvZ3Jlc3NpdmVseSBlbmFibGVkIGFz
IHRoZSBrZXJuZWwgc3VwcG9ydHMgdGhlbS4NCj4gVGhlIGtlcm5lbCBzaG91bGQgZXhwbGljaXRs
eSBjb25maWd1cmUgdGhlc2UgZmVhdHVyZXMgYXQgYm9vdCBvcg0KPiBwb3N0LXVwZGF0ZSBpbml0
aWFsaXphdGlvbiB0aW1lLiBDb25maWd1cmluZyBhbiBhZGQtb24gZmVhdHVyZSwgc3VjaCBhcw0K
PiBURFggUXVvdGluZywgdGhhdCB1c2VzIGV4dGVuc2lvbiBTRUFNQ0FMTHMgaXMgdGhlIHByZXJl
cXVpc2l0ZSBmb3INCj4gaW5pdGlhbGl6aW5nIFREWCBtb2R1bGUgZXh0ZW5zaW9ucy4gVERYIFF1
b3RpbmcgaXMgdGhlIHRhcmdldCBmZWF0dXJlIHRvDQo+IGVuYWJsZSBidXQgZGVmZXIgaXQgZm9y
IG5vdyB1bnRpbCBmdWxsIGtlcm5lbCBzdXBwb3J0IGlzIGluIHBsYWNlLg0KDQpJIHRoaW5rIHRo
aXMgaXMgdG9vIG11Y2ggcHJvamVjdCBtYW5hZ2VtZW50IHR5cGUgaW5mbyBmb3IgdGhlIGNvbW1p
dCBsb2cuIFRoaXMNCnBhdGNoIGlzIGdlbmVyaWMgYW5kIGNvdWxkIHN1cHBvcnQgYW55IHR5cGUg
b2YgZXh0ZW5zaW9uLiBJJ2QganVzdCBsaXN0IGEgZmV3IGFzDQpleGFtcGxlcyBvZiBleHRlbnNp
b25zLg0KDQo+IA0KPiBURFggbW9kdWxlIGV4dGVuZHMgVERILlNZUy5DT05GSUcgYW5kIFRESC5T
WVMuVVBEQVRFIHdpdGggbmV3IGJpdG1hcA0KPiBpbnB1dCBwYXJhbWV0ZXJzIHRvIHNwZWNpZnkg
d2hpY2ggYWRkLW9uIGZlYXR1cmVzIHRvIGNvbmZpZ3VyZS4gVGhlDQo+IGJpdG1hcCB1c2VzIHRo
ZSBzYW1lIGRlZmluaXRpb25zIGFzIFREWF9GRUFUVVJFUzAuDQoNCkFzc3VtaW5nIHRoZSB2MyBz
ZWFtY2FsbCB2ZXJzaW9uIHBhdGNoIGlzIHRoZSBmaW5hbCBvbmUsIHRoaXMgc2hvdWxkIGJlIHVw
ZGF0ZWQNCnRvIHRhbGsgYWJvdXQgdGhpcyB3aXRoIHJlc3BlY3QgdG8gaG93IHRoYXQgcGF0Y2gg
ZXhwb3NlcyB0aGUgc2VhbWNhbGwgdmVyc2lvbg0KY29uY2VwdC4NCg0KPiANCj4gRm9yIHJ1bnRp
bWUgdXBkYXRlLCBMaW51eCBhcHBsaWVzIGEgcG9saWN5DQoNCiJhcHBsaWVzIGEgcG9saWN5IiBz
dGlja3Mgb3V0IHRvIG1lIGhlcmUuIENhbiB3ZSBwdXQgdGhpcyBpbiBzaW1wbGUgdGVybXMgb2Yg
d2h5DQp0aGlzIGlzbid0IGRvbmUuICJQb2xpY3kiIG1ha2VzIGl0IHNvdW5kIGFyYml0cmFyeSBy
dWxlIHRoYXQgd2UgYXJlIGJsaW5kbHkNCmZvbGxvd2luZy4NCg0KPiAgdGhhdCBubyBuZXdlciBm
ZWF0dXJlcyBzaG91bGQNCg0KIm5ld2VyIiBpcyBhbWJpZ3VvdXMgaGVyZS4gSSB0aGluayBpdCBt
ZWFucyBubyBmZWF0dXJlcyB0aGF0IHdlcmUgbm90IHByZXZpb3VzbHkNCmVuYWJsZWQsIGJ1dCBp
dCBjb3VsZCBjb21lIG9mZiBhcyBzYXlpbmcgbm8gZmVhdHVyZXMgdGhhdCB3ZXJlIHJlbGVhc2Vk
IGFmdGVyIGENCmNlcnRhaW4gcG9pbnQuDQoNCj4gYmUgYWRkZWQgYWZ0ZXIgdXBkYXRlIHRvIGF2
b2lkIGRpc3J1cHRpbmcgbGl2ZSBURFggb3BlcmF0aW9ucy4NCg0KDQoNCj4gIFRvIGFkaGVyZQ0K
PiB0byB0aGlzLCBUREguU1lTLlVQREFURSBtdXN0IGNvbmZpZ3VyZSB0aGUgc2FtZSBmZWF0dXJl
cyBhcyB0aGUNCj4gVERILlNZUy5DT05GSUcuIFJlY29yZCB0aGUga2VybmVsIHJlcXVpcmVkIGFk
ZC1vbiBmZWF0dXJlIGJpdG1hcCBpbiBhDQo+IGdsb2JhbCB2YXIgc28gdGhhdCBib3RoIHBoYXNl
cyBjYW4gdXNlIGl0Lg0KPiANCj4gVERYIG1vZHVsZSBhZHZhbmNlcyB0aGUgdmVyc2lvbiBvZiBU
REguU1lTLkNPTkZJRyBhbmQgVERILlNZUy5VUERBVEUgZm9yDQo+IHRoZSBjaGFuZ2UsIHNvIHVz
ZSB0aGUgbGF0ZXN0IHZlcnNpb24gKHYxKSBmb3IgYWRkLW9uIGZlYXR1cmUgZW5hYmxpbmcuDQo+
IEJ1dCBzdXBwb3J0aW5nIGV4aXN0aW5nIG1vZHVsZXMgd2hpY2ggb25seSBzdXBwb3J0IHYwIGlz
IHN0aWxsIG5lY2Vzc2FyeQ0KPiB1bnRpbCB0aGV5IGFyZSBkZXByZWNhdGVkLiBJbiBmYWN0LCBp
dCBpcyB1bmxpa2VseSB0aGF0IFRESC5TWVMuQ09ORklHDQo+IGV2ZXIgbmVlZHMgdG8gY2hhbmdl
IGFnYWluIGFuZCB0aGUgY29kZSB3b3VsZCBzdGF5IGluIHYxLg0KDQpIYSwgdGhlc2UgYXJlIGhh
cmQgdGhpbmdzIHRvIHByZWRpY3QuDQoNCj4gIFNvIHRoZXJlIGlzDQo+IGxpdHRsZSB2YWx1ZSBp
biB3b3JyeWluZyBhYm91dCBkZXByZWNhdGluZyB2MCB0byBzYXZlIGEgY291cGxlIGxpbmVzIG9m
DQo+IGNvZGUgaW4gNS03IHllYXJzIHdoZW4gdGhlc2Ugb3JpZ2luYWwgVERYIHBsYXRmb3JtcyBz
dW5zZXQuDQoNCldlIGNhbid0IGRlcHJlY2F0ZSBpdCB0b2RheSwgc28gd2hhdCBpcyB0aGlzIHNh
eWluZyBleGFjdGx5Pw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVA
bGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4Lmgg
fMKgIDYgKysrKy0tDQo+IMKgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jIHwgMjggKysrKysr
KysrKysrKysrKysrKysrKysrKystLQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3Zt
eC90ZHgvdGR4LmggYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmgNCj4gaW5kZXggZmJiNTIw
NzA0NjYyLi5hNDdlODcyNDgwYzcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3Rk
eC90ZHguaA0KPiArKysgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmgNCj4gQEAgLTU4LDkg
KzU4LDExIEBADQo+IMKgI2RlZmluZSBUREhfUEhZTUVNX0NBQ0hFX1dCCQk0MA0KPiDCoCNkZWZp
bmUgVERIX1BIWU1FTV9QQUdFX1dCSU5WRAkJNDENCj4gwqAjZGVmaW5lIFRESF9WUF9XUgkJCTQz
DQo+IC0jZGVmaW5lIFRESF9TWVNfQ09ORklHCQkJNDUNCj4gKyNkZWZpbmUgVERIX1NZU19DT05G
SUdfVjAJCTQ1DQo+ICsjZGVmaW5lIFRESF9TWVNfQ09ORklHCQkJU0VBTUNBTExfTEVBRl9WRVIo
VERIX1NZU19DT05GSUdfVjAsDQo+IDEpDQo+IMKgI2RlZmluZSBUREhfU1lTX1NIVVRET1dOCQk1
Mg0KPiAtI2RlZmluZSBUREhfU1lTX1VQREFURQkJCTUzDQo+ICsjZGVmaW5lIFRESF9TWVNfVVBE
QVRFX1YwCQk1Mw0KPiArI2RlZmluZSBUREhfU1lTX1VQREFURQkJCVNFQU1DQUxMX0xFQUZfVkVS
KFRESF9TWVNfVVBEQVRFX1YwLA0KPiAxKQ0KPiDCoCNkZWZpbmUgVERIX1NZU19ESVNBQkxFCQkJ
NjkNCj4gwqANCj4gwqAvKiBURFggcGFnZSB0eXBlcyAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvdmlydC92bXgvdGR4L3RkeC5jIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+IGlu
ZGV4IDJhMDMxNTI3OTZlNi4uOTIzMDViNWVhOTBkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni92
aXJ0L3ZteC90ZHgvdGR4LmMNCj4gKysrIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+
IEBAIC01Nyw2ICs1Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgdGR4X21vZHVsZV9zdGF0ZSB0ZHhfbW9k
dWxlX3N0YXRlOw0KPiDCoHN0YXRpYyB1MzIgdGR4X2dsb2JhbF9rZXlpZCBfX3JvX2FmdGVyX2lu
aXQ7DQo+IMKgc3RhdGljIHUzMiB0ZHhfZ3Vlc3Rfa2V5aWRfc3RhcnQgX19yb19hZnRlcl9pbml0
Ow0KPiDCoHN0YXRpYyB1MzIgdGR4X25yX2d1ZXN0X2tleWlkcyBfX3JvX2FmdGVyX2luaXQ7DQo+
ICtzdGF0aWMgdTY0IHRkeF9hZGRvbl9mZWF0dXJlMCBfX3JvX2FmdGVyX2luaXQ7DQo+IMKgDQo+
IMKgc3RhdGljIERFRklORV9JREEodGR4X2d1ZXN0X2tleWlkX3Bvb2wpOw0KPiDCoA0KPiBAQCAt
MTAwNCw5ICsxMDA1LDE4IEBAIHN0YXRpYyBfX2luaXQgaW50IGNvbnN0cnVjdF90ZG1ycyhzdHJ1
Y3QgbGlzdF9oZWFkDQo+ICp0bWJfbGlzdCwNCj4gwqAJcmV0dXJuIHJldDsNCj4gwqB9DQo+IMKg
DQo+ICtzdGF0aWMgX19pbml0IHZvaWQgc2V0X3RkeF9hZGRvbl9mZWF0dXJlcyh2b2lkKQ0KPiAr
ew0KPiArCS8qDQo+ICsJICogVG8gYWRkIERJQ0UtYmFzZWQgVERYIFF1b3RpbmcgZmVhdHVyZSBi
aXQgaW4gdGR4X2FkZG9uX2ZlYXR1cmUwDQo+IHdoZW4NCj4gKwkgKiBrZXJuZWwgaXMgcmVhZHku
DQo+ICsJICovDQoNCkNhbiB3ZSBub3QgbWFrZSB0aGlzIERJQ0Ugc3BlY2lmaWM/DQoNCj4gK30N
Cj4gKw0KPiDCoHN0YXRpYyBfX2luaXQgaW50IGNvbmZpZ190ZHhfbW9kdWxlKHN0cnVjdCB0ZG1y
X2luZm9fbGlzdCAqdGRtcl9saXN0LA0KPiDCoAkJCQnCoMKgwqAgdTY0IGdsb2JhbF9rZXlpZCkN
Cj4gwqB7DQo+ICsJdTY0IHNlYW1jYWxsX2ZuID0gVERIX1NZU19DT05GSUdfVjA7DQo+IMKgCXN0
cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHt9Ow0KPiDCoAl1NjQgKnRkbXJfcGFfYXJyYXk7
DQo+IMKgCXNpemVfdCBhcnJheV9zejsNCj4gQEAgLTEwMzIsNyArMTA0MiwxNSBAQCBzdGF0aWMg
X19pbml0IGludCBjb25maWdfdGR4X21vZHVsZShzdHJ1Y3QNCj4gdGRtcl9pbmZvX2xpc3QgKnRk
bXJfbGlzdCwNCj4gwqAJYXJncy5yY3ggPSBfX3BhKHRkbXJfcGFfYXJyYXkpOw0KPiDCoAlhcmdz
LnJkeCA9IHRkbXJfbGlzdC0+bnJfY29uc3VtZWRfdGRtcnM7DQo+IMKgCWFyZ3MucjggPSBnbG9i
YWxfa2V5aWQ7DQo+IC0JcmV0ID0gc2VhbWNhbGxfcHJlcnIoVERIX1NZU19DT05GSUcsICZhcmdz
KTsNCj4gKw0KPiArCXNldF90ZHhfYWRkb25fZmVhdHVyZXMoKTsNCg0KVGhpcyBpcyBhIGxpdHRs
ZSBvcGFxdWUuIFdoeSBub3Qgc29tZXRoaW5nIGxpa2UNCg0KdGR4X2FkZG9uX2ZlYXR1cmUwID0g
VERYX0tFUk5FTF9TVVBQT1JURURfQURET05TICYNCnRkeF9zeXNpbmZvLmZlYXR1cmVzLnRkeF9m
ZWF0dXJlczA7DQoNCnRkeF9hZGRvbl9mZWF0dXJlMCBjb3VsZCBwcm9iYWJseSBiZSBuYW1lZCBi
ZXR0ZXIgdG9vLiBJdCBtZWFucyB0aGUgZmVhdHVyZXMNCnRoYXQgdGhlIGtlcm5lbCBoYXMgZGVj
aWRlZCB0byB1c2UuIEhNbSwgYW55IGlkZWFzPw0KDQo+ICsNCj4gKwlpZiAodGR4X2FkZG9uX2Zl
YXR1cmUwKSB7DQo+ICsJCWFyZ3MucjkgPSB0ZHhfYWRkb25fZmVhdHVyZTA7DQo+ICsJCXNlYW1j
YWxsX2ZuID0gVERIX1NZU19DT05GSUc7DQo+ICsJfQ0KDQpUaGlzIGtpbmQgb2YgZmVlbHMgaGFj
a3kgdG8gbWUuIHRkeF9hZGRvbl9mZWF0dXJlMCBpcyB6ZXJvIGlmIHRoZXJlIGFyZSBub25lDQpz
dXBwb3J0ZWQuIEl0IHNob3VsZG4ndCBpbnRlcmZlcmUgd2l0aCB0aGUgdjAgY2FsbCB0byBzZXQg
aXQgdW5jb25kaXRpb25hbGx5Pw0KDQpJIHRoaW5rIHRoZSBjb25uZWN0aW9uIGJldHdlZW4gdGR4
X2FkZG9uX2ZlYXR1cmUwIGFuZCBUREhfU1lTX0NPTkZJRyBpcyBhIGJpdA0KdGVudW91cyB0b28u
IEl0IGlzIHNldCBpZiBhIGV4dGVuc2lvbiBpcyBmb3VuZCB0aGF0IHRoZSBrZXJuZWwgc3VwcG9y
dHMuDQoNCldoYXQgZG8geW91IHRoaW5rIGFib3V0IHdyYXBwaW5nIFRESF9TWVNfQ09ORklHLiBI
YXZlIHRoZSB3cmFwcGVyIHRha2UgYWxsIHRoZQ0KYXJncyBpbmNsdWRpbmcgdGR4X2FkZG9uX2Zl
YXR1cmUwLiBUaGVuIGhhdmUgdGhlIHdyYXBwZXIgZGVjaWRlIHdoaWNoIHNlYW1jYWxsDQp0byB1
c2UuIEhhdmUgYSBuaWNlIGNvbW1lbnQgdGhhdCBzYXlzICJVc2UgdmVyc2lvbiBvZiBzZWFtY2Fs
bCB0aGF0IHN1cHBvcnRzIGFkZA0Kb25zIGlmIHdlIGhhdmUgYW55LCB1c2UgdGhlIG9sZCBvbmUg
aWYgbm9uZSBhcmUgc3VwcG9ydGVkIGZvciBiYWNrd2FyZA0KY29tcGF0aWJpbGl0eSIuDQoNCkJU
VywgbG9va2luZyBhdCB0aGUgdGR4IG1vZHVsZSwgaWYgSSdtIHJlYWRpbmcgdGhpcyByaWdodCwg
cjkgdXNlZCB0byBiZQ0KaWdub3JlZC4gU28gZGlkIGl0IG5lZWQgYSBuZXcgc2VhbWNhbGwgdmVy
c2lvbj8gU29tZSBvdGhlciBWTU0gd2FzIHBhc3NpbmcNCmdhcmJhZ2U/DQoNCj4gKw0KPiArCXJl
dCA9IHNlYW1jYWxsX3ByZXJyKHNlYW1jYWxsX2ZuLCAmYXJncyk7DQo+IMKgDQo+IMKgCS8qIEZy
ZWUgdGhlIGFycmF5IGFzIGl0IGlzIG5vdCByZXF1aXJlZCBhbnltb3JlLiAqLw0KPiDCoAlrZnJl
ZSh0ZG1yX3BhX2FycmF5KTsNCj4gQEAgLTEzMTQsMTAgKzEzMzIsMTYgQEAgaW50IHRkeF9tb2R1
bGVfc2h1dGRvd24odm9pZCkNCj4gwqANCj4gwqBpbnQgdGR4X21vZHVsZV9ydW5fdXBkYXRlKHZv
aWQpDQo+IMKgew0KPiArCXU2NCBzZWFtY2FsbF9mbiA9IFRESF9TWVNfVVBEQVRFX1YwOw0KPiDC
oAlzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzIGFyZ3MgPSB7fTsNCj4gwqAJaW50IHJldDsNCj4gwqAN
Cj4gLQlyZXQgPSBzZWFtY2FsbF9wcmVycihUREhfU1lTX1VQREFURSwgJmFyZ3MpOw0KPiArCWlm
ICh0ZHhfYWRkb25fZmVhdHVyZTApIHsNCj4gKwkJYXJncy5yOSA9IHRkeF9hZGRvbl9mZWF0dXJl
MDsNCj4gKwkJc2VhbWNhbGxfZm4gPSBUREhfU1lTX1VQREFURTsNCj4gKwl9DQo+ICsNCj4gKwly
ZXQgPSBzZWFtY2FsbF9wcmVycihzZWFtY2FsbF9mbiwgJmFyZ3MpOw0KPiDCoAlpZiAocmV0KQ0K
PiDCoAkJcmV0dXJuIHJldDsNCj4gwqANCg0K
