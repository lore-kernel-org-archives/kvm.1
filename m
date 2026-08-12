Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369B442392;
	Wed, 12 Aug 2026 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568574; cv=fail; b=Y7fjFJs9f3GAAZiRnib1cVXvYK0ZIpdi2sSdBDspWHJWUnrJ/jNOVdhrAjWH7YZ7pqeHm6iX/2oBIZnaTlttK6mq6IRg2SnOfdxILtFJwZLyKUVI03EzX2vM/QZZZEYOtKVX2VfWrrVyk8hTACinB5yhZ3wBDFbYcI5EuLLap0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568574; c=relaxed/simple;
	bh=5VJYwLu25ZlgWbdeU3CVT1nfTFhyG046fL9KgsEzEyM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lz3GMdJWQwxQ6fPc+H/Y7wDxb0CenITq6BJ1rtXvNbClK+coQXcFn8iRjOCF/SuXq9vtc3ckVchSpvvRfXpNPprN/AOcjiTIhq+JqumeGA4cpwv5uyMRl82aYI6kR4IjtmAI1CwXgMCS1k67/h4KuMhQdEX04h7jWEZIKnez6Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ol86ccA6; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ol86ccA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786568573; x=1818104573;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5VJYwLu25ZlgWbdeU3CVT1nfTFhyG046fL9KgsEzEyM=;
  b=Ol86ccA6mT8QHphIx/LYAMhHTrbDRuUMkBL0CuTw4qzQSIf6kuDLJs7I
   h62H051uV8GKQm4/CutQESlBWWUaNeuOdHcGR62FQ5Jcx40okgt+VNEz1
   NXzr2wQCCAj35G6g0mEGJR06+ET1vr6w/l/a2uk445wt4Q715AIyPId/f
   9xP3FqWlXMwkPUklH7nocmBlzL7Zq3taNSqcucrH8pl/kIAVziDFjTGBU
   8xtlt+9BH6kLVR+IYlbmjhPMl0khh3XuVf9APhbUTqy+sfomX6cN849qX
   XiLy9JpDrF1DXOtftESDFO0J/mrFv2BHbfGWofBRRKpEUB6uTmLvU4D0V
   g==;
