Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265E397E73;
	Tue, 30 Jun 2026 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837343; cv=fail; b=QWxX65JmtMZ5W+2yZLe0MfY6bn63W5SEDGj5h5dvWtwbdTIvFGxK92ba25cMQHdR0t3pP3N284QjZqMQfeWZOpCtOGrXnKqRwN46EDoq8cfbPszz59qL0uC2oZySHPbeyJ9xnYnwhzC+jt0nDp35NPXK4xskEQpOZ5nvSHk7FFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837343; c=relaxed/simple;
	bh=68APJ79C4WQ1BJusbXJQMmuBJ4EI8Jor6GMtZcaFQjk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftA1ou8bPhvZBbeEQzTeqb+uC7jnbVO27Pl+28f0lQsfiRykfVqx+Lh6AwNCPPBa7boh4DExK+fubnh7jNuQES+9hZm76WpWl1BBAk4z1ShQ1TVDU0SKmYzfY3kEJledkYs9yWSRzI4NMg6Xu9hdDtsTDLOJ6dSywKR/DfS0glU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EoI/PxKX; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoI/PxKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782837342; x=1814373342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=68APJ79C4WQ1BJusbXJQMmuBJ4EI8Jor6GMtZcaFQjk=;
  b=EoI/PxKXtyWpr+Osf1/aevcPWj/EKHbR2VUxFV4GNJamI01yVZWEXRDJ
   USh4kZctOmNRQoYbD0fnACTlLDLAMDLG3jCxXS4NHXfAkuX5jTqeAe0DK
   ef9S0TokIyo8ArZTm74k5/bUnxSZ54Gz/1kDPpg2f9frgGihOstjRNbhc
   sexznlcyuwLfFame0peEeESoLkkSDRQym7jb6fPZgTWXXhk98QtTSLKQ/
   nAsP/e8+CCxQ8WMz/fODdXC96AQGFboOS8TJQVNNwVM9+TV1nkSMRHdE9
   7GzgTFBaAsiL7zV/rdKgA6DW8mXaryDmIwFI9oPtpC+2KLkObZ2JWm7WO
   g==;
X-CSE-ConnectionGUID: 4LUSSUKDTqG/efCkUwthnw==
X-CSE-MsgGUID: LXXrvni4R4irvf73JTsAPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94939234"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="94939234"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 09:35:40 -0700
X-CSE-ConnectionGUID: DmJBx5L+SwCTE+J65spklw==
X-CSE-MsgGUID: sSbPeOlvSvGNX7KegdMjJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="290438949"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 09:35:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 09:35:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 09:35:38 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 09:35:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV0yf264fFdqSR6z8Z8p/jL1ac14QwJ/NDU05ujHuQwGRte+6Q7nZS5mrkLNjO6Ltxfu7NawERVk0fs/bPCAZBMhcswJvB8L3rnyRBjxI+7vDcmMuJf2Vb8DXXif5BT2PSk8VVQEngKC6bm5C3EPm6fpY4BLLSlYLWqNZ1MtO7xNnWf3NfBv3mOSUUOq9xKNJPP5uW/JAU7dRy2F1rYzHHGW7eggR3S4t4wk53yfLzT+KEOoT78bM3kue3IZH07luEwFxOMLxlAe/zA8GdQzXh2iosif5Tg8Ad/D2BwS2BexALw2ugcg3N7CVda52iT2rgQsHfDN6czPFPzPHNZMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68APJ79C4WQ1BJusbXJQMmuBJ4EI8Jor6GMtZcaFQjk=;
 b=qY/UqI/11DL9XmrCt6hcAHo63kp9/fAEcjoy0UCUuMyZYx5A6LqfS+wVTk1xSnBZKs7MkxlNtozcHj+3Y0y/yVXkcTRkGrLyLHyq6zP+XRirOs9fzDpZ5E46OsTnuT07uLtajjzQw2+TFHCFgYGZzy8jHz/UKHcngQTaxISl5YxgqaUcWLBqqryigJ71DxGYUnFNczem47FWvuCkL3+dsfjn64u056NzDKQIT133gSLxq0FCWBcJnilor8ipsV3qWxZ6l1ePRkV7YCVD8TqBrAj6lWljZbglD1WGNNoijoI0+3Q+XBZdmiT4VhbnZSmBSKVdQ6amiptsxtuMMN9kRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ5PPF0F15BC42D.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 16:35:35 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 16:35:35 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>, "sagis@google.com" <sagis@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "Annapurve, Vishal" <vannapurve@google.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH v5 30/45] x86/virt/tdx: Add API to demote a 2MB
 mapping to 512 4KB mappings
