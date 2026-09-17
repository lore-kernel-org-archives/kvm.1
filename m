Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6E547061
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668740; cv=fail; b=N40X6X5SDH3fSNB6FsIMAKCg9OdLbeykXNK7IuMN+QVKPYon5c2fS7YkzmOvgi3eFDQfXCSMpK+3MUCmL92v55BHtInoaMgnCmnLCa5io2uP6XjnpP2Dl0CvVwRm6VfcAHyt9+BPSvespuOIhrdPLWxvqEytc4fNlqE1A/77o0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668740; c=relaxed/simple;
	bh=CcTk9XKqoi8fQ4bxXQ5gUpS3J74okhLnIKuRbQnoaTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gvd+XTMUtOZ81SPAQPwofsNvzA0LzkCesXggLnKHs350S6BpLuWxMVKMiXxodbykJnMqG0ywEe3H8x7fpkxpObwUDuB41irrVxlzrLHFivaKZnWsrL7IxgUskpH2kuu+iSoscw3af0cqddibV4L+RfLw+ZAUg1gHDMcxcUMZK4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgbNCvZ6; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgbNCvZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789668739; x=1821204739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CcTk9XKqoi8fQ4bxXQ5gUpS3J74okhLnIKuRbQnoaTY=;
  b=CgbNCvZ6EE1RIIlMHOvUdVKQvSnAoT38+MS+kqDYzNH4zpl859kciVnX
   /mDNCysb5/8dOt2EHNtXlwlSvvMPNEY4+hCxYIyE0iBkMv2h53K6Nc+Bm
   f7WhUVZNu0lCcfa61aUD6k7mHhByFMKkMlrYRHahTe6aqS/rNBYg7wyn9
   4d/P/Ymjk/CTmdDqptJisCzLB17sbDD3Q7UQAMSrzC+uLB3ZkYkGdOEZf
   5qYiIeDDM+YfURZynE+pujmDmPiEWBrIML4o52G0aVVxyag+n0/8KP7Pz
   gttL458Rln90u5jxOY8G3zCp352Zp9W8U0/7l6dnnr4wP6vr+yQP11/ZE
   A==;
