Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0939D47F76B
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255542; cv=fail; b=oQftUNnLyGpmzJ3syyzPgEsadXbCngk+PtYfkQQQdJ32KhIk01DFczhuxK0EZZZhPCW/uJohDBLTrdpIjzVYnM49CDfxpj3UHqx7vBuaa7Q72LR49Sc5P225NESTdPfV5/uY806tOrmjmVPHaJOVKxf5Isr4inXiMhRTIhyNg2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255542; c=relaxed/simple;
	bh=QTnrHuGRsxFSyvL/6eeDtKnpdRVm8adAD5oiLsBPV/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t3DjIgUsjbQCWfH2kESRmw7oDjINEjnXP77uNifpabx3nsEb0Ptg/6Xj7plxjAk1LAS0eGYrRQ9vdcCPhnHg2iKa1rrp3I1oXoH4Lo13UfI8HKFVqFd/IDwU70ec4hbQsgo2j7yHaLoUFJvA2Q7OISrAweBgBAOMsWdieeldxyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SX/Si0dK; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SX/Si0dK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnKt6k4OaLQTnKXycNX0GNGPsI6O6A/p3trWzIepTU6rUo72FYXeZzyz4o6XpRNy1CgMROSlzIJX0gQXdBy98HTi/QqvGjA2xY7IJR9GTW39TnBidmh890NvrimS05M/ld0ztEEUxPGxchL4Uy4gWHl8FKWDZsUtCDEHM4M6mu/aUcprl02DfGoC+RyTp2wBd9Gil4KExR9mj+zMryg8LDRc3u/z/cympvS2EyZQ6kLupqMHNLabhxK7YS0LVAlmEkDyqwup9peyMaA1VcZdoubMkrr83wjNj3p7MdD+bvIKJPnKPpc5BfFYfi4saGAT6BFs0pgbaARoLutcVbKFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTnrHuGRsxFSyvL/6eeDtKnpdRVm8adAD5oiLsBPV/k=;
 b=mWsStqzzGl0hoN2BggZ4ab11NUlxGXsOUpgAUfcIuu52wrnOF0vaPjVrsht13LkikMWDe1kLS5URyYTVBmj5Hzp+uDErYwXbilVCWeoS0ozsKlXwuZrniK2M1XbqBPmhgN3+8Ae9kn0B+gWcXyrOTdHsQEyYzWSnh5JW7uzgBWoA32YhIRC//kIa52Rtnt4kOF4GrVx+coaYaKDNnmJHf43Xeya+1cXplXeAwHqQ/1QC9YA+BqPUG3b833nyZ0/bNShBsUvbGyt3Y9jM5y1U2/Lj/DGhkVlcumtWgdQDB3P+ALGvtddfHc+jRFDPkPEOIP61Y0+SOqZRfdgImK/+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTnrHuGRsxFSyvL/6eeDtKnpdRVm8adAD5oiLsBPV/k=;
 b=SX/Si0dK2e3qZssQA038HlhZVAITWu2MQUokF0S0+bNSdAIUJyZYtk1vXoiwHe+D6h046udyM7iOnxW8ZoNVZlwtPqSavjrJv2N0bRhhwvserX3DnU6AOI5glAZ/EgylSrOaZaqsh6YngqTXsFRlNgzY/XwBKkal7245IYHL+Jw=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 09:38:48 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:38:48 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] KVM: selftests: use allowed NUMA nodes in
 guest_memfd_test
Thread-Topic: [PATCH v2 4/4] KVM: selftests: use allowed NUMA nodes in
 guest_memfd_test
Thread-Index: AQHdOesd755TzqQrVkKO/bnrQakggLa5ZuuAgAAQnoA=
Date: Tue, 1 Sep 2026 09:38:47 +0000
Message-ID: <0a98f85d164cc7eac4ca584b094aa402508efb10.camel@amd.com>
References: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com>
	 <20260901-gmem-selftests-fix-v2-4-5a273153354c@amd.com>
	 <20260901083920.1C86F1F000E9@smtp.kernel.org>
