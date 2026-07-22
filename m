Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623A470E8A;
	Wed, 22 Jul 2026 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747933; cv=fail; b=G1WVacid8bwZuYil247JVPuVLXiFopywOe8sRu5oX2yHLQrDWh3qP0uQMt7/70TS+TCABEES9IsTH79jbVHe2kDTUGZYfM845in4BPQ/MzA42l+WTvGAaNeGtDCfPLnS2xuKG+IH25iwbxiDIi3y8guWmICJEuIO9ft8SW9CigU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747933; c=relaxed/simple;
	bh=fIw5m//1FiOqWcorG7rGA36ZFPjd7xW/7RZ9E+fOpeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LPuAVotyHfen1vwTS/eA+z0draZshc5R7CNsdK/GH1t8jZjpbsATovcC9pnIKQVIa3mXQkq7Z2HLUnjPcqVjghEHBnn0WiSyU9jnIlAD0Fii0K80qpcjMWLtQvT5YAdo13Q3vKE8nit+1GLD/XaMK4wldwi6SCNiKG9mcRcC3iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuWT244s; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuWT244s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784747932; x=1816283932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fIw5m//1FiOqWcorG7rGA36ZFPjd7xW/7RZ9E+fOpeM=;
  b=KuWT244smwU4zdZeO5j+o7nitWCDLBRiS1y4zodtV72RGY9qHenGIPNB
   RZ3nI3xjpD+Mgtgx7ayIrEBD8jd7dDvdO7cDYTWxMy5uUmFm22Tyu6kF4
   Tc4ljhtl9E5VzCvrjGeKG01ikwYHLm7LrvIEhukrJFTKUdhLL1v41Pv2Y
   bfmyBE5L4vmI4cLws3cLMs5gVpTRHM8HuI79zCDa6AS7cIr8hrORkXhy6
   V9KmCGllSJIR80Xpcw6PslmU45d/aT3c7wHsG5PPKC3/LNu4p7MDDiyOE
   CvPISU5akIMNg1HCKH8Un8lGi7bEkggK5eSf3M6JBBuFZihyfF+Kp+uMP
   Q==;
