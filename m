Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8943890E0;
	Thu, 30 Apr 2026 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584225; cv=fail; b=qDN/CgPp8Zuz3DqniXY5cYnNI8fxi7FgpyARKC+oJTvk+9lakAcdILkdPF74V/Rn6tiL4QajeXTreb8e5xeduCsDUOxMpTTJOb28nd/phFyxYBMXDtDD3yTgAqQ/rWCDQ0OcMPM4QEsnJ03h2+cjrHecmpOTnNspqX85dJFTkTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584225; c=relaxed/simple;
	bh=wor9IJI2ShX3HJMKUOXUMx12bejlUPMko9wJVsDvmCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oJFTrkPwjqpYZ8X4eBmUmizHM2dPv+b3WmU7z+RhY1W6KS8GoxgfnpS3l3z84njqaL6EOp5feE0cfDQIBkZPLDj6c1FGQhgr4v6qvmZzm6z7GwXEZh6J0FDB5FyeOdo4hhsV1wHbGGcxuqN9kqbU9MUyI/Eu1d4WynUK0F0d1fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nvqew2/f; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nvqew2/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777584223; x=1809120223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wor9IJI2ShX3HJMKUOXUMx12bejlUPMko9wJVsDvmCM=;
  b=Nvqew2/fy9JfveRFhSo2vtEBl18tWqi6j3pYmhrMgu4bTY7iStA2Wgib
   zBQmtUDRPa5fuxvCJcZodQgb5O15NUqhbG0RDW7fsRRIkaWn6/6DauAbg
   van6hoSqvvyYQ337BBYmVNUsu7x5GnhJn8vSuTsjCV3coRXqrv6MXAfFF
   C0R9/fzChyiMgNYNp/XVV/PB5/s7EITEsGwSYkFsypQ7WCuhgzj56f8Zy
   1nTJg10JAxmXX6CzXSHqfUjIGEcXZc5JghsSSMgSOkO9nxBVUJg1ILSYo
   lDprRJinNE3AlYJ4q53bWqpqI3J0WeOFSGfHE0U8uJQx78fJV4KC54+kz
   Q==;
X-CSE-ConnectionGUID: m48SAmJITxywweMoCBtJZA==
X-CSE-MsgGUID: mp/widWtSzmWara7Gqp+zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89648700"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="89648700"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 14:23:42 -0700
X-CSE-ConnectionGUID: WtyT/VOqQxGsb8x8JuQHyw==
X-CSE-MsgGUID: +I+n1Ra4SEee7jelKyBGzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="230349415"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 14:23:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 14:23:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 14:23:41 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 14:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEZbgndzHHf9H43ocNEBLHxRVG08TKbEyamZGTPM5+NO/JmbE1lxE3E28I/Ckio+syq4AFWLn8o34ut7qGMZhcjSBjsy1vHWCLY2Krgx4RffHHV6fbmuxWIhBYqWKQ5i9A7NV0ogXPIWdE5ZWSWuueJP6KrMLQKLQ/GdJx33E2Z0IvPLpiF+71AJjZWRAq5L+DSdix6BZWqOOFDIzNM96pdggN2nbTpn/zCvXY4Ez0wOMQCDfvxApnXj2EpzBTLftWt9+YtJnCgmhO8+hb6n/+UpdY2YA2G9jr+xLbAkKKKJs8C+atmHBQpQG5CiWlJ92lzVM39kSWfzT7x2eXeCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wor9IJI2ShX3HJMKUOXUMx12bejlUPMko9wJVsDvmCM=;
 b=ALHnaa7671bONOdsDsY/V7QFViHthjPxsMwGbQi+vr0BcPR0W3mvBF5sYwvAsO0OQWAdKs2nILdy2KpgnJ5wk+L2ZbiV3D+IYPrp5xVnYRM8E6nIp9JpHn8NNtoIFoiM2/Htyr+wWoSwsAOvFeS5FF1OEJYVsXBnieq54ypi4L/qC7wx2xfhUji/n+DmFYV0GoWibt/AAd3Hh/V/aycn1/5jBX3HHBiVW/klPZ5uqYWWOEGWvf9JWH9gJJIMzvCshy+2Jr3QM+zXtn1nYRq1rM5r8lLmOL/E1an5j2p+dJKzdTbvuT1o6CdvAW+8N/0aSGjf6hx3tltIu+fashU62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 21:23:33 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 21:23:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Hansen, Dave" <dave.hansen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "Shahar, Sagi" <sagis@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v8 08/21] x86/virt/seamldr: Allocate and populate a module
 update request
