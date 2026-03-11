Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261D31F984;
	Wed, 11 Mar 2026 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266795; cv=fail; b=jdfBNGkdftYfoJhmRiFDHcZr82aTr2Uu9tD+VM/fIzmBnB3xOMMeTlKa3HLy9QQpJKsWXZITcGavAXUpu5z/ll4PAkyvIU57mlJj/qTgbaYQKzDH0KGy08K196C4LOioFMK94g2TgjztnDEYkqdkK8GDDh2XZbwt7t5vIYMQ/SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266795; c=relaxed/simple;
	bh=ktpMf9Uhnrw0FjuP6qLaKfBMHrlEWNEajJihZ953CYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lruULl2dB3z/0HC873KJ7V7FMlZbeyxfjcuqzqsOXvagp7SS+9wyBdqEHKX8uXPkk4rb4UBRxIzBzAQKYv9CfYWF5KspMadpt//5R4fBtv2bM10CI7os7Sc8qpp2E9wLTwhFBo81nPWv9ooEiD0/F8boiXftSgxn68jEFMhEsjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ozv9V3D7; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ozv9V3D7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773266794; x=1804802794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ktpMf9Uhnrw0FjuP6qLaKfBMHrlEWNEajJihZ953CYw=;
  b=Ozv9V3D757iDK//PZsDsurL2n7Wyolv2WDeZ7tEuUbnxVMhdU2XhmdBT
   a4NgEw0U0ohfZDy41K0iCFSuGzXfYmNCGrJsqMsSXBIBXgyMIb3a2A47E
   Ydw9bdDlJCB3COf5Zv0pWU+zE9svHvcsyjQKrwQmTIvKzqh8lvqmN/ffm
   kJ8z7lsnxfTJpaimXiEpzK75z5j4Xwynnf9LCwTtu6JBOPvJpLHBqa0Bm
   90uRemiTpW3d9ZfEg46UVoeiBUr+FCwGi14xP521MjOokLmAkjaYE6pjx
   cd6eHwP/nQ/v+mbGZW//KqzsJg4aK6QCXPA7F/rbX9i3pZYLt3DXIduaS
   Q==;
X-CSE-ConnectionGUID: 7qwfM6kMRXiegq4tZCwnZw==
X-CSE-MsgGUID: Qutoj0I4RlaXgwBhD2vFDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="91731270"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="91731270"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 15:06:27 -0700
X-CSE-ConnectionGUID: UlV592/PRka+a34Mazt9vw==
X-CSE-MsgGUID: 3+UvmOpOTPKFe3SHU0X35w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="218074337"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 15:06:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 15:06:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 15:06:26 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 15:06:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyaEXIlyTwUglxzWPZgQOYARUFoVtgVchstd0fqOPRdk4aSRRQgSB2BD79cFnqGumeTEGuGoYuKO7I+XnG5+tofWj+Lh4Vj/pFjAYbj5qGDaOLOccVtaxtqNhMPBi7awH6QDvMuhCNeqzA+/DYgRiO2ezMWp289QfMCW8HOzGYkGUXVkPzm1RUXBBs7qQL8LnIFwp6qmiuWorX1+8zccpmTv8qNftq0Su4nBmU3IEzqjp7ERd58PiwmM6oreikBIsdmMvhRDCG1kfoxSThl/ukydJPXSmmUa+6YJvusS6NHmJzPnLtWnnqe7JE3JLjcieD8oM7IzDWU9ukOjRbUoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktpMf9Uhnrw0FjuP6qLaKfBMHrlEWNEajJihZ953CYw=;
 b=aEufI4vrK2MPxFA1JHWW2LjcEXIozGTcfrQ+55CKwBzRjtXVg2nMT8rSizrXK9DpdP1TP6kLqrv7h6aZEtVNjeh4wagIID4VHw59OI7oIKo/BAlh0/wCldgiMdvD+p2jI+9pPPggdCEuKEkpYkO/bU++cea1VbfAiW99CTubMl0bEAP7PXiYa7FIkS5S/s7KHgv+ll/Ag3fmjghEK2KmU41r+zDqVmgtO1b83IUfjt8Vse1uasr19s1cluf2y9FOmp5vsWy6FR9P0MTx8AJGJSvvYT5W9VrRtX49ulfInPYLpbcip/gZW/TzuuxzNk9+JKtj0oW0h2gdW4ui4pKecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB2647.namprd11.prod.outlook.com (2603:10b6:a02:be::12)
 by DS7PR11MB9473.namprd11.prod.outlook.com (2603:10b6:8:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 22:06:23 +0000
Received: from BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::32d7:4779:29d3:a1ee]) by BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::32d7:4779:29d3:a1ee%4]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 22:06:23 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "kas@kernel.org" <kas@kernel.org>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"sagis@google.com" <sagis@google.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v4 24/24] [NOT-FOR-REVIEW] x86/virt/seamldr: Save and
 restore current VMCS
