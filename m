Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23437269A;
	Thu,  1 Oct 2026 00:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814744; cv=fail; b=tmq436Um59KQFG533djHa91w2odEKSLgTy4t54D2ma37+ghXG6dRkQzkmUJ5ZNiSNR/gwP2SGL2YcbBQSxbiQwGF1PjAVt2P0MEl/wxOumiDyRi1nM2LEjywaj1N5nyb6BIQJ7TVpZtAf0Gi0yFc8UuiqN4eSoZwn6fZEVao0Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814744; c=relaxed/simple;
	bh=VRX22KLHussxfv5YO/cxlhW97yCHX/Y1qZbICLIRo58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVGmESm5GS0RF6Eu4blGE0QH5QsmH81IHS/VSxNswPqHnEAJr6ON1YZFOrVLxFwdYmvXy6XyT5hsGOQAt4GC5IXwszGqccMh8+dLdpUDaB1DmutX+rFNg01q6O2/75xmHvQ+JkELhUtA9lCntSTKw2CxeyaCAcCZrS4HlO+zA30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNYp805o; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNYp805o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790814736; x=1822350736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VRX22KLHussxfv5YO/cxlhW97yCHX/Y1qZbICLIRo58=;
  b=LNYp805ocR9xl9LpFhHc4eKXNrzCjNU7YR1dhGxrWsvFialf1n1Meu36
   VlNGpiaJx33RaQCUch37sQn9w6fmoPmdpOgM06lSOMtVWhwnjuJq0i7RS
   8xCQJj/ZXZ+K53HVUuHMFDWzONFna03fLYqLPH4HxTRQ5Ue/ZLFI9VoLC
   Qx43EWfBDL7LrNATIP+9oSCOoXb9Ck9rPD7pmZtrAwA8+NXyUshmv0jQn
   f6KufBtoEndD2UVxUDjFW34K+0bizF0fwzT6L6oHC+ycWm9tfC0zhsv1t
   Efo3KqK27ZRL7ULhYgOOZz50BI6LvdqC90r8KTWy+G1WfKVcx0bYv58eo
   A==;
X-CSE-ConnectionGUID: 2JX0+cgQQZeO2wz8M+pmhg==
X-CSE-MsgGUID: ErBMMitDRVuWNzR3wQDeyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90778430"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90778430"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:32:08 -0700
X-CSE-ConnectionGUID: xatU2CK6ScGAZlygK/S4pQ==
X-CSE-MsgGUID: K+suNqQoQr+UXVf+BmMSFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="305351376"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:32:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 17:32:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 17:32:07 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 17:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbgDKAKsIS+uB+ezQffPXB0pxWJ/6HnMU+bkKzFHYuUfOYqTLeY+A20PIGJrgDlvMVGI6sPLCBfkfwwVkkf9KXcujZS4EJTXms27bri7G1Y93YC3a/WQmi5UQaYNQGVW2+v/Kyd85JfB63p2KmGkvv6aLfHp56/PZda3Ah8lSbGmG1EcdKNLxYVrDMYs6hZbHcGnXagRJmeH6TjlryscZghOj1lB5r1C9lfNanZUksCz5F9rHAOYlm8JN0i1KrJ4f++B7VBAz7AxCr8nCOVLX9l+3r1bhrKQ0u3BJ+LrjDoSxV3cd8wyNCW1mfrLBZQdZl838qx1qAPrbAk7+Epo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRX22KLHussxfv5YO/cxlhW97yCHX/Y1qZbICLIRo58=;
 b=NlJwYGGcIZUqcyH/kka+bDmPjWWvnXHXPn+VWOwzgmYhz8zXBT77vt6KqPUCvnDltHEczxfjSHu2ckqC6kQ+QbpajDJmHHVbtWY5rYOWiLo28dIZ9Rmix3SLAX9o+s0Fz7V9FxFC0EGzRI4Uo1X0akDD604Mabjz8YcZUz2KTTdKLig4LOFSIzW1rS8EjkpYA0Ezw3YEiPgUZH11Gds2RGq4g4TJA75Ol5OTMJhrvjwr3wa/gdo9XqsktqNEcVHogwcpW8WOQa5eb07cHkZv6Pvv/ZKTZ7TEy5My+FecghuEk6/T/V/u/hDGJsehRwiuUI0XrKPbzGcf5Dg82GoICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 00:30:31 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 00:30:31 +0000
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
Subject: Re: [PATCH v3 01/10] x86/virt/tdx: Add a helper to read a table of
 metadata fields
