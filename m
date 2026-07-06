Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4583DE439;
	Mon,  6 Jul 2026 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369675; cv=fail; b=btc/Rwi0EXKiupUJ+qIEC+0b2ukI9K4dK5vhX6HfnRzUpk2rLDK57DWnRVY8hhuen8VmvJOifQ8w5IwGllXfPwUHEq+qPb+VBP2Cp90wIv7rOwMx2uprGmT1evsiDLBPsV48s8jNtWQxq5YeLhrSgLHGj9zvdMozvcYIVM6VSdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369675; c=relaxed/simple;
	bh=JIYiUUl/qdQQ9MNlrcIEaqNBI+2TSsk7NGPh+WyKZ8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jmfWqazdSKeIe6X1gzuohS1JMEoxwJAhIR6B7m5H8RJ4JEBy9mNdnwNtrDUer2O08YkgLFBdk0UNWYmMbP7REdt2DIyBlVF4coAIrUbdJWKFrSpaz9W6oPw32uPAtNIQYvDG5ZEHVF29SxxFkKTSrEfctVexu2mXRkZrME4TG78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jR/gphHP; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jR/gphHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783369673; x=1814905673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JIYiUUl/qdQQ9MNlrcIEaqNBI+2TSsk7NGPh+WyKZ8A=;
  b=jR/gphHPg6oh+uEVAgFma9i0VBC08+hqqB0D0PVAP2RL7hz7EgJAvcB1
   ve8sQ5xFmUbhfThQyhn4k8ROVgv7zCSjGHVbwWwe4OieziTWDogHwlGwc
   Q7bKjEDFe01uNPVHT9dBo6CqESt5gyGz8asb7vLk+xMFiXcg7BsyXuokG
   O6iFN/99lEom/gOGK4XVl8U3jgXoz++hddrwvYXBVffCJu6Lh93LaQIS4
   Y7/DJ1uAVy2NQEWtnVBJYTsoqizxOWpDaL34vZtXt8wkXud1ImcpLMhiL
   ll2sK1zkSTSly2AlGHsEuRmYwaQH00d8uv68Ai1AfdOcj4ElKXjYsBZap
   A==;
X-CSE-ConnectionGUID: SC+VHj8WRXe5fwj+Mc8dbg==
X-CSE-MsgGUID: qPeShtFLSN6XynGs/bq6KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83883810"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83883810"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:27:52 -0700
X-CSE-ConnectionGUID: 1dWG4FnfQf+dVkM+wDv2Yg==
X-CSE-MsgGUID: ErsOUzRxS5C20Hj9F5d+lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="258125832"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:27:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:27:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 13:27:52 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:27:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTZzWoCYdr9r1X1KapSqfd3D97dV2LcIsrEbSnXFSOUGnoBJhowk2olKIOSuw5tcQWLeCyDzpFBUpYg+d5Y0a5BOUhOwR1hvP4GvINCG1ecqg2BVgrEJk7aXmrBzZQzVcGxDBZUhc7+tsw6g6wT06nVO1jBWW+9wIfNQFv9D6p3FqfjbdO6Zxu8yJrYYR5JFdr6ZFFVuXRMR8ym0v87TUjKPFPztIJoYG9KnBgxHJkYt30PcIJIUjZLcrWT5e3oIVg9YL0VD1PIgWrOWJeKsr0+k+JqY7unqDhS7BQ7YJepHg7hQs788Ip7EYV+JCkCuKKgNnO59DhpHs/bc58AFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIYiUUl/qdQQ9MNlrcIEaqNBI+2TSsk7NGPh+WyKZ8A=;
 b=TiwwOgDeYwTY9kCdWBoirNgMqC0QOGYnCTfwu94B0hfTnNqaJSxDPzycyxZsSSwWwSlmoX1AyaG37Lv/O1rdCFCwXiN2wAREkfcvDVAu+iRdAZM4TiNzbd3CkQrgxayz7ePeY1SiupD/p9VAbZjL6vZy5mGDiAJdo0qR+/BuiBkY2SWQsxD9Gz3c/IuVhwaB2al3xOYpoHhRojwabI84zI7T750W255n4hRPe/RWJRov7hwfOrT7KcEPkufkINgRsbmKN0p0cQAymiUpZ45uRAxTCsGWe2VzxQh/oR5X3tzvCMVA9zS+0K9gLJYqlxFS3Zd2Exz9Z+Kz2PiRbPUAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 20:27:43 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 20:27:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Thread-Topic: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Thread-Index: AQHc7LhXfoCfkuUFmkqKqK55gbUxZLZaEl0AgAcf/AA=
