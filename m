Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A812257845;
	Wed,  7 Oct 2026 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791333244; cv=fail; b=H1VRUnxAxg5OztghaUaQU7t13+JYI5o0MKiee5Z7Ii+P4cogxDmv2o5+r7cTYpNNr39eiA2+jGGlKm7O92vtEt2Z4bQ1RhRu/R3QDQysKgS4IAtcPgHWcU4GIlauN9WJNil39OeCSULPUbfaHdSZxa8zmCV1FSRDE2F5dfDsmek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791333244; c=relaxed/simple;
	bh=z+fL18IcxTm9Je58a3rEPLoGLI7nJgNy3opKUWt7Rco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GryDjVAYWlMzNLwTM0g2SH71hJw8wL/tnNFtqCJrPfRQ0HWR9uci2cfcHm9Nu/nOff9Py6ITt7y4/jV3rqbM0vbBfNDtO7o300YZp6LfunTC2txXhF+2puRew7qNwYu+Qtt60UGgVZaSxjbf3mfkXB/psJczXUG5VioQBdGoFd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqmCVQjN; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqmCVQjN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791333243; x=1822869243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z+fL18IcxTm9Je58a3rEPLoGLI7nJgNy3opKUWt7Rco=;
  b=bqmCVQjN+xkxUm8nsGjK1PEismv9g8FwG11j5KE3nVMO8ZbG/IpE3Tey
   hqryEh9a0CdmqfA8wmF9lerlFFPVwsWLUMRURvhVBF6sXKRFw7sdWvBnr
   StIcY26yN6GCL5b7aJSJLedWRrgJJKLmK3ufBOA8CkiGVebQmtGSng42M
   3OBqNSudKn9icr009COlTJxH+vTVOJto98q5HRgcxei3zYwJZ8Elrf5C3
   /CxTJ57ksn/ZU+XJ7HvR7aJAd2vTtJt2yFWVZskuifRbVRQx2Mps/kvsw
   Tselpl2KKmox96QBqYQyRRPvk+bSDiAgVh1Wg9Xm5htupdPPUBAF7Ha5r
   A==;
X-CSE-ConnectionGUID: T5NXS0CfTfqoagwh/HEFjQ==
X-CSE-MsgGUID: +kNuOjh5TayCSIJ2ZRKnNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="94908424"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="94908424"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 17:34:02 -0700
X-CSE-ConnectionGUID: mUMP6UEkRQijlySxTtehlA==
X-CSE-MsgGUID: SVXyVFvpSAaM3DbcAu4b+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="275089043"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 17:34:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 17:34:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 17:34:02 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 17:34:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lb8WrdgYG9ENjAp+t4H892Lwl/oFtffe1s7AFGa7ewbUwvsRQgqO4Fov+e7nmQDja6tO+/TCMMsaT1flgkKmfpI3ABj1K4BwS+iUhG9Sbx1rkkwkGXDMIjm0S7gXQLhDJ70h8N9IetsXMMf6W91wPB8vJua74vcLNlFUk847tSg8/QH7YSnuXb5S/y3FKGvaZX4j6FLXBmU7+AB8OISUWuygw4/wsECdsM6EW0+UJ8dQB1GLIslaI5eatQugHXfxeZMVjRIMt91lqUdC8n1LUgwP4QoISi3SzsuRXhu5AjDqVA0VWgAYj/alkrJwVP+oCze1gNS5tfi0U6ksK+sUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+fL18IcxTm9Je58a3rEPLoGLI7nJgNy3opKUWt7Rco=;
 b=IZhK6LZuoJI5EebJmTkmRZhDeFkYJDswZO672h7oEsemPj8CDNr9qQQWuyGajJGgUteZTjVqiGdwcMgEs7YKkrieIJJa6dnhxtpiMw940mZCe9wWKJDu92WjP5HpT5dS5QSAnLMAIj/heNmEaB1v85Otjqon7rbJvU/6q0nQHVyExAObakFQa8SSbo2dIR3zmN5cKgO9ZWXue2Ld9nuKZBwl/LJhY6vzD3Te2zEFg1fuMA8wYNAXmUGevZEg3Jg0484SEDeZc5yjdKc6fwLcIbeeczsspkU5oMGz/HjbsjpswRq6/RFB9sZHaOwqoYI1f8xGmYOAHjURxy7dQtbn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA3PR11MB9255.namprd11.prod.outlook.com (2603:10b6:208:578::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 00:33:27 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 00:33:27 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan
 Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 05/17] KVM: x86/tdp_mmu: Alloc external_spt page for
 mirror page table splitting
