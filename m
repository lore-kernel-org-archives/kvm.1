Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5C46F49F;
	Wed, 29 Jul 2026 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323568; cv=fail; b=T3uABsb3SDQY840o+ovi8f+NmtafVtyE7h/JY/4WSE6vmGdj1qvEfqyWoQ1ptHqW5xF1j5WUKi+fNKitpSwWT9OzKUVzD9ZhxEvpnljR2znNtXyalX75cy6W/N2crLg/sVoU+1IDlqYRMm7QW+vAEJHR20f7zbjF5BWhkmCwY00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323568; c=relaxed/simple;
	bh=f4n6J6J8oUOzlYBBxSnhhX/Wj9RJWVAgIBh2HjrYTLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lv+YeGQNIuWOH/v/Zo4GU3A/wr9BCfZICyrPVqDJ1PdNASdhPO0wbcDwyoD4rcWx11IVf+0kJM68bTmj0rgSR1zalv4100crwXsovW7+y4NV21rNlXZqFYPSpRX7HVptlgrkTh031WL0vhASk5FICKSipVNPTc9h7S2aOuGWdwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dl/41Ggn; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dl/41Ggn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785323564; x=1816859564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f4n6J6J8oUOzlYBBxSnhhX/Wj9RJWVAgIBh2HjrYTLY=;
  b=Dl/41GgnVbD1L4Jvj0jTwVjBxFodI6d5rR672x3pcnB17uK36arYRKFw
   0HIR7c4h/c+97sKY3V4nW9JYlzmu5YNkRZLnpdv6/vHljhp/lZgivjXgQ
   7geyozmeeK1+Kox3FZKUqFViE2Ov0lhHn8mzBqcDQ4LtGycbgck3on5ak
   rkMAXCd/syXWLiLF1NLaMILgCcXOZwN/cSYlqw/ueIU3u7MnEuBRoBmyY
   52a2tPWJ6gaadtY2R5kO4ZM+65TjhwSJjpHmJ+QMH/6u509fEFuKB5UYf
   6+DQOi02hce1GrT2n8x+yiQXWyFAhgkm/ChNUb2oU7HgyKPIVAvlREUFT
   Q==;
X-CSE-ConnectionGUID: hcukDzQGQ7q/+OKipPCkyg==
X-CSE-MsgGUID: uYKZEukJSXOKqwYnZpFoTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86003215"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="86003215"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 04:12:43 -0700
X-CSE-ConnectionGUID: OPq4h2c4SbCXrcC8aq0X7Q==
X-CSE-MsgGUID: 0Q78havGTWyEQNhXBe1TWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="261936393"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 04:12:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 04:12:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 04:12:43 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 04:12:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0otq9PUi/E7UvRKKl6Qa3QmZRndzTOtt64s8Zc21GOKabS+DQQYAoo9gMA7orU1qNNkY3t1DRyGm466FzJ1f18o4jY4ill8hIU2idYRbnu3BvxgftYfnCHuw6HdATw+W69MUc0mmIbrm6UFg3QJIonJcpV3SBTk1Rme1uYVXodbAJ7yeDmk6J82ODZDCVCRv80wXYqNnoCHvw1077eH2ZEyCP5eb7/UFm5f6EkfSMPoI7gXUwcj//QENbbronDawj56AYU14s+TxjSYLCi2TuLGzKFHf+3lvWNA6RDLdONapjDXZrwbRlRo68odCg8uvlS83Gnrr93/bZTFCZoyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4n6J6J8oUOzlYBBxSnhhX/Wj9RJWVAgIBh2HjrYTLY=;
 b=fXcf7eSHRaPglBNs/VxLEz7s7GuFQgBcOk+XYwBfh2L+YXmmQ9l7ObGIsF89mFDaq+bqAnNrYzrmrI4nOd9uvIHBslXCTLOXULnbC2UUY+ncfZRVS0BE1z41RsnnKDTdYAuUvYoiIFPQtRMP3jS8Ssx2V8hgz2tun4ng2oe78UWNJBGFMaC4tj51XNvzvBXItcgPK6lWmw81WD46tZLvkwJgVivKvH0nB74qDPHe+RmFF1dGoaRRNkklTF+G5VTzuTRJkDnbQZ8W/v8kLjLuZr4h7a/3L53Q0M9JyE31e/k0PCOSgXx3cZ1eBB2mdK2N7Ho3myRbXWBFyrVzzkjW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 PH7PR11MB7028.namprd11.prod.outlook.com (2603:10b6:510:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 11:12:37 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 11:12:37 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jthoughton@google.com"
	<jthoughton@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] KVM: x86/mmu: Use LOCK CMPXCHG to clear Accessed bits
