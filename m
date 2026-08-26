Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6413161BA;
	Wed, 26 Aug 2026 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761445; cv=fail; b=gboYhP2QtBDtA9N6qPu6eYKhGt1MUofooyqC1d6/P5fO9JpfcWtvqD8+l7/3b6ukOowiHuSWYMibzGFJ2mWhWB9pNNVfAJrHWK80ja4UjIF4kppu5neGl/jzqK+elVSceT+Pp3n6Ga4yc3y+apOqGuBEgAO+F3qoyWl3uysDjqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761445; c=relaxed/simple;
	bh=gt1nVYl+/t4TRlhfKPIN6NJsNi6Z+eG/dGWK7M6LuiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YXOkKQgEhSU5cz0eSR7Ke5r2mpRHttwwHueT9dMJveeiae6T4IELsslEpb245gkARPF2cBoBaHP2RDqAfNauI/17mx/UKJv4M49EL5JsXi9Zipy9QZqG6T8KgGfWaGO2+eK60kXn6/fb8VX0/gbEQ89VO4BNJ06RVcyHk4+cRTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTO+7blh; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTO+7blh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787761444; x=1819297444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gt1nVYl+/t4TRlhfKPIN6NJsNi6Z+eG/dGWK7M6LuiI=;
  b=KTO+7blhfjy1lIZh9pNbsMgn2tK8xSGNU8XYAWpG4v1hKNf+TmzzyKYl
   Ci8SwT34E9QyXfaMaUCGR4T1zHsDmbZid65vfpoZV+6HmzBu8SUh6MgNj
   P0i1SmyS+LCCj8UpVb7zcihX4Xhr8HnwzpnZ/vNejqtWNq/m9nVfgoZ5Z
   fzp2UnblfNpaNTkXL46gMn6xMRPJS4Uff7q/3aAtdT5a2iAFqpNwyEXbU
   GsDoVMJfHesmmvzcXgZcMlgTQMUZqDIgb9in6yypsmUtyIU7ht9WUX4ez
   JJH7pgQ+5is4jMcJoDxrxP9IvOn5uceQJu07GSsBTYUuzAjxoPOt9pzGf
   A==;
X-CSE-ConnectionGUID: hPhHvazVR1eB/gwBRy/5mw==
X-CSE-MsgGUID: SdO/kne0QtWowXLTHQDoHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="87378689"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="87378689"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 09:24:03 -0700
X-CSE-ConnectionGUID: XShLTOG6TNarXHBuLOYR5A==
X-CSE-MsgGUID: vmiuWuFWTcGijL9Z09CBmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="291144351"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 09:24:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 09:24:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 09:24:02 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.45)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 09:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhyHE/nFO4GNCvc8G97twQr1nEno0QSpR4heSw0KhpIgS+Z1qeJq5J2Ze2gUewyWq+ortNd29JjznuV0hgtbOXyyb5DVL5YfwlaO9bTHdAip7eBQY8I06smvIToed8dhZ02swxpu/dMoF4vbxQkaYfaAUMSW9NeHPkWVF8vmMi33KQ+WfLc3QesllzttQg5IVPKs09qJ7Too/7Xcd27e6amwaaJOwX7DdoXn9RTHTRELMFRi+29YIkiTSYD0OtgAP0rBrci7UQrReYUUdaU/4Wh98lumxReH+5aOvy6RZYxJQzqpKbN+21gSEkyaoWDmbDwZtGuSrPfpf73VYqOThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt1nVYl+/t4TRlhfKPIN6NJsNi6Z+eG/dGWK7M6LuiI=;
 b=iutR3VrfAtwe5CT2HqJfj1IQV0Hff4hFgXp41FXKrr/lIJmo7XcsAM5BVZ/Y85VMxAyV0MvbwsT4oSar57xN0Twify88tKBF3Glj/Jsa85oxzP6RDRwNENTYAXuVja6KE7y3cSUjPQInQwaaEY1pflpF2oyKvNAMfbxikDHVrNv5c1SDgsSdAQnE205riE7bHam6czeEkjHv1aaui2TZCIG3GIO8SJlv2mrqyXGG5p4HFEp0LKAyVlfez8exihrpytxhWCFXMUcFv/DJoc6BmwgMUdZzMyr/0roIzmIJAf44JgoHC/iUs105dHDNzVcHkAoBszQ0cMq6PCcBAuAwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Wed, 26 Aug
 2026 16:23:57 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 16:23:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "sagis@google.com"
	<sagis@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH] x86/virt/tdx: Warn on !4K level in tdh_mem_page_aug()
