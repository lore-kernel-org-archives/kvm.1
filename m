Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD40F3C3BED;
	Mon, 13 Apr 2026 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082748; cv=fail; b=saDMBXEmaywdyIOXUVEWmISxkTf51CVYmJvLYiLNyurzeZ3x2YKTZhSFIjG7YNkKWolSebyimrfe+pqxFg2wKETGUfpiaP2IvmQU9N66vSmVqyDvVzIdPMS12xURBIEMJaxWXryWdJ4AKV0zDhe/+pEtqSGwEsOPn0FrLsht0LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082748; c=relaxed/simple;
	bh=mPKinvR0L4GzynP/NVDDG9PhiUPQoXUBbe4HDOEXWu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RWJnDbIQeTmYA6mjh04BWK1ZH4r4gBVp+frZM6D508JUZYk+SLpTPn24ky3ru9AGp8C4CC07/SF2thlbPcns/nNnRJEvl2onzb5IUzeSaEvjsYaJJ6yStwe0oz7VzbcuE7rfOYHVP/j2JVt9nRSof8r4tXCiVyO5lsyB8rGJhHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhWKm8TB; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhWKm8TB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776082746; x=1807618746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mPKinvR0L4GzynP/NVDDG9PhiUPQoXUBbe4HDOEXWu8=;
  b=GhWKm8TBqWQWTV7CUZtpjjqFH02BjRvc9qXdao4o9Kcl40FOgezJdlEL
   WFcLZekKLMCfUEqBgUI8U1Mk0KOtBfGLM5xRCxy1RVqEiXTTbmYT0vkuk
   +SrQ5unCsew2WY+YrNINEOaKa0bgdvRqk5NUBq6QkJ1PT/pkKBlQYhcKX
   AWR23WOuinkKzI9hKU4K8//V9SLBhSzXyYbQOomkxpGpWa0o5vXKMVTv3
   bb45iQMQa2/YhLOh7o1bAsogCIG6BGFUAgOZSS6/4A7CvPXW8VVW7KFKe
   mFzib5D/6tA/37E7gyPuhvTXCMAaNOtvEEcmiePwA/XNQhJhtDszs8bIw
   Q==;
X-CSE-ConnectionGUID: DRiVBAi7RTuCS8HXvLV6aA==
X-CSE-MsgGUID: gJPd9unvR+i9yuqGyVFtjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76181726"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="76181726"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 05:19:05 -0700
X-CSE-ConnectionGUID: vkLudi1DTWWvCvhB9rIe3Q==
X-CSE-MsgGUID: lLjYY4vjQvGCUBbLdE/hTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="260207745"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 05:19:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 05:19:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 05:19:04 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 05:19:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9uz5lYeH1vaYNE65zk0Y34c/wp3/VTj74C79vvEuhiHM5OrRTTXPmeXxHpMbpOTBwq2vL4LS+rbbganB+NcO19NEn6jVDm/mWUvYZyODH309UQxt9+jHHq8aaxcZaIPnaMtv8wJJCo3twjFaYgKApNuUZLv9BGQRNQzpXHdzpOXE9ulksdSc72nHF5jXf6/Ki5dF/7VkvalfCFvq38hNH8ihCJmtsncew7tMDKpUK1c7EJ0At+9mDiU9a+oASOE3Vq9FwMIFH5dszhOOr9eGs+2I++eBbZup9mXva/cKJZY6KS7+X2jnHl1Yys99uT0P8MqTppo3PwrGgoS4Vjfbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPKinvR0L4GzynP/NVDDG9PhiUPQoXUBbe4HDOEXWu8=;
 b=Iar4igHtK81hQT6Z9v7vC6dvlEn30dXG1dkJtGT6c8mFMGEUjBo5Oa2tYSXXdpFt3a1jX4iI/zsLP9pg1pigb7HyPKiDRVMfnS+X5l7byLr+zBJkYtWf63r02i7Yw/UmTg6VeZNg6VkKW4uUrM1DyL7ywxAWvnamQ0FEPqu3BwHJKZcYvKCsSzgEfa2TlH6/dL9pk9toqTU7vihzuH3mCTdxpuMaI5FuFDmxZ3ItjkPmtr6lpnQix2qUQGYdkMEVTDY18VH96NfRj5YN5bqP7GNI3Anuk5SUl+60V4dViZ+zS7aA7ZRkhbGxZUTpgDtUq3gSJjfzf1ngvh0cKovSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 MW4PR11MB5871.namprd11.prod.outlook.com (2603:10b6:303:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.47; Mon, 13 Apr
 2026 12:19:02 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 12:19:02 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH 04/11] KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode
