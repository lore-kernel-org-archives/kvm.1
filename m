Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3739434A791
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787788774; cv=fail; b=NS1bjTXbpqyqgQGDQVDz7S1YKOa6swqO7Ei2lhG2TQmBuQdS1PfuRXmtno9jPe1HiuuhKzlnsGgPwbHR+SG2C6h+ZHwF0N1B+Bo27WuUT+TyNUdBFIkYNQFxaB7ZZ3ZAlkyhc7/vzbeNl5+8gNW0yHCoye/DDx5x+3TuGON2ZtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787788774; c=relaxed/simple;
	bh=iYm95st6JcH7hW/VJTw6DlXf4AGMWR9a+CZoqUc7i08=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Aii7M4SnQvZC1UXLsHl/tOztFYTlnTv7kEuTXtLDRprIl6DMlICEC/+FYB0BZr/eVVjTss0UZLwYSWW3j8NCKzj4De7wbBGJ4dWQi8fUAvSp4MpeA+Q+fM4X1xf/axT04d8mAv6y7zQ7E5bSm6KpnVnVgbjTqhGVzqgCUvuniPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPX+7Rit; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPX+7Rit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787788772; x=1819324772;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=iYm95st6JcH7hW/VJTw6DlXf4AGMWR9a+CZoqUc7i08=;
  b=PPX+7RitDGa0gixiYEyu4FEutHq/8JE2li0VS1jAiQZPoQTZxGigdn5/
   PHmQCNLiAqGqpRYWBbr1vzjSp4kaM74BUa5aVKBuc40vCrRY+MuihCpTC
   TzMl+NLt1qB74asV3m7F2eiISAIH6BrED3N9mGZLNyDSSqJmrv16uWFvr
   yHt/USVKYUMHl5RnoHlHpE26Xu7YJMpBctu7XWTrcp0M7U4Kcj+ZtJ4UV
   6m/igUdhli4mBVrvUKzPnfR3Yengbfgqf2K/IIATh5DI1deI65ts6jE7w
   ACUz/dptyTaZJG/0U3DB2AiOIaf1ti+JaWgoVDkx2yUJzRY6UTXYH3C4n
   g==;
