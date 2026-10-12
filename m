Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9233B8BD4;
	Mon, 12 Oct 2026 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843413; cv=fail; b=t03DBvWPnOo4KkxjblGXPAzmvCDboZANoiOMTf5SjRrP8/lM7Rv39PvT30syHf7EEtWf0kAsjx7JwFcs/cNHpw2uWDIbd8vyfAzy5hPPTfhUdNqSTziYjAUw05tGFdHW/G3BFW8oMWqBsmBtZdotRVaCvRINQPvFXqX7YVzLO/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843413; c=relaxed/simple;
	bh=9y/I2cTQb69a/rEIYxuh7OKtzd/6Smglb8xUSS+F7dQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iyvoY3rFhnP15yLW67WW/oUUZiIAiJ5T9Sf1zMzClzOAf2gwlBMLM7Fk+ZNbwRlNQDOooPWvToY7sLILsCugc+tWxILPDiiSakn+2/jxYfQsRYirK7YB4j6yOkY8CyEQOFBo8oGD9XiiTIyyTGWmbifsukpsiVSLlFt5ALPT0xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EG4Ij8At; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EG4Ij8At"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791843412; x=1823379412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9y/I2cTQb69a/rEIYxuh7OKtzd/6Smglb8xUSS+F7dQ=;
  b=EG4Ij8AtwLwkv+XP/iF855ETSTyoA0HQWWqvCx+X3tTKsJqmLXS8Ybb6
   6Ojnzy3dWIEn3bi3mqJRNlknN50A3zN86NMvi9Xcse3082FW4L7JlhuyS
   lJjyddgHbhZ78lAPQtC1cwyAzPU4PRXbLAb8jcetAHhdrE4EmNqO02UEx
   NRs5o4U1mMsg+pKQfre+RfwjedTLF2lPASO0s7iEW+rOzfT41ULtmMN9+
   nevGN+/wN2x36V2vhsmIcKeX9jGRE3GSRVWvR51VT+EQ70chu5OJUvonM
   4Fn+UcnGcPx5w3GonthwmZ7YF+EXJAZjYQHBMb0P/TNny0r8JK7B3aEta
   g==;
X-CSE-ConnectionGUID: ttfnaT3KRNSR0qy9AG3NdQ==
X-CSE-MsgGUID: 8hFz49EOSoqV6hSP8a1KSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="462674"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="462674"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 15:16:51 -0700
X-CSE-ConnectionGUID: 3sWewariSe2KxBML2Hhg7g==
X-CSE-MsgGUID: ar8NMYS6QZGbaXwV6/J5fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1324633"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 15:16:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 15:16:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 15:16:50 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.60)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 15:16:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iv/maMHIkoFDh1buMwhBvTL2Mnr2hSnnFEDE0Xip4L07pF3VjJFZPpqKu23u7oFBAPZWjleAq1GV/6ku+ryvVl/Y/T6AmNbmSt9gECipQojfYg/52T6Q7pe36oVVpHGwUC6RB+WA6duywihRVuj7exaqscSS94ObYiEIXCserDKKzSOUUz0wtt7eGZmQGmp4cZlXOhrrkNtusDzEnSfTrEq/ooRIdUli2ki0VHHXC2e8cSdYINwOQAoO4T8We79CrHfBdQ5xCBym40ItgPI+y2kauGr5vLFQj6yDq+jfo4ZAfFubbf3m7DP67x7YdpXA7j32NbMC4h4+Z7aIbwBDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y/I2cTQb69a/rEIYxuh7OKtzd/6Smglb8xUSS+F7dQ=;
 b=THcZhAeiIkOxopR9yHv2qoi3MpNdepxeO7UmIJonVqeLaDVLr2KRqHN+XX9G27rmHAIMDoCUuSm+FFlgB8+AV/MmbLL6q6SlwMQuxDQPCancaopKskwVuH/2wFpnjQ8zjI1o3uzBFXd77PGbMYCJGeszKhkaHoxXbaHcUd2Qa/bDzie/lom+5CkR7E1wNH7Uqa+osQ53k7TBao+gqGKNReu0tTVXN7ww6z9Y0r0uJd2IFZRWKa2HI0j55NvmmkXq87XAbBfqGGAPt7nW0jYsjeBPyBXBsSeDpukN2SkNV2b9cn/zOGxq2AIQpzJocxirbpjYxapI7nGIblFjutc95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS7PR11MB6224.namprd11.prod.outlook.com (2603:10b6:8:97::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.20; Mon, 12 Oct 2026 22:16:46 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 22:16:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 02/17] x86/virt/tdx: Add a SEAMCALL wrapper to demote a
 2MB huge page
Thread-Topic: [PATCH v4 02/17] x86/virt/tdx: Add a SEAMCALL wrapper to demote
 a 2MB huge page
Thread-Index: AQHdTykMi6GQTjL+gUG+CUOLydf/JLbpcr8AgBBH4gCAANXIgA==
Date: Mon, 12 Oct 2026 22:16:46 +0000
Message-ID: <94e930e88046fca1f53d2234d581aae593367d95.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928090831.15502-1-yan.y.zhao@intel.com>
	 <9016c06a883bde489957ffdf7933cbbf6b8e6b03.camel@intel.com>
	 <asyo+Pr7aCje1AZ6@yzhao56-desk.sh.intel.com>
