Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF844CAFB;
	Wed,  1 Apr 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052006; cv=fail; b=EZicMeOwuTbCCeQwFzd2CMt2nzZEv3jQkC+v74n9Wh6MHEHkS7I6dEkW71qN5Czv4bemRFTcNEfQmbDMaEstOhJ8OEtJZrH+hH12Z3it0ny8iSTkgM6+GLm1qX+fj/x4TW2Y0SsKWB/hzorfGd6sQKPFV9aj7sw2kv94QgsqhnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052006; c=relaxed/simple;
	bh=MTa3FgVWCRo4zM8yZrnihDP4qpwSzC5CpIYsHf1qr8E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d68odK1I/GSGyFU17U1EMGQaTD05MZfxbKlU79jsYckla8lE7f/ITqP7dCOPaaDr/DcJ45AtTcqeJAvYzqqs3tk1WFEEDNzVMbFVLUV4KqpAAjSg67lrf+aBt6KBZoM6lL2F57wej2A6IHWfidVaUDxYnMBJGmYrCJjKa9h+CVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncMxG6sL; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncMxG6sL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775052005; x=1806588005;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=MTa3FgVWCRo4zM8yZrnihDP4qpwSzC5CpIYsHf1qr8E=;
  b=ncMxG6sLgEuUZ+hy0aq8vhmwn32icIjYliaVx3gAoZgpoxHpAyCYm4p9
   zmLxqGJdKQLIYMzKz/CZyv40awG1AbqERjhkHQnEn9CVKWRA/ubIGy2Y2
   4+DPmZqE3CXtLcvjeND61MDH7AqBF+0iLWrlj+czNOUT+BgfuU7KTu+bm
   OQlZIzlMemnhM7iO2OCzlefkoWXISNfDvLBm95DyAwZ2LQtetaYez7y4p
   PwhmEHqm1SUvv3xFmXYS0qzSRDEbOWhJcis8gIPRNDOIC6AB1KVO+QmRF
   mqaPYw0IrUGq5k11mWwanxDRyj8TZYlw85h0azQyAgY/+J10p9dOGi2+q
   Q==;
