Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D24E73B9;
	Mon, 28 Sep 2026 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622280; cv=fail; b=pt8pqQA97tlnEgv4yVd7KHyVekDGt7hIGKC/XG4Db17bMB8MWTXpAv55d9FPMC7AVYs91WsgJlEpF82ff6/uujKhzRYkadnOJwQk3EgE4p2vT29bexKa9TwMv2Xq7JEa71MhNvNmlKYq1kkD/pzLZ+jd+DGUpQwYq0VZv9QboDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622280; c=relaxed/simple;
	bh=Ebt65TiJhPbH1SzDfAtVhroo2jt484YZjO/8nMub5ZY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i0lrnawyj7d27NtfAS08SM6b0zli6e+aXv+8QL8/vGf3izGDM9o5b8z97UB62Mfbxg2MOuRUbk8yq0jDueyWOS36hIMCu78LkKF9rn/JtX8rFX66dCjdUIlzpvP0fXXhru+6inQnwORSJZUMjH/GUvu/UCxZr/FEQX9Y8WRKLkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ond3DrEE; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ond3DrEE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790622276; x=1822158276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ebt65TiJhPbH1SzDfAtVhroo2jt484YZjO/8nMub5ZY=;
  b=Ond3DrEEqm1gCGp7sulDcJsR81TZQlCiaQqzKmOjVcRC7lFiNcqjLDrB
   DhYW/HGM511xl/0RrH81TBRwATHP1Jy45J8m+x5pcrMt4+wp8g0Xhnhey
   2MJnpSNroNP1D4wNdSi4Mnu/zxakmaHpDOby/T2bOIs+V8WpEn2f2uwhS
   wyk2of0+pZKFgCCjxNhlcKr3e07JwsGSOhQHdzhxo0EOY0Dd2qlTOnlWX
   edC9NwjbwEduh/707Ny4V8fV49pvxzT1dODt8Gn1JA88JtqBtLdsttvyX
   x9DCPO4VMozOo9L6aqzV7/qnZCSxUQtlUWOdE/SnhfyxXHxEvx7KBPWDW
   Q==;
X-CSE-ConnectionGUID: 3NnaibjxSOuksrR6y7qfTA==
X-CSE-MsgGUID: BISPlnm8TyeJ1jzQXK15Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90548724"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90548724"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 12:04:34 -0700
X-CSE-ConnectionGUID: aPP4c7cdSDqw9DDaPZjV8Q==
X-CSE-MsgGUID: K3sJtp4HT0i5PtyPnwb8OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="278512540"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 12:04:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 12:04:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 12:04:33 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 12:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5aLgeIRP6BD/62oMCmt1XhdQ6L/mY0MQKH628h+cPTRwOlyxRl/4/Ycv0cwRhuuTgw4GCR6eXNPw8zJ/sVExLWT0ZW9bLjQCBp49+HMJ5KdmTsBKngc/bZfYw2G1aIwyIPC/N+shPS2nfC9ZVO7cseqtJqbJS35nl8928Z3Ks6lAJI0ye5t/BZg++XhDk8mKsJqlJdGE6tiJ1oPrrTeT0TiW0UfQlwTcrfjEzEgg21Va87mCRywXP69p7VYPwYJvvF7YbkRsJNAF3pdybdyKWzwWk5S5V/xjZfAkWcQkKvqjof+FmJuu262oTqf01Jnag3iSnx55eviaUAp7mNprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebt65TiJhPbH1SzDfAtVhroo2jt484YZjO/8nMub5ZY=;
 b=VZEKNVTmWwXYMqa/vk9BmK8n6C7TrpHUhUOgmlSDZDcfG0uiC26dPm/uCgZ/lP9qCAeD68jUJa1cmz9jvDcXW04nPN0Ir2lkXS7ebxW8Cf5334+A2wgdVXsYeFUIXAs/GPlA3q285BpEXTxl7vlL1h0AcFKYaqAatYypZt1Q7D2tOg8sTp6gKyaJqAWJ1iVfm6BuciChkqmTkq+jxMRquBtzLmMsyBIYJztifYl3lMX+SgOUTnID/cTsI9VlpGVs7xDSeCgUu071KYlnC5uk4ET7y8HS7C4fYyKHPLMxKset0oL5+hXIN4hTG++0aci1WdjvQrktQiBt22vBhdcDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH8PR11MB6927.namprd11.prod.outlook.com (2603:10b6:510:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 19:04:30 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 19:04:30 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v5 1/6] x86/tdx: Take the Quote buffer as a generic
 pointer
