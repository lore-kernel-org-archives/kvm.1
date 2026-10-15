Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47D3AAF56;
	Thu, 15 Oct 2026 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089058; cv=fail; b=py/7934QXYcO6i+OWuGTaGViHq2VI++h/MnJUN1jpVW0W/VPWf2f4gqUwVo2N1q3IY/HsQOPCo4LahmaUZdpIVW9OE1zlpdsA8M0Tbvhc3P7Rtmv5Oos9rB/r9vO+II0N1SW7mV0eDDuAW6wMQjoNpLbm2dp+jIAkWBqrGnhBaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089058; c=relaxed/simple;
	bh=Zk2L352Lx+652pcB4XOTcpkmgsvFlkXIkLbLjayo8+U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fyHsW/RZmeLcPWhtLUckeLAWTkawz+CI3vBn6KQAv7HF9bv5DvWcD6p5FRlTIip8eDUn6m9zbnNRECO2CagdXEukeK6ptFL8YUUVghRcRjGTV3R1x93c0tGWvqNNh4cFQ2dZTL6OeTI3L+oTW8DX97cpB0hpk20HaU9fi/F37C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7t9LOJW; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7t9LOJW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792089056; x=1823625056;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Zk2L352Lx+652pcB4XOTcpkmgsvFlkXIkLbLjayo8+U=;
  b=S7t9LOJW2xxrYskMa3Y4nPzLhPJR/jAuoE8CrWLKS+r6nbvHhDZXC0AG
   uM7ERqc7Z66NkyLQSDYOXhxoNm51SZ9erWiw7WORIjcQSWWKBWwgWGe8M
   /gNlzZbgHuG2DrIn1MZaRBRyluDaw9eF3koZVWOHmxRgECvyIAWItE+b8
   xcgiP82TzEiLaFN45zaToLKaFTPDdVQyzC0AC/ThAOvDuFNVs0AV0VxkQ
   mqVpIB/Et9Vn9MNVQX1twh++I4L9ExkSVhgMP1YLc1y/2CiMMqLP5esE7
   G/37hzceykl68SzzI2cDYIBDPQ5lJFEBepx9vA8qAY4EE9VoFU2vxcz1K
   w==;