X-CSE-ConnectionGUID: J/j3dkdVSpi6hNRXDSH9Xw==
X-CSE-MsgGUID: JINDYWIvSxW87IlGxErSMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76051330"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76051330"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 06:59:51 -0700
X-CSE-ConnectionGUID: plZRNDmyQuKnj1TOW2S7qg==
X-CSE-MsgGUID: zS/WbvohSsSMV/kAo1a4Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="231091974"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 06:59:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 06:59:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 06:59:49 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 06:59:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT5w0uwlBCAvqXO9GRp/4Km51Lu9yQ4UKMj2sROKP3v4HgfBeIYzd/u+V0RcIIj34qTF4TjQ1kpyELXc2XiUm/y7+VGdQzvq70zQ0oQweOZXMd160NXh0mrsnMcMXH8Y3jpGp87DdCY2vvvjZl/QeMJELKjdXHzgY3qQAinrncFH/AUIHmEYd6Edx1HFEfV/A5yySPhQ8Qw1jGHWEiMZwfk5gurhCdb+7iSgFsYshzb8RsmDD6Dvz7Sgb9iVbNO1+ATWMkHl3OEOk3LIJYNG2ReokktTExRk1emo4oKyiSjX37lf69YPUEREiYCGvoYZEhaCcIQKIAj1UO4zqMwDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTa3FgVWCRo4zM8yZrnihDP4qpwSzC5CpIYsHf1qr8E=;
 b=hPhNB92FxRFMIHYxkQdb2HzzMm3D+yaSuRFQTvR0fEnGKjFIsmoMkakt4jODVaVdQswouO8I2STuTx4AY3fp5kYgFGJWqyqzKQxoZSSTgpYUKYeK+SGNEUZ7e5uGn6NSZfi6FwAOr9f73fFDH5QXKoO4FxdUUiyszHWYmL9ELvV/X2jUIkxqv4UvvHCS+F08OK1idAIlrK95xeqvae3jrxivcXfatu4Om5ZTvKfQbaLQwEFE+Cv/bgsHrYtmfoQOYtwy59IcC8dQtrLqg43kwh4Q04uTHKwlCUIUGx8hKpbu7pBKfinNdQXl3iNSXflBLF6Ne9Uq1kgqW7OigB5N+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB4901.namprd11.prod.outlook.com (2603:10b6:510:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 13:59:46 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 13:59:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pcj3195161583@163.com"
	<pcj3195161583@163.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: TDX/non-ACT: failed TDH.PHYMEM.PAGE.WBINVD after successful page
 remove can leave a page unreset
Thread-Topic: TDX/non-ACT: failed TDH.PHYMEM.PAGE.WBINVD after successful page
 remove can leave a page unreset
Thread-Index: AQHcwdjISJvuLzUnAky/TDRUx8hFSrXKPGkA
Date: Wed, 1 Apr 2026 13:59:46 +0000
Message-ID: <c1a05fb9c8966d94a581ae2faffb7cf588f6340b.camel@intel.com>
References: <5a73e445.aca5.19d48e268dd.Coremail.pcj3195161583@163.com>
In-Reply-To: <5a73e445.aca5.19d48e268dd.Coremail.pcj3195161583@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB4901:EE_
x-ms-office365-filtering-correlation-id: 900f5785-b4c8-4ad1-5f3d-08de8ff6eee7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: jxTYq/cFfgWJBnIIBrXvfeMGlWm8T+Ys7YHoNONWoKkPmuz2VRVjU9dEcT2yH616hWuY1oQDy2+VJ7F//AaWcbNLxIkoPAC9JUTM0u5DZiqF85PbfLdhArtU010uDfEBAm7ViQTo5ovdn3PNBSxLxRP1GTQPKQl2wgZHdZX7l+deh0Qu9rD9epaRg2N/JCvC1TDNf3lazqvHGdrXIw1l6VLJx7VnP8ERfCrAyb9bfyGksOgmQJCK+NZNSLWVPPQM/g2p5yjw8jnuV8SUXWUtwctMATqzk1XHp/tSWQT9BgZIwImOgi8f3yCMs7aYtUDRBd6g8umSUG7Z0IvgLjcLXv84V6LV/t8ywrAfaaurEvO8gilYsg3wjf3QjjK4DkThi/ETfwNbF58M9pDaxIAgFG/l/Np1QYUNLgbMsvT6DolydUe5IZO4AD47Ru28nHTVOe4xbBybdKKFZIU+5aQnm3YQob6jy79e1GvTY4p7fuegZyxuzTgCmVo2NfjHHhBidArKeybTXTK7xB6alP5wnPaHleacDzidZzdlkmiplJQA8ib6+A01GAExMO//REdsFXEC6EpX31gaUaNBN5NgcALx/PZYXqSr5Fc+cysIAIO7GLgKl8QRDjgHAYwr37kNQaHQ5OgHP4sxHW4vP9MLH6tcRxmd9p8P5rvR77NXDQCv+5bnSA93peIFMRh2IXujHj4M924/PJFaXtyqnUKnhvPTg4JOjfvM7NEd99ojtAZHFgbWiDnYKjjYnryL7aq7SCVlXv010Li/GV2pBJqeNYiL6RNyIPvJyt25RpjtoD8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TForU3gwWitTSklpQjI0UjJIMzZGZllCSERTWFBkZUNmeE9iR285RHR2T0tv?=
 =?utf-8?B?SndNQ0YyT0NFUTdRNnJMNVpmNVNwMFV6UXJqZW9CUUxGWTdnT0VldW9SSEhn?=
 =?utf-8?B?dlJlTlh0WGhjM055Y2dxMXJtWFlqc3A3SWI4OFNkYjMxUlJpSjdXdTcvTk1O?=
 =?utf-8?B?L2trYmczWURpekVOZlVrb205anllckFpNFcyY29SR2JrWkJoZWVhajQvc1Bh?=
 =?utf-8?B?WWNJOWE1M29zR3JKcWJ4SjhkMUo0TDY5MDN5NTd4dlVmRnkwOUk5RU5jSUNG?=
 =?utf-8?B?NStiNXhHaHpsUGdpVmhJUUxsbTFyYXloY1VRNFNPeFRIMGJhdWVGK1d2SERx?=
 =?utf-8?B?Qklaelo0WXZMeld1V3RZYWFnZFRMVGYzWFluTi9WVHNOOSt3U3ZneWRxWTFN?=
 =?utf-8?B?L0Q3YmlIY09kWGdvNzlFL1h6TStCcWVvbFUwNmRhNlNXMjlFSk0wdWcvLzlL?=
 =?utf-8?B?aU1XNFViV1BzZDJCVVIrR1RGaGtHZDJqNWlqdklDbDNWMGdxTkJ1QVRnSXRR?=
 =?utf-8?B?dzRiNVV3dW9WMUV0VzBJM3FZeFpQaC9qbGZlanNrTmJUWVJnVENxNVppTUh3?=
 =?utf-8?B?ZTB5U2hrRXA5TitPNUM3RURUNlBwUVNvemJXdXZMZHdFa3ZGSkRpQzVHbDVJ?=
 =?utf-8?B?cG80SElJOXpRQjFqRmNEeitPd3cvamR0VzVwMzlxUXlXZEZyNnZBRFNMcWNX?=
 =?utf-8?B?NFJKZlJ1TkhuWk1rQWJ5d29aL2thZ01sNlFNM0NEVHd3QXNvcVhrVTB6R2Y2?=
 =?utf-8?B?TTlGVDc4cXhERng4dVJkcTBMTUc3ekkwOXF0dHowZStQUGlHRGFCTGwzWGMy?=
 =?utf-8?B?VkxjZ0c0RzFYbFhpNVZTeHlGOUJuV1BXZHZYSnRRZ1JkeXA3elpUSThObWdY?=
 =?utf-8?B?Q1BiU2pnV1ZIbXR5YnVBYnFueC9RNEY4cEFiWVpNR0ZGR3l2Vk9nb3hXdkQ2?=
 =?utf-8?B?WmNnaitndHhnNmhxdys5ZGVJSDRTM0xxTjBMQ2xlN1c2YlQ5YSt2d2hJczNp?=
 =?utf-8?B?aWhTQk5STHJ4Y3JtRnhxSk5HWGc5TXMzcGpaUW00bUJkKysrYTZ4R2NTK1Bl?=
 =?utf-8?B?YndPNXJVbXdZVDRxT3NLVCt1Q3hQYko1MHIvK254WkhkLzJqSXlNZ3F0Vzcw?=
 =?utf-8?B?Mktza21TNDUxb2szRVVJL0hYb2tGMEErSjhVY0dnNW1rWVdkajE3WjZkSmpD?=
 =?utf-8?B?eEV2RC9SQ3B3TTNlM0hsTTcrSzR0TnBhNkE1MWxIeERsYlJtZXM4MHo4SDIz?=
 =?utf-8?B?WmpTZ1lxQ2l4SW9GRXlBRWQybDJHRjFVKzFGeWFSVXVZcjhjYklWa1VkSFl6?=
 =?utf-8?B?Y2dESE51eUU3R3NNVXZQZk9ncUNFV28vTElETUtNNUhERXZkWS8yRVY5cXVO?=
 =?utf-8?B?VE1hWDFXM25zcnV0ZWo1RFFra3doQlBtK3RZakQ1N1haTzRFUDl4SjM3a3RF?=
 =?utf-8?B?V3h0WUZEN3hIdzVuNi8xdkxrT3RieUIwRlhZUDJKamx2Nk9odW1DSVNBSG0v?=
 =?utf-8?B?VWV6WjRwM2RRQ2RDUGI5L1J6WTl4ZklDNlVHRTV3aVpMa21ITWtTamlwVy81?=
 =?utf-8?B?bzFLdzl6WW42Nk5uUVpHTVFvQ0FmYTdXVG8xRGdzM01xOWkwaklHbktoWXFV?=
 =?utf-8?B?c2lqYXJTek5sNnlhYW5MTHNuZHpVY3A1UDAzRkNXd2J2MVNRN21rR2FHNHFp?=
 =?utf-8?B?dlg2elZwb0pxNE1OQjV1TzhwVmE5WCtYVFBrUmM5MmtxQjd3Sk9hNFB2Wmhq?=
 =?utf-8?B?dXlNd0JLem13TFNXY1VTVThiRGM5eE9HbEdUTGxPS2pFUVY3eGZPRGw4RUk0?=
 =?utf-8?B?eFM2dHNOZzhHd0tJcDVQa25LVVh0bFF5UGtBRFNhbG5SM1hNVWpwaDFraTVs?=
 =?utf-8?B?YTVpNDlKY1dJWDVWOVRrL3JmdWVyM2d2RnQ2eU1ERzl0MHVqcHZnTEV4QWNQ?=
 =?utf-8?B?TXBicXJtRE9hZlQ4M0RuY0hsc3VWSVJvS21oV01hTFVpajRoanV5Q3VQNHNO?=
 =?utf-8?B?OTl3QzFRazNIZjdkMkUzVWhMSnNvUVp3Z3RTYWNjWXdyNzV6U1NtM0NHOTJ2?=
 =?utf-8?B?aFlhSU00T1k2SWhlc2RBeW9GY2FKdDNmTEk1Ri82WEx0YWZUOGxuY2RSeGs5?=
 =?utf-8?B?MmJUU2JSZGJ5a3RNYzQ3OXFXeEx3RU41dE9HTmVsZ1Vva1dGcnYwR0xYNE44?=
 =?utf-8?B?akZzNnA1dkt4RGlSa09PUmprbXBNamRlYVRIK2xJeTkwbmpMTTRrQWp2WUxZ?=
 =?utf-8?B?eUJZZlEzamtXQUh0bVY0VHRlSng5WHl1eTVXQXljd3hiNnFORTB6SVV5YWs4?=
 =?utf-8?B?akRMb0FlVFd0N0twMzB5dUJpZnd0RE84Qks0OGpwdVhvVHRKc2hxalllcHdn?=
 =?utf-8?Q?MWLXKm9nzgrqgnP4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C642C157D69044C8D38F0851D9A412B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VHBBFzJSRMS4uDqGqW1eobZYe2v9uaRztnDlEOiYq0LrkJD7F301kBkF4DOgdtt1KZXQRZqxln7CRiy+XgRhBGXg//ZnHCYYPgvoThctE11EXnujbFWQSeoDE4IHsRjwq6eN3Nol8j0viv5rV54rnSbj4LmgvmwemAZe3DC6fk7Gjc5bLtLRmyf/REC3IZOe1okr627VFkFVa3F2QYEjL0zdySuVkb6b7N6nSfIMC39Mz8nM2o+bE4Kj2LHzpwIiY3dxZi8IHiO7xflltis5M8XKrtTSulWEHj75SUZsBIfZINvLqCFlZdkeTI3SZOPxTdFstqF4/Y91P4wiKKu4NA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900f5785-b4c8-4ad1-5f3d-08de8ff6eee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 13:59:46.5317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLcGBxUp52QltiOG9NQ1Yc33irfWrkqVSjpRMogEJiK7ff/M+UhKjqe9bn7QaslnZw1NZ0rj8FKj0nMvYlCBhbSPB3mDu+d2kMWCOojVwC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4901
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTAxIGF0IDE5OjUxICswODAwLCDoo7TovrDkuL4gd3JvdGU6DQo+IA0K
PiDCoCBPbiBub24tQUNUIHBsYXRmb3JtcywgVERILk1FTS5QQUdFLlJFTU9WRSBkb2VzIG5vdCBm
bHVzaCBjYWNoZWxpbmVzDQo+IG9yIGluaXRpYWxpemUgdGhlIHJlbW92ZWQgcGFnZS4gS1ZNIGhh
bmRsZXMgdGhhdCBieSBjYWxsaW5nDQo+IFRESC5QSFlNRU0uUEFHRS5XQklOVkQgDQo+IGFmdGVy
IGEgcHJpdmF0ZSBwYWdlIGlzIHJlbW92ZWQuDQo+IMKgIFRoZSBwcm9ibGVtIGlzIHRoZSBmYWls
dXJlIHBhdGggYWZ0ZXIgYSBzdWNjZXNzZnVsIHJlbW92ZToNCj4gwqDCoMKgwqDCoMKgIEtWTSBk
cm9wcyBhIHByaXZhdGUgcGFnZS4NCj4gwqDCoMKgwqDCoMKgIFRESC5NRU0uUEFHRS5SRU1PVkUg
c3VjY2VlZHMsIHNvIHRoZSBwYWdlIGlzIG5vIGxvbmdlcg0KPiBhc3NpZ25lZCB0byB0aGUgVEQu
DQo+IMKgwqDCoMKgwqDCoMKgIEtWTSB0aGVuIGNhbGxzIFRESC5QSFlNRU0uUEFHRS5XQklOVkQu
DQo+IMKgwqDCoMKgwqDCoMKgIElmIFRESC5QSFlNRU0uUEFHRS5XQklOVkQgZmFpbHMsIEtWTSBt
YXJrcyB0aGUgVk0vVEQgZGVhZCBhbmQNCj4gdGVhcmRvd24gZm9sbG93cy4NCj4gwqAgQXQgdGhh
dCBwb2ludCwgVERILlBIWU1FTS5QQUdFLlJFQ0xBSU0gd2lsbCBub3QgcHJvY2VzcyB0aGUgcGFn
ZQ0KPiB0aGF0IGhpdCB0aGUgV0JJTlZEIGZhaWx1cmUsIGJlY2F1c2UgdGhhdCBwYWdlIGhhcyBh
bHJlYWR5IGJlZW4NCj4gcmVtb3ZlZCBmcm9tIHRoZSBURC4gTm9ybWFsbHkgVERILlBIWU1FTS5Q
QUdFLlJFQ0xBSU0NCj4gY2xlYXJzL3JlaW5pdGlhbGl6ZXMgVEQgcGFnZXMgZHVyaW5nIHRlYXJk
b3duLCBidXQgdGhpcyBwYWdlIGlzIG5vDQo+IGxvbmdlciBpbiB0aGF0IHNldC4gVGhpcyBzZWVt
cyB0byBjcmVhdGUgYSBzdGF0ZSBob2xlOiB0aGUgcGFnZSBoYXMNCj4gYmVlbiANCj4gcmVtb3Zl
ZCBmcm9tIHRoZSBURCwgYnV0IGl0IG1heSBuZXZlciBiZSBmdWxseSByZXNldC9jbGVhcmVkIGZv
ciBzYWZlDQo+IGhvc3QgcmV1c2UgaWYgdGhlIFdCSU5WRCBzdGVwIGZhaWxlZC4gRGVwZW5kaW5n
IG9uIGxhdGVyIGhvc3Qtc2lkZQ0KPiBoYW5kbGluZywgdGhpcyBjYW4gYmVjb21lIA0KPiBlaXRo
ZXIgYSBsZWFrZWQgcGFnZSBvciBhbiB1bnNhZmUgcGFnZSByZXVzZSBpc3N1ZS4NCg0KTm90IGV2
ZXJ5IFNFQU1DQUxMIGVycm9yIGlzIGV4cGVjdGVkLCBiYXNlZCBvbiB0aGUgY29uc3RyYWludHMg
aW4gdGhlDQpjb2RlLiBTbyB0aGUgY29kZSBkZWxpYmVyYXRlbHkgZG9lcyBub3QgaGFuZGxlIGFs
bCBkb2N1bWVudGVkIGVycm9ycy4NCkFzIGluLCB0aGUgY29kZSBpcyB3cml0dGVuIGluIGEgd2F5
IHRvIGd1YXJhbnRlZSBzb21lIG9wZXJhdGlvbnMgd2lsbA0Kc3VjY2VlZC4gSWYgdGhlIGNvZGUg
c2VlcyBhbnkgd2VpcmQgYmVoYXZpb3IgaXQgZG9lcyBhIEtWTV9CVUdfT04oKSwgYXMNCmEgYmVz
dCBlZmZvcnQga2luZCBvZiB0aGluZy4gSXQgaXMgbm90IGludGVuZGVkIHRvIGJlIHBhcnQgb2Yg
YSBzeXN0ZW0NCnRvIGNsZWFubHkgaGFuZGxlIGFsbCBwb3NzaWJsZSBidWdzLg0KDQpJbnN0ZWFk
LCBpZiB0aGUga2VybmVsIGRvZXMgYWxsb3cgYSBzcGVjaWZpYyBLVk1fQlVHX09OKCkgc2NlbmFy
aW8gdG8NCnRyaWdnZXIsIHRoZSBrZXJuZWwgc2hvdWxkIGJlIGZpeGVkLiBJZiB0aGUgVERYIG1v
ZHVsZSBzdGFydHMgdG8gcmV0dXJuDQphbiB1bmV4cGVjdGVkIGVycm9yLCB0aGVuIHRoZSBURFgg
bW9kdWxlIHNob3VsZCBiZSBmaXhlZC4NCg==
