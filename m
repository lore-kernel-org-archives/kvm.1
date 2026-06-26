Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42413B293;
	Fri, 26 Jun 2026 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434615; cv=fail; b=HXNhSF2n+Olz2xrT71oHegL00j2l3qGobpry6hUZGqk3vD8jnY1B0vp7xJuN2k5ww94crKVCc29i2Dsx3dJVtzwzk844ZER4CcV7NtvVzY58auueQpebxtPXrDT+DwtiG0yzMwvRBz/75C/qinnQ045cN+ELTNcrtDqWXIUgISU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434615; c=relaxed/simple;
	bh=xwLgShtPwXs1BJm9hkq9N9+2LHbjgzyTMSsM9GHP0hY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E0uRtitF37BcAshUbziiJGFiLxMHNI9b4+KfBq5TJE+DqrYPu876z2zA31DE4SzayhHUPeLQeF2T1bYlwAf9OoHEtegeRHXLaBmPrG6YYv3rx0yoaKtkdzj+9pM2Du/vDbL4ArDL7lImAO2U9C+x2GdTUkTICORV/a3JwasBBgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZanTSoTz; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZanTSoTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782434614; x=1813970614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xwLgShtPwXs1BJm9hkq9N9+2LHbjgzyTMSsM9GHP0hY=;
  b=ZanTSoTzejQWGSoM0SL0Njb7ipoc4Q52/8veCeTxZIByA54g67l/PtPD
   nis6XDhKraIbqfMa2nvmJx/dp0Q8nWH9/SrsMnZHaXVo6/uYHJl/F978O
   PvNGiwrNMSwCR1EYL8BQRue7Jdhz/yxkaTf1xiFQJKtGC55SAeqM54pdU
   JKLnfpNubM4O2F+FmXboFNaVY++j2zVvPFpz+u3BsYPk20qyeKlOMw1ec
   sGdbRDf6vfbRF907Ia5yiYIB1kDW/ezC+UsaGs6u36FxJWekIIJy8V6lT
   sR9qjW+zpkNgWtVZs7BT4rYstq2ZncYYjt43rj3zh99HGREsBB88uTNIr
   w==;
X-CSE-ConnectionGUID: /ioguIutQ0OCVlCv2vNjOQ==
X-CSE-MsgGUID: I1sV8so+TfaaaIEI6t2qyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94621551"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="94621551"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:43:08 -0700
X-CSE-ConnectionGUID: tx0KBiW8TvCCQEXcw8jXdg==
X-CSE-MsgGUID: pUP+mPjKQsOnRXlfEvcNwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="253103029"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:43:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:43:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 17:43:07 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:43:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvzfixHSydX5Y7RXHyAT5bh6lHYuwnCXWtItOxL2EiEMztMd5hvVTfhncwaV6tTOo3OYEV5q7FRthElEMMmpzrUyJCPNcBLzPTp0rEeagqkyANsoIlNDX66D74jkZfvpO7lu7KRzdTDVabeUDrMAm9CrzaJCBasOCU/BUxtZ9+KabBB4s8LNI31t1lqNxtwJF0mRjHfe+Toy5xxF2AZ6bARuv+Y2DsRiIW8vXmWFQQ0I/ZSLWyy4feHTQ4CGOznA7y/TRc5ChYtMD3rf4Vv+Dt+P8B2pQURCr3rrg+6/MGJjMFGJEmaNc6qn+RNeb+y7qffZ4LhXMs5bIT0xFa3CTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwLgShtPwXs1BJm9hkq9N9+2LHbjgzyTMSsM9GHP0hY=;
 b=jUhO9lspv5yiVK1diE+tbU2l+BfSoqOsY6+FJunWEmC0VeJ3tVVBWFZBLmhMuEZsiWr48gGX1riRtKyBYo6dAhiwnGrxtpI9+S+ZKwO+9Cqm8y9xaZaTb/AfvRNoLuEh/jZ6/817NXBxgS8Ui8wtkx8SJNVkOlel1DOJl0Jg3tiomC1/eA10JXGmwtx6kO2irpfmC+lo/KHbGe3MMopDtj9kBTrv9x0/py4qiZriT/525fCaC7FH4vS2buWroZeeWdjy9EYFCvl6BEOxMDJloG7MTzByKRA912afZk9QGYmZhPHdyb+0J1FUuvxItRwByZmhQRVbuax9K+WvQrMVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH7PR11MB6450.namprd11.prod.outlook.com (2603:10b6:510:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 00:43:01 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 00:43:01 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH 6/9] KVM: x86: Add static asserts to document connection
 b/w TSS structs and macros
