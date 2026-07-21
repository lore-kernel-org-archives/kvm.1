Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259433368B2;
	Tue, 21 Jul 2026 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652243; cv=fail; b=pp0wDoUY66zOoYK+fUUHbaZPe1ZK9+NZlenwSjgyWIqcDw0MKyvt28FD/oRUk8QHi0SqVCTdO9Vtmr2SWY0tDqzy6TjURYtJULNTi34GDX+oSdo5t23Qhmm1FVqn0nQe5y+2prALFTT1iaXyteh1r0/FVcaoeVNscHpy64jnni0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652243; c=relaxed/simple;
	bh=XH7vhryWY714lsBBkPu2YODpIMdJrZB3tnm3llrKgjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=co6RtH6nKkQ4XPZavgmJiKLDGMtByGTErQKhMX71XjFMAYPkgO6tS3yaS1oq+mfYhY+Vmpfm+4QAONyc40ypqy+i7IHQtDjNDV92euVwxamsVGuKVL8RAAP41eWYptepTiJkTwnn6HPZRMC1Ld/Q0EZ3sSbrU6vZtcyOGDnyRQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WoMJqOgC; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WoMJqOgC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784652242; x=1816188242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XH7vhryWY714lsBBkPu2YODpIMdJrZB3tnm3llrKgjU=;
  b=WoMJqOgCTfR3dVB9Dh2nt58rTeKNHbERk4TEmUJnk1BpvI/T4rpinDGJ
   c7N+oWpFNGps4arB97feGvjMOE8GfpJMXZdeB3N/bWA3ry8ik69X9yesC
   MoPay0LjYQ/6SpWyptLxf+lV4zOAVWQoFLOBLI+GppEmOLoRyrWjvWWr8
   VZ/TL3SSPOmrUkxUyuD3oxpNT/8JN4i0k0gjBKnybHYIU9Jh5TUKS086C
   Tv5/MFcrGtrqr5q9Wb/wUzeLd44CI6vH9ChgrzyJd/B06g4XjV+LJlEAM
   CG8SIH2rkOnqHjaPqWO6wiuR/iNaWbdIp5YNKBRYy7RsP2U172dD2as0N
   g==;
