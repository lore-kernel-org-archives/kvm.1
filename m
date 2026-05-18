Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178C3803C5;
	Mon, 18 May 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127276; cv=fail; b=AujsHLhDzTwL8c1SCe4gCMkCjOz//0/3jEBcZLMMZr7/7XscMRxGYD0yGP1JutSxDmMHQLzrzD+EgTej11XuyAlSm6mpoJ5F+CVbGhlqikt6kzxLQ9311fv7v7b0RehRsLnbdzVwXC+95CqtqzW+r1P4Ot6hCMqM1ZCrrdOB/8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127276; c=relaxed/simple;
	bh=WTG+5Fg2vhu4a5C1oEEMeiMGW7QSv6ueITNaymnAkmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E0evlzrOtWiB2JYfHMsth4zCb8ObjLRJOF6jJSd70xM7+Llxeazs6MrKmGMo3ZdxCP9w1ynyuAk4QG8+JYXhHxgFidAHb5LSbGAfTDmhzveWqGT9IlXE93i7N1LqZdV4hlYfJ67+sDfkCqxg5fRH/PPOTet0P/DRhykBBoQhKt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxyVJRtu; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxyVJRtu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779127274; x=1810663274;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WTG+5Fg2vhu4a5C1oEEMeiMGW7QSv6ueITNaymnAkmg=;
  b=UxyVJRtui/7dPVER7aS3jGbDN9DK+hc888cAn4tKfnghg5bYCmrAmTB+
   KjPebyV844ZehyCQmr8pshDUg+vuv3QDumpapgA6sHud2+wD+EIR3jCuE
   2YsONRD2Kms5NGKnyMeNjoQjbv9zaJr+AE3NMoNaBPWQA8H0JqxgnC26i
   Wk5U9ZweU2O7lY2CExytwRvnzaHA/Jn6ZcB5IIwwsUbrSmneDejCfcdLa
   EaLTokH6pA/yz9ZZKeO3+en3r6VLss2v9Vep3iVzb5w1cOiSxqSnOMSdF
   azVuauNAChS+bHyIfUNUfHnSXXdQs+tJn2JKMWfv4pKj/33vA4OMJNy23
   w==;
X-CSE-ConnectionGUID: T1zyKG2kRjyGZAQQsChO5A==
X-CSE-MsgGUID: ZVCYrHOVScqssp0VOoe52w==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79890458"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="79890458"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 11:01:14 -0700
X-CSE-ConnectionGUID: eiiuSX8yRBS7xk+jKHg59w==
X-CSE-MsgGUID: aZpaRpgMTQCi3tabpQ3Sjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="269849213"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 11:01:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 11:01:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 11:01:06 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.69)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 11:01:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0IHgdSGGBV1Mr3YGHs1ZCW9Dut9V0nEB4jgeT6OxYsIAATsDw4z06nj7auWp4xeoRebNO+KOJF2vZM/vLkFnUoXfZ8BTyH9jaeHH9E0p2ZRYHhPlPWDwIl70pY65/h6NrCl1i/6IK/2welqAzgkAQQl3k/9r/v8rBuEfKq7iNkU7lqnTkhvzqsqdhHw0Vc2dGZ4x05NvFxLbXGjWabO1I7acGvibJ6eJRTWUxJbIVbhOHz0unBKmbj15BtSl2XLvKev5WZrbJ9XnEgmqvZKz7KnqpwY2HOrf6JIcwRdxNF82rdw71HoF0TwmCN62fH6XFu8ls8OQY1yrXjP+PMtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTG+5Fg2vhu4a5C1oEEMeiMGW7QSv6ueITNaymnAkmg=;
 b=NCg84JZ5bqkxtx9IDeA8gQITeuHifyYCXNyepZf+zYMqWzJ26hQRQx2pgX+yIi4QeAf5jiKF4cBUKfZK3hUmVUd+FQ4H6Aw5ftdQfG3SchytsEUrub/e4ieT9Ankp/HnHh2doEM9iQZMeTtW9VZL+I9iZCHd79qKNY6DpgpbBg46wzr35ap+93F+JFhefJPANrniB9wBHS0sFEDPTPWRtbTCNyjxvRtgfUdrx8B8/Iz7SkXXxxR2OKioLnl6+T10XIjgzNsYlOM6vcbKgOvkC4F0izSlJeH48salWP180zXXD6t0y4lSWLnAW1crZdrlI635TYdOHyeTwaZFW5gtlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BL3PR11MB6412.namprd11.prod.outlook.com (2603:10b6:208:3bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 18:00:59 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 18:00:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Gao, Chao" <chao.gao@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "kas@kernel.org" <kas@kernel.org>, "Shahar, Sagi"
	<sagis@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 01/23] x86/virt/tdx: Consolidate TDX global
 initialization states