Thread-Topic: [PATCH 6/9] KVM: x86: Add static asserts to document connection
 b/w TSS structs and macros
Thread-Index: AQHdBO6zgXJog+9SWUqkxwguVR+JprZP/5uA
Date: Fri, 26 Jun 2026 00:43:01 +0000
Message-ID: <2ec81e2e8a08bbef742cf6708e4285ebc40c204d.camel@intel.com>
References: <20260625220450.3354415-1-seanjc@google.com>
	 <20260625220450.3354415-7-seanjc@google.com>
In-Reply-To: <20260625220450.3354415-7-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH7PR11MB6450:EE_
x-ms-office365-filtering-correlation-id: 3f4db858-1fe8-43d3-d4e5-08ded31be032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: SojbGuezeW/61/s+5NdKVEj7b3TRAGQnjUuQMSXXmsbxYq/+OSwFY1iFYBjS0PYwWwsheMvmQjEwhOUogPZOgbhKCEaPWmcEsPSnGgl+g16p0yhzcA6e7WxNdeZQEoX9lYjyMhauKuGjkbnMp9No7GMV5tqb1bNxZqnbrtx9EljMYEhEqf5nfKIaEaPevdKUwdK+XsBGQxrfWmkoTdgM1R8UNuIJCwOoGrUHGR/+boFdh2K4tgpOXhxsPVAyIckdcRuoIV0rvrsgMqNxoVEXHM+l5LiLaWOvZb8P7FtA/RracxV3E3gMzji4RDMKopjiOVOJnO8vpC31pYI9WxGhxD0+jTaJ6RHRvut7kC4HvbK8kBuWDb/Azo54To5prsRgOuS+iygIzceRumimObTjxSguLN6wOrPNlrT3v9W32obohgf1W2Op8EM2NKE591GJs/2lWGXkUA9zcX2wBxTISsfhnJXjsSgPF4IytkDH6Hi+IO3OMsHG3vvc9cLhVhmrAa/C7lcMeaJnYYXXHZ7chpD5Lj3lH2DXXxYIF1A1t1tniibuRybEVbEzIilvfvU+lHXieGAl9nxjK9jFyCrX9lDuC5CN1Zu3OYvBzbzETmxF9jsZH35Wvu2RowWgLoCUokUcCV9MH/N+VGJYDESvS1CG1L+0VuxQIdAMEJ1TPU5wHCCwiRO0v3vefoX2M7u1GRalvlrwJ3rPgstKh5KpVbVodEeDYE1ppT9dFWvm89w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFF4QlJnOHF5bFBHaDlzNXdPUUYzcldOM0RJcnkvTDErbDIrVXpadCsrSmxN?=
 =?utf-8?B?SFZNQ01ISklmQlRtQkZ6V2szU1I1NVoyM2ExMUlvcTBqRzNoRVRKS2pRRzVR?=
 =?utf-8?B?Z3hENEViOEZxVmphRDZMZXo0YjBUTU5aTFF0cmJYTnBiSStFaGtYVTdudlZO?=
 =?utf-8?B?K29sa3paRit1YmxUeXNNQ3l4QzdiTTJKSWlhb0FMQy9Ud1RUU2hFMzUyZHNh?=
 =?utf-8?B?L3pZUzJsQml1WUFqVlJrUkU5T2RYOFJpb1dxRk5tTVE0elZETlZndXgvbURP?=
 =?utf-8?B?bUNXVmdRVG1iNEUzSVAvZWwvcDJWVXlSQmVQdDFxODhQWUFSL3E2cVFIa2hJ?=
 =?utf-8?B?d2s3STJHZng1aTFMeDdqOEhLRENlWEVBMWU4aTIzUHkvSlZ6MTBRQTY2QndL?=
 =?utf-8?B?MkZWSXhldzRZU3I3VUZWWXFHdENENUVjN2MzalpKK2xteWQwdzBVYm53bFMz?=
 =?utf-8?B?d1RQVlNaUDJEbGZJOXBwV1FtSW1VcS84c0xYN1FDYlRxVGt2eVV4WEpuMUE5?=
 =?utf-8?B?S3ZUMndxbHRNR0d4UXhGZHZLVm1vNzZpVnlSWUJBSmJ2eFNRR1lORmt6TE5B?=
 =?utf-8?B?NERkbWtKYzZxVGw0Ym4xK0hsQTFNWnYzNThFdVIvWk9GTlc1YmZaSm1TaFhV?=
 =?utf-8?B?eXA4UXd3QitqMllHcldmSjlSN2FROEFBRXpSK0paMFJuVzhNYnNNdTBDZ25w?=
 =?utf-8?B?SFRzRHErRHVKSFRRYk1HbU5uU1BEbVdQbXdRMmVyM1NZZEt6S1I1bHNPQUMw?=
 =?utf-8?B?YmxOa0lWeUliVXhuaVlWQkNKQVBLUkZiK0NveE9ScjdYcUsxQWhVVUtYTHIr?=
 =?utf-8?B?c3ltMFk3VHh2dnJzcWJ1R09aZ2FSNlBPYnJmYUNOWHFCbG1HOFFPaWRPMDRr?=
 =?utf-8?B?UW05aWM1K3JhdTBWQnpzS1o1QWl3dnFaMUUvMU5RM3QycjhVV2Nkd3Rldi9I?=
 =?utf-8?B?QjVqaTZDRmJwZ0FXeFBhMEpIaW03dStHSHh3NEVyU1NxcmxjeGsrN3lUU1kv?=
 =?utf-8?B?MUdNQVZYeFlqUk9wdHIwbzNKVkhtS2M5K2lndk1xeFIzR0FXV0lITFdUeTJV?=
 =?utf-8?B?RVlDZ3RBMVEvQXJPb2dlNXo3cmVOQkgyQS9NbHorVnJWQ1RwL2VtWXhlRTF0?=
 =?utf-8?B?YjlLb2tKRGcxVjBvR2tDVm1taURQWVZ3eWNFOHI2ajJMUWMwMC9GR05xRHl3?=
 =?utf-8?B?OCttLzcrU01kVDhzaytxQ2toNEMwMVg3U20vTnlRMEk1UXpqQ1hscE14em1H?=
 =?utf-8?B?djBSUnhXeW1YRENwQUFDYklIZHNwa2J0NFhvcUZtZ05QNE5KVFE1Y1RDZWVQ?=
 =?utf-8?B?SThzWTlMNVhyTHQxL043dW5nVnNhb1NDY0Rhd2l4M1FMUkFDYkNyUUROQ2pl?=
 =?utf-8?B?QktsVXpnOGE0ZmxEU2dCR2pWUis0ZGRvR3lJNTE5ZThOTHdXNUtQZlVOVHVU?=
 =?utf-8?B?VG5mRVlkeEZVNEpKNytJL1RRalFlQ3JLa0M2a2I3djUvZ25pZUErUHl4WUVy?=
 =?utf-8?B?UGdoOFRLK2NMclRkYUpaZTYxRi9LQlNHckxVZVBJN2xCNC96dVF1Wi8zQm5D?=
 =?utf-8?B?UlhGUE1GK2drYUpUYWtUS3NVMVcyQmxISTFydzFVeGIyNzR6MEJybUlZQ2NG?=
 =?utf-8?B?Z1RXWVVUeDREeWtwK3dCbE5HdlBsNGVTMWNjUXlBNWw2YnRDb3VLTjFiNlNk?=
 =?utf-8?B?WlpMOTRrZmVXaktyb3N6K1dHTWdEa1lHa2NqbHBubGZ3NXhrRmkvaFpBeHZu?=
 =?utf-8?B?TXJFMnRPKzd2WFBpZ1JnanV3ZVBDNDB1QlZ5My9SNVRqZGUxdVVWbmQrQlFZ?=
 =?utf-8?B?djc1N3J2cVQvTHRIRlh1Ulhtc1dBM3o0NGFISEFkaUNzWVJkVFZqanhUQThp?=
 =?utf-8?B?L09OMUtvamZZWXV6bmxFemkrUDZqZnFqWWRWbjZVaUJrVEl3UUJEYUNtRVlr?=
 =?utf-8?B?S1F4WHFHQkR4VHpWWi9sOHUxZC9GN3RUMElkaWRld0UwSVk1cHlRdm5jOG9W?=
 =?utf-8?B?Nzk3OFFDekFqZWNreHRqZWwzdDNCa1luQmlFNHJubW0rQWJOV3RoN3lNVktr?=
 =?utf-8?B?dEtXVEhWbTI5WFNsNjVQdG1WNW9QVjNHNlFsZlFZdFg0OXU1TU1uT1loWWha?=
 =?utf-8?B?TUdkMlRaNVdMaHFlZFd2Zk16Y09qZjY0Q2ZhNlBwL09IbFpvSTJ5NXVnL3J0?=
 =?utf-8?B?WEVTYy9ZcVJLZDQ4Sm0vc1BPM2FmTXhidHJCSzRsRVdPWURoQzZaUVliRjJy?=
 =?utf-8?B?RGpkRHJhS2NyQUdLc1FFclBRUGhxWld5OFZXUXVXUHZFcUFPNVFIN1VDN0Jx?=
 =?utf-8?B?WGR1dVhhZWxWWXhTRVBnSDdVaW9zazZCRHZmN01WOGVTTHhnb0hKUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C982BB61042FC44B6827021DA4D0365@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rpxSpPhVO8IppL0/RpJ4KMGYUHMsrbckmcfs2YpJMCPtr6R5z0NHm0eclewDclqZ34sct8Gn9Y4iLsBTtcEM3CfgGG1MynWjHKAcPct1llIwGEOdSP3Fc/1Ntiqd8dGjlrNduM75YuYOUpDlsaWu7hiKoM0xibheFfnZgPt9UXT01GsK82F9Z43QG+gANjddrRzC05GThSkiYLGYbPrJzIJasv4cUlOTWd3H3Fqv20j/nawHW7z5dG2Ybg4MiwV6wf2tW+MK4v0YK09iFN3ru5gx5cJThhD+Gdph6ntIY6NQ02NTdS4qC2rd28KWTmPVjm4y5TlKani5ONso0iQMPQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4db858-1fe8-43d3-d4e5-08ded31be032
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 00:43:01.2054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoqtLZIPdNtseAgDEewhk2HjgZOFvycUq6m3RC6KiGQ/+P8ES0MjaTjbkSA2DD8ikvhedkaunQPkOkUpYLeLcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6450
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTI1IGF0IDE1OjA0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBBZGQgc3RhdGljIGFzc2VydHMgdG8gc2FuaXR5IGNoZWNrIHRoZSBJL08gcGVybWlz
c2lvbiBtYXAgYW5kIFRTUyBzaXplDQo+IG1hY3JvcyBhZ2FpbnN0IHRzc19zZWdtZW50XzMyLiAg
QWx0ZXJuYXRpdmVseSwgdGhlIG1hY3JvcyBjb3VsZCBzaW1wbHkgdXNlDQo+IG9mZnNldG9mKCkg
YW5kIHNpemVvZigpLCBidXQgaGF2aW5nIGxpdGVyYWwgbnVtYmVycyBtYWtlcyBpdCBlYXNpZXIg
dG8NCj4gdW5kZXJzdGFuZCB0aGUgYmlnZ2VyIHBpY3R1cmUsIGFuZCBwcm92aWRlcyBhIGdvb2Qg
ZXhjdXNlIGZvciB0aGUgc2FuaXR5DQo+IGNoZWNrcy4NCj4gDQo+IE9wcG9ydHVuaXN0aWNhbGx5
IGFkZCB0aGUgbmVjZXNzYXJ5IGluY2x1ZGVzIHRvIG1ha2UgdHNzLmggc2VsZiBzdWZmaWNpZW50
Lg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
