Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF0233942;
	Fri, 19 Jun 2026 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854595; cv=fail; b=OXva0sgi2rblH56ZSKeqT9dRfuFQdb6vMceF5LqIch92h4Xg3IEH44qnq82BOyxBdalvkKLgKvYJ6t5XO8t3NdhgvOQKKq/LZ8jpNtzu8Quy+0OSgSeyPZoVFIgZBxYCNA95FBmJFHb/+KlNbERPuFELEipt9iEQru8ljjCiDTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854595; c=relaxed/simple;
	bh=1VnB79kwEfkiCM5yE/BKJLToUfkbY32d0vsVklPhHmo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HH01XKbpEDuVdnDn5PHXCeHMMjju4byG36mQmItWBtMtzlXGdI/+avvTN+In8lzBN3u9gfePmQZWOAtWPyZnLpffh6L1oNa16L/lmH2+S8qSLAuDLGHOkCptX5/9yAQCGc3oX9pL0tB3e9G0Tzh3JC+lmzE63aTWT2zZekL+tBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RarhdrD9; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RarhdrD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781854595; x=1813390595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1VnB79kwEfkiCM5yE/BKJLToUfkbY32d0vsVklPhHmo=;
  b=RarhdrD9dzsDrqUAuJKvlIO4XwYEbiDT2VlvsaBaCeNJXE5RrWESCiDW
   nFNaXMuhI/D8BqLIDw+hF+MVfg3Ydq5rOYNqmw+2t1MEICToQtL26qbAZ
   4mW65owapQPKeUCbs3FJ5V+AILCeAzcUrd0fh7yB9l9Ju1nWeXxV2FZYt
   QkW1kxvXANPHCNQ219c+9IPpzs8jD+HJu8nFhh4cpqJF+zLW+8ZF1oiH9
   p6seurfuZRRFDFirCrBO94xJxE9xRspp+m2QTHcCr3n5RTYe7T71Of6Fk
   IviQ5OIiqbTYDtMmnNBp8JiHK1yM/31ZYk9bafATlsvRfOoWj2kl2fFB9
   Q==;
X-CSE-ConnectionGUID: 0typpdVuQaGa5628ZmSPbw==
X-CSE-MsgGUID: 3EVDERXwScOXIxNeY879CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="94096531"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="94096531"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 00:36:33 -0700
X-CSE-ConnectionGUID: FGRPE9VHQbqHb/QQSbUwFg==
X-CSE-MsgGUID: jiGLPh5vSHewrWiyhwFslw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="253557626"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 00:36:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 00:36:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 00:36:31 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 00:36:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlISm7Z+hbJd0RUhokj0s3y9XFR11EMrrzoLhwMn5/B+GqqASNFfWkpZd+DyqcU6GJVoVeNoztoBUinbn3w6D648QWreH+b2BY7p4hOAv5vRkre+/ZD9ekC33xsNBLfwNNDC1BCW43PMUxY/xTq5WWx6elGkoXu1qpvR/K7NkTwwx8pYVq/LTwxUMQp6crT+aZKo/4f1qwmQJDf3qO+9o9X2ZWrgBMmgTgZ8cpe81QotkGSqnO1KXYEQoJwwqhMKzweU9PF0HTxRYAgapfLdIkxg44IxMgQFufqm8Jl23vq3w1XYLJ3ko7qpIbV6OScUXiUL5l5nRHDvLiUz4rOlug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VnB79kwEfkiCM5yE/BKJLToUfkbY32d0vsVklPhHmo=;
 b=uQZl2N42nqNkXR8ck1oX5jMBVw5yh3BpEZMBLIpGGdakz126gk/ipPsmL5DBrO08eHmSNeMXST03yzHQqf50TgW1dTNZ96VLEYWifzG8ZIJ9vk70RfAY0bv+rXJpMFzUYhH1MU7YmnhZeIRJ/0hDbXDw6/FLeUranLlPvxKtgLclPu/iCvl6bVZz35GCxCooZ/859tQNP+MMMhI+yhOSVNG2tgckBJRYzeQ746BuU7LAvs36mXiAGOck77AlP/hqtN48830w3Zh03ytWKlplfxErbpuyErq3Z/G11FXqUGHFmnAYkEdeId+jxuz5WJv+gEk5uOSjjEQ8U1zgUf1HWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Fri, 19 Jun 2026 07:36:28 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 07:36:28 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: WARN (once) if RTC pending EOI tracking goes
 off the rails
