Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAA410D3C;
	Thu,  4 Jun 2026 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573848; cv=fail; b=D0VJ71YzvVMKfKYYmWCao/IL9vtRxj2fA313ixxDLwL/A6Nx3C+dlDyfi2//3nejjvwT5WHEsygCihirGQZP0VWNrjo4oXba6wn7Z3/qx8p9EnoK51IMA6gXQrOJo/QSQ/QSvzTdniVPzk2liOeoP207hr58O9QqvMERvApj4cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573848; c=relaxed/simple;
	bh=tGpuwc0tq9F8+iiGqkHcdYEsYQkRogd/nOcwJb9/EeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cOgWoorZo9MBZeot1+yYTNWGUCl5ZzZEE7ivzgR9LCsjlor39cdUsEcMr5CV/bDBA2lAbE0hbQm2YLYvBv43B8n2V+LQvHQmt3egkrcnGD5JD5p53XXFSCMJQl3F6SDJi5qNoOJ5+ZtTQwX4Iye91onqaCSH4WCD1eQPBy8BW2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJma2qGN; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJma2qGN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780573846; x=1812109846;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tGpuwc0tq9F8+iiGqkHcdYEsYQkRogd/nOcwJb9/EeE=;
  b=lJma2qGN9TrHTD4VvQUaAxswdACRtqxrfvU4OdQj0r1TAe1lTumo5+0M
   HVnagAdbqaHbhB29ySbqFy7B9L68XvqHtIooYpcdnw3T2qwsEm5pEQN2y
   PRetHbumUHitiUKeUsdnSa13TOuFveb1qurrC8S/gF1pZ6L1m5D96K493
   5jSA4nR4m/ug45Fu4/n9RI5Cehm2ZGzl1MK/8CVx/fROT/AAiwlpr4XNt
   BrfJ0kEkrw67bsVtYgOkTrGqNnb261BKZ/1fcQZY+IWVcVVS/7svw3mLq
   eFUQsXD4sGLfjXKNwLk13Rf9YbHi8gFDnXlvHAdOTXGVRazpx887Qo8CW
   Q==;
X-CSE-ConnectionGUID: lK819o0USOeO/rVqdiirrA==
X-CSE-MsgGUID: sNn5ZxTvRECJznBqlgJ6yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80433269"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="80433269"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 04:50:45 -0700
X-CSE-ConnectionGUID: UOHX5TMgRQ63HC7/Eb2brQ==
X-CSE-MsgGUID: OZcq0HN/Qd+6qGDYKvy19Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="274768863"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 04:50:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 04:50:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 04:50:44 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 04:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axwH3ZPRIYej3B4myhGmPd1WxLLAvOYPtxfv6i5D5T9bO1x8+A0I7hmp5fsu+Ypu5o5ZymaFTNppPunRP8393p7jeGiCxW4hajfJPecF4raj8mNYiGjFX57KRfTHow1ATyz61u3Cc9n+aV5C3MlS2oSfMtff6tHUQ1Rudaduky/ZagroWASVWFWIaK3nwLLz2JO0xEQU3Wz7OCj2sNsLO+9bJYJ/mJLSKvSsgpFOGt+n87WA/AbA0wXVZSKfRHAxOOkE5Vnj9zS+T7fo0jIyrNwcNL8zyw81VZr6xvQIKdd3ZVJdL+raXAWlrfDbEMPigr1r9RMgk2Nr2EfFtCFALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGpuwc0tq9F8+iiGqkHcdYEsYQkRogd/nOcwJb9/EeE=;
 b=Y46AhRk+m9k2utwjoMRxCyK9gECd5JQD4j95E5bDjdyAQDxYlfODduLxu6wCuHODaHOmdVS3wfrWGRY/Q64/hMmMZOlEQWXL1+fUHn5Sy01fqLZb3tIRcJt3D3X6zjL5kVkMZLyvm1+jg0/Rk6/R7Pv2HZWqtr39vJiQ21en44AqIrakgbrbN5JFgAjt3aVL8TaVvvz1fqDxRqWabPkkmEVzQONlG8jUhymyV2ydJ5M44jv78l2gRXXmpHIye3h4diXwaV7KhbD/TxAsE+ojDO10ZmWB7mBe7VQfKQx9q4zrmrNWCRhWmWlcMms9cN6FPHZg5PSQnWyW7nCdyqXFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA0PR11MB7863.namprd11.prod.outlook.com (2603:10b6:208:40c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:50:36 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:50:36 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 25/40] KVM: x86: Expose several TSC helpers via x86.h
 for use by MSR code
