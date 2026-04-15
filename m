Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D030C617;
	Wed, 15 Apr 2026 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264995; cv=fail; b=juXmTqFlBet5ijANyH83LEVggc2MobpQcZC/8GbP0Cp1XXuLoYTtkvmI291WMIxSX3DMv6fDiXAVV8SMR55wC5VVp0dXpmFa2Tf9YWrOsy1U23M3gcoB3hqc8gMSP46YMVhc5uOvUdOnEfkDBWAfwthwCuILDrVGUvg3ZH72ATA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264995; c=relaxed/simple;
	bh=N8t8NbMA2leitPoKSLwMhpeoeer7dsAg2oBB5p9HfQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DP/PRKPJc0oa0FnY4IsxV911qB0JO8Q8iFfX6zA/B7j92ld/pl52SLRaeqN3Hf08ifN3sF7E+AzP220bceMm8lZcI4Pcwxzgt9xGqVt6kAY/izboDPM9RGbDJRSqylWdMpluVa3JeP9PgAdtv/UBN7VekH2w4U9xdKYhVjvB77k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTLlyhmp; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTLlyhmp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776264994; x=1807800994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N8t8NbMA2leitPoKSLwMhpeoeer7dsAg2oBB5p9HfQY=;
  b=XTLlyhmpZHYXoxmk2NMc89/qQxEMwqlkdl2m4xraZ233crDantmQBjZx
   1MmoMnEKhyX0Gl10lGGeDOvLlM9o9/YJBmybKV0ddtzwvSH7okFlS3Iy1
   t8Oybei2Dl0ck31aDx1h/Ebny+u2+wE3h2W6K10MahryGpr5FiuiI9PFL
   UDgTlYA9Je4Qrl5tI90fKuCBnnwjw2IbiSlsG9wmgREn4lUh0n+8DbIoO
   lHFAdST1pfewY+vy9D/cKBDFfM34MXSxB6tKvr97uHZ+QW7c7S46m6K87
   iCk445t2kC1+jLPWzhaBA9RqmqkXfZ2kVkVA8B37Gx+3d8YIHhcBQrfCO
   A==;
X-CSE-ConnectionGUID: 7za6RIdJR7GVymOHGfwiOg==
X-CSE-MsgGUID: t+PyQM4qTEG8e8HtdU5xDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77121023"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77121023"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:56:34 -0700
X-CSE-ConnectionGUID: mRFlXil8Toqu6natG8bILw==
X-CSE-MsgGUID: 4QotUMbqT8acdA7vuH5mOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235396253"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:56:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 07:56:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 07:56:33 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 07:56:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1ZTQDZXGdIczc7LEU1gvabWG7bXwLD8zp555nqV91vCr/WumH0SBnNjvDyIWRx3eApRh7cA6wqGji3hT6RpsLKeZCLkCw8ikYsn31yZtSMWBa/MSVKUI9oOstxezEaG6MW4kQOiaUVU0xtEKoeDLDofXcty5jBdSsAUSutPKTwPW6znBvM+jxhEuzQFFzBzLBWfd9n3D3QOTDz6gxheIVNPfaUtzuvcJJSnfmCL6ZKAVvYtOgRXlP1h2jCd0TyzMAsVr2f5Oj7PZMwA22TFokxqMJ5xfUVfVT0xeVpSwclXTDf25hYPqaVaNEIhOKZd4xkBZbwYvn/y40D/Hd10xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8t8NbMA2leitPoKSLwMhpeoeer7dsAg2oBB5p9HfQY=;
 b=YnUvawv6vlfMmA22dFW/a2Kiywj7RKdlW7U0TQJqCQOuXf+AoUWCGIOAv3arYwdaKYHNErxoL6JuzYI1YBoT98177tf6vksk5wCkiTUt1KMQox3sH1pmdvJWjeGEaswpWqic11w67iSeo+kCU/riPnze4zVYp2W5QqEYi+rbGKQ5IYeFgJWVaNTctB2hDiKsYoiqwHxyUrk5WX7RK5pOZeRf82tp1ShzFWMp15S09u0mFtifQaUBafzPsJ52kg89IXjZVgaVURkhtFEE6kvha/3fVjzqmSe7sg8krJDZaqzgGyYf7AmGsV/E9cUoDs7Haeb/R6Wsabpd503r2x2cCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Wed, 15 Apr 2026 14:56:30 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 14:56:29 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"Weiny, Ira" <ira.weiny@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "sagis@google.com"
	<sagis@google.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [PATCH v7 10/22] x86/virt/seamldr: Abort updates if errors
 occurred midway
