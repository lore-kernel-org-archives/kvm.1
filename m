Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46F934C806
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789606573; cv=fail; b=Llra8giaeTJOzvgt+T3xadCIlEqqU/b3YqbgqdqPRDylj5zgfBAumCqkrPbwQhii6C5BZYn2wwBayVd62OM8FfrF8bdpR2vX0g0M/5HULccpsFEHowHvGRpFjeNbYaIrqvNTB0ixchZWNJPV3WicoPGMnTgipvQxxDZ4OAHi4PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789606573; c=relaxed/simple;
	bh=DxTZGRHolVltBsIOiWYVsdq7qeB176g+H5uIRIuS3tc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RM09SoX3H5bUswE0YJASsen9tcQz01CoE0UgmoU8kI7Yr7KcVlCxUcFJG1q7WqPEp5pSmyAvNxHyST3FCSLwwDyVFdFUzvlLqj19YJkEnfS3JsXAbK/TQdEZyn+eyYJz3TR9pYedl5FophGmZ4JjZCwD2vtss+mLH+UDOS8QY8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWUAsivx; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWUAsivx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789606571; x=1821142571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DxTZGRHolVltBsIOiWYVsdq7qeB176g+H5uIRIuS3tc=;
  b=GWUAsivxYsmpYj7r3YC4f2wHH5QYNElsWT/Bs0WPxhHSJSoV6HefxkHF
   AMtmwP4OtStlivtIhCx6AL18JCMgCCAq/cJNxs7Q6uup4J0sD68kqoI6K
   cL2pnw9SOH706CNepauA5GoMQUdGX68t4+gm4xdt9BJTZh2/FA4FidLnC
   wldVb+j40a9J0pPNCnac6sEa5WNK+ttOzV0BFTB8yrty5U0vkZGUw1EUl
   gJYzQYjhJmwxjpby5luVFzx7yG0/TWHAGGrkDw+2iGk9m5KQy12aYErLj
   M2Xgwdk+/UFxZHM5xojlZ+NbtIR7RvOW+6iQD++BL5o7zDwE6s22PuvDQ
   g==;
