Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A571EB1AA;
	Sun,  6 Sep 2026 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717200; cv=fail; b=t6tZ8B5dzp0h9CdwJLuiVz2fa8Dts1wF/PMMdIWloNlTjzl7wFWtVPuVSPou5dTzjpQYYdjCqD5X3wSu1n6IjHpYF5g82rI+m5XCjyhh7F52yAFKOfTK5nxR5W57NUwdpvhvihzpqTO/C+4PgTuuGJ/nPJMkPLzDVw3d1Gk4n0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717200; c=relaxed/simple;
	bh=6Jq0O2z5owVK23Nl+cBZnIietdTmtgNDeMit/uOiHYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IWtAb45iEZivulYPVbHz0N1QMzK1AXN4UuEtwDDSgvc2Czx3P19BEFOtF6AMSvhms5mMumGroQhL5XwN+zoErzZRz4tqPEd5Un6b6FH5ygBJIre689IQdRo6hWVaoqU10Jf0Q2Jnc8iSNHD0UErxiQK3UDAtDO4p6zaFv5SzsLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B9nfvvZG; arc=fail smtp.client-ip=40.93.194.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B9nfvvZG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9qBXSBwTvV0XTeRZNHTGxtA5iLAC51m4kys3/sInBHJKGteSCUTNOKqTuwBG0uIxsSO4vVuWXVlHSPvNmbCFlrfV+MWQYjlIBzZzFtiTVvuTzdPx/0u8Mzw+N+jmW0acdRVkMNxbZdXxquhwPjR/jAxD3BrOQz9zoHyoOJcgsNqGEf3Zoyeuy/W0hLniQFlzjPdoc4iUy0ZFHYeiVC1Dg1Ezjhw6hHIzxpDKGNbxIgJYp26hdheAO6Q/YLCj2JAvW065zOmFg9UaAH1+/6D2mQWL5BdkQd/IktzynFkAufUJu6U8UBanYvaVsCLTgfdA+NQtPP9dHHRIByJrMz1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jq0O2z5owVK23Nl+cBZnIietdTmtgNDeMit/uOiHYI=;
 b=wQmdUtW8Uva0Sq8xUoTBVEkCb75zJ7zEnDK/xVdsLefYuRVcUKxznfggtMuDIHzFA3peXuwFkeKy6MGzRPVmryAenBO6e4gm/8hOnoebzrtJ1So6NB1rMQ1s2VWUs48SFGUupuboazyN00rMRxDTmMq+gr4q6yfDQYv8MzfKswWspH5Aas2sE6scfoSUELp/tUc0cLaBjeEKPI3hRQ7MPvx/s+MKnXJbDrFKscIi8B/e2c9ZLlEnDpsVnmU2GnC/4Yx8Q79Sp63X2STXeJoz1z05P3rXnZefMGvICfVcjUxWtxqE7Aa2fu0dM9Qbrt0npcIzumXTmRkcT2A7DYPEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Jq0O2z5owVK23Nl+cBZnIietdTmtgNDeMit/uOiHYI=;
 b=B9nfvvZGK76HeBnLwT/48fM+Z8Vb/KDnPTV2eQdjrkKb3iM8+7zFVfUVRiHCvAIstCnykeeCpG7PPFjSpXLL+TDOAj7J87YQqe3NPIDgatvrCPsMUI3PgN2iejd9N3bYj5o47922aJa065e3deTIafDrqM4Q/NmDHNsCuPnPpZk=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Sun, 6 Sep
 2026 17:53:15 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0382.007; Sun, 6 Sep 2026
 17:53:15 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] KVM: selftests: Add common helper to get mask+number
 of usable memory NUMA nodes
Thread-Topic: [PATCH 5/7] KVM: selftests: Add common helper to get mask+number
 of usable memory NUMA nodes
Thread-Index: AQHdOzl8DfEraE6Z1k+MmR70UPMl2LbB2rmA
Date: Sun, 6 Sep 2026 17:53:15 +0000
Message-ID: <8c6da18a1edc1ad60bcbf5d3c5956ad3a0aa745e.camel@amd.com>
References: <20260903001625.2792367-1-seanjc@google.com>
	 <20260903001625.2792367-6-seanjc@google.com>