Thread-Topic: [PATCH v7 10/22] x86/virt/seamldr: Abort updates if errors
 occurred midway
Thread-Index: AQHcwQv/Ma1z1LjCBUm2ZgQgcKxBmrXZInqAgAVGIwCAAIEHgIAAnBYAgADI0gA=
Date: Wed, 15 Apr 2026 14:56:29 +0000
Message-ID: <09f13262cd8ad37e8d8b9e667d79d9a539c27207.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-11-chao.gao@intel.com>
	 <fb472138f6ba06efd90a3834a5748662d7b7ac44.camel@intel.com>
	 <ad4P9HZEOnC3wUH3@intel.com>
	 <80a01d40855136a5825e5f353a8cc2982dde385a.camel@intel.com>
	 <ad7/ICVYG+Z63b4i@intel.com>
In-Reply-To: <ad7/ICVYG+Z63b4i@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB5971:EE_
x-ms-office365-filtering-correlation-id: 9aadac3e-4951-4301-e682-08de9aff2d24
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: kTIrq7oPewQ9SQFZeGL3wiTjaNncfH/5h8PYS9cuvcMAU813OVGx91nNIaW0qyNzFon18U2vMbHPu2BWrmUDLaDXdkrOcAN+OQbKxYyu+/y4d+Ndm7oFVd/0/JEZ4cobxalwtxlppKEEu5MndeyHFjxWI04aAWjoEqihaNNvmQyLTmtRq7bEE2A32Bjl1p3lbIe8tzU6nIFf0gn7gGjjG+MJeoi6SY6YQJapWt0KjRYcSt1I+cpMmVwCJSnvXLpZFbKzOOdt2zZdiB6uXPaFsbWM/HvkKQ12Zi4RHW2pEKBDN3iw1FSgcTndK2s+lKipCb4saRZLbRf37Hx6sEu5CtTTUxGGi391nSv4ziyWvyTwWJOrkBY7/63GWotfBpzEXsy1snJqGG8/CcT1NBRFaxaplaLRTYSur8XKzpw1sQ0ZVHWzM5IrPARNuV0IMKmNVTb7HVBYAAWkOjOUh5BbAU9vhYoDzmB4MPmrxn6V4DqXctg/oQ9gxGCssLYCUcldD8K3wluHLc26tqxfbr1S9KWXC70rFtRQay/2aWx54HKk+tagqYxAIBa3JAblTmg/tnSZJgw/RlNoYp5waMjNTb28ig7rv5cNK4OBoRckRiG0d5cUNAx//446eqaVphMlG530Lo0wu2/1J0oOXdcITjSdy02FbgpcOuRA3qYTYPv2Jq6vgyL6NYOEDmNJSDWZGnGohuQ0//ng9Mtf4s/inp+xuIFJKN7AbRyWhsviLcllkPwxi2D0P//PvnxM+0OP66BRiPH8F89X/D3CIZgcMiyEUl6186KJcRtBQpNp3z4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVZDaFdiZ3pjQ3YzeFNoZVdoUlJFcnc5NlM5SlFVVjNUMndqR2txeXVBWFBU?=
 =?utf-8?B?N2QzR1Y1eW5BS1RqcGJ5TlNDdnhTaHJiZFBxQ1JUVmJnTGpnZXZISzY2ODdH?=
 =?utf-8?B?amtuSDRDTVZyaXBnVmwrRy9nSnErNWpucW5rU0hEQ1VoSkUrSUhQR0J3dXQ0?=
 =?utf-8?B?dTBjRGY1dlcyMURxV3RBY1dtQUhXSmdTdXpFWkI4aDRLUEE0cGZhV0ZYd0Qw?=
 =?utf-8?B?djYrZTlCWWhRbFFDZzdjRW1IWTF5QngvRllONUlPUHBYZ2RLRTY0Zm5UczRr?=
 =?utf-8?B?c0tyRE9vV2JGa096V2ZRUzVYcVVBMzI2VEM3UUo1SHUxajZZUEpyNlh0MzJx?=
 =?utf-8?B?NmhMYmZSWVFHYmJLdTRPK2czcGhjc0lIcHpsTnZaV084TTk2UTQzanRrRnFC?=
 =?utf-8?B?K0VNeHRGeHJpZEtlUGc3TVA1RFJxTGRaamU4WVNxanA0SzRuR281ck0xckxu?=
 =?utf-8?B?UG5FK2J4bVRhdHZzUVFKWXIrL2plcW1YWkRCUVlDSDltMTFvSk52eWV2bUE5?=
 =?utf-8?B?TnBEOERqWFJWWmorWWEyQ09tRlhKVVZtS0Y3QktDczZNUGwwNGxnbTFsT1Qv?=
 =?utf-8?B?NnlucmVjQS9RTTBndnV3NHhYZ2Q2OTY0NW5yYWFSdlBPbGkvcTNadmppSzcy?=
 =?utf-8?B?MldiVXRtL1ArZ3NtWkZiazBBdkNRcUsxa2xmdjZvaXRtZnJHM3hORjlLenpt?=
 =?utf-8?B?aVZHdXk3WUJ0d0Y4NkRzRHVzZ3R2U3hNeHFvL285L0tVNThtN09GSkR2bmpt?=
 =?utf-8?B?RU9IRlZqdmxxcGl0MHZaaXU3SEJFK0FDTEJ0cUVhNXRQZjVIQTBXQVpubEJX?=
 =?utf-8?B?ODVUOTRBdzdCU1A3QmFSUGEwWDlzdHJ5QmZCRm5HZHR5Tm5kekZVbUdmYlhs?=
 =?utf-8?B?MHppMnYzTGVTWEp4NGFYdHplb1loV0wzWHd4c1BtWWZxemgwZ0xiV25JQzZ4?=
 =?utf-8?B?aGhSUDgvbkRMSWxERFFuQ2VwSFZmUVVWRy9WLzVKYUt3RlYxTndyb2pOZ1BZ?=
 =?utf-8?B?ZlZWd3dheGU4R0tpR3JHQlFydkpHeSs3elpkcXpCTmJWZUhGbzhyU2tObzNQ?=
 =?utf-8?B?d1V5RHR2VzNYVHAxbkE4VkIrZkNpL1FhY2VwbVc5eHQ5YkFmM05yL2xGNFVU?=
 =?utf-8?B?Q0pocEhFUWFYTk8raFZvL0I5UUwzOXVZalJMNVl3YmtBZTIwc2FoY3NMVlhl?=
 =?utf-8?B?Y3IydE8rVEJPa0UzVHhUNC9lOE01K1hVS1BKemh5SDhhdlM1RFVsUGdKcGdk?=
 =?utf-8?B?SFVTN1NmakREOTY2UUJJVmJ1NHk3dzZ6ODBIUEhLcTRnV3J0RVgwNHp6ekc3?=
 =?utf-8?B?N3IycFErNklhamkwc1dxQVlGei9kVU16WWZwUjFPM2xXRU5iZ0xHZHJxWmgw?=
 =?utf-8?B?WXF5S1ozTThrbTRWYU5UdFh3UEtYdXRqVHA1dFVhOHNWS1c4bkxzcGlQQ0JU?=
 =?utf-8?B?MnRHOEZPeFZqT1NTRG9KdkJHSzRzKzBsSm00aWtLckxNZjNOSmIxM3lwUkpD?=
 =?utf-8?B?V2VMMDhHVXphUmlrSnZiZFIvdzNUd2ZkZFJJeDdhT0VMSGVTYkZLYXB5UDhl?=
 =?utf-8?B?TzF4MTE4bitOWERhOXlwVkQ0Uno2dDA3bCtXTDRyV21nMkl3RElhaG9weGI3?=
 =?utf-8?B?SW9wZk9zRTFXb2ZJWm1UZnZuemFFeU8xN1gyTFhoYlV1ZlBUNkkrays5WGFt?=
 =?utf-8?B?REZzSlZIenFkSk0rbnpwQmlFT21WbENSdEtlN21wMmZlMkNLOUtSM2xsYzJK?=
 =?utf-8?B?ZktOV1hIVTNvNis5N2JYNnk2TjRjVmEyNVpJWkNJRFFmK0ttNXdpazZaa1Zl?=
 =?utf-8?B?eERLWjA4YmFmY3JraHFlVWt2R1UvbTREUjc2dE10WmtudWx2T0RWMmdLVkRp?=
 =?utf-8?B?RU5FOVowTmh0UklkN0prWmZRNTJ0VURhem12c3NESTcydS9GZFNaVlhWVEdO?=
 =?utf-8?B?Y3VnRlhVRVUvNXVTTHZSNVNsZG1yYUdSUlozc3ovcFh5Z0R6dU9QRUdxeDk2?=
 =?utf-8?B?eUpNUFNCN0ZTTDBWQnUyR3BpQ1R2NFcvM3diR0tLUjkxWElKUlBVUWtyZ3Fo?=
 =?utf-8?B?d0IxRW1oQzVlRXg3S0dTcFlYd3JFc0dHOHU1TFZEZDd5ckNKMDJ5cmVJNEF3?=
 =?utf-8?B?OXFQZzVDQ0pxM0poVjMwVWxPc1Y2Vk00eW93R1VwcDFkT3lXQ3UyS0tmSk5C?=
 =?utf-8?B?WENzaHk1RmtFb1BJN2J1OUV6OG9XNTU0aXltY2RIUkkvTkEvYXRlTzZoRjRi?=
 =?utf-8?B?QkhwOWRDSDFqb3dBMUoySW9oK1NoVERjeGIrd2dLV1VnbkhQVllnMExRTlFh?=
 =?utf-8?B?cENWMnV3cERZZk43aklLcnlSZ2dGL1hkdVZFb1IwNzR3WkxIMnB1TVhZQmpJ?=
 =?utf-8?Q?7OowMhMk56HFm7BM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <706A7047F3749F45A8B437099CF69B94@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JxYDRAYsX5Sy9K/EZZINltku7na3TtIdF9/v8vcCSy2lh/ic8Z93U9Hm2lTKzbJGJgyerUOkZx9GNUinK8/TsbKaxFh26K36s5Dhkxvru8K/9DLKc/3G5R8kwgdy0x2LoivXfUT0IRACw45ceSuF/Z/ppnJHbFehRpnhnWxMmDzZV/a4aCUGMj++nWUucEr9nx9iV16zSJHrWNsx4IMpMx+VdfsmEjcKhY6XJLVoSAoIuGP+8DyOZ8QNdV/cvPt14aI84+07FZFiFkqxP7BXNXxENAPUvV56wEa8oAy2zp8iAkYE1BpwzVqjXr8zQ1EDzsZ8GyXjBK2lnh/3Bo8oWQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aadac3e-4951-4301-e682-08de9aff2d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 14:56:29.7182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMGCDfiNWJfkx62laHlwr0XlAKUStGICsey2lSl0FOUHDcqNu1x4H8B1XYUdCtTkBfrhXktq9XoNjjXeL+Vt4ZxwWCyYqaWDqHgjgllJTX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTE1IGF0IDEwOjU5ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiBJ
