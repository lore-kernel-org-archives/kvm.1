Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803523C4F3;
	Thu,  1 Oct 2026 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814733; cv=fail; b=Ae55sJpiGDj7tKQKCBqQF50dlUwZ5RlRngfAdPN7f8JfZFaPI6pPR/pdOvQ+7kt9qHh2ORRwdeMwA7eg7G+9BkJ86l6Ewt0ZF3Ql2+iqZ2tlq5Kd6eBvlh3cftl+8arcXbucNbzBakqCQw2ljeDvV2tVj2WvsqYDha5oUPumhH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814733; c=relaxed/simple;
	bh=IiwHHLmaGM+XleyK98qQMnBqbD6iB4ZahDY8MSRk+ns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PGV/Z2GHi5V84AjtiGNz6VdKytuwxX6DWpOb4jUrpLL4RL8yiJEMnCq5aBMHX5G5OOrWsjWB3m/8jkqlmE5CJIP3olTFmxq8qN5agKHADqlkNfkqzTFe5S0WCi7GlQf9x8GSavomC7/FAOFk62IANDwvbv4YAbZjzqLR7otrn3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOptJdVC; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOptJdVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790814730; x=1822350730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IiwHHLmaGM+XleyK98qQMnBqbD6iB4ZahDY8MSRk+ns=;
  b=SOptJdVCyjWKkck1ms3/wEFCS5LlnfujSV4N8bhkqbNMMLRp9H/gblQ0
   Vxzs+jb9kxt1QAy0hAoj7doqCr7TxvLdzPuoTc4N++7Z4CmAx5FB17I1r
   HYW5oEm8ClWxlBN8w4ecqF+FACWwG3j2hlCIzzfsdnyUibFGFYMe+1gFE
   6Xht/gexPfvi969G/BiCUi54kEmuNKnCl8IuAJpSQSTHLc1ixhjLFEzCt
   o6l+NXhgZQVZjjOddYiE0tyChSx5Ad6gViZvzyHbLVEp6B1bQOTaljtIp
   rddy3Yb/WcN+jyLrEl+aC8Sq9h/I2Bgh58Kycw4j4kNkj1kOsxdONM9vC
   g==;
X-CSE-ConnectionGUID: wZmDJghIRlK6g1qdX1c/dg==
X-CSE-MsgGUID: RJkPj1CNQieO8T1u0+VGbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90778424"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90778424"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:32:07 -0700
X-CSE-ConnectionGUID: nrZEqLzyS/yZX0yONOA+cw==
X-CSE-MsgGUID: HEi82O4PT6qzGrj6X3+lXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="305351375"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:32:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 17:32:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 17:32:06 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 17:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOatnMFyO2MLDF7k1TK9FupxeLw2RFzw5QWlq7Tl+BBO7Hlmh6UxvERtJwRIyYWX1ecS1D+a+iSMl0A9jIsqTvyxWBi0yuuZyqv+TCdZYOV1O/UAFH0T0PGYRDDOQ6XG/AHx/waWsUIrS2jTa5n/mQE8GE1fvzcY7bhipKdIRUA9o5qZNlxTQxfAnGYwyQ6BuiTRN5S+YXs3A6ZJOB1zS7N3Oh2XM4GrWBudO71rY94DMJuf5X8GsF27QkRHq50+KzYH4pistBVHZaw/lSNy4KNT58zaXbsHrVbhjDqqyMDJ+Tif3/vQZsH9MhMrrZ8lJMN42dg/UslSbKU8aOdgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiwHHLmaGM+XleyK98qQMnBqbD6iB4ZahDY8MSRk+ns=;
 b=G/8dNo8TN8/BYx4egecY/qOTuEOBeIPpn9HxNen/l/DUPc61nEEgL6r7Dg2YV9GJLhLTkNN+OFir/esMVXGJ4lWhV661JLGQ90iRCnkweip9ALbNH+yQ83H8Nc1BVTl+YUn2yhKaWO1FDOCb9upYFQeW3bRdZZLInQQrtUwXay474Wxhp9n5ObsIhF56pQLJJ1fc2l/CnOCyCXtgM8UIV7sDRjxyhjfn7sbvekKURmHajcNic1Myz1mWWbSdEgqp3G57lG4ygGXrNwzymyNfJ1Sevx938ZCIwJJik0ftbVgLzRx2ynyCB6TtVUC4/0Saz8x8N5pc5LvOzAP5fDZUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 00:30:40 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 00:30:40 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 02/10] x86/virt/tdx: Convert the version metadata
 reader
