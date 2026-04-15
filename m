Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD7313E03;
	Wed, 15 Apr 2026 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776222006; cv=fail; b=ro1JkHU6sn2YGqTF4cICaeWOeJ8KSCl0bQEmY9kwX3trdsaY0TbDnG9HLiEs7RzoAVcr07w93PZIB4teC2PR8Yq5WwG31LKNlzdJIMo+VbrABvlnLdD90cvj+HcixkMjjE1MJFOmLgZwvcmBafHePLpL2s1AILI4kII4ih2v47I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776222006; c=relaxed/simple;
	bh=5dVDsxPLWv/kDGFsWbd9K/x/eN0HfTWvR3IvnbMoHxk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R1FP7h7AcPVV+nZ2jmirWw1Cydw8rsmQgWuNfnPQaQUANPndI3CIVSukGVsdPf0jLu75VI6j1o1CkklvUdyCjaIn2i5FZ1GF1mE+cINCXYBo60xICqmg/E7VS1J9ct0ZxZ4YPnnjBPQHhkJMGwbH7jnpYHJQxVbics1Cgrq2v3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUWSKYyV; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUWSKYyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776222005; x=1807758005;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5dVDsxPLWv/kDGFsWbd9K/x/eN0HfTWvR3IvnbMoHxk=;
  b=NUWSKYyVz7bglvRBPk0MA0K0ZBENuMXXisS5hlodiDoEwEDHM12kkCzZ
   vbNbu0Eumd//s4G62zQaOz1qQRdsvZLQnYVNmL2eRNjQ7Prh5I8E9h54k
   CgR1A4K9/NepYLelNIYX9/QtekGHo/sMIomzq9cM7By/DQEj37bYlicgH
   FIDIGpa3fMeYfutqjoS22KPQISux53FihFYonDnETnjek6RjWvF2khAIW
   afMftKYRHTFd+wb3onUG+F3L7fAB/sAnAcQ4MHlEOGt6DAo7Jz9Kfww0e
   0YfqTx7w+1aKrS2btgAoxOzfdEulXPxRwC/nynM3hxKiBEGP4l+OR2iaK
   Q==;
X-CSE-ConnectionGUID: L5T81GAtQHeXw9dk5AOGpQ==
X-CSE-MsgGUID: r2JMzqctSOakJht5TfJPpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="79776535"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="79776535"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 20:00:04 -0700
X-CSE-ConnectionGUID: IhDfi6u0RD+yxgsVqwCbdQ==
X-CSE-MsgGUID: 76bRp25KSdO7dfLWQciXHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234666974"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 20:00:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 20:00:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 20:00:04 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 20:00:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQi3siL9c5G6iXgtk8X98tJrLEvJm+lTnLWkztXkqPtQwuUR8ScbdD1y2ELJUTB8+BHsIo5HIqpFCPct3DMU0DVm+HULTvsBLPEOJw8jlLuntGf4C9SR6bj6W8KidTaLfouCojGr1eaUP8BmdwruNwyhMBGQHyF7AuGUYGOVYAY1kLtVTz8ZxlvARLDiCnno504flYBLoblSAyXrQD3Vt+UjqSLtCPy8bS6BvxL0Tgk2MvUbjeT5dxp/5xAjOEJy0cp/yTp6YK/awGEGotgZr3vTne2f7fMb7S+bKFAbPVdOyAyWpTNsr6/pIKUYDZsOdl/chLwMNykmGNIYqlOiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HFzbzScQtZIt2TU+UmTIDHclbhCt1XKYlkpJJ+xk0Q=;
 b=IeywOMc+Ke4L2FwweVjF25UoDhjLAOu2+qVigXVlfKqgGLzb7jbiiw/rK9IXwGlIrouH1cJGuWt6Om5luts/CUAtYYYMXqj8AIR4KRlHXuuA3isEVn2cb8TeMu0s82AiuAbWCtodzzU3Ck/v2AGlLdp93bbhXJYdWDFQTgi7XXIvR77i4jVIgp3enlg0RJmfA5BpPRB80PXPS8SEVhWDnoixEGKgYq+QZgg+jqWtrgO0ksObkTgLfwrEb0s/Te3+Hytu02zo0+ESMGB1jbZH8cMzpUYpLjhB05cn762i1/3gJX7V5ggSoBqYcGFX1TgtibIpxru7M0P+cL5SDxs47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 03:00:00 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 03:00:00 +0000
