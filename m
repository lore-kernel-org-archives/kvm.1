Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BAD36680D;
	Wed, 18 Mar 2026 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870015; cv=fail; b=bnW0S1Q+/+aTkmgXyKqMctzT/C6jEORuyMly9LP0Co/hjKkpHlRU4bOkR0u1EfhBtDK4+Ib6po1NRDnfDCPIs9mbLRuwNDCbutAuA4JaLq3/hR6TWf9g4Xn2Y65PJQWKzcoGDtH1zz5iPKlxtdpMdvLkD7SfL0jQzyftPZ+klUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870015; c=relaxed/simple;
	bh=y6VF9mRjkslOOCO3yR/yT33h1pde/62VtMbgmLvR8Ec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sBzA3GtGZniyteLcQGRs2q4rttxGPGEcA6PoisWxHPsBNo+j2Q0TBZQwvmozNNVgM42DuW+cGNXlJ9YFdueoFkK7IF3cPix0673/hm5i3QhFAtJKJv/ZcLKCYwqGBNb3eFqP4QODZn7QpoyaomGpLHsxYRGb/AjNqXXf217iPZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aq77EODZ; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aq77EODZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773870013; x=1805406013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y6VF9mRjkslOOCO3yR/yT33h1pde/62VtMbgmLvR8Ec=;
  b=aq77EODZASYzD2811ACq7r7xtoepjA3Nx3wA79DBnmhfEvGLu53pYsKL
   l/KKHMzxZG/i0DdsCThAo77NmqhmEEmCO/sQehGUNvMFfy0MkpSzxPr6c
   cRLYGPBNWNbwo2iqkT3XVci8tn3S50g9g13KtWt0X2qqMi4AYbt3NsxcH
   +0B7egD/MfNfFdl4ygKH+SR2MZ4LwCdQ2ZvbA4eCTdumnstQ+diIoV3cN
   VORazqLsz/WUuestNcdD6am7zux9PeaMTKwT1/xjo672wdC/sp0vDm7Vd
   K0IkEp73QeOF6AJWNLNucqDzefg3dMHpxjPA8tovIYsET1J1iSMGvpJBp
   A==;
X-CSE-ConnectionGUID: EpDFi6hVR8K+KBPR60jwjw==
X-CSE-MsgGUID: eGpncZGmRc+HNyafJlsx8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="78797026"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="78797026"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 14:40:12 -0700
X-CSE-ConnectionGUID: RZzB+cetQwSsZryHempLVg==
X-CSE-MsgGUID: 53AWiBcvTmmYLZ7/xj9FNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="220179676"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 14:40:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 14:40:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 14:40:11 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 14:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7THMvnuivxeog/v1uXXeG8tSSxjH2oyWtTMPV7QT7s3IHTEVFQB4wcgO7XAE4LgxSniUxDK3SlazK3nSBWIBFZ9/HjRbxxVt+jE1chD5ZcYRLh4fq9QoJphBhn9w5huLgv7LQBiolMRyt7LmtxKDEiKmB/mRigJHfnKuSF2roKt5f+h8yjsDvqsTgi5/TLi7pGj9Oo/uxmdfLUzMhee8IG9ZVN1S1EZAUUJs89xly+NeqW9gFIgysP+f07Clw2qMa6G6VTb514TRwYnPc/K6IScJXTV77bQjQQ4ZQnraxbtm1On0hNzT1gLDhUk5jEEMX1CUzX0HvrssBEeg6bL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6VF9mRjkslOOCO3yR/yT33h1pde/62VtMbgmLvR8Ec=;
 b=Jn3dPQLdTseZ4E9rpcuvEW/yddRrViemmEmE9qEQ/J3fnB4iAfIEolP3139H73Tzl2ehGTBqgSY2D2c4qY5uzbKmcF04jd6BVIduNxM/O3yKcOORO0/xZLWTFEHwsw60DcdZgUm7j1qrMg0G0ULdBNCDydGt8S1Z5gJJUD+dO9eybmXtISLbZFkiPV2HuhNS71AdL7jN61t2bfpbjMYt8KvnFcSdOte3/UGjVLNlth49HvWoN6053sGCJKomIxJkB8m6ayUfeqoOfPs9X6FiQXXVHjBdkKcPZUpRLgF2QfKq99nHQHLi6NYKtM6VubiZJhZ36BWi3MmR3dBG3CjTzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DM4PR11MB8201.namprd11.prod.outlook.com (2603:10b6:8:18a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Wed, 18 Mar 2026 21:40:05 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 21:40:05 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v5 05/22] x86/virt/seamldr: Retrieve P-SEAMLDR information