X-CSE-ConnectionGUID: PjgCjw1RRRiwSTv3fIyTgw==
X-CSE-MsgGUID: 3ooY6xdgTTCm+9dMQR3eBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89057572"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89057572"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:12:18 -0700
X-CSE-ConnectionGUID: DNSmXJK9TtOlbWm7uosiFQ==
X-CSE-MsgGUID: /VzJAOehRV6Ifkfs5JR8gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="275892519"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:12:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:12:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 11:12:12 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:12:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoDKxidqeAHReLfitHzZU6oZIr7IJnK0Khp7MgqpaYitFb9MHt225l2NH/v8C/t+j2HqmcnE+znU0qfP/HBj4XQF1jOQ8Adxe+9Zsf75QQ9lJEnVeAGQPqmrKLgsuo00yW2wuHTR3Lm+hNoAKRHhmG0iOUBtuHxO9qOicROe0JpNsRX5eze+2slmyuNlldpwn6Gzs98d9whIbjIpwFfjJzp5cC+uOiRJ2B8BvEpNQr+AIS1cf0lQBkt0IQAea/TecRvpx9XKoTG1ZFnT4wOGfFiS+tFxqWYXbVAPoIx2WdAxlzhduNSmydtzr81+4DTAy3rvclBSTCnP8R+qXhqcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcTk9XKqoi8fQ4bxXQ5gUpS3J74okhLnIKuRbQnoaTY=;
 b=K8dYrdPGPN7BtZ7PJhZckOvwO+/JUJg224u0DbBI0jQ5/IKj8Nd+LOpMYuFbO84+OHGLbAtnFHtmcCIJcv4jpp7KlF28DsfuFKAH951b9R1kGEzW1IrHGSNvV5eFdQcG2BBYuZ6m41q9mBoM5oQDj1/QbllFfrjvhq54yy+ep3o7e6kjYCfbbPMavtEMwxU2Zk9dKmaAbvxTxsPN+GDOilDvb6len93mizsgG+gzYu8hrulYsinT2YoFm2wbDf4xwWtADgps/ryHmF3WS5anXrd/b0zakSUj+3asaU+CGKChIrc8pP8M5p1CXnV7swqtGoFaeHMlqBNK7AIy/uGvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by DSVPR11MB9694.namprd11.prod.outlook.com (2603:10b6:8:34d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 18:12:08 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 18:12:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Fang, Peter" <peter.fang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: TDG quote analysis
Thread-Topic: TDG quote analysis
Thread-Index: AQHdRXUGnV1D6jtpckytZt9IbBOCMLbRf7KAgAANsICAAAqMAIAAM3uAgAAIGQCAAA/ugIAAEEIAgADUxICAAEy5gA==
Date: Thu, 17 Sep 2026 18:12:08 +0000
Message-ID: <3f97caf660cbe460b8bbaf3f2a72e4b6a3ea83d9.camel@intel.com>
References: <24a751d16ba0dc37aa7774df5739f39734cf9aca.camel@intel.com>
	 <aqrZUZtSZ-YItclT@google.com>
	 <736a9315f3cc3d8ef7079b784bfcc7b014386bd8.camel@intel.com>
	 <aqrtprn5YaMijVdZ@google.com>
	 <dae5a64112c9c949524226c66efac9c669df5b92.camel@intel.com>
	 <aqsfoHzOip3n4zdU@intel.com> <aqss_eQAY7soHRwJ@google.com>
	 <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
	 <aqvtG90zWq6SkU8L@google.com>
In-Reply-To: <aqvtG90zWq6SkU8L@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|DSVPR11MB9694:EE_
x-ms-office365-filtering-correlation-id: 0aefb3e1-346b-483b-db0b-08df14e72ff9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|6133799003|56012099006|5023799004|3023799007|22082099003|18002099003|10067099003|38070700021;
x-microsoft-antispam-message-info: Qj1XS7FO0Q0b1eJRxc+Tx5m3/SovPc05zegPGW/FKxJGS/K/9+CHidNoQH224/borlRK9+YsAdFQScl32c4PvY9R6bN+EmTtmDAyepub3K6VrfKSnGj3l52Yd5dg2/CqzuHCmiA8Nt3EngA31b42I9I7FPIqlv4Qw021ZIF77bCdLPhForao0lCkw51ypvMrsxjxFapfxQ6fTnFyLXzshXuSQuIYLuumRqlzPN73ALlXaazkGTBiXqAE3OQZz6rCpncVqYGLOKyGgBqyNo0BQD8XRA1ujHQ7VAYxUmL2xOlyf/xtFte0wU7iusxdE5gmxWU7AQobZZ24zSgf3aCOQNqjo8NDsf6aoCJWodL7WdZPdKb5CeMz4wVl0MS3gRqRUz9Z772wBbLCzciNGv1dECxqb+dzDOdwwnAbzyiM4wKTMMwi3xWC7FD2DsUHszP7Lsy21PwoMfgNgaKfjbRRV/v6ypfxtDHPt3hcrHnqbNBKXDSwG64Zi2npv5Ut6O5w9lo5jgCtqsqKrMUY0IFTAusGTAT+Mcl6IsTdj1yI/IMrKbzFBTKMbUNlLY85Lw4muSNID2ilJYoBgGPjj8c7rPOTb0ZXg/15a/xdG++nyKSs0Og/3ijuQA+Fh6EtcGuyyvOR77LqqH4b1bREq20WrV3IEjj3KBEYFsQfY/3LlqEtg1cutrL063y6gSSM7KGDakkKga2Av7Oe+6XMMgxiKv3ReHWRexTGsXZ1tcDkFkQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(6133799003)(56012099006)(5023799004)(3023799007)(22082099003)(18002099003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU8zVmJsUVRDaVBTNkJNNEVsK3R2L2toZE1jcFltYytBVFBhVW5Xd0JYWWY0?=
 =?utf-8?B?QlBTTHlOZFpJWEk2ZitLTnRwR1pHZmk2WG96S0oxMHlmS2orWlQ5WU42Vk11?=
 =?utf-8?B?dTVpWHhVVXdKbDQwa2NuYTZjVDFRM3cyREIyZThENFhERVVmOXk3MzNPZVVk?=
 =?utf-8?B?aXZqNmZNZzM1dXNscVdyaTNtNDZLN29JdDNOd1MycUlGc1c5Z09rVmxXemZm?=
 =?utf-8?B?MDkxT2t4alFPQ0NQa0pGOWx5YlB0TnlrSzZjcHJVSit4ejN3Nkppakk0Si9N?=
 =?utf-8?B?aFEvZ3FaL3kvUkRRaGE3RU9kTFlJVGNVdjJxNm1TK2tDdjg5QmpaME80bzBk?=
 =?utf-8?B?QUNuVm5VRXJJV0xPemNzT0JRNmdlMjFXT3B4ZmlaYTUxblAzZXdJOHY2am9x?=
 =?utf-8?B?Z2l6enVDcDZkb3RDaFlNZ3YySHBMZGpHRUdzZFJ1SVdzMFlhV3BRWXJjS3BO?=
 =?utf-8?B?RVA4cmJrWTNBRm9vc2hsOHF5M2R2SnEyOHArOWxnV09zVTJ0em1OdUNhTDlR?=
 =?utf-8?B?bUt1NElYTGxJb251Mno2OGtaNGEyYTNicGZ4a0NpemQzUTBDZDVZVE9PRlFH?=
 =?utf-8?B?WC9FT3RJeHpubjdMOTRaU3NndGJWM3hIM0Q5VU0wRDlsYUJ3aTZaMm5EMTJp?=
 =?utf-8?B?SngrK2tNZk1udy9KNGg4bkw2SXBweUV2dmFObmhqS0pGeUkwWm92QkF0cElt?=
 =?utf-8?B?WEdmSVYvb1dBZ0pMNnFyZUFpMHlSYk9tQzZGRnRJYTh0amY1MnlQcjBXa1o3?=
 =?utf-8?B?QjUweTRCcDE2TlI3Wk8zaWM2UDF1NTNtQmlQb2dMeVhmbnRjKzViY20ybFJX?=
 =?utf-8?B?aWtwVzk3T2h4d2o5UkRyYy9TN0VxMC9SU0xzY0gwanhja1dMaUZNUkRhRTRs?=
 =?utf-8?B?bS9CWEo0UlJVWk9rdG4xdXg4eXk1MGRua0tsVHJVcFRMWUs3YzdXdlF4VkZC?=
 =?utf-8?B?NGRSMWRiZUlyUzlpQTVhZ0RScXhUaHg4aUxiTnZSRlExT3Z0ZjBiYWxZMkRt?=
 =?utf-8?B?dmVVczRYTjFTT1BIWHRLUFF2cHQyZWZPZk1pTDRNYkUzWGsrNEtVOFF3QVNx?=
 =?utf-8?B?Si9OejFONEdkeEhlUlhUTGQ3cGtEeHh3Sk1nUUZZYVVwN1MzVnVyMU5aN0Qv?=
 =?utf-8?B?b3Q1MEZ0WTMwcE5iUVNjSGtRYVY1RmdpaDZrcUtrSDZtNkJER3FNQlFDZlF1?=
 =?utf-8?B?NDVKYlNLTWRkeWU5WUVqWExMT1Fsc3hjU0JKMEZuUmFqbnNpTVMyejJic1hY?=
 =?utf-8?B?ZE9uN21XSW5ZVURXSmNDeVYrbFBlc2p5RFI0ZTdDa0RlSEMzVkJBK0ZEdnBI?=
 =?utf-8?B?Q2xYaHE1emlTZCtMTjVXZzlsOFVGcEpHc3hTTEE2VXRweVJHRGt3Zk9JWFFh?=
 =?utf-8?B?THVNOUN6T3pwaG1DQ3dLY2swUmVpM0RzRnYrK2lTeXA3NFhmaW1sTE9yWlpT?=
 =?utf-8?B?dlBRM3hnWEdOOVQrRTRTN1FQU04xZTBiWEdHNllDbE5Dc01CWDFzU2U1NDFk?=
 =?utf-8?B?NUpEb2dtS3E0ZVZBUWU4NTRoQTJyRTF5WHZpVkhCQmwvRWZZWEhwcHhOZjhr?=
 =?utf-8?B?TUZ6OHorNGdXTGN4QTlxWG1yeU50Q2ZFTVRTc2IyckhoRlFmRXBuWlZHZHhO?=
 =?utf-8?B?OUw3WWh6WDgwYVZ6djYrMjZsbDhSS1A5NG9tK0tKRlRBcWZkaDFnaklGSFg5?=
 =?utf-8?B?bi9TWGZXWVQxU0dXNmxqeHRCam1oZngxMHM2Q2sxV25KMTFNN1VPbjFuSHpP?=
 =?utf-8?B?OU9BOWhkV244SE0wZTd0bGlFaTBMTkhSbmN6ekpZWUVWMmwyUURzNlhRRHBa?=
 =?utf-8?B?SW9PSURBOXVpVUdOaHlydUhCclZpNU5NZ1E3cTlNRkkya29mbFBJODNTcjhy?=
 =?utf-8?B?N1F4WnB0MUcvbXJxenE2VkdGdWVWTlNxdStXZVlkR0ZJdXREZmZyd3VSckhS?=
 =?utf-8?B?cCtmMVlsa21tbmswa1IrWkp3U0lRc0JMVzFmZjd3MExYUzFDV2t4THh4aVVI?=
 =?utf-8?B?OHhmeVRPWHZLUEF0ZVJaTTQ5ZU5LYkFUUjE2aWpGcEJyM0hFTSthSGRBa0g5?=
 =?utf-8?B?TngrVVVtWVFxdldtMU9JbDNFcEgyVVdKZW03V2FzaWpnOUR5SWp2M2poQmpn?=
 =?utf-8?B?ekh3ZzhCenFzcFBTZmZXclVZVFpWTDY5NkJYbEVCZXpRSmdhWE02N0svcHUx?=
 =?utf-8?B?WWFCQ2N5Mm1vZjZua2FORG9WSm5hbGZSY1N2bEFnNGlXa3J2UG5vWm9ZUlcy?=
 =?utf-8?B?WkNCTkRCcnVyZ2c1U3JWckYrWTZGb0tFNUk3ZlF3R2xDM1JRZ3VFZ1ZLOUp5?=
 =?utf-8?B?YTJwczRHeVhMOUNzcnRIN01udENZaitYYkNUTmdEK2J5TnFlblRQSXJyKy9i?=
 =?utf-8?Q?5cav8BT1UqByoMOQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70FA9F182FE8DD4EA845FED595C5790F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JuBG2T2Iib8mIIJTXT218CMYgN+9mpSXKxEcxl5E9mQ43GoTepan3KgSF4qNSVhadsQ4UZ10e0a8dRR2ZNmkImYFi3/hAOi+klC/Isd/SI8S9gC3Cj8zeIHgAQ6K4t6VyT4VaU+IJnlSKrgmWjbUgL60HJv7EPYBBwxie3cosJl5hWPJQHyOkjVtClXhRA3mvt6uxOtf79Be6Kus+i9c4Yz0FHcW437BdvKqxm9npxckltsKTLMo5kV5xC/kz6NZQ/gEaZt7DjEZYV+E54kSg5Njtf4tfxTy/ZWOltr94xqNUK0wddh0anzS5bBdvP+IqRhbQP2WDc7soEU9t8SWMA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aefb3e1-346b-483b-db0b-08df14e72ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 18:12:08.4188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVZrACRG8QjHxnPf2/yQw/J0Aes583xCB5SqnsNr+2U6mDLlSPweTHS+L/3qqS+x5kqVL3/JnMd4ghHxg+jolpPvlCYn1N56qacRKSLkLjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9694
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTE3IGF0IDA2OjM3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUaHUsIFNlcCAxNywgMjAyNiwgUmljayBQIEVkZ2Vjb21iZSB3cm90ZToNCj4g
DQo+ID4gDQo+ID4gIkhXIiBpcyB0YWxraW5nIGFib3V0IHRoZSBTM00gdGhpbmcuIFRoZSBxdW90
ZSBvcGVyYXRpb24gY291bGQgZ28gZGlyZWN0bHkgdG8NCj4gPiB0aGUgUzNNIHRvIGdldCB0aGUg
cXVvdGUuIChIVyBiYXNlZCkgT3IgaXQgY291bGQgZ2V0IGFuIGludGVybWVkaWF0ZSBrZXkgYW5k
DQo+IA0KPiBHZXQgYW4gaW50ZXJtZWRpYXRlIGtleSBmcm9tIHdoZXJlP8KgIEkgYXNzdW1lIHRo
aXMgaXMgYSBwcml2aWxlZ2VkIGtleSB0aGF0IGNhbid0DQo+IGJlIGV4cG9zZWQgb3V0c2lkZSBv
ZiB0aGUgVERYLU1vZHVsZT/CoA0KPiANCg0KWWVhIHRoYXQgaXMgbXkgdW5kZXJzdGFuZGluZy4N
Cg0KPiAgSS5lLiB3ZSBjYW4ndCBoYW5kIHRoYXQga2V5IHRvIHRoZSBndWVzdA0KPiB0byBsZXQg
aXQgY29tcGxldGUgdGhlIHF1b3RpbmcgcHJvY2VzcywgaW4gYW4gaW5oZXJlbnRseSBpbnRlcnJ1
cHRpYmxlIGVudmlyb25tZW50Pw0KPiANCj4gPiBnZW5lcmF0ZSBxdW90ZXMgdXNpbmcgQ1BVIGlu
c3RydWN0aW9ucy4gKFNXIGJhc2VkKS4gVGhpbmsgbGlrZSBhIGNyeXB0byBsaWJyYXJ5DQo+ID4g
aW4gdGhlIFREWCBtb2R1bGUuDQo+IA0KPiBUaGF0J3Mgbm90IGEgbGlicmFyeS4uLg0KDQpOb3Qg
c3VyZSB3aGF0IHlvdSBtZWFuLiBUaGUgVERYIG1vZHVsZSBidWlsZCBkZXBlbmRzIG9uIGEgY3J5
cHRvIGxpYnJhcnk6DQpodHRwczovL2dpdGh1Yi5jb20vaW50ZWwvY29uZmlkZW50aWFsLWNvbXB1
dGluZy50ZHgudGR4LW1vZHVsZS9ibG9iL3RkeF8xLjUvQlVJTEQubWQNCg0KSSBkb24ndCBrbm93
IHdoYXQgdGhlIERJQ0UgaW1wbGVtZW50YXRpb24gd2lsbCB1c2UuIEJ1dCBJJ2QgYXNzdW1lIGl0
IHdpbGwgbm90DQppbXBsZW1lbnQgaXRzIG93biBjcnlwdG8gcHJpbWl0aXZlcy4NCg0KPiANCj4g
PiA+IEF0IHRoaXMgcG9pbnQsIEkgZG9uJ3QgY2FyZSBhYm91dCB0aGUgZ29yeSBkZXRhaWxzLCBJ
IGp1c3Qgd2FudCB0byB1bmRlcnN0YW5kDQo+ID4gPiB0aGUgYmFzaWNzOg0KPiA+ID4gDQo+ID4g
PiDCoC0gRG9lcyBnZW5lcmF0aW5nIGEgcXVvdGUgcmVxdWlyZSB0aGUgQ1BVIHRvIGFjdGl2ZWx5
IGV4ZWN1dGUgaW5zdHJ1Y3Rpb25zPw0KPiA+ID4gwqAtIElmIG5vdCwgaG93IGRvZXMgc29mdHdh
cmUga25vdyB3aGVuIGEgcXVvdGUgaXMgcmVhZHk/IA0KPiANCj4gSSB3b3VsZCBzdGlsbCBsaWtl
IGFuIGFuc3dlciB0byB0aGlzIHF1ZXN0aW9uLsKgIEV2ZW4gaWYgdGhlIGVuZC10by1lbmQgc29s
dXRpb24NCj4gaXNuJ3QgbmFpbGVkIGRvd24sIEkgaG9wZSB0aGF0IHRoZSBwaHlzaWNhbCBjYXBh
YmlsaXRpZXMgb2YgdGhlIFMzTSBhcmUgZGVmaW5lZA0KPiBlbm91Z2ggdG8gY292ZXIgdGhpcy4N
Cg0KVGhlIFMzTSBpdHNlbGYgaGFzIHB1YmxpYyBkb2NzLCBidXQgaG93IFREWCBtb2R1bGUgd291
bGQgdXNlIGl0IGluIHRoZSAiSFciDQpmbG93cyBpcyBub3Qgc2V0dGxlZC4NCg0KPiANCj4gPiBP
aCBtYW4uIFRoZXJlIGFyZSBhY3R1YWxseSBhIHRvbiBvZiBhdHRlc3RhdGlvbiBwbGFucy4gSSBk
b24ndCBrbm93IHdoaWNoIHdpbGwNCj4gPiBiZWNvbWUgcmVhbC4gU28gdGhlc2UgdHdvIGJlaGF2
aW9ycyB3ZSBhcmUgZW51bWVyYXRpbmcgYXJlIGFjdHVhbGx5IGFuIGVkaXRvcmlhbA0KPiA+IGRl
Y2lzaW9uLg0KPiA+IA0KPiA+IFRoZSBzb2Z0d2FyZSBiYXNlZCBmbG93IHdvdWxkIGJlIGV4cGVj
dGVkIHRvIGZpcnN0LiBJdCB3b3VsZCBpbnZvbHZlIHRoZSBDUFUNCj4gPiBkb2luZyBjcnlwdG8g
c3R1ZmYgYXMgYWJvdmUuIA0KPiA+IA0KPiA+IFRoZW4gYSBIVyBiYXNlZCBmbG93IHdoZXJlIHRo
ZSBjcnlwdG8gaGFwcGVucyBvbiB0aGUgbGltaXRlZCBIVyByZXNvdXJjZS4gVGhpcw0KPiA+IGlz
IHdoZXJlIGZ1bGwgcGFyYWxsZWxpemF0aW9uIGlzIG5vdCBwb3NzaWJsZSwgYmVjYXVzZSB0aGUg
Q1BVIGlzIG5vdCBkb2luZyB0aGUNCj4gPiBoZWF2eSB3b3JrLiBZb3UgbWlnaHQgd2FudCB0aGlz
IG9uZSBpbnN0ZWFkIGZvciBzZWN1cml0eSByZWFzb25zLiBCdXQgdGhlIG1haW4NCj4gPiBwb2lu
dCBvZiBkaXNjdXNzaW5nIGl0IGlzIHRoYXQgeW91IGNvdWxkIGV4cGVjdCBzb21lIHF1b3RlcyB0
byB0YWtlIGEgbG9uZyB0aW1lDQo+ID4gYW5kIHN1cHBvcnQgYSBsaW1pdGVkIG51bWJlciBvZiBw
YXJhbGxlbCBxdW90ZXMuDQo+IA0KPiBJdCdzIG5vdCBqdXN0IHRoZSByYXcgdGltZSB0aGF0IG1h
dHRlcnMsIHdoZXJlL2hvdyB0aGF0IHRpbWUgaXMgc3BlbnQgYWxzbyBtYXR0ZXJzDQo+IGdyZWF0
bHkuwqAgVGhlcmUgaXMgYSAqbWFzc2l2ZSogZGlmZmVyZW5jZSBiZXR3ZWVuICJmaXJlIG9mZiBh
biBvcGVyYXRpb24gYW5kIGdldCBhDQo+IG5vdGlmaWNhdGlvbiIgYW5kICJjaHVybiBvbiBjcnlw
dG8gc3R1ZmYgZm9yIHRoZSBlbnRpcmUgdGltZSIsIGVzcGVjaWFsbHkgd2hlbiB0aGUNCj4gdGhp
bmcgY2h1cm5pbmcgb24gY3J5cHRvIHN0dWZmIGlzbid0IGludGVycnVwdGlibGUgYnkgZGVmYXVs
dC4NCg0KSW4gZ2VuZXJhbCwgUzNNIGlzIGRlc2NyaWJlZCBhcyBhIG1haWxib3guIFNvIG15IHVu
ZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgQ1BVDQppcyBub3QgY2h1cm5pbmcgd2hpbGUgUzNNIHdv
cmtzLiBNb3JlIGJlbG93Lg0KDQo+IA0KPiA+IEJ1dCBuZWl0aGVyIG9mIHRoZXNlIHNvbHV0aW9u
cyBhcmUgYWN0dWFsbHkgbmFpbGVkIGRvd24geWV0LiBIb3cgc2hvdWxkIGEgb2ZmLQ0KPiA+IGNw
dSBiYXNlZCBmbG93IHdvcms/IFdlIGNhbiBkaXNjdXNzIGl0LiBJJ2QgdGhpbmsgdG8gaGF2ZSBz
b21lIGludGVyZmFjZSB0aGF0DQo+ID4gZG9lc24ndCByZXF1aXJlIGd1ZXN0IGNoYW5nZXMgYWxs
IHRoZSB0aW1lLiBGb2N1c2luZyBvbiBzb21ldGhpbmcgdGhhdCBqdXN0DQo+ID4gc3VwcG9ydHMg
bG9uZyBxdW90ZXMgc2VlbXMgdGhlIG1vc3Qgcm9idXN0Lg0KPiANCj4gTm8sIGJlY2F1c2UgdGhl
eSBhcmUgd2lsZGx5IGRpZmZlcmVudCBiZWFzdHMuwqAgVGhpcyBpcyBiYXNpY2FsbHkgbGlrZSBj
b21wYXJpbmcNCj4genN3YXAgYW5kIHRyYWRpdGlvbmFsIHN3YXA7IHllcywgdGhleSdyZSBib3Ro
IHN3YXAsIGJ1dCB0aGV5IGhhdmUgKnZlcnkqIGRpZmZlcmVudA0KPiBjaGFyYWN0ZXJpc3RpY3Mg
dGhhdCBuZWVkIHRvIGJlIGFjY291bnRlZCBmb3IgYXQgdGhlIHN5c3RlbSBsZXZlbC7CoCBOb3cg
bWFrZSB0aGUNCj4genN3YXAgKGRlKWNvbXByZXNzaW9uIGNvZGUgY29tcGxldGVseSB1bmludGVy
cnVwdGlibGUuwqAgVGhlIHdob2xlIHByb2JsZW0gc3BhY2UNCj4gY2hhbmdlcywgYmVjYXVzZSBl
aXRoZXIgdGhlIGhvc3QgaGFzIHRvIGJlIG9rIHdpdGggYSBDUFUgImRpc2FwcGVhcmluZyIgZm9y
IGFuDQo+IGV4dGVuZGVkIGR1cmF0aW9uLCBvciB0aGUgaW50ZXJmYWNlIG5lZWRzIHRvIGJlIHJl
d29ya2VkIHRvIG1ha2UgdGhlIHN3YXAgc2VxdWVuY2UNCj4gcmVzdGFydGFibGUuDQo+IA0KPiBJ
dCBzb3VuZHMgdG8gbWUgbGlrZSB5J2FsbCBuZWVkIHRvIHRha2UgYSBzdGVwIGJhY2sgYW5kIG5h
aWwgZG93biB5b3VyIGN1c3RvbWVyDQo+IHJlcXVpcmVtZW50cywgaW5jbHVkaW5nIHdoYXQgaXMg
dG9sZXJhYmxlIGxhdGVuY3kgZnJvbSB0aGUgZ3Vlc3QgcGVyc3BlY3RpdmUuDQo+IA0KPiBGV0lX
LCBpZiBTM00gcXVvdGluZyBpc24ndCBJL08tbGlrZSwgaS5lLiBpc24ndCBmaXJlIGFuZCBnZXQg
bm90aWZpZWQsIHRoZW4gSU1PDQo+IGl0J3MgY29tcGxldGVseSBicm9rZW4gYW5kIGxpa2VseSB1
bnVzYWJsZS4NCg0KTGV0J3MgdGFrZSBhIHN0ZXAgYmFjayBoZXJlLiBUaGVyZSBpcyBhbiBleGlz
dGluZyBhdHRlc3RhdGlvbiBmbG93IHRoYXQgd2FzDQpkZXNpZ25lZCBhcm91bmQgc29tZSBsaW1p
dGF0aW9ucyB0aGF0IGFyZSBjaGFuZ2luZyAoc3BlY2lmaWNhbGx5IHdoZXRoZXIgdGhlDQpxdW90
ZXIgaGFzIGtub3dsZWRnZSBvZiB0aGUgVEQpLiBUaGUgY3VycmVudCBob3N0IHNpZGUgcXVvdGUg
ZGlzY3Vzc2lvbiAoS1ZNDQppb2N0bCkgaXMgYmFzaWNhbGx5IGEgc3RyYWlnaHQgZm9yd2FyZCBl
dm9sdXRpb24gb2YgdGhlIGV4aXN0aW5nIGRlc2lnbiwgZXZlbg0KdGhvdWdoIHRoZSBsaW1pdGF0
aW9ucyBhcmUgZ2V0dGluZyByZW1vdmVkLg0KDQpZb3UgYXNrZWQgd2hldGhlciB3ZSBjb3VsZCBk
byBhIHJlLWRlc2lnbiB0aGF0IG1ha2VzIG1vcmUgc2Vuc2UgaW4gdGhlIGNvbnRleHQNCm9mIHRo
ZSBsYWNrIG9mIHRoYXQgb2xkIGxpbWl0YXRpb24uIEF0IHRoYXQgcG9pbnQgd2UgYXJlIGZhY2Vk
IHdpdGggdGhlIGFnZS1vbGQNCnF1ZXN0aW9uOiBob3cgZmFyIGludG8gdGhlIGZ1enp5IGZ1dHVy
ZSBzaG91bGQgd2UgZGVzaWduIGFyb3VuZD8NCg0KVGhlIG5lYXJlc3QgdGVybSB0aGluZyBpcyBh
IFNXIGJhc2VkIGZsb3cgd2hlcmUgd29yayBoYXBwZW5zIG9uIHRoZSBDUFUuIEJ1dCB0aGUNCmV4
YWN0IGFtb3VudCBvZiB0aW1lIGlzIG5vdCBrbm93IHlldC4gUGV0ZXIgZ2F2ZSBhIGJhbGxwYXJr
Lg0KDQpBIGZ1dHVyZSB0aGluZyBpcyBhIGZsb3cgd2hlcmUgUzNNIGlzIGVuZ2FnZWQgZm9yIGV2
ZXJ5IHF1b3RlLiBUaGF0IHdvdWxkIGJlDQpleHBlY3RlZCB0byB0YWtlIGxvbmdlciwgYW5kIGhh
dmUgZ3JlYXRlciBsaW1pdHMgb24gY29uY3VycmVuY3kuIEJ1dCB0aGUgZGV0YWlscw0KYXJlIG5v
dCBzb3J0ZWQgb24gd2hhdCBleGFjdGx5IHRoZSB1c2VyIHdpbGwgd2FudCwgb3IgaG93IGl0IHdv
dWxkIGJlDQppbXBsZW1lbnRlZC4NCg0KDQpJIHRoaW5rIHlvdSBhcmUgbWF5YmUgd29uZGVyaW5n
IHdoZXRoZXIgUzNNIGNvdWxkIGJlIHVzZWQgc3VjaCB0aGF0IHRoZSBndWVzdA0KY291bGQgd2Fp
dCBvbiBhIHF1b3RlIHdoaWxlIG5vdCBuZWVkaW5nIGFueSBzYXZlZCBzdGF0ZSBhcmVhPyBJZiB5
b3Ugd2FudCB0bw0Ka25vdyBtb3JlIGFib3V0IFMzTSB3ZSBjYW4gcm91bmQgdXAgc29tZSBtb3Jl
IGluZm8gb24gaXQuIFRoZXJlIGFyZSBzb21lIHB1YmxpYw0KZG9jcyBvbiBpdCwgYnV0IHRoZSBp
bnRlbCBsaW5rIHNlZW1zIHRvIGJlIGRlYWQuDQoNCkFGQUlDVCwgb3V0c2lkZSBvZiBURFggYW5k
IGp1c3QgaW4gdGhlIHdvcmxkIGluIGdlbmVyYWwsIGNyeXB0byBpcyBpbiBhDQp0cmFuc2l0aW9u
IHBoYXNlLiBJIHJlYWQgdGhpcyBpbnRlcmVzdGluZyBhcnRpY2xlIG9uIGx3biBhd2hpbGUgYmFj
ayBhYm91dA0KImh5YnJpZCBjcnlwdG8iIHRvIGFkZCBzYWZldHkgZHVyaW5nIHRoZSB0cmFuc2l0
aW9uOg0KaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzEwNDg5NzgvDQpOb3QgdHJ5aW5nIHRvIHRv
c3MgRlVEIGhlcmUsIGJ1dCBJJ20gaW1hZ2luaW5nIGFsbCB0aGUgY29tYmluYXRpb25zIG9mIENQ
VSBvcg0KUzNNIHdvcmsgdGhhdCBjb3VsZCBwb3NzaWJseSBjb21lIHVwIHVucHJlZGljdGFibHku
DQoNCklmIHdlIHdhbnQgYSByZWRlc2lnbiBmb3IgVERYIGF0dGVzdGF0aW9uLCBJIHRoaW5rIHdl
IHNob3VsZG4ndCBmYWxsIGludG8gdGhlDQp0cmFwIG9mIGRlc2lnbmluZyBldmVyeXRoaW5nIHVw
IGZyb250IGJlZm9yZSB0YWtpbmcgdGhlIG5leHQgbmVhciB0ZXJtIHN0ZXAuIFdlDQpzaG91bGQg
ZWl0aGVyIHN0aWNrIHdpdGggdGhlIGN1cnJlbnQgYXBwcm9hY2ggKGd1ZXN0IHJlcG9ydCBhbmQg
aG9zdCBxdW90ZSkuIE9yDQpkbyB0aGUgdGhpbmcgd2hlcmUgeW91IHRyeSB0byBidWlsZCBhIGZs
ZXhpYmxlIEFCSSB3aGVuIHlvdSBrbm93IGFuIGFyZWEgY291bGQNCmhhdmUgYSBsb3Qgb2YgZ3Jv
d3RoLCB3aGlsZSBub3Qgc3RhbGxpbmcgdG8gZmlndXJlIG91dCB0aGUgZnVsbCBmdXR1cmUuDQoN
ClNvIGhvdyBmYXIgYW5kIHdpZGUgc2hvdWxkIHdlIGhhc2ggb3V0IGhlcmU/IE15IHZvdGUgd291
bGQgYmUgdG8gbm90IHdvcmsNCnRocm91Z2ggdGhlIGRldGFpbHMgb2YgYSBmdWxsIFMzTS1ldmVy
eS1xdW90ZSBkZXNpZ24gZm9yIHRoZSBURFggbW9kdWxlLiBMZXQncw0KanVzdCBjb25zaWRlciB0
aGF0IGluIHRoZSBmdXR1cmUgcXVvdGVzIGNvdWxkIHRha2UgYSBsb25nZXIgdGltZSBhbmQgaGF2
ZQ0KZ3JlYXRlciBjb25jdXJyZW5jeSBsaW1pdHMuDQo=