Thread-Topic: [PATCH v3 01/10] x86/virt/tdx: Add a helper to read a table of
 metadata fields
Thread-Index: AQHdUJ5NF+rDf6KAUUGKuAfA4AFENbbn1uMA
Date: Thu, 1 Oct 2026 00:30:31 +0000
Message-ID: <2b73254d257bae5292e16b9c1bead75844fbb1e0.camel@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
	 <20260930053901.22528-2-chao.gao@intel.com>
In-Reply-To: <20260930053901.22528-2-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB6736:EE_
x-ms-office365-filtering-correlation-id: 81cbef98-53d8-4789-12b6-08df1f53335f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|56012099006|9063799003|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: wd8ZkKOjveq/09MhyWEEo5p/nQgHWx72JrgUOHOANoMsIKytjQ/bdoArDQmti5Q1bZfP/AbNgjvAvvOe2cWo1KAa0Ivgd/Lg3aCscHDP+Rz+reVK8qtsRCwUwLvm1yB1jNjG/uEkvqUDbwDtdwP0fmM+q4+WJ8wjPcwyi9d/N7zwVe4ElkfiEQDR+QfD/GtWe8PfPMdmQo0kkrzVE1FT9w+uTjh5TzYQWewtvmIFwX2nyinHiNB2oMObbMR5wj8o+zMTawhXTk9DpXRNxMJsGsaZFzh+2wdodTGzBM8JmSNzFJRmedB4ikj2YRihg9tog+yDUT4Jl2U70cdU6bN6Mq5MombwdLeqmGdctmI1bHxNpNBo12ahS9egonkxGVGuvxJjSGkY3aFZ4o9+ZdO+1hsQsojdb310tDzh9J/3V/0JByJDVC5aeKcexHQ8q+i3a0xxjAUZReXKUk37ckxYVV5AST+OfWNopyCofD9fMQ0BjG9kafbGdIxNuI6Ggb00pOB5aCvR/8Bk0wSe25mbBObKph8QTIrLI6PExBK1nMHUp3HE7AZ9XRCRh2paoL0fs1uixpD/eLY6sg8AUtkYbEAAjNu8UY/HtjA1pheDWniZu3xvnIjJED+P0VETZfYINsEjn9vuhuYo9hr2sJnrStZwwfsvr3vfrvtmRqaO4LY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(9063799003)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnkweGdnWE9NTjNGdm9WR3REZ3VacTJmb21JQnZ3RmdibktuWTRXRW14NmN1?=
 =?utf-8?B?ODYxYmRnYVNreFFIQ0lwVGZKME9WakpsVlRGUFkxSHpjc2xZbDg4SmQ2Mll1?=
 =?utf-8?B?aUk0NDBxQUxucWlkcVdkWnlRaCtSSEdtNjVLbmJ4cmIrWUd6d2VsTGxsVDV6?=
 =?utf-8?B?VHBoaWdGcEtxUEVmbytzU1IrSWJtT0xuNDErNzFOQU4yK0NYckhxZE1PeHo4?=
 =?utf-8?B?TDNNRWMyVGJJTjJxMGlvazVBelBBRDRWdERGZXNOS09tZnUvLzdmZ1NXMFhD?=
 =?utf-8?B?UVJtckFaS2ZvdFFSNUZxSHFXSzQ2SmtUQTY2WEk1eVlScDdheVhJM1dVblpJ?=
 =?utf-8?B?VHZCZjBaZFgvL1FLdVFaYURzZFR6MW1CQ3NTVVp4M2xMNTZMbVh1Y0xDTWRL?=
 =?utf-8?B?UlFNZzZmbEpkS3puaW8vSytVQUdEbFdRNWppN1cyVUFRL2dMdXBlMnFHVS9x?=
 =?utf-8?B?RnhxSXNzc2lUZFVVZHVnbVJtbkhKS1c0MXJoL29sbnlHNTdycE5mdHF2OHVm?=
 =?utf-8?B?UFhXcEp2cjBWcTVlT2UwZnpsd2w4a0dIWjY3MkFjZzBDMVQrUVlLRmpaenlh?=
 =?utf-8?B?R1IrVDI4dmZhcWFtVkJjeURSQnUyRGlhY2E3a3dROEdYdjloZTdpRU4xL1hZ?=
 =?utf-8?B?MHJwVlJZMC90SVUvdmlUQUdhMStjbWJQcTVEWmNlQjd1bjN2c2F2UHA3bXdL?=
 =?utf-8?B?OWNtMTZ4WmV4REN6M2xDbTVqR2t4clJJVjNUTE1EdkhIak5oYlhWZG1JZDd3?=
 =?utf-8?B?MXFaZG85TDMwR3RZZldiS014em9HVnlnTUxxY0VjMHNhSDYxRUkzcTg4K3Zn?=
 =?utf-8?B?UTVTanpKVFhSQ3NrOWhDc3VSM2xrNzVrS0kvbTJkSFJDTDluRURmbTl4bzQ4?=
 =?utf-8?B?MDBJQmhhT2FVTzJpS0dJUWxjQS9WaFhPTGxuUjNwZnd6bHFhMldIbXdhRkVS?=
 =?utf-8?B?N1JZR3VoS0UvZmtKWnpXcHN3Z0E5Vzh4K290amc5ZlhUQjc1WEFaMzJEdW15?=
 =?utf-8?B?MzJSWmR1R2hCRENEamJEM1A1bGdTQnhiUFFmTTY5OGpQMnczRFJ6Zk9JaDFX?=
 =?utf-8?B?Yk9VSUdUdXhGcEtjbjVXNFNlRHhIbUthUHNDWHpMYUtPQkxUczZ5K0RXbUFH?=
 =?utf-8?B?QzNmd1VpamZDYVdFM2F2OWFDVUpsMUw5bWFLRmU0ajlTL1pOQjVXL2hBQitK?=
 =?utf-8?B?VUFRTHM3ZXdtYXN4aFpzbVBHQ0trUy80Qi9uTVNSU3FOZnFobHQyRkNDMUNH?=
 =?utf-8?B?OHRZKzd5OUFMUFF2ZTJ5YWlKcDBCTnJLc3ZBeU5QTENZRWJVWUJaaGMxekxY?=
 =?utf-8?B?WWVTc2o3S05Wd3g2T3pzQmw4UFJ6UldqaFhuR2V3RGwwdlpFbVROYzBROU9B?=
 =?utf-8?B?M09NU1RrZnozSlFTZDFXS21TSXoxTUEvNVZ1cm9QK1RiZWplazJtczVGek9G?=
 =?utf-8?B?VCtNRHpHNFpSU2dGTUtZaWR5eVUxaXZSY2d2bC9kaFdLVnExSGcxVEk3Zncw?=
 =?utf-8?B?QmRKTWdBVXVJK3RBcThQMjV6QjhDS2g3a0RXZHBveS9uQzZvNjJtZzk1aEZJ?=
 =?utf-8?B?RGp4STZjYnRTQUFKRUJVdU1SVU5wY0ZSQ2dYMmxSWGx5SlhON2J6dnZZbmZh?=
 =?utf-8?B?VEFIM3p0UE1UYW8wWDRTempsd1ZmVDAwQm5jL0U4eDFHMEs2QkV0TG1jQjY5?=
 =?utf-8?B?dkhNMUNLZHAyTGdna1ZGTi9JUEVBU3BoZFo2UGpaQlJkeWlwYVRlUnY5Y0pj?=
 =?utf-8?B?aTUxbno5YUdOOVBDcWFFV2RiRDlKMFhqaHRiSmk2amZVR2pzeGpqNzFpbE4z?=
 =?utf-8?B?cUxMZTZQYnB6U1Z3Sjg5Q1ltSU9TR1BmbTVsK0NkS1FQT3JwUGdZYjJycHpH?=
 =?utf-8?B?VDBHbml0dVNrVUdJdUhYYWw5OEpNKzVQb3M3WmptbzNWZitiZnRmMUtMRjUy?=
 =?utf-8?B?dUZKSnRCNGptOVVxSWgvVHFHM0ZFSldwZDZERmlnSW95U05LbjJDSWw1RGh2?=
 =?utf-8?B?TlVNZXlJZytlU0dHQkJiRXFwMFlzdUxVKzZ0RjdqVXJWTXY5aTFYV0dOTXVa?=
 =?utf-8?B?TklTUFRiUHJ1WXIxeEtDUmpjZGdEZFFqWm9sWXhrMW8wbkV6YnNRREhhMVc0?=
 =?utf-8?B?WVdodWRxRGpXV0kzd0JrMWE4LzZGbE1ibnNyUURoUzA4OVpQMFhld28wdXJV?=
 =?utf-8?B?dVJMcDRHSnlBd2I5K01WZHdVbkw1c3VMNmlhc3AxbndBNjdjKzVGazQxN1g1?=
 =?utf-8?B?Vzh1NE5ScWJpSG81UXM0cGJsRkJpdjVteE05K1JaOVBxSS8waDM4RUNlcjlG?=
 =?utf-8?B?dmxtdmFXSlFpcHljUFEvR2xLUnNLZDZVMElYT05nZXFZYk1XNEwwaEd4L1BD?=
 =?utf-8?Q?Ve1jbKSp8P6r45fU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6670450FC17AB741A07C3FAFD2EF353C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0l/mmfInWI/DrX88IPUc1ztsfIZYhLvOFGYl94u3pIKYdXdn2ONT2bkLLjEHSebdBR/bxu30Zq76EHlCOsfbFUeaDs4oQd/lOhU7WMQhVFKPNZ66w/yPJ9xfaTrWEK0mb8YWnShLc0w1aDqD8ZHUvvjt+m8+nH4W0vZK97dzcvU1EnhdGqmSqo9T/CVPFpFtEHefmCAJz1Yc/8cqAV6obB6omRXmS6pPxb1xr0Ods90rYqCmVDazD2geHRTE9jY+zS1Ja8VjIO2HuutOI5mmtYFNyoPBcAPXXWstgOOH4TAxxHxJfNY4VuHXRZwZ7JciTGnrc53NA/AShHdqe1HdnA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cbef98-53d8-4789-12b6-08df1f53335f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 00:30:31.4348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgxssC//7zPJLFUTMRE5HlB5c7AN6v6HxixVcahJ1WLXyhL1VKLlvdCT5D+dkvKFLHVVBfdN28KtWgdQ1N8QtdRiSRCXJyL/rGF0CxKvEJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDIyOjM4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IG1ldGFkYXRhIGZpZWxkIHJlYWRlcnMgZ2V0X3RkeF9zeXNfaW5mb188Y2xhc3M+KCkgaW4NCj4g
