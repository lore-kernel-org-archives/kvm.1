Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C892BEFEE;
	Wed, 30 Sep 2026 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728358; cv=fail; b=jBzeQc33RomHzl4OSfqLq0pFDU3hbIM9K4Gb0QRUa9XpYIsxkpaQ+3efUsA8gEsJSvA9pvdKBASHk+rp350FiiQngCJjEA+tseQdZgouaPl81sC5O5byGPcPzCRwu0vsUsfk0w6ee4ej+NWn9nY5q+pXwJEnejSZ3sW7ZOf5kq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728358; c=relaxed/simple;
	bh=DLcmnldLAe1Fhcn3eTJqZKanwRKRVOFzHpFklYf3ANY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NKfcTTyn69Xv0jyQGR/siImi5s6fJSau4jpD71V1PI40S8l0O36qafoly57npMdjinHPDtIc/ame7PTbSE5j0vVkgc3w27RzzDKis1AiHYIkvx5xN0whfQuYFExe7ichbh8cG2xNTL7JvvwcsotWq+3/9jrQc7EbIf0MG4M7YnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgHhoQkD; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgHhoQkD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790728356; x=1822264356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DLcmnldLAe1Fhcn3eTJqZKanwRKRVOFzHpFklYf3ANY=;
  b=FgHhoQkDoRmasv8sanP/xiUs7DViEfh6yutRDCZ2MHLhxQHpUqZb6sEC
   rznr7AZho4pzqBH+sY+1LEyQqARqXGlK34bPeLJdlf63b+V8CFnpI195b
   KJLUfu2i6F+umAELLz3ShegReP+TVSc1AFYc5/RlC74vaQvVYjmR78smY
   0Tj6OT3XZjjT/lks6JmEpZVuKj0dKXvZ244xAimQMPMD86pUtAdVaih81
   hLXjtyQNamQzXyvYdjr9u9U2NzBqWlzSq+zGw04iIN57Ow3AIaFzfTOBH
   GfgIpYbXrsGGEISDvoaomn4V3Rjob4QGBKo/2ijyfQveekmWWWbhhciI7
   A==;
X-CSE-ConnectionGUID: RxS3IvU2QEuaHf0zxOOjxA==
X-CSE-MsgGUID: tQCVEYs5SQi8LuMLfhHWAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="95271331"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="95271331"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 17:32:36 -0700
X-CSE-ConnectionGUID: cPVHi0LwR7qprhS9A0tkyQ==
X-CSE-MsgGUID: MvoHLTFFSIaQGUIaIk+ARQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="278737101"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 17:32:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 17:32:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 17:32:35 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 17:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBkjvrz/Yj6BlHn0TsJJxDNEFu5t31TqEoDe1bwk5M+Fk1c+UHVTSzSMSIEBuu8niikwLj0uXuGz13QYRG/BOkWwXFdHaiTOJWJA41HDIG1KcHDlc4itywetIkuPVxi4jdDIB+A1cVRZyc/g465pu4TeW/WU1Vi510XYN6gDj/iA7Sy97sXUrjmBALiTj5CySin7p/SJAihC8SyDvDybexDWYjhMkxhKD/7ug0XuP8xC9jb1Md1zfpLjiyQbcCn9NVxfsYQwG2aDrLLa5hoFZ2uVkXV/KtovbFCXcUxPVW4IOCry1yNrExX9Vfbwp56ytKzMt37axRMA2KWbDM8I9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLcmnldLAe1Fhcn3eTJqZKanwRKRVOFzHpFklYf3ANY=;
 b=sqGwfz5IuXUDpBQoHvzcxfzh5t0H+k8ao6ZJSv/rHzLUiIPs97P1g9DB4PX9tHnSaRXDU9L3bLQi0y1Z2DKcb9zmzaRu6cmaUmSQJTNbQ0z2krVFdSjky5o7fZxwYltdfHq9wwkwvFuLH5hVIB/UQT/X2kTWfRMnGOiza2SBFs7V8VCtzeKz+B5UYOj4I1MVbzMlE9r8s8MOpR9hN/N89In62Zd5lZnve01IH3pE3vgPov1vD/UnBzQJnrV6pae0aC8ZV8bfdM8knzTip8qh2JTdEhpO9nm5g92FZyYh62YDj7HBxGmeFeBpHRhgEcwW/qWKnOtdOmNGDBLNuZtuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 00:32:33 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 30 Sep 2026
 00:32:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>
