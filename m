Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4743B482;
	Wed, 29 Jul 2026 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785362671; cv=fail; b=leSSBdrucaFKfKbkgcnLj2rBLuwAiqs+m5L4dCsYLykxEEbCw6o8EZJ75x+EmhbLfYOYCqNZSfPtxT+CInbsNfE+h3Ri6HOzzvgAV+AWBtWnxyhIpBGtOODD3z9sjSL31x+GQAGRly7aJdRckBlzqzJvQsn+SVeXfV5E3u6X4h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785362671; c=relaxed/simple;
	bh=mIz/svJimC54txumttYxk+gu1xIQbZs9P/OzALJc0aY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQ+g+0tRDsgfv2CoLyKQ0X43KE+i4SGG6ea8gEsXqpgZxZoSOo8+AWzB0ks1InI7jvKcm6gPh8CNsKUkzdgKT7ztTgRCvYjbnvdYgaghgVHQAWEepr/wHsl8HCwi+5RErTLIV46Rr2CXWy9+2ae7xBl6+hxn3WlwXmBmYkDFteI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLMX5A09; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLMX5A09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785362667; x=1816898667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mIz/svJimC54txumttYxk+gu1xIQbZs9P/OzALJc0aY=;
  b=JLMX5A09ZcyXUSwqpzfVFMIUuTMBDdcQ4R/KEPWQhZrrTpPnRePNODOB
   8TX+f8UnQw2LDrm50gNVySHAHO9y4leTRPV7dbf5EKR/VCBqY6Fhrw4s3
   m8Nk19jG+Mn5mwd19C5bClxhOR+5PTP979JOptAWRqe3uAK4StQ5jmEZj
   PUDo/HLweosXiON3Yi1pBWVY3hJXXH8f4TVFA9DVH2mSq76sWe8Wt39CT
   lJzRGBh3HbopLhfZGxPWNU70vDtHXJpkUGBzqRyJd5GvYCqT8ROHR2Wx2
   MftWafS97YHXNd9TPDQKlWYYbQ+HYCAQVAXJWqX13but8IiWCBYPdUsn9
   Q==;
X-CSE-ConnectionGUID: zsL0MorvRZGfVNWPj0bQbQ==
X-CSE-MsgGUID: wAQ2T0wZQWiqXobxXiLx9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86057761"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="86057761"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:04:23 -0700
X-CSE-ConnectionGUID: 0u3voI+PTC29aF9UP9JgiQ==
X-CSE-MsgGUID: lPL4yXTIRnKMu4hqkwGEcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="259545293"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:04:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:04:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 15:04:22 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:04:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0rHwROnDconV2H/Amap5EBgsdxvLXoJXVftFtA6PARmR7w7mQ/3AF39X5pl3qeeI5ya2r+QAIExYVsJyy9NtIPAybAQaRj1di2uuB60DFoeuNIRpPW++klZCHT0tHiTLZG1aeqtB8jgEvr8rBQon9KcAC7/lpM5OLucIs68gNO91thHzF33VcZ8f+Vt38joXjBOlFjQkRTn9nQFi0RALj053fvXoTeDQ2CFK1gejjQw/Kc0j9Bo4XEsdTFRkV5HkgbE2DUQwkJFBu8qwvELoWdu3iEznm/5AsUzw9wVDf8SdG6s62LxdiNFHanOHFvYyrGStVkNAvLg9tPR2sG6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIz/svJimC54txumttYxk+gu1xIQbZs9P/OzALJc0aY=;
 b=L/MthN5yMCIRcetRA3HVgXZl+EVoo30Z73T8i1ScYZqxqE2zy7MfKLrODdJnIR/n9kGfOnFNLWIeJyidi3T1PvxvNFbid9sxKK0QXZDizVEfmTKB91n55pMwohUh/Rn5xv6WBVvkN2cWBLe+QRgv2Iauar/XoMmH+EBx3UPmKpgo2Kcn5SV6r9XAuG8wpWiAxngTwzfavLyTp8Y5uE/Kaoot+GcGfilmy/yMVMlcCt2HXy29Q543JXYJr8ukFjaBcL/bSNqxH8YeUmXKl0QDnie1Gunhp8Ei9lCJS/I5n2CtY6/w+nLBVby1tb1VBfTRdQ1YUi9VuVZN2X9g4n8cIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Wed, 29 Jul 2026 22:04:19 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 22:04:19 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] KVM: x86/mmu: Use LOCK CMPXCHG to clear Accessed bits
Thread-Topic: [PATCH 0/2] KVM: x86/mmu: Use LOCK CMPXCHG to clear Accessed
 bits
