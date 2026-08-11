Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61CF2472AA;
	Tue, 11 Aug 2026 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411133; cv=fail; b=YRcmz21JNqBFL6/OnCzB98ikFVKDZlJGU9uQNXHK1iDfG8cl0gzPGphRThs4DYKcGVTH8ZyUtTe8tqMb3TDMMoVeAnLnVNB8yiFmUP2Lhi4v0WFNK/lnRTAuY1Hvi44uZ/dHJkliz/iflJ8vR8uG331Vb27pFyeGON7wFXupHNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411133; c=relaxed/simple;
	bh=LjknO1PAtO+qGTC8+116VgUJ2qyOXVZfwqqsVIdCwMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ozIY5Zlkmavpd4NRGAjiSn5dPnelxL0TSis2MzREJxCcyaAEeK2PSYOA82GDSXHEpCwOSh/gjDVIqMQ73UgteTEzCrQxLdTlLSNgenrrZ/2XutngrSu4VNmiP8eL7EevPdJwFKGmoNmg65DRUSCKwBan0iuZrPZCTqrhaEIfOrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClqcTM1s; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClqcTM1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786411130; x=1817947130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LjknO1PAtO+qGTC8+116VgUJ2qyOXVZfwqqsVIdCwMQ=;
  b=ClqcTM1slSohOT7mpZzy9uSmYC+KipRKnFGjfyA8P2rFQrkMqOKdzLpm
   J9g+435mKrYxe7evFYGJMe0woKkYmwNk8pYXHs0Sq3SnVS9h0HOHuXStJ
   aIqAsHl4W9YqhYjjun80ohDsIZ8Xmgvur7tsoBZsqeqSN8yg/c1ssoAzp
   guHIFHv5tVG8Uu8ZcymDEFk47GksSg9F3GzkItwc5ZVnbiG5m4Z1jTnYS
   Z91vNTVi5jnLp+9f9LUDrxlidxuTD0U+z8ERxIAHWsO/XGFLtHH43bjYp
   oSnOapca/sTE9VQcenJnHL3LmziCrOZMrwLW/V8t2F1JudsrsZn6eA4Kh
   g==;
X-CSE-ConnectionGUID: y5lGXlp+RcmbJpzfJuLjPw==
X-CSE-MsgGUID: tFFprzynSpqJ1hs78YHF2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98296409"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="98296409"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 18:18:49 -0700
X-CSE-ConnectionGUID: Qwnm9oX6T5eYImCxCSgdhQ==
X-CSE-MsgGUID: T3FCZa4lSJiMkV4fIgUqog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="256971074"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 18:18:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 18:18:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 18:18:48 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 18:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7ItEdlnf9kY9vMYPyYx8px8VHJD9ehW4HkASDGAoJPHEyFtkfXFzdwyi8guSVO30NNeLmja7igPa/ZF88dAoFn2vvDhZkn3glUWaQBPMq9kG421e76f/sp6YUdRobAiVfzD2257SI4KWgPI83yJjguNVte29qBfgJKZ3M0VG//Fzf/+9JkjXCsVmwdetuENTAQ5XSDjMfgYOwsCeTHcEptPAy+L5FlPtXfpnzxkPB9yVhERUwIqzqOWn2z4zgdO89/Tllo66ctAjYBhDOX26WU3DjQBfPzTPFBDb26DijLNt/rGTyMUaApid2J4hVR35nxVub1fj7NDrFxPistnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjknO1PAtO+qGTC8+116VgUJ2qyOXVZfwqqsVIdCwMQ=;
 b=zRdJzh6am/OqcqIkkLfdy8TpfkgZtszQJNbgktBqZLrjnZfjMKWkItVdef6wqlICdrsRAdHhiUVeWevm620rKjsV1Xfs5Z3JBmwo4uj8R1Sf9zEQ+kzEwP4zwwA62+jJht5KQboy6ejIZXTooDK92TPX6h1hwngfx50Yb20T0/2suJnQfdtCrHxYjPFwrwmooIW0R7DVod2k8f/2rrklBNNUEABYbeJiCWK4bXuuwwcom3yopYW+ZpJxTEqyGZPIYxlrM/fSEvpz6HJ1qpw3FrG2vP2F0A6IYCoyrP9us+J6jwJC7BQLv5dvj9PrzbFnMXKr/4phn2hkYNC2z7CrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DSWPR11MB9930.namprd11.prod.outlook.com (2603:10b6:8:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 01:18:45 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 01:18:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] KVM: TDX: Enable Bus Lock VM exit
