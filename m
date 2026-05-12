Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A71A23AB9D;
	Tue, 12 May 2026 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549389; cv=fail; b=ePzJPGOSsm7pXQ7bkBz9UZt4JHGsSZPmGGWIRYXItShAHUyDekpTCidItN2YWyNhYtCNpfXvdfLm5K0Xrt3TEC5JyCLFNhWOJbd5Kx6jb0SbsLUVYymhOKD5PFzfDmPy58rYHwklD/vpl4T06IdtRcMMhRg11Rw80t+v+yGYbTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549389; c=relaxed/simple;
	bh=G/pyVhhhbZTTqyZUSfjkRoBMx5DdD45CC1Wb1Es8OCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZtONKVsE/iCtXG2UkQ5N5uShM7IKm53TaOpfdLetNyOowW5AppSDEoUj81S40nJ7i6mIYnVqIpMdgbGcncjg77JOvfDPWN3hrC0etU7Ytilr2uwfMRYVZSH2tH44CxOtCd3ADb+HseTsDwdwtE8hkDD8CqU76o2fAyuq8LRTvUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALWMoWqi; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALWMoWqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778549387; x=1810085387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G/pyVhhhbZTTqyZUSfjkRoBMx5DdD45CC1Wb1Es8OCc=;
  b=ALWMoWqiLQ7vE+zYFBgZwlSh2Sk8aSeiw3kpyH7ahlXYKEcFtBVTBcpg
   5akSy0z+TbecYqPg0IPDwh7Zsn24OANEgsqEcGTCGoXMV7IKOwLMVCOCN
   s5ieK14FOOLFaRyoPpVomoMPDY+8ulgAC+QJttj4k2ERQ68E/4AK9aNQX
   RTknd4ny6NGohV3BhVdDDZHpxdg6VXHFM/Le9Q5F0ljanLEtzXmzsWQjN
   VTr3pRuur8cH2b0LskSaX6TUWOXDAiqh5Tj/JB+tsIbVhFt9qRZGBsMRW
   tWKhn24zq9bbOHi+C0PptNdwbE16gq+GK9wpjxaz5XOjJkeYDDUmJUcBN
   Q==;
X-CSE-ConnectionGUID: jzUyAky3QlKhW6qkMAH7lw==
X-CSE-MsgGUID: 7VDBVyn/RHq/c5EiNi0t5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79310258"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79310258"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:29:46 -0700
X-CSE-ConnectionGUID: /oXWRdXiRBm0swkkV9pn9w==
X-CSE-MsgGUID: DALI5cUAQoCJQrIi6CRXoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="236638879"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:29:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 18:29:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 18:29:46 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 18:29:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZD8F06MlJgo8effDn0D5aPGNsohom9+7sC8ODdtS4NTSaerAQ4E/ielAk5slZWLWXducMMrVw7AD3GyO2vKDdAtYH1xnOK0up/LVyGcEWInD86Hdb/tRIloVxc3TQkcC0WWHFwhDJ3XPHYGX0qhkjagp+SYS6Uu6gS2JDmyuTWeqxsGfDSRj3J+ps9Ufod6KufV59hTE/hflAVF58vNCqH0vawLYqJjt8f3vTzmFSsVud8p91mfnfDjiMfUZ6lroOvLSUNgjkn9nxWtnQXJp9SewJKw+/z0CB9JYqENtoDE6vH3e2zuBn9RC9X9ZaaNYKeXppsINLllnGmiDXsZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/pyVhhhbZTTqyZUSfjkRoBMx5DdD45CC1Wb1Es8OCc=;
 b=Ij5FWgzJfR/7WHDIlNlHW7KBTVOmRX+ZaDNK4K7LO/JTjHY0lslHzQY0QgGCW+wB4eCMu71U4eTjnX6ffBQHahxthWu71nD+6/+CxrAxb6BT2WEeQYXrQeVwr8WRHwt0sezNuxrB+zmE4hCs47v332NuS6liFBNSvOl3+o9f5xWbv0ckY6ZJoj8ufa96r5MtjoAN+LQLlfcq85ida0gxM3eEm+VeSUkZ3hbUl/5cBJFwo4VK0Z4rn9/P29WiKxOD3fTlVASxfCQCbh2zNGx6b5x60GNsE/8NP4neLZTDcpoo/QAWA+JLpgkCx/f8d22cs1XKfQwCiwQkjfKx9gdzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11)
 by DM6PR11MB4706.namprd11.prod.outlook.com (2603:10b6:5:2a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 01:29:43 +0000
Received: from PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::789c:dda1:63ec:6dbf]) by PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::789c:dda1:63ec:6dbf%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 01:29:43 +0000
From: "Miao, Jun" <jun.miao@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KVM: x86: Block TSC multiplier writes for protected guest
 TSC