Thread-Topic: [PATCH v4 05/17] KVM: x86/tdp_mmu: Alloc external_spt page for
 mirror page table splitting
Thread-Index: AQHdTyk6DoRqTgPWkE6/bgY4vRFaa7bxSJwA
Date: Wed, 7 Oct 2026 00:33:27 +0000
Message-ID: <0e0b2da671574f0f3e776312557794c2e7553e83.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928090946.15551-1-yan.y.zhao@intel.com>
In-Reply-To: <20260928090946.15551-1-yan.y.zhao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA3PR11MB9255:EE_
x-ms-office365-filtering-correlation-id: 488c5a0d-0aec-4276-a567-08df240a9aa2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|38070700021|11063799006|56012099006|4143699003|22082099003|10067099003|18002099003;
x-microsoft-antispam-message-info: DYXfEOAakeHPEum+62MXvHdBKFAlHe3T7g2a6t6BhUmsBAvSsEAg4OGLSfLcL4RraZ/fIQIetj8/op4BxW0bCzGKJLFMLvpxcPggWh1BNB5DLVlKOxeaGAMzzSQLuTVPZ+DwKz72XaNcTvPW0e9iEbOv9a7J5F9ILOJXr0v7nFLxxn7rjVdD7YBBt64CaqeD4rPAGfFXBBNwSnmJYYyYmyTYvE2GnFPFX+UcTbvJnDzLLmLwuQZt8+8/qVykxVqZuBJJOQPm9gyMwIHSlHxpIxTJrGMdQVfHyQ1liG7fWUgXCpmaez4yMb5DytTmNQ3eepCS+8j0AihJjBaSjHbxluxuMjCf9TcDibf1iLgZCqQOPz6yp6Y/k508NRy2rh4LT9/91FAgQiGHMiw3REnfcXApzxvC+popt602xTdx+fNFNdMmCvgpE4t9OY0cki2eZjD6NQAnWtcUo+s/N9ZHGSVn+OoqENbNIHnQzAhQRIAktvvEBtrfq/9THF9xfJF4QtaD+/y0xNQLCkrqKCQMHTtWaKfDah4iEibFRyyPkfe2KaTssNrNN6tJyW3mvG7Lljd4tekezX/z2Tgcsg7D0TvXu/NLTsxUDZZpfS8FKb+R4C5dcs/bh+fmtTKlps4zFQVFrGWFO447U4vv/+bmouuWxL2+d+UBWSxa6W1wJdrCpk5fJ4Va3/RhYkJFD4hAeVyltrZLgVtmw/4Nxnf06eE83ACEMQUz8IsyCnCTRR0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEFjT3hsOWY0dkVPemZqcEdKZlFPakQxMFF1SGpmLzNNMjBPSnVlblVZYm9Z?=
 =?utf-8?B?clJEVTFPbHczSXlOVFJHQXpFTU50S2Q2ZjkzQXdNVSsyK21CQWZQVFlhRy9k?=
 =?utf-8?B?dVQxNkxjSW5wWkFidGtwR1RLcU9zcDR3dUpsY3ltZWVnVlJBbEpKajE4cVFU?=
 =?utf-8?B?emtSOTA2bGJ5WWRmNVgzaHAwK0JnTG5YaVZMbzBqbGg2L0V2VVUwbU0vUU9k?=
 =?utf-8?B?amRwZDVEd2Y5Und1WlQwWldmbXFMZEpmTUlrMlNjVThrQkU3Sk1tRDBQU0lv?=
 =?utf-8?B?K1I0T09pOWNsSENDT2k3aXpQZm1GY2RPSk5mcHFQNU5NNWNzRFYyUzQwTGJY?=
 =?utf-8?B?dTlCcVVZTFFsM3NIaW9ISnMvS1VxQ1hkazREK0ZSQmYzT3lIQW5ac1BMMkVw?=
 =?utf-8?B?ZGtZM1p2SUFteUJYK0xXdVF4aWNmcU9KV3FUbko4Qk1XYUZQaEt4YUpTQVU2?=
 =?utf-8?B?eWdkeHBkS1FkNTJ0T0tkVGYxQnhGRnFMRE1HZnhOTk1HelltbE1GNmt0UEpq?=
 =?utf-8?B?OTNVVnAyQi9Fa2tncHd3YmRpcDRXZ3oyeU5JZVZnMmpDRDgvUDh2STF1WUY5?=
 =?utf-8?B?K2ZPN09KSHNBd2JjMzBJRWlhWmhvQXVLczJhemhTOWphYkNYOS9tS3gwU2Rv?=
 =?utf-8?B?Qm14UTVjd2QvYVVqQW56KzNSblVuVUFsbGdGaTh0MmpuYlFwalFYdHpYOW05?=
 =?utf-8?B?UUcrS1U4bXcyMEMwc0d3ZEp0R013VHd6bXM3TnorSlF5UWg2MTZ4NEM2eDQ4?=
 =?utf-8?B?bjNmRmlIUTQxZEZsbzNPT0pWUjNBemkxdWZySHcvbVJPNGRlbGdrVDNDYVQ2?=
 =?utf-8?B?ekg5YjVndlg3ODF4aUsyd1l6SDdsQW1oaXBSeFU0d0szRjJUMHQycE9tUXBK?=
 =?utf-8?B?M3FiakNCTnBHZmE5UFRsRHo0UVdEOWhsKzRNYVpFblVpS0RFYXVZNElSOTFV?=
 =?utf-8?B?QjNzWG5ienRmY0lRd3NLMEU5VlVra21lck5zZFB2NWRoS2tJVkxMWG5TTkkr?=
 =?utf-8?B?Kzc0Ty9oaVdydmtTTjZQOElDcWllOGtlL1B4TXpRUzZyaFQzSXM4THhiYjhl?=
 =?utf-8?B?VVE0N1NXaE04L25keE1wMVB4S0lLSlNYYS8zRlVYTWZkUURpOXVCYXpocjRB?=
 =?utf-8?B?RkFnZkVHSTZMc3hhZzVuK2xqdnhMbkxvQXhKSHJxNnJYblZzbDZMa0RaNFZy?=
 =?utf-8?B?eExlVGVwcXV2WTRvdlRadm9sYU1YWHZnVFJia0toMWV2cDVzbEFGZytGa3FC?=
 =?utf-8?B?eXgwNmgrdm9hdWh6Uk1PY2ZHU0NCV0lqZ1ZRK21SYVhBb3lLT0g5TDMyZXBN?=
 =?utf-8?B?N01wMUtpOC9iSDdYeCszSDRRa3RUWE9wUDZMaXhZTWJRSVVOdVBvb1hQRFZN?=
 =?utf-8?B?QzhFWHR5c2QxemFTRzg2QU1qd3lHZnFpZU5MZzVxREdJVWQrT0xEeHpvT2ZV?=
 =?utf-8?B?YWNMTkpBU3Vkb3VuQ2pGNGxldm9oR3c3M2Z2TlFLVTdackxMckpISytUYjZl?=
 =?utf-8?B?NHlSaVlsdzJoOTlNZ3dLbG02S2E3YlhFVkZTZVNMK1NETWVTSmZsdjF6U3NM?=
 =?utf-8?B?akdVSGZ5NHhiQlA2cDlpaHRtMGtnVXVWdXpmUUpoRllEbnZJWCt6WU9YeXBT?=
 =?utf-8?B?UW5aWXBGOVhIWEVnMUpVUlBTWHIzTXdzVXVuZE9GSm1VS2pxZHp1Y3M2VmNB?=
 =?utf-8?B?VTJEVlVhY2pJbVMxSUV3T09yOGhpZzRzNFI4NGxWSjVDWENicEorTWdSNVRy?=
 =?utf-8?B?OFc4OUhxS1ZIRGpMZTJFNHM5VWdRZm13VjJPcldQNTljWHZyb2lKZkdqRk5F?=
 =?utf-8?B?eXZPWmJvb2JFNk82R1ZCRXl2Z2VBeXJhQitoekJ1cHZwU3huNitncWltVTl0?=
 =?utf-8?B?WGdKSEhDYjY3OGVBMmplWmpjcDVjc2poUEc0cDA5WGVXam1JUzhXeXJsMktY?=
 =?utf-8?B?dnhGMEc0RXd5RkxCWkt1ZEVrdEwvK0tCOXdqWTJMdkc2V0dxYzd1c0RSNkdm?=
 =?utf-8?B?ZVBYVmtZQlYxRmltWjJWT3JxNmJyL0FpSElRRTlkbFlkdnBkREFTRm1yTWJh?=
 =?utf-8?B?SkNzMnF0dEl1ZFc4Sk85emt4RmVOZ1ZVcmVnU1ZnSWFLU3BCN05FNVBWT1Ja?=
 =?utf-8?B?anE4dWlrZytqNzdmckhGeEJ0NWdzY2lZbk1JUnA5dGxOdUlxK2lSYlZES1dt?=
 =?utf-8?B?NlI2SjV5UGlPTXp5UGVGenNvdU5VOGgzdE9QQUhtM0lscFI1VmhwcWRCYThW?=
 =?utf-8?B?V3Vzd1BjejI4b05ud2NjUGQ4RXMwb2ZkU2hTbS80Q1Q3cURQYWZyMi9PUnVk?=
 =?utf-8?B?OEh3MnBWcjFzREN4QVphaVFUMytTVkNmZ3liUTJYa1ZESkh6MVQ2OU96dFJl?=
 =?utf-8?Q?R/Eh5YICT/n8MPGA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05E626597551E3439056F6CBAAE92B6F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GOWqFRMTsNqvWdatUNXso4t6cbtTbKqRpUbmHvLBnht6CQb9wreYecWPWV5g38UAhv3SjSPv+OOCikHnOTSrrbC2Vr7kwKT5+IoQRBw7oRw/Ydg3wAWAsMzx/8pLUbDjjQyJEZdcRzjkdm/Me8C4f8LraC9eFKeZNrc/vNdN7PDlW67X/zr59AmFXeOhUW7RF3i749WZxTq3FHG17v0wy7VC5bSNHgJ7vryMDgbjMeCI6a1tlNN3YySQQuHSjWy5L0+u6Ct/tZphr45sPWdxkfi75MvOZPZkj/cGQggyNmKdNKM0Wzjb1JfM5GFDIvhtetiFglY3Xm0K9ofIcXYx4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488c5a0d-0aec-4276-a567-08df240a9aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 00:33:27.2107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCJy865orQCeiTSZWpaZyZvZny6VB3mKV59N0tpJdtXKKt+FJJxzT/3RdWLurwGy+HnNKlLk9ybQikbiaETmAFcqqdGgr1x4KN5J9sdkS1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9255
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjA5ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gRnJv
bTogSXNha3UgWWFtYWhhdGEgPGlzYWt1LnlhbWFoYXRhQGludGVsLmNvbT4NCj4gDQo+IEVuaGFu
Y2UgdGRwX21tdV9hbGxvY19zcF9mb3Jfc3BsaXQoKSB0byBhbGxvY2F0ZSBhIHBhZ2UgdGFibGUg
cGFnZSBmb3IgdGhlDQo+IGV4dGVybmFsIHBhZ2UgdGFibGUgaW4gcHJlcGFyYXRpb24gZm9yIHNw
bGl0dGluZyB0aGUgbWlycm9yIHBhZ2UgdGFibGUuDQo+IA0KPiBXaGVuIHRoZSBtaXJyb3IgcGFn
ZSB0YWJsZSBpcyBzcGxpdCBpbiB0ZHBfbW11X3NwbGl0X2h1Z2VfcGFnZSgpLCB0aGUNCj4gY29y
cmVzcG9uZGluZyBleHRlcm5hbCBwYWdlIHRhYmxlIGFsc28gbmVlZHMgdG8gYmUgc3BsaXQuIFRo
ZXJlZm9yZSwNCj4gYWxsb2NhdGUgZXh0ZXJuYWxfc3B0IGluIHRkcF9tbXVfYWxsb2Nfc3BfZm9y
X3NwbGl0KCkgdG8gcHJlcGFyZSBmb3IgdGhlDQo+IHNwbGl0dGluZy4NCj4gDQo+IFRoZSBleHRl
cm5hbF9zcHQgd2lsbCBiZSBnaWZ0ZWQgdG8gdGhlIFREWCBtb2R1bGUgYW5kIG1hcHBlZCBhcyBh
IHBhZ2UNCj4gdGFibGUgcGFnZSBpbiB0aGUgUy1FUFQgZHVyaW5nIHNwbGl0dGluZy4gU2luY2Ug
dGhlIFREWCBtb2R1bGUgd2lsbA0KPiBpbml0aWFsaXplIHRoZSBwYWdlIGNvbnRlbnQgaW4gdGhl
IERFTU9URSBTRUFNQ0FMTCwgdGhlcmUgaXMgbm8gbmVlZCB0bw0KPiB6ZXJvIGV4dGVybmFsX3Nw
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IElzYWt1IFlhbWFoYXRhIDxpc2FrdS55YW1haGF0YUBp
bnRlbC5jb20+DQo+IFtzZWFuOiB1c2UgX19nZXRfZnJlZV9wYWdlKCksIGxldCBpc19taXJyb3Jf
cm9vdCBiZSBjb25zdCBhbmQgY2FsbGVkIG9uY2VdDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hy
aXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IFlhbiBa
aGFvIDx5YW4ueS56aGFvQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWWFuIFpoYW8gPHlh
bi55LnpoYW9AaW50ZWwuY29tPg0KPiAtLS0NCj4gdjQ6DQo+IC0gImJvb2wgbWlycm9yIiAtLT4g
ImJvb2wgaXNfbWlycm9yX3NwIi4gKFNlYW4pDQo+IC0gVXNlIF9fZ2V0X2ZyZWVfcGFnZSgpIGlu
c3RlYWQgb2YgZ2V0X3plcm9lZF9wYWdlKCkuIChTZWFuKQ0KPiAtIGxldCBpc19taXJyb3Jfcm9v
dCBiZSBjb25zdCBhbmQgY2FsbGVkIG9uY2UuIChTZWFuKQ0KPiANCj4gdjM6DQo+IC0gUmVtb3Zl
ZCB1bm5lY2Vzc2FyeSBkZWNsYXJhdGlvbiBvZiB0ZHBfbW11X2FsbG9jX3NwX2Zvcl9zcGxpdCgp
LiAoS2FpKQ0KPiAtIEZpeGVkIGEgdHlwbyBpbiB0aGUgcGF0Y2ggbG9nLiAoS2FpKQ0KPiANCj4g
UkZDIHYyOg0KPiAtIE5PIGNoYW5nZS4NCj4gDQo+IFJGQyB2MToNCj4gLSBSZWJhc2VkIGFuZCBz
aW1wbGlmaWVkIHRoZSBjb2RlLg0KPiAtLS0NCj4gIGFyY2gveDg2L2t2bS9tbXUvdGRwX21tdS5j
IHwgMTQgKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9tbXUvdGRw
X21tdS5jIGIvYXJjaC94ODYva3ZtL21tdS90ZHBfbW11LmMNCj4gaW5kZXggMDAxNDQ5MTQyZDMy
Li5mMzMxMTMxN2E2M2EgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2t2bS9tbXUvdGRwX21tdS5j
DQo+ICsrKyBiL2FyY2gveDg2L2t2bS9tbXUvdGRwX21tdS5jDQo+IEBAIC0xNDY2LDcgKzE0NjYs
NyBAQCBib29sIGt2bV90ZHBfbW11X3dycHJvdF9zbG90KHN0cnVjdCBrdm0gKmt2bSwNCj4gIAly
ZXR1cm4gc3B0ZV9zZXQ7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBzdHJ1Y3Qga3ZtX21tdV9wYWdl
ICp0ZHBfbW11X2FsbG9jX3NwX2Zvcl9zcGxpdCh2b2lkKQ0KPiArc3RhdGljIHN0cnVjdCBrdm1f
bW11X3BhZ2UgKnRkcF9tbXVfYWxsb2Nfc3BfZm9yX3NwbGl0KGJvb2wgaXNfbWlycm9yX3NwKQ0K
PiAgew0KPiAgCXN0cnVjdCBrdm1fbW11X3BhZ2UgKnNwOw0KPiAgDQo+IEBAIC0xNDgwLDYgKzE0
ODAsMTUgQEAgc3RhdGljIHN0cnVjdCBrdm1fbW11X3BhZ2UgKnRkcF9tbXVfYWxsb2Nfc3BfZm9y
X3NwbGl0KHZvaWQpDQo+ICAJCXJldHVybiBOVUxMOw0KPiAgCX0NCj4gIA0KPiArCWlmIChpc19t
aXJyb3Jfc3ApIHsNCj4gKwkJc3AtPmV4dGVybmFsX3NwdCA9ICh2b2lkICopX19nZXRfZnJlZV9w
YWdlKEdGUF9LRVJORUxfQUNDT1VOVCk7DQo+ICsJCWlmICghc3AtPmV4dGVybmFsX3NwdCkgew0K
PiArCQkJZnJlZV9wYWdlKCh1bnNpZ25lZCBsb25nKXNwLT5zcHQpOw0KPiArCQkJa21lbV9jYWNo
ZV9mcmVlKG1tdV9wYWdlX2hlYWRlcl9jYWNoZSwgc3ApOw0KPiArCQkJcmV0dXJuIE5VTEw7DQo+
ICsJCX0NCj4gKwl9DQo+ICsNCj4gIAlyZXR1cm4gc3A7DQo+ICB9DQo+ICANCj4gQEAgLTE1Mjcs
NiArMTUzNiw3IEBAIHN0YXRpYyBpbnQgdGRwX21tdV9zcGxpdF9odWdlX3BhZ2VzX3Jvb3Qoc3Ry
dWN0IGt2bSAqa3ZtLA0KPiAgCQkJCQkgZ2ZuX3Qgc3RhcnQsIGdmbl90IGVuZCwNCj4gIAkJCQkJ
IGludCB0YXJnZXRfbGV2ZWwsIGJvb2wgc2hhcmVkKQ0KPiAgew0KPiArCWNvbnN0IGJvb2wgaXNf
bWlycm9yX3Jvb3QgPSBpc19taXJyb3Jfc3Aocm9vdCk7DQoNCk5pdDoNCg0KaXNfbWlycm9yX3Jv
b3QgYW5kIGlzX21pcnJvcl9zcChyb290KSBhbG1vc3QgZXZlbiByZWFkIHRoZSBzYW1lLiBBbmQg
dGhlIGxvY2FsDQp2YXIgaXMgb25seSBldmVyeSB1c2VkIG9uY2UgZXZlbiBhdCB0aGUgZW5kIG9m
IHRoaXMgc2VyaWVzLiBJIHdvbmRlciBhYm91dCBqdXN0DQpoYXZpbmcgdGRwX21tdV9hbGxvY19z
cF9mb3Jfc3BsaXQoaXNfbWlycm9yX3NwKHJvb3QpKSwgb3IgZXZlbiBqdXN0IHBhc3NpbmcgdGhl
DQpyb290IGluLg0KDQpPdGhlcndpc2U6DQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8
cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQoNCj4gIAlzdHJ1Y3Qga3ZtX21tdV9wYWdlICpz
cCA9IE5VTEw7DQo+ICAJc3RydWN0IHRkcF9pdGVyIGl0ZXI7DQo+ICANCj4gQEAgLTE1NTksNyAr
MTU2OSw3IEBAIHN0YXRpYyBpbnQgdGRwX21tdV9zcGxpdF9odWdlX3BhZ2VzX3Jvb3Qoc3RydWN0
IGt2bSAqa3ZtLA0KPiAgCQkJZWxzZQ0KPiAgCQkJCXdyaXRlX3VubG9jaygma3ZtLT5tbXVfbG9j
ayk7DQo+ICANCj4gLQkJCXNwID0gdGRwX21tdV9hbGxvY19zcF9mb3Jfc3BsaXQoKTsNCj4gKwkJ
CXNwID0gdGRwX21tdV9hbGxvY19zcF9mb3Jfc3BsaXQoaXNfbWlycm9yX3Jvb3QpOw0KPiAgDQo+
ICAJCQlpZiAoc2hhcmVkKQ0KPiAgCQkJCXJlYWRfbG9jaygma3ZtLT5tbXVfbG9jayk7DQoNCg==
