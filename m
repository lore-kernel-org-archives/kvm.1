Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938B397E85;
	Mon, 30 Mar 2026 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898734; cv=fail; b=SiJQBKUkxUX+cSgdNf7UwcTlag80RSFOgNB+HZEeWBeK3pFb82NATqHW4PW1tUhbS3Pg41jrdYleZvd2Ph9ScqlpSMRZ8IctGsHY8738E8PvZDQE8DjYEtuF931awyYhj2B5WNMGMW/o3YPGp2tH/RnkrkcuYhZJBW2Pxw/C9z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898734; c=relaxed/simple;
	bh=P+U+DnuO9cMqQGeGmevQZIlkFyqgvviFM3oAuVRPh0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IChtXchHnsgakcftUmglRlLj81osXDfM3+DOUIB513lx3yOa8BxpATuhzmB7QNnRBM5HhBSmbYegDIAi6/rR/yPys2BD4XmoQXKC/6o7XpTJWMviMt/0AhlhcINyoehNVIxDFjNFWiEXTZoHk+hnCdbvnFEFbBt0Cn6B8PRUr+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYpNG7tg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYpNG7tg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774898733; x=1806434733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P+U+DnuO9cMqQGeGmevQZIlkFyqgvviFM3oAuVRPh0U=;
  b=dYpNG7tgOSJawuykryoK790/RpI4OKInh4zUfr9a8FodTG95uT0h+dW7
   t5KX51Yl7urjahm7fCrnvw16tCLRcqKBle9HPqvf7+MeRNVph2wBuVo3c
   LQnSNe5l0PcmaTddMehpQCUx6h8vHppT7FNMcyejIFnjo1vMIA73qM+27
   STr+4B0DQP0RRxU7pcZbVrcFnkx9JsTBUfO7QjiceStOKXQUOLuRwZ3yT
   Cq+yZ4i1jIXnIba2iyz01vC+tu03yYlLNG2bU+8gHMjMwKTrM4N8Dfi2+
   G+GqtVq0pGcdCjdST3wr1Jmf2xv28r84LHwtDolKrkzD4HlRmYTDtGYle
   Q==;
X-CSE-ConnectionGUID: xftY5j6eQ4a4boGwt/UlBg==
X-CSE-MsgGUID: fo7XgXx0S+qccnK7m/r01g==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76011445"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="76011445"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 12:25:32 -0700
X-CSE-ConnectionGUID: 22259oYRQRWae0r650Ou+g==
X-CSE-MsgGUID: ASwDZK6/QaqW5NQQwAjwsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="226402419"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 12:25:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 12:25:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 12:25:31 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 12:25:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1uoLYAQOejP5PCzBXnh5C7LZ3nigKOwFLCM0j09VyG/X9E8kx5zquJsAcIojBho2j5hCKOwonv8cfFNHe48DsSRzmRMt3N2UwR0kf2eCMDNQqVwYsziasXnStdgLsyCWG53J32PU62zN3fLLeF7ItohFiu24kgWEeSkOwv7CCGA7bZSy5snjjuSWv1hXiVDGxrTJB9I901xkvGOo6J7WSr07LUAv6uSlWPvVFYSGNCWPDuaBZHTGeauUFFypPgxyo1u0Tsqo0i8/5R2Lct1mssQ0tCvGwNXuUDtwxVCcQwrqBkfN5BEc0quLsjbfxxv2citpFWlgpNPVuETT0SVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+U+DnuO9cMqQGeGmevQZIlkFyqgvviFM3oAuVRPh0U=;
 b=WrwAfcoKVFb7bXso/2EifOOrcZ3iCV1InZdfmnhAHVoKsXze939P6GUdI5C+Xx+xBc6vB+UKtRcnfzOBdpjUp8GmPo23L2xrzUrkfmsvPOAYlcfhdmKc/eJrj4ohPjymbLQhlbjjSpjIOQrWeKH7flU+LUG2lBMunsIUb3aKZqeT1Yyjc/tk2TWam1Gp1guBfTsM9KWiaL02lZLHCpwR9NbmQe43s7tmNlasVH3k+2irjFXAu7sfvHIitOR7fuPbTkHJMejvVN2kIQMFOCYSU94avmAZK5Yeu1ukij3sIBi1jmfa52aQSnleadGgcCB+8PUTtqEK8O1GISdO5oSz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 19:25:22 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 19:25:22 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Topic: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Index: AQHcuwf0xG4i7UD/nE2Ttuc0mPAERbXHAxsAgAB9PQA=
