Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8B1940B0;
	Tue, 26 May 2026 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831027; cv=fail; b=qPHRsSMBtQjaCd6EBgsdwM89kGMEm3OtfpO0p/vbWFKWEs8NcdLJnBuwy5gcab+1cJWKouBkPJnkOm+b9gb17TYVNAXug7NmpifEzmKcIPgAGSz5huLOIQQsLPIo7Nx9v2SQIHK5RbeDcJWNW2lvXdSPv9FGb4Gn2YXvK2sWbVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831027; c=relaxed/simple;
	bh=xEHmp8qB4NSZlylj1hKSAWcRsHYFLHK3fGv0IdHkYTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eoxRc98U/V85DlR0Uwoc82E1bkH+jDqkqRNAE/Pg77m3oJiabDBbS6Te1i6eXhLfKp0y3j4lNekZ3AuHS4v9AuS5pKM5ubbOfMaUJYc1vCpwCr0TnMrs7pDUb/1lB+iCO3IaShISaqRpj498d01fyMtaEtyHNLGv3NWahhmlW1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BMEBPfcg; arc=fail smtp.client-ip=40.107.209.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BMEBPfcg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKdCm5EW6VYvxQBf8G1mSYbXt/ooWfGW4TIpvrhDIYeB47VRZXzb9YYaWFI4anxEF1YNS21xL81Lbfgl99ERVQfXlPdm3jD5kNOJXHQ83uWW/FWu0V7kO7VRp4NDD1T31rekrWEQqC1DbITQIz9EMLNAvdp5SCtGBXBetU0NPKT41caaCySfh/cZf1iheUT+hNekogstrNPK6wrp762J/tqtrhem6LwWi9cI5CicAOYbmA3ykwEuvle+8Uny1/HwO1F2Qc+b6ECVe3idQtMP51lLFDsJXUPydXq/eiG4fK2MEXFCSDXhBfdmbS9fDV3JlPkEoh+2T3og7FXpDcCjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEHmp8qB4NSZlylj1hKSAWcRsHYFLHK3fGv0IdHkYTU=;
 b=R0xd8EUawnnZW43S7TeRMt201Zut+IkqMrrw46reHIQUYCzPgtul4bWeI7k03IWNV6E8UuBgGNL3J7VCPkKCY9L1D4ulHH+XUZkJjYXfiKT1Fv7KNH9Yit3uM8PNbv0LWhR+QfCang/ll7oa4ixt7Ezou4shAKtCeveLeJtb4AzpyexDf5I6CAwTeG+AZ4v+/lMLX+H1XhtPyyEKZPOQFCZFiwIMdAafP9I1gwRLieUozXbx4brc/JBxHOzxhAkjvxB9Q2BjvYkar1RpgiY4G8kuyL6v0tZmCERQ7xQdLHITm3z2Q5Av5kL1EIpDi+kbunimLc6DaMvgmjRG5UpoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEHmp8qB4NSZlylj1hKSAWcRsHYFLHK3fGv0IdHkYTU=;
 b=BMEBPfcgs9sz9v6F0tUegjq/DdFiQ1Q4PnBXkWLNq3rRyEwLiosrpqF/IoBKzRzIwtX3O0w/f4n6J8F/qCZa4HGrjdNdj2zz/VWWljWcPGl/eDc0nLgegEsgyo6RNPwQ9yd06OxoLveTKBYUm+eNeWcIgA5D1C7gHzUgKNqFqc8=
