Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5D381B0E;
	Mon, 23 Mar 2026 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305660; cv=fail; b=CMx4CamPuEXDNJiy5Ai8EvVMqxwd89zqn32uTc5JRHxnUvhUp4vuFYke4nkiT014APoJ2Kadau6XuYXMtOp4VICYjN3gpBa0wliwfpbE4mNgMvAFq4E0DxGadZNXpIxqoJI9jDrlREkIO7zGgnJ5IW2iza2J1fnzedyXBAi2fsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305660; c=relaxed/simple;
	bh=6pO252aml4gRC12p2tyzt6BuDx5QwrbQgRLoKbLgCQA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kQZgDKlAoXrZqDHMu5dGiKx9UK8nSIUkiKG9iSh1VLF3HMuwVaZ1ICIskeVmFogpwCfGCB12sJLA9sObQtO12gcGE1J1GCG99Runo+gDEeHFDtxtuhq3SczWLOS3DS5kdtrMg/V1oYNIauJTK39EJKyTti2pUAWyW8V9aX7dbK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HiQFH1SH; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HiQFH1SH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774305658; x=1805841658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6pO252aml4gRC12p2tyzt6BuDx5QwrbQgRLoKbLgCQA=;
  b=HiQFH1SHoQvgykHUz6pwDwr5lzg6p3swsli0VB5TEA7UrgcY8aMLQNw6
   ZYyBwdEr8tkm7S/JkQ/zM+8nEmVy2DyjXbu1iRw/hmyWNnf2Vk0WyrXZu
   fD/FEBfvT5uNsEVrqq85v7pZFoMclatVqNGMevPf/38LHwGZPXQwuTVN8
   N5RNts8mmJBkrWaoFSPdDO7SrO0idCL9FDRF3BIp8RFGLBM3ZgDzrsCAQ
   YFud+mlrNdj1U61sAmjw5MZOKiZAup++MgMdPrTHQL2S+HFJUXmUlk8Bc
   L6XrcbFrYs9mE4QL1DrwiWPo0b/8ei5FuqCUvVWGPZaSuiCbSIhrlba2P
   g==;
X-CSE-ConnectionGUID: CPYpvMJHTrGyY6ZnRvbEVw==
X-CSE-MsgGUID: YyV98josS+GtFpTUlIPI1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75283675"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75283675"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:40:57 -0700
X-CSE-ConnectionGUID: FWqQMdmwTPe6sPYFk42nVw==
X-CSE-MsgGUID: WUkimbQNT4qJZjyb8ZOxYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="225845669"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:40:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 15:40:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 15:40:56 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 15:40:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ugi0BSSECvzvcBLMj5jY8J+re9uUo+5LfaoZM7nLf59nSQEdWhhE4wGo+0xwSxV0Azg3sdMJRyx60TIoZoPGtZJ5TR3bCR9qNVPB8giohT1RI0ey0joZGnX+D8b85iK2GALM5C1S3FXJ4BRM7UiHB7gsGgmOADjn4cfOys0ECrsJUNM7o5RNxKv4BXziwgPLd/XWNg3P3OdYslm/n5bT/v9HRlA3PInF4wGKNM2qgZrSq8JZ5hMUBTiCHCFvvyHxDBUABd9rfhmXxnjRjcj6lTroOGtr+h+TG/9YyVupbjXQkivHCkNw9MWR7wKfe+/Kje1MkaDd6bpIxzNMxGTAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pO252aml4gRC12p2tyzt6BuDx5QwrbQgRLoKbLgCQA=;
 b=ggs0pethqlVu8nUtmhxu7SiRZ45foKeyPhOADhMgsRuH74dphwYtvAM4NM/ILXozeme2zefxW6rNUsyEExo+3e4pwaljZDV+ptDD+7V4wugTvxnava1wCLQqtiO6Ne4wUqNHS+gSrf3aW2UnIQQ9AtndBelkkArgEmncsrzzz/tNGY03myRZTvC2fQ9zCATBTsdWYOvaAgUmzvue21Xg+qcb19o8Gf4W2Bgcl0V9PEJH8bmW0w6N0zikdQ8DjQKclcMjK1qiju8KY5TWoQZ4eGU3q121KAgKBO20hR9ixdHt1GioIGlHz4dfIajEUqzXgKpQlTl4qWiMs1l2rWU6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SJ5PPF3A51834D3.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::821) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Mon, 23 Mar
 2026 22:40:46 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 22:40:46 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Topic: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Index: AQHcuwhGqb9Pg2wXF0mrsfysgz7ow7W8thoA
