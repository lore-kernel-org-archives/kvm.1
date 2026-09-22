Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA934EF14A
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059746; cv=fail; b=D/oSiazKXDLPf5PTxNHBCrbGKsHC59Tu20kQQ1CbvCyHYm9DyFDXvH8koSOOiaXTYk6w7+oAQtdvjLDS4Fgprio1Up9nPO1Wu1rZOvJ4wP1PwqUJ3Ifq0YcJvj++G6hQIvMdhy/C35pZmbznja/zm1bDueSffktLvfJg9Ch6syM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059746; c=relaxed/simple;
	bh=bBwWHYCAxEipdWNpVW+UGz5bzlt//2qQwyiolTDXlD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nG2ugklnEsIAHajrxxsJTf9bxPHt/33ZkCuJ1DhueSQpwCl2sjQB7gkeFOdV7kjuIEwTa42sosvT1SPQ1TR1dW8mfndPNqqYpWw5c+I4w7FnopCKc1LiUUivNpT/VSyep8TSvV6h66LPKUeP1I57YjP3bmQDscUNXXj+leJ4J1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcDfPs1A; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcDfPs1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790059743; x=1821595743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bBwWHYCAxEipdWNpVW+UGz5bzlt//2qQwyiolTDXlD0=;
  b=gcDfPs1ADcFIFQzKsqr+DMU9yCOzT8LZuWmdQGBrLTfAXArgIeXW9Y2G
   wXx3ZyRYogdiP6Bj2bb3jxDo9uSrnlNVVpLHYzUHXyfpsQcqHsyvwo9+o
   xRfxvc6xBsFofBAA8oqlalUv/BFN+PBvAL8qOQughc8pPRR3d8UTln0Ab
   um3X1yImazlV+z26qpyFExX66Rc9dSUUrSLV7G0kfz4e1SUU1Xo4h+YV0
   O0a0cFhPIILNX3bMOd+BNhykAQNdRTp3t3JgzaQ2gU4TGa1xgfKN2HpYs
   DmmQQNmo6uPXvNU5tO0i84oo3+5f8VcKa4WIOFSDnPztjSfeSkBAXa4UE
   g==;
