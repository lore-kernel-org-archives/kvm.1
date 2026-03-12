Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466C39478F;
	Thu, 12 Mar 2026 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343325; cv=fail; b=CqQfa3+5jYkZsnKHVLSdSFrV2BODa5p/o+rpk77I8wRsGtVlyGi0yywyeAPc1zvprob4F8yebu5hfr+OvlzeS1lZ7xgBt3I6/yd0VRTmNvzs/RvOpaWVhqgG9bpx4AOEXsSGXl8yCqISZcFw7KsFWvPckYu+NR1E1BT6CVW0G7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343325; c=relaxed/simple;
	bh=iWtg2wP14oNxLaD1TFv7o0V2sc5a1d+vdcaqQfjYVHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FgkjuLSyVBBp/aoQyB4HY+Oo4aIsdheeaQ/wc9AsjXh7IOZy1RzWIsnrYrHBJxmsCFwIhYoWfhY/KpnMSbT8HZ1dhA+Z0y6u91cBqDYPoTpukh62SN6bGQ+zqX7GkZPEbn2Q5GxzMPq5WdTmr9PfZJ6V7gpB9iYhB2DCCK5A3NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLUT9PO+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLUT9PO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773343324; x=1804879324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iWtg2wP14oNxLaD1TFv7o0V2sc5a1d+vdcaqQfjYVHk=;
  b=OLUT9PO+hmP+Twzm45NYav3320NQ79XSgNXlKldecQX7mlkmgnglqaOm
   ZBdfNDa81OiRHPH+fntsIlVonpS0R40HBwo7WUQHqUUb5Q/YBeElT35OB
   fveOULRG1YMj6yolrAlfeg+ZimXFh/8IIDtaN8nhboZEPYM5KT3MDKd7t
   OGvEEHZptcq7kSkAxXSFr+DROWHXlGs90yj+uwrCDYagPjeUz94Q+WS4t
   YbWU0CYTcvKrlKCV+H9jUtKag2VxhkDCPpdKJibMKVmXPp/BJLwbN5iZZ
   rfcwYOWMzieT5zsUmBcaAFSwnBd0TqXrm1+llgYXdmvazv8j04y/bO7pp
   Q==;
X-CSE-ConnectionGUID: DcNqLizSS2uZ+1YTGmsgLw==
X-CSE-MsgGUID: bFDBBA9PS/SxwpZGNr5KaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="62023019"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="62023019"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 12:22:03 -0700
X-CSE-ConnectionGUID: tKAz2NWIS2+AR8mQHWMcEw==
X-CSE-MsgGUID: SUMjEuk5QQOr+siSer4oow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220988691"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 12:22:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 12:22:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 12:22:02 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 12:22:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FH6XN0L7jw/c7mtFls/iEXRdrtaFZfr6Gbqp5Q4wbNDD5KuZtBeZZDvciwkuOPnBWLTmdS99dAdRezSmpsHsk1RblKmOxLDo3dHTozrKfiwp/FGK54yLh6Sr4Xg0YS69fEBJBpcdkZ7PqZnqyX1GTJ70Exr40PloBN6S+H/92DtXNkO6HDLKr6Oejs6J0jezSi2HEr7metyCrBpTrFO/atce9dCDXeA9NyetAiOdq3eyoJoR0RLXZXIjfy97tNeKd7XOB3fcgHj7ARHNJPlrCfx6H/di9WiWA5U7k4KbQzlPe+ZGiWJwqO8H9Xvx2TC/MTOHOVxOrlLN7pZeOtSMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWtg2wP14oNxLaD1TFv7o0V2sc5a1d+vdcaqQfjYVHk=;
 b=fHW/sUxMu3Y65n5m79XrcQUg1wp9bqno8yR4OAT1PyPgplmD9Vzol3fxhdWBMT09Xdgkz3GQ5b9jsWE2B1/CcrG/YORM9qNKdGUIaZi35q1RQU0uO03DZxZ7A/dbULV5Jzhn+vnNnJqamoMSIQgVXaxlFjOILYKQhyY+ikgci+O/JF6oaFtSOwAE+0EmwIipjegMLp75PW8+6+9zaGsAgK2c3Mjr+VeE9WRFHqeBg4zAWeH5SIBHvvPvDeW8dzTM8NbQfwtQo4rXIdZ/uNIpEPg7rCZNw2Zhg+QP8mlxa1vNTuWLduzgzk8EZuhNFEDuBVAyPZtkHOgBafcBYr9UYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 19:21:58 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9678.017; Thu, 12 Mar 2026
 19:21:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "Huang, Kai" <kai.huang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, "Weiny,
 Ira" <ira.weiny@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "sagis@google.com" <sagis@google.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 09/24] x86/virt/seamldr: Check update limit before TDX
 Module updates
