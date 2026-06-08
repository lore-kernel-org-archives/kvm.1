Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74835A3AF;
	Mon,  8 Jun 2026 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917454; cv=fail; b=O3RKWnhQwOW+7dKvwyMXCqwzMRlDu/+2uc3LPgjUofF7hoYIFkaKbczJNJZB+dWTp3Oz7G6hebfqTPl3CoZVefYTLDoEJ+oS331LXk5QGMyIRCh3yXCJwaldj4nBfnOX1t++z0hmYFydWRw4OQ2z/B8fH/kIZXfH3LT9x7Cupiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917454; c=relaxed/simple;
	bh=RdesdNPKeJgbR6WPtn3dTTAqJD7SzVBfLx7CfA9sbTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BiSHJwXrLzAMfD/3BxiS2FERufxelY+NeMP0Pxj3RDB/GQ937iv0SOLYAvvq/jTYPkjrdIJGWAX9zzpItAuAxjtxhIc4MzX28E2Wy5CC8sySR+EZbOhxb1AtpBlvAbCb0znzMbnZpKqqB7FT8U6h/97xrciKsj4SbYbQFcbHprQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2cAkGec; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2cAkGec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780917451; x=1812453451;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RdesdNPKeJgbR6WPtn3dTTAqJD7SzVBfLx7CfA9sbTA=;
  b=C2cAkGecHxZ0vLpmjZ5q3OjBO6IVx8XKK33VjicBDrFhwmEXhG+IC7TC
   0em6poCSd+4w5iVHyaVNOld3eXAQVrd9xiv4JQlXJCCt38zFaGYeSSSrU
   QcwjT+RwOWqOz8J3RBaXJb5RZEW420Pd7/ASt6h1DCoH3pEQ7q3SXExt5
   IvumnNZr4Ep0ELpASEr/a9h8IirsA0VX/vYmgEFI+elowAuq/59k2fjLe
   bgCSCxzhOpB4WFAYcWluAf9gpPD0sbPcy8/hrkLv1NY67xqaD2v0+vLVX
   1mozhlZV+ikp2gSv85CGHhpqUvfiYx3Jtuii3M7s09x6R+MGEyWvZ6BZG
   A==;
