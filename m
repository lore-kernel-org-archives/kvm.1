Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29B37A486;
	Fri, 21 Aug 2026 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349686; cv=fail; b=MMlidEHpQl0EUmfJsdN12sxMEiNOqdLijrC1NvXx9wwV0WPkOe0wdQNllXIzp5UMSqd+TsGFMLzV71MtPNuODD2wexXLnfv5XtnAYDXMdeKTKEQE1kxcrT6cSESaIxTCznGX/2xbxl0FsEL447AwfHUGJIPYCR/fB+MF/obzJWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349686; c=relaxed/simple;
	bh=3QHo/CrssjwHZWp5WBw9Tt53de50+bAbWypOb7o89HE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=okhbcn1pc9IHYVngADUBjSDY0BzRSeHtuqCP5AP6Ri3DRHGP4xIBW/Fo6S9eo3CXvL6TObXDKNUczE2NV39n/lyWoA6WfhTUu1+FfhJ7dkd5Zyn9kRONAT6jSb0UtDKfiZQzilnMHggj+KWXuJBBsjSCxRHPJ2id6RjVXheVtvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9HNtilm; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9HNtilm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787349685; x=1818885685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3QHo/CrssjwHZWp5WBw9Tt53de50+bAbWypOb7o89HE=;
  b=B9HNtilmRbeNqNyvwmzBUvMU4OjqXq50OuogH8Nuy4N4Z5AVC90FVO5I
   RjyXVje31MGeI7+QYpi5FwItVVhh8seLdOvSKOJ31ugYOVm48V2XS43Q8
   +XNxSyN9i4rK7J7nVXdNk0SJCFiK5SWUCBe6yg4nREq3O09WsUSBWHZWG
   VIhUHXkqLGQTxgujgR2i11ex3z2FWWyofFUDZaEXthFnxpmCWdavhG2TV
   zEIfZZQeYyb0dCNcAoLU7j8L8bNxm1MwOAfi2DtWIrLaVo3XtmvV63Zy3
   eEOV2ydU618BMdoL4rzo6ch/QG5gv48+nGaOjCYFhSlZtPZvl73AFOAk/
   Q==;
X-CSE-ConnectionGUID: L2DxRAFdTNO0qH9H+mblew==
X-CSE-MsgGUID: Lr/mFd1tTW2aSElS7RnWug==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="105440707"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="105440707"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:01:25 -0700
X-CSE-ConnectionGUID: DmQkw9n6Rh670iyx3ER5hw==
X-CSE-MsgGUID: l2FZEIL7RJG0DkkGSF5VhA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:01:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 15:01:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 15:01:21 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 15:01:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2W3+Lj//mi8aUCIqXQO+SAON4F0GjwNoSLVkOSUELpIHgkjo34p31NqTvtsP2RpZQvfLy2xQvNIpfUYh+YdwsMlIFBozii6A3iqen2L1oRhHJ52P6gtr7/1vKFxB+p0lnrnZfuA1qL61amkokUWj8O6bDIhKMr0XnfWZb7mpLmP69r862qL28vCorI263ngpd3vTgnqz3QxbEDi9rMOfcfVuDuxman9XMcHULsQKFSIZp6pLlms5wG9MLPLrH0v8Fg1LDlDLtsXQ2ihrmhtqvk0h9JXm1ggg73VjCZwSP28Stg+B3yr3f5PIn5mk59SxAcBNxumplxHkaQ3LLaVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QHo/CrssjwHZWp5WBw9Tt53de50+bAbWypOb7o89HE=;
 b=U/eX8DjeBfhfu/zgte1sg1lQcr1rc/sxI3B6xYhMhRSpj9JAuS6iiPW+8yU97s7Z0yZrgfot1q+mB74s48G7Sxwrtu9QPlyGJO3f/DbYWlpNMDLU/a41oe8/xvJkW/+CGfx3aU72+djvIGhaAu6310thr09sCj4EmVLXrwfBy4x2R8c8zrmwxHYvIT7mFMoQgt/NrPQ4S6di/rzUDwYPv6RPnGjlsN7XwfD6UVdsJ5eA6o5hjCY9cPyuzTlrhtCxaq7yESyrqSirIx2vAKTfCgc7T9POKeXIDOSF/jW18qdAjB6vH7iU1gh9J3YwFZOUG3Z4qs+u2kbkpdS0gnQ/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 22:01:17 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0315.012; Fri, 21 Aug 2026
 22:01:16 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH 2/6] x86/virt/tdx: Configure add-on features on TDX module
 init and update
