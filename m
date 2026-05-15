Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BA43FDC0F;
	Fri, 15 May 2026 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870691; cv=fail; b=i42pLGvUHwo+/1HQGwDaBv02tejSj4kpcOSIp6d8Mb+4KwFN60V4QIqPTfzw4oZoSzr04vvNMDHgSmOSh38JBT4SQpM+98rPzjV6ry1BWsOESsLusokEdKZ2plUmGIwfPIoa+uaRHQsEXFkJKE7QeYapu8KO6djBaKKPnIzhl4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870691; c=relaxed/simple;
	bh=0WsO1sGjkniWPg+ztH4QJmeXKSiQSnAqNmB4ssHzObk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k0Ls9oJPIfZz9O528sUvuefWWXQZLSiPTYNpmMXIkaA86UJWaRIhOevsWsBa2FH2xF2Jd7ujkedxJd315bV7wlxsL0HEi0RPbBz9nJQCbAkgSWWfVCb+uNZtPlnFC+4TI3jiRktEHKpTVyw8ZJZDY7DB7Cj00v/u02PIy0oMhOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrR7dh7T; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrR7dh7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778870686; x=1810406686;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0WsO1sGjkniWPg+ztH4QJmeXKSiQSnAqNmB4ssHzObk=;
  b=WrR7dh7T9UG1v1Wz2x80hSgiGJ3+nL6akBSIVIoE/vjZP48KlJJh0nh/
   /0eLBQXqXxg28u2HcdSg/j7fNkot8g8I6M8J6Srye9prf4UJYMsJHdb7T
   b/ATqGcz4WqR0HKh9VmfYQzp5tJalPiI9SfrO2VsT1D4+0f6yr0OT4umk
   /h9YFM7FCXHHbE/9v2MAXUkmdtDf9ggCkUnNOifCeab8GhUrh7DtF7981
   3EURTDbCa2E2B9/ZFTXcf+O6v97BiG6ejfw5nwlIK51VfaFMcdgG0gTi4
   keYr4p1FKjjzidr2LhHov0Ke2g2hQHqPVezitbR37us0HPP7m/YKopejC
   Q==;
