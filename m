Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C62D7D2E;
	Wed,  1 Apr 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058587; cv=fail; b=T3aOuD9kpIcTYl6FxR3eFI0ayTvhsUNCdJ4h+hRKETBcgb6XeAGQZlkWoy/ObWsAAP8KAIgZTY4Fb0qYpPe0WcxATA5DwvFfuSxB+JVbYicGsoJTJRH0FVCq6RVUumuwjC/eEZ/iWqvqNcuOwKyRHndK/FVEP//6afHvR429u7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058587; c=relaxed/simple;
	bh=nJBAyuBKn8vo/N23Q+413k6HK+R1AaOqmY7ivytU+o8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lpEUk1wq+teL65M7vkMwAHhVd37hGaXaFC0hU0zYN7tGH2O5uV++5fE25cn3LucIAOx3MkJTiZ9bmb/W+TaJokxgTK5OKGYDu3PA3VvZpwlcfHUx/+3VDA/4uKR1+m16gHqb7l6AbFfDYP+LfkgtxNpRsY2s377I534qhdDdgYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZltqCtgF; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZltqCtgF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775058587; x=1806594587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nJBAyuBKn8vo/N23Q+413k6HK+R1AaOqmY7ivytU+o8=;
  b=ZltqCtgFIWaf2ZDauIQV9Uf6Dwn9lpdWN5SL31E4Z0jXVBiF3o8AuctU
   aEvCLzetmLRZfhMqyeulTGFkmWG7IM/6c1Gz9ozLpfvBjFk/NQu6xWagW
   tTkksCHhSIokx1/Djl4/tWXH+5aEbeEn3l2Eg+Py4YGKqqWXbTdlEwCuU
   w+60xMo46UCLNId5bwKyQ1GXWhKI0nr6J6TStyhnwkxKAKrcP/rxZvF1o
   jTlwUikTh7p+ODvjlmozhwVl0MOZUE2NGI8TraDl+ydKqZy9U1n/rz2XK
   3ksUE/NqDAOpYv2QQugJmbY1L9tgiVyhzV9nWTx2txNtFHbWkZEPlHTLf
   Q==;
