Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742111A6829;
	Wed, 23 Sep 2026 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125045; cv=fail; b=mFBQLfN/2iEiNoX77/Cx1nWCdkVEdPl21ASGna7jpFXINBLKcIuaF2Kzs9PCE2JfGmBgq5ggeOu/khKFbtAQgMLEFNfBq2gjhJBGxZou1LDhZ3oxNxmZ+7WLDLtRlVrm7iddPC8zhvxg94whFiEP5rR1Oh2akTaDONsOHVyfTGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125045; c=relaxed/simple;
	bh=IKycJEmRvsRr9vs2V7BcStGGr4DaUxoh3hgs9qFxm40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cJDBD4V1PYLC8UbCVQv2qsM2OtcU7oNduM7TIribTvmTqMrB4/A3cRB2QCRQwLw3CpUplVHw4CygCWqROAQDbFbwYwIOyCoXnGyb8/yi2llEjPLtbt3NlJ4emOLw3z+3DZTunq25+/xqazMFDhZFDjD31jxmeIqa50oKX74Eb+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjoU+SJo; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjoU+SJo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790125044; x=1821661044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IKycJEmRvsRr9vs2V7BcStGGr4DaUxoh3hgs9qFxm40=;
  b=VjoU+SJosAq4PNZbg/1h7VVkbTLGrCkOr5VhM+BRJ3Ti1RKkdoGYxR8y
   ZbOViwrrTKl611g3vEDz1GP9rJJxF86NmO84GSH3+vc4mimpgINhrkH9U
   cgptIcHoKoguAAFA8eOk180tWYFiiq0xEkmWrU5RreFg8vzSvfbJ7fUFv
   3PuHAZl032vDdrjTCqA6kaCO6nWljGGwWa8SD2mzAiZH5aw3j8i6h4WLW
   wdq1+eW5DrKIoFeX5E6oJGK44XvNqOy2wWB67IhPEhzAckKp+94nTq/k3
   0jPrXPTa0B6aWJiBisU8ArH6ol0kLE3sy6g9UqrwWTUFgP/fz+wCV2TY8
   g==;
X-CSE-ConnectionGUID: ScCTeSuPSb65lgi43VKvEw==
X-CSE-MsgGUID: Nm+EuDWETaa/EdupDtXmEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1290525"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="1290525"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:57:23 -0700
X-CSE-ConnectionGUID: V8y31rWPT/uYu2HKQPXOmQ==
X-CSE-MsgGUID: L1FTnYAlQ6y/NdnPIGA4HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4388643"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:57:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:57:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 17:57:22 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:57:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6x6GURzPUf6HTHxqo2SvnTV0cp8sYAZTvwRalA2oxfVGF18LjeeSN3fMfziWudLk7yYTsVwqPmVpvYZoXDDk+Mq3PmOJy61CQ5qdc6arn2WqVjf5lC7UgkkxnQBMiM/4YNedmlIIuZ6s/Su5WlDLYPLTvcKXPNsbV4YuAwr/nDUGD92R4xM51bOkCeOIMJNsbzYaGKMmQlPs4BUa/oNZw/G2HJezk3VQVNU62K19iPwLF7S3Yg8q/zJg3ux0FMCdkCCBnQiq1Qtrd60Z6LjMIioI5Ls7yVB1/xjL/z4Raqg7dxvYISimiIgWs/CQvB4sRCpSYyaloaSxRQjd56NSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKycJEmRvsRr9vs2V7BcStGGr4DaUxoh3hgs9qFxm40=;
 b=nffX5120aB6f5DL9vII4Yao9jslpYuiWxxmogqkOJ1OrXgMPjsfdUGX5+p8bsVCuneNDsULerOlNNOZFtUqkPU66q5oXfz8mbJLneEdUHAXo3EodXowirjWDhJWYxG4tborX3/UGHVdbXct68Dqq6yR2aHVyTrIu7u+q6xnz7axJ//ghNibLZUcZ4dlpwcLbCJTq3X13Gm4rQshFswdVSkrU041iW4SYU6QNC++ysapmdxgc5YAp5T53vjQAp5JY7pJLVM6hBXyLBMbertKkAgw07Aoe/p21ic/+XJMXKRM8fkMg6LyhHoqrgm4QKAnyVLuY7dJkyDwvRgixPH7gPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LV8PR11MB8677.namprd11.prod.outlook.com (2603:10b6:408:1fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 00:57:18 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 00:57:18 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH] KVM: VMX: Formally define KVM's "0xdead" exit reason used
 for failed VM-Enter