X-CSE-ConnectionGUID: xWicCC36QHOwO+2SaJqpnw==
X-CSE-MsgGUID: p6MyUSEhTQWN+i0V5Pjp/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="95623872"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="95623872"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:44:02 -0700
X-CSE-ConnectionGUID: Xrqa4eweSGiWTVwjuo3wlQ==
X-CSE-MsgGUID: BQdCZpjAR6iEmC4TBKWgNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261596794"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:44:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 09:44:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 09:44:00 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 09:44:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jzdjl8nJw/NHNGzC/WuLJ74foc8/1ezuCqJtam2v/c3GG/aNWIXq5mXmQ8yd9HE9yDh/QHZgmwODLWY1OuEtrneDbzhJ3kmwsmrRlug1EvO+xnMEJUMxegxcDDniZeCBf9qtTRBMrq3K4p/h6twXk9I42zGoTkTmYeMIWq9IzzN1bxNtYfYicmPDAl9AB17Zn6+dP/AXa3IKO9HiaMMR9ljZUZmukV8lOgiexTI8tkoEnsJtDHYFCdAcUbQCLLSMKrsczcolneHYS6WavgSAeW4uCUBV1OCtZguKrEDzgXl4iKvn2+593PexgX/htAJa7BsFbRK8jBP7IKFTJdJP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH7vhryWY714lsBBkPu2YODpIMdJrZB3tnm3llrKgjU=;
 b=fyr1Tiaa8QKZfBqbVKmxDlrz3oTB2KQa8V8snKgYA2UapJmr9uI4YQ3RXfIAlvpTp9mCs162C+rggYwv/QCy7klmkZx9ttymHEILUMfVOdTma0pyDaAacAiktnlFgWe0CrluYPM9rgdW5l+QgfLE0qrk9mPDMCLSzkoz5rNhC8QkbKTbZr254VmvXEg06mTuK1RF/5lC2U9TTid6EtP6cWYjELBBXuYv7mw+Z+IaIPRAOez2GwqED3euoAlOjYhB/3ZltvuM3xgfKnMVj5hzaewhL95OrThOiYbpY/CxlH62n2j3tTtJeUIY9fE9+SYovbcxnQXUZ9J+v92I/nwfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW4PR11MB6572.namprd11.prod.outlook.com (2603:10b6:303:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:43:57 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 16:43:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Fang, Peter"
	<peter.fang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "hpa@zytor.com"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v2 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Thread-Topic: [PATCH v2 2/2] virt: tdx-guest: Allocate Quote buffer
 dynamically
Thread-Index: AQHdFjVxGm4rX73UokGVasXeUtNPEbZ2bNeAgAEgy4CAAHUlAIAAMQwA
Date: Tue, 21 Jul 2026 16:43:57 +0000
Message-ID: <741eb8b8b83dd10d39f304133a7625f4232ab793.camel@intel.com>
References: <20260717214349.4075994-1-peter.fang@intel.com>
	 <20260717214349.4075994-3-peter.fang@intel.com>
	 <51059852-9a10-4735-a81d-003b4b1963a6@intel.com>
	 <20260721064907.GG3178326@pedri>
	 <d88fe58e-5963-49a5-86a4-6a9779d06109@intel.com>
In-Reply-To: <d88fe58e-5963-49a5-86a4-6a9779d06109@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW4PR11MB6572:EE_
x-ms-office365-filtering-correlation-id: 46feb2cf-72bd-4956-f41f-08dee747427e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: KT7gxMvRmA8TWMdTltuVHz/5mDL3aRHjbFRvhpm58oKxJXGajBdU+cDg+taOKBY288V/tcg5nvWHOQ6cqG1m7UPV9Yq5h7050n1rcXRgfRXwgNtBm+htCDZ4LGwlz5nzBfT0kGFYS/Qu3UH8VSuaeF0bmFr1vNettJavub8Sd5dM+aWiw7e2E/wlQ2Weuq35j8jW2xGqvAzrgVDBSft4L75r0MN2CulSsor0kZqMx/IpeOGYm1kD/LVdTtrElZfX7kR6ZQGJK3aoIQuuNBvh16uZkdY60CSti4yJBzIQlhzUxQnTuGBJU7uuAMEB0iNKeyZoKgFRzkC8c7ZmtSagnPaqRzdAc5jejJ7KjQvsN6giffEZYUDSfwlc4SJJGjSotwGZQ6RWOS+LRFKhxHZtRbXfY6864Z+JG9y6t33GBF7tqot9uAdu6gl8rQVyw8XzMuKt3k6MfIC3+GjTjSS7xOolGdmF80yp1FHcPK4u8dLdaE0pCD4j+qQgk4hINiiWts//mwUNhUFjDvwMmUFa6vim7YkVdWI1Q+aDAnDpIdpdLqL3rtfwWNcSIo14IbsqUpsC24RzrDJNdDZ8OpUQJgGI5VIAz45SSo0zd/ZmYH16prxXac5cknFcLNq0D2BMQ/yG8Ou0wytFdNYl22dWAq1BXHyCu9sL7zWF8xrveGFKjCbGFahaWNZExPbT5kRhT/Ou/s6T5WNQf2dB6itSDM4u7R4Mib/r8nTgQXud2vA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlhqYk5ESmZMR1JLbzErYmJiVjNqakRoZjhyN0FKRm50cWJyMlgraTBXMVU5?=
 =?utf-8?B?anpvYzR3bTNuYU5LUUh1VjJFcjRLeXJKcDYzR3F6SEp2dmk4bUx2ZzNHa3JR?=
 =?utf-8?B?MGVJODlFWGNBV1gzNUcweDdiOFpNYXhiejVxMnd5QitJOXozL0N6eXRXbGp0?=
 =?utf-8?B?UXRpVGE3RGRuWWs1Y01Td2V2K1pFVjRsOWtxVE1HbkhQUklpanNJTG5XVXUy?=
 =?utf-8?B?M0xSdzB5Z2xzV0M1QUZIZ0tacEJUcUYvOFJ4bi9GV2psaUdBaklKaFUzSGhr?=
 =?utf-8?B?dzlXM1dJMWRKZlAzRkFTU0NlWTZ4dm0zNThoUEhBdmlmWTBxTXcvSEtRZ0Rw?=
 =?utf-8?B?ZFpMM3hmYUQydE5XQi85bktQTWZ6b2VDcE5tOW80b1lrZVg4cXRKSi9hdXZo?=
 =?utf-8?B?Q1JxR2g3THMrR1R0TGRrcm90cHFuZjNJL0xjdld2T1RnMVRWMk9SaGxqMGUr?=
 =?utf-8?B?eExnc21XcXNrNUpFd3lHYThJSGY0bDhiMHhnNEpPdEkvNnZxSE5JMVRBeDJS?=
 =?utf-8?B?NzJ3WFJDWVhSanNKMWhMdkZyL3dnTlE2Ylg0OTZkcUM3aEQxQWdyQit2VEZ0?=
 =?utf-8?B?OWVPRnQ4Q1pocDV3QmRWTXYzNmxTTUsrZkorMVhaN0hCZmNWZUlCaXZqR0lX?=
 =?utf-8?B?RzdWWXFXWHFva29aTGs0M1ZkaTJyU1ZldkdXRE5jT0lPQ2xXQkx6VE0xd1Jt?=
 =?utf-8?B?ejV5cmhXNTl2ODFiUS9CalAvRWIxR3pxbWlzNW9JTkRwNUp6MmsrN1dpd215?=
 =?utf-8?B?OHVXYkg3ekVQRlllRVF4SnppVDdBV2Q0b1VFeXlZaVZXRElHRHpmQm1pRGY2?=
 =?utf-8?B?ckQ3aFNNN3hIbE1CT0ZnQXNkemZOSmYvSXVwbURBVXhyaHdCOGF1NFhlcHlj?=
 =?utf-8?B?dTM1TVhWVTlGaFhpaXFVRWwrSDNaNlhUL1F5NTR5enZrbnJFYldZUE5IUWhP?=
 =?utf-8?B?SjUvVEdHVGhKQmtlSi9xYU11bnByRXpGVTY3WExSdHVtNlpIN2NFMFJtMExp?=
 =?utf-8?B?dEtEMkJPWURzV29LY1BvMi9EYkJWRE5EMGY4dHYyTVA5NDVHYWlYSHBXVDMz?=
 =?utf-8?B?QVBvajlIZnVkU0ZRZjBFR0hCbFVuMVlmU2plSTcyYUYzR1ZzS29BM1dKNS9L?=
 =?utf-8?B?cEpSNkM2ZG13UnVJNW1TYUlKWlpBRENQSkdRbjlhaGx1S1VxOEZJOEhFR2VS?=
 =?utf-8?B?M3gvY2lqM0l2YjBETFRIaXFHeEhERXNLZnRGcUtRT3krWE1LMnJxUExMYWx0?=
 =?utf-8?B?eUZVaWd1TW9NbG5EV0kyOXMzZWpNSHA4UW9CVU5GUzVkRm4xQmpaVHF1cXlm?=
 =?utf-8?B?VG1ydkpqYXNQZ0F6cWVJOTNYTS8xdGJjSHFqck14QWJuWjE1SkUyYkVmTjVR?=
 =?utf-8?B?SkliWnI1SWg5bVp5blFPL2Jwa0QzTUNEOGxhckZnY1ZLTXZtUTRwcFJGU0dQ?=
 =?utf-8?B?Z1lDRWVSZnQvSGZDbFhhOVRmb1ovTUNjazRrUFR5WS9LZVgzS1JqMEtCbTJG?=
 =?utf-8?B?YkVuQkZCVmwxS0RnSDVQTi9BNi8xdjRXZ1dSTFF5TGhtU0g3WVhpREQvaG40?=
 =?utf-8?B?dDMyMXpDd2ZlUHIvUU53aXB4VGVXREF3eFZ5THdXcVQrR3l0b01WaS8wSW1X?=
 =?utf-8?B?NXZHWENXY2orcXAzWFVuVWY0NjRnSlJ6UTRVVWV4VVFVVEh5RWpkV3o1b05I?=
 =?utf-8?B?RXQzLzFFSXJVcysvY2Vldm1HQnZ1NUxySXFZd2w5bEMxdzhLdHpLeFB2L3VF?=
 =?utf-8?B?RHRKcW56aUpoWlBvZ2RWYWtxUzA2TDRvbUQ1ZmR1MU9ob0xFd3Vma2xpaEV3?=
 =?utf-8?B?YmFEbWtpYUV1QjdmL3pDQlVxV3BENEVncTdzN3JadnlKRHhQcHpoa3dNTlFR?=
 =?utf-8?B?c2tObzMyV2ZWV1o2Y2pkS0U1a1VFYi82S2VCL0s5bUMxQTNoMWhJTUpLRHFY?=
 =?utf-8?B?Y25GZ3FicEFtTTBoSDhCemdYVmcxV3d1VmJGa0NsQ1ZpdThVVGRCTVQwNzFu?=
 =?utf-8?B?Z3c4eW4zUXZMdkJkNDNwSWx6K2hJOG10dExyT1NPaGF2SFJyOXNBSy9zenAy?=
 =?utf-8?B?WWV0TzVMU1R1NkRLd08vQ2xXMldkSUtjN2VsbVlCNU1YWlNWMlFnTC94TEtm?=
 =?utf-8?B?Y2N3cjZMZDNZVUdHSGE3NHkvbGptVFRCNTEvTUFKOEpoUTA0UE1QTGNMMVhX?=
 =?utf-8?B?czNucENrdDRDeUIrWDNHNjNGQ0hTT212TFlNVFFyTGQwb3Q4N21lWFJmSmxl?=
 =?utf-8?B?UURpQVdJcGtSTHp1cU1DNVJGWG9lSXN5WXh4OFMxNWFvWWxrQjl0WmErQmUz?=
 =?utf-8?B?MzBmQkt5bnBVVlMxTTluUjlWR0V5SmNhcTVzcHpNbWVsSHJob212WUtJVkRq?=
 =?utf-8?Q?IvZyyzTtj2E+EXq0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A44738C9239E0C4692B51A6AA6A35797@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k308AwLaxQy2tqxOaXD8eGIQlTFqPZn3HgPRtdP/chUjeFut0ShxH8WzAdCm4AN1pyNWb9MQ+K4BvuOrEJwkb4LZoD2aAgOU3rs7YFo58S110roZfmAbZxMgtpSADSSHkeoxwNYQT+Tl83vD2qmtPLOMJJsrnqi7LfFW4lvqrYvvQ2sPbChp0mU2BkLZki/5T6WYSZhMzIPk95QCc1pVLyU817DVQKg1572RyHgov3IDUgqg3vi3AYAUj3GaJb0pzfh3gwZXWtPwCa7qqpvfl1TyTCuWA2JjkjZ1wP4jds9UCOpg6thMynIrNLGJSIuOgf2MZtikcExQisPW2bjdkQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46feb2cf-72bd-4956-f41f-08dee747427e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 16:43:57.6888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9/Qb1S1gmOtCJXUaL1z1ewqAUU5EzIa8E3Jg6hDcJNsHGtfJIY7fuWh8N70R80XVGiqYGHSW6Zrbl4UwBPCQBG/1pzMDkhEe/vBaueKqX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6572
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTIxIGF0IDA2OjQ4IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
PiA+IFRoZSBob3N0IG1heSBiZSB1bnRydXN0ZWQsIGJ1dCBpdCdzIGFsc28gYSBjcml0aWNhbCBw
YXJ0IG9mIHRoZSBzeXN0ZW0uDQo+ID4gPiBBcmUgd2Ugc3VyZSB3ZSB3YW50IHRvIGJlIGNvbXBs
ZXRlbHkgcXVpZXQ/DQo+ID4gPiANCj4gPiA+IEkgdXNlZCB0byBzZWUgbGl0dGxlIGRtZXNnIHdh
cm5pbmdzIGFib3V0IFRDUCB3aW5kb3cgc2hlbmFuaWdhbnMgZnJvbQ0KPiA+ID4gcmFuZG9tIHN5
c3RlbXMgb24gdGhlIEludGVybmV0LiBNYXliZSB0aGF0J3Mgbm90IGhvdyB3ZSBkbyB0aGluZ3Mg
dG9kYXksDQo+ID4gPiBidXQgaWYgYSByYW5kb20gZHVkZSBvbiB0aGUgSW50ZXJuZXQgY2FuIHNw
ZXcgb25lIGxpbmUgdG8gZG1lc2csIGlzIGl0DQo+ID4gPiB0aGF0IGNyYXp5IHRoYXQgYSBiYWQg
Vk1NIGJlIGFibGUgdG8gc3BldyBhIHdhcm5pbmc/DQo+ID4gDQo+ID4gVGhhdCBtYWtlcyBzZW5z
ZS4uLiBJIGFjdHVhbGx5IGFyZ3VlZCB3aXRoIEFJIGFib3V0IHRoaXMgYnV0IGl0IGtlcHQNCj4g
PiBzYXlpbmcgdGhpcyBpcyBraW5kIG9mIGxpa2UgRG9TaW5nIHRoZSBndWVzdC4NCg0KQSBndWVz
dCBET1NpbmcgYW5vdGhlciBndWVzdCBpcyByZWxldmFudCwgYnV0IHRoZSBob3N0IERPU2luZyB0
aGUgZ3Vlc3QgaXMgbm90IGENCnRocmVhdCBtb2RlbCB3ZSBzaG91bGQgb3IgZXZlbiBjYW4gY2Fy
ZSBhYm91dC4gSWYgdXNlcnNwYWNlIG9yIHRoZSBrZXJuZWwNCmRlY2lkZXMgdG8ga2lsbCB0aGUg
Z3Vlc3QsIHRoYXQgaXMgaXRzIHByZXJvZ2F0aXZlLiBBdCBtb3N0IGl0J3MgYSBmdW5jdGlvbmFs
DQpidWcgYW5kIG5vdCBhIHNlY3VyaXR5IG9uZS4NCg0KQnV0Li4uIGRvZXNuJ3QgdGhpcyBzaXpl
IGNvbWUgZnJvbSB0aGUgVERYIG1vZHVsZT8gSW4gd2hpY2ggY2FzZSB0aGVyZSBpcyBubw0KaG9w
ZSBvZiBkZWZlbnNlIGZyb20gYW55dGhpbmcuDQoNCj4gPiAgQnV0IHRoaW5raW5nIGFib3V0IGl0
DQo+ID4gbW9yZSwgdGFpbnRpbmcgdGhlIGd1ZXN0IGlzIHByb2JhYmx5IHRoZSByaWdodCB0aGlu
ZyB0byBkby4uLiBBdCBsZWFzdA0KPiA+IHRoZSBndWVzdCBzZWVzIGEgYmlnIHNwbGF0IGFib3V0
IHdoeSBhdHRlc3RhdGlvbiBpcyBmYWlsaW5nLiBJJ2xsIHJlbW92ZQ0KPiA+IHRoZSBfX0dGUF9O
T1dBUk4uIFRoYW5rcy4NCj4gDQo+IFRoaXMgZG9lcyBzZWVtIGxpa2UgdGhlIGtpbmQgb2YgaGln
aC1sZXZlbCBURFggcG9saWN5IHRoYXQgd2UgYWxsIG5lZWQNCj4gdG8gYmUgYWxpZ25lZCBvbiBh
bmQgcHJvYmFibHkgZG9jdW1lbnQgc29tZXdoZXJlLiBUaGUgYmFzaWMgcXVlc3Rpb24gaXMNCj4g
d2hldGhlciBhIFREWCBndWVzdCBzaG91bGQgYmUgcXVpZXQgb3IgdmVyYm9zZSBpbiB0aGUgZmFj
ZSBvZiBob3N0DQo+IG1hbGZ1bmN0aW9uIG9yIG1hbGZlYXNhbmNlLg0KPiANCj4gS2lyaWxsIGFu
ZCBSaWNrLCB3aGF0IGRvIHlvdSB0aGluaz8NCg0KV2UgZGlzY3Vzc2VkIHNvbWV0aGluZyBzaW1p
bGFyIGFyb3VuZCB0aGUgc2V0X21lbW9yeV9lbi9kZWNyeXB0ZWQoKSBmYWlsdXJlcy4NCkJ1dCB0
aGF0IHdhcyBhcm91bmQgd2hldGhlciB0byBwYW5pYyBvciBqdXN0IHdhcm4uIE5vdCBiZSBzaWxl
bnQuIElmIHRoZSBob3N0IGlzDQptdWNraW5nIGFyb3VuZCwgSSB0aGluayBzZWN1cml0eSBjb25z
Y2lvdXMgZ3Vlc3RzIHdvdWxkIHdhbnQgdG8ga25vdywgYW5kIGV2ZW4NCmhhdmUgdGhlIG9wdGlv
biB0byBwYXNzIHBhbmljX29uX3dhcm4uIFNvIHllYSBJIHRoaW5rIHdlIHNob3VsZCBhc3N1bWUg
dGhlDQpkZWZhdWx0IFREWCB1c2VyIGlzIHNlY3VyaXR5IGNvbnNjaW91cy4gIldhcm4gb24gdW50
cnVzdGVkIGhvc3Qgd2VpcmQgYmVoYXZpb3IiDQpzZWVtcyBsaWtlIGEgZ29vZCBwb2xpY3kuDQoN
CkJVVCwgaXMgdGhpcyBudW1iZXIgY29taW5nIGZyb20gdGhlIHVudHJ1c3RlZCBob3N0IG9yIHRo
ZSBURFggbW9kdWxlPyBJIGNhbnQNCmZpbmQgVERDU19RVU9URV9NQVhfU0laRSBpbiB0aGUgZG9j
cy4gSWYgaXQgaXMgY29taW5nIGZyb20gdGhlIFREWCBtb2R1bGUgdGhlbg0Kd2UgYXJlIG5vdCB0
YWxraW5nIGFib3V0IHNlY3VyaXR5IGNvbnNpZGVyYXRpb25zIGF0IGFsbC4gSXQncyBqdXN0IGEg
ZnVuY3Rpb25hbA0KImRvIHlvdSB3YW50IHRvIGtub3cgaWYgdGhpbmdzIGFyZSBmYWlsaW5nIi4g
Tm90IHN1cmUgd2h5IHRoaXMgb25lIHdvdWxkIGJlDQpzcGVjaWFsIGluIHRoYXQgcmVnYXJkLiBJ
ZiB3ZSB0aGluayBpdCB3aWxsIGZhaWwgc28gb2Z0ZW4gdGhhdCB3ZSBkb24ndCB3YW50IGENCndh
cm5pbmcsIHRoZW4gd2UgcHJvYmFibHkgbmVlZCBhbm90aGVyIHNvbHV0aW9uLg0K
