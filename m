Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECFD2770A;
	Thu,  2 Apr 2026 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088545; cv=fail; b=OKiuAOZ/F4U2fcQKszgQCuMbNMAt7oFXyFL6HkWrTJR8FLnfCGGLalt434QujWFgMZXfL+xkOTcMSw7TLoJ3oo5V/WMUBDB7recykoGj8oSf8ciU4c7yEK3t2SFHmvUTdM2ftqCVK52onyilVI++5f2ZBNa2tc+9UphHgX0Mr94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088545; c=relaxed/simple;
	bh=lY5NRYQVkmAaWWt2eAtbUOeYmqJqqAU9tAaEfZqMAjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vA2GREc0xXMNTNI3wBe3VxUL9sXU6YHQ993Ficmnp1npI/WaOD8FeVKEoYhFdm1kRk2HgWgBGKLo+PEiTFH/p9iaNFUKoEMxnQ8i6UY6a5KpljUa46WKmLH5DGJZEIPz2d9JCzFKmx9poiPcsZsiEFSU6ei9f21o5BAbwz6d1Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXyOH/V7; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXyOH/V7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775088544; x=1806624544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lY5NRYQVkmAaWWt2eAtbUOeYmqJqqAU9tAaEfZqMAjs=;
  b=IXyOH/V7/RJyqgiqQCo5d7J5/yNJ3jNrDPXBFBLlwK7G/V7kOovRfGxn
   u6jfMuYtW8gcL9UBnOMGYmeLXJUS19Ps0BV+3C9fnFNEUns/tcfNXgPHp
   Ngqib0yCxx0Cm5hdXf5rBhQTvRiUFl/VQzL5IU0VfGYnW8o2UcJLgzNrc
   aDajErtuK3fd9RSrS5mCkM5fmlJHrP2Y3ytAwyWxlQVzo8FXffcO3G8iR
   ZMJV43Th9hs+KeVqjGiggAfvFSZ5gz1rYh/YFUGr0/H+AiD8LkIcPspX6
   rBZBGUzul+pYXwMkRjd592UVQOfntR67B+XSFk21Nc5SXIyOofU2EK/ng
   w==;
X-CSE-ConnectionGUID: D4Pf+x24TQaEdcsM5b1Exg==
X-CSE-MsgGUID: AUHav/WzT+SfdlqdZkZmeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="79750854"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79750854"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 17:09:03 -0700
X-CSE-ConnectionGUID: ++VXmuOvTJmFli0SK2cuOQ==
X-CSE-MsgGUID: xBKdKFtxSQijNIkr95H3oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="220171796"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 17:09:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 17:09:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 17:09:03 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 17:09:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdA6fA3av4vF4W78ITXMfozi7vWF7ik7hc2zOFuCJ1FM834i2bLuS0AXzTvofjxeGyItR5B16psWCyYBtGLXTl3YF/FmaBe+f1LiPkVQP9Rm2gfDcwh0AcKv6fMPmgkEONhk9ofQWD9GsilzjA7H7+Owhsj+KJtYRYfyXncORc10WjNJ/DZYbWfGJMw/8e+KHHPopom4TbyfpiU/Z+brchRZbE8FpK0ACNJZem568xxQOSh/W2ksxLr3RqRBGlED1bWnVCWK5zwnX8mM76+2YMkmiGe0GVFvo1z+XOtvRdmiFhtyfcV4IiBjhiW28U+/PX/gHR/kpT1Fe3TcMqsYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY5NRYQVkmAaWWt2eAtbUOeYmqJqqAU9tAaEfZqMAjs=;
 b=g0z3yCA36ez6Ky9L+WLD8eYzxygYdskwaAs3ix8uAeX/qKAs8Fa2V5Uwr80rhHEV7J1+27uxBmj9HZk2qM8tWKZJPdybdG87RQxxQQ8lw3OvTjTSRwYpgb2tQCYhCex6XZUVLI4QsrUCWd3sq4GSsavJLSKCys4o//I/l9Fkj3kg/FDYDZ19LgeQeX6tXjAzpvKmSRO2+ZyWkuPGPT+0l4VIZYbgs7WVtWCmyQrELNpK+86QWbu0EAuelmq2aIeTa4QmOwTrFQwt79Nmgfw9Cu7HhamZ4fjOzV9oovTxTya2kKA5tqGhQnSh+dxyHQJd74Q0o6IS/ms5Yar8JM0Isg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ5PPF7DCFBC32A.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::839) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 00:08:55 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Thu, 2 Apr 2026
 00:08:54 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/17] KVM: x86/mmu: Remove KVM_BUG_ON() that checks lock
 when removing PTs
