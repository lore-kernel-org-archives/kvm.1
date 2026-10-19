Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792427886;
	b=xGOC0om4jIvVt4sz1jAm5QhZXKxhPWwgekgNuQ2H7V5empilTUrXJ+s3cuO5hzbhCG3Q
	 IBwgVnAZIn72DIzDGYQD/DHf5XKzzsa9A3sKjgIY0UO8jaZfnk0HC//PllW7gFdu+9uL2
	 buB9o/0KIo71cOBeu1rsjYexxtPdSJFt+GG+9ZzSZfromky7Sgp26bbbiB1bHx2yYV7Pr
	 q4TsXjre3m/37AO3MQA2Dhp1CbCBttb659Zxz+ihkru/uHdhhoe3d6lasB6E2PJ1Ej5/3
	 YHLYlDJ1fL9XqZvcwiWmWEGirOe69FRSh8NGNG2dbZwfwqEzqNfMvQjA9s/KNOBJxsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427886;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=bXQTftAIxHpGXBystEqHMJHPXjOGoFcAfRSYpYXMNjc=;
	b=M5m3gZ3EBAqBCiBlV1qWAbP7GlAuP2BNJMTyxAeClXjD76Zijmtat1hHkJtidV0p9Ylj
	 4eiqm1FzwEBPgWBR/aJ12GxHLew5Lw+zZaQtUND1H3pRRtJBAkUEj6+uxbIQIM3udBDH2
	 M4lcUt0NZVc3p8VLBq2tuxMaQR64j0kLPbR7BemFdOkL8x75fk1yuJhOIcTUswFEBVO7+
	 6ogrrcZ+h97kF+GAqUa2HOvRx5nYyqXlKVREe1KP2ZAC0+cXzGFIniNX0alWRJIj7Gyj7
	 A372vTLpOiZsICyrXcXK423EV9yX9wYHazR+fKedPyR1e3L9oFOLxOoedTgiKUwnrGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E2kXHnnE;
	arc=fail smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BB8606A327;
	Mon, 19 Oct 2026 16:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2BB8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E2kXHnnE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792427886; x=1823963886;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uk9yMaz+KYEHAPaYXNXWbOwIPdKaPofw7dnuvzkBNGg=;
  b=E2kXHnnE4o8ZblMTlqwuL4RZQlGhtgZbVDzDUmj5bmnD3SPjYt/dVcM5
   DHSGYP0JbGXz25/r65NhJY5SCZQrXDMgUNqaCeLoPHxM5HkKxd6RmNzaB
   aDUJUBlishVLH8+OdTTa8qn24o/Kl9O0GdLXVWXYynxaSREFlqXAohZW1
   MYf7iYWgrFmJUbQzRiNWU9m+k9cU9X5nhVeqXIQPYkMBXyvAGV8wv2dZy
   Krt7e7Zm+xz14ocA99JyOBAReAmkCDR3vKsTlOdqzhhtq5QzM93OVCspe
   +h3C5Rph8Sn1Op8uPYdCCgqk/Fa7KfJdqdcdYtVbCjZ3PU78meB2vVb3n
   A==;
