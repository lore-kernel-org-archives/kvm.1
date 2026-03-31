Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207B9399345;
	Tue, 31 Mar 2026 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951759; cv=fail; b=P1qaG3VCJi4GjXu6GNEN0q0dwHkIURQQ9hNTz2anT0fiqmqpYwgsD8/DUC6ddj+vDV+64D3fqwjpnwFtL8lUsPKZxOO+K4AdXtdwXtqMHzq3aZvi+DI7oNF6reaIsXBdBYJ1p8irkTHi9BVVmGzqFKizoUiLez1ijn64aX1T8CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951759; c=relaxed/simple;
	bh=Q5Rv8sf6dTEwByEsgPgocilhdyej0lsUJPNIehB+kNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RZhF3Vw3Q3deC4Of/wxcfdCDPaaKOEUjL66nLwUbj/FUNWDeRWNwzRgAUix0jA3+IMzr4HMs9PrYx+gmEBGUZRJiGcI4qyDMDBTB/Qqk/C1CbzvwujjftQ5HAYTDBMZY980Qqc1vg1NaOJunN4IPpDPDJYRuO0kUYa9gj9sBRko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flbR43Pt; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flbR43Pt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774951758; x=1806487758;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q5Rv8sf6dTEwByEsgPgocilhdyej0lsUJPNIehB+kNk=;
  b=flbR43Pt0qJu5GZ8GkqHdsPCoTk+8dFdWAOn9mxY0XLoClNyAq2sfHR9
   7TAwzPtRGAt1xKy2ZHE6ST0nR3KMopzOozTb0MxkhyQLrmtYZo6uxZZy5
   85CU+3d20UUe3fEP7cmXhHGmipj2iSYY8sb7n6G4lfdD7/7qxhZG10g6u
   x1qY/+scv8QmGiuQ5fFxfnOfCmAkjveuLBdIm1Q5fnZG6vpfv2YxbLpow
   7vbBMgIQ2SrBIizPdF1JkJmoVy96LaDfEZhGSZRSAgPySFPtUjAcqw07o
   KdqKrr9S7oq/fav9pcmZWfQ+6MHzqlVJqX8N5oXYjjRjKYmou3Bp8YZaP
   Q==;
