Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652B120C029;
	Thu, 24 Sep 2026 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209919; cv=fail; b=HlCl5tZ+pH2Er3MrhoQqUKDBTcWHovjnSlUr90QbSLb83wkFLGSN5Kb+9ksFW+mvEP7kBmcHaq1OcFIo9qegI7OESkkMBOFXUNS/6hTvE/iqXow1gdQUzLXp54AfyXHSoUJLYDLcOla16B3cMoVhB6Iqbn5Tf90G9G64K3OEaMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209919; c=relaxed/simple;
	bh=/ErERva0+C7dSzfYHvo/d19fmf8xNQJuggNnsoOASJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pisZ3jlO5qZuvvlRnV8ryowPD3t+7BOpajwEjH++bBd32VkXs0DHt4XWs9GxQuqD0S01QNxYpvl6x0qDNGNgVmLfUjsZlirvj+6dtX5FwFTqGXxselVJGfxyBziEE96g6O9eIXLRtxZFPvtIDn/uq7LnfQ8q73Q1trgct66jU0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9c/jts1; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9c/jts1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790209918; x=1821745918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/ErERva0+C7dSzfYHvo/d19fmf8xNQJuggNnsoOASJM=;
  b=V9c/jts1RbTFAHlGsIPb3B/557cDUMUWF0/mepgyV1vrEK7XmvZUaCLZ
   b1nds4FEYvRuZyMnyqkq3A2YYOGZR+RxNclSvm0gz7QqsHG1QugJArCm3
   GIPhJkreihjnDoSzm0UJ3j4uxoyIJU0vyyw2YYW3f/sVuiR7sVderrf+d
   thid0db7EVY0EIUgIpFO5h0GDnHBLyN4stonBnmPPsfbHWdmSkW2gmFZ+
   ciJGdaqiaxz02P4RysPQ9n/NFyp+NOn+DkrJxQr5kgJPBpxuCl+yhmWY6
   a8pou2xfD8ivL3Dt4vYSGReOY7SRF88Uan0hu2psyNsNklDFxaGRbYgIb
   A==;
