Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4242F317150;
	Tue, 31 Mar 2026 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991227; cv=fail; b=iOuMLh+rnXQ8ClJfUjtuhaXXRWBDLy7jAVXaTz5kSyBg+bfR3PIyChOCrxGzP5bGqzTwK3z48iLLNDw8xrC0dSEvmd2WXGqJypiTe/t0Dcww6KkDX1gBu7ApIT+rgIzs4tz6NBmJP2mhGq0ZH9CECZqNX2c2oDKhuFDEnsTx0+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991227; c=relaxed/simple;
	bh=hwElLS9NwAMdHucOxEezAi0J9AvveKFgdTn6PB0cq4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qTvEImyXgXfX14ZQB5F2ewQzVHMEsiaD7k5p4C3jXh0lan28oXGwj0lCmJ4nlxuVKKDSTlSPUH42TI3en9SCvE5RRC6+X7U3EOIo3bFzU4izu6UGAhU5mTBhhnfGWKrck7LHMzoEC0gTVFcRF1/bXzugdJ7y171WrsRl/2o7UkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SC9ePszY; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SC9ePszY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774991226; x=1806527226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hwElLS9NwAMdHucOxEezAi0J9AvveKFgdTn6PB0cq4s=;
  b=SC9ePszYN0Ztsr2LRMrjM2PamlCYA8C+f9I4484bHA51M8/FHIxGpygf
   6p5Fg1RYXDxbhO5EaUQ19N2BdH89jY0C7ITkvpxez86lJ5mM5HQAcGPcV
   BYWJlBxZJ7iw75DLxAvrptxedXTA8jS4mpWQwvII6GArulRUULsbZFiQ1
   6M4TRcfBZB6mwQTwhD88sizsP2jJYCrx7NY/SWRnVqlEdv/slsup8DQX2
   pAbr2bRMiYS9pTSBKgB133Nx0LuiaEoyb31zq8NpTCqUSlEEz77O/Fboe
   2tEVG7pAZvNEe0euWAq03eQIml70Xo8LLjY/DW+w9UR+V8nbs6lY1NdOy
   g==;
X-CSE-ConnectionGUID: pWl1gszDQ2CDv4JeHW1eBA==
X-CSE-MsgGUID: bZCMPIqURcSWnk7/linmNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86321543"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="86321543"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:07:06 -0700
X-CSE-ConnectionGUID: B0U/QgoZShqlW/0KRy2Vgw==
X-CSE-MsgGUID: Qdbtakx2S4S/1gkQh3NUtA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:07:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 14:07:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 14:07:05 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 14:07:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1GhD6BX7Z8BjzfN2TkcYEbo08RH4ZLEsUKWq5XNM7wg/kOV4DngnD2HvREXNuLTM+LWHujFsI/608tNPmvSUHiE988JDtZykxvZdE4gycRzRTZxTi0Hnlo7P8TGhsVV47AwnMLViZV8eEvaowzdwlY1b9Go7DlloJysGO1UIy2eQ3FALy6UIKryZ2AEGSoG/awhvI4j57qgCjV5xjwpGrXZmhEZ7JmwCouTuesfYpfopGsh4w+ai+/SLnpCc2m98LkI/cc5hwloZlE+ufC+brSWhlL+ul8/hmaCQ5QRaPyo+wIK3idENXoqy//L6qZpeda34xEL+D5Fclwm4XIz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwElLS9NwAMdHucOxEezAi0J9AvveKFgdTn6PB0cq4s=;
 b=TWf/tc1CVtehhzajfup0sLrxjIFOzliqSMkau4cFWBteUQzEboh1mF5I4/5DHw84F+bCODwulCPn93IF1AUgQS+ICZAbcyeRpsipcDzEJJX04rlCgAmTkxepE8PZ8mPdN7Bpd68GYYvmQ+FhMdueT5mj55Ma8swNlsXuRW8tO++yJZ2MaEBQz6Mog2+9UndC4IyhXwvE6O0XJ7rOJKnK8nuzpT+xrfuANS0MQLCmdYkzh7Vcx/EywPGavbKHIyySiO0c+YnfuEaKQhHCBG3uJVm/A4YQS17zruvrx+9dqXlWkWwUTDojka+keRt3nkOGI6CBGdq7Z8DKw5TeT7vCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB6448.namprd11.prod.outlook.com (2603:10b6:8:c3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 21:07:02 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 21:07:01 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "weixq1@chinatelecom.cn" <weixq1@chinatelecom.cn>,
	"zhangzg12@chinatelecom.cn" <zhangzg12@chinatelecom.cn>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "hanht2@chinatelecom.cn" <hanht2@chinatelecom.cn>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "18341265598@163.com" <18341265598@163.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] vmx/nested: Set the SGX feature flag only when hardware
 supported.
