Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69348369985;
	Wed,  1 Apr 2026 23:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087943; cv=fail; b=YOYB17peZZpqSKaCht42eSTcvjghcErwLRx+8BwSq+E2zPABbHqNAf28jVwmsyZb1mBdMDxKnr4AX6rLx32Fugke68wmwqTx7P1GUgfSOe9TVsLDxNxVuFcRseV6pumVno/Pwgkg6N0pCgUbq/CB+btHEpbMP1AuQj8h5w8Q08o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087943; c=relaxed/simple;
	bh=/J4RBXll8Z+bG4pLpUS7NoMkRz3uwFjmVSgY/AS4pCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a189WR5/efFmeoy+YMFHQH23fZxRH4++hM2Qhc9z77zImvQT9w6o/j/168tl0iDPjIsoHsyORGjBIF0U64FWpzxk6bLERY2l7TyZgmphccqUSaJNy58CsiTNAay9RZAFKlJbhgRuPQvyOaRSkCjAXYwUMgQKEw+2UdJEAFsHwwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C86TjhI4; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C86TjhI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775087943; x=1806623943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/J4RBXll8Z+bG4pLpUS7NoMkRz3uwFjmVSgY/AS4pCI=;
  b=C86TjhI48r97pTrjGTPjpAgBvd+F3Md8QnbluVxNy0zvXH4hvDc6WEBZ
   FSvcZGaYgYRrGOxVsnyuRDexiUBCuO77O4mCktNw8qT+GLeHGI5uZKoWx
   GeOy1KvxBjO6MEYbMdzbBsorgTRjcJFeCddWWm90kk0qvMyLN2Lcy5hFR
   ROFko65FV753JFA2Herd1lPHUviuyb2Jp6jaI2f6jNHg8xnAOOW2032mO
   Q3Eh5nTT5OqOG6BNxG5wRkZugDxf7D/Ogz0RdM3EpNyHogLl35hWMM47i
   VyDqUmb+jP+5b0y8idGkMv2ChXlJYB9SnBCm85oU4uhHwIRh30mR/7OCz
   Q==;
X-CSE-ConnectionGUID: 930VVyYUTxuCQIeaHef4cg==
X-CSE-MsgGUID: pumGrdzoSQmGgN3Jq+m4yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75858627"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75858627"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 16:59:02 -0700
X-CSE-ConnectionGUID: HKmf6h4nQfeFjL1cWJqzcw==
X-CSE-MsgGUID: xVaaGmebTmWP/zgGDNTM9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="231761038"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 16:59:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 16:59:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 16:59:01 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 16:59:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Al1ED8Tp7nVv/+bQhaCEPkKOunqXYotIyXzGqvBZdK5BgHLPhcXZbm8qvZ/KKr2BxvHEVaipGF5jc18zaWLpiEf8J8xc6aHUXcE7n6H3tKyjxjQWm4U+Hr3WTMv8PUpJXkmYhaBRCbU6AfrbyJsZRG0BsEM6//cMcX4gXr79du6kgAGB5GggBKcHw3GmUumKcyYI9Y4J2IXFy22JfCFeF8V1h/bSLM7eTwKVOBeVOS+q4nHvm8Qgmsn1ClCOvnj2bt/+/j3lVbR9wJNixW56sKLL6wrvNMljpkxjOa1KFF9WDiphStnzk/oGV4XYvOeH47xFNh8bna30vzuHXWoJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/J4RBXll8Z+bG4pLpUS7NoMkRz3uwFjmVSgY/AS4pCI=;
 b=Yadf1OEk04mbPXQILJsgfMbLyjZ4tTVXi4aNQesHE5W4PsTEq7/HQ7letxzgVOlhzhTWLYdyUgFSve4/vhh2GsznUvbmZFzf9JWv+/2XeIgkwulhLhTrja8Qhq6HPyLPPdUagOBPF7LK4GPpYGBlj0zlXFVBfIapzxzvPcsJZU9YzDn7t7NXi0+lz/jCQ9CRGv/eCi1t6z3ttrSHpC43r7mAeTRjxTEI16wePRoajFbEz2ZMaLi5vVOZCMzDBOTPaKYwu+2KWvigERdFat0sZkm0JGQ/lfuQPon3VudvFMZc6K+qrojfAVK/Y2IJcJVqcarky5+DqISTs1RrnB4WAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ5PPF7371775FE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::834) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 1 Apr
 2026 23:58:58 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 23:58:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Topic: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Index: AQHcviZXKVkTxmL/NkWOkEaa1Zh4L7XIcI0AgAJ6J4A=
