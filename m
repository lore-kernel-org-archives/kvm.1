Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2B936B933;
	Thu,  1 Oct 2026 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814733; cv=fail; b=rOqS/C+ddZX+Q7ssy3M6tLB3OYdmljcqH6bQB4qb9zmifMKhgFQGv/tyTZhbfwtqQcJzx46TXY4sbep/1oIDU/wtx2/JdTc8VgHoBa4ffYSqYwo/g/by55P0xs5/F+T3W/NerBUk4xglNrGPM7yQeSLSdsx9K2k/lNiNrQ2DFr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814733; c=relaxed/simple;
	bh=n2/rOQArs1KEY/PqGhyXms7HxHFZJbcteoS9wJ6g0us=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZliS0jT4+Z8TLE6U9FyWq1lPNMR8GcwdFCDt5dk0evwlx/h+9guoG07b4JLyKfUChHOMm8BCFhmGJILzwAPSKQMtIGXKA32JoZ21bhKeaMWOwf9yRqVI+UoEzhKAVzooQy/ALHd6DWdqm/kpTSw+1uySqO4vgdHjGU/mrrUHxqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFtOPLTf; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFtOPLTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790814730; x=1822350730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n2/rOQArs1KEY/PqGhyXms7HxHFZJbcteoS9wJ6g0us=;
  b=GFtOPLTfQ6QG/lYafs90/2cetCXmLnHTU88xs05zESBS+j4WNagjoQ2d
   n+wzg1OyunwkUndxfcBxHdCp7vfGiQWgNH3w+3e0Ep8jLlTelKMXkbIA5
   tD80YUzxUHeBX4NBVZOOXffHQD2Fv+acuHPAFHk3fllyUU9ux+Sh0h9pn
   NAZOmNQ8kXPnt+QdxGjIhg+GJ5NNV+um8GpCXB0+gkSSPJ1NHmPoOAOFJ
   VY9uN/qB1CffkfUebq+UsA4vgW+DFtEn8OZc949HRY3EAGPbI+7eyiHAH
   GCwAMm5m9EKXKILzJv9YtPYmvqeKRi5FnhbpUSdbgmg3+NO4536M6AbBC
   w==;
X-CSE-ConnectionGUID: 3beO1usgSsibKhJY0ICqyA==
X-CSE-MsgGUID: MhA84lqmRV+SY3ZK7a9Cnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94279695"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94279695"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:32:07 -0700
X-CSE-ConnectionGUID: 84vxy5JBQm2XIRWWCC2iEg==
X-CSE-MsgGUID: +kz+c10rT62yrycmCRvZeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="279142705"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:32:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 17:32:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 17:32:07 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 17:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWnEWG2xWTG+Gwj/c3TxVRGOE68nGtvLYn7b+0zCBXkwFLZ/FA0j0BSD9a8NpXPwcRc0W9gsMnSVF9DRO5POmeKYTE+bM3Li9kDXswjYGYfjygKgGYJwDmGRmCsbcaDw37VXsgP3Wou6rMUVr8eju71LZYB4VHrR/sHbp18xZOkZlet6FnWgEgXLDtSU2wlF9TFYHY/CzK+kP457h1TZwXJ869h/YqFWFjcMi2JUid/a5F2anYLpRxqy6wMpyIbNNwSGFMIQbWwtomz4KW4fwSj7T8bheoDN7dmGaVMLrunynk8jEQ/uyjCzfyzsb9lZmmzPSJfQHxHzHW1JjZPbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2/rOQArs1KEY/PqGhyXms7HxHFZJbcteoS9wJ6g0us=;
 b=SXnRzlt7e4x5ggxzNbbH4W5J4PZvhKde4KqMLHzOgiKSApupyZkuIE5/ZWEuBFsW1PUMGOMoSmvPrTRY8BF2rtOPPEki1DwoGCn1IOz+nWIZJNefJGShzLZUYBzwgmcrpLPLb4+6+bI6nRhUh0tuyWqOuTtTWKrVlg1qVRfRsMw7oAxV2Cfe+71yBZ1Om1Nw7zHKGlQyfgkObNcDZmyqqcCtA4ygiOhYbTT7N9DitVaTcjaFvxhhNhXB62PUNFlYRqwYDgLcIRWQse7YjLr8k1vTe5oumBwST+XZ2ilwS0HTT8O4seuzBdDYCG5CCm+YTK+21Ag5gYk7Vx6n3eY9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 00:30:54 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 00:30:52 +0000
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
Subject: Re: [PATCH v3 03/10] x86/virt/tdx: Convert the features metadata
 reader
