Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA638D6B2
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543496; cv=fail; b=ARC+rDw1F3SCH4y2hDbI/GLGQumffTsw63o/fzrw3xNE/Uy2BW5mKF2fvtJhvV3Q1szbpSWuPAAHEpKiTZ3mlGOqWehhYf6QdKfho/Zfca6G+qh118hz062rWwDSFbswfvqfycewWNo58km6f4tYuCZiwnwKEXE3H2YDMG9I7BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543496; c=relaxed/simple;
	bh=rIccaT+VwKipJ278pMCiIUaTF/DBDC92r3sj3BVmDlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ldwjRjbSRQssvF9+s1a/uNURPtSr53ZVkJD3lP3taF1oh7MNMW3Oaa5bXN2kpGsfOrg5KHELjpaO+/GJBKByTuu5OEFx+wm83kT1XX4U9ojQPSVGHJ7DWhld5s3HLPreZhRx16K0nSqUrocE3sdvUUys6ntDXE70/lHqKRwtxTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFyaDUKQ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFyaDUKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774543495; x=1806079495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rIccaT+VwKipJ278pMCiIUaTF/DBDC92r3sj3BVmDlo=;
  b=VFyaDUKQyU7c+xVMt4syCO8RsjSpPfNFnfIPatUYVmo3SclCNb/epKrC
   oy5Zq446/Oo1bNAMaqQvjFJbVYf90WFcUCZjn1E+1Dfj2rOvGB0a4wAxs
   IHzXzKRbzYQuPrAY5vIZEAsm1ylg09pfQ2LonTK5H9eShyxPXLINtdhDv
   WgGFTi0+RYXp+il+5PO4C7hdfWnQMTDBDmtlG6ipRPmfdbWJv/sLb9Gub
   nv5+299SyllWI5KqFxmRjKqxbU4GkcGklCCBSM0SEwvYEx+cu1NubvA0Z
   RIJx695Fh/rcK1xO7aSPqVmJ7FyshmUh0I3wMzAc6fkpL0T18zf35IqH/
   A==;
