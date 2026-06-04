Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34847A0D1;
	Thu,  4 Jun 2026 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576802; cv=fail; b=rPXBZvmm4uMT0OiTI5+P1awsu5KC1FEPuM3NGS7E6CRJdOtIsoliWE7wyG8TYKRhoZpzd51bv6v/35huDm+8ydE4kAr7Etw749SVYg/uSDOiRSDF6igKaGLkJwui98GGtXsJfAU7YfPfD9T0i+TzI0o4d3uR7YuJgNnH37+J69w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576802; c=relaxed/simple;
	bh=09oFYwZCdWn6/rgwptW/4ImEJjuGMu3BcvJzi51oQMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o+GqEQdKHWF07LZuaq1T9OPpysw2bWB38on9ElQveqdyTatjD71kGJP8mg2c0Wu3Kwn7ly9oBe3XZ8BMJ0TcTyi3Tr5el+dgvw5p7arLh7xXuIskpw7Q01WPduDhF4RBFiJVz2rqdab3Bai+91hqwEm3QQ3W/cIqSxSDbTOZW7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bc6dL5H9; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bc6dL5H9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780576796; x=1812112796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=09oFYwZCdWn6/rgwptW/4ImEJjuGMu3BcvJzi51oQMY=;
  b=Bc6dL5H9/GNuskFmL0vUfaG7iJaszbt38DRcspQTt+CkapZoezR8b4tO
   56hF43PXmhQsyHNCq/9YUmhhHyhS8etQKWM8lnuOlbO4ioCQNL7K7YXIf
   kqJM3drVr0NTDZeDa+EVmnyQAUbz24AVdw61Zjm2W0IFimn0n5w1sF//t
   2mjgwljieWwKoEFhDzcV6+UFGtd80JAQzQabgcZd67V6v308IMNyHKk2r
   bL56zNIeylyMRxUodze4D413Ch0txudMlqzFXZb1znMuktYHZ6pWXmnc2
   yy8gZlMtqiH4DLrx5kN/rI67zYQNdkiT217wEIMo8BneSATA1QkOjYnF7
   Q==;
X-CSE-ConnectionGUID: w5rAK7MQSnm5LUpPdgPj2Q==
X-CSE-MsgGUID: 1tQpHBD6QPWel/oKIEZzig==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="85290257"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="85290257"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 05:39:55 -0700
X-CSE-ConnectionGUID: EX4X0nCcSt+ZzAuPpx8Axw==
X-CSE-MsgGUID: 98vThjjPQg+SCZH8VY/M1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="242042414"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 05:39:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 05:39:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 05:39:54 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 05:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3m7nJoy7l8Fe4D4jpbw/rHF6qhduLpoDVj12yjq6tbAvpbUMARNFwVmfEUjTmlptAZEc0JMNarz5NzrY7mA1xJSIBIAxGu7ywAZKRuqMDHad/IqeQH2NgJzrdij48IgKr6L6xxrZsSQJy65rTn5C14fjLDQxS2beBKTFPv3dNioz3B0Fd86Io1eBlycWEhK7pHGGQWWjCqdhWv2YQ5yJo3PWS29iJ2ndp1WPLRg6Fm8+GjxcW54NHV01BIikxgrX05nhNK64Tqtdmgt2CLQTffzYtgUvaSJ816uYMxANgmxzKnN8uNZ2toxllr2pwCqELRlxOJOnpJphl8ybXw+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09oFYwZCdWn6/rgwptW/4ImEJjuGMu3BcvJzi51oQMY=;
 b=J+xuv99X39Jtl5Sep4Ha4pGw8CZpZJ24n4d5eFS9SF8HNbO59h+FkHYDZwSF65HUUJhUpOZ0dsBlD0CKiuy3p+YOGXyx4bMiHzkW0Fk5X5ioY9f5HSlfk2H3S8o3q/KjOtm272VQEkPNpBm2NOxLJCNVfNSr6MU9kJCDPiNHretJwjb58FhIG1W5blJyBp6kwZPZSl5Qn1g6erM2ygNykCzaE93vR5rHA5pBaHR19yUEi1en/taLqrD7oO/jhsX8oQSnCSUkmwerW2+yH0izU4P8jBjhpqyQZjKgSp2u2S1D1nNtwHLukLtB+GasvvI7Gw7+WYIEhXoe4fcWGLVV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA1PR11MB5780.namprd11.prod.outlook.com (2603:10b6:806:233::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Thu, 4 Jun 2026 12:39:51 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 12:39:51 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 29/40] KVM: x86: Remove defunct
 kvm_load_segment_descriptor() declaration.
