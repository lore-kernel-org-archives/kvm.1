Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D062D5937;
	Tue, 31 Mar 2026 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995706; cv=fail; b=kedneCH9BAHAD4SY+2//m0VjrGA00QPnPkWKOPREtEXNLAUDGfUWdzh6+sb3qPxvUFdyc7sewBrDgADwqV08JZC2lY8Yz/JZtrDlcQnxwxF71hxfz/ZYQtY4NNcZyeXWaHTCEswtDyf5/7DC+SrSvXCvLbdvtw1mSR4N/9gs1yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995706; c=relaxed/simple;
	bh=O+YhVCGIq0Ffusw6R0LKA8HRvrTYdnn2z9jti7tMiGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NvQCQ7U7sR3C2jen+lHA6/hTjR85bbiqYGhQahcy76XMd3AGJXNt661d3fyuqWWuA+jBjZNQ6/ou/TVTm8cXCNU5JhPna9kqqFv99WCO2nKf2wIYzk65CMFqPxzhikKwhS1P2VoPV4/JHmYxE13UnI0mafLklBockPCwdDteSRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGN5FG3w; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGN5FG3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774995704; x=1806531704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O+YhVCGIq0Ffusw6R0LKA8HRvrTYdnn2z9jti7tMiGY=;
  b=iGN5FG3wWCQP2PFdhF+zFXxV7eYZWBr+rpLuFUNVQFCBtnzd1JSG8/jz
   CFyx5TpsSFS+jgBVgXsP8XzSs+P8NJsDLKnO9qA+nmLaOnuiegz9j8vvt
   PfM1RIk8oDdJ+w61sb4KYc90Llasig63ns4RPXwLjMntLatUwk5n6q2I0
   /zuxTELVcEZ9yPYNNIKlIbuoYl5Q9RdEXp8Eu2mf0bNMDV5k/vfPNAip4
   nHv/mXNlf8g2d9b29EfjENRO5oVOTXP8NKjqW1y3lmFM8O9cO9J3vB0Ym
   ZWNz3eyW9CaLd18OTyMCeuPa2ZaKxDeBl9NTke8IAQYgbFaLcGbaIz1kn
   Q==;
X-CSE-ConnectionGUID: m4XKS6piRnizh8phEEFnlQ==
X-CSE-MsgGUID: zfc3KsvxTAWkHNJ/fd69nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86722500"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="86722500"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 15:21:44 -0700
X-CSE-ConnectionGUID: PRpoWnBRQYaRfacYznCDLw==
X-CSE-MsgGUID: hwwhvw09QYqmD4obX2s/Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="230561459"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 15:21:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 15:21:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 15:21:43 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 15:21:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jz5lUw/deCahSwuS0r3kcQqDbCoinZgC/GUotBc8nlqW0lXvB8XS0Wx4LN8XzOtWt2rdxFPrlldmnDUJ1h2oLVvi+lBocQYGKVcBgtT0dwfG+leLNmq7cjGkaUl1rYL9Dtsn34K8TF+s40hOtt+uZRGGIiG9tP+cudMrJseAFegcXjxqOETA28USRvfgJ36O8Yfe0DtBL3D0/Heq7F96XKw+uKkSLZrvVzcpDKZHbhiWeavrwpo7nqlipm+7OS5TkthK6isoepIOEZtK999fV8CyNr1xIiRXvkVq7gvZXK2AhTjF4dTwMn5MROuLBUpsSxtzzcMtUZMMbBKaiM13Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+YhVCGIq0Ffusw6R0LKA8HRvrTYdnn2z9jti7tMiGY=;
 b=ZHAbsDkclhK6Z9q5iT5FlsWSQd/1Z9UNoqVOfySwbjVkcM/wZgz82lQdd7qRQPOXtQXDyD/ZEHgZATKZZN4/l9JjjpQzbEHSBFsG7X8qbbS8y0S4cnM5aO0KXBpmMHRzNvVs/o9X3lE0cAeDRqk7zhg1IMd9gVuOMMCksPNAYrmDus0MhWFhAvgxMAnhANra7Uqa2xogo2Kk0Vrse4CWW4L090jASjwTkxWQdFi6pbVvRHskQH9Ogziizd3nHc3/p5+uxHxXRf4iPN5UkiGmdsGdnSryFGiRgFwTgl5FRAQ2OBgiym9SGl8JKlnIelzGjgak9WArk+OUupfUUEagag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by CH2PR11MB8867.namprd11.prod.outlook.com (2603:10b6:610:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Tue, 31 Mar
 2026 22:21:36 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::893d:78de:7a85:7c8c]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::893d:78de:7a85:7c8c%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 22:21:36 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Pull kexec cache flush logic into
 arch/x86
