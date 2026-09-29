Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73963DA7FB;
	Tue, 29 Sep 2026 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696746; cv=fail; b=UzAMVjhl8jPiRdyGpEdbKkkwohxmKUg0R3B6CJ6QUx6bQmuKLHl81iuQ/wgNhDiFXzUFNqZTFjHF6HAFjjnts8tG3+HKA32OnmwsVpnxgxg6irrmuXjiO0MupUUH7DAsvJaGl3224pQA2W5oqygE/VBqVUmq1Ac5QjXDohRMiBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696746; c=relaxed/simple;
	bh=xGuLcvGCtEv/XddT6zggaDw3ap8Lj3BlMjgOasAF/J0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lP+QZWQ4429ZpI4bUYadJGL1NhQ+GMy9zR1byHfy1M6GR5lNXOaX0d2t1ZHYRCLwIKog/gJVi//+QmLXeomPcMsQu+DoJqEPnXbSBZGAUtShqvHnUgFsU7AeZ4UvPGJBUTJe/rEGC2a1oVoD3ZtlGqoE0q3gICcDzyLQN5I86TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=batvUEwD; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="batvUEwD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790696744; x=1822232744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xGuLcvGCtEv/XddT6zggaDw3ap8Lj3BlMjgOasAF/J0=;
  b=batvUEwDatLvfsWwVE0h4rfwCL1+7p03tyiPbAnW7PPwdmGZzZsiCR76
   aW3iv1fSSA3QbQgSS95v1LzssggnpV10lAJ95LGc7IiU8JFqUJMeggLu8
   dNvnbTSByf1kWXB+BVKKuUOKZb/GHypzLU+4Q84cC+WcgTJUTa8V8G1kI
   TLx0OnglVcnv+AXAzfxspOiQtqDMaUo/1Oivti+tCnf5/NU9g0tYRTPNS
   zSakC46ReqLlCGNIMI9/w4SFU/oOUFUKH+FAM9JLWQ8T/KLvtcpfBnJr5
   ZBoOEMqX3lHZu5HVN7vYnNOhiz/Z38E01jOhpSVZhnRR/RQoIK0mdkLU0
   g==;
X-CSE-ConnectionGUID: bBoYlN4tTkCBRun/NAyVuA==
X-CSE-MsgGUID: D5eiaQLHSjiKdMo2qzyYzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="94301779"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="94301779"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 08:45:44 -0700
X-CSE-ConnectionGUID: YLFGRm2QQjqkwwIng918Pw==
X-CSE-MsgGUID: n9Tbh3a+SPWiQzH7Kr3XzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="303372105"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 08:45:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 08:45:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 08:45:43 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 08:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWaWlN5dpFlqQlb++XxSNrdEKKpObNjVRGgmiYLOzyn37TdgfU0WUyaXzFJytMZgw20o67ZoaxBoobOvANmcEzaYfsM5NR6urGsUUjDbGo8yiDIGAnwaCO6AQj7JggLY/oFEifyIY6aSHpoNsnH3//ZySc4Ekm4oaSIL/356Y03+Ypg5VuAZAHa2Uu53ykLH2enUNC/ixNVCTZ/ZcND993qZnVHxkSibLpU+uRXDQoTqj2z6+HtpHYRScbwipIert2I2Bw8ngO9f8gcUidAFfTKq2u++jbpstHra4K1xZeLL0ShWpYmns+fJchnInOmbOHHlnp4mbSE83JAbxNWmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGuLcvGCtEv/XddT6zggaDw3ap8Lj3BlMjgOasAF/J0=;
 b=GkqpcKEHnA95ik05dstjH6/2VYubakIvyOvhFYYHTcp7sYsGXjO79mAv4kN/ZXe4pa8CHh9GdvjpDUBeauU6pCdRzIN3QZ3Cw17YN9JSLhaCqkrYrfsN+NxblMu9Qvz3r3aMKWIWJC+qRVqX/Bn7i5m7ZkMYRcKvN7OBys77fJyhspMq1Okl5AIn1VZxOn1lmdaju8l7UWshBD6MCpgw/WJBsZnfj6xSJOm371Mr959MQi9XHtP4uNgrotaK+sXnGmkKf0/c2FxlVfPvbjX8SNzWK+kOld6BtBk1eR5oqchE+t+i472POftdCAut8q6yycg5qazR5pP3clqwmEGn3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LV2PR11MB155101.namprd11.prod.outlook.com (2603:10b6:408:417::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 15:45:36 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 15:45:36 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v5 4/6] virt: tdx-guest: Add a helper for the Quote buffer
 size