X-CSE-ConnectionGUID: fKQ31IVPTKKyATN/vP6S9w==
X-CSE-MsgGUID: VqenLvzrTaekoc8CFNcKDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="91069872"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="91069872"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 17:31:57 -0700
X-CSE-ConnectionGUID: tfsajkUSRbiiVE3jDAhvTg==
X-CSE-MsgGUID: qyeaPpsPRj+g5sCP7MnDpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="273032264"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 17:31:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 17:31:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 17:31:53 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 17:31:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J81AhXV5WemugTF7akNi97J5antoq4Cx+Lt4tko1adYQPAnnBrrvtkDdpoZWfBRKi5kzMRgCWSixpcmgDLLuOtCUMPNxXLDh0OKPdS3xAOLJzbcxJoNSlqdh6q8FxY4Mi+gtCQmYK3KRG5JW5GnSWupc1WgnJ4uAjAYaiEfhupzue+HziK66qUFrcMjSDLvHIo/Zb8wxy6X3oyeFe+quVCh0nbQ4ZLOi7e1ETxwQiqOG4ixMo/qu8pO0qMELoHgPJ7KLr1oJ7nbIGMAK1s0OzqIRAr5oetVXtqENy3XJ3HAiBVon45juRQXkdg7qt5Ew617cESxHDMf1ZeLu4EQ3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ErERva0+C7dSzfYHvo/d19fmf8xNQJuggNnsoOASJM=;
 b=BuOXE5S97qBCFY5TRq+TvRbVi8C9JEzMwZINBh/4ptESCjG4TtQqKg12zKwX0iFyUEc36nHZ05a6p81Dkpf0Fm0p6q+rYKiem+7aaqOg2ovQVibQPmNW6KoGyOgjOe1MRoSOUaBd1f1KEiS+KzkrWwtINpVYMa89fMq60jxyjxmZ6sXlZdyPy1bJeHzFrhahcj2iQ7jMmEz7BtI5KSrp90LmwniPW76HLjsdub+rL1noXytuKhSjxDkQ0OHbJ6eyXnkME4ovQjZIFy1WhRnclAQiipbaaHxRewxGkiaFZSDfkUHZJRtzJw/ujaC0mFg5Cm9zo/kb+vZCSKp/Eumdrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MN7PR11MB913619.namprd11.prod.outlook.com (2603:10b6:208:639::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 00:31:45 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 00:31:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "jthoughton@google.com" <jthoughton@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "Annapurve, Vishal"
	<vannapurve@google.com>
Subject: Re: [PATCH] KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO
 on unhandled EPT violation
Thread-Topic: [PATCH] KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO
 on unhandled EPT violation
Thread-Index: AQHdS3lOpZpjMUNuZ0SBG1w9Qe9I/7bcz94AgAAF+QCAAAtbgA==
Date: Thu, 24 Sep 2026 00:31:45 +0000
Message-ID: <43c29df1dd1e332305bbd31db0ece7c8cb791299.camel@intel.com>
References: <20260923163315.1580860-1-seanjc@google.com>
	 <8c9922a47e3044683322a5a8755fccca1a1a129a.camel@intel.com>
	 <arRl6HECqNVOL_cH@google.com>
In-Reply-To: <arRl6HECqNVOL_cH@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MN7PR11MB913619:EE_
x-ms-office365-filtering-correlation-id: f31833ed-de53-470a-c628-08df19d336a3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|18002099003|22082099003|38070700021|56012099006|11063799006|10067099003|4143699003;
x-microsoft-antispam-message-info: +PLdGNH78TqktV4bdZavA5ONytCHWceXFKeP7N9yY7L1c0dqjl09v9iqOMWU/IhhjAUQ0dt5LBKybSrKAQkK/ouWyyJLEHdoArbybGuVXl4xHIAzoHxfTzGud2vGsnn9loqZ9ooKjjV6DwiJcO9tUeWuXpLEOLTQtqxjC8bUtCKoyXHWDaERe2NCIVDthmt+L/m88eJT3VqpLxYWbhVh/w6XzxHCJ23FWVfdGo/qsShdyXcHbB0VgrqUVQj23dTs4Q3NLdPz9WL/BOM2IXNeWLjMxXG9BLIE2rp3TupWma5J6UhyvnWp2Tt2GKXa69jEa5ByuNdfT9OvBFbLwBEqy8819kzWXIzJjEgxoCCwCAVwgTrAq5TrZveNl5kPhT5FjlWjRFM8wcsxn44e9kryRxcUdZkXqQ1uxVSQ1R60eSKi5IZqEj25BY8i5+vw5rsoLG6ii/9nA0fLFOH4Ddgy2uSRYHqm1M3VelFpqb4XUA14wu1adF8RMs3MyIB3Xjf2Pa+PGBYs2BEj4tgtWSIByWtRJavwNSHEKMEqmeWybaAdgZ+ttAnXomwJzP457OGRvqTFP01uha87IBpMWoTEIa55liF9B/HQLHJC10lNgV/mCaTEtWpDKqndzlPxwKTR4TNnYwC90/lgmUle6RfIWC2pbBU4ZDGI8hbnpLuF50DzDYw/uof7PosbjbaQZLoJOuBpYl1ZbRky/jmjFGufvEty3qw071ughXS7Be1Yx0A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1NJMUpyd1hRTnh0dGNFVWkvc2UwTVk5RHQ0ZzVZRFdKbUYxY2Q3ZUFHN3Ez?=
 =?utf-8?B?U25ydlNMaWp6RE5OQXpBTjRkV1NWMTRKeDhzdWo5M0h0bWh1WFVSRVkycFdG?=
 =?utf-8?B?T0dyQTVoK0kyVkFGUE03eGszQk9qcFUrZE9sY3hIeC9ZTmpGQTNxcU9Hdm9B?=
 =?utf-8?B?NlhLMTc0aG5GY20vQWliNU9yMURkNWxYMVZ2eC85OVFrcUx3QnlIVy91cHZH?=
 =?utf-8?B?NWxCbFpCdm1VTFNjdzVIcWZPNXhhV1IxVGxoS1RVcjl2aHUxZkJyN21oekdQ?=
 =?utf-8?B?MXFHaktDa2JVRE9pK2M4aHJDMW81cXdhVkJFVTYrQldOd3dOcUM0YkplYkVU?=
 =?utf-8?B?M200SzBxUDdTSll0M0NKQmZCbVRycUdCZ05XaDdDS3lyUzBzR0c2aEE5V2tE?=
 =?utf-8?B?cGVxeEs2Z3VsRFhZeDhnUm1zMGdocXhtMk0zMFZscGxGclhXR2Ezcm9uTzY4?=
 =?utf-8?B?MXlSN0s3enl3d3I4c2JHclRMTTBEYndadVZtR1AyNkxIZWdkUjlzRnkwd3Rq?=
 =?utf-8?B?cXhNcVA3YUZiZUM5bzJBRUorK3dWRVVCN3lPeitWUGNuNldTdHY5VUV5dUVJ?=
 =?utf-8?B?TUQ2cVMyTUxCL3VqK05ZbDJmdmJuWTlzRStMMUNJaG5KSWNmSFRuakVJZ2lP?=
 =?utf-8?B?Mkd1Z3dMb2ZkMnI1KzBxVS9id1dxSjNwTFJCaTU4M0lrLzBJNUF2RGR6TGpq?=
 =?utf-8?B?bkV2aFpXVDVha3d2cktlSWdVclVSS1ZtYUorRXdKNHBzb3RxbjVLYU95cDJl?=
 =?utf-8?B?VWZmdGtnbHNnUFgzSHJzK1J5MDdZK2hkUEpMcEpJSVd0TE41N0lDY2tHYjZj?=
 =?utf-8?B?NXlQWVE2eEF2UmZCTEhEeTZkQ1pTYmhPa3BFdkFhZGpIT0VzK2VYdm5laUEz?=
 =?utf-8?B?QTREK2YyTCtvejUxYmFrYnZDYUNSUk80WTA3ZGp0ZXVKWlpURUJKNkQxUUx1?=
 =?utf-8?B?K1prSFNCR2s0alZPRjJzeXIvRkhsUHhyS0ltWnhhKy9JY21wRU1RS2hwdmMz?=
 =?utf-8?B?TWI2T3V4cWZWQW05dHc1TDZoN2lEMEdBWVhUMmt2bitiV0lBWnYyN0RiNHpz?=
 =?utf-8?B?a1Nvb21mRXpTQTZ6L0ZVV1JaWUdPZE5pYjd0NlFYRkVWMFEwSjlKYXJJMkpF?=
 =?utf-8?B?UU1SM21GMS8wNGhkOTVOaGhoa2xqc01STEZvU1VUU1NQSzIzdjdCNEh6dHhG?=
 =?utf-8?B?VEpkcXYzOUMyTkJtODJNVFRxSUtsWnNvMXRPWXk0RU9QVVlnNXRVUERSZ0VZ?=
 =?utf-8?B?aVlvNUZPYjZlQ3BISk9jU3h4Rm1IanZqMEU1Rm0wUHh6bUpoZjF3Mm1uZ2U2?=
 =?utf-8?B?N200dXRaTGFXS2x5VnhsdG5zSGlZc3JJcjJJWHN3MlMwc0pXOElMdjIwQTRT?=
 =?utf-8?B?YUc1cncxazQvWk02M3N1MGFwVVc2cmZxRmluR3FlZlk0TitCRkJQbnk3ZEM0?=
 =?utf-8?B?cnpCdG5peVFUdmJ0djd0V1l4VUk5WUQ4c2k1ZzkvR3h3dDU5a015SlVLYTlm?=
 =?utf-8?B?dFdyL0xDUXlVbnptYWovY1BON1ZLNEhVanhIS3djeTRJbEZSOTUybjRFNkdk?=
 =?utf-8?B?UW9zc3hkOXFmR0lCSU1CdWR5eHpnU3AxVkxUMGxpeDFLTVgrTUpkOVlmcTRO?=
 =?utf-8?B?Z0RkaVJOb0N2L1M3cGlydEhEU3NiU250a0F2YUtkb2J3Q3M5TUI5NUV2cmpD?=
 =?utf-8?B?akt2Mjg3SzROSVBleC95cWY2YjcxaUt0cE02SjBBMzd3RlFWWXV1dkdZeloy?=
 =?utf-8?B?ZWFjSWpXcUJCQy8xZXJBVGZpSy93QTh4OFpQaUVzL3ZxMVpJUU84WERxVVls?=
 =?utf-8?B?YkFrR1hFc2RibDZLaHFKOFJOdkY0Mk8xVG94aG9UQ0RkM1Q5bHlCYTN2VUl4?=
 =?utf-8?B?eEtHRzMxWE5IdmVxQWJlN3ZyTUpjRDJZTUh2Y2hvREtoamo1ZHZDMXArWkxZ?=
 =?utf-8?B?aGFrTit3MEdrZ3RhTTVPTWJvbHBTVitvaWRYNEU5ZzRYeHRTNHgvR0Vkd3Vs?=
 =?utf-8?B?OVZ6UW9QdzVCTHdzcU9rU3Z5Y2k3UEFRcFlXQkNqcHNvMUpqbUE5WGZYaXkr?=
 =?utf-8?B?UWF0UXFtRlRMNVN3cDFpVWR5TEpONjBBMU1vRmhyTFArYkg0bjVqKzR1NE9x?=
 =?utf-8?B?NEkxandJVVljTzQwTUh1S3R6d3lFM1ltMmFXbWltRmVrdEVZWEdpNzQ1Vll4?=
 =?utf-8?B?QUI1SEp0WjlDWU9GMXQwMFIwRzAvSFBsTlphbVNXZmROUlhJWXkwaTFyZFkz?=
 =?utf-8?B?aVRNWVNjOU9UTG9YUlBPQk9Gc082VjEyaGdadkt6RjRBcnkxVzM4NkFpOUlK?=
 =?utf-8?B?V3pobmpYbFdhN1VLam8xUmMycU05MWFjY3dwaDRsQXFzdVFSTlkra3NLWDdx?=
 =?utf-8?Q?os+4KiyhHQFKvSJg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83C29A9C74A603469BE59C05AAF31ECC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oEep2k7exx9q97cRbcjatbBggaFh4fWEus6bivWit6v+pS/RKO0cybWbZ6sbN+Xxq6qJ2a3MfAOIrV2GucAUQ32kyBs0+B/5FDe9bo07JSq2owae+F+BeMv9o9kDHFxFE6XbKSqOrhC1/p8OTMSItF0sqp8rQndur0p6ekshct+lqlELNLus5tOubYQTSCSidd3Fn4l7OD4g1YAtvwZ6DKnCfVb03wTsc7v5RhJICQv7m3T7GiIidKwzfqdOjKo1YnVI1GzKRMrAvd7nkF1A+bSb+fEuh9BUVB4KNlvCoHVFfu33gfAA0g15QtgEFltXvY5XWxEMwtA6pN6mGbxGmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31833ed-de53-470a-c628-08df19d336a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 00:31:45.4984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /c0QZWqENVnfdDFuxcPBYql4HtklMk+CwfYYTUVJhsNf2SjlPzAlVuHTlt0LXQrZrb7EhP3XZZ0Jott5Af3xO/Q5gQ6v8qL/qTtXoO/yZrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR11MB913619
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDE2OjUxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBXZWQsIFNlcCAyMywgMjAyNiwgUmljayBQIEVkZ2Vjb21iZSB3cm90ZToNCj4g
PiBPbiBXZWQsIDIwMjYtMDktMjMgYXQgMDk6MzMgLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24g
d3JvdGU6DQo+ID4gPiBTeW50aGVzaXplIGEgdHJpcGxlIGZhdWx0LCBpLmUuIGV4aXQgdG8gdXNl
cnNwYWNlIHdpdGggS1ZNX0VYSVRfU0hVVERPV04sDQo+ID4gPiBpbnN0ZWFkIG9mIHJldHVybmlu
ZyAtRUlPIGZyb20gS1ZNX1JVTiBpZiBLVk0gZW5jb3VudGVycyBhbiBFUFQgVmlvbGF0aW9uDQo+
ID4gPiBkdWUgdG8gYSBndWVzdCBhY2Nlc3MgdG8gYSBwZW5kaW5nIHBhZ2UuwqAgUmV0dXJuaW5n
IC1FSU8gaW1wbGllcyBLVk0gaXMNCj4gPiA+IGJ1Z2d5LCBhbmQgbW9zdCBWTU1zIHdpbGwgcmVz
cG9uZCBieSBjb21wbGV0ZWx5IHRlcm1pbmF0aW5nIHRoZSBWTSwgdmVyc3VzDQo+ID4gPiByZWJv
b3RpbmcgdGhlIFZNIGluIHJlc3BvbnNlIHRvIEtWTV9FWElUX1NIVVRET1dOLsKgIEkuZS4gZ2l2
ZSB0aGUgVk1NIHRoZQ0KPiA+ID4gb3B0aW9uIG9mIHRyeWluZyB0byBrZWVwIHRoZSBWTSAoZnJv
bSB0aGUgZW5kIHVzZXIncyBwZXJzcGVjdGl2ZSkgYWxpdmUuDQo+ID4gDQo+ID4gV2h5IG5vdCBq
dXN0IHJldHVybiBLVk1fRVhJVF9TSFVURE9XTiBkaXJlY3RseSB3aGVuIHRoZSBwZW5kaW5nIGVw
dCB2aW9sYXRpb24gaXMNCj4gPiBkZXRlY3RlZD8gVGhlIHN5bnRoZXRpYyB0cmlwbGUgZmF1bHQg
bWFrZXMgaXQgaGFyZGVyIHRvIHRyYWNlIHdoYXQgaXMgaGFwcGVuaW5nLg0KPiA+IEkgZ3Vlc3Mg
dGhlcmUgaXMgc29tZSBjZW50cmFsaXphdGlvbiwgYnV0IGhhcmRlciB0byB0cmFjZS4NCj4gDQo+
IEJlY2F1c2UgaXQgZGlkbid0IGV2ZW4gY3Jvc3MgbXkgbWluZCB0aGF0IHRoYXQncyBvbiBvcHRp
b24uICA6LSkgIFRoaXMgd291bGQgYmUNCj4gYSBncmVhdCBvcHBvcnR1bml0eSB0byBkbyBzb21l
IGNlbnRyYWxpemF0aW9uLCBlLmcuIGRvIHRoZSBiZWxvdywgYW5kIHRoZW4gdXNlDQo+IGt2bV9w
cmVwYXJlX3NodXRkb3duX2V4aXQoKSBmb3IgdGhpcyBjYXNlIGFzIHdlbGwuDQoNCkFoISBPay4g
V2VsbCwgeWVhIHRoZW4uIEknZCB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gZG8gaXQgdGhh
dCB3YXkuIENsZWFuIHVwDQpzZWVtcyByZWFzb25hYmxlIHRvIG1lIGV4Y2VwdC4uLg0KDQo+IA0K
PiBkaWZmIC0tZ2l0IGFyY2gveDg2L2t2bS9zdm0vc3ZtLmMgYXJjaC94ODYva3ZtL3N2bS9zdm0u
Yw0KPiBpbmRleCBmNWFhM2Q3ZDNhMTAuLjM0ZTViYzI4MzQ3OSAxMDA2NDQNCj4gLS0tIGFyY2gv
eDg2L2t2bS9zdm0vc3ZtLmMNCj4gKysrIGFyY2gveDg2L2t2bS9zdm0vc3ZtLmMNCj4gQEAgLTIx
NjQsNyArMjE2NCw2IEBAIHN0YXRpYyBpbnQgbWNfaW50ZXJjZXB0aW9uKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSkNCj4gIA0KPiAgc3RhdGljIGludCBzaHV0ZG93bl9pbnRlcmNlcHRpb24oc3RydWN0
IGt2bV92Y3B1ICp2Y3B1KQ0KPiAgew0KPiAtICAgICAgIHN0cnVjdCBrdm1fcnVuICprdm1fcnVu
ID0gdmNwdS0+cnVuOw0KPiAgICAgICAgIHN0cnVjdCB2Y3B1X3N2bSAqc3ZtID0gdG9fc3ZtKHZj
cHUpOw0KPiAgDQo+ICANCj4gQEAgLTIxODgsNyArMjE4Nyw3IEBAIHN0YXRpYyBpbnQgc2h1dGRv
d25faW50ZXJjZXB0aW9uKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gICAgICAgICAgICAgICAg
IGt2bV92Y3B1X3Jlc2V0KHZjcHUsIHRydWUpOw0KPiAgICAgICAgIH0NCj4gIA0KPiAtICAgICAg
IGt2bV9ydW4tPmV4aXRfcmVhc29uID0gS1ZNX0VYSVRfU0hVVERPV047DQo+ICsgICAgICAga3Zt
X3ByZXBhcmVfc2h1dGRvd25fZXhpdCh2Y3B1KTsNCg0KVGhpcyBwYXRoIGdyb3dzIGEgdmNwdS0+
bW1pb19uZWVkZWQgPSBmYWxzZS4gSXQgcHJvYmFibHkgaXMgb2ssIGJ1dCBhIGZ1bmN0aW9uYWwN
CmNoYW5nZS4NCg0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IGRpZmYgLS1naXQg
YXJjaC94ODYva3ZtL3ZteC90ZHguYyBhcmNoL3g4Ni9rdm0vdm14L3RkeC5jDQo+IGluZGV4IDcx
NzNlZjNmYzM5OC4uMGZhYTdjZmQwNDMzIDEwMDY0NA0KPiAtLS0gYXJjaC94ODYva3ZtL3ZteC90
ZHguYw0KPiArKysgYXJjaC94ODYva3ZtL3ZteC90ZHguYw0KPiBAQCAtMjA5MSw4ICsyMDkxLDcg
QEAgaW50IHRkeF9oYW5kbGVfZXhpdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGZhc3RwYXRoX3Qg
ZmFzdHBhdGgpDQo+ICANCj4gICAgICAgICBzd2l0Y2ggKGV4aXRfcmVhc29uLmJhc2ljKSB7DQo+
ICAgICAgICAgY2FzZSBFWElUX1JFQVNPTl9UUklQTEVfRkFVTFQ6DQo+IC0gICAgICAgICAgICAg
ICB2Y3B1LT5ydW4tPmV4aXRfcmVhc29uID0gS1ZNX0VYSVRfU0hVVERPV047DQo+IC0gICAgICAg
ICAgICAgICB2Y3B1LT5tbWlvX25lZWRlZCA9IDA7DQo+ICsgICAgICAgICAgICAgICBrdm1fcHJl
cGFyZV9zaHV0ZG93bl9leGl0KHZjcHUpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
ICAgICAgICAgY2FzZSBFWElUX1JFQVNPTl9FWENFUFRJT05fTk1JOg0KPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIHRkeF9oYW5kbGVfZXhjZXB0aW9uX25taSh2Y3B1KTsNCj4gZGlmZiAtLWdpdCBh
cmNoL3g4Ni9rdm0vdm14L3ZteC5jIGFyY2gveDg2L2t2bS92bXgvdm14LmMNCj4gaW5kZXggZThh
ZjVlNTdlMWNjLi41NDExZWI3ZjNmMjYgMTAwNjQ0DQo+IC0tLSBhcmNoL3g4Ni9rdm0vdm14L3Zt
eC5jDQo+ICsrKyBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jDQo+IEBAIC01NTg3LDggKzU1ODcsNyBA
QCBzdGF0aWMgX19hbHdheXNfaW5saW5lIGludCBoYW5kbGVfZXh0ZXJuYWxfaW50ZXJydXB0KHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gIA0KPiAgc3RhdGljIGludCBoYW5kbGVfdHJpcGxlX2Zh
dWx0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gIHsNCj4gLSAgICAgICB2Y3B1LT5ydW4tPmV4
aXRfcmVhc29uID0gS1ZNX0VYSVRfU0hVVERPV047DQo+IC0gICAgICAgdmNwdS0+bW1pb19uZWVk
ZWQgPSAwOw0KPiArICAgICAgIGt2bV9wcmVwYXJlX3NodXRkb3duX2V4aXQodmNwdSk7DQo+ICAg
ICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gZGlmZiAtLWdpdCBhcmNoL3g4Ni9rdm0veDg2
LmMgYXJjaC94ODYva3ZtL3g4Ni5jDQo+IGluZGV4IDE3MDVlN2JlNDZlYy4uZTQzM2FhN2VlNjAz
IDEwMDY0NA0KPiAtLS0gYXJjaC94ODYva3ZtL3g4Ni5jDQo+ICsrKyBhcmNoL3g4Ni9rdm0veDg2
LmMNCj4gQEAgLTgwODIsOCArODA4Miw3IEBAIHN0YXRpYyBpbnQgdmNwdV9lbnRlcl9ndWVzdChz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
a3ZtX25lc3RlZF9jYWxsKHRyaXBsZV9mYXVsdCkodmNwdSk7DQo+ICANCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKGt2bV9jaGVja19yZXF1ZXN0KEtWTV9SRVFfVFJJUExFX0ZBVUxULCB2
Y3B1KSkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZjcHUtPnJ1bi0+ZXhp
dF9yZWFzb24gPSBLVk1fRVhJVF9TSFVURE9XTjsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2Y3B1LT5tbWlvX25lZWRlZCA9IDA7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAga3ZtX3ByZXBhcmVfc2h1dGRvd25fZXhpdCh2Y3B1KTsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByID0gMDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBnb3RvIG91dDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiBkaWZmIC0tZ2l0
IGluY2x1ZGUvbGludXgva3ZtX2hvc3QuaCBpbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgNCj4gaW5k
ZXggMjg0ZmM3ZDY4YzYwLi5kMTMzYWQzMzc3NmIgMTAwNjQ0DQo+IC0tLSBpbmNsdWRlL2xpbnV4
L2t2bV9ob3N0LmgNCj4gKysrIGluY2x1ZGUvbGludXgva3ZtX2hvc3QuaA0KPiBAQCAtMjUyMyw2
ICsyNTIzLDEyIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBrdm1fYWNjb3VudF9wZ3RhYmxlX3BhZ2Vz
KHZvaWQgKnZpcnQsIGludCBucikNCj4gIC8qIE1heCBudW1iZXIgb2YgZW50cmllcyBhbGxvd2Vk
IGZvciBlYWNoIGt2bSBkaXJ0eSByaW5nICovDQo+ICAjZGVmaW5lICBLVk1fRElSVFlfUklOR19N
QVhfRU5UUklFUyAgNjU1MzYNCj4gIA0KPiArc3RhdGljIGlubGluZSB2b2lkIGt2bV9wcmVwYXJl
X3NodXRkb3duX2V4aXQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiArew0KPiArICAgICAgIHZj
cHUtPnJ1bi0+ZXhpdF9yZWFzb24gPSBLVk1fRVhJVF9TSFVURE9XTjsNCj4gKyAgICAgICB2Y3B1
LT5tbWlvX25lZWRlZCA9IGZhbHNlOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQg
a3ZtX3ByZXBhcmVfbWVtb3J5X2ZhdWx0X2V4aXQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3BhX3QgZ3Bh
LCBncGFfdCBzaXplLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYm9vbCBpc193cml0ZSwgYm9vbCBpc19leGVjLA0KPiANCg0K