Thread-Topic: [PATCH v2 2/5] x86/virt/tdx: Pull kexec cache flush logic into
 arch/x86
Thread-Index: AQHcuwfzpAtra6mY6Ueuk8SDGwySQLXJEVUAgAAyE4A=
Date: Tue, 31 Mar 2026 22:21:36 +0000
Message-ID: <6ad3ff51bbab85147b716de0b1f4e8b994b1998b.camel@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
	 <20260323-fuller_tdx_kexec_support-v2-2-87a36409e051@intel.com>
	 <acwe7kKyjfEQ0sIf@google.com>
In-Reply-To: <acwe7kKyjfEQ0sIf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|CH2PR11MB8867:EE_
x-ms-office365-filtering-correlation-id: 18a1b412-f63b-4019-283a-08de8f73df33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: wZq8qqiTnxQeteGFcEomFhrlQ1UlWXHBKL4kBLW3K9K4NKgO/ZxYVvNm6znX0DLwH3oj4J9NXGfy5r8By7M5SZxkFOvh3sI7pq8+NE4Hr/Rs8WdXZbSTNJ3XzzAzABQ6K/82fYy5+fEqtrZIv039p3SXEOqQ1HXgbnAdSfRHQI3TqOZluGKURJEDH2xQ4BBG2oLXEZSvBR6gatNs4vYAGDKXN4uDZvyjzVACKGvP/YoIlMctMi00gwMcFdsf2O8ZI7BfKqysftsAjl8GRxaS3j5cnc/k4apna2+m2Ze8sJjXKEXLFLcnLX+oRrR7eYw8VZNSEINhys9Hq6M0/W0vz9k+NVnotCTOn3ZlBs2I7b05yW+f9ywfEejyszdd07TpuzJanzz+JhDLomMrO8YKeLxV8nySz9v4d5LkS4P48kxzsoBA8Kf00JQlhvefWpMh/bBZ/3YKL1RkNqIPRKEKUzELj1B3DOFhhkL+DN4KcHBAipeVZgdbSDmnzgTR9cC1IPwJgX28cf9e/KzgD7fDZMjSxqMMV4U6gaqUzyQGwhGhC2gzZXgQT9TC4VJVBbCzQKiuSAdZGkXLkktG8AJKDSkc8PGUhTmdXjbAkfhfl/59fOj+n31F3Rdvwcivp0dtKCuWlI0wvuxdUEk5cKlkZ8Ny/CQkgW2b5ndbtuyUdTwZKrF2nlSB+g72Oy0lirjZ4fRMok6iX8Qp3iA2qjHPVkFoZ2mLAsDFwW9DzNDeOWw2LrPagdkP+4Kcgxj4LsiWZHVbpEbn13TFU3DBykzFi9t8pPoi48+kW/pcKydkssrRZtTAYC2Y1KWkfBF+xjET
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGNhSU5YVHRUbDVPcVlWekFCUTErYVErMnZSMDF6OTBkdmQ3RVgxMjQvWUVN?=
 =?utf-8?B?akxTbGRkanhRYUVwRERRdW1BUUU4dGNHMGhZaWNtVnYzcFY2RkZBV3BvakRs?=
 =?utf-8?B?OG9Oa3FhZFBQcnRwV05na051bDVyODh5TnF5OWY3MytxaVE3RS95TFlrK3Jq?=
 =?utf-8?B?c1dPU0ExQzloT01BQjdLTTFORFM3dHBUeGpjRW16dWNlb0lzZThGT045S1dp?=
 =?utf-8?B?cHFEdmlidDdtWHNkVHNYeW95bDZCVmpXYkhiNkwvUUZpeFJMUVhaeFpJUFht?=
 =?utf-8?B?L3ZVTmxPcFpKMldWYnRKeGZmWjlkMDBUMFNJZUJCWGIxQlFrMzF0YmVNUTlG?=
 =?utf-8?B?eFhIWDdJV2JjNUxLOHljV2VjUTZKLzFkNVFJOWtiVFV1elFiVkxhMGNSM1Jj?=
 =?utf-8?B?M2xyLzBDSkJMVUVaTlBUWGJzMDF5SEY4d0tKVjM0OGhYUi9ydjRaZ0hDSjhH?=
 =?utf-8?B?VS9aNDY4ZDQxMko5R0tZUis5MTN0bUR0bGl2SUtnMVZ6dnpHNTlGdlgza3Y2?=
 =?utf-8?B?T3l6UlFqeHQyT283U0R3UzZ0b0UxdWhWSjFpaE9jOEs5VkpBbkNNZGcrOXND?=
 =?utf-8?B?RVVBbUVoZjhnYytLaGh5NjU4em0raU5zNDF5Vk5DWmUyUVR1anpOeVNKQWV4?=
 =?utf-8?B?Ulhzemc1VVkwcWdtTGZjbU5nbWc4c0RqOXFwTlRvOHEwTnhNWGVpVmZzb2t0?=
 =?utf-8?B?RG0xWTB1MjFNRXpSeFFpK2ltd0tyZSsyNlZrZ1ZqeDZvVDB3VFB5MmpDN2tY?=
 =?utf-8?B?cVpYRnE4eTdWSS9TaHE2eEZnK1FqOXN6MXY4R3lhOFhZcUpsUy8zT0FyWHBy?=
 =?utf-8?B?b0VQdXU1NGdaV2tuZzZuNmkzWC9FM2ZTNHh1akJqVS9OVUdaRVNsUXB5Ungz?=
 =?utf-8?B?Sm5aSWY2Ty92M0QyWUp4b01DY2xaNXhBUXVnenV4azJwdUJXOWZXcXJGamhE?=
 =?utf-8?B?WU5taFplNytieEFpYWNBVUlQQlpRT0Q2QVNoMm9sYjVkZkNDanB1VjgvWk1p?=
 =?utf-8?B?SzMrYVdZSHRHQm1xWE9zcElYdTN1RTA3UHRxZzlsK2lxaS9QWVp0VFNLcXpF?=
 =?utf-8?B?RGhrMEEyZThiM1YrTjl0VFViSnV5Zm0xOUc2ZUpibjV6cFZjcEdEZDlON1dP?=
 =?utf-8?B?bGRlSWJBYVVUZlhWNW5CeS93OVVoRW9tZFVDREgwdUtZdGYwVmNEVzFPR3J4?=
 =?utf-8?B?UGR6OG9LSFV6eWFqaGxXWGNndy9UN1lUcjg1VTNaZEcrdGRnaWFnWlVFVlhi?=
 =?utf-8?B?dHYxcExvbG9samRNeFJnWGJsazcrdXloeE9ubVcwazloYVp6b2F4eGN3L0RW?=
 =?utf-8?B?LzhrcmF6ZlVCYWRIM1JPQ2ExV0FCMVdGb09DQUNhb1U3eXdJSFc1U3I2WFJP?=
 =?utf-8?B?T2k0OWIydXNUcVlmVVA3dHhJTkYvWWVpY2hlakhPVDZsTVFsM2ZpRWZVZFVF?=
 =?utf-8?B?RmUxYVhDdTB4WG5xbXdCTDdrQ24rVEI3SGtEYk9WU0drekEzYkRQbjBXVlJt?=
 =?utf-8?B?L0VUMnNJMW14QUtXdndjbFArTDNSeTZ4LytqR25PRmtqekJkOXFYUjVSSng3?=
 =?utf-8?B?SjMyRENFRiswMkRrOGN3QmcrTnNyN3RldFNPbE1nbGtkSmZpQUZnZUxER281?=
 =?utf-8?B?cEMwVmNNSzZiOW1HTllMVUhIc1VtQlF5L0hrdkJqaHhKM0ptOTQvTStvLzBI?=
 =?utf-8?B?K0hZbTBOTVArMXBWdTZiY25pL1FQRDRRbnVmdkhKTi9VODVpNVlaUzRiSFlr?=
 =?utf-8?B?WFVTRnFqa0xYbm13S3lMWTdRajhDSFVKY25xRWF4LzUzM3FVdURZdjZZVzNt?=
 =?utf-8?B?eGxsVVc3eHVrZmpsNFIyS0tpdytmNHVTMUUvOFdvdE9EM3VIbjVFOUp0cE5I?=
 =?utf-8?B?WE1HcmplVmtyOUpweExvUTBoZzVDTHpWYm9XU1F5OGZneWRLSzBCOWxlRHhI?=
 =?utf-8?B?M1Ura3F3OU1uUmp1OXdEUjZZUmJxYTFZTFpaNUJIWDJMVDAwL2JHZHRpV1E1?=
 =?utf-8?B?Nk90dkdtYnJldWRGZ1JabVB3eDRJR0h0ZzhmdDlaUFN0Ti94eE1mVXpEWUtW?=
 =?utf-8?B?V0FXZGpzVDhaNGZuMkZxaDlVWU4vb1ZyWWpOS05GLzRVb1ppcTBTazRlaGZr?=
 =?utf-8?B?U1BnUjlmVXBMbXhWN3QvZnpjVGhlSEdCODlkeGVNdE5hU2UrSjBKVXJQU3Nr?=
 =?utf-8?B?V0NWcVR0b1RTb2RRUUppbGoxUjBRZ1M1Mks1aHc3aE4wNzlBVWQySXB5NXk0?=
 =?utf-8?B?R0JDOE5SSkx5TkxGMkhPdlJwc21XTkQ4MDh6T1NGMDJVTUxqbkw5dGYzbzlQ?=
 =?utf-8?B?MDM0U2RBUEREY0ZWRkFKdE9nMFlzM3ZXNUo4SVZMMi9sNnJkVmx2cVIveXdG?=
 =?utf-8?Q?ALhA0I1fT1IvKR4k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F548CCF8C5E3F241818008C300CBE729@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EqnFAuT16T4VslfEUIqg9KHkFOabfMTBmiDiCVzb3gzt0vbY8vxThE+LRHVVTDUJKyVLg1wbVbPYDcjFprBXQUVmHHL/fO58udx08yxwEpwcVzQw+w/TsiRqJrmbXJlwLirrp8x2j5eB2N/s5JfXKv4YbQAMxHHe87ltqtdDaSk7oSrGlUGB8lUpWBx+Kj1szQncQsTTJXNngBwi/hfySLMHDVEiohEVRKsFcIrCCPFLG5JFnQ5A0g/KHvXSctM7vUUah3kn10UNi6Jjt350mqCkdyr5zfk9ij8EYP7tEPriRcqewDWloVbiyIurNkfmh7fi7tV6RLOv3DsMTT/V/Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a1b412-f63b-4019-283a-08de8f73df33
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 22:21:36.1357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kME2MTIIK+KgtWfBrpTfoxNhNm2d475QPNZNeekggEG7nSj1c/yOPa8fJJYMdWzy/PTBg8VetEn1ARNrUEgvWiM8N+P4MPbFa8rzYhim3fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8867
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDEyOjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IC0NCj4gPiAtI2lmZGVmIENPTkZJR19LRVhFQ19DT1JFDQo+ID4gLXZvaWQgdGR4
X2NwdV9mbHVzaF9jYWNoZV9mb3Jfa2V4ZWModm9pZCkNCj4gPiAtew0KPiA+IC0JbG9ja2RlcF9h
c3NlcnRfcHJlZW1wdGlvbl9kaXNhYmxlZCgpOw0KPiANCj4gSXMgdGhlcmUgYSBwcmUtZXhpc3Rp
bmcgYnVnIGhlcmUgdGhhdCBnZXRzIHByb3BhZ2F0ZSB0byB0ZHhfc2h1dGRvd25fY3B1KCk/wqAN
Cj4gV2hlbiBjYWxsZWQgZnJvbSBrdm1fb2ZmbGluZV9jcHUoKSwgcHJlZW1wdGlvbiB3b24ndCBi
ZSBmdWxseSBkaXNhYmxlZCwgYnV0DQo+IHBlci1DUFUgYWNjZXNzIGFyZSBmaW5lIGJlY2F1c2Ug
dGhlIHRhc2sgaXMgcGlubmVkIHRvIHRoZSB0YXJnZXQgQ1BVLg0KPiANCj4gU2VlIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC9hVVZ4MjBaUmpPektnS3F5QGdvb2dsZS5jb20NCg0KWWVzLiBB
bmQgYWN0dWFsbHkgaXQgZ290IGhpdCBkdXJpbmcgZGV2ZWxvcG1lbnQgb2YgdGhpcyBzZXJpZXMu
IFRoaXMgcGF0Y2ggd2lsbA0KY29uZmxpY3Qgd2l0aCB0aGUgZml4Og0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8yMDI2MDMxMjEwMDAwOS45MjQxMzYtMS1rYWkuaHVhbmdAaW50ZWwuY29t
Lw0KDQpPaCwgeW91IGFja2VkIGl0IGFjdHVhbGx5LiBCdXQgSSB3YXMgdW5kZXIgdGhlIGltcHJl
c3Npb24gdGhhdCBhZnRlciB0aGlzIHBhdGNoDQpoZXJlLCB0aGUgc3BsYXQgd291bGRuJ3QgYmUg
dHJpZ2dlcmVkLiBTbyBpdCBpbmFkdmVydGVudGx5IGZpeGVzIGl0LiBCdXQgdGhhdA0Kb3RoZXIg
cGF0Y2ggaXMgbXVjaCBtb3JlIGJhY2twb3J0IGZyaWVuZGx5Lg0K
