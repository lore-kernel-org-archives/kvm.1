Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4854407CC6;
	Mon, 10 Aug 2026 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397604; cv=fail; b=FlfBWT5qcBBM5a+kfMW3LfROHvqYTdQd9RShrlCZL6QWvlAiYMBR52nwsTztp68mLnrYtsRj6NWv/L27jvq3JJ/OBUJKUMac5ERf0oDlpH8X2luA1AcYoFRwE8FNVL9TcVoh/Fpbl83nl0toT5Pa5g01OqsYvNsr98rFejglgwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397604; c=relaxed/simple;
	bh=LVuVYTfwjKXEkdYHiaDWBT4N3r8EKy+vOrj8A2KVSTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G6qnsHmlfZLFU51DWJii7UNGej9532TH/uPzg1pauwVpTIzrC3G9PLAfufD8OaM0MbfZ5g/ye5s4/RIdj48AUo1BFazpkxozRa7GtXsvFPJiFeW95FUufwFVjpR1ZczRlX5x56qIUq2Nn/HuN50fEyIf0cnk9vHfkDaFKUN4dyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5shE5B9; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5shE5B9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786397603; x=1817933603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LVuVYTfwjKXEkdYHiaDWBT4N3r8EKy+vOrj8A2KVSTQ=;
  b=l5shE5B9mUmj0lAXP9y9gk+DOC4NW6pc9xD4h2WFDLiXvsNztRAZOqAx
   hw74FdrZQyfykC1dqqXCjCA3acn0JJZN13EhMD+L1poJHQNDxaw325hwM
   cH5KiLk6uHf4njMQTPg6mEXJgGbq5BU2KlmcgBdLP/LjY//npGRlNzZBP
   +4T0sGmoaENBq9YlUtZ0mSUUBiUej0pCu2pxXeSfqikyv+wu7pCuCb1hV
   4vdZFv9PDebGY2X6TpZ3RYQWcp2NfIZ4iPYm/TtkWaaZc+o6Y8d/iijDR
   zQvP14VdFDeUKIZr0yg3Wfcii35n6baFBkK5avdvLhiC85aDSEdnACIar
   w==;
X-CSE-ConnectionGUID: /v9z3H7oQaeeMD9ixG4Uog==
X-CSE-MsgGUID: IGs69yPHSYyQbpqmxoGYvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86996949"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86996949"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 14:33:22 -0700
X-CSE-ConnectionGUID: 8AJfOD1pSPWJvObuu1kYew==
X-CSE-MsgGUID: GRb9sfe0TLy7yUlJa+eRVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="259846512"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 14:33:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 14:33:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 14:33:21 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 14:33:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ifna+gXAM8JXY1IvukBHNXoVnxnriZRfujkr7NWZesH5JbbM7akZhU8RqK/G57GfzxvjGAGzOlnfIrpeE+J0AKFSfT1Y0DdtYJ1TxJ4nYkn4W0o8TblqM1VQnpZVAo6Jn1Nti9sDHPyLiWEdTaAvoXvVKs1Y6Ke+QcyqFNplsnTLUSlPeRjHZhUCAtphtgGp8WX2dJYXNI8dLlrU1zyY2uTPtVt4jen5XUDQ/dPA9YagtWh13FTJLMM63mwdmaetuCRgNKyi2XgR9NOI0TWlcKglkO8bHJlATOhvX070SLRDrQTqVRNrMc0RLUc8RT+UtS0QEqEU+qOow39sjXIcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVuVYTfwjKXEkdYHiaDWBT4N3r8EKy+vOrj8A2KVSTQ=;
 b=nVP8jyA64ye82afBHJrmr1dtuIQ3gK+pFxFhQJip95CtuARqP/LJ5nKShmoR9y0o/vytw3bxXmTdMLtBY92xWF7tJiYOGMX3tyZ+wkVVVVqq5nBbNu+kUlpD5en/ZMsVnxpuLxIoV0Z8pPMSWhI2f4hKdI/wedCkvAJIcrDmb5QxO+cdpk2lRODWVrJKhyP5JlWjBQiiuY/7RXYqZKadHSKiz5XMr6Mvt6pLxvVIoR7wWU4tXdqR28NzvXHvQmL+diaUoMWH7B1OILolmcHF1ggmPMNw8+5eudr+w2s5efn8MKf3zYAhus9AJDs335S35qI+ZwaI/blsKtKYdn/Ktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SABPR11MB9940.namprd11.prod.outlook.com (2603:10b6:806:4ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 21:33:18 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 21:33:18 +0000
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
CC: "hongyu.ning@linux.intel.com" <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH v9 09/11] x86/virt/tdx: Enable Dynamic PAMT
Thread-Topic: [PATCH v9 09/11] x86/virt/tdx: Enable Dynamic PAMT
Thread-Index: AQHdJUiUC0UmCEgtm0OWxkUikZzIlbaXVcMAgAB/YoA=
Date: Mon, 10 Aug 2026 21:33:18 +0000
Message-ID: <3a2b65f309bbcedd9986528d86eebf4ddd14712d.camel@intel.com>
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
	 <20260806020850.1221381-10-rick.p.edgecombe@intel.com>
	 <fec4f97c-36e1-4c25-9c4b-6aa2eeed12b2@intel.com>