Thread-Topic: [PATCH 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Thread-Index: AQHdMR1Pq6sFAWadj0WCNSD1lSPhrLapDvGA
Date: Fri, 21 Aug 2026 22:01:16 +0000
Message-ID: <41f5a558ca67e2895fcb114c418f0e453e933974.camel@intel.com>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
	 <20260821032920.256225-3-yilun.xu@linux.intel.com>
In-Reply-To: <20260821032920.256225-3-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|MW3PR11MB4555:EE_
x-ms-office365-filtering-correlation-id: 6e258bf5-aef4-45d7-08f5-08deffcfb975
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|38070700021|3023799007|56012099006|10067099003|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info: lK9/vsY+2+6Opa19Q8krTehxMQ0Ujm5xyzSaalC5veCfnv8XDVUHyIndnj5kVkzcA+5v/Go764utGdEE+aZqezoyHvRwsngnBjS6jIXrFAIrXTEyucMytNpxkI6GbV+TBOlJ9sfxyrJj250Q35xlttm7IDjPwAbWWXley88TNb/X8/UiylRKX/swxAZPCFuPgbV2Mvegts/gntbC2Qq2GKWGYKwP415Qhq6N1k4ssLkffFHxCX4fP21vP5rmsBVquwx+Qb+KphrZGTvByRe2y6FV47pAMWjQHgBo8h5g3Q1eAqTQTnd+3zWo3iBeBS3ARJ2DNCMO75/bWBsO40sYYhMCCO9Qml13ErAJRrhWDMm+eRQ241mfKBWf0k9NO3BjFOhpY8j76IFGnSv1vyVlNo4yXemPg1Fexs7kF5HUEhZZyi2KAKX4xwSdfPkI4C0gf/foQJslJw0fVWg4aYEMT7E75dwMk6b9WcLpeTi2LHx1hPgzfTTE+r++Q1IGi2B9a6gn/RBTbFqSTNx/V9BOu3cTykhkYmpOQbbIKHi9aTGIP0wdCakjS2yg5TsfnbNmGD27HGn1410CUbKIxm5KKa/qCoAw7APDFlB7gui0LWWJN1B/4fa4sNOS/Ce7iK/bCQbSmxrsYpPZWucD6JDV5YoEoSMtIZyFN8zMlCgtq66f2f520fy9BNs7X7tRBl0Q5NtprXakLmaAcnsyhfykyZOQLYhT+LuR1ybjBYPOFBA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(38070700021)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU8zdkYrU04vU2pnRXpVWEVNRytQY2hDTDR6UWJrWE94ZnF4OHlTTWpCTTJT?=
 =?utf-8?B?TW5xbGI5NTRkeGFzVDBrMVVMV1FXWTBEa29NdjFKMTdxQlRweHNzd2tQdDJR?=
 =?utf-8?B?VjdlMTFPd05Ca2REM1BDcHZYR2dLSzV4RitpbFhtRk51Y3F5LzV5N2g0R0V2?=
 =?utf-8?B?RERhV3ZxUW5MakRjcndzOFlrMW5SVEZvTzhKMVljc2xsTXpRRFVZZkpXaGVo?=
 =?utf-8?B?SVdkY2pjRVV1bEtaS1lQY3hRUXVDS2ZZZGEvNTNwOGNySlU4dlorWEp3MVMw?=
 =?utf-8?B?M3FubmIrOXdXem5mcEkyTE10bTlPUGZHZ1VIWHRieXY0U0FNNHhLNUNERmZo?=
 =?utf-8?B?ZWJZb3NnVzdRdDYzdjJqZHFpV1Z4T3JFeU10L0NVQ3dhU1huKzhMM1EzM3lz?=
 =?utf-8?B?QzIvK04yUFNjMkNuVWllcE8yalVScTdFaVVtc0ZaU3FYT1hLbTFHNU9zRFpo?=
 =?utf-8?B?TUxBazBoenFaZFUyc2xvZm1BQ2dJRGVZNmtjZ01jKzUySkg4eXJ2WmNEZTFI?=
 =?utf-8?B?VjZtQUtUVlpvN2hFUFY2T2IvNnJYRWN1OWdNQ1hYNlhiRXhOdCtKYk9uMXZW?=
 =?utf-8?B?QUYxeEpwVjNndDZRd1ZjSDRGTjZEcnpPU1ZPdlJ6YzBpaS9UMzY5RGtHb3d2?=
 =?utf-8?B?bEhHTyt5K0VoTTZKSmNmZUdPeTlJZVlhS2t3Mi9Da2Y0MklvWnh6aG1GQnIr?=
 =?utf-8?B?UytsZ25keU9VZWdiTEEzT1V2ZXpHZnJ4dlIyK3lZSzRzWVl2c09UQlNOVDN1?=
 =?utf-8?B?d2w5NGZ6cWxpTE0vdmRRVG1PVWk3VklOVjczcCsyY1ZjYkloQU5PaE5UenAz?=
 =?utf-8?B?VHRPb3dWUjByc3FrY0hVbHpEQ2pmWms1MTRHbzVDRnJmMC8ydEk3UTQvemU0?=
 =?utf-8?B?VE9uVnh2NllDWlA0UjhTSks4YkxnREdkR1FOVjlvemtFWEkxYWswdi9NYVF4?=
 =?utf-8?B?T0FUa1NCKzRnTWNMamZFeW1ZZDdXa3gyeWl0ZnJLbmtpWmZ5QmJRZmp6N09n?=
 =?utf-8?B?NEIxZ0hRWTg4Tkx4OGUvak5za1Fid0lMbnRwUXg0VVM0S3Y3aWdidDJ1cjk1?=
 =?utf-8?B?VE9ZK2srS0l0TUZ4OXhFRlpmb3hiY2ZUWCtjWTJFQmcrYjhvb3MvbERnQ3Vm?=
 =?utf-8?B?VGwvM0xJU2RxTnNadTZBTTNIcGdHcTJYWUt3MmN6MWVlUUxqNnlES2Z5Z1J3?=
 =?utf-8?B?NUlveUdGVk1HWGZxRklwWmkwcWY2L0Vad2ZwM3B0SGxRR04ya0FnMlQzSVZ3?=
 =?utf-8?B?dmZKWEtBWWJsVDMyMFlHTG52N1dtODhTc2VrV1M5blNZRTFTQXpadzc5aklV?=
 =?utf-8?B?L1ViMUFSVDdTWHRpZkdKdXdtR2lzblkyNklmNGk4bHNWbVdHQlNyQ3RjNUJs?=
 =?utf-8?B?bWdFdDZsRXBkVHdYNXF0eWtPOGM1Umh1c1g0Qitxb1JxYVhXbWZYVnZXakpy?=
 =?utf-8?B?ZFM2T1RrSXc5ZVVmaVZYdm5aamVYaWluNVM3M0lOVWIzeExBQkFVNktoYlln?=
 =?utf-8?B?SGdSV2tqWCtHeDJJVUFHaFdsbHlaSnpSczJlaHhrR3pLWVVydURxeXhDckYw?=
 =?utf-8?B?a2N2c2dwMVkwUWZDR2NFNzcvZlBKTExMak5ubDRTcjNhUmtrZThsekxmQWtI?=
 =?utf-8?B?M2l0RmovbGxzelV6b2FGTTkxWmhyMGh2ZzkxejcxNDd3ZzZzdzFuZkdNQ2ha?=
 =?utf-8?B?aTBSb1hJeFh3Wm5LZzNpZTFlSXovUC91M2tORVVwTSs2RFE2UFFFbHZhVGN4?=
 =?utf-8?B?bmdqdkpWS3B6U3BQSHlTWC9PeWRyM1Vob1hwQVNBdTJTblg4U0hoVnR3L3lO?=
 =?utf-8?B?WUJtWXhjNVpEVVpDSzRNRjN0OFlIdXpKeVYwamErc051WHBUSHkydDBkTWxj?=
 =?utf-8?B?TERYNzhNOU5aWGpKdEF0cU5xemdEVzZjRGpMWDBhY0tPSWw0L21TR012UTNi?=
 =?utf-8?B?MWlzcXJacGNSVytxeVREa0dCVlMrZ2I2emExY1htVTVkQVEvcVMvWVhtc0xl?=
 =?utf-8?B?L283cklqVHBFRmt1aUhQSElZUCtHd0hyejU2bktSekhNMjArMjFPY0d2Z21V?=
 =?utf-8?B?aUU0Ykw0cnNnU09DSCtBWkIrQ2pmbHdYcW56ZWRIWVR2eU1lWFVVSUszM0dT?=
 =?utf-8?B?czZqY0piSWJFYWZTckRXWjRqekw4cTNPNGlVMzREeDV3S0NBR1ZSYThmTVR2?=
 =?utf-8?B?S1NrT3FPVmVJbVhtRzAyTFZtTzFHYnhmeTBsT2kwYU1kRFdOREEzazFsVkhm?=
 =?utf-8?B?NDhxOTBmMXF0VG5RZnpJVkl3a0NhV0N4L1V2L2xtSXFYdDNYYlk0TU91SzM2?=
 =?utf-8?B?Q1hSbEFxdGhQSVVXdWNZOUFnaUljNjFLWFZFR1U1YjdtSmNHdWJzaVN1YzdL?=
 =?utf-8?Q?Zvp3/N+WcLUQVhco=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D254496E06E19F4B975B82BD03CA7389@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LK4lSPZ3mFVaiOweBeQNNlFUh7O0hnI68PbZj0oagW8YEaVo0a5h1zsLDKDv53kalGkKMJtMMsyyyNUUX2xvfHP1X0wpCuTCYs/05kLXl+o/iJSYIWp/TwwiwMXXoiOL68QUp5DzgUAf0GsCan21UeXm8VRLAHwe8Baaaw5UId4H20YMu/9vA2U8xLOQq54AAEB7cDSDaAYCiOCm9kwWbrKKfUStOcuW5Xlrr1CW9lp0BpGllplVlAjJRlWSul8VJ/g7Ik9qhK0uHwJGofkRQsi0G7+XMQR9PGW6MjWmyHrkpVqXpZWRbaDSucEEa64zTBftpWI0dPb0JrGdhPPw7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e258bf5-aef4-45d7-08f5-08deffcfb975
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 22:01:16.7262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OY6dzXOgMpUV27RS90DCtKXJg/aZlGMtAkZTobNIxUYup+zkzgnmzzGWJ03hdKTUWyzL/FGAvk/yPdZ+wcTROkpGypVxFs8UKLECEF2mars=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4555
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTIxIGF0IDExOjI5ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gVGhl
IFREWCBhcmNoaXRlY3R1cmUgaWRlbnRpZmllcyBzb21lIGZlYXR1cmVzIHRoYXQgbXVzdCBiZSBl
eHBsaWNpdGx5DQo+IGVuYWJsZWQgd2hlbiB0aGUga2VybmVsIHN1cHBvcnRzIHRoZW0uwqANCj4g
DQoNCkl0IHNvdW5kcyBsaWtlIHRoaXMgaXMgc2F5aW5nIHRoYXQgVERYIG1vZHVsZSBpcyBkZW1h
bmRpbmcgdGhhdCB0aGUga2VybmVsDQplbmFibGUgdGhlc2UgZmVhdHVyZXMgaWYgaXQgY2FuLiBJ
IHRoaW5rIGl0J3Mgbm90IHRydWUuDQoNCj4gVGhlc2UgYWRkLW9uIGZlYXR1cmVzIGFmZmVjdA0K
PiBleGlzdGluZyBURFggc3lzdGVtczogdGhleSBtYXkgY2hhbmdlIGV4aXN0aW5nIGZlYXR1cmUg
YmVoYXZpb3IsIHJlc2VydmUNCj4gbW9yZSBtZW1vcnksIG9yIGltcGFjdCBURFggaW5pdGlhbGl6
YXRpb24gcGVyZm9ybWFuY2UuDQo+IA0KDQpXaGF0IGFyZSB5b3UgdHJ5aW5nIHRvIGdldCBhdCBi
eSBzYXlpbmcgdGhleSBhZmZlY3QgZXhpc3RpbmcgVERYIHN5c3RlbXM/IEl0J3MNCmltcG9ydGFu
dCB0aGF0IGlmIGEgbmV3IG1vZHVsZSBnYWlucyB0aGVzZSBmZWF0dXJlcywgYW4gdXBncmFkZSAq
ZG9lc24ndCogYWZmZWN0DQpleGlzdGluZyBURFggc3lzdGVtcy4gQXJlIHlvdSB0cnlpbmcgdG8g
c2F5IGluc3RlYWQgdGhhdCB0aGV5ICp3b3VsZCogYWZmZWN0DQpleGlzdGluZyBzeXN0ZW1zLCBz
byB0aGV5IGFyZSBhZGQtb25zPw0KDQo+ICBUaGUga2VybmVsIG11c3QNCj4gZW5hYmxlIHRoZXNl
IGFkZC1vbiBmZWF0dXJlcyBhdCBib290IG9yIHBvc3QtdXBkYXRlIHRpbWUuDQo+IA0KPiBURElT
UCwgRElDRS1iYXNlZCBxdW90aW5nIGFuZCBURCBtaWdyYXRpb24gYXJlIGFtb25nIHRob3NlIGFk
ZC1vbg0KPiBmZWF0dXJlcywgYXMgdGhlaXIgU0VBTUNBTEwgbGVhdmVzIGRlcGVuZCBvbiBhIFNF
QU1DQUxMIGV4ZWN1dGlvbg0KPiBjb250ZXh0IGJ1aWx0IGJ5IHRoZSBURFggbW9kdWxlIGV4dGVu
c2lvbnMuIE9uIHRoZSBvdGhlciBoYW5kLCB0aGUgVERYDQo+IGFyY2hpdGVjdHVyZSBkb2Vzbid0
IGFsbG93IHRoZSBleHRlbnNpb25zIHRvIGJlIGluaXRpYWxpemVkIGlmIG5vbmUgb2YNCj4gdGhl
c2UgZmVhdHVyZXMgYXJlIGVuYWJsZWQuDQo+IA0KDQpTbyB3ZSBoYXZlIGFkZC1vbnMgZmVhdHVy
ZXMgYW5kIGV4dGVuc2lvbnMuIFNvbWUgYWRkLW9uIGZlYXR1cmVzIGRlcGVuZCBvbg0KZXh0ZW5z
aW9ucy4gQW5kIGFsc28sIHRoZSBleHRlbnNpb25zIGNhbid0IGJlIGluaXRpYWxpemVkIGlmIHRo
ZSBhZGQtb24gZmVhdHVyZXMNCmFyZSBub3QgZW5hYmxlZD8gSSdtIG5vdCBzdXJlIHdoYXQgeW91
IGFyZSB0cnlpbmcgdG8gZ2V0IGF0LiBUaGF0IHRoZSBrZXJuZWwNCmRvZXNuJ3QgaGF2ZSB0aGUg
b3B0aW9uIHRvIGJsaW5kbHkgaW5pdGlhbGl6ZSBhbGwgZXh0ZW5zaW9ucz8NCg0KPiAgQWRkIHN1
cHBvcnQgZm9yIGNvbmZpZ3VyaW5nIGFkZC1vbiBmZWF0dXJlcywNCj4gYXMgdGhlIHByZXJlcXVp
c2l0ZSBmb3IgZW5hYmxpbmcgdGhlIGV4dGVuc2lvbnMuDQoNCkkga2luZGEga25vdyBob3cgdGhp
cyBzdHVmZiB3b3JrcyBhbmQgSSdtIHN0aWxsIHN0cnVnZ2xpbmcgdG8gdW5kZXJzdGFuZCB3aGF0
DQp5b3UgYXJlIHRyeWluZyB0byBzYXkuLi4NCg0KSSB0aGluayBvcHRpb25hbCBmZWF0dXJlcyBh
cmUgcHJldHR5IGNvbW1vbiBwYXR0ZXJuIHRoYXQgd2lsbCBiZSBnZW5lcmFsbHkNCnVuZGVyc3Rv
b2QuIFNvIHRoZSBvbmx5IHRoaW5nIHRoYXQgbmVlZHMgZXhwbGFuYXRpb24gaXMgdGhhdCBzb21l
IG9wdGlvbmFsIChvcg0KYWRkLW9uKSBmZWF0dXJlcyBuZWVkIGV4dHJhIG1lbW9yeSB0byBzYXZl
IHN0YXRlLCBldGMuIEJ1dCBhY3R1YWxseSwgdGhpcyBwYXRjaA0KZG9lc24ndCBkZWFsIHdpdGgg
dGhpcywganVzdCB0dXJuaW5nIG9uIG9wdGlvbmFsIGZlYXR1cmVzLg0KDQo+IA0KPiBUaGUgVERY
IG1vZHVsZSBleHRlbmRzIFRESC5TWVMuQ09ORklHIGFuZCBUREguU1lTLlVQREFURSB3aXRoIG5l
dyBiaXRtYXANCj4gcGFyYW1ldGVycyB0byBzcGVjaWZ5IHdoaWNoIGFkZC1vbiBmZWF0dXJlcyB0
byBlbmFibGUuwqANCj4gDQoNCkJlY2F1c2Ugc29tZSBvdGhlciBWTU0gd2FzIHBhc3NpbmcgZ2Fy
YmFnZSBpbiByOT8gSG1tLCBob3cgZG9lcyB0aGlzIHdvcmsgd2l0aA0Kb3RoZXIgZmVhdHVyZXMw
IGJpdHM/IExpa2UgZm9yIGR5bmFtaWMgUEFNVCBpcyBhIGZlYXR1cmUwIGJpdCwgYnV0IHdlIHBh
c3MgaXQgaW4NCnI4LiBCdXQgZm9yIGFkZC1vbiBmZWF0dXJlcyB0aGF0IHVzZSBleHRlbnNpb25z
IHdlIHBhc3MgaXQgaW4gcjk/IE9yIGRvIHdlIHBhc3MNCmFsbCBmZWF0dXJlczAgYml0cyBpbiBy
OSBmb3Igd2hlbiB1c2luZyB2MSBvZiBUREguU1lTLkNPTkZJRz8gVGhlIGRvY3Mgc2F5Og0KDQog
ICBJZiB0aGUgcmVxdWVzdGVkIHZlcnNpb24gaW4gUkFYIGlzIDEgb3IgaGlnaGVyLCBSOSBzcGVj
aWZpZXMgVERYIE1vZHVsZQ0KICAgZmVhdHVyZSBlbmFibGluZyBmbGFncywgZm9ybWF0dGVkIHNp
bWlsYXJseSB0byBURFhfRkVBVFVSRVMwLCByZWFkYWJsZSBieQ0KICAgVERILlNZUy5SRCouIEEg
Yml0IG1heSBiZSBzZXQgdG8gMSBpZiB0aGUgY29ycmVzcG9uZGluZyBURFhfRkVBVFVSRVMwIGJp
dCBpcw0KICAgMS4NCg0KSSB3b25kZXIgd2h5IHRoZXkgZGlkbid0IGp1c3QgdXNlIHRoZSBtYW55
IHJlc2VydmVkIGJpdHMgNjM6MTcgb2YgcjggZm9yIG5ldw0KZmVhdHVyZXMgaW5zdGVhZCBvZiB0
aGlzIG5ldyBzZWFtY2FsbCB2ZXJzaW9uLi4uDQoNCj4gVGhlIGJpdG1hcA0KPiB1c2VzIHRoZSBz
YW1lIGZlYXR1cmUgYml0cyBhcyBURFhfRkVBVFVSRVMwLiBBZGQgYQ0KPiBnZXRfdGR4X2FkZG9u
X2ZlYXR1cmVzMCgpIGhlbHBlciB0byByZXR1cm4gdGhlIGJpdG1hcCBvZiB0aGUgYWRkLW9uDQo+
IGZlYXR1cmVzIHRoYXQgdGhlIG1vZHVsZSAmIGtlcm5lbCBib3RoIHN1cHBvcnQuIEluaXRpYWxs
eSwgdGhpcyBoZWxwZXINCj4gcmV0dXJucyAwLiBJdCB3aWxsIGJlIHVwZGF0ZWQgdG8gcmV0dXJu
IHNwZWNpZmljIGZlYXR1cmUgYml0cyBhcyBmdWxsDQo+IGtlcm5lbCBzdXBwb3J0IGxhbmRzLiBQ
YXNzIHRoaXMgZXh0cmEgYml0bWFwIHRvIFRESC5TWVMuQ09ORklHIGhlbHBlci4NCj4gDQo+IFRo
ZSBURFggbW9kdWxlIHJlcXVpcmVzIFNFQU1DQUxMIGxlYWYgdmVyc2lvbiAxIGZvciBUREguU1lT
LkNPTkZJRyBhbmQNCj4gVERILlNZUy5VUERBVEUgd2hlbiBwYXNzaW5nIHRoZSBuZXcgYml0bWFw
IHBhcmFtZXRlci4gQSBwcmV2aW91cw0KPiBjaGFuZ2UgWzFdIHN1cHBvcnRzIHRoZSB2ZXJzaW9u
ZWQgU0VBTUNBTEwgbGVhdmVzIGJ5IGFkZGluZyBhICJ2ZXJzaW9uIg0KPiBmaWVsZCBpbiBzdHJ1
Y3QgdGR4X21vZHVsZV9hcmdzLiBTZXQgdGhlIHZlcnNpb24gZmllbGQgdG8gMSBpZiBhbnkgYml0
DQo+IGlzIHNldCBpbiB0aGlzIGJpdG1hcC4NCj4gDQo+IENvbXBhdGlibGUgdXBkYXRlcyBrZWVw
IHRoZSByZXBvcnRlZCBmZWF0dXJlcyB1bmNoYW5nZWQgYWNyb3NzIHVwZGF0ZXMsDQo+IHNvIHRo
YXQgZXhpc3RpbmcgVERYIHVzZXJzIGNhbiBjb250aW51ZSB0byBvcGVyYXRlIHdpdGhvdXQgZGlz
cnVwdGlvbi4NCj4gVG8gYWRoZXJlIHRvIHRoaXMNCj4gDQoNCkNvbXBhdGlibGUgdXBkYXRlcyBr
ZWVwIGZyb20gZGlzdHVyYmluZyB0aGUga2VybmVsLiBTbyB0aGUga2VybmVsIHNob3VsZG4ndCBu
ZWVkDQp0byBhZGhlcmUgdG8gYW55dGhpbmcuIEp1c3Qgc2F5IHRoZSBrZXJuZWwgZG9lc24ndCBu
ZWVkIHRvIHJlLWZldGNoIGl0Lg0KDQo+ICwgcHJvdmlkZSBUREguU1lTLlVQREFURSB3aXRoIHRo
ZSBzYW1lIGJpdG1hcCByZXR1cm5lZA0KPiBieSBnZXRfdGR4X2FkZG9uX2ZlYXR1cmVzMCgpLiBU
aGlzIHdvcmtzIGJlY2F1c2UgdGhlIG1vZHVsZSBzdXBwb3J0ZWQNCj4gZmVhdHVyZSBiaXRzIGFy
ZSBjYWNoZWQgYXQgYm9vdCBhbmQgbmV2ZXIgcmVmcmVzaGVkIGFmdGVyIHVwZGF0ZXMsIHNvDQo+
IHRoZSByZXR1cm5lZCBiaXRtYXAgYWx3YXlzIG1hdGNoZXMgdGhlIGluaXRpYWwgVERILlNZUy5D
T05GSUcgaW5wdXQuDQoNCg0K