Thread-Topic: [PATCH v3 29/40] KVM: x86: Remove defunct
 kvm_load_segment_descriptor() declaration.
Thread-Index: AQHc77nHMix46aj0j0CuSNFdEDh60LYuXwOA
Date: Thu, 4 Jun 2026 12:39:51 +0000
Message-ID: <dca44cb7e6eca6fc2fbe113a39523d787f6d0fa7.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-30-seanjc@google.com>
In-Reply-To: <20260529222223.870923-30-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA1PR11MB5780:EE_
x-ms-office365-filtering-correlation-id: 91eb9c2f-f37a-4302-1b42-08dec2365f64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: grl9TTMK1fpncvQIUKL8zVcRNw7d6WEWcV75q97yCuUQuRMoupiTwcVRmEjycUHbCj5KQZ5iqVBQNkbUCSBzZiqRH4gVFzLf7oYxLKJG/5P8PIpdzXDLU9gPgs7KH9sowx4SkpgbSI2vzOInewM38PsGGFPCpedEvN9SjMp5X4gO6evb870TUh6jiL4pUY5d9BWdooF8kH3iQhgt+TtVRcke5KnTBEYvedjpMH6QzbdOflUgLue9/zz7iThy1FPzWAp18kZB0jI5rvi5qYsJihuprG/kMA0xWSYwoQa8Pztcp/OObIXkb2k4matCNoJqC7d+4TuUaiWDia/7aS+WbPatUqsV+wuqaBH8ZVPXyTl0Bcrt5yKtHlfWTiD/riORU0vYjhJQypJ9iLgkPIo/mqtmkb4e1oxJ8KrSzNDQjuWXqIoOBwvxja15cH7iYVcF5yNdG9GjYOBGjmlCagJVqRVnu5bJgAQSK+g1wKqr0IpwoYcNRxeFJRoiTxIAKWxYeeHzDkpLHhIVwMICe+5M/6VZ+vkAhCnAyh9fRNhMXoiiq0i/8FvNUV6Aa2SxGNHM09mXRA2VzySMIuLLz3RA4vMaG4Fzw5yHmaoRIvD7+XflbgX+5p2Zeoow3TIW1XNMxoLKYaA4Eb0hJISpBY1rJPZ/Qvk7gqVysRkZqByl0hyHFNlsR9zBEjN+zv7PKSI1wCnGzOv2Lp43Z10y1UcA6krNSpSwtlKi1SUUqQqHIQJ8V2WwfhHJjg/vXaft3Zog
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDFBMkpZSm14T0poclFoTlpWc1NLNUhGbTFFS2x1UDc4NHRJUFl2bVRpZXph?=
 =?utf-8?B?N21lTVVxVFFwMHlrZkM5UlZJRkJnR0ZLZ0k1SEVydnZkMDJxWnR5ME9rSTNM?=
 =?utf-8?B?VGt5TzJ1LzhtZkVnSHdzRGVOVHI2eWJEMGFqSU5NbTZ6VlZzeFBYMURYTkYw?=
 =?utf-8?B?ZEswdC9iS1pITlRvYWNqU2szTFNwNXBmTytsdHVtODF4bzhrMVZrM1c0TWYw?=
 =?utf-8?B?eFRScHNuUnBEdkVoaDliNlNnckt6WjdlZm5JdWtYQnVQWTBWWEZvODVBTzVj?=
 =?utf-8?B?aEFONFllU2VUbVQzR3VYMW9BSUtLVEgzdVhyYU5aTGZmY2RJakdJM1RGcEFQ?=
 =?utf-8?B?Q2ZPZTRMRDdoYU1UdWM3MjVVdGJBUW9GTUdyUEc1eXlKVk0xaDRkQ3VHLzFw?=
 =?utf-8?B?WmRvQzNtSjFoc0VORFIrd3Qvc2tvcTZMc01yRHcyeUliM1VyVS9EVmczdW1W?=
 =?utf-8?B?Unh6T3JzZDRSbndXeHpzQkk3TWlCN00xaVByZnVpUklxbko2ZlZBVkJWa1ZW?=
 =?utf-8?B?MW9TbGJ1aCtGN1VwMWRvUnA1RHZ6ZmhLRDk0akduQ2pOUzdMQUxnSVRQL1VW?=
 =?utf-8?B?NS9tTk11Q1BTQ0wyOWc4UFJBWWlpMW1rOHpZWmRQUjZuY3E1WXFlTGk1aWxT?=
 =?utf-8?B?QXJHK2lRWWpNb0VocDIrOGxhV0huaDVYc0R4OFZHd0l1QW1JZ05wWW5DMDcw?=
 =?utf-8?B?VnRiNlJaWWoxQjZ0ZDZtaVlFS0RKVXZRNklvdFNQSzNmQ0lEcy9HYlZqN24v?=
 =?utf-8?B?SzVzVXlFSzdiQm5JLytLc1E5U0Qyc1dWTlYrTFdqL1pzN25xRTZYRzdQRVlh?=
 =?utf-8?B?b0tTQXBLQmNlYWl2U3FoampaTVlKaEc1a3MxbEVFWEVCYTZFWmFZWnJSaWZm?=
 =?utf-8?B?WEltZVhHcmg1NWhnQ1R0RTVjaWN5ZnhhUmJHdnNib0ZKSjBhT2ZyaWZkT0Vm?=
 =?utf-8?B?Uk0vaTc4T3NqQWtPVHI1V3pNdExUKytDOTg1YWMvRGNDMnl1SE02TWFRdDk4?=
 =?utf-8?B?RUUxdTZhUEtUT1pxckJ1d1pRMEcvMW1aSDJtaEpIR3pId3JMQzViZjFTbVlL?=
 =?utf-8?B?cERQRTNDMzZQcWhHOXJWSUljM0MyQnFCQ0JOWitndDVJbjNCcXFGVzBPY2My?=
 =?utf-8?B?QTUySm9UbE9ITDdKNTRmQlBtd3VTZEwvYUozd3hTTFYyMW9CY3BQN1J6SFBz?=
 =?utf-8?B?VEdWU2lqa1QraEpNS2IvbHBCNnBwZi9YVURlRnRkMkRiODZ3U0NYZEEzemZW?=
 =?utf-8?B?eFExWXZTdnBQVjNhaUhuUU1FZW1SdGN1aEpMNGFHVU9vR3NNN1pIZmNHdFlL?=
 =?utf-8?B?alN5WkNtdnZPOVE5OWsvOU9ZbXMxVEpwaHM5SkdybVo0MW9SM3dlcmVZR2Va?=
 =?utf-8?B?ZlZISGtGM21EaWkwblhsMW93QWlLejZJZjJvV1NZMm12Q3J5YmQrMmM4SHhn?=
 =?utf-8?B?R3RLVXpnSmxzdlhiaVVweFByVDVxa3JidStpTUtyMXVId2NKdkp3M0tpQkQ5?=
 =?utf-8?B?QkJ3ZEpndUZZVUNPNTJJM2w5VTZtak5tUGFrazFEMnlkQ1hwVFdaL0MveDBP?=
 =?utf-8?B?MVNiNXhTYytLTVFINEhGaFc5Wm5iUWVHU0FRNHEyb1RxbVZudEFiV1JCM2pO?=
 =?utf-8?B?VXlFdU1wclQ5dFgrU0xGQ0VmUmNmY3F4RVNkN1ovS2trbXM1c084YnNPU3dn?=
 =?utf-8?B?MUJrSzBidUtxY1ZsN25ZcUxHa0xUTUp4dmFmYUVXMGVvV0NiQ2lwcnFrK0l6?=
 =?utf-8?B?bHp4cmNxR0IyNmtoVWFJaWZLV0d3Mjl1Z0p2ajczZ25qWk1zYndpa3JvaG9L?=
 =?utf-8?B?TW9NemlhV0hjYTk3TTllRDNwNmttSHNLdzhJT3FBMHpFdXU3L25ZbWZETUQr?=
 =?utf-8?B?MG1FN3RZVkhjU3dnZ3ppcUdCTlFtNTJ1VFpnYnl0ZmN0Rmo5cmJiUnE4Vnp0?=
 =?utf-8?B?K0dWOEJYRWU3QTRzRFAzNWVHMy90R24weERvMzd2MlpySEJQMVBMMjFzalVi?=
 =?utf-8?B?R1I2RVdUTlB0RitSSFdybHMweFZGZDExM3hha0tLRWdObTEzWEErUzNhTC9h?=
 =?utf-8?B?U0hOVGtITEZlZzZRRlUxbjFUU1N6YUYreXNvYWR3ekY3WHNZNVhNb2UveUda?=
 =?utf-8?B?cmZGNzIwQlJsbHd2VFVQMktwYkZFcXZUQXc0OTJaOGs3Wlh1aUZkYzZGemg4?=
 =?utf-8?B?cm1QaVd2VU5QelZsVi9FK1RHQjh6bU1LUkM3aVBnT2thU3NmRW93ZGJ2V3pM?=
 =?utf-8?B?cm9sM1dJOVhQWG40alg5WmJqMWxlcWlGZXM2bC94cFk5NFpCSEtDd3plRmM4?=
 =?utf-8?B?dE53QS95S0RrdlhJRVRNRlZLQUxERkUwMXdaaUhwbnc5UktvVVkvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D363FB9706A6BA46987D1E47E0269D7C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kPEc/NoFf1AAZmespYyeG7I93aW4tCmRB7TRqr/diVU1YLEh4r3+c1c5UTlU519/8+lOSeKrvvYUqGypwakVlrSwBT5YEOP7aK7YFaz5QyKrwUAWyYbmyr1pm2Y+CTEwzbF9Fa2+KC653rg955ogxGZPOk5Wup+4R5C7XpuN7TUSU5TOzpda+fLUwjNwUHVgmwJcPqp5s9hsu/wYf+NCEsGxBxHZlxLEvsk5hd0IjO3UXbS5l+MOxm5Yy29AA71/25rtauAGnOlYYKIJU3iVaXKx1j6SyT6XLJHjGHqiBBRAubMPobPI0aCyWBl/ijD1lH27kqvZ8Y76vFb7tXnccA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91eb9c2f-f37a-4302-1b42-08dec2365f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 12:39:51.7003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYB4heX5GGygl2mN8yWX2Q4tT2Yo6JOz5rrFFHqmEySKOn6q1JDqh75XQ/eWcIVIh8J9GZcGx8lW5a1zFVk/TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5780
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZW1vdmUgYSBkZWFkIGt2bV9sb2FkX3NlZ21lbnRfZGVzY3JpcHRvcigpIGRlY2xh
cmF0aW9uLCBubyBmdW5jdGlvbmFsDQo+IGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiANCg0KUmV2
aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