Date: Wed, 15 Apr 2026 10:59:44 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
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
Subject: Re: [PATCH v7 10/22] x86/virt/seamldr: Abort updates if errors
 occurred midway
Message-ID: <ad7/ICVYG+Z63b4i@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-11-chao.gao@intel.com>
 <fb472138f6ba06efd90a3834a5748662d7b7ac44.camel@intel.com>
 <ad4P9HZEOnC3wUH3@intel.com>
 <80a01d40855136a5825e5f353a8cc2982dde385a.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80a01d40855136a5825e5f353a8cc2982dde385a.camel@intel.com>
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|BL3PR11MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 9689db0a-8a1c-426d-ad3b-08de9a9b153b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: kjTFRpPkvmxvKzlwmZb8Xe2ruEXtfmP2g+BU/xM3xtXvzCMFv34o/wkdk82COb/Xii9/xyyrJQKtpHyC4awf3d1ufHPi7BBSnIvAt++NapOub1ElplzWeaIXXi6pYopTmaEvBm1pgxBfa7DBZaaIbYQEKYmEoIAMzI0fNwphJXczf7IdYOFHR+XAgK/m4lpYzzGD+713H6mGDnLKYUPRMtg36P9vUonfolcMWGt3+Py8QhY2aKKr2HUJN8itnIo+HKacn6RaGyziZbBsV3L+uiKaEMZixKcYKzFGLAFD7OhvVnBoj6ls8tUnKHacJsVLok5++4u2kvw4ev4U16ZHxsQrfeq1aG8nU3cjR8SCK/QH5MTSrddIxB/uZvxFdfaOGV/AxQtOOQ/IBvrOPNepCX1yNyY+x5larg4gVqXVYtc4q6SbM5bnQXJ24fouJf3hWa/vYwMbSJnfXy2xcjvdv1jYKIgIjjtadLBEAgzPxNiRtnRIKy4fpl8MDUaM9lKVB1Ju3L3oqIE+4ooeempmqLC4/VE3Cv+/1lXCD50L2z8CFpUtASetKwOnItg5dySjvuXzSiZVgrtbCNRu+8+hkKKzePgyKP9CCir1+78gkOIrSfJRICl0cWfRA0JC/CM1HzFFTqzu9bxZ68VYxHtQk/kCk93H6E2VeABBs89ta5iwfHOeu5cKDIWMe6+5pKgjeyOqTxgjZB9huVpoqmhRUH5hJIbfByp/mYNZxD/J2rI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU0xZ2Y2YkJjNzhyRzdRa0FwcjB6MHl1Wm80UTgzRFZ4ckJpZ2dFc1IvYVpt?=
 =?utf-8?B?cUEvc1doMkJCQVN6NG11SnA4bmZRRzIzaVhySUNmNCtqOTdheGE3S1FRZTBE?=
 =?utf-8?B?cTFCUmtrY04wUkR4VjIzOEovOFU4SlJEOUhhdkFybkNEWnJyaEUvazZiU01X?=
 =?utf-8?B?Z3AwRVdoUHQ0eGRUZ0ZTRE5ueUY5U1VuU1hQSEQySFhicStXalRqOHh1WTR2?=
 =?utf-8?B?c2NVLzduN2JzeDZGQSt0dVlwVXJwbG92eWNveGM4WVBhblJIVXFJVFJVWit0?=
 =?utf-8?B?bEJBa2IrZTI0Y1RDbklzY3NSOG00My9KRUIvWlpCUWErdzgxZktNUVFRbVFD?=
 =?utf-8?B?cjBIWmtXUEVhTW9KTkxNT3pJdWFOMVE4MHlsdVpOV0lRdllEWWZiaVdPeXg2?=
 =?utf-8?B?Wkx6V2FDeFRQeDYyNHpPZ3FjNnQyaVlvNk5YdEVnQmpEQTN2eVVXc2tGSkdp?=
 =?utf-8?B?OVJxQkRndzFLemkwTnFXT0Izd3VKS2NPb3hlbnpTRU1BdDkxLzF6dThnN0Fv?=
 =?utf-8?B?elVUa3FYbzBvd2IvamVROFU3VmlPbVN3RmZmMXpsc0IzOFpJTlUrYVdsR2Vx?=
 =?utf-8?B?MXZHaHFESENXa21uNUpBY3hmNStxdG9BcFAycmNLQU9zZ3JCUDJMNlBzVUpp?=
 =?utf-8?B?RWVhdmNkVnRVZ2hmOEx1SjhCTFhwbUNZR0cxY0UvTWdzcEhrbkF2Sk54TUF4?=
 =?utf-8?B?Y0dtenB5ZGxaWTNuZU9OcGJQaHVuNFFqYVEvbDBkVzJFeDc3Rmxmb0FwSlVM?=
 =?utf-8?B?VjZlK205ZER2bkQyU2lBcDBHWC80WFlXbjRSTUs0U3lQRDd1MFJwUXdKcHpw?=
 =?utf-8?B?WEorMCtzM3pqMHlvMUFHbTRDdWk4Sys3czN3K3pDeWt6R0tYRDZNYlV2ZWN1?=
 =?utf-8?B?WWl6MFlCcW0zM2E3ZUkwMG53cWlHOFpjTEtvQnNLQkh0V01EVHRqZFY0Y2hl?=
 =?utf-8?B?UHRocVNGbTB1NHkzL0ZKYWc2ZzM4clJRL3hkaDJqUGFuZm9Qang3SDBydkVz?=
 =?utf-8?B?cmdMUFllcFhxdU1VbUgrNFhZbzNHNjdoei9reUpsZDZRRjBtWSs1NUk4Rnlz?=
 =?utf-8?B?L2F3QkRZNzFFU3c1QTRNN1BPbjZ2YklBL21qTzc3WTRmKzB3dStna2NNWG9T?=
 =?utf-8?B?SU9BMzlKbzJGd1I0WkU5eCtYV2pCaE9QVUdJVnVFNlQwUUlzaTF1WDhaWVo4?=
 =?utf-8?B?Vjhic3pKYmFnMEVHSTNNRDhqbnE2aXByUElkMFp0d1kzSUhyYXRQczdkbGMr?=
 =?utf-8?B?T1pLVzJNTGFiQ1VhZHMxWVRoUVRjeXFvY0lFWllWRmU4bk5zMUlsSlZDaWly?=
 =?utf-8?B?Z0RrK2svQ09HRTZBdjNtSWRZZVpVL1VmcE5WeUY1cUdnS2RSaEpyeXdtOGo4?=
 =?utf-8?B?clpjMkZyV1hFc0VUenloVUFxamNWbExpQnBMSWJBYmMrcHB4TllpQk9nbUF6?=
 =?utf-8?B?UmhZMWsxSzJLaUpWOW9jbVVidmJnalBCRHFMR2VhU2lJWDZBRTZGTUtqVDh6?=
 =?utf-8?B?U21KTThYdjMwd0psL200cVVndXJuSnF2UFVycUJqcnpBV3hvaUZGeTFPVVk3?=
 =?utf-8?B?eGhkRElEZ0ZBQjVkZkU1aEFPQ0FIZm8vcitQWnpsN2tkdldoS0NwYjN4aVVK?=
 =?utf-8?B?aTBIQzlxa3pGOXJMYVQvaEpzRHlMeHVxTFFLVnJ4dkhsOFRHYjhTNWx3RTJu?=
 =?utf-8?B?Umg1TDhsbm4yWHI3NVdzQ3k2bUdUYUloMjR2WjNTeTh6M3hSQktNSk5lQ25W?=
 =?utf-8?B?M1hIZVE1VnJITzdwc2UyOGhKZVNkazNaRGFBZTVWUllybjNsa1JaQWJwNmxS?=
 =?utf-8?B?NmxjLzB4ZERmMmlBL3FNYzFxMzNybmdNSTRXL3phY2RMSnVzM0RwMzdrRXRq?=
 =?utf-8?B?YjU5TXNPNFphUTF3UXZFUXBnaHRpenNObUQ2OFZLcXk0ejBqRS9rNmpJTDcr?=
 =?utf-8?B?ZFMwYS95YjUrVDlEa0lqQ00ycm9GSlpxVnVreURmMGxGNzV5VkRmUVZsU2NM?=
 =?utf-8?B?UlF3UURRQitjVFkxZ2RDcnRWSXR2bjlaMVZMVEUvdzJtOXQwRmovaFNFZHNE?=
 =?utf-8?B?Q1o2L1JKb2ZzZ0ZmNXR3QUZ2Tlk0dml5TTFzcHRYYy95OGNaSkkrWVBKUGVh?=
 =?utf-8?B?c2llQUdQT1lnOFVQM01CdnJMWkhOZ2Z3b1JEbWF3VGVQREhaNGhQakdVRVZ6?=
 =?utf-8?B?TEw3dFVQQUY4MkVJa2dzSkFubUJ5cEwzYlRTamY5KzhLUjlJc3Jpa2Eyc1Qy?=
 =?utf-8?B?YVdrRDBpYURwYXZpMHE3bHBuelM1VEFsanBDNUNMdGJadWEvNXB6UXRhazB4?=
 =?utf-8?B?bjdkdmEydzNQYnZsM1FkaVZQOEJZTXdQc2xTNCt3eDVWZXZVWGZ1Zz09?=
