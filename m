Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6745221D2;
	Tue, 22 Sep 2026 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111535; cv=fail; b=qRJxDI+IaBx/PjT9oRX+8eIj42eezju4Yyt406MwTh+8wmlFKabh2ToBlGCQjbs1gw5EWArlUsrBbkEYhcyxDzpXAzNRQJe0Q5hMTgq1tE3Gp5wixVO3z20MPQtpXP5LCrJEK5S+dz178yWJnnESrjEZXAZU37y0z+14ZX7iPqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111535; c=relaxed/simple;
	bh=X4jk3mNUoP7zQQzqYSpn7g9GvIhZUGxsvZx2IpTh3z4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ioU2PtxP7nwTDpe7XpM3kOzRFxTRH9oMR5K2wsMEJJvBb155dSClOzePgef1F0oLSyCf/2D1xAa6sUNtBN63XhXC5jjhFEfxQNmeDTLmaZA7cEtVeMkSgUMKWRit2KNnX5ZxbX8PcDtjDTpZNdA3VBoBO96jvJVCQq7fdSSrLtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyqcNnn6; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyqcNnn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790111522; x=1821647522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X4jk3mNUoP7zQQzqYSpn7g9GvIhZUGxsvZx2IpTh3z4=;
  b=IyqcNnn69790Cijz7ONg5Oiys9+XviRehku+I/1MTzOFH+MTtabmbfLa
   z+q4Zo6GKvVtmCLNAu4WyUnmt3VGLb6169rJpBQDwyU2OqsL5oI6HSsuG
   e//S1FH7UvLYn/DgQg5czoq9Nu3/pmm2CVBut46SGhEQmONuQZSBykwjT
   rGfx1DGxA77X2TMZOSGGjOv3B4VtyFaSzeuKfnSm7ZwOGdUF+UCFXDugl
   DdGxlOR2eiyNdUzEh2aFQUJPMm1uc+WH2G06OFkFCkl16QpuDZkDXpj0s
   Xqw/Ytzc1LMJ/4tWHyxgD20YS/jjaFrt0bIaPCdjgKUh/RwfUF+0Iju0l
   w==;
X-CSE-ConnectionGUID: GjBgTJemQd60C4sMGR9V7w==
X-CSE-MsgGUID: zhqJnYc8TEqOJdCNlRh+Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1260761"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="1260761"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 14:11:57 -0700
X-CSE-ConnectionGUID: 8gF6KQahSp2rKCVGNNJLMg==
X-CSE-MsgGUID: 2eRyHkpuRuOaa3b8nG9Fgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4326208"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 14:11:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 14:11:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 14:11:56 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 14:11:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYVKni4aRBZWcKxIX7e2UuLlSwMz9HMkowoqLxCqC4mjA1w15ucM/c5SI/JYW7CzslsMZRHYFK9bXIAsmL16dXiAmF1pPmY4pzMJF0jW+Wp6glFXCDqB6HBlJ4gxgWmd+lFLyAb9Oe25Fr8voh8WTJ7gYk8x74KkKtCDSAoR2Ouo61iGWwXZr/IjKgh8XCzsTg4tCD4bAvdiHP6MNDc8kpx8ZRXOmRDBygv8s5VYYVVBNOWvp+eW1ZAGqNoFGnEDEOywKiRy21N+rTlrmTQLQ5pb9NueCyVLvK8UCoBsbS1CMBD1px9RWipOEzpLC62Jk6/PH8d6SiLp0UPUsnj5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4jk3mNUoP7zQQzqYSpn7g9GvIhZUGxsvZx2IpTh3z4=;
 b=YBwt1C4zkSmCrGExyu6UegUCMPIIT1xYOF4gSEX22NlLGmsKWJmsMPOS7ohZCgRXnrWQiUyFIa4rReAZtujyb16l2Elz8koFk41GkVknIHys2vquMVA/YXPdvlw6ezP3fQwRjjJ16eAb8/abANnNYgagUW8MxLnKJHCCAbLYULHxQgz7UQ8M9j5sbf+Vvndatamhd/7jyBCp/5j5PXQUG90nIfwtSrUak7WS8vuDfuHpiFW54/DEQG3kpf4iftES0YtROFoItDC5Z6fQwj/LPdGcQr7hDD9kcApMDzFiJQyhohc3TJuxfVW2NUurBw8JTycj+ojhosqpDykmmgBm9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS7PR11MB7806.namprd11.prod.outlook.com (2603:10b6:8:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 21:11:53 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 21:11:53 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v4 2/4] KVM: TDX: Report CORE_CAPABILITIES as configurable
