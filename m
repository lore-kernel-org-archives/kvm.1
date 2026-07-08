Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6005F3A718D;
	Wed,  8 Jul 2026 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783544599; cv=fail; b=PN5BjYfkvEK9182WbR+NPmQ6FQeljA7YMKpceW/xqWRWQmXygTM/39zZ64GGJ/KEEvOv18fGswFG9GcHDfYElpYjaTtrgniZHvxANoEFq7Rxjnr2KsZSP+2YEXiJPeYgT6xJAl8UyZ5mO0lZ/jlRwVhdsmSXFbi7dYxJMJXxmSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783544599; c=relaxed/simple;
	bh=OTRpc95nUMwrLDNVuR6MhODsVqZuG70aj/E6RHIieAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dxjDDZBwL6BFcB+Svv6G7wMCzSbl4+51+GPji+6IUxElrirdB8gdznuvfPK+rx2do5J4nHq1qLLbAaD35zHBG83J6F2Wwg2FtWqqZgpdBo56q9OUoyNf1YyAbgINx26abWRsmyjnepLBN8X68jR7lJ1DWc3D5Wp2bVtfs1A3JOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiurkM0g; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiurkM0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783544599; x=1815080599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OTRpc95nUMwrLDNVuR6MhODsVqZuG70aj/E6RHIieAc=;
  b=MiurkM0gaWl4jsUJA4O7zfqKW1Ry0qdSEk3c14+MVHEnyRms4gWUJuGQ
   kI8mMq8+cFyJdDy/6gEmbqvXzZNW+d2sm9EMbuy4uYT0Ezc+RR4Ny/eQu
   uoQvnz2Y1veTJbyoYrEOuEMJLwCBY6JB+tVQgFnv/k4zDrXhQ7njFo/Ff
   nkfHNp+3cUaxiejktYKRetFstDH28BgkTM8foViRERu7q6r5P8Kt3zm4z
   2bv1U9TMeoQDdqwybR3ec9fTGETMQ3OzuU8mgzOdf30V9cXaiB+HQxGmf
   N5RcOOi2ONVURAgjzncJ/JRZRft/d6rW7IOROkzGOkiwMsAToIlng/PFb
   Q==;
