Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7D19343E;
	Tue, 24 Mar 2026 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389843; cv=fail; b=Qwv0HioOBv+57O9ykwIenC/Ci3TSD3VYf7GdIQBhkkfg3JEk3HDeiwq4bSXYxQH+Acty3FGOx9n3FGQsRPl42v8Py1C7+77euJjaltfvGB0X5GejMtfCHD+PpYHLbKMOY+1zhmmTp1PHVXe3QyD7SGSIjF+Rj+F2IMxPkJ4trNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389843; c=relaxed/simple;
	bh=FU2f3wxLpCN0w3nxyKQ3SsDwyN78Cw8dP+fGCgGrXIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bsaA/EqhP6lz+gLjIkiNurgprGRcrCA7CpxTjMDpIR6DMf0bBCJjwmQZQEhF8HhY7ZPJmIA/lYcSfsm9p8DuhNNCnDpUn0EEqIHTAY05NUjMCc+/c46jWsfLYXkyIM3qeT8OLDIdl9a3V8ag8Kxc57vSNfEaBecurjCQScwGG8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ph1luLNF; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ph1luLNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774389842; x=1805925842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FU2f3wxLpCN0w3nxyKQ3SsDwyN78Cw8dP+fGCgGrXIA=;
  b=Ph1luLNFzv34CpmS/j0j70UiH9ktgATj4gjTQl4Z5knUdwORTGI+rrn9
   7jQDoP/wQ4OkZqWQ/G/vslx2YI6FQ5LJov2QuqrLghQNCDrS9oaIGXwz6
   xY06bOMQeBWoNVXWuvsMiMyml0lx5aCUlVLoX/2jwc/+Mnmpvyj0aLl+w
   N/cY+gcGcnvw8eOupZq++EGHT0pRIgmx8p1BOAI227i04myKaTKL7fuAM
   eMcvurYaSw59QHdkBmRxNbB9MV7ueadgGVPpUfPELlc0WfOzjTQR+flK9
   V6jmjmrKv/Xb1tV7ZLspPVH2VCcd8uNGSukU+Fv7dfRwhElgNORp7dEZQ
   w==;