Thread-Topic: [PATCH v2 3/3] KVM: TDX: Enable Bus Lock VM exit
Thread-Index: AQHdKLs2QPenYNyidUyTPJ2fMW7YmraYDT0A
Date: Tue, 11 Aug 2026 01:18:45 +0000
Message-ID: <fd9498858696baf30ab5b151f79fcf173d0fb0cd.camel@intel.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
	 <20260810112200.2326727-4-xiaoyao.li@intel.com>
In-Reply-To: <20260810112200.2326727-4-xiaoyao.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DSWPR11MB9930:EE_
x-ms-office365-filtering-correlation-id: 3da187d7-5aab-499d-dac6-08def7467d26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: E6rGseRJGva+nJzvqWXDs5MLBoIqobgbXqDLjTmYS9+zvuvdQ+hi8DH/0gIii+uBQgvUo9zWbkTfZJlryqQ2U2h/jucvCyjx3kOEKBLZtcLfJUXXR1IKdNkkX+nHbZvWVojcTaFVrEjab4GxJz91jwMN9W7IBWcyaSZLE4QGm9TvBo8JIp/ca9RMAB7GelyB5dy2+3q9LYX07Gyw6i9dD1BL9p94OSwnjqW9bUF06l9QkrjpKLRPeTJBS6idzYR23Q3WyePl0M/zD5+JMZMAHsmd+WYwNAEVUfHxYytuu+glOMkfRxdIT/R+NtCJP8EURjk1U1mXkLnsivKjoIGdHp8niUCw7iWjECNzmEJ5/cbZZdztnHEcwILmNzL0qPJXN0gfc7RCchRRZ3UKKFbx7P/HeHmCTJzP5P34OW7PMkITx0KRPTmt2yOhbYKbzcprRweIBn04/RX42aCH5bo+WPju3a/5TcXB+2Z0Ct1GZfJr9BUw4k+4FUk02MgqKKuIcrpCSBq14fqEx67py9lAGWp81kVPaKSdwiYdXB7kgez273As6IwpLFiOpDa6ShyCkhwkkhKymyOdyQpZu6qPu6yl1Nu/qBmijKuTlHGwZRkqTXHDxJWSxOGIrTG0FbrFNnyc1ycOBgHgyWFDit6OvH+91YOaXV3bEsFpXN3Ozb0jnGJrs3T4YjhoYlGEanDnauCx/N3yDMK+KXVVQ+yD6UwL/Dqhjlf/3sm1K0KRR0M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0V2Zzh4dHdrS0hsY2hld0xSamIvUmw5SnA1NTBaeDQxM1E2UW5PVHJwU0lJ?=
 =?utf-8?B?U3ZrUG9pWUVkalpNRm1JOWxkcWtIQVdGMmlhMGMzMVc4NnRFTTNNekZaVktG?=
 =?utf-8?B?MjRmY0NBQno5NEN6Y0JkWWxWa3ltNXpDUWRsTnFjM096SGtQMU51UTBRdllj?=
 =?utf-8?B?VThQV3g1L1p0Si9RWVVHSTB2MjN5b3N0YXpNZnV5dlNhRS9zSVZGUk8wN3Jj?=
 =?utf-8?B?T3JhdE1rVkZIbm5tb2NmcXB1RHMrV3BmZnFTUk04Z0NtbmIvUjVqRDIxRWh0?=
 =?utf-8?B?L3RERGZzbWVwMGN4YkhUVHpGNlphR040U2ZRalp4M3RkRTlvQVhwbW1mNTFC?=
 =?utf-8?B?Q3M2L1VKWGh5MjlnWGVSU0pRWk1BSndwVHZRTXN3a3lmYStWWDlCNDJBQ3lj?=
 =?utf-8?B?UDM5Yjk2TmpVTlBEQUFwL2ZLaENLbkJRWVFjVUhMUGtBUDBIREROa1gzdTlB?=
 =?utf-8?B?dnpkSE5aUmMzWGRKU2dXUTN1WEhpYzJyRHN5L1FYOUJSR1RlK0doZFh4RUZw?=
 =?utf-8?B?QVoxREpMQklXUUJ0azFUSGdxUmtrU2tLeHhDbUtoVy9xQjR2d1Z1bDhHblhS?=
 =?utf-8?B?MnFRMmFXeU5mWDM0YytJa25Ic2tVeEUrWXVaRDFSc1RPenMrd2NoR3hFUDFE?=
 =?utf-8?B?NTFoZHpHK1Fob0xNL3Q5RlVqQkJzKzYzOEppemQvc2c3Sm12NzJQeFRaYjds?=
 =?utf-8?B?SDhKMjlnNDdXQTc0K3lncVNQSGM4ejZsaU1wVzRmRWpOU280OWJVKzNtZGZN?=
 =?utf-8?B?RlZWN2dYYklTSW1sLzJ4eWJkczFWWVdXczZqRnF4aGhHWWx2c2F6bnl4R0hh?=
 =?utf-8?B?SlcxRHZFSldSTWZwL1VBMldKYWt6WXdsbkNhU0NzN2wvNE9Wb3VUUVZ5cXRm?=
 =?utf-8?B?TEV6MG51ZW9IMldLY1hIWERtTk5uamdKY0hhenJ2MW9wYTZFNE5SSko3elE1?=
 =?utf-8?B?MHhDQitJK2ViUGRnbmNra2hEWW5BZWljcndBcWlDMDZod29kVm8vWUJCNDJm?=
 =?utf-8?B?MnhsWXgyNkErdk5CYTVXUUpwaTU0L3ZpTnN1b3NGeEZoV004YVRZbTR5RkUx?=
 =?utf-8?B?TnB1UU1kR25OeVFNSnZWeGdjUXBhcHBwSTUrNklWUm5kZ3J5K2NsLzZKa0My?=
 =?utf-8?B?VkhIQ2RRa0U4L3ZraUxxMUxFZWtPbXErSk1uaVZDMnFFUXdMNDhFU2JvaVZz?=
 =?utf-8?B?RU9RTkJQbE81YXB6aFdjdDE2KzJMOFUzb2E0YTZtN3pSKzdGOU9zVHhoODdG?=
 =?utf-8?B?bE16SFQ5MXRkOEdRRFlGdFFUVEpKRUwxRTRubWJqSzE2RStlS0ozSlpQYW9S?=
 =?utf-8?B?TFFkZi80M3p0U3c0VW9LdkxXaGdRdGFaV3VkbHVnY3ZwSStoUm90cmdvbWpP?=
 =?utf-8?B?V2RlNEhadWd5QlhRVnZKRjQ4WXJiUm9Rb0dPQU5WWFBVbTlEcEpXcG9jZnBE?=
 =?utf-8?B?WkNNWlFBOG42OTd1eWVhVTBKSXp6SFAyelNSaWs5bmhIY1p1NGlGWW9WTWpO?=
 =?utf-8?B?UVBKZnJOeGhhelVKNVhqWW5EVVBWR3pzbGdpeVgzSjJCS0JPbGEyOVlNWjJ6?=
 =?utf-8?B?OXEwQ0dUNWtBQTVuNmdzNENiTCthZmc3VG11ampWQVQ2YllaME9IdUNmeVpn?=
 =?utf-8?B?R3VRbFBaSnpuS05UZVRyeXFtSnZlWng2SzhUV2FteUlsS1hDcTFZT2xCTXVa?=
 =?utf-8?B?VGZaNXRqdjBtZURXdEhqdGR1dnNKcmdTcitLa251bFF1Mzc2dElZSXhLQ0ZL?=
 =?utf-8?B?ZVBNdm05aHJYU2o3WERPdXl5SlFkTGJQUDF3YzZ3OHNoc2ZHSEI3QkNIUW96?=
 =?utf-8?B?Yjk5WTFmNUhuVitNaHB5c2JyRW52dmlXMk1qeXdZdnRqci91UkJ3UUpHY0d3?=
 =?utf-8?B?MHZBeUg2TVpWMlFRa1dEMWU0aGVVQVNmVVp3eGJiMldkNUEyZGM4NVJtaC9Q?=
 =?utf-8?B?eDZaaEp4dUd6ZmZxQ0twbHZKT0lEMGgxTXRCMElBMmFQYkp0QkRXOW9GeXpD?=
 =?utf-8?B?OVVXSFJkdmdoUXpmNDU0blFtbEVsZWlaRHpQTXJpTWcyK1hZQnFhSi9JL0l5?=
 =?utf-8?B?NHdjUHQxS21VQVVzYTQzVjFSd3lRWjh6aUVPK2hwL2RWMWdqcEJyWW5JWmFF?=
 =?utf-8?B?TmIyZERDVlI0ZkZnb3lnb3pEQnhaU2xCa2twdm5jaGo3K1VjUkp3QjNjaU9z?=
 =?utf-8?B?ZFNnZDZ2ZExOaGd2NTlqS2hqNEV2cUx2Sjl2SUtCUm9XdzlBT3RYVVdMaS84?=
 =?utf-8?B?QXIxT25KYjlvOVdhdFgvLy9sZjl1ZlByRmtjWElzV3lmbjdpSEozMklpYUNh?=
 =?utf-8?B?WDkvbFR5a0Vma3JhRS8zN0c1M3VWcGF4RVAyQjNUTjRtTjRVSzRYek5ZeWpZ?=
 =?utf-8?Q?S/xurzjKEQVZB/Wg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91E7FB424E0DAD4593451DE046DDF37E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tP8L8c7ruwCTpoHqypi0+5UYEH9kbEO+g43+TKZUqg71F48CNVdEmYMTSwq7rzv2OpBPIdsKgBn/QcVJo+1LAWiFJUCWfjAVQy6FU6bbKPKm3YXr+w9Tg1ai9OHLnBbjEAxypvZLTh90mDF7sKqgJEN2aqqvfJV0W6U1rbqAraCOM4FG1S5WZTrRwBeIrgSg6jecUs/IufobVj4kXWk4bRuaKxpHwUAvvHO19OA2TlLsjHSRGXkrGf0pL9DQxI/fN+RsR8sadQ6Fu8fMVjM+Dk4mjMhj7GyY2c7Cfblj/bMJOUKRcJ4DAtE4Z6w/tbigrgS/tprVBrlfYpfBpt4wvw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da187d7-5aab-499d-dac6-08def7467d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 01:18:45.2297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vON1obrhHeVndvIbYOkvQ4MkZ9WVxTHNUyNBxhB51GSxqOdDtVNKpOnux+yg7JEaoWWGRjZR1a4YXDW6dzZfOh8DQE6yw4Dz1jrzVwTVOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9930
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA4LTEwIGF0IDE5OjIyICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiBF
bmFibGUgQnVzIExvY2sgVk0gZXhpdCBmdW5jdGlvbmFsaXR5IGZvciBURFggZ3Vlc3RzLg0KPiAN
Cj4gVXNlcnNwYWNlIGNhbiBlbmFibGUgS1ZNX0JVU19MT0NLX0RFVEVDVElPTl9FWElUIGZvciBU
RFggZ3Vlc3RzIHdpdGhvdXQNCj4gZ2V0dGluZyBhbiBlcnJvciwgYnV0IHRoZSBmZWF0dXJlIGlz
IG5vdCBhY3R1YWxseSBlbmFibGVkIGJlY2F1c2UgS1ZNDQo+IGRvZXMgbm90IHlldCBwcm9ncmFt
IHRoZSBURFggZXhlY3V0aW9uIGNvbnRyb2wgb3IgaGFuZGxlIHRoZSByZXN1bHRpbmcNCj4gZXhp
dC4NCg0KQSBiaXQgcnVuLW9uIHRvIG1lLiBXaHkgbm90IGJyZWFrIGl0IHVwIGxpa2UgaXQncyBl
eHBsYWluZWQgaW4gcGF0Y2ggMS4NCg0KPiANCj4gRW5hYmxlIEJ1cyBMb2NrIFZNIGV4aXQgZm9y
IFREWCBndWVzdHMgYnkgcHJvZ3JhbW1pbmcgdGhlDQo+IEJVU19MT0NLX0RFVEVDVElPTiBjb250
cm9sIGluIHRoZSBURCBWTUNTIGFuZCBieSBhZGRpbmcgdGhlIGV4aXQgaGFuZGxlci4NCj4gQ2xl
YXIgdGhlIGJ1c19sb2NrX2RldGVjdGVkIGJpdCB0byBhdm9pZCBiZWluZyBjb3VudGVkIG11bHRp
cGxlIHRpbWVzIGlmDQo+IGl0IG5lZWRzIHRvIHJldHVybiBlYXJseSBmb3Igd2FpdF9mb3Jfc2Vw
dF96YXAgY2FzZSBpbiB0ZHhfdmNwdV9ydW4oKS4NCj4gU2luY2UgdGhlIHdhaXRfZm9yX3NlcHRf
emFwIGNhc2UgaXMgZXhwZWN0ZWQgdG8gYmUgcmFyZSwganVzdCBkbyB0aGUNCj4gY2xlYXJpbmcg
b2YgYnVzX2xvY2tfZGV0ZWN0ZWQgdW5jb25kaXRpb25hbGx5Lg0KPiANCj4gTm90ZSwgdGhlcmUg
aXMgbm8gZW51bWVyYXRpb24gYml0IGZvciB0aGlzIGZlYXR1cmUgYnkgVERYIG1vZHVsZSBiZWNh
dXNlDQo+IGFsbCBURFggbW9kdWxlcyBzdXBwb3J0IGl0LCBhbmQgYWxsb3cgdG8gc2V0IHRoZSBU
RCBWTUNTIGFzIGxvbmcgYXMgdGhlDQo+IGhhcmR3YXJlIHN1cHBvcnRzIHRoZSBmZWF0dXJlLg0K
PiANCj4gRml4ZXM6IDE2MWQzNDYwOWY5YiAoIktWTTogVERYOiBNYWtlIFREWCBWTSB0eXBlIHN1
cHBvcnRlZCIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IE9yaWdpbmFsbHktYnk6
IENoZW55aSBRaWFuZyA8Y2hlbnlpLnFpYW5nQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
WGlhb3lhbyBMaSA8eGlhb3lhby5saUBpbnRlbC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYy
Og0KPiAtIERvbid0IG92ZXJ3cml0ZSB0aGUgbmVnYXRpdmUgcmV0dXJuIHZhbHVlIHRvIDAuIChT
YXNoaWtvKQ0KPiAtIENsZWFyIHRoZSBidXNfbG9ja19kZXRlY3RlZCBiaXQgd2hlbiBpdCByZXR1
cm5zIGVhcmx5IGZvcg0KPiAgIHdhaXRfZm9yX3NlcHRfemFwIGNhc2UuDQo+IC0gQWRkIGEgbm90
ZSB0byBjbGFyaWZ5IHRoZSBmZWF0dXJlIGlzIGFsd2F5cyBzdXBwb3J0ZWQgYnkgdGhlIFREWA0K
PiAgIG1vZHVsZSwgdG8gbWFrZSBTYXNoaWtvIGhhcHB5Lg0KDQpIYSEgVGhpcyBpcyBwcm9iYWJs
eSBqdXN0IGJlaW5nIGEgYml0IGZ1bm55LiBCdXQgbGV0J3MgdHJlYXQgQUkgcmV2aWV3IGFzDQpz
dWdnZXN0aW9ucyBvbmx5LiBJZiBpdCBpcyBhIGdvb2QgZmVlZGJhY2ssIGl0IGNhbiBzdGFuZCBv
biBpdCdzIG93bi4NCg0KPiAtLS0NCj4gIGFyY2gveDg2L2t2bS92bXgvdGR4LmMgfCAyOCArKysr
KysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jIHwgIDIg
Ky0NCj4gIGFyY2gveDg2L2t2bS92bXgvdm14LmggfCAgMSArDQo+ICAzIGZpbGVzIGNoYW5nZWQs
IDI4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva3ZtL3ZteC90ZHguYyBiL2FyY2gveDg2L2t2bS92bXgvdGR4LmMNCj4gaW5kZXggYTg5
ODg1ZDU1MGM5Li5hYzNmNzE2NDNjZDUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2t2bS92bXgv
dGR4LmMNCj4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC90ZHguYw0KPiBAQCAtMTA4MCw4ICsxMDgw
LDEwIEBAIGZhc3RwYXRoX3QgdGR4X3ZjcHVfcnVuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTY0
IHJ1bl9mbGFncykNCj4gIAkgKiBhbGxvd2luZyB2Q1BVIGVudHJ5IHRvIGF2b2lkIGNvbnRlbnRp
b24gd2l0aCB0ZGhfdnBfZW50ZXIoKSBhbmQNCj4gIAkgKiBURENBTExzLg0KPiAgCSAqLw0KPiAt
CWlmICh1bmxpa2VseShSRUFEX09OQ0UodG9fa3ZtX3RkeCh2Y3B1LT5rdm0pLT53YWl0X2Zvcl9z
ZXB0X3phcCkpKQ0KPiArCWlmICh1bmxpa2VseShSRUFEX09OQ0UodG9fa3ZtX3RkeCh2Y3B1LT5r
dm0pLT53YWl0X2Zvcl9zZXB0X3phcCkpKSB7DQo+ICsJCXZ0LT5leGl0X3JlYXNvbi5idXNfbG9j
a19kZXRlY3RlZCA9IDA7DQo+ICAJCXJldHVybiBFWElUX0ZBU1RQQVRIX0VYSVRfSEFORExFRDsN
Cj4gKwl9DQoNCkhtbS4gV2h5IGlzIHRoaXMgdGhlIG9ubHkgcGFydCBvZiBleGl0X3JlYXNvbiB0
aGF0IHdlIGNhcmUgYWJvdXQgaW4gdGhpcw0Kc2NlbmFyaW8/DQoNCkkgd2VudCBhbmQgbG9va2Vk
IGZvciBzaW1pbGFyIHNjZW5hcmlvcyBvbiB0aGUgVk1YIHNpZGUgdG8gc2VlIHdoYXQgaXQgZGlk
LCBhbmQNCmRpZG4ndCBmaW5kIGFueS4gU2FtZSBmb3IgeW91Pw0KDQo+ICANCj4gIAl0cmFjZV9r
dm1fZW50cnkodmNwdSwgcnVuX2ZsYWdzICYgS1ZNX1JVTl9GT1JDRV9JTU1FRElBVEVfRVhJVCk7
DQo+ICANCj4gQEAgLTIwMzcsNyArMjAzOSw3IEBAIGludCB0ZHhfY29tcGxldGVfZW11bGF0ZWRf
bXNyKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgaW50IGVycikNCj4gIH0NCj4gIA0KPiAgDQo+IC1p
bnQgdGR4X2hhbmRsZV9leGl0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZmFzdHBhdGhfdCBmYXN0
cGF0aCkNCj4gK3N0YXRpYyBpbnQgX190ZHhfaGFuZGxlX2V4aXQoc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LCBmYXN0cGF0aF90IGZhc3RwYXRoKQ0KPiAgew0KPiAgCXN0cnVjdCB2Y3B1X3RkeCAqdGR4
ID0gdG9fdGR4KHZjcHUpOw0KPiAgCXU2NCB2cF9lbnRlcl9yZXQgPSB0ZHgtPnZwX2VudGVyX3Jl
dDsNCj4gQEAgLTIxMzgsNiArMjE0MCw4IEBAIGludCB0ZHhfaGFuZGxlX2V4aXQoc3RydWN0IGt2
bV92Y3B1ICp2Y3B1LCBmYXN0cGF0aF90IGZhc3RwYXRoKQ0KPiAgCWNhc2UgRVhJVF9SRUFTT05f
Tk9USUZZOg0KPiAgCQkvKiBOTUkgYmxvY2tpbmcgc3RhdGUgaXMgaGFuZGxlZCBieSBURFggbW9k
dWxlICovDQo+ICAJCXJldHVybiBfX3ZteF9oYW5kbGVfbm90aWZ5KHZjcHUsIHZteF9nZXRfZXhp
dF9xdWFsKHZjcHUpKTsNCj4gKwljYXNlIEVYSVRfUkVBU09OX0JVU19MT0NLOg0KPiArCQlyZXR1
cm4gaGFuZGxlX2J1c19sb2NrX3ZtZXhpdCh2Y3B1KTsNCj4gIAlkZWZhdWx0Og0KPiAgCQlicmVh
azsNCj4gIAl9DQo+IEBAIC0yMTQ3LDYgKzIxNTEsMjIgQEAgaW50IHRkeF9oYW5kbGVfZXhpdChz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGZhc3RwYXRoX3QgZmFzdHBhdGgpDQo+ICAJcmV0dXJuIDA7
DQo+ICB9DQo+ICANCj4gK2ludCB0ZHhfaGFuZGxlX2V4aXQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1
LCBmYXN0cGF0aF90IGZhc3RwYXRoKQ0KPiArew0KPiArCWludCByZXQgPSBfX3RkeF9oYW5kbGVf
ZXhpdCh2Y3B1LCBmYXN0cGF0aCk7DQo+ICsNCj4gKwkvKiBFeGl0IHRvIHVzZXIgc3BhY2Ugd2hl
biBidXMgbG9jayB3YXMgZGV0ZWN0ZWQgKi8NCj4gKwlpZiAodm14X2dldF9leGl0X3JlYXNvbih2
Y3B1KS5idXNfbG9ja19kZXRlY3RlZCkgew0KPiArCQlpZiAocmV0ID4gMCkgew0KPiArCQkJdmNw
dS0+cnVuLT5leGl0X3JlYXNvbiA9IEtWTV9FWElUX1g4Nl9CVVNfTE9DSzsNCj4gKwkJCXJldCA9
IDA7DQo+ICsJCX0NCj4gKw0KPiArCQl2Y3B1LT5ydW4tPmZsYWdzIHw9IEtWTV9SVU5fWDg2X0JV
U19MT0NLOw0KPiArCX0NCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KDQpPaywgc28gdGhlIHBsYW4g
aXMgdG8gY29uc29saWRhdGUgdGhpcyBkdXBsaWNhdGlvbiBvbiB0b3Agb2YgdGhlIGJhY2twb3J0
YWJsZQ0KZml4Lg0KDQo+ICsNCj4gIHZvaWQgdGR4X2dldF9leGl0X2luZm8oc3RydWN0IGt2bV92
Y3B1ICp2Y3B1LCB1MzIgKnJlYXNvbiwNCj4gIAkJdTY0ICppbmZvMSwgdTY0ICppbmZvMiwgdTMy
ICppbnRyX2luZm8sIHUzMiAqZXJyb3JfY29kZSkNCj4gIHsNCj4gQEAgLTMxNzMsNiArMzE5Mywx
MCBAQCBzdGF0aWMgaW50IHRkeF92Y3B1X2luaXQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1
Y3Qga3ZtX3RkeF9jbWQgKmNtZCkNCj4gIAkJCQl2Y3B1LT5rdm0tPmFyY2gubm90aWZ5X3dpbmRv
dyk7DQo+ICAJfQ0KPiAgDQo+ICsJaWYgKHZjcHUtPmt2bS0+YXJjaC5idXNfbG9ja19kZXRlY3Rp
b25fZW5hYmxlZCkNCj4gKwkJdGRfdm1jc19zZXRiaXQzMih0ZHgsIFNFQ09OREFSWV9WTV9FWEVD
X0NPTlRST0wsDQo+ICsJCQkJIFNFQ09OREFSWV9FWEVDX0JVU19MT0NLX0RFVEVDVElPTik7DQo+
ICsNCj4gIAl0ZHgtPnN0YXRlID0gVkNQVV9URF9TVEFURV9JTklUSUFMSVpFRDsNCj4gIA0KPiAg
CXJldHVybiAwOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC92bXguYyBiL2FyY2gv
eDg2L2t2bS92bXgvdm14LmMNCj4gaW5kZXggZTUzY2M5NjAwMmM3Li5jNDI5ZGI5YjkyMDUgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMNCj4gKysrIGIvYXJjaC94ODYva3Zt
L3ZteC92bXguYw0KPiBAQCAtNjI2NSw3ICs2MjY1LDcgQEAgc3RhdGljIGludCBoYW5kbGVfZW5j
bHMoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiAgfQ0KPiAgI2VuZGlmIC8qIENPTkZJR19YODZf
U0dYX0tWTSAqLw0KPiAgDQo+IC1zdGF0aWMgaW50IGhhbmRsZV9idXNfbG9ja192bWV4aXQoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiAraW50IGhhbmRsZV9idXNfbG9ja192bWV4aXQoc3RydWN0
IGt2bV92Y3B1ICp2Y3B1KQ0KPiAgew0KPiAgCS8qDQo+ICAJICogSGFyZHdhcmUgbWF5IG9yIG1h
eSBub3Qgc2V0IHRoZSBCVVNfTE9DS19ERVRFQ1RFRCBmbGFnIG9uIEJVU19MT0NLDQo+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5oIGIvYXJjaC94ODYva3ZtL3ZteC92bXguaA0K
PiBpbmRleCBkYzg1MTdmMTViYzQuLjhmYWYwNGMwOTcyMSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94
ODYva3ZtL3ZteC92bXguaA0KPiArKysgYi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5oDQo+IEBAIC0z
NzksNiArMzc5LDcgQEAgYm9vbCBfX3ZteF92Y3B1X3J1bihzdHJ1Y3QgdmNwdV92bXggKnZteCwg
dW5zaWduZWQgaW50IGZsYWdzKTsNCj4gIHZvaWQgdm14X2VwdF9sb2FkX3BkcHRycyhzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHUpOw0KPiAgDQo+ICB2b2lkIHZteF9zZXRfaW50ZXJjZXB0X2Zvcl9tc3Io
c3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1MzIgbXNyLCBpbnQgdHlwZSwgYm9vbCBzZXQpOw0KPiAr
aW50IGhhbmRsZV9idXNfbG9ja192bWV4aXQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsNCj4gIA0K
PiAgc3RhdGljIGlubGluZSB2b2lkIHZteF9kaXNhYmxlX2ludGVyY2VwdF9mb3JfbXNyKHN0cnVj
dCBrdm1fdmNwdSAqdmNwdSwNCj4gIAkJCQkJCSB1MzIgbXNyLCBpbnQgdHlwZSkNCg0K