Thread-Topic: [PATCH v8 08/21] x86/virt/seamldr: Allocate and populate a
 module update request
Thread-Index: AQHc1lq8spy0kSCipkax7ksdoXY0IrX2yKiAgAFZ0oA=
Date: Thu, 30 Apr 2026 21:23:32 +0000
Message-ID: <e4a12820bdb7fa8c2e97e028fc9a4b51e1baff1e.camel@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
	 <20260427152854.101171-9-chao.gao@intel.com>
	 <a52c4701-c99d-48d5-9b63-8eb1c0e589f0@intel.com>
In-Reply-To: <a52c4701-c99d-48d5-9b63-8eb1c0e589f0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB6285:EE_
x-ms-office365-filtering-correlation-id: 2e2be23b-5eb7-4d2a-7e92-08dea6febb0b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: fdtbQqgMA2m25bW/WSOJ2nNZxHI8YMfFy4btMexUr251rUHv1ccYD+aBlobxAQFqwZa3YzBpArC+j4EDbK4JQwP0R7FjOeZ2QqwcHbJ5jxOpuQUFoHpdns6+GxM68YpXMwohrsvZ9hR5F50H8uHbNlo/7Q6laO10S1Kbbd/j1Fq4yI17LG/x0IwB1qZXgzSj3XHkW3YOC9W9bDUUiMa1+EUQ17OTfW0WmyYMbZpswq81sJ9upq28XHCeljlfo3TFlNx/hZrm7pFGmLyT54bTkXBR4yFItmGPMMXlcOhL3/lYC5R3B/YFnsRzaTjY/AlPMcCmGQCDmGqviVLTjdg9SDGEKGIhQz9pJ1l1MNTPGRKF8MT3rTg3XIKXLgN3gNqyroI693oZ76VUqunDTCSu8YK/2Q7gXRy/S8jjIClQErGbGtuQSKMfj/ts7a9gEILlhKY077rl9Z213ksLGAySbJmKs1eTIpbbJvl6FihrTOOYyd45jsSAwJ+f0W33+r0g/2p68M+ETA3PRzYJAwXOuiY5ZpSIP/WqAtPre0dpHKxmxjbr3667IEo957IJrYKOUIzogDeKlAxj2/Ha4WPAYMZ0TC2leKf+jG7zWAXWGxShUdSafd5CcqMplJy6O2yIYaHvnoL5NZ9wEoS4qXeNnKwci8N6B5EPQ608lKBqGxSU1CQKwNIH++/6CyA1eBzULlE8iYnaEG97X0hHZBlqbr4JL+MdMV0haUiNM9G9hm6XLvD95yYHruT3FCTahSw1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0c0SloveHBJYWFFTTJPZmFlekFOOEx4cmJJM3FmQzhFb3c3Q25qY1hTUHow?=
 =?utf-8?B?SlB6ZHVnekJlYXpuUkMzWEJPS1p5RitiK3Y3cDE2SG1lc0I1WlJrZXlUNkc5?=
 =?utf-8?B?cFcwVzRoa3NHNjc3SUtmV2lkUTFEUlJPTmtqZmF4WXBsWTVBS0FpMXJTdUxh?=
 =?utf-8?B?V3dYL1g2dFppbWZQbWp0S2xaRFBXT2hUcGsrVjhPVWlGZ0dTRXVJb1hsZ1Vk?=
 =?utf-8?B?aWFONlllZEFZYVNxcTkwU1FtaGUrNlBERHUxWVZVR092L2NuNmxjMGV2QWdn?=
 =?utf-8?B?MVF4cXpVZ0UzZ0NObXZtWlp0NjFtTHFPVFFYS0haajdTbjVSNC91Uzc1b0sr?=
 =?utf-8?B?azFyMTJERlVJOG5LaTBITzdEdm96OVpDZXNOSGwreFEvLzVISFkyTVRqN0g4?=
 =?utf-8?B?MlA3SFNzN0pUVTNiN2JVSnNBNEdwUW5JLzhTZ2tRdWlUMFJZYzdaUFk4aXJL?=
 =?utf-8?B?aGNDZDZYM3l2VUh2TC9jOFBmeWhUVzN0ZkoxY2NNb2Q1Zm5QdG10OE5MaW1w?=
 =?utf-8?B?SndjMGdPWVFuZDM3ZEN1bHJvalNQVFIrQkkyb0g4SzJRWGJSaHFWaGZEVEVF?=
 =?utf-8?B?bE1DYS9ETGZNZC93cXpScTkyeDNVaXllSEttNUwwa05hRDRyRkk1RWJDQ2Rn?=
 =?utf-8?B?eUQ1dVc1TTQ5NTBPN0pUUVFpSzYvb3VHL3VyU21KZlhBQVR1WFlONjMyMWlK?=
 =?utf-8?B?UXlnZ1pKNTZuMHVaN25CejB0NUtMa3VvNjFrMEdFR1BmbjVIM0VrclpTVEYv?=
 =?utf-8?B?YW9iR0c4TEVURjBPVDY1elYvUXZwb1l6VTFKcW9BbEtnWGFFdXpIM0hIam5N?=
 =?utf-8?B?bEFIUWc0NGR0ZDNac0FkcGdYWVVPWGQ3MU8wbVZiZEo2OEY4NVNUY2VHS2Qv?=
 =?utf-8?B?OTNic1hVc2hhV3lGMkNKRTZ6NmMxOG9wV1dSRUdLTEVLVTVRQzlMYVhvY0FH?=
 =?utf-8?B?S21KQnNsYmJqYVdQZHU0ZnAwT3hkNEluV0pYS3F0ZXdnMTFyMFE4aVhjamdB?=
 =?utf-8?B?Qk5OY0ViOU9QeWNCRXNLTS9xaHZhaDJUZG5uOU5vVW1nRW5nRDJqT2ttRGdj?=
 =?utf-8?B?QXdHR085MmZlVmpqZEw2bUFzSS9Sbk5zNi9ETHBkMGNZU3cwWXd1Y25mVjhw?=
 =?utf-8?B?eWRHd1BURDkvS2YySU96VHZKd05GVEgyM0ZCTWo2SXJIcGtBZXlWN1ZkU0tO?=
 =?utf-8?B?SVpnTzlXbGVKdTdFd3psWXBTcElYK2U1ZHZFN2RldUVqRDlpNHJoZEJxNFA2?=
 =?utf-8?B?b0NJeVRldCtUTnJkbytxdzRJcGdKTnZJNlVzMm54cGNaak05NFptM2Z1SHZB?=
 =?utf-8?B?dml2a0JWWDR4UzMvWWtxaU03dXhublpBRkJ6KzM3ci9Db0NpZHlaajExVHIw?=
 =?utf-8?B?QXdId1YvQ2hrTDl5UkJhWXZQangvVTUrdk9ucC93a0pTdTZGc3pPTlZVSkpn?=
 =?utf-8?B?c1d1Z0xmRzBlK05RQTdBaUgwN1lUWFFneCtTbnM1d2RLN3czVzRLb1MrWUl5?=
 =?utf-8?B?M0hIbHYyWlFkaDlsRTJ0c0lQWGI3QW5GMk15MEtuaTR2QmhPL3pvc0VNc01a?=
 =?utf-8?B?Q1BsMjJrRW1pY0ZWU0crRmQ0WXphRi9jbFZ6NDhyVmd5MldTaC9uelNaTkhv?=
 =?utf-8?B?VWYvMEprTW1nM3hPdWNPWjAzb2RUblJxLzFiSjQvakdtV2dXZkRWZ012U0NJ?=
 =?utf-8?B?UWx4ZUxiZVhZOE02R0VGTmhVM25LQ1I1c2Frb2VuZkI4cFRieGtSWUU4aVdH?=
 =?utf-8?B?blBLV1NmbGxCNUNZZkFKWXlkQUd4b0VaZEgvUlVnQkdLM1E0Mm01QUxRYUhB?=
 =?utf-8?B?a3UyVTlQMWdvMmoyeXNvbnp2R01zUVN0MElWdmZOYjVHa3RUV1RkR3JvbVhR?=
 =?utf-8?B?ZHZ1TEpJb1dpa2hjaHJZdkNkcnVMbnA2UzV1Q2RQK2pERlFkaUZERTNtd1Fj?=
 =?utf-8?B?NVgzY3p2R0JIbGhNQ3RmQ1VrVnVzUWk0SnpKVFVyZ2tOVnF3Ynh4dk1GbUMz?=
 =?utf-8?B?Y1ZUOCtDNWpKbnpTR3BPa1dHandrWXh1L0QwMGNXQkpFeDNXUzRraDdIaXBT?=
 =?utf-8?B?ZElocUt3a3lCblIzbU0wcnBwWC81VDJpN2p5TCtMTktkd1dVQVhYdGxaSnlL?=
 =?utf-8?B?TlJKUWJzbHUxYTRZaTBEbkwwYW9UalJYTzlrdWhRRURkWEkyUmpmaHJ4OWdE?=
 =?utf-8?B?Z3VxSWVMb2xmOXAzcFluNVYxQWV1b1NvR2Z4VDZES3d2T0xKSlZhbXhTMFM2?=
 =?utf-8?B?dXV0VEFvaDl5VzJLazZYZFp2Z1ZycStmUy9HejRmcklXNmRQVXdxdVFoN1Fx?=
 =?utf-8?B?UEZhZGl5cTZyMm5YaFdDRzluTzlkUXRLSDk4Ykk0ZUg2VmhWWnFOVkRLM2lX?=
 =?utf-8?Q?kGW8zgxY55X8kDIc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03882C1CECFD3940BC1FA265E15EDD6E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o2sNTy2YxjEWeb5wiAX2wUhpW9lOT9FkclrnJgLfaqowqjhXBWx66bMLmqN7aGZ9WRb1XkIOwXkFSvb3b5itwuRt5/KOCsupcdgjndfT3LguX10eT9kfybPxOE0oR/bqSrf2XhsouhuRn0ykMef8yLltULizWWMtDZpk/C8OBiQMiZ1P3Ck91GCNVJNQbzVrzPxcibfDefzPXYhwXt8AG9spvRcNJVdn9E1dtLdMujs/cMq0Cxy8jfWx/vuJoC3GoiU50j+Hz/ONFxZ1ZP4lmKFMIyxzYx1oGu7rTG16eru2scRZgJDXwta6vCoRz7MgICg7uEIQLcpU9UGl1NpnYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2be23b-5eb7-4d2a-7e92-08dea6febb0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 21:23:32.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0TxhmPgcnBDH6HFd/l+cKbDKgiEMP5WjVYPCwl53gJdK4sHnJ1UfW0A2IxmxTLfmqTcQyv8kE04i2UBJg9xdwd85ebQFrMr1saIdzjkE2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTI5IGF0IDE3OjQ1IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