In-Reply-To: <asyo+Pr7aCje1AZ6@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS7PR11MB6224:EE_
x-ms-office365-filtering-correlation-id: 31d2f644-0ae0-4c5f-8c8c-08df28ae80f9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|38070700021|56012099006|5023799004|4143699003|261009223027099003|11063799006|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: 7hGmvWAcrbHm8Hlk6cFc3pJZD5DnKkwBkfAAVm20kzqA4GVp0WzcAXZwuHZ/qY7c2KLe6B5RgaSPQgCx1u+vMVqk1vCCDeCzzdrB35NZx3v4T7wOv5uW+Bq3rdlCUgJ4R84G4AQPHYbkO9SJIYRG0By9tX7uoZ9GT5mKmYlrDN/j1WbPxMoJpnqYvYS85f+Ne3z1JDZjRkmmoGfuJ8z8xUC7lI6E1pK9WDI2za987OuyHCGMNCnd0KJLGPd1z/7F3dJM0mCi3cZvtQD3sFoW5jWCmYbcvavX+U8hnyzTgeDf28157nfz1aGDJpebQqygl2Q4FIm8yLfLfCALaHZt4i5ZLXgFal1U87+QkTEjBE+HR/WoOnery+2t1rZQAEC9+94v4dEMHnf3BD/93kpVCW7oxti35oN7cQVb4e1gdb9c6Uch2VNtDhj2d4VLOLjOn4rV+ifJcAvuVEHdc7FXrhRsxT6Nyr1CDcmpRjGv9uH7FSmBm+qLEF2Jrifph0m9LtTneB2F58yTB+fBNVPtUefuX7MuZsm2D43xT+CFjXntuLGzolsdOvj+EfcarryLuXQbc6Dbt42uPI3rMM11/PcGjYuGo3/ZizEJye/kTGTta/nkEMkMrWYSl8eyZfKk2X+89aMVASKzx2ZSum9/Cj/cNZq6w16MsDMOmLiGYLk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(38070700021)(56012099006)(5023799004)(4143699003)(261009223027099003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3llTkprSzFzTngwSUFNU0QyYnVWRDhTZ2dqbkhRWFJjaklaZG51Q01oTUEz?=
 =?utf-8?B?MzMwRWs5L1RRUnBMTUhTT3BFLysySFc5OCtPN29MajZrUVVLd1JsSHBIbCtZ?=
 =?utf-8?B?L3kxOWFTdXg0dFp4L3BDNnIvbDBzbGdzQkdRaWRudzFESTA4Y2JxZ09RSytD?=
 =?utf-8?B?TGE0dUgxdFZFaERPVUIvNWRza3hCODFldFliajNtQ1V3Q0JyeXNVUUd3ZkhL?=
 =?utf-8?B?TGE1YTRoODl3Q3ZkdG1vU2VxSlNBV0RyZGFPQStpSjMyN0V5dDVZOWl5dTRZ?=
 =?utf-8?B?UGxQQ1lGQWFrYmlOSHZGQWpoWG16N1dZWHZKNEcwRHBmMmp6ZnhaSDdSRWJU?=
 =?utf-8?B?VVhtNGwrcUtwZkx5cDJaNW9ET3JxRXMxbXVsS2lHa1VPNE1Ud203UUlaL3Zq?=
 =?utf-8?B?cWJMSzZ5RUErRTVFQm5wT1A3emJnZ1dpYmxRQkpXSVVocDZoSzBhc2ZzQ3VS?=
 =?utf-8?B?VjdoUHNFTEI5c2REZmJZWjFaVzdaY0lBeVJBRC81S1lFZndIOG9wMTc1R0Fk?=
 =?utf-8?B?TTR5NlhCVGwzUWhrb25KWUxYc0g0N2pLbjIxQTJkSENEbFJuSmJycktrNEpV?=
 =?utf-8?B?enVrUzAxRnZVckhNck5JRzhiRTdOcG9jTDlmQjgwUTl0Wnp2UEdBbmc5c0tq?=
 =?utf-8?B?NTFUaHJSSmNnWkJXVGFKekJjaFgzVFFJbDNncTdYY01pUDJHemxVNEw4N3Fi?=
 =?utf-8?B?RXRxZlVhdHNubFVoVlVRWkMrLy9KMW4xRGd4b2hpY20raHRNL3UyWStPS3Jp?=
 =?utf-8?B?bUVlancvY2hjMHVncnIvcFNEM2Yvd0l6NGNJRzVycTNhZDBKK0tzQkxKaFNo?=
 =?utf-8?B?L2hJL0dWTWVSZ1Zja3lGTWhsVWx2WmhTL2prREJ6bXpkaFRFZjN6TVFEK0s3?=
 =?utf-8?B?bGpBUGFvVjByOU9EejZnMGRBWXlSSFd3bkplS2g2d0J0NU5BaldlVmorR2lj?=
 =?utf-8?B?OWFEVlJ3MUNaNE9RYW9EK2lqam93Z0tOZ051RHNJMGt4RWNYWXpVb1ltOTRF?=
 =?utf-8?B?QndaaWx5WnFKeGdRbEhoWE13ZnhhZ2t3OE0zTzlXcHAwWnRNWlc2Z2xtdGtz?=
 =?utf-8?B?V0liSFN3RGxOUzFhdVdVOUtBUTNWS01COVNIN1plN0RaREtteXZmWVVKMWVr?=
 =?utf-8?B?V0xKMHFGVlFrZ2toTTlOSDU2eEJWMDd3WlZ0VmJPcEJ0SDZsSU85My9WVmph?=
 =?utf-8?B?S0U5QkJiNVh1UEhVUGdMUHoxM25NWUF3OHhrelM1RHUvMUtsOGhIZXNqSGd0?=
 =?utf-8?B?MjFKVWZINlNTdWp2S25HRnFHOVZabXhQcDdPQkxpdEp2TERKUU5QYU5acEdr?=
 =?utf-8?B?c1BUSWlubHUwcGRqNGZ2bGp4UllmN21tREtlSnBxaU9LNno3YmIrLzJic3lj?=
 =?utf-8?B?N2RTcGoxMmVzTEIxM2VsdjB0amhDZWYwTngxSm4zcUkxYkMwVGtCaXdJUXE5?=
 =?utf-8?B?SUNoaVMyUTduWnQ5cGNPKzlCYVZOVXM5Qzd3SFd1NkZWRUtlNHlmdzMvNGN1?=
 =?utf-8?B?OWttblZQUHpXUVBUYmtQVUpzVlhJTzV5SEpHRk12eW9FU3dSdjdrMTU4QmxL?=
 =?utf-8?B?WTNQNm4zaXRZK1VzUkxIZmlyTnBUSW14UEtmS3pvUE9Tb1RncDFtc092Mlg1?=
 =?utf-8?B?SHJYSTdvNWdONmNFclJObTBnQVFxeU9nbWIvSnFPWXhLanZwc0R1QXNsTUdy?=
 =?utf-8?B?WjFwT2VEN09PLzc0MnY0L0NJUnNLUTJqNXRaRVJQWjdMV3lOMERTTDhJK0Ir?=
 =?utf-8?B?NDdvR3N1RjJyT1BXUEVWZ01veS9QVkhBZnVVbmFqMmJ4em9SM3dEWFNGUlF1?=
 =?utf-8?B?RllPb0xIMDRwMWZId3krVmNJS2p4Z2xiRHAvWVVNQnBqM05vQ1J1YzhrVTRU?=
 =?utf-8?B?TW14c1g4OU9QclBwV2FtVUs1Zk5COGRSV09Hc3JGQ2JMdVdCUnFpOVZmTCs0?=
 =?utf-8?B?dmdxcDk5bThFcGhJclhQbkNMcERGNFZOYVBEM3VxNWhROUtBSDZJN0NnbFlx?=
 =?utf-8?B?RjFIWWcrQXNUYWlaTWV3WmxmREhqa0RXM3ZNNXAxcEkwU2w2MHlIZ1V4N1NK?=
 =?utf-8?B?WEYwemFjY3NGUGFSRjF1WkhudG5OdzFYcHl3aHFXSWsrOFhFalhQVWRsNm9r?=
 =?utf-8?B?V09weDVrelJZTmU4b3VFVk9iaTd2dmFrZHh3NHNHdkhIdmdWMGJUWXBtMEQ4?=
 =?utf-8?B?NEZobEducEFIaVc4Z3V4Z21lVlREeUZkcXFWdU0xRS91VUFFMXpiazEvSDJB?=
 =?utf-8?B?VmFJZTRCb2xyeTZVNStSU1RyZWRhTlZJK1NNd1hIbEt5a2gyVWthOGY4NVY0?=
 =?utf-8?B?WlBMQlhURjlJRnY2Rkw0b0Fid09QN0pSS3BNdnlRNHhEZ1BVK0ZVSDVMZTFp?=
 =?utf-8?Q?EMq8yItGfHAngkM4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB94628BA23A8A45B0CE9E3815BC18D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wWpU3430txcU5WQSxOB7AxJJoS82WcfVDY/4Tlua0q68bQ/TwNWdmQxzRGnJJYS1WN4RZMUDCyIDgVa9UlOV0vkpjxqmH6ZDnp2Nf9RdwoXA2zwCjUCEIsor1dpRk/iOQPS2adATNQseYoyemRxH+niN9D8YvsHCPRBQFveam45AloDetsnRQA7xcw54ug23fwLK//jKTzITtiYV6kWnfQcKSz/fZUFSfqpjx6OU8e+gqMMQOXkQZRDHM+7cXJmJCnbPOunoeiKb9WBdYXi6qMDKfKICLRhvixjkVGTtRt0565eQB831H++93N7cstzhEYcz6CLt58NEfwu2uKVouQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d2f644-0ae0-4c5f-8c8c-08df28ae80f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 22:16:46.2327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwD/G2sA7K8GjDfrHXOQInGnVY5xohIfYhfTY/2JyRnKFslhBkhxXrjPT03mRSMlbnicrKrTQ5IC7OyeUTldJ1EDU8cNjEBXnWFHIFd29Ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6224
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTEwLTEyIGF0IDE3OjMxICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiB3
ZSBkb24ndCBuZWVkIHRvIHN1cHBvcnQgYW55dGhpbmcgb3RoZXIgdGhhbiAyTUIsIHJpZ2h0Pw0K
PiBZZWFoLCB3aXRoIHRkaF9tZW1fcGFnZV9kZW1vdGVfMm1iKCksIEknbGwgaGFyZGNvZGUgdGhl
IGxldmVsIHRvIDJNQiBoZXJlLg0KDQpKdXN0IHRvIGJlIHN1cmUuLi4gV2UgZG9uJ3QgbmVlZCB0
aGUgbGV2ZWwgYXJnIGFueW1vcmUsIHNvIGRvbid0IG5lZWQgdG8gd2Fybg0KYWJvdXQgaXQuDQoN
Cj4gDQo+ID4gPiArCQkucmR4ID0gdGR4X3Rkcl9wYSh0ZCksDQo+ID4gPiArCQkucjggPSBwYWdl
X3RvX3BoeXMobmV3X3NlcHRfcHQpLA0KPiA+ID4gKwkJLnIxMiA9IHBhZ2VfdG9fcGh5cyhkcGFt
dF9wYWdlc1swXSksDQo+ID4gPiArCQkucjEzID0gcGFnZV90b19waHlzKGRwYW10X3BhZ2VzWzFd
KSwNCj4gPiA+ICsJfTsNCj4gPiA+ICsJdTY0IHJldDsNCj4gPiA+ICsNCj4gPiA+ICsJcmV0ID0g
c2VhbWNhbGxfc2F2ZWRfcmV0KFRESF9NRU1fUEFHRV9ERU1PVEUsICZhcmdzKTsNCj4gPiA+ICsN
Cj4gPiA+ICsJKmV4dF9lcnIxID0gYXJncy5yY3g7DQo+ID4gPiArCSpleHRfZXJyMiA9IGFyZ3Mu
cmR4Ow0KPiA+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICt1NjQg
dGRoX21lbV9wYWdlX2RlbW90ZShzdHJ1Y3QgdGR4X3RkICp0ZCwgdTY0IGdwYSwgZW51bSBwZ19s
ZXZlbCBsZXZlbCwNCj4gPiA+IGt2bV9wZm5fdCBwZm4sDQo+ID4gPiArCQkJc3RydWN0IHBhZ2Ug
Km5ld19zZXB0X3B0LCBzdHJ1Y3QgdGR4X3BhbXRfY2FjaGUNCj4gPiA+ICpwYW10X2NhY2hlLA0K
PiA+ID4gKwkJCXU2NCAqZXh0X2VycjEsIHU2NCAqZXh0X2VycjIpDQo+ID4gPiArew0KPiA+ID4g
KwlhdG9taWNfdCAqZHBhbXRfcmVmY291bnQgPSB0ZHhfZmluZF9kcGFtdF9yZWZjb3VudChwZm4p
Ow0KPiA+ID4gKwlzdHJ1Y3QgcGFnZSAqZHBhbXRfcGFnZXNbVERYX0RQQU1UX0VOVFJZX1BBR0Vf
Q05UXTsNCj4gPiA+ICsJdTY0IHJldDsNCj4gPiA+ICsNCj4gPiA+ICsJKmV4dF9lcnIxID0gMDsN
Cj4gPiA+ICsJKmV4dF9lcnIyID0gMDsNCj4gPiA+ICsNCj4gPiA+ICsJaWYNCj4gPiA+IChXQVJO
X09OX09OQ0UoIXRkeF9odWdlX3BhZ2VfZGVtb3RlX3VuaW50ZXJydXB0aWJsZSgmdGR4X3N5c2lu
Zm8pIHx8DQo+ID4gPiArCQkJICF0ZHhfc3VwcG9ydHNfZHluYW1pY19wYW10KCZ0ZHhfc3lzaW5m
bykgfHwNCj4gPiA+ICsJCQkgbGV2ZWwgIT0gUEdfTEVWRUxfMk0pKQ0KPiA+ID4gKwkJcmV0dXJu
IFREWF9TV19FUlJPUjsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKFdBUk5fT05fT05DRShhbGxvY19w
YW10X2FycmF5KGRwYW10X3BhZ2VzLCBwYW10X2NhY2hlKSkpDQo+ID4gPiArCQlyZXR1cm4gVERY
X1NXX0VSUk9SOw0KPiA+IA0KPiA+IFdoeSBoYW5kbGUgdGhpcyBkaWZmZXJlbnRseSB0aGFuIG90
aGVyIHBhbXQgZmxvd3M/IEl0IGFsc28gbG9va3MgbGlrZSB0aGlzDQo+ID4gd2FybmluZyB3YXMg
YWRkZWQgc2luY2UgdGhlIGxhc3QgdmVyc2lvbiBJIHNhdy4uLg0KPiBSaWdodC4gVGhlIHdhcm5p
bmcgd2FzIGFkZGVkIHNpbmNlIHY0IGR1ZSB0byB0aGUgaW50ZXJuYWwgcmV2aWV3Lg0KPiANCj4g
SSBhZGRlZCB0aGlzIFdBUk5fT05fT05DRSgpIGFmdGVyIGFsbG9jX3BhbXRfYXJyYXkoKSBmYWls
cyBiYXNlZCBvbiB0aGUNCj4gZm9sbG93aW5nIGludGVybmFsIHJldmlldyBjb21tZW50OiANCj4g
IkhtbSwgc28gdGhpcyBtYWtlcyBtZSB3b25kZXIsIHdoYXQga2luZCBvZiBlcnJvciBkbyB3ZSB3
YW50IHRvIHJldHVybiB0byBLVk0uDQo+IERvZXMgS1ZNIGV2ZXIgZXhwZWN0IHRoaXMgdG8gZmFp
bD8gV2UgaGFuZGxlIFBBR0VfQVVHIGZhaWxpbmcsIGJ1dCBjYW4gd2UgdGFsaw0KPiBhYm91dCBo
b3cgS1ZNIHdpbGwgY2FsbCB0aGlzLiBXaGF0IGtpbmQgb2YgZmFpbHVyZXMgZG9lcyBpdCB3YW50
IHRvIGtub3cgYWJvdXQNCj4gYW5kIHdoYXQga2luZCBvZiBmYWlsdXJlcyBjYW4gaXQgZG8gc29t
ZXRoaW5nIGFib3V0PyBPdGhlcndpc2UgdG8gcmV2aWV3IHRoaXMNCj4gcGF0Y2ggeW91IG5lZWQg
dG8gbG9vayBhaGVhZCB0byB0aGUgY29kZSBhbmQgdW5kZXJzdGFuZCB0aGUgS1ZNIE1NVS4gSXMg
aXQNCj4gcG9zc2libGUgdG8gZ2l2ZSBzb21lIGp1c3RpZmljYXRpb24gaW4gdGhlIGxvZyBmb3Ig
d2h5IHRoZSBlcnJvciBleHBvc3VyZSBpcw0KPiB0aGUgd2F5IGl0IGlzPyINCg0KSSBkb24ndCBz
ZWUgdGhlIGNvbm5lY3Rpb24gdG8gdHVybmluZyB0aGF0IGludG8gYSB3YXJuaW5nLg0KDQpCdXQg
YmVzaWRlcyB0aGF0LCBwbGVhc2UgZG9uJ3Qgc2lsZW50bHkgY2h1cm4gdGhlIGNvZGUgbGlrZSB0
aGlzLiBFc3BlY2lhbGx5DQp3aGVuIHlvdSBwcm92aWRlIGEgdmVyc2lvbiBsb2csIGJlY2F1c2Ug
aXQga2luZCBvZiBpbXBsaWVzIHRoYXQgbm90aGluZyBlbHNlIHdhcw0KY2hhbmdlZC4NCg0KPiAN
Cj4gSSBhbHNvIG5vdGljZWQgaW4gdGhlIHRkeF9wYW10X2dldCgpIHBhdGgsIHRoZSByZXR1cm4g
dmFsdWUgb2YNCj4gYWxsb2NfcGFtdF9hcnJheSgpDQo+IGlzIHBhc3NlZCBiYWNrIHRvIEtWTSBk
aXJlY3RseSwgdHJpZ2dlcmluZyBLVk1fQlVHX09OKCkuIEhvd2V2ZXIsIHNpbmNlIFNlYW4NCj4g
cHJldmlvdXNseSBwb2ludGVkIG91dCBkb3VibGUgd2FybmluZ3MgKGkuZS4sIGJvdGggaW4gZGVt
b3RlKCkgYW5kIEtWTSBhcmUNCj4gYWNjZXB0YWJsZSk6ICJUd28gV0FSTnMgaXNuJ3QgdGhlIGVu
ZCBvZiB0aGUgd29ybGQuIEl0IG1pZ2h0IGV2ZW4gYmUgaGVscGZ1bA0KPiBpbg0KPiBzb21lIGNh
c2VzLCBlLmcuIHRvIG1vcmUgcHJlY2lzZWx5IGRvY3VtZW50IHdoYXQgd2VudCB3cm9uZy4iIFs1
XSwgSSBmaW5hbGx5DQo+IGFkZGVkIFdBUk5fT05fT05DRSgpIGluIHRoaXMgY2FzZS4NCg0KIlR3
byB3YXJucyBpc24ndCB0aGUgZW5kIG9mIHRoZSB3b3JsZCIgaXMgc2F5aW5nIHNvbWV0aGluZyBk
aWZmZXJlbnQgdGhhbiAiYWRkDQp0d28gd2FybnMgd2hlbiB5b3UgY2FuIi4gU28gd2h5IGRvIHRo
YXQgaGVyZT8gSWYgd2UgaGF2ZSBjb2RlIHRoYXQgZG9lc24ndCBoYXZlDQphIGNsZWFyIHJlYXNv
biBpdCBpcyBnb2luZyB0byBiZSBoYXJkIHRvIGdldCB0aGlzIHBhdGNoIGFja2VkLiBLaW5kIG9m
IHdoYXQgSQ0Kd2FzIHRyeWluZyB0byBzYXkgaW4gdGhlIHF1b3RlIGFib3ZlLg0KDQo+IA0KPiBT
aG91bGQgSSBhbHNvIGFkZCBhIGNvbW1lbnQgc3VjaCBhcyAiVGhlIGNhbGxlciBtdXN0IGVuc3Vy
ZSB0aGVyZSBhcmUgZW5vdWdoDQo+IHBhZ2VzIGluIHRoZSBwYW10X2NhY2hlIj8NCg0KSSB0aGlu
ayBpdCdzIG9idmlvdXMuIFRoYXQgaXMgdGhlIHdob2xlIHBvaW50IG9mIHRoZSBjYWNoZS4NCg0K
PiANCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2FZb1M0NUFaTlkwclVKUURA
Z29vZ2xlLmNvbcKgWzVdDQoNCkl0IGxvb2tzIGxpa2UgU2VhbiB3YXMgc2F5aW5nIHRvIHdhcm4g
YWJvdXQgc3VidGxlIGNvbnRyYWN0IGJyZWFraW5nLiBIZSBhbHNvDQpzYXlzIGluIHRoYXQgdGhy
ZWFkOg0KICAgRG9jdW1lbnQgd2hhdCBleGFjdGx5PyAgTW9zdCBvZiB0aGlzIHNob3VsZCBiZSBj
b21tb24gc2Vuc2UuICBFLmcuIHdlIGRvbid0DQogICBnZW5lcmFsbHkgZG9jdW1lbnQgdGhhdCBw
b2ludGVycyBtdXN0IGJlIG5vbi1OVUxMLCBiZWNhdXNlIHRoYXQgZ29lcyB3aXRob3V0DQogICBz
YXlpbmcgOTkuOSUgb2YgdGhlIHRpbWUuDQoNCkJ1dCBiZXNpZGVzIHRoYXQgd2UgYXJlIHRyeWlu
ZyB0byBnZXQgRGF2ZSdzIGFjayBoZXJlLiBTbyBJIGRvbid0IHRoaW5rDQpleHRyYXBvbGF0aW5n
IGEgY29tbWVudCBTZWFuIG1hZGUgaXMgZ29pbmcgdG8gc3VmZmVjaWVudCBmb3IgaGF2aW5nIGNv
ZGUgdGhhdCBpcw0KZGlmZmVyZW50IHRoYW4gdGhlIHJlc3Qgd2l0aG91dCBleHBsYW5hdGlvbi4g
U28gbGV0J3MgdGhpbmsgYWJvdXQgaG93IHRvIGdldA0KdGhhdCBhY2suIE9idmlvdXNseSB3ZSBz
aG91bGQgdGFrZSBTZWFuJ3MgaW5wdXQgYXMgd2VsbC4gQnV0IHdoaWxlIHdlIGFyZSBvbiB0aGUN
Cm1haW50YWluZXIgYm91bmRhcnksIHdlIGNhbid0IGNhbGwgaXQgc2V0dGxlZC4NCg0KPiANCj4g
DQo+ID4gPiArDQo+ID4gPiArCS8qDQo+ID4gPiArCSAqIFRoZSBkcGFtdF9sb2NrIGlzIHVzZWQg
dG8gYXZvaWQgY29udGVudGlvbiBiZXR3ZWVuIHRoZQ0KPiA+ID4gKwkgKiBUREhfTUVNX1BBR0Vf
REVNT1RFIGFuZCBUREhfUEhZTUVNX1BBTVRfe0FERC9SRU1PVkV9DQo+ID4gPiBTRUFNQ0FMTHMu
DQo+ID4gPiArCSAqLw0KPiA+ID4gKwlzcGluX2xvY2soJmRwYW10X2xvY2spOw0KPiA+ID4gKw0K
PiA+ID4gKwkvKg0KPiA+ID4gKwkgKiBUaGUgY2FsbGVyIGVuc3VyZXMgdGhhdCBERU1PVEUgaXMg
b25seSBpbnZva2VkIG9uIGEgMk1CDQo+ID4gPiBtYXBwaW5nLCBzbw0KPiA+ID4gKwkgKiBkcGFt
dF9yZWZjb3VudCBtdXN0IGJlIDAuDQo+ID4gPiArCSAqLw0KPiA+ID4gKwlpZiAoV0FSTl9PTl9P
TkNFKGF0b21pY19yZWFkKGRwYW10X3JlZmNvdW50KSkpIHsNCj4gPiA+ICsJCXJldCA9IFREWF9T
V19FUlJPUjsNCj4gPiA+ICsJCWdvdG8gb3V0X2ZyZWU7DQo+ID4gDQo+ID4gV2hhdCBpZiB3ZSBk
b24ndCBoYW5kbGUgdGhpcyBjYXNlPyBJdCB3b24ndCBnZXQgY2F1Z2h0IGJ5IHRoZSAocmV0ICE9
DQo+ID4gVERYX1NVQ0NFU1MpIGNoZWNrIGJlbG93PyBJJ20gZ2V0dGluZyBkZWphIHZ1IGFib3V0
IGFsbCB0aGUgZGVmZW5zaXZlDQo+IEl0IHNob3VsZCBiZSBjYXVnaHQgZHVlIHRvIERFTU9URSBz
ZWFtY2FsbCBmYWlsdXJlLg0KPiBIb3dldmVyLCBpdCBtYWtlcyBtZSB1bmNvbWZvcnRhYmxlIHRv
IHNldCBkcGFtdF9yZWZjb3VudCB0byA1MTIgd2l0aG91dCBmaXJzdA0KPiBhc3NlcnRpbmcgdGhh
dCBpdCdzIDAuDQoNCkhtbSwgeWVhIGl0IHNlZW1zIGxpa2UgZ29vZCBjaGVjayB0byBoYXZlLiBC
dXQgSSdtIGRvdWJ0aW5nIGhvdyBtdWNoIHdlIHNob3VsZA0KaGFuZGxlIHRoZSBlcnJvci4gVnMg
anVzdCB3YXJuIGFib3V0IGl0LiBOb3Qgc3VyZS4uLg0KDQo+IA0KPiA+IHByb2dyYW1taW5nLiBJ
IHN3ZWFyIG1hZGUgdGhpcyBjb21tZW50IGJlZm9yZS4NCj4gWW91IGFyZSByaWdodC4gUmUtcmVh
ZGluZyB5b3VyIGNvbW1lbnQgbWFkZSBtZSByZWFsaXplIEkgaGFkIG1pc3NlZCB0aGF0LCBhcw0K
PiB0aGUgZXJyb3IgaGFuZGxpbmcgaW4gdGhlIHByZXZpb3VzIGludGVybmFsIHZlcnNpb24gd2Fz
IGNvbnZvbHV0ZWQuDQo+IA0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCXJldCA9IF9fdGRo
X21lbV9wYWdlX2RlbW90ZSh0ZCwgZ3BhLCBsZXZlbCwgbmV3X3NlcHRfcHQsDQo+ID4gPiBkcGFt
dF9wYWdlcywNCj4gPiA+ICsJCQkJwqDCoMKgIGV4dF9lcnIxLCBleHRfZXJyMik7DQo+ID4gPiAr
CWlmIChyZXQgIT0gVERYX1NVQ0NFU1MpIHsNCj4gPiA+ICsJCVdBUk5fT05fT05DRSgocmV0ICYg
VERYX1NFQU1DQUxMX1NUQVRVU19NQVNLKSAhPQ0KPiA+ID4gVERYX09QRVJBTkRfQlVTWSk7DQo+
ID4gPiArCQlnb3RvIG91dF9mcmVlOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCWF0b21p
Y19zZXQoZHBhbXRfcmVmY291bnQsIFBNRF9TSVpFIC8gUEFHRV9TSVpFKTsNCj4gPiANCj4gPiBU
aGlzIHVzZWQgdG8gYmUgUFRSU19QRVJfUE1EIGFuZCB3ZSB0YWxrZWQgYWJvdXQgc2V0dGluZyBp
dCB0byA1MTIgcGVyIHRoZQ0KPiA+IHNwZWMuDQo+ID4gaW4gYW4gaW50ZXJuYWwgcmV2aWV3Og0K
PiA+IMKgwqDCoCBEZWNyZW1lbnRpbmcgUFRSU19QRVJfUE1EIGJ1dCB0aGUgY29tbWVudCBleHBs
aWNpdGx5IHNheXMgNTEyLiBUaGUgVERYDQo+ID4gc3BlYw0KPiA+IMKgwqDCoCBleHBsaWNpdGx5
IHNheXMgNTEyLCBzbyBJJ2QganVzdCBkbyBhdG9taWNfc2V0KHBhbXRfcmVmY291bnQsIDUxMik7
DQo+IEkgZGlkIHJlcGxhY2UgUFRSU19QRVJfUE1EIHdpdGggNTEyIGFmdGVyIHlvdXIgY29tbWVu
dC4gVGhlbiBpbnRlcm5hbGx5LA0KPiBTYXNoaWtvDQo+IHN1Z2dlc3RlZDoNCj4gDQo+ICJUaGlz
IGlzbid0IGEgYnVnLCBidXQgd291bGQgaXQgYmUgd29ydGggZXhwcmVzc2luZyB0aGUgNTEyIHN5
bWJvbGljYWxseQ0KPiByYXRoZXIgdGhhbiBhcyBhIGJhcmUgbGl0ZXJhbCBoZXJlPw0KPiANCj4g
VGhlIHNlZWQgdmFsdWUgaGFzIHRvIG1hdGNoIHRoZSBncmFudWxhcml0eSB1c2VkIGVsc2V3aGVy
ZSBpbiB0aGlzIGZpbGUuDQo+IHRkeF9maW5kX2RwYW10X3JlZmNvdW50KCkgaW5kZXhlcyB3aXRo
Og0KPiANCj4gCXBmbiA+PiAoUE1EX1NISUZUIC0gUEFHRV9TSElGVCkNCj4gDQo+IGFuZCB0aGUg
YXJyYXkgaXMgc2l6ZWQgd2l0aCBQVFJTX1BFUl9QVEUuIEVhY2ggbGF0ZXIgdGR4X3BhbXRfcHV0
KCkgb24gYQ0KPiA0S0IgcGFnZSBkZWNyZW1lbnRzIHRoaXMgcmVmY291bnQgb25lLWJ5LW9uZSwg
YW5kIG9ubHkgdGhlIGZpbmFsIDEtPjANCj4gdHJhbnNpdGlvbiBmaXJlcyBUREhfUEhZTUVNX1BB
TVRfUkVNT1ZFLCBzbyB0aGlzIHNlZWQgcmVwcmVzZW50cyB0aGUgY291bnQNCj4gb2YgNEtCIHN1
Yi1wYWdlcyBpbiB0aGUgMk1CIHJlZ2lvbi4NCj4gDQo+IE9uIHg4Ni02NCBQVFJTX1BFUl9QVEUg
PT0gNTEyID09IFBNRF9TSVpFL1BBR0VfU0laRSwgc28gdGhlIHZhbHVlIGlzDQo+IGNvcnJlY3Qg
dG9kYXkuIFVzaW5nIFBUUlNfUEVSX1BURSAob3IgYSBuYW1lZCBkZWZpbmUpIGluc3RlYWQgb2Yg
dGhlDQo+IGxpdGVyYWwgNTEyIHdvdWxkIGtlZXAgdGhpcyBzZWVkIGluIGxvY2tzdGVwIHdpdGgg
dGhlIGluZGV4aW5nIGxvZ2ljIGlmDQo+IHRoZSBQTUQvcGFnZSBnZW9tZXRyeSBldmVyIGNoYW5n
ZXMuIFdhcyBhIGJhcmUgbGl0ZXJhbCBwcmVmZXJyZWQgaGVyZSBmb3IgYQ0KPiByZWFzb24/Ig0K
PiANCj4gR2l2ZW4gdGhhdCB0aGUgVERYIHNwZWMgcmVmZXJzIHRvIDUxMiBhczogIlRoZSBob3N0
IFZNTSBjYW4gc3BsaXQgdGhlIG1hcHBpbmcNCj4gb2YgYSBzaW5nbGUgMk1CIG9yIDFHQiBwYWdl
IHRvIDUxMiBjb25zZWN1dGl2ZSA0S0Igb3IgMk1CIHBhZ2VzLi4uIiwgSSB0aGluaw0KPiB1c2lu
ZyBQTURfU0laRSAvIFBBR0VfU0laRSB3b3VsZCBiZSBtb3JlIGFwcHJvcHJpYXRlIGhlcmUgKHRo
b3VnaCBwZXJzb25hbGx5IEkNCj4gdGhpbmsgUFRSU19QRVJfUE1EIGlzIGFsc28gZmluZSkuDQo+
IA0KPiBJIGRpZG4ndCBjb25zaWRlciBpdCBhcyBhIGJpZyBpc3N1ZSBzbyBJIGRpZG4ndCBtZW50
aW9uIGl0IGluIHRoZSBjaGFnbmVsb2cuDQoNCkkgdGhpbmsgaXQga2luZGEgaXMgYWN0dWFsbHku
IEl0IHdhcyBhIHBvaW50IG9mIGRpc2N1c3Npb24gdGhhdCBnb3Qgc2V0dGxlZCBhbmQNCnRoZW4g
c2lsZW50bHkgY2hhbmdlZC4gVGhpcyBtYWtlcyBpdCBoYXJkIHRvIHJldmlldyBzdWNjZXNzaXZl
IHZlcnNpb25zIG9mIHRoZQ0Kc2VyaWVzLiBJdCBhbGwgaGFzIHRvIGJlIHJldmlld2VkIGZyb20g
c2NyYXRjaC4NCg0KVGhlIHJpZ2h0IHRoaW5nIHRvIGRvIHdvdWxkIGhhdmUgYmVlbiB0byByZS1v
cGVuIHRoYXQgdGhyZWFkIHdoZXJlIGl0IGdvdA0KY2xvc2VkLiBTYXNoaWtvIGRvZXNuJ3QgZ2V0
IGEgc3R5bGUgdm90ZS4gYnV0IHlvdSBkbyBpZiB5b3UgY2hhbmdlZCB5b3VyIG1pbmQuDQpCdXQg
Y2hhbmdpbmcgeW91ciBtaW5kIGlzIG5vdCBhIHJlYXNvbiB0byBzaWxlbnRseSBjaGFuZ2UgdGhl
IGNvZGUgdG8gc29tZXRoaW5nDQpvdGhlciB0aGFuIGRpc2N1c3NlZC4NCg0KTXkgcHJlZiB3b3Vs
ZCBiZSA1MTIgb3IgUFRSU19QRVJfUE1EIGJlZm9yZSBQTURfU0laRSAvIFBBR0VfU0laRS4NCg0K
PiANCj4gPiBOb3cgaXQgaGFzIGNoYW5nZWQgdG8gUE1EX1NJWkUgLyBQQUdFX1NJWkUuIFRoZXJl
IHNlZW1zIHRvIGhhdmUgYmVlbiBhdA0KPiA+IGxlYXN0IGEgZmV3IGNoYW5nZXMgdGhhdCBtaXNz
ZWQgdGhlIHZlcnNpb24gbG9nLiBXaGF0IGhhcHBlbmVkPyBBSSByZXZpZXc/DQo+ID4gV2UgbmVl
ZCB0byBtYWtlIHN1cmUgd2UgYXJlIG5vdCByb2xsaW5nIGJhY2sgcHJldmlvdXMgZGVjaXNpb25z
IHNpbGVudGx5Li4uDQo+IFdpbGwgbWFyayB0aGlzIGtpbmQgb2YgY2hhbmdlIG5leHQgdGltZS4N
Cj4gDQo+ID4gQ2FuIHlvdSBzaGFyZSBtb3JlIHdpZGVseSBpZiB0aGVyZSBhcmUgbmV3IHVubWVu
dGlvbmVkIGNoYW5nZXMgaW4gdGhlIHJlc3QNCj4gPiBvZg0KPiA+IHRoZSBzZXJpZXM/DQo+IEJl
c2lkZXMgdGhlIG1haW4gY2hhbmdlcyBsaXN0ZWQgaW4gdGhlICJNYWluIGNoYW5nZXMgZnJvbSB2
MyIgc2VjdGlvbiBvZiB0aGUNCj4gY2hhbmdlbG9nLCBhbmQgdGhvc2UgYWxyZWFkeSBkb2N1bWVu
dGVkIGluIHRoZSBjaGFuZ2Vsb2cgb2YgZWFjaCBwYXRjaCwgdGhlDQo+IGZvbGxvd2luZyBjaGFu
Z2VzIHZzIHYzIGFyZSB1bmRvY3VtZW50ZWQ6DQo+IA0KPiBQYXRjaCAxOiBhZGRlZCBhIGxldmVs
IGFyZyBhbmQgaGF2ZSB0aGUgY2FsbGVlIHRvIGRlY2lkZSB3aGV0aGVyIHRvIHNraXAgUEFNVA0K
PiDCoMKgwqDCoMKgwqDCoMKgIGFkZC9wdXQuDQo+IFBhdGNoIDI6IC0gUFRSU19QRVJfUE1EIHRv
IFBNRF9TSVpFIC8gUEFHRV9TSVpFLA0KPiDCoMKgwqDCoMKgwqDCoMKgIC0gYXRvbWljX2NtcHhj
aGdfcmVsZWFzZSgpIHRvIGF0b21pY19zZXQoKSBkdWUgdG8gdGhlIHNwaW5sb2NrDQo+IAnCoMKg
IHByb3RlY3Rpb24uDQoNCkNhbiB5b3UgZXhwbGFpbiBtb3JlIG9uIHRoaXMgb25lPyBJIG1pc3Nl
ZCBpdC4NCg0KPiDCoMKgwqDCoMKgwqDCoMKgIC0gYWRkZWQgYSBoZWxwZXIgX190ZGhfbWVtX3Bh
Z2VfZGVtb3RlKCkuDQoNCndoeT8NCg0KPiBQYXRjaCAzOiBpbXBsZW1lbnRhdGlvbiBpcyBtdWNo
IHNpbXBsZXIgZHVlIHRvIHRoZSB0aGUgYmFzZSBjb2RlIGNoYW5nZXMNCj4gwqDCoMKgwqDCoMKg
wqDCoCBpbnRyb2R1Y2VkIGJ5IHRoZSBwcmV2aW91cyBNTVUgcmVmYWN0b3IgYW5kIGZvbGlvL3Bh
Z2UgdG8gcGZuIHNlcmllcy4NCj4gUGF0Y2ggNDogLSBNb3ZlZCBpc19taXJyb3Jfc3AoKSBpbW1l
ZGlhdGVseSBhYm92ZSBkaXNhbGxvd2VkX2h1Z2VwYWdlX2FkanVzdCgpDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGluc3RlYWQgb2Ygc2F2aW5nIGl0IGluIGEgbG9jYWwgdmFyaWFibGUuDQo+IAkg
LSBhZGRlZCBhIGNvbW1lbnQgZXhwbGFpbmluZyB0aGUgZGlzYWxsb3dpbmcgcmVhc29uLg0KDQo=
