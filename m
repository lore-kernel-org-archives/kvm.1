Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34774225A38;
	Wed,  1 Jul 2026 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870371; cv=fail; b=S6OyAmrwSGMHzCdUcuGpudX6XRpOVOkbubFpwQTA3iBSkv8jzS3mHNkEhuvBI4ZaDrLHVRWOmDu+Ga+akCKLyeCnpCyi19RtZWFxHnJ640wOI8kL3X+YuMponX9fUQIeais1DDu3yCWAlbv0TIw1oMraEa3Za5knQAuqV2SIfG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870371; c=relaxed/simple;
	bh=VTkXaaXGnkMqZVYO4B5+JIYrNSt21fB/8cW5HKqmlog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dxy35uFH0ZtPKgP0e0EiPRWgIgifDKMGzBEQLtfxcDFH3D2EVVmbUfK7qIoyPh25vpvNyEbxbX/OnyCP0/UDJMja6KhFvvbM9Q+9yZ9kIVAQaacjPjkA3/PTE6wgCG0nG1IaDDz2JESMvq76hj+CpjnTdb5glg3JBg3VhdjcIK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjAxTnxs; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjAxTnxs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782870370; x=1814406370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VTkXaaXGnkMqZVYO4B5+JIYrNSt21fB/8cW5HKqmlog=;
  b=HjAxTnxs7aFzVhIXfHQCB1Dpof8AAf2YYfsLtHYlXCnPeMsCBovuWpWn
   11t452DClQZQxKPK9NSxQOM3vYmgmmbK4p71Ipue+lLdLc569B3ItVwnM
   M+vrR75AHt/0TkAcmgM5HXSwpOdqTzm0/GsIQ8//deKq6OTbh1YaTFO0h
   GvFev6A3URSyB09LT/JWaDePGFXe3Pvkqiq20A+WypMjfYAI8SOAUD0EO
   S9BoF6zPaKl09RyE5s0OxyvA1HgPBHuKviQpDtRj9Cro56RIuVfB6X/8a
   FuGFWCgobovL+vzjLNhEstb/6KAQyGAz/Rf3xrWy3YIJLNvIqjdANlVHi
   w==;