Thread-Topic: [PATCH] KVM: x86: Block TSC multiplier writes for protected
 guest TSC
Thread-Index: AQHc4UoUpaTNvEFXi0S77/WpHA6QpbYJlkEAgAACosA=
Date: Tue, 12 May 2026 01:29:43 +0000
Message-ID: <PH7PR11MB8455026E7188DE98FA6940C69A392@PH7PR11MB8455.namprd11.prod.outlook.com>
References: <20260512111830.1295437-1-jun.miao@intel.com>
 <33cc37f03fe011180b90c66787d5ee5e7456471a.camel@intel.com>
In-Reply-To: <33cc37f03fe011180b90c66787d5ee5e7456471a.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8455:EE_|DM6PR11MB4706:EE_
x-ms-office365-filtering-correlation-id: 2dd63f31-167c-44a1-023c-08deafc5f1f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021|11063799003;
x-microsoft-antispam-message-info: +c7c62uklMKl5aRQDRGbTsBdyffOdCy1VUdnCzDiUU43VutNZ19SISYuxBDZ1HvC/vkiXQDQK2IV3+MSDrmtHVhAdm20o07svZik897V/3DJ7h48N5RWUN7Nn9InMDGQNPfQCsHoc++NQcOYmqhy7KJ2bmIy7j5DvLmydwnLZhbk8rf1+qe+9EHfzM8ntCO9HdTlbzoO23slOSsmQlCj6+O1XmvbFtBiiaSf2ukDio8XnUxY06jp/dMPYRQS3VtleUZtwoEtURAO79eIiGMvayL6iL4NKx3lMaPmTnf6L5vjTnW+67xoVWwjBF0ikYgVBaEvNhb6rXhd8KkQfIMMErMiXytMcwbp2CCuLLTh6bUp+KztBAWmrkB7nlkczD6u8Q6ny/NjduSQkwiqjoCpOSfmem5hi9Wthc083pXG8PAzcuqJeTqGolZpRWbyOYM1TsmLu2LB5DHe1V+PRsypwvh9KjrRC5wXulbdAbJlTfOfnwfAlFYZzFHtrMqY9uhh/xqVAGpztju1xvCnDY5XBXRw72X8addpnPKuNmOjco7HeJogickrQf/MWiVyUGjQ1fdqwj3WSMlo4UoJE64XX3guGZJdSq8auoiS5vJ9o74lbSUYO2YPkWfwd24FS7LrGoW4AWoXlA+Ci2b7/BEBgdkmIMdte/tw2gSjeWOg7H7rxEJLdWd6vcq/dP1wourNzSz4T2wNZYtjOIxAoRMjF4AHDOw9ODe+VR34fkHtvbPny0BkkgjzMiNr/+kfjROr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cy9weFp3bi9DNnlmbWt3bUFKUUJRVHZZUGVvVTR0bDZ2cFlhV01XaVNUWlBP?=
 =?utf-8?B?WXBtVzhsdnJiQ2lyTmpKcDNmUzArMlBacVZwZlZtR0JVOEdLZ3NybW5xK29s?=
 =?utf-8?B?Sm91OFFPMytoYWpFVFVFRUNTMXo5SndnaDJwUHNxM2RGM3hHdVNPTXJ6UHQ0?=
 =?utf-8?B?WW85c2hlN3hjcmQ0OEF2aWNvRVNySkhyZ2RJWFVSMlVidXJnYzRNaUUvc01K?=
 =?utf-8?B?b0E4citSVEUzb1duUFBYWVE4SFRiTXRTT01hZEV3Ui9YdXhsMVFlSU5saVFW?=
 =?utf-8?B?cE1YbG1CbWF1NjFEbmxTc0JSRmN2OEZ1UEZrL1dHSkVhcS9Vd0dUUkV0d0Rl?=
 =?utf-8?B?NXc1WWY1M0J3TjQ4QmJYQ0VTczBDcjNsUVhscVFVKzhPYVhkNzdVTXZoSVk3?=
 =?utf-8?B?WHY4eS9CckZHSmgzVHhGUGcrWGlmSStaV1VvWkxFRUlBT1RXMkkzQ01HQUxM?=
 =?utf-8?B?WUVmZUxZTW5meFplZlZpSkxURFkwRU5jK094ckhucFoydjlhbG9hcFdwUDVa?=
 =?utf-8?B?NktTc2o0Y0NEb0Fac2JyemNoVmFNTXlPRFNCVXVFOE1iSTl6dHpySXZ2RTdv?=
 =?utf-8?B?MmFpd0FYbzJFZWpRMkZzWVAyVGhxcVBtcEZVVnc4Yk9XalBKTjlDTVlrVUxE?=
 =?utf-8?B?ZU9WaTBXbllEaHF2RTN2bXNjdlN5TVArZmdPN0RMdVJLb1pMMXFpUnZoNmtO?=
 =?utf-8?B?dEZVak5yRStEZmQ1SXFiQm5pK2lsa2lTWkxiN1Ixam0wWjJ5bTlXWVdZVjJN?=
 =?utf-8?B?a1hXMi94azZ3aEJJWW1pMkNmSFJqUUI3d1NvU0ppdFJXOUNYWVFxekZBSzh5?=
 =?utf-8?B?UGJHc0xyZkpFc2Z3RzM2Ujc0Z1pETXJQV2hSanU0VkJBUkVzVU1YN2xweTFm?=
 =?utf-8?B?ZmdGeXlqSXp3QjVmd1pPTlpZeVJrcUpvbzFsV1lDbW5UTHczZjh4ZGh2dzg4?=
 =?utf-8?B?YktMd2tFdXJTVFV1RDhyV05WUjdKdm0vVmUzSGdSRFpoZ3N5WXBwWkw0VW1R?=
 =?utf-8?B?ZGJsMWpKWjFyZWpUR0d3SC9ZZnRHZFpybkZ1VjNURHRDTlQzclN3YlB5MGxn?=
 =?utf-8?B?eG92Ly9UeFVaMVhoN0pyajVPNURPTndySjBRYkYrTFJUUzd6Yk9jRTZxa08z?=
 =?utf-8?B?VzM4akhTMlpDLzRoTkxWVjJPVDNYYXhUT1NaVGtWRHZ5TDU1NVNjakV4NE9k?=
 =?utf-8?B?UW9jTXNxVTlFTHhRaGRjRTB1RTdlZFNrd3JHY3ZSKzRGN2JvRFhSM1pNUGI2?=
 =?utf-8?B?WnpaSXl6YkVFTXZYTXQ3TjlPdTdwZk4rN2h5T0Y1TVJBMVkrVHloY2xGOU1E?=
 =?utf-8?B?ajR2U1FSTzNGL1hGM0tvdW45bGhObVBZQTZZejBmSVM2N0JoQXdtOU5CSjdm?=
 =?utf-8?B?RDkxS21neVN1MWpuczMwQkRhVlgxcitCMnEvc251Z01RZitubnpacE9jRUUz?=
 =?utf-8?B?NlZOM081Wlo4MXkwRUF5WjR1UXc2c0xJRzlLU0RiRXB0K3FyZ0krUFlDL213?=
 =?utf-8?B?VUYwZ0prOGNCUzdybGVoWXFMeWt6d1dMWkNYa1QwVW1CdG42cEpTZmtpbTEy?=
 =?utf-8?B?OWxMa21ZOGRIbWN6b3N3QldNOGR3VHhKeXFxTXVFVUE2Rmc5QXBHQWlHZ2FN?=
 =?utf-8?B?Vk1NeXZCbW0vRlcrSlcwK3ZqQlJoanV4SFRIMm0xd3VEL3U0QlJKU2RIYzJT?=
 =?utf-8?B?bGVwRDdFTGRhbFFCdUowU3hRZkFpK01OOEROSEwxd0Fsb1oyWnQyLzI5NmJT?=
 =?utf-8?B?YURxcXRUaGlnYzZ5RjFObG9aNkVkRnozSjNkeldDMnM2ZkpTcWs4c0E4YWpK?=
 =?utf-8?B?RytVT0YzQk42NkVKUXJOdkpiYVNzMGVkK25sWG1XRHd5Z2pMTHdIdS9ZdTJ0?=
 =?utf-8?B?VEpkUG9FYzJ0Qk9xTWR0KzhuSzAwRWJoSGZZa0grSHh1ZVBSd2VEZk5ab0Ex?=
 =?utf-8?B?ZXZoU24xZnFia2MrZUM0QmZ4UkttN2Raa2ozblV6S2oreWNUU3lXMEREeVZ2?=
 =?utf-8?B?a1hZb0NjZlRuRURENlgvTW1OQ2FXVThzclZvdHJWZHJ6bStVUkZaSzBrUWhD?=
 =?utf-8?B?aE4rNWtDVDVJdnN1TzA2Ti9tVTNQTzByY2VhQVdSR2ZsU2dDcFNOWFhLcGl6?=
 =?utf-8?B?bERubUoxL09icGxQeWFpRzlTTmJRMW5RU2cyZThrUzNmY1lvU1VnSG5oek00?=
 =?utf-8?B?ZW5qZnhMdmRKckRWRE04UENHaEFBRjFzVk5qZzhrZVEyOURjWlNaUXdvS0N5?=
 =?utf-8?B?RVRiMWRybHV1VjZvU0RTKytvSEJRNnhtQlp0SnNweUhZU0VqdHk4THY1WGx0?=
 =?utf-8?Q?TTBVsVQrDtraOoljjL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gvMVHbP/JN/zfFR7mW4gR0kw73zJBeSUnl40B+9scayjFGKan6GGLmL2HTvUciafzKaCLDY8xuAGxEZd/wsFnW4FNnLX34upQbu8zCObLTPCnNKWa/9wlA4LMn9nPf9Si6fZX7t9qkn8k1pYZm6HQ0JWdPXt7fJPv8wvpcZbiRMU9v0Ik475AishL7KfJ1XZ+nDkGeRSBgU2NvaaqI4XUIiCs967swxRg9r03HtM4xWqg37yMaTTxGLTPFfszGS2ztvx3Zcht4JGN6e0wdjgS+DLYAmca6Atu+vT+IO1d+4pm+I2I2Y0/JLLBIsvB7BlC/Z6/DCOlbSDHmoUvObc9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd63f31-167c-44a1-023c-08deafc5f1f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 01:29:43.5055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+1khZ2joT2i8u79U0LT5ONiuNFhpnJmqkHf6FjXSr6WqJX3TIxxJe4J5j4qzqH8mgYm1pxSVTij1MRjWvm8uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4706