Thread-Topic: [PATCH v3 03/10] x86/virt/tdx: Convert the features metadata
 reader
Thread-Index: AQHdUJ5N4nuw4jMXB0S6qvNODHAIq7bn1vyA
Date: Thu, 1 Oct 2026 00:30:52 +0000
Message-ID: <79f4132d19b334bfe4a0f8ba3e4d9b8ab213e332.camel@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
	 <20260930053901.22528-4-chao.gao@intel.com>
In-Reply-To: <20260930053901.22528-4-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB6736:EE_
x-ms-office365-filtering-correlation-id: 8b93d18a-bcb0-4073-63bc-08df1f533fc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: mPyGNDZ6T/hTpud265Z9CislBelFSCHvllerDcPHVztWLLqKIGEvhHUAM/LqLomvlAYlozP5Lr0DVPpZs1FfIYicKFdG2zxnnUwjDDb3VK203uuUcqTHa2Ney9PC2uJ6lZLSB9cChAp2+s55B3dyyN6mwnGdeDg9MM7otCbNtx/QnX+yBqn6QWqPLKureWr5KCHwqetvwx0ipd90IsojUOtT4/Um+CwNt0D08yqRdlizmaF4fCkXHa1965IiTEM9/Nfj/so6lnCR0m2PiTfbAVgSBUKl2CUAf8NX5ciEadCXZu9rzHsZadDK7gLIl0HCXF0uqGVRuVrR9hh39It7haRzqUlIO0APh36o429P8g3U3Gi72y8/rK+w7CPJSh4C3+CtIoRow/aAJz83NYAlXupoJKMYchuUoPJgTJ4NrEHe4USSakWy0bxnDwMEvzE3SamMQkj3KG/CElwxuAp3u74JiBo38kU6gSV6Lm2XSAWxwLQPZ2s15Dnn/QRoIshyVMPaIu8LSugpUh6puSQvZKT6OQrS6DV9Ed91be6FPA+o3CVM+4tusMfywi2vljLdX9a4C3PZR7Ry1GZxtkkF7DFbMMGNUau1qefzYLFZJq+98xfKsa8Z+gOvQHN3wkWgQVPFoEncZIOevh7I8MBtotCUK1wleybV6KqNGNtcrWWC5+0nueG1fkgxiUh8F4LnGF+n3z5hQWHSgvmqf02Bte+YemWDdCz6D0+uSNMoGu8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGZwSWVCcWVzUWhGblloOUN5MkFsektBZnByYTNabDIyc2t0bUF1eGdNdjJZ?=
 =?utf-8?B?U2RXTnlxV3pRbElpUUNKalVOWXJkbFlRMG1NQkl3TDBobnZJb0NnRnVFY0tv?=
 =?utf-8?B?WFphTWt3dWI1ajU0NVkwdVJhOW16UkdCQ050U2V0OTJ0TGE0dTdnc3NzNDBC?=
 =?utf-8?B?cXNjT1RCVGk2MDFOVy9QZGJTMW9lZGlOUWNkM2t0OVpmdnZDd1BQN2x6TWlK?=
 =?utf-8?B?djJBTVZwQloyTEw5ZDRYalpsam1wUlpDOVpSaDhsc1luZzhBNFVxR2NmL3F4?=
 =?utf-8?B?QWVKVDNrL1NEdFNaL3E2OW1wWTduSUNBSVMveXRycFhFNlhGMEdlRXBUajM1?=
 =?utf-8?B?Z0pwU2kvQkRYSVE2Yzhtc21uZHlzOUM3VGgzcmFvVEdHTkpjbVFnOHRhb1d1?=
 =?utf-8?B?R0VEbW5mb0FPbXdyUFc2dldueDJ6QUlkd0ZqQytCVDRrMUpRaGRrWlBSRHcx?=
 =?utf-8?B?RVFQYlJQSWJ6T2RQM0N1aW9SQmgzdlE0TTMxeHFhVGJHMVk0L044clczOTc3?=
 =?utf-8?B?RElLNnpjM0xjTHVmcWl6VUM4d3plLzNmeFBwYmlVL05SbUlYbmYrNnU1WS9p?=
 =?utf-8?B?ZnZuREhWYStqUlpqcnhjUkxSZkZnL3R5VE9DSVdlSDZ3akZIWTJMSVhqczh0?=
 =?utf-8?B?ZWV2clg1NG8wYVl2QklSRkxtMkQ3dDJ3WlBGamxadHJhcFVwOEk1V2tBOC9U?=
 =?utf-8?B?ekNYTGlqTk9QcSs2bHlxWXZBcGZ0d1NNelhuWkFNSE1JZjRuZmVvTmlxbll1?=
 =?utf-8?B?RkdNMVZXUDIxbjJiOGt3R1dwbnJaSWlBNTRrditVT0k3MmoxYlA3dHR0QjRG?=
 =?utf-8?B?S3Y5ajZicDFRN2x5N2pEQzhtVGtGTkc4bjBCelJWZS8zaVZscmpuWHdHL2Nw?=
 =?utf-8?B?d1lVK0dvZFZOdDVUSHFzSVlpYUpMdWpxVTZoNlJKK0NySzhPRTNoRUczQm5U?=
 =?utf-8?B?QXZzY0NDR3dNSDc2YUFYZitGRGZrNFN5eng4ZXdCbDI0M1lDZkl5cWZRNExO?=
 =?utf-8?B?d3NxaVlwYzhXNjNJZ29mQ0x4SXJEcDgrUW12T0hNeGwxWmNsSDJOQndEb2lP?=
 =?utf-8?B?YXFoc2tZaGNWQmtGTW8zSnIzellIMWhVVFJXdStQZ01BaVFFWEIxR25CUGNv?=
 =?utf-8?B?alZzSVpHdUZreHdOU1J3dXFwc0l0cW1Wa04wc3JESGRLTXJkSDdtTnZocUgw?=
 =?utf-8?B?TDFYQkNBaUpuNEF2bi9tRkI1a0kzdW5uYXNRR2Q3RXY0Q1hyZmhjU010cERB?=
 =?utf-8?B?TXhmNmttM2o2OTFxUlN3WXdvWHN0eTNscWdyZituR080S1Z3cTJvd2ZiU3hL?=
 =?utf-8?B?MUpUeEY2Z1VhK2ZZMHVvb2VWdlpPZDZDQlIzekJRWFFFNk9zVXBBempteEkr?=
 =?utf-8?B?UG1LMmIyU2ZjY29mVktFb0diQkJPK05WQXFLRFFpaTJQejBWWm94dVJYaGE5?=
 =?utf-8?B?R2MwLzYwRUlYSUhMR0N2dXRuaUVuVlRFUkNXQ09WYmljWDc0aUVYUk9hZUt2?=
 =?utf-8?B?QnJ4OXdmQXFFVGdVSktaWEw5WndjakZ5L05URTRrcHdZamVVR3pKSzgvMXZC?=
 =?utf-8?B?SUo5S3hjak5ZQUIvWFhUb2wvRXNhTFlRRGFlSU1RMjRmRHM2TnhPWmVaYVlK?=
 =?utf-8?B?b1V4dFRpc3BnMlZQZ1FoZTNGR0FZMWtHdkc4RExSbkQxdk5kUEJGMEw0SEYr?=
 =?utf-8?B?Wnhmd1dCVzIxWDhQMmM2Zk52S1BNR3Jqam5XUWZaRkZvZEM2czAyaDdoR3JN?=
 =?utf-8?B?YWdBN2U2TzdibmtoVXFJMUFEUFdwcDJRbXArbG1VZHdGc1NydXQ3UitBYW5C?=
 =?utf-8?B?ZGdvUjVVRm1IK3gzL2tpcDdBR3RqUU9aenZvZXBiK1hFUVlHVHM5TzVsWHYr?=
 =?utf-8?B?b0RlYmVLUE5ENkVBakI5elpVUXd0OHVwbVlzL0dxT2RjZm5mMzZ3TGY1VTJ1?=
 =?utf-8?B?RndrblE3QzV4S3ZDL01PTXBMU29OaTRlSHdpd28vMlVocEJ2WFVxRjZlUDUx?=
 =?utf-8?B?OElLU1ZZWXJtNS9GTDJ4L25sSmJEa3ZFQXk3N2Yvd1BWRlU1QktPL0o2S0FZ?=
 =?utf-8?B?S3R2alhxME9ObnhkeTFZV2o5QzNCTnd6djBYbWtlRk92WVdxb1M5dmdPeUlZ?=
 =?utf-8?B?bXc2OTh2cW4zSUo1WlI3UXBrcnFjajBsWjI1L285Y0puYWg0a0d0bFBjSGhJ?=
 =?utf-8?B?ZGZZWWsxb3VaSmZWUlFFdi9ONjlHWDlXaW5qdlMwR0pRbDZRS3dEbVNaWDFv?=
 =?utf-8?B?SCs4QU1nVkJQMDJsRnJsWG5zN0Z6dGJ1bEVSM0QrV2FlQ3A0VDhqZDNXeFdQ?=
 =?utf-8?B?Nm9nemdVMXU4aWNUZjhnRGhubllGUDdwZU11TUF0ejAvM0xXUG9YZmlKV2tR?=
 =?utf-8?Q?8PxquIRooUVK9V0Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD1315655C6F2D46ACA3FEDD46CF2CBE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5KaKJYWVnIxP4API340oDcLnV5JVD538YjObN7QPtmSRAOzlQEDtN8yWKplFr9VL7VZPx6mzfZcn9rA0VdK6nJ6MlexZlexGoLv4uJi6ZlCcU4HldwynR7TBqWED7WgbqRBPvOY0MFQCLWIFPgs0cZNQkiYexFNw1FeyLcpX6w+ELIwnvDSIaIUqk2hovQFEKB64A5uojP/sdtHDZ+MeDyaJ8wLYV/90ep1jGoMAxu5l6L6dKhdRKRdYBMlL8WwSK2m/Qc1WI5fVv+0l02nvD0eraXKZmJHdoVQ4bxu3AYbzr4p/v/SGOHHyggwXYP3HS7VF3R9kb/vArbUkg+F/eQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b93d18a-bcb0-4073-63bc-08df1f533fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 00:30:52.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kzoZpdYm4lDiK3dD/STvLj46h97YkWQ9/IarDpxt5rTzBgY9EJZe3Sn6ynS6oaswTq5XloR2wgLpTbHdEZXHyy2x+m6AhEIsHIGC3PzlHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDIyOjM4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQ29u