Thread-Topic: [PATCH v5 1/6] x86/tdx: Take the Quote buffer as a generic
 pointer
Thread-Index: AQHdTzGoFO/IMnLsW0W4KJsbOGux/rbkWfyA
Date: Mon, 28 Sep 2026 19:04:30 +0000
Message-ID: <5e4e97560352666d55033fbcb92f2f183fd42086.camel@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
	 <20260928100913.2265687-2-peter.fang@intel.com>
In-Reply-To: <20260928100913.2265687-2-peter.fang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH8PR11MB6927:EE_
x-ms-office365-filtering-correlation-id: 5742c2e4-833d-4cbf-c5d4-08df1d935308
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 6cewBqVP7IGgF974xMiUDpceTrWlHF2wZ6vBHVKDiTzCkvoNMG0W1SLmn5MakrPGKvRGRo5KR6FEvwVOWl3WeEFO8nV4pQFUmBeeJh1UKuN9jYsd4xXfE/DJu0CsNeVjIa8bFs7QxuxMD/8HaRvlHuMdlH7BOSn0V0f+3aDmRxWj5OVRqAHEsNV37uXsIYfml/et5LB33QWmexI5M3CtflzCcTckIX6fP4+xGomc9bxuR/AQJ+rpBehn4dygPC5N9lZeNUPMp9T15h217ZPoNjSMmTTrkWccEEjGe3wwQfKVzhV3oi3UW7ld5zw2G1lIXws9eA0FswQpw8lCYS8ZNiISSkSLXKjhOUy8b+IjgzZw4XWRwcDdViETvU5QHjsKMZ9sSFWBTRuOX82yUNLmf0FxjzaBlsLIzWKLpgwA8eBJSomm7l55PN//vGNm3qcPra8imQR/1ehxHFn0K4+WB7VO5bluWWwC561TdG4IrxjJwZ8U7je6tV79DUf6dQhsXweCrDmAVQIrsVBlqaxTyFbgydAlcFQdQiANrG/8DXQQ3u55EeZzuAaYRju///8puhTbCrhyue3NsVgo87/x14+Ez+75LXkxoOpVOHHzm17tENgxUhjSLBGO4Am+mFWRG/T46Eu3NQKkIPSbncKJqCLBRemjM2iWLY+z5aQt+WwSlMIIjzr6a/mjtJBcDhd+A516y0AcHHYRQRqzwpLnR0d9ZOstyESyL3CHASBmxTA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3J5YXRtTGNuVU1BYm9yS285RDVqTmc4MCtYVU14RHFhbml4aU5XMTlQVHRO?=
 =?utf-8?B?VVdHMW92ZkkwdjRJbjZkcEIrVTVPdWRENHc0SmFZUHk4VnVUYWFPNEhDYURr?=
 =?utf-8?B?T3FXcmxEdUpkT1J5bmhVbnRSMjFNaUhCQzJNS0loSnBDL05walpHcXpUQlk3?=
 =?utf-8?B?OVJZSjVqdjh1ZUNzOUNyTGV6bFY4OWlseTJyNnh3akE0bHR1STJqaUI4SExP?=
 =?utf-8?B?MU54KzFRaE0raFZsckxYYW5FcnNYRldoQ2h5d1dlYmRSM1B0ZmYzZ1cvRmxH?=
 =?utf-8?B?WWFkZXpCcUJ1aXVKTTZkcnF5cUsxNE1jQjdLd2dtVjM0MWhTczlrOEdTSWNR?=
 =?utf-8?B?THEwSnVPazYvZ1lnalF4eGZkY05GM3ZVZFdHcnNTRnZWZDh5aFA4TlJsMmd5?=
 =?utf-8?B?Z3FQNnF1eXVDcGUvMlErK2c2N2dRZmZSaVJsYkZrdENLMDdwL0RSbXRYOXkw?=
 =?utf-8?B?NGVWR0pweGtXY2UwSDdtRWk1OTk0b01ORXZBaVZrYkVPeTFreHZOTnNabzFV?=
 =?utf-8?B?eGFCbWRjT1c3M25OWmNncUdpZC9zSEpFaU13TTVrRDkrVFlJOXhQcFpLUG55?=
 =?utf-8?B?ZVpVS3R2R01YL3VFZThNWk05VXd0Z0dzNnkxckJnV3R5YUp2U2ZwK0JZVE1j?=
 =?utf-8?B?QWtVM2s4T21HSk5NZlU5cXBleU9jQS9YT0NZTW96b3hxVCt2NkdMTDBLaGdw?=
 =?utf-8?B?eXdOdmZ5ZTVXay9rTXlubmpKY2l3QU1hMk8yNVI5L0hDKzB1VGJ6dE9oTkl1?=
 =?utf-8?B?ZXdCNkFJNStFUDUzcENFQ3Z6WU1tWVhJT3pvYTJ0QllzK1ZvcXJkU01STkt4?=
 =?utf-8?B?ZG80UHlGQTJXSmZGNm5WcnZ1MTdTcWkwSGhVUmgyOFdURWJFejR6b0dNWE1t?=
 =?utf-8?B?elVPQ3VDSzl5Y1NVVExhZDVPNUtjRVVJa09NSGt4aGR0ek5ickhOOS9wTFBR?=
 =?utf-8?B?dU0yeHlqUi9tbU8xNnkxelBhTE9VKzhDUFJWSDk2RGVqK3FKbXNBWHV0cGNo?=
 =?utf-8?B?V0tONWg1U2EydWUvZlNQbU5BU252M0NlcDYxWnVFbGl0YlUzbGRiTXpJdlQ2?=
 =?utf-8?B?V0Y1TGNnbFlCcHRSeFNVMEoxbkRpeEU5U1YxdXUrRVhxeW5wd0o5N0NDNnJN?=
 =?utf-8?B?WFRBSUI1ZDI5RVIyUmdaL0dERlJuaTlLTEEyS3NIaVYxWDNWU3UxYkNiak1M?=
 =?utf-8?B?WGFVL2NPQjFnbXptSVZXUHNqYW1qNW5Nb1d2TkVzL09oYjRjb0dBb25ITU9r?=
 =?utf-8?B?Z09JZTFSa3RBYVZENFlxZWhrSVJNeEZFSVhQWFZwZ1ZaSTQwQkhTYitaYUNC?=
 =?utf-8?B?cWNaUXpkcHd5bDFuWHcvN1FFeDY0VVdNdnYxMTNtUVRZMStGRmNhdVpQZmJE?=
 =?utf-8?B?aEdNWXhIUGkzU3ZKYmpYcTgxd2Z5TXJPOFNWVUVpYnBMYTJGcDdHcjF2N1Zx?=
 =?utf-8?B?aVBpU0drVzhXZ2lhbTdwVkNWQVpRdEh0YTk1SHV2bjNLMHJhZkppbm9XYU84?=
 =?utf-8?B?TWRpcHdtTzl4VTcrYWk0NktKamZMVU04M2NsUWoxeE8yc2hPYi83MTlBZEJK?=
 =?utf-8?B?cjNHRWp5TG85MkFpYXE3K1E5ZUJwaE5vaEVZV1VIbDFPbnNJWkZaMzc4azBv?=
 =?utf-8?B?L3VNSDZSUmUyVGZLK0pvaDgzaVVaTEZuam5SR0JTdjMxMVg5VFNieG16WEdQ?=
 =?utf-8?B?cG5ZUjRGWVgzaVdmMVVDbGlzYjdtWjh5U09XbWdZVGkyZmJIRTNZS3dqTG1O?=
 =?utf-8?B?anFCbGQxdlJMS0M0ZS9oTGpLODg1T0QxWWt3UUhTMWcxU2FzSkxXRzNydzdU?=
 =?utf-8?B?NVlieHBqSVJzN1lERFBHR1ovbVRhbkJIcTRPblNBNTh2SWZLSFF2QllTTzVi?=
 =?utf-8?B?ZmdrelQ5MXI1UTVQSXpDMmZiVzI1NDJ5N2NXUDZXUnJiaEFrallCYVNrd2p0?=
 =?utf-8?B?a3lEaDhCMDJIOXVvZ1c3UHFtQitzdHFsWTFhNEpHRlBFNG9lS05vZnhHbW5X?=
 =?utf-8?B?SjAyczFKbkVnb3E4TWtIWWtyczQzaUw3UHNyOU50dnExeWNRVmZTbkVsTHlN?=
 =?utf-8?B?WlpEK2s0Y1A3ajlpMFlwMkI1UFpaYWZaSkdIYXFDcnVxNjA2Q1g4clgzenpi?=
 =?utf-8?B?OGN2Yy84NHV3OFUyZnBLK2puK0dFVS9kcU9uTTE3dVVTeGJTaDBHYU1uMGJy?=
 =?utf-8?B?YzNsc2VsMzVsNUx5RFBIdlMyTEdrK0h2NXZNWDltaWx3dmZxV0ViUkZSZjB5?=
 =?utf-8?B?NkdjR05TMHdnQTI4RU1TTkd1Z3BCTm4rTlNZbEZ6RjNWNDV6dGVkZS9RZlMv?=
 =?utf-8?B?V0o1UnlQUk5MV0xTQ0RmSW1UcEIxa1R6UHFjNXNCaHh2QXFBLzRXZTFZcEUw?=
 =?utf-8?Q?JsZ0o85tSevfKyeE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4FA750996EB254182FAC796D03DEA96@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tV6Qu/BiH+HfnBH/P2k3onfD0IKGH7ufEYQ50k8o2azN/K96yO32ac2r2rb4ex8DWLWBM/+dHdAJUcOpkYrTpertwYCPzaZndOJk7vcI8QnmRl+BmcTfHKVOBtzYUX6wJjBbDesEKOJpvcATdALbC9GbTGpv7JbFSXi0amaZGk6rzIljef/9uftN+R7gUnoKSl9nClgoySdQ5ZR5K2nbqLTC7lbxESA0todt36p16OQKhxFwXRD1uPCBv7sf+LUqm+mtwY/u7p5UB9MkQLwlevpnEMblWUCapnsZLRV+yhkoMd/Wa+alzu+0/D4/4MgAwy5/2N6Om67N1Dw8It+Yqg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5742c2e4-833d-4cbf-c5d4-08df1d935308
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 19:04:30.0336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ei6HXPUNhofNVMSU3zxrotQGQ5y8qEtgG1NRqrqZ1bY02KdC/0Af/CDXAjtXLtN/6X4H0W6k6H73e+l/Pe4FaqpqnOayL60ZNYM0xMvwyyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6927
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDAzOjA4IC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiB0
ZHhfaGNhbGxfZ2V0X3F1b3RlKCkgdGFrZXMgYSAidTggKiIgYnVmZmVyIHVubmVjZXNzYXJpbHku
IEl0IGlzIG5ldmVyDQo+IHVzZWQgYXMgc3VjaCwgc2luY2Ugb25seSB0aGUgYnVmZmVyJ3MgbWVt
b3J5IGFkZHJlc3MgbWF0dGVycy4gTGV0IHRoZQ0KPiBndWVzdCBkcml2ZXIgZ2l2ZSB0aGUgYnVm
ZmVyIGEgdHlwZSBpbnRlcm5hbGx5IGFuZCBqdXN0IGFjY2VwdCBpdCBhcyBhDQo+ICJ2b2lkICoi
IGluc3RlYWQuDQo+IA0KPiBBSSB3YXMgdXNlZCB1bmRlciBzdXBlcnZpc2lvbiB0byBjb2xsZWN0
L2FwcGx5IGZlZWRiYWNrLCByZXZpZXcgY29kZSBhbmQNCj4gd29ya3Nob3AgbG9ncy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFBldGVyIEZhbmcgPHBldGVyLmZhbmdAaW50ZWwuY29tPg0KPiAtLS0N
Cj4gdjU6DQo+IMKgLSBOZXcgcGF0Y2guIFByZXBhcmUgZm9yIGEgdHlwZWQgUXVvdGUgYnVmZmVy
LiBbRGF2ZV0NCg0KSSBndWVzcyB0aGlzIHRyYWNlcyBiYWNrIHRvIGEgY29tbWVudCBieSBCaW5i
aW4uIFdoaWNoIGhhZCBhIHNwZWNpZmljIHJlYXNvbi4NCkNoYW5naW5nIHRoZSBnbG9iYWwgZnJv
bSBhIHZvaWQgKiBtZWFucyBhIGNhc3Qgd291bGQgYmUgbmVlZGVkIHRvIHBhc3MgaXQgdG8NCnRk
eF9oY2FsbF9nZXRfcXVvdGUoKS4gSSBoYWQgdG8gZ28gaHVudGluZyBiYWNrIG11bHRpcGxlIHZl
cnNpb25zIHRvIGxlYXJuIHRoaXMNCmJlY2F1c2UgdGhlIGxvZyBkaWRuJ3QgbWVudGlvbiBpdC4g
T3RoZXJ3aXNlIGl0IGxvb2tzIGxpa2UgbWlzYyBjbGVhbnVwLiBDYW4geW91DQpleHBsYWluIHRo
ZSBjb25uZWN0aW9uIHRvIGZ1dHVyZSBjaGFuZ2VzIGluIHRoZSBsb2c/DQo=
