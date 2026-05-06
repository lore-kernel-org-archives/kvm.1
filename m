Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D6530EF63;
	Wed,  6 May 2026 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778111784; cv=fail; b=tZ9WfmpHZMb13Aim05dEZO8IID+Bhy0wgTEfXRxmeaKVz+KEZ9TG2giTA7Y0W8Tn7Eq2mZlMgs5doGq7jYnd6NPelCTSCK5HUMvAspw/bwnlUhRxQW4vusNzEF/G4LZYWgSZpoLwSrRHTUBGXws302QDJDbwC1000GAegMWEZsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778111784; c=relaxed/simple;
	bh=zxPziodR8MwXuaA5Si/BwHVOrYFHen6muUfV3M/GkK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u51Srsq6AVNDTueCHmjYsDY+9NiL041MG6cQ87311GOJlCqHMkQ8wwZBQ8Fv5jV//nhUTO8nm3DqbMzTdWbxmvaoTCLGi7j5x9H/PszBw+4hQzywsZB9JnLTkiIph0KfQ9KXj6eRD6x0B4eSYMCOirlA9sJyS4a43HYlHjHY024=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmLKquc7; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmLKquc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778111782; x=1809647782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zxPziodR8MwXuaA5Si/BwHVOrYFHen6muUfV3M/GkK4=;
  b=BmLKquc7XhXexBs1Xc5Hyyg5042U6uHhrad+fA62+pTXLW+3/SLslfpz
   JYojNwGpYaBHb8AwGgwqHiJ8UF42SfWqKl3k1rFvjZ0yadnBOB9lo/xX0
   56qUP/rnuYgXqKcUWmwkJ55QsWUtjQOa/qGz8VgkKcVyW9O6o7dq7LxS+
   ZGZblVYWKPyE7G59arOHmT77DePqscAeTzZqhSDNBWUDVyfCq0Qo1KEYQ
   3ZyKHG8HbDrEsZYaB3q6faab88N2FfALKJdwZR1ehbXJ04F1WQPwK3ER/
   SINKTiBcgTIp9kcu2o/S7qwC3uIM867UZUMAhKewKL67CJ6QeP+3/TG+6
   Q==;
X-CSE-ConnectionGUID: 8i+3zOs6Ru6OOgtoreQalw==
X-CSE-MsgGUID: EWm0s9VFRaOWWXnUQDnn1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="104514948"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="104514948"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 16:56:21 -0700
X-CSE-ConnectionGUID: uI0CrxRFRaaPBb9rQvG1DQ==
X-CSE-MsgGUID: kALhqL/6QzaeikfGf6uB2A==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 16:56:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 16:56:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 16:56:20 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 16:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5MVEp4R05vxgpSkXlA9ez/zFWasTOgebgxR5j5oyJ+HfsAHvdsJigpk07R9i9A9QH0+vOZGyQ3wQXTfDu4Y+ThLmyjfLn/Aht33cI48voVVB/i6s9FZcCODsSTyPGmoUAhXARv2L8KO+bYUFdYn/PZoQ/VukeC6x4A0fmcAdy/7XaQm9knf4k2sO8GdfsihpF+wWaEAZuZuNXdk4dlgzE8Fc66YlDyK0PKtc5mCIa4hG5b0EnCcmPqoMgms1LpJ0yX68OBx2uJjx26hah7n/zzwTcAQNaLovYooJhF6x3QkHOIj6jaR/fbLacuvpXjtmxK3Xs9DTcdRt4fKkjccEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxPziodR8MwXuaA5Si/BwHVOrYFHen6muUfV3M/GkK4=;
 b=RP4FD0Qt2QGmFXHWmcKaGVoB0P4ZbpFRh2YMeEzNPq6cBDmMrluXbK6m7K+ipOTDdffwkokK5qHdLvYwvgOQf51SVThK+R7Yx7bmHyxKKBrBWigEEKxPi9tw2pk1NDYlIfqW4N6Zflcqv0mG3YFkKB0V53qqfih1IKCItq7FJfuao3t5EjG6tQPc7AZi7uunH+/u8cLuzg08edlILg/erSKxj7jN2gczqfhtKXmaUF+zZkrMxdLuUNDDHKbdIjGkuvCxY4VzPKStWRhhlyRfpAuygthQU6WWvo19jsPxIohcQnQE627hn0g2MqZZVYTFZRJbHs9ObtkRU0TsJdfZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Wed, 6 May
 2026 23:56:10 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9891.016; Wed, 6 May 2026
 23:56:10 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "jmattson@google.com" <jmattson@google.com>, "mizhang@google.com"
	<mizhang@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] KVM: TDX: Disable pmu virtualization for TDX VMs