Thread-Topic: [PATCH] vmx/nested: Set the SGX feature flag only when hardware
 supported.
Thread-Index: AQHcuz6j0NEGTKXnYUS0AWJdG9RzpLW9drkAgAtqLYCAAE08gA==
Date: Tue, 31 Mar 2026 21:07:01 +0000
Message-ID: <8fbedc9183f61400c772b36562963cfc8c3a8797.camel@intel.com>
References: <1774322860-25106-1-git-send-email-18341265598@163.com>
		 <95c13b532d2958977d176e965efc433f1f4793c4.camel@intel.com>
	 <acv2jIBRxKp94oP5@google.com>
In-Reply-To: <acv2jIBRxKp94oP5@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB6448:EE_
x-ms-office365-filtering-correlation-id: b7315383-9403-42c6-4faa-08de8f69741a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: tYBxXuCDsDKreS9sulLcmfgCpDP96OlGIDVqupyz1XJDIZ1iWj/MXR13un5g2A0ToJ0ueePgieutzPT/+qoYEIsMXyoJfxoBPuIsDyj6oQGpFtEoPIMnIwCinzyurdZ7B0nnjJLzHvHnWpQ+rC+UjzQmJgcx/UzBwQRww3huS0MXkwNukN6WsoKbAucrzSj6eqin+PP6rMx+l2pK/N8X/PDo5vXV0TylFoD4c40ZRXN1YTpQzRFFOG5/xFxqG4X+JPKPtTiL/UaizLJkbJxE+r12OEg1b5CE1E92PCH8IbEq+VTSBv3waOoR9cwYHjkiMPIC+BlwKL4JmEAUgNULawlKPOSP1VgeuKPflMJ/poX5Qr+JTF3GFsGe39XlTmgGu5PN9BxKhA+cnaFKbEkH+zydweB2e/xZdXmMUpzo9sNaSi2O0jX68KRNEFgHcZkrFxmRb5YLNWb1+sFT9nf9w26lp5bDwzXQTyQFwBtONMk9KyufTlcz097DIHO67Lozu2uvQRmbx5iXhrTxqwHTteILrC71aTj1qUNRzoP4J88doJ/mV6lmceqy6SQP/Bz8zn3rjxKWwun6Mg3Na0Xr7XjtVGOHtyrEZc7bkd86bPC1cnwpFpqVMfgrIEsQbCBoK5EconFrhCt7IpqKriZykofgLddFogODx9sRMKSEPx686Py0l1h+msD4K32TMt7AwmWueEo3KJkTV+HlsjiiKLpAyy+i8oJbgsH1K4mYmqaZoPs9ULrX+IOS4LK/ZFIr/JFgk9A95VuL4de9kJUyBjTVN8wL+QUMEMvQV0MwVcM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVorYXYvbThUV2dYdDFPNWNrQ0dKRVRpV0RZNWFoUy9YTzA1RGZuYVNuVW9E?=
 =?utf-8?B?NVRXNWR0cndnMDZjbW5YbC9ibVpxQlNlK2hGY2YzcFJCcnl6RUtjbVVRSHNl?=
 =?utf-8?B?RnR2RTdmN1J0MW8yWVFVbVN2dlhaWU1CWTg0UFJtWVpsM25XWW1aUlFzSlFU?=
 =?utf-8?B?Vi9BelNza0txZStVQnZiZHhid241dTMySmV1bmxPUzc5MXR0TGF2R21SRWkw?=
 =?utf-8?B?QS9QZjhVbHJKZ0dPdkFQcTJjUXA4dzFodFdHMytiUEVtVkNzdEpzRC9hbUwx?=
 =?utf-8?B?NzVQbk01YldkZFZwWFpXRmplYXB3Rm9RUEIxTjdSYmZyaUFQZEVFbGo1aGQ4?=
 =?utf-8?B?OWFiMmZoUXpyaG1iQjc4cUpVUWpRUHRjT20vdURqWWRmMytFSUc2eGRldWlZ?=
 =?utf-8?B?dlcwSWtSZUxHMmhqakt3aldCVG13UStEOU03VEJscjNkemNsWWhNakRBV09i?=
 =?utf-8?B?b1BhY0lZYzdOK0xiZ1Rzb1A2SEVHS3kzd1NLYkJMWjZDbFI0cGUzTlh0SlYx?=
 =?utf-8?B?Wi9RSzVLc0ZjZWxHTytOdUcvMXZJTVZxVVhuaUFlWU1RQUw3TEFyZWxXSitv?=
 =?utf-8?B?bGo2bzRzcWQ2VUl6a21TZGFEMTFYajlRblpaUG1FZFZsYnlQOEI3azVodjRN?=
 =?utf-8?B?dXlWL0VkYm1HTFlrZStOQTkwelV5bHFvMmpVRk9JUE4rbE9kbDV5RkxJbzdW?=
 =?utf-8?B?SmJNaUhja25wNUpPWFNmSXJaUnpTby9CYStuNFBrSnUxQWFXZGgvUTYrQW1F?=
 =?utf-8?B?RGpxTGRiY0x1bmNDRVM2SmF4U2M4WjB1L2FSYUxhU3luai9NL2tXWlgyS3Bh?=
 =?utf-8?B?MllKN2p4RENhdS82OWRueGVtRzlQc2pqamRiYUZHamtQM2ZvSFNmSFBKWTR4?=
 =?utf-8?B?WkMxOFVwUHo0VFYwcTNOYVR0NGkyNXZwOFdId1NqOUdyaWdDRFl6RVpyZkxC?=
 =?utf-8?B?Z2NiL1J2bmlwVmJjZlNsQjREcXRmV1BKUmtnSm5VR0VzTUo4NVBENXhMUkt1?=
 =?utf-8?B?dGtTbGh3d2Z6SW51VlJjWHBsbVRVblhubEREenFUb1ZOUzdZMCtTR1NmRkFz?=
 =?utf-8?B?d0V4cGM0YTI0M0ZSZUxOSlRZSk1FcW4yd3VSM29jQ2tNeDVnMWFWTlNVQ3NR?=
 =?utf-8?B?eitXeUVTUkZWZldnUnV6d2pNdnJRbDczTytGcFk1ZVlnUW1FNFZ6V3BoaFd3?=
 =?utf-8?B?eW4yYmY3L1JDZ0NOVlVYUjBSVFEwVWtCakhIZUo3K3NSRWRsd3orcTBwT2Mr?=
 =?utf-8?B?Qm83RS9sTGI0bTFOSFhLNkVzVzhwQ3RoM2RRMVpjaWVjMWNtMlNRTkVUR2I0?=
 =?utf-8?B?QnM1SGU3UWJvVVk1MTZDSCtmOXVCNVhWZmkrQWxVMWJTUFN3ajdZYW1pOTRN?=
 =?utf-8?B?WXhLS2haT0RCN1cvT3lNcThmN2luSk5pNFFRbzFtblpoZVBaK0ducFJNZlEr?=
 =?utf-8?B?VkZScFplNk1POGJOQW9vZXA4Y2cxc1IyUkZkeXRDOTl6azVYa3REb1dOdkxl?=
 =?utf-8?B?L21kV01sbWRMOFJXdHBmeUhNUnBtZWg3ZGVmL0k5UVIyUmZxUmRCMHJuaTlm?=
 =?utf-8?B?QldBaUVEbnpkRDFSV24ySmRZTzlvcXkrSVFtUnFiT3hWS3huYU5xUkZ4bWpj?=
 =?utf-8?B?S3lGb01hRVBkaUtMc2pZU1dtM0xaTTVuNWtXaDFIU0Qzd2UzMGh4eXoxOU5a?=
 =?utf-8?B?c0trK3FDU3hjM2ZySHFBMis2Z09ncU9ENzE1UzA0cGMrd0dtT2tEbGhnTnVr?=
 =?utf-8?B?dVBtWStUaHUxZnpCV3BSZFczdHJtd1Avbk4rZzk2SHpoSTlrN2diS1NFUFVE?=
 =?utf-8?B?YnpLTERoejVNZmwzWURRRHdKYllPQy9SNS82cXlHQS9XdDVLR1lLclg3Y3Ar?=
 =?utf-8?B?V1Y2cE1mSHFyR0w3QlNjbmNGNXNaamZHVlY4MzYrek5oUVlZVGZUdGpLckQ3?=
 =?utf-8?B?U09qNHpBU2NkaUtyNEVodDNmeVhhMlcyMjFISk05Q0w0TlZwQmdJWEFJditk?=
 =?utf-8?B?aXJRanBzbjhDdmI5MG9BcE0raWR0dW42WlJ0amk0QWRVcWxVRTBXYzV1L2lP?=
 =?utf-8?B?d204UTBWZjNvUVpPTUlHdktJRmdxR3Q5R2hCK0hyVVNScGZrQ0lXTVVpVk9U?=
 =?utf-8?B?ZlEzQVV6aHg3RDhBRDBSZWFTNHlhSFBwZHpyZjlndXlLRXpwR09kN2xhRit5?=
 =?utf-8?B?a1BuZHRiRXdYbnBxNnE4dzlCUXNTZVdTNERrV0RSNjJGSEtBZFRwZ2wwNW1i?=
 =?utf-8?B?OUJaV3hFWFBlcHhuamRtUVF4L1BwRTRTQm83ZlU2Zys2Q3o5aHJHdE9xSmph?=
 =?utf-8?B?K3pZcmdVUi9WVUVkQWowVmMwLzcwTWRjblMwdVlMTnZuMFByaEVkUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7430F6872D268E469FE44B22817A2995@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X/YrtGP3yozy7DZIeQ/tGYpY0x82D1JUJepImWkpXkXezrD4hPZD9ALulpOHz8ycfXsEhV/98MSL3IhFnmn/SP3D6AskJaXQwqwkJivPFlG/ulwcJ723JYPn73Bg89ADFLpWSK+OrEtz+QfmDSOBZjqDeUt6w4Wr7hstWEMmvqRE80M98gesbBYNepWAUsCZs4R+a9iGFsj4v+9tUfexEAoavza4oq85ov9Go2RNtejM3dNKYUGKQUc3uVimoiB5mjXMr5gnPkKlFVN+BUYHIbcWZaKwbyHGwUdSojQDDFMMZOmlAE9XOgIe8uh6ivUbEqLPvVMZPs/hWoU/Kl/C0w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7315383-9403-42c6-4faa-08de8f69741a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 21:07:01.4944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxqMFy428dq98Tu94av4yQA+kvN58bBMuyHuYlqkvUgnWqTJOsO7OVDwAsJxq0YpIfwDkaSOhwICaVbllG1aCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6448
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA5OjMwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUdWUsIE1hciAyNCwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgMjAyNi0wMy0yNCBhdCAxMToyNyArMDgwMCwgMTgzNDEyNjU1OThAMTYzLmNvbSB3cm90ZToN
Cj4gPiA+IEZyb206ICJ6aGFvZ2UuemhhbmciIDx6aGFuZ3pnMTJAY2hpbmF0ZWxlY29tLmNuPg0K
PiA+ID4gDQo+ID4gPiBJZiB0aGUgaGFyZHdhcmUgZG9lcyBub3Qgc3VwcG9ydCB0aGUgU0dYIGZl
YXR1cmUgYW5kIHdlIHNldCB0aGUNCj4gPiA+IGNvcnJlc3BvbmRpbmcgZmxhZywgd2hlbiB0aGUg
TDEgaHlwZXJ2aXNvciBlbmFibGVzIHRoZSBjb3JyZXNwb25kaW5nDQo+ID4gPiBmZWF0dXJlIGlu
IFZNQ1MxMiwgdGhlIFZNIGVudHJ5IHdpbGwgZmFpbC4NCj4gPiA+IA0KPiA+ID4gUmVwb3J0ZWQt
Ynk6IHdlaSB4aWFvcWlvbmcgPHdlaXhxMUBjaGluYXRlbGVjb20uY24+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiB6aGFvZ2UuemhhbmcgPHpoYW5nemcxMkBjaGluYXRlbGVjb20uY24+DQo+ID4gPiBS
ZXZpZXdlZC1ieTogSHVhaXRvbmcgSGFuIDxoYW5odDJAY2hpbmF0ZWxlY29tLmNuPg0KPiA+ID4g
LS0tDQo+ID4gPiAgYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYyB8ICAyICstDQo+ID4gPiAgYXJj
aC94ODYva3ZtL3ZteC92bXguYyAgICB8IDExIC0tLS0tLS0tLS0tDQo+ID4gPiAgYXJjaC94ODYv
a3ZtL3ZteC92bXguaCAgICB8IDExICsrKysrKysrKysrDQo+ID4gPiAgMyBmaWxlcyBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2t2bS92bXgvbmVzdGVkLmMgYi9hcmNoL3g4Ni9rdm0vdm14L25lc3Rl
ZC5jDQo+ID4gPiBpbmRleCA5MzdhZWI0Li4zOTZhYzA3IDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJj
aC94ODYva3ZtL3ZteC9uZXN0ZWQuYw0KPiA+ID4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC9uZXN0
ZWQuYw0KPiA+ID4gQEAgLTcyNzgsNyArNzI3OCw3IEBAIHN0YXRpYyB2b2lkIG5lc3RlZF92bXhf
c2V0dXBfc2Vjb25kYXJ5X2N0bHModTMyIGVwdF9jYXBzLA0KPiA+ID4gIAkJbXNycy0+c2Vjb25k
YXJ5X2N0bHNfaGlnaCB8PQ0KPiA+ID4gIAkJCVNFQ09OREFSWV9FWEVDX1ZJUlRVQUxJWkVfQVBJ
Q19BQ0NFU1NFUzsNCj4gPiA+ICANCj4gPiA+IC0JaWYgKGVuYWJsZV9zZ3gpDQo+ID4gPiArCWlm
IChlbmFibGVfc2d4ICYmIGNwdV9oYXNfc2d4KCkpDQo+ID4gPiAgCQltc3JzLT5zZWNvbmRhcnlf
Y3Rsc19oaWdoIHw9IFNFQ09OREFSWV9FWEVDX0VOQ0xTX0VYSVRJTkc7DQo+ID4gPiAgfQ0KPiA+
IA0KPiA+IEFyZSB5b3Ugc2VlaW5nIHRoZSBjYXNlIHdoZXJlIGVuYWJsZV9zZ3ggaXMgdHJ1ZSBi
dXQgY3B1X2hhc19zZ3goKSByZXBvcnRzDQo+ID4gZmFsc2U/DQo+ID4gDQo+ID4gSXQncyBxdWl0
ZSBzdHJhbmdlIGJlY2F1c2UgZHVyaW5nIEtWTSBsb2FkLCBpZiBjcHVfaGFzX3NneCgpIGlzIGZh
bHNlLA0KPiA+IGVuYWJsZV9zZ3ggaXMgZ3VhcmFudGVlZCB0byBiZSBmYWxzZS4NCj4gPiANCj4g
PiBUaGUgb25seSBjYXNlIHRoYXQgSSBjYW4gdGhpbmsgb2YgaXMgYWZ0ZXIgS1ZNIGxvYWRzIHNv
bWVob3cgbWFjaGluZSBjaGVjaw0KPiA+IGhhcHBlbnMsIHdoaWNoICJzb2Z0IGRpc2FibGVzIiBT
R1ggKENQVUlEIHJlcG9ydHMgU0dYMSBhcyAwKS4NCj4gPiANCj4gPiBJcyB0aGlzIHRoZSBjYXNl
IHlvdSBhcmUgbWVldGluZz8NCj4gDQo+IEl0J3MgYSBtb290IHBvaW50ICh1bmxlc3MgSSdtIGdl
dHRpbmcgLUVOT0NPRkZFRSwgd2hpY2ggaXMgdmVyeSBwb3NzaWJsZSBhdCB0aGUNCj4gbW9tZW50
KSwgYmVjYXVzZSAiZW5hYmxlX3NneCIgaXMgY2xlYXJlZCBpZiBFTkNMUy1leGl0aW5nIGlzbid0
IHN1cHBvcnRlZC4NCj4gDQo+IAlpZiAoIWNwdV9oYXNfdm14X2VuY2xzX3ZtZXhpdCgpKQ0KPiAJ
CWVuYWJsZV9zZ3ggPSBmYWxzZTsNCj4gDQo+IFdoZXJlIGNwdV9oYXNfdm14X2VuY2xzX3ZtZXhp
dCgpIGlzIHBlZWtpbmcgYXQgdm1jc19jb25maWcuY3B1X2Jhc2VkXzJuZF9leGVjX2N0cmw6DQo+
IA0KPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBjcHVfaGFzX3ZteF9lbmNsc192bWV4aXQodm9pZCkN
Cj4gICB7DQo+IAlyZXR1cm4gdm1jc19jb25maWcuY3B1X2Jhc2VkXzJuZF9leGVjX2N0cmwgJg0K
PiAJCVNFQ09OREFSWV9FWEVDX0VOQ0xTX0VYSVRJTkc7DQo+ICAgfQ0KPiANCj4gQW5kIHRodXMg
YWxyZWFkeSBpbmNvcnBvcmF0ZXMgdGhpcyBjb2RlOg0KPiANCj4gCWlmICghY3B1X2hhc19zZ3go
KSkNCj4gCQlfY3B1X2Jhc2VkXzJuZF9leGVjX2NvbnRyb2wgJj0gflNFQ09OREFSWV9FWEVDX0VO
Q0xTX0VYSVRJTkc7DQo+IA0KPiANCj4gSSBzdXBwb3NlIHRoZSAjTUMgY291bGQgaGFwcGVuIGJl
dHdlZW4gc2V0dXBfdm1jc19jb25maWcoKSBhbmQNCj4gbmVzdGVkX3ZteF9zZXR1cF9jdGxzX21z
cnMoKSwgYnV0IGF0IHRoYXQgcG9pbnQsIEtWTSBpcyBob3NlZCBubyBtYXR0ZXIgd2hhdC4NCg0K
RXhhY3RseS4gIEkgdGhpbmsgd2UgY2FuIGlnbm9yZSB0aGlzIHVubGVzcyB3ZSBjYW4gZ2V0IG1v
cmUgaW5mbyBmcm9tIHRoZQ0KYXV0aG9yIDotKQ0K