Thread-Topic: [PATCH] x86/virt/tdx: Warn on !4K level in tdh_mem_page_aug()
Thread-Index: AQHdND1FpRR2p2rutEOa7iAk6ZY7/rauw4GAgAEreICAAGHigIAABlWAgAAu6gA=
Date: Wed, 26 Aug 2026 16:23:56 +0000
Message-ID: <14ff9d8dc8fe6999fa8a4100ea9fc833fd7a9c3d.camel@intel.com>
References: <20260825025533.25663-1-yan.y.zhao@intel.com>
	 <ao2ZH8dmkPfBDnGv@google.com> <ao6UVdWNbhQaAFsm@yzhao56-desk.sh.intel.com>
	 <1e77b1f6-0491-464b-b79f-ca756a73e7ea@intel.com>
	 <26df3b906110c060d996ae8e79c4c1857f16f187.camel@intel.com>
In-Reply-To: <26df3b906110c060d996ae8e79c4c1857f16f187.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BL1PR11MB6051:EE_
x-ms-office365-filtering-correlation-id: ff4178c8-1b64-4ebe-d424-08df038e6d70
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|56012099006|18002099003|22082099003|4143699003|5023799004|11063799006|38070700021;
x-microsoft-antispam-message-info: 43LJue2Yeql2AX4phVOg/priHreoD5ImaoCty26DDyhJsS4d+77K1H3Gz2/6V8vbyE9t4H1MeXYjNGzEiy9U2gJsBfBcDtMPa6/FgGVUQTgsURHgcNOHKNQ6NVRwCqnC7HY1sPQewZz7JLfAzswQm5LXYs4s5GFZm1CZHR4q4m5bMdOVtbV0EsDFv/3W1SzvMHMIWnkrUlVUmsUFNdgq/33HpDtZQ7XR7jjJcPHOoDhIpeglO92wDGHBHP0AY4MX61N4PqlzUXQX4awY7Yx+Jk6NOq29zcilu1G4NEWQYoUEovx5oTqu0RKKQxnuomSFD/H/lc/ONytk6s1+sR26K6lSsKkzJjVoPnqmWq75/63vG6LNjvhSI4PVWxWe95/qYOuAs4KBRxLcNihXuuUhdsW8URAiXW61V8UQIc9X8DNWrzw1uMaZh5lz6NeZ8VRgreYhbXHSSbr3Ta5B6sUFd29T6RWiElOA1Jxz4smISPjp2anVfhEbV+p7cok+LJABmjYHT8Yz6mE5jkE09eI9nFSM4FDa6YY+ovGmYX/4UNSdJnLWRZsW82Pt4nCSrK5PpYOEgeEtVeynMhAPmzWFaf1c9jnwxYSu++sJy9I6gaqsXwuRWjIwC6D3ZrZIel59ha9QorWrpJwiBNUZowJZnCxYfIrt8q9YefeSsoAXMKNjC/p9OG40JF/hFNrkOCfP4kWOdw58+gyBji0uOIOZmFIqHsevP5fTczl92TsVz00=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVVadnIwbm45K01aT2tjQ1NmaVUzd01VZGlYdHlscFZrcXF4ckMxQm15ME96?=
 =?utf-8?B?Qm10VGFUemtMcXRCcHpLU1BISzh0enZ3YlNTcDNwekpOeitTSEdpL0NIYUtO?=
 =?utf-8?B?b1JoaTZ4amJ0TUcyNUxKSVIyaDdWMmFSTFdtME84Wi85NjNQbUN1T1ZGRzhK?=
 =?utf-8?B?RjQyaHIzOUx2REl4T3gycUZCNTJ1SHVtNUY2YnFhR05FMW5KNU01R0xIQWJS?=
 =?utf-8?B?Nlk1Z3dOWEFHMzM1VThoSStGcGp5L1hrcmxzdWpZRnE1VnEvUm1wMENUbVpN?=
 =?utf-8?B?eWZYdlBZTmFJSVp0YkUrcUlKSUtycmtnN2ZOZDRMeit2dFU4SHM4TXNxVXBT?=
 =?utf-8?B?MUkyU0JYN2UzR1J2MVVBVXphY2xreW9KM2lieGE1ams1WktvcHJmZjdQa2Iw?=
 =?utf-8?B?cGllM205NElwcXRERHpqK2xPMXJzVit1Q1NWSHU1MTEyK25qbkZHK2hCSnBX?=
 =?utf-8?B?VXNGTjJyVUFvZE9zZm1qUGRYeGhWRk9vVWtJMEJFbnoydjZocW1uUENKTzJz?=
 =?utf-8?B?VlMrUUM0UlREb2QvMXZpOUZGQ21iWU9nR2kyQ3dzRnBXOEdZRlZVMGltK2FZ?=
 =?utf-8?B?emNGUi9YamZwUjZaWjB6K0EzLzFXMjVCUmRpS2hYM0thbGYyNmZIbmUxQXlv?=
 =?utf-8?B?NkZBdS9MVVBvVkh0blNickloRDBYUm95eHlkc3ZVZjJQQkdVTENhakRYV0pC?=
 =?utf-8?B?T1FEb211TDlrSkkwYjdiZ3RtYytma1JiL0o5bnJ6UjZyWTc1MXVZUTNxTFA2?=
 =?utf-8?B?NENwWUw1TDJneVoya3hzdVd2dWF1ZWdHWmRmRWRpRUsyRWFyMjZMM1VQSWtF?=
 =?utf-8?B?TkJRM1pFL1NLbW1HbkFjbko4TFgySWNaVjZVYkJaVmgvTlJ2c011YWZJTWZz?=
 =?utf-8?B?Vms0a2xHV0ZQWjc3bXRRQW9iZm5LZTdnVkJsZ1BGR1FuSlhlMGxDSE1kc2oz?=
 =?utf-8?B?T0dEMFNHNzNyTGJ0VUhvZFpWSzFPWW9nZ1FBUEFGSE1tWU9FUDdFdmVuS3FS?=
 =?utf-8?B?alNVa3hWaVVLeThIRTlFV2ljdjVuRERCK1BzcEhhQTdlSWY1S0Fmd3hJcGFj?=
 =?utf-8?B?OVN1U3JMNjdaS3Fwdm9MNFdCMjVpaWFJSitXNUN1b0hSSlJZSXRHaW5ndGRC?=
 =?utf-8?B?eG53U24wc3RaVndFSjZLZGlpejlKY1NzK0FNaktMclR1UC96ZDdJd1BTQUlp?=
 =?utf-8?B?WGhUVFhaNmxmemVidnVpb0loN25kOTRqaWdMc1E2eFJvRVVvem85VXpPVmcy?=
 =?utf-8?B?bC94TXI2dGd2dkRjWCtsTlJYNVArT2NWNzV6N01WVUZyTmdEUXZIeDlzeDhE?=
 =?utf-8?B?Yk15T2dmWnNBVFZzdGUwcm1yTjNreHVyRWE2Q2duNER3TEYvRi9lU2NqdEtF?=
 =?utf-8?B?N3lNRFJjeFI3aFRPYTJaNWNQVW00ZEpIbnFvdlNQUWFjNW9LREc2aSttQStz?=
 =?utf-8?B?ZzhZc0dHYUJEY1QxRWdnKzhUazhrb2NOd2FHWkdHU24vNlVyeFhWeFJjUEh1?=
 =?utf-8?B?OXE3eERab3hsQThicjFIaU9QOTZXcFVCdkxQbTd2Tmk4WmU4Wi8zeHRLNlZh?=
 =?utf-8?B?V2VGOHkzQ0tES2JqMlNMcGxYODV0MzFDUE1BSDY1Z3RVTm9vRkZiQk8xN0ZL?=
 =?utf-8?B?cmN2dUpOQkxLMGVYeWk3TWZlWmp1Wk1Ua3cvZEs2c0xMRW1qVkdJNC9BTk11?=
 =?utf-8?B?bG5QRUVEamZKSEd5WncyWXJDMytEdnpxN2ZwSjFwRVhHZzNwUW1Xa0x5SDZr?=
 =?utf-8?B?S1U4cG5FMFlhT1RjR2NxMGd1eEIvRVBhY1g0NFl3MnBXVFhZS1JOOVRvM2Fq?=
 =?utf-8?B?bzJhUmF6dFpZUWF4b0kwcyszQS9iaHhzMUVSZWZBSVVrYjVLcDNtbTgrRWov?=
 =?utf-8?B?RFhGR01zb2Z0SUNLTW43WE92RG1LY2o4OXcrR0REMCtUbUlEN1lEMmtrWUZn?=
 =?utf-8?B?bVhlM2pTZGRSaWN1YTJpT3krMVBUak9pZ1crM1NUNFFhMnF3cFFjcjk0ZVdU?=
 =?utf-8?B?SG56emFQUVlRSUl4ZnJBNWlUMTJwaXJHb1NtSml4bDVid2FEdENTNUluSzEz?=
 =?utf-8?B?U20wN2dtMVhOcE9CVXNMajhzdHZhbGFKRnFSS0RCZFRUbW1TamR5Z2hBWm9X?=
 =?utf-8?B?QlhiZjEwUFBGb2pqKzFaV2Y2OEw5M1lvUUxTT0k5a1U5MlVURTgwTmpwZ2VJ?=
 =?utf-8?B?R2F4dEVRMHh3QWtWR1EzV3FaWkFUWkNtdHRKang0UVNaVGd1ZEwzSVEzN3Bi?=
 =?utf-8?B?L0lZNnNUcEo2cXZlUk80YjR3dERzK1FWTTJ6UGxhbFFtdnJqdHJJMWVSVkh4?=
 =?utf-8?B?VXhSUE9UYnVXVGxhQzlTMGFjU243dlF0UlN5Q2QxK3lUSVV2TDlXc3N2OG9o?=
 =?utf-8?Q?j7YQqOqhapyNBths=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12BA5DCC9A0E2445986D2F9F38F7429B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v5Eocpw9P5wsspk4OZnB2ZTDP4mMg2OjNshpPVJ5HZTGRFL7Ev9Zy57iIH6XFmekl1M7D9GwkSVJDtwVsT/QqHGLqliXlhHHMpajdHLDLQ99EbwD4hmdlm5JuZTFAd1X24ytOsweoeEvyO2rRyQGl1zVpI2jjQ0R+UpyCWbgsxMPK3YC+2X3/XCPxlaIxzKHjxmTTMWTmH7mZKIQfel1X2WGq82dj71nS09u41uXlY5ukpx6XLFRKGUajDvSWR3oq4aL94ndoehRerytUnDgzfudvRpndh+ElUl7F6eEr5fU0CpGVM53gB3iGmW4LOdHpaKoMe2RPa08eykpkzQJUA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4178c8-1b64-4ebe-d424-08df038e6d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 16:23:56.5872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7cjg4Sqnz7M5HUBLRQfE1qDpWBFfE0EigDlRm/SnQCUl+S6F011CU24t7BVIOBdTGggOkip4Rl95/fZnqonAAoAKs8148s7sbF1HCSU0KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTI2IGF0IDA2OjM2IC0wNzAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gV2UgYXJlIHdhaXRpbmcgZm9yIHNvbWUgZmluYWwgY29uZmlybWF0aW9uIHRoYXQgdGhl