Thread-Topic: [PATCH] KVM: VMX: Formally define KVM's "0xdead" exit reason
 used for failed VM-Enter
Thread-Index: AQHdSiTt2kITJxwJqEi269X80OvKJLbbWKuA
Date: Wed, 23 Sep 2026 00:57:17 +0000
Message-ID: <8edfb868bcabfef8e2dee96c0831cc3f1234367e.camel@intel.com>
References: <20260921235656.1107929-1-seanjc@google.com>
In-Reply-To: <20260921235656.1107929-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LV8PR11MB8677:EE_
x-ms-office365-filtering-correlation-id: e29c2724-6c35-4a05-00d0-08df190d9db3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: XkOvu34l8qE+xzhi7Wf4v1Fx/uhOLwOD7hbx0Dtw3Zwkl9XTclobNZVDfKmgvnrcbnXF1X2ymDXRctnxla36KUPcYn8nAJRN+88PfEb0Hn6GT5vMyPatgMfma6/8V+UVjAI5c4yurXOhqmL1oXsMgRSsGIg28KlPOkkF2/dewAsZ16v0I4HOcKXUYQThTtDFsrA9OTWOSwgdwsagECFo2b/NuzLtzXngz3QUXIxvEqthH34cFBCKtarT5JF6I/POn9FuM2iv48nQT+AgZ9AFTO6HqVlRRWid6O2IRs4BlZjtWuNbhsZHD+/Wwvbm3qb/5VwmbursR4fM6uSGyz5vZO/mBhfIjhO1j/noqQj5mI/YLt/TEK+a99J5O+6tECzk7DgxYkCSSVPkAri9GKU1rQz3vWQnvwtyJivC1YGR9H0irtdQCOz0MZOX2ZlON60G8ZajVjqTV7I/1pQKhlD0DnhieGRkbYdYjn6lHUSIIVpv7HVv9GbGSLj1HIccS7fCr4LDV8E5DRv/J526qEF8MuzBU1sLfAZEQRKsCziLkdJAeUdYXsXW4qpybEfRGFRbCJ8EoVRZuTRdLgX0Jaxww9D6MUaFATRNxUjXMTYHLGmQEBCvqJmEvOEjsH6XpNo43ob/iVzl3eiaE5RJjue5Wq3qdlb72a7xlcNDj6pyrZVcxEgWoz6tjQO19AGyHU/h8VdcEubqXHeSCN7jjBMgq8o3GBqjqddfHUgexjtn9/g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Umo0RWlHSWo4aFcydmhwTW1jbHNiN1JKUHVYK1Eyd1FRTWx5SmIwL1VjUm5J?=
 =?utf-8?B?U3Z0SXRVM1NKT1lPZUhrQUxIY3N4YWpqbmVlTW1iZklMVXk4eUpEcVRRQ3h6?=
 =?utf-8?B?U1ppY0x0a0p2ZHZVZlczT1V0M1RLZ0ZMSVNuU3hsOGlzS3BCdVZxZFQ1STFw?=
 =?utf-8?B?VFVsUTZtcWxSSEozczQ2U3RLalE2WC9rZkhzcFN2azJDYnJiZ3dXaWdOVmxX?=
 =?utf-8?B?NkE0S205VEwzeGlrTHBQOXlWNitOUnVUdnl5SlY1WXkyNDFMR3ZQTVV1cWpj?=
 =?utf-8?B?QVdLa0VwamZ1MHAzckF0WWFmazRIeFpFSUVsU0piMktLTFhDWENPWSttV094?=
 =?utf-8?B?Qkg3cDFwSkVubm1JTlRrOGlObXozeGJmVGdxMklmMmdPQUNQUVZQQk56ZGQ3?=
 =?utf-8?B?ZjMzUWt3Sm8rbXRBREZQTmRleUM3VE5oUEVMZVBRMUdUbHpnMFNrTHpyVjNJ?=
 =?utf-8?B?VzhXSUM0bDlqbFpqVDdFVGhjNFVFeEp4U09pR0cybjZmMS9WQlBNQVNmQWM1?=
 =?utf-8?B?WXpjYmhhRkRPY2hJZDJieS9LZnVmclBNZE9Zb2JyY25nL1Myc0dGT1hPdzc4?=
 =?utf-8?B?TmFTSkhSM3pZVXRKbFJxUDBSYTNXUXZIdVA0cWtmdzl0ajRQNGk3RTEvVkt5?=
 =?utf-8?B?MkNUTG1YRDJueVBMQmJ6WlpZQVZncnVtSk1nb2cvLzJsV2V4dzVYTXBEb1h6?=
 =?utf-8?B?VU9ZOU9ZQSsyc3BwY0JLY2VqU1ZlQ3IvSEVFdjFSOUR0MTNmcGdhWG8vclhO?=
 =?utf-8?B?VHhmMXYrL1Z4WFBJRTJLUUVhZnJjdmd3RTZNdmVlVXZDbGVJZnJBaG9aZXUx?=
 =?utf-8?B?M1l5K2N0TkRaSXZCME1qUUFHK0E4SlhWSGtBOVJReEUzOXFVallReDYyUENG?=
 =?utf-8?B?Z0thbUhxOW9qcWhpWVRRZ0NYTndIQnc0NnJhTElUOEZnRzhlVW5rZnR4TDZT?=
 =?utf-8?B?Q1dnT29INkx5UzVhcnlVb3pINXdUUE9FbENsU0VzSWdUY2UyMkZuN2drYWJl?=
 =?utf-8?B?cndtcit6akh6a3J5S0VMWGZvYk5SWkVYaGJwenpPSDNoSEs0RGNSYld4WWlp?=
 =?utf-8?B?OWlva1lHVDA4SDd6L0VsdFdxQjREN3prc085Wk1RTm9KNzExR2htRWkvOFow?=
 =?utf-8?B?bVR2UWVFcHF2VWszKzcyMmJkd2N5NkM1MkxlcStBeExaS1NUUW1tVWVhT3VB?=
 =?utf-8?B?clk0QUlmaUY0UWNFVEdrS20ycUViYnJ0VWtHRm52VWtTTHovVlpnb1RvRTM1?=
 =?utf-8?B?V0NWbDdrdWVCSEFNVWxHYUVYZnREU0pHTjBUQU1yeE9rY0Z6dE5LSThIdjls?=
 =?utf-8?B?RlJIcUJNaGxvYjZzR0l5UElQTG96WGRvVzJZYXdpVFc4RUdNMlhtelN5dTBa?=
 =?utf-8?B?Wk1sYldSUlJzbG1HYTdsSlhjTER1ZGhMTGVqS1JEVnJCK1JqTmdQZVFaNzls?=
 =?utf-8?B?T3lxUWI2OWFMQVNaRkhScmxJTDhxYXkzT3FpRVlOeC9RRmxZM2J1aURxcDlL?=
 =?utf-8?B?U3RHc2xJd21pc3VHTTN5NEM3Nmoyc1BLQlRGemp0Ujd3b0NUMXpHcklSbVJx?=
 =?utf-8?B?d1BRNjJzVGVsdmNEcHBEUmRhdUlCTWRmRGRoNHBnOXlpTmJ4NnRJWjVHVkk3?=
 =?utf-8?B?VHlIY1NPSUJ6T2ZscWMwT3k2ZmRQZk1qeEJKU09BYmZweTVVTDJRSGx4cDN1?=
 =?utf-8?B?YkdKQzl2VXFoNG94ajlkTTlmeVJ0RTl1dC9JczA3elc3czZtNnFGcmNmM2o0?=
 =?utf-8?B?d3VDMmczWVdJTzdWNzhQS3QzSHBMYjFta1FHMEhFS25ra1FXMGVPVEpZV1VW?=
 =?utf-8?B?ei9kMUZjc0JNb1VydWlHcGxUS3RlS3I5aWdnQzlZOEExYmVZdG1pb2hMdlFP?=
 =?utf-8?B?MVhDMEFQTWJBN3RlT0RQMG9iWU1LSU1kdjBEMWJUd2FuUnVLRE9MdnREMzFy?=
 =?utf-8?B?ek1lVHVIU1lwNE0ya2FyNTVxNGpDTmUwZUVWa2k4RURDclZYdkV3N3VtVWJY?=
 =?utf-8?B?RXRaR2lFL0ZwYUx3aEhtVG5DOHlyM1YrZWFBV1VmUmRuSlNCYXFaL0NzTWs4?=
 =?utf-8?B?MWdZTisxamdzUFY3Skx4OEhTSU9pTVgwTmZmT2lvM3B4aGc4UFZkZ3lheEhy?=
 =?utf-8?B?NmQ4cWhobVhaYVZWNFBHd2hDdTg2c0FZbmVXLzIzNmxwZnZ2eVBwUXQ3dnNs?=
 =?utf-8?B?c0IzYkUrbTRHYnhONE5xNGQ5cExNcVNlc1JxMW1FS2ljWGhub3lMVnFVS3VY?=
 =?utf-8?B?WTZHanQvVDhhRlltN1ZQNlpHRjU1VU4zMmJZRlNaU3NyVXZRZWtKaFNvY3N2?=
 =?utf-8?B?dndLSGt0YVdRRElwV0d2UmM4RVZIZnhFcDJxVjRpY1dNY2JZNGxzTWFlelR1?=
 =?utf-8?Q?t/iipb6S54nVZOv4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <074FFBCABC8FC74C903F1E6197FB15F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hOzYKdBIxnGpfRfuoQEF6w6/RVpGpOI7DgPRk+ISv8Co1jGW+991kBKr55wCsFm/+avV1inmMC6CMjtFa4Cl3Jhr8s6DI6L2uXxQASpRQXkWBflmSo+8RPB754PA8rVYpJ12bZYecG8czkX4jp3BHQHWPVaLy6L2UGVWW/Nqao4KGVJ+087XUq0r53MAdVMkrtwughdwutn4AOJmhKr7vks4vEZ0WX7Y/Ai7/5YFocF+A8gkvs9BO4mK66vuU4cBFbwDt/yYSXpbsTgdLS1HVmscM55mTR9b3NE6jPou+CurRQTED6AI17VY8JVAe5+dOdiyNudjSkT99XseW1opDA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29c2724-6c35-4a05-00d0-08df190d9db3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 00:57:18.0353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C35f6Q7b+KtQY640FMwQ2mP0bN+3aeZQZMtqGKzoTXTKmKqdxi2nd3ORoGB67Ndn/IAvutY4zMcywPc5PzZaFEKfohmujIEg0+GL0hFJIj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8677
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTIxIGF0IDE2OjU2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBBZGQgRVhJVF9SRUFTT05fVU5ERUZJTkVEIHRvIHRyYWNrIEtWTSdzIG1hZ2ljICIw
eGRlYWQiIHZhbHVlIHRoYXQncyB1c2VkDQo+IHRvIHN0dWZmIHRoZSBleGl0IHJlYXNvbiBvbiBh
IGZhaWxlZCBWTS1FbnRlciBzbyB0aGF0IHRoZSBtYWdpYyBjYW4gYmUNCj4gcmV1c2VkIGJ5IFRE
WCwgYW5kIHRvIG1ha2UgaXQgbW9yZSBvYnZpb3VzIHRoYXQgaXQncyBhbiBhcmJpdHJhcnksIEtW
TS0NCj4gZGVmaW5lZCB2YWx1ZSAodGhvdWdoIHRoZSB3aG9sZSAiZGVhZCIgdGhpbmcgbWFrZXMg
aXQgcHJldHR5IGRhcm4gb2J2aW91cykuDQo+IA0KPiBPcHBvcnR1bmlzdGljYWxseSBhZGQgYSBj
b21waWxlLXRpbWUgYXNzZXJ0IHRvIGVuc3VyZSB0aGUgS1ZNLWRlZmluZWQgZXhpdA0KPiByZWFz
b24gbmV2ZXIgY29sbGlkZXMgd2l0aCBhICJyZWFsIiBleGl0IHJlYXNvbi4NCj4gDQo+IE5vIGZ1
bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPiANCj4gQ2M6IFhpYW95YW8gTGkgPHhpYW95YW8u
bGlAaW50ZWwuY29tPg0KPiBDYzogWWFuIFpoYW8gPHlhbi55LnpoYW9AaW50ZWwuY29tPg0KPiBD
YzogQmluYmluIFd1IDxiaW5iaW4ud3VAbGludXguaW50ZWwuY29tPg0KPiBDYzogUmljayBFZGdl
Y29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KDQo+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQoNCj8/IFRvIGhlbHAgdGhlIGJhY2twb3J0IG9mIHRoZSBET1Mgc3R1ZmY/IFNl
ZW1zIHN0cmFuZ2U6ICJubyBmdW5jdGlvbmFsIGNoYW5nZQ0KaW50ZW5kZWQsIENDIHN0YWJsZSIN
Cg0KT3RoZXJ3aXNlLA0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNv
bWJlQGludGVsLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxz
ZWFuamNAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+IMKgYXJjaC94ODYvaW5jbHVkZS9hc20vdm14Lmgg
fCA4ICsrKysrKysrDQo+IMKgYXJjaC94ODYva3ZtL3ZteC92bXguY8KgwqDCoMKgIHwgNCArKyst
DQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdm14LmggYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS92bXguaA0KPiBpbmRleCAzZjFiMzA5NmZmMDQuLmU0OWI4MzZjNzMxMyAxMDA2
NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdm14LmgNCj4gKysrIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20vdm14LmgNCj4gQEAgLTIwLDYgKzIwLDE0IEBADQo+IMKgI2luY2x1ZGUgPGFz
bS90cmFwbnIuaD4NCj4gwqAjaW5jbHVkZSA8YXNtL3ZteGZlYXR1cmVzLmg+DQo+IMKgDQo+ICsv
Kg0KPiArICogVU5ERUZJTkVEIGlzIGEgS1ZNLWRlZmluZWQgdmFsdWUgdXNlZCB0byBpbmRpY2F0
ZSB0aGF0IHRoZSBiYXNpYyBleGl0IHJlYXNvbg0KPiArICogaXMgdW5kZWZpbmVkL2ludmFsaWQs
IGUuZy4gb24gVk0tRmFpbCBvciBpZiBURFggbmV2ZXIgYXR0ZW1wdGVkIFZNLUVudGVyLg0KPiAr
ICogVGhlIHZhbHVlIGl0c2VsZiBpcyBhcmJpdHJhcnksIGl0IGp1c3QgbmVlZHMgdG8gbm90IGNv
bGxpZGUgd2l0aCBhIHJlYWwgZXhpdA0KPiArICogcmVhc29uLg0KPiArICovDQo+ICsjZGVmaW5l
IEVYSVRfUkVBU09OX1VOREVGSU5FRAkJCTB4ZGVhZA0KPiArDQo+IMKgc3RydWN0IHZtY3NfaGRy
IHsNCj4gwqAJdTMyIHJldmlzaW9uX2lkOjMxOw0KPiDCoAl1MzIgc2hhZG93X3ZtY3M6MTsNCj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMgYi9hcmNoL3g4Ni9rdm0vdm14L3Zt
eC5jDQo+IGluZGV4IDYxMmFiMDdkNDEwMC4uYzg5N2RiZjBlOTU0IDEwMDY0NA0KPiAtLS0gYS9h
cmNoL3g4Ni9rdm0vdm14L3ZteC5jDQo+ICsrKyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMNCj4g
QEAgLTYzODgsNiArNjM4OCw4IEBAIHN0YXRpYyBpbnQgKCprdm1fdm14X2V4aXRfaGFuZGxlcnNb
XSkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KSA9IHsNCj4gwqBzdGF0aWMgY29uc3QgaW50IGt2bV92
bXhfbWF4X2V4aXRfaGFuZGxlcnMgPQ0KPiDCoAlBUlJBWV9TSVpFKGt2bV92bXhfZXhpdF9oYW5k
bGVycyk7DQo+IMKgDQo+ICtzdGF0aWNfYXNzZXJ0KEVYSVRfUkVBU09OX1VOREVGSU5FRCA+PSBB
UlJBWV9TSVpFKGt2bV92bXhfZXhpdF9oYW5kbGVycykpOw0KPiArDQo+IMKgdm9pZCB2bXhfZ2V0
X2V4aXRfaW5mbyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHUzMiAqcmVhc29uLA0KPiDCoAkJwqDC
oMKgwqDCoMKgIHU2NCAqaW5mbzEsIHU2NCAqaW5mbzIsIHUzMiAqaW50cl9pbmZvLCB1MzIgKmVy
cm9yX2NvZGUpDQo+IMKgew0KPiBAQCAtNzQ3NCw3ICs3NDc2LDcgQEAgc3RhdGljIG5vaW5zdHIg
dm9pZCB2bXhfdmNwdV9lbnRlcl9leGl0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwNCj4gwqAJdm14
X2VuYWJsZV9mYl9jbGVhcih2bXgpOw0KPiDCoA0KPiDCoAlpZiAodW5saWtlbHkodm14LT5mYWls
KSkgew0KPiAtCQl2bXgtPnZ0LmV4aXRfcmVhc29uLmZ1bGwgPSAweGRlYWQ7DQo+ICsJCXZteC0+
dnQuZXhpdF9yZWFzb24uZnVsbCA9IEVYSVRfUkVBU09OX1VOREVGSU5FRDsNCj4gwqAJCWdvdG8g
b3V0Ow0KPiDCoAl9DQo+IMKgDQoNCg==