X-CSE-ConnectionGUID: Beo9rabIQfCaa3vDOHinNA==
X-CSE-MsgGUID: fyVjQywXSxGqP6gpIWAw4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1118678"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1118678"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:38:02 -0700
X-CSE-ConnectionGUID: 6G7iwiRASVaM3d0+zc+rBA==
X-CSE-MsgGUID: a9OTJPFORgyNmm4ywOSAVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2464197"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:38:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:38:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 09:38:00 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:38:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtzvmMzY/cIZFvWMI6TetiuXKcdmm9ssFSWnlGdatd8RL/WRXxZZNtS6IMNCtEisN3SjEoGg8Y9n0z23GcOdRsfvh+5CWYCrG/BIKtlrRNtvkwA6C6Bw45PNK76ekpYjQlDpoORZTcTry6q6VLva8arNUjBEDli64dZ/PVNO/h/yWcq/y9e2ZB4YXFAvSzGojWsNL7ALbXV6eJ7DHb6gDMTZQKdrpsLJNvbNnpa03BMl8alzU1vCC0QSv9LAdGFauWruL6uQ/YLoFoCCe8zeh/ciS5B8T17wriGidG+ufLAckA+AkLQQXr0C7NYh10WbHeNtaP9RRLIRZ6oGzUw91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXQTftAIxHpGXBystEqHMJHPXjOGoFcAfRSYpYXMNjc=;
 b=kECT7B4IGS4/Bs//zhGtM11LeGvS3hf2CsbIPV7mu+Mxj46R5ARnAH+4JDS+esN551jSYZg2TINrvATAY/2vmIuzNaZ5PryIr3NnCAvzR/ZErVIwFfrvuZmDRjWOfPSvXzidpvvtSou5CC0d30C0dXknuWhOSjT2zN0NHgqbyXLioxXwuhpLqaP1mE3BHzUhrhmVpY7ha3FvJgwN031wHwQuPa9P82oUuPX/iLLq4Hc9m6ht21RdyT2/BbJdYxvgm8ALY2yJCYURogy8H5EyvNbyjfSWQb4bRJSzPzNPW1OC/xsDjO9D55HxXP8w7wRbXD/Gttoy98tzBrrgo8M03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by PH3PPF801A91A7D.namprd11.prod.outlook.com (2603:10b6:518:1::d34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:37:51 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:37:50 +0000
Message-ID: <f7a56c83-b732-4959-9f31-6273d25963d1@intel.com>
Date: Mon, 19 Oct 2026 09:37:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/18] fs/resctrl: Deactivate kernel mode associations
 when a group is removed
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <e9a2b05b2322acf51e16571d07bc7ee297613b3c.1790867441.git.babu.moger@amd.com>
 <08e1de88-cab0-4caa-87f2-94db0f698ba7@intel.com>
 <cabf7da5-e5ba-4a49-9edf-f801f344ded6@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cabf7da5-e5ba-4a49-9edf-f801f344ded6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|PH3PPF801A91A7D:EE_