dGR4X2dsb2JhbF9tZXRhZGF0YS5jIHdlcmUgZ2VuZXJhdGVkIGJ5IGFuIG91dC1vZi10cmVlIHNj
cmlwdC4gVGhhdCBoYXMNCj4gbm90IHdvcmtlZCBvdXQ6IHRoZSBKU09OIGZpbGUgdGhleSB3ZXJl
IGdlbmVyYXRlZCBmcm9tIGlzIG5laXRoZXIgc3RhYmxlDQo+IG5vciBhdXRob3JpdGF0aXZlIGVu
b3VnaCBbMV0uwqAgVGhlIGdvYWwgbm93IGlzIHRvIG1haW50YWluIHRoZSByZWFkZXJzIGJ5DQo+
IGhhbmQgYW5kIHRvIGVzdGFibGlzaCBvbmUgc3RhbmRhcmQgd2F5IG9mIGFkZGluZyBhIG1ldGFk
YXRhIGZpZWxkLg0KPiANCj4gVGFrZSBnZXRfdGR4X3N5c19pbmZvX3ZlcnNpb24oKSBhcyBhbiBl
eGFtcGxlOg0KPiANCj4gwqDCoMKgwqDCoCBpZiAoIXJldCAmJiAhKHJldCA9IHJlYWRfc3lzX21l
dGFkYXRhX2ZpZWxkKDB4MDgwMDAwMDEwMDAwMDAwMywgJnZhbCkpKQ0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzeXNpbmZvX3ZlcnNpb24tPm1pbm9yX3ZlcnNpb24gPSB2YWw7DQo+IMKg
wqDCoMKgwqAgaWYgKCFyZXQgJiYgIShyZXQgPSByZWFkX3N5c19tZXRhZGF0YV9maWVsZCgweDA4
MDAwMDAxMDAwMDAwMDQsICZ2YWwpKSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3lz
aW5mb192ZXJzaW9uLT5tYWpvcl92ZXJzaW9uID0gdmFsOw0KPiDCoMKgwqDCoMKgIGlmICghcmV0
ICYmICEocmV0ID0gcmVhZF9zeXNfbWV0YWRhdGFfZmllbGQoMHgwODAwMDAwMTAwMDAwMDA1LCAm
dmFsKSkpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN5c2luZm9fdmVyc2lvbi0+dXBk
YXRlX3ZlcnNpb24gPSB2YWw7DQo+IA0KPiBUd28gcGF0dGVybnMgc3RhbmQgb3V0OiB0aGUgcmVh
ZC1jaGVjay1zdG9yZSBzZXF1ZW5jZSByZXBlYXRzIG9uY2UgcGVyDQo+IGZpZWxkLCBhbmQgdGhl
IGVycm9yIG9mIGVhY2ggcmVhZCBpcyBjaGFpbmVkIGludG8gdGhlIHJlYWRzIHRoYXQgZm9sbG93
Lg0KPiBOZWl0aGVyIGlzIGNvbW1vbiBpbiBoYW5kLXdyaXR0ZW4gY29kZS4NCj4gDQo+IFByZXBh
cmUgdG8gZWxpbWluYXRlIGJvdGggd2l0aCBhIGxvb3AgdGhhdCByZWFkcyBlYWNoIGZpZWxkLCBz
dG9yZXMgdGhlDQo+IHZhbHVlIGludG8gaXRzIHN0cnVjdHVyZSBtZW1iZXIsIGFuZCByZXR1cm5z
IG9uIHRoZSBmaXJzdCBlcnJvci4NCj4gDQo+IEFkZCAnc3RydWN0IGZpZWxkX21hcHBpbmcnIHRv
IGRlc2NyaWJlIG9uZSBmaWVsZCBhcyBpdHMgSUQgcGx1cyB0aGUgb2Zmc2V0DQo+IGFuZCBzaXpl
IG9mIHRoZSBtZW1iZXIgdGhhdCByZWNlaXZlcyBpdHMgdmFsdWUuIEFkZCBURFhfU1lTSU5GT19N
QVAoKSB0bw0KPiBidWlsZCBzdWNoIGFuIGVudHJ5IGZyb20gYSBmaWVsZCBJRCwgYSBzdHJ1Y3R1
cmUgdHlwZSBhbmQgYSBtZW1iZXIgbmFtZS4NCj4gQWRkIF9fcmVhZF9zeXNfbWV0YWRhdGFfdGFi
bGUoKSBoZWxwZXIgdG8gcmVhZCBldmVyeSBmaWVsZCBpbiBhIHRhYmxlLg0KPiBBbm5vdGF0ZSB0
aGF0IGhlbHBlciBfX21heWJlX3VudXNlZCBhcyB0aGVyZSBpcyBubyBjYWxsZXIgcmlnaHQgbm93
Lg0KPiANCj4gRm9sbG93aW5nIGNoYW5nZXMgd2lsbCBjb252ZXJ0IHRoZSBleGlzdGluZyByZWFk
ZXJzIHRvIHVzZSB0aGUgbmV3IGhlbHBlci4NCj4gDQo+IEFJIHdhcyB1c2VkIHVuZGVyIHN1cGVy
dmlzaW9uIHRvIHJldmlldyBjb2RlIGFuZCB3b3Jrc2hvcCBsb2dzLiBJdA0KPiBzdWdnZXN0ZWQg
YWRkaW5nIHJlYWRfc3lzX21ldGFkYXRhX3RhYmxlKCkgbWFjcm8sIHdoaWNoIGF2b2lkcyByZXBl
YXRpbmcNCj4gdGhlIHRhYmxlIG5hbWUgd2hlbiBwYXNzaW5nIGJvdGggdGhlIHRhYmxlIGFuZCBp
dHMgc2l6ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYW8gR2FvIDxjaGFvLmdhb0BpbnRlbC5j
b20+DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8xZTdiY2JhZC1lYjI2LTQ0
YjctOTdjYS04OGFiNTM0NjcyMTJAaW50ZWwuY29tL8KgIyBbMV0NCg0KUmV2aWV3ZWQtYnk6IFJp
Y2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg==