PiArLyoNCj4gPiArICogSW50ZWwgVERYIG1vZHVsZSBibG9iLiBJdHMgZm9ybWF0IGlzIGRlZmlu
ZWQgYXQ6DQo+ID4gKyAqDQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL3RkeC1tb2R1bGUt
YmluYXJpZXMvYmxvYi9tYWluL2Jsb2Jfc3RydWN0dXJlLnR4dA0KPiANCj4gSGVoLCBzbyBVUkxz
IGFyZSBub3QgT0sgaW4gY2hhbmdlbG9ncyBiZWNhdXNlIHRoZXkgZ28gc3RhbGUsIGJ1dCB0aGV5
J3JlDQo+IGZpbmUgaW4gdGhlIGNvZGU/DQoNCkhtbSwgd2UgdXN1YWxseSBjb3VsZCByZWZlciB0
byBhIGRvY3VtZW50IGJ5IG5hbWUuIEJ1dCB0aGlzIGlzIGp1c3QgYSB0eHQgaW4gYQ0KZ2l0aHVi
IHJlcG8uLi4gTWF5YmUganVzdDoNCg0KSW50ZWwgVERYIG1vZHVsZSBibG9iIGlzIGEgZm9ybWF0
IGZvciBkaXN0cmlidXRpbmcgVERYIG1vZHVsZSB1cGRhdGVzLiBJdCBpcw0KcGFyc2VkIGJ5IHRo
ZSBob3N0IGJlZm9yZSBpbnRlcm5hbCBiaXRzIGFyZSBwYXNzZWQgdG8gdGhlIFREWCBtb2R1bGUu
IEZvcg0KZGV0YWlscywgc2VlIHRoZSBsYXRlc3QgVERYIG1vZHVsZSB1cGRhdGUgcmVwb3NpdG9y
eS4NCg0KDQpUbyBtZSB0aGUgY29uZnVzaW5nIHBhcnQgaW4gYWxsIG9mIHRoaXMgaXMgdGhhdCB0
aGVyZSBpcyBhIGZvcm1hdCB0aGF0IHRoZSBob3N0DQpoYXMgdG8gcGFyc2UgYW5kIHRoZW4gcGFz
cyBkaWZmZXJlbnQgYml0cyBpbnRvIHRoZSBURFggbW9kdWxlLiBVc3VhbGx5IHNvbWV0aGluZw0K
d291bGQganVzdCB0YWtlIHRoZSBmb3JtYXQgaXQgZGVmaW5lcy4gU28gSSB0aGluayB0aGF0IGlz
IHByb2JhYmx5IGdvb2QgY29udGV4dA0KdG8gaGF2ZSBhcm91bmQgaXQuDQo=
