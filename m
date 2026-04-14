Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C93F0A8A;
	Tue, 14 Apr 2026 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188355; cv=fail; b=UE8o/O2pVlqHcQVti6tuzLhmTwFkRtUBF3WHPZBp0FxrDmdJwALPJKlzN6crUL42E7Fr/teYEYRTMjfzq58cwd0UzCLmfKJT6fhatqwzPbAh41WXlBZmX38Uy4vxX41QyvUzXA8F6BacB5RBPwiOQk0yH126p/N+06BKGzUVMd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188355; c=relaxed/simple;
	bh=jIQgZ/Pc1EaFXn1enUT43FXYYn1EiiEHf9twFiTPti0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m0QWxA/L6yu3AmO4PS6azoYBThK/ouwKsUqTv2Z0BqavRIbCKicIr2/xt6z0gvB/w1zFVR5gzene7QTdOTR1bhjFX4NevEZ028vKdX1Q5c00nODxFPvNTfAIn2OfxY8aqOHm1RIUdKSm1BEdOSyw2VURIEY6exPgISQ0rzWTc3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioOCGRBZ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioOCGRBZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776188353; x=1807724353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jIQgZ/Pc1EaFXn1enUT43FXYYn1EiiEHf9twFiTPti0=;
  b=ioOCGRBZFKRQ4L6BQaOchvlmhdLRlEcqaCFpJtmfWJBI9ziyp13OQvDT
   +Z/noEyZm6ynLhFPM4BLPEfmzXbMFza7eVLIZwtq/8i4aP59d5Ni0IVHW
   RWZr0Ep8ME7cb0oJjuKjPS2mC5Ae6n3ZwxOvdFKzR3gTE0USPwcDSWfY2
   TrGNpB0VZZp2/DMZzkZrqeOApwxvqFX3uBASE+r2yLa/ymdIiDPjuLrt+
   72CK/liuT5wPMXoPygjAXgvLIjpq8YXpmbAdwlzqlNg7nvXYOkBkUkVaU
   3yiB+uXfWLTE92NpuosFmuw/wowf29OFdfMCWuCoXjSomfDzoHV1XkfJR
   Q==;
X-CSE-ConnectionGUID: 2rHTtdbqQNmEE4TZTK89cQ==
X-CSE-MsgGUID: uE47vLSoS1aH2uKkTKuvqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77034905"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77034905"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:39:13 -0700
X-CSE-ConnectionGUID: FAJgAQG0QDW5ycBeOXFJ/w==
X-CSE-MsgGUID: HXuwK2SZQ7SdnZSk9ea1OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230383257"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:39:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:39:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 10:39:11 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:39:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgPnua/mkl4r4trsLvj6rN91JL2Y25FRZ1iLwMQpxUB7v/t7+F5ln7xwvf0zqbYV4d8Q8NgW5n+yK9Id8gro+r/6bEeZLu0FshLpnSrxG4IoTGVwe7D9tTtcdb9OMcjvZ9of1xBAVWiXMWC7B1X6qkDSiTq9KllKHEMurIs1/Cx1rrsTGh43FDonRs5V3ci7+vnZnf0pHoxkGu2DdNUDtUZ0dZZxwxjt2WKksvi25WpTneooQ9dBOexOcJYT+QxKKXQd87QegfCU8/AMY+kMKw27jYt+wf4GTD87eldDUTtE+3YLLqzwsVK4hEQDkMuD2L6Z8s4HVZhhj45tUJErvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIQgZ/Pc1EaFXn1enUT43FXYYn1EiiEHf9twFiTPti0=;
 b=i971pDwXl6RCFxTcfGH9yTnYvYQwDHuXghnHbBGRXETK2pKPz4wdEuMWXD0B4RSZNvvpi/9nq0ZpKLhTXttP4kjoGCJE6KQSFeVZ4gRAuHTsouIMlcD3De++9MkhIUXoHzprqVWtjJUFtlYonfHRD2124V9BTSYpnGN6BukWVc5kzx3vlMOLWSOYMmOTaycfHEhQRt9r5jVvhQl0yWexWJpND6HFYDRfHJ9aSY49gUittd4csanKAZa/OM4Kdf4pr6acKHdfQ8uenrrfRKABVrkCoOmd/5jZ2stQgphec+hrxV1zXsH5Pia3fSmqS5Wv6k5NcJRj9bT4k+YEHzw36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 17:39:07 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 17:39:07 +0000
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
Subject: Re: [PATCH v7 22/22] x86/virt/seamldr: Log TDX module update failures
Thread-Topic: [PATCH v7 22/22] x86/virt/seamldr: Log TDX module update
 failures
