Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7862E173;
	Sat, 11 Apr 2026 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775870638; cv=fail; b=qWHDLtZLz3rhNAYhqQyOBaIzVECO8llRltff3agm+nRUUCZwwYv9hRlP/qJVt5YSZE8gdQFE9GSpFU9pi4K8BDBOm1Lls75x14WqgN9IB/tfPnRb9OThbHGlE5xILiZxRQqDISKz7nHnkjhJciZllr5zWCco660sqNDLb/V3Aks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775870638; c=relaxed/simple;
	bh=b6Le4dt3rAzQefWr7VdlQR0E1oRlqTqkeDBO9wrHW5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eVkIR0wctoaM7TACVqIrYdrEWpcY4s0XbAPirtQNKqbISVjqmTNRcqKOxNX5xkepE1w01ZvxCvXXfrREJQPgQkIS/5WwPje1QB9KZ/+pzeEGbdc+J1eZ8osnjPFh2mchFlanceib2hlzifV3joWHeqHQwmKWZuwDY+RGhVNuoEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxXiYk7D; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxXiYk7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775870637; x=1807406637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b6Le4dt3rAzQefWr7VdlQR0E1oRlqTqkeDBO9wrHW5U=;
  b=MxXiYk7DqS2ZSaOPEyh9CkRBZmCjMKdCHz8W3Fk1RDFfm4+O/Eas36jo
   5R+JIZFG+XzmppmgZf2nwp1utVRzCiPOWdxDh1DUsqjDa/Am6Zs4Hf1Er
   1ec5l72YzLdDB6VqhfamZC6mK4gpLbWDwlLPnd9beiZ00yhhBhYs8RPMV
   NTbBtTeyfZav7ZvlAJfEYpK0UpSF+2oFyS7Q6V/zTslS4l+UWnLsR9/i6
   W67i22guvrPW7slgNEjs88XtMPS/B9B9u2itIdtgeX12V+FDbkf5pyg9V
   wVcpjun1ukZj//kVqKvRrL6k455CV3gZPqr3CJaRhjj5Y7Gr+fg+o5itn
   w==;
X-CSE-ConnectionGUID: 5PZKXsNXQQOP6GyhPF/W4w==
X-CSE-MsgGUID: vJxxMCUuQDadft4BdkvYMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="88338117"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="88338117"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 18:23:56 -0700
X-CSE-ConnectionGUID: D2vRWctMQo2sR0nYj+J10w==
X-CSE-MsgGUID: F3a5earARoybos1nhd+djA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="234237355"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 18:23:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 18:23:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 18:23:55 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 18:23:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUikOL2CZC+Nw1QTGpZAxUTgTyY+egoB3PfQxefhM6xYztP8pd3nwDcekj5O3wjOpHH3jKqE41hYoGCVKicYfP6KrecvMESbCttaGYQxXTeEvSjw5L1o8nfklUiBVjvWpCqunD0lkHkopccmoCS3yEJ0hemLG4ZeY5PTlStR70oxwPvZt44Se8YnM9P6odi03iK9OZd5nwbFZ1k0vBLLL1teHhzTNwli7xOFuuqAnbZ4G/cTCU3sFl5sjIn5xLg4VCw/fKUIusmiThdqQrHsP0/YMXbj2exfvpfzU6hthM1XNrP8Up4lohwpu+LUnKxsvxlQBZnkUDF2JIhOnMyzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6Le4dt3rAzQefWr7VdlQR0E1oRlqTqkeDBO9wrHW5U=;
 b=Y+Zf8ytkY8n5CQBmFvzMP6kHFV8tL4mTSICS0NmhtGSRWtfKyMWliRReQbowj3cmKsqKaxDsVc8amyD3ygyCwEBKkx4FyZmE9CQBnv9M7LeobsxluP6OlBpMl45jkbwEwcZcx134QfqhgbXnFGgAUCPKzfsjE8DPhMHtDQ7STpFXL1HBhDFWCp1SVUOfyhKEVqdu8YWTG/sxBKfaPy4DzYC792p0GIkqZUDKrMvstHUDlx+JLuDzlDSOF3uYuG2vipB8NsOMW/Up72RdeQAd5ZsIPNfOBRAgPhudEsCsI7iy1jNHOXZK4v9OK00auhAB64A1AbE+QA1qN3NRi+r+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB6780.namprd11.prod.outlook.com (2603:10b6:510:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.15; Sat, 11 Apr
 2026 01:23:52 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Sat, 11 Apr 2026
 01:23:51 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 09/22] x86/virt/seamldr: Introduce skeleton for TDX
 module updates
