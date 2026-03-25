Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A743FA5D7;
	Wed, 25 Mar 2026 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457859; cv=fail; b=qM774OjXTUdbq+6qST8gVADxK91gnsQ+EiLFtsRfl06+WGn2oImTbjQ4JtDLL8XwKh1EIt1xOSdpZPFGwFBblpnQtyfM5WoTdVbevKdp4lPqSbxH7p/N0HOt85Hov881xK/IVqa3BuxVe5g7jgJAplS6r20B9ajFZcx/56yX/RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457859; c=relaxed/simple;
	bh=8bTobgwVN09aU6f6CD5/376oQc//3CiIFE9UJeKSv1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FVRNdV5JRhPkx8NS4XJLxc9H5yJ3RwCRB/AeuBETk1apnhr0tqI9eN8Oghm2YP8HbZ/kYKxooy2BH/Swvx9VtTgOavzio2133G5Wd3GpwwzM9mT33Y2h1jIY19zaImiSn8RdVLvBnocaL/YFHfDdJjXNEyZJ2U5L7S4Mkq1t5C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvSbq7cw; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvSbq7cw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774457856; x=1805993856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8bTobgwVN09aU6f6CD5/376oQc//3CiIFE9UJeKSv1Q=;
  b=UvSbq7cw2v3aEMQ3zVLiSbM7I5aiYjE4tj7fEp6W1jwMWxb5RPozMHRd
   ICj6e4kjnm63eCmyaoXwA2EzncxUTMLw620+xM9ih1nhrqhu4VoeEylWj
   vjAps0j7SftBV5/ftlQw7gPQmNLHS/Mn9r1mk7eRHMEf5sFk7gzQ/8SZr
   IHfrCKUM7m3Wb2ubB3+f2dE22ueIlrT2dDJITgpkWIJeF5q+YQha54+68
   D74h8ujLqch7zTQLvMI3T0POtVBFsk2s6QGdVY3TPATgrr4ttObX5HZcz
   +ww8qbDsEHqR9iaoL83Kbk7RoHB96Xb7YPyzKryQjIgz9MTY58bZBV+hl
   g==;