X-CSE-ConnectionGUID: QDHarUBLSCatklBYBsiAMg==
X-CSE-MsgGUID: YCbA5M2aSTyHiTma9odExQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87492996"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="87492996"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 08:49:46 -0700
X-CSE-ConnectionGUID: f2Ogl2+YQe6EqGHVg55Hmg==
X-CSE-MsgGUID: wXeGpg6uRbqv2au3AQFMZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="223417083"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 08:49:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 08:49:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 08:49:45 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 08:49:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw4f3qQfytwnS7xv2zCV3cOXlbdGQ9WXOhIMheTj/asVcV/MvfK2Zd56yl7spvsBULQLtQcS9VHqJoSNOLp6Z+U7pmJ1opu81I1CvBOVuANk3+jUCJUZm1ja/n2Rw+xyCiXBMIBqA35EKbuCBed6opmWuRNGXOszlbC7Zy98tU9iaDDYHtg4SpacfESCchFZ2EIpYWWl//QbcByEHmV/1uNaHjgPRPg4PUr2LXDH+FZH12DyhK/qtTm1P1HT8kTwRvvmde+U75a/qXe8FX7XfjQyxbjDI1gR2xcKPfdjjEKPG/7h3ArN2y2VH4mny/4Y1r7l8NV9+ADyNAJTIe83vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJBAyuBKn8vo/N23Q+413k6HK+R1AaOqmY7ivytU+o8=;
 b=YU8qZnDDaYWZnioEroVZbWR1H0oGX4/i/dhwZCTQxVMTD9wm0s8AN3u27REZH0sQytMM2rMOjKpHfcuzy8ijWqOAMWbSUBMA6SL/qpbQVHYcHecV0amYNoAgZYf9dIVgHBX/zja76N4e2XIjIif5spp3nUeHvhc9g70JF+SY+v7EST1wnCY9F5pBRnHZbR5Mus79p8L5mRLKusNim5R7x4LK/m/ATrODAMPr/yzKcNYkWXzxKo6jndDUrE8zQJ0WGIHCOfwK1maDNmK9ewAfaimqPjIOo2bscJkh5vSPU69+8ii43CkYJByk/KDpY2yE5hM0Ex4nxY08M+CFLtzuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB7247.namprd11.prod.outlook.com (2603:10b6:208:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 15:49:41 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 15:49:41 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "prsampat@amd.com"
	<prsampat@amd.com>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"Qiang, Chenyi" <chenyi.qiang@intel.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Topic: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Index: AQHcu6ISxXKhFiWKBUuIm+vE1xtYKrW+PPMAgADQbgCAAHNtgIABo7qAgAAlqQCABe0qgIADLMUAgAADbgA=
Date: Wed, 1 Apr 2026 15:49:41 +0000
Message-ID: <819d84c1e62a8bac7ed22c402e1f2015958b6e04.camel@intel.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
	 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
	 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
	 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
	 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
	 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
	 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
	 <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com>
	 <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
In-Reply-To: <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB7247:EE_
x-ms-office365-filtering-correlation-id: 18e7ffa3-9002-4feb-89a7-08de900649d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: b9MX9eIjxnlks+pug/XHmJQnuG6k8cPgaHOoaw/NyNbpK9x5TKq2yKRM2ZtGk/keqXx/YKG0Wvd/T6RlWLHksj4WjXa/1ZyeGUddA2WrrLrDJDK5Nzll3boySomt/2w0+XzDXkJYESGrPyCuDQihhk8mO4koyQqoNjJZagB9zzL/JvMj/Bk5NeFCq05d4gJ6lo+IpYvimsFWpdCUb8zPzswyTszEwnNw5b+DG0CO+CKvdVU33v1TFdeG1NAx/s6y4aYdYkcFz/sSxAWDjHOxiwSF1jG7TQIAn/77HX627VFMxINZn9VkoC3t91f65biBpW7rYrcy3KV56rhAIqd33nBAEho0GEzdejjCL3ctzhLHicSZCofkdaa2HApUgfQfC4X3bvlKCfwP2jDBGML/ezxLvxHPXPPNxVEd9TZUhXs19srS9tiLg4iS4X4CikCbWZZ6snSSyAQozcltmnWFassAUfrZvMphw2ivOTBTpAEYA8Ma1KVoKEqGQPDnFmZNznD618bZmGi5jjcgUitQUK8qRgY69Dau9XyxMun3LD+DJkn7lbDU4UVNoacPjz2gsLVMhkEVFAejUz+MexiCvqNs/mgojJVp96RbOM96vJE+ZYb2agoHN3rzD55fbtEUUU+3NUClRLU281jcDr7FCaj0h76lDEe0Ug7M7TkynaTBGICxpJUAykGfBM9nylW2rtMq/wGvvsC+cBsIfTAByXbhCOZJ2kggRDVoCHH26xNgfvYOHu81uOKYUmo/SwmKu47zfcFxKWI2f3S+zOzA46poifv476WUWvNIXIM61cs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yy9Gb0psRFd0eEIrV3JjWG5manZ5QzczbWp6NStFSi9SNnNzQ2FMYXQ3aFcz?=
 =?utf-8?B?Vm9tTm5tclFOTlMzMHMwOXJJYU9PeWlPQkkyb0ZmMXhBN2FJdGFtbHFmTW5s?=
 =?utf-8?B?V0xwQSs0bFZsVGhVOEJiaytGbjVYYVRKeEFFZk5ONFZRMzJjZlQ2TmtuTzdR?=
 =?utf-8?B?MGlQWFZaNnlkeStZZjE1Z2FyNkYyU1RtVlI4SHBZVG9TWG9RYjRFYkhvRFZz?=
 =?utf-8?B?b2pFMzlwTjhrRUlzK3RyTjdGd3k1WEhWdXdJOHZmMUV1cGR1WlcvQlA5TmtX?=
 =?utf-8?B?c0l6Q3F3cnB5MkRKQ3VQTFdJOU9uYUZCMmN0TjhoYlVIWitsK2ZMa3ZHZi80?=
 =?utf-8?B?WXdvQUFvQnVQUVV4cEhJQVY4eW0reUlOSkJ0THNlY3ZHeEVHb2ZxZVJmZlBt?=
 =?utf-8?B?cXlxVGJnTnhNMWFTQ3pRb0NCV0JvelE3Ymt1RWY2c1J4dVVYdmhIRENuMTVU?=
 =?utf-8?B?NXVUSlFDdEpXNXllcjlBNFhKVjJ6YndJQmtxWXBFL0JXWmpQUWxKa3JuWFFJ?=
 =?utf-8?B?Z1pjSFhuOXZMWWFtN1lZK3lPT2FzRXZuSzBhdyszVC9qZGIvc3hkd25PMWc4?=
 =?utf-8?B?WVU0MXhPWDlYZmVPTmFWUURKVEFXR1hGZGxnVVo3RkpDMWhXZFZ6NnpsTVEv?=
 =?utf-8?B?aUNYQkZhWE5ENGZvVmozUm01VjJ2M3J3S0dvSHJPQkNMRWRpd0h1eGRpOCtj?=
 =?utf-8?B?TFhBdjZoYUV4c2tLT1ZQemg1R2o0amFIV3MwMEIxY3lRellvVWJKaWZCTTNF?=
 =?utf-8?B?Y3h1bjVKR0JZbDJkS3N5d2R2WHA1bWNIalhLQ0FPaDFrZHJnL1Q2K2JzOTY5?=
 =?utf-8?B?aGxUeGdBYjkvdTgxRzFuM0tjdHF3N2l0V2JQMEVsTFJVeXFIQ0ozdlV2Si9F?=
 =?utf-8?B?bVJpenJkVXlybDZDaVpmN1FaQ2hqblJhWVJVcGpYelNvVVJHKy9KSk5pVkRo?=
 =?utf-8?B?WE5rb1UzWDhXajVOQnp3VUZ4UW1EOFJzUXoxT3gzcmJnVjRxczN1WCswT1Rk?=
 =?utf-8?B?Y2J6WFdIWUhiT29QR2FVR0JjMEFWYWY2K1RjWG84NFRxQTFhVlFzM0l3VDdq?=
 =?utf-8?B?eTE5UkFqYWxXbWcxWVIzeUxXbENtNWplb2dvak44Uy9JWkV4ampkZ0dRM3hi?=
 =?utf-8?B?N0hxRit4SXdsVFcwZnNRb1dJZzlvdnVPNml5NDUxMy9XbzZkRXBUMk96MXor?=
 =?utf-8?B?bW1ncklhTmhmUG1zTHNPeElmTGdVblZBVzhIcHJncmh0dzlmZFIvRG9OVkxj?=
 =?utf-8?B?MnRWOXhENjdGM2pJeExRcGh0blkvcW5yVmVuS3ZGRlZ3Z0tnL1VMZENGekhT?=
 =?utf-8?B?WFVOeVNxS0RmeXhJaHhkdmp5RFJCWHl0ZFZmSXRuc0o0OGVBZjlBK0g1VTJu?=
 =?utf-8?B?dWFreG1UcWFwRXVDY3plRC9aTFllWkZFNy9UN1pDcTR3QytkTkptTHhMaDFy?=
 =?utf-8?B?RWFNZUZDUUFWZGpybzlnY2ZMcHFQdGJGQnZiYmtzNTRyRHZ6OXZDMGhmcklO?=
 =?utf-8?B?NGF0dnV1ZDBTRTI1aGpscDYxczlwalhhMGh3WjQwdEdtWFNsVEhJZWtyOEpU?=
 =?utf-8?B?ZXZWeElWUk1DWkFHWWxEY2ltUkFoU01aRWtuVzB5Ym45SDJQaWJabDRITHdt?=
 =?utf-8?B?L3hMVjJ6OUJXUzlsUS9BaWlFS3Q4TFk0bkxiYUkycFlsZENFSU02OGdGUk1t?=
 =?utf-8?B?eUtOdEZSMDc2eW9kVndRZXNVTUZoZGsvb1g2Z0ZZS3lYQldYTHlDbUlVUkR5?=
 =?utf-8?B?cG5MZTZvOHp5T29mK3RRbXZCRXppa0tXN3RxekZLNGhLc0l3bllPcC9acmgw?=
 =?utf-8?B?VTk2NEZyWmVJVUNpdkpHb2UrclBaSXJPMzF1VWxuWG8zTXF5RmdDUll6MERl?=
 =?utf-8?B?R2hnajB0NDlJcW5MdFZhME9QekF2endTSlhUc3c1TWFYeHNGY3Z5UktESFVQ?=
 =?utf-8?B?ZmsxVHA5dzJrMm0zNzNmeUh5WmZVUFh5OE1JVnJlWmlyTVc4QW9ZVmtlRFFv?=
 =?utf-8?B?L0tlSG1WcWQ2UUk5NkpFNlhaMUFRWXkyRjRhS3g1SmdBUUdNNXNGcm9rTUpt?=
 =?utf-8?B?WWlUSDZaRk02ZVhzK0hWdlk1dUY4OCtOdG1Ram5ESUZQNERDVlBkLzBhcUEy?=
 =?utf-8?B?ZHlxWWRTM0x4VVpVZXlybWdFcVFQTGpzSUE1dGQxV0c3cmxYWTk1M285VCtS?=
 =?utf-8?B?c3hkKzFPQTdrMWZqOVl2RHRncWRhbjZIaytROFBEazh4dDRtS0o2Szh4aWs5?=
 =?utf-8?B?L1FQejRxb0xXVzNYSGVId29majlJamtPTzY4UDk3SFoyQ3ZqMit3aEpxV1R4?=
 =?utf-8?B?TUxWZ055bk5CeEFjYklFQ2RuSUVPODk3aEkxSHVpRUcrZitGQVdReFNTYTZ0?=
 =?utf-8?Q?NVOES17SJ6V9Zb0M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <997B5BFCAF3D5F4F853635D039D7DF42@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bDwCw7L8cDDtKbI4+wZGUGD7DbDSyi/eKgaTyz3jKgnlWtBC+k16S7yDYE7DpDd6EKZTcMr5sWgH6dhYWxyDmAWNLJnrEK3fiqcriQYdbRG/zg1s2lUU68v2/CtQzZadaBL/ON+o3WU4GCFbSxLbl1in04s3TEqPFIGXd0cZR5cbDeMF4YAyqiX7P4VwiX7fd4Xx4imE5+7S0KwuOfkbB63SJXEtnT+Z7i0bquy/YMBs131neIwasbaGLFr9hu3jWHfRbQwnc4u/noigHllk0lpdtcq6kxRjTqQhkZxh0lS2dTabJPUgQQQmskzl92DGMbuGfBQVurWt4Zfg/0xMDQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e7ffa3-9002-4feb-89a7-08de900649d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 15:49:41.5703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AT/6yfBEDjwZQ/gBsoL8FdEhYUfJXOMiHpYq1HJkFn2nhuj0uI/nXYLK1QLOkUMU/SSY6DJSBp05200MZ7S1s8hWf8sgWn29AQPrT2h5wek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7247
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTAxIGF0IDA4OjM5IC0wNzAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gPiBXb3VsZCBpdCBub3QgYmUgYmV0dGVyIHRvIGhhdmUgdGhpcyBpbmZvcm1hdGlvbiBp
biB0aGUgdW5hY2NlcHRlZA0KPiA+IGJpdG1hcCB3aGljaCB3ZSBjb3VsZCBleHBsaWNpdGx5IHF1
ZXJ5IHRvIGFjY2VwdC91bmFjY2VwdD8NCj4gDQo+IEl0IG1ha2VzIG1lIHRoaW5rIGFib3V0IHNo
YXJlZCBtZW1vcnkgdG9vLiBTaG91bGQgdGhlIHVucGx1ZyBldmVudA0KPiBhbHNvIHNpZ25hbCB0
aGUgaG9zdCB0byByZXNldCB0aGUgbWVtb3J5IHRvIHByaXZhdGU/IElmIHRoZSBWTU0gaXMNCj4g
YWN0dWFsbHkgbm90IGFkanVzdGluZyB0aGUgZ3Vlc3QgbWFwcGluZyBmb3IgYSB1bnBsdWcvcmUt
cGx1ZyB0aGVuDQo+IHRoZSBtZW1vcnkgd291bGQgY29tZSBiYWNrIGFzIHNoYXJlZC4NCj4gDQo+
IEJ1dCBpdCByZWFsbHkgc3RhcnRzIHRvIGZlZWwgbGlrZSB3b3JrIHRoZSBob3N0IHNob3VsZCBi
ZSBkb2luZy4NCg0KQWx0aG91Z2ggaWYgbWVtb3J5IHdhcyBhYmxlIHRvIGJlIHVucGx1Z2dlZCwg
dGhlIExpbnV4IGd1ZXN0IHdvdWxkIGhhdmUNCnJlc2V0IHRoZSBtZW1vcnkgdG8gcHJpdmF0ZSB3
aGVuIGl0IHdhcyBkb25lIHdpdGggdGhlIG1lbW9yeS4gQnV0IGZyb20NCmEgaW50ZXJmYWNlIHBl
cnNwZWN0aXZlLCBpdCBzZWVtcyB3ZWlyZCB0byByZXF1aXJlIHRoZSBndWVzdCB0byBzaWduYWwN
CnRoaXMgYmVjYXVzZSBwcml2YXRlL3NoYXJlZCBzdGF0ZSBpcyB1bHRpbWF0ZWx5IGNvbnRyb2xs
ZWQgYnkgdGhlIGhvc3QuDQpVbmxpa2UgYWNjZXB0IHN0YXRlIHdoZXJlIHRoZSBndWVzdCBnZXRz
IHNvbWUgc2F5Lg0K