Thread-Index: AQHcwQwLJaw4VKJe1Uar8HVQfCmNn7Xdf0IAgADwmQCAAHk7AA==
Date: Tue, 14 Apr 2026 17:39:07 +0000
Message-ID: <2b1741f544a395b75ab60617a9023651ca99a9c8.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-23-chao.gao@intel.com>
	 <e4cdab7d83bfc1c7fe3b5759a987c71b922585b7.camel@intel.com>
	 <ad4WCJdJ2MrGvkWX@intel.com>
In-Reply-To: <ad4WCJdJ2MrGvkWX@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN2PR11MB4517:EE_
x-ms-office365-filtering-correlation-id: 7e69dfb3-15d8-4062-a4f2-08de9a4cba9a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: GVLZDQp/hJ5FjVPpKrQAlcO/IWgVEOXbiZ/Ph9qTEVkpYVWG8/pOlHiDGjjSTjQWBOZWKgfspXRz8InA4yWUQJ/tpJB+dLKR0Pvue1fSj+0WrHahrU/mqy8AnYtoi5Ic9O/OlI8hHBi28SXzhCRCJ9Lkh/3vx4/ftcqAQJgBwCzAr1+eJ6jFlQRFVGLATOnjG7pOPULDjyxpwQUj81NXDHAIO61ZtsZn2Grh6DxlECQks+Bg5o7sBcnWfacZIg05GIpoUoZ+wgPkA0RJjLVujplThy9onEUjDYIFvDq8jp9r+zcWJOYbMnsUS8L0uV0wLT5fzXzhDP63LarnP8k8Qj1iyQodosar0MwjNd0MdH9rXyMxiroIiLkawiF8FeK8USvSjwWg4a3ybUdwc/x/V3JJTtzDUz6R4Q+DiLKKkclg1P3UP86E91gzd1JhpZvG99xZAuQWmXfrS2O5BiRcIFVp9nPd+0lzHbG8l9Nhg2/ea1qdfidk9Unon5wJFDm+c8Ot+UanFxWJVrNR1BL8caLNsk/Ptdh0VIc96ebRs8VOIzBiT6dSYCxygA+oQeu+ICZPkxqKli0/eZsgfnVAxc6YKPdDIul6FGGMNCUVFs3bMj7ttidPr5GNdeMfEezC0hFHavsW4xSZAB7N2MGK9SvDPfarBZuQr6nGFQNhJEND+5VJPVRYzHaXzCaYHUtD1+U0GwhBmbtsa0V3yes+RGiEdpoZRFwZmvUPoX9+NQuxL0pkcso9P52ULHupIAky
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHZoUmN2Vy8zZjUrTVQ3UGRCNDdGNWNpc05LQjVESEgxcVdnMWpmVE5VcEgx?=
 =?utf-8?B?a0NqNnJrVGRyTHJpb1Fsc3NDWDJ6NUVFQ1BFNEdhaCtvYkxoMmxobHhHUEF3?=
 =?utf-8?B?T0k2K0NvRjdoc2lzQzNuTy9pRHBLMkpyUll5R3RGd1VkaFRKYTl1SUFDdGl5?=
 =?utf-8?B?Q25sMVI5bGI1OUlacEc4WkNKcWtPOWp6ZGljN0dsT0pCeUpMUFRtYndBcENa?=
 =?utf-8?B?Qk1STFRsOG1xd0VVVDdtbEcxT1oxMGNWNzJqQ0UwejZLWnU4UXh1ejFCT1dW?=
 =?utf-8?B?bk90QjFzZGJWbzNzVjdEeVVsd2hYUGs5eEoxb3I5UVJzRE84YnZ4bkY5SE1B?=
 =?utf-8?B?aW9idEZpaDU5QmU1ZnZUbzYvRnVvTVM4QTNsbUlTUGk5Y1V5RXdTTE01SmNI?=
 =?utf-8?B?eloxcHQ1aUJ2NytKc25MN3BsS09kaGlJR2x1WkJOWUxRemRRT3B2SVVlc3pB?=
 =?utf-8?B?NDk2QmI1Z0RPeGdHQTBkSW1zc2IzbXp1dVZ4ZTBDQWdDVWFRbUtHb3VzWFBv?=
 =?utf-8?B?T2hONUdMc2REVllLZ3NxK0d4bTJ5dWh1YlVLNkJXcy9HV0E0N3B2M3Rua1p6?=
 =?utf-8?B?VEp4VGRtS3JxQTU1VklQL24zWndOZG52c0tvNTlPaWV4TTZIUTMvRm9yZUZI?=
 =?utf-8?B?c2ZheTMvUFY0RE85THhhZFNaZFU3aEVhOStES3ZRYzRCU25FLzZXK1dRVXFx?=
 =?utf-8?B?QjF1ejRTZmhmTmtDY3R2UGExRkpTWmtkVTcva1NUV0VseE9KTHNvcmU3eXlV?=
 =?utf-8?B?RkxObTdWRndVUXRGRDg5RnNKR3pDRkcvbkZlNFVNbDFhRnBJd1djaVFtWTZ4?=
 =?utf-8?B?S0VvSDJVQitVdnVaQTMrVG5sQ3VQUWVORzMzYUNuQURHZEluSGY0bGZsaXhq?=
 =?utf-8?B?QUIrMzgyK1JmU0FjdEJvcTA5NFJPQVdXQ1ZaMnF6UERFcXFTL1ZuMWZ0d1JV?=
 =?utf-8?B?T0ZKemRKbnU5RGlhSFFtMzRLb3ZlT3k5MXBQZ2pQNTNGSnlUSThGandMZmt4?=
 =?utf-8?B?dUhGRGdTMUthNEpQZGtSdWt1NThlNkR0NjAzU1R4dWJzWEVZVnozVHJjcDRC?=
 =?utf-8?B?MGhMM1FrYk91MWNnanc5UWI3REFOamhKWlFJK3VBZVBNUTJ6V0tXUVJKWG1s?=
 =?utf-8?B?YTlmbi9aMkJFZmZRNDdob2MrSzRzZ2M0YnB4SkV5eWNxRnZld0VWMjYvVXM4?=
 =?utf-8?B?S00yeGZielN3cjRTU1NVR21EVENmdFU5T3k1bEVUK3BNQllOMitiekJaT2x5?=
 =?utf-8?B?dzdOMENlejdHN05XZ1ZUMVp3bjNvN3dxY3NmbFRTL3pCRS9DeGxVNmNaSTBq?=
 =?utf-8?B?ZGtMOEcwZkNhOURpUXk1UVhvcmFOTUlmYldRRlJhZFdYRWNGbDFHZTJTM1ZV?=
 =?utf-8?B?RGNkMWFWZkZ6aUZlZHhJT0llR1hIdUhITVNxUGJrVnhBTnhBTnJFN2RicDMv?=
 =?utf-8?B?N3dMSG9Rcm80M29WL1FMSFY2MU1DOFhucmpXZFg2U0lqYTdNN2VtMTVoQlFK?=
 =?utf-8?B?WlZNdG1rcHpHUHBxaXY5Ly92YWp6eU1nN3BYdGl6NElrWnFMb21CaXlmWGFs?=
 =?utf-8?B?MmdBTzZVL1F0UjFlQjAydXVkeDZyR3BNRjE1NS9sVUlYZTUraGtDL1JpRmd3?=
 =?utf-8?B?TE43enNEOFAzOEZhT3lESVVqbk9CUzJUeER5WStOdFkrcndtUVFKOGlPeVh0?=
 =?utf-8?B?ZjdOUUdUbTI2Rk9mVS81VTQ4OUs3U28xbkJWMHEwNDlaejZiZWgram9UQjdM?=
 =?utf-8?B?WnNieXlTeGQxNVBZQ21yRG5YTFN0YVFINENrRVAvd0FHR0RZOGZGQnJGM3Zr?=
 =?utf-8?B?bnBDWGlIMkYwNFE0VTZ6RXVtSlRDRXdhTlY2bHMrYTVXZEQvRmlhZUdXWGVZ?=
 =?utf-8?B?ZmcwQWwvdGpJZ0dKYUNqRjJzWU1KdUtjM05mSGdHWERFR2VydTBwQ1dOT2Mv?=
 =?utf-8?B?eGUxRDR6NUZ6MDltMjBqRFFSODZjd1BrSVVkMnlPSTRraGVZeTBrSnZ1YjJG?=
 =?utf-8?B?S0xnMFBXcW1mWTZ3Skx3Wmdpc0x4MTFtK0JSY0gzN0NTU0dGZTgvd2RuM1dI?=
 =?utf-8?B?Ym9FellwWWkrNWtqVCs3d2xvZzgzMTE2ci9WeFdCV1VPOHBpbUpHQkU3Ujlv?=
 =?utf-8?B?dDRjVzc2YnFxQmM2a25qNVJjNFd0bFAwbllRc2QwY0JJSDJkRlZBeDVicEtL?=
 =?utf-8?B?MHYydWVhcEVHWmpIOEM4dDR1OC9DNkdqaDh1dnNzbWxORUJDUkhyUTVRYW1z?=
 =?utf-8?B?TVNUVnljaXhNdTNDM0QzTnNEM0lsd2c2NGE2M1FpNDArakdaVnBBQktXRDBz?=
 =?utf-8?B?ZTcrZ0RCVHpONHNKMWhGVTNsU0dIOHE4Y0lZMitnamxucjVrQUZJU1lsRG9T?=
 =?utf-8?Q?1B2WSGx1PQniF6iA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4439A4306BFFD042AEC2F1F5D755EC3F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uUO+i7tojpvnrWpGbKDoTnYuMntK4uwbFe7n8lY6njKlOdOpKrBNiOtv0KHbWDIFOjBMnV+peujAH2nsgI+dk0ZBt2ZbdQAE6A2WppSF82La1EbX4DqE3xSvp+IoTLNKbR7MHHTbk/O8jVCajDlVjl/QSUOsxtBCnXGC/nhec55ZDM/dpe9vFylKJzxhfkp3rCgxGDvX9/G8EJVjbh9HbPatIXXKXAjZ1uc+eg9Tms6vWCHoMjLM7GXX5lMqSjTWIvBYcd+eM4d7KkugAa/ZmekZVYJRiCZwL40CNQC2sWSxqLgF+/F2Z8RZgWX/LLKARr9qBsB8uonaDbBlra9JPA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e69dfb3-15d8-4062-a4f2-08de9a4cba9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 17:39:07.1443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnmOYr1nQIswQVnfwhvPBKduuVXa4sYl7GuFz5p9/L8Pq4kkBzHwnopQCJl3aDSffzhfX2HF7IV0m6kDpnN74aOa8N0FR8JLj/kw+pudW1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTE0IGF0IDE4OjI1ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gT24g
