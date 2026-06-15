Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09F3F1ADE;
	Mon, 15 Jun 2026 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528506; cv=fail; b=rbX13RpyN3HenfQLqn+7S1+NNkcsjYd8e2gUcieEiDbBi+lMWezdQ5PeZMJMcYGa36aoJFXjyW1B5l9mm+o0Dg5XBBCNblmvTSQHbFzjxAAgsZ7IgxFsSLaOJIFJNuhRgEpY7ry+tpRps4j3WEHSVmBi9IqdFPtAIsTgJS1AMKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528506; c=relaxed/simple;
	bh=GScDrVUuUVxQjEcwOA8x7Nz/qIcG5AU8yhlLZ9jG4BE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vFVokZVlL7Jr9nU9m2iYLFG1lPM+hOGM8mZTby75Ece/3hD6AoUSJcGV7K7nw0u94gn9kWRtev2fvun4W6Wa8jLgd2b6wrEhg3tDE+JgLvob1CGE7WCe6j0+g1zM899UxzLN6aeHK+wpmf3qS76j7LqTZa5VPXMhAE4C1d5LFV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLG+zBLe; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLG+zBLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781528504; x=1813064504;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GScDrVUuUVxQjEcwOA8x7Nz/qIcG5AU8yhlLZ9jG4BE=;
  b=MLG+zBLe2yUC3kiEqqqczavj+9jOBlXECDWAIo9fWgzoobMnWk++jV9t
   Oe0OIPKnjQnXkAUdJJRCSkz4uRlXPD/qNyJLg4Z2UL6WfypZlwueEJ3AX
   82ynCGGkJYL/SAINEnhIqcxz6zwG95Wf1a1P5XGOWrf/HZXHdR4MqN7K8
   inmTUASHoWRkx536EVYFRjjL96RZlzexCyVWR49HMMD6sXAzFr+oKf50K
   9tabiouS1FQsagl9nZUuL+Ioyi6mSy9IMLaOX0amg5f9cBFe3LNbUIRWk
   vVk5TfkcV876zatsg/v1T6oeWnVfn8UhOAUNT9OaShBj8TEeW2wh1FcU6
   A==;
X-CSE-ConnectionGUID: 8aCMocvaT2SzZH1TKovT4w==
X-CSE-MsgGUID: ICFZjofKTUSETOJCx8dfgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="84831392"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="84831392"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 06:01:43 -0700
X-CSE-ConnectionGUID: Vbl3Bd/oSoWTyGlDZdMW5g==
X-CSE-MsgGUID: ineeHPHdQe6sRFc/mZDvDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="271546963"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 06:01:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 06:01:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 06:01:42 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 06:01:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvhDm7Vh9iEr+aTBFK4CASTrr2nRDph9BOmdjd0otXM4V+x/Zz3J5Bb+rCidEhk0l39YH1jX8K67e30MAyOhuqfW5z5jqtY59t7Phh1HkcRZBRXKuOGnjv64d40E/a8J/nYtONYBuYjHYO2FWYrsRoc2koxYelO2Hse77dl59c47rUiaTLbjtU0GIJeYEl6gXCtp9Gj32z1x5fwv0aTmvV6QAhfQubFfOcAsXvMXV3o85dYuRccOCzHn5WMVin1pzaCJ5pFQ+palPe0p/AzVnnZ2eK/4twCzo4glUxmX7Bw5p9XwUSNtREYkj5dwLwmtmFxIgi1aaAeb0n2MPXfwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GScDrVUuUVxQjEcwOA8x7Nz/qIcG5AU8yhlLZ9jG4BE=;
 b=MgwqKb76ydYV7vqfNj2F6Ag7kURs0YBa9dnyg6LT0c981+JjDDN6t40SpON5ihWJ99usY1V8fW0FemqZH/BzTKDDENH7bEDK87qFiRd1yqZ0lW+QMLIzJAeGppSCTAriQX4Y0Lw1NOnjr0VvIPEuI088dHMzxAxK6BiBLCaFaTVC5uHeJScUmGC2lof3Sl2oA/Jra0X656Jh7pgpdHWMr38YtxzY5DbwnsYOxLZJG+70Stn5OCzKEIA82myG583pyvh3bOdf5ztC+JoEilpHaQBjkBBZ9unvyYhoF8FJ/TPat2l2qdOJrHnuJmnJUEPlEdZRNt0j5zJNyg2uO8a26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CH0PR11MB5282.namprd11.prod.outlook.com (2603:10b6:610:bd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 13:01:40 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 13:01:40 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH v4 30/30] KVM: x86: Move a pile of stuff from kvm_host.h
 => x86.h