Date: Mon, 6 Jul 2026 20:27:43 +0000
Message-ID: <078769dca47fccf0655531e3c339ed08caa1fe8b.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-6-rick.p.edgecombe@intel.com>
	 <1694d6c2-2aaa-4277-ba83-97c4a3007417@linux.intel.com>
In-Reply-To: <1694d6c2-2aaa-4277-ba83-97c4a3007417@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY8PR11MB7947:EE_
x-ms-office365-filtering-correlation-id: a092e165-ec6d-499e-6ce2-08dedb9d08ce
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|38070700021|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: pStJ/6MVaGyVQBGzMxyJaLOqxWcodZTR9agS4AE3/jxlDWsYpTsQ8MWOKMyvBwoaiR6G1lRgdIcP9GdEvmSMwLKI+jOo+gojMkH9JsjswpO/zAlqG21iCGSWFVbts41Olg39Tq6a+LIvwCtRgz7z4WEdWI0zrYpxyAJIbjjq5B79KOXXnLke1TRyPBQnaTCh841q1rbHBra6ZQWwEfJV2lX0QD2O0RgdlljxG+iT5g5Dy2AlYHMZ4pyvEQV+ZAVS8wZvYSI+0zZelAD6aBmmVQXwCBqQSgDSivK16H5pA4tNrILpS4JJaz/gq49ZGmBEk8XtY88vSJh+ry18A/XnbKO2efrj6O78EZHdm6QK9uE2lAWgfzh0Fgwgnn75+ZsfXeM3Cholsj/PuTS+0dzsX0Zo1Ocw+8teoTue+JkacnoFdFUZgg56grHCZSV9PDASSr/rEhK5EoIdMEP9ptzzA2Jsb8dRypAWUOYJFslxYBLHaFgAFlS+qPOYevpnLyUQOCpuzc2nP+H7aUcSpcCrVJwH4kmkE9OuuOMgqu+NryKBPDUr9LlNNsFnhr/d4eVE4qNmIif75sXNuuqiznew8czzQoyZUbDcrKXRjAJXuw8WK9d0jZUT13Sh9krT9NL5xnCNXU1z16dFzBv1doXTYhNhNC4Rt9bxx+7ZjMDtf14UTT9fhr5aZ5Hi6L0oY38P0FE8yLEJM4MR2W5iR7J9Ue5HVSYEPKjHNLQN9BrcWUI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUNqMVlQQWVka043c0dqNC9pNWVIMk5ZL0gyREZ4UDR4cGU1TDY1ajdNQXhr?=
 =?utf-8?B?cmdkaHNYeGE5WktocVByeXM5bUc3OFd2Uzh0WjAvVTcvVVZTRUZOZkJiU0c4?=
 =?utf-8?B?M241bkMrdDdBaGVYT3dGTkZrc0RaMGdUZ3l6V1JRVXY5dWwzUTFId3hwMkFp?=
 =?utf-8?B?WmNRVlVUZHN1aTFlZ3RRVzVOSjJ0RXN6RjRFZURvR3JGWUtvTlVHUFIvV0li?=
 =?utf-8?B?N1o2bmR0bXUzbWhtVHQ5dzlQL2F3Nnk5bWVHck5UNmNyZ2ZQODZpdDFKakR2?=
 =?utf-8?B?ZWV4RnorTEJmNDJIWVNYQWRUWjNwcmRBN0REZ3Mxb1FOWFR4N2liV214UGpY?=
 =?utf-8?B?aHNIQ1F1UWVlc3poV1BuS25qZEFHdHVyTTBPL3NIOWQyNlhJUUp4bnA5Zjgr?=
 =?utf-8?B?SEZkRDJlL1p2aFJlR3RrVkt5WlovanFhYTYwVEYydm10RnFsaHIzMXhyNkJi?=
 =?utf-8?B?eWNpbENIRVJqUFpLaGl5OWp1STJvMHVsVHZ1OVRmQ2RkQ2hqOW5RTTIyeEk4?=
 =?utf-8?B?dE82cHhzaEhwWmdUWXo5RmwzemVHWm9ObTNPQjJSUFBVcjVZOGpBMFZzRW9i?=
 =?utf-8?B?VU9OUkxGbE9kMVRtdzZLRjJSOXNLS0YzR3JWbFZvcWQ1bVMwQU9ZZjJWZEVi?=
 =?utf-8?B?ZnEwcmw3VnRaZXdxTUVyM0Y1UGtUb3lMZGs3QWlTQXZDMkxZanBxWGhOaVlj?=
 =?utf-8?B?YnpGRFN4RDZkTXVWYjhwaWl5UHdaWVg4R2dXK1d3YjdITEM1ZXZCN1pnNjVx?=
 =?utf-8?B?dzRnZDNrbEQyNzRNM0RONDZxZW8xd2xFMGlBMXMxNVhNaGN2MGw2OEJNdjh5?=
 =?utf-8?B?OU16VjJhaG5jdXFhckV4bWtoQk05OWpVVHk0aHBMckI1Q04yeHZRVWc3anZH?=
 =?utf-8?B?c1lJTFhqL2JxOWdWSHBrV1ByRFlFdW5Kc0pjbURWOWk5Mm9XY2EyRDdMK3Ns?=
 =?utf-8?B?WGpvZlVoMDBKUnRDYUlZeERvZTRna3BmYVlzYXFCUHFFZ0p2bVdzblNoMVg4?=
 =?utf-8?B?K0NTMGZOOUY3NVRtajQ4RkorTU9KbXZob1Zyc1d4QUdzV0QyaFJvUS91UUQ2?=
 =?utf-8?B?MzduMTM2U3RFRTIwNkRJT1J2VDh4N1ZwMGhTY3VzV3h3TituZlhwN2pxSURw?=
 =?utf-8?B?aE5iQ3F5U0lEcjI3M0l1eHAwZTRUUm5kM2FBSzh5YzFWYnF5ZUZzdUZOZWJQ?=
 =?utf-8?B?OXNRTjBhbG1BRFJnQzVraVJwT3daUGNsQTRTS3p3MWtlUWhDMDNOdzBMNnZO?=
 =?utf-8?B?REswUk50LzB1TjhDN0ppckJvcm1iMkNlRUU3c0l1NGRaKzZuSzVRaHlwUVla?=
 =?utf-8?B?LzNTenRCaWIvRmZJa2l3NGVJdGFIM1N1ckhzL2pRSDI1NUthMkV6TDYrM3Jv?=
 =?utf-8?B?Q1VUUm5XeE5kYTNkcGRFYkdxelFNZEg1Z2FaRHc2VHhNNmxTVDVNRHhiYmU0?=
 =?utf-8?B?andScm5naUJoL3VFYmxRZWFQbUhRczhtc2E0NFgrenNaQTRzV2RZNTRVYUZG?=
 =?utf-8?B?L2dsUU82TVBzWndtU0ZCSUlqcUQ2QzAwbzF4cmVPb05IbW5VWWpSUGdyOGNn?=
 =?utf-8?B?Zjl6M3VyakRhMWtsOVo4VWdIS2FXRU5mNkxOQm1NRHhlZCt0V1UyRmwrN1A3?=
 =?utf-8?B?QUc5ci9hZDRDRVJob3JPL3pjbTV3YXFqa1FVS3ZuRzlac051ZFhFekE0V0k1?=
 =?utf-8?B?a2tPeWViZmdyODFBZHk0QUtBLzBIckdUeWZTSW1US2p4cExMNjJjKzllYUZh?=
 =?utf-8?B?WUV4NW1obTE1WnF5M1ZBSmhlK2N6aFhlV3BTTjZLbWFJYVh1YkZDR3BOWk9n?=
 =?utf-8?B?czZzZ0NvTGZRNnNEbm5XVDdmcjFlbU53bmFnMUM3ZFhGbVc2M0N3RmhTVkM5?=
 =?utf-8?B?N1k2cmZCWTNHRitWeEZCTWpvVk5LVDNoVjEvcnJuVEc1MG9ITGxIaFhWMXB2?=
 =?utf-8?B?bHA5TXJXSXBOSTZuTU5tak8vSll1bGVUMFcxTlFDNzVmb0N2dHNqNUVCMEdq?=
 =?utf-8?B?SDRMWTY1R29pMjM1aWFuS0hWbkNBN2NkWE1zQ1ZXSGgrUXd0bTNLem1iNWov?=
 =?utf-8?B?MnhlRks1T0hkSjJzQ1liK1RjODVZM3BaZmNQdFF2MVgzdmJlZXppVnRMWnpq?=
 =?utf-8?B?THFSbG1heUh4TmpRNHgrZ2QvS1I5VHpZc0lLQmZwY0NyRGErQkYzTk1PZmNJ?=
 =?utf-8?B?eTlZSE1MbkdpemFGMGkvWm1yWmJuWGttdmk5bnZybDU0dGh1cjJrd2tQVVBo?=
 =?utf-8?B?c0ZMUWRJeC9UUCsrQlFKeE81WmxnYkVZL0hQYnN4aSsrY295bkdWR2hrc081?=
 =?utf-8?B?MGdBUnlwbmUvMTVNZnhjeThPWWI0MDg0UTAvdkxGR3JhUC9jVzlPYkgvUUpy?=
 =?utf-8?Q?fB5pNq82azbc5dQ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5740F6B33FB49479A78DFF733299B0A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fJZ8dxO46jnsbfPVyQzfDH2clEFWp2rGjVhCQ5mCUIXv4e/ZAhPD0TmtKdNHYJdU3qcFzsIqyDtOKBHc9104Vz57V/nb3LJ1qC1ZY0pVrWp404wxw5KQ5o2kYf8eLNrcRNIxPawguVyi49dRaxquPSmS4s0dsB+rm782uE/g8m9B4CCP7+FqPgdKUMikYkkL0QPeXZm3oXSxfPnbNBFryVEy7W+p8uxem/jfpnZTaBwKZtkY8m3t6z9sxPJwq3HeV/RKPVMti3BaL7YttueSl5um1Zk343OKCxsQbp+CGLzp57ee0pjysjsDIS83kOmKO6mhNfuHFH9YGZqCQakqNw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a092e165-ec6d-499e-6ce2-08dedb9d08ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 20:27:43.6213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MInYmYD8AxTV9lvPA3I39u3NVolV5Qqz49d0x7GxPxLimldipg/p+2asfoOn1AbBA7V6qvkytQGBt7y3g1SxXY4JQNjmK+iXrAflctZZBvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA3LTAyIGF0IDE1OjM5ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IE9u
