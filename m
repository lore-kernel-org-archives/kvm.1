Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A393A1A38;
	Tue, 14 Apr 2026 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155212; cv=fail; b=jQTSCWUI/zfsJ9+w2YyLGfIa4wfBwpydRq4RG0fpEowmcv8sYSQkwKCUJ20PPHmKaifPcBmkYfm7LDGbJP3N4DTaRon4uy8AZjpTa7SLqkQA3yGRW98zXRVTokgMGm83wIjsuGgT6FJPLHyp2vE8TISg6EuyNTF3UU0aqGvabSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155212; c=relaxed/simple;
	bh=Gzj1BJMutxBGeOPxmL7eioLcaVzs+He7uzWsSN/j0i0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RGkPNrf+yBm2ntSHeHw69jivaf6mxgcqbg86enJXl8KYUUOa69Y+Bm+fB3Nw0B1e4eoqc/6H/KMqOMReAsC2ZGpKOiyMg6EiNrkYK/v43jXuSgqOKevc2k5WVOGc24EQ3+PmXF8Z6KHL9QQqye2QLRh4ZvK6VNI9oHPzpBkdxh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPypBVJz; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPypBVJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776155211; x=1807691211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gzj1BJMutxBGeOPxmL7eioLcaVzs+He7uzWsSN/j0i0=;
  b=JPypBVJzaZHqU+YuZvJChGCF7F/NRzV+936eea2P+DcawO+XZaC6fPlZ
   00xWX7JT36m42p/bW/icnl5iQPpDtpivbtKO+0ndp54jlpm7pDvVuxxLb
   zdlP+lt1uWmI54iPB296cOZe5/Q0FE7GOmQ1UlUqsFCO1/B42cX8CDF8o
   xU3uroQvFuzyyypkQ3fBRoPcOLqFVV/ayW+Zfu1t4wFocs4a/YgpG221A
   K7XOH70+ZzqenKapkfiF0zWh7jzDtBpXNb0fFKp3GFKywoSB0NBoKO/j+
   c66HRTNx9l5DbgYHejw4+UK9MSrXKk6dh4qruugueaEOveeKxQi3FXU91
   g==;
X-CSE-ConnectionGUID: BLDardJYR2ax9gWnpEBQDg==
X-CSE-MsgGUID: s8L7aeyWT0KCuluIq+7xKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="102561517"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="102561517"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 01:26:50 -0700
X-CSE-ConnectionGUID: VwjF+7KBTL+0/ZPvToSxtg==
X-CSE-MsgGUID: Q3D+nRkZR66MV1WfuLg6EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234428085"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 01:26:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 01:26:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 01:26:49 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 01:26:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bgc5Gj0OhMRtVnj9+5WpkaRI+0W+7JZwKDV9XSHTxWmJzunyR2gRqormX8PbyxQLXCkeiVHOnUQHEt27ts7IAopkmZBFnTwzPNHN+WhLOKFbCksBoP6RvfjoJQ9tQa7dLfzF8sbV/vTcctNzqp4WePPE26pNbIg9IIeqz8Bq0lr5i35tnj6AaUoNna82nHWaS5EuuqI1jFFCw5nQLuD4lsyIS5q+MW0jl7wg+viz43NTZmMwHMAH36kkFLrQPrYv0SChvnWsmeJQ21980yiGKIfkY2h7wt3eDqQE9IqtNjuuxMXEEd0AzI9+LNPIGBwpmNJpJ0/wsHpHwsn0feKajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gzj1BJMutxBGeOPxmL7eioLcaVzs+He7uzWsSN/j0i0=;
 b=PS8Fn2Jo9UFTnV8df3bNia415C+ojcKXy4hTFmBAEDNW0RazaKwCmotmT6HCzgg03GIqOyRXj2hQv+8JANVIyjZQ81+QCENqMzpHnE5Zo52rY8WVc/dZxi3aUdE9oK4S5uqQo8afpX0/hbfxzOYwhNtr1M1DXgsKgcIoNHVX9M3MBwnqQOTThjecwfUV24tji3A7WLI19b+uoUbqFAAZJwIAueb9Sv+0osYJ4s3rVocZHQei4HOIPPJwZWTiz2BgIjT3KW3jJHMdd2UD3at0A4voeh22+0N1kTrvKdT0Q9LTgz6k/qOQonD5MedLQmsd970n/KSwSixSstZjOu7yKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA1PR11MB9849.namprd11.prod.outlook.com (2603:10b6:806:4d7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Tue, 14 Apr 2026 08:26:47 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 08:26:47 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH 07/11] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