In-Reply-To: <20260903001625.2792367-6-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|LV2PR12MB5920:EE_
x-ms-office365-filtering-correlation-id: 0ffb3388-1be0-42d3-ab72-08df0c3fba0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 BSlg5USY2n9CGvvPpbFEuVllRDIEyUw4wB8ShbtlFn2qXhVTWkmSclynT2aZ8S1uA2b6euH+F1uL3FiPiK/QDMxxTNIihTl/PmUg8zIATaJ8lXo/IBqLbZinCT25nMDQy2btTx29vhRw7YaAS0xD3k4R6m8W1P6oKJCNcoyQFJO2biciH7rgD/tKj25YeBGHGYGhQEE236Ih28e/RIZOny56+u6dRTtADEyLUb0wKTH+tEnD2lgUn/dBLR0/YL+VeLSDDWOJZG/lTr9iXnPnWWuG4cdQLBxbp5cbYn1e9CNqpU4TiHvnrvlLMJ8fBtTub6liFkBhfP+NcjbzodDGTdroGeaRtfUG8j7MZoo5ePObVLO6g6m0T71KFuOJhppj2/RNVpFxqlNsUXFsa+GvXNQfuo4I84hBdsAJz35nonbrvo+pqBU9BdxyX5dkVnCrlkhqBx2nX+5fh2PEB/mUWuqtRs1VysWAAzqQlgPqOLWI9//LCVGpQViq72nssS5eByXVm6n53IbEwTsJ0S7YuL/kin/dq0dxi/mDMXO/9jNZ+lm4qGA0SxfjgNKX/YF7DDp0Qi2uFWrUA2l03SD8cWS8GHUGgavjrQtozlHxmWTc3HbE6FC4g/jvse813V4P2BbeUEECwnx+i2JmLZvXcMI+PkAGfSabUyP1NwhHc9j9DgL/+C+szBBssEsi8xD7E+nbOxglf3x9hAfoCByagCYPOhkNYGLPlxJye/Ib34o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Snd2ZVpnazJqbmE4Y3ZHNkVlUE51YXFBR3lxOHRPai9TNGEvRzRjSUNvUFBZ?=
 =?utf-8?B?cS9XbktqQmtLdG43SWVxKzNZM3VxVG5kam9GWXhUaUd1ZTlWWEhFNCt6MzNh?=
 =?utf-8?B?cit6M3d1eGhwelFXSUVMYjlDTUtVTjcxTWtUQlhEU1VaVW5PSERtSnRlMlpE?=
 =?utf-8?B?RnhFbytvcWlSRWxBSitTMHIza3JkcTJySkdOVnhpaDd2N3EzdUtlNlVxQW1L?=
 =?utf-8?B?MXkveGpiNjJpWXFycjF0UWFNS1M1SWwxaXUxNThGYVFsNlVMU1lOS05sY1FW?=
 =?utf-8?B?ZjYrdm1rTVI1MEVQdThEVml6YlZVcXRPQXM0Rm1PZk5XSDkyL21BdUZ6SFlG?=
 =?utf-8?B?OWd2Y2h5OWswcnRramRzWDBoZmc4UnFDN3V3NUxsL3Fnd3Z4Q3FQVGtuZFJy?=
 =?utf-8?B?NHg4UEZQSUNVNEFMeU80ZFBBa3E2Tlo0TjRFcGFlbW9uQ2VMUk11NERMYU1Z?=
 =?utf-8?B?U2orNDNMTmZCaTlvb24xS21DVTFpaGs0OEJXaUFDUUhyR2xWQTg1c3l3Snd4?=
 =?utf-8?B?c001MzZ5RmQ2d2dXa3dWMis5U0dYaUl0TmRUUTNjaGFvd25uNzNRVzBTdWdR?=
 =?utf-8?B?WUxVUzlKRzlWdGtIWEUvMFFtRjJmK2RPRDJEQUc4NlJnSHovY3dDN2ZGNmdz?=
 =?utf-8?B?ZnJMa2tnZlB1a1JSbkN4UHA1dFFFVmcyaG5qVTdsMEVBTkczNFZiZUlUR1Mz?=
 =?utf-8?B?UUFvQXNkdGppeE1hdjQ5ZFBmdXc3S1B0alloNHk5K2YvSHJINDdQbUI1UUlz?=
 =?utf-8?B?Q3c4bFdQNHBIMVlQTFNvbWhVdFdNWStZSk1Lc0N1bWhNajRXV29mRGsvZDRH?=
 =?utf-8?B?RUNJbE83ejFBKzB3V2RuU2h1WVh0ZGZUYTlaaWx1YzNCUUdoSVh5cWJlTnBj?=
 =?utf-8?B?dDhDVmJ4SjBNZWRscFduTzYzbHNBUCt0cW56eUdlK3hlRjdIcSt5SHo5TU9o?=
 =?utf-8?B?Y2RHOXB4L2d3NFducnZzc0JhTklZWmtDSkdLWjc1Vm1GU2pMUzZpa1VOekdp?=
 =?utf-8?B?eXZrNjJSUHo1eVNNaS9tZlVNb2N1TkxsK2ROZytoY0E5dWtNdFd1Zk53M0dK?=
 =?utf-8?B?KzlnenNVSG16SnFoRTZ4bVYyRitIRDhJZlZCL2pVNUlwSUpOeVhQL3loU1RX?=
 =?utf-8?B?ckltRWtNWVdvNnBPT0Q5RERpdFRVbmd3d2kzazdzU2JtVlpIZjdaYmJDZjRi?=
 =?utf-8?B?VTllQlQ0bVBVem1Pc1hycGc3eVN4YjA4TkxnZ1JYM3BON2VtWUphVjl5dkll?=
 =?utf-8?B?dzZXMDc0b1lBK21xTVJ5VDFkMVJHbmc5bWpPU0pTazdUa3I4a3N4ZlFtN3lk?=
 =?utf-8?B?UDdyS2UrNnBmT3pTYllvTmZWSEFqYVZlQ2tVUFN6cytQcDNsVWwwQmNmTUxC?=
 =?utf-8?B?L3dMS2lCbWFFQW9OSTNJdWVtTjFiakVEbzEzNDdtMUpPampValYxOWFib3BT?=
 =?utf-8?B?RjJuNFZGYnF6cldENWlNeHVvMTFYYUpQdUVTY29nMUgvdSthME93RW9hRVFC?=
 =?utf-8?B?VmxGWW1qWmR0US9PRHg4R3ZTT2ErV0x4OUFLM0lPdGNBTGtuUnI0WkVjR2JG?=
 =?utf-8?B?ZUZMZlFIN25IT013UXlIalZTMk1RcVRlcWhyM3V2NGlKc1lzK3lXTjRmZHNq?=
 =?utf-8?B?ZzZ5cmxRM2lCeVFEdzR2L2paYlNjZTFhZXIyN2hQSjNoWDhRY2o1TVI0SnRT?=
 =?utf-8?B?YjZIdkxVYVpIVmthZ1lFdDhVR0NSa1JrL1JxTE5YRFl0OE81Nm8zZzlyODRn?=
 =?utf-8?B?QjNOMUd5M1E4QjVKSnIySUdCamswaVhNVUttR0NLTmxqdUZPb0IyeXpOeG11?=
 =?utf-8?B?MG5BdlREYVBJVkpWL1FuVFozWWtsZ2srL1Rmck9zS2V0MEdYeHVzUVc5WHBh?=
 =?utf-8?B?OUxSRGJ4TE42STAxQnBJb2hQcldoMlR6L2N2WWpKVStJbTRUZkV3WFZEbXZC?=
 =?utf-8?B?d2ZxYzJNeW1aZ2wrUXNlS0xqdVJPRWF3YWtFdFRtQnduU016WG9SRENSV3d3?=
 =?utf-8?B?RFMzbXRxN3hLdm1qWmdGVS9VWW1adTRLTkc0cmF1OEdqZjVMeHcyR2ZlSXZq?=
 =?utf-8?B?eC9zaGwrQzA0N09VNW9NTGwwTHI3QzdPKzJHcjJmODVwM3ViODY3VXFoYXdr?=
 =?utf-8?B?c0hoVndGWE16d1g2RTdKRGpZbnNUNFFnVlpWNFVGb0NwSlZsZ2JORUtsZG50?=
 =?utf-8?B?NnhiQ3k0YkxyOWhkbjFpUEJrRUFSdFlBd0M1ekZZaW5TRGd3QUlTZENHeThM?=
 =?utf-8?B?ajVGemlJblJidU40R2pselowL2o5WWIyaEtIdUx6czgzR3NOTDZOUGNaR29r?=
 =?utf-8?B?UVB2VmkrYUsyblpJRFhwT2J5N1YrWG9FK2lyM2FBMnFlWVk0Nnpndz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2B8AAD9D2168E4CAC28889D4EFC17A0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffb3388-1be0-42d3-ab72-08df0c3fba0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2026 17:53:15.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGjws7iTLm+ZAcn1BT5sORoHWnixafFkAvnsoC2SHKe75I+FfcD3Qt6GKs7ALQ6NaivTNY+tmfBAU2dP93UE+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDE3OjE2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBFeHRyYWN0IGFuZCBzbGlnaHRseSBhZG9wdCB0aGUgeEFQSUMgSVBJIHRlc3QncyBs