Thread-Topic: [PATCH v3 02/10] x86/virt/tdx: Convert the version metadata
 reader
Thread-Index: AQHdUJ5NzYgwfL+kLEuoLMeKgwDC67bn1u6A
Date: Thu, 1 Oct 2026 00:30:40 +0000
Message-ID: <97dbadbdbe0b86a66a52581d546bf0ecb3b9884d.camel@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
	 <20260930053901.22528-3-chao.gao@intel.com>
In-Reply-To: <20260930053901.22528-3-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB6736:EE_
x-ms-office365-filtering-correlation-id: e6d59dcc-1615-4876-b81a-08df1f5338b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 6TLPPFkhs6uoF/Wf0a00xGsh0Tnc6ZcmsRcvreqBME08/0GhRQhWW3Nhono5stx/OZkaC44HEC5nEOVoEq34rHEYxcHQ2adtVhrJlIo3E8ddsdFj86FSXSO/sZVYDBgTNve8fUFORcI4TkoBZALQ6/jU9l0NwWTPxyO98TeOZNGgg5rmIOyvXFGwBBGK3MNO+i5dUzLkvsnWU6uuuGdVidA76VrYxhOdqY4cFwZ2TvcMHYisfuurmK0XaMTXlrDjg6YgbkE6J7JBdVuq4DU5O8uYS2K2sZf2XUReB4nCw4dOc9DLxdOPzrKka1xYpb7QSXLx0JnKGLKPjfeBCqUe5Z1SNQuNm6dqkClGxNW5lORqb8arWVqcrmTGAqy8E6Pj2D5r5ZIpOAsukor46yVE2h8xRpIa61uO0+dgdvvzrkhuvoZxXwnd8FziRG2Gowjtx+NOYz+JiUZJTfWW1rVwMl6PoZGEsM8Xc5rGA5EgLG9JXVk3mYrZCrRxmegVGm6lfkBMtU2VkHFEruDkdv3yHjRrRmGmyc/YOhqnWrbPtHh1vxTDSBHvEHOd0hZjY8rfbG4fCkTGIFpa6+ZDbzxG/s2oIoK5BtSTW1wueukQaWGBJ4UfhTSxEP9Hq/V/OaV9hZ6314+DHKgGnl/fnwuApSk8ET1F0ldaiDK6Qu6wrz+GOXMsKtsr8xuOOvYHmvPQDq/hxODi5MdkcNmGNawDqoa2ppRpxv+e/CmS8wUDwFI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWt6SGpiZUZVNTNiNDhUMDBqcnVxVm94aVJYc2JNYkk5bWo1MXBhOG4zYnpO?=
 =?utf-8?B?K2JxNmE5MlRWNVp1Rmxva3lvMml0MENOTHN5ZFZiL3phMVJUQ2FpYzEzRUI3?=
 =?utf-8?B?OHVmTzh3QjdrTzNhUnlxY3RvamZDd2p2aGgxMGJWV0VYY1ROU21STDgydWlp?=
 =?utf-8?B?aWNUQm5YL0xwc1BnU201dURVS2JjUVdSY3JpK2hWRHZWcGZ6ak5GQkZUSEIx?=
 =?utf-8?B?U1kyaHpvZWtBcTNBTnl1QkRTN3J4L2NFY2cwcllwbXRhRlQ1SG90OXFPdGFk?=
 =?utf-8?B?SWRpcUVYdFlFdy9JU09YUVhEN1pWOHhzZHRJTTJLL0NsOG45d3FIYldnclMv?=
 =?utf-8?B?VU9Pa3dKTW9hbmJHS3UxNEFEdDhOa0NBWlA1M0MwVm5aaHNHMVFHTFVMa2Ur?=
 =?utf-8?B?NC9DMzRqVHpKMG1FNHAremVzbGYyOFJXVHVQMG9hTy8yL3RwYTQzc24rdmtJ?=
 =?utf-8?B?YXdZdk16MmNONC9FbDA2bnYxNkVONWtMak42aVJvLzJCb1FtV0xSekluVVpu?=
 =?utf-8?B?aUt5RWNwSlVxQ21Nd1pGdExTWEJmZFpzQWJFKzZ6VHN0NzVIazhERXNZYUJD?=
 =?utf-8?B?VUtOME9uODFpclBweDNIcEx5azFPRStHREt4blNaVkNyRVVZYVgrUmJudW9P?=
 =?utf-8?B?TjBwUzVGbHZ0VkpJdjg0d1lkbzUwNHBVKzJidW41Slh0WUFVdjhPVnR3WU04?=
 =?utf-8?B?a0MyckNObExlY09tcGlTazBUYW5ZaXl6Ri9Rek1ocDlMTFpGaFQzTjNLVS9n?=
 =?utf-8?B?cUdPKzZRVVdVY3JQZS9INmtvT3EwMWczL1pMREtxNmRleWdzVUhFTGhBSlVC?=
 =?utf-8?B?UUtDbktGNUlMbVl0RWRyNXZHYkY3V1JsS2xZdU1UQU9wMWZrS25NVmkwc2Nk?=
 =?utf-8?B?ZVZxUmN2THBubVFSVmlpdFVGN0Y4Qm5JMFZRQUVwV1VwQ1VneGJWRUJTYUxj?=
 =?utf-8?B?WmYxUDgwbWFOT0Q1Vm54Z0l4ZmkrbGNSODJMbG1CdmpwZU8vbFRzcy9Ldk8y?=
 =?utf-8?B?OUxFSnZ5TW5MQjNjTXFCNUp5alhpcmFDekVuNVhyOS9pSmd5N0VxZ1RkSWc5?=
 =?utf-8?B?eVFaaTMxNUc1eTRId0VaUnZqVmU1a1plc0tJekt0b0RMdGU3aEtTMFZzN3Jx?=
 =?utf-8?B?TEVYbDJVdzAyWVVscklQeG1CWGF5OUdDZnlaN1BDQmQ5UHIvVFFVcFBXOFk5?=
 =?utf-8?B?SEswVHJtcG5Gb1JNYmw1OHdKb2xlT0JVdGp2TWt2eDc5S3B0OGE3VDh2RlBl?=
 =?utf-8?B?andoM3Q0OEx6ZzlWek5ESFQxeklhbWwyQmgyUDhMUWZndzgva0MrYkxOK1Y2?=
 =?utf-8?B?T2ppTDA2a1hhM3dJZ2dvWXVabzVKY3I2Tkh4NDNHUXZHbFdab3BCYTNCaXRO?=
 =?utf-8?B?ZmpDdlN5SngvRkU0RzhPYzZjV1Jpd0pTSGN2Z3htYVRhUjZ2d3pvQllYVVgw?=
 =?utf-8?B?MGJQc1lUU21SQnNpMXBhYjN5UGZydVdBT3kyQkg5RVJBeHZKVWxrTUdEaFRm?=
 =?utf-8?B?WGhadnVkaHJNSHpiT09COGs3ZHU2Y1QzWjBReUNRc3FLNi9VVFZheUo3SjBn?=
 =?utf-8?B?elc0SEthdG0wNHZndWtwMldjcGE2a0M5M05SWXZXWFNKSHczanc5d1Z6bWRJ?=
 =?utf-8?B?Q0xocDlHRS90WVJSUjV2d0pzK2hqRStjMW9ySWVmOHZSWjZKNmRXUmNxTkkr?=
 =?utf-8?B?dWpucVBsZkNHeFNoVnBSbVJmMmNYeDBqcC8rdmNoR2ZnSnZJaUlLSzJJVS9n?=
 =?utf-8?B?ckgxRVdBS2hpTStwMkJsRTJleDZ5RGp0ZEJneUtxWTFJUnZSakoxWTZPQXpq?=
 =?utf-8?B?aGVpQlpBcVJJeHpwdDQ3ZmtVWGVZOE9TbEROcXBmdnl2em1LQVdKSFg5ZnVZ?=
 =?utf-8?B?RW9QQ2VSd3ZsYjVmeWg2QUhBNFdoRGNTRyszaVJEdEc3YmFzSkZzd2VNdWly?=
 =?utf-8?B?VWhZS0hzbTBWNStZYzhwMGFFOUl6RGhtcEp3RmZiUDIxeDJGVlhKT0NSMEFS?=
 =?utf-8?B?QWR5VVdhaVBFSmVCd0xFaUVBaUhDUVNoZ3V3T1NKSXlmR3hiNHRuU0c3WS9j?=
 =?utf-8?B?cktyeWVNc1hKdmpQZytUbTFpTkJIWThIWWExUm1iL0pwYjFiV3VCb1d0cGZQ?=
 =?utf-8?B?Y056MXk0UjgxR0RvRC9JRXcyZGNhVSthRDh0RlVuVURnUkZuNDR4dU83aHUx?=
 =?utf-8?B?Zk52cU9QdlpzZmRvcmNGRThZWE1OQld0NGNGSFNsS0dsN295WHlXVmJMSlZW?=
 =?utf-8?B?RFlaQ0V1Y2VKSFNpKzdsa2FnSi9ncEpGNmxtMUsrRHh3OTJFRE05ZTBaaUp2?=
 =?utf-8?B?UzJRcWMvbHNTcDE2enN3YmgwM0tYUHJ1Tmg3eERvWG5jQm5EeHNVWWJnUm41?=
 =?utf-8?Q?KlKacLhQ14w2WTHs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7071228FEA9ECB4396EABD3C448D3C8A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Uw05DRNfKQoxXRmzgBH43VQx0J5FFujgmIi1yi0bpynSQk/ePcLif6qzm3dCPIRQs4iqZbRgKKrRQ23qTdM8jxuM8RKyTFvOc89OTzJt1PMK34RL9Ym/MOzXubZ17Nz29xEMEB5Bx/47FTFM8nq2PevZzgRnGcskB6ZbRU+1dt9kpMotr/H+JD2E/i4ABIKGDGKDVCPJpfL/Ve/BXjAEN4Zwm2M5S5nWMupDgTdXJgBPWT4ISDksRAKiFVdMsqmkuzIGOzU0Sko2BdXue9LvKK45Y8FlQ/sDzCUNqE06ElTZgf03klq6B5uf6vpeL2Ck9J5s6i8yIZM/2vW9m3CvgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d59dcc-1615-4876-b81a-08df1f5338b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 00:30:40.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5AmVlSjCEIabchYm0Inc+p5qUPODCre8AhDKP77JCh+Zkhcly+wxpj3AlbNagGyeN3DkEvkSoNNZ4VR265bpl6XLsqPbonWinoMWvhDI1ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDIyOjM4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gV2l0
