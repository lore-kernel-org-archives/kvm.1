Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03030E84B;
	Thu, 14 May 2026 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778782652; cv=fail; b=IeTvhUXYIMK160IJV71jk6uL1gC3gFIiWurfg3KlkaVJlMRK5fXpmr2fGO3hk9cDiF/nIKBxK1u/YvJcwQX6b2+6phbRASAUDLdv7JCaNF73oG0859XThDyuuR3h5H3jfWCNCsRWAi6FtDgxmR7JbMPQ7VlI4lQsjvPqTloRMH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778782652; c=relaxed/simple;
	bh=fVYdIZy0abIJY9IYT6H+9ovbbJBkuu5GqjBT2rbvfz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EOJxpnXvtBrbhfuSrbYrCYoTR+HISZmB6yHI6rqggcuDzkdFwik/DWXAuwPud3as6EsUZXlgSvfyKtmQgi5DAoa/Ex0JMK3fktpbyMQwybmsNa7glJoJSLQsNXmF7CJKh3YIv8ezQopVkj7gS/qIlGaSd0DgxPNt7K7h45mNg44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q5Uzpz2Z; arc=fail smtp.client-ip=40.93.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q5Uzpz2Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVIiRdqWFl8ePGkJF6V9O05qYqvuRbjEC7jAUlPrjqjIZu57/T/h5xLMUhhm7DHFgxrm6THb1GoKgDrf+QS6JQhFLCtba2XGF8aN/kbAcOqJZQwyDu/VIfgz4z5h8NWncpu2WrRdC2RJR5s1MyXJlR+MyMOOPrjKESfhKWWDa3M1pWVq9fphRPL0SrdPfxnR97xtC00BWeI0o10o3n0qJvqLn0Gjjks6pwjniyzpdesm9piU4HngnhLC/nlQaxM1COXGthEpZhGsZxoDHCeSC7r9+adBMWiKfv+NSlcb9FRJvOerexXs8r0P3+RY4MMxCva11kCJZqfIt+QJVMRFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVYdIZy0abIJY9IYT6H+9ovbbJBkuu5GqjBT2rbvfz4=;
 b=ioPvECrOz5GPfOQMrUJzv6q6l+Ok9VmMsrbTKbgUJizWvMfgwP8M35wPet3Ducb2kTIIsGkB8hF8sG5H5wiKIsDx1+VJTCh4tLuk12OOO8XN5Olp6twfjz9GkUxPVG3oLJuQG6/1+Yvdo2+NB+3H0QMZIg7al7VYOwomgKf9VP5CKKsFv3pwzktmc4cfMysVhq8GSMSCbOb9e2QLFgygp9/62unNK0YC/MkhaU/NrKB+7dwnOWE7Ibsd5JMMLHUbyC3r+VFbtrYF/0oR6qhPNvrkPF3VcssgFzr/PEgaAW5YUsTArJBIpfxSMMo5Hk7be7cmEQiGSIYjkNx9vzeBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVYdIZy0abIJY9IYT6H+9ovbbJBkuu5GqjBT2rbvfz4=;
 b=q5Uzpz2ZPtOqESp/AAc53q7Eg1jGcvRJESTaUZ/rqdZtoKhYFZMfWayLpdBxhRLCyRgrpnEKwJ7e+Mg3ZJCszBSu3k0eF3e3G0k3SPk1BKDpt1Hhnud+i1IcZAqVrQHUhVN5IzMPPEZdI2QrjVsXDiNj6R4+aNbF1aA3dduaQ4s=
Received: from DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) by
 SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Thu, 14 May 2026 18:17:26 +0000
