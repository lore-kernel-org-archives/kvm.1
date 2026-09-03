Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543E38B122;
	Thu,  3 Sep 2026 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460425; cv=fail; b=VSMtJLGOKbSCP9WeWuzKss1irQqcr8nfs1c+Yw+L5qq7bbG7tzlkTnNe97p1Ih3ARmOfnumVnmSDj9Mu6IeiZSaz0D+cpNlBfFEsaHLkZ2I+ZVHFNnaj4cc3N6+qmZe4iChj45XnE55bYa5LG7HJl2jadVsz2sPBFQp9HwDMjj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460425; c=relaxed/simple;
	bh=pPaekPJqAJQYCqRstrwGCHOvQ5/vhGKe6FKd6V5iZ0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GyUPdzxRt1CxeKXPDdcRrK/Zehtfa5t+afi3ALykWqDrLUmaDxkXP+ObGKgZPKLhUCTrVm+atYXdv4HBKtR+deR8UCfZumIQAXGoHvgwTtoyjBqDP4sxfu18OzBc5IjJLL0ep+lS9b2Lu0zllTIkvf3unUJplpOfzgI1UlYrDMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFA1FEQ+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFA1FEQ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788460422; x=1819996422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pPaekPJqAJQYCqRstrwGCHOvQ5/vhGKe6FKd6V5iZ0U=;
  b=UFA1FEQ+4K/2PztR1GSibfM6QGu6o2ayHz7KzrfZPUpSK5wVqzY8f8Jd
   KTbDMUjpcfjV/qeLREqZFGFsQzqYy116Ua0Vck17ekoj/7gh6FWN3BObj
   6AXEGuHAsIEf8BzoMQNEPGPeF42M4wby9I1FxFVBMWXrXQgtXjdjQt1oy
   xS9AuofqugIHDyihn4bvdPzt1OCnCOWTYxfVtBk8twlnWrp/mi7PMF7rC
   jBxztAiP6eeloUc7SNZUvjo0Ngpc6a0PcAR+E9zcyVuv3BLBdXmNSPyWq
   QrSraS/cwE1sBoYdrhAfaeyzHMXnYpzbBBjSUXf6sYAci8uQfRaQDzqHD
   Q==;
X-CSE-ConnectionGUID: 68Be8JD8SYWbl5PAWvvhiQ==
X-CSE-MsgGUID: rDXOkm8SSx+kAx3v3bSRmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89164091"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="89164091"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 11:33:34 -0700
X-CSE-ConnectionGUID: uJ6wH/vrTY6OsQXRItoF0w==
X-CSE-MsgGUID: MX4YxTVSQl6BaclbDx49Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="271768842"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 11:33:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 11:33:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 11:33:33 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 11:33:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvYRpXSkIFweaXKzxnsIj31a5ecEXGQJx5tffSwQHLKlg5VWWw9ykEgZ+XIKgImq3xjbO6/8ilxABsD8SGYnEVbbBoyLUVZsZi0L7veEGXhapxCcKnCN6SVC7GmpLiLNRzyWFX8LYatguqL+zRHohlwm014UwaK/RtfLm6EOi7C/zqBrd4odJhLnoau2Pd50D/Vom/+0Zhtg5HaRBfn6ckYXl74oEJlxy0s49e5U5kDxulbgsFdLG3CBUUijqpv/T7YokgjCZJNsOqaKwJ+QyEyzpm97q1At1iisTIHogXbyd1iUWi6H0WOdBTy/smwC/lndkvBkoECkAD8TtOPUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPaekPJqAJQYCqRstrwGCHOvQ5/vhGKe6FKd6V5iZ0U=;
 b=SNNw6HOz4vLJT0ecmKfuQuHdPzSgFjUKlM3hxh2BTHZcpXjyEeDC/mpdPVUwEjn8YCQl5KIsNgvBmD2QxiC9wPksYMnLqD0K4HQ+Ci6cBMJ98/SvXHon4gxw9deyZABBUCHyuFcl7zZvz9pce+lPiOTbyj+X+MDVOmcQLi3j7JMxO232NEXxWc0Kr2LZjIdtP/ldmV9mddcYI21rDYiTMmEdhtJv91k9HXDGnlxIggI44OB1U3h9FMasDrNFV1HJ26h/xKXmzm+gnBniGb8L1XeeKknv8/Kg7Ju9pwDAwz1qBvwVkoLQZ0KSJR62/BmIds443sxVysjs1P9/jFJB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA3PR11MB452602.namprd11.prod.outlook.com (2603:10b6:208:54a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 18:33:25 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 18:33:25 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"hongyu.ning@linux.intel.com" <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH v10 04/11] x86/virt/tdx: Allocate refcounts for Dynamic
 PAMT memory