aCB0aGUgaGVscGVyIHRvIHJlYWQgYSB0YWJsZSBvZiBtZXRhZGF0YSBmaWVsZHMgaW4gcGxhY2Us
IHRoZQ0KPiBleGlzdGluZyBtZXRhZGF0YSByZWFkZXJzIGNhbiBiZSBzdGFuZGFyZGl6ZWQgb24g
aXQuDQo+IA0KPiBDb252ZXJ0IHRoZSB2ZXJzaW9uIG1ldGFkYXRhIHJlYWRlcjogYWRkIGEgdGFi
bGUgdGhhdCBwYWlycyBlYWNoIGZpZWxkIElEDQo+IHdpdGggdGhlICdzdHJ1Y3QgdGR4X3N5c19p
bmZvX3ZlcnNpb24nIG1lbWJlciB0aGF0IGhvbGRzIGl0cyB2YWx1ZSwgYW5kDQo+IHJlYWQgYWxs
IHZlcnNpb24gZmllbGRzIGJ5IHdhbGtpbmcgdGhhdCB0YWJsZS4NCj4gDQo+IE5hbWUgdGhlIGZp
ZWxkIElEcyBmb3IgcmVhZGFiaWxpdHksIHNvIHRoZSB0YWJsZSBlbnRyaWVzIGRvbid0IGNhcnJ5
IHJhdw0KPiBoZXggbGl0ZXJhbHMuDQo+IA0KPiBBSSB3YXMgdXNlZCB1bmRlciBzdXBlcnZpc2lv
biB0byByZXZpZXcgY29kZSBhbmQgd29ya3Nob3AgbG9ncy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IENoYW8gR2FvIDxjaGFvLmdhb0BpbnRlbC5jb20+DQo+IC0tLQ0KUmV2aWV3ZWQtYnk6IFJpY2sg
RWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg==
