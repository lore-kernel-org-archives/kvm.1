Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84422689C;
	Mon,  6 Jul 2026 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783370896; cv=fail; b=lzK/XSWR4nBFE3x5Y0TROhiE5SENMagWJ1PZzeflRaz0YYZZtW2djzpDJH26L/MQrI2mcnxy94yIXhAp8mT3IS0HqNJYQU8B7PuEqjyWSAXbHz0iyukIWeIOF/tKwAzxuBErN9kPw+J2KdSrAQmUsToOXIHYXWt2ShxDMhuRYlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783370896; c=relaxed/simple;
	bh=zJgw0Qv7uTYcjw8Y0IjKwiuzGpYXhwUhrB9PjUUBJfg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GiUPgtpW1FUqpWKzzd9xXKuxjimJ86vBvUgiZv//+RVXoe75wqzAMkLD1v5taHLWoibrFfJlYsYihrxVVJNeA325QEE7zPE1N9n4jKZVSR8uY72iubgpoj/cE3MRcyf8JedIishDzwP2GWU2CUM6dkwdr6awsNmnkZcxVNncboA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SuSjfzLS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuSjfzLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783370895; x=1814906895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zJgw0Qv7uTYcjw8Y0IjKwiuzGpYXhwUhrB9PjUUBJfg=;
  b=SuSjfzLSaaSU+g+12Lv/DqL+mS2q+d3qeaBfjVdgwjgNcrvCU7EBgSc/
   eUi+5EIexikAi0bZ97WQF2ObOUNhmsV2dqr42OjfvYU4kpJS5BpXkg2Pl
   z+j8cHeY5Ve50E7UhsTvFgkgVDFmYDfi2IYiNO6Sr5vM3tMvp9wb8qjBh
   ywCeYpHixThQoMjmDl8NWXMYOAeY5h5bsDmfcIAepit26Aauf6JnbV2Uk
   PppUfW1c/6v25FS20Lu14UfmwLqp5wSrB+9BfGagxr1GiyS/ng9TzTzWU
   hsoLwX2hxgx2Day2aSdpdkWS1lvhv0fzLrPVASjxoRnWq+HHlAmg6c0HM
   A==;
X-CSE-ConnectionGUID: 0AwJ+iF1Tq6USVhio8jSNA==
X-CSE-MsgGUID: kc+rYGK/R2ezevmbqSACWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="109558217"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="109558217"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:48:14 -0700
X-CSE-ConnectionGUID: uhp0gM/VT1WpseUY6PvKLg==
X-CSE-MsgGUID: sGKlwENsTF6BeOhelmwj4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="249819377"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:48:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:48:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 13:48:13 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:48:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abhKXGbYJ81lSA2Du0tvPGjXXaN8ZJTQNDBN3/9OghCzQB6t8GiJaHj+knItBgnr1lf4U6VgavUp5gjPSsGbaDxSCDt5Eu7OAgcc28BQuo2u5jKXmC1CQa8ecSBlp8rFf35jwiNoO7g/PeEeY1QO+bRSy+ubh9Kk6JzMPKZhS2XDx816ocCGyQHb4goE6uroY9GjdyD1Q0OmcSrH424yaLHUlq6jYOGj299CNPYEN99HcZE7WJQwmgxrpFZvF2jLuGHOECwJ/gJUc0EKOMDJ9eLQnYKtiO2JjvZzUGFAe8W+QcLUsuj+cAnCO2NoABPM622t3/DI0Ronuxvq3qpDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJgw0Qv7uTYcjw8Y0IjKwiuzGpYXhwUhrB9PjUUBJfg=;
 b=QolEMHXcnirW71V5ccPuaM+6MnW5Gpx5bUL1J7M2oD4UxSztAWCEOs53uq5itUaG1p5QxaaSjl0fl+aU+wwOd5DF258sEzlEvyZEUrnfIXmRlYCI8cgQJCLhmcBD9ObJuhHMeRTsxeEnYwnz8JppNx2X0lInMvOl/7Sqcq4eCTFN03eV3ig7FRr8b2RroeNHzqyaQ0ri35s3cH0mjoRYBcpMtA2BIk3KSE600CI+6/JHaF90v/xfd+V7pwAS+oh4EkEtb7ETcXYMx6l/4bmUAaHoyCPAoKLPxrbPHrnIqqB7W3sb4wmN8yX6BS2GvfA/QpoeYfq9qHl58FMboSxx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 20:48:07 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 20:48:06 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 10/11] x86/virt/tdx: Enable Dynamic PAMT