Thread-Topic: [PATCH 2/2] KVM: TDX: Disable pmu virtualization for TDX VMs
Thread-Index: AQHc3DByfgzLWqsiP0G3zQJGml8/1LYBoK8AgAAOvgA=
Date: Wed, 6 May 2026 23:56:09 +0000
Message-ID: <3dc2300e50f655e261115099b416c6a1abbb9e9d.camel@intel.com>
References: <20260505014118.3783476-1-vannapurve@google.com>
		 <20260505014118.3783476-3-vannapurve@google.com>
	 <afvIuEuSYuktmtA2@google.com>
In-Reply-To: <afvIuEuSYuktmtA2@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA2PR11MB5036:EE_
x-ms-office365-filtering-correlation-id: e0350b4b-444e-4034-002e-08deabcb0bf3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: bThdpKM0MA2//FEzEaQhnWZyYcGaK8COdTYmkGE4w5+fHPxXLPntV1ktnZqTCqRKIouOJeooXmMg04EmNyud4BWaWuMkucWIB78bflgC3q6utwDo6MYDnzGdU+2X4t3cP/uZX8szGtyCHIZR41VVEJpkMqFgFnLDfvCBt8w+AoOGPtfRrD/GA9HXGgxOJdghSpx8qgPxADhpqP3MWORBOOiSsCOlRtFONOjj0b6peXCrk0orjbgcXDrcwDwCET5jxJ8Vz8lL1jXRVwz85W0SQd3yWHdgUZTZwuDE8jNUFA0UhX72LS3avFkf0VpjMmYwCZ+cDCIDosMmAEwPZ6uH9+hPzqsieLjR0Ogn+nOgJg6xIFcKKuzkoUDvj0SO/4J9xefoU6MWBOWpT+Lq7gO9kk2ifI4UHHxgIbc4bc0efTchg22FAknvbOssGFKrTQA2tfmf3GjBaKcV9ZxJtJZWN77YJZhhXXUFQOJ7D3MS+UisvFuv9pfb7h3Wg3UP4eOzYAVw9RZ67nO43M16A22WH/O0ckX3OauHzqn4PqEo6ILmwo8LXjawCoHynhKonCL6aG6otfglhD136qNO2dLfXW/veVwQbp65k3fFa11ipzcSsE57L5F4YTq1xv76mLak492MrOddBnP3D6lDo0XHtVfMzDxuKGhHYBtF2HZ32XfYNHbpBXwFnHGYGarCdfoBBJzLjXrVwwYezIfNb9BR4izZUNAOk8AqrQRnZrVW1YurlKoNLv+Spi8/c5ilcGpl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blR6MDcyQTFsZ1BUSmF2WURQR2dGbG9rV1Y3UHlnSEpKL3pGR0J2Y2FqYUJj?=
 =?utf-8?B?bm0rREhxaUx6VHhBa3psc0prK2NhaTlaT0U2bFFad2ZDQ2FMSGM4Q2RUTURZ?=
 =?utf-8?B?ZHpoRDdCREt4R0NPMU9FZXVhU0JMNXBIakdGOERLWE0xNEdob2l1K2dOTktH?=
 =?utf-8?B?Qm4rd1ZiQU5jd3hhQ2l2Z1l5cCtjbHcybi9xS0hiTGd2V2RMOUQvNHgzclh5?=
 =?utf-8?B?aGpHT0ZSYzNWTHNWV0piOUgyazhjWHdEeEpmV2NXVDJqRG5ubkNQN1dpKzd6?=
 =?utf-8?B?ek03d0g2R1lacTNSOFdwQlRrS1hVU3pGWmdva3AwT0tJZUVzaHdyeThwYXov?=
 =?utf-8?B?OXBoY0NrRE1uYWx0RVNXbnVFK1R3MkZ3bDBjOUkySncyOE1DOFVqOUh2T2o5?=
 =?utf-8?B?eGROZmxaOXRsbGwwbXdmcmV6RmtQM2RvVG9Yc3FiQzdsK0V3MHBEM3NGQXVG?=
 =?utf-8?B?YlZvQWR3NFZkYWNSL3RCdmp6dmxxeUE4SW9zMTZVamhTc094WElaeXN6S3JK?=
 =?utf-8?B?OW9WTDk3anVXTHMveVlhQXJITkdHeHl6RVo4NlI3R0VVanMyZTJtcGZobzRC?=
 =?utf-8?B?dGJtUDZ0S0VRemkzb01KMWdub3Y1R09yL2RmSG4rYzM2ZUx6UWo1ekJCcEsw?=
 =?utf-8?B?bU4yY3dFcTNmQXF1eHVRR2p0RnRGb1h4WitCVjNMMjRzT2lEVzdtdGVMRnU1?=
 =?utf-8?B?Tlkva1hmTVFJa3JnRGpwNmZNZFY4Z3l5M2g4RnRDV0FOR1NnbzJzYitxZ09F?=
 =?utf-8?B?bGM3aW44Ty9selFsbWdSQVVrUTIzbzBUejBDK2dBOWw3KzRRSk1jOENaZW16?=
 =?utf-8?B?NFBzLzN0R1VUMloxaGFOOWlwZFg4SzFZR0ZJVHJvT1RSd2wxNjVYbFlNWm5r?=
 =?utf-8?B?MmRGVWtua2xqSHNkQW1Pei9sNnY0dFBOaHlGS0tOb0o3enp6eEhLc3NkYlFN?=
 =?utf-8?B?YndHOSt2QndkOWFtWm5JdU5xeDQwTGdNa3RpWm42ZW9TOUdBdkJ4OUVTODFS?=
 =?utf-8?B?Q3hpSGxVbllaa3NHbThRTVdnSWszVXNKZDcwa2tpcEVtWjdoM2pPalR0TmIz?=
 =?utf-8?B?TEQrRmhpUG5aVnlYMTB1aUw1QVZHSE9FTkVRejRVRysxcWdwWVQwT1FraElh?=
 =?utf-8?B?UG8rZzgySmZJQittalAzYVNBZDBpb3lBWmxNa2wrWjZUZ0ZLV240TjBibmlT?=
 =?utf-8?B?dHZUVm5HRXFoTWY2N2hPcFBsN0VOcmt1cEhwUk02YnpYQ0VlQUxVK2IvVzJD?=
 =?utf-8?B?RkVzVFRXVkZxTkUxalF2NWl3OS90OExWQWJiQlpleE95UmJOOFhpcFUxZFNx?=
 =?utf-8?B?bTJLYVgwWXoxWlJuS0dCOUJJQjFkSlVPL0d1M3hia1o1ODMzRjRhT1FlZm9s?=
 =?utf-8?B?a0dSMG1uN0J3cG1yaTBkSk93U2c0cm5pWVZGekFKVjNBdVNrUmJlSWhWM29G?=
 =?utf-8?B?a2UxVjg4b1J0bU5kMmRBakZWaVRsTTVid2YxOVNBR2xpdGtvaEZCeE9SM2t0?=
 =?utf-8?B?WnM4cHdMWmhnNEhTUitTMFBuNEFKRU5xQTQrWFUwTVE1U1lOSkhaeXRjVmJ2?=
 =?utf-8?B?Q01qY2NBMWpERGtpMWNoYmJDTkJsZlNMeDlpeEpBNTZOTnp0QjBPZmlZejBw?=
 =?utf-8?B?cVNGWDcwMFZIVnl1SndJempxajZLNHM5bGt1bHE3SCt5anZlOWNuUEdBWjdx?=
 =?utf-8?B?WFE0QnUzbkpSM3N0aFQ3K2dMNVhiVmF0dkxVMU9GT09TOGVOTVVoTWpqOXNI?=
 =?utf-8?B?M0lHN01MVERJdlNtODhleVZMYlZVa0txOE5zVkEvSU5WeTMvOGdOV1RlY1JD?=
 =?utf-8?B?SmcrYkU3NjJVVWV3bUFkWmVxaCtvQVFWcnQ4UGxoT29yVThEWFVVOWpaQUJV?=
 =?utf-8?B?VlJPY3R2YUVyOG5qT005OEJFbTRHaFhHV201b3BsTWErTDVWcm1reFo1NTNv?=
 =?utf-8?B?WnU4RWpEZ3V3bXZuaHR1eDVCVzJVV1Y2aWRTYVM2TTVWV1M0bWVZTDNaa09B?=
 =?utf-8?B?d3VnazRMUXlMc3NnQWkvRUZNT043djZMS2V5bUpwZWYzbWUvUXZzY2FQZ3Iw?=
 =?utf-8?B?eDI3NUplWC9MZ1J3ZjFqUytnSkNIMDFUUVV1cmxyT0pQa3Njd25xUzVBZzVZ?=
 =?utf-8?B?RTBVbWQ4UFRlQWhKcjdoYWVFY2dPUVh0My9sWFpmK3I0ZFhnNk9aaStIclZB?=
 =?utf-8?B?NVRqdzZkTjBscWZ4TUxTTXhXOHZsZ0FLWHNDeG8zemVybTE5NU9NYXRvbEZl?=
 =?utf-8?B?SlR0K2tWNS91VnNjQWtkUEVFNHdMQXNlVEhvUG5WZmVNOHZGUXNkT3ppVlp0?=
 =?utf-8?B?R3JPWUJKaDZuVjNsVm84aVZud2JUekJJbkxDc1pqWmR5L0RidGwxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D151F883A4E7EE498FB9C36824F4AFD4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EinuWTbKWfA1uYEh/ygIman/oIktgOZblT2zusoU382FrNy1xFim5izgXR+GmS0D1r36k3XyBbtZ5wX7fAM2HlHzDtatOZM90ciUUR+W0AWo4aqrxoeBKys6GabsiwNvLTefETMUuY8azhhXK2AqBLM7OrU3AuMTG71YzDYFvxvuseZXH0TM4J6fsYKA2Uy8yxReHLi9MkwLdiVTI2NMaqUgqg9LuYl4VMQJ6kx38Qu7RrjBHwKTn6+PohETB0Jgh4KJs3Gz+wrZ7x9X4a9gd+MxZ+dBG5KJIQ/hD9yetSxKB671GQAmCmAret0+onb0L65RPZMdMjTuRPRDvS1dFA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0350b4b-444e-4034-002e-08deabcb0bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 23:56:10.0170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hA/PmZhSf0Eg5xDM5vPYCPHtd/cOR9SwudBZeon0GFQJDvwkv7OrIHbj93Ag3/DFgG/1FS1HcXyvX87VTSWEdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA1LTA2IGF0IDE2OjAzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBUaGUgcXVlc3Rpb24gdGhlbiBiZWNvbWVzLCBkbyB3ZSBrZWVwIHBhdGNoIDEgYW5k