X-OriginatorOrg: intel.com

Pk9uIFR1ZSwgMjAyNi0wNS0xMiBhdCAwNzoxOCAtMDQwMCwgSnVuIE1pYW8gd3JvdGU6DQo+PiBD
b21taXQgZDVhNGU0MDhlNjliICgiS1ZNOiB4ODY6IEFkZCBpbmZyYXN0cnVjdHVyZSBmb3Igc2Vj
dXJlIFRTQyIpDQo+DQo+VGhlIGhhc2ggaXNuJ3QgY29ycmVjdC4gIEl0IHNob3VsZCBiZSBhZGFm
ZWExMTA2MDAgQUZBSUNULg0KPg0KPj4gYWRkZWQgdGhlIGd1ZXN0X3RzY19wcm90ZWN0ZWQgZmxh
ZyB0byBwcmV2ZW50IEtWTSBmcm9tIGNoYW5naW5nIHRoZQ0KPj4gVFNDIG9mZnNldC9tdWx0aXBs
aWVyIG9mIHZDUFVzIHdob3NlIFRTQyBpcyBtYW5hZ2VkIGJ5IGEgY29uZmlkZW50aWFsDQo+PiBj
b21wdXRpbmcgbW9kdWxlIChlLmcuIFREWCwgU0VWLVNOUCBTZWN1cmUgVFNDKS4gIEhvd2V2ZXIg
b25seSB0aGUgVFNDDQo+PiBvZmZzZXQgd3JpdGUgcGF0aCB3YXMgZ3VhcmRlZDsga3ZtX3ZjcHVf
d3JpdGVfdHNjX211bHRpcGxpZXIoKSB3YXMNCj4+IGxlZnQgdW5wcm90ZWN0ZWQuDQo+Pg0KPj4g
QXMgYSByZXN1bHQsIHVzZXJzcGFjZSBjYW4gc3RpbGwgY2hhbmdlIHRoZSBUU0Mgc2NhbGluZyBy
YXRpbyBvZiBhIFREWA0KPj4gdkNQVSB2aWEgdGhlIEtWTV9TRVRfVFNDX0tIWiBpb2N0bCBwYXRo
Og0KPj4NCj4+ICAgS1ZNX1NFVF9UU0NfS0haDQo+PiAgICAgLT4ga3ZtX2FyY2hfdmNwdV9pb2N0
bCgpDQo+PiAgICAgLT4ga3ZtX3NldF90c2Nfa2h6KCkNCj4+ICAgICAtPiBzZXRfdHNjX2toeigp
DQo+PiAgICAgLT4ga3ZtX3ZjcHVfd3JpdGVfdHNjX211bHRpcGxpZXIoKSAgIDwtLSBub3QgZ3Vh
cmRlZA0KPg0KPkNvbW1pdCBiMjRiYmI1MzRjMmQgKCJLVk06IHg4NjogUmVqZWN0IEtWTV9TRVRf
VFNDX0tIWiB2Q1BVIGlvY3RsIGZvciBUU0MNCj5wcm90ZWN0ZWQgZ3Vlc3QiKSBhbHJlYWR5IGFk
ZGVkIGNvZGUgdG8gYmFpbCBvdXQgZWFybHkgaW4ga3ZtX2FyY2hfdmNwdV9pb2N0bCgpDQo+Zm9y
IFRTQyBwcm90ZWN0ZWQgdkNQVS4NCg0KSW5kZWVkLCAgSXQncyBiZXR0ZXIgdG8gYXZvaWQgaXQg
ZWFybGllciAvIHVwZnJvbnQuIFRoaXMgbW92ZSBvZiBtaW5lIHdhcyBhIGJpdCB1bm5lY2Vzc2Fy
eS4NClBsZWFzZSBpZ25vcmUgdGhpcyByZXZpc2lvbi4gVGhhbmsgeW91IGZvciBwb2ludGluZyB0
aGF0IG91dC4NCg0KPj4NCj4+IGFuZCBzaW1pbGFybHkgZHVyaW5nIGt2bV9hcmNoX3ZjcHVfY3Jl
YXRlKCkgLT4ga3ZtX3NldF90c2Nfa2h6KCkgd2hpY2gNCj4+IGNhbiByZXNldCB0aGUgbXVsdGlw
bGllciB0byBkZWZhdWx0X3RzY19zY2FsaW5nX3JhdGlvLg0KPg0KPlRoaXMgaXMgbW9yZSBsaWtl
IGluaXRpYWxpemF0aW9uIG9mIEtWTSdzIGludGVybmFsIHZDUFUgZGF0YSBzdHJ1Y3R1cmUgYmFz
ZWQgb24gdGhlDQo+ZGVmYXVsdCBUU0MgKHdoaWNoIGlzIGNvbmZpZ3VyZWQgdG8gdGhlIFREIGJl
Zm9yZSBjcmVhdGluZyBhbnkgdkNQVSBbKl0pLCBzbyBJIHRoaW5rDQo+aXQgaXMgT0sgZnJvbSBm
dW5jdGlvbmFsaXR5IHBlcnNwZWN0aXZlLiAgTm90ZSB2dF93cml0ZV90c2NfbXVsdGlwbGllcigp
IHNpbXBseSBkb2VzDQo+bm90aGluZyBmb3IgVEQgc28gaXQncyBzYWZlLiAgQnV0IHNpbmNlIGl0
IGlzIGNhbGxlZCBhZnRlciB2Y3B1LQ0KPj5hcmNoLmd1ZXN0X3RzY19wcm90ZWN0ZWQgaXMgc2V0
LCBJIGFncmVlIGl0J3Mga2luZGEgbm90IG5pY2UuDQo+DQo+WypdIFREWCdzIGZsb3cgaXM6IDEp
IHVzZXJzcGFjZSB1c2VzIEtWTV9TRVRfVFNDX0tIWiB2bS1pb2N0bCB0byBjb25maWd1cmUgdGhl
DQo+ZGVmYXVsdCBUU0M7IDIpIHVzZXJzcGFjZSBpbnZva2VzIEtWTV9URFhfSU5JVF9WTSwgd2hp
Y2ggY29uZmlndXJlcyB0aGUgVEQncw0KPlRTQyB1c2luZyB0aGUgZGVmYXVsdCBUU0M7IDMpIHVz
ZXJzcGFjZSBjcmVhdGVzIHZDUFVzIGZvciB0aGUgVEQsIGluIHdoaWNoIHN0ZXANCj52Y3B1IGlz
IG1hcmtlZCBhcyBUU0MgcHJvdGVjdGVkLg0KPg0KPkFmdGVyIDMpLCBib3RoIEtWTV9TRVRfVFND
X0tIWiB2bS1pb2N0bCBhbmQgdmNwdS1pb2N0bCB3aWxsIGZhaWwgdG8gY2hhbmdlIHRoZQ0KPlRT
Qy4NCj4NCj5UaGVvcmV0aWNhbGx5LCBBRkFJQ1QgdGhlcmUncyBhIGNoYW5jZSB0aGF0IGlmIDEp
IGdldHMgY2FsbGVkIGFnYWluIHdpdGggYSBkaWZmZXJlbnQNCj5UU0MgImFmdGVyIDIpLCBidXQg
YmVmb3JlIDMpIiwgS1ZNIHdpbGwgaGF2ZSBhIHdyb25nIGRlZmF1bHQgVFNDIGZyb20gd2hhdCBp
cw0KPmNvbmZpZ3VyZWQgdGhlIHRoZSBURC4gIEJ1dCBubyBzYW5lIHVzZXJzcGFjZSBzaG91bGQg
ZXZlciBkbyB0aGF0Lg0KPg0KPj4NCj4+IE1ha2Uga3ZtX3ZjcHVfd3JpdGVfdHNjX211bHRpcGxp
ZXIoKSBzeW1tZXRyaWMgd2l0aA0KPj4ga3ZtX3ZjcHVfd3JpdGVfdHNjX29mZnNldCgpIGJ5IHNr
aXBwaW5nIHRoZSB1cGRhdGUgd2hlbg0KPj4gZ3Vlc3RfdHNjX3Byb3RlY3RlZCBpcyBzZXQuICBU
aGlzIHNpbmdsZSBjaG9rZXBvaW50IGNvdmVycyBhbGwNCj4+IGV4aXN0aW5nIGNhbGxlcnMgKHNl
dF90c2Nfa2h6KCkgaW4gYm90aCBpb2N0bCBhbmQgdkNQVSBjcmVhdGUgcGF0aHMpLg0KPg0KPkZp
bmUgd2l0aCBtYWtpbmcga3ZtX3ZjcHVfd3JpdGVfdHNjX211bHRpcGxpZXIoKSBzeW1tZXRyaWMg
dG8gVFNDIG9mZnNldCwNCj50aG91Z2guDQo+DQo+Pg0KPj4gRml4ZXM6IGQ1YTRlNDA4ZTY5YiAo
IktWTTogeDg2OiBBZGQgaW5mcmFzdHJ1Y3R1cmUgZm9yIHNlY3VyZSBUU0MiKQ0KPj4gU2lnbmVk
LW9mZi1ieTogSnVuIE1pYW8gPGp1bi5taWFvQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGFyY2gv
eDg2L2t2bS94ODYuYyB8IDMgKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0veDg2LmMgYi9hcmNoL3g4Ni9rdm0v
eDg2LmMgaW5kZXgNCj4+IDBhMWI2M2M2M2QxYS4uZTkzNWZlMzNkOWMyIDEwMDY0NA0KPj4gLS0t
IGEvYXJjaC94ODYva3ZtL3g4Ni5jDQo+PiArKysgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCj4+IEBA
IC0yNzM2LDYgKzI3MzYsOSBAQCBzdGF0aWMgdm9pZCBrdm1fdmNwdV93cml0ZV90c2Nfb2Zmc2V0
KHN0cnVjdA0KPj4ga3ZtX3ZjcHUgKnZjcHUsIHU2NCBsMV9vZmZzZXQpDQo+Pg0KPj4gIHN0YXRp
YyB2b2lkIGt2bV92Y3B1X3dyaXRlX3RzY19tdWx0aXBsaWVyKHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSwgdTY0DQo+PiBsMV9tdWx0aXBsaWVyKSAgew0KPj4gKwlpZiAodmNwdS0+YXJjaC5ndWVzdF90
c2NfcHJvdGVjdGVkKQ0KPj4gKwkJcmV0dXJuOw0KPj4gKw0KPj4gIAl2Y3B1LT5hcmNoLmwxX3Rz
Y19zY2FsaW5nX3JhdGlvID0gbDFfbXVsdGlwbGllcjsNCj4+DQo+PiAgCS8qIFVzZXJzcGFjZSBp
cyBjaGFuZ2luZyB0aGUgbXVsdGlwbGllciB3aGlsZSBMMiBpcyBhY3RpdmUgKi8NCg==
