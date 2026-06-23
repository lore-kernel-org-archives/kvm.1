Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84F384CDB;
	Tue, 23 Jun 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210558; cv=fail; b=GPtr0BHqmeUdYHi7LIq3fAIjGJBWurHSwP+/POnvnt/E53W/Z/aXQgQBePWcGuBMmgYogqmaxG85YVwOActkEXAUm3HtNG27H7tAueZ9Xr/Xp1MSN9Kh7rXGo5j3xhoSKVYKWIUtIQU6eDLKJdfV7u5Lwlm1aIrW8F5MQh48lyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210558; c=relaxed/simple;
	bh=zz0Dz0lCKV7N0e91T8sDlEaINoCzLedz39MTkHCdwIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J4EuE1SZV7dJLVcT/hn+aUd6fV6u75Mj7rBTJz7VHY64KvdkPiNYyQc4XtQbpe8NU+2hnNkfP63/qQDRxKyfClV1fFGZ3MHA6pynfxjyaOfGueJ1GK20V3vT4kdh8SxwyFoM5weZ1nnZjgUg1ie/MrLDKPfVC4U4KIcxbWwoWbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfXbrWJn; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfXbrWJn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782210557; x=1813746557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zz0Dz0lCKV7N0e91T8sDlEaINoCzLedz39MTkHCdwIs=;
  b=LfXbrWJnoF8WBHDMXXof+ozkrUf4e5TvgQW6DrwYWkL5ZPIIchpwf7Pu
   r4GQQ+Wy8gG7fiVAQpaSmU9GEyiRjaG9XYp29XUJ//KJFjbQlHiiIM0sS
   4N5ybSQOuPeEmTulIZoFJS8dcOz0u6+QlL5Ii/ogs7SiApS52qDtUMwVG
   V9j7VeS3i+vL169lPJuR61rtQkaKl368Gy86GUIutbKh26NmAIEfy+JkK
   F5dNxdWDQ29LBB7L1slaaaHRkp/uO/crxwQ4lu9H8OVBklDS95QbgjJlL
   K+HUXVn3D5e44eAleyG29FW+1qbco0YBcMXjvInMIhzLvv7fHXJCPc7oN
   A==;
X-CSE-ConnectionGUID: hloGTeaTSx2LaU8hkOrCvQ==
X-CSE-MsgGUID: NBGi0uSgThu9TrGJKwJKCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82991719"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82991719"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:29:16 -0700
X-CSE-ConnectionGUID: c6qoIm2zTlqXzhGbHKVJvQ==
X-CSE-MsgGUID: kJv54hqxTjibyrBGgPHg5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="253361553"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:29:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 03:29:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 03:29:15 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 03:29:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5HOwNYgiPdGZn+gy5JS49QBaTy+CjZ9ZbbUKSoTXlgaIdMehjHsx40iV4CKmfFLzWDzzWFa2bOm2NqDE41R1Q96xzrYZ1URFRHNtRH5ye1Sn3I4Dhq92ux5pbo3EYWj4p2wTNv7XY0Dcx0LK0gvVtgG1RDXjv1J7p4finOGQUGPZy7E/Ufkbqe9SevSOaKb+tPZek6lQxuY5yeUFCIhhdVe7j93nBggtxsDmaEsrfbgakkKYZCHUmbe3Gy4lQ03Nkej9WTL91lk3312bnfbfm4IDuZESvNXT4+ggcclUlfbWOw77Ip4eKrhKNBuCyg6QtgHGofS2PlzCpVQ5aC7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz0Dz0lCKV7N0e91T8sDlEaINoCzLedz39MTkHCdwIs=;
 b=wlXqcUuol6emCUIN5kOwo7pmkr05FVEQwJMyw9AXiCfLwtS4LRD7at/yRhGxTVDrjFJMBGcMxNYWMJsRfUtv4HjLbP4n17k3L0DgfjsHnjPdZaeP+l41z54WbhAQVisaqatOL2SFURiTFI1UddD660eAMf/ipm3BMa2LKIw36wtDl2HEh7sZKSCbI2NiGDfhAsxBpYSk+zfb+1xFPXTZ6WaZF+Cdg3TZGU7p8F6RMSlW+/mq1wmQ3PZEE2EM6ut2tCTLlhqC4DqcOA7sQwJ8ea6YkIK9w3edZiI2cxedvcE472pA+CyR//qodPG/k66Fea2fLsyJJQdFODHZA6jyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH7PR11MB6450.namprd11.prod.outlook.com (2603:10b6:510:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 10:29:10 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 10:29:10 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: Clamp the EOI vector if its OOB instead of
 bugging the kernel
