Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE53921E9;
	Thu, 19 Mar 2026 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945905; cv=fail; b=t9DCbBU8ArvrajZdK+3DDX4ltVjfjAuSwo9u19bVP+KlnQwhI9JH1kn+EoeReZFu2jvLu08ZOsQ1xn6BpdRPLhOQ6LSjDBRVKSSo+4u68eWvbLmnCkQgwTT68yoRc+PCvZotaKeIfOZ6myHON0JkZPPqMX6MxKHYR7ZC3mmkgbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945905; c=relaxed/simple;
	bh=kL7wtMOdv9xI40amTpXAO5bV2E8TRP529zWSr2U/kTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hmOzNjKbvYD2q5zci2CI1JY7tJFw9S+Q/Sd5PlZAbyDPFWHdpX0lAlQHPw5d/qUfa1RU7gJOwqrWLPsPFkfoavZS13UI0AiIPDgGh6Wu33W6aQ4QKrJ5Kh7hMErN3eU4f8qY2F8ze6RetB1Lin1qZhVdKcofK3ubgZ+8/Fs3CeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddJXORHQ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddJXORHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773945904; x=1805481904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kL7wtMOdv9xI40amTpXAO5bV2E8TRP529zWSr2U/kTI=;
  b=ddJXORHQQ1+dXo+usDhiCmhqqmaG3coNIrsYyuzWZBcF/OAvLLuKBo+k
   m/QHgmctHYkxSEjGb8mQ15pgl3qohsVc+7RdW+5WJQnkOqL6rbc4+aSTU
   q8tkZB8c33vWqS5GW8/n3Ccie8pKjbh0wItz6HfuQl3/yiViCBDO7i/AM
   gqQbejb+EnvBVpPZdKIrTMfrWWRfsanTbeT6yVw0D8QHKxu0hPRaZFKAb
   NKbvfl1rypqARe4BDlDQLhh/biGNWvu8BVLzLoLVfcbOrOpWjHIPax0Kh
   7i2RjYQkUEb/W/Au+L6kB7tOUeNI7rA710qWCxA2kWXOAv8usXYys5xWW
   A==;
X-CSE-ConnectionGUID: TXFW6TajSGGPCbyuKqr2cQ==
X-CSE-MsgGUID: wYFgjamiTCSpFbhqz79gEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74939783"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74939783"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:45:03 -0700
X-CSE-ConnectionGUID: KRQHovNTRZe0LjzjgAASbQ==
X-CSE-MsgGUID: 3oMAq+nJQ5Wf5YOmi5FMHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="223277763"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:45:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 11:45:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 11:45:01 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 11:45:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdXUIyz1hHGtfZZcr9AueEwJvSbpAu3VrOxvpk2BcqKSnQfbv9OL7hR5EK19cX84eQzuZhTXoxppjRzWz0k1UqjF8id8dFQR1S2X9rqMGyHdy1OGZMF+VWrfxuNh/XNJ22XSXRqSVeIPyGX2ZW/xGoZANQUty9d/meR5Q74IB9RO/vpUkev2HwB5w2tUZmn/d40/jGzdpir2zaY3zzxOzBcKpBcVtEn2T1ebA3InwAjInPCoFh4XlC5mUWKtP/B0QgQOA41EKm4revDs2/4N2vu3BKwXEjP7Sioh9uNkYczmWdyssqYLaoGXXVBBGe50dJpCl4HnGEWsY1TYC+i/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL7wtMOdv9xI40amTpXAO5bV2E8TRP529zWSr2U/kTI=;
 b=knYT/IF24x4i2+jNT4QXVyKk3v2fRdLLugzVEHHexAQ1RD9z81LNclMVMlyjYSeUe5en3b8j4kUGsrrjiKuFSJzgV0gCt/ql0eAe0gATcdl3S/ajVjDPJaeq6Cv4p0P4C2CgDinzTm+a9dNJ5/b0J2ilxaTbHz16FbTWEqzw32HJKTSD6Bv455cpqW5aA8XwsSN0FbLvL5wxCt6epPp4nKekOgiIrbQLAPzd4DKn/lg6HwN+9wzTIlbenE9pUTOFFTisS8+qBWdQCt77Jam86ghhhfZ63rTkZX+ZX6FQTHcp6HVlpeBTg20OILcI4lKq8zbMVs+AONz8encoefHItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 18:44:56 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 18:44:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@kernel.org" <tglx@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] x86/virt/tdx: Use PFN directly for unmapping guest
 private memory
Thread-Topic: [PATCH 2/2] x86/virt/tdx: Use PFN directly for unmapping guest
 private memory
