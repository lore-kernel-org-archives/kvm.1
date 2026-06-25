Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76CF7260D;
	Thu, 25 Jun 2026 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372611; cv=fail; b=oI8gOnZVsebPLOimYz+T1yTD9I/ypGIpxjnUPx1dY7rGAYqbo5GIm9znDAH61I6tw/+su2GrY/rKq8DMyFYSezInUNF/IkNhbfmICOrtLPsi5NEk/RwNzz+OsBpvufj3tSQuq1aBzB/0l7a6+05BANkogKj+tIlkwfnreccx6hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372611; c=relaxed/simple;
	bh=meFypD2v90dSLXkZX4hX/2a2Q0i2LM2ojHRvuI87KTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DunMFkHy37aWTEyUiSOz5XNmvfSgT+5S4STa5bz2oKvoY7gz6RplJ8XASmgdSWu9oPkdNbyeuOd2LaO+AcGjlH1DBHExigaembU9VA9f4/JVwZCpyDW9utlDPxLX8CvqxatKlCXyQ5QFK0TwL2tCFzLYHH7dxhCTOwZdeMtkyq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOhfPbO5; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOhfPbO5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782372610; x=1813908610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=meFypD2v90dSLXkZX4hX/2a2Q0i2LM2ojHRvuI87KTU=;
  b=nOhfPbO5DlvoA1B+j9gmQ4kCXq8GuIW0i/1mbj2fX45kvNzFrufjEKRi
   hwLkYqPiyltvsO5Eh6bGL/fv8MzdOX2tdmZ/y9zm34siZJC/kwk0U+K56
   r2dWHIORUcGh/kVljDDLKEYI60BnlSwtFGkVk55SAnpx7tikrPpgMvDyJ
   KnOrLOVY3oeOqQ0wwuaEdBpz1Gew6wH2ceVeYnQ7bDc1UdM7GSw3cqnKI
   iRrBUycu7V57KA8sjg4X2SpDTJepuI795Kl5/WusDbHs93Vu4+vgIBGZh
   pKs5DnAWO3gwMkmR2YZFLTKSC0MR4pL0zzklxbHrMVeY4S9XDZcHIpxH8
   A==;
