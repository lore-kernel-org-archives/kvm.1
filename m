Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586B35AC0C;
	Thu, 12 Mar 2026 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283390; cv=fail; b=afC749nNKfmDuD4AiB33qdq4cB2u0Hg0IZs61ZKtPDZaMaOnLP5iEs/9gVePNfMvI9LouyyJDydXA7m5Cum85XdGh+9Cujql2DBY41J5V2hYF8z6sv4TGJRTnW9iWtFjqIBv7RcDDUvf/fBeEihbTceicbb1fw8b3u90LgaKgWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283390; c=relaxed/simple;
	bh=fBUc0X+suGpafU3cHtOxt6WB7FkXwlSsxUdSAwl6A6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mhDOjC9XCCtGAJMk96wiRfV/RtcU0/0cif4B9SaAFO+/LH3Z4UNNyW5mjA8oX/ZoWZcX4IcuR6xSF+KDq+C/9bIFnPr/IeYNt5U9FbTvOpwPsE/MgPwaHQu3+RCqSqtmOtyWp2tWdGCtAOAPqnkawexCPTPjwT3vN73CUE+TOmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeZ+319T; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeZ+319T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773283387; x=1804819387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fBUc0X+suGpafU3cHtOxt6WB7FkXwlSsxUdSAwl6A6I=;
  b=HeZ+319T0vVtEtU3j0fpfhItfS9WwM9ms23z7OKuQCgxY70lVioYlsP4
   u/6cqxV6hxbEBOEcsPNTneWRHeBGfitUNI6lCwGbABNuVXMZZYhSs/RXT
   BrParRQYikyBSBftcycpa3fisTMfy2Y7OTTPeXfRptIxo3UREfCCQ5+A6
   jxk3dBNE8Hl99GQ7SUnjg4LasJXo1oIA6xUayNXoRRi1HFVnJ0yGLLqST
   v7GB3yaG87LioSxtnPufdZ82DHY75/QiHGWVQ5j+iaSO+yyn8jDmaz2qB
   0ucC4gakvwm36VXkvUePgHHITzM7RN+s9f6U0Dla6DZ5JmMA7PIVo3XKs
   A==;
X-CSE-ConnectionGUID: L7MjUvXOTIyRMtCyInB2jw==
X-CSE-MsgGUID: E4xGyseCQ7Cdq4o8CjJa7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85843659"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="85843659"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:43:07 -0700
X-CSE-ConnectionGUID: zCPP5o5STmKPl/zSZ0sdIg==
X-CSE-MsgGUID: NM1uUM2CQJirrwaTNferXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="246135799"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:43:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:43:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 19:43:05 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:43:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMPyuVIFvO4XI50sjaErPtD/hClggbN76mL8L9dRtMicSz77Pf2kxe4uF4GNDi4ua+Vsky/U5jRFJ368nytPYusWg2ihWnTLPiQwg7/CFP8uskecAYnTuFLJqNyc5u5+nxTLjQNZTLviyQvUVP1VheRvsjsCUfNRrh6CvvFGBPbuq7iA36ML42eDp7yuTT+O4DHSiVhNu3WEe1avbHwWkBu2GLhlb6VE51JFWNME2g2K15rRqBKaOWUWP94Gf98ZVJSZdD79/9spX3n5pQBYQli4ndAGTww8Exuqi6BajrnEia3CQ9cVrAG3NRIGP6OaZlx3aoB4C105zveqMsJlJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBUc0X+suGpafU3cHtOxt6WB7FkXwlSsxUdSAwl6A6I=;
 b=cWaijtblpaaIzoD35wv2ySbMcDaIXA69/lbIfoAe9aeHCNa3SJ6RKSwZ/V60nLMx2U5KdqnU8EvzfqEjDwBFUY1/ayMXuEqcEumuw0rzRB4520i7ir5fBjVlGf3NnTRRdsLTNOVuLlh0jsr57KmECn0Wuyy9iWW02ELs3/00FnNEiL7HAfGi8OKAH2kA5/832quXoCn8jodFEijwodT775WgNc6Au12WU9Y0zQFOUgPDR2aHvWq/z6QQf22EOLIBwH2dV/smcW9rfNbak/L5qnRHll+yVhFkP1qBm0UHfSaTEj/zcL39s+dRhggEMf7/Op4zD8O5tDtXRk5eyBKs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA4PR11MB9277.namprd11.prod.outlook.com (2603:10b6:208:55d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Mar
 2026 02:43:00 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9678.017; Thu, 12 Mar 2026
 02:42:59 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Huang, Kai" <kai.huang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Weiny, Ira" <ira.weiny@intel.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "sagis@google.com" <sagis@google.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 23/24] x86/virt/tdx: Document TDX Module updates