X-CSE-ConnectionGUID: xxiGe6wqRTKO8NXauee29A==
X-CSE-MsgGUID: xE2mhS/zRiO8TYhXOKfjJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="78020641"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="78020641"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:04:02 -0700
X-CSE-ConnectionGUID: 6NIUADOVTaKN3qXGBb8cSA==
X-CSE-MsgGUID: dlD4PhllSL6xXYmZIjTsJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="223692500"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:04:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 15:04:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 15:04:00 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 15:04:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAb5YZY+eVIpH/avjqZtPH6P3hTf+mATf5uigUYKRQSutaz8JrKO8kpSGM3D3/CP1VIVgUwPXtG+xnIwowqrgoLox998Dvc4Uv3AYGTbbO5t1TOsqJ9Jl3aN9hxzWzAa17ZV5u93hBCKr0kLLMxMWzfiaxTGzQIedYrhN+VhWnYF45vFy3ClX+xYpoC+2m1syCWuakdTkU37XAbI384LnlvewkJdlr20PgKru228zLMSkv0IhYhrL/15kjyw8oxe7GtyfTgG16M6A9T+RqRc2d2SOz7vYI1d1Ko0Z9BlC2gv4f/JpcOta6+kjjaAL31dM++8b0r3JIssdDhIwK30nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU2f3wxLpCN0w3nxyKQ3SsDwyN78Cw8dP+fGCgGrXIA=;
 b=cB8vk0JpOawxsM1jV4Plm4NO1FLXSLHdDtf7yBmW+6TJlDcU+com0k93yMtvOjuP36ClXipJYilNJNkMKCoVl6LwC5DbilP/H/Yvkr6fIx+rMEDjEebYdhIJHwZ09O01uPphpEZ2zINE3C0byBoAzMAY+gguBeesAapqROsUa/ujoTiP7gDHN4xOyH+JPwx0CocgkxN/hABl2jbhW1rGLfYhfCFZvBagctC1dFaEOTH1NUm9nqFgts8B7j+GnbQp2JZFoKpThFMemU/HFYR+OHeBG6rNRPagQjBdNAp5m5RGmteX3zBASFAFiejmdtJAKQaWBAUEGKmNrGHV/sUHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB9880.namprd11.prod.outlook.com (2603:10b6:510:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 22:03:57 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 22:03:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "bp@alien8.de" <bp@alien8.de>, "marcandre.lureau@redhat.com"
	<marcandre.lureau@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Qiang, Chenyi"
	<chenyi.qiang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Topic: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Index: AQHcu6ISxXKhFiWKBUuIm+vE1xtYKrW+PPMA
Date: Tue, 24 Mar 2026 22:03:57 +0000
Message-ID: <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
	 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
In-Reply-To: <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB9880:EE_
x-ms-office365-filtering-correlation-id: f81b652b-9ad6-4642-0ded-08de89f13f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: krZD/M0vpJDQkYrpkm0DkA7kjAFc3BhKLIHdsp8IBtAIMmSxC8FhwBTH6s8N55HXyoGLC6ZIBvBG36IEMFgUH67cL7HcnTvHfPEtJ+PNH7bvhOnoYm3qaE47fbD+BxogHYxwF61dbks3TO1uTVd87qmnbO5kfQ6EOjzEqCvCLItzrAW7luyvRenqN40kRQ+zw7ZB2B7z+jd5ZEaaWbBiDSbLEq6K7fEI0mUrlM0h7JiqhQCwttoP4tfZCjDdCEO1bJ7AF3xnXuAWP9U4p1gTqj2A5fIzI0X0BXZs+qQ1N2AZd0pnxVYsWYFpCyK45N4ao/leDfxSSwrREsKWOeWanhaAgPOn5XtkC5XdKM+GYVviqk9ODIC5FJTHck+jDtouexUS9o7E9vgn0H4NKMGkZVbV1TMaPi+RhF/D3/zodSpdQiEI1V/vpWyny8hAekZASEbwQBmL2YLb+hIfOyCXMd29py4yshEuw3b8XtU6v0YoJQ516NNjprK4Oq95Wu6e79b8rbG1KsqPhLShYdNgVzpv9x8Xebu7fs2WVqcPDyx+ksN7MpEVGkic7+tdqz+CCQ7d2hBZ/rQSENOznQognH+7DOcrWweFM8yaIQThO+mPs9B/ZXiMcOYxuawrxquDL48KfOcsBKUe2V1NIXdqDU0ei5yHWahFtK1v7Qnqdeu5zK1h+Vy7ghwc2PstwwuoUaYa6GFIun1LSDIRTITnAMz1mPNd9HbRXZoPu67bVqB/kcrlNL8H4t9lulR7HB10jAEV6EMMrXpQ3a9W+9+cz/e6rWbZsbRjJDxj+XvEUi+ip0sX57YrP6e4P5KF6Npp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0Ywd1N2QUdHYTFvbGw5UXJObFIrdUgrZXFIQzlqZlZMTFczMlhJQzJ6Lzl3?=
 =?utf-8?B?OUdWV1Z6SGdFc2VYbU9oZkM1UCtzU2Y4M29FL2lVbjB4RVhUTUh4b0ZQTXFI?=
 =?utf-8?B?VGRKcGpRM3pmTXc5NlFVSVE0WER5d2ZXWm92NGowV3JkVWFjSmlTZjBkVWxh?=
 =?utf-8?B?NWVWc1dFWXVxZFkyRGxuOURxanhydXVVazBrQXQyKy9YSTMwUmtGdUg3ZHd6?=
 =?utf-8?B?YjVheTBha3NGYUlqbW95dnBKVDRTRjFJNis0MWlmUERsOUdWYkVneUZ6RmNR?=
 =?utf-8?B?SEl0ZVVLY0RaNTRtMGFyVHRnRU9Kd3IxVEJlZkhYUitueVJVTXU0Ukl0L0xQ?=
 =?utf-8?B?R0xzZXQvYUJNdjNCbWJOdnlwQU5EWDBsRGs4bXVSc3l1TkRYd29DTUwyUnFP?=
 =?utf-8?B?b1VXV01iU25vZm00M1RIT2VYNFl4anF2Z2cyNUdPblpORnU1MzFkL3JMb0Fq?=
 =?utf-8?B?ckY1ODF5OEhneGtqYUJHa3ozY1ZuZXFNZEVpUklOaDhtUTFjcmJOUHZ0blZn?=
 =?utf-8?B?bUNOV0E0THN0K2x0TmpxeGdIWjJFTzFTaHlodi9xcmdQYSs4OUx5OHc5dDNn?=
 =?utf-8?B?RzBsYjVlSEdBUXd2dnRHSlBWZkRtWE1neXN1UFluTzdXRTAyV1B2cWxqN2No?=
 =?utf-8?B?SDdLdDdNK21CYmxRMHJ2Sk13M1NXU1VsdngydzV0QUwvVWtWcWpwaDJUUEF1?=
 =?utf-8?B?WVJUd0kwbHhXTXpyQXdkbEZvQkZEWm8rRDVNdG9ZNEQ1Y1U2TXlOTXU2S3J6?=
 =?utf-8?B?L01reFBDaDYvRHVwNGZsUGc0c0JnWHVEUGNRNDVGY0FvSnhpNkZ1bEUwUXhP?=
 =?utf-8?B?Z0NrMEdXRmxsU1JRWHFqU2xLV0ZSVzRZeUg5YkdXOGhpcFFudWYvN1dsTEZX?=
 =?utf-8?B?Z2cvZHJiVUxyQUZEdTl6YnEwZ1doMGwwMGlBMWpRMXZyd1FJR2xWWVhkc1hN?=
 =?utf-8?B?VGlraFVzbEdIYUV0SXZuYlluMmcwUlRRbmJNSTBmRDdHeXg5ZFpqUVZsd2lM?=
 =?utf-8?B?eGJ2eGR1VVRmWmx3aEhiVzRUbGhFa3Z2TDgzWEhaLzMzZnd1TEJZLzhFeDda?=
 =?utf-8?B?NXIrdGwrZ21TdEZOakplVEM0V2U0bDVrUEVLL2tuRU90S2t1SytmRzlQUW5Z?=
 =?utf-8?B?RmMzNm9QT0Zpamtxa2NoS0YrYUt3RCt0eWNvVW45ZGZZUXNNU2lnbm9zdDNt?=
 =?utf-8?B?UWlJcTJTVThkLzRJc3FacSsveFJhQ09Cc1BLby9GZmxxUGtWaTVHZGdCUjYy?=
 =?utf-8?B?NXZuOVFSMER5NDhxNWxSREE3SWREb21TaU1DNXhvd1RDVWl4R0Q3QmpDTXNZ?=
 =?utf-8?B?YlI4WW00S3JxV1kyQVZGLzRmZElqODdJRnJhK0lPLzNmNmhDL0RyVjhhQ2JE?=
 =?utf-8?B?dWpkZTBlR3hKQjJGek1aa0hYZkdQNnQ1T2w3SGIxd2xySjBiVVZYUzVqVGhw?=
 =?utf-8?B?d2tHWk0zcmRncnkvNHZRWVpOK2k1eTRvMnpTb1Z4TUpBLzlWL1o4RlcvSllk?=
 =?utf-8?B?M283d0hkZzBwRWhmaVJ4cUpUZXJSY1YyL3NzcGkyKzVBQklCb1ZRaU51MnhD?=
 =?utf-8?B?NjVuTFBRaXN6MzRyYVFha3NuTGVOdjE0ZlZOd2IzTzQxMG96V0lPSXZXbWdm?=
 =?utf-8?B?bzM4SnliRS9pQnY0dkVlU3RKVzlqUTJmYUdhTVZPYVRZbWFyNFgyRkYxZTZP?=
 =?utf-8?B?dXRvQmJKQUVHa1RBaW0xT0xrY3I1SjdIbi9EUnM5aVY3ZWdjZ3YyaDFPa3Fs?=
 =?utf-8?B?ODJpem1YTFNPL2NLaUNkS1N1NWZBRGVEQWMzMXY5NVdmeEJYS3pRQ29Nc3Az?=
 =?utf-8?B?YVBIOVR4bWRFeWFPdGU2eFQzakRvWm9wU2E5UWx4cEVSZXE3cnFMbWJjQkM0?=
 =?utf-8?B?REhsak5kK3dwWE15SzFjeWhJUkoxcTdxVE9KN0xDNG95VkpDb2FRNlc1bm5E?=
 =?utf-8?B?NlRoNUxvMXM4UEhLZzdRR21DdWtSZm5FMjBWdkNFMHhrVlU3T2FpRnFRTmNX?=
 =?utf-8?B?Y1h5b1FXeW1NczRVZXkvSjVzMmpLbnBlbUxpcFJ2TklMamdIcFJMdFRYclo1?=
 =?utf-8?B?Tmhud1FLWlN0REtxZ1BXOCt2cExweGgvL25zOUlOWXJSSmNnWHhyeW9zekxm?=
 =?utf-8?B?c09SUUlNYUpmd0pua1YxdnRiSHNQUkVpNDBSOGpXTUNvczI3SnNkZGcyVS9a?=
 =?utf-8?B?S0hmeEJWR1g3c1NBZTQyRzVqRTYvZVlMYlgyc002ekpUWVR5NjQ5ajRCWU9E?=
 =?utf-8?B?V1k2QmlmN09aeU1taGNuQ2tQMUxZNzdBTkpkQ25sdVlSYmZEVUhHakR0RVdn?=
 =?utf-8?B?RnhvTFdNeGNVSUZmWVE5UTRHUzErYWhxQ1FMcFh6bExOMFJMR2MvZytEcms1?=
 =?utf-8?Q?TnCiD3nJDcI2bP/M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10671101B9B4DC4A9187725F5AD94A55@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qmblaGmK/uRLBbvNZlcasmoJl9V0qfJG3aNvgMOq9SwtjxVqfr0c/rJ69Q3sQtFnkNbFYw/sPbL3BaVxDNsx0pT59mwOsLrFmW/maeuIrM/BznIeeZ3KHvfqbje19cnajlaJLFk3c0aZ/pWiLahpeE2/ST1dHuNDbfPXLKBMx6O6l6ReiWPQqxSbVhKD3GGsN0a4XvkblcRegNPk4GkkGVLOlL3QFkMkiwNDeuI80qjfirjiyLGxOFPSJ2eV19UeTBYLmpDigXTP6FfmCpJKTP2wuxO4CJ9ie/4Z2bGa+tfO3Kw3ywOp3IB/fAKr2VGvcgpgZ487X068roVcnJpCgg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81b652b-9ad6-4642-0ded-08de89f13f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 22:03:57.1260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8y/aybdkgSskW1Be+6vDD48tCvXYq3xrbmG8awqTio/zL3UWWEb3U2NofiU3l/tXrNoL/p2cHyA7KJrpld9sZye2eQoSD6Enf0gN/HzuyCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9880
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTI0IGF0IDE5OjIxICswNDAwLCBNYXJjLUFuZHLDqSBMdXJlYXUgd3Jv
dGU6DQo+IEluIFREWCBndWVzdHMsIGhvdHBsdWdnZWQgbWVtb3J5IChlLmcuLCB2aWEgdmlydGlv
LW1lbSkgaXMgbmV2ZXINCj4gYWNjZXB0ZWQgYmVmb3JlIHVzZS4gVGhlIGZpcnN0IGFjY2VzcyB0
cmlnZ2VycyBhIGZhdGFsICJTRVBUIGVudHJ5IGluDQo+IFBFTkRJTkcgc3RhdGUiIEVQVCB2aW9s
YXRpb24gYW5kIEtWTSB0ZXJtaW5hdGVzIHRoZSBndWVzdC4NCj4gDQo+IEZpeCB0aGlzIGJ5IHJl
Z2lzdGVyaW5nIGEgTUVNX0dPSU5HX09OTElORSBtZW1vcnkgaG90cGx1ZyBub3RpZmllciB0aGF0
DQo+IGNhbGxzIHRkeF9hY2NlcHRfbWVtb3J5KCkgZm9yIHRoZSByYW5nZSBiZWluZyBvbmxpbmVk
Lg0KPiANCj4gVGhlIG5vdGlmaWVyIHJldHVybnMgTk9USUZZX0JBRCBvbiBhY2NlcHRhbmNlIGZh
aWx1cmUsIHByZXZlbnRpbmcgdGhlDQo+IG1lbW9yeSBmcm9tIGdvaW5nIG9ubGluZS4NCg0KRG9l
cyB0aGlzIGRlcGVuZCBvbiBwYXRjaCAxIHNvbWVob3c/DQo=
