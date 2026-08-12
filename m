Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA7218592;
	Wed, 12 Aug 2026 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571942; cv=fail; b=bH4B+GIvVS/xT6exHmsJeayK7oxuI5txm5OMHKFIQUf+8UJS8sWfNsMkjg3sa7EWE7PZLD3z+iyVf7OkjpKGqxrorxGnrLoFZ2Kx2JWHSAYKg42IBJbolW1kOMX7yc9fI5OjeZWymOiQPKaI4Y2VK9VAacFn3WevKIdNJX5HP5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571942; c=relaxed/simple;
	bh=3KXtc4ilymaXNcw+7OMufWRf/ySB6e19QGueWcv5KeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gMaqFtZ22NZ+sUe3S/xgleVfuRDkA0piZ6qsnJErsT3k3w4PSee6wHyhrDxGYbH0peWMq1j7vrmqhIXxQuM+0X9hw+SHccluU947le90WRVyl0Nftd3n9WgUyOwztL7/tBq7DQWdoSksuuba+qkI5vKu2GCVi4y5z8NPZyGg7+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5b5slmV; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5b5slmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786571942; x=1818107942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3KXtc4ilymaXNcw+7OMufWRf/ySB6e19QGueWcv5KeU=;
  b=Q5b5slmV8VCjKpFR3YWPpC1fdhCWdye8KBj0GHTB0UsOEzswIrWjSc38
   V/otl2IsdFKFXdhbgEyoZLcrWCzQR+90SenL2Q68CdGAWaKlHtQouLg+r
   E8Ukv8En/Yaoes81I9DjID+D1oShEKBqcNGXktz6Gi+pcv4UuG8uzVQQu
   gV70Cen6B6YcY9ij21UMaHE4qdigtRVNm5h2z5MtxES1Sx3VxJ8Tk+8Gy
   uYULS6C1PoFxuW9y8zf3FA1gzHoQ6pp3ARWM6LnI5PKSx1SRP1ereBm+g
   xsn6hmTO8+XQ3NHLFcyEjB5DI5+RRTg/Q34ZWw/+rYIBbIgvsMM/v4r42
   A==;
X-CSE-ConnectionGUID: vKEygrZTQbCRXZSCy07/wQ==
X-CSE-MsgGUID: Urk5CgeeSKuH7bgzSohxnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87215956"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87215956"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 14:59:01 -0700
X-CSE-ConnectionGUID: XzEbEyX/QPqqt71vnMJPeA==
X-CSE-MsgGUID: 9ZRrv3mSSQOXCy06CrN7HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="288538288"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 14:59:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 14:59:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 14:59:00 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 14:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWxCqYCwwhg4BeQTl+NatHZGCT4JfEtJ13P1GWCLtogIiXl4AN1V/zzZgKGIUFHmQla688zd+voVy/UXjPQyM+10Stx1qNlMZfA2fw0jTiqB7UAo6IH8CKsFJJX79YngOqn63LPPRNQbf9xnvUcar6IGYGvXQSQxFStKnSfkMBctQ4AdwAgX9hFPwcO84xC+yIVTi/s1J5LEzAD4gdYgdHIG/qQ5oAsAAhyLYqqByhOXV2BYjHs+D73Y5SJ+Wc+eLYLoeyz5iB+NxbAjiWxbzBbOHbkAGd797bdg1IK8IXM+RuVaIx9ngLQ9DilsSm6PXb2dBRzvtmEFd9k55iHdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KXtc4ilymaXNcw+7OMufWRf/ySB6e19QGueWcv5KeU=;
 b=sAS0VMdERkCe0RZd95BEm+DKYgT4bq07I1wvcPYZXwmYu9/PikmkDrgxDi2c/gcBA96BH3OMNicXzxp5O7n/vPmNpy/hLbISJSLY2D3CZcNRFjlVnWN9tKWuonn58AX5EBD/C8gMSAt6bnuEf9UFsVDLnSmXVZDZo2O4uEU9JukZ9GyUzJO22uN2ag5utCXvZUqgzwuMgrlQVotBRuwS5xikaeAXZ20DkYQW0dSHRFmvBuULLCzBvbjBBIur8d3EW6KtO7hSgFbWALXw5SumCxM8X39GlhgAceFO6d8f8T2oTPsuSd/QE0XrdKtgm7gAuEmZUwiehFFxFaRPG+jsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA4PR11MB9081.namprd11.prod.outlook.com (2603:10b6:208:56e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 21:58:57 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 21:58:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v3 2/4] KVM: TDX: Set bits 31:16 to 0 for the synthesized
 Exit Reason
