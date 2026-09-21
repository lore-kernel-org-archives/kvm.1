Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC55A502560;
	Mon, 21 Sep 2026 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025626; cv=fail; b=a86sn3xNgS24ctWpcZ4cIwG2gotx2Dzu5zG1UHIrV0WzpOzIV0Dtb0+39uwKFJJJUBO9C8iyN25cYAZLGqqMe2Cp+f6g1qn28798woGc0gTT6gzGNPtYgSa+at2e6+Cuz/1RrKztWF9G0+hNUErct7F9jbBnPCAjaRYFQZz+qa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025626; c=relaxed/simple;
	bh=yxbiG2mlb+lIgS9MrDnEV4b94sTk5GH7huWxcXIYjnY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZi5jfDdtHgstT+CS28RTdTCQj63p9WiAUsu2FPlUNZLUM0nrXaYvjfvsrLu4wvb9URiAVsVVT4goXlyj8Yf7f62afgC1RgAgLTGlnjdazA/0ayuO5zlJSvL6J2CkWhtnh8vW9R0p8q+dYcm+NWsJjs1Om0wulH0BNpEbRJuxgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aibHTyUO; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aibHTyUO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790025624; x=1821561624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yxbiG2mlb+lIgS9MrDnEV4b94sTk5GH7huWxcXIYjnY=;
  b=aibHTyUOn9HRv4YiFvz0cc+gX7PICiC9XaOHCw01yIA02mSb2Hf+vUMh
   gLoPTeAc0vw+BO0f/wOBILSlt+p7IRVHWyHeBlzgqlMWWb1xpCU05mvNv
   D1Z/gpWS31rtBtQYNi8NcKNIAWU6/nklMJi7d+1kW4cP9kUWKIhM9T/Ce
   QJqzYty55VCZ5hBJ9UeK4BCX7Us75OPsykOrWoMl3ihd9Qwl0RJSLis49
   f8nCKPpSLpjcq8WdhO6zJAqvi6Chd3UdidvnzlMc5EsgYfCWCZG1ON1Pl
   Bcnt6V8NAjg7DoBaFTvppLOEERMW9A5araHSeq4edD9NiyzRBDGgj26Gm
   A==;
X-CSE-ConnectionGUID: ewO4jLS+S6aEMQZc0RwwYA==
X-CSE-MsgGUID: RSZh9yzPTymXEtnDd4BtpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89503140"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="89503140"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 14:20:23 -0700
X-CSE-ConnectionGUID: ouOti43TQJOFeRjZfd6gWw==
X-CSE-MsgGUID: bP7hiHbbTXOTb8bSyVLmIA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 14:20:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 14:20:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 14:20:22 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 14:20:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1g/WTFAMKjIe/aOxiiBlz8e233Gi2//fi+FeoZLz/1ij8ABJGMkmV8bLpZ78Umjyy2shLl3WttpET/+KCsxNfOLySTXpOuPUnhzfLFdNLcfkN7X26fKbW+8Y6zUfSvRFm7neXkXmkrhxKLiHVnsvknqk6EZAYZ6GDClp4ENFdEyh5WYqvvAnpzIZYzzcgd4uU/JkLc/b+ct15FJGuZsGeDvTrLU1deiAU9D6cLZ9qZmlKzF/5jjN6cYzXW/i0ju9aTMpweaAildwOIznqVAvsr58lfkNhDURzqzLIZP2z8HIIsHuF27nT8pmXnmnZTZuoLZmh10ScCntMGGWwuAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxbiG2mlb+lIgS9MrDnEV4b94sTk5GH7huWxcXIYjnY=;
 b=oFndFfH9B/3krgdfQr1ohfhFIKIUVGW43XFVZi4XBrbemHw1yxnOZkAh8jKlmUfoEkuXW53nj4+WjIvc5eT/KPLn0bSEtc0mlI/882i7XIzQT+0Q4HgZqjODBSttpg75S/zo33WKx7KQLaisXepdC/XvBZXCN4vgaEM9vc0dOQdxJgbE1RtC+7T+PUUFGvwVyB5heqeZ1/D8LNpQit4Mt59tmpoxgnY0mVXUl4GSzZHekjah+wlHw7AXxbJmJRmc6POZ7byqG3EDaUXrcvZL1eYMh/n/nMIIK4qrV5SaakGcM9VQA33Nmwk9HGV0w4E4WeMg1Rma0DrlJxYxd2ASYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22)
 by DS4PPF11A2D5672.namprd11.prod.outlook.com (2603:10b6:f:fc02::b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 21:20:18 +0000
Received: from SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c]) by SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 21:20:18 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "kas@kernel.org" <kas@kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/tdx: Remove the early #VE handler
Thread-Topic: [PATCH] x86/tdx: Remove the early #VE handler
Thread-Index: AQHdQVJI5eTV/fAKY0yXdX2Qs0UGg7bIRmSAgADp84CAEGsDgA==
Date: Mon, 21 Sep 2026 21:20:18 +0000
Message-ID: <4238bd74efaeea1a6158b79f9475a5f8d1aa7e0a.camel@intel.com>
References: <20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com>
	 <b41da075607d1eaa9d96eddbf3acc24502edd604.camel@intel.com>
	 <aqPTIyi--7f2Fzxm@thinkstation>
