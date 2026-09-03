Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09645503BC7;
	Thu,  3 Sep 2026 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463920; cv=fail; b=VkugPiI1szOgVyDrxoq6fc3yttk+RTIItn+cLKoCC91CVlTJQVq8ZHfDt+OwR9sYKKRoIptfpuLGioi8DczTKHcH5XO+vq5nn1Unjv5J0HHKp51Uk/BSA0sLdFY1i9IN4v5lOc/0W6G6qXPqKljU/eA7mGj6gIAGfgrvoOzJWGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463920; c=relaxed/simple;
	bh=U/hCe4pZXF+Eu6u5Gz28oYiQwRQQ4gSsJe2I2ZB54es=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RXdMsSU00Ro1WGZmMeEAiryIOQJee2AWgWHU5EwyGr4mm8KATENbXZ3yKb9FQae2ZSvW7uhY31BtPeZ+vNExkuiUvna6mXqlk/5YbLdNkBirnbhNFohZkeBhveJQMJ8PgKNJKZr8LcLLRnHDmroOaxKqJ52ZttE7xQEk2yDFlW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XU7F4UG8; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XU7F4UG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788463911; x=1819999911;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U/hCe4pZXF+Eu6u5Gz28oYiQwRQQ4gSsJe2I2ZB54es=;
  b=XU7F4UG8pFuXpgA93kLK0WSv/292yDoVgVGJ3QP6CBN5VYodxW6QscF7
   4hzzxvkMTbB5ZLz+e/EtRDOH+r17eQMYuO+D00W4U8Joqq8tLw8Q1DB9U
   DFT9z5XYRZPMdfkU4M2jSRNqRgiQ/GuPVZa+de6jA8a4xYadQ9LfVKo0A
   QiJWDS976Dj55vIrmdN9YXyJnHIPMDuGKxtHX2AF08X70NcTXAgdAMgl0
   Iq8ACUjDzTZcumioAH0DUy4Am1I9Y5IVIS//hc9I16xPZBOvjBM6A42mJ
   ZwbMJb1XSSporwsUMZ6aO2/DqGjlodRVNRyGJQfa0YGqMTnCc3y6RLSwH
   Q==;
X-CSE-ConnectionGUID: y55WlXQSRmS3h++dPc9EHg==
X-CSE-MsgGUID: VPbm/UgkRw23sWAeWxsmBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92657258"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92657258"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 12:31:45 -0700
X-CSE-ConnectionGUID: IA/lQe2qS8KEe6N3BSvrEw==
X-CSE-MsgGUID: Wnptw9RPRWKOmp/hhwQSlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="265489037"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 12:31:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 12:31:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 12:31:44 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.53) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 12:31:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=serOusAELncQYio2Og3t/UB9fkZVqb8hvjAgDoorxyAb7qa8TmB3fgwhcKL74OhYbwP9xw1KmzqgOfYixeuAZ91mkFOBE9kn4Bo9Nnbf0JdD5uxPyroxZfZvmW+d0UFgKsqCotZwQuADPBXEAmDINtyXRIN34C+OvgXstub4PCym6gCcXWJP24OBTmHM73La0DiCXmrAA2qgnYNV60XcJrLMY8erIYHQqp4xDG7w6iOB74RiCTZBwTXGvE+ac5uDSxUSheDwo/CdA5T+CaWxtASl0a1EyI+Llo4uHjglMyaA4Q5aOLNOyLkDdWyZ+EKxqcPixRwi/+pUJrJSj/Mqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/hCe4pZXF+Eu6u5Gz28oYiQwRQQ4gSsJe2I2ZB54es=;
 b=ShZVcmC0W2gsrc4y9cYFeJKIVBhcpXxjCkVUghTzynztlhsiCEwfWvrWZ3f0fa+q6LAkwFU2UhwcfYkXtEbsfiQev0iD1tXKucF18+HhYPJqf0z0ulomCS9j5dwJA2bykOjthLDP1jQ/Y2fxA5nnOPxShLipIDOo2IVCN81KdffZekF//j4yMYuKRnBUfGlOCKl4F8Ua+/e6AQ1PcAiLdXqeUgMR/uwZlYlnRaTe141n+L8OPL6aPqpTN2S+/T1EtMhIX6eT0hSJz0BvU1MlzF+YecX0iOEkneJ44IFj9ZrL5iRsujJJZS8RtyZi8b0N8uTkrgY7ZKz/EU+41bWMRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by FT1PR11MB420853.namprd11.prod.outlook.com (2603:10b6:170:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 19:31:41 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 19:31:29 +0000
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
Subject: Re: [PATCH v10 10/11] Documentation/x86: Add documentation for TDX's
 Dynamic PAMT
