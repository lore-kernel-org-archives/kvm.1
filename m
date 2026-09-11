Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D081DC198;
	Fri, 11 Sep 2026 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085743; cv=fail; b=szrBIGVP/be6tBUmeO9d3YEk39Xf3SnJX2kpNL1JwNch1sY8kn9HyA3AQfPnYow/UDrbwF82NXHNhfHrVtZL63J3mVe0ZmgAPoW1ECZc47vX+hul38oRU0LKTjF88vK0bBFGQLt+y9N0ZsbJCioMcpvxjiQCEi3LlMgRwGUTMzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085743; c=relaxed/simple;
	bh=Y8w4s86pB+UTgolYYfcu6kjBB+z1wwzuJhoukZZ33pI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jui3dMYunjZ05X0vWwwjKZL8Lgwc0F2988wgN4ARc4ssJQRdMS7Kiw20y6ukgjP6pcqLBLVdK3h1VLQom+AzuqGr8i2Xp4vaFTEr1TIdGXUelChLAg+NkywJLTCEbRoP4Y2Tgt8HuWa4u8T2WYpt8UfmexQbOygQWKrn8f+PDxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGt6B2fj; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGt6B2fj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789085741; x=1820621741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y8w4s86pB+UTgolYYfcu6kjBB+z1wwzuJhoukZZ33pI=;
  b=ZGt6B2fjL+8EmWE3wott6h0ckfvKGtDxYCejyvEr/wv2tOkyBOuEBpIe
   c/i549Mfjpi264MXCWohcpF+i7Bo1e8+CICwdcQutoiogAJFNqtHFukhx
   EEysO6bP7oU4c01h+zu+VKEP3bvdFD0JN2MImVoYatd55hEwbLGLl9t07
   Lna1Tg7Dkz24BhsRsbWCXMZn/PpsOOEf+aWG8qLf32VMlI4Dpj2oWD6I6
   Xyk5B/tM3ydJqdStU45vmkTBVgQJvGZRG6+Z5VeKELhFubzWjbekfJYxL
   +GS4rkNpfW8+4XRCXpZbfch5GNStXVaC7qIO5rZH9zpYaAywmBH1W8J1y
   Q==;
