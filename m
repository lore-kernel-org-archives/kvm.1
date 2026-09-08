Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE939396B9D;
	Tue,  8 Sep 2026 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902021; cv=fail; b=kdjbgoD77HwLm3xacCiuDewC1PrZHW8AQWXERrUnXuZSrOdgIInmMXbS+fWtXrMdPIKKe/knUmaS2H9tFjaXB4Oel+Rk2rCHK0ZelIDJa47A7Lm2uLW6B8160QxjQxIFsK5tCFlSSOzKTN6bg0LaxF7jbc8qBDtYStb+6kxprLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902021; c=relaxed/simple;
	bh=t88aJ2i47/MlSvJb+Cq4TaxzhJ5zAkuukwNJxreKvJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uJrLj8iWuF2B5IgmenL1xi/OuF46Yc9Kc+fmhXPNWnJrJCocpw+z3kBwSTxcqCj+C65JIDjMMKOhwG4E8igC+/alK3lGgu0pNmjPkvktEUJj9XzLkxUYyaGnPCqVC9fdpWCjvLjwUwAYgyWw8eK+DK+0yejwvf6ls61FTKIyhLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdecSexP; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdecSexP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788902020; x=1820438020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t88aJ2i47/MlSvJb+Cq4TaxzhJ5zAkuukwNJxreKvJ8=;
  b=KdecSexPWnJw6aUAgvoMKhx2wdZo+obPZi5M7BcHfx6Qzail7fvFWWZ3
   SY6tFoOudynpJ87XnDmJIW4PDSUQQseFxiMrUYQve435GnYOKBZjrzgvh
   N8oy34kg/dcqVSikXkeYjQC6u6FGMQWqRPm+wUmk0w80XCwgjRvnwG2EK
   vvyogLDgWqs319+uF45cG71EfEFgxInXXR2Pj0Kppc3s8GRDa9UH8RUVX
   mhEQL7+cn9p8bXlZ/bHvqw0qsI+7uUH9CfOYDbWRfGvbMQTraNoTqYYyZ
   jBGg9hg+7nv4reJzvBVgHEbVEU/w/2vOh1HSZzkRhmQb+dEJG2fC0XQwz
   w==;