X-CSE-ConnectionGUID: GsRrZP4hTveg+5aJYZcCkA==
X-CSE-MsgGUID: ZLaNuppiTZei2Pb7EcZqfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71740730"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="71740730"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 14:03:17 -0700
X-CSE-ConnectionGUID: KwK+q2ywQvegxsNAYSYTHw==
X-CSE-MsgGUID: qpFjKM/pSLu5qN1ARIb55A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="253305777"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 14:03:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 14:03:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 14:03:13 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 14:03:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y101KISj7s4aoEuMRrhrL+NA/EFoTTgu8sThNG4sCCnvN8IkspRojaDioNPTUQMAgyB69Z9rZj2Q/R3AVXnejZj42Jdoo6GXJG8ygBehpELb5ZxDLqCRCisNE4KbUAemOWKj7kWxrTlwaWKIAecwDy13O14BhiArZVFQg91V2xCgFAsEA1z4+JmDOgbmjhChBL04cFHygI5zAzg/Hx8DIZpyaOgQfd6yD2iynDecTlbpS7lpQWfSlT0N0ZEwpHGeQ43IyXOo+K0kLE9bThU/+xIwxwaseVFmi0xkE+/avrX4blkSr5D7XsJ9e6u3vGjrXz0dZ86wy0XF+1izWbQdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTRpc95nUMwrLDNVuR6MhODsVqZuG70aj/E6RHIieAc=;
 b=CZe6VblnVGJAKysDiCseAlhWjVt2VAofRtbeb43hX9+ms68EKGEQWhGPoag11sAxN1Ww760ddalYiyUO/vGhEH+uPcSBMWyUTz5VLJwPezAqu4NSlwXRuPyN5aDO4RakKOKxs4wqHpAc9f1rnhgWJ2IqEgEPEgMNW11hpd0avzChEDH5+MiRLSgOHgiQHZHx+q8ftsTzOrtTmHCqLa8NLZmjkAbA+kxvuq+Db9OSMMOavrL7lyUQMIl3PvOysQdb7HdgrxXfY3ZE7fcqibyIRDqei1vMBxPZXKZYvU0FhhQ+1INqyIP9X/fPsCWKvbMECpMI2UWIkU1LPucmd3jiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DSWPR11MB9737.namprd11.prod.outlook.com (2603:10b6:8:354::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 21:03:10 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 21:03:10 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Thread-Topic: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Thread-Index: AQHc7LhXfoCfkuUFmkqKqK55gbUxZLZkPsuAgAAiHgA=
Date: Wed, 8 Jul 2026 21:03:10 +0000
Message-ID: <eab9a2e601883deaffb70cfe2fbdbbc95daacc28.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-6-rick.p.edgecombe@intel.com>
	 <1d60cebf-4764-4785-bf01-8ca59ab2cc7d@intel.com>
In-Reply-To: <1d60cebf-4764-4785-bf01-8ca59ab2cc7d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DSWPR11MB9737:EE_
x-ms-office365-filtering-correlation-id: 82d1fd84-f533-48ff-9ce0-08dedd345127
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006|921020;
x-microsoft-antispam-message-info: CM9qYAFwFZM8GqMQs4FYaBkgotK1VtNU7nVX9/c8TWVDt3vNzsDfyejY6Cz0IrOCfi9bbHmaK9Qj2S3qbx1T5r1pB9VLIxkJ70216+LEnC2wUir/3pzqCRfDIQ8tmzi7V4gt97kPegiDTy210dsiEyvF78HyMG/yux03VpPbGOJMFTzeueFWFSzaDqxk1G6k711s3WrYEsItCuzIV1n756gh471QA+vZ/jEtZ/roTCOQczq5ZrcfAl6hy+bacxaMoGQWwRvx9sOyi94zO0MOxRVqri6vp00ZzteFonQdALfs8dxoYcZpb0Db3ot1sNqjEKKZiXS5Hmnv2BnHoWAEa4++QuY9EBKKq19ntwmr/PH8rhGaZjOxDDYqty93fkoJPsDCJCdvR8rFIx3rbQpO81DGZa+x+uPmUOtwDJ1uRqZe4Po0eDWxkQns1V3AeZWI7n7t3i6qaSeWPNHcxVXxHZ3GLH3cP0BEFpgZ8FWsS8u/1grfuK+UzVYaKv2j/P2OobcIr7YN17AzNke9vlYDdia6xah7ckW3/JDhQ4HeKKDN+v1df49lPtqsdNvO4wRsCZNR0iR8k3vJFroaYhtftQf91oLx7PkdzQJN/QI3MtRoCAor5hlZYsUCdK+bjxM4iOg/zy9b8HAayLih6NdeylLgyJTIUkAXD5IoXmADoyG27eIRocKtTn9P33cJ/j621NUfnjclJllYpyKAnkYSzUMSzPJAg6PjW2+kCWVg3Yv+oJRQSfdQVVLzNUvpLLCQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlNFbEJTSldRSXNHcVJmczZrKy9PK0RsdlFvdC80WFIwZkplUUJRMEQvNXN5?=
 =?utf-8?B?aCszdDNRYzE2RDBUYUlWVi9zSmlPamVjaUV6ekJ2cHZVckVjWlRnOEVlU245?=
 =?utf-8?B?d0pHSVVKdFVwRldRb05QcVhsS3NiSkEwVzNzbTArcGtzMTFHOVFzZW1RaFJq?=
 =?utf-8?B?Mnc5cHlCQngzZ1lVL3dkWFVoNmR3YnVDSkxleVJ0SHN5eDZIOUFWV0trRDRF?=
 =?utf-8?B?VE05Nmp3YkIwb29PSnNmN0Fmb2ZxRkxBQWMvU21UODBKMHk2VjBmbDYzaURu?=
 =?utf-8?B?MzlEd2x5OXJrMFJFM0xHcGRQNy8rSDFia09FTDA4UU9PQ3lDNUdRMzdZM0Jt?=
 =?utf-8?B?cGVEdUhJYzVNc2pVNlFkZDU3Tm02RlVLR2pMZWtsb1RXMVpCZmpTNlhjZmw4?=
 =?utf-8?B?VjdxQldLYnRUeVhMWlFIZ0UwQXV1VmZONWM2b0JrUkRhN3AraUZndVZHbzBj?=
 =?utf-8?B?L2ZOc0RPSXYwMGxEVFA2Zk41b3RwT3lWT0FVVWlvRUFZRUdYZ2lCeHBXSjYv?=
 =?utf-8?B?U1JVWU02eXpzSEpCOVd3Zkd2Y3ErU1Q1NzZGNHRtcXVGTnl2RmVRcWo2dWV5?=
 =?utf-8?B?L1NRNkduaEx4TzZNUVowYVk1SitaOXhBRXhBUUwxeHhIQk9DVTJJd1dyUGd4?=
 =?utf-8?B?UEpla3hGODdMV2VPWVFLbXdjRWk1T3dnQkNodlpUZXp4Zk9Ba0xDZVcvWEFS?=
 =?utf-8?B?N0lFWEJjWTR6RGJwTWR3NFdiK0lCMUlNdFhqelplM0xrQU9RcnRUQUJTRmpH?=
 =?utf-8?B?UTJ4bFV0RDB6L1NlTWxYMWxUL2oxWTdrTzhNYmo2Y2FJV1NiVHNPOGxsVWNn?=
 =?utf-8?B?V0xQQlF3QzFobWtiMnE0MURYU2xJU3p0ZTdSd1lETThHQXhoWkIrQzdhN1Ew?=
 =?utf-8?B?OE40d1A1eWY2T3BZaGVMRUsrTThnM2Z2bzFaZC9BQ2RUd28rdWlBRzRYVHFh?=
 =?utf-8?B?RGxHSDc1d25OWDJjZm9CSEJPZkZlNnVmc2dReTEzTnpZT2M3VER0OHdPb3p4?=
 =?utf-8?B?R2g3QmVOUStPV2RtdXFVeVhGNjFWN2RaakZ5VDRwbHgyWUNmdmJxSUlFNVJS?=
 =?utf-8?B?Rm1GcGJiS2dqb3E0RVBRQkdDSmlHaVhyTUNkc08vOWQ2V3hoNDZWTGdRYzRC?=
 =?utf-8?B?UnIrdCtNTStzNVEyWVVpR1BMWGJUeEkxb3VZNHlpelUxNjRMVXVxMnlXQzU0?=
 =?utf-8?B?UFBPLzJ3dWVSMDZVM1RrSjFONHUyajQ4TTVSbGd4c0N2TGZhb0VnZXR6NFZZ?=
 =?utf-8?B?YU5sQW5xTHhPUEJVNmtGU1hqVzJoeWtiUDI2TCtMRUQwbmdnL1cxRGFyYVlk?=
 =?utf-8?B?bkZXblVtY3hUamJ0UmNiT2phSU5kRGFweTZJTXdVZGxSMkpENlpyU2NCUjNC?=
 =?utf-8?B?V2FXTXpBdUNzbVNENHF5amFNTjNldGkweC9rQkdzWjVqbm5kT3M3bjV3aG5j?=
 =?utf-8?B?eXpyOUhpK1dhTDZxYmVHcVZhRm9PeEdyQWtsSnUreEhHclE0SVlwa0sxclJF?=
 =?utf-8?B?NGN0bkhodE9EbGJyVVhiZi9WaEdFcE50T01VQ1d2SjgybUx0QjVacklFQ3RZ?=
 =?utf-8?B?UEhlUHBOR3RHc1Z2bFJMMXFTUTJzZG5yby9IcWQ0R3ZVR29MS2dhK2ZncUZX?=
 =?utf-8?B?OElRWXk5eTJ2ZWFiVTh3UWhaNVMvWmVpQjFlTTRGN1d1cXlnb2RRQU5GOGlK?=
 =?utf-8?B?LzFYcXJSQlhaZEZUZzdRRTNLbkxYOURMY2drNFF6bmVhdVlqcUxzNFJPcVhm?=
 =?utf-8?B?c3Q0WTJzRkd3UEEwY2l0SjJzTHRkZS9zWktvT2ZraWhwS2k3UDJVaDJvN0ZN?=
 =?utf-8?B?eVZPT0lncHJ4UkxJLzdpdVJaWndmazhjbGJJNUovbVRvdVNWdkhPNFBUYTdM?=
 =?utf-8?B?bmRxSStMWmlOTzczdXRuS01FRGFKdUxzcVBBZ0NhYjF5QkJQZjduZlZQQUtB?=
 =?utf-8?B?aWg5dUZGZnNYTEdRVGJ3U1pvMGpYUXhwdUJFNzJXZmd2SDVBbVo2V3JPY1Qx?=
 =?utf-8?B?dU5CUHhzS202UXRoSVpqUldKc3ExdTRoV1lFdEFUdDN5VFZnVUt5MTV3V3pT?=
 =?utf-8?B?VVdTQU9TTFJ0WGF5NXV3VGlYWmQ3VFF1VDBiVWVGQkFTdU9vZUhEL0ZFN21x?=
 =?utf-8?B?TzNqMXlnd1ZBUmptQlllVUdHSk90YmV4aUVWUXVpQXhnbHdmMHVvTXVrM0dS?=
 =?utf-8?B?eHJuSm1qUkgwTlFYa092cExVVCs1UUhBSXhkQ0FOWmpLU0FaY2t0L2s2Rklo?=
 =?utf-8?B?UzZEaTZkR2huclYzZGw4WnlUbzhWVStpaUM3bTN6eG5JY0U5OGQ2Q25kV3Rq?=
 =?utf-8?B?VmFQZWFOYzZGVkYzdm1BWWFEV21CQUQ2UXJzbUhLRmNzNUU0M1l3Wkw2L0du?=
 =?utf-8?Q?ZHTQWNOEcTAlHbjg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB42BE4CF808634BB5695566B36A50AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lOAHos8T15cxVlEoPUswBF+hUIlj5MjvxCwMEDVTFsc9l8aLB2GlTbo/0TKiRCuT8j7NNmcebdrC+cdyjTM9OqDtej1YyL8RDynO2YXIJNN+WrQaGyYFMESqFMjDKRGsYwhmPQFGAC7+iTDTdJGRL9zu1cuTbZbcJfpvGm3eYwegN4S5+/IzYXpe7PsVB6ycoF7oVexUVz/JaVrOe0W1+/WcqPqeahzJqRe7vXmCX0rWBPgyUfellqZzU3WWChioKkk8jZ02s8kN1Jt8dCygvGMW9a5L4m/GXUy3k0WxmPOKto69y07JrTeaIA2HdHeBXxs5jxTOprOcGvhjSKK/Sg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d1fd84-f533-48ff-9ce0-08dedd345127
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 21:03:10.2256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3vKAtsqJyKI1eZy86N8H3h8ScdpdvuCd8Mw7LTQPrtUPEGDXe529az2n7UKbc+DfnzQvDdGdUe4bWwZLr8VVKHOPWQPPvuno82QZKDXVeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9737
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTA4IGF0IDEyOjAxIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gNS8yNS8yNiAxOTozNSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gKwlzY29wZWRfZ3Vh
cmQoc3BpbmxvY2ssICZwYW10X2xvY2spIHsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIElmIHRoZSBw
YW10IHBhZ2UgaXMgYWxyZWFkeSBhZGRlZCAoaS5lLiByZWZjb3VudCA+PSAxKSwNCj4gPiArCQkg
KiB0aGVuIGp1c3QgaW5jcmVtZW50IHRoZSByZWZjb3VudC4NCj4gPiArCQkgKi8NCj4gPiArCQlp
ZiAoYXRvbWljX3JlYWQocGFtdF9yZWZjb3VudCkpIHsNCj4gPiArCQkJYXRvbWljX2luYyhwYW10
X3JlZmNvdW50KTsNCj4gPiArCQkJZ290byBvdXRfZnJlZTsNCj4gPiArCQl9DQo+IA0KPiBJIHRo
aW5rIHRoaXMgcGF0dGVybiBpcyBhIGdvb2QgZml0IGZvciBhdG9taWNfaW5jX25vdF96ZXJvKCku
DQoNClN1cmUuIFRoZSBpbnRlbnRpb24gd2FzIHRvIG1ha2UgdGhpcyBvbmUgYXMgb2J2aW91c2x5
IGNvcnJlY3QgYXMgcG9zc2libGUgYW5kIEkNCnRob3VnaHQgdG8gbGV2ZXJhZ2UgdGhlIG1vc3Qg
ZmFtaWxpYXIgY29uY2VwdHMgb2YgcmVhZC9pbmMvaWYuDQoNCj4gDQo+IEkgdGhpbmsgaXQncyBh
bHNvIGZhaXIgdG8gc2F5IHRoYXQgdXNpbmcgYW4gYXRvbWljX3QgaGVyZSBpcyB1bm5lY2Vzc2Fy
eQ0KPiBiZWNhdXNlIG9mIHRoZSBzcGlubG9jayBwcm90ZWN0aW5nIGFsbCBhY2Nlc3Nlcy4gQnV0
IEkgYWxzbyB1bmRlcnN0YW5kDQo+IHRoYXQgaXQncyBoZXJlIGJlY2F1c2UgeW91IHdhbnQgdG8g
b3B0aW1pemUgdGhpcyBwYXRoIHRvIGF2b2lkIHRoZQ0KPiBzcGlubG9jayBpbiB0aGUgZnV0dXJl
Lg0KPiANCj4gVGhpcyBpcyBub3QgYSBob3QgZW5vdWdoIHBhdGggdG8gY2FyZSBhYm91dCBhbiBh
dG9taWNfdCB2cy4gaW50LiBJbg0KPiBwcmFjdGljZSwgdGhlIHBlcmZvcm1hbmNlIGlzIGdvaW5n
IHRvIGJlIGJvdHRsZW5lY2tlZCBvbiB0aGUgYmlnDQo+IHNwaW5sb2NrLCAqbm90KiB0aGUgYXRv
bWljX3Qgb3ZlcmhlYWQuDQo+IA0KPiBJJ2QganVzdCBhZGQgYSBjaGFuZ2Vsb2cgYmx1cmIgdG8g
aGFuZHdhdmUgaXQgYXdheSBmb3IgdGhlIG1vbWVudDoNCj4gDQo+IAlUaGUgcGFtdF9yZWZjb3Vu
dFtdcyBhcmUgYXRvbWljX3Qncy4gVGhleSBkbyBub3Qgc3RyaWN0bHkgbmVlZA0KPiAJdG8gYmUg
YmVjYXVzZSBhbGwgYWNjZXNzIGlzIHByb3RlY3RlZCBieSBwYW10X2xvY2suIFRoZSBvdmVyaGVh
ZA0KPiAJb2YgYW4gYXRvbWljX3QgaW4gdGhpcyBzaXR1YXRpb24gaXMgbWludXNjdWxlIGNvbXBh
cmVkIHRvIHRoZQ0KPiAJZ2xvYmFsIGxvY2suIExlYXZlIHRoZSAodW5uZWNlc3NhcnkpIGF0b21p
Y190IGluIHBsYWNlIHRvIGVuYWJsZQ0KPiAJZnV0dXJlIG9wdGltaXphdGlvbiB3aXRoIG1pbmlt
YWwgY2h1cm4uDQo+IA0KPiBEb2VzIHRoYXQgd29yayBmb3IgZXZlcnlib2R5Pw0KDQpXb3JrcyBm
b3IgbWUsIHRoYW5rcy4NCg==
