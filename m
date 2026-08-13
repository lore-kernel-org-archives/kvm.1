Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD1381B0C;
	Thu, 13 Aug 2026 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786661276; cv=fail; b=mHeRQ2vWrqEFkLjp2myKS2F6HIVCRQENqtoCxqevFgCjfUDaGlNjgzVb76kphXilkM0hd3DpAbl5iKOI6pgyRTEHF1K9sxw3cduixVMxLjeVzP+KS+p6NgeWBXiA8vRFb2U9ED4+M/KqiLqqtiDkCe6CvVexoZf2XUrwHSaZCnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786661276; c=relaxed/simple;
	bh=Y84kfWMaGMaKZAuIwNFTzQ5gau78x+6U3jB+EFkBe8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uzXgS6mX4eWVtGp4AF11OKbIKPnSjEnpu0Cuqc+lmxMgIvmfyKdfGPyRB1ZN8vaRPsySPozB7R5AnUlBs3rI9QF9hxGoqq1kKOAFv9AUS6Ee6OSEVjVvr34dCTp6Q4+AyqGVhYNW+IvVeA+Tt95JRz83b8Vxh/OEONlgr7nwfQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vv/qrXh3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vv/qrXh3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786661272; x=1818197272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y84kfWMaGMaKZAuIwNFTzQ5gau78x+6U3jB+EFkBe8U=;
  b=Vv/qrXh3RH93EoPCfTBqoepjd68sGyIHKFCB91hG9D321iH9D72DNFLb
   GC/FOOjytFQT3xHuHLs1IzdNYyfdRq2KLM+cIb87aRdQGg5Ogy0EHFQuw
   bnM89ugy/QrEaBVp7LWqzoUHwKU6/6G/v6Lv/i4Hztqlx2/WBs4wbAHXm
   cldSIa6seN3DsKzGfD+5cG9bnp012P4aeLCv4u+AJcfqsI8mckFYKdOlQ
   3fcDY4jcdRiYhEVmm5Lrqw4yhiqAxWkdcMZBWk7BN/u75YW+ByNKMmNoi
   TTUaelD/XR+8xxCnfrivHMp087LSO9IArWKUZktilA1YyFjJqvnuj2wm/
   A==;
X-CSE-ConnectionGUID: LBrR0uLFS9yxAFF2SfiYpw==
X-CSE-MsgGUID: wBrQe2lYSnWEp72YQDk3AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="89766190"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="89766190"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 15:47:51 -0700
X-CSE-ConnectionGUID: 7pysKfCBRDOnUysYJg133w==
X-CSE-MsgGUID: VL/Ke8efSf+eOzambpW8Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260268470"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 15:47:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 15:47:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 15:47:50 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 15:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlFWIGltyfQ9Y8SWEYu6uvlA4ogWs/qXoKF1NQg4w9G2Z37JUrF3uGkfVoBTs53Wi3XbxUnqHEbf1iJC67LDlDwGAqw+5fwSV6IhSzzpdeI2fCI7ofw5eCJipPGI3XS4gPIw0kAZwx3DqQa0GU2ZErqTTcEGizItRsd59sK9z9ZzNYS3T1oeAQPrO2EAnkY7JHZk4gHcMrqGaxRF18hlzNJmXDxlznrOLIjwVDyMKZdDvrZ006C5RtSpsfsPcFinNAV7rSPHRyds6Gt81iPp/NrVjlCsKiaNIChs1nsegTYsD0cfLcLl7cN0MWz1C7o/Wesn3JQcVqnzFgHxjVhO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y84kfWMaGMaKZAuIwNFTzQ5gau78x+6U3jB+EFkBe8U=;
 b=upERHph88CYKgaGDhGPXii9qyRf12Xbzzb8TiO2OiklCSzRAEqsCnG4TV4fDLvrAtmLKhzAugZgj36hb+tjnMs+DaQpLt/Le+3V3zdiyt5J+dU4yPM9I94wBgc7oDYqPCSezmAuQCvwxKGIBcynj8L3XbcFfKvqN+TvVDrqJtUWaZN6nXc3PpzYEwbZuhXO9HkM6DsnOS2Zd39/HxGwu8zJOFi81EbA0LEzO9P3sxq5pzkLx9E34vZ/4G9MD3AmOUscdbecWBUXPdJk5OMCO/6TGca11qSgg3tk+6rWn9PJj7abIoeP2WTcxX7nRDCd6pebbGmNl5vN4GYDeX9yc0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA1PR11MB8864.namprd11.prod.outlook.com (2603:10b6:208:597::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 22:47:41 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 22:47:40 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Aktas, Erdem" <erdemaktas@google.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"afranji@google.com" <afranji@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "seanjc@google.com"
	<seanjc@google.com>, "pratikrajesh.sampat@amd.com"
	<pratikrajesh.sampat@amd.com>, "oupton@kernel.org" <oupton@kernel.org>,
	"wyihan@google.com" <wyihan@google.com>, "sagis@google.com"
	<sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>, "Wang, Roger"
	<runanwang@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 00/22] TDX KVM selftests
