Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792721636;
	b=nBjEkWW+34pcJxgvhbtl/c01qcGV9lE7qWZ43XzcPg0HEaHIMVhg6uDXwK/tbvJ/U+tV
	 uMIwaNrVgDSgmNLqOCVG8qRXx9pHqve3vcQwAOAcQJV6U4BhNoZazFnjAtasBZ7PmOrGd
	 8IpL85LUYykz/4ztRPgJ4j/spT0E63P89t5+28AqekElNZt7M4PC2lbeWIRgsnmbVa+Yk
	 6DZvMh8UGj2ZjzK1gfonjAzCgAHRBTYxWGkW0iOuFzS5j3ab+/Me9fBHGkkM6dxxWoptU
	 YJ/u5yn1wnsjHvhC325T9T+eFBvQtBlJXM0iF02Xg35/gfiyAyk9k7OmQSyRSAH0p0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792721636;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 Reply-To:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=UiNHLhpKD6tek9xXtE7bioP+FOqAq9vHzh9HjF47TXc=;
	b=0HdvSslMeEomWfzHaTTdQ1Y7tFGYOC7JzeHoEjiqsZoMJKPMwq36AHkrc6279/hEp4cJ
	 SEXjtYD4yX66K6ZE7WgQzy80z6085+HnmI9/jT1bPyF7rJRybUU28UEw2QsFHeN+VdN/y
	 CmykR60oKFlWSJ5JyNcycejzPexpd1D7M9Ny5kKVD8Dllka+NJzX2sxWfq0AxFIuVcC9O
	 2Z2U5jjx+N52GgNa+m9aEbt4eUSPhj7LnbXcVl0UqOSftVpWebsWnAvg7RQQ93Y3WJPeb
	 3imyQCXUyO4x/FZZWIdaQvI8glOL+0U0P/TmOzF/5OEE4xRW+D7f2zaZnFx1W11WHsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TU9TFWuZ;
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A1606A319;
	Fri, 23 Oct 2026 02:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC0A1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TU9TFWuZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792721635; x=1824257635;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AnRNNCWffQM0OStZ/CEzO0WZ12tajhhpyvQxbXcQOjc=;
  b=TU9TFWuZUkX/egv2dmo61GgiHyGvpUJ1yQCvvF+byqHY1yvBkaG1svdY
   O1KmrOclpJOK9khADgHWYRR3aSPP6pYw9boJDejEejrMW6kO+a1kCSIsJ
   MgKYmWazflD3QY/NrNZ4rgrCgD7xZTCycrx1a+WTXPUH1c4iqt34YKe14
   tzx0Wij0U30j1S4B6y/B2yBqVqLPboz++vsr+KPCP7LWMmm2alIQ0RykV
   LQVFZbqilTAFdi451D5NUbwbuSbeAznMTfZ4yFXLTYEy3QuCWFBIjq+xW
   h7NzD5FBOEzFN9sd/+THZCeZWa+eqLjLUKavtacr4H10MW1yZ/jSIoH4J
   Q==;
