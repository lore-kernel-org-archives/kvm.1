Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13A3839B9;
	Tue,  6 Oct 2026 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330997; cv=fail; b=mlV/cFiNkSv8fIlma5YS8OF0GYm9KGStqZsJnTnUXaIN+HfoEk5RT+foIH+JaiZ+AF8geYeKWqTWRV/zxkMOU4NuN36ab+xNlCzU7knmVMfTF3XY4tojfCukYK17A1+uuQQSULW6k6TOY9TIsSLd3ucset+w7jdsEiCCx54v6/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330997; c=relaxed/simple;
	bh=9ZtZuRIu5rXOq512rTClelrXwHgwbAU43YRJl4TfzIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YfiDvi1LMSdsYMtbs2LKpCmxX5a6pvjSiR1+2RoNg6F+yTdxFU2NqOahNJDxHsNJZoxc1fp6iQUtKJg59vxD5ry6Tj6ZZ8U5qWOqrd7c6iMIhPuU5LPq4DaPIMDr/3YPyct2x8oZxf26gvmeclhS8IVwuUc5iKQ2cV5mbKfn3mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FU3Tx9EP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FU3Tx9EP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791330995; x=1822866995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9ZtZuRIu5rXOq512rTClelrXwHgwbAU43YRJl4TfzIE=;
  b=FU3Tx9EPwpkriBpv5l9gNshvgEuZsKsEsrsVRxo3FfMLg1gGcRy0jKL5
   8GYEJiQTD9t3npmxWN9KpTgSwRYCiqGyADQVDFRV2q6gK9s/PwYHtXo3d
   Rqy9E9TjlvpxVg7dU6zOIC4p0s4odKrua33pRG98F1i+lojUZc76duKUL
   HR2Wl5KLJ4yye82jADuFKbMe/5P+obws7kyZPk3OX/pw6YVWr3mw1QdGp
   b5p0IBmmrn7TVV0lLVyOTePhhCZFrM/01WkyNCaDn/ojMmaiqGJyEGHBd
   Jqmi1zWAJHBaZCNLnVILHYA+pXmaMw+foakeMqgTiMcgZ56nwvS+KZWbf
   Q==;
X-CSE-ConnectionGUID: v6IkuYA+S+GSeH6+9von9Q==
X-CSE-MsgGUID: MoVzjrFoQVSTDpTafT9igw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="102194498"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="102194498"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 16:56:35 -0700
X-CSE-ConnectionGUID: fs/iPWSMT2GOMKT3o0JAhw==
X-CSE-MsgGUID: BxcXJrFMRA6s98hGU6fgiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="315319937"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 16:56:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 16:56:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 16:56:33 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 16:56:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpnIdv8kUjuDwlRUBwREewfwEUz4qhFge9uvqXNdMlKoanLms62YWbNk1BjPRgt2sT0BD20NT5SW8si5hBVKGT48MB0xQr6uONkn12P0zr1PnRuIEkQYSMyQf3Y+EwFUQOGWKBzmXyZaYeFz8ZrbbLHW2NLpxL2tuNt5G2GdSOlxjQNPUNPnGO33Ixz67H3BS+hNBebx0tEqlBzGGVdN+XsGKNoNcKk6jbPOsMYkrNebpmIUBdNWuh6jzIaXRea6mo7BcWgQHjdAdT+SZ2uJOTZQ3cKKLQFEPoMd8gjghrhwd+l4qNYVf5QS4sxy2KMdcXGaAi1ZskpgBd6RrHWf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZtZuRIu5rXOq512rTClelrXwHgwbAU43YRJl4TfzIE=;
 b=SBm1wXRGhn+X7HC3OF4Z/gBpdmiVqSG93Ri+SmJZaHVcfkdCBRldYmBMlzjCAQQ9YoPJRw1BeNUDwP1YklizSix/w2dDDBIPsxEj5om7H/Z3/L/fU/qjmgV2ZlmU2y5KG2HwOV9bRxCarD1upg+ltp1xCjWIrj0YizqgdAlZZPCMohLbc5hw//RaxWBd0nC2dXvgu/DrqIYzftI6UA0R7F7uivv6CcoAmpa7foU0+2e0bGL3AgX8Xc0OeIVBd3TgePfyaWvORSCjl0Y2IlEeUeqPc3YIG02x9Jv/QClSqnXjMDgqjly6jslwoyx9Px23mQb9C58g3ZBvS7S1Z0drOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA0PR11MB7861.namprd11.prod.outlook.com (2603:10b6:208:3de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Tue, 6 Oct
 2026 23:56:24 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Tue, 6 Oct 2026
 23:56:23 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Xu,
 Yilun" <yilun.xu@intel.com>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>
