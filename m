Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268673F0743;
	Tue, 14 Apr 2026 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188189; cv=fail; b=q4BTTLOkI06pT1pb4WIcrNexGDYjQm+NTapcwlF6VTyAvQChdU3LBNzkOBlXg17bfkYVI4FyPwoMuAL0BIncef2MBSeIv1xFYM+GagTd5a1COrzJX36oZ7zK8r1qeCTyZi7zR7s9dETSCW/hgY/7jQS/6s5z9F65RlTseCHKql4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188189; c=relaxed/simple;
	bh=Cv/b8ORGvLsoZSOWLAp+/MuEm/q5ovd330ogBKXxkIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uGPU5cJhWaTA7+BKY44JgUtgU6IbUAJmkChHK0ITDEIRFkO3H7e6IHX0SGCGM+4sgNmSsdgqqEhF/w4Kbwg3rZskw7ikZmd/j+X4keOqDvvchB7lZc92pHYozxOZ1Rz64+slh4DW4DxGQP0jcIhSt5NAAY/HRKgVPBYLoPqz7Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cU/haFN7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cU/haFN7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776188188; x=1807724188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cv/b8ORGvLsoZSOWLAp+/MuEm/q5ovd330ogBKXxkIo=;
  b=cU/haFN7C9QzkH15QzFBTuYrodTozQE7Jkxz2+L19X6hLkkUAuPG+ywi
   omTjUNyr4iOQJbxXKUNkQhpu3MOeIHeB/CELXx8tXoV0Twz7H6MUBq2a+
   GP5JGzN04M+az56Orcb0xNeeEAGzNbW7B1btHwV4Wbr7xL+0NHuwoTqTs
   dYyGmRiFX6bzOGjzAWyNYhAzxFTlBVhwZ7NdqE9YHgN9uWaQEr0kwY2QD
   Q23Bskp82HiJlZfAYnH2tZlyMVzUkQrEN+2de6AUkT+9Y5IMAR317vXs2
   zCtkK8bUkR0yxX/xBNDJmAbYCHr1+7jpj3SaaS9jvb2ZGWLEQyAJ2UmsN
   A==;
X-CSE-ConnectionGUID: DVyXTk9VTkeAPYEL65Iv4Q==
X-CSE-MsgGUID: IcKQ7EywQIWZERuD2VrnNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77034598"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77034598"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:36:21 -0700
X-CSE-ConnectionGUID: neNazXR4TZihqm5AoHP/vg==
X-CSE-MsgGUID: q13CwC5uRUGNXvXN8SzO4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="260589038"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:36:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:36:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 10:36:17 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:36:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeVn8soYW04IHjinxLlCUlfTbtYeSHvzFnUR9f+nvEcimwG+/y2gQUHOzsw8vXIgWhBx5wSuvE/HRULoManfjS+nJ33U7aO34EnMJynKNIPisrf8V/ptmbO8yGwlAOb4z/8z3rMe3C5numFw/Y8w00uSH5zI9nTsR1TFdL9GWhIwoRybtKIYUb25mEOBgtiQFei97zQNjVIQZEWmdkHttV1SlCxzNZqZ8GEWdWIzUSnonjN6izGbMFeTxHjQdetOF/r11/eqVkHYIWI1ggN/01eAKpqwVWOOs+H8ViDp+pOyp6jAgcqgqnoVqjXWtSPSy+cK4yz4f4fKgX2rsL2Law==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv/b8ORGvLsoZSOWLAp+/MuEm/q5ovd330ogBKXxkIo=;
 b=aCkrRlEwtYcSooLJKcHHLQxNCMvh14Y2hWpZnd2uKwq4ts/tStasBmlCBmQKuX7iul/MtgP35q7W46O7u3lxm2o/zcZ8ROq8GCqqit12J8vrStKqcNf76bAhYioT9HXKoQ8kyHVbJ0VNl/g3ZJqtRYWHl/dvkhA47WPCN7IlbLNfzI9YGYCo1r1Kqn31frSBdkqQ8tHr527Ldgto9EerZnUuL2jYtADHQAKXwXuAuJneAD3ebFmsGBblFL+S5kgHAdd0wePLYuLBQ6XcLuSQstNBGRd6UfN4KLvqYcm/pW+7YWVlMy1zlY/fCUR/DKqF+6mGT5kP0sKkPfkWWJn+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Tue, 14 Apr
 2026 17:36:00 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 17:36:00 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "sagis@google.com" <sagis@google.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [PATCH v7 13/22] x86/virt/seamldr: Install a new TDX module
