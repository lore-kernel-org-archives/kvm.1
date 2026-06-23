Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022127.outbound.protection.outlook.com [52.101.48.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E06B374E6C;
	Tue, 23 Jun 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226283; cv=fail; b=gs9pZ1RMG6vto8hrv+GsPXED8IoN7aok7bZJneg7KgNr8ifWX6rf7S3fNMWg5hsmjZS4KSB4JvZDsbIQR8b+WT/WowBuRDLQFPHTiRNQroUtstjiOi9tBl06/tkyDRHN0avORYV8PthkEaNec6RFTlqS242YHAtjo6hw+NZONVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226283; c=relaxed/simple;
	bh=mR/+phGB3Jo4NYly0be3yKzm+dbHJdmjKD+0A9c4lVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iZ7BiZqdT913G15RNU5UGs2I180cBWEWdq4RVU+ZXfWwej5DZdvNkPgZbgHQY4ZYSta1xTluziXtn2dyc0mAVt8RYcTeacvUTtmsxOFw10vt5ygJsUggLAd2+xRbixW0FeE6cB2dGBdBYeaxLsmSr0qzTNywcqgsYoAZobMeMZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CTXwUa2s; arc=fail smtp.client-ip=52.101.48.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CTXwUa2s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpDC1YPbENS8coZzejp6Gys3m4mAzT2DBuu1jVPhBgp1/ZnTHti1JqTZmFvtiZEhHkAi8atgt4NRSnwA8O2I0Ya4Gk7PZmtz9MS14DOUq1K4OIUH/UMDl+kQD3ulJP56U8C8i2bG3lQTKo8AwCvhPco6pQf+6zHxTXRTyD0JRrfYFcBIRutjmnj5gtBPDd6ZdPcYD3mX1QH0p1m06427P63oAhtckXKpn8usQ8mkbLRH4ZRfGCKcF2ZkB5UOyHwEoi5JeG+wamomejBQfWdX5iiU7x0TN5hKmOzurCo+d8ablSfdmzeq+a2vCJcH+gePE8sM6zNccd0zTA+1WJh1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR/+phGB3Jo4NYly0be3yKzm+dbHJdmjKD+0A9c4lVE=;
 b=QMGoQvkz4GUVoGQUGHPPlWvtEFaoJLnSqYGup5gc+b+Wu9JZlFngaL0fEIZusT3aLfAq2Vzdnr08LjgLxbB7UqjvCrTPBYLeYvve/0x+WO3Rag6wpkOKZK6p05yhHo1A+Qm+gBM36DcR357fOOFQEYYBa3PR0YNlCTet8nXOxlhvp3QgUMU/BhIHSpFNmLcb02zEM2GC6gKTGde5h036K/LIglB2wbhjQFspFgEIu2Pp+b5Z5t64TDXe9elGnIcEeEWF+sg5Ig70i2CxqtyaFbhDjMwd81CQx5Vi7ZI3HYe7dNVSgtw8IbKNmhXJc967/Rg2h9PjCei+hqLvlWhsXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR/+phGB3Jo4NYly0be3yKzm+dbHJdmjKD+0A9c4lVE=;
 b=CTXwUa2sQVm6EFmb5Ea2YTNCApVa1Jt8PGiOtp9V8X7EAAYGs4ravpAplBvaZYfXD1uIgm5rYTYaN32O6lS4VtSgA/6REcMcwuwIiGkIeh//73pY6e4VYNoJIi1erw7IwBNjrpQjxoAhoYWpBvXUbmXsLx+RionoG7wubX7pRe4=
Received: from LV0PR21MB6859.namprd21.prod.outlook.com (2603:10b6:408:32f::18)
 by LV2PR21MB6863.namprd21.prod.outlook.com (2603:10b6:408:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.3; Tue, 23 Jun
 2026 14:51:20 +0000
Received: from LV0PR21MB6859.namprd21.prod.outlook.com
 ([fe80::189d:71d9:30be:1e38]) by LV0PR21MB6859.namprd21.prod.outlook.com
 ([fe80::189d:71d9:30be:1e38%4]) with mapi id 15.21.0181.003; Tue, 23 Jun 2026
 14:51:19 +0000
From: Jon Lange <jlange@microsoft.com>
To: Sean Christopherson <seanjc@google.com>, =?utf-8?B?SsO2cmcgUsO2ZGVs?=
	<joro@8bytes.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	thomas.lendacky <thomas.lendacky@amd.com>, Michael Roth
	<michael.roth@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"coconut-svsm@lists.linux.dev" <coconut-svsm@lists.linux.dev>, Joerg Roedel
	<joerg.roedel@amd.com>, Jethro Beekman <jethro@fortanix.com>
Subject: RE: [EXTERNAL] Re: [PATCH 4/4] kvm: svm: Support
 KVM_SEV_SNP_PAGE_TYPE_VMSA at SNP_LAUNCH_UPDATE
Thread-Topic: [EXTERNAL] Re: [PATCH 4/4] kvm: svm: Support
 KVM_SEV_SNP_PAGE_TYPE_VMSA at SNP_LAUNCH_UPDATE
Thread-Index:
 AQHc+aBIydFKXqUyuk6zRDYkZH6X1bY5V58AgAgnwQCAANcHAIAAaO+AgAAG9wCAAANvAIAAErsAgAlb6oCAABELAA==
Date: Tue, 23 Jun 2026 14:51:19 +0000
Message-ID:
 <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-5-joro@8bytes.org> <aiqtWVMqTK6vDoZ8@google.com>
 <aiqwjn2DVOumfr3T@8bytes.org> <ajGOELiYwKByXbVP@google.com>
 <ajJAYZAPxNrrsiYp@8bytes.org> <ajKadxZEMI253AoT@google.com>
 <ajKe-oboTRowcO_i@8bytes.org> <ajKjMIBb21qB46fh@google.com>
 <ajKnKeo1FV3zbjEt@8bytes.org> <ajqMvQLMGONiLn1S@google.com>
In-Reply-To: <ajqMvQLMGONiLn1S@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=528f4edf-1c7f-498e-88d1-2f1248d7c703;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-23T14:41:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR21MB6859:EE_|LV2PR21MB6863:EE_
x-ms-office365-filtering-correlation-id: 1e4da86d-675e-4cce-c591-08ded136e2f5
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|22082099003|18002099003|3023799007|56012099006|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info:
 HK3A4iq0iTcgb2ZznyHqRbhQ+JOJOLnHGKk4fsIdZM+NhQlSzGsMyJ69nLWbKQFEVXUrLEMMNpJD1i00baD+MUgVHn1nRyvvR56huafjpJLCE68uKhg/8JHFvspZqxeuGo/5DMXPwNTUyMLTB0pBoc9YDz18V2T6l9p9J9Edc0ZZHHN6jVun5gLsWP/c9k+KY4jvpyyv2KpeDEn9isaJTpFuJbZ/dhuEu1Ft2qsQ7PUIkAKWKF9qo6AbliTz24OYRmD10Plxj+aoQAKx36+OADcYn9b3oi2881cJrqmzjAb3O76VnpVPiZ7y2THa56OiWfbxIb7Ur8YdKUfq2Yt0MQ5i3GXyddxG17j0FDp6PQn5h4qJzceorpTcAhIkAOurJv6A8f2+aFc9pzyQ547sDTuiUjs+Rb55r8Maxes9ZCxvnDtPtf5M1XROERzB9eKftVXrRju9OHCf7ptzla5cGZREt8t+sE5oU3VXIBW0aUkcuN9ycnZqRtUBWhssVRjuoRNkw7Ha9vwwsAvxSsX4iB/7xNtLriNiNPnZk4mdf1q3F+q+Odye+dvQCkONQdncwyOykv2mAmODQzshez/LUSmB1CH/zn98cWFWJzmUDxvyGlPITzwxWVn2/HVrisBiM1XnbTDBuRnQDNY+uxonlfTm9TBGQWrF3e9HxXdO5au2wAHPeLDR9RG0u5gNRO2DQdwoZlF0QNav3XCxWXfohaIoh2ITY9MdhwhddhuIJs8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR21MB6859.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlhCOGc3dEs3djZlNjFGbUdUN3M4YW5SdkJSVlVQZjI5Ylh4UVJSNGZmSWVF?=
 =?utf-8?B?VFFjVCt5MENZbVBUWWNxTUYyOXM4T1J1TStkb1REZEtjblhPWHJtYks0OHpF?=
 =?utf-8?B?VWRxMWF2SVZFZnYzS0QweVNZR0VaMlRsOWJwMlh6SXhReTJaeHZjT2k2dGsx?=
 =?utf-8?B?LzhSOHRmUmcwbG4veWxsVWFkNE9IWXVHZTJhTC84VXRMVG5rd0JHWEUyQXFi?=
 =?utf-8?B?KzdwczYrbGZyRDEvNFZYc1dnWTUxRXY0UnZXWlJDWVQ3MkZRWUZvNFlrSU5m?=
 =?utf-8?B?aERCUVBZU0ZkVVdSNmJWWjhGWEFjUHNzN2tvdVE5OWU4VG5hK2JaRU1EYUN3?=
 =?utf-8?B?MnFEWFpxU2dCOFNvYzM5dDFkWXdYamxPaDNZWFhsbXRJb3BtN0ljRWdsZHhH?=
 =?utf-8?B?bFViSW9sSGNNTVJudDdqVlNMbUN0M2dhSlBUb3E4dXM5UWF6bHdrYkFGV2kr?=
 =?utf-8?B?OXBUQi8rdFRhT21JSUF3QXVxZlJqalFlS0RHS0x2NFhybnp4bW9IYzBhRVFp?=
 =?utf-8?B?dG4zeGRMeDcyQWttMmhyNXU0cnhwUDlCcUQ5Tkt1UFRhanFmK0U4eWdJS0di?=
 =?utf-8?B?V2hoczNwbGgyQUpxSFJSZzEvYlNwRUE0SWpveGZBMzErc1pLTmQwY3cvUzFq?=
 =?utf-8?B?UmhBMGJmYXFjczJlV2hwakZSR3hxS1FBMzhWZ0dZWGxoNm5ic1BZbllQTlRW?=
 =?utf-8?B?YWdtekc3bithL3FBeEhMdnVhNlFrOE1KYXdKRVhUMCtMWDF5amtCNmlsMitD?=
 =?utf-8?B?TnhHZGhFTzlpRVE0SGdjUjU1Z0RSZytuRzNTU1hKemVWdFRyUVFmUGVoNmh6?=
 =?utf-8?B?V2RJWFA4ZTlXSzFHdTN2cTMvNEl2NjEySm1JM1VKSmFvU2NiRkR1T2pUUXox?=
 =?utf-8?B?YmkzcVZRaGU1SlY5ejZMdUlKOUFEUmRLWlVVWmpqQ1U0c2RuUGVPK3JqbEQv?=
 =?utf-8?B?cS83QitOM3Q4RGUxWElUelJYZTl6QmJLVGdSTDRxTWRQcDJTOGZtZnpMUlBi?=
 =?utf-8?B?Y3gvSnBYQWtPN1VwRDFwOFR5eUpDKzRRVlJGZzNvUEF4KzBKVnhVUVRwTmk4?=
 =?utf-8?B?aWxTamVnZXp6NU9pbldwdFFIVndKVzNWalB4Q2tBbHptYkcxdnozeFlURWZ5?=
 =?utf-8?B?YnRIbS9BSHUvby9nWURjSWd1ZHh0TStxWHA5bjN4bmN1S21XUUplYWc4bThs?=
 =?utf-8?B?VTVZSktsdVFrZVRvWDhaaTRQL2RlVlN0UzRQcGRuTWhrQmFlU20zK1dZckFT?=
 =?utf-8?B?VUdLbGNVbDhtOHk1LzRwcUVhTkJ5a3JObkRxaktXQW9Td0ZkSTlLUlVvWkRF?=
 =?utf-8?B?WGF1MmNpcEhzdm9EU0ErY055Mk9hNUJ1RDJqNHZHanFnN21MZGFmcHl3WWpI?=
 =?utf-8?B?QTJhbm53eVlDY2V2ZEFXSm5LK2MrK0lpZlFUemV4NHJZSFhsM3lTQ3c1aVBE?=
 =?utf-8?B?cGxFU3dDeXVCaW00d2pGcCtkZ2tFbVpMeC9TbUx6MFd0Nnd4RHpWNG5paVpY?=
 =?utf-8?B?bnlhWFFUWDlIT2FnQVI4ZzV5eUJiUXhSNmM3dFR5dWgwT0I0NWcwUHdCSHE5?=
 =?utf-8?B?TG0xZFNqSG1UNGxQQXI2NExvYnc4ejRKdkNkNk9tMEJPcC9ucEo1MDhXdngx?=
 =?utf-8?B?elNMYnM0SThTU3NFa3h2R045L3MrdldQeXdFejk4cFJ2bEhxYTdqSEVYaEYr?=
 =?utf-8?B?ZW16b21iZTlOWFNONG1RaXJJYXVuZDBFWTdOc3RCenVPY1Fzc1IxcTNxVEhN?=
 =?utf-8?B?Q1B0U1lBNHg2c1FETS9zSVh2eVZ5bmRIakRKUDcwQW5pc1FFbmR5V29WMnVp?=
 =?utf-8?B?SUZ3SzhDVUkzclF4YnZzTEFrQVVIZUFHenNyWkRQZDJIOE9VaDYrVFVleGVX?=
 =?utf-8?B?cTlmSW1ISXFLVmVIQVBPay9acVhiZXpLcndXSVhsR0NsRzYxRExQYWdDblZC?=
 =?utf-8?B?UTRYamdETWdWRk9WQ0ZMc2wzVHhGSUhid3M4MXhJVFlTSmdyNFdRZ292L3VH?=
 =?utf-8?B?cUx1RTY3VHFoVWoxS0x2YlZKWXpPVnpDYmwxNEpMblo3bEY4SDRmUGp1d2FV?=
 =?utf-8?B?a29TTDB2SzRyc2xhTllTZ3NIWXBGdklWa1hIMTRGdjNDNGxIT2ZEUlFycDFS?=
 =?utf-8?B?Mm44Tm5sQ3p2S3FWSm1mRDlrRGYwRmtXRWgrSEtxSURFQnRVSnpyYndEeEYv?=
 =?utf-8?B?TGdDbVJyQS9ETWtURys0cm03UWUyQzdzNUJpL3VCNlhOMTdydjhaTlcvbm55?=
 =?utf-8?B?b2k1bUl2RVB2V3FNN3V0TFY3SEtEaGZ3MDJkV1dYalJ2RkFDL0p1NTdmc1VS?=
 =?utf-8?B?WDM0c1NnNVFNanNRU0FkMnAxMEhNRzQvQVRjNGVSOEc0WlNhdElwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR21MB6859.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4da86d-675e-4cce-c591-08ded136e2f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 14:51:19.8137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRf+B8NdOY9LfoQj/q+C12cvkPhHrX7srkdUiyfNapKjLG0O3NhZNhExXlRyo5t2e2mODc38vZyl2PjB2KLHlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB6863

T24gVHVlc2RheSwgSnVuZSAyMywgMjAyNiA2OjQwIEFNLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBXZWQsIEp1biAxNywgMjAyNiwgSsO2cmcgUsO2ZGVsIHdyb3RlOg0KPiA+IE9u
IFdlZCwgSnVuIDE3LCAyMDI2IGF0IDA2OjM3OjUyQU0gLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJz
b24gd3JvdGU6DQo+ID4gPiBPaywgc28gaXQgdG9vayB1cyBhIGZldyB0aW1lcyB0byBsZWFybiBv
dXIgbGVzc29uLiAgSSBzdGlsbCBkb24ndCBzZWUgdGhhdCBhcyBhDQo+ID4gPiBzdHJvbmcgYXJn
dW1lbnQgZm9yIG5ldyB1QVBJLCBlc3BlY2lhbGx5IG5vdCBmb3IgVk1TQSBwYWdlcy4gIEkgYW0g
dmVyeSBmaXJtbHkNCj4gPiA+IG9mIHRoZSBvcGluaW9uIHRoYXQgbGV0dGluZyBhbnl0aGluZyBi
dXQgdGhlIGhvc3Qga2VybmVsIGNvbmZpZ3VyZSB0aGUgVk1TQSBpcw0KPiA+ID4gYmV5b25kIHN0
dXBpZCwgYnV0IHVuZm9ydHVuYXRlbHkgd2UncmUgc3R1Y2sgd2l0aCBBUF9DUkVBVElPTi4gIEV4
cGFuZGluZyB0aGF0DQo+ID4gPiBzdXJmYWNlIGhhcyBhIHZlcnksIHZlcnksIFZFUlkgaGlnaCBi
YXIgdG8gZ2V0IG92ZXIuDQo+ID4gDQo+ID4gVGhlIHN0cm9uZ2VzdCBhcmd1bWVudCBpbiBteSB2
aWV3IChhbmQgdGhlIG1haW4gcmVhc29uIHdlIGFyZSBkb2luZyB0aGlzKSBpcw0KPiA+IGFjdHVh
bGx5IHRoZSBwcmVkaWN0YWJsZSBsYXVuY2ggbWVhc3VyZW1lbnQuIE9uIFNFVi1TTlAgdGhpcyBp
cyBhIHJlcXVpcmVtZW50DQo+ID4gdG8gdXNlIHBsYXRmb3JtIFZNLWlkZW50aXR5IGZlYXR1cmVz
IGxpa2UgdGhlIElEIEJsb2NrLg0KPg0KPiBBbmQgSSdtIHNheWluZyB0aGF0IHVubGVzcyBLVk0g
KmNhbid0KiBwcm92aWRlIGEgcHJlZGljdGFibGUgbGF1bmNoIG1lYXN1cmVtZW50LA0KPiB3aGlj
aCBBSVVJIGlzbid0IHRoZSBjYXNlLCB0aGVuIHRoZSBsYXVuY2ggbWVhc3VyZW1lbnQgKm11c3Qq
IGJlIHN0YWJsZSBhY3Jvc3MNCj4ga2VybmVscyBiZWNhdXNlIGl0J3MgcGFydCBvZiBLVk0ncyBB
QkkuICBTbyBhcyBJIHNlZSBpdCwgdGhlIGlzc3VlIGlzbid0IHRoYXQNCj4gS1ZNIGlzIGluaGVy
ZW50bHkgdW5wcmVkaWN0YWJsZSwgaXQncyB0aGF0IHdlIGxhY2sgdGVzdHMgdG8gdmFsaWRhdGUg
YSB0aG9ybnksDQo+IHN1YnRsZSBwaWVjZSBvZiBLVk0ncyBBQkkuDQoNCkpvZXJnIGlzIHN1Z2dl
c3RpbmcgdGhhdCB3ZSBuZWVkIGEgbGF1bmNoIG1lYXN1cmVtZW50IHRoYXQgaXMgc3RhYmxlIG5v
dCBqdXN0IGFjcm9zcyBtdWx0aXBsZSBsYXVuY2hlcyBvbiB0aGUgc2FtZSBzeXN0ZW0sIGJ1dCBh
Y3Jvc3MgbXVsdGlwbGUgaHlwZXJ2aXNvcnMuICBUaGlzIGlzIHdoYXQgaXQgbWVhbnMgdG8gaGF2
ZSBhIHN0YWJsZSBJRCBibG9jaywgc28gdGhhdCB0aGUgc2FtZSBJRCBibG9jayBjYW4gYmUgdXNl
ZCBldmVyeSB0aW1lIHRoZSBndWVzdCBpcyBsYXVuY2hlZC4gIFRoZSBzeW50aGV0aWMgR1BBIHRo
YXQgS1ZNIHVzZXMgdG9kYXkgdG8gYXNzb2NpYXRlIHRoZSBWTVNBIGlzIG5vdCBhcmNoaXRlY3R1
cmFsLCBzbyBpdCBpcyBub3QgdXNlZCBieSBhbnkgb3RoZXIgaHlwZXJ2aXNvci4gIFRoZSBvbmx5
IGFyY2hpdGVjdHVyYWwgY29uY2VwdCB0aGF0IGV4aXN0cyBpcyBHUEEsIGFuZCB0aGUgb25seSBj
b25zaXN0ZW50IG5vdGlvbiBvZiBHUEEgaXMgdGhlIGd1ZXN0IGFkZHJlc3Mgc3BhY2UsIHNvIHBl
cm1pdHRpbmcgdGhlIGd1ZXN0IGltYWdlIHRvIHNwZWNpZnkgdGhlIFZNU0EgR1BBIGlzIG5vdCBv
bmx5IHRoZSBvYnZpb3VzIGNob2ljZSwgYnV0IGl0IGlzIHRoZSBvbmx5IGFwcGFyZW50IGNob2lj
ZS4gIEJleW9uZCB0aGF0LCB0aGUgU05QIGFyY2hpdGVjdHVyZSBkb2VzIG5vdCBzcGVjaWZ5IGFu
IGFyY2hpdGVjdHVyYWwgc3RhcnR1cCBzdGF0ZSBmb3IgdGhlIGJvb3QgcHJvY2Vzc29yLCBhbmQg
Z3Vlc3RzIGV4cGVjdCB0byBiZSBhYmxlIHRvIHByb3ZpZGUgd2hhdGV2ZXIgY29udGVudHMgdGhl
eSBuZWVkLCB3aGljaCBjZXJ0YWlubHkgc3VnZ2VzdHMgdGhhdCB0aGUgZGF0YSBvZiB0aGUgVk1T
QSBpcyBndWVzdC1jb250cm9sbGVkLg0KDQpSZWdhcmRpbmcgdGhlIHRyZWF0bWVudCBvZiBWTVNB
cyBnZW5lcmFsbHksIHRoZSBTTlAgYXJjaGl0ZWN0dXJlIGNvbnNpZGVycyB0aGVzZSB0byBiZSBn
dWVzdC1vd25lZCBkYXRhIGJlY2F1c2UgdGhleSBoYXZlIHByb3RlY3RlZCBjb250ZW50cy4gIE91
dHNpZGUgb2YgdGhlIGJvb3QgcHJvY2Vzc29yLCBldmVyeSBBUCBzdGFydHMgYnkgZG9uYXRpbmcg
YSBHUEEgcGFnZSB0byBiZWNvbWUgdGhlIFZNU0Egb2YgdGhlIG5ld2x5IHN0YXJ0ZWQgcHJvY2Vz
c29yLCB3aGljaCBpcyBuZWNlc3NhcnkgYmVjYXVzZSB0aGUgZ3Vlc3QgaXRzZWxmIHdyaXRlIHBy
b3RlY3RlZCBjb250ZW50cyBpbnRvIHRoZSBWTVNBIHRvIGluaXRpYWxpemUgaXQgYmVmb3JlIGl0
IGNhbiBiZWNvbWUgZWxpZ2libGUgZm9yIGV4ZWN1dGlvbi4gIEFuZCBiZXlvbmQgdGhlIEFQIGNh
c2UsIHdoZW4gbXVsdGlwbGUgVk1QTHMgYXJlIGludm9sdmVkLCBlYWNoIGxvd2VyIFZNUExzIFZN
U0EgYWxzbyBvcmlnaW5hdGVzIGFzIGEgR1BBIHBhZ2UsIGFuZCBoZXJlIGl0IGlzIG5vdCBvbmx5
IGZvciBpbml0aWFsaXphdGlvbiBwdXJwb3NlcywgYnV0IGJlY2F1c2UgdGhlIGhpZ2hlciBWTVBM
IGhhcyBhbiBvbmdvaW5nIG5lZWQgdG8gcmVhZCBhbmQgd3JpdGUgdGhlIFZNU0FzIG9mIHRoZSBs
b3dlciBWTVBMcyBmb3IgbWFuYWdlbWVudCBwdXJwb3Nlcy4gIFdpdGhvdXQgdGhlIGxvd2VyIFZN
U0FzIGxpdmluZyBpbiB0aGUgR1BBIHNwYWNlLCBpdCBpcyBkaWZmaWN1bHQgdG8gcmVhc29uIGFi
b3V0IGhvdyB0aGUgaGlnaGVzdCBWTVBMIGNvdWxkIHJldGFpbiBhIHZhbGlkIG1hcHBpbmcgZm9y
IHRoaXMgYWNjZXNzLg0KDQpTbyB3aGVuIHlvdSBhZGQgdXAgdGhlIGZhY3QgdGhhdCBBUCBWTVNB
cyBhcmUgaW50ZW5kZWQgdG8gYmUgZ3Vlc3Qtb3duZWQgKGJ5IHRoZSBHSENCIHByb3RvY29sKSBh
bmQgdGhlIFZNU0FzIG9mIHRoZSBsb3dlciBWTVBMcyBhcmUgcmVxdWlyZWQgdG8gYmUgZ3Vlc3Qt
b3duZWQgKGZvciBvbmdvaW5nIGFjY2VzcyksIHRoZSBpZGVhIHRoYXQgdGhlIEJTUCBWTVNBIG11
c3QgYmUgaG9zdC1jb250cm9sbGVkIG1ha2VzIGl0IHRoZSBvZGRiYWxsLiAgSWYgdGhlIHN5c3Rl
bSBoYXMgdG8gc3VwcG9ydCBWTVNBcyBsaXZpbmcgaW4gR1BBIHNwYWNlIGdlbmVyYWxseSwgdGhl
biBpdCBkb2Vzbid0IHNlZW0gbGlrZSBhIHN0cmV0Y2ggdG8gc2F5IHRoYXQgdGhlIEJTUCBWTVNB
cyBjb3VsZCBiZSB0cmVhdGVkIGlkZW50aWNhbGx5LiAgVGhpcyBnaXZlcyBjb25zaXN0ZW5jeSBu
b3Qgb25seSB3aXRoIHRoZSByZXN0IG9mIHRoZSBWTVNBIGRlc2lnbiwgYnV0IGdpdmVzIGNyb3Nz
LWh5cGVydmlzb3IgY29uc2lzdGVuY3kgYXMgd2VsbC4NCg0KLUpvbg0K