Thread-Topic: [PATCH v4 2/4] KVM: TDX: Report CORE_CAPABILITIES as
 configurable
Thread-Index: AQHdRnUxaFwZzx/2hE2Jo1Ze0cG1JrbbIQ8A
Date: Tue, 22 Sep 2026 21:11:53 +0000
Message-ID: <7c5543092453fd1509695e2e17024fe20e45ee9a.camel@intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
	 <20260917072548.2314491-3-binbin.wu@linux.intel.com>
In-Reply-To: <20260917072548.2314491-3-binbin.wu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS7PR11MB7806:EE_
x-ms-office365-filtering-correlation-id: 1abf45af-e808-4e06-43be-08df18ee202d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|38070700021|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: Uy6LFOApMohoiffvmmNBv0GDLBF/80UMEkhnOLD1OC7VNGWtKs7RITliY6c4OXET7R3h5H9xuL5v6wIn8E685jWiPuGKYfas3y5dImCPUoXSSee8+h429EXxMDtcxgV+R0I8pYHbocYDBI8xPjsVco8B11W89OYb/8VJMi0baeNNbkxD+ZF7ilMUMU9gZO+rxvNNrMiA2myEFRRe1gWbNhYOfz2r23bCwctd7J+Bsw/bLxwk8UyoQ7Tib42adBE/M6h0nPnLRQGbAVVUfjTYhQhdwoxMZaf5hmClLQG4Pj7zrWt2Pk83SKHvT03y6ociGRV4uQhsAN73Us5eU9o8dmM1mMVYai3i1iBcEliF6meg811gd9Qf00ma6YCdsOHP7tRgsol67v6k0v6N5EFmrR5pxtMJv9HJti3QSruc/WUa1DlYcK/mJOcspgdBzvpYrrrmcQOpXwC/A1qbvRcnjL0wOnjMS9QNy/UM7yEpHKGijQpiCiBWWhrKI7JyjmFSUrB1kQicYuU92TVGuJvk4kLjr0ZvI7lv8KLtJomHIv3CRl0Vg+3XCjLbJZpi/qUKVgTwCmEBR08rMjlt92UKFHYCCAZOyG8rS6RJHtMMX6AQpHXk6gzkddTmyYLDB0BPIG6tcApNwEL6aq0sK+ma9Wm8JHxTVt+fgUg99m+XXYQJ4W9GUw1kwGkcsN+6OTSmkm8V36o6eFzdBI1Xm4ZLjrV3TB/3hsybh9CmEOTEXhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yko4U0tJZTJXS1VNc1dSbjFLVUE0aWlWLzJDRG9KUXgwcS92SlVqRTdtOG5k?=
 =?utf-8?B?WE1FUjJrTS9YNVd5K0RFZUZWV2NzaFB3SkZOS1BYdHBUcWNzRmxxYmw1KzBh?=
 =?utf-8?B?N0tORkJ4RzZsVVR2YXdNUGxVUWdTbXA3MDdpYkMreVNRYmFkRzRWYUo3dlNr?=
 =?utf-8?B?VVZxejVXUzhTWUtMdVdOV1dDSzZDTHhkOWZUOXlmTGVPZ2NlUGZ5ckFBcjdF?=
 =?utf-8?B?dzRYU3VsRW1ZQmJscElQdFRBYlU0em1KSkgya1o0bkdQeExtcHJnVEpEY0py?=
 =?utf-8?B?M21UTk85MEJaMkFWczk0ZmNTeHNHTncxSFRPSHRud0lYamJVWlBlN2xiQWw0?=
 =?utf-8?B?NW5wQlAxVFRPSkI1UWJ5bVZEbk1KdmRjVnp5d0ZIclFXSW10UFBxeU5ORjlL?=
 =?utf-8?B?QWU5dXBtRXFNaW5TZEdOaTBkRGVqdTR1cFgrY2w2WDl1bnN2cnpRek1hbXlD?=
 =?utf-8?B?blBxOU14MVlOYXhpTStjU1pDckVpcnNQRXY2NEdhdUlRTDBYSUkyWVhTdDlM?=
 =?utf-8?B?NEkyQk5BV3hjb0I5bUhXRUg2WUJiNzFlMzFkb1I0WHZlaGF6SXpzOGx6MGpF?=
 =?utf-8?B?ekduS3E2MXVKM1ZIdUcxeFFsYk0yRmVvc09KVzZrMmMwY2o3dC9BVE0vZnBJ?=
 =?utf-8?B?d2gyVDYxbVR2TFVVYWFlM3MyMHF5UW1xYWhicHZua1VEdFZ4QjdSZnEwTnVV?=
 =?utf-8?B?RDNkNFgwM04vUEowUHcrenNBMHg1QjBwcFZqYXJxcmc3U0tFa0dGQlZmSE16?=
 =?utf-8?B?bDAwQkQ5UnRKV2xDZjhXRHVNOXBhdjZISjJrK1IxWEpwNENVRWNzMmdqWE1N?=
 =?utf-8?B?dnZtU2FrMGVQQXRlN2hVVkFEUmtFNXRKeVFvaUM1emJCL094WGZ3WU9UQlVV?=
 =?utf-8?B?ZFhIWmU5czJPQW5TRGdVQ20wbnE0V09zMDZTeUJzTUhNWVB6RHpoTWEzN0N5?=
 =?utf-8?B?c1paQWt3cmk0SThNRk9JbTJoY01kamdFMTk1YXpvb2tWK1dyZHhWSVBQZTJE?=
 =?utf-8?B?OXhVM1ZYSkR2dHN1SDZTdDZFY2VUWVNiYVlZTzloMzkvR0Zob3RXRW15WFpv?=
 =?utf-8?B?NVVrWWJaOE5GMTNUZHYzRXNhWXRLQlNUbW96RXNJL293K1pzYkVYWTltWjAr?=
 =?utf-8?B?a1J2Y0tBNzFWbDVsRlZtWkdIUU4vRG9iV2JxbldBV3BJQU1SdHRFTjZjSWp4?=
 =?utf-8?B?SW92bUV4aGZrV1ZmdmppdE9sa09NeTAwdWJqay82L0tFNEtHdko3c2JBR1o0?=
 =?utf-8?B?dWRjK1EzYS9MRnNoQmdiVTJJODdBL0lQY1FmTldxYkorZENNTG52VmQyeEpY?=
 =?utf-8?B?Y1Zsc3liTG40RUowaFJqVzdYNkoyWUljbXhicDB2OGtNUnluSjU5Q0ZtYldh?=
 =?utf-8?B?dGRkMFpvN1F4YkhDY1FhYVdRci9keFh6TXJGMFdMc0dTTk5WaWs4bTJqRWxt?=
 =?utf-8?B?NEdQTmcwRExlRTI4WE53RnFjcC9JTzBVTFFVZ1pCRGpPVzJ2WUExRmdkVFUx?=
 =?utf-8?B?VFFxQUpxd2YrTlZXTlUzTTY5dittamtWK0RkTHAyUTh1aGFFb0lQcDhWc2di?=
 =?utf-8?B?YTJib0xOM0hYeldNZmFndUdzU2Uva1RsVGRQNzFnUWlpQU5sdFV2WWNpdklu?=
 =?utf-8?B?dlIrTjkzQWQ2K0YreWJCK1ZkTy9QZzlRcDRFb0Q3aVJvbmMwTGJCdWpobHdQ?=
 =?utf-8?B?SFdHeEE3K2RRZHdQZUNUZm9pZFJUc2dFSk5RbmRTYklubHZXYmNTNnRoWTUv?=
 =?utf-8?B?ejg2TkhFejczSzd2M2h1cmNXSnVSc0U5WWFJWHExSm42OFpkaFZ3OFN0dFhL?=
 =?utf-8?B?SjdJaFF1N25kZGxrMWJ0TTJRcWlQRVF4Zm1Ha2ROQXNPNGFCQ1Q4U2xndytU?=
 =?utf-8?B?VGtla2lUUHBnQlp5OUh6SzRJWDlOSG1hREp2YmIxLzZxWnNzdEw5cHVQVFlh?=
 =?utf-8?B?Q3FEemhUdVNhTWVHYURWZE1KZm83MkwvcTkyYWpuSGFwKzVuSUsxTGtPa3E0?=
 =?utf-8?B?UnBLZis5YUZnZ2Jtb2QwUDc2SmtBREttYVJLNFUxMUI1QStzTk10NmtLTjNI?=
 =?utf-8?B?L0FpY0xERlc0cmVndEFqUTVuc21vamFCUzkzWFhYdWlOU285eVZzMllSTEFN?=
 =?utf-8?B?STMxZ1NEM216WU1pbXg3b2tGYnNxVVpNbVl0Sy9PVTJHL1pKNVZJNkJQT3Av?=
 =?utf-8?B?d1pPTWdOWTNUdVhITS91NHJhS09hcU14TkE0WGFVVG9hcTFLZ2YzckNpcVBw?=
 =?utf-8?B?WTg3MnZva0FlcFJSczI3SnQ0bnUwVE55RC9YcEJudkVkaVR4LzBldHZCdXdL?=
 =?utf-8?B?bUppR2loK0hEdE44M2pGQm9GdUtTWTd1NWlyelFuYS9EdkRvSkRBRE5zWnpW?=
 =?utf-8?Q?dNiWo2OwOXoTNBGs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCA26D3A98DE994E9100E20190D53DC3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f5r7Dx0+cpKbUbyaXVTOkDpSdQTrD9trPF22EnjdiG29bBMJN76D+Efp8ZJveh0RyRl40u9Or8OOILoIVx+VnrNu1XseNXB4BUIEZbleAxE9yt1q4TSmEOnEsJKAwIJVmkhA6CYNErsF+E+kIkDrH92bFbyik9W/F8N/beEaDBEpLBNNKg0a/FPiFnFH939EUl2XtdX6bIztUoTdXmJ6blIWfpVK1oCia8uYDzuDPUFKsahaja64Qvypxh8PQR1a7h5YEtG14UdIn6H1m1PoZBlCxQXcvJvQxm49I+nCw2CPaSP68YzUqA1Nguq1okfCnd2zbLt7fwxDnNKo+C/bdQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abf45af-e808-4e06-43be-08df18ee202d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 21:11:53.0957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njzjbrDV8uyT3c7EVzLj8h6sof4uTVnMQbHMKa0t1uQZorYCX0MhyLSyVizrGphjxGfp6Pva/UTPI5XIgef5c4VwprmbQyS2OHHc834nJRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7806
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTE3IGF0IDE1OjI1ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IEFk
ZCBDT1JFX0NBUEFCSUxJVElFUyAoQ1BVSUQuMHg3LjAuRURYWzMwXSkgdG8gS1ZNJ3MgYWxsb3ds
aXN0IG9mIFREWA0KPiBkaXJlY3RseSBjb25maWd1cmFibGUgQ1BVSUQgZmVhdHVyZSBiaXRzLCBl
dmVuIHRob3VnaCBLVk0gZG9lc24ndCBzdXBwb3J0DQo+IE1TUl9JQTMyX0NPUkVfQ0FQUyBmb3Ig
VERYIGd1ZXN0cywgdG8gYWNjb21tb2RhdGUgdGhlIGxlZ2FjeSBURFggbW9kdWxlDQo+IGRlZmlu
aXRpb24gYW5kIHVzZXJzcGFjZSdzIHN0YWxlIGtub3dsZWRnZSBvZiBpdC4NCj4gDQo+IE9sZGVy
IFREWCBzcGVjaWZpY2F0aW9ucyBkZWZpbmUgdGhlIENPUkVfQ0FQQUJJTElUSUVTIENQVUlEIGJp
dCBhcw0KPiBmaXhlZC0xLCBzbyB1c2Vyc3BhY2UgbWF5IGV4cGVjdCB0aGUgYml0IHRvIGJlIGVu
YWJsZWQgZm9yIFREcy7CoCAjVkUNCj4gcmVkdWN0aW9uIHR1cm5zIGl0IGludG8gYSBkaXJlY3Rs
eSBjb25maWd1cmFibGUgYml0LCBzbyBsZWF2aW5nIGl0IG91dCBvZg0KPiB0aGUgYWxsb3dsaXN0
IHdvdWxkIG1ha2UgdGhlIGJpdCBpbXBvc3NpYmxlIHRvIGVuYWJsZSBvbmNlIEtWTSBzdGFydHMN
Cj4gdmFsaWRhdGluZyB1c2Vyc3BhY2UncyBDUFVJRCBpbnB1dCwgaS5lLiB3b3VsZCBiZSBhIHN1
cnByaXNpbmcgYmVoYXZpb3INCj4gY2hhbmdlIGZvciBzdWNoIHVzZXJzcGFjZS4NCg0KU2luY2Ug
I1ZFIHJlZHVjdGlvbiBpcyBjb250cm9sbGVkIGZyb20gdGhlIGd1ZXN0IHNpZGUsIHRoaXMgaXMg
YSBiaXQgY29uZnVzaW5nLg0KVHVybmluZyBvbiAjVkUgcmVkdWN0aW9uIGNhbid0IGNoYW5nZSBD
T1JFX0NBUEFCSUxJVElFUyBjb25maWd1cmFiaWxpdHkgc3RhdHVzDQpiZWNhdXNlIGl0J3MgdG9v
IGxhdGUuIFlvdSBtZWFuIHRoYXQgdGhpcyB3YXMgY2hhbmdlZCBmcm9tIGZpeGVkLTEgdG8NCmNv
bmZpZ3VyYWJsZSB0byBzdXBwb3J0ICNWRSByZWR1Y3Rpb24gYXJjaD8gKEknbSBub3Qgc3VyZSB3
aHkgdGhvdWdoKS4NCg==