Thread-Topic: [PATCH 14/17] KVM: x86/mmu: Remove KVM_BUG_ON() that checks lock
 when removing PTs
Thread-Index: AQHcviZX1cU7kHanMECcSZWk/PS9dbXGqbWAgAHRSQCAAnJ8gA==
Date: Thu, 2 Apr 2026 00:08:54 +0000
Message-ID: <82f842d780f9394cd670d10a15a25973cae3d3d4.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-15-rick.p.edgecombe@intel.com>
	 <acofvYU6zlzeF6wf@yzhao56-desk.sh.intel.com>
	 <7c580a45c27440852ddb16465bf8a9acf41381fc.camel@intel.com>
In-Reply-To: <7c580a45c27440852ddb16465bf8a9acf41381fc.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ5PPF7DCFBC32A:EE_
x-ms-office365-filtering-correlation-id: 253a7c09-815b-4c70-a5bf-08de904c0751
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: dhuaBh7S81CoaezrBcmV1/FGRLPGF27EPs93yeYALmnH4vzU3UWzru4GPb31zqvV/xtd9DaE+SlV71RwrSziZOwWn4PvUECWGGejznuKXHX/KTKP/0ayKWkv1gcwm5Q1/6QYnLPnaKidxCqeF+ljmVLK06QpVWcvU6fLkSylwikqn5UpgoPdgNoMkTy6aAigIpzMxJYQiPNpkfKozAgS4GMVNA2AJ3D1CJmSx+u7aOCYomYl/7byf66geU38sTRnVMLZTUty3Gb1hOWxtCWU6L4MMI5kspMf7m02BTol2WqbWqbU8lPRE0Z9+aTnw4rN43PMhjgZf5ruQpE4EzeqHVSUUERlTlXtlcUPegML93bZazvpeVsRPpOue7kJq5GpdeKpA575N+alFufD4Lu2TOWgknTcheOR5mJ5QrGb9TOcljsPMWltmzt2lYFuHQizZDWwDZaINTw4SJuj9p9dSlQD1CzUUvbc4dRxTNBsL2M2oAu8YmOjen6nMoU+AzyG0pHay3t8pFvntvjX3iuvupDwqKGxmL51kKYdw41W3N32vOBT21KaSsC54wOX7mdHamW0ma0EAmfDXUGMqXBhIYXHlvh/tSe3tK+6ZmHedu6vW4Ig63dcnfC9QN3N1IDSCYuC+IfsMJqPzvVWJ2eQQlEz3Lwp88C/xTpJIBK6zdTfc26IDoZh/Rp3Gv1psMAJ2nNRSt+5jTJfKeFefTaYmjjM7zu4UDvCLjkX0CtG8MHgG1MXKuZ++WICtlhO4Ib0EHrNO6vzbcer5S33f+RS7yKK+DA9jlAQOvCfj7nTJTc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkJHUGFXL0lOaHFFZHhtZ09jSUdPay82amhwbmNCeGJ4Sk9tNXZMU1R5eFBu?=
 =?utf-8?B?cjJPd0psT0ErYisybzVvUnpmUnlEcWxJTXVKSVptK2t0VFI2VzhqUWV0dE1z?=
 =?utf-8?B?SVdUMDZLZVBpTU4xalBqREFJanpmRlJXYmZ0b3V4VlcrSUNhV0Y4bUx4aWMx?=
 =?utf-8?B?YnJxRkVBbkRTa25nckdIdThYZmZVdTZYZ2Rxd1BKRmtFOFBtaGYwek1IZjhU?=
 =?utf-8?B?Z09wQytJbmVzcExHa21xb0VDL1ZLd2g2ME5mS3htNFlDOE5WYVZ2R2R2Unl6?=
 =?utf-8?B?eVZIbFYvNCtscDNKVXhXZlZrM2JsTDhKVzFWOGtKTU9wSGtaUFEzN3NoSGpi?=
 =?utf-8?B?UjdGU3VrclRqbUNEbGlQdWtBQWl2TEhCcm5JbW9mckM2U2NRMERac21ad1Vj?=
 =?utf-8?B?WWRrQ3B6TkNoeVB1NkdFajMzY3hvYzlJR3gybjJRU1ljMFpDRnNkNHBSUDls?=
 =?utf-8?B?eDFraU85RGdNQU80K1hac29iQllkQkJFdE84WkpHNHd2OEt6NFdSU0lEQ0wy?=
 =?utf-8?B?dkh1bUhpVUI2N3pJNTRxSHZjY0h6TXNtOHp6NzlPK2hueCtKdG1Va3ZkOW16?=
 =?utf-8?B?d3RHMFkvanZsRDVQNmhGSlZWTnVETEpob1UvV1dna2tIQzBMVE9kV2lvNXpK?=
 =?utf-8?B?OFBzUDVqTVgrcEZjWlBNWXdaWmpzb0p4LzhaRFdpV0U1eHdDdVR6YzRSVjNV?=
 =?utf-8?B?Z1EwVVNrWllQSDk1V1RmeUpVdUFBRXkxT1pOTHR0NGtLNTE4Q3JqZkVBTHdy?=
 =?utf-8?B?VTQzNlliR3crdndpMnhCT3Fhb1pKVHRIV2crbmxSNUxUeFAvWWdodHlUTVdH?=
 =?utf-8?B?OU4wcldSN0xpMU9MVEJrVDE1ZVRTRDdyYndGeUNtYnFjRkdXNnc5UFNlSnNG?=
 =?utf-8?B?ODlTbmR5dVJ2ZTc3bHpFK2lpNXJuMHpGUjRyekR1K0psQkJOakpUYytHa0oz?=
 =?utf-8?B?WUNvdm00bGk1a09EY0QvU1RJclk4eEQvRTR0eXlyRkFFbkd3dDk4TEdRNmJw?=
 =?utf-8?B?QURIOWlncFJDZ3piMlA5K0pibUtxb1VRUTBwbkhLZHpRYjVTaGE0K1puQmZh?=
 =?utf-8?B?M0JVRHgxTWU5NjFSd2hEWjlrRDZPRTJreStXQ3gzRGdoeTZjRm85ZVc1U1Vn?=
 =?utf-8?B?WFR2eW5zelZVK29GZExESjdxbGk4SkJpV2ZtRUM5SzJXNU1VbVl2dmdEdVBt?=
 =?utf-8?B?Q2w0SzZSQUNUOXhieWcraDRzMHFIN3hZdCsvNmJWVXpwZERqdXYyblJqaUpP?=
 =?utf-8?B?ei92WkVOeEc0Y3JCOHNQMUUxM054cm4vdm9vV1lYWUduaGc5UjV3clVMQmE1?=
 =?utf-8?B?bWFId0NCOFVqSGoyVEUvbkFBU3dpRHRhWXZsZndXT0pNOWQrK0ZBM0Q1TTdC?=
 =?utf-8?B?MEVxWHpXSE44NlJOaEJ3cUZTOGZlVVVFNWR2QTkraEU4d1RYNUFGVk5aQ01C?=
 =?utf-8?B?bGhGL2RlWG1LUDd5VXhhQ2M2dGRsUldMYzNmS2JYcXVjcjZtVldLWmxzMFpD?=
 =?utf-8?B?bms5ejhJcFNPVjJzZjVCRVhyTU1xTUZWYW5GczNGUnBCaW9vZTRQQjBTcDlt?=
 =?utf-8?B?dHprbm9vSVJDYmQzT1ZrNDJENitsbEJJSzdESFRJWE1vcXRTTkNkUi9pTlpt?=
 =?utf-8?B?V252VmJteEdGSG4zeXUrSVdqUGdiOEhjU3JXTGNwd3l4THRhcnVhdE9zZmdU?=
 =?utf-8?B?OW1EcEpXbUxFUEM2ekdDSnJheUQzNlk0UkFBNytPdTI5Tm9pejZ1UjZod3Yw?=
 =?utf-8?B?dnB4SEJhSEROWDFJWE5nR3k1TzlxbkI4d1RleHM2V3FWcVpnUjVKMXlCeVlW?=
 =?utf-8?B?dCtNbytWZlNjWE9aTlU1c3NmU25KKzZyNnJTTytLaC8yWDU5eU1wNE90ZWJr?=
 =?utf-8?B?VHVod1RYMWRNZ1RBZGIyUEZMUk03YVoyQ0s2REh4S2hwWjE5UjJMUEpZRnVN?=
 =?utf-8?B?UmJuSzhGR1FZbU5TZ1JnanhabGxwWk1XZjI0b0hEZ0JFcU1sMVJEVnh1Qm9v?=
 =?utf-8?B?YjZZVHZiVVlYVGpFbVh6SFRtRTZqdDA5NXZpOHZzRWFJNWNVVzdabHRIZkNj?=
 =?utf-8?B?b1JCeWdxRjcrclByckhJNTZOWWtjeXc3aDl2ZWM5MlFIaDlIRlI4Qy9MY0hY?=
 =?utf-8?B?K0dKdlh4TDNHNGhlUU9jM2I5djA5Ny9SZEkzYmlTQ094aWFQdmE4NkZmTnhR?=
 =?utf-8?B?WUlmbElXNmg0S3BWR21jTDU3VFRkNXFFUmdsdUtRbmkyUXp3VDNKeHJoU3p4?=
 =?utf-8?B?R0l2VWZ5MXN1ZGtaY1pnR2svekxVNUZEK0xlMlg2UGxsTDZ5bGQrNzNHM2Zr?=
 =?utf-8?B?b3JmOWNuVitwdHBIOFZTaDZMZ21ta0gzUENiaEprZXdxeDRZVlF3NEM1Z1Rn?=
 =?utf-8?Q?++fsfT/OLHC6YPeI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01747564DF9E2044AA2B79837E0737DC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sbHgufoSMvfxhYvOE7HneT0SsztZpBT66+q4Qqgm2MgA8LpajI0rYOyAxQu9BFlOaBa5aEkSM1gRbBD9+jHirVw80wBICtk7Y0ZNLYX/xd73XJNjZ80LQv1ajEgbhQmSXYINByl99nK/0tcJ+ADDwYTxlpNfpeomU6zC9XiUKhoZl6CvNQnaKqDhMflvHLk64VQxkvRiByonFBjIT8Vyy6gW3nCeOL5MKTiCZAaPtziK+0zIKVIes5NQg5h2m2zUZv+GQ7nzoOOX+irhswfjhzpu6lORNehPI+RE4UNi8IXotdtX2pHqKitFiKydF4X8sEVQFSPC6SUWx6oMWDtj7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253a7c09-815b-4c70-a5bf-08de904c0751
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 00:08:54.7481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A29XjDiA7tJ/pnr+su1LErVRxsaCh/TT13rdPm+G+MCSm0V7+Pv9C5ngZnuqR+mr3UzUWuTfUIz8xNneUtb5RhUwM0ZuMDuoZyxt/k40diI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7DCFBC32A
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDEwOjQ2ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
IA0KPiA+ID4gS1ZNX0JVR19PTigpIHRvIHVzZSBpbiB0aGUgbG9naWNzIGZ1dHVyZSBob21lLg0K
PiA+IEJ5ICJpbiB0aGUgbG9naWNzIGZ1dHVyZSBob21lIiwgZG8geW91IG1lYW4gIndoZW4gdGhp
cyBsb2dpYyBpcyBtb3ZlZCB0byBpdHMNCj4gPiBmdXR1cmUgbG9jYXRpb24iPw0KPiA+IA0KPiAN
Cj4gTWF5YmUgaXQganVzdCBtZWFudCB0byBiZToNCj4gDQo+IMKgIHRoZSBsb2dpYydzIGZ1dHVy
ZSBob21lDQoNClllYSB0aGF0IGlzIHdoYXQgSSBtZWFudC4gSSdsbCB1cGRhdGUgaXQuIFVubGVz
cyBZYW4gZG8geW91IGZpbmQgdGhlICJmdXR1cmUNCmhvbWUiIHBocmFzaW5nIGNvbmZ1c2luZz8N
Cg==