In-Reply-To: <20260901083920.1C86F1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|DS7PR12MB5862:EE_
x-ms-office365-filtering-correlation-id: dbe2df2a-edad-4261-afff-08df080cd2d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Vbo/WdvZEJTdPYlWvalp9rlNLMazfcdhAZTZPMFNjf9/xdqp8vJm30YFKagpzfJjZ87Cgfi8FkynANhaKJScdO8zHnRQ3WL4qiMCjKR3SSEFjXqvmdcnMHF3Q480vRuNPsTRqkAz8pZds1ZkHcqATkLM8fbyC2dSP0d1W5MUWOL2aKu4jh85YdejePGwz73ksWJCRxJA9moaAs5Xek/wzGlduTAQy7UkhD5iheOXf6iW7QLVEYeCxfmtEfrmMKtL5DiIJ1CavE+VOy+tiOpiNpHjZxfsWjpl2y9nxbDPBuHyqp2nI3MRT9pSzbrhRz477iM+8Q54K+Tf/M8E6XAIcRuEJ8IAr5MLglRRZwhscDWpLGbY660iGyw/Coa6+5nJdIO0XUXVqdGs2IIAp/g/uGJ9VBmTEk+7pVy6syEl638P3yceY034Rc2m7Au+6Tpelu0R6UlLoU24R3IGVHNBkDml0Lnse1dky3Yvd0AYCMEoT7Hl13pbZcQx6DbwNdQvRrAV+kZlxp8uZ/b8Gs4BVQ73q3ryyBC6mnRSYoX2lpuk9xOVCWrtZoWWYkvChKfukeR2SkYLmywTaTfCCUcPPZhgllMo0EDKUTnPPDG0FerftPTyx41uDzTMh8q8WNYTXIx5cpaK0frSQGxk10oKocA1ewcnxOotZ4eDtGzIj1YKiNm5nB2RgDLw7rD1x29Bzu9AakjU1goSAwOYo6kNOThB82nJJlX7CjXvWa/K8Rw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFRFU1UxWUlxWTNKbm9FL3JJZEUybDRUZWQvOWx6NmI2LzI2eGtyQk82NU9t?=
 =?utf-8?B?UmJNZW9PU0FiSU9OOVptWFZXMHpIQndsWXJDNy81UUNZOFpHVDlJVExLNGc5?=
 =?utf-8?B?dndBVTNNNWVtTm5hSlN2eXlRNEF0K0RYNmlvSE8xTHBQZExlcGNPSWNkNllw?=
 =?utf-8?B?ZzMrZ2V2ajd4M01HZGhPK091blZ1TTN2b1BCQXFyc2o1NnpqTzYxMnVtMEZO?=
 =?utf-8?B?bThWYVphV1dBK2d6T2J0Qjc0anhYRm5rNE5YeVRoQjlMbStNWlE4ckhBZ2RR?=
 =?utf-8?B?WnpwYnVPUklzZ3c0TU9mU2ZNMXBjczRCV0x6eFV1QW9FcHlSdnYyMjZTakxL?=
 =?utf-8?B?clNkQnBnZmI5N29hczl4bFg1QlRIZFBsRm5TK24vSi9XeTJxd0oxVDJHSmY1?=
 =?utf-8?B?R0FpaWFjTm5GU1k1NVZyL3A3R0FrRnRGR2NtcDZlM1dXNCtQdVJrYUxXZGpm?=
 =?utf-8?B?Vlk4QmliVmpnNWpWYklpSDFSS1ZrSTFDUkFLc2M5b1FaREhxUW5PYUVZTVNK?=
 =?utf-8?B?dTlRNHJrNW14ZUxJQjJYV1U1VWx3RWxBbEhFWW0zd3VLd1QwcXlMTDZJTlhS?=
 =?utf-8?B?cFF6eVhvcEUzRHJUUFEwajBpMTdSYy90OTk2VnJqS0x4ckdoZHkxazZmQXZS?=
 =?utf-8?B?TU1DY1dDd2ZaS1UvQnlmYXQ3aG5BRk9SYUd0a2tMejgvRmUyNmZiTVhoYk9Q?=
 =?utf-8?B?Q3JxKzRpQzFJME5ZdVhMaXh4NG40QytaUFlqT0liWEowd0w1Ym9FU2RCbnZJ?=
 =?utf-8?B?ZEMvY2RVSHIveWxWS2RUMVMrcXVxNXNoaG1UbXdoRGJVRjdRSHY3UkF3Zmxp?=
 =?utf-8?B?ZmVhR0dNaUkydExTZ3ozSktRaExGOExneGZNcmIzT29rSWZSM1lUSjZXUW9R?=
 =?utf-8?B?bTNNUGRad21TVkhyL2o0YUh1WThFWmdkMlg5OWZYL2MvNXNFTVpVc3RQcWZN?=
 =?utf-8?B?K1NER0g3STdyWU1obk5HSEFVYXFNaFpuTHV0ZzhJeWt0bncwZk1pN2U5Mm5K?=
 =?utf-8?B?RDgwaHlrSE5GTlRFUXEzRS95TVUxQVYzd1FGMEFra1RpalUyeGhJZDRlUFdK?=
 =?utf-8?B?QzBVSDlxR01zWnpZN2tQVkpRdkJLY1FqOU1FMGlnZ1l0TEhSeGRuc041MTY1?=
 =?utf-8?B?bHdjSkZ1Z3g2UEo5N2tQWDFSWHpkanM1amdiZXlaZXI3QVVYR1dDMitzd2JK?=
 =?utf-8?B?ZDVtR1E4YTd6U3FabU5EZG5KL0JWVnNKNVE0ck1sRTNoczMwSWFiZE8veGQ1?=
 =?utf-8?B?OXRKMzd5cnNKeEwrMVo2dE1JOFpFRVdFS05aODhqRWFxdU9pWU5aOFNkOWdY?=
 =?utf-8?B?akN1NzRleWhkSHBQeGcvdFUxZU90Wm02eEVpb1A2R1J5WmJUNWNCa283MjR4?=
 =?utf-8?B?UlpHMURyeUNXcG5qWm9CcWVabVl1ejdMMzRNa1RQNHh4bXhXNVRibDByNGdy?=
 =?utf-8?B?dnIwcmJkLzdPSFR0Y21SbjRlc0l1anpJcEZNVmVIRXAxYnI5di9wVzRLREdz?=
 =?utf-8?B?T1Ywc1Npb2xPYVRncDFYV0w2ekVrRTZ5NDVKQ3FlV0VuSUhBaStVZFdhcVRi?=
 =?utf-8?B?K1lwSkxiN3NwbnIyMFliY3J3Y05HVW0wMGVCMStWSGlwbUZoekYxbFc3TmlO?=
 =?utf-8?B?ZVdRdWkxMVZVcGdlRTNnOW5Wa3VSVUZpRFE4RUdMK005VFdaQVRwSTFvcGkv?=
 =?utf-8?B?dkRBSGhBaTE5bURUQzEyeGlQZ0FPVFFiM2ZLb0xndGgzRXlZdVJvRlJIZXU2?=
 =?utf-8?B?VVhReU9qb3k1NnpxTG52V2JwQWdDU3BEbEk1MTVHSUloOFNSRXA3LzVOeHc2?=
 =?utf-8?B?bG1hTGVQNE9GS3NlQTB3TlhnTFltVGtySTNnL3MwZDlGdERVZWJpa3hpVnl2?=
 =?utf-8?B?ak9hTFlXOUJscWd2c3B0bE9ON2tmYmEvbU9NQllaTFpXWitLZ3pZdWQ1UGlj?=
 =?utf-8?B?bTBnelZyNWF6d1l1a2dKSmQrcFpUcUd4QmtnbENpSHhYRnJnb2k0RWZ6MnB1?=
 =?utf-8?B?dzVXRkQ3WmxwRUZTaTEyeGJ2M0x0WGdmVGRxYm9sNEl0S2xudXBVcy9IL3Qr?=
 =?utf-8?B?ZEdPdFczQnJVWXN4SmlJWHZzeTJHRlZ1akhJUEdrRER0NUJsZWdWUjJvcy9Y?=
 =?utf-8?B?MzhtTXVUSlRKSENWWTYxV2k5L0ZReFBlNnAybGVuQ0NmK25EK3piR3hBayto?=
 =?utf-8?B?bWt2cHQ3THFhcFd6Nk1xQlk0eVB5aVQ2a3JXamZkY2hvZ0lONTc5TzZVSzJn?=
 =?utf-8?B?UE5KWWoyd04xU2RKK1dCRDhjV1V5TFJxR3hDU1NXU1NtTnpOazFzNkxxdHJP?=
 =?utf-8?B?d3VabzBtYjBPek5xYTV6QXY2WUtHNUpmK2RRNjlXazdmWC91WkRzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18C218C677AE384BB817CBFC6066D835@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe2df2a-edad-4261-afff-08df080cd2d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 09:38:47.9541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVxg5VQAU53dmJs+B3KcEuKAOwmYEMsEijNig7si98p/JG3o7qQa4/MhmRhFnCmsFrB0Y9/QZ9bQTCN+sm9tJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862