Thread-Topic: [PATCH v3 25/40] KVM: x86: Expose several TSC helpers via x86.h
 for use by MSR code
Thread-Index: AQHc77nFfbq/FzVVaUyFhcKpYyxIwrYuUUAA
Date: Thu, 4 Jun 2026 11:50:36 +0000
Message-ID: <b82785f8d9ee8ff2fd68b65b16ce32dabf53894f.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-26-seanjc@google.com>
In-Reply-To: <20260529222223.870923-26-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA0PR11MB7863:EE_
x-ms-office365-filtering-correlation-id: 05ebff91-c6bd-43fb-bdf7-08dec22f7e02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099006|4143699003|11063799006|6133799003|38070700021;
x-microsoft-antispam-message-info: yp8ciqNeOHqpYIHo9ayot1poa/fiS6hoBRIuvWidB5oLHWoUcV7X3zuo0FywI+PL4krWyCXuS9rYCpu/VVxtt7x17hj8EPO+FCNe6nQWM7nRXCHO/zlaLms2tf8bmhFEflFFmGHA3/4GpVM2jPXGjmzU6N0p85HMIoO1vRkTys8sVOWn9cpXiLnPHgSPn412hijEPPBPp6MI28QCTMLVongnSq9JEMiIj3YnsOjAznU4vNMYwyQsGq7iE3jaRk0s+UI1dJcpyPtwUP7XyzyPVWZ8CTSPmo/p6IjzUpfeED78KYpKtXFBFZNg7nTG3ObhodI8eJaLs+Cy+uKZGDDOZFuGgqVVG3WtWtFyiGRBNv5KxwcVq+flrVjdmzJw2yVHHSJp5KBGEIPcTX80ygmaCepYgmgv/RkSCfNJXi6XUbbR4ns+8kb9x2aSA6CMwzVzeCAytHe7U+c2b7xn4xAXHYo7Sau38VqwLyFO7TmWApnfTaF+aOY2sA/2sUMqYt1Ks+1KtFf7Lsm8rZzIs+rrtsYu/bVu6yLmXO2b5Py91diz2Ct4Mn8nVru7ylEaLqIHXvIb+On280OcX3YWfWzw9LC43mZ3Mvcn1smMHXz6T/uk1ct0NxxM12eSRMnn9CGRtYJkRmA0ep6wjuB2iu3DP6KCut9XSDVQWf8fDNa1MZ5VLbxteNdYtQQglTf+7VaHXs2oZauQFPSO+vJTYQ0ZPRL+VxrZc0ZBEK6lqrgsI22PUDt64BLfL3ZBJgz+mm+d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU50WWdrSFZvdXpNQ0IydjduTjgzL2NVSHM1MzFLUGpCZnhMK1pSK01mMHk3?=
 =?utf-8?B?aDJQOG5KWlhuOEt0RXdVdnBTKzFZVjZQRlg3T1FLWWZvSjUycE9SbUdleTdU?=
 =?utf-8?B?VEF6aC9sUndGOXluNUdxN2Ewd3pTV0NVUVMzWWNaZHZLaDF1Q0U4YXpmRVhu?=
 =?utf-8?B?OFV6c25xWllZZDVQWWhONVFOOFNobE9CWC9Jd0hNc2F2ZFF5aXhYVFNYY1dm?=
 =?utf-8?B?MkE2UkxTZS9rM3RTcnVVWE1tYUxBQ2doNzNZL2RWek5Na1Z4a012clBCQm03?=
 =?utf-8?B?ejJOaWFIMGR0UUFWMXFmNlh4N3ZMdkJMcC9FbERLUCtxZGNRNi9qRkd4ZzVa?=
 =?utf-8?B?aE51bEF5MUx1RWtJMUpUWnFTbGhwQUxocGVTdk5RRVh5OEs2WFpBclhacnp3?=
 =?utf-8?B?Ujc4ZWhSZzNFV3o3aXl4K0M1cG1XbzRzaEhnb0xoeDAxKzRmenZNMnh4aXZv?=
 =?utf-8?B?UEF2ekROWGlFUGZndVRvYnNEUTNabU9WNXBZUkhhSjhKSUFJQVpmdHltQlgr?=
 =?utf-8?B?UW9uQmk3ZGJTZzVPejlDNDBPelRXd3IwNUZqOEowbDU1aC9rRG51bzFpUkZZ?=
 =?utf-8?B?WE04alEzMUFKelZ0R1VPTi84SHZQcEM5Y3BkaHU0M2FaSkxFRjZ4R2FJemsy?=
 =?utf-8?B?a3lmbUl5UlFESXliSFBqS0lvSlZCaDViZnpYdUZIZ2diZVFkVzhPMHhqUGdJ?=
 =?utf-8?B?alR3Y29TeDB4eFFDOUlNd3I4MmZNQjJNWk5OUTNBZVN3VFcxQ0krY2l6Y09x?=
 =?utf-8?B?WHpyL1RDNnFJbVVVemxxV0dNQ25BUldRUElaS0RHVFBESCthUGtYcDBkVldK?=
 =?utf-8?B?M3h3NWsrd2F3ZHRkUXhjdDFqeW1ZUEdieTd3MzE0TjJOcnFYU2NDOFQ0M1JX?=
 =?utf-8?B?cUcxd0I4S3cwN3UzS1hQNUVnanNMbmRlYkdmTG5WeDVjRmFqZXpaQksxdUpr?=
 =?utf-8?B?ZDlCeUtxRWxqUnV2K01jdVFxWlpwRHVnQ1hLTzh0SEtqRjVTdjBIR3hENlIw?=
 =?utf-8?B?TkJ4ZWlLSzBnUVAvREduek1RRU5aNnZ4U2c3WEd3blJRWGlRZFdxK04xNExD?=
 =?utf-8?B?dXl2UHE3Y2l5MVBselFrUHVxRUp5OXV2b0dkdW5yZitrbkQyUlZhLzArcWx0?=
 =?utf-8?B?TEUyRlhEbmlaZVc4d1JieHo5VmVkRXJ0RjZYNGFNL3pQWThiKzRhTU9ac3dt?=
 =?utf-8?B?MDJXY0hORkZVUUhzRVRhUVc4RnRRWm8rQnROdDJ6cFFXeTc2T0U4VUx3cUtU?=
 =?utf-8?B?QUc4eURoTzVjSW5vWENjM2NUMERaMEQyczBCR0xoNm5xUjJuWWJZT1N5dWxI?=
 =?utf-8?B?eW1uckhDa1RhWXN0bXJnbDhUUWdyWkVtRS9lbGJvQ3FmYVJ4ai9MS1BYcU43?=
 =?utf-8?B?aGdLeFo5OVJDQ2lxazNjRzdJZW54NW9NWUVPVStEZzFjRlNWclh2ZDQrT2I3?=
 =?utf-8?B?QmEwUDBCN2M3c0FDR2twdHBqTXlRWHNOUlIrOUNjQ3VnTE1BT2JteklBd21P?=
 =?utf-8?B?a1ppUnRYelZSc1hMSnB1d0M5S1RpNVdOWmlyc1Z3Sm9uZEhWcTN5YmVHVWVw?=
 =?utf-8?B?OWt0QVRGRlgrb0FOUmtsS0pOSFRmQUorMjdyY3JCYzJ1bnFiQnpZZjkzbk5S?=
 =?utf-8?B?R21QdWVudTEyZzA4ZExWbzhZOTM3b0hXZGxtQ2FmK0lqNkxkbVdwWEovYm5L?=
 =?utf-8?B?Z3hYOUVPZ212Yjh6bHZjTXZVVWtQTUpNZ0haWG44eFRiTHVhbVpnRnZpWUtW?=
 =?utf-8?B?SWhDUWJHakFLU2RmRHhYNCtsVEVISEVYb2JPTExoVCtZWmV0cmhrdlVJd2ov?=
 =?utf-8?B?VjUyYmVqNGtYM3RLM3FvYitmM2F6ajhZakozd1lJWExRK2Q3RDFyOGtPOUtL?=
 =?utf-8?B?dVAzcTJ5bkhtdHVNU0R5Q2VSYWEyK0pLSENvTmtwWU1qbGVjcTlEQXJkenFZ?=
 =?utf-8?B?bElhMi8wRUt2OTdITnFIWTlGT3ZLNzRlN2R1VUdRWXdxRVNwQkRpcC9xTkRL?=
 =?utf-8?B?bWRLNnJTMDdibFVuck0yS3hHc04rSmxPczRWMnYvY1RhQmdnUkpQd0NTd3pW?=
 =?utf-8?B?Wi9xSFJpRU9UTDRBb3g1aks1Q2FmSkphSThQY2p4UnZMVzhXeHZIL01mT0N6?=
 =?utf-8?B?NEllWVdhUHNhV3JpcHpIVVhiUGFwZTVsUG1jRm9FQmpoa1dMME1ZWmRPVVFQ?=
 =?utf-8?B?K3pvNllVWk5mNWZHTVhhMWwwLzg5Q1hMV1VuYWFJRk8zU2VlMmxXN2o3Y3Za?=
 =?utf-8?B?TmNiaTU0Y1RPVkpKcWxLaWtJQVpJRGNQSWdoeE1HaHRBYXVGb0dEWCsxSkwx?=
 =?utf-8?B?L1RCZTJVa2YzVUtUWWZ5YTVqQUZQRWJpK2hmeGF1KzEwSGVINUxhdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <896BC042E8A8CE4897D30DC42779D364@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KybxqXZF22hmLV2yjEBuN+fHBpUz4rk5wJc7C2k4ZL3JYTUKtDPvGQoB0CndAEuQgPbUXCZENKo6xgIbZkWa/g1NMAPjGlX0SdzTqu0IuuNLrFV/lTHwv3cQBEVcpPOEbe/QuAQqEYJWX7gvXXPDr3c6XCPhxB3IUSY42PIYb9axKGAz48eT+uJ7XQ/byr/hyv46Un8Jwn3JEyjrV00glyuTGFh1bSIJ4PtIgdVa+Up9Ldt5p6B58u8zay3C+D5hUSsDgzby9cso8Dvr+2wCyrqcYap78dCNlfKFainEq713/ofoiItnvtJlTV3zIO5PDyYM6UIKmj8sas/1ZzkFvQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ebff91-c6bd-43fb-bdf7-08dec22f7e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 11:50:36.5927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bu9tbSwS+paTVzKFi/l5PqTNVQm5YVzZzFAywYuJi7hChsY8xxK+ibVuAou7Kx9Lh3EgRQgAl9a+E+5xZE2e6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7863
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBCZWdydWRnaW5nbHkgbW92ZSBhZGp1c3RfdHNjX29mZnNldF97Z3Vlc3QsaG9zdH0o
KSB0byB4ODYuaCBhcyBpbmxpbmVzLA0KPiBhbmQgZXhwb3NlIHNldmVyYWwgb3RoZXIgVFNDIGhl
bHBlcnMgaW4gYW50aWNpcGF0aW9uIG9mIG1vdmluZyBLVk0ncyBNU1INCj4gY29kZSB0byBhIGRl
ZGljYXRlZCBtc3JzLmMuICBVbmZvcnR1bmF0ZWx5IGZvciBLVk0sIHNldmVyYWwgTVNScyB0aGF0
IEtWTQ0KPiBlbXVsYXRlcyBjYW4gYWZmZWN0IFRTQyBzdGF0ZS4NCj4gDQo+IE9wcG9ydHVuaXN0
aWNhbGx5IGRyb3AgYSBzdXBlcmZsdW91cyBsb2NhbCAidHNjX29mZnNldCIgdmFyaWFibGUsIHdo
b3NlDQo+IGV4aXN0ZW5jZSBjYXVzZXMgY2hlY2twYXRjaCB0byBjb21wbGFpbiBhYm91dCBsYWNr
IG9mIGEgYmxhbmsgbGluZS4NCj4gDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5j
b20+DQo+IA0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
