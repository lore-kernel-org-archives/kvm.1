Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA8496D59;
	Wed, 23 Sep 2026 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178617; cv=fail; b=qNx8i79cdouaelNszCSrveCSbTV9qf4WdJFDF5Op7MDy0Qf/aVOeMwKD/MjsTFhMJbmTxOFdNKRMw9r/Hr0dYCmT6iQ6G3hdGl4akaK/Y+cnez37yt2AJe7OO6AbJlemBcsnV62rm3faw/KVbZVfMp12U/womH7Fw2J+eXbkJbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178617; c=relaxed/simple;
	bh=mHf9X/MQf08h8wH69rOJ8utsMf7CF3ycoukW0f5HQ2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A9j6VbH8ZsfrPePTwyNxjQtdfBjscYWc4EL567uQ1HyocwuyNn6wBgMy+KKGEXiEigrsc1sACOIJYNhkel0bm3wIFgzpaiqc5//IPFKJ8bbY/Xc9vsypYO4HNwcZUTBQ7fnDdctFMne/Ix7GD1cU1FUbf1GkP1SmzCyMsyaJoaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxW33fXM; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxW33fXM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790178615; x=1821714615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mHf9X/MQf08h8wH69rOJ8utsMf7CF3ycoukW0f5HQ2s=;
  b=lxW33fXMQ/RRc6xDOCwMTQRUiqs3gN7ze2VVwGFu9Au+ZIYvmGGWFQ2y
   JMiftNdeWutcWvnhU5O4zX/rOoV2zk9IbXRk4vSW9/9aNt1CmU8mVzxqm
   bLx7YiFhrUUlX0+TU8cR4bgf6xFy7DIFjWQFY0UB2ZJQihf8yM2vgihOe
   DygCnMrh78RS1yGzM9wDXNr6lgazAsAIJQfKa1UkVcWZVUJOFggw7EBRf
   U+rTeCDX6bthvyoN4ptBYxmq1Q7256ts3zfCxWLYioB5+S6Mg/7RWc3vu
   clLjse8XjwkjbchwAoiCwFNqfKWHGEEbZLrdEcz7Ys3b7HV9d1NrjCu9K
   Q==;