T24gVHVlLCAyMDI2LTA5LTAxIGF0IDA4OjM5ICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gLSBbTWVkaXVt
XSBTdGFjayBidWZmZXIgb3ZlcmZsb3cgaW4gdGVzdF9tYmluZCB3aGVuIHJldHJpZXZpbmcgbWVt
b3J5IHBvbGljeSBvbiAzMi1iaXQgYXJjaGl0ZWN0dXJlcy4NCj4gLS0NCj4gDQo+IGNvbW1pdCBj
MjlhNjM3NjA4ZThiM2VlMzcyNzg3MjhmZDk0MWI2MmRmMTg0YThiDQo+IEF1dGhvcjogU2hpdmFu
ayBHYXJnIDxzaGl2YW5rZ0BhbWQuY29tPg0KPiANCj4gS1ZNOiBzZWxmdGVzdHM6IHVzZSBhbGxv
d2VkIE5VTUEgbm9kZXMgaW4gZ3Vlc3RfbWVtZmRfdGVzdA0KPiANCj4gZ3Vlc3RfbWVtZmRfdGVz
dCBhc3N1bWVzIHRoYXQgbm9kZXMgMCBhbmQgMSBleGlzdCBhbmQgaGF2ZSBtZW1vcnkuIFNlbGVj
dA0KPiB0aGUgcmVxdWlyZWQgbm9kZXMgZnJvbSBNUE9MX0ZfTUVNU19BTExPV0VEIGluc3RlYWQu
IFRoZSBzeXNmcyBoZWxwZXJzIGZvcg0KPiBmaW5kaW5nIG1heG5vZGUgYXJlIG5vIGxvbmdlciBu
ZWVkZWQuDQo+IA0KPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0v
Z3Vlc3RfbWVtZmRfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2d1ZXN0X21l
bWZkX3Rlc3QuYw0KPiA+IGluZGV4IDIyMzNkODcxYTM4ZjQuLmFlZTgwZGRhNjIyOTUgMTAwNjQ0
DQo+ID4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2d1ZXN0X21lbWZkX3Rlc3Qu
Yw0KPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9ndWVzdF9tZW1mZF90ZXN0
LmMNCj4gWyAuLi4gXQ0KPiA+ICBzdGF0aWMgdm9pZCB0ZXN0X21iaW5kKGludCBmZCwgc2l6ZV90
IHRvdGFsX3NpemUpDQo+ID4gIHsNCj4gPiAtCWNvbnN0IHVuc2lnbmVkIGxvbmcgbm9kZW1hc2tf
MCA9IDE7IC8qIG5pZDogMCAqLw0KPiA+IC0JdW5zaWduZWQgbG9uZyBub2RlbWFzayA9IDA7DQo+
ID4gLQl1bnNpZ25lZCBsb25nIG1heG5vZGUgPSBCSVRTX1BFUl9UWVBFKG5vZGVtYXNrKTsNCj4g
PiArCXVuc2lnbmVkIGxvbmcgbm9kZW1hc2ssIGJpbmRfbm9kZW1hc2s7DQo+ID4gKwl1bnNpZ25l
ZCBsb25nIG1heG5vZGUgPSBCSVRTX1BFUl9UWVBFKG5vZGVtYXNrKSArIDE7DQo+IA0KPiBbU2V2
ZXJpdHk6IE1lZGl1bV0NCj4gQ2FuIHRoaXMgY2F1c2UgYSBzdGFjayBidWZmZXIgb3ZlcmZsb3cg
aW4gdGVzdF9tYmluZCgpIG9uIDMyLWJpdCBhcmNoaXRlY3R1cmVzPw0KPiANCj4gVGhlIG5vZGVt
YXNrIHZhcmlhYmxlIGlzIGRlY2xhcmVkIGFzIGEgc2luZ2xlIHVuc2lnbmVkIGxvbmcsIHdoaWNo
IGlzDQo+IDQgYnl0ZXMgb24gMzItYml0IGFyY2hpdGVjdHVyZXMuIEhvd2V2ZXIsIG1heG5vZGUg
aXMgc2V0IHRvDQo+IEJJVFNfUEVSX1RZUEUobm9kZW1hc2spICsgMSwgd2hpY2ggZXZhbHVhdGVz
IHRvIDMzLg0KPiANCj4gPiAgCWludCBwb2xpY3k7DQo+ID4gIAljaGFyICptZW07DQo+ID4gKwlp
bnQgbmlkOw0KPiA+ICAJaW50IHJldDsNCj4gPiAgDQo+ID4gLQlpZiAoIWlzX211bHRpX251bWFf
bm9kZV9zeXN0ZW0oKSkNCj4gPiArCWlmICghZ2V0X251bWFfbm9kZV9pZHMoJm5pZCwgMSkpDQo+
ID4gIAkJcmV0dXJuOw0KPiA+ICANCj4gPiArCWJpbmRfbm9kZW1hc2sgPSAxVUwgPDwgbmlkOw0K
PiA+ICAJbWVtID0ga3ZtX21tYXAodG90YWxfc2l6ZSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwg
TUFQX1NIQVJFRCwgZmQpOw0KPiA+ICANCj4gPiAgCS8qIFRlc3QgTVBPTF9JTlRFUkxFQVZFIHBv
bGljeSAqLw0KPiA+IC0Ja3ZtX21iaW5kKG1lbSwgcGFnZV9zaXplICogMiwgTVBPTF9JTlRFUkxF
QVZFLCAmbm9kZW1hc2tfMCwgbWF4bm9kZSwgMCk7DQo+ID4gKwlrdm1fbWJpbmQobWVtLCBwYWdl
X3NpemUgKiAyLCBNUE9MX0lOVEVSTEVBVkUsICZiaW5kX25vZGVtYXNrLCBtYXhub2RlLCAwKTsN
Cj4gPiAgCWt2bV9nZXRfbWVtcG9saWN5KCZwb2xpY3ksICZub2RlbWFzaywgbWF4bm9kZSwgbWVt
LCBNUE9MX0ZfQUREUik7DQo+IA0KPiBXaGVuIG1heG5vZGUgaXMgcGFzc2VkIHRvIGt2bV9nZXRf
bWVtcG9saWN5KCkgaGVyZSwgdGhlIGtlcm5lbCBtdXN0DQo+IHdyaXRlIGF0IGxlYXN0IDUgYnl0
ZXMgdG8gcmV0dXJuIDMzIGJpdHMgb2Ygbm9kZSBzdGF0dXMuIFRoaXMgcm91bmRzIHVwIHRvDQo+
IDggYnl0ZXMgKHR3byAzMi1iaXQgd29yZHMpLg0KPiANCj4gV2lsbCB0aGlzIG92ZXJ3cml0ZSB0
aGUgNC1ieXRlIG5vZGVtYXNrIGJ1ZmZlciBhbmQgY29ycnVwdCBhZGphY2VudA0KPiB2YXJpYWJs
ZXMgb24gdGhlIHN0YWNrPw0KPiANCg0KVGhhbmtzIHNhc2hpa28gZm9yIHJlcG9ydC4gVGhpcyBs
b29rcyBsaWtlIGZhbHNlLXBvc2l0aXZlLg0KMzItYml0IEtWTSBzZWxmdGVzdCBhcmUgbm90IHN1
cHBvcnRlZC4gSW4ga3ZtX3V0aWwuaCwgbm8gVk1fTU9ERV9ERUZBVUxUDQpleGlzdCBmb3IgMzIt
Yml0IGFyY2guDQoNClRoYW5rcywNClNoaXZhbmsNCg==