X-CSE-ConnectionGUID: ZzFvMqopSJSE1gy+qBu4KA==
X-CSE-MsgGUID: aZjQfQMgSaqlYfKflwdAyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75977570"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75977570"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:09:18 -0700
X-CSE-ConnectionGUID: AqyF7fmvTjyKQf8uDn4ALw==
X-CSE-MsgGUID: pSF6rVSGQwWVoo/kNmcqYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="231142435"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:09:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:09:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 03:09:17 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjackAjH5xiWznbWq3s6cxATEopzeVtG2GogaAElfSC0ChS5+ikaXYfrQuqJgsk59QXscVCdTO657eIygt2qGRaAIW/KFsIeAm7dWiWDzE6cFn8VGkRM3tNg1/3AqXrBDBV+kUXX1dt11s7OH/J1WL1OLV2rGR/i+y3o7ulRFWIxnXcOdFtbmR0qZLH4b2EGrL7gHn5U1WXr9JqjBihYhKryYiRQgmye1gUqZbJ+TLDuJ94aeAaMFp4082QnkMHVDHnOgChybTSJvygxdN2IsODaZdrXxywa6DC2kKGKhnjVjCOynq58fKjlQDADTg27mmqcOeVuLDr7M+zyUNEv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5Rv8sf6dTEwByEsgPgocilhdyej0lsUJPNIehB+kNk=;
 b=RjodR7b42X23BIRgKjwyvnw3ULj3I+sQYHYbT5Nm+V6xJYGsL+oPo0TLzBN0x66yzJq3yfNYmcbMt9zqb8l63Z5uL3sA3D4d/W0/82hxFMe9XyPUhdatc6ZJeOdN+tsMGfZC+1DoYwlZrHk5F049C/peJdmv/k6GGbqSVYCMkPd1x3JiEvYM7Mi7PceVhDgIgYgtyNzPufOMlEBTTDq3ds8BOOPMSfp5SSSqX7YrqZ2q0+7lb2SiUvWKh1j0YFtleJqG/T3jR7FJ+/QsfvkJWXFKW0D7NbNCLXnE8jAuj1rPbZ0dS1nXv9ecaPMfogxyPJHrM31ahQCYM/9N1tLLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA1PR11MB9636.namprd11.prod.outlook.com (2603:10b6:806:4dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:09:15 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 10:09:14 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Topic: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Index: AQHcviZX7bFmE++yzkWQSajwny2yIrXIcIsA
Date: Tue, 31 Mar 2026 10:09:14 +0000
Message-ID: <63caca29904f7d7d657ed54f71be1e066b422a9c.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
In-Reply-To: <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA1PR11MB9636:EE_
x-ms-office365-filtering-correlation-id: d6beabc0-6bb2-45f3-a6a5-08de8f0d902e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Kj0AgIOXokTMwMC/rrGTY2glvLoxnG0EkKpndbxduo0QULiSaJB9mLL/x7tRgm+j9lldsBgm8lCGo2PlRh1f9dwGmflGwTRkGOuuRFYDjvsnPlR8b4/1s5qw7UkGMOhzq/OlZ/7ZeaT6dAOiKVraVUIE4ohWTp/s3nTElStlpZHSERFz7ENcYnKvMSK/It4pjFmx+2L6Tzk9aI/eC9Gj2FBLiLN+qiqnMUlBCcbARkKESSqtXD9+XPsQE2NPnym/Y5xNxu4AfeR3iOzWmSmTde1IgVPozaI7OOQd72RSR8I+3bTMJkEgR7JPcjB4WfvfOjAYJ4/4yBeicLRKTSN5PTyUWwvs4B4fJ6lhA9rI16E9ObF/h9xMcAhyu3G4TR1WzR6kzylTaktcQyiX06STC4ynZWEapFF2L3/5Rr7PZtsK95jmAWvT/v+B+dWyxnPGW79UQRJb71mVStkqjZ21gB7ckMm3zbaQS4UerulNCh3ULziQWs50eSfdQei+96pKsUD3BRvUIG7qeg6JHydTq3HBYRyYeND9RNy5mYG4Eva24UkOW0JXzfL8ssVXmDkvuNpvO7lnj99+RfN4XWzvOcDTq9PXERX3t01c5DnMlwz3hqg9Lrt0eRc4eA8pref2KhjMz2RB9NymOjVml7TLybwS0/TeamzimK9c/lkh5urRryBp/r7qvDJKz48iT+rqCO57HmoKFnbsKq6kqEW6m8VQjjItKhu2jqmBoUUIc7nyudVLOFUVNQR0t9iLHizkbwYfG+lfhCQl9VP6/9XRB3A8fqFl4XRvXeW7qTSUpVo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bklBQjMrL3Vzb2ZLbVdGVkJKVCtOQ3JqT1RqSVZDdEovUkVKQi9aNEk3VlRT?=
 =?utf-8?B?TTNVMEZUTDN5U3ByQnRxKzZJMHVYVEowWlFnWnQ5SDBjN1ZJSkhnTkVUbDFT?=
 =?utf-8?B?K0dSZ0U3S0lWZ1EwMGhsZno3U1dFbWl2eFRvNGNzeHJVa25oTmo5YUM2SEY4?=
 =?utf-8?B?anhRLy9rcjdyUmNyYUNjYWtMdHFWNjJJL0pxbGlVRysvSnZnMDJucWdwbUg0?=
 =?utf-8?B?anVRaWNwS2dob2FkaFFHSUVNaEQzRnA4ZGd6b09pVUtIRkVacDNNUWIzNXpO?=
 =?utf-8?B?aGdCenB2Mjc1R2NWVmtUcytEZWlhQXF0SytLc2FpUmQxT05Rd1VEZDBweXBs?=
 =?utf-8?B?WGpJbjZzY2ZHT0tNNmtkNlk0YkVwK29IS0w4YnFHZFFvWEEvQ0VjTHRJdjdH?=
 =?utf-8?B?RitQaXRGb3pSWGpRYnhOaExYUE50cWdNTmZmVm9WT1FJMHJ2Q0FjaTBEZmRa?=
 =?utf-8?B?eXEvejZIR3pPd3lpNFlkNDVJdC90VlFEL2h0TFc0QUo3WFBxU09VbXZUQUJQ?=
 =?utf-8?B?d2pJWHZjdmNlL3MrWk81NUVXSVFxMkFpOGxUbGN0TVliQUY2UWhwV3hyMkJM?=
 =?utf-8?B?dm1qSkw3aHdGbWFJeTVWUTJqaVhoMGc3Nnc2RzR2Y3dlSDh2SjRPaTV6dU9C?=
 =?utf-8?B?TUVYK29oSHlzOThJYWpsVWVoUE5McHJiSWhxY2NmS0lMUS9nZ0g4Wmk1ckNl?=
 =?utf-8?B?RXEzYUVOYzY2NWRoVGFFQ011SU1QTklEQXNJRUZUQ01VY1F2dklWYzFXNDFi?=
 =?utf-8?B?UXVXMUszZDBUam1LVlJVandpaDJNNGJwdjJoenFzaFY0VzcvSWxpM042a3ln?=
 =?utf-8?B?aFljeVAyWW5IWGJZeFI3VFBPaW1wczZwTTV6NC83aWNSb2txbXVabnJBYTlZ?=
 =?utf-8?B?ZW5iMW1vL250R0dybWxveDkzWnpBUTJWRjdqQ3FaempnY21aTHUrQXJCWnA2?=
 =?utf-8?B?U0NmdlZ4L0o5L2JqNTJtTUJ6S25QbjdDQm9vQ1dJa2J0NTAraitqTjVpNTRH?=
 =?utf-8?B?ZjgxZ0srOE9GdG1pT21ZKzM5Q29CZE13VU9rdDJvYzVtNnEyRjYzSCtKaGpm?=
 =?utf-8?B?NkVaUW95NEluMm51ZmJJeVR3dTZ6ZVlaM0U0dnByMlBDRzZON1NvQ2dGSmJY?=
 =?utf-8?B?YkNkcnM5L0tTUUEySi9YRDBic250dHhVZThaQS92ZVlMbGJXL0JieU4rMGZT?=
 =?utf-8?B?eW5OaEF4OTN6QzBGYTBrN0F6cGh4TnFnREJWQ29UTWJaVGtKTmF5ZXgzUHZR?=
 =?utf-8?B?c3YvdExKZ1NCS0RJZm9qR0VQVnZ5SGo5Qm1DR1ZTdVZhOCtlK2FpbXpKN3RM?=
 =?utf-8?B?VUdvc3l4THJ2cE1wTHNMTXlQUHVWTEF5cDUzUkFBWDNjM2NJQTlVL0dDTFV0?=
 =?utf-8?B?UEZlK2x1Q21PY1paYTkyWXB2UzlkNkV5N0JxRzVyd0NTOFJxbk5aMkcwL2xE?=
 =?utf-8?B?YkxkTlMyUWVKNVk5cnErUmZYRjRwY295VVRxYjF2SDhxYkxjSG55ZDJmOXBz?=
 =?utf-8?B?YjZoVnZGY2dNUmplZ0Z0em01b3p2WDFGT0xseHJmaHo0blJvWFMxMjVlMWRJ?=
 =?utf-8?B?LzI1Nm1pYjVHTkRGZmZITktpT0pweGtWS0tXdFBtS01QNFBhUUN2b3RSZHVo?=
 =?utf-8?B?T21LRk0yS05Uc1FySmh3WkZwZkNTR01HY21RRjhKNDA2TGdhMkVyNDNpcytR?=
 =?utf-8?B?RXpWTEplb1llNHlMeTRTSXcxM0w2VWRVVTVNdHMyQXEvTnZMOTlaVEhQL2Rv?=
 =?utf-8?B?WSt0cmgxVExjRGdLc1dWcVJqbUF6MklmWlM4VnpxUCtoa3g2bXRFNi9PZnZs?=
 =?utf-8?B?N2R0M093ZU5iME1FczNUNTlKWFVqZHhXSHF0RWEwOVNDbURONHZwVVd2NlJK?=
 =?utf-8?B?UHJpSktxK2F4WHR2UnFqL1lCNmM5TFZDMko4OTRKZEpjUCsvMGs3UzZHdEUv?=
 =?utf-8?B?ZlVyQUgxQUp6NUVydVRRYzRMZVdkQit0VytVb0pwdGtnV0hjdDdvU2pBendM?=
 =?utf-8?B?dmh5TEh1bjg0WEk5Q0daR1loZEc2MFZvZ2JWdytGTnBQdDlITlpBcXBGNk5X?=
 =?utf-8?B?RjlUMklKUHNYcEpxeWVPYW9vNjV6SWpxNUpGaHkybml6RC9ZTEtiQ3FZNjMx?=
 =?utf-8?B?c2dkNHhRdkt4N2FrdWlZZW1xMnl6R09JaHBCYlpBS3Jzekp1RjRaUkZIVVJM?=
 =?utf-8?B?TGxpcHpGNDI3NVdoT2xPTGRBR0taMEI3b2x2aEsvMks2Tll2azROelFxNU1M?=
 =?utf-8?B?SDRCczdDQ3RxUm5EUUZyV28wUlFrbW5na0JhcFZUR2NmbTROUVhZc01hV3Ji?=
 =?utf-8?B?THhUaVVmOFdEbXZJcFJuR1ZpNkthN3h4OUdkbTFvaGc4eElTejQrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A496AACE163B734C9A98A75E02330023@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AyryLrY0AMfkSxYDIGrLHV8AfbB345GUAMEQImZmaHhJliF+tI9w4YGLl9rVaT58nl4SJrKE/K+4Y5BsWC6PmFXoqW/xCVHE/j/ORSUMb13ozb3AR4ETQ+vm1NVP624HyiiE38/xkqCT8ewFEc62QGXjqnnzFap0IdflBtug1Y7y+q7B/XpA69+zT1bHl85Jjr6YTuiaHiK0aeNIeZ0HhHVLFT2M7sFaN5yssNDw2KgeEyG1YF7MijKDNE9oFRDPkGnUjkmh3J2rddsr8i6oulonUonG35XrVQF+afSNELKkCRpLGr8RktNv4C5rmbCxNrhf+8qtRNKN5HUEVEywGA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6beabc0-6bb2-45f3-a6a5-08de8f0d902e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 10:09:14.8914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SgcSV31wVjt9AHjLS/RqQAtQPrJwgVz9rNC4y5hWVerAC6uV3v9+jWX6RkcQy0hiBQJt66r3Xdv+9osNIQy+QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9636
X-OriginatorOrg: intel.com

DQo+IEBAIC0xMzczLDYgKzEzOTYsOSBAQCBzdGF0aWMgdm9pZCBrdm1fdGRwX21tdV9hZ2Vfc3B0
ZShzdHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCB0ZHBfaXRlciAqaXRlcikNCj4gIHsNCj4gIAl1NjQg
bmV3X3NwdGU7DQo+ICANCj4gKwlpZiAoV0FSTl9PTl9PTkNFKGlzX21pcnJvcl9zcHRlcChpdGVy
LT5zcHRlcCkpKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gIAlpZiAoc3B0ZV9hZF9lbmFibGVkKGl0
ZXItPm9sZF9zcHRlKSkgew0KPiAgCQlpdGVyLT5vbGRfc3B0ZSA9IHRkcF9tbXVfY2xlYXJfc3B0
ZV9iaXRzX2F0b21pYyhpdGVyLT5zcHRlcCwNCj4gIAkJCQkJCQkJc2hhZG93X2FjY2Vzc2VkX21h
c2spOw0KDQpBRkFJQ1QgdGhpcyBjaHVuayBpc24ndCByZWxhdGVkIHRvICJDZW50cmFsaXplIHVw
ZGF0ZXMgdG8gcHJlc2VudCBleHRlcm5hbA0KUFRFcyI/ICBTaG91bGQgaXQgYmUgaW4gYSBzZXBh
cmF0ZSBwYXRjaD8NCg==
