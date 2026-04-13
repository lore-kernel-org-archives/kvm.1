Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6872E8DFC;
	Mon, 13 Apr 2026 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776108535; cv=fail; b=ahTME9CvM2ZZ97TbmIwx+4PuXldOcwv82dnjiftzic2Wyof4C40SQ0OAFQH2P1fzp/2mfGAPfDkkPfil4kCNw0qGyevoq77MUSvHpCCLN+r4PyLhnpx/laplBosSA8RXpl+0dN+EOtcGCktbUymhiZLYDalWrJoOYtfJaJwVaCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776108535; c=relaxed/simple;
	bh=aCXFXE0PmWS2d8PdmUHIKHxFenRXnaKLtwftqNtiuDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DxrDQqWDBHrqnmnyRUVZ3ZM75dQZ1mNfuhjnnBNNyX2+oNlIEnIfv4CFnt7z886W78jAEYkfvVMMl5hj4VQQUgc6ThlN3nt92i6ePZEmOuLjgXDUsbVz2ElE5dFfJGT8ARa6+p94fNRMmBWWHpY/+6m9Zwk49kPux8+9PZkEMjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAjBmwpW; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAjBmwpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776108533; x=1807644533;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aCXFXE0PmWS2d8PdmUHIKHxFenRXnaKLtwftqNtiuDk=;
  b=NAjBmwpWkfe4LIBY732hu54mraDWDzp9NORqk/TadOYIVPt6R/Ewvkqf
   M9UjAANVUciRbYE6918twFV+KK7UunJLpjfuo5FJ2k30K0uTMNvAmPfMQ
   adipGrlqp5LFqAjKP5AcvR5Vwj3SgZEWlPhaHnK3m9hnvrUuqmEzTJt2m
   5NH4z2F0Ds1LgdnMk14xRRAoW2aHvxUFcPCbJ7j+IfpFczLZdZlFgwsn7
   WPfkLHTmnNAgddHtdsE886G5VhlDVmSIaN47Bo0Yy9NHRyO769sgAm9D/
   MRHeEOBkgPgZtV8RDsD7TwXqxpVbuPmzS5dbrpjRU+ROyKPWu5U4wIkom
   Q==;
X-CSE-ConnectionGUID: 3R4BMrRkRU2aQkSja+QKTw==
X-CSE-MsgGUID: 453P/whHTBGofw+WhiBPqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="88500732"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="88500732"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 12:28:53 -0700
X-CSE-ConnectionGUID: EPnXgcfGSpahPYowINJaDQ==
X-CSE-MsgGUID: O4f5eCysTii16YVXSQcrmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="229807957"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 12:28:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 12:28:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 12:28:50 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 12:28:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSAEQRvWlJ+nZprScImXvVLH9K4inJt5tuRNk1taC4qjoZbgi44M+YdQOD6U6cNTbNTiTYHmT1UOYLOfcOj/gtmD4ZMIuNCyN/hGh+LO6WAX1YY3l5rJLQZ2R3sN16YUynb/XrZ1sC+LiqPOLpLY2q7IrUrYvykOyZ8xmvdLc+1OFGZEbcN65Q0h03luV8yQ9Wl0THufpafyh++tbWjuitdwxYMk3lthJAsS9dDhdSdvMC2CUMg/WpXVDAvWJtPQwgRO5dts2dS6B25zTpc0BMGG6Zdy2i5Uy73Rq7k4J+UkwX86JEoP1qkxXukJfthM3v3PemQnAjInJcrLCjy7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCXFXE0PmWS2d8PdmUHIKHxFenRXnaKLtwftqNtiuDk=;
 b=BTGK928g5I8Meokto5zyK3wwbhOYYfTpU/Ayr4fum1muOqi/QNXQWF6iIsVD05M8yytWNTkOIYLL8QvBA6XxShvFiNsAB8i+0eHeFbp/my7GcxyPV/w3hTOMJ2+pkP+e86qUOdl+TX5ZO7RTwHqOu/Bbio6bekhri4d3XAQROOhMgJywgEep8Way/ofZ7KkCqxx+J5+dipbzmp9LUsgjAL+7vEEDuC2amFmZt9RfYJCZx3A0OvLB0ZIByLT9imq16/LigX6KPgNPJhJpiiW2tOk0CtcgwoTzyISiQQ01UPsJCLrJTPJ6Aa+Cxh0XWvsEfC9mTp0K9zp6uYq4mWexGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV0PR11MB9863.namprd11.prod.outlook.com (2603:10b6:408:385::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 19:28:48 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 19:28:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 18/22] coco/tdx-host: Don't expose P-SEAMLDR features
 on CPUs with erratum
