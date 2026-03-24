Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A261A0BF3;
	Tue, 24 Mar 2026 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389766; cv=fail; b=LfEyHC9qFX8R+aPqivMnbKJUSC65fx9u4HxsrTUdxX7VM1xicfg2gSBLg/qLK6f6I0oMXvvaikirBtCxsLjd9SIpzI5EnEZ+LL+kTh+KR9XyD9eXOkwE5TTJCcYMW0yEGXOzfb9xGYFmAkSG6fzjuPjE4Wq+nKT0zpw7JLQOsb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389766; c=relaxed/simple;
	bh=PIAiZdn1266me0QKJvDa4k9TdWnI0SNHT+t+GXqqzhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kix6AklmBaBmnIZp8TC8JPeYRXKXPg/xrKlxU5jMHsn6LsEgrc9fLRGQVOmVPnLE9iRpR33a6LnkRpb21iI1cW7mgpEPSXgmL5SiKtQB9mZuY/00eqw7rPMpkndP6QqIkQZy0lG/3R08gHzd2sp94qKY/dD/ZLUVnwaOHVNAYNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnq3ZpLU; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnq3ZpLU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774389764; x=1805925764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PIAiZdn1266me0QKJvDa4k9TdWnI0SNHT+t+GXqqzhY=;
  b=bnq3ZpLU+it7B+dg1zXv1H1N9WTPMKuHohE8ruMpQA4NfGIg484yV0p1
   R0Pde5m0UInVx41tN7+6SVB/z3MBvSWeFDDKOuEwI5jvMYcqWm0v391Kc
   XHQpqkt9j1k0NUdK0yx9yvmNStc7k5OlVeOJNmnbfAkN14xbCoC4sUdYv
   gpWor8T3RpshDk7fNE3u+vjDmsZjpfvL4dAdylXYzsa29ZIsuREpOiz2h
   xk5YQU+PGKlwkegAsh8ez/pMK7sE76RI/r1aPSTvdaCpEdHiqMItlHE3A
   Otw+lt3B5LxymCZrTZ16wPkiR8MfnvOkvAau1CbkBaRM5pkRy2AS2BTNK
   Q==;
X-CSE-ConnectionGUID: 3DcI3wSNQJmwqNPdksESeQ==
X-CSE-MsgGUID: 1kSFPmUqTt2SYBIQTJu0jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="100866594"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="100866594"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:02:44 -0700
X-CSE-ConnectionGUID: e1YUkeu8T5O4nTmgTu8+cw==
X-CSE-MsgGUID: SsaIdFvoTCuFtXi9ZdhotA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="254987295"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:02:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 15:02:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 15:02:42 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 15:02:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2SwGq53I3/D21OBVbyQGDhGSkF6gbWO+UDxWoGPPOwr7Itjk6X3o/TAYgmVA+usJxi3Dw/xrcDRZsbiiMlkuYfsNw9I8rajnBDi3wdlSJinDyfi+ay+s7YQYOY+pF6MgiN3QGQ7+5jBYMt12Uf/V+mlB6zJo+CjuC/GWFTe7uM0LK/vI4txHzTN+uyJYjyAqQK1nEcMptfApuFGtEL0WE71u6A2dWs80sQGgXisRoeieUk0yiUJF5J+Ii/+bbAdByDdac44rIwKeNWbLofF8YZn7TVtQyZnVeKsGx0hX5+pzG97kcesrdulTa64YPWPkUXL1LGwrb7PY37CCIsM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIAiZdn1266me0QKJvDa4k9TdWnI0SNHT+t+GXqqzhY=;
 b=SAj8ROyIfReKGhLn2WAaIMj/ffps6nGD2trMoun/bzCUyKO7wFEjz5aN1vMJYbkZhacIDcCnFXv2MDbr2m/7r6JR0u0+oVsW/VOgAAkz1G2KKpXeCmlcDHhY4zSvpBE6jyxQh9x2zNYihr4r1ytng6LtGm5oHaxK1iSqNoC/NBRG4kEUlSyesakophmSPNsm78sFvoFPXwNxGh96fKwxLMdETq2YpCQf67PGcAv7fD0Ug/tpOMk8I56P7lH6HRRgSy3RnSVBj1eqRxqmWgpgizzl7GsCEaBToYC/JjQnavBdC5ndfeGaInyTMOy7nWnplFsgn7Cbya18Bj/85//bRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB6223.namprd11.prod.outlook.com (2603:10b6:8:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Tue, 24 Mar
 2026 22:02:38 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 22:02:38 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "bp@alien8.de" <bp@alien8.de>, "marcandre.lureau@redhat.com"
	<marcandre.lureau@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Qiang, Chenyi"
	<chenyi.qiang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/tdx: Handle TDG.MEM.PAGE.ACCEPT
 success-with-warning returns
