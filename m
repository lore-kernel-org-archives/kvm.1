Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247111CAA68;
	Fri, 26 Jun 2026 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434343; cv=fail; b=ZPUjMbXshbc71rEhyMCKlRIYQtN1/z3DE4mIKXqp+7u2xFQRWhmqcEims2PNhJ5Z7e2jnoDzlpFsLXnmvWnGE1nuN8iXglyhalXOfweRZvNvny2n1pre1eoEJjBhR8+1euRxZ5vqNVAUMGMb62CvZPVNdLh+LL22IvwfIU3hOWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434343; c=relaxed/simple;
	bh=/0Sh7jQHJWrZQ8aArTJHuAByYCZdXexBC1gzCVMHt3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U9VRM1+8TJw3k5CtyyeYIzMzHLt5SP/HpUW/LpkiK4Pvk8LiMVj9+ig+btfrndIy25Z7CGlWnKcGoRgB12johTszD9v0fpsrAlCiUZiHyYg3VqIf9QDuJkbz6lhQynv603gQEch1FYsTWZtB8vgu7pwqzivnb2TSUjUm8RR2weI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTpj7yjS; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTpj7yjS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782434342; x=1813970342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/0Sh7jQHJWrZQ8aArTJHuAByYCZdXexBC1gzCVMHt3U=;
  b=WTpj7yjSpsfK6wGAjevNM+0CfMWyT4PDxXMgn+QVj0Nl536viIxwMWrr
   xAlEYqgAkTcDMwsCTsGh5MH4rHRTdYt4YPnizZgKq0EZqk4jkXwmF7Ifg
   lq/2OniFlfI7EX2vyFvHondeCNs/AJTRLyR1SFVEh0P6OSVxQfti860Gm
   fNXPntUb+OUDagzbbpFWczy0QIK1WPPr5C5GquJEwiW4TEpfuFqjlvFuh
   0lZn7oy/QPm9hQWdgtcBVC9XxG+hrbeZYiU5jv+Gyb9MzPw7M4tuYVlk+
   Qz1vHRennbMl/pKge/7L4Wp8bWvKinJIAWpzrb5JGnGqBB8I/Pb0Z+wUv
   Q==;
X-CSE-ConnectionGUID: hhVA4q+YSryOoo8sxaqoHg==
X-CSE-MsgGUID: LTGgvqUzRkq062nwDF6Kfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83327346"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="83327346"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:39:02 -0700
X-CSE-ConnectionGUID: jBZJwWTZT1KvZDFKFqWFoQ==
X-CSE-MsgGUID: ltZyB9YpRoChvg5jX5h4fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="255178412"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:39:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:39:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 17:39:01 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs3ME1JceLllKkG3nV8WcENZWoH6yZc/5UXvGCHD2gOIacWVkjJwLdHF0vMWOaiyY+oUxwlfLm9BZ2+bOHIPIGZVIPXRwkLileQjkfH+dbBNTnWP7r2eO/mrnaW4h682r2ANyJaCMsu3sgjraOsb2+0kmyCc9vCn5HxHcip/bZJLUwmYbTASpv/Q4R5mnbiWgswmqevjfpSpJnl6pJ074TTmwoQXl4k4u5JkY5Fz6FtiYEi8zBMq+shqjls/NA7YP5MPUmMoi/2UHykcBohJBZbc4T0ZzC0G6pjn5WS2SgZmDkKzKyzk9uiGT1MihU8hfZP1qjiOUgcAeut6KKqoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0Sh7jQHJWrZQ8aArTJHuAByYCZdXexBC1gzCVMHt3U=;
 b=odb4hwG5aJVTnhSNa4mt6Euus4PHot4F21ZR3GN8++tP7VDMmNET7rbZE/PS6f3fYAXjcna+GxvSGkTL66LKqXy4LGBerOHkHcDXwueravnkGNrFPhObt8HrTuFFNFzRrSPIeJR0WlfqkbCxgQ0fnVGf7irNOnvMcOp32NXDvL2HdAVTI9QhOvwKdxeugtdrs3JsEcGLBUfcNGL9NPDFi4Nw3ObfBzMrOB1AC3qYSvBC9uXHEq3kgdZz+OBo8CO5npfUb/0YG3slDJpkeDCaVcFHRlFWhXNCFF+zDXV2FcC7fBnRX2ZPCo55m0lYpE9q40E1ur63GG8OsDpsGxKMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH7PR11MB6450.namprd11.prod.outlook.com (2603:10b6:510:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 00:38:58 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 00:38:58 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH 5/9] KVM: x86: Move KVM_GUESTDBG_VALID_MASK from
 kvm_host.h => x86.c
