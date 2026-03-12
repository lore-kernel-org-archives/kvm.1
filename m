Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCAE3932DB;
	Thu, 12 Mar 2026 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338722; cv=fail; b=Bm27qRWsqI/KaFleWVkNDD14nMX2JImaOsDqwi1bc674Cv8d6IPLYnjo8kS6ezm9rNBXQgZAa5yCN5gG/ZZKeGAfEMrcd31a5v/FgintCaGWe7y2+a3lcfQKQAFBsSzcb0mY11/RlamS6pYcAdZRd76xpcoN7ouKPIZaSW5w4XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338722; c=relaxed/simple;
	bh=HnmSggEmqPI3fZXeFr3I3TwYYPp8R/sO+ox+fuBh2Dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MLRiBaRgJsCvB106YRhJV/mKYBcTlniv+8SHeP4Pl42tp1V2zlC/vAAmC/8YTyBfs6k+eFhGeO2J04l7r684zIHo0LSoDTFgx2guXv9BxLRE0sLqAq4WFyi5SNUN7044i03FFFThBAgJ5ujzl4Ygl/a9ihrg1SyhSs+7nXJ32Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxVHbQN8; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxVHbQN8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773338722; x=1804874722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HnmSggEmqPI3fZXeFr3I3TwYYPp8R/sO+ox+fuBh2Dg=;
  b=cxVHbQN8104yo9Wd2Zd3WHFpMcPR9LkmJ31i/R26oUo2JcI/B341TtPo
   CVZJlKWuqzX4l/ICobk8ASjySkYYECBrZNgKPKB5pHaq/32ERl4BjhXm2
   4lstU/pUymkpwHxuQc+TbPMs8/HspnGJW5pmrBJYsX6IT/fACkJ6ee3t7
   pvM9wouRAynbJS8j8s+3agm3aeFUN+DTft1VYj/nZw1FocRTHzahFq+EK
   d8NSI2erW2+QP7SKAJfsazwIFhMZ2YwVz74SFQEDi81mpkhNlfI+IY4XV
   IRkumq2d7G/a6F0eV05oobtXxJcxemmDNznOdnHNla5S96XZUgIdy9/XK
   w==;
X-CSE-ConnectionGUID: prOoPVfxSAq/gFvogFwjtg==
X-CSE-MsgGUID: 2oaUpvKnQuWQ/pEe+tRutw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85924639"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85924639"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 11:05:21 -0700
X-CSE-ConnectionGUID: 72Iu+HRWR8yKej1UfXAyuw==
X-CSE-MsgGUID: wYx/4vWLReSAHDo2n7VuYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="225363452"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 11:05:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 11:05:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 11:05:19 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 11:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrZwt/z7iZKMUYVc8XfZqiAP+PebvQPKVC8AcnkdarWr2I6x7eGWJv3hnyF/bWOCeWpYRCTucntZwsMArg+EdJT+EJRrMZ4hENfZPD0O3OAjE5NGbvSj+SRy9bZ/mI8LgbeSaLCeWrv7RZwUtokjRNRoJ7Q6XtMshrUWaltYaoRIC1AMR2ih7+JIkBblZlcyLwrHj8z+2YkT62B5OSrtndJvrrlWGvhemnhGEl03s0JVZsBkrxk+K+xZYAIJZ7herCQykJiuBL7L4WMnPt945FRZyxELnzNvqtn9iE+3UPFWBIrJYW6DV0K+bTbxZXCvRBFFRPjZXb/Zd/EKZ4fXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnmSggEmqPI3fZXeFr3I3TwYYPp8R/sO+ox+fuBh2Dg=;
 b=D9zGrul0z7EOxXLaGCzD/6qvslpicvh4ew2adLXVKxL0giBpOcGc5RTSH72XoOVmT8LFFA5AmdY76LKE0JnOvntyfy7TKd8l1yR6o25dZeP7Qhic4i14IksgXOVI8N23yfHKb5x5jSvPEHyuZ8vZVd0DLhUhVI1BVYyh2T/9coa2gark5SQ8JNtFTrVzmi2VQM+in+xOHENnhXa3lOizcZX2eeT6cNwaaTKp8OYjcYQb7ffKT9hOmIVa7eo4V9y7wRH/Xi6Md/j95v5WH93/Ya66F7wgSFJpL1rC7l5wMwnT66lDawhC+7hOY2IHb9vvoBamJReH4SsOGLxU4CZLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ5PPF035FE4CB7.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::805) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 12 Mar
 2026 18:05:14 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9678.017; Thu, 12 Mar 2026
 18:05:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "sagis@google.com"
	<sagis@google.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v4 11/24] x86/virt/seamldr: Introduce skeleton for TDX
 Module updates