Thread-Topic: [PATCH v4 23/24] x86/virt/tdx: Document TDX Module updates
Thread-Index: AQHcnC0E9TcZfkXAtE6eaAXYVeJZxLWqW4aA
Date: Thu, 12 Mar 2026 02:42:59 +0000
Message-ID: <9127d34e042a5877f76488c7d31bd0458510772d.camel@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
	 <20260212143606.534586-24-chao.gao@intel.com>
In-Reply-To: <20260212143606.534586-24-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA4PR11MB9277:EE_
x-ms-office365-filtering-correlation-id: dd0928b8-ba61-464f-32ac-08de7fe112f7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: OHG5wOdk9OhTJXtIZ73T1Cm689QqOvrqkpeJQGgvIlM0zd4Q5xbDnzdjfUJIH204F9rPqDeUyorRTXbMxR1L5eN6+aLiIx9OD4HY7KqqXq99idKdAhvEK5ri0Tj0ZYKDx5mH/sQdXnDkiP7xyMDi8IcgTx98cbiaWUkS4LfodYOQK9Z4ERo7Yw57jx0UkG5d9wsqNxu5haXDGhc5sHXL2joI4nC3pXh2BfGaH+RTEFF6b1LY/SJgRm5LbtJKYdhV3GpPy49Lf4isqU4z9MiXs+dvF+lvRtf2YrRuoamJlfFV1XF2QVd0y+odjjwAg+c11k7+RGgdvHSyYwQS4XCjAlQEghBbnuNRQ+hEMPdkkM96trflzhaBYoq6UPE0LbwzI2C1SJv2XQi73o9QVv7G4QrPlrQ2B07fwX8oewtO5MDaMd37zxVmpzERA0cNoiaz0qysTSXQFA3B2I50vRxZ1ToKMZ36vQNafA1iYeUieLadWwmQ3ugZjMz0xQ+65/QdF9STRQLgBzmonGf6mznFxxGax6oKAlcoBaS3nq45E/IHmfeA1lUs8ZeZJPWn1AmP9pNQiODHeO25Lr7qlRwK33Xf15DEEnmn4rL9y/uUkfynA7nKsE6E4Q6CXe04Vpbqu3SHWDrcX6/qColE1+IJ0thBzplD7TE2Qxb4fRBlTjrdVZrg4zUtTl3JsnjY1EulcAsMjzZfC9vTU+17NV5LNWq4MpvBI15FIowynvIwfmkcToUFPEU8kiRkqrbtROpp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1VicFRMaWRpZCtrb05rdkp1ZDQrUmRMdjlCb2cwdVFmWVI2eG5lVnFCK29w?=
 =?utf-8?B?T1d6YWdVUGJ3SGdtaG02ZDFGZ3U5Z2NpZjg2dmN4SnpMTHdZc2hmSm95QjJs?=
 =?utf-8?B?WUQvN1lNNW9KNC93WFZKUWEvOEVZYjZMUzNWVm1vODJRbnZxQWZ5VDdvZ21X?=
 =?utf-8?B?dCtOeUErZGhkYmhsTk40Y0p6ZGxmZVFlQ00razBwaXdhbzBZR1JBNDBhRTFM?=
 =?utf-8?B?dXp6RzUvVmJEaDBPT2cvWVlkM3VVVXNPRWdLRUpIUDBZRmg2STFETWNySXNz?=
 =?utf-8?B?dEoxR2JvczJidEY1aGhzYmwxM2dOVnVRV01CM2JTdU1YcFhzU2NwNDFJblpx?=
 =?utf-8?B?cWZNZlliUjY5L1pMVGNkL3ZiMTFMMzIxVGJQZTFYanJncUhXRUJQWE5wbE0z?=
 =?utf-8?B?WTJORWwvdmJ3M2FxM3hON2VpRThZRTRaaU1GSXdKamdMa3BuNW11aStYbGFv?=
 =?utf-8?B?TTh2bEVUV0s1RVhjL3ZRdkMvNDc4VlVwazF4cm9Ic3k0c0YyL1dqZzZYN3No?=
 =?utf-8?B?VzZNdU01d1BBWENCQ1FSVkk0c1U5UVl2TmZSTlEvKzVnT1AxbGw1QUNSMi85?=
 =?utf-8?B?SjNjN0dSR2VvSDBsM2ZUVUxKN3F5SDVNMXkwYy9WcmV5VUl3Sm0wZHczaUFM?=
 =?utf-8?B?UVkzSThkQWlvcHdPZTVqQmNYMGNyNDd5bGM1eVhVWHh5dWsvQnlvUU9qQVh5?=
 =?utf-8?B?Z3hZUEEyYnBKQ3Q2ZWl4dmNxQUVIRGdVUVlFVC90ZGpuVlZUQzJrUEh4R1Rp?=
 =?utf-8?B?TmNWbUVTSFExNVlEbENmc0ZsOEwvWEhmR2pvL1Q1MERHOVhyN3UvTFVZaldI?=
 =?utf-8?B?QlRVRFN3YldiUzJNdUl2SzFna3dZY1p5U3dDMmRFODIrWWRGaEQ1NzNWY2xB?=
 =?utf-8?B?WWhKZXcranlpS25NSnNrbkUyck8vWFFhSTRGNFRWb1RIY3Y2ZlpnWHNqZk0v?=
 =?utf-8?B?OGdjbEZud3JPelhRMEdiY3crMDBEZ281UnB3SERXeWNTN3RKbk1IL3UwTGhm?=
 =?utf-8?B?R1M4UjhkeXFhaDZlTGhmU081V3ZZTmpFaFRHWXQ2NnJzcmEzV2VBUTIvVGNa?=
 =?utf-8?B?RDdUOHZkU2svVTVMYk9wMW9JQzQzMElVVExTREJhVDN3TnVpUXRXdVRkbmRM?=
 =?utf-8?B?UUpuRjluc1BxakQvT2Y1S3hIeHBUb0NHZjh6azZOK25xLzRKcDBMUjFJdHI4?=
 =?utf-8?B?ZUFGSU1uRG4rZjZ2NkJ2ZWxoUEhpaTI3MzErSFFwcVVJcmIraytnMVFEY0Vq?=
 =?utf-8?B?T051MmJqa2FZWkhWaWRMNzhiZ0RlVlEwNytwb0I1dWhQQ3FMWEtwRU83UXVx?=
 =?utf-8?B?MjR2bmtxVDBQUHd3aVNIbUZYTnNneTBSa3lQVU9FV0UrOFFuTWN5TEZiRnVj?=
 =?utf-8?B?ZXE1eVJhMnNNK2poZnJKQ1p0OHJtQTRBMThCVnA3YnlHU0pQMHo0WXZ3V1FJ?=
 =?utf-8?B?em5ZNy95NUEvVHF5bERtdE5YTXVabG9PSHU1SmRMa09BdXY3d2pCcUhPUk9X?=
 =?utf-8?B?NGwySzE5NG1rbXFWREJ2TDhtUnhxd2dUVWl0dUVWUVcxZDZTQzRTLzRpcWlH?=
 =?utf-8?B?TVNCL05lWTNyckxLWWxXV2FSVE0zQWRyY3dEQUluR0FQUEY2TUlwZUl6RDBu?=
 =?utf-8?B?VmwvQ2FRMWhXcWpUZjVoTXFrLzJNT251RmpIK04wajhQdlh6REZFZnF3Y0JP?=
 =?utf-8?B?eXFuVDBUcjVLZmh5MDFXTFk4L2VyTTh3ekJXYjdQZUNDZzVwZE44ZFNybzdx?=
 =?utf-8?B?bzBGeG1NZ0JzWDliVmh6cERrazBKNjdTeGJzTGFiVU1VNW5HT0JJSS95bm5K?=
 =?utf-8?B?NzVxOTdkWXBta2w0Rks2TXNvUGRQVGxmRzFPRXE0aE1MYzRxQkk1UkEwY1hq?=
 =?utf-8?B?bWhlZTE2a2VoSUh6c2VzNTZZSWliZThsU09wTng1VFdaWlNQRmpqcWFRZ1ZW?=
 =?utf-8?B?ekZORHJNTUhBbGc0Z21CdEphNy9NcG8wYkJIdGFnMFk5Nk5qTEhDR2gzcWxC?=
 =?utf-8?B?WFJkRnlCU3R2UHBjaFFET1pNR09YZ0NmZ21KQ251MDhkYkozMnFXTm5qVkhy?=
 =?utf-8?B?YjErNVBzV2t1S1lGb2MraS9WTXI5WWdEVDZKdXBlZTl3VkYwY1I3OHNrN05S?=
 =?utf-8?B?dlJCbXJDeWFjR1BGK25qQ0g5U2hIVzU1T0NMbnYxMGd0dzZEbVl5VUJPblZO?=
 =?utf-8?B?TEM5RDIrdjU4WlEzUHl3Q1pZVXJDZzlmNFIwSEgyUTRrNFJRZ1g3NG1Td3Ji?=
 =?utf-8?B?WmNTU2c4TGgveHFENTFQd0RTZzMrZExMZkp6bFNzZjFxSUdHMUdvcFpnN3N5?=
 =?utf-8?B?MzVCK25lT2ZLaG9GanNQa0FiLzd0Rm82OE9temVBRjRmRENuR1BISnJLTUht?=
 =?utf-8?Q?owBE7A4p7MsJ7sz4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31E03CC01E2B5143B9557D7BB258A997@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0928b8-ba61-464f-32ac-08de7fe112f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 02:42:59.5263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TiL/kurR92/LbKui2/sW0mRpEZrmlg469fJI0vWJNOKnqlXpiOWbdogQNuf3ATdoaGl70LrZlPMdJN6pf5HchmNoaLLAfmHnqRDp/wFNlkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9277
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTAyLTEyIGF0IDA2OjM1IC0wODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gKw0K
PiArR2l2ZW4gdGhlIHJpc2sgb2YgbG9zaW5nIGV4aXN0aW5nIFREcywgdXNlcnNwYWNlIHNob3Vs
ZCB2ZXJpZnkgdGhhdCB0aGUgdXBkYXRlDQo+ICtpcyBjb21wYXRpYmxlIHdpdGggdGhlIGN1cnJl
bnQgc3lzdGVtIGFuZCBwcm9wZXJseSB2YWxpZGF0ZWQgYmVmb3JlIGFwcGx5aW5nIGl0Lg0KDQpN
YXliZSBhIG5ldyBsaW5lIGhlcmUuDQoNCj4gK0EgcmVmZXJlbmNlIHVzZXJzcGFjZSB0b29sIHRo
YXQgaW1wbGVtZW50cyBuZWNlc3NhcnkgY2hlY2tzIGlzIGF2YWlsYWJsZSBhdDoNCj4gKw0KPiAr
wqAgaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2NvbmZpZGVudGlhbC1jb21wdXRpbmcudGR4LnRk
eC1tb2R1bGUuYmluYXJpZXMNCj4gKw0KDQpJdCBsb29rcyBnb29kIGluIGdlbmVyYWwuIE15IG9u
bHkgcXVlc3Rpb24gaXMgaWYgd2Uga25vdyB3aGF0IGtpbmQgb2YNCnBlcnNpc3RlbmNlIHRoaXMg
cmVwbyB3aWxsIGhhdmUuIFRoZXNlIHRoaW5ncyBjYW4gbW92ZSBhcm91bmQgdW5mb3J0dW5hdGVs
eS4NCg==