Thread-Topic: [PATCH v14 00/22] TDX KVM selftests
Thread-Index: AQHdGi/fD3HeSKoX5UGSIW2nqtNBd7actxyA
Date: Thu, 13 Aug 2026 22:47:40 +0000
Message-ID: <5a44a6925715e1edbd379ac0ea5526ec990eb819.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA1PR11MB8864:EE_
x-ms-office365-filtering-correlation-id: a16dc4de-ca80-4556-997b-08def98ce199
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|10067099003|18002099003|22082099003|11063799006|5023799004|921020|38070700021;
x-microsoft-antispam-message-info: 87l//oVXP+pQhF5daJIrereNRMVLGLn22dPh5E23XumJhX0x1Tl3j6j+rTqZuQowHDEieWOTKKWynt0mso90d5X1n6LQzAR6C+3mS4y30uxS8VDXldaNGeivlYTKW0f+alk95+ri4G99Otvbtib9i/wkUJXw70E81RwLNuFQunOiBNnuhTUp6C3xRglAvbTpaoxXsIZ0QGMrGNcJukaIrOdfa06mRpWrxjDqIQ3GpNnsZkGbaodJ1x34SQ9qXCwgR4CO+6Qb3SLFeCjVJMAnnnQwP/RzqPfa3wP8pFQ+2C2I5C6+dONN1EUcSg5FcqCpkBC3KulmtO2Vrf7AACNpfQURV9AZ51M9bDh3Yc/aKuZWP/FMYu6bjVojMQeaarjvp3348jcwmmih/mKExLIxM3uy9944v7BK/aHqBEznj8RHo80XNOSM0ACAh6v9WTqSPZVGKZ8RQCV76ZmTCBSEEaI+pZxPssMV9vvrGLxDfhtT5TRybyrjnbghnHw+gK4Jj+19T9w7N5spfiulRydlyMoAFWMCmoWlF8BAvUFmEgPLKeaPp924KHwDu601m75d2q/wIx9ry2bt8tKbRvfDZ6/Wgrd+Ar45Al+nrlp65Hc66x7XEF54A2LKIS9Mcw94PYOgf0IM6ftw1bTe7ClGBc5+tz+mIOHvXhRXbWlgms45BjNBae0XQmt3Xz5S51rbrDSwJkXhbHBLMdpIWNbvQ+5u7cZnV5oTaOoUJ5OKunOAD0GevpHvVbGmJtQ88p1C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(5023799004)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFFXbjhxSVRONVcrNmEyUTF1KzZ3MHpBcUdtWG1FQU9UQm1aRUZyVWxmclpt?=
 =?utf-8?B?aUgrZWk5SkF3T2YzMDZUdmUxK1YrUjRIb1VJcUVKSGdHZFdnYWNEQ3ZDS1Fs?=
 =?utf-8?B?TnVIdmJ4VTdqMXhXWHJYcWpEdUQ4S1VBSDUzbjdJdGMyWEY3TXEzUk5CZlY2?=
 =?utf-8?B?ejdydEhtSW4xZU02SEFuTjk5R1loRnZMQlpYZU1qOGNrNzJrMW9QdTRhVUNU?=
 =?utf-8?B?QkNPQ0VYS3NTU2xWd3d2YkphWHFrUjdtKzk1aXlIY05lcjJoNGtGbE1LVGkv?=
 =?utf-8?B?amxmdjZ0c3BubjF6a1lxdUwrczhNSHlDaFZUYncwOGNBTUlqMXFGRjVOWDdE?=
 =?utf-8?B?QVc3c2pBL1dTQkRTV0VEem5NR3k1RklhS3dXNm8yTmJWZzU3RyswMlBDSVV4?=
 =?utf-8?B?SVROb04zR0ZRRmlzWlNMaEg2c1dmb251QWp5WXpoRVdub0l4UEpEbWxXK0ll?=
 =?utf-8?B?VmUvQllISEZPcjN5Tk9uR2d3alV3ZGd3SWRvZll0SlMvbmExb2htYWtkWWx2?=
 =?utf-8?B?dXUvSXoxdjhibExZbUVMcUd2bkV4Q2VHK01RSFM0T1hyY0xuWkRsQ0p0aXNO?=
 =?utf-8?B?a25JaTUzTWNkQm1FSnNDYXA1b2dXenIxY05wY1NGSWlwK0pnN0hkTlFCVjRu?=
 =?utf-8?B?NTNZMldQZFNhUkRCaUJOR3NMenpoUTRZcU1leXRmZDRnTW5rb1N4VndXQVY2?=
 =?utf-8?B?TlRFa2pXRkM0VTRnbHRMdVlYZ29CMkYreGs2YTV6dFRvS2RYVjlzM1FKRWhz?=
 =?utf-8?B?SlFxNllkY3BjaHgzYmlyRWgxK3NrQXdnbG1LM0VMSlFkajMwQjc5dFZxUmUy?=
 =?utf-8?B?aFhBT3dZdEhQNTJBUzU3RVJsYXdzMis1R08yaEowTWxuWHlGdEc1TUVQbHNS?=
 =?utf-8?B?WVEyUmlaOVk3K1BldUZQZEhubzB4aVp2QXBBR0JtZmFqckp5b21zSTVmMHhr?=
 =?utf-8?B?VE1TS1pudEVzQkM1ellXUkszVkRzTjd3WlRWZWRJaGxCN2Vxc1V5b3pFQVY0?=
 =?utf-8?B?c2xRaEdOQ2VoeEVuN3pMNmFMRkM2bUUyaVJxOUFFbWRJTllIby91Q3UrSnJq?=
 =?utf-8?B?QnFxQ0l1YklyVmg1UWFJelRQczhrbmhTSGVvaGVodXUvbmpQRTFSNWFFQjJ6?=
 =?utf-8?B?R1A4bmZyMy9HdWRub3lGZzc1K2hkSkMxeFRyZE1JZ0FmVmk0Qlcwdm9zQy9L?=
 =?utf-8?B?YkRpVjdHMUxpZHhUNWJhVGJOaUhhUUN6Y0JjMlo5eXVIZXIxT0VacHNyT0xq?=
 =?utf-8?B?S25Gb3BpRUZzcytCZm5zT3hMTWI2Tk85NS85MmN3ak5DRzQ4RjFtckg2cmNj?=
 =?utf-8?B?U1BQYTVCS0pmeUdUNHhWb3F0WkNOZDI5K0FhQkNZa2c5cE96cUF1Zm1GMU1F?=
 =?utf-8?B?cEp0SW1NQ21wd055dFpQMWtCZlZ2UDF2OVJpZGcxVGNqeFhJck5tVEhHNzZK?=
 =?utf-8?B?N3JiL0JtQ1NiemZuN28xdVBwazFreWVRRkhOOENLVk9FYjhVWGs5OVo1d0xv?=
 =?utf-8?B?L3NpTnptbVY0Qm14a0NnS1N3MnJCNHJlTDlUQjU3UEp2Q2JNQlRlSDhYWnhQ?=
 =?utf-8?B?UFFxQ1kzeXlkeWdEREFMT3pxYmVQWVdCMlZXYTdYUlUrdXc1amhDNmpDRFNE?=
 =?utf-8?B?Z3RrZ2dlaHgrb256UER0SW1ROHpoMEVLT1JQbzBKWXNnQWtYaTBGYktRcnpt?=
 =?utf-8?B?SmxBTjV2ZzFlREVDUnV4d1AxRTViUmxJVHZJZk4vbEFVbjhRZ2lHMjlxYUF0?=
 =?utf-8?B?aXMyajAxL1pLYmZPV3N6MEk4ODNML3VyR3BtaUVuNWN4R0g2SzJ2dVJaUHhS?=
 =?utf-8?B?Sjc3cEpZZWFKdXdmQmsrenJJakdOcGkrdnFrbXB2U1dpRWlLbndQRnhhYU1w?=
 =?utf-8?B?MEtRbTdOaWRHWTd5VDR4SUJwRGtlS2QxOU9LQ3FaeXRXNlV0Mk1yTmwzNEw4?=
 =?utf-8?B?OFdRc1pSZXpSUVR6VEJCZEpCRjBwYmxKT09vejh2WS9DMyt5Z2N4cytUM2FR?=
 =?utf-8?B?R1Q2U0tiam5qc0NsUlJvY1RZQWxhVGVJQ3RvUWNLWWRaeDltbjVKMVcvUmcx?=
 =?utf-8?B?VlJ2SUtZeHgvQTAraWlSamZOZHRZTndZYWtXS0hmZVd1WVNkMHNQKzZmWkoy?=
 =?utf-8?B?Tm8rS1RCcHc4QmJLRWZFMmZvdWF0aUdIZkQ0RytaZWlRR01La0xYWmxqTHVM?=
 =?utf-8?B?MGhoU3RSZ3B4NllKckV5c0VqQnBaZTk3dURVWmJKZUo1SWluVHNjRU5UaFFJ?=
 =?utf-8?B?ZHJ3OFRSaCt3R2hocnpTQjloMmtPTU9EMXJJUTh5RDlodUtLU1Q2RHVXQlR3?=
 =?utf-8?B?ZTBYODAwUDhtYk8yNUcvWWZ6Znl2UDBUS3J6ak1hdVV4RUlFRFdaRkxjSGpi?=
 =?utf-8?Q?P9ksNeMfwVwWpSsg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA662DA27B332E4DA1558B95C938AB19@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dt56ju7XqDgeDL61IyKqO1AhcivV1dJ3amEL4OKI3NOsMndL1oU8rp+609hMZzV1QywUeTly0vTwzToUGfLzj7H1COZU0kvMTjJ/3+GsUCLbdnNRyb22rYtjxEdDdBqW84alLG4RjeH01ugUCsx2gkgUVGHVFz+LWUUpYL11dKIODeIx7uFooRpKw3f2qDLLpp7VqY3RQi8qMEzYnMibQotG6IR+Fk7M5Sprq2Hci/+1VyssH7tQEcV5qP+PAwHNdu+CAyvxor2QcCbLicjB055IVbLpBRWGUEUjgdxyppfr9aN5K9dj6A3OCowJ/0iXHcEB2zyyVU69G7hMJFlhnA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16dc4de-ca80-4556-997b-08def98ce199
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 22:47:40.8484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SosYROHYX2oEpRADt2hKGAs0y/hvrnhtZCwhxYbn2JhWvYVtZKD/S1r/KS4esSWBMVKszAMspbVHkAiMFtm0e35UmKGqqqRedY/ws5yCQmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8864
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDIzOjEzICswMDAwLCBMaXNhIFdhbmcgd3JvdGU6DQo+IHYx
NCByZXZpc2lvbiBmb3IgVERYIEtWTSBzZWxmdGVzdHMgYmFzZWQgb24ga3ZtL25leHQgYW5kIGd1
ZXN0X21lbWZkOg0KPiBJbi1wbGFjZSBjb252ZXJzaW9uIHN1cHBvcnRbMV0uIFRoaXMgc2VyaWVz
IG5lZWRzIHNvbWUgY2hhbmdlcyBmcm9tDQo+IGluLXBsYWNlIGNvbnZlcnNpb24gdjkuIEZvciBl
YXNlIG9mIHRlc3RpbmcsIGFuIGV4dHJhIGhhY2sgY29tbWl0IGhhcw0KPiBiZWVuIGFkZGVkLiBU
aGUgY29tcGxldGUgY29kZSBpcyBhdmFpbGFibGUgYXQ6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9n
b29nbGVwcm9ka2VybmVsL2xpbnV4LWNjL2NvbW1pdHMvdGR4LXNlbGZ0ZXN0cy12MTQNCg0KQXJl
IHlvdSBhYmxlIHRvIGdldCBzYXNoaWtvIHJldmlldyBvbiB0aGlzPyBPciBkaWQgeW91IGludGVy
bmFsbHkgc29tZWhvdz8gSXQNCnNlZW1zIHRoZSBwdWJsaWMgc2FzaGlrbyBjYW5ub3QgZmlndXJl
IG91dCB0aGlzIHN0YWNrLg0K