Thread-Topic: [PATCH v6 10/11] x86/virt/tdx: Enable Dynamic PAMT
Thread-Index: AQHc7LhTN6Vy5fBwVk+k2LlkQg5tWrYusbWAgADMaICAKJgqgIAJIcYA
Date: Mon, 6 Jul 2026 20:48:06 +0000
Message-ID: <471962e96dfb6a5ad5add10506573cec391b927c.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-11-rick.p.edgecombe@intel.com>
	 <aiGyIQvudD5ZF3lf@thinkstation> <aiJd4XTToKX20j/R@intel.com>
	 <6d87002a7484cd44687c78d60319bea283a78562.camel@intel.com>
In-Reply-To: <6d87002a7484cd44687c78d60319bea283a78562.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH3PR11MB8775:EE_
x-ms-office365-filtering-correlation-id: 72ae2fe9-00b6-499b-d8c2-08dedb9fe1e0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|7416014|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: RuxeLldGqC3lU4xBLxb7tIFMlIgE1YQrDSPtGJE2LvIJE2egA4KUVKrvCXS9zECLiFzDWLFgvGuajs/54XPpcFqt1t8RjG7URP+89edZqhs7yEHKPhKfvoeUO8ql5zaPAzJ9R+ardpUgMCukfDQJ4yXTzvHKcK955prmvmXIseeEVv1wpRAuGBRHrv6goQKVqucZyBZ+5MHaZe4UDoVuBPHLNDOSvpzUPaqUZVNDSgPH+/jclo4/rR5WD333zolnAEv1yLLrgaGT+u7aOQy37GVvs2feVEQR0x02GmRZk44xe8hUmJz+BbNN9OjLNMH2/r8p5KmW74BMqYj0ThmAbU1orpSBNBq56bNbcDSh+Jck0pZOi9/jgUfnApACMqgI9AvDKF15JOrU2TFgx8eP4sm7aX5UJfG7hKX3ZRZ9h8pJB1iy4V2fPjN5IWICxEYjKEqKPx8vzDxNd7X9nfO0hJj+RzTORPzgW07K5bdXLgxfT99JBljN0CgyCUV7Eku0hSFRvV7aC+KVVsJDgisQ1Z6F/cZXdbS2PnTLc5G7ZjiYQtg2eCOPA7tHyeIdEtqCOsH11IvOBz/3u+g4N6UXFs2by8Bj8kZXPzU9OJMnq+EaTyjtRR639XNZPcMjT0SWA6TV5Omwjxkx3bfgWMyf5HNr3bhKQkOSrGb7TSDZ6TckUDn8gaWHrUZKG/nkwMidhW1JzMRx2Dy9EU+D+esRZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(7416014)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWUrcWZGWVFvcUs0RnU4R05jN2h0U2xxeUpFcExMVHhhYlYrOCtET1YvVkZr?=
 =?utf-8?B?aGFrTklXNXNvelNJLytGdGxCUUIyT0llQmNJU01MZW1iOVlXV08za3lXMk5x?=
 =?utf-8?B?UjNxWFp4OEg4eDJDZzFMcEVFQWptRzlwbkNNQVFZVnlxdUt5UmFPSVZxRUZM?=
 =?utf-8?B?WjJTVWNiZkRaVWRNb2Rvc0Y3b1JMME1HWGcvSHIxQXNpamFkS21zVjF4aDRa?=
 =?utf-8?B?SFZqcTNrWWkrTjBmUEptc2lpQ3JvNGJoaWlUeFZsQ01uNEpXWS9IWmloSEdj?=
 =?utf-8?B?ekZ5Rll2OHlMUFUveHZhUkVMaFBvbGFOTWYwdVBnblB4QUJiK25tdVBRQ2Fv?=
 =?utf-8?B?dWY0OWg3MDBNTlZxMWQrQzhtKzNIdHd6bWFZS1BkNGhEY00zQW1aYk1zT2FY?=
 =?utf-8?B?QTB3ak5haFdTN0NwK1FucUlMRWRCUFdOQy9nWndRYmRURWpLMlVEY3hMa3NJ?=
 =?utf-8?B?cFVpQzR6Y1kzVTRhR2tPdkFweVliQnNiK1hpY2Fzb2xVcktaWURRT2NxbURT?=
 =?utf-8?B?YUNqUnozMU5ZNktaSGhIZzVkakFyVkQyenJwRHlTUUtZc3kxM0NMalU0Y05Q?=
 =?utf-8?B?dVgxOHRhMmMxSnpLbWFwaG5kTUVuWUdkQ2RVOTZJMUtWdzhyZVQvcEpZb1Zx?=
 =?utf-8?B?Qy9NcDI4OWRxYlFDQitVZXRHSmhveElCdlV0ZkE4TUlBaXpLelJ6Tmlyc1Iv?=
 =?utf-8?B?T2xlc1VHWXNlQVN1UERxajBKNW5IOU1oeFhlWjNTM042QXQzR0NCNFViaTE0?=
 =?utf-8?B?UDR0UVBmZFFSR2pnQ0tpanF2Q25iZGIxMlJSckFIeG1udnBPaVJUdGFnSmhP?=
 =?utf-8?B?SXpaRFYyV09WMGNNak02UXZJKy9lMk1EbFZZbTJQa3JqUzl0ckR0ZjRSZEZ1?=
 =?utf-8?B?TTFJWi9aUENrZXd4dk8wclN5R2llR0lQY2dtUFdJNGdBVm9UenUvcVRWU0lE?=
 =?utf-8?B?WWRFRlEwT25ndWR2Qld4TUg3UHN4Nm96SlZXek5NN0wzOEdEbUZUaTBYWHIv?=
 =?utf-8?B?dUNEUVZsY0tSN0VWSUhMU1lRdWljQTMzRnM0S2xGSWNtUHIvY0VhaE5mbDN4?=
 =?utf-8?B?TjRLK2VTN1NQTHd3Mnk4MCtSNU90cE80RFdQRXZxVkdjeHMrcjZEcnYxeC82?=
 =?utf-8?B?bCtGbU5STnhEa205SXBNUm5TMkJKblRuTldXV2hPZVZFTXZmR1N4eUY3UE0v?=
 =?utf-8?B?QkcxOEdZTGgwZ1VYK25oM25uREIyMWdNY3U4bXpuSHM4RFhsV1NCMmFUcUxS?=
 =?utf-8?B?YmRWaWNlRCs1eDlHUy93cjZPc1JBZkJFQ0tESW44TVVEWlVkSHBBMWxNNnBK?=
 =?utf-8?B?dEswYVNoNE16aDdwTGlSUTZnWjViY09wakhLS3BJRVM3dmlOSWE4eFFaMVVW?=
 =?utf-8?B?aEVFa0JqSXVnZ1ZhTEhDWVFlZEY0UUV6T2Mvdlg0eVRmQ1QxNlROYXlScVF4?=
 =?utf-8?B?SWVKMWVUbVlxek5ZL0xWSmNMMVJuTEtaVlJRc0llT3NDd090MEw4d2dnQUtO?=
 =?utf-8?B?OGxpVFIrSFV2TDZVMGhXZmM4U1ZkSjZ0OFkxSFdweU1QdHM1b0FyRW9JQWVN?=
 =?utf-8?B?V3NHVEdHNVZNZ21hVlJJMzNKZWNLbXRvcndmak5SQlFoVjZWR2pzMjVtZEpH?=
 =?utf-8?B?anpiak9jOVNnWTlyRFNoZ0h3VXBYbm5HNE5xdUFVR05jNkpjVHFBQ2pyRVBp?=
 =?utf-8?B?OTRsc29NRmJ2SCs3aVBxb2x1ejdwblR5TnNITVRFdnJVRkpRSzNvL2wveFh0?=
 =?utf-8?B?bVJnbGxzVGxXVk5LdVZzdjI1RXpjTzdRVTJUbHBUbFZPbTFac2kxVjAvcGc2?=
 =?utf-8?B?WFZlbVdwYjVGQ1R1cXpOU1dFTXY0S08walpocks1d1p3L3dFOUs0NjNubFdp?=
 =?utf-8?B?NmxDbXVnbXNRdFdPMEFCdHIrNXlGVzN0YzNhdTJIazhPNmw4ZDRGOXBBMGNz?=
 =?utf-8?B?N3pwdUpDRm5TOUdmTmg1T3dnSDZWSjJBbmtZN256SjF4N2xTa1FyTWMvaStB?=
 =?utf-8?B?VWd4VmRDV3lWTWVseW15THZWeUg4U2cxRHRvcEdwbjVNZ3JTM3pPazg0RElZ?=
 =?utf-8?B?WjlNVTZ1SXM3bWtWdy9UUUZiVmV5amNLS3NObjYrZEtQSnhYLyt1Y0MvY2JM?=
 =?utf-8?B?VVlia1l1QUhxRnl2ZWRVcmhvUzZiUzROL3ZFL0pjVjNaVy9XQ2pRMUJ2Ky9S?=
 =?utf-8?B?ZXVYYVRxdzhEbDVHREFmS1kyT1VrajJTcXVrYkhITmVFd2ltK3NJUzE0ekhM?=
 =?utf-8?B?dzVrUUN2cnNnOVdhRmYxc3FSbGdrZEQvQUFYM0VFaWEvbk5nQUt6QTdtWUFo?=
 =?utf-8?B?OTNaSGhpcWZmY0hkN0d4azNSZnJTNjAvUFQxYUR3c0IrQkhScEpYMk0yUll0?=
 =?utf-8?Q?+xtp0+F72WdyIFuM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA61F899673AEC48BAED79F3A8EDD1E0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kY5zNVvkbIu72dLVAOYjTuqSfysK0K2xIXqCMwjjUBFm+qcmzcKvl8+FAobov7KxQg+dgUNdUuArLZLI/3ZQOjNlkrfWOCy1MzbBFQCEzdT3np2suZ/PrpwzD8VZbV0615KTqJgZdsW94KfDXCGMaU/zc5/ILAJbewcPv/2T3czcebTGK6YPw/1c8Rom/OtJ17EcZU7qlPnrFgDgvTvdmA8JpmHBnogFJs6IIHYGXhHOP5K6nGApz05Z8j2rMW4XwC5MvXPGHTBSOvJzfkLGjV4mYiz9y8qnfrv+403BdQX6LuuLtgLbyK1n+COAi1zKpK2vDQ084qhQsT9THBrYlQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ae2fe9-00b6-499b-d8c2-08dedb9fe1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 20:48:06.8582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXUUcdCcIptaTK1N647YNOreLLpkh+P/hU6ZVZUPLgmvtx5raPCH1k/s2mQpo9sUPU8z8a7x5w9dZ148TLl+gz5bLaQBtTcWbRyK9GWiB/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8775
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA2LTMwIGF0IDE4OjIwIC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gTG9va2luZy4uLiBBY3R1YWxseSB0aGVyZSBhcmUgc29tZSBkeW5hbWljIHN1cHBvcnRlZCBv
bmVzLiBPaywgSSdsbCBhc2suDQoNClRoYW5rcyBmb3IgdGhpcyBzdWdnZXN0aW9uLiBMb29rcyBs
aWtlIHdlIGNhbiBkcm9wIHRoZSBjaGVjay4NCg==