X-MS-Office365-Filtering-Correlation-Id: a3779c88-e6ef-4e26-039c-08df2dff50d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|7416014|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GmHjNMSDurw3jQQ/SvrGciCvRdcN8nfU8cgRWfp1n407IEzY4LL5/1F9c2T8AgFErvyywZOatMrgZE+1eGChFvuFLi7QLhenf56whS7Pp7YR+9mrG7j70LH1Lb0UfPXAPZuswy4b0s+QcsIIVeFWiZpMR/YOZE25ltXgry7zFORytDXyOvROkfLYYOxDmuDBUGZKX9HQKqaFjxs7uoNVCAGPQlP5o/tWD7ZohdlvJtDlTuORcXVWRp88gBBG5eflzEAdW4fYrgH8/tJiDKfo6icg9MA9OrPGPKRcS/Wss35Spt0cBOTwaPZlU4gVs2bTNKOhKTFRcko4mG+ff0Pixt73apaPjDy4an8GWpq9bLqn7yRIrL7WYwY7ble1e+C8KpgVnhu+pcggtl9f79AhFo0sGzW1bqOeF8MtHdxO1DRLN0DSjg+T6Dl+TYWvCOlLNnCs/VRBdJosEfRYabRYB3T66aZyhnP59MLMf0zrMrsc0LMF+HHLQluUrbBFhQYPNjEQYPDNEPO2H3KJUCG3hFSNstocW6fXUGPpNygES1ziTI32BOWzWYxgA66JXmEWSDhZL5ezmZYDUu/LjLstxUr5097S6/7fru/5D8qSV1cLL1raUgPYEKm2ktO8n6LK/Q5PzdCrfCkGuGQDpgRD4UWR2Ri5DxgpPzWMHoWyFN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(7416014)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkkvT2thWlBaUWx4VEZ1MXBlS0F3YTBMTHh3aTBLTnpDZWlmUFExelJoMkRN?=
 =?utf-8?B?MnhGaG1PZ2hKYWVtbGppUlNiNmcreG5vK1hJSDBGY01qMStMcFRueU9MVEd1?=
 =?utf-8?B?eGcxY3Myb3RuZ1JFTEM3L2xwZGlkYXlqOGp3emVjelFGdExYcllEelBQamht?=
 =?utf-8?B?VnRGN3hpMGMyVWYwaEozUkRKc0NBcWdMdmlqblJxN08ySXpvTi9Jd1lKc21N?=
 =?utf-8?B?dTdtZlFCL0FENXBUKy80MHJHenBqS25zTGFHS3FiWTE1SVQvZWVBamw1b1B1?=
 =?utf-8?B?VmJkbHMrb3dmTGhGQU0yeGNsYlV1Q3VDbStRSlFkVEpUMU9wN3lsNUZWcGYy?=
 =?utf-8?B?L0h5bTRlZmp5T1dhL3BJaWlFTWN4MW8raWwwZVcrRmF5TitiWDhRdjRqVzhW?=
 =?utf-8?B?Zi8wSjRhOEZHVnJqQUcyY1RMQVI5b29lNGZCdUdNS3EyRmYvN3B4V2lGNEF1?=
 =?utf-8?B?TXBOd0xZN29SdG9DSHZsWEY4YnZwelB6akVJYVRyOHlhZmhtcld0dUVzOXVM?=
 =?utf-8?B?Tll1Nk1mVW9vMmtKUXlhK3lqZjFyVnQrWWxuVDg2c3hYVWQvQ20yUitieEtD?=
 =?utf-8?B?LytoUHBtVVo5aTZjdFdUb1JyaE03U3pLMXNldFFOdUlCeTNvY3ZyTi8rcmVj?=
 =?utf-8?B?bURzM2UyUDhYR2VYM1dLOStVRzAxaDFvNFhiRVhqM1dDYXVOSlFMZEdPR3lL?=
 =?utf-8?B?TndmdDU5bHpTM09oNy9TYnU4dTl4QTJhcUlhUTRCcGlXMTEveU5hbVZPN1N2?=
 =?utf-8?B?aE91K3Fad3pPZ0pHVXFVbzgyZWlsMDVsbUNyQWpNNFNYWGo4UjR3UVVDaVpo?=
 =?utf-8?B?N2dOOEdmbmRVM295ZDRrcEpwSHdTYzBVWmxHdzYxT2xBVktvNVdWdDk4UGY0?=
 =?utf-8?B?alV6M05mT0lTdkd5ZkZzRnpBVElnTEMwb3hXaERHcUR4YldSTTNlbm53cWRi?=
 =?utf-8?B?akU5a0hNT0M0SUVlTlQ5WUJkUWZkOGRjcjQ0YVhYcVdRSFVJVFovL2tnb2hW?=
 =?utf-8?B?M29KVkJ3dGx1M3ZzM1pqZ2NnT1J6UGs3cU93UU90bUpFTkNXcW5oYjNMUnJl?=
 =?utf-8?B?T0tHT3hyZVVqYXRYKzREdE5oNlN3SzBUVFFBemwxMUxMK0RiV2tYZERXdmtB?=
 =?utf-8?B?azhSTERDcDBoNUFyc1BXQytRTkRaT3RxcGpBU0JjcUNNODdlWTRNanJNQ1ZS?=
 =?utf-8?B?bTcwWUlGNFZGMHJ1MkE0azk4Z0pTYkVMd3NINnpTcHY1UUtJQkJ6TXM5MjZH?=
 =?utf-8?B?THNUbW04MnFiZmJsTkEwcHVSTVU4djdIbmt5TGZMeE55NVpDNmNOeVRWVUtu?=
 =?utf-8?B?NHdmSlRaMS9xNWg4a1JsTzBxc1QvSnZrNE9iRURYWmlTS0o0MnRvbkJtOXo5?=
 =?utf-8?B?STN0OG03SlppTlBpcDRCSkc1M2o0USs0UHEzaGNDeXU1djJjc0kwQ3U3QWFo?=
 =?utf-8?B?VTZSS0ZlSE9SZzhOeDd4RGdwc3lVREoyMXk2anNaOTQrWTd5YnhOVFk5Mjlr?=
 =?utf-8?B?WGhqWG5lcjNMRGZFOXlQNzNZeXM3M1AwRXZEdlU2bmhiMzBWeDZ2RnlBRm1U?=
 =?utf-8?B?MnVhdkhudUZzYXcycTVVWEFVbU9CN0RXZlpGMUVPZDlMOWc4UzlIMHNwQld5?=
 =?utf-8?B?R3c5ZTJXQWVHVUJMWk8wL3dMVFdYQ1BvekM3VEtOeVA4S0xJa1prUGd6T0dQ?=
 =?utf-8?B?dEZibUNITGVhQzI3RHB0YmtKYmxsQklTU0RJYmZtQ2d4cDhqZWo1YWdDWkxo?=
 =?utf-8?B?cmNLVDRKRzdZempod2ZsMFZQc214Z1lsUHQ5cER3VWZGVE5KWEQ5cFlRdXFu?=
 =?utf-8?B?aHU3YW9TeWMyeVRyZGdkNG56elUzKzJUVzBIUEdodkFuM25aSTZhYkNseUcz?=
 =?utf-8?B?TTZ3dnB4aDVESXNoQmRQTFJuNTRwT2N6OXFKSlg5bVlPUXNtWG1aMTF5NjJp?=
 =?utf-8?B?RjQxVnE5S0MvNEFieU55dFJwd2prWkphUFZQMno5VmVtalVqS2xhNEcvakl3?=
 =?utf-8?B?SXV1UWdDZmlYL3QrVzJCWWNYN3RuVXZuL2NSRkZZWGhrTm9ubWQ3eXlJb3ZZ?=
 =?utf-8?B?bXlRTkJqWEtKQjA3QlNrUnl1dnptMVM1S0tQNFc0aEJVUWIvdnBmdWJxR3FQ?=
 =?utf-8?B?L2JVZVVrK2QrQWpmNjBFejJuSHdLcVBmbVNKRE9naThrOEpFazRiMjZWcU02?=
 =?utf-8?B?dHcyUE1wSWtsQkNPWTAySXlwNVBEdTA1ZDVodnoxbksvbU51RDNpQk03SG1r?=
 =?utf-8?B?UFUvZ2l5S0xVaTlaaVh2V2U4c2F2MjdsMStXM3hQQlZySXlOQXROQWNkQTN4?=
 =?utf-8?B?VStkczN4anZOTVR6VFJCcUpURXhVTWNkQnk4K3ZhSkNySElsYTR0ZmVYZ0hF?=
 =?utf-8?Q?v5+40uVPnafPKHXc=3D?=
