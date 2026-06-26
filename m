Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688313B293;
	Fri, 26 Jun 2026 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434248; cv=fail; b=NoYNXl4yyo+V2Z92A7w2u4FTpMtpYxx/zbttY8zREe3HS2OaMyRFt2pbLs1sDVTWYIqT7JKes/juodKOxZI4D2hw140RLDKjNNZG+syu6Ep5q0m+4FtG+vndyVh4v0VVAZs+FGz7XMB/PjVC/MxG7XahsCTLZXzXUoRe8Jkwhsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434248; c=relaxed/simple;
	bh=ARwC1aepdeAuru+lUSOcZ5EaJa0W/eTDMMSjsRmbpAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mEqCK4oFhAseotuwho5wyMeaIWQU5/L2MU0KT5skHatBv+zEmpMbxJf/PXQ4eXZ+4zDSnNHawasQZrQ61mCq+wkP77Qu6Ql5vUCA3FiOXWP4unYhAlBVPUTxjDMU7Le4cH18+5lNgx7nTZiXgNm04/1yV2PtATO3kN7mVzOrGcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cijb5+cU; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cijb5+cU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782434246; x=1813970246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ARwC1aepdeAuru+lUSOcZ5EaJa0W/eTDMMSjsRmbpAU=;
  b=Cijb5+cU4JVeUyNqalZL6WUQIdgngfe+CDwOxqIc2oDSGk6fJcleREWl
   aPTmod+B+DDBuYLGMXdd4gxBphbYBfo73rEJTUPBi5nLC4JvY8EXAwvYd
   u69TXEoXvl+eBbQSa5CX72xRemdLsOMisTD556CSPCXOnqWeQhEXu/CA9
   Vp8ovMW3hmwMIq+CUF3kytTcSQp/ftOJeNW3fgeWe9DcRegXx1a6IYM5D
   bNAqsrPk6v6XD6YfLy76GoMQE0IjGpRN3Kmb/anCvLHmOfrud1sd/PB5n
   qN+5vjDJ5SQWZFDYVtONfmotZMBTWGa+Ii2Y/u0eJFV2E/X0VQiliCXWm
   Q==;
X-CSE-ConnectionGUID: NQde+buoRIONXpeEf/98sQ==
X-CSE-MsgGUID: iu69bpNvTi+/t2++is9ZHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83327263"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="83327263"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:37:26 -0700
X-CSE-ConnectionGUID: If7itLq3Q6648Cqu1ozb+g==
X-CSE-MsgGUID: TmGHy/XQQCyXjYdde2KpgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="255177585"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:37:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:37:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 17:37:25 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:37:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMxhwXg9YzgIhctt74TewNM8TlQK25NtV2wqAKySNnNaR6AOIOzYygTbU9rZes8TzroRoDVjPTB1d5xSBVIVRHiYdavwK+rPpMX2aOTxVedcJYVwC0czW+XZ/9DmIjAuxe+JNlXeGHJFHoAJUbcMwXbVvd3wNjQSIw6U23DrggfgLe56VYPKka8jquaqGjhmTYDNAsxSc6sBlryn2evB3mngxHscKmpAAzFaKor6Sf1kp72qGytuDXU/Lbe+7dZ7374yT3ProxEN9U35zts3FZ/lYVe0znOiu0D7M9y+ieuKwlLebkEZgSXQ7vkfvV+IhddW4yLeHfgpuKJkhFmHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARwC1aepdeAuru+lUSOcZ5EaJa0W/eTDMMSjsRmbpAU=;
 b=bWvzThiEjluX0F9DLBp6Hslxyb7kf0Xz+JBUg6y2h0XvF3KKl814iWBCat7WhCOpP1XIrDMR9RyLmZSeVYKBg6pVQTUGTOm54uNDiJ3JLNOjKDchEpusXEstJdLp4PGYHnmcnNGovhm+euTKTg13neEwCvhjonIxdp5VPu7BO6LwfLwbWmt7xVZJMn4QQoPwIuwrRYDDN7u8dUcCzvx04+IVQZsnabyEvuK918TJ2rWmUFxH/GhSor9w74/m9MQ5hSDQISaaIHQaoZyKxCE6N0On7o3ssGfOVGipgllnkUToIhtQth27Jvx8IaU5ggh73ImU4v7PjAM7A2nSh8h4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH7PR11MB6450.namprd11.prod.outlook.com (2603:10b6:510:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 00:37:20 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 00:37:20 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH 4/9] KVM: x86: Move CR and DR macro definitions from
 kvm_host.h => regs.h
