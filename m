Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C4334A775;
	Tue, 17 Mar 2026 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745702; cv=fail; b=Plr5UASX/JGfBm3sLmIdVQ8nY2GI+tynbdF8Aqw8Uh22T/+uEjuJRuQnWM7dqLdyQnV/OxB/6sQyvibscKSAvq7GaGEyomgL8t6CBzaJxnDTPCEjH/jsNw26RA/ISqHoZEh5O/UyaB5lpWRsH7b5Sa50uX2CYiKuzPXKdwohsJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745702; c=relaxed/simple;
	bh=6PT2s7k//QxlZtFwHFuZmFViuhSeHE8/V3dgVArdCL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IOd5nrUhDtlwOl3IvM1pO9zIqhiarN2zlqcg0OnNgP3S7O3UnADfm3eZARaj32MygBCG6lkrYQELqCPZESIzxcAGg0EiLDFfMKDZnEGem3CNXmwqhj7yZ+f7XlDuHrH1T4VaU4XpyAbapk80dzqtxYRhBq3JIoOuU9ZySLRsukI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrQTV7N6; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrQTV7N6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773745698; x=1805281698;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6PT2s7k//QxlZtFwHFuZmFViuhSeHE8/V3dgVArdCL4=;
  b=GrQTV7N6TB7tEZ6tn2N4zpmJiei/P/uH/P91N6ssvfySbPZYW0hLHkfB
   Qa7mvZ0rK7pkjGfsCgbVaLPnZfvc77CI3FxiUGCuHIcG/F08X3WdWcbuX
   Bvw3/lRCn1n6ECyyPDcZOAnmnmI/Kfm6jL8xHY9nXRhODVQCsMDgyl+z1
   GzrjqptOqAHfUh5ewfVN8mJBZhJGwVIxBH2IniBhnhxLNp1trxf1pFyD7
   a6MD1Wl0kWsramYSOj5Nv14XuHDRo4/ku7raHoMWuGi6w8QYmhpCa9lEz
   VC+uMdBy+Cjnw04hdX2IPh6LeX0pqPUwMFyea1UXnebqZ+lcBnsBpurTU
   A==;
X-CSE-ConnectionGUID: bT7lpJMpTiOhq6V3zzeXhg==
X-CSE-MsgGUID: 0Bzzz0zcTFeQiH1NLVCwUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74853186"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74853186"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:08:17 -0700
X-CSE-ConnectionGUID: pF7vLx79T6u8nAOoGMBJaA==
X-CSE-MsgGUID: jPtfzk1dS8+f8ovY8Fpijw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217947404"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:08:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 04:08:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 04:08:16 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.12)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 04:08:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9lEi8G/9pBSTraHJIfUIeeN6egzT7cKCy0uLv7x2bSJZf0NSdTj5huFtZmo+rh8rnzzgAT/J5J1IgdmIDlH6FYxsS1Bs0pfI6yjgbD2pKLB0EsBJARTlXUNl7R7dcMOeOuK53RucGJ4J9J1JNqvWdXT50KgReCICFCKXqYM8WfKXofpucHQbYsNODV8CC/MtdwrS6J4PhuZr5QglKX06p2pwQGrZ9BR9Rt6nwLyXDehwftmcGeFpA9fY78Y1tEK8q08VYfsuZCSIxIAtsjMgjdEKwl1WNsVUcSfAvSnT9exg0HUQpJnMC1knvBYXM9Hau1itUiUkAdg2PffIVHTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PT2s7k//QxlZtFwHFuZmFViuhSeHE8/V3dgVArdCL4=;
 b=mH4TBjjnRdoIVVtCMmXV0PIfOmIeWldqNJLJ3GVwJWoBqz9MQ6oe/+P8uo1IazVbDEmHLBZam2Gwrp7HM3mObi/5GL9/ReMRxpW/yWW+zWQuFte118a/EV+rWjXPtEwphwZVNe/wGO94kf8w3muhCaDA9PRs0WEFTSk79TAW1Y0gb9FfY34MynuvO8P7fZ81TVGcfMT2WCMezKuIwI6fGUFALN/zNnvUB3FBa/wVjND8OdvjeZHtEH/t2qu77/9t7XtjqUye1a/l6hFYIkaI4NHka2MEveA5EndSxcFVOXNSJFAyhHj1d4894N+bV+1J60ep/6gZLw/Rxx7mJ879kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB8181.namprd11.prod.outlook.com (2603:10b6:8:159::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Tue, 17 Mar 2026 11:08:09 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 11:08:08 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"sagis@google.com" <sagis@google.com>, "Annapurve, Vishal"
	<vannapurve@google.com>, "hpa@zytor.com" <hpa@zytor.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 12/22] x86/virt/tdx: Reset software states during TDX
 module shutdown