X-Exchange-RoutingPolicyChecked: sz7LPN411kmsq3jHTMLf1x3sPyaWB+FpXdA4p3KnBhXbia8r1EnPRzkuhlD6JmzjnV2kKS6GMHGoHQbVjGmnla74ypW/2kNNsxlucPmrLCwgHZkGtdG3mdwPm30ri3Jy1Ki65BGzfj2s3xosnRAaLuw2cAP3+ItUyDzTTQSe2ZFr2zP+9ToIBjIdcSWYs+ClmaJCItvVYB8r6yZjsvZ1RdapCrDuC0mJgA5nmqg7oNY6kFUAOOqjoTfvcyTWasD8EN7cHi0zUk0iyWBUvGFsGeXmyhvY9l6vvMqBFgnzbHoerBsC7AAVkzg51Qtu+gcIj4ZsHJuF05nUV54u0E8u8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a3779c88-e6ef-4e26-039c-08df2dff50d4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:37:50.7597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TtKAQDoaWIIM+VvTKQlhVBAZHi/uWtjzAjZzQX21zjNiWWiupX0CBcFM+EltydMAtYHVBeM9Ip0NBZuv+ZyHCmxK6NEbvS/t4VGf7QX/a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF801A91A7D
X-OriginatorOrg: intel.com