X-CSE-ConnectionGUID: bs7tbQzMRxeBw9Ta+yO+EQ==
X-CSE-MsgGUID: U2GcES6iQdCYsXe8b92HBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83624748"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83624748"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 18:46:08 -0700
X-CSE-ConnectionGUID: eB9JtE/aQgSQ/3qNuOb0aw==
X-CSE-MsgGUID: ptF/yDdTTE6eFO3DS5AV4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="254348624"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 18:45:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 18:45:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 18:45:29 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 18:45:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAn2jnycWYY87oXr4jtUM7gtmlxmVr/YmoOS09G68cG2JZRYnOMFVDY6XTUSB1199hOdMA2t2xABqf7B3M/g1p9FNUrHIRhvzQZF6dPw1za8OE+ku4RwvEpa1lM7A/jkgDc5P7QfnmF752GeC7E5yidhvGeFEfS+9IjLQP10MndgiY6czzy0bp8bovlk85uwodrNtoAPkTlrCy2vXG5C+ZfKy+ExnfBkU301SPkTSesVteW63h01VbNrehqGOFAUj/F5fwEMqrXVrxMnVgdHiq80xA4sB3xl7kbMX7qECKjN4pgCmTkyVBH2kv1WJLj8lOBFksuDdwSKgZ33a/Tceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTkXaaXGnkMqZVYO4B5+JIYrNSt21fB/8cW5HKqmlog=;
 b=O5HlzSMe5eC4046hkhWgjDlRou17s8KB3SuFOkaB2H8bN/tBXJYsUM+o95hQtOBoay/8TBPvjILaNg5nMoO/GX/dlBYfo3WzctEEMGEaCl4ZAaLXS0rkyaOtTRL1uTE3zj8ogaZEpfmcBw07g2Wga+CBBQ5zx+kJvj2DNhYHgQOzbYOltKjX9WZdZPQwNTfbJFG30Ue4uDmN3X5YNzApw8Gi2vqIBN/51Tv3ODRpiouyxwigibY/D6RS8l/qbPy+p3j94tJhmh9BYq4cJBqaeyfwa2lLMRinVuP71E7X7/jAbRtceLPSmFzvt9HGzNr5uvyKeQ20ISVqT407o0hAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by DS0PR11MB8181.namprd11.prod.outlook.com (2603:10b6:8:159::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 01:45:24 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 01:45:24 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Thread-Topic: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Thread-Index: AQHc7LhTkBJCRmynDUGCQ1lB6jZxi7YgAfsAgACB1YCADimiAIAA1LqAgABlRQCAAE5egIAEST4AgCOeEoA=
Date: Wed, 1 Jul 2026 01:45:24 +0000
Message-ID: <173092378dcc803463b8d2af9f6f3ab6a908f77b.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
	 <ahVghgNAe4JrmlQH@intel.com>
	 <fe08f03a22acfe758cd97f7c2880deeafbc5fe58.camel@intel.com>
	 <aiGq7XjmMrsqdBY5@thinkstation> <aiJhScChLZkH44eB@intel.com>
	 <aiK1_q8beMcIEiwO@thinkstation>
	 <572868d7-4794-4fec-b80f-97d8434d5fb6@intel.com>
	 <aiaQaCzL8o2yLu/2@yzhao56-desk.sh.intel.com>
In-Reply-To: <aiaQaCzL8o2yLu/2@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|DS0PR11MB8181:EE_
x-ms-office365-filtering-correlation-id: a36ee0d5-0882-4b6e-7ada-08ded7126b88
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: I+2uEh7Djm4YKH/C5p5u9qbT7ekeskrGlGEFtb8WTi8tDOWK4ksk0TytyxMD209XhHWk/O/kSgt4JvU2yUSATRtDUQfK9lzj3lczoKc17p/7Od02bGblKsoNiJYP17msTD1qSIFruiaAcvy7KJY1zvilnT0BKwhyX49mdHQaf/6mWtZDFP3SGUQjbd7YOf87WHF7XTE4oqcBBs4v9TqZMj3M4r44BekUjJ4NY1WsFipWN51TWO/e11mGprJyCTpBoEFRfj81Rag4a6udFlFrTATzSdWTEkZ0Maohu9j5fCJLkIF3JdWrPTzujCGC7YSkwRZpMaYfWytDgbLITmKNwm7i6el1kiLTJRi/W9l5CJuHFNtepCFcv1a2hgQJrfCzcFU0LDZQLjTjhlgbP0JvD3d7PGMLv30RDOp430/VlQCpcixsvTVZw3Yq9uhQUwApfkeqhlnXouawxBNKv7Kc9fHkkhG4oOhh3GWigtAa73+yEY1bT5rtG5QQGrjEm8vEFRNBy9xNM8HH68g9mAIE4AWFriTT5/uhUuiEVKYfruDawWt8P7lL6QEuvn+/N7xLnFUlfiB1Gz5scI51c+XdrdEL8kUjL/7S+mxEDhfxdg4MypCg3CFr8NDLZCzEgPnxZxiPbP7U1/jG5VIfifGrAfwD5+TFFo3bNeMgNifY6xxwBgvpPMXp+k6C+ZG94FGEBzEl9cMktMVfUR3dJtn/yB1zo0iQEJivaNeGEbtyGjs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1R2UDQ1Vy9tM3k2b0hVekxQVkhPZ2VieU01ek5yU0ExY01CY05lVjhtMFFT?=
 =?utf-8?B?Zi9LMVgxK1BEUXY3M0JnUUFFYnFtN1NPTUY4UzJPa2xRZExBY0UzcUgvdEZV?=
 =?utf-8?B?RW9DR282Z3h1eDFjb09tLzlaMEhZZXdYRm1zWTFqTktMZjZHV0VNVW9mSmhG?=
 =?utf-8?B?MDA3VW5IU0lvbkNmOXRlVWFqSkdISjJmdERacVdVSlMxZjV1UWxDTkZxQVpG?=
 =?utf-8?B?UG1CWXBSangrU0lLRE5XTGxwOHVRWUdZSEwzVUVoT1RFcFZ6c2dIdXl5eVk0?=
 =?utf-8?B?OVhpc2x6ZGU1UmIrN0N0YVp6ZjJJVjBXZENqZlh1U0VFRE5KWkJsaktyOVoz?=
 =?utf-8?B?WFhva2VwL0NOZkZiaG1yQUUvb1J3Z2RUalRXRHAxVzdEMEllNzBSclNScWlD?=
 =?utf-8?B?TmJTQkZlREQ4Y2QrT0lkVjZUUGlTU0dhTTlnM0wyWnpEVzVPTGNIcFJWUUlZ?=
 =?utf-8?B?Z3dFN3YwM21aN3dsak5FYzVwSEt3azgwMTFUWStCcmNQSUxrdzF3MVpsRzFr?=
 =?utf-8?B?TW9DSU8vT1FURGNyWVIyTFVOdVloaHA5TC9NK3FkMHFmL0Y5ZXY3VUNoZmZI?=
 =?utf-8?B?WDJWcjBKVnNWWmw5MWFzZ1g3MitQNlJKUnMxS3dRenBMNHJBU3lkT0RDR3NV?=
 =?utf-8?B?Y0kyeXAwcGNVUjZxd2RYQzEzYkZXejA2MGZESWkrWkRJdG5XUERMbk03dXFW?=
 =?utf-8?B?K3ZkOCtnWGFReTdVWlNhVUN3bTNqSlJkeU9QbWE2UEl1QnNpN1FPU2lOcGhS?=
 =?utf-8?B?ejJZME9UQTkzc3NqemhCL09PSDN0ZTNnZ2ptSE9wRGsyTHluS2UxdEsyY3NP?=
 =?utf-8?B?cDh2RlRaUjRDVUNXa0hGQzdCYm9ha0g0WlpPcEJGY29EWEdGUlEvMmFaWFda?=
 =?utf-8?B?eHBZRXJ0RmtBUVRQay9SOW5VRkNZNjJpdW4xN0NMMDkvdHEybWt4OW5MdGMx?=
 =?utf-8?B?NEEzNXFIbGFTVXVwVVJ2Z3pQRlV1SXRJZGI5eldPYU1PZkNEd1h5SU9yelhz?=
 =?utf-8?B?enRjeG9pd25GaUlTandSWkVPck4rbGlZSUUwcTA2L3dpYTg1d0hEdE1HQUl5?=
 =?utf-8?B?SUNwL2dGRzF2OFdkU2JmeHRSNVVZbXdpSlF1RitjUittWktKVVlkSXlUUzRQ?=
 =?utf-8?B?TlZSazdROGdLamRLZDEyeGRRaDU0cHpzRW5PNyttSkNqSDhpSGtDek50VldX?=
 =?utf-8?B?dVQxeDVjK2pJRmltVW5xMlNvVGFWTFJQNUFKTlJZejZVb1QwMDNGb0RrMVJs?=
 =?utf-8?B?cCtGWE5tbk1DUlE2a3hJTC85TGRNalJiSzZIVEtjTXh1ek1qV0dLMjZEby9p?=
 =?utf-8?B?NUZOWm9NOVdaTysxSG5LKzZhN3lwYVhLcW9VMGxleXFBdnpVS1YrYU5jVGRV?=
 =?utf-8?B?RHNFV0pITTdDYkM5SVhOcERXRFFDekU1NWhrM3o1RUZTSDcvL0M0NCtqbG9j?=
 =?utf-8?B?Nm1iR3R4UnoxU2dGNVpPbU5Fa2lWZGwzNGYvYjF4eEJTVnJLbEozNHJSbytZ?=
 =?utf-8?B?ZDZCdDlnb2lGa3c3TzdNcHRkQWh2SzBhU1dmUXBZTkhRcVo3N0lJRlhXbjBk?=
 =?utf-8?B?ZEtBRHlvMytEN2FUM0htUitUeGFMdG1aQ2R5RTNRT010T1dCK2NGTG0wZWZv?=
 =?utf-8?B?ZXoxN3pNczdsVzJZUE0vKzVUM1dkT0RRYmlKZGVTQmQ4WnhTZGwxR0k1aUFl?=
 =?utf-8?B?ZzN2VU9JWE1IMFNlaTA5cUtQNGY3ZE5EUUNFeGw0OG85d0U4dXRVOEZYZnVp?=
 =?utf-8?B?Wm1mZFpjOWQ0dldhVVdXOTNJeDlSSDhwdWduWjE0SXZiSmk5RGI0MnFDZGZa?=
 =?utf-8?B?N2lWNjluMnloWk8wSk1YanVVTTZQaWVFRkdLOHJhT3JFUkY5RGh1c3o2bFd1?=
 =?utf-8?B?OTVGMGFtMkZaTGU0SSt6MGxZa2NNVlVKbGo5ZVQ4YUh0L0JCQU1uRUJRTEdh?=
 =?utf-8?B?Qm9oa0NtSmZSUkhvV1hGNURoV2NoNU04Vmp5L21ocXgrWldmMStWam12RmdP?=
 =?utf-8?B?UTlQZnpFR0VyR3ZDOHlIem5tMWRubzJYWGF0STNtenppSHdGdmdhOU5HeEJD?=
 =?utf-8?B?N1FILzRLekt0ZXl3Q1ZLSDdsU3lHdFpmSko3UTBxTVRFTmNTZUNKWXhPdW13?=
 =?utf-8?B?S0JXaDh3Z1BkL1czbWZDVTN4cDVTYjZSYkxoRFVBWWppcFFVQzd3SERIZllM?=
 =?utf-8?B?b0VsWXAya1R1NUpYNDFHNWRqV3ZxT0toZ0xEWDVYbXVEMjhRTFNKU3d5ek5X?=
 =?utf-8?B?ODB3blo1YVJVY2N0RGFVMlRqYTVPWnBjQ3RkdDhQS0NJd3d3amY1ckFhNUxQ?=
 =?utf-8?B?dVY2Qy9WKzd6QnhuMlN6cCtYQStkUEtHRFlwcG9TNkxoREN4Ni9lc1pMbzBi?=
 =?utf-8?Q?kONNBJLFzX42jBpc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E53DE1E6CFABE74F8F3D6D35F9AA6C92@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n1N2q3UDgbcsNuHwU1TkPn9r11QdmLsayQ5AY2V8krsDgWI6Gt+w5o63Zlit1mrjtNHNM4ttAm00tCzNK0y1Kqzd40OUXCjXm4Z5IjL/gEuCKUm/oQ7GP6R5CRAnf6xGuZ1y6BMRbQNm5SYja79O0eExIDQgunNj8HVZCrqWdmZE4mNRrXQBuJcBmU3bXcV13s4JUBDkHFPc2kXCFktNykQVNIrvQJjA6bLzshr8MFzur4GAG1xxBaJBR5JjomrCtmdqXlRMZ2nMyBVlBIUkIKwlSTN7zoXlBBm+prv43upGSxBzVXXOLXElvJp5n6YjKprIB29P8C0UWZnoIFtPJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36ee0d5-0882-4b6e-7ada-08ded7126b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 01:45:24.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXZaTqyacD/TvPm8Z3kvb7Esmd0tgON/mdYqSe3PL9QZAimCQUR6pvaIqwknjoKNi+ZtgPOepS3EJOXvHbWSVEyncpNju0cDLrUa7kgKOow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8181
X-OriginatorOrg: intel.com

T2ghIFlvdSBhbHJlYWR5IGRpZCBzb21lIHRlc3RpbmcuCgpPbiBNb24sIDIwMjYtMDYtMDggYXQg
MTc6NTAgKzA4MDAsIFlhbiBaaGFvIHdyb3RlOgo+ID4gSG93IGltcG9ydGFudCBpcyB0aGlzIHBh
dGNoPyBJIHNlZSAiT3B0aW1pemUiIGJ1dCBJIHJlYWQgIk9wdGlvbmFsIi4KPiBUaGlzIHBhdGNo
IHJlZHVjZXMgdGhlIG51bWJlciBvZiBnbG9iYWwgcGFtdF9sb2NrIGFjcXVpc2l0aW9ucy4KPiAK
PiBSZWZlcmVuY2UgdGVzdGluZyBkYXRhIHdpdGgvd2l0aG91dCB0aGUgb3B0aW1pemF0aW9uOgo+
IChjb2xsZWN0ZWQgb24gbXkgU1BSIHRlc3QgbWFjaGluZSkKPiAKPiBCb290aW5nL3RlYXJkb3du
IG9mIDEgVEQgKDggdmNwdXMvOEcgbWVtb3J5KSBwZXIgaXRlcmF0aW9uOgo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8LS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLXwtLS0tLS0t
LS0tLS18Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgYXZnICh1cynC
oCB8wqDCoCBtYXggKHVzKcKgIHzCoMKgIG1pbiAodXMpIHwgCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCB3L2/CoCB8wqAgdy/CoCB8wqAgdy9vwqAgfCB3L8KgIHwgdy9vwqAg
fMKgIHcvIHwKPiAtLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS18LS0tLS0tfC0tLS0tLS18LS0tLS18
LS0tLS0tfC0tLS0tfAo+IF9fdGR4X3BhbXRfZ2V0KCl8wqDCoCAywqDCoCB8wqAgMMKgwqAgfMKg
IDU3OMKgIHwgNTA1IHzCoCAywqDCoCB8wqAgMMKgIHwKCiBeIGl0IGxvb2tzIGxpa2UgdGhlIG9s
ZCB2ZXJzaW9uLiBJcyB0aGlzIG9uIGEgaHVnZSBwYWdlIHN0YWNrPyBPciBqdXN0IHBsYWluCmR5
bmFtaWMgUEFNVD8KCj4gX190ZHhfcGFtdF9wdXQoKXzCoMKgIDDCoMKgIHzCoCAwwqDCoCB8wqAg
NTYzwqAgfCA0OTYgfMKgIDDCoMKgIHzCoCAwwqAgfAo+IC0tLS0tLS0tLS0tLS0tLS18LS0tLS0t
LS0tLS0tLS18LS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS18Cj4gCj4gQm9vdC90ZWFyZG93biBv
ZiA1IFREcyAoZWFjaCBURDogOCB2Y3B1cy84RyBtZW1vcnkpIGNvbmN1cnJlbnRseToKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfC0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS18
LS0tLS0tLS0tLS0tfAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIGF2
ZyAodXMpwqAgfMKgwqAgbWF4ICh1cynCoCB8wqDCoCBtaW4gKHVzKSB8IAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgdy9vwqAgfMKgIHcvwqAgfMKgIHcvb8KgIHwgdy/CoCB8
IHcvb8KgIHzCoCB3LyB8Cj4gLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tfC0tLS0tLXwtLS0tLS0t
fC0tLS0tfC0tLS0tLXwtLS0tLXwKPiBfX3RkeF9wYW10X2dldCgpfMKgIDE1wqDCoCB8wqAgMMKg
wqAgfMKgIDE3MjMgfCAxMzg2fMKgIDLCoMKgIHzCoCAwwqAgfAo+IF9fdGR4X3BhbXRfcHV0KCl8
wqDCoCAwwqDCoCB8wqAgMMKgwqAgfMKgwqAgNTYyIHzCoCA3MzN8wqAgMMKgwqAgfMKgIDDCoCB8
Cj4gLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tfC0tLS0tLS0t
LS0tLXwKCgpEaWQgeW91IHJlY29yZCB0b3RhbCB0aW1lLCBvciBudW1iZXIgb2YgaW52b2NhdGlv
bnMgdGhhdCB3ZSBjb3VsZCB1c2UgdG8gdHVybgp0aGlzIGludG8gc29tZSBtb3JlIHJlYWwgd29y
bGQgaW1wYWN0Pwo=
