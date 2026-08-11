Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52B364931
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448614; cv=fail; b=JlIRqsH9xkx0YxEjqluMbQsHZWuWC5eHgDllOI7u+9G5JNcDrYzeYWFlaj1MnHUWtuth4ngv+p9uKHKVF0meFT3cG8NS5/0otz0vj4/WKpv+sYfWFoqV140DR7gM570Tg74OZNqp6JU2yOEbuhRxqz/Z6eQWen+sCRLz0v/7SwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448614; c=relaxed/simple;
	bh=NQ5MIu4kHppt+URDKnXzNVqrh7/nM2GoiNzzOQFqP0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GIo+MZxfh3cdlbfnp9vMIgCHCw/VXClumC6azb024YVrW7uf/MDA84fjAiEJC+E0Nci0QII4JgOzjRFDJyEaJPTqCk2UcS7BGCulr7PzW8mTZi5UIo64BrjMyVGmYdeFxxs+yyFToPea2+vSHtONs6CwiWLBNs4CcZYyW6DZ+no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOHnIIs7; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOHnIIs7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786448613; x=1817984613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NQ5MIu4kHppt+URDKnXzNVqrh7/nM2GoiNzzOQFqP0g=;
  b=BOHnIIs7qI2Bp1Nvs0vmCrHjlL+UIcNSeymN0/GdZU9BffuU+mt+eGUX
   N+KKy4NhMwQ4bMNEm4f6piLURbgDiagMk2//i+ipTVZb72wMe4wAZWHEy
   8EZGMh6KkXuObEtD5KWnDWfb0p4St20dkWVZL/1k5W9IfrUWdzJ1I9ITd
   /mnXrA57zbMBByZUgheRGaqDkK8lCc+bMhpPdgDAzEo0Pn3Wu8lIn7ewQ
   ij97BT64xYsMLdePH95wxjYo7V4Y0twL47T/5Y6tjWHERwJnEM9Yym1Gu
   mm/hJGY7NQ4hppDhb2T1XkeE+mZt5Q0p+xkOgy6qxhwUaStsZrBC4U8eC
   A==;
X-CSE-ConnectionGUID: 206xtZmXQqiWvYrH29l85Q==
X-CSE-MsgGUID: AyVAvia2S82f8BB0T0DMaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="74510058"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="74510058"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 04:43:32 -0700
X-CSE-ConnectionGUID: 1wXiOhCRR9SAQ7SL2j7W2A==
X-CSE-MsgGUID: ZL7BmTejRVy6R4WZxARCkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="267597115"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 04:43:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 04:43:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 04:43:31 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 04:43:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGkJXRGay/GPRHfTulv4uvarswOpOc2uGLSYt7cQV7ntZvF831i6Baig3TdcBcqLllHnrHRpMgDf3sR5VxnKn9rrV/6Iv08Z+TzXPM2lEQLa+4CmKOoH/7t3pLsnOisaSgid7ZExE8jUMJwE1eyKyzXGt3sxXqU7d+KoeP4uyU5lAUmq13gFC+U7c13d4lD6P/6DJUTi+TMEKzdYkW+GJM8/ptLHy7F9KeDUh5+FZgfcJe/ulO7dyjhwvANNNK3AFJqdoCu8Np0YVK+atU6/iJc1spLCvpABu4XG/VOELVcxjISX/QcJOEBETcGsKnW5UqVQTP5h75vbwtj5fJXhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ5MIu4kHppt+URDKnXzNVqrh7/nM2GoiNzzOQFqP0g=;
 b=qnjjECzSc8qPhFNIsAa/x+JDHZUsQSeAk7K0XPuQ0tuPaIyZvWlPSJYQkqo8FV0s5qvCtJaF4jbErA6U1fqqPSmXdQrrKGSfCnx4wOusm4vo94G2PwZbHFt5rlH7iNqg+CzdXZVkbNaHmTUxxrPsOmOvaCrGlapzoN7hBcv8SBKaNEYpHBinLqZNhsJbZorRqWDKTgd4/4LjbR3CTnld5mRH/D2HIyEZ8a454U9VK71BPwBc89cw/ZAWPLbaciVCUMczWPEIuMRqiL1i94ONjqTpBPLC4/klhCPl2eTcnOXO9QUvjSaN9TGKgEM2LHKb68Aufn0p7yEmS7mo+nXwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18)
 by SAWPR11MB9710.namprd11.prod.outlook.com (2603:10b6:806:4c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 11:43:28 +0000
Received: from CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c]) by CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 11:43:28 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "hao_zhang_kdev@163.com"
	<hao_zhang_kdev@163.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH v4 4/4] KVM: x86: ioapic: Clear irr_delivered on
 level-triggered RTE
