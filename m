Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169653A1A5B;
	Tue, 31 Mar 2026 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953424; cv=fail; b=RNPl3bwKDJkPlu27OLILEzdQYkX8d4N/ZE6VR/Q3+bLrljfJPWo+H/vfU2CaL8Ty56jyQ5YffAQAfABRxHA6l2+i1KZNxKSlXQBOhG7UxTSwiCUUBHiyuYFIH663PClMJktb+82ZHK/8Qyyq6x8AuEg5eohnv0JWvJSlAUAYDsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953424; c=relaxed/simple;
	bh=sAcPqZOa8hiz8tsWf3MHy/RIBaJZYswCFVIPVa21Vos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ppspeXp6miQcz2nLtoCWgY86gi5xdmQ/ivUos9Jd4SdAEVzAPxVjWCZUyoqGoYg10hHBVDYBLrGY0mFfrgukE1bIlGoYk8C+dvZTU8f1PMh+6HDmMSRdxUYCf1jDsiT6E2uvkYSwA/Lt2Jq/RwAvNNDLtd27OMjX80z2v+1k4zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6ucDgnY; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6ucDgnY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774953423; x=1806489423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sAcPqZOa8hiz8tsWf3MHy/RIBaJZYswCFVIPVa21Vos=;
  b=Z6ucDgnY7rHR65ofkOZ3toJHAai6W6fcHEXQNc8598+zHsfR5D6i5O12
   eTzXTsKLuOVUD40m76en9/hnP3QKXktsUYgdSPBJwTuUj7QaEwpPh5Ctu
   1/mR/PtVxNoq/qGK/bNJJ5+KAyOwvUY/N+qOmowfdaeYdgpJ4XQ1fRc12
   niaH7Qho5wg/FzOQeY1uPtUKzrA1Opnl/6P+1/ZIMPwEXTN9u8jNnXKdG
   cV35mKFJywxg+eg/P6CQKdw6cE5bJ76MjZUQnrCkFscbkzqNC0RbGZtH6
   HjItKfVa1ArVZ8fmsotbY4T6mnIpFoq65RVYRIrOzUaDmPVnTxenvPpOw
   A==;
X-CSE-ConnectionGUID: BBC1S9TPSDW5BXz5Meg1sw==
X-CSE-MsgGUID: 1PFj8XLRT32Tx5tZQb1Hpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93545736"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="93545736"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:37:03 -0700
X-CSE-ConnectionGUID: uPOE4ICZRnaOvxOOsQcMIw==
X-CSE-MsgGUID: ht13R69iQYmbuTJ4nk4d3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="230397304"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:37:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:37:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 03:37:01 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:37:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvplWdfC49wVj7CJuk90IFyVEQS653Tv5KoSAAgJzYMWyCbHXtIim15bq+cmmFfvbzwvipHWd0X1/M/S/KtPpfJFWOY/qqsKHURyMAHnA1LK8iKuwwAX6fcaeNXE5+kVCneyOIDnqZUZkYsWkcX44t0NZOBSv46eyHGt5EIbbcS5jMo5yjOQUkzrE3M/BHYKndYDdMKLoDyiaBaHKD5WPVa1KHUc0UJQWqA8pWDaKOVJPPeNLk+zLSWbzAo0b1Ra1CD3EOzPAqucW1YxulLvZ8WMJRBTsqu1Kjq1efuU+ZpmBoBOVNCwpFksyICsCYgdtthd0FxEtu/rxDpbFVmaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAcPqZOa8hiz8tsWf3MHy/RIBaJZYswCFVIPVa21Vos=;
 b=XQTM31lSmf2Q70g0MV4Zbr2YtNZkefHj7/xKWHVqnWa7Gv57NFr61d2NJLLzc+aPYg29oete/URdprTZ0YEqWe1rN7/knmtA4l0WNCNJhoTlY3FbUx9Wmd7OTt0ClHZelF4WCwoBWut7E1EqVeUOFoJvedvLThSKTuC4upaBBarEUlz9sylLvFsTKAfyVmvsGSf2flrukDss7ULZUH/unDjWllazQr7LoFUGHEsO4H3SztQ5ApocVSgCBlpjf+sG7GZAK/JFRFNdF2o2ZknSs9tSPu8IGb2lpv+YJzFtWAcvUuJX4r/Ue9QtBjXpP4xauksSwSqsvqL3M8e+grr6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH3PPF25FF87461.namprd11.prod.outlook.com (2603:10b6:518:1::d10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Tue, 31 Mar
 2026 10:36:58 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 10:36:58 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 11/17] KVM: x86/mmu: Fold set_external_spte_present() into
 its sole caller
