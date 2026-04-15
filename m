Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637662459E1;
	Wed, 15 Apr 2026 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776214339; cv=fail; b=EEOSAr1ZIF1D0yoEWEOGbObAhHy3Ru3PNsZyFWrvNVxCv19kWQBv1SY2ImAGyAEerCQ1kyGADUNroKXPUyB+ajdUyJsD/04WynVhh42djzGmi4YspN0Rc6/8g8UyTjXQgSZE9+tM5CgNkVgNA4lhej8GCpwozuoOjhzl4NUv4sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776214339; c=relaxed/simple;
	bh=r3BvzdgoieXr9jfQXqQHhckhqVZlpgSTaq4d/Myno0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=teWm1RDPJcu7vMkoYqCgFrviKcBJlheiyccJVIqRRVWkJbhRnX27qHEF6i3Vo4fLMmgycjMU+htU29zoQbghVu9KfKb7OjOUZvKr9894+BegiivKUAC+R0ZxAjhoerUupASM9vCVolE2g0ZMOW3hD6wSfKqLWxf9s0PC3BfS1JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2OhsDUd; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2OhsDUd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776214338; x=1807750338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r3BvzdgoieXr9jfQXqQHhckhqVZlpgSTaq4d/Myno0A=;
  b=X2OhsDUdYZbl8jKgRSxCUyiDznuiNWW/1gRFvD/QW5pFf4emUz/o9ysS
   oH4EXZsuE/ZBLbnfIgMWmqZO0IKOJvYQ+p4zWtEex5iONbqwK92i33fKG
   hpeCufI//BTHA/TdCl4P0nFOYka/Q4tAErzkXPLUQ2JbBi/6Ynf50pPFA
   jXG8T3uw2Y/JBFi1P2+qKFJtpCz/s+vD6PQGs0SoE2I4ehwyQ0QcjSr/e
   EBRtPIuH5UQM9wP01XUIHvUGS7mNmKtJSl+JTO5kqWYvki5REvx72vUNN
   k241IqaejMjWr3RQxWEkeBmtZfbM8vhP2eTzUqCzSBaH0bJoBHTz8iOiO
   w==;
X-CSE-ConnectionGUID: 7ppluI5CS7Kui1v0CBBuLg==
X-CSE-MsgGUID: 04RrS4dkQj+hPk5D6uHs0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77208301"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77208301"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 17:52:18 -0700
X-CSE-ConnectionGUID: fFminUbNRfeaf/BGS1jh0A==
X-CSE-MsgGUID: gHclb5ELQ5KuCYdeZhRvOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225951406"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 17:52:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 17:52:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 17:52:16 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 17:52:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQFd7OjSmzaYsDOxUTkiHHVMhoBWXicH5nL2iK5vZXVbP9IhLSDpH+JqdyHWYxAsbqJAlRbOuuH2+65KJ4H0u9HwMVe7mEIAIbNAWEij1VVwcnykTNQTRKuIEBVQj+nsr94Hrr6sAZiA8sHiHzaAGF1D8XaFOZwRhCSV4eZEpEWUjlM/JejWUyXl5h5AVXwhX8n46WndlyVhrgqhHoC6ahnu4M3itZ7xCjwpYPfbx52Ge9hplcmFn7Y0385Q08LvHKUuu2wJMTkgo+VHgLDw06IV4EhWkb5Fw0FNszlSby3Axi29+6aR1P9fEQKNqDmDCxNneKbsVJG9JlsL2/zKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3BvzdgoieXr9jfQXqQHhckhqVZlpgSTaq4d/Myno0A=;
 b=ZVuASmoSl3AVmsyfAsCJzxM2JZNKMkk8FxT0y4Xp8Qgw0Ohv2LETM1Xt2uuy3zpd3dK2oUCcJeWKYbYBcocSwVKkh8befeytQmgNrD3/klDtizGfT/xVelRQGni2POaAGaG4naxySg7uVxxy84EtMyTTSUBu8N9wlDxZRwl30XnvCrjhCWtSHYbBzYZg0SK1Ikusuyiv8AWjnflJo95qYS7aL+x6GxR13A2PpJtWzq83tpDecjUtZ+oLjktE15kW4CWOFRNPYy5lR/G/lTGJhdpY83IlIgPkBAk2oVn9Z0v2axLBZ9RrNc25rsWF/lNsud3coI+g8DHpc6flNqUwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH0PR11MB5265.namprd11.prod.outlook.com (2603:10b6:610:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 00:52:12 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 00:52:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "djbw@kernel.org" <djbw@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "sagis@google.com"
	<sagis@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 17/22] x86/virt/tdx: Avoid updates during
 update-sensitive operations