Thread-Topic: [PATCH v9 01/23] x86/virt/tdx: Consolidate TDX global
 initialization states
Thread-Index: AQHc4urR+HXZxTFlKUG6K/WDNjK4+7YPRdoAgAQoWYCAAKyFgA==
Date: Mon, 18 May 2026 18:00:58 +0000
Message-ID: <f6e9a736d15ec41d23156c8e4e75533e8debf908.camel@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
	 <20260513151045.1420990-2-chao.gao@intel.com>
	 <ab35e6e4-b57a-4d49-8521-ca69a9135d3c@intel.com>
	 <agrDIa/foXa2PhCh@intel.com>
In-Reply-To: <agrDIa/foXa2PhCh@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BL3PR11MB6412:EE_
x-ms-office365-filtering-correlation-id: f529ed16-aebb-4c92-da17-08deb5076a72
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|4143699003|11063799003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: N2sU1pCJxtCHflPm43VU00dZWV/RLaPfhSh4MusRGYyspDiORSVrFtoFgBqhU1qtXfYBaHQlBa5dE5vQpIHWdzsHfLoKn7wHKkh2IW/AI6pSAdu9eUVVVsQLMCcn0ZJhV2CUAADwdCel9B8lvHcGa4Ch5BM8KSpnSM9gEWChWZZLepEQA0O/16zLy3MmUn4w65HBhj1xmwaffbLJy4JYZ24fyns1ujILvWrzpTp+FB9qvBU6Ud+uR8r7sQsEvAMEJ7/NXck4IchpPQXkDg4yOjxL9xs+ouG1Mim1dpqyVMk9dMqBnqkb9QdTKbLztguMMGVZrkz/hwxs3B56VwPX8fsPc88VAH8RegbbLqMytrD66BlpeY9FvB25753N6cH8jRlFuToU4lOqirVw0INwBNha0LuCp0m1IQ9/9dyYsY3rmWkwBNeWJXxUlTqqdt8w8kXdfyAhmwleOCGQTQ/gGKFJWY0TfhF3FmBSZHWgpMoxZPcg67l+mye1Eonkv3LtIHTmXoZUdF1JmnCkMyl3rxg1K0J37NOLDLcJItoiz59X/efPL5YPuUcovef9DqPK8gFu+dJZrR5ITx2lw4BxGCWbQIRpg+yhof4ApYmGdMRBJElvqf35DIrW9iL1wvCGVdXyS/w2ZxcD442UQlJjXHCIBfWS9nW9wZPepRm47B+CSKrPZps8eQH7HpybYYUwY5DyeQ2YC0E+/R5kTy0W2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(4143699003)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2xuQTlwZmQ3cmZVWTkrUXdvV0s0THpBY2cyaXdNZzV4eTJSdHZOZjVxNlJz?=
 =?utf-8?B?b2pWNm9XTU9oa3prMXpxQ2pEY1duYTY1aFo1RzhDUmg4REVWdWZyTjhZSDdI?=
 =?utf-8?B?Yk5VdkJFTmNybldGeEhKNGJNaUJsYnpNSVg1MW5rWitFQ3hhY21WOUNjQ0JL?=
 =?utf-8?B?WkpUR1hqd3E3b3FDSG9Tazdyd1FMbG8wZk9lQU5iOHN4TU9XY1FPUVhkaSs0?=
 =?utf-8?B?VGx3MzRWUGRWMU5DREtpMXM1YllrUDRRN0NUaG5lMUxRTlEvamJoV0pzc3NU?=
 =?utf-8?B?cG9xNVB4aWE1YmMzTldKRm5zbmlwckFEa2tyaGVuQ1RnR3JmN3hEbUwxMkdz?=
 =?utf-8?B?ZjFNL1k3SkdKT2NTRExSNjVQS3d0TFZiZkd0M25oV3I5WWxyRk5TcUgvRjZN?=
 =?utf-8?B?NC9DUkh1dUJ4SlY2NktXSFcrSHV2eVZFTEJNbVNyamt2UmxCRDU5N1BVQXVI?=
 =?utf-8?B?cms1VHBUb05YM2U5T2llUWZJT1duQllmenU4c1VJdFBuSkJTeWJoU2ZtT3ht?=
 =?utf-8?B?ZjhEeGtxZWdpRS9samJKVlpRR3FtU3lqWHRPa3g4U1lpTFpkaEV6YzFIdWZ3?=
 =?utf-8?B?ekloeHZoSkhmd1lCc3IrZlZxM1BTOFRGNE4rTFA1WGRqdUJidlRFQml1NW5n?=
 =?utf-8?B?bW0xa01EWHdUWmVvM1FObzMxR2YyQ3FQOEk0OWtyTFl0Y0ZWSnNEMzJTTStm?=
 =?utf-8?B?blBXa1I4bmF6QmpOQzN2T2l5TkpMdjZhZ29XcGpUc0ZlaE9wVUJLdzRtcGxp?=
 =?utf-8?B?ZHpCNUNPSEwydUhjTnZhWEZNampsUnJHbWRoSFBwVFg5ais1QTQ0a0FpQU9J?=
 =?utf-8?B?Wm1xWUE1Z09MVWRYODRtR0pDbmhoOVo1OHY1ZVFLZ051RS9sQzg1elBjVFNv?=
 =?utf-8?B?UW50QVBVeGNaZkFMeHdKa3ZYeFJsK3JSVUorUlR2Mm53TTg5SUhwODZOWmZx?=
 =?utf-8?B?R1ROTkQ1dzluZlM3Slk0MTNYV1cvQ2ZQSDkzNmFWM2E3TzRibHRpdC9wbXlF?=
 =?utf-8?B?MFNiY09zMWE4VUFJKy9iTzlzWXFaVTJYM1dUMFVTNk14cndhejk4ZlVvVGNM?=
 =?utf-8?B?dW0vbVNrdm5GU3JHekRBZmRLUU1qRkpPT0dJQld5K2FTS3k5SDJQWlEwNlNZ?=
 =?utf-8?B?Y2hRRkhPZVBHRzJCSGJzZW9Db2ZueHJkcDVCZGc1MmRzeS9yUDhXaUhJNHVX?=
 =?utf-8?B?M0F3eWhSMy93R29HWHBpZXpUVDRWT05qMDVObkZ3SXR3c2ZZK1huWHVnSjJs?=
 =?utf-8?B?azh2OVYreVFNWmgwQnJoeDl6dTdLQVpPQ040UFY3QlhoRjg5UFUzbzlwamFR?=
 =?utf-8?B?YmRyQmgwYjROM1VTQnV3UXN3Z3Zrdm5IY01XZ0w4OUVCenJZL2RISkoxckxW?=
 =?utf-8?B?dnh1ck5mQWgrYlNpYzN5UmJHL01MRGdRczRHSThnVXg3NDk1MCtlRUpzQWhz?=
 =?utf-8?B?NmRiR1BNUFlJcGJhMHZhZnJLOFNLWStML2d0cDVLQXdiSEN5ekpRQzhaVE54?=
 =?utf-8?B?eGNseVhqK2RhMHNjL3h0NnU0b1FPd1lMdHJMRkpaMXQ2anNyY0xVVXJpeFN2?=
 =?utf-8?B?RzNHdDNvMys5OW9FNVpMYWU0aFBLWDhtR0I3OGZhc0h5ZU1TZVozUnhaSlVh?=
 =?utf-8?B?VkhHYUxaTHcyNUJ4eHVzWlkyQVg2SnVtS1J0QVVlc3hEa2haVG1aYkR4bFdD?=
 =?utf-8?B?NFdsSzd6aThEMjdOOWhCSElnbG9tcCtwbWttRHBiVmc1TDNKWkIyb0oxejJT?=
 =?utf-8?B?bzQ3bmFEdEozb05EbGZER2Vjck03bmtSMGxZMFNVR2RYbThmVHJKMlpqd2ZZ?=
 =?utf-8?B?MHd4QmIxVFFtQ04zVFJ5TCsrYVg2eVJWblk2eDJHZ0lta1lodzRDcklCSWVE?=
 =?utf-8?B?cDRSQWt5VmF0MVVkbzJ5Y0dVZElna1p4UEdSUnhoSWtSa3VUTWwwKzRQWEZy?=
 =?utf-8?B?MW50OWhpKzJEYzRXcnJxZEpoeVNjNkk1aWNoaHl5UVpmOEZzZE5PVGhJUko1?=
 =?utf-8?B?KzFLNmh2QUVtZW4yZTI3YUhDWnBDaSt0Skx3WVo1M0ZzVThLUWpQbi81L3FY?=
 =?utf-8?B?THA0SkhqMEJ0bG55eU5DeUNjY01LWHFOR1lpU2JRNkw1Z2h2SlRwMlZRTmhG?=
 =?utf-8?B?RW5sanRVa2NUTHRpOHhFdGw2cml0aFFSUEMyeFZZVkRCSndNRE9KanpiTzBm?=
 =?utf-8?B?T01ST25wYXpYNS9RSjdSWHAzRnA5WkZmTzdLb05ueWNrUFpJK1JQRmVheHRr?=
 =?utf-8?B?SjN3SmU2OVFtWHZ1dDRIbWVKV2NqTXhEWS91ZWI2WmJZdnhlQWRsZGNYb2Iy?=
 =?utf-8?B?eW5uZEJEbHhOTGpYYzdwaWNXbXIrZzIvKy9ieDFzMDREVy9IZ3JPZEN1alF6?=
 =?utf-8?Q?5pl+S/ihhz79aTnM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDE612854A6A4E48A21AF7C339A2B212@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GZfmClNmHshabzDaSdw2cTeEnKJeiUXODfbamYEJH/uUEHEO+Z8SrktSarqrnh+as1b3XfsBAaVpB4ZR/RpC0GEvJUXdOpY2agm/173/+gHyhA9g04r0uLbyH6tzwaF4r6GQMioERO/1NcHyWOrCP+xTnQglgKmvlBmraZ/3p6T3IKJN9bWdSjeSjO2Un+5/yVTwEdPF9W+819b4zRF6++tN0IOJO6NSdZIGD9kD/LUCErWnJ83un2huDorCF9kSmDAlexo3q0xkgKqCgX2D4fzr8njXwaHEyzKabzXc3SVGkVpJJmpt/pANG55B1SIvK6geVbC5XNacziYEw78LWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f529ed16-aebb-4c92-da17-08deb5076a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 18:00:58.7782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0eUPA/Md1fYNpII1r+Z8ACQ/+8LCNlFBGWcxJjyApTR8/EYR1xqDBheMuJf1AFl70s1W3FB0GwE7IZsF8o15uWzb1L0yv9fqey0fdXBoGJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6412
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA1LTE4IGF0IDE1OjQzICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gY29t
bWl0IDI2YmIzODljNTc2MmZkNmE0OTZmYmVkMWNjNTVlNDk3OGU5OWE1Y2INCj4gQXV0aG9yOiBD
aGFvIEdhbyA8Y2hhby5nYW9AaW50ZWwuY29tPg0KPiBEYXRlOsKgwqAgU3VuIE1heSAxNyAyMDow
MzowMCAyMDI2IC0wNzAwDQo+IA0KPiDCoMKgwqAgeDg2L3ZpcnQvdGR4OiBDbGFyaWZ5IHRyeV9p
bml0X21vZHVsZV9nbG9iYWwoKSByZXN1bHQgY2FjaGluZw0KPiDCoMKgwqAgDQo+IMKgwqDCoCBU
RFggbW9kdWxlIGdsb2JhbCBpbml0aWFsaXphdGlvbiBpcyBleGVjdXRlZCBvbmx5IG9uY2UuIFRo
ZSBmaXJzdCBjYWxsDQo+IMKgwqDCoCBjYWNoZXMgYm90aCB0aGUgcmVzdWx0IGFuZCB0aGUgImRv
bmUiIHN0YXRlLCBhbmQgbGF0ZXIgY2FsbGVycyByZXVzZSB0aGUNCj4gwqDCoMKgIHNhdmVkIHJl
c3VsdC4gQSBsb2NrIHByb3RlY3RzIHRoYXQgY2FjaGVkIHN0YXRlLg0KPiDCoMKgwqAgDQo+IMKg
wqDCoCBUaGUgY3VycmVudCBjb2RlIGlzIGhhcmRlciB0byByZWFkIGJlY2F1c2Ugc3lzaW5pdF9k
b25lIGlzIGFjY2Vzc2VkIHVuZGVyDQogICAgICAgICAgICAgICAgICAgICAgICAgIF4gaGFyZGVy
IHRoZW4gd2hhdD8gTWF5YmUganVzdCAiaGFyZCINCj4gwqDCoMKgIHRoZSBsb2NrLCB3aGlsZSBz
eXNpbml0X3JldCBpcyBub3QuDQo+IMKgwqDCoCANCj4gwqDCoMKgIFRvIGltcHJvdmUgcmVhZGFi
aWxpdHksIG1vdmUgc3lzaW5pdF9yZXQgYWNjZXNzZXMgd2l0aGluIHRoZSBsb2NrLg0KPiDCoMKg
wqAgDQo+IMKgwqDCoCBHcm91cCBzeXNpbml0X3JldC9zeXNpbml0X2RvbmUgdXBkYXRlcyByaWdo
dCBhZnRlciBpbml0aWFsaXphdGlvbiBzbw0KPiDCoMKgwqAgQ2FjaGluZyB0aGUgcmVzdWx0IGlz
IHNlcGFyYXRlIGZyb20gdGhlIGluaXRpYWxpemF0aW9uIGl0c2VsZi4NCj4gwqDCoMKgIA0KPiDC
oMKgwqAgU2lnbmVkLW9mZi1ieTogQ2hhbyBHYW8gPGNoYW8uZ2FvQGludGVsLmNvbT4NCg0KVGhp
cyBpcyBhIGdyZWF0IGltcHJvdmVtZW50IGJ5IGl0c2VsZiwgaXJyZXNwZWN0aXZlIG9mIHRoaXMg
c2VyaWVzLiBUaGUgb3JpZ2luYWwNCmNvZGUgbWFkZSBteSBoZWFkIGh1cnQgd2hlbiBJIGZpcnN0
IHNhdyBpdDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC83MjZkY2NkNmQ0NmQwYmQ0NzFl
YzBiMmY2ODYxZjhlNDViYWRlMjZjLmNhbWVsQGludGVsLmNvbS8NCg0KVGhlIGhhbmRsaW5nIG9m
IHRoaW5ncyBvdXRzaWRlIHRoZSBsb2NrIGlzIG9uZSB0aGluZywgYnV0IGFsc28gdGhlIGZ1bmN0
aW9uDQpzY29wZXMgc3RhdGljcyBzdG9vZCBvdXQgdG8gbWUgYXMgc3RyYW5nZS4gU28geWVhLCBt
YXliZSB0d28gcGF0Y2hlcywgdGhpcyBvbmUNCmFuZCBhbm90aGVyIHRvIGdldCByaWQgb2YgdGhl
IGZ1bmN0aW9uIHNjb3BlZCBzdGF0aWNzPw0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
dmlydC92bXgvdGR4L3RkeC5jIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+IGluZGV4
IGMwYzYyODFiMDhhNS4uYWQ1NmYxNDJkZDBiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni92aXJ0
L3ZteC90ZHgvdGR4LmMNCj4gKysrIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+IEBA
IC0xMTUsMjggKzExNSwzNCBAQCBzdGF0aWMgaW50IHRyeV9pbml0X21vZHVsZV9nbG9iYWwodm9p
ZCkNCj4gCXN0YXRpYyBERUZJTkVfUkFXX1NQSU5MT0NLKHN5c2luaXRfbG9jayk7DQo+IAlzdGF0
aWMgYm9vbCBzeXNpbml0X2RvbmU7DQo+IAlzdGF0aWMgaW50IHN5c2luaXRfcmV0Ow0KPiArCWlu
dCByZXQ7DQo+IMKgDQo+IAlyYXdfc3Bpbl9sb2NrKCZzeXNpbml0X2xvY2spOw0KPiDCoA0KPiAt
CWlmIChzeXNpbml0X2RvbmUpDQo+ICsJLyogUmV0dXJuIHRoZSAiY2FjaGVkIiByZXR1cm4gY29k
ZS4gKi8NCj4gKwlpZiAoc3lzaW5pdF9kb25lKSB7DQo+ICsJCXJldCA9IHN5c2luaXRfcmV0Ow0K
PiAJCWdvdG8gb3V0Ow0KPiArCX0NCj4gwqANCj4gCS8qIFJDWCBpcyBtb2R1bGUgYXR0cmlidXRl
cyBhbmQgYWxsIGJpdHMgYXJlIHJlc2VydmVkICovDQo+IAlhcmdzLnJjeCA9IDA7DQo+IC0Jc3lz
aW5pdF9yZXQgPSBzZWFtY2FsbF9wcmVycihUREhfU1lTX0lOSVQsICZhcmdzKTsNCj4gKwlyZXQg
PSBzZWFtY2FsbF9wcmVycihUREhfU1lTX0lOSVQsICZhcmdzKTsNCj4gwqANCj4gCS8qDQo+IAkg
KiBUaGUgZmlyc3QgU0VBTUNBTEwgYWxzbyBkZXRlY3RzIHRoZSBURFggbW9kdWxlLCB0aHVzDQo+
IAkgKiBpdCBjYW4gZmFpbCBkdWUgdG8gdGhlIFREWCBtb2R1bGUgaXMgbm90IGxvYWRlZC4NCj4g
CSAqIER1bXAgbWVzc2FnZSB0byBsZXQgdGhlIHVzZXIga25vdy4NCj4gCSAqLw0KPiAtCWlmIChz
eXNpbml0X3JldCA9PSAtRU5PREVWKQ0KPiArCWlmIChyZXQgPT0gLUVOT0RFVikNCj4gCQlwcl9l
cnIoIm1vZHVsZSBub3QgbG9hZGVkXG4iKTsNCj4gwqANCj4gKwkvKiBTYXZlIHRoZSByZXR1cm4g
Y29kZSBmb3IgbGF0ZXIgY2FsbGVycy4gKi8NCj4gCXN5c2luaXRfZG9uZSA9IHRydWU7DQo+ICsJ
c3lzaW5pdF9yZXQgPSByZXQ7DQo+IMKgb3V0Og0KPiAJcmF3X3NwaW5fdW5sb2NrKCZzeXNpbml0
X2xvY2spOw0KPiAtCXJldHVybiBzeXNpbml0X3JldDsNCj4gKwlyZXR1cm4gcmV0Ow0KPiDCoH0N
Cg0K
