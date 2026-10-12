Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61B4AF9D1;
	Mon, 12 Oct 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823292; cv=fail; b=jw2ucOJM/9U+hV5DUteJcqBr950LstuodjIZjmcP+AdUMl8l2XfXxCBdWWomRMUzImD+ULKr4fGq5ZSUwBHbH3MZzfwiwKDFH935jLGA4q3SIn8RmojgceM9mgDVciG/52TX8phdp990euiVK5kMhVUt7Sqg80Q7dXWeQkjooZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823292; c=relaxed/simple;
	bh=2XAZyfdZ20KSX/+zl6vt216ilWYJhyR3JU1feSYkIlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UKeug8tseiOEFGlAY8oTvD6zITAt0lfP8M+yJvYZxVCUXKnAe3QTGzJmw4kIFNwjuZbSpc4DALW2xv7aa1F2tp8bMaWCw3S0qrG+rnSUaumXElRMJ+Az7wKUeVbPQGktZh9bmQLLwNv5VECBmqsqutj3IikTdmTDAG3qV3bc/OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1/Rdsvd; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1/Rdsvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791823290; x=1823359290;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2XAZyfdZ20KSX/+zl6vt216ilWYJhyR3JU1feSYkIlw=;
  b=S1/RdsvdhqMk9vIgmAWoICQlLA3G6qtRZURKN+7fHo0tBXIn45JRb6Aj
   W6vXxzwPckdLgJnEXC/pnyeKG5mAq8DS/sbwyMu3Cr1yYgXmBVSGyeCSs
   DYoZ8iYeMXyoId9nf9qwm0YMzHTC1b01g8xlwAFdXqlKGxYTEtnEQdV19
   M/faxgEK1STzn2kLWQKER9kwPLWBNacDbdXBMBVcDbcMhwSqq5dhrKuw9
   OzGox0vbZ/D9HgDoXgHa3Ghv2SRGtBK3K/P321mUKeRva4vuCpSi4IGTy
   xKCcVK9kdr72qMqydPP67f8BViVrmRRwAStHfuekbGE91RKwjCF6f8WwS
   A==;