Thread-Index: AQHdHieFISPnkkgj4kOehA8FTOxDRbaEWgAAgAAncICAAI6lAA==
Date: Wed, 29 Jul 2026 22:04:19 +0000
Message-ID: <64f162ab48f62d89c00375fac8f245342a1975bd.camel@intel.com>
References: <20260728002236.869865-1-seanjc@google.com>
		 <99aef43760db560d32e12e99df6bf209c67260e8.camel@intel.com>
	 <amoBN62nWqEgh0RE@google.com>
In-Reply-To: <amoBN62nWqEgh0RE@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|DS0PR11MB7286:EE_
x-ms-office365-filtering-correlation-id: b73eb32d-94d9-4fc7-082e-08deedbd56e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: o3q9ZL0zZIq/PNQXXnJnk8EXVQ0lxp8itqM3OEqLaiPrFjvN5tCd61VgIENrEyWklr3n50/Wk68+V2+mIORZJ/GKrZiU5ZkvsTFKq+J6vIVpH22kaNi2d602Fim5J3XNfDfx45GhwhBLnPhoTI2Ze0isGT7dNifpCFKPcRxPbCtLryDUgU7YfSUnbndbDN0yalEwVYZmNu9Pc+6OpfEMun1C/6PQJ0/vdCFp40wc4uQ3MnQrmkQchMzM0gQ91WxvmYawc+VkDsxgZsPZoP+QBRPpYvMeDWgwAoU1CVYtbWOHIS5alTev43uaVcwnYj1owQBymdXW22GOAYbuFUsEXiiwZNfGF2UiZu28Y8HE5oSNnB++1qVEwCtHQqd2/zlIXHld2Zp8ITDjVLvi1UrjxvNk8Xrnc30/5w6In3jGhnexBim2AHRmLXTHVbn7u7e/qRPXnO4qa97Ylxv6X9uI5JKNFCP+3Oll/Cak1yS2+8wgu/7ns4TEjD4p26arXM+59RdGe3MQVSx6KFnlBWUW2kHteeH4jCNO5xhPo7w+X1H+LeZ23p7RardzFDnfW2kUu2+x4tdAGq0OrJSZ69d7bEHiAv9OUjIfOozVvx19mcMLB/mfhPzINhOmtmI/LMQ4Cteec1YqKs5A0cqkecdtAINROylQy2j9Z/woYBOcO+HKdzM7Nd+Umoe5RE9nGKB2hNgYL7Fpzy+Q0QuMCaJXiarFaVrPEncKw0l0Htfjeww=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnN4SkxlMG12RjRzeWdlRDFHaHdQYVdJZU9iQmNrMFFIZmd4ak03MFZ6ME9a?=
 =?utf-8?B?czhJUTVLbTdjV1Y0anVtaytRMDN0ZGxVVi9zNzIyVmVsUVVweUJJM2dFZE1u?=
 =?utf-8?B?YjRpM0ZiSm1zbVNEQll3eFd0Uk9kRUJVWEtxbEY5VzRHaHRSKzhOU0YvTW9x?=
 =?utf-8?B?QUduQjh5TERlMnRKMGQ4cVBDQWhiWEhTdkExUHJIYkxUVkRFanBPeDM3S2ly?=
 =?utf-8?B?cWhWYkt5ZTJWRC9FTndHU29IRGhqWkU4Nm1EdWR0MkxTQ0JWVUZRalVlbFNm?=
 =?utf-8?B?a1VvdnUrU0gvMzdDOUN6eHJSeTNXWnRUcVlBbjdGc0NVY2ZtRlJLbnEwQVRl?=
 =?utf-8?B?R0hpd3VORlRORlJ0TTdmSzNkcnUxV2hqMkJKbmsybkVHdUQ3REpXbjdsbC9B?=
 =?utf-8?B?blBUTlJtNzVFYW56b3VyaE53WEpRZEJYb3dVVVlKQmxMamlEeGFZczNaeGFw?=
 =?utf-8?B?TitMbXh3MHkrL1BWbE5tdWhaMTRtVWwrczBmZTB3dWsrWVJLUVFVYnNlWHlQ?=
 =?utf-8?B?YUZCUDI1eDd6NE5FYURRL1JqYlA3L3g1aHhPQUlZMDc5OTVGSU9RLzU2THN0?=
 =?utf-8?B?R2d6RVpXMHBUbHZEeTNrb0wvb0s4endsWjdCaGNpaUlTNWhsb2grMTgzbVFO?=
 =?utf-8?B?OWVrVHBJWFIyZEFHdWdzazA3K1FheHkvMmhBMHhCMHNxbDlYdjhwRGVaT1RO?=
 =?utf-8?B?VlhmUmg1SHRHTXpCbHBHdDZGaHFPeXpTYTFlM1h0eCtsZ3o0bnVaaVFaRVMr?=
 =?utf-8?B?YkdNbFFDMjhUM05HMnRObFlydjBad1pIQmd3UU5PL25yQ292V0RsdG5aM3BJ?=
 =?utf-8?B?bVVwMnQyUU1TcmdFRHVRMSs0TXVsQU1MSS9WRGhWNXJGaGVobVFLT2NhdDlS?=
 =?utf-8?B?RHdiNVJhRU9NcUkxZUV5ekJYM2hrNk1MS243TzU3VC9xQjdNcGJJQ0tCR2JZ?=
 =?utf-8?B?SkNLR3FJT3hPaVgrUGJXQ2JGOGRYMUQrNkdTb3JUdkNhbndYd0QvdE82Qmow?=
 =?utf-8?B?aGtGUjYwVHVoSVVIQlhGZllYSGRXcVVVM2dUTnpRcWN1azVGdWRieCs5REdn?=
 =?utf-8?B?M0pVbGRSTnprYUdFNlhveWk0OHZGSTgrek1EdGh2QjBTMHZVRDNKak53UHJI?=
 =?utf-8?B?ZmRiWC9LY2tFbVc5b25rTlkwWEcvUHJ3QVlzK1dKbDlPT2F3c1N5dThyS2g1?=
 =?utf-8?B?YUlzem5RUk5oUThSclNDVFRiTzYyL3A5dDQvYlFUdTd0QjRSc2VMTFFqSGlQ?=
 =?utf-8?B?RUtBc1NXNHZkOTJIWStTZGdUVWxZYytnb3BvdXQvV2pyNHBNQVFNR0hTZ3dn?=
 =?utf-8?B?c3FoZzBsVTNJaXlLT0VTTVVoL01adlFuUFNraU9XT1oyNVBxb1IvRU9vK0VS?=
 =?utf-8?B?dVdPSDlucHpCc0VDRnJlUERQZkxkTndNLzFCbXpjUFdZL01aU1paNmFDbzRr?=
 =?utf-8?B?dnpCSGgxU3JWOTJ4Q3BZbjRxMzJyK1NieVFDVTArL2kvMnFoT1lOUG5LVERX?=
 =?utf-8?B?L05sb0t5d2QyT0pUK2o1aUdrMzJwOVNIWjlkYUp2SXVZVVhNSm5kTkRPalpu?=
 =?utf-8?B?dHFTYkpkZ1ZoQzEzMi9Zb2NxNGZGOHRJdVlBeHpTZWlYazlxWElsMmRDYzZm?=
 =?utf-8?B?emhsT0FBNllITUVkMnJRTHhOZlloOTM0anJxbmdZQWZXZGpGdkdXeEZLMmZD?=
 =?utf-8?B?bEI4OEJMOVpBYUZTNEtCVnJ4V0VlOGVlN3hKd1VRZURYRENjYUx2UUVJVGVt?=
 =?utf-8?B?dmRPWURkd0NNNTBWaTA3NlZtVzA5Skh3eTdGa2tIOEx5MDU0cUNwTDFjalBr?=
 =?utf-8?B?WVdGUDg4MkVzZUJHTjQ3S1pHZ08zU2VJS3RQYmJzYnlhZnhRTVR4V29TMmdY?=
 =?utf-8?B?eG85UjIxamg3VmJ4OW9ueGFHK2tndXNMQXdQVEZDc0ZFSHlnY0dib0tFZEVG?=
 =?utf-8?B?Lzg3ZFVlaUdEQUY2VDRxeTFWYStEcTI5WkV4UGs0L0JTVGt4aE9QSEpHenZl?=
 =?utf-8?B?ZkdQbjlJOFZqbjg0TFd6Y3YrMm5KWUh6RURiRE1NNlREODZIODBybnhwOTZs?=
 =?utf-8?B?aUhBb0xaRzlXd0RGZFZLUG52Ny9mT1YrYzdGaUx2NkFYN3k4UjBRYzNnRDky?=
 =?utf-8?B?WWJOeCt4aHNmVE5DNVpoS3NUbURubGUvTmJPUUxjVmZpbjl0SEZRUnlFUHpZ?=
 =?utf-8?B?NXhwYTYvN2h2MkQrM1AvZGNsNFFhcHBCM0lienl0M3VWbVhVNDFVV0VtK0hi?=
 =?utf-8?B?RGhXb0RVTk1RMlFIbkJ5MkpGNXFZbVFkaUk4N2tDWGdhSTZJSm53TXpJOVIy?=
 =?utf-8?B?NVBXbkdEZzVFYUdUYTgrM1A3VTIyUnhMVmY4SWhZRDVwdUFGSmhMUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE313BC9EC14F241BB695331485579F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jPzFXLHosf/5aw4qW3tCZdXtjhw4m71JVscbNO8ZFuP9i2tqXGfYPxeHmHp3AoJ6sTGGgjlgDVFDgMq3ECtRzKoj/w4F4o/rMUW7Wf85PCVwM1oI/5yz3o2NtsrEWdRoZ5z53htF/7p+ESPARL4GzNhSRw2kLzm0bx0Irl36BshLTLtPz2BD6OuTWArf/S04V9cKDFZNeGxZEvgm2+VTqqEaz3ZO0orYmBhFkNAjdzPW7XSW868D8Ok1AfUIFtUyGTnekk8s/cJmquG0tGbKyhwqd1ExNEn2EhGW6Fu6tYAlIWhHWTpk8568TttzRtTSzPF5b3aZ3cqKW6ypAE+4ag==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73eb32d-94d9-4fc7-082e-08deedbd56e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 22:04:19.4846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ux8OtHtJHp7zlbvH77jU8U1KK2pCT7Mubpa25arxONgLK7CDOwD0t+hzVhZu93x3gbdITSjE/HPMZQGlSViESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7286
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTI5IGF0IDA2OjMzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBXZWQsIEp1bCAyOSwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIE1v
biwgMjAyNi0wNy0yNyBhdCAxNzoyMiAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+IEkgaW5pdGlhbGx5IHdhcyBwbGFubmluZyBvbiB0d2Vha2luZyB0aGUgRlJPWkVOX1NQ
VEUgdmFsdWUgdG8gbWFrZSBpdCBvayB0bw0KPiA+ID4gdXNlIExPQ0sgQU5EIG9uIEFjY2Vzc2Vk
IGJpdHMsIGJ1dCBBRkFJQ1QgdGhlcmUncyBubyBtZWFuaW5nZnVsIGRvd25zaWRlIHRvDQo+ID4g
PiB1c2luZyBDTVBYQ0hHLg0KPiA+IA0KPiA+IE1heWJlIGRvIGJvdGgsIGUuZy4sIHN0aWxsIHJl
bW92ZSB0aGUgQS1iaXQgZnJvbSBGUk9aRU5fU1BURT8gIEFGQUlDVCB0aGVyZSdzIG5vDQo+ID4g
Z29vZCByZWFzb24gdG8ga2VlcCB0aGUgQS1iaXQgaW4gRlJPWkVOX1NQVEUuDQo+IA0KPiBIbW0s
IEknbSBsZWFuaW5nICJubyIuDQo+IA0KPiBPbmNlIGFnaW5nIHVzZXMgQ01QWENIRywgdGhlIEEt
Yml0IGlzbid0IGFueSBtb3JlIG9yIGxlc3MgbGlrZWx5IHRvIGJlIGNvcnJ1cHRlZA0KPiB0aGFu
IGFueSBvdGhlciBiaXRzLiAgQW5kIGFyZ3VhYmx5LCB1c2luZyB0aGUgQS1iaXQgaXMgInNhZmVy
IiwgYmVjYXVzZSAoYSkgaXQncw0KPiBnb3QgdGhlIHNhbWUgYml0IHBvc2l0aW9uIG9uIEVQVCBh
bmQgZXZlcnl0aGluZyBlbHNlLCBhbmQgKGIpIHNwdXJpb3VzbHkgc2V0dGluZw0KPiBvciBjbGVh
cmluZyB0aGUgYml0IGlzIG1vcmUgbGlrZWx5IHRvIGJlIGJlbmlnbi4NCg0KT0sgbWFrZXMgc2Vu
c2UgOi0pDQoNCk15IGNvbmNlcm4gd2FzIGlmIHNvbWUgbmV3IGNvZGUgY29tZXMgdXAgaW4gdGhl
IGZ1dHVyZSB0byBtYW5pcHVsYXRlIHRoZSBBIGJpdA0KdGhlbiBpdCBtYXkgbm90IGJlIG9idmlv
dXMgdGhlIEZST1pFTl9TUFRFIGNvbnRhaW5zIHRoZSBBIGJpdCwgYnV0IGxpa2UgeW91IHNhaWQN
Cml0J3MgbW9yZSBsaWtlbHkgdG8gYmUgYmVuaWduLg0K
