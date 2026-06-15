Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DF83EAC8B;
	Mon, 15 Jun 2026 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524530; cv=fail; b=P7/qdck8XouAd/eC5EQADI9Am+gpaTHnqP2qwx3min3Fi4yIwLCe0C1GyuM4fv+pPVB1GBDL1qFBGQ+mIExGDmiyzC2ItRdDBITj2mJGJXtRJ6XHoOOXCcuYfzkqAnljROl1r2fXLm1e5ZnkfacW7DDhuNa4Cx7hcogOkujqH64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524530; c=relaxed/simple;
	bh=qWCTqR7ZrZyRTwma41z9FWsWP/evLLYvmLrjIpq8LsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R1RRVxpHKNjx5ZK/I5hWDdtrqicGBXUMPZKr1pybPU0ETnmmEnOWD2yAoy2KcxLDzfr3Q0glvYbhOqzPrh+hOeYB6Ma6mGp3socfhGbk25F3owFK5tgsq2TbH/7yWFZOXzOUltao42g0dsOwaGJFl87FKlvizoS9Lazr/d8Szcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFmUazRR; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFmUazRR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781524530; x=1813060530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qWCTqR7ZrZyRTwma41z9FWsWP/evLLYvmLrjIpq8LsU=;
  b=nFmUazRRfAHKse1mBM3qtFgAMoU/kjIrDlnOuROsUAs06znusoBKydJ8
   ZpozPondKXz/hiC3MKy6dxwK8E+KguK4ImP7iApVulSUSx8f+R1JsaHmN
   YZTwdurpwfy6u8OhtuiEC5maA5XOWGlfHROxroQBY68WxucSxYJ0PBUoN
   lsxdBvpMQlBi2sPYvygPSMxoGQFSlSyRRKNHBmeFAmNOys/TesQ7uQ/Ek
   g6peDaW7Dfa1UPgRBrr4jdRQW+QplLvgprKAdkvthoZZUuK9jcEcIGomr
   GU37YogmLEf1cKCcl9gQ1s7q2AbD5esk+v8kK0qEUlC8LcKuZjd0qwXBc
   Q==;
X-CSE-ConnectionGUID: N0/Prm2GTvWtLNnmk3urOw==
X-CSE-MsgGUID: wTd1Fm9+SRGYOt9dcaocMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82298673"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82298673"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 04:55:28 -0700
X-CSE-ConnectionGUID: B0X/VtGLTkmXF2nicTwwmw==
X-CSE-MsgGUID: loff2GxPT6SZBNXjnjhClw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 04:55:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 04:55:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 04:55:27 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 04:55:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwckzASyCQrkJbsl+yy5pWBY7VOQwpsmW2z5cpDzzxVi3q+YPOFquD5mE1gh9na7G8gXt1Wxa0iixyrQ13S9EIrkbMMhPf213Wwk2m7yOaQCfZ5uTWvpT66iQObkFhsIV7EfBWvbH+ZYHll3qWXSxcgTgdz+DN4RzLcFa5mY/1+Qc/MVRzGVLeI3cos0Qr3MM7by0tO9DbTm095J3JDl665Vb2uB9XiDnWdC8zh1ya4p0lTtT/QK/Mxarch8vColwXfRWBsPpq4WB2rAD1fTCT/dGxpO8S3rzUbhQyPD1DJz+TcxRub5aVecLvecui0CQlfnJH7+3+RucLpQSNuEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWCTqR7ZrZyRTwma41z9FWsWP/evLLYvmLrjIpq8LsU=;
 b=r4bMw08UENV5U8hbd2YS8SZnYtJb3ectolAu5GxtPOPih1y+NIIIl0WfFmWpVS3Y7lytNKdSsLlCiuFZPI/PDYU+WYD7gdAx9F2R0wyWaNuQWU1YT/TbJjyVz977dVtXmlKKE8mqT6YDaINc8vC0DO1bYcA+fHY72cVII9LPPpuJnsSRSv4DnPgVbVYrVUeGcKdYWok0Cd1WvWSUNP04hABgVkemhRueeMAcDkKzGa5xcGephVGZocylaTycqkeEVveYzDDGZL/F6XaqwdNdkUDyzTVCh4tQ9Bx9GJVyBFGdcWDiu6KuMtwZZwnxh6jVvLCbICXRjohixtidTgtxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH3PPFD9B78DE02.namprd11.prod.outlook.com (2603:10b6:518:1::d53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 11:55:24 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 11:55:24 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH v4 24/30] KVM: x86: Move IRQ-related helper declarations
 from kvm_host.h => irq.h