Thread-Topic: [PATCH 0/2] KVM: x86/mmu: Use LOCK CMPXCHG to clear Accessed
 bits
Thread-Index: AQHdHieFISPnkkgj4kOehA8FTOxDRbaEWgAA
Date: Wed, 29 Jul 2026 11:12:37 +0000
Message-ID: <99aef43760db560d32e12e99df6bf209c67260e8.camel@intel.com>
References: <20260728002236.869865-1-seanjc@google.com>
In-Reply-To: <20260728002236.869865-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|PH7PR11MB7028:EE_
x-ms-office365-filtering-correlation-id: 12eedaa5-8099-45d5-1439-08deed624c32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|38070700021|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: zUKYSHDGXpJ2muMUWo6ujhzdT+fjXWQ4i5KO0zCE9lcHegfZchgfMXgdO6CSdhzs6uOFV062MOpkRLY9Q1oCdUa11WB4XFQHbmVL9K++xcE/yO4aI177VeHw8Rjf7nh4dvynaPW/1b2egKbCCA5Bo3938XYLPt91b1B/fKX7RanIQl5Z53fxcALeDsfmaJ5uacnY10atMjaEXJ2LMfpbXxRLCp99SDZgXkloB964oGDbKmBfN/hD1TwdpS84+9dNg7vLCaFZ3zggGDf/qt2dRLgxLlvPfNOSthi0f6rckGsYsAh1wzUeAqLo6Wk9+v6K85mylVPGzCgvCvvD5s4bh7sLDJs4GVSn9LlO3KKZE0ulYkddCNEbcI3Z7XiGEJeCwyJfhnBcD7nOajyPs7X9fS8tz4r6jm5Q2Jj765KPmdOsQLKCfLKbXSLC8W+kOdbKY81QtaGLvir+95WG4prNuJBb2DmjFBvY4UYz2cMz4kZO8Z7vCpIlwNOOh+3u4S+/fJQCxopwLtX6qWS4KSVUIZV6ZDZVrR46plNVqqIsoyRXxljgYjWP5SR9Uum+myDiTh7beXkvSrOxrYrJViAVMI09RZ5dTP+j1QTkrR6FXj8cLHCKDlOwnnFFQRuNNcBjSfFs83Mb+OENNjnOUaPgdkOFkp4z1jNIvdm9YJnll26bvTGD9E4CQDYOO7ocPOtRWJ7EgqSV6qOt1F4XJ/wlvGv6YofWxuOrqVyfoBogZH0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUlsejE1U0tJazBmTytkR01CQ0tTZVpBZW9GbkpqVkxPNmN0cDdTenBwS2tJ?=
 =?utf-8?B?YnZ5Q05xUHhmZUJ4RXM0aWZJM0NTOTkxb2dkaG5jYTY3b1JjRUJEUlV3TFVG?=
 =?utf-8?B?ZWpBTWxBZ2pWMVdOa1ZvaTEvTHI2UTYrWFE0bHFtN1Z0bTZLVzFrVlJoNEZu?=
 =?utf-8?B?Um9RMVF2d282R1RDQ0MwWkl4Wk9NRUJpeDBYdWgra09QVzY2YVRqQ3JIbWxU?=
 =?utf-8?B?QVdDNmlFLzE5Z05YSFJSWVVjVVV1b2xZdlVSbnFsN3ZLTEZWejV2S3pNcFFR?=
 =?utf-8?B?cG1yYnVTY3FFVHlxd0FiNkZFSmxEWFJuU3NramkrbjczdGVWM1FPcS9IckpJ?=
 =?utf-8?B?eTdKZ1VqWEJ5UEVYUjBrSUhkWkVCRnN0NGlyeUdWTElCeW5KUUdmaU1WNS9t?=
 =?utf-8?B?OFdsS21ESGhYbmFsZ2x2WEtjc3huV09TS2hIemV3bEIyejBXSHRrOXRFaHFj?=
 =?utf-8?B?MDM2dysrV1N2dnBNQzBKaGp3T0RDaHNwSDVBUUFoNHBKYzVMcXowRTNxTVNX?=
 =?utf-8?B?OVptTkhVMUhHVmYzRlhkaTJJZkI4YnMzV3p0NjYxMkx4eHNZL1pKaHZlQmtm?=
 =?utf-8?B?aC8rdXdwT214Zk5aYzdRUGIzNThEWnhMSnBNMWlNRGZIbjV3UVV5eWJWbmda?=
 =?utf-8?B?R0FTUThoRkFOSHBSc093bys2MTdPN1djZlBZQk1FN0FYd2xzRk9xeSs5bS90?=
 =?utf-8?B?blJlVFZrNnBlb1g1Ylo4NGNyYk9hY0ViTnN4TXdsMDdzZUozNzFKcVdIdkQ0?=
 =?utf-8?B?V3Q2TytLR2tiYjluWU5WYmUyN1hnaU52eTBFVkJndmNBcW9zWTZDQTZEcnpS?=
 =?utf-8?B?Q0VESXFENUlRcXRONmpxTjZHWUV3TDU2Z1lDZjU1MFVJWHMxeTQ1QndCUGpI?=
 =?utf-8?B?S3g1YnJZWVc2WjdTcytZaUprbVhXZ1lsN0t1ak8yL0VwUXc4WUFLWlFqOWNs?=
 =?utf-8?B?QzAwYjVibkMwNkl2dVQ5bGYreVpDTTdYajRVei9aNTN5L0FtTDJKZ3FvSkFv?=
 =?utf-8?B?VjlkVEJwNU45Mml6TUFMNHg4VmFIVzRJOG1QcEl0YlF6Y2szN29zMEZpN1lN?=
 =?utf-8?B?Mll1eXpEVnZDN2Zhc3c3czJsUGVMSGVDZWxjL3BWT21PdFFHelhMTDJmcXpx?=
 =?utf-8?B?UExlakFKSVJiUnlaa0Y0K2xCS3lwRlR5QXVIenc3YUhZSjNtNS9lSVNwVmM0?=
 =?utf-8?B?ZGt2VU1ZQTFhNm1kRXZ0a004Z3dLOExWb3hmTGUxcmhWallZTWVxbEhCTk0y?=
 =?utf-8?B?aGl3QkN3UlR2MHFVdmlPak5CYUdhQytlL09mTmxJK3B6clp3MFNBV011MkpD?=
 =?utf-8?B?VXNCRHMyYmNobytXY3VmWWx0d3E3Y3NvaXl1bHJtZ01wdXZDREdVMm1wekF0?=
 =?utf-8?B?OGhPOWtSUmpBejBxQXlWSzM0NVU5aVlMTCt6UFpmWC9nYmVyNitwWFdCU0Jr?=
 =?utf-8?B?NDBWcXY5YS9YVG82cS9PNk5uVkdNR2tXemtEYm9nc0puY2ZhMkJZcW42N3E0?=
 =?utf-8?B?Q2Vzd0JvbjcrUG81SE9ic3A0ZENyWHc2V1FQOGNEazNKZzRMYTlkRFdqVzJX?=
 =?utf-8?B?UzUwS1ZGMklYc1ZKemhkZCtFRjRHQmJnN3lLK3daQUxJQ3drcGxFa3FOcFFx?=
 =?utf-8?B?YXRlK2loRnEyODc5Y2VHQ0VEa3hqSDg2cEtlZCtmbW02STRmVkJPZ2djaC9k?=
 =?utf-8?B?MGs4SnRpcFF0TmNXNXRUanlEY2NUaU5TNEtGZnlNNTdkYWdUR1hKSjR3aHhI?=
 =?utf-8?B?QllXajN2c3hVZ0NSTzN6d0lMamcwWElCMmJEOFZDaGtHeXJUWW1yd2pRL0FF?=
 =?utf-8?B?Vmd2eW5qanA4aVQxeGROSUU1UjcwcTRPQVovMGcySkFZQzZ5SzFoL2ZDTTEv?=
 =?utf-8?B?TTVhUlpSNWFGTjV4TDZ0NmdyakVTZXFsTmphQll4VzErZktWZGVtT0tZRmp0?=
 =?utf-8?B?NTVpeUdZRVMvOW9JanYwRS9EVVdYa0ZzcDlZUFpScTg4eXh2MEtYVVFWOXBR?=
 =?utf-8?B?U3AxakxoaW0zM2U2K01sWFBHN0Yzb2NJTnF1d1lSY1B0bE4yTDA4SnVFT3Za?=
 =?utf-8?B?cmNZMU9vTzBJb0I2cEEybGJBSVJvWFBPODQ3QjdFc2U0bVdYb2NKSjdPVVpx?=
 =?utf-8?B?NlovQ2RVcHQyZk9nR2Z6RDNyVWs2MVEwT0ZBMU42MlcyenV4eE84empXTG9y?=
 =?utf-8?B?VE5DKzRZRWZqdUJJU2gyYTU0TjJwQ1ZaSjlCTHVKT0w5VXFnY3JwTm1SSGFs?=
 =?utf-8?B?Q1B1SXRSa3RxeHBjbGdnUksyc1NFTnkyTU5vTVlzWEp6UUMzVmFGWXJ6b01t?=
 =?utf-8?B?K1V0RGtQeDk4bUN1eS9kNW1NbWlBVU5XbXlKc3pDWVI2UXVEV2ptZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BA7BF10719BE74BAA51514A984059E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SAVQasLQAxy6i78tWpQ+nlvsgPDrwL3UB+6K1Xe/md/IXOXxlU9dXpk3F1ZE64GcrpeGY8kOJcJHCzV4UbVeWnTbhmpaJeii71K8rJalgLsM32uKXWagQCV3Xd7cdbSgj3RDRXoaNM4+Gj3rufjoNcklqu8zdjxDhiUn+Q2/Q6XehvDYh85PpNEoBBgeHPKBp2tE0zitITbFae7EZs0p1HBrP3aE/giTIwgR9iwKLTLsbI/cJWog61cs5l9WYTg4CKOxVh+r1q34ZRN77Rdb7g9Vmjm/9xE3SJgBOsOozPCOwT8Qa/lEKO77x6GMaZexCTdCySUcVNPvBCbGzDndxA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12eedaa5-8099-45d5-1439-08deed624c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 11:12:37.3686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okXeCL8JtWzUpwhdW0NtPWwE0aB5Pp4uknVUVZqaLUZkL85UHGYD/dzqNDL207RhqJuhTOp6yC40ckcUhcngKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7028
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTI3IGF0IDE3OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBJIGluaXRpYWxseSB3YXMgcGxhbm5pbmcgb24gdHdlYWtpbmcgdGhlIEZST1pFTl9T
UFRFIHZhbHVlIHRvIG1ha2UgaXQgb2sgdG8NCj4gdXNlIExPQ0sgQU5EIG9uIEFjY2Vzc2VkIGJp
dHMsIGJ1dCBBRkFJQ1QgdGhlcmUncyBubyBtZWFuaW5nZnVsIGRvd25zaWRlIHRvDQo+IHVzaW5n
IENNUFhDSEcuDQoNCk1heWJlIGRvIGJvdGgsIGUuZy4sIHN0aWxsIHJlbW92ZSB0aGUgQS1iaXQg
ZnJvbSBGUk9aRU5fU1BURT8gIEFGQUlDVCB0aGVyZSdzIG5vDQpnb29kIHJlYXNvbiB0byBrZWVw
IHRoZSBBLWJpdCBpbiBGUk9aRU5fU1BURS4NCg==