Thread-Topic: [PATCH v7 13/22] x86/virt/seamldr: Install a new TDX module
Thread-Index: AQHcwQwDQ7ZxyuO8zU6gEwli2EidE7XZLAUAgAVCPwCAAHnyAA==
Date: Tue, 14 Apr 2026 17:35:59 +0000
Message-ID: <90b84fb7860c0fe41fd6b6ec9913c03f6db57ad2.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-14-chao.gao@intel.com>
	 <2eec98d012b85113b4e6876d07eb6513618e2404.camel@intel.com>
	 <ad4UsiCjY6V+Ox5D@intel.com>
In-Reply-To: <ad4UsiCjY6V+Ox5D@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB5085:EE_
x-ms-office365-filtering-correlation-id: 06e5d898-b3d7-4821-efdd-08de9a4c4b06
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Bfu2Z591fNyu5umGjAh1LubJoZ4rNPBogRZtp8sVvDuav28D2AeUOHWF8jrhGl1k+CuxEwBZd8bfWKhPHCzod6Ul/OMdKSB3pOoVPN9gUsEkrk2X5FNuMpfzOSmSmrYgzPxs6A0jqrIcOlb8f46fDTyIyqVDiUaABAT5jNz+otlrYP+84z3IsvBm98JIvfNTd1czJpntKln6XixVSg3Tz95J8iWLUvu22ehnysWOtjQLJX4Q06cyuN6GLpOMrpuxNlrd5aNWLHpqVWKvv220e8SA6vfzwhZN6pjhAe4Oeb65h66sG5wrkskjqCyteptnbHACgoB1H4noOWTzu6LbAC2HWGU9v0zR507LP8AUEp3cv83A4R/SK4dOOKyvyUn+yyAp9xtH0/D7avjTyN5kC+7A0AzTQh+hgncU5FKg094ZBOPwE2Kk5LsTIRMUlFbKitu67iuk3yJswScdrPkdDmK6GdHbqjqJRdXY54HBextzsVrFDwl26T7R84CqURKLmKy2sbZccBbri50XeA924BieHf80Z+DQ1zZ2Ki2zL2hS+/n5K39CzuT0FYbudMrMzcZxBVa4JrxWCz95ulMQrTjCqCTyCPBYUAY+Tfnxf5r8aaTrjcinQKxQTirrg2tcdarmEK0xqUviRVduzclmgwKLAyLQnoy1NomJn3T0x9/w6fRob1GJ5hkBVr8DfLl1FXVWLJ5XFfp7JMm9wlKH3V5Mr8zI90bi6fJGB9Q+OV1HskwCmGT1fCHszdQVV45rE4ToWKR2o0Z0AnShKF/gVJxhhBkLNYYVIVItDb4MAAk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkNtaGdNaU83VC9Xek93WHJUcEVRT1Q4MEx0S1JLSlBhT2t0NjJQZ1QwZS9Y?=
 =?utf-8?B?TzZSelNSNzJDVXlPZy9SUm1LSzh5bTNqRkMrS040RHMvWWliUnNtYWNqVmhZ?=
 =?utf-8?B?MXp5MXgvMWNGNWFrZFRDbkszODk2Mlo2MEtqc0FWakpvTiswWGxYTjNFN3dZ?=
 =?utf-8?B?WCtQSStwbnNwY2dlTzR6ZDN4dGxveXpna1RvVGFGUmFMbXNjM1VUcFBKMkd1?=
 =?utf-8?B?S090YjBEaVd3aEpEcS9pTDl2dzhQYWlQd0dRMFFNSmx1YkJzVkdmSXlDWEdn?=
 =?utf-8?B?c01xSFVrVEpEZVFZV1YvcXNncStUeXdWR3RDYklhVUcweU1QVjZ6L2I2WVhO?=
 =?utf-8?B?Uit2eERpQ0ZSYW5xcHI4S1dPczVnR1VTV1BJRFR2RjdHZENGTWF1V0pidGtR?=
 =?utf-8?B?eXFFOFQreEViVFFVc1prTWxnOVl2L1lWMUF3UVkrcG43UkhZSVhqMDJUYXhX?=
 =?utf-8?B?Uy9oOXQzZlhXSWg1WFd3d216R2d2bHgxK2dvQTVtZUNvY1FYNnlWUnJvdnpI?=
 =?utf-8?B?Z1V1SWpIOGRKOUMydXo5VW8xdFRjVnBJTXBDbHBmVjNmTHVXWEpSZzVCRGZI?=
 =?utf-8?B?Z0p3RFZiVjd4QVVOclZucWxWSHJNZy9EZjFSRlIwazNIVHZ5djRrUTVSUVI4?=
 =?utf-8?B?dEJNREJWeGhPczhRN0s0ZUhzVDZiSUJndHJiN3hxMm9QUkFWeFJDaThrZXg2?=
 =?utf-8?B?K1cyc1NQbmZlaXdQV0Q2SzVPb3BqL3l6cE1LQlg1MGNueUxWaXQxS2Yzdmlk?=
 =?utf-8?B?UGdRbzZmM2NGMFM5d3NtNE9uVG9jbURBNVorU0M2ZXpXb2hqNEtObnRZNEZW?=
 =?utf-8?B?TWp1aTc0SmI5L0pqMmZRRzUyeDg0MVdMTEgxeDlBbldITUFmYmdZS3RsdVhJ?=
 =?utf-8?B?NjdNNzNIdmRoNVZUeUxNUUtXTmlsT2M3OE9BTFBZZEc3VloxMG9ycHc5dlFj?=
 =?utf-8?B?VTZWQ0I2NzgrS0F6dE9WWVRDYUVMa1ppajk2a1NwWmZGbFFuVk9GM3NCV0pX?=
 =?utf-8?B?bFpObllONDZiRWJxVFBCdUFlRmYyZUxFQzc5aStmSjgzeUNXbXB6S1d2QTJq?=
 =?utf-8?B?aGx5U21qZ1M4aUZ6ZklwVnVjT1l6aXZKV3NnSUI1ODdKdlpUbENlcUluR0NP?=
 =?utf-8?B?UUpDSnlTNVgwUTZ1dEZlSHpocDlNN3BnOFk3cnlSNFVZOTBjRlVJV2NIZEk2?=
 =?utf-8?B?dFNpcjYzZ3A0YnQzNkRtdjZaOVlOVEp0QXpKQzg0ODlJV1FEeEVUa0t2ZVpo?=
 =?utf-8?B?RCtyTUNIM1k2VXp0djc3VTRZV085U25PYk9xYkxVZStGUHhhbWYxOU5keUsy?=
 =?utf-8?B?bVVuYUR4dE1IQWFKWG1xRHcrUExHY0tMbUdhMVFBUjJTNGZFeElMaXN1OEZs?=
 =?utf-8?B?WWYzUktYdmFTQitjZ2xDampWbjJnMjZzUGYrN2NEeFBhM3dhTDU1Z2lzUS8y?=
 =?utf-8?B?ZzhEWktBNzY0a2EvT3VMcDFLT3llQ1FMRThCMVNqWTFZUE52NHptS3JIMlh2?=
 =?utf-8?B?Rm9zTTUzQTh1SlBoMW1sNVFwR0pqTmpXODVuSjJrd2w2Q3lFeFd3MjFuV0Zh?=
 =?utf-8?B?NzJrLzhYM01pTFZxSExacXRmZGNKUWVkREhkclk2aXpqMWdNOFpsN0J3NzFK?=
 =?utf-8?B?NUk1bllnWEI3WmJOTWFubEE2bVAxdmJ5NXBiMzN4YkpTVXYwakdzam0zTlha?=
 =?utf-8?B?OFNTcEVOaXhHVzlUVjJsV3h3ZzhvWlg5OEh2cmROek1xNHZSZWprWlhrR3pi?=
 =?utf-8?B?bk5EcVhZQ1VDSzFsVUNuY1hRREJHYWNTYlFWT2Vhd2VwVEdXZG54UGtMcWJn?=
 =?utf-8?B?Q0NYMkRIVTRDQUxGTFhyeHJMTzVMQnoyZmg4V0Y3bytwdklvdzVhSjZ3SjFB?=
 =?utf-8?B?UmxlbHNVWXROUFlUUEhYb3hKRkdkc1pNK0VvbTI2ZWI2S3VOS1F6c0Q5SCtw?=
 =?utf-8?B?TnB0MHg0aVNtZkVlNnVXNkRRMkU5T3Bod0ExVGxFOTEvai9ENTM2Y3NQd2tK?=
 =?utf-8?B?Rk1TbnloZ0NGZHVWaGVHbm5vcWRHQWV2S1RqdmY0Uktyd3Z6elcvUFlXNG5t?=
 =?utf-8?B?OURmWDhXLzZjT1ZqSWx1Mzh3VU9RaldBd1VVR08vcEtTQTVmRTRncU1Va055?=
 =?utf-8?B?OFE2Skw4UTgzalNydmE4dWt0ZHZQd0Q3YXdGVWVXOHpmTnFXZ2pjdkVZc3Jw?=
 =?utf-8?B?cHMvUXk5NnZicHk2d3ZwdVRIbC9sWGluVDl3ZkMxZTV5MDlhZ2l4eTRVcElS?=
 =?utf-8?B?OTJZZnFEN2Y4QjMvQkUxQjNtUmdlc283SUN1SldlbnZyK1VNTFRCREU2Znpn?=
 =?utf-8?B?ZlhvWitXa0M1TEZ5UnI2NGRiVHlUZVRQUFg5UFI0aWlnYVhWWnpMbmlSTWt1?=
 =?utf-8?Q?GFYgbxFfnUULBIHg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60A9D99F205AC842908A48ED8C9A31AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TCIF5Yn479cVr7yOJp8WD2DI8bgBWmL4J2UT97pk+WX4tIYTnqaWu7Rt02b01tx7IikRrlcznfndNzI0C5eBBM22YUzH6yqp3T1SsJFM1Ff9J/N/vyF6Mf217Xqh/99DHdZ3HZ67hjacS4DOmxYRk5yRhy8PVsZCll8nh9SQNNpnM+wGQ0IdcxoUZSiC0RSJghoAzlgNsZKneA+ZxzfW0SG3UxzRNH5o/OqVxCY6VXZFMSuOW5W9hSIrU4bxlrW3UXciNbjkMV0Ijn+SWLP1UemnG1RQh8F0Irq7Us+sMRhIFURhE+mBxeSpmx92MlEJtErusVtfw2hhaUqJMedQ6w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e5d898-b3d7-4821-efdd-08de9a4c4b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 17:36:00.0005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKtzSmgsmTNqkPMEJi1UmudYtKfw7dc0j94kzSf0z1T6uf5Rxk1uhJiQXXmUHM0xQEAXXzXxHcG2MYrvKfZ+AlNkNt4AgBFVGseEp4LXCT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTE0IGF0IDE4OjE5ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiBX
