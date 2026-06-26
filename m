Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD913B7AE;
	Fri, 26 Jun 2026 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434790; cv=fail; b=Zl6o2DTj3KNDT1hoQCmyp9qluVgWuYxWp6BdXW/yxwBRlcpzGtzFeqR6AKhAhD7kxrnzpIa2KYffYJ6CwOwsTwAQqpzts0LZewKy2aSw3EEwquHDvzbc8pZ5j5/U1igDhEtblKj0yLHVjOZzszwVrMBfnxC3g20HVi6J9NwuBDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434790; c=relaxed/simple;
	bh=/wAzd+CkxKpCRFicxtJnorot5JjYCw1I8PXS6OBictI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uraau+DeCL9iBXvyL2q73Hns+M+3nr7yl9iTl7b4DSvNUU8IWK4lBtg3nHxbsKT8jLK9J2dZ6wpgF51tARbrbah3Zk/YRikm0KD/f4eJyU+PHW0fYr7lfbH1rBm+8xI18CQ/LjZkoGje9lVB9J26Y8KtbTAAudRS3mU71irIXfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0yj1qvx; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0yj1qvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782434788; x=1813970788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/wAzd+CkxKpCRFicxtJnorot5JjYCw1I8PXS6OBictI=;
  b=e0yj1qvxgKI4RRUhED5UsxJJUnmqOWj1B0hgFHFuXIzgsVcsWqHD3WCO
   nk/xO/DjNDDkpD9XVgbgjB+qoElJ+xdwyGsMouOSk1HMDYGz252ARjhTx
   ym+zD8tNShcxqUHS54cAi3HX4wzn0TBARHHVqF9uiVUNCbLHxts4lXO/i
   IToq9cn1VcXEy9VM4imJ9EQ4KBf8ENg14lddw+K5sBa96UpuJ0g2XBkDE
   JSGQtHYbDu6cHt1eBE0roah+3vztXQGqARPVav1kdSDm5oZIBJOxI0Rqn
   f0ZwTmtx/Crgxhgjt318mZnQE8xsLyVF2deqmpqT+hmqsF56yFGJBh2f9
   A==;
X-CSE-ConnectionGUID: 0fvzUXqJRMC/pncckxuqJg==
X-CSE-MsgGUID: 4m8Ab3HqTFuOVM/0xWn9Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83427305"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="83427305"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:46:28 -0700
X-CSE-ConnectionGUID: ilYwzi8TRseEVZBPJboHdA==
X-CSE-MsgGUID: KdMvP2lITtK2SpexGvCRIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="249534388"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:46:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:46:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 17:46:27 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWj7+WUXxr7C/BooXPzjyhQbkPD3Rg1mMoI0Ooz+xEPE+U+NqHDbCJDxiz2QzsTOMIPVapOO7p8D9BwOVI8r5/Ljn1NSP8rt1Jz4nR1J9sMcNV5U2Gdf7exlcwnWu1sz8ZnvWUsV5Z7soeV1NS1yxloPUqNmghKMWsx5ORkPVBA2aAaIHBTtDhdLZY8y7XCddAUnFAlY0D5PZEOoIyqyF2K/dUoXOoXxSD+zm43w7QszoFqFcaGydHRaS1Sp4hLYQoFFZibaUN7dR81umkyoD320G+R6UWTArHNfQFqjWLSkl/3LRFUBNOYFxdXsK7VGtv/Xsxb2vwTYUn2OyBIo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wAzd+CkxKpCRFicxtJnorot5JjYCw1I8PXS6OBictI=;
 b=TMDq36Yt3yBm6opwIu+R2Ku38fNqYTGD9OC5aNpTuHtvGU56lfV1s4SSDf/l77lvS+P7BI0W1Xz7jnHyVJ2AQqRrm9+n4gwBPw226aJPzdVClEViW31cTallA6NDdnFyk3XmBSfc4az+RuNjkFzNSsdss2XHvL2CCjV/LsO3Pvg3/1NMRPKqpK6nIb7slWISGvNYjzS1oz2aRBADNUyKIBHCkv5qJqmRW5V2qXqzgyI+VgheoNnTiCu+dlvMyDViYHtbxTimtwaiLO3XFqnatLlVXITQ1tqjaP7cnNiOtCopls1sxwsoZQqFjOG/aTOygdS68eSb6zmz0Kk2wPJCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SJ5PPF8AFAE74CF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::841) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Fri, 26 Jun
 2026 00:46:19 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 00:46:19 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH 7/9] KVM: x86: Move KVM's arbitrary task switch reason
 enums to x86.h