X-CSE-ConnectionGUID: lqlRvKOaQ/mtTwwtnTHwJQ==
X-CSE-MsgGUID: KxfFTdIfQPOHJwMHNxqdIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="421793"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="421793"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:41:29 -0700
X-CSE-ConnectionGUID: r1elnkw2RRqq1B/AvLVMAQ==
X-CSE-MsgGUID: gUKZjl9cQd6DTb7VNmMgOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1033044"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:41:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:41:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 09:41:29 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:41:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGCKVBEKQUfcfqRVk4vFII/0rw8xUyvGIsPuOF9N2ZVS9jT2Tg+NkGEKbb6eZnyePg+0QgXPqyJ91WH9gIfH9yG77hsxzJay+F/+Y634bKMu4Uc0m4U3isU3XutZeWTiPwypDVyCjlr2BozJ7Gv1xGHG5X6RXsLR/E06rsMj35glLmyhGU7EfY3jO2bbuN7KDm2DOMsmcHMHfZx9nyWpB0qrBFSn4xs/Va+5ORZAG/XdNFPKxZMagaxuHx5E/SWDDd7YiexTdIk5dUniLYilAWZOvYGN7EsKVevcUTwhmDSsFzuRHJ2g6vwwfN1/fPebwbICJSdVV7uE25NslXp9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XAZyfdZ20KSX/+zl6vt216ilWYJhyR3JU1feSYkIlw=;
 b=cQNlrn1+IFdL5E/Ots3OfMp8P8VnWtK4IBulSqHzJBCPwI0LHvD4YB6IFIRjLGLKEkV0U6yXCMJuyYSRaYTy4I39L3lPnBEDBeS3NFQDcUm/XwQ3GUCmkYWaQnp/6zD/BtUtOT0fUtw8k28ov7u5aGankWOOUj1MwPtOSkuToUYqVdYrMkdm3e+RkcN0auJ+6eYngOWXhB10X9L8nFGlHK5Optsp93zniYM/yls0nH8krL/75cSmC1bjR26SPLWCzUyzifPfg5O1m/90yfReV38tv/JrxkKd8Xt0T5ypCB9xe85lJyiNkaBEXImR8EK5JGHjwy7VIgM+ZejEGjsVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA0PR11MB4528.namprd11.prod.outlook.com (2603:10b6:806:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 16:41:22 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 16:41:21 +0000
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
Subject: Re: [PATCH v4 06/17] KVM: x86/mmu: Allocate DPAMT pages for
 vCPU-induced page split
Thread-Topic: [PATCH v4 06/17] KVM: x86/mmu: Allocate DPAMT pages for
 vCPU-induced page split
Thread-Index: AQHdTylEUwxIhfdjnkuIpWUZwgMmJbbyR4EAgAQdwoCAA81ygA==
Date: Mon, 12 Oct 2026 16:41:21 +0000
Message-ID: <6615996fe0ad499c0a4c93ae668368a34d988b05.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091005.15567-1-yan.y.zhao@intel.com>
	 <76157e3dcff065d444d83a9c5e7a924967fecc87.camel@intel.com>
	 <asndHcWpIMAObuz4@yzhao56-desk.sh.intel.com>
In-Reply-To: <asndHcWpIMAObuz4@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA0PR11MB4528:EE_
x-ms-office365-filtering-correlation-id: 2ced53e9-06c9-420c-998c-08df287fa578
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|10067099003|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: SVPkHYjn03i+dUz1t+wr4Usui9vqnA69dSTWlWsPTZ4fwAahIyLUeI8KfK/RDk0UaRftdlIgV4jqBdwAD7JkDOccRsH/pKwyWreJmy5vJd5LOjgTZ3EtLnoMIs9lZu7Jv5wcoQMBGASsYjKNyKENOxaeZUyjzQ6oHCaZYd9UFNmEhsFBv1f/vobL09uiBSm3sLm7wB1+8kNGAHLiE9NwqswGwS2F/Rdjw7jLoPqifHo/2Ocwf7Ml1MVTdcBK3K/622cPgHWh/voFTwwdnTIwi7hDo7cJCh6/6cY/4aIPeXOuM1gWyYh4Iy5sHw5fEmK91Xs5ETooq5kZUdcnlJzuzGH+6EDLWT/r6bFyyjnvQC+Xom2NFjmAcrc747V6+S+v/7zdQ8GVOAhweITd3jTMiMis9TGJSUB+OwVK9BDQtastUnSiLNVjlgZwuKPWFsG4CjnNyg5k5+3GeTrvnc0J/a5GPezAyxIe9ZoHn8n8rYf2knNy+zoYjZacK81O4jcbbvUaD+xxsHHpzsJ5txBq41Aum6m2VRsbe6GeHIotGrVEbc6SXLwoTAepvYFd+9TBaJHM6NNAlT/e+KowkjVxm4AOn5SWeXnJa3DKG4dzr4q4Q0DQvKBkgp2c1ehbdn2P5IvsWLFxCXfIi37GF4spjOLq2seTMsKsBFvLZVkdg84=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVlNOEllZ2REYWFoTjNYQ2NiaGYzeGVRNlpQRCtYUW52YzJCTVBxSVhyc3F5?=
 =?utf-8?B?NC9IenR6L2x5YWhXT3JwOEx3bWVFQlRZK0xpUzhyVDBaRzhGY0tOWE1XU3R0?=
 =?utf-8?B?dkZzdFlaek1ZcFphdWdkc05Yb1drMzNHVDVyY1QzdTltRXljdmFwTGFGQmc5?=
 =?utf-8?B?cG1zZFI3cUpaV3VqTXY2K3o1ZmluYWJRbjhkWGNZQjdWaTRiaVAvT0RWNGdk?=
 =?utf-8?B?cmp6bE1uV0phK0F5b09SVFFzWkUrQ05GMHE3R1IxU2Q3Q3M1U091M1dmb3RK?=
 =?utf-8?B?SENNc042QjBOMEtJdWJnV0dMUThQdW9UL2JrbTNabCtvR1NHS1YrNXZoR1dH?=
 =?utf-8?B?aDFjNEo3YmlEc00yeG9PbU5SakN6aEd2aFpCdWtrR1FoZExEWjI0c1QwQnpx?=
 =?utf-8?B?VGJ6cjFZZktobmlKUEtBanM0aDFoUkFzN3VHVUlHa2FaSWpxTFF1WmFkQy9k?=
 =?utf-8?B?SGlvMktzU1BoQTBuYlRMT2svUVpQL3A2dzJqZDU3OGRJTGpJbnNCRjMxSFZ5?=
 =?utf-8?B?QkxsWENrcVdRanNDaUhHU0cyZXVCdlBZbDE3cUNIR1NLRGNISi9yMk1tOGt4?=
 =?utf-8?B?UTE4WktZLzJ2RFlOT1g3S1RPdUhtcHZVTGhVV295cENWMGZzeFlHUXVLQ3hv?=
 =?utf-8?B?VDNVNEtsWGFWVTM0M0Z3QzVDNm9yUWtzWVR5Z21RcmZnV0FxbExkRy9BZ3NP?=
 =?utf-8?B?MTlJWEQ4aUtBK1J2T3RwQnVKL2xzQUZxbW9TUFlGSitBWWw2Qm1OMDZFSHBz?=
 =?utf-8?B?ejZYWmViaEV0and1VHo5QnJRN1VRSTF0d2RBTENnYm5FSWxheG5BNlhtZUcw?=
 =?utf-8?B?OC9YWXRHTXBsSythUlRuSkFsQ2ZoazFKdWphZ2FiTkRhNDhLYndFQkRWcUxt?=
 =?utf-8?B?QXY3Unl6RTMwVTI4aUxzUVovYmZtODlyUmE4eTErYTZUR3RvV0FiMi9EcUJN?=
 =?utf-8?B?OGdzcjNkdEZEMllFSjhHR3BNc2NlN1NnSXdXMkZ2SmJoNXhwU0hSaTFxMjRT?=
 =?utf-8?B?dDY0V3dQSVhleWFncEl4WGp4MTFvUnlHaDBublNoTWM4NlhzdHltRGpGYkVm?=
 =?utf-8?B?SkxJa0h3aTFCRlBISEgyM2lJbDBESWNJZWhuL1JJU3FVeTNPOEg1TzUyTHJU?=
 =?utf-8?B?dnM3bHUxbWcxS0dNYk9qYWtTdy80aXhTeW5oaFJuU0x4Z2ZxZmZSNVJrMk5i?=
 =?utf-8?B?U1FmenNrc2kxNmhVclp5NTdwK2dRdlluYnA1UUJFbm96VGZ3WGV6STdMbUlF?=
 =?utf-8?B?dEZmTlZObzFNcmRscGhReUp1cXdLR3pXbGNra0V1Tk92V3NqNUROeW1WQXdN?=
 =?utf-8?B?UzVJdDBVVWp0NjIwSE1RczhWd0Y0bkJKbnlLUU1kbWdZdUY1eTFubFRITjdu?=
 =?utf-8?B?M3BEZVEwN2gwOFNlcU9xSTlqb0JCbnovK3JJTTNzakdmMmZBN1J5MXJkS0xN?=
 =?utf-8?B?N003bzVDRERFbDRBVnZpMVRlR2R2V0haa2hlSm9sQkUzQTNGTnBBZmpZZFd2?=
 =?utf-8?B?U05LWUY2eVkyZHEyd3ZmRVRWQ2F4MUx3QnRuSGtPWGFWaDBKakZ4b1RBLzZB?=
 =?utf-8?B?NGRuYmdEMGczdUhyZmErVFJURnNQRzlhUVVFbFM1cTlacldqZ3o1eWpHdFJP?=
 =?utf-8?B?cHU5REtRZ3pUMDIweUJINXBFaFU4QUdwQzFEODJyRTVkY0ExS0M1Yjl6UXFM?=
 =?utf-8?B?b1d0YXRyUVNteElFTjFueFhiUXRUUEtYUkJoWkNJb0RCN1ZIajdNQWRzclhx?=
 =?utf-8?B?MkM3S001aWI3KzU3eFlBMjdhTXZNQitZU0p0dzNZS3VFcC8raGttdGtuclky?=
 =?utf-8?B?WjFsZGxJejBacEsweENVbU1lbFhVQXlodzZBcXZZK2dvaDhpYXBEMndXYnkr?=
 =?utf-8?B?TmNObG1CbFhNTmxkL0RxTGhUN0F2Qm5FbEJXK09zSmxDd3FFRlJ0dUFVUUJ4?=
 =?utf-8?B?ei9kVE0raVNKVEFESGF0VVNKd0NHZTNrbXAva3FvVnBOS0Z3VSt0aUIxVmJv?=
 =?utf-8?B?dllRTmwxclB1T3dqZGZ1RUFya0pJQ2NQYlFvUStCOUlTa0htNWMvSER0Qjdy?=
 =?utf-8?B?ckkzQ3NzZVdOZlpJUlFkN3Bmcjc0Rit5MEQvc2N2dkNjZWpQeEh1K1VsZ0U0?=
 =?utf-8?B?RFFGdmF0a2tXSnlrRldxSjViZDNFRUdBRHFGLzlsS0FyemNnbFlNRXBxOGt1?=
 =?utf-8?B?VElzVzJyTUFRWW1pYVhuVTdSM3lmaDRlWURtdlNiWmJVNDRiU2czSFVJcWhK?=
 =?utf-8?B?SEVWK05YcjFmSG1yRXZGREhrcGxVSGJrWEp3dVB0Y2F1dHR5SWVsZ2dBM09i?=
 =?utf-8?B?aGFLaVFpdGFCdjdIQ2o4KzRHWG5qY3RENFBHSFp4Y2JoMHUwV05oMWhIMTU3?=
 =?utf-8?Q?e/BsxIIxekXyHfrw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0089AC3BF39422409D753B2AB7524908@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Lp/w2jTPfIFSOQK6q2E3nxDrTe53nWBj3H6Yj23xKell4Why2Td7tCYAgAK34Or/n2tx98BEovROhrE+QuJzu/0+wMH8ifue3Dq6hh68iF0ijpvjJZ1DqEZrzdZSD6mIJCTOTPhUUAH2slLlE/39hCF7WgCHkq0NbiUUpGpROyIieC2xttCS8rOJAgj2uBV4AuzJnig6uH0xtOC5Z3RQ8X10thzGIxtakTBcsPXOA7g+aU1bgmEzCeecpSYrTVffeoUBb63Yf2sQTOa1NaVR5BW2iJ9Y/WVScApBEqmmEcMfIKkAGoxPfoEdKW3JwXJjs1RN+EtFda4iLm41Nld5Nw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ced53e9-06c9-420c-998c-08df287fa578
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 16:41:21.1880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgbQUFfTVHEM0S6FF4eQcJEw4wE1E+T/gbniLcoW0tu/1LgjzN2ctEwRX6AmrUN/nZA8bMA9Q+IFejRYpGe5HnKoAj+aJupiD7KjhXexzdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4528
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDE0OjM3ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiBO
ZXc/IEl0IGlzIGVzc2VudGlhbGx5IHRoaXMgd2l0aCBhIG5ldyBsb2csIHJpZ2h0Pw0KPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8yMDI2MDEyOTAxMTUxNy4zNTQ1ODgzLTM5LXNlYW5q
Y0Bnb29nbGUuY29tLyN0DQo+IEhhLCAibmV3IHBhdGNoIiBpcyByZWxhdGl2ZSB0byB2My4NCj4g
SXQncyBpbmRlZWQgaW50cm9kdWNlZCBieSBTZWFuIGZyb20gdGhlIERQQU1UIGNvbWJpbmVkIHY1
Lg0KDQpEb2ghIHllcy4NCg==