IGFsc28gY2xlYXIgZW5hYmxlX3BtdSBpbiB0ZHguYywNCj4gb3IgZG8gd2Uga2VlcCB0aGUgb3Jk
ZXJpbmcgYW5kIGhhdmUga3ZtX2FyY2hfaW5pdF92bSgpIGNvbnN1bWUgaGFzX3Byb3RlY3RlZF9w
bXU/DQo+IE5laXRoZXIgb25lIGlzIHBhcnRpY3VsYXJseSBhd2Vzb21lIDotLw0KDQpNYXliZSBr
ZWVwaW5nIHBhdGNoIDEgaXMgc2xpZ2h0bHkgYmV0dGVyPyAgVGhpcyBhbGxvd3MgdGhlIHZtX2lu
aXQoKSB0byB0b2dnbGUNCmFsbCB0aGUgdmFsdWVzIGFuZCBmbGFncyB0aGF0IHRoZSBkZWZhdWx0
IG9uZXMgZG9uJ3QgZml0LiAgSWYgd2UgZ28gd2l0aCBsYXR0ZXIsDQp3aGVuIHRoZXJlJ3Mgc2lt
aWxhciBjYXNlcyB3aGVyZSB3ZSBuZWVkIG1vcmUgZmxhZ3MsIHRoZW4ga3ZtX2FyY2hfaW5pdF92
bSgpDQpuZWVkcyB0byBjb25zdW1lIG1vcmUgZmxhZ3MuDQoNClRoaXMgaXMgYWxzbyBjb25zaXN0
ZW50IHdpdGggaG93IEtWTSBzZXRzIHRoZSBleGlzdGluZyBrdm0tDQo+YXJjaC5zaGFkb3dfbW1p
b192YWx1ZTogS1ZNIHNldHMgdGhlIGRlZmF1bHQgaW4ga3ZtX2FyY2hfaW5pdF92bSgpIC0+DQpr
dm1fbW11X2luaXRfdm0oKSwgYW5kIHRoZW4gVERYIGNoYW5nZXMgaXQgdG8gb3RoZXIgdmFsdWVz
IGluIHRkeF92bV9pbml0KCkuDQo=