Thread-Topic: [PATCH 04/11] KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode
Thread-Index: AQHcyHyrzjYXYTlHnEikxTOUo3JIB7Xc7m2A
Date: Mon, 13 Apr 2026 12:19:01 +0000
Message-ID: <dea50f27311d88dcb09ea98261ca280853396a42.camel@intel.com>
References: <20260409235622.2052730-1-seanjc@google.com>
	 <20260409235622.2052730-5-seanjc@google.com>
In-Reply-To: <20260409235622.2052730-5-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|MW4PR11MB5871:EE_
x-ms-office365-filtering-correlation-id: d4e5f2fa-6d2e-471e-1744-08de9956d911
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: H32OJfDwUjqX9d8wgU2vdXmpMemBKOz2A50v7bOic+Ff/MSS/bPZkgg0/qVDQIVO8vcJdN2L0W7bhR77gEeU8HBBnicFNRTmut24Rs4KnuJ2iO44qWwWasBv3G8m8Bw+mhUxuWczim9yFepxvx4iEi8wf/rt7bk3n1jdQVFyhGlucrDPl369WmduBaxZbXO1Lbbg4oBIUrT+zxhm5NWHCzsKQbz7AcUimt2NmE2A96zeQkXilzWhmSLv+dcXl7a6n2qS7FxtYPhFU8iBODVeE1FfWm2IR0CD5C8WV3sISgwbHL/fyiBSRUZyXbJ1sCO7CSxIw9FiX9FFbXq0KFOLRAop4Dd2mX2Uyncxm8KSSRWFCFdGK54ZqHdbucO9RtHJVVWrWxVYcCeoM7e0worRNNJ9PETEG8wMXk4+MVrLnE4VVe2FPqgiFocFPbIgiynH94GcI8CqplHqE0XKmWIFGEP7xYAOB8c2Aja6d9bQcTFMYRMc2JgjH+9gTtcoNzMlVhRiYbhjvOfJjqljklFTHhm3dRGVBS9YPucI25ttn//ODwctgJUUeMuF8mrDVnTMBvWN0UwX5ctMofRo5yoE+rTx+53n4JcwuusRKWUXbycDySKzFcLtthm3LesgxuRkmh1FLc5ZZWugZn14o/TzGI7V1OSoaO2ev0Uo/sEjI/x3TLtOLmat8dkDwvCg8PEg8y/GzBDS2Vshl2uVGz6EcTP3y7LPAtJE7qteA5QIKUmYjkhdMFACTia14eCBohnaz8XZC+a/9cC3DzvuHJeib+Xr2kHnWIvu9yv4iaI+kXA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW1TNll3WXFVRDZRZXJhVkNMYkJrWUhRM2dFQmprZ0NBVVJVOUpqcEw1NklX?=
 =?utf-8?B?ekRPaEtLdUViWUp0bkRsN2tJRlhadWE3ZjdQR1RHNUx3ekE1eVdQeG9UdkVY?=
 =?utf-8?B?NWliSi84NlFJTUQ4blZtcFJ0bkFhNnp2K2g0c2Npb2JyTmdPMWJ5MDN2TmVh?=
 =?utf-8?B?SmIxMWJJWEIvSkpnUmRWamtlbDkyVldGUnY2UVBwNkpiSm9Zb0dsMVFJQkRI?=
 =?utf-8?B?ZmlWYUJZV09nOWs5cTlQN1UwRDdpZlFBZjg3ZWpQTVNMbUFGcXBvbEh0TjFm?=
 =?utf-8?B?UEJhbjdhSXFXZnptTGh1bnNWc0FLcm1VVnJ5NTZIeGR6RVhOMTRZMXAzWEl6?=
 =?utf-8?B?MmIvMW1KbzFqQU1pVmpLcXhySzcyVExCcEVLQ2MyeW1ITzFiOHNNS2xPYUli?=
 =?utf-8?B?eDBIYW9vaTBHakF3dUh2allON29CRFgxUmZvTWs0UnEzanlyRlUxWm5DYVd3?=
 =?utf-8?B?SjBGdTU3L3pxNmcrUTZxbE1CNVBUK09MamFCeTZ5eW1KMkdjRFhCaWw4b3pl?=
 =?utf-8?B?QWh1SVRmWUxzaTJDTVZaS0RUOGViZmVwYUtIMFAxSjZwRzNBaUtaQkFMNnZJ?=
 =?utf-8?B?Z2t1RTNDWGttZCtZcVBTdm81V2o5aitWUWZ0NlhkNktaNERnSE9XMjFwMU9V?=
 =?utf-8?B?aUlkMFkwaW0rbHp1WEcvVk9jL2xXdGdqRExNSUd1VXh5MGk0YUV4VUIyM1dk?=
 =?utf-8?B?SjA3NlV6b3Z1ZmhSTms2Vk50QW5PNHJYcFU2NVZla3VxNUdiaEwvcW8rQXRM?=
 =?utf-8?B?OGZsdDhsbHIvNHlXRVllNUpMS0hkTlhXZzQrNzk3ejkzMFQvNWpHVVlqN2NN?=
 =?utf-8?B?Sk5qb0xzTlZiUk1tTVRzVEtwTUVTMStDVzg4YXhpbTNnSGZFeitUWnBORUFL?=
 =?utf-8?B?bUFRLzFUY1pmZFQ2UGhSejFzOHVtSmphWWF2OHU2RE8rL0NRaXRxUnB6UVVm?=
 =?utf-8?B?SzBwNjByY3pxZGNubjhSK0JNU014UUNQNDA1bzRab0kwejVxMlRLWGRJd0xW?=
 =?utf-8?B?Qk9MS0pFTXhSZEhYRWxHU2MwN0t4Mm1IQlhUaWY5NXdaMTRzREVkY3R6L0dm?=
 =?utf-8?B?d00weEJBVGtQTGxJRXNQL2FOcUsrRDA5RlJQbkNQRTlVMDVmL254MzNHaVZy?=
 =?utf-8?B?azJGbi96akl5MFhvMWF4c3N6dGF3QVd0UmdxeFFWSGNVVG1rWGxCOTRNcWdx?=
 =?utf-8?B?d0tweGVIamdnSzQ5ajNzT3V1Q3d3QU5iekJGRFpmaCtjMFlncERhSXZpeUt2?=
 =?utf-8?B?bWwvbjdQN0xCdS9CRDBNM0ZPWkdrMDhuNG16bzlLTzlSaGVzVG4vbW9NYUhs?=
 =?utf-8?B?R08yRUFOcDdQK1ljaWVWVEM2YWZwZnNGeUY1OWVvU3htbGY0cmp2WHVkenk3?=
 =?utf-8?B?cG4wMytMNzdiSUtGTFA0bDYxTmtzNWs1bkFnMWV5dUQyQkNxRnAvcEtvM0tF?=
 =?utf-8?B?L2R1czhBQnN5Q0R5Q1RlbDhsNVhlUkNMUkM0d0tsUHRUenMvUVpTZE1EcXRt?=
 =?utf-8?B?c2llSTFDejNuSXpBSkh1T2JNM0lsbFU0NFFQeXlpVHlYUmRJRFQxSXhjeU5H?=
 =?utf-8?B?RTh5ZEMwS1pySkxZd3RUT2RjditjSytPaEZQeU1HNFQ3c3k2dFdjaE1rWW50?=
 =?utf-8?B?VU1QUExRcWIxK1NwelNQbW9PT1BBZ2NxRGx2eWRkaEZzcnljNWs5eGdIc2lF?=
 =?utf-8?B?N1RnWVlYMytwRm96b0IrcXp5ell5eFRCeUtCb0d0Mm5zZnlQZFhMbkhsTGNm?=
 =?utf-8?B?dTlsdXc2TEZ4aktsRFZnczI0YWRmY0ZYZ3p1Q3pUSzZENmhOd0lnK0ZvVEcz?=
 =?utf-8?B?Zm1VQW5EdXFjSFFJd3VlNTNUbkd0Vk0wQmlxeGl0Sk9zM2M2YjFqWGtGckRT?=
 =?utf-8?B?bGYxTkNtYnhyd0VyMFpCZmw2KzFEbE5pVEJGMXNHbUd1Q3FhdHYwZVFROEdB?=
 =?utf-8?B?UnpYc0U1bTVkYllnTWIzTkpEU1VYbnBGRE16QlEzNXBXVFJNb1BHODRoL3Zq?=
 =?utf-8?B?UklTOFFWYWY5MlBmbXNJZUlKZ3Z5cTRsU3NJUXFXeGxaa3cxci8yTEFXZWV3?=
 =?utf-8?B?OWc3L3RUcEIwWGhyaDVLeTFndm5XRnF5b1p2SW9EWkV4TDZObUZpOXRsbzNw?=
 =?utf-8?B?Ykl5VVlKN2NYSjNqZEV2eDB0ZFRtd0dqa3NJY2VGbFJOSkYrMyttTUI1TkNQ?=
 =?utf-8?B?cjUxZnpKU1ZjMEozRnZTMUZOWklBTW1Yd0tybFQxeXFPMnVobUppQ2tSb0ZB?=
 =?utf-8?B?VlplbDBLZTJzKzhvMGgvR2JXc3VHeWxaUnJlcjBTV25SaVEwSVBSaGpXQjBi?=
 =?utf-8?B?TzBTdU1FYVlaQWQzSUY5dEROK0tNdG55enJuMWVFenRSMGZIRnRldz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D638BE56B604D64CA2E357D5914D0F73@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UF3iB2m0jFhdP19dfEWoAHf16/NeeHI63nz15F8ts9O+can/V/9cvPtVzikameiWO59q0C6dCrtD6NgUtmzBw0vmEN/KwnO7sxQWzHgyzcd5JT+DhdPqIkaYBqDXs64bqh5Qja7uQzJ4C0vjdc63pQ8AKyEGrYwIlkIooCWR54jTeX4LD4F+TaAS3QDe7zrD44EQXw6SH9XpOIetxlMhaF/om9QWdBwoOmkbrur7dEthFgXQ693Tm+oNGVkNMwLolEfepWoZ8wVuhpYxEp+ZOvEPjr8vc39+2RAkLIVbj24pKmNw4SZL8WZk11KM5ImHYUpcnqiTvdD6vBRZXaiEtQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e5f2fa-6d2e-471e-1744-08de9956d911
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 12:19:02.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qI1dS0GKmoWJJ5CPaze8bI0E7AC8Iki+tk02FPVYICdJHx3gIxsgMIlLjdLhQyLvz1cqRHihUa82gMGv3SH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5871
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTA5IGF0IDE2OjU2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBXaGVuIGdldHRpbmcgcmVnaXN0ZXIgdmFsdWVzIGZvciBFTkNMUyBlbXVsYXRpb24s
IHVzZSBrdm1fcmVnaXN0ZXJfcmVhZCgpDQo+IGluc3RlYWQgb2Yga3ZtXzxyZWc+X3JlYWQoKSBz
byB0aGF0IGJpdHMgNjM6MzIgb2YgdGhlIHJlZ2lzdGVyIGFyZSBkcm9wcGVkDQo+IGlmIHRoZSBn
dWVzdCBpcyBpbiAzMi1iaXQgbW9kZS4NCj4gDQo+IE5vdGUsIHRoZSBtaXNsZWFkaW5nL3N1cnBy
aXNpbmcgYmVoYXZpb3Igb2Yga3ZtXzxyZWc+X3JlYWQoKSBiZWluZyAicmF3Ig0KPiB2YXJpYW50
cyB1bmRlciB0aGUgaG9vZCB3aWxsIGJlIGFkZHJlc3NlZCBvbmNlIGFsbCBub24tYmVuaWduIGJ1
Z3MgYXJlDQo+IGZpeGVkLg0KPiANCj4gRml4ZXM6IDcwMjEwYzA0NGI0ZSAoIktWTTogVk1YOiBB
ZGQgU0dYIEVOQ0xTW0VDUkVBVEVdIGhhbmRsZXIgdG8gZW5mb3JjZSBDUFVJRCByZXN0cmljdGlv
bnMiKQ0KPiBGaXhlczogYjZmMDg0Y2E1NTM4ICgiS1ZNOiBWTVg6IEFkZCBFTkNMU1tFSU5JVF0g
aGFuZGxlciB0byBzdXBwb3J0IFNHWCBMYXVuY2ggQ29udHJvbCAoTEMpIikNCj4gU2lnbmVkLW9m
Zi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAg
YXJjaC94ODYva3ZtL3ZteC9zZ3guYyB8IDEwICsrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva3ZtL3ZteC9zZ3guYyBiL2FyY2gveDg2L2t2bS92bXgvc2d4LmMNCj4gaW5kZXggZGYx
ZDBjZjc2OTQ3Li40YzYxZmMzM2Y3NjQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2t2bS92bXgv
c2d4LmMNCj4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC9zZ3guYw0KPiBAQCAtMjI1LDggKzIyNSw4
IEBAIHN0YXRpYyBpbnQgaGFuZGxlX2VuY2xzX2VjcmVhdGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1
KQ0KPiAgCXN0cnVjdCB4ODZfZXhjZXB0aW9uIGV4Ow0KPiAgCWludCByOw0KPiAgDQo+IC0JaWYg
KHNneF9nZXRfZW5jbHNfZ3ZhKHZjcHUsIGt2bV9yYnhfcmVhZCh2Y3B1KSwgMzIsIDMyLCAmcGFn
ZWluZm9fZ3ZhKSB8fA0KPiAtCSAgICBzZ3hfZ2V0X2VuY2xzX2d2YSh2Y3B1LCBrdm1fcmN4X3Jl
YWQodmNwdSksIDQwOTYsIDQwOTYsICZzZWNzX2d2YSkpDQo+ICsJaWYgKHNneF9nZXRfZW5jbHNf
Z3ZhKHZjcHUsIGt2bV9yZWdpc3Rlcl9yZWFkKHZjcHUsIFZDUFVfUkVHU19SQlgpLCAzMiwgMzIs
ICZwYWdlaW5mb19ndmEpIHx8DQo+ICsJICAgIHNneF9nZXRfZW5jbHNfZ3ZhKHZjcHUsIGt2bV9y
ZWdpc3Rlcl9yZWFkKHZjcHUsIFZDUFVfUkVHU19SQ1gpLCA0MDk2LCA0MDk2LCAmc2Vjc19ndmEp
KQ0KPiAgCQlyZXR1cm4gMTsNCj4gIA0KPiAgCS8qDQo+IEBAIC0zMDIsOSArMzAyLDkgQEAgc3Rh
dGljIGludCBoYW5kbGVfZW5jbHNfZWluaXQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiAgCWdw
YV90IHNpZ19ncGEsIHNlY3NfZ3BhLCB0b2tlbl9ncGE7DQo+ICAJaW50IHJldCwgdHJhcG5yOw0K
PiAgDQo+IC0JaWYgKHNneF9nZXRfZW5jbHNfZ3ZhKHZjcHUsIGt2bV9yYnhfcmVhZCh2Y3B1KSwg
MTgwOCwgNDA5NiwgJnNpZ19ndmEpIHx8DQo+IC0JICAgIHNneF9nZXRfZW5jbHNfZ3ZhKHZjcHUs
IGt2bV9yY3hfcmVhZCh2Y3B1KSwgNDA5NiwgNDA5NiwgJnNlY3NfZ3ZhKSB8fA0KPiAtCSAgICBz
Z3hfZ2V0X2VuY2xzX2d2YSh2Y3B1LCBrdm1fcmR4X3JlYWQodmNwdSksIDMwNCwgNTEyLCAmdG9r
ZW5fZ3ZhKSkNCj4gKwlpZiAoc2d4X2dldF9lbmNsc19ndmEodmNwdSwga3ZtX3JlZ2lzdGVyX3Jl
YWQodmNwdSwgVkNQVV9SRUdTX1JCWCksIDE4MDgsIDQwOTYsICZzaWdfZ3ZhKSB8fA0KPiArCSAg
ICBzZ3hfZ2V0X2VuY2xzX2d2YSh2Y3B1LCBrdm1fcmVnaXN0ZXJfcmVhZCh2Y3B1LCBWQ1BVX1JF
R1NfUkNYKSwgNDA5NiwgNDA5NiwgJnNlY3NfZ3ZhKSB8fA0KPiArCSAgICBzZ3hfZ2V0X2VuY2xz
X2d2YSh2Y3B1LCBrdm1fcmVnaXN0ZXJfcmVhZCh2Y3B1LCBWQ1BVX1JFR1NfUkRYKSwgMzA0LCA1
MTIsICZ0b2tlbl9ndmEpKQ0KPiAgCQlyZXR1cm4gMTsNCj4gDQoNCklzIHRoZXJlIGFueSBjYXNl
IHdoZXJlIGJpdHMgNjM6MzIgY2FuIGhhdmUgbm9uLXplcm8gdmFsdWU/DQoNCklmIHZDUFUgaXMg
aW4gMzItYml0IG1vZGUgdGhlbiBpdCBzaG91bGQgbm90IGJlIGFibGUgdG8gYWNjZXNzIDY0LWJp
dCBHUFI/DQo=
