Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775B3451D9;
	Fri, 10 Apr 2026 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775864555; cv=fail; b=hFuYLkXwdvKd3ld3FbSPyyQKmQGFkovcLZ/qOPEmZcJczjFJHfs1+TlgRLmRPCP3bnuXLweNGCS8pu5PVKq+HP3hxYqgN8MEzc9LpS6Khy1Mz8H162NY/5FM7GTzRdTKoK9IWaItw5vz89xNefNMkyYDuHjrStcp/smvye2hyyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775864555; c=relaxed/simple;
	bh=+ZXbIYIMYqAjnCqu2LOyIJ7o3X4qoYLjWgK/PizgCgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uWZS6BYpFQuMD4u1oze7lWHOnb06ZrJIXYgRdPOulvNO1NWG/mCLVqBZTjXaWO0n6hj6YVW0798aNI/B4HKRvPOh0R+Vv8jgWmSiEafLJyYr47AnKO3Jfj/CIb6m4vqnKTpy+swyCM7+D1yaso+4QCuWYGW3278TmpdHqWA36po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJ2hbPg1; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJ2hbPg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775864554; x=1807400554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+ZXbIYIMYqAjnCqu2LOyIJ7o3X4qoYLjWgK/PizgCgg=;
  b=LJ2hbPg1e3N3od4fPgNjFfboO31VaIaPcQE9fVN8xoXV/o/YD9/3+sKo
   hGCEsCj04V4rLUA+4LSZOaLs0gAxZ/YZ26gaBbYSDRDVWchGfYJQR0yMX
   pKMWoJKehixichqxZLUVkCmHUC6QmT6XTBZfqz2flSEOtRG/rW9IH9miz
   ZyAG9eGY0lcWzGr50Rgmf9u9irRtJjK5mr6aiyDPslvO4bWdqG1TI+owS
   hs1BW5KgwgHRf6EOFApRHdhy84j97Upeti68OLeJipf5Z5stU9z93ITZB
   J4axjPQrN1wwv9XN3p5upzuYYCsIoEodip5iQkyJCg/IfB9T4e8BUDBda
   A==;
X-CSE-ConnectionGUID: ke5oarmSRk+sQAYmY/oeMQ==
X-CSE-MsgGUID: Aqa4lPseT82TwQXpexs+hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="87180516"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="87180516"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 16:42:34 -0700
X-CSE-ConnectionGUID: 6kJyAnWVSVCJ2UU511PJVg==
X-CSE-MsgGUID: +dpwC3EgSB6i1Z5heEV54Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="259701101"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 16:42:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 16:42:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 16:42:32 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 16:42:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NApwNfk8NAEy/rTXarrJSGfKxec0MaC8lODG+HaZ0FJaJBQObynu/fLsAXaxTV1608mW69oUcmpnp9hbb7IaRPS/UfDoq79eEsxBt8hWOuh5/l9S3gT88X8/cmaiIxA4kwaSJmwIKzYEqsjGWifBchXz5ztv8Vvzou/HVUFzZ7un3qqG8Xc4yg5qpy/qIlaKVRILMIuAF7GhbKvcu+4boUfeplcHW9cLDHU8VIOGMFa2Kms89IVEo2P1P812tKAN/6ve+d5gAHYj0L6dgEUquayEzlZWV8pDwmZhMQ38+n2KNOd23tngG+NR6g28pWgFqsvJPXPOnrjazavac1hGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZXbIYIMYqAjnCqu2LOyIJ7o3X4qoYLjWgK/PizgCgg=;
 b=h/MsgGdO/D6EX9SDhXpWCSV21Sh26e/nmGY8gvDQyuyeWAh0Rd8jbtG+zJHx1FyiqEKM78TwfE0+OW/XjFTIHfbN+PSJ4j6PkCkyD+cBEJ+Eqgc1mm4vMfpS5fDRWEpvF6jvFdI/1Do/fnZIFlpzfp7fvhZrA+IocgsYmEH5GIgStRgwMn9qxlsSKdVuNA67vWgdDa2bIVT70xx6Gu30JJaEFt2VqPcooTk37FTN8eJqZBp3N0ZW3VrNaW35DMuaEk4qu9K8GrrjV6fAmVKLDDLJ7Gi2K0yPpS1I3t8B1kYXjNRDwiqYMkPAPD3uB345Pns3JIOTbsl2mWVZ0Nk55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB7347.namprd11.prod.outlook.com (2603:10b6:610:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Fri, 10 Apr
 2026 23:42:21 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Fri, 10 Apr 2026
 23:42:21 +0000
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
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 01/22] x86/virt/tdx: Move low level SEAMCALL helpers
 out of <asm/tdx.h>