Thread-Topic: [PATCH v7 18/22] coco/tdx-host: Don't expose P-SEAMLDR features
 on CPUs with erratum
Thread-Index: AQHcwQwK2D2l/qQPb06N1IaIG904hrXddWUA
Date: Mon, 13 Apr 2026 19:28:47 +0000
Message-ID: <8e53c78d2aea30113df55d43040687ab3f36c062.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-19-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-19-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV0PR11MB9863:EE_
x-ms-office365-filtering-correlation-id: 02e1550c-bd74-4770-a0af-08de9992e29c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 2E9CAnOhO9sXcKHt7eMKZwHAcdAOd9S8XjMd5qDs1K2mq/BcqpODRQLXV3q9ad5+LQr38IHHSE1yk0XJZadde2BHD3xDg4PLVowBpHuNYlGAm6rIes87b5jc1j3ZG5mC0gKcyRp/Z8wMkJgL2boAdplZRQ+yfWV12jhW3e8ji1Knq6nalid7Eg05yG7KzzNmA6/Jl7oQe0pM1W1NZMGSC8WjM12kZ+cOp8cz5h2qhXrKsM9fgzWIfrxUaHGHBoY2QSkfGcKUWbG0RnKn2i0CkJN9uPCgIU5I83K7JsY0FuPvSRZCnE49b6Dx+j8zmWO590AXJkmoXVzcXwXnJIjcC34ceLZWHOhMTJ+SNTFFm6w1JXvR8uoc5uuE6kOle8UHbZcyFCBTo+v2o22kITYyZTCZyy9fvR0QXXcreO85Wdlk4CQ/rIuFLjAcIhlo+mLV7bd7N8N2eEeHqgCS2Ug/VIzZzMc+AU7NnWRz15LkBoi41vP3BVpRJKu6oV2VlywHOscgPVUaxNbQwriA6bSdAQTZoB3kcmHqDHaC6D0uEq6gD6R8/bb2JeONGdfg2GVAdZTKITEBNq33PyzXFY2btx0sR/+OuPGkjXbf28PcqwbShV3AVABaZMpPf0GDEH7DQmmTWEeFxrsJZpbnpd07uvV9abFRU4qdDRQQ08UsdTvuPH3TqeCQ0ItCXY4JiDPJfrX6PFM35AS9dvLJthsb7EgebxPQ1oQP580AAPkjX4DCoMHUykanRCX09IZEq1xB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SC9JVnV3Tjc3WlljN2R0d0FqT2ZVMEdEaHRXMEt3MTc5VTg2ZlpDTmVxQmtT?=
 =?utf-8?B?ZzhkQW1qSDAwVWNBN043SWpLSGRJeElGZGl1THlHU3ZBTWtINEN4b1lyY3Jp?=
 =?utf-8?B?NnMwS3hzT0hvcTNvNzcrM1p3cUpmM3lUZVc3N0pwbDdweS9yZVY2Qm9zMng0?=
 =?utf-8?B?UnFYNnU3TVpzd0RjZXlETGtsazRPdUFxMnNCQlA0S2hBSm9tTFpZZk1IMy9O?=
 =?utf-8?B?TWFJRGlQVllTNDd0Vlg4b0hRUmFVclV0dllkYlVTTi9TcHd3NVNRc2NXckp0?=
 =?utf-8?B?Sy9JNHJYK1cydEw1YnFBbVV1aytjeU5TU01KclVISVZaSm11OWVZRW82dDhW?=
 =?utf-8?B?SGI1OWwxaVVjcW1IdHR1YkJUYWFoZHZSLzBMVGx4ZTBGcU93RSt2ZXlKTmpP?=
 =?utf-8?B?RGd0NHJHSmU4cjFwak9YZE5Iem94L1BLWjR4UVduUi9KTEVWZ0g1TER3bGxh?=
 =?utf-8?B?TFBodkZ1Q1RzVXB2dndrYnpCOFJWZWY1K2pRRG11V0orMVZ1N0Y1VEx6VkFq?=
 =?utf-8?B?d2pXV0duazdaU204VFFvbkhtMGRXQko5aGw5TmE1MkdiczFyczhOUHRQa2lG?=
 =?utf-8?B?MkczQmh2QU91YzZ0aUtqUnUyb0lCeFNPQnpZTzZBTUdqMUJpdGtUL283WjNV?=
 =?utf-8?B?Q1dkRDZlcVVEL2JRV0loamYyd2M5QWR2ckZSOFlxZ0ZjalVsVURpelFCYklE?=
 =?utf-8?B?VWRhd1hXS0JZMHdIRTNjcUR3SzRBVmdyR2xtTFBUemNPQWpzQytFSFRFY1ZI?=
 =?utf-8?B?VGE0UERzWW1UY2grSUVxcVFCVVAyQ3dmZlpQdU5oUnd1TjluK1NNSTVKeGln?=
 =?utf-8?B?Yk9rSU1yaitOVzdPcUJVWVREZ3Izc3M5eFYwZUZIQ09MZkZpbnJpM1dxUWQ3?=
 =?utf-8?B?NzNmOVhTQWdOek56OCtJY2MxWnR2am4weXMvSWxCRUdPM0VBUmFWYm12aUZV?=
 =?utf-8?B?dE43a25TTVQ1dXgyTWEvdnd0M3U5VEdBOFI3MU8zZ0FhN1k0VVBkcHF0SDFG?=
 =?utf-8?B?S3hDRGZSdDNObEwvcDdLbzNEUW5QTzg5WDY2QU1FekJXaUxtbmFkZGUwK2tn?=
 =?utf-8?B?RnFvQUJhek1lRmdGamZjUE1zTUF3K05HL2FnR29QOGR2SW5zTFVPM3RWcGhN?=
 =?utf-8?B?YnBISVlLaGVyYmhlSzhPRXBIVFlLbHVqd2R5SHhoZFEyeVQzenN5bXpjYmo1?=
 =?utf-8?B?T1M0SGZKQWYwUnBxNTNOd1ZucWl5dXA2SzAvaHZWdkFLVXJqOWVEajRUR1pi?=
 =?utf-8?B?b1B6eEJiUnk3WHUyRXpQamtRT2liTGdwZTNXaFRDLzRhaXJLYVlXM0xTempC?=
 =?utf-8?B?RUJPcHF3YkpBc3Q2MWhpZ0RUUTB3QWZ0TjJrYkdyZk4wNlRGbmc2V05vTi9I?=
 =?utf-8?B?UDNiOEozall6VGV0VThoS1F4Q1pWb2x4TVZFSTNmdStyTGI2QkpBZ3NzVElE?=
 =?utf-8?B?T0g1MGtlRTRMWHdKdXlXRGNqM1FRZkhXVVdJR29ncEE4bDBKSGpmT3pYeUNP?=
 =?utf-8?B?bDhjMm9wSTF5RzFHc2Q5bGxMWjR0bVh3UWxSaTdaQWRBK2FuYjl5WmY2bDJw?=
 =?utf-8?B?WnFzN2dURkZCSW1qSk5zY1hnWmJROUxacmhoSk04WGlKUXBYcjRkY0VyYkJ4?=
 =?utf-8?B?NnRqNXpYUFhtTnBPbGJJM0J5ZVpZN3FMeVQ4aXJYd2dIWC9sY09lQTkwcVp2?=
 =?utf-8?B?T3RhR1pJQlJIMy94NGlCMUFZQmVHejlWN2hkd0I5Z1hVZlpYMzdibHRKKzhp?=
 =?utf-8?B?S0d1V3hEaVArMGZORVBaVmRkaGlsUWJucTl0UFlaRkNkNnpPb2JldGxXcVFw?=
 =?utf-8?B?Sm5TdHd2cVpobC9ZeXFWYUxvaEkxaVpqTjN1Qmd3akFZeGpHSlMrdUtLVHhw?=
 =?utf-8?B?MkpDU0dNeVlwemVnbGM1M2l1eHFEWUVMZkhMMzN1Ynl1QnkweGYyZFhKQW1p?=
 =?utf-8?B?MFpmZHFDT3E2VjF3TXNQaTJJNkFWNTlFcDRFdmJQdUlTOHFub3BpdG4rbEpR?=
 =?utf-8?B?K2JvZmJEdDdRaGFjcGQyU29NUit1Slh4M010TGhUVFpqSkhkR0ZKem05Q2sw?=
 =?utf-8?B?Qk8vbzR0NXdlRVQ1L1Q4SDVXVFd2b0M4RE05MERJSE1oc0lZbkl1R3Vud1ZR?=
 =?utf-8?B?MlBMaStoKzloaE9EV3ZGSVAyU1Zma1k5NHY0Rk1VT1dqQTRBdUN4cXhYQzh0?=
 =?utf-8?B?MmZvRWhWa3ZUSXluTVJFMTIwMUMzQWxJVGhrU0Zmbjdtb3ZiVkFtMENUTmlE?=
 =?utf-8?B?NmtJYmpkMFFRRm1PMEp1NGVYM2phTTZONEMwU0hQL0FzTEE0TmtBdzJ5Z2NS?=
 =?utf-8?B?V1htbTFoNkdBMVUwSnJ2RlRCU2VwK054cFNUZ29PQ2d2clZvRFJGOXo1d2ts?=
 =?utf-8?Q?MY0hrETcv0LSnV4o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01CA7353EB076242B64170A1700292EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D8HTG6ihnfzgAmwKlNUMJewuYZ6WLzHr8Pxou+izshAThoXd4QqLgBoLuTQwSNJYSfE+a5aT86pfHGVA8bnroL2esFQVXDiScql4+QE8QrUQ27+dQoaAg4ne4pnDuwX7RNFqw7Jw+Y5979Hu/v7RqqRHFOxxqnD0fLHPTRZyKVhRJZQlw8rROfpddj3lcbfTNyg4oWNgxR11E2rITA/X66pzFJ3ELO5DQtInxdGq2/csQdi8DdEROf2QgADCyXkOzy1niHCiT5Obs2h2A4WriqCtDY9ZrCEpxcpprITfyJ1YdJM594woY+aZ3MUzpWisxE7KbuiOrdhBoReONOZhdw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e1550c-bd74-4770-a0af-08de9992e29c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 19:28:47.8817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdwhvcd5hU5570UAmyyqJGYZm4jdV0sTi/oqlChs14xWptoyTdUKetmWg5Dx3fJKyVgnULvBoGED7Fh5PIpCEE9/Pl/c/gx+V5PuuC+K9qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9863
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gU29t
ZSBURFgtY2FwYWJsZSBDUFVzIGhhdmUgYW4gZXJyYXR1bSwgYXMgZG9jdW1lbnRlZCBpbiBJbnRl
bMKuIFRydXN0DQo+IERvbWFpbiBDUFUgQXJjaGl0ZWN0dXJhbCBFeHRlbnNpb25zIChNYXkgMjAy
MSBlZGl0aW9uKSBDaGFwdGVyIDIuMzoNCj4gDQo+ICAgU0VBTVJFVCBmcm9tIHRoZSBQLVNFQU1M
RFIgY2xlYXJzIHRoZSBjdXJyZW50IFZNQ1Mgc3RydWN0dXJlIHBvaW50ZWQNCj4gICB0byBieSB0
aGUgY3VycmVudC1WTUNTIHBvaW50ZXIuIEEgVk1NIHRoYXQgaW52b2tlcyB0aGUgUC1TRUFNTERS
IHVzaW5nDQo+ICAgU0VBTUNBTEwgbXVzdCByZWxvYWQgdGhlIGN1cnJlbnQtVk1DUywgaWYgcmVx
dWlyZWQsIHVzaW5nIHRoZSBWTVBUUkxEDQo+ICAgaW5zdHJ1Y3Rpb24uDQo+IA0KPiBDbGVhcmlu
ZyB0aGUgY3VycmVudCBWTUNTIGJlaGluZCBLVk0ncyBiYWNrIHdpbGwgYnJlYWsgS1ZNLg0KPiAN
Cj4gVGhpcyBlcnJhdHVtIGlzIG5vdCBwcmVzZW50IHdoZW4gSUEzMl9WTVhfQkFTSUNbNjBdIGlz
IHNldC4gQWRkIGEgQ1BVDQo+IGJ1ZyBiaXQgZm9yIHRoaXMgZXJyYXR1bSBhbmQgcmVmdXNlIHRv
IGV4cG9zZSBQLVNFQU1MRFIgZmVhdHVyZXMgKGUuZy4sDQo+IFREWCBtb2R1bGUgdXBkYXRlcykg
b24gYWZmZWN0ZWQgQ1BVcy4NCj4gDQo+ID09IEFsdGVybmF0aXZlcyA9PQ0KPiBUd28gd29ya2Fy
b3VuZHMgd2VyZSBjb25zaWRlcmVkIGJ1dCBib3RoIHdlcmUgcmVqZWN0ZWQ6DQo+IA0KPiAxLiBT
YXZlL3Jlc3RvcmUgdGhlIGN1cnJlbnQgVk1DUyBhcm91bmQgUC1TRUFNTERSIGNhbGxzLiBUaGlz
IHByb2R1Y2VzIHVnbHkNCj4gICAgYXNzZW1ibHkgY29kZSBbMV0gYW5kIGRvZXNuJ3QgcGxheSB3
ZWxsIHdpdGggI01DRSBvciAjTk1JIGlmIHRoZXkNCj4gICAgbmVlZCB0byB1c2UgdGhlIGN1cnJl
bnQgVk1DUy4NCj4gDQo+IDIuIE1vdmUgS1ZNJ3MgVk1DUyB0cmFja2luZyBsb2dpYyB0byB0aGUg
VERYIGNvcmUgY29kZSwgd2hpY2ggd291bGQgYnJlYWsNCj4gICAgdGhlIGJvdW5kYXJ5IGJldHdl
ZW4gS1ZNIGFuZCB0aGUgVERYIGNvcmUgY29kZSBbMl0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBD
aGFvIEdhbyA8Y2hhby5nYW9AaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxr
YWkuaHVhbmdAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogS2lyeWwgU2h1dHNlbWF1IChNZXRh
KSA8a2FzQGtlcm5lbC5vcmc+DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS9m
ZWRiMzE5Mi1lNjhjLTQyM2MtOTNiMi1hNGRjMmY5NjQxNDhAaW50ZWwuY29tLyAjIFsxXQ0KPiBM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vYVlJWEZtVC02NzZvTjZqMEBnb29nbGUu
Y29tLyAjIFsyXQ0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29t
YmVAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVy
ZXMuaCAgICB8ICAxICsNCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL3ZteC5oICAgICAgICAgICAg
fCAgMSArDQo+ICBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgICAgICAgICAgIHwgMTEgKysr
KysrKysrKysNCj4gIGRyaXZlcnMvdmlydC9jb2NvL3RkeC1ob3N0L3RkeC1ob3N0LmMgfCAgOCAr
KysrKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaCBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmgNCj4gaW5kZXggZGJlMTA0ZGYzMzliLi4zNzdkMDA5Yjdl
MmUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmgNCj4g
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaA0KPiBAQCAtNTcyLDQgKzU3
Miw1IEBADQo+ICAjZGVmaW5lIFg4Nl9CVUdfSVRTX05BVElWRV9PTkxZCQlYODZfQlVHKCAxKjMy
KyA4KSAvKiAiaXRzX25hdGl2ZV9vbmx5IiBDUFUgaXMgYWZmZWN0ZWQgYnkgSVRTLCBWTVggaXMg
bm90IGFmZmVjdGVkICovDQo+ICAjZGVmaW5lIFg4Nl9CVUdfVFNBCQkJWDg2X0JVRyggMSozMisg
OSkgLyogInRzYSIgQ1BVIGlzIGFmZmVjdGVkIGJ5IFRyYW5zaWVudCBTY2hlZHVsZXIgQXR0YWNr
cyAqLw0KPiAgI2RlZmluZSBYODZfQlVHX1ZNU0NBUEUJCQlYODZfQlVHKCAxKjMyKzEwKSAvKiAi
dm1zY2FwZSIgQ1BVIGlzIGFmZmVjdGVkIGJ5IFZNU0NBUEUgYXR0YWNrcyBmcm9tIGd1ZXN0cyAq
Lw0KPiArI2RlZmluZSBYODZfQlVHX1NFQU1SRVRfSU5WRF9WTUNTCVg4Nl9CVUcoIDEqMzIrMTEp
IC8qICJzZWFtcmV0X2ludmRfdm1jcyIgU0VBTVJFVCBmcm9tIFAtU0VBTUxEUiBjbGVhcnMgdGhl
IGN1cnJlbnQgVk1DUyAqLw0KPiAgI2VuZGlmIC8qIF9BU01fWDg2X0NQVUZFQVRVUkVTX0ggKi8N
Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZteC5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vdm14LmgNCj4gaW5kZXggYjkyZmY4N2UzNTYwLi5hNWE1YjM3M2VjNDIgMTAwNjQ0
DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZteC5oDQo+ICsrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3ZteC5oDQo+IEBAIC0xMzYsNiArMTM2LDcgQEANCj4gICNkZWZpbmUgVk1YX0JB
U0lDX0lOT1VUCQkJCUJJVF9VTEwoNTQpDQo+ICAjZGVmaW5lIFZNWF9CQVNJQ19UUlVFX0NUTFMJ
CQlCSVRfVUxMKDU1KQ0KPiAgI2RlZmluZSBWTVhfQkFTSUNfTk9fSFdfRVJST1JfQ09ERV9DQwkJ
QklUX1VMTCg1NikNCj4gKyNkZWZpbmUgVk1YX0JBU0lDX05PX1NFQU1SRVRfSU5WRF9WTUNTCQlC
SVRfVUxMKDYwKQ0KPiAgDQo+ICBzdGF0aWMgaW5saW5lIHUzMiB2bXhfYmFzaWNfdm1jc19yZXZp
c2lvbl9pZCh1NjQgdm14X2Jhc2ljKQ0KPiAgew0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmly
dC92bXgvdGR4L3RkeC5jIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+IGluZGV4IGQx
NDQ4NjBlMTdjMi4uOTJhYjFkOThlMWI4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3Zt
eC90ZHgvdGR4LmMNCj4gKysrIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+IEBAIC0z
OSw2ICszOSw3IEBADQo+ICAjaW5jbHVkZSA8YXNtL2NwdV9kZXZpY2VfaWQuaD4NCj4gICNpbmNs
dWRlIDxhc20vcHJvY2Vzc29yLmg+DQo+ICAjaW5jbHVkZSA8YXNtL21jZS5oPg0KPiArI2luY2x1
ZGUgPGFzbS92bXguaD4NCj4gIA0KPiAgI2luY2x1ZGUgInNlYW1jYWxsX2ludGVybmFsLmgiDQo+
ICAjaW5jbHVkZSAidGR4LmgiDQo+IEBAIC0xNDYyLDYgKzE0NjMsOCBAQCBzdGF0aWMgc3RydWN0
IG5vdGlmaWVyX2Jsb2NrIHRkeF9tZW1vcnlfbmIgPSB7DQo+ICANCj4gIHN0YXRpYyB2b2lkIF9f
aW5pdCBjaGVja190ZHhfZXJyYXR1bSh2b2lkKQ0KPiAgew0KPiArCXU2NCBiYXNpY19tc3I7DQo+
ICsNCj4gIAkvKg0KPiAgCSAqIFRoZXNlIENQVXMgaGF2ZSBhbiBlcnJhdHVtLiAgQSBwYXJ0aWFs
IHdyaXRlIGZyb20gbm9uLVREDQo+ICAJICogc29mdHdhcmUgKGUuZy4gdmlhIE1PVk5USSB2YXJp
YW50cyBvciBVQy9XQyBtYXBwaW5nKSB0byBURFgNCj4gQEAgLTE0NzMsNiArMTQ3NiwxNCBAQCBz
dGF0aWMgdm9pZCBfX2luaXQgY2hlY2tfdGR4X2VycmF0dW0odm9pZCkNCj4gIAljYXNlIElOVEVM
X0VNRVJBTERSQVBJRFNfWDoNCj4gIAkJc2V0dXBfZm9yY2VfY3B1X2J1ZyhYODZfQlVHX1REWF9Q
V19NQ0UpOw0KPiAgCX0NCj4gKw0KPiArCS8qDQo+ICsJICogU29tZSBURFgtY2FwYWJsZSBDUFVz
IGhhdmUgYW4gZXJyYXR1bSB3aGVyZSB0aGUgY3VycmVudCBWTUNTIGlzDQo+ICsJICogY2xlYXJl
ZCBhZnRlciBjYWxsaW5nIGludG8gUC1TRUFNTERSLg0KPiArCSAqLw0KPiArCXJkbXNycShNU1Jf
SUEzMl9WTVhfQkFTSUMsIGJhc2ljX21zcik7DQo+ICsJaWYgKCEoYmFzaWNfbXNyICYgVk1YX0JB
U0lDX05PX1NFQU1SRVRfSU5WRF9WTUNTKSkNCj4gKwkJc2V0dXBfZm9yY2VfY3B1X2J1ZyhYODZf
QlVHX1NFQU1SRVRfSU5WRF9WTUNTKTsNCj4gIH0NCj4gIA0KPiAgdm9pZCBfX2luaXQgdGR4X2lu
aXQodm9pZCkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydC9jb2NvL3RkeC1ob3N0L3RkeC1o
b3N0LmMgYi9kcml2ZXJzL3ZpcnQvY29jby90ZHgtaG9zdC90ZHgtaG9zdC5jDQo+IGluZGV4IDc0
NmE1ZWVmMDA0ZC4uNzFlYTk0ZGE4ZTIyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3ZpcnQvY29j
by90ZHgtaG9zdC90ZHgtaG9zdC5jDQo+ICsrKyBiL2RyaXZlcnMvdmlydC9jb2NvL3RkeC1ob3N0
L3RkeC1ob3N0LmMNCj4gQEAgLTEwMCw2ICsxMDAsMTQgQEAgc3RhdGljIGJvb2wgY2FuX2V4cG9z
ZV9zZWFtbGRyKHZvaWQpDQo+ICAJaWYgKCFzeXNpbmZvKQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+
ICANCj4gKwkvKg0KPiArCSAqIENhbGxpbmcgUC1TRUFNTERSIG9uIENQVXMgd2l0aCB0aGUgc2Vh
bXJldF9pbnZkX3ZtY3MgYnVnIGNsZWFycw0KPiArCSAqIHRoZSBjdXJyZW50IFZNQ1MsIHdoaWNo
IGJyZWFrcyBLVk0uIFZlcmlmeSB0aGUgZXJyYXR1bSBpcyBub3QNCj4gKwkgKiBwcmVzZW50IGJl
Zm9yZSBleHBvc2luZyBQLVNFQU1MRFIgZmVhdHVyZXMuDQo+ICsJICovDQo+ICsJaWYgKGJvb3Rf
Y3B1X2hhc19idWcoWDg2X0JVR19TRUFNUkVUX0lOVkRfVk1DUykpDQo+ICsJCXJldHVybiBmYWxz
ZTsNCj4gKw0KPiAgCXJldHVybiB0ZHhfc3VwcG9ydHNfcnVudGltZV91cGRhdGUoc3lzaW5mbyk7
DQo+ICB9DQo+ICANCg0K