Thread-Index: AQHct0D70l6IbeBF5UW69mhkmrXomLW1MEAAgAA5RQCAACRvAIAApH6A
Date: Thu, 19 Mar 2026 18:44:56 +0000
Message-ID: <c466c0425b78806000942f58ead2298f0508bfc8.camel@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
	 <20260319005808.9013-1-yan.y.zhao@intel.com>
	 <623ac08e-07a7-4823-bd0a-777d8df5c128@intel.com>
	 <abubmi7BjMwgnrvC@yzhao56-desk.sh.intel.com>
	 <b74acb4b-4658-4113-9fce-9faf972975c4@intel.com>
In-Reply-To: <b74acb4b-4658-4113-9fce-9faf972975c4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB8660:EE_
x-ms-office365-filtering-correlation-id: de96e8b0-b0e3-45c5-cc5f-08de85e79db4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: cZoCta1ApxB9nOWJksfbEZgEve/YIKj86HOOcAOqSyV7VAXoFU0YDawStdnIrqrz1gnEhT3DgIjsrpJmCKDEg58IxJX2+Hcvlyxem0r5iZalI9vqsouuR7qPzzTgt0eK3VnLb9IHmnnNGZxgW1olKB0QUsblZz5+LYdUS0/pVk3hqTC2aZXoZjcaDVGQsJ0OCIddKi5Cof+BrdHsBU7LONddGAwXWcLB0gH9QszFypQpc/fQHKqescjyrZUPt3fotFeenciHtExhR5Tk3caK2yxlszuQafvXzAeZR4VsCcyMn4CZQR3j7sFhpvVRZ5vosp+LS/w/DW4fqh9AGQklwcyi2qi3fIBuB70LK4zNa38PCeq+GCwid9k45SAbQ4tEUBxSJDSwh4aojfaOUpUUSnC06/s4w/ycsV2HOdm5/snljPAyxd3JKvE/o5DMtwgOXliC9LAV5HtTURrZ7c/lhy+aFl5M2HZntNE+NxtWmfX4ykXT4NV3oTlGJjwxR5UntGK1GjoWlQHV5llmVcwKSLvpWbdqPbzbjC8Iqi829zu+vkotKctQmddTcqkOMFUQYSn9sdoV2V7RCEAb7tQi1PejL//TMJ4jAkDsHvEiSujWv04pT3IPIcPXzCd7NqUbuJoZVee/wvgLjAlHMI2BTA1lovboWQPtve7Xdq8eSAhHk5CKdjrwGwfMp2p+EvCZbnNyijhzq2VdTy5olDSK0kuZKvZGfZrqnR5cZuf4P/zItB0YX+0PNbZLjyMMiYRFl0znSJ2vi39FiwV6HK2gJ0vWcM43kq184vpto/zYMqw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2RKQ284UlhCWFRkTXJOYmU2VHdZYnFCbjFZY0xURGcvODh5ZXlacVkwZy9M?=
 =?utf-8?B?dVB3bVRCejh1TTBHWDZvQlhRTnFIRjNJdU1vZ3NTV3VlMXl0bVNzQ1FDMm5z?=
 =?utf-8?B?Q3owTXM5MVBPODVNYjI5SmE5U2JINmNIU3Y5Y3daM2Q1ZStESmYrZXUxQ3NG?=
 =?utf-8?B?NTJMWXRWeEYxNWFNN2I1U20rVG9XY3IySW9lOWJxcFNBOEtjZDVRZzZINTdY?=
 =?utf-8?B?Zjl2TWZuU0l6K3hKQ2hqNUdjdmwzSkVsQ2tJTDNpZGdOKzZBS09vMFdjdm5K?=
 =?utf-8?B?YWE5UmhIZWF6VytOWVNldFBDUVl5Q1ErWkhXUE1FL3lEMmFZelN4WU4vZjl1?=
 =?utf-8?B?cWM3ZHZjOTFjVlU5RzNKNHVSa0c3cUFWTFNzVWNvaUQwZGFtbnN0NDgwMVVz?=
 =?utf-8?B?WGFaeWtKTWZMVmI5TXg4dFR6Sk90YkRNSFZkV2w5MkZ2UUpyN3VjR3lWa3hJ?=
 =?utf-8?B?UDk2Zjcra241WndQdnFOcUhURnRldDJEVmFuYzdwZ3BucGZBVU9PUXdGWHpE?=
 =?utf-8?B?Y013VmM2NWROVUhFR2tib1VybXlmbnFZazVrZ3RQTzdERitOYmU4Wlo5R3Zn?=
 =?utf-8?B?Nko4QWs2QzVhajVUOVlhZ1E2djRmSXdQditvbTZGUEtKcE0vVllJc2ZrWmEy?=
 =?utf-8?B?MTZzUExsRVpYc0duaFJsYjlKZWJydTlwdDI0MDIwRGhDbWxrWW4zQXpiWUZ1?=
 =?utf-8?B?RVNsYmVnSnJscXhJL29ZU0IvVElYdGk2eWkxU0taOGhKeEppaVBlU0I3SEgv?=
 =?utf-8?B?SzR1TG9qNWpjeExrMHhpQlFoU2l1czQ0bjNvRzkvbEVsYVBOcTFZbTF1MzBV?=
 =?utf-8?B?YytkZzZ0M2grcHp3ZTNTa2hwQXlOS1ZkQWN6QTg5dXVrbVQ2L3FZM211ZUpW?=
 =?utf-8?B?Q09yU0JDV3ZRWit4S1JMcUVyWXRUb0ozMmttWjhwYnlyMm1OdzF0NmE3ZVVp?=
 =?utf-8?B?QmVPaWhPY3ZGV2dxV2Y4eHRsVnhuTjIzN251eW1DRnJ4WWpiOFY4TjBpZ3li?=
 =?utf-8?B?eDRCTzJhbk9VMGwxdG1INW9nMXV2YXM0Z3NkZlFxY2x5RElpRzJxVmFDNVQ2?=
 =?utf-8?B?MjR1dVM2VG92TlJqQi9PTG5HdWJ5bUppbFdzNDVMV1R5ODluN0QyZmtFdnV3?=
 =?utf-8?B?a0l2dlhldDR3enA4ZG9HdVZUYU9kYlBQN0oyemRhREVFRE9EdkJmSXdLMzZj?=
 =?utf-8?B?clQ2UzRDRWxPckQzTnk1Uy91ZFZEekdMekp1VWkzYThPNCs3QS9WNHh0Kzgz?=
 =?utf-8?B?SThVcnBmY25ZdG9XZVpsVXM5ZDZWNnRFdHM1QUFNK2dVMVVaelpod3lCLy81?=
 =?utf-8?B?ZGxnUy84TFMwSUovV091VVRTUkUrUzlDQmxlLzUzRWJJMUxHRTNacTZCV0hP?=
 =?utf-8?B?YUw4akhEZXRRUXZCYm16NjBvaTkydW90bWlBNFVIWDhHYUo5TUNTMzRETUZP?=
 =?utf-8?B?WVdJM3RtYTByblZEWDlhdTkxRUJSYlcrWFl3cW1lYVZqclMyWjdPTGxpQjVL?=
 =?utf-8?B?VkEyRjQvNCtMUnZqamU3bjQwbmpSMHlURGFVWG8zem90UlQwVm5WUWduZDBO?=
 =?utf-8?B?cFJvTWlycU55LytPRnVDcHJHUHdMbjhtYk1Tc1NkOW92ZVBxMEppb3hVV3Y3?=
 =?utf-8?B?N3c5blk3WmRhbWhXUytnQ1FzK2RPTTJlWGJQNHNHVWpya2FrY04yc0tRK3pM?=
 =?utf-8?B?YXpNVVBRUmhQc2tjbzk5TERZTWFaK0JlRlpFSUVmUHpVOWpsZnlwV0N1Sk9i?=
 =?utf-8?B?ZkpwMys4eXN4aGRIckc1ZU1Rd1BEeUVOQTBKamtCQXZZM3dOWndHcHhyOVJN?=
 =?utf-8?B?M2FRWmVEUjRUcGhUdUhzSlNxU3UyMnNsNUNNaXpncGEwM0xqQXc3eWFsbzVm?=
 =?utf-8?B?Nk1BNk1PNFl5WWpmaGFIRGtkR05ONmRYU0hVNHUzYWNZRHFXNHd0NWQ0ZVFF?=
 =?utf-8?B?aGFaWWFTNmFoYk8rdnF3eDc4VGZmcTdEWjVLWEhjZmszbU9qTGVGU2lFNDJk?=
 =?utf-8?B?WDNNdkVheGc4K2dNQTZ1UFNMc0pPNDk1Z01kRU9KblQ4Q1Z4bVIzeVBQTUo1?=
 =?utf-8?B?Vm4xR1VpSlI3Mkx4b2pFUks5UlJBY0pkNVJFelM4eUt0bnBYdEphdytPYTkw?=
 =?utf-8?B?Zy9VWlN1elFsaTYyRXRkS0k5K1FmUXF2NUFNUnJQR3FUeVdFR3poWWtoSTBU?=
 =?utf-8?B?Mlc1cjd3c3QwYlBQN2VvUjY2cVVVWEJPWW1xUWdJMW9GbmVSa0tuMWZkVFBQ?=
 =?utf-8?B?SDRZSnp2Z1U4cVc5OWJBT2Z0TEZGamdpbU9FUGNBYms0RjF0QlFUTGRwNGRC?=
 =?utf-8?B?cldsQ25IdW5hTXUrcm85TGNKYmt1TEFFUkRPeFltVUtsMFo1bE5wK0hmYm13?=
 =?utf-8?Q?fWgixK/eVG4qcDAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59AE8E74D083BE469E404CA0C27AC136@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZDMObxb63MXejyXOU8FpZycaGR5nfTzgRL828QQLkwQnFhOQwm1biSp1Eh1XCIIFxAHztknRG0V1h78ai9jaZ+wSRkWBaUxO2LfccSt94dE0rXctz24gJY09sj2fLEKvFqnP+EK2gG6VHyhIkataGjJcAQf14I1zMRpqaT8USAFURdfyjW3bHZU4mQ3O7enxUKLahA1O5L69PVF1FMvWirDH4TLDLoH2YAudkZwGYYG9vF6OrGGbuDQi0Jo9ON0LYrgWJubYkCBs0tHiPYCwoWcvs4tQX6RRj1f6OFFrgZC/nXYn6uOJXxiF/uwmg/I83fMKo3oJwfvggIfGfQld1A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de96e8b0-b0e3-45c5-cc5f-08de85e79db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 18:44:56.2654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0Q7UpoOC6Rwi0ON/jLdvXA1TcqVkIjOg/r2oZy7wVQgWBEUCXib0m9j8EJM0gOj3oR5BZyVYHrdB8bArmepcEJj1zSVIxKVO5DDEDl7nbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8660
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTAzLTE5IGF0IDE2OjU2ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiA+
ID4gPiDCoMKgwqAgfQ0KPiA+ID4gPiAtdm9pZCB0ZHhfcXVpcmtfcmVzZXRfcGFnZShzdHJ1Y3Qg
cGFnZSAqcGFnZSkNCj4gPiA+ID4gK3ZvaWQgdGR4X3F1aXJrX3Jlc2V0X3BhZ2Uoa3ZtX3Bmbl90
IHBmbikNCj4gPiA+IA0KPiA+ID4gU28gd2h5IGtlZXAgdGhlIGZ1bmN0aW9uIHRkeF9xdWlya19y
ZXNldF9wYWdlKCkgYnV0IGV4cGVjdCBwYXNzaW5nIGluIHRoZQ0KPiA+ID4ga3ZtX3Bmbl90PyBJ
dCBsb29rcyB3ZXJpZCB0aGF0IHRoZSBuYW1lIGluZGljYXRlcyB0byByZXNldCBhIHBhZ2UgYnV0
IHdoYXQNCj4gPiA+IGdldHMgcGFzc2VkIGluIGlzIGEgcGZuLg0KDQpUaGUga2VybmVsIGhhcyBB
UElzIHRoYXQgdGFrZSBub24tc3RydWN0IHBhZ2UgYXJnIGZvcm1zIGFuZCBvcGVyYXRlIG9uIGEg
InBhZ2UiLg0KRm9yIGV4YW1wbGUgZnJlZV9wYWdlKCksIGNsZWFyX3BhZ2UoKSwgZXRjLiBTbyBr
ZWVwaW5nIHRoZSAiX3BhZ2UiIG5hbWUgc2VlbXMNCm5vdCB0b28gaG9ycmlibGUgdG8gbWUuDQoN
Cj4gPiBJIHRob3VnaHQgYWJvdXQgaW50cm9kdWNpbmcgdGR4X3F1aXJrX3Jlc2V0X3BmbigpLiBC
dXQgY29uc2lkZXJpbmcNCj4gPiB0ZHhfcXVpcmtfcmVzZXRfcGZuKCkgaGFzIHRvIGJlIGFuIGV4
cG9ydGVkIEFQSSwgSSdtIHJlbHVjdGFudCB0byBkbyB0aGF0Lg0KDQpZZWEgZXhwb3J0aW5nIHR3
byBmdW5jdGlvbnMgdGhhdCBkbyB0aGUgc2FtZSB0aGluZyBkb2Vzbid0IHNlZW0gdGhlIHJpZ2h0
DQpiYWxhbmNlLg0KDQo+ID4gDQo+ID4gR2l2ZW4gdGhhdCBldmVuIHdpdGggdGR4X3F1aXJrX3Jl
c2V0X3BmbigpLCBpdCBzdGlsbCBleHBlY3RzIFREWCBjb252ZXJ0aWJsZQ0KPiA+IFJBTSwgSSB0
aGluayBoYXZpbmcgdGR4X3F1aXJrX3Jlc2V0X3BhZ2UoKSB0byB0YWtlIHBmbiBpcyBzdGlsbCBh
Y2NlcHRhYmxlLg0KPiA+IA0KPiA+IFdlIGp1c3QgZG9uJ3Qgd2FudCBLVk0gdG8gZG8gcGZuIC0t
PiBzdHJ1Y3QgcGFnZSAtLT4gcGZuIGNvbnZlcnNpb25zLg0KDQpXZSBjYW4gYXNzdW1lIHN0cnVj
dCBwYWdlcyBoYXZlIHBmbidzIHByZXR0eSBzYWZlbHkuIFNvIHBmbi0+cGFnZSwgYW5kDQplc3Bl
Y2lhbGx5IGFsbG9jYXRlZCBmcm9tIGZhciBhd2F5IGNvZGUsIGlzIHRoZSBjbGVhbnVwIHRhcmdl
dCBoZXJlLg0KDQo+IA0KPiBPbmx5IHRkeF9zZXB0X3JlbW92ZV9wcml2YXRlX3NwdGUoKSBpcyBk
b2luZyBzdWNoIGNvbnZlcnNpb25zLiBXaGlsZSANCj4gdGR4X3JlY2xhaW1fcGFnZSgpIGFuZCB0
ZHhfcmVjbGFpbV90ZF9jb250cm9sX3BhZ2VzKCkgYWxyZWFkeSBoYXZlIHRoZSANCj4gc3RydWN0
IHBhZ2UgbmF0aXZlbHkuDQo+IA0KPiBTbyB3aHkgbm90IGNvbnNpZGVyaW5nIG9wdGlvbiAyPw0K
PiANCj4gwqDCoCAyLiBrZWVwIHRkeF9xdWlya19yZXNldF9wYWdlKCkgYXMtaXMgZm9yIHRoZSBj
YXNlcyBvZg0KPiDCoMKgwqDCoMKgIHRkeF9yZWNsYWltX3BhZ2UoKSBhbmQgdGR4X3JlY2xhaW1f
dGRfY29udHJvbF9wYWdlcygpIHRoYXQgaGF2ZSB0aGUNCj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcGFn
ZS4gQnV0IG9ubHkgY2hhbmdlIHRkeF9zZXB0X3JlbW92ZV9wcml2YXRlX3NwdGUoKSB0byB1c2UN
Cj4gwqDCoMKgwqDCoCB0ZHhfcXVpcmtfcmVzZXRfcGFkZHIoKSBkaXJlY3RseS4NCj4gDQo+IEl0
IHdpbGwgbmVlZCBleHBvcnQgdGR4X3F1aXJrX3Jlc2V0X3BhZGRyKCkgZm9yIEtWTS4gSSB0aGlu
ayBpdCB3aWxsIGJlIE9LPw0KDQpFeHBvcnRpbmcgdGR4X3F1aXJrX3Jlc2V0X3BhZGRyKCkgc2Vl
bXMgcmVhc29uYWJsZSwgZXhjZXB0IHRoZW4gd2UgaGF2ZSBwZm4sIFBBDQphbmQgc3RydWN0IHBh
Z2UgYWNyb3NzIHRoZSBBUEkuIEl0IGluY3JlYXNlcyB0aGUgYXN5bW1ldHJ5Lg0KDQpXZSBkaWQg
ZGlzY3VzcyBjb252ZXJ0aW5nIHRoZSB3aG9sZSBBUEkgb3ZlciB0byBQRk4gZm9yIHN5bW1ldHJ5
LiBJdCBjb3VsZA0KZWxpbWluYXRlIHRoZcKgY29udHJvbCBwYWdlIGFuZCBndWVzdCBtZW1vcnkg
ZGlmZmVyZW5jZXMuDQoNCkJ1dCB0aGlzIHdheSBzZWVtcyBsaWtlIGEgbW9yZSBtYW5hZ2VhYmxl
IHN0ZXAgdGhhdCBhZGRyZXNzZXMgdGhlIGJpZ2dlc3QgaXNzdWUuDQpJZiB3ZSBkb24ndCB3YW50
IHRvIGRvIGEgbWFzc2l2ZSBjbGVhbnVwLCB0aGVyZSB3aWxsIGJlIHNvbWUgc3R1ZmYgbGVmdCBm
b3IgdGhlDQpmdXR1cmUuDQo=