X-CSE-ConnectionGUID: bPNsblBQRuKpDilGytC8/w==
X-CSE-MsgGUID: yqT31boxSfupSsGY56aHMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1137017"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1137017"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:49:00 -0700
X-CSE-ConnectionGUID: SKRfQD5USXukcHPQxL9QBg==
X-CSE-MsgGUID: 2UAZfGeUQz+oO6aq5AG0lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="299238402"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:48:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 23:48:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 23:48:58 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 23:48:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMPfHd3AfpBLDRHzsu0OXJ6Mmj+dBkmMbf9KmWMGIEVKTuZSdrjxFzxF2mUqet+UWCXtXUR+ynye2aQ1r0kAI/5rpGVow6yT2fKHs7155A28P+GhZW9iEqiL6C1aW7ViQEk2phksryN+nolnMpuGmaw0/Q0qMYRRWEDDXFTo2sa9IFkDKsbItI/fbeYdO+2wqU4jG8zegK+VnHhUFNgPaiZgHAV3Ou0w8cRt70UtgmUN0nL8YecunsbEdwgrVbTb5pWQrSQCUcDMEAJnptqEISc2fBAeKztLofzFQahCKkUgY8e4LMSnul74Z31hnBdjNJWvHGRExpnbHgniBFEA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBwWHYCAxEipdWNpVW+UGz5bzlt//2qQwyiolTDXlD0=;
 b=wIglTsWMGgRe+t6MrdeIw3MCq94QKdNRsEXZh7WuLH70ynV3JpEhwMj0fVTa/SsKSsDBwOLfjpUudkjsHPu3l2vyrDZKoaqGXPbBwFYNMPIfNPPXGk57hGcS35riWr9kNNtfzlVckTqz40TaoPoLWPIZXpjhJgDH9Qrn7ysgJe1cJfjzbaS5z02MIDlDeQeCMten2EkIF5/OK1A99aelfFK1EmqlKJze5TgtU4xYpqnsabSIOxH2/NP+am/RYs7EwSCO1vZJJ82QnTOz3wdiFORRVlrXdJTf4FY6BNxIQVCtHI4TT/cUFvl3fHvZDLfKDXJ64lR4Ek+SwMU3ZWT0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFA84FA90FC.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::43) by PH9PR11MB459651.namprd11.prod.outlook.com
 (2603:10b6:510:413::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 06:48:55 +0000
Received: from DS4PPFA84FA90FC.namprd11.prod.outlook.com
 ([fe80::3d16:f788:d216:291f]) by DS4PPFA84FA90FC.namprd11.prod.outlook.com
 ([fe80::3d16:f788:d216:291f%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 06:48:54 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, Sean Christopherson
	<seanjc@google.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, "Annapurve, Vishal"
	<vannapurve@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Fang, Peter"
	<peter.fang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: TDG quote analysis
Thread-Topic: TDG quote analysis
Thread-Index: AQHdRXUGnV1D6jtpckytZt9IbBOCMLbRf7KAgAANsICAAAqMAIAAM3uAgAAIGQCAAA/ugIAAEEIAgADUxICAAEy5gIAAHYGAgAAafICAACp6AIAAK0aAgACxHQCAAFN8AIAAN/OAgATQzgCAAAQOgIAABL6AgAAC3ICAAAS0gIAAamdg
Date: Tue, 22 Sep 2026 06:48:54 +0000
Message-ID: <DS4PPFA84FA90FC58F88D79B0EF19B34596E7832@DS4PPFA84FA90FC.namprd11.prod.outlook.com>
References: <aqxGN2Zc8sOl2RKx@google.com>
 <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
 <aqyAED5ZK48eEZtq@google.com>
 <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
 <aq048KmPN5WPQ4sQ@google.com>
 <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
 <aq2t5wJGLtsltMza@google.com>
 <de659c43-4121-483b-acbd-e1c4f89e4e80@intel.com>
 <arG7delLjerkKbYQ@google.com>
 <2df88806-4583-4bf8-b699-43eb6217399b@intel.com>
 <arHB1SACk4Z9kJq3@google.com>
 <07297a47-9dc8-4e46-bb5f-fb228ba6447f@intel.com>
In-Reply-To: <07297a47-9dc8-4e46-bb5f-fb228ba6447f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFA84FA90FC:EE_|PH9PR11MB459651:EE_
x-ms-office365-filtering-correlation-id: 2160592e-216b-4d5c-cf5c-08df187591dc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|3023799007|10067099003|11063799006|4143699003|56012099006|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info: O/kzH8LX5voNjH16fdkYyCLku3tZg2rCmYXZ7DyONMBDjcRYuwnwzZ2518m9MFlXECldRU6ZP7j51dh1Q68kXrWb1p9G7HMFNY+D75uouIxokRpYnvdJAplp7GnzQ2IuZSlhX2r5fCRRhlYG++bULtRDPp3MsOs1JWxb81Q0CtOQCmdpPJpuY5FnqXfX9yiOVG0A9pZTdMT55/Lhy2+poTUrlj1kUoGXVC5sUG8x7sM4yN2ymJH9QNmYPECO6ePYRZ/mcUBGKXfo0XekKqoJoKouG2iuLFkMlrawLx9sWjdvsa5cOvNsOT355/xT6HWUNw57+buEQ3DG5gEcDrwZtFURFu/lW3tFIrrqGtG8QoG1c4NV4xsiSkSkTOidOplOC0HEZNixaRYWuv8uPUtrOfBaThycJ5CJDVcVHqTuDEiSuIPZY0GjSvnNysowpSTwU5ogCbqC3TfqgH9vbTwcjJxK6Y2pE9lVXpR9/i7Tzp8ycEA1L5VtT9QFclJ7mpPsdb+qgVbhaX+eJwwimn+mArbECS+5IFyaEmY8OY1p6MNkCped7+nlfMvTRCgcEgnqorVcs7vzEs5axEoLNrQnB/r0UiK7Llma7QRxPNhsLo2Yz6qTxjUCCJfVEZjaHK+dKJLr+qeDX1tPgR8h1IjUvewK5A5Ni2JOxzL0KmsWggXSmQLHv4VJhAkuZv9b0KxQxwOXz+zaRqSzqHI3vB1HZHVgygYgcsxNm/O7IkfpuMc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFA84FA90FC.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a01CL3g5TUMydzg0anNhcmliMUlBYXlQQXdHUXlIWDZRdmtVNDZYdWl0YkZ0?=
 =?utf-8?B?TnFKdkh6eVVhZS9LY1l6WkxjcHJzOFI5VjdaVkpQb2hEaWJpTzIrcWhrM201?=
 =?utf-8?B?TDBvcFZBODZvMytSNE4yVTZkWlVmSmFPZWkyTExLVjV4YkFFdWF1N21aYnNo?=
 =?utf-8?B?Q3dFVThPWUQwcnVPNHhLMlR5b3ZQVjYyR2x4eFBOa3RSb3U0dWMxU0g1a05C?=
 =?utf-8?B?UGdTK2NESFFsT2MwaXRESnhDRjNxVGFDS1VTOWZuQkxvSC9pbkgyL3R0SE1B?=
 =?utf-8?B?NVMvMWlyTmU5ckhIb2tOZmdRclZhR2hlSlNsYytQeE1VWjllekRBWkJKUGlT?=
 =?utf-8?B?RUtxTkVYUWNhSjMwSVdUZTRrcEJrSVhPejRHN0hPcUZCWkNnWWxkNU9kaUNx?=
 =?utf-8?B?TUpXZU1GOGVQRlJlMXZsZUZLUHZXdW50K29XOC9zV2pvNTVyU1VnbEM5VVFz?=
 =?utf-8?B?R2FUVHkzNFhicFZ4b1FsNGxRaXEvdWhNM2lFQUlXV094cmlLb3lOc2pnS0x1?=
 =?utf-8?B?U3pWZXlPa0UvV0N1cWRpM1NYalU2RVIyR3NFK21nK2dPMTNlTUptRkhYYmJ6?=
 =?utf-8?B?SStFcVllMlhCNEw5ZEg0VGEyV0Y5NUhjRGR0SVpqbUxvZXdoN1RpZE9zSmQv?=
 =?utf-8?B?NGxoSWo4cDNnUDNvKzhGL1FxV3dZeUdNclgrQTNQS054ZlZVOWxPOFJ1bTVi?=
 =?utf-8?B?ZGN0QjVJaG9JZG5EQVMxT3ZLTWRzaXNVV2pxQVM2ZUZmczRCNW81M2V2amdv?=
 =?utf-8?B?emp0Q3grQXkzQmZMSmtSTUtzd01vRjBMMkJrRGwwZS8rNTR0SGhXR25aaFFS?=
 =?utf-8?B?RUhkME5ZKzlCMlp0TXdaTmJjdlJZbkJXM1RLd1lNU0ZtYlIwVEJDSVJDcS9v?=
 =?utf-8?B?OVZlQTZBeXpReDlXTHZhL3ZQQkorVE1sTm9pRVU5OXJIRFN5OXhJaGNObWNj?=
 =?utf-8?B?K3NwaHZuM1JWckcwTCtGcEdZTlJUd1RlZ2RRLytUZDBXbEs1WE9xOGVwd0R2?=
 =?utf-8?B?QmMvZ0wvWjU0ckJJZ1BaNGkxWUVBbVFpL1FTOVAzSllxVXhLU0NhV3RIMCtm?=
 =?utf-8?B?cm9qVk5mbkt5bzVZQjdQelRqR3p0azNmRzlxNEMzNVhxSmRNLzNGL1AxR1Js?=
 =?utf-8?B?QnlRNithTHNGQ2xacE9TZ2MxSWg0OS8xMlhEVGJ2azFBdGN6ajNzL1NhWUtq?=
 =?utf-8?B?QVdhWWdZbzF0azNsTFc0cUFiUDVTRW5OTFcrU3g4M0dKNG95OWs5eDlpc21v?=
 =?utf-8?B?YlhqcExiVXRicWtIbWF2VXFnNnpnazJzY011SG9xREN4ZC9UNGNXQ3pNKy95?=
 =?utf-8?B?V0J6dTY1eGpqNmxaODhONThYaVI2WTRtTUFXRFFRTytxdE02RTBuemxIT3pz?=
 =?utf-8?B?UnlsRlRweGJ5aHVEK3psV0hGcmkvQ3FEMXZuVm5WNUhuNlBkR1YxbWprMEV6?=
 =?utf-8?B?b2d0cGhBVEZXT1lKbll6b1VOUmxSWXBYQzFoTUNDVVkza2FqaXJHaUhZbmll?=
 =?utf-8?B?WjA4RTlWQ2gvVkEvNDdKVTVJNjZ1NFNVYURBTzJGQVY0YnlWZ2tQRFFRNjFh?=
 =?utf-8?B?U05vMExEdFU3NWsrK0I1VDdLVGNna2ZzZTc1ckptVG1KL0hWUlZEb1pkbWVq?=
 =?utf-8?B?UjR0eUpjNHVtbzFKUXJwR1lwQlFzRForbE1pSGRVcjZXK2NtV0ovSzJ2L3RR?=
 =?utf-8?B?bEgwckhIby9oOVE3WjZzaDlIVGtJaTRxM1F1Sy9UTjRzRWFLb0xBVHFBeEVQ?=
 =?utf-8?B?WDhtNjMyUktRdWxsWTJXR1VFRE5nWTEya0txU1RhNWZLQ284QXRNQ29RMFM3?=
 =?utf-8?B?Vm5WQVQ4WS9IQmJ0WUdCNWlkSmo3dlJhUER0VDJ4YzBRamptWHZ2djFic042?=
 =?utf-8?B?ZUFseXZXU1dobmFkNTlMemhiVnRJL3pFS1JVL2VsZkRqZjg1YlNQSy8wbzFX?=
 =?utf-8?B?OWMxYllaVjZpaDduNzdhbXBESUdacHFMd3dDRUxhRUFTaWlmK2hiV1JCMHBs?=
 =?utf-8?B?RERsWHlINkwzL3JRQzV4ckIraEd3NU5YQlZraU1ILzBlSFlOL21tRitiMU9j?=
 =?utf-8?B?Q09rNDFYUndHMGxuSGpnU3RjWFZERkVvYlg4SWtVVlBUbkFTVGhmYXg3b1ZH?=
 =?utf-8?B?b2lYNEJkalRSUnl4dFRpU3BNVW50SjBZczJzZmdCYzlSazhDS2dzWlk5RDM4?=
 =?utf-8?B?SFgveGNHZEp3S0dUNmROYWZVTHlhcG43YmRubHlsbHBEK3Z5clRpYmk2ZTdN?=
 =?utf-8?B?enp6NVdNTUEvc2kvT2tzcThKMmVTVHJWdzJZYmlHTC9tTCtqamNmY0JkNUs4?=
 =?utf-8?B?cXg1aHRUNnRQWUpIbnorZ2RnM2xDeTVwZnlTeHk1dUFUNXowblN2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xx7V8D8PcQr1DqzmDMZ+W+HF1d+dwmp6wcI+1OPmff8yF7SCKtV2FuthkT0hPzkqOKKbW/FIaQRgRb2GD1JxROALv617MCM2b9PT7yvK/uj7/GHZ5YYSOZ/oVR7MmKdCDx7C2lxZv1TI2KMuG/EeWXKhyL2GHDRmh5SwZs+pKN+cpbcmOymIxSbB/szMAipKOpfMbnVKQiu9V5sLzqBNqXSzm5EyCa2KEZNJNRVfq1My/GdletAkKgucoRw5bclM2TbV07rR9cJYV5Vi9goLI0GaG27UsYWUdQKly+CFtbxmiRzNnGY8WA5iYYQEnH9ZWXNjt+kuKE2dcgWzFsaw7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFA84FA90FC.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2160592e-216b-4d5c-cf5c-08df187591dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 06:48:54.6713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQlWv+x/CTd6cNOc520/eLrOIay3nNv2qUOkQ66fZMKLtRx+/FeP7zUZxAtq5cLH3RUZNEp+dLF1zUbFL5hYoPl7hwjvdBCAvXu+GvjK4Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR11MB459651
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFuc2VuLCBEYXZlIDxk
YXZlLmhhbnNlbkBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyMiwgMjAy
NiAzOjAzIEFNDQo+IFRvOiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4N
Cj4gQ2M6IEVkZ2Vjb21iZSwgUmljayBQIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT47IFh1
LCBZaWx1bg0KPiA8eWlsdW4ueHVAaW50ZWwuY29tPjsgUmVzaGV0b3ZhLCBFbGVuYSA8ZWxlbmEu
cmVzaGV0b3ZhQGludGVsLmNvbT47IFd1LA0KPiBCaW5iaW4gPGJpbmJpbi53dUBpbnRlbC5jb20+
OyBBbm5hcHVydmUsIFZpc2hhbCA8dmFubmFwdXJ2ZUBnb29nbGUuY29tPjsNCj4ga2FzQGtlcm5l
bC5vcmc7IHBib256aW5pQHJlZGhhdC5jb207IEZhbmcsIFBldGVyIDxwZXRlci5mYW5nQGludGVs
LmNvbT47DQo+IGt2bUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFRERyBxdW90ZSBh
bmFseXNpcw0KPiANCj4gT24gOS8yMS8yNiAxNjo0NiwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90
ZToNCj4gPj4gT2gsIGFuZCBmb2xrcyBjYW4gX3RoZW9yZXRpY2FsbHlfIGRvIG9uZSBxdW90aW5n
IGluc3RhbmNlIHBlciBWTS4gQnV0IEkNCj4gPj4gdGhpbmsgdGhlIG92ZXJoZWFkIHBlciBxdW90
aW5nIGluc3RhbmNlIGlzIGluIDEwME1CIGJhbGxwYXJrLg0KPiA+IE1CIHdpdGggYW4gTSE/IT8h
ICBXaGF0IT8hPyAgIEhvdz8gIEkgd2FzIGFzc3VtaW5nIG15IDMyS2lCIHRocmVzaG9sZCB3YXMN
Cj4gZmFpcmx5DQo+ID4gY29uc2VydmF0aXZlOyB3aGF0IGlzIHRoZSBURFggTW9kdWxlIGRvaW5n
IHRoYXQgaXQgbmVlZHMgMTAwTWlCPyAgVGhhdCdzDQo+IGluc2FuZS4NCj4gPiBUaGF0J3MgbGl0
ZXJhbGx5IDN4IHRoZSBmb290cHJpbnQgb2Ygc29tZSBmdWxsLWJsb3duIFZNTXMuDQo+IA0KPiBG
aXJzdCBvZiBhbGwsIEkgaG9wZSBJJ20gZ2V0dGluZyBteSB3aXJlcyBob3JyaWJseSBjcm9zc2Vk
IGhlcmUuDQo+IFdvdWxkbid0IGJlIHRoZSBmaXJzdCB0aW1lIEkgdGhyZXcgYSBjb3VwbGUgb2Yg
MCdzIGF0IHRoZSBlbmQgb2YNCj4gc29tZXRoaW5nIGFjY2lkZW50YWxseS4gSXQncyB3aHkgSSdt
IG5vdCBhIHBoYXJtYWNpc3QuDQo+IA0KPiBFbGVuYSwgYW0gSSByZW1lbWJlcmluZyB0aGlzIGhv
cnJpYmx5IHdyb25nPyBJIHRoaW5rIHRoZSBpbnRlcmVzdGluZw0KPiBudW1iZXJzIGhlcmUgYXJl
IHByb2JhYmx5IHdoYXQgdGhlIHNtYWxsZXN0IHBvc3NpYmxlIGV4dGVuc2lvbiBURCAoYWthLg0K
PiBOUlggVEQpIGFyZSwgYW5kIHRoZW4gaG93IG11Y2ggZWFjaCBxdW90aW5nIFREIGFkZHMgb24g
dG9wIG9mIHRoYXQuIEFueQ0KPiBjaGFuY2UgeW91IGNvdWxkIGZpbGwgaW4gbXkgaG9ycmlibGUg
bWVtb3J5Pw0KDQoNClRoZSBjYWxjdWxhdGlvbnMgZm9yIHRoZSBtZW1vcnkgb3ZlcmhlYWQgd29y
ayBsaWtlIHRoZSBmb2xsb3dpbmcuDQpMZXQncyBhc3N1bWUgdGhhdCBtYXhpbXVtIG51bWJlciBv
ZiBURHMgb24gYSBnaXZlbiBwbGF0Zm9ybSBlcXVhbHMNCkxQIGNvdW50IG9uIHRoYXQgcGxhdGZv
cm0uIEZvciB0aGUgcmVmZXJlbmNlIG9uIEdOUiBpdCBpcyAxMzc2Lg0KU28sIFREWCBtb2R1bGUg
bmVlZHMgdG8gYmUgYWJsZSB0byBjcmVhdGUgMTM3NiBpbnN0YW5jZXMgb2YgUXVvdGluZw0KU2Vy
dmljZSB0byBoYXZlIDE6MSBtYXBwaW5nLiANCg0KRWFjaCBURFggTW9kdWxlIGV4dGVuc2lvbiAo
UXVvdGluZyBTZXJ2aWNlIGluIHRoaXMgY2FzZSkgbmVlZHMNCm1lbW9yeSB0byBzdG9yZSBpdHMg
c2Vzc2lvbiBhbmQgVkNQVSBzdGF0ZS4gVGhlc2UgbXVzdCBiZSBwcmUtYWxsb2NhdGVkDQppbiBv
cmRlciB0byBndWFyYW50ZWUgYXZhaWxhYmlsaXR5IGF0IGFueSBtb21lbnQuIA0KU2Vzc2lvbiBz
dGF0ZSBzaXplIChTKSBkZXBlbmRzIG9uIGNvbmNyZXRlIFREWCBNb2R1bGUgZXh0ZW5zaW9uLCBz
b21lDQpoYXZlIG1vcmUgaW5mb3JtYXRpb24gdG8gc3RvcmUgKGVzcGVjaWFsbHkgdGhlIG9uZXMg
dGhhdCBydW4gbXVsdGktc3RhZ2UNCmNvbW11bmljYXRpb24gYXV0aGVudGljYXRlZCBrZXkgZXhj
aGFuZ2UgcHJvdG9jb2xzIGxpa2UgU1BETSksIHNvbWUNCmxlc3MuIFF1b3RpbmcgU2VydmljZSBp
cyBsdWNraWx5IHRoZSBvbmUgdGhhdCBuZWVkcyB2ZXJ5IGxpdHRsZSwgYnV0IGl0IGRvZXMNCmNv
bnN1bWUgYSBzaW5nbGUgNEtCIHBhZ2UgKHNtYWxsZXN0IGdyYW51bGFyaXR5IG9mIG1lbW9yeSBh
bGxvY2F0aW9uIGluc2lkZSBURFgNCm1vZHVsZSkuIEFnYWluLCBmb3IgdGhlIHJlZmVyZW5jZSwg
VFBBIChTUERNIGNvbm5lY3Rpb24gbWFuYWdlbWVudA0KZXh0ZW5zaW9uKSBjb25zdW1lcyBtdWNo
IG1vcmUgLSAxMjggS0IgYXQgdGhlIG1vbWVudCBhbmQgaXQgbWlnaHQgZ3Jvdw0KYXMgYSByZXN1
bHQgb2YgaW50cm9kdWN0aW9uIG9mIHBvc3RxdWFudHVtIHN1cHBvcnQuIA0KU28sIHRoZSBmb3Jt
dWxhIHRvIGNhbGN1bGF0ZSBob3cgbXVjaCAqdG90YWwgbWVtb3J5KiBpcyByZXF1aXJlZCB0byBz
dG9yZQ0Kc2Vzc2lvbiBzdGF0ZSBmb3IgYWxsIGluc3RhbmNlcyBvZiBhIGdpdmVuIFREWCBNb2R1
bGUgZXh0ZW5zaW9uIGlzOg0KDQojTWF4X1REX2NvdW50ICogKFMqMisyKQ0KDQpQbHVnZ2luZyBu
dW1iZXJzIGZvciBRdW90aW5nIHNlcnZpY2UgYWJvdmUsIGdpdmVzIHVzIA0KDQoxMzc2ICogKDEq
MiArIDIpID0gMjIuNU1CIHRvdGFsDQoNCk5leHQsIHdlIG5lZWQgdG8gYWRkIG51bWJlcnMgZm9y
IHN1cHBvcnRpbmcgc2VwYXJhdGUgVkNQVSBzdGF0ZSBwZXIgZWFjaA0KUXVvdGluZyBTZXJ2aWNl
IGluc3RhbmNlLiBNYXRoIGlzIHRoZSBmb2xsb3dpbmc6DQoNCiNNYXhfVERfY291bnQgKiA2ICh0
aGlzIGFzc3VtZXMgbm9uLXBhcnRpdGlvbmVkIFREcykNCg0KUGx1Z2dpbmcgbnVtYmVycyBmb3Ig
UXVvdGluZyBzZXJ2aWNlLCBnaXZlcyB1cyANCg0KMTM3NiAqIDYgPSAzMy44TUIgdG90YWwNCg0K
VGhlcmUgaXMgYWxzbyBhZGRpdGlvbmFsIGltcGFjdCBpbnNpZGUgU0VBTVJSLCBidXQgaXQgaXMg
c21hbGwgaW4gdGVybXMgb2YgMzBLQg0KdG90YWwgZm9yIHRoZSBhYm92ZSBMUC9URCBjb3VudC4g
IA0KDQpTbywgdGhlIHRvdGFsIG1lbW9yeSBjb3N0IHNwZWNpZmljYWxseSBmb3IgUXVvdGluZyBz
ZXJ2aWNlIHRvIHN1cHBvcnQNCjE6MSBtYXBwaW5nIGdpdmVuIEdOUiBtYXggTFAgY291bnQgd291
bGQgYmU6DQoNCjIyLjUgKyAzMy44ID0gNTYuM01CIHRvdGFsDQoNCkhvcGUgdGhpcyBjbGFyaWZp
ZXMgaG93IHRvIGNhbGN1bGF0ZSBtZW1vcnkgaW1wYWN0LiANCg0KDQo=