Thread-Topic: [PATCH 4/9] KVM: x86: Move CR and DR macro definitions from
 kvm_host.h => regs.h
Thread-Index: AQHdBO6vs8pMei8uf0i/NXPNnr+I+bZP/gaA
Date: Fri, 26 Jun 2026 00:37:20 +0000
Message-ID: <bba1269243ce17952814634b6656e65a3d4477b0.camel@intel.com>
References: <20260625220450.3354415-1-seanjc@google.com>
	 <20260625220450.3354415-5-seanjc@google.com>
In-Reply-To: <20260625220450.3354415-5-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH7PR11MB6450:EE_
x-ms-office365-filtering-correlation-id: 9dadbf06-4362-414e-ea24-08ded31b1557
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: p+8LHq+IFu7UQGjRbHhb4bcQxg35Hn87fSZezZT87kqaYyI2Am7NMFmjns/1fe90tFFSYLWuLfSCZb4UrD+bUcUcFMXZAQuc4XhBp4LyQoaDvnm4VdZhcWU7uBrN54VzfjGpJKtS3opgENObI15iq2o6+0TIeljXXqeB/wPJJ71d1ID3tynq55v+dhnS3sSzeWOhKf4a7YCKY77qo3zNvGeWadfgDfjTYH1Kyz6mytGTPjsUFlBukwOfLbUFMMeHN6OppO3stHI7S0CstsKbqF5U7tjOW6KyBMN3kfzpVAjia5aR1crca/ivcE51z/R0+xUMXeBr9QH5h6mJlZaEp5RGGfyL9CPhzQcxd0BqIE5FzbJY6vO0esLE1mofzLuMkNYcOB+roIlojWUhSYiElXJ6X1jhw4BN7XgYevtbjXXy9rMCxvqYFgIgNJLb42LZtryVCIX9oEJ1z8aiRpIiyLcESEgctsqWj7RVZg8RcqyTM1VZCXn0LZJXA/fuI7lObD+bsbIWNO6OFwH+BiVRuA0R2ChyEAF+L2zniBk71T/yxwkkN0FZrepiNJG9PphefSIW5pPrxK9eIYzot8ysia+iDtsevn+ARrP0344nK4Ax/vV71tNI37s332hrYlqvJfi6HsPWcPP2aOkIMat8hzlv32BCq+FVfxd3WeHRIxaTdR2XfFlCR9dDy4JNRJXdHc37dq61k07+IP5KnjyHyY4EVdmzteRSI/kkZfEA46I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDlsYWVHZVdXeGdQcjEwTkFUeDVsVDF1QkI0MS82cE1GeGRpajRESE11Yk5L?=
 =?utf-8?B?SmhER081ZkxkVVdVTlZJb09RN3NBSnJKZ0Q4RkNwdmZsbTROdlVicHhZd200?=
 =?utf-8?B?KzJkelJUNWlwQ3hybkJpV283cW5UcTI0L2RwRDY5OElyK2VtVnJKTE9ET00z?=
 =?utf-8?B?bXcyQTBaY3d1eUJYcitVZVgxSmpWNGNsMXJGRHVHN3lPRWRUWjlrTWs1aUJP?=
 =?utf-8?B?Y3dTMXVaK0lXekg1UFV5Sjd3QWNhRzhqb3JBVWw0Y0FoVERhOHlId2tOa01I?=
 =?utf-8?B?eGZiM05nK2had2tCUWt6OVg0eHlRanNBS0tKbFhmM0xxT2paaEloK3ZER1JT?=
 =?utf-8?B?L0U0cjg2R3BnZk9MY2NpWHZGQkFlcmRsaVArclc1V3ZBZFUzWk5oeW9QTEk0?=
 =?utf-8?B?YzFBZmVPRnN3NVpVMGNETWFJUlVwcmh0WUVPSlhidjFJMVkyYzN3VWJPN3lu?=
 =?utf-8?B?dE5UaWtsZzRtRDZxMyt4VTFGb3Yvck51aVNrcFN3SFI0QkdSVTVxV3kzbzl3?=
 =?utf-8?B?Y3NuT2VJdUF3ald1MHRjL1l3OExrWW9Db29oSW1zQ3dOOUFrMlBzWDhzRjhY?=
 =?utf-8?B?bEFMbTdHVVhpZDN0SDBuVnZTZ2FWZUhpWWdWVmQ1a2FEaGhWU0c0Z0JGQnFJ?=
 =?utf-8?B?a3o1cnAwUkFTdGRwbHBaZjFDSDlWMDVKUXppZUlOVjI2V0gzNkxXNFI2MHpr?=
 =?utf-8?B?b1VrUktqK3pncVQ4NjA5OGdhU3duR21QOWt2b1VndGVlWHk2OHJ1dXRWWTdQ?=
 =?utf-8?B?N296a1Zsditva3dnd2pWenZhdU51UDRXM3h2VE9yZEJCUzZ0eGtZQWZzT3Jn?=
 =?utf-8?B?Nnplalp3QW9QUVRzZTZPWkxlRC9Ba09LazMrK01nZWU1U3hOSWhndnFkLzFE?=
 =?utf-8?B?SGpEMEF5eTVteTdJbHI3Tk4xcmk3RWxBazRvK1JNYmFWNXU1M3Zub2ZFaU9N?=
 =?utf-8?B?OTltRGp2YzZlbWYxQWY0OENld1duejhFNGIvenpQRE1kUTBCeWR5eDVjRlFp?=
 =?utf-8?B?eXBTT3FNcFhWT2pxdGNNK0NUMkhCK2xaWmt4YWZ2TG15RUtBOStBU2Z5Zy9X?=
 =?utf-8?B?WjdJdGR6cWh0bmdkSmN6Mjh5WHdlYmx2WXQ1aGtCTFNMUG0zMU9lc21ianFi?=
 =?utf-8?B?bGRoYzI0T2dFY1F0RDU5eXFqanBpdDR2RWpoUUNwbmVIcVMxaFVOV20xalBx?=
 =?utf-8?B?djlLL3E0N0k0K3kzZVRvVWFkY2VDNng3ZTRrUmhGRlJ2UGk3ajNnNkN5ZWhP?=
 =?utf-8?B?bmRROG5INERSYmd5UXQzc0dCa0s2M0hKOVQ5TFNxazVKSGVWT3R2STBKOThp?=
 =?utf-8?B?amxMRFhJVDB3SzRtNTBGVmhjUk9SUmtvUGd0N1JwRWU5V3hWZ0xMNVA2U29D?=
 =?utf-8?B?N1owOVVySjlNODY0Y1lKOW0rclBMMzR1Z1ovWWt6dnhOTTErVnZHTFZYOTVy?=
 =?utf-8?B?a1gxaEdzdkx3b2kzc0hCMU03dDlOUHJnWVpMai9rQThnRFVlRkI1Tk9jSEs2?=
 =?utf-8?B?Qmd3MFRUSmJCOTBrbER1Mzc1QWxvUUltZTNkNmk0K1hmTFVFT3drVVROUVd3?=
 =?utf-8?B?TCtCM2x2QkRBeDd1em9EZHY5c2FyZmhSRG94MzZZbnZ0dTFXNzN0TnI0MzBs?=
 =?utf-8?B?NjVsSW9MSW1NWTNHRlRqTEtoMjlFODVvREduUFVIMVZrUC9waGZnOWY1NWJ2?=
 =?utf-8?B?UzJWZGRZNmRMVTJtVkZuMXMyc1Z2b1lQSmllc0lvUEJZdy9pb2RXS0xLUW80?=
 =?utf-8?B?b3JzL0pLUEpNRnF5dDN1U0pSSC9NU05seWJIVHhweEd3cGlaQ1prSVRQV2gv?=
 =?utf-8?B?Q0R6R3VOTWxKQkZwUWNtUlB0dE1wNGFoRG9YSUdtSzRTdm9IT1Z6Z3NQbVNE?=
 =?utf-8?B?N2I4ckhERVo0Y1B0cVdNNUxGV2lVbHliSEUxOU5DU2tIajE1bWVnN2tWd1BJ?=
 =?utf-8?B?SFBPYXN2Z2lTZCtWRFpMYXpzQzdBa1VIbGNpU1lYdHRBcFZvdEtLby93Q1l1?=
 =?utf-8?B?SVlBVFViSFQvR2ZWK294QlFwZmVWTnN3NmFzR3BBMERWUnJialFxVzNFdllC?=
 =?utf-8?B?R1FWWjA0bWxpTGpSQ204Njl1YUI4OEl0bGU1aGhrSWc4dnVpWExQc0lVdXpv?=
 =?utf-8?B?SVArVnVrMWF3Vy9LTnRzRVpscm14MHB1VlVOT2t4L3M3T2FHbkFHUEYrbWtL?=
 =?utf-8?B?TG10citRZmp4NWZKeEhzVHo3UU02aDV6dm04LzRVRFRtbG43ZnBYSCs3a3hq?=
 =?utf-8?B?ck5TaU01SkdqU1ErZVlXbTFWWDd4M2xLcjRRb2hETHRzQkxTK3pjQzJnNjN3?=
 =?utf-8?B?eERtOE9FeTdGOTdybDYvUXlFcGExUTByMVJUdFJrbmQ3bW5BYk03dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93568685CB22824E98EF13C5A926888A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OZwGNGBB+WTN4sjtvjZNTsJPwbiNoOPLtVDGRI719lZw/jXQVyDTiwskjJvuJaoHz7s6eVDegSj4h4LnqeQzzwph8wQ5OvWry0aFgN38u1S9MhgZ4hr6W9maCk852jc/VuqwrDP7Wu8ntaKSiehZ9Y7zOETj0FPrhupFgmL+tBXfCOhI3+Z3yCKZRLPrPqB8m5v1/K2IoLPKBrX5sQAMkXKpfMpzCazn7D8CQa+JoXS1oEEHy0bXX3z4zgR6GwgU/HwZ0SHmPlPh2Fykml+RngKLcWPOjbcm8U/WaRzg7O3Ag/JXV4lvPKscqR0V6CHp/KQBebn9F/Gy5ytO0TgAyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dadbf06-4362-414e-ea24-08ded31b1557
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 00:37:20.8392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fz9xEEkGU5H+HPj2XhYbVV3EKso6s2xPP7WOEGguvvYBz8HymoPuvaH8qsdKSRB248VTqU8zME8sD0GHEUTMxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6450
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTI1IGF0IDE1OjA0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZWxvY2F0ZSBhIHZhcmlldHkgb2YgQ29udHJvbC9EZWJ1ZyBSZWdpc3RlciBtYWNy
b3MgdGhhdCB1bmludGVudGlvbmFsbHkNCj4gZ290IGxlZnQgYmVoaW5kIHdoZW4gdGhlIHJlbGF0
ZWQgaGVscGVyIGZ1bmN0aW9uIHByb3RvdHlwZXMgd2VyZSBtb3ZlZCB0bw0KPiByZWdzLmguDQo+
IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiANCg0KUmV2aWV3ZWQt
Ynk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