VHVlLCBBcHIgMTQsIDIwMjYgYXQgMDQ6MDQ6MDVBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3
cm90ZToNCj4gPiA+IEN1cnJlbnRseSwgdGhlcmUgaXMgbm8gd2F5IHRvIHJlc3RvcmUgYSBURFgg
bW9kdWxlIGZyb20gc2h1dGRvd24gc3RhdGUgdG8NCj4gPiA+IHJ1bm5pbmcgc3RhdGUuIFRoaXMg
bWVhbnMgaWYgZXJyb3JzIG9jY3VyIGFmdGVyIGEgc3VjY2Vzc2Z1bCBtb2R1bGUNCj4gPiA+IHNo
dXRkb3duLCB0aGV5IGFyZSB1bnJlY292ZXJhYmxlIHNpbmNlIHRoZSBvbGQgbW9kdWxlIGlzIGdv
bmUgYnV0IHRoZSBuZXcNCj4gPiA+IG1vZHVsZSBpc24ndCBpbnN0YWxsZWQuIEFsbCBzdWJzZXF1
ZW50IFNFQU1DQUxMcyB0byB0aGUgVERYIG1vZHVsZSB3aWxsDQo+ID4gPiBmYWlsLCBzbyBURHMg
d2lsbCBiZSBraWxsZWQgZHVlIHRvIFNFQU1DQUxMIGZhaWx1cmVzLg0KPiA+ID4gDQo+ID4gPiBM
b2cgYSBtZXNzYWdlIHRvIGNsYXJpZnkgdGhhdCBTRUFNQ0FMTCBlcnJvcnMgYXJlIGV4cGVjdGVk
IGluIHRoaXMNCj4gPiA+IHNjZW5hcmlvLiBUaGlzIGVuc3VyZXMgdGhhdCBhZnRlciB1cGRhdGUg
ZmFpbHVyZXMsIHRoZSBmaXJzdCBtZXNzYWdlIGluDQo+ID4gPiBkbWVzZyBleHBsYWlucyB0aGUg
c2l0dWF0aW9uIHJhdGhlciB0aGFuIHNob3dpbmcgY29uZnVzaW5nIGNhbGwgdHJhY2VzIGZyb20N
Cj4gPiA+IHZhcmlvdXMgY29kZSBwYXRocy4NCj4gPiANCj4gPiBXaHkgaXMgdGhpcyBwYXRjaCBh
dCB0aGUgZW5kPyBJcyBpdCBub3QgdmFsaWQgaW5pdGlhbCBiZWhhdmlvcj8NCj4gDQo+IEl0J3Mg
bm90IHN0cmljdGx5IHJlcXVpcmVkIGZvciB0aGUgdXBkYXRlIHRvIGZ1bmN0aW9uLiBJdCBqdXN0
IGltcHJvdmVzDQo+IGRlYnVnZ2FiaWxpdHkgYnkgZXhwbGFpbmluZyBleHBlY3RlZCBTRUFNQ0FM
TCBlcnJvcnMgYWZ0ZXIgYSBmYWlsdXJlLg0KPiANCj4gSSBwbGFjZWQgaXQgbGFzdCBzbyBtYWlu
dGFpbmVycyBjYW4gZWFzaWx5IGRyb3AgaXQgaWYgdGhleSBjb25zaWRlciBpdA0KPiBub24tZXNz
ZW50aWFsLCBzaW1pbGFyIHRvIHRoZSBndWlkYW5jZSBpbiAqLg0KPiANCj4gKjogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcva3ZtLzYzMDgyY2QxLTE1YWItNGFhZi04M2FkLWY3MmQ5NGI5YmI4ZUBp
bnRlbC5jb20vDQoNCkRhdmUgc2F5czoNCiAgIElmIHlvdSBkb24ndCBuZWVkIGl0IHRvICJ0dXJu
IHRoZSBsaWdodHMgb24iLCBJIHNheSBraWNrIGl0IG91dC4NCiAgIA0KVG8gbWUgdGhhdCBzYXlz
IHRvIGRyb3Agbm9uIGNyaXRpY2FsIHBpZWNlcy4gTm90IHB1dCBpdCBsYXN0IHdpdGggbm8gZXhw
bGFuYXRpb24NCnRoYXQgaXQgaXMgb3B0aW9uYWwuLi4NCg==