X-CSE-ConnectionGUID: n0gxQM3iTC6tLdBkWY3SeA==
X-CSE-MsgGUID: NkRG485FR3eX4taInKoV1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="859565"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="859565"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:30:55 -0700
X-CSE-ConnectionGUID: f7w3lkPmR5uENFlxRT112g==
X-CSE-MsgGUID: S48oG/CrTaa2GcNKfYuUkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1853540"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:30:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 11:30:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 11:30:53 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 11:30:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEmtiLq8PzpMfHZ8mg0T32BTghrWnBl7n6drde8uNM7hD9Vmd/PVE4heLP3c7uQznUjpXLimUtg3AGX0rV7p1QD7iLcmelknfvsdFNptbkc3gzKsks+w/yxQK2nACrkNa4tH/+EuPPsYBSm+H4JSGdXyUXqY/WjwFYO0gLkvOQo/bFUmX/hhOPfYfqLMb7RkCfgDbZf6L/OjinAQNtDT2cfGla62UzUP0h7zjRLqg1++pQCzfEBAveAVn4wgrgEX13hrbjb6nU2oMUh3mJp4ppGO1GfQZgmc68fTmQjBYBVPckLPS5vDu/o5KzTnw6fi+BgaCGFompFZc5zAeVgqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk2L352Lx+652pcB4XOTcpkmgsvFlkXIkLbLjayo8+U=;
 b=v2CftDnuxIy6q15QB3FuEAiV5DzyhtnDrmNDvsNQumtSC+SOioAJ2RrGf2ld3gWpVdab6zZH7s/+Px38y5gzdFc5QjTZEs32djbfYw++0hcfH94d0CuFheDuRPK/QGffk8Jz4zScONZlDrnhq4U1CnDkqtec6CjfeHuhxY4Y7FhuO60qPlXrVtz58bKLWg8/3myRRa4qBc5HMGa3SoPBl2/30a85/D4FqaFDQEfTZdwb0LNk7WNrIvYbl5iXYTx9adbtfBb4YlJ5hmk9Df83J4M7+Kxabp3A6uZhj+6YTCiDdfZBn2QWLdefosMlpTk67OKgIJjLEwmHz6lnTuOZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LVUPR11MB9785.namprd11.prod.outlook.com (2603:10b6:408:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 18:30:49 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 18:30:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Du, Fan" <fan.du@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "tabba@google.com" <tabba@google.com>,
	"david@kernel.org" <david@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Peng, Chao P" <chao.p.peng@intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
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
Thread-Index: AQHdTykMi6GQTjL+gUG+CUOLydf/JLbpcr8AgBBH4gCAANXIgIACUXEAgACUo4CAAMNTgIAANu8AgAAF7QCAAJGaAA==
Date: Thu, 15 Oct 2026 18:30:49 +0000
Message-ID: <ce6a1dde0089b0d357b11e58d2771596943c1239.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928090831.15502-1-yan.y.zhao@intel.com>
	 <9016c06a883bde489957ffdf7933cbbf6b8e6b03.camel@intel.com>
	 <asyo+Pr7aCje1AZ6@yzhao56-desk.sh.intel.com>
	 <94e930e88046fca1f53d2234d581aae593367d95.camel@intel.com>
	 <as9OHnM4mceEre/2@yzhao56-desk.sh.intel.com>
	 <a0936473c0ac5a2ca0cfb30bc61c9d5c374c712b.camel@intel.com>
	 <atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com>
	 <atCcvJoCwQyP1z9e@yzhao56-desk.sh.intel.com>
	 <atChtNfitK1PJCqJ@yzhao56-desk.sh.intel.com>
In-Reply-To: <atChtNfitK1PJCqJ@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LVUPR11MB9785:EE_
x-ms-office365-filtering-correlation-id: 3b80b9bc-6a38-4b31-0041-08df2aea6f87
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|10067099003|261009223027099003|921020|4143699003|11063799006|38070700021|18002099003|56012099006|22082099003|6133799003;
x-microsoft-antispam-message-info: ycBnxwqtePAmQav0w5RcQD5Ck+FpMFRFgcFtfnC72rEy2PrQafJZkloGKqZYaOprYRsMb1FPLuTAvGzfcg8b4ky9LPCj1qaBEpUsg6OG8iSrvPClgBplnV1JsIcRkXBcw6H0debfOqbWIjx6P8VsX+SjkBvBwl8eDSR+oDUc2eZTmRG71EwModS/Sm8ka6kUrGGAMrilzGeSBJVGaLRANr9mCe+FH7Uj+tqy3cgcDZX+85YAkLlok1rnmGyHYEUvjhGLReLGj5SPIk457K5MjOON0qdEBRoSmePqxoVbvDMLGpxICkCDjGxjBYtfj2ULzIMZLUBo8owPP5DlTxg3q/cFB1Pr0rT8+6gUTt6A/lpZ3z4KDAD0vrVFQe3XrYV7ToP1vdEcfwwq2+pbspsy2NGxlfd5+y+lisP7xCFzTaKVNQFndG/b2AjgqewEqI1mFIokgeNnQuOK3su7xLQmmYuZ7tUdXcc0YjrT7Mt5XMUPmaCAYFmGY3bE7hLs3/1eqwfI+JrHWeYwAv0jpnCM7uTbRadXgCgz622KA2SIIZqi3PKWAcZ4XnTvfXKIBhoLFmsaBMjuPyKXxWhH3tKMRhp73Vab76IxXOo6FA1GOPKOjXgLeNfoO8wVBc1Eknk0sdddmEGSk4Ll/GMCklkHIzhx66PH0xV0aKO8EZK4s4Ip8Oq8Uir1pxVO2LuasVsNlkSNhB5INX8jWmwisBuMcB2+jIR+zUNzYt8F4KJPgs5qYK7nXOw6FWQCa7tkndVw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(10067099003)(261009223027099003)(921020)(4143699003)(11063799006)(38070700021)(18002099003)(56012099006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUtkL1phWEJKcmNrbDhiTGdBRXMzWG9vdm52TEZQeitwZDNIUFRUR3JDdnJZ?=
 =?utf-8?B?MUFzbkREVEUyNm5iOFB1TExWVU00SjkrNnhPNUtnT1VFVjBvZm9JUXdIYXEv?=
 =?utf-8?B?RUZNbzYwdFpjOVZvTmtxMFhxVHJxamQ4VUV0S0luSldBYldrbGJzY0tjOUlo?=
 =?utf-8?B?bG1Rc0RTSWNQdFBXVEpWTnU1ZEdIL3p6eXRQVTJleWprUHI0OFFTRTd1MzBX?=
 =?utf-8?B?cVdwczlzblZEU2Y2UUEwREgxaVJxVi9zZE51bU0rSEJLNE1GRFFyTkhXNzIv?=
 =?utf-8?B?enRHaW0wSjVTc0dtZXNsY3N2Ymx3TGhlS0ZRcXZRdUtEM0JQSUtQS1ZmV05J?=
 =?utf-8?B?V1VicGN4ODRSNWxvTHVVa3V0dlZGbmdaVG1rN3A5ekJmVHBmQ1ZXVzhJTFJX?=
 =?utf-8?B?QjRBRDExWlV0REdHSEtSZFhQazVlR3hmSVgzSXRwV24yc0FlLzJpMkg2WUhT?=
 =?utf-8?B?Tmxza0l1NVIvUlp0Z0J1N1RxZVAwVFUxSWJFSlB1aC8yU0Z0ajZ0SkJyUktv?=
 =?utf-8?B?Z0FzMlhLSnV4ZW9za0lQQklxdWVreXZBc3BSTFZxNVZmZ29uRkErYVE0aUR1?=
 =?utf-8?B?TWtEZGptT1cxaWJEVjUySGswcHM3Tkkybkx6cjJxQlM1YTQ0QXU4MlJVV1BH?=
 =?utf-8?B?d0ptZ3ROTmxRRzdhSHAxSDFScFVsWkFZSlhsczQrcmFoaFk2NVhVTmtPM21C?=
 =?utf-8?B?aEhWbklEVEdJMEFQTkpZVDlrSnV4REN6clhGeXYrakx2ZWVSR1NHSSt4SVB1?=
 =?utf-8?B?ejFEcmxvRWxjUnUzNWJXSmk0V0xOQmRKbWN1K2d6Z3pMckJBbG94QmhFRHVR?=
 =?utf-8?B?NmQzTzM1aHBoYzZ4bC9NN3g2NXhOWWN0akppcitJcWRnQWQzZUJIVG9vbFJn?=
 =?utf-8?B?Y3lTNkdGNHluKzhBSHVwT2QwaXU3Z0hvYTYyMzBseGpVZFZpbzlDTlEvYjMx?=
 =?utf-8?B?aC9nRytRUDB1eW5VWUpINDg1QjhwWFJMS21sWFNDRmlicCtoRDgzR2s3MlFz?=
 =?utf-8?B?UWN6SEh3ejRFaVczNnhuaTd0RVAvTlBmWXcxZk1PK3VJMUx3d3NDMGRUK0cw?=
 =?utf-8?B?S2RSL3J4ZXBlbUsvT0RNamsycFF3YWpNUmRHZWd5ajltelYyTTVOR3pUMVZ5?=
 =?utf-8?B?S0REeEFjcFA1bUJMVkNmVjY1WGlzdEx3SzVUKzE2YTRqRUZCd01yMHRzcjJk?=
 =?utf-8?B?QWVUa1M0amxVZDJEdnNHVlBqQlZsZXJmVVFJcTZFTnMzWHF5MTlIdUxsaHBW?=
 =?utf-8?B?cmpjdGhPeTcydUdMcGd2VjhXVklYeVQvKzV3aHRSNmVqa2g3NU9kNFc5cFAz?=
 =?utf-8?B?SFFjK3NKT1NZTm5ZaUZlMzVQZkp4empNNTB3aEovcjc1QjVPU290ck5NakZR?=
 =?utf-8?B?VXljRGkzRTU5cXdqMHkzQ05tYUliSjRPdGdjdVd4L2lsNmlIRHZIcVZVb3Rl?=
 =?utf-8?B?K1J4Q3pHOE1ZMUVjS1JKc25FZDhmeFk2eTZjOEJma3lZdDJDYW1LeGswRWwr?=
 =?utf-8?B?bzYzZFErZldzYXN3dkNTZnBNZWRYWHRONnNvK05COURkT2FKc0U4YThCRWNJ?=
 =?utf-8?B?STVFek41bG5VTTJUVW5WUlB2NmVZcGFtQTdqZnZ4U0tZZ1UvOVduaExWNDN6?=
 =?utf-8?B?U0xlMWNDRlFZd2J0dThIb2phOGpJbjVFNXhEWXhOODVlWFZhUmRYckdhd29Z?=
 =?utf-8?B?c1hUeXp1WjZCaTBZU3loeWtTYlJlVGs2clN6WEQyaXJrdk4wdno1KzlLd0Vh?=
 =?utf-8?B?TGF6bGhEVk93Q3RlNFFhSHFISU0wVmZ4eGtjQnRua3o0dk9YcUFUTERYYnRX?=
 =?utf-8?B?TW1Xd1RoQmFYc2tkMy8rUWI0by9hV2hxRkNpVXhzSTd1M3lqL1hqV09vKzlx?=
 =?utf-8?B?b1kvcnBLRHNoN1lXd0xMaFRSZVlDS0V5UFlJSVg1VVlKM1JGUnl2R2szQWZF?=
 =?utf-8?B?RVJZdjcwOEYzZUtYVHJVeGh3eEpmVXEvLzgwN3cwbGd4VktHb2RXdVEzemtt?=
 =?utf-8?B?NTRGN3pSYXdEQmVNL1dLS0krNFdnWWNMb1BIamdSNC9VVzR5Z2p5OUhLU3Ji?=
 =?utf-8?B?YUVETExoaTd3WlBkTnJibEMwV0RpZWh6S2xlZC9VeC9EVGJUTURsdXNjNWpk?=
 =?utf-8?B?UWZyRHpaWGVXOHNUOXdXTVlTSnA0UWhpeTFjS0J0eUY2dGpkSU9CTmMrL2k5?=
 =?utf-8?B?Rnd3TkVhazBERWNZTUh0am1QSnVpdlE3Q1ZDdngxRXBKYWlpbWdUeGtEUzcv?=
 =?utf-8?B?UUJLbFRnVWFFdFNUZDNmSjJrZ1ZyKzBLNTNha002QzZtQnNWVm1nOTJsb0g1?=
 =?utf-8?B?M0RTcXlEWTdNUWdTY2hSMkNyM2VZdTJOOXVYUkR2RDI0c2tLckFrYjlmMzNX?=
 =?utf-8?Q?X2lYgfVFOo40QsA8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29F4037CC448124395F390D914DD6DFE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pP3606R/r5QQXcBCilHU5H09geUZkDxbz+gPAHEQfC4Yy94BLxRiniR5wkqlTr4/lheH49WmOjpjzsq8OZv6/3THG1LjO5HY0rLRpdDWKXiklBxg87FO+HC7GGWA80ZYqjqEGU3mCyx9gVd6rjR2UZKJa+aLDJ/efMJrl0ZFHcVu77K49leImivMTwsJyzjUTmN39f4/BEyN0VV4SBuoLE7Xjl6VAGj61iufk4E3MkCudIUu6GBVJm+45Lr6lJ7PTH/Jb8VVFXgvp5NtnY7+Pm/wQdkHKN2i3uGyxXhCdcDBf5wTiNBDtOnVwpIk3zjEauS5bMVWpvPJ/UqhYCBsnw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b80b9bc-6a38-4b31-0041-08df2aea6f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 18:30:49.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FoH47x8oeDdX8zvXyKHbiO+ydxrEdyMC6KwSf6vPQcZRn65AnzCPLZv8IsB0jWME5lyb/X9eD2cMZjJSDVRn0UTsi47zZUCYNnfREq9/wE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9785
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDE3OjQ5ICswODAwLCBZYW4gWmhhbyB3cm90ZToKPiA+IHU2
NCB0ZGhfbWVtX3BhZ2VfZGVtb3RlXzJtYihzdHJ1Y3QgdGR4X3RkICp0ZCwgdTY0IGdwYSwga3Zt
X3Bmbl90IHBmbiwKPiA+IHN0cnVjdCBwYWdlICpuZXdfc2VwdF9wdCwKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB0ZHhf
cGFtdF9jYWNoZSAqcGFtdF9jYWNoZSwgdTY0Cj4gPiAqZXh0X2VycjEsIHU2NCAqZXh0X2VycjIp
Cj4gPiB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9
IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5yY3ggPSBncGEgfCBwZ19s
ZXZlbF90b190ZHhfc2VwdF9sZXZlbChQR19MRVZFTF8yTSksCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAucmR4ID0gdGR4X3Rkcl9wYSh0ZCksCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAucjggPSBwYWdlX3RvX3BoeXMobmV3X3NlcHRfcHQpLAo+ID4g
wqDCoMKgwqDCoMKgwqDCoCB9Owo+ID4gwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGFnZSAqZHBh
bXRfcGFnZXNbVERYX0RQQU1UX0VOVFJZX1BBR0VfQ05UXTsKPiA+IMKgwqDCoMKgwqDCoMKgwqAg
YXRvbWljX3QgKmRwYW10X3JlZmNvdW50Owo+ID4gwqDCoMKgwqDCoMKgwqDCoCB1NjQgcmV0Owo+
ID4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgICpleHRfZXJyMSA9IDA7Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgICpleHRfZXJyMiA9IDA7Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKFdBUk5fT05f
T05DRSghdGR4X3N1cHBvcnRzX2R5bmFtaWNfcGFtdCgmdGR4X3N5c2luZm8pKSkKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBURFhfU1dfRVJST1I7CgpXaHkgZGlk
IGl0IGNoYW5nZSBiYWNrPyBCYXNlZCBvbiB0aGUgIm1pcnJvciB0aGUgb3RoZXIgY29kZSBmb3Ig
ZXJyb3IgaGFuZGxpbmcKbGV2ZWwiLCBJIGd1ZXNzIHRoZXJlIGNvdWxkIGJlIGFuIGFyZ3VtZW50
IGZvciBjb25kaXRpb25hbC4KCkhtbSwgdGhlIG90aGVyIGNoZWNrcyBhcmUgYWJvdXQgbWFraW5n
IHRoZSBjb2RlIHdvcmsgdHJhbnNwYXJlbnRseSB3b3JrIHdoZXRoZXIKUEFNVCBpcyBlbmFibGVk
IG9yIG5vdC4gQnV0IHRoaXMgb25lIGlzIGFib3V0IGhhbmRsaW5nIGNvZGUgY2FsbGluZyB0aGUg
ZnVuY3Rpb24KaW5jb3JyZWN0bHkgKHNpbmNlIHdlIGRvbid0IHN1cHBvcnQgaHVnZSBwYWdlcyB3
aXRob3V0IGRwYW10KS4gU28gSSB0aGluayBJJ2QKc3RpbGwgcmVjb21tZW5kIHdoYXQgSSBzdWdn
ZXN0ZWQgbGFzdCB0aW1lIG9mIG5vIGNvbmRpdGlvbmFsIHJldHVybi4gV2l0aCBhCmNvbW1lbnQg
bGlrZSB5b3UgaGFkLiBJIGFsc28gZG9uJ3Qgc2VlIGFueXRoaW5nIGJsb3dpbmcgdXAgdG9vIGJh
ZGx5IGlmIHRoZQp3YXJuaW5nIGlzIHRyaWdnZXJlZC4KCgo+ID4gCj4gPiDCoMKgwqDCoMKgwqDC
oMKgIGRwYW10X3JlZmNvdW50ID0gdGR4X2ZpbmRfZHBhbXRfcmVmY291bnQocGZuKTsKPiBDYW4g
bW92ZSB0aGlzIGxpbmUgYWZ0ZXIgYWxsb2NfcGFtdF9hcnJheSgpIHRvIG1pcnJvciB0aGUgc2Vx
dWVuY2UgaW4KPiB0ZHhfcGFtdF9nZXQoKS4KClRoZSBsZXNzIHRoYXQgc3RhbmRzIG91dCBhcyBo
YXZpbmcgdG8gdGhpbmsgYWJvdXQsIHRoZSBiZXR0ZXIuCgo+IAo+ID4gwqDCoMKgwqDCoMKgwqDC
oCByZXQgPSBhbGxvY19wYW10X2FycmF5KGRwYW10X3BhZ2VzLCBwYW10X2NhY2hlKTsKPiA+IMKg
wqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiBURFhfU1dfRVJST1I7Cj4gCQnCoCByZXR1cm4gcmV0Owo+ID4gCj4gPiDCoMKg
wqDCoMKgwqDCoMKgIGFyZ3MucjEyID0gcGFnZV90b19waHlzKGRwYW10X3BhZ2VzWzBdKSwKPiA+
IMKgwqDCoMKgwqDCoMKgwqAgYXJncy5yMTMgPSBwYWdlX3RvX3BoeXMoZHBhbXRfcGFnZXNbMV0p
LAo+ID4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgIC8qCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgKiBU
aGUgZHBhbXRfbG9jayBpcyB1c2VkIHRvIGF2b2lkIGNvbnRlbnRpb24gYmV0d2VlbiB0aGUKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRESF9NRU1fUEFHRV9ERU1PVEUgYW5kIFRESF9QSFlNRU1f
UEFNVF97QUREL1JFTU9WRX0gU0VBTUNBTExzLgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgICovCj4g
PiDCoMKgwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmZHBhbXRfbG9jayk7Cj4gPiAKPiA+IMKgwqDC
oMKgwqDCoMKgwqAgV0FSTl9PTl9PTkNFKGF0b21pY19yZWFkKGRwYW10X3JlZmNvdW50KSk7Cj4g
PiAKPiA+IMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gc2VhbWNhbGxfc2F2ZWRfcmV0KFRESF9NRU1f
UEFHRV9ERU1PVEUsICZhcmdzKTsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqZXh0X2VycjEg
PSBhcmdzLnJjeDsKPiA+IMKgwqDCoMKgwqDCoMKgwqAgKmV4dF9lcnIyID0gYXJncy5yZHg7Cj4g
PiAKPiA+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKFdBUk5fT05fT05DRShyZXQgIT0gVERYX1NVQ0NF
U1MpKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXRfZnJlZTsK
PiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoCBhdG9taWNfc2V0KGRwYW10X3JlZmNvdW50LCBQVFJT
X1BFUl9QTUQpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmZHBhbXRfbG9jayk7
Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFREWF9TVUNDRVNTOwo+ID4gCj4gPiBv
dXRfZnJlZToKPiA+IMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJmRwYW10X2xvY2spOwo+
ID4gwqDCoMKgwqDCoMKgwqDCoCByZWluc2VydF9wYW10X2FycmF5KHBhbXRfY2FjaGUsIGRwYW10
X3BhZ2VzKTsKCklzICJyZWluc2VydCIgdGhlIHJpZ2h0IG5hbWUgaGVyZT8gSXQgaXMganVzdCBh
ZGRpbmcgdGhlbSB0byB0aGUgY2FjaGUgYW5kCnJlc2V0dGluZyB0aGVtLiBTbyB3aHkgbm90IGp1
c3QgYWRqdXN0IGZyZWVfcGFtdF9hcnJheSgpIHRvIHRha2UgYSBjYWNoZSBhcmcKaW5zdGVhZCBv
ZiBhZGRpbmcgYW5vdGhlciBmdW5jdGlvbj8gSW4gdGR4X3BhbXRfcHV0KCkgcGFzcyBOVUxMIHNv
IHRoZSBwYWdlcyBnbwpiYWNrIHRvIHRoZSBwYWdlIGFsbG9jYXRvci4gTWlnaHQgbmVlZCBhIHBy
ZXAgcGF0Y2guIFdvdWxkIGhhdmUgdG8gdGVzdC4KClRoaXMgcGF0Y2ggd2lsbCBlbmQgdXAgZ2V0
dGluZyBzdHJpcHBlZCBkb3duIHRoZSBtaW5pbXVtIHdlIG5lZWQgZm9yIHRoaXMKc2VyaWVzLiBB
bnkgbmV3IGZ1bmN0aW9ucyBvciBleHRyYSBjb2RlIHdpbGwgZ2V0IHNjcnV0aW55LgoKPiA+IAo+
ID4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+ID4gfQo+ID4gRVhQT1JUX1NZTUJPTF9G
T1JfS1ZNKHRkaF9tZW1fcGFnZV9kZW1vdGVfMm1iKTsKCk90aGVyd2lzZSBsb29rcyBiZXR0ZXIg
dG8gbWUuCg==
