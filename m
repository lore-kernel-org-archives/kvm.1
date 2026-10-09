Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F83DEFF0;
	Fri,  9 Oct 2026 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573776; cv=fail; b=Tr2XNYGrtzQfPHbtGGFACgjtwjctUxpunS7rzn99b0b4KQT8tC0SSZjXxIrRKY9h46XETSr6mbMIM5g6/mpnfGNbe13YtsZk+VJrZo5dKsXnU0L7S8NjjRqDuv/CNSAzDIqvY2K6R1ZH5T3X50Zx/R1OovLdWPEpGGN2NysaT7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573776; c=relaxed/simple;
	bh=/iGfFzNJb4YyfC9okjynpNWW1w9X6/E9cH69F1G5p0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZSZSbcxlR8IGb9CV3bGzmXSsmaJ23zn5nVM+e9qJpci9pGdC2yLkbLbUX7ye6PyGhQRXbgS9oDtn4h8Yx1N9h/++Rq2cMJz545ao3+x0/g4Cb9KIPpP0SmvNfVVI2ceEBAlYyp1KHGTeQFIuh/jweZqXdAG2jjTIAHFH7e3elto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgOh16cg; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgOh16cg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791573776; x=1823109776;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/iGfFzNJb4YyfC9okjynpNWW1w9X6/E9cH69F1G5p0c=;
  b=IgOh16cg8YXeMXx9q3ksm+A+fuXSvVswtZv3sZEfRszbAFiiYuZdkRTD
   csn7540rzG/hxI+KxFo6BHRw7/eR8fBpol8LVRpyXXoRoD7gyeCqKPdj6
   0XW224SJTmgxlFf+WIxm46sydi1OD7pLksmZPmHP7OoOs+EgOIhp5bU4Q
   NtNlBv5eWYC0VB9qkgjfbiyhmg6OsxQaoDO41fTbmMBMEVjYqSPGxFinA
   7lDVgy4g+WlOY/gicXLsrb86tDoduSo/QB8xWUfWVCF4Eyw9+tV2Ygyuc
   oDkToZWucFv8//xLnk4bScc8yc0vDxd/qogKLBNlMKjvUBOkI/+kgW88j
   g==;
X-CSE-ConnectionGUID: YaMGWo/2Sui8z/aHSsUe/g==
X-CSE-MsgGUID: NugQfNmYRc6Y+7kv9vo20w==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="272492"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="272492"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:22:55 -0700
X-CSE-ConnectionGUID: 3R0etAvRSR6Z8jEbYhS2Jg==
X-CSE-MsgGUID: EGtqLbvtSleUNnIl7eNE7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="322626"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:22:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:22:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 12:22:54 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:22:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpvqSI3X79dwysWDmzok5YGcHK4uTl3IJ87SdwfEQSiT9lKLvDk6NftF4IiGO1bRYpiNBIejiTdrMODSXT++QLRbDVhm7H9b8KwMKYhf/R3QVNe6Vg96fcSYYtMpvbTJwtHRn5XoZNSzhObthvT35/v21d0TqmmK9JZcSUdm2XA2Rzy5J4mUsuD4JEPOEQvB3lRqAKAij7Te6FP8fPbGMJMo3rhVNBEcNTCnqCTZqI5irPDBfCZDNaRuhKnDoECVffJ6MF1TIDviYfuYGUuWEB53I8s6RGId4NerbR62kxSU4cMSe22ESqYGXt3ZylCZ9fqfEjcvf0BrcFSnIgHSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iGfFzNJb4YyfC9okjynpNWW1w9X6/E9cH69F1G5p0c=;
 b=khBw6L3x6fbagXs3MqsrHCdeccmxgQq2XPElQ7WNewZs1Y6R6L0EIaiv8A77DHuqeJVvpHoedys2dMs9rBCPEyLUHOi+H6+gBQA9x6M5wzbSSlqB0BPa3y3c0Jg4nmF6bW84ULhHWpYoCiRJAq9IeoBlG5idGZqlBTQ5Ugw0mJZgc8Egdkjvo9ouflv37fJp2h03NiUWfrMPoDBXbykwplAbH6HUqodJkLJE08pkuAwAHzV9Rbq3oXajvsESAhDSeJoMuAYvONCSgfPys9DiOINVAqK6NnQihEq4qzG6hu4HuORhrgYPIBrwmwhQZdHu0d+WBYguuyPibM1xRH0bFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA1PR11MB6322.namprd11.prod.outlook.com (2603:10b6:208:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 19:22:51 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 19:22:50 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "rdunlap@infradead.org" <rdunlap@infradead.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] x86/tdx: Move port I/O definitions to a shared
 header