Thread-Topic: [PATCH v5 05/22] x86/virt/seamldr: Retrieve P-SEAMLDR
 information
Thread-Index: AQHctIP8rRVDim87nkaP83JITdv2NLW01oUA
Date: Wed, 18 Mar 2026 21:40:04 +0000
Message-ID: <f48929337f7ff9b37b17435ba7414e5d6e7e52c4.camel@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
	 <20260315135920.354657-6-chao.gao@intel.com>
In-Reply-To: <20260315135920.354657-6-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DM4PR11MB8201:EE_
x-ms-office365-filtering-correlation-id: 11d7ab12-a352-4b13-dcbb-08de8536eaf7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: tDvDo05FoZdxZh2HPfQK+XSBuE9eIatBTzBdrlPeS4gj44pnjSjQ5KXIBfQfz/GdEGr8xEt0vxlKJAIfuhGk42RPxbFX/QFmF3sRnxyy4ElCljges7+mxHmdNA1SFYcK0EJtRQm9Bm4no3PfMLzu8JJmjvBKrfIPFx1SPSKUolJWs8TDOr9jB4g+A4qysUt97kmm6mWj3RdQkOdVSj65HKUFpPFgh0wc8J5Qnv9QZm9UGq/H9rRDKeMX6+/TUIxPu59jo0YJtAwCj3b8IRY5rxzDxyiPEV7DIbZJBe+Zuh5HZ5trPOc42vKgN8ebRWkQLHpWuUE/QuZ0SX5al9gZgQQ54g7j7p0yQRLkW9PsEx2BKMHmMRA9svzoLCoPnVV0KetoYv3UrakxT3mV3TxAHJPnug/h33ubiTMd1Fw4ywtCSZJrD4danMJaeStRsLAFrGuLCHdkeP2gZ3BgINCdlu0U7HyN+8rOoIJRFgKvX/dHaVIj0DEMrHiCkxVWqbzMVPFvsGcAxnFcoQv4m9432zqpzqwUyH2rCGS635wU7kFyDCcBFu/vUNfnZJoIEPA0M/9FOKDffH0g31L9POjO0IZt/DtmrmpoIB32E8EEFtuRGs0WkymjVKapCD0Mq4GC3pj+TBXvdA2Le6RMn3dWOglbqdykMhBTy56wkdZMoqlqBl/epomIiqy+DrzfoNeDVNOErrQOGkGNEEFEOUfbyULkeElekG3Om1rpLEear+x4uD14+f6A2tBhjcVf11zwrW2qXd43DSeHhpq7uYpy1QkRWMfnU/A4UxGNQ/mYFTk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0tadnJ3MjdaZit2ZFZxdFhzU01vTGRFb0JiSFFQY0UwVzVTTTNobzRTMlBH?=
 =?utf-8?B?ek1vMzBSMlRTTHBDZ0tOTk5KWEJ3UDQ3RzhXQkQ5d0FOdjJha3V6c2o5WjRn?=
 =?utf-8?B?MVhsVEVTM1ZvMGZlS1lDWERtWDg5SGkxeHkvcEhsZHV4eG85UTQ3Vk5hZko5?=
 =?utf-8?B?Yk5PdDZZcU9BWVU3NS9OTzB5Vm53WVgvRkxkZ2tOU2lrZFhkTlZTQndJMzV1?=
 =?utf-8?B?U0srbkw0akRiKytjRDNjZGxHdURNeW9uTFRUTTk2WmxmM0RKUHdWT1JES0xX?=
 =?utf-8?B?cHdQUHBFOVRBeUxkVzhPMWZNYm1uWTVJYWVXdERqeDZ1TGRpVkE4ZDVtRzlp?=
 =?utf-8?B?cHlyY0NKVmlqdTNZR3dPWnhsdDlxSzBmNGM2UU9yY0h1NVI3ZktwSWl1Nk9F?=
 =?utf-8?B?OVR5T0x0N0h3WTlBWDRybjFrLzMzMkdxTXJTZmpGdmFRSjRmbGdVeW9ldFFM?=
 =?utf-8?B?OTF4MGNoNXpXNDB1UTZ5MDlIZ3h0TXlrNEM1ZkxlY3Fza1ZvUC9WZjFyNFZk?=
 =?utf-8?B?eUh6di9vSjBVaW9SdjlOM0ZRRjh6ZGM3bEJyTExiKzdyZ0h1TVJrMDdoNU44?=
 =?utf-8?B?S0pIZFM2SzBkQk9ua2lPK0ovSHVIWEZxMnFUaEE2Wm52K2d4V2w3aEF5WE5q?=
 =?utf-8?B?cVkyNHI3RUN5Vk5JZ0dPNkJsVUZ4LzBHV3Y1OEhTc2VKT0ZjS1c0a0tMZEhh?=
 =?utf-8?B?YlpJcW1hdUs3U0wycmMvd1J1UG9pNkZmTE8xeW1oR3JLcWt2WWQvbjhpR0hw?=
 =?utf-8?B?K2J0MVR6UDJQdS9CbERBTG11akV4RFdOZEZQTWxSK2l4d1NCaFo1eFFRK2tz?=
 =?utf-8?B?WEZiRDRTMS95UERGbkt4UFZvdmxqRTZNank5dlVDbGtkNitkQmlQaU44Tlpr?=
 =?utf-8?B?eDg2RFFLSHF1aS8yWXJ5aUw0YS94Nk9GKzRjYzdWUDlJNE9iVkV6YzRDTDBK?=
 =?utf-8?B?TSt1eDVkZVJ5ZnpHdmVJeGJaaDJiaEFMU1ZsY1l5dCtKUEpJYWUvb3lVaHhh?=
 =?utf-8?B?UHVGRnRueVJQaGhTVCs1L3ZDS1ZNbmdaUTFiS2R4Rlc1NTNZK2p3VDNUYWdR?=
 =?utf-8?B?bUlsZ3hOcmp6ZytWMWF6SGRCbWhPcmpNNUx4WTA5UE9XOFBqOCsxNTdyR2RJ?=
 =?utf-8?B?azlPTk5ZbklyYUtGRUFGQ3UxTXFqL0U4c0pQUW1GQWpqeXFXV24wQU56RmFQ?=
 =?utf-8?B?NDhqTURSVWk5VGxNZXRLZXdEeXY0Y2ZkcGVQakNpbEJlZGZ5cWlIU05TTHpk?=
 =?utf-8?B?ZnlwdFlxWTRsZDlOLzdOdStORzhDMFJ4Rlk0N1ZqQS9CZ0U3czJaQ1FnYlFD?=
 =?utf-8?B?Ni9FTXA5WUtFL3FrWlB0SHVNWWhhWnpUTFFrVUtmRmdQcjYySVQ4dVNWaEk2?=
 =?utf-8?B?ME1tTm11cEdyMS9SZ1J0UVhIc2pmSEkvSFE4L29tMHF0L3ByZUYrNVNyaEY2?=
 =?utf-8?B?czZzaGVVcmI5ZE5kSVpGRC9aMWgvc1hvMXNTYzk2ck9NaXVkWk5ObEVxN0xV?=
 =?utf-8?B?MzRVVW12MUEzYi9PYWV1eVVWYU1HamV6YWJnZU9xd3FSMVI2b3BNSWZvaGV4?=
 =?utf-8?B?emsxRkZGaEV2ejJJcmtPY09rdGZGbmNTYjdPbXp4ZVl4SS90eXFuSDhSYlRG?=
 =?utf-8?B?QmdrYTJta1l1K2ZGYmNvdU81OGJYS2REOGdsQnpSazAxVG5qMmxxY01sN0pp?=
 =?utf-8?B?U0lDQmJjY3dVQy9TbkFYcWYrQ2NUOW1BWXVuYmxPbWhjZC9qam5uT25TZWVQ?=
 =?utf-8?B?N3FQbDNnNm9PSUFHaXBhUGJpcm1mcVZDeUc0TnE1N2NQd0xxVEJDL25nWnFK?=
 =?utf-8?B?ZFJYS2pOZ1MxK0J6UjZQdmxzY1VBRGxCam9PS3p1TWpxRTNMRHJhTTNmcjZw?=
 =?utf-8?B?d1hqTlExc2czQjJSTEozZm5FZkxVUmpFK0I2ZGtsazZzaFQ1SFdVWVpEOUNC?=
 =?utf-8?B?MlhyWk9rYXVGTmJDZllpelBKZTAxUHlONERXREJZMmZMaGUxUHk1Ukk5NUI1?=
 =?utf-8?B?MHF5OVdXN2gwei9nNHhpY2IvS2RqVGxkdUlkR1hSL1dxMWk3ZEtuYWV0d0pV?=
 =?utf-8?B?ajhvVXg5TFlDTTdWSkZTcCs5UzljOXFLOElMSEwxT1NMZjdHRzFQN0FycEJQ?=
 =?utf-8?B?cEFNbFpsSXBRNlVHdUFFYkxlQ3JlYmF6WWwxVmoyRXRVc3RlL2JPT05GTGZx?=
 =?utf-8?B?MStqeGltTnk0N0FsbXltOG81amJhVUZWU1IwMHNZUkxCdHZCb3I0dTBQbFp6?=
 =?utf-8?B?c1dDR0JyR3NjNGlVMVFKNFlDKzRsVFBkSmJWa240cTZWc05EWWxHUWFOK2Vk?=
 =?utf-8?B?cXdvVUZ3Qmk2UFlyTU9neURNcWoxbTl6V2dSWXNLci9ibVVRU0Rzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6ABC4F87A746544E8F3A8E13BBCDDA7C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tqIgjhCVkCS5js0QKx/DM1b65iKdm1dO/tmvUOXzIMxQRmC7ALW6JSJNpl3V1asZs8hs/Q+O6ATwFKcqKXod/1yQrXImxpw5eDoxX8yfwS74pOyPeMMFw8v8yT1xvKyLTfhFNkZaik4pweHSQfa4efNXaImZITfFKXFQ0ho35yhL837m1UCcbpfHvVOg3HaskNtUxEROVn2K/FhUg/jCDh0FlFPBTWRy+FXMIcPXXRZXF1SmYbqnpvLAzW9XMdYVySXA6yyW0+Oqv8b39J43Nd4ysGDf1sNO132Vsn9fpWyQX9BoeXPnn9xMPYsbLMBs/vxD1h/goeuqfkZU7qQ8iw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d7ab12-a352-4b13-dcbb-08de8536eaf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 21:40:04.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fI2OxeAev5Bf13+MjnOa1RwL6Uet/RIsL7LliIjQo+n5Hbt3BFsLQjdHzOOwhBM812KIYD7vurhX0b1Wa4QWCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8201
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTAzLTE1IGF0IDA2OjU4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gUC1T
RUFNTERSIHJldHVybnMgaXRzIGluZm9ybWF0aW9uIHN1Y2ggYXMgdmVyc2lvbiBudW1iZXIsIGlu
IHJlc3BvbnNlIHRvDQo+IHRoZSBTRUFNTERSLklORk8gU0VBTUNBTEwuDQo+IA0KPiBUaGlzIGlu
Zm9ybWF0aW9uIGlzIHVzZWZ1bCBmb3IgdXNlcnNwYWNlLiBGb3IgZXhhbXBsZSwgdGhlIGFkbWlu
IGNhbiBkZWNpZGUNCj4gd2hpY2ggVERYIG1vZHVsZSB2ZXJzaW9ucyBhcmUgY29tcGF0aWJsZSB3
aXRoIHRoZSBQLVNFQU1MRFIgYWNjb3JkaW5nIHRvDQo+IHRoZSBQLVNFQU1MRFIgdmVyc2lvbi4N
Cj4gDQo+IFJldHJpZXZlIFAtU0VBTUxEUiBpbmZvcm1hdGlvbiBpbiBwcmVwYXJhdGlvbiBmb3Ig
ZXhwb3NpbmcgUC1TRUFNTERSDQo+IHZlcnNpb24gYW5kIG90aGVyIG5lY2Vzc2FyeSBpbmZvcm1h
dGlvbiB0byB1c2Vyc3BhY2UuIEV4cG9ydCB0aGUgbmV3IGtBUEkNCj4gZm9yIHVzZSBieSB0ZHgt
aG9zdC5rby4NCj4gDQo+IE5vdGUgdGhhdCB0aGVyZSBhcmUgdHdvIGRpc3RpbmN0IFAtU0VBTUxE
UiBBUElzIHdpdGggc2ltaWxhciBuYW1lczoNCj4gDQo+ICAgU0VBTUxEUi5JTkZPOiBSZXR1cm5z
IGEgU0VBTUxEUl9JTkZPIHN0cnVjdHVyZSBjb250YWluaW5nIFNFQU1MRFINCj4gICAgICAgICAg
ICAgICAgIGluZm9ybWF0aW9uIHN1Y2ggYXMgdmVyc2lvbiBhbmQgcmVtYWluaW5nIHVwZGF0ZXMu
DQo+IA0KPiAgIFNFQU1MRFIuU0VBTUlORk86IFJldHVybnMgYSBTRUFNTERSX1NFQU1JTkZPIHN0
cnVjdHVyZSBjb250YWluaW5nIFNFQU0NCj4gICAgICAgICAgICAgICAgICAgICBhbmQgc3lzdGVt
IGluZm9ybWF0aW9uIHN1Y2ggYXMgQ29udmVydGlibGUgTWVtb3J5DQo+IAkJICAgIFJlZ2lvbnMg
KENNUnMpIGFuZCBudW1iZXIgb2YgQ1BVcyBhbmQgc29ja2V0cy4NCj4gDQo+IFRoZSBmb3JtZXIg
aXMgdXNlZCBoZXJlLg0KPiANCj4gRm9yIGRldGFpbHMsIHNlZSAiSW50ZWzCriBUcnVzdCBEb21h
aW4gRXh0ZW5zaW9ucyAtIFNFQU0gTG9hZGVyIChTRUFNTERSKQ0KPiBJbnRlcmZhY2UgU3BlY2lm
aWNhdGlvbiIgcmV2aXNpb24gMzQzNzU1LTAwMy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYW8g
R2FvIDxjaGFvLmdhb0BpbnRlbC5jb20+DQo+IFRlc3RlZC1ieTogRmFycmFoIENoZW4gPGZhcnJh
aC5jaGVuQGludGVsLmNvbT4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFu
Z0BpbnRlbC5jb20+DQo=