Thread-Topic: [PATCH] KVM: x86: Clamp the EOI vector if its OOB instead of
 bugging the kernel
Thread-Index: AQHc/1QYLGBBYF7ab0m45gRDa3IBLLZFT+IAgAX2joCAALEmAA==
Date: Tue, 23 Jun 2026 10:29:10 +0000
Message-ID: <399c963febf1899381af22880821ca29b6722a91.camel@intel.com>
References: <20260618185515.2021642-1-seanjc@google.com>
		 <f8d021453f5bb6565fc9c9c2e23e63d8c620e2f4.camel@intel.com>
	 <ajnLWcMETdVnKVRc@google.com>
In-Reply-To: <ajnLWcMETdVnKVRc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH7PR11MB6450:EE_
x-ms-office365-filtering-correlation-id: 3778c0c9-11fd-4c30-313e-08ded1124392
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: c7N9HoMEHrE1wOevRden/M2di/YdX1ouQgSuflMgyS/MKHPTALBHgiBAzC/ZwT8swmFdAyYVCM13brsBpSaG3cwP70FGt1by7k05W7YfF3eboLxHvT999QDVpVgnbt4EChvPbwwVJ1iH9ufyeYiu6zDha52QcQc3qz3kWWTtRmUhGhrN1J7pbD5oEPSc1fSjcaGjkKStHmsN0ro+MVG0GbriYQBavHah4QuODySLMgXJFZuK3anG90Xkkf9PFnbowzgKFrGbcTaACIvA0CCdphVt6W1KR1kDEQKRAt+XYdQ7/LqSg1iUrTV8cLbonOxZsbA7yNwGX8UwmgqoEm42XpOLccgct3P1D7owXCKPIkZRBntApAtP+7iehrvVcMeMy6MO91k9ZEIdKCA93jJAkOuK1Aj0MF4RZqoFURljMFjwHsMXJMw0NJcwsk4dsNKfnh7gifnpBxyzImOaqPk1d/2ZXrgIz9SpQQGWmg+mOtflvJKn2pIG+J71INdp/+32b/p++KwA+5v1Mm3ln+zOXKQlArkIX3XmwbnWSDpQGV0nE1usvYY9SYMwKj37T9g3GjJfcj3HJmljM7r2ojCF5WrjcuKktsDXKuwD6MTkR/qyjDOU14G7+k1BWBkN9zZdC4+avCvwOiWTNJu+dGSwbN9AvIUFxeSoCOxRFL7vAh3wORuPrGA6J+HYIlH/0aWkoycOc23eCCIXKZLbt0Syxbq1AUGuwyLsWFukESig1WU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWdzRUpRaEpBNDh0di9QcTJpYTlhaFJkTXdwZGxPQnlIbGZSZzY4MXFaZDdz?=
 =?utf-8?B?a3hqY3dRc0M4cVppM1drVzJ2ekJJUGFCc2lROU50WnpUSldqUVE5YlE3dCtx?=
 =?utf-8?B?eUxUVlRwWTVkMmZwd29ZSTZpTkJnZEhrNURxNjZRUjRoeW5kV1JJa1lTcmxF?=
 =?utf-8?B?cHZUZkFXRW5NZGp0L3o3Q0RwcVI2dzR1VU85OW1kR0FNRDVlRlJRaytieHI4?=
 =?utf-8?B?WTZiM2ZJM1NPUmoxRmJqT0NZai81QVVFSnJOSmFHMkxwUitNK0NLejhYN1Zn?=
 =?utf-8?B?QXVpSU41bXBncWNZQUtpVzNIK3dKQ1g1VFpVZlFtcDZsQXkxRVpZaXFDNk4w?=
 =?utf-8?B?RG53bktKd01OZzRJSUt2N2ZBNnFvczVFRHdsNjhnTlk3bFJLTWxZcW5QaFZS?=
 =?utf-8?B?NUk1aWVBS2p6QnpVeWNzRU91MGhhdEJXNVFUakw5cFJYbVRGcGh5SmxORWxV?=
 =?utf-8?B?Skt0TkxVaWlCZ2xIaDZUTEJiV1FENGFaWVppb284TnIrbSthYkxaYlJMZysv?=
 =?utf-8?B?OTdkckg3akIwaXVuUkV3OWE2bmJ3U3doZHB5UjY2MEsxbWFHWmNpcy9qOTds?=
 =?utf-8?B?UUlzdXptUkFQUVMzd3dDY2Y5UmNKSGNlcG91K0VMSjlHMHdlRHB0TCtmRzFI?=
 =?utf-8?B?M1FwK1FvN25qdE4zenloNjdKQVp4RmpNSDUzeFZRTFFZR3ZaVEZFaWVUc2Mx?=
 =?utf-8?B?S1h2UFc2ZXJoVEIyalg4NzZDWTQyblFSY01uYjBpL0tJNXNjOU9EVGpFTFlC?=
 =?utf-8?B?RmxOYWkwenNzQWRselhEZEp5VWFHczRWUVk4V0ZyeTI5SE54cWVDQlhkczNF?=
 =?utf-8?B?eFppNldTNTBZWUpIcFpvTTlIUkJvMHVPTWc3bThsRXVkR2xsek96WSt2Rkpj?=
 =?utf-8?B?aGdwdCtCNG1wTmFjcGc5azZIZ3VsaGRhMlRqTUVRTVhBZmNQUnA2cSs4bDY4?=
 =?utf-8?B?LzV2VXB3bHNiY0ZOSUhJWndtL0VreTIrTGhoZFM4KzBMM0I4ajRSUy80a0cr?=
 =?utf-8?B?V2xrcVFuWFc3aEs4OVpHRXRrUitDZ3JCZzBUL0t5MVkxaTV5SXJWc0tDMXgv?=
 =?utf-8?B?ZDhnaVF6bVhwYkZyWnh6SGVaZE1RR3k2Qmx3V1BaejdrNFcvN2FhVmxwQWpI?=
 =?utf-8?B?c0JMYlRkRG1hRkFScW9NQTh4RWptWWU2TmJGNkhmcTEyVDFVQis4d3N4cmNT?=
 =?utf-8?B?RzVmREhJQ2FwcFlrZUxqZmR6dzExcGw3NXliQ0tja09kdGFvd0E2Vml0STVr?=
 =?utf-8?B?ZVRZdnhjMDFSM2FLeTFZSTFMUG1HQ09mOWtkSTZTd3lnVnlZYW1HbTZlSWFE?=
 =?utf-8?B?OGw5Sjk3STNtU0JPUk1NY3o5dWJZdjFMcDNxOFhqbmZEQ0lidXo4UEYrczMy?=
 =?utf-8?B?NEJCbXNabUlPQUcvaitZVGwwZFY0SFo3MDVJOTlEOG5udXpFSjd6UWlWWFJM?=
 =?utf-8?B?Y0VEbUtGZ2R4L1JsSzZDLzVYbHNvUVI5K0VxNTBiT2xHOEU0RHhVejV2TlZ5?=
 =?utf-8?B?QTBUTVNtUlpBVTFQSEN2bW83MmJ0TnFUU3dDaVFNZWl6TkhXTC9BQTZ5NmZT?=
 =?utf-8?B?NEttbTJqSlk5ZjhsaXdpSTZNMk1RQjcxMi9Pc3JYSHFOVW5VUFhERUdxS09l?=
 =?utf-8?B?YkI0cmN0Z1EwRW15N0liRG1FdmIvZ2dEUXpVd04vM1hBblh1dlE2YUUraExO?=
 =?utf-8?B?NTYvb3h0Z2JSUkM2QVU4U1J2V1hadlZkTVkrNUh0UEhIZHVwaExvNC9wQjJE?=
 =?utf-8?B?U3J1RkRCTkJqUDM2N1NVNHJDQ2F2SXBOUDE3SHlCNDltZ05qRGM2MkQ3NU02?=
 =?utf-8?B?cXNzY0VpcDZXRDRRTTNIZU1OQ1d4WXZsMkdWempjY1hWbnNHU3hQL1k4dnRR?=
 =?utf-8?B?RGtpWDhNRVpsUEU1ZXYzWm1SQUwrSUYxR3FWbU5UdlZaOWJDRWc4SVFDUVI0?=
 =?utf-8?B?NU4rbTJkVXRpOWFhVTZsL2ZXQzVpU0hmT2tZc2dqUFhXR1orMFpKbVAwckRk?=
 =?utf-8?B?YUU1cFc1NExYdEFjN2VPcEQ5SHJwUkdXckpxUEhLQkRuZU1oTW1MRUQ4TG04?=
 =?utf-8?B?dExhRmp5YTUyZk1uSDA5SGdNTzZ3UXdQSVJJZUE2K2N2aE1uSWp0MUl3WUIw?=
 =?utf-8?B?L3E3ckdkNkNrdWRQV05FbWNlSmN5a3ducXZDemJLNmp3aEJPeWJ0RTFIMGNO?=
 =?utf-8?B?RUJRN2JWRFczYkFiY1dvRytxNXBrTXZNWnc5SkliTm1XSzdkSUQ1alY5R2pv?=
 =?utf-8?B?QVhOM3pnNWE5Z2EvOVVxUmRjTDVlV1dILzZPNmJrZDh0R1l3WnZHRXRHUkhD?=
 =?utf-8?B?RVlhdGhGanpQblhDbjBqZ2tmTmMwYmxOc1NzZ3dqaVpWWVhzaVlSdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FEAFBA03C2C174AB91E34F35915FD2C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VduAF/Yo+bdulCfMSEJK9Ef7XV9CkDnmvvNEHymcwUjlkAosKGiKF+cdm1pmx3Y+x3WSf8hUdEaKvi6UyrL81pw0/Lmuz5YdJ+B0Oug2PW6ywQgUOoC9pvbjG4Jk5uCHno5XxML70iSkC7RorgeVkrS7d8u1m5lmtnaC68LEsXH0hKY2c92zYichzqbLtUE5u2fRsoTIrKzKj8j/9Zv5Gu8W09xj+2X1+mL5i11Dq8dLITcS5ekO5LeiHNl+YppywT6rMycoOLDnlo7BBg65YS2RMJLisW1KIJAe1H6hP/e9hC5wFX8R/g09vnU+SK5HfOCjGZZPpaDTbllKiwCbEw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3778c0c9-11fd-4c30-313e-08ded1124392
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 10:29:10.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYmk4R6wGJUPasAKwFMYBj7Dz0kMP7/5KxIKXOi7ICHvDm7BRTttb+jUtlZc38fEPfQemjawOwOoyMxpM5zlvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6450
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA2LTIyIGF0IDE2OjU1IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBGcmksIEp1biAxOSwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIFRo
dSwgMjAyNi0wNi0xOCBhdCAxMTo1NSAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+IElmIEtWTSBoYW5kbGVzIGFuIEkvTyBBUElDIEVPSSBleGl0IHJlcXVlc3Qgd2l0aCBh
IGJhZCB2ZWN0b3IsIGNsYW1wIHRoZQ0KPiA+ID4gdmVjdG9yIHRvIDI1NSBhbmQgaG9wZSBmb3Ig
dGhlIGJlc3QgaW5zdGVhZCBvZiBidWdnaW5nIHRoZSBob3N0LiAgSW4gYWxsDQo+ID4gPiBsaWtl
bGlob29kLCBhIG1pc3NlZCBFT0kgaXMgc3Vydml2YWJsZSBmb3IgdGhlIGd1ZXN0LCBhbmQgaXQn
cyBtb3N0DQo+ID4gPiBkZWZpbml0ZWx5IG5vdCByZW1vdGVseSBmYXRhbCB0byB0aGUgaG9zdCwg
aS5lLiBwb3RlbnRpYWxseSBwYW5pY2tpbmcgdGhlDQo+ID4gPiBob3N0IGlzIGNvbXBsZXRlbHkg
dW5qdXN0aWZpZWQuICBBcmJpdHJhcmlseSB1c2UgMjU1IGZvciB0aGUgZHVtbXkgdmVjdG9yLA0K
PiA+ID4gdGhlIGdvYWwgaXMgcHVyZWx5IHRvIGVuc3VyZSB0aGUgdmVjdG9yIGlzIGNvdmVyZWQg
YnkgdGhlIGJpdG1hcC4NCj4gPiANCj4gPiAyNTUgaXMgYSB2YWxpZCB2ZWN0b3IuICBIb3cgYWJv
dXQgdXNlIGEgQ1BVIHJlc2VydmVkIG9uZSBpbnN0ZWFkIChlLmcuLCB2ZWN0b3INCj4gPiAwKSBh
bmQgaG9wZSBmb3IgdGhlIGJlc3Q/DQo+IA0KPiBJIHdhcyB0aGlua2luZyBpdCB3b3VsZCBiZSBi
ZXR0ZXIgdG8gZXJyIG9uIHRoZSBzaWRlIG9mIHNwdXJpb3VzbHkgZXhpdGluZyB0bw0KPiB1c2Vy
c3BhY2UsIHZlcnN1cyBzdXBwcmVzc2luZyBhbiBleGl0PyDCoEFuZCBJIHdhbnRlZCB0byBrZWVw
IHRoZSB2ZWN0b3IgbGVnYWwsDQo+IGluIGNhc2Ugc29tZXRoaW5nIGVsc2UgaW4gS1ZNIGNhcmVz
IGFib3V0IGxlZ2FsIHZlY3RvcnM/IMKgSG1tLCBidXQgdXNpbmcgMjU1IGlzDQo+IGJhZCBiZWNh
dXNlIGl0IGxpa2VseSBuZXZlciBiZSBjbGVhcmVkLCBhbmQgdGh1cyB3aWxsIGJsb2NrIG90aGVy
IEVPSSBleGl0cyBkdWUNCj4gdG8gMjU1IGJlaW5nIHRoZSBoaWdoZXN0IHByaW9yaXR5IHZlY3Rv
ci4NCj4gDQo+IEFoLCBhbmQgdGhlIGZpZWxkIGlzIG5ldmVyIGV4cGxpY2l0bHkgaW5pdGlhbGl6
ZWQgYmV5b25kIHRoZSBzdHJ1Y3R1dHJlIGJlaW5nLA0KPiBzbyBpdCdzIHN0YXJ0aW5nIHN0YXRl
IGlzICcwJyBhcyB3ZWxsLiAgTXkgb25seSBoZXNpdGF0aW9uIHdpdGggemVybyBpcyB0aGF0IGlu
DQo+IHRoZSB1bmxpa2VseSBjYXNlIGJpdCAwIGlzIHNldCBpbiBpb2FwaWNfaGFuZGxlZF92ZWN0
b3JzLCB1c2Vyc3BhY2Ugd2lsbCBiZSBleHRyYQ0KPiBjb25mdXNlZC4gwqANCj4gDQoNCkkgd2Fz
IGFjdHVhbGx5IHRoaW5raW5nIDAgbWF5IGJlIGxlc3MgY29uZnVzaW5nIHRoYW4gMjU1LiAgQSBz
YW5lIHVzZXJzcGFjZQ0Kc2hvdWxkIGp1c3Qga25vdyAwIGlzIGEgYmFkIHZlY3RvciB0aHVzIHNo
b3VsZCByZXBvcnQgYW4gZXJyb3IgdG8gYWRtaW4sIGlmIG5vdA0Ka2lsbCB0aGUgZ3Vlc3QuICBP
biB0aGUgb3RoZXIgaGFuZCwgMjU1IGlzIGEgdmFsaWQgdmVjdG9yIHNvIHVzZXJzcGFjZSBtYXkN
Cndyb25nbHkgRU9JIGFuIGluY29ycmVjdCBJUlEsIHdoaWNoIGNvdWxkIGJlIG1vcmUgY29uZnVz
aW5nIHRvIHRoZSBndWVzdCBvcg0KdXNlcnNwYWNlIGl0c2VsZiBpbiB0aGUgZW5kPw0KDQpCdHcs
IEkgdGhpbmsga2lsbGluZyB0aGUgZ3Vlc3Qgc2hvdWxkIGJlIGFjY2VwdGFibGUgaWYgc3VjaCBi
dWcgaGFwcGVucz8gIFRoZQ0KZXhpc3RpbmcgYmVoYXZpb3VyIGlzIHRvIHBhbmljIHRoZSBob3N0
IGFueXdheSAuLg0KDQo+IEJ1dCB0aGF0J3MgZWFzeSBlbm91Z2ggdG8gZGVhbCB3aXRoLCBqdXN0
IHNraXAgdGhlIGNoZWNrLg0KDQpJIGFtIG5vdCBzdXJlIGlnbm9yaW5nIHRoZSBJT0FQSUMgRU9J
IGV4aXQgKGluIGNhc2Ugb2YgdGhpcyBidWcpIGlzIGJldHRlciB0aGFuDQpyZXBvcnRpbmcgYSBp
bnZhbGlkIHZlY3RvciB0byB1c2Vyc3BhY2UuICBJIGd1ZXNzIGl0J3MgZmluZSwgc2luY2UgdGhl
IHdvcnN0DQpjYXNlIGlzIHVzZXJzcGFjZSBsb3NlcyB0aGUgRU9JIGZvciBhbiBJUlEgQUZBSUNU
LCBidXQgSSBhbSBub3Qgc3VyZSB0aGlzIGlzDQpiZXR0ZXI/DQoNCj4gDQo+IFRoaXM/DQo+IA0K
PiAJCWlmIChrdm1fY2hlY2tfcmVxdWVzdChLVk1fUkVRX0lPQVBJQ19FT0lfRVhJVCwgdmNwdSkp
IHsNCj4gCQkJaWYgKFdBUk5fT05fT05DRSh2Y3B1LT5hcmNoLnBlbmRpbmdfaW9hcGljX2VvaSA8
IDAgfHwNCj4gCQkJCQkgdmNwdS0+YXJjaC5wZW5kaW5nX2lvYXBpY19lb2kgPiAyNTUpKQ0KPiAJ
CQkJdmNwdS0+YXJjaC5wZW5kaW5nX2lvYXBpY19lb2kgPSAwOw0KPiAJCQllbHNlIGlmICh0ZXN0
X2JpdCh2Y3B1LT5hcmNoLnBlbmRpbmdfaW9hcGljX2VvaSwNCj4gCQkJCQkgIHZjcHUtPmFyY2gu
aW9hcGljX2hhbmRsZWRfdmVjdG9ycykpIHsNCj4gCQkJCXZjcHUtPnJ1bi0+ZXhpdF9yZWFzb24g
PSBLVk1fRVhJVF9JT0FQSUNfRU9JOw0KPiAJCQkJdmNwdS0+cnVuLT5lb2kudmVjdG9yID0NCj4g
CQkJCQkJdmNwdS0+YXJjaC5wZW5kaW5nX2lvYXBpY19lb2k7DQo+IAkJCQlyID0gMDsNCj4gCQkJ
CWdvdG8gb3V0Ow0KPiAJCQl9DQo+IAkJfQ0KDQpFaXRoZXIgd2F5IHdvcmtzIGZvciBtZS4gIEkg
YW0gc3RhcnRpbmcgdG8gdGhpbmsgd2UgY2FyZSBhYm91dCB0aGlzIHRvbyBtdWNoIC0tDQppdCdz
IGRlZmluaXRlbHkgYmV0dGVyIHRoYW4gQlVHX09OKCkgZm9yIHN1cmUgOi0pDQo=