X-CSE-ConnectionGUID: pAOYSnVCS96bwduh0t4jvQ==
X-CSE-MsgGUID: v//3xS3nQSCWV4go1SnJVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="99446873"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="99446873"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 16:59:31 -0700
X-CSE-ConnectionGUID: ChAnedtuQlqiuS9arEcSig==
X-CSE-MsgGUID: O9SY8+xIT3e0lqmoYUD09Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="265928329"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 16:59:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 16:59:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 16:59:29 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 16:59:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOI155KELvX2rrC0F/euMrnBfHLSIdQRmHLgKW7/O8uRw2iFg4jgrZK1CXvEJclVm2ceEpco5PtVemrHiTR3X4wriPdyi3ke9a/kHHsF7VWCQ4tdtmhNHoUxaXoOE6H5D4zCg3vo/rVmwd2F1iYvy4q9SH92k7ghMf0zCeo6Q9h4bGfImPNEyazmB7sY9Rm0VLDvAN8gqT37a2kpFZ8ClZ90gPm5KBbOBeE46oBakw61DIOtfRb3D2EAFORZFYJ3SnFoKfIlPVSXZsNB1JQfGGUmJM2CIDXRRJ8HGiVTu1lLI+wY1f+z7CvwXz5LwF6SjWdwdxdPqDzuBGjAxJtUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYm95st6JcH7hW/VJTw6DlXf4AGMWR9a+CZoqUc7i08=;
 b=XtFhgs6JcZbyq1IofG3pp/rxLMF2XbZfO2Os0+PANnZ7tzZtqcIuZM9DxAoj7kGwr+Ok3EmGSWiLf9sngCVbBEHYwG9yBXM8UWMCJZJQ6q+v+wjuCbDY0RoufoGjh0NyRMD96sAQ4uC1jaTdb4nWjFITqvqWOBYAy35AyHT0U0h+9H+gsYFUwkV1t0CKfpQUU/H4E788LAk2oWL4VABIHbDjeDpFYPZWQMy22O+Avm/qI0lSsKw3j2tZDFj1cEe2R8ZO3cQDObEp24TlQI0zeuUgX0nwS7HDD/hlGUa8bwlfyz6KBh+UkPUNwTHnA3tOSck16JbWqJ+SdSNPNLxxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DM4PR11MB7325.namprd11.prod.outlook.com (2603:10b6:8:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:59:24 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 23:59:24 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.og" <kas@kernel.og>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Process for doing early internal type review on the list
Thread-Topic: Process for doing early internal type review on the list
Thread-Index: AQHdNbbrl3HWGo88DU+28qB6FuIfIg==
Date: Wed, 26 Aug 2026 23:59:24 +0000
Message-ID: <827b213a9482b417abb1d172438f0fdbfecd4c7c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DM4PR11MB7325:EE_
x-ms-office365-filtering-correlation-id: 182f4adb-74d5-4050-84e4-08df03ce0e23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: 6sJMZ0ZqmmuycXDhPdcq9Qpp0vn/kBySoUQXmLuVGyharfVHV2H1m/PXraOUaRPeLR5eGTXmLHpOWBAMUBYGqTm+9dRso8naGBSq2WBnn43SD/Lr4oaT9IcRbsSXobzsuzQ62bg33r8ypKKWpDu+i5opmJ6dNOSWoOLM03oBh6ig5Mt87CLDosQj6nIcdSDu6yZv899aRIH1yIgO+IDbq8afq/mnK4fhnzfVB6JJRoCg9qR1+y+kQp4mRqvkRbUvE/vT4JPWOfA/dVlKZkZ7y11XyS0IUoG3ZeNpTWk/5uDrVpFhDW8JBhvBIVhFdUZBlTmpZ1TPNNXoDGRMSdYgNhktDrDl8txTIl86e3DVoSiu+va8uTQBvwUClIZhwmu0hkice+t/YD8DLKi6thY5OX236JkWPHzp/UWyruE2fF+6ZhpnX/8lsz/mIQkTPHYC+aK0udMi3N78pb0RH60t/agJx2Ca4jBXxm85TEBdixYK/HrXf0LFXMvE22reOFdtKARfpemh2LRtQLpeqTyx3sweiBC6a+yGA7/Am3no9BtGMCyFhXK7jnH/JTvPq6B150Ik4A+93e7F2SM/gPZ+Roto8oXwKjHFAg7Mb1f/7yZCF+TLDOS2HU3Cu3NQAQSY17bBBsf2tQrYO18SxhCi0xzbzLXPuHKHv0gqJ+Ujb5+iHf2kOgaXam/xbo0R9U7OTfQfTF32cDL5/+rNQ5Zp1doIW56GbNDn1mKm22cWI3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGNud1BDaDhlNFBmVGNFNm11amtjeXkrZnYvM2ZySGRFWEdwTGdzZXB0clha?=
 =?utf-8?B?YlppYjBWK3E1cHZWMnh4NC9uazVLOTlwN3IxZlBZZk1HU0dKRmt6azJzK0sv?=
 =?utf-8?B?T3VHcUwzbjR6TTVVdE8ySFlmckRLREdMUEE3UkxYVGhySUFHUWE2SFd6cW1i?=
 =?utf-8?B?YjRTWXE4RU81c3NyVzRaZnd6TDhFL01HTm9EeG9oWG9DNklHV1lPNHBHejRp?=
 =?utf-8?B?QnNZMk56TVVRbDVtZmVicjkwbklNU3FkbzU5MEdGQS9EMjVmU2FvQ0dwcTVm?=
 =?utf-8?B?REhlUjcvQm5NTmRlMW0rRG45RmxGRGt4Z3ZSeVBZT0FrR3ZBMzZyemJYZ0VF?=
 =?utf-8?B?UVY0eHdEOFdlQWYzeVVMcWpGdTkrRGJuRzdwei9TMERQdVZOdjVUakdudExk?=
 =?utf-8?B?YStONzlQREFQQzBYTTVvMmxTblBWZEUrWjVHUTljU3BYTHloaEthMWF5dVNM?=
 =?utf-8?B?RXVUVXdqTHlwVnNCRGc1bk5FSWF1L2xOWjZwUExDYmhvZ3l4N0kxUmZqbnpB?=
 =?utf-8?B?N1ZMdHdxbjZ0NnJ6Tmt4ZHVUZm5qblkxTGd6LzJ5VDJHSDRtcmdKRzI1T1Bm?=
 =?utf-8?B?clZ3YS9hSzZsdWJLRmpiYXFLRzR1Ky9mZFNoV2ZPNlpTajh5NXJQdHRtblc5?=
 =?utf-8?B?NEJDQ0wyK2Fid0ZYWFRaQTZyMTlUdEFZU3A4QVg5aml4ZkttcHZpSGFhR091?=
 =?utf-8?B?UjVMMHdFVmNkSkxLSU9HdnNna2IwNW1qYXdxRTQzRTNLa3RoNXRUQXZsR2ZG?=
 =?utf-8?B?L3VCeExjQytSVWtNREcvb3kvZVN0V2NDMjhJN3EycTJ2eVg4ZjQ4cVlWb0NB?=
 =?utf-8?B?aVI5bnU2MGtkOERvOWc0Z0ZlKzlya3Zhd2FLZHVVaE1uVXRJcnU3dlJHRGJz?=
 =?utf-8?B?WG0weDNycWIyYVZVT0lWRkpnL2JIRVRPa2Q1ZEpmdTZuWHJnczZKQ1Y5OW11?=
 =?utf-8?B?enB3VExHeTlBYXdGc2pmMDFIM1luRTd3WkxqVDBDZWVLQmxXMFNpVy9JTlRP?=
 =?utf-8?B?b2N1UjA0V1BiZ0RsUUpGOXoyWHc3dkRCWUdwTFN6SzFMY1oyejJ3K090WFVl?=
 =?utf-8?B?TWduZDhaZC9tcFE3QjJUZDRjRkJ4MmxhNzhZTytXZXNWVlp2RUVJaFdHeXRC?=
 =?utf-8?B?Z01TMkVnV0luK2dLYkpxdUgyamZCWURvdUN6Zmhya3FPdUJuYy9VVFEwZFVD?=
 =?utf-8?B?MTN1N2RnUjFhdEpDckFRNUZCWTdVOXBmYzRlQUUvMGE2TXFZMjR3Uzh4NjJL?=
 =?utf-8?B?YndUVy9DRlhkMkR0Rndwek10RUMzRjBEZUt1b081NUJ4RDd2TWN2bm1IVzVJ?=
 =?utf-8?B?VzJDeEM5YTFXRXVMR0pSTWNXZ211alNCMVJObWR2RDBUQitwUUVRcXZ6ZDJC?=
 =?utf-8?B?TVd0UGhvZzBKSFRtYWZVUlA2TUlvRGhsbE9ZT1F6a29iT2xEU3hzbjJndXkx?=
 =?utf-8?B?WG9RRllSdjlFZlR6RUhWOWNPYno1Y0I1M2UvWjdVNjZ5SjlFb2RRbGc1b3Fr?=
 =?utf-8?B?dG5qdldubXR0ZXFaTnM2NWxVSDFyclFDRTVmblVZTTlDeHBTUVFEaDhPM3p3?=
 =?utf-8?B?ME9ZdFE2OWNEZzZFanVrY0Fla3ZHV0NnckNXRHZJZnZoNVJWNUZCYmNRZ0RM?=
 =?utf-8?B?UTdLek1keVJZUW1UaGFuVWxGRzJ5RnNoM1dzOGRlTjRLM0dWS3hCSkFKcFlO?=
 =?utf-8?B?ZFN4VVFkZy9lcmVxN2tOMk9aYVJFUTVxNEJqbitQV0NtZWVEaWN2V242L1Vz?=
 =?utf-8?B?VnBLVWlRMk5oSEU2OHlLNTNiNmQ4UDlBNXA3RDFqM053Syt6Z2doTXA2RkpE?=
 =?utf-8?B?WHlxdmRKYjVxYXhITmVvUCtmUG8vdmNBd3dOVHl3TENyTGNzRW5kZHk5ZEJN?=
 =?utf-8?B?b0tTajlDbTZqcmxQaWVnY25zaSszYzBhQTdmRURDKy9MRU54Q1N3TGFMcmJn?=
 =?utf-8?B?UVZRV01WVE1Bbjd6QXZ5dHovWWd6RDZTaG5pYmpLQ0tSMXVONkU5UUR0cFlL?=
 =?utf-8?B?amV5VWsreWllNEEwTW5DYjFYRjROOG55UEpjMG1CaHA2TGpzTWNrcHBKUnU3?=
 =?utf-8?B?eUhzMm9BeUxzWVlZRjZvbE1mNHNjTFMrWHRtWmNWb0VVeS9uamZUYTR3bWNm?=
 =?utf-8?B?MW44NGg0L2xSMDBZTlF3cTI2Y044bG5hM1l6OXM2ZW5WU0hqOGczMm1IRmZD?=
 =?utf-8?B?OUZwU3ArOUhCdFhTQ0JucURtek5LVjVmcTZyMzg0dGMwSHZxRHliNVNvOFBU?=
 =?utf-8?B?azhBQ2VESzVOam54V2tRemR0dVJrTXVxdDFFVERrQkZKTnd6anl5Z2g3d0Zz?=
 =?utf-8?B?ZHpBZDFlUE9zTWxlNFVOdExNQXAwQTliU21vRGxaLzlEcmJXaWMvZGQ1YUNR?=
 =?utf-8?Q?IKqiD3GLaPdBLaYE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <351159E72EA35A469C909C0D41065B84@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WEghBK4fsM3W8nmC5/kWUoql8av/4QvAqcWoS9MQnBGPmYx5bdwKW/EW8iLmF4QBvnaHNojONSKuk79iLaL/mcyVksbJuOK77jlzd0kzf7gzlycPCPTPsiY3seXMCH9r1C/z9aU4q33B3emX994fpH2xaD5TBTRqGTKB28Ttrb0jhtGhknQvQ3BjWGWzBvtoua/yV9CdmuvosiREKeiuJL8L0tjTN/xCBWpLZR6nAsgoAJAxcsmnjEWLQZGhusraHupJNOBG18uzVlHsXpax24OnMdL2Zoxl/rBCTLe1/KiE9fNxQfTsRKGQpPbJuR1gQfr10pjWtcpsoTwGVq0tHA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182f4adb-74d5-4050-84e4-08df03ce0e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 23:59:24.4938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwvhBnZ1e88rsWGpt38WvroohWw5rja9WOvWI5WQbtzmDYfWVUS80PZBeCC+SQkwCVo8RkMTS3d3ThkC+f/2Yeg+IfiP/bXoBZhlKo5TAoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7325
X-OriginatorOrg: intel.com

U2VhbiBoYXMgbG9uZyBiZWVuIHB1c2hpbmcgVERYIGRldmVsb3BlcnMgdG8gcmV2aWV3IGxlc3Mg
aW50ZXJuYWxseSBhbmQgY2FwdHVyZQ0KZXZlcnl0aGluZyBvbiB0aGUgbGlzdC4gRm9yIHNldmVy
YWwgcmVhc29uczoNCiAtIEF2b2lkIHRocmFzaCBieSBoYXNoaW5nIG91dCB0aGluZ3MgaW50ZXJu
YWxseSB0aGF0IGFyZSBqdXN0IG92ZXJ0dXJuZWQgbGF0ZXIuDQogLSBDYXB0dXJlIGFsbCB0aGUg
ZGVzaWduIGRlY2lzaW9ucyBpbiBsb3JlIGhpc3RvcnkuDQogLSBIZWxwIGRldmVsb3BlcnMgZ3Jv
dyBieSBnZXR0aW5nIGNvbWZvcnRhYmxlIHdvcmtpbmcgYW5kIG1ha2luZyBtaXN0YWtlcyBpbsKg
ICANCiAgIHB1YmxpYy4NCiAtIEEgc3Ryb25nIHBlcnNvbmFsIGNvbnZpY3Rpb24gdGhhdCB0aHJv
dWdoIHNvbWUgY29uZmx1ZW5jZSBvZiBpbnRhbmdpYmxlcywNCiAgIHdvcmtpbmcgaW4gcHVibGlj
IHByb2R1Y2VzIGJldHRlciBvdXRjb21lcyBmb3IgdGhlIGtlcm5lbD8NCg0KQXQgdGhpcyBwb2lu
dCB3ZSBwcmV0dHkgbXVjaCBkbyBhbGwgVERYIEtWTSBwYXRjaCByZXZpZXcgZXh0ZXJuYWxseS4g
QnV0IHRoZXJlDQp3ZXJlIGEgY291cGxlIHN0cmFnZ2xpbmcgY2FzZXMgd2UgcmFuIGludG8gcmVj
ZW50bHkgd2hlcmUgbm90IHdvcmtpbmcgaW4gcHVibGljDQpwcm9kdWNlZCBzbmFnczoNCjEuIEZh
ciBvdXQgdGhpbmdzIHRoYXQgYXJlIGluIFBPQyBzdGFnZXMgKGUuZy4gRElDRSwgYW5kIG5leHQg
bWlncmF0aW9uKQ0KMi4gVGhpbmdzIHRoYXQgYXJlIGhlbGQgaW50ZXJuYWxseSB0byBub3Qgb3Zl
cndoZWxtIHRoZSBsaXN0IHdpdGggdG9vIG11Y2ggVERYDQpzdHVmZiBhdCBvbmNlLCB3aGlsZSBh
bHNvIGNvbnRpbnVpbmcgdG8gbWFrZSBzb21lIHByb2dyZXNzIG9uIHRoZW0uIChURFggaHVnZQ0K
cGFnZXMpDQoNCkluIGFuIG9mZi1saXN0IGRpc2N1c3Npb24sIHRoZSBpZGVhIGNhbWUgdXAgdG8g
aGF2ZSBzb21ldGhpbmcgbGlrZSBSRkMsIGJ1dCB0bw0KZGVub3RlIHRoYXQgdGhlIHBvc3Rpbmcg
d2FzIGZvciBlYXJseSAiZ2V0IGl0IHJlYWR5IiB0eXBlIHJldmlldy4gVGhhdCBpdCB3YXMNCmJl
aW5nIHNoYXJlZCBvbmx5IHRvIGNhcHR1cmUgZGlzY3Vzc2lvbiwgYnV0IG5vdCBnYXJuZXIgYXR0
ZW50aW9uLiBJdCBjb3VsZCBiZQ0KdXNlZCBmb3IgdGhlc2Ugc3RyYWdnbGluZyBjYXRlZ29yaWVz
IHRvIGRvIHRoZSByZXZpZXcgaW4gcHVibGljLCBidXQganVzdCBvZmYgdG8NCnRoZSBzaWRlLiBJ
dCB3b3VsZCBiZSBhbiBvcHRpb25hbCB0aGluZyBpbnN0ZWFkIG9mIGludGVybmFsIHJldmlldy4g
Tm90DQpyZXF1aXJlZCwganVzdCBlbmNvdXJhZ2VkIHdoZW4gcG9zc2libGUuIFRoYXQga2luZCBv
ZiBpZGVhLg0KDQoNClNlYW4gc3VnZ2VzdGVkIGEgIkZVVFVSRSIgdGFnIGxpa2UgIltQQVRDSCBG
VVRVUkVdIi4gSGUgZGlkbid0IGxpa2UgIlBSRVAiDQpiZWNhdXNlIGl0IGNvdWxkIGJlIGNvbmZ1
c2VkIGZvciBhIHBhdGNoIHRoYXQgd2FzIHByZXBhcmF0b3J5IGZvciBhbm90aGVyIHBhdGNoLg0K
SSBkb24ndCBsb3ZlIEZVVFVSRSBiZWNhdXNlIGlzIHRpbWUgZm9jdXNlZCwgcmF0aGVyIHRoYW4g
YWJvdXQgdGhlIHB1cnBvc2Ugb2YNCnNlbmRpbmcgdGhlIHBhdGNoZXMuIEhvdyBhYm91dCAiUFJF
VklFVyI/DQoNCkRhdmUsIEknbSB3b25kZXJpbmcgaWYgeW91IHdvdWxkIHdhbnQgdG8gaGF2ZSBh
IHNpbWlsYXIgcHJvY2VzcyBmb3IgdGlwIHRhcmdldGVkDQpURFggc2VyaWVzPw0KDQpUaGFua3Ms
DQoNClJpY2sNCg==