X-CSE-ConnectionGUID: r3f3BuCoTlejHRw1TFvFFg==
X-CSE-MsgGUID: sF+dkaU/QsODJsVlzWI9Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="74530487"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="74530487"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 09:57:34 -0700
X-CSE-ConnectionGUID: z8LXbmmLSLCftH8w/UX+2A==
X-CSE-MsgGUID: /3AnQis9QQmQFpKLT2yeDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="247769230"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 09:57:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 09:57:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 09:57:33 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.33)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 09:57:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S04hzALH3Makw88of6KfQFi2RQLvAGVzLG/cxturlp+H4lqXHyqqCt+fImfnP/bS34IyrMqhsUJZLbCW63BgxmWLZMcoxengThSXAfw8MQzTdj449Y3QSAml5oxA3vjC7svheQ2VgFEsardNwNCrcAL+xWUt9SybpREUhBIB7ie5p5H0y93vjcnEgvVhGUBVVENoYEmYU9yUNA57ooS8UbswPT4tivbYNmZI6XizD3N+OZz1iV//QEiNObuuF09FxaPW8QadFyvJrbgqzc3f3UkST35ehjvzTlO1g1Hb7QTicnzYV+YYYKnSCIVDSqTzC3AsGd9pksN3wkTnmz1IVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bTobgwVN09aU6f6CD5/376oQc//3CiIFE9UJeKSv1Q=;
 b=UihKS/hi1FSp1zjq8hNzRi+hy4g8j1sT5TEOa6yk11+tXQbHbS76I1kUOw5ZtWV4XNhPPAbHQ7kTsCU5OWHql0M+J7dX98j5tey2+qOzsNRyM2dSoY5inT8Q3NdVtVYfMc/lIEzJYlKU70wfTqyQMF8gUbNa2PQjTMNhElwSzPrHR2icqFxG/7Zs4Obe5lhL0hID5inRpiSrdQ02lvnqGNRf2WD0VgCd1rdE/oJ16zYHN/yVIL6CJQ2HSIY48CPq97pXyvVUHXYXXBoA9QUunbVjWQ2CBKlj5kudBwM7ctQhYNmgfCDj3Xm4Lkbcze/JlI2B9kpX7Ow+k/BYxDsdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS4PPF10012BF96.namprd11.prod.outlook.com (2603:10b6:f:fc02::a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 16:57:26 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 16:57:26 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@kernel.org" <tglx@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Thread-Topic: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Thread-Index: AQHct0DWySj+AXH+Kk26T1K2yM7v+LW2J1aAgAjYuwCAAILVAA==
Date: Wed, 25 Mar 2026 16:57:26 +0000
Message-ID: <189f00877360117ab91ec3a6cb8b8239f4fff06a.camel@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
	 <20260319005703.8983-1-yan.y.zhao@intel.com>
	 <a14531ab-f069-41f9-8c5c-9fe6f28a9454@intel.com>
	 <acOmoOP2fFUyOByC@yzhao56-desk.sh.intel.com>
In-Reply-To: <acOmoOP2fFUyOByC@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS4PPF10012BF96:EE_
x-ms-office365-filtering-correlation-id: 063a2e42-6b5d-43b9-4e2f-08de8a8f97f3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: eqFksssinYzi84YQ9Q8WdxhoSOihwO+c2IWxzg26W/WUq5qvSvfnK/mlxOzdp4gkxfsysez69L67cGy+1YeQePzuwWr+5uuHWtG8QTURxbroLGHFJ/gCtgY9dd6uHMIGO758+4PMH2cof5nUdBgzBxMbUx2gUQ444eCAEA+LZ6LTEb525krE3BWGWn9uSgpDoncSYhcOaq84ugPMzz8eY4AeiYAcZqjWtjateFkDpN2PNAsvKZrBly5Lt4NTuQWyDWhR1wMM2piHluKgxpXADYZpPF/MwYE64XZdQabIR1m7sndJZokOrI6MC6iL/2fwKcf9Hsw2pR7GkOR+d5Y8XZ4onN75qbmgx4gW2pglCnJNecjAqu/A+A14DP7mt8dYg5PQ3I0qFPUd2dq+9cNtxxQZKCCESVEHdXwt/ALpP6gSoxDtWQOhzSLQd0HSTjee4PBTJGwql77YV4ehAupJM/Zt4k2w3WZGSu2dNE3kCDJTJhIVzu73HegF145TnOngh7m5IpI+2QRMa3IlCg3/byC9lpD2lSpeFC4R/tYKzwNETWxvXTJ+cGt7ol2YsYMZoAybLFaLV3HPFL4+9UDg6jRBq4kJovUEuJc6YJD0WyqTKzpucEqLdxd6IKN21xFH7WY0lVUm81rAlEJhq3zIG7AQaFDKwwvJObKmUOxUqkwHWz6EXsQI4/wrFSKWi29DyJfBqK05svLc7DqzeZ++EYQxXQdBdo0gJjxdm/7ltHlmVXKSyTIcJRooxiUjOvIV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDhnRmJUbGlrcHVJbGlQNnk4c2VUSGdwVkUyZ1FORVZaMUs4djErclhMS09x?=
 =?utf-8?B?SHlxTHVLejFqdTQzaVc2azdxampvU0dKNHdYS0VOMjZEZXpPYnJQVzk5TGk2?=
 =?utf-8?B?VjNCc0FTVzRwek10WVc4RUxRV0htYVBJakhncXRhTk5FVWhaNUpyUS9Da0dw?=
 =?utf-8?B?Q0JaaVZ4bW1jRXN4MmpzajBVdFR2TFpaelQ4amJ5N0h4eUpnb3ZSb0Z4YUJu?=
 =?utf-8?B?MmFGZk11d0lIL3pkZHpndmhValRjYjBBSDYwWTBrdWtCNzNhT015MkJ0d2t1?=
 =?utf-8?B?QnNGaXIrS1R3cjFCdTVRakpxTjRkM1k1eG1QZEo2U1VWTm1mNHBrbUtRQUlG?=
 =?utf-8?B?cS85RThOTktFTER4Rnc5WmtrdFpTamk0TEtXcjF0bGJkN0gxbCtrenY0elJZ?=
 =?utf-8?B?dDNVVGpCWTVlZXNBWGJwL2FvLy9aY2FMWXBOVnR6NVNBdW9yVGY3eE90ZTdD?=
 =?utf-8?B?VTU4bzM1Tnc1SkZsL3pKWExNS1dNWTd0VmROazY2NlFhR0hpOXBUZ3ZxOUlt?=
 =?utf-8?B?ci9lcWhrUTJ3M2V0TldUWW9rSTZDZTJFaXRHNXp4RGtpVFVzTjFPNWtHVUY3?=
 =?utf-8?B?N2pDYW1ZR3g2enMzZ29JV2h0S0VoejhyT2ZaSzUxcGhRSEJGQVplMW93VmN0?=
 =?utf-8?B?ak1pdTBmMTJKTWRNKzhtdzltR01lNWUxckpZR0g3OElMS3Avdmwxb2hWNXIr?=
 =?utf-8?B?c1UxQWI4bzh6Z3lFUW1BeGxmRitYbjF4RGZQVU9XMEdPMVZWM2RnYXUzUlcz?=
 =?utf-8?B?ZytJQkNJM3BGZVo5cWJpTDg2aFJPNTZCRG5jT0J4UTh3UkliN1lJd1RqelNH?=
 =?utf-8?B?eHFrbkNlcGtrd3hjQlNHbHdwaGo1SHZ3RENEaWE2RzJIS3lNaVFvNDdHT2gr?=
 =?utf-8?B?eHNXVEk5RE9QNCtBZEgzRTVSYmtBTjk2ZFpPMnBXSTFEak9OYWl3L29RdzJh?=
 =?utf-8?B?Y3RwR3FPMWpPWVFzUG9rdEpvVHhwQUYrV0IvUC9mNzRxWVNMbnJTS09rejZt?=
 =?utf-8?B?bjVCVG5WNEthaVRTQURIUWJvZXovR0trQlBTM0l3d2x0eEVtZGhpUUpvNVhT?=
 =?utf-8?B?M1IxS1lzeGpkdGhzejU2MjNxUlkwZzQyazFsd2t0QjVhMmYxRFhNeERMb25P?=
 =?utf-8?B?MnQ4V2ZmRzRjeDlpcXIwK3p0ZGxkQk1TSDY4aE9wQWNXUDBtajNwRjhtMnRT?=
 =?utf-8?B?VXV1R0psMjN4TTBLNHBNaDFsUEhwaVBndnpuQmJBeE82dlY3a3l1NWgzYS9s?=
 =?utf-8?B?Z1ZkWnNvM0thRTQ2QXJiRExaWUpSV09oM0FRSlo4Q0xISktaa1ZlMENySHBs?=
 =?utf-8?B?bUpZenBTdFVzbWp1VFJsQzV5LzVlWDAzSlVZeGlsaXFObHZmYWIvdk84OVNh?=
 =?utf-8?B?eEZ2dEdrcXc2ZG9kU3ExSk4rWWt2cktYeG85ei81Z3NGYTJFc09kSGlqenBk?=
 =?utf-8?B?bVMyRFZsNU1Ra2JmYWpseThPeEJVWXNQemtBRUc2RktOM2t2SHhWSE5WbGVK?=
 =?utf-8?B?ckczc2kzTVdTRDI4K29kU0VwajluOStMYmRYMW1lc3BmK3RoUkprOUdidyt2?=
 =?utf-8?B?aXhSQXlNMjlrMG5tVFVySU1UdHY3WUUxdzZTWUtjN1ZWZGNoWFhBTDBPZDNh?=
 =?utf-8?B?c3hXa0RrdmRPYWxQakw3MHBEcjBtZjdYQXlLcTM5M0MxWEQvYkZjNWcySXRB?=
 =?utf-8?B?K0tyTDljajhiYnRXVEphb1QyWkRWWUdva2sxSFJWQkF1YVF5RDhRbjF0WXBZ?=
 =?utf-8?B?bGJCc2tWcExOMG9CV1lJRnR2T2NoWGNpM3d1L0xreCt2UGxLamI0VzlwZHFP?=
 =?utf-8?B?cFI2Y0FzR1dxRkExVU9Kb3hKRjVxUkw3UHpVajMzRXVXanNjZVl6Y3Z0K1p2?=
 =?utf-8?B?YXRGY3FkR1VEeUh3cnQ3b2Y5V3RlZWN3a0JMS1RzaTNudHNQOEJvYTBzU3Yw?=
 =?utf-8?B?TzBMSElRdDZmbHh3QTYvZnd1cWx2MlVhVjkvaHhTbldGUy9kUGJtdnJoeFZ0?=
 =?utf-8?B?cEphSXlZelZPUXJrWUhSMmxiaHVLS205L0pLN0ozbGhrWFZ2VVhEWVkxRm9V?=
 =?utf-8?B?T1RRTUZFYm1HNHBWQm0wd3J3bG4wWXRjdFBXT0xkVmh2c25jYlhiMldacE5T?=
 =?utf-8?B?RVY3RWRIK3ZKcjk2WkowVzI5UE9RdUZBT0lPaDZJV1lpSENnTDVpRmlhK2t5?=
 =?utf-8?B?SGw1aXZpT2xHbDhBSU5jT2xoNVQyenh1cXRZRWd1N0d6RWlZQk1uU3o5NGpM?=
 =?utf-8?B?WW9mSFlFUllhQ0g1VmxWaGg3aW1hdEZtazZmSmx1QTl0Q0lxRWpua1owdUhT?=
 =?utf-8?B?RnM3UXFnNzNLYVNCS09aVVA2RWc1YUIzY29SaUptbkNZVEQ4QTVYSlUzbUpR?=
 =?utf-8?Q?hmihilGNo2htNOI0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EECBED8536EE044B1E929827870D52C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EWHr4b98NEfri2yJjaaB9CBys1OOAo/2TmrIaedgTm0led6L7aV2t0pVkVv5DNE1g4vW2PXIMSoPWd5HGdZUpUVr9CPy2gd+0qz/ebYorC99cOTSQnB0Zjm0t1u9STlAaolVY3HbiWt0L1lBA6b+pCNGIG0NAZKOHuYVhDTX6ufl22oWZScYjm17VxSVT/rerCH+0/LojgFmaHnO6O65vZY4DYt1sP1R6t4wP3UAe+PVuveA6kq0Mc6+b7Dw1v8CivoV9Wi32uuaV9b2vciIm+FCbrZwxzMunxdY6mf+cD4AzSUuI/dUPlHXjIn0pI2xsSe/2KkszcgeFISxZ94Adw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063a2e42-6b5d-43b9-4e2f-08de8a8f97f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 16:57:26.7246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SH8QG+ge4NI9c80QYpp0VER0k6Ce7vjeZ+YWuED3kSpOx3BhbUN5Ess80h9DbgHkDaKVtF1sdLN5f6QXVIaWzutK2ywkDFUPRKz1Lcs4CrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF10012BF96
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTAzLTI1IGF0IDE3OjEwICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiBJ
IGRvbid0IHJlYWxseSB1bmRlcnN0YW5kIHdoYXQgdGhpcyBpcyBzYXlpbmcuDQo+ID4gDQo+ID4g
SXMgdGhlIGNvbmNlcm4gdGhhdCBLVk0gbWlnaHQgd2FudCB0byBzZXQgdXAgcGFnZSB0YWJsZXMg
Zm9yIG1lbW9yeQ0KPiA+IHRoYXQgZGlmZmVyIGZyb20gaG93IGl0IHdhcyBhbGxvY2F0ZWQ/IEkn
bSBhIGJpdCB3b3JyaWVkIHRoYXQgdGhpcw0KPiA+IGFzc3VtZXMgc29tZXRoaW5nIGFib3V0IGZv
bGlvcyB0aGF0IGRvZXNuJ3QgYWx3YXlzIGhvbGQuDQo+ID4gDQo+ID4gSSB0aGluayB0aGUgaHVn
ZXRsYmZzIGdpZ2FudGljIHN1cHBvcnQgdXNlcyBmb2xpb3MgaW4gYXQgbGVhc3QgYQ0KPiA+IGZl
dyBzcG90cyB0b2RheS4NCj4gQmVsb3cgaXMgdGhlIGJhY2tncm91bmQgb2YgdGhpcyBwcm9ibGVt
LiBJJ2xsIHRyeSB0byBpbmNsdWRlIGEgc2hvcnQNCj4gc3VtbWFyeSBpbiB0aGUgbmV4dCB2ZXJz
aW9uJ3MgcGF0Y2ggbG9ncy4NCg0KV2hpbGUgdGhpcyBwYXRjaHNldCBpcyBraW5kIG9mIHByZS13
b3JrIGZvciBURFggaHVnZSBwYWdlcywgdGhlIHJlYXNvbg0KdG8gc2VwYXJhdGUgaXQgb3V0IGFu
ZCBwdXNoIGl0IGVhcmxpZXIgaXMgYmVjYXVzZSBpdCBoYXMgc29tZSB2YWx1ZSBvbg0KaXQncyBv
d24uIFNvIEknZCB0aGluayB0byBmb2N1cyBtb3N0bHkgb24gdGhlIGltcGFjdCBvZiB0aGUgY2hh
bmdlDQp0b2RheS4NCg0KSG93IGFib3V0IHRoaXMganVzdGlmaWNhdGlvbjoNCjEuIEJlY2F1c2Ug
S1ZNIGhhbmRsZXMgZ3Vlc3QgbWVtb3J5IGFzIFBGTnMsIGFuZCB0aGUgU0VBTUNBTExzIHVuZGVy
DQpkaXNjdXNzaW9uIGFyZSBvbmx5IHVzZWQgdGhlcmUsIFBGTiBpcyBtb3JlIG5hdHVyYWwuDQoN
CjIuIFRoZSBzdHJ1Y3QgcGFnZSB3YXMgcGFydGx5IG1ha2luZyBzdXJlIHdlIGRpZG4ndCBwYXNz
IGEgd3JvbmcgYXJnDQoodHlwaWNhbCB0eXBlIHNhZmV0eSkgYW5kIHBhcnRseSBlbnN1cmluZyB0
aGF0IEtWTSBkb2Vzbid0IHBhc3Mgbm9uLQ0KY29udmVydGlibGUgbWVtb3J5LCBob3dldmVyIHRo
ZSBTRUFNQ0FMTHMgdGhlbXNlbHZlcyBjYW4gY2hlY2sgdGhpcyBmb3INCnRoZSBrZXJuZWwuIFNv
IHRoZSBjYXNlIGlzIGFscmVhZHkgY292ZXJlZCBieSB3YXJuaW5ncy4NCg0KSW4gY29uY2x1c2lv
biwgdGhlIFBGTiBpcyBtb3JlIG5hdHVyYWwgYW5kIHRoZSBvcmlnaW5hbCBwdXJwb3NlIG9mDQpz
dHJ1Y3QgcGFnZSBpcyBhbHJlYWR5IGNvdmVyZWQuDQoNCg0KU2VhbiBzYWlkIHNvbWV3aGVyZSBJ
SVJDIHRoYXQgaGUgd291bGQgaGF2ZSBOQUtlZCB0aGUgc3RydWN0IHBhZ2UgdGhpbmcNCmlmIGhl
IGhhZCBzZWVuIGl0LCBmb3IgZXZlbiB0aGUgYmFzZSBzdXBwb3J0LiBBbmQgdGhlIHR3byBwb2lu
dHMgYWJvdmUNCmRvbid0IGFjdHVhbGx5IHJlcXVpcmUgZGlzY3Vzc2lvbiBvZiBldmVuIGh1Z2Ug
cGFnZXMuIFNvIGRvZXMgaXQNCmFjdHVhbGx5IGFkZCBhbnkgdmFsdWUgdG8gZGl2ZSBpbnRvIHRo
ZSBpc3N1ZXMgeW91IGxpc3QgYmVsb3c/DQoNCj4gDQo+IEluIFREWCBodWdlIHBhZ2UgdjMsIEkg
YWRkZWQgbG9naWMgdGhhdCBhc3N1bWVzIFBGTnMgYXJlIGNvbnRhaW5lZCBpbg0KPiBhIHNpbmds
ZSBmb2xpbyBpbiBib3RoIFREWCdzIG1hcC91bm1hcCBwYXRocyBbMV1bMl06DQo+IAlpZiAoc3Rh
cnRfaWR4ICsgbnBhZ2VzID4gZm9saW9fbnJfcGFnZXMoZm9saW8pKQ0KPiAJCXJldHVybiBURFhf
T1BFUkFORF9JTlZBTElEOw0KPiBUaGlzIG5vdCBvbmx5IGFzc3VtZXMgdGhlIFBGTnMgaGF2ZSBj
b3JyZXNwb25kaW5nIHN0cnVjdCBwYWdlLCBidXQNCj4gYWxzbyBhc3N1bWVzIHRoZXkgbXVzdCBi
ZSBjb250YWluZWQgaW4gYSBzaW5nbGUgZm9saW8sIHNpbmNlIHdpdGgNCj4gb25seSBiYXNlX3Bh
Z2UgKyBucGFnZXMsIGl0J3Mgbm90IGVhc3kgdG8gZ2V0IHRoZSBpdGggcGFnZSdzIHBvaW50ZXIN
Cj4gd2l0aG91dCBmaXJzdCBlbnN1cmluZyB0aGUgcGFnZXMgYXJlIGNvbnRhaW5lZCBpbiBhIHNp
bmdsZSBmb2xpby4NCj4gDQo+IFRoaXMgc2hvdWxkIHdvcmsgc2luY2UgY3VycmVudCBLVk0vZ3Vl
c3RfbWVtZmQgb25seSBhbGxvY2F0ZXMgbWVtb3J5DQo+IHdpdGggc3RydWN0IHBhZ2UgYW5kIG1h
cHMgdGhlbSBpbnRvIFMtRVBUIGF0IGEgbGV2ZWwgbG93ZXIgdGhhbiBvcg0KPiBlcXVhbCB0byB0
aGUgYmFja2VuZCBmb2xpbyBzaXplLiBUaGF0IGlzLCBhIHNpbmdsZSBTLUVQVCBtYXBwaW5nDQo+
IGNhbm5vdCBzcGFuIG11bHRpcGxlIGJhY2tlbmQgZm9saW9zLg0KPiANCj4gSG93ZXZlciwgQWNr
ZXJsZXkncyAxRyBodWdldGxiLWJhc2VkIGdtZW0gc3BsaXRzIHRoZSBiYWNrZW5kIGZvbGlvDQo+
IFszXSBhaGVhZCBvZiBzcGxpdHRpbmcvdW5tYXBwaW5nIHRoZW0gZnJvbSBTLUVQVCBbNF0sIGR1
ZSB0bw0KPiBpbXBsZW1lbnRhdGlvbiBsaW1pdGF0aW9ucyBtZW50aW9uZWQgYXQgWzVdLiBJdCBt
YWtlcyB0aGUgd2FybmluZyBpbg0KPiBbMV0gaGl0IHVwb24gaW52b2tpbmcgVERYJ3MgdW5tYXAg
Y2FsbGJhY2suDQo+IA0KPiBNb3Jlb3ZlciwgR29vZ2xlJ3MgZnV0dXJlIGdtZW0gbWF5IG1hbmFn
ZSBQRk5zIGluZGVwZW5kZW50bHkgaW4gdGhlDQo+IGZ1dHVyZSwNCg0KSSB0aGluayB3ZSBjYW4g
YWRhcHQgdG8gc3VjaCBjaGFuZ2VzIHdoZW4gdGhleSBldmVudHVhbGx5IGNvbWUgdXAuIEl0J3MN
Cm5vdCBqdXN0IGFib3V0IG5vdCBtZXJnaW5nIGNvZGUgdG8gYmUgdXNlZCBieSBvdXQtb2YtdHJl
ZSBjb2RlLiBJdCBhbHNvDQpzaHJpbmtzIHdoYXQgd2UgaGF2ZSB0byBjb25zaWRlciBhdCBlYWNo
IHN0YWdlLiBTbyB3ZSBjYW4gZXZlbnR1YWxseQ0KZ2V0IHRoZXJlLg0KDQo+ICBzbyBURFgncyBw
cml2YXRlIG1lbW9yeSBtYXkgaGF2ZSBubyBjb3JyZXNwb25kaW5nIHN0cnVjdCBwYWdlLCBhbmQN
Cj4gS1ZNIHdvdWxkIG1hcCB0aGVtIHZpYSBWTV9QRk5NQVAsIHNpbWlsYXIgdG8gbWFwcGluZyBw
YXNzLXRocm91Z2gNCj4gTU1JT3Mgb3Igb3RoZXIgUEZOcyB3aXRob3V0IHN0cnVjdCBwYWdlIG9y
IHdpdGggbm9uLXJlZmNvdW50ZWQgc3RydWN0DQo+IHBhZ2UgaW4gbm9ybWFsIFZNcy4gR2l2ZW4g
dGhhdCBLVk0gaGFzDQo+IHN1ZmZlcmVkIGEgbG90IGZyb20gaGFuZGxpbmcgVk1fUEZOTUFQIG1l
bW9yeSBmb3Igbm9uLXJlZmNvdW50ZWQNCj4gc3RydWN0IHBhZ2UgWzZdIGluIG5vcm1hbCBWTXMs
IGFuZCBURFggbWFwcGluZy91bm1hcHBpbmcgY2FsbGJhY2tzDQo+IGhhdmUgbm8gc2VtYW50aWMg
cmVhc29uIHRvIGRpY3RhdGUgd2hlcmUgYW5kIGhvdyBLVk0vZ3Vlc3RfbWVtZmQNCj4gc2hvdWxk
IGFsbG9jYXRlIGFuZCBtYXAgbWVtb3J5LCBTZWFuIHN1Z2dlc3RlZCBkcm9wcGluZyB0aGUNCj4g
dW5uZWNlc3NhcnkgYXNzdW1wdGlvbiB0aGF0IG1lbW9yeSB0byBiZSBtYXBwZWQvdW5tYXBwZWQg
dG8vZnJvbSBTLQ0KPiBFUFQgbXVzdCBiZSBjb250YWluZWQgaW4gYSBzaW5nbGUgZm9saW8gKHRo
b3VnaCBoZSBkaWRuJ3Qgb2JqZWN0DQo+IHJlYXNvbmFibGUgc2FuaXR5IGNoZWNrcyBvbiBpZiB0
aGUgUEZOcyBhcmUgVERYIGNvbnZlcnRpYmxlKS4NCj4gDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcva3ZtLzIwMjYwMTA2MTAxOTI5LjI0OTM3LTEteWFuLnkuemhhb0BpbnRl
bC5jb20NCj4gWzJdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8yMDI2MDEwNjEwMTgy
Ni4yNDg3MC0xLXlhbi55LnpoYW9AaW50ZWwuY29tDQo+IFszXQ0KPiBodHRwczovL2dpdGh1Yi5j
b20vZ29vZ2xlcHJvZGtlcm5lbC9saW51eC1jYy9ibG9iL3dpcC1nbWVtLWNvbnZlcnNpb25zLWh1
Z2V0bGItcmVzdHJ1Y3R1cmluZy0xMi0wOC0yNS92aXJ0L2t2bS9ndWVzdF9tZW1mZC5jI0w5MDkN
Cj4gWzRdDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGVwcm9ka2VybmVsL2xpbnV4LWNjL2Js
b2Ivd2lwLWdtZW0tY29udmVyc2lvbnMtaHVnZXRsYi1yZXN0cnVjdHVyaW5nLTEyLTA4LTI1L3Zp
cnQva3ZtL2d1ZXN0X21lbWZkLmMjTDkxOA0KPiBbNV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
a3ZtL2RpcXpxenJ6ZGZ2aC5mc2ZAZ29vZ2xlLmNvbS8NCj4gWzZdDQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI0MTAxMDE4MjQyNy4xNDM0NjA1LTEtc2VhbmpjQGdvb2dsZS5jb20N
Cg0K