ZiBpdCdzIG5vbi1yZXF1aXJlZCBmb3IgInR1cm5pbmcgdGhlIGxpZ2h0cyBvbiIgaXQgc2VlbXMg
YWxpZ25lZA0KPiA+IHdpdGggRGF2ZSdzDQo+ID4gc3VnZ2VzdGlvbiB5b3UgaGlnaGxpZ2h0ZWQg
dG8gZHJvcCBpdCBmcm9tIHRoZSBzZXJpZXMuDQo+IA0KPiBJdCBpcyByZXF1aXJlZCBmb3IgdGhl
IHNodXRkb3duIGNhc2UuIFdpdGhvdXQgZWFybHkgYWJvcnQsIGEgc2h1dGRvd24NCj4gZmFpbHVy
ZSAocmVjb3ZlcmFibGUpIHByb2NlZWRzIHRvIHNlYW1sZHIuaW5zdGFsbCwgZXNjYWxhdGluZyBp
dCB0byBhDQo+IGRlc3RydWN0aXZlIGZhaWx1cmUuIFRoZSByYWNlIGhhbmRsaW5nIGJldHdlZW4g
VEQgYnVpbGQgYW5kIHVwZGF0ZXMNCj4gZGVwZW5kcyBvbiBzaHV0ZG93biBmYWlsdXJlcyBiZWlu
ZyBub24tZGVzdHJ1Y3RpdmUgc28gdXNlcnMgY2FuDQo+IHJldHJ5Lg0KDQpUaGVuIHdoYXQgaXMg
dGhlIGxldmVsIG9mIHN1cHBvcnQgb2YgdGhpcyBzZXJpZXMgaW50ZW5kcyB0byBhY2hpZXZlPw0K
VGhlcmUgaXMgYSBsb3Qgb2YgZGlzY3Vzc2lvbiBhYm91dCBob3cgdGhlIGFkbWluIG5lZWRzIHRv
IG1ha2Ugc3VyZSB0bw0Kbm90IHNjcmV3IHRoaW5ncyB1cC4gV2hhdCBpcyB0aGUgbGV2ZWwgb2Yg
c2NyZXcgdXAgdGhhdCBpcyBoYW5kbGVkIGJ5DQp0aGUga2VybmVsPyBXZSBzaG91bGQgc3BlbGwg
dGhpcyBvdXQgaW4gdGhlIGNvdmVyIGxldHRlciBvciBzb21ldGhpbmcuIA0K