Thread-Topic: [PATCH v4 11/24] x86/virt/seamldr: Introduce skeleton for TDX
 Module updates
Thread-Index: AQHcnCz8dleGg3tjsk+bFkddavHcSbWqT5iAgADLvICAAEHcAA==
Date: Thu, 12 Mar 2026 18:05:14 +0000
Message-ID: <aa798a36216fb44969a6abedf96ecf1c7d4e95fe.camel@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
	 <20260212143606.534586-12-chao.gao@intel.com>
	 <daa8080e1195f586af331dcf31ee5239c4ecbd15.camel@intel.com>
	 <abLJGel27U8xuU6q@intel.com>
In-Reply-To: <abLJGel27U8xuU6q@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ5PPF035FE4CB7:EE_
x-ms-office365-filtering-correlation-id: 1be32ab0-6174-40ec-eb10-08de8061e8ef
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: WkC085sZIqI0YfDmkKPpEANwPVCfEjUw9Dy/YTgRcU71Wj6g4rruZezjFEMkCfJB2I01PC+eBCmAQv4SeLuuytKFv5huY18zSX1jLGs7cB64wXLuft7AArifGEKyQOGuoaWxX0iY3v9WKpdYAYcCogDlHOCyY4FGLdAntC8th2jDv2r5Daw01UtYlz0pTt+W7j0pFDUnO9nmpwkGZpEqiZcgal40Imk6HrkAGGBE5krmEpCpgCzJd+IAbgdV/2fSIV1K0CvWI7tjKS1piM+DxephTnuJXV+2lvpGG+640YYAbwC7xSJ75kE/Z5S1/jmH95lmjA4pyiiIxVes7moH3iz7KHUPL3QkoFX02U8dtbSCPW88b1XWbPDjqy06StQ6z+tQ+hRMZy6L6vRepFDsPNn1XWX6XdzGKJZbbE2KO/pwPjZJw3vHY+UMeBwWzoANtgMfmMR0VowCWocXpzBOOMEvNoTv4rtB/CifL0UH7n4q4KpN2VcoiPu86x8Mzb7SAv1dLMUAizeEJRDYLbNbOkwo4yifxPa1qJSwV0qkStwUHrKxsubLQjzn53fKMttUhTfRZMLTAdS9XKCvqa5OLCXdrivtGZfc6Q2wP2FUbp0TB0AckjMTMfzK/7d8CUTVgzL2rz7KkyjMvv+bMCm2E5tuFbl/wS3d50rSoRGQP9bpUxXbpjLFdsm0OwvDxXlqw1Ixe7g1AwsEomWDxW9gcod6b+Be21b49Ksg/yhojfxGifA/801IKMg/H6gf7Dfk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rzg1SmdtejdJamQwSHV3anFHNVZwRDd3KzBhbEllMVZ5ZHk5d0NWc1RUd1Zl?=
 =?utf-8?B?SDQwQlpoOXd1b1dib0ErQk1weldTVDJGdEl6bWpEdTV1M0RNS3VSZXl0WHNt?=
 =?utf-8?B?cVljUTgxL254Rkh4RUNmSnRjbThsNU5Nc0tScWQvc3pRQ2FhL09PN05idmJ0?=
 =?utf-8?B?MXEyaDc2b0ZxVWZPSXNCUHBKbEZMTW1Mb09KMy91RkpYNExZN0RHYkRmOWQx?=
 =?utf-8?B?MlcyUkFIelNRMkN6Mkg1YzVHWnhFR3VPMTZjQVBENXJ3aThURTRQMktYN3c0?=
 =?utf-8?B?V3ZHMExSVm1ZMy9QdW1wSzJRL0hPKzhCcG5Lc2xCT2w3WVhWTEsrajVjNkMv?=
 =?utf-8?B?NGJ3UW1JclJVOGtvZ0p6RHZQNm1pNjlUTndtV1A4dXV0TFI2S2RuYUxlZU9Y?=
 =?utf-8?B?SXppWEpTTWhNVEhZdmhuL0c0Q1NIUDRVOTdYeG1qNmRjeUw3RlorNXc3SWl3?=
 =?utf-8?B?V1NZWDNrODgzaDhhSzYzSDAvSWs4UXppZ202cTdubTNTMXR3clg1MW83dGhY?=
 =?utf-8?B?bVJRRTdaQUFvSG9NL25OZUlMUmZtT3JrUjlCZ2pFNldhMFVBa3A1S2kwdUhJ?=
 =?utf-8?B?d1NWcThsdnNVbFhOUW5lV21mZWduQUxpdGIrMzV0cFIraGZmS3N2bHFGRDND?=
 =?utf-8?B?Ti90Z0g3cFU2N2s1Mkt0MUxSNzVhQ1JoVDdFUDRRMlIvZGRubnlhWlliSmx6?=
 =?utf-8?B?cytmVlJWT2FrdE9NdElHRG5IVkF2dkw2eVlOV2F2Y1pXL1BLVkF2bW9BRVo3?=
 =?utf-8?B?bXhYc1UreTlYc3dkNXpxMThXbitNeVJuZ2ZSeUNEODJXTHRFWWVpR2pWQThJ?=
 =?utf-8?B?ZVdhY0ExZzhjdzdFQmxWblM5dzJCakZjMkNQb1dzTjRZNndXWk1NOThqV2FL?=
 =?utf-8?B?Nm9rYVpyNHNlWk96Z2VkRTExS2tlaGd3dGlISkVldFZVN1pDV1UyTkpYN1kw?=
 =?utf-8?B?UFAvVm1NdUw0R28wcVdBL2J4aE83TXp2cTNqNzVZN1M3aWhaRGYyaGlLVnIv?=
 =?utf-8?B?VzNWMHVNdjh2QnR6bjE3ZTNzenZNc3JyTEFDWGorWnh3Z2NENGxUcWFQWkxU?=
 =?utf-8?B?OXBZd2YyNFUzcGRZVERnb2JPZjFEQ05ORFlTb3A3WWNOKzc2S3RiaWc4Q1Jh?=
 =?utf-8?B?ZzR6NlFlemo4d2k3dHBXaTI1UUdSQkd4R2lWZDBpcjhpam9mRXpQR0JPQ2ZZ?=
 =?utf-8?B?TVkyKzFPYnB4TlExOXZWT1dUbkt1S20vUkl1TDV5eU5lMFN5RWxnZ05ZWG5X?=
 =?utf-8?B?MmwrNVFoVUE5ZlRsREkzL0c2SXg4S2hlUEpxc1BzUnpPNDlNUUVqbHJZZjJw?=
 =?utf-8?B?TzZlZkJaOWhwVEUwYzdvQ0ZIM1FzN2V0QXl6Ymx0dmdvMW1KTXowYnAxMXN6?=
 =?utf-8?B?VzFsclR2UUExSnpzUEFhMFcyeUh4T2lBVWUvTDRTdVZ6TG5FUmhTUm1wa0Qv?=
 =?utf-8?B?bjZqVWg0OXo0YlF0cUlmUks0emZuZ2RzMEE2dXVhNzN3V3VXVFFTUHJNWnA0?=
 =?utf-8?B?RXV3dDhyN3JmUzF6QmozQXc0c1ptOURDUHhiZmhLSXdlcXYzK3RMWk5OeVVX?=
 =?utf-8?B?QjJ3ZGN1TVcxRUhGNHNFYzZJVUxlS0RHeVJySlg2QmcvZ2xtU0s5RnFCbWtD?=
 =?utf-8?B?ZnR4bzVUMnF1TW5Kd1AzQzZ2S29XMm5GUzU4YjV6VDZ1ak5BN2lUY3I2dGhr?=
 =?utf-8?B?T25qMHY2TUs3Qm01Z0VvbCt2NDgzdGgxcmF3WkFPY3gzdFhxWGVkVy80ajBC?=
 =?utf-8?B?ay9lMVM3WGZGendYbzZ5bE9HTHNLUU1TakwvMWxzZEgzdmZSSGFoeUltai9y?=
 =?utf-8?B?TEdMekZaSktCblYzWTNCVUJGTGpHejlaNFRZcGtuQURXc3E0cVJheWh6UkZB?=
 =?utf-8?B?MFVXOEg4clB1a1dpa1R0N3h4ejlRZ3l1M3pmSUMxZlM1NUFVb3JEMlNCYUtJ?=
 =?utf-8?B?NGREZUNtc1NhNmt5RXNsMTBxS1h5UndKNTRnYlN3a3M1QXdGQWZDODRFWEcr?=
 =?utf-8?B?K0ozUmdVN2M3b1FJTGh1VGE1L29meGFxb250SmpYM2NLbTBQTE40dko1djYv?=
 =?utf-8?B?eTJpcmJhM3piWXBaaEFGOUljbk9NeFhoU3FNdlVzbzIxblYveXRoYURrU3ZR?=
 =?utf-8?B?bGpXRkVJZHkwWGRXYWFQeFJjMnhyRFF2Y2YwU1lZV21PdDhnVTBycFUxZThq?=
 =?utf-8?B?SjQyaGNhYUIwa3U5T1RGaWkrbnpndzJKT2Zwc1N6VFpTcS8yRGcyOEEvd0E1?=
 =?utf-8?B?QjhUSmhKSUZLNXptYzdKaTJUcXhZayt4R0NhZ2R3dC96Z0pva01NR0UvRWZY?=
 =?utf-8?B?ZVphdmx5Q1NjNHg3SVVHUHZsZ2VSNEtBQzY3N1RnYkVqUy9BS3c4OGlJS2ZW?=
 =?utf-8?Q?DihLF+uG5LWZIvEc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B552AD56F8E3204D8EDF90F8B428E665@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be32ab0-6174-40ec-eb10-08de8061e8ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 18:05:14.0991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1wZ+7N7Aj5zXOfy+Zwg1NdRoU+cOINiyXsL9MuhaXUBj6aeqK2aJ/qEWlt6R45QYu+RC5C/QuFsrw/1Lj3ok7n3MvFspGoLoBqyEK2wuO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF035FE4CB7
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDIyOjA5ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gT24g
VGh1LCBNYXIgMTIsIDIwMjYgYXQgMTA6MDA6MjBBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gVGh1LCAyMDI2LTAyLTEyIGF0IDA2OjM1IC0wODAwLCBDaGFvIEdhbyB3
cm90ZToNCj4gPiA+IFREWCBNb2R1bGUgdXBkYXRlcyByZXF1aXJlIGNhcmVmdWwgc3luY2hyb25p
emF0aW9uIHdpdGggb3RoZXIgVERYDQo+ID4gPiBvcGVyYXRpb25zIG9uIHRoZSBob3N0LiBEdXJp
bmcgdXBkYXRlcywgb25seSB1cGRhdGUtcmVsYXRlZCBTRUFNQ0FMTHMgYXJlDQo+ID4gPiBwZXJt
aXR0ZWQ7IGFsbCBvdGhlciBTRUFNQ0FMTHMgbXVzdCBiZSBibG9ja2VkLg0KPiA+ID4gDQo+ID4g
PiBIb3dldmVyLCBTRUFNQ0FMTHMgY2FuIGJlIGludm9rZWQgZnJvbSBkaWZmZXJlbnQgY29udGV4
dHMgKG5vcm1hbCBhbmQgSVJRDQo+ID4gPiBjb250ZXh0KSBhbmQgcnVuIGluIHBhcmFsbGVsIGFj
cm9zcyBDUFVzLiBBbmQsIGFsbCBURCB2Q1BVcyBtdXN0IHJlbWFpbg0KPiA+ID4gb3V0IG9mIGd1
ZXN0IG1vZGUgZHVyaW5nIHVwZGF0ZXMuDQo+ID4gPiANCj4gPiANCj4gPiBBYm92ZSBpdCBzYXlz
IG9ubHkgdXBkYXRlLXJlbGF0ZWQgU0VBTUNBTExzIGFyZSBwZXJtaXR0ZWQuIERvZXMgdGhhdCBu
b3QgYWxyZWFkeQ0KPiA+IGV4Y2x1ZGUgU0VBTUNBTExzIHRoYXQgbWlnaHQgYWxsb3cgZW50ZXJp
bmcgdGhlIFREPw0KPiANCj4gVGhvc2UgU0VBTUNBTExzIHdvdWxkIHJldHVybiBlcnJvcnMsIGFu
ZCBURHMgd291bGQgYmUga2lsbGVkIGlmIHRob3NlIGVycm9ycw0KPiBhcmVuJ3QgaGFuZGxlZCBw
cm9wZXJseS4NCj4gDQo+IE9uZSBtYXkgYXJndWUgdGhhdCB3ZSBjYW4gaGFuZGxlIGVycm9ycyBh
bmQgcmV0cnkgYWZ0ZXIgdXBkYXRlcy4gQnV0IHRoaXMganVzdA0KPiBwcm92aWRlcyBhIG5ldyBm
b3JtIG9mIHN5bmNocm9uaXphdGlvbiwgd2hpY2ggaXMgbm90IGFzIGNsZWFuIGFzIHRoZQ0KPiB3
ZWxsLWRlZmluZWQgc3luY2hyb25pemF0aW9uIHByb3ZpZGVkIGJ5IHRoZSBrZXJuZWwuDQoNCkFo
IG9rLCBzbyBpdCdzIG5vdCBhYm91dCB0aGUgU0VBTUNBTEwgcmVzdWx0aW5nIGluIGVudGVyaW5n
IHRoZSBURCwgaXQncyBhYm91dA0KU0VBTUNBTExzIHRoYXQgYXJlIG9wZXJhdGluZyBvbiBURHMu
IFRoYXQgbWFrZXMgc2Vuc2UuIEJ1dCBwcm9iYWJseSBkb24ndCBmb2N1cw0Kb24gdGhlIFREIGVu
dGVyaW5nIHBhcnQgdGhlbi4gSXQncyBqdXN0IGFueSBzZWFtY2FsbHMgdGhhdCBhcmUgbm90IGFs
bG93ZWQNCnNob3VsZCBub3QgYmUgY2FsbGVkIGFuZCB0aGV5IG5lZWQgdG8gYmUgZXhjbHVkZWQu
IEl0J3Mgc2ltcGxlci4NCg0KPiANCj4gPiANCj4gPiA+ICBObyBzaW5nbGUgbG9jayBwcmltaXRp
dmUgY2FuIHNhdGlzZnkNCj4gPiA+IGFsbCB0aGVzZSBzeW5jaHJvbml6YXRpb24gcmVxdWlyZW1l
bnRzLCBzbyBzdG9wX21hY2hpbmUoKSBpcyB1c2VkIGFzIHRoZQ0KPiA+ID4gb25seSB3ZWxsLXVu
ZGVyc3Rvb2QgbWVjaGFuaXNtIHRoYXQgY2FuIG1lZXQgdGhlbSBhbGwuDQo+ID4gPiANCj4gPiA+
IFRoZSBURFggTW9kdWxlIHVwZGF0ZSBwcm9jZXNzIGNvbnNpc3RzIG9mIHNldmVyYWwgc3RlcHMg
YXMgZGVzY3JpYmVkIGluDQo+ID4gPiBJbnRlbMKuIFRydXN0IERvbWFpbiBFeHRlbnNpb25zIChJ
bnRlbMKuIFREWCkgTW9kdWxlIEJhc2UgQXJjaGl0ZWN0dXJlDQo+ID4gPiBTcGVjaWZpY2F0aW9u
LCBSZXZpc2lvbiAzNDg1NDktMDA3LCBDaGFwdGVyIDQuNSAiVEQtUHJlc2VydmluZyBURFggTW9k
dWxlDQo+ID4gPiBVcGRhdGUiDQo+ID4gPiANCj4gPiA+ICAgLSBzaHV0IGRvd24gdGhlIG9sZCBt
b2R1bGUNCj4gPiA+ICAgLSBpbnN0YWxsIHRoZSBuZXcgbW9kdWxlDQo+ID4gPiAgIC0gZ2xvYmFs
IGFuZCBwZXItQ1BVIGluaXRpYWxpemF0aW9uDQo+ID4gPiAgIC0gcmVzdG9yZSBzdGF0ZSBpbmZv
cm1hdGlvbg0KPiA+ID4gDQo+ID4gPiBTb21lIHN0ZXBzIG11c3QgZXhlY3V0ZSBvbiBhIHNpbmds
ZSBDUFUsIG90aGVycyBtdXN0IHJ1biBzZXJpYWxseSBhY3Jvc3MNCj4gPiA+IGFsbCBDUFVzLCBh
bmQgc29tZSBjYW4gcnVuIGNvbmN1cnJlbnRseSBvbiBhbGwgQ1BVcy4gVGhlcmUgYXJlIGFsc28N
Cj4gPiA+IG9yZGVyaW5nIHJlcXVpcmVtZW50cyBiZXR3ZWVuIHN0ZXBzLCBzbyBhbGwgQ1BVcyBt
dXN0IHdvcmsgaW4gYSBzdGVwLWxvY2tlZA0KPiA+ID4gbWFubmVyLg0KPiA+IA0KPiA+IERvZXMg
dGhlIGZhY3QgdGhhdCB0aGV5IGNhbiBydW4gb24gb3RoZXIgQ1BVcyBhZGQgYW55IHN5bmNocm9u
aXphdGlvbg0KPiA+IHJlcXVpcmVtZW50cz8gSWYgbm90IEknZCBsZWF2ZSBpdCBvZmYuDQo+IA0K
PiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBjb25jZXJuLg0KPiANCj4gTG9ja3N0ZXAg
c3luY2hyb25pemF0aW9uIGlzIG5lZWRlZCBzcGVjaWZpY2FsbHkgYmVjYXVzZSB3ZSBoYXZlIGJv
dGggbXVsdGlwbGUNCj4gQ1BVcyBhbmQgbXVsdGlwbGUgc3RlcHMuDQo+IA0KPiBJZiB1cGRhdGVz
IG9ubHkgcmVxdWlyZWQgYSBzaW5nbGUgQ1BVLCBzdG9wX21hY2hpbmUoKSB3b3VsZCBiZSBzdWZm
aWNpZW50Lg0KDQpUaGUgbGFzdCBwYXJ0ICJzb21lIGNhbiBydW4gY29uY3VycmVudGx5IG9uIGFs
bCBDUFVzIiwgaG93IGRvZXMgaXQgYWZmZWN0IHRoZQ0KZGVzaWduPyBUaGV5IGNhbiBydW4gY29u
Y3VycmVudGx5LCBidXQgZG9uJ3QgaGF2ZSB0by4uLiBTbyBpdCdzIGEgbm9uLQ0KcmVxdWlyZW1l
bnQ/DQoNCkl0IHNlZW1zIHRoZSBtYWluIGFyZ3VtZW50IGhlcmUgaXMsIHRoaXMgdGhpbmcgaGFz
IGxvdHMgb2YgY29tcGxleCBvcmRlcmluZw0KcmVxdWlyZW1lbnRzLiBTbyB3ZSBkbyBpdCBsb2Nr
c3RlcCBhcyBhIHNpbXBsZSBwYXR0ZXJuIHRvIGJyaW5nIHNhbml0eS4gSXQncyBhDQpmaW5lIGZ1
enp5IGFyZ3VtZW50IEkgdGhpbmsuIFRoZSB3YXkgeW91IGxpc3QgdGhlIHR5cGVzIG9mIHJlcXVp
cmVtZW50cyBhbGwNCnNwZWNpZmljYWxseSBoYXMgbWUgdHJ5aW5nIHRvIGZpbmQgdGhlIGNvbm5l
Y3Rpb24gYmV0d2VlbiBlYWNoIHJlcXVpcmVtZW50IGFuZA0KbG9ja3N0ZXAuIFRoYXQgaXMgd2hl
cmUgSSBnZXQgbG9zdC4gSWYgdGhlIHJlYWRlciBkb2Vzbid0IG5lZWQgdG8gZG8gdGhlIHdvcmsg
b2YNCnVuZGVyc3RhbmRpbmcsIGRvbid0IGFzayB0aGVtLiBBbmQgaWYgdGhleSBkbywgaXQgcHJv
YmFibHkgbmVlZHMgdG8gYmUgY2xlYXJlci4NCg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gSW4g
c3VtbWFyeSwgVERYIE1vZHVsZSB1cGRhdGVzIGNyZWF0ZSB0d28gcmVxdWlyZW1lbnRzOg0KPiA+
IA0KPiA+IFRoZSBzdG9wX21hY2hpbmUoKSBwYXJ0IHNlZW1zIG1vcmUgbGlrZSBhIHNvbHV0aW9u
IHRoZW4gYSByZXF1aXJlbWVudC4NCj4gPiANCj4gPiA+IA0KPiA+ID4gMS4gVGhlIGVudGlyZSB1
cGRhdGUgcHJvY2VzcyBtdXN0IHVzZSBzdG9wX21hY2hpbmUoKSB0byBzeW5jaHJvbml6ZSB3aXRo
DQo+ID4gPiAgICBvdGhlciBURFggd29ya2xvYWRzDQo+ID4gPiAyLiBVcGRhdGUgc3RlcHMgbXVz
dCBiZSBwZXJmb3JtZWQgaW4gYSBzdGVwLWxvY2tlZCBtYW5uZXINCj4gPiA+IA0KPiA+ID4gVG8g
cHJlcGFyZSBmb3IgaW1wbGVtZW50aW5nIGNvbmNyZXRlIFREWCBNb2R1bGUgdXBkYXRlIHN0ZXBz
LCBlc3RhYmxpc2gNCj4gPiA+IHRoZSBmcmFtZXdvcmsgYnkgbWltaWNraW5nIG11bHRpX2NwdV9z
dG9wKCksIHdoaWNoIGlzIGEgZ29vZCBleGFtcGxlIG9mDQo+ID4gPiBwZXJmb3JtaW5nIGEgbXVs
dGktc3RlcCB0YXNrIGluIHN0ZXAtbG9ja2VkIG1hbm5lci4NCj4gPiA+IA0KPiA+IA0KPiA+IE9m
ZmxpbmUgQ2hhbyBwb2ludGVkIHRoYXQgUGF1bCBzdWdnZXN0ZWQgdGhpcyBhZnRlciBjb25zaWRl
cmluZyByZWZhY3RvcmluZyBvdXQNCj4gPiB0aGUgY29tbW9uIGNvZGUuIEkgdGhpbmsgaXQgbWln
aHQgc3RpbGwgYmUgd29ydGggbWVudGlvbmluZyB3aHkgeW91IGNhbid0IHVzZQ0KPiA+IG11bHRp
X2NwdV9zdG9wKCkgZGlyZWN0bHkuIEkgZ3Vlc3MgdGhlcmUgYXJlIHNvbWUgZGlmZmVyZW5jZXMu
IHdoYXQgYXJlIHRoZXkuDQo+IA0KPiBUbyBiZSBjbGVhciwgUGF1bCBkaWRuJ3QgYWN0dWFsbHkg
c3VnZ2VzdCB0aGlzIGFwcHJvYWNoLiBIaXMgZmVlZGJhY2sgaW5kaWNhdGVkDQo+IGhlIHdhc24n
dCBjb25jZXJuZWQgYWJvdXQgZHVwbGljYXRpbmcgc29tZSBvZiBtdWx0aV9jcHVfc3RvcCgpJ3Mg
Y29kZSwgaS5lLiwgbm8NCj4gbmVlZCB0byByZWZhY3RvciBvdXQgc29tZSBjb21tb24gY29kZS4N
Cg0KUmlnaHQsIHNvcnJ5IGZvciBvdmVyc2ltcGxpZnlpbmcuDQoNCj4gDQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC9hN2FmZmJhOS0wY2VhLTQ0OTMtYjg2OC0zOTIxNThiNTlkODNAcGF1
bG1jay1sYXB0b3AvI3QNCj4gDQo+IFdlIGNhbid0IHVzZSBtdWx0aV9jcHVfc3RvcCgpIGRpcmVj
dGx5IGJlY2F1c2UgaXQgb25seSBwcm92aWRlcyBsb2Nrc3RlcA0KPiBleGVjdXRpb24gZm9yIGl0
cyBvd24gaW5mcmFzdHJ1Y3R1cmUsIG5vdCBmb3IgdGhlIGZ1bmN0aW9uIGl0IHJ1bnMuIElmIHdl
DQo+IHBhc3NlZCBhIGZ1bmN0aW9uIHRoYXQgcGVyZm9ybXMgc3RlcHMgQSwgQiwgYW5kIEMgdG8g
bXVsdGlfY3B1X3N0b3AoKSwgdGhlcmUncw0KPiBubyBndWFyYW50ZWUgdGhhdCBhbGwgQ1BVcyBj
b21wbGV0ZSBzdGVwIEEgYmVmb3JlIGFueSBDUFUgYmVnaW5zIHN0ZXAgQi4NCg0KSWYgaXQgY291
bGQgYmUgc2FpZCBtb3JlIGNvbmNpc2VseSwgaXQgc2VlbXMgcmVsZXZhbnQuDQoNCj4gDQo+ID4g
DQo+ID4gPiAgU3BlY2lmaWNhbGx5LCB1c2UgYQ0KPiA+ID4gZ2xvYmFsIHN0YXRlIG1hY2hpbmUg
dG8gY29udHJvbCBlYWNoIENQVSdzIHdvcmsgYW5kIHJlcXVpcmUgYWxsIENQVXMgdG8NCj4gPiA+
IGFja25vd2xlZGdlIGNvbXBsZXRpb24gYmVmb3JlIHByb2NlZWRpbmcgdG8gdGhlIG5leHQgc3Rl
cC4NCj4gPiANCj4gPiBNYXliZSBhZGQgYSBiaXQgbW9yZSBhYm91dCB0aGUgcmVhc29uaW5nIGZv
ciByZXF1aXJpbmcgdGhlIG90aGVyIHN0ZXBzIHRvIGFjay4NCj4gPiBUaWUgaXQgYmFjayB0byB0
aGUgbG9ja3N0ZXAgcGFydC4NCj4gPiANCj4gDQo+IE9rLiBIb3cgYWJvdXQ6DQo+IA0KPiBTcGVj
aWZpY2FsbHksIGFkZCBhIGdsb2JhbCBzdGF0ZSBtYWNoaW5lIHdoZXJlIGVhY2ggc3RhdGUgcmVw
cmVzZW50cyBhIHN0ZXAgaW4NCj4gdGhlIGFib3ZlIHVwZGF0ZSBmbG93LiBUaGUgc3RhdGUgYWR2
YW5jZXMgb25seSBhZnRlciBhbGwgQ1BVcyBhY2tub3dsZWRnZQ0KPiBjb21wbGV0aW5nIHRoZWly
IHdvcmsgaW4gdGhlIGN1cnJlbnQgc3RhdGUuIFRoaXMgYWNrbm93bGVkZ21lbnQgbWVjaGFuaXNt
IGlzDQo+IHdoYXQgZW5zdXJlcyBsb2Nrc3RlcCBleGVjdXRpb24uDQoNCkxvb2tzIGdvb2QuDQoN
Cj4gDQo+IDxzbmlwPg0KPiANCj4gPiA+ICtzdGF0aWMgaW50IGRvX3NlYW1sZHJfaW5zdGFsbF9t
b2R1bGUodm9pZCAqcGFyYW1zKQ0KPiA+ID4gK3sNCj4gPiA+ICsJZW51bSB0ZHBfc3RhdGUgbmV3
c3RhdGUsIGN1cnN0YXRlID0gVERQX1NUQVJUOw0KPiA+ID4gKwlpbnQgcmV0ID0gMDsNCj4gPiA+
ICsNCj4gPiA+ICsJZG8gew0KPiA+ID4gKwkJLyogQ2hpbGwgb3V0IGFuZCByZS1yZWFkIHRkcF9k
YXRhICovDQo+ID4gPiArCQljcHVfcmVsYXgoKTsNCj4gPiA+ICsJCW5ld3N0YXRlID0gUkVBRF9P
TkNFKHRkcF9kYXRhLnN0YXRlKTsNCj4gPiA+ICsNCj4gPiA+ICsJCWlmIChuZXdzdGF0ZSAhPSBj
dXJzdGF0ZSkgew0KPiA+ID4gKwkJCWN1cnN0YXRlID0gbmV3c3RhdGU7DQo+ID4gPiArCQkJc3dp
dGNoIChjdXJzdGF0ZSkgew0KPiA+IA0KPiA+IE1heWJlIGEgbGl0dGxlIGNvbW1lbnQgaGVyZSBs
aWtlICJ0b2RvIGFkZCB0aGUgc3RlcHMiLg0KPiANCj4gU3VyZS4NCg0K