Thread-Topic: [PATCH 1/2] x86/tdx: Handle TDG.MEM.PAGE.ACCEPT
 success-with-warning returns
Thread-Index: AQHcu6IFt/ZkGri570uEMkKrxbGlybW+PJWA
Date: Tue, 24 Mar 2026 22:02:37 +0000
Message-ID: <928bb81af66232a7c898758e42ad59dc95edd345.camel@intel.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
	 <20260324-tdx-hotplug-fixes-v1-1-8f29f2c17278@redhat.com>
In-Reply-To: <20260324-tdx-hotplug-fixes-v1-1-8f29f2c17278@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB6223:EE_
x-ms-office365-filtering-correlation-id: c40910c1-1c32-4952-0874-08de89f10feb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: ZsNIBPdWTSilbhDbY8mHPd/+2ceI3Bdg4Po6PGkdaiOU3Izq2TKs1sFAjkEZ5juHDXOI1NAuPB1mXwYY3PkQPycq4sCG4WubsB3nyUC6DlqWQGZ0AXhnhAQq3Dds9hnEnqtq9b4sMhccsg+j3jJA+xEev93k9j4lpsdrMEvf53hGYjW8xyqndU/2R9Zeq9m519l2dvOUIKZ4+LQLL9FYFlQcUvYAc7aE5LVVsLaiKXbxc/9+6wGK82HGnJFSFMdyivawcCLbgIQlaX40fUTSNSPXhIAOyxdA2e0wJS2DJEXKNHcEMwMYeMrzPQYFrrZBvzzJdRE6eV7uXisfWGkgQ67Z8U9fXFx2dL22F64zaTQWumAi2HqwPXqiYQLU51J3eollsPIJ1fJKUPVAdOvQm9aC7vs5wtEjh5edyurpeD9zGT59zMlC0egGsV91KiCWTUAZP1KuzOQ+kTXzplJwCy1NJHrXuDezZkM2qD7uYc7RHQDCaJ8zkIRwwK+rcK8WtujVzyreOmR3Z77CBtU9xwtjElFeagFkYoO7FtGleRRahyc2SSDMSb7qFtbvA1mGhstZp0eob1zofYe+BefyChou/dMfbdYh/hFvsbgcrQAkTX0GL88BEprqkJxcEi7Qllw5OxP3uqVxcehM+XxcwiYSA3AVjSvLiHKJPEKp8HitB6n4R2YgPeRDm9gkC8Dp8Ri1MjO34uplK0VJYvDEqz4d2QOylf7q2OQntz0ldgpiiVShpaFvOhjv6T8INUZ9a/tM/nD9Rp8nJotJC6/7clVrhEVzWgyIhXNbECtokvqsNDo1mDIkDFbk8pK/jzfK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aThzQ1c0Nks0aGlCTWpITkdxL1Z0c29KcGxneEJsYzg0aGdGUXR4SFUxd00x?=
 =?utf-8?B?dTNKVjB1bHdWOVdwV3cxZCszUjdEZ09aWHhPbWdRMThTcy9Ta2NrSDJHYXVs?=
 =?utf-8?B?YWxGdExyNFV3WUlxL2pBSmhnS1Q4UTZqWHFKbXNhYVNHUVdMWS9MbVB4Nk5T?=
 =?utf-8?B?WjAxdzIzQUJQRGhmN3RzWXU1N0duaVdTVnVlSFhMeTcvVTl5U25JM3hXeWFv?=
 =?utf-8?B?Z3FGbjNRNzZCNHZpRVpjY082TXJwWDJpQTJTWEpFYjZTak04SHR4V25UNEEr?=
 =?utf-8?B?QnpadGxrR3hVTisxTzduVnR5cTdwVXFFbFZkQUo5ZUUwUnYzL2xFeWJvMytz?=
 =?utf-8?B?cmJyazlyWjFGclRzQ2RkTGFxOStWNU4vWnJCNDdhbURac3EyY1cwalBkVFE2?=
 =?utf-8?B?NkNmUGpWV0x6MittK200c20vbWRkbHoyRjRNR0FLUDZwRW1SNlEwWWt2L2Rz?=
 =?utf-8?B?VVdhRGJvc3lmNlFQd01HOXVXSzIyVzZOSUhEV1QwSkpuRmUvRmk1NFFRb2pw?=
 =?utf-8?B?bktYTWQ3ZVNLYmVIYzZyT01RclM1ZjlaWHlOb1p1WTNBejBKTnd1bForUDRq?=
 =?utf-8?B?STM0WXQ5YWs4Q08xZVNiZFZzRkxveXl4aHcwZlRhMmJOZ2VxUDQxK09BTHlz?=
 =?utf-8?B?TmlicmZGRXZ3Q1JaS0JQVzZ2d0hIZi9BNEd3bE4wMXVLVUN5c1Z1eXdyY2s0?=
 =?utf-8?B?T0wzRWY5UXhjek5IRytHTyt2S2tEeTZmY0JENURscW1KZE05UXY3VWhLV2J1?=
 =?utf-8?B?TEc3Slp3Q3J4bVlXUHhVUW0yU0Q4UGRxaG16bUM2SzJzSWE0QXVnT0VRNmNr?=
 =?utf-8?B?dTdweXVqNXYrbSsyQmRKMDNFOTZ4WksvZ0xpZFlYVXEvUWdtdHNyWGkzUTY4?=
 =?utf-8?B?K0orWGx5NUZyT09ERkExQTZ6N0FZcGROYm03eS91ZVdLNi82WmorL292bVl0?=
 =?utf-8?B?cjVQQ3A2dlN1Q2k2ajVDcDZXVXZZZTZQL242NmVvQ3lHenFYamJUV0F5clU2?=
 =?utf-8?B?WElVNW9iUjAxMWxVMlErVkxaUi83SlBGVVdOczNMWjVCemRtdkpwTlZlZEFY?=
 =?utf-8?B?bm44TXArdkpJRTFwT0JZb2U0Uzh0WnBPeFhqVno0eGZHV05JcitjdlhWRXk0?=
 =?utf-8?B?OENFOGI5eUtZVUl0NWxJUUI4VENJbVNWbWs4WUJQMDZZU2xQK2Q1eC9Wck1j?=
 =?utf-8?B?bE5BQ2xZcGVUa1FqU2tXVzNmTFlMNnhSVVdxUVNZWFhvZldnaDFycmtOZC9k?=
 =?utf-8?B?ZFJBZUJmTW9sWVFLNFM3eUx6ZDVncFNLU3dRN1ZEZTcvNUpZck9iMmJKUER6?=
 =?utf-8?B?QldTQ1JUbkhlQ1BZdExYNHowSW05cDdFVnZlSC93eVRvZHBtOWdaSkVtYStU?=
 =?utf-8?B?VTA5Y29NSTYwY2xadUNnRGJSZGNDcFpaNjYrUzZtRTFrNER2WGZ0L2QrK3B4?=
 =?utf-8?B?VHdDLzB6RG9OSzNSczYwMnltelQyTkQ0ejZ3dkJvcm53TFdmZ3dIQ2hUZ2JR?=
 =?utf-8?B?NkxmTzRtU3JKeUI4WTlrWW16NHZ1QUFJL0Y2MFRiS1JoQ1FxS1JZbUVsWnBJ?=
 =?utf-8?B?T2NNNmVGcjNaczZNY2dXY2V6UEVjZU1BQTJHWkZwM0RwbzlHK1RoS3V0ZG1S?=
 =?utf-8?B?RTVxMGdyZXZwNzBZTDJZSnlyVThUOUdYaklzTTd4TFZxOHNobUZCem5lTms5?=
 =?utf-8?B?V0FhYWFkdE1RUVJuL0NMNW94WG5VcWlDRFhFMmtwanRrdlh4ckJXNjQ1OU8r?=
 =?utf-8?B?RWJXQ0lJNERYVlV3aGtTc1cvNEFKME5ZMmJQSWN6Y01DYVdacXh4N1pnQTZX?=
 =?utf-8?B?MEhVbmtQbUdsVWx5ZCtPK3ZHNnpTaHdXT3VJeHVWdWp3ZG9zWWJhdDI5bVVF?=
 =?utf-8?B?UElJbmx1ZVd2dENCS0RLbUZzaWxSVHBKTXY2Q1B6MUM1RDg2c1Y0cENuSkhM?=
 =?utf-8?B?V0RDblFFL2V5eEFvakRsNWFHdE5ubWVBVFlNNWJYbnE1U0VpMk1tZzIyYStR?=
 =?utf-8?B?ckZFYWhRUG5rd29HSnpwRUw2YjdES3RmbmovalRha2Q0emd2c1pqNU5rc09O?=
 =?utf-8?B?K0hsTDQ4SlErdFVaOGxsR3VaSTBybkhNRzFGZ3B3bkZnQzgwM2ZKam96Zk9v?=
 =?utf-8?B?QS8rYkNpd3RwRmZiRDFtNWhYMEpQT3ZBM0JuTk0zM2pIQ0RPRTVUdWUyY1JV?=
 =?utf-8?B?YjNraHpmN3Q2UGZIMEppYW1pM1lYVmhPSjEzakgxbnIrTXg2K2x5QTJ5Z0hh?=
 =?utf-8?B?SjFFUjN1N25Zd2dVbGFtdS9qSVNMS0lmK2QxQjRLbmlpZXRyVTVHbWg4enNu?=
 =?utf-8?B?VWFUdVZ5aTZPcTdCRUs1ZDl6aDhPZ1hGZ05icmNHa2RjOVljOEdONlU0cW15?=
 =?utf-8?Q?djPTBnIRyaPp2MYA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BA2FE13E11B6A45B5A11225F4F1F53A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PhnV6YLsn9cSVJ/0G6vQYEmrdXg7bQBidfKNV+vZRRtavszcoVnoGVnk/x6/CHxmpZRiq0/Pcya3/IZn9j+07wCHa+8efK/C+pg7tTfuu1jkAv2qEZYYDWJCHBqivh+cXMyLtlWMQMfh07/cmD5zQLh7Lr9S0mf7VAL+wrmenIZOlSet5ZmzGR79ghnXxLa8U+TbwiZVfafSl0KD4jdo8AIXXh8VsMstbgci+xHG/uZMSvxfOL4oLrgK1XKtO7HJIOxUI3g0Ivw24DJJXp2ipzYo4OOv3zEPx3aIhtud2HKHPtrVffbCsOKqWsGSiaBFPGDCAi0Gp/x2IIDNGMXRHg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40910c1-1c32-4952-0874-08de89f10feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 22:02:37.9833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYbVpQok73koPGGJ9ePE6kz5/2autjpY/fqxogRBS4g2v+hawMtMScArxZOoi/gUC6K2BbuOx8J/3KlVXnGfsiLX0cEjmR9ByZ5F1c0UMOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTI0IGF0IDE5OjIxICswNDAwLCBNYXJjLUFuZHLDqSBMdXJlYXUgd3Jv