X-CSE-ConnectionGUID: IFeU/eB/QseLweEb6tLZzA==
X-CSE-MsgGUID: 3AU1JNWEQk6YFlBYx/hSCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="85701199"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="85701199"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 00:30:09 -0700
X-CSE-ConnectionGUID: L/npwGnPSmytx4suCfLMBQ==
X-CSE-MsgGUID: hLVkN/eZQ3y9rjwpxAMiQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="249426312"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 00:30:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 00:30:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 00:30:08 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 00:30:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daCJn57IFOY51VkPMwkOiuihC0IiyZNyfuqfxmbGsKXHnph216+qKraz8gvbmrg5K36yWNEah20bJRIQ+TdShKae2Wnjl7NfsVkxHIPHPKfkhd/QwDfiarVg0Phu+TlHUfL1qehXt1RBvrkWU9vK4GjO7DQdHhlrRfc9qkdiiU/X7av9n5v3jFQdJ50jwwjzWknFM+3pWSx9LC0l++R5N4A+Ta0A02laP0CZelmKFdhkWctGIjeq2gtwijtVOVtRZL+x2FYVAcDG10bx9J+ccLSyxwRGUageBy6Cq8TACehvPM4l/pZ9zKUSwdbZaBT71nY9N94bv1BOVZn8lmcWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meFypD2v90dSLXkZX4hX/2a2Q0i2LM2ojHRvuI87KTU=;
 b=DqYp+lRiISsFHY2CBVN0IAooeaRayAAbh7BsEIrM/mLjWGZ6WEQyypOrB8Lz7bw9OLtrbvB9k1lvmBII4rA5QcDuMJIc6k33a0MmaaLB6x+ME+8EnJ1+viOYw3OUZbS1I6+dLPSUpW+w4pIfi5dSX5Wp6WNlZrehLQtDn+wWmEOyokwQeSMw7DSZLzn7KK44ZG/YvbiQzAM5pHYPeGjSjjw+e5dgNlnYKubkMHfcZqv/4pyfxjGJMhxkya4jK6OIrzueLl52gf3Xf3y9TxvqDY8puT2CZgzXdlaREhPee28V7/9TL4DST1l1J/7JQFf3xGP2HVBlEn+j5FN5uHaVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH8PR11MB6949.namprd11.prod.outlook.com (2603:10b6:510:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 07:30:05 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 07:30:05 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
Thread-Topic: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
Thread-Index: AQHdBCWnns3dykXXyUWZiAS1Gt6Yz7ZO4JMA
Date: Thu, 25 Jun 2026 07:30:05 +0000
Message-ID: <c4ce0b3ebc40384afef7895909df3d00370b3e1d.camel@intel.com>
References: <20260624220516.3033391-1-seanjc@google.com>
In-Reply-To: <20260624220516.3033391-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH8PR11MB6949:EE_
x-ms-office365-filtering-correlation-id: ac6be4e2-2d25-4825-5dc1-08ded28b93bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|56012099006|11063799006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: ahP/0Hq/oxAPas4odJxrPEh7pCwRfNEe4aGYaPekpzOYYU8BdS1V3AKFpLXJhH4FO+PLDXFitb0I9MM/8aRUqjEoY82L8AH/H/5GIhOFxufcFqd+33HO+6WOt9YpXMnRUPA2BL23NyVeclID2zOyxacZjCfpKvy8BhuSPOmH8hs+UW1U7xUWUzyeIxL8Dvg5GEkXAHrPcB5wY376GAm70LPWkUmVD4QSMRlmh5FQh4ZLZvnei2r2DCRFV75Y/IR+Ys05VHsViLWgkcJuOeYP6poe99xW32TKMHvIcrOEDF3YhQ9SMZq9VJbFMYzxJvnxvafIremOQwWN74AHVEL/gVGIH1gKE3e+568agXuwt4XlOnUGRX2tMulAsVD86y7qyafxZxCbrFR5fVX0a3VKHqZTqnf1ZEPzRv1/ATCFmWIrlNAtGBXs1eGleYLoFH7JBCA+ZsxxFYs/eb+Zxu8SjXxxxzxPFFOHDk8YzK+GK+b48c0DWjudJm8DQOm76KqiCkDTmFtAJTmfz1zbvs/6dvVwqL4Gs6tnHD0hgicCazmR3ccNT/frMzU5IsrVwn/VlUQ93tuUGs2PBjNu0ublpyzIZr9ShFI1D6ouJ+VSw+YGJl+KdzGhyCXWovE8TP3MBB08H3wMIMaWUrLrM1c2NQKQqR9FDWxX3AOvIBmIrU8oSLmCYQeATHjdXpDHJXD23PIvmM1LlFBl5mqFJLp0iLrIXtrpzZISKwTFXr1pNdw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzZVZDVlczA5cXhJRkgvWE1vT1ZJWDJKakNQN2VFVzJqVERjTWJrRi9kRzNt?=
 =?utf-8?B?MStGbVg3aW5wUFBCQWdrblh3bkhZN00vYUNpVy93QlZFU1dRR01jOVhFVmFq?=
 =?utf-8?B?QkpvYjMxWG4xZnJtV3VhUVNIUlNTWDQvcVJySEZHRXNhVjJXV1M5Z24raFBP?=
 =?utf-8?B?UU5HemY1clFlQXRhdW1LODNCNXlMdjREU3pvMm1NU0o0UWRSWWhHc1RWc1ho?=
 =?utf-8?B?UFg3dzdkWERpa2VhV1RVS0drdk5Sb08vaEpMbW5rcjQzTFJERVM2a3Vjb0pZ?=
 =?utf-8?B?WmlpRmxacEx3NmMyK0dNdVFIOGFYR3ZQQ3FOZ1U2U2lPZmI3R1ZTb1dBTCtB?=
 =?utf-8?B?Tno5aUZuRUNWV2VpdXFkcjkxTkxDSUlaYWFrL1RLamZpWm5GYU54cy9Ld0hw?=
 =?utf-8?B?Tm1pelZZVnZmWDF3R2U3MjMzaFpKWjZUTG9FWXZNNHo4NElYZmswdUdhbTV0?=
 =?utf-8?B?Y2MzbmZseEZYVHluYXp5YlJ1MnJQSGhiVFZuRUNLTjJzcDkwV2thUW9sL1hh?=
 =?utf-8?B?emMrTW1GUmUyUWlrTFlVVXJKd2JseWNPWjR4L0QvdnVJREs4TUs1YzZPdCtF?=
 =?utf-8?B?NEJoQ0hmYm0vd2RDK2ZKZzd1WDFlWUNQZkVSS3lhNWgzUEljOVJSalFIdnJz?=
 =?utf-8?B?SllTVHZqZVlqaDdkVEFWempCSGVDZ05LWUtFU3ZiSGZCOXk5NDdPUkZjT2hV?=
 =?utf-8?B?Y3VEeEsydjFESVFza3h4MlUzUWd6RWM1OWdldjNQc01rcVRXT2lsYzNUYVBq?=
 =?utf-8?B?cm1zZmFWQ0JtL2JKSFNpeEhXSTROTXlsL1JlOFVLbGdkdnlVM08rNW9hVWhW?=
 =?utf-8?B?WGxyS1JUaUM2NTQvOUlvK3IxL1JXTVJpMzVVU2dDdDhPQko0aTNPVE1YSVF6?=
 =?utf-8?B?aGFneXBGeWtHRTd6RFN4ckgwcTZWY1JJNSs0MjcxeWZNeFd1V0d3aDhGdllo?=
 =?utf-8?B?L0FITmpadHZlaWlLKzh6RnFvOENtQWhmbGlxek1WclBmVmVXemZwcGI1QUVw?=
 =?utf-8?B?MUgrN0JobjhGRDRIcDNzMHk2SlhJOVVZNkkybmJkdkxxdGFzaFlBQUROL2RH?=
 =?utf-8?B?VFZQajFFamxrZE1RVklXdlBBWUM1eG9hWllUL1Y1cDBzc1Q2eUY4YVM2c01l?=
 =?utf-8?B?cy9qTzVzbkZUYTNXZDdOMmE0QjlkYzhOdU5tMEx0TGtiT0xmSDFiUFRZNy8w?=
 =?utf-8?B?cE05Umh2R2paMm9pb3VwVGI5eWFnS1BrZFdramJ3VDVpdU9PWDN3WXBBejA5?=
 =?utf-8?B?OS94YzdLZWRIYW55Y1NoWFBUbmszRm5TS0s0VXB3WHRPUG11RGx4djlIMnlh?=
 =?utf-8?B?MUFGR1hNYjhEQjJwTDN0Z0hkY3g3SWNhV0NRb2gySHJyM3ErMUJ1WitzK2Vm?=
 =?utf-8?B?SHpUTWlTZ1FwSTZkbWIrWFBMczBsTHJzUkY1NEt5MjROK25HaUE4NzJFZi91?=
 =?utf-8?B?aHVyemQ5T3B0T2FXWkkrZGovVFBlejNoTCtHL3haWVk2dDhQamhPdHJPaWxU?=
 =?utf-8?B?dE1uaXFYbzVhOG4vUWZEaFZhdnFmcDRXaXR3akhPNGtrTVAyT3VBUVdlamJR?=
 =?utf-8?B?QXp0R1graW9HbURWZWcrU0VNalp6b3NZNW50b0RPTlpaOHNSRkxZdW0wQnRM?=
 =?utf-8?B?UUx3K1ZublJkYVlkR1Q2VzQvZVl6dThMUWFZdERHcVQwbnpXRXI0Y054d3Vv?=
 =?utf-8?B?c2h0WEp1V3RlS0t6VWprWGJBUngwTnVLOU1yZUk4Y1hBN01QK0xOejZuUGpn?=
 =?utf-8?B?blpXZkR1V2RpMTVjQm4zTk8xK0hjUGMzb1Zxc1lyUjRBRWdTbTJnSDFOQ09j?=
 =?utf-8?B?TTU4b2hIRGsxeEF6dDlkRjJhdzZ6Qm9kc0lWZlZ4bU44eS9TTjF2VXlUVkNU?=
 =?utf-8?B?ZGJ4eEZtQmV6eGhiTzFBU2VROWJ2cDJGTWZGajV1VW0zUmRnWVJVRzA1ZXRs?=
 =?utf-8?B?VFFiRjAyaWd0L05xRkxWVEppN0oxV3VIckNndFJTRUJDQk8xaGJXNGlCUVZs?=
 =?utf-8?B?QkpHSjJQc0pZUFZUZHpuL2puMmJjL0RDZFlGWHprclhTbzdzNDJjUXVOcXF1?=
 =?utf-8?B?YnE3YS9RTm11WUNxemp5bmxhcFNzOTBBQkFnanozbGlvbEh2RnRBNE1ub09t?=
 =?utf-8?B?ZmdYVHNSQ2NuUWJIb2lneW16NkowUkFMajExTG8rS2VNbVIvWkIrbjd2enFR?=
 =?utf-8?B?V2lRRk9HeFhNOGd4QW9HSEdvdHMwQUN0LzB6R2U5eTRHbm43VnNCdDdyNHhJ?=
 =?utf-8?B?ZzhlekRuL1pVN1N3R3JkYWZsNXluT0ZjVmpBa2F3TFNMUUVwTXkrMzRZMkdG?=
 =?utf-8?B?S1czeEVld1NjaVdoRWY3VEVGcjIzMlJMMUMyNnBUc0ZKZnhXUVZzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D01F77D7BD877419FFBE2A9E09EEE66@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pOkh97hqHahzZ1cQaYRtbjmdLb4Ej+SKlPxOqC9qKO9DgdK/fbQJpdPY5DKAxC/XkBZZzubDyQltcLuvg+ILr8BfpQvCchRlMaLY3eblUzS+XnaD9cSltHRmu97J7GXL3wsTiCrGqV8cMDSvag8BkFxmN+pUsFqDPN2QRFJ9ijBMskRxmW93NmHFQhgQ+8jOUOpbmy4AQvAFQGv/JfI/vmze5y1Cz2LfDIFZ+LOSd6wjLdkFEEQ+Nd+CdYFDfVsAhRYbskPDQo0apM4Ae1+HD1B/UQVw9tK1rKbaDIjMLMbFcu4UJ0Yj4JI2LlxvnOgSrj9Ti0jCN0M6Hk326Hx9Mg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6be4e2-2d25-4825-5dc1-08ded28b93bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 07:30:05.3418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bj9l7AZchx/CEbbLzhMwUCB6q5UolF6tPO1De+GSMivt/ovqQ/0fEVoXXemkSh9ybPJ4vQSJ4uAwVx2xUmGMZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6949
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA2LTI0IGF0IDE1OjA1IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBJZ25vcmUgS1ZNJ3MgaW50ZXJuYWwgInNlcnZpY2UgcGVuZGluZyBQViBFT0kiIHJl
cXVlc3QgaWYgdGhlIHZDUFUgaGFzDQo+IGRpc2FibGVkIFBWIEVPSXMgc2luY2UgdGhlIHJlcXVl
c3Qgd2FzIG1hZGUuICBBc3NlcnRpbmcgdGhhdCBQViBFT0lzIGFyZQ0KPiBlbmFibGVkIGNhbiBm
YWlsIGlmIHJlYWRpbmcgZ3Vlc3QgbWVtb3J5IGluIHB2X2VvaV9nZXRfdXNlcigpIGZhaWxzLCBp
LmUuDQo+IGlmIHB2X2VvaV90ZXN0X2FuZF9jbHJfcGVuZGluZygpIGJhaWxzIGVhcmx5LCAqYW5k
KiB0aGUgdkNQVSBhbHNvIGRpc2FibGVzDQo+IFBWIEVPSXMuDQo+IA0KPiAgIGtlcm5lbCBCVUcg
YXQgYXJjaC94ODYva3ZtL2xhcGljLmM6MzMzOCENCj4gICBPb3BzOiBpbnZhbGlkIG9wY29kZTog
MDAwMCBbIzFdIFNNUA0KPiAgIENQVTogNCBVSUQ6IDEwMDAgUElEOiA4OTAgQ29tbTogcHZfZW9p
X3Rlc3QgTm90IHRhaW50ZWQgNy4wLjAtZDU4NWFhNTg5NGQ4LXZtICMzMzcgUFJFRU1QVA0KPiAg
IEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9T
IDAuMC4wIDAyLzA2LzIwMTUNCj4gICBSSVA6IDAwMTA6a3ZtX2xhcGljX3N5bmNfZnJvbV92YXBp
YysweDEyYi8weDE0MCBba3ZtXQ0KPiAgIENhbGwgVHJhY2U6DQo+ICAgIDxUQVNLPg0KPiAgICBr
dm1fYXJjaF92Y3B1X2lvY3RsX3J1bisweDEwNzUvMHgxYzMwIFtrdm1dDQo+ICAgIGt2bV92Y3B1
X2lvY3RsKzB4MmQ1LzB4OTgwIFtrdm1dDQo+ICAgIF9feDY0X3N5c19pb2N0bCsweDhhLzB4ZDAN
Cj4gICAgZG9fc3lzY2FsbF82NCsweGI1LzB4YjQwDQo+ICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0
ZXJfaHdmcmFtZSsweDRiLzB4NTMNCj4gICAgPC9UQVNLPg0KPiAgIE1vZHVsZXMgbGlua2VkIGlu
OiBrdm1faW50ZWwga3ZtIGlycWJ5cGFzcw0KPiAgIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAw
MDAwMDAgXS0tLQ0KPiANCj4gRml4ZXM6IGFlN2EyYTNmYjZmOCAoIktWTTogaG9zdCBzaWRlIGZv
ciBlb2kgb3B0aW1pemF0aW9uIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2ln
bmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IC0t
LQ0KPiAgYXJjaC94ODYva3ZtL2xhcGljLmMgfCA4ICsrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2t2bS9sYXBpYy5jIGIvYXJjaC94ODYva3ZtL2xhcGljLmMNCj4gaW5kZXggNmYzMGJi
ZGRkYjVhLi4zOGJiYTlhMTExNGMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2t2bS9sYXBpYy5j
DQo+ICsrKyBiL2FyY2gveDg2L2t2bS9sYXBpYy5jDQo+IEBAIC0zMzcxLDYgKzMzNzEsMTIgQEAg
c3RhdGljIHZvaWQgYXBpY19zeW5jX3B2X2VvaV9mcm9tX2d1ZXN0KHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwNCj4gIAkJCQkJc3RydWN0IGt2bV9sYXBpYyAqYXBpYykNCj4gIHsNCj4gIAlpbnQgdmVj
dG9yOw0KPiArDQo+ICsJaWYgKHVubGlrZWx5KCFwdl9lb2lfZW5hYmxlZCh2Y3B1KSkpIHsNCj4g
KwkJX19jbGVhcl9iaXQoS1ZNX0FQSUNfUFZfRU9JX1BFTkRJTkcsICZ2Y3B1LT5hcmNoLmFwaWNf
YXR0ZW50aW9uKTsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0KDQpEbyB5b3UgdGhpbmsgd2hl
dGhlciBpdCdzIGJldHRlciB0byBkbyB0aGlzIGluIGt2bV9sYXBpY19zZXRfcHZfZW9pKCksIGku
ZS4sDQp3aGVuIGd1ZXN0IGRpc2FibGVzIFBWX0VPSSBmb3IgdGhpcyB2Q1BVPyAgSWYgd2UgZG8g
c28sIGl0IHNlZW1zIHdlIGNhbiBzYXZlIHRoZQ0KdW5uZWNlc3NhcnkgcHZfZW9pX3NldF9wZW5k
aW5nKCkgKHdoaWNoIHdyaXRlcyBndWVzdCBtZW1vcnkpIGNhbGxlZCBmcm9tDQphcGljX3N5bmNf
cHZfZW9pX3RvX2d1ZXN0KCksIG9yIGl0J3Mgbm90IHBvc3NpYmxlIHRvIGhhcHBlbj8NCg0KPiAg
CS8qDQo+ICAJICogUFYgRU9JIHN0YXRlIGlzIGRlcml2ZWQgZnJvbSBLVk1fQVBJQ19QVl9FT0lf
UEVORElORyBpbiBob3N0DQo+ICAJICogYW5kIEtWTV9QVl9FT0lfRU5BQkxFRCBpbiBndWVzdCBt
ZW1vcnkgYXMgZm9sbG93czoNCj4gQEAgLTMzODIsOCArMzM4OCw2IEBAIHN0YXRpYyB2b2lkIGFw
aWNfc3luY19wdl9lb2lfZnJvbV9ndWVzdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsDQo+ICAJICog
S1ZNX0FQSUNfUFZfRU9JX1BFTkRJTkcgaXMgc2V0LCBLVk1fUFZfRU9JX0VOQUJMRUQgaXMgdW5z
ZXQ6DQo+ICAJICogCS0+IGhvc3QgZW5hYmxlZCBQViBFT0ksIGd1ZXN0IGV4ZWN1dGVkIEVPSS4N
Cj4gIAkgKi8NCj4gLQlCVUdfT04oIXB2X2VvaV9lbmFibGVkKHZjcHUpKTsNCj4gLQ0KPiAgCWlm
IChwdl9lb2lfdGVzdF9hbmRfY2xyX3BlbmRpbmcodmNwdSkpDQo+ICAJCXJldHVybjsNCj4gIAl2
ZWN0b3IgPSBhcGljX3NldF9lb2koYXBpYyk7DQo+IA0KPiBiYXNlLWNvbW1pdDogNTA0MDZkMzVm
NTYzNWUxY2M1MjNlNjE0MDlkNTdlODUxYjVmNWRmOA0KDQpBbnl3YXksIHRoZSBjb2RlIExHVE06
DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