Thread-Topic: [PATCH v4 24/24] [NOT-FOR-REVIEW] x86/virt/seamldr: Save and
 restore current VMCS
Thread-Index: AQHcnC0D6N826aOF4kysQId97d9HJ7WpcuAAgACbWYA=
Date: Wed, 11 Mar 2026 22:06:22 +0000
Message-ID: <d664ac9445b1c7cc864dead103086341c374b094.camel@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
	 <20260212143606.534586-25-chao.gao@intel.com> <abFlCkNd7tqaUyAP@intel.com>
In-Reply-To: <abFlCkNd7tqaUyAP@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2647:EE_|DS7PR11MB9473:EE_
x-ms-office365-filtering-correlation-id: aeadc0ba-2752-4dee-6338-08de7fba6efa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: gRz/twszgW7cN3C3v5loatjKJ8OAUWPTZpF8mLZ6jL+sHrTqUjLIJK5joaUig3h2b3gqS4AzrqncIQsxsWKFcFHX4waivHFGIZ8X79M40LxG5QuMPL5d1AI58BELVuOdBaM77gHFNnfNUiURanL0NsKFiqu9SREdMWpb9xB13avSz/jm0sKl9TXj8PS+FEua0O2BzcK0EAfBeIsjWa2denBH1tQOi7Vfo7M+1BY4APJHyeSjvhsSK4muAr4HbWYheu44LzKXJUtpcPFgkc93d8+vEE3u6hh25xvTiTv0njSLRQcnY0lJPL1aO4vLTS6MVsMAq19/OwbfZGXJSgSCN14S3ZYK2GWFBFaooLjkFSyz6Wuqo9LmjXJeMAX1qJJRssaIS/udq7I92o2VzxhsA1daaVZq4eNu/WEK6kMSgU/3oQPMHq8hgONaYj/R3v7p6zSNOWm1XaAbsNQJw8qOpIBTq9wB3+y5ko5nb+8fM8q+B1ZCeHYSAV+rFcXRxlEE+uDAtMXAW06pN6shmVEQlCBJl8YyJkCxvOiXWYE3/R96vCn4SUopj++M/droHPX96NEWd5POWPglMoTBiom7n9TjWiEtJhPChF/vAbkMrM7bBtTAg6FKPjB5X9Du1wwng5acaZk1TjlWfNgNGi/8jTqD6txdbJ0+Zjd87HYxmBqDIRK9NgheY71NKekP+Rik506UPNewPt2qjbJaFW9a1BdZQD4qi93O6vrSwDX4lVmHbbITYrIsNMGHJNbBgVtdXKqI7OAzhjlHxybgTza17KgNBccVUN09whFfdmCxbt0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2647.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTZxZVZ3SGc3UTFOS3JMV3ZXZUtVbXUvdFkyL0dzaGtWcnA0bVpDWWRhOXMw?=
 =?utf-8?B?NHFJMklLZEZZZ3VOOG9oOTBZendyOEhVQ3pDQWVoVGNvaGdvSEwybFZJRVJ3?=
 =?utf-8?B?OUJKNENpeFJPdkxFRzZKY1VkbGEvdm5qUlphbSs1b2I1OURudzVBang4Z2xS?=
 =?utf-8?B?emM0Vi8zeXU5d0J1THN2b1hNU1dTSW5EVm51QnFmN2dDUnBEbGIydXZCQjRJ?=
 =?utf-8?B?dTVWbkpzZTMxZFY0YlE0aWZ5WStVWXZwbFFzQXU1SmtySkZZcWJGZk1aZ1Yr?=
 =?utf-8?B?QmJHTFZhaU40YW1ITlQySEFSeDFWZnpYcGlPeG5nMk5FdVpFRmFkZDh0OVpK?=
 =?utf-8?B?dTN6eEVyR2dzUFZUODNramRQaFpvREphRDRUZlF5VStrMFIvOVlqanluZ3BB?=
 =?utf-8?B?WURLU3ErRzd0WWo5a3diZThMeHhQUGxwVlhueDREcUt3UXRSV09UM3pRUWVE?=
 =?utf-8?B?YmR2cGw1WjE0bUVWdkRPUEFNZTY2NDlodkhLT2Z2L3QvaVBHaFF2cEs2aHFw?=
 =?utf-8?B?NmVjaHZjSzRIaFNBTzJ3Tmd0VUtXTGx6dy9PR21ZYldpL043c2Y3aVd0dFY3?=
 =?utf-8?B?b24rWEM5ME9VZEw2YXhjTjQ4Q3hNamw0a29ydG1JUTMyeERaMW1HSDBiZ2F5?=
 =?utf-8?B?T2dtUkgwemdrQ2dtSHNtR1Q4dXNBSkVzK0ZTS2FwTTdBL013UUpyU2lERkx0?=
 =?utf-8?B?Q3dwNnpxOUw5bGtkWjh2MnFkSnlHVlZ3c3VkZjRBb2R3dFpiSFBZZzVWQVky?=
 =?utf-8?B?eWZpUG5CSk5qZTFYWjYvNE1IMlgxTkpjU3ZPK1BzZ09IU0FhVWRUZXBhT2x1?=
 =?utf-8?B?aUIvUUpPOWRGMDJFd25QYVloNmVhRHp1T1AyVW5UL1Nxa1dvdE1Ld1lCZEM1?=
 =?utf-8?B?TDMvZzRtaFZsUnh4TEtxOGRtV3hqaEVqaGtuVzZ0eUdsV3VpbmEwb1pMaVdM?=
 =?utf-8?B?d0FrUytBQS9xTEpGZlZXUzFCSUxPREE3TzllWjVkY2xoQUZUWlU0VnBhclhN?=
 =?utf-8?B?elVWNm5keHBYcE1nUG9aRVRnd0hicVNDNFdZaXZjTmRYNEtqNmZRWVA3NlIx?=
 =?utf-8?B?Q1pjWHhGRitlaWJKRmhvbWZ6R1h2N0hWTEpEUWloTWxnQU9HbmhDZUR1Wkh4?=
 =?utf-8?B?VnBHd2V0R2FhYS9qMXNFVkJGTGJkcktvYmh2MzhqNzVFZmd5NWUyc0t3L2J1?=
 =?utf-8?B?R2wvSEw2OVRUQmV1bDAvY0gzY1hDVlV1T3cyS3FldVpKdG5SVnVZb1phWWs4?=
 =?utf-8?B?aVFYeDI4dDRCZEk1TFRUOHkrOXh3WDBKNkVIc3MxUXFkdVNXOWtBeU1UVkhW?=
 =?utf-8?B?aXF0QVk2WkRHc0tKcE53cTlwT3BpMkt1akJWTnZJQTh3NkRLYXlUR00zY1pQ?=
 =?utf-8?B?UXpPM1VMeWQ5R09OZmY5YU1sbWZpOGNiS1pycEJ6WEJxVXN3dGpEOUpDYVFH?=
 =?utf-8?B?WEJmeXJYYTUxL2Z1dFU5NnU5VytUbmxsQjZMS0pLcWpOYlBBN1ZSWUhEVmhP?=
 =?utf-8?B?Wk40TWo1ZEVYK0UrSENTUnFvTGVHUkUwRFNkSjdpRGxZaUJSKy9CVEZIVTJX?=
 =?utf-8?B?R2syaDlTa29DZlRRUVkxQkFyejR2djR3clNTWERkSUhpNE14bXhONmhuckk0?=
 =?utf-8?B?WWoxaWpHNndNSDIxQ2hKRnFLRDd5cVB3Y1N1NE5uVGV5M0pVWU9MK1M5SGpP?=
 =?utf-8?B?Smk0Y3Y0bU9vYmp1Y3ZIVlAveUpHRlF6RElsejVvUGl2TFIrT3QrcWNqbWVG?=
 =?utf-8?B?VytUTTNhS0xBRG91RXVxOFBIa2JkOTZKZ0p1NFBSelRvUUZ4emJtcFJYU1Rn?=
 =?utf-8?B?UC85clF3RkJkL2N6Nnh0VVlJeDJlZVRkUmtQaEt3UkJVSTIzUEt1UzdRdE43?=
 =?utf-8?B?NytVWFMxakRTeXlWcCsreE9EUXpLK3lnaVJxeE0reHVHdTlOQ2ppQndIbXBQ?=
 =?utf-8?B?dkg3MjNkUW5BMDF1ajhPTGJuTHZsb3I3aHBUR05nZCt0Z2tzRVVhdGJ0c0to?=
 =?utf-8?B?VzI1OTFkNXVFaHNpK25YamIvOUlUK1hEVXZaQVFLVU5MdVQ5cUFBR3JLT1Fr?=
 =?utf-8?B?R1d6TG5HeG9iZk5JT2R5WFNBOGRsZWw2VHg4cXk1ZTNkeDBERG9MMWhwTlN5?=
 =?utf-8?B?MURsZGxSdnhDWlNCS1ZZY3Bpc05ET2FXaUoxcS9wTGdsZ000K005QmxIdndH?=
 =?utf-8?B?UTJlZXk3VFJucHVZZDd2UFplME4yUm1nVW0zV0xUeXZhR29sZXdnL3JqWVJG?=
 =?utf-8?B?aTExSlFmZ2NnVVlXSHQ2Rk9Nbkl0QlRGb1VHQUhlWEhPbENob08ydGFUYlpt?=
 =?utf-8?B?ZUxSRGsxNjdBbzNIM2tKVjMyT2RRZ0Z5aDRzVjRHWTNQZlc2dHB2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC943599C3A01F41ABADD7296C3841DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M569oD3pJaZzMMzGBhGW45k3L9THn6NwtUgEihROPXOlS9i0yMfaESQ4gdbLK997gCPtJefctGaQGvImuok+hxXFzCQnSOyiVY66iUm7+KsV6/YXEl7p1R+JY//dL8FJi//DKIngoDJfJgz9Z+MBwBtsZifonktbAadXS2JdFDwPW8gl/ivM4FcjfHE0EopXUQkqtdvdBP+atfjESRCP0rY80eN/g7yCxm/LxaEb394x9XgKa2MxGAqJTkrKgDBj6TCtqQUNe9oqYvtD7kL9kScuFAMznw8/KUIlUbGuhJQ3pEe/iIVQCfbSwRi/o2Qla3Z6/VNQ2LZsbjJsQy/c0w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2647.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeadc0ba-2752-4dee-6338-08de7fba6efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 22:06:23.0948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cGQB/SFlWlrkFBgCjDwotelpHhPdmlqDDqeZhVi2msq6EPZHtQAB2kz4uly/n6Uz9L7yuaIFKjftw8krw47HzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9473