Thread-Topic: [PATCH 07/11] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
Thread-Index: AQHcyHzSXiT5XCiFDUKuKJP/5RyUcbXeP+KA
Date: Tue, 14 Apr 2026 08:26:47 +0000
Message-ID: <04265eaad625a7e594f1f1b273cfde3c90b84934.camel@intel.com>
References: <20260409235622.2052730-1-seanjc@google.com>
	 <20260409235622.2052730-8-seanjc@google.com>
In-Reply-To: <20260409235622.2052730-8-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA1PR11MB9849:EE_
x-ms-office365-filtering-correlation-id: b71ef2d9-f438-4238-67af-08de99ff91e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: e2Ajmelx+m3RY5ew0Aboq2vcakshMUx7uErhp1zGaXd1MFb9DRHbtcsgyp1jCW9PXSmnheDoFbDxDJHQ8o/yQPSgYui3z7Ior4idh2eyQutAJojg9mwDTH9w8qu2z3MBHLSeNrJAxf/sMBZHye/FvbRvxoXVb4hOSSk10iLbOGMfWEpHUoyVoWqKEXX/PI5N9GyAskqqmuaWmq4rFFeIF1mSKqVgs7TYBqcpZcRINnXswn89CCticzWh/7d/dFnhgF22eL/OqorJ+h4UZ5JBkz/y5lg4mWGhMGR4x5b3sltdQzCQrTTYyZrFi/60f2rrPc+bkWjYPlJR7eXJLCIvf7hJOaVE5Ez7j86ameNawKFmMSFbEAJ8yg10zIObtB0x1oRc5eoET8CF2AmdwCU+Wt7skf86OvE5j3o4yvaVuKBmlWSW/Gk0TxeM1Op3nHncVigKpxbDarkCo8EzoYRD+xZ/hp6cq0H9HhQrFvOj3FjbmH2nUbHsOp1Kg5z8WyMzw8XjKgGTAzzanSXsR6r4N0o5iYpY37OH2WzaJwI2oL8hjEnUMwi3Ts0+vzhTEur/6NeOtyXud5lzRsyWa6mCkSKOI2d347TInb1nteE4mDyW6/19U28XGLusFoRzQ3KmoblWQRhADixSSzvV501IRxunk+4jCaCno/mLD10wrDLblkdkfi86b0+jEFY+oXotuHCU49QT8t4bPkzgRnCa4j6uK1+7kANgdtowHyxeXOYfN2dQRXiTdsfUmwuUcGObErpRAq/8/qyQHT+WEbRIBtWqeHgkPifjDovCk4EJcho=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0lSSExicGJwd01QMld0b1dlZjdBYS9QSmNkN2tmWDUvR1JkSWtad2VYRmx4?=
 =?utf-8?B?cTRuTWo5QW13RDF4bE9nNW5nRFNIUkE2UzlyTDRMb1VTTUVzRjgzN1JzQlJP?=
 =?utf-8?B?T1lOYkdDK3N1OGxSK1FZZjRaVGpCUUtlLzNiYS9rcUFqQ1NsbXhaR2MrV3I5?=
 =?utf-8?B?NkFsYmxPLzZkT01BQW1VbXMwQmF4RWp0Z0ZEK0QraC9Md1VzblVmZ2VRL3Bk?=
 =?utf-8?B?TnhVU1hEWExHclphRjRUengrcldrYjl5bVl4b2p0cy9WaTZ4dm50ZGREalFp?=
 =?utf-8?B?WUx2SWRlbDBnVzNFTDRaUjE3SXBFbVhWYWNBcnRjNktDbCtzMGZWSXJMejFo?=
 =?utf-8?B?ZEV5bDQySVlqT2lFTjdaVGxKOEhvOUtoMGlIUVNieTlQV1VGSkpwaHkvY1ZM?=
 =?utf-8?B?UDlSekpqeXFPY0hlSjRxRElYcVppNnRMOTdNcnltdHhISGRSVEw4UkpzT3dH?=
 =?utf-8?B?UEJLbmdLUi9XaThJdHVHVFNyc0kzSnByTldJSDZMc3d0N1pNbmczbjhIbUND?=
 =?utf-8?B?MlpNOGxJak1SdXVsN0FlOXBiRjNUYzJUbUJ3M29NNTR4VWZYZTRXUWl5bVJ4?=
 =?utf-8?B?bFA4R1hLT0x0UUR6aXRFZVpoZW5lK25rSFU2QTk1cEJJNkpMd1BmNDJGbWpn?=
 =?utf-8?B?VkdhZ3JkVnE5NEY2WS94Z2lyWENxbDhnTnE4am9adjJjRVBVdmZaYktxTXhq?=
 =?utf-8?B?M25tRDNMT2RzSi94WTF6MDFoNHhBRVhZSzBJNHQyQnhKaFc5N3IzUTBFN1NC?=
 =?utf-8?B?dm5nTndLTWpBZVJTMk9RaHZhNG11Wm1KTFYwWWpoWUZiWWF6NGpKbWZCVVV1?=
 =?utf-8?B?a3NGQWREakx3NHQ2NjU4TlprZlRIRmVSVzhXTXl1cWduVSt4WW1lK2VIQkw3?=
 =?utf-8?B?Qi81em1jQk9oQ1orMmY5cDJpS1hYY0JjTFNpdjNGQWJEdWJ0eWh0WTNrVGlt?=
 =?utf-8?B?UTFpdVluNk5uTzZBRHFoNnVFbFJFTTBYYmxYZ3E2a1JKMjFTa2tNREV2cDZR?=
 =?utf-8?B?LzB1RC84S3lmRCt6bXBkcGl5bVRPQ3JHWjFoblZTM1k4Yk1LK1NGeDdMZG84?=
 =?utf-8?B?WmU3VFNPUnhLOXE1R052UHNrZ1ViN0FtcFl4Ny92SXh0UTludzcxRG54MGhR?=
 =?utf-8?B?c2lsbzdkWG1IWG1Zb1h1cjVZcWRMUWQyYWw3NDQwQ0R1bEhJOVpuUjdEd1pE?=
 =?utf-8?B?Qk1odEk0aEtLOEdEZkRFODV1WWdiV25wTWwrWm9jdUEwSFFlZUh2ZzdnRUdu?=
 =?utf-8?B?bnFlenJYY3RIc2JTSUhSdWVTV0Q5M3o2ZDY3VGNPcVRqR1V0a2Y0WlZ6TjlH?=
 =?utf-8?B?REkrKzhWQVB5Q1JSUzZxVWdab3gwbHpia1ExMHliTDZXN1FITXVlWFhCaDRl?=
 =?utf-8?B?b0J0bTJNRFdlc3BmRnpydis1dHRzTGt4T1BsSXpnL2hPMHZhZ3lOZGcwTXVY?=
 =?utf-8?B?UVJrOEZveUUrU2RjTEhVTWtYWE12aG5oWEFOOGdqc1phbmFBeVoyMm03ZXdo?=
 =?utf-8?B?SFBtS2prQldRUWdRSExqczNSMDdNZFRzU1ZOOTNQNmJZY2YyYkFMbU95Snov?=
 =?utf-8?B?OWF4WTVJV3NrOTZUV200MGhLTTdMN1M5NkVMSFNWRmRoZ1NpdTNEeXlxMWpt?=
 =?utf-8?B?NDllWlZqNjF2RG4rWFZzbDlRYUQ4cHQ0SUpmTkZrUE5nWlFqdTNnRVFyVVRG?=
 =?utf-8?B?TjROR09MbzYrNXZiUkJXTFZGdEdtS3BkSmtRbVZkbGxtbEhNcElZVGlLUjc3?=
 =?utf-8?B?bDRZYzZpMnhObVEwY3dCRkZtWStYR3kvcXZQU0l2b00yWWR2bHBKc3RjbStQ?=
 =?utf-8?B?eWhETVZqR0ljZ1VuSW5iYm1QNENtenlPSEZOalpZUm0zRmcwWUxzeU8wSTRB?=
 =?utf-8?B?SHRwMFBOYW0zcmFTNGIvMm9LN0Yzc0ZtblByQlk3dkVwTnd5dkdBUzhFckV0?=
 =?utf-8?B?bk1EM0RmSVRRUXlqeE9QckxRbTBiM2ZBSE45TEUvc0hsdW9ySjdGOHhPM2wv?=
 =?utf-8?B?VU51Mi8vK2p5Z3VvVCtKb2E2ajZ0bkNCTGlaRVFmclByM29wS3JnNHdGUHNG?=
 =?utf-8?B?K3B2WFFmMysyUnpQU1gwQVAwcmhIMVR5dnZtR3h2cGMwL3I0OXpQUVNmZW45?=
 =?utf-8?B?YitpcFdNQjgvcFFvK05hUitSL2NWeDRUTlBFcFk4OTM5MWtxMno5S0hwamxl?=
 =?utf-8?B?aDhpMS9xM2ZZWWpmY2g3RUhhMElWWXc0ZkVpQjcyZko2ZXNEMjR4OGREb1NS?=
 =?utf-8?B?aE1zWkRGRm0yeE1rV01JeXVCT20vVFZKWlBRcDBGZ3ExV2FGWEowMUphejVh?=
 =?utf-8?B?dXB0ejlNT1BhY1BuVkhIRTJPcnpjYTNsbVV1cktLdzA2T21uWVFqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7BED27EBB3B474E92AD823CB6FA470F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OQQpATOQAUlGyhpKgbuoKr1OcjeiWGtjWvoC2rDGu4L/7kzK+CDD+Grnp1R8clg6jFKFNefLciY7AFwwtdgALBsw0egOiOP2+MIhLqrKN+Q5bd9lPWmTk7a+AFQPVxc+q0l+Ps+yjMS8s9CdLX1K0Aj7Bq73X/oPriJGlhjhQKWxtSxsnlPdGabGEFoUUsGeCUmEpuJ6ihNCy2YoP+vk3cDtSF6ENb/XBknZE3O0kusWvD3u1rX7hLH55me4zZhLwW6U7nLb/DoXoGDEC5Lp8dhdRRII2yYvQwjSq3ex6zQDK3Cz5yDeF0q1CjDjV3BeG+xK1PeNtzfi1ozdmj/8Gw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71ef2d9-f438-4238-67af-08de99ff91e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:26:47.6501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOrMyGzYWOpCelsnlP2+vyUMbSvsDkr0RoLPl0yGMroY69GmBacyf4KH9EQWdAQ+uVDXUMry2hO0gacYaC7syg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9849