X-CSE-ConnectionGUID: o6dMXajFRcSR6+QSJ9ZbsA==
X-CSE-MsgGUID: 4CgxdIQ2SoG6jcmrxpc5wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1361541"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1361541"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 19:13:54 -0700
X-CSE-ConnectionGUID: gFjHU7E1SlKP7B5J972DIA==
X-CSE-MsgGUID: CU4VrPPHQ1SsHr4X0C9x5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3835936"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 19:13:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:13:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 19:13:53 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:13:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGWHdFljoK+YMJLjJlYyv33jHPBQzWzd6namRe3ylceePpDkEbREJBIaMlwl5WOHEEkBcGQN9zQHyoD2/3Lt50uUhVWX5ql6xBaDY7LwdscYt0atjJW3MogIergPdUWQJPeghMiyo0RlXlQ93R/FmmeNAWG1OnXrmc0sTBOi8dMqXGtAt3pm/OuZhu2V0GV2upd3XKS2/Vvnq4MbIaM2ipho0yxtzBgdjsNrRERg/RaLiYcZXXqHdIf+Zb3LgRGNnKHPXFBOa1hGyop4WWJneMVF7kueJgvQe4+W0OzrjnrsbjtmFg36eXbRwvTJRtfN6oTUlOdVo9aPISO6N95S5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc0wi4xHlE2ndJ0eVaGI9I9UcQvJWFPweNH0XHF+By0=;
 b=w4TBQiptqsaeP/gXI4y/7j2xU/u5PCChYUCZZpRUlCFiuMD7Hze8NEblzLkQYOWOE/8/fbqlmiE+IHzLDD3NPT9g4oK+/5YG6bMGnDtWA5ENG3Bk9/PhCyGHMdP9fA8DgsIMlpbmZs5ojGj9NROWPjXqT+p/GOG0gSXNy+qKhACVzWYU7uFCYIE2USbyIOoRYY/ua5eKuRoj/usf5hMv43YXr5Cinby19OvYTwEt2QM5If4VVh3jUYb8suxutg8Ciw1t/6MIIoVoK6usrXknaougGDQltuDbc+P9qUUaZWjNvICfm7WKPrquX+B1hnDdBU3P+xPvGA5zsM2LdB538Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by PH3PPF632600ADB.namprd11.prod.outlook.com (2603:10b6:518:1::d27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.17; Fri, 23 Oct
 2026 02:13:45 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 02:13:45 +0000
Date: Fri, 23 Oct 2026 10:12:45 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "tabba@google.com" <tabba@google.com>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Message-ID: <atrCnSpy8UTTVw6Y@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
 <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
 <atV5fDnckj+3V0D/@yzhao56-desk.sh.intel.com>
 <ca53c3bd37218828822a9b990a0900ca2541fd9e.camel@intel.com>
 <atm6NBNrwYc+Y8yo@yzhao56-desk.sh.intel.com>
 <55ccf641218c6553b2f43f4394b92c23bd8b5d98.camel@intel.com>
 <atqjeaPTXmCfiQmo@yzhao56-desk.sh.intel.com>
 <29790651d7a5d8727f956985823c17e3dfbdcc24.camel@intel.com>
 <atrAZhEINeaieBxN@yzhao56-desk.sh.intel.com>
 <97ad9dac09d945ab5b76ec8596a76f8fdf2bb6b6.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97ad9dac09d945ab5b76ec8596a76f8fdf2bb6b6.camel@intel.com>
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|PH3PPF632600ADB:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb68aaa-b239-4cb7-2b33-08df30ab4443
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|18002099003|22082099003|261022105027099003|3023799007|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1oQ1LWQEp7WDZBkFOKjixmBp5DTLfuQdEAzmp0IizFI7LVd8uAUbCj1onWcVsPBkL/+r5Uj0fn1D1xeokBYVWQg+8clWwVZaBznSlVXeBXxJvghbqF0wPa55BEVZ72I7+CLf+hfXXKkFCDfi/BFnfKIAfBR0W9ful9idfoWOXMHpxFlL4g8Ug7l9zwsn6L+9BJzDFTPPzyYZ3xpdGtGFduwCLjiOkdyXnpxSRO+/tItJkUiq1jeiveYuRnHncvljduIWY9nVI3nnzvVqgnEK4mTHG7jKVEDN8OaAcq7TnmNeHTMUObXGbToW6WSMAhUj3oVD9oYs06LXE4207Kjb3sxk767L3xVXwUdh7knKzDlNtTMlQhbYIB5AvxZdB5iNjWEWXi9GcWgfyeRCpQf6veFCDkxzE4xkQmJzD7KGKpMR6R0f/7YEiqtLnVqsbEg4oVtuH/ill9m+zY6ydCTfKP+tPmYqa3EQORmDBfgwQmMVatrrztZaiN089zEvR8lg40D5SuhZ2500KDIops2O+VkT1SHTx8JVG6oWhro9lACuSMhVqZWioB7APRhegXvQ4NZGUBg6dKP+J6Pj5/agHz35jIq9ZiW8UFhhwzFqOk/e8c3GpoRL86cnMTgQDcVKlpuYOPjnzIXTxGFDWt0E8ehwJ7y+nRUrjiDqUoYyhEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(18002099003)(22082099003)(261022105027099003)(3023799007)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ntfmio2XyjgIgzzxKrNoWOLWAausonJTclzq81JREPpMwINNV3hxjWmpka?=
 =?iso-8859-1?Q?WvbhP2GKalGYY1Y4qMdNOE+7zmA3P83AkssAozmCL0alXIE+QdjTiRs1+w?=
 =?iso-8859-1?Q?pDAIvBQJDTBblK/rZ9Sb67IhOyWPXn13DnWNTAdyusokjBx6tCzoiWaZ6j?=
 =?iso-8859-1?Q?NIjyg9OCeY1QKqu/vGNPYiI2uE4kzd8pUew0e5II7nEP5E/n4OMT02WMww?=
 =?iso-8859-1?Q?X+H2VgprBmMyM5iWhV2SvIVVivVg9xK/qy2tPtQR/tsAhZ0i6RSpq+rh5Z?=
 =?iso-8859-1?Q?hvaD9H7pIfDE3V/sRngwmvQTW+MztrULGa9PrZiXA3yj+LXX0PGQ+mdF9a?=
 =?iso-8859-1?Q?ySuPBIdWfRthUVsxou7CSXX+MGtGMCJ2Jy43og28d4gisF5dWTyTHH9T1F?=
 =?iso-8859-1?Q?iJZWhvO2l4i1c3anL+6Xu02N9Shg4NiIUMdiiHOXNCT4BYu+ox/0S6QFfs?=
 =?iso-8859-1?Q?q0Xb119qSVQeJBBKR/xVihhaGF4/VUnPnPpYBFVnU4uuNtd8bNHBvcZsUT?=
 =?iso-8859-1?Q?+MtDfSrX+N8sl76jOjzRbX1cyBRBiA9pUrODd7FRkchWY4Mb80AfYDlpe2?=
 =?iso-8859-1?Q?aWRkeqc+wiGKJuisAZG4LhaGskWEQEuVGLChZTBVEe1i/grHXXQkxelTOk?=
 =?iso-8859-1?Q?gW0dAZhAbOBNR9U1uvXmtfQ2/mWS9PBkH/rtVrVva4g5pH7s7FaZSxvZ6l?=
 =?iso-8859-1?Q?cM/EsC3V6RlSO87Kipm48bc/wrkx2IUNGsX8Q6S8EbT9NCYpbMTMq9htEq?=
 =?iso-8859-1?Q?OW/cz1B5heNKzRTtel6omj3aL7hLQ96FErYsYttBlV23v9xHHzVCnIsEiT?=
 =?iso-8859-1?Q?TKGMoC2Nv3GUuiiHf3pnFPWprMJis6GUvW/CRFFRuwAoUq+wA3IZvQwLgq?=
 =?iso-8859-1?Q?Q2Ycu79SPN8sNcFbzVuESCEZCIcnMhLZ08rAQPUnE3mLBbYBXAYBo457Zg?=
 =?iso-8859-1?Q?fD4gDmsSuf1px//Y511wnx5UYIpdamJ/K+WZHi3ulzPL04a4bvsmKKmd12?=
 =?iso-8859-1?Q?G6Tg1zsaoawyxIGj8eBP2ASs1ah6M791CyiEJv2FX17pOVt8iNE87vmuRB?=
 =?iso-8859-1?Q?GSSkHSebqSEDLMTf27gSlaGFzSap1AYSFgJzx0kz42UDOsCzX+qgYJ4v2y?=
 =?iso-8859-1?Q?ox8Gp9nPx0CBjdkEZthCE+N5akZkFv/WqWCfOZJhg6ZB/hMK1miB0Jhhno?=
 =?iso-8859-1?Q?nPOT7IKzVUf9bkq+SPMGuwLIdmiXPi+io8H7SvVRNa4J7OwXaT+WwXNSEl?=
 =?iso-8859-1?Q?oA/bciPYhUeuTR/VoGrpjeD4ezx648xFm0N86KCHhawWd/L5OeDFUeZIv+?=
 =?iso-8859-1?Q?JuhWrjULV7xyfI4BOQA8zMM9hLRSe1jai/laeAjvcPKGuU5VTSUXCxUVfH?=
 =?iso-8859-1?Q?uYiRuysYsPslRCJBkMJrFuhJDsWuS54p9l8uKEUYchJ68hbE1c37dsvpUJ?=
 =?iso-8859-1?Q?NXKVQnpS39FF/ikce3/kaiCGFbEFTFbSV2eRzn5WNcR8hpMR2pBubrKS3u?=
 =?iso-8859-1?Q?ONg3nT0A+EgaK3SkffvZRtxgtEDybFGqhScczi5MN8nBvi8t8+jTpDmeUC?=
 =?iso-8859-1?Q?iCkmu/UMMKSAtew9Bt9m7RtFWLwVQa2IDN2EFFzIOki291ufg+hxf6w8u5?=
 =?iso-8859-1?Q?408WHmAbIRfMAXNXpXnDptvTVYJJ1PP2BeEN1JSDn2OmRW4b6JiNs6fRX8?=
 =?iso-8859-1?Q?MwmI0NH6zt03CEzX1J5HBuruoM3wQ6/AwSE/0KQqMicrHcCpfTuSuIlvNX?=
 =?iso-8859-1?Q?M1MbeBwh0zB0er6M5aN7FWNxTFHcZKcyngYMA65I0mwoFhIOox8L3mc5Hb?=
 =?iso-8859-1?Q?deIMdBjkMg=3D=3D?=
X-Exchange-RoutingPolicyChecked: U7hTRxto0as3yGVxq99HEhLxXgHeBJzTPaUiaSSA/Iuc5h9tocs4cFG+1YRdZKSc2Hk2Qi3NQexMCr737Q8rVrkG+H3HfXto7FKEXt31p/ml16uXG5AdIwZOOQwPRllIgqZzTWhes8aW8qc+SZnR7OqUox2bX9qpHnHM6K1UloG0yjh6EsgxMP2TuY3A+3jtYTUyeJcT3MIDdGWP+v2FzWYAbQv7ghVYpMB4K/oJmtcpMfX56mtN3kcyIaqYwXNJdNa2fFOvysjuWO8+uEjIwGOVJbUPbpi+K9TVkwHtpHNk1i375+dLXUDvEollDUzff8gr3suuZDEQ0WwTeuErNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb68aaa-b239-4cb7-2b33-08df30ab4443
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 02:13:45.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ExyRI6NOvBHeU/4x8MkRcaL9bAbfu5QNshottAmxMR+8PNBT80SrfjI1NIY84o8KKx6qT+fLcljU7cMc30wvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF632600ADB
X-OriginatorOrg: intel.com

On Fri, Oct 23, 2026 at 10:06:01AM +0800, Edgecombe, Rick P wrote:
> On Fri, 2026-10-23 at 10:03 +0800, Yan Zhao wrote:
> > > Can we mention why we only need one for 512 pages, what about?
> > 
> > But "2MB guest page" should already imply that the physical range is 2MB
> > aligned. Instead of expanding the details in the comment, would it be better
> > to put the explanation in the patch changelog?
> 
> I think the detail that is missing is that DPAMT only needs one page pair per
> 2MB aligned region. That info is encapsulated in arch/x86 side. So I think this
> code needs a comment to cover that part.
Makes sense.

> That the 2MB page is 2MB aligned is not necessary. Can you propose something
> else?
What about

  /*
   * Only one DPAMT page pair is needed per 2MB aligned region.
   * +1 pair to account for mapping a new 4KB guest page or splitting a
   * 2MB guest page into 512 4KB pages.
   */

?

> > 
> > > /*
> > >   * +1 pair to account for mapping a new 4KB guest page or splitting a
> > >   * 2MB guest page. Since the resulting split 2MB page will be 2MB
> > >   * aligned it will only end up needing one DPAMT page pair to cover all
> > >   * 512 4KB pages.
> > >   */
> 
> 