X-OriginatorOrg: intel.com

DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgdGR4X2hvc3RfaWRzW10gPSB7DQo+
IAlYODZfTUFUQ0hfRkVBVFVSRShYODZfRkVBVFVSRV9URFhfSE9TVF9QTEFURk9STSwgTlVMTCks
DQo+IEBAIC0xNzUsNiArMTc3LDcgQEAgc3RhdGljIGludCBzZWFtbGRyX2luaXQoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiAgew0KPiAJY29uc3Qgc3RydWN0IHRkeF9zeXNfaW5mbyAqdGR4X3N5c2lu
Zm8gPSB0ZHhfZ2V0X3N5c2luZm8oKTsNCj4gCXN0cnVjdCBmd191cGxvYWQgKnRkeF9md2w7DQo+
ICsJdTY0IGJhc2ljX21zcjsNCj4gIA0KPiAJaWYgKFdBUk5fT05fT05DRSghdGR4X3N5c2luZm8p
KQ0KPiAJCXJldHVybiAtRUlPOw0KPiBAQCAtMTgyLDYgKzE4NSwxNSBAQCBzdGF0aWMgaW50IHNl
YW1sZHJfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+IAlpZiAoIXRkeF9zdXBwb3J0c19ydW50
aW1lX3VwZGF0ZSh0ZHhfc3lzaW5mbykpDQo+IAkJcmV0dXJuIDA7DQo+ICANCj4gKwkvKg0KPiAr
CSAqIFNvbWUgVERYLWNhcGFibGUgQ1BVcyBoYXZlIGFuIGVycmF0dW0gd2hlcmUgdGhlIGN1cnJl
bnQgVk1DUyBtYXkNCj4gKwkgKiBiZSBjbGVhcmVkIGFmdGVyIGNhbGxpbmcgaW50byBQLVNFQU1M
RFIuIEVuc3VyZSBubyBzdWNoIGVycmF0dW0NCj4gKwkgKiBleGlzdHMgYmVmb3JlIGV4cG9zaW5n
IGFueSBQLVNFQU1MRFIgZnVuY3Rpb25zLg0KPiArCSAqLw0KPiArCXJkbXNycShNU1JfSUEzMl9W
TVhfQkFTSUMsIGJhc2ljX21zcik7DQo+ICsJaWYgKCEoYmFzaWNfbXNyICYgVk1YX0JBU0lDX1BS
RVNFUlZFX0NVUlJFTlRfVk1DUykpDQo+ICsJCXJldHVybiAwOw0KPiArDQoNCklJVUMgdGhpcyBz
aWxlbnRseSBkaXNhYmxlcyBydW50aW1lIHVwZGF0ZSBhbmQgdXNlciB3b24ndCBiZSBhYmxlIHRv
IGhhdmUNCmFueSBjbHVlIHRvIHRlbGwgd2hhdCB3ZW50IHdyb25nICh3aGlsZSB0aGUgdXNlciBj
YW4gc2VlIHRoZSBtb2R1bGUgc3VwcG9ydHMNCnRoaXMgZmVhdHVyZSBhbmQgYXBwYXJlbnRseSB0
aGUga2VybmVsIHNob3VsZCBzdXBwb3J0IGl0KT8NCg0KU2luY2Ugd2UgYWxyZWFkeSBoYXZlIGEg
WDg2X0JVR19URFhfUFdfTUNFIHdoaWNoIGlzIGRldGVjdGVkIGR1cmluZyBrZXJuZWwNCmJvb3Qg
aW4gdGR4X2luaXQoKSwgc2hvdWxkbid0IHdlIGp1c3QgZm9sbG93IHNvIHRoYXQgdGhlIHVzZXIg
Y2FuIGF0IGxlYXN0DQpzZWUgdGhlIENQVSBoYXMgdGhpcyBlcnJhdHVtPw0KDQpBbm90aGVyIGFk
dmFudGFnZSBpcywgaWYgaW4gdGhlIGZ1dHVyZSBzb21lIG90aGVyIGtlcm5lbCBjb2RlIG5lZWRz
IHRvIGtub3cNCnRoaXMgZXJyYXR1bSwgaXQgY2FuIGp1c3QgY29uc3VsdCB0aGlzIGZsYWcuDQoN
CkFuZCBidHcsDQoNCldoaWNoIGNvZGUgYmFzZSB3YXMgdGhpcyBwYXRjaCBnZW5lcmF0ZWQ/ICBJ
ZiBJIHJlYWQgY29ycmVjdGx5LCBpbiB0aGlzDQpzZXJpZXMgc2VhbWxkcl9pbml0KCkgaXMgYSB2
b2lkIGZ1bmN0aW9uIGJ1dCBkb2Vzbid0IHJldHVybiBhbnl0aGluZy4NCg==