IFREWCBtb2R1bGUgd2lsbCBuZXZlciBzZXQNCj4gQ0xGTFVTSF9CRUZPUkVfQUxMT0MuIEFuZCB0
aGF0IG1lYW5zIGFsbCB0aGUgY2xmbHVzaGluZyBpcyBub3QgbmVlZGVkLiBTbyBJDQo+IHdvdWxk
IHByb2JhYmx5IHNob3J0bHkgKHdlZWtzKSBzZW5kIGEgcGF0Y2ggdG8gcmlwIG91dCBhbnkgZXh0
cmEgZmx1c2hpbmcgYWRkZWQNCj4gYWxvbmcgd2l0aCB0aGUgcmVzdCBvZiBpdC4NCj4gDQo+IEkg
dGhpbmsgYW5vdGhlciB2YWxpZCBjb3Vyc2Ugb2YgYWN0aW9uIGhlcmUgaXMgdG8gZG8gbm90aGlu
ZyBmb3Igbm93Lg0KDQpPaywganVzdCBnb3QgY29uZmlybWF0aW9uLiBTbyBob3cgYWJvdXQgaW5z
dGVhZCBvZiB0aGlzLCB3ZSBqdXN0IGRlbGV0ZSB0aGUNCmNsZmx1c2hpbmcgYWxsIHRvZ2V0aGVy
LiBUaGVuIHRoZSB3YXJuaW5nIGlzIG5vdCBuZWVkZWQgYmVjYXVzZSB0aGUgZnVuY3Rpb24NCndv
cmtzIGZvciBodWdlIHBhZ2VzIGFmdGVyIHRoYXQsIHJpZ2h0IFlhbj8gSSBjYW4gc2VuZCBhIHBh
dGNoLg0K