Received: from DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) by
 DS4PR12MB9586.namprd12.prod.outlook.com (2603:10b6:8:27e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.18; Tue, 26 May 2026 21:30:23 +0000
Received: from DS7PR12MB8201.namprd12.prod.outlook.com
 ([fe80::e5d:5f41:954d:be38]) by DS7PR12MB8201.namprd12.prod.outlook.com
 ([fe80::e5d:5f41:954d:be38%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 21:30:23 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Jim Mattson <jmattson@google.com>
CC: Sean Christopherson <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ctpence@google.com" <ctpence@google.com>
Subject: RE: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
Thread-Topic: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
Thread-Index: AQHc48u/ypunHfXv0E2Ct1Pgh072/rYN03IAgBLixwCAAC4RIA==
Date: Tue, 26 May 2026 21:30:22 +0000
Message-ID:
 <DS7PR12MB82011943131DF5415365E19E940B2@DS7PR12MB8201.namprd12.prod.outlook.com>
References: <20260513224608.1859737-1-jmattson@google.com>
 <20260513224608.1859737-4-jmattson@google.com>
 <CALMp9eS4s9tsOmvDUDeqS7oph0mSHyhxBiULQdwHVaG+7gXLSQ@mail.gmail.com>
 <agXcKDjnJc9DPcyr@google.com>
 <CALMp9eS831M153QmAgjzJcR2dFY_wCCCzDisd7_T6GyS3-gAFw@mail.gmail.com>
 <agX2SJF3rJSkIqDe@google.com>
 <CALMp9eQTSxFkVf4vV83yNYvv2AjseHYiD3M68mcc951L4U1Jxw@mail.gmail.com>
 <agX5v1utAfyMadPm@google.com>
 <CALMp9eQqbHrcV1_WM+5xUR16OpGk+unxoZGi+=t55cqVhFgAfQ@mail.gmail.com>
 <DS7PR12MB82016B1B310BD994C83B35D294072@DS7PR12MB8201.namprd12.prod.outlook.com>
 <CALMp9eQ2SLq2bVngJ1RHEfkFe5yaTDrFxXT0KNTgBZY6WRMDbw@mail.gmail.com>
In-Reply-To:
 <CALMp9eQ2SLq2bVngJ1RHEfkFe5yaTDrFxXT0KNTgBZY6WRMDbw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-26T21:23:48.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8201:EE_|DS4PR12MB9586:EE_
x-ms-office365-filtering-correlation-id: bc8da0e3-27a4-4372-5ee8-08debb6dfe8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|4143699003|11063799006|22082099003|18002099003|3023799007|56012099006;
x-microsoft-antispam-message-info:
 tAIIQXqAwO/+Fo+0zRC45d/YHg6TS+Lfb1l68ucjv3YlzdUwcmYYolt8jXKNSr8DGbDZLFBM4sT0hN1aHLk8lDW5KuPr+IKM2g6JA5dxudn0S1XDc3cQHYlVak6SCgYd+etlIro6VAUNmCeehBzQwTiw+oydJGngFxlsrWs+DlpYy9vUhgYDLwtoLIvtkCiy9Y2C5yZr6XNJG8PST28kVzj6TmiZEALq/FKqj9QCyQcXMWc551433LZXESzFtBl5rFyHRgkfcyestWKIYNSmGJxkSj06yflJJsG85PSzLZwHHDiySX6HpXHmIZwj9eToztGk8hAYOYY7+oh69Fe3Cw71NJwseBdSEbm+ZtNZApIpmLpgPUTu9v+KhABGqgVkXdbOe3vS5rcmndIcZcWuMC5duUF8Du5Ty4Iob1f27TJfDqL57j2/qTFxh7Ml7m9d/ynXAODU7dbWQXlAhywINmJHsx6Kp6p/+ysFyEi0iXTdjLmez9iqlojMpQMKEAC1WQ6PejWxCtueeByEF8Y7Lyv78ssmDB5JPr9ujNR7gVfktVs8b7ZZrdQwZcxqEz55tbEpEllryuMWzBklAgeEifpAee1eD5pd+xIaHCTj6AouNNecOyS0IRcZx9tVp1/DuebRoRq+XGS/CzIyid2e3X2d+yV1mJKvc+YJALAYseOV6zfEJxvdnpMIxLoY/1XCs56IVSykcR55E2PgN4/ylBO1SXIFd8oShLEF9zo8F+evmJ3wwrnlXeENYNXUotjk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(4143699003)(11063799006)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0Q4S25URkJTRTIvaXEzWS9TeVY0SERxekhHeDM5ZzZyY3NoZDBVM3czWHE3?=
 =?utf-8?B?OHFERjNKbGNMOEhQVG5QcExuYnVFSjZHTXFSSGRPRHd1dlhpRjM1aWZKNkdS?=
 =?utf-8?B?aTdYTlhyS1ptSXRzVk5qNUQ5aGU1engzdkhZT3I5MUZlNlByY3FxWTl5NHV5?=
 =?utf-8?B?RTVrc29PWThuYjQyOEtyZFRxOWVLbE9GcThSY1Q5cU1hNGxacU9nNlRFRXJG?=
 =?utf-8?B?c1dsN2dCbUJUTmJmZ0ZLbGZjRHlzZ3hGRThJaVVJbkFvbitXZVhlellZNFBX?=
 =?utf-8?B?ZTRnVy93Rmx6WllxQ0JMUGxrYlZSWnlXTjQ2cldoUHpRbWxUMExyS255NU5l?=
 =?utf-8?B?cEt3VkVoWTBCMGJaK05BYVZucCt1UHhZNDNPUEVGTGlac3pHK2k4MTk2a0No?=
 =?utf-8?B?TjdUZjFOOXQ2WXcyUXpscDhoalNBUmxOT1dVc1Z6VmNJemRHdHg2WXg0WWEw?=
 =?utf-8?B?dFVDb3JvbUJXNWtVQ2UyUkVGc1lpSENKRzZkcWJOWUo3YjBpdXZEbXlXR1R5?=
 =?utf-8?B?RFBQdDliRXNCWnhnQmJ1Qk5HL3JaNEMvUjNMNDdoQmZmQmU3dm1SY0FTQURT?=
 =?utf-8?B?QjhjVkswM2VuMU5pMkdPK1BJTlAwemZpZlhJcmt0cHpGY0dVamU5eHN5R3pR?=
 =?utf-8?B?UDZIRVZwNWdiSlNJYks3a2pMV3ZnRnh6aVNnV3NONXh3U1ZBdExORSthZDJU?=
 =?utf-8?B?N2hFTHhKaEgzVUxxelpWSmEzdGwvZ3BKWU80dVRyMzhSaDJicXhpREovT1h4?=
 =?utf-8?B?Q0lwNEtuV2VPVlNwaW4yRUFycGFsQ1hreEpHL3R6RlA5UUM4bjNNVy9vVkRa?=
 =?utf-8?B?U2tseFdMaElZcWdxemdaaDlBUWZOcG1SdmR4QUJzSHhCRk9zWmJSdkoweUJt?=
 =?utf-8?B?K2grN0pTM3QrRkllcFBhWFE4RllHNjNXdUFER0VWeHN0L0NLUW9kRTB5azlw?=
 =?utf-8?B?bjh1cStpdUNiVWIxZ1FFSFI3SjhtbGlPWnQzallOZWk1bmtPbG9Uejg0UFBJ?=
 =?utf-8?B?cnEwTy80cy9QNlhmVkRXQ25DRFRJRUU3cDA5QndMalBXU2phckxvSmpyK2Np?=
 =?utf-8?B?MHl6Y3o5M0x6N1FjNDl2Q2FZelgvenhEWUFZazZCMWVuOWpPOFJZSWVlTllJ?=
 =?utf-8?B?cWlEcE1qTjdleU10b0lmQUc2UG5OaG9JaC9EcDBPckNITDI4Sjcrb011WmlF?=
 =?utf-8?B?YVBPOXAxYW9RcmxYT1hkQ2NHeWx6TlRxbVVmZW1Sc2hoaXpxWjhsM2V6QlJ6?=
 =?utf-8?B?QnlhVzB1ckRDN1Y4VGdxcGlZaGZsV1hWV3RQYVdUN2V6cjBXTTh0cXJteDFp?=
 =?utf-8?B?a0RReTc5WUpTVEtHWnd6NW1UZE0zMDgraURqS3lid0pIckUzYzlyYU1IdXBn?=
 =?utf-8?B?disyZUtHRlRWcEl4Vis3VG9WNDRmakdscEsyVlE2T1NQL2NDYkI0RWljZVRs?=
 =?utf-8?B?VVRSb0NqUmhjQVppZnVDMGtiQTlPYm9KVDdZaG9oMit4dkJHTGlMdUhFZXpH?=
 =?utf-8?B?TGdJQlpMTk9rYmM0KzAyMldqWmNJSDlFS1NtUVdzM3JyNVc2RHRqWVFMempW?=
 =?utf-8?B?Z2xKZU8rQ0d6L0FrR1Y5R0hodVJzT3pSL0xRRzFaYUJFaEs2bjg1T2NwMHZN?=
 =?utf-8?B?OThkREZxSTdCRm9OYTIybys2YWNmNFA4Y0lJeVBwZUxtYUVzYlJESlZENUpu?=
 =?utf-8?B?dlNDK1NFTDV4M3A3aVY1VkxIclhiSGx6Y2hiTTIyT0lvZnpJNjY4eng1QnhJ?=
 =?utf-8?B?d2J1V0NkcW95U1JuTW5nVGR5UjdRelpFeng3YUJ1eU9CK01MT2w1bGlnL1Va?=
 =?utf-8?B?N1d1RUtwdCtZRGFLMU9JTXdPZ2hzeVk4Z3ZpZFJtV1pNbG1YZ3ZrRTNEVFdP?=
 =?utf-8?B?VEpOYml5aDR0ZjZrdS9EakpRaU10RGF1aERBRGFDdFd5WFZnY0FyRjh0UkdS?=
 =?utf-8?B?ajJTdHUrbEVvb2VrMHBValorU1dtVSs4Z0NoN09TSUdpZWcvY3dBR1FCMjEv?=
 =?utf-8?B?eXFYV0V4cGNzL2hlTzVHRlk5b3FsWFRoRkJPOGlOOVVQWGVmaVpUTUc3azN3?=
 =?utf-8?B?ZmxhdXNXOVFxZXJ3MmtlMUx6eFV1UDl5a25IYk5ZYWpGZkFGWDF6RnZPdGpl?=
 =?utf-8?B?Q2MxSGN2VURBWkppZ1ltYlFDbzhNZUFUamUzaHNEaVZEUUlNZlVoS1RPR1BG?=
 =?utf-8?B?M3RNZldVZlFtTzBGejNxbzZWZExwNUsrZ0F5V2RiWlU5V1Z2enM0RGYyV2JV?=
 =?utf-8?B?WmkrUWNDRzRJRGxtZVFBNkRheXhEYmsxRmJWbnFNanRCcVVFMFdLVVI2aWw0?=
 =?utf-8?Q?ohZ7tPUKQMRz+t2s7e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8da0e3-27a4-4372-5ee8-08debb6dfe8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 21:30:22.8440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRt108kSlQnr0LPAA2JIAywFvKD9Bm+fB6n2Z4Xs/jvtDW3zOJ1ki1cNkGZz4dPO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9586

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaW0g
TWF0dHNvbiA8am1hdHRzb25AZ29vZ2xlLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDI2LCAy
MDI2IDE6MzkgUE0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0K
PiBDYzogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+OyBwYm9uemluaUBy
ZWRoYXQuY29tOw0KPiB0Z2x4QGtlcm5lbC5vcmc7IG1pbmdvQHJlZGhhdC5jb207IGJwQGFsaWVu
OC5kZTsNCj4gZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyB4ODZAa2VybmVsLm9yZzsgaHBh
QHp5dG9yLmNvbTsNCj4gc2h1YWhAa2VybmVsLm9yZzsga3ZtQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtzZWxmdGVzdEB2Z2VyLmtlcm5l
bC5vcmc7IGN0cGVuY2VAZ29vZ2xlLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDMvNF0g
S1ZNOiB4ODY6IFZpcnR1YWxpemUgQU1EIENQVUlEIGZhdWx0aW5nDQo+DQo+IENhdXRpb246IFRo
aXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVy
IGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3Ig
cmVzcG9uZGluZy4NCj4NCj4NCj4gT24gVGh1LCBNYXkgMTQsIDIwMjYgYXQgMTE6MTfigK9BTSBL
YXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBU
aGlzIGFwcGVhcnMgdG8gYmUgYSBidWcsIGFzIG1vc3Qgb3RoZXIgaW5zdHJ1Y3Rpb25zIChlLmcu
IElOVlBDSUQpIHRoYXQgaGF2ZQ0KPiBDUEwgY2hlY2tzIGRvIHRoZSBDUEwgY2hlY2tzIGJlZm9y
ZSB0aGUgVk1FWElUIGNoZWNrcy4gIEknbSBmb2xsb3dpbmcgdXAgb24NCj4gdGhpcyBpbnRlcm5h
bGx5Li4uDQo+DQo+IERpZCB5b3UgbGVhcm4gYW55dGhpbmcgZnJvbSB0aGUgaW50ZXJuYWwgZm9s
bG93LXVwPyBUaGUgZWxsaXBzaXMNCj4gc3VnZ2VzdHMsICJzdGF5IHR1bmVkLi4uIiA6KQ0KDQpJ
dCBhcHBlYXJzIGl0IHdhcyBhIGRlbGliZXJhdGUgZGVjaXNpb24sIGR1ZSBpbiBwYXJ0IHRvIHRo
ZSBmYWN0IHRoYXQgdGhlIHRyYWRpdGlvbmFsIGZsb3cgb2YgY2hlY2tpbmcgQ1BMIGV4Y2VwdGlv
bnMgYmVmb3JlIGludGVyY2VwdHMgdHlwaWNhbGx5IGFwcGxpZXMgdG8gdXNpbmcgaW5zdHJ1Y3Rp
b25zIGluIGFuIGlsbGVnYWwgd2F5LCBidXQgdGhlIHVzZXIgaXMgbm90IGRvaW5nIGFueXRoaW5n
IGlsbGVnYWwgaGVyZSBieSBleGVjdXRpbmcgQ1BVSUQgd2hpY2ggaXMgbm9ybWFsbHkgYSBsZWdh
bCBpbnN0cnVjdGlvbiBhdCBDUEwzLg0KDQpUaGF0IHNhaWQsIGNsZWFybHkgdGhlIGJlaGF2aW9y
IGlzIGRpZmZlcmVudCBub3cgYmV0d2VlbiB0aGUgdmVuZG9ycywgaG93ZXZlciBhdCB0aGlzIHBv
aW50IHRoZSBmZWVkYmFjayBJIGdvdCBpcyB0aGF0IG91ciBhcmNoaXRlY3RzIHdhbnQgdG8gc3Rp
Y2sgd2l0aCB0aGUgZXhpc3RpbmcgYmVoYXZpb3IgdW5sZXNzIHRoZXJlIGlzIGEgc3Ryb25nIHJl
YXNvbiB0aGF0IGl0IGlzIGEgcHJvYmxlbSBmb3IgU1cuDQoNCi0tRGF2aWQgS2FwbGFuDQo=