Thread-Topic: [PATCH v7 17/22] x86/virt/tdx: Avoid updates during
 update-sensitive operations
Thread-Index: AQHcwQwKfzyh37Ly8UCrIvEL2Q9aZLXfECgAgAAdOICAAApIgIAAJhWAgAAEWoA=
Date: Wed, 15 Apr 2026 00:52:12 +0000
Message-ID: <c02f70504cfd674edd97d7fec717fc25263176f8.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-18-chao.gao@intel.com>
	 <af7732a08fcce4a21ff14b2038acbb85200c6f34.camel@intel.com>
	 <69deb5032ff01_147c801004c@djbw-dev.notmuch>
	 <c44a4aebca86584ec33a19fbd9ca464443e66718.camel@intel.com>
	 <69dedd953ddc8_147c80100d@djbw-dev.notmuch>
In-Reply-To: <69dedd953ddc8_147c80100d@djbw-dev.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH0PR11MB5265:EE_
x-ms-office365-filtering-correlation-id: 757f6135-fef5-4b70-74f4-08de9a893aee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 18hNnggESQ70jVwAL8tVlOBkRoWD1JzLQ7BnkTT+hd5wGPfZtWhZ5ukLFXgysqp/PwW+EB/aTxbkHSH59oaLdbkGhhGtd159l3Etfr/sU+RN5G0GJ1USAc+5B7mMa+CFJPUtW0maA4sQne1lzmqoWoyOTK9d268QRIyj7fzdC0JU2GvOws+Umf38ulKE0P9eFzF8Ixj+np9T77vLPwGHi9J76gzFIXgjmv2/3aJ0V62+8C1z962BgRTTeucQ3iUWI1ni5mJcjulz2tEAtv1uLFD3FodZFYmmmh5Nz1sUUPm1ifuBK6K77/NT81T3Tk5D3hUeWaAo7Zd1myyVGwt3JV+wpWiEyKXfz9hJzaP/WpMVoCzQGdIxUy0sQPHcVXjphWQfk+dmPGoe2PN/Pz30LHqBLYf/0rXp8fd9YsFp/wAsavscAYL6Ur90ipH711FHweif2eHKRXF80O/Dhsyb6enSRe20vlJAUTfPltGIpi2rVYrTdQ5Rxu74BmAHzacnDPM48L9PNlFVsEuW/NsjX9Jz5bn124Gz6OZx7A0t3zxeqysv+/W26xF9Hkj/KqzziVzUZvSWC2MLAq//L3Iun5dxRXrs/L5Z66NJ8v3HXbMVIYcK4vv08i3gGyQ47ui9fuokCNd4YCIWminpA59rOqvWhk0aCJNpp2NNzpjCJkcO45gbOI+nlHsVy7fSkg7ldZFUYN4k7xA+K7e1sBHo2FGmqgXhAOWPqjJzJmFfqRv9ny/DcSpLrJI9dCphoO9vmZeKNC3BZ3C9kS8yS2OgfV27+SE+TGZ7kTRM1iMeR/c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVJnbGNYZ29hWU9lbnRnQjZ4eHRSQVErUnlvZit0TUIrWFhMbmNvYTFuNlhs?=
 =?utf-8?B?NGtNQWt4ODVJVjFXL2p5YXRKZFRMcm5NekduUFhyNDBqYlE4ZTlwanF0Ympi?=
 =?utf-8?B?WFF6RFJFQnEraVZBOTBFaVhBemQzS2g1OCtDWk9iTkpxYTJxR2R6bGt4MHgw?=
 =?utf-8?B?b1AzM2hKYklKTmNkSm5uMnBxeGREb1NVbGEzczYxOWRLYXBsT3IyQkhnWXU5?=
 =?utf-8?B?VnorYXpjSi92Uy9SMmxxT3hrN2FrUE9LaldObVZyem5LY3VxeEtVL1J3bXln?=
 =?utf-8?B?T3gvWjQvWnB1TnN1eFNSeUtVZis3dmx3MmtwL0JjR2RITEtMVTBUTHMwMHlH?=
 =?utf-8?B?S2M3NXpxTWQ4UzFHZVc2Z1dnb0ZXUWNVMTJQamJReWFuU1ZPaGFsRWRyblhx?=
 =?utf-8?B?MFYzZktNZGxwa0Mvazd5cFptRTJMMmhDZUFuOUg0SmxDcmdtNERLVjlaSU8v?=
 =?utf-8?B?OWhmejAzZ0p2OUdjV1ArUW9KM3VreERlS3dRRjA2UXpPVzZycnNjR2hCUlIx?=
 =?utf-8?B?ZS9hVHZNMFo5NUo4RnVPc1FrMit4RGZ6bXoxcWtPclBKUk1HWm1oK2xFVE05?=
 =?utf-8?B?WHNyb1g1RUFwMkVmbUMzQkVmc3BzczJyck1yVENGQ2ZMQ29vQTNxWjdNSzNO?=
 =?utf-8?B?VjFNVXh5SmNkV0RndDZzU1dJTzdhZjYzaml1WG1McE8yRWxiSGdkQnJ5blQ2?=
 =?utf-8?B?Ny9ZUVZJWGpkTlFUcjk3YU1PRTA3UGFoa3ZHM09DOHZNSDFxdVZCZG9CblNt?=
 =?utf-8?B?NUd1Sit0U0hHRG5NL0x4dFFaNHFJdlNEYzZGcEtjTlZJUWVvMmIvaU9XZzRu?=
 =?utf-8?B?SXh5ejNCUmsyakIvVWtuNVZ5TkkyZXE5bDFPNkNCcTdkMHpLZysrMXlwdC9m?=
 =?utf-8?B?R09LQ0Z1djl3NEYvb285L2t3ZmI2NjNpc0s3Q2dOSGttWitzNW4wc2xEMmhV?=
 =?utf-8?B?eUlzcWpTL0tYNUhmbzJLWHpLMXdobi9wUDc1SGpWRjdwOEYvY09tY21lK0tK?=
 =?utf-8?B?c1R2MVB0Nm50NmRmd0VzVlY0K3JzQWkvWVpPeE1MR2FuNW5xRTg4ZEFwZk1y?=
 =?utf-8?B?RzRiTDd2SUdHTndsS2hwV2hzczRhU1JRZ08wemxPWCtHUmE3dXV3cUVqa3Jh?=
 =?utf-8?B?WHRSdjJCWjBXSjZwTm9vMUFoTDVnb0t5eVc5N2NjdUQ3c3hSWFkwYWNRUStQ?=
 =?utf-8?B?UmR0elh6R01HaWgya3I4cjV3ZWpmV3RETWdaV1NMamRNMjlwMFByQ3RpZU9p?=
 =?utf-8?B?Y3ZoNUg4ZURtaVRZMTJhY0JYSy9CUTByaXJIQ2oyQVZVREpMSkZhaFRLa0Ux?=
 =?utf-8?B?d3NVaFZZczdiRmNrVWlleTZmSGUrRWExK2llQnpJU0VGbXpXakh6cG5LL3VY?=
 =?utf-8?B?eG0rWk5jV2wxTlU4WTJCcEhiajdYYjNYWThpYnpoSEU1NnFRQ3FUZVN0TlMv?=
 =?utf-8?B?KzZaUlJhY1dwM0lSZkk2STlmUDNjZ3hBbmZRZUVxV0ZaTmJZZlI5UlIvUEta?=
 =?utf-8?B?ZmVTRkcydjFFQ1Y2TEU2U2pHakNLT1FtdEl5UXMra1hVdDRCcVdTd3A5SHBT?=
 =?utf-8?B?OTcybVJQTE9JMWJmM0pYYVVRUTBoQU9McUc2MTdwcWZ1MDNyODRpNHVMMEoy?=
 =?utf-8?B?RWlCTGxrVkJTWXRvREJQM3dWMi9ST0VCdE41STRDWHFkVzNYV2tJZ2dyQktm?=
 =?utf-8?B?eDNtbnI5czgwdXhEN1NzQ0s1ek9NdVdvMjl1S3U3a3ppcTFQcWwwUTc0UGZY?=
 =?utf-8?B?TlpjRnRJYVlialdmdEo2VE1yTk5LTDlFZHdpN0NGWDh6YnpqeEdTTHcxT0tQ?=
 =?utf-8?B?LzJyQjNlbXRGZnc2aThCd1dBL0YwK2Q0bGFuRzd0MGNWb000Zzc3UUFPSW5S?=
 =?utf-8?B?K2pjMkNWeXZUUXJPMGVZWUtkWTBaRCs2WEVrVGp0bUhQVk5FTDNWQ05KT3Zh?=
 =?utf-8?B?cjFXbGVualpQaG9hcnFVQmVEQTJJSWg2RmRXY3MyTFZHZnFRTHRWQ3J3OHB3?=
 =?utf-8?B?MnlaR3pLd28yL1ZYYnFBaTRGU3ZKVitSRUhHMERmcTJoVlFJaGR0N3RyRndV?=
 =?utf-8?B?U2NreXVJeklCOGN0MTZEd2FBblRhREdGY1IrVW42ZHc4RkJrV0hwVFg4WVB3?=
 =?utf-8?B?RU5qOTNoTURHKzYvYUVWMzZaWGNCQUExckZEM0N0Z0IzUlR2WGtvblZ3Mmo5?=
 =?utf-8?B?UFFXV2VyQ1dSa29jSndFZVgvM25QOTNTeEJGa0N0ZWZQelZDNW92NjI5dlYx?=
 =?utf-8?B?YjlZSmtJeFJHM0tkeXduYWFxdkVndEJiUDhXbGlVTTNyTTBWM3dIRi93emlR?=
 =?utf-8?B?Q0ZyTkkyZElrS0ExTlJsbis2dTJLaS9kdmpkNEtNU1U3RXdqdWFZTUlmVFB2?=
 =?utf-8?Q?amJd1Wu82M49uM5s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <294E6A5E71ACEC4D980806D132E82AF9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Sw4YC9d3dtcIwH0ENQJDH9k5TSkk2l6xIivVmK+Bv/zfU1p3UEoUD5FNfrWU/h9zy/kwngdSXGy4aSC8yjE0EwcLRXSHKC/fvpVPbEUfp4QKxXKYCBwPyQaqwIET+HqWBCpPombAh6iwzl4gEdbvJQ76pTOiSKelIKVs5k1COt6R6/Qiuw/zymtXJtXYAP1rJQrzgrVujlSXj5QnxdnUamZy37V5xh2vkC4yx+IqbjLrGdAiuiOi+ASfJ4UAA/yZ9KBdl90+DZlpINXfGRu3ySfydhYTHRTBAUkxXuZZCgx0r87XRB9bc9vRS8j59zkim/H6g7sHEuVOS/XILX+vsQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757f6135-fef5-4b70-74f4-08de9a893aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 00:52:12.3068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwYXkpDukOzzQhYP8sGdpXugeuLi20Dm96un+4bTK3bwrQAx4c5YqdjH3TtE+9WdTApJZ9MyZPKuS/B1Fi0e5SuGp+QZOKYaSns6LUQ4/3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5265
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTE0IGF0IDE3OjM2IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFllcy4gSnVzdCBwYXNzIHRoYXQgZmxhZyB1bmNvbmRpdGlvbmFsbHkgYW5kIHRyZWF0ICJvcGVy
YW5kIGludmFsaWQiIGFzDQo+IGFub3RoZXIgImNhbiBub3QgZG8gYSBjb21wYXRpYmxlIHVwZGF0
ZSIgY2FzZS4NCg0KR3JlYXQsIHRoYW5rcyBEYW4uDQo=