Hi Babu,

On 10/19/26 8:47 AM, Babu Moger wrote:
> On 10/15/26 10:43, Reinette Chatre wrote:
>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>> The active kernel mode association is backed by either a CTRL_MON or
>>> MON group.
>>
>> This context does not reflect the code at this point in series but what
>> behavior will be after entire series is applied. It is also written as
>> general but specific to the global per-CPU kernel mode.
>>
>>> When the backing group is removed, or when resctrl is unmounted, clear
>>> the programmed association and restore the default settings.
>>
>> Please provide more context to user and help reader to understand what the
>> patch does without needing to decipher the patch.
> 
> "The global per-CPU kernel mode, RESCTRL_GLOBAL_ENABLE_PER_CPU, allows kernel work to use allocation and monitoring associations that differ from those of the originating user task. When the mode is active, "info/kernel_mode" displays the backing mode. If the backing group is removed, or resctrl is unmounted, the association becomes invalid.
> 
> Clear the programmed association and revert the kernel mode to the default "inherit user" behavior. This ensures that kernel work continues to use the allocation and monitoring associations of the originating user task until a new kernel mode association is configured.
> 
> Document this user-visible behavior in resctrl.rst."
> 
>>
>> For example, "restore the default settings" is a very vague way to
>> describe that removing the group backing the global per-CPU kernel mode
>> automatically switches the kernel mode to "inherit user". Please explain
>> at high level what the code does and why. As a hypothetical, why not
>> keep the kernel mode as "global per-CPU kernel mode" but switch the assigned
>> group to the default group? This would match most other similar resctrl behaviors,
>> no?
> 
> My assuption, you are not asking me to change it to "global per-CPU kernel mode" when the group is removed.

Not specifically, but since the behavior is different from the typical resctrl behavior that,
for example moves a removed group's tasks etc. to the default group, it would be valuable to
know *why* this behavior was chosen.

...

>>> + */
>>> +static void rdtgroup_kmode_global_deactivate(struct rdtgroup *rdtgrp)
>>> +{
>>> +    resctrl_configure_kmode_global(&rdtgrp->kmode_cpu_mask, rdtgrp, false);
>>> +    cpumask_clear(&rdtgrp->kmode_cpu_mask);
>>> +}
>>> +
>>> +/*
>>> + * rdtgroup_kmode_global_detach() - Detach @rdtgrp from the global per-CPU mode
>>> + * @rdtgrp: Resctrl group being removed or torn down.
>>> + *
>>> + * If @rdtgrp backs the active association, disable it, clear kernel mode
>>> + * state, and restore RESCTRL_INHERIT_USER.
>>> + */
>>> +static void rdtgroup_kmode_global_detach(struct rdtgroup *rdtgrp)
>>> +{
>>> +    if (resctrl_kmode.rdtgrp != rdtgrp)
>>
>> Please do not use tests on resctrl_kmode.rdtgrp as synonym for
>> resctrl_kmode.active == RESCTRL_GLOBAL_ENABLE_PER_CPU.
> 
> Not really. This was a check to make sure kernel mode is pointing to correct group that is being removed.

The problem is this "global per-CPU kernel mode" specific function is called without ever
checking if "global per-CPU kernel mode" is active. Instead it uses one of the parameter
values as synonym for whether the "global per-CPU kernel mode" is active. What is a future
developer to understand from this? This implies there are two *interchangeable* ways to determine
whether "global per-CPU kernel mode" is active ... sometimes
resctrl_kmode.active == RESCTRL_GLOBAL_ENABLE_PER_CPU is/should be used and sometimes the value
of resctrl_kmode.rdtgrp is/should be used. How should somebody interpret this? Are these
two interchangeable tests (and thus making one redundant) or is the test dependent on the scenario
(which is not explained anywhere).

Reinette
