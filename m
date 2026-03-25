Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C213D8B1;
	Wed, 25 Mar 2026 04:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774412971; cv=fail; b=FZN18vbL5tS7r+ne3iXTZ/G9veIn0m47Zcf2XQH+lrJopgHQzYz842meeADjZDHPDStx00cMijBR2j/OOctHmVpZOJOzsr/F55vQb04q89w1UsRs2fJDCuIBfBunLFop0Hrhiegw7n06okjYLe7Ctu3O+tjW11n04Xg8HcrHTcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774412971; c=relaxed/simple;
	bh=7aWLuMLpqT8eq7/lYg4cI7quDtY1GiuntNNupg3n9W0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTcqFb3Zx1rAfKKaJlEvGs14N+kUME/DvyD9CSvBmy0UZeqN8+zzUjOUYI4JBtcRWCHRzmvuFxEhrZfvuTUFb9stASuIGyleHLixALpbVTdu3eBQKIglTpyG3waIg7+AZUwUFYs8MKyIMg/94+t5SdQGc95lKKFrXco7kQMFH5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDcuAFFL; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDcuAFFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774412970; x=1805948970;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7aWLuMLpqT8eq7/lYg4cI7quDtY1GiuntNNupg3n9W0=;
  b=PDcuAFFLQcVTQMmcXpVefo+aOV668QX3G/gjJyb5TVDAm1Ih8I3kO65b
   bxhIallzVs95nfLEaB9+lm/V2LRsPe847GdeI4TmLYzmPtvRMrzJ+vdwp
   75/22OBMb4DxkQZywwx+cBCULzWlOtvGn8EEzTqfXoCBBWJSIIyIgsnsD
   T+OM+DqSVNWmfy2b3Y0Rkez12doeq+nIDBWXkRnHbUcQ2/QsPEZxFUy9O
   gG3DWyCd+mm4E9Dy7A5LgA/7xwKHsSraafY/WApJU0ZA/PXM4W5BbMYdr
   MS937Vr4AsQdnD6ISrBaYfSb/Q32AVXJX/Jwux7gmqD3WHeSpHqB1d5KF
   g==;
X-CSE-ConnectionGUID: V8C3Me6iQV+7ZxR54AAv7Q==
X-CSE-MsgGUID: 3H754OvIRlOpBQDKK50jsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79350839"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79350839"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 21:29:30 -0700
X-CSE-ConnectionGUID: DbmTxujFTHetUS9NwyRrtw==
X-CSE-MsgGUID: MoLi+pZgRlGyA7lLqOU70Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="228630903"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 21:29:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 21:29:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 21:29:28 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 21:29:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DM50eEgmQ8ueCeaQ54X1e3uFteIqio0ILU4M5+JxWe1rY0WO7jFzaXpWe0/qGu7eqxEFPDA1ckUrF4CtFlNkuQWk+bJjhLETFmiFSFKJKld4S8VdqOqv6L5qhS16+vHjb/FYDgwkSbsSMTgY/Ci5yNPtjEDtglp8mL2V/RrKsBmReFMfJd+QJ553GzhWlKA36c2kQcRO/Qy2FgKFubjC9LXzAd8Qevvr1IodfKErdvbVcGoJpHZjzB3bv5c5pWXNpyXkn9MRI0M0YBARkhODGMeW4AKM00yXNgtTMI5DeIMpPuyiO1XM8RK/HjogW7WngMfC0WKHASKeIA8am62Z+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aWLuMLpqT8eq7/lYg4cI7quDtY1GiuntNNupg3n9W0=;
 b=bLYsrOTnPmXILumg674xdb3pyQegg0lW+tiD1cStkCPHye5HULRK7Iy0Bj1nLEq25a6fFNOFiNTSlf34898G5oFHoYywfxL6fTvCf0fyL7wuCIU38fV/uaRokHW/nUPpl5wigH9MVd+p/mBoPUOppUFPWnPIXAUhllaRfXBENaC/Q2m953Fd1wdX4AyATBqRLwiHRkvoibCzGM+3ixWkL8hI03xCDeXVkvwQIVCzZQ+7dl5g/A2EFMoRQpFLCNxrTUw42PXXzAb7wxzBfRYUk5Uv3Z/5E6J7p/VH2rl2a/q4M/M7OF47Bd0q1R0caB/PgF1f2qHwfTzuoPocsEFy0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 04:29:25 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 04:29:25 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "amit.shah@amd.com" <amit.shah@amd.com>, "Kohler, Jon" <jon@nutanix.com>,
	"seanjc@google.com" <seanjc@google.com>, "mtosatti@redhat.com"
	<mtosatti@redhat.com>, "nikunj@amd.com" <nikunj@amd.com>
Subject: Re: [PATCH 01/22] KVM: TDX/VMX: rework
 EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