Thread-Topic: [PATCH v5 12/22] x86/virt/tdx: Reset software states during TDX
 module shutdown
Thread-Index: AQHctIP+QgonfM6NE0ygNTGLoWRFtrWw32MAgAGHQgCAACzzgA==
Date: Tue, 17 Mar 2026 11:08:08 +0000
Message-ID: <a021e75749ef358d9d00822ab082d3c4458136a2.camel@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
	 <20260315135920.354657-13-chao.gao@intel.com>
	 <996e42a31101bb90575e7b2b6f33b3bd607b5e6e.camel@intel.com>
	 <abkQWsqR7BURMZxc@intel.com>
In-Reply-To: <abkQWsqR7BURMZxc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB8181:EE_
x-ms-office365-filtering-correlation-id: 544405f1-8377-4bd9-2eae-08de8415788d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: jGO35NsnR2x6NQzzo7bbSINLjBY6K9dluoleevSAy7Vh4KnNcQW1eYEk9PX6TZqz52J9Hi5fNlhxdIQtuIiwrRU6yvPxmKj6xzR/Ky/C65MaYP48BUkZeHvacDT05AMumgf5605DMwz5GMyKak932QASIDfUrOPE7OcDCbXfIQ8/lf/dCDKsdFwFRIvaQb46KH6yaZYjBwzymtF602dTc7QJ6B7DVUZAEBf+/og5XCdNYWvd73gYXM2V2gBiY2VJUuHyZnzMtaWeo+UTeX1cnsLQSNKK6pa8eZigHG63W2zb8lpObJhrCN7Erb4gZNPfzKkRukwG0vz+/OTGGaEeAEzGDsjV0mGKbMbsjMA4S75mO755e/HS3T9pCtBw6n0pf1Dcyz0LfklFcnf/X2YHdPC7de7FSg9FkHxirlr7bHSXsxJ+g9q4HVI9OKSPLE5LUNWw02PQXi9ifK/Ycro4vHP0xagyJ0VqkMLcd8i8ULj2IYuXmKmILSYDBmNk06VVmFdku57rrHys60VKlNgyCFXbob+u1HmigBSpI0s94G2PlBiFtpOcwkBJZJ2mQY8PN/WbJhwFKRBfyS+ozyo7oyqsjnu0axGsctSUG3RZ3idYkopPVL3EDabaIzUy7H18UlqtZntz7rlfbbY2/q/7+irAaUnTFc+iAOhD8welEOJBb6D+5fY56xiH+lSfgDr19QNCRSeAFOBx/yY9mIkoocKIkB/PGNn/adssmI/8MQGat2Um235D/rFRV+Xhz8T89sX0WVc4EbttWjtylpanj8/OHZOoFLDBI3RBXqMWPgo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEVuMlFwSnpHeEM0Uy9ESm9uV1REU3U3VXNYV2xXWDZ2MjIvdStYbjNkUjMv?=
 =?utf-8?B?ZFE1N1B3N2Qvd0V6MkFOejlmMDJYRjQvQldzYmkyYzdwckhuV3ptSVBDcXNq?=
 =?utf-8?B?V1BpQ3UxQ1RjWC9XVXozNjFxQnRFYjNrNElzaWwvRmtJeFRhcEhuUHNzNVor?=
 =?utf-8?B?NVB3anZyNTI3eEpubG5McDUvS2RaTk5hRkxuN0F1L1QzUldQQnF4Y3k4aHRP?=
 =?utf-8?B?eFpPVjkwNktqSjk2RFByWk5ZZ3NDNUtrZUFQZzNINjZLL3JZRUNIemVlQjZt?=
 =?utf-8?B?SUp4SE9hVUVaN2xYaE1SMUZKYytXWDhHdnhwSFJ0N2VGaUhrWFRxUjRqRm5K?=
 =?utf-8?B?NlFBb25PYkFlWUV2SVlBK1ZVc3hqTU5Dd1ZVbzB2RjFWRTVNZW1YYVdycWZ0?=
 =?utf-8?B?LzFUazZMQmcyZzd0ZWxFVDZXN3E2RGZFU2pBK3QwT3FkVVNYU3VqdVp4TDly?=
 =?utf-8?B?dy91dVJ2Rlo0WWVOTFQvM0dxVG56OXNSczVoOWVwby9UYU80cVNZak54NnJT?=
 =?utf-8?B?SHVDbHpidjBvQ1RqMzJiYlp3ckl0TVFNQWY1Q1hFa3VuR1J2WUtLcUpuaWpL?=
 =?utf-8?B?akJxdVdZVFVaVVJ5RWlYanNObFVYOWo5L0NGTzFlaEFTV2ZzcnQyVmZwclRE?=
 =?utf-8?B?bzdmWktjTDJSRTJXcE91Z1RNZTk5OThLeDhJVEkrOVhlWWZNcVMxS2l2M2tk?=
 =?utf-8?B?R0NvdUNMdXFZSnBxZUpnNEhFRVVwQ2k3KzZONXo1Q1dNeUZmK2g3M2dPV09w?=
 =?utf-8?B?bDA3SlpTUDlDZ2lPK3QvYjJISXNiR0JBSGJ0ZEp3T2J2VGUyWGFOcTF2TEYz?=
 =?utf-8?B?Rk5LU0JvYkpKenhDUFF1dXVkMm03NmIwM0NVY3JuTUl4RlZVZVFNYXdwTW5B?=
 =?utf-8?B?L1Y1TjRhdXFmdlBYdEk5VkdxZ0NpSVN1QW81UWpNcmN0QmR5RURFQUlhQ21S?=
 =?utf-8?B?bmJhY1R0NllpMmtJYm1qMHdlSk4reXc3a3hPb0M0dldNUXBjVWd2cTlyeHpH?=
 =?utf-8?B?TlJTTkk3aXJQTlhnQVVOaHU0L01aczZQL0xFbFNzc0VrQ0F5eTE5Um5PMnNo?=
 =?utf-8?B?T2VzVmtrZUtTaGsyTWkvUGI0NzFVSmFZYytQVTVaRjJDUDBFYUwrWWVKZTZ6?=
 =?utf-8?B?RS9ISmE4M0p1VkJUbFJLVlRBKzZ0WkIrcStaYWpzTTBmbWpLUVorSWlsWks1?=
 =?utf-8?B?YWNxZUkxSW5MV3A5eFVBQTNQUDB4NHNFUE9oZURIbkJZZUxLeHlXVzgyeVJq?=
 =?utf-8?B?ZUxNdktCUHJLOEs2UldkRmQ4RXhjcmVCWjR5S0p0NnhhSnBwako1Q1pFbmlo?=
 =?utf-8?B?dFQ2eE5uN0pGTlBnMEhaNWJMVXpGMDVCbW5BZlQ1MU1DOHFvcU1uM05mc3dE?=
 =?utf-8?B?NWVxai9YaXUzN0crcFJreVU2S1FFS1pvZ0RwNWlVL3h1VVRKL1F4YlVaYWFH?=
 =?utf-8?B?WGh3aWRibFV4ektTSFloM21BejdEZXUvYURFK3BqOXNNdGROQUJZZXFKeVpF?=
 =?utf-8?B?dmRrMW4vUC9rZ3dDcVN3MGczWkk2Z2tZczFyMWlERXNxYWNKaW9sUGlvUTg0?=
 =?utf-8?B?c0Q5dkgyVkpva2VTN2h5UEZjb0hoemptUXB5aktZNU9jSG90aDBxVnNWYTF5?=
 =?utf-8?B?QUIramdUSDd4S0FFOFp0c05MZmRBRDNNV28wWkFQSndxYnUrRWNIY3BsT01L?=
 =?utf-8?B?RGk0emdpczZSZ3MvZExMa0pLR2x6UG5RRGtEUkZXZFRocmx1cHlSOVV0MW1x?=
 =?utf-8?B?UFBUMXNhYzBlQ0x6Q1hqY29vbTBQRVI0RTE2NjJhMlRuMTM4R0ZhNzhqeXV0?=
 =?utf-8?B?b0dnMFRYak1MelhoYTc0empmblVKa3Jjbm04UWY4S3ptZnRHRnFGa0RCVlRX?=
 =?utf-8?B?QUNDc0VLTGhPc0ZnTExsbVlqSUs4UkdzcWkvbmYxWHhEUm1DTjIzY0FwcEEr?=
 =?utf-8?B?ZTVUaDNKMm8vUmZhUW9qWktwQTRoS3ozd1ZyYjRuRGN0TFI2RHVOanYyV3ls?=
 =?utf-8?B?QzNrOVhIS0hPVUpoa1VVVmF6M0RUTE9CRUYyRGM1TmZEVEpxOGxBSXE1ZTJP?=
 =?utf-8?B?bHU4c3F0K2g3a2hpcHF6cnJhUkoxczBqTW54c0JBdUhEejhQeUw1MFdxL1hQ?=
 =?utf-8?B?dnJ2UlFPV3ZXNDdldzdreEkrdmJKQTF4M0dtak5qMC9haVV3bm9nQkVLdTNi?=
 =?utf-8?B?RVY3dnRhWkN0aG9JNTBpSmpMbzE5emY3Rm9YZFBrdkdOZUtlYlFtdUhuRGt4?=
 =?utf-8?B?TUY2eXBTTU8rcGt2clY3bFRZSkF5TEZoTjdWWStkVklteEJnSDc3WVZDR1gr?=
 =?utf-8?B?TUdMNmRLQjJhYWNoSnpkT1ErMExQN2ZVWXBQRTM5QU1HdGJTbDdyQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0323B31D8075F4AA73E9D42405B2B5A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ck43HOVO9J/HOaSL9INo3KUGYR/ADxe47XBaqMNw/JbkhIWQWSs5U8CcSa1o7CIX8ZmsmYppsSW7ttMPrEiN72b2qGQiqBIF+wbasT8o4+7RFP0qTNgvMooi9+SQ9L9kXDEtJfhTizRrIWL/NdBzYtRnTfIhEEr85lyE5gIdfenzJQ0fqCrt9hg0M+VpArnUTZc5Spnuw0YVMeOMMgFukHLjna5ljfb7rksSs+tHm5J00Fi820EKGZCUq23pwofsn6dqCFU4T7Lz0fZPGiqVCiHGn6Kh5tE7Z0o4FfGkLFh6SwDJ7JE+Sd71Qxr0QFjikB3MZu8Rj8MRXtsimbrBOg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544405f1-8377-4bd9-2eae-08de8415788d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 11:08:08.4749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ueGHdijj5JtLXD7ZB9gvsAGu9L0dyl7E8+ootvsdqdE1vyRdl/Cu7NG35ODeLo2BCrtW6BFShTkWRxwilTX3sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8181
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTE3IGF0IDE2OjI3ICswODAwLCBHYW8sIENoYW8gd3JvdGU6DQo+IE9u
IE1vbiwgTWFyIDE2LCAyMDI2IGF0IDA1OjA2OjQ5UE0gKzA4MDAsIEh1YW5nLCBLYWkgd3JvdGU6
DQo+ID4gDQo+ID4gPiBAQCAtMTE3OSw2ICsxMTc5LDcgQEAgRVhQT1JUX1NZTUJPTF9GT1JfS1ZN
KHRkeF9lbmFibGUpOw0KPiA+ID4gIGludCB0ZHhfbW9kdWxlX3NodXRkb3duKHZvaWQpDQo+ID4g
PiAgew0KPiA+ID4gIAlzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzIGFyZ3MgPSB7fTsNCj4gPiA+ICsJ
aW50IHJldCwgY3B1Ow0KPiA+ID4gIA0KPiA+ID4gIAkvKg0KPiA+ID4gIAkgKiBTaHV0IGRvd24g
dGhlIFREWCBtb2R1bGUgYW5kIHByZXBhcmUgaGFuZG9mZiBkYXRhIGZvciB0aGUgbmV4dA0KPiA+
ID4gQEAgLTExODgsNyArMTE4OSwyMiBAQCBpbnQgdGR4X21vZHVsZV9zaHV0ZG93bih2b2lkKQ0K
PiA+ID4gIAkgKiBtb2R1bGVzIGFzIG5ldyBtb2R1bGVzIGxpa2VseSBoYXZlIGhpZ2hlciBoYW5k
b2ZmIHZlcnNpb24uDQo+ID4gPiAgCSAqLw0KPiA+ID4gIAlhcmdzLnJjeCA9IHRkeF9zeXNpbmZv
LmhhbmRvZmYubW9kdWxlX2h2Ow0KPiA+ID4gLQlyZXR1cm4gc2VhbWNhbGxfcHJlcnIoVERIX1NZ
U19TSFVURE9XTiwgJmFyZ3MpOw0KPiA+ID4gKwlyZXQgPSBzZWFtY2FsbF9wcmVycihUREhfU1lT
X1NIVVRET1dOLCAmYXJncyk7DQo+ID4gPiArCWlmIChyZXQpDQo+ID4gPiArCQlyZXR1cm4gcmV0
Ow0KPiA+ID4gKw0KPiA+ID4gKwl0ZHhfbW9kdWxlX3N0YXR1cyA9IFREWF9NT0RVTEVfVU5JTklU
SUFMSVpFRDsNCj4gPiA+ICsJc3lzaW5pdF9kb25lID0gZmFsc2U7DQo+ID4gPiArCXN5c2luaXRf
cmV0ID0gMDsNCj4gPiA+ICsNCj4gPiA+ICsJLyoNCj4gPiA+ICsJICogQnkgcmVhY2hpbmcgaGVy
ZSBDUFVIUCBpcyBkaXNhYmxlZCBhbmQgYWxsIHByZXNlbnQgQ1BVcw0KPiA+ID4gKwkgKiBhcmUg
b25saW5lLiBJdCdzIHNhZmUgdG8ganVzdCBsb29wIGFsbCBvbmxpbmUgQ1BVcyBhbmQNCj4gPiA+
ICsJICogcmVzZXQgdGhlIHBlci1jcHUgZmxhZy4NCj4gPiA+ICsJICovDQo+ID4gPiArCWZvcl9l
YWNoX29ubGluZV9jcHUoY3B1KQ0KPiA+ID4gKwkJcGVyX2NwdSh0ZHhfbHBfaW5pdGlhbGl6ZWQs
IGNwdSkgPSBmYWxzZTsNCj4gPiANCj4gPiBTaW5jZSB5b3UgaGF2ZSByZW1vdmVkIHRoZSByZXF1
aXJlbWVudCB0aGF0IFAtU0VBTUxEUi5JTlNUQUxMIG11c3QgYmUgZG9uZQ0KPiA+IG9uIGFsbCBD
UFVzLCBhbmQgcmVtb3ZlZCB0aGUgcmVsZXZhbnQgcGF0Y2gsIHRoZSAiYWxsIHByZXNlbnQgQ1BV
cyBhcmUNCj4gPiBvbmxpbmUiIHBhcnQgaXNuJ3QgY29ycmVjdCBhbnltb3JlLg0KPiA+IA0KPiA+
IEFuZCB1c2luZyBmb3JfZWFjaF9vbmxpbmVfY3B1KCkgaXNuJ3QgZW5vdWdoIHNpbmNlIHRoaXMg
ZG9lc24ndCByZXNldCB0aGUNCj4gPiB0ZHhfbHBfaW5pdGlhbGl6ZWQgZm9yIG9mZmxpbmUgQ1BV
cy4NCj4gPiANCj4gPiBPbmUgd2F5IGlzIHRvIGp1c3QgdXNlIGZvcl9lYWNoX3Bvc3NpYmxlX2Nw
dSgpIGhlcmUgc28gdGR4X2xwX2luaXRpYWxpemVkDQo+ID4gZm9yIGFsbCBDUFVzIGFyZSByZXNl
dC4gIFNpbmNlIHRoZSAiQ1BVSFAgaXMgZGlzYWJsZWQiIHBhcnQgaXMgc3RpbGwgY29ycmVjdA0K
PiA+IEFGQUlDVCAoc2luY2Ugc3RvcF9tYWNoaW5lKCkgZGlzYWJsZXMgQ1BVSFAgaW50ZXJuYWxs
eSBkdXJpbmcgdGhlDQo+ID4gb3BlcmF0aW9uKSwgcmVzZXR0aW5nIHRkeF9scF9pbml0aWFsaXpl
ZCBmb3Igb2ZmbGluZSBDUFVzIHdvbid0IHJhY2Ugd2l0aA0KPiA+IENQVUhQLg0KPiA+IA0KPiA+
IEFuZCBhc3N1bWluZyB0aGlzIHNlcmllcyB3aWxsIGJlIGFwcGxpZWQgYWZ0ZXIgU2VhbidzIFZN
WE9OIHNlcmllcywgd2Ugd2lsbA0KPiANCj4gWWVzLg0KPiANCj4gPiBoYXZlIGEgVERYLXNwZWNp
ZmljIENQVUhQIGNhbGxiYWNrIHRkeF9vbmxpbmVfY3B1KCkgaW4gVERYIHg4NiBjb3JlIHRvIGRv
DQo+ID4gdGR4X2NwdV9lbmFibGUoKSwgd2hpY2ggd2lsbCB0aGVuIGVuYWJsZSBURFggYWdhaW4g
b24gdGhlIG5ldy1vbmxpbmUgQ1BVLg0KPiANCj4gR29vZCBwb2ludC4NCj4gDQo+IENsZWFyaW5n
IHRkeF9scF9pbml0aWFsaXplZCBmb3Igb2ZmbGluZWQgQ1BVcyBtYWtlcyBzZW5zZSwgYnV0IEkn
ZCByYXRoZXIgbm90DQo+IGp1c3RpZnkgdGhpcyB0aHJvdWdoICJlbmFibGluZyBURFggb24gbmV3
LW9ubGluZSBDUFVzIiBzaW5jZSBtYW55IGRldGFpbHMNCj4gcmVtYWluIHVuY2xlYXIuIEZvciBl
eGFtcGxlLCB0aGVyZSB3aWxsIGJlIGEgU0VBTUNBTEwgdG8gZGlzYWJsZSBURFggcGVyLUNQVS4N
Cg0KU29ycnkgd2hpY2ggU0VBTUNBTEwgYXJlIHlvdSByZWZlcnJpbmcgdG8/DQoNCj4gSXQgc2hv
dWxkIGJlIGNhbGxlZCB3aGVuIENQVXMgZ28gb2ZmbGluZSBzbyB0aGF0IHRob3NlIENQVXMgY2Fu
IGJlIGV4ZW1wdGluZw0KPiBmcm9tIGRvaW5nIFNFQU1MRFIuSU5TVEFMTCBkdXJpbmcgbW9kdWxl
IHVwZGF0ZXMuIHRkeF9scF9pbml0aWFsaXplZCBzaG91bGQNCj4gaGF2ZSBiZWVuIGNsZWFyZWQg
YWxvbmcgd2l0aCB0aGF0ICJkaXNhYmxlIFREWCBwZXItQ1BVIiBTRUFNQ0FMTCBmb3Igb2ZmbGlu
ZWQNCj4gQ1BVcy4NCg0KSG1tLi4gSXQgc291bmRzIGxpa2Ugd2UgYXJlIG1pc3Npbmcgc29tZSBi
YWNrZ3JvdW5kIGhlcmUuICBDb3VsZCB5b3UNCmVsYWJvcmF0ZSB3aGF0IGFyZSB0aGUgc3RlcHMg
dG8gdXBkYXRlIG1vZHVsZSBvbiBhIHN1YnNldCBvZiBDUFVzPw0KDQo=
