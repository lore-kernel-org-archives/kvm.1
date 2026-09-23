Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857B3D0910;
	Wed, 23 Sep 2026 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202412; cv=fail; b=E1CZOsVbTMdXQPLRiD+VS0iI9L5XX9nFgSjuUjbx3kUcfbulmWUX01SBlUcQ/lJKyIY/he8nfAM71HGgn/Uu8FmYsGBZgJ8d0racXq0NEkgXzim3KTBrAaVoV2xaygeTS6GfOAzmaybTcwm92Ldk24r5YeCdiXqxHLdUyF7RYNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202412; c=relaxed/simple;
	bh=vnEErchuGilofef39uz4EWPETJrk5VWWf/ZzZS+WGAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OMVtHvj3SGOy5wMvKEgFMhFEs9/86NmnOJJIZKx5VyajTLjA1sgMMga83EFmV/2ZKDnH10h49cOZrru1idX0u0cddz6q/lQG4B2y2KZMz8g9KwkK0KefLAAS8M8u/US0sSsxNusk95ZWCLh4ty10+yr5BSQ3DlXjEWA1ATbfuPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MnNRI2QO; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MnNRI2QO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790202410; x=1821738410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vnEErchuGilofef39uz4EWPETJrk5VWWf/ZzZS+WGAE=;
  b=MnNRI2QO10KR/eIHBGakAHB5EYRnVyDSNUxRM/HJP6u2fU+o9k6BgzvQ
   0YnNSXcc+zj2hDilHBMa0gGmk2mUzVOk8Vax1zdgwFSx+6T5ckEHUDfnj
   21XBk1IutAEpAbfdxoN3oT6bqBh1ACsvfJvZPsTVFhGI4DrG7evF3Yjt6
   z/c/YRoJ7WugXuQyJ5UYLm0o3saZWjSE7+Eybu8KwMvU45PPJhhBuUPE3
   eFEs7PPBf8t1/o4kzqM0/cQI+NXvv2h2T291d5Vgy66bevufOl3+AF9yR
   xYQdC/SuQuJwp5YxC7vsytU9J0EZNc/BjRbwxfhfhMvbxMOHOm8C8BKyt
   A==;
X-CSE-ConnectionGUID: YT/oYdd4R+WSIFDGeMoyvA==
X-CSE-MsgGUID: oERZpLqpRieunyOvjomPMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="1450011"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="1450011"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:26:50 -0700
X-CSE-ConnectionGUID: oxdYk17+TYeMCBzhzkkkLA==
X-CSE-MsgGUID: QKw4gO7UQVOiTIw/+LurCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="4923481"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:26:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:26:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 15:26:47 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:26:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTKZmgGRipeqXWg7LJ0I7ZHSQAqT+ROVmdxOkqfGFZRA525oFIRn3hl/fzRA5TR0Wabs9vgvXaFiwPaSlVoAkGj4u55ztVbAwc2rIRCI5JZVc+5X9et0Q8RE0UHKNsJZlCFHrZqYT3i+3iECHwj5Vr0QDr6U8wYd2qju3YWGpGn766WxHs16BwU5+VcurYc0BCqQgteAELjf05q/amcj3ie4TBylD5kX0fnU91s0Q+5f1LeKLDumTyndPu5fQTXlgwRS9px73fniQwmjuP9Uf8Q5d8WpE5PADtye6c3OZt240aZCgScgDhc9vvme+4VA8x194c40feqijjxnAEKtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnEErchuGilofef39uz4EWPETJrk5VWWf/ZzZS+WGAE=;
 b=nutmJhJEtmslyVcrZE/y9WG7szU7LfyOJQqNmvxyDvqJ1MYoWE5SuiWnRcZfTGkt/5m2odXq++LpmsJKiFs/QyrH+/CSzsNhewgDlxWR3JHqS/aw3T1lcktDx4q/z/DA8SvB9AX0OcA67WCZbJiJuAn/hScJgLC0Dfw4bU6fQza0393OaYY0fwnktXOZQ5qGuHw2eqIFyanW1fy4BtZ8vmKLb6gtjLP8dGCcaf73nqtM2TN7loogWyG/ltT1WKbWG/MNfo3wM63Qz1qeblH2BbRDoUCQBqLr8EzOrZLcM+cufPEGdCkJ+qsLJpknuUbnvKNtsLCpo4zahb9UG71h9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 22:26:40 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 22:26:40 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v2 02/10] x86/virt/tdx: Convert the version metadata
 reader