b2dpYyBmb3IgZ2V0dGluZyB0aGUgbWFzaw0KPiBhbmQgbnVtYmVyIG9mIHVzYWJsZSBtZW1vcnkg
TlVNQSBub2RlcyBpbnRvIGEgY29tbW9uIGhlbHBlci4gIFRvIGFsbG93IGZvcg0KPiBmcmllbmRs
aWVyIGJlaGF2aW9yIHdoZW4gdGhlIHVuZGVybHlpbmcga2VybmVsIGRvZXNuJ3Qgc3VwcG9ydCBO
VU1BLCBvciB0aGUNCj4gdGVzdCB3YXMgcnVuIHdpdGhvdXQgc3VmZmljaWVudCBwZXJtaXNzaW9u
cywgemVybyBvdXQgdGhlIG1hc2sgYW5kIHJldHVybg0KPiAiemVybyBub2RlcyIgaWYgZ2V0X21l
bXBvbGljeSgpIGZhaWxzIHdpdGggRU5PU1lTIG9yIEVQRVJNIHJlc3BlY3RpdmVseS4NCj4gSS5l
LiBhbGxvdyB0ZXN0cyB0byBza2lwIChzdWIpdGVzdHMgaW5zdGVhZCBvZiB0aHJvd2luZyBhbiBh
c3NlcnQuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFNoaXZhbmsgR2FyZyA8c2hpdmFua2dAYW1kLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5j
b20+DQo+IC0tLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2luY2x1ZGUvbnVtYWlm
LmggICAgIHwgMTMgKysrKysrKysrKysrKw0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3Zt
L3g4Ni94YXBpY19pcGlfdGVzdC5jIHwgIDUgKy0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vaW5jbHVkZS9udW1haWYuaCBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2t2bS9pbmNsdWRlL251bWFpZi5oDQo+IGluZGV4IDI5OWRkZGZmMjcyOS4uMDk0NTUw
MGM2MzIyIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vaW5jbHVk
ZS9udW1haWYuaA0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vaW5jbHVkZS9u
dW1haWYuaA0KPiBAQCAtNDEsNiArNDEsMTkgQEAgS1ZNX1NZU0NBTExfREVGSU5FKG1iaW5kLCA2
LCB2b2lkICosIGFkZHIsIHVuc2lnbmVkIGxvbmcsIHNpemUsIGludCwgbW9kZSwNCj4gICAqLw0K
PiAgI2RlZmluZSBNQVhOT0RFX0ZPUl9NQVNLKG1hc2spIChCSVRTX1BFUl9UWVBFKG1hc2spICsg
MSkNCj4gIA0KPiArc3RhdGljIGlubGluZSBpbnQga3ZtX2dldF9udW1hX21lbW9yeV9ub2Rlcyh1
bnNpZ25lZCBsb25nICpub2RlbWFzaykNCj4gK3sNCj4gKwlpbnQgcjsNCj4gKw0KPiArCSpub2Rl
bWFzayA9IDA7DQo+ICsNCj4gKwlyID0gZ2V0X21lbXBvbGljeShOVUxMLCBub2RlbWFzaywgTUFY
Tk9ERV9GT1JfTUFTSygqbm9kZW1hc2spLCAwLA0KPiArCQkJICBNUE9MX0ZfTUVNU19BTExPV0VE
KTsNCj4gKwlURVNUX0FTU0VSVCghciB8fCBlcnJubyA9PSBFTk9TWVMgfHwgZXJybm8gPT0gRVBF
Uk0sDQo+ICsJCSAgICAiVW5leHBlY3RlZCBnZXRfbWVtcG9saWN5KCkgZmFpbHVyZSIpOw0KPiAr
CXJldHVybiBfX2J1aWx0aW5fcG9wY291bnRsKCpub2RlbWFzayk7DQo+ICt9DQo+ICsNCj4gIC8q
DQo+ICAgKiBSZXR1cm4gdGhlIG5vZGUgSUQgb2YgdGhlIG5leHQgTlVNQSBub2RlIGluIHRoZSBt
YXNrLCBzdGFydGluZyBhdCBAZnJvbSsxLg0KPiAgICogR3VhcmFudGVlcyBhIG5vZGUgaXMgZm91
bmQsIGFuZCB0aGF0IHRoZSBmb3VuZCBub2RlIGlzIG5vdCBAZnJvbS4gIFBhc3MgLTENCj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODYveGFwaWNfaXBpX3Rlc3Qu
YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODYveGFwaWNfaXBpX3Rlc3QuYw0KPiBp
bmRleCA3MTQ0YWQ4MzNhZTAuLjQyYzYwMTYxN2Y1YSAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMva3ZtL3g4Ni94YXBpY19pcGlfdGVzdC5jDQo+ICsrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2t2bS94ODYveGFwaWNfaXBpX3Rlc3QuYw0KPiBAQCAtMjQ0LDE1ICsy
NDQsMTIgQEAgdm9pZCBkb19taWdyYXRpb25zKHN0cnVjdCB0ZXN0X2RhdGFfcGFnZSAqZGF0YSwg
aW50IHJ1bl9zZWNzLCBpbnQgZGVsYXlfdXNlY3MsDQo+ICAJZnByaW50ZihzdGRlcnIsICJDYWxs
aW5nIG1pZ3JhdGVfcGFnZXMgZXZlcnkgJWQgbWljcm9zZWNvbmRzXG4iLA0KPiAgCQlkZWxheV91
c2Vjcyk7DQo+ICANCj4gLQkvKiBHZXQgc2V0IG9mIGZpcnN0IDY0IG51bWEgbm9kZXMgYXZhaWxh
YmxlICovDQo+IC0Ja3ZtX2dldF9tZW1wb2xpY3koTlVMTCwgJm5vZGVtYXNrLCBNQVhOT0RFX0ZP
Ul9NQVNLKG5vZGVtYXNrKSwNCj4gLQkJCSAgMCwgTVBPTF9GX01FTVNfQUxMT1dFRCk7DQo+ICsJ
bm9kZXMgPSBrdm1fZ2V0X251bWFfbWVtb3J5X25vZGVzKCZub2RlbWFzayk7DQo+ICANCj4gIAlm
cHJpbnRmKHN0ZGVyciwgIk51bWEgbm9kZXMgZm91bmQgYW1vbmdzdCBmaXJzdCAlbHUgcG9zc2li
bGUgbm9kZXMgIg0KPiAgCQkiKGVhY2ggMS1iaXQgaW5kaWNhdGVzIG5vZGUgaXMgcHJlc2VudCk6
ICUjbHhcbiIsDQo+ICAJCUJJVFNfUEVSX1RZUEUobm9kZW1hc2spLCBub2RlbWFzayk7DQo+ICAN
Cj4gLQlub2RlcyA9IF9fYnVpbHRpbl9wb3Bjb3VudGwobm9kZW1hc2spOw0KPiAgCVRFU1RfQVNT
RVJUKG5vZGVzID4gMSwNCj4gIAkJICAgICJEaWQgbm90IGZpbmQgYXQgbGVhc3QgMiBudW1hIG5v
ZGVzLiBDYW4ndCBkbyBtaWdyYXRpb24iKTsNCj4gIA0KDQpSZXZpZXdlZC1ieTogU2hpdmFuayBH
YXJnIDxzaGl2YW5rZ0BhbWQuY29tPg0KDQpUaGFua3MsDQpTaGl2YW5rDQo=