aHkgdGhlIHN0eWxlIGRpZmZlcmVuY2U/IEl0IHdvdWxkIGJlIGdvb2QgdG8gc3RhbmRhcmRpemUs
IGJ1dCB0aGUgZXhpc3RpbmcNCj4gPiBjb2RlDQo+ID4gaXNuJ3Qgc3RhbmRhcmRpemVkLiBXaGF0
IGRvIHlvdSB0aGluayBhYm91dCBnb2luZyB3aXRoIHRoaXMgc3R5bGUgdGhyb3VnaA0KPiA+IHRo
ZQ0KPiA+IHNlcmllcyBmb3IgdGhlIG9uZSBhcmcgb25lcz8NCj4gDQo+IFN1cmUsIGhhcHB5IHRv
IHN0YW5kYXJkaXplLiBUbyBjb25maXJtLCB5b3UgcHJlZmVyIHRoaXMgc3R5bGU/DQo+IA0KPiAJ
c3RydWN0IHRkeF9tb2R1bGVfYXJncyBhcmdzID0geyAucmN4ID0gX19wYShwYXJhbXMpIH07DQo+
IA0KPiBpdCBsb29rcyBtb3JlIGNvbW1vbiB0aGFuIHRoZSBvdGhlciB3YXkuDQoNClRoZXkgYm90
aCBzZWVtIGZpbmUgdG8gbWUuIEFuZCwgeWVzLCB0aGlzIGlzIHByb2JhYmx5IGluIHRoZSBuaXQg
Y2F0ZWdvcnkuIEJ1dA0KaWYgaXQgbG9va3Mgc2xvcHB5IGl0IGNhbiBhZGQgZG91YnRzIHRvIHRo
ZSBjb2RlIGZvciB0aGUgZmluYWwgcmV2aWV3Lg0K