Thread-Topic: [PATCH v10 10/11] Documentation/x86: Add documentation for TDX's
 Dynamic PAMT
Thread-Index: AQHdO0a+mQEM0chOC02TaniOPpT/Wra9AJUAgAA+fgA=
Date: Thu, 3 Sep 2026 19:31:29 +0000
Message-ID: <7cd4a38ed0ab1618a90e1afc8d56b450d57a9374.camel@intel.com>
References: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
	 <20260903015113.93343-11-rick.p.edgecombe@intel.com>
	 <225572f8-5636-41fd-9315-ef5efb78f0a5@intel.com>
In-Reply-To: <225572f8-5636-41fd-9315-ef5efb78f0a5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|FT1PR11MB420853:EE_
x-ms-office365-filtering-correlation-id: ef8aa1d1-aa1b-46e9-5704-08df09f1f429
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|3023799007|22082099003|18002099003|56012099006|11063799006|38070700021|10067099003|921020|4143699003;
x-microsoft-antispam-message-info: w43Xllgv3d7Ag0lv6gCrcyyPjThQRmNn5ER2IxXUigBcYBn63sj7N/ZrqWgpIHakQbyjBhAO7kyQ4bFmRIUiXhIVJSdpEN+AHrNS/f+GgjuC7Nlrjidyipmi+4HaN1IUCPfx6zFbhzYk3FVSC4ELJm0gor5tI+enHTlC9CJ42r/StUIEENsmQDAsBN0l+ZQioX5vsB5eue+5bbEFKx59r6LZofU7H4NIln5Srizgpws7k1uJL8Q2FL9g4xjLhsadmfasAOlwgNat090yEuMpZ3SrAxFng2IvHjK2iNYdd3/ri5qaUMf3lqIddNUZTZDN3092JrLg0OwAmKyOwlq1PEw/Td0baTVOjjV2i9f/X04RztpIzPbwxGyw/sM9r6dTfasbnIswOq1BTNBm47VBjXNfkI1MZUDHMMAhCsrhzbqfMYCZPg6AsrT+hIV09VYkzjfI0ng1BWtg+V+kRrz9ImacELwNgIlTuqclaLZHdmzksOC5cdvTiIJvFFkdlZkkUL38a9O5aFLuaFWt2R9JTjohDhmtAa3L0Z7LxXokEoC2wp9qsTiGCfJJOzaIQuIUU2SW4RLB00k0nJME3YJdiOyl91GIXPtsbuSbah8jloonuzZ2bBuPtc/zFGMoayZiGqqUN9nTdUQmgrB0AR3agqeygFc/kppMdTR94PWWp+PlvKFqi38+X+AEWq788klZW4ehGKS7n5fo1yOGtNidYtVShf/i6Fo32UjEP45tZeuRnOm3vNPS1Ufo5h4wLVfZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021)(10067099003)(921020)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFVBS3M5Z0VwVFFWd29CQWNxdEhJUzEyRW9BQUg5TUlZdzJobTVJWm1oUFlF?=
 =?utf-8?B?SWtUaG5ZZXZSUnBsU2p3dzBTcDZRaVlzdkZZdTAwUXAzVDB2MWJKMGdNaHc0?=
 =?utf-8?B?bXQ1R2wyMXZvb0dWQzdjRnZIUUc2OHNtNnBkRE55L3FJbU82Vm1qblpTUzRE?=
 =?utf-8?B?TWdaSnQvamJvODV4dXg5N1h6N2s1NWFaRGFSenBEdmkvdnBrRjBGMlY5MlpH?=
 =?utf-8?B?UWZUcVRtNDdaOHRxWGJhZkxmTHlVN25CZWVTbTdnY25jbXk5SFYzaWFBdW1v?=
 =?utf-8?B?OUJ2QUFPdUh4YVF1dlc3V2ZXZFRtQkQ3T2V2dnVtZUdRNWxQN05YOUxKMUVV?=
 =?utf-8?B?c0swdERzU2FZNHBSQVhpQlovOTF6RHRjWnNiQjNvSGlpWGNvbjZ5dFlZMVVh?=
 =?utf-8?B?SVdvdnNUUldlaGk3Y0Zmd1NhNVR5M1RiN3lBamZ5emtPcTBEOWlLWUYxaDJJ?=
 =?utf-8?B?NEVoTW04UkFFNmtkV0VFQ2dWRms2ZFJvbEVycjBJdllDNFJYRlJ2ZnVITnZM?=
 =?utf-8?B?dU1pRDRiQXZkN3lSWUhUR0FFRXhBbHhwMFVPZlg5YjJKK2E5SkJ4eGo3Wlpi?=
 =?utf-8?B?RE15bHptSERTOW44bDhjdzB2UWhmMFBUTUJBV1V5NjZUSW9XMzJFVlF5anhn?=
 =?utf-8?B?Mm9zZ2VvUmc4TUFjcUxyRjZWaXUzVFAvL2FIVk13ai9leE1ORm1NdmNuMzFn?=
 =?utf-8?B?UCtpSm8wWFFpNXdORko5ZldPNVR0bXQxOEFPYmJueEx6cG9Eczl1NjZZTC9s?=
 =?utf-8?B?clZXNDZEUWdHVlVaREZsRlFNcGJqZmROWnVWbGVodnBjOUI1QVl5ZlhGODVw?=
 =?utf-8?B?bWtYdjZSQ1hhay9YNGNwV1JTZ2hpZEdnSTNSSGYzK3kyUW55Zk1udlIrV2xo?=
 =?utf-8?B?MEFVYWpyNXoreEQ5QlZmV0xPb0hQa3kvR3E5dFIvYjZGZFZXNVRodWxTYzFv?=
 =?utf-8?B?YVBIQnEvb2RmVVdKdUxUNHpMNzh4ZzJieHU2NElGZktPcTdrdXphSEJFSkpm?=
 =?utf-8?B?TWMrR0JpRlNqVzhkK29GZERWYmpXNTd6UWowVVliOG12Nk02c1ZnOWJNY2lY?=
 =?utf-8?B?Y29FVmRDbGs4SDNhRkd2bjdMQ3h5MFRlL3JQV09MTHN2ZVhvandzQ3RtWEJF?=
 =?utf-8?B?MXIwSVl4R3dJbGJmMmNkTk11Nk9hdDB6WlM0WGRPTnRUbnBncitLR0dQYUpk?=
 =?utf-8?B?QWxBSHIydFozWWd0SHozZUZ3WmlZazdVVTJnU2hMdkE3K2sreGxVY1F3S3Ex?=
 =?utf-8?B?RU91dERNSXJUWEVuMDdlM211RDVnblFZYUlUWm9NVWdwd0NOUkM3QUx0dEVC?=
 =?utf-8?B?eUNhTUZzUW5nVEVNaDNOTFdJVUI2TFMzSXhzMERENnJZZUYrWmQyZXBkSHZs?=
 =?utf-8?B?UUp2TEJwNzlGSmg1Z2ZiU0FFSEpCSmo2R0VJdVBTUGdxd2VJVmJzQVBTdWJ5?=
 =?utf-8?B?OVhyU1ZXSjNCOTlNMXhKMjdxYklPTWR4dU4zL2J5SjRlejJLbkdOb2NEQjYr?=
 =?utf-8?B?aytYV0dHdzJ1WWUyQnU3SmV2Yy9Ra2xnK2xWNElsVGZjMFR2a1J0aTNkalN3?=
 =?utf-8?B?QlFVOGw0MDRXR1lGWDBRL0NXOGg4eEwzck8vNXpMQ294WTBnamdQb2szaUE2?=
 =?utf-8?B?RlFSb0toSFY4V0JZTGYvOFZWM0IzK3hGRWo3bnVmUlNIZC9UU25iOE5rRjFL?=
 =?utf-8?B?bFB3eWl6dWhWTGUxYkI1RDRwZ2JCVTN1b2c0TElLenFteVRsVURwSFRLcmR2?=
 =?utf-8?B?OHFHNE1wUG45VHVwZkk2VURob29NN0dGWXRpRFJhdFVMZHNpMEh0SFRUckpm?=
 =?utf-8?B?OVV1eGk2ZXdZSmtnMkttUE5PbFJDaGRmN3lLVUhVZXlvSlF1UU5NUEdnSHJL?=
 =?utf-8?B?TTc0ellGQjA4Ry9TQ2xnZWhBUUNjZWs3U1o2VW9EU1E1ZWdoNWlrMjNudTdp?=
 =?utf-8?B?REJWMUM0MVNFejcrbzJMb2xGakR6UmRZRWdjZVdYL2FldzZ0Z1Z5d2ZjMXpS?=
 =?utf-8?B?NTRBakxaSmpZTmFyY2g4ZWlJeFF2NHkvcTRrMWxYclJ3S3lIcnI1VUQ3WlQ5?=
 =?utf-8?B?bmZuNmxOYkhRZ1RVUU5hRUNTQlE4YmdXQ0tiRTAvdSt1b2xIbFJSV05rZ3ZF?=
 =?utf-8?B?TkJXQzRvd2MrNVNyeGh5bDZHTnpnNWZ1YjdYcVRWN3VETml0NDVnc2NhVjRG?=
 =?utf-8?B?V3l4dmFNZGdWZTRROEhLMnVtN1RpOU56aEpTQ0oraElwekI4eUlheG1LS25i?=
 =?utf-8?B?WG1pTkowMURmWDdPaWlzY3dwVkUyemJWSUs4djR1M0tYemdjQU1nUEZna1N6?=
 =?utf-8?B?eU1pR2VIR1BZbzQ5Y3J0SU9FUnRhclV2TTJxd1pnUWh3bm80WVArU3V4T1JT?=
 =?utf-8?Q?+X9vfCemRWrnuMAo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D51655AC66AF24A9A4102C885EC4A5E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JhQ+HR4kZ/knwlW3ILKK8cMOJWkneYnWMdJ0xZ28qhzorBebQXVJPi62DSSh+k5xmJ5dJ9SZ8i+xlcKRNz6vioSVJu/JUJWpk3FQZmhKpET3ls3iRTK8WIPZNSEJrEN3JfMTlwFsFlD1CKAnjtJzp2Q0qAkxOQfymHQC+mu9LooINlEKOL31RX+BZXCxgFSvKfBtkV5tKLq5YcvLZ00FXcMkdi3mturUMPSMSR8+I7f6JEDrI3BfUJMSWFZO6PH5wUQKu198O6S1C1mrJ44cqFlb2j8ALR6EVV5WtsEg9Uc8pjl9yLKiWB3PBFQZU91PNGVCHXxE+azI6fQXnsXYRA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8aa1d1-aa1b-46e9-5704-08df09f1f429
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 19:31:29.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: os+kFd4eJyHp2ZTEjzYIX8TkGpS6neaZhyR6fwGcAXjwoC8umDdSG1FvDlHSiRagbpB7vWW2VJHmblQk1YkAfFtgZeXT9A4Ewvrf0Iu2jQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR11MB420853
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTAzIGF0IDA4OjQ3IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOS8yLzI2IDE4OjUxLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiArRHluYW1pYyBQQU1U
IGlzIG9ubHkgZW5hYmxlZCB3aGVuIHN1cHBvcnRlZCBhbmQgdGhlIGBgdGR4X2RwYW10PWBgIGtl
cm5lbA0KPiA+ICtwYXJhbWV0ZXIgaXMgc2V0IHRvICJvbiIuIFRoZSBmZWF0dXJlIGlzIG9mZiBi
eSBkZWZhdWx0IGJlY2F1c2UgVERYIG1vZHVsZQ0KPiA+ICtpbnRlcm5hbCBkZXRhaWxzIHByZXZl
bnQgRHluYW1pYyBQQU1UIGZyb20gd29ya2luZyBvbiBhbGwga2V5aWQgcGFydGl0aW9uaW5nDQo+
ID4gK2NvbmZpZ3VyYXRpb25zLiBXaGVuIHRoZSBURFggbW9kdWxlIGlzIGZpeGVkIHRvIGluY2x1
ZGUgdGhlc2UgY29uc3RyYWludHMgaW4NCj4gPiAraXRzIGVudW1lcmF0aW9uIG9mIER5bmFtaWMg
UEFNVCBzdXBwb3J0LCBrZXJuZWwgc3VwcG9ydCBjYW4gYmUgY2hhbmdlZCB0bw0KPiA+ICtkZWZh
dWx0IG9uLiBGb3IgbW9yZSBpbmZvcm1hdGlvbiwgY29uc3VsdCB0aGUgSW50ZWwgVERYIGRvY3Vt
ZW50YXRpb24gYWJvdXQNCj4gPiArRHluYW1pYyBQQU1ULg0KPiANCj4gV2hhdCdzIHRoZSBlbmQg
dXNlciB2aXNpYmxlIGVmZmVjdCBvZiBoaXR0aW5nIG9uZSBvZiB0aGVzZSB0cm91Ymxlc29tZQ0K
PiAia2V5aWQgcGFydGl0aW9uaW5nIGNvbmZpZ3VyYXRpb25zIj8NCg0KRFBBTVQgZ2V0cyB0dXJu
ZWQgb24gdmlhIHRoZSBUREhfU1lTX0NPTkZJRyBTRUFNQ0FMTCBpbiBjb25maWdfdGR4X21vZHVs
ZSgpLg0KSW5zaWRlIHRoZSBURFggbW9kdWxlLCB0aGlzIFNFQU1DQUxMIGRvZXMgc29tZSBjaGVj
a3MgYWJvdXQgdGhlIG51bWJlciBvZg0KY29uZmlndXJlZCBrZXlpZHMsIGFuZCB3aWxsIGZhaWwg
dGhlIGNhbGwgaWYgaXQgZG9lc24ndCBsaWtlIHRoZSBjb25maWd1cmVkDQprZXlpZHMuIEZvciBh
IHNlcnZlciB3aXRoIDUyIGJpdCBwaHlzaWNhbCBhZGRyZXNzIHdpZHRoLCBpdCBzaG91bGQgcmVx
dWlyZSBhdA0KbGVhc3QgMTYgaGtpZHMgKDQgYml0cykuwqBJZiBhIGxvd2VyIG51bWJlciBvZiBi
aXRzIGlzIHNldCwgVERIX1NZU19DT05GSUcgd2lsbA0KZmFpbCBhbmQgaXQgd2lsbCBjYXNjYWRl
IGludG8gYSBURFggaW5pdCBmYWlsdXJlLg0KDQpUaGUgVERYIG1vZHVsZSBleHBvc2VzIGlmIERQ
QU1UIGlzIHN1cHBvcnRlZCB2aWEgYSBmZWF0dXJlczAgYml0LiBJZiBEUEFNVCBpcw0Kbm90IHN1
cHBvcnRlZCBkdWUgdG8gdGhlIGhraWRzIGxpbWl0cywgdGhlIG1vZHVsZSBzdGlsbCByZXBvcnRz
IGl0IGFzIHN1cHBvcnRlZC4NClRoZSBtb2R1bGUgZm9sa3MgYWdyZWVkIHRvIGNoYW5nZSB0aGUg
YmVoYXZpb3Igb2YgdGhpcyBiaXQgdG8gc2F5IGlmIERQQU1UIGlzDQphY3R1YWxseSBzdXBwb3J0
ZWQgKGkuZS4gZG8gdGhlIGtleWlkIGJpdCBjaGVja3MgaXRzZWxmKS4NCg0KU28gd2UgaGF2ZToN
CjEuIElmIHlvdSBhcmUgaW5jbGluZWQgdG8gdGhpbmsgc3VwcG9ydCBiaXRzIHNob3VsZCBhY3R1
YWxseSByZXBvcnQgd2hldGhlcg0Kc29tZXRoaW5nIGlzIHN1cHBvcnRlZCwgdGhlbiB0aGlzIGtp
bmRhIGlzIGEgVERYIG1vZHVsZSBidWcgdGhhdCB3ZSBhcmUgd29ya2luZw0KYXJvdW5kIGJ5IG1h
a2luZyBEUEFNVCBhbiBvcHQtaW4uDQoyLiBUaGUgYnVnIHdpbGwgb25seSBiZSBoaXQgaWYgYW55
b25lIGhhcyBjb25maWd1cmVkIGEgbG93IG51bWJlciBvZiBoa2lkcy4NCg0KV2UgY291bGQgb3B0
aW1pc3RpY2FsbHkgdGhpbmsgdGhlIFREWCBtb2R1bGUgd2l0aCB0aGUgZml4IHdpbGwgYmUgZGlz
dHJpYnV0ZWQNCmJlZm9yZSBhbnlvbmUgd2l0aCB0aGlzIGNvbmZpZ3VyYXRpb24gaGl0cyBpdD8g
QW5kIGlmIHRoYXQgaXMgd3JvbmcsIGFkZCB0aGUNCmtleWlkIGNoZWNraW5nIG9yIG9wdC1pbiBh
cyBhIGZpeC4gVGhlbiBtYXliZSB3ZSBzYXZlIHNvbWUgY29kZSBsb25nIHRlcm0uDQo=