Thread-Topic: [PATCH 5/9] KVM: x86: Move KVM_GUESTDBG_VALID_MASK from
 kvm_host.h => x86.c
Thread-Index: AQHdBO6x81qpzH7Ab02JdEGY+hx/drZP/nkA
Date: Fri, 26 Jun 2026 00:38:58 +0000
Message-ID: <ae56ed2d5309e32550e4f536d20e9c75554396c1.camel@intel.com>
References: <20260625220450.3354415-1-seanjc@google.com>
	 <20260625220450.3354415-6-seanjc@google.com>
In-Reply-To: <20260625220450.3354415-6-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH7PR11MB6450:EE_
x-ms-office365-filtering-correlation-id: ffe23f34-b5ae-4fec-c29c-08ded31b4f67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: QXOyfPfwv0Er7xwQVqorXSn+tU3GpDVE/gSOr6eXWrFPw+fgIBAyN6mprvu+y2cY23ThKE5qCn457Fb60iBdXVvn1EuVqrrq6cTH2vSKOJxJb47ERHHTrPP8CTf2evKD11qitQoF+1U7Wd0B2dGTW2/s7u3YP7n+d5/11xkZQpHCEaPY7XOlq9S0y87UdJ1ZRae56UibkEQyxe5UD2EhUGxPWTFkHjqyPhxdexujxP95dBGrJnyCEFiYUEa5122R5t4uZ8GsHxgRp+eDJsvcarmTrHObHISVxnZMkkp47IFGlQMrlOXcwoXLE6uMGTPmf9FJOM+akkafwgKqN7S+ztr2K9hvKgLs2RR+3luUJzaOZW3Nn9gcUYAVf9rKtmmMBDFtSEd4xwLETekHDCkMQ2Hp8YuYm644/+Je/Ghu7VEi3BcFfE/yYlhrGl6vgVoqS71iuKMBDt6MSufPfCcGeTde3lTHEZi3toussDlreU6c+HMwKFtNH3zwDhlsxOE16K6O0PeeXTTamsfkiLgm2UQIgIechmmPOuIDctcfqOjGklibUShazJfpcYdHemJuZpnK4b9pJGBQjaXanXZw5zcz5ohhCS0jXvkck41pOJmyLByIy9y0FtFBa5GX2QkPsqb62SDB1cAjCiLu+ex7oBxpKEk0CkhRyJ2beE/k66IHIDnicASPolO2ZRHNbnbmQOeTFdDKSOTCzy1rDYMnVEiPvE0Vs+E6EXQ8Jf7/U/s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1dSYW9SaldZNmFad1lNR29GUDU2bVg1cE84bk5iM1Nhb25udVlrbXRxdnZz?=
 =?utf-8?B?VldJOWEzZ3ZLNkkyc3RRdkJZTXo1SmwzNVNTRFl4ZTRFQmFLLzFKU1Y4Sk53?=
 =?utf-8?B?eHRHMjFaSFVSa2FNUG0rdkhFalRwRGFSdkFBZTNnMkxnb3lFMHNFNjJRRmpl?=
 =?utf-8?B?eWVjenZpTFZyanJXcExHbHQxQlRub2VKRmRxSFlQMDlQaXNmTVlqbi94YlQy?=
 =?utf-8?B?bDZrT0xoaEh6TjR3dEZZLzU3RkN5VisrT25QelcrbVhHQUgySjIzNnpZbGFw?=
 =?utf-8?B?MlVwMDRYRjFzcjJ4czQyUytFQStZUFY4ZTNVRm5LaWR1N2dWdzZoWXB6QjNT?=
 =?utf-8?B?WGVvNG5CMHVKQlNJYmNqYTdUbG1zbHhjdG8xSkp3STJKQjdqNDRQV2Fsemor?=
 =?utf-8?B?TjJuY0pUNnptQjFjR2hmY1g0bFFPdERUL1RkRU5KNGFvWmx6ZFdtekF0a09p?=
 =?utf-8?B?OTVZYmhFSzJPclN0dWQ3dCtma0tnRlY4SnFEa1VwL3pZNTNud2ppbHJKaWky?=
 =?utf-8?B?TDRndTZncGVRby81d0VzYURUVG5EQmJUamlsVmtNQzhDbDNENElZcDBra2U5?=
 =?utf-8?B?OVZJczZKQ2xMRXpPZUR3QUx5U2krVGwyWHhjYXdVY3Q5aXdEQ0xsWnArOGI5?=
 =?utf-8?B?K3lqcDVDb0szOWR2bWZwTWNuTTNOdFZTdEFsc1lwejBJT25EeThJMGNRaEU4?=
 =?utf-8?B?bXE4YzVRenQzMjRlT1VDRGUycDVNajZyOGRNVE8relEyRHJqVURhejBUSHUr?=
 =?utf-8?B?TmE0QVhUMUJPaHpaUGp3ZkZ4U3Y5cDdwK2t4ZjBCbnZhYWgyWmZzeC9KV1Iw?=
 =?utf-8?B?VXREZnJHUzZPZktYYlZuNmwvUk04UjZiYkcya2dTYzlJZU9scFZwSE1PWm9y?=
 =?utf-8?B?M2hGMnV2WHNWUVpWN3FqVDF5ZU1QNzlQejMwK1lBYjBQdFg4enc0NU96amlF?=
 =?utf-8?B?THIyUzFWSWV0ZS9pQkN4dzlQK3VkQTNqOWF1TVlYaG15Q1JxWGMxTFI2b2Yx?=
 =?utf-8?B?NU55R2VRM1N3ODVWUjk4RURDN01RQ2FtaDYzdkcrTDJEaGpMcE5INjlBazNX?=
 =?utf-8?B?d1NhK0EzRHR1R1dMMHVVbmpVL29BUElld0FTS2p5ZG9qaVlIeEpnbk1wYWZq?=
 =?utf-8?B?V3FPejV6MUVqNExwdllxcXVPbVZkN2psY1ZnS2ljSWVHVy81WHU3TTBmUlFi?=
 =?utf-8?B?Mm90akRLakhLMXMrSDdEZkZMY2pVQ0UzSXpqRTNxdlIranlNbUNTV2dkOUxj?=
 =?utf-8?B?ZURCOHA4dlhUQkUzMDdlS1VnMmFuaXZraHJMbFo5bURpa241MUFHR0tQNTA4?=
 =?utf-8?B?eDYvRGNoRThLaWgvSXVwSW5YMGVBc2s3elNTOUV2VlBDVVdDajZjbm9TSzM2?=
 =?utf-8?B?OWo5R0lLczdiK1VhaVFrS0Z0OG5qQ2paTnNLTkxjVzhlTU5SRlV0WnFEMXB5?=
 =?utf-8?B?NzEwMW9oMUJReXJEZnJTMTAxNFl3RkVvaEZoS1FYNDNWMUt2Tzd1M2RUTHFG?=
 =?utf-8?B?cndkNk1LZUVQdkJSZm1tN3BxcVlqUmlsYzQzVzRwYU9LdXZmc2pEclJ6SFNw?=
 =?utf-8?B?Q2FkR3JnTWZEZmN4WlFIY3ExZkpBbjdUM3B0T010MlVVcEpBV1BzdDgxY3lp?=
 =?utf-8?B?ZDBPak9hcmR2WEovZFU0bFZkOUFSTWVRUzFEb2ZFV2NDV245VWM2aHhrVm4x?=
 =?utf-8?B?T0wyT3lKTFY0ZXdjY2lQUHVNYS9jK3pUNjVTL1JidzdVQTJocEV1bHpHblNq?=
 =?utf-8?B?Z08vNURkSXorL2x2ek9ZRjRKOHVmVTRPOEJNMVM0MHBYTGdJdEhDbm9HSUIx?=
 =?utf-8?B?amFyNDNrR2t5VWprS0dQVlEvMUZrbFJ6YllEYWVxQXVXRW81NWMzR0R0MDRU?=
 =?utf-8?B?TmdpZUdjZHZickZOakRLS21MaThHNW5aclFGR2pJT2pyZFkxUWVNM2I3a1hm?=
 =?utf-8?B?SjNFbm11WDRWKzUxYmRZdnNNQzhIYTBIU3RMREFTNlZ3bGlDVVlFT21DV0hM?=
 =?utf-8?B?bFpUQmNmS28rRFFYdlZoOVh3TUwzTy9YUklxMFlzS0szcmQyTGhVRG81RUJM?=
 =?utf-8?B?OGNCZkQ4eCs0bGdyZFFWK0JkaDNidlRZUTNNWnN2OXcxUC95VWI5bGw0c2xV?=
 =?utf-8?B?Q2hHa0lBa3pDU2k5TlBWazNERExYWTlMcDZYKzRVZW5PWUFtRXVPblpOSXor?=
 =?utf-8?B?UDRvVFZiQ0pEUGRTMUpXTEQrS0FIOFNLYnJmVDhNMXR2SFVyY3o3UmE5U0Rn?=
 =?utf-8?B?NWZyc2Y2b05GWnFKZ1I3a1NtOVpNRncvazN5dFNsSVVYQVlNdkdjUFlyMXVZ?=
 =?utf-8?B?MDNxWVFidlc1Z0ZibExQcUZ2SHlOdWhNcGw0RzFtVVVid1QwRlRmUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F7E1059F1ACD64AB84025C965B0C93F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n9d1TfvdmSVrkFqDkZ+viC2Rphp7A2/L905PIsgMaBEF589b8nVrX+L+PG/4dJXjMXqS+mhIot1ROt+cCRuM6yf/PBqORuf3Mf6SspbJDKH1IEDTycfHOIUlgYY5UqkGoV0RlLQpnC8+W1V7rYwoSJZBQ4qqiUfH8OCxqphe2otIwUUtPQE+nAkkJ/2ExK9mG/Ve2hzgzHfNdXCbqlhkbsg7NaJjdE2q3SeKSi69G8yd7USk2ZHlwhgsHjZ4U+qWLE4iw2ups7/mg/+jB+Ei/0SD+SHqk2RDmXpjrFstUZK3Rr4WRC2movp0rQD0vIv3P7O5S6lRzq6SgRBjB6VL5w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe23f34-b5ae-4fec-c29c-08ded31b4f67
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 00:38:58.2494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3V1qiknJntth4mkLdo+GCBX7ZRyVeYOTZyVNcJRh2dBHgCRue4XKRKhkwuavCvqjKDfvV+JYPuphZSHA6tlu8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6450
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTI1IGF0IDE1OjA0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIEtWTV9HVUVTVERCR19WQUxJRF9NQVNLIGludG8geDg2LmMgc28gdGhhdCBp
dCdzIG5vdCBnbG9iYWxseSB2aXNpYmxlLg0KPiBBcyBleHBsYWluZWQgYnkgY29tbWl0IDQ2MjQ3
NDU4OGIxOSAoIktWTTogeDg2OiBNb3ZlIG1pc2MgIlZBTElEIE1BU0siDQo+IGRlZmluZXMgZnJv
bSBrdm1faG9zdC5oID0+IHg4Ni5jIiksIHdoaWNoIHVuaW50ZW50aW9uYWxseSBtaXNzZWQgR1VF
U1REQkcsDQo+IHRoZSBzZXQgb2YgdmFsaWQgZmxhZ3MvYml0cyBpcyB2ZXJ5IG11Y2ggYSBLVk0t
aW50ZXJuYWwgZGV0YWlsLCBhcyB0aGUNCj4gdmFsdWVzIGZyb20gdGhlIGhhcmRjb2RlZCAjZGVm
aW5lcyBhcmUgb2Z0ZW4gY2FwdHVyZWQgYW5kIG1hc3NhZ2VkIGJ5IEtWTSdzDQo+IHNldHVwIGNv
ZGUsIGkuZS4gKmRpcmVjdGx5KiB1c2luZyB0aGUgbWFjcm9zIG91dHNpZGUgb2YgS1ZNIHg4NiB3
b3VsZCBiZQ0KPiBhY3RpdmVseSBkYW5nZXJvdXMuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5n
ZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNl
YW5qY0Bnb29nbGUuY29tPg0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50
ZWwuY29tPg0K