X-CSE-ConnectionGUID: xh8vGyELQlytqYG0basnqg==
X-CSE-MsgGUID: gztvyuGATQe4TzI/uPmUJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89127912"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89127912"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 17:56:09 -0700
X-CSE-ConnectionGUID: lmPMfW+fT0OjDN5iVfFT0Q==
X-CSE-MsgGUID: 247tMwWRSeais+PbhlaWjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="311768740"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 17:56:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 17:56:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 17:56:09 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 17:56:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7cAUd+cpum8qUnpF8ZQ50zd2hR2UN9X1RzeJ/56XazcBC7e5fz0i7IN6/su4+n7XruyWw8k8TUO4W0aHzFJq+w7HW5e1iky8KkkQ6jM4jBzCYVu+i5Qs3TMoe9GbO4RgGh+OaW/GkhL6U+ISTKQ9MyIXvbp/2a5hB2nqOUCS8LorZRVgK4+JCJ0v+p92Blr+rQWzSgokfZYpdicLUbyFOLM0IyxUTNLscj9mXljwDHp9W7C/sLcaVey2G0uizS7fMnVm25yUSP0HSa+elPmB33TpBBwc1uJhRIzF6sBKK9jTwK8xvzIIg/Lr9yXcmsn/9a/7U/WTeX7VVuzdvGFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxTZGRHolVltBsIOiWYVsdq7qeB176g+H5uIRIuS3tc=;
 b=OyTmjQGwpJ3xXClBH+p2Md1wLP0Z4xqeBruTtz83ZJR2DmyIlXJpjbOIoEt/g4oon+IZV/F4Z+dmnj5JRs7Dgxb+Zpgpm+gzobkYohfUgynE1i9sA9hsd7W5WAibF6LxA5zXcehuzoMowCJNDQ/mrNGslclQrP633jbcyJCArfRalV1nLh9oK5vvcDHgwqS5CPSy3u223TaaHIK1/hDLTPfEKI3kd7JWmdofA3LhUZPzEgf3S5lyqiEgd0V9gzbqby6UB0qbOVPORUzpyXQjBVCEffNQRWtdbNzxVyoFaqnduDM5J6JyxBdcq1oh7jhvXFRbAZbRLAaWG9c6bT18fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CO1PR11MB4867.namprd11.prod.outlook.com (2603:10b6:303:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 00:56:02 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 00:56:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "Fang, Peter"
	<peter.fang@intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>, "Annapurve,
 Vishal" <vannapurve@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: TDG quote analysis
Thread-Topic: TDG quote analysis
Thread-Index: AQHdRXUGnV1D6jtpckytZt9IbBOCMLbRf7KAgAANsICAAAqMAIAAM3uAgAAIGQCAAA/ugIAAEEIA
Date: Thu, 17 Sep 2026 00:56:01 +0000
Message-ID: <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
References: <24a751d16ba0dc37aa7774df5739f39734cf9aca.camel@intel.com>
	 <aqrZUZtSZ-YItclT@google.com>
	 <736a9315f3cc3d8ef7079b784bfcc7b014386bd8.camel@intel.com>
	 <aqrtprn5YaMijVdZ@google.com>
	 <dae5a64112c9c949524226c66efac9c669df5b92.camel@intel.com>
	 <aqsfoHzOip3n4zdU@intel.com> <aqss_eQAY7soHRwJ@google.com>
In-Reply-To: <aqss_eQAY7soHRwJ@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CO1PR11MB4867:EE_
x-ms-office365-filtering-correlation-id: 7233e0cb-21da-46b2-78a1-08df145671b6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|11063799006|5023799004|3023799007|56012099006|6133799003|4143699003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: u4TU6F/X4ayk5KcHJvGUto3hFseNgJANjdDMpJiM4DMyZ7JjibN7iEJO8DwVfk58s3UwrqAuPyiIAj9m5boS9S6J7ufIhBEbuoknwOYUlkY1SDsA9MfZVBFx5ZMVbJw7KIEqRtijui4Wf6gXAGEasoJTJ2QL2kC1W0FBZbnR1ZiGK/dx8oTCfgaolRaYz0d03jMlOgTSBFI6tETYGtlvnp5JvZ4GRxewETBuqDjPoaXFYX3BdwKOjKz1nRYxmv7aAOS8UP1feItHkAh1lwBkJaTFXH0u9x7DACdGxNh7bGYy679pxyf+U3xZZ2OhCvTKolMssuA5ytIRVIeu1Kuh1DondZTObuKqRVgR5jXnSITERamSFO6M7HC1PPAZFMATtm16Uv/UXDdLTfN9k11gYTvavLQcfx0m9MdcGm0BR177LgWKZ4FeHIDAAUerPQvijUT6sXgKcVyOr1XskKzs16+Ec+/ciihGWI3kWY6z44iUIh2PnkLfjN7DkM3+XxgZFQlQkfvbg0XObDGDRL/zT5Tt5xPzqtzsfBN4BhfAMwFpC/LL8pIsE1ONyAJjt6c4XRGlG3OGdKG+VxtoobAkLUqOHpxI9+/MHdlocj2lr+dqAOAXu73QzLAfFdctm9/5U8EzwNYICKCQeQS4IjRojCOtntqlmyKw17sHcX7CwyqK5F2mX3F/MPHDE0c5du7LTX2ZRKZDIrDq67udcOU2TxukCdmAuGYAtEJCAtBSvRU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(11063799006)(5023799004)(3023799007)(56012099006)(6133799003)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFowckd6Njl3eHU1ZDVWRytidjN6OTAwNTlVa2Vzck8yQ1JUbGxFR3Z1SG9W?=
 =?utf-8?B?OXdSM2hBNE5ReFhJdlFYaGdJUTJWR3ZVZjUxQ3JjVXd5MXdCQlJHdFVXWVho?=
 =?utf-8?B?aUpoZFZvYWdjbU40T0dnRUw4RWtad0J6RjdHR3pKQlhLZ0h3TVZUV3EvUGRN?=
 =?utf-8?B?UUtRSW4zZm9zK3N3eUFFYjdNbGdxaDBsL1NRNklLaGVEYndLcFQvNWNEd21o?=
 =?utf-8?B?NWExc3pqVENkWmFpbDl2K1FVQld2cE51TEtDSmYwY2NObTlKemFndEtsN0J4?=
 =?utf-8?B?VG8xdEY3aVZuMWZ0Skc4cEt3N3dNVWJScW1oVDNVTE5qelhmdDR3UWR1d3Qr?=
 =?utf-8?B?MWMzczY4WEtvU2NjQTVXYWVPZ0Q5YlozMkVQWmN4a1BiTFR2RTNoZzdzb0t6?=
 =?utf-8?B?RzVOeFhnaEpCOXpCeXFGWDE0aGpGb0thMjZQcHdDWEFwMUcyY3lwZFh3dEJI?=
 =?utf-8?B?cS9CaXFlRUdMNnJOV3lxNGhpeGozOHk1VDlZUU9WeFYxZWVxZy9yNG5QamI3?=
 =?utf-8?B?NUxFYk8xaEpJalRGTGtuNExERldoc3hSRyt3blc0WE56N2orVXJZbEp0QW52?=
 =?utf-8?B?eTBFTGlMd1ZSaHFhSFRNdS94YjFNdE5KS2lnWkRBR0ZmdjVmVks5Nktwc1FO?=
 =?utf-8?B?d2Y2M203cUo5TEVuUTQydndoODh6YjVucXhRMk9nZ25lOVErMjlTQTUrS1o0?=
 =?utf-8?B?cW1vYWQ2eVUyQmFTbUdoSmZDanVCWFpud1g1cllZdHh0dVNDcnQ5THAyYkVv?=
 =?utf-8?B?QkgzR0Q5NmF2NFlPSlBMcjBNYUJFSmt3Mkc4eUxLRkc4eDR3dEJQazZqajJY?=
 =?utf-8?B?NzF1OG8zMzRuanVuM2NEN2F2c2JwRTU1UFlzRklwMHN6SmpvTXdRK25rRDNV?=
 =?utf-8?B?dk95N0kyWklYNHFaMDB4Qk5jb1pESlk2b3BuRVlrUEk3STNWdW4xcFFkV25v?=
 =?utf-8?B?UnRvejVQUTVtclM5dXRVQzFUcjhWc1JFVGtMdzRsWTM5MXdGWUYySFJrV0NB?=
 =?utf-8?B?OUx5VmU1WmRwU1kzeWxBTmt6NldnOTRDcUNxYnhWWjdoRFgzWDQrS20vODBl?=
 =?utf-8?B?Q1lsbmpZdG9zTHZaU3oyakxGZVdXOStsdTRYeXlCdHRnLzdQM2xVZ01Dekln?=
 =?utf-8?B?NENGM2NOMTlDakZhQVNyYXlkUkNwZFVTckRyWmkzR2tsaTQ5Z3VIWlpoL2lR?=
 =?utf-8?B?UFNlVlBqNndINmFmY1cxL29iUWRlQnozSG9rRGdEM1hDUGFPZjA1UmRiM3BZ?=
 =?utf-8?B?VFJQMnlVU1djMy9LUnFwQ01DTzBRRllhcU1xRXIrUmt3T1J4Q2VqZW5rejVQ?=
 =?utf-8?B?UEwwQXRmdFVESkEvb2pKdW1vRVlhcE11NzNYbjZObDZwOTJYWXkxb1ZvdFNi?=
 =?utf-8?B?aTdObXFKbmRSY3FiVTFveW5tZEJoL1c3ZmVJT2dvWnk1VzhvWVIvODdqQlVU?=
 =?utf-8?B?REFsdVRGL0xqSVorcGJ3Q2xFRFR1by9lOWUzLzNRR0JpWHU5THBuaUd5eWNz?=
 =?utf-8?B?YVhTNkoyS0JtZU96TjR4Mk9FQVNhcytmRHZTbEFnVlU4cE5rUjBqVnJwOExZ?=
 =?utf-8?B?eXZ1T2xWdUVLTG9vbzIzUEZuczVHSGZQcEJEckdpZSt4ZW5mWGM0L281M21k?=
 =?utf-8?B?SkQweU1NSUJDNDRXY2RVZStMY1pKSXNIdEFLaVFuaVc2elY0VlFrZTRSNE0v?=
 =?utf-8?B?eVBrY25ia203dHhYdExxUHEyVUpVRmd1VzJEeExSNVZxajZQSm1paW1GSHlF?=
 =?utf-8?B?TEhvTFFtTWw4ZzRUWFRtTWRoejg3V2Q5UWFJakx1SEhQM0dqZCtYZ2E2NHBU?=
 =?utf-8?B?bzQ1dWhiS0xUQmwwdzJWQkh6S1c4VXQzZ2Zwd2hPRi9ncDB0Uzd1dFo4bDhl?=
 =?utf-8?B?U3pDSHhSbHdGVkswRDY2bEp0TU9kanRVVjBROU9WM3crNFJ0YU9RQzYvbUxI?=
 =?utf-8?B?WW1qcTlNZkhnWTZ1c0xpNVVKZk1saDFKZllvWFJOR0NkdHduZUdLK0p1MmdP?=
 =?utf-8?B?cjFxdUlpYjdCdEFuWnRvTjF6aUZHRUt0SkFoNXhhWXkrb09CZjhSYXFuaCt0?=
 =?utf-8?B?QmxrQXZ3ODRlM0UwcXNuYXgzVVFkbWdRS3JmcENXQXRlTEJycDcwUjd4dEQy?=
 =?utf-8?B?TTBpQ3pIa1daN1Q1OHF4bDVwbHo2cERPS3hjYzBhMDlUN3FDSEdMM1loOGgz?=
 =?utf-8?B?aE13QXBIQVRobFp1K3RPdE1XeW52YnlKdW5xa1BRTmlvQ1F2NmprVnMvWUhE?=
 =?utf-8?B?OVJ3d3B4bEJHOG5nM1o2Vjl0Vms2cW0wR2NtY2pGTnpEQU12b3l5YUNVQTBC?=
 =?utf-8?B?Nkt5L1Q0dzBrWmNOTjJzNVN2RU9mNlRPaDlERWJHdG1JVHVGczdqT2RZS2lm?=
 =?utf-8?Q?AFd8S1QCymaTBNdI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B3CCBB3C829624B942010816BB35CD8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Am3JjGHUNvjODUd7QXN5P1Yd32V/XpptQJQSGFnpzFyEEOfZSJyyQl4/H5hkeuJ922gOaJFmGvd6OwkYr00/j4DTveJiPJtwyB61Ok/PMOVXcyw+3un791aSDTY9902lJI4gM30/UxKexaVij/sT9K2/qkIzIZKGxAfOlkdBxY4OnzGYJqVUNCQDdCEVe0nOF4OfDJVOagp8gVw6T0J5/po8g3bykJ1b5slajXYQ1KVKzqa7Bf0QyQbV2cGazeqgxH3yj04CYBgUUNUrGHCKOIMBbH+WWZNF2bzaBYtIWWai7aIzvFtH+Kk6EYUgFMKhT2wfUybqVe2DxrUxC6K94A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7233e0cb-21da-46b2-78a1-08df145671b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 00:56:01.6962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foVQKyXtQxxCow5OwsZO8Mr41ko5C/zpTAGhrIRZFck0391TYjFIIwDfoQBMsHvn2ZdoSu195yP5b4zph/3bTqOOzKHyqbI+uUQYF+6wL+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4867
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTE2IGF0IDE2OjU3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IFRoZSBjdXJyZW50IGVzdGltYXRlIGlzIDEwcyBvZiBtaWxsaXNlY29uZHMgZm9y
IEhXIGJhc2VkLCBhbmQNCj4gPiBtaWxsaXNlY29uZHMgb3IgbGVzcyBmb3IgQ1BVIGJhc2VkLg0K
PiANCj4gSSBhbSBiZXlvbmQgY29uZnVzZWQuDQoNClNvcnJ5IGlmIHRoaXMgaXMgYW5vdGhlciBn
YXAuIFRyeWluZyB0byBmaW5kIHRoZSByaWdodCBsZXZlbCB0byBjb3ZlciB0aGUNCmltcG9ydGFu
dCBwb2ludHMuIERpZCB3ZSBub3QgdGFsayBhYm91dCBTM00/IA0KDQo+IMKgwqBXaGF0IGlzICJI
VyBiYXNlZCIgdmVyc3VzICJDUFUgYmFzZWQiPw0KDQoiSFciIGlzIHRhbGtpbmcgYWJvdXQgdGhl
IFMzTSB0aGluZy4gVGhlIHF1b3RlIG9wZXJhdGlvbiBjb3VsZCBnbyBkaXJlY3RseSB0bw0KdGhl
IFMzTSB0byBnZXQgdGhlIHF1b3RlLiAoSFcgYmFzZWQpIE9yIGl0IGNvdWxkIGdldCBhbiBpbnRl
cm1lZGlhdGUga2V5IGFuZA0KZ2VuZXJhdGUgcXVvdGVzIHVzaW5nIENQVSBpbnN0cnVjdGlvbnMu
IChTVyBiYXNlZCkuIFRoaW5rIGxpa2UgYSBjcnlwdG8gbGlicmFyeQ0KaW4gdGhlIFREWCBtb2R1
bGUuDQoNCj4gDQo+IEF0IHRoaXMgcG9pbnQsIEkgZG9uJ3QgY2FyZSBhYm91dCB0aGUgZ29yeSBk
ZXRhaWxzLCBJIGp1c3Qgd2FudCB0byB1bmRlcnN0YW5kDQo+IHRoZSBiYXNpY3M6DQo+IA0KPiDC
oC0gRG9lcyBnZW5lcmF0aW5nIGEgcXVvdGUgcmVxdWlyZSB0aGUgQ1BVIHRvIGFjdGl2ZWx5IGV4
ZWN1dGUgaW5zdHJ1Y3Rpb25zPw0KPiDCoC0gSWYgbm90LCBob3cgZG9lcyBzb2Z0d2FyZSBrbm93
IHdoZW4gYSBxdW90ZSBpcyByZWFkeT8gDQoNCk9oIG1hbi4gVGhlcmUgYXJlIGFjdHVhbGx5IGEg
dG9uIG9mIGF0dGVzdGF0aW9uIHBsYW5zLiBJIGRvbid0IGtub3cgd2hpY2ggd2lsbA0KYmVjb21l
IHJlYWwuIFNvIHRoZXNlIHR3byBiZWhhdmlvcnMgd2UgYXJlIGVudW1lcmF0aW5nIGFyZSBhY3R1
YWxseSBhbiBlZGl0b3JpYWwNCmRlY2lzaW9uLg0KDQpUaGUgc29mdHdhcmUgYmFzZWQgZmxvdyB3
b3VsZCBiZSBleHBlY3RlZCB0byBmaXJzdC4gSXQgd291bGQgaW52b2x2ZSB0aGUgQ1BVDQpkb2lu
ZyBjcnlwdG8gc3R1ZmYgYXMgYWJvdmUuIA0KDQpUaGVuIGEgSFcgYmFzZWQgZmxvdyB3aGVyZSB0
aGUgY3J5cHRvIGhhcHBlbnMgb24gdGhlIGxpbWl0ZWQgSFcgcmVzb3VyY2UuIFRoaXMNCmlzIHdo
ZXJlIGZ1bGwgcGFyYWxsZWxpemF0aW9uIGlzIG5vdCBwb3NzaWJsZSwgYmVjYXVzZSB0aGUgQ1BV
IGlzIG5vdCBkb2luZyB0aGUNCmhlYXZ5IHdvcmsuIFlvdSBtaWdodCB3YW50IHRoaXMgb25lIGlu
c3RlYWQgZm9yIHNlY3VyaXR5IHJlYXNvbnMuIEJ1dCB0aGUgbWFpbg0KcG9pbnQgb2YgZGlzY3Vz
c2luZyBpdCBpcyB0aGF0IHlvdSBjb3VsZCBleHBlY3Qgc29tZSBxdW90ZXMgdG8gdGFrZSBhIGxv
bmcgdGltZQ0KYW5kIHN1cHBvcnQgYSBsaW1pdGVkIG51bWJlciBvZiBwYXJhbGxlbCBxdW90ZXMu
DQoNCkJ1dCBuZWl0aGVyIG9mIHRoZXNlIHNvbHV0aW9ucyBhcmUgYWN0dWFsbHkgbmFpbGVkIGRv
d24geWV0LiBIb3cgc2hvdWxkIGEgb2ZmLQ0KY3B1IGJhc2VkIGZsb3cgd29yaz8gV2UgY2FuIGRp
c2N1c3MgaXQuIEknZCB0aGluayB0byBoYXZlIHNvbWUgaW50ZXJmYWNlIHRoYXQNCmRvZXNuJ3Qg
cmVxdWlyZSBndWVzdCBjaGFuZ2VzIGFsbCB0aGUgdGltZS4gRm9jdXNpbmcgb24gc29tZXRoaW5n
IHRoYXQganVzdA0Kc3VwcG9ydHMgbG9uZyBxdW90ZXMgc2VlbXMgdGhlIG1vc3Qgcm9idXN0Lg0K
DQo+IA0KPiBJIHRyaWVkIHBlZWtpbmcgYXQgVERYIE1vZHVsZSBzb3VyY2UgY29kZSwgYnV0IEkg
Y2FuJ3QgZmluZCBhbnl0aGluZyByZWxldmFudA0KPiBldmVuIGluIHRoZSBsYXRlc3QgVERYIDIu
MCBkcm9wLg0KDQpJIGhhdmUgbm90IHNlZW4gaXQsIGRvbid0IHRoaW5rIFBldGVyIGVpdGhlci4g
VGhlIHBvc3RlZCBESUNFIHNlYW1jYWxsIHF1b3RlDQpjb2RlIHdhcyBhY3R1YWxseSB0ZXN0ZWQg
b24gYSBtb2NrZWQgVERYIG1vZHVsZS4gU28gRElDRSBpcyBlYXJseSBlbmFibGluZyBraW5kDQpv
ZiBzdGFnZXMuDQoNCkl0IGlzIG5vdCB0aGUgdXN1YWwgeWVhcnMgb2xkIFREWCBmZWF0dXJlLiBU
aGlzIGlzIG5ldyBzdHVmZi4gU3RpbGwgb3BlbiBhbmQNCnVuZmluaXNoZWQsIGV0Yy4gSW4gc29t
ZSB3YXlzIGl0J3MgYSBtb3JlIGNvbXBsZXggcHJvYmxlbSB0aGVuICJjcmFtIHRoaXMgVERYDQpp
bnRlcmZhY2UgaW50byBLVk0gYXMgYmVzdCB5b3UgY2FuIi4NCg==