Received: from DS7PR12MB8201.namprd12.prod.outlook.com
 ([fe80::e5d:5f41:954d:be38]) by DS7PR12MB8201.namprd12.prod.outlook.com
 ([fe80::e5d:5f41:954d:be38%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 18:17:26 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ctpence@google.com" <ctpence@google.com>
Subject: RE: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
Thread-Topic: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
Thread-Index: AQHc48u/ypunHfXv0E2Ct1Pgh072/rYN03IA
Date: Thu, 14 May 2026 18:17:25 +0000
Message-ID:
 <DS7PR12MB82016B1B310BD994C83B35D294072@DS7PR12MB8201.namprd12.prod.outlook.com>
References: <20260513224608.1859737-1-jmattson@google.com>
 <20260513224608.1859737-4-jmattson@google.com>
 <CALMp9eS4s9tsOmvDUDeqS7oph0mSHyhxBiULQdwHVaG+7gXLSQ@mail.gmail.com>
 <agXcKDjnJc9DPcyr@google.com>
 <CALMp9eS831M153QmAgjzJcR2dFY_wCCCzDisd7_T6GyS3-gAFw@mail.gmail.com>
 <agX2SJF3rJSkIqDe@google.com>
 <CALMp9eQTSxFkVf4vV83yNYvv2AjseHYiD3M68mcc951L4U1Jxw@mail.gmail.com>
 <agX5v1utAfyMadPm@google.com>
 <CALMp9eQqbHrcV1_WM+5xUR16OpGk+unxoZGi+=t55cqVhFgAfQ@mail.gmail.com>
In-Reply-To:
 <CALMp9eQqbHrcV1_WM+5xUR16OpGk+unxoZGi+=t55cqVhFgAfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-14T18:14:35.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8201:EE_|SN7PR12MB8434:EE_
x-ms-office365-filtering-correlation-id: a20ddb5f-e42a-4d32-a6d2-08deb1e50d35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|18002099003|22082099003|56012099003|3023799003|11063799003|4143699003;
x-microsoft-antispam-message-info:
 n3OrigqJ46Y+BUrrJhCFvxhzikgezCBe4uwumPztjhoM8zfrYzYsG5hBk3Ifef2vpKdYZP+mGtk+F04vh0iAWmcrINx1QD5U4qfVHYc6PCr2GgQgFXJI2ck8guLgQ8c5rvMJ7PyqwhpFtsCyZ7XFgvHwdlvJrZCFPO9orOTKqflse6sa5McwryKO1f6gm48dGZjNsRWy9ezafzMv40K6N6N1YknH+YHOoKeoslN+PEw+3GHoyHAx4UXuvcTL26WUHvcdVzfraa/c7ylQxGN2igQAuug6T5M/d/s5D2UcQb1eRJ0f4tkFtsMb8ljdVoNs3rTI8jX9BrU2EufPgHhsVMsGCbnpJQP7TwjQP92AUYZE4QcvU59kAooY/El5W4ic+omObvX9lVbOeapp3k4c/BGN/9iV67Hn3JWBR8GoKFcHpFo3wsXD9o3U0QNpa1b5QKg7nDPKwjnMhJTPnZwBaQIdpB+1ch/jByewE0SHZYsMfjO5MmD0ybkMvHRp8TQCSP8qC0XsmOgnGXN9AeMtH4klkQpejpGgvyqKVajRq3bnRR0EY+g+hPCRTxGtgW9JkC1Tz87Svce0wAt9TLyz9R4EzowmQyNGC1VxsAb+F+aSIjKjNgcogyWV4PT3LqWEvv0/CsE3/cRjz3QR2l92uwAmwF0nagQlXSGBm23hfBffzgW2epZkJ6GJSFhjmOscMdsUGwTmR/P0FkZAObt1GfpDZ07mXnfr6EW3ee7c0fyQTR0Q0NPC0NFWuMG4PTkG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDRacFl4MzZpSHYyWFg1YWhwN25VbUJQNEcwaGo4SlBwNk5PUnpPc2YvaWVK?=
 =?utf-8?B?U09GdTF4RzV5ZDRCcm9xeXdGZ3BhOVVkaEJ5TlNQSGpPMWZ6M2haVFNrQnRB?=
 =?utf-8?B?eFlzKzB6dHJYYzVRTFV6NGhFTGNFaEQ2L1FMSGd6ZzNTU21OMUJlcGRzMWhq?=
 =?utf-8?B?K2s5Q21mT0c4c3doSFBPQXIyb0VEVmxCUG9rV2VPQUY5YzI2SEp4dnBmd3hp?=
 =?utf-8?B?VDExbmhxZFlVanlybCtJY3dMcURuUWRQU2psT3p3RGJzbS81RklhQUJXWTZ2?=
 =?utf-8?B?V0VZWGlWVkpiRW4zblJBaGdpc0dYeVB2Z1B6RVJudzNtUDQrUk9qZE9USnU4?=
 =?utf-8?B?SGVvRFArcFllQzdJeGE1SWtvamh4T0RnZHZsdVVRc3QySVZuU01HUlQ3OHBx?=
 =?utf-8?B?WHR6eWZaWjdHSXYwOHR3Q3lvNEREc001R3B6cXc3dXR1c284VllPai9kZHp1?=
 =?utf-8?B?VFMyUmxOMEY5eHYrOXNYcW9JcFFnbUVBaG44MjIyd1YybHcrc0NPVlJsQ0Jo?=
 =?utf-8?B?MEVKZEpnUTBHMlFkMml2Rk1GbWlwNzhYMzk5bTJpWThlcUNIcEw4VGpXT3M5?=
 =?utf-8?B?U0RpK0ZpMjFFVGxCNDNrWXF3Qlg0dmtHNjF5MzJKR1M1RmxZRWFhbjFBSWg4?=
 =?utf-8?B?V2MwY0xFTm9neHAvRTM3QytNYk1XZTd4bGU3V0VmT0pLNmZaT2s4SUFCVVA2?=
 =?utf-8?B?MHBjLzlBcW9wdXAxdWUvcGJwYlEwdExrSmJaL201NzF1VE4vQUkrd1lnSUhk?=
 =?utf-8?B?aFF0NjRhMzUyRm1YMGMyZU5RbjRnK0JKWFh5a2R6ZisyTXlJaG0xeStBb25Z?=
 =?utf-8?B?ekRKNXJhRFY3Y0w4OVRNUjBhU0c1bG05NUpTaDkweW0ycDdPRTlKTFVUUnlM?=
 =?utf-8?B?YnJ2T0pBbHVrZzlNVE1EYXVvYTlCVGR1K01HWHpJTVpWbVEzNHczbHdJMkFl?=
 =?utf-8?B?R1JJOURHblV6b1kzODFsRnZaQko4RUN5THJnakNudUpWT2RDYWRxT1FpTGxV?=
 =?utf-8?B?Qm9DY1doVk5TV0EycitoZW96TE9XTFF3U0NkeFU2d3NEUmJ3OEpyNXFDUDFo?=
 =?utf-8?B?dlJwTCtOTDRSa2Zqc1pPbDI0MjI3Rm95T1B2UmlySm9lNmNCR3UzSnlpa09t?=
 =?utf-8?B?em83RFJBSXY0cTIxSngvR0xTVEJhSFFUY2ZpaGpWbjdNOHhqbHk3MGc5OHlB?=
 =?utf-8?B?akVmeUhMcGRoWHZjTi9tczJUVElwZ2RzYklFTkJVS2l5YjF6a0xvUE41cTdz?=
 =?utf-8?B?RzBwT09KOHN1ZStYMk80OVRJcFVib2l3dXpBZ2ovN0hnUTRkL1Y5OHpHLzdF?=
 =?utf-8?B?dVlGRmtmMU1jTWJuV09DcXhJUkRzQzI5MVNXS3FLZ1VSeE5PWkliaXhxenFV?=
 =?utf-8?B?REttVzhrVFlGelROcmtaWTZEMmpuTndZTlJqOExJWEpqZ3BYVDdlMmNqZEFM?=
 =?utf-8?B?eWJOajFqV3ZoKzRqY1RWUzF1M0ZrODg4T0lwdjNlcWpSRDVCRk1mV1NpQmVs?=
 =?utf-8?B?Y3U1RzNaMk9wQ2I0K1Q1V2F3d0VacXd4Umo1cWVKdXM0d3VaYk1mRTFuaUhS?=
 =?utf-8?B?aXdHTkVMQkhIbWRWZ2I1aUQ0V0QyL0hhNXpxb1BCSEF0Mmtmdm5pa2g3Sm9L?=
 =?utf-8?B?RkNSNGx0NlBWNVlVTyt6dUkzRWxsT3ZVMW93QWdWeXo1ZmV5SC9GNmJPYWZ5?=
 =?utf-8?B?TjhaK3p2dkpVLytIa2lVOG02VXhRcW9GdU5oSjVFRGUrdkVBbEhkdmgyNy9r?=
 =?utf-8?B?ZnFaYnpTUGM0MFBtd2dlVWdMc0h3S3lNaFZCQjRxcXJZTE1UVlhBY01PRDRC?=
 =?utf-8?B?Y0VQWk9PNllvK0xaMFFaZnlxSkc4N2hpaURCMHRQS0J4YmtqeU0wcEpiWkRx?=
 =?utf-8?B?RGRuUTdlcmhibkRZdFhOOGJuS1RFRmRVcjJKNTRTaysrYm0xNi9YOGtsREl3?=
 =?utf-8?B?aDkvSjJMODhWVENFb1A4d2xJaUdhdWxLWXBDUjJVejlWMlZRbmdwemVROVk1?=
 =?utf-8?B?VlJVcEg3enFFNzNxNnNHLzFwWGtkSmovWTQxNTUwdUtqeExaOGx3clhsRHBK?=
 =?utf-8?B?V1U2a1hoOGpZUWpXZFBWQ05QRG9QbUdSSHE4cEIvK0pzWDdRczJyR3dock00?=
 =?utf-8?B?ZFlRVkRQSmhUNHZETUdqNGtEK0VuN1AxSmJyWC8vZXExaFhEZytCQWxlK0dZ?=
 =?utf-8?B?MktrSzQ3T05yUnV4QjBTejR3aGt3L3BsYlEwRGZUVThqVys1ZDh2bkFhN2xM?=
 =?utf-8?B?SDhmYkRrUzVkb0VaMHlUdjYxamhZc3d0TThObVlTTkhrc013MFMyZ0hYdXRv?=
 =?utf-8?Q?0OIfuLqtGhnOmS5HQS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20ddb5f-e42a-4d32-a6d2-08deb1e50d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 18:17:26.0371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/2RNxjJBDNe+AkyAFbm0whadL9mvK468OyKtt9KLEeL9Tgwo/RighhEAc9ZOVwZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaW0g
TWF0dHNvbiA8am1hdHRzb25AZ29vZ2xlLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1heSAxNCwg
MjAyNiAxOjAyIFBNDQo+IFRvOiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNv
bT47IEthcGxhbiwgRGF2aWQNCj4gPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBDYzogcGJvbnpp
bmlAcmVkaGF0LmNvbTsgdGdseEBrZXJuZWwub3JnOyBtaW5nb0ByZWRoYXQuY29tOw0KPiBicEBh
bGllbjguZGU7IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmc7DQo+
IGhwYUB6eXRvci5jb207IHNodWFoQGtlcm5lbC5vcmc7IGt2bUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJu
ZWwub3JnOyBjdHBlbmNlQGdvb2dsZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzRd
IEtWTTogeDg2OiBWaXJ0dWFsaXplIEFNRCBDUFVJRCBmYXVsdGluZw0KPg0KPiBDYXV0aW9uOiBU
aGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Bl
ciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9y
IHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFRodSwgTWF5IDE0LCAyMDI2IGF0IDk6MzXigK9BTSBT
ZWFuIENocmlzdG9waGVyc29uDQo+IDxzZWFuamNAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBPbiBUaHUsIE1heSAxNCwgMjAyNiwgSmltIE1hdHRzb24gd3JvdGU6DQo+ID4gPiBPbiBUaHUs
IE1heSAxNCwgMjAyNiBhdCA5OjIw4oCvQU0gU2VhbiBDaHJpc3RvcGhlcnNvbg0KPiA8c2Vhbmpj
QGdvb2dsZS5jb20+IHdyb3RlOg0KPiA+ID4gPiBPb29oLCB0aGlzIGlzIGJhc2VkIG9uIHRoZSBn
ZW5lcmljIENQTCBydWxlcy4gIEkgZGlkbid0IHRoaW5rIGFib3V0IGl0IGZyb20NCj4gdGhhdA0K
PiA+ID4gPiBwZXJzcGVjdGl2ZS4gIFNvIHllYWgsIGFkZHJlc3NpbmcgdGhhdCBkb2VzIG1ha2Ug
c2Vuc2UuICBXaGF0IGEgcGFpbi4NCj4gPiA+DQo+ID4gPiBXaGVuIEkgZml4IHRoaXMgaW4gdmVy
c2lvbiA0LCB3aGF0J3MgdGhlIGNvcnJlY3QgZm9vdGVyIGZvciBTYXNoaWtvDQo+IGF0dHJpYnV0
aW9uOg0KPiA+ID4NCj4gPiA+IEFzc2lzdGVkLWJ5OiBTYXNoaWtvOmdlbWluaS9nZW1pbmktMy4x
LXByby1wcmV2aWV3DQo+ID4gPg0KPiA+ID4gb3INCj4gPiA+DQo+ID4gPiBSZXBvcnRlZC1ieTog
U2FzaGlrbzpnZW1pbmkvZ2VtaW5pLTMuMS1wcm8tcHJldmlldw0KPiA+DQo+ID4gVGhpcywgb3Ig
ZXZlbiBqdXN0Og0KPiA+DQo+ID4gICBSZXBvcnRlZC1ieTogU2FzaGlrbw0KPiA+DQo+ID4gaXMg
Z29vZCBlbm91Z2ggZm9yIG1lLiAgSSBkb24ndCBleHBlY3QgcmFuZG9tIGRldmVsb3BlcnMgdG8g
a25vdyBvciBjYXJlDQo+IHdoYXQNCj4gPiBtb2RlbCB3YXMgdXNlZCwgYXQgbGVhc3Qgbm90IHdo
ZW4gaXQgY29tZXMgdG8gcmVwb3J0aW5nIGJ1Z3MuICBJZiB5b3UgdXNlIEFJDQo+IHRvDQo+ID4g
aGVscCB3cml0ZSB0aGUgY29kZSwgdGhlbiBtYXliZSBJJ2QgY2FyZT8NCj4NCj4gSSBoYWQgSmV0
c2tpIHdyaXRlIGFuIGVtcGlyaWNhbCB0ZXN0IHRvIHNlZSBob3cgdGhlIGhhcmR3YXJlIGJlaGF2
ZXMuDQo+IE9uIHRoZSBmaXJzdCB1c2Vyc3BhY2UgQ1BVSUQgVk0tZXhpdCwgdGVtcG9yYXJpbHkg
c2V0ICNHUCBvbiB1c2Vyc3BhY2UNCj4gQ1BVSUQgcGVyIHRoZSBhcHByb3ByaWF0ZSB2ZW5kb3In
cyBtZWNoYW5pc20sIG1ha2Ugc3VyZSB0aGF0IHdlDQo+IGludGVyY2VwdCAjR1AsIGFuZCByZS1l
bnRlciB0aGUgZ3Vlc3Qgd2l0aG91dCBhZHZhbmNpbmcgUklQLiBUaGVuLCBzZWUNCj4gd2hhdCB0
aGUgbmV4dCBWTS1leGl0IGlzLg0KPg0KPiBTdXJwcmlzZSENCj4NCj4ga3ZtX2ludGVsOiBLVk06
IEVNUElSSUNBTCBURVNUIFJFU1VMVDogI0dQIHRvb2sgcHJlY2VkZW5jZSBvdmVyIENQVUlEDQo+
IFZNLWV4aXQNCj4ga3ZtX2FtZDogS1ZNOiBFTVBJUklDQUwgVEVTVCBSRVNVTFQgKFNWTSk6IENQ
VUlEIFZNLWV4aXQgdG9vaw0KPiBwcmVjZWRlbmNlIG92ZXIgI0dQIQ0KPg0KPiBMT0whDQo+DQo+
IERhdmlkOiBJcyB0aGlzIGludGVudGlvbmFsIG9yIGEgYnVnPw0KDQpUaGlzIGFwcGVhcnMgdG8g
YmUgYSBidWcsIGFzIG1vc3Qgb3RoZXIgaW5zdHJ1Y3Rpb25zIChlLmcuIElOVlBDSUQpIHRoYXQg
aGF2ZSBDUEwgY2hlY2tzIGRvIHRoZSBDUEwgY2hlY2tzIGJlZm9yZSB0aGUgVk1FWElUIGNoZWNr
cy4gIEknbSBmb2xsb3dpbmcgdXAgb24gdGhpcyBpbnRlcm5hbGx5Li4uDQoNClRoYW5rcyBmb3Ig
YnJpbmdpbmcgdGhpcyB0byBvdXIgYXR0ZW50aW9uDQotLURhdmlkIEthcGxhbg0K
