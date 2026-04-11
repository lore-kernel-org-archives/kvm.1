Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB17247291;
	Sat, 11 Apr 2026 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775873190; cv=fail; b=Cym5G1YtNLKv0jVZF/Q3/k9k4fJFOQsKKtUvpffXMNdlv3F5CcAVr/seAEITVPsM9JI/l66zCPESWj8TU+mvKtfY/4uL5UDR2qLRal4vX7EaurLSkYippfporwO1VEH0RYDGEL+sX8Op6i0JB1D6jKbSrBB+g2OB4+XqjgrMCjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775873190; c=relaxed/simple;
	bh=WKm0bGoFJ/VArRzK5sadmTG3yJ+ZZ+VnolIJEPI4HiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YTzVQz6K2xnbGNWYnMSKYkTFRT0KN5+AMY3+Lvu++s5JrClXHipKicyr37N51k/Rs2gg9CkbeB5rpNEhfJddpfUD3IrxKlMB66WsvEPXMpeGWjVpWyWmYO6D0N4y4jaTR/PDUc+XwtGL7RUlk0UQlFGHFVkz9BTAqqGSvoCBqxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ni/MSuIt; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ni/MSuIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775873189; x=1807409189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WKm0bGoFJ/VArRzK5sadmTG3yJ+ZZ+VnolIJEPI4HiM=;
  b=ni/MSuItAkS+Op0hOMZ3G/Uwhax92qjovMbCQwaROuVwxSRpS2nXZf9O
   0B55sklHf4tGOM7/MdDr7Wiy5ic5WkgZN9Q6h9vlFV4eBsqtqMWQYXzrI
   Gfsx9pg2DmP791NMW6/HWrFkBHyvOTL6DfPPDHiteUY1U+sOiaxCYSx0T
   3BOQA5ICFxu21Jg/8iNK+BkvBFkt29kMQDT+dzQleywHoqAVniiulOK3o
   TPT1H6cFkrMs3QjpYaCsJW1mq41aJr+sAlJy1n7IBU3j6+r/NCwdlvWBL
   nlPzLXQKkB9kpQ3E6GqxmGFx0/hmSHQn88pyxpvvHP88JqSwTo19ltKy1
   g==;
X-CSE-ConnectionGUID: 9gCkFDWnQCatne2V4ow+/Q==
X-CSE-MsgGUID: kvGtTr6ySLi5f+SuuG36Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="102353875"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="102353875"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 19:06:28 -0700
X-CSE-ConnectionGUID: s2xUsxYOQ6iUMUJOnRftWg==
X-CSE-MsgGUID: Ur07EOZvS4SXPGg4UUrVJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="228225283"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 19:06:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 19:06:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 19:06:28 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 19:06:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BotLsbCPlAVCX9+ZIMxaF9t6E7dV/b5+Vvsl2kr7Gby7K0/O8QpxEwWzR4vZ0Dj3IZYp25LE2DcmQIXpmh1vJo3hHavLvXxm7+lEN8KaQfzu/QZmcsPQUXb7iKDqX5izO8zN+YQj0n++wrHO62XXs96ELFH2fZ5xtTdDyXZrOiR7VQJh6V9rj9u6EZ8+wp8kORy0+lk1FcqP+9Ch7NVHcDMdbArvbfH0UrYJClL0vOPzyoS6txGEaYU92uyOycTOnlAIctCj5J2iXC619aeRUd15IPUdkNIq1gUZ2ad2XvNT0+8hrz+4UX/Ax2ilLpsCJ8uZrdF0Bk0nYRC8RhnRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKm0bGoFJ/VArRzK5sadmTG3yJ+ZZ+VnolIJEPI4HiM=;
 b=gu7cxgphfTVtuDFrRX5ZphA/1LM4/v9elaBktxd+ZUieFMFz1TDQFbQf5ppiPz/7uwDBj2iuK1kgmNdfEjo+rLYekgEYuPNNj5IacV80wzg5IIXzMi5ruIeaiH66oCWahxjTCUfToTxMBIz484PpJzbkWNJsqDaf2Zi+YhrdeGu/Fh+2Ltb7pBfdO+QGF5RTTNRdCnfHsy9JrGFu9U4yxG7Wj50DLXHMSAVFk17vRK39KwZT4D3LWMmruEGpyGfIjrrJ2x2xngdIBIyZIrjuEeHrPoE7zw/zxt+pV08Lko2BoMMus6/4+ewH8nCWV8XDUk8a8xFIP1DPc5QZi08YZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Sat, 11 Apr
 2026 02:06:24 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Sat, 11 Apr 2026
 02:06:24 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 15/22] x86/virt/tdx: Restore TDX module state