X-CSE-ConnectionGUID: fhW5HFT4RM6JV9P0IXPtJg==
X-CSE-MsgGUID: 71JXe0peSkOMIiSJYxpBEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93389474"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="93389474"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 08:50:14 -0700
X-CSE-ConnectionGUID: 3g71GFvnSWqqFHioQoOnbQ==
X-CSE-MsgGUID: LE7usQnfSrO3WQIujbHZOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="301601319"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 08:50:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 08:50:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 08:50:13 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 08:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQuA4+ukL7IJ2xDVKdgXQGnwizJnCOniWhrXy0yDIc7imLfDzOJ6H73izmcd3z+n7OVw5AZRDlEN/coMZbpLQlee7yJnw55441/zLECR3LS/UAro62IFi3F38YyiLSu+e5O2VPpV+piQFIUofv0JgugXTXcfk8refsb+bISvIDM1OR4p4YYPyHJ2J78sm9uvJPJU3Kd42bzHpUqLSAbY4gBOw3ocOSQHPXEMRCBWC9pP/uxSBEsA0vFV1l8B+PWE7e+8s3tq1/xN8Qx6tYR7JTj2X9SSGRyeqrntNLqGoObv6RgTFDgNGI8TG1EStaYXacRr8HR9M5soWOPimaJeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHf9X/MQf08h8wH69rOJ8utsMf7CF3ycoukW0f5HQ2s=;
 b=nu0ucyK/0EsfaJVUvJYCi/KdYpKr8fH3qPXaVQuvU3jcbFZbBSpjf0ACuSHAQqUksVJaX2AuZ1kQwNFZjCFOffm33Nqarl/GLLPDZOuUKC2J2KC9cUDzbELKuJiiicZw33uJJ0Maj73sRxhZp3d5XwGBSn1rmvY6++qFtk2spIC2TRhL0GSTkSGGx20IcAxCwlbs+/m3x8hwXeNDkfGIKgqQ8A2QnOmbUuxOZSxuQvQT91Hl1CRxV52RblxKkv51EspWVnbC/2YgEnlg71N/ljxYnnJAhjW/yFyN2vFLi1kJzFj3COsG8h+wx7/8ZeyRH+G2w56/x/SLpONVK2EVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH3PPFEEDD586DA.namprd11.prod.outlook.com (2603:10b6:518:1::d5e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 15:50:11 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:50:11 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "Wu, Binbin" <binbin.wu@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Drop tdx_clflush_*()
Thread-Topic: [PATCH 1/2] x86/virt/tdx: Drop tdx_clflush_*()
Thread-Index: AQHdStRVsWarOe4Dj0yp8Uw84+65B7bbyfaAgACGzYA=
Date: Wed, 23 Sep 2026 15:50:10 +0000
Message-ID: <9b5b78ff72d263e43e49b18b0035c0aea8846d51.camel@intel.com>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
	 <20260922205215.870563-2-rick.p.edgecombe@intel.com>
	 <arOEHVklXn3VGBQt@tlindgre-MOBL1>
In-Reply-To: <arOEHVklXn3VGBQt@tlindgre-MOBL1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH3PPFEEDD586DA:EE_
x-ms-office365-filtering-correlation-id: 7a0727c6-3273-4ab7-7221-08df198a59a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: uC9mkK2iOwqKHM3k4ZYVnkUWKS+Rl1i9wWHL+cUxq+sjCDdq8kvjzqiwa9xxWtzuAiQrE4aaMYyHxX8MwEeOeG3VOCSCpoJfz6DL2qw/PTHbDpolMr4z84vUlxGMt09h+LLLwD+hhtt0vqY9DKjT0IF2IKv13CHO3u/5iBTFS+L1xEa8FhJVGdsnZ5RdBma+NCtsxaSIxrbmmLDdRsAXr58nyS+pc1V+UQasUUaKwXUuvrFxkFN3nRlz+GkckGZDEwhIXzyfWds2PeiqDMRye0zi+eGhf4OkID9PW+18ESzn/GQcWvImjCJttLBKiF7Zn1xpbDA/Y7goPw9f5R5S9WdtiKMlYTO4HsC40i9A1RNJuOL+1aWkckSRJxao/6MH0VQAhtowzNDvpAe5JMGJ2xJoWuOwp/qBoNr/Clc2y9m6PcebCHzG5KPq4OaFYSipErG1Ru741h1Cx3ylRvifFSioxiodfeW3BPxkaFOQDPtrtYkLoTI2SmHFP7W9NzXT/8Cj1X1uj/AjYPVSjQL3bKvgdHe+8DwMHtouTtHEQ+5F9vLtuIrZ8sR6ircbJz1nrVelG4UDU+detIANhM0ggNb0283r0LJ3rqmBR2oUx2PvIowSsgRiS88wLkc9TjSgcZvyHRu4JBISbHIF/jULlhjz5ysQsUutN9IMiedqxQrLk5NY9BZiZbCdaWB6+R/X6K2/c4craGs//Ax5ALoTXRDRJ/OhA4F3+AGKeKFXBmA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0RnRyttdlMvVnlkMk1iU3U1Mis3aDVRRUMvN3BlYWwwSXhMRHZLNXp5WXJ3?=
 =?utf-8?B?ZkViUkVhT0s3eW5BeVpvdlJWUW5uWHdHV0l5TEdDVWM4dHZrQWpZUHZSSWlD?=
 =?utf-8?B?cDdzZkZzdGM1S1hRU1k1Q291Sk56eE5Kbk81U3FLMGJKLzN5QU1vWUtwbWY3?=
 =?utf-8?B?eGFOTi9NeDVHeFdabHh0TEMxV042VG9rOG4ycGtWWE5QaGVCOUpoTkNZVU9s?=
 =?utf-8?B?Y3I4RkZmdGt2bXlrK1hONVl3QXpkLzd0ckdhVWp1SGkwMGMwUDEwSmVlN0Y5?=
 =?utf-8?B?QnRWOE43UW85RnBRako1R0pzUXlIOEZNcWFmc0hjYXFVMlRoWVJCc1JhUksv?=
 =?utf-8?B?TlpOVHJRSUNrazFnb1hKbGo0amRYR3ZpQXpOZFdUUXJMMzhyaVNibjIrM1d6?=
 =?utf-8?B?ZEFSeVd0bnlFeU1ucWFGS1BBZUtycEt6TUNEeTNSbGJWVkd0YXgyZ0hxMW14?=
 =?utf-8?B?QlEvUnN6WHJuQU12UnpyVGNIbFZtNWs1K2txTUcvR3pBK1FIRzZEMjN5aWNM?=
 =?utf-8?B?SVRNRHpMbDVUUDBGc3JhdlMwL0pjYk1UUkd6STdQNkNxaTlKa0UxTkVydXhP?=
 =?utf-8?B?R3NMa21EbFQwdnRiaDFMbWNiY1Z2ZXBCQVdHN0czVmVpM0FIVi9ReTBtd0Yx?=
 =?utf-8?B?YnkvNWJja0VqWHcrZExIa3JUMldLYjdoNGRoRmtUQ09scmVjTGhqQ3p5Ti9T?=
 =?utf-8?B?SlRQWElwVlMzdzNWYjQzaW53L2paMW5VTDVKYkUyOG50K1laeENERW5EOFR2?=
 =?utf-8?B?TEh0N1NVWkVoYkF4clBobUxSSFd2VHYxNmhTaEg0OW1JT0RhMlQ2OHc3a3M2?=
 =?utf-8?B?YVdhVFE4ODgwNU9ZRkFQRmZQQ21wd3pYWTdrdjJWd2hSdVp6N1ZxU1ZDbWxF?=
 =?utf-8?B?UU5DR3o5K28xZDdsUFo0dVRTQTVoRUxHckw3bXBobFN0ZWN1RW56b0FwckNk?=
 =?utf-8?B?QVJqM0NnOWl4VFdMMUZKRlhXbTY1WE5UUU1OR2lsT1lNRHcvU1RVQkl4cVor?=
 =?utf-8?B?V3JzTnRNVmU1U2FKV3RZWms5bnJwWjZaZGIzMjA0bFV5ZDA5QngwZERyTmh4?=
 =?utf-8?B?RHpEblZCR2FVS2J2L3ZTSGlUZmFXSkFZRnBhaUUzQWVWazJTTHFpNkMxNnhy?=
 =?utf-8?B?dHdMcnVPc3djMFRTWlgzVUlSaWcyb1NLMzI1MkwvakF0cGJOSGI5eC9NdnhO?=
 =?utf-8?B?bzBrQ0UzSnRoQUMweTRjMHg0ZkVENlZvYm1qYzZOY3VLQ1IydFJXZWYybUFy?=
 =?utf-8?B?aFlXWVZOYW85SVRRL3JCN3E5REtPNmFoSkEwaDR2VVRkSjkycFpuSXZ3eGhJ?=
 =?utf-8?B?cmpwcDBFaFUxQUo4NUZKY0JHaDN3RUJ4ekt0OE5Wb1gyazdjWDN3eHV3OGJO?=
 =?utf-8?B?SFdDZTVKUzBkVDBBTVR1S3RhRW84UHp2Y0ExTy9FMnFDV0hkeGdXNVRuZDIw?=
 =?utf-8?B?UDRJTC9UcG82QnQ5SWVOVU5nUnZQL2RCdm80d0szdk1mTGwwWHZLK0hLUU1L?=
 =?utf-8?B?RElJTi8rcmhwZmp1cWVid0RlWGhZSS9wQnVyMG5vb3Y1VS9qK0NDTkROZVhr?=
 =?utf-8?B?Uy9uYVhtNlo5am12K3VkQVdJemVoU2I1Tk5VR3o3bjhCYVgvS05reC96Tk1Q?=
 =?utf-8?B?Ujl4V1BJWUJkdzVFK3NCczVpRENSTlFSVW8vMHlrTktkV1Vmbkl3aURVZ0ZE?=
 =?utf-8?B?UGJULzhYak0xayswek5ibDhPS2psbjFtUnUyOU41RVg4RFR0ZGFGN2lqQjN1?=
 =?utf-8?B?MURZMU1uVDB5dmE5ZkQ2RTZ1OFlzMW9laFZYUFhMbG55YUcyZEw3QmQwak9R?=
 =?utf-8?B?V3NlNk5LM1RPMG5QcDhkU1ZsdGpTQndyNDI4N1hzTmZKSUFYNWhORmFyS1Zm?=
 =?utf-8?B?dzBNNHBPQS9qaHRCUTk3Yy9CbVc3eUw3S1BHSkxocE4vK2s1SUE1ZlZxMUR1?=
 =?utf-8?B?Mi9yS2VuSS9UNy8yR2N2OE9tZytjWWFDOWdZT0VwM2hwVVRJeFVEVG1aSExi?=
 =?utf-8?B?WUxoeEI0KzNtV082STRnQVdlWWtaeDdCMDU4aW5JYTlGaWcwbWpzV1laNm4z?=
 =?utf-8?B?S2VUYlhNbSt0bGd4MlJqbStLeXN3MnhwRjNYKzJFVHRtRlBqbGhzSDllY1dq?=
 =?utf-8?B?eVo4eXgyZFlBcTNTZDVpSVh6cnhLelErT3BYbHJOZnBRNUh4WWs0M3FJSll2?=
 =?utf-8?B?eUpWaThmd0d4VlhCWnlFTm1BMWI0VEthemtnNi9LaGo5dmtUbWxvL1V5Uis2?=
 =?utf-8?B?ZTdES3BhaGhUZGFYUUV5SDZHSkE5NGw3a0M0T2lkNVBoRFdVeUViOHZWbzJt?=
 =?utf-8?B?a0Q3aHc3MVdiMnl1eWp0ckdvWndramNSbzdoaUxUZlVRMHNzMEZxMzBMbThY?=
 =?utf-8?Q?HDMYFu52JhvTohEA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D21C1E84B190634B9CB5C3C160BDDE45@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fPN3LlLD+UkSw7Hly8EgRJUV92m6fVXDlK/rQzs2len+F/j95VeBNmW9rNlU7rDyvA7NVGy8Nd9wsxryIQloX1alq/eUGB1mBtYxxzg5b1JZ6NClNtvCCOzw5CIB76kktWIND2p4Az0VJFThg+w+1XTajkgJQ0Xfw3q3Ytggp+0BTBFo2Nx/+2+K8GfcEYPHEucw+WluI7qv1zRhvLf7IB+rQ/SsKh1sszlHihZy5Pe8vNo6BlrmDRgSKoqYZYr3o1JXtzBVyxPt4Gy7O95dGlBR/m1cC5CyYfIEiS1lBUlf0IOnQUIMbiW06WGLqaNj0Pf65B/dRIeLKfWUrlT8ew==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0727c6-3273-4ab7-7221-08df198a59a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 15:50:10.9405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4B4CVRVZEWzqIgfdXL0OyG8TsuDanZyLpbkDKlW/rAREfePtE+kkRFUc0bsv+wyIhb10NH8IUbKdr4qRLtouJWSWMI6cCkfpqlVsGbU0dA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFEEDD586DA
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDEwOjQ3ICswMzAwLCBUb255IExpbmRncmVuIHdyb3RlOg0K
PiBPbiBUdWUsIFNlcCAyMiwgMjAyNiBhdCAwMTo1MjoxNFBNIC0wNzAwLCBSaWNrIEVkZ2Vjb21i
ZSB3cm90ZToNCj4gPiBJbiBwcmFjdGljZSB0aGlzIGJpdCBoYXMgbmV2ZXIgYmVlbiBzZXQgYnkg
YW55IFREWCBtb2R1bGUsIHNvIGZsdXNoaW5nDQo+ID4gaXMgdW5uZWVkZWQuIEdvaW5nIGZvcndh
cmQgdGhlIFREWCBkb2NzIHdpbGwgYmUgdXBkYXRlZCB0byBjbGFyaWZ5IHRoYXQNCj4gPiBDTEZM
VVNIX0JFRk9SRV9BTExPQyB3aWxsIG5ldmVyIGJlIHNldCBpbiBhbnkgZnV0dXJlIFREWCBtb2R1
bGUgZWl0aGVyLg0KPiANCj4gU2hvdWxkIHRoZXJlIGJlIGEgc2VwYXJhdGUgcGF0Y2ggZmlyc3Qg
YmVmb3JlIHRoZXNlIHR3byBwYXRjaGVzIHRvIGJhaWwNCj4gb3V0IGlmIHRoZSBURFggbW9kdWxl
IFREWF9GRUFUVVJFUzAgQ0xGTFVTSF9CRUZPUkVfQUxMT0MgYml0IGlzIGV2ZXIgc2V0Pw0KPiAN
Cj4gVGhlbiBkcm9wcGluZyB0aGUgcmVsYXRlZCBjb2RlIHdvdWxkIGJlIHNhZmUgdG8gZG8gd2l0
aG91dCBoYXZpbmcgdG8NCj4gcG9uZGVyIGlmIGl0J3Mgc2FmZSB0byBkby4NCg0KRWgsIEkgZG9u
J3QgdGhpbmsgd2UgbmVlZCBpdC4gSWYgZG9jcyBhcmUgdXBkYXRlZCB0byBzYXkgVERYIHdpbGwg
bmV2ZXIgc2V0IGl0LA0KdGhlbiB3ZSB3b3VsZCByZWFsbHkgYmUgc2FuaXR5IGNoZWNraW5nIHRo
ZSBURFggbW9kdWxlIHNwZWNzLiBEb2Vzbid0IHNlZW0gd29ydGgNCnRoZSBjb2RlLg0K