Thread-Topic: [PATCH v4 4/4] KVM: x86: ioapic: Clear irr_delivered on
 level-triggered RTE
Thread-Index: AQHdKWUmSEVFnnW/702aYN/1fgMqyLaYunEA
Date: Tue, 11 Aug 2026 11:43:28 +0000
Message-ID: <ff25747d2827c847b0b1153177de6c6c004df8fb.camel@intel.com>
References: <anrSjerPIvO4Ww-T@192.168.1.215>
In-Reply-To: <anrSjerPIvO4Ww-T@192.168.1.215>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5300:EE_|SAWPR11MB9710:EE_
x-ms-office365-filtering-correlation-id: c221854b-2550-49ad-f983-08def79dc2a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|38070700021|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: c2qjzg7XYnLv/CvC3k3MWYekC+ysSAhlb9FFx7AbDFc/tIbUOTAfOVNKqqhqjr9aH/QKtIjHFVs1LAHmfF3F8PvenZbBOlNJLEpeVauhIFEUVgwoqoPdufG3Ta3TxgvhRNJb3qmbPl2cvaHTNODlBDBU7nKNqWJNqSjvCVgmQ1n10pJh/im3QfN6TcEwohv2ReDmMMarEGdmFLZtgak3/G1+BHoEGnY/caxmZEIKKjstFJd0V8kJ2q1OEcBjLb5v9h77C2cGeF3FujrZLQXo6tnxcM6fF5Wc1xXMXmXYwZtxeTk2upzQ+DsFLXhqjus30gPPHojjKNE7b2915stEbvWsVGDWc29kyJAHh7wZLK47h471S5M/Kwr5SFXiNt2CiduW377Eo4E+3SQV7dbTPD0PXCCuj5QcmoDDdFi0dN0dAxOHTDgs87agZDL8aLpGiNIzbncZuiaKdPm+NmNiZWdwMWVMLtgVqmWAi5JYld77uNvKnwOdxPgFR1K2aUrC+fdKrDUQYyx5vMt42A8BsTg0RkQSRRADtUABervaEW9jFEaB6fV7BIUjLi6lGFDro7LRZx4m3MF+FnSKA0cmK1zbgnDxRdWBbKhQu5T3RWsCG143R2L7+hANsr5d99ZqJNsSvGn4Et2uzxh2oRFy/8Ve2XaSqLZRUjOyzewm/Q24bj/5uUNs/35TmdaL0QwxSlCpNue4A3po+mBtMaLGYxdDhoRqyD8LaLFjjtH9ypo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(38070700021)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1Y5TVB3OEdlUnhTbUpGR09VVXIrWWxadC9DTWN1VTNwclJjZlJWLzlWdlJM?=
 =?utf-8?B?KzlVTVF3WVorTndxS1JqZEpMRXEwbi9qenJiRHlPeVFFbUxPOFI1NUFrMTVa?=
 =?utf-8?B?RGNMZmxqZ0tmaE5ZZzB1U0N3bmdkRklJb0M0Q0FaTjFZYkg5SkgramhOOUxK?=
 =?utf-8?B?Lzh4MzVZZWZ5Zkg3dXJaUFVjUWwwaWMwZExWNWx4TDVYY3lyQWRPL2FuTXVi?=
 =?utf-8?B?V3krdndqZU1lVGpHRU5wQkttbTNPdG5NbUNVVmhFR3c5OXZyU29sTGxTcThL?=
 =?utf-8?B?REtTV0pOdjFtRGlGSm91cXN0anZ0RC93c1dPckw0SkVkUTlhTkt6YlNWekFx?=
 =?utf-8?B?dGtUYklxS2cvVWdjeklzcFExbUI0empYUFFsNDI4aGpUSDlOSmVSb1hOMXJ0?=
 =?utf-8?B?ZUhnd0hGQXBxSWVPQjU1eHY3bFF5ODQ4ZFVZOGhvRVB1TWdodVRzTWpEbzhn?=
 =?utf-8?B?SzBkeGI4UkI2YzNEa2tZdHVmd2NRd08wWkdCc3RqYVg2cXBqeDVKL1VjQTFh?=
 =?utf-8?B?bkQwUUhxanRMZ2JmUzhLandndjQzTWhZMEVjVTJUMXhNbWxCSndtSWpsNXVp?=
 =?utf-8?B?SVMvNVB6bWlQSTlET1RDaFBTekFNTTJNSlVRamRVanlvZk9KV3hDWE9Rbi9C?=
 =?utf-8?B?RnVjaGYzVDc1ellvOXprK0FJU1V2Q0FxdjlTMmMrcHBYNXBoVHppNEduK252?=
 =?utf-8?B?dURaakh2QUhBVXRaamVNRDJScmREbjRqWHJiVkdyeldDRlBFOC9LQTZvNVl0?=
 =?utf-8?B?RFFRUFJKR0ZwU2VQbm9BaHYya0NURHArNHZyYlEyVUU2TFFqdk5OYW9YdFZw?=
 =?utf-8?B?cXdzTEZ0WUR1TUJVQThKV2ZWM21oOTlWdWhWZVozSFk5Yjg2UEF4TXlFbDUx?=
 =?utf-8?B?UlJOZG5NVUJlUnM1SjFNMTcyaFBoUDNSMlhKNGljRWxqNS95WFc5T1BxQjFS?=
 =?utf-8?B?ZmdFUEIvZFc4VFJzdVhUUm16ZUlnUXBDeFQzSlVQVVkrZ2xMRnNVZ1JUd1Nm?=
 =?utf-8?B?cFl1SjBRNmRSMVY1T1c1Vjc4TXFuM1RyVC9aeWVqL0R5clFXeXlyd0F6Rllk?=
 =?utf-8?B?UnhzZzE2a3ByWXhBc3pCY2xER0UyUWt4QWFiRWEzWTBlZlpSa1FaZjgzdHpK?=
 =?utf-8?B?d0xEaVd0dnVCTVZjWTJMMS9kUGhBZ3R3Q1VVUllkeWwwU3BSU2d6ZUw2dEk3?=
 =?utf-8?B?a2tVQThSM1ZTNjdmRGhMN1BqUDhwcmVqcmFYUHJWWjc0OCtTMjJEdFpKcnZ0?=
 =?utf-8?B?MFhnZXNUblRTZENUVDZTOTVpSTNnMnNNRHZPaEd0WE9pSS9SLzRDdVIzcEta?=
 =?utf-8?B?ZUlraCtubGg4SDM0RUpnOURaL3FlZERPcERFejJONUowd1NzRmFiU1h0L2p5?=
 =?utf-8?B?QnlWaDUwV1NSQUdFa2xGQmsyQ2xidVhLYmtUczV5aGY0Q2IrV0V4YXZsZnVt?=
 =?utf-8?B?N3k4UmNsakphcFFrSkIxNG5EL1FudkJUd1ZFRjE4WEJ4SVI3aVhCaXBVcUR4?=
 =?utf-8?B?OUxSejVJR1dFK2VQc3pncU9NK3VNUlNQSEhNQ3VaQys2d1AwTllMS0U0N1h3?=
 =?utf-8?B?bjF5L0dSdXNDVXpoc1FkVW5RNTA2SDQ1MStyem9uTmJTVUh6a1JiUVpzZ2tO?=
 =?utf-8?B?UlNFSHd1OFQwM2U4U1cwbjk3RTRnNzYxWEtpM3RURU84T083OHppb2xyV0Zt?=
 =?utf-8?B?S2Zub0xwT2YyUTJjWXk3bkU1d2g1VXFVS1hKbHFWRUhaL1ExYm5IUkpObWh0?=
 =?utf-8?B?RUdtOHNrdm1UKzFzVkVpTUt1L2paMm9pTExsYjROb1RBWHNRTEZlSDlpZkhW?=
 =?utf-8?B?THNHQjdYL1ZjUHVNOEhFaWRwMjdpajdNYk5zYUQ5eUUwZlFEZ3ZnL2NXVmd0?=
 =?utf-8?B?MUtkUnE5OFk0dU5PZFBwc2tvb0hFRU9TNXNuTVR6Y2xramxhOTJVL2xmRGF6?=
 =?utf-8?B?djJOTWViWXJqS292Nm1CaEh6YlB0YnY5cERtdGV5V2NLSEpqcHg0d043VmNW?=
 =?utf-8?B?eW1VNE9reUtWak4vb0FRZ29JRG1UMDBJSHNLUS9jVStwYjNVL3JyZ2k2VnFR?=
 =?utf-8?B?QVl6NEswSjJac21VL0RPOHBjYXpBTGxieVh3L1BMZDVGeE5aZUx3aEJkQWV5?=
 =?utf-8?B?Y0d6UnVZNzYzK0paOVBrV1UrVlhUKy9rTlNUSERPejF0YlBsNk40RmtCMHFm?=
 =?utf-8?B?M2NiUmVKOGdpUzJSSWNBM2FMOUl4NktjTUE3Mm9QdGlWZWNHOWFUYTBWVHMw?=
 =?utf-8?B?ekZHT1hLNldML0JBd0UyWFBaZGVVQjV1Wmk5MXpUTm5zY3RXN040SFRBSnl6?=
 =?utf-8?B?dEZiSG55QUl5cmtUSlZtcFVQTU9OVjJYOFAvL21HdWk1bmRIdkZhZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E6348B3C05C1146A77F4BD42B2A4823@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b/HqjQhlCGvrFlS8twZYmAl/NCghznK0lrGX+KC7Appgj3N7H3JdLIk9wKj31wDfTSvPnhEd+kCMcmyEV0MR7uKD/4WAcRt54aND6edGH6LVfn2lHGS0stsHRLVmpt+bpEoerP0JCxy2Q/wb90UdTz6zypqe1zO02aIHxQ85Ueh32B+1Rx5/oNAj6iuKVIV96PD5LI6d0oDS5DAPZ0Xi185ZMDmwrhHZuhfUdbL70uMif1nrzSVhG0wS1JeIayHER6eKNOShyVOvjSfvzRbV20j6aTweEHUbxcGpBXbGzayRo2FMDHkud8PaX7cwVCgC2ceTQxmcNRhb4oRAumBpgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c221854b-2550-49ad-f983-08def79dc2a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 11:43:28.0474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zgZujB9zLQtzpcs+V9b9azsi4hZ4Rn34gekSOd8f4zKEu8j+pui5AbyJhXsrBfih3UV+D9Oh+9RQ5MHeuSWKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9710
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTExIGF0IDE1OjQzICswODAwLCBIYW8gWmhhbmcgd3JvdGU6DQo+IEZy
b206IEhhbyBaaGFuZyA8emhhbmdoYW8xQGt5bGlub3MuY24+DQo+IA0KPiBpcnJfZGVsaXZlcmVk
IGhpZGVzIGRlbGl2ZXJlZCBlZGdlIGludGVycnVwdHMgZnJvbSBLVk1fR0VUX0lSUUNISVAuDQo+
IFRoZSBpbnRlcnJ1cHQgcmVtYWlucyBpbiBJUlIgdW50aWwgdGhlIGd1ZXN0IGRlYXNzZXJ0cyB0
aGUgbGluZS4NCj4gDQo+IFRoZSBndWVzdCBjYW4gcmVwcm9ncmFtIGFuIElPQVBJQyBSVEUgZnJv
bSBlZGdlIHRvIGxldmVsIHZpYSBNTUlPLg0KPiBJZiBhbiBlZGdlIGludGVycnVwdCB3YXMgZGVs
aXZlcmVkIGJlZm9yZSB0aGUgdHJpZ2dlciBtb2RlIGNoYW5nZSwgYQ0KPiBzdGFsZSBpcnJfZGVs
aXZlcmVkIGJpdCBjYW4gaW5jb3JyZWN0bHkgbWFzayBhIHN1YnNlcXVlbnQgcGVuZGluZyBsZXZl
bA0KPiBpbnRlcnJ1cHQgZnJvbSBLVk1fR0VUX0lSUUNISVAuDQo+IA0KPiBUaGF0IGNhbiBjYXVz
ZSB1c2Vyc3BhY2UgdG8gbWlncmF0ZSB0aGUgVk0gd2l0aG91dCBhIHBlbmRpbmcgbGV2ZWwNCj4g
aW50ZXJydXB0IHRoYXQgaXMgc3RpbGwgcHJlc2VudCBpbiBLVk0ncyBpbi1rZXJuZWwgSU9BUElD
Lg0KPiANCg0KWy4uLl0NCg0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0vaW9hcGljLmMNCj4gKysrIGIv
YXJjaC94ODYva3ZtL2lvYXBpYy5jDQo+IEBAIC0zNzcsOCArMzc3LDE3IEBAIHN0YXRpYyB2b2lk
IGlvYXBpY193cml0ZV9pbmRpcmVjdChzdHJ1Y3Qga3ZtX2lvYXBpYyAqaW9hcGljLCB1MzIgdmFs
KQ0KPiAgCQkgKiBhcyBlZGdlLXRyaWdnZXJlZC4gVGhpcyBiZWhhdmlvciBpcyB1c2VkIHRvIHNp
bXVsYXRlIGFuDQo+ICAJCSAqIGV4cGxpY2l0IEVPSSBvbiBJT0FQSUNzIHRoYXQgZG9uJ3QgaGF2
ZSB0aGUgRU9JIHJlZ2lzdGVyLg0KPiAgCQkgKi8NCj4gLQkJaWYgKGUtPmZpZWxkcy50cmlnX21v
ZGUgPT0gSU9BUElDX0VER0VfVFJJRykNCj4gKwkJaWYgKGUtPmZpZWxkcy50cmlnX21vZGUgPT0g
SU9BUElDX0VER0VfVFJJRykgew0KPiAgCQkJZS0+ZmllbGRzLnJlbW90ZV9pcnIgPSAwOw0KPiAr
CQl9IGVsc2Ugew0KPiArCQkJLyoNCj4gKwkJCSAqIGlycl9kZWxpdmVyZWQgdHJhY2tzIGVkZ2Ut
dHJpZ2dlcmVkIGludGVycnVwdHMgdGhhdA0KPiArCQkJICogaGF2ZSBhbHJlYWR5IGJlZW4gZGVs
aXZlcmVkLiAgQ2xlYXIgc3RhbGUgZWRnZS10cmlnZ2VyZWQNCj4gKwkJCSAqIGRlbGl2ZXJ5IHN0
YXRlIHdoZW4gdGhlIGVudHJ5IGlzIGNvbmZpZ3VyZWQgZm9yDQo+ICsJCQkgKiBsZXZlbC10cmln
Z2VyZWQgaW50ZXJydXB0cy4NCj4gKwkJCSAqLw0KPiArCQkJaW9hcGljLT5pcnJfZGVsaXZlcmVk
ICY9IH4oMSA8PCBpbmRleCk7DQo+ICsJCX0NCg0KVG8gYmUgaG9uZXN0IEkgYW0gbm90IHN1cmUg
d2hldGhlciB3ZSBzaG91bGQgY29uc2lkZXIgdGhpcyBjYXNlLCBidXQgSUlVQyB0aGlzDQpjb2Rl
IGNoYW5nZSBkb2Vzbid0IHNlZW0gdG8gaGF2ZSBhbnkgaGFybSwgc28gd2lsbCBsZWF2ZSB0byBv
dGhlcnMuDQoNCj4gIA0KPiAgCQltYXNrX2FmdGVyID0gZS0+ZmllbGRzLm1hc2s7DQo+ICAJCWlm
IChtYXNrX2JlZm9yZSAhPSBtYXNrX2FmdGVyKQ0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMva3ZtL3g4Ni9pb2FwaWNfc3RhdGVfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMva3ZtL3g4Ni9pb2FwaWNfc3RhdGVfdGVzdC5jDQo+IGluZGV4IGRhMDI3NmExNTQy
Zi4uZjAyNGY0ZjAxNTcxIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9r
dm0veDg2L2lvYXBpY19zdGF0ZV90ZXN0LmMNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMva3ZtL3g4Ni9pb2FwaWNfc3RhdGVfdGVzdC5jDQoNCkFnYWluLCBJIHRoaW5rIHlvdSBzaG91
bGQgc3BsaXQgc2VsZnRlc3QgY29kZSBjaGFuZ2UgYXMgYSBzZXBhcmF0ZSBwYXRjaC4NCg0KQW5k
IGl0J3MgYmV0dGVyIHRvIGhhdmUgYSBjb3ZlciBsZXR0ZXIgZm9yIHN1Y2ggc2VyaWVzIHdpdGgg
bXVsdGlwbGUgcGF0Y2hlcy4NCg==