Thread-Topic: [PATCH v7 15/22] x86/virt/tdx: Restore TDX module state
Thread-Index: AQHcwQwGBQTdkoQrn0uWtifigogDmrXTjAIAgAWhfYA=
Date: Sat, 11 Apr 2026 02:06:23 +0000
Message-ID: <900333d28647f21da461fadf31edf2d3c8d1f991.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-16-chao.gao@intel.com> <adTzamrJOOy+fGyF@intel.com>
In-Reply-To: <adTzamrJOOy+fGyF@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB6408:EE_
x-ms-office365-filtering-correlation-id: ad7c6c6f-730a-47b1-c57e-08de976eeead
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: mSCZjHyOZelRD6aM2VHWfvHu3bpOs6U322lRodYSG/Df9o6Ay50NVhqwrGtxrxs+oQsTa8n2Isq3xBwHbpGhZbR7BPAqq1TsNC824AooBcj4QM50tJO7GgMKQ4+ZKxNbemyjBw1bHKDLoW+RYgNARmrZLXn4GHxtAltma1LYOqjtOh/LYLn6DUwo6aXkpM8QZC1ljcRekF1nrRqd4QbfYS4OJ30acWoQAhc/pphUm49kwYHXPNRf1Na5X+nCfm7nUHN3e1vKnqnEVg8xIsBvDPzQ1gFZMOd1Z2MTmmzL7PCjwzIpF4luiuLJf+hmYgFC5bxW0iancJz63FAV+s8i2Hjq9cqmiZjEeXxtVkkhp5Njmrqck5Wl9kX3o/ojV41HjcNQjM2bAxFJyaEgXURGcT2w9NlIKs/R7SfGRbIwHVva6bEum/DTgyVyJScEwUK+9MfAEaw214rTXlIcu7lTYHxWO4rDtuzDp4gOBOLKWXqOuF6QAVcnjuUeKCl+Y4ctUwJs/tcjDBQPXG3vfOhwl4bNcHsDo3G6uBy5zvVQruXnKW5UT/Z4Rve8j0BqY5V/uqN9/OQRcHOoz7jOBLRe1eUfDENo0EE6zw3Eplx6PoGyG+Bk0+FW2mvruNLSo29BNdTLvTWmAF234RWr94E0lumu641V9MV0cSKR7FR5/te/LARvKSpbxzfUvDlee3extQE43+qUBmvbk4dUMp0gx5MbssIoK3l89FqweiNp46oNbNFtihiq9tutuizT5Rkh++sBtD2Zd+8yR4RV2Yi0phPzyuqE7oyELlJlcMVUW9s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SC9TMnpmVy9PQjJlL0JmZzllamxKWHZncU43WmVXdFFNeklDSWE0SXZsQnBZ?=
 =?utf-8?B?Uys2YTEraEhOZmRwaUhrbityWEVoSjJJRFExNXk1R29jMCt6elU0ZjZqbVVR?=
 =?utf-8?B?UFVrakFoMVh0ZnZ5YTYydHY4Z3huSi9MRUNaV3JPTlJ0azI0c3d0LzM4dzU3?=
 =?utf-8?B?TUMwNUhPNjdkRjJVZGFDWTVuREV5SnZOR0JEd2NSSjUrUVpTMlg3dXJPMWZN?=
 =?utf-8?B?cjJnSTduRVduNVNnbUREUWJBOWNlN2ZnbVQ3R3g3SVY3VW1UNHNEY0hzTmJH?=
 =?utf-8?B?YXMrVGtSa0xVUkdXZEp5L3Ztb29aUHRNUEJscndJcDh0RHptRXBFcUpnMEtL?=
 =?utf-8?B?OGNPVUxORDVaaThvRDIvaVc4cHNqVjRleE9KY2Z0bGdqSmphMDY2SnpKQVl5?=
 =?utf-8?B?WWtFZGh5aDdDZy94dGloYkljRk9XcERmaERNK3dJaHBFcWZGRWJEM01nT2VP?=
 =?utf-8?B?UzQ1RysrdHVUc3pZVHdFUjRrSDZ2N1UwbWI5cUplREFXc0lXSHQwRy9hRHpF?=
 =?utf-8?B?VmlPUjA5anc0U1kxR2FvazhzVmlEcUFIQ0JKWXFKR1JVc0xkM3NZRUczR01J?=
 =?utf-8?B?S2NsQmd3M2xqNHFiVC82R1VqcTI4Y2xsODJ0RWQ4QnltT3U2MzJ5cmh5d2hF?=
 =?utf-8?B?eGNxdEc3TTdlQ3lrOWlSMVJqQU50RFRWbDhoRkZPOWN4REUvMGRTdVdNOGtB?=
 =?utf-8?B?amtvRjRUR1FNWGRSNUUwR2hYSE80bmhMOVU2UnNLbmVVNXdQb2Naalp5OFo4?=
 =?utf-8?B?ZUcwUnAyMHFDOTlWVDlaa0I4blJIRy8xckVTOVRBV1FpTTFtZ0MxbmVJVVFy?=
 =?utf-8?B?dXJOTkRBcm5CZm5teVRpNDl4VjQzVWxNdHovaFRoczZ2YllPU3hmUzBFbE82?=
 =?utf-8?B?VEJyM1FFRWE0UnBXZG9UZXlHQzFhM2k2bDVqZklJNlY2blVsZ3g2aVpGK0hn?=
 =?utf-8?B?enVYdkdQUGNTSnRmRGgydVpMWkp6RWt1M2lrZHo5ejAzRjFLQVV1R3pjVWht?=
 =?utf-8?B?czZubjJhTk5ZclEwVFlMQ3U1NXNmUXlCZ0pxVkFocEtFdXVCV1JLT2grWGdD?=
 =?utf-8?B?RDREWEJES1ZkV3F0anUyTXI0SjM2bzNpK3k5YXc2dDRhWFJJd3ozSFJ5WUhX?=
 =?utf-8?B?c3JFbjNPTGhDU2s3NGJkV1FFM0wrdzE2dVVIMzBFWk9XellJcklXSE5QalRI?=
 =?utf-8?B?MnpvWVJ5TmlkSmg0ZUZqYUV6L093czZhWlpPcllNQzhzVXMyellhdlNiUVND?=
 =?utf-8?B?Z3Z6TGFmSU4rMWdrTkZKYkMrQ2ROVVRQTlIxbDdlbzIyOGNiUjNSQlZJdDRT?=
 =?utf-8?B?aDJrK1JzYVFMRm1SQnJsL3J6NGx3Sm5jbXJ3blU5MUxldU5FemRnQWc1T1Ar?=
 =?utf-8?B?THRKa1BQelB2SUpZbkU1VFBsQTB6bjh1N1VySTh0RHpYb1BmM3ZsajhSUG1Q?=
 =?utf-8?B?V1hubmxVVllaQXVCWUZOREdUZFBTK21USThlQnJhdFVLR2Foc0F5SllYclZG?=
 =?utf-8?B?a1lBZ05YRjROQVpKcjd0c21QTjhaQjdiMWZZSUhhUFNTL0hRaEhBZlR1OXF5?=
 =?utf-8?B?eDR6TmNHY1VWWlVBNnNsZnordUlxem96NWNnRUxOVlFoRlZmREgxMUJTUWxB?=
 =?utf-8?B?R3EvRFBFRHNZSys1TFVlL0pHeG16YXhwRk5LZk45c2Q5UDJwd0k3MVhxejNy?=
 =?utf-8?B?ZFVMYWFramR2S0NvZm5RY05QYW9ITS9IL2ttUDRYdXEyMktObzJKZFozN05Y?=
 =?utf-8?B?d3dXRlN3dlpES1UvZlg5bGhuSk83YzA2NFRCUUlmZzFmdjhiMklEa0FFNXpI?=
 =?utf-8?B?ZGJSdEpGczQ5WHBpYnpXeDZlY1JwbUpLaFJib1RTaURxMW10M2xoR1A4enBD?=
 =?utf-8?B?Z0JOQW4yNFpuWnBnRFpoN2pDZmdpZHhsTmI4aVZudXdQOTlVWk05bU5nMVFW?=
 =?utf-8?B?TGsvLzNkdWxQOEJ0bDZUOUVIbzUxa1A4aUR3TzRoSk1HS2IrQXNZMVE3dDVS?=
 =?utf-8?B?ZlpJRVFBUXYweEtNTkZZNEpHVWU3T3hXS3VzWmpOVm11dXo5VGVTekZjOTAv?=
 =?utf-8?B?OGV0dFJFckRwM2F5S3VoQ0lFcHpOdHZGWjlhZDNUV0Y0TzFSd2s3MmtwTXdH?=
 =?utf-8?B?cW0zOGFXU1c4cTh3UUZlUDJrbkhEbC9wemtjTXE4ZDJtWmtSUS9FQnpiWmty?=
 =?utf-8?B?eHVEa2M3bVBJMHBnVVdEQkRqbDh2WGxKR2pOTngwZEhQa2NmVjhpRDRlaTRG?=
 =?utf-8?B?bWx6OTh4QjY0KzgxYmNYUW83ZDRhVER0YmI0UUdEU1JmLzZEQTdYZ005ek80?=
 =?utf-8?B?Z204S1hSS1hQaFoxQ0haUnlBZTNTMTRrN2kxK0FBOWFQY0VoZTFScTJDemlB?=
 =?utf-8?Q?pHSa8HT+EdPbe6i0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <815D2F4FF31E9043B27C83771B43BE5E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rb5SyzwZ6B2QTCe+hZdSQ2iGha6rjLGMMUqITWCToNSUuBppCZKTEn1d1d9hWIImaEzYSD+z2AMxbY4BmPHB3w6tDqzf8BFD53KUAp86nARe+KxtRbyRzhszYK4xGAH0YE/SKmjUQmGsouyaV8VCN+QqhwxubyzaoRNXosY2+6Swi19bUzODQ/sHW8zGbihPbT6lSd+l+dP9T4GLYNGrk8RW9ETKUzrPZNe7zk3KHl9Qpl293Tl/trvQYgh/pMOklaBQFlYGOiCvq5VpvRvJJh5ZYzMD3FUOuqJhkRxOzzdTavl/Qb+ljV45UfcsiLdD4eW4tKs1Enl4NYgZNY3OOQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7c6c6f-730a-47b1-c57e-08de976eeead
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 02:06:23.9478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOeu+Ibvyk0SERLW+gRypNwx/zlh/1LIabWv0km7QPtBCy54132Zc9hefaII+KTE31NmcbnAL8XGNJNR1erQS18maqfYyl/M3KnESeIO6uA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6408
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTA3IGF0IDIwOjA3ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiAr
aW50IHRkeF9tb2R1bGVfcnVuX3VwZGF0ZSh2b2lkKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgdGR4
X21vZHVsZV9hcmdzIGFyZ3MgPSB7fTsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0
ID0gc2VhbWNhbGxfcHJlcnIoVERIX1NZU19VUERBVEUsICZhcmdzKTsNCj4gPiArCWlmIChyZXQp
IHsNCj4gPiArCQlwcl9lcnIoInVwZGF0ZSBmYWlsZWQgKCVkKVxuIiwgcmV0KTsNCj4gPiArCQl0
ZHhfbW9kdWxlX3N0YXR1cyA9IFREWF9NT0RVTEVfRVJST1I7DQo+ID4gKwkJcmV0dXJuIHJldDsN
Cj4gPiArCX0NCj4gDQo+IFRoZSBwcl9lcnIoKSBpc24ndCBuZWVkZWQgYXMgc2VhbWNhbGxfcHJl
cnIoKSB3aWxsIGVtaXQgYQ0KPiBtZXNzYWdlLiBhbmQgbm8gbmVlZCB0byBzZXQgdGR4X21vZHVs
ZV9zdGF0dXMgdG8gRVJST1Igb24NCj4gZmFpbHVyZSBhcyBpdCBpcyBhbHJlYWR5IGRvbmUgZHVy
aW5nIHNodXRkb3duLg0KPiANCj4gc28sIHRoaXMgY2FuIGJlIHNpbXBsaWZpZWQgdG86DQo+IA0K
PiAJcmV0ID0gc2VhbWNhbGxfcHJlcnIoVERIX1NZU19VUERBVEUsICZhcmdzKTsNCj4gCWlmIChy
ZXQpDQo+IAkJcmV0dXJuIHJldDsNCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNr
LnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg==