dGludWUgY29udmVydGluZyB0aGUgbWV0YWRhdGEgcmVhZGVycyB0byB0aGUgdGFibGUtZHJpdmVu
IGhlbHBlci4NCj4gDQo+IEFkZCBhIHRhYmxlIHRoYXQgcGFpcnMgZWFjaCBmaWVsZCBJRCB3aXRo
IHRoZSAnc3RydWN0DQo+IHRkeF9zeXNfaW5mb19mZWF0dXJlcycgbWVtYmVyIHRoYXQgaG9sZHMg
aXRzIHZhbHVlLCBhbmQgcmVhZCBhbGwgZmllbGRzIGJ5DQo+IHdhbGtpbmcgdGhhdCB0YWJsZS4N
Cj4gDQo+IEV2ZW4gdGhvdWdoIHRoZSBzdHJ1Y3R1cmUgaGFzIG9ubHkgb25lIGZpZWxkLCBhZGQg
YSB0YWJsZSBhbnl3YXkgZm9yDQo+IHN5bW1ldHJ5IHdpdGggdGhlIG90aGVyIGNsYXNzZXMuIEFk
ZGluZyBhIGZpZWxkIGxhdGVyIHRoZW4gYmVjb21lcyBhDQo+IG9uZS1saW5lIGNoYW5nZS4NCj4g
DQo+IEFubm90YXRlIHRoZSB0YWJsZSBhcyBfX2luaXRjb25zdCBhcyBpdCBpcyByZWZlcmVuY2Vk
IG9ubHkgZHVyaW5nIGluaXQuDQo+IA0KPiBBSSB3YXMgdXNlZCB1bmRlciBzdXBlcnZpc2lvbiB0
byByZXZpZXcgY29kZSBhbmQgd29ya3Nob3AgbG9ncy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENo
YW8gR2FvIDxjaGFvLmdhb0BpbnRlbC5jb20+DQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUg
PHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K