In-Reply-To: <aqPTIyi--7f2Fzxm@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB5162:EE_|DS4PPF11A2D5672:EE_
x-ms-office365-filtering-correlation-id: 8d4d1d3e-dd48-4f89-8859-08df18262329
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|3023799007|10067099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: aOlb+yAj27IBTxudIG/gjN5zcMndyc0h8ZB4GKZobx64yClpS5IoQOGnVUnn9G2DfvUuCvDyHAAPkTjyz/HQuTAtGXi4Yb17UT2JFbws+O41KQqGeEiRH2rErxt97clL4C0TXulwZDiYLA7TeRKn2u8bT7kA2I6VcX7+/MGLCOyA2iGd3hiy34ij/uC4tYlQGH+aQhsQLeJy47zFLQTzIl8vQbgvV+NcTkfBHieEfHXCh0JMAFEXIiFLL7UXaJPiUAnRzHlre8DoJQHLSW2O8fQoVItzzK7RWE9MmxG3OJbCE20j5thlm19PjWFo1AWivX0T03Hzon9W/o5Wl8S3TkvnPLqw/t0Jft5DZCmfBbj2IYr6nf5l2+DqIwq8OPveCSldeCuWISnoUGf3djZGGQXGdUe3FPf6LFw1D/WFW09yt+hRQ2JskhxpG6zqiWwcYhMczEz9W9oqEYPcjADXtHSX78Y+MGBU9i3rHaznROolm4d+pbG1ysYSVALkSmJ8xhLQJXymoa1N0IoQ2RdIGfuQm01xp2L7OlFhWL3Xmt3H/W7soRQYVBAzvlIHCbCYYcvvo52H8dtFOTXFVp6gcxb5KHQ0qCeezWxe5RISMTYaGtvoMsd2IC/2m24je8pS6wNgfxs5XIPD0Ng6AfW9boqOYKmHV3NelNSLZ6ppdL6Yy4Zi7oxaPsCmpKfMx/d9DKxkuq8HT4c0hOOCH5bKD90wYo8clsqRMjoAtneM6Jg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5162.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(3023799007)(10067099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmdlaXB5M3RmUU5CaHM5ek5zYVMyUEsxM0dVUjZ6VWRiSy9xSDRuV3duQjBy?=
 =?utf-8?B?OEhxZkZIZEFubThSV2E2SjB3dGZOZ2Myd2V6RGFYOUhWck5Wb2U4SFJPNjRj?=
 =?utf-8?B?Ry92WU5USHgyYUhQeTdnUTNJa0xUeXFXeXdvVm5OOUNjMGdzZVhaSkVBOVNL?=
 =?utf-8?B?WDlFOUx5OTU4bCtEMDZWWlM1Y2JQVVhtcnVGUG9mOXBQRTRKWDdUcE9CV3E1?=
 =?utf-8?B?UTlWbjdQMkY5MnN5ZlRncm1FUFcydGFJemZWK1RrY0J3QWJEMTNBdEFqdVFK?=
 =?utf-8?B?RC9LWFRBTVc0a2pVaHFPb3hTNEp0QTVGSExZR2NwcFR0R1VxaDliS0cvd2w4?=
 =?utf-8?B?SS9BRnhTN3p0MC93bkxoTzVFSGpaVGdzeE42QXRQTDAvekZKczFIVEFZMWlm?=
 =?utf-8?B?NXE5OFpjOFRnSVVYRmdmcmtRT2xTbGRtQ28vUFdLL1lISXg1akdpUVNyeEx5?=
 =?utf-8?B?OHc3Rm9xeC85NjVHM3hFcm15V3JGKzRIYlZZNEZ3eUpDUDRBRFM3YTBzV2FT?=
 =?utf-8?B?OHFzUWF4blNscWV3SXoycXJGWkRRRnFPVkhzQk1qVm93L2NPV0hZc21STVdl?=
 =?utf-8?B?WmhwMTNPckJkeCtUOGJrMUpLZzQrWkJNdC9VZlRuVW0yVmpiakRoaEErUHky?=
 =?utf-8?B?dDBuNEt1ay9WMDFHdDRZOWNmUWxJODdMZVdKeS9wOXJqSWMvbm5nR1NRNVhw?=
 =?utf-8?B?aFlEdU1JSTZKK1V6MWhwQXJ4RHNsekVOSEJXRjBGaUV6bXpKZGpMc3FCenN5?=
 =?utf-8?B?STF4ZXh3WWgvUW5aUm51TUx1ejJoOUFNNTQzQ1VrVUExWkRUd0pCWEw5T0Jq?=
 =?utf-8?B?aHJSdGVLc1UvdXUxZkZQb0N3TDJVUWk3NmR4ekc3Qmc4dC9jN2s1WFd0WmxM?=
 =?utf-8?B?dEVuVTBmZS83NEdLd1FTSSsyYUljckJUazQyV2d3T1JPZXgwT0pLajkxR01p?=
 =?utf-8?B?Tnh5TUl0NjNvSFJpbW5XTHZENEQ5L1R5S0Y1MTMvVUZtdG9VQnVmY1NFZnVN?=
 =?utf-8?B?WVExVjRqTXVBK1l3U2RiOUpETXBvMlpnYjMwbnZEdVpwZjNHcmhXTjN4RGQw?=
 =?utf-8?B?ZkJreHhVRFJZeTlIVzljdHRtTkd2cjljRHQ2VjY5MS9FYlBCenBaYjRidFk3?=
 =?utf-8?B?ZXkzOGxsNGZzRWpUblJOMkJrQlZOQ3FRdzEzdFN1T2hxdDdmcnJ4M1RHa3RF?=
 =?utf-8?B?Ny9mWVhDc1VRRFpKeldIL3FJM3BmUkNERk1hcVFMb1duOHB6ZUE4SkorT09U?=
 =?utf-8?B?ajk5d2dOL053ZU1QVTFSdmdnYmZDQno3SWZyY3laV2dKZitadW1ZYUZtMHh3?=
 =?utf-8?B?WWMwNlRBaGFJU3dNWFIydHlqYXA1NjBmanQ2WEFJbmFvdEZHODNBNDYyeUlI?=
 =?utf-8?B?YUVWQXNIOEphMkx2Z0hlU0VkSDlTcEdNMTVIcDE2WDAxUHpTMGJHd0FMRUxp?=
 =?utf-8?B?SlIxektzZTNTbWUyMkFVT0V3RjcrQ1lPbThkMUQvUkl2c2xzcjJ2bloxUjlM?=
 =?utf-8?B?M2FUOTR0N2FrcDFBdnFiWlI2eCsrQXA1VUN4aWhXTGZSTnVjT3NWOEtINy93?=
 =?utf-8?B?Zmc4U3Exc25PWk1vZS9XU1pqbmRvcDMyQm1LNmhmSGR3TVc5TWRqZUtEbzZj?=
 =?utf-8?B?dEZFRkpTZ0RhU3hOcTRCZk9rMThnU3dRd3pDKzJ6YWVCZS9vYjJ3MGRHaC9m?=
 =?utf-8?B?anZvc1MyVzRMRWhuZlpjOWw5SVdIWldwMGNFSm0xRzlPbGFqRkhJRFlzMWdy?=
 =?utf-8?B?NHo4M3VWMDZkZVVjbzl6dmpLd0hZM2lTS2pYWVRhaWNRSGdydk9WUkRaWnk1?=
 =?utf-8?B?UXBOVTlTdmovRDBpZGtMSmF2NU90dHJYaTVJc3oydC9TZ3RlQ0Q2QWVrMTlZ?=
 =?utf-8?B?TkdwdjFrSmNoc2hqb24zYWt1cWcrdWZ6WGxQTGJ4dS9lRm93TE54Z1p1S24v?=
 =?utf-8?B?YnI4MFNnK1VaT0t6b0hoTnpGVVVHWmNpdm50S3ozeTNucC8rUXJZRndmR0tW?=
 =?utf-8?B?M1ozeHNRT0JMV0dXWGdVNURzR3BhZm15emJJdXIwNFdnN3BBU0c2VUJiUWo4?=
 =?utf-8?B?V3RlMHRjeG41dExqUmFDemV2V2txV0xXTnRhY0FFTm9sZDB2S0JHUGM2SnZB?=
 =?utf-8?B?TW1zbWs2Nk9JZ1VxazBQalBuT0FSTG1LSTIzWWJodjRWemZ3bHAwT3gvMERv?=
 =?utf-8?B?a01XbE4zZkdGNVgvci9GcG5mTldGdE45ZEV5UmNhQ0FXQW1CTzZBc2wyeHhG?=
 =?utf-8?B?Z3dhdllub3JGZC9FOHBQUWNhQkhTd2NOb0lTN1VZd2dnU3h3MTE1RWZBMVBo?=
 =?utf-8?B?dERDMGVnZk04VXpnTjdCT2lKMFF2cnUwa0Zmbk8yZktCS0JJY2lyREZvSmhF?=
 =?utf-8?Q?aXHLfkwYZWIJc1zk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0896225BDD20745BF8B60DAA2B43CC2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eovwyFlD9KFaUA5/diWgQjQ3DEqVDL37VtFwbHvixuj3x3IS1ea37X7q4X9lOSPO3ZjSBIEEZ9+l1yroBIuTHUIdZYF4svb8zMMR8kO6DHS7ImGpQM/9mkQLIKad4pbUqJtLIzT4KF2EdmtnsvpgeNb53jlO6NZ2zRrtBvyHm0VpNGxlDBrW0JUrZxC4vNFeljc05Lyx6X7+ExcX76xPEjMGfBNEx7V5avKbJ1K6eIpcOgFrPa9/u2xJrQD3gNrWuykgAJiOZFqhusM1DL4w9sOJaJuBMqp8LRRKqvNhdK9Ewoz0thvuIY1D0qlG7cEC3sWI3uKOjlFlgi88WZ27KA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5162.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4d1d3e-dd48-4f89-8859-08df18262329
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 21:20:18.7419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bB/QVgnr+48WLVo81LAMji+zS84ADM19uqvunEgSFaS7uVb7mdWAMN0W9rG/i5sYELAwQ4ZrtMjh/fWeyvhgR7vZ+PowypUJY8+L/W5Sk9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF11A2D5672
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTExIGF0IDExOjM3ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+IA0KPiBSaWNrLCBjb3VsZCB5b3UgYWN0dWFsbHkgdGVzdCBpdD8NCj4gDQo+IEFyZSB3ZSBz
dXJlIHRoZXJlJ3Mgbm8gb3RoZXIgcG9ydCBJL08gaW4gYmVmb3JlIGlkdF9zZXR1cF9lYXJseV90
cmFwcygpPw0KPiANCj4gSSBkb24ndCBzZWUgYW55dGhpbmcgZGlyZWN0LCBidXQgZXhjZXB0aW9u
IHBhdGggaXMgZGlmZmVyZW50IHN0b3J5Lg0KPiANCj4gbmF0aXZlX21hY2hpbmVfZW1lcmdlbmN5
X3Jlc3RhcnQoKSBkb2VzIHBvcnQgSS9PIGZvciBCT09UX0tCRCB3aGljaA0KPiBzZWVtcyB0byBi
ZSByZWFjaGFibGUgYW5kIGxlYWRzIHRvICNWRSB3aXRoIHRoZSBwYXRjaDoNCj4gDQo+IG1hY2hp
bmVfZW1lcmdlbmN5X3Jlc3RhcnQoKQ0KPiDCoCBfX21hY2hpbmVfZW1lcmdlbmN5X3Jlc3RhcnQo
MSkNCj4gwqDCoMKgIG1hY2hpbmVfb3BzLmVtZXJnZW5jeV9yZXN0YXJ0KCkNCj4gwqDCoMKgwqDC
oCBuYXRpdmVfbWFjaGluZV9lbWVyZ2VuY3lfcmVzdGFydCgpDQo+IMKgwqDCoMKgwqDCoMKgIHJl
Ym9vdF90eXBlID09IEJPT1RfQUNQSSAoZGVmYXVsdCkNCj4gCWFjcGlfcmVib290KCkNCj4gCXJl
Ym9vdF90eXBlID0gQk9PVF9LQkQNCj4gwqDCoAnCoCBrYl93YWl0KCkNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpbmIoMHg2NCkgLS0+ICNWRQ0KPiANCj4gQ291bGQgeW91IGNoZWNrIGlmIHRo
ZSBwYXRjaCBjaGFuZ2VzIHBhbmljKCkgYmVoYXZpb3VyIGluIHRoZSB3aW5kb3cNCj4gYmVmb3Jl
IGlkdF9zZXR1cF9lYXJseV90cmFwcygpPw0KDQpIaSBLaXJ5bCAtIG5vdCBzdXJlIGhvdyBJIHdv
dWxkIHRlc3QgdGhpcyAtIGJ1dCBsb29raW5nIGF0IGl0IGEgYml0DQptb3JlIC0gDQoNCnZwYW5p
YygpIG9ubHkgZ29lcyB0byB0aGUgbWFjaGluZV9lbWVyZ2VuY3lfcmVzdGFydCgpIHBhdGggaWYN
CkNPTkZJR19QQU5JQ19USU1FT1VUIGlzIHNvbWV0aGluZyBvdGhlciB0aGFuIDAuIERpc3Ryb3Mg
YW5kIEtjb25maWcNCmJvdGggZGVmYXVsdCBpdCB0byAwLiBUaGlzIGNvdWxkIGJlIG92ZXJyaWRk
ZW4gYnkgcGFuaWM9TiBvbiB0aGUNCmNvbW1hbmQgbGluZSwgYnV0IHRoYXQgaXMgcGFyc2VkIGFm
dGVyIGlkdF9zZXR1cF9lYXJseV90cmFwcygpLCBzbyB0aGF0DQp3b3VsZCBiZWhhdmUgbm9ybWFs
bHkuDQoNClNvIGF0IGxlYXN0IHRoaXMgcGF0aCBzaG91bGQsIGluIHByYWN0aWNlLCBuZXZlciBj
YXVzZSBhIHByb2JsZW0uDQoNCg0K