X-CSE-ConnectionGUID: t1LpEqs4SWqnzko1lVt7nA==
X-CSE-MsgGUID: ibftDea/RXe98MTW+oINrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75805870"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75805870"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 09:44:55 -0700
X-CSE-ConnectionGUID: BeKZ9IELS9qgXhrG5CKH2Q==
X-CSE-MsgGUID: PAQOTfi+RwSlzSqIBZ5Qsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="255551931"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 09:44:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 09:44:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 09:44:54 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 09:44:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZI08WQ+1LjcAvcyjAnzJjocXDk+cjTghf1TmKYyPKZmRbKHhVlW792lRLxCJlL7ltqLtO3xazTrtIgGwyCWi6+egUONJosA2YcrfRj95VVCjGXWvf2tlWw+ydLIKeJdqSHWR24kNhB4AhjVkU442WVvLKlgDzTxbp+sTp2weIACfl70h8pG5+nYFP8ank89tgNInF9nou1FmsIK/fcCk9yM+1z03+zW+iYZedfQdwVaqR012AWMfHmmu5EI914Nb2Xf2dSYEVuXzU5cze17Iz0PpyJhD1UuZx3BSouHSvwBEeA4NGx9BuzfsESbGYwW7NjF+2FA4nBOqp1/gam+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCeBgW/+9Z3kR8q+u/OgcWHaFVpEq+UBKE93TxmzL+A=;
 b=Pe+93N5StFF87okVDxF1Uos3nfYNt73kTdKiFBaH+YQFD1kvomEKCLhad8whp78AkHmBi6RXwmmz7WK/TX0ii3M6Ejnrn5pRrR6AhL5aMGu/+DizVtkljra6+TsZ1C3nFAnCGlEbH7b+j1VrVDqCOywyCFs7reUJg3fpGPtcqqyU4ws81q7E8GbCJ+7bef7ylOzWjZxvfTAD/UXEwjy9pVShnInZDi0hv17o7v7BEterPO1UGyTajKlFRoX2rJdF7k0qgD23fEjfuEQXFWKzCqnEpHpMHfrpiSS3RiTuPdQChOc0egSYZMIrfk7xfUYnmu/JWLHLc0Q1VfthZRkhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5091.namprd11.prod.outlook.com (2603:10b6:303:6c::11)
 by DM4PR11MB6528.namprd11.prod.outlook.com (2603:10b6:8:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 16:44:51 +0000
Received: from CO1PR11MB5091.namprd11.prod.outlook.com
 ([fe80::2449:4935:1adc:59bd]) by CO1PR11MB5091.namprd11.prod.outlook.com
 ([fe80::2449:4935:1adc:59bd%6]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 16:44:51 +0000
From: "Chen, Zide" <zide.chen@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "Liu, Zhao1"
	<zhao1.liu@intel.com>, "sandipan.das@amd.com" <sandipan.das@amd.com>,
	"joe.jin@oracle.com" <joe.jin@oracle.com>
Subject: RE: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD
 PMU getter
Thread-Topic: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD
 PMU getter
Thread-Index: AQHcu/z9xetbS6xwg0CdGSN6kBVRFbXBB19A
Date: Thu, 26 Mar 2026 16:44:51 +0000
Message-ID: <CO1PR11MB5091E0F44CAC1B8DAD9EF085F356A@CO1PR11MB5091.namprd11.prod.outlook.com>
References: <20260325021236.14574-1-dongli.zhang@oracle.com>
In-Reply-To: <20260325021236.14574-1-dongli.zhang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5091:EE_|DM4PR11MB6528:EE_
x-ms-office365-filtering-correlation-id: d1df14a7-39e7-4d2c-a46a-08de8b570058
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Mi7Z81VENR3rjCSfkZJHpBVzcon9giqAyiz3CcWyc+boDQaCPxWwQnl5ilm5BW7O9ZcYnY237q3AOqspI2DOcTu815VrYISBGXkVh7N/GTAsFyaFnQbx0lZEG1wK8ooBtOAkgdoedB2sjHszgu6AkVTF0cPxh6ZM92lVS0wWT4CjHda+Jo/poAMeOouzBMfop0m6IZIfYzjwzxF1K3W4Fw+St4EVGhyqzOhgptp9hfwBfgSzk35b6zHDidbtG29u8Hr6kRak7ypmRFxC2UCWq+AQgIBT+6a04HnylGBiqvb572GactkTm59gQyR0z7TRpeIhUtJ5CHLxHoZx70/gr3KCblXEhpwuZ24wxmfSgUjKYxp/WAvHjtpMmdBEZgOOZ3ui53MsZ2+Xv9agLEqek/jrB0BzFi5UTex9lHrhKp11KHrXacRZQFbPNrGisyZKKCruAzsynez8MPcVsR45trvqRypQgJNT3prmf8zKo9+pb8H/HTZukqkJgTsbKfOUTgDR3fNaIxR5Xpo4nT1fulrAJLybxWRs0iP+j5JO3pzYMQRdG1dBcu9qtv3t4mOjanSRFWjVfYpy5Rq3K1DDiM//L1I11+Ey1lTPSEaJZNXMAubFIBP+mVXUg+CQkClAKVoNiGgFY/SBoE6ji7HS11FDqkG4+QYc8xCYPc3v4Byhk6eE8BtTT+XXSCZ1YI+v+yg4MF/0BjVtcG/PAs01FTgPEH5FQ3iSd3LVcpuGz0mf6We3Ni9a8QltQi1o3ro4ILa3pQMz97nGEBzJQQSBT7eW1x8y82l5ef2K3Mm+92k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5091.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3P0+j81m97529vBDOZfibfMfVOJ3mEnMjU+NCL6doqO2SwKXJOfNlL/AmsiO?=
 =?us-ascii?Q?+my49kcG22oMoYdJQXbMks/hMdHIO2AkmxkyDkOVnFswyZp8/6Qf/JI5liXQ?=
 =?us-ascii?Q?9Q1mYcv+m/HtFVy63WmhNd/1hfQg1dyt0gazHPgtmzAOh8TvpatYC2SCmnVI?=
 =?us-ascii?Q?4o9J2N7h59ytPAHpgL9FxyHvhFTsnpPZQOkBTncaH5eReYY3mdWD55tAcbnh?=
 =?us-ascii?Q?ihY+o11zcO8ye9D5C/9w9sBUX0IfWDffjL79pWy+OKxORUaXupK05T+sMY8L?=
 =?us-ascii?Q?cR/svjbAQ9EhKYhaqp/12bGcyW9ndGUODJDtb4+Bq78Gv0TSsChhZKByC0Hj?=
 =?us-ascii?Q?aCp7Aw6R5Jt3nOfp0Od5MYBbCh5JeRcp/JAOVJH3rl1/BiGriKRi/HQQlGwZ?=
 =?us-ascii?Q?NQc6MGx+poNM7zrB+/40hXc2jT6xkAJ8aqe88IZSJ9bAOu1QhBnBP5dhvoto?=
 =?us-ascii?Q?OH7K6/wVGaKKg9tuyyQH5u9/lBpFl3ZsQ2iIOVwKtdj9rlL1+dA0hPAdoONU?=
 =?us-ascii?Q?woHfzI06b1UxTZ4S6OZT2f1JE74j3+3K2rKy5s5TT0399dKEN/RpuCEUODqm?=
 =?us-ascii?Q?gTqfEdZ+wrK5vOsvhuFCLhpghInbpKCxnKpsH8sVdBelIG62TYCQsC30PqXz?=
 =?us-ascii?Q?zZUmJh+EckqBmFMC9xXwOXbzjYIRlWd5pIWdmVedgbif7D1Z+24p4Zr79vG0?=
 =?us-ascii?Q?c19Ve+CKnA7z65Fs2bNgTeN8lalFkOG/OHyvmbi/GA4zP/iYLv+pCXFbZ5bM?=
 =?us-ascii?Q?ycDg9d59zZTxRSvedIrzhz5sisNT74hNogJ5GKvIsLH2cugkHUTg11JiWB64?=
 =?us-ascii?Q?8wHiSe2fHOAgsNxRKAxLO0/cpbXTHXNbFTnipM9LjcxlU2JcXa4uPlDS/1N7?=
 =?us-ascii?Q?Lkia8ZerqG6Xemc9AjKevFF1IYKRBIgzECAPINzf+1KTW+aI7q4LZ2fULIy4?=
 =?us-ascii?Q?ZvKBDMe6eI/Ik5uOJiUr/c8fP0skI2r/Y/yniozKsy1aYkvNnkmYU8NzeICZ?=
 =?us-ascii?Q?pekHZVHg5if/aMVCD2OICczLPjINDTs9XDNz3vm7GRqqHsM6aa2nMTnelW+I?=
 =?us-ascii?Q?9/WfpR0j45n4N0aq6SlGayL9g6uR1fWQNUy+kXWJNqTi+UKKA3vISgvYwgfU?=
 =?us-ascii?Q?7/XmNP2Ogy7rb97cbznLCJ/WHHq3zXDkvkb4y1mLBMZpWVDGBNh9PMTITrmo?=
 =?us-ascii?Q?LijUXolxZAoohnxU5vqqu2qwtBT3vO7VGTH0Uo3YjMOw8So3agvFz1V7AIAW?=
 =?us-ascii?Q?uELz7tA42/x4X9kkfbuIeB1ICVCeve/Vq7sq9z7ta4N7rU2XhnLohffOp2sd?=
 =?us-ascii?Q?uR2SQGcSSjZtKqMbetb7eRuuwylXyzJRkGFbM/9BGSfSBWQPxntp00fH2H0w?=
 =?us-ascii?Q?kplGIhIPqqkEZf6QTg0Kn+5c5+azyglbnnxnSYW8vi/JVD/nWI9Y3u5kgRSc?=
 =?us-ascii?Q?+7tLSscx6wvYxH55ZgpCpDOHEHwzCedXIRWSJSYKEPwiw465FT8E8eHZ6JoW?=
 =?us-ascii?Q?1MFXbft3rgaOfhy2A2LfUt99bI9FzotIHsMn3MXlJZoNPwzsdN4w2YXXHXCM?=
 =?us-ascii?Q?MIjo8avKCmpNprlGGmfCWTovXvtZi9DeDO8QSQB0V+3J40pwNEVFPxzRl/Ie?=
 =?us-ascii?Q?pmXmMaLCysGRrByU+M/WTApcsAsX7l8uipfPJwb8aonrJ/Vdi+c7T2PIevyh?=
 =?us-ascii?Q?unfcjS9Mzu7lwtwCMv0IVhS1WF9UR+9H9jx+XpEN6UlBdw2lovaZU155DQK7?=
 =?us-ascii?Q?PQyFIoni/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IBjqI4S1Yj3xLf0NIgOxvjekY93DAyk7jCg9+1VnGdkop6YZ9XdM6Ahn+tHJ+o+P/rLJe5/EuxjhZ0nkysoBP5KivwwPUXdzGVvprgoEc/DjgzMly8TIKNNAkyutMXvPLGN4FE8muhze2PRgCv1yl9P6yCqdCThiQupZJCU7L796FgXMJ3zN/SShjy3sYugSE/QXOV32sUjWvmZwOMdLWTLio6LfStKO/uR0qTAdg+TTEv6KPK/E3J+v7RDp9k3OHMWptTRgZSPRMSmRgrJqhFXl+i2N3oh3Cf6N2AdCE9zQtUD5Q6F3GrHv1Due42nZTfsblwjL6jqttL6YF0OM7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5091.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1df14a7-39e7-4d2c-a46a-08de8b570058
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 16:44:51.7269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+DpDbaN2f9l9D4lCjlUbpXeA2UJA7n1g8NqZAhi7B2WV1Dd3ivSzztIgRV18OEgxJj8vppYP4gvDUp0T4242w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6528
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Sent: Tuesday, March 24, 2026 7:13 PM
> To: qemu-devel@nongnu.org
> Cc: kvm@vger.kernel.org; pbonzini@redhat.com; mtosatti@redhat.com;
> dapeng1.mi@linux.intel.com; Liu, Zhao1 <zhao1.liu@intel.com>;
> sandipan.das@amd.com; Chen, Zide <zide.chen@intel.com>;
> joe.jin@oracle.com
> Subject: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD P=
MU
> getter
>=20
> For Intel PMU, the counter and selector MSR ranges are disjoint. AMD PMU
> behaves the same way when PerfCore is unavailable.
>=20
> However, once PerfCore is present, AMD PMU switches to an interleaved
> layout in which selector and counter MSRs share a single alternating rang=
e.
>=20
> MSR_F15H_PERF_CTL0 =3D 0xc0010200
> MSR_F15H_PERF_CTR0 =3D 0xc0010201
> ... ...
> ... ...
> MSR_F15H_PERF_CTL5 =3D 0xc001020a
> MSR_F15H_PERF_CTR5 =3D 0xc001020b
>=20
> The commit 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during
> VM
> reset") added the getter/putter pair for AMD PMU MSRs to clear them on
> reset, but it ignored that, without PerfCore, AMD reuses alternating MSR
> addresses for selectors and counters. env->msr_gp_counters[] holds the ra=
w
> counts and env->msr_gp_evtsel[] holds the selectors, so with the interlea=
ved
> layout we must translate the MSR address back to the logical counter inde=
x
> instead of treating the interleaved slot as the array index.
>=20
> The arrays are sized to MAX_GP_COUNTERS =3D 18, so the code never writes
> past the end. And in the reset path QEMU simply zeroes everything, so tha=
t
> use case still works.
>=20
> However, the live migration is broken. The PMU state is stored at the wro=
ng
> indices, so the destination VM reloads mismatched selector/counter pairs.=
 Fix
> the getter to use the logical counter index rather than the raw interleav=
ed
> offset.
>=20
> Fixes: 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM
> reset")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---

Reviewed-by: Zide Chen <zide.chen@intel.com>

>  target/i386/kvm/kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c index
> 9e352882c8..b4e549c62b 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5239,9 +5239,9 @@ static int kvm_get_msrs(X86CPU *cpu)
>               MSR_F15H_PERF_CTL0 + AMD64_NUM_COUNTERS_CORE * 2 - 1:
>              index =3D index - MSR_F15H_PERF_CTL0;
>              if (index & 0x1) {
> -                env->msr_gp_counters[index] =3D msrs[i].data;
> +                env->msr_gp_counters[index >> 1] =3D msrs[i].data;
>              } else {
> -                env->msr_gp_evtsel[index] =3D msrs[i].data;
> +                env->msr_gp_evtsel[index >> 1] =3D msrs[i].data;
>              }
>              break;
>          case HV_X64_MSR_HYPERCALL:
> --
> 2.39.3