Thread-Topic: [RFC PATCH v2 02/10] x86/virt/tdx: Convert the version metadata
 reader
Thread-Index: AQHdR3IW9Vo4ecSFX0OAytf8FV4/R7bcxk+A
Date: Wed, 23 Sep 2026 22:26:40 +0000
Message-ID: <390fc4d56769f87d91949e900262640b52b505b7.camel@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
	 <20260918132946.76533-3-chao.gao@intel.com>
In-Reply-To: <20260918132946.76533-3-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|LV1PR11MB8850:EE_
x-ms-office365-filtering-correlation-id: 30bbf9e6-0006-4fda-c225-08df19c1bd3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|38070700021|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 9i57D/JEV38TN2QdjsYNb6aWGqgq3hk9aeaurB00bVIgXaw8WewIeiGhwTAdLTPLzB2yDtXnYKqsb/0oW427UsCCA2LUigTolzKSp+bZd4sn1I0460FjnyDymbQcRwMiPpsdmGNGGkT0rRa3bdKYPtaIdEvRfSo6JuIvwNqKwZNR7y1kYxweUsOswMAtAcKipGYOMQsTmGOnhZoTGz8RZySRBfNQHUnBrbjgLviepidHtaKvRZ0yqBQjLGmN5I2r/Hf14m1FYz1Bc7TInmQK/1u0bMrXKBZhrISfpvIFkDOLa02ask+zsDWiE1fMJX6P3MYwKKaTbuGOLn74wdAuQpbYF6ZqGJRgys5Ar+yC/lsXEhBMkD8MolhpR+bZ7uc7WhTYyf6FEBCUNhNwISKJnGarpHFSUjuvb03MJFAOD7c+I6u9NEUR6gf5uS5IGoUXTf8oIYvbnOjOVJftm4AkdCCyk00lIKZ6uryDjiqgkWArdiYolAbBWWS6fniw6EXLULOmpArw6s5HX9A1I6jeAI0k3ZfjpBblp6HS9yT4rLNXVrK1a3dI4GMzGoNbE7jRC6laBOemiyKx7h/C5rUDMQ8P3k9hUQ9AUFr90GDT4DXQFOiyU4zMPVCg8I/zKhLN3CFxAQPQPcIUS7Zp+OPXcQm6Za6jN85nok/9tjkbypAuVZMhysVJL9e+p4P1VG3TnU5yIUDDag0yzATjV9H4r6WHbHJCVoT3Pz0rKe+bJNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk1xUXRzb0ZVRnY0RWg1RndBdkkvdTcyN21POE4xQmlLdm96VjQ2aVd0ZEll?=
 =?utf-8?B?WlNhMXRMbTQ1cWZSWFFsbXRrWEVnSXRPcTAydW9jajh0L2pqbU9sN1BKMTJC?=
 =?utf-8?B?N0tQTVFYNDFocGpvbFpCM2F3bWVsdHZkenJSNlI0UTlVRnFOZENiYi9FQmF2?=
 =?utf-8?B?bTNCcUJ6MXVmZ3g5Y2dpNm1uM1NybFY1U2lPYXhKYWQwQ2lMbXFicGg3RkZV?=
 =?utf-8?B?UXV1TFQrcE9VY2pTcTdvaTlRWk1wL0IrQXVPMDNkandJdUpKMjk0bklTM3VG?=
 =?utf-8?B?a29nMjBLYS82UlYyZE96U1llTkdkSlFSd1VWWnpqNzJJWVFXTzE3SnlPT1dx?=
 =?utf-8?B?TWJUclVXUkJwd1I3M0RDa3RYVnBjSUpLb0hOSEErQkVNaHhJbiticmNLdUkz?=
 =?utf-8?B?TVZQNjdMZEZaZTFJM1R6aGt3bmdKYWNGTWpLY29PSE1KN3N6TGpYSHlJcy9T?=
 =?utf-8?B?T2xoYy95bnJ5OG9mQTdXWnMvbEc1SmlXKy8rMUZhUmJRd1pYNURPd1g3Uzlp?=
 =?utf-8?B?OXJ3ME40T3pydGd6THlSL1MyM0M1blphZW1NY01EMmxqdE9nUlJBSVZLVUND?=
 =?utf-8?B?REpEYkF1WTF6R1JFcTVuVGF6ZXE4V2lPWmpNdGtqZ0o4U3FHTDNTQkdNak1s?=
 =?utf-8?B?TEtYbWxTWWVCMDlianZkc3BGbWIydHkvbTlYeGZZTFB5K2ZoQzFzVUNlTlhv?=
 =?utf-8?B?TmxvVE56Tml2clQxZnhlNktnYWRQbmRzQ1JFOTZQb2dPVmpaRytaM3lTTXQ3?=
 =?utf-8?B?b2JNMjdSMldVdkVDcG12QWoxbjBHNENFQTdVU0J4aW1VdXBXU2IrVWszZGh5?=
 =?utf-8?B?VEpIWTZEWWpWL1JCTzdlSFVBanJXcmdXMlRUb21zZFBvaUh3K0JZZVprV3Bh?=
 =?utf-8?B?Wkt3VG1DWjl4TW92eFVQb0kvWVRqSms4WHViT3JsTm5vY1MvTmwxWXF4eG00?=
 =?utf-8?B?ZG1uclkrRk04OEJ6dXZzT2hOQXpvNkNkby9KMXhTRG5PaEhIc0lVN1g2WXp0?=
 =?utf-8?B?UkhVUVdFWFB6R1o0eGdtbVVWeW1DaUpMZ3QrOUpOTHZTZ0pWQm5yV1NVb3JE?=
 =?utf-8?B?ODdpM0RoK2JIUEdKVW45TEcyOEdiaU9KWDRtR3RGOTBYOG9WL1QrblMrU3Vu?=
 =?utf-8?B?TEVRbDFpOE1zL2ZYeVpyV3M4ZlF6WWFtQWFTMWQxZ0t6SE1JUEtZaTdGTnNu?=
 =?utf-8?B?MzRhWk96ck94ODNiSlRrTjVTaXM0V0tIbmZZVGFobE0vYkZCTStHNWR3Y1pJ?=
 =?utf-8?B?cm9VMW5nbmxOUE5OT29hbE1xWkpMUi9Bb2dFWWxRaGxpeW5MaThSRU8xN2tL?=
 =?utf-8?B?ZlZZbWNlRVJkVG1QSWNaY1BEdFEvNEJvd2xUZkdrQ0NvRnhhTnI5TGM4czZN?=
 =?utf-8?B?RHRBUUZET0sxTGxReHN1SFdhcENPclhFeWZvSmdiRzlFRnN6OStxQkZxL0Jz?=
 =?utf-8?B?VzNYckc4NzNDSjNoV2hMZ3BNd2F5aHdRZ2o2NkJYYVpWWFRGVDBFSnQ4RWlN?=
 =?utf-8?B?SDZMUVNWWUh6QzRWbUFwQkNuekRKUldLVTIvZFA1SWhxaTB1aHhSNFVDMGNh?=
 =?utf-8?B?NE1Zdm9kNmFmdGZKdks4aWNHYjBlaHJEL2dOaFp4UndlcGZ6V3BhNnp1NXd0?=
 =?utf-8?B?a25mNDFadXh0UTBkOHREenFRaEtRUVA1RVl6cStjYjBJZjdXbWpQbGlyTDIr?=
 =?utf-8?B?eEUvYm0zdjF0eTdIRUh6cFN3eEpXRDZORHNWMEx3Yy9pNm03aXNSeWpyMkFt?=
 =?utf-8?B?TWkzNEN6ZzJka2l6ZTkzZUZvZmdSbXB3QTF1TVhPOHA3UlgrNE10aitGWDl1?=
 =?utf-8?B?RndOVSsvd2N3L3V2L3FsOGludk02L2NUclRZSTRPaWxzQTFJZnFjanBDV0Y4?=
 =?utf-8?B?ZVArbTllNThSTm8ybWhzVDlTdnNLYm53V2RxaUhUZk1zdS9tMHJzMm5tZjNh?=
 =?utf-8?B?ZXJSdmMzS2pUM2VyM0tqNUh5RFJQT2NiUTArYUxZWEdnOERXUFppekhydytl?=
 =?utf-8?B?ZXRJWi9IaHdDU2xMZmVaR1hQZkFjMzdVaFVXcmJYVmZSTU5UTm92K0lpeXdT?=
 =?utf-8?B?S2RGWjY2djVWcjFOdjFmRjJUWlk0dHIwcnVBWmdQYlFyVERTYWNlNG1oRUhI?=
 =?utf-8?B?TDR0bXA1c1BmeEZLbHVnclI0UXZMRzVJcVNTNHNKZzYvVTZiT3FWaGwxRkRN?=
 =?utf-8?B?WSs2K1hxK0gxaVNienNxWmNEU0RVdjlRNlltbXlxN1Y0M0FuVnQzTmdnV1VH?=
 =?utf-8?B?Z0FGWlpVSVg5Z2dqeTRqa3FEQXhTM3UzYWZteGIyalZDMm93a1B1ZVJJR3ZN?=
 =?utf-8?B?UFJJcThEano5cGU0dnhBdjBnTWZ4enAwL3JLRlJiNjZwL0d1a2xMcWJkMlhH?=
 =?utf-8?Q?iu0Iw5c8tORhUuhM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA78F0BFE25C494090D33A10F391AE8C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xwMYm//Vxbd0/SwMgmJC1nHU42C/95wD5runAIER/CgJkUWNxB5l2Vfo8zuwGj9JFUTRsNh8kMuulrDJIT6gVZQiSdTK0FdHLht/NbkFX4MAQOADs1ckWjrmkwUG2bJtTNoLW/Any0TukrceDZhLaf4T+xdHo1vjf7H9b9KCqlQWYX8VEKcrqZok3t54YGaNKhdys7OgJj5FVbwAa83U9CYo4Zs5m8A/F1XAerPHeABz4VhhB+nKTd5Y9j82ZCWyWPam1tJ6VvfqtJU6fXbjyqL8dyP9NF8cy/TCcO9LgdKnkOUPyqWjxors66VyJpPFJP6jrhKk+/zaRuUqBnGSGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bbf9e6-0006-4fda-c225-08df19c1bd3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 22:26:40.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aW0q0jMVcy2J4hl5oEWcYMFcPT5eDKQJRj91UkzwagmoFOIgtP8zJ1Et3Fop/0z6bVyxxeu6e1JGxz086GKNMVi9wYFQiXF74VYqjWUQZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTE4IGF0IDA2OjI5IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gV2l0