Thread-Topic: [PATCH v7 01/22] x86/virt/tdx: Move low level SEAMCALL helpers
 out of <asm/tdx.h>
Thread-Index: AQHcwQv8tMpH1g1JdU2isTsnzl7LvrXZBUAA
Date: Fri, 10 Apr 2026 23:42:21 +0000
Message-ID: <e22c02836351ae0f9e6fe422429333db840578ab.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-2-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-2-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB7347:EE_
x-ms-office365-filtering-correlation-id: d20095b0-a104-4508-d596-08de975acf5f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: FnNkLCJVELt5OhXTMmXzrtmI3VBXd83P401VkHBKpRaAmTz0yYgnGaFQTIlcPjPKGKdh+tZPblxVzdQtNe2cRyYZqsRDTbvqqVJXvlYUR/Nxb9dz5avknn6oCsHtzRrfv5qHN7Q4BtDjRLhn7slXjJhmy0VC7Z+UCg/ChtVMiOoavQab1Ms11CPT7MdGJnWFOufuZ5JljnpY4wpB/WR3qqtYag0jrymOL8427BjqL2WfBAATnI1gDecgSsNIICYSH7JNF2lxktB3bka8ZbkkpE0zZbKwXq/gLaxpdhTBA8DZEe6sF0lYuMRcWC0Hm6O9UBFS5yBhg3TmGMN3hHemqIKwCGvk2oVQwgjVBpMIyAjSDeyWd04ukXiBQ7B3mo4ptAJVZfgeiqvdnnb7aCdQ7gAz0MWvZn5SYke47WOU49VlTtF6rD6jdI6wetaUc3x7b+/FMSvPXjNAVih0S3Z44+5chhXY94n+cwfb171TIjlSeyKLGwM2+PCBLAiWO3Df1R2prbvt0M+4vE01gPnLQmjqVpaGHcLf9qZMcUN7FBroITMfK6otGUeII2zfSExZxFS1ipsZ/RV2aCF4WRsbr3z/SBGPPh6ETvQLkvgdUoIZ08uFtRBjI9UOb0TpDbSeUyU88RDQl8yIHMfTMR2rrfcr8rm0nNgS6XdREc1d0cU6P+S0vt9ODvGcDZ3Gcdgv+hld+TpnAY5r6gEb6GaN1y14YXhJC4NJPkega/uGizxSamZ7tjaoFGbDshdNs+d+Z6nm2/pgnT+yRMSJPwi7eznKmLqEGkk1JfRBQFfk+48=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUtWMm5XTmVjYTQ2NWZaQ2JFbGlCejMvM1AyTm43WTg2cmdXVG9NRW82M1dv?=
 =?utf-8?B?djZLODE2NjJQdEdOYS9pOG4vbVZkMkFrWS9jbUlLU213a1psR2NUUm82b2lJ?=
 =?utf-8?B?d0N4WmE5RGNFOVVWVndCeEpKTTBJTDl1aVU1d20xYWZFUEc3RVFNT0p6aFpO?=
 =?utf-8?B?Z1Z6MnZNNTNxU1pOTVdmV2xhNkpvcmZkbWFIMXhaTk0xMXROaVdtQ0hvSU43?=
 =?utf-8?B?bDRJaUxqeTNOK1lScXkrN0ZkYUliTVBQZS8xZTl1TTRkOXUxejdNQ01VWE5p?=
 =?utf-8?B?eUJ0cWs3TUkrWnp2b0EzVC8wRC9ESCtHcjVFU0JhdjlmOUlkUmhidnFBbVBN?=
 =?utf-8?B?bkV0WGF1QXBaNHByS05iVlRTTGdVdlZJQVAwZWp4Nm1mR0Uvc25aelVFMWdS?=
 =?utf-8?B?eW5yVGsrQ2hBS0I3Lyt4US84YUUxVTNHVTZ1eWZBQWJaQU1QY0Y2YzVEY2xQ?=
 =?utf-8?B?SUlJa2Rwbmx1RlYzM3N3dHdLZDFaQjY3OHk2ZXpnVmhBQjBpMStWbGNqaFNV?=
 =?utf-8?B?dk5WdHViSWxLaFBiN1RLUGVuTFp0eUNPVHZnMUFVMTRnZmxMOWNER2trQkZv?=
 =?utf-8?B?ZThVNUJqK0VUajBKaGdiNVBGbzI3V0VpY2orMlBLdERqN0UxV0ZhMFVTSktW?=
 =?utf-8?B?bnR4Z2JKbGxTd3VTZ1BHSDVDNnF3RjQzK3VoMncvaFpxeWlBTnVzMkdWUG9s?=
 =?utf-8?B?elpkeUhYSi9LbzltbE1zN3dvbk9YWGNMb0xkVFQwUWVoVDNwN3FGcGFhNWJC?=
 =?utf-8?B?eHRLV3hLN1kwYUI5YU9aK1pPeFhiditFQnErQk9HOXV0ZHlPd3F6VUZsbmJo?=
 =?utf-8?B?WWZRblZaT0Q2dEoyd0ZGSWtKUHAxbVhVTkx6ZVlMYXo4Z2hZR3BRQ29SRkZq?=
 =?utf-8?B?eFZLeVhCek5QNGlOVWJVdldNVlNBTXBNT0o5Vm9KNDdaMUJ3b3cyTEJzQTN2?=
 =?utf-8?B?WGRqeEE5Vks0MFM5T1FJSHVvSGovcEFKYWlHZ0MrQ2VXVERaMjZkNmVjZkow?=
 =?utf-8?B?ZVBoQVBYYnlmTFByOFFZNkpzSzZLcG5ObE1oZlpuM1NSTnBacGFKaGhYYk13?=
 =?utf-8?B?QTVDZ2hCZlRGYytCRXJYblFLbGg0ZFVteU5pQzhjSjNkd1FDL1I4bHVraGxv?=
 =?utf-8?B?Y0VvemNUOGZQSTZJc0d2T2w1KzRvYS95dkRIY3duWlZyU0YzY0NNWFpBUkpY?=
 =?utf-8?B?UGF4WmNEb01JVkcyeVlEWEdRdGJEdDB4VUlrbGsvbzFBNEcxck1kakp4WUdj?=
 =?utf-8?B?VUdhaVRzcmZreVk5RXg1clQxOUw5T2hwc09JVG5TdlZHUlREQWdNRUtuWWQw?=
 =?utf-8?B?Mi8wOCtsOTVVOUpjVkM5TWpuVkhSWGJUWkNTbjFQeHdHYVRVWnVtcU5hY1pt?=
 =?utf-8?B?WUVFd0hkYTdnS1dYZU5USmk5WEttQ1ozS2ZGbTFSZ2Jzd01RSm5mV3BnZEVv?=
 =?utf-8?B?NDBWTzFrZm1LNDVBQlFHaElGTDJKTk43RVZZQkpoU0dOZXNpZlFWUU0rTWFN?=
 =?utf-8?B?QWFhbkxKaTJiNkNCRmU1YkQwSzVodTZkSS9iWWJoR21BRE9wOXVmVFNlRDRq?=
 =?utf-8?B?c0VvTC9uY3Ixcy9pRTBjU0ZiVHdoVDBqK2ZhTjdiVU0vWnhKTjdqS1ZWdGdv?=
 =?utf-8?B?aStCYnRPdEdNS1V1UGlCdzcrUVhaOHhVd1FLbk9pd1hvdmRYRXFQQklXcU5Y?=
 =?utf-8?B?YnUyczdrSHhFWExRallnd2dudGE4RDZRSGFhOHhmem1mdDlsWUh5Z3E5T2xr?=
 =?utf-8?B?QkhYdEc1dncxcTUvKzI1ZUlqMkZlTFMzRlNuRUxXbTdkWVZCTEZhMk03Ymdz?=
 =?utf-8?B?M2diQjBxM1NQZzVGQWFXVG90K1Y5dExnT05iOWM1QkJ4VU9Jb1RUVk9xejds?=
 =?utf-8?B?U3A4L2kzaU13YVF2dXBjbWp5bUx4R2FsbWN6N29NUE1WSTJQUHRtNERJZjJw?=
 =?utf-8?B?bkVXbkFnWW1waFpGVlYzUmJRL0EwOHBsR2JhMWxWUDhaa0V3a0pwRFNnSGNu?=
 =?utf-8?B?VWljcW1PV00rLzNvYktPNHJGS0dmYTgxUFB2TjMzZGFiNUN2UTBLZUJZSUZj?=
 =?utf-8?B?UVRlNmpvdllnR1pFMi9Ddis0L05nR09EZmYxTVV4akJhVzVXVUZCODRxVmZE?=
 =?utf-8?B?eUFrMldIcWRLTTJnbWo3RDlReW1ZeEZoME5Gd0cydjZ2eGhiRXMrNDNmWWdy?=
 =?utf-8?B?dzhzTXFIKzJxQmVOTlJwN0VnR2VVM0t1SG9RdmtKdzA5YnVUSW82WlBZWUVU?=
 =?utf-8?B?V3NOR3FVejFrcVRPR3JzSFhQQ3RxcDRRdWNNZk1LSzQ4WXdFczFJdWVvNjBQ?=
 =?utf-8?B?clBIelo4bVFaMC9wcGtISU1MY1lYV3g1dis5T3FIWWw5M3oxUnluazB5UW80?=
 =?utf-8?Q?EQ/IjzQJAc8Rj44Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFBB25884D20D14FBEE0A35ACE95A4EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hx/aXsVKT+0GuuKUeRCGnPx+41H1NjOOIH8w+JHN6DEhkHofAi+nKeN7gzwJXW6gl5KUOzJWbQut9IfwhFflrQFSMm5xX22jHm0JfiYlnJniXhaC/jnHC9wanXCdwDM0eVop3fAbuOpqEwFubbO98R7mwxWuxQXekXn44Qj0vb4P3xzb/kJwu+rVsWrEcFBzB62JXTDx49CunvK7c1A0s+xOuZWO43yra0p2wMQFKAeAtjtinvdMWQH/05HFcRsHcHYEvpFh9bMMBUsOOqZQmdvrHDfMyrk9Wu6B1DufWP2FF9L5EMFGoyeNTtmTsqQDYh7/E3oLNsLV2JGKJcXENw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20095b0-a104-4508-d596-08de975acf5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 23:42:21.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgqgDr9q8A7DnkmSa6IaOocpHd3tEtugryIrPNMxgMU/BLdQLkoDuP+97WhvIoKTCYgzBOXHytJHBC/DQAfU5xv4ObgeB3wtxi5niV1ok2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7347
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gRnJv
bTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KPiANCj4gVERYIGhvc3QgY29yZSBj
b2RlIGltcGxlbWVudHMgdGhyZWUgc2VhbWNhbGwqKCkgaGVscGVycyB0byBtYWtlIFNFQU1DQUxM
DQoNClRoaXMgcGF0Y2ggYWxyZWFkeSBoYXMgRGF2ZSdzIGFjay4gU28gbml0cyBhcmUgbm90IHJl
YWxseSBpbiBvcmRlciBoZXJlLiBCdXQgaXQNCmJvdGhlcnMgbWUgdGhhdCB0aGUgdmVyeSBmaXJz
dCBzZW50ZW5jZSBvZiB0aGUgc2VyaWVzIGhhcyB3aGF0IGxvb2tzIGxpa2UgYQ0KdHlwby4gTm90
IHRoZSBiZXN0IGZpcnN0IGltcHJlc3Npb24uIFNob3VsZCBiZSAiU0VBTUNBTExzIj8NCg0KPiB0
byB0aGUgVERYIG1vZHVsZS7CoCBDdXJyZW50bHksIHRoZXkgYXJlIGltcGxlbWVudGVkIGluIDxh
c20vdGR4Lmg+IGFuZA0KPiBhcmUgZXhwb3NlZCB0byBvdGhlciBrZXJuZWwgY29kZSB3aGljaCBp
bmNsdWRlcyA8YXNtL3RkeC5oPi4NCg0KDQo=