X-CSE-ConnectionGUID: +L2HRog6Qk2RzjQP+6l9yA==
X-CSE-MsgGUID: KenbKi58T92XcLMW6KZ1zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89335413"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="89335413"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 14:13:39 -0700
X-CSE-ConnectionGUID: UXZd3a7jRZyIwItUDKQj0g==
X-CSE-MsgGUID: LBJubzP2SVucJdZ0W21ptw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="274902456"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 14:13:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 14:13:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 14:13:38 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 14:13:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8DTtmKo20UMr6M3XA5LuimNb4nnEN+P7F4DQhFtivuQVp2lnGXkMnzfYfhPKE+Jy+/YF2efOP3y1hfo2HexeXDxa/5+6j0FjOYRvoV2S+cnCTb1B3GLPzukzUYBaOXuCPBWMsDBDUtrgGOgrHpXPVWJ+mdjcuBjjRxZqb1hps9t002fgA2F80EOZp/c1ZnqpZ57eyx2FMBqXL1lkk+cZN9S5QkPVFRmS9XNbjs4sUxhzZS/d58jaVALAUVLS+MFP/5MaNXswLu30TD1EiBCZb4MfXi+wOUaKUnvb2pGfD8I0pygjY3a5ChRsUBkjJgfRcDDpERzeOv/t5UcBzagtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t88aJ2i47/MlSvJb+Cq4TaxzhJ5zAkuukwNJxreKvJ8=;
 b=Z5vYqHsgEU7xyVEuLLbL76f2/N9sYBQc28FsyPGYU/6t05OSaWXmEFWu0bm23ApzRGvVsOKAaZMCo3/bY7C4PVgVuMaPnaCETfDYfryFZC8eK1JSSQ+0/vJ7F4J1PSHlvk+r2Mv4tQd0cSkxMyTOLuHWuRMkOkM9dswWJQ2FmWbUasxIepH8Zc5iohMv08HuWF7S21wvJbQdmPGPAR44nq4B0ovar1VgrNn4bkwOkaOTpPCHJ1IeysZnBW0FXKoaL76OIypG8FNbjTuH38XLUyMn8P3kAeDPvJUwpNP5cTdJxAIVHGnaV/foQnHpspUrVzzNnokOE3yJ35ygrz5DDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY8PR11MB6962.namprd11.prod.outlook.com (2603:10b6:930:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 21:13:34 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 21:13:34 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
Thread-Topic: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Thread-Index: AQHdNdIg5EuCH7XFUE6a3Q+aSzpVqra50omAgACnLQCAAPSngIAAE6YAgAD+CICACMIfgA==
Date: Tue, 8 Sep 2026 21:13:34 +0000
Message-ID: <d8012e9acbe3c733b082c87fdbe9f229a8f7750c.camel@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
	 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
	 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
	 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
	 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
	 <cfe57e67-49ce-47d7-b20b-a29e23fe16d4@intel.com>
In-Reply-To: <cfe57e67-49ce-47d7-b20b-a29e23fe16d4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY8PR11MB6962:EE_
x-ms-office365-filtering-correlation-id: e9f6c4a1-a646-49cf-d64a-08df0dee0aaa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|4143699003|11063799006|5023799004|38070700021|10067099003|3023799007|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: GLjHqTvOUzUu0cKlvlctKPAo6hTTr5GB3A2Cluovh054O/PekW+9XPtqwJXNvG8iwYzKUT/Yo/0vo3fQtj5VxsoO8/YyfTqfywrxByJLqWbgb8BA/5tt62gwhJRi0H1P0XGalvgDjKjI+ph8Qc8n6on6hNofEl2NENyH+AN1ZGKm0ITkKLyydSwGdQh1fy9ASoshyrgROWLAmS3CMfap4nwJ/tcnEGkzHLetsv3F35yCsHPXUEmxeSq2pkAqQNk0pBEDk6lVUlFQe6KC4eVaF1QWpxBIzpyS6HYSzcXzDMLCccq3ns/9nFvg9hhlx7hs5FLZGJUsTv9/aT7zR1WQ8iDlbH3CXzktYI8D2s9QT5dn9/Rv75Pa80CW8bZ0J+6n+J2nafnhhhW8iTf9KbPT/KknVxd8qCQCxq8lnsiXqe9rkFuEzbA3Sjk9EHoWT6r/Tva3TWxxT8wvW3qeV3nBmViVlm+0Y9Wxv53bKdSePSPYWQI6783SBLpaoYoGH9QQr9r8l2VTvcRnRe7ZxzppzAHRvy+jMxz//139+GxSEptlIXsniCSBP7qJFfBqCOlUmr2r6D6U1k4cAGBJtsKXEJeY3HtuGfSWebCSObxKnmYM9E0WBEly7d75tXQCWRrk+4ifzZMfqH9MhYSukl5PrjCl9ftXjCKeYvtl1sLnqim+PEm9ZAebWOMqn1blm39dun45VhyxdvQ2lvvs0iPvAiiqdfpuryEW+nZ9HJ7dx/s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(5023799004)(38070700021)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkIwb0U3cWJxMGpzRTBUWjZERFdRM1p1UXpJSGJJWE13Uk45RDBnd2xWSlJG?=
 =?utf-8?B?UmMrTCtLYlhDQk1OQTBXaDV3TGFXVE1GbnhzVmtOYmZkT3lTUlYxSm9Ua2FR?=
 =?utf-8?B?YXkveUp4Y1hoL0dtU3lhNk5Mb1JQcCtXRWl4NDNPeW9Ibjh6MlVRNHZXNGFH?=
 =?utf-8?B?RFlVUnpnRW9VUU1YbEpEbHdtT1FHbVV1SkRyZkttd3pLdkg3cDZoYngyVG9Y?=
 =?utf-8?B?VXZiN1FRRzlhWHhJbCszNng2SXFOZTU5YUlTeW4zSHE2NjJ2d3lvQTBMUVE3?=
 =?utf-8?B?bS9ienZTTjBmNTIvL1JzU3lPM1NFbUVaQzMyVlFJekJQaVJkNzlrblc1cnlT?=
 =?utf-8?B?cXlnSnBBZ1E0R0VQODRTdndtSnQ4RGJNS1YvWmkrRlM2U3VBajNNbWhhSDVz?=
 =?utf-8?B?ajFFTndVMS9TbjBVUFlCVDVpZndHcHEzcDl1Vk4rYS96eHNaYVdreVMyenRH?=
 =?utf-8?B?ZkJ3NjhQYWMwTEtYdzgvT2pqVml2MlZURzliY0pNelpmcHlidW8wWWtHYmxv?=
 =?utf-8?B?cENwWUwydTJvR1p3VmE5OXZtTWw4a3hUQjFROEFsbGZzUUJrcjQwdzVNOVJj?=
 =?utf-8?B?TFF1dk4zTys3bFZhMDVsSlVpZWJPOXBHS25oMVA2b1dZWFF0S0xSdE5MY3F3?=
 =?utf-8?B?T3MyRWswSTF0OXhDdlFFUjlUcTJQSzliRngybVA3UHFBK3I0M0s3RFByUUYw?=
 =?utf-8?B?VXRFRmk1aE0zMWEvY0pBcFN2ZUVsRFFPU2wyMzZab2ZMQWw3czNTcm9TaTJN?=
 =?utf-8?B?MGF4alV6UStqc1NvNjN0Z08vZWNOYWx5VE0yQVBMMzluRlNIQUhjSE5GNGNv?=
 =?utf-8?B?YWRUaHdOQkhadTBseXR5L3FsTGtjL09lZDAwWFZmd1RkU2ZyTTZoSkRrbVhC?=
 =?utf-8?B?SnA0YXQxbkJzNUxwNkYwYjRlV0pzWWFGb2JXZktVRzl4NUM0NFBLT3FNVHkz?=
 =?utf-8?B?N2NTTEtpU1EyYi9zY1B6K0t6bXY1TFBROGNsM1VvcldlN2ZsNkJKNHVjaEg4?=
 =?utf-8?B?akp1Q2tHVThiTlhjZlJGbmxDVlkrM1FtYkhFK0ZLWkMrcFJsV2dsMnFmMHBW?=
 =?utf-8?B?a1BMcjI3RUhocHlsVE9aQk54eFY1ZU9OVG1vVXNNWkI3OUVUSzdWbCtiaFRj?=
 =?utf-8?B?THMySWF5NjhJZk5teEoxYk1ObVRtSnRwNkgwZWtMb1BaVjl1cmllK243b1lF?=
 =?utf-8?B?c2Q4S2pvMjVMaXZxMWhtamdmWUIzMFp1cjFRaHNrSHRFeGZEcTIvN2ZKbENY?=
 =?utf-8?B?UXkrWjc4SXVMbGFTb0hIakpnUGRGSlV2YTh6SlZWQ2ZVQnlIWW5mM0Ezcmty?=
 =?utf-8?B?cXhlT2ZsdXFBMWJNVGM3VkdzSGxhS2RabzFMQlUvOFY1ZzR0KzdnNkxuNzVY?=
 =?utf-8?B?WWNQdENOWXpuTC8zWVJMV0FBZzFQMUVNVFNYd3IwVUhxUjBuT2RSTHJwTHZN?=
 =?utf-8?B?dHpueWM2M2RWaGlacTJxenpaY09GTkdrdnF6dHc2MURxNS9ySXYrcHgvQ0pk?=
 =?utf-8?B?K1hhUXpvWkVoeTdiT1haZC9CNC9tU2x4eVpWNURCa0ZIbnRwVXRBZkdOeVVH?=
 =?utf-8?B?UzdjdWxCVHYxMWdhcUNNbWJiM1VZZU5mTThRMENZU0JJMmxYRTBsQzdYRW1R?=
 =?utf-8?B?NkVVK0I0eEZnTTVNR2lBckdkQkZVdFhSOHZYMGNQY0M4TDQ3bHNHSkYzZHJQ?=
 =?utf-8?B?MGtWL0pINW9PS0FqZElwUk9Gc0UrdHl6Tk9KblpCTy9xRjRJUTMzSGxwRXBD?=
 =?utf-8?B?bGJDYXcvSkNZK25uN0pFOUozREVGTXRiNTRaL0pPRFErb2E2NUN4eWtyWHp5?=
 =?utf-8?B?WDF0ajZvWEZ0RzRrMGJSN0hyVi83VU45RDZHMmlZSEVNSG5ibWtnRFRyN2Jq?=
 =?utf-8?B?U255RTZtYlcrckRTeERMc0gzb3pWRlBMQUFBZDllVDJHbjJSZWNXTEE2YVE1?=
 =?utf-8?B?Y3owcytWeXhNN3NucmRQSkRNQnpUME9ibnJDOGsyMkVlRUJjV0h3Z0lNNC9Q?=
 =?utf-8?B?d1JJcUFxOS9iSnJ0RDFTVU9mK0o2M1EyNDQ2aHhpTExkSGtISmhmeENRSmpt?=
 =?utf-8?B?U0xRZlk2LzVDVUNwRFFBT1JCR1p4KzZJQWtvZGdXeUlqVGY4dEJZY0JwYzc3?=
 =?utf-8?B?bTR6MjNsTUhLd2ZVL29jRHdFdWwwY1Y5WVJBNmRySHdnMy9aU1RhcVBkMEQ1?=
 =?utf-8?B?eDFyaUx3enhSSEZGOWhIV0NJZHZXZUF1SG9mcjl5WFFlSHF2Z0I5YXhGZ0Ix?=
 =?utf-8?B?dGhsaW5Sc0pWTTYzOXMvd2I0RXNEZzJPd0p1d1Q2WUpMRExqS1VZM3RJb2Jr?=
 =?utf-8?B?T1hXVzV6SXRCSzJqa0IwR09mZ3FXOS9mVm5GdlR3VE5xNExla3A1b2YzT2w5?=
 =?utf-8?Q?nBuDGetky9uZdDUA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C6DD4F367F1EE41863208C0E3B206F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nmLlxP88AbMCAi34MLfKQ6h77ki1f38xhVLQjWCLjLXAnSQjBn0+nZ135dsfEv212pZYFFF+Rsm63qUfAL2x/j3cD8rUpmRX4AzLN9Sb9yIOOgzOiZMHxvXqUb0RB/9nS+Pgz5ayygAHBeHfJL8EKJI+oFi1b5GBNa2rc2q5jhw1LW1LGvL0MvWAHNeYU7FVnvxU80BxFD5PnD59ClpHR/TyQfBsVs5sHIZXHcSNJYWpqAk3QbA60T9yBDfBOJXjUFuGbMBxHz5hBtnlDMOTT/ch02ebEyEnYk8UhwUequB6RuwvbUCvCKeC+7ZUn3ulUw+IpaUiXOFU2FnAy4V89g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f6c4a1-a646-49cf-d64a-08df0dee0aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 21:13:34.2094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5H8Hmsg54hFLalmxKMi3iNmtYvbZrX1JeYF7U/yurQwzOLxKtuH0ZFoTyuDjcwH1gvhTSSE4N4RsamqGwtaDRfAg815WPcofIX2PYVnbBrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6962
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTAzIGF0IDE1OjI4ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiA+
IEluIHRoaXMgdmVyc2lvbiwgVERYX0NGR19GKCkgYWxyZWFkeSBjaGVjayBhZ2FpbnN0IGt2bV9j
cHVfY2Fwc1tdLCBpZiB0aGVzZQ0KPiA+IGZlYXR1cmVzDQo+ID4gYXJlIG5vdCBpbiBrdm1fY3B1
X2NhcHNbXSwgaXQgd2lsbCBub3QgYmUgZXhwb3NlZCB0byB1c2Vyc3BhY2UgYW55d2F5Lg0KPiA+
IA0KPiANCj4gSSBzdGlsbCB0aGluayB0aGUgcmVhc29uaW5nIHRoYXQgd2Ugb21pdCB0aGVtIGJl
Y2F1c2UgdGhleSBhcmUgbm90DQo+IGNvbnRhaW5lZCBpbiBrdm1fY3B1X2NhcHNbXSBzb3VuZHMg
bm90IHJpZ2h0LiBCYXNlZCBvbiBpdCwgc28gd2hlbiB3ZSBhcmUNCj4gZ29pbmcgdG8gYWRkIGEg
bmV3IGZlYXR1cmUgZm9yIFREWCwgd2UgbmVlZCB0byBmaXJzdCBtYW51YWxseSBjaGVjayB0aGUg
S1ZNDQo+IGNvZGUgdG8gc2VlIGlmIHRoYXQgZmVhdHVyZSBpcyBjb250YWluZWQgaW4ga3ZtX2Nw
dV9jYXBzW10gYWxyZWFkeS4gSWYgbm90LA0KPiB3ZSBqdXN0IGRvbid0IGFkZCBpdCB0byBURFgn
cyBsaXN0LiBUaGVuIHdoeSBuZWVkIHRvIGNhcCB0aGUgcmVzdWx0DQo+IGt2bV9jcHVfY2Fwc1td
IGZvciBURFhfQ0ZHX0YoKSBhZ2Fpbj8gSnVzdCBmb3Igc2FmZXR5IGluIGNhc2UgaHVtYW4gbWFr
ZQ0KPiBtaXN0YWtlIGFuZCBtaXNyZWFkIHRoZSBjb2RlIG9mIGt2bV9jcHVfY2Fwc1tdPw0KDQpX
ZSBjb3VsZCB3YXJuIG9uIHRoZSBjb25kaXRpb24gYW5kIG5vdCBqdXN0IHNpbGVudGx5IHN0cmlw
IGl0Lg0KDQo+IA0KPiBJIHRoaW5rIHRoZXkgYXJlIHR3byBpbmRlcGVuZGVudCBzdGVwczoNCj4g
MS4gbGlzdCB0aGUgQ1BVSUQgZmVhdHVyZXMgdGhhdCBLVk0gY2FuIHN1cHBvcnQgZm9yIFREcy4N
Cj4gMi4gYXBwbHkgYWRkaXRpb25hbCByZXN0cmljdGlvbnMsIGUuZy4sIGlmIGEgZmVhdHVyZSBp
cyBub3QgYWxsb3dlZCBmb3INCj4gbm9uLVREWCBWTXMsIGl0IGNhbm5vdCBiZSBhbGxvd2VkIGZv
ciBURHMuDQo+IA0KPiA+ID4gSW4gdGhlIGVuZCwgdGhleSBtaWdodCBiZSBkaXNhbGxvd2VkIHRv
IGJlIGNvbmZpZ3VyZWQgdG8gVERzIGJlY2F1c2UgS1ZNDQo+ID4gPiBkb2Vzbid0IGFsbG93IHRo
ZW0gZm9yIFZNWCBWTXMuIFRoaXMgaXMgYWxzbyB0aGUgcG9pbnQgSSB3YW50IHRvIGRpc2N1c3Mu
DQo+ID4gPiBEbyB3ZSByZWFsbHkgd2FudCB0byBtYWtlIHN1Y2ggcmVzdHJpY3Rpb24gdGhhdCBL
Vk0gY2Fubm90IGVuYWJsZS9hbGxvdyBhDQo+ID4gPiBmZWF0dXJlIGZvciBURHMgdW5sZXNzIEtW
TSBmaXJzdCBlbmFibGVzL2FsbG93cyBpdCBmb3IgVk1YIFZNcz8gV2hhdCdzDQo+ID4gPiByZWFz
b24gYmVoaW5kIGl0Pw0KPiA+IFNlYW4gbWVudGlvbmVkIGl0IHRoYXQgImdlbmVyYWxseSBzcGVh
a2luZywgS1ZNIHNob3VsZG4ndCBhbGxvdyBmZWF0dXJlcw0KPiA+IHRoYXQgS1ZNIGRvZXNuJ3Qg
c3VwcG9ydCBmb3Igbm9uLVREWCBWTXMiIGluDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
a3ZtL2FqMWZpXzBTQnhNSzVXT0JAZ29vZ2xlLmNvbS8NCj4gDQo+IEZvciBleGlzdGluZyBmZWF0
dXJlcywgaXQgbWlnaHQgbWFrZSBzb21lIHNlbnNlLiBCdXQgZm9yIG5ldyBmZWF0dXJlcywgSQ0K
PiBkb24ndCB0aGluayBzby4gSXQgZGVmaW5lcyB0aGUgZW5hYmxpbmcgb3JkZXIgZm9yIG5ldyBm
ZWF0dXJlcyB0aGF0IHdlIG11c3QNCj4gZW5hYmxlIGEgZmVhdHVyZSBmb3Igbm9uLVREWCBWTXMg
Zmlyc3QgYW5kIHRoZW4gVERzLiBBbmQgcGVvcGxlIG1pZ2h0IHdhbnQNCj4gdG8gYnlwYXNzIHRo
aXMgcnVsZSBieSBhYnVzaW5nIHRoZSBURFhfQ0ZHX0VYVFJBX0YoKSB3aGVuIG9ubHkgb25lIGxp
bmUgb2YNCj4gVERYX0NGR19FWFRSQV9GKCkgaXMgZW5vdWdoIHRvIGVuYWJsZSBhIGZlYXR1cmUg
Zm9yIFREcyBidXQgbW9yZSBlZmZvcnQNCj4gcmVxdWlyZWQgdG8gZW5hYmxlIGl0IGZvciBub24t
VERYIFZNcy4NCj4gDQo+IE1heWJlIEkgbWlzcyBzb210aGluZy4gSSB3b3VsZCBsaWtlIHRvIHNl
ZSBzdHJvbmdlciByZWFzb25zIGZvciBzdWNoIGRlY2lzaW9uLg0KDQpJIHRoaW5rICJnZW5lcmFs
bHkgc3BlYWtpbmciIG1lYW5zLCBpdCdzIG5vdCBhIGhhcmQgcnVsZS4NCg0KQXMgZm9yIHdoeSB0
byBwcmVmZXIgaXQsIEkgdGhpbmsgd2Ugd291bGQgbm9ybWFsbHkgd2FudCByZWd1bGFycyBWTXMg
YW5kIFREcyB0bw0Kd29yayBzaW1pbGFybHkuIEVzcGVjaWFsbHkgdGhvc2UgdGhhdCBoYXZlIHNv
bWUgb2YgdGhlIHZpcnR1YWxpemF0aW9uIGhhbmRsZWQgYnkNCktWTS4gQnV0IFREWCBtb2R1bGUn
cyBiZWhhdmlvciBvZiBhIGZlYXR1cmUgY2FuIGNvbmZvcm0gdG8gS1ZNJ3Mgb25seSBpZiBLVk0n
cw0KYWxyZWFkeSBleGlzdHMuIFRha2UgZm9yIGV4YW1wbGUgc3BsaXQgbG9jayBkZXRlY3Rpb24u
IFRoZSBub3JtYWwgVk0gS1ZNIHN1cHBvcnQNCmluaXRpYWxseSB3ZW50IHRocm91Z2ggc2V2ZXJh
bCBpdGVyYXRpb25zIG9mIGRlc2lnbi4gU2VwYXJhdGVseSwgVERYIGVuZGVkIHVwDQp3aXRoIGEg
ZGlmZmVyZW50IHNvbHV0aW9uLiBJbWFnaW5lIGlmIHdlIGhhZCBlbmFibGVkIHRoZSBURFggYXJj
aCBvbmUsIGJlZm9yZQ0Kc29sdmluZyB0aGUgZ2VuZXJhbCBLVk0gcHJvYmxlbXMuIFRoZW4gd2Ug
d291bGQgZW5kIHVwIHdpdGggdHdvIGRpZmZlcmVudA0KYmVoYXZpb3JzLCBvciBhIHdvcnNlIEtW
TSBiZWhhdmlvciBhcyBpdCB0cmllcyB0byBjb25mb3JtIHRvIFREWCBtb2R1bGUncw0KYmVoYXZp
b3IuDQoNClNvIHdlIG5lZWQgdG8gYXQgbGVhc3Qgc29sdmUgYSBmZWF0dXJlIGF0IHRoYXQgbGV2
ZWwgYmVmb3JlIGRlY2lkaW5nIEtWTSdzDQpoYW5kbGluZyBvZiBpdC4gVGhpcyBjb3VsZCBiZSBk
b25lIHdoaWxlIGVuYWJsaW5nIHRoZSBmZWF0dXJlIGZvciBURFggb25seSwgYnV0DQpvZnRlbiB3
b3VsZCBpbnZvbHZlIHNvbHZpbmcgdGhlIHByb2JsZW1zIGZvciBub3JtYWwgVk1zIHRvby4gSW4g
dGhlIGVuZCwgaXQncw0KdGhlIGdlbmVyaWMgS1ZNIGJlaGF2aW9yIHRoYXQgbmVlZHMgdG8gYmUg
c29sdmVkIGJlZm9yZSBlbmFibGluZyB0aGUgZmVhdHVyZS4NCg0KSWRlYWxseSB3ZSBjb3VsZCBj
b25zaWRlciBub3JtYWwgVk0gYW5kIFREIGF0IHRoZSBzYW1lIHRpbWUuIEkgZXhwZWN0IHdlIHdp
bGwNCnN0YXJ0IGRvaW5nIHRoYXQgYWZ0ZXIgdGhpcyBzZXJpZXMgaXMgaW4gcGxhY2UuIE5vdCBh
IGhhcmQgcnVsZSwgYnV0IGEgbm9ybS4NCg==