Thread-Topic: [PATCH v5 4/6] virt: tdx-guest: Add a helper for the Quote
 buffer size
Thread-Index: AQHdTzGrpyv2GJzwpkGpI0tjfVPUWLbkKiCAgAAySoCAAQDTgIAAV4AA
Date: Tue, 29 Sep 2026 15:45:35 +0000
Message-ID: <1d20a787ac6c51e923c96b18a8c44fe8e7dd6d0d.camel@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
	 <20260928100913.2265687-5-peter.fang@intel.com>
	 <0c6bc71f-53fb-4240-83a3-c52d090044d3@intel.com>
	 <42975a72efc3a0f96200c065cb86970e8f452625.camel@intel.com>
	 <aruTt9Y-AexP4NsI@intel.com>
In-Reply-To: <aruTt9Y-AexP4NsI@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LV2PR11MB155101:EE_
x-ms-office365-filtering-correlation-id: a6261713-e5b7-426c-9ccd-08df1e40b421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|38070700021|11063799006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 1tG5zsXzfqzqsdUKYJMbS2cWwjf4akEZLyz8rnUpFvyb1hyK3OT6RJatoQqBBrGqDRW5IIreSTq5YSeL2NY9WttFUHoMxY2ubF9+r6ea4GMjWlIMp9wDnhRhXkzA+DOkKHs3vM9eqh562p4vaNrzHaiU/aG4WNuRvQyurv5HvIvYl7Y/ErmtvTIq9Fa+S9QcWiQWf0E0pWOqBxWAftia0xh3m4yG36mEM2MnryLzWfP/XYcVCggtNKxCYEB2BVS+KI34iDtHJiDHDznkBOp4NqAdmF2JTN661MKZRxkGTFN1AZxu7IDnyOtUN5tfPCRzcHCUERsyHbikOeYgHKY0oeW84wWJX0BCau3cWDbbrzeq6ApmBbKn7oBSfGgWcdaf4UmTJhEGO8S6fxdNK2UGrO7z7tFtH2U1E7Lhc6q7PFFL6DCDXbYhkDSmnA/9k3ACRyb4EYo2Wa+GKXEuVEUBZFr8QfLGJl3AJNBmoNlMtdUSEpHlnQseoP19OeBQ7MSU/UKolDLUkH9ZFUpJ4xuPS7tWtxwYAC/OIJi/h5ROkibPyhKyh9bKYq0AOpL6iMbCg2rjYCT41Ynq5ataZKocWaGP0OtAz/PtTDDs85V8eSoTX4HfaqbifBiF/r8gySMWurye7Zc3g3YStyaXqom0DQgGp8BZgjn3BkNHjBG6yLiT1QjTRlIfQ28NgFmu41IcYIgP7guG/R1AkThlVUlsTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(38070700021)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFBRemJabGFScitNbm5LQXR2K3laSHhqTGdyZ3ZPMG5uZ3NoU2RXMkNnSHc2?=
 =?utf-8?B?eFlTb0g4MmJvRk1vRHl3NEx0K3JIMWZIREU3ZkUxa00rNkEwZTNIWUFROEtn?=
 =?utf-8?B?UUFxVEtIc1pXMDNvQkx2K2RwMnQrcjdFR0RLYnBETXMxWkJjSFo4L1Zybmtq?=
 =?utf-8?B?MXJxck1LK2YzV015cURnZWZ1K3Z0VTBnR3hyazZHR0NKYUFUbVAzeS8xZFlK?=
 =?utf-8?B?NTBHMmY4K0Q5eWZtam5wNDBOOUtNM0Y5Q1JNa3M1Rk14dGVEV3pnMnBuS0do?=
 =?utf-8?B?c21rSmxPMVpuZEx3Wnd4SGxwMDJVZWgvRlpWOE84ZFhUN1BaK1AvYnAyOCtk?=
 =?utf-8?B?S1luQXhiSmlkaXlvb1YwZkZaQUFRSzFTNzhrT3V6d2NnWit2UHhZYjQ3OVFp?=
 =?utf-8?B?OTZsMkVOSnRCSG9UbmJzSXIzWjhrVWlOVlVvcFFiSldlalJTMlhrYTRZZWR5?=
 =?utf-8?B?aVNFa1ZVc1hrWXg2ZkRhUFFkOEdsTzFZTW90blVaU0JXeHNyaEhzVXJOR2hM?=
 =?utf-8?B?Y0RYd1VVRExiSlBVRVhOTk9qekFkK3RKb25JNFUwSndnVTU3OXFnWlJpbzB3?=
 =?utf-8?B?QTBERUg1bi9UdlI5YjJFd1ZEVFNyN3gvazBuU3EvWmxmOWduUmJ6TUIvQjYw?=
 =?utf-8?B?ZTVScWh0MkVGczAwdysyNExJK0FqalZQcXhPME5Eci9BMGdrUTBLVzBpT2pp?=
 =?utf-8?B?N3J4Tk5VUUx5b0pobDl4V1poVENGYktjUXE5Qi9DcEkrVWNtQU9NTnQ3MU9F?=
 =?utf-8?B?RjZiTlJ2dlZuVU84eHF2cGJ5aE5MdmlidFJYcksvQnJ5RmVOdkovMEg3NE5C?=
 =?utf-8?B?blJ1RmRkbnBkM2dmQlNEZHM1ME5ad2IxcXJHL09oek5GVHhuaHhwbE9YT3Ra?=
 =?utf-8?B?SWR2bDdtTWhQMllnMHZiWjBHVVZjUGVBM1BUV2VrSGllb25vQ1BrVjdJWVIy?=
 =?utf-8?B?K1pFNi8xbHh2bFFKajRxc0czeUdMOGxZSkZCNlp6am8wMStoUXJmbEgvYTVR?=
 =?utf-8?B?bGJNL1BJcGJSRnhTcEIrdHdPSjdFeWl6RHhRTjdsQ29GQUF5QmZBR1ZaSU1N?=
 =?utf-8?B?cW5MS0owWkxGdEhmR1dyUHVsRmt0S2dNL01IMVNwTldFVlNCVjFiQlM2eC92?=
 =?utf-8?B?OFpOTm9WQmpwWUErRUVHYzExV3JHWHRQNTR3QlViNTJwelhQaTlVeUswQyta?=
 =?utf-8?B?aEJ6K3ZsWlVKc3hFc25HemFiTDB1cVhtUTQvaGtJMEwzZUFveVR1K0ZoRGp1?=
 =?utf-8?B?NXFIRGpRZHBkaXZMYkJISVhvcWtJZjRPNGRPaC85QitxdVlOakRzNjNMRnFr?=
 =?utf-8?B?STE0VVZCRDM1QldoZmlkNVhYUk9rbGZuVXpmVUFUUFNpaWorZDZiMjJ0YjZj?=
 =?utf-8?B?QVNsWjFNaktmWnBmVzNJa1NvbVc0VkNCYTNiSmdxRWtsK1pOcjV5Qjc1ajNM?=
 =?utf-8?B?TSsrRHNlQmxROHdvQUZJSVlxOWs4M3ZYOXNnZ0VhVE1HZDZqeEttNmw4OEUr?=
 =?utf-8?B?YkdKRUZ2SHU5Z2VPc3pMVkp5TE9IUWtVTDlCMDBuRjFkSUIxNmFjVUk1OXZB?=
 =?utf-8?B?a3JKZWNncnFNZU5zZDJ2amRMUDBpZnk3KzF5dnBzQ1BKVk1xUzJkU1JpVlNn?=
 =?utf-8?B?VGliKzFJK2E5dFhXdXJDcEVXYy81TW9LNDBHWXZLY0NuTndzMGhVTkFjSWVQ?=
 =?utf-8?B?UFdpYnAvNUdwL0ZwUHVjZitOTWR4V0RhcVByMXJFNHNXRjRnNWNYbDRkYTNu?=
 =?utf-8?B?N3RERDZ3b2ZNV0ZWN0tJdzJIMkVmclhYamVGY01iQlV5WjR2QW55dkJUWTgw?=
 =?utf-8?B?dVZnYTNxSjJseXZPV0I1aEVaUzNWcWVpOU1nbFBIK0l5U1ZUZU5USm1PbVY4?=
 =?utf-8?B?emFaeW4zOER6L0xFS0NnNFpFSnRtdWNzM1BMM3VQK3g5S1JYTnYwZW5TTnRR?=
 =?utf-8?B?RFZNcE5xbG04Y3ZyZFJydDFGRG42MTAvZExySlVmbktxTzI4ZUw2WWxSN2lP?=
 =?utf-8?B?UjExZ0xNR1ZVNkpYL3JPanNaVTA0OWZTWGc2VXdPSVBMS0p5L24rOW50SlNC?=
 =?utf-8?B?Q2tNMmhTRGpiQ04zSGZVTnY4elltcForSysvbENoTUkrWUZLdlhTQXBTc2d2?=
 =?utf-8?B?dy9iVE1qd3ZLRFdYL0NJdGNKTncvUDNRY0pQOXZjbFMzMTJtL0laSUw2RDNr?=
 =?utf-8?B?TVZVV2doUkxMK2ovZXc3ZG96bVN2STllNXR5UkNHOFdzN3FtNXlXaHNleDM1?=
 =?utf-8?B?QlBuOFpKNUMxOFpRTGNnYkc4MHRVVVlTdTVnSTcwSTlBdnJCWittdXZzYUlz?=
 =?utf-8?B?bXl0d3FYb1N6SW11WUowOEJ0b3N6WEkzNWtheFZLQzIrTlB4K0NON3hvMXlj?=
 =?utf-8?Q?gTRiRPg55a//41s4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DFFB2BD75D0B74ABBD3825CF32A6085@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PNEqijHpAs//iS8Wvmi1qE78XS3knBSIiicPrJzXb1bK/B1apJ/bi2jM9zBwwxR0y6sdD5YXCQ1pMesp1XS54IgphDtdFJtnV9+OxBcujtRVx12uUxGcIX1CCULJyCvOye1PKRg5bWMc4t+qQnUeeKlUWKOvxTNvAq8CvD+ggVYMagiejFF0bQSsqrFpMbTB69QTjl9jHcf20Nb6tUcIbrmCbnJC8jWR0Sgpjmgq0YhTvPb7x/CmnHYG/El3AGxBEIty9wyJ9d87GLfYS5jAYFRUSQgGvtR6apdnHCCCG3TKEauR9wH6Hss9sdu9H+Wa2Kwbacm4ye0ziuEGVylDkA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6261713-e5b7-426c-9ccd-08df1e40b421
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 15:45:35.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XOBwU+9ItECaXYOgdqrSr8MY4RUqFby/b3zQaDXtfRFodBbxRxmkZ+aknkwFvPlgHlV/E7gWtoOMdqO/P/m5ENi8IqAGAYItjgIKxTp9jaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB155101
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDAzOjMyIC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiBP
biBNb24sIFNlcCAyOCwgMjAyNiBhdCAxMjoxMzoxMlBNIC0wNzAwLCBFZGdlY29tYmUsIFJpY2sg
UCB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjYtMDktMjggYXQgMDk6MTMgLTA3MDAsIERhdmUgSGFu
c2VuIHdyb3RlOg0KPiA+ID4gUGxlYXNlIGV4cGxhaW4gdGhlIGdvYWwgb2YgdGhpcyBmdW5jdGlv
bi4gV2h5IGlzIGl0IGRvaW5nIHdoYXQgaXQgaXMNCj4gPiA+IGRvaW5nPyBUaGlzIHNob3VsZCBh
bHNvIGV4cGxhaW4gd2h5IGl0IGlzIHBhZ2UtYWxpZ25pbmcgYW5kIGNhY2hpbmcNCj4gPiA+IHRo
aW5ncy4NCj4gPiANCj4gPiBJJ20gbm90IHN1cmUgaXQgYWN0dWFsbHkgbmVlZHMgdG8gYmUuIEl0
IHNob3J0ZW5zIHRoZSBtYXRoIGluIHRoZSBwbGFjZXMNCj4gPiB3aGVyZSBpdCBuZWVkcyB0byBj
YWxjdWxhdGUgdGhlIHBhZ2VzLiBBbmQgdGhlbiBpbiB0ZHhfcmVwb3J0X25ld19sb2NrZWQoKQ0K
PiA+IGl0IHNraXBzIHplcm9pbmcgdGhlIHdob2xlIGJ1ZmZlciAobm90IHN1cmUgd2h5IHRvIHpl
cm8gdGhlIGJ1ZmZlciBhY3R1YWxseS4NCj4gPiBTZWVtcyBpdA0KPiANCj4gSSB0YWxrZWQgdG8g
dGhlIFREWCBzZWN1cml0eSBmb2xrcyBhbmQgdGhpcyBzZWVtcyB0byBiZSBhIGh5Z2llbmUgdGhp
bmcuDQoNCj8/Pw0KDQo+IFNraXBwaW5nIHRoZSB6ZXJvaW5nIHNob3VsZG4ndCBwb3NlIGEgc2Vj
dXJpdHkgcmlzay4NCg0KSXQgaXMgYWxsb2NhdGVkIF9fR0ZQX1pFUk8gc28gdG9kYXkgdGhlIHdo
b2xlIHRoaW5nIGFscmVhZHkgZ2V0cyB6ZXJvZWQgYmVmb3JlDQpiZWluZyBzZXQgc2hhcmVkLiBB
ZnRlciB0aGF0IGl0IGlzIGEgc2hhcmVkIGJ1ZmZlciBhbmQgaG9zdCBjYW4gcmVhZC93cml0ZSBp
dCBhcw0KbXVjaCBhcyB0aGV5IHdhbnQuDQo=
