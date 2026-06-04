Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849F35F5EC;
	Thu,  4 Jun 2026 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570851; cv=fail; b=ocEodOufGfu/GuGKlVg180mFLDyTwIg309sr/jQX2hqr82EI9YsjhCYg7sZ/gnpwi0Q/VIaE8usNcHr2A6TUTKEUih0Dgj/Djf0ZmmZO2QrECw1NGgKYvJaaY6uk+c9xr+0e4LvcyzIF4+sCg3OFp2vYTVNlwb1gcDO0EEwJGRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570851; c=relaxed/simple;
	bh=j2X8BZAvkXuDwUUT+o4MWYNdxwTCVamX/OP1o59RMP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kVT5pSyi3RMiIEWyAfYLrAKoG12Xe64Mrnr7/3SvVG17uHKt9H09WLyjWoWdZs1HeVVw11EPAeCC1EMvsA5kh0CDQ5bMAB16p24nb66yedRG9NLLQL1zKUcT5bAFC0daprFKhEs+lKszDiQ6araXRPdBf80ZgVmpTSbxkR0fp5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYff4TFq; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYff4TFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780570850; x=1812106850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j2X8BZAvkXuDwUUT+o4MWYNdxwTCVamX/OP1o59RMP4=;
  b=UYff4TFqtzVLdzRp/+PTLXA/gJLtNOf865qQs0iyJuZkGKdZ3gVEqydu
   zRwowLr7spq2kgtor1YrU+rWUhPPxMTGKpnvxN6gkVwU6ZdndbIRZcdVX
   AD+xStaqd7V29YkelkZJkADI6i5CNK3gL56a9tmzhNlVOCDSKq99wMvTg
   BRbtCyau0jl4YklE6mYglFFFofut9uURQ6f9cCmeXme547pJZ8SEaSd61
   eWBrKuM4Xf2tJ0YB2QhwWtfULbNr7dxG5qL/sqWp38gvJ65qlaKy6UPrk
   Apr+qHWXAXT8SN7uqXSZbB9nIPUpkFP7N3XrtV8WMJOti1WfNaF07kB0c
   A==;
X-CSE-ConnectionGUID: AlBQYp8XSNq6BhbG2h2pRg==
X-CSE-MsgGUID: gypFK46pRhKG/v5gr4JHjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80429774"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="80429774"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 04:00:49 -0700
X-CSE-ConnectionGUID: JSQrbbaRRKSZ9o3oFnrG6g==
X-CSE-MsgGUID: AHJdNkCDSkW+TiawW9TY6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="249434992"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 04:00:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 04:00:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 04:00:47 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 04:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpnlBKBoSxMa06QQdOCx0eOSQvO5Ezy2jRpG0LHK3lcao0Pb2IG54cX/xveRMC4a1VxuWxLmM4Du9V3CMe8BrC2sbZBeUIArOugLsyhl+NdwgBzFf2K/jxjTBPicO3xTwYv+QEvx+Wl0jrm6cd0TZE/Spj7f6feZ/qh03qwZuqIwKGWcvx2S/QLaENVGHQTx/Iac5XekDC8mY8v/+b/FjUV1pfmVJJj2YGbEVnALDuNl6IZB+epDE8wW9Rhxo4BmaHGbxPATIlOxNRJMZzkLAcvKKJerhmng1X1eqHx9uTyGcksMfdkWDC0qCOZNpRQVfjVmBQNBw+H5Vxb844jPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2X8BZAvkXuDwUUT+o4MWYNdxwTCVamX/OP1o59RMP4=;
 b=YyKeH+yVtisrKGMmtAiU1uSamfoEBLDZBJqNtgmHZemfX5mwpr7cR6pmC8mpphgj1ETdW2eno15YyVSBprBPndFYYPsYFJyR7/OeCb5NVmyfesv/lXue2btSE4exb8egIoVxWpwjcK0Y5Mbm/Hn8it6MpB0aaJMU8aExAfW3Y95JaarucZe0IwRy8zb47VrRVqSZg4iqQg69dP6vqQZUG30ojryw1ug5QZBOBa+PJ2gKXUOQ/CUStCVKqduhvWCbm8rvri/Nc5dSr0p1dtAWhfuFiaMQt457XMy84lFiHU+7LepY8Qb5V8ofr31XolkoxeVDk0q+NW55rXzBTTk6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:00:44 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:00:44 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 22/40] KVM: x86/hyperv: Eliminate an unnecessary
 include of x86.h in hyperv.h