Thread-Topic: [RFC PATCH v5 30/45] x86/virt/tdx: Add API to demote a 2MB
 mapping to 512 4KB mappings
Thread-Index: AQHckLzz8Z2GKPhpy0S7O2pbUAy4grY525sAgB0ZbQCAAFwhgIAA6k8A
Date: Tue, 30 Jun 2026 16:35:34 +0000
Message-ID: <212aa1eee0c19fe9cabc1ab8cc2b217f1ee0b7ca.camel@intel.com>
References: <20260129011517.3545883-1-seanjc@google.com>
	 <20260129011517.3545883-31-seanjc@google.com>
	 <aip1eO7wvJDxKtBX@yzhao56-desk.sh.intel.com>
	 <9c22a8bc7f326f81effdff27fd72c3c5339e5053.camel@intel.com>
	 <akMryYJGxIk+FnbO@yzhao56-desk.sh.intel.com>
In-Reply-To: <akMryYJGxIk+FnbO@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ5PPF0F15BC42D:EE_
x-ms-office365-filtering-correlation-id: 5ae9ee1f-49bc-40c3-4b72-08ded6c59c27
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|38070700021|6133799003|4143699003|56012099006|11063799006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: hQM2wINWUaxWUYyzlH3JXS+Hnf0aKCdgerSLh9FoA6O8PzzLCoyLpJMp1NyMSMpeLNDokStaVCeVJrgJeS0GY8+SAc9VBY/TtUWmf2LrxdUfu8X7WU+oWS6xAADK8eyPrD7jMhBjQm3wKYDiYoUp76wdIBDW24iPo2h7Ca7MZuhFcmSY4OCTAXx9LCQNnEOGAWMAAjpj5FEeOyIbpsaBJE2Vj6Fr2HI5Kh9kkk+TxZNhiO8FQzzUZXCuvLx35tgSx6KsttOU2W4HFR1Fw5IHI9KbWZlXWyj90bLRfRg4HJAHv840ZFUEMaeUwr82mBHu6261qDx1sJTraNOalkMhWb1HD/ZaQpMc9jU19DK1ZFg6DmEIf1+Nm7kvcnDiDaILax2qa95KsJDGuLDYVWaZlyl3RBVj5WCDLh2zCk70GSnpKpLRJSdq5t/zK4VLm3XoCYhXlHKbQ75uGMsYnQ/JfxoacyRDfaIzmZfD6ZKT/Fg6ZGm/NYc9xvidTuNSwFmFoo6550je0HvJKWsx+ti21Hvepjuikkc4qsKXNnXaiqBhTKEzWvXiSlX6mi63eNi0A7ZnpHbQu7HYixnmj4y8ezIH+LrLyldF7hmtag4yh1GrWpDtAfln+VW4hFPPA6cLGvdrjTIQqAIHRBcDnaw8HX7T78HS/X/R/W5IOrfG0jsKccHa9oyQ7dZoQ/pad3Wmb94dNyQcOaXxqGt3j7DPBMjKm6S9q9rhKbyMcZpWhKo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(38070700021)(6133799003)(4143699003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlMreTg2YWNWQzZMKzlyQ3BsU1B5aGpDYWdaZitYUndUcXIvaER1VkpoNnJj?=
 =?utf-8?B?a21TeWdYZ0RGTFhEUXVObnRWUnY2MzB6c2xTWThkb2Yra3RlVldTL1VtYUpZ?=
 =?utf-8?B?WHhKNFRXSzJzd2YySU40RmEvRWxTN2JYZjZQTkwrQ0xidktCME16NWNBUXAv?=
 =?utf-8?B?RjNENGVCUjNsQmlOMDdwdHIyV1JDSzk3K1lJZG9YN1Bma25mZ2hWdWUwdGZI?=
 =?utf-8?B?bXNjVG84UWNkMXFHNFdLbi9aRHp0bmFXemhzRWd1U0crQWNMVmlDT0RuS0pL?=
 =?utf-8?B?RCtqWHQweW45R1lia29qOGIxVG1iVVJBNTRsYU9hb0NTeFBwcnVNNFF2Y0RP?=
 =?utf-8?B?bEtXeEdoWksxUUZIMS8xc1FSaU9Wc0tzeVpSdFIyK0JyWmFaMGpibG9lNlU0?=
 =?utf-8?B?ZGlING5oNEE1MzE0cDVvOTZXeG1BYnd2UTc3SXhUSTgvUjZaWm1aYm1wRng1?=
 =?utf-8?B?d2JSVkFIaTFXQ3ZKcGVibEQ1OWlseHRSakVWd3ByYThjMURHU1BGQTBiQ2po?=
 =?utf-8?B?RWdoQ3FYY1RSRDZJN0ZsOXFIZlBJN1MwNHJhWlRhc2JKWnJwRWVhak5ZY05X?=
 =?utf-8?B?eXpQc1RIWlQvdFNETTZQZzNIN0ZOdkMvbVRMdkh0aVVlNGdnUWR1eXBIZ2tC?=
 =?utf-8?B?QmFyMGowdzNvM3FQVk1teExlWjlhbm1VV0c0Nm1jMkhIRHBRQW1LdWk1Ym90?=
 =?utf-8?B?cHN6cEUyejQrVlJFd29SaFNTZnA2a2I0cklISTIzUE50Y3VLUkNsZElURGNR?=
 =?utf-8?B?bm1SV2t6UmRlcmJXN2pNWlVJcGVxeEc5VDJRallDTE42cmtXOFEvWFl4RFBO?=
 =?utf-8?B?YlAydW1wbTlaSWNheG0yN0Y1azlXbkxLV2x5Vjk2N3FUdkZqZEhSZjUwRnlX?=
 =?utf-8?B?WUcyMHFodGJmcDFKOXNLL1hYN2pVMWtGZ3NPSlBmSG0xdkJ3T2Mzenl1ZXQ5?=
 =?utf-8?B?L2ZZR2FPam0yZ1hVei9KT1ZhbTQ3VDVFRE9oaGZpbmhmaHJnTmEydldXMW9U?=
 =?utf-8?B?cHUydk14NmQxU2F5Qjl4OXBlT1Z4Mzl5aHNvS2Z3YU14anpqNXU4dVMrYzZa?=
 =?utf-8?B?WHlhT2NuSmd3OW9RUWNhUzczSjJZSkU1OHFPVTRMVE42YjlGUHRWSFI2N0xP?=
 =?utf-8?B?UzJwWXhvNDg4dDBxaWlCN1dPZXdlV25YWkRWSGNhK3BGbU9tQzJxNkwzS0NF?=
 =?utf-8?B?eksyaWxQTU5FSExhZ0JiSlZuc1RNSWJFUG1rb2wyaFBFVlRvMHlqRVd3ZmhB?=
 =?utf-8?B?eXJGR0taWGlFMEdVTGhVMzhZWmN5dExBYTltK3RvY3NPOU9yYUhzRXk1VjlM?=
 =?utf-8?B?Y0grSU11Z0ljd0k4OHdxajI1bERUKzl5dU1NY1JWT0t3K3k5SS8vV1Q2LzhK?=
 =?utf-8?B?NE81c3hEc1BFOWkxbjB3VWVOcXZlcTZ5ZWxxUER4am9VNlc2dlJyeHhMUVlU?=
 =?utf-8?B?UzF4am5BY2hHcVRjemN6bXRjUUluZ0Q5NzdVYUFhWWpvS0xoNlVjcTlsUGl0?=
 =?utf-8?B?d2Q5U2xUTituMkJQdzlUQ0NMbXBIOXBTbUNmNVFVT1Z4OFpzdDEzSG56Sm40?=
 =?utf-8?B?MC82b1FVKzNVZ09QTTlXN3BoTlBNbU9ITkNTZDI0OXY0NXprQTUxa0tDSDFD?=
 =?utf-8?B?NWNkRUw1dnordjdsSENFNU5RMGVOVk9CUnlGYmVNVWZKenVWRkhrWFdFL00x?=
 =?utf-8?B?MlFIWU5ZekNicVozcWlqYkNheW4zbTVxdDkxenZQVXEyOGg4Ni9jWUl4L2lG?=
 =?utf-8?B?OFYxNW5CWTdXK0pzY3VVVk5abSs5cUhCRHVCUmZUVlg5RXRySit0TE5yeGVT?=
 =?utf-8?B?Z3NMRnZuK29tZzF1NjJzbWZGK0t0Y3NOOVRwSVBRNzRjWkpSUmxVcWFPRmNq?=
 =?utf-8?B?T2FiNDZTTHNpaVpUeUFGWEVjaXUrVU9WYlFBVDNZaElOSDhFZDZqR2dlaXRx?=
 =?utf-8?B?aU5jTmRjU2NBcXhaK0dwMG9Vb0N1RVJjbDR5S3U3eXFyeEZiZTZvVFNWYXVs?=
 =?utf-8?B?RnVHbE5kQ2Z3dDZ5VVp5cExwWFpYVFp2ZklpM3MxU2FIREQ4UmFBdkpRSDNI?=
 =?utf-8?B?MTdoMVQ2NmY0aE5lM2JnWWx1YmxoV0V2N0srOFRuSnZQQUQ0Qzd6Z1dDbWZW?=
 =?utf-8?B?b0RYSStVUnF1dTlGYkhrZEVmTnVuTm1ZMHNYNWxYZFE1U2hvWjZ2WkNRU1po?=
 =?utf-8?B?QndYdHd3aCtPa3h6MzY5SEszSzRVejBlTlZDRERrUGlKVFpQQlVITkFBTjFT?=
 =?utf-8?B?Y3YwWjBZaVpGVEl1SzhRUUIrd1pXZnV6K0ttSEdkRUpZUHJyeDBBZjZ5SHBE?=
 =?utf-8?B?MVQ4MEdUcGZNQ0xtQjRDdXg1SEF4OGxnOEhqMVlxWHpzUWdXTWFNN2tzTUJR?=
 =?utf-8?Q?r0rOevj7cojwKil0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <946BB837EF00BC4DA2D5A54367B1D6F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TK8eofLJcAULenYgOzy+iAMvdy19mf0wQ6qv8qFCjUjPercehInXWdbccOSC3M2TIhk5AiTEi1SZMmTSFVOOxSUUzVM6tAYdZ5nFfL2VesNJyCATKtws6WAl7MGZD5wW/FUkwWuulyPljYepDJ4cAYlBgAsdRjLcqOL1KiwZrexMBOohRykn0dv3Cr70KhyO2YwH5tsi+pzxqZPwL4RV/Y5RGslUWqKC0bje4Tp4NJhK3FbLCzRLWko451fBQ+46fyTdaCjbzCt0i/4eLtLpfrJg4gSGaTmpn5RBkSGJeNDuJvyu0RiiPjvFE9YTpb8///4wVvXIfG/MmwgkJo4J2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae9ee1f-49bc-40c3-4b72-08ded6c59c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 16:35:34.9712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwAoneaU3prHWqLbtOdod/K6TNCnsF7ObI3Csgt9owFkVyBg4jh/7TprLtDXH0WgQ20wv5SpWFbJc84wEBGXxCPXAhwWUg0Ps1N46jrJq/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0F15BC42D
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA2LTMwIGF0IDEwOjM2ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiBJ
dCBmZWVscyBraW5kIG9mIGhhY2t5LiBUaGUgcmVmY291bnQgc3R1ZmYgaXMgYWxyZWFkeSBhIGJp
dCBoYXJkIHRvIGZvbGxvdy4NCj4gQWZ0ZXIgZGVtb3Rpb24sIHRoZXJlIHdvdWxkIGJlIDUxMiA0
S0IgbWFwcGluZ3MgZm9yIHRoaXMgMk1CIHJhbmdlLg0KPiBUaGVuLCBpbiBsYXRlciB0ZHhfc2Vw
dF9yZW1vdmVfbGVhZl9zcHRlKCksIHRkeF9wYW10X3B1dCgpIHdvdWxkIGJlIGludm9rZWQNCj4g
Zm9yIDUxMiB0aW1lcy4gVGhhdCdzIHdoeSB3ZSBuZWVkIHRvIHNldCB0aGUgcmVmY291bnQgdG8g
NTEyIGFmdGVyIGENCj4gc3VjY2Vzc2Z1bA0KPiBkZW1vdGlvbiBoZXJlLg0KDQpPb3BzLCBJIHRo
b3VnaHQgSSBkZWxldGVkIGl0IGJlZm9yZSBJIHNlbnQgdGhlIG1haWwuIEFmdGVyIHRoaW5raW5n
IG1vcmUsIGl0DQpzZWVtcyByZWFzb25hYmxlLiBCdXQgSSBkaWRuJ3QgY2hlY2sgaXQgdGhvcm91
Z2hseSB3aXRoIHRoZSBvdGhlciBmbG93cyB5ZXQuDQo=