Thread-Topic: [PATCH v3 2/4] KVM: TDX: Set bits 31:16 to 0 for the synthesized
 Exit Reason
Thread-Index: AQHdKjGrpm5W50EBd06ge4piw+c7Rraa9yaA
Date: Wed, 12 Aug 2026 21:58:56 +0000
Message-ID: <789f552d37a3fb8c60b8cd1b6550f60b67b94f8c.camel@intel.com>
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
	 <20260812080229.2481439-3-xiaoyao.li@intel.com>
In-Reply-To: <20260812080229.2481439-3-xiaoyao.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA4PR11MB9081:EE_
x-ms-office365-filtering-correlation-id: c2735bad-64ab-4bfe-2084-08def8bce84e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|56012099006|11063799006|18002099003|38070700021|10067099003|4143699003;
x-microsoft-antispam-message-info: 0RGv9wuJkVU3XAbgW/ISq7Lep8qLw0NM0edhvhDd6RaKVn/yRVG1HVJV86CtDYp8Nt+HkxdknOUui5uZytxvotZQFAbgy6PrK8uKssh3jyswIDNcdP+bLZArWT9EomOHBBFCtK5inxvXIrXCxtqSxq2EHm+5uIxVEm3293hv0TCvgRfZicvUoopbKCZrTZ2DJYxcsoZ8Pyuf8zX0NrXFyA2QFtqyrHUW4m+B9VeoJRXPAzdXiO9bWyAWjvF/mMXcC3dcXeodHoFhVYFQ0Eo5tt3FD2+gXuh7exNFGRi+c7pGxMVrdDxfHCZL9sgmA8hi8omnjQWkyCRWCHU005PdcUXq2Hwxc0LdR6SujHssP/BLvSIZYWIGmFKoYZ3iXNvFRdBW2QmPIW3QJ3R0sVwO5fq7Bw477TfykVeoK0JX1yJoGGAilxSGpZ6amVS0O1Pqk3XEPvZ9WOu8sAa60Ql6VqQgt1ATVou+uyIRA9qiifQTqsN3yJJacNPYgvzOdK1qhka5H9QU3N1XNdnCm8TQ4wDTk4yqpT5gvXvMKkBWlcqr5wk9buByHVBXkHgkqebI7V8wjBAUkBJFR6j6/Uca/5b/D1ERG0heyDZJ+dswY3PYJqtoxCR6UJMdIF1Y/GjHYP1Ru82+pb9FW4+Os50IQ94kQsw0tccQPAv//6bWxoMbGdqx3GT79ZUDoamIGpdr7X7BwbEe/MsQCoagRb737XzR9JkZrKcB8k6slOOCHOQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(56012099006)(11063799006)(18002099003)(38070700021)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFNXc2NmdUppTDV4bzdXalFrcytZOFBnWHN5UlF3dnUzUjMxWisrNXd1T3ow?=
 =?utf-8?B?NUwvQlRRVDR6V3FLcGRQQXd4VzhHYkVxRmxmd04zMGw0VE9KcTdEVzRVaG5v?=
 =?utf-8?B?dUlZbEh4Um5tRDJraWl1ZFZ4L2VXYm9uK3FlWlg5MVBlQlNKa3gvMURSc3NE?=
 =?utf-8?B?UzdyWElPRzZ5Y0FpYUlYYXg0cWRZOW5IRGE2QmdwdllYandFQ0FlRzNRZEs1?=
 =?utf-8?B?aUdpSUx6YlRCVnFVS3B0cTh1TUlLN3pzSlBKSTkzcmVZS0VkcmwwU0ZoR0lC?=
 =?utf-8?B?MmtBN2pxM0tLOHlHaTQyMms0a2hMT1dlRWJuNnhSNG45Qk5QVnRldTFqaS9u?=
 =?utf-8?B?MlZVY3p1UnZ5RFNWbTVLTkJuMlpQbFNObFhESGJNNXFELzllSGZZNm9BTUFa?=
 =?utf-8?B?REEvbGlYL2ZFa0drYVJINUFPK01XbURLcEIyMWVOMCtQck40b2l0aTRhdzBy?=
 =?utf-8?B?emNnaVBmUGNvblFOZGcwWnN1QlVQOGM1S1ZTWmg4R1VacnpkY2hnOXFjV0Jk?=
 =?utf-8?B?UkZxNyt3NUFOaURjM2xYbWhuL1BKc0pxVnhmM2xQWlFrM2dCSjJkdXhTclpM?=
 =?utf-8?B?dVJ3OHdBK0swUmJFNWdjNlJJQnpUeHZGcVVZNWhYTjg0cHEyTlFadmtHdUox?=
 =?utf-8?B?TGlSZXFPdVFIK3F4Vys4QUF1ekg4bC9wZUQvc3FmTEJ6WERtQUVaaHliRmx1?=
 =?utf-8?B?Tys0NlgvMzVDc1pkODNBa2puYWxWZFNIU1FlZExDRU5IK2p1K1dvUFg5OUhI?=
 =?utf-8?B?Zk1DNTN1b1pIdzgrTno4KzdWQW1maXpmdGNsVXFHRGcxVjhadHRpV0s2eDZY?=
 =?utf-8?B?aXR1NUk3MFBhY2lhSGU3Yy9qcUJOakhETXg4OGlDeCt3T0xkZUg4cmlwQkdM?=
 =?utf-8?B?R0ppMWpiV0t1cnkvKy9uWEFSY2tBdWRMWTA4by83amtzbG1lOTcxRE02TDE0?=
 =?utf-8?B?L1lxNTNsUFZYcGJkM1p6RU8wdDhjRUN4ZHo1NEt5RlFiNExTRk5lcVVhV01U?=
 =?utf-8?B?R1BwMDNaUnBucHZvTVQ2NWY4RXoxVVF4VG4xeTdkT25DZDJ5NTA3VUJXL1pR?=
 =?utf-8?B?K2VTSWNXNG5NSzJad0VZdE42M3dScVkxQmdveUcwR05Za3Y0ZmRCMmFkOFBR?=
 =?utf-8?B?VTk1eENWOHlHenVZM1Y4SDB2MElHcWZOUUZPanZ3UWJIdmh1aHRjTDgzalZN?=
 =?utf-8?B?UUcxSXdQN1lDNytEUmZudXhRNGFON00wWGxLRDhXNEVuMURycGJ4dGVPd05T?=
 =?utf-8?B?RDEwYmRONUF6eWhMUmhqVjBvZHdrVHpaVTZ1U3JZMWlzU1Jud1VSb0Z0R3VZ?=
 =?utf-8?B?SGNSL0FsSUFoSmhZZ1V0c0E5bC9lR25VbWZRQjFUWU5vdUliZCtOQXVqdXpQ?=
 =?utf-8?B?a1VKeHFMM1RWamFoUGRHazQ3RlhkVjhJcDNQdG5yVW1OV2ZlVEg3UlRQZ05G?=
 =?utf-8?B?Nm9RWlNoVVR6WWh0WFA2WFBJNDJPZVh6Y29JZHJQNnU2SGJLaEtWVSs5SzRt?=
 =?utf-8?B?U3lFSUNEOFhhcG96T1lxcjVkcHl6d0NtQlo1cGFKMEtqd282MnZrcE1IR3N3?=
 =?utf-8?B?MkhIZlgwUFFRN3JXUnBPQ3B1cE1BQU9EY2psT2sxU0ZzNVhqT1Z2d05xbHJ0?=
 =?utf-8?B?SHBBdEJpZEJKRzlMUkRpTUV6MTcyOG1mS1JDUnpwUVVMd1ZyZjhCVm51TlFt?=
 =?utf-8?B?SGx6dzUrRlRGNDBtVTducEN6bmtCSzV1RGxSVTNzY2RnZThYTVJ1c01RVTU2?=
 =?utf-8?B?MVA0QW5zSlRTeXhCbUk1UUNuMlljcEtTS1A4bzVJcmhhWHVPUTZUUUozeHBW?=
 =?utf-8?B?b1BwN09xWnk5bWtYVlRKdjNhWEtWRElxd3B1WklwaitvS2w0T2gwWm1KRXlK?=
 =?utf-8?B?Q1dvU0JCSktIT0tyVDNqZjBiUG1YZW1ncDR0N0d6WUNvT3R2VGF6dkl5bGhx?=
 =?utf-8?B?YmF1dXFIdXVOcXFSR2lnV1J4dm5WajNUdWY3WmZiNk5xRVlsVW4zZzRnd3dn?=
 =?utf-8?B?Ly91Qy9RRS81N1BBZ1ErTG5Ibkloam96bGp0WXIrbm95RC9WNThvOWFKd1BK?=
 =?utf-8?B?cTErWlhKMzFTUGwrOVJ6bHlhRXRvNjNXNTZSVXdpd3hPN0FLQ3UxeFZKRXVZ?=
 =?utf-8?B?dGl1MWVreVNWeUFYQm1wTXBoN2JsN0RSdGJEdzFCQ3Foc2EyOUk2OFhtSnBO?=
 =?utf-8?B?TFdqeHREQ1IvYU5kNEZBaXU5czdKdHdUL1grZUplaGp4Q2RhSk5GV2oxZ3ZZ?=
 =?utf-8?B?TWZQendQMDVYdFRFZUpkQjFlR1loMFJmZXFVdWpjMUxUVEM1di9Nc0NZRjJa?=
 =?utf-8?B?anpWREdqL2d3QW1RS2o5c2M1bXJRQUxFd25ibTUxMDhhSDNVTGxhTnMrUmtP?=
 =?utf-8?Q?0q9AWVcTczMeIGHc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A31D28220B219A4BB98C8D4D060B0AB3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F5qNeIJ1xVYIcbB3thQKfmJnjGZHE29S1i4MyfmxSeUZbN0mlwg7bMQPr6EMWMTj+OW1MFUW49bGyxhrUrLyJxTg9bkH6uGWKpfpykma1R5Y3bbUk3n0dxE20Vkx5x8sTPH4ueb9bBEVti69aQm3G8ugLVVoXWqQTsDdGLn8g3qLPUdDBg+nV4MrKdZB6qLW/YqPqJsKOV/iR4UWuoElknXFsIhseLof9vLaO9PqKWHFo0cCKxjvstfMXafN+zHqafMdLBzaMAh4AVNMQ0Uit9xwPvF3CCKT1aWNZ4VBvutTDz2QGG4f/UC2t6ZdPxiDPWtIc4lXINcYgdlAOiK3sg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2735bad-64ab-4bfe-2084-08def8bce84e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 21:58:56.7669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NO4LG+Fd/mjnI1ce1O0du4ve58XxXdghIriyhd9Ou3mxE5yPA8gxT+nBKWs5kVucUKpuQbWBe9KeYQ8+3XAHmjnc8HfzXBYPQm+UyTqO/AM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9081
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDE2OjAyICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiBT
ZXQgYml0cyAzMToxNiB0byAwIGluc3RlYWQgb2YgYWxsLTFzIGZvciBLVk0ncyBzeW50aGVzaXpl
ZCBFeGl0IFJlYXNvbi4NCj4gDQo+IEtWTSBpcyBnb2luZyB0byBzdXBwb3J0IEJ1cyBMb2NrIFZN
IGV4aXQgZm9yIFREWCwgYWZ0ZXIgd2hpY2ggYml0IDI2IG9mDQo+IHRoZSBFeGl0IFJlYXNvbiBi
ZWNvbWVzIG1lYW5pbmdmdWwgYW5kIGluZGljYXRlcyB0aGF0IGEgYnVzIGxvY2sgaGFwcGVuZWQu
DQo+IFRoZSBleGlzdGluZyBzeW50aGVzaXplZCBFeGl0IFJlYXNvbiwgLTF1LCB3aWxsIGNhdXNl
IGEgZmFsc2UgcG9zaXRpdmUgaW4NCj4gdGhhdCBjYXNlLsKgIENoYW5nZSB0aGUgc3ludGhlc2l6
ZWQgRXhpdCBSZWFzb24gZnJvbSAtMXUgdG8gVTE2X01BWCwgc28gdGhhdA0KPiBiaXRzIDMxOjE2
IGFyZSBzZXQgdG8gMC7CoCBUaGlzIGFsc28gYXZvaWRzIHRoZSBwb3RlbnRpYWwgaXNzdWVzIHdo
ZW4gb3RoZXINCj4gYml0cyBpbiAzMToxNiBiZWNvbWUgdmFsaWQgaW4gdGhlIGZ1dHVyZS4NCj4g
DQo+IEFzIGEgYm9udXMsIHRoZSBjaGVjayBmb3Igc3ludGhlc2l6ZWQgRXhpdCBSZWFzb24gaW4g
dGR4X2ZhaWxlZF92bWVudHJ5KCkNCj4gYmVjb21lcyB1bm5lY2Vzc2FyeS4gRHJvcCBpdC4NCj4g
DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFhpYW95YW8g
TGkgPHhpYW95YW8ubGlAaW50ZWwuY29tPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRn
ZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg==