Thread-Topic: [PATCH v4 1/2] x86/tdx: Move port I/O definitions to a shared
 header
Thread-Index: AQHdVRv1fbzvcfhWr0CGy5WJBJEc5rb1nOyA
Date: Fri, 9 Oct 2026 19:22:50 +0000
Message-ID: <978846f27dbadc919e02ccb89f59fc998c50b46f.camel@intel.com>
References: <20261005-b4-tdx_earlyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com>
	 <20261005-b4-tdx_earlyprintk_tdcalls-v4-1-3f7c56dd568a@intel.com>
In-Reply-To: <20261005-b4-tdx_earlyprintk_tdcalls-v4-1-3f7c56dd568a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA1PR11MB6322:EE_
x-ms-office365-filtering-correlation-id: 8a41fd4f-1572-440f-9a0a-08df263ab5c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|10067099003|18002099003|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: 65ZScj8UHwnjqMrxEqaOpUPoYKcLdtkGFkPIYbfUXJ+kpNCPZbWDIppwFoGMdjjSBiJD9dCshkaDiTZdrqx0xWdEQI3lTe0nbDiNXsMPkLFADqyDFFC3OwQ2+BUMyV+jriKLrpldEVUeHGIqFn5EOJWGHtX87wm6i+xQGzLtr5vlPMH6RHMRXpvyrvcLDXIF1yiZH1SyN9h9egqJqj2JKkKRvFBJifPA7MlV14JLYRPDI4FNxnElbbGwxWmJ2Pt9rBHFluB1gTpiMu3eTGVIVumXfe15U2Znwds637FuI7IIz62CyKIR59ekQwT5Fw0o78VRP6KiD5cMJbXOg4kyg2++Tm8yATRs76goh/f15AXv3FsuCnDqVNSQoDQmASkF+sHwNi3SRbnBOxs3NjlJ7GwvNdGxWEL57B9s4M/ObXsgReLZD4B1Xrfhnuy85FwrWlEKLlpsC7n1qVSB8w94/PWcdp6upEUTHtpV5v+SKt0yz2RxMN7NphJXo9k94VgOeYtuWK7NG0/1F3w1glE4NiO7TSJUB3iGFnpB+HmmTjSoOq4kP+7nJP68KeiVHBoeTDyIdqnWMBLzuHNgaq40mAKy4cbWQ5GM+ORcdP4Ga6c36KtBnJNq1BGuVPYTvnH9Xotp/EHW0jkkFTn0TK5ldcijZ9uee5MFKSjojteYyJy04X31oyzv1pt3bc+zSD+5uvKkUqE+a1OW/zhx6kBRVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHFKYzdORGJHTHJJZWpvOXhYSkU2dWhzdDliOURBWU1MVWZyZU5wL0NuQnN3?=
 =?utf-8?B?VXJvdHNmYTFiYmdVRVNXYU5SK2NJZnJ3L3BmSGVCWHBkSjlrVEluNjFaYTEx?=
 =?utf-8?B?b056VmJyMWV5dGVXbXRieEtZZ2NjcWZGM3k1VHk2WVN2bXZKeW5aVGp2K0o1?=
 =?utf-8?B?Ulp6ZlBnMHgvOHBGVEtpUlRQQzNBU3ZudVovMVY1MzJnSFVTVUZtbTFCT3Za?=
 =?utf-8?B?Z1ZDWkZTR1NKREM3SWJhc25SUHErbHRDOVBISjZaNEphbXhZU0d1V1hQcklq?=
 =?utf-8?B?YTQrU1FLUzA0SFZ5ZU05OWNjQkdhdXVxcDRVMVg2RW9aeUpKWjFXaDI3djl0?=
 =?utf-8?B?ZUpHYmhnNmNna2FZMGlyUEcwc0dyM1AvdFpWVFJ4TThoWVpTMnFaMFdaRjFz?=
 =?utf-8?B?TkdtUEp4cmo0MEphQnR6R2dGS1dvb0kwbWxjL2NPWVpMbUZqMzY5ZUlyUldK?=
 =?utf-8?B?cktyd3dtMlkwdzZsTy96UlFhWGJBS01VL3lMU01FQm9HVzUyL2VxeGhyZGJH?=
 =?utf-8?B?NlN4YVZPSDNZUWdFS1ZIbXFVTzU1QjJ5TUM3cmEzTlhIaFNybmVUNHdtOWpt?=
 =?utf-8?B?RzRxelBhQzY5dE8zNkZ3RURBVEoxSFZ4ZUJraU45Z1JpRVkxWFhROGVldFk5?=
 =?utf-8?B?Tm1QUGY1L2ZtY0dCeGlvMHFOSjBOWUwwUDFuR21iR3ZJTTEyYjNKRnV6akpS?=
 =?utf-8?B?ZnJzVFpDU0FGdXEwOEdGdnUvbGs3TjlJcUo0ai9IeGRzWVYzcXNraFQ3Z3F6?=
 =?utf-8?B?SG43WVQ0OFRrNitvcUFENVJpZEpaMFhJS0s0SlI5alMxRU1aSkdMK2RWakNi?=
 =?utf-8?B?MVdldlVOdytWOVZNTDE5eE1VRTRJc2NQMzhvaFJtYlRiOWhwUFJKQnVkY3lR?=
 =?utf-8?B?UUZMaE5XeEJKdDlyS1U0WUJMMHF6QWd6OGVZb20ycU90eENYUWxjUUtkVldS?=
 =?utf-8?B?Z05PSWZISmdHcGxWQWM5YjJvTkQwY0lQZzU2eFdlMUVTS0UxK0FlN1FnWmFm?=
 =?utf-8?B?Rkx5aWhIREt5L0t2S3VOS05jM0NFYjAzYklEeTBXUUp4Mm9qbGFVdzhKYmR2?=
 =?utf-8?B?aC9hSy81WDZManJ3RkVaR09MdCt5bTlxMVBWQWczeFN6QityNEc1QmR3eUNI?=
 =?utf-8?B?RXU0dkFteHVTZWVMWHRBdzNMeE5oaksvSklaMG9rbmd2RGEvU0QwWkdTMU1V?=
 =?utf-8?B?bGZEQzVNSFZaT3lnRFJyV05Cay9OV1VOKys2RklFbjIycmJxQm01VzRSY2Zh?=
 =?utf-8?B?OWQvRXFkWFluMjhncW5NVGhNa0ZYeXhCcnpiNWxqWVhPMEx5SjhwcHVkcDli?=
 =?utf-8?B?M0VlVWtPWm9MQ1VOMlF3czJHSzhxOE8rOXZESmlRdmdYdzhoV1F6cU1mSW1Y?=
 =?utf-8?B?UlB6WmIxS1EzNEx2alM5c3JIN1l0a0RJZTYzdXhMNktZNmYrSmtud3BveHU3?=
 =?utf-8?B?ZGxNOTUvNkFLUjdjZ1Rua3pvY2pseHFJQlZNZXpwOUY4WU93aDdnZEVGTXVl?=
 =?utf-8?B?MURuRmpoZldhV0cxRW9WaHVVN2Z2U2pJNUptOFFWT1JkRUpDUTlHbmtkR0Zj?=
 =?utf-8?B?ZDlxSm9tMVo1eHp6TlFORW1QbjRVWUxQNHJoSEZ4QWJQRFpFa0pkUjFndmVU?=
 =?utf-8?B?N3NxTlJIeHFZZ0x2V1RrY1o4TXpZYXNLSUFpcVB5dTNnYUtkcGdwSGFnYnAx?=
 =?utf-8?B?blo0REtOMDM5TjJCa1MrZnVEcjdoSjBzalhDZjRzWE5kSEVEZjdEU3UvYUEy?=
 =?utf-8?B?RnhVdVBzK3JXSS9VajdFK28vYjg3TnA5WVFhcEtUZUF5OEo2S2k2UFA5M3BW?=
 =?utf-8?B?c0VwVTNHbFJ1NXRiTmJhMkpsWUJzTGRLbGlXYTg4UitxanMzSmN0bnd2NHFx?=
 =?utf-8?B?T0lIbUhBaHI2eHUxYnV6VU5LeXNBZEtMSXRJNS8vQTdYN2NHRHlDYkxFWFBw?=
 =?utf-8?B?VjZQQVNidFRSVGhFbExpS1A5ZFdwbW5neTMxM1V3dUhmcXRvVmlNYngxR2tn?=
 =?utf-8?B?Z3pJRFl5K0xEZ25VT1lQUWNVVkxXYWdDaDJmLzQwZXFjTmZGT2YzRUxja3Jr?=
 =?utf-8?B?dmJxMXduVWVzMzRVZ2RraEZwd3c3T1phSXBXTlFVeEZBRUllY0NMbWNSUFlB?=
 =?utf-8?B?cXJ3MERYanAyT3IxRCtYc2FUYTd2L1cyUGhWQWhnYmRCeEZBNzU2NUVOem5Q?=
 =?utf-8?B?WjFnSlZiaFI0TzZrSGgzdTRWYnVOTE04T05USnZGOFVZcytWeTBTTEJLMU5V?=
 =?utf-8?B?bzlycXdLeHViWjI3Q1Ywd2xURHYrRmRRL1RLTFR4TmcvdGhrbTlFSng0YlEz?=
 =?utf-8?B?RUwxSkNWME00VVo1eWFsMTlpR0Z6MzVqVnpUKzJxcmhxdWYzSXh5bjJDbjJ4?=
 =?utf-8?Q?8C4J+OorInynvXvs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5201C68C1E6084A9933104BDA744FE5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SKi0+jovpzlC+lZ4EkxYVIzs5l5jJvy7s8NXAxmHb8RIsiXZ6tA3BlWjqitkI3zZz0AFTGBvt0hHGti7OcroyMUxRw1z5xIxkSieYpX6Ey3Ie4E8LbSmDfaOEH8LTwC7Y6zWWNWQysTb0qmvPNHZIjB8Ut4OqPi1DxAG25M6i8RRGuc4I1txR1VQjKNDUAmKZSkuG6opjAnRvDHuHHTQhhGh5iu2DDx5RXFlvnAn7QZA9AzrnAFqKUc+UuBd5smw2HvSBNha+RiWwO86fqllV1Cwkn5yorB2vzQ7RtZ+9D8OglhfrFAwf/l+XJ1aa8a9/obrpwQgB0Dzju0hVgateQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a41fd4f-1572-440f-9a0a-08df263ab5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 19:22:50.9133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFqlgAzH0TrP0Gd1Wp5qmMKvqoVmPPf2rfz0y3qFxiL1nj0gQpF9iHizElV1KL+RH8yaM5ps9xZHqUkNYvwhytYAxgQx83Wr6gnZy+dS7QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6322
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTEwLTA1IGF0IDE2OjUwIC0wNjAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+
IEluIHByZXBhcmF0aW9uIGZvciBhZGRpbmcgYSAndGR4JyBvcHRpb24gZm9yIGVhcmx5X3ByaW50
ayB3aGljaCB1c2VzDQo+IGRpcmVjdCBURFZNQ0FMTHMgZm9yIEkvTywgZmFjdG9yIG91dCB0aGUg
UE9SVF9SRUFEIGFuZCBQT1JUX1dSSVRFDQo+IGRlZmluaXRpb25zIGZyb20gYXJjaC94ODYvY29j
by90ZHgvdGR4LmMgaW50bw0KPiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zaGFyZWQvdGR4LmgsIGFu
ZCBuYW1lc3BhY2UgdGhlbSB3aXRoICdURFZNQ0FMTF8nLg0KPiANCj4gVGhlIGRlY29tcHJlc3Nv
ciBhbHNvIHVzZWQgMC8xIGxpdGVyYWxzIGluIGl0cyB0ZHhfaW9fe2luLG91dH0gaGVscGVycyAt
DQo+IHN3aXRjaCB0aG9zZSB0byB1c2UgdGhlIG5ldyBkZWZpbml0aW9ucy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiBSZXZp
ZXdlZC1ieTogS2lyeWwgU2h1dHNlbWF1IChNZXRhKSA8a2FzQGtlcm5lbC5vcmc+DQo+IENjOiBS
aWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQoNClJldmlld2VkLWJ5
OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21lQGludGVsLmNvbT4NCg==