X-CSE-ConnectionGUID: J/oqWCPcRduBV0itNVU4fg==
X-CSE-MsgGUID: zFxqPeo9SCeNBGGQ6cUY2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="92059927"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="92059927"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:15:40 -0700
X-CSE-ConnectionGUID: 3vbfGZa1QP2MUx5k+h9ROA==
X-CSE-MsgGUID: f2gWeVmSS6+SWHym0UxkYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="273717228"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:15:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 17:15:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 17:15:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 17:15:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ukgm4NFID9OuHWbbJcZgt+AGcPOQAv34x/Pkkrx64ATiWWQRRKH532kSTgLtkkfAaq4/ejyt+bNVBj+VFysDqDa0juS426C0cvpFvZNpqS4mrXY2LC9W0Lb32Blq35umFIN+RbEh+9ecu8xPxPum41RBtkB2jpn8DTuloUl8vZo+cubAhbEBOP4o5Rc0p8aLi6lklX/IYIPidS1qvMM/tbarDYJp3Ndr5/e/W42FNohn9YkuG4B6wC3tXv+t5Hw2sFZTyqJl1yVSSJJKfxjhtEiw6BtbETRH/9NeVmF1Fgc/s9sKkcfHm57ip5RBlQBKsZL/knX+3w3TMpXncrCqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8w4s86pB+UTgolYYfcu6kjBB+z1wwzuJhoukZZ33pI=;
 b=cx8D8dZN/8d78kJ2gl1UejfIC+Aj5pO1zdEYAdMYRKilHGX6o9hxIWe9SLvaLpsIsqt4ltlC5rWewzaiwClXO509N77VNd4rHYb3+ApHF2Lvp7kPSqdkojwYaOdanbTmKy9AWmmwD2BcQa2d/PoiiJJH2zu0nuax5OSCnel7niR+xQaYtEWm8qc2PB8ZtZ50HB1LNQnjyIZIZx7ZpG3fmjdJSRsE0QqK5xpMMzVxw+VZXEYJLeikEqB0YkjZcLR7mBhysw5d/wHqmdj5qc+D3WdLkjZl7krrgZnp9MhqbBamdSzah9Nh8kgj3/MQMaXtThAVezXGOovXQM9zkSqBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7121.namprd11.prod.outlook.com (2603:10b6:510:20c::7)
 by CH3PR11MB7914.namprd11.prod.outlook.com (2603:10b6:610:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 00:15:32 +0000
Received: from PH7PR11MB7121.namprd11.prod.outlook.com
 ([fe80::6b9c:c109:a0a8:2997]) by PH7PR11MB7121.namprd11.prod.outlook.com
 ([fe80::6b9c:c109:a0a8:2997%5]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 00:15:32 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "kas@kernel.org" <kas@kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>
Subject: Re: [PATCH] x86/tdx: Remove the early #VE handler
Thread-Topic: [PATCH] x86/tdx: Remove the early #VE handler
Thread-Index: AQHdQVJI5eTV/fAKY0yXdX2Qs0UGg7bIRmSAgAA8R4A=
Date: Fri, 11 Sep 2026 00:15:32 +0000
Message-ID: <9a196321135d2a02e3ccf774eac5c30e8ebe15ff.camel@intel.com>
References: <20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com>
	 <b41da075607d1eaa9d96eddbf3acc24502edd604.camel@intel.com>
In-Reply-To: <b41da075607d1eaa9d96eddbf3acc24502edd604.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7121:EE_|CH3PR11MB7914:EE_
x-ms-office365-filtering-correlation-id: e1cfdfdf-35ef-48c2-3d78-08df0f99cb43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|3023799007|10067099003|11063799006|56012099006|4143699003|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: UYz/vWt7/KgpC4pJYWjoxWJnS5JyX0D4jJt/0lSid6M+Bs5jeeCiEomPZ1EywBVLV3hmJbMytGOzVssCl3dvgfxJ7omRmFZy1ndfg/gqteD5KFY9u6as7GwOs66iqrc7ks7P3Ma5jgC3am5LMILi34iIFmSRge72bbIYW66wwd4WJTdaIUG2Fali5tyDnAbPMYG7uuCC62/qQAMAlAiesncMxQOJJc+DPceRFoPjT8tH1qsYNYfaLubz8cjB3J776IYLJ82hWf6FLmkQkfFnIFPBxNqxWS+5q+QWhV0gFvRbHRlWXfLQ5LYjCOBe+bX2SIGSPhvRxP3WBn/M59p2P+BDnXT8OryVLzj2RTFtic8rXB7p57xeD70/QzTVeXMW7+KHveGh3+TBus/m0bKLpqT6ktsx3NM8KWt4GQkZMQEJ1BHF7SB9dA7M/BkHi0uPhKmCOUq0GUA9jLFPm3zb4If/4SXuZZeT2ecMSm3/xvKXPN9DjXgwpwhWXMCSUxaKqak5abzBjBJvYzM5y55NBJpwdDIr6Mb5siH25dJNQEv6X5EFVONcSymP4dx/D2EEKYgjv13n0XxVvbn3E1Q4f6w06EYUDYZVHOfHFqjZtykY5NQw3Dz8+oaoEOz8Gh2GMrrldualfMp7uRJe6sQR6RzjLL/QM+XPBIPRzN5dEEulvuzSTrzOMg/blrC8goTO/a49i3doq+hjliDP/lSPAjMLX0VouPw7CWvKGydizz4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7121.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTZVZFJCV2djSHgrdkgxM3duK3Bvc1FaK241eDV0U1UwOFRySUovK1RqcWlO?=
 =?utf-8?B?QjEzZFZIT0tQUU9pcXIzeEdRcVpKOUFHRFJJOFp2RFBiVlBoaHNHb1VnTU9U?=
 =?utf-8?B?dWZneUVzWXZveUwzRU1yYUlxTktPaXlTVzJLeEVrNFd6OW1aL2hpQkUyNWhs?=
 =?utf-8?B?THRRYkRabmJTSmxhbG9LNWhIcmRmckhxTkM4YXZTeVRLeGNnb1pFMUFUYmcw?=
 =?utf-8?B?dWNxRWRKLzJHaDNVMnovVGNKeGlheTYrY1F3aUUrNWRndzV6djdBbnFaek91?=
 =?utf-8?B?SmZCNnFtYlUxdktKQWdveFg2RU1yL1hIVmY4UEo5OGFTay9jaG93Tjl2b0dT?=
 =?utf-8?B?WmpRa3pwc2lqM05xSVRja0N4TFp2ZE14NkpZTGtZRHd0NkFBUmhSVXhlamlJ?=
 =?utf-8?B?SXN1c0taeDBZWTdzWk1OMGNVSnpmYlNmY3BlM3NGNjloRHdNb05OQ0NjZHNu?=
 =?utf-8?B?Q3NWS296TGdJZU1wQUVYdFJ3M2dZMExxdkdRcmNZTVpwREJWL2Z0VFVnb3hW?=
 =?utf-8?B?VnYrTTUrbXBRZEMxK3V4alFHczhRTWNYK0wyYkZxODMraTB5aXp0YStoRW1V?=
 =?utf-8?B?K05zQnZTczhvL3FmOHJ6RDc0YWVqOW5ma3BKSURuYVg2S3A4RjVlR00wdWx2?=
 =?utf-8?B?QXN6VThIa0hwZ1BWMUxTdytVUHVvbW8xK2xkRmZUVzFGaWIzdjJLRVhIK3BC?=
 =?utf-8?B?ajRvQUU1MXNHQW1qS2lDT3F0U1U3dFRMVGQ1TTlVdjMrZTdaTVNtYmI5RnlV?=
 =?utf-8?B?ZjN6bmpDZ2FvOFZKNm8zWmFxdks4YkF2VWtqZjhQYUUzVktma3hMbzkyWjJ2?=
 =?utf-8?B?UnZNN2pwUE5QWTZBakRQR2NxdW1ES0QzWi8xZG0zUi9yMVoxV1FyUG0yeGhy?=
 =?utf-8?B?cjdHRkVmVGttZ0lCTWhjSDBBZGl3VW5yQmE5K094cGp6TW4rNityb1VHcHVx?=
 =?utf-8?B?REx5Y0JlU2JTbnl2SmZRdldTVG5jd1hYSkQvMlNBMVlEWEZBZFpqS1N2cUpU?=
 =?utf-8?B?QnVaay9vOGhMNFdPUkFTZE1QMlVjaEppanVyb29xTWhVUmlaZU9jZUZ1ZEtt?=
 =?utf-8?B?aVpmQUt6eExjanRZT2hpWDhxZk1Ta3JWOEQva255NW1WeGsvRFNXSUYxZXRU?=
 =?utf-8?B?aEdieFY5cmtEY3RWTHlDVHhvWlhZVFpIa040K0c4aXd2QmRVNCtZRU9ITFht?=
 =?utf-8?B?RThscWVBMUVrcmNydlRGeGJyTU5RY2g4dDFza21XcDg3eXgxQnBJajh2OG04?=
 =?utf-8?B?Z2N1U0hEeWVBd3ByYTB2Ry9tdUkwRmZHdGVsR0x0VnV4aWVFbFc0Mi9ZUFI4?=
 =?utf-8?B?c2tRRnBQdXBoU3FBSWZJY3UrUElzWjRhNHJacnVSZTcwUjluU0M5L2N4ZXpZ?=
 =?utf-8?B?VlBUMGxDdDJ3eTh0VjZMcnZCUEF1QTB6WWM3K2dGTTExWDFOWkkvS2dEcW9Q?=
 =?utf-8?B?Z05YVTJ1YU1nK09xUHRlaDJYa0grcjdseFR1UXEwV1I3d3NxZHZmbG9YU1pC?=
 =?utf-8?B?MnRVY0FFemhwMmFvRXFlNG5mMFhvT0JYdWNBejhYTHdEdVpYaXNrRjU3T29J?=
 =?utf-8?B?Y3VOcEFkcE11bVpodExOTmh3a2NidU5TY3lnYVVYelNqME1DRjRJN0dGSFZP?=
 =?utf-8?B?ZEwzNTVYN09VWVp1QWZlaXg5ME5Gdk9zTmxINHh4a21RVk41cVJ4RkFLbjFN?=
 =?utf-8?B?NkR2UDVjeHcvTWdPU2h5ZVNBMUFCeVBPVWNHdnpLTTdIYU1jK1BJTVF6bUtr?=
 =?utf-8?B?QWNmYnJFeUZreXpMcEtFU25JUjQrMVNVdE9yV2JmeExuWVRrckZ3UWhMdHIr?=
 =?utf-8?B?SVZIeGdVNVZCQ2xRRWYxdnE2NUVYQU13MnpicHhmaFNxd3YyeHp3aXJjY2Fu?=
 =?utf-8?B?RDIrM2ZWM2c0T2RKZnpMYTJvSGtqazF2cHZOZW1Kd3BmdnAyZk95WDlMa3JH?=
 =?utf-8?B?WmRnQkFkZEpwZUxTTmRZanNoODRCU01keWRzUFF6OW5Ham1pTHVTZ0tQTWNx?=
 =?utf-8?B?c3J5UGl1bHI2S2ZqVmZIZzF3Tld2UHptK1RZY05vSUo2ZUg4OWt2Y3JCTU8x?=
 =?utf-8?B?M1AyTnpvdzJhVGIrS1hWK2dGUnQ2OVNQQkRSVUpwaWcvTHJIYzVDSmZGTTFT?=
 =?utf-8?B?Zm5KVUdwOWNaUlByUExRTXo2MDRDNmdYcnBhMG1lcXFzMWZLejkrZjVvZDZZ?=
 =?utf-8?B?Uk55eWc0R3B3VnZmWmFGbDdERi9QVEZCMnNRRTZFREVJYmJqM1BkNFVqRE1h?=
 =?utf-8?B?S25USzNnUFBJQUFTU1pVTW9qQnhYWTNnMDg0ZWFibGY2aXlyVnV0UytORUlr?=
 =?utf-8?B?dXNVeG9ub1JGYXFuaFl3SG4vcGtVNEh5OWI4R0lBZGN5Mmx2UDRMR0QxbDdy?=
 =?utf-8?Q?3kSV58i4kqrefGkE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FD8F19794AA9C4FAB6947DDA4FBF425@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V/952lkLtbzb/4sAX6QWIuQiTrl0Sf05dcr2xgtv8z8799u5ag7No7nApPCDItJsJ3SJBzOwTtMyB9Wi3gBvzxp4GWL13Mpuva7QI1UU71KNJGzqXev811+gIw3IJ1oRjHyAAlUjAkOQtH8uFXdatyd7elVtrZ8peNeIN5uMNrDiyxLzFWuDDtrT9tQ2qGecDHzpaWedYpN/DCT6pU3a+l+WIKiAYxPfpKzrqDiW5WEfsknP/r3dgo508b6OkWQu5L59W+ZBbkF6r8U793YYjEEiuW0sPV6o+h9VD2MuGxXNmf2TvWDu/FEdz3LafPaMjD07a3Cpwf8CH0EUB8ylEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7121.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cfdfdf-35ef-48c2-3d78-08df0f99cb43
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 00:15:32.4325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLdihcbWphva0nhPSZ1XIqXRANm2HFLvIi7nXD7KKfMPt46RqEWr1TSpWcdBK9l1ChNH9u5n28yLa5YuY7MU/vXoVjGAjpq2NaLpiCbieF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7914
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTEwIGF0IDIwOjM5ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gVGh1LCAyMDI2LTA5LTEwIGF0IDEyOjI4IC0wNjAwLCBWaXNoYWwgVmVybWEgd3Jv
dGU6DQo+ID4gdGR4X2Vhcmx5X2hhbmRsZV92ZSgpIGVtdWxhdGVzIHBvcnQgSS9PIGZvciAjVkVz
IHRha2VuIGJlZm9yZQ0KPiA+IGlkdF9zZXR1cF9lYXJseV90cmFwcygpIGluc3RhbGxzIHRoZSBy
ZWFsICNWRSBnYXRlLiBQZXIgY29tbWl0DQo+ID4gMzJlNzI4NTRmYTVmICgieDg2L3RkeDogUG9y
dCBJL086IEFkZCBlYXJseSBib290IHN1cHBvcnQiKSwgaXQgZXhpc3RzIHRvDQo+ID4gc3VwcG9y
dCBlYXJseXByaW50aydzIHNlcmlhbCBkcml2ZXIuDQo+ID4gDQo+ID4gImVhcmx5cHJpbnRrPSIg
YW5kICJlYXJseWNvbj0iIGFyZSBib3RoIGVhcmx5X3BhcmFtKCkgaGFuZGxlcnMsIHNvIG5vDQo+
ID4gY29uc29sZSBjYW4gYmUgcmVnaXN0ZXJlZCBiZWZvcmUgcGFyc2VfZWFybHlfcGFyYW0oKSwg
d2hpY2ggcnVucyBmcm9tDQo+ID4gc2V0dXBfYXJjaCgpLCBhZnRlciBpZHRfc2V0dXBfZWFybHlf
dHJhcHMoKSBoYXMgcmVwbGFjZWQgdGhlIGVhcmx5IElEVC4NCj4gPiBOb3RoaW5nIGluIHRoZSB3
aW5kb3cgYmV0d2VlbiBpZHRfc2V0dXBfZWFybHlfaGFuZGxlcigpIGFuZA0KPiA+IGlkdF9zZXR1
cF9lYXJseV90cmFwcygpIGRvZXMgcG9ydCBJL08sIHNvIHRoaXMgZW11bGF0aW9uIGRvZXNuJ3Qg
ZXZlcg0KPiA+IGdldCBjYWxsZWQuDQo+ID4gDQo+ID4gUmVtb3ZlIHRoZSBoYW5kbGVyLiBBbnkg
I1ZFIGluIHRoZSBlYXJseSB3aW5kb3cgbm93IGZhbGxzIHRocm91Z2ggdG8NCj4gPiBlYXJseV9m
aXh1cF9leGNlcHRpb24oKSwgYXMgaXQgcHJldmlvdXNseSBkaWQgZm9yICNWRXMgdGhhdCB3ZXJl
IG5vdCBJL08NCj4gPiBpbnN0cnVjdGlvbnMuDQo+ID4gDQo+ID4gRm91bmQgd2l0aCB0aGUgaGVs
cCBvZiBhbiBMTE0gb2JzZXJ2aW5nIHRoYXQgdGhlIHJlYWwgSURUIGlzIGluc3RhbGxlZA0KPiA+
IGJlZm9yZSBwYXJzZV9lYXJseV9wYXJhbSgpLiBMTE1zIHdlcmUgYWxzbyB1c2VkIHRvIHZlcmlm
eSB0aGlzLiBPbiBhIFREWA0KPiA+IGd1ZXN0IGJvb3RlZCB3aXRoIGVhcmx5cHJpbnRrLCBhIGNv
dW50ZXIgYWRkZWQgdG8gdGR4X2Vhcmx5X2hhbmRsZV92ZSgpDQo+ID4gZm9yIHRlc3RpbmcgcmVt
YWluZWQgMCBhZnRlciBib290Lg0KPiANCj4gVGhlIGxvZ2ljIGFuZCBoaXN0b3J5IG1ha2VzIHNl
bnNlIHRvIG1lLiBJJ20gc3VycHJpc2VkIGVhcmx5IHByaW50ayBpcyBub3QNCj4gdXNlZnVsIHRo
aXMgZWFybHkuDQo+IA0KPiBSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdl
Y29tYmVAaW50ZWwuY29tPg0KPiANCj4gSSBzZWUgZG9fZWFybHlfZXhjZXB0aW9uKCkgLT4gaGFu
ZGxlX3ZjX2Jvb3RfZ2hjYigpIGhhcyBzb21lIGVhcmx5X3ByaW50a3MoKS4NCj4gUHJlc3VtYWJs
eSB0aGVzZSBkb24ndCB3b3JrIGZvciB0aGUgc2FtZSByZWFzb24/DQo+IA0KPiANClRoYW5rcyBm
b3IgdGhlIHJldmlldyENCg0KRm9yIGhhbmRsZV92Y19ib290X2doY2IoKSAtIHRoYXQncyBhICNW
QyBoYW5kbGVyLiAjVkUgZ2V0cyBwYXRjaGVkIGludG8NCnRoZSBpZHRfdGFibGUgdmlhIGVhcmx5
X2lkdHNbXSwgYnV0ICNWQyBkb2Vzbid0IHVudGlsIGxhdGVyIC0gaW4NCnRyYXBfaW5pdCgpLiBT
byBlYXJseSAjVkNzIHN0aWxsIG5lZWQgdG8gYmUgaGFuZGxlZCBoZXJlLg0K