CC: "jthoughton@google.com" <jthoughton@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "Annapurve, Vishal" <vannapurve@google.com>
Subject: Re: [PATCH v2 0/3] KVM: TDX: Syntehsize SHUTDOWN on unhandled EPT
 Violation
Thread-Topic: [PATCH v2 0/3] KVM: TDX: Syntehsize SHUTDOWN on unhandled EPT
 Violation
Thread-Index: AQHdUHBFUydNTIT8MkO3FyCkDkrTNrbmRXqA
Date: Wed, 30 Sep 2026 00:32:32 +0000
Message-ID: <3c0ee89f560b0235f293b32019327186785aa795.camel@intel.com>
References: <20260930001127.3170009-1-seanjc@google.com>
In-Reply-To: <20260930001127.3170009-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH0PR11MB5015:EE_
x-ms-office365-filtering-correlation-id: 76625fa2-ef0c-41fb-f4cb-08df1e8a5134
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: GNkMLyh63CDtUlOOKufwMVd94Ygmxw1Oxk5S6p1napJEby3HMEGxMrlK86UJi9YA+DUsbGYbUWAU9rqQWGn0WLwXmhLdK4rzFRI4DyV1WCFVRz6JcrcW3uqMvM8zWDNr/xM4tw0Bj0M2ZlnAFnkP1gkdM1IAHJCFImTvv80XhQk2ibme77xAmHLb8p5ApmgOem3iyRkJXU70RlH9ZkoMnU77Rzp8ytV/gyYtCRpqU8BNdDEg6NSkPGPwC/wGx4IPSCH6oP6AkQNCOm1Y/7A4jiNZC3KO1AHi5FZ4axp4SF8wRcvymctX4sisqV1PTbItKP2amOIT+UPHCBwCIRDqwNmHOKNSSx1kLt0l21z4m2mtsvcTatVgDBP28eFEIpmQb34FujkQKDgVISpzMEZ6QLqn5uHny0K9ZbkZA60c6XpeMOosaQ71SX+Kz66VGbAeo+9My0LaPTsUOMgZmPjnP7Glw5l6+5RTdaSHSZJjJySCca868EDRT6aNwdtmor3b6/yEL9v+pSar017AnxkNAFidr4ghFwFkEAHFsbT6vErUdZ9aFpxoUyKvuMux7qewY2oyHbWN5nk9eH02zAAyj/lkzMdaO0AhRqwj96bd3hPmuTibBnNdbLZeqm3732+paPTFt4t5fqQ+jK3EyDWr14QCr1p582AkgeXZOtRsN1Lg4OZl1YkcKTvSL41i1myAxedYKKALMOQoa0f5YnthyWCM595CFhFJvAy/EusPG4s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MC9TYnJuV3hhZ1Z2Q0RZdUkwS3FBeWNORDBkd0hGN2F3UUtERFZsQzN5Mldk?=
 =?utf-8?B?dmM0eWVwZEZleHBIMitKSWJXRHZEeGM2U3F3S3haNUhNNWorSjU5VTlQWjVi?=
 =?utf-8?B?djVPY3ZRaGFmMmo0UGxCY2F6N2NWVTF6b2p6UFROeUs3dExpMWlPZFlMR0JN?=
 =?utf-8?B?YnFjb3hZVktlYlBvdkdXZWtWbEtwTTFwTDZvam91N3N6MWdFMFFSSGdwNnZt?=
 =?utf-8?B?R3BRdFBuOFVVTDhUVXZPSWpyQW96bU81YS9iZEFxdWM3WkxjWXd0QnI1bUxX?=
 =?utf-8?B?QXZSYlFIUkJMTFVjWkFjR1Y4czlhbTk5MDcwaW93bW1BN1cwMU1mMkxpSUtK?=
 =?utf-8?B?NlNwSjZ1QWJpSE1icHJlUVpFODM5U2hhNDdqb0wwVTk3bmpQNnBPTytUZmJ5?=
 =?utf-8?B?YTA0a1JPQnZaemMrekVVK21mV0QxN0pINW0yd0VrNGYxTTh0RDg2cTBrbVhY?=
 =?utf-8?B?YUNhaEhLMFJuYUlUSDJlNk9SeW8xYWRkaHRGZVFuaHdiK1VNbG5XNXdwekMv?=
 =?utf-8?B?Vmh3L0M5VmEyYUxTM1V4NElVb2xPeFhWaXRGcTRpQWNXVmh1TEdoN3ljb2Ja?=
 =?utf-8?B?cTJFSm9LVjVJTU1YeHo2a3hra3dobDJDR25pUHUycnJwWmdrYUlVZlE5N01L?=
 =?utf-8?B?c0dUSm5NR1diZVpUNkJ0TmdqamtqUTVRN1J1SnI2ZkE2SW8rVm45cVQ4RWoz?=
 =?utf-8?B?TjNvSUNYSG1pUHJwSm81Y05XSEplMlFhZEp1RWc2amFuUjFkdHRjV0lBcFNL?=
 =?utf-8?B?TjE1TldJaUtzbGp6d2ZKbGNvNWFrblpnWDJwL3FkZWV6V0F3ZTFiNTBXaENx?=
 =?utf-8?B?alJEL3hIdkQ1bS81aFhhbUJzLzQ2b29JcTVQMmRwOUZ5eGZZeisyU0dMMDRp?=
 =?utf-8?B?YmEzZDhXcWk2a2xYckw2bTJMak9RdjRIRExHUWxibjRYMnBzQzkwS3hVR1ZH?=
 =?utf-8?B?S2xZNnV2aTd6cnVUSmYrcFN5TlZIaEQrK1RVcU80ZWpMUjlibTJQb2lRTTJV?=
 =?utf-8?B?YmRyVUhOMG80NEFnZ25ENm5ML1NSbzgwVzFSTjNuQjllWEVvUFhPbmd5ak10?=
 =?utf-8?B?RlBlK0ZJM2ExaExPWkU4M1ZMS1BDeVhBWllIc0lWRzNJNG81V2lmaFBOVHFv?=
 =?utf-8?B?U3M5TWkzUWk4SGVMTC9Pa0NDQXFSeW0xREVrSEpkS0lJT0RJQUFZRUduMHJM?=
 =?utf-8?B?TEYxU21tdHVDMzJhWUJpOEtHRjd4NS8wZXdPNjZmWWs5dnROQUFvVU1pZGlX?=
 =?utf-8?B?d1BmMG1kV25RTmlCdncvanZONmN3dGdKanJPZmk4VWFjUWpJWTlOVFpuZVJ1?=
 =?utf-8?B?aDJJK29RbDZVVzN5WGNCS3ExckMwSkU4QVVRbHpBb0xBRmJ1MHFNRmgrdWts?=
 =?utf-8?B?NHE0QjdlTWRpa2F0MWs5T3Z6SW5WbDR5cUVSRTVLNVl3NytDZFcvWG41UjJt?=
 =?utf-8?B?SnUzQm1QZVNIQVNMeTd5NHpPZ2IwL1VtVEF2N1FRZm81ckRTeUpqYkxtVHA2?=
 =?utf-8?B?bnA0Ui85bXAzQ252Mkord25XQVVIcEtJTE4wV0x2ZjhSaUV1c1l2OG5Udnh3?=
 =?utf-8?B?U0FscGphMFUvZ3Q5bUpYZFhVK1BqL0lGdC9qczV0RWI3bWkvdU1YNEFlelRU?=
 =?utf-8?B?RVF1NnhZcXEvOElQS2d3S3Y3S2RZMjl4cC9SM0xzNStDZXZScDE3dEF2RWN4?=
 =?utf-8?B?ZVZSY3dmY29YUVZaUkpHRFJuMlM4QU5ScTRGcVF5OGo4OExkWGNsenIwUU5Z?=
 =?utf-8?B?VVJJZzNHSEV4UkRkVWJLMU9XR3FWcC9CVkpXQS9uVmpsbUZRMjlBcWF5cVJK?=
 =?utf-8?B?amltRXIrZEx2WUZIUS91RlZsQnJlWE5SZWxVbW1Tb0REUnNZeUVFZzlQQ3Nj?=
 =?utf-8?B?cmJmTzVBa1orZlltUHZvVlhEVEYrakIzODlnR1BRazVnMC9RQmxzaEtjTnZC?=
 =?utf-8?B?YTRWQVk2TnJnNmQ5V09xYUREUzh5NHUyWWszb0tUaTBITjA2NHRXaytXZXNy?=
 =?utf-8?B?ekUvOU4zK3JGTk1LZkJBZjhHOWF4dkJ4UzRpV0dKZm9XNk1PUnZ4VTFzZnQ0?=
 =?utf-8?B?WVlZaEd6cWV2Zk95c2M1d1VxR3o3Wk5iVTlOSC9NUzdzZWlzck9yMjRoY1Ru?=
 =?utf-8?B?VXRZV2hLNE01WXZxVlJIMkQxRHA3UHZ3U0c0VXZXSHdUeERUTkxjQzdlVjJE?=
 =?utf-8?B?U0NaZmdtM3BnWWVrd2pRZ0dwanZ0a3Qrb1BBWFZRSHdUazBkM1BDdjV4TzEr?=
 =?utf-8?B?bzFTeUhlSE12NFNGVU9kUDQrc1Vtd0tsVE12aWl1bGpxQUJ5MzdUYjRmYmVx?=
 =?utf-8?B?Y1JnbVp4eVZvOG5GVTRpT0M0VEl3SCtRa1NXeDY2RnZMa25KY2grSjdrOG5v?=
 =?utf-8?Q?3CNgy7FkUIE+T3RA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EF6295745BB944393F989284137C94C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sOXzUpJQ5EdVl3LzMqaQucdvfhJyhJMmEttDBSZ7gek83l4iHeD97fK5z/YRuHEBZqaEhWZDK2LPW+/DOnMFBgWr7q2yehQhkYz1bgjPKr/OihZrpsg4ng1vDPC4axu23TRy3hiVHfPPTrnqdDWYnO1g07U5sCVmsasSsWA4T8Z57ivxc0U1dBN6BAhLYYw82SsGi9wCT9cnN37UwNMbGc5qfvejOPaH32qwBYY5DJn6KfGWjyNioYoPGvWVQhUyk7YaHm5IsnRROEBAF12kFyulsb8g8YH5pQUcEskv0KMYM7cXgDXGrfo7U3VpqenFp7rC/IMxCIho/H46hC7aPQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76625fa2-ef0c-41fb-f4cb-08df1e8a5134
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 00:32:32.6177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKUWpP4Qg454QQ8ojeMtoh/alb5+O/caWk8JyAV/E+fgXmkD8P0QaHEzqOTZOb371qaM2RsDuSIU+hA+eODAzuH40O9rg0ZFSkRXRNHsJWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDE3OjExIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBTaWduYWwgU0hVVERPV04gaW5zdGVhZCBvZiAtRUlPIGlmIHRoZSBndWVzdCBhY2Nl
c3NlcyBhbiB1bmFjY2VwdGVkIHBhZ2UgYW5kDQo+IGhhcyBkaXNhYmxlZCBFUFQgVmlvbGF0aW9u
ICNWRXMgb24gc3VjaCBhY2Nlc3Nlcy7CoCBSZXR1cm5pbmcgLUVJTyBpcyBhbGwgYnV0DQo+IGd1
YXJhbnRlZWQgdG8gbWlzbGVhZCB0aGUgVk1NIGludG8gdGhpbmtpbmcgS1ZNIChvciB0aGUgVk1N
KSBtZXNzZWQgdXAsIGFuZA0KPiB3aWxsIGxpa2VseSByZXN1bHQgaW4gdGhlIFZNIGJlaW5nIHRl
cm1pbmF0ZWQgaW5zdGVhZCBvZiByZWJvb3RlZC4NCg0KSSdtIHByZXR0eSBzdXJlIFlhbiBoYWQg
YSB0ZXN0IGZvciB0aGlzIHBhdGgsIGFuZCBJJ2QgbG92ZSB0byBzZWUgaXQgYWN0dWFsbHkNCmV4
ZXJjaXNlZC4gV2hhdCBpcyB0aGUgdXJnZW5jeSBvbiBnZXR0aW5nIHRoaXMgZml4IHVwc3RyZWFt
PyBDYW4gd2Ugd2FpdCBhIHdlZWs/DQo=