IDUvMjYvMjAyNiAxMDozNSBBTSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gRnJvbTogIktp
cmlsbCBBLiBTaHV0ZW1vdiIgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+ID4g
DQo+ID4gdGR4X3BhbXRfZ2V0KCkvdGR4X3BhbXRfcHV0KCkgdW5jb25kaXRpb25hbGx5IGFkZCBv
ciByZW1vdmUgRHluYW1pYyBQQU1UDQo+ID4gYmFja2luZyBmb3IgdGhlIDJNQiByZWdpb24gY292
ZXJpbmcgdGhlIHBhc3NlZCBwZm4uIEhvd2V2ZXIsIG11bHRpcGxlDQo+ID4gY2FsbGVycyBjYW4g
Y29uY3VycmVudGx5IG9wZXJhdGUgb24gNEtCIHBhZ2VzIHRoYXQgZmFsbCB3aXRoaW4gdGhlIHNh
bWUNCj4gPiAyTUIgcmVnaW9uLiBXaGVuIHRoaXMgaGFwcGVucyBvbmx5IG9uZSBEeW5hbWljIFBB
TVQgcGFnZSBwYWlyIG5lZWRzIHRvIGJlDQo+ID4gaW5zdGFsbGVkIHRvIGNvdmVyIHRoZSAyTUIg
cmFuZ2UuIEFuZCB3aGVuIG9uZSBwYWdlIGlzIGZyZWVkLCB0aGUgRHluYW1pYw0KPiA+IFBBTVQg
YmFja2luZyBjYW5ub3QgYmUgZnJlZWQgdW50aWwgYWxsIHBhZ2VzIGluIHRoZSByYW5nZSBhcmUg
bm8gbG9uZ2VyIGluDQo+ID4gdXNlLiBNYWtlIHRoZSBoZWxwZXJzIGhhbmRsZSB0aGVzZSByYWNl
cyBpbnRlcm5hbGx5Lg0KPiA+IA0KPiA+IFVzZSB0aGUgcGVyLTJNQiByZWZjb3VudHMgZnJvbSBw
cmV2aW91cyBjaGFuZ2VzIHRvIHRyYWNrIGhvdyBtYW55IDRLQg0KPiA+IHBhZ2VzIGFyZSBpbiB1
c2Ugd2l0aGluIGVhY2ggcmVnaW9uLiBHYXRlIHRoZSBhY3R1YWwgRHluYW1pYyBQQU1UIGFkZCBh
bmQNCj4gPiByZW1vdmUgb24gcmVmY291bnQgdHJhbnNpdGlvbnMgKDAtPjEgYW5kIDEtPjApLiBT
ZXJpYWxpemUgdGhlIHJlZmNvdW50DQo+ID4gY2hlY2sgYW5kIFNFQU1DQUxMIHdpdGggYSBnbG9i
YWwgc3BpbmxvY2sgc28gdGhlIHJlYWQtZGVjaWRlLWFjdCBzZXF1ZW5jZQ0KPiA+IGlzIGF0b21p
Yy4gVGhpcyBhbHNvIGF2b2lkcyBURFggbW9kdWxlIEJVU1kgZXJyb3JzLCBhcyBEeW5hbWljIFBB
TVQgYWRkDQo+ID4gYW5kIHJlbW92ZSBTRUFNQ0FMTHMgdGFrZSBhbiBpbnRlcm5hbCBURFggbW9k
dWxlIGxvY2tzIGF0IDJNQiBncmFudWxhcml0eSwNCj4gPiBzbyBzaW11bHRhbmVvdXMgYXR0ZW1w
dHMgb24gdGhlIHNhbWUgcmVnaW9uIHdvdWxkIGNvbmZsaWN0Lg0KPiA+IA0KPiA+IFRoZSBsb2Nr
IGlzIGdsb2JhbCBhbmQgaGVhdnl3ZWlnaHQuIFVzZSBzaW1wbGUgY29uZGl0aW9uYWwgbG9naWMg
dG8ga2VlcA0KPiA+IGNvcnJlY3RuZXNzIG9idmlvdXMuIFRoaXMgd2lsbCBiZSBvcHRpbWl6ZWQg
aW4gYSBsYXRlciBjaGFuZ2UuDQo+ID4gDQo+ID4gQXNzaXN0ZWQtYnk6IEdpdEh1YiBDb3BpbG90
OmNsYXVkZS1vcHVzLTQtNiBDbGF1ZGU6Y2xhdWRlLW9wdXMtNC03DQo+ID4gU2lnbmVkLW9mZi1i
eTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0K
PiA+IENvLWRldmVsb3BlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50
ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNv
bWJlQGludGVsLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBCaW5iaW4gV3UgPGJpbmJpbi53dUBs
aW51eC5pbnRlbC5jb20+DQo+IA0KPiBPbmUgbml0IGJlbG93Lg0KPiANCj4gWy4uLl0NCj4gDQo+
ID4gwqAgDQo+ID4gQEAgLTIwNTcsMTAgKzIwNjEsMjYgQEAgc3RhdGljIGludCB0ZHhfcGFtdF9n
ZXQoa3ZtX3Bmbl90IHBmbikNCj4gPiDCoMKgCWlmIChyZXQpDQo+ID4gwqDCoAkJcmV0dXJuIHJl
dDsNCj4gPiDCoCANCj4gPiAtCXRkeF9zdGF0dXMgPSB0ZGhfcGh5bWVtX3BhbXRfYWRkKHBmbiwg
cGFtdF9wYWdlcyk7DQo+ID4gLQlpZiAodGR4X3N0YXR1cyAhPSBURFhfU1VDQ0VTUykgew0KPiA+
IC0JCXJldCA9IC1FSU87DQo+ID4gLQkJZ290byBvdXRfZnJlZTsNCj4gPiArCXBhbXRfcmVmY291
bnQgPSB0ZHhfZmluZF9wYW10X3JlZmNvdW50KHBmbik7DQo+IA0KPiB0ZHhfZmluZF9wYW10X3Jl
ZmNvdW50KCkgaXMgdGFnZ2VkIGFzIF9fbWF5YmVfdW51c2VkIGluIHRoZSBwcmV2aW91cyBwYXRj
aC4NCj4gSSB0aGluayB0aGUgdGFnIHNob3VsZCBiZSByZW1vdmVkLg0KDQpPaCB5ZWEsIHRoYXQg
d2FzIHRoZSBpbnRlbnRpb24uIFdpbGwgZml4Lg0K