dGU6DQo+IHRyeV9hY2NlcHRfb25lKCkgdHJlYXRzIGFueSBub24temVybyByZXR1cm4gZnJvbSBf
X3RkY2FsbCgpIGFzIGENCj4gZmFpbHVyZS4gSG93ZXZlciwgcGVyIHRoZSBURFggTW9kdWxlIEJh
c2UgU3BlYyAoVGFibGUgU0VQVCBXYWxrIENhc2VzKSwNCj4gVERHLk1FTS5QQUdFLkFDQ0VQVCBy
ZXR1cm5zIGEgbm9uLXplcm8gc3RhdHVzIGNvZGUgd2l0aCBiaXQgNjMgY2xlYXINCj4gd2hlbiB0
aGUgdGFyZ2V0IHBhZ2UgaXMgYWxyZWFkeSBpbiBNQVBQRUQgc3RhdGUgKGkuZS4sIGFscmVhZHkN
Cj4gYWNjZXB0ZWQpLiBUaGlzIGlzIGEgInN1Y2Nlc3Mtd2l0aC13YXJuaW5nIiAtLSB0aGUgcGFn
ZSBpcyB1c2FibGUgYW5kIG5vDQo+IGFjdGlvbiBpcyBuZWVkZWQuDQo+IA0KPiBDaGVjayBvbmx5
IGJpdCA2MyAoVERYX0VSUk9SKSB0byBkaXN0aW5ndWlzaCByZWFsIGVycm9ycyBmcm9tDQo+IHN1
Y2Nlc3Mtd2l0aC13YXJuaW5nIHJldHVybnMsIHJhdGhlciB0aGFuIHRyZWF0aW5nIGFsbCBub24t
emVybyB2YWx1ZXMNCj4gYXMgZmFpbHVyZXMuDQo+IA0KPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNs
YXVkZS1vcHVzLTQtNg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNh
bmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCg0KSG1tLiBBY2NlcHRpbmcgcHJpdmF0ZSBtZW1vcnkg
aXMgYSBzZWN1cml0eSBzZW5zaXRpdmUgb3BlcmF0aW9uLCBzbyBJIHRoaW5rIGl0DQppcyBwcm9i
YWJseSBiYWQgdG8gc2lsZW50bHkgaGlkZSB0aGUgZGV0ZWN0aW9uIG9mIHJlLWFjY2VwdGluZy4N
Cg0KRm9yIGV4YW1wbGUsIGlmIHRoZSBrZXJuZWwgYWNjZXB0cyBhIHBhZ2UgYW5kIHNldHMgc29t
ZSB2YWx1ZXMgaW4gaXQsIHRoZSBWTU0NCmNvdWxkIHJlc2V0IHRoZSBkYXRhIHRvIHplcm8gYnkg
cmUtYWRkaW5nIHRoZSBwYWdlIGFuZCBsZXR0aW5nIHRoZSBzZWNvbmQgYWNjZXB0DQp6ZXJvIGl0
LiBJdCBhbGxvd3MgdGhlIFZNTSB0byBoYXZlIHNvbWUgbGltaXRlZCBhYmlsaXR5IHRvIG1lc3Mg
d2l0aCBndWVzdCBkYXRhLg0KSWYgd2UgZGV0ZWN0IGEgcmUtYWNjZXB0IHdlIHNob3VsZCBwcm9i
YWJseSB3YXJuIG9uIGl0IGFjdHVhbGx5Lg0KDQpOb3Qgc3VyZSBvbiBpZiB0aGUgc3BlY2lmaWMg
Y2FzZSBpbiB0aGlzIHNlcmllcyBpcyBwcm9ibGVtYXRpYywgYnV0IHRoaXMgcGF0Y2gNCmNoYW5n
ZXMgdGhlIGJlaGF2aW9yIGdlbmVyYWxseS4NCg==