Thread-Topic: [PATCH 11/17] KVM: x86/mmu: Fold set_external_spte_present()
 into its sole caller
Thread-Index: AQHcviZYTyrvzbif9k+ouMqQl04+obXIeEmA
Date: Tue, 31 Mar 2026 10:36:58 +0000
Message-ID: <555dd3a1ea3ec84c8f18882ddf3a1353206fc07f.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-12-rick.p.edgecombe@intel.com>
In-Reply-To: <20260327201421.2824383-12-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH3PPF25FF87461:EE_
x-ms-office365-filtering-correlation-id: db4168ca-9cdd-43f5-d3fb-08de8f116f89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: YwbV2zKPLQ934Zb/MyrsadV2DUyCPXhprPXjsndDuIYkCHvHuCTANvceEmG0A79etwHsGIW/25SQ+MHFQidXM8Wh8Vrmv7jjp66mj1gaJdNOtyY0KPSjfWwaGiwOPuicy6a+x9662fjNW4jwNEUQtPZuCvlAdSILVedZNHiy7U8X3joi82OyKv7N2ud1zZkxSUNww9au4ytQnPqbkYrNJHhelCYDQqtWTucZHwHsIXAyzVFSeXiGKnbEyRnFczHEVXlSnW98NYJXDgUqJzdhAF1+y5oi0tkcipsUOIyWIwybu2yb7AQTzhRXh5JRAercB6sSGBEHsPLKe14exVv6q7FHhOKRRGbXbdJlhIqaUYOpcBeNoTuLE9K75UkkvXwn5Ptg6qn02H0ObbUWFLtfsv7c9c545bBed7HvNFpvKDG+tHfX+ZZUCHOOmwzRmEf9AfpUMt0ELpOghLHA+SH4LSDnhKnD0qr7GC/229OmmVq6DNX7404idvUldWYo7f72TQUuDg7xpK2POHLrjrgHOzSpFpvyrolqm0i/b9qm3RFoWe1iOe/jmXdCp+ytNBvTxS14agZI4xOAXw0f3vi4fXSmupJntSWPDa0ECPEp/0TPNAuXaFSAQJZh85EoDGw8FgYnG03ihATaimANxAFEwBJL4N0rcpPTnDK5z5SqdUlQue1xec3PhyibXkb9ksSaR4mq4LdcFLgJCZyju45l7ADO4S6EJTTtsd1EcTozW18+R7qr1tTlLfAjL2/GwHl60llWhINEli89GDWzD1Z8td4mQ3A2dfP9G5Q8H+NmupQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkY0UG9NTHpreDRqRW5PNG1xeGRTMFhUVDBRSjA1Q2kwWU1ReXc0OTRwKytC?=
 =?utf-8?B?Zm4yY2dBTURNcExUQnpPYm1vR1pYS2tSUGc2ZW93eTRzUmNLZ0VrcUFOSTcy?=
 =?utf-8?B?NFRhWnIweVFpK0tuM2tBTEZBS1BFUVVObHRndFJ3bThmTFdrQ1doS2Rac3FH?=
 =?utf-8?B?WDQwSU9Xb0ZsalFmSzk1bEJRRkxnYnVaMGVsTVZkVW1YdWczZTFDODlBT0dk?=
 =?utf-8?B?OU81RVFDaGx5d3Z1WG1tdHJiQ3k2Z1BKQi93dHhucVJsbU9PbUE3S25CQmc4?=
 =?utf-8?B?aXcxMzcvbHRaenVDT0pWSG85dkoxNU05SGxwNHN1SzVXbE14MnpXY2t3aWdO?=
 =?utf-8?B?bjFiVzA5WlBnMjhYd2dGcncxc3hMNXJMTnVYMC9WVmQyVFBGUlZEeHRaLzMv?=
 =?utf-8?B?b0VXcTlIWVUxUktLcFBjYndENGc2NXNoVFlySFdhMlFYQjNRSWtSKzBNRFR4?=
 =?utf-8?B?QkVNM0Y4QUp3MmRBSDA3bllqbEhjVG4rQytOVllWdDBYM0JXVmtmRnlzeXox?=
 =?utf-8?B?cUtLL3o5Zk1oTlE3MXM3Q0MvYnZIazh0MWhkZlNLZGdIWStOc3o0ZVNpa21S?=
 =?utf-8?B?VFMybHgrN3NGR0FFWWxaaTlnSlZIa2Z6TzdEaDluTnhiUjlETEZXNTgrYnRz?=
 =?utf-8?B?SEQ5Y29wbkQ1cUlNYm01YVN4bWRjRjNUbWhNWGoyRUpSVTVGdDRRb1hVL1l4?=
 =?utf-8?B?QkY3NEdOOWNlVzljMUpLclFjNXdQWG5YNGRIWWdWdWtTVzJtaTVLSGphcnZT?=
 =?utf-8?B?Mjg4a0xwU0M0OWRMNHB0Q2s1NDE2VXVZRHJOdmtTZFdYc0sxRm4za3Jma2Ji?=
 =?utf-8?B?YlRTMGh2clFBS3BHM0xHV2svTWNXZ3A2aUg0YUwyMEZTWGo0ejBUa2I5My9X?=
 =?utf-8?B?V2NRQzBiVi8raWpLUVFNMnYvdUZNVUIxZVZpWG9pRm9OYzViS3h5dmRPVnJh?=
 =?utf-8?B?L3JSd1hEUDczQVpXaFRwNHRrMkYzMHY1SkRtdkEzcGo1NnBGREJXVmdTS0hU?=
 =?utf-8?B?Tk5NNitVa0MrVFRncS9BNFErTVgzR1Jmejl2dkh4QWp3eVhkL1UxajJtZkN6?=
 =?utf-8?B?Y3J3R2hkclp2ZGFTY1hjb3hwNXpsVFBudkd2bWM1N1JhUzA4dUJSSnBoZmww?=
 =?utf-8?B?c0hXb3pMTmFscVc4cGk3ZXBPQWVNd1JmSWJMazVYTzRrYXJGT2hGWUNZcjls?=
 =?utf-8?B?MlpmM0lHTWhDZkZZMHBwU1NGWmNabTB3Yjg5bnEzOXJkaDVMQzdyeHNqemdj?=
 =?utf-8?B?L2NWWFpFL1BVWjNQd3g5OXNaa2R3N0FxdndDU0tUZHRZR3pkUDZ3TTg1TE1y?=
 =?utf-8?B?WVEwWEVIaDg1UmtlU1l6Q1FkaTdXUyt3bndibjFBbmpnb2dYSUxvb05aMW1h?=
 =?utf-8?B?UHV3QWJyQ3QyK1JCWGVnaUJuZWhvcDhOTWVhVjFuUWFXamtTSWdQNHhCZGV4?=
 =?utf-8?B?c2hRVG9Ia1ZZNG1ORlFVVzdtY2lkc05SMzZhVzZxRUJCMnhGYXZtU1JVTkw4?=
 =?utf-8?B?WWpTQ2Y4VDNsNTN5RmZ0a1VCWWZJZkpiL3psZDdiNTBHZFo2Mk9HWFdKd2FJ?=
 =?utf-8?B?cXB0Ui9MMHZsblhteHhUZytXZkZtNFFCaUxRS3hQcGQ3NE1aNnJOdFdReEg3?=
 =?utf-8?B?ZFAxSk94L2szdTZtMWowWmxmRDJrTEh1NnlvOFd0eGRHM25zcDdaTDM3ck9B?=
 =?utf-8?B?KzJxWHJteEJsSENlRGRaQUQwd3Y1Z21PQ01zYit6WjB5d0dDbjRyMTNCRk4z?=
 =?utf-8?B?N1A3RTM5MjJwQjIzcGFySmVOZXg1YTh4eGh2MCs5Y04yNUpNUHYvM3Uydm1h?=
 =?utf-8?B?eWdwTGh3aEhEODk4NFFwYXFiZnRLREJVZmZTUFBpdWpMdnc2QTZ4QUVmY29R?=
 =?utf-8?B?Tk5SR3dZUjdrNkdGeTY1RXdMS2J1SkpNcDRTWmxsQ2pyc0puNGZWSm9OVkIz?=
 =?utf-8?B?UHo5dnJTQUROTThKbyt2WnlCWWMwUkF2NVJmNW0vck0zQTh5YmEwbmcyTHZM?=
 =?utf-8?B?SS9uclJZK29kTHBhZllJdkxKa1NuelV1cGZYRldlRW51SEhjQktPRHJab3o1?=
 =?utf-8?B?NU9Qd1luNENGMDAvYVZkenNTZ0xYWlhFVmxDNW0wVHBnUE45cmh2b0N1M2Js?=
 =?utf-8?B?ZDhGY3dYdklUS3FiNUxTWWxkZmFtRHNFRWFxaXVLVjU0R2J0cTE4UndseXd2?=
 =?utf-8?B?a0wxN0R4c2plSDBWV1ozZGVmTFdaSC9YNmdiMVkwdmxkVWVscW5NMDFHRitP?=
 =?utf-8?B?NDh2K0NxVVkyblBWb3FTZHBRNlVTTHZYR1JwSytQaWIxMjJKMERwbXFhakxl?=
 =?utf-8?B?aUh4U2tUZ3hibGRxNGNsSUlGK1RialArVGZYaWJFL1FmaytLa2FIUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <848EE05E9E29D34F912B14544F35F5D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ah+f7PCmkzUKsasI5ZunCQ2/RSmeVEz/T8dTjjclknWFW3EYuubHBHKyWLLbNwPp7l7sTjA4UQ38PKqV4U12jGTjj614WD/7Tv5AqqikHcBkE4Yq3CZIoA9RL1WS6mBUSwx4a9uoLO7Ndsab7Y+5JQrqiB7V0J7CIo+ejEGq3cZlh9CpXqFbRkVloCwik3yV/F589ThdgNrMMrUT6panUXgNGmjQorQ1VLrUU2ugqghfMIKUcMf9Sz2VNeHSuyN3eNKvnmsnd6mH2FT9Ybc2OOfi0cpWJWizbm7ARxO0h0qtRGbekAihGBSvGaUPadfvEjIfLCU45ORAx+GpzbMa5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4168ca-9cdd-43f5-d3fb-08de8f116f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 10:36:58.1662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/2u5DNUk9NPxpWwXSylCvd31x62l/OW9ka6vPn9iKv9oRqQ6tZxc0EzqaDJ1RtD35eRRTo1KGLYqiGziM0KSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF25FF87461
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDEzOjE0IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gRnJvbTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KPiBG
b2xkIHNldF9leHRlcm5hbF9zcHRlX3ByZXNlbnQoKSBpbnRvIF9fdGRwX21tdV9zZXRfc3B0ZV9h
dG9taWMoKSBhcyBhbGwNCg0KRm9sZCAuLiBpbnRvIF9faGFuZGxlX2NoYW5nZWRfc3B0ZSgpPw0K
DQo+IHRoZSBvdGhlciBmdW5jdGlvbmFsaXR5IGJlc2lkZXMgY2FsbGluZyB0aGUgb3AuwqANCj4g
DQoNCmFsbCB0aGUgb3RoZXIgZnVuY3Rpb25hbGl0eSBiZXNpZGVzIGNhbGxpbmcgdGhlIG9wIGlz
IGdvbmU/DQoNCj4gSXQgbm93IGlzIGEgc2luZ2xlIGxpbmUNCj4gaGVscGVyIHRoYXQgaXMgY2Fs
bGVkIG9uY2UuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+
DQo+IC0tLQ0KPiAgYXJjaC94ODYva3ZtL21tdS90ZHBfbW11LmMgfCA5ICstLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9tbXUvdGRwX21tdS5jIGIvYXJjaC94ODYva3ZtL21tdS90
ZHBfbW11LmMNCj4gaW5kZXggNjc2MzUzNzA5OGVlLi44NWM5MmFlYzg2OGYgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L2t2bS9tbXUvdGRwX21tdS5jDQo+ICsrKyBiL2FyY2gveDg2L2t2bS9tbXUv
dGRwX21tdS5jDQo+IEBAIC00OTQsMTMgKzQ5NCw2IEBAIHN0YXRpYyB2b2lkIGhhbmRsZV9yZW1v
dmVkX3B0KHN0cnVjdCBrdm0gKmt2bSwgdGRwX3B0ZXBfdCBwdCwgYm9vbCBzaGFyZWQpDQo+ICAJ
Y2FsbF9yY3UoJnNwLT5yY3VfaGVhZCwgdGRwX21tdV9mcmVlX3NwX3JjdV9jYWxsYmFjayk7DQo+
ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgX19tdXN0X2NoZWNrIHNldF9leHRlcm5hbF9zcHRlX3By
ZXNlbnQoc3RydWN0IGt2bSAqa3ZtLA0KPiAtCQkJCQkJICBnZm5fdCBnZm4sIHU2NCBvbGRfc3B0
ZSwNCj4gLQkJCQkJCSAgdTY0IG5ld19zcHRlLCBpbnQgbGV2ZWwpDQo+IC17DQo+IC0JcmV0dXJu
IGt2bV94ODZfY2FsbChzZXRfZXh0ZXJuYWxfc3B0ZSkoa3ZtLCBnZm4sIGxldmVsLCBuZXdfc3B0
ZSk7DQo+IC19DQo+IC0NCj4gIC8qKg0KPiAgICogX19oYW5kbGVfY2hhbmdlZF9zcHRlIC0gaGFu
ZGxlIGJvb2trZWVwaW5nIGFzc29jaWF0ZWQgd2l0aCBhbiBTUFRFIGNoYW5nZQ0KPiAgICogQGt2
bToga3ZtIGluc3RhbmNlDQo+IEBAIC02MDAsNyArNTkzLDcgQEAgc3RhdGljIGludCBfX2hhbmRs
ZV9jaGFuZ2VkX3NwdGUoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX21tdV9wYWdlICpzcCwN
Cj4gIAkgICAgKGlzX2xlYWYgfHwgIWlzX3ByZXNlbnQgfHwgV0FSTl9PTl9PTkNFKHBmbl9jaGFu
Z2VkKSkpIHsNCj4gIAkJaGFuZGxlX3JlbW92ZWRfcHQoa3ZtLCBzcHRlX3RvX2NoaWxkX3B0KG9s
ZF9zcHRlLCBsZXZlbCksIHNoYXJlZCk7DQo+ICAJfSBlbHNlIGlmIChpc19taXJyb3Jfc3Aoc3Ap
ICYmIGlzX3ByZXNlbnQpIHsNCj4gLQkJciA9IHNldF9leHRlcm5hbF9zcHRlX3ByZXNlbnQoa3Zt
LCBnZm4sIG9sZF9zcHRlLCBuZXdfc3B0ZSwgbGV2ZWwpOw0KPiArCQlyID0ga3ZtX3g4Nl9jYWxs
KHNldF9leHRlcm5hbF9zcHRlKShrdm0sIGdmbiwgbGV2ZWwsIG5ld19zcHRlKTsNCj4gIAkJaWYg
KHIpDQo+ICAJCQlyZXR1cm4gcjsNCj4gIAl9DQo=