Thread-Topic: [PATCH v3 22/40] KVM: x86/hyperv: Eliminate an unnecessary
 include of x86.h in hyperv.h
Thread-Index: AQHc77nEPmzDhptcbUKmDNOOyxBUbLYuQ1CA
Date: Thu, 4 Jun 2026 11:00:44 +0000
Message-ID: <62541512da5f11d457a2c4a04341e7180fb494ca.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-23-seanjc@google.com>
In-Reply-To: <20260529222223.870923-23-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|MN0PR11MB5961:EE_
x-ms-office365-filtering-correlation-id: 1a7cd873-ee77-4be4-9b0a-08dec2288658
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|56012099006|4143699003|11063799006|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: fp1Hmpuz/dVYJNAAFU1w3z3Zt+YierBSm3SS62ZJ6bHmthzo9QPhRLNE0VFF2cgQHoKO5oAPog+M/X97E8/aIGeBob9wjZf3DmU4ZF1WHtDnjCBRCx5+yYWnLM/sLsB0dhuD+9iirI3RkQZxdatt27HUxZOFCnmODIQhZHs6WsN2TkL9ypmy0re+YBAh8wp16NvvhEROAL5Macm8ZfRBS+cKM/I4T8/UOw39i7ceMjNoZXh9ZNPAJx0roiphbPFVrEKAfX1JPnc7LGrqBokTo2S56vW6fhDWOUzyaFcMWBAkiMHu4Cxd/KfZBcnvE4sgYP3iWU7rqLKa/UQ+Ujm55la/wS7ux6IsqHN1ospkzzhdZQRWXo/vJojtyVJKrV503UosSFk+hUl0AlDpNhJg5a7+IJHSTJtYpEYriVWNwKiUVV6NDF72eAjZhYcq3//XCn3Q3DlfLayiTtUif4q+ZWW6BmKohHPCYmafeClQYttJpb7ewZnvBRc8cyeGLl+NuDS+8L4esjsDnwlS2etpdo88Cjkgq7BYWrYRsQLrv28PDsE9cwfrkG5U9/LPd/Ly9a47DPM2zos8thB68wnpAl0gtFuZAnveLWEBiGPavom2U9RNyMGYtLfpytARjpymY784yRGk0fHzTjFCyYac34eJyDXf8Ux3WeNA+y86OgzgkDQFhj7iReeWXdn9phtSLPIIP5HlUFQIO5AYRWHSnUi5WOjPVbClhm9qGwbQw4J/v2rDAq8un+pOcQ+7eTFK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUd2OFJrVnZyUDJpT2wwUGVsYlFzd1RWSkoybUV5NnozVlh6anVucGZYcnB3?=
 =?utf-8?B?bzZja2V2MUxjTjlqUVVieVdtYlg4OUpOWllIMXcyWEJRVC9SMU1DVjR1VnpN?=
 =?utf-8?B?STlNMXR4Zkk1WWlZT0FReHJFZkYxUlZkdlBMQU9kZno5cHB0ekpOYkRpdFBk?=
 =?utf-8?B?emlBRU1vdWJPaTVhWmF2ZTFNVVNMTzZwanF3MlA3cDViZVdOVzB1SUtmQkg2?=
 =?utf-8?B?VVhiMzlubDBKNUMrUEV3WUVOQ1VRSXg3cXMwRWJScVNqNThXL2FTdlFhWGQ3?=
 =?utf-8?B?R21ia2pOSFhKdHN2eTlHa0JqdGtWZFhQbEdvay80QmpVam13OWpDMDdOTTVt?=
 =?utf-8?B?eEdxZWxjL3gxQnNLcjBRZUlQNkhHajY3UTZyeFR3V09remJHTUUyWmQxZkd5?=
 =?utf-8?B?RERHUkF0U3RLcE5QSDVoLzJCOGozSmdUN2xOUWNPdW9WZW9jQUxFYjVmUW42?=
 =?utf-8?B?VjBmNnd3OTJONkxydkJlNXUvdStEY2VERXhjNThySXBReWZlZkZqM29sV2k3?=
 =?utf-8?B?NXdZV084KzJhMW1BVTRjY013OHArMllEVGgvREtTZzVVemdvd1pDOEZmZ0NT?=
 =?utf-8?B?SFZiWnZUdEkxc1NNN05vZ293ZU1INUpXdTRqbjg4Q1ZhUFZnWm9Tb0Qya01P?=
 =?utf-8?B?SXFaMGx4K1o3N09NMCtiQTIvNWJkaWxCcmpueW10Qy9uNnVHajcwVFlKUFBi?=
 =?utf-8?B?VUUzQ2J6ZEYrSk91YVpuYWIvSlJVR2pBamdQQkZMUFB0amMwc3dNR3N4UXJ0?=
 =?utf-8?B?M0RnSGlmK05TaUh5RGp3OTdkanNBVWQvS3IzS2JzaVdnd1MvcU04RXlXcVhC?=
 =?utf-8?B?dUNHSkhMWkZ2MngyZjJkUkFCYnBXdnhXVWdkZGdmK0tGMk5iYWJocnFvVEpo?=
 =?utf-8?B?bDl5VFdQSjJ4MjNQVnFmQ1AvN3gvN3JDWXVwSTc2aVk2T1p3czZWd2Nkc2Jh?=
 =?utf-8?B?VStvV1N6SHlldWlOK1V3Y1JTR2xkQjZrUnNUdTZ1RVhKc1Rla004Y1ZGakVI?=
 =?utf-8?B?d1VnWlVTb2pMVVRpNHFjemZESFRwMVlIZm1LUEpMU3JVUi8xdS8ra0R6VWhN?=
 =?utf-8?B?c1JYWFQ3MlVvakZ3RzZFNUR1cFJlNVhJSFF6TXVXV3RyVXF0ZDI3Z295MWpB?=
 =?utf-8?B?UmVNczB4alIzUlhOTUVnNW1scEcyY1hSVy9lVXFLK1lpZFp6R2xwK3VGdVZF?=
 =?utf-8?B?ZS9aWW0rdWVKcXFkUUpjbDEvaWZlUGk1bzNDcEQ0Z2U1ZVZjcDBGNEI4THlr?=
 =?utf-8?B?Y3R6cGNiTm55UStUNWxnckZ1bmVaNlFUUUdIRmdQUmIwQVAxeDlCbXlRVThM?=
 =?utf-8?B?b01OZERQN2lvMlRZbTF3Yk1FNUs5QysvdktOcENGbWlLVDZLNGkzMEVSQ0dV?=
 =?utf-8?B?eGQyVUN4cmhieGNEUVBjNWJtakR1UUlXRTV5azZ6clM4Z1hLMjd3YjA3UlI5?=
 =?utf-8?B?MDZYMGdrYUExanpiRmhxNWRlVTVQWEFDR2JIcUJGRmVMZlAxejNzVWprZDB3?=
 =?utf-8?B?c1AzbGs0b2FQajk3Mjk1OWRyL1E0U0tGQWdFeGlLMWpTMEtkOEhtZUlpY1I2?=
 =?utf-8?B?UG1EOFRBazJyM2tHeFdFZTcxanJ2OUVCSlRHU0R3MnF3TzZEU2Nwc1l2TGJU?=
 =?utf-8?B?OHlWcEE2bkV3VUs1ZXpNSDdMRlpZcUFXaFRWM3BxR0NNTG5zbXR1WGFIU0R1?=
 =?utf-8?B?SXZjMVVLb2toaVpHbnYxWldLcis4N09Za0h4TjM4cHc1R2gxems3NmhBRUlR?=
 =?utf-8?B?OWptbjVnZzQ5OEQ4ZFZFbytISEZMbnd2c0VPUDFjRjh5K2NLTC9IK3FnVEJ6?=
 =?utf-8?B?MTlPZW1GOHhzQ1RIYnBMT1EwSlgyTktwbXdJWFVRa08xdWZPSjFuOVQrcENx?=
 =?utf-8?B?NGNCcTJieko0VzRYWmlrN1FjUEJIcS9Hem5PYlZGbmlBMVowUzdWQmtMNkR2?=
 =?utf-8?B?cXk1NWdaakNJZFplSUc0Y3BXYWhIc1h4N3ZsWVhiYzdldDh0eG5tMVN0NzNP?=
 =?utf-8?B?M05jQmVaZ0xVOVNJajZLS0NLRkswN1AvWWhSazkvVFA0QkZOSVJaKy84RkpT?=
 =?utf-8?B?T25HVGJjNmNZTDd4TWpyaUI0eXo3eGo4RG1kdXNneC92NkZodXJqV1hiSENW?=
 =?utf-8?B?blNLaTF2UlRZVHo2RGc4NVpQRkdKNmJUTFl4VENSVSs5dmExUVNpelRjeUxF?=
 =?utf-8?B?SXREN1ZzaXlTeExzNVJKV0xBWEhYUTZWelFoZUVWZ1YwaVRJeUZ2MmNHd2Fz?=
 =?utf-8?B?cTNuenkxMnhsRjIvWXUwdUJ1NUtsczdkNkw5UDd1cFQ1TlBaSDZLbGs2b3ph?=
 =?utf-8?B?MXNZZnI3Q25ZQUdYem0vTmZsQUt6djBoam43TjZ2T2l6ZE15OG1hdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1964198AF7EB424687BFE869678A8B21@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PvGgrhtbJZMHP/9VyIYFVEs6QMMJnpcl2AYm6as/e0kYE1lB9EwcmDW5vyRouH2lIrvJHQkY5QJHPbvD47g7hVVvSWNqpUZe/0S6pAMV90CDbYvSxqxQohfuu0TGTDJacNyB7xGB+xufj8gdRHUcuXIJOQ/OFVJYFCHb33sgiLqwvGSriEw2Hg4aAFG6O1FgzR0N+bfUiYQg/aGpVuMEt+RDV5uD/DlDeQZrAkKxivrYU5y1dB2rtE0/DafMgiKVVW/ZtHYxDFuP7YQEe7gI1CtlxVG9qqpeBJ0eChh/vGtkLbvZtA3PboeS59iinpHifuf+CBKB6etObkYsJvjouw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7cd873-ee77-4be4-9b0a-08dec2288658
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 11:00:44.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2QYpK/LUBWN1dgE6x5+rgyKXYKlY1vObO/fsDg/I5jY2QsAiYNPo/iOhya9KeroH+ZkCuNZf1Fe3adTtHRJoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBEcm9wIGFuIG1vc3RseSB1bnVzZWQgaW5jbHVkZSBvZiB4ODYuaCBmcm9tIGh5cGVy
di5oLCBhbmQgaW5zdGVhZCBwdWxsIGluDQo+IHJlZ3MuaCwgd2hpY2ggaXMgbmVlZCBmb3IgYXQg
bGVhc3QgaXNfZ3Vlc3RfbW9kZSgpLiAgVGhpcyBlbGltaW5hdGVzIHRoZQ0KPiBsYXN0IGluY2x1
ZGUgb2YgeDg2LmggZnJvbSBhIGNvbW1vbiB4ODYgaGVhZGVyLCBpLmUuIHNvbGlkaWZpZXMgdGhh
dCB4ODYuaA0KPiBpcyB0aGUgdG9wIG9mIHRoZSBweXJhbWlkLg0KPiANCj4gQWRkIGEgbWlzc2lu
ZyB4ODYuaCBpbmNsdWRlIGluIGNwdWlkLmMgdG8gYXZvaWQgYnVpbGQgYnJlYWthZ2UuDQo+IA0K
PiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNl
YW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KDQpSZXZpZXdlZC1ieTogS2Fp
IEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC94ODYva3ZtL2Nw
dWlkLmMgIHwgMSArDQo+ICBhcmNoL3g4Ni9rdm0vaHlwZXJ2LmggfCAzICsrLQ0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rdm0vY3B1aWQuYyBiL2FyY2gveDg2L2t2bS9jcHVpZC5jDQo+IGluZGV4
IGZkM2IwMjU3NWNkMC4uZGI4YmU5MTczYmQwIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0v
Y3B1aWQuYw0KPiArKysgYi9hcmNoL3g4Ni9rdm0vY3B1aWQuYw0KPiBAQCAtMjgsNiArMjgsNyBA
QA0KPiAgI2luY2x1ZGUgInRyYWNlLmgiDQo+ICAjaW5jbHVkZSAicG11LmgiDQo+ICAjaW5jbHVk
ZSAieGVuLmgiDQo+ICsjaW5jbHVkZSAieDg2LmgiDQoNCkZXSVc6DQoNClRoaXMgbWFkZSBtZSB0
aGluayB3aGV0aGVyIHdlIHNob3VsZCBqdXN0IGFkZCAieDg2LmgiIGluY2x1c2lvbiBpbiBwYXRj
aA0KDQogIEtWTTogeDg2OiBTd2FwIHRoZSBpbmNsdWRlIG9yZGVyIGJldHdlZW4geDg2LmggYW5k
IG1tdS5oDQoNCi4uIGR1ZSB0byB0aGUgZmFjdCB0aGF0IGNwdWlkLmMgaW5jbHVkZXMgIm1tdS5o
IiBidXQgbm90ICJ4ODYuaCIgZGlyZWN0bHksIGFuZA0KdGhhdCBwYXRjaCByZW1vdmVkICJ4ODYu
aCIgaW5jbHVzaW9uIGluICJtbXUuaCIuDQoNCkJ1dCB0aGF0IHBhdGNoIGRvZXNuJ3QgYnJlYWsg
dGhlIGJ1aWxkIChJIGFsc28gdHJpZWQgYXQgbXkgc2lkZSksIGJlY2F1c2UNCmNwdWlkLmMgYWxz
byBpbmNsdWRlcyAibGFwaWMuaCIsIHdoaWNoIGluY2x1ZGVzICJoeXBlcnYuaCIsIHdoaWNoIGlu
Y2x1ZGVzDQoieDg2LmgiLiDCoA0KDQpTbyBjcHVpZC5jIGFjdHVhbGx5IGhhcyAieDg2LmgiIGlu
Y2x1ZGVkIGluZGlyZWN0bHksIHVudGlsIHRoaXMgcGF0Y2guDQoNCkZyb20gdGhpcyBwZXJzcGVj
dGl2ZSwgaXQgbWFrZXMgc2Vuc2UgdG8gbWFrZSBjcHVpZC5jIGV4cGxpY2l0bHkgaW5jbHVkZSAi
eDg2LmgiDQppbiB0aGlzIHBhdGNoLg0KDQpBIHNpZGUgdGhpbmc6DQoNCkkgYWxzbyBzcG90dGVk
IHRoYXQgY3B1aWQuYyB1c2VzICJkb3VibGUgcXVvdGUiIHdheSB0byBpbmNsdWRlIGxpbnV4L2xv
Y2tkZXAuaDoNCg0KI2luY2x1ZGUgImxpbnV4L2xvY2tkZXAuaCINCg0KQWZ0ZXIgY291cGxlIG9m
IG1pbnV0ZXMgdGhpbmtpbmcgd2h5LCBJIGNvbmNsdWRlZCB3ZSBzaG91bGQganVzdCB1c2UgDQoN
CiNpbmNsdWRlIDxsaW51eC9sb2NrZGVwLmg+DQoNCkZvciB0aGF0IEkgc2VudCBhIHBhdGNoIHRv
IGZpeCwgYXNzdW1pbmcgSSBhbSBub3QgbWlzc2luZyBhbnl0aGluZy4NCg==