X-CSE-ConnectionGUID: Os0m8YgsQhi9Tb4tdzjwQA==
X-CSE-MsgGUID: KHP/bl0NSSWMI7UWzn/2YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="97404207"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="97404207"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:44:40 -0700
X-CSE-ConnectionGUID: KBYv1fGVTyieP5rLF5bLXQ==
X-CSE-MsgGUID: 0TFA0y/7Q/W5mTTp35zYqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="234512472"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:44:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 11:44:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 15 May 2026 11:44:40 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 11:44:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH0ZF0peq+sbRf1BuVnytU72xTqK//4P7cXwhl2x/Lm/ZE3GPzle6XcDcYdtC/XfsXrGLp3kNN2E+O9dC0S8wsGssIU10rjk+Qr8mMaaZ04iI8I5H0ycU2gF8N8WKAJ3Y4+FNegT4bAfSNkEdrKHrSvNnNLGvyTyUyBTbkBA3mXg2o+cwE5w4XEYUUxs2EQkh8s3laNxC5XXrXms8BdbqYyFzFi9J8c/HfEoc9NW8c6OC14ToTI6RjEkksXIR/2c1Ia47b1nm+YK0hpYz84kOtaztZmSQ25wFLaGWCxdAtjaiZTng7DeijnX0L1AvILi53xqKoGfLG9PVCHfiqsuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WsO1sGjkniWPg+ztH4QJmeXKSiQSnAqNmB4ssHzObk=;
 b=OxQaqDb2A61yw6F0+Ej0vQ3gfiJh73ueI17G8SzbWMzxOLGQlxb07Krc5lSex9jcLhg+CKCGM24ziX8gUK6enPe7PDyPlOLtMYv+2xyXiweM1Vyf+ya6+XIywTDoTfHz09FpUdOSWxrdOvQtgWSlpRwivzS2OMW4tTNsNt1q5SMGGGu9tQfL+fasUfEVedaQIZyrO66i2WlRNX0qIo8XB2sVjEerZv5IXDIFqoRZOrBJwdXL8h0dYQ67cyHdbNGtumC7ly+h9qpW+rao0l8P20LCnFI/PbNwwng9Ny41equ9qGXhKZFyFr4LRfWWpZZgqotVUb8bGJWhCekVSj7HcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3018.namprd11.prod.outlook.com (2603:10b6:5:68::11) by
 LV4PR11MB9516.namprd11.prod.outlook.com (2603:10b6:408:2dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 18:44:35 +0000
Received: from DM6PR11MB3018.namprd11.prod.outlook.com
 ([fe80::d5a2:c5ee:1227:9d1f]) by DM6PR11MB3018.namprd11.prod.outlook.com
 ([fe80::d5a2:c5ee:1227:9d1f%6]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 18:44:35 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Hansen, Dave" <dave.hansen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "Shahar, Sagi" <sagis@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 11/23] x86/virt/seamldr: Allocate and populate a module
 update request
Thread-Topic: [PATCH v9 11/23] x86/virt/seamldr: Allocate and populate a
 module update request
Thread-Index: AQHc4urZ5clLhLz/KkOaBOTVNf2GUrYPaksAgAAFngA=
Date: Fri, 15 May 2026 18:44:35 +0000
Message-ID: <ec32e59834ffa585a4145e51253f84e134758c16.camel@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
	 <20260513151045.1420990-12-chao.gao@intel.com>
	 <7d7fff5a-53a5-439e-9ff8-dcbd97f473cd@intel.com>
In-Reply-To: <7d7fff5a-53a5-439e-9ff8-dcbd97f473cd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3018:EE_|LV4PR11MB9516:EE_
x-ms-office365-filtering-correlation-id: 71413576-d5e5-415c-6b10-08deb2b202ef
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|4143699003|38070700021|18002099003|22082099003|11063799003|56012099003;
x-microsoft-antispam-message-info: dKcm0IHSVL89cBEbD8ug1D1kO5aBWT6jR+ASyN4tgfOW6nSUXqKi4aiimkeiiQeD5rK8immyr1ib/XIQpldVbzibQNQYcT9njYCmYGHU5IHvhzakUGEpYblOIJLijr8BflOIFAWpaTdLnBDMrN9pgn3MTSF5KHPwKHsMzhZRPIcz0XnKuwgtP2PzFFNUxWM8k5zJJ6nhnKD8yZ+2bzQRk/kmxKf3upxSdb5UrRLIE8gmLlLlFecgVyNXOUlHRLE1x4QHLjcLx3ZMjQlphg6j9EWYRnHvI76JmrK2qEVcM/3OomKDAUqL9mmZ1QevYoRJyozxu7RMgmrTsaBaAwBIVeiwYCt3srpedA0WXtv3U1lnxDuYRJ+KvUBbTxkoBr4y4ze0oL7YZW8gss2LyvsuKEJcvMqK7Jvrc1tTmN5eNU00hiQAgttZxznxA9synhYQvBYADCQQ/Jbirw8Sl657KoblrMGY3asaw+mjQ+Wuww7GDHd7ajpHx4oMeY8anN/64nTch3F85LnuxjhSMlWsvQIPq9GPi9hW1KZz9WciCoxVdF3ntaqsX6wzOI7F+GJIYP6D3k3aFUru3iudbFeYsMtR1obYxbDQ4conhElBKjzcKE9/MovtoflN4UePwKdwdLl/+EJxAogNJzQZ6Jp0uobqb3QmGufTuvw6ei4C5I3PRvBM+xnTfMc7ncxypsB36roePtMpTff1rQh/difKYRYR0kVSeAXK9QYpGuZb/2CYIItpVLvBtOo6jW1GGe3f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(4143699003)(38070700021)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFdQTElnRDNid3l0UEZTTHFaNFlralZ3YXFPeThmNUYzVDE2Tzc3WFVRUTRT?=
 =?utf-8?B?Y1laRkNRVmI5V1NKRGtTbllGeTZZK0U3d2pGNjVXTi9JYnA2YTF0MEhuREJZ?=
 =?utf-8?B?bDV2S29LWDdhajY3T0hMWXF0eWZUaGFtZzRVMmxTSno1MThCZDBWbkxlNFZQ?=
 =?utf-8?B?S200TlRRY3FJZmdHdEdLWXk2VC9oZzRhcWJmVHc0cjNIK1p5UGF2YlNZdVVO?=
 =?utf-8?B?Mm94SEtXcXRMTzlMUnk4NnhxcDcxOUlqbSs0MUVCMy9vZmJvOWY5NTU2NURF?=
 =?utf-8?B?Z1QrTTRkNkVnUHZwRkI1SjdHbTRYRlE5d1NaeEZrWnEwRThzU0lGWSsxdm5J?=
 =?utf-8?B?cGxuaXk0YUxXT2wxS0xmRUhKMm9WdkdHejVXblNRQUR0N0xISmliZUNmdnps?=
 =?utf-8?B?SkxIeUVYRnBvNnNmQ1NRN3VSLzBpWlNKYkZlSjJKMEd5dTNtTVEzMjd4SVVs?=
 =?utf-8?B?bEhuOHV4MlJINU1iQ3RjaWJ3alA5ZTR0Q2I3bUNSVWtacllyVHNJVHcwVjJQ?=
 =?utf-8?B?MnB6VGN1cnlXYW9mbkQzMWtBYTZCVFdjOEYxdDRidkZTaVphakhielNqUXBZ?=
 =?utf-8?B?NU9VckNDZVlyTVJJY1h6SHlOQlR2d2VlMFZsZ25abzRhZHYrcG9yTTJCazhr?=
 =?utf-8?B?OTVQWTdaTVF2cjlGWDhxMGUyd3N3c0xKUFJSNkJXRTZyb1FMeUZKc1I0L2VU?=
 =?utf-8?B?U2N4cjNwWTVva3VyampmUzVlcGxKU2xZNGwvV3R6clY2K0NpNWIraEdaVWhn?=
 =?utf-8?B?WFdPSXZaZ1Y3akJyekhIR2tJNnFoMGxJQjV3S1VDT2k5YzFyQlo1cWJ5WXV4?=
 =?utf-8?B?aXlpQnd5V25GVkFwSTBHYVU4UnpDa0tDNW9vV05NdU43aTZBaEV4SDgwRnBh?=
 =?utf-8?B?ME9LMDdSYzRXS2sxdkFraStMTTdvb3dHWkdzOStncVVPTEQ3VmdnTVBiUm00?=
 =?utf-8?B?Z0FueGZpS1lsTGdaLzB6QTBXYW9HcXovSFpqNk0yWEFyWmU5ZkMvUFlCdVpE?=
 =?utf-8?B?Nnh6cXRzV1BPQzgrQmM5RzF1UVVWMWkxWmVGeW5UalRjYnZTUjArQ1NtOGhs?=
 =?utf-8?B?UUV5QUkvRVMvV2prRlNIR01seE9SUUhJUEdsdGJDKzRVdnpDTjkrK256alVl?=
 =?utf-8?B?K1QyamZkN2tPWlYwN3dSZ2pCalJDc3lQNVNmWVdId0hQNFhHV0FGczB5SXlq?=
 =?utf-8?B?Yjh2NWNDWHJZSFZDQ0owZ0NtZC9KQ3E1Q1hTV0NRTnRvTXY3ZTluSm95Q1BU?=
 =?utf-8?B?SVA3ZC8wSVFkZTNLK2w3amhaWGV5Vm1rQzFycytjQ1hhTzdHTTJId2xWKytX?=
 =?utf-8?B?SS96OXhBaXVtUTV3YXlZMWkzVEI4UkJSMFpNczcyWGF1UmhDZDhuUFFQMjEx?=
 =?utf-8?B?MXp0MUI1ZC9Hc1JrL3BtR2hLMGxYb2FySHBQZ3lqbnk2V1ZwU2ovdFoycHVy?=
 =?utf-8?B?dTgyRnI3ald0ZC9VNnhBd0wzQUxZSmZ4dU9DNENPalYwVnVQb3hxNi94VWg3?=
 =?utf-8?B?MVhMQXZIUFBWMDkvQlFiRDZ6YzFXRkpoN0M4azZDeTFtSm1ScWF4L1U4OHlM?=
 =?utf-8?B?cVNlMW5SWmxzV2wrN2h3ek5RN2JpeS82N1p6WXVxc2ZWdm9HTFd4NUhhTUk1?=
 =?utf-8?B?czYxdTZJSW03RlY0YS9JcFBscUVoV1N4Tm9zZ0kwTm83YUJSa1VuWlRNTHBs?=
 =?utf-8?B?eERubmtuaDA1ZkUwZ1VuUXdUWkdkVGtBem9FbFdZTVVOSUdxckNvQ2dEbDIz?=
 =?utf-8?B?QXdOQjI0SGFFdkljR2F1SlhmUmpwdzUrODBaUTZVZW9PNVVNd3JsaGFRNUhU?=
 =?utf-8?B?WmhPZWYyaFpqR2hWbEw0QnJOTW9IeTBDZFRYWnR5VWhDN1BObVo5S2djdkdT?=
 =?utf-8?B?U0JRUTgza2xSOStiUDNiT3o5enNnbGhiSmlUenhOZnIvQktHUXIzUG56WFZS?=
 =?utf-8?B?K09ETk55eW9KeW1QN0twWCtGeDgzQmROQTNsc0VBUzFKVFJSajEydVhlazBz?=
 =?utf-8?B?WFM2M0lFdE5kUUVEMXJhVDJhRzkyZ295QmgwcGJGTVBqbUhrUzNOTGN5ZU4w?=
 =?utf-8?B?d1psUFVKb2szajdVUnZneXJGZmNKTzZmQUU0YTdseGlRNUM3QkFOTE8zczRS?=
 =?utf-8?B?Yng4YVFyT2RUSm5xcHV3MUdoNnY4RFVVcWlFYytCVFhXQjFySHBZR0dQU01o?=
 =?utf-8?B?UzRVNDN4aUV3cXQwK0FNWFFxZFBGSDlkYlp5RmJLN3lQd25DREpzYlZOY3c5?=
 =?utf-8?B?b0tpa2VKMm9NUzQyL0ZSbCt3RGZ1REdHWk5kSHFDSnd6SER5T09nMXdsb0tP?=
 =?utf-8?B?WUc2M3RDQnNRRytPbkFLd0VtbzVxUDJXbW1Mc1pEdngxRzQ5SU9GREFmZXpW?=
 =?utf-8?Q?4YL/c4cjPgYedBBU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FDDA048A93E7B40B5BC76A933104F85@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gJVZJOv99SBQwl8EOMTjtWAKm8BfP712Salk18tg03CEBGC4H63g0lXHfaObw3UvM8R1poorjQm6QbQD8IhgUB6FW4rbWr8JB29PL+fdbtksS1AzQsRSHHVoxyyfUeFhXajWB0tNcRbJux/2082iGXWMOnQwRLsQ6N2t6ti4dcGHapHJ4RUD9xA320wJTUp5rbFeLUCWiDCeeWYRh6tTBW+CfCCDufB34VgA4vyxRQM2RMbyGhNjtSAUL1K7DYA0GbUAhipvbfBxj1aXV817F6sxhv9jnY9tRJ9XQ1vwa68DrIPRU3zn/aS4VkbMQAmszMDawD4e4TRUyizzHJT2fw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71413576-d5e5-415c-6b10-08deb2b202ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 18:44:35.5902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2NsgJSPXhHv9EOdH7qWZpOIdZ5kDrRuWf2Mw4qN3o0K5zpHwjUCjxc6i4x76eJLRn8ip6sFboE8IN1bksKbEYBddt41JG0A85EcRvMxvnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9516
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTE1IGF0IDExOjI0IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
PiArCS8qIENoZWNrIHRoZSBjYWxjdWxhdGVkIHBheWxvYWQgc2l6ZSBhZ2FpbnN0IHRoZSBkYXRh
IHNpemUuICovDQo+ID4gKwlpZiAoSEVBREVSX1NJWkUgKyBzaWdzdHJ1Y3RfbGVuICsgbW9kdWxl
X2xlbiAhPSBzaXplKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCS8qDQo+
ID4gKwkgKiBEb24ndCBjYXJlIGFib3V0IHVzZXIgcGFzc2luZyB0aGUgd3JvbmcgZmlsZSwgYnV0
IHByb3RlY3QNCj4gPiArCSAqIGtlcm5lbCBBQkkgYnkgcHJldmVudGluZyBhY2NlcHRpbmcgZ2Fy
YmFnZS4NCj4gPiArCSAqLw0KPiANCj4gSG93IGRvZXMgdGhpcyAicHJvdGVjdCBrZXJuZWwgQUJJ
Ij8NCg0KSSB0aGluayBpdCBtZWFucyB0byBub3QgYWxsb3cgdmFsdWVzIGluIHRoYXQgZmllbGQg
aW4gY2FzZSB0aGUga2VybmVsIHdhbnRzIHRvDQptYWtlIHRoZW0gbWVhbiBzb21ldGhpbmcgbmV3
LCBsYXRlci4NCg==