X-CSE-ConnectionGUID: GvtAhDZtQmyLg/yS7Vz+nw==
X-CSE-MsgGUID: oojf28oSTeKaOwqIkXdnVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="110937950"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="110937950"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 12:18:51 -0700
X-CSE-ConnectionGUID: CzL/aK/CRFGuKV2plFk6dw==
X-CSE-MsgGUID: 0BOwEUtOQiOad9JbZy2JpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="262502442"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 12:18:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 12:18:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 12:18:50 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 12:18:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7H5ieUT8cCT5od0lK6qfyxyUCz1JWp+9ti4b15KPXuDgeba2Qqg44UDCpu30hLgXMbM0AYjFtJVQF98xxwDchlc9WsD1L4IvoNgLOx/mO1EJNb6VCUaB6MhZUai78xTo3IY7GMIqibAH6kQ2mxWo9U2kfukKxd3ewltXU3chh+t8iQaJcHpnjgNelPpkSN5XKKaobcY46xYW3AX1gf4kziC57R/cnEFilD/qZvpDG4p/ZgBPFdULvgnT1iG3nBQpgweBME9kEEDKFNXxtUy4tfTs7CB8+Nq4ggOVNnrOabt7y7al9R+Wb4SO64nMnsTWwvXm3KmdxhGLOuF3Oj+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIw5m//1FiOqWcorG7rGA36ZFPjd7xW/7RZ9E+fOpeM=;
 b=pc5DFEGej73tQkjCEKq91uU/rj/vyKN4NI/p4NvCfmpHrtFmLhjsuzidD0KAqsX7tF01BOlhhT+8GpGlWdpNEmqBkjwUZjDmn2u42MqoZR+EcmgfL37oz0jnqgC1UL+ycjTmgQvLtOCUElUrfi6iJv4GBeSk7hM8wgIP+QGvXbM0NXYHUcQoj+ddQ7qbf38ZZp5+IbYf68gjKTGz+bavEp7ugGMqWUo2RkHHaxAyvhUrgJZHZR1djInvZXYPkNi+ED0h+2qMNGOH60wK1qUCrYH3zvpSnP/PqP/yZRF5R7pJhz0+IRhPS7AFSJxlbB3mGe7kydLMjtxBZ9pyxdRi3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH8PR11MB7072.namprd11.prod.outlook.com (2603:10b6:510:214::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 19:18:45 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 19:18:44 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, "Wu,
 Binbin" <binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"Annapurve, Vishal" <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHdFlcgM4x/Hv8VdkeOGppLXPcVVLZyy64AgAPW3wCAAwm/AIAARNWA
Date: Wed, 22 Jul 2026 19:18:44 +0000
Message-ID: <375a07a55d4683f2564dce191b2ef66633da9876.camel@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
	 <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
	 <20260718061050.E17B01F000E9@smtp.kernel.org>
	 <1417841720b8435f8fb95ac0bd95be6e0e9390d4.camel@intel.com>
	 <amDd1Ip3XTvKSTcb@google.com>
In-Reply-To: <amDd1Ip3XTvKSTcb@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH8PR11MB7072:EE_
x-ms-office365-filtering-correlation-id: 269bfcc7-6e25-4c06-f5bb-08dee8260c33
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 5shlZBQvdZSGStgzDT0X3eHEliRaD1DZ/vpFc439BAe/tbepod/9R8jetGMXPUkuoIieDtoHDoLwDMatlD0RUULXb6fBC3G4Vf6vMpc7BXy6yHoEdzuh8cRuGq++Nucn/hCANc3UQxhO09znLBwDixkEyy8k+HQ95NdAKTZS+TS6k9EquDCzMmmxR7Wq2e/bL261FlWIqj9NRAXinC5yzzu9BKLvQMFHSQujfr5QFmPPGTYdicZUc3mI8edipy4c2//Wfw94diPysrbHamvniTMIpyyhDwsGgcM7AErMiiAm4w1En1OG2rElrlx2nk6XO8niNr0HnLoUVGAZ+Jxd6KF8yJP/pg3o9Dzu9xFD3rd6H4mSjg0PtJaSQOA7azKSUm0eC50lwXuXv/fJ3r7HhYmcyKGD7tWf5A/kzhcosea1i/355aFC/LoPjs3Di+TJUJ4XbUD2FgjYZ4PvbHunTGGJi6EatN12dPOZZpTA++N9Tr+yHBkwKxT0AQJs5bPoin1LuLQo+cR9w3xL+hA0icjYxEj4LJMdKmtFJ4qvtGU0dPZNJpJ/7AMGkYGPssrJZHydaKGKoVyam5qYI0HiTgHmpvBvXqHYe+Mx9JtzpOzolFdS+w5rUbHpxjzH4rAA8U2QAMPOgUrRAekRcn7OWsimYsavb9eoYowdDo8ndrJQm8hnX2h94yEjd36+0FAZ7uMcPR/j8lEKsrY/kN/5h+mbf1YPXE+H+1lRMoABNyg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGhQaVUzWmJjSkFJU0pGeE85VjlYdWZOYkRUK2FwdkoyVE9qUzVlMFlOYzht?=
 =?utf-8?B?a3BTeDEyaC9UdStPd05tTEZmaG5FeUJ1OEptblV5L3pyNGJUdmJwS0IyemxW?=
 =?utf-8?B?WEgvODZzNElGcEdCdG1rSXRhZmVqS2JIQjhaRFdYVkY3Z2UzdFZLa2o0TmRF?=
 =?utf-8?B?ME14OE12R014VjNYMDFWMkhGRkMyQi9NOVVhQmtRTzNvcTVqekgxeXhxZisy?=
 =?utf-8?B?c0ZDNFAraFp3VFpJUDE5bXM2YXA3TkRGMVp5ejI1dk5SSEtpVWtOWlBWR0c0?=
 =?utf-8?B?MWVSMmkrQlAyU0FIQlJLSm1takdodjRZZVZVSDRZMFpvVXlOc2NRQ2h5Z2Y3?=
 =?utf-8?B?N2ZaSCtpbEpDY3plbTlVRytNRDZubTlBWGNtWXFGeTdidlRLaTZucjNLbEN0?=
 =?utf-8?B?SWFvQ2gwWFRaWHNIRzZISHprQUF4VDA3U2FtTFIrclVsU0xLZzlkYnY0YkJS?=
 =?utf-8?B?NzBFbTVRUVVqcDM0elRiNkpuNklIV3l5UEZVcW43aWYvUmprQ1o1T3ZmK29Q?=
 =?utf-8?B?UFQrVFJhSTBsMzFoV0MzYzdDOXlKekJjOWw4U3dsSG56elhVUnFjVFZVWnAx?=
 =?utf-8?B?c2t6QlVVaEw4bE9MUmgrQUtPYXZMMlRWWTZlWnJzZjIvQkpEOHlEenFjN2h2?=
 =?utf-8?B?VUJwNVlHZC8vd0FJZ1IxU3VCQ3B4dzBFU3F0bk1wTEVGd3U3S3JtclZNSWFr?=
 =?utf-8?B?VkVhWktSTDFyaU1DbHhQMjVLMXovekQ1emg5a0tLM3dUTFZXcmJkUWlaU2Rw?=
 =?utf-8?B?VUt2TWI2bGwrM2pRZS9vdEU2bVhPUkF2RERRZTdNUEJLVlhtWHdDV3J3cUFw?=
 =?utf-8?B?Q3ArbnVzUytJbERUWnRvWE1NUHMwT3kvNVRCK0FCN0R6NUJwYkllblJpcnhp?=
 =?utf-8?B?dkpRaHNzUHBaUlBkQzlLM1RvMTlpZ0xhbmppTkZTOVRBU09MN1MyNGFzbnNl?=
 =?utf-8?B?VGdhSWh5RG5pUkxqZXVuUURlMzZlSjRuYUlRR0Zwc0JsaDdlS3k3QThLQTI4?=
 =?utf-8?B?eEl5VnJsbnFocllsem9aaGpPdVRQRTVOS2cvOG1xVjJFUVFuWWVKbDJYY3ln?=
 =?utf-8?B?LzArejBqVnhCOHBLOHY2QkFKSnd2OXJoYWgxVm5adkRMVDREeWdUb2s2T29n?=
 =?utf-8?B?N3VTSWZPb2VQQ0dJTlJnWVE3SVhKZGthRkY1UUxWZGtRODBLMmJSTlN5NE16?=
 =?utf-8?B?R01ORDRMcDRpc1JBbkJLZjkrZktzNW5jcENmcllXWWNCUnVTWmFhcHRqYW5O?=
 =?utf-8?B?Y2dYM0lMTUFTZElmNmE0T1hlNXRhUlRDamc5VGpJRlBURk5qYWZ0OStncGI5?=
 =?utf-8?B?Y0xHcGU3MXZvSkxrNlJMV3pMVll1Uk1ENUNvR2FxZmpPcXYxQWtRK0JOT2RG?=
 =?utf-8?B?cWwxeUJyVE82QnlScllRZVMwaGFEQXY5NEdWSGF0VEJxWTkvajBLL2NGMnpK?=
 =?utf-8?B?VmNUZkUxbUJFcHpzWDFPbkZkM1NkZ3ZUcHhGV0RUSkppWVJJTFdHaEwrMTJD?=
 =?utf-8?B?WVExbW1sc1JuWE0vL2hsc3JiUXhWTUlvVzF3ZDgwYmJLSVAySFBHRzJURk1h?=
 =?utf-8?B?QVZoT0wvNWZocWJEUFc3eDQrOTlPem5uSWIrVUVza1VqVUdHaDg3aFkydHdn?=
 =?utf-8?B?MjJlc0FWNmxQYjNtMjk1aS84emVVa0pwRkVBc0RtMGRTWXp6RDRrZTlLQ0tm?=
 =?utf-8?B?YnJUeXFnaHUzQWxGQndROG9kWkg1V2FsWTFGYWw5bXUwdFNWZDRpRmdqeGJm?=
 =?utf-8?B?VUprWnJXRUwzTE91NHRhMHYxd3FsNnZwbmVXb3ZwSHF6ODJtdmlBZDUzY1Vs?=
 =?utf-8?B?aUswMllmNlF4SFA3NERQeDJqODZJdGdXUTlaZHNCd3R3V1ZZUzRMS2pKZVkr?=
 =?utf-8?B?ZUpFaGh2ZEFuNkROc2pxRXUvWERCSkJnYmFGYmJJTTBxcHdxTmkxTFFlUlNz?=
 =?utf-8?B?azdPbFlrZE05UVJkSlJzZE9lc0U4ZFB0cm9KdmtMNThMWnY4SGZmdDcvMTBx?=
 =?utf-8?B?enMxaU1yOFo2VzhQMlRtRk5aQTdWQkdtYllmUWJBbVdyNXFHTTQwYksvNVA2?=
 =?utf-8?B?UkU2dVhNWEdrRW40MGRWQklEQSthSmVlTjFxd3orSUFVcGpYd1ZiZ3pvb1I4?=
 =?utf-8?B?UTlWc3lyRjd2WEFZM0RxcElUQVN4Z3VCTDdDU3BrZUhza2xtbDk3MFpPMHFH?=
 =?utf-8?B?dGsvZEtGaXFkM1B2Y3hUMEI0dE1Lc2NLenhTbnU1ZGo3U01oUkVsVWRNSTRv?=
 =?utf-8?B?R1NESW4vOHdoQk1VWmpDdHZFeHV3dmhzbUhsQlNXaklYRGJGODgrWlcvTXVP?=
 =?utf-8?B?RVJKRUM5Nis4dzNnQ1NkbnNQT2lCU3N2Kyt1MEwwbVJJSXZPREdPVWc2UFRr?=
 =?utf-8?Q?y5WoeKIgyDJ+nRoM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7419EE8E140032449A39579585A3CB5A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aduEvJBWjX15CiW0N0t63IL2nec9QiZBMs4Jx6Oa2+TVJmOj5nS8LtH6Q/vYmc5EOebcROE8lv2MZ/QSjCQJFv22d48mIsxk9zIQuzLtG+jBi//5mZv11bnvNUzBUipaD8I3Hq5LlWxd5xHGjPaw/dD7uaQvYKW89E1qDLnsg6OxuRxFCihDJXAyLOR4AoQzK3tt+PWXvuggBDC3+4PJMze0lx489jUxs30DfWzz9GoljeuxED68LAyYl6q4vbTPJuGogjPGCUwW5GKyEgB1LE/IJmMTZdfleVy9L5PK5TiYRjdYXJeDAIXTtjQ9EL9Tnkda0AkRN28HHJ7LuKkxGg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269bfcc7-6e25-4c06-f5bb-08dee8260c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 19:18:44.3444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Tzj57eMzAHluNB21GR/3/G1I0R8NuZqvBggDcbF9ePWRviwHrgxsgdWFjp9NGzAq7bdpN0SpiS80PZkr9w8WQwVG9ev6LVSeUDwiOKBaog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7072
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDA4OjEyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+ID4gPiArCXJldCA9IHRkeF9wYW10X2dldChwYWdlX3RvX3BmbihzZXB0X3B0KSwg
JnRvX3RkeCh2Y3B1KS0NCj4gPiA+ID4gPnBhbXRfY2FjaGUpOw0KPiA+ID4gPiArCWlmIChyZXQp
DQo+IA0KPiBTaG91bGRuJ3QgdGhpcyBiZSBhIEtWTV9CVUdfT04oKT/CoCBUbyBTYXNoaWtvJ3Mg
cG9pbnQgYWJvdXQgdGhpcyBjcmVhdGluZyBhbg0KPiBpbmZpbml0ZSBmYXVsdCBsb29wLCB0aGF0
IHNpbXBseSBzaG91bGRuJ3QgaGFwcGVuLsKgIFRoZSB3aG9sZSBwb2ludCBvZiB1c2luZw0KPiBj
YWNoZXMgZm9yIHRoZSBwYWdpbmcgYXNzZXRzIGlzIHRvIGd1YXJhbnRlZSBzdWNjZXNzLg0KDQpN
aXNzZWQgdGhpcyBvbmUgdGhlIGZpcnN0IHRpbWUuIFllcyBpdCBkb2VzIHNlZW0gbGlrZSBhIGdv
b2QgS1ZNX0JVR19PTigpIGNhc2UuDQpJJ2xsIHVwZGF0ZSBpdC4NCg==