Thread-Topic: [PATCH v7 09/22] x86/virt/seamldr: Introduce skeleton for TDX
 module updates
Thread-Index: AQHcwQv/p2duQNls3kS1uvAt2nIa6rXZIZ2A
Date: Sat, 11 Apr 2026 01:23:51 +0000
Message-ID: <8bdf05f851f50adc989d67b7d7a825a2b8b1c69d.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-10-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-10-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB6780:EE_
x-ms-office365-filtering-correlation-id: 4ce5bf7e-cf38-4337-d733-08de9768fd7e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: juGYr9TeNVqYJeRrOpQaOhnMJ9vsjQEdYXBVKtwRRfCizfPBgj7stojeX51w7sO7V6wLO7/HlfTX5QGW/8kP3iv/F2qCKkKFsK1BKmf+iME+MlA1o8ndnFBLbXasfcJFUNdFyvBL1EjkklBcKSu1wD1RZYRG+lJf2hf4a2Y2jUx7PS1aX5IMbPRi4RBFEF/DUW/Rqlhy/I3763281fSR7QZtgj8B+0cpE28ZvJqbW+oqhbLg03Gd9nAxlvAt3663pQcEBBza/dxsl5XGvu78i/UHO+W8j1SAMQx8PBJ1HxkU98sgVRjb+puiICqjKuSmDp3H2lG5InkMFmuHqA9h5eYFhClnnXzPItSPxgtX15ghrGgw1jqVArxAquU/exXDdhHVW47M383l2HtA1iHaia0g+BcwfMZlrEwnXuXzsAUxfYHAd/NjFFxlXDN0i31bKg6lVCPznJV7SHGO3RaxfzGsun/YIf8htAKKMIFL6TwBbHmHhmBN8K0g0kJLneOMsC3Zc/7r5thhAzuPI8ST13/7t3OVU4PkjEkgI0eW7ITtk61hkNYhvWPL3ghNrtBZ10dARlFL6pFzXDn6wT8/2dxcpyorwPGDypiSOabcHB4ZNsfJKOw7YIE91ry8eWPfNHlIizqBQwoBJmZwyo6purCzTydOuIuugwNfn9V2kgTM61nx73ArGWRE49LTNpczQrIFeegihxh/Eu76lOQ6Vy0/tpuL0s/Es+qbMLamdku7EeyQ4es2SsDV3FXUc73nwu+mv4LtfTFJ+2meCugHAA9Jx6obe0VY7t4EMUPZoAs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1dYUTQrdG9UTGlvMDNlNXd4bXVJVnpjSk5oWHZwbG84Y1RiWTJqVDJDM0U5?=
 =?utf-8?B?aVpmbjJXRXhGWXhSc3lKMHdsUUp2NjhnYXgzZzFEQ3FTalR4MVlMU3A3OUVU?=
 =?utf-8?B?VjlybUtyUHdzcGt5SU1NMGRIWGRHbUVZazl4TEVBZ1ByeHJ6eHg4am02Ykg3?=
 =?utf-8?B?Q0tkNXk5RklzNVBQMnZqSHV3NDhHQ2NveUcxK284dlJEakRYcW81cEpwcndP?=
 =?utf-8?B?VWdkMTdPMEgyZWhwa3FlTTRNelBXY0h1SW82OWxyblB1bjJOL1kwbDF1Um5T?=
 =?utf-8?B?Z3dEUy95SklaamdCSGxLQ05WV2M3YXZzYWhzL2pmRWx5aE15czg3T0FCdXN4?=
 =?utf-8?B?UEFSM3F0OUkrdnJpL3BiczA1TmVrbG9SR1V4UVJFRHBZdytaYzdMeXZFdE95?=
 =?utf-8?B?bmVxYjJuTXJEVDRHOUxPUTN4amhlWE1FUU1EeUoxdkxjOUtVdHdNemlpRmlp?=
 =?utf-8?B?YmpYbTJZNVNKUWN0YU5zLzdFY1B3MXVQZ0JDdXM0VGVNSExrV3RyWkNjWnZE?=
 =?utf-8?B?Y3YrQ1lpOTFoc0dlZVhpREhWM3hTall6c1VpdWNZeXhxSTNYRGlqcTMzMGdt?=
 =?utf-8?B?Skhlem41U1RRRHFsaitoZFF6aTJZRUpvazdUR0FGVGJSSUVpWTcxbEhMM0xC?=
 =?utf-8?B?ZHBTNk9RdUpaMENLYXJ4ZEMrZU82MU01N1NhcGdUTHFTbnpHaVIyKzV0NkFl?=
 =?utf-8?B?SkJFTFhOSGZudFptT2haVUxyQktDK0dDZWwzcnZrSWFRMDZjbkRNbkpId01w?=
 =?utf-8?B?SHpoWnNNNlpUSWgxbmZPY2U2d0FYUFRzMW1VRnR0QURISDhLcHAya09BRzJT?=
 =?utf-8?B?QWVOcWJqM2pYeGRrRnpzRFF3eFoyM2ZZWGczNlhTd3NjODNoQndMbDM2MVA3?=
 =?utf-8?B?YWorOHNhTVBNcytFd0tQSzh2RlNlRTArU3kxMkxudmd2czJKM2tTYlYrTEd2?=
 =?utf-8?B?aW55cVJ5NEJ3cFNBOGhhMllmVnp2SE05cy80UENIZ0I4SGtWQU5TSnhySkI2?=
 =?utf-8?B?d0dWTjA3L1lzdkRUdG9WR1V5Tnl4OTZZK0JhTWMzaUlHMXRJUlpCSkR3ZjFk?=
 =?utf-8?B?c1ZFNnB3dFBqaFNUVWxOTGNXdytVa2NpYkRMSm1VL2llV1JHQVJ2TThlcWtm?=
 =?utf-8?B?UXRsdUU5SGtKL0RONjVWQW5wRkRKeGxLL1JkMmNxKzBwL090K2twcDB3OVJD?=
 =?utf-8?B?bCtHTXBueVNuVnN5Tm5LSUc3Y0VuVFphcXRiYklYbTZWR2VsUnZHYllBUnNl?=
 =?utf-8?B?RjZHYWhxZFpTdHZnNURDbmloYys2S1VYV3FOaXQ4RUE4WjBQaUtiVEoxeThr?=
 =?utf-8?B?OS9oRTJBa1V3cHFCZUFGWmFZQ0o2RWhhMmtkbmRkNXg0eEVLU1JYMmgveEx2?=
 =?utf-8?B?LytMTWtqQkIrbjhGTnNOZVZYL1lGQzAzWnowOHY4b1VqUzFiWGtKNWFGTjR4?=
 =?utf-8?B?WmEvYUtka1BLVEVyY3hsN3hyMjd5V3BtK01QdjUvUU5uSVJMMjZ6TW5CVDVW?=
 =?utf-8?B?ZEtydS9VemMyTlJ1Q0xUdlJrNUsvVUM3c3NkVEE2U2p6RzRZWGZ5aHRNUzNh?=
 =?utf-8?B?TjBYS1hTN2FkODhvVlFadTdmT1lPM1p1TDd1RTQ4U0w0dnVyV1VqZW9KdGFH?=
 =?utf-8?B?ZEg4ZitNN3pLbjhOSTJIYkRtc005UitGQ3ozOXllNDBCd3J5Qm5ZRXFVY0Ir?=
 =?utf-8?B?blhLVlBOYUpwUkRvdllOeHBxVGdMcGVjazd2OWJmbUZ3dm5TU1o3L09CeDBW?=
 =?utf-8?B?MjdxOXB5K3pwWENxMkhZWnBOWVZ2T0lMck5CQWkzMEhhRHAwOGZydjY1YnVP?=
 =?utf-8?B?MEgwVitzTGFMN3pCSEt3cktFU0dnb3JRV2J1RHFmVmJyakIvYXh5Q0ZqQi9h?=
 =?utf-8?B?R0Npdkw0OXdCWDRDdmlsZU9xNzNrVE5xLzRlNjZvVU8rSWVQaE9jNjRFUnhN?=
 =?utf-8?B?WnRiZ2NrWHgwREM1VTQvWnpJeFRDem9TMlFIaVdLKy9Lbzl5MVB2cm5MeENH?=
 =?utf-8?B?T2pUSzJ0QkFDeTdQQXd4RWRjS3dXQ0tiTjdQWkFYRS9PVXExaVk1UVlEb0tv?=
 =?utf-8?B?ZTA1L09iMGpvenRVcHVNdmhoY0RTTGxGeFprOUxCaUZhUERjS0lrRE5KMnlP?=
 =?utf-8?B?NUtLdFZIcjhlc0V0ZUNuNS9oVFRWdnc1Tk5MSVI3QUw4azFPVEx0YlRkQVVL?=
 =?utf-8?B?NTZVS3J1SG1sYlRSN2lqZ1VOQXN0YTNTWnNmek1lbE9JZzN6c0c5YW5GQVpC?=
 =?utf-8?B?Nkw0ejZwekxFeW14OFd2STgyYnVFWXZmK2ZiQlNSM2xXNUMxUG1zbVdwL2Jy?=
 =?utf-8?B?T0t1bVh1MEg0Z29PNStzQ3BtSVN3KzhOMzAzTGxyam9USG5xQ2ErVUVnUThY?=
 =?utf-8?Q?IEd4u+NQ/KJFewg0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F15294970C4B1459D831758E48A8BDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D5m/IS/CvGTcZb+EddjbpWAljtP+L5iLi+V6M1i5DlXsUWzkMhxRSkQGse7571OaZsuUv+0Fo2uZN5v9bGOKOOVXNq4E+SAjRAW9MaYHG0fHlzkQfr6X3VlEhU6nOsnxEFmvFR0rvgAFSE/eSXo9/qdZFAz/o2IY6Z+AU8zd7OlOK4TxIqz5WQwa7E6o4hkGQ6fHfQCXzRfCGqbSDQRgaNRFyL0aP0wiAjzpt811VgveooBHkX40j2gfjXnkdN50Rm/Hb+YBhNUzZ2lrfIRlCZnP5dwtjX/frqtV+h5y/F/Zk5SHwnLnZf0RaMePNs0IHU5XYhinf5hlmadg7qGXZg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce5bf7e-cf38-4337-d733-08de9768fd7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 01:23:51.7435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znwpaY3qxtoFY51ALnUHDeQEmzKjaVEe5/D3dG40qsjUtZwDz5p8QZlQLG7+P+BY0ROqNX335pEdrBdLHrJ0Oan/bfBfD4WIXXT+B3QaiyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6780
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gUG90
ZW50aWFsIGFsdGVybmF0aXZlIHRvIHN0b3BfbWFjaGluZSgpDQo+ID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiBBbiBhbHRlcm5hdGl2ZSBhcHByb2FjaCBpcyB0byBs
b2NrIGFsbCBLVk0gZW50cnkgcG9pbnRzIGFuZCBraWNrIGFsbA0KPiB2Q1BVcy4gSGVyZSwgS1ZN
IGVudHJ5IHBvaW50cyByZWZlciB0byBLVk0gVk0vdkNQVSBpb2N0bCBlbnRyeSBwb2ludHMsDQo+
IGltcGxlbWVudGVkIGluIEtWTSBjb21tb24gY29kZSAodmlydC9rdm0pLiBBZGRpbmcgYSBsb2Nr
aW5nIG1lY2hhbmlzbQ0KPiB0aGVyZSB3b3VsZCBhZmZlY3QgYWxsIGFyY2hpdGVjdHVyZXMgS1ZN
IHN1cHBvcnRzLiBBbmQgdG8gbG9jayBvbmx5IFREWA0KPiB2Q1BVcywgbmV3IGxvZ2ljIHdvdWxk
IGJlIG5lZWRlZCB0byBpZGVudGlmeSBURFggdkNQVXMsIHdoaWNoIHRoZSBLVk0NCj4gY29tbW9u
IGNvZGUgY3VycmVudGx5IGxhY2tzLiBUaGlzIHdvdWxkIGFkZCBzaWduaWZpY2FudCBjb21wbGV4
aXR5IGFuZA0KPiBtYWludGVuYW5jZSBvdmVyaGVhZCB0byBLVk0gZm9yIHRoaXMgVERYLXNwZWNp
ZmljIHVzZSBjYXNlLg0KDQpJJ2QgYWRkIGEgbGl0dGxlIGltcGVyYXRpdmUgZW5kaW5nIGxpa2Ug
Iiwgc28gZG9uJ3QgdGFrZSB0aGlzIGFwcHJvYWNoLiINCg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
Q2hhbyBHYW8gPGNoYW8uZ2FvQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFh1IFlpbHVuIDx5
aWx1bi54dUBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBUb255IExpbmRncmVuIDx0
b255LmxpbmRncmVuQGxpbnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8
a2FpLmh1YW5nQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEtpcnlsIFNodXRzZW1hdSAoTWV0
YSkgPGthc0BrZXJuZWwub3JnPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJl
IDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg==