Thread-Topic: [PATCH v4 24/30] KVM: x86: Move IRQ-related helper declarations
 from kvm_host.h => irq.h
Thread-Index: AQHc+sgx66wmGQrqWUKT4rrRHBniQ7Y/hh8A
Date: Mon, 15 Jun 2026 11:55:23 +0000
Message-ID: <d777b5f3df788c2176e00deb2a2bdf75290f3059.camel@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
	 <20260613000329.732085-25-seanjc@google.com>
In-Reply-To: <20260613000329.732085-25-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH3PPFD9B78DE02:EE_
x-ms-office365-filtering-correlation-id: 21b78517-0b58-4ce8-24d2-08decad4fbd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|6133799003|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: PlY1X1LUObs6LhESiaNn7ECxlQHHpBJySyQ+9om39ua90nblbBNnOAX48C/RS2JtpdGODbLxwabV9XZN06qSSi3LJAhvhcShMbSQJUQJ+vxIlaLpYCSZb+r44NV3uRtpDoS7p40TdWStBUlmE0urDqln/XyTfgCbDN1yVhTuCrVgPZRzKBFyV6NB6izu9D/KzdEHg80DBtbgZYL4cgxIB4WrDCWv4T5Lw/ODCLTD2bXjMuL9gWHmp4GYxORQzewAvHtvCN+lhZeWyB6gwGtnI0NdIBkh62Zr/rRlCM9M2QuKzgfa6UH1yeBb2Fl5KvFp2IN+SWckQvx0NpXCY7mS7Eoq1U31tyg2TjGgnKDf7dLkM2c9qIpOp4BdjL7jyQlJkiPwwzHh6IJ7VB5GWC3KMhuwvBIt6YmKlE749Ige3MVGinh2wDDDqqdMfi05xz9fqvlM3tD8//HoVDNu3Id8fIasyWUx2eFhuEZEH39yJitQzig8JgQsJKA43gpRvCft/hG1Fa0ug8ZrkJ0gKgIm6jB8tDduZ4QlhVIiQVplfCZFrDqVU5y/VgZ06AELg1Z9p0edVVxE9szwLRmVntNNteziaZmniFZdbdR1dnbX5omQm+q88y8dlAlVLkWUSNTs6D7z5BO2IbxAnIqVNCj6SVTzaQVmzMFZbyqu2RSZ4aQJ80qrsksJRvVUV9nZjVqMQOZS+SUzrQ3K9fI+PErPbZk7+3Yq/qcADMdwoww4P7gT7E8uKNgQApw4/lJcSC6U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmZqK3F5YWhJMzlnc1FuRzFDZVdlc1F6d1hHcHpIdWdJcjlqM3JKTXp5Ulpu?=
 =?utf-8?B?M2R4OGxmVzZOU1pxdGJXUURhNnh6bDJlamJPbDMzSlVGUlZKOWZzeUZoOWhR?=
 =?utf-8?B?ZC8xVWwxQjMvOGZJMlI1azVleTVSZVZvbmNzR2x3U2RFcTBZMmdNd2FyUWVy?=
 =?utf-8?B?MDB3OGJsMzl4V3ltUUUzSXpqeGlITHIwSFVkaFN3bVpuS2dRaEhBZ0o3WFFD?=
 =?utf-8?B?bFZaWXlmT3Q3dmhvdHVTaGt5MVlrTkwyLysrSzgwdXNSN1VaM09TMzJWUkRk?=
 =?utf-8?B?V255aE1aRVVqOUNPS1JTeVdqdzNMM0k4bXpoVER2cnhaTWlJcjFIaGhxL2xN?=
 =?utf-8?B?K3UzZWxuV2F1bXdwdmNyekxYL3VoMXR4d1pUZUJXZEh1VWFRTlV6MXV0dmt5?=
 =?utf-8?B?YmlDVFd2THVQYzczajNLRmlXQVdkK1Urd05OdXRxNW5MY0NwUU9EQ3FMTjNZ?=
 =?utf-8?B?U3BTUFZJNXltTUhJLzdaa2lhUm1NU1JteHJvdnQrbXlvRE9ZTWtjVUNDajFS?=
 =?utf-8?B?V21yck5YOXlLRkNZM3BITk5ITENtdUlGc3BPZHM3WFQ0UGlmTmtJbzVwSnRk?=
 =?utf-8?B?SG9GMDZuVWpramxtaTZsVDR6T1BSdk5vZ250M3ppTU95a1ZVTXVtUGFYbkx1?=
 =?utf-8?B?eTJrNWtWTzdUeE5FZDhsMGMzNUltQmcxOFFVLzVXc0ZwWHhndEQ0VGtlMDJh?=
 =?utf-8?B?Z3AzVVpDYi90TGZ2TGpoeHRybHd2MWxsSnExNlVZOE9ncnpJdTB6QVdoNFQv?=
 =?utf-8?B?RDFyVXRvMjlCbXl2djhaRW9hSkhEb0F2UnRsRG9hNnFtUzBZQ1BDZ0FWMVR0?=
 =?utf-8?B?Z3hvTVh1VnVEc1JVcUttemI4dVdNRDJuZ29qWnU5cFE2bERtaDc3UW11VGRr?=
 =?utf-8?B?NDllYjVNSzZNMHdaMHkwR3hVUGRNd2ozY1RiNWx0THo0N3NsV05TMXRUMmNk?=
 =?utf-8?B?L2g4SjZBZittQ1NEemhHejgwZkpnR2VqSDFGN0xhamV5VzR0QkZ2ZUNQNzdH?=
 =?utf-8?B?cGo2djFTVnExREF2TnprOWI0cXFxUHgyejZwNjRmdVpjZ2ptRDFFMjV6VUpj?=
 =?utf-8?B?cTlMZDJqWTdRV1NURmFOTFk0ZEp4ZFljeFdkSExpRjJPVzIwZG83NmtzRjhW?=
 =?utf-8?B?Tk9zcWM3SW95UlRoTjg4SVJoamxBZWtMMFgxUHVUQXIrUGd3OGk3YUFQNXVE?=
 =?utf-8?B?eUhmY0FlKzJHSmYvMWRONmJNckt1OGxmZXlqMm04UDc1ZVRkK1N2dnFXNVdk?=
 =?utf-8?B?UUVsRExlaUdieFYrZUlMYWUvTTgxSU96ejRBcnVZMFVIOGF5UTI2UkxxNkZC?=
 =?utf-8?B?VzM3MEN3OU1UeVRDTWZIelZhaDRhZVQ1SlIrMjFQWWhITGRKYWk5RnV1eTlu?=
 =?utf-8?B?YzdTUlh5aDBSaDNYMWp2K3MwNjQxMWFFOVZZTzNIL3hVNFV6ZzdJcnphRW9P?=
 =?utf-8?B?ZFgyOCtwSDFjaVJGdXZSM0U0Z1BLNFpEY2piMThvc1ZFUjVpRGNhQXZYOW5w?=
 =?utf-8?B?dUZ5NUs4emVPd3ZTMjZ5YWU5WVIwa3B0cUdWdGtSQWZhL1RXWTNyS0U4djUw?=
 =?utf-8?B?SW05bUsvNWR3bkxyeU9NOFUxN0RHN0FZcTFTc2tEZExBM2xJZ09pODU2cERB?=
 =?utf-8?B?MTk0cVR1L3BwWUxNbWhyQjN6SEk4Mmx6WTBMc0ZQNTRSZTZwWkd6YzlsQUtB?=
 =?utf-8?B?Vmw4M2JTQWwxVndqMEFEUzBCTkx2TXg4TlJ6NDlseDdrUUdSNXJ2UHhaekFE?=
 =?utf-8?B?VmZzNVBVQklGR1pzUE5kYWcxZGNSOU5CS0M3Um50WXN3VzY0UEF0aDJ6RDVH?=
 =?utf-8?B?ZlF4c3lJL1JlaUhGbnFvWXQzRjhKaU1scFN1bjhGVHArZmlSRUxJQ0dQTlBt?=
 =?utf-8?B?RXV4WkRkaFlEekhkQnBNWWZvYkt6Q3I2VXdObDc5QVpmUlI4bjNwckJ5RmlW?=
 =?utf-8?B?TjhSTWlYdjlqRk81eEFjV1FhNEZDemorc2M4d3NYQksrVUR1blQzaW4reUtx?=
 =?utf-8?B?Z0IzRnJ3dTl5VTkwbVAremlDR2Y3NHFPRFFWVEI5RXRid1QvdXkzVVZXOHBK?=
 =?utf-8?B?YUFldHZBd1dWcUdGb0dSdkt4T3MyVXR4VHZBcTlvRHBibk9VNmEwMlRvQnZ4?=
 =?utf-8?B?clpIU2lYSFM1TThOVG45dVBpaEJWNUlBeU1YWEJVMEk5YkRuVTIrcGdkM0tL?=
 =?utf-8?B?NEsvVU56bWRSY05sa1kyVjUxTnJYYU1uVmhyRVhLQXZkYkFmK1NBcC9lRjVM?=
 =?utf-8?B?R0c5eGZDVWIrRkFoSHVDdHFoa2FnT2pNZUdvT3UxVkt4VGlSRFpOM2Z4TzNm?=
 =?utf-8?B?bWhGRWs4VTJqcmQyL2krZHJWdDdEWGo5Nm5jSUdCclJLK1o4aGVrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5ABE779C27FBE746B0827F076AA20B36@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YAg/ZDED1BP+RecglGGt32/6xGY7n3tLIXPPhcS3EZQ8a33/uLDKo+r7IlDc89YP1kQvnPJ1mk8IAXSxQCAlWlTj29XhC17WFApGj/brzfu0TN1wQLzc4Ws/wAPztuYlhfSfMhp3Q2Nsdg3k3qv7lOZRRvQNd96uxG9fXLydZL45AEyb5ITlXWaW8NOW9m2c0q1qXBWsU5GWaWwrA7TEl+2owbfPFlfFfnXCnh6W6VLDr1bojz7KoSLYsxkRLWdBPD7Ch96QqJMOTZsEMfwtuuC9FEi6rQbknzdYHzxASD/cF/uYi5Gd+VTM9qEs1qqAdzOtWNd4gdmNhc8+s9/v5w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b78517-0b58-4ce8-24d2-08decad4fbd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 11:55:23.9574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2eszPYaFzG6RHQ0W6Z0NTjJbi5UZQlfMc2FDBA6aAasBiYfqUW5pXHze2bEqSbXkBxDkkW6DrwT9nJ6Af2sNig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD9B78DE02
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTEyIGF0IDE3OjAzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIHRoZSBmdW5jdGlvbiBkZWNsYXJhdGlvbiBmb3IgQVBJcyB0byBnZXQvcXVl
cnkgcGVuZGluZyBJUlFzIGZyb20NCj4ga3ZtX2hvc3QuaCB0byBpcnEuaCwgYXMgdGhlIEFQSXMg
YXJlIG9ubHkgdXNlZCBieSBLVk0geDg2IGNvZGUuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5n
ZSBpbnRlbmRlZC4NCj4gDQo+IFJldmlld2VkLWJ5OiBZb3NyeSBBaG1lZCA8eW9zcnlAa2VybmVs
Lm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2ds
ZS5jb20+DQo+IA0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29t
Pg0K
