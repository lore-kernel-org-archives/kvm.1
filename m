Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F9339390;
	Fri, 11 Sep 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140283; cv=fail; b=Q+E2JI4Wz7yQUNxg5QLbx6pKc/sBPMRLEm6WsvO0HJRiabAL6ILuoUPCb3anahZwQ26dAYud6b9u9/QAdJ0xN24jNRlhLbJt2pWxSkV7v9wUZnt0L6kDpc6xL8btI7imzaWqhV4JSfj+CfUwg4lGiL07/KFruVQDshjI5YIc8yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140283; c=relaxed/simple;
	bh=v1niNsjFvchHf0WTapX2VxZ6Wep4cSK3gmL/D5mOibI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mO1n0jRPZMAIMmwlSi/cOB/PDCchqNwjmZzACG7YwO0JHuKsjH466zQBg7UR6LcF1J+kjQjqUVfO9y8KdeZjwO/KllK3YKx7/t3moev6yyPDOxzaIkDxbybRPI2q8/mrbpLc4Lj7sOUrFjk5fsfDfaYwPmIDeArhWGRQjKeFigc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3GPT+FZ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3GPT+FZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789140281; x=1820676281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v1niNsjFvchHf0WTapX2VxZ6Wep4cSK3gmL/D5mOibI=;
  b=l3GPT+FZ7Z3Jeu7b8luyC6Sp+Lxc2Fd+l/wp9dl9kBwlFvFPvjsdnQSh
   aqB1HKpmQHro5z9rdqwC5eEdJAy4Jy1WCpSeXZGDd1bzkZ3ybSsb+L6Jh
   oDoSXkZ+P19IHDQ9V4bhf7XdXqO0igMrALfOZWyc+p51Q2SSTcHktfDQb
   F9tBzH8U1F7OIGGMpIUsvWzGdC+lOwAX6FYEAuJwz/TK/Wgn3R+QBKNK8
   NWcSiK8UzIWlq9DOlzofcwhqY/3AOMK2j2s2aSINhXHTqkDBLZPnvDaIE
   ZJ3otPNag5UV0zWr/pg1vwBABACsAKQHoE/ae13BbHSYmB2B0Neyprtqm
   w==;
X-CSE-ConnectionGUID: B7rBxiK8QByhK1hFat+K4A==
X-CSE-MsgGUID: H0/ZsG7EQ+ieLlyIyqOB6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89476287"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89476287"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 08:24:40 -0700
X-CSE-ConnectionGUID: V/e4jLETS/2osiNnTNP3FA==
X-CSE-MsgGUID: ARk7GlhSQ6K2udljSYpKNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="268264447"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 08:24:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:24:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 08:24:39 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:24:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SE5pDdq/2DcAlWpa2wh1+JorO/yV/vc+p0Vcwft3aU2WrTq/kKWvIEqAAd9UdPaAls5VK6QRb8WyYAggJeEhVJN0lUQ3jTwegzCrlA2ruhlqgPKgniKC0OCV/0vzuIm4tyAmMBsakjO3tXNPgo6Ep1sUWQ/GRfGviniDZKguSA5Evsd02JNR14gVHuq1risYDi/xjhR74p1z4vA4spI887cSBfQCIWeSKpYrguQ5iyyIvv5sKNPiEnaUiuqVPUBOitea6WGyXsvqNTVyZ7mFQjQhk4VQUiyUyN9ngnTzNr26gKZY6c4mivSfTRaAD4cXY4L1temQQFr5qgeUbiYenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1niNsjFvchHf0WTapX2VxZ6Wep4cSK3gmL/D5mOibI=;
 b=ZTNHP23QaN7kmZMpb4pYfQfp/pLaOaHgYbRUtfqjP6LJpbyWYs3d9jxqEDj+vhiPWfFpoFhmyKZeUXBs//bXisoSXK8JN+0yVgb9DS0Z56Qa9+o+8Xtjz3D9OzpS1ex6qBVVnNEv6YUOM2IQU2AayqRNCSQVqDJWjNCHJyOeRna9E9oZgIHOtNl7GCjl7W6kMomItTNaFMsHp/VHuSE5wAanP6HIXHbSwwWzV9j7TQDYU22fybpwSCTPe9lF5KnXod1Qfh1vPYX+nIcKssPGyhFnDgg53/gZQaoryLWJFxII9ZFXC7Fu6dDj5lliUL10Pgfu3GjCZbu2lXmPrzInUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MN2PR11MB4550.namprd11.prod.outlook.com (2603:10b6:208:267::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:24:35 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 15:24:34 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/tdx: Remove the early #VE handler