Subject: Re: [PATCH v3 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init
Thread-Topic: [PATCH v3 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init
Thread-Index: AQHdVPFmExIGsUMl602vvqA16jCvyrbxMrAA
Date: Tue, 6 Oct 2026 23:56:23 +0000
Message-ID: <51a0f0e33d523fa652b3c664ea1083a9459bd323.camel@intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
	 <20261006-tdx-module-ext-v3-2-db52cb05b918@linux.intel.com>
In-Reply-To: <20261006-tdx-module-ext-v3-2-db52cb05b918@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA0PR11MB7861:EE_
x-ms-office365-filtering-correlation-id: f425bd70-3b9e-4098-b19a-08df24056d4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|23010399003|376014|10067099003|6133799003|56012099006|11063799006|38070700021|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: ZHuHRh3yVnSjcIXBexIj1MnFATSQGRIdJ7YaPh120384EFYTl5cf2HFoZCl4bHo6hp66i3Euw0//lvTgufXtXmMuIVkm58lAWTDfTLyi4IY/7xFbGn7zwacd1NuU0BQevUxV2LElIodx6y2wg8YENC4g5Anq8y6tGbARPqr9tR3F7P0/8b7PAHzp6l77Nn8+0080QPhYXFCBuhGxnq9nD2fGi70zyYs2e2YMNIJSZfEgqBJt60xN+YCEGdfrHB6IGP8MC0ZAtUGPkaOA9saHD9pGllEwyxZd1X8zIdSwTnOkfNC7beNWAPy00s0tctg6i/WhjCOK1llm3iu9IoB7VfZ3ZjZXSM+doulHIdxqaNmJmAtAQwR2TgdXCD2pOmpKOFregterAMdX1juyxD1RunMqxiKFazx6y5I0+v40h0yIEZLBLYxmmZa9ETJOfh8P2DDj9YAnKFT/h7t/MRq19Ss64VBSU+CV/pbfLLr2TKPLCLGz5QoMKsRLneaK1PFlm4c6BdJjalYRHPzFrqz2lL7qQ1WwSDhcQJSCzzN7Bq5Ooku8F1eyxhCfI/jKAaN/sUqj++3hNpv8yKJxFL3YsCdTr56y5JhrvAzRKl1me6ehqjBkARevRMByr4XMXmVNLquj5y5KAI1YFgCdNLT1xXX+rtEGk/tPJeYXBMyCqeA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(56012099006)(11063799006)(38070700021)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk5PZzdMUGVoQVcwaXdaRVlFaGFlc043b3FtVE9qazdlTzJDR0dWRm5EbGdN?=
 =?utf-8?B?MUFWb2VScG41ZmRlLzBzQ2ZaeStYMUJ3U2RGbUZITE1xbDdiQVhVMnpDTkRk?=
 =?utf-8?B?ZTVSeExHOGZzb3VMc3QrTHUrcUJMc3dWeTFjem1zVFpOVzB3eTJydlpaRmRv?=
 =?utf-8?B?bWJzMlZsWHMzL2ZiU3dxY3MzMVBaSmRHSzN3MTFZVkJJbDB4cUZZRW8vNnUw?=
 =?utf-8?B?MjJRdmNvSno0WUlLa25KTG9xMVpYVE9FdTc4aHNyeWp3K2VCYzlTZm1LeFNK?=
 =?utf-8?B?QmNaS2NjSkJnekNEMXdHaUowaStKV0xOakRxazdwQmtmTytOeVcwMlYyOHlJ?=
 =?utf-8?B?andBa09oTmVwcU9lNlRMMmFJdmV3WjhyRk45MzJzNG1PSEwyVGdqNHZndWk3?=
 =?utf-8?B?ZEFDZnVoWnNmTW9YVEd0S041UXQ2MDNub0Z2WnlZeDVRaEFRR3VQMVdwTWh4?=
 =?utf-8?B?TFF5YXcyR0IxNG1oY0NCV1B0d0Z0S29WQkhrNE1KdENUSWt2Ri9zY3l5bTlP?=
 =?utf-8?B?RXFYYXE3aW1WcERMZkRBQ3BibnlDMm5zZDhTZDVidFltUEU3WjlycSt2b2hh?=
 =?utf-8?B?SjNxRGd5M3lHc1huczRvM283UDVmVzlUZnJtWnRoL3J4dnd2cjB3Y1U1YzBE?=
 =?utf-8?B?UGZSU09aM1Nuei9VTlk1azlVejQzZ2ZESkpjQy9pQ2k2QXVESCtRYS9PRkdj?=
 =?utf-8?B?TVdVWmJpYnZzVjNzR3JzN2JycWxQWnFtb3lqQTZGT0lGMC9pQzJBOE96SE02?=
 =?utf-8?B?RFZOSzNscitIcmpzcUVDUVZvbFdyeHk1WHVqMHpvdWhSb0Y0VHVwQXhVRDFQ?=
 =?utf-8?B?TGZjTDlXUUlpOHZhRlhPb0pBWWFFODE5UDZpeHg2MmUyUnhhcHJYV01YSWNG?=
 =?utf-8?B?WVJOd2JGb2JJZ2FWdEJ1anpQUk5qKzYyaitWdTFqV2RIOVk0RitSdGo5VFhE?=
 =?utf-8?B?ZTBJTmt2R3Q2WWdDU1hRL2FtcVBQNHU5eW9aVnMwY0ZyR3hJQUFzQ0x6NC8v?=
 =?utf-8?B?N3d2Y0N5dG00MnNwcFpqeUlpbTNqNDR4bVFWRkZGUXJvbXNUTzNFVGpEclQ5?=
 =?utf-8?B?S2V2ZlR6aTltMCtFUnNjTGlhRGNuTFQ0NGlRZVdjVE80N2xLT3M5alRmZU9w?=
 =?utf-8?B?eXhlVU9EK1pyY3dGdlMwSnlvbzlWWEE3UUx0a0IyTWM3anpSelJrSkVsLzJo?=
 =?utf-8?B?bG9CMS91WExBUFBvNXdweGppMVBpNmJQNytjLzFadXN2dnF1aUloU2RjWnU3?=
 =?utf-8?B?cnc4ZHovOXR6NkoyT3lSYlF1LzJLREVRdWI2cXJsMHl2WGtWM2ZKOHFBZFVQ?=
 =?utf-8?B?T1NQODVRVjk1YW1sM2lJQ1VhQkVUWmxwYWhMMXIrejd0NUZpWG1taklHL0Nx?=
 =?utf-8?B?aGFlNmtUbzRwcW9LRmR2QTd5eGJUYXRjRm93Wk9NTnpWaVB6ZU5LNTdiL2pS?=
 =?utf-8?B?a0x3S3RWQ1B6eC93RWZnd2RENCtrcW9mcHM1SWoyNEtrNjlkenVCVFNqbEJY?=
 =?utf-8?B?VG9vMTdISVRyMGswWFNabWYxMmdhbzJVbE0wUFAvMWJmRXg3QVBmeUEvMjcx?=
 =?utf-8?B?bU5xMjBqaHZiV2R1TU5KaWdkaG1MVEo2bjJzZVJyZXp1K0xMNWNQTmdIVjdK?=
 =?utf-8?B?anNiRisrMjdNOXdpRmp4cFNHY2FabGxBV2IybTZLZ0t3cnFuemVYbVFjckVo?=
 =?utf-8?B?NWtJK1Z0cTRDWEUzL3NXR0pWOFBuZkpjYmNZVlJrMVVCaU5OZDZYS2MxTWtr?=
 =?utf-8?B?Sloxc1c5ZmVWQ1o5bUEwWFFQZXJ4WS9kVjlDcm5XVGlUMUU5ZHc0aVY1N2oz?=
 =?utf-8?B?Yk9UVDNrbzBXT2RmeTJnSUJSY1RYRVE4aHZMNThGbjhQU1dpSVlJMTFzN0dZ?=
 =?utf-8?B?QmpPSFgvNU1PRTZ1TTlvb3JKV1lQbVAyWkNDcFE5bnhNbkpLRmljRXpXa0hO?=
 =?utf-8?B?K0liRStLYUxWTXU3ay9EbWR5TjNFUWl1QzBsR2ZDclJaU0pYODVxUStuKzZt?=
 =?utf-8?B?YjJwQ2ovRXZPb1JyeFVTS1lwTHFwdWl5SzhZY1FlM2dXaWFsd2hjN3BMTzZ0?=
 =?utf-8?B?ckYwVHcwVmxYK1poeEhjb3NrM2k3Zy9ReGdzeHM5T3NmY29NMXV2REh1S3kv?=
 =?utf-8?B?MjV2ZnhpdXVsUlR1TTFsOWhYbVNXeXVQaE5ndlhKWGVsWSttREVqMmE5Nkx2?=
 =?utf-8?B?SWROaEZDSkxObVMwR1pVL25zRjlxeEtHMFRCaGlkMW9aaG4zeHFpSExGR24z?=
 =?utf-8?B?VzJZZTdEVXlRWXZFM3BKdlJDSWRncWpKd1F4WE5XWXpqYWtIQzdSQ05KR3VG?=
 =?utf-8?B?aDNlZWFycFRVd0VnMnVuZmtHTjZndi9MYktSUXVHdThvR2xhTzZIYVdubk5m?=
 =?utf-8?Q?P55giAzHfHWWw9SY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <448863892C708C4082C0516275C3BD3C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rW+JaGxYmKUPZvliltlFYwDbHk18G90cifZHi80J7RAmNqwStFXYL0HVp0TCuftv0rRB4vIbpXZ9Ut1yGz15outMetnnSesDo7kKu+t0BOH8uY9LWAP0MPDRI9axVIBNOlS2JLt+OSCtu21eor1uMKm8szL88VbS53A8S8x8Tf/q2huVJ8nGcf5Dh8R/wVbgfN5Yh9bYofHEbdfwccmYyri/qrQJAI8ujwBP2DL8B2Esfl+MLZFA3g07bxrET2ku4iwmRqWgFi/oo/bjnIS7AFf0/0+OlYdSV7DkWwdU0HZ7/Awm6GInYOsHjhemCmzOeZ145mCAwMQ/AR4ERZ5xzQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f425bd70-3b9e-4098-b19a-08df24056d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 23:56:23.6692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1/whP1lLoQhrbg3bmDu7nfvM87ufYsftHHIOqmvolwRGX8ofkcHkhSSJTy8/4Rz+xRHB4U7pYYFPDwws/loLO2u/ClzDCr8rLNS/1vCIZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7861
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTEwLTA2IGF0IDAxOjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gVGhl
IFREWCBhcmNoaXRlY3R1cmUgaWRlbnRpZmllcyBzb21lIGZlYXR1cmVzIHRoYXQgYXJlIG9mZiBi
eSBkZWZhdWx0DQo+IGJ1dCBjYW4gYmUgZW5hYmxlZCBieSB0aGUgaG9zdCBkdXJpbmcgVERYIG1v
ZHVsZSBpbml0aWFsaXphdGlvbi4gVGhleQ0KPiBhcmUgY2xhc3NpZmllZCBhcyBhZGQtb24gZmVh
dHVyZXMgYmVjYXVzZSBlbmFibGluZyB0aGVtIGFmZmVjdHMgZXhpc3RpbmcNCj4gVERYIHN5c3Rl
bXM6IHRoZXkgbWF5IGNoYW5nZSBleGlzdGluZyBmZWF0dXJlIGJlaGF2aW9yLCBvciByZXNlcnZl
IG1vcmUNCj4gbWVtb3J5Lg0KPiANCj4gVGhlIFREWCBtb2R1bGUgZXh0ZW5kcyBUREguU1lTLkNP
TkZJRyB3aXRoIGEgbmV3IHJlZ2lzdGVyIGFyZ3VtZW50IHRvDQo+IHNwZWNpZnkgd2hpY2ggYWRk
LW9uIGZlYXR1cmVzIHRvIGVuYWJsZS4gVGhpcyBuZXcgYXJndW1lbnQgaXMgYSBiaXRtYXANCj4g
dGhhdCB1c2VzIHRoZSBzYW1lIGZlYXR1cmUgYml0cyBhcyBURFhfRkVBVFVSRVMwLiBOb3RlIHRo
YXQgRHluYW1pYyBQQU1UDQo+IGlzIGFuIGV4Y2VwdGlvbjogYWx0aG91Z2ggaXQgaXMgYW4gYWRk
LW9uIGZlYXR1cmUsIGl0IGlzIGNvbnRyb2xsZWQgdmlhDQo+IGEgbGVnYWN5LCBkZWRpY2F0ZWQg
cmVnaXN0ZXIgYXJndW1lbnQgWzFdLg0KPiANCj4gVGhlIGtlcm5lbCBuZWVkcyB0byBlbmFibGUg
dGhlc2UgYWRkLW9uIGZlYXR1cmVzIHdoZW4gaXQgc3VwcG9ydHMgdGhlbS4NCg0KSSBtYWRlIGEg
c2ltaWxhciBjb21tZW50IG9uIHYxOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC80MWY1
YTU1OGNhNjdlMjg5NWZjYjExNGM0MThmMGU0NTNlOTMzOTc0LmNhbWVsQGludGVsLmNvbS8NCg0K
SXQgaXMgdXAgdG8gdGhlIGtlcm5lbCB0byBkZWNpZGUgaWYgaXQgd2FudHMgdG8gZW5hYmxlIHRo
ZXNlIGZlYXR1cmVzLCB3aGVuIGl0DQpzdXBwb3J0cyB0aGVtLiBUaGUgc2VudGVuY2Ugc291bmRz
IGxpa2UgdGhlcmUgaXMgc29tZSBoYXJkIHJlcXVpcmVtZW50IHRvIGVuYWJsZQ0KdGhlbSB3aGVu
IHBvc3NpYmxlLiBJIHRoaW5rIHRoZSByZWFzb25zIHRvIGVuYWJsZSB0aGVtIGJhc2VkIHNvbGVs
eSBvbiBhdmFpbGFibGUNCnN1cHBvcnQgY291bGQgYmU6DQogMS4gVGhleSBkb24ndCB0YWtlIHNp
Z25pZmljYW50bHkgbW9yZSBtZW1vcnkgb3IgQ1BVIHJlc291cmNlcywgYW5kIGxpbWl0aW5nDQpw
b3NzaWJsZSBjb25maWdzIHJlZHVjZXMga2VybmVsIGNvbXBsZXhpdHkuDQogMi4gSXQgd291bGQg
YmUgcmFyZSB0aGF0IHBlb3BsZSBkb24ndCB3YW50IHRoZW0gb24uDQoNCk1heWJlIHdlIHR3ZWFr
IHRoaXMgdG8gYmU/DQoNCkRlc3BpdGUgdGhhdCB0aGVzZSBmZWF0dXJlcyBjYW4gYmUgYWRkLW9u
cyBkdWUgdG8gaW50cm9kdWNpbmcgc29tZSBvdmVyaGVhZCB0bw0KVERYIHJ1bnRpbWUsIHRoZSBp
bXBhY3Qgb2YgdGhlIGZpcnN0IGZlYXR1cmVzIHdpbGwgYmUgbG93IGVub3VnaCB0byBwdXJzdWUg
YQ0Kc2ltcGxlIGFwcHJvYWNoIG9mIGp1c3QgZW5hYmxpbmcgdGhlbSB3aGVuIHN1cHBvcnRlZC4g
SWYgYSBmZWF0dXJlIHdpdGggYSB2ZXJ5DQpoaWdoIG92ZXJoZWFkIGFwcGVhcnMgaW4gdGhlIGZ1
dHVyZSwgdGhpcyBjYW4gYmUgcmV2aXNpdGVkLg0KDQo+IEFkZCBhIGdldF90ZHhfdXNhYmxlX2Fk
ZG9uX2ZlYXR1cmVzMCgpIGhlbHBlciB0byByZXR1cm4gdGhlIGJpdG1hcCBvZg0KPiB0aGUgYWRk
LW9uIGZlYXR1cmVzIHRoYXQgdGhlIG1vZHVsZSAmIGtlcm5lbCBib3RoIHN1cHBvcnQuIEluaXRp
YWxseSwNCj4gdGhpcyBoZWxwZXIgcmV0dXJucyAwLiBJdCB3aWxsIGJlIHVwZGF0ZWQgdG8gcmV0
dXJuIHNwZWNpZmljIGZlYXR1cmUNCj4gYml0cyBhcyBmdWxsIGtlcm5lbCBzdXBwb3J0IGxhbmRz
LiBQYXNzIHRoaXMgYml0bWFwIGFzIGFuIGFyZ3VtZW50IHRvDQo+IFRESC5TWVMuQ09ORklHLg0K
PiANCj4gVGhlIFREWCBtb2R1bGUgcmVxdWlyZXMgU0VBTUNBTEwgbGVhZiB2ZXJzaW9uIDEgZm9y
IFRESC5TWVMuQ09ORklHIHdoZW4NCj4gcGFzc2luZyB0aGUgbmV3IGJpdG1hcCBhcmd1bWVudC4g
QSBwcmV2aW91cyBjaGFuZ2UgWzJdIHN1cHBvcnRzIHRoZQ0KPiB2ZXJzaW9uZWQgU0VBTUNBTEwg
bGVhZnMgYnkgYWRkaW5nIGEgInZlcnNpb24iIGZpZWxkIGluDQo+IHN0cnVjdCB0ZHhfbW9kdWxl
X2FyZ3MuIFNldCB0aGUgdmVyc2lvbiBmaWVsZCB0byAxIGlmIHRoZSBuZXcgYml0bWFwDQo+IGFy
Z3VtZW50IGlzIHVzZWQgdG8gZW5hYmxlIGFueSBhZGQtb24gZmVhdHVyZSwgb3RoZXJ3aXNlIGtl
ZXAgdGhlDQo+IHZlcnNpb24gYXMgMC4gVGhpcyByZXRhaW5zIGJhY2t3YXJkIGNvbXBhdGliaWxp
dHkgd2l0aCBvbGRlciBtb2R1bGVzDQo+IHRoYXQgZG9uJ3QgcmVjb2duaXplIHZlcnNpb24gMS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFh1IFlpbHVuIDx5aWx1bi54dUBsaW51eC5pbnRlbC5jb20+
DQo+IFJldmlld2VkLWJ5OiBUb255IExpbmRncmVuIDx0b255LmxpbmRncmVuQGxpbnV4LmludGVs
LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE5pa29sYXkgQm9yaXNvdiA8bmlrLmJvcmlzb3ZAc3VzZS5j
b20+DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDkwNDIxNTg0MS4z
MDMwNzAtMTAtcmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20vICMgWzFdDQo+IExpbms6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDkyMS1zZWFtY2FsbC12ZXJzaW9uLXY3LTEtY2Yw
NWZlNzZiNDY3QGxpbnV4LmludGVsLmNvbS8gIyBbMl0NCg0KV2l0aCB0aGUgbG9nIG5pdCwNCg0K
UmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4N
Cg0KPiAtLS0NCj4gdjM6DQo+ICAtIFVwZGF0ZSB0aGUgc3RhbGUgY2hhbmdsb2cgZm9yIGJpdG1h
cCBhcmcgb2YgdGhlIHdyYXBwZXIgKENoYW8pDQo+ICAtIHMvZ2V0X3RkeF9hZGRvbl9mZWF0dXJl
czAoKS9nZXRfdGR4X3VzYWJsZV9hZGRvbl9mZWF0dXJlczAoKSAoVG9ueSkNCj4gIC0gQ29sbGVj
dCBSZXZpZXdlZC1ieSB0YWdzDQo+IA0KPiB2MjoNCj4gIC0gRG9uJ3QgcGFzcyBhZGRvbl9mZWF0
dXJlczAgcGFyYW1ldGVyIGFyb3VuZCwgZ2V0IGl0IGluIHRoZSB3cmFwcGVycw0KPiAgIChEYXZl
KQ0KPiAgLSBSZW1vdmUgVERILlNZUy5VUERBVEUgd3JhcHBlciAoRGF2ZSAmIFJpY2spDQo+ICAt
IERyb3AgdGhlIGNoYW5nZWxvZyBzZWN0aW9uIGV4cGxhaW5pbmcgd2h5IGFkZC1vbiBmZWF0dXJl
IGVuYWJsaW5nIGlzDQo+ICAgIG5lZWRlZCBpbiB0aGlzIHNlcmllcywgYXMgaXQgaXMgYSBnZW5l
cmFsbHkgdW5kZXJzdG9vZCBwYXR0ZXJuIChSaWNrKQ0KPiAgLSBBZGQgYSBub3RlIGluIHRoZSBj
aGFuZ2Vsb2cgdGhhdCBEeW5hbWljIFBBTVQgaXMgbm90IGVuYWJsZWQgdmlhIHRoZQ0KPiAgICBu
ZXcgYml0bWFwIGFyZ3VtZW50IChSaWNrKQ0KPiAgLSBBZGQgX19pbml0IHRhZyBmb3IgZ2V0X3Rk
eF9hZGRvbl9mZWF0dXJlczAoKSAoQUkgbml0cGlja2VyKQ0KPiANCj4gdjE6DQo+ICAtIFVzZSB0
ZHhfbW9kdWxlX2FyZ3MudmVyc2lvbiB0byBhc3NpZ24gU0VBTUNBTEwgbGVhZiB2ZXJzaW9ucyAo
RGF2ZSkNCj4gIC0gUmVtb3ZlIERJQ0Ugc3BlY2lmaWMgZGVzY3JpcHRpb25zIChSaWNrKQ0KPiAg
LSBSZW1vdmUgdGhlIGdsb2JhbCB2YXIgdGR4X2FkZG9uX2ZlYXR1cmVzMCAoQ2hhbykNCj4gIC0g
QWRkIGEgTWFjcm8gdG8gY29sbGVjdCBrZXJuZWwgc3VwcG9ydGVkIGFkZC1vbiBmZWF0dXJlIGJp
dHMgKFJpY2spDQo+ICAtIENoYW5nZWxvZyAmIGNvZGUgY29tbWVudHMgY2hhbmdlDQo+IC0tLQ0K
PiAgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jIHwgMTkgKysrKysrKysrKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMN
Cj4gaW5kZXggYjA5OWFhNDA1NmY1Li5mMDgyNzhhNDdhZmYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
eDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiArKysgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4
LmMNCj4gQEAgLTEwNDIsOSArMTA0MiwxOSBAQCBzdHJ1Y3QgdGRtcl9pbmZvX3BhX2FycmF5IHsN
Cj4gIAlERUNMQVJFX0ZMRVhfQVJSQVkodTY0LCBwaHlzKTsNCj4gIH07DQo+ICANCj4gKy8qIExp
c3QgYWxsIGtlcm5lbC1zdXBwb3J0ZWQgYWRkLW9uIGZlYXR1cmVzMCBiaXRzIGhlcmUgKi8NCj4g
KyNkZWZpbmUgVERYX0tFUk5FTF9TVVBQT1JURURfQURET05fRkVBVFVSRVMwCSgwKQ0KPiArDQo+
ICtzdGF0aWMgX19pbml0IHU2NCBnZXRfdGR4X3VzYWJsZV9hZGRvbl9mZWF0dXJlczAodm9pZCkN
Cj4gK3sNCj4gKwlyZXR1cm4gdGR4X3N5c2luZm8uZmVhdHVyZXMudGR4X2ZlYXR1cmVzMCAmDQo+
ICsJCVREWF9LRVJORUxfU1VQUE9SVEVEX0FERE9OX0ZFQVRVUkVTMDsNCj4gK30NCj4gKw0KPiAg
c3RhdGljIF9faW5pdCBpbnQgdGR4X3N5c19jb25maWcoc3RydWN0IHRkbXJfaW5mb19wYV9hcnJh
eSAqdGRtcl9wYV9hcnJheSwNCj4gIAkJCQkgdW5zaWduZWQgaW50IG5yX3RkbXJfcGEsIHU2NCBn
bG9iYWxfa2V5aWQpDQo+ICB7DQo+ICsJdTY0IGFkZG9uX2ZlYXR1cmVzMCA9IGdldF90ZHhfdXNh
YmxlX2FkZG9uX2ZlYXR1cmVzMCgpOw0KPiAgCXN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9
IHsNCj4gIAkJLnJjeCA9IF9fcGEodGRtcl9wYV9hcnJheSksDQo+ICAJCS5yZHggPSBucl90ZG1y
X3BhLA0KPiBAQCAtMTA1Niw2ICsxMDY2LDE1IEBAIHN0YXRpYyBfX2luaXQgaW50IHRkeF9zeXNf
Y29uZmlnKHN0cnVjdCB0ZG1yX2luZm9fcGFfYXJyYXkgKnRkbXJfcGFfYXJyYXksDQo+ICAJCWFy
Z3MucjggfD0gVERYX1NZU19DT05GSUdfRFlOQU1JQ19QQU1UOw0KPiAgCX0NCj4gIA0KPiArCS8q
DQo+ICsJICogVXNlIFNFQU1DQUxMIHZlcnNpb24gMSB0aGF0IHN1cHBvcnRzIGFkZC1vbiBmZWF0
dXJlcyBpZiBhbnkgYXJlDQo+ICsJICogcmVxdWVzdGVkLiBPdGhlcndpc2UgdXNlIHZlcnNpb24g
MCBmb3IgYmFja3dhcmQgY29tcGF0aWJpbGl0eS4NCj4gKwkgKi8NCj4gKwlpZiAoYWRkb25fZmVh
dHVyZXMwKSB7DQo+ICsJCWFyZ3MucjkgPSBhZGRvbl9mZWF0dXJlczA7DQo+ICsJCWFyZ3MudmVy
c2lvbiA9IDE7DQoNClRoaXMgaXMgYSBzbGlnaHRseSBzaWxseSBwYXR0ZXJuOg0KYXJncy5yOSA9
IDA7DQppZiAoYWRkb25fZmVhdHVyZXMwICE9IDApDQoJYXJncy5yOSA9IGFkZG9uX2ZlYXR1cmVz
MDsNCg0KLi4uY291bGQganVzdCBiZToNCmFyZ3MucjkgPSBhZGRvbl9mZWF0dXJlczA7DQoNCkl0
IGNvdWxkIGFjdHVhbGx5IHNldCBhcmdzLnZlcnNpb24gYSBzaW1pbGFyIGJyYW5jaGxlc3Mgd2F5
Lg0KDQpCdXQgSSB0aGluayB0aGUgdmVyc2lvbiBpbiB0aGlzIHBhdGNoIGlzIHN1cGVyIG9idmlv
dXMgYWJvdXQgd2hhdCBpcyBoYXBwZW5pbmcNCmFuZCBoYXMgYSBuaWNlIHBsYWNlIGZvciB0aGUg
Y29tbWVudC4gQW5kIHRoaXMgaXMgZXh0cmVtZWx5IGZhciBmcm9tIGENCnBlcmZvcm1hbmNlIGNy
aXRpY2FsIHBhdGguDQoNCg0KPiArCX0NCj4gKw0KPiAgCXJldHVybiBzZWFtY2FsbF9wcmVycihU
REhfU1lTX0NPTkZJRywgJmFyZ3MpOw0KPiAgfQ0KPiAgDQo+IA0KDQo=