Date: Mon, 30 Mar 2026 19:25:22 +0000
Message-ID: <def1f4395865ad0d22be245647fbb75ab8698ab8.camel@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
	 <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
	 <acpiGUKS-WRmLoxp@thinkstation>
In-Reply-To: <acpiGUKS-WRmLoxp@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB6733:EE_
x-ms-office365-filtering-correlation-id: d58f12ee-7fec-49f7-8fe8-08de8e921651
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: JCha2nvaLPczaMqXo9uUEQl/BLb0QxcuY1B7wtBW8u998t0fdQgdjHcsXGeQY6G/BnQV2ABKpzVGnWItCCw0CWybC31biuJfJqw716CdHhSwKP7GbZ8Gh1oiKDmpqe+Qfg/G/ZBtmn7ohs+m601VJU1StH5KCD2N9octsLtGXWZac6MVd27XJYBFx9mMH0y/xraG62CBmsT21et0Mixgcvk1aBIP1UuVN6CPXlqjEdRe3yByq1+WQ1eeTWZZ/+H35DqCa71AXWeEDHZy4IEXJZ6o754IFoj2cwpFYibRcTy5tnjHFMq2PxNmV+4rgGJOjNrSzQdl/EfG2oUrXP6sMJ/RfgCLMDpK1ZJiNcpy/WLpB9QWIEJJUwBnW37SUQkWu0xiQnz6zIiMhJENb0PZZzpTYRaPAK0v3yOiMDKMg+9hWKr8J7+XJU/WJc+k9Z6JlZNNR2dM76I/w/5RPqXWPu5IkDqg8VfUYGRF7lYln+SDnFQUYMwcUSXMlf+lvNZGDQexEJhMx4TpCSqPwaUUkcJ228hZu1j66/W9lsTzHEgKRtirreQ4zBCNYovKlzotWRLszxR8xwdRSsnkUj8Jqnh2Ss9qocHvrI+dSi0wxXGlpznfpSoR8XQBg1HdOHOG5dev9P2EasEmO6CumJ8HjTOTXoMyII8nx0dqJ9/qAXAwfBmtPxG3RWQLHKB4dy5jJmLkA1BHm3ai06Nq+yus28F2IVBWr0Kf/tPIeDK1eDTGh/t7NKeI6XXysab+3ucgSmVL1geGVKFD0iz5rXYED96IztLLJYMan62FO/dBeuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amhjT0FKOW0wNWdFWlo3Tk1IOG13eGlUM0ViaHBYL3ZVeEljd01XVDFSeXdE?=
 =?utf-8?B?TlQvYjBnUEZoU1g0dFE0c3RCM2dRUjVaajFjNFhXZ0FqV0p5bExEOEV1SnA5?=
 =?utf-8?B?djcyc3pHOGlabnhCWlBzVGZOK2FhOUh6Z09mRjIrNHh4ZHg5aUZYZkJDRTdG?=
 =?utf-8?B?T1VvUFZXajJ1V1ZrR0Focnp6N0dpUUxyM25paElUZFBCeG9QRzNOY3NqVDQ0?=
 =?utf-8?B?U1BCWnl6N29IeUdRNDEwK0VsTTBxT0JoSHh6MnREK1NhZFFqenMvVGtPTjk0?=
 =?utf-8?B?bHlRQU5LZCswNklPT3A2Q0hkSkxzWk9wWVpJc1JhUHBlcTlJOWRaVFVDMitu?=
 =?utf-8?B?NVpEV1E4RzE2YS9SWG1BSnd3Ny9TSWM0LzhtMVUxWVFlSEp3bFF5NTBNWVFp?=
 =?utf-8?B?NXJVOTR6Wm9nUWk4aGErQ2t1YVYvaXEyZWVpWHpldENJQjBaMjJOV1NHdUFO?=
 =?utf-8?B?c0hMd1JaVTQyRWU5ZEhVOWR2dFMrV3lxbkRuWXEwc01HSkxNY1pDZ3ZwOXpj?=
 =?utf-8?B?TG9PcnF1Z29LQVM2ZFBxbURBZkV5UUhEZ0pOaFNNejRXUzBVSDJJSEtOQlY0?=
 =?utf-8?B?QUhJbkY5bmlsQ01uUFowdm4venN4V1NrdVpkREpBbGd0YjZRTktvL3Z5a2tY?=
 =?utf-8?B?UkVuY2pCUEVMenFiZFh3a2xLZVJ0MzRiNkRpZEFIakNUb1RNUkhIS3FneFVZ?=
 =?utf-8?B?blBPTFlxNnQvOG5YME5mbTUydXFmZ1JJU2NveEQ5Wk1ZZEdSMG44U1JEc254?=
 =?utf-8?B?bDFiejlQbUtmVmNFOTU1cUxuUmZUcTJIeUgrNk9ubGVvcmdZWUF2a3dleHJC?=
 =?utf-8?B?ZW1IOEFQdlpBWHNGcTNPVlY1SEFvYU5ZUmlka2xPSlc4N2FlL0pxNGFCcXlL?=
 =?utf-8?B?RWdTNWthTjFYRjdJdkJrdUNpdytMV3d5dUNFZ2lRL2ZoZ2ZOb2NCSnI3MENK?=
 =?utf-8?B?ZGtpRUowcDF6ZngyN2UzNFhyK1hhRUNYdS96L3MxVDBMMmY3aVRIdzd3cTR3?=
 =?utf-8?B?V3N3R1BZZGxyUlBwOUMvMGxpNEtrVnV6TktKeUw1T1gycVVhbW5XL082VGZz?=
 =?utf-8?B?NStPb0FVbGpTV25PTUZzSnNMVEhoUU14UitVUi9GcDUyUVFmc0FqbDdjbTJD?=
 =?utf-8?B?bW1VTzZBS0c1U1A4RkJiYlZGMWFXWUErRTNUcDdBZy9oUForbGhENXBmdWVS?=
 =?utf-8?B?QVpod1ZnR0swdVFpNEFsMG8wQkxMSGJic09SdmZCNTNJYjFiVXBaQ1NKMHBX?=
 =?utf-8?B?TVQ5S0JLMXBlcThqa2VScnVDRGoySTNqWko5WVh2TktMbjZESlhnUjdTRXlT?=
 =?utf-8?B?QnB4TDBON2ZiT1RUQzNKR1dQUk1SVHZSMitIVEMyWElhM1FmVUxNOFRDNjJX?=
 =?utf-8?B?cVFDTHVZZzY0b0d1NGhJWUdUenZrSTU5OG5sTmtVam14R2ZmKzF5SlBSb3kw?=
 =?utf-8?B?dXpMUXRsNDRqMDJBbFVhWUdRVk1QdHRsaitnNTFUQzMrUVY3VDlMZUhHeEJi?=
 =?utf-8?B?QlE5ZXRzNlBRb3g2dlpueC82UlQzUlpmcENIeEJOOFNLRk9qUFZ3ekFuWU5G?=
 =?utf-8?B?M2VRTFNDdHR2emVONk9aZXJyL0wzakp4WHlmcDVPeUFLc253Q0E2S01KeEw4?=
 =?utf-8?B?MmNidXpCdi8vbk5GclFKekdHYTNWSkxPcGxpS3N4cExZMVM5NExtdW9PTnJm?=
 =?utf-8?B?OTkyT2UvZzNkVmIxMXk3b0QvUGpJRzhtVlVwakFadXV2ODF4RUhWVWUrcDAv?=
 =?utf-8?B?UXFVZy9NQm1TVmhOZDhXelFQZ2pTZCtOWXRCc2dyWll3ZUtTZ0Q3ZjVzdUI0?=
 =?utf-8?B?ZW1XTVE1dmZUc0xsTHkrVFdTQjl4RitnczA4OHNzci9zaXArUnhXdEN5bGd3?=
 =?utf-8?B?MEFQRDVDRHI2NndMZE4rdFQrVmtJNzkvZWZUU1JuQU9HM1JiWFQ1Y0tjYk94?=
 =?utf-8?B?Y2xQSVQ2V0xZZ3VReG9YNXpPL3hhWnBwVnovRHIwYjFRRGFkL1BHbzhKQWZU?=
 =?utf-8?B?TXg1QUg5MjZMUm1zQ3BlT1FSeGV2SlN4WDEra2RsN1B5dkxQbnkrdVRKdEFa?=
 =?utf-8?B?Z0xWRzUzNk1GVVJYSG0ydW8wLyt5WGZYTnNXTk1DNHltK3czemtHd2ZRRkRS?=
 =?utf-8?B?bnZ4SitxbkZoMlNreTNqODN4SGJUeVpIMGViU0JrazR5MEwyV2s1T1FHRW80?=
 =?utf-8?B?WTRINjE2QXk4ZWF2cE9rMnNhaklram9pYnZhNDRrbk5OWUZKTldiS0x5Y1Rh?=
 =?utf-8?B?MDhnR3NwaGxBT2kzaVVGZUxnVTBqWTF4UmpqUWZjU3NMK2k4Z0dCS2ZvZW5T?=
 =?utf-8?B?b0hrdURwNXljdjFzRmZ0TktOdWthcVdLWWVISU0zY2JGVWhPMHdWdmtNTHUv?=
 =?utf-8?Q?AXbqAWkZ1Z3q8LYw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <543E95FBE449DD4CAE46BFC97E2DDA31@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: p8s2ERiH4ZEFU9UTlrXkAg/evw97Gh0NuwRXoWXiWqOVEvQsoJcV2bcqjQUrie5de8F54V7B6qZ0MSd4YjE/3VLbojTyn3pVl+DU6WZHkcQO0rXU+bWqOpg/LsRa0hFDQWDjOGbdUoRO4j4fwpE6qfM48Lm1mM5WKO0J835e/CGGn9lp9aMvirwsTCm+1NNdlU8lNQ+l3aoNsvGvsnJn1FZXcJ4NB8IoKCUVokUHjYqDG68Tnc71yPiKGV9Pt8N9ktwbm60iBCx/lvGiW+CMvt0YlLozb/nPsah0jZPhzfQJN6I+YDSTyI34x9G4f2lBlAacT8HKo1oCSuQnHIrj8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58f12ee-7fec-49f7-8fe8-08de8e921651
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 19:25:22.3759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IrO44cWY8kLiL1PPbZmBgwg+bPVxhNkaXBWrFNJbPzz/CRCwrOv6HukopfX27FbGg+OsO2EHU/Db2LQP0B1WNJtkFo0MG8dcHJ8CbLvw3YE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6733
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDExOjU4ICswMDAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+ID4gKwkgKsKgIC0gVERYX1NZU19CVVNZIGNvdWxkIHRyYW5zaWVudGx5IGNvbnRlbmQgd2l0
aA0KPiA+IFRESC5TWVMuKiBTRUFNQ0FMTHMsDQo+ID4gKwkgKsKgwqDCoCBidXQgd2lsbCBsb2Nr
IG91dCBmdXR1cmUgb25lcy4NCj4gDQo+IExvY2tlZCBvdXQgYnkgd2hvPyBJcyBpdCBURFggbW9k
dWxlIGNvbnRyYWN0PyBJIGRvbid0IHNlZSBpdA0KPiBkb2N1bWVudGVkIGluDQo+IHRoZSBzcGVj
Lg0KDQpZZWEsIGJ5IHRoZSBURFggbW9kdWxlLg0KDQpXZSByZWxheWVkIHRoYXQgd2UgbmVlZCB0
aGlzIHNwZWNpZmljIGJlaGF2aW9yIGFyb3VuZCBURFhfU1lTX0JVU1kNCmNvbnRlbnRpb24sIGJ1
dCB0aGUgaW1wbGVtZW50YXRpb24gaXNuJ3QgZG9uZS4gVGhhdCBzcGVjIGlzIGFjdHVhbGx5DQpz
dGlsbCBpbiBkcmFmdCBmb3JtLiBXaGljaCBpcyByZWZyZXNoaW5nLCBiZWNhdXNlIHdlIGNhbiBh
Y3R1YWxseSB0d2Vhaw0KdGhpbmdzIGxpa2UgdGhpcyBiYXNlZCBvbiB3aGF0IHRoZSBrZXJuZWwg
bmVlZHMuDQoNCj4gDQo+IEkgYXNzdW1lZCB0aGF0IGlmIHRoZSBTRUFNQ0FMTCBmYWlscyBvdGhl
ciBTRUFNQ0FMTHMgc3VwcG9zZSB0byBiZQ0KPiBmdW5jdGlvbmFsLiBIbT8NCg0KVGhlIGJlaGF2
aW9yIHNob3VsZCBiZSB0aGF0IG9uY2UgeW91IG1ha2UgdGhpcyBzZWFtY2FsbCAoYXNzdW1pbmcg
aXQncw0Kc3VwcG9ydGVkKSB0aGF0IG5vIG90aGVyIHNlYW1jYWxscyBjYW4gYmUgbWFkZS4gVGhl
eSB3aWxsIHJldHVybiBhbg0KZXJyb3IuIERvIHlvdSB0aGluayBzb21ldGhpbmcgZWxzZSB3b3Vs
ZCBiZSBiZXR0ZXI/IElmIGl0J3MgYW4gb2xkIFREWA0KbW9kdWxlLCBub3RoaW5nIGhhcHBlbnMg
b2YgY291cnNlLg0KDQpTbyBsZXQncyBjaGFuZ2UgdGhlIG1vZHVsZSBpZiB3ZSBzZWUgYSBwcm9i
bGVtLiBXaGF0IHNob3VsZCBpdCBiZT8NCg==