Thread-Topic: [PATCH] x86/tdx: Remove the early #VE handler
Thread-Index: AQHdQVJIriwy64Eilke8gkXVO7WINbbIRmSAgADp84CAAFBPgA==
Date: Fri, 11 Sep 2026 15:24:34 +0000
Message-ID: <93b41dce8d7a9b4f28bfed2a51f919eebec9b7f5.camel@intel.com>
References: <20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com>
	 <b41da075607d1eaa9d96eddbf3acc24502edd604.camel@intel.com>
	 <aqPTIyi--7f2Fzxm@thinkstation>
In-Reply-To: <aqPTIyi--7f2Fzxm@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MN2PR11MB4550:EE_
x-ms-office365-filtering-correlation-id: f666461e-ee87-48b9-9796-08df1018c8e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|22082099003|56012099006|11063799006|4143699003|18002099003|38070700021;
x-microsoft-antispam-message-info: H7RaAUNbUy617Yav+M8Qdiwf8iIxsnK+HsDxKDjOIU5gMPiHo9sJHA9JPYW7uhRlEAAp6ICIDkxX61dauzPMc/Si0Hi5WfqXV7LG0IdLZS3g2mTyER3DuU8s05xkWX9X19NL6Sin1OoZX1ov15LGs8eYoWhOGK3g/rnFoJraclqac9POSHZgU+FkMU2v37CST9modSGNuSAoWyQOtsetkAsCLIn5+rO0xbWnGDS+V6yAZVaKyxyApRXk8OJKZSQn3rfWLXYOJ6LCsB7kPrWGHYROCD18rvn6QBYWslNv1m6Z6NfURYKB9eGMRCNoYPlsCenmPYG89cOuxrZy/1OGd/DwsrecKJgmcl+stPISd648Zl4A3ahVRqMbqp/Lvr42KTuVtySUGU0KfVOc3++EDostupW/3oGqxjx21QmJz2YfP00PDZ4ZsPtz23Cz9ZqSJVD27AjF4HVFyuLrv/NBWm1NeK4XqOa+7RpClH4US8uEKDJGH3WYf8wzqSJ0DxLspjRYmWcUJ0bVuyNumXmJPW0baq4j3Ww9x2d3D17smW+nV9KsVrNmUgwThFb4RvH/cxr+cKEz4qYePtuzJZXM7Eoz/bjRrUyffbTcqphjAld2xT3eE22YkKt6WKjOwCvhkKpR0JbJzBm6fVI1VMRFsCMP0EnXO2nmPorlJx/Dw+qlthIrvnc3awf7aEa861FN3Fscvz1fcVlfrGl8joGFl3C3YFJSk9tQfgUo+ClFMj0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(56012099006)(11063799006)(4143699003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek53c0VZd1lCSzRuQWk1K2k1aXZFM25ES243RzBBWFZQREJqc2tzZlBtVXow?=
 =?utf-8?B?MlJ0bkNiRXZXSlcranN1OE1OSFFvSndpK0pLME5UNU15KzlaSEsvUzBGZE5L?=
 =?utf-8?B?Y1JkeXdZbjl3WlFWNDRDYm5nSWsxNm9aM1gvQXpNTFNncFF3QTg4YkIxeVRE?=
 =?utf-8?B?dGh3V1JVckt5a3RIMlpBVlBaaEI1d0FNbjk4em5DS2dESlA0R0tnMnZMdFEw?=
 =?utf-8?B?RWVRMDJ3NDdHRWh5Sk96T3E5bzhLOUVDaitJZGpwS0NvMktGMWpYNXM3MGRj?=
 =?utf-8?B?bnUzb3dSQWZUU05yd210LzM3YWQ3SDlvamdFSUt5UlZaRldXZmptbi9qbmpV?=
 =?utf-8?B?dkJXbTdpN0ZPKzFzbjdoWmRnYjNHY2lncStESEtGSExqMDArUmpuZDJjS0dB?=
 =?utf-8?B?N3NKZlhOWm4rK3BHTE5XcGFhdTdOWVNveElIYnBITEJIWTVzTkhnZmhRTEZt?=
 =?utf-8?B?UWNxamZhWU1ZaDQ3OStkRmJzUmdvSXJNMnBxMk1OZGh6a1llR2hXSTc2eEhn?=
 =?utf-8?B?YndVQ0RnSGY0Mk5TWUs1cmFzang0cWdORVVLdjRnVm9Jd1VzZ1ZYRmhHU3Rv?=
 =?utf-8?B?R05pcnFSSTR1c2VmMko0aElXaUk5cWxRRjFXYW5jenMvdmFkUU1yUlZ6TU5H?=
 =?utf-8?B?V09wQWhQaGFpWnlNMVlFMHA0MHFOTkliMmNicHNJR1RxQU9tRVU2cElhUG9y?=
 =?utf-8?B?SnppYi9iVlRCc1FWSFlhZDJ3MUJaSEZ1ZzFkOUJnWUVHaEsrNjBmZ01lN3RU?=
 =?utf-8?B?U2ZxcUNRWVhpRzNMTTY3RENRSlNnRVhFM0lHUmo3djB2NHBQYzZVVFdqMDhB?=
 =?utf-8?B?Z1RHaTUyYXRhUUY3N0Z1MDFsaDg2Qk1wT0RLSUo3eWN4OE8zM0x6VTBadUxt?=
 =?utf-8?B?RGsxL05MTzdUNVYybi95VFNLY1czZ2VxYkNGVVg3bUlRa0tHVmpXL0QzY01y?=
 =?utf-8?B?WEJDNHlDNmtRME0vRnVXVDFVYWtJTjZBZno4YlVXR1NxUkMzWU5ZVUhyc0VC?=
 =?utf-8?B?Z1hjK05laDBqd3NEb2lXQnVLRmsyRG01OWRTOUhpNUVIRFhDNjN5NzlhLzFX?=
 =?utf-8?B?cTdEblloY1FBbU1vbnNXbmw0dVVyb3l3NTdWU2ZqUEhkVjhWZFd2b215SXgy?=
 =?utf-8?B?cU5XVURzMFEwUnhyamhZUU9CWkRSb0JGZGo0clByOVdHR2NOYnBaZnJ5U3dI?=
 =?utf-8?B?NVpRN0tuVTRoMVRzd2RxaWkraGE3dEZhNGhkOVE4dG9LS1RFSUw2Rk9IVmlE?=
 =?utf-8?B?Qzl1REhLN2FheEdVS2ZIZWVOai9TeXV1R3JTM3Rla2w0RkVnN1NHdmxzQ0Vp?=
 =?utf-8?B?cjJXRDgvNHNDMTB1eml6T1RhLzVGZExkZjdnS2hvdkxXRlFmZFFwSUtJc3U3?=
 =?utf-8?B?TjF2dHpPOUhCdE40Wm9kTVBBTW9MKzE0WmF5T2tRb2Yvb3BrWlVOOCtBQjZk?=
 =?utf-8?B?VStycC92TmcrMXJ6VnJ1NzcyT3VYNHlKWWJnZFJuTjVnZjFJamlJTUhnUkp6?=
 =?utf-8?B?SHRzVXFudkk0YnltLzJBU2pZSVN1MFJSM2pHR0lGTklMZHNvYjROK01iM0ZT?=
 =?utf-8?B?bTZFT0JJMG1OUU1MVUFSZU51UWNhU0ZmRllHbTRROFFibUUreWt3aFZRQ2k5?=
 =?utf-8?B?cklFblh4Z25OcXdTV3JONEdpdGd1Q1NhRENRb2tMY0RVeGwrMHB2c0pTQjV3?=
 =?utf-8?B?amcwejQ1RWpjN1hQc1F4Z2UyYk4yVENIRUR6dXkwamxvS0d4Q1FaSnRtMFNl?=
 =?utf-8?B?eTNDRjVFaHRFNWV4ZHcyRFRVRVVSaTFwcGtQdVVjdnVLaFNKa01TUjVqN01W?=
 =?utf-8?B?Qkw5NnBJQ25ubENnWUNVTzRCaHZhY3A4TjBJRldpZFE5V2ZGN0ZwOE4xbU5M?=
 =?utf-8?B?WTdMTStjVXJpMVBXYWhYRmxtZG00WGhyVytGTjZEQnplWFplRTJ0dGhzRlhp?=
 =?utf-8?B?Wm5tSVZ2eHhoZG9SbTZCcTFRMElHV3F0cmpOa0gya054S3IzYXlaODI0Zk5M?=
 =?utf-8?B?dDIxNUtaUDhRSlhJYmo3SElSaWcrMTJHQkxUdlZjbTI1SVhTcEd4b0lBcWNZ?=
 =?utf-8?B?T1YraVpoYnFrdXE0UzNKcG45ejNYQXRnVWtscUdFeXpGQ2d5VkpuUE5Jby9z?=
 =?utf-8?B?VHFoZ0lhb09NZkw3ZmFpS1pWL2hiZmxtMEl4K0QrNkhmLzR6SGE4dHo1djRq?=
 =?utf-8?B?Q3BHWDBoa2pUUUc2Z3M1UllnUnltKzZSVmk2RGRmSW1aYUNiQnIxVDN2aStX?=
 =?utf-8?B?TENIUTBndkZhbWx3VTRaUE9JWUp2SFlqWlY0bjFVUzhzMUNldXNQd3hvaFBx?=
 =?utf-8?B?QkdMZ1FXWktsRDduUkY0czl2cWNuSXljZHdMK3NnMG9GU0xlSE54aUh1ODBz?=
 =?utf-8?Q?jEvhihmXKqujkYqQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <734B6AE254ABE743BD9A378DF17411B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dmd/jcQPnZUX8wJdVuzO064WeqCwFL3sniNwD/A+7aYviYSIjUwB1SI1cCahOxPwt+8kbmqnhL1VHBhIeKKQ938O+bvxN+gPm78szsLW5DebONCfefasBTx+9kiBdidgiRFC+bXCQ9M4ZNng1iijJTy5T/v9C89K9IkKesAs/hKlJqRNSpQFyMH9EtbrO15MrKGURfsPp5i2ZlgLadctNXul5DBKCRQaZ4/5+XBxJ8E6SiuYuBcuXYTGfwJqYetxsAmzellNXqDelSCs1PCU7LyKFrKDNTh0X4eUC91H90eePgJn/NKlAsl4YdiICuXhsgP2HAPGo6k1XGG+v9gZ2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f666461e-ee87-48b9-9796-08df1018c8e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 15:24:34.5147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9zzpo12zaovEmbptzY2Hoz+mWYA4rlBAPcbpIZ/Bw+JMOfpjGoXyzVdqlDTCxAMnNAVeYAJZu26/CewL+OcpX6baOvVMNTYJjk1TiKxxWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4550
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTExIGF0IDExOjM3ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+ID4gUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVs
LmNvbT4NCj4gDQo+IFJpY2ssIGNvdWxkIHlvdSBhY3R1YWxseSB0ZXN0IGl0Pw0KDQpJIGRpZG4n
dCB0ZXN0IGl0IG15c2VsZiwgYnV0IGRpc2N1c3NlZCB3aXRoIFZpc2hhbCBoaXMgdGVzdGluZy4N
Cg0KPiANCj4gQXJlIHdlIHN1cmUgdGhlcmUncyBubyBvdGhlciBwb3J0IEkvTyBpbiBiZWZvcmUg
aWR0X3NldHVwX2Vhcmx5X3RyYXBzKCk/DQoNCkl0IHdhcyBhIGNvbmNlcm4gdGhhdCBzb21lIG90
aGVyIGZlYXR1cmUgYmVzaWRlcyBlYXJseSBwcmludGsgbWlnaHQgdXNlIHBvcnQgaW8uDQpCdXQg
bm9uZSB3ZXJlIGZvdW5kLiBBbmRpJ3MgcmVjb2xsZWN0aW9uIHdhcyB0aGF0IGhlIGhpdCBzb21l
dGhpbmcgdGhhdCBuZWVkZWQNCnRoaXMsIGJ1dCB0aGlzIG1heSBoYXZlIGJlZW4gd2l0aCBzb21l
IG9sZGVyIGNoYW5nZWQgZWFybHkgcHJpbnRrIGJlaGF2aW9yLg0KDQo+IA0KPiBJIGRvbid0IHNl
ZSBhbnl0aGluZyBkaXJlY3QsIGJ1dCBleGNlcHRpb24gcGF0aCBpcyBkaWZmZXJlbnQgc3Rvcnku
DQo+IA0KPiBuYXRpdmVfbWFjaGluZV9lbWVyZ2VuY3lfcmVzdGFydCgpIGRvZXMgcG9ydCBJL08g
Zm9yIEJPT1RfS0JEIHdoaWNoDQo+IHNlZW1zIHRvIGJlIHJlYWNoYWJsZSBhbmQgbGVhZHMgdG8g
I1ZFIHdpdGggdGhlIHBhdGNoOg0KPiANCj4gbWFjaGluZV9lbWVyZ2VuY3lfcmVzdGFydCgpDQo+
IMKgIF9fbWFjaGluZV9lbWVyZ2VuY3lfcmVzdGFydCgxKQ0KPiDCoMKgwqAgbWFjaGluZV9vcHMu
ZW1lcmdlbmN5X3Jlc3RhcnQoKQ0KPiDCoMKgwqDCoMKgIG5hdGl2ZV9tYWNoaW5lX2VtZXJnZW5j
eV9yZXN0YXJ0KCkNCj4gwqDCoMKgwqDCoMKgwqAgcmVib290X3R5cGUgPT0gQk9PVF9BQ1BJIChk
ZWZhdWx0KQ0KPiAJYWNwaV9yZWJvb3QoKQ0KPiAJcmVib290X3R5cGUgPSBCT09UX0tCRA0KPiDC
oMKgCcKgIGtiX3dhaXQoKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluYigweDY0KSAtLT4g
I1ZFDQoNCklzIEJPT1RfS0JEIHNvbWV0aGluZyB0aGF0IHlvdSB0aGluayBjb3VsZCBiZSBoaXQg
ZnJvbSBhIFREWCBndWVzdD8NCg0KPiANCj4gQ291bGQgeW91IGNoZWNrIGlmIHRoZSBwYXRjaCBj
aGFuZ2VzIHBhbmljKCkgYmVoYXZpb3VyIGluIHRoZSB3aW5kb3cNCj4gYmVmb3JlIGlkdF9zZXR1
cF9lYXJseV90cmFwcygpPw0KDQpDYW4geW91IGRlc2NyaWJlIG1vcmUgd2hhdCB5b3UgYXJlIGlt
YWdpbmluZz8gcGFuaWMoKSBkb2luZyBlYXJseSBwcmludGsgb3Igc29tZQ0Kb3RoZXIgcG9ydCBp
bz8gV29uZGVyaW5nIGlmIHlvdSBoYXZlIHNvbWUgbW9yZSBzcGVjaWZpYyBodW5jaC4NCg==