X-OriginatorOrg: intel.com

DQo+IC0tLSBhL2FyY2gveDg2L2t2bS9zdm0vbmVzdGVkLmMNCj4gKysrIGIvYXJjaC94ODYva3Zt
L3N2bS9uZXN0ZWQuYw0KPiBAQCAtNzU3LDcgKzc1Nyw3IEBAIHN0YXRpYyB2b2lkIG5lc3RlZF92
bWNiMDJfcHJlcGFyZV9zYXZlKHN0cnVjdCB2Y3B1X3N2bSAqc3ZtKQ0KPiAgDQo+ICAJc3ZtLT52
Y3B1LmFyY2guY3IyID0gc2F2ZS0+Y3IyOw0KPiAgDQo+IC0Ja3ZtX3JheF93cml0ZSh2Y3B1LCBz
YXZlLT5yYXgpOw0KPiArCWt2bV9yYXhfd3JpdGVfcmF3KHZjcHUsIHNhdmUtPnJheCk7DQo+ICAJ
a3ZtX3JzcF93cml0ZSh2Y3B1LCBzYXZlLT5yc3ApOw0KPiAgCWt2bV9yaXBfd3JpdGUodmNwdSwg
c2F2ZS0+cmlwKTsNCj4gIA0KPiBAQCAtMTIzOCw3ICsxMjM4LDcgQEAgc3RhdGljIGludCBuZXN0
ZWRfc3ZtX3ZtZXhpdF91cGRhdGVfdm1jYjEyKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gIAl2
bWNiMTItPnNhdmUucmZsYWdzID0ga3ZtX2dldF9yZmxhZ3ModmNwdSk7DQo+ICAJdm1jYjEyLT5z
YXZlLnJpcCAgICA9IGt2bV9yaXBfcmVhZCh2Y3B1KTsNCj4gIAl2bWNiMTItPnNhdmUucnNwICAg
ID0ga3ZtX3JzcF9yZWFkKHZjcHUpOw0KPiAtCXZtY2IxMi0+c2F2ZS5yYXggICAgPSBrdm1fcmF4
X3JlYWQodmNwdSk7DQo+ICsJdm1jYjEyLT5zYXZlLnJheCAgICA9IGt2bV9yYXhfcmVhZF9yYXco
dmNwdSk7DQoNCk5vdCBzdXJlIHdoZXRoZXIgaXQgbWF0dGVycywgSSB0aGluayB0aGVyZSdzIGFu
IGluY29uc2lzdGVuY3kgaGVyZToNCg0KVGhlICJyYXgiIG9uZSBoYXMgInJhdyIgcG9zdGZpeCwg
YnV0ICJyc3AiIGRvZXNuJ3QsIGRlc3BpdGUgaW4gcHJhY3RpY2UgaXQNCmlzIGFsc28gYSAicmF3
IiBvcGVyYXRpb24uICBEaXR0byBmb3IgInJpcCIsIGFsdGhvdWdoIGl0IHdpbGwgYmUgbW92ZWQg
b3V0DQpvZiB0aGUgInJlZ3NbXSIgR1BSIGFycmF5Lg0KDQpCdXQgbWF5YmUgdGhleSBhcmUgZGlm
ZmVyZW50Pw0KDQpbLi4uXQ0KDQo+ICAJY2FzZSBFWElUX1JFQVNPTl9NU1JfV1JJVEU6DQo+IC0J
CWt2bV9yY3hfd3JpdGUodmNwdSwgdGR4LT52cF9lbnRlcl9hcmdzLnIxMik7DQo+IC0JCWt2bV9y
YXhfd3JpdGUodmNwdSwgdGR4LT52cF9lbnRlcl9hcmdzLnIxMyAmIC0xdSk7DQo+IC0JCWt2bV9y
ZHhfd3JpdGUodmNwdSwgdGR4LT52cF9lbnRlcl9hcmdzLnIxMyA+PiAzMik7DQo+ICsJCWt2bV9l
Y3hfd3JpdGUodmNwdSwgdGR4LT52cF9lbnRlcl9hcmdzLnIxMik7DQo+ICsJCWt2bV9lYXhfd3Jp
dGUodmNwdSwgdGR4LT52cF9lbnRlcl9hcmdzLnIxMyAmIC0xdSk7DQoNCk5pdDogIHRoZSAiJiAt
MXUiIGlzbid0IG5lZWRlZCBhbnltb3JlIHdpdGggdXNpbmcga3ZtX2VheF93cml0ZSgpLCBidXQg
bWF5YmUNCndlIHNob3VsZCBqdXN0IGZvY3VzIG9uIHJlcGxhY2luZyB0aGUgZnVuY3Rpb25zIGlu
IHRoaXMgcGF0Y2ggYnV0IGxlYXZlDQpjbGVhbnVwIGluIHRoZSBmdXR1cmUuDQoNClsuLi5dDQoN
Cg0KPiBAQCAtMTIxODQsMjMgKzEyMTg1LDIzIEBAIHN0YXRpYyB2b2lkIF9fc2V0X3JlZ3Moc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3JlZ3MgKnJlZ3MpDQo+ICAJdmNwdS0+YXJj
aC5lbXVsYXRlX3JlZ3NfbmVlZF9zeW5jX2Zyb21fdmNwdSA9IHRydWU7DQo+ICAJdmNwdS0+YXJj
aC5lbXVsYXRlX3JlZ3NfbmVlZF9zeW5jX3RvX3ZjcHUgPSBmYWxzZTsNCj4gIA0KPiAtCWt2bV9y
YXhfd3JpdGUodmNwdSwgcmVncy0+cmF4KTsNCj4gLQlrdm1fcmJ4X3dyaXRlKHZjcHUsIHJlZ3Mt
PnJieCk7DQo+IC0Ja3ZtX3JjeF93cml0ZSh2Y3B1LCByZWdzLT5yY3gpOw0KPiAtCWt2bV9yZHhf
d3JpdGUodmNwdSwgcmVncy0+cmR4KTsNCj4gLQlrdm1fcnNpX3dyaXRlKHZjcHUsIHJlZ3MtPnJz
aSk7DQo+IC0Ja3ZtX3JkaV93cml0ZSh2Y3B1LCByZWdzLT5yZGkpOw0KPiArCWt2bV9yYXhfd3Jp
dGVfcmF3KHZjcHUsIHJlZ3MtPnJheCk7DQo+ICsJa3ZtX3JieF93cml0ZV9yYXcodmNwdSwgcmVn
cy0+cmJ4KTsNCj4gKwlrdm1fcmN4X3dyaXRlX3Jhdyh2Y3B1LCByZWdzLT5yY3gpOw0KPiArCWt2
bV9yZHhfd3JpdGVfcmF3KHZjcHUsIHJlZ3MtPnJkeCk7DQo+ICsJa3ZtX3JzaV93cml0ZV9yYXco
dmNwdSwgcmVncy0+cnNpKTsNCj4gKwlrdm1fcmRpX3dyaXRlX3Jhdyh2Y3B1LCByZWdzLT5yZGkp
Ow0KPiAgCWt2bV9yc3Bfd3JpdGUodmNwdSwgcmVncy0+cnNwKTsNCj4gLQlrdm1fcmJwX3dyaXRl
KHZjcHUsIHJlZ3MtPnJicCk7DQo+ICsJa3ZtX3JicF93cml0ZV9yYXcodmNwdSwgcmVncy0+cmJw
KTsNCj4gDQoNCkRpdHRvLCB0aGUgInJzcCIgb25lIHN0YW5kcyBvdXQuIDotKQ0KDQpbLi4uXQ0K
DQo+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQga3ZtX2UjI2xuYW1lIyNfd3JpdGUoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LAl1MzIgdmFsKQlcDQoNCkl0IHNlZW1zIHRhYiBpcyB1c2VkIGJl
Zm9yZSB0aGUgJ3UzMiB2YWwnLiAgU2VlbXMgbm8gbmVlZC4NCg==