Thread-Topic: [PATCH v4 30/30] KVM: x86: Move a pile of stuff from kvm_host.h
 => x86.h
Thread-Index: AQHc+sg2WDg8kWhxWkC43gBckbTBIbY/mKMA
Date: Mon, 15 Jun 2026 13:01:40 +0000
Message-ID: <477ed5cf76f73379886c01bdf1a0f47c984f2de9.camel@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
	 <20260613000329.732085-31-seanjc@google.com>
In-Reply-To: <20260613000329.732085-31-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CH0PR11MB5282:EE_
x-ms-office365-filtering-correlation-id: 1bf903ee-a213-4920-967e-08decade3dd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: AYtJIgCyhZqiTbFYyiag3fZauarxmZs2yx70W0PdFir2MlovmG1ynRPIOxjkO7bkiEt+pXlitYn+BsQSV/NOxyZDS18ezSqH24CT31/LPL5bp4nJqQozAKf1dpy8yk850cD9KApMnqAr8v408jjUqX0Zj179D4djOGlx5FTG/b66yeY5XcsDvj5nE4e2J9J72MObTrQ2jcIv2uNYTduuw5LtyM8ROsMRoF5rIKRe5BrwVekZ5jM5fKXyAo8DbL95hlmjNUmkZInLyNFB9fNBvVGRXFkuzgAFa7rIOcGb3x7xNeOM3Qu2i9eQzM2AOfsSkQ28Iim9xCUK3hGZg/yy3iyxl3MQ7X7oh/qWmnbGHT0fb1ujSZab15pGgH2fSrSe2X5b6PMPYIeG9cpCznX5UczKm3fn38StnqkpmFdQYmsSflsC6G5HzTkixDaHQaho5PrTxc7rbdk12d54BIx35JrM//NDXKcKw5D/P1+bxJA0vOiPJZlW+eeu5j8EQKZTdfvT4+OxJKsPGZraAYVUplCJW87qj9NV3tmlTKvkPsHxhvVYXbQdb2Vr8PmrSF35YEi7z4SEG67t14By2fhkcBPz8Z0+LRgz/QG5q0V2bckTS5xoYpbodIzZMoEBk3vk/C4slUQ5PChTqNtA1MUW9/ZfcbwBBvaJfB6EATrz9pEvU8R3aVFvZLZtCfrkvX6tmHRt+ADOl4X4LI0fLOpL3QRBOGJBJJ1w2D0wwvaCxabekq7Wyr9wwnuM/gibfrgz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1dWcnIvaEVmSndEM2Q0eVRzb2xGcWZqL2gyc252eCs0ai9QVndEc0tFbzh6?=
 =?utf-8?B?cUEyOFAwWVZMdjJZZGtRcElIb3JJdVpwYVNtRlMwSGt1MTdUQW1uanhSbm14?=
 =?utf-8?B?RW1sUkpBTkR2eDRhOTNPVG9ha1phdkxpNHo5WjU2bnF6Q2hITHFZRUtuem00?=
 =?utf-8?B?aWQwOEJNdy84SnVnUy8zOTR5ZFZFLzVqeG9EMnFxOVZvSncwdSt3cG9SN3Q2?=
 =?utf-8?B?U2pmb0ptaSs5S0RhMURVL2lCRHl5Mm9QT2grQ00xZDFrRGwrZGhHM20xbG5p?=
 =?utf-8?B?VTJqOG5EbXkyaHE2VFJUb00rRnY5WTlHTnB0bU8rV0NsaVdMSmhBWVM5MHZ1?=
 =?utf-8?B?cDBvaG9ZZHVCRkdNYzNXYXNvYWFGZno3RGhIUk9DMVBlYS9FQnc4QlJXKys3?=
 =?utf-8?B?ZWd3N2ZONUIwOG5zbjlBRlFYVXhQSGtJNGdpeVYrTHJlMG5NNkFHMXNOYXow?=
 =?utf-8?B?MFBFcHlqeUpqTnoxZ0RVTnMvZ1VzNXN1V2xtczdWRW5VdXJvREtESHhpVkZo?=
 =?utf-8?B?RnI2a0ZKZUVYRUVLTDlPU3B6dnZ2NTBlbjk0WWFpWXB1V1dsanlrb3U3ODI4?=
 =?utf-8?B?RVlLeEMzNWcxWVFrUHJkN3hJMXJlQmNFS0hEWmhuVzZRUnY3RTQySDZaVUkr?=
 =?utf-8?B?RFRITksyOXdEOGFrcVRwdm11WFF3bWRxREgraWh6bFBNOVdacHg4UTBnVWFX?=
 =?utf-8?B?WDNZMzc4UGxiWEozTk5telE5dlFrT2Jya2tlei9ONnpvYWVab1Fkc0hjK3E2?=
 =?utf-8?B?NFZRd1czUjh6cXgvOVk5VVUyL0s2YldteXM3My9SR240cCt5ZDErSFp2K01T?=
 =?utf-8?B?MlZ6YlJNREx0TGlUNmJlSVdaVUlzUzNvd1lBdnQ1cDBIdUJ4cVZVWkxiU0ti?=
 =?utf-8?B?T3FXTHpmYXlFajVRTkhWaDBSaXhmditCZEFDMlBjU1dYZmVPeXJlWUJmL0VM?=
 =?utf-8?B?YzlTUEJmUFhYMTNaMWN6alZQdktqUlZzclRtSDBSay9SMnFMMThYY3NGaU1i?=
 =?utf-8?B?NVh2U05TK0c5RGplbDRwOFFFelpjYVUvTGROVlRkZmc4alFPVHFZWFJ0Umxr?=
 =?utf-8?B?bnIxZ0FKTnVxTEdjZVRaT0VMcVFCbndaSWhQSjliWGx5cEx5dmRYMktjSDBG?=
 =?utf-8?B?YW0xZjFZZEN3amdBNTRQM0g1Q1JTYmkvdXVPRWh4YlZ0SEljMC9rOTZRandQ?=
 =?utf-8?B?N2k0U1liSURvQWZrMzdpU0l4MFBRb3NXWktQVlhtMnNXZ3BoK0xQVk5WK0FL?=
 =?utf-8?B?SE9SOFZZUnIraktEbFhqUVRQQTFtVktST0VzRXY1SlFZaTl0ZldPeWloSnlF?=
 =?utf-8?B?NmUyRWVxc3Q3LzB1bmswLzlmMnFmaWhFN2pyRC9IRURJcTFobzFHK0lvNnk2?=
 =?utf-8?B?MkN6K24rTVRmWHFXOGxJUVVxT3pqM0REdG5CZUw3OGVyRDQ1TFJHdk5JRVVW?=
 =?utf-8?B?RTZHM1gvZWdVemtDT2QwamZZL1l2WUFMMGQ0ZjBrY3g5V2VaRUhMUGtvcE1s?=
 =?utf-8?B?aHlIZjVrL3llV2FFb1p1L0pkVktXdU01RkdyQzZjK1JPVjBrQStUbzZKOEIv?=
 =?utf-8?B?bFAxRUR4QUJIeGd6TFVsUFdPUERkWUQ4TGVodU1CU05SWW9ES091V1ZEdDEx?=
 =?utf-8?B?ejVBTGJ2bHJYSm5GdU9Jak1COXJIWk5CbG4yc0xSdEJ0eE1JYTdpZ1pSMlhZ?=
 =?utf-8?B?RWdJRUc5amhSUGxycUxub0dpTXBGYStVa3R6eElUT0RjeUFtNGo0NmdRV0Fy?=
 =?utf-8?B?MEMvVjFXOTd4TmVsZzB0TlphbWJEeFJnNnJjRXFtUTZDRmJLQXNhbmhHVE1s?=
 =?utf-8?B?eHdLQUFhazF1UWpUSW9SbDR4Rk9tS2ZYczZXYjhWUlVORnA3VHFWQjFTK0ds?=
 =?utf-8?B?VU9lR0xqSUpqdnFsR1FkNEdic0F4OExOVGlXYWRBWlkrd2svQWxqR2pHK2Y5?=
 =?utf-8?B?UVpoK1BKRjNpemIzME1QTGdORjRHbEZDeXFYRklYT3cyeStmbXpNb01yVXBD?=
 =?utf-8?B?UllEOFYxakZMVmRUV05LYnFUTndOTFlHNWZBUzRZa0MvQzlPRXBDQTIrblg3?=
 =?utf-8?B?cTFYeFJneWFaRFZLS2VFTXJXSkZLYnI1MG9NTnczUUM1ejQ2MXAzUDBDcy93?=
 =?utf-8?B?OERyMDd4Y0dmMmNyZUlsdkoySWE0WjRiSzcxYk9QbVlxV2o4RWtIQkVNZXVS?=
 =?utf-8?B?eU9MQkIrVjA5TTA0a3JUYjNIcUk5b3d0bkZBMmhQUTg0VXRPMjdDL0pGZklP?=
 =?utf-8?B?MjN5TmtURHZPQjVVV01mNHBHSThGb3FuSDN4dWg5cFplL0kzTVR3WE5reXNu?=
 =?utf-8?B?dWEvYjYrQzFOWHNla1A2V2tzWUtpNkYrUXU0QjB5Y1dxMGczZEN3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E0028E05EB22048A091012FF5BF708A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MSyVxb9s1OkazNznvDSe2yGbQINfmjjMn64MtDJCDiyk3iE7gnehF4UJ6tFoO3z5LXtUBk+mE01loNZLTor8/jr39OYfHBoZ7JtJDIuCPqH3B4ronwydARkC0szJwLyqTdpq1WkDVGfikWL18fWF37eQXCulL1MlLSUL0A7LCx4wJOlP6nQ/FyS0VLzwgzsJv6SY30TMpjQhc5iJlMa8iJ0bAKyMKOFrQyN54r2f6SEQTpKJmqJd4+0wNlQ/UuH+/J/uW5FCavHqzQ3fcvWYHwDyWIttevbyi2yoqIMJdGrySS2p8b9tKAZ+r1STmU2ylFkxXhpGGazgHF6JRBosXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf903ee-a213-4920-967e-08decade3dd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 13:01:40.1856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYeT0O2m4lX5fDfoLyhyXrDcAU13sZeUZCs4u2SDoJ1a/BQEYuPPcCb/Cs8IiV5P/Zp0AHVBwZVffexlw534rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5282
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTEyIGF0IDE3OjAzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIHRoZSBtYWpvcml0eSBvZiByZW1haW5pbmcgS1ZNLWludGVybmFsIGRlY2xh
cmF0aW9ucyBhbmQgZGVmaW5lcyBpbg0KPiBrdm1faG9zdC5oIHRvIHg4Ni5oLCBzbyB0aGF0IGt2
bV9ob3N0Lmggb25seSBob2xkcyBzdHJ1Y3R1cmUgYW5kIGZ1bmN0aW9uDQo+IGRlZmluaXRpb25z
IHRoYXQgbmVlZCB0byBiZSB2aXNpYmxlIHRvIGFyY2gtbmV1dHJhbCBLVk0uDQo+IA0KPiBMYW5k
IHRoZSBlbXVsYXRvciBpbnRlcmZhY2VzIGluIHg4Ni5oLCBldmVuIHRob3VnaCBrdm1fZW11bGF0
ZS5oICpzZWVtcyoNCj4gbGlrZSBhIGdvb2QgaG9tZSwgYXMgdGhlIGludGVyZmFjZXMgYW5kIGRl
ZmluZXMgYmVpbmcgbW92ZWQgYXJlIHByb3ZpZGVkIGJ5DQo+IHg4Ni5jLiAgSS5lLiBrZWVwIGt2
bV9lbXVsYXRlLmggYXMgYW4gaW50ZXJmYWNlIHRvIHRoZSBlbXVsYXRvciBwcm9wZXIuDQo+IA0K
PiBOb3RlLCBhbnkgIm1pc3NlcyIgYXJlIGxpa2VseSB1bmludGVudGlvbmFsLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQoNClsu
Li5dDQoNCj4gLQ0KPiAgI2RlZmluZSBUU1NfSU9QQl9CQVNFX09GRlNFVCAweDY2DQo+ICAjZGVm
aW5lIFRTU19CQVNFX1NJWkUgMHg2OA0KPiAgI2RlZmluZSBUU1NfSU9QQl9TSVpFICg2NTUzNiAv
IDgpDQoNCk5pdDogIFNlZW1zIHNhc2hpa28gd2FzIHJpZ2h0IGFib3V0IFRTU19JT1BCX0JBU0Ug
YW5kIHRoZSByZWxhdGVkIG1hY3JvcyBjYW4gYmUNCm1vdmVkIG91dCBvZiBhc20va3ZtX2hvc3Qu
aCAoZGl0dG8gZm9yIHRoZSBlbnVtIG9mIFRBU0tfU1dJVENIXyopPw0KDQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9rdm0vMjAyNjA1MzAwNzU5MjguODg4QjYxRjAwODkzQHNtdHAua2VybmVsLm9y
Zy8NCg0KQnV0IHlvdSBzYWlkICJtYWpvcml0eSIgaW4gdGhlIGNoYW5nZWxvZywgc28gd2UgY2Fu
IGFsd2F5cyBkbyBtb3JlIGNsZWFudXANCmxhdGVyLiA6LSkNCg0KWy4uLl0NCg0KPiArdm9pZCBf
X2t2bV9zZXRfb3JfY2xlYXJfYXBpY3ZfaW5oaWJpdChzdHJ1Y3Qga3ZtICprdm0sDQo+ICsJCQkJ
ICAgICAgZW51bSBrdm1fYXBpY3ZfaW5oaWJpdCByZWFzb24sIGJvb2wgc2V0KTsNCj4gK3ZvaWQg
a3ZtX3NldF9vcl9jbGVhcl9hcGljdl9pbmhpYml0KHN0cnVjdCBrdm0gKmt2bSwNCj4gKwkJCQkg
ICAgZW51bSBrdm1fYXBpY3ZfaW5oaWJpdCByZWFzb24sIGJvb2wgc2V0KTsNCj4gKw0KPiArc3Rh
dGljIGlubGluZSB2b2lkIGt2bV9zZXRfYXBpY3ZfaW5oaWJpdChzdHJ1Y3Qga3ZtICprdm0sDQo+
ICsJCQkJCSBlbnVtIGt2bV9hcGljdl9pbmhpYml0IHJlYXNvbikNCj4gK3sNCj4gKwlrdm1fc2V0
X29yX2NsZWFyX2FwaWN2X2luaGliaXQoa3ZtLCByZWFzb24sIHRydWUpOw0KPiArfQ0KPiArDQo+
ICtzdGF0aWMgaW5saW5lIHZvaWQga3ZtX2NsZWFyX2FwaWN2X2luaGliaXQoc3RydWN0IGt2bSAq
a3ZtLA0KPiArCQkJCQkgICBlbnVtIGt2bV9hcGljdl9pbmhpYml0IHJlYXNvbikNCj4gK3sNCj4g
Kwlrdm1fc2V0X29yX2NsZWFyX2FwaWN2X2luaGliaXQoa3ZtLCByZWFzb24sIGZhbHNlKTsNCj4g
K30NCj4gKw0KDQpUaGUgZGVmaW5pdGlvbiBvZiAnZW51bSBrdm1fYXBpY3ZfaW5oaWJpdCcgcmVt
YWlucyBpbiBhc20va3ZtX2hvc3QuaC4gIElzIGl0DQpiZWNhdXNlICJ0cmFjZS5oIiBzdGlsbCB1
c2VzIEFQSUNWX0lOSElCSVRfUkVBU09OUz8NCg==