Thread-Topic: [PATCH v10 04/11] x86/virt/tdx: Allocate refcounts for Dynamic
 PAMT memory
Thread-Index: AQHdO0a+AoxqLEU3aUycAxT6czg5w7a8+6WAgAAzNQA=
Date: Thu, 3 Sep 2026 18:33:25 +0000
Message-ID: <1a823329596d449e6f4e2c224cfc28b01b4f9cab.camel@intel.com>
References: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
	 <20260903015113.93343-5-rick.p.edgecombe@intel.com>
	 <a8243fed-c2ee-4032-a273-a5737e270889@intel.com>
In-Reply-To: <a8243fed-c2ee-4032-a273-a5737e270889@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA3PR11MB452602:EE_
x-ms-office365-filtering-correlation-id: 57d7827c-cd40-4588-c786-08df09e9d73c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: jtHz1CsxEBf9SEDHsSslEbWevH4ZYXhRAPH+m8ePQM7xYf9B4xcKUi34Ty3vc2zs9/ItdxAeVIN2wz+A/p5nj9biREo7iS3DXgNQa5FPILgGX70ofWyJpybmQSnfUqkgj1WDMZ4cZLK01lTKrf1GMgaPfFzrISxmqaAMXD3fQbNdh0KVWVGKJBUVEI/Vwh91rb6H5yl0L8im8bj8voVocdzjBlkZmClYmtI3ghOXwIyQ7qi+6uXexK3M5kVQpegDyx6Af+2aVxKIiydghks3Ka1ysf1zDJbGHQfqywGtxKcWvrPP76JycCgVp6onc/1AxmG/5bCh0Q/RZ0QgABwAL4+r18lINHJn6pWpZWkM01nyWzMH0t4j/vYIFrB9MiqMDxehCwwopwrRIkOI6xedfpqafXNE17k3XqbAlSYloQR4/i+A6Q/g7VGWyjNzzkrlC3RFW1srSUQ7NGWvWNOcBbFcwWTATE0LoT9h2lL1aMtBxe7JmYRFpRzPSPz3lA2p6MLY/BRYRnAYDcUNryzkDifsJCFr0dppbmLZtGEUYo7IewvpmPKkqPBOFP0Y+CWm2LyyzcIf+AhKFqZqOVgf+JeX3YpnV6u2NrSnhy0RghDZKON3NXoQZ9Ay9+0HjU3xn3AjWohMxW7qjLQkw4wvXZjwle84nENUUTY0zRvn+Wip3+oTXKOGR8C7kjA/mF4yYWBwQ2ouChplzQyPHg2dfjFE7K85yIxcY+kWBzt4HfqTL9vuboHv7dkKYqXUEoXB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWlvbmszL1I3YWlKN29yclloUVkyOFIxN200aEVHUTlyRk5QNmNUMVd3czND?=
 =?utf-8?B?TUhqV3VNS2l4OUhtSlliTkYxQVBGQ2RwNGc0OS8xSE9tWnowbjRjdFBrY2xN?=
 =?utf-8?B?ZUtvZVJhVURCMmZxSDVTV0Jjb0hVeVcyV3ZleU9FVnlRRTErcHlNTmEwRjRs?=
 =?utf-8?B?SXF4aHJWd1B1ajcwcGpYdVVZWkFzY2o5NlozNTI5a01ORWYxUHVzRUVPVXZx?=
 =?utf-8?B?WnpYcUp2dW9aT0RpcmJCTUEyNVpwS3pCNnpIR3FMc0xmZURINW5MRVJYbWMz?=
 =?utf-8?B?UmVJMTdJUGxIS3AwYVVvbWY2aFNkY0d1Z2s2YnIySy9JQnpFOGpGOVhXdnpK?=
 =?utf-8?B?M21UekxXcmQwK21LTUVVMC8xdEZ4ZTkzWVpFWU1PZ1h0cDh2bWVWQzFERGh1?=
 =?utf-8?B?MVJOWXBEZG5QbmR4YmVYNklRbGZHQkk2Q1lqZ0ZmczQ1aGFzaW1MMjdRdUhk?=
 =?utf-8?B?aHdPV1ROd2gvUVFFRlNSMG9qR1NpbnpEWjVVRGZuOVpoQkJwNUJCRnlEeVUv?=
 =?utf-8?B?TGtIb2lwai9OQlEwSU1BTEprVXdlYjVrN05BTjJTMFlxYUt0UGhhYkd3SmJt?=
 =?utf-8?B?YVlZN3dXLzFxdXZZZk9UeHYyRVNhQkNacnNLZHNLRWhLaG4yS1gwWENXQitk?=
 =?utf-8?B?ZDV3cjR4YlhLUHQ2Z0ZPaE1NdkJvbGpjdlp2eGtJTFpCU1kvelVXclN3M0p0?=
 =?utf-8?B?aEg1WkQ1S1lVMm5PbEZQNmdWSjEyR004Y1REQjMra0h0SlU4NDdFc3VXcWMv?=
 =?utf-8?B?UXBVb01xbjBFRGFkRXRHQ2haQmpkY3IyVmpuK2Q0elZrckpRWW5lQUxwV1dp?=
 =?utf-8?B?eFFQMnNyUXUrc2dFZUsxN3laUE9NWVcyU1R3R29YRWhMMGRQYXBwV3JlR3lQ?=
 =?utf-8?B?S01ra1VadGIzWDB4aFlyeU10WHJ6WU9USFh5L1B0Z3lYRG0wZ1BXd1dTeFdv?=
 =?utf-8?B?V1g5V25sWW9iQmxJdnVHaFNoZzl3cXlNbUtQbmhhMUVoRWhtNElqTW9nU2tX?=
 =?utf-8?B?ekdCbHE4L2l3WkhackZnZHRkRGRDMEZiNmdjZnB0VkhoYXZOYXZnV0doMDZO?=
 =?utf-8?B?TlZqMjVPTUNpL0s4MDdsTVNRWDJpaHp0c1VIcTN6aEMvbWdmc2NCc3YyblJZ?=
 =?utf-8?B?aVN4ekJMZVI3RWd0eGJXbE5LdmhBbEtHc1pwRlZGQUErR0hzWFFTTUM3dDJw?=
 =?utf-8?B?VVVtS3BQbDlmSEJ0ZkxDVTBmUXZaU1kxZ3ZIY0NYUk03VnRROWpuRzlxeVQx?=
 =?utf-8?B?N0tGbkFpdjNYSTZoRDN2QjFva2czNHRwc2twS0VNc3dXMTFyc0FFRDNSeldo?=
 =?utf-8?B?bkFLU1F2M0ZKU1QrRTlEVlkvc1RuZk5zUFROZ2V5dlordkF1T3kyWEx3WWpt?=
 =?utf-8?B?eG1SR1R1RVNpOEhjeVdZdUZZbEl3dERqd2s4QzdpQ2MzTWJDY3RhOWc5d2ND?=
 =?utf-8?B?dlJxSVBFK21ScFR3MkVEbGwrTHV4dFc4SHFHc0owNmpSSGtDZStpeTkrbEN6?=
 =?utf-8?B?M2NmRDZPb1BtTzIrVll2Y0l3ekx0QXlKZ09PRlZnV0tzalg3dlNLN2FiSmtV?=
 =?utf-8?B?dlJYYU9KaGlqdWpJTWh3dWF3NWdSZThkdmRZTnZZRUx4ejk4M1pQM0dCK1Fm?=
 =?utf-8?B?Ulo0MW9VMWhHOWlnMjliazBISURCQUs4R2wvcVM2YUNqWHhtWlV2c1k4YWEz?=
 =?utf-8?B?WjZYZkw1ZlplS1c3ZUl6WEhEc2pKSEdrTkV3RXV3eW9OaVdydURIeGRNSXh6?=
 =?utf-8?B?cXJTdU5sb2NxWXAyV0VNTFZ6RUNwSVhiYXpVV3A4RUlhZzU1MW1xVll5TWRi?=
 =?utf-8?B?SDJOc0creHBmcXlUQndYT1hDWHZIekVKb0lHOEtSUEV3WEJNVUhiYzAyRkVR?=
 =?utf-8?B?ZmVUbkJtOTBTTEtzVE94YzF0WHNRclROWUh2UWZnNmpKdGNjbmllNVNJLzlM?=
 =?utf-8?B?VDdIMEIvQnJrVDFCSHdneFRydm5vRE94Z3lrS1ZEeDB2YUtneWJsVmYyUW5J?=
 =?utf-8?B?VzJjcE9od1VzazR1Q2FJN0ZPSmNhTkMwZ3FXYml2R1F1Y0pkZSs4bnFscFZV?=
 =?utf-8?B?SVNBNVEyVzhaZzRQR1BvRTJyRW9Wc0hOV05ZdmlueUFDZlVQeENtU3puSHht?=
 =?utf-8?B?YXp6QzNFN0txQ1FxdG9FREFqWXgrM1NKMk9wZFA4bk9naFN2ZTFNeFVVT0Vs?=
 =?utf-8?B?Q3YxWUs3OEdObE1vSnIwWTArK2tTc0hubU9RS0h0Q01kSjRiL3dyNDlPWjA0?=
 =?utf-8?B?QlZaakZtN1Y0eW1yNG1uUlFKNDdhUC9EMjZsVGxpMWhUZFNNYWVESDVkWDls?=
 =?utf-8?B?UlJWcEpCZjJxNGRVZTJVVmE5N3JCeXp1Zk1hUnpmMExicE5qZzJTVnoycnps?=
 =?utf-8?Q?um7Pp0YXBe8dWk/k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5512AAC237DA7A45B112328BC97C5520@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aV3PJ9DGL+zEVFywXJc4siibCOMxsbRIrf+ME9FOfn+e2d4+CawKzqdFfWf6skZKarQXdO+zGXw3eq4ChlDumbUEU3jvbwvkRzOs6vcHNDeQLoZv5HqFy5dj5c0IS33Y6hO4n2Ize0WZhz2u0VTLklqjDNrO6DH0cz6jXNKuuiNpYTa1QQTc9BamGQ/g0q5FM3MskrAxhM5jFg1DC5atynZJF9up39Sqs3ISOWzRaooA6EAv9VwLcjmenEdinLJUbFor+US360st5WvrkkMAOncK1aBivXCRfRV3rMr+tW/twg18DAVMh6oO+41JHLbRYHX6vaH0rDeW8+9B13RKbA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d7827c-cd40-4588-c786-08df09e9d73c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 18:33:25.2862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BwVh3nBvtQVipBW1ha4rBYLXJ9NTGvxQdXj46YyI3No0KzgFQr0fPhTjBQj+aa2VWRNV21uKaB4CRm1rkRODpoQvLt2xjb0IRF0ik67MRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB452602
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTAzIGF0IDA4OjMwIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOS8yLzI2IDE4OjUxLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiBAQCAtMjE1OSw3ICsy
MjEwLDcgQEAgc3RhdGljIHZvaWQgX190ZHhfcGFtdF9wdXQoa3ZtX3Bmbl90IHBmbikNCj4gPiDC
oMKgICogVGhpcyBmdW5jdGlvbiBpcyBjdXJyZW50bHkgb25seSBzYWZlIHRvIGNhbGwgb25jZS4g
QW5kIG5vdCBzYWZlIHRvIGNhbGwNCj4gPiDCoMKgICogaWYgX190ZHhfcGFtdF9nZXQoKSBpcyBj
YWxsZWQgYmVmb3JlIG9yIGFmdGVyLg0KPiA+IMKgwqAgKi8NCj4gPiAtc3RhdGljIHN0cnVjdCBw
YWdlICogX19tYXliZV91bnVzZWQgX190ZHhfYWxsb2NfY29udHJvbF9wYWdlKHZvaWQpDQo+ID4g
K3N0YXRpYyBfX21heWJlX3VudXNlZCBzdHJ1Y3QgcGFnZSAqX190ZHhfYWxsb2NfY29udHJvbF9w
YWdlKHZvaWQpDQo+ID4gwqAgew0KPiA+IMKgwqAJc3RydWN0IHBhZ2UgKnBhZ2U7DQo+ID4gwqAg
DQo+ID4gQEAgLTIxODQsNyArMjIzNSw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqIF9fbWF5YmVf
dW51c2VkIF9fdGR4X2FsbG9jX2NvbnRyb2xfcGFnZSh2b2lkKQ0KPiA+IMKgwqAgKiBpdCwgYW5k
IG5vIG90aGVyIHBhZ2VzIGluIHRoZSBhbGlnbmVkIDJNQiBwaHlzaWNhbCByZWdpb24gd2lsbA0K
PiA+IMKgwqAgKiBzdGlsbCBuZWVkIHRoZSBiYWNraW5nLg0KPiA+IMKgwqAgKi8NCj4gPiAtc3Rh
dGljIHZvaWQgX19tYXliZV91bnVzZWQgX190ZHhfZnJlZV9jb250cm9sX3BhZ2Uoc3RydWN0IHBh
Z2UgKnBhZ2UpDQo+ID4gK3N0YXRpYyBfX21heWJlX3VudXNlZCB2b2lkIF9fdGR4X2ZyZWVfY29u
dHJvbF9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KPiA+IMKgIHsNCj4gDQo+IFdoYXQncyB3aXRo
IGFsbCB0aGUgX19tYXliZV91bnVzZWQgb3JkZXIgZmxpcHBpbmc/DQoNCk9vcHMsIGl0IHdhcyBh
cHBsaWVkIHRvIHRoZSB3cm9uZyBwYXRjaC4gU2hvdWxkIGJlIHRoZSBwcmV2aW91cyBvbmUuDQoN
CldoaWxlIGFwcGx5aW5nIHNvbWUgb3RoZXIgY2hhbmdlcyBpbiB0aGUgbWlkZGxlIG9mIHRoZSBz
ZXJpZXMsIEkgZ290IGJ1aWxkDQp3YXJuaW5nIG9uIHRoZSBvcmRlciBvZiB0aGUgYXR0cmlidXRl
IGFuZCB0aGUgcmVzdCBvZiB0aGUgc2lnbmF0dXJlIGJlaW5nIHdyb25nLg0KU29tZWhvdyB0aGUg
Q0kgYmlzZWN0YWJpbGl0eSB0ZXN0IG1pc3NlZCBpdC4gVGhlbiBJIGFwcGxpZWQgdGhlIGNoYW5n
ZSB0byB0aGUNCndyb25nIHBhdGNoLg0K