Thread-Topic: [PATCH v4 09/24] x86/virt/seamldr: Check update limit before TDX
 Module updates
Thread-Index: AQHcnCz7d3DLAeeagUq/RUL7jSdHg7WrcqKA
Date: Thu, 12 Mar 2026 19:21:58 +0000
Message-ID: <651ca665d5f58ac9afd01de32aa5d6053a254ab4.camel@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
	 <20260212143606.534586-10-chao.gao@intel.com>
In-Reply-To: <20260212143606.534586-10-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB7414:EE_
x-ms-office365-filtering-correlation-id: 7eda3e4f-4c43-4f54-1711-08de806ca123
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: kqBrchLreuOYV7mAgXbeKwayazDZKpDI6Bj7GvoNNPd5J/8LuIUgbgLYiGC2rz4ydl2YZgOgZjXAvhcyUntHddP7hD9sFlTTxdtbT8ZmrAHlAJGbMCQrRy8+lK1j2N/6dfqgiSkJZHIXLy9VzS3Bh/Ypxnbqoe/1ntvODTcYDq9jv4Xbm0DgO9OiKzpKo0epzZdaSk/fx0IWzYRDCoDZdVMo/HZigFGGbnIlrRZ5aB+raRE5kONmEpAcmAiEDP4vaohLCAUP8GveB2OcGFNE7lPGBbtWtS+sMhzEC4ri/EKCC3FO5tAMYywSBE4CYhl2Y52pjmRNZZCpjDWsKbG/jA8w9umRP351Z5BF//uS9WF2ovkPShDHvqy0SsPtZvJYBeojX7gMiY1dz4qL2PUy5uafoHxYseAmstvpmd6fsZwlzAYbsl9jCwKotJGGxJKDMad/iNNC1bWTL35iA1RsrBdDov/kzkZukPqTy/Dx5aFPVGKSFBrSWG7W94lmdrrQ2ZjK4lsSlvOqY2KK/+QsPQvrUg75gerKxdMiit0rgEM/ENscBVMT2pArPoUQKv2i3jrF+Cout4vq9nYpNk9N+YGXb5whf9fdFfMXN9hit0om9LHmpX5ElvRE/sMSaefZkxshM+H9iaZu7/hv0bT4nNQnZOB+JUm8yFfz2k4R2rqQgIT0WC7HKJaEwd6HCknHAlM346wYDsbZDsGBL3IG0wVCa44SebLM9hnMP/v/EYMkv4DQFGkExyAaSL6hAz+WBFtQCSzZ3G3LKe4y1KgUNzs5r8STI3tm9lX0xsDFBIo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEVpT0V3dTYxNUhZRzR3V2NYQks1RTZiL0doV2J6Z255dDBpRlpwenVNblQx?=
 =?utf-8?B?STc3SXgxNzV6b1psRmpuRDR0OCsvcnNSTkh2U2I3akkxNjBuM2crdERldkYr?=
 =?utf-8?B?WGU1S2tCUkl4SEtMd1Y5eHFRcmdRZVVpZ3ZJc1FNYksyZmxwSVFpcmcvM09K?=
 =?utf-8?B?VUVvaXhtaUcrL1c3cGFVWUxBdFdYc0VqVGpoaXNDNFVPVDdRMkRPMUoxQkd3?=
 =?utf-8?B?K2h1ME5QSE9rT3pvUW45S0VHL1NESUdTaWgvMXhyZURYQ1Fob2tmY1cwUTRu?=
 =?utf-8?B?Q1E4NXNWVEtCRkJqL1NJR1RzTGxqRVl4bjE4SGExdDJqZkxmVnlUbXdjY0s1?=
 =?utf-8?B?QWM3YWhQZU1ScUVZbW45L2VVczhpRXFwTTgvSm9lcVl1bzZxQVNFSWNOMHlN?=
 =?utf-8?B?am03d0lQcXRpWEZleGNZeWZtZ0crdlRTQWo2SEJuVERzTFR2eFRvVi9OVHhO?=
 =?utf-8?B?czVZYURuV25RNzhXS29Sb2EwYS9kbTdsTXhqVjBDbkVvSVR5U3BVVjVXUHFZ?=
 =?utf-8?B?R200T3pwYzVpbDk3T0hudVh6WDVpeDZ6MWlzbVNheUNKRTM2ZHZtT2dpQUVl?=
 =?utf-8?B?QWJSSTZxWjRVNUg3aWpMRGxLdmJ4MkNjazQyejFRWklPQkJIR1B3a1RSMldW?=
 =?utf-8?B?QllYL283WHVKeTV3TnQrcGdlT0U2UVNvSGN3dXgvRllCWEVnQ1pyVkZoQzgw?=
 =?utf-8?B?d1NyRG9pRUJsVDVGZnNTVGRsM3kwV0xRV2ZtRFEzZnZzMFJGNXRaZmhuSWFq?=
 =?utf-8?B?YTQ3YlNUcHY5c2d5RG5OYVE3TnQyT3grd3ZheG5HbDU1RVJ5YUhPSmMxNGlL?=
 =?utf-8?B?c1FwRTNNMTAzV05tZ3hZa1UzdEo0a1JtLzZrWWUwdDVUZysxek5yeWhxZHJM?=
 =?utf-8?B?R0RFT2xBOU1lcE5yakxPVzdCTllBR1ZraTlGNjErWStPcFpwM0ZXUnFFUkVL?=
 =?utf-8?B?MEdzcmY5NHh5OE94WE1zbW11eE56TDZBZGc5OFk2ZmhhTjNoeXVScVNob3Bq?=
 =?utf-8?B?RmVSZ09hcDA3b3Z0UVI0Z3JTUkRYNXU4WWNmMnVOdnRENDlwdDZvMVZSTEZR?=
 =?utf-8?B?VzZDNlhnRy9OenNaeGE1Tys5Z2NtaGltaDc3ZUVXbXJuVCswQ2JLaWZHOXJo?=
 =?utf-8?B?QTFpN3hDTmxhc1RDbU0zV2NyNWN4aWo4RlBFVGxjbms4SzdCdVFwL3hIWTFa?=
 =?utf-8?B?OG9DUHhSRGJOb2dFRm1uVzgvVzNDd1QzS2o1T2g0NG9MbzFsUGE5Q2JxNU1V?=
 =?utf-8?B?TnplZThIMlhoUlMvNzNzSFg2UmpGZk82Ylc0Wi8yZ0h2Q1FUMForeUczNzcy?=
 =?utf-8?B?d1JudTJRYzlOeE5ENWhzdjJUTWRPOVpWM3d2OXFKTHB1Mm9udDNQSDRYME05?=
 =?utf-8?B?WmNPdWw3T3E3QXYwRlljQnBSWWtYVjVPcmZ6Mm90UkdOcTVwZ2N0TjVKeHho?=
 =?utf-8?B?Uy95Wldkc2JiZEdyMVE0N0IzSEFWOXNZek02NERtSTAxcFZRL3U2OERTUHk1?=
 =?utf-8?B?WlozOHg2eFlXdWM1UE9ZeVBEMHpsYTkxeEpkaVhXQkI0SytoQUE5cHJjSWJ0?=
 =?utf-8?B?MisxOHUxb2FrWGFzaHdkcm5NQlVYZThNT1UySnV3d2FRR0syRXphYmFUTnND?=
 =?utf-8?B?NnRET2hsQ2ZDSVQ1ektFYmM1dHpxYkFFak5aT2hUTzVKRW1qSGwzeUp3UlZj?=
 =?utf-8?B?dUdRKzZuRFVkcytKckFrblFvZjUxMEZTTlEwYkcyYmxIVWxTazczQncycnVj?=
 =?utf-8?B?Y212a2RxMmRoOVFELzV0MFg3MVR3dWRZRnQ2VUtmemtuUTVGUFZYMTVqVUdG?=
 =?utf-8?B?V3dvTlJzL1RmQWhvOVd1NmdORUw4b282M3dkaW1uRkhPRHdvalF5dU1zOXJS?=
 =?utf-8?B?dlUwZTZvWDNzYUQ3cjIxVzEvWnN6Z0RVVTRoRFJ4aHMza3A5bGtFZ0dKN3hv?=
 =?utf-8?B?SlNMWDZkQmoyci9vY0lzMWhNbDVDZDZjb3ZCOFFsV283WjFOM3BoUENEK0RT?=
 =?utf-8?B?bU45SlBJYWlZU3puREkrOS9iYUxDNDNMYklpSUE2ekxnU3N1cU5keFF3K2FW?=
 =?utf-8?B?Z0tkN3RDaDNZVUQ1eldFQ2xFM2tOdmh3U1hTWndjdWc3UUxCYzY4cVFVaHJR?=
 =?utf-8?B?N2RBajNhSlNueGpTM3VFeFZISUFWSWxORFlCc0swVmlienZLT3BjeGg0SWMw?=
 =?utf-8?B?TW11RHJ1NG9qK1ZVR1dYSm0rdHlkWDh1cEhaRDVVWHlYekRWNnNJTXNhK1dk?=
 =?utf-8?B?cFA4dEwwcGhMWGJjclhjZlE4a084V1U4UHBvVVI1bXM2VTF2YjIzT1NoRWl0?=
 =?utf-8?B?WThpM01qYnk2WWswazVvZEYzNThmc01Vc0hOSEpHQm5hUTNBTUc1N0Y0R3F4?=
 =?utf-8?Q?SZe50a+ORBU8JqOE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DE968A236E3F24AA41E3E83AE1C5EBC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FnV8F6qyAQZzCwKDEpk3Af0Msh3/yZ6GneZLHTpjhuBkljwFgo/yX1bVpZI0DYR8vVBtka1Kw7tvRn3GIvxNVL7jsD/DiuqFcE/6yt0F+ZVDvmTTx5wOhi9QdiwYYd52M5+qeU6SarFwoiXpqR0wMV65Hvl/+GAFo3Kp/rP+BdYlZYZE5LdM5Ck0T8CFdh1VPEWJWAYHLqPeSFetPseuEoO/8T3YwNVx7CCKtPFCn+TBIkO5OKAns39J0cFa6SwzR/Kci0iHLRC8glMm+fwD6NWO16sg767imump4ZSLUEPDM+wLXExnkNb1+qIBmIKImXT67/bLnQH9Mzr1etf52w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eda3e4f-4c43-4f54-1711-08de806ca123
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 19:21:58.0839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhIJttyjBflNINcjtawiosaal/RDJAjURIi2Z/LnYdNeXbLZgstEhLD5T6eQdFPyMsnm/CF3/m7hGSr1ndGKjGiwIFky3xwcPtZq/cGdR5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7414
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTAyLTEyIGF0IDA2OjM1IC0wODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVERY
IG1haW50YWlucyBhIGxvZyBhYm91dCBlYWNoIFREWCBNb2R1bGUgd2hpY2ggaGFzIGJlZW4gbG9h
ZGVkLiBUaGlzDQo+IGxvZyBoYXMgYSBmaW5pdGUgc2l6ZSB3aGljaCBsaW1pdHMgdGhlIG51bWJl
ciBvZiBURFggTW9kdWxlIHVwZGF0ZXMNCj4gd2hpY2ggY2FuIGJlIHBlcmZvcm1lZC4NCj4gDQo+
IEFmdGVyIGVhY2ggc3VjY2Vzc2Z1bCB1cGRhdGUsIHRoZSByZW1haW5pbmcgdXBkYXRlcyByZWR1
Y2VzIGJ5IG9uZS4gT25jZQ0KPiBpdCByZWFjaGVzIHplcm8sIGZ1cnRoZXIgdXBkYXRlcyB3aWxs
IGZhaWwgdW50aWwgbmV4dCByZWJvb3QuDQo+IA0KPiBCZWZvcmUgdXBkYXRpbmcgdGhlIFREWCBN
b2R1bGUsIHZlcmlmeSB0aGF0IHRoZSB1cGRhdGUgbGltaXQgaGFzIG5vdCBiZWVuDQo+IGV4Y2Vl
ZGVkLiBPdGhlcndpc2UsIFAtU0VBTUxEUiB3aWxsIGRldGVjdCB0aGlzIHZpb2xhdGlvbiBhZnRl
ciB0aGUgb2xkIFREWA0KPiBNb2R1bGUgaXMgZ29uZSBhbmQgYWxsIFREcyB3aWxsIGJlIGtpbGxl
ZC4NCj4gDQo+IE5vdGUgdGhhdCB1c2Vyc3BhY2Ugc2hvdWxkIHBlcmZvcm0gdGhpcyBjaGVjayBi
ZWZvcmUgdXBkYXRlcy4gUGVyZm9ybSB0aGlzDQo+IGNoZWNrIGluIGtlcm5lbCBhcyB3ZWxsIHRv
IG1ha2UgdGhlIHVwZGF0ZSBwcm9jZXNzIG1vcmUgcm9idXN0Lg0KDQpXaGF0IGhhcHBlbnMgaWYg
d2UgZHJvcCB0aGlzIHBhdGNoPyBUaGUgSUlVQyB0aGUgaWRlYSBpcyB1c2Vyc3BhY2UgbmVlZHMg
dG8ga25vdw0Kd2hhdCB0aGV5IGFyZSBkb2luZyBhbHJlYWR5Lg0KDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBDaGFvIEdhbyA8Y2hhby5nYW9AaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogVG9ueSBM
aW5kZ3JlbiA8dG9ueS5saW5kZ3JlbkBsaW51eC5pbnRlbC5jb20+DQoNCg==