X-Exchange-RoutingPolicyChecked: cvHt6076maKtkuPH6cNyf70ZcUBTZQVORsRkpGjQg2d1KA7o9qbcXbsp12x3LXmfWH6wwMtlJQ9zG3RNqr1U/f2902SZCSlzHsMHwaOyPveiAegsFc5wUmEn2lsx7+UvkZh20J7ftptniH3CA2Q5aKHWLCLY/75xmAnHc/+nHozyerwggZHtCXp+EcS7mNGeMdOmOteZyTN1hoAVL0yW9KcqJAHHl/Atukiq1mjloiokbG5cC20V5+CPT+ASyJViIIn0srqsXtZJuF2O3K+Eu7AjpRzrb9NbIW81Ew4l2KBgRdjqEXf1t6XEVCtbTq1XwXGzZkLDqXAwNAloJFB3gA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9689db0a-8a1c-426d-ad3b-08de9a9b153b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 03:00:00.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyfP3dZUb2dmY5mszfn2BHburam4bAEX3uW84ry7Iq9WR8lYXjoGlyOlFRWgkr1KxXIsLO6Wm85h0wMqfnc6zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com

On Wed, Apr 15, 2026 at 01:41:06AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-04-14 at 17:59 +0800, Chao Gao wrote:
>> The main point is correctness, not saving time.
>> 
>> If shutdown fails midway, the update is still recoverable — TDs can continue
>> running. But if we proceed to seamldr.install anyway, it becomes destructive.
>> Aborting early on shutdown failure preserves recoverability (this is needed to
>> handle races between updates and TD build/migration).
>> 
>> If seamldr.install itself fails, it's already destructive, so aborting early
>> there just saves time. But using the same abort mechanism for both keeps the
>> error handling uniform.
>
>If it's non-required for "turning the lights on" it seems aligned with Dave's
>suggestion you highlighted to drop it from the series.

It is required for the shutdown case. Without early abort, a shutdown
failure (recoverable) proceeds to seamldr.install, escalating it to a
destructive failure. The race handling between TD build and updates
depends on shutdown failures being non-destructive so users can retry.