Thread-Topic: [PATCH 01/22] KVM: TDX/VMX: rework
 EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
Thread-Index: AQHcuMcixHMMJfGGlEKdps1Thzyo6rW+rluA
Date: Wed, 25 Mar 2026 04:29:25 +0000
Message-ID: <58010441d334fe400d292a6ec53cccb568f4e4c6.camel@intel.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
	 <20260321000931.1947084-2-pbonzini@redhat.com>
In-Reply-To: <20260321000931.1947084-2-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH7PR11MB6498:EE_
x-ms-office365-filtering-correlation-id: f72b6b78-aa99-465f-a4aa-08de8a2718d2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: YKyBPn4ixgXvPzn866jTETo9JGTDMRWUXrWGlsji0LK/6E1fw87XHYCCo6rbFARVVLWiqjzGDnAu+QxRVcJvfWpTUlega9O22oAhRtZopn13EM3KzE6T/r4u6W7SMkiaIpKyG5Cj6QzyoKyTtKOXxuBZR7mbtRmOmzwFZKONn6vjDrGN4Zuok0NKB6uvEEFZvSFlLNFuDEtGs+GZVHLSpA1c9IaoveoDxAhX4m6nm1VxyP9zFJv3gLc8r/P2AV9/NLzh1vq3gxfkbUBa3E94jSF2o185ZtHXFIJRW42vtYaav4n6R6N0/5nFNJD39W/4GlHKHy8juU9cqcD4WMeHs/Sm5S/7kisT2Z/iWGscUdcWbQn7tKRs+Tvv0wIPJ9kdmoaYfXg/gSApyiODAIK0z/lv/3Zlt6pAg1p02AYnYiWYCpcUViXtcX2hLswX5DxKUe/ib0wH2237fQrm0gkMiQZTH8we6zdQ8jimkwSMC/06XK+SkG2ovonMpQyjkBBH/v79y0RRoF0jyGFfTJgNP0MgvnO21JhO78am60NAfLmxq1U+qpdWcUalNZHsmxLutQtSqmsLI9Pb4LFNz9MGOxKzn76XFrPsXQWiZgiMGTGXIidBtb0PWZ3hBEg3ottef1QiBfRhJNIjViNp+xpnxFAf+zwHWv4qKpOqwTfKZdIyIEL/ytMNoDzWEspTT/t2V8JBiNXDTpWEVihIO7JgMGYVxvNBFkquX4OtCwtuoBT4dfvNhX4KxhCbr48Gyl8HEbj5qdIcJXlmA8RHQm/cdwpZ5ycXmezWPqs48FPA56w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzJDY0xtWFJBZTFBcU5QQWk3TWJQSUVhNDlSNktkajJvS2hrd0podXdyV0JI?=
 =?utf-8?B?UlpnZUw5UlRrQXRoZjdrYVFVWGd1TWFWK3VzeWRDUVhqM2xYOFpoMU5qSDZO?=
 =?utf-8?B?WmVVRGs1WmRmY2h2MjlHNVgvTDVweHBPclpJaFZ1M2dLUVNEL0pwRGYrc284?=
 =?utf-8?B?RE5VWlBOK3Q0VUE0RHY3a0RzclVlaHBIMStIMmtud2tyUHR2RldRRFNsWUpZ?=
 =?utf-8?B?OXJETVJCa0pyTlVQWVVaRVRya2FuTUJjT0NrUDN2NWJJVEJiZ1FuSmU4THB4?=
 =?utf-8?B?VEh3K09lZGVmTW1RWG9IY0k3RnYvY0RINEQ5bk1KdFc2UGNXeVJ6RVNyQ2hS?=
 =?utf-8?B?UkVrK1ZJTDY1cWZxaTlEcVlVUjV4UjE4RlpMZXFydExWNjlxN3pvNkNOZElX?=
 =?utf-8?B?UEppR3puT2hUenhCOVB1aWk0dWhzdmpab0I0aFk4djNtV3d1WmQ4dGx1VFhC?=
 =?utf-8?B?WGNRc1NiMVFkaTMrVmNkTkEyV3E5aHBieThubmVFOWNWNy9laHhYYml1cVRS?=
 =?utf-8?B?OUtXbWhKVEJFWGd6cG9LK2RrZEl3TlNiZElvRFdXQWRXdXhIcDVPVXQ2MmZR?=
 =?utf-8?B?eU1lVy84TFhJZ1RPcGs0Zjg3YXh5S3hWWWZxdGFTS2c5Q0c4S2xQaFliSTVi?=
 =?utf-8?B?UnVVa001WkFueURQc0cvT2d3b2twS0JWZ0M2Q0dNSkJCMEMraTZPZjI4QlpS?=
 =?utf-8?B?SnpKWVp1enpGbFRjQVdLZlFZS0JWOUJqTzA4STRuSlcxZmluOUd6RzljbFR2?=
 =?utf-8?B?M3RzUnVydjJSRDJSMDFsQWoxdWNEOC8ydXVrQmhFZkc1RjcyUUlMeXJtVmxu?=
 =?utf-8?B?aGkrNEdHb042T1lydEliQ01vSTFIcElOa0hyM3A4T0g5Y2tsRXRwS2pzTnZG?=
 =?utf-8?B?eUpJVk9OSXdEM0wwdzZISWFVTU9VdnBLNGt0UHFYSFdNa2M3cDZ3c2lPalVy?=
 =?utf-8?B?Zmp0d1FiZ1Q5YlVQZWR3RFBNemV0UzVmM3pIeko2ejFhdUVWaVRZSGdBUkxP?=
 =?utf-8?B?TWFSNWhSVXp2eWh6bVVlTEd3OFFjTm1xWGdUNWxiRi9pSVVPNU1tQVBPY3di?=
 =?utf-8?B?MUR1YVRqNXdLdXRpY0VRUzFlRlI3N2xpdW9RS0pPZW1QT2hXL2lFU1pkK0hj?=
 =?utf-8?B?dGpoRlc1d2gxbHBKcWVOY3V1b1dzUGhkdXZTcm0rckZMQVZxV2lWTGIrcVR0?=
 =?utf-8?B?SG9sNHlTeTlBNHFMcnRoMENOZnE0L05lRExkelRyQUg3aDc4OHpjdUgxclh4?=
 =?utf-8?B?UDZqcDVIdncvOG9uZG52aEg1S29hYW5JUWp1Rk02ZjFVNS9HWHo5UHU2VU95?=
 =?utf-8?B?aGN6elVtZXFRb0UxajZsbGxwZGVOVUlLdkNwT3lvK2hqYklrMGc2ckVPYUFs?=
 =?utf-8?B?OHgvWUZOQzJ1dHNQdlo2Ykw3SHRocFoxQlh2K3loRGdWQ0tFWG9RdUlOOTFU?=
 =?utf-8?B?VUJOVnVMbmQvUVBSUmtVV0RSYWlZbWFFZnZJenMyVUxLOTl0eDZJMDQ1SzNj?=
 =?utf-8?B?YUk4TWtBVGx4ODBFTDJwUUltK0ZXUzl5bWpZSDdRUnNxRGVheDJKNnc0OWs4?=
 =?utf-8?B?eEZUZElNelB2TGZMMFN5MWFoMENKeU1qcUQ3Ri9yQS9LQm9meUZONi9tNmR3?=
 =?utf-8?B?SEl1cmFGMUo0MVlnYVlMaWZCM1RHWnh2UERBbnhZQ21zSlNsWDNsdXo2RDBa?=
 =?utf-8?B?V2ZLNGxnb3kxN2VrL0JpVlNrZUVMNUtqSjl6QitCTmx4c1RPaEtxOHRyeDlB?=
 =?utf-8?B?cjRDa0dQbWxNMzRuQldKcWJoRGhTUFhvRjNnMnRKdkhia1NGaW11ZlpyajNJ?=
 =?utf-8?B?NUhOa2FlVlhsMy9kRlJEQlNIcGRhZmhicnVTeE9FQ0tUZlNKTng2Z1JWZkdB?=
 =?utf-8?B?S0NnRGtMa3dPOGFXYlR6MWtUNmJOTEpLL1BjcFdwck5WcDBZK25qdmFqM2tw?=
 =?utf-8?B?OHRZa0FPbWRCZ1NsMlhqUmRqaG5tOXJKbWFpZjBXUDY5Ym5reDZ2cXV2Tk9y?=
 =?utf-8?B?VVJaRkJzbmcybjdnVnNjTTVWSmc2UVBIZ3h6TWlxOEFUbndFNytXY1pkWC8r?=
 =?utf-8?B?blpPNmduOWk4aXAwbkE3WnBjY1g5L0YwVDVwc3dSSnozL1c1aU1GVHovTytL?=
 =?utf-8?B?cExtUVM2K1l5VUpIcVltL0xuUEtTWCtNWDYyNWJOWGpRWjZFNTFENWZzY3NP?=
 =?utf-8?B?OTRaRHp1enBaZ2VwYTc3N1RCUkFvaEJGZG9ubWx0Y3p3SGVmV0U3L0pnSVcz?=
 =?utf-8?B?RHNRUVVQNkxONEJ1ajJNNHpnV3BKRU5EMzQ2WFFXYTVkOHo3R2JKenR4QUIy?=
 =?utf-8?B?S2REcDJRRW5KYkFKVTVLUEFEdVIybTZPY3JKY0xJSzBVcFVxdHEwdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CCFB84CEC675749B682B56301EB7A72@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aFIuyzgIb4/B/dQzUe2szDiQmoer9n3+FSkQeEWO7QHhNC3Y57SUjpkHvew1R1E3t3ffl0vDM66b+CMlkT5RvKCHSuIcTndJDv5+cxZLWxp2+uYVdoT7XtttE7SWTQ95+/M/nvRB9vEg4ZGbLP1HPPGYWUrtyLlcRxASJFfbC++3DHPEEPefAB0979CNQ0pjA9k51Qzt5M8vwV2gEFipKShsLOTeaeZZblAgRTpC4/758TUEQk6O8Ifx/TRAtfqGes5KHTv5wPs6w4iqEnJubIjN0c6iNW/3qoOm9PjrRrZtZ2/+D2KQxWsZwPQ0qjyvWY2zuBmGEymEX9fOBHtzig==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72b6b78-aa99-465f-a4aa-08de8a2718d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 04:29:25.7559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQa44dRQWRURnYU5qq8n+aov3QIQIzwTHUx/HMcOcyhoeYZNHlspQMqSLwbT/+U6MmUDaeDoJOVtNDN82H0Kyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6498
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTIxIGF0IDAxOjA5ICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBGcm9tOiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+IA0KPiBFUFQgZXhpdCBxdWFs
aWZpY2F0aW9uIGJpdCA2IGlzIHVzZWQgd2hlbiBtb2RlLWJhc2VkIGV4ZWN1dGUgY29udHJvbA0K
PiBpcyBlbmFibGVkLCBhbmQgcmVmbGVjdHMgdXNlciBleGVjdXRhYmxlIGFkZHJlc3Nlcy4gUmV3
b3JrIG5hbWUgdG8NCj4gcmVmbGVjdCB0aGUgaW50ZW50aW9uIGFuZCBhZGQgdG8gRVBUX1ZJT0xB
VElPTl9QUk9UX01BU0ssIHdoaWNoIGFsbG93cw0KPiBzaW1wbGlmeWluZyB0aGUgcmV0dXJuIGV2
YWx1YXRpb24gaW4NCj4gdGR4X2lzX3NlcHRfdmlvbGF0aW9uX3VuZXhwZWN0ZWRfcGVuZGluZyBh
IHBpbmNoLg0KPiANCj4gUmV3b3JrIGhhbmRsaW5nIGluIF9fdm14X2hhbmRsZV9lcHRfdmlvbGF0
aW9uIHRvIHVuY29uZGl0aW9uYWxseSBjbGVhcg0KPiBFUFRfVklPTEFUSU9OX1BST1RfVVNFUl9F
WEVDIHVudGlsIE1CRUMgaXMgaW1wbGVtZW50ZWQsIGFzIHN1Z2dlc3RlZCBieQ0KPiBTZWFuIFsx
XS4NCj4gDQo+IE5vdGU6IEludGVsIFNETSBUYWJsZSAyOS03IGRlZmluZXMgYml0IDYgYXM6DQo+
ICAgSWYgdGhlIOKAnG1vZGUtYmFzZWQgZXhlY3V0ZSBjb250cm9s4oCdIFZNLWV4ZWN1dGlvbiBj
b250cm9sIGlzIDAsIHRoZQ0KPiAgIHZhbHVlIG9mIHRoaXMgYml0IGlzIHVuZGVmaW5lZC4gSWYg
dGhhdCBjb250cm9sIGlzIDEsIHRoaXMgYml0IGlzIHRoZQ0KPiAgIGxvZ2ljYWwtQU5EIG9mIGJp
dCAxMCBpbiB0aGUgRVBUIHBhZ2luZy1zdHJ1Y3R1cmUgZW50cmllcyB1c2VkIHRvDQo+ICAgdHJh
bnNsYXRlIHRoZSBndWVzdC1waHlzaWNhbCBhZGRyZXNzIG9mIHRoZSBhY2Nlc3MgY2F1c2luZyB0
aGUgRVBUDQo+ICAgdmlvbGF0aW9uLiBJbiB0aGlzIGNhc2UsIGl0IGluZGljYXRlcyB3aGV0aGVy
IHRoZSBndWVzdC1waHlzaWNhbA0KPiAgIGFkZHJlc3Mgd2FzIGV4ZWN1dGFibGUgZm9yIHVzZXIt
bW9kZSBsaW5lYXIgYWRkcmVzc2VzLg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9hQ0pEelUxcF9TRk5SSUpkQGdvb2dsZS5jb20vDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFNl
YW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBK
b24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+IE1lc3NhZ2UtSUQ6IDwyMDI1MTIyMzA1NDgw
Ni4xNjExMTY4LTItam9uQG51dGFuaXguY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQYW9sbyBCb256
aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiANCg0KQWNrZWQtYnk6IEthaSBIdWFuZyA8a2Fp
Lmh1YW5nQGludGVsLmNvbT4NCg==