Thread-Topic: [PATCH 7/9] KVM: x86: Move KVM's arbitrary task switch reason
 enums to x86.h
Thread-Index: AQHdBO61aOQ0CcASpUyTtznm33CuX7ZQAIeA
Date: Fri, 26 Jun 2026 00:46:19 +0000
Message-ID: <dd59d9a560749a1dc48d0d518cac160c45a8ae1e.camel@intel.com>
References: <20260625220450.3354415-1-seanjc@google.com>
	 <20260625220450.3354415-8-seanjc@google.com>
In-Reply-To: <20260625220450.3354415-8-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SJ5PPF8AFAE74CF:EE_
x-ms-office365-filtering-correlation-id: bac876a7-fc11-4209-faca-08ded31c5692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: ANm6DUYdPzuKpwG/A492UDhrAOHmMyAemx2yILTo1qunC6TKGbOkKzceOfK3ZANwvY7pJ+uFbjYmsNxLL+51pMYgHY1DziBNqDFGhC+T2LkkYXHVUgixdpaMlmdxCjITQ/fisbmmCqP6TYzqzsgAmfVEZtSIv/gEK3FebyYbuSDjVILIYtoLWgxlr++Vi95KwlPd8zvM0pFR8BeNB3Erfqv1KrPCOZxRfLbkGfRfhTdhfxnW+AdJra1zTNgaqg9oBRq8MHZFZm/Qha5Mj6RmhKlVksnCjT5j9hVt+88DcXNUSeELuFLWfwlrmN8gxMU40LPLlMeQ1p28GmyFChV1VkRIt+TWXA89T/ktGJ2zvNKpi7sDcMcJtu1rjU5L3JCyRbMoDpQeKPseJspDphKfpHFqwa2kDUohQrb/g4MIrLEVVH8yTo2cauHhQrr/wmk4AELL4baK9Qv9cI5byd95nPU2nmzgfS/qieiCka2W5PYU9D9M5rHepwlDFifo97QhJX3L38JXke3OBdLDHq0Q6opMnBAHwmMM6fCU7jc8OeYmakwrWCwll/un8WHJBmA3THRp2fRRlpnGwG8xPLrVTk4iQxmdYbWXMeuY5TauGORvws3tIMsQBU2vKsiRByuUoqh2puCtV2Wn3zC/ZGg09WGYjT++5/2RYN+6yIpltHEZaO28iS/w2QlSIxWLOhRFy3Lop/cwfq4DKNuINDHGb+deB1IST+WbkgSghsf9FWk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXJLbi9SRGtjNVF4VlBYK1VHSXZkZXQ2Rm12a0NDMDY5aThEcm8xSjBkMStp?=
 =?utf-8?B?V3haQTNlZzdqQ0ZCcGxaTU1kbURtWFRSUVRhSmc1bjFQUEV4ejRURjJRRjFQ?=
 =?utf-8?B?VCtJV3o2MjFhNzRWMCt0UVp0K055MnhxQzBtTStwZkt0RUFKR213dnQvNXRU?=
 =?utf-8?B?VjgxeHhEOFU0ZXNpR1g1eU9BaXovWkVieVpXQnkwOVdoZjV0NzZHT3JibGEz?=
 =?utf-8?B?WWJQYUY3OHp6cW4wd1kxM2NGTHoydXR0czJ0N3RFamxsYWtVcnlwa3ZTVmpo?=
 =?utf-8?B?RDhuTnVjeHBqcnNHdEgvU29HdFFsU2VnRHMwSHRGbG85czVNR1h6aFlmY1ZN?=
 =?utf-8?B?cnJxYlFiaGY1OXM3bit2SnBiUkh5ZXdQYkhsN1MzS3JnaVF3d1c1aWVhZC9M?=
 =?utf-8?B?eW8rdmsySXRCamVGTlplWldTajNUd3Nycyt2RytXSUtNY3Z3RkZrZnpzOW1q?=
 =?utf-8?B?dW1ncXdjWnY1SGNqbWFyOXh6dGdxS290RzlpZ3ZMN3ZBelFtemgrVVBCN29M?=
 =?utf-8?B?a2dEcjdGcUNERnczUkZBTHFabTdMd2hnSEtCQlhSUnpHaWJVK1NlVENQeTBE?=
 =?utf-8?B?ZldnWnp4MlF3cGNELzk4bmtmdEhPTUVTY2YvaUhwNi9rZThQbXBRNU9aclZn?=
 =?utf-8?B?VjJPS1pDZGpVOXU4anZXTXMyWWpIWVZWSFlIUjd4WEtwbFZZN0lzV3JicXBh?=
 =?utf-8?B?R2lUWWdMNmpvOUI0VWlzeVhndzNJNzRXWHlrU0xYWE56NHlGdnkyOGxBejdZ?=
 =?utf-8?B?V082NlFDM0t6bStCRGx5YmVLTHB0ZkNWSExic01TWlZ0M3Nsend2UXllNDFG?=
 =?utf-8?B?am4zenJVRHk1VFFqZHFLdzZ0T1NoeVJOZUxSYWdaZzUyUnY0MHdFMTBWbmhJ?=
 =?utf-8?B?VWxJWEhXR0QxaG05cSt3d3NESU1IYTBZQjJFbHYvLzFGUlhOalFMR1hCaGhu?=
 =?utf-8?B?RTlwSEIra1ZJMkV2RTVYRDNrbTlNT2dUcnpRYkhNT1F4ckdpdmZodDhHNzdL?=
 =?utf-8?B?SkFIbVNDdUtWSU5ad1l6dDZ6SDJJQWdTTDZDQmliYkpiTzAybkE5TWpyU0hs?=
 =?utf-8?B?Q2JqYTVzbkVIYW5YdTR6TW1WYUVRWDh4TkE3WlptMWovOGo3MGllTzhCVkkw?=
 =?utf-8?B?cWJJa2ZEdWp5bWRSS2NLVDRVWWgyZWxuQUMxbmUxUlpmdFVoR2toMVIxR3o2?=
 =?utf-8?B?WTJZMlBGZEN5MGpVTDYyditIZS9HWEJNV2pvbWIrUll2NWVjWTdSM0FVTU02?=
 =?utf-8?B?NXlOU3dVdXZuUjZyM2dxaExUZ25HUXVZZkovajJieG1XWm1FRFp4amQ2Rktv?=
 =?utf-8?B?WU12VTQyUEp4Qkx3NlBMNm92ZUxSRTliM0pLK045SmFkYUFnV0xCS0o4S3dv?=
 =?utf-8?B?Ym9tN1hrdGRCaUs4L0h3MDFNODNRcDVtNUVlRjNpNGJ1MzFNRHIzTCtRcUVK?=
 =?utf-8?B?MmllbEVOYlIzdXh2U3BadjNRVS8zSzY2WEpnQ3VQb2F1bjVva3l2U1UyZ2dQ?=
 =?utf-8?B?ZHduandzU3FmNEhHVk1WVG16Slp3ekJZTkVabEVUeGdUUDhmb3RWemJkWkRy?=
 =?utf-8?B?TGg2UTVjWHlpVHJjQXdaMXNYQitvTjdaMWJSY2NkN2MrbHBKQnJ6Sk83R0NU?=
 =?utf-8?B?RVN5UDIwMkQvcjFiTDNka3JiS2VPRENNQklLUDZIdk8wMENGZ3dWQ2VCRnFi?=
 =?utf-8?B?ejZ1QjhFUklOWmdMbC9RQ2wydGtZUTRCbFN5WkZ6K2Y4Wnk3QzE3by9kSXl2?=
 =?utf-8?B?U2t5U2VqSHpjOGR3a3EyMnBOUURRVlZOeEdVSUlGaitRSWRjSDhrZzVScWpH?=
 =?utf-8?B?dFlvTHQyQ0lsY28yTVZHK3hIUVN2MVZRbWNpWUVSMXZud2psaHc3Y081dXlD?=
 =?utf-8?B?OEtzbDl4cE5FZXBEZit3YXJLNUtKbmRiNUJRTDNoRjRDSFg0V2F0MGs3VkpE?=
 =?utf-8?B?K0ZGV0o0d0htS0Z5REdaUVF3YkJoRFh0SFNySExDNjczU2JsMEVUOENLUTM2?=
 =?utf-8?B?WEFoRGNuVHhtb2NrazlKL2cyRFlTMWU5MEpYa0MranNVU1UxWGRzTklZTUY2?=
 =?utf-8?B?U2daZXhEVTd5SXk1Ni9SWVZrcVdrY1lEd1dnRjQySmpkUWdNTFZXcGx2bmFh?=
 =?utf-8?B?V1pXTW42RVNXUXJmVUJoWGhjQVEyVm5hYUpmQUdYS3V4VWlFWm0yQktLNXpF?=
 =?utf-8?B?WlpKTHR3UUc3Wjk1dEt1RGlYd0dIT1Z5NXZvcmZPNmFtVm9XMmNFSTBGRU10?=
 =?utf-8?B?eU9WM25NSVQ1eDlEb2RyRVhCYXFoM0JOVFROcFhRK2hkQ2lMYVdXRzlJd3M0?=
 =?utf-8?B?YjRkYjNTZDBaYit2M0pRdlRMQkFhRkZxV294NTZaaUZKcmlhVzh5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08214787286E9A44912C64A36AC27E59@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jJlly6/Ev/IHWTEeKFsTGXMQtLvXO2WfuU9ThXItnEG/hHGVDt7Dladvztd58hBEULMMFunPBO/OCd/yaQ91hLOH390jDcf0M11BJ1mdkuMVA7Rfb10MJrl158WaKTdL5QSjPpGz4jD0o0fdBNFtT5lTYtWHp6jW8wXS8V/U9AUOCTmB5cPptQ0OVz22PMfNpuJAkIu8jO/oyuFoFCW9tP+1ZKEM98vfPdR+xcYlNiCCWuftnOWE+WnOIc7q715qXU3OlGiLKTvUVobvW31H49YL1zR5bkv2Bt5uDQSy8BivMXgY890yTOuU2wkFzJMQyFGTMDcT3sBw1Ji6XcaDwg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac876a7-fc11-4209-faca-08ded31c5692
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 00:46:19.7761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsuoquuhjvwYeXJgxclPBZQ+FGyRw58Lj18rOM4Z5gmq46VOX2b9Wo5ANesJzuRI1shvrsuQ26tSwdtMjgQjJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8AFAE74CF
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTI1IGF0IDE1OjA0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZWxvY2F0ZSBLVk0ncyBUQVNLX1NXSVRDSF88cmVhc29uPiBlbnVtcyBmcm9tIGt2
bV9ob3N0LmggdG8geDg2LmgsIGFzIHRoZQ0KPiBlbnVtcyBhcmUgYXJiaXRyYXJ5IHZhbHVlcywg
aS5lLiBub3QgYXJjaGl0ZWN0dXJhbCwgYW5kIGFyZSBpbnRlbmRlZCB0byBiZQ0KPiB1c2VkIG9u
bHkgdG8gdHJhbnNsYXRlIHZlbmRvciBzcGVjaWZpYyBpbmZvcm1hdGlvbiB0byBhIGNvbW1vbiB4
ODYgcmVhc29uDQo+IHdoZW4gaW52b2tpbmcga3ZtX3Rhc2tfc3dpdGNoKCkuDQo+IA0KPiBPcHBv
cnR1bmlzdGljYWxseSBuYW1lIHRoZSBvdmVyYWxsIGVudW0gdG8gaGVscCBkb2N1bWVudCB0aGUg
cm9sZSBvZiB0aGUNCj4gdmFsdWVzLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5k
ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29v
Z2xlLmNvbT4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5j
b20+DQo=