X-CSE-ConnectionGUID: 2I9WxKjsTM+siOJmOCUpEQ==
X-CSE-MsgGUID: glUFThSwSMeCjoYU5o0K3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81625848"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81625848"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:17:31 -0700
X-CSE-ConnectionGUID: 08g4+nWzThalKvj8+pmu0w==
X-CSE-MsgGUID: JERRrBpFTiumf0xaCTSo7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="275723715"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:17:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 04:17:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 04:17:30 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 04:17:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7pApHpe7rJAcrKD+VKPL4C9catVP3FIdm4MFvcAtCxb7RF6pernvzJ93RVS/K+wYddb0we2VJviE6/wZ2erB/j/+2rK/LqLJeHjJwTcUYQO+3eEQ3d3Z9v7wxR6FWhJfbLYSVJjxDsBQ4NWm856kYDRjkN3nOeVQ9f9aFwkDmyKEHx5Pm1wX7IbIK79mQHnBDZW5lh3P+dCX37/wr/PYyFlo9dqevjAh5IifxQejQUHJze9oHMyC0nqzIDSLWgjMVpxcWfKi2vffWhCqyo0DKuzuP4AFi5xXUUeKhv5TE3jZxnkDNj/W4JizSZ3jhCYOIExtSLGVJwtjib3eqyjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdesdNPKeJgbR6WPtn3dTTAqJD7SzVBfLx7CfA9sbTA=;
 b=aJbAhzCBJVXrYjtgMGYoy8iCEFChJDDKv49aUaxVx0Hkn5gjeTDDAbGqP1fxcS/FMVy/sHnkCaOIeV6TN5HOfuRMo45TbXNUsh2+UjHpCQymdL1RRJwuPdYjzAIFecSXVM3HIiXSYjoPr7m7g8+UQYwCjWFnsK4AB1uMX3k9X58FlJvuePApdrN/yrKiHcV/S7+N8wgKscVICcq0WWH0bEDTpfDO+mVCTrbPkaH1HOAdftlQGxl+uTGupVAGPJQPBzd5KYT+ZgdHrqA9Vf8EbSISVXlobc0OPZMQDwxwexr2pmeA10UL4NrkkOLWU4tJFubchljfeeOHcWP7ESMd+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CY5PR11MB6138.namprd11.prod.outlook.com (2603:10b6:930:2a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.12; Mon, 8 Jun 2026 11:17:22 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 11:17:22 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"paul@xen.org" <paul@xen.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>
Subject: Re: [PATCH v3 34/40] KVM: x86: Move misc "VALID MASK" defines from
 kvm_host.h => x86.c
Thread-Topic: [PATCH v3 34/40] KVM: x86: Move misc "VALID MASK" defines from
 kvm_host.h => x86.c
Thread-Index: AQHc77nMIfChLQNqwka5iBSflv7287YvnzkAgADWJYCABBvsAA==
Date: Mon, 8 Jun 2026 11:17:22 +0000
Message-ID: <0f653745fcb79aeddbde81eb896fd06f2305e8b7.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-35-seanjc@google.com>
	 <0dbe94ba88bc2c9de04233cb72964fec762e228e.camel@intel.com>
	 <aiMyVbi8at8ZJKOS@google.com>
In-Reply-To: <aiMyVbi8at8ZJKOS@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CY5PR11MB6138:EE_
x-ms-office365-filtering-correlation-id: fee6ffe7-9661-4543-f285-08dec54f8316
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: nYIn3NRXCTrEG4wSPE3nwQxD6oQbG9ZOhu3OeIU/+YnJeE3DhFfvZtOa/txyPtmnQ+JHyi0eueCHf18M2OWUH5jWt56Rt1F22Z9RTzzNeIp+uWCSiOULka9lr+6GsaxvMG0v4goUouMHkqorIuQokVNEw+MOFR6t/4czQ2v1fkc4e0WhAkDG3HGIEZOF2huUxhdXKos1EFrqVHqhSiZ1KzYNltyir+WUJeSUnp3k9cD7Z0N0kux5EUR2LugW7NqPNPBsakm1u+CzUxpOrXeVYynO9xAE1888f8/ip29j0lBdsMDtkmwHYtFJHAo16EBNALQl9YCq6nWisYLgQEUZe1GWxrKqb2A2rBfgdZNmKbeB73OGfawzNcb3LhhZjRGVwzQQeiKe/0GLBsXs+bjwxIiyhu6dbOhQsLa4FmbVul1BrD+NYp3nrfG8ctnsw5VcpTEQOE5uubhnehkbJWEMD0QMhwX8Xz2Tf7tkWTniO25/fZP+gXhdYBfjFYiVaO75vzgYAfaLAMf+2EiaxuC8hWOVKU8qzEuG8nwJf991Y2Md2C2sXlE4dj+gX5sNGOOwIfcokkq/Nxnt8r4EYlDWOyzwMUGowhmpXk3iWUWcyddE9GB9qwSionB6XR6yivP7fhRY2/xiStrQZdXF6Qs3CfkG/nn4QHRl4kA4XtoLbx0KNqbZkFFBiYdamI0Co//fOBjXAUY66NG8uPDWfIiwV13gyvodCQhe4E+WBFFRWIqxIBld1pXmHKHe58PZPxuJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlE5OHdZYzhmdGticnJyTXIwckJxdUxYUGRONWxnaFdFVXJHa1M4YSs1bXFN?=
 =?utf-8?B?U1A1MXJseCs1Vzl1TUgzSHpoVDJ3eUFvdmFCbWNGOCtGZ1RMaXBHbCswSEgr?=
 =?utf-8?B?bDN4WkcxeW5KSnllZUV1VkJqMDMvSUQ5SnIxYjZEV0NUTUszSmQvMzNRUm5w?=
 =?utf-8?B?ZkpCc1Y3RUQyWlNpdkFnaGhPQ0lZYlBjTEtsVS9rSGluallZZDZtOVQ2QVpl?=
 =?utf-8?B?dzkwZU94M2hZS0h1Nnl0V0c4L1lHN044SnpKbGNKYzA0bE9ZTWRHaHZqaFpQ?=
 =?utf-8?B?OHFuN0ZqWmw2V1QxT0ZiWkc5a1VRUHErci9zTG9hcDJzWWJwRVdYVk8yTXlw?=
 =?utf-8?B?YlppWVUzSXNSbGpwa2NUWW9XS0xnZW1PSWVGek5vWTFnYXFkVU5QdGdidGV3?=
 =?utf-8?B?T1NmTER5bWs3ODJBcnBWeTZ2U0VReTY3M293U1pBc1orMkpZTXA3WFo4Zktz?=
 =?utf-8?B?dGs3d1pYdXgrbmFncWJSNFlXK1dSL0IwYW9jWmdwS1F2Vys0bDFVbGJWd3lH?=
 =?utf-8?B?ZHIwMVp0YkF3REZQTThXM3Q5QzdqU25HYk10TVZ6dEFXakxPTEc4eU04cXps?=
 =?utf-8?B?VGIzcDgwWGRybkxKcjA0eUJkVXNVMVhQVnl2RHBYMXRVbTYrZFl6andMVFhy?=
 =?utf-8?B?KzN2SDFuSVpzSThoZk1uamNtQWV1WGswYURtbUU1LzN4d3V6M2hQSGdyS1ZE?=
 =?utf-8?B?dDFlRDV1VWJqTTRJdkpHazE4UytuMUQyYmxXSmI1K1dQcFV5TzJVQmM5dCtn?=
 =?utf-8?B?a2lNSG5qQ2FTWTZ2Y2RHZGFwbUhyT1UrVm5QQXZiWkhQSmRLZ1Bycm9WU0pF?=
 =?utf-8?B?YkVldzBOcEJBZUpTOFpDMXdBbkQ2U2QxL2piMUgrY1Jrck9JSm9uMmc2dmxW?=
 =?utf-8?B?QUpYRTExR0N0b3pqSDZMQ1I2bjUzTjFDS053UFNsOUdhZk1MR3hqc2lnL0Yv?=
 =?utf-8?B?VGlwbzVSTlJXMGV0M0RwVGVNQ2xzcGFkR2E3VDk1aFQ0ZnI1b2xEUkJPd0Zw?=
 =?utf-8?B?cFNUUlFpWGV3NlNBUjdhWTBMb3N4QTdhQXJtTnFXTTkvWW5oKzZld1FZRlhz?=
 =?utf-8?B?VnFGd04vekpGT3cyUjIydzhFalFxNkhDY3cxSG51UWM1ZTdJWDZJSmR1RlJs?=
 =?utf-8?B?Wk1tRUtPK3BUMi9qcUhnVUQ2d1hPa2s3RUx3RnJ1aGY1VmE3WEdIM2I0MCsv?=
 =?utf-8?B?ajl1d1NmVjhTL3NZak0wcEpnYk1HT04vWlpFVHFpaHVJOTFZYzlpRy9jdnhC?=
 =?utf-8?B?TXRJRTJFRkdFV3ZzdC9WRVdBemx2OUtwVHI1b1hYN1R3MG85SG5XWFJhTWU3?=
 =?utf-8?B?UmEvcERwaDhzTlUwNlVPSnVtOFloU3FORFRUSVBmdjdzYkMxRmo2MHVUSFc5?=
 =?utf-8?B?TVgvMDRNa21KRlVhVzZCRnR2b2tLSmtGcXBkaXRtOWNkbEhTbm9qUEY4RFV6?=
 =?utf-8?B?WXYycmluTUJydzFYSm56VTJhSXJaVXRsTk15blg1bFMvVkZ0UFNabXpSRzUx?=
 =?utf-8?B?QXNJUUZ6RXhxRytQVWdSem9Sb081WU5zTVdjaDMvUDJNZHFubWNnS2Z5bXVk?=
 =?utf-8?B?bkh1cWtRL0g2ZVA2dklKdUNlZTdkYjdUZW9uTHQ3ZEtrbjFobWpDTnBGWVdz?=
 =?utf-8?B?R2FsYk5vL21JZEwwclV0WmFITDhIUks0U0ppN29KMUcvU1BFWmZxMnRxSnp2?=
 =?utf-8?B?N2pwaW5lYm5YODVOYmt3V052ZFczc0VJYzJQSisxRlJRblRwdUIwclVWaXIy?=
 =?utf-8?B?cVFsZ0FrWFluVlp1Y1NTQ1lPN0dmdnpHMklkTHlzMXpjcDJhMVVIYzlUeVFH?=
 =?utf-8?B?UHRLRUZudHRPWFdjYkpGdWlJYkdzS1pvVzVJWXZIbGN0dlJlamNZTmxVZU9Q?=
 =?utf-8?B?c3UxanRBMU9MbEZTTjBiSDlCcmN2ZGpEaEt6bTlyOEgrbXFUVkNRN1c3RExo?=
 =?utf-8?B?cUJmOEE3c1gyU3ZBS1VJUGJYcjZ0eElGM1NuTzdaa0Z6YkZPMXluWWYwcGpB?=
 =?utf-8?B?c05kZlRJSkt2SGFaVU5LQzJDYlVPUytiaXd2eHR1R0hoUWR0TW0yUzl3Y0Y4?=
 =?utf-8?B?cldTRnd5Q2U3c29IRjQ3UUgxRHJTRnhzT01MS3Q3bUV3NUtsb3hudWF1ZU5k?=
 =?utf-8?B?aDN6YkpmRUpZeWhQaDQyMGpvWW10bGlBZGw4U2U3TnBiMWgzVVloRHpaeTZa?=
 =?utf-8?B?M09NaXk3bDlrR1Y1aXZmVTJLQW8rOXJKTC8xL2MwMFN1NTJlZ1QyaHdXTHFs?=
 =?utf-8?B?bWpLelI2ZnlQbzllUUVvdWlCUXpBdzdtOXNTQ2twRVoyZXkzVDkyZFpkT09j?=
 =?utf-8?B?b3pIeFNITmtVYkwwWnVqK1RiS1ZESDkyN1luVnlwRVFJS0dEaWoxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA2539889E48EF4B91770509CDFFCF3D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E0NRWc17pf876WfCBCFu1NnkBCQHKGpB0hp2XsVOYMdboxaggAmTAd3yQGpdyFMjHgtiBcncNf9GHcHQ/9mgNUJo1DiBgS3m5HGNFaQPdtwxkWS/NCkxmMxm8DlINXlimfGiSiOLJVufbiXDIVLnR1hFBXD/F+kbFGeNHDXRm5m4SGCHrMHgidXzWTWhrdf3rgSVUQ+wCIQxOVOQU5STKu7OY0CDMnaagUR+/+QmB2s3UqNKD83waV59EmQRROxhM8VFI0lceAolayCdwNlJ1uH7Vq0vfehl7clwdPUxWWWVhw6WwO8sOwsGEiisGG47Mn+rGb0n0I4p4POawNhV0Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee6ffe7-9661-4543-f285-08dec54f8316
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 11:17:22.5067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5zt2iK8Rygk2LmSytSdOPg2RLVh6uMbSZL5huvMn9Lw8Cq+UxHsIgnzkq9pxc2dnjTxqCWGec8f3vTdDNCzwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6138
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTA1IGF0IDEzOjMyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBGcmksIEp1biAwNSwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIEZy
aSwgMjAyNi0wNS0yOSBhdCAxNToyMiAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+IE1vdmUgYSB2YXJpZXR5IG9mICJWQUxJRCBNQVNLIiBkZWZpbmVzLCBlLmcuIHRoYXQg
Y2FwdHVyZSB3aGljaCBmbGFncyBpbg0KPiA+ID4gYSBnaXZlbiBpb2N0bCBhcmUgc3VwcG9ydGVk
IGJ5IEtWTSwgZnJvbSBrdm1faG9zdC5oIHRvIHg4Ni5jLiAgVGhlIHNldCBvZg0KPiA+ID4gdmFs
aWQgZmxhZ3MvYml0cyBpcyB2ZXJ5IG11Y2ggYSBLVk0taW50ZXJuYWwgZGV0YWlsLCBhcyB0aGUg
aGFyZGNvZGVkDQo+ID4gPiBkZWZpbmVzIGFyZSBvZnRlbiBtYXNzYWdlZCBhdCBydW50aW1lLCBp
LmUuICpkaXJlY3RseSogdXNpbmcgdGhlIG1hY3Jvcw0KPiA+ID4gb3V0c2lkZSBvZiBLVk0geDg2
IHdvdWxkIGJlIGFjdGl2ZWx5IGRhbmdlcm91cy4NCj4gPiANCj4gPiBJIGFtIGJpdCBjb25mdXNl
ZCBhYm91dCB3aGF0IGRvIHlvdSBtZWFuIGJ5ICJoYXJkY29kZWQgZGVmaW5lcyBhcmUgb2ZlbiAN
Cj4gPiBtYXNzYWdlZCBhdCBydW50aW1lIi4gIERvIHlvdSBtZWFuIHRoZSBzdXBwb3J0ZWQgZmxh
Z3MgY2FuIGJlIGNoYW5nZWQgYXQgcnVudGltZQ0KPiA+IHZpYSBpb2N0bD8gIEJ1dCBpZiB3ZSBh
cmUgdGFsa2luZyBhYm91dCBpb2N0bCwgdGhlbiB0aGUgZmxhZ3MgbXVzdCBiZSBwYXJ0IG9mDQo+
ID4gdUFCSSwgd2hpY2ggc2hvdWxkbid0IGNoYW5nZT8NCj4gDQo+IE5vdCBieSBpb2N0bCwgYnV0
IGJ5IEtWTSdzIHNldHVwIGNvZGUuICBJcyB0aGlzIG1vcmUgY2xlYXI/DQo+IA0KPiAgIE1vdmUg
YSB2YXJpZXR5IG9mICJWQUxJRCBNQVNLIiBkZWZpbmVzLCBlLmcuIHRoYXQgY2FwdHVyZSB3aGlj
aCBmbGFncyBpbg0KPiAgIGEgZ2l2ZW4gaW9jdGwgYXJlIHN1cHBvcnRlZCBieSBLVk0sIGZyb20g
a3ZtX2hvc3QuaCB0byB4ODYuYy4gIFRoZSBzZXQgb2YNCj4gICB2YWxpZCBmbGFncy9iaXRzIGlz
IHZlcnkgbXVjaCBhIEtWTS1pbnRlcm5hbCBkZXRhaWwsIGFzIHRoZSB2YWx1ZXMgZnJvbSB0aGUN
Cj4gICBoYXJkY29kZWQgI2RlZmluZXMgYXJlIG9mdGVuIGNhcHR1cmVkIGFuZCBtYXNzYWdlZCBi
eSBLVk0ncyBzZXR1cCBjb2RlLCBpLmUuDQo+ICAgKmRpcmVjdGx5KiB1c2luZyB0aGUgbWFjcm9z
IG91dHNpZGUgb2YgS1ZNIHg4NiB3b3VsZCBiZSBhY3RpdmVseSBkYW5nZXJvdXMuDQoNClllcyBp
dCdzIGNsZWFyZXIgdG8gbWUuICBUaGFua3MhDQo=