aCB0aGUgaGVscGVyIHRvIHJlYWQgYSB0YWJsZSBvZiBtZXRhZGF0YSBmaWVsZHMgaW4gcGxhY2Us
IHRoZQ0KPiBleGlzdGluZyBtZXRhZGF0YSByZWFkZXJzIGNhbiBiZSBzdGFuZGFyZGl6ZWQgb24g
aXQuDQo+IA0KPiBDb252ZXJ0IHRoZSB2ZXJzaW9uIG1ldGFkYXRhIHJlYWRlcjogYWRkIGEgdGFi
bGUgdGhhdCBwYWlycyBlYWNoIGZpZWxkIElEDQo+IHdpdGggdGhlICdzdHJ1Y3QgdGR4X3N5c19p
bmZvX3ZlcnNpb24nIG1lbWJlciB0aGF0IGhvbGRzIGl0cyB2YWx1ZSwgYW5kDQo+IHJlYWQgYWxs
IHZlcnNpb24gZmllbGRzIGJ5IHdhbGtpbmcgdGhhdCB0YWJsZS4NCj4gDQo+IE5hbWUgdGhlIGZp
ZWxkIElEcyBmb3IgcmVhZGFiaWxpdHksIHNvIHRoZSB0YWJsZSBlbnRyaWVzIGRvbid0IGNhcnJ5
IHJhdw0KPiBoZXggbGl0ZXJhbHMuDQo+IA0KPiBBbHNvIGFkZCByZWFkX3N5c19tZXRhZGF0YV90
YWJsZSgpIG1hY3JvIHRvIGRlcml2ZSB0aGUgbnVtYmVyIG9mIGVudHJpZXMNCj4gd2l0aCBBUlJB
WV9TSVpFKCkgc28gdGhhdCBjYWxsZXJzIGRvbid0IG5lZWQgdG8gcGFzcyBpdCBzZXBhcmF0ZWx5
Lg0KPiANCj4gQUkgd2FzIHVzZWQgdW5kZXIgc3VwZXJ2aXNpb24gdG8gcmV2aWV3IGNvZGUgYW5k
IHdvcmtzaG9wIGxvZ3MuIEl0IHN1Z2dlc3RzDQo+IGFkZGluZyByZWFkX3N5c19tZXRhZGF0YV90
YWJsZSgpIG1hY3JvLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBHYW8gPGNoYW8uZ2FvQGlu
dGVsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgICAgICAgICAg
ICAgICAgIHwgMjEgKysrKysrKysrKysrKysrKysrKy0tDQo+ICBhcmNoL3g4Ni92aXJ0L3ZteC90
ZHgvdGR4LmggICAgICAgICAgICAgICAgIHwgMTAgKysrKysrKysrKw0KPiAgYXJjaC94ODYvdmly
dC92bXgvdGR4L3RkeF9nbG9iYWxfbWV0YWRhdGEuYyB8IDE1IC0tLS0tLS0tLS0tLS0tLQ0KPiAg
MyBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9hcmNoL3g4Ni92aXJ0
L3ZteC90ZHgvdGR4LmMNCj4gaW5kZXggNWNkOWM2ZWI5OGMyLi4wYzhiNTcxZjUxODYgMTAwNjQ0
DQo+IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiArKysgYi9hcmNoL3g4Ni92
aXJ0L3ZteC90ZHgvdGR4LmMNCj4gQEAgLTQwOCw4ICs0MDgsOCBAQCBzdHJ1Y3QgZmllbGRfbWFw
cGluZyB7DQo+ICB9Ow0KPiAgDQo+ICAvKiBSZWFkIGVhY2ggbWV0YWRhdGEgZmllbGQgbGlzdGVk
IGluIEBtYXBwaW5nc1tdIGludG8gQGRhdGEuICovDQo+IC1zdGF0aWMgaW50IF9fbWF5YmVfdW51
c2VkIF9fcmVhZF9zeXNfbWV0YWRhdGFfdGFibGUoY29uc3Qgc3RydWN0IGZpZWxkX21hcHBpbmcg
Km1hcHBpbmdzLA0KPiAtCQkJCQkJICAgIGludCBudW1fbWFwcGluZ3MsIHZvaWQgKmRhdGEpDQo+
ICtzdGF0aWMgaW50IF9fcmVhZF9zeXNfbWV0YWRhdGFfdGFibGUoY29uc3Qgc3RydWN0IGZpZWxk
X21hcHBpbmcgKm1hcHBpbmdzLA0KPiArCQkJCSAgICAgaW50IG51bV9tYXBwaW5ncywgdm9pZCAq
ZGF0YSkNCj4gIHsNCj4gIAlpbnQgaSwgcmV0Ow0KPiAgCXU2NCB2YWw7DQo+IEBAIC00MzEsNiAr
NDMxLDIzIEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgX19yZWFkX3N5c19tZXRhZGF0YV90
YWJsZShjb25zdCBzdHJ1Y3QgZmllbGRfbWFwcGluZyAqDQo+ICAJLnNpemUJCT0gc2l6ZW9mX2Zp
ZWxkKF90eXBlLCBfbWVtYmVyKSwJCVwNCj4gIH0NCj4gIA0KPiArI2RlZmluZSBURFhfU1lTSU5G
T19NQVBfVkVSU0lPTihfZmllbGRfaWQsIF9tZW1iZXIpIFwNCj4gKwlURFhfU1lTSU5GT19NQVAo
X2ZpZWxkX2lkLCBzdHJ1Y3QgdGR4X3N5c19pbmZvX3ZlcnNpb24sIF9tZW1iZXIpDQo+ICsNCj4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgZmllbGRfbWFwcGluZyB2ZXJzaW9uX21hcHBpbmdzW10gPSB7
DQo+ICsJVERYX1NZU0lORk9fTUFQX1ZFUlNJT04oTUlOT1JfVkVSU0lPTiwgIG1pbm9yX3ZlcnNp
b24pLA0KPiArCVREWF9TWVNJTkZPX01BUF9WRVJTSU9OKE1BSk9SX1ZFUlNJT04sICBtYWpvcl92
ZXJzaW9uKSwNCj4gKwlURFhfU1lTSU5GT19NQVBfVkVSU0lPTihVUERBVEVfVkVSU0lPTiwgdXBk
YXRlX3ZlcnNpb24pLA0KPiArfTsNCj4gKw0KPiArI2RlZmluZSByZWFkX3N5c19tZXRhZGF0YV90
YWJsZShfdGFibGUsIF9kYXRhKSBcDQo+ICsJX19yZWFkX3N5c19tZXRhZGF0YV90YWJsZShfdGFi
bGUsIEFSUkFZX1NJWkUoX3RhYmxlKSwgX2RhdGEpDQoNClNob3VsZCB0aGlzIGdvIGluIHRoZSBw
cmV2aW91cyBwYXRjaD8NCg0KPiArDQo+ICtzdGF0aWMgaW50IGdldF90ZHhfc3lzX2luZm9fdmVy
c2lvbihzdHJ1Y3QgdGR4X3N5c19pbmZvX3ZlcnNpb24gKnZlcnNpb24pDQo+ICt7DQo+ICsJcmV0
dXJuIHJlYWRfc3lzX21ldGFkYXRhX3RhYmxlKHZlcnNpb25fbWFwcGluZ3MsIHZlcnNpb24pOw0K
PiArfQ0KDQpJJ20gbm90IHN1cmUgd2UgbmVlZCBhbGwgb2YgdGhlc2UgaGVscGVycyB0aGF0IGFy
ZSBlYWNoIG9ubHkgY2FsbGVkIG9uY2U/DQoNCj4gKw0KPiAgI2luY2x1ZGUgInRkeF9nbG9iYWxf
bWV0YWRhdGEuYyINCj4gIA0KPiAgc3RhdGljIF9faW5pdCBpbnQgY2hlY2tfZmVhdHVyZXMoc3Ry
dWN0IHRkeF9zeXNfaW5mbyAqc3lzaW5mbykNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQv
dm14L3RkeC90ZHguaCBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguaA0KPiBpbmRleCBhODg2
YzU0ZGVjYWEuLjQ0MTI0ZjM5OTcwMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvdmlydC92bXgv
dGR4L3RkeC5oDQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguaA0KPiBAQCAtNjAs
NiArNjAsMTYgQEANCj4gICAqLw0KPiAgI2RlZmluZSBURFhfVkVSU0lPTl9TSElGVAkJMTYNCj4g
IA0KPiArLyoNCj4gKyAqIFREWCBnbG9iYWwgbWV0YWRhdGEgZmllbGQgSURzLg0KPiArICoNCj4g
KyAqIFNlZSAiZ2xvYmFsX21ldGFkYXRhLnBkZiIgaW4gSW50ZWwgVERYIE1vZHVsZSBBQkkgRGVm
aW5pdGlvbnMuDQo+ICsgKi8NCj4gKy8qIENsYXNzICJURFggTW9kdWxlIFZlcnNpb24iICovDQo+
ICsjZGVmaW5lIFREWF9NRF9GSUVMRF9JRF9NSU5PUl9WRVJTSU9OCQkJMHgwODAwMDAwMTAwMDAw
MDAzVUxMDQo+ICsjZGVmaW5lIFREWF9NRF9GSUVMRF9JRF9NQUpPUl9WRVJTSU9OCQkJMHgwODAw
MDAwMTAwMDAwMDA0VUxMDQo+ICsjZGVmaW5lIFREWF9NRF9GSUVMRF9JRF9VUERBVEVfVkVSU0lP
TgkJCTB4MDgwMDAwMDEwMDAwMDAwNVVMTA0KPiArDQo+ICAvKiBURFggcGFnZSB0eXBlcyAqLw0K
PiAgI2RlZmluZQlQVF9OREEJCTB4MA0KPiAgI2RlZmluZQlQVF9SU1ZECQkweDENCj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHhfZ2xvYmFsX21ldGFkYXRhLmMgYi9hcmNo
L3g4Ni92aXJ0L3ZteC90ZHgvdGR4X2dsb2JhbF9tZXRhZGF0YS5jDQo+IGluZGV4IDk4ZWJmMTdh
YWIxYy4uOTUxMGJmNWY2ZTdkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgv
dGR4X2dsb2JhbF9tZXRhZGF0YS5jDQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHhf
Z2xvYmFsX21ldGFkYXRhLmMNCj4gQEAgLTcsMjEgKzcsNiBAQA0KPiAgICogSW5jbHVkZSB0aGlz
IGZpbGUgdG8gb3RoZXIgQyBmaWxlIGluc3RlYWQuDQo+ICAgKi8NCj4gIA0KPiAtc3RhdGljIGlu
dCBnZXRfdGR4X3N5c19pbmZvX3ZlcnNpb24oc3RydWN0IHRkeF9zeXNfaW5mb192ZXJzaW9uICpz
eXNpbmZvX3ZlcnNpb24pDQo+IC17DQo+IC0JaW50IHJldCA9IDA7DQo+IC0JdTY0IHZhbDsNCj4g
LQ0KPiAtCWlmICghcmV0ICYmICEocmV0ID0gcmVhZF9zeXNfbWV0YWRhdGFfZmllbGQoMHgwODAw
MDAwMTAwMDAwMDAzLCAmdmFsKSkpDQo+IC0JCXN5c2luZm9fdmVyc2lvbi0+bWlub3JfdmVyc2lv
biA9IHZhbDsNCj4gLQlpZiAoIXJldCAmJiAhKHJldCA9IHJlYWRfc3lzX21ldGFkYXRhX2ZpZWxk
KDB4MDgwMDAwMDEwMDAwMDAwNCwgJnZhbCkpKQ0KPiAtCQlzeXNpbmZvX3ZlcnNpb24tPm1ham9y
X3ZlcnNpb24gPSB2YWw7DQo+IC0JaWYgKCFyZXQgJiYgIShyZXQgPSByZWFkX3N5c19tZXRhZGF0
YV9maWVsZCgweDA4MDAwMDAxMDAwMDAwMDUsICZ2YWwpKSkNCj4gLQkJc3lzaW5mb192ZXJzaW9u
LT51cGRhdGVfdmVyc2lvbiA9IHZhbDsNCj4gLQ0KPiAtCXJldHVybiByZXQ7DQo+IC19DQo+IC0N
Cj4gIHN0YXRpYyBfX2luaXQgaW50IGdldF90ZHhfc3lzX2luZm9fZmVhdHVyZXMoc3RydWN0IHRk
eF9zeXNfaW5mb19mZWF0dXJlcyAqc3lzaW5mb19mZWF0dXJlcykNCj4gIHsNCj4gIAlpbnQgcmV0
ID0gMDsNCg0K