Date: Wed, 1 Apr 2026 23:58:57 +0000
Message-ID: <af52f6122e158c8804ff8661e979101079c4caab.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
	 <63caca29904f7d7d657ed54f71be1e066b422a9c.camel@intel.com>
In-Reply-To: <63caca29904f7d7d657ed54f71be1e066b422a9c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ5PPF7371775FE:EE_
x-ms-office365-filtering-correlation-id: 332582e2-8ff5-4c83-8f84-08de904aa395
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 2lrHEA1W1bA0IS6OcVD7mWvYcNwWfEdqThdBAv8ypDNy+iGvp56UhuCKc5zHdQbF4z6EOu0OItgs5mHupeG4aQl3kcpqzIrOo/Okwxar7HDVG8XgZhlrHIypzAiEEWEgbrvA5XlW659LCAuHsZY4dgw9Eu2fnxj398MQK6byYewJMFe1RFP56HpZ3rx1d+kqP7lmI1SFy+WjVGWnOKLcMkPiGoJj1QxGVrfV2KMLRLv1CClmLfI824LV/Ld15mJOQNqi40LfmWNUQLaFUTVSGv82Eqf7CIoeCWwJXivDU1G5rS/tgROT5ivyXhvQvHEVFZ5LeuJxuCQ8DO3nuPC5uhQ+po0Ao3acB/H8dBAgL6nTzZPLlrBw6h28hGObWiD8TJudBGLiOAf8mDmHs6TQZRITdldHIpfVmtw2U6OACYeTLXNd/DwP9y75TO1G2FijOeUCV1MqsRRkPhuQtztpsepeaprKX6jN2ilNPA3W8upqk/Q/JGDhJuXfyDtxZzF1ujtLD+fpjLwKhH959rh53WcwWqFDQzfIn6hnjGVSlwWpN/8zuwYmIEvqG7EKXuxXvjVs5inTboR/HLif0tR/QdjLYsB6+Wo/SWFZiGCJH2ThFlX0rBOAegFJk2SAPBW0V9lH7O5zAe1p8rUiTx6j/wRlemYrJjVqZdVnzlXHpZ5IBIErHF1QBG3uLc3krSEwl+VJxJWZkq+2W5k1zZhcTqAJ+xyy9/klYKVG4LbwgvYCtE22frF11uF6t3JIoOdE+Q5hMwNeysdQtaOmD6SumP51PYtFXl+vMfZU9CICFOo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnBBNVJIR3VzWE1odHF0NW11YmhwbU0xaWhkNm80MExtYTZrV3d4TmNYWDlj?=
 =?utf-8?B?ZXlNSzJiK0RYMlErTkgvYXM5M1creVFFb0RIb3VBRDJhNkFBWFIrUTAvenpt?=
 =?utf-8?B?aGlHcmtmYmVNS0gvUzNsQTZZNHVXMWtxaytzNHptNlJmQlZYTi9LazlRUkNM?=
 =?utf-8?B?Q2s5N3U0WVpqdEozdjRIb0VXOHJlNi8xU3AwcHdzaXdqZEh3bGIveGdFbTdR?=
 =?utf-8?B?UlhwNnRSNHNUdWpIYmJ2OU1nSW9IVUdpQU1jVGo0R1h4RFdVZlJod0VkbFZR?=
 =?utf-8?B?M3g3SWtRc2FPMFFjNi82MnNvUkVheHF3ck84RjRQTnBmSG5vNHpmMkxFR09v?=
 =?utf-8?B?RldTZTF5T3lVL0dkRWl1SGcxcmlNMk5OdWk0bnFqZEllcTk3UFRpT2oxby9F?=
 =?utf-8?B?dEJqRCt4bGVaSENlMTJsRTJSR3NYMk1Qa0pCbEdiYlROSnpLWithcnkzM1N2?=
 =?utf-8?B?RUJCZTVsbVNMUUlwSnVCOE5BaDY1eFNRMDFmZHVlcUFPUWVJdU1YcDYwc0pr?=
 =?utf-8?B?QkNTVEprc01QdDFQcDRGaFoyaVlHQ2ZSRVNXMUp6VkdHV2c2aS95Z09aOHJG?=
 =?utf-8?B?enZTbmo4RFgxWFhrb0lvYlVrNElqd1kzN0ZuK3crZ3FGNUpYRVlQUzlwZFU3?=
 =?utf-8?B?aVBpd1d3ak0rTitCclpETDV4b2ZITHQ1OTl2b3FkRnk3ZHY4a3pPUElZWW4w?=
 =?utf-8?B?dGk2TzNnOHYrRUJIWjJkN1U2anhvTVp5aUU1b3ZvYnlKMGkzZlpCc3pwVFR2?=
 =?utf-8?B?UjFUQk5GUVhkNlZsM01lZjRaanEyYlg2Qkc2Zkw3ZVdwT201OWhLeGRJNVRR?=
 =?utf-8?B?L1dIZ1hDTW40dFlmUXV1dEVHcUZ1dlA1VG1INUtmTVJzanlSeVhKSWMzanZU?=
 =?utf-8?B?d0QxRURKRDYrVGpiYWFjdkF4a3FqWUpQcHF1b0FwUUNtWXl3QVNFTE1ObEg2?=
 =?utf-8?B?QTM0cERZMm1sQitycVBLMFFGQWxzQ0FRQXBVS2RvaGt4bmdSMnpMWTJXUGRK?=
 =?utf-8?B?eUpBNDI4OUY3UGlLc3Y5RERDOUhwVlBnaDVId25sUUdvY01Fck90Y0F4RFJn?=
 =?utf-8?B?ZjFPNG9xbUdlckZZNXIxUU5nQWt4NnlsSlJmYktka2lLaXRURVNZeDUzblJl?=
 =?utf-8?B?NGw4K3pZSGZVbVNtZldNN2d2MFNaR1VvZ1gxYnoxRTQ4a2F4WlZiMnlSbG9y?=
 =?utf-8?B?RFN3OHErS2xUVmpEYlR1NmtmVzZtd0hvTzNScDd6MmNKQ0cyL2IwSCtWbTJN?=
 =?utf-8?B?dVc1QzVVSFhqYk9NeFhxWW1XME1MN0orMVN1cENPckVmWWF4OVlYR2xJenlK?=
 =?utf-8?B?bjBpMjJaRlp6NzhJYnFKUWJSeGZIK2NTMTZJcUtYTnhjUXIwS1NxNzlhaGpV?=
 =?utf-8?B?dk5FNkpjbXNzQTJlbkw5NTN5M1FrNW1XYUxDK3JCSW4wRlZTUXZhWllTTmlB?=
 =?utf-8?B?RitWdU52WlM3TnF4VnZnSHRDcGJvN2tlSGVMZlllajluRkZNMndiWkdmczh1?=
 =?utf-8?B?M0tjQVVRZnB1QzhIY1VrbmVsWkhlclkvUkoydVdLVitGMWo0NTRMY2ZGcWRo?=
 =?utf-8?B?UElONlJtdHhucERkZ0ZSVkxGNWs5MmpZRWhBamJzYzlNRjNucG9hLzdKWkNp?=
 =?utf-8?B?RGFSUzcxTjFzbUhtL2lCRlZHVnBEYnNHNkRLclBrK3JiOGl0cjM0VFZsUDdl?=
 =?utf-8?B?Q3kvOUZyUWZNb0s0U2I2bVhHNnJScVRqYTRLd2RsbEJjYmxjajNXUnB2M3dD?=
 =?utf-8?B?dEk4R240MVVOZGRiZmQ0WFNjNDkxaTVRYmxxMktaR251Ly9rNi9QamFvb3RG?=
 =?utf-8?B?NFNhRnY5TnVPYnBBWGw5UmlBN2JYV2xKTThJT2xaR2p1MVE2QnZTVWkrMDhW?=
 =?utf-8?B?NXVmU3ppZGFsWkFZRUdXQ1BmK0F4UWN5eUxrZGJRZjZId2dGbzlZY01sWUxp?=
 =?utf-8?B?cnFNUXI3OWpUN3NsbGc4WTVWTWUxbys4cGlBclJwVWhiSTI3Ulo5Q1JBallB?=
 =?utf-8?B?bWdRRXZCWEZ0SXBQWDI5cDFRQ3czRU1MOXdQb1J6K0w4TVhNNitrKzBiNGJQ?=
 =?utf-8?B?MVVFZlVQSm9nYzl2VWtSYXlYMDJVYVlQa3BGMTZSa1poT1dnQm1oZlIwNkhF?=
 =?utf-8?B?Wkc1T0p1QUV6bm1Ec2wvYUxoc2ZzczNpY0xWY1JjcU4yZmJCYWJJcU5PeEtx?=
 =?utf-8?B?REhORVdHR1FBRElIYjJ3VGc0SS85SngxcDBPT2NsZG5HWXJiY0JFakMvM3Rw?=
 =?utf-8?B?ajVHSmJLU2tMUFAyN3h3M1REUjc0RUI0R0xTWTJWcGM0YWZEam1HK2ErZkxB?=
 =?utf-8?B?NGEvL0w2cmZRcG9STDFjSTgyeW5VdGZES0xNMDNodytUK0ZzUEd0SDBFVWV3?=
 =?utf-8?Q?P3Hq934W1isxdXY8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <140213A7D6AD4448AB581DF506226FC1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gdW7+z59n42Uvk4//8l7jpt1HdAad//o3s7+/nQUMDrIzuPJWLtP0TcbmGsiyyaD1qPLE+6KNEhItjCZToVJYctScxzB6sLZe8wJ9dY3xp17FAgfFSZ5TjC6zTreK75g028xyOV22muj6P2wbRsQlaBT3yknBbNK6K29l/LRTNeOpRl4IqzP74T7OZUkqhaJCYNJmHsNSZ43g3pAXP5f7LDua5vqmdVuFHNOQA3fXDrIwXrxpXPX0vma5MEa6V1quVjcBmbaljBZuZe4Vqxv/oOzuQKA8aRBewRyh7qFwjD1NMk3UQctJ42blohKTXLkFHhB1+DCfM6uNZHaADszng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332582e2-8ff5-4c83-8f84-08de904aa395
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 23:58:57.9332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ad0PNtfK6ZYsdiWoIGbn0gRE22MmhzfZR89Ew7hVZCtV8qk8loNAhqoDPfmcI3g+ZJ7TIT3jlyGamsTGieM+Y13WpDhFYzgVMpI3ZMRTRag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7371775FE
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDEwOjA5ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
IEBAIC0xMzczLDYgKzEzOTYsOSBAQCBzdGF0aWMgdm9pZCBrdm1fdGRwX21tdV9hZ2Vfc3B0ZShz
dHJ1Y3Qga3ZtICprdm0sDQo+ID4gc3RydWN0IHRkcF9pdGVyICppdGVyKQ0KPiA+IMKgIHsNCj4g
PiDCoMKgCXU2NCBuZXdfc3B0ZTsNCj4gPiDCoCANCj4gPiArCWlmIChXQVJOX09OX09OQ0UoaXNf
bWlycm9yX3NwdGVwKGl0ZXItPnNwdGVwKSkpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4gPiDC
oMKgCWlmIChzcHRlX2FkX2VuYWJsZWQoaXRlci0+b2xkX3NwdGUpKSB7DQo+ID4gwqDCoAkJaXRl
ci0+b2xkX3NwdGUgPSB0ZHBfbW11X2NsZWFyX3NwdGVfYml0c19hdG9taWMoaXRlci0NCj4gPiA+
c3B0ZXAsDQo+ID4gwqDCoAkJCQkJCQkJc2hhZG93X2FjY2UNCj4gPiBzc2VkX21hc2spOw0KPiAN
Cj4gQUZBSUNUIHRoaXMgY2h1bmsgaXNuJ3QgcmVsYXRlZCB0byAiQ2VudHJhbGl6ZSB1cGRhdGVz
IHRvIHByZXNlbnQgZXh0ZXJuYWwNCj4gUFRFcyI/wqAgU2hvdWxkIGl0IGJlIGluIGEgc2VwYXJh
dGUgcGF0Y2g/DQoNCkl0IHdhcyBiZWNhdXNlIHdlIGxvc2Ugd2FybmluZyBjb3ZlcmFnZSBpbiB0
aGlzIHBhdGNoIGZvciB0aGUgYWdpbmcgY2FzZS4gVGhvdWdoDQp0aGUgZGlmZiB3YXMgZnJvbSBT
ZWFuLiBCdXQgbXkgdGFrZSB3YXMgdGhpcyBqdXN0IG1haW50YWlucyBjb3ZlcmFnZSB0aGF0DQph
bHJlYWR5IGV4aXN0ZWQuDQo=