Thread-Topic: [PATCH] KVM: x86: WARN (once) if RTC pending EOI tracking goes
 off the rails
Thread-Index: AQHc/0pOFiydeASqwkOv1sWxYJFWXrZFfhYA
Date: Fri, 19 Jun 2026 07:36:28 +0000
Message-ID: <ada04a4834ac481963b3723db4ce47f617a3ff70.camel@intel.com>
References: <20260618174527.1982333-1-seanjc@google.com>
In-Reply-To: <20260618174527.1982333-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH0PR11MB4949:EE_
x-ms-office365-filtering-correlation-id: 6da5a17a-a06b-4d02-591d-08decdd5796f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 0lTJW0kap+xEoVk4/Do7yyepIgUTJL8X6t2lDrhkE+xlIjyCjhU7e0sjHYi4rBX4yvrLnj7cCjQHmYN3xL1HCJ0WvzAf2WM1vAiG1YiCn4Z2i/qqJyEMSqt6JAvsAlk7cECH2MsdHyxvutTvnTY/jT0UlgRUks051vDHPUASVvkZuUP00nNyWZTEfx6gZ2pau2chOyY8snPjpx7RxQCmC21oB0WFNmaQYSLyoAHCA+vIR5zxihFMvTSXOM6r+rx5XFySdFdWkYmqGbi0pp4lVyy0Cd6mTvIBchj6n+9r9V/Z0bYiKTmOhSPiN1EArHZmlAf4NCVDMs+tiw1Z48ocBUIcxH2GW1JRchbw61yJSAOCIgWgrFrYNrdIagU1VZY2hi5tCjI0pQnp/RMcH9MrG8rhjdhAtXeFVWd7Zm25NDrisvVclm29rH+nkddFBKbMMeoxU3FMTkz/M+klflrpfpjvlS3MMEL8GRJXfn2gOrFC/L+rr7fU3HYVSrvjrtjnKf8pAUzB0Zwzc+INtlSzwclRQjm446sI0cXW7Et5lIKax0dvmfHpvh8+fdcp3QsCGbqGxMyMnKejgNeRJLMnNOzMJqkvzdJhfCwBoKCVlyE1NQfc2peRpBmT79qamfoevULt8/ufA/0i5dZAJCVGhcW5Q1ubHky0kQREWxlvsBi/uDMbOL10iHSP8XG1ec317pTSSU2FLiz8o9hTswzjMUou9Y2GwPT5Q3pM+NfedYU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHdFbjRDRlRqejUrb2FydHpFQWtTcTNxeWtWZ1puT1lvTFNVeTFtZG40cXRw?=
 =?utf-8?B?OVdkWlFtSEx3UE1vQy9mRzVoRXZtZGQ3Q25MRU1kbjBMdlpKaDZZMjVCM09m?=
 =?utf-8?B?alo0S1JtRkdXM1RVU1ZUck9kTzZubnBoR0xVd0E4MmVqZVJTSkh1ZS9PMkpm?=
 =?utf-8?B?b0RvS1lBVFEya3VmeG5BNlVuNjRRQlBma0MvUWtXOGpWVERwbUI4cldMZXBV?=
 =?utf-8?B?eDkrRkdWRDQ0VFAxWS9KVTNEMGlESnd2ditTcTlxL2FGUHhEQmJoaGxtYVVP?=
 =?utf-8?B?bStETkEyMUtiQjZDR3pFWWJSRzQwbEVXVk81bUlYeUZtVGhFdzdVK3oxS2g0?=
 =?utf-8?B?Z3UvY05jQWEzZ0hkNDFYc2o1dDU0VWhGSlZ3WS95UytCUEV0QmJDQXg1Vjds?=
 =?utf-8?B?ZXFlRkk4UXd3MHJEYkhBRGVJejRjN0lVcjB6NEd3MVh4M3hpSkE2S2NQWCtm?=
 =?utf-8?B?dGcyZWM4eUttamxGZ3YvaXJIeGluUFdkOWtDdENMVDJhazd5K05CQnpMNDFm?=
 =?utf-8?B?QjErNWZmQmtNMXBTVFpHMDk4bHgya25IVkZJMlRHdjFycVRMUUtxYzV5VWhK?=
 =?utf-8?B?b0VybkJ1VytNclJhdm9SdW02aTZ2Skd2elBCOGtNUmZGTmdzb1lZUEFZV0FM?=
 =?utf-8?B?ckgzM1BqTnFKMnZhUEFaUUlQQkU4ZHpFYTAwdHlURUg5UURucWlFc09EVTF2?=
 =?utf-8?B?V0JOQlNsWlNUb0daZWxTQWswdTJCTDNRVlNXWmtRVjhjTzZSTW1wa09UaTRT?=
 =?utf-8?B?N0JhNTB5RjJyY1B6STk3cHNnSlNudWt2VFpJek1HUG9nRmlub2tzRnUwd3RQ?=
 =?utf-8?B?ZEdMRU02blQzNEEvcWFMekpDaEpLdWUzYjFhYi9qQmFBSjdKRTB1RzJpcUJH?=
 =?utf-8?B?eHBhM2RUMUp4SWI1aWJ0cUM5NktvRXFEQjRUWTBDMit4aUY5aWozcktDNnBH?=
 =?utf-8?B?RzhOMVlIT1FNeWpaaXFCQmY0N0gwYWRJTW05K3FTVm5YWmkvQ3JKeDN3RGFH?=
 =?utf-8?B?QUNEalFlRHpYdU1rYURqOWxXajI0ODlRRVNVNnkrWFE5K2RqcVdQSDNwL1JH?=
 =?utf-8?B?RU9EcUhoRkE3NjZZV2hadlh6VXFHaDNXbXFaOGU0MXdUNkZkWDNMZHhFSkZ6?=
 =?utf-8?B?QXdTdWNEVHROVE1vMHhzcExhMG5sNitzQ2xLN1JwRktZaGlQalF5Y1ZreGNB?=
 =?utf-8?B?SGxwMUowQVdYY0h3YTdGN0pVUENxMktnYWpJQk5yMU9oVThGb1d5YnNUSUli?=
 =?utf-8?B?aGVuQkxwVXYxemd2TE1RTTdGQ0NYYk1QbWRuQkZaVHRxQXFzM29lbXlpNWsy?=
 =?utf-8?B?K3l2V2J4eFdXN3I3UlBGWFUxMDByMGhDbmZ5bG4zcncyV29FTm1na011V2ps?=
 =?utf-8?B?bGZLa0ZqS0ZyZ0x5RGZJUUhYNWpJKzUvMkhxeFc0c3RwVUpCdmE4bHdXb2Ro?=
 =?utf-8?B?Yzh6ZmUrLzhNVjhFTEFUVGpGendQa203MDY2WEI1V2NldjlPdGNtamQ3RUJr?=
 =?utf-8?B?b1h4eEVOTGZtVkJaYnBBaDlSVEdsZ3N4ajlTZlppSU8yZ2Q0T0Vqd0FQaEU1?=
 =?utf-8?B?Ky9hNTF5bW9DdmxOYWpoRmlCVkRPR0x4emI4UmsxRi8wZkczYXJWVFNiUzJN?=
 =?utf-8?B?RDVnZWxJMVZ6LzlJaCtIODJPUXV2WEEyMzVKU09NckZLUTNWZzBURGdZd2Z2?=
 =?utf-8?B?VnFkMUNhZVJwaTQ0ZkZSeG9JMzJwWGQ0czMyK2ROQ0hWRTQwL0UzQlJoblJi?=
 =?utf-8?B?cHVVUkZtYTlQenRNUlJUZVI0ZGVZcnZHMHhDcWVwUkZSL3VBWVBzUEswbXpI?=
 =?utf-8?B?Nnk0bWZHNWxLMVVZTi92VlcvQUFWYWh1d1BFaUtTL0dCNmFZQTJGM2U0VCtu?=
 =?utf-8?B?UmNmMEVXTmgwOVlvZkI4bG5VQ095dXY4cElnamtDSllKVVNidkhBT3NDSlZV?=
 =?utf-8?B?UHNkcTRTOTNISnJBVnBvVGpYMnR0QXNadm5Xb2FVanpFK0NFWEVQU3d3UTNV?=
 =?utf-8?B?T2x6N3FFdmRqRm9OeWhISks1OW1FaVhmc0p3RmdPSVNCVUw0WWpFaWJHRjFl?=
 =?utf-8?B?TDlFZFhZa2VGL2ZkSzRYUG5oVWZVa1RCK1Vma1AxaVZFMFF1ZXRBUnh3Y1Zu?=
 =?utf-8?B?VHl6WWFoN3VrV3RRZG51dlRyZWgvdC9xR3V0NldIVEYzM0VET2lSdTBIRXNN?=
 =?utf-8?B?SUdyZEdVZ0NtakVtcFN4TjJPTlZMSlcxOUk3ODQwcDgzdkpBY01nR3Z2NlFI?=
 =?utf-8?B?RmxHWllCdFl2V1dsVGJzUWdjenJIbVRUdi93T2pQcGRuc2JxRVVJTXZmMzk0?=
 =?utf-8?B?MUd0ekFwbk50S1BhR0s2MVB0bWp1SHVpOXFIb1VqVG8xK0FwZGNwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCBFA14D11552E4AB526AFD9AC05A38F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CmZKHUeEw44fDQIbNmyRJfgIwqagisosTP6TnnriW/zW7JCDq06x6BxXEarsNmSzNN8HWijJxRezIXjWDmGuyv/5JFrhVj2xUEcFi0XnBC0ulwHil1RMICW3N/NyXNSvn9VgrGt7ux5MwNWHqJFEtLK20/J1wYga+l4uNPsmiwGFgZcPC8yRfjWUyKCQORHtBGav+Sxkumi+SueOCXHd+B2l1Gt5slWZemHCmVjxin2/k/EuhzIYvV4IAenOv7shGktQzP8uf4t7ruIvJEqjAckBXPAa+ollUS7iwBkIgb9lyQs5sP6FMoaYEPR/eZp+OyARaVfBRY5vF4C6yyRLLg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da5a17a-a06b-4d02-591d-08decdd5796f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 07:36:28.2176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRWUPrAp3cUDYs2zELqeUgYcrExrjFu2FBHo87ds7JlgJ7r7abBsS36/Qpd9Oeo7wjemJKIc2n4hypaOpt99sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTE4IGF0IDEwOjQ1IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBXQVJOIG9uY2UgaWYgS1ZNJ3MgdHJhY2tpbmcgZm9yIHBlbmRpbmcgRU9JcyBmb3Ig
UmVhbC1UaW1lIENsb2NrIElSUXMgZ29lcw0KPiBvZmYgdGhlIHJhaWxzLCBhcyB0aGVyZSdzIG5v
IHJlYXNvbiB0byBidWcgdGhlIGhvc3Qgb3IgcmlzayBhIERvUyBkdWUgdG8NCj4gc3BhbW1pbmcg
ZG1lc2cgd2l0aCBlbmRsZXNzIFdBUk5zLiAgQWJzb2x1dGUgd29yc3QgY2FzZSBzY2VuYXJpbywg
Z3Vlc3QNCj4gdGltZSB3aWxsIGdvIGF3cnkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENo
cmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFu
ZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