X-CSE-ConnectionGUID: Rq/uDRQWTleI03sOOljC+A==
X-CSE-MsgGUID: uf3rS+8iTUy3Mc/JCMTvNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87260461"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87260461"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 14:02:52 -0700
X-CSE-ConnectionGUID: 8yeHr71tTlehOuXKn74slA==
X-CSE-MsgGUID: QGC7kVFzRrObpdgJ4PWi3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="257541660"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 14:02:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 14:02:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 14:02:50 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 14:02:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+x+E+bDxc3V992vc/ODIULYNlO33Bz++i3IBfEMQRvSslhmF64x+DVxSoeJY6FYf50eTVsDa3XMrTsc7ARXILsb1+nK4Tr7Hz7IyTNKXJtqLHTRXkeF2m1MCiwHvlOrl7+g7wCMPaXB/c9kq+qopdcbvtCLqzvc02SmOIu7ke/XCw6BdJxhFabCOJDhIWI6g9c+cYfsvhAHsTP5zAbqKYcRifbp61BCY8nmfwVzw+MvTj7DJiKkH4Y+AVzlq3u2hfvFmqno1/Jc6iNRg9hIMHFDz36u5x/Q6u32CBkVzEAZ3dO4x4U+1OyrAbGhtCRKx90q7T2Pe3NQ6dYrMgcg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HvS7ec5Q/78OhNqqJzbZpE9TLDtSfro2zZmbBL5BVQ=;
 b=JUWoJLNVJ/CvnN1o1hIMvSB0X8BglhSUVguFz7N1S65ZJaK+WcHn7esW/98flo92wQp0kSZGzFHwcZYvS/E0bLJXAQZTpM4dbVo50qLz253mfEXyFDZyNTdsuSVM/p8FVgxipKBM96pV6dH0pwOSg/fCoQXKUeHRm7Y2l+s4Fr+mtm1qrNbNU2hGG106n4lMz4HH3Y6DXjzT5YhMEpZ5ZG1a/Ux0y81i2UX9TvsSEtfvqLyCTuHZLdf0qOzG9UMYmCPs6p53snwhHs3KRthw7gbbC1qpxy2F1/BpNyvqCR8tQMahqRX+Ellb1RMxZo0EmW9bvHpbW+GBsMFmIYoWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5643.namprd11.prod.outlook.com (2603:10b6:510:d5::21)
 by MW3PR11MB4763.namprd11.prod.outlook.com (2603:10b6:303:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 21:02:45 +0000
Received: from PH0PR11MB5643.namprd11.prod.outlook.com
 ([fe80::db77:8171:4d1:22c0]) by PH0PR11MB5643.namprd11.prod.outlook.com
 ([fe80::db77:8171:4d1:22c0%3]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 21:02:45 +0000
Date: Wed, 12 Aug 2026 14:02:43 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Message-ID: <20260812210243.GC1013044@pedri>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
 <anxvwV_Pz4UYaxxt@google.com>
 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PH0PR11MB5643.namprd11.prod.outlook.com
 (2603:10b6:510:d5::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5643:EE_|MW3PR11MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 15611715-f7c3-409c-ca43-08def8b50eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: v/+Qi93Ob2xMkFY308V6hCiTldkfiYwGco//Ni4b99ZUzQ84TgXkNA+PDLj1wf5q+XKTA+zwrchyEFezD4826FJpV7mThDxNHjua4LKRduaqM468IYTm8h1MQWQBFT23+7817e0viyNkp4QtrcqM/o+cBlT5OtCaGCtIuk8EnNXwbiZf94/yO3B/sicwSnRqJYquhWuS2LHmzK3DlejOymqARotvjIN4KLnRxuAojl6YLJIypcot1CpX5c7Z6kWEv1YCHzYixduozb85j4vKCmV3CrdWKkmm4/oeqkTDTpDEFgkhDeTrlpP+SoKx4rpz3X7QqrrGqRupPQ+N4txeWm10V40iQACoD2QKOSh64mmZvVU9NCkHb0H82YsguWqmi4W8U1cb2cn8slLUaSN9gda2urtsKC6c9XESVs4aGQZjjZLnIeUoiO53bGXsM+4Z5Mgi9ff095gRkgM3PDmCWEe3I3gNUFTaP71xma7/OLFlIRZRycDbx42Q2c1w1wl4EsyqbUF8rZRPqDlSTDI1G2ajBqrvfrSmejB9ZaVbnCOT7cQ3gA/xX0xcUQE6y7F/8FnXG6BBnpQY33+UYFU5tfhHp856zn1z50OZpLRuHFUgmkjlA62EqjRJMriR90WgvbAFsyQ1uLn3Q4s50Zj4Rc7O+4jClHSttEXdacxQoWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5643.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFRpR3FDQW01SWJHQ3VpaGFHSlRHWXdtOWpQREIyU2dKZUJtK3RrQVJwclNk?=
 =?utf-8?B?WXJJcjhYajNZbllEUXpwMVh3RzFGcTRFL3hkUGw0blZwVkpFc2xCeTVJTTFR?=
 =?utf-8?B?SVlVYS9lQW94S3J0OWxxVENFZGt3Y3NVVTJ5dkJLSGh1L3lBQnRIMEQ1anhV?=
 =?utf-8?B?TFFNTytUQlk3VlJZZm1aMFdKWjAraGdUdElpYUR5TndBOGI3SmtJdE1MOGQ4?=
 =?utf-8?B?QncxQVJkMW1YNCsxTWJHbS9vWVR2bmVjVlJ6SXJhb2I1cWdqRittUnhEZDNa?=
 =?utf-8?B?MXlqQTZxMlp6WWdBTGZJcEluV29UU3Z3eld2cU01Q3hJYWJvQStkdysrYkV3?=
 =?utf-8?B?RlJra01rN2ZkSWxJWVhhU05IYTZJaGpUc0xoTDViRlNKYitibld5MjhacGlD?=
 =?utf-8?B?ZzlCeG82T0xrcTFzaE5EM2hNYnhDNUgyU2s4YVJySHZVR1A4TUQ4bmpXaUZi?=
 =?utf-8?B?dS84NkZ1akhab0k3SWc1aVJnZVRJTm5jMG5PYWxkTnZzOW50M0tCdHlnTlRW?=
 =?utf-8?B?QkJIUGVIN2FTMCt3RnhtTVBoWjlrM0lrZVdUOUFEbWlvQ1lTTGJaMk9YV0E4?=
 =?utf-8?B?UWxEVDlIMjc4d2FVaEJQV3FVM0laS25sRXFrdFdUU3JWZVJPWGZkY003MlRU?=
 =?utf-8?B?MHhzZFFwS21INlg0MVNJTHVRbFhSVXg4NjdWd0gwWlNHWjl1SnphaUYwSjJy?=
 =?utf-8?B?OUxvUDVEeWdpd2ExcElRazBmTXNWdlUycHZCc2tCSS9tWUg3aXQwb1MvSGtS?=
 =?utf-8?B?ZjdrUHJVa1g2eDRySHdtaG5pR3ErbFRXTkRVNXpXdG51SXdiOWNLa0kyRHF6?=
 =?utf-8?B?RFFIUnZaVnNMT2ZOZ0FZNlIwbVlubTNCaVpIazg2dXFhVmk0b2FxdmRNUEEz?=
 =?utf-8?B?QWR2N1pGSWZvNGU3U20rTVQzcm43WFVGUWo1TE1Xa0FjTnpPNE1FY3N0ZTJt?=
 =?utf-8?B?YmVpRnpQZHJudjhvYmdmdkhRVXVjK005R3U2NFc1dTFzSHZtSHUwUVNvb3Jh?=
 =?utf-8?B?amhDVTI0cFgxclZFM0RmdFE2VGV3K0oreG5TRlAwdWtwZ3JZUG4wSnhOTGR6?=
 =?utf-8?B?dE1JTUdTcTJGV0NacUlQdDl0cmErTUFZSExYTGFYNDlXb1JndTBMZytrZ0pW?=
 =?utf-8?B?dkRmUjRaYytRZzd4dFdoRmQxR1FtcXo0elFud3g3bFdEZE92Ky9zSWJTMlFk?=
 =?utf-8?B?RzZtOTN3bG5kMFlBYkI4Z210TkFRSlFUMTltRExkaGl1eDBSakE2S0FQaFlF?=
 =?utf-8?B?bXpWWm5ORXdoRUxJMXQ1QWdsTEhFbXNrbnJtVEJLVWdIaGp2b3JBT2dnYUlX?=
 =?utf-8?B?Vm9PUW9OazNZbklhVTF0YTVlZk84aUlmOHpNbHJGWVhCZHgxejV1QUpOR2pr?=
 =?utf-8?B?YU9PWWdrMnl2aDJYSENzZG1HdllOdjd1R0lZemlENm5FSkRuMjRKSWkrK0ZP?=
 =?utf-8?B?d1FMUkp1c2R0aEpqcjZTU25aOVN6Si80YWxIVkZvaDBUTUZuR0NCVW5JZ2pF?=
 =?utf-8?B?NUEyc0lIQ0s2aWd4cmFiTStSaVVxV1hVTjZNWDByVk1hbFJkU1pPaVMwTzlR?=
 =?utf-8?B?SHUrTWM0b29jQ3plYzJaSmE0Q3pDVGgzdnVmeVROcm1qOFlTOUV3Zmd2dWZN?=
 =?utf-8?B?OWNrN0gybmtRT3dnRkVmS0c1YkxpZ3ZwajRFYVNIa0RzK05YNlJoMXJwdm1D?=
 =?utf-8?B?dEhjOHRQYW1UYk1lSjRrWC9MWGNjMXlpL2cxd0dtblUreVdpY0RScG5uMHFi?=
 =?utf-8?B?b2RpRjh1ajl5MjBVUjg1aGgzSXdFZVFQNXMzaWJqZ1BxZVJRdmMxQ0ZqRGZl?=
 =?utf-8?B?OWRxcmQ1NDRwMHc0Nm5QQllSTnlDSkxIZ1lpSWo3Q3BoWmo2dkpZWjFxUFNh?=
 =?utf-8?B?bFk0L1BWRjdVcUlXVDlLMVd1YnRONkg2dHZZUnZvRGYwNjAwQ0h6T2k0MXEy?=
 =?utf-8?B?MU9oaXlZdVk2MTZqMEJBd2tkbmo4U2NxVW80VkNVRitWMkY0dyt2dWZRSGZU?=
 =?utf-8?B?V1MxQklMaUlURW1QeGloeDMwTmpGMGxwOG1McWZMdzdmUDFScEZBUnd0QXNs?=
 =?utf-8?B?ZEFtTklLOGNxUmZVaExZVkVicm9IMjVUdCtIMVNESnFTdE5xdHRrd0JKNXd1?=
 =?utf-8?B?Q1E0cWdyYnloQ3BWNThBek1XMlFYTGNyWHJMd1lpemtYTjlTdVA0cnJhT3ln?=
 =?utf-8?B?azVxU1JrQ1ZxVDAvSHhHc2xpMFFJb1EySDArbFIxL2R6b3lqaHR2UlZvL2R4?=
 =?utf-8?B?enVXYUtEd1NqSkdpZWxaQklERW95WHVUOVRDbXdVTTJlVmkyYlZ6ZlNqN09P?=
 =?utf-8?B?bkNDaVlYNkVqdThaRHl5NDBONHNDWHlFeURSV3EzOGFQSEFoWGhodz09?=
X-Exchange-RoutingPolicyChecked: Z4Ck3rxnPoDnf6gZ3Kf8ludTeeXRM0R+Sq6LkcaFf6eiuAYKqwaOjmL9h7mematBTeaH2a3dZc3NFtvB3kQmrOjOJyatOZirAJJxTkjBIaEZEhnnUrpHwkDmcbLJxiT9FaDPov66xTJITxImruJOnLiNmUQ9LXLrdQ0okFAxQeZ5e9oEX55EonVqBhwRiy99cSD7RlRGEfq4koHd1R05mEd2UummtBa8LqqUN4oLc4RR/E1wKgeGoJPGiRQK6NC4wTyuo6evRP1poK+vn2oSeG7AlkxVG8OaH9+VwcVv1aDA/kziCO/kSYC3nKBiLTiga2CELioDTP1m44wNncVPKw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 15611715-f7c3-409c-ca43-08def8b50eac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 21:02:45.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lsIZ1fHPU7X4Nwb6NfmVWNSaPRMZrE+GP49KaCXdCYkXvw3p3GVbArvN7RBy577QrEl9SvaUyx54SIcGPEQSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4763
X-OriginatorOrg: intel.com

On Wed, Aug 12, 2026 at 09:02:21AM -0700, Edgecombe, Rick P wrote:
> On Wed, 2026-08-12 at 07:08 -0700, Sean Christopherson wrote:
> > >   |Normal quote    |Migration quote |Report size|Quote size|uAPI location  |
> > > -|----------------|----------------|-----------|----------|---------------|
> > > 1|Platform scoped |Platform scoped |Grows      |Grows     |TDX host driver|
> > 
> > With my KVM hat on, this option looks very attractive.
> > 
> > And with the caveat that I'm most definitely not an attestation expert, from a
> > separate of concerns perspective, IMO it seems like the report should contain
> > the TD-specific information while the quote just wraps that information in
> > platform-specific goo.
> > 
> > In other words, to me, TD-scoped quotes feel like a hack that was thrown in to
> > avoid having to modify the guest because y'all didn't plan ahead.
> 
> Caveman crypto person here too. It seems scattered and makes me similarly
> suspicious about some lack of planning. But I kind of came to a different
> conclusion on what went wrong.
> 
> It seems to me that from the overall solution level, the report should never
> have had the details in it. It should just be some nonce or some type of thing
> that can tie the guest request to the quote that it ends up getting
> back. Doesn't it seem weird to get a bunch of details from the TDX module, then
> pass them from the guest to host KVM to host userspace then back to the TDX
> module... which already had all those details?

Yeah this has been a source of much debate internally. I feel that the
directions boil down to: is now a good opportunity to design something
that's more future looking (like can scale better wrt future attestation
needs) or is it better to keep the old SGX design a little longer...

> 
> My understanding was that the original SGX attestation was a complicator of the
> design of this stuff. Because I'm not sure that SGX had all those details about
> the TD. In fact I can't see how it could have. Is that right Peter? So it needs
> them all to be passed in. All the extra validations etc of this shuffling is
> TDX's problems to deal with, but for Linux, it would be at least a lot less
> confusing if there was not two things that have the TD details in them.

Yep this is correct IMO. Basically the report has lots of old SGX
baggage.

> 
> That said, from KVM POV, (1) kicks the attestation out of KVM. I see the
> benefit. But a TD quote is a TD scoped operation in concept. To me at least.