Date: Mon, 23 Mar 2026 22:40:46 +0000
Message-ID: <d783c07ce3d6bf7477eaee3b892a3f007bd291e6.camel@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
	 <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SJ5PPF3A51834D3:EE_
x-ms-office365-filtering-correlation-id: f88e85ef-7de5-49a5-4e89-08de892d39c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: b0tedqAejdqVTlgBzRwfz2HrZPjJwFQXYZ0SHJK6v4DTdWYLcUNyPLKv6SiKUT1DVhsCE1pZxlJCk+QhVWv7sSdsOFDxqelY/iO8CXYuMZSSe3BtCm4jDlcNcF4hKldDoCZ/+lKIxo9Nrki7BJUGB0wpLNNuLfgZ4HmdfdfigQbZbEwUn7Rdb9fBQ1nL+2oIC2pTRCBZY3ntA+0GQDfUoPfStXmWv0l8ncxTXbD5lEVCWSI+eacJ0uj7VD9N08ZOUGEf9NpmB2h2iFUmZvNIz4wisIbO3cShqxQcRHyZAzTcEWIy0AyJgCnmd6P9NYwix2K6TYJByKXQa+wZ5wk5U3ZbWKa51GuwudnFwGIEaL9b6P6tgb14msHYJ/eJd7QE+FDZXGa8Z6C87KvT+uMOAu70tTk1v37aCg0AlkLzzDrMrAV38B1eNOfWfJeqUJMqgDt/YEdv9XYkwPlLRZUhpywH+HXn856o25j3Z+x+PcikKXNuqU+/y2mVhUx0WqCbCYAzTSMYFRpfWK3/hn6TUwJ7qQZ5zIiwETHYrKHNCqzSrCgzceALyxe+NVQT+JehES+hUU0/C524la6ccTEhPAts5HfeREbyOQrgWhZh/+uSqaxx1Nocy2aLWirMx44M0725VSh71ylKcVMvVO57KIQEP2PzkP18PkAAbAKZcVowFv/bdKZOlxN7WwzHy10SoTMhE6Y1u5WKxvEQqij7jYnC5kPcuCNYd5sFYvs7SclZ9OuYCT9WjOfadWXjU2XsuTaWqVsGzoibsOsAufEGUgWnyeoDVVgvU1Rxehnsas+8GVh8VyXK20q62rDKAc4h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3hrZ0w2TmNZTjJWYzJnVWFNa2VrZm9YM3hVTE8xb0J5SUlXRU1CbFM4aGNI?=
 =?utf-8?B?MWxPdUsybDMxdktqMklGY2Y2ZCs5TmxBVGEyLzBleWFiVWQ2aVFyMTIwZStx?=
 =?utf-8?B?aHRkZFk1T0FrWjUySVNBTHowNDFQbzRya3lQcWY2elZSM3phQ215VG55Vi90?=
 =?utf-8?B?SFhMWWtMWk5GeVdMSmlIaTN0MHRFc0dDZ3RwUEZ4OFRkS01SQXQyVVFkdytu?=
 =?utf-8?B?MmJOQTk4WDlseHJIbzc2ODBwYm1XSUtKY3hReUozSGl5RGI1a3N3TUY4Mzdt?=
 =?utf-8?B?NEdwSUhCMlVLS1gyeFdUYzRHOVIwU2FpemlLTTV2RFRGb2U3cXdDVFpuL0I5?=
 =?utf-8?B?cUFTOW1QQUhLeVpub21vWEFuTnlzUmlsSVVlTzBGdkpXTUVXU0xEYkNaVTZs?=
 =?utf-8?B?bnpVQ3BwZG5MYVlFVHp5K1pxcUxnVDJNd1ZlZzNQaVpGUnBrV3QvZmZWNmNp?=
 =?utf-8?B?cUFHTUlkSlYwZ3lINFQ0TDFsclJsVGd6cWk0RWU2Nnk3UnhQN2UwbXRVQzRH?=
 =?utf-8?B?MTN2SWkxTnBEMkxMajJXdzZNZVI4cWt4TFJ5SERBVXpFeDM5enpZYjNHSCtJ?=
 =?utf-8?B?ZmRlM2Y4cng1VFNwVnBlVkFKeWpKS1RES0pXNzdIYzJuSmk5cmhmMXMrZStL?=
 =?utf-8?B?L3djdS9UT29RSW1nOUV2Rmwwc0tBVm8vWXZqdnVsekRZQUhmMnB0U2psMG5N?=
 =?utf-8?B?TjZobjFGMFFGRllLTE9LNEFFV1pHbHZQZlk0ZllSU0o0SmVMK1U2ekt5V0Ro?=
 =?utf-8?B?WC82aFdQa0lKMXAzTXJDSDEvOUd5ZFFPRG04VnIveVRNTXEyR2ZSY3VQekMw?=
 =?utf-8?B?b3RRcXArRXplSEZUellvUzJzMWxIR0tKQmpzQ0pCem1QaDlHSmIzTStWbmVB?=
 =?utf-8?B?cTl4aDhJRVlLMUhZdWpTZm5aT3B0QXRxQzMvc2VyK1g5QkZzUE5VODlZbExj?=
 =?utf-8?B?YUpwaSt1ME9uSlh4VlRKR1BpMzlROWZhMFVMWEdJcm15dThwZDFNL2hYemlE?=
 =?utf-8?B?b1FaVnFwRlVwTzNYVU1JN2pLdi9YbG9Mbmk5UFp2UFFoS2xNcEZUK2g2UG9S?=
 =?utf-8?B?c2lEdWY5eWdEV2lhUGRjVGg2QzFZY0RIUTdRaGNEdytwaDM4aC96a2hzMmZY?=
 =?utf-8?B?dzRGVEh6WFhIWjF5M0xPYi9yV3dPSVJ4dGpJRys4dWVubk5qTzhiZVBkSG9s?=
 =?utf-8?B?NlpKUGxLa3FjZExKbm1mSEl3dWF2OWdhaTJSRTN4QnJmd0srK0FrekpqS3Y2?=
 =?utf-8?B?K3JnOWtYSHV6eDNSSk55QStaQnJlZXp5M1ByeGZISTZ3RGJaQmMyT3BiT3U3?=
 =?utf-8?B?ODZzL1h5b3VJWkN5eUNIV01VNXFZcEM1Q0JXL28zak10NzFvRUMyeWR6ZTVk?=
 =?utf-8?B?U2hvMDdib1k5SzVmb01EVE5PdHFjVWJFcS85dEZ3bWQxTUptVHhrbXJNU2wr?=
 =?utf-8?B?ZEVKZEx0aTRDQnU1cVVkalgyOElvRVJPOUVLa0kwQ3BDOWlYcHVIOUJZYzlG?=
 =?utf-8?B?ZzFRT1hmSUpzaTdkUnEveHpkcGpBaVpTRWtrc05zRTM4dkUrbUx1c2IvSHhx?=
 =?utf-8?B?bmpSVVZMclB3ZGNBUm0zV2c3cXdja2xzYzU4SDBlRlVHeUMyZVo3MFVYRUJu?=
 =?utf-8?B?QWV5eFdqd05nMTFBQ1cyRXVWU1dTQjBLdHNXNlI0SVUydEM0aW16ZzBNeHN2?=
 =?utf-8?B?OWZwNEF5MjM4WUcvRmFTUk1HK2tEZFdFYzY5SE1jbXhQYVdHMFpWcDM5Y0l4?=
 =?utf-8?B?akVtZU0rSUdkd3ZIM1N5UTVwcndIR0RtOUo4N1FDazg1U2RFRjB5UkVKbER3?=
 =?utf-8?B?amowaGNMV2Y3MVY5NVJGRWYyNmlWeVIyL3hmTy9oY3pnRUtIRUdGc1JtZGJJ?=
 =?utf-8?B?bEMwN0wxVXg0ME5sR2hqMWlpdHo3ZFJUWFVOcVBYZkxzb1BjS1YxRVA1aXdj?=
 =?utf-8?B?dTVzN3dWSTVKN1ZBbmFtclBGMXJ4YWNnWmh0d251cXBJOW5VN2h0UGFKZ1R6?=
 =?utf-8?B?aXpUZGU1Mm4zWXUyelRXV2E3dS9QOG85VjZmM1lRKzdZSlR0MXEzVUNYZW1i?=
 =?utf-8?B?cHo0YnBqcW42bmtTK3lSOVZCTTI2Y3VvSkQySUhKbHFNeHU3T01GNEJHeVVr?=
 =?utf-8?B?b0RMTC9UUUNsWWxtc0drRS95MDc5elcwV1pwWm1BMXE5dmZtVU8xdmxLZmxu?=
 =?utf-8?B?QnVNWEZydHVhQU94U2Q3czcwZ01CWUlvWUl5VmdaeUo2dEpoUXRFaXgvSE5q?=
 =?utf-8?B?dG5CMEVUMUdzcGx1OHo2Y2RNT0NLY1NteWw5eWg3SzJjQ01wZXdVVDlPZlpw?=
 =?utf-8?B?R3NXZ2MwMUJYZzJOVEdwOUJiZ2hIeERYejRKVHQ0S1hZOXJ0RG03UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA1E39FE170E2B4CAB17BF893AAB0B8E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M1nkPbcmsrhOh9SuIWjkybTk+i7RykMzkhTgTTsUMP/n4FChnuG/XQ4D8Z3ZLCbgbtVMMXfwwx85az47sE1a7vRjwK3Bjnf69WmDZTI6HH72IRba6sP3vfcCCIO2Grfnk3K2eibSz++FhK6H2fpspwRNGeXN0mvZZMzZvmeluTTdHtnpxQK0pOfCqtAd+jPOpBvNwrh/RMLmDH9X9cvkxsBJ/SapUVXb2LbGlnyGXlu6juNXiU0L5MrUZy20cmXe9fUtqOORV0nxI7euJ/qTXQ2y+MMAedyQps21xyrhctbzKeDOu7cA7qDm95y311BkNieeH9GWcYU6ptJuKRyX9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88e85ef-7de5-49a5-4e89-08de892d39c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 22:40:46.8063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFoQFtHQ7GEA0I0zalUEWoMttyD34DPWUt0myWQdgnt5lBWlKpH/2C4jRm04DUpgaJgLufIiM9Kg4nljbwcmdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3A51834D3
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTIzIGF0IDE0OjU5IC0wNjAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+
IFNvbWUgZWFybHkgVERYLWNhcGFibGUgcGxhdGZvcm1zIGhhdmUgYW4gZXJyYXR1bSB3aGVyZSBh
IHBhcnRpYWwgd3JpdGUNCj4gdG8gVERYIHByaXZhdGUgbWVtb3J5IGNhbiBjYXVzZSBhIG1hY2hp
bmUgY2hlY2sgb24gYSBzdWJzZXF1ZW50IHJlYWQuDQo+IE9uIHRoZXNlIHBsYXRmb3Jtcywga2V4
ZWMgYW5kIGtkdW1wIGhhdmUgYmVlbiBkaXNhYmxlZCBpbiB0aGVzZSBjYXNlcywNCj4gYmVjYXVz
ZSB0aGUgb2xkIGtlcm5lbCBjYW5ub3Qgc2FmZWx5IGhhbmQgb2ZmIFREWCBzdGF0ZSB0byB0aGUg
bmV3DQo+IGtlcm5lbC4gTGF0ZXIgVERYIG1vZHVsZXMgc3VwcG9ydCB0aGUgVERILlNZUy5ESVNB
QkxFIFNFQU1DQUxMLCB3aGljaA0KPiBwcm92aWRlcyBhIHdheSB0byBjbGVhbmx5IGRpc2FibGUg
VERYIGFuZCBhbGxvdyBrZXhlYyB0byBwcm9jZWVkLg0KPiANCj4gVGhlIG5ldyBTRUFNQ0FMTCBo
YXMgYW4gZW51bWVyYXRpb24gYml0LCBidXQgdGhhdCBpcyBpZ25vcmVkLiBJdCBpcw0KPiBleHBl
Y3RlZCB0aGF0IHVzZXJzIHdpbGwgYmUgdXNpbmcgdGhlIGxhdGVzdCBURFggbW9kdWxlLCBhbmQg
dGhlIGZhaWx1cmUNCj4gbW9kZSBmb3IgcnVubmluZyB0aGUgbWlzc2luZyBTRUFNQ0FMTCBvbiBh
biBvbGRlciBtb2R1bGUgaXMgbm90IGZhdGFsLg0KPiANCj4gVGhpcyBjYW4gYmUgYSBsb25nIHJ1
bm5pbmcgb3BlcmF0aW9uLCBhbmQgdGhlIHRpbWUgbmVlZGVkIGxhcmdlbHkNCj4gZGVwZW5kcyBv
biB0aGUgYW1vdW50IG9mIG1lbW9yeSB0aGF0IGhhcyBiZWVuIGFsbG9jYXRlZCB0byBURHMuIElm
IGFsbA0KPiBURHMgaGF2ZSBiZWVuIGRlc3Ryb3llZCBwcmlvciB0byB0aGUgc3lzX2Rpc2FibGUg
Y2FsbCwgdGhlbiBpdCBpcyBmYXN0LA0KPiB3aXRoIG9ubHkgbmVlZGluZyB0byBvdmVycmlkZSB0
aGUgVERYIG1vZHVsZSBtZW1vcnkuDQo+IA0KPiBBZnRlciB0aGUgU0VBTUNBTEwgY29tcGxldGVz
LCB0aGUgVERYIG1vZHVsZSBpcyBkaXNhYmxlZCBhbmQgYWxsIG1lbW9yeQ0KPiByZXNvdXJjZXMg
YWxsb2NhdGVkIHRvIFREWCBhcmUgZnJlZWQgYW5kIHJlc2V0LiBUaGUgbmV4dCBrZXJuZWwgY2Fu
IHRoZW4NCj4gcmUtaW5pdGlhbGl6ZSB0aGUgVERYIG1vZHVsZSBmcm9tIHNjcmF0Y2ggdmlhIHRo
ZSBub3JtYWwgVERYIGJyaW5nLXVwDQo+IHNlcXVlbmNlLg0KPiANCj4gVGhlIFNFQU1DQUxMIGNh
biByZXR1cm4gdHdvIGRpZmZlcmVudCBlcnJvciBjb2RlcyB0aGF0IGV4cGVjdCBhIHJldHJ5Lg0K
PiAgLSBURFhfSU5URVJSVVBURURfUkVTVU1BQkxFIGNhbiBiZSByZXR1cm5lZCBpbiB0aGUgY2Fz
ZSBvZiBhIGhvc3QNCj4gICAgaW50ZXJydXB0LiBIb3dldmVyLCBpdCB3aWxsIG5vdCByZXR1cm4g
dW50aWwgaXQgbWFrZXMgc29tZSBmb3J3YXJkDQo+ICAgIHByb2dyZXNzLCBzbyB3ZSBjYW4gZXhw
ZWN0IHRvIGNvbXBsZXRlIGV2ZW4gaW4gdGhlIGNhc2Ugb2YgaW50ZXJydXB0DQo+ICAgIHN0b3Jt
cy4NCj4gIC0gVERYX1NZU19CVVNZIHdpbGwgYmUgcmV0dXJuZWQgb24gY29udGVudGlvbiB3aXRo
IG90aGVyIFRESC5TWVMuKg0KPiAgICBTRUFNQ0FMTHMsIGhvd2V2ZXIgYSBzaWRlIGVmZmVjdCBv
ZiBUREguU1lTLkRJU0FCTEUgaXMgdGhhdCBpdCB3aWxsDQo+ICAgIGJsb2NrIG90aGVyIFNFQU1D
QUxMcyBvbmNlIGl0IGdldHMgZ29pbmcuIFNvIHRoaXMgY29udGVudGlvbiB3aWxsIGJlDQo+ICAg
IHNob3J0IGxpdmVkLg0KPiANCj4gU28gbG9vcCBpbmZpbml0ZWx5IG9uIGVpdGhlciBvZiB0aGVz
ZSBlcnJvciBjb2RlcywgdW50aWwgc3VjY2VzcyBvciBvdGhlcg0KPiBlcnJvci4NCj4gDQo+IENv
LWRldmVsb3BlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRl
bC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50
ZWwuY29tPg0KPiANCg0KQWNrZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4N
Cg==