In-Reply-To: <fec4f97c-36e1-4c25-9c4b-6aa2eeed12b2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SABPR11MB9940:EE_
x-ms-office365-filtering-correlation-id: ec30f82b-3222-4f98-7928-08def726fea5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|921020|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: LN2PrHQnS5nWiPeBCb8QlMzEUUFQFnlDm8d5UPu2Axf2B9slGhI1A609871VypVc4ROa8s8LKSOTrAV+Szn7rVNRhVDXO8y2KMjFWZ5uORAuGzT0XCKaVcTPNRDPgIUemQ3hUBVJrJGVeErGZRL7cmw7sz0vPvXzW8MpYqY/wQhAqTows/ynslQOYXkbhHd9eHdTQqTaF04+l5IDAnao5phIcNqufzgE203c9kQACoHq8HUubrlusFm0V5rwBQ++npgmuikm8S1n0af0Ph3ynG+W519oeLQ4K7U9BnZdEvQ5sZ5uOkAPxn0mK4BBosmv8RoH5r/oqhmiAH3gzF6BhFhIxheJlNMAa+Y9/0GqoUTzGVeaD0pChVbpa/cWevF8MMZz70x4llBrd2eHrCWVhDXjoMrAhGicT/6fv6LOd7MmKVkq/HTtaaLx14X16rD6UJHv7rImUlrvUTnS/EUyyicFJM1p1EaA15++2oOo2uUd3g9gpw2rbXWLT1jTMLsLkd0FFDXY/BZQ77hglk1STgh0rf+5rrZHDjgk4quyRHsS1IaTJOSw/MoGVz99g3SEz6kHZdxDZM5U5yKDQlpx4JoDqS7ChtNchKYyJ8kIHR5YXxa99No7VoXm4zwj4lTtvwMWQDQjqHbxJNhkC9iLxhiRmw4aQSSxW+V+XkOxzuqh+pNalNsM8fTM96P/hAZOX8dW21x41TocHbrq8ZVzaPWQiqedTYVXACNpN/sRIbs57emyCk0r0SrXCdYrCA8F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(921020)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejkxZEMwRDRZVnBGbjZXQkdudUxESDFueXlFUFprK1ZWSlowNUdoQXlTeTFR?=
 =?utf-8?B?dG9tZ2NZaXBoT0o0Mm9aYU9tTEdtaHpJQ0xvY0RlN1dkcWVlMXI2WjNWYWhR?=
 =?utf-8?B?dDY2ZXQyS3FWOHNaWndMUk9RZElFQ243V2h4RUpzNHc4V2lLcWR2elVHZGhC?=
 =?utf-8?B?VStxKzNXZ1E4SFhpU0gzVXh3cHNtUVVFSmNiUXRqVnpWakxFaithWW16MzNV?=
 =?utf-8?B?YUgvQ3dGdHFNeUlDb0I3U0dPeDJIUldGWFliZVYwTUZhVEMzWkcvQThXRCs3?=
 =?utf-8?B?Q255WnpSUjhPNHM2eXBPMjlzb2cyMzd5c1Q0UEJPb2VwNHJheDRjWFpQNmJF?=
 =?utf-8?B?aFJCNjFjTU5mUmdZeExBbXBHejF0RmZQdmNpU0R3aW9nNW9CMUNHMnJsQVZn?=
 =?utf-8?B?SEJQZ3VrbE5SVGVEeW5WMmh1U2JZcml6SmsvQk40bklkc1ZOSjBPWHN2ZlRN?=
 =?utf-8?B?dWgwcG14WWpyS0ZIVjlOamZHWFB1UmNUc0ZBRlF1MVpNaFRvMVA2VWQrS1Vm?=
 =?utf-8?B?eWorMkM1OWVRQTk4MDBHM2JPMHFGYjR1R0M4b1NHTGVUK3NhQXEwVkdSVngy?=
 =?utf-8?B?a0Rtd0h1VzY0N3A4RzljMHVTNFJnQXorSWpMOThZdDdQT25Hb1drQjdsWWxa?=
 =?utf-8?B?N1hnYWI0eXhvelJObTdpM2JMZWFqN2J2RVdaRWlqRU9yQnByWTUrWGVkellN?=
 =?utf-8?B?eXFTWHRZYWs4dk5LVVowc3JhS3dnZURRQ0swckRvV0kwa2hUYlhQRDZxRkxO?=
 =?utf-8?B?TzlKL1Z3QjJ5K0h5eVB1NXRzNC95K3RINFdkZkcyRWlBaFYyMURwTGw0ZENr?=
 =?utf-8?B?MVRZdFN1VUtmOVgxK1hlamd2UEk0KzQwc1o2ZzM1RkFxWnp1WS9aeFlRV2pI?=
 =?utf-8?B?SHJjUjcrTHY0UnA4S0V4Z1R3WUxtOVVDVmJBUHphT1NCbVBSK2hUOU5XSDBW?=
 =?utf-8?B?c0JLWEg1SldTbS9iRWtxdW83RHphM1pIeGY5UkxqS3dMVHdQdTNiQ0ZoWXdy?=
 =?utf-8?B?TVY3U1ZYczFmUm94OWw3WTFpSGFJaTJjUHRIQXFCbEFYSG1IZ3N4ZW5VQWZk?=
 =?utf-8?B?V2JtYmdoWnl3S0xCOTV3cllKRXRzWjdRYVBLMFp4dy9TcXVUTUYrL2tnT3Mr?=
 =?utf-8?B?ekVXaFl5WVFzcWZnZWM5YmxlUU5LbXlkdHpwc0dqbzRSaW9QaWE2UERCQ3Rv?=
 =?utf-8?B?T21qZXdxRVdzajBzSkIrTkVienVHR3dyOE1DcmdTOHYvb2h6dDIzWTZVVkg4?=
 =?utf-8?B?RTFJM3RwOFJsVXdGK3BaWWEveExwc0kwRmlYZlpZOXprTzZ2K1FGTHBDcWFw?=
 =?utf-8?B?SkNTQ2FGRWNiWkFHRFJrNzhDZkd5YVc0WkpGYThieWo1S2piWWIwS21uYnp5?=
 =?utf-8?B?MkpxVXJyQi9HWFZFeWJvUjJHS1JpbTM4L1diNEZCT2hFeGJKT1NXVHR0VXJq?=
 =?utf-8?B?RkFUbm9GZ3pnZE9Sc01GMW15OXBiY1ZQRTFkQXlZL0wzMXlzeVN6RDBqMkdk?=
 =?utf-8?B?K1lXWVFBcUQ1NUlNYW85MWQxTXovVytBaG5obXNEM3dYRkRLdXR0WFVyT2Jw?=
 =?utf-8?B?cG4xK05LZWxFQURLVWwxWktWQkVRSjVWbHpxMEFOYjJ1WGs4ZlFWQTM4Yjhj?=
 =?utf-8?B?aTBZQXFBdldUNUFQMVZCWGNsQWZqeklDd2hhU1RTWW0vVFN6OXhLbzd0ME5p?=
 =?utf-8?B?eDRmMXYxV0pFNDhZMW1HdkR4WlpDcUFFeS81YlRabHBIdGhkVjRmaDM3bERz?=
 =?utf-8?B?VTJsb2ppempaUFJiK21Uc01aSWxHSXFXZ0FzQ09xbS9OWkoyMTJQaTRIUUpj?=
 =?utf-8?B?U0JHTVZ5eFpCOUZkTHI0aklXYTdVUlBVdWhmNGg2S2NBeUxwRjV3a3ZVWmYw?=
 =?utf-8?B?OHFjSjgzelVmYUFFZzB2UTV3aDc2b1ZxZWZWdzJuVVpyUXlnZnF5VnkxV3g2?=
 =?utf-8?B?bXBmak1mMWhXaXJTeDU3QWxYVm9ZYXVHQWxhNElKNGxLZVkxYlhWNFJMUXQ2?=
 =?utf-8?B?aWRETXc0SUNYNHFoODQ5TXBBWFBrcmFmYzdiV2k4L21kejloSzNxeWVPMlp5?=
 =?utf-8?B?enJnVmI2aGd6RTM4ZVNiOWZ4ajdzUHBuMmdFcTVoT0VBRXl1VWlBNHpGL1Zr?=
 =?utf-8?B?NXhVYm9jZEJ6Uk5Ja0NIdmhNNE9IczVWZWhsZFZaTTdOU3gySmVNdlVTc2Ro?=
 =?utf-8?B?ZmdxWm9UT3B4WmtiNGljWDM0RXRBWnIrWTR1WnRVL2lpWE9ZY0RZWG9WaUQw?=
 =?utf-8?B?WEFUMGRnRzFCOThuODJyaWJ6U3RLVHREVWdIVTJiditqR2luSHU1Qll2L1Vq?=
 =?utf-8?B?ZU1ObGxDK2NLYkFBdHVQSW9CVGFROVVCL0Nac0FBbWhPbWt2Snk1U1VMbTM4?=
 =?utf-8?Q?/FEJ54RXik6f/QRY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FBFEFEDB5586D4C9C59553688225D38@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mz7K/ip31ymVAVnljYGE8R1f3rRpBQawp99iJuhjlsZhJiar7D9k8lngwQZR+fhgHw+8pqWjRAef8Ds9PFjnUC79ygVjiG8CFV89Fz/H6sJnDLDpHd59LtYT3KOc2NOA163oC6ySvQtsTBpcGRb95S1lUvTcY9GumfEmrQ00Pagbz/5D/bMm5XEAMIbKg24Uea81JV8p8dhiz3g/TUUoF9/HdomJQQ6oIWJuI73k8cA6jVGgCZWG29f/RJzE3YZmwTSJgAELgGCYejEehpLKyX9UOnkfRzrt6NpEQcWi3DfOWqRtkaUYuNmjaMiQ9qs7Mmys83nlCtjX8VybM3frSQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec30f82b-3222-4f98-7928-08def726fea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 21:33:18.6119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0K8tQGGVWX5QNw8ohRlkXvsmgPhCe/t3I6y844oKFX1lakKecIKe27l/Nx5o7l4ckVJaIk5U1tCCqdrspDFDHndQWQvj5m3WCh9cwDb9F0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9940
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA4LTEwIGF0IDA2OjU3IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOC81LzI2IDE5OjA4LCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiBUaGUgVERYIG1vZHVs
ZSBleHBvc2VzIHdoZXRoZXIgRHluYW1pYyBQQU1UIGlzIHN1cHBvcnRlZCB2aWEgYSBiaXQgaW4g
dGhlDQo+ID4gJ2ZlYXR1cmVzMCcgbWV0YWRhdGEuIFVuZm9ydHVuYXRlbHksIHRoZSBURFggbW9k
dWxlIGV4cG9zZXMgdGhlIGZlYXR1cmUgYXMNCj4gPiBzdXBwb3J0ZWQgZXZlbiB3aGVuIGl0IGRv
ZXMgbm90IHN1cHBvcnQgdXNpbmcgaXQgd2l0aCB0aGUgbnVtYmVyIG9mIGtleWlkcw0KPiA+IGN1
cnJlbnRseSBjb25maWd1cmVkIGluIHRoZSBCSU9TLg0KPiANCj4gV2hhdCdzIHRoZSBjb25uZWN0
aW9uIGJldHdlZW4gRFBBTVQgYW5kIHRoZSBudW1iZXIgb2Yga2V5aWRzPyBUaGV5IHNlZW0NCj4g
b3J0aG9nb25hbCB0byBtZS4NCg0KQUZBSVUsIFREWCBtb2R1bGUgaGFzLCBvciBoYWQoPyksIHNv
bWUgcGFnZSB0YWJsZXMgbGlrZSBzdHJ1Y3R1cmVzIGludGVybmFsbHkNCmZvciBQQU1ULiBOb3Qg
anVzdCB0aGUgNEtCIGxldmVsIHRoYXQgd2UgYXJlIGhhbmRsaW5nLiBJZiB0aGUgcGh5c2ljYWwg
YWRkcmVzcw0Kd2lkdGggaXMgdG9vIGxhcmdlLCBpdCBleGNlZWRzIHdoYXQgdGhlIE4tbGV2ZWxz
IG9mIHRoZXNlIHRhYmxlcyBjYW4gaGFuZGxlLiBTbw0KaWYgdGhlcmUgYXJlIGVub3VnaCBrZXlp
ZHMsIHRoZW4geW91ciBwaHlzaWNhbCBhZGRyZXNzIHdpZHRoIGNhbiBiZSBzbWFsbA0KZW5vdWdo
LiBBbHRob3VnaCBJJ20gbm90IHN1cmUgb2YgdGhlIGRldGFpbHMgb2Ygd2hldGhlciB0aG9zZSBs
aW1pdHMgYXJlIHJlYWxseQ0KbmVlZGVkLg0K
